return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "typescript", "javascript", "haskell", "latex" },
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
    },
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    version = "*",
    init = function()
      local setup = false
      vim.keymap.set("n", "<Leader>d", function()
        if not setup then
          require("neogen").setup({ snippet_engine = "luasnip" })
        end
        require("neogen").generate({ type = "func", snippet_engine = "luasnip" })
      end)
    end,
  },
}
