return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      toggle = { enabled = true },
      indent = { enabled = true },
    },
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- {
  --   "3rd/image.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     backend = "kitty",
  --     integrations = {
  --       markdown = {
  --         enabled = false,
  --       },
  --       neorg = {
  --         enabled = false,
  --       },
  --     },
  --   },
  -- },
}
