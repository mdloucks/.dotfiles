require('lazy').setup {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
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
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      {
        'j-hui/fidget.nvim',
      },
    },

    config = function()
      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
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
        intelephense = {},
        jdtls = {},
        phpcbf = {},
        prettier = {},
        stylua = {},
        tailwindcss = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
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
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { { 'prettierd', 'prettier' } },
      },
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

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
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

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      -- require('mini.pairs').setup()
      -- Startup screen
      require('mini.starter').setup()
      -- Cool surrounding replacer, us sd and sr to replace surroundings
      -- I replace the defaults because I'm using flash.nvim
      require('mini.surround').setup {
        custom_surroundings = nil,
        highlight_duration = 500,
        mappings = {
          add = '<C-s>a', -- Control + s + a
          delete = '<C-s>d', -- Control + s + d
          find = '<C-s>f', -- Control + s + f
          find_left = '<C-s>F', -- Control + s + F
          highlight = '<C-s>h', -- Control + s + h
          replace = '<C-s>r', -- Control + s + r
          update_n_lines = '<C-s>n', -- Control + s + n
          suffix_last = 'l', -- Suffix for searching
          suffix_next = 'n', -- Suffix for searching
        },
      }
      -- Cool scope highlinging animation
      require('mini.indentscope').setup()
      -- Split and join lists/tables
      require('mini.splitjoin').setup()

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = {
          enable = true,

          -- NOTE: enabling indentation significantly slows down editing in Dart files
          -- https://github.com/akinsho/flutter-tools.nvim/issues/267
          disable = { 'dart' },
        },

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

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      require('nvim-ts-autotag').setup()
    end,
    dependencies = { 'windwp/nvim-ts-autotag' },
  },

  -- MY PLUGINS --------------------------------------------
  -- MY PLUGINS --------------------------------------------
  -- MY PLUGINS --------------------------------------------

  {

    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>TroubleToggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
    },
  },

  -- Love this one, file explorer
  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      },
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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

  -- Need this for my work, great plugin though
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {
      dev_tools = {
        autostart = true, -- autostart devtools server if not detected
        auto_open_browser = false, -- Automatically opens devtools in the browser
      },

      dev_log = {
        enabled = false,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = '', -- command to use to open the log buffer
      },
      debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = true,
        -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
        -- see |:help dap.set_exception_breakpoints()| for more info
        exception_breakpoints = {},
        -- Whether to call toString() on objects in debug views like hovers and the
        -- variables list.
        -- Invoking toString() has a performance cost and may introduce side-effects,
        -- although users may expected this functionality. null is treated like false.
        evaluate_to_string_in_debug_views = true,
        register_configurations = function(paths)
          -- If you want to load .vscode launch.json automatically run the following:
          -- require("dap.ext.vscode").load_launchjs()

          local dap = require 'dap'

          -- Register Dart configurations
          dap.configurations.dart = {
            {
              type = 'dart',
              request = 'launch',
              name = 'Launch Dart',
              dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/bin/dart', -- Ensure this is correct
              flutterSdkPath = '/opt/flutter/bin/flutter', -- Ensure this is correct
              program = '${workspaceFolder}/lib/main.dart', -- Ensure this is correct
              cwd = '${workspaceFolder}',
            },
          }

          -- Register Flutter configurations
          dap.configurations.flutter = {
            {
              type = 'flutter',
              request = 'launch',
              name = 'Launch Flutter',
              dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/bin/dart', -- Ensure this is correct
              flutterSdkPath = '/opt/flutter/bin/flutter', -- Ensure this is correct
              program = '${workspaceFolder}/lib/main.dart', -- Ensure this is correct
              cwd = '${workspaceFolder}',
            },
          }
        end,
      },
    },
  },

  -- Line at the bottom of the screen
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {

      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {

        lualine_a = {
          {
            'mode',
            -- Truncate to only show one char
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },

        lualine_b = { {
          'branch',
          fmt = function(str)
            return str:sub(1, 10)
          end,
        }, 'diagnostics' },
        lualine_c = {},
        lualine_x = {
          {
            'buffers',
            show_filename_only = true, -- Shows shortened relative path when set to false.
            hide_filename_extension = true, -- Hide filename extension when set to true.
            show_modified_status = true, -- Shows indicator when the buffer is modified.

            mode = 0, -- 0: Shows buffer name
            -- 1: Shows buffer index
            -- 2: Shows buffer name + buffer index
            -- 3: Shows buffer number
            -- 4: Shows buffer name + buffer number

            max_length = vim.o.columns * 6 / 7, -- Maximum width of buffers component,

            -- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
            use_mode_colors = true,

            -- buffers_color = {
            --   -- Same values as the general color option can be used here.
            --   active = 'lualine_{section}_normal', -- Color for active buffer.
            --   inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
            -- },

            buffers_color = {
              active = { fg = '#ff9e64' }, -- Color for active buffers
              inactive = { fg = '#5c6370' }, -- Color for inactive buffers
            },

            symbols = {
              modified = ' ●', -- Text to show when the buffer is modified
              alternate_file = '', -- Text to show to identify the alternate file
              directory = '', -- Text to show when the buffer is a directory
            },
          },
        },
        -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
          },
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { 'oil', 'trouble', 'fugitive' },
    },
  },

  -- Nice plugin that moves the colon commands to the center of the screen in a nice box
  {
    'VonHeikemen/fine-cmdline.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
    },
    opts = {

      cmdline = {
        prompt = '? ',
      },
      popup = {
        position = {
          row = '50%',
          col = '50%',
        },

        border = {
          style = 'single',
          text = {
            top = ' cmd ',
            top_align = 'center',
          },
        },
      },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          -- always center screen on jump
          require('flash').jump()
          vim.cmd 'normal! zz'
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
    'sindrets/diffview.nvim',
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
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = { 'theHamsta/nvim-dap-virtual-text' },
    config = function()
      -- Configure DAP adapters for Dart and Flutter

      require('dap').adapters.dart = {
        type = 'executable',
        command = 'dart', -- Adjust this if using FVM
        args = { 'debug_adapter' },
        options = {
          detached = false,
        },
      }

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
          type = 'dart',
          request = 'launch',
          name = 'Launch Dart',
          dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/bin/dart', -- Ensure this is correct
          flutterSdkPath = '/opt/flutter/bin/flutter', -- Ensure this is correct
          program = '${workspaceFolder}/lib/main.dart', -- Ensure this is correct

          program = function()
            local flutter_tools = require('flutter-tools.config').get 'project'
            if flutter_tools and flutter_tools.target then
              return flutter_tools.target
            end
            return vim.fn.input('Path to main.dart: ', vim.fn.getcwd() .. '/lib/main.dart', 'file')
          end,
          cwd = '${workspaceFolder}',
        },
      }

      require('dap').configurations.flutter = {
        {
          type = 'flutter',
          request = 'launch',
          name = 'Launch Flutter',
          dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/bin/dart', -- Ensure this is correct
          flutterSdkPath = '/opt/flutter/bin/flutter', -- Ensure this is correct
          program = function()
            local flutter_tools = require('flutter-tools.config').get 'project'
            if flutter_tools and flutter_tools.target then
              return flutter_tools.target
            end
            return vim.fn.input('Path to main.dart: ', vim.fn.getcwd() .. '/lib/main.dart', 'file')
          end,
          cwd = '${workspaceFolder}',
        },
      }
    end,
    event = 'VimEnter', -- Ensure early loading
  },

  {
    'theHamsta/nvim-dap-virtual-text',
  },

  -- nvim v0.8.0
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
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
