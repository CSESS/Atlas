{ config, ... }:

{
  # Enable auto upgrade with flakes.
  system.autoUpgrade = {
    enable = true;
    persistent = true;
    flake = "/etc/nixos#${config.networking.hostName}";
    flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    allowReboot = true;
    rebootWindow = {
      lower = "02:00";
      upper = "06:00";
    };
  };
}
