local crates = require('crates')

vim.keymap.set('n', '<leader>vt', crates.toggle, { buffer = bufnr, silent = true, desc = "[t]oggle Crates"})
vim.keymap.set('n', '<leader>vr', crates.reload, { buffer = bufnr, silent = true, desc = "[r]eload Crates" })

vim.keymap.set('n', '<leader>vv', crates.show_versions_popup, { buffer = bufnr, silent = true, desc = "Show [v]ersions Popup" })
vim.keymap.set('n', '<leader>vf', crates.show_features_popup, { buffer = bufnr, silent = true, desc = "Show [f]eatures Popup" })
vim.keymap.set('n', '<leader>vd', crates.show_dependencies_popup, { buffer = bufnr, silent = true, desc = "Show [d]ependencies Popup" })

vim.keymap.set('n', '<leader>vu', crates.update_crate, { buffer = bufnr, silent = true, desc = "[u]pdate crate" })
vim.keymap.set('v', '<leader>vu', crates.update_crates, { buffer = bufnr, silent = true, desc = "[u]pdate crates" })
vim.keymap.set('n', '<leader>va', crates.update_all_crates, { buffer = bufnr, silent = true, desc = "update [a]ll crates" })
vim.keymap.set('n', '<leader>vU', crates.upgrade_crate, { buffer = bufnr, silent = true, desc = "[U]pgrade crate" })
vim.keymap.set('v', '<leader>vU', crates.upgrade_crates, { buffer = bufnr, silent = true, desc = "[U]pgrade crates" })
vim.keymap.set('n', '<leader>vA', crates.upgrade_all_crates, { buffer = bufnr, silent = true, desc = "upgrade [A]ll crates" })

vim.keymap.set('n', '<leader>ve', crates.expand_plain_crate_to_inline_table, { buffer = bufnr, silent = true, desc = "[e]xpand plain crate" })
vim.keymap.set('n', '<leader>vE', crates.extract_crate_into_table, { buffer = bufnr, silent = true, desc = "[E]xpand plain crate" })

vim.keymap.set('n', '<leader>vH', crates.open_homepage, { buffer = bufnr, silent = true, desc = "open [H]omepage" })
vim.keymap.set('n', '<leader>vR', crates.open_repository, { buffer = bufnr, silent = true, desc = "open [R]epository" })
vim.keymap.set('n', '<leader>vD', crates.open_documentation, { buffer = bufnr, silent = true, desc = "open [D]ocumentation" })
vim.keymap.set('n', '<leader>vC', crates.open_crates_io, { buffer = bufnr, silent = true, desc = "open [C]rates.io" })


