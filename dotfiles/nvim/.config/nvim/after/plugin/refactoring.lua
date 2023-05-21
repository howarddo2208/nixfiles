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
