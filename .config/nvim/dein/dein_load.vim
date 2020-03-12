"dein Scripts-----------------------------

" Directories:
let s:dein_dir = expand('$HOME/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Automatically install dein.vim if not
if !isdirectory(s:dein_repo_dir)
	  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" Set runtime path
execute 'set runtimepath^=' . s:dein_repo_dir

" Required:
call dein#begin(s:dein_dir)

" TOML plugin manager
let s:dein_toml_path = expand('<sfile>:p:h') . '/plugins.toml'
let s:dein_toml_lazy_path = expand('<sfile>:p:h') . '/plugins_lazy.toml'

call dein#load_toml(s:dein_toml_path, {'lazy' : 0})
call dein#load_toml(s:dein_toml_lazy_path, {'lazy' : 1})

" Required:
call dein#end()
call dein#save_state()
autocmd VimEnter * call dein#call_hook('post_source')

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Update installed plugins
" if dein#check_update()
	" call dein#update()
" endif
"End dein Scripts-------------------------
