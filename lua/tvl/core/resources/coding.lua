return {
  -- {
  --   "abecodes/tabout.nvim",
  --   event = { "InsertEnter" },
  --   enabled = false,
  --   dependencies = { "nvim-treesitter", "nvim-cmp" },
  --   opts = {
  --     tabkey = "<Tab>",
  --     backwards_tabkey = "<S-Tab>",
  --   },
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    enabled = true,
    opts = {
      tabkey = "",
      act_as_tab = true,
    },
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "neotab.nvim" },
    config = function()
      local opts = {
        history = true,
        delete_check_events = "TextChanged",
        enable_autosnippets = true,
      }
      require("luasnip").setup(opts)

      local ls = require("luasnip")
      local s = ls.snippet
      local sn = ls.snippet_node
      local isn = ls.indent_snippet_node
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      local r = ls.restore_node
      local events = require("luasnip.util.events")
      local ai = require("luasnip.nodes.absolute_indexer")
      local fmt = require("luasnip.extras.fmt").fmt
      local m = require("luasnip.extras").m
      local lambda = require("luasnip.extras").l
      local postfix = require("luasnip.extras.postfix").postfix

      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
      require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/LuaSnip/" } })
    end,
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },

  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = { jsonFormatter = "jq" },
    keys = {
      {
        "<leader>za",
        function()
          require("scissors").addNewSnippet()
        end,
        desc = "Add new snippet",
        mode = { "n", "x" },
      },
      {
        "<leader>ze",
        function()
          require("scissors").editSnippet()
        end,
        desc = "Edit snippet",
      },
    },
  },
  {
    "smjonas/snippet-converter.nvim",
    -- SnippetConverter uses semantic versioning. Example: use version = "1.*" to avoid breaking changes on version 1.
    -- Uncomment the next line to follow stable releases only.
    -- tag = "*",
    config = function()
      local template = {
        -- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
        sources = {
          ultisnips = {
            -- Add snippets from (plugin) folders or individual files on your runtimepath...
            "~/Downloads/tex.snippets",
          },
        },
        output = {
          -- Specify the output formats and paths
          vscode_luasnip = {
            vim.fn.stdpath("config") .. "/snippets",
          },
          snipmate = {
            vim.fn.stdpath("config") .. "/snipmate",
          },
        },
      }

      require("snippet_converter").setup({
        templates = { template },
        -- To change the default settings (see configuration section in the documentation)
        -- settings = {},
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "kawre/neotab.nvim",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup.cmdline("/", {
        -- mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        -- mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
          keyword_length = 1,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              require("neotab").tabout()
            end
          end, { "i", "c" }),
          ["<Esc>"] = cmp.mapping(function(fallback)
            -- require("luasnip").unlink_current()
            fallback()
          end),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          -- { name = "luasnip" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          -- fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local icons = require("tvl.core.icons").kinds
            item.kind = string.format("%s %s", icons[item.kind], item.kind)
            item.menu = ({
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return item
          end,
        },
        experimental = { ghost_text = false },
      }
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    lazy = true,
    config = function()
      require("lspsaga").setup({})
    end,
  },
  {
    "echasnovski/mini.ai",
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      ---@type table<string, string|table>
      local i = {
        [" "] = "Whitespace",
        ['"'] = 'Balanced "',
        ["'"] = "Balanced '",
        ["`"] = "Balanced `",
        ["("] = "Balanced (",
        [")"] = "Balanced ) including white-space",
        [">"] = "Balanced > including white-space",
        ["cltc"] = "Balanced <",
        ["]"] = "Balanced ] including white-space",
        ["["] = "Balanced [",
        ["}"] = "Balanced } including white-space",
        ["{"] = "Balanced {",
        ["?"] = "User Prompt",
        _ = "Underscore",
        a = "Argument",
        b = "Balanced ), ], }",
        c = "Class",
        f = "Function",
        o = "Block, conditional, loop",
        q = "Quote `, \", '",
        t = "Tag",
      }
      local a = vim.deepcopy(i)
      for k, v in pairs(a) do
        a[k] = v:gsub(" including.*", "")
      end

      local ic = vim.deepcopy(i)
      local ac = vim.deepcopy(a)
      for key, name in pairs({ n = "Next", l = "Last" }) do
        i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
        a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
      end
      require("which-key").register({
        mode = { "o", "x" },
        i = i,
        a = a,
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      keymaps = {
        insert = "<C-g>z",
        insert_line = "<C-g>Z",
        normal = "gz",
        normal_cur = "gZ",
        normal_line = "gzz",
        normal_cur_line = "gZZ",
        visual = "gz",
        visual_line = "gZ",
        delete = "gzd",
        replace = "gzr",
      },
    },
    keys = {
      { "gz", desc = "Surround a motion" },
      { "gzz", desc = "Surround line" },
      { "gzd", desc = "Delete surrounding pair" },
      { "gzr", desc = "Replace surrounding pair" },
    },
  },
}
