local v = vim
local macbook = require("util").macbook

return {
  { "vim-airline/vim-airline", lazy = false },
  {
    "junegunn/fzf",
    build = function()
      v.cmd("call fzf#install()")
    end,
    lazy = false,
  },
  { "junegunn/fzf.vim", lazy = false },
  { "tpope/vim-commentary", lazy = false },
  { "sheerun/vim-polyglot", lazy = false },
  { "jpalardy/vim-slime", lazy = false },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").set_default_keymaps()
    end,
  },
  -- use 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  { "Olical/conjure", ft = { "clojure", "fennel" } },
  { "guns/vim-sexp", ft = { "clojure", "fennel" } },
  { "fatih/vim-go", ft = { "go" }, build = ":GoUpdateBinaries" },
  {
    "windwp/nvim-autopairs",
    config = function(_, _)
      require("nvim-autopairs").setup({})
    end,
    lazy = false,
  },
}
