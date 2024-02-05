local load = require("core.plugins").load

load({{
    "hrsh7th/nvim-cmp",
    config = function()
        require("configs.cmp-nvim")
    end,
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-path"}
}, {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
        require"lsp_signature".setup(opts)
    end
}, "hrsh7th/vim-vsnip", { -- VSCode Icons for Completion
    "onsails/lspkind.nvim",
    lazy = true
}, {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    cmd = {"TSInstall", "TSInstallInfo", "TSInstallSync", "TSUninstall", "TSUpdate", "TSUpdateSync", "TSDisableAll",
           "TSEnableAll"},
    config = function()
        require("configs.treesitter")
    end,
    dependencies = {"p00f/nvim-ts-rainbow", "haringsrob/nvim_context_vt", {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("configs.colorizer")
        end
    }}
}})
