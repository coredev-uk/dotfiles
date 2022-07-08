local M = {}

function M.config()
	local g = vim.g

	-- g.nvim_tree_git_hl = git_status
	require'nvim-tree'.setup {
		disable_netrw       = true,
		hijack_netrw        = true,
		open_on_setup       = true,
		ignore_ft_on_setup  = {},
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
		renderer = {
			group_empty = true,
			add_trailing = false,
			highlight_opened_files = "all",
			root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
			icons = {
				show = {
					folder = true,
					file = true,
					folder_arrow = true
				},
				glyphs = {
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
			}
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

	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	-- from nvim-tree readme: autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
	-- https://neovim.io/doc/dev/api_2autocmd_8c.html#a4bf35800481959bb8583e9593a277eb7
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = { "*" },
		nested = true,
		callback = function()
			if vim.fn.winnr "$" == 1 and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr() then
				vim.api.nvim_command ":silent qa!"
			end
		end,
	})
end

return M
