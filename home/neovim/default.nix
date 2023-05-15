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

    plugins = with vimPlugins; [
      # vim-closetag
      fugitive
      vim-rhubarb
      vim-sleuth
      cmp-git
      nvim-lspconfig
      lsp_signature-nvim
      fidget-nvim
      neodev-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      luasnip
      cmp_luasnip
      which-key-nvim
      gitsigns-nvim
      lualine-nvim
      indent-blankline-nvim
      comment-nvim
      telescope-nvim
      telescope-live-grep-args-nvim
      plenary-nvim
      telescope-fzf-native-nvim
      dressing-nvim
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          bash
          c
          css
          diff
          git-rebase
          gitattributes
          # gitcommit
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
          # terraform
          tree-sitter-tsx
          typescript
        ]
      ))
      nvim-treesitter-textobjects
      nvim-tree-lua
      nvim-ts-autotag
      nvim-web-devicons
      lualine-nvim
      papercolor-theme
      nvim-autopairs
    ];

    extraPackages = with pkgs; [
      nodePackages.typescript-language-server
      rubyPackages.solargraph
      nil
      ripgrep
      terraform-ls
      nmap
      nodePackages.vscode-langservers-extracted
      onethirtyfive-dev-python
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}

