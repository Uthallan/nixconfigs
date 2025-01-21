{ config, pkgs, ... }:

{

imports = [
  ./scripts/default.nix
];

environment.systemPackages = with pkgs; [ 
    nixfmt
    nixd
    nil
    ];


}