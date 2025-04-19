require 'opt'

require 'lazy-bootstrap'

require 'lazy-plugins'

require 'remap'

require('luasnip.loaders.from_lua').lazy_load { paths = { './snippets/lua/' } }
require('luasnip.loaders.from_vscode').lazy_load { paths = './snippets/json/' }
