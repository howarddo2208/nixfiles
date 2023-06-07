-- steal from https://github.com/liaohui5/dotfiles/blob/d935bdcfd8a04d6112b380d071df06442b2b48b3/nvim/lua/keybindings.lua
-- the repo structure is really interesting, will steal more
local wk = require("which-key")
local function createBindKeyOpts(mode)
  return {
    mode = mode,
    noremap = true,
    silent = true,
    noawait = true,
  }
end
local normalModeOpts = createBindKeyOpts("n")
local visualModeOpts = createBindKeyOpts("v")
local operateModeOpts = createBindKeyOpts("o")
local keybindings = {
}

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                          ctrl + x : toggleterm                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.toggletermKeys = function(plugins)
  local toggle_lazygit = function()
    plugins.lazygit():toggle()
  end
  wk.register({
    ["<leader>ox"] = {
      function()
        _G.buffPath = vim.fn.expand("%:p:h")
        vim.cmd("ToggleTerm2")
        _G.buffPath = nil
      end,
      "open terminal in current directory",
    },
    ["<leader>gg"] = {
      toggle_lazygit,
      "toggle lazygit",
    },
    ["<C-g>"] = {
      toggle_lazygit,
      "toggle lazygit",
    },
    ["<C-f>"] = {
      function()
        plugins.vifm():toggle()
      end,
      "toggle vifm",
    },
  }, normalModeOpts)
  return "<C-\\>" -- toggle terminal
end

return keybindings
