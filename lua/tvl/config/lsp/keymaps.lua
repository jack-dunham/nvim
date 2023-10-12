local M = {}

M.attach = function(client, buffer)
  local opts = { noremap = true, silent = true }
  local map = vim.api.nvim_buf_set_keymap
  map(buffer, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map(
    buffer,
    "n",
    "gl",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    { desc = "Open diagnostics in floating window", noremap = true, silent = true }
  )
  map(
    buffer,
    "n",
    "<leader>cs",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    { desc = "Signature help", noremap = true, silent = true }
  )
  map(
    buffer,
    "n",
    "[d",
    "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
    { desc = "Previous diagnostic", noremap = true, silent = true }
  )
  map(
    buffer,
    "n",
    "]d",
    "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
    { desc = "Next diagnostic", noremap = true, silent = true }
  )
  map(
    buffer,
    "n",
    "<leader>cq",
    "<cmd>lua vim.diagnostic.setloclist()<CR>",
    { desc = "Add diagnostics to location list", noremap = true, silent = true }
  )
end

return M
