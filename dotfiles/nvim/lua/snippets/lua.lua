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

local group = vim.api.nvim_create_augroup('Lua Snippets', { clear = true })
local file_pattern = '*.lua'

local cs = utils.snippetCreateFnBuilder(snippets, autosnippets, file_pattern, group)

-- Start Refactoring --
cs( -- [local] Lua local variable snippet{{{
  'local',
  fmt(
    [[
local {} = {}
  ]],
    { i(1, ''), i(2, '') }
  ),
  { '<C-d>', 'jj' }
) --}}

-- End Refactoring --

return snippets, autosnippets
