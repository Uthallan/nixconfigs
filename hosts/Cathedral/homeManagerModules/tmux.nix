{ config, pkgs, ... }:

{


  programs.tmux = {
    enable = true;
    mouse = true;

    plugins = with pkgs; [

      tmuxPlugins.better-mouse-mode
      tmuxPlugins.yank
      tmuxPlugins.tmux-powerline
      tmuxPlugins.sidebar
      tmuxPlugins.sensible
      tmuxPlugins.sysstat
      tmuxPlugins.prefix-highlight
      
    ];

    extraConfig = ''
      set -g @plugin 'alexwforsythe/tmux-which-key'
    '';


  };


}
