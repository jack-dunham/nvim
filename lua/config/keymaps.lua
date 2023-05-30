-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Disable arrow keys
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Diable mouse scrolling
for _, amplitude in ipairs({ "", "S-", "C" }) do
  for _, direction in ipairs({ "Up", "Down", "Left", "Right" }) do
    for _, modus in ipairs({ "", "i" }) do
      map(modus, "<" .. amplitude .. "ScrollWheel" .. direction .. ">", "<Nop>", {})
    end
  end
end
