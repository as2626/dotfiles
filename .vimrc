set nocompatible
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
filetype indent plugin on
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
let mapleader=","
nnoremap <leader><space> :nohlsearch<CR>
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap j gj
nnoremap k gk
" highlight last inserted text
nnoremap gV `[v`]
nnoremap <leader>u :GundoToggle<CR>
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

