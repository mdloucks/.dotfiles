-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

  
-- prefs
vim.wo.relativenumber = true
vim.wo.number = true

-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4

-- Set tab length based on file type
vim.cmd[[
  augroup FileSettings
    autocmd!
    autocmd FileType html,htm,lua setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType * if &filetype !=# 'html' && &filetype !=# 'htm' && &filetype !=# 'lua' | setlocal tabstop=4 shiftwidth=4 softtabstop=4 | endif
  augroup END
]]

vim.opt.scrolloff = 8

-- snippets paths
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/luasnippets"

vim.api.nvim_command('set colorcolumn=78')
vim.opt.ignorecase = true
vim.opt.virtualedit = "block"




vim.cmd("set formatoptions-=cro")
