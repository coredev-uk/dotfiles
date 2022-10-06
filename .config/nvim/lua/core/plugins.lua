-- Bootstrapping Functions
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end


local packer_status_ok = pcall(require, 'packer')
if not packer_status_ok then
  return
end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])


return require('packer').startup(function(use)

  -- Plugin manger
  use 'wbthomason/packer.nvim'


  -- Finder
  use {
    'nvim-telescope/telescope-packer.nvim',
    after = 'telescope.nvim',
    config = function()
      require('telescope').load_extension('packer')
    end
  }

  -- builtin lsp
  use(
    {
      'williamboman/mason.nvim',
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
      end,
      requires = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig'
      }
    },
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig'
  )

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("configs.nullls")
    end,
  })

  -- nerdy shit
  use("ThePrimeagen/git-worktree.nvim")

  use {
    'ThePrimeagen/harpoon',
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('configs.cmp-nvim')
    end,
  }

  -- LSP completion source
  use {
    'hrsh7th/cmp-nvim-lsp',
  }

  -- Buffer completion source
  use {
    'hrsh7th/cmp-buffer',
    after = 'nvim-cmp',
  }

  -- Path completion source
  use {
    'hrsh7th/cmp-path',
    after = 'nvim-cmp',
  }

  -- Command line completion source
  use {
    'hrsh7th/cmp-cmdline',
    after = 'nvim-cmp',
  }

  -- LSP signature
  use {
    'ray-x/lsp_signature.nvim',
    after = 'nvim-cmp',
  }

  -- Snippet engine
  use {
    'hrsh7th/vim-vsnip',
  }

  -- Snippet completion source
  use {
    'hrsh7th/cmp-vsnip',
    after = 'nvim-cmp',
  }

  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = 'BufRead',
    cmd = {
      'TSInstall',
      'TSInstallInfo',
      'TSInstallSync',
      'TSUninstall',
      'TSUpdate',
      'TSUpdateSync',
      'TSDisableAll',
      'TSEnableAll',
    },
    config = function()
      require('configs.treesitter')
    end,
    requires = {
      {
        -- Parenthesis highlighting
        'p00f/nvim-ts-rainbow',
        after = 'nvim-treesitter',
      },
      {
        'haringsrob/nvim_context_vt',
        after = 'nvim-treesitter',
      }
    },
  }

  -- Auto Pairs (Brackets and Stuff)
  use 'jiangmiao/auto-pairs'

  -- Git Messenger(Shows origin of code)
  use 'rhysd/git-messenger.vim'

  -- Development Plugins
  use 'pangloss/vim-javascript' -- Syntax highlighting and improved indentation for JS
  use 'tpope/vim-surround' -- Replacing surrounding stuff
  use 'mg979/vim-visual-multi' -- Edit multiple lines at once
  use {
    'vuki656/package-info.nvim',
    requires = {
      'MunifTanjim/nui.nvim'
    },
    config = function()
      require('configs.package-info')
    end
  } -- Package.json Information

  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('configs.kommentary')
    end
  } -- Commentsss


  -- Notifications
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
    end
  }

  -- Highlight colours
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('configs.colorizer')
    end,
    after = 'nvim-treesitter'
  }

  -- File finder
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('configs.telescope')
    end
  }

  -- Bufferline
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('configs.bufferline')
    end
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    after = 'bufferline.nvim',
    config = function()
      require('configs.lualine')
    end,
  }

  -- File explorer
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("configs.tree")
    end,
  })

  -- Colour Scheme
  use {
    'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      })

      vim.cmd [[colorscheme tokyonight-night]]
    end,
  }

  -- Better Colors for various elements
  use 'folke/trouble.nvim'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Terminal
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup()

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, 't', '<A-t>', [[<Cmd>ToggleTerm<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    end
  }

  use 'github/copilot.vim'

  -- Bootstrapping
  if packer_bootstrap then
    require('packer').sync()
  end
end)
