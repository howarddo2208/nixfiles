if not pcall(require, 'harpoon') then
  return
end

local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'
local map = require('utils').map

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
