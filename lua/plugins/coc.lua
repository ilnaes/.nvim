local function goto_tag(tagkind)
  return function()
    local tagname = vim.fn.expand("<cWORD>")
    local bufnr = vim.api.nvim_get_current_buf()
    local pos = vim.fn.getcurpos()
    pos[1] = bufnr

    if vim.fn.CocAction("jump" .. tagkind) then
      vim.fn.settagstack(
        vim.api.nvim_get_current_win(),
        { curidx = vim.fn.gettagstack()["curidx"], items = { { tagname = tagname, from = pos } } },
        "t"
      )
    end
  end
end

return {
  "neoclide/coc.nvim",
  branch = "release",
  cond = not require("util").macbook,
  ft = { "lua", "javascript", "typescript", "python", "vim" },
  keys = { "<Leader>ls" },
  config = function()
    vim.keymap.set(
      "i",
      "<cr>",
      [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      { expr = true }
    )
    vim.keymap.set("n", "<C-]>", goto_tag("Definition"), { silent = true })
    vim.keymap.set("n", "<Leader>rn", "<Plug>(coc-rename)", { silent = true })
    vim.keymap.set("n", "<C-r>", "<Plug>(coc-references)", { silent = true })
    vim.keymap.set("n", "K", function()
      vim.fn.CocActionAsync("doHover")
    end, { silent = true })

    if vim.fn.exists(":ALEDisable") ~= 0 then
      vim.cmd(":ALEDisable")
    end
  end,
}
