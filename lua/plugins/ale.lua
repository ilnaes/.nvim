return {
	"dense-analysis/ale",
	enabled = require("util").macbook,
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
	init = function()
		local v = vim

		v.g["ale_fix_on_save"] = 1
		v.g["ale_lint_on_text_changed"] = "never"
		v.g["ale_lint_on_insert_leave"] = 0
		v.g["ale_lint_on_save"] = 1
		v.g["ale_linters_explicit"] = 1

		v.g["ale_linters"] = {
			c = { "clang" },
			cpp = { "clang" },
			go = { "go vet" },
			python = { "pyflakes" },
			rust = { "analyzer" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			rmd = { "languageserver" },
			r = { "languageserver" },
			clojure = { "clj-kondo" },
			lua = { "luacheck" },
		}

		v.g["ale_fixers"] = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			go = { "goimports" },
			python = { "black", "isort" },
			rust = { "rustfmt" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			html = { "prettier" },
			rmd = { "styler" },
			r = { "styler" },
			lua = { "stylua" },
		}
	end,
}
