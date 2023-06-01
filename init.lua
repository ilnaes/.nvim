local dir = os.getenv("HOME") .. "/.config/nvim/"
local v = vim

-- load some non-migrated code
v.cmd("source " .. dir .. ".vimrc")

dofile(dir .. "lua/opts.lua")
dofile(dir .. "lua/maps.lua")
dofile(dir .. "lua/plug.lua")

local function nvim_create_augroups(definitions)
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

local augroups = {
  initial = {
    { "BufReadPost", "*", [[call setpos(".", getpos("'\""))]] },
    { "CompleteDone", "*", "pclose" },
    { "FileType", "c,cpp,go", [[setlocal commentstring=//\ %s]] },
  },
}

nvim_create_augroups(augroups)
