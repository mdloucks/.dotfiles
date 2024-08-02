require 'opt'

require 'lazy-bootstrap'

require 'lazy-plugins'

require 'remap'

local luasnip = require 'luasnip'

-- load snippets from path/of/your/nvim/config/my-cool-snippets
require('luasnip.loaders.from_lua').lazy_load { paths = { './lua/luasnippets/' } }

-- Need this for friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- Because VSCode snippets are more common, I'm also going to load those in
require('luasnip.loaders.from_vscode').lazy_load { paths = './lua/jsonsnippets/flutter-riverpod-snippets' }

local js = require 'luasnippets/javascript'

-- associate js/ts with .svelte
luasnip.add_snippets('svelte', js)
luasnip.add_snippets('typescript', js)

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new {
  cmd = 'lazygit',
  hidden = true,
  direction = 'float',
  float_opts = { border = 'curved' },
  winbar = { enabled = true },

  on_close = function(term)
    vim.cmd 'bufdo e'
  end,
}

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })

vim.cmd 'Gitsigns toggle_current_line_blame'

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
      -- goto_next = {
      --   [']d'] = '@conditional.outer',
      --   ['<C-l>'] = '@parameter.inner',
      -- },
      -- goto_previous = {
      --   ['[d'] = '@conditional.outer',
      --   ['<C-h>'] = '@parameter.inner',
      -- },
    },
  },
}

-- Fill in color for hex codes
require('colorizer').setup()

local colorschemes = vim.fn.getcompletion('', 'color')
local themes = {}

-- This logic will make each terminal background transparent after application
-- so I can see my cat in the background
for _, value in ipairs(colorschemes) do
  table.insert(themes, {
    name = value,
    colorscheme = value,
    after = [[
      vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
      vim.cmd('highlight NonText guibg=NONE ctermbg=NONE')
      vim.cmd('highlight NormalNC guibg=NONE ctermbg=NONE')
      vim.cmd('highlight SignColumn guibg=NONE ctermbg=NONE')
      vim.cmd('highlight CursorLine guibg=NONE ctermbg=NONE')
      vim.cmd('highlight StatusLine guibg=NONE ctermbg=NONE')
      vim.cmd('highlight StatusLineNC guibg=NONE ctermbg=NONE')
      vim.cmd('highlight LineNr guibg=NONE ctermbg=NONE')
]],
  })
end

-- Minimal config
require('themery').setup {
  themes = themes, -- Your list of installed colorschemes.
  livePreview = true, -- Apply theme while picking. Default to true.
}
