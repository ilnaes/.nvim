local function noremap(mode, key, command, options)
  local option = { remap = false }

  if options ~= nil then
    for k, v in pairs(options) do
      option[k] = v
    end
  end
  vim.keymap.set(mode, key, command, option)
end

local function toggle_quickfix()
  local winid = vim.fn.getloclist(0, { winid = 0 }).winid

  if winid == 0 then
    vim.cmd.lopen()
  else
    vim.cmd.lclose()
  end
end

noremap("n", ";", ":")

noremap("n", "<c-e>", toggle_quickfix)
noremap({ "n", "v" }, "j", "gj")
noremap({ "n", "v" }, "k", "gk")
noremap("n", "<C-l>", ":bnext<CR>")
noremap("n", "<C-h>", ":bprev<CR>")
-- noremap("i", "<C-n>", "<C-x><C-o><C-p>")

noremap("v", "<Leader>y", '"*y')
noremap("n", "<Leader>p", '"*p')
noremap("n", "<Leader>h", ":noh<CR>")
noremap("n", "<Leader>r", ":lua dofile('" .. os.getenv("HOME") .. "/.config/nvim/init.lua')<CR>")

vim.api.nvim_create_user_command("Q", "bd", {})

return {
  noremap = noremap,
}
