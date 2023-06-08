-- return {}
return {
  "dense-analysis/ale",
  lazy = not require("util").macbook,
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
  init = function()
    vim.g["ale_fix_on_save"] = 1
    vim.g["ale_lint_on_text_changed"] = "never"
    vim.g["ale_lint_on_insert_leave"] = 0
    vim.g["ale_lint_on_save"] = 1
    vim.g["ale_linters_explicit"] = 1

    vim.g["ale_lua_luacheck_options"] = "--global vim"

    vim.o.omnifunc = "ale#completion#OmniFunc"
    vim.g["ale_hover_cursor"] = 0

    vim.g["ale_linters"] = {
      c = { "clang" },
      cpp = { "clang" },
      go = { "go vet" },
      python = { "pyflakes" },
      rust = { "analyzer" },
      javascript = { "eslint" },
      typescript = { "tsserver" },
      typescriptreact = { "tsserver" },
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
  end,
}
