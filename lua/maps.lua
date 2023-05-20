local M = {}

function M.noremap(mode, key, command, options, fn)
  local option = { remap = false }

  if fn == nil then
    fn = vim.keymap.set
  end

  if options ~= nil then
    for k, v in pairs(options) do
      option[k] = v
    end
  end
  fn(mode, key, command, option)
end

local function toggle_quickfix()
  local winid = vim.fn.getloclist(0, { winid = 0 }).winid

  if winid == 0 then
    vim.cmd.lopen()
  else
    vim.cmd.lclose()
  end
end

M.noremap("n", ";", ":")

M.noremap("i", "<cr>", "(pumvisible()?(<C-y>):(<cr>))", { expr = true })
M.noremap("n", "<c-e>", toggle_quickfix)
M.noremap({ "n", "v" }, "j", "gj")
M.noremap({ "n", "v" }, "k", "gk")
M.noremap("n", "<C-l>", ":bnext<CR>")
M.noremap("n", "<C-h>", ":bprev<CR>")
M.noremap("i", "<C-n>", "<C-x><C-o><C-p>")

M.noremap("n", "<Leader>f", ":Files<CR>")
M.noremap("n", "<Leader>a", ":Rg<CR>")
M.noremap("n", "<Leader>t", ":Tags<CR>")

M.noremap("v", "<Leader>y", '"*y')
M.noremap("n", "<Leader>p", '"*p')
M.noremap("n", "<Leader>h", ":noh<CR>")
M.noremap("n", "<Leader>r", ":so ~/.config/nvim/init.vim<CR>")

vim.api.nvim_create_user_command("Q", "bd", {})

return M
