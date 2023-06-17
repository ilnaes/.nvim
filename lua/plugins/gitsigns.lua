return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
    vim.cmd(":hi GitSignsDeleteVirtLn ctermfg=221")
    vim.cmd(":hi GitSignsDeleteVirtLn ctermbg=52")
    vim.keymap.set({ "i", "n" }, "<C-g>", "<Cmd>Gitsigns toggle_deleted<CR>")
  end,
  lazy = false,
}
