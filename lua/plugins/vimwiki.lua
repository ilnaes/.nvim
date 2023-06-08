return {
  "vimwiki/vimwiki",
  keys = {
    { "<Leader>ww", ":VimwikiIndex 0<CR>", mode = "n" },
  },
  init = function()
    local wiki_loc = "~/Dropbox/wiki"
    vim.g["vimwiki_global_ext"] = 0
    vim.g["vimwiki_list"] = { { path = wiki_loc, syntax = "markdown", ext = ".md" } }
    require("util").noremap("n", "<Leader>wf", function()
      vim.fn["fzf#vim#grep"](
        'rg --column --line-number --no-heading --color=always --smart-case -- "" ' .. wiki_loc,
        1,
        vim.fn["fzf#vim#with_preview"](),
        0
      )
    end)
  end,
}
