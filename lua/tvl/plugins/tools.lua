local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    if config.type and config.type == "java" then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

return {
  {
    "mg979/vim-visual-multi",
    event = "BufAdd",
  },
  {
    "jbyuki/venn.nvim",
    keys = {
      {
        "<leader>v",
        function()
          local venn_enabled = vim.inspect(vim.b.venn_enabled)
          if venn_enabled == "nil" then
            vim.b.venn_enabled = true
            vim.cmd([[setlocal ve=all]])
            -- draw a line on HJKL keystokes
            vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true, silent = true })
            -- draw a box by pressing "f" with visual selection
            vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true, silent = true })
          else
            vim.cmd([[setlocal ve=]])
            vim.api.nvim_buf_del_keymap(0, "n", "J")
            vim.api.nvim_buf_del_keymap(0, "n", "K")
            vim.api.nvim_buf_del_keymap(0, "n", "L")
            vim.api.nvim_buf_del_keymap(0, "n", "H")
            vim.api.nvim_buf_del_keymap(0, "v", "f")
            vim.b.venn_enabled = nil
          end
        end,
        desc = "Toggle Venn",
      },
    },
  },

  {
    "moll/vim-bbye",
    enabled = false,
    event = { "BufRead" },
    keys = { { "<leader>bd", "<cmd>Bdelete!<cr>", desc = "Close buffer" } },
  },
  {
    "natecraddock/workspaces.nvim",
    enabled = false,
    opts = {
      hooks = {
        open = "Telescope find_files",
      },
    },
    cmd = { "WorkspacesAdd", "WorkspacesRemove", "WorkspacesList", "WorkspacesOpen" },
    keys = {
      { "<leader>fw", ":Telescope workspaces<cr>", desc = "Find workspaces" },
      { "<leader>pp", ":WorkspacesOpen<cr>", desc = "Open workspaces" },
      { "<leader>pa", ":WorkspacesAdd<cr>", desc = "Add current workspace" },
      { "<leader>pr", ":WorkspacesRemove<cr>", desc = "Remove current workspace" },
      { "<leader>pl", ":WorkspacesList<cr>", desc = "List workspaces" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        opts = {},
      -- stylua: ignore
        keys = {
          { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
          { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
          { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
          { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
          { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
          { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
          { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
          { "<leader>dj", function() require("dap").down() end, desc = "Down" },
          { "<leader>dk", function() require("dap").up() end, desc = "Up" },
          { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
          { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
          { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
          { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
          { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
          { "<leader>ds", function() require("dap").session() end, desc = "Session" },
          { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
          { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        },
      },
      -- dependencies = {
      --   "rcarriga/nvim-dap-ui",
      --   -- {
      --   --   "theHamsta/nvim-dap-virtual-text",
      --   --   opts = {},
      --   -- },
      {
        "kdheepak/nvim-dap-julia",
        config = function()
          local nvim_dap_julia = require("nvim-dap-julia")
          nvim_dap_julia.setup({
            adapters = {
              julia = {
                type = "server",
                port = "${port}",
                executable = {
                  command = "julia",
                  args = {
                    "--startup-file=" .. "no",
                    "--project=" .. nvim_dap_julia.get_plugin_root(),
                    nvim_dap_julia.get_debugger_script(),
                    "${port}",
                  },
                },
                options = {
                  max_retries = 100,
                },
              },
            },
          })
        end,
      },
      --
      -- config = function()
      --   vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      -- end,
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
