{ config, pkgs, ... }:
let
  inherit (pkgs) tmuxPlugins;
in
{
  programs.fzf.tmux.enableShellIntegration = true;

  programs.tmux = {
    enable = true;

    prefix = "`";
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;

    customPaneNavigationAndResize = true;

    shell = "${config.programs.zsh.package}/bin/zsh";

    plugins = with tmuxPlugins; [
      tmux-fzf
      vim-tmux-navigator
      yank
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
    # prefix-highlight and continuum are loaded manually at the very end (not via
    # `plugins`) because both rewrite status-right when they load; anything that
    # sets status-right after them (e.g. the theme in tmux-extra.conf) silently
    # undoes their work.
    extraConfig = ''
      ${builtins.readFile ./tmux-extra.conf}

      set -g @prefix_highlight_fg '#0c0c0c'
      set -g @prefix_highlight_bg '#78a9ff'
      set -g @prefix_highlight_prefix_prompt 'PREFIX'
      set -g @prefix_highlight_show_copy_mode 'on'
      set -g @prefix_highlight_copy_mode_attr 'fg=#0c0c0c,bg=#b6b8bb,bold'
      set -g @prefix_highlight_copy_prompt 'COPY'
      run-shell ${tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux

      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15' # minutes
      run-shell ${tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
    '';
  };
}
