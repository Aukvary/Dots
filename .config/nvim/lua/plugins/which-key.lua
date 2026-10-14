vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim", name = "which-key.nvim" },
})

require('which-key').setup({
    preset = {
        "modern",
        items = {
            ["<C-h>"] = { name = "Окно уже" },
            ["<C-l>"] = { name = "Окно шире" },
            ["<C-j>"] = { name = "Окно выше" },
            ["<C-k>"] = { name = "Окно ниже" },
        },
    },
    win = {
        border = "single",
    },
    icons = {
        mappings = false,
    },
})
