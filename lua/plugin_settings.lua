local wiki_path = "~/Dropbox/wiki"

vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"

vim.g["sexp_enable_insert_mode_mappings"] = 0

vim.g["slime_target"] = "tmux"
vim.g["slime_dont_ask_default"] = 1
vim.g["slime_default_config"] = { socket_name = "default", target_pane = "{last}" }

vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#ale#enabled"] = 1
vim.g["airline_section_y"] = ""
vim.g["airline_section_warning"] = ""
vim.g["airline_section_z"] = "%3p%% %3l/%L:%3v"

vim.g["vimwiki_global_ext"] = 0
vim.g["vimwiki_list"] = { { path = wiki_path, syntax = "markdown", ext = ".md" } }

vim.g["ale_fix_on_save"] = 1
vim.g["ale_lint_on_text_changed"] = "never"
vim.g["ale_lint_on_insert_leave"] = 0
vim.g["ale_lint_on_save"] = 1
vim.g["ale_linters_explicit"] = 1

vim.g["ale_linters"] = {
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

vim.g["ale_fixers"] = {
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

local m = require("maps")

m.noremap("n", "<Leader>f", ":Files<CR>")
m.noremap("n", "<Leader>a", ":Rg<CR>")
m.noremap("n", "<Leader>t", ":Tags<CR>")
m.noremap("n", "<Leader>wr", function()
  vim.fn["fzf#vim#grep"](
    'rg --column --line-number --no-heading --color=always --smart-case -- "" ' .. wiki_path,
    1,
    vim.fn["fzf#vim#with_preview"](),
    0
  )
end)

local function send_word()
  local reg_save = vim.fn.getreg('"')
  local save_pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd('silent exe "normal! viwy"')
  vim.fn["slime#send"](vim.fn.getreg('"') .. "\r")
  vim.api.nvim_win_set_cursor(0, save_pos)
  vim.fn.setreg('"', reg_save)
end

m.noremap("n", "\\ww", send_word)
m.noremap("v", "\\vv", "<Plug>SlimeRegionSend")
m.noremap("n", "\\ll", "<Plug>SlimeLineSend")
m.noremap("n", "\\pp", "<Plug>SlimeParagraphSend")
m.noremap("n", "\\cc", "<Plug>SlimeSendCell")
