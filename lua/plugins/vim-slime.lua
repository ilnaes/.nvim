return {
  "jpalardy/vim-slime",
  lazy = false,
  config = function()
    local noremap = require("util").noremap
    local v = vim

    v.g["slime_target"] = "tmux"
    v.g["slime_dont_ask_default"] = 1
    v.g["slime_default_config"] = { socket_name = "default", target_pane = "{last}" }

    local function send_word()
      local reg_save = v.fn.getreg('"')
      local save_pos = v.api.nvim_win_get_cursor(0)
      v.cmd('silent exe "normal! viwy"')
      v.fn["slime#send"](v.fn.getreg('"') .. "\r")
      v.api.nvim_win_set_cursor(0, save_pos)
      v.fn.setreg('"', reg_save)
    end

    noremap("n", "\\ww", send_word)
    noremap("v", "\\vv", "<Plug>SlimeRegionSend")
    noremap("n", "\\ll", "<Plug>SlimeLineSend")
    noremap("n", "\\pp", "<Plug>SlimeParagraphSend")
    noremap("n", "\\cc", "<Plug>SlimeSendCell")
  end,
}
