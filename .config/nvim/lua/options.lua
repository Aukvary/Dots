o = vim.opt
g = vim.g

local is_wsl = (function()
    local output = vim.fn.has('wsl')
    if output == 1 then
        return true
    end
    return vim.fn.filereadable('/proc/version') == 1 and
           vim.fn.readfile('/proc/version')[1]:lower():match('microsoft') ~= nil
end)()

if is_wsl and vim.fn.executable('win32yank.exe') == 1 then
    g.clipboard = {
        name = 'win32yank-wsl',
        copy = {
            ['+'] = 'win32yank.exe -i --crlf',
            ['*'] = 'win32yank.exe -i --crlf',
        },
        paste = {
            ['+'] = 'win32yank.exe -o --lf',
            ['*'] = 'win32yank.exe -o --lf',
        },
        cache_enabled = 0,
    }
end

o.clipboard = "unnamedplus"
o.expandtab = true
o.nu = true
o.relativenumber = true
o.shiftwidth = 4
o.tabstop = 4
o.termguicolors = true
g.mapleader = " "
