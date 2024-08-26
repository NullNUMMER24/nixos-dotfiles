  { pkgs, ... }:
  
  with import <nixpkgs> {};
  with builtins;
  with lib; 

  let

  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile vim/vimrc;
    settings = {
       relativenumber = true;
       number = true;
    };
    plugins = with pkgs.vimPlugins; [
      vim-elixir
      vim-mix-format
      idris-vim
      sensible
      vim-airline
      The_NERD_tree # file system explorer
      fugitive vim-gitgutter # git 
      rust-vim
      #YouCompleteMe
      vim-abolish
      command-t
      vim-go
    ];
  };
