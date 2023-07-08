{ config, lib, ... }:

{
  # Enable auto upgrade with flakes.
  system.autoUpgrade = {
    enable = true;
    persistent = true;
    flake = "/etc/nixos#${config.networking.hostName}";
    flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    allowReboot = lib.mkDefault true;
    rebootWindow = {
      lower = "02:00";
      upper = "06:00";
    };
  };
}
