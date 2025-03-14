{pkgs, ...}: {
  home.packages = with pkgs; [
    # k3s
    kind
    minikube
    k9s
    #kubeswitch # needs a valid ~/.kube/config
    kubie
    k6 # load testing tool
    lens
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
            - ~/.kube/switch-config.yaml

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
        zsh_use_rps1: false

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
        validate_namespaces: false

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

  home.file.".kube/switch-config.yaml".text = ''
    kind: SwitchConfig
    version: v1alpha1
    kubeconfigStores:
    - kind: filesystem
      id: config
      paths:
        - "~/.kube/"
    - kind: filesystem
      id: zapay
      kubeconfigName: "zapay*"
      paths:
        - "~/.dotfiles.nix/zapay/kube/"
    # - kind: gke
    #   refreshIndexAfter: 3h
    #   config:
    #     # optionally set the account. Otherwise, the currently active gcloud account will be used.
    #     gcpAccount: fabio.souza@ciahering.com.br
    #     authentication:
    #       authenticationType: gcloud
    #   cache:
    #     kind: filesystem
    #     config:
    #       path: ~/.cache/kube/
    #     # optionally limit to certain projects in account
    #     # projectIDs:
    #     #   - hering-integracoes-b2c-dev
  '';

  programs.zsh = {
    shellAliases = {
      kubectx = "kubie ctx";
      kubens = "kubie ns";
      kctx = "kubie ctx";
    };
  };
}
