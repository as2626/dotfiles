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

" Journaling :)
augroup journaling
    autocmd!
    autocmd BufNewFile new.jrnl execute 'file' fnameescape(strftime("%Y-%b-%d.jrnl"))
    autocmd BufNewFile *.jrnl 0r $HOME/Documents/text/journal/templates/fiveminjournal.txt
    autocmd BufNewFile,BufReadPre *.jrnl set spell spelllang=en_us
augroup END
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## d17b63569cd6ce00473c6a453fb31e1b ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "$HOME/.opam/4.08.1/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
