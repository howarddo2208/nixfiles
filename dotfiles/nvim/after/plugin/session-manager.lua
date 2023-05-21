local config = require('session_manager.config')
require('session_manager').setup({
  autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
})

-- autocommand open nvim-tree when session is loaded
local config_group = vim.api.nvim_create_augroup('SessionTree', {})
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = "SessionLoadPost",
  group = config_group,
  callback = function()
    require('nvim-tree.api').tree.toggle(false, true)
  end,
})

local map = require('utils').map

map('n', '<leader>ps', ':SessionManager load_session<CR>', { desc = 'Switch project sessions' })
map('n', '<leader>pa', ':SessionManager save_current_session<CR>', { desc = 'Add current project session' })
map('n', '<leader>pd', ':SessionManager delete_session<CR>', { desc = 'Delete project sessions' })
