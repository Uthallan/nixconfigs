{ self, config, lib, pkgs, ... }:
# Reference: https://carlosvaz.com/posts/the-holy-grail-nextcloud-setup-made-easy-by-nixos/
{
  
  environment.etc."nextcloud-admin-pass".text = "1q2w3e4r!Q@W#E$R";
services.nextcloud = {
  enable = true;
  package = pkgs.nextcloud30;
  hostName = "cloud.local";
  database.createLocally = true;
  datadir = "/usr/data1/nextcloud";
  maxUploadSize = "16G";
  config.adminuser = "emillyo";
  config.adminpassFile = "/etc/nextcloud-admin-pass";
  config.dbtype = "pgsql";
};


}
