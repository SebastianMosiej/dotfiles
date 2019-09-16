
" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

syn keyword vbConditional If Then ElseIf Else Select Case

"Numbers
"integer number, or floating point number without a dot.
syn match caplNumber "\<\d\+\>"
"floating point number, with dot
syn match caplNumber "\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match caplNumber "\.\d\+\>"
syn match caplNumber "\<0x\x\+\>"


syn region  vbComment		start="\(^\|\s\)REM\s" end="$" contains=vbTodo

"comment

hi def link caplNumber			Number
