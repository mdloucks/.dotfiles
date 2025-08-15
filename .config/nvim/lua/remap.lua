-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR } end, { desc = 'Go to previous [E]rror' })
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR } end, { desc = 'Go to next [E]rror' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Window navigation
vim.keymap.set({ 'n', 't' }, '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 't' }, '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n', 't' }, '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n', 't' }, '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Scrolling and centering
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- Visual move lines
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', '<cmd>bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'bda', '<CMD>silent! bufdo bd<CR>', { desc = 'Delete all buffers' })

-- File operations
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
vim.keymap.set("n", "<leader>t", "<cmd>x<cr>", { desc = "Write & Quit" })
vim.keymap.set('n', '<leader>we', '<cmd>wa<CR>', { noremap = true, silent = true })

-- Flutter-specific
vim.api.nvim_set_keymap('n', '<leader>br', ':silent !flutter pub run build_runner build --delete-conflicting-outputs &<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>FlutterRun<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>FlutterRestart<CR>', { noremap = true, silent = true })

-- DAP (Debugging)
vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>do', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>di', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ui', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })

-- LSP actions (on attach)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("vanilla-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
    map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
    map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<C-k>", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    vim.keymap.set("n", "K", "<Nop>", { desc = "Disable default hover" })
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, { desc = "LSP Hover Docs" })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- LSP completion
vim.keymap.set("i", "<C-j>", vim.lsp.completion.get, { desc = "Trigger completion" })

-- Fuzzy finder
vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })

-- Escape utility
vim.keymap.set({ "n", "i", "s" }, "<esc>", function()
  vim.snippet.stop()
  vim.cmd "noh"
  return "<esc>"
end, { expr = true, desc = "Escape+" })

-- Black hole deletes
vim.keymap.set('n', '<C-g>', '"_d', { noremap = true, silent = true })
vim.keymap.set('v', '<C-g>', '"_d', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>p', '"_dP')

-- Misc
vim.keymap.set("n", "-", require "oil".open_float, { desc = "Oil (Float)" })
vim.keymap.set('n', ';', ':', { noremap = true, silent = true })
vim.keymap.set('n', '<CR>', ':', { noremap = true, silent = false, desc = 'Open command mode' })

-- Custom definition buffer replacement
function replace_buffer_with_definition()
  vim.cmd 'update'
  local current_buf = vim.api.nvim_get_current_buf()
  vim.lsp.buf.definition()
  vim.defer_fn(function()
    vim.cmd('bdelete ' .. current_buf)
  end, 100)
end
