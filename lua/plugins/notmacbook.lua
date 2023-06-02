if not require("util").macbook then
  return {
    "neoclide/coc.nvim",
    branch = "release",
  }
else
  return {}
end
