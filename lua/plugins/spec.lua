local Util = require("util")
local Icons = require("core.icons")

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- Configure LazyVim to load gruvbox

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-pro-default",
    },
  },

  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
    end,
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- add tsx and treesitter
        ensure_installed = {
          "julia",
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      },
    },
  },

  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
    lazy = false,
  },

  { "akinsho/bufferline.nvim", enabled = false },
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = true },
  {
    "folke/noice.nvim",
    opts = {
      commands = { history = { view = "popup" } },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
    },
    enabled = false,
    lazy = false,
  },

  { "nvim-lualine/lualine.nvim", lazy = false },

  {
    url = "https://gitlab.com/usmcamp0811/nvim-julia-autotest",
    ft = "julia",
    config = function()
      require("julia-autotest").setup()
    end,
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
        easing_function = "quadratic",
      })
    end,
    lazy = false,
  },
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({})
    end,
    lazy = false,
  },
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },

  {
    "akinsho/toggleterm.nvim",
    -- dependencies = { "stevearc/stickybuf.nvim" },
    keys = {
      { "<leader>rt", "<cmd>lua require('config.terminal')._repl_toggle()<cr>", desc = "Toggle REPL" },
      {
        "<leader>ri",
        "<cmd>lua require('config.terminal')._repl_include_file()<cr>",
        desc = "Include/insert file in REPL",
      },
    },
    config = function()
      require("config.terminal")
      require("toggleterm").setup({ size = 20 })
    end,
  },

  {
    "stevearc/stickybuf.nvim",
    opts = {},
    config = function()
      require("stickybuf").setup({
        buftype = {
          terminal = "bufnr",
        },
      })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>-", "<cmd>NvimTreeFocus<cr>", desc = "Un(focus) file explorer" },
      -- { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    },
    opts = {
      renderer = { highlight_opened_files = "all" },
    },
    config = function()
      require("config.nvim-tree")
    end,
  },

  {
    "loctvl842/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, position = "left", dir = require("util").get_root() })
        end,
        desc = "Explorer (root dir)",
        remap = true,
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            position = "float",
            dir = Util.get_root(),
          })
        end,
        desc = "Explorer Float (root dir)",
      },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = Util.generate_borderchars("thick", "tl-t-tr-r-bl-b-br-l"),
      -- source_selector provides clickable tabs to switch between sources.
      source_selector = {
        winbar = true, -- toggle to show selector on winbar
        content_layout = "center",
        tabs_layout = "equal",
        show_separator_on_edge = true,
        tab_labels = {
          filesystem = "󰉓",
          buffers = "󰈙",
          git_status = "",
          diagnostics = "󰒡",
        },
      },

      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          -- expander config, needed for nesting files
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          folder_empty_open = "",
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = " ",
        },
        modified = { symbol = "[+]" },
        git_status = { symbols = Icons.git },
        diagnostics = { symbols = Icons.diagnostics },
      },
      window = {
        width = 40,
        mappings = {
          ["<1-LeftMouse>"] = "open",
          ["l"] = "open",
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["H"] = "navigate_up",
            ["<bs>"] = "toggle_hidden",
            ["."] = "set_root",
            ["/"] = "fuzzy_finder",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["a"] = { "add", config = { show_path = "relative" } }, -- "none", "relative", "absolute"
          },
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
      },
    },
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
