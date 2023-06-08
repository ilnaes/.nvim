local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s(
    { trig = "fn", dscr = "Shorter function" },
    fmta(
      [[
      function<>(<>)
        <>
      end]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
  s(
    { trig = "ff", dscr = "Generic for loop" },
    fmta(
      [[
      for <> do
        <>
      end]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    { trig = "fi", dscr = "Iterate over array" },
    fmta(
      [[
      for <>, <> in ipairs(<>) do
        <>
      end]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),
  s(
    { trig = "fp", dscr = "Iterate over table" },
    fmta(
      [[
      for <>, <> in pairs(<>) do
        <>
      end]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),
}
