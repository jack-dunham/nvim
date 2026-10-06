return {
  {
    "neovim/nvim-lspconfig",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    keys = {
      { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code action" },
      { "<leader>cd", "<cmd>Telescope lsp_document_diagnostics<cr>", desc = "Document diagnostics" },
      { "<leader>cw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>ci", "<cmd>LspInfo<cr>", desc = "Info" },
      { "<leader>cI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info" },
      { "<leader>cj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },
      { "<leader>ck", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Prev diagnostic" },
      { "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens action" },
      { "<leader>cq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix" },
      { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      { "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>cS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
      {
        "<leader>W",
        function()
          vim.lsp.buf.format({
            filter = function(client)
              -- do not use default `lua_ls` to format
              local exclude_servers = { "lua_ls" }
              return not vim.tbl_contains(exclude_servers, client.name)
            end,
          })
          vim.cmd([[w!]])
        end,
        desc = "Format and save",
      },
    },
    config = function()
      -- special attach lsp
      require("tvl.util").on_attach(function(client, buffer)
        require("tvl.config.lsp.keymaps").attach(client, buffer)
        require("tvl.config.lsp.inlayhints").attach(client, buffer)
        require("tvl.config.lsp.gitsigns").attach(client, buffer)
      end)

      -- diagnostics
      local severity = vim.diagnostic.severity

      local signs = {
        text = {},
        linehl = {},
        numhl = {
          [severity.ERROR] = "DiagnosticSignError",
          [severity.WARN] = "DiagnosticSignWarn",
          [severity.HINT] = "DiagnosticSignHint",
          [severity.INFO] = "DiagnosticSignInfo",
        },
      }

      for name, icon in pairs(require("tvl.core.icons").diagnostics) do
        signs.text[severity[name]] = icon
        signs.linehl[severity[name]] = ""
      end

      vim.diagnostic.config({ signs = signs })
      vim.diagnostic.config(require("tvl.config.lsp.diagnostics")["on"])

      local servers = require("tvl.config.lsp.servers")
      local ext_capabilites = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("tvl.util").capabilities(ext_capabilites)

      -- local function setup(server)
      --   if servers[server] and servers[server].disabled then
      --     return
      --   end
      --   local server_opts = vim.tbl_deep_extend("force", {
      --     capabilities = vim.deepcopy(capabilities),
      --   }, servers[server] or {})
      --   require("lspconfig")[server].setup(server_opts)
      -- end

      vim.lsp.enable({ "julials", "lua_ls", "bashls", "texlab", "pyright" })
      -- local available = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      --
      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          if not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  -- formatters
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "mason.nvim" },
  --   dev = false,
  --   config = function()
  --     local null_ls = require("null-ls")
  --     local formatting = null_ls.builtins.formatting
  --     null_ls.setup({
  --       debug = false,
  --       -- You can then register sources by passing a sources list into your setup function:
  --       -- using `with()`, which modifies a subset of the source's default options
  --       sources = {
  --         formatting.stylua,
  --         require("format.runic"),
  --       },
  --     })
  --   end,
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        itfmt = {
          command = "itfmt",
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        julia = { "itfmt" },
      },
    },
  },
}
