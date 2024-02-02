local Util = require("tvl.util")

Util.map("n", "<leader>o", function()
  require("edgy").goto_main()
end, { desc = "Unfocus outline", buffer = true })
