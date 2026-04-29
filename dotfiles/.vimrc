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
autocmd FileType javascript :IndentGuidesEnable

map <F3> :echo 'Current time is ' . strftime('%c')<CR>

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black   ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=239

if isdirectory(expand('~/.vim/bundle/Vundle.vim'))
  set nocompatible
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  "Plugin 'vim-syntastic/syntastic'
  Plugin 'nathanaelkane/vim-indent-guides'
  "Plugin 'scrooloose/nerdtree'
  call vundle#end()
  filetype plugin indent on
endif

