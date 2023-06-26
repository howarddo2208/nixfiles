if not pcall(require, 'nvim-tree') then
  return
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- better mapping to use with flash.nvim
  vim.keymap.del('n', 's', { buffer = bufnr })
  vim.keymap.set('n', 'o', api.node.run.system, opts('Run System'))
end

-- empty setup using defaults
require('nvim-tree').setup { -- BEGIN_DEFAULT_OPTS
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
  git = {
    -- show ignored files
    ignore = false
  },
  on_attach = my_on_attach,
} -- END_DEFAULT_OPTS

vim.keymap.set('n', '\\', ':NvimTreeToggle<CR>', { desc = 'Toggle Explorer' })
