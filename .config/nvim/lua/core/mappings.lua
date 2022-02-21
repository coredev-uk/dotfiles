local M = {}

local opts = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

-- Telescope
vim.g.AutoPairsShortcutToggle = '<Nul>'
map("n", "<A-p>", "<cmd>lua require('configs/telescope').project_files()<CR>", opts)
map("n", "<A-f>", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<A-o>", "<cmd>Telescope packer<CR>", opts)

-- Bufferline
map("n", "<A-,>", "<cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<cmd>BufferNext<CR>", opts)
map("n", "<A-c>", "<cmd>BufferClose<CR>", opts)
map("n", "<A-1>", "<cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<cmd>BufferGoto 9<CR>", opts)

-- Nvim NvimTreeToggle
map("n", "<A-m>", "<cmd>lua require('configs/tree').toggle_tree()<CR>", opts)

-- Toggle term
map("n", "<A-t>", "<cmd>ToggleTerm<CR>", opts)

-- Move Lines
map("n", "<A-Down>", "<cmd>m +1<CR>", opts)
map("n", "<A-Up>", "<cmd>m -2<CR>", opts)

-- Diagnostics
map("n", "<A-d>", "<cmd>TroubleToggle<CR>", opts)
map("n", "<A-Left>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "<A-Right>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

return M


