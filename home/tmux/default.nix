pkgs:
{ ... }:
let
  inherit (pkgs) tmuxPlugins;
in {
  programs.fzf.tmux.enableShellIntegration = true;

  programs.tmux = {
    enable = true;

    prefix = "`";
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;

    customPaneNavigationAndResize = true;

    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with tmuxPlugins; [
      tmux-colors-solarized
      tmux-fzf
      vim-tmux-navigator
      yank
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    extraConfig = builtins.readFile ./tmux-extra.conf;
  };
}
