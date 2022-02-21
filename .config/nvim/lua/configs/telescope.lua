local M = {}



function M.config()
	local actions = require("telescope.actions")

	require('telescope').setup{
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			mappings = {
				i = {
					["<A-p>"] = actions.close,
					["<esc>"] = actions.close
				}
			}
		},
		pickers = {
			find_files = {
			}
		},
		extensions = {
		}
	}


end


function M.project_files()
	local opts = {} -- define here if you want to define something
	local ok = pcall(require"telescope.builtin".git_files, opts)
	if not ok then require"telescope.builtin".find_files(opts) end
end


return M
