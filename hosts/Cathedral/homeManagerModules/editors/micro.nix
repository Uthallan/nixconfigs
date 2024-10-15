{ config, pkgs, ... }:

{

programs.micro = {
	# Options at https://github.com/zyedidia/micro/blob/master/runtime/help/options.md
	enable = true;
	settings = {
			diffgutter = true; diff = true;
			saveundo = true;
			softwrap = true; wordwrap = true;
			status = true;
			linter = true;
			literate = true;
			
			
		};  
	}; 

}