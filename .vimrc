"###############################################3
"## General goodness
"###############################################3
set nu " line numbers
set term=xterm-256color " behave sensibly
set cursorline " highlight the line being edited
set scrolloff=3 " keep 3 lines above or below when scrolling up and down
set pastetoggle=<F2>

" Search
" Use ignore case, smart case, highlight results, incrementally
" smart case ignores "ignore case" if we include uppercase characters
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <CR> :nohlsearch<cr> " enter clears search highlighting

" Navigation
nmap <C-Up> 4k
nmap <C-Down> 4j

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
set statusline+=%{&paste?'paste':'nopaste'}
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

" Tab nav controls sorta in the vein of Firefox etc
" Not using Ctrl-Tab etc because X and/or the terminal don't let the ind. keys
" through :(
nnoremap <S-Tab>   :tabprevious<CR>
nnoremap <Tab>     :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>

" Redundant mappings for common functions because I always typo
" split
command Sp sp
command SP sp
" quit all
command Q q
command Qa qa
command QA qa
" split vert
command VSp sp
command VSP sp
command VsP sp
" write/save/quit
command W w
command Wq wq
command WQ wq
command Wqa wqa
command WQa wqa
command WQA wqa

" Saving if forgot sudo
cmap w!! w !sudo tee > /dev/null %

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
Plugin 'ConradIrwin/vim-bracketed-paste'		" Automatic set paste when pasting. which is nice.
Plugin 'JamshedVesuna/vim-markdown-preview'		" Preview markdown from vim in browser
Plugin 'Valloric/YouCompleteMe'				" Code completion
Plugin 'altercation/vim-colors-solarized' 		" Pleasant colors
Plugin 'elzr/vim-json' 					" Better than standard javascript highlighting
Plugin 'godlygeek/tabular' 				" Aligns text
Plugin 'iamcco/markdown-preview.vim' 			" Md preview with commands MarkdownPreview and MarkdownPreviewStop
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-surround'				" Easily work with surrounding objects eg parens, quotes, tags
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
" YCM only supports 7.4.1578+
if v:version <= 7.4.1578
        let g:loaded_youcompleteme = 1 
else
        let g:ycm_autoclose_preview_window_after_completion=1
        map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif

"###############################################3
"# Markdown Preview
"###############################################3
:command Md MarkdownPreview
:command Mds MarkdownPreviewStop

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
