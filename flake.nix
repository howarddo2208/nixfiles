{
    description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {nixpkgs, home-manager, ...}: {
        packages.x86_64-linux.default = home-manager.defaultPackage.x86_64-linux;
        packages.x86_64-darwin.default = home-manager.defaultPackage.x86_64-darwin;

        homeConfigurations = {
            "macos" = home-manager.lib.homeManagerConfiguration {
                # Note: I am sure this could be done better with flake-utils or something
                pkgs = nixpkgs.legacyPackages.x86_64-darwin;

                modules = [ ./home.nix ];
            };
            "linux" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;

                modules = [ ./home-linux.nix ];
	    };
        };
    };
}
