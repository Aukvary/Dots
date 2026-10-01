return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml' },
    settings = {
        ['rust-analyzer'] = {
            check = { command = "clippy" },
            inlayHints = {
                bindingModeHints = { enable = true },
                typeHints = { enable = true },
                chainingHints = { enable = true },
            },
        },
    },
}