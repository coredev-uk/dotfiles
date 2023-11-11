return {

  -- Theme
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme carbonfox]]
    end,
  },

  --[[-------------------------------- 
  Language Servers
  ----------------------------------]]
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
      "nvim-lua/plenary.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("configs.copilot")
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    config = function ()
      require("copilot_cmp").setup()
    end
  },


  --[[-------------------------------- 
  Completions
  ----------------------------------]]
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("configs.cmp-nvim")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require"lsp_signature".setup(opts) end
  },
  "hrsh7th/vim-vsnip",
  { -- VSCode Icons for Completion
  "onsails/lspkind.nvim",
  lazy = true
},
--[[--------------------------------
Treesitter
----------------------------------]]
{
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  event = "BufRead",
  cmd = {
    "TSInstall",
    "TSInstallInfo",
    "TSInstallSync",
    "TSUninstall",
    "TSUpdate",
    "TSUpdateSync",
    "TSDisableAll",
    "TSEnableAll",
  },
  config = function()
    require("configs.treesitter")
  end,
  dependencies = {
    "p00f/nvim-ts-rainbow",
    "haringsrob/nvim_context_vt",
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("configs.colorizer")
      end,
    }
  }
},

--[[--------------------------------
Git
----------------------------------]]

"rhysd/git-messenger.vim",
{
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
        delay = 500,
        ignore_whitespace = false,
      },
    })
  end
},

--[[--------------------------------
Interface
----------------------------------]]

-- Better Notifications
{
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = require("notify")
  end
},

-- Telescope
{
  "nvim-telescope/telescope.nvim",
  config = function()
    require("configs.telescope")
  end,
  dependencies = "nvim-lua/plenary.nvim",
},

-- Bufferline
{
  "akinsho/bufferline.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  config = function()
    require("configs.bufferline")
  end
},

-- Statusline
{
  "nvim-lualine/lualine.nvim",
  config = function()
    require("configs.lualine")
  end,
},

-- File Explorer
{
  "kyazdani42/nvim-tree.lua",
  config = function()
    require("configs.tree")
  end,
},

--[[--------------------------------
Other
----------------------------------]]

-- Brackets and Quotes
"jiangmiao/auto-pairs",

-- Syntax highlighting and improved indentation for JS
"pangloss/vim-javascript",

-- Replacing surrounding stuff
"tpope/vim-surround",

-- Edit multiple lines at once
"mg979/vim-visual-multi",

-- Pretty Errors
"folke/trouble.nvim",

-- EditorConfig Support
"editorconfig/editorconfig-vim",

-- WhichKey
{
  "folke/which-key.nvim",
  config = function()
    require("configs.whichkey")
  end,
  lazy = true
},

-- Comments
{
  "b3nj5m1n/kommentary",
  config = function()
    require("configs.kommentary")
  end
},

-- Toggle Terminal
{
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup()

    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, 't', '<A-t>', [[<Cmd>ToggleTerm<CR>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  end
}

}
