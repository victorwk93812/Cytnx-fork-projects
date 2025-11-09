{
    description = "C/C++ nix shell";
# May run nix develop under any subdirectory of this

    inputs = {
        flake-utils.url = "github:numtide/flake-utils";
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    }; 

    outputs = { self, nixpkgs, flake-utils, ... }:
        flake-utils.lib.eachDefaultSystem
        (system:
        let pkgs = import nixpkgs { 
            system = "x86_64-linux"; 
            config.allowUnfree = true; 
            }; 
        in  {
                devShells.default = import ./shell.nix { inherit pkgs; };
            }
        );
}
