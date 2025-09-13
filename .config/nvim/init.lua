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
  -- UI for flutter-tools
  "https://github.com/stevearc/dressing.nvim",
  -- debugging
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
-- dependency of nvim-dap-ui
'https://github.com/nvim-neotest/nvim-nio',
  "https://github.com/nvim-lua/plenary.nvim",
  -- misc
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/rmagatti/auto-session',
  'https://github.com/windwp/nvim-autopairs'
}

-- 3. PLUGIN SETUP =====================================================================================================

-- 3.a. ------------------------------------------------------------------------------------
local function scandir(directory)
  local t, popen = {}, io.popen
  local pfile = popen('ls -1 "' .. directory .. '"')
  if not pfile then return t end
  for filename in pfile:lines() do
    if filename:match("%.lua$") then
      table.insert(t, filename)
    end
  end
  pfile:close()
  return t
end

-- 2. Load each plugin config
local plugin_dir = "plugins"
local config_path = vim.fn.stdpath("config") .. "/lua/" .. plugin_dir
local files = scandir(config_path)

for _, filename in ipairs(files) do
  local plugin_name = filename:gsub("%.lua$", "")
  local module = plugin_dir .. "." .. plugin_name

  local ok, config = pcall(require, module)
  if ok and type(config) == "table" then
    -- Try to require the actual plugin and call .setup(config)
    local plugin_ok, plugin = pcall(require, plugin_name)
    if plugin_ok and type(plugin.setup) == "function" then
      plugin.setup(config)
    else
      vim.notify("Plugin '" .. plugin_name .. "' does not have a setup function", vim.log.levels.WARN)
    end
  else
    vim.notify("Failed to load config module: " .. module, vim.log.levels.ERROR)
  end
end

-- 3.a. kanagawa.nvim (colorscheme) ------------------------------------------------------------------------------------

require "kanagawa".setup { ---@type KanagawaConfig
  colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
}

vim.cmd.colorscheme "kanagawa"

-- 3.c. nvim-treesitter (treesitter parser management) -----------------------------------------------------------------
require("nvim-treesitter").setup {
  ensure_installed = {
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "dart",
  },
  sync_install = false,   -- don’t block startup
  auto_install = false,   -- don’t try to auto-install on open
  highlight = { enable = true },
}

-- 6. DEBUGGING ========================================================================================================
vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})


-- 4. LSP ==============================================================================================================

-- requires lua-language-server
vim.lsp.enable {
  "lua_ls",
}

-- 5. KEYMAPS ==========================================================================================================
require 'remap'
