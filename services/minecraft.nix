{ pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfreePredicate = pkg: true;

  services.minecraft-server = rec {
    enable = true;
    eula = true;
    package = pkgs.minecraftServers.vanilla;
    declarative = true;
    serverProperties = {
      motd = "Saccharine of childhood. Vanilla ${package.version}";
      enable-command-block = true;
      max-players = 3000;
      enable-rcon = true;
      "rcon.password" = "cookiesloveu";
    };
    serverIcon = ../assets/server-icon.png;
    openFirewall = true;
  };
}
