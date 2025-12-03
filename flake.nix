{
    description = "Flake of Alex Paquette";

    inputs = { 
        nixpkgs.url = "nixpkgs/nixos-25.05";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {self, nixpkgs, home-manager, ...}: 
    let
        # ----------- SYSTEM  SETTINGS ----------- #
        system = "x86_64-linux";
        host = "desktop";
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
                    ./modules/gaming.nix
                    ./modules/software.nix
                    ./modules/kdePlasma.nix
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
