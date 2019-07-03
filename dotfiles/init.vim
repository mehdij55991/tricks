" https://github.com/Shougo/dein.vim
" https://github.com/Shougo/deoplete.nvim
" https://github.com/deoplete-plugins/deoplete-jedi
" https://github.com/deoplete-plugins/deoplete-go
" https://github.com/mdempsky/gocode

" Installation:
" - curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
" - sh ./installer.sh ~/.nvim/dein
" - copy this file to ~/.config/nvim/init.vim
" - start nvim

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/linux/.nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/linux/.nvim/dein/')
  call dein#begin('/home/linux/.nvim/dein/')

  " Let dein manage dein
  " Required:
  call dein#add('/home/linux/.nvim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/deoplete.nvim', {'on_i': 1})
  call dein#add('deoplete-plugins/deoplete-jedi', {'on_ft': 'python'})
  call dein#add('deoplete-plugins/deoplete-go', {'on_ft': 'go'})
  call dein#add('cyb70289/Zenburn')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

let g:deoplete#enable_at_startup = 1

let g:zenburn_disable_Label_underline = 1
colorscheme zenburn

set ruler
set whichwrap=b,s,<,>,[,]
set backspace=indent,eol,start
set shiftwidth=4 tabstop=4 expandtab

set wrap hlsearch noincsearch ignorecase smartcase
map <F4> :nohlsearch<CR>

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap qq <C-O>:pc<CR>
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

set laststatus=1
set completeopt-=preview

autocmd BufNewFile,BufRead * setlocal formatoptions-=ro
