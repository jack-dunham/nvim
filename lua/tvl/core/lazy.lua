local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local diagnostics = require("tvl.config.lsp.diagnostics")

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.o.exrc = true

-- load lazy
require("lazy").setup({
  spec = { { import = "tvl.plugins" } },
  defaults = {
    lazy = false,
    -- version = false, -- always use the latest git commit
    version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = false, notify = false },
  dev = { path = "~/Projects/nvim/plugins" },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.lsp.enable({ "jetls", "lua_ls", "bashls", "texlab", "pyright" })

vim.diagnostic.config({ signs = diagnostics.signs })
vim.diagnostic.config(diagnostics.diagnostics["on"])
