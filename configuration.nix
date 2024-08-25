# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure i3 to start automatically

  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
    };
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ch";
  #  variant = "";
  };

  # Configure console keymap
  console.keyMap = "sg";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    wireplumber.configPackages = [
	(pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/10-bluez.conf" ''
	      monitor.bluez.properties = {
		bluez5.enable-sbc-xq = true
		bluez5.enable-msbc = true
		bluez5.enable-hw-volume = true
		bluez5.headset-roles = [hsp_hs hsp_ag hfp_hf hfp_ag]
	      }
    '')
   ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.<user> = {
    isNormalUser = true;
    description = "<user>";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install steam
  programs.steam.enable = true;

  # Install bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable pulseaudio

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Text editor
   vscode
   git # Distributed version control system
   pkgs.discord # Discord
   pkgs.prismlauncher # Minecraft
   syncthing # Filesync 
   obsidian # Documentations
   i3
   i3lock-fancy-rapid # Lock screen
   polybar # Taskbar
   rofi # Search menu
   pulseaudio # Sound
#   blueman # Bluetooth
   findutils # locate and find command
   docker-compose
   flameshot # Screenshots
   alacritty # Terminal
  #  wget
  ];

 # Defines systemd user units
 systemd.user.services = {
	# Syncthing service
	syncthing = {
		description = "Starts Syncthing";
		wantedBy = [ "default.target" ];
		after = [ "default.target" ];

		serviceConfig = {
			Restart = "always";
			ExecStart = "${pkgs.syncthing}/bin/syncthing serve --no-browser --no-restart --logflags=0";
		};
	};
	
	mpris-proxy = {
		    description = "Mpris proxy";
		    after = [ "network.target" "sound.target" ];
		    wantedBy = [ "default.target" ];
		    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";	
	};
 };

  # Start docker
  virtualisation.docker.enable = true;
  # Rootless docker
  virtualisation.docker.rootless = {
   enable = true;
   setSocketVariable = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

