""" Install plugins
" auto install vim-plug if it not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
let plug_vim_path = data_dir . '/autoload/plug.vim'
if empty(glob(plug_vim_path))
    silent execute '!curl -fLko ' . plug_vim_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! if plug#begin()
    " My own plugins
    " Plug 'moukayz/coc-yztest', {'do': 'yarn install --frozen-lockfile && yarn build'}

    " lua relative
    Plug 'milisims/nvim-luaref'
    Plug 'nvim-lua/plenary.nvim'

    Plug 'junegunn/vim-plug'
    Plug 'christoomey/vim-tmux-navigator'

    " colorschemes
    " Plug 'olimorris/onedarkpro.nvim'
    Plug 'morhetz/gruvbox'
    Plug 'dracula/vim'
    Plug 'junegunn/seoul256.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'cocopon/iceberg.vim'
    Plug 'altercation/solarized'
    " if has('nvim-0.5')
    "     Plug 'navarasu/onedark.nvim'
    " else
    "     Plug 'joshdick/onedark.vim'
    " endif
    Plug 'ayu-theme/ayu-vim'
    " Plug 'sonph/onehalf', { 'rtp' : 'vim' }
    Plug 'sainnhe/sonokai'
    Plug 'sainnhe/everforest'

    " snippets
    Plug 'honza/vim-snippets'

    " tools
    Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/vim-easy-align' " alianment operations
    Plug 'tpope/vim-surround'      " surrounding operations
    Plug 'preservim/nerdcommenter' " auto comment with shortcut
    Plug 'justinmk/vim-sneak'      " quick search based on first two chars

    " display
    " Plug 'Yggdroot/indentLine'
    Plug 'mhinz/vim-startify'            " vim startup page
    Plug 'preservim/tagbar'              " show code structure by using ctags
    Plug 'mtdl9/vim-log-highlighting'
    Plug 'machakann/vim-highlightedyank' " highlight yanked text
    Plug 'junegunn/goyo.vim'             " concentrate only on text!
    Plug 'junegunn/limelight.vim'        " highlight current paragraph
    Plug 'junegunn/vim-emoji'            " get emoji from name
    Plug 'ryanoasis/vim-devicons'        " awesome file icons
    " Plug 'vim-airline/vim-airline-themes'
    " Plug 'vim-airline/vim-airline'       " just status line
    " Plug 'itchyny/lightline.vim'
    if has('nvim-0.5')
        Plug 'nvim-lualine/lualine.nvim'
        Plug 'kyazdani42/nvim-web-devicons'
        " Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    endif

    " syntax highlighting
    " Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'cespare/vim-toml'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'neovim/nvim-lspconfig'
    " Not need anymore because coc-clangd and coc has builtin semantic highlight support
    " Plug 'jackguo380/vim-lsp-cxx-highlight'

    " Plug 'sheerun/vim-polyglot'
    " Plug 'vim-syntastic/syntastic'
    Plug 'plasticboy/vim-markdown'

    " Plug 'preservim/nerdtree'
    " Plug 'Xuyuanp/nerdtree-git-plugin'

    " git
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    " Plug 'airblade/vim-gitgutter'
    Plug 'lewis6991/gitsigns.nvim'

    " misc
    Plug 'easymotion/vim-easymotion'
    Plug 'vimwiki/vimwiki'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-unimpaired'

    " code completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " cheat.sh support for vim
    Plug 'dbeniamine/cheat.sh-vim'

    " languages
    Plug 'dag/vim-fish'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }

    " Plug 'wikitopian/hardmode'

    call plug#end()
endif

lua << EOF
---require('gitlens').setup()
require('config.lualine')
require('config.gitsigns')
EOF
