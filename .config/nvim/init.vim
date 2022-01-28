"set autoindent
set expandtab
set tabstop=4 sw=4
set termguicolors

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

let path = '~/.config/nvim/config/'
exec 'source' path . 'mappings.vim'
exec 'source' path . 'plugins.vim'

let g:numbers_exclude = ['NvimTree']
lua require('init')
