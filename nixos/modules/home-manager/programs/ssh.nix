{ homedir, ssh-identities, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks =
    let
      identityFile = map (i: "${homedir}/.ssh/${i}") ssh-identities;
    in {
      github = {
        user = "git";
        host = "github.com";
        inherit identityFile;
      };
      gitlab = {
        user = "git";
        host = "gitlab.com";
        inherit identityFile;
      };
      bitbucket = {
        user = "git";
        host = "bitbucket.org";
        inherit identityFile;
      };
    };

    extraConfig = ''
      AddKeysToAgent yes
    '';
  };
}
