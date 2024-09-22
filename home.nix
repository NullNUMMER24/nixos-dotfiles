{ config, pkgs, ... }:

{

  # Import the i3 config
  imports = [
   /etc/nixos/i3.nix
   /etc/nixos/polybar.nix
   #/etc/nixos/bedag.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jamie";
  home.homeDirectory = "/home/jamie";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    kubectl # Tool for k8s operations
    kubectx # makes my life easier
    fzf
    kubernetes-helm # schützt den kopf 
    ranger # fileexplorer for terminal
    picom # transparency
    jq # json parsing
    feh # used to set wallpaper i3
    spotify # music
    playerctl # used for fancy taskbar with music stuff
    fira-code-nerdfont # install fancy fonts
    imagemagick # used to convert images (used in i3lock)
    talosctl # used to manage talos linux
    usbutils # lsusb
    yubikey-manager
    yubikey-personalization-gui
    sshpass
    oh-my-zsh # installs oh-my-zsh for zsh
    traceroute # tracks the route tacken by packets over an IP Network
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  
  # Enable zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -l";
      k = "kubectl";
      ns = "kubens";
    };
    
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "kubectl"
        "helm"
        "docker"
      ];
    };
  };


  # Set zsh as default shell
  #home.defaultUserShell = pkgs.zsh;


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jamie/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
   EDITOR = "vim";
   NIXPKGS_ALLOW_UNFREE = "1";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
