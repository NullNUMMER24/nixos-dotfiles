{ config, pkgs, ... }:

{

  home.file = {
    # This is used to copy all of the i3 config
    ".config/i3/config".source = /etc/nixos/i3/config;
    ".config/i3/i3lock.sh".source = /etc/nixos/i3/i3lock.sh;
    ".config/dunst/dunstrc".source = /etc/nixos/i3/dunstrc; # copy dunstrc (notifications)

  };

}
