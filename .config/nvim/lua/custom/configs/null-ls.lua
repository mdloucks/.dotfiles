local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with {
    filetypes = { "html", "markdown", "css" },
  }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- PHP
  b.formatting.phpcbf,

  -- Go
  b.formatting.gofumpt,
  null_ls.builtins.formatting.golines.with {
    extra_args = {
      "--max-len=180",
      "--base-formatter=gofumpt",
    },
  },

  -- cpp
  b.formatting.clang_format,
}

local gotest = require("go.null_ls").gotest()
local gotest_codeaction = require("go.null_ls").gotest_action()
-- local golangci_lint = require("go.null_ls").golangci_lint()
table.insert(sources, gotest)
-- table.insert(sources, golangci_lint)
table.insert(sources, gotest_codeaction)

null_ls.setup {
  debug = true,
  sources = sources,
}
