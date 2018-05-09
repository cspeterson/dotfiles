setlocal autoindent
setlocal colorcolumn=100
setlocal encoding=utf-8
setlocal expandtab	" inserts spaces instead of tabs
setlocal fileformat=unix
setlocal shiftwidth=2
setlocal smartindent
setlocal softtabstop=2
setlocal tabstop=2
setlocal textwidth=100

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
