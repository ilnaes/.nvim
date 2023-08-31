local util = {}

function util.noremap(mode, key, command, options)
  local option = { remap = false }

  if options ~= nil then
    for k, v in pairs(options) do
      option[k] = v
    end
  end
  vim.keymap.set(mode, key, command, option)
end

function util.next_cell(pattern)
  if pattern == nil then
    pattern = vim.b.cell_pattern
  end

  local i = vim.fn.search(pattern, "nW")
  if i == 0 then
    return
  else
    vim.fn.cursor(i + 1, 1)
  end
end

function util.prev_cell(pattern)
  if pattern == nil then
    pattern = vim.b.cell_pattern
  end

  local curline = vim.fn.line(".")
  local i = vim.fn.search(pattern, "bnW")
  if i ~= 0 then
    vim.fn.cursor(i - 1, 1)
  end

  i = vim.fn.search(pattern, "bnW")
  if i == 0 then
    vim.fn.cursor(curline, 1)
  else
    vim.fn.cursor(i + 1, 1)
  end
end

function util.get_synstack(offset)
  if offset == nil then
    offset = 0
  end

  local stack = vim.fn.synstack(vim.fn.line("."), vim.fn.col(".") + offset)
  local ret = ""

  for _, val in ipairs(stack) do
    ret = vim.fn.synIDattr(val, "name") .. ret
  end

  return ret
end

-- gets current form
-- WILL MUTATE CURSOR so should use internally
function util.get_form()
  local sel_save = vim.o.selection
  local reg_save = vim.fn.getreg('"')
  vim.o.selection = "inclusive"

  local skip = 'synIDattr(synID(line("."),col("."),1),"name") =~? "comment\\|string\\|char\\|regexp"'
  local open = "[[{(]"
  local close = "[]})]"

  local pos1, pos2
  local i = vim.fn.col(".")

  if vim.fn.getline("."):sub(i, i):find(close) then
    pos1 = vim.fn.searchpairpos(open, "", close, "bn", skip)
    pos2 = { vim.fn.line("."), vim.fn.col(".") }
  else
    pos1 = vim.fn.searchpairpos(open, "", close, "bcn", skip)
    pos2 = vim.fn.searchpairpos(open, "", close, "n", skip)
  end

  vim.fn.setpos("'[", { 0, pos1[1], pos1[2], 0 })
  vim.fn.setpos("']", { 0, pos2[1], pos2[2], 0 })

  vim.cmd([[silent exe "normal! `[v`]y"]])

  local ret = vim.fn.getreg('"')

  vim.fn.setreg('"', reg_save)
  vim.o.selection = sel_save

  return ret
end

-- uses send_form to slime send a sexp
-- 0 for top level
-- n for nth current form
function util.send_form(num)
  local save_pos = vim.fn.getpos(".")
  local code
  if num == 0 then
    local reg_save = vim.fn.getreg('"')
    vim.fn["sexp#select_current_top_list"]("v", 0)
    vim.cmd([[silent exe "normal! y"]])
    code = vim.fn.getreg('"')
    vim.fn.setreg('"', reg_save)
  else
    code = util.get_form()
    for _ = 1, num - 1 do
      vim.cmd([[silent exe "normal! h"]])
      code = util.get_form()
    end
  end
  vim.fn["slime#send"](code .. "\r")
  vim.fn.setpos(".", save_pos)
end

function util.str_split(s, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(s, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

function util.format()
  local save_pos = vim.fn.getpos(".")
  vim.cmd.mkview()
  vim.cmd([[silent exe "normal! gg=G"]])
  vim.fn.setpos(".", save_pos)
  vim.cmd.loadview()
end

function util.create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })

    for _, def in ipairs(definition) do
      def[2].group = group
      vim.api.nvim_create_autocmd(def[1], def[2])
    end
  end
end

util.macbook = vim.fn.hostname():find("Sean") ~= nil

return util
