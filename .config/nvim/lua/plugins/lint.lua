vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-lint", name = "nvim-lint" },
})

local lint = require('lint')

lint.linters_by_ft = {
    python = { "flake8" },
    cpp = { "cpplint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
