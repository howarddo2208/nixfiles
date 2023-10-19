-- KEYMAPS
-- TODO: merge keybindings and keymaps together
local map = require('utils').map
local M = {}
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- yank/delete without copy to clipboard
map('x', '<leader>p', [["_dP]], { desc = 'paste without copying deleted text' })
map({ 'n', 'v' }, '<leader>D', [["_d]], { desc = 'delete without copying text' })

-- yank to system clipboard
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'yank til end of line to system clipboard' })
map({ 'n', 'v' }, '<leader>P', [["+gP]], { desc = 'paste from system clipboard' })

-- saving with Ctrl+S
map({ 'i', 'n', 's' }, '<C-s>', '<ESC>:silent! w<CR>', { desc = 'save buffer' })

-- add semicolon, comma to the end of line
map('i', '<M-;>', '<ESC>A;<ESC>', { desc = 'add semicolon to the end of the line' })
map('i', '<M-,>', '<ESC>A,<ESC>', { desc = 'add comma to the end of the line' })

map('n', '<leader>cp', ':let @*=@%<CR>', { desc = 'copy buffer relative path to system clipboard' })
map('n', '<leader>cP', ':let @*=expand("%:p")<CR>', { desc = 'copy buffer absolute path to system clipboard' })

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

keybindings.general = function()
  wk.register({
    ['<C-d>'] = { "<C-d>zz", "scroll down half page" },
    ['<C-u>'] = { '<C-u>zz', "scroll up half page", },
    ['n'] = { 'nzzzv', "next match", },
    ['N'] = { 'Nzzzv', "previous match", },
    ['gl'] = { vim.diagnostic.open_float, "Open floating diagnostic message", },
    ['gL'] = { vim.diagnostic.setloclist, "Open diagnostics list", },
    ['<leader>fd'] = { '<cmd>!rm %<cr>', 'delete current file' },
    ['<leader>q'] = { '<cmd>Bd<cr>', 'Unload buffer without closing window' },
    ['<leader>Q'] = { '<cmd>qa<cr>', 'close all buffers' },
    ['<M-t>'] = { '<cmd>tabnew<cr>', 'New tab' },
    ['<M-Tab>'] = { '<cmd>tabnext<cr>', 'next tab' },
    ['<M-S-Tab>'] = { '<cmd>tabprevious<cr>', 'previous tab' },
    ['J'] = { 'mzJ`z', 'group lines' }
  }, normalModeOpts)
  wk.register({
    J = { ":m '>+1<CR>gv=gv", "move highlighted text down" },
    K = { ":m '<-2<CR>gv=gv", 'move highlighted text up' }
  }, visualModeOpts)
end
keybindings.general()

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                          ctrl + \ : toggleterm                               │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.toggletermKeys = function(plugins)
  wk.register({
    ["<leader>ox"] = {
      function()
        _G.buffPath = vim.fn.expand("%:p:h")
        vim.cmd("ToggleTerm2")
        _G.buffPath = nil
      end,
      "open terminal in current directory",
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

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                   dap                                        │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.dapKeys = function()
  local function dap_call_fn(fn)
    return string.format("<cmd>lua require('dap').%s<CR>", fn)
  end

  wk.register({
    ["<leader>d"] = {
      name = "+Debugger",
      t = { dap_call_fn("toggle_breakpoint()"), "toggle breakpoint(F4)", },
      d = { dap_call_fn("continue()"), "continue/start debug(F5)", },
      i = { dap_call_fn("step_into()"), "debug step in(F1)", },
      O = { dap_call_fn("step_over()"), "debug step over(F2)", },
      o = { dap_call_fn("step_out()"), "debug step out(F3)", },
      B = { dap_call_fn("set_breakpoint(vim.fn.input('Breakpoint condition: '))"), "Breakpoint condition", },
      p = { dap_call_fn("set_breakpoint(nil, nil, vim.fn.input('Log point message: '))"), "Log point", },
      r = { dap_call_fn("repl.open()"), "open REPL", },
      l = { dap_call_fn("run_last()"), "run last", },
    },
  })

  wk.register({
    ["<F5>"] = { dap_call_fn("continue()"), "start debug(F5)", },
    ["<F4>"] = { dap_call_fn("toggle_breakpoint()"), "toggle breakpoint(F9)", },
    ["<F1>"] = { dap_call_fn("step_into()"), "debug step in(F1)", },
    ["<F2>"] = { dap_call_fn("step_over()"), "debug step over(F2)", },
    ["<F3>"] = { dap_call_fn("step_out()"), "debug step out(F3)", },
  }, normalModeOpts)
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                    dapUI                                     │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
keybindings.dapUIKeys = function()
  wk.register({
    ["<leader>du"] = { ":lua require('dapui').toggle()<CR>", "Toggle DAP UI" }
  })
end

keybindings.lspsagaKeys = function()
  wk.register({
    ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "Lspsaga lsp_finder", },
    ["<leader>la"] = { "<cmd>Lspsaga code_action<CR>", "Lspsaga code_action", },
    -- ["gr"] = { "<cmd>Lspsaga rename<CR>", "Lspsaga rename", },
    ["gR"] = { "<cmd>Lspsaga rename ++project<CR>", "Lspsaga rename ++project", },
    ["gd"] = { "<cmd>Lspsaga goto_definition<CR>", "Lspsaga goto_definition", },
    ["gT"] = { "<cmd>Lspsaga goto_type_definition<CR>", "Lspsaga goto_type_definition", },
    ["<leader>ll"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Lspsaga show_line_diagnostics", },
    ["<leader>lb"] = { "<cmd>Lspsaga show_buf_diagnostics<CR>", "Lspsaga show_buf_diagnostics", },
    ["<leader>lw"] = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Lspsaga show_workspace_diagnostics", },
    ["<leader>lc"] = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Lspsaga show_cursor_diagnostics", },
    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "previous diagnostic", },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "next diagnostic", },
    ["[e"] = {
      function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
      "previous error",
    },
    ["]e"] = {
      function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
      "next error",
    },
    ["<leader>o"] = { "<cmd>Lspsaga outline<CR>", "Lspsaga outline", },
    ["K"] = { "<cmd>Lspsaga hover_doc ++keep<CR>", "Lspsaga hover_doc ++keep", },
    ["<Leader>ln"] = { "<cmd>Lspsaga incoming_calls<CR>", "Lspsaga incoming_calls", },
    ["<Leader>lo"] = { "<cmd>Lspsaga outgoing_calls<CR>", "Lspsaga outgoing_calls", },
  }, normalModeOpts)
end

keybindings.lspKeys = function()
  wk.register({
    ["<leader>l"] = {
      name = '+Language Server',
      s = { "<cmd>LspStart<CR>", "Start LSP", },
      S = { "<cmd>LspStop<CR>", "Stop LSP", },
      r = { vim.lsp.buf.rename, "Rename", },
      R = { "<cmd>LspRestart<CR>", "Restart LSP", },
      i = { "<cmd>LspInfo<CR>", "LSP Info", },
      I = { "<cmd>Mason<CR>", "Manage LSP servers", },
      -- a = {
      --   vim.lsp.buf.code_action,
      --   "[C]ode [A]ction",
      -- },
    },
    -- ["gd"] = {
    --   vim.lsp.buf.definition,
    --   "[G]oto [D]efinition",
    -- },
    ["gr"] = {
      require('telescope.builtin').lsp_references,
      "[G]oto [R]eferences",
    },
    -- ["gI"] = {
    --   vim.lsp.buf.implementation,
    --   "[G]oto [I]mplementation",
    -- },
    -- ["<leader>D"] = {
    --   vim.lsp.buf.type_definition,
    --   "Type [D]efinition",
    -- },
    ["<leader>ss"] = {
      require('telescope.builtin').lsp_document_symbols,
      "Search document symbols",
    },
    ["<leader>sS"] = {
      require('telescope.builtin').lsp_dynamic_workspace_symbols,
      "Search workspace symbols",
    },
    -- ["K"] = {
    --   vim.lsp.buf.hover,
    --   "Hover Documentation",
    -- },
    -- ["<M-k>"] = {
    --   vim.lsp.buf.signature_help,
    --   "Signature Documentation",
    -- },
    -- ["gD"] = {
    --   vim.lsp.buf.declaration,
    --   "[G]oto [D]eclaration",
    -- },
    ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder", },
    ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder", },
    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "[W]orkspace [L]ist Folders",
    },
    ["gq"] = {
      vim.lsp.buf.format,
      "Format buffer",
    },
  }, normalModeOpts)
end

keybindings.languages = {
  rust = {
    rustToolsKeys = function()
      wk.register({
        ["<leader>R"] = {
          name = '+Rust',
          h = { "<cmd>RustHoverActions<CR>", "show hover actions", },
          a = { "<cmd>RustCodeAction<CR>", "show code actions" },
          r = { "<cmd>RustRunnables<CR>", "show runnables", },
          p = { "<cmd>RustParentModule<CR>", "show parent module", },
          j = { "<cmd>RustMoveItemDown<CR>", "move item down", },
          k = { "<cmd>RustMoveItemUp<CR>", "move item up", }
        }
      })
    end,
    cratesKeys = function()
      wk.register({
        ["<leader>Ru"] = {
          function()
            require("crates").update_all_crates()
          end,
          "update all crates",
        },
      })
    end
  },
  go = {
    dapGoKeys = function()
      wk.register({
        ["<leader>G"] = {
          d = { require('dap-go').debug_test,
            "Go: debug go test"
          },
          l = { require('dap-go').debug_last,
            "Go: debug last go test"
          },
        },
      })
    end,
    gopherKeys = function()
      wk.register({
        ["<leader>G"] = {
          name = "Go+",
          j = { "<cmd>GoTagAdd json<CR>", "Add json struct tags", },
          y = { "<cmd>GoTagAdd yaml<CR>", "Add yaml struct tags", },
          T = { "<cmd>GoMod tidy<CR>", "Run go mod tidy", },
          g = { "<cmd>GoGet ", "get go package", },
          i = { "<cmd>GoImpl ", "Implent interface", },
          c = { "<cmd>GoCmt<CR>", "Add comment", },
          r = { "<cmd>!go run main.go<CR>", "run main.go", },
          t = { "<cmd>!go test<CR>", "Run tests", },
          b = { "<cmd>!go build<CR>", "Build binary", },
        }
      })
    end
  }
}

keybindings.sessionManagerKeys = function()
  wk.register({
    ["<leader>p"] = {
      name = "Project Session Manager",
      s = { "<cmd>SessionManager load_session<CR>", "switch project session", },
      a = { "<cmd>SessionManager save_current_session<CR>", "Load session", },
      d = { "<cmd>SessionManager delete_session<CR>", "Delete session", },
    },
  })
end

keybindings.dapTelescopeKeys = function()
  wk.register({
    ["<leader>ds"] = {
      "<Cmd>Telescope dap search commands<CR>",
      "DAP search commands",
    },
    ["<leader>dC"] = {
      "<Cmd>Telescope dap configurations<CR>",
      "DAP search configurations",
    },
    ["<leader>dP"] = {
      "<Cmd>Telescope dap list_breakpoints<CR>",
      "DAP search breakpoints",
    },
    ["<leader>df"] = {
      "<Cmd>Telescope dap frames<CR>",
      "DAP search frames",
    },
    ["<leader>dv"] = {
      "<Cmd>Telescope dap variables<CR>",
      "DAP search variables",
    },
  })
end

return keybindings
