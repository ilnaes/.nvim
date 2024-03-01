return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "powerline",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { { "diagnostics", sources = { "ale", "coc" } } },
        lualine_z = { "%3p%% %3l/%L:%3v" },
      },
      tabline = {
        lualine_c = {},
        lualine_b = {},
        lualine_a = {
          {
            "buffers",
            show_filename_only = false,
            symbols = {
              alternate_file = "", -- Text to show to identify the alternate file
              directory = "", -- Text to show when the buffer is a directory
            },
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },
    })
  end,
}
