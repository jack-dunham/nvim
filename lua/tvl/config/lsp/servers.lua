local servers = {
  clangd = {},
  cmake = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
        misc = {
          parameters = {
            "--log-level=trace",
          },
        },
        format = {
          enable = false,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
      },
    },
  },
  bashls = {},
  -- texlab = {
  --   settings = {
  --     texlab = {
  --       auxDirectory = "build",
  --       bibtexFormatter = "texlab",
  --       build = {
  --         args = { "--synctex=1", "--shell-escape", "--output-directory=build", "%f" },
  --         executable = "lualatex",
  --         forwardSearchAfter = false,
  --         onSave = false,
  --       },
  --       chktex = {
  --         onEdit = false,
  --         onOpenAndSave = false,
  --       },
  --       diagnosticsDelay = 300,
  --       formatterLineLength = 80,
  --       forwardSearch = {
  --         args = {},
  --       },
  --       latexFormatter = "latexindent",
  --       latexindent = {
  --         modifyLineBreaks = false,
  --       },
  --     },
  --   },
  -- },
  julials = {
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern("Project.toml")(fname)
        or require("lspconfig.util").find_git_ancestor(fname)
    end,
    filetypes = { "julia" },
    single_file_support = false,
    autostart = true,
  },
}

return servers
