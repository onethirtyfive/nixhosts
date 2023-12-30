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

      # projects
      project-nvim
      telescope-project-nvim

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
      nightfox-nvim

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
          toml
          tree-sitter-tsx
          typescript
          tree-sitter-yaml
        ]
      ))
      nvim-treesitter-textobjects
      nvim-ts-autotag

      # rust
      plenary-nvim
      rust-tools-nvim
      crates-nvim

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

      # debugging
      nvim-dap
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
      taplo
    ] ++ (with pkgs.joshua; [ ruby31.env ])
      ++ (with pkgs.nodejs.pkgs; [ typescript-language-server vscode-langservers-extracted ]);

    extraLuaConfig =
      let
        inherit (builtins) concatStringsSep readFile map;

        sources = [
          ./init.lua
          ./plugins/crates.lua
          ./plugins/lsp.lua
          ./plugins/lualine.lua
          ./plugins/treesitter.lua
          ./plugins/cmp.lua
          ./plugins/telescope.lua
        ];
      in concatStringsSep "\n" (map readFile sources);
  };
}

