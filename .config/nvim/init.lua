require 'opt'

require 'lazy-bootstrap'

require 'lazy-plugins'

require 'remap'

local luasnip = require 'luasnip'

-- load snippets from path/of/your/nvim/config/my-cool-snippets
require('luasnip.loaders.from_lua').lazy_load { paths = { './lua/luasnippets/' } }

-- Because VSCode snippets are more common, I'm also going to load those in
require('luasnip.loaders.from_vscode').lazy_load { paths = { './lua/luasnippets/json/' } }

local js = require 'luasnippets/javascript'

-- associate js/ts with .svelte
luasnip.add_snippets('svelte', js)
luasnip.add_snippets('typescript', js)

-- Make it so that on file load, Sleuth is called to set tab spacing automatically

-- local group = vim.api.nvim_create_augroup('FlutterToolsGroup', { clear = false })
-- vim.api.nvim_create_autocmd('BufEnter', {
--   callback = function()
--     vim.cmd 'Sleuth'
--   end,
--
--   group = group,
-- })
