{ keys, ... }:

{
  openssh.authorizedKeys.keyFiles = map (k: ../keys/${k}.pub) keys;
}
