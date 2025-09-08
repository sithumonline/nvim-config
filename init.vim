" enables syntax highlighting
syntax on

" Better colors
set termguicolors

" Leader keys early
let mapleader = " "
let maplocalleader = " "

" Improve UX and integration
set clipboard=unnamedplus
set signcolumn=yes
set updatetime=200
set timeoutlen=400
set splitkeep=screen
set cursorline
set relativenumber
set nowrap

" Completion menu behavior (for nvim-cmp)
set completeopt=menu,menuone,noselect
set pumheight=10

" Don’t auto-continue comments when hitting o/O or Enter
set formatoptions-=cro

" number of spaces in a <Tab>
set tabstop=4
set softtabstop=4
set expandtab

" enable autoindents
set smartindent

" number of spaces used for autoindents
set shiftwidth=4

" adds line numbers
set number

" columns used for the line number
set numberwidth=4

" highlights the matched text pattern when searching
set incsearch
set nohlsearch

" open splits intuitively
set splitbelow
set splitright

" navigate buffers without losing unsaved work
set hidden

" start scrolling when 8 lines from top or bottom
set scrolloff=8

" Save undo history
set undofile

" Enable mouse support
set mouse=a

" case insensitive search unless capital letters are used
set ignorecase
set smartcase

" Simple, handy keymaps
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

call plug#begin('~/.config/nvim/plugged')

" plugins will go here

Plug 'gruvbox-community/gruvbox'
" High-contrast, LSP-friendly theme
Plug 'folke/tokyonight.nvim'

" Telescope requires plenary to function
Plug 'nvim-lua/plenary.nvim'
" The main Telescope plugin
Plug 'nvim-telescope/telescope.nvim'
" An optional plugin recommended by Telescope docs
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }

Plug 'neovim/nvim-lspconfig'

" (optional) autocompletion:
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

call plug#end()

lua require('sithumonline/telescope')
lua require('sithumonline/lsp_go')
lua require('sithumonline/cmp')

" Use this for dark color schemes and load theme config
set background=dark
lua require('sithumonline/colors')

