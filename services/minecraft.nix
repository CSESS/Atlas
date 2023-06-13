{ config, lib, pkgs, mcpkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfreePredicate = pkg: true;

  # Preference: Override listening socket.
  systemd.sockets.minecraft-server.socketConfig.ListenFIFO = lib.mkForce
    "${config.services.minecraft-server.dataDir}/stdin";

  services.minecraft-server = let
    variant = "Fabric";
    version = "1.20";
  in {
    enable = true;
    eula = true;
    package = with lib.strings;
      mcpkgs.${toLower variant + "Servers"}
            .${toLower variant + "-" + replaceStrings ["."] ["_"] version};
    declarative = true;
    serverProperties = {
      motd = "Saccharine of childhood. ${variant} ${version}.";
      enable-command-block = true;
      max-players = 3000;
      enable-rcon = true;
      "rcon.password" = "cookiesloveu";
    };
    serverIcon = ../assets/server-icon.png;
    openFirewall = true;
  };
}
