--@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!

M.lawnmowerdave = {
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "move line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "move line up" },
  },
  n = {
    ["<C-x>"] = {
      "<C-\\><C-n>",
    },
    -- center everything after navigation
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },

    ["n"] = { "nzz" },
    ["N"] = { "Nzz" },

    ["f"] = { "\"d" },

    ["<leader>bd"] = { ":w<CR>:bd<CR>" },
  },
}

return M
