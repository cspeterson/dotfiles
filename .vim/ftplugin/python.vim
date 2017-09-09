set autoindent
set colorcolumn=120
set encoding=utf-8
set expandtab	" inserts spaces instead of tabs
set fileformat=unix
set shiftwidth=4
set smartindent
set softtabstop=4
set tabstop=4	" Sets a 'tab' to 4 spaces
set textwidth=79

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
