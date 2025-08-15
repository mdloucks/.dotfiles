
vim.g.mapleader = ' '       -- Set <Space> as the global leader key
vim.g.maplocalleader = ' '  -- Set <Space> as the local leader key

-- Line numbering
vim.opt.number = true            -- Show absolute line numbers
vim.opt.relativenumber = true    -- Show relative line numbers for easier movement

-- Mouse
vim.opt.mouse = 'a'              -- Enable mouse support in all modes

-- UI feedback
vim.opt.showmode = false         -- Don't show current mode (already visible in statusline)

-- Clipboard
vim.opt.clipboard = 'unnamedplus' -- Sync Neovim and system clipboard

-- Undo & Swap
vim.opt.undofile = true          -- Enable persistent undo history
vim.opt.swapfile = false         -- Disable swap file creation

-- Indentation
vim.opt.breakindent = true       -- Indent wrapped lines to match normal indentation
vim.o.autoindent = true          -- Copy indent from current line when starting a new one
vim.o.smartindent = true         -- Auto-indent based on syntax/context
vim.o.expandtab = true           -- Use spaces instead of tabs
vim.opt.tabstop = 4              -- Display tab characters as 4 spaces (used for visual alignment)
vim.o.tabstop = 2                -- Actual tab character is worth 2 spaces (override for consistency)
vim.o.shiftwidth = 2             -- Indent by 2 spaces when using >> or <<

-- Search behavior
vim.opt.ignorecase = true        -- Ignore case in search by default
vim.opt.smartcase = true         -- Use case-sensitive search if uppercase letters are used
vim.opt.hlsearch = true          -- Highlight search matches

-- Splits
vim.opt.splitright = true        -- Vertical splits open to the right
vim.opt.splitbelow = true        -- Horizontal splits open below

-- Sign column
vim.opt.signcolumn = 'yes'       -- Always show sign column to avoid text shifting

-- Cursor & scroll
vim.opt.scrolloff = 12           -- Keep at least 12 lines above/below the cursor
-- vim.opt.cursorline = true      -- (Optional) highlight the current line

-- Completion
vim.opt.completeopt = { "menuone", "noselect", "noinsert" } -- Better completion experience

-- Command preview
vim.opt.inccommand = 'split'     -- Live preview for :%s substitutions

-- Whitespace display
vim.opt.list = true              -- Enable display of whitespace characters
vim.opt.listchars = {            -- Customize display of whitespace
  tab = '» ',                    -- Tab character
  trail = '·',                   -- Trailing spaces
  nbsp = '␣'                     -- Non-breaking spaces
}

-- Performance
vim.opt.updatetime = 250         -- Faster trigger for CursorHold/autocompletion

-- Local config
vim.opt.exrc = true              -- Allow project-specific `.exrc` files (use with caution)

