-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
  yellow = '#e5c07b',
  const = '#56b6c2'
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.black, bg = colors.cyan },
        c = { fg = colors.white, bg = colors.grey },
        -- c = { fg = colors.white, bg = colors.black },
    },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

local function update_filename_color(section)
    if not vim.bo.modifiable then
        return { fg = colors.black, bg = colors.const }
    end
    if vim.bo.modified then
        return { fg = colors.black, bg = colors.yellow }
    else
        return { fg = colors.black, bg =  colors.blue}
    end
end

require('lualine').setup {
  options = {
    theme = 'everforest',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      { 'filename', color = update_filename_color, separator = { right = '' } }
    },
    lualine_c = { 'diff', {
      'diagnostics',
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
    }
    -- , { 'coc#status' }
  }
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = { { 'tabs', mode = 2, max_length = vim.o.columns / 2 } },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'branch' },
  },

  -- options = {
  --   theme = bubbles_theme,
  --   component_separators = { left = '', right = '' },
  --   section_separators = { left = '', right = '' },
  --   globalstatus = true
  -- },
  -- sections = {
  --   lualine_a = {
  --     { 'mode', separator = { left = '' }, right_padding = 2 },
  --   },
  --   lualine_b = {
  --       { 'filename', color = update_filename_color}
  --   },
  --   lualine_c = { 'diff', { 'diagnostics',
  --     symbols = { error = '', warn = '', info = '', hint = '' }
  --   } },
  --   lualine_x = { 'coc#status' },
  --
  --
  --   lualine_y = { 'filetype', 'progress' },
  --   lualine_z = {
  --     { 'location', separator = { right = '' }, left_padding = 2 },
  --   },
  -- },
  -- inactive_sections = {
  --   lualine_a = { 'filename' },
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = { 'location' },
  -- },
  -- tabline = {
  --   lualine_a = {{ 'tabs', mode = 2, max_length = vim.o.columns / 2}},
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = { 'branch' },
  -- },
  -- extensions = {},
}
