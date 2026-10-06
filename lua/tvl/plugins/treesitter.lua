return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup(opts)

      local installed = {
        "bash",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "yaml",
        "cpp",
        "julia",
        "latex",
      }
      ts.install(installed)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = installed,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
    -- opts = {
    --   highlight = { enable = true },
    --   indent = { enable = true, disable = { "yaml" } },
    --   rainbow = {
    --     enable = false,
    --     query = "rainbow-parens",
    --   },
    --   textobjects = {
    --     swap = {
    --       enable = true,
    --       swap_next = {
    --         ["<leader>]"] = "@parameter.inner",
    --       },
    --       swap_previous = {
    --         ["<leader>["] = "@parameter.inner",
    --       },
    --     },
    --   },
    -- },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    -- tag = "v0.9.1",
    event = "BufReadPost",
    submodules = false,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- PERF: no need to load the plugin, if we only need its queries for mini.ai
      local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)

      local enabled = false
      if opts.textobjects then
        for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
          if opts.textobjects[mod] and opts.textobjects[mod].enable then
            enabled = true
            break
          end
        end
      end
      if not enabled then
        require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
      end
    end,
  },
}
