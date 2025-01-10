{ config, pkgs, ... }:

{

	environment.systemPackages = with pkgs; [
		gpt4all-cuda
	];

}