local g = vim.g
local o = vim.o
local fn = vim.fn

local M = {}

function M.setup() 
g.onedark_style = 'warm'

g.sonokai_diagnostic_text_highlight = 1
g.sonokai_diagnostic_virtual_text = 'colored'
g.sonokai_better_performance = 1
g.sonokai_style = 'shusia'

-- Gruvbox theme configs
g.gruvbox_contrast_dark = 'hard'
g.gruvbox_sign_column = 'bg0'
-- g.gruvbox_improved_strings = 1
g.gruvbox_improved_warnings = 1

g.onedark_terminal_italics = 1

-- everforest theme configs
g.everforest_enable_italic = 1
g.everforest_diagnostic_virtual_text = 'colored'
g.everforest_diagnostic_line_highlight = 1
g.everforest_sign_column_background = grey
g.everforest_enable_italic = 1

o.showmode = false
o.termguicolors = true

vim.cmd('color everforest')

local function getHighlightAttr(group, attr)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

local function getHighlightAttr2(group, attr)
  for k, v in pairs(vim.api.nvim_get_hl(0, { name = group })) do
    print(k, v)
  end
  return vim.api.nvim_get_hl(0, { name = group })[attr]
end

local function setDiagnosticHighlight(group, fg)
  vim.api.nvim_set_hl(0, group, { undercurl = true ,sp = fg})
end

setDiagnosticHighlight('CocErrorHighlight', getHighlightAttr('CocErrorSign', 'fg#'))
setDiagnosticHighlight('CocWarningHighlight', getHighlightAttr('CocWarningSign', 'fg#'))
setDiagnosticHighlight('CocInfoHighlight', getHighlightAttr('CocInfoSign', 'fg#'))
setDiagnosticHighlight('CocHintHighlight', getHighlightAttr('CocHintSign', 'fg#'))
-- vim.api.nvim_set_hl(0, 'CocHighlightText', { bg = getHighlightAttr('Comment', 'fg#') })
-- vim.api.nvim_set_hl(0, 'CocHighlightText', {reverse = true})
vim.api.nvim_set_hl(0, 'CocSemClass', {link = 'Structure'})
vim.api.nvim_set_hl(0, 'GitLensText', {link = 'Comment'})
vim.api.nvim_set_hl(0, 'CursorLineNr', {ctermfg='yellow', fg='cyan'})
vim.api.nvim_set_hl(0, 'Folded', { reverse = true })


-- Customized coc syntax highlighting
if g.colors_name == 'onedark' then
  vim.fn['onedark#extend_highlight']('Function', {gui = 'Bold,Italic'})
  vim.fn['onedark#extend_highlight']('Constant', {gui = 'Italic'})
end

end

return M
