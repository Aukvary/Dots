local o = vim.opt

local is_wsl = (function()
	local output = vim.fn.has("wsl")
	if output == 1 then
		return true
	end
	return vim.fn.filereadable("/proc/version") == 1
		and vim.fn.readfile("/proc/version")[1]:lower():match("microsoft") ~= nil
end)()

if is_wsl and vim.fn.executable("win32yank.exe") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

o.autoindent = true
o.clipboard = "unnamedplus"
o.cursorline = true
o.expandtab = true
o.mouse = "a"
o.nu = true
o.relativenumber = true
o.scrolloff = 5
o.shiftwidth = 4
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.tabstop = 4
o.termguicolors = true
o.undofile = true
o.updatetime = 250
o.wrap = false
vim.g.mapleader = " "
