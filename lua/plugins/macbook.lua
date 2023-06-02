if require("util").macbook then
  return {
    {
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
    },
    { "rafamadriz/friendly-snippets" },
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
  }
else
  return {}
end
