if not pcall(require, 'copilot') then
  return
end

require('copilot').setup {
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = '<C-p>',
      jump_next = '<C-n>',
      accept = '<CR>',
      refresh = 'gr',
      open = '<M-\\>',
    },
    layout = {
      position = 'bottom', -- | top | left | right
      ratio = 0.4,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-y>",
      accept_word = false,
      accept_line = false,
      next = '<M-]>',
      prev = '<M-[>',
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ['.'] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {
    -- trace = "verbose",
    -- settings = {
    --   advanced = {
    --     listCount = 10,         -- #completions for panel
    --     inlineSuggestCount = 3, -- #completions for getCompletions
    --   }
    -- },
  },
}

local map = require('utils').map
map('n', '<leader>cp', '<CMD>Copilot panel<CR>', { desc = 'Copilot panel' })
map('n', '<leader>ct', '<CMD>Copilot toggle<CR>', { desc = 'Copilot toggle' })
map('n', '<leader>cs', '<CMD>Copilot suggestion<CR>', { desc = 'Copilot suggestion' })
