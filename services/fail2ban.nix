{ config, lib, ... }:

{
  services.fail2ban = {
    enable = true;
    maxretry = 1;
    bantime-increment.enable = true;
    jails.sshd.settings.mode = "aggressive";
  };
}
