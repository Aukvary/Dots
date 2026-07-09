vim.pack.add({
    { src = "https://github.com/goolord/alpha-nvim", name = "alpha-nvim" },
})

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

alpha.setup(dashboard.config)
dashboard.section.header.val = {
    [[ __ _  ____  __   _  _  __  _  _ ]],
    [[(  ( \(  __)/  \ / )( \(  )( \/ )]],
    [[/    / ) _)(  O )\ \/ / )( / \/ \]],
    [[\_)__)(____)\__/  \__/ (__)\_)(_/]],
}
