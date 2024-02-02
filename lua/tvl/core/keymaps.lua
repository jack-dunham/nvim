local Util = require("tvl.util")
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
map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
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
map("n", "<leader>;", ":noh<CR>", { desc = "No highlight" })

-------------------- Go to buffer quickly ----------------------
map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Buffer 1" })
map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Buffer 2" })
map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Buffer 3" })
map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Buffer 4" })
map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Buffer 5" })
map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Buffer 6" })
map("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Buffer 7" })
map("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Buffer 8" })
map("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Buffer 9" })

-------------------- Split window ------------------------------
-- map("n", "<leader>\\", ":vsplit<CR>", opts)
map("n", "<leader>_", ":split<CR>", { desc = "Horizontal split" })
map("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical split" })

-------------------- Switching between pairs --------------------------------
map("n", "<tab>", "%", opts)
map("v", "<tab>", "%", opts)

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

-- stylua: ignore start

-------------------- Toggles -----------------------------
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle word wrap" })
map("n", "<leader>ul", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle line numbers" })
map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle conceal" })

-------------------- Tabs -----------------------------
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-------------------- Terminal -----------------------------
map("t", "<esc>", "<C-\\><C-n>")

-------------------- Disable arrow keys -----------------------------
map({"","i"}, "<Up>", "<Nop>")
map({"","i"}, "<Down>", "<Nop>")
map({"","i"}, "<Left>", "<Nop>")
map({"","i"}, "<Right>", "<Nop>")
