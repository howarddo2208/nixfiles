local M = {}

M.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
  -- NOTE: if you want to lazyload the keymap, use this instead:
  -- local keys = require("lazy.core.handler").handlers.keys
  -- -- do not create the keymap if a lazy keys handler exists
  -- if not keys.active[keys.parse({ lhs, mode = mode }).id] then
  --   opts = opts or {}
  --   opts.silent = opts.silent ~= false
  --   vim.keymap.set(mode, lhs, rhs, opts)
  -- end
end

-- SNIPPET CREATOR FUNCTION BUILDER
local ls = require 'luasnip'
M.snippetCreateFnBuilder = function(snippets, autosnippets, file_pattern, group)
  -- whenever using this to create snippet, must switch buffer in order to BufEnter event to trigger -> hot reload sniippet
  local function createSnippet(trigger, nodes, opts)
    local snippet = ls.s(trigger, nodes)
    local target_table = snippets

    local pattern = file_pattern
    local keymaps = {}

    if opts ~= nil then
      -- check for custom pattern
      if opts.pattern then
        pattern = opts.pattern
      end

      -- if opts is a string
      if type(opts) == 'string' then
        if opts == 'auto' then
          target_table = autosnippets
        else
          table.insert(keymaps, { 'i', opts })
        end
      end

      -- if opts is a table
      if opts ~= nil and type(opts) == 'table' then
        for _, keymap in ipairs(opts) do
          if type(keymap) == 'string' then
            table.insert(keymaps, { 'i', keymap })
          else
            table.insert(keymaps, keymap)
          end
        end
      end

      -- set autocmd for each keymap
      if opts ~= 'auto' then
        for _, keymap in ipairs(keymaps) do
          vim.api.nvim_create_autocmd('BufEnter', {
            pattern = pattern,
            group = group,
            callback = function()
              vim.keymap.set(keymap[1], keymap[2], function()
                ls.snip_expand(snippet)
              end, { noremap = true, silent = true, buffer = true })
            end,
          })
        end
      end
    end
    table.insert(target_table, snippet) -- insert snippet into appropriate table
  end

  return createSnippet
end

return M
