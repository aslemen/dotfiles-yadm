set nocompatible

" Loading dein.vim
runtime dein/dein_load.vim

" Personal Settings
" Interfaces
set number
set showcmd
set noshowmode
language messages en_US.UTF-8

" Buffers
set hidden

" Syntax
syntax on

" Tabs
" set noexpandtab
" set tabstop=4
" set shiftwidth=4

" Search
" smartcase
set ignorecase
set smartcase
set hlsearch
set incsearch

" Cursors
" (For Xfce Terminal)
if $GUITERM == "xfce4-terminal"
	au InsertEnter * silent! execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_BLOCK/TERMINAL_CURSOR_SHAPE_IBEAM/' ~/.config/xfce4/terminal/terminalrc"
	au InsertLeave * silent! execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc" 
	au VimLeave * silent! execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
endif

" No Arrow Keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Home> <Nop>
noremap <End> <Nop>
noremap <Space> <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" No Mouse
set mouse=

" No timeout
set notimeout

" Spell checker
set spell
set spelllang=en_us
set spelllang+=cjk
