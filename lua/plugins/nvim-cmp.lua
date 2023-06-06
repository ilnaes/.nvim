local function next()
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.select_next_item()
  else
    cmp.complete()
    cmp.select_next_item()
  end
end

return {
  {
    "hrsh7th/nvim-cmp",
    keys = {
      {
        "<C-n>",
        next,
        mode = "i",
      },
    },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          autocomplete = not require("util").macbook,
        },
        mapping = {
          ["<C-p>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ["<C-n>"] = next,
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "nvim_lsp" },
        },
      })
    end,
  },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
}
