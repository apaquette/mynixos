{
    description = "Flake of Alex Paquette";

    inputs = { 
        nixpkgs.url = "nixpkgs/nixos-25.11";
        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nix-flatpak.url = "github:gmodena/nix-flatpak";

        plasma-manager.url = "github:nix-community/plasma-manager";
        plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
        plasma-manager.inputs.home-manager.follows = "home-manager";
    };

    outputs = inputs@{self, nixpkgs, home-manager, plasma-manager, ...}:
    let
        lib = nixpkgs.lib;

        system = "x86_64-linux";
        timezone = "America/Halifax";
        locale = "en_CA.UTF-8";

        userRegistry = {
            apaquette = {
                name = "Alex Paquette";
                email = "alexandre.d.paquette@gmail.com";
                dotfilesDir = "~/.dotfiles";
            };
        };

        hostUsers = {
            nixos-desktop = "apaquette";
            nixos-thinkpad = "apaquette";
        };

        userSettingsFor = username:
            userRegistry.${username} // { inherit username; };
        
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        nixosConfigurations = lib.mapAttrs
        (host: username:
            lib.nixosSystem {
            inherit system;

            modules = [
                ./hosts/${host}/configuration.nix
                ./hosts/${host}/imports.nix
                ./users/${username}/nixos.nix
            ];

            specialArgs = {
                inherit host timezone locale;
                userSettings = userSettingsFor username;
            };
            })
        hostUsers;

        homeConfigurations = lib.mapAttrs
        (username: settings:
            home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
                inputs.nix-flatpak.homeManagerModules.nix-flatpak
                inputs.plasma-manager.homeModules.plasma-manager
                ./users/${username}/home.nix
                ./users/${username}/imports.nix
            ];

            extraSpecialArgs = {
                userSettings = settings // { inherit username; };
            };
            })
        userRegistry;

        checks.${system} = import ./tests/checks.nix {
            inherit pkgs;
            nixosConfigurations = self.nixosConfigurations;
            homeConfigurations = self.homeConfigurations;
        };
    };
}
