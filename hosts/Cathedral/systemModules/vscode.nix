{ config, pkgs, lib, ... }:

let
  vscodeNodeVersion = pkgs.nodejs-18_x; # Adjust Node.js version as needed
in {
  environment.systemPackages = with pkgs; [
    vscodeNodeVersion
    vscode
  ];

  systemd.user = {
    paths.vscode-remote-workaround = {
      wantedBy = ["default.target"];
      pathConfig.PathChanged = "%h/.vscode-server";
    };

    services.vscode-remote-workaround.script = ''
      for dir in ~/.vscode-server/cli/servers/*/server; do
        echo "Fixing VSCode server in $dir..."
        ln -sf /run/current-system/sw//bin/node $dir/node
      done
    '';
  };
}

