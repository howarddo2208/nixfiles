local ls = require 'luasnip'
local utils = require 'utils' --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup('Javascript Snippets', { clear = true })
local file_pattern = '*.js'

local cs = utils.snippetCreateFnBuilder(snippets, autosnippets, file_pattern, group)

-- Begin Refactoring --

cs( -- for([%w_]+) JS For Loop snippet{{{
  { trig = 'for([%w_]+)', regTrig = true, hidden = true },
  fmt(
    [[
for (let {} = 0; {} < {}; {}++) {{
  {}
}}

{}
    ]],
    {
      d(1, function(_, snip)
        return sn(1, i(1, snip.captures[1]))
      end),
      rep(1),
      c(2, { i(1, 'num'), sn(1, { i(1, 'arr'), t '.length' }) }),
      rep(1),
      i(3, '// TODO:'),
      i(4),
    }
  )
) --}}}
cs( -- [while] JS While Loop snippet{{{
  'while',
  fmt(
    [[
while ({}) {{
  {}
}}
  ]],
    {
      i(1, ''),
      i(2, '// TODO:'),
    }
  )
) --}}}
cs('cl', { t 'console.log(', i(1, ''), t ')' }, { 'jcl', 'jj' }) -- console.log

-- End Refactoring --

return snippets, autosnippets
