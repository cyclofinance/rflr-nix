{
  description = "Rainix is a flake for Rain.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    foundry.url = "github:shazow/foundry.nix";
  };

  outputs = { self, nixpkgs, flake-utils, foundry }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays =[ foundry.overlay ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        pkgs = pkgs;
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.yarn pkgs.foundry-bin pkgs.git pkgs.nodejs ];
        };
      });
}