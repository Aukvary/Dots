vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim", name = "which-key.nvim" },
})

require('which-key').setup({
    preset = "modern",
    win = {
        border = "single",
    },
    icons = {
        mappings = false,
    },
})
