{ config, pkgs, ... }:

{

  home.file = {
    # This is used to copy all of the polybar config
    ".config/polybar/config.ini".source = /etc/nixos/polybar/config.ini;
    ".config/polybar/launch.sh".source = /etc/nixos/polybar/launch.sh;
    ".config/polybar/discord.sh".source = /etc/nixos/polybar/discord.sh;
    ".config/polybar/mpd.sh".source = /etc/nixos/polybar/mpd.sh;
    ".config/polybar/spotify.sh".source = /etc/nixos/polybar/spotify.sh;
    ".config/polybar/GetWorkspace.sh".source = /etc/nixos/polybar/GetWorkspace.sh;
  };

}
