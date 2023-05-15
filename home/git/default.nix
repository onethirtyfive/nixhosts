{ ... }:
# Git Config: https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
# Signing Commits: https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work
# rerere: https://git-scm.com/book/en/v2/Git-Tools-Rerere
{
  # home.files.".gitconfig" = ""; # disallow other files
  # home.files.".gitignore" = ''
  #   .DS_Store
  #   *.swp
  # '';

  programs.git = {
    enable = true;

    aliases = {
      s = "status";
      g = "";
      ci = "commit";
      br = "branch";
      co = "checkout";
      df = "diff";
      dc = "diff --cached";
      ls = "ls-files";
      ign = "ls-files -o -i --exclude-standard";
      brs = "branch --sort=committerdate";
      deep-review = "log --no-merges -p --reverse -w";
      dr = "deep-review";
    };

    extraConfig = {
      filter = {
        lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };
      };
      # [diff]
      #     tool = meld
      # [difftool]
      #     prompt = false
      # [difftool "meld"]
      #   cmd = meld "$LOCAL" "$REMOTE"
    };

    ignores = [
      ".DS_Store"
      "*.swp"
    ];

    includes = [
      {
	contents = {

          user = {
            name = "Joshua Morris"; # email intentionally omitted
            editor = "nvim";
            signingKey = "FF30B1CA93CB1225";
          };

          commit.gpgSign = true;
          rerere.enabled = true;
          log.showsignature = false;
          init.defaultBranch = "main";

          core = {
            whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
          };

          color.ui = "auto";
        };
      }
    ];
  };
}

