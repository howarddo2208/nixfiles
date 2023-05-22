if not pcall(require, 'reach') then
  return
end

local map = require('utils').map

map('n', '<leader>rb', ':ReachOpen buffers<CR>', { desc = 'Switch open buffers' })
map('n', '<leader>rm', ':ReachOpen marks<CR>', { desc = 'Switch marked buffers' })
map('n', '<leader>rt', ':ReachOpen tabpages<CR>', { desc = 'Switch tabpages' })
map('n', '<leader>rc', ':ReachOpen colorschemes<CR>', { desc = 'Switch colorschemea' })
