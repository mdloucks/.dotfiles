-- This plugin will basically open the associated LuaSnip file
-- found in .nvim/lua/<luasnippets>/<snipfile>.lua

-- local buf_name = vim.api.nvim_buf_get_name(0)

local function open_snippet()
  local filetype = vim.bo.filetype
  local snipfile_path = vim.fn.expand('$HOME/.config/nvim/lua/luasnippets/' .. filetype .. '.lua')

  vim.cmd { cmd = 'edit', args = { snipfile_path }, bang = true }
end

return {
  open_snippet = open_snippet,
}

--
--
-- -- Get filename
-- local function get_file_extension(path)
--   ext = {}
--
--   for i = string.len(path), 1, -1 do
--     local char = path:sub(i, i)
--     print(char)
--   end
-- end
--
-- filename = get_file_extension '/matthew/thing/test.python'
