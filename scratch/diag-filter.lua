local unused
unused = nothing

local filter_diagnostics = function(diagnostics, level)
  local filtered_diag = {}
  for _, d in ipairs(diagnostics) do
    if d.severity <= level then
      table.insert(filtered_diag, 1, d)
    end
  end
  return filtered_diag
end

-- save the original diagnostics handler
local orig_diag_virt_handler = vim.diagnostic.handlers.virtual_text

-- define our custom diagnostics namespace
local ns = vim.api.nvim_create_namespace("my_diagnostics")

local set_diagnostics_level = function(level)
  -- Register our custom handler
  vim.diagnostic.handlers.virtual_text = {
    -- our custom show method
    show = function(_, bufnr, _, opts)
      -- get all diagnostics for local buffer
      local diagnostics = vim.diagnostic.get(bufnr)
      -- filter diags based on severity
      filtered = filter_diagnostics(diagnostics, level)
      orig_diag_virt_handler.show(ns, bufnr, filtered, opts)
    end,
    hide = function(_, bufnr)
      orig_diag_virt_handler.hide(ns, bufnr)
    end,
  }

  bufnr = vim.api.nvim_get_current_buf()
  -- hide all diagnostics
  vim.diagnostic.hide(nil, bufnr)
  local diags = vim.diagnostic.get(bufnr)
  -- it is important to make sure we don't pass an empty table
  if #diags > 0 then
    filtered = filter_diagnostics(diags, level)
    -- we display back the filtered diagnostics until the -- registered
    -- handler is called. If we don't, all diagnostics will disappear -- until
    -- the registered handler is executed, usually after a save or insert --
    -- event
    vim.diagnostic.show(ns, bufnr, filtered)
  end
end

-- set_diagnostics_level(vim.diagnostic.severity.ERROR)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Enable underline, use default values
  underline = true,
  -- Enable virtual text, override spacing to 4
  virtual_text = {
    spacing = 4,
    prefix = "~",
  },
  -- Use a function to dynamically turn signs off
  -- and on, using buffer local variables
  signs = function(bufnr, client_id)
    local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, "show_signs")
    -- No buffer local variable set, so just enable by default
    if not ok then
      return true
    end

    return result
  end,
  -- Disable a feature
  update_in_insert = false,
})
