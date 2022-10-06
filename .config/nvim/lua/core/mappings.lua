local nnoremap = require('core.keymap').nnoremap
local opts = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

-- Telescope
vim.g.AutoPairsShortcutToggle = '<Nul>'
map("n", "<A-p>", "<cmd>Telescope find_files<CR>", opts)
map("n", "<A-f>", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<A-o>", "<cmd>Telescope packer<CR>", opts)

-- Bufferline
map("n", "<A-Left>", "<cmd>BufferLineCyclePrev<CR>", opts)
map("n", "<A-Right>", "<cmd>BufferLineCycleNext<CR>", opts)
map("n", "<A-S-Left>", "<cmd>BufferLineMovePrev<CR>", opts)
map("n", "<A-S-Right>", "<cmd>BufferLineMoveNext<CR>", opts)
map("n", "<A-c>", "<cmd>bdelete<CR>", opts)
map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", opts)
map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", opts)
map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", opts)
map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", opts)
map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", opts)
map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", opts)
map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", opts)
map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", opts)

-- Nvim NvimTreeToggle
map("n", "<A-m>", "<cmd>NvimTreeToggle<CR>", opts)

-- Toggle term
map("n", "<A-t>", "<cmd>ToggleTerm<CR>", opts)

-- Move Lines
map("n", "<A-j>", "<cmd>m +1<CR>", opts)
map("n", "<A-k>", "<cmd>m -2<CR>", opts)

-- Diagnostics
map("n", "<A-d>", "<cmd>TroubleToggle<CR>", opts)
--map("n", "<A-Left>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
--map("n", "<A-Right>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

-- Harpoon
nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, silent)
nnoremap("<leader>tc", function() require("harpoon.cmd-ui").toggle_quick_menu() end, silent)

nnoremap("<C-h>", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<C-t>", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<C-n>", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<C-s>", function() require("harpoon.ui").nav_file(4) end, silent)
