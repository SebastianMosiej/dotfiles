@ECHO OFF
CLS
SET HOME=%HOMEDRIVE%%HOMEPATH%
REM SET HOME=%APPDATA%\..

ECHO User data folder is %APPDATA%\..

if exist "%HOME%\vimfiles\" (
ECHO Folder vimfiles exist 
) ELSE (
ECHO Creating user vimfiles folder 
md "%HOME%/vimfiles"
)

if not exist "%HOME%\_vimrc" (
 mklink "%HOME%\_vimrc" "%CD%\vimfiles\vimrc"
)
call :CreateFileLink "%HOME%\vimfiles" "%CD%\vimfiles" filetype.vim
call :CreateFileLink "%HOME%\vimfiles" "%CD%\vimfiles" scripts.vim
call :CreateFileLink "%HOME%\vimfiles" "%CD%\vimfiles" bundle_configuration.vim
call :CreateFileLink "%HOME%\vimfiles" "%CD%\vimfiles" custom_functions.vim
call :CreateFileLink "%HOME%\vimfiles" "%CD%\vimfiles" detecting_tags.vim
call :CreateFileLink "%HOME%\vimfiles" "%CD%\vimfiles" greps.vim


call :CreateDirectoryLink "%HOME%\vimfiles" "%CD%\vimfiles" syntax
call :CreateDirectoryLink "%HOME%\vimfiles" "%CD%\vimfiles" plugin
if NOT exist "%HOME%\vimfiles\bundle" (
  md "%HOME%\vimfiles\bundle"
 )
call :CreateDirectoryLink "%HOME%\vimfiles\bundle" "%CD%\vimfiles\bundle" Vundle.vim

mklink /D "%HOME%\.vim" "%HOME%\vimfiles"
goto:eof


:CreateDirectoryLink
if NOT exist %~1\%~3\ (
ECHO Creating link to directory %~3
	mklink /D "%~1\%~3" "%~2\%~3"
) ELSE (
ECHO Directory %~3 already exist 
)
goto:eof

:CreateFileLink
if NOT exist %~1\%~3 (
ECHO Creating link to %~3 file
	mklink "%~1\%~3" "%~2\%~3"
) ELSE (
ECHO File %~3 already exist 
)
goto:eof
