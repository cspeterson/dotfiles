setlocal wrapmargin=0
setlocal conceallevel=2

" Override `-` as an option for `vim-surround` to instead wrap things in code
" fences
let b:surround_45 = "```\n\r\n```"

" Custom text object for code fences
" Modified from https://github.com/preservim/vim-markdown/issues/282#issuecomment-687613426
function! s:SelectFencedCodeA()
    execute "normal! $/^[ \t]*```\<CR>V/^[ \t]*```*$\<CR>o"
endfunction

function! s:SelectFencedCodeI()
    call <SID>SelectFencedCodeA()
    normal! joko
endfunction

nmap     <buffer>         va-      :call <SID>SelectFencedCodeA()<CR>
nmap     <buffer>         vi-      :call <SID>SelectFencedCodeI()<CR>
onoremap <buffer><silent> a-       :call <SID>SelectFencedCodeA()<CR>
onoremap <buffer><silent> i-       :call <SID>SelectFencedCodeI()<CR>
