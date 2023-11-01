local map = require('utils').map

-- search cheat.sh
map('n', '<leader>cc', ':Cheat<CR>', { desc = 'Search cheat.sh' })
map('n', '<leader>cC', ':CheatList<CR>', { desc = 'Search cheat.sh list' })

-- search local cheatsheet
map('n', '<leader>cl', ':Cheatsheet<CR>', { desc = 'Search local cheatsheet' })
map('n', '<leader>ce', ':CheatsheetEdit<CR>', { desc = 'Edit local cheatsheet' })
