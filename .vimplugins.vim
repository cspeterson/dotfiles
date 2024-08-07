"###############################################3
"## Plugin stuff
"###############################################3
  " Vundle Plugins Setup
  filetype off
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

Plugin 'AndrewRadev/linediff.vim'
Plugin 'ConradIrwin/vim-bracketed-paste'    " Automatic set paste when pasting. which is nice.
Plugin 'altercation/vim-colors-solarized'     " Pleasant colors
Plugin 'bogado/file-line' " Open paths like `/path/to/file:NN` directly to the specified line number
Plugin 'cespare/vim-toml'
Plugin 'chaimleib/vim-renpy'
Plugin 'christoomey/vim-sort-motion'
Plugin 'christoomey/vim-titlecase'
Plugin 'coachshea/vim-textobj-markdown'
Plugin 'craigemery/vim-autotag'
Plugin 'cspeterson/vim-convert'	" Unit conversion
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'elzr/vim-json'           " Better than standard javascript highlighting
Plugin 'godlygeek/tabular'         " Aligns text
Plugin 'iamcco/markdown-preview.vim'       " Md preview with commands MarkdownPreview and MarkdownPreviewStop
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vader.vim'
Plugin 'kana/vim-textobj-entire' " Requires kana/vim-textobj-user
Plugin 'kana/vim-textobj-line' " Requires kana/vim-textobj-use
Plugin 'kana/vim-textobj-user'
Plugin 'kshenoy/vim-signature' " Show vim placemarks in sidebar
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'psf/black'
Plugin 'rhysd/vim-textobj-anyblock'
Plugin 'rodjek/vim-puppet'
Plugin 'sk1418/HowMuch'
Plugin 'tmhedberg/SimpylFold'  " smarter code folding
Plugin 'tmhedberg/matchit'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'        " Easily work with surrounding objects eg parens, quotes, tags
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/ReplaceWithRegister'

if (has('python3'))
  Plugin 'fisadev/vim-isort'
  Plugin 'python-mode/python-mode'
endif
if v:version < 800
  Plugin 'vim-syntastic/syntastic'
  let syntax_checker = 'syntastic'
else
  Plugin 'dense-analysis/ale'
  let syntax_checker = 'ale'
endif

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
"# vim-json
"###############################################3
" If this is left on (default), the editor only shows the quotes around keys and values
" for the active line
"let g:vim_json_syntax_conceal = 0

"###############################################3
"# vim-fugitive
"###############################################3
set diffopt+=vertical

"###############################################3
"# vim-markdown-toc
"###############################################3
:command! Mdtoc GenTocGFM

"###############################################3
"# vim-markdown
"###############################################3
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_edit_url_in = 'hsplit'
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_yaml_frontmatter = 1

"###############################################3
"# Markdown Preview
"###############################################3
:command! Mdprev MarkdownPreview
:command! Mdprevs MarkdownPreviewStop

"# Pymode
let g:pymode_lint_checkers = [] " using ALE for linting already thx

"###############################################3
"# Linediff
"###############################################3
nnoremap <Leader>ld :Linediff<Enter>
vnoremap <Leader>ld :Linediff<Enter>
nnoremap <Leader>ldr :LinediffReset<Enter>
vnoremap <Leader>ldr :LinediffReset<Enter>

"###############################################3
"# Theming
"###############################################3
syntax enable
let g:solarized_termcolors=256
colorscheme solarized
" Set undercurl mode to get around underline fallback bug in some vim versions
" https://github.com/vim/vim/issues/2424
set t_Cs=
" Toggle dark/light colors
call togglebg#map("<F5>")
" now set it so it doesn't do that awful ugly blocky coloring behind text
" (this needs to be after the syntax line above)
hi Normal ctermbg=NONE

"###############################################3
"# Snytax
"###############################################3
if syntax_checker ==# 'syntastic'
  "# Syntax highlighting options for Syntastic plugin
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_python_checkers = ['python3']
else
  let g:ale_echo_msg_format = '%code%: %s [%linter%]'
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_linters = { 'markdown': ['vale']}
  let g:ale_sign_error = '✘'
  let g:ale_sign_warning = '⚠'
  nnoremap ]l :ALENextWrap<CR>
  nnoremap [l :ALEPreviousWrap<CR>
endif

"###############################################
"# Speeddating
"###############################################
let g:speeddating_no_mappings = 1
nmap  +     <Plug>SpeedDatingUp
nmap  =     <Plug>SpeedDatingUp
nmap  -     <Plug>SpeedDatingDown
xmap  +     <Plug>SpeedDatingUp
xmap  =     <Plug>SpeedDatingUp
xmap  -     <Plug>SpeedDatingDown
nmap d+     <Plug>SpeedDatingNowUTC
nmap d=     <Plug>SpeedDatingNowUTC
nmap d-     <Plug>SpeedDatingNowLocal

"###############################################
"# titlecase
"###############################################
nmap gt  <Plug>Titlecase
vmap gt  <Plug>Titlecase

"###############################################
"# Textobj-Markdown
"###############################################
" I only want this plugin in order to make objects of fenced codeblocks, so
" stop it from doing its other things
let g:textobj_markdown_no_default_key_mappings=1
omap aF <plug>(textobj-markdown-Bchunk-a)
omap af <plug>(textobj-markdown-chunk-a)
omap iF <plug>(textobj-markdown-Bchunk-i)
omap if <plug>(textobj-markdown-chunk-i)
vmap aF <plug>(textobj-markdown-Bchunk-a)
vmap af <plug>(textobj-markdown-chunk-a)
vmap iF <plug>(textobj-markdown-Bchunk-i)
vmap if <plug>(textobj-markdown-chunk-i)

"###############################################3
"# Man
"###############################################3

runtime ftplugin/man.vim

"###############################################3
"# Fzf
"###############################################3

imap <c-x><c-f> <plug>(fzf-complete-file)
imap <c-x><c-l> <plug>(fzf-complete-line)
" File completion of *directories only*
imap <expr> <c-x><c-d> fzf#vim#complete#path("find . -type d -print \| sed '1d;s:^..::'")


"###############################################3
"# Tabular(ize)
"###############################################3

autocmd VimEnter * AddTabularPattern first_hash /^[^#]*\zs#
autocmd VimEnter * AddTabularPattern puppet_params /^[^\$]*\zs\$/l1c0
autocmd VimEnter * AddTabularPattern rocket /^[^\$]*\zs\$/l1c0
