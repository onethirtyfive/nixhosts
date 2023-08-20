pkgs:
{ ... }:
let
  inherit (pkgs) vimPlugins;
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;

    plugins = with vimPlugins; [
      neodev-nvim

      # tmux
      vim-tmux-navigator

      # scm
      fugitive
      gitsigns-nvim
      vim-rhubarb

      # chrome
      lualine-nvim
      nvim-tree-lua
      nvim-web-devicons
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-live-grep-args-nvim
      which-key-nvim

      # theme
      nvim-solarized-lua

      # lang
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          bash
          c
          css
          diff
          git-rebase
          gitattributes
          gitcommit
          gitignore
          haskell
          hcl
          html
          javascript
          lua
          nix
          python
          ruby
          rust
          terraform
          tree-sitter-tsx
          typescript
        ]
      ))
      nvim-treesitter-textobjects
      nvim-ts-autotag

      # lsp: meta
      nvim-lspconfig
      fidget-nvim

      # lsp: utility
      # copilot-lua
      lsp_signature-nvim
      lspkind-nvim
      luasnip

      # text
      comment-nvim
      indent-blankline-nvim
      vim-sleuth

      # cmp
      nvim-cmp
      # copilot-cmp
      cmp-git
      cmp-buffer
      cmp-cmdline
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
    ];

    extraPackages = with pkgs; [
      marksman
      nil
      nmap
      ripgrep
      taplo
      terraform
      terraform-ls
      texlab
    ] ++ (with pkgs.joshua; [ ruby_3_1 ])
      ++ (with pkgs.nodejs_16.pkgs; [ typescript-language-server vscode-langservers-extracted ]);

    extraLuaConfig =
      let
        inherit (builtins) concatStringsSep readFile map;

        sources = [
          ./init.lua
          ./plugins/lsp.lua
          ./plugins/lualine.lua
          ./plugins/ruby.lua
          ./plugins/treesitter.lua
          ./plugins/cmp.lua
          ./plugins/telescope.lua
        ];
      in concatStringsSep "\n" (map readFile sources);
  };
}

