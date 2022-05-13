local fn = vim.fn

local data_dir = fn.has('nvim') and fn.stdpath('data') .. '/site' or '~/.vim'
local vp_path = data_dir .. '/autoload/plug.vim'
local install_vp_cmd
if fn.empty(fn.glob(vp_path)) then
  
end
