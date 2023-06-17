-- return {}
return {
  "dense-analysis/ale",
  enabled = require("util").macbook,
  ft = {
    "python",
    "c",
    "html",
    "javascript",
    "typescript",
    "typescriptreact",
    "json",
    "lua",
  },

  init = function()
    vim.g["ale_fix_on_save"] = 1
    vim.g["ale_lint_on_text_changed"] = "never"
    vim.g["ale_lint_on_insert_leave"] = 0
    vim.g["ale_lint_on_save"] = 1
    vim.g["ale_linters_explicit"] = 1

    vim.g["ale_hover_cursor"] = 0

    vim.g["ale_linters"] = {
      c = { "clang" },
      go = { "gopls" },
      python = { "pyright" },
      rust = { "analyzer" },
      javascript = { "tsserver" },
      typescript = { "tsserver" },
      typescriptreact = { "tsserver" },
      lua = { "lua-language-server" },
    }

    vim.g["ale_fixers"] = {
      c = { "clang-format" },
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
  end,

  config = function()
    vim.o.omnifunc = "ale#completion#OmniFunc"
    vim.keymap.set("i", "<C-n>", [[pumvisible()? "\<C-n>" : "\<C-x>\<C-o>"]], { expr = true })

    vim.keymap.set("n", "<C-]>", ":ALEGoToDefinition<CR>")
    vim.keymap.set("n", "<Leader>rn", ":ALERename<CR>")
    vim.keymap.set("n", "K", ":ALEHover<CR>")
    vim.keymap.set("n", "<C-r>", ":ALEFindReferences<CR>")
  end,
}
