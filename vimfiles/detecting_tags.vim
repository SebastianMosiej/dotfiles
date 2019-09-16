
"*****************************************************************
"Detecting tags file recursivly in parents dirs
"*****************************************************************

if (! exists("FindCtagsHere"))
function! FindCtagsHere(dir, dir_sep)
      let tag_dir = a:dir
      let sep = a:dir_sep
      while !filereadable(tag_dir.sep."tags") && tag_dir!=$HOME && stridx(tag_dir, strpart(sep, 0,1))>=0
              let tag_dir = substitute(tag_dir, sep.'[^'.sep.']\+$', "", "")
      endwhile
      if filereadable(tag_dir.sep."tags")
              return tag_dir.strpart(sep,0,1)."tags"
      else
              return ''
      endif
endfunction
endif


function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endfunction
" au BufEnter /* call LoadCscope()
" 1

" 2
if has('win16') || has('win32') || has('win64')
au BufReadPost *.cpp    let b:current_file_tags=FindCtagsHere(expand('%:p:h'),'\\')
au BufReadPost *.h      let b:current_file_tags=FindCtagsHere(expand('%:p:h'),'\\')
au BufReadPost *.hpp    let b:current_file_tags=FindCtagsHere(expand('%:p:h'),'\\')

au BufReadPost *.cpp    call LoadCscope()
au BufReadPost *.h      call LoadCscope()
au BufReadPost *.hpp    call LoadCscope()
" treat paths as relative
set cscoperelative
else
au BufReadPost *.cpp    let b:current_file_tags=FindCtagsHere(expand('%:p:h'),'/')
au BufReadPost *.h      let b:current_file_tags=FindCtagsHere(expand('%:p:h'),'/')
au BufReadPost *.hpp    let b:current_file_tags=FindCtagsHere(expand('%:p:h'),'/')
endif

" 3
au BufReadPost *        if exists("b:current_file_tags") &&
\       filereadable(b:current_file_tags) &&
\       stridx(&tags, b:current_file_tags)<0 | let &tags.=','.b:current_file_tags | endif

" 4
if has('win16') || has('win32') || has('win64')
let x = FindCtagsHere(getcwd(), '\\')
else
let x = FindCtagsHere(getcwd(), '/')
endif
if filereadable(x)
       let &tags .= ','.x
endif

set tags +=/usr/include/boost/tags
set tags +=/usr/include/SDL2/tags
set tags +=/usr/include/i386-linux-gnu/qt5/tags
set tags +=/usr/include/x86_64-linux-gnu/qt5/tags
set tags +=c:/projects/Kanzi_Source_3_6_3_iznak/tags

