{ config, lib, ... }:

{
  services.fail2ban = {
    enable = true;
    maxretry = 1;
    bantime-increment.enable = true;
    jails.sshd = ''
      enabled = true
      port    = ${lib.concatMapStringsSep "," (p: toString p) config.services.openssh.ports}
      mode    = aggressive
    '';
  };
}
