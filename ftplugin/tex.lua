local v = vim
local noremap = require("maps").noremap
local options = { silent = true, buffer = true }

noremap("n", "J", "j", options)
noremap("n", "K", "k", options)

noremap("n", "<leader>gv", [[:execute '!open ' . substitute(expand("%:r"), " ", "\\\\ ", "") . '.pdf']])
noremap("n", "<leader>lp", [[:w<CR>:execute '!latexmk -pdf -g -halt-on-error "' . expand("%") . '"']])
noremap(
  "n",
  "<leader>f",
  [[:w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR> <C-L><CR>]],
  options
)

noremap("n", "]]", [[:call NextCell("^\\\\\\(sub\\)*section")<CR>]], options)
noremap("n", "[[", [[:call PrevCell("^\\\\\\(sub\\)*section")<CR>]], options)

-- latex macros
v.cmd("iab ca<Bslash> \\begin{cases}<NL>\\end{cases}<ESC>O<BACKSPACE><SPACE>")
v.cmd("iab pf<Bslash> \\begin{proof}<NL>\\end{proof}<ESC>O<BACKSPACE><SPACE>")
v.cmd("iab mm<Bslash> \\begin{align*}<NL>\\end{align*}<ESC>O<BACKSPACE><SPACE>")
v.cmd("iab ml<Bslash> \\begin{multline*}<NL>\\end{multline*}<ESC>O<BACKSPACE><SPACE>")
v.cmd("iab ma<Bslash> \\left(\\begin{array}<NL>\\end{array}\\right)<ESC>kA")
v.cmd("iab enn<Bslash> \\begin{enumerate}[label=(\\arabic*)]<NL>\\end{enumerate}<ESC>O\\item")
v.cmd("iab ena<Bslash> \\begin{enumerate}[label=(\\alph*)]<NL>\\end{enumerate}<ESC>O\\item")
v.cmd("iab it<Bslash> \\begin{itemize}<NL>\\end{itemize}<ESC>O\\item")
v.cmd("iab th<Bslash> \\begin{theorem}<NL>\\end{theorem}<ESC>O<BACKSPACE><SPACE>")
v.cmd("iab pr<Bslash> \\begin{proposition}<NL>\\end{proposition}<ESC>O<BACKSPACE><SPACE>")
v.cmd("iab co<Bslash> \\begin{corollary}<NL>\\end{corollary}<ESC>O<BACKSPACE><SPACE>")
v.cmd("iab lm<Bslash> \\begin{lemma}<NL>\\end{lemma}<ESC>O<BACKSPACE><SPACE>")
v.cmd("iab rm<Bslash> \\begin{remark}<NL>\\end{remark}<ESC>O<BACKSPACE><SPACE>")

v.opt.signcolumn = "no"
v.opt.number = false
v.opt_local.commentstring = "% %s"
-- setlocal commentstring=%\ %s | :NoMatchParen

local function set_servername()
  local nvim_server_file = "/tmp/curnvimserver.txt"
  local cmd = "echo " .. v.v.servername .. " > " .. nvim_server_file
  io.popen(cmd)
end

set_servername()

local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
local cond = require("nvim-autopairs.conds")

npairs.add_rules({
  Rule("$", "$", { "tex", "latex" }):with_pair(cond.not_before_regex("\\", 1)),
})
