set shortmess=atToOI 
set showbreak=\| 
set showcmd 
set showmatch 
set showmode 
set smartindent 
set splitbelow 
set swapfile 
set t_vb= 
set tabstop=2 shiftwidth=2 expandtab
set textwidth=105
set updatecount=200 
set vb t_vb= 
set viminfo='20,\"50 
set whichwrap+=<,>,[,] 
set wildchar=<TAB> 
set wildmenu 
set wildmode=longest,list,full
set wrapmargin=1 
set formatoptions=roq21 
set novb 
set noeb 
set nocp
set hlsearch incsearch
set number
set foldmethod=syntax
if has("win32") || has("win16")
  set guifont=DejaVu_Sans_Mono:h11
else
  set guifont=DejaVu\ Sans\ Mono\ 11
endif
set t_Co=256
" decide whether concealable items in the current line are displayed unconcealed to be able to edit the line.
set concealcursor=nc
set conceallevel=2
set clipboard+=unnamedplus
let g:ttcn_fold=1

"*****************************************************************
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

syntax on
augroup Longlines
	"remove all autocommand for the current group
	autocmd! 
	"autocmd BufEnter,BufWinEnter * match NONE 
	"autocmd BufEnter,BufWinEnter *.cpp,*.h match ErrorMsg '\%>104v.\+'
	"autocmd BufEnter,BufWinEnter *.cpp,*.h set cc=104
  autocmd FileType cpp,c,cxx,h,hpp,python,sh  setlocal cc=120
	"autocmd BufEnter,BufWinEnter *.ttcn3 match ErrorMsg '\%>114v.\+'
augroup END
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
autocmd BufWritePost *.pu,*.plant silent !plantuml %

" Plugin loading and managing
source ~/.vim/bundle_configuration.vim

source ~/.vim/custom_functions.vim
source ~/.vim/detecting_tags.vim

"*****************************************************************
"Keyboard shortcuts
"*****************************************************************
map <F2> :BufExplorer<cr>
map <F3> :silend ~plantuml %<cr>
map <F4> :cprev<cr>
map <F5> :cnext<cr>
nnoremap <F6> :w<CR> :make<CR>
inoremap <F6> <Esc>:w<CR>:make<CR>
vnoremap <F6> :<C-U>:w<CR>:make<CR
map <F7> :TagbarToggle<CR>

if has("win32") || has("win16")
  "on Windows findstr is used instead of grep
  map <F8> :execute "grep /s /n \"\\<" . expand("<cword>") .  "\\>\" *.cpp *.h *.cmake " <Bar> cwindow<CR>
else
  map <F8> :execute "grep -srnw --binary-files=without-match -e " . expand("<cword>") .  " --include=\*.{cpp,h,cmake} * " <Bar> cwindow<CR>
endif
"map <F9> :execute "grep -srnw " . expand("<cword>") . " --include=\*.{cpp,h,cmake} * "<Bar> cwindow<CR>
map <F9> :execute "grep -srnw --binary-files=without-match ". expand("<cword>")<CR> 
map <A-left> :bp!<cr>
map <A-right> :bn!<cr>
map <A-o> :A<cr>
map <F10> :NERDTreeFind<cr>

command! GrepRouter :%!grep -a -E 'Router_VD|RFMan|ModuleReadyInd|resetProcedure started'
command! GrepPrimary :%!grep -a -E 'Channel RP3-01 [[:digit:]] (in|RX|TX)|ModuleReady|resending|Header :|SFP RX LOS|rx LOS|SFP_LOS|monitorPllInterrupts|Set position in chain|resetProcedure started|triggerFilterSwUpdate$|WRN/LTX/Router_VD'
command! GrepSyslog :%!grep -a -i -E '\bFRM_REL[0-9]|(OAM/BBC)|(HWA/SUM)'
command! GrepIdData :%!grep -a -i -E '(\bHW environment\b)|(Active build)|(EepromHelper::serialNumber)|(StartupComponent, HWID)'
command! Rename call DoRenameRefactoring()
command! Underscore call DoCamelCaseToUnderscore()

command! RF3RemoveLogPrefix :%s/^\x\x\sFRM_REL3\s//
command! RF2RemoveLogPrefix :%s/^\x\x\sFRM_REL2\s//
command! SyslogRemoveLogPrefix :%s/\d\{6}\s\(\d\{2}[:. ]\)\{5}\d\{2,4}\s\{2,4}\[\(\d\{1,3}.\?\)\{4}\]\s\{2,4}\x\x\ [[:alnum:]-]\{4,20}\s//

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
colorscheme torte
