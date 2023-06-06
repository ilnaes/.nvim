local v = vim
local servers = { typescript = "tsserver", lua = "lua_ls" }

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      if require("util").macbook then
        v.diagnostic.disable()
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
        ":LspStart<CR>",
        mode = "n",
      },
    },
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    lazy = require("util").macbook,
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
  },
}
