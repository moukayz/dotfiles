local utils = require('config.utils')
local maps = {
  { 'n', 'lhs',               'function() print("real lua function") end' },
  { 'n', '<leader>ps',        '<cmd>PackerStatus<cr>' },
  -- basic map
  { 'n', 'leader>q ',         ':q!<CR>' },
  { 'n', 'leader><leader>q ', ':qall!<CR>' },
  { 'n', 'leader>w ',         ':w<CR>' },
  { 'n', 'leader><leader>w ', ':wall<CR>' },
  { 'n', '<Esc><Esc>',        ':nohlsearch<CR>' },
  { 'n', '<leader>.',         '<cmd>tabe   $MYVIMRC<CR>',                 { silent = true } },
  { 'n', '<leader>ri',        '<cmd>source $MYVIMRC | redraw | e<CR>',    { silent = true } }
}
utils.addKeymap(maps)
