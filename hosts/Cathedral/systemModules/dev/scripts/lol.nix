{pkgs}:


pkgs.writeShellApplication {
  name = "lol";
  
  text = ''
  echo "lol its an app or something"
  '';
  }