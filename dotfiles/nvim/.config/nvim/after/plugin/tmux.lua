local map = require('utils').map
-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<cmd>lua require("tmux").move_left()<cr>', { desc = 'Go to left window' })
map('n', '<C-j>', '<cmd>lua require("tmux").move_bottom()<cr>', { desc = 'Go to lower window' })
map('n', '<C-k>', '<cmd>lua require("tmux").move_top()<cr>', { desc = 'Go to upper window' })
map('n', '<C-l>', '<cmd>lua require("tmux").move_right()<cr>', { desc = 'Go to right window' })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Left>', '<cmd>lua require("tmux").resize_left()<cr>', { desc = 'Decrease window width' })
map('n', '<C-Down>', '<cmd>lua require("tmux").resize_bottom()<cr>', { desc = 'Decrease window height' })
map('n', '<C-Up>', '<cmd>lua require("tmux").resize_top()<cr>', { desc = 'Increase window height' })
map('n', '<C-Right>', '<cmd>lua require("tmux").resize_right()<cr>', { desc = 'Increase window width' })
