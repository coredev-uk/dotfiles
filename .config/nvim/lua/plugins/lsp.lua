local load = require("core.plugins").load

load({{
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "nvimtools/none-ls.nvim",
                    "nvim-lua/plenary.nvim", "jay-babu/mason-null-ls.nvim"},
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
    end
}, {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
    end
}, {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("configs.copilot")
    end
}, {
    "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    config = function()
        require("copilot_cmp").setup()
    end
}})
