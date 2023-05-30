local Terminal = require("toggleterm.terminal").Terminal

local M = {}

M.repls = {
  julia = {
    term = Terminal:new({
      cmd = [[julia]],
      direction = "horizontal",
      close_on_exit = false,
      hidden = true,
      count = 1,
    }),
    test = Terminal:new({
      cmd = [[julia -q -e "using Pkg; Pkg.test()"]],
      direction = "horizontal",
      close_on_exit = false,
      hidden = true,
      count = 2,
    }),
    plot = Terminal:new({
      cmd = [[julia --sysimage=]] .. os.getenv("HOME") .. [[/.julia/environments/Plots/sys_plots]],
      direction = "horizontal",
      close_on_exit = true,
      hidden = true,
      count = 3,
    }),
    include_cmd = function(fp)
      return [[Revise.includet("]] .. fp .. [[")]]
    end,
  },
}

function M._repl_toggle()
  local ft = M.repls[vim.bo.filetype]
  ft.term:toggle()
end

function M._repl_test()
  local ft = M.repls[vim.bo.filetype]
  ft.test:toggle()
end

function M._repl_plot()
  local ft = M.repls[vim.bo.filetype]
  ft.plot:toggle()
end

function M._repl_include_file()
  local ft = M.repls[vim.bo.filetype]
  local fp = vim.fn.expand("%:p")
  ft.term:send(ft.include_cmd(fp), false)
end

return M
