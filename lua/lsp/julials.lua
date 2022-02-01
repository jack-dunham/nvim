local util = require("lspconfig.util")

require("lspconfig").julials.setup({})

require("lspconfig").julials.setup({
	on_new_config = function(new_config, _)
		local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
		if require("lspconfig").util.path.is_file(julia) then
			new_config.cmd[1] = julia
		end
	end,
	root_dir = function(fname)
		return util.root_pattern("Project.toml")(fname) or util.find_git_ancestor(fname)
	end,
	-- single_file_support = false,
})

-- local util = require "lspconfig/util"

-- local cmd = {
--     "julia",
--     "--startup-file=no",
--     "--history-file=no",
--     "/Users/JackDunham/.config/nvim/lsp-julia/run.jl"
-- }
-- require'lspconfig'.julials.setup{
--     	cmd = cmd,
--     	on_new_config = function(new_config, root_dir)
--         	new_config.cmd = cmd
--           	new_config.cmd_cwd = root_dir
--     	end,
--     	filetypes = {"julia"}
-- }
