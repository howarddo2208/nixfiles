return {
  -- autopair for tags, parentheses, quotes, etc
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-treesitter.configs').setup {
        autotag = {
          enable = true,
        },
      }
    end,
  },
  -- Autocompletion and snippet {{{
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets' },
  },
  -- }}}
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  { "catppuccin/nvim",     name = "catppuccin" },
  {
    -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    -- comment based on context for react, vue, etc
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
    end,
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = {
          text = '+',
        },
        change = {
          text = '~',
        },
        delete = {
          text = '_',
        },
        topdelete = {
          text = '‾',
        },
        changedelete = {
          text = '~',
        },
      },
    },
  },
  { 'ThePrimeagen/harpoon' },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        config = function()
          require('mason').setup()
        end,
        build = ':MasonUpdate', -- :MasonUpdate updates registry contents
      },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        -- theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('null-ls').setup()
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {}
    end,
  },
  {
    'themaxmarchuk/tailwindcss-colors.nvim',
    -- load only on require("tailwindcss-colors")
    module = 'tailwindcss-colors',
    -- run the setup function after plugin is loaded
    config = function()
      -- pass config options here (or nothing to use defaults)
      require('tailwindcss-colors').setup()
    end,
  },
  -- Telescopes and extensions
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    -- commit = "33eb472"
  },
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup {}
    end,
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>t', '<cmd>UndotreeToggle<cr>', desc = 'Toggle Undo Tree' },
    },
  },
  {
    'tpope/vim-fugitive',
  },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    'folke/which-key.nvim',
    opts = {},
  },
  {
    'anuvyklack/windows.nvim',
    dependencies = { 'anuvyklack/middleclass' },
    config = function()
      require('windows').setup()
    end,
  },
  {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  {
    -- navigation easy between tmux and nvim
    'aserowy/tmux.nvim',
    config = function()
      return require('tmux').setup {}
    end
  },
  {
    -- illuminate all the occurences of the word under the cursor
    'RRethy/vim-illuminate'
  },
  {
    'postfen/clipboard-image.nvim',
    commit = '9c45980'
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  },
  { 'kevinhwang91/nvim-bqf' }, -- better quick fix
  { 'nvim-treesitter/nvim-treesitter',        build = ':TSUpdate' },
  { 'tpope/vim-eunuch' },
  { 'wakatime/vim-wakatime' },
  { "axieax/urlview.nvim" },
  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig'
    }
  },
  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require("mason").setup()
      require("mason-nvim-dap").setup()
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
    end
  },
  { "theHamsta/nvim-dap-virtual-text" },
  { 'leoluz/nvim-dap-go', },
  { "nvim-telescope/telescope-dap.nvim" },
  {
    'saecki/crates.nvim',
    ft = { 'rust', 'toml' },
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
      require('keybindings').languages.rust.cratesKeys()
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "-",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "_",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  {
    "olexsmir/gopher.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, opts)
      require("gopher").setup(opts)
      require('keybindings').languages.go.gopherKeys()
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end
  },
  {
    'notjedi/nvim-rooter.lua',
    config = function()
      require('nvim-rooter').setup { manual = true }
    end
  },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "markdown", "tex" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "princejoogie/chafa.nvim", -- image viewer
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim"
    },
    config = function()
      require("chafa").setup({
        render = {
          min_padding = 5,
          show_label = true,
        },
        events = {
          update_on_nvim_resize = true,
        },
      })
    end
  }
}
