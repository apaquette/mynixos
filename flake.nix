{
    inputs = { 
        nixpkgs.url = "nixpkgs/nixos-25.05";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {self, nixpkgs, home-manager, ...}: 
    let
        # ----------- SYSTEM  SETTINGS ----------- #
        system = "x86_64-linux";
        hostname = "nixos";
        # profile
        timezone = "America/Halifax";
        locale = "en_CA.UTF-8";


        # ----------- USER SETTINGS ----------- #
        username = "apaquette";
        name = "Alex Paquette";
        email = "alexandre.d.paquette@gmail.com";
        dotfilesDir = "~/.dotfiles";
        # theme
        # windowManager
        # windowManagerType
        # browser
        # editor

        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                inherit system;
                modules = [
                    ./configuration.nix
                    ./gaming.nix
                    ./software.nix
                ];
                specialArgs = {
                    inherit username;
                    inherit name;
                    inherit hostname;
                    inherit timezone;
                    inherit locale;
                };
            };
        };
        homeConfigurations = {
            apaquette = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./user/home.nix ];
                extraSpecialArgs = {
                    inherit username;
                    inherit name;
                    inherit hostname;
                    inherit email;
                    inherit dotfilesDir;
                };
            };
        };
    };
}
