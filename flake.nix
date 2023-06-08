# This file is part of the nixos configuration.
# Resides in the /etc/nixos directory.

# To list system generations, run:
# $ nix-env --list-generations --profile /nix/var/nix/profiles/system

# To rollback to a specific generation, run:
# $ nix-env --switch-generation <version> --profile /nix/var/nix/profiles/system
# $ /nix/var/nix/profiles/system/bin/switch-to-configuration switch

{
  inputs = {
    nixpkgs.url = "github:usertam/nixpkgs/nixos-23.05-atlas";
  };

  outputs = { self, nixpkgs }: let
    specialArgs.lock = nixpkgs.lib.importJSON ./flake.lock;
  in {
    nixosConfigurations.atlas = nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      system = "aarch64-linux";
      modules = [
        ./programs/common.nix
        ./programs/doas.nix
        ./programs/nix.nix
        ./programs/zsh.nix
        ./services/autoupgrade.nix
        ./services/fail2ban.nix
        ./services/locate.nix
        ./services/openssh.nix
        ./services/rsyncd.nix
        ./services/minecraft.nix
        ./hosts/common.nix
        ./hosts/atlas.nix
      ];
    };
  };
}
