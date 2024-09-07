{ config, pkgs, ... }:

{
 home.username = "jamie";
 home.homeDirectory = "/home/jamie";

 home.packages = with pkgs; [
  neofetch
  nnn

  zip
  unzip
  xz

  jq
 ];

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}
