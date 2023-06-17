require("opts")
require("maps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", { defaults = { lazy = true } })

local augroups = {
  initial = {
    { "BufReadPost", { pattern = "*", command = [[call setpos(".", getpos("'\""))]] } },
    { "CompleteDone", { pattern = "*", command = "pclose" } },
    { "FileType", { pattern = "c,cpp,go", command = [[setlocal commentstring=//\ %s]] } },
    { "FileType", { pattern = "help", command = "noremap <buffer> <C-]> <C-]>" } },
    {
      { "BufReadPost", "BufDelete" },
      {
        callback = function(event)
          local num_bufs = #vim.fn.getbufinfo({ buflisted = 1 })
          if event.event == "BufDelete" and num_bufs <= 2 then
            vim.o.showtabline = 1
          elseif event.event == "BufReadPost" and num_bufs >= 2 then
            vim.o.showtabline = 2
          end
        end,
      },
    },
  },
}

require("util").create_augroups(augroups)
