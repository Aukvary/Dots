vim.pack.add({
    { src = "https://github.com/folke/todo-comments.nvim", name = "todo-comments.nvim" },
})

require('todo-comments').setup({
    signs = true,
    merge_keywords = true,
    highlight = {
        multiline = true,
        bg = "BACKGROUND",
        fg = "TEXT",
    },
})
