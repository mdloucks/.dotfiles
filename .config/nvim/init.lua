require 'opt'

require 'lazy-bootstrap'

require 'lazy-plugins'

require 'remap'

local luasnip = require 'luasnip'

local auto_session = require 'auto-session'

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

-- Fill in color for hex codes
require('colorizer').setup()
