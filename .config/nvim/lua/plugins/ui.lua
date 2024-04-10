local load = require("core.plugins").load

load({{
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("carbonfox")
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
}, {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = require("notify")
    end
}, {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim"
}, {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
        require("configs.bufferline")
    end
}, {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("configs.lualine")
    end
}, {
    "kyazdani42/nvim-tree.lua",
    config = function()
        require("configs.tree")
    end
}

})
