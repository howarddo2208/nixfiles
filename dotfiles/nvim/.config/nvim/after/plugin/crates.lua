local ok, crates = pcall(require, "rust-tools")

if not ok then
  print("crates not found")
  return
end

local cratesKeys = require("keybindings").cratesKeys()
