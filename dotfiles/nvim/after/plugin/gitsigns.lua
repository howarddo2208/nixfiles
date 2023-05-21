if not pcall(require, 'gitsigns') then
  return
end

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = require 'gitsigns'

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, nowait = true, desc = desc })
    end

    -- Navigation
    map('n', '<leader>gj', function()
      if vim.wo.diff then
        return ']g'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, 'Jump to next hunk')

    map('n', '<leader>gk', function()
      if vim.wo.diff then
        return '[g'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, 'Jump to previous hunk')

    -- Actions
    map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
    map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Reset hunk')
    map('n', '<leader>gS', gs.stage_buffer, 'Stage buffer')
    map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo stage hunk')
    map('n', '<leader>gR', gs.reset_buffer, 'Reset buffer')
    map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
    map('n', '<leader>gb', function()
      gs.blame_line { full = true }
    end, 'Blame line')
    map('n', '<leader>ub', gs.toggle_current_line_blame, 'Toggle current line blame')
    map('n', '<leader>gd', gs.diffthis, 'Diff this hunk against index')
    map('n', '<leader>gD', function()
      gs.diffthis '~'
    end, 'Diff this hunk against working tree')
    map('n', '<leader>gt', gs.toggle_deleted, 'Toggle deleted')

    -- Text object
    map({ 'o', 'x' }, 'ig', ':<C-U>Gitsigns select_hunk<CR>', 'Select current hunk')
  end,
}
