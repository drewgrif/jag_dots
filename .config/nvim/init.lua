vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true
vim.g.mapleader = " "					-- sets leader key

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Tab bindings 
map("n", "<leader>t", ":tabnew<CR>")			-- space+t creates new tab
map("n", "<leader>x", ":tabclose<CR>")			-- space+x closes current tab
map("n", "<leader>j", ":tabprevious<CR>")		-- space+j moves to previous tab
map("n", "<leader>k", ":tabnext<CR>")			-- space+k moves to next tab

-- buffer navigation
map("n", "<Tab>", ":bnext <CR>")				-- Tab goes to next buffer
map("n", "<S-Tab>", ":bprevious <CR>")			-- Shift+Tab goes to previous buffer
map("n", "<leader>d", ":bd! <CR>")				-- Space+d delets current buffer

map("n", "<leader>m", ":MarkdownPreview <CR>")				-- Space+d delets current buffer

-- Sets up lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "rebelot/kanagawa.nvim",
        config = function()
           vim.cmd.colorscheme("kanagawa-wave")
        end,
     },
     {
         'norcalli/nvim-colorizer.lua',
         config = function()
            require'colorizer'.setup()
        end,
     },
      {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    alpha.setup(dashboard.opts)
  end,
	},
     {
         "nvim-treesitter/nvim-treesitter",
         config = function()
             require("nvim-treesitter.configs").setup({
                 ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "rasi", "bash", "go" },

                 auto_install = true,

                 highlight = {
                     enable = true,
                },
            })
        end,
     },
     {
         'norcalli/nvim-colorizer.lua',
         config = function()
            require'colorizer'.setup()
        end,
     },
     -- start lualine
     {
         "nvim-lualine/lualine.nvim",
         dependencies = {
             "nvim-tree/nvim-web-devicons",
             "meuter/lualine-so-fancy.nvim",
         },
         opts = {
             options = {
                 theme = "iceberg_dark",
                 component_separators = { left = "│", right = "│" },
                 section_separators = { left = "", right = "" },
                 globalstatus = true,
                 refresh = {
                     statusline = 100,
                 },
             },
             sections = {
                 lualine_a = {
                     { "fancy_mode", width = 3 }
                 },
                 lualine_b = {
                     { "fancy_branch" },
                     { "fancy_diff" },
                 },
                 lualine_c = {
                     { "fancy_cwd", substitute_home = true }
                 },
                 lualine_x = {
                     { "fancy_macro" },
                     { "fancy_diagnostics" },
                     { "fancy_searchcount" },
                     { "fancy_location" },
                 },
                 lualine_y = {
                     { "fancy_filetype", ts_icon = "" }
                 },
                 lualine_z = {
                     { "fancy_lsp_servers" }
                 },
             },
            },
          },
		-- end lualine
		-- start treesitter
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

      require("telescope").load_extension("ui-select")
    end,
  },
		-- end treesitter
		-- start neo-tree
{
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
},
		-- end neo-tree
		-- start markdown preview
			 {
         "iamcco/markdown-preview.nvim",
         cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
         ft = { "markdown" },
         build = function() vim.fn["mkdp#util#install"]() end,
     },
		-- end markdown preview
		
		
     })
     
