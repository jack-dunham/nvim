vim.g.diagnostics_enabled = true

local icons = require("tvl.core.icons").diagnostics
local severity = vim.diagnostic.severity

local M = {}

M.diagnostics = {
  off = {
    underline = true,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
  },
  on = {
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    }, -- disable virtual text
    virtual_lines = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  },
}

M.signs = {
  text = {},
  linehl = {},
  numhl = {
    [severity.ERROR] = "DiagnosticSignError",
    [severity.WARN] = "DiagnosticSignWarn",
    [severity.HINT] = "DiagnosticSignHint",
    [severity.INFO] = "DiagnosticSignInfo",
  },
}

for name, icon in pairs(icons) do
  M.signs.text[severity[name]] = icon
  M.signs.linehl[severity[name]] = ""
end

vim.api.nvim_create_user_command("ToggleDiagnostic", function()
  if vim.g.diagnostics_enabled then
    vim.diagnostic.config(M.diagnostics["off"])
    vim.g.diagnostics_enabled = false
  else
    vim.diagnostic.config(M.diagnostics["on"])
    vim.g.diagnostics_enabled = true
  end
end, { nargs = 0 })

return M
