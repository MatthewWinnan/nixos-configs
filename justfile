# NixOS Configuration Task Runner

# Default: list available recipes
default:
    @just --list

# Format all files with treefmt
fmt:
    nix fmt

# Check formatting without modifying files
fmt-check:
    nix flake check

# Run statix linter on the codebase
lint:
    statix check .

# Fix statix warnings automatically
lint-fix:
    statix fix .

# Run deadnix to find unused code
deadnix:
    deadnix --no-lambda-pattern-names .

# Fix deadnix findings automatically
deadnix-fix:
    deadnix --no-lambda-pattern-names --edit .

# Run all checks (format check + lint + deadnix)
check: fmt-check lint deadnix

# Run all fixes (format + lint fix + deadnix fix)
fix: fmt lint-fix deadnix-fix

# Build a specific machine configuration
build hostname:
    nh os build --hostname {{hostname}}

# Switch to a specific machine configuration
switch hostname:
    nh os switch --hostname {{hostname}}

# Update flake inputs
update:
    nix flake update

# Show flake info
info:
    nix flake show

# Set up git hooks (run after fresh clone)
setup:
    git config core.hooksPath .githooks

# Run vulnix vulnerability scan on a machine's closure (runtime deps only)
vuln hostname=`hostname`:
    #!/usr/bin/env bash
    set -uo pipefail
    export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
    export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
    store_path=$(nix build .#nixosConfigurations.{{hostname}}.config.system.build.toplevel --no-link --print-out-paths)
    outfile="vulnix-{{hostname}}-$(date +%Y-%m-%d).txt"
    echo "Scanning {{hostname}} runtime closure: $store_path" | tee "$outfile"
    echo "Date: $(date -Iseconds)" | tee -a "$outfile"
    echo "Whitelist: vulnix-whitelist.toml" | tee -a "$outfile"
    echo "------------------------------------------------------------------------" | tee -a "$outfile"
    nix run nixpkgs#vulnix -- --closure --whitelist vulnix-whitelist.toml "$store_path" 2>&1 | tee -a "$outfile" || true
    echo ""
    echo "Results written to $outfile"
