vim.filetype.add({
    pattern = {
        ['docker[-_.]?compose.*%.ya?ml'] = 'dockercompose',
        ['compose%.ya?ml'] = 'dockercompose',
    },
})

vim.lsp.enable({
    "rust-analyzer",
    "lua_ls",
    "clangd",
    "dockerls",
    "yamlls",
    "neocmakelsp",
    "protols",
})

vim.diagnostic.config({ virtual_text = true })
