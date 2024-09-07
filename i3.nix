{ config, pkgs, ... }:

{

  home.file = {
    # This is used to copy all of the i3 config
    ".config/i3/config".source = /etc/nixos/i3/config;

  };

}
