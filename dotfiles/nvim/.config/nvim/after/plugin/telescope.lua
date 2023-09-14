if not pcall(require, 'telescope') then
  return
end

-- [[ Configure Telescope ]]
local telescope = require 'telescope'
local telescopeConfig = require 'telescope.config'
local actions = require 'telescope.actions'
local map = require('utils').map

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, '--hidden')
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, '--glob')
table.insert(vimgrep_arguments, '!**/.git/*')

-- See `:help telescope` and `:help telescope.setup()`
telescope.setup {
  defaults = {
    wrap_results = true,
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(filepath)
          local image_extensions = { 'png', 'jpg', 'jpeg', 'gif' } -- Supported image formats
          local split_path = vim.split(filepath:lower(), '.', { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. '\r\n')
            end
          end
          vim.fn.jobstart({
            'chafa',
            filepath, -- Terminal image viewer command
          }, { on_stdout = send_output, stdout_buffered = true, pty = true })
        else
          require('telescope.previewers.utils').set_preview_message(bufnr, opts.winid, 'Binary cannot be previewed')
        end
      end,
    },
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
    mappings = {
      n = {
        ['q'] = actions.close,
      },
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
    },
  },
  extensions = {
    import = {
      -- Add imports to the top of the file keeping the cursor in place
      insert_at_top = true,
    },
  },
}

-- load extensions
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

-- See `:help telescope.builtin`
map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Search Files' })
map('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
map('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
map('n', '<leader>st', require('telescope.builtin').live_grep, { desc = 'Search Text' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
map('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = 'Search Keymaps' })
map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help docs' })
map('n', '<leader>sb', require('telescope.builtin').builtin, { desc = 'Search builtin method' })
map('n', '<leader>lp', '<cmd>Telescope import<cr>', { desc = 'Search and import' })
