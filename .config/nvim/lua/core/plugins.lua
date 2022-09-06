-- Bootstrapping Functions
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
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
	use {
		'wbthomason/packer.nvim'
	}

	use {
		'nvim-telescope/telescope-packer.nvim',
		after = 'telescope.nvim',
		config = function()
			require('telescope').load_extension('packer')
		end
	}

	-- builtin lsp
	use {
		'neovim/nvim-lspconfig',
		'williamboman/nvim-lsp-installer'
	}

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
			require('configs.cmp-nvim').config()
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
		requires = {
			-- Snippet collections
			'rafamadriz/friendly-snippets',
		},
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
			require('configs.treesitter').config()
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

	-- Git intergration
	use {
		'tanvirtin/vgit.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('configs.vgit')
		end
	}

	-- Fugitive (Git Wrapper for Vim)
	use 'tpope/vim-fugitive'

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


	-- Better quick fix
	use 'kevinhwang91/nvim-bqf'

	-- File finder
	use {
		'nvim-telescope/telescope.nvim',
		config = function()
			require('configs.telescope').config()
		end
	}

	-- Bufferline
	use {
		'akinsho/bufferline.nvim',
		tag = "v2.*",
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('configs.bufferline').config()
		end
	}

	-- Statusline
	use {
		'nvim-lualine/lualine.nvim',
		after = 'bufferline.nvim',
		config = function()
			require('configs.lualine').config()
		end,
	}

	-- File explorer
	use {
		'kyazdani42/nvim-tree.lua',
		config = function()
			require('configs.nvim-tree').config()
		end,
	}

	-- Colour Scheme
	use {
		'folke/tokyonight.nvim',
		config = function()
			vim.g.tokyonight_style = "night"
			vim.g.tokyonight_italic_functions = 1
			vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "Telescope" }
			vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
			vim.cmd [[colorscheme tokyonight]]
		end,
	}

	-- Better Colors for various elements
	use 'folke/trouble.nvim'


	-- Icons
	use 'kyazdani42/nvim-web-devicons'

	-- Terminal
	use {
		'akinsho/toggleterm.nvim',
		tag = 'v1.*',
		cmd = 'ToggleTerm',
		config = function()
			require("configs.toggleterm").config()
		end
	}

	use 'github/copilot.vim'

	-- Bootstrapping
	if packer_bootstrap then
		require('packer').sync()
	end
end)
