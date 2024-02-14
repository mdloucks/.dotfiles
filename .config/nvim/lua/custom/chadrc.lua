---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "nightfox",
  theme_toggle = { "nightfox", "one_light" },
  transparency = false,
  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    separator_style = "default",
    -- theme = "vscode_colored"
  }
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"


return M
