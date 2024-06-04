require 'opt'

require 'lazy-bootstrap'

require 'lazy-plugins'

require 'remap'

local luasnip = require 'luasnip'

-- load snippets from path/of/your/nvim/config/my-cool-snippets
require('luasnip.loaders.from_lua').lazy_load { paths = { './lua/luasnippets/' } }

-- Because VSCode snippets are more common, I'm also going to load those in
require('luasnip.loaders.from_vscode').lazy_load { paths = './lua/jsonsnippets/flutter-riverpod-snippets' }

local js = require 'luasnippets/javascript'

-- associate js/ts with .svelte
luasnip.add_snippets('svelte', js)
luasnip.add_snippets('typescript', js)

-- Make it so that on file load, Sleuth is called to set tab spacing automatically
--

require('lualine').setup {
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
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'buffers' },
    -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { 'oil', 'trouble', 'fugitive' },
}

-- TODO: Put this in opts or something, not sure why there's an err
require('nvim-treesitter.configs').setup {

  textobjects = {

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = { query = '@class.outer', desc = 'Next class start' },
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        [']o'] = '@loop.*',
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
        [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        [']d'] = '@conditional.outer',
        ['<C-l>'] = '@parameter.inner',
      },
      goto_previous = {
        ['[d'] = '@conditional.outer',
        ['<C-h>'] = '@parameter.inner',
      },
    },
  },
}

require('auto-session').setup {
  log_level = 'error',

  cwd_change_handling = {
    restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
    pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require('lualine').refresh() -- refresh lualine so the new session name is displayed in the status bar
    end,
  },
}
