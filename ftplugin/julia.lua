local options = {
  shiftwidth = 4,
  tabstop = 4,
  textwidth = 92,
  colorcolumn = "+1",
}

for k, v in pairs(options) do
  vim.opt_local[k] = v
end

-- vim.diagnostic.hide()
-- vim.diagnostic.show(nil, 0, nil, { severity = { min = vim.diagnostic.severity.ERROR } })

vim.diagnostic.config({
  virtual_text = false,
})
