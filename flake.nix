{
    description = "Nix development shells";
    # Run `nix develop` for default and `nix develop .#<name>` for other shells

    inputs = {
        flake-utils.url = "github:numtide/flake-utils";
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        Cytnx = {
            url = "path:./Cytnx"; # Path to your project directory
            flake = true;
# To ensure consistency, it's good practice to make the project flake
# use the same nixpkgs as this shell flake.
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.flake-utils.follows = "flake-utils"; # If yourProjectFlake also uses flake-utils
        }; 
    }; 

    outputs = { self, nixpkgs, flake-utils, Cytnx, ... }:
        flake-utils.lib.eachDefaultSystem
        (system:
        let 
            pkgs = import nixpkgs { 
                inherit system; 
                # system = "x86_64-linux"; 
                config.allowUnfree = true; 
            }; 

        in  {
                devShells.default = import ./shell.nix { inherit pkgs Cytnx system; };
                devShells.cytnx = import ./shell.nix { inherit pkgs Cytnx system; };
            }
        );
}
