vim.g.mapleader = ","

if require("util").macbook then
	vim.g.python3_host_prog = "/usr/bin/python3"
else
	vim.g.python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.10/bin/python3"
end

vim.opt.mouse = "a"
vim.opt.vb = true
vim.opt.expandtab = true
vim.opt.autoread = true
vim.opt.guicursor = nil
vim.opt.scrolloff = 1
vim.opt.title = true
vim.opt.ruler = true
vim.opt.wrapscan = true
vim.opt.showmatch = true
vim.opt.signcolumn = "yes"
vim.opt.showcmd = false
vim.opt.number = true
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.concealcursor = "nc"
vim.opt.completeopt = "menu,menuone,preview,noselect,noinsert"
vim.opt.conceallevel = 1
vim.opt.showtabline = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.whichwrap = vim.o.whichwrap .. "<,>,h,l,[,]"
-- set wildmenu                " have autocomplete on commands
-- set ttyfast                 " smoother changes
-- set autoindent
-- set updatetime=500
-- set tabstop=4
-- set shiftwidth=4
