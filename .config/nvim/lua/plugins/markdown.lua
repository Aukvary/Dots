vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
	-- Иконки: render-markdown сам подхватит nvim-web-devicons (уже ставится для neo-tree)
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown.nvim" },
})
require("render-markdown").setup({})
