local o = vim.o
local g = vim.g
local opt = vim.opt
local gv = vim.g
local api = vim.api

local M = {}
function FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  if line:sub(1, 1) == ' ' then
    line = '▸' .. line:sub(2)
  end
  return line .. ' ...'
end

local function reloadVimCallback(params)
  local fname, ft = params.file:match('([^/]*)%.(.*)$')
  if (ft == 'lua') then
    local module_name = gv.custom_dir .. '.' .. fname
    -- require('plenary.reload').reload_module(module_name)
    dofile(params.file)
    -- local m = require(module_name)
    -- if m ~= nil and m.setup then
    --   vim.cmd('echom "' .. module_name .. ' module setup!"')
    --   m.setup()
    -- end
  elseif (ft == 'vim') then
    vim.cmd('source ' .. params.file)
  end
  vim.cmd('echom "' .. params.file .. ' reloaded!"')
end

function M.setup()
  gv.mapleader = '\\'
  gv.python3_host_prog = '/usr/local/bin/python3'
  gv.custom_dir = 'config'

  -- -- disable netrw at the very start of your init.lua
  -- g.loaded_netrw = 1
  -- g.loaded_netrwPlugin = 1

  opt.rtp:append('/home/linuxbrew/.linuxbrew/opt/fzf')
  opt.clipboard:append('unnamedplus')
  opt.diffopt:append {'indent-heuristic', 'linematch:60'}
  o.swapfile = false
  o.shell = '/bin/bash'
  o.guifont = "mononoki Nerd Font Mono:h14"
  o.mouse = ""
  o.termguicolors = true
  o.background = 'dark'
  o.tabstop = 4
  o.softtabstop = 4
  o.shiftwidth = 4
  o.expandtab = true
  o.smarttab = true
  o.autoindent = true
  o.incsearch = true
  o.ignorecase = true
  o.smartcase = true
  o.hlsearch = true
  o.ruler = true
  o.laststatus = 3
  o.showcmd = true
  o.wrap = true
  o.breakindent = true
  o.encoding = 'utf-8'
  o.title = true
  o.number = true
  o.relativenumber = true
  o.cursorline = true
  o.showmatch = true
  o.autoread = true
  o.splitbelow = true
  o.splitright = true
  o.exrc = true
  o.list = true
  o.listchars = 'tab:›\\ ,trail:-,space:⋅'
  o.colorcolumn = '+1,+2' 
  o.scrolloff = 3
  o.showtabline = 2
  o.pumheight = 10
  o.pumwidth = 10
  o.pumblend = 15
  o.jumpoptions = 'stack'
  o.autowrite = true

  gv.vimsyn_folding = 'af'
  o.foldlevel = 5
  o.foldmethod = 'syntax'
  o.foldtext = 'v:lua.FoldText'
  opt.fillchars = {
    vert = "│",
    fold = "⠀",
    eob = " ", -- suppress ~ at EndOfBuffer
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
  }

  vim.cmd([[
    filetype plugin indent on
    syntax on
  ]])

  api.nvim_create_augroup("ReloadVim", {})
  api.nvim_create_autocmd("BufWritePost", {
    group = "ReloadVim",
    -- pattern = { vim.fn.expand("~") .. "/.config/nvim/**.vim", "~/.vimrc" },
    pattern = { vim.env.VIM_CONFIG_DIR .. "/**.vim", vim.env.VIM_CONFIG_DIR .. "/**.lua", "~/.vimrc" },
    nested = true,
    callback = reloadVimCallback
  })
  vim.notify('Reload basic lua', vim.log.levels.INFO)
end

return M
-- return M
