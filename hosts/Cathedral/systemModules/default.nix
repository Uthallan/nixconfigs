{ ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #./example.nix 
      #./gpt4all.nix
      ./display.nix
      #./bitcoin.nix
      #./nextcloud.nix
      ./vscode.nix
      ./audio.nix
      ./dev/default.nix
    ];


}
