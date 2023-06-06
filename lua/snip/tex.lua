local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
  s(
    { trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'" },
    fmta("\\frac{<>}{<>}", {
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "beg" },
    fmta(
      [[
      \begin{<>}
        <>
      \end{<>}
    ]],
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),
}
