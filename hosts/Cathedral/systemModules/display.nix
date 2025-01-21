{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    gtk3
    adwaita-icon-theme
    qt5.qtbase
    xapp
    xdg-desktop-portal-xapp
    cinnamon-common
    cinnamon-session
    cinnamon-desktop
    #cinnamon-screensaver
    cinnamon-control-center
    cinnamon-settings-daemon
    rustdesk
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.cinnamon.enable = true;
    #desktopManager.xfce.enable = true;
    #desktopManager.xfce.enableScreensaver = true;
    displayManager.lightdm.enable = true;
    displayManager.sessionCommands = ''
    xset -dpms
    xset s noblank
    xset s off
    '';

#     ${builtins.readFile /home/emillyo/.dotfiles/hosts/Cathedral/dummy.conf}
#    config = ''    '';
  };

  services.xrdp = {
  enable = true;
  #port = 3389;
  openFirewall = true;
  defaultWindowManager = "cinnamon-session-cinnamon";

  };

  services.rustdesk-server = {
  	enable = true;
  	openFirewall = true;
    signal.enable = false;
    relay.enable = false;
    #signal.relayHosts = [ "127.0.0.1"];
  };


  services.libinput.enable = true; # renamed from services.xserver.libinput.enable = true;
  services.displayManager.defaultSession = "cinnamon";
  services.displayManager.autoLogin = {
  	enable = true;
  	user = "emillyo";
  };
  #services.cinnamon.apps.enable = true;
  #services.displayManager.defaultSession = "xfce";
  services.dbus.enable = true;

}
