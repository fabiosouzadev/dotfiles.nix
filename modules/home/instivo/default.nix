{config, ...}: {
  programs.git = {
    includes = [
      {
        contents = {
          user = {
            email = "fabio.souza@instivo.com.br";
            name = "Fabio Souza";
            signingKey = "93D386079F216B6C";
          };
          core = {
            sshCommand = "ssh -i $HOME/.ssh/instivo_ed25519";
          };
        };
        contentSuffix = "gitconfig.instivo.inc";
        # condition = "gitdir:~/Projects/Work/Instivo/";
        # Like: https://seansantry.com/development/2022/12/14/split-git-nix/
        # See: https://git-scm.com/docs/git-config#_configuration_file
        condition = "hasconfig:remote.*.url:git@github.com:Instivo/*";
      }
    ];
  };
}
