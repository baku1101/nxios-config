{
  programs.nixvim = {
    colorschemes.gruvbox.enable = true;
    colorschemes.kanagawa = {
      enable = false;
      settings = {
	colors = {
	  palette = {
	    fujiWhite = "#FFFFFF";
	    sumiInk0 = "#000000";
	  };
	  theme = {
	    all = {
	      ui = {
		bg_gutter = "none";
	      };
	    };
	    dragon = {
	      syn = {
		parameter = "yellow";
	      };
	    };
	    wave = {
	      ui = {
		float = {
		  bg = "none";
		};
	      };
	    };
	  };
	};
	commentStyle = {
	  italic = true;
	};
	compile = false;
	dimInactive = false;
	functionStyle = { };
	overrides = "function(colors) return {} end";
	terminalColors = true;
	theme = "wave";
	transparent = false;
	undercurl = true;
      };
    };

    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      clipboard = "unnamedplus";
    };
  };
}
