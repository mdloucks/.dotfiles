local options = {

  pickers = {
    find_files = {
      theme = 'dropdown',
    },
  },
  defaults = {
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
      },
      vertical = {
        mirror = false,
      },
    },
  },
}

return options
