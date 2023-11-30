-- vim.api.nvim_set_hl(0, "NormalFloat", {
--   bg = "bg",
--   fg = '#d8bd92',
-- })

-- vim.api.nvim_set_hl(0, "FloatBorder", {
--   bg = "bg",
--   fg = '#d8bd92',
-- })
require('catppuccin').setup {
  flavour = "macchiato",
  -- transparent_background = true,
  dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
    },
}
vim.cmd.colorscheme "catppuccin"
-- vim.cmd[[colorscheme dracula]]
-- require("gruvbox").setup()
-- vim.cmd("colorscheme gruvbox")
