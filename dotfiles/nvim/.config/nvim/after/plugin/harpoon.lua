if not pcall(require, 'harpoon') then
  return
end

local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'
local map = require('utils').map
require("telescope").load_extension('harpoon')
map('n', '<leader>hs', ':Telescope harpoon marks<CR>', { desc = 'Search harpoon marks' })

map('n', '<leader>ha', mark.add_file, { desc = 'add file to harpoon' })
map('n', '<leader>hh', ui.toggle_quick_menu, { desc = 'toggle harpoon quick menu' })

map('n', '<leader>1', function()
  ui.nav_file(1)
end, { desc = 'navigate to harpoon 1' })
map('n', '<leader>2', function()
  ui.nav_file(2)
end, { desc = 'navigate to harpoon 2' })
map('n', '<leader>3', function()
  ui.nav_file(3)
end, { desc = 'navigate to harpoon 3' })
map('n', '<leader>4', function()
  ui.nav_file(4)
end, { desc = 'navigate to harpoon 4' })
map('n', '<leader>5', function()
  ui.nav_file(5)
end, { desc = 'navigate to harpoon 5' })
map('n', '<leader>6', function()
  ui.nav_file(6)
end, { desc = 'navigate to harpoon 6' })
map('n', '<leader>7', function()
  ui.nav_file(7)
end, { desc = 'navigate to harpoon 7' })
map('n', '<leader>8', function()
  ui.nav_file(8)
end, { desc = 'navigate to harpoon 8' })
map('n', '<leader>9', function()
  ui.nav_file(9)
end, { desc = 'navigate to harpoon 9' })
map('n', '<leader>0', function()
  ui.nav_file(10)
end, { desc = 'navigate to harpoon 10' })
