augroup filetypedetect
    au BufNewFile,BufRead *.ttcn  setfiletype  ttcn
    au BufNewFile,BufRead *.ttcn3  setfiletype  ttcn
    au BufNewFile,BufRead lumclient.log  setfiletype qemu_log
    au BufNewFile,BufRead mvp_machine.log  setfiletype qemu_log
augroup END

