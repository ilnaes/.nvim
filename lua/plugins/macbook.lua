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
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip/loaders/from_vscode").load({ paths = { "~/.local/share/nvim/lazy/friendly-snippets" } })
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
      "hrsh7th/nvim-cmp",
      keys = {
        {
          "<C-n>",
          function()
            local cmp = require("cmp")
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end,
          mode = "i",
        },
      },
      dependencies = { "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-buffer" },
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          completion = {
            autocomplete = false,
          },
          mapping = {
            ["<C-p>"] = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
            ["<C-n>"] = function()
              if cmp.visible() then
                cmp.select_next_item()
              else
                cmp.complete()
              end
            end,
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          },
          sources = {
            { name = "luasnip" },
            { name = "buffer" },
          },
        })
      end,
    },
    { "hrsh7th/cmp-buffer" },
    { "saadparwaiz1/cmp_luasnip" },
  }
end
