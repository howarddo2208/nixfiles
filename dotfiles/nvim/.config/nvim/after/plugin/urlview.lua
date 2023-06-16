if not pcall(require, 'urlview') then
  return
end

local map = require('utils').map

map('n', '<leader>u', "<Cmd>UrlView<CR>", { desc = 'View buffer URLs' })
map('n', '<leader>U', "<Cmd>UrlView lazy<CR>", { desc = 'View lazy plugin URLs' })
