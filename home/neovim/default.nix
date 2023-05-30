{ pkgs , ... }:
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

      fugitive
      nvim-cmp
      cmp-git
      cmp-buffer
      cmp-cmdline
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      comment-nvim
      copilot-cmp
      copilot-lua
      fidget-nvim
      gitsigns-nvim
      indent-blankline-nvim
      lspkind-nvim
      lsp_signature-nvim
      lualine-nvim
      luasnip
      neodev-nvim
      nvim-lspconfig
      nvim-tree-lua
      nvim-ts-autotag
      lualine-nvim
      plenary-nvim
      vim-rhubarb
      vim-sleuth
      nvim-solarized-lua
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-live-grep-args-nvim
      nvim-treesitter-textobjects
      which-key-nvim
      nvim-web-devicons
      # papercolor-theme
      # nvim-autopairs
    ];

    extraPackages = with pkgs; [
      nmap

      #lsp
      marksman
      nil
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      ripgrep
      rubyPackages.solargraph
      taplo
      terraform
      terraform-ls
      texlab
    ];

    extraLuaConfig =
      let
        inherit (builtins) concatStringsSep readFile map;

        sources = [
          ./init.lua
          ./plugins/treesitter.lua
          ./plugins/lsp.lua
          ./plugins/cmp.lua
          ./plugins/telescope.lua
        ];
      in concatStringsSep "\n" (map readFile sources);
  };
}

