local km_set = vim.keymap.set

vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true })

km_set('n', '<Esc>', '<cmd>nohlsearch<CR>')

km_set("n", "<leader>e", "<Cmd>Neotree focus<CR>")
km_set("n", "<leader>E", "<Cmd>Neotree close<CR>")
km_set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")

km_set("n", "<leader>s", "<Cmd>w<CR>")
km_set("n", "<leader>S", "<Cmd>wall<CR>")
km_set("n", "<leader>q", "<Cmd>q<CR>")
km_set("n", "<leader>Q", "<Cmd>qall<CR>")

km_set('n', '<M-v>', '<C-v>')
local fzf = require('fzf-lua')

km_set("n", "<leader><leader>", fzf.files)
km_set("n", "<leader>fg", fzf.live_grep)
km_set("n", "<leader>fb", fzf.buffers)
km_set("n", "<leader>fh", fzf.help_tags)
km_set("n", "<leader>fs", fzf.git_status)

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

local opts = { noremap = true, silent = true }
km_set("n", "gd", vim.lsp.buf.definition, opts)
km_set("n", "gi", vim.lsp.buf.implementation, opts)
km_set("n", "gr", fzf.lsp_references, opts)
km_set("n", "<Leader>fo", vim.lsp.buf.format, opts)
