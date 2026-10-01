local km_set = vim.keymap.set

local opts = { noremap = true, silent = true }
vim.keymap.set('i', '<C-j>', '<Down>', opts)
vim.keymap.set('i', '<C-k>', '<Up>', opts)
vim.keymap.set('i', '<C-h>', '<Left>', opts)
vim.keymap.set('i', '<C-l>', '<Right>', opts)

km_set("n", "<leader>db", "<Cmd>DBUIToggle<CR>")
km_set("n", "<leader>df", "<Cmd>DBUIFindBuffer<CR>")
km_set("n", "<leader>da", "<Cmd>DBUIAddConnection<CR>")

km_set("n", "<leader>rq", "<Cmd>%DB<CR>")
km_set("n", "<leader>r", "<Plug>(db-execute-op)")
km_set("v", "<leader>r", "<Plug>(db-execute)")

km_set("n", "<leader>fS", function()
    require("conform").format({ async = true, lsp_fallback = true })
end)

-- Переход к предыдущей ошибке
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Прыжок к предыдущей ошибке" })

-- Переход к следующей ошибке
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Прыжок к следующей ошибке" })
vim.keymap.set('n', '<leader>o', vim.diagnostic.setloclist)

km_set('n', '<Esc>', '<cmd>nohlsearch<CR>')

km_set("n", "<leader>e", "<Cmd>Neotree focus<CR>")
km_set("n", "<leader>E", "<Cmd>Neotree close<CR>")
km_set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")

km_set("n", "<leader>s", "<Cmd>w<CR>")
km_set("n", "<leader>q", "<Cmd>q<CR>")

km_set('n', '<M-v>', '<C-v>')
local fzf = require('fzf-lua')

km_set("n", "<leader><leader>", fzf.files)
km_set("n", "<leader>fg", fzf.live_grep)
km_set("n", "<leader>fb", fzf.buffers)
km_set("n", "<leader>fh", fzf.help_tags)
km_set("n", "<leader>fs", fzf.git_status)
km_set("n", "<leader>fr", fzf.oldfiles)

local gs = require('gitsigns')

km_set("n", "]c", function()
    if vim.wo.diff then return "]c" end
    vim.schedule(function() gs.next_hunk() end)
    return "<Ignore>"
end, { expr = true })

km_set("n", "[c", function()
    if vim.wo.diff then return "[c" end
    vim.schedule(function() gs.prev_hunk() end)
    return "<Ignore>"
end, { expr = true })

km_set("n", "<leader>hs", gs.stage_hunk)
km_set("n", "<leader>hr", gs.reset_hunk)
km_set("n", "<leader>hS", gs.stage_buffer)
km_set("n", "<leader>hu", gs.undo_stage_hunk)
km_set("n", "<leader>hR", gs.reset_buffer)
km_set("n", "<leader>hp", gs.preview_hunk)
km_set("n", "<leader>hb", function() gs.blame_line { full = true } end)
km_set("n", "<leader>hd", gs.diffthis)

km_set("n", "<leader>cm", "<Cmd>Mason<CR>")

km_set("n", "gd", vim.lsp.buf.definition, opts)
km_set("n", "gi", vim.lsp.buf.implementation, opts)
km_set("n", "ga", fzf.lsp_references, opts)
km_set("n", "K", vim.lsp.buf.hover, opts)
km_set("n", "<Leader>fo", vim.lsp.buf.format, opts)
