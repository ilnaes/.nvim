local v = vim

local dir = os.getenv("HOME") .. "/.config/nvim/"
v.cmd("source " .. dir .. ".vimrc")

require("opts")
require("maps")
require("plug")

local augroups = {
  initial = {
    { "BufReadPost", "*", [[call setpos(".", getpos("'\""))]] },
    { "CompleteDone", "*", "pclose" },
    { "FileType", "c,cpp,go", [[setlocal commentstring=//\ %s]] },
  },
}

require("util").create_augroups(augroups)
