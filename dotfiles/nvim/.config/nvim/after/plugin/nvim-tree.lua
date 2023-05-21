if not pcall(require, 'nvim-tree') then
  return
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
  }
} -- END_DEFAULT_OPTS

vim.keymap.set('n', '\\', ':NvimTreeToggle<CR>', { desc = 'Toggle Explorer' })
