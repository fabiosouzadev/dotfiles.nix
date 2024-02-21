{  config, pkgs, defaultUser, defaultGit, ... }:

{
  # basic configuration of git, please change to your own
  home-manager.users.${defaultUser} = {
    programs.git = {
      enable = true;
      userName = defaultGit.userName;
      userEmail = defaultGit.userEmail;
      signing = {
      	key = "64781516";
      	signByDefault = true;
      };

      delta = {
        enable = true;
	options = { 
	  navigate = true; 
          light = false; 
          line-numbers = true; 
          minus-style = "syntax #3a273a";
          minus-non-emph-style          = "syntax #3a273a";
          minus-emph-style              = "syntax #6b2e43";
          minus-empty-line-marker-style = "syntax #3a273a";
          line-numbers-minus-style      = "#b55a67";
          plus-style                    = "syntax #273849";
          plus-non-emph-style           = "syntax #273849";
          plus-emph-style               = "syntax #305f6f";
          plus-empty-line-marker-style  = "syntax #273849";
          line-numbers-plus-style       = "#627259";
          line-numbers-zero-style       = "#3b4261";
	}; 
      };

      aliases = {
       c = "!git add --all && git commit -m";
       s = "!git status -s";
       l = "!git log --pretty=format:'%C(blue)%hC(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'";
       amend = "!git add --all && git commit --amend --no-edit";
       count = "!git shortlog -s --grep";
      };

      extraConfig = {
        credential =  { helper = "cache --timeout=28800";};
	core = {
	 editor = "nvim";
	 default = "current";
	};
        init = { defaultBranch = "main"; };
	pull = { rebase = true; };
        diff = { colorMoved = "default"; };
	merge = { tool = "nvim"; };
	mergetool = { keepBackup = false; };
	"mergetool \"nvim\"" = { cmd = "nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'"; };
      };
    };
  };
}
