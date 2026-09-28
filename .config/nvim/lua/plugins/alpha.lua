vim.pack.add({
    { src = "https://github.com/goolord/alpha-nvim", name = "alpha-nvim" },
})

vim.api.nvim_set_hl(0, "AlphaHeaderCustom", { fg = "#cba6f7", bold = true })

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.opts.hl = "AlphaHeaderCustom"

dashboard.section.header.val = {
    [[           ⠀⠀⠀⠀ ⠀⠀⠀⣀⣤⣴⣶⣶⣿⣿⣿⣿⣶⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[  __ _     ⠀⠀⠀ ⠀⣀⣴⣿⣿⣿⣿⣿⣿⡏⢿⡿⢹⣿⣿⣿⣿⣿⣿⣦⣀⠀⠀⠀⠀⠀   _  _ ]],
    [[ (  ( \    ⠀⠀ ⢠⣾⣿⣿⣿⣿⣿⣿⣿⡟⢻⣾⣷⡟⢻⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀  / )( \]],
    [[ /    /    ⠀ ⣴⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⣸⣿⣿⣇⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀  \ \/ /]],
    [[ \_)__)     ⣼⣿⣿⣿⡟⠛⠛⠛⠉⣉⣠⣼⡿⢻⡟⢿⣧⣄⣉⠉⠛⠛⠛⢻⣿⣿⣿⣷    \__/ ]],
    [[  ____     ⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠹⣶⣿⣿⣶⠏⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆    __  ]],
    [[ (  __)    ⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⣿⣿⣿⣿⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧   (  ) ]],
    [[  ) _)     ⣿⣿⣿⣿⣟⣩⣤⡀⠀⠀⣠⢤⣿⣿⣿⣿⣿⣿⡤⣄⠀⠀⢀⣤⣍⣻⣿⣿⣿⣿    )(  ]],
    [[ (____)    ⢻⣿⣿⡮⢝⣿⣶⣶⣶⣶⣶⣞⣩⠟⣿⣿⠻⣍⣳⣶⣶⣶⣶⣶⣿⡫⢵⣿⣿⡟   (__) ]],
    [[  __       ⠸⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣤⣾⣿⣿⣷⣤⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⠇   _  _ ]],
    [[ /  \      ⠀⢻⣿⣿⣿⣿⣿⠟⣹⠟⢛⣛⢛⣛⣛⡛⢛⡛⠛⠿⠿⠿⣿⣏⢹⣿⣿⣿⡟⠀  ( \/ )]],
    [[(  O )     ⠀⠀⠻⣿⣿⣿⡟⢰⠏⣼⣿⠿⠸⠟⠛⠃⢛⣛⣓⠘⠓⠒⣀⣹⡄⣿⣿⠟⠀⠀  / \/ \]],
    [[ \__/      ⠀⠀⠀⠘⢿⣿⡇⣿⣀⡥⢶⣶⣿⣟⣉⣩⣭⣭⣿⣿⣿⣿⣿⣿⣶⡿⠃⠀⠀⠀  \_)(_/]],
    [[           ⠀⠀⠀⠀⠀⠉⠳⣬⣥⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠉⠀⠀⠀⠀⠀]],
    [[           ⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⠿⣿⣿⣿⣿⠿⠿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀]],
}

dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", "<Cmd>ene <BAR> startinsert<CR>"),
    dashboard.button("f", "󰈞  Find file", "<Cmd>lua require('fzf-lua').files()<CR>"),
    dashboard.button("r", "󰊄  Recent files", "<Cmd>lua require('fzf-lua').oldfiles()<CR>"),
    dashboard.button("g", "󰈬  Find word", "<Cmd>lua require('fzf-lua').live_grep()<CR>"),
    dashboard.button("q", "  Quit Neovim", "<Cmd>qa<CR>"),
}

alpha.setup(dashboard.config)
