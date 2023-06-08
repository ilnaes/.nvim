local noremap = require("util").noremap

return {
  {
    "junegunn/fzf",
    build = function()
      vim.cmd("call fzf#install()")
    end,
    lazy = false,
  },
  {
    "junegunn/fzf.vim",
    lazy = false,
    config = function()
      noremap("n", "<Leader>f", ":Files<CR>")
      noremap("n", "<Leader>a", ":Rg<CR>")
      noremap("n", "<Leader>t", ":Tags<CR>")
    end,
  },
  { "tpope/vim-commentary", lazy = false },
  { "sheerun/vim-polyglot", lazy = false },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").set_default_keymaps()

      vim.keymap.set("n", "f", function()
        local current_window = vim.fn.win_getid()
        require("leap").leap({ target_windows = { current_window } })
      end)
    end,
  },
  -- use 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  {
    "Olical/conjure",
    ft = { "clojure", "fennel" },
    config = function()
      vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
      vim.g["conjure#client#fennel#stdio#command"] = "fnl"
    end,
  },
  {
    "guns/vim-sexp",
    ft = { "clojure", "fennel" },
    config = function()
      vim.g["sexp_enable_insert_mode_mappings"] = 0
    end,
  },
  { "fatih/vim-go", ft = { "go" }, build = ":GoUpdateBinaries" },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
    lazy = false,
  },
}
