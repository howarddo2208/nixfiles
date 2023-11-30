local window = function()
  return vim.api.nvim_win_get_number(0)
end

require("lualine").setup {
  sections = {
    lualine_a = {
      window, --[[ "mode" ]]
    },
    lualine_b = { "branch" },
    -- 1 = show relative path
    lualine_c = {
      {
        "filename",
        fmt = function(str)
          local ft_to_filename = {
            fern = "",
            editree = "",
          }
          return ft_to_filename[vim.bo.filetype] or str
        end,
        path = 1,
        symbols = { modified = "[*]" },
      },
    },
    lualine_x = { --[[ "searchcount" ]]
    },
    lualine_y = {
      {
        "filetype",
        color = function(section)
          local hl = vim.api.nvim_get_hl(0, { name = "WarningMsg" })
          local fg = bit.tohex(hl.fg, 6)
          return vim.bo.filetype == "editree" and { fg = fg }
        end,
      },
    },
    lualine_z = {
      {
        "location",
        -- color = { fg = colors.fg, bg = colors.active },
      },
      { "progress" },
    },
  },
  inactive_sections = {
    lualine_a = { window },
    lualine_b = {},
    lualine_c = { { "filename", symbols = { modified = "[*]" } } },
    lualine_x = { "location", "progress" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
