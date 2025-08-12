require('lazy').setup {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically


  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      attach_to_untracked = false,
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-tree/nvim-web-devicons' }, -- Pretty icons (requires Nerd Font)
    },
    config = function()
      local telescope = require 'telescope'

      -- Enable telescope extensions, if they are installed
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },

    config = function()
      local lspconfig = require 'lspconfig'
      local mason_lspconfig = require 'mason-lspconfig'

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        svelte = {},
        jsonls = {},
        bashls = {},
        cssls = {
          filetypes = { 'css', 'pcss' },
        },
        denols = {},
        docker_compose_language_service = {},
        html = {},
        htmx = {},
        -- prettier = {},
        -- stylua = {},
        tailwindcss = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Set up mason and mason-tool-installer
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers)

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }

      -- Set up LSPs with handler
      mason_lspconfig.setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
      }

      mason_lspconfig.setup {
        function(server_name)
          local server_opts = servers[server_name] or {}
          server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
          lspconfig[server_name].setup(server_opts)
        end,
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {},
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-j>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  {
    'EdenEast/nightfox.nvim',
    config = function()
      vim.cmd.colorscheme 'nightfox'
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.starter').setup()
      require('mini.splitjoin').setup()
      require('mini.surround').setup {
        custom_surroundings = nil,
        highlight_duration = 500,
        mappings = {
          add = '<C-s>a',     -- Control + s + a
          delete = '<C-s>d',  -- Control + s + d
          replace = '<C-s>r', -- Control + s + r
        },
      }
      -- Cool scope highlinging animation
      require('mini.indentscope').setup()
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = { enable = true },
      }

      require('nvim-ts-autotag').setup()
    end,
    dependencies = { 'windwp/nvim-ts-autotag' },
  },

  -- MY PLUGINS --------------------------------------------
  -- MY PLUGINS --------------------------------------------
  -- MY PLUGINS --------------------------------------------

  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  -- This is nice, allows you to generate json tags from structs
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },


  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      tabline = {

        lualine_a = { 'tabs' },
        lualine_c = {
          {
            'buffers',
            show_filename_only = true, -- Shows full path if space allows
            max_length = 170, -- Uses 2/3 of screen width
            symbols = {
              modified = ' ●', -- Indicator for modified buffers
            },
          },
        },
      },
      extensions = { 'fugitive', 'nvim-tree', 'quickfix' },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },

  {
    'rmagatti/auto-session',
    lazy = false,

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      use_git_branch = true,
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },

  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },

  {
    'norcalli/nvim-colorizer.lua',
  },

  {
    'akinsho/flutter-tools.nvim',
    version = 'v1.14.0',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {
      dev_tools = {
        autostart = true, -- autostart devtools server if not detected
      },

      dev_log = {
        enabled = false,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = '',         -- command to use to open the log buffer
      },
      debugger = {             -- integrate with nvim dap + install dart code debugger
        enabled = true,
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
        register_configurations = function(paths)
          local dap = require 'dap'
          dap.defaults.flutter = { exception_breakpoints = {} }

          -- NOTE: If something is ever wrong, it is likely to do with this section. This controls
          -- where your actual binaries live
          dap.configurations.dart = {
            {
              type = "flutter",
              request = "launch",
              name = "Launch flutter",
              dartSdkPath = "$HOME/fvm/default/bin/flutter",
              flutterSdkPath = "$HOME/fvm/default/bin/flutter",
              program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
              cwd = "${workspaceFolder}",
              exception_breakpoints = {}
            }
          }
        end,
      },
    },
  },

  {
    'mfussenegger/nvim-dap',
    commit = '6a5bba0',
    dependencies = { 'theHamsta/nvim-dap-virtual-text' },
    config = function()
      require('dap').defaults.dart.exception_breakpoints = {} -- Disable exception breakpoints globally
      require('dap').adapters.flutter = {
        type = 'executable',
        command = 'flutter', -- Adjust this if using FVM
        args = { 'debug_adapter' },
        options = {
          detached = false,
        },
      }

      -- DAP configurations for Dart and Flutter
      require('dap').configurations.dart = {
        {
          type = 'flutter', -- Set to "flutter" for default
          request = 'launch',
          name = 'Launch Flutter',
          dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/bin/dart',          -- Ensure this is correct
          flutterSdkPath = '/Users/mloucks/development/flutter/bin/flutter', -- Ensure this is correct
          program = '${workspaceFolder}/lib/main.dart',                      -- Ensure this is correct

          program = function()
            local flutter_tools = require('flutter-tools.config').get 'project'
            if flutter_tools and flutter_tools.target then
              return flutter_tools.target
            end
            return vim.fn.input('Path to main.dart: ', vim.fn.getcwd() .. '/lib/main.dart', 'file')
          end,
          cwd = '${workspaceFolder}',
          exception_breakpoints = {} -- Disable exception breakpoints here for Flutter
        },
      }

      require('dap').configurations.flutter = {
        {
          type = 'flutter', -- Set to "flutter" for default
          request = 'launch',
          name = 'Launch Flutter',
          dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/bin/dart',          -- Ensure this is correct
          flutterSdkPath = '/Users/mloucks/development/flutter/bin/flutter', -- Ensure this is correct
          program = function()
            local flutter_tools = require('flutter-tools.config').get 'project'
            if flutter_tools and flutter_tools.target then
              return flutter_tools.target
            end
            return vim.fn.input('Path to main.dart: ', vim.fn.getcwd() .. '/lib/main.dart', 'file')
          end,
          cwd = '${workspaceFolder}',
          exception_breakpoints = {} -- Disable exception breakpoints here for Flutter
        },
      }
    end,
    event = 'VimEnter', -- Ensure early loading
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup {

        layouts = {
          {
            elements = { 'scopes', 'breakpoints', 'stacks', 'watches' },
            size = 40,
            position = 'left',
          },
          {
            elements = { 'repl' }, -- Remove "console" from here
            size = 10,
            position = 'bottom',
          },
        },
      }
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
  },

  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    keys = {
      { '<leader>g', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
