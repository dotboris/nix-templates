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
      overlays = [
        (final: prev: {
          nodejs = prev.nodejs_20;
        })
      ];
      pkgs = import nixpkgs {inherit system overlays;};
    in {
      formatter = pkgs.alejandra;

      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.nodejs

          # Provides packages managers (pnpm / yarn based on `package.json`)
          pkgs.corepack
        ];
      };
    });
}
