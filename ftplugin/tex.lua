local util = require("util")
local noremap = util.noremap
local options = { silent = true, buffer = true }

vim.b.cell_pattern = "^\\\\\\(sub\\)*section"
noremap("n", "]]", util.next_cell, options)
noremap("n", "[[", util.prev_cell, options)

noremap(
  "n",
  "<leader>gv",
  [[:execute '!open ' . substitute(expand("%:r"), " ", "\\\\ ", "") . '.pdf']],
  { buffer = true }
)
noremap(
  "n",
  "<leader>lp",
  [[:w<CR>:execute '!latexmk -pdf -g -halt-on-error "' . expand("%") . '"']],
  { buffer = true }
)
noremap(
  "n",
  "<leader>v",
  [[:w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR> <C-L><CR>]],
  options
)

noremap("n", "J", "j", options)
noremap("n", "K", "k", options)

-- latex macros
-- vim.cmd("iab <buffer> ca<Bslash> \\begin{cases}<NL>\\end{cases}<ESC>O<BACKSPACE><SPACE>")
-- vim.cmd("iab <buffer> pf<Bslash> \\begin{proof}<NL>\\end{proof}<ESC>O<BACKSPACE><SPACE>")
-- vim.cmd("iab <buffer> mm<Bslash> \\begin{align*}<NL>\\end{align*}<ESC>O<BACKSPACE><SPACE>")
-- vim.cmd("iab <buffer> ml<Bslash> \\begin{multline*}<NL>\\end{multline*}<ESC>O<BACKSPACE><SPACE>")
-- vim.cmd("iab <buffer> ma<Bslash> \\left(\\begin{array}<NL>\\end{array}\\right)<ESC>kA")
-- vim.cmd("iab <buffer> enn<Bslash> \\begin{enumerate}[label=(\\arabic*)]<NL>\\end{enumerate}<ESC>O\\item")
-- vim.cmd("iab <buffer> ena<Bslash> \\begin{enumerate}[label=(\\alph*)]<NL>\\end{enumerate}<ESC>O\\item")
-- vim.cmd("iab <buffer> it<Bslash> \\begin{itemize}<NL>\\end{itemize}<ESC>O\\item")
-- vim.cmd("iab <buffer> th<Bslash> \\begin{theorem}<NL>\\end{theorem}<ESC>O<BACKSPACE><SPACE>")
-- vim.cmd("iab <buffer> pr<Bslash> \\begin{proposition}<NL>\\end{proposition}<ESC>O<BACKSPACE><SPACE>")
-- vim.cmd("iab <buffer> co<Bslash> \\begin{corollary}<NL>\\end{corollary}<ESC>O<BACKSPACE><SPACE>")
-- vim.cmd("iab <buffer> lm<Bslash> \\begin{lemma}<NL>\\end{lemma}<ESC>O<BACKSPACE><SPACE>")
-- vim.cmd("iab <buffer> rm<Bslash> \\begin{remark}<NL>\\end{remark}<ESC>O<BACKSPACE><SPACE>")

vim.opt.signcolumn = "no"
vim.opt.number = false
vim.opt_local.commentstring = "% %s"
-- setlocal commentstring=%\ %s | :NoMatchParen

local function set_servername()
  local nvim_server_file = "/tmp/curnvimserver.txt"
  local cmd = "echo " .. vim.vim.servername .. " > " .. nvim_server_file
  io.popen(cmd)
end

set_servername()

local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
local cond = require("nvim-autopairs.conds")

npairs.add_rules({
  Rule("$", "$", { "tex", "latex" }):with_pair(cond.not_before_regex("\\", 1)):with_move(cond.done()),
})

-- returns nil if not in math mode
-- 0 if in math mode and -1 if previous
-- character is in math mode (so ending $)
local function in_mathmode(mode)
  if mode == nil then
    mode = "texMathZone"
  else
    mode = "texMathZone" .. mode
  end

  if util.get_synstack():find(mode) then
    return 0
  elseif util.get_synstack(-1):find(mode) then
    return -1
  end
end

local function go_mathmode()
  local mode = in_mathmode("X")

  if mode == nil then
    print("Not in math mode!")
    return
  end

  local sel_save = vim.o.selection
  local reg_save = vim.fn.getreg('"')
  vim.o.selection = "inclusive"

  local indent = string.rep(" ", vim.fn.indent(vim.fn.line(".")))
  local pos2, pos1
  local found = false

  if mode ~= -1 then
    repeat
      pos2 = vim.fn.searchpos("\\$")

      if util.get_synstack(0):find("texSpecialChar") then
        vim.cmd([[silent exe "normal! l"]])
      else
        found = true
      end
    until found
  else
    pos2 = vim.api.nvim_win_get_cursor(0)
  end

  repeat
    pos1 = vim.fn.searchpos("\\$", "b")
  until not util.get_synstack(0):find("texSpecialChar")

  local line = vim.fn.line(".")

  vim.fn.setpos("'[", { 0, pos1[1], pos1[2], 0 })
  vim.fn.setpos("']", { 0, pos2[1], pos2[2], 0 })
  vim.cmd([[silent exe "normal! `[v`]c\n"]])

  local ret = indent .. vim.fn.getreg('"')
  ret = util.str_split(ret:sub(2, #ret - 1), "\n")

  for i, val in ipairs(ret) do
    ret[i] = string.rep(" ", vim.o.tabstop) .. val
  end

  table.insert(ret, 1, indent .. "\\begin{align*}")
  table.insert(ret, indent .. "\\end{align*}")

  vim.api.nvim_buf_set_lines(0, line, line, false, ret)

  vim.fn.setreg('"', reg_save)
  vim.o.selection = sel_save
end

noremap("n", "gmm", go_mathmode, options)
