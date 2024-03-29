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

-- load extensions
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
pcall(telescope.load_extension, 'file_browser')
pcall(telescope.load_extension, 'git_worktree')
local lga_actions = require("telescope-live-grep-args.actions")
local lga_shortcuts = require("telescope-live-grep-args.shortcuts")

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
    file_browser = {
      hidden = { file_browser = true, folder_browser = true },
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-]>"] = require("telescope-live-grep-args.actions").quote_prompt(),
          ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
  },
}

pcall(telescope.load_extension, 'live_grep_args') -- load after setup in order to this plugin to work

-- See `:help telescope.builtin`
map('n', '<leader>s?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', "<Cmd>Telescope frecency workspace=CWD<CR>", { desc = 'Search frecency buffers' })
map('n', '<leader>sb', require('telescope.builtin').buffers, { desc = 'Search existing buffers' })

map('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search Files' })
map('n', '<leader>sg', require('telescope.builtin').git_status, { desc = 'Search git changed file' })
map('n', '<leader>sG', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
map('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
-- map('n', '<leader>st', require('telescope.builtin').live_grep, { desc = 'Search Text' })
map('n', '<leader>st', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = 'Search Text' })
map('n', '<leader>/', ':Telescope current_buffer_fuzzy_find<CR>', { desc = 'Search Text current buffer' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
map('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = 'Search Keymaps' })
map('n', '<leader>sm', require('telescope.builtin').marks, { desc = 'Search Marks' })
map('n', '<leader>sH', require('telescope.builtin').help_tags, { desc = 'Search Help docs' })
map('n', '<leader>sB', require('telescope.builtin').builtin, { desc = 'Search Telescope builtin method' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search diagnostics/errors' })
map('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Resume previous search' })
map('n', '<leader>si', '<cmd>Telescope import<cr>', { desc = 'Search and import' })
map({ "n", "v" }, "<leader>sv", lga_shortcuts.grep_visual_selection, { desc = 'live grep with visual selection' })
map('n', '<leader>gw', telescope.extensions.git_worktree.git_worktrees, { desc = 'Search git worktree' })
map('n', '<leader>gW', telescope.extensions.git_worktree.create_git_worktree, { desc = 'create git worktree' })

-- file_browser open keymaps
vim.api.nvim_set_keymap("n", "<space>fB", ":Telescope file_browser<CR>",
  { noremap = true, desc = 'open file browser in current workspace' })

-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true, desc = 'open file browser in current buffer directory' })
