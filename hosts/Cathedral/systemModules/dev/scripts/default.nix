{ config, pkgs, ... }:

{

environment.systemPackages = with pkgs; [ 
    (import ./lol.nix { inherit pkgs; })
    ];

}