local v = vim

return {
  "vimwiki/vimwiki",
  keys = {
    { "<Leader>ww", ":VimwikiIndex 0<CR>", mode = "n" },
  },
  init = function()
    local wiki_loc = "~/Dropbox/wiki"
    v.g["vimwiki_global_ext"] = 0
    v.g["vimwiki_list"] = { { path = wiki_loc, syntax = "markdown", ext = ".md" } }
    require("util").noremap("n", "<Leader>wf", function()
      v.fn["fzf#vim#grep"](
        'rg --column --line-number --no-heading --color=always --smart-case -- "" ' .. wiki_loc,
        1,
        v.fn["fzf#vim#with_preview"](),
        0
      )
    end)
  end,
}
