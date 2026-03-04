# Nix Configuration

This repository manages system and user configuration for macOS machines using [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Overview

- **nix-darwin**: Manages system-level configuration (system packages, macOS preferences, Homebrew casks)
- **home-manager** (standalone): Manages user-level configuration (dotfiles, user packages, shell config)

This setup uses **Nix flakes** for reproducibility and **standalone home-manager** for flexibility (user config can be rebuilt independently of system config).

## Repository Structure

```
.
├── flake.nix                 # Flake entry point
├── flake.lock                # Locked dependencies
├── hosts/
│   └── zachs-macbook-pro/    # Personal laptop (darwin config)
│       └── default.nix
├── home/
│   └── zachbrown/            # Personal user (home-manager config)
│       └── default.nix
├── modules/
│   ├── darwin/               # System-level modules (nix-darwin)
│   │   ├── homebrew.nix
│   │   └── system-preferences.nix
│   └── home-manager/         # User-level modules (cross-platform)
│       ├── fish.nix
│       └── git.nix
└── README.md
```

## Machines

| Hostname | Type | Architecture | Username | Purpose |
|----------|------|--------------|----------|---------|
| Zachs-MacBook-Pro | MacBook | Apple M3 (aarch64-darwin) | zachbrown | Personal |

## Conventions

- **File naming**: Use kebab-case for all files (e.g., `system-preferences.nix`, `user-packages.nix`)
- **Module organization**:
  - `modules/darwin/` — System-level modules (nix-darwin only)
  - `modules/home-manager/` — User-level modules (portable across platforms)
- **Host configs**: Each machine has its own folder under `hosts/`
- **User configs**: Each user has their own folder under `home/`

## Prerequisites

1. **Nix** must be installed with flakes enabled:
   ```bash
   # Check if nix is installed
   nix --version

   # Ensure flakes are enabled (add to ~/.config/nix/nix.conf if missing)
   experimental-features = nix-command flakes
   ```

2. **nix-darwin** must be bootstrapped (first-time only):
   ```bash
   # Install nix-darwin
   nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
   ./result/bin/darwin-installer
   ```

3. **home-manager** CLI must be available:
   ```bash
   # Add home-manager channel (or it will be available via the flake)
   nix run home-manager/master -- --version
   ```

## Usage

### Rebuild System Configuration (nix-darwin)

```bash
darwin-rebuild switch --flake .#Zachs-MacBook-Pro
```

### Rebuild User Configuration (home-manager)

```bash
home-manager switch --flake .#zachbrown
```

### Update Flake Inputs

```bash
# Update all inputs
nix flake update

# Update a specific input
nix flake lock --update-input nixpkgs
```

## Adding a New Machine

1. Create a new folder under `hosts/` with the hostname in kebab-case:
   ```
   hosts/
   └── new-machine-hostname/
       └── default.nix
   ```

2. Add the darwin configuration in `default.nix`

3. Add a new `darwinConfigurations` entry in `flake.nix`

## Adding a New User

1. Create a new folder under `home/` with the username:
   ```
   home/
   └── newusername/
       └── default.nix
   ```

2. Add the home-manager configuration in `default.nix`

3. Add a new `homeConfigurations` entry in `flake.nix`

## Adding a New Module

### Darwin Module (system-level)

1. Create `modules/darwin/your-module.nix`
2. Import it in the relevant host config(s) under `hosts/`

### Home-Manager Module (user-level)

1. Create `modules/home-manager/your-module.nix`
2. Import it in the relevant user config(s) under `home/`

## Troubleshooting

### "experimental-features" error
Ensure flakes are enabled in `~/.config/nix/nix.conf`:
```
experimental-features = nix-command flakes
```

### darwin-rebuild command not found
Run the nix-darwin installer or use:
```bash
nix run nix-darwin -- switch --flake .#HOSTNAME
```

### home-manager command not found
Use the flake directly:
```bash
nix run home-manager/master -- switch --flake .#USERNAME
```
