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
      formatter = pkgs.writeShellApplication {
        name = "alejandra-format-repo";
        runtimeInputs = [pkgs.alejandra];
        text = "alejandra .";
      };

      checks = {
        format = pkgs.runCommand "alejandra-check-repo" {} ''
          ${pkgs.alejandra}/bin/alejandra --check ${./.}
          touch $out
        '';
      };

      devShells.default = pkgs.mkShell {
        packages = [
          # nix & flake
          pkgs.nil
          pkgs.alejandra
        ];
      };
    });
}
