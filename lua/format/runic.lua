local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin({
  name = "runic",
  meta = {
    url = "https://github.com/fredrikekre/Runic.jl",
    description = "A code formatter for Julia with rules set in stone.",
  },
  method = FORMATTING,
  filetypes = { "jl", "julia" },
  factory = h.formatter_factory,
  generator_opts = {
    command = "runic",
    args = {
      "--inplace",
      "$FILENAME",
    },
    to_stdin = true,
  },
})
-- return {
--     name = "runic",
--     meta = {
--         url = "https://github.com/fredrikekre/Runic.jl",
--         description = "A code formatter for Julia with rules set in stone.",
--     },
--     method = { FORMATTING, RANGE_FORMATTING },
--     filetypes = { "jl", "julia" },
--     factory = h.formatter_factory,
--     generator_opts = {
--         command = "julia",
--         args = h.range_formatting_args_factory({
--             "--inplace",
--             "-",
--             "$FILENAME",
--         }, "--lines", nil, { delimiter = ":", row_offset = -1, col_offset = -1 }),
--         to_stdin = true,
--     },
-- }
