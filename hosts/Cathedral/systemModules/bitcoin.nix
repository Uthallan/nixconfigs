# You can directly copy and import this file to use nix-bitcoin
# in an existing NixOS configuration.
# Make sure to check and edit all lines marked by 'FIXME:'

# See ./flakes/flake.nix on how to include nix-bitcoin in a flake-based
# system configuration.

let
  # FIXME:
  # Overwrite `builtins.fetchTarball {}` with the output of
  # command ../helper/fetch-release
  nix-bitcoin = builtins.fetchTarball {
  url = "https://github.com/fort-nix/nix-bitcoin/archive/v0.0.117.tar.gz";
  sha256 = "sha256-JN/PFBOVqWKc76zSdOunYoG5Q0m8W4zfrEh3V4EOIuk=";
};

in
{ config, pkgs, lib, ... }: 
{
  imports = [
    "${nix-bitcoin}/modules/modules.nix"
  ];

  # Automatically generate all secrets required by services.
  # The secrets are stored in /etc/nix-bitcoin-secrets
  nix-bitcoin.generateSecrets = true;

  # Enable some services.
  # See ./configuration.nix for all available features.
  services.bitcoind = {
    enable = true;
    dataDir = "/usr/data2/bitcoin";

    rpc = {
      address = "0.0.0.0";
      allowip = [ "0.0.0.0/0" ];
      users = {
        emillyo = {
          passwordHMAC = "a3bb8fa0ba76f710326fef4a94455e8c$a5b78bf7a207e2d865c282835e7406d220a07e84659b4cfbf4856e0c4de4fe01";
        };
      };

    };

  };
  networking.firewall.allowedTCPPorts = [ config.services.bitcoind.rpc.port ];
  #services.clightning.enable = true;

  # Enable interactive access to nix-bitcoin features (like bitcoin-cli) for
  # your system's main user
  nix-bitcoin.operator = {
    enable = true;
    # FIXME: Set this to your system's main user
    name = "emillyo";
  };

  # Prevent garbage collection of the nix-bitcoin source
  system.extraDependencies = [ nix-bitcoin ];
}