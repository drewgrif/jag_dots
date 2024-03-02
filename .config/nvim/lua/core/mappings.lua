-- map leader
vim.g.mapleader = " "
local keymap = vim.keymap
local opts = { silent = true, noremap = true }

-- General
--  e keymap.set("n", "<leader>q", ":qa! <cr>", opts)
keymap.set("n", "<leader>a", "gg<S-v>G", opts)
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Window

-- Tab bindings 
keymap.set("n", "<leader>t", ":tabnew<cr>", opts)		-- space+t creates new tab
keymap.set("n", "<leader>x", ":tabclose<cr>", opts)		-- space+x closes current tab
keymap.set("n", "<leader>j", ":tabprevious<cr>", opts)	-- space+j moves to previous tab
keymap.set("n", "<leader>k", ":tabnext<cr>", opts)		-- space+k moves to next tab

-- buffer navigation
keymap.set("n", "<Tab>", ":bnext <cr>", opts)			-- Tab goes to next buffer
keymap.set("n", "<S-Tab>", ":bprevious <cr>", opts)	-- Shift+Tab goes to previous buffer
keymap.set("n", "<leader>q", ":bd <cr>", opts)		-- Space+d deletes current buffer

-- easy split generation
keymap.set("n", "<leader>v", ":vsplit", opts)			-- space+v creates a veritcal split
keymap.set("n", "<leader>s", ":split", opts)			-- space+s creates a horizontal split

-- adjust split sizes easier
keymap.set("n", "<C-Left>", ":vertical resize +3<cr>")		-- Control+Left resizes vertical split +
keymap.set("n", "<C-Right>", ":vertical resize -3<cr>")	-- Control+Right resizes vertical split -

-- Oil.nvim
keymap.set("n", "<leader>e", function()
	require("oil").toggle_float()
end, opts)

-- Telescope
keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <cr>", opts)
keymap.set("n", "<leader>gc", "<cmd> Telescope git_branches <cr>", opts)
keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <cr>", opts)
keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags  <cr>", opts)

keymap.set("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = "~/.config/nvim/",
	})
end, opts)

-- Fugitive
keymap.set("n", "<leader>g", ":vertical Git <cr>", opts)
