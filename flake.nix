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
        # ----------- SYSTEM  SETTINGS ----------- #
        system = "x86_64-linux";
        # profile
        timezone = "America/Halifax";
        locale = "en_CA.UTF-8";

        hosts = builtins.filter (x: x != null) (
            lib.mapAttrsToList(name: value: if (value == "directory") then name else null)(
                builtins.readDir ./hosts
            )
        );

        # ----------- USER SETTINGS ----------- #
        userSettings = {
            username = "apaquette";
            name = "Alex Paquette";
            email = "alexandre.d.paquette@gmail.com";
            dotfilesDir = "~/.dotfiles";
        };

        lib = nixpkgs.lib;
        
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        nixosConfigurations = builtins.listToAttrs (
            map (host: {
                name = host;
                value = lib.nixosSystem {
                    inherit system;
                    modules = [
                        ./hosts/${host}/configuration.nix
                        ./hosts/${host}/imports.nix
                    ];

                    specialArgs = {
                        inherit userSettings;
                        inherit host;
                        inherit timezone;
                        inherit locale;
                    };
                };
            }) hosts
        );

        homeConfigurations = {
            ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ 
                    inputs.nix-flatpak.homeManagerModules.nix-flatpak
                    inputs.plasma-manager.homeModules.plasma-manager
                    ./users/${userSettings.username}/home.nix
                    ./users/${userSettings.username}/imports.nix
                ];
                extraSpecialArgs = {
                    inherit userSettings;
                };
            };
        };
        checks.${system} = import ./tests/checks.nix {
            inherit pkgs;
            nixosConfigurations = self.nixosConfigurations;
            homeConfigurations = self.homeConfigurations;
        };
    };
}
