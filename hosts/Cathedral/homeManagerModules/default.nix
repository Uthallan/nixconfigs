{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #./example.nix
      #./scripts/default.nix
      ./editors/micro.nix
      ./editors/neovim.nix
      ./shells/bash.nix
      ./git.nix
      ./tmux.nix
    ];

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
    };
}
