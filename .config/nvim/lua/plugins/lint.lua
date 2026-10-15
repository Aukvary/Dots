vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-lint", name = "nvim-lint" },
})

local lint = require('lint')

lint.linters_by_ft = {
    cpp = { "cpplint" },
    dockercompose = { "dclint" },
    sql = { "sqlfluff" },
}

lint.linters.cpplint.args = {
    '--filter=-legal/copyright,-whitespace,-build/include_11,-build/include_order',
}

local lint_group = vim.api.nvim_create_augroup('Lint', { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
    group = lint_group,
    callback = function()
        lint.try_lint()
    end,
})
