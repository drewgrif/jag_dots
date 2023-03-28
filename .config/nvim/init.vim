:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set mouse=a
:set termguicolors


call plug#begin('~/.vim/plugged')

Plug 'ap/vim-css-color'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'kovetskiy/sxhkd-vim'
Plug 'https://github.com/preservim/nerdtree'
Plug 'nordtheme/vim'
Plug 'ryanoasis/vim-devicons'

set encoding=UTF-8

call plug#end()
:colorscheme nord

map <C-f> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let g:NERDTreeWinSize=38

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

noremap <C-t> :tabn<cr>
noremap <C-n> :tabnew<cr>
noremap <C-x> :tabc<cr>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
