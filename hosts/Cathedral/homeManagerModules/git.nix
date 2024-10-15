{ config, pkgs, ... }:

{
  
programs.git = {
	enable = true;
  userEmail = "emillyoadamo@gmail.com";
  userName = "Uthallan";
  extraConfig = {
	init.defaultBranch = "main";
	};
	# damn there are a shitload of options for this thing
    };

}
