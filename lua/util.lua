local fn = vim.fn

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

return {
  next_cell = next_cell,
  prev_cell = prev_cell,
  get_hostname = get_hostname,
}
