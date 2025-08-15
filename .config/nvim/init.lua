-- Plugin manager (built‑in for nvim 0.12+)

-- 0. CHECKS ===========================================================================================================

-- nvim 0.12 is required for `vim.pack`.
if vim.fn.has "nvim-0.12" == 0 then
  error "[ERROR] Requires nvim 0.12"
end

-- 1. PREFS ===========================================================================================================
require 'opt'
require 'auto_cmds'

-- 2. PLUGIN INSTALLATION =============================================================================================

vim.pack.add {
  -- appearance
  "https://github.com/rebelot/kanagawa.nvim",
  'https://github.com/nvim-tree/nvim-web-devicons',

  -- navigation
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/neovim/nvim-lspconfig", -- data only
  -- Dart/Flutter
  "https://github.com/nvim-flutter/flutter-tools.nvim",
  'https://github.com/mfussenegger/nvim-dap',
  "https://github.com/nvim-lua/plenary.nvim",
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  -- misc
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/rmagatti/auto-session',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/windwp/nvim-autopairs'
}

-- 3. PLUGIN SETUP =====================================================================================================

local function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -1 "' .. directory .. '"')
  for filename in pfile:lines() do
    if filename:match("%.lua$") then
      i = i + 1
      t[i] = filename
    end
  end
  pfile:close()
  return t
end

local plugin_dir = "plugins"
local files = scandir(vim.fn.stdpath("config") .. "/lua/" .. plugin_dir)

for _, filename in ipairs(files) do
  local module = plugin_dir .. "." .. filename:gsub("%.lua$", "")
  local ok, plugin = pcall(require, module)
  if ok and type(plugin) == "table" then
    -- If it has a `config` field, call it
    local name_only = filename:gsub("%.lua$", "")
    require(name_only).setup()
    vim.schedule(function() print(name_only) end)
  else
    vim.notify("Failed to load plugin from " .. module, vim.log.levels.WARN)
  end
end

-- 3.a. kanagawa.nvim (colorscheme) ------------------------------------------------------------------------------------
require "kanagawa".setup { ---@type KanagawaConfig
  colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
}

vim.cmd.colorscheme "kanagawa"

require("nvim-autopairs").setup {}
require("auto-session").setup {}
require("trouble").setup {}

-- 3.c. nvim-treesitter (treesitter parser management) -----------------------------------------------------------------
require "nvim-treesitter".install {
  "lua",
  "markdown",
  "markdown_inline",
  "query",
  "dart"
}


-- 6. DEBUGGING ========================================================================================================


-- 4. LSP ==============================================================================================================

-- requires lua-language-server
vim.lsp.enable {
  "lua_ls",
}

-- 5. KEYMAPS ==========================================================================================================

require 'remap'
