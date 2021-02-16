setlocal autoindent
setlocal colorcolumn=88
setlocal encoding=utf-8
setlocal expandtab	" inserts spaces instead of tabs
setlocal fileformat=unix
setlocal shiftwidth=4
setlocal smartindent
setlocal softtabstop=4
setlocal tabstop=4	" Sets a 'tab' to 4 spaces

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
