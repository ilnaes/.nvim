local util = require("util")
local noremap = require("util").noremap
vim.b.cell_pattern = "^```"

local options = { silent = true, buffer = true }
noremap("n", "]]", util.next_cell, options)
noremap("n", "[[", util.prev_cell, options)
