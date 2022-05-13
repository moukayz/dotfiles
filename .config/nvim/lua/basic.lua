local o = vim.o
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
  vim.cmd('source ' .. params.file)
  vim.cmd('echom "' .. params.file .. ' reloaded!"')
end

function M.setup()
  gv.mapleader = '\\'
  gv.python3_host_prog = '/usr/bin/python3'
  gv.loaded_python_provider = 0

  opt.rtp:append('/home/linuxbrew/.linuxbrew/opt/fzf')
  opt.clipboard:append('unnamedplus')
  o.shell = '/bin/bash'
  o.guifont = "mononoki Nerd Font Mono:h14"
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
  o.colorcolumn = 120
  o.scrolloff = true
  o.showtabline = 2
  o.pumheight = 10
  o.pumwidth = 10
  o.pumblend = 15
  o.jumpoptions = 'stack'

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
    pattern = { "~/.config/nvim/**.vim", "~/.vimrc" },
    nested = true,
    callback = reloadVimCallback
  })
end

return M
