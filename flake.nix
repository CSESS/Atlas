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
    mcpkgs.url = "github:Infinidoge/nix-minecraft";
    mcpkgs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, mcpkgs }: {
    nixosConfigurations.atlas = nixpkgs.lib.nixosSystem rec {
      specialArgs.lock = nixpkgs.lib.importJSON ./flake.lock;
      specialArgs.mcpkgs = mcpkgs.legacyPackages.${system};
      system = "x86_64-linux";
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
