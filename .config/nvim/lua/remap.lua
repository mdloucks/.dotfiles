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

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>t', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true }, 'move line down')
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true }, 'move line up')

vim.keymap.set('n', '<C-x>', '<cmd><C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bd', '<cmd>w<CR>:bd<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>', { noremap = true, silent = true })

-- Save session
vim.keymap.set('n', '<C-s>', ':mksession<CR>', { noremap = true, silent = true })

-- black hole buffer
vim.keymap.set('n', '<C-x>', '"_d', { noremap = true, silent = true })
vim.keymap.set('v', '<C-x>', '"_d', { noremap = true, silent = true })

-- go back from buffer
vim.keymap.set('n', '<leader>n', '<C-6>', { silent = true, noremap = true, desc = 'Go back to previous buffer' })

-- default :bd messes up a side split which is annoying for flutter

vim.keymap.set('n', '<leader>db', ':bp|bd #<CR>', { desc = 'Delete buffer' })

-- https://github.com/vonheikemen/fine-cmdline.nvim
vim.api.nvim_set_keymap('n', '<CR>', '<cmd>FineCmdline<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })

-- trouble.nvim
vim.keymap.set('n', '<leader>xt', function()
  require('trouble').toggle()
end)
vim.keymap.set('n', '<leader>xw', function()
  require('trouble').toggle 'workspace_diagnostics'
end)
vim.keymap.set('n', '<leader>xd', function()
  require('trouble').toggle 'document_diagnostics'
end)
vim.keymap.set('n', '<leader>xq', function()
  require('trouble').toggle 'quickfix'
end)
vim.keymap.set('n', '<leader>xl', function()
  require('trouble').toggle 'loclist'
end)
vim.keymap.set('n', 'gR', function()
  require('trouble').toggle 'lsp_references'
end)

-- Oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

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

-- Custom plugins :)

vim.keymap.set('n', 'ss', function()
  require('OpenSnippets').open_snippet()
end, { desc = 'Open the snippets for this file type' })
