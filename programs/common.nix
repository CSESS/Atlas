{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    home-manager
    git
    htop
    kitty.terminfo
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    efibootmgr
    lm_sensors
  ];
}
