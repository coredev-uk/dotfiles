set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set ignorecase
set mouse=a
set smartindent
set relativenumber
set cursorline
"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()
syntax on

if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
	set termguicolors
endif

let path = '~/.config/nvim/config/'
exec 'source' path . 'mappings.vim'
exec 'source' path . 'plugins.vim'

lua require ('init')
lua vim.notify = require('notify')
lua require'colorizer'.setup()

" Theme Setup "
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "Telescope" ]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:tokyonight_colors = {
	\ 'hint': 'orange',
	\ 'error': '#ff0000'
\ }

colorscheme tokyonight

set completeopt=menuone,noselect
