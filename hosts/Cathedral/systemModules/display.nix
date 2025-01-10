{ config, pkgs, ... }:

{

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
  port = 3389;
  #openFirewall = true;
  defaultWindowManager = "cinnamon-session";

  };


  services.libinput.enable = true; # renamed from services.xserver.libinput.enable = true;
  services.displayManager.defaultSession = "cinnamon";
  #services.cinnamon.apps.enable = true;
  #services.displayManager.defaultSession = "xfce";
  services.dbus.enable = true;

}