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
        # profile
        timezone = "America/Halifax";
        locale = "en_CA.UTF-8";

        hosts = builtins.filter (x: x != null) (
            lib.mapAttrsToList(name: value: if (value == "directory") then name else null)(
                builtins.readDir ./hosts
            )
        );

        # ----------- SYNCTHING ARGS ----------- #
        syncthingArgs = {
            desktop.id = "U5RZCCK-IFQB4GH-XR2FAOW-VW3ZGJK-3FEJHZL-B7Z3SP5-LNU2FVE-7T2ERQA";
            laptop.id = "ECCP6YE-XZZ4IE2-MXIXDGT-WLSGHKR-S3RM6PP-6JDWWW6-EXPDBTC-XFT4OQL";
        };


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
                        inherit syncthingArgs;
                    };
                };
            }) hosts
        );

        homeConfigurations = {
            ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ 
                    inputs.plasma-manager.homeModules.plasma-manager
                    ./users/${userSettings.username}/home.nix
                    ./users/${userSettings.username}/imports.nix
                ];
                extraSpecialArgs = {
                    inherit userSettings;
                };
            };
        };
    };
}
