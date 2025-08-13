-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '[e', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Go to previous [E]rror' })

vim.keymap.set('n', ']e', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Go to next [E]rror' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set({ 'n', 't' }, '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 't' }, '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n', 't' }, '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n', 't' }, '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- qol remaps
vim.keymap.set('n', '<leader>we', '<cmd>wa<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ';', ':', { noremap = true, silent = true })

-- black hole buffer
vim.keymap.set('n', '<C-g>', '"_d', { noremap = true, silent = true })
vim.keymap.set('v', '<C-g>', '"_d', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>p', '"_dP')

vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', '<cmd>bprevious<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.keymap.set('n', '<CR>', ':', { noremap = true, silent = false, desc = 'Open command mode' })

vim.api.nvim_set_keymap('n', '<leader>br',
  ':silent !flutter pub run build_runner build --delete-conflicting-outputs &<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fs',
  '<cmd>FlutterRun<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>fr',
  '<cmd>FlutterRestart<CR>', { noremap = true, silent = true })

-- Delete all buffers, don't show output
vim.keymap.set('n', 'bda', '<CMD>silent! bufdo bd<CR>', { desc = 'Delete all buffers' })

vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>do', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>di', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>do', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require("dap").toggle_breakpoint()<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ui', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })

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


		-- Disable default Shift-K hover if you want
		vim.keymap.set("n", "K", "<Nop>", { desc = "Disable default hover" })

		-- Use Ctrl-K instead
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, { desc = "LSP Hover Docs" })

    -- Optional: Enable document highlighting if supported
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

function replace_buffer_with_definition()
  vim.cmd 'update'
  local current_buf = vim.api.nvim_get_current_buf()
  vim.lsp.buf.definition()

  vim.defer_fn(function()
    vim.cmd('bdelete ' .. current_buf)
  end, 100)
end
