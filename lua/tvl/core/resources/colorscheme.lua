return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        notify = true,
        neotree = true,
        noice = true,
        navic = {
          enabled = true
        },
        ts_rainbow2 = true,
        telescope = {
          eanbled = true,
        },
        which_key = true,
      },
    },
    config = function(_,opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end
  },

  -- {
  --   "loctvl842/monokai-pro.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   keys = { { "<leader>C", "<cmd>MonokaiProSelect<cr>", desc = "Select Moonokai pro filter" } },
  --   config = function()
  --     local monokai = require("monokai-pro")
  --     monokai.setup({
  --       transparent_background = false,
  --       devicons = true,
  --       filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
  --       day_night = {
  --         enable = false,
  --         day_filter = "classic",
  --         night_filter = "octagon",
  --       },
  --       inc_search = "background", -- underline | background
  --       background_clear = {},
  --       plugins = {
  --         bufferline = {
  --           underline_selected = true,
  --           underline_visible = false,
  --           bold = false,
  --         },
  --         indent_blankline = {
  --           context_highlight = "pro", -- default | pro
  --           context_start_underline = true,
  --         },
  --       },
  --       override = function(c)
  --         return {
  --           ColorColumn = { bg = c.base.dimmed3 },
  --           -- Mine
  --           DashboardRecent = { fg = c.base.magenta },
  --           DashboardProject = { fg = c.base.blue },
  --           DashboardConfiguration = { fg = c.base.white },
  --           DashboardSession = { fg = c.base.green },
  --           DashboardLazy = { fg = c.base.cyan },
  --           DashboardServer = { fg = c.base.yellow },
  --           DashboardQuit = { fg = c.base.red },
  --         }
  --       end,
  --     })
  --     monokai.load()
  --   end,
  -- },
}
