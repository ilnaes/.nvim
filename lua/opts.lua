local o = vim.opt

vim.g.mapleader = ","

if require("util").macbook then
  vim.g.python3_host_prog = "/usr/bin/python3"
else
  vim.g.python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.10/bin/python3"
end

o.mouse = "a"
o.vb = true
o.expandtab = true
o.autoread = true
o.guicursor = nil
o.scrolloff = 1
o.title = true
o.ruler = true
o.wrapscan = true
o.showmatch = true
o.signcolumn = "yes"
o.showcmd = false
o.number = true
o.hidden = true
o.splitbelow = true
o.splitright = true
o.wildmenu = true
o.shiftwidth = 2
o.tabstop = 2
o.concealcursor = "nc"
o.completeopt = "menu,menuone,preview,noselect,noinsert"

vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.whichwrap = vim.o.whichwrap .. "<,>,h,l,[,]"
-- set wildmenu                " have autocomplete on commands
-- set ttyfast                 " smoother changes
-- set autoindent
-- set updatetime=500
-- set tabstop=4
-- set shiftwidth=4
