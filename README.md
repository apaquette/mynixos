# mynixos

This repository contains my personal NixOS configuration, developed as part of my transition from Windows 11 to a fully declarative Linux environment. The project reflects my efforts to learn, apply, and maintain Nix, NixOS, and Home Manager in a modular and scalable way.

## Overview
The configuration is built on the following goals:
- Full declarative system management using NixOS, flakes, and Home Manager.
- Modularity and reusability, allowing components to be composted, extended, or overriden easily.
- Multi-host support, enabling different machines to share common modules while still having device-specific configuration.
- Practical, maintainable structure that supports long-term extensibility.

## Features
### Modular Architecture
The repository is organized around a module-based structure. System and user configurations are split into logical components such as settings, software, gaming, KDE Plasma, local AI, and flatpaks to name a few. This allows each host to selectively import only what it needs, maintaining clarity and avoiding duplications.

### Multi-Host Support
The project currently defines configurations for:
- nixos-desktop
- nixos-thinkpad

Both systems import from a shared library of modules containing common packages, shell environments, and other reusable definitions.

### Home Manager Integration
Home Manager is integrated directly through the flake, ensuring that system-level and user-level configuration remain consistent and reproducible. User environments, dotfiles, and program settings are fully declared in Nix code.

### Desktop Environment (KDE Plasma)
The desktop environment is configured with KDE Plasma 6:
- SDDM as display manager
- KWin effects for smooth animations
- Virtual desktops for workflow organization
- Custom panels and widgets
- Breeze Dark theme with custom fonts
- Konsole terminal configuration

### Flatpak Applications
Flatpak support is enabled with local bundle files for:
- Photocraft (ai.storyteller.photocraft)
- Filmcraft (ai.storyteller.filmcraft)

These applications are installed from local flatpak bundles rather than Flathub, ensuring offline availability and version control.

### Local AI Stack
Local AI inference is configured with:
- Ollama with AMD GPU Vulkan acceleration
- Open WebUI for general-purpose AI interface
- Model management with automatic sync and unload
- Web search integration (DuckDuckGo)
- Resource optimization for 6700 XT GPU

### Gaming & Emulation
Gaming support includes:
- Steam with Proton-GE compatibility layer
- Heroic launcher for Epic Games and GOG
- Prism Launcher for Minecraft
- Dolphin emulator (GameCube/Wii)
- Xenia (Xbox 360)
- RPCS3 (PS3)
- Steam ROM Manager

### Testing & Quality
A comprehensive test suite exists in the `tests/` directory with unit tests for:
- All modules (applications, base, desktop, packages, security)
- User-specific configurations
- Automated validation of configuration correctness

### Security & Certificates
Security features include:
- PKI certificate management for local development
- PAM configuration
- Local certificates stored in `certs/` directory

### Repository Structure
- `hosts/` contains device-specific system configurations.
- `modules/` contains shared modules that can be imported by hosts.
- `users/` contains Home Manager user configurations and modules.
- `flatpaks/` contains local flatpak bundle files.
- `certs/` contains certificates for local development.
- `tests/` contains unit tests for all modules.

## Learning Outcomes
Through this project, I developed hands-on experience with:
- Nix expression language and declarative system design
- Flakes, input pinning, and reproducible environments
- Home Manager for user-level configuration
- Modular configuration engineering
- Managing multi-host systems under a single repository
- KDE Plasma customization and desktop environment management
- Local AI stack deployment with GPU acceleration
- Flatpak application management with local bundles

This repository continues to evolve as I refine my setup, add new modules, and deepen my knowledge with Nix and NixOS.
