local v = vim
local macbook = require("util").macbook

return {
  "vim-airline/vim-airline",

  {
    "junegunn/fzf",
    build = function()
      v.cmd("call fzf#install()")
    end,
  },
  "junegunn/fzf.vim",
  "tpope/vim-commentary",
  "sheerun/vim-polyglot",
  "jpalardy/vim-slime",
  -- use 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  { "Olical/conjure", ft = { "clojure", "fennel" } },
  { "fatih/vim-go", ft = { "go" }, build = ":GoUpdateBinaries" },
  "guns/vim-sexp",

  "vimwiki/vimwiki",
  {
    "windwp/nvim-autopairs",
    config = function(_, _)
      require("nvim-autopairs").setup({})
    end,
  },
}
