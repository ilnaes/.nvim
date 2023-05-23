local dir = os.getenv("HOME") .. "/.config/nvim/"

dofile(dir .. "lua/opts.lua")
dofile(dir .. "lua/maps.lua")

vim.g["polyglot_disabled"] = { "markdown", "autoindent" }

-- load some non-migrated code
vim.cmd("source " .. dir .. ".vimrc")

dofile(dir .. "lua/plug.lua")

local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })
    for _, def in ipairs(definition) do
      vim.api.nvim_create_autocmd(def[1], {
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
