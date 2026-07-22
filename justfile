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

# Nix vulnerability scan (sbomnix/vulnxscan — version-range aware)
# Scans the current host's NixOS closure. Override hostname: just nix-audit fafn1r
nix-audit hostname=`hostname`:
    SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt nix shell github:tiiuae/sbomnix --command bash scripts/nix_audit.sh {{hostname}}
