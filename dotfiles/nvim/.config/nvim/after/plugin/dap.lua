-- steal from: https://github.com/liaohui5/dotfiles/blob/c9fb097b98506f3091ba1fe30f953f22bb53f857/nvim/lua/plugins/dap.lua
----------------------------------------------------------------------------------------
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Javascript
-- https://github.com/microsoft/vscode-js-debug
-- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
-- https://github.com/mxsdev/nvim-dap-vscode-js
----------------------------------------------------------------------------------------
local ok1, dap = pcall(require, "dap")
local ok2, dapui = pcall(require, "dapui")

if not ok1 then
  print("dap not found")
  return
end

if not ok2 then
  print("dapui not found")
  return
end

local keybindings = require("keybindings")

keybindings.dapKeys()

dapui.setup({})
keybindings.dapUIKeys()

require("nvim-dap-virtual-text").setup({})
require('telescope').load_extension('dap')
keybindings.dapTelescopeKeys()


require("mason-nvim-dap").setup({
  ensure_installed = { "delve" }
})

require('dap-go').setup({})
keybindings.languages.go.dapGoKeys()

-- auto open dapui on debug
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ breakpoint symbol                                                            │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
local breakpoint = {
  error = {
    text = "🔴",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  rejected = {
    text = "❌",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "🟡",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint", breakpoint.error)
vim.fn.sign_define("DapStopped", breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", breakpoint.rejected)
