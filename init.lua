local dir = os.getenv("HOME") .. "/.config/nvim/"

dofile(dir .. "lua/opts.lua")
dofile(dir .. "lua/maps.lua")

vim.g["polyglot_disabled"] = { "markdown", "autoindent" }

-- load some non-migrated code
vim.cmd("source " .. dir .. ".vimrc")

vim.cmd([[packadd packer.nvim]])

local util = require("util")

local packer = require("packer")
local putil = require("packer.util")
packer.init({
  package_root = putil.join_paths(vim.fn.stdpath("data"), "site", "pack"),
})

packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use("vim-airline/vim-airline")

  use({
    "junegunn/fzf",
    run = vim.fn["fzf#install"],
  })
  use("junegunn/fzf.vim")
  use("tpope/vim-commentary")
  use("sheerun/vim-polyglot")
  use("jpalardy/vim-slime")
  -- use 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  local i = string.find(util.get_hostname(), "MacBook")

  if i ~= nil then
    use({
      "dense-analysis/ale",
      ft = {
        "go",
        "python",
        "c",
        "javascript",
        "typescript",
        "typescriptreact",
        "json",
        "rmd",
        "r",
        "clojure",
        "lua",
      },
    })
  else
    use({ "neoclide/coc.nvim", branch = "release" })
  end

  use({ "Olical/conjure", ft = { "clojure", "fennel" } })
  use({ "fatih/vim-go", run = ":GoUpdateBinaries" })
  use("guns/vim-sexp")

  use("vimwiki/vimwiki")
  use("windwp/nvim-autopairs")
end)

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
