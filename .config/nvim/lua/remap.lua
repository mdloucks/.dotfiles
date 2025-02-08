local telescope = require 'telescope.builtin'
-- local oil = require 'oil'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true }, 'move line up')
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true }, 'move line down')

vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>', { noremap = true, silent = true })

-- Save session
-- vim.keymap.set('n', '<C-s>', ':mksession<CR>', { noremap = true, silent = true })

-- black hole buffer
vim.keymap.set('n', '<C-g>', '"_d', { noremap = true, silent = true })
vim.keymap.set('v', '<C-g>', '"_d', { noremap = true, silent = true })

vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', '<cmd>bprevious<CR>', { noremap = true, silent = true })

-- go back from buffer
vim.keymap.set('n', '<leader>n', '<C-6>', { silent = true, noremap = true, desc = 'Go back to previous buffer' })

-- default :bd messes up a side split which is annoying for flutter

vim.keymap.set('n', '<CR>', ':', { noremap = true, silent = false, desc = 'Open command mode' })

vim.keymap.set('n', '<leader>n', '<C-6>', { silent = true, noremap = true, desc = 'Go back to previous buffer' })

-- Oil
-- vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Flutter

require('telescope').load_extension 'flutter'
vim.keymap.set('n', '<leader>f', function()
  require('telescope').extensions.flutter.commands()
end, { desc = 'Open the snippets for this file type' })

vim.api.nvim_set_keymap('n', '<leader>br', ':silent !flutter pub run build_runner build --delete-conflicting-outputs &<CR>', { noremap = true, silent = true })

-- Custom plugins :)

vim.keymap.set('n', 'ss', function()
  require('OpenSnippets').open_snippet()
end, { desc = 'Open the snippets for this file type' })

-- diffview (this plugin is awesome for seeing historical changes)
vim.keymap.set('n', '<leader>dvo', '<CMD>DiffviewOpen<CR>', { desc = 'Diff view open' })
vim.keymap.set('n', '<leader>dvc', '<CMD>DiffviewClose<CR>', { desc = 'Diff view close' })
vim.keymap.set('n', '<leader>dvh', '<CMD>DiffviewFileHistory<CR>', { desc = 'Diff view file history' })

-- Themery
vim.keymap.set('n', '<leader>th', '<CMD>Themery<CR>', { desc = 'Change theme' })

-- Delete all buffers, don't show output
vim.keymap.set('n', 'bda', '<CMD>silent! bufdo bd<CR>', { desc = 'Delete all buffers' })

vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>do', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>di', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>do', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ui', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })

-- live grep from the current working directory (of the current buffer)
-- function grep_in_dir()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local oil_dir = oil.get_current_dir(bufnr)
--
--   if oil_dir then
--     telescope.live_grep { search_dirs = { oil_dir } }
--   else
--     local bufname = vim.api.nvim_buf_get_name(bufnr)
--     telescope.live_grep { search_dirs = { bufname } }
--   end
-- end

vim.api.nvim_set_keymap('n', '<leader>sd', '<cmd>lua grep_in_dir()<CR>', { noremap = true, silent = true })

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('<C-k>', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
