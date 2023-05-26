local M = {}

-- auto create folder when saving buffer incase the folder doesn't exist
-- reference: https://jdhao.github.io/2022/08/21/you-do-not-need-a-plugin-for-this/
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end
})

-- open telescope on startup
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   callback = function()
--     if #vim.fn.argv() == 0 then
--       vim.cmd("SessionManager load_session")
--     end
--   end
-- })

-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

local autoCommands = {
  highlight_yank = {
    { "TextYankPost", "*", "silent! lua vim.highlight.on_yank()" }
  },
  disable_autocomment = {
    { "FileType", "*", "setlocal formatoptions-=cro" }
  },
}

M.nvim_create_augroups(autoCommands)
