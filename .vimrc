"###############################################3
"## General goodness
"###############################################3
set cursorline " highlight the line being edited
set lazyredraw
set number " line numbers
set relativenumber " in combo with above, makes 'hybrid mode'
set scrolloff=3 " keep 3 lines above or below when scrolling up and down
set spell spelllang=en_us " spellcheck on
set term=xterm-256color " behave sensibly
set ttyfast
set virtualedit=onemore
let mapleader = '\'
nnoremap Q q
nnoremap q <Nop>

" repeat last substitution on current line
nnoremap ! &
" split line before cursor
nnoremap <C-j> i<Enter><Esc>

" " Toggles
set pastetoggle=<F2>
" Spell check
nnoremap <F4> :setlocal spell! spelllang=en_us<CR>
" Toggle whitespace char representation
nnoremap <C-l> :set list!<CR>
" Toggle nu
nnoremap <C-n> :set number!<CR> :set relativenumber!<CR>

" Registers
" map register c to x11 'clipboard' register because "+ is more work
map "c "+

" Search
" Use ignore case, smart case, highlight results, incrementally
" smart case ignores "ignore case" if we include uppercase characters
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <CR> :nohlsearch<cr> " enter clears search highlighting
" Search only within lines on screen
" https://www.reddit.com/r/vim/comments/8mrwu3/search_in_part_of_file/?utm_source=reddit-android
nnoremap <expr> z/ '/\%(\%>'.(line('w0')-1).'l\%<'.(line('w$')+1).'l\)\&'

" Navigation
nmap <C-Up> 4k
nmap <C-Down> 4j

" Split directionally
command! -complete=file -nargs=? Spl leftabove vsplit <args>
command! -complete=file -nargs=? Spr rightbelow vsplit <args>
command! -complete=file -nargs=? Spu leftabove split <args>
command! -complete=file -nargs=? Spd rightbelow split <args>

" Statusline
set laststatus=2 " always show status line
set statusline=
" Buffer number
set statusline+=Buf:%(%{&filetype!='help'?bufnr('%'):''}\ \|\ %)
" Add full expanded path (without filename) of file, cut from right at 30 chars
set statusline+=%.30{fnamemodify(bufname('%'),':p:h')}/
" Add filename
set statusline+=%t
" Add modified or RO marker after filename if either true
set statusline+=%{&modified?'\ +\ ':''}
set statusline+=%{&readonly?'\ 🔒\ ':''}
" From here, align the rest to the right
set statusline+=%=
" Paste?
set statusline+=%{&paste?'paste':'nopaste'}
set statusline+=\ \|
set statusline+=%{&spell?'spell':'nospell'}
set statusline+=\ \|
" Character value
set statusline+=\ A:%b\ U\+%B
set statusline+=\ \|\ 
" File type as detected by vim, specifying when none
set statusline+=[%{&filetype!=#''?&filetype:'none'}]
" Show file encoding ig
set statusline+=%(\ \|%{(&bomb\|\|&fileencoding!~#'^$\\\|utf-8'?'\ '.&fileencoding.(&bomb?'-bom':''):'')\.(&fileformat!=#(has('win32')?'dos':'unix')?'\ '.&fileformat:'')}%)
" Show `et` or `noet` for expandtab on/off. Then, shift width
set statusline+=%(\ \|\ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)
" Column number
set statusline+=\ \|\ Col:\ %{&number?'':printf('%2d,',line('.'))}
set statusline+=%-2v " Virtual column number if differs
" Percentage through file
set statusline+=\ \|\ %2p%%
" Total lines
set statusline+=/%L

" Layouts
set splitbelow " when splitting layout, new horizontal splits go below
set splitright " when splitting layout, new vert splits go to the rights
" Automatically rescale splits on window resize
autocmd VimResized * wincmd =

" Quickfix
autocmd FileType qf nnoremap <buffer> <Enter> <C-W><Enter><C-W>T

" Tab nav controls sorta in the vein of Firefox etc
" Not using Ctrl-Tab etc because X and/or the terminal don't let the ind. keys
" through :(
nnoremap <S-Tab>   :tabprevious<CR>
nnoremap <Tab>     :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>

" Redundant mappings for common functions because I always typo
" quit all
command! Q q
command! Qa qa
command! QA qa
" split
command! Sp sp
command! SP sp
" split vert
command! VSp vsp
command! VSP vsp
command! VsP vsp
" split directional as above but with typos
command! SPl Spl
command! SPL Spl
command! SPr Spr
command! SPR Spr
command! SPu Spu
command! SPU Spu
command! SPd Spd
command! SPD Spd
" write/save/quit
command! W w
command! Wq wq
command! WQ wq
command! Wqa wqa
command! WQa wqa
command! WQA wqa

" Saving if forgot sudo
cmap w!! w !sudo tee > /dev/null %

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za


"###############################################3
""## My functions or long-form commands
"###############################################3

" Exi - "execute interactive"
" A command to execute whatever follows in an interactive shell
" Ensure shell flags specify interactive mode, execute command, and return
" to original setting
" Basically I just want to be able to execute bash aliases once in a while
" Use example:
" :Exi %!myalias arg1 arg2
command! -nargs=+ Exi
  \ let shellcmdflag_orig = &shellcmdflag |
  \ let &shellcmdflag='-ci' |
  \ execute ':' . "<args>" |
  \ let &shellcmdflag=shellcmdflag_orig

" Delete all trailing whitespace
command! Endwhitespace :%s/\s\+$//e

"###############################################3
"## Plugins!
"###############################################3
source ~/.vim_plugins

"###############################################3
"## After plugins!
"###############################################3
" This needs to come well after Vundle does its thing
filetype plugin indent on
