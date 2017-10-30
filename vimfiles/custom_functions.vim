
"*****************************************************************
" requires xmllint in PATH
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

"*****************************************************************
" function which returns the highlight group syntax under the cursor:
function! SyntaxItem()
    return synIDattr(synID(line("."),col("."),1),"name")
endfunction

"*****************************************************************
" recursively performs rename of whole word under cursor in C++ files
function! DoRenameRefactoring()
  let curword = expand("<cword>")
  call inputsave()
  let name = input('Rename ' . curword . ' to : ')
  call inputrestore()
  if name == ""
    return
  endif
  if has("win32") || has("win16")
    silent !clear
  else
    silent !clear
    execute "!grep -lrw --include=\*.{cpp,h} ".curword." * | xargs sed -i -e 's/\\b".curword."\\b/".name."/g' "
  endif  
  "execute "%s/\\<" . curword . "\\>/". name."/g"
endfunction

"*****************************************************************
" if any of vim standard directories is missing - create them
function! InitializeDirectories()
   let separator = "."
   let parent = $HOME 
   let prefix = '.vim'
   let dir_list = { 'backup': 'backupdir', 'views': 'viewdir', 'swap': 'directory' }

   for [dirname, settingname] in items(dir_list)
       let directory = parent . '/' . prefix . dirname . "/"
       if exists("\*mkdir")
           if !isdirectory(directory)
               call mkdir(directory)
           endif
       endif
       if !isdirectory(directory)
           echo "Warning: Unable to create backup directory: " .  directory
           echo "Try: mkdir -p " . directory
       else  
           let directory = substitute(directory, " ", "\\\\\\\\ ", "")
           exec "set " . settingname . "=" . directory
       endif
   endfor
endfunction
call InitializeDirectories() 

"*****************************************************************
function! CppSyntax_variables()
    " Add highlighting for function definition in C++
    syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
    hi def link cppFuncDef Special

    syn match cppFuncCall "\zs\h\w\+\>\ze(.*"
    hi def link cppFuncCall Special

    " Add highlighting for structures or pointers refered to by . or ->
    syn match cppPointerVariable "\zs\<\h\w\+\>\ze\(\[.*\]\|)\)*\(\.\|\(->\)\)"
    highlight NormalBold     gui=bold
    "syn match cppFunctionName "---------"

    hi def cppPointerVariable gui=bold
    "hi def link cppPointerVariable NormalBold
endfunction
"*****************************************************************
"Here's a function to toggle the use of syntax-based folding for a c/c++/java file. It also handles folding markers.
"*****************************************************************
function! <SID>OutlineToggle()
  let OldLine = line(".")
  let OldCol = virtcol(".")
  if (! exists ("b:outline_mode"))
    let b:outline_mode = 0
    let b:OldMarker = &foldmarker
  endif


  if (b:outline_mode == 0)
    let b:outline_mode = 1
    set foldmethod=marker
    set foldmarker={,}
    silent! exec "%s/{{{/{<</"
    silent! exec "%s/}}}/}>>/"
    set foldcolumn=4
  else
    let b:outline_mode = 0
    set foldmethod=marker
    let &foldmarker=b:OldMarker
    silent! exec "%s/{<</{{{/"
    silent! exec "%s/}>>/{{{/"
    set foldcolumn=0
  endif

  execute "normal! ".OldLine."G"
  execute "normal! ".OldCol."|"
  unlet OldLine
  unlet OldCol
  execute "normal! zv"
endfunction

:command! -nargs=0 FOLD call <SID>OutlineToggle()
" End of code 

"*****************************************************************
" recursively performs rename of whole word under cursor in C++ files
function! DoCamelCaseToUnderscore()
  let curword = expand("<cword>")
  let curline = getline(".")
  let word_pos = match(curline,curword)
  let word = substitute(curword,'::','/','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'[.-]','_','g')
  let word = tolower(word)
  let new_line = curline[:word_pos-1].word.curline[word_pos+len(curword):]
  :call setline(line("."),new_line)
endfunction

function! DoSearchInProject()
  call inputsave()
  let name = input('Search for : ')
  call inputrestore()
  if has("win32") || has("win16")
    silent !clear
  else
    silent !clear
    execute "grep -srna  --include=*.{cpp,cc,hh,h} --exclude=build '".name."' * " | cwindow
  endif  
endfunction

function! GrepRfIdData()
 " execute %!grep -m 1 -a -i -E '(\bHW environment\b)'
 " execute %!grep -m 1 -a -i -E '(Active build)'
 " execute %!grep -m 1 -a -i -E '(EepromHelper::serialNumber)'
 " execute %!grep -m 1 -a -i -E '(StartupComponent, HWID)'
endfunction

