return {
  dev_log = {
    enabled = true,
  },
  fvm = true,
  -- debugger = {
  --   enabled = true,
  --   exception_breakpoints = {},
  --   run_via_dap = true,
  -- },
  closing_tags = {
    highlight = "ErrorMsg", -- highlight for the closing tag
    prefix = ">",           -- character to use for close tag e.g. > Widget
    enabled = true          -- set to false to disable
  },
}
