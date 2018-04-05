setlocal colorcolumn=80

setlocal autoindent
setlocal smartindent

setlocal shiftwidth=2
setlocal expandtab
setlocal softtabstop=2
setlocal tabstop=2

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
