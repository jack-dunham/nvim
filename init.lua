-- bootstrap lazy.nvim, LazyVim and your plugins
require("tvl.core.lazy")

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

local function filter_diagnostics(diagnostic)
  -- Filter out all diagnostics from sumneko_lua
  if diagnostic.source:find("julia", 4, true) then
    return false
  end
  return true
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(function(_, result, ctx, config)
  vim.tbl_filter(filter_diagnostics, result.diagnostics)
  vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end, {})
