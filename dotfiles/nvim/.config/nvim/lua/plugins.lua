-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
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
      require('nvim-ts-autotag').setup()
    end,
  },
  { 'hiphish/rainbow-delimiters.nvim' },
  -- Autocompletion and snippet {{{
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    },
  },
  -- }}}
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  -- colorschemes
  { "catppuccin/nvim",                name = "catppuccin" },
  { "ellisonleao/gruvbox.nvim",       priority = 1000,    config = true },
  { 'Mofiqul/dracula.nvim' },
  {
    -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    -- comment based on context for react, vue, etc
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require('Comment').setup(import)
    end,
  },
  { 'zbirenbaum/copilot.lua',              cmd = 'Copilot', event = 'InsertEnter', },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+', },
        change = { text = '~', },
        delete = { text = '_', },
        topdelete = { text = '‾', },
        changedelete = { text = '~', },
      },
    },
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      require('git-worktree').setup()
    end
  },
  {
    'ThePrimeagen/harpoon',
    config = function()
      vim.keymap.set('n', '<leader>sh', ':Telescope harpoon marks<CR>', { noremap = true, desc = 'search harpoon files' })
    end,
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",    opts = {} },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = function()
          require('mason').setup()
        end,
        build = ':MasonUpdate', -- :MasonUpdate updates registry contents
      },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' }, -- Useful status updates for LSP
      'folke/neodev.nvim',                                -- Additional lua configuration, makes nvim stuff amazing!
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
    config = function()
      require('lualine').setup {}
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require('bufferline')
      require('bufferline').setup {
        options = {
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          numbers = "buffer_id"
        }
      }
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'nvimtools/none-ls.nvim',
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
    tag = '0.1.4',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0", },
    },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },
  -- { "LinArcX/telescope-command-palette.nvim" },
  {
    'dhruvmanila/browser-bookmarks.nvim',
    version = '*',
    opts = {
      selected_browser = 'brave'
    },
    config = function()
      require('telescope').load_extension('bookmarks')
      vim.keymap.set('n', '<leader>sb', ':Telescope bookmarks<CR>', { noremap = true, desc = 'search browser bookmarks' })
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension('neoclip')
      vim.keymap.set('n', '<leader>sc', ':Telescope neoclip<CR>', { noremap = true, desc = 'search clipboard history' })
    end,
  },
  {
    'jvgrootveld/telescope-zoxide',
    config = function()
      require('telescope').load_extension('zoxide')
      vim.keymap.set('n', '<leader>sD', ':Telescope zoxide list<CR>',
        { noremap = true, desc = 'search directory zoxide' })
    end
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    'nvim-telescope/telescope-github.nvim',
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require('telescope').load_extension('gh')
    end
  },
  {
    'piersolenski/telescope-import.nvim',
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require("telescope").load_extension("import")
    end
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'akinsho/toggleterm.nvim',                version = '*', opts = {}, },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    -- commit = "33eb472"
  },
  { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup {}
    end,
  },
  { 'mbbill/undotree', keys = { { '<leader>tu', '<cmd>UndotreeToggle<cr>', desc = 'Toggle Undo Tree' }, },
  },
  { 'tpope/vim-fugitive', },
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  { 'folke/which-key.nvim',                    opts = {}, },
  {
    'anuvyklack/windows.nvim',
    dependencies = { 'anuvyklack/middleclass' },
    config = function()
      require('windows').setup()
    end,
  },
  { 'folke/zen-mode.nvim',  opt = {} },
  -- {
  --   -- navigation easy between tmux and nvim
  --   'aserowy/tmux.nvim',
  --   config = function()
  --     return require('tmux').setup {
  --       copy_sync = { enable = false, }
  --     }
  --   end
  -- },
  { 'RRethy/vim-illuminate' }, -- illuminate all the occurences of the word under the cursor
  {
    'TobinPalmer/pastify.nvim',
    cmd = { 'Pastify' },
    config = function()
      require('pastify').setup {
        opts = {
          absolute_path = false, -- use absolute or relative path to the working directory
          apikey = '',           -- Api key, required for online saving
          local_path = '/',      -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
          save = 'local',        -- Either 'local' or 'online'
        },
        ft = {                   -- Custom snippets for different filetypes, will replace $IMG$ with the image url
          html = '<img src="$IMG$" alt="">',
          markdown = '![]($IMG$)',
          tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
        }, }
    end
  },
  { 'kevinhwang91/nvim-bqf' }, -- better quick fix
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'tpope/vim-eunuch' },
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
      { "-", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash", },
      { "_", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
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
  },
  {
    "roobert/activate.nvim",
    keys = {
      {
        "<leader>sP",
        '<CMD>lua require("activate").list_plugins()<CR>',
        desc = "search plugins",
      },
    }
  },
  {
    'chentoast/marks.nvim',
    config = function()
      require 'marks'.setup {}
    end
  },
  -- {
  --   'Wansmer/symbol-usage.nvim',
  --   event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
  --   config = function()
  --     require('symbol-usage').setup()
  --   end
  -- },
  -- {
  --   "chrisgrieser/nvim-puppeteer",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   lazy = false, -- plugin lazy-loads itself
  -- },
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true
      }
    end
  },
  { 'akinsho/git-conflict.nvim', version = "*", config = true },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  { 'mattkubej/jest.nvim' },
  { 'gbrlsnchs/winpick.nvim' },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require("transparent").setup({ -- Optional, you don't have to run setup.
        groups = {                   -- table: default groups
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLineNr', 'EndOfBuffer',
        },
        extra_groups = {},   -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
      })
      vim.keymap.set('n', '<leader>tt', ':TransparentToggle<CR>', { noremap = true, desc = 'toggle transparent' })
    end
  },
  { 'famiu/bufdelete.nvim' },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },
  {
    '2kabhishek/nerdy.nvim',
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Nerdy',
  },
  -- {
  --   "hinell/lsp-timeout.nvim",
  --   dependencies = { "neovim/nvim-lspconfig" }
  -- },
  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  },
  {
    'RishabhRD/nvim-cheat.sh',
    dependencies = { 'RishabhRD/popfix' }
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- configuration goes here
    },
  },
}
