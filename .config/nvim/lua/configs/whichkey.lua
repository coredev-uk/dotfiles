local wk = require("which-key")
local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

wk.setup()

wk.register({
  ["<leader>f"] = {
    name = "Find",
    f = { "<cmd>Telescope find_files<CR>", "Find files" },
    g = { "<cmd>Telescope live_grep<CR>", "Live grep" },
    r = { "<cmd>Telescope oldfiles<CR>", "Open recent files" },
  },
})

