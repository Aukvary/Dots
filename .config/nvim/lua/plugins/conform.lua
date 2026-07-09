vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim", name = "conform.nvim" },
})

require('conform').setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        rust = { "rustfmt" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
