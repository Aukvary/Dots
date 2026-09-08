vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/happyeric77/joplin.nvim",      name = "joplin.nvim" },
})

local joplin = require('joplin')

joplin.setup({
    port = 41184,
    token = "ВАШ_ТОКЕН_ИЗ_JOPLIN_WEB_CLIPPER",
    auto_sync = true,
})

vim.keymap.set('n', '<leader>jt', '<cmd>JoplinTree<cr>', { desc = "Toggle Joplin Tree" })
vim.keymap.set('n', '<leader>jf', '<cmd>JoplinFind<cr>', { desc = "Search Joplin Notes" })
