# We minimize the surface area of the ad-hoc nixpkgs currently in scope before
# locking down to a fixed, known version specified in version.nix
{ bootFetchgit ? (import <nixpkgs> {}).fetchgit
# We can pass in the string identifier of the Haskell compiler name/ref to use.
# We could pass in "ghcHaLVM240" instead to use HaLVM 2.4.0 :)
# Even on the command-line, like: nix-shell --argstr compiler ghcHaLVM240
, compiler ? "ghc802"
}:
let
  # We lock down the version of nixpkgs via the attributes in version.nix
  pkgs = import (bootFetchgit (import ./nixpkgs.nix)) {};
  # We get the Haskell package set to use to build our Nix expression
  # which represents the cabal definition which was generated via 'cabal2nix'
  hsPackages = pkgs.haskell.packages."${compiler}";
in
  # using the Nix Haskell package set and related lambdas we build our
  # Haskell package for our project
  hsPackages.callPackage ./servant-intro.nix {}
