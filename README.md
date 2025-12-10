# mynixos

This repository contains my personal NixOS configuration, developed as part of my transition from Windows 11 to a fully declarative Linux environment. The project reflects my efforts to learn, apply, and maintain Nix, NixOS, and Home Manager in a modular and scalable way.

## Overview
The configuration is built on the following goals:
- Full declarative system management using NixOS, flakes, and Home Manager.
- Modularity and reusability, allowing components to be composted, extended, or overriden easily.
- Multi-host support, enabling different machines to share common modules while still having device-specific configuration.
- Practical, maintainable structure that supports long-term extensibility and version control.

## Features
### Modular Architecture
The repsitory is organized around a module-based structure. System and user configurations are split into logical components such as settings, software, and gaming to name a few. This allows each host to selectively import only what it needs, maintaining clarity and avoiding duplications.

### Multi-Host SUpport
The project currently defines configurations for:
- nixos-desktop
- nixos-thinkpad

Both systems import from a shared library of modules containing common packages, shell environments, and other reusable definitions.

### Home Manager Integration
Home Manager is integrated directly through the flake, ensuring that system-level and user-level configuration remain consistent and reproducible. User environments, dotfiles, and program settings are fully declared in Nix code.

### Repository Structure
- hosts/ contains device-specific system configurations.
- modules/ contains shared modules that can be imported by hosts.
- users/ contains Home Manager user configurations and modules.
- flake.nix declares inputs, outputs, and host definitions.

## Learning Outcomes
Through this project, I developed hands-on experience with:
- Nix expression language and declarative system design
- Flakes, input pinning, and reproducible environemnts
- Home Manager for user-level configuration
- Modular configuration engineering
- Managing multi-host systems under a single repository
- Versioning and maintainability best practices for NixOS deployments

This repository continues to evolve as I refine my setup, add new modules, and deepen my knowledge with Nix and NixOS.
