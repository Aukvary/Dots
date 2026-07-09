vim.pack.add({
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('3') },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("neo-tree").setup({
    source_selector = {
        winbar = false,
        statusline = false
    },
    filesystem = {
        filtered_items = {
            visible = true,
            show_hidden_count = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {},
            never_show = {},
        },
    },
    window = {
        mappings = {
            ["<space>"] = "none",
            ["l"] = "open",
            ["h"] = "close_node",
            ["v"] = "open_vsplit",
            ["s"] = "open_split",
            ["t"] = "open_tabnew",
            ["P"] = { "toggle_preview", config = { use_float = true } },
        }
    }
})
