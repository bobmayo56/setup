set ai
set ic
set tabstop=2
set shiftwidth=2
set expandtab
syntax on
highlight Search cterm=NONE ctermfg=black ctermbg=yellow
colorscheme default

"per-filetype configuration
autocmd FileType make setlocal noexpandtab

map <F3> :echo 'Current time is ' . strftime('%c')<CR>

let g:indentLine_color_term = 238
let g:indentLine_enabled = 1

if isdirectory(expand('~/.vim/bundle/Vundle.vim'))
  set nocompatible
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'Yggdroot/indentLine'
  call vundle#end()
  filetype plugin indent on
endif

