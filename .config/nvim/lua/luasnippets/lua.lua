local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

return {
  s('trigger', t 'Loaded!'),
  s('lorem', t 'Lorem ipsum dolor sit amet.'),
}
