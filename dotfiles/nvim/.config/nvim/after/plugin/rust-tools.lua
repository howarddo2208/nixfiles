local ok, rt = pcall(require, "rust-tools")

if not ok then
  print("rust-tools not found")
  return
end

rt.setup({
  server = {
    on_attach = function()
      require("keybindings").rustToolsKeys()
    end,
  },
})
