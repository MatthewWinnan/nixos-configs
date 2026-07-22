#!/usr/bin/env bash
# Nix vulnerability scan using sbomnix/vulnxscan.
# Generates SBOM from the current host's NixOS closure and scans with
# Grype + OSV (version-range aware).
#
# Usage:
#   just nix-audit              # scans current hostname
#   just nix-audit fafn1r       # scans specific host
set -uo pipefail

HOSTNAME="${1:-$(hostname)}"

echo "═══════════════════════════════════════════════════════"
echo "  Nix Vulnerability Audit — $HOSTNAME"
echo "  (sbomnix/vulnxscan — version-range aware)"
echo "  $(date -Iseconds)"
echo "═══════════════════════════════════════════════════════"
echo ""

# Ensure TLS works for OSV/Grype DB fetches
export SSL_CERT_FILE="${SSL_CERT_FILE:-/etc/ssl/certs/ca-certificates.crt}"
export REQUESTS_CA_BUNDLE="${REQUESTS_CA_BUNDLE:-/etc/ssl/certs/ca-certificates.crt}"
export NIX_SSL_CERT_FILE="${NIX_SSL_CERT_FILE:-$SSL_CERT_FILE}"

# Verify the NixOS configuration exists
TARGET=".#nixosConfigurations.${HOSTNAME}.config.system.build.toplevel"
if ! nix eval ".#nixosConfigurations.${HOSTNAME}" --apply 'x: true' > /dev/null 2>&1; then
  echo "  ⚠  No nixosConfiguration found for '$HOSTNAME'"
  echo "     Available:"
  nix eval .#nixosConfigurations --apply 'x: builtins.attrNames x' 2>/dev/null | tr ',' '\n' | sed 's/[" \[\]]//g' | sed 's/^/       /'
  exit 1
fi

# Output setup
REPORT_DIR="logs/audit"
mkdir -p "$REPORT_DIR"
TIMESTAMP=$(date +%s)
REPORT_PREFIX="${REPORT_DIR}/${TIMESTAMP}_${HOSTNAME}"

echo "── Generating SBOM for $HOSTNAME system closure ──"
echo ""

SBOM_FILE="${REPORT_PREFIX}_sbom.cdx.json"
sbomnix "$TARGET" --cdx "$SBOM_FILE" 2>&1 | grep "^INFO" | sed 's/^/  /'
rm -f sbom.spdx.json sbom.csv  # cleanup CWD leftovers

if [ ! -f "$SBOM_FILE" ]; then
  echo "  ⚠  SBOM generation failed"
  exit 1
fi

pkg_count=$(python3 -c "
import json
with open('$SBOM_FILE') as f:
    data = json.load(f)
print(len(data.get('components', [])))
" 2>/dev/null || echo "?")
echo ""
echo "  ✓ SBOM: $SBOM_FILE ($pkg_count components)"

echo ""
echo "── Scanning for vulnerabilities ──"
echo ""

SCAN_OUT="${REPORT_PREFIX}_vulns.csv"
SCAN_LOG="${REPORT_PREFIX}_scan.log"

WHITELIST_FLAG=""
if [ -f "data/audit/whitelist.csv" ]; then
  WHITELIST_FLAG="--whitelist data/audit/whitelist.csv"
  echo "  Using whitelist: data/audit/whitelist.csv"
fi

# shellcheck disable=SC2086
vulnxscan --sbom "$SBOM_FILE" --out "$SCAN_OUT" $WHITELIST_FLAG \
  > "$SCAN_LOG" 2>&1 || true

# Show errors if any
if grep -qE "ERROR|SSLError|exception" "$SCAN_LOG" 2>/dev/null; then
  echo "  ⚠  Scanner error (see $SCAN_LOG)"
  grep -m3 "ERROR\|SSLError" "$SCAN_LOG" | sed 's/^/    /'
fi

if [ -f "$SCAN_OUT" ]; then
  vuln_count=$(tail -n +2 "$SCAN_OUT" | wc -l)
  echo ""
  echo "  Vulnerabilities found: $vuln_count (version-range verified)"

  if [ "$vuln_count" -gt 0 ]; then
    echo ""
    echo "  Top affected packages:"
    tail -n +2 "$SCAN_OUT" | cut -d',' -f3 | sed 's/"//g' | sort | uniq -c | sort -rn | head -10 | sed 's/^/    /'
  fi
else
  vuln_count=0
  echo "  ⚠  No scan output produced"
fi

echo ""
echo "── Summary ──"
echo ""
echo "  Host:       $HOSTNAME"
echo "  Components: $pkg_count"
echo "  Findings:   $vuln_count"
echo "  SBOM:       $SBOM_FILE"
echo "  Vulns CSV:  $SCAN_OUT"
echo "  Scan log:   $SCAN_LOG"

if [ "$vuln_count" -gt 0 ]; then
  echo ""
  echo "  ⚠  Review CSV. These are version-range verified."
  echo "     Fix: nix flake update + nixos-rebuild switch"
else
  echo ""
  echo "  ✅ No known vulnerabilities detected"
fi

echo ""
echo "── Flake lock age ──"
echo ""
if [ -f "flake.lock" ]; then
  lock_date=$(stat -c %Y flake.lock)
  now=$(date +%s)
  age_days=$(( (now - lock_date) / 86400 ))
  echo "  flake.lock last modified: $(date -d "@$lock_date" -Idate) ($age_days days ago)"
  if [ "$age_days" -gt 30 ]; then
    echo "  ⚠  flake.lock is >30 days old — consider: nix flake update"
  else
    echo "  ✅ flake.lock is current (<30 days)"
  fi
fi

echo ""
echo "═══════════════════════════════════════════════════════"
echo "  Audit complete — $HOSTNAME"
echo "═══════════════════════════════════════════════════════"
exit 0
