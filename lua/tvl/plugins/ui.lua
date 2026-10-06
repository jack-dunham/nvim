local Util = require("tvl.util")
local Icon = require("tvl.core.icons")

return {
  {
    "j-hui/fidget.nvim",
    enabled = false,
    opts = {
      notification = {
        override_vim_notify = false,
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    enabled = false,
    event = { "BufReadPost" },
    opts = {
      options = {
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        diagnostics_indicator = function(count, _, _, _)
          if count > 9 then
            return "9+"
          end
          return tostring(count)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "EXPLORER",
            highlight = "Directory",
            text_align = "left",
            -- separator = true,
          },
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        -- numbers = function(opts)
        --   return string.format("%s.%s", opts.id, opts.raise(opts.ordinal))
        -- end,
        numbers = "ordinal",
        -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      local lualine_config = require("tvl.config.lualine")
      lualine_config.setup({
        float = false,
        separator = "bubble", -- bubble | triangle
        ---@type any
        colorful = true,
      })
      lualine_config.load()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    enabled = false,
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        enabled = false,
        char = "▏",
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Trouble",
          "alpha",
          "neo-tree",
        },
        buftypes = {
          "terminal",
          "nofile",
        },
      },
      -- char_highlight_list = {
      --   "IndentBlanklineIndent1",
      --   "IndentBlanklineIndent2",
      --   "IndentBlanklineIndent3",
      --   "IndentBlanklineIndent4",
      --   "IndentBlanklineIndent5",
      --   "IndentBlanklineIndent6",
      -- },
    },
  },

  { "nvim-mini/mini.animate", version = "*", opts = { cursor = { enable = false } } },

  {
    "echasnovski/mini.indentscope",
    lazy = true,
    event = "BufEnter",
    enabled = false,
    -- lazy = true,
    version = false, -- wait till new 0.7.0 release to put it back on semver
    -- event = "BufReadPre",
    opts = {
      symbol = "▏",
      -- symbol = "│",
      options = { try_as_border = false },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    enabled = true,
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },
  {
    "utilyre/barbecue.nvim",
    enabled = false,
    event = { "BufReadPost" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "tokyonight",
      include_buftypes = { "" },
      exclude_filetypes = { "gitcommit", "Trouble", "toggleterm" },
      show_modified = false,
      kinds = Icon.kinds,
    },
    config = function(_, opts)
      require("nvim-navic").setup({
        highlight = true,
      })
      require("barbecue").setup(opts)
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    event = { "BufReadPost" },
    enabled = false,
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      start_in_insert = true,
      direction = "horizontal",
      autochdir = false,
      highlights = {
        FloatBorder = { link = "ToggleTermBorder" },
        Normal = { link = "ToggleTerm" },
        NormalFloat = { link = "ToggleTerm" },
      },
      winbar = {
        enabled = true,
        name_formatter = function(term)
          return string.format("%d:%s", term.id, term:_display_name())
        end,
      },
      shade_terminals = true,
    },
  },

  -- {
  --   "milanglacier/yarepl.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     wincmd = "botright 25 split",
  --     buflisted = false,
  --     metas = {
  --       julia = {
  --         cmd = "julia",
  --         formatter = function(lines)
  --           return lines
  --           -- return table.insert(lines, "<Enter>")
  --         end,
  --       },
  --     },
  --   },
  --   keys = {
  --     { [[<C-\>]], "<cmd>REPLFocus<cr>", desc = "Focus REPL" },
  --     { [[<C-\>]], "<cmd>REPLSendVisual<cr>", desc = "Send to REPL", mode = "v" },
  --     { "<leader>rs", "<cmd>REPLStart<cr>", desc = "Start REPL" },
  --     { "<leader>rf", "<cmd>REPLFocus<cr>", desc = "Focus REPL" },
  --     { "<leader>rh", "<cmd>REPLHide<cr>", desc = "Hide REPL" },
  --     { "<leader>rq", "<cmd>REPLClose<cr>", desc = "Quit REPL" },
  --     { "<leader>rc", "<cmd>REPLCleanup<cr>", desc = "Clear REPL" },
  --     { "<leader>rr", "<cmd>REPLSendVisual<cr>", desc = "Send selection to REPL", mode = "v" },
  --     { "<leader>rr", "<cmd>REPLSendLine<cr>", desc = "Send current line to REPL", mode = "n" },
  --     { "<leader>re", "<cmd>REPLExec<cr>", desc = "Execute command in REPL" },
  --   },
  --   config = function(_, opts)
  --     vim.api.nvim_create_user_command("REPLStartOrFocus", function()
  --       local current_buffer = vim.api.nvim_get_current_buf()
  --       local repl = require("yarepl").bufnr_is_attached_to_repl(current_buffer)
  --       if not repl then
  --         vim.cmd("1REPLStart")
  --         vim.cmd("1REPLAttachBufferToREPL")
  --       end
  --       vim.cmd("REPLFocus")
  --     end, {})
  --     require("yarepl").setup(opts)
  --   end,
  -- },

  -- {
  --   "Vigemus/iron.nvim",
  --   branch = "master",
  --   keys = {
  --     { [[<C-\>]], "<cmd>IronFocus<cr>i", desc = "Focus/open REPL" },
  --     { [[<C-\>]], "<cmd>lua require('iron.core').visual_send()<cr>", desc = "Send to REPL", mode = "v" },
  --     { "<leader>rs", "<cmd>IronRepl<cr>", desc = "Start REPL" },
  --     { "<leader>rf", "<cmd>IronFocus<cr>i", desc = "Focus REPL" },
  --     { "<leader>rh", "<cmd>IronHide<cr>", desc = "Hide REPL" },
  --     { "<leader>rr", "<cmd>lua require('iron.core').visual_send()<cr>", desc = "Send selection to REPL", mode = "v" },
  --     { "<leader>rr", "<cmd>lua require('iron.core').send_line()<cr>", desc = "Send current line to REPL" },
  --   },
  --   config = function()
  --     local core = require("iron.core")
  --     local view = require("iron.view")
  --     local opts = {
  --       config = {
  --         repl_definition = {
  --           -- sh = { command = { "zsh" } },
  --           -- julia = { commmand = { "julia" } },
  --         },
  --         repl_open_cmd = view.split.horizontal.botright(25),
  --       },
  --     }
  --     core.setup(opts)
  --   end,
  -- },

  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    enabled = false,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    keys = { { "<leader>0", "<cmd>Dashboard<CR>", desc = "Dashboard" } },
    config = function()
      require("tvl.config.dashboard")
    end,
  },

  -- {
  --   "goolord/alpha-nvim",
  --   event = "VimEnter",
  --   keys = { { "<leader>a", "<cmd>Alpha<cr>", "Alpha" } },
  --   config = function()
  --     require("tvl.config.alpha")
  --   end,
  -- },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  {
    "petertriho/nvim-scrollbar",
    enabled = false,
    event = "BufReadPost",
    opts = {
      set_highlights = false,
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "neo-tree",
        "dashboard",
        "alpha",
        "lazy",
        "mason",
        "DressingInput",
        "",
      },
      handlers = {
        gitsigns = true,
      },
    },
  },
  {
    "anuvyklack/windows.nvim",
    enabled = true,
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = true },
    },
    opts = {
      animation = { enable = false, duration = 150, fps = 60 },
      autowidth = { enable = false },
    },
    keys = { { "<leader>M", "<cmd>WindowsMaximize<CR>", desc = "Zoom window" } },
    init = function()
      vim.o.winwidth = 20
      vim.o.winminwidth = 20
      vim.o.equalalways = false
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*", "!lazy", "!neo-tree" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {
      -- input = {
      --   border = Util.generate_borderchars("thick", "tl-t-tr-r-bl-b-br-l"),
      --   win_options = { winblend = 0 },
      -- },
      -- select = { telescope = Util.telescope_theme("cursor") },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
    end,
  },

  {
    "kosayoda/nvim-lightbulb",
    enabled = false,
    opts = {
      sign = {
        enabled = true,
        text = "",
        -- Priority of the gutter sign
        priority = 20,
      },
      status_text = {
        enabled = true,
        -- Text to provide when code actions are available
        text = "status_text",
        -- Text to provide when no actions are available
        text_unavailable = "",
      },
      autocmd = {
        enabled = true,
        -- see :help autocmd-pattern
        pattern = { "*" },
        -- see :help autocmd-events
        events = { "CursorHold", "CursorHoldI", "LspAttach" },
      },
    },
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      notify = { enabled = false },
      presets = { lsp_doc_border = true },
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline = { icon = "  " },
          search_down = { icon = "  󰄼" },
          search_up = { icon = "  " },
          lua = { icon = " " },
        },
      },
      lsp = {
        progress = { enabled = false },
        hover = { enabled = false },
        signature = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "%d+L, %d+B",
          },
        },
      },
    },
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    ---@module 'edgy'
    ---@param opts Edgy.Config
    opts = function(_, opts)
      opts["exit_when_last"] = true
      opts["animate"] = { enabled = false }
      for _, pos in ipairs({ "top", "bottom", "left" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.3 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
      for _, pos in ipairs({ "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { width = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end

      table.insert(
        opts["bottom"],
        { ft = "iron", title = "%{b:terminal_job_id}: %{b:term_title}", size = { height = 0.3 } }
      )
      table.insert(opts["left"], { title = "DAP Scopes", ft = "dapui_scopes", size = { width = 40 } })
      table.insert(opts["left"], { title = "DAP Breakpoints", ft = "dapui_breakpoints" })
      table.insert(opts["left"], { title = "DAP Stacks", ft = "dapui_stacks" })
      table.insert(opts["left"], { title = "DAP Watches", ft = "dapui_watches" })
      table.insert(opts["bottom"], { title = "DAP REPL", ft = "dap-repl", size = { height = 0.3 } })
      table.insert(opts["bottom"], { title = "DAP Console", ft = "dapui_console" })
    end,
    -- init = function()
    --   vim.opt.laststatus = 3
    --   vim.opt.splitkeep = "topline"
    -- end,
    -- opts = {
    --   exit_when_last = true,
    --   bottom = {
    --     -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
    --     {
    --       title = "TERMINAL",
    --       ft = "toggleterm",
    --       size = { height = 0.35 },
    --       -- exclude floating windows
    --       filter = function(buf, win)
    --         return vim.api.nvim_win_get_config(win).relative == ""
    --       end,
    --     },
    --   },
  },
  {
    "stevearc/stickybuf.nvim",
    enabled = false,
    opts = {
      get_auto_pin = function(bufnr)
        local buftype = vim.bo[bufnr].buftype
        if buftype == "terminal" then
          return "buftype"
        else
          return require("stickybuf").should_auto_pin(bufnr)
        end
      end,
    },
  },
  {
    "willothy/flatten.nvim",
    enabled = false,
    opts = function()
      ---@type Terminal?
      local saved_terminal

      return {
        window = {
          open = "alternate",
        },
        callbacks = {
          should_block = function(argv)
            -- Note that argv contains all the parts of the CLI command, including
            -- Neovim's path, commands, options and files.
            -- See: :help v:argv

            -- In this case, we would block if we find the `-b` flag
            -- This allows you to use `nvim -b file1` instead of
            -- `nvim --cmd 'let g:flatten_wait=1' file1`
            return vim.tbl_contains(argv, "-b")

            -- Alternatively, we can block if we find the diff-mode option
            -- return vim.tbl_contains(argv, "-d")
          end,
          pre_open = function()
            local term = require("toggleterm.terminal")
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              -- Hide the terminal while it's blocking
              saved_terminal:close()
            else
              -- If it's a normal file, just switch to its window
              vim.api.nvim_set_current_win(winnr)
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }
    end,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  -- {
  --   url = "https://gitlab.com/usmcamp0811/nvim-julia-autotest.git",
  --   opts = {},
  -- },
}
