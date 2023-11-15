setlocal wrapmargin=0
setlocal conceallevel=2

" Override `c` as an option for `vim-surround` to instead wrap things in code
" fences
let b:surround_99 = "```\n\r\n```"

" Custom text object for code fences
" Modified from https://github.com/preservim/vim-markdown/issues/282#issuecomment-687613426
function! s:SelectFencedCodeA()
    execute "normal! $?^[ \t]*```\<CR>V/^[ \t]*```*$\<CR>o"
endfunction

function! s:SelectFencedCodeI()
    call <SID>SelectFencedCodeA()
    normal! joko
endfunction

nmap     <buffer>         vac      :call <SID>SelectFencedCodeA()<CR>
nmap     <buffer>         vic      :call <SID>SelectFencedCodeI()<CR>
onoremap <buffer><silent> ac       :call <SID>SelectFencedCodeA()<CR>
onoremap <buffer><silent> ic       :call <SID>SelectFencedCodeI()<CR>
