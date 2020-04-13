set nocompatible  " vim, not vi
" https://dougblack.io/words/a-good-vimrc.html
colorscheme badwolf
syntax enable
set encoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set showcmd
set cursorline
set ruler
filetype indent plugin on
set wildmenu
set lazyredraw   " don't redraw during macros

let mapleader=","

" Searching Criteria
set ignorecase                  " ignore case in search patterns
set smartcase                   " override ignorecase if search pattern has capital letters
set incsearch                   " search incrementally (modern)
set hlsearch                    " highlight searches
set showmatch                   " highlight matching parentheses/brackets
nnoremap <leader>/ :nohlsearch<CR>

" Folds
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" Update term title but restore old title after leaving Vim
set title
set titleold=
" treat a wrap-around line as two lines
nnoremap j gj
nnoremap k gk
" highlight last inserted text
nnoremap gV `[v`]
nnoremap <leader>u :GundoToggle<CR>
" black hole register delete
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" system clipboard copy and paste
nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>p "+p
xnoremap <leader>p "+p
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" Delete Trailing Whitespaces On Saving:
func! DeleteTrailingWhiteSpace()
	normal mZ
	%s/\s\+$//e
	normal `Z
endfunc
au BufWrite * if &ft != 'mkd' && &ft != 'tex' | call DeleteTrailingWhiteSpace() | endif

