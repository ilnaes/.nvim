local map = vim.api.nvim_set_keymap

local M = {}

local function modes_map(modes, key, command, option)
	for i = 1, #modes do
		map(modes:sub(i, i), key, command, option)
	end
end

function M.noremap(mode, key, command, options, fn)
	local option = { noremap = true }

	if fn == nil then
		fn = modes_map
	end

	if options ~= nil then
		for k, v in pairs(options) do
			option[k] = v
		end
	end
	fn(mode, key, command, option)
end

function M.toggle_quickfix()
	local winid = vim.fn.getloclist(0, { winid = 0 }).winid

	if winid == 0 then
		vim.cmd.lopen()
	else
		vim.cmd.lclose()
	end
end

M.noremap("n", ";", ":")

M.noremap("i", "<cr>", "((pumvisible())?(<C-y>):(<cr>))", { expr = true })
M.noremap("n", "<c-e>", ':lua (require("maps")).toggle_quickfix()<CR>')
M.noremap("nv", "j", "gj")
M.noremap("nv", "k", "gk")
M.noremap("n", "<C-l>", ":bnext<CR>")
M.noremap("n", "<C-h>", ":bprev<CR>")

M.noremap("n", "<Leader>f", ":Files<CR>")
M.noremap("n", "<Leader>a", ":Rg<CR>")
M.noremap("n", "<Leader>t", ":Tags<CR>")

M.noremap("v", "<Leader>y", '"*y')
M.noremap("n", "<Leader>p", '"*p')
M.noremap("n", "<Leader>h", ":noh<CR>")

return M

-- nmap <silent> <buffer> \ww :call SendWord()<CR>
-- vmap \cc <Plug>SlimeRegionSend
-- nmap \ll <Plug>SlimeLineSend
-- nmap \pp <Plug>SlimeParagraphSend
-- nmap \cc <Plug>SlimeSendCell
