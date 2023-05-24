if not pcall(require, 'module') then
  return
end

require("lualine").setup({
  sections = {
    lualine_x = {
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
        color = { fg = "#ff9e64" },
      }
    },
  },
})
