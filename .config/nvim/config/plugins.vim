" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Github copilot
"Plug 'github/copilot.vim'

" LSP "
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" lualine " 
Plug 'nvim-lualine/lualine.nvim'

" Material Theme "
Plug 'marko-cerovac/material.nvim'

" Lines "
Plug 'myusuf3/numbers.vim'

" NeoVim Telescope "
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Tab Line and Icons "
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" File Browser "
Plug 'kyazdani42/nvim-tree.lua'

" Tree Sitter "
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Tree Sitter Context "
Plug 'haringsrob/nvim_context_vt'

" Terminal "
Plug 'akinsho/toggleterm.nvim'

"Git Stuff"
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'

" JS "
Plug 'pangloss/vim-javascript'

" Useful Development Plugins "
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'vuki656/package-info.nvim'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Initialize plugin system
call plug#end()


