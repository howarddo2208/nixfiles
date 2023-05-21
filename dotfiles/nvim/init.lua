-- [[ Setting options ]]
-- See `:help vim.o`

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: load all plugins from 'lua/plugins.lua'
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
--  if you want to further config them, create a file in `after/plugin`
require('lazy').setup('plugins', {
  dev = {
    -- directory where you store your local plugin projects
    path = '~/plugins',
    fallback = false,
  },
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      source = '📄',
      start = '🚀',
      task = '📌',
    },
  },
  git = {
    timeout = 300
  }
})

require 'options'
require 'keymaps'
require 'autocommands'
require 'appearance'
