local vault_loc = vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main/"

return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		-- ft = "markdown",
		event = {
			"BufReadPre " .. vault_loc .. "**.md",
			"BufNewFile " .. vault_loc .. "**.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		picker = {
			name = "fzf-lua",
		},
		init = function()
			require("util").noremap("n", "<Leader>fw", function()
				require("fzf-lua").fzf_live(
					"rg --column --line-number --no-heading --color=always --smart-case -- <query>",
					{
						cwd = vault_loc,
						prompt = "Search vault> ",
						actions = {
							["default"] = require("fzf-lua").actions.file_edit,
						},
					}
				)
			end)
			require("util").noremap("n", "<Leader>ww", function()
				vim.cmd("e" .. vault_loc .. "Index.md")
			end)
		end,
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "personal",
						path = vault_loc,
					},
				},
				follow_url_func = function(url)
					vim.fn.jobstart({ "open", url }) -- Mac OS
				end,
				note_id_func = function(title)
					-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
					-- In this case a note with the title 'My new note' will be given an ID that looks
					-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
					local suffix = ""
					if title ~= nil then
						-- If title is given, transform it into valid file name.
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						-- If title is nil, just add 4 random uppercase letters to the suffix.
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return suffix .. "-" .. tostring(os.date("%Y-%m-%d"))
				end,
				daily_notes = {
					folder = "dailies",
				},
				ui = {
					checkboxes = {
						[" "] = { char = "☐", hl_group = "ObsidianTodo" },
						["x"] = { char = "✔", hl_group = "ObsidianDone" },
					},
					external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				},
				mappings = {
					["<cr>"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = true, expr = true, buffer = true },
					},
					["<C-Space>"] = {
						action = function()
							return require("obsidian").util.toggle_checkbox()
						end,
						opts = { buffer = true },
					},
				},
			})
		end,
	},
}
