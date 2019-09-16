" Plugins specific settings PRE-instalation

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsUsePythonVersion = 3
" YouCompleteMe settings
let g:ycm_server_log_lever = 'debug'
let g:ycm_server_keep_logfiles = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" CTRL-P settings
let g:ctrlp_by_filename=1
let g:ctrlp_working_path_mode = 'ra' "disable root looking feature
"Specify an external tool to use for listing files instead of using Vim's globpath()
if has("win32") || has("win16")
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|jazz5|jazzSched|generated_hal)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
  let g:cmake_project_generator='MinGW Makefiles'
else
  let g:ctrlp_user_command = 'find %s -type f -regex ".*\.\(java\|cpp\|h\|hh\|hpp\|cc\|xml\|ttcn3\|' .
        \ 'rb\|js\|erb\|yml\|bunion\)" -or -iname "Gemfile" '
 " let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
  let g:ctrlp_match_window = 'bottom,results:15'
endif
let g:cmake_build_type = 'Debug'


let g:clang_format#command = "clang-format"
let g:clang_format#detect_style_file = 1

let g:SuperTabDefaultCompletionType = '<C-n>'

let g:plantuml_executable_script='plantuml'

"*****************************************************************
set nocompatible              " be iMproved, required
filetype off                  " required

if has("win32") || has("win16")
  let github_clone_type='https://github.com/'
else
  let github_clone_type='git@github.com:'
endif
" set the runtime path to include Vundle and initialize
" adjust configuration for such hostile environment as Windows {{{
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin github_clone_type . 'gmarik/Vundle.vim.git'
" SuperTab - move between completion suggestion with TAB
Plugin github_clone_type . 'ervandew/supertab.git'
Plugin github_clone_type . 'bling/vim-airline.git'
Plugin github_clone_type . 'scrooloose/nerdtree.git'
Plugin github_clone_type . 'vim-scripts/a.vim'
Plugin github_clone_type . 'ctrlpvim/ctrlp.vim'

Plugin github_clone_type . 'majutsushi/tagbar.git'
Plugin github_clone_type . 'jlanzarotta/bufexplorer.git'
" make GVim only colorschemes work properly in terminal vim
Plugin github_clone_type . 'godlygeek/csapprox.git'

" add ClangFormat to trigger Clang formating your code
Plugin github_clone_type . 'rhysd/vim-clang-format'

"get it as a package
Plugin github_clone_type . 'MarcWeber/vim-addon-mw-utils'
Plugin github_clone_type . 'tomtom/tlib_vim'
Plugin github_clone_type . 'garbas/vim-snipmate'
Plugin github_clone_type . 'honza/vim-snippets'
Plugin github_clone_type . 'SirVer/ultisnips.git'
"test

Plugin github_clone_type . 'octol/vim-cpp-enhanced-highlight.git'
Plugin github_clone_type . 'vim-scripts/WhiteWash.git'
Plugin github_clone_type . 'aklt/plantuml-syntax.git'
Plugin github_clone_type . 'benmills/vimux.git'
Plugin github_clone_type .  'brookhong/cscope.vim.git'
" CSCOPE settings from vim
Plugin github_clone_type . 'chazy/cscope_maps.git'
Plugin github_clone_type . 'kana/vim-operator-user'
Plugin github_clone_type . 'Yggdroot/indentLine'
Plugin github_clone_type . 'peterhoeg/vim-qml'
Plugin github_clone_type . 'vim-scripts/Improved-AnsiEsc'
Plugin github_clone_type . 'tikhomirov/vim-glsl'

if (!has("win32") && !has("win16"))
  Plugin github_clone_type . 'christoomey/vim-tmux-navigator.git'
  Plugin github_clone_type . 'Valloric/YouCompleteMe.git'
endif

call vundle#end()            " required
filetype plugin indent on    " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"*****************************************************************
" Plugins specific settings POST-instalation
let g:airline_section_x=airline#section#create(['%{SyntaxItem()}', ' | ','filetype'])
"let g:airline#extensions#tagbar#enabled = 1
set laststatus=2

let g:alternateExtensions_hh = "cc"
let g:alternateExtensions_cc = "hh"
let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc,reg:|src|inc/ivi||,reg:|src|inc/nit||'
