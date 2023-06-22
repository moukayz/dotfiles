local g = vim.g

local M = {}
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-- plugin configs that need setting before plugin loaded
g.vimspector_enable_mappings = 'HUMAN'
g.coc_default_semantic_highlight_groups = 1

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- use 'nvim-tree/nvim-web-devicons' -- optional
  -- use 'nvim-tree/nvim-tree.lua'
  use 'szw/vim-maximizer'
  use 'sindrets/diffview.nvim'

  -- lua relative
  use 'milisims/nvim-luaref'
  use 'nvim-lua/plenary.nvim'

  use 'junegunn/vim-plug'
  use 'christoomey/vim-tmux-navigator'

  -- colorschemes
  -- use 'olimorris/onedarkpro.nvim'
  use 'morhetz/gruvbox'
  use 'dracula/vim'
  use 'junegunn/seoul256.vim'
  use 'joshdick/onedark.vim'
  use 'cocopon/iceberg.vim'
  use 'altercation/solarized'
  -- if has('nvim-0.5')
  --     use 'navarasu/onedark.nvim'
  -- else
  --     use 'joshdick/onedark.vim'
  -- endif
  use 'ayu-theme/ayu-vim'
  -- use 'sonph/onehalf', { 'rtp' : 'vim' }
  use 'sainnhe/sonokai'
  use 'sainnhe/everforest'

  -- snippets
  use 'honza/vim-snippets'

  -- tools
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }

  use 'junegunn/fzf.vim'
  use 'airblade/vim-rooter'
  use 'junegunn/vim-easy-align'   -- alianment operations
  use 'tpope/vim-surround'        -- surrounding operations
  use 'preservim/nerdcommenter'   -- auto comment with shortcut
  use 'justinmk/vim-sneak'        -- quick search based on first two chars

  -- display
  -- use 'Yggdroot/indentLine'
  use 'mhinz/vim-startify'   -- vim startup page
  -- use 'preservim/tagbar'              -- show code structure by using ctags
  use 'mtdl9/vim-log-highlighting'
  use 'machakann/vim-highlightedyank'   -- highlight yanked text
  use 'junegunn/goyo.vim'               -- concentrate only on text!
  use 'junegunn/limelight.vim'          -- highlight current paragraph
  use 'junegunn/vim-emoji'              -- get emoji from name
  -- use 'ryanoasis/vim-devicons'          -- awesome file icons
  -- use 'vim-airline/vim-airline-themes'
  -- use 'vim-airline/vim-airline'       -- just status line
  -- use 'itchyny/lightline.vim'
  if vim.fn.has('nvim-0.5') then
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
    -- use 'kyazdani42/nvim-web-devicons'
    -- use 'lukas-reineke/indent-blankline.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  end

  -- syntax highlighting
  -- use 'octol/vim-cpp-enhanced-highlight'
  use 'cespare/vim-toml'
  use 'junegunn/rainbow_parentheses.vim'
  use 'neovim/nvim-lspconfig'
  -- Not need anymore because coc-clangd and coc has builtin semantic highlight support
  -- use 'jackguo380/vim-lsp-cxx-highlight'

  -- use 'sheerun/vim-polyglot'
  -- use 'vim-syntastic/syntastic'
  use 'plasticboy/vim-markdown'

  -- use 'preservim/nerdtree'
  -- use 'Xuyuanp/nerdtree-git-plugin'

  -- git
  use 'tpope/vim-fugitive'
  use 'junegunn/gv.vim'
  -- use 'airblade/vim-gitgutter'
  use 'lewis6991/gitsigns.nvim'

  -- misc
  use 'easymotion/vim-easymotion'
  use 'vimwiki/vimwiki'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-unimpaired'

  -- code completion
  use { 'neoclide/coc.nvim', branch = 'release' }

  -- cheat.sh support for vim
  use 'dbeniamine/cheat.sh-vim'

  -- languages
  use 'dag/vim-fish'
  -- use 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }

  use 'puremourning/vimspector'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

  require('plenary.reload').reload_module(vim.g.custom_dir)
  require('nvim-web-devicons').setup()
  require('config.lualine')
  require('config.gitsigns')
  require("diffview").setup({
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
    git_cmd = { "git" },   -- The git executable followed by default args.
    hg_cmd = { "hg" },     -- The hg executable followed by default args.
    use_icons = true,      -- Requires nvim-web-devicons
    show_help_hints = false,
  })
end)
