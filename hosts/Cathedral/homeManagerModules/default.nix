{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #./example.nix 
      ./editors/micro.nix
      ./editors/neovim.nix
      ./shells/bash.nix
      ./git.nix
    ];

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
    };
}
