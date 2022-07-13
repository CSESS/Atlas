{ lib, keys, ... }:

{
  isNormalUser = true;
  extraGroups = [ "wheel" ];
  uid = lib.mkDefault 1000;
  openssh.authorizedKeys.keyFiles = map (k: ../keys/${k}.pub) keys;
}
