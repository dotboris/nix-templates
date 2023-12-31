{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    {
      templates = rec {
        simple-flake = {
          path = ./simple-flake;
          description = "Simple nix flake with minimal boilerplate.";
        };

        nodejs = {
          path = ./nodejs;
          description = "Minimal NodeJS dev shell with package manager provided by corepack.";
        };

        default = simple-flake;
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    });
}
