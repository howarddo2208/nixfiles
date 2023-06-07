if not pcall(require, 'reach') then
  return
end

local map = require('utils').map

map('n', '<leader>b', ':ReachOpen buffers<CR>', { desc = 'Switch open buffers' })
map('n', '<leader>m', ':ReachOpen marks<CR>', { desc = 'Switch marked buffers' })
map('n', '<leader>t', ':ReachOpen tabpages<CR>', { desc = 'Switch tabpages' })
map('n', '<leader>rc', ':ReachOpen colorschemes<CR>', { desc = 'Switch colorschemea' })
