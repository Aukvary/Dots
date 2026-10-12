vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" },
	{ src = "https://github.com/epwalsh/obsidian.nvim", name = "obsidian.nvim" },
})

local obsidian = require("obsidian")

obsidian.setup({
	workspaces = {
		{
			name = "AuObs",
			path = "~/stuff/AuObs",
		},
	},
	ui = {
		enable = false,
	},
})
