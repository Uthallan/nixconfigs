# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  # Builds packages for manufactured FHS environment. Included below with other normal system level packages
  fhsEnv = pkgs.buildFHSEnv {
    name = "fhs-env";
    targetPkgs = pkgs: [
      
      # libs
      pkgs.gcc
      pkgs.libgcc
      pkgs.glibc
      pkgs.icu # Unicode and globalization support library

      pkgs.python312Full
    ];
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./systemModules/default.nix
    ];

#######################################
# BOOT AND INIT                       
#######################################


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = false;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.systemd-boot.enable = true;

fileSystems."/usr/data1" = {
    device = "/dev/disk/by-uuid/02f908dd-5774-406b-9755-d35893148387";
    fsType = "ext4";
    autoFormat = true;
    mountPoint = "/usr/data1";


    # See FILESYSTEM-INDEPENDENT MOUNT OPTIONS at:
    # https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
    # (I think its just man pages basically)
    options = [ 
        "nosuid"
        "nodev"
        "nofail"
        "x-gvfs-show"
    ];

  };

 fileSystems."/usr/data2" = {
    device = "/dev/disk/by-uuid/8a5a647e-3634-4396-befe-4e4104a24477";
    fsType = "ext4";
    autoFormat = true;
    mountPoint = "/usr/data2";


    # See FILESYSTEM-INDEPENDENT MOUNT OPTIONS at:
    # https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
    # (I think its just man pages basically)
    options = [ 
        "nosuid"
        "nodev"
        "nofail"
        "x-gvfs-show"
    ];

};

services.devmon.enable = true;
services.gvfs.enable = true;
services.udisks2.enable = true;

  #boot.kernelParams = [ "kernel.unprivileged_userns_clone=1" "user.max_user_namespaces=15000" ]; # Needed for steam now?
  #  boot.kernel.sysctl = { # Needed to Steam now?
  #    "kernel.unprivileged_userns_clone" = true;
  #    "user.max_user_namespaces" = 15000; # Set this to a sufficiently high value as required
  #  };




#######################################
# Graphics and Desktop
#######################################

  # Nvidia settings

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # "OpenGL"
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };










  programs.steam = {
  enable = true;
  #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};


#######################################
# Networking
#######################################

  networking.hostName = "cathedral"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall= {
      allowedTCPPorts = [ 22 443 3389 8080 5001];
      allowedUDPPorts = [  ];
      allowPing = true;
  };

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

#######################################
# Languages and Localization
#######################################

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   #console = {
   #  font = "Lat2-Terminus16";
   #  keyMap = "us";
   #  useXkbConfig = true; # use xkb.options in tty.
   #};


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


#######################################
# Users and packages
#######################################


  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.emillyo = {
     isNormalUser = true;
     initialPassword = "";
     # Can use this above to do auto login services.displayManager.autoLogin
     extraGroups = [ "storage" "wheel" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.bash;
     packages = with pkgs; [
       brave
       notepadqq
       obsidian
       discord
       
     ];
   };




  # List packages installed in system profile. To search, run:
  # $ nix search XXXXX

  environment.systemPackages = with pkgs; [
    # FHS environment above for programs and libraries that need it
    fhsEnv
    
    # graphical libs to help around generally
    gtk3
    adwaita-icon-theme
    qt5.qtbase
    xapp
    xdg-desktop-portal-xapp
    #cinnamon-common
    #cinnamon-session
    #cinnamon-desktop
    #cinnamon-screensaver
    #cinnamon-control-center
    #cinnamon-settings-daemon


    wget
    wezterm
    
    vscodium.fhs
    pika-backup
    bottom
    gparted
    steam
    zoom-us
    unzip
    fzf
     
    xclip
    lazygit
    just
    baobab

    # Bitcoin
    bitcoin # GUI + CLI

    # Rust
    rustup
    #rustc
    cargo

    # python related
    quarto
   ];
  
  environment.variables = {
    GTK_PATH = "${pkgs.gtk3}/lib/gtk-3.0";
  };






#######################################
# NixOS and Nix Store
#######################################

  # Store optimization
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };


  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;



  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 524288000;  # 500 MB
    cores = 12;

  };
}

