local Util = require("tvl.util")
local Icon = require("tvl.core.icons")

return {
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        override_vim_notify = true,
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
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
        -- offsets = {
        --   {
        --     filetype = "neo-tree",
        --     text = "EXPLORER",
        --     text_align = "center",
        --     -- separator = true,
        --   },
        -- },
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

  {
    "echasnovski/mini.indentscope",
    lazy = true,
    event = "BufEnter",
    enabled = true,
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
    "utilyre/barbecue.nvim",
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
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    opts = {
      animation = { enable = false, duration = 150, fps = 60 },
      autowidth = { enable = true },
    },
    keys = { { "<leader>m", "<cmd>WindowsMaximize<CR>", desc = "Zoom window" } },
    init = function()
      vim.o.winwidth = 30
      vim.o.winminwidth = 30
      vim.o.equalalways = true
    end,
    enabled = true,
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
    opts = {
      sign = {
        enabled = true,
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
    enabled = { true },
    opts = {
      notify = { enabled = false },
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
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "topline"
    end,
    keys = {
      {
        "<leader>-",
        function()
          require("edgy").toggle("left")
        end,
        desc = "Toggle sidebar",
      },
    },
    opts = {
      exit_when_last = true,
      bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
          title = "TERMINAL",
          ft = "toggleterm",
          size = { height = 0.35 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
      },
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "FILES",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          -- size = { height = 0.5 },
          open = function()
            require("neo-tree.command").execute({
              actions = "show",
              position = "left",
              dir = require("tvl.util").get_root(),
            })
          end,
        },
        -- {
        --   title = "OUTLINE",
        --   ft = "neo-tree",
        --   filter = function(buf)
        --     return vim.b[buf].neo_tree_source == "document_symbols"
        --   end,
        --   pinned = true,
        --   size = { height = 0.5 },
        --   open = "Neotree position=top document_symbols",
        -- },
        {
          title = "OUTLINE",
          ft = "Outline",
          pinned = true,
          open = "OutlineOpen!",
          -- size = { height = 0.5 },
        },
        -- any other neo-tree windows
        "neo-tree",
      },
    },
  },
  {
    "echasnovski/mini.animate",
    enabled = false,
    version = "*",
    config = function()
      local animate = require("mini.animate")
      local timing = animate.gen_timing.linear({ duration = 50, unit = "total" })
      local opts = {
        scroll = {
          enable = false,
        },
        resize = {
          timing = timing,
        },
        open = {
          timing = timing,
        },
        clsoe = {
          timing = timing,
        },
      }
      animate.setup(opts)
    end,
  },
  {
    "karb94/neoscroll.nvim",
    keys = {
      -- { "<c-d>", Util.lazy_keys("<c-d>zz"), { desc = "Scroll down half screen" } },
      -- { "<c-u>", Util.lazy_keys("<c-u>zz"), { desc = "Scroll up half screen" } },
      {
        "<c-u>",
        '<cmd>lua vim.api.nvim_command("normal " .. vim.wo.scroll .. "k"); require("neoscroll").zz(220)<cr>',
        { desc = "Scroll up half screen" },
      },
      {
        "<c-d>",
        '<cmd>lua vim.api.nvim_command("normal " .. vim.wo.scroll .. "j"); require("neoscroll").zz(220)<cr>',
        { desc = "Scroll down half screen" },
      },
      "zz",
      "zt",
      "zb",
      "G",
      "gg",
      "n",
      "N",
    },
    opts = {
      easing_function = "sine",
      mappings = { "zz", "zt", "zb", "G", "gg" },
    },
    config = function(_, opts)
      require("neoscroll").setup(opts)
      vim.keymap.set("n", "n", "(v:searchforward ? 'nzz' : 'Nzz' )", { expr = true, remap = true })
      vim.keymap.set("n", "N", "(v:searchforward ? 'Nzz' : 'nzz' )", { expr = true, remap = true })
    end,
  },
  {
    "stevearc/stickybuf.nvim",
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
  -- {
  --   url = "https://gitlab.com/usmcamp0811/nvim-julia-autotest.git",
  --   opts = {},
  -- },
}
