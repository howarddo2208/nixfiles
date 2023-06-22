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

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ debug UI                                                                 │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
local debug_open = function()
  dapui.open()
end

local debug_close = function()
  dapui.close()
  dap.repl.close()
end

dap.listeners.after.event_initialized["dapui_config"] = debug_open
dap.listeners.before.event_terminated["dapui_config"] = debug_close
dap.listeners.before.event_exited["dapui_config"] = debug_close
dap.listeners.before.disconnect["dapui_config"] = debug_close


local keybindings = require("keybindings")
local dapKeys = keybindings.dapKeys(debug_close)
local dapUIKeys = keybindings.dapUIKeys()

dapui.setup({
  mappings = dapUIKeys.mappings,
  icons = {
    expanded = "",
    collapsed = "",
  },
  layouts = {
    {
      -- 执行上下文/断点/堆栈信息/watch的变量
      position = "left",
      size = 35, -- 30% 宽度
      elements = {
        { id = "scopes", size = 0.5 },
        { id = "stacks", size = 0.5 },
        -- { id = "breakpoints", size = 0.25 },
        -- { id = "watches", size = 0.25 },
      },
    },
    {
      -- 控制台
      -- elements = { "repl", "console" },
      elements = { "repl" },
      position = "bottom",
      size = 0.3, -- 25% 高度
    },
  },
  floating = {
    border = "single", -- 边框: single | double | rounded
    mappings = dapUIKeys.floatingMappings,
  },
})

--  ╭──────────────────────────────────────────────────────────────────────────────╮
--  │ 加载适配器                                                                   │
--  ╰──────────────────────────────────────────────────────────────────────────────╯
dap.set_log_level("DEBUG")
dap.defaults.fallback.terminal_win_cmd = "30vsplit new"

-- 加载对应语言的debugger配置
local utils = require("dap.utils")
local command_path = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter"
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = command_path,
    args = { "${port}" },
  },
}

for _, lang in ipairs({ "javascript", "typescript" }) do
  dap.configurations[lang] = {
    {
      --- options: https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeArgs = {},
      runtimeExecutable = "node",
      skipFiles = { "**/node_modules/**" },
    },
  }
end
