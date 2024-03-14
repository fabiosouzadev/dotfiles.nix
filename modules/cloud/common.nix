
{  config, pkgs, defaultUser, defaultGit, ... }:

{
  
  home-manager.users.${defaultUser} = {
    home.packages = with pkgs; [
	k3s
	kind
	minikube
	k9s
	kubie
	#lens
	k6 # load testing tool
    ];

    home.file.".kube/kubie.yaml".text = ''
      # Force kubie to use a particular shell, if unset detect shell currently in use.
      # Possible values: bash, dash, fish, xonsh, zsh
      # Default: unset
      shell: zsh

      # Configure where to look for kubernetes config files.
      configs:

          # Include these globs.
          # Default: values listed below.
          include:
              - ~/.kube/config
              - ~/.kube/*.yml
              - ~/.kube/*.yaml
              - ~/.kube/configs/*.yml
              - ~/.kube/configs/*.yaml
              - ~/.kube/kubie/*.yml
              - ~/.kube/kubie/*.yaml
              - ~/.dotfiles.nix/zapay/kube/*.yaml

          # Exclude these globs.
          # Default: values listed below.
          # Note: kubie's own config file is always excluded.
          exclude:
              - ~/.kube/kubie.yaml

      # Prompt settings.
      prompt:
          # Disable kubie's custom prompt inside of a kubie shell. This is useful
          # when you already have a prompt displaying kubernetes information.
          # Default: false
          disable: true

          # When using recursive contexts, show depth when larger than 1.
          # Default: true
          show_depth: true

          # When using zsh, show context and namespace on the right-hand side using RPS1.
          # Default: false
          zsh_use_rps1: true

          # When using fish, show context and namespace on the right-hand side.
          # Default: false
          fish_use_rprompt: false

          # When using xonsh, show context and namespace on the right-hand side.
          # Default: false
          xonsh_use_right_prompt: false

      # Behavior
      behavior:
          # Make sure the namespace exists with `kubectl get namespaces` when switching
          # namespaces. If you do not have the right to list namespaces, disable this.
          # Default: true
          validate_namespaces: true

          # Enable or disable the printing of the 'CONTEXT => ...' headers when running
          # `kubie exec`.
          # Valid values:
          #   auto:   Prints context headers only if stdout is a TTY. Piping/redirecting
          #           kubie output will auto-disable context headers.
          #   always: Always prints context headers, even if stdout is not a TTY.
          #   never:  Never prints context headers.
          # Default: auto
          print_context_in_exec: auto

      # Optional start and stop hooks
      hooks:
          # A command hook to run when a CTX is started.  
          # This example re-labels your terminal window
          # Default: none
          start_ctx: >
              echo -en "\033]1; `kubie info ctx`|`kubie info ns` \007"

          # A command hook to run when a CTX is stopped
          # This example sets the terminal back to the shell name
          # Default: none
          stop_ctx: >
              echo -en "\033]1; $SHELL \007"
    '';

    home.file.".config/k9s/skin.yml".text = ''
      # Styles...
      foreground: &foreground "#f8f8f2"
      background: &background "default"
      current_line: &current_line "#44475a"
      selection: &selection "#44475a"
      comment: &comment "#6272a4"
      cyan: &cyan "#8be9fd"
      green: &green "#50fa7b"
      orange: &orange "#ffb86c"
      pink: &pink "#ff79c6"
      purple: &purple "#bd93f9"
      red: &red "#ff5555"
      yellow: &yellow "#f1fa8c"

      # Skin...
      k9s:
        # General K9s styles
        body:
          fgColor: *foreground
          bgColor: *background
          logoColor: *purple
        # Command prompt styles
        prompt:
          fgColor: *foreground
          bgColor: *background
          suggestColor: *purple
        # ClusterInfoView styles.
        info:
          fgColor: *pink
          sectionColor: *foreground
        # Dialog styles.
        dialog:
          fgColor: *foreground
          bgColor: *background
          buttonFgColor: *foreground
          buttonBgColor: *purple
          buttonFocusFgColor: *yellow
          buttonFocusBgColor: *pink
          labelFgColor: *orange
          fieldFgColor: *foreground
        frame:
          # Borders styles.
          border:
            fgColor: *selection
            focusColor: *current_line
          menu:
            fgColor: *foreground
            keyColor: *pink
            # Used for favorite namespaces
            numKeyColor: *pink
          # CrumbView attributes for history navigation.
          crumbs:
            fgColor: *foreground
            bgColor: *current_line
            activeColor: *current_line
          # Resource status and update styles
          status:
            newColor: *cyan
            modifyColor: *purple
            addColor: *green
            errorColor: *red
            highlightcolor: *orange
            killColor: *comment
            completedColor: *comment
          # Border title styles.
          title:
            fgColor: *foreground
            bgColor: *current_line
            highlightColor: *orange
            counterColor: *purple
            filterColor: *pink
        views:
          # Charts skins...
          charts:
            bgColor: default
            defaultDialColors:
              - *purple
              - *red
            defaultChartColors:
              - *purple
              - *red
          # TableView attributes.
          table:
            fgColor: *foreground
            bgColor: *background
            cursorFgColor: *foreground
            cursorBgColor: *current_line
            # Header row styles.
            header:
              fgColor: *foreground
              bgColor: *background
              sorterColor: *cyan
          # Xray view attributes.
          xray:
            fgColor: *foreground
            bgColor: *background
            cursorColor: *current_line
            graphicColor: *purple
            showIcons: false
          # YAML info styles.
          yaml:
            keyColor: *pink
            colonColor: *purple
            valueColor: *foreground
          # Logs styles.
          logs:
            fgColor: *foreground
            bgColor: *background
            indicator:
              fgColor: *foreground
              bgColor: *purple
    '';

    programs.zsh = {
      shellAliases = {
        kubectx = "kubie";
        kctx    = "kubie";
      };
    };
  };

}
