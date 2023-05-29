local fn = vim.fn
local v = vim

local function get_hostname()
  local f = io.popen("/bin/hostname")
  local hostname = f:read("*a") or ""
  f:close()
  hostname = string.gsub(hostname, "\n$", "")
  return hostname
end

local function next_cell(pattern)
  local i = fn.search(pattern, "nW")
  if i == 0 then
    return
  else
    fn.cursor(i + 1, 1)
  end
end

local function prev_cell(pattern)
  local curline = fn.line(".")
  local i = fn.search(pattern, "bnW")
  if i ~= 0 then
    fn.cursor(i - 1, 1)
  end

  i = fn.search(pattern, "bnW")
  if i == 0 then
    fn.cursor(curline, 1)
  else
    fn.cursor(i + 1, 1)
  end
end

-- gets current form
-- WILL MUTATE CURSOR so should use internally
local function get_form()
  local sel_save = v.o.selection
  local reg_save = v.fn.getreg('"')
  v.o.selection = "inclusive"

  local skip = 'synIDattr(synID(line("."),col("."),1),"name") =~? "comment\\|string\\|char\\|regexp"'
  local open = "[[{(]"
  local close = "[]})]"

  local pos1, pos2
  local i = fn.col(".")

  if fn.getline("."):sub(i, i):find(close) then
    pos1 = fn.searchpairpos(open, "", close, "bn", skip)
    pos2 = { fn.line("."), fn.col(".") }
  else
    pos1 = fn.searchpairpos(open, "", close, "bcn", skip)
    pos2 = fn.searchpairpos(open, "", close, "n", skip)
  end

  fn.setpos("'[", { 0, pos1[1], pos1[2], 0 })
  fn.setpos("']", { 0, pos2[1], pos2[2], 0 })

  v.cmd([[silent exe "normal! `[v`]y"]])

  local ret = v.fn.getreg('"')

  v.fn.setreg('"', reg_save)
  v.o.selection = sel_save

  return ret
end

local function send_form(num)
  local save_pos = fn.getpos(".")
  local code
  if num == 0 then
    local reg_save = v.fn.getreg('"')
    fn["sexp#select_current_top_list"]("v", 0)
    v.cmd([[silent exe "normal! y"]])
    code = v.fn.getreg('"')
    v.fn.setreg('"', reg_save)
  else
    code = get_form()
    for _ = 1, num - 1 do
      v.cmd([[silent exe "normal! h"]])
      code = get_form()
    end
  end
  fn["slime#send"](code .. "\r")
  fn.setpos(".", save_pos)
end

return {
  next_cell = next_cell,
  prev_cell = prev_cell,
  get_hostname = get_hostname,
  get_form = get_form,
  send_form = send_form,
}
