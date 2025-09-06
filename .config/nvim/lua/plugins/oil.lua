return {
  view_options = {
    show_hidden = true,
  },
  skip_confirm_for_simple_edits = true,
  float = {
    padding = 20,
    max_width = 0.5,   -- 50% width of editor
    max_height = 0.5,  -- 50% height of editor
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    override = function(conf)
      local width = math.floor(vim.o.columns * 0.5)
      local height = math.floor(vim.o.lines * 0.5)
      conf.width = width
      conf.height = height
      conf.row = math.floor((vim.o.lines - height) / 2)
      conf.col = math.floor((vim.o.columns - width) / 2)
      return conf
    end,
  },
}
