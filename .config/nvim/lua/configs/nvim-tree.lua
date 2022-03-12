local M = {}

function M.config()
	local g = vim.g

	g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
	-- g.nvim_tree_git_hl = git_status
	g.nvim_tree_highlight_opened_files = 0
	g.nvim_tree_indent_markers = 1
	g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

	g.nvim_tree_show_icons = {
		folders = 1,
		files = 1,
		git = 1,
	}

	g.nvim_tree_icons = {
		default = "",
		symlink = "",
		git = {
			deleted = "",
			ignored = "◌",
			renamed = "➜",
			staged = "✓",
			unmerged = "",
			unstaged = "✗",
			untracked = "*",
		},
		folder = {
			default = "",
			empty = "",
			empty_open = "",
			open = "",
			symlink = "",
			symlink_open = "",
		},
	}
	require'nvim-tree'.setup {
		disable_netrw       = true,
		hijack_netrw        = true,
		open_on_setup       = true,
		ignore_ft_on_setup  = {},
		auto_close          = false,
		open_on_tab         = false,
		hijack_cursor        = false,
		update_cwd           = false,
		hijack_unnamed_buffer_when_opening = false,
		hijack_directories   = {
			enable = true,
			auto_open = true,
		},
		diagnostics = {
			enable = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			}
		},
		update_focused_file = {
			enable      = false,
			update_cwd  = false,
			ignore_list = {}
		},
		system_open = {
			cmd  = nil,
			args = {}
		},
		filters = {
			dotfiles = false,
			custom = {}
		},
		git = {
			enable = true,
			ignore = true,
			timeout = 500,
		},
		view = {
			width = 30,
			height = 30,
			hide_root_folder = false,
			side = "left",
			preserve_window_proportions = false,
			mappings = {
				custom_only = false,
				list = {}
			},
			number = false,
			relativenumber = false,
			signcolumn = "yes"
		},
		trash = {
			cmd = "trash",
			require_confirm = true
		},
		actions = {
			change_dir = {
				enable = true,
				global = false,
			},
			open_file = {
				quit_on_open = true,
				resize_window = false,
				window_picker = {
					enable = true,
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
						buftype  = { "nofile", "terminal", "help", },
					}
				}
			}
		},
		log = {
			enable = false,
			types = {
				all = false,
				config = false,
				git = false,
			},
		},
	}
end

return M
