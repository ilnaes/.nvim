return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"typescript",
					"javascript",
					"haskell",
					"latex",
					"vimdoc",
					"python",
					"markdown",
					"hcl",
					"terraform",
				},
				highlight = {
					enable = true,
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
