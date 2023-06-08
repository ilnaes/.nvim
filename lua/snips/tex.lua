local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local ret = {
  s(
    { trig = "fr", dscr = "Fraction" },
    fmta("\\frac{<>}{<>}", {
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "ov", dscr = "Overset" },
    fmta("\\overset{<>}{<>}", {
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "bb" },
    fmta(
      [[
      \begin{<>}
        <>
      \end{<>}
    ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    )
  ),
  s(
    { trig = "ci" },
    fmta("\\cite{<>}", {
      i(1),
    })
  ),
  s(
    { trig = "ma" },
    fmta(
      [[
      \left(\begin{array}{<>}
        <>
      \end{array}\right)
    ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    { trig = "ena" },
    fmta(
      [[
    \begin{enumerate}[label=(\arabic*)]
      \item <>
    \end{enumerate}]],
      { i(1) }
    )
  ),
  s(
    { trig = "enn" },
    fmta(
      [[
    \begin{enumerate}[label=(\alph*)]
      \item <>
    \end{enumerate}]],
      { i(1) }
    )
  ),
  s(
    { trig = "it" },
    fmta(
      [[
    \begin{itemize}
      \item <>
    \end{itemize}]],
      { i(1) }
    )
  ),
  s(
    { trig = "lr" },
    fmta([[\left<> <> \right<>]], {
      i(1),
      i(2),
      f(function(args)
        local close = { ["("] = ")", ["\\{"] = "\\}", ["|"] = "|", ["["] = "]", ["\\|"] = "\\|" }
        local ret = close[args[1][1]]
        if ret == nil then
          return ""
        end
        return ret
      end, { 1 }),
    })
  ),
}

for k, v in pairs({ cu = "bigcup", ca = "bigcap", su = "sum", ["in"] = "int" }) do
  table.insert(ret, s({ trig = k }, fmta([[\<>_{<>}]], { t(v), i(1) })))
end

local envs = {
  mm = "align*",
  pf = "proof",
  ml = "multline*",
  ca = "cases",
  rm = "remark",
  th = "theorem",
  lm = "lemma",
  pr = "proposition",
  co = "corollary",
}

for k, v in pairs(envs) do
  table.insert(
    ret,
    s(
      { trig = k },
      fmta(
        [[
      \begin{<>}
        <>
      \end{<>}
    ]],
        {
          t(v),
          i(1),
          t(v),
        }
      )
    )
  )
end

return ret
