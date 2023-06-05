local v = vim

return {
  "L3MON4D3/LuaSnip",
  version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  init = function()
    v.keymap.set("i", "<Tab>", function()
      local r, c = unpack(v.api.nvim_win_get_cursor(0))
      local line = v.api.nvim_buf_get_lines(0, r - 1, r, true)

      if c ~= 0 and line[1]:sub(c, c):find("%w") then
        if not package.loaded.luasnip then
          require("lazy").load({ plugins = { "LuaSnip" } })
        end

        local ls = require("luasnip")
        if ls.expand_or_jumpable() then
          return "<Plug>luasnip-expand-or-jump"
        else
          return "<Tab>"
        end
      else
        return "<Tab>"
      end
    end, { expr = true, remap = false })
  end,
  dependencies = { "rafamadriz/friendly-snippets" },
  enabled = require("util").macbook,
}
