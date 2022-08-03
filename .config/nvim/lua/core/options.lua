local M = {}
local set = vim.opt

set.autoindent = true
set.expandtab = false
set.tabstop=4
set.shiftwidth=4
set.clipboard="unnamedplus"
set.ignorecase = true
--set.mouse="a"
set.smartindent = true
set.relativenumber = false
set.number = true
set.nu = true
--set.cursorline = true
set.termguicolors = true
set.background = 'dark'
--set foldmethod=expr
--set foldexpr=nvim_treesitter#foldexpr()
vim.g.vimsyn_embed = '1'

return M

