{ ... }:
# Git Config: https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
# Signing Commits: https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work
# rerere: https://git-scm.com/book/en/v2/Git-Tools-Rerere
{
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
      core = {
        editor = "nvim";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        pager = "less -R -F -X";
      };
      filter = {
        lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };
      };

      user = {
        name = "Joshua Morris"; # email intentionally omitted
        email = "joshua.morris@hey.com";
        signingKey = "FF30B1CA93CB1225";
      };

      commit.gpgSign = true;
      rerere.enabled = true;
      log.showsignature = false;
      init.defaultBranch = "main";

      color.ui = "auto";
    };

    ignores = [
      ".DS_Store"
      "*.swp"
    ];

    signing = {
      signByDefault = true;
      key = "FF30B1CA93CB1225";
    };
  };
}

