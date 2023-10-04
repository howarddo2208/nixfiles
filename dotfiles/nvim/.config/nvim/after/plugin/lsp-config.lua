-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.

require('keybindings').lspKeys()
local map = require('utils').map
-- references: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
-- use null-ls as default formatter
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  }
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local on_attach = function(client, bufnr)
  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- want to autoformat? uncomment below
        lsp_formatting(bufnr)
      end,
    })
  end
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {
  --   settings = {
  --     completeUnimported = true,
  --     usePlaceholders = true,
  --     analyses = {
  --       unusedparams = true,
  --       -- shadow = true,
  --     },
  --   }
  -- },
  -- pyright = {},
  -- tsserver = {
    -- settings = {
    --   typescript = {
    --     inlayHints = {
    --       -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
    --       includeInlayEnumMemberValueHints = true,
    --       includeInlayFunctionLikeReturnTypeHints = true,
    --       includeInlayFunctionParameterTypeHints = true,
    --       includeInlayParameterNameHints = 'all',
    --       includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- false
    --       includeInlayPropertyDeclarationTypeHints = true,
    --       includeInlayVariableTypeHints = true,
    --       includeInlayVariableTypeHintsWhenTypeMatchesName = true -- false
    --     }
    --   },
    --   javascript = {
    --     inlayHints = {
    --       includeInlayEnumMemberValueHints = true,
    --       includeInlayFunctionLikeReturnTypeHints = true,
    --       includeInlayFunctionParameterTypeHints = true,
    --       includeInlayParameterNameHints = 'all',
    --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    --       includeInlayPropertyDeclarationTypeHints = true,
    --       includeInlayVariableTypeHints = true,
    --       includeInlayVariableTypeHintsWhenTypeMatchesName = true
    --     }
    --   },
    -- },
  -- },
  emmet_ls = {},
  jsonls = {},
  -- clojure_lsp = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },
  ltex = {},
  -- nil_ls = {} -- nix LSP
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

require('mason').setup()
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- grammar and spell checker for markdown, latex and plain text. I use this for writing blogs as English is not my first language.
-- ltex-ls installed via mason require JAVA runtime, so download and install from github release page is better
require("lspconfig").ltex.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    require("ltex_extra").setup {}
  end,
}

if vim.lsp.inlay_hint then
  vim.keymap.set('n', '<leader>lh', function()
    vim.lsp.inlay_hint(0, nil)
  end, { desc = 'Toggle Inlay Hints' })
end

local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.api.nvim_set_keymap('n', 'gD', ':vsplit<CR>gd<CR>', { silent = true, desc = 'definition in vertical split' })
