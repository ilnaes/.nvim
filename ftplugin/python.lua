local util = require("util")
local noremap = util.noremap
local v = vim

v.g.slime_cell_delimiter = "#%%"
v.b.cell_pattern = "^[ \t]*#%%"
local options = { silent = true, buffer = true }

noremap("n", "]]", util.next_cell, options)
noremap("n", "[[", util.prev_cell, options)
noremap("n", "<LocalLeader>ca", "<Plug>SlimeSendCell | :lua require('util').next_cell()<CR>", options)
