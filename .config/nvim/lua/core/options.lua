local set = vim.opt
local g = vim.g

set.autoindent = true
set.expandtab = true
set.tabstop=2
set.softtabstop=2
set.shiftwidth=2
set.clipboard="unnamedplus"
set.ignorecase = true
set.mouse="a"
set.smartindent = true
set.smarttab = true
set.relativenumber = true
set.number = true
set.nu = true
set.cursorline = true
set.termguicolors = true
set.background = 'dark'
--set foldmethod=expr
--set foldexpr=nvim_treesitter#foldexpr()
g.mapleader = " "
-- disable netrw at the very start of your init.lua
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1


return {}
