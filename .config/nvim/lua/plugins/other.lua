local load = require("core.plugins").load

-- Main Stuff
load({{
    "numToStr/Comment.nvim",
    lazy = false
}, {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
                delay = 500,
                ignore_whitespace = false
            }
        })
    end
}, {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        require("configs.whichkey")
    end
}})

-- Simple Stuff
load({"rhysd/git-messenger.vim", "tpope/vim-surround", "folke/trouble.nvim", "editorconfig/editorconfig-vim"})
