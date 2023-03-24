local nnoremap = require('core.keymap').nnoremap
local xnoremap = require('core.keymap').xnoremap

-- Telescope
vim.g.AutoPairsShortcutToggle = '<Nul>'
nnoremap("<A-p>", "<cmd>Telescope find_files<CR>")
nnoremap("<A-f>", "<cmd>Telescope live_grep<CR>")
nnoremap("<A-o>", "<cmd>Telescope packer<CR>")

-- Bufferline
nnoremap("<A-Left>", "<cmd>BufferLineCyclePrev<CR>")
nnoremap("<A-Right>", "<cmd>BufferLineCycleNext<CR>")
nnoremap("<A-S-Left>", "<cmd>BufferLineMovePrev<CR>")
nnoremap("<A-S-Right>", "<cmd>BufferLineMoveNext<CR>")
nnoremap("<A-c>", "<cmd>bdelete<CR>")
nnoremap("<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>")
nnoremap("<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
nnoremap("<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
nnoremap("<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
nnoremap("<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
nnoremap("<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
nnoremap("<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
nnoremap("<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
nnoremap("<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>")

nnoremap("<leader>cic", "<Plug>kommentary_line_increase")
nnoremap("<leader>ci", "<Plug>kommentary_motion_increase")
xnoremap("<leader>ci", "<Plug>kommentary_visual_increase")
nnoremap("<leader>cdc", "<Plug>kommentary_line_decrease")
xnoremap("<leader>cd", "<Plug>kommentary_motion_decrease")
xnoremap("<leader>cd", "<Plug>kommentary_visual_decrease")

-- Nvim NvimTreeToggle
nnoremap("<A-m>", "<cmd>NvimTreeToggle<CR>")
nnoremap("<leader>trf", "<cmd>NvimTreeRefresh<CR>")

-- Move Lines
nnoremap("<A-j>", "<cmd>m +1<CR>")
nnoremap("<A-k>", "<cmd>m -2<CR>")

-- Terminal
nnoremap("<A-t>", "<cmd>ToggleTerm<CR>")

-- Diagnostics
nnoremap("<A-d>", "<cmd>TroubleToggle<CR>")

-- Symbols
nnoremap("<A-s>", "<cmd>SymbolsOutline<CR>")

-- Harpoon
nnoremap("<leader>a", function() require("harpoon.mark").add_file() end)
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end)
nnoremap("<leader>tc", function() require("harpoon.cmd-ui").toggle_quick_menu() end)

nnoremap("<C-h>", function() require("harpoon.ui").nav_file(1) end)
nnoremap("<C-t>", function() require("harpoon.ui").nav_file(2) end)
nnoremap("<C-n>", function() require("harpoon.ui").nav_file(3) end)
nnoremap("<C-s>", function() require("harpoon.ui").nav_file(4) end)
