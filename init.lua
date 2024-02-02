-- bootstrap lazy.nvim, LazyVim and your plugins
require("tvl.core.lazy")
-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path =package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path =package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
