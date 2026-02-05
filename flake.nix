{
  description = "Erlang development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell.override {
          stdenv = pkgs.llvmPackages_16.stdenv;
	} {
          buildInputs = with pkgs; [
            erlang
            rebar3
            openssl
            unixODBC
            glibcLocales
          ];

          shellHook = ''
            export ERL_AFLAGS="-kernel shell_history enabled"
          '';
        };
      });
}
