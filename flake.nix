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
    rec {
      templates = {
        simple-flake = {
          path = ./simple-flake;
          description = "Simple nix flake with minimal boilerplate.";
        };
      };

      defaultTemplate = templates.simple-flake;
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    });
}
