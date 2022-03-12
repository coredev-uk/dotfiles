local M = {}

function M.config()

	require('bufferline').setup {
		options = {
			offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}},
		}
	}


end

return M
