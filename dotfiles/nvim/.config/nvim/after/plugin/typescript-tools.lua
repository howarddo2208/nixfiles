if not pcall(require, 'typescript-tools') then
  return
end

-- settings = {
--   tsserver_max_memory = 8092,
--   separate_diagnostic_server = false,
-- }
require("typescript-tools").setup {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    tsserver_plugins = {
      -- for TypeScript v4.9+
      "@styled/typescript-styled-plugin",
      -- or for older TypeScript versions
      -- "typescript-styled-plugin",
    },
  },
}

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

wk.register({
  ["<leader>T"] = {
    name = 'Typescript+',
    f = { ':TSToolsFixAll<CR>', "fix all" },
    s = { ':TSToolsSortImports<CR>', "sort imports" },
    r = { ':TSToolsRemoveUnusedImports<CR>', "remove unused imports" },
    R = { ':TSToolsRemoveUnused<CR>', "remove unused statements" },
    i = { ':TSToolsAddMissingImports<CR>', "add missign imports" },
    d = { ':TSToolsGoToSourceDefinition<CR>', "go to source definition" },
  },
})
