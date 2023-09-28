if not pcall(require, 'refactoring') then
  return
end

require('refactoring').setup {
  prompt_func_return_type = {
    go = false,
    java = false,
    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
  },
  prompt_func_param_type = {
    go = false,
    java = false,
    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
  },
  printf_statements = {},
  print_var_statements = {},
}

-- prompt for a refactor to apply when the remap is triggered
vim.api.nvim_set_keymap(
  'v',
  '<leader>r',
  ":lua require('refactoring').select_refactor()<CR>",
  { noremap = true, silent = true, expr = false, desc = 'Refactor' }
)


vim.keymap.set(
  "n",
  "<leader>rn",
  function() require('refactoring').debug.printf() end,
  { desc = 'print checkpoint below' }
)
vim.keymap.set(
  "n",
  "<leader>rN",
  function() require('refactoring').debug.printf({ below = false }) end,
  { desc = 'print checkpoint above' }
)

vim.keymap.set({ "x", "n" }, "<leader>rp", function() require('refactoring').debug.print_var() end,
  { desc = 'print variable below' })
vim.keymap.set({ "x", "n" }, "<leader>rP", function() require('refactoring').debug.print_var({ below = false }) end,
  { desc = 'print variable above' })
vim.keymap.set("n", "<leader>rd", function() require('refactoring').debug.cleanup({}) end,
  { desc = 'cleanup debug prints' })
