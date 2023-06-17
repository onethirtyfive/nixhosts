-- local custom_solarized_dark = require'lualine.themes.solarized_light'
-- custom_solarized_dark.normal.b.bg = '#404040'
-- custom_solarized_dark.inactive.b.bg = '#505050'

local custom_theme = require'lualine.themes.ayu_mirage'
custom_theme.normal.b.bg = '#2A3A44'
-- custom_theme.inactive.b.bg = '#505050'

require('lualine').setup {
  extensions = { 'nvim-tree' },
  options = {
    -- theme = custom_solarized_dark,
    theme = custom_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_b = {
      {
        'diff',
        colored = true,
        diff_color = {
          added    = { fg = 'DiffAdd', bg = custom_theme.normal.b.bg },
          modified = { fg = 'DiffChange', bg = custom_theme.normal.b.bg },
          remoted  = { fg = 'DiffDelete', bg = custom_theme.normal.b.bg },
        },
      },
      'diagnostics'
    },
    lualine_c = {
      {
        'filename',
        path = 4,
      },
      'progress',
    },
    lualine_y = {}
  },
  inactive_sections = {
    lualine_b = {
      {
        'diff',
        colored = true,
        diff_color = {
          -- Same color values as the general color option can be used here.
          added    = { fg = 'DiffAdd', bg = custom_theme.inactive.b.bg },
          modified = { fg = 'DiffChange', bg = custom_theme.inactive.b.bg },
          remoted  = { fg = 'DiffDelete', bg = custom_theme.inactive.b.bg },
        },
      },
      'diagnostics'
    },
    lualine_c = {
      {
        'filename',
        path = 4,
      },
      'progress',
    },
    lualine_y = {}
  },
}

