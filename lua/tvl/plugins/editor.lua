local Util = require("tvl.util")
local Icons = require("tvl.core.icons")

return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "<leader>F", ":Oil --float . <cr>", desc = "File explorer" },
    },
    opts = {
      delete_to_trash = true,
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            actions = "focus",
            position = "left",
            dir = require("tvl.util").get_root(),
          })
        end,
        desc = "Focus file tree",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({
            action = "show",
            toggle = true,
            position = "left",
            dir = require("tvl.util").get_root(),
          })
        end,
        desc = "Toggle file tree",
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
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "e  edgy" },
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      -- popup_border_style = Util.generate_borderchars("thick", "tl-t-tr-r-bl-b-br-l"),
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      -- source_selector provides clickable tabs to switch between sources.
      -- source_selector = {
      --   winbar = false, -- toggle to show selector on winbar
      --   content_layout = "center",
      --   tabs_layout = "equal",
      --   show_separator_on_edge = true,
      --   sources = {
      --     {
      --       source = "filesystem",
      --       display_name = "󰉓",
      --     },
      --     {
      --       source = "buffers",
      --       display_name = "󰈙",
      --     },
      --     {
      --       source = "git_status",
      --       display_name = "󰊢",
      --     },
      --     -- diagnostics = "󰒡",
      --   },
      -- },

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
          ["<bs>"] = function()
            vim.api.nvim_command("wincmd p")
          end,
          ["<leader>e"] = function()
            require("edgy").goto_main()
          end,
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["H"] = "navigate_up",
            ["."] = "toggle_hidden",
            [","] = "set_root",
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
        follow_current_file = {
          enabled = true,
        },
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    enabled = false,
    version = false, -- telescope did only one release, so use HEAD for now
    opts = {
      defaults = {
        -- mappings = {
        --   i = {
        --     ["<esc>"] = "close",
        --   },
        -- },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "   ",
        dynamic_preview_title = true,
        hl_result_eol = true,
        sorting_strategy = "ascending",
        file_ignore_patterns = {
          ".git/",
          "target/",
          "docs/",
          "vendor/*",
          "%.lock",
          "__pycache__/*",
          "%.sqlite3",
          "%.ipynb",
          "node_modules/*",
          -- "%.jpg",
          -- "%.jpeg",
          -- "%.png",
          "%.svg",
          "%.otf",
          "%.ttf",
          "%.webp",
          ".dart_tool/",
          ".github/",
          ".gradle/",
          ".idea/",
          ".settings/",
          ".vscode/",
          "__pycache__/",
          "build/",
          "gradle/",
          "node_modules/",
          "%.pdb",
          "%.dll",
          "%.class",
          "%.exe",
          "%.cache",
          "%.ico",
          "%.pdf",
          "%.dylib",
          "%.jar",
          "%.docx",
          "%.met",
          "smalljre_*/*",
          ".vale/",
          "%.burp",
          "%.mp4",
          "%.mkv",
          "%.rar",
          "%.zip",
          "%.7z",
          "%.tar",
          "%.bz2",
          "%.epub",
          "%.flac",
          "%.tar.gz",
          "lazy-lock.json",
        },
        results_title = "",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    },
    keys = {
      -- goto
      -- { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition" },
      -- { "gr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
      -- { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to implementations" },
      -- search
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Find colorschemes" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
      { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Find man pages" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open recent file" },
      { "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Find registers" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
      { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Find commands" },
      { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Find highlight groups" },
      -- Git
      { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
      -- Find
      -- { "<leader>f",  "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files" },
      { "<leader><leader>", Util.telescope("find_files"), desc = "Find files" },
      -- { "<leader>F",  "<cmd>Telescope live_grep<cr>",                           desc = "Find Text" },
      { "<leader>/", Util.telescope("live_grep"), desc = "Live grep" },
    },
    -- config = function() require("tvl.config.telescope") end,
  },

  {
    "benfowler/telescope-luasnip.nvim",
    module = "telescope._extensions.luasnip", -- if you wish to lazy-load
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      plugins = {
        presets = { motions = false, g = false }, -- This fix mapping for fold when press f and nothing show up
      },
      -- window = {
      --   margin = { 1, 0, 2, 0 }, -- extra window margin [top, right, bottom, left]
      --   padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      --   winblend = 5, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      -- },
      layout = {
        height = { min = 3, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 5, -- spacing between columns
        align = "center", -- align columns left, center or right
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      local keymaps = {
        { "<leader><tab>", group = "Tabs" },
        { "<leader>P", ":Lazy<cr>", desc = "Plugins" },
        { "<leader>Q", group = "Workspaces" },
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>q", group = "Sessions" },
        { "<leader>r", group = "REPL" },
        { "<leader>s", group = "Search/Replace" },
        { "<leader>u", group = "Toggle" },
        { "<leader>z", group = "Snippets" },
        { "<localleader>l", group = "LaTeX" },
        { "g", group = "Goto" },
      }
      wk.add(keymaps)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = Icons.gitsigns.add },
        change = { text = Icons.gitsigns.change },
        delete = { text = Icons.gitsigns.delete },
        topdelhfe = { text = Icons.gitsigns.topdelhfe },
        changedelete = { text = Icons.gitsigns.changedelete },
        untracked = { text = Icons.gitsigns.untracked },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      -- preview_config = {
      --   border = Util.generate_borderchars("thick", "tl-t-tr-r-bl-b-br-l"), -- [ top top top - right - bottom bottom bottom - left ]
      -- },
    },
    keys = {
      { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next hunk" },
      { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev hunk" },
      { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
      { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview hunk" },
      { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset hunk" },
      { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
      { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage hunk" },
      { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage hunk" },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
    },
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "neo-tree",
        "alpha",
        "NvimTree",
        "neo-tree",
        "dashboard",
        "TelescopePrompt",
        "TelescopeResult",
        "DressingInput",
        "neo-tree-popup",
        "",
      },
      delay = 200,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
    enabled = true,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    enabled = false,
    dependencies = { "kevinhwang91/promise-async", event = "BufReadPost" },
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  … %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
      open_fold_hl_timeout = 0,
    },
    keys = {
      { "zd", desc = "Delete fold under cursor" },
      { "zo", desc = "Open fold under cursor" },
      { "zO", desc = "Open all folds under cursor" },
      { "zC", desc = "Close all folds under cursor" },
      { "za", desc = "Toggle fold under cursor" },
      { "zA", desc = "Toggle all folds under cursor" },
      { "zv", desc = "Show cursor line" },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      { "zm", desc = "Fold more" },
      { "zr", desc = "Fold less" },
      { "zx", desc = "Update folds" },
      { "zz", desc = "Center this line" },
      { "zt", desc = "Top this line" },
      { "zb", desc = "Bottom this line" },
      { "zg", desc = "Add word to spell list" },
      { "zw", desc = "Mark word as bad/misspelling" },
      { "ze", desc = "Right this line" },
      { "zE", desc = "Delete all folds in current buffer" },
      { "zs", desc = "Left this line" },
      { "zH", desc = "Half screen to the left" },
      { "zL", desc = "Half screen to the right" },
    },
  },

  {
    "luukvbaal/statuscol.nvim",
    event = "BufReadPost",
    enabled = false,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = false,
        ft_ignore = { "neo-tree" },
        segments = {
          {
            -- line number
            text = { " ", builtin.lnumfunc },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          { text = { "%s" }, click = "v:lua.ScSa" }, -- Sign
          { text = { "%C", " " }, click = "v:lua.ScFa" }, -- Fold
        },
      })
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          if vim.bo.filetype == "neo-tree" then
            vim.opt_local.statuscolumn = ""
          end
        end,
      })
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#FFFFFF", bg = "#000000" })
    end,
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "rasulomaroff/reactive.nvim",
    enabled = false,
    config = true,
  },
  {
    "hedyhli/outline.nvim",
    enabled = false,
    keys = {
      {
        [[<leader>O]],
        "<cmd>Outline!<CR>",
        desc = "Toggle outline",
      },
      {
        [[<leader>o]],
        "<cmd>OutlineFocusOrOpen<CR>",
        desc = "Focus outline",
      },
    },
    config = function()
      local outline = require("outline")
      local function focus_or_open()
        if outline.is_open() then
          outline.focus_outline()
        else
          outline.open()
        end
      end
      vim.api.nvim_create_user_command("OutlineFocusOrOpen", function()
        focus_or_open()
      end, {})
      require("outline").setup({
        symbols = {
          icon_fetcher = function(k)
            return require("tvl.core.icons").kinds[k]
          end,
        },
      })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    keys = {
      { "<leader>sp", '<cmd>lua require("spectre").toggle()<CR>', desc = "Search and replace" },
      -- { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word" },
      -- { "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word", mode = "v" },
      -- {
      --   "<leader>sp",
      --   '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      --   desc = "Search on current file",
      -- },
      config = true,
    },
  },
}
