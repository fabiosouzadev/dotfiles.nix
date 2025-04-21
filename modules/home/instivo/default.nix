{config, ...}: {
  programs.git = {
    includes = [
      {
        contents = {
          user = {
            email = "fabio.souza@instivo.com.br";
            name = "Fabio Souza";
            # signingKey = "1A2B3C4D5E6F7G8H";
          };
          core = {
            sshCommand = "ssh -i $HOME/.ssh/instivo_ed25519";
          };
          commit = {
            gpgSign = true;
          };
        };
        contentSuffix = "gitconfig.instivo.inc";
        condition = "gitdir:~/Projects/Work/Instivo/";
      }
    ];
  };
}
