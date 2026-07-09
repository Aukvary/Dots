vim.pack.add({
    { src = "https://github.com/folke/trouble.nvim", name = "trouble.nvim" },
})

require('trouble').setup({
    auto_close = false,
    auto_open = false,
    auto_preview = true,
    auto_refresh = true,
    focus = true,
    restore = true,
})
