"
if did_filetype()
    finish
    Decho "filetype known"
endif
"30.11 13:49:42.335
let s:ip_address="\(\d\{1,3\}[.]\?\)\{4\}"
let s:short_timestamp="\(\(\d\)\{1,3}[\.\ :]\)\{5}\d\{3,6}"
let s:long_timestamp1="\(\d\{2,4\}[-T:\.\ ]\)\{6,8\}\d\{-3,6}Z"

if bufname("%") =~ "runtime_DEFAULT.log" || bufname("%") =~ "startup_DEFAULT.log" || bufname("%") =~ "startup_BTSOM.log" || bufname("%") =~ "runtime_BTSOM.log"
  set ft=syslog
  :%s///ge
elseif bufname("%") =~ ".*\.log"
  "if getline(1) =~ '\_^\x\x\ [0-9A-Za-z\._-]\{6,30}\ <\(\(\d\d\)[\.\ :]\)\{5}\d\{6}>\s*\x\{1,3}\ '
  "  set ft=k3btslog
  "  :%s///ge
  "else
  if getline(1) =~ '^\d\{6\}\s*\(\(\d\)\{1,3}[\.\ :]\)\{5}\d\{2,6}\s\{1,2}\[\(\d\{1,3\}[.]\?\)\{4\}\]'
    set ft=syslog
    :%s///ge
  elseif getline(1) =~ '^\x\x FCT-1011.* <\(\d\{2,4\}[-T:\.\ ]\)\{6,8\}\d\{-3,6}Z> '
    set ft=syslog
    :%s///ge
  elseif getline(1) =~ '^\x\x\ FRM_REL\d\ <\(\d\{2,4\}[-T:\.\ ]\)\{6,8\}\d\{-3,6}Z> \x\{-1,7\}\ ' || getline(1) =~ '^<\(\d\{2,4\}[-T:\.\ ]\)\{6,8\}\d\{-3,6}Z> \x\{-1,7\}\ '
    set ft=rflog
    :%s///ge
    :%!grep -a -v 'SfpHandler::addToCache'
    set ro
    set buftype=nowrite
    :GrepRouter
    :GrepPrimary
  elseif getline(1) =~ '^\d\{6}\s*SYSLOG_\d\{1,3}\s*\(\(\d\)\{1,3}[\.\ :]\)\{5}\d\{2,6}'
    set ft=syslog
    :%s///ge
  elseif getline(1) =~ '\v^\d\d:\d\d:\d\d.\d\d\d\s\s<((INFO)|(DEBUG)|(WARN)|(ERROR))>\s*\(N:\d,P:\s*\d*,T:\s*\d*\)\s*\{.*$'
    set ft=ivi
    :%s/^$\n//g
  elseif getline(1) =~ '\v^\s*\d\d\:\d\d\.\d{6}\s*:\s<\w*>\s*.*'
    set ft=ivi_performance
  endif
elseif getline(1) =~ '^=====$'
  set ft=use_case
elseif getline(1) =~ '@startuml/>'
  set ft=plantuml
elseif bufname("%") =~ "*\.js"
  setlocal foldmethod=indent 
elseif bufname("%") =~ "msg_.*\.txt"
  set ft=vusa_sx_testcase
endif

