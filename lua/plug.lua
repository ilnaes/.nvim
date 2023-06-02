local v = vim

v.g["polyglot_disabled"] = { "markdown", "autoindent" }

local lazypath = v.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not v.loop.fs_stat(lazypath) then
  v.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
v.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

local wiki_path = "~/Dropbox/wiki"

v.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"

v.g["sexp_enable_insert_mode_mappings"] = 0

v.g["slime_target"] = "tmux"
v.g["slime_dont_ask_default"] = 1
v.g["slime_default_config"] = { socket_name = "default", target_pane = "{last}" }

v.g["airline#extensions#tabline#enabled"] = 1
v.g["airline#extensions#ale#enabled"] = 1
v.g["airline_section_y"] = ""
v.g["airline_section_warning"] = ""
v.g["airline_section_z"] = "%3p%% %3l/%L:%3v"

v.g["vimwiki_global_ext"] = 0
v.g["vimwiki_list"] = { { path = wiki_path, syntax = "markdown", ext = ".md" } }

v.g["ale_fix_on_save"] = 1
v.g["ale_lint_on_text_changed"] = "never"
v.g["ale_lint_on_insert_leave"] = 0
v.g["ale_lint_on_save"] = 1
v.g["ale_linters_explicit"] = 1

v.g["ale_linters"] = {
  c = { "clang" },
  cpp = { "clang" },
  go = { "go vet" },
  python = { "pyflakes" },
  rust = { "analyzer" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
  rmd = { "languageserver" },
  r = { "languageserver" },
  clojure = { "clj-kondo" },
  lua = { "luacheck" },
}

v.g["ale_fixers"] = {
  c = { "clang-format" },
  cpp = { "clang-format" },
  go = { "goimports" },
  python = { "black", "isort" },
  rust = { "rustfmt" },
  javascript = { "prettier" },
  typescript = { "prettier" },
  typescriptreact = { "prettier" },
  json = { "prettier" },
  html = { "prettier" },
  rmd = { "styler" },
  r = { "styler" },
  lua = { "stylua" },
}

local noremap = require("maps").noremap

noremap("n", "<Leader>f", ":Files<CR>")
noremap("n", "<Leader>a", ":Rg<CR>")
noremap("n", "<Leader>t", ":Tags<CR>")
noremap("n", "<Leader>wf", function()
  v.fn["fzf#vim#grep"](
    'rg --column --line-number --no-heading --color=always --smart-case -- "" ' .. wiki_path,
    1,
    v.fn["fzf#vim#with_preview"](),
    0
  )
end)

local function send_word()
  local reg_save = v.fn.getreg('"')
  local save_pos = v.api.nvim_win_get_cursor(0)
  v.cmd('silent exe "normal! viwy"')
  v.fn["slime#send"](v.fn.getreg('"') .. "\r")
  v.api.nvim_win_set_cursor(0, save_pos)
  v.fn.setreg('"', reg_save)
end

noremap("n", "\\ww", send_word)
noremap("v", "\\vv", "<Plug>SlimeRegionSend")
noremap("n", "\\ll", "<Plug>SlimeLineSend")
noremap("n", "\\pp", "<Plug>SlimeParagraphSend")
noremap("n", "\\cc", "<Plug>SlimeSendCell")

if v.fn.hostname():find("MacBook") == nil then
  noremap(
    "i",
    "<cr>",
    [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
    { expr = true }
  )
end
