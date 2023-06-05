return {
  "rafamadriz/friendly-snippets",
  config = function()
    require("luasnip/loaders/from_vscode").load({ paths = { "~/.local/share/nvim/lazy/friendly-snippets" } })
  end,
  enabled = require("util").macbook,
}
