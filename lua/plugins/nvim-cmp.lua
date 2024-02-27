-- return {}
local function next()
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.select_next_item()
  else
    cmp.complete()
  end
end

return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      completion = {
        -- autocomplete = true,
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
        ["<C-n>"] = next,
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
    })
  end,
  --   },
  --   { "saadparwaiz1/cmp_luasnip" },
  --   { "hrsh7th/cmp-nvim-lsp" },
  --   { "hrsh7th/cmp-buffer" },
  -- { "hrsh7th/cmp-nvim-lsp-signature-help" },
  -- { "hrsh7th/cmp-path" },
}
