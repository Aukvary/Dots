vim.pack.add({
	{ src = "https://github.com/tpope/vim-dadbod" },
	{ src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
	{ src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
})

vim.g.db_ui_use_nerd_fonts = 1

vim.g.db_ui_save_location = vim.fn.getcwd() .. "/postgres-queries"

vim.g.db_ui_disable_mappings_sql = 1
