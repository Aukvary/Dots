-- lazygit.nvim: запуск lazygit из nvim в плавающем окне.
-- Команды (:LazyGit, :LazyGitCurrentFile, :LazyGitFilter,
-- :LazyGitFilterCurrentFile) плагин регистрирует сам.
--
-- Учти: бинарник lazygit должен быть в PATH — плагин его не ставит
-- (до установки :LazyGit будет падать с ошибкой «lazygit не найден»).
vim.pack.add({
    { src = "https://github.com/kdheepak/lazygit.nvim", name = "lazygit.nvim" },
})

-- Оформление плавающего окна (дефолты из официального README)
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.9
