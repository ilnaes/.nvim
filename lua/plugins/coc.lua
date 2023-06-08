return {
  "neoclide/coc.nvim",
  branch = "release",
  lazy = require("util").macbook,
  keys = { "<Leader>ls" },
  config = function()
    require("util").noremap(
      "i",
      "<cr>",
      [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      { expr = true }
    )

    if vim.fn.exists(":ALEDisable") then
      vim.cmd(":ALEDisable")
    end
  end,
}
