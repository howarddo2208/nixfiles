if not pcall(require, 'winpick') then
  return
end

local winpick = require('winpick')

local function pick_window()
  local winid = winpick.select()

  if winid then
    vim.api.nvim_set_current_win(winid)
  end
end

vim.keymap.set('n', '<leader>ww', pick_window, { noremap = true, silent = true, desc = 'pick window' })
