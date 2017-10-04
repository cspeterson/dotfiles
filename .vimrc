"###############################################3
"## General goodness
"###############################################3
set nu " line numbers
set term=xterm-256color " behave sensibly
set laststatus=2 " always show status line

" Statusline
" Show full expanded path of file, cut at 30 chars
set statusline=%.30{fnamemodify(bufname('%'),':p:h')}/
" Filename
set statusline+=%t
" Start aligning the rest to the right
set statusline+=%=
" File type as detected by vim
set statusline+=FileType:\ %y " always show filename in status

" Layouts
set splitbelow " when splitting layout, new horizontal splits go below
set splitright " when splitting layout, new vert splits go to the rights
" Map layout navigation to ctrl+<key> 
nnoremap <C-J> <C-W><C-J> " down
nnoremap <C-K> <C-W><C-K> " up
nnoremap <C-L> <C-W><C-L> " right
nnoremap <C-H> <C-W><C-H> " left

" Tab nav controls sorta in the vein of Firefox etc
" Not using Ctrl-Tab etc because X and/or the terminal don't let the ind. keys
" through :(
nnoremap <S-Tab>   :tabprevious<CR>
nnoremap <Tab>     :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <S-Tab>   <Esc>:tabprevious<CR>i
inoremap <Tab>     <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" Redundant mappings for saving and quitting because I always typo
command Q q
command W w
command WQ wq
command Wq wq

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za


"###############################################3
"## Plugin stuff
"###############################################3
	" Vundle Plugins Setup
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" Examples:
	" Plugin 'tpope/vim-fugitive'
	" Plugin 'git://git.wincent.com/command-t.git'
	" Plugin 'file:///home/gmarik/path/to/plugin'
	" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
	"""""""""""""""""""""""""""""""""""""""""""
	"" Install Vim plugins with Vundle here
	"vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
" Install plugins here.
" They can be easily installed without entering Vim by running:
" vim +PluginInstall +qall
Plugin 'ConradIrwin/vim-bracketed-paste' " automatic set paste when pasting. which is nice.
Plugin 'JamshedVesuna/vim-markdown-preview' " preview markdown from vim in browser
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized' " pleasant colors
Plugin 'elzr/vim-json' " better than standard javascript highlighting
Plugin 'godlygeek/tabular' " aligns text
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/nerdtree'
Plugin 'tmhedberg/SimpylFold'	" smarter code folding
Plugin 'vim-syntastic/syntastic'
	"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	"" End list of plugins to install/manage
	"""""""""""""""""""""""""""""""""""""""""""
	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
	" To ignore plugin indent changes, instead use:
	"filetype plugin on
	"
	" Brief help
	" :PluginList       - lists configured plugins
	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
	"
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line


"###############################################3
"# vim-markdown-preview
"###############################################3
let vim_markdown_preview_github=1

"###############################################3
"# NerdTREE file browser
"###############################################3
map <C-f> :NERDTreeToggle<CR>	" Ctrl+f toggles file pane

"###############################################3
"# vim-json
"###############################################3
" If this is left on (default), the editor only shows the quotes around keys and values
" for the active line
"let g:vim_json_syntax_conceal = 0

"###############################################3
"# Code completion
"###############################################3
" Via youCompleteMe plugin
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"###############################################3
"# Theming
"###############################################3
syntax enable
let g:solarized_termcolors=256
colorscheme solarized
" Toggle dark/light colors
call togglebg#map("<F5>")
" now set it so it doesn't do that awful ugly blocky coloring behind text
" (this needs to be after the syntax line above)
hi Normal ctermbg=NONE

"###############################################3
"# Snytax
"###############################################3
"# Syntax highlighting options for Syntastic plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" This needs to come well after Vundle does its thing
filetype plugin indent on
