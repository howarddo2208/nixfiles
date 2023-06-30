if not pcall(require, 'session_manager') then
  return
end

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

require('keybindings').sessionManagerKeys()
