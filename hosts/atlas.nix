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

  # Backport: Mount tmpfs on /tmp during boot.
  boot.tmpOnTmpfs = true;

  # Disable mounting metadata disk.
  fileSystems."/metadata".device = lib.mkForce "/dev/null";

  # TCP connections will timeout after 4 minutes on Azure.
  boot.kernel.sysctl."net.ipv4.tcp_keepalive_time" = 120;
  boot.kernel.sysctl."net.ipv4.tcp_keepalive_intvl" = 30;
  boot.kernel.sysctl."net.ipv4.tcp_keepalive_probes" = 8;
}
