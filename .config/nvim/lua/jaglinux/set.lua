vim.g.mapleader = " "					-- sets leader key
vim.opt.number = true					-- turn on line numbers
vim.opt.relativenumber = true 

vim.opt.tabstop = 4						-- tabs=4spaces
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false				-- expand tab 
vim.opt.smartindent = true

vim.opt.hlsearch = false				-- disable all highlighted search results
vim.opt.incsearch = true				-- enable incremental searching
vim.opt.wrap = true

vim.opt.backup = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8					-- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true

vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.cmdheight = 2
vim.g.vim_markdown_folding_disabled = 1
