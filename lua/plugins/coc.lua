return {
  "neoclide/coc.nvim",
  branch = "release",
  enabled = require("util").macbook,
  config = function()
    require("util").noremap(
      "i",
      "<cr>",
      [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      { expr = true }
    )
  end,
}
