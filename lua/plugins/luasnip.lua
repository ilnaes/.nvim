return {
	{
		"L3MON4D3/LuaSnip",
		version = "1.*",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		init = function()
			vim.keymap.set("i", "<Tab>", function()
				local r, c = unpack(vim.api.nvim_win_get_cursor(0))
				local line = vim.api.nvim_buf_get_lines(0, r - 1, r, true)

				if c ~= 0 and line[1]:sub(c, c):find("[^%s]") then
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
		config = function()
			vim.keymap.set("i", "<S-Tab>", function()
				if require("luasnip").jumpable(-1) then
					return "<Plug>luasnip-jump-prev"
				else
					return "<Tab>"
				end
			end, { expr = true, silent = true })

			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "~/.local/share/nvim/lazy/friendly-snippets" },
				exclude = { "tex" },
			})
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snips/" })
		end,
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "rafamadriz/friendly-snippets" },
}
