# My Neovim config

### Introduction

Hi there, here is my neovim config, my starting point was from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Later I decided to rebuilt its structure based on some other dotfiles I read:
- [ThePriemagen video](https://youtu.be/w7i4amO_zaE)
- [TJ's config](https://github.dev/tjdevries/config_manager)
- [ziontee113 Luasnip tutorial](https://youtu.be/ub0REXjhpmk)
- [Takuya's dotfiles](https://github.com/craftzdog/dotfiles-public)
- [liaohui5/dotfiles](https://github.com/liaohui5/dotfiles): steal keybindings and toggleterm config

### Installation

This config, which is derived from Kickstart.nvim targets *only* the latest ['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest ['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim. If you are experiencing issues, please make sure you have the latest versions.


Additional system requirements:
- Make sure to review the readmes of the plugins if you are experiencing errors. In particular:
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
- See as well [Windows Installation](#Windows-Installation)

### Configuration And Extension

* Adding plugin by first adding into `lua/plugins.lua` then add the configuration file into `after/plugin` folder 

#### Example: Adding neo-tree plugin to display file tree

add a new plugin into `lua/plugins`:

```lua
-- new file: lua/plugins.lua

{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
},
```

If you want to further config the plugin, create a new fileinside `after/plugin` folder

```lua
-- new file: after/plugin/neotree.lua

-- ensure not throw error and config in case we can't load the plugin
if not pcall(require, "neo-tree") then
  return
end

require("neo-tree").setup({
  -- your options, setup here
})
```

### Windows Installation

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
### TODOS
- [ ] Write step by step configuration guide for luasnip
- [] restructure keybindings
