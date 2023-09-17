local crates = require('crates')

vim.keymap.set('n', '<leader>vt', crates.toggle, { noremap = true, silent = true, desc = "[t]oggle crates"})
vim.keymap.set('n', '<leader>vr', crates.reload, { noremap = true, silent = true, desc = "[r]eload crates" })

vim.keymap.set('n', '<leader>vv', crates.show_versions_popup, { noremap = true, silent = true, desc = "Show [v]ersions popup" })
vim.keymap.set('n', '<leader>vf', crates.show_features_popup, { noremap = true, silent = true, desc = "Show [f]eatures popup" })
vim.keymap.set('n', '<leader>vd', crates.show_dependencies_popup, { noremap = true, silent = true, desc = "Show [d]ependencies popup" })

vim.keymap.set('n', '<leader>vu', crates.update_crate, { noremap = true, silent = true, desc = "[u]pdate crate" })
vim.keymap.set('v', '<leader>vu', crates.update_crates, { noremap = true, silent = true, desc = "[u]pdate crates" })
vim.keymap.set('n', '<leader>va', crates.update_all_crates, { noremap = true, silent = true, desc = "Update [a]ll crates" })
vim.keymap.set('n', '<leader>vU', crates.upgrade_crate, { noremap = true, silent = true, desc = "[U]pgrade crate" })
vim.keymap.set('v', '<leader>vU', crates.upgrade_crates, { noremap = true, silent = true, desc = "[U]pgrade crates" })
vim.keymap.set('n', '<leader>vA', crates.upgrade_all_crates, { noremap = true, silent = true, desc = "Upgrade [A]ll crates" })

vim.keymap.set('n', '<leader>ve', crates.expand_plain_crate_to_inline_table, { noremap = true, silent = true, desc = "[e]xpand plain crate" })
vim.keymap.set('n', '<leader>vE', crates.extract_crate_into_table, { noremap = true, silent = true, desc = "[E]xpand plain crate" })

vim.keymap.set('n', '<leader>vH', crates.open_homepage, { noremap = true, silent = true, desc = "Open [H]omepage" })
vim.keymap.set('n', '<leader>vR', crates.open_repository, { noremap = true, silent = true, desc = "Open [R]epository" })
vim.keymap.set('n', '<leader>vD', crates.open_documentation, { noremap = true, silent = true, desc = "Open [D]ocumentation" })
vim.keymap.set('n', '<leader>vC', crates.open_crates_io, { noremap = true, silent = true, desc = "Open [C]rates.io" })

