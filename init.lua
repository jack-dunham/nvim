-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").julials.setup({
  on_new_config = function(new_config, _)
    local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
    if require("lspconfig").util.path.is_file(julia) then
      new_config.cmd[1] = julia
    end
  end,
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern("Project.toml")(fname)
      or require("lspconfig.util").find_git_ancestor(fname)
  end,
  filetypes = { "julia" },
  single_file_support = false,
  autostart = true,
})
