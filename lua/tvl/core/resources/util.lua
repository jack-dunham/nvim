return {

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
