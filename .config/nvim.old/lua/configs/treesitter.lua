require('nvim-treesitter.configs').setup {
  auto_install = true,
  sync_install = false,
	rainbow = {
		colors = {
			"#ABDEE6",
			"#CBAACB",
			"#FFFFB5",
			"#FFCCB6",
			"#F3B0C3"
		}
	},
	--   -- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = "all",
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		additional_vim_regex_highlighting = true,
	},
}
