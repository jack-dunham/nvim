return {
  {
    "mg979/vim-visual-multi",
    event = "BufAdd",
  },

  {
    "toppair/peek.nvim",
    priority = 10,
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>p",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    opts = { theme = "dark" },
  },

  {
    "moll/vim-bbye",
    event = { "BufRead" },
    keys = { { "<leader>d", "<cmd>Bdelete!<cr>", desc = "Close buffer" } },
  },
  {
    "natecraddock/workspaces.nvim",
    opts = {
      hooks = {
        open = "Telescope find_files",
      },
    },
    cmd = { "WorkspacesAdd", "WorkspacesRemove", "WorkspacesList", "WorkspacesOpen" },
    keys = {
      { "<leader>fw", ":Telescope workspaces<cr>", desc = "Find workspaces" },
      { "<leader>Qo", ":WorkspacesOpen<cr>", desc = "Open workspaces" },
      { "<leader>Qa", ":WorkspacesAdd<cr>", desc = "Add current workspace" },
      { "<leader>Qr", ":WorkspacesRemove<cr>", desc = "Remove current workspace" },
      { "<leader>Ql", ":WorkspacesList<cr>", desc = "List workspaces" },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "blank", "terminal", "folds", "tabpages" },
    },
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore last session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't save current session",
      },
    },
  },
}
