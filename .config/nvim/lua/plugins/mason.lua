vim.pack.add({
  { src = "https://github.com/williamboman/mason.nvim", name = "mason" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", name = "mason-tool-installer" },
})

require("mason").setup({})

require("mason-tool-installer").setup({
  ensure_installed = {
    "black",
    "clang-format",
    "cpplint",
    "debugpy",
    "docker-compose-linter",
    "docker-language-server",
    "dockerfmt",
    "mypy",
    "neocmakelsp",
    "pgformatter", -- бинарь `pg_format` для conform (sql)
    "protols",
    "pyright",
    "ruff",
    "stylua", -- форматтер lua для conform (заменяет luafmt)
    "yaml-language-server",
  },
  auto_update = true,
  run_on_start = true,
})
