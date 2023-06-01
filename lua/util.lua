local v = vim

local function next_cell(pattern)
  if pattern == nil then
    pattern = v.b.cell_pattern
  end

  local i = v.fn.search(pattern, "nW")
  if i == 0 then
    return
  else
    v.fn.cursor(i + 1, 1)
  end
end

local function prev_cell(pattern)
  if pattern == nil then
    pattern = v.b.cell_pattern
  end

  local curline = v.fn.line(".")
  local i = v.fn.search(pattern, "bnW")
  if i ~= 0 then
    v.fn.cursor(i - 1, 1)
  end

  i = v.fn.search(pattern, "bnW")
  if i == 0 then
    v.fn.cursor(curline, 1)
  else
    v.fn.cursor(i + 1, 1)
  end
end

local function get_synstack(offset)
  if offset == nil then
    offset = 0
  end

  local stack = v.fn.synstack(v.fn.line("."), v.fn.col(".") + offset)
  local ret = ""

  for _, val in ipairs(stack) do
    ret = v.fn.synIDattr(val, "name") .. ret
  end

  return ret
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
  local i = v.fn.col(".")

  if v.fn.getline("."):sub(i, i):find(close) then
    pos1 = v.fn.searchpairpos(open, "", close, "bn", skip)
    pos2 = { v.fn.line("."), v.fn.col(".") }
  else
    pos1 = v.fn.searchpairpos(open, "", close, "bcn", skip)
    pos2 = v.fn.searchpairpos(open, "", close, "n", skip)
  end

  v.fn.setpos("'[", { 0, pos1[1], pos1[2], 0 })
  v.fn.setpos("']", { 0, pos2[1], pos2[2], 0 })

  v.cmd([[silent exe "normal! `[v`]y"]])

  local ret = v.fn.getreg('"')

  v.fn.setreg('"', reg_save)
  v.o.selection = sel_save

  return ret
end

-- uses send_form to slime send a sexp
-- 0 for top level
-- n for nth current form
local function send_form(num)
  local save_pos = v.fn.getpos(".")
  local code
  if num == 0 then
    local reg_save = v.fn.getreg('"')
    v.fn["sexp#select_current_top_list"]("v", 0)
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
  v.fn["slime#send"](code .. "\r")
  v.fn.setpos(".", save_pos)
end

local function str_split(s, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(s, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function format()
  local save_pos = v.fn.getpos(".")
  v.cmd.mkview()
  v.cmd([[silent exe "normal! gg=G"]])
  v.fn.setpos(".", save_pos)
  v.cmd.loadview()
end

local function create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    local group = v.api.nvim_create_augroup(group_name, { clear = true })
    for _, def in ipairs(definition) do
      v.api.nvim_create_autocmd(def[1], {
        pattern = def[2],
        group = group,
        command = def[3],
      })
    end
  end
end

return {
  format = format,
  str_split = str_split,
  next_cell = next_cell,
  prev_cell = prev_cell,
  get_form = get_form,
  send_form = send_form,
  get_synstack = get_synstack,
  create_augroups = create_augroups,
}
