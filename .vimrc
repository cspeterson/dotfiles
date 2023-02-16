"###############################################3
"## General goodness
"###############################################3
set cursorline " highlight the line being edited
set lazyredraw
set nojoinspaces
set number " line numbers
set relativenumber " in combo with above, makes 'hybrid mode'
set scrolloff=3 " keep 3 lines above or below when scrolling up and down
set showcmd " in visual mode, shows char or line count of selected area
set spell spelllang=en_us " spellcheck on
set term=xterm-256color " behave sensibly
set ttyfast
set virtualedit=onemore
let mapleader = '\'
nnoremap Q q
nnoremap q <Nop>
set nomodeline
nnoremap <F1> <Nop>
nnoremap Y y$

" Unmap home/end in insert mode because I git them by accident a lot on my
" laptop
inoremap <Home> <Nop>
inoremap <End> <Nop>

" repeat last substitution on current line or selection
nnoremap ! :&<CR>
vnoremap ! :&<CR>

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
nnoremap <silent> "" :registers<CR>
" map register c to x11 'clipboard' register because "+ is more work
if !empty($DISPLAY) && has('clipboard')
  vnoremap "c "+
  vnoremap "C "+
  nnoremap "c "+
  nnoremap "C "+
elseif !empty($TMUX)
  function! Yank_to_tmux()
    " Takes the contents of `@c` and puts it into the Tmux paste buffer `0`
    " (which works with old and new versions of Tmux - the newer `bufferN`
    " naming scheme is not backwards compatible)
    :call system('cat <(pasteme=' . shellescape(@c) . ' printenv pasteme) | head -c -1 | tmux load-buffer -b 0 - ')
  endfunction
  function! Pull_from_tmux()
    " Pulls whatever is in the Tmux paste buffer `0` into `@c`
    silent let c_tmp = system('tmux save-buffer -b 0 -')
    if v:shell_error == 0
      let @c = c_tmp
    else
      let @c = ''
    endif
  endfunction
  " We could use the `TextYankPost` autocmd to make this work by reacting to
  " any placement of text into `@c` but Vim 7.4 that I'm actually using on
  " some older machines lacks this feature :/
  " As a consequence, I have no good way to integrate this yank into normal
  " keystrokes with motions and text objects etc and have it still end up in
  " Tmux
  nnoremap "Cy :echoerr 'Please select in visual mode before using this mapping
        \ to yank text into a Tmux buffer' <Enter>
  nnoremap "cy :echoerr 'Please select in visual mode before using this mapping
        \ to yank text into a Tmux buffer' <Enter>
  nnoremap "cd :echoerr 'Please select in visual mode before using this mapping
        \ to yank text into a Tmux buffer' <Enter>
  nnoremap "Cy :echoerr 'Please select in visual mode before using this mapping
        \ to yank text into a Tmux buffer' <Enter>
  " Pasting is easy though!
  nnoremap "cp :call Pull_from_tmux() <Bar> normal! "cp <Enter>
  nnoremap "Cp :call Pull_from_tmux() <Bar> normal! "cp <Enter>
  nnoremap "cP :call Pull_from_tmux() <Bar> normal! "cP <Enter>
  nnoremap "CP :call Pull_from_tmux() <Bar> normal! "cP <Enter>
  " Yank current visual selection into Tmux paste buffer
  vnoremap "cy "cy <Bar> :call Yank_to_tmux() <Enter>
  vnoremap "Cy "cy <Bar> :call Yank_to_tmux() <Enter>
  " Put the contents of the Tmux paste buffer, repacing the current visual
  " selection
  vnoremap "cp :call Pull_from_tmux() <Bar> normal! gv"cp<Enter>
  vnoremap "Cp :call Pull_from_tmux() <Bar> normal! gv"cp<Enter>
endif

" Casing
" Hitting `u` twice is kinda easier than shifting it up
nnoremap guu gU

" Search
" Use ignore case, smart case, highlight results, incrementally
" smart case ignores "ignore case" if we include uppercase characters
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <CR> :nohlsearch<cr> " enter clears search highlighting
" Search only within lines on screen
" https://www.reddit.couuuV
nnoremap <expr> z/ '/\%(\%>'.(line('w0')-1).'l\%<'.(line('w$')+1).'l\)\&'

" Whitespace
" Compress empty lines within entire buffer/selection if more than one
nnoremap <Leader>wc :%s/^\s*$\n\n\{1,}/\r/ge<Enter>
vnoremap <Leader>wc :s/^\s*$\n\n\{1,}/\r/ge<Enter>
" Delete all empty/whitespace-only lines
nnoremap <Leader>wd :%s/^\s*$\n//ge<Enter>
vnoremap <Leader>wd :s/^\s*$\n//ge<Enter>
" Delete all trailing whitespace
nnoremap <Leader>ws :%s/\s\+$//e<Enter>
vnoremap <Leader>ws :s/\s\+$//e<Enter>

" Numbers
nnoremap <Leader>na <C-a>
nnoremap <Leader>nx <C-x>

" Navigation
nnoremap <C-Up> 4k
nnoremap <C-Down> 4j
vnoremap <C-Up> 4k
vnoremap <C-Down> 4j

" Navigate splits easier
nnoremap <S-Left> <C-W><C-H>
nnoremap <S-Right> <C-W><C-L>
nnoremap <S-Up> <C-W><C-K>
nnoremap <S-Down> <C-W><C-J>

" Split directionally by command and potentially with a new file
command! -complete=file -nargs=? Spl leftabove vsplit <args>
command! -complete=file -nargs=? Spr rightbelow vsplit <args>
command! -complete=file -nargs=? Spu leftabove split <args>
command! -complete=file -nargs=? Spd rightbelow split <args>
" Split directionally by command and potentially with a new file BUT with fzf
command! Splf call fzf#run({ 'down': '40%',   'sink': 'leftabove vsplit' })
command! Sprf call fzf#run({ 'down': '40%',   'sink': 'rightbelow vsplit' })
command! Spuf call fzf#run({ 'down': '40%',   'sink': 'leftabove split' })
command! Spdf call fzf#run({ 'down': '40%',   'sink': 'rightbelow split' })
" Split current buffer directionally by leader
nnoremap <Leader>sl :leftabove vsplit<CR>
nnoremap <Leader>sr :rightbelow vsplit<CR>
nnoremap <Leader>su :leftabove split<CR>
nnoremap <Leader>sd :rightbelow split<CR>
" Split current buffer directionally by leader BUT with fzf
nnoremap <Leader>slf :call fzf#run({ 'down': '40%', 'sink': 'leftabove vsplit' })<CR>
nnoremap <Leader>srf :call fzf#run({ 'down': '40%', 'sink': 'rightbelow vsplit' })<CR>
nnoremap <Leader>suf :call fzf#run({ 'down': '40%', 'sink': 'leftabove split' })<CR>
nnoremap <Leader>sdf :call fzf#run({ 'down': '40%', 'sink': 'rightbelow split' })<CR>
" Split operations
" Change split to horizontal
nnoremap <Leader>sh <C-w>t<C-w>K
" Change split to vertical
nnoremap <Leader>sv <C-w>t<C-w>H
" Maximize current split
nnoremap <Leader>s_ <C-w>_<C-w>\|
nnoremap <Leader>s\| <C-w>_<C-w>\|
nnoremap <Leader>sM <C-w>_<C-w>\|
" Minimize current split
nnoremap <Leader>sm <C-w>1_<C-w>1\|
" Equalize splits
nnoremap <Leader>s= <C-w>=
" Close all other windows in current tabview but current
nnoremap <Leader>so <C-w>o

" Completion mappings
if !empty($DISPLAY)
  " GUI file and directory completion
  inoremap <expr> <c-x><c-g><c-f> substitute(system('zenity --file-selection'), '\n\+$', '', '')
  inoremap <expr> <c-x><c-g><c-d> substitute(system('zenity --directory --file-selection'), '\n\+$', '', '')
endif

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

" Ctags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <Leader>t} <C-w>}
nnoremap <Leader>t\ :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <Leader>t] <C-]>
nnoremap <Leader>tz <C-w>z
nnoremap <Leader>tt <C-t>

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
" Sub
cmap S/ s/

" Saving if forgot sudo
cmap w!! w !sudo tee > /dev/null %

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
nnoremap <Leader>zi :set foldmethod=indent<CR>
nnoremap <Leader>zs :set foldmethod=syntax<CR>
nnoremap <Leader>zm :set foldmethod=marker<CR>
nnoremap <Leader>za :call FoldAround()<CR>
function FoldAround()
  " Fold all of the text *except* for the selection
  " via https://stackoverflow.com/a/11862731/3366053
  set foldmethod=manual
  execute 'normal! `<kzfgg`>jzfG`<'
endfunction

" Filetypes
nnoremap <Leader>f! :set filetype=<CR>
nnoremap <Leader>fj :set filetype=json<CR>
nnoremap <Leader>fm :set filetype=markdown<CR>

" Incrementing/decrementing
nnoremap <C-a> <Nop>
nnoremap + <C-a>
vnoremap + <C-a>
nnoremap = <C-a>
vnoremap = <C-a>
nnoremap - <C-x>
vnoremap - <C-x>
nnoremap _ <C-x>
vnoremap _ <C-x>

" Redraw
nnoremap <Leader>r :redraw!<CR>

" Spell
"On config read, generate the lookup file from the spellfile if out of sync
function UpdateSpellfileLookup()
  silent exec 'mkspell! ~/.vim/spell/en.utf-8.add'
endfunction
let spellfile_mtime = system('stat -c %Y ~/.vim/spell/en.utf-8.add')
let spelllookupfile_mtime = system('stat -c %Y ~/.vim/spell/en.utf-8.add.spl')
if spellfile_mtime > spelllookupfile_mtime
  call UpdateSpellfileLookup()
endif

" Writing out and transforming the buffer into the clipboard
" Write/Copy Markdown to BBCode
nnoremap <Leader>wcmb :silent w !pandoc -f markdown -t $HOME/.config/pandoc/writers/pandoc_bbcode_smf.lua <bar> xclip -selection clipboard<CR>
vnoremap <Leader>wcmb :silent w !pandoc -f markdown -t $HOME/.config/pandoc/writers/pandoc_bbcode_smf.lua <bar> xclip -selection clipboard<CR>
" Write/Copy Markdown to Html
nnoremap <Leader>wcmh :silent w !pandoc -f markdown <bar> xclip -t text/html -selection clipboard<CR>
vnoremap <Leader>wcmh :silent w !pandoc -f markdown <bar> xclip -t text/html -selection clipboard<CR>

"###############################################3
"## Plugins!
"###############################################3
source ~/.vimplugins.vim

"###############################################3
"## After plugins!
"###############################################3
" This needs to come well after Vundle does its thing
filetype plugin indent on
