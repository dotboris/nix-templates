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
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.writeShellApplication {
        name = "alejandra-format-repo";
        runtimeInputs = [pkgs.alejandra];
        text = "alejandra .";
      };

      checks = {
        format = pkgs.writeShellApplication {
          name = "alejandra-check-repo";
          runtimeInputs = [pkgs.alejandra];
          text = "alejandra --check .";
        };
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
