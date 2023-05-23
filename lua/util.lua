local function next_cell(pattern)
  local i = vim.fn.search(pattern, "nW")
  if i == 0 then
    return
  else
    vim.fn.cursor(i + 1, 1)
  end
end

local function prev_cell(pattern)
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

return {
  next_cell = next_cell,
  prev_cell = prev_cell,
}
