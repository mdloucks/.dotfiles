
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',                 -- Apply to all file types
  callback = function()
    -- Remove auto-commenting when pressing o/O or entering insert after comment
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" --[[or ev.data.kind == "install"]] then
      local ok, _ = pcall(function() require "nvim-treesitter".update "all" end)
      if not ok then vim.notify "[ERROR] Failed to update nvim-treesitter parsers" end
    end
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable treesitter highlighting and indents",
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if lang and vim.treesitter.language.add(lang) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end
  end
})
