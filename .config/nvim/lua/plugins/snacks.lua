vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim", name = "snacks.nvim" },
})

require('snacks').setup({
    bigfile = { enabled = true },
    dashboard = { enabled = false }, -- единственный dashboard — alpha.nvim
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = false }, -- уведомления — noice.nvim
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
        notification = {
            wo = { wrap = true }
        }
    }
})