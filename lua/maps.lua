local noremap = require("util").noremap

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
noremap("n", "<Leader>z", ":noh<CR>")
noremap("n", "<Leader>r", ":lua dofile('" .. os.getenv("HOME") .. "/.config/nvim/init.lua')<CR>")
noremap("i", "<C-C>", "<Esc>")

noremap("n", "<Leader>mp", function()
  vim.cmd("enew")
  vim.bo[0].buftype = "nofile"
  vim.bo[0].bufhidden = "hide"
  vim.bo[0].swapfile = false
  local bufnr = vim.fn.bufnr("%")

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    buffer = bufnr,
    callback = function()
      local text = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), true)

      local words = 0
      for _, line in ipairs(text) do
        line = string.gsub(line, "^%s*(.-)%s*$", "%1")

        if line ~= "" then
          local _, n = string.gsub(line, "%s+", "")
          words = words + n + 1
        end
      end

      local progress = math.min(math.floor(words / 63), 12)
      local finished = progress == 12 and "Done!" or ""
      print(string.format("Progress: |%s%s| %s", string.rep("*", progress), string.rep(" ", 12 - progress), finished))
    end,
  })
end)

vim.api.nvim_create_user_command("Q", "bd", {})
