{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #./example.nix 
      #./gpt4all.nix
      ./display.nix
    ];


}
