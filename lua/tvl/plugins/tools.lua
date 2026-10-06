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
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            {
              id = "console",
              size = 1.0,
            },
          },
          position = "bottom",
          size = 30,
        },
      },
    },
    keys = {
      {
        "<leader>du",
        function()
          require("dap").continue()
          require("dapui").toggle()
          require("dap").repl.toggle()
        end,
        desc = "Dap UI",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "kdheepak/nvim-dap-julia",
      config = function()
        require("nvim-dap-julia").setup()
      end,
    },
    keys = {
      -- stylua: ignore start
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint", },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor", },
      { "<leader>dT", function() require("dap").terminate() end, desc = "Terminate", },
      -- stylua: ignore end
    },
  },
  -- {
  --   "igorlfs/nvim-dap-view",
  --   lazy = false,
  --   enabled = false,
  --   version = "1.*",
  --   ---@module 'dap-view'
  --   ---@type dapview.Config
  --   opts = {},
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --   },
  --   -- stylua: ignore start
  --   keys = {
  --     { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
  --     { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  --     { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
  --     { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
  --     { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
  --     { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
  --     { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
  --     { "<leader>dj", function() require("dap").down() end, desc = "Down" },
  --     { "<leader>dk", function() require("dap").up() end, desc = "Up" },
  --     { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
  --     { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
  --     { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
  --     { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
  --     { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
  --     { "<leader>ds", function() require("dap").session() end, desc = "Session" },
  --     { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
  --     { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  --   },
  --   -- stylua: ignore end
  -- },
  -- {
  --   "kdheepak/nvim-dap-julia",
  --   lazy = true,
  --   config = function()
  --     local nvim_dap_julia = require("nvim-dap-julia")
  --     nvim_dap_julia.setup({
  --       adapters = {
  --         julia = {
  --           type = "server",
  --           port = "${port}",
  --           executable = {
  --             command = "julia",
  --             args = {
  --               "--startup-file=" .. "no",
  --               "--project=" .. nvim_dap_julia.get_plugin_root(),
  --               nvim_dap_julia.get_debugger_script(),
  --               "${port}",
  --             },
  --           },
  --           options = {
  --             max_retries = 100,
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   -- event = "VeryLazy",
  --   -- enabled = true,
  --   dependencies = {
  --     -- "kdheepak/nvim-dap-julia",
  --     --
  --     -- config = function()
  --     --   vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
  --     -- end,
  --   },
  -- },
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
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "snacks.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
      -- I find auto open annoying, keep in mind setting this option will require setting
      -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
      vim.g.molten_auto_open_output = false

      -- this guide will be using image.nvim
      -- Don't forget to setup and install the plugin if you want to view image outputs
      vim.g.molten_image_provider = "snacks.nvim"

      -- optional, I like wrapping. works for virt text and the output window
      vim.g.molten_wrap_output = true

      -- Output as virtual text. Allows outputs to always be shown, works with images, but can
      -- be buggy with longer images
      vim.g.molten_virt_text_output = true

      -- this will make it so the output shows up below the \`\`\` cell delimiter
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },
  {
    "Vigemus/iron.nvim",
    keys = {
      {
        "<c-\\>",
        function()
          local config = require("iron.config")
          local custom_fts = vim.tbl_keys(config.repl_definition)
          -- vim.list_extend(custom_fts, vim.tbl_keys(require("iron.fts")))
          local ft = vim.bo.filetype
          if ft == "iron" then
            vim.cmd("startinsert")
            return
          elseif not vim.tbl_contains(custom_fts, vim.bo.filetype) then
            ft = "zsh"
          end
          vim.cmd({ cmd = "IronFocus", args = { ft } })
          vim.cmd("startinsert")
        end,
        desc = "Focus REPL",
        mode = { "n" },
      },
      { "<space>rR", desc = "Restart REPL" },
      { "<space>rc", desc = "Send motion" },
      { "<space>rc", desc = "Send selection", mode = { "v" } },
      { "<C-Space>", desc = "Send selection", mode = { "v" } },
      { "<space>rf", desc = "Send file" },
      { "<space>rl", desc = "Send line" },
      { "<C-Space>", desc = "Send line" },
      { "<space>ru", desc = "Send until cursor" },
      { "<space>rm", desc = "Send mark" },
      { "<space>rb", desc = "Send code block" },
      { "<space>rn", desc = "Send code block and move" },
      { "<space>mc", desc = "Mark motion" },
      { "<space>md", desc = "Remove mark" },
      { "<space><cr>", desc = "REPL <CR>" },
      { "<space>r<space>", desc = "Interrupt REPL" },
      { "<space>rq", desc = "Exit REPL" },
      { "<leader>rd", desc = "Clear REPL" },
    },
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      iron.setup({
        config = {
          repl_definition = {
            julia = {
              command = { "julia", "-i" },
              format = require("iron.fts.common").bracketed_paste,
            },
          },
          dap_integration = true,
          repl_open_cmd = view.split.botright("30%", { winfixbuf = true }),
          -- repl_open_cmd = view.bottom("30%"),
        },
        keymaps = {
          restart_repl = "<space>rR",
          send_motion = "<space>rc",
          -- visual_send = "<space>rc",
          visual_send = "<C-space>",
          send_file = "<space>rf",
          send_line = "<C-space>",
          -- send_line = "<space>rl",
          send_until_cursor = "<space>ru",
          send_mark = "<space>rm",
          send_code_block = "<space>rb",
          send_code_block_and_move = "<space>rn",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space><cr>",
          interrupt = "<space>r<space>",
          exit = "<space>rq",
          clear = "<space>rd",
        },
      })
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      { "<leader>-", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "File Browser" },
      -- { -- Open in the current working directory
      --   "<leader>cw",
      --   "<cmd>Yazi cwd<cr>",
      --   desc = "Open the file manager in nvim's working directory",
      -- },
      -- { "<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = { show_help = "<f1>" },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- mark netrw as loaded so it's not loaded at all.
      --
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        split_side = "right", -- "left" or "right"
        split_width_percentage = 0.50,
      },
    },
    -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
    -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
    -- spec defers loading until a <leader>a* mapping is pressed and the commands
    -- would not exist yet.
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "folke/sidekick.nvim",
    enabled = false,
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
        win = {
          config = function(terminal)
            local orig_open_win = terminal.open_win
            function terminal:open_win()
              orig_open_win(self)
              if self.win and vim.api.nvim_win_is_valid(self.win) then
                vim.api.nvim_win_call(self.win, function()
                  vim.fn.winrestview({ leftcol = 0 })
                end)
              end
            end
          end,
        },
      },
      nes = {
        enabled = false,
      },
    },
    keys = {
      -- {
      --   "<c-'>",
      --   function()
      --     -- if there is a next edit, jump to it, otherwise apply it if any
      --     if not require("sidekick").nes_jump_or_apply() then
      --       return "<Tab>" -- fallback to normal tab
      --     end
      --   end,
      --   expr = true,
      --   desc = "Goto/Apply Next Edit Suggestion",
      -- },
      {
        "<c-.>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      -- Example of a keybinding to open Claude directly
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Toggle Claude",
      },
    },
  },
}
