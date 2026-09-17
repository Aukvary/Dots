vim.filetype.add({
    pattern = {
        ['docker[-_.]?compose.*%.ya?ml'] = 'dockercompose',
        ['compose%.ya?ml'] = 'dockercompose',
    },
})

vim.lsp.enable({
  "rust-analyzer",
  "lua-ls",
  "clangd",
  "docker-language-server",
  "yaml-language-server",
  "neocmakelsp",
  "protols",
})

vim.diagnostic.config({ virtual_text = true })
