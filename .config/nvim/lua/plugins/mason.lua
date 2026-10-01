vim.pack.add({
  { src = "https://github.com/williamboman/mason.nvim", name = "mason" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", name = "mason-tool-installer" },
})

require("mason").setup({})

require("mason-tool-installer").setup({
  ensure_installed = {
    "clang-format",
    "cpplint",
    "debugpy",
    "docker-compose-linter",
    "docker-language-server",
    "dockerfmt",
    "luafmt",
    "mypy",
    "neocmakelsp",
    "protols",
    "pyright",
    "ruff",
    "yaml-language-server",
  },
  auto_update = true,
  run_on_start = true,
})
