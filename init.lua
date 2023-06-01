local v = vim

local dir = os.getenv("HOME") .. "/.config/nvim/"
v.cmd("source " .. dir .. ".vimrc")

-- dofile(dir .. "lua/opts.lua")
-- dofile(dir .. "lua/maps.lua")
-- dofile(dir .. "lua/plug.lua")

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
