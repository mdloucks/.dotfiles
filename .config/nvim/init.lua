-- Plugin manager (built‑in for nvim 0.12+)

-- 0. CHECKS ===========================================================================================================

-- nvim 0.12 is required for `vim.pack`.
if vim.fn.has "nvim-0.12" == 0 then
  error "[ERROR] Requires nvim 0.12"
end
require 'opt'



-- 2. PLUGIN INSTALLATION =============================================================================================

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" --[[or ev.data.kind == "install"]] then
      local ok, _ = pcall(function() require "nvim-treesitter" .update "all" end)
      if not ok then vim.notify "[ERROR] Failed to update nvim-treesitter parsers" end
    end
  end,
})

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

-- 3.a. kanagawa.nvim (colorscheme) ------------------------------------------------------------------------------------

require "kanagawa" .setup { ---@type KanagawaConfig
  colors = { theme = { all = { ui = { bg_gutter = "none" } } } },

  ---@param colors KanagawaColors
  overrides = function(colors)
    local theme = colors.theme

    return {
      -- dark popup menus
      Pmenu = { bg = theme.ui.bg_p1 },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
    }
  end,
}

vim.cmd.colorscheme "kanagawa"


-- 3.b. oil.nvim (file explorer) ---------------------------------------------------------------------------------------

require "oil" .setup {
  view_options = {
    show_hidden = true,
  },
  skip_confirm_for_simple_edits = true,
}

require("nvim-autopairs").setup {}


require("flutter-tools").setup {
  dev_log = {
    enabled = false,
  },
  debugger = {
    enabled = true,
    exception_breakpoints = {},
    register_configurations = function(paths)
      local dap = require("dap")

      dap.defaults.flutter = { exception_breakpoints = {} }

      dap.configurations.dart = {
        {
          type = "flutter",
          request = "launch",
          name = "Launch flutter",
          dartSdkPath = os.getenv("HOME") .. "/fvm/default/bin/flutter/bin/cache/dart-sdk/bin/dart",
          flutterSdkPath = os.getenv("HOME") .. "/fvm/default/bin/flutter",
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
          exception_breakpoints = {},
        },
      }
    end,
  },
}

require("conform").setup {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
}
require("auto-session").setup {}
require("trouble").setup {}

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Oil" })
-- vim.keymap.set("n", "-", require "oil" .open_float, { desc = "Oil (Float)" })

-- 3.c. nvim-treesitter (treesitter parser management) -----------------------------------------------------------------

require "nvim-treesitter" .install {
  "lua",
  "markdown",
  "markdown_inline",
  "query",
  "dart"
}

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable treesitter highlighting and indents",
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if lang and vim.treesitter.language.add(lang) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end
  end
})

-- 6. DEBUGGING ========================================================================================================

local dap = require('dap')

-- Flutter DAP adapter
dap.adapters.flutter = {
  type = 'executable',
  command = 'flutter', -- or use your FVM path if applicable
  args = { 'debug_adapter' },
  options = {
    detached = false,
  },
}

-- Dart configuration (replaces `flutter-tools` registration)
dap.configurations.dart = {
  {
    type = "flutter",
    request = "launch",
    name = "Launch Flutter",
    dartSdkPath = os.getenv("HOME") .. "/fvm/default/bin/flutter/bin/cache/dart-sdk/bin/dart",
    flutterSdkPath = os.getenv("HOME") .. "/fvm/default/bin/flutter",
    program = function()
      local flutter_tools = require('flutter-tools.config').get 'project'
      if flutter_tools and flutter_tools.target then
        return flutter_tools.target
      end
      return vim.fn.input('Path to main.dart: ', vim.fn.getcwd() .. '/lib/main.dart', 'file')
    end,
    cwd = "${workspaceFolder}",
    exception_breakpoints = {},
  },
}

-- DAP UI setup
local dapui = require('dapui')
dapui.setup {
  layouts = {
    {
      elements = { 'scopes', 'breakpoints', 'stacks', 'watches' },
      size = 40,
      position = 'left',
    },
    {
      elements = { 'repl' },
      size = 10,
      position = 'bottom',
    },
  },
}

-- Optional: virtual text
--require("nvim-dap-virtual-text").setup {}

-- 4. LSP ==============================================================================================================

-- dartls is automatically configured by flutter-tools
vim.lsp.enable {
  "lua_ls",
}


-- 5. KEYMAPS ==========================================================================================================

vim.keymap.set({ "n", "i", "s" }, "<esc>", function()
  vim.snippet.stop()  -- exit current snippet (native snippets only)
  vim.cmd "noh"       -- clear search highlighting
  return "<esc>"      -- standard esc behaviour
end, { expr = true, desc = "Escape+" }) -- expr to make sure "<esc>" is actually evaluated

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
vim.keymap.set("n", "<leader>t", "<cmd>x<cr>", { desc = "Write & Quit" })

vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

require 'remap'
