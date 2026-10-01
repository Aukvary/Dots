vim.pack.add({
    { src = "https://github.com/tpope/vim-dadbod" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
})

vim.g.db_ui_use_nerd_fonts = 1

-- Отключаем buffer-local маппинги dadbod-ui из sql-буферов
-- (<Leader>W/E/S = сохранить/запустить запрос), чтобы они не мешали
-- глобальным биндам, как <leader>s = :w. Команды DBUI*/:DB остаются.
vim.g.db_ui_disable_mappings_sql = 1