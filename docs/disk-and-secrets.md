# Disk, Secrets & Bootstrap

## Bootstrap: Installing on a New Machine

### Prerequisites

- A NixOS live USB (minimal ISO is fine)
- The target disk's device ID (e.g. `/dev/disk/by-id/ata-Samsung_SSD_870_EVO_250GB_...`)
- Network access for fetching the flake

### Step 1: Boot the Installer

Boot from the NixOS live USB. Enable flakes in the live environment:

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

### Step 2: Partition with Disko

Each machine has a disko config in `disko/<hostname>.nix` that declaratively defines the full disk layout. Before running, update the `device` path in the disko file to match your target disk:

```bash
# Find your disk ID
ls /dev/disk/by-id/

# Run disko to partition, encrypt, format, and mount
sudo nix run github:nix-community/disko -- --mode disko ./disko/<hostname>.nix
```

This will:
1. Create a 1GB EFI System Partition (vfat, mounted at `/boot`)
2. Create a swap partition (with hibernate resume support)
3. Create a LUKS2-encrypted partition (prompts for passphrase)
   - Cipher: `aes-xts-plain64`, hash: `sha512`, KDF: `argon2id`
4. Format the LUKS volume as BTRFS with subvolumes:

```
BTRFS Volume
├── root      → /
├── home      → /home
├── nix       → /nix
├── persist   → /persist
├── snapshots → /snapshots
├── log       → /var/log
└── tmp       → /tmp
```

All subvolumes use `compress=zstd` and `noatime` mount options.

> **Note:** Partition start/end values are hard-coded as sector numbers because Disko doesn't evaluate percentage values correctly. Ensure the disk is at least 10GB.

### Step 3: Install NixOS

```bash
# Clone the repo into the mounted filesystem
sudo git clone <repo-url> /mnt/home/<username>/NIX_REPO

# Generate hardware config (or use the existing one from the repo)
sudo nixos-generate-config --root /mnt --no-filesystems

# Install
sudo nixos-install --flake /mnt/home/<username>/NIX_REPO#<hostname>
```

### Step 4: Post-Install

```bash
# Set user password (nixos-install doesn't create user passwords)
sudo nixos-enter --root /mnt -c 'passwd <username>'

# Reboot
reboot
```

After first boot:
- Update monitor IDs in `machines/<hostname>/settings/config.nix` to match actual hardware
- Sign into browsers (Firefox, Chromium)
- Set up GitHub SSH/GPG keys
- Install Steam games if on a gaming profile

### Adding a New Machine

1. Create `machines/<hostname>/` with `default.nix`, `settings/config.nix`, `nix/`, and optionally `home/`
2. Fill in `settings/config.nix` with device/system/user settings
3. Generate `nix/hardware-configuration.nix` on the target hardware
4. Create a disko config in `disko/<hostname>.nix` (copy an existing one, update disk device path and sector values)
5. Add the machine entry to `machines/default.nix` with the appropriate modules
6. Optionally add an image store entry in `image_store/<hostname>.nix`

---

## Disko Partition Scheme

Configurations are in `disko/` and are managed with [Disko](https://github.com/nix-community/disko).

### Machines with Disko Configs

| Machine | Disko File | Disk Device |
|---------|-----------|-------------|
| ba1dr | `disko/ba1dr.nix` | Samsung SSD 870 EVO 250GB |
| h31mda11 | `disko/h31mda11.nix` | — |
| od1n | `disko/od1n.nix` | — |
| m1m1r | `disko/m1m1r.nix` | — |

Machines without disko configs (fr3yr, th0r, fafn1r, nixos) are either partitioned manually or use alternative boot methods (e.g. Raspberry Pi extlinux, WSL).

---

## Secrets Management

[SOPS-nix](https://github.com/Mic92/sops-nix) encrypts secrets at rest in the repo and decrypts them at system activation time.

### How It Works

1. Secrets are stored as age-encrypted YAML in `secrets/<hostname>.yaml`
2. `.sops.yaml` at the repo root defines which age keys can decrypt which files
3. Each machine's `nix/sops.nix` maps secret paths to files on the system
4. On activation, sops-nix decrypts using the machine's SSH host key (converted to age)

### Key Management

```bash
# Generate an age key
age-keygen -o ~/.config/sops/age/keys.txt

# Convert a machine's SSH host key to age
ssh-keyscan <hostname> | ssh-to-age

# Edit encrypted secrets
sops secrets/<hostname>.yaml
```

### Current Secrets

| Machine | Secrets File | Decryption Keys | Contents |
|---------|-------------|-----------------|----------|
| fr3yr | `secrets/fr3yr.yaml` | Admin age key + fr3yr host key | Home Assistant secrets (lat/long/elevation), iwd WiFi credentials |
| h31mda11 | — | SOPS module enabled | — |

### `.sops.yaml` Structure

```yaml
keys:
  - &admin age1...    # Your personal age key
  - &fr3yr age1...    # Machine host key (from ssh-to-age)

creation_rules:
  - path_regex: secrets/fr3yr\.yaml$
    key_groups:
      - age: [*admin, *fr3yr]
  - path_regex: secrets/[^/]+\.yaml$
    key_groups:
      - age: [*admin]
```
