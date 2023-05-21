-- KEYMAPS
local map = require('utils').map
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map('n', '<leader>lk', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', '<leader>lj', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', 'gL', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- highlight and move lines
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'move highlighted text down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'move highlighted text up' })

map('n', 'J', 'mzJ`z', { desc = 'group lines & keep cursor position' })

-- half page jumping and keep cursor at center of scree
map('n', '<C-d>', '<C-d>zz', { desc = 'scroll down half page' })
map('n', '<C-u>', '<C-u>zz', { desc = 'scroll up half page' })

-- keep search term in the middle
map('n', 'n', 'nzzzv', { desc = 'next match' })
map('n', 'N', 'Nzzzv', { desc = 'previous match' })

-- yank/delete without copy to clipboard
map('x', '<leader>p', [["_dP]], { desc = 'paste without copying deleted text' })
map({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'delete without copying text' })

-- yank to system clipboard
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'yank til end of line to system clipboard' })
map({ 'n', 'v' }, '<leader>P', [["+gP]], { desc = 'paste from system clipboard' })

-- quit
map('n', '<leader>Q', '<cmd>qa<cr>', { desc = 'quit all windows' })
map('n', '<leader>q', '<cmd>q<cr>', { desc = 'quit current window' })

-- saving with Ctrl+S
map({ 'i', 'n', 's' }, '<C-s>', '<ESC>:w<CR>', { desc = 'save buffer' })

-- delete current file, follow up with :bd or as I set <leader>c to unload buffer
map('n', '<leader>fd', '<cmd>!rm %<cr>', { desc = 'delete current file' })
map('n', '<leader>c', '<cmd>bd<cr>', { desc = 'Unload buffer' })

-- language server info
map('n', '<leader>li', '<cmd>LspInfo<CR>', { desc = 'LSP Info' })
map('n', '<leader>lI', '<cmd>Mason<CR>', { desc = 'Manage LSP servers' })

-- tab switching
map('n', '<M-t>', '<cmd>tabnew<CR>', { desc = 'new tab' })
map('n', '<M-Tab>', '<cmd>tabnext<CR>', { desc = 'next tab' })
map('n', '<M-S-Tab>', '<cmd>tabprevious<CR>', { desc = 'previous tab' })
