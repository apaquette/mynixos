{
    description = "Flake of Alex Paquette";

    inputs = { 
        nixpkgs.url = "nixpkgs/nixos-25.11";
        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        plasma-manager.url = "github:nix-community/plasma-manager";
        plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
        plasma-manager.inputs.home-manager.follows = "home-manager";
    };

    outputs = inputs@{nixpkgs, home-manager, plasma-manager, ...}: 
    let
        # ----------- SYSTEM  SETTINGS ----------- #
        system = "x86_64-linux";
        host = "thinkpad";
        hostname = "nixos-${host}";
        # profile
        timezone = "America/Halifax";
        locale = "en_CA.UTF-8";


        # ----------- USER SETTINGS ----------- #
        userSettings = {
            username = "apaquette";
            name = "Alex Paquette";
            email = "alexandre.d.paquette@gmail.com";
            dotfilesDir = "~/.dotfiles";
        };
        # theme
        # windowManager
        # windowManagerType
        # browser
        # editor

        lib = nixpkgs.lib;
        
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
            ${hostname} = lib.nixosSystem {
                inherit system;
                modules = [
                    ./hosts/${host}/configuration.nix
                    ./hosts/${host}/imports.nix
                ];

                specialArgs = {
                    inherit userSettings;
                    inherit hostname;
                    inherit timezone;
                    inherit locale;
                };
            };
        };
        homeConfigurations = {
            ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ 
                    inputs.plasma-manager.homeModules.plasma-manager
                    ./user/${userSettings.username}/home.nix
                ];
                extraSpecialArgs = {
                    inherit userSettings;
                    inherit hostname;
                };
            };
        };
    };
}
