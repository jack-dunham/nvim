local Util = require("tvl.util")
local Snacks = require("snacks")
--
local map = Util.map

local opts = { noremap = true, silent = true }

--Remap space as leader key
-- map("", "<Space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-------------------- Better window navigation ------------------
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-l>", "<c-w>l", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)
map("n", "<c-q>", "<c-w>q", opts)

-------------------- Navigate buffers --------------------------
-- map("n", "<S-l>", ":bnext<CR>", opts)
-- map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<A-S-l>", ":BufferLineMoveNext<CR>", opts)
map("n", "<A-S-h>", ":BufferLineMovePrev<CR>", opts)

-------------------- Previous -------------------
map("n", "<bs>", ":wincmd p<cr>", { desc = "Previous window" })
map("n", "<S-bs>", "<c-6>", { desc = "Previous buffer" })

-------------------- Press jk fast to enter --------------------
-- map("i", "jk", "<ESC>", opts)
-- map("i", "Jk", "<ESC>", opts)
-- map("i", "jK", "<ESC>", opts)
-- map("i", "JK", "<ESC>", opts)

-------------------- Stay in indent mode ------------------------
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "p", '"_dP', opts)

-------------------- Resize windows ----------------------------
map("n", "<A-C-j>", ":resize +1<CR>", opts)
map("n", "<A-C-k>", ":resize -1<CR>", opts)
map("n", "<A-C-h>", ":vertical resize +1<CR>", opts)
map("n", "<A-C-l>", ":vertical resize -1<CR>", opts)

map("n", "<C-w>>", ":vertical resize +2<CR>", opts)
map("n", "<C-w><", ":vertical resize -2<CR>", opts)

-------------------- Move text up/ down ------------------------
-- Visual --
map("v", "<A-J>", ":m .+1<CR>==", opts)
map("v", "<A-K>", ":m .-2<CR>==", opts)
-- Block --
-- map("x", "J", ":move '>+1<CR>gv-gv", opts)
-- map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-J>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-K>", ":move '<-2<CR>gv-gv", opts)
-- Normal --
map("n", "<A-J>", ":m .+1<CR>==", opts)
map("n", "<A-K>", ":m .-2<CR>==", opts)
-- Insert --
map("i", "<A-J>", "<ESC>:m .+1<CR>==gi", opts)
map("i", "<A-K>", "<ESC>:m .-2<CR>==gi", opts)

-------------------- No highlight ------------------------------
map("n", "<leader>h", ":noh<CR>", { desc = "No Highlight" })

-- -------------------- Go to buffer quickly ----------------------
-- map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Buffer 1" })
-- map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Buffer 2" })
-- map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Buffer 3" })
-- map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Buffer 4" })
-- map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Buffer 5" })
-- map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Buffer 6" })
-- map("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Buffer 7" })
-- map("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Buffer 8" })
-- map("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Buffer 9" })

-------------------- Split window ------------------------------
-- map("n", "<leader>\\", ":vsplit<CR>", opts)
map("n", "<leader>_", ":split<CR>", { desc = "Horizontal split" })
map("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical split" })

-------------------- Switching between pairs --------------------------------
map("n", "<Tab>", "%", opts)
map("v", "<Tab>", "%", opts)
map("o", "<Tab>", "%", opts)

-------------------- Inspect --------------------------------
map("n", "<F2>", "<cmd>Inspect<CR>", opts)

-------------------- Fuzzy Search --------------------------------
vim.keymap.set("n", "<C-f>", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes"))
end, { desc = "[/] Fuzzily search in current buffer]" })

-------------------- Saner n and N ---------------------------
-- map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- map("n", "n", "nzz", { desc = "Next search result" })
-- map("n", "N", "Nzz", { desc = "Prev search result" })
-- map("o", "n", "nzz", { desc = "Next search result" })
-- map("o", "N", "Nzz", { desc = "Prev search result" })
-- map("x", "n", "nzz", { desc = "Next search result" })
-- map("x", "N", "Nzz", { desc = "Prev search result" })

-- stylua: ignore start
map( {"n", "o", "x"}, "n", '<Cmd>lua vim.cmd("normal! n"); ' .. 'MiniAnimate.execute_after("scroll", "normal! zz")<CR>', { desc = "Next search result" })
map( {"n", "o", "x"}, "N", '<Cmd>lua vim.cmd("normal! N"); ' .. 'MiniAnimate.execute_after("scroll", "normal! zz")<CR>', { desc = "Prev search result" })

-- stylua: ignore end


-------------------- Toggles -----------------------------
-- map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle spelling" })
-- map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle word wrap" })
-- map("n", "<leader>ul", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle line numbers" })
-- map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle conceal" })

-- stylua: ignore start
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.profiler():map("<leader>dpp")
Snacks.toggle.profiler_highlights():map("<leader>dph")
-- stylua: ignore end

-------------------- Tabs -----------------------------
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-------------------- Terminal -----------------------------
map("t", "<esc><esc>", "<C-\\><C-n>")

-------------------- Disable arrow keys -----------------------------
map({ "", "i" }, "<Up>", "<Nop>")
map({ "", "i" }, "<Down>", "<Nop>")
map({ "", "i" }, "<Left>", "<Nop>")
map({ "", "i" }, "<Right>", "<Nop>")

--------------------  LSP -----------------------------
-- stylua: ignore start
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code action" })
map("n", "<leader>ci", "<cmd>checkhealth lsp<cr>", { desc = "Info" })
map("n", "<leader>cj", "<cmd>lua vim.diagnostic.jump({count = 1})<CR>", { desc = "Next diagnostic" })
map("n", "<leader>ck", "<cmd>lua vim.diagnostic.jump({count = -1})<cr>", { desc = "Prev diagnostic" })
map("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<cr>", { desc = "CodeLens action" })
map("n", "<leader>cq", "<cmd>lua vim.diagnostic.setloclist()<cr>", { desc = "Quickfix" })
map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
      vim.diagnostic.config({ signs = signs })
map("n", "<leader>cd", function() vim.diagnostic.open_float() end, { desc = "Show diagnostic" })
map("n", "<leader>W", function() require("conform").format({ async = true, lsp_format = "fallback" }) vim.cmd([[w!]]) end, { desc = "Format and save" })
-- stylua: ignore end

vim.g.copilot_no_tab_map = true

-- vim.g.nvim_surround_no_normal_mappings = true
-- map("i", "<C-g>z", "<Plug>(nvim-surround-insert)", { desc = "Surround" })
-- map("i", "<C-g>Z", "<Plug>(nvim-surround-insert-line)", { desc = "Surround (new lines)" })
-- map("n", "yz", "<Plug>(nvim-surround-normal)", { desc = "Surround" })
-- map("n", "yzz", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround line" })
-- map("n", "yZ", "<Plug>(nvim-surround-normal-line)", { desc = "Surround (new lines)" })
-- map("n", "yZZ", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Surround line (new lines)" })
-- map("x", "Z", "<Plug>(nvim-surround-visual)", { desc = "Surround" })
-- map("x", "gZ", "<Plug>(nvim-surround-visual-line)", { desc = "Surround (new lines)" })
-- map("n", "dz", "<Plug>(nvim-surround-delete)", { desc = "Delete surround" })
-- map("n", "cz", "<Plug>(nvim-surround-change)", { desc = "Change surround" })
-- map("n", "cZ", "<Plug>(nvim-surround-change-line)", { desc = "Change surround (new lines)" })
