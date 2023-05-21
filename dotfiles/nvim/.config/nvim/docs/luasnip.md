WIP
```lua
-- EXAMPLE SNIPPETS: based on tutorial
--@todo: write docs about this and clean up the examples
local myFirstSnippet = s("my first snippet", {
	t("hello, that is my first snippet in luasnip"),
	i(1, " placeholder_text"),
	t({ "", "another line here" })
})
table.insert(snippets, myFirstSnippet)

local mySecondSnippet = s("mySecondSnippet", fmt([[
local {} = function({})
{}
end
]], {
	i(1, "myVar"),
	c(2, { t(""), i(1, "myArgs") }),
	i(3, "doSth"),
}))
table.insert(snippets, mySecondSnippet)

local myFirstAutoSnippet = s("auto trigger", { t("this is my first autosnippet") })
table.insert(autosnippets, myFirstAutoSnippet)

-- reference: https://riptutorial.com/lua/example/20315/lua-pattern-matching
local myFirstRegexTrigger = s({ trig = "regex%d", regTrig = true }, { t("this is my first regex snippet") })
table.insert(autosnippets, myFirstRegexTrigger)

--function node
local myFunctionSnippet = s({ trig = "digit(%d)(%d)", regTrig = true }, {
	f(function(_, snip)
		return snip.captures[1] .. " and "
	end),
	f(function(_, snip)
		return snip.captures[2]
	end),
})
table.insert(autosnippets, myFunctionSnippet)
-- type "digit33" --> 3 and 3

-- function node example 2
local myFunctionSnippet2 = s({ trig = "fn2(%d)(%d)", regTrig = true }, {
	i(1, "type in here"),
	f(function(args, snip)
		return args[1][1]
	end, 1),
})
table.insert(autosnippets, myFunctionSnippet2)
-- type in fnn2%d%d -> replicate 2 times your input node

-- function node example 3
local myFunctionSnippet3 = s({ trig = "auto3", regTrig = true }, {
	i(1, "uppercase one"),
	f(function(args, snip)
		return args[1][1]:upper() .. args[2][1]:lower()
	end, { 1, 2 }),
	i(2, "LOWERCASE ONE")
})
table.insert(autosnippets, myFunctionSnippet3)
-- type in auto3 
-- uppercase portion....UPPERCASE PORTION....lowercase portion......LOWERCASE PORTION......

-- rep function -> repeat
local myRepSnippet = s({ trig = "repSnippet", regTrig = true }, {
	i(1, "type in here"),
	rep(1)
})
table.insert(autosnippets, myRepSnippet)
-- type in: repeatSnippet -> repeat what I typetype in: repeatSnippet -> repeat what I typerepSnippet
```
