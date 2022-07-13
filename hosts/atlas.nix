{ lib, modulesPath, ... }:

{
  imports = [ "${modulesPath}/virtualisation/azure-image.nix" ];

  networking.hostName = "atlas";

  users.users.tam = import ../common/users/tam.nix {
    inherit lib;
    keys = [ "blizzard" "nova" "redfin" ];
  };

  users.users.root = import ../common/users/root.nix {
    inherit lib;
    keys = [ "blizzard" "nova" "redfin" ];
  };
}
