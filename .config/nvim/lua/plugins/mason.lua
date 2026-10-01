vim.pack.add({
  { src = "https://github.com/williamboman/mason.nvim", name = "mason" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", name = "mason-tool-installer" },
})

require("mason").setup({})

require("mason-tool-installer").setup({
  ensure_installed = {
    "clang-format",
    "cmakelang", -- cmake-format для conform (cmake)
    "cpplint",
    "docker-compose-linter",
    "docker-language-server",
    "dockerfmt",
    "neocmakelsp",
    "pgformatter", -- бинарь `pg_format` для conform (sql)
    "postgres-language-server", -- LSP для SQL (vim.lsp.enable)
    "protols",
    "pyright",
    "ruff",
    "sqlfluff", -- линтер SQL для nvim-lint
    "stylua", -- форматтер lua для conform (заменяет luafmt)
    "yaml-language-server",
  },
  auto_update = true,
  run_on_start = true,
})
