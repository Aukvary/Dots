vim.pack.add({
    { src = "https://github.com/tpope/vim-dadbod" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.g.db_ui_use_nerd_fonts = 1

local ok_conform, conform = pcall(require, "conform")
if ok_conform then
    conform.setup({
        formatters_by_ft = {
            sql = { "pg_format" },
        },
    })
end

local ok_ts, ts_configs = pcall(require, "nvim-treesitter.configs")
if ok_ts then
    ts_configs.setup({
        ensure_installed = { "sql" },
        highlight = { enable = true },
    })
end

local ok_cmp, cmp = pcall(require, "cmp")
if ok_cmp then
    cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
        }),
    })
end
