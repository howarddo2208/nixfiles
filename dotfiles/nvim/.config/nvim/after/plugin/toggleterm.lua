if not pcall(require, 'toggleterm') then
  return
end

-- below I steal from https://github.com/liaohui5/dotfiles/blob/d935bdcfd8a04d6112b380d071df06442b2b48b3/nvim/lua/plugins/toggleterm.lua

-- ╭───────────────────────────────────────────────────────────────────────────────────╮
-- │  Toggleterm                                                                       │
-- │  docs: https://github.com/akinsho/toggleterm.nvim                                 │
-- ╰───────────────────────────────────────────────────────────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────────────────────────────╮
-- │ Terminal API                                                                     │
-- │ https://github.com/akinsho/toggleterm.nvim/blob/main/lua/toggleterm/terminal.lua │
-- ╰──────────────────────────────────────────────────────────────────────────────────╯
-- new
-- toggle
-- is_open
-- open
-- close
-- shutdown
local toggleterm = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal
local plugins = {}
local float_opts = {
  border = "double", -- single | double | shadow | curved
  winblend = 1,
  width = function()
    return math.floor(vim.o.columns * 0.95)
  end,
  height = function()
    return math.floor(vim.o.lines * 0.95)
  end,
}

local function createTerminal(cmd)
  return Terminal:new({
    cmd = cmd,
    hidden = true,
    direction = "float",
    float_opts = float_opts,
  })
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 集成 tig                                                                     │
-- │ https://github.com/jonas/tig                                                 │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- plugins.tig = function()
--   return createTerminal("tig")
-- end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  集成 vifm                                                                   │
-- │  https://github.com/vifm/vifm                                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
plugins.vifm = function()
  local buffPath = vim.fn.expand("%:p:h")
  local rootPath = vim.fn.getcwd()
  local commands = string.format("vifm %s %s", buffPath, rootPath)
  return createTerminal(commands)
end

local keys = require("keybindings").toggletermKeys(plugins)
toggleterm.setup({
  -- on_close          = function() end
  -- on_stdout         = function() end
  -- on_stderr         = function() end
  -- on_exit           = function() end
  -- shell             = vim.o.shell, -- 打开终端使用的shell: 不建议修改, 默认使用系统默认的 shell
  on_open = function(term)
    if _G.buffPath then
      term:change_dir(_G.buffPath)
    end
  end,
  open_mapping = keys,
  hide_numbers = true,
  shade_terminals = false,
  persist_size = true,
  start_in_insert = true,
  shading_factor = 1,
  insert_mappings = true,
  terminal_mappings = true,
  persist_mode = false,
  direction = "float",  -- vertical | horizontal | tab | float
  float_opts = float_opts,
  close_on_exit = true, -- close the terminal window when the process exits
  auto_scroll = true,   -- automatically scroll to the bottom on terminal output
  shade_filetypes = {},
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
})

local wk = require "which-key"
