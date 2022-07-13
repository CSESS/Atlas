{ pkgs, ... }:

{
  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    localuser = null; # unsupported; need to run as root
  };
}
