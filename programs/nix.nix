{ lib, pkgs, lock, ... }:

{
  nix = {
    # Use unstable version of nix.
    package = pkgs.nixVersions.unstable;

    # Lock nixpkgs in registry.
    registry.nixpkgs = {
      from = {
        type = "indirect";
        id = "nixpkgs";
      };
      to = {
        type = "github";
        owner = "nixos";
        repo = "nixpkgs";
        inherit (lock.nodes.nixpkgs.locked) rev;
      };
    };

    # Everyone loves experimental features!
    settings = {
      experimental-features = [
        "nix-command" "flakes"
        "auto-allocate-uids" "ca-derivations" "fetch-closure" "recursive-nix" "repl-flake"
      ] ++ lib.optional pkgs.stdenv.isLinux "cgroups";
      auto-allocate-uids = true;
    } // lib.optionalAttrs pkgs.stdenv.isLinux {
      use-cgroups = true;
    };
  };
}
