vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }),
  callback = function()
    vim.lsp.start {
      name = "standard",
      cmd = { "~/.rbenv/shims/standardrb", "--lsp" },
    }
  end,
})
