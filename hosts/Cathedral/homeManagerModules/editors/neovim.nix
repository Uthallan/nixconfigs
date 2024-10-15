{ config, pkgs, inputs, ...}: 

{

programs.neovim = {
	enable = true;
	withPython3 = true;
	plugins = with pkgs.vimPlugins; [
	  vim-nix
	  nvim-lspconfig
	  nvim-treesitter
	  nvim-cmp
	  harpoon
	  
	  { plugin = vim-startify;
	    config = "let g:startify_change_to_vcs_root = 0";
	  }
	];
	
};

}
