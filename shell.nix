{ pkgs ? import <nixpkgs> { } }:
let
  vespa-cli = pkgs.callPackage ./default.nix { };
in
pkgs.mkShell {
  buildInputs = [ vespa-cli ];
}

