{ config, pkgs, ... }:

{

  # Help enabling BASH autocompletion?
  # https://mynixos.com/home-manager/option/programs.bash.enableCompletion
  #environment.pathsToLink = [ "/share/bash-completion" ];

    home.packages = [
    
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'myhello' to your
    # # environment:
     (pkgs.writeShellScriptBin "myhello" ''
       echo "Hello, ${config.home.username}!"
     '')
  ];

    programs = {


    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {	
     	   ll = "ls -l"; # Turn into a variable
      };
    };

    alacritty = {
  	  enable = true;

  	  # https://alacritty.org/config-alacritty.html
  	  settings = {};
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
    
      # See https://starship.rs/config/ for the full list of options
      settings = {};
    };

    
    carapace = { 
      enable = true;
      enableBashIntegration = true;
    };



    zoxide = {
      enable = true;
      enableBashIntegration = true;
      # options = [];
    };

    zellij = {
      enable = false;
      enableBashIntegration = true;
      # See https://zellij.dev/old-documentation/options for the full list of options.
      settings = {
      };
    };

    };


}
