local servers = { typescript = "tsserver", lua = "lua_ls" }

return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			if require("util").macbook then
				vim.diagnostic.disable()
			end

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local default = {
				capabilities = capabilities,
				on_attach = function(client, _bufnr)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			}
			for _, val in pairs(servers) do
				lspconfig[val].setup(default)
			end
		end,
		keys = {
			{
				"<Leader>ls",
				function()
					require("lspconfig")[servers[vim.bo.filetype]].manager.try_add()
				end,
				mode = "n",
			},
		},
		dependencies = { "williamboman/mason-lspconfig.nvim" },
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		lazy = false,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end,
		dependencies = { "williamboman/mason.nvim" },
		-- keys = { "<Leader>mc" },
		-- lazy = false,
	},
}
