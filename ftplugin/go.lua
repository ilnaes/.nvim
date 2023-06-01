local v = vim

v.g.go_highlight_types = 1
v.g.go_highlight_fields = 1
v.g.go_highlight_functions = 1
v.g.go_highlight_function_calls = 1
v.g.go_fmt_autosave = 0

require("maps").noremap("n", "<leader>rn", ":GoRename<CR>", { buffer = true })
