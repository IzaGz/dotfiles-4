""""""""""""""""""""""" }}}
" Preamble              {{{
"""""""""""""""""""""""

" Map Leaders
let mapleader = "\<Space>"
let maplocalleader =','

" Use vim, no vi defaults
set nocompatible
filetype off


""""""""""""""""""""" }}}
" Plug setup          {{{
"""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" Core
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'nelstrom/vim-visual-star-search'
Plug 'godlygeek/tabular'
Plug 'icymind/neosolarized'
Plug 'dracula/vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'grassdog/RemoveFile.vim'
Plug 'mbbill/undotree'
Plug 'YankRing.vim'
Plug 'bogado/file-line'
Plug 'szw/vim-maximizer'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sbdchd/neoformat'

" Tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

" Text objects and motions
Plug 'michaeljsmith/vim-indent-object'
Plug 'bkad/CamelCaseMotion'
Plug 'kana/vim-textobj-user'
Plug 'rhysd/vim-textobj-ruby'
Plug 'wellle/targets.vim'

" Completions and Snippets
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'

" Tools
Plug 'EasyGrep'
Plug 'jremmen/vim-ripgrep'
Plug 'henrik/vim-open-url'
Plug 'grassdog/tagman.vim'

" Ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'vim-ruby/vim-ruby'
Plug 'jgdavey/vim-blockle'
Plug 'tpope/vim-cucumber'
Plug 'nelstrom/vim-textobj-rubyblock'

" Web
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'nelstrom/vim-markdown-folding'
Plug 'timcharper/textile.vim'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'slim-template/vim-slim'
Plug 'groenewege/vim-less'

" JS
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'glanotte/vim-jasmine'
Plug 'mustache/vim-mustache-handlebars'
Plug 'JSON.vim'
Plug 'fleischie/vim-styled-components'
Plug 'mxw/vim-jsx'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Clojure
Plug 'guns/vim-clojure-static'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Other
Plug 'lukerandall/haskellmode-vim'
Plug 'ajf/puppet-vim'
Plug 'wting/rust.vim'
Plug 'cespare/vim-toml'
Plug 'reedes/vim-wordy'

call plug#end()

" Enable matchit
runtime macros/matchit.vim

" Turn on filetype plugins and indent files for per-type indenting
filetype plugin indent on

"""""""""""""""""""""""""" }}}
" Leader binding prefixes  {{{
""""""""""""""""""""""""""

" s - search
" a - alignment
" f - file
" e - edit
" x - execute
" m - filetype specific
" u - ui
" k - bookmarks


""""""""""""""""""""""" }}}
" Base setup            {{{
"""""""""""""""""""""""

set number            " Show line numbers
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set hidden            " Hide buffers, don't nag about them

" Don't try to highlight lines longer than 300 characters.
set synmaxcol=300

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
"set t_ti= t_te=

set nowrap                            " don't wrap lines
set tabstop=2                         " a tab is two spaces
set shiftwidth=2                      " an autoindent (with <<) is two spaces
set expandtab                         " use spaces, not tabs
set autoindent
set shiftround                        " round indent to multiples of shiftwidth

" auto-wrap comments, auto insert comment header, allow formatting of comments with "gq"
" long lines are not broken in insert mode, don't break a line after a one letter word
" remove comment leader when joining lines
set formatoptions=crql1j

" Fast terminal please
set ttyfast

" Display tabs and whitepace
set list
set listchars=tab:▸\ ,trail:·,extends:»,precedes:«

set backspace=indent,eol,start        " backspace through everything in insert mode
set whichwrap+=<,>,h,l,[,]            " Allow left, right, bs, del to cross lines

" Treat all numbers as decimal
set nrformats=

set scrolloff=3       " Always show at least three lines below cursor
set mat=3             " Blink matching brackets for 3 tenths of a second
set visualbell t_vb=  " No Noise or bell

set nopaste

set cursorline

""""""""""""""""""""""" }}}
" Statusline            {{{
"""""""""""""""""""""""

let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

set laststatus=2  " always show the status bar
set showmode
set shortmess=atIOT   " Abbrev. of messages (avoids 'hit enter')
set showcmd


""""""""""""""""""""""" }}}
" Spelling              {{{
"""""""""""""""""""""""

" Setup my language
set spelllang=en_au

set spellfile=~/Dropbox/Backups/Vim/custom-dictionary.utf-8.add

" Toggle spelling
noremap <F9> :setlocal spell! spell?<CR>


""""""""""""""""""""""" }}}
" Search                {{{
"""""""""""""""""""""""

set nohlsearch  " Don't highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" Toggle search highlighting
noremap <leader>sc :set hlsearch! hlsearch?<CR>
noremap <leader><leader> :set hlsearch! hlsearch?<CR>

" Search for current word in Rg
nnoremap <leader>srw :Rg '\b<c-r><c-w>\b'<cr>
nnoremap <leader>sp :Rg<space>

" Easy grep
let g:EasyGrepReplaceWindowMode=2


""""""""""""""""""""""" }}}
" Wildmenu completion   {{{
"""""""""""""""""""""""

" tab completion for file selection
" set wildmode=longest:full,full
set wildmode=list:longest,list:full " Pop up a list when completing

" make tab completion for files/buffers act like bash
set wildmenu

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=.DS_Store                        " OSX

set wildignore+=*.obj,*.rbc,*.class,*.gem        " Disable output and VCS files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz " Disable archive files

" Ignore bundler and sass cache
set wildignore+=**/vendor/gems/*,**/vendor/bundle/*,**/vendor/cache/*,**/.bundle/*,.sass-cache/*,doc/**
set wildignore+=*/tmp/*
set wildignore+=*/spec/vcr/*
set wildignore+=*/coverage/*
set wildignore+=*.otf,*.woff,*.orig

set wildignore+=node_modules

set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files


""""""""""""""""""""""" }}}
" History and undo      {{{
"""""""""""""""""""""""

set history=1000

" Undo, swap, and backup files
if has('persistent_undo')
  set undofile
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

set undodir=~/.cache/vim/tmp/undo/
set backup
set backupdir=~/.cache/vim/tmp/backups
set noswapfile
set writebackup

set autoread                  " Just load a changed file


""""""""""""""""""""""" }}}
" Folding               {{{
"""""""""""""""""""""""

set nofoldenable
set foldlevelstart=99

function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()


""""""""""""""""""""""" }}}
" Colours               {{{
"""""""""""""""""""""""

set background=dark

let g:neosolarized_contrast = "high"
let g:neosolarized_visibility = "normal"
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1

if has("gui_macvim")
  let g:airline_theme='solarized'
  colorscheme NeoSolarized
else
  colorscheme dracula
endif

""""""""""""""""""""""" }}}
" Movement              {{{
"""""""""""""""""""""""

" Move across display lines, not physical lines
noremap j gj
noremap gj j
noremap k gk
noremap gk k
noremap <down> gj
noremap <up> gk

" Camelcase motion
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge

omap <silent> i,w <Plug>CamelCaseMotion_iw
xmap <silent> i,w <Plug>CamelCaseMotion_iw
omap <silent> i,b <Plug>CamelCaseMotion_ib
xmap <silent> i,b <Plug>CamelCaseMotion_ib
omap <silent> i,e <Plug>CamelCaseMotion_ie
xmap <silent> i,e <Plug>CamelCaseMotion_ie

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <s-down> <c-w>j
nnoremap <s-up> <c-w>k
nnoremap <s-left> <c-w>h
nnoremap <s-right> <c-w>l

set splitright
set splitbelow

" Stop page movement on shift arrow
vnoremap <S-Down> <Down>
vnoremap <S-Up> <Up>

" Switch to last buffer
nnoremap <leader><tab> <c-^>


""""""""""""""""""""""" }}}
" Text manipulation     {{{
"""""""""""""""""""""""

" Shift-tab in insert mode goes backward
inoremap <s-tab> <c-d>

" Indent or outdent and maintain selection in visual mode
vnoremap >> >gv
vnoremap << <gv

" Yank to the end of the line
noremap Y y$

" Yank to system clipboard
map <leader>y "*y

" Move past the end of lines in visual block edit
set virtualedit=block

" Bubble lines up and down
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <silent> <C-up> :m .-2<CR>==
nnoremap <silent> <C-down> :m .+1<CR>==

inoremap <silent> <C-up> <Esc>:m .-2<CR>==gi
inoremap <silent> <C-down> <Esc>:m .+1<CR>==gi

vnoremap <silent> <C-up> :m '<-2<CR>gv=gv
vnoremap <silent> <C-down> :m '>+1<CR>gv=gv

" Tabularise shortcuts
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Auto align when inserting `|`
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" Re-wrap the entire file
nnoremap <leader>ei ggVGgq
nnoremap <leader>ew :StripWhitespace<cr>

" Format the entire file
nnoremap <leader>ef ggVG=


""""""""""""""""""""""" }}}
" Proper quotes etc     {{{
"""""""""""""""""""""""

"
" RemoveFancyCharacters COMMAND
" Remove smart quotes, etc.
"
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()


""""""""""""""""""""""" }}}
" Working directory     {{{
"""""""""""""""""""""""

" Easier current directory in command mode
cnoremap <expr> %%  getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'

" A standalone function to set the working directory to the project’s root, or
" to the parent directory of the current file if a root can’t be found:
function! s:setcwd()
  let cph = expand('%:p:h', 1)
  if match(cph, '\v^<.+>://') >= 0 | retu | en
  for mkr in ['.git/', '.hg/', '.svn/', '.bzr/', '_darcs/', '.vimprojects']
    let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
    if wd != '' | let &acd = 0 | brea | en
  endfo
  exe 'lc!' fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
endfunction
command! SetProjectDir :call s:setcwd()


""""""""""""""""""""""" }}}
" Abbreviations         {{{
"""""""""""""""""""""""

iabbrev teh the


""""""""""""""""""""""" }}}
" Netrw                 {{{
"""""""""""""""""""""""

" No Netrw menu
let g:netrw_menu      = 0
let g:netrw_list_hide = '.DS_Store$'
let g:netrw_liststyle =0

" Preview in a vertical split
let g:netrw_preview   = 1
let g:netrw_winsize   = 30
" Use the same window for all netrw windows
" let g:netrw_chgwin=2

" Remove netrw history files
let g:netrw_dirhistmax = 0
" Don't change current dir when browsing to different dirs
let g:netrw_keepdir=1

" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='trash'

nnoremap <leader>fj :Explore %:h<cr>


""""""""""""""""""""""" }}}
" Ctrl-P                {{{
"""""""""""""""""""""""

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_mruf_last_entered = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
let g:ctrlp_use_caching = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_mruf_exclude = '\v\.git/(MERGE_MSG|rebase-merge|COMMIT_EDITMSG|PULLREQ_EDITMSG|index)'

nnoremap <leader>fp :CtrlP<cr>
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>bb :CtrlPBuffer<cr>
nnoremap <leader>bk :bdelete<cr>
nnoremap <leader>bt :CtrlPTag<cr>
nnoremap <leader>fr :CtrlPMRU<cr>


""""""""""""""""""""""" }}}
" Git                   {{{
"""""""""""""""""""""""

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Search for merge conflict markers
nnoremap <silent> <leader>sgc <ESC>/\v^[<=>]{7}( .*\|$)<CR>


""""""""""""""""""""""" }}}
" Ctags                 {{{
"""""""""""""""""""""""

let g:tagman_ctags_binary = "gtags"

" Let me select my tags
nnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>

" Open tag for word under cursor in a new vsplit
map <c-\> :vsp<CR>:exec("tag ".expand("<cword>"))<cr>



""""""""""""""""""""""" }}}
" All files             {{{
"""""""""""""""""""""""

function! SetHardWrap()
  setlocal textwidth=80 wrapmargin=0 formatoptions+=cqt
endfunction
command! SetHardWrap :call SetHardWrap()

function! SetNoHardWrap()
  setlocal formatoptions-=cqt
endfunction
command! SetNoHardWrap :call SetNoHardWrap()

augroup grass_allfiles
  autocmd!

  " Don't show trailing space in insert mode
  au InsertEnter * :set listchars-=trail:·
  au InsertLeave * :set listchars+=trail:·

  " Highlight TODOs
  au WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
  au WinEnter,VimEnter * :silent! call matchadd('Todo', 'DEBUG', -1)
  au WinEnter,VimEnter * :silent! call matchadd('Todo', 'XXX', -1)

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  autocmd BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " Write all buffers once I lose focus
  autocmd FocusLost * :silent! wall
augroup END

augroup grass_rainbowparens
  autocmd!

  au VimEnter * RainbowParenthesesActivate
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
augroup END

" Avoid red so I can easily see mismatched parens
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'chartreuse3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkblue',    'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'DarkGoldenrod'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'DarkGoldenrod'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkyellow',  'SlateBlue1'],
    \ ]


""""""""""""""""""""""" }}}
" HTML and Markdown     {{{
"""""""""""""""""""""""

function! ExtendMarkdownSyntax()
  " Highlight bare urls in markdown
  hi def link RGBareURL markdownUrl
  match RGBareURL /[^(]https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
endfun

augroup grass_html
  autocmd!

  "override .md for markdown instead of modula2
  au BufNewFile,BufRead *.md set filetype=markdown

  au BufNewFile,BufRead *.md :call ExtendMarkdownSyntax()

  au FileType html setlocal foldmethod=manual

  " match (:),[:],{:} in html
  au FileType html,eruby let b:match_words = '(:),[:],{:},' . b:match_words

  " Fold current html tag
  au FileType html nnoremap <buffer> <leader>z Vatzf

  " Indent current tag
  au FileType html,eruby nnoremap <buffer> <leader>e= Vat=

  " Change tab width and wrap for markdown
  au FileType markdown setlocal wrap softtabstop=4 tabstop=4 shiftwidth=4

  " Preview markdown files in Marked.app
  au FileType markdown nnoremap <buffer> <leader>mp :silent !open -a 'Marked 2.app' '%:p'<cr>
augroup END

" Highlight fenced code
let g:markdown_fenced_languages = ['ruby', 'javascript', 'clojure', 'json', 'sql']

" Disable useless HTML5 stuff
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0


""""""""""""""""""""""" }}}
" XML                   {{{
"""""""""""""""""""""""

augroup grass_xml
  au!

  au FileType xml setlocal foldmethod=manual

  " Reformat XML files
  au FileType xml noremap <buffer> <leader>ef <Esc>:% !xmllint --format -<CR>

  " Use <localleader>z to fold the current tag.
  au FileType xml nnoremap <buffer> <leader>z Vatzf

  " Indent current tag
  au FileType xml nnoremap <buffer> <leader>= Vat=
augroup END


""""""""""""""""""""""" }}}
" Clojure               {{{
"""""""""""""""""""""""

function! JumpToClojureSymbolWithoutNamespace()
  let wordUnderCursor = expand("<cword>")
  let symbol = matchstr(wordUnderCursor, '\(.*/\)\?\zs[^\/]\+\ze')
  if !empty(symbol)
    execute 'try | tjump ' . symbol . '| catch | echom ''Could not find tag ' . symbol . ''' | endtry'
  endif
endfunction

augroup grass_clojure
  autocmd!

  autocmd filetype clojure setlocal wildignore+=classes
  autocmd filetype clojure setlocal wildignore+=lib

  autocmd filetype clojure silent! call TurnOnClojureFolding()

  " Eval and print top level form and return cursor to where it was (outer)
  autocmd filetype clojure nnoremap <buffer> <leader>mo :normal cpaF``<cr>

  " Eval and print current form and return cursor to where it was (inner)
  autocmd filetype clojure nnoremap <buffer> <leader>mi :normal cpaf``<cr>

  " Eval and print current element and return cursor to where it was (element)
  autocmd filetype clojure nnoremap <buffer> <leader>me :normal cpie``<cr>

  " Eval and print current element and return cursor to where it was
  autocmd filetype clojure nnoremap <buffer> <leader>ma :%Eval<cr>

  " Better ctag matching
  autocmd filetype clojure nnoremap <buffer> <c-]> :call JumpToClojureSymbolWithoutNamespace()<CR>
augroup END

let g:clojure_fold_extra = [
            \ 'defgauge',
            \ 'defmeter',
            \ 'defhistogram',
            \ 'defcounter',
            \ 'deftimer',
            \
            \ 'defdb',
            \ 'defentity',
            \ 'defaspect',
            \ 'add-aspect',
            \ 'defmigration',
            \
            \ 'defsynth',
            \ 'definst',
            \ 'defproject',
            \
            \ 'defroutes',
            \
            \ 'defrec',
            \
            \ 'defparser',
            \
            \ 'defform',
            \ 'defform-',
            \
            \ 'defpage',
            \ 'defsketch'
            \
            \ ]

let g:clojure_syntax_keywords = {
    \ 'clojureMacro': [
            \ 'defproject',
            \ 'defcustom',
            \ 'defparser',
            \ 'deftest',
            \ 'match',
            \
            \ 'defproject',
            \
            \ 'defquery',
            \ 'defqueries',
            \
            \ 'defform',
            \
            \ 'deferror',
            \ 'when-found',
            \ 'when-valid',
            \
            \ 'defroutes',
            \ ],
    \ 'clojureFunc': ['string/join', 'string/replace']
    \ }



""""""""""""""""""""""" }}}
" Ruby                  {{{
"""""""""""""""""""""""

augroup grass_ruby
  autocmd!

  " Arb
  autocmd BufNewFile,BufRead *.arb set filetype=ruby

  " No comment extending with open
  au FileType ruby setlocal formatoptions-=o
augroup END

let ruby_fold = 1

let g:blockle_mapping = '<leader>m['


" Some Test helpers

map <Leader>. :call VimuxRunLastCommand()<CR>

map <Leader>tr :call VimuxRunCommand("be rspec " . bufname("%"))<CR>
map <Leader>tar :call VimuxRunCommand("be rspec")<CR>

map <Leader>tj :call VimuxRunCommand("./node_modules/.bin/jest " . bufname("%"))<CR>
map <Leader>taj :call VimuxRunCommand("./node_modules/.bin/jest")<CR>


" Run a given vim command on the results of alt from a given path.
" See usage below.
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" Find the alternate file for the current path and open it
nnoremap <leader>, :w<cr>:call AltCommand(expand('%'), ':e')<cr>

""""""""""""""""""""""" }}}
" Lisp                  {{{
"""""""""""""""""""""""

augroup grass_lisps
  autocmd!

  autocmd filetype lisp,scheme setlocal foldmethod=marker
augroup END

let g:paredit_mode = 0
let g:paredit_disable_clojure = 1
let g:paredit_electric_return = 0


""""""""""""""""""""""" }}}
" Vagrant               {{{
"""""""""""""""""""""""

augroup grass_vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set ft=ruby
augroup END


""""""""""""""""""""""" }}}
" Javascript and Coffee {{{
"""""""""""""""""""""""

let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

augroup grass_js
  autocmd!

  " Setup JSON files
  autocmd BufNewFile,BufRead *.json set ft=json

  " Reformat JSON
  autocmd FileType json noremap <buffer> <leader>ef <Esc>:% !js-beautify -f - -s 2 --brace-style=expand<CR>

  " Undo vim-coffeescript screwing with my formatoptions and keep manual folding
  autocmd BufNewFile,BufReadPost *.coffee setlocal foldmethod=manual formatoptions-=o iskeyword=@,39,48-57,_,192-255,$

  " Some plugin is messing with this so undo their work
  autocmd FileType javascript setlocal formatoptions-=o
augroup END


""""""""""""""""""""""" }}}
" Vimscript             {{{
"""""""""""""""""""""""

augroup ft_vim
  au!

  au FileType help setlocal textwidth=78
  au FileType vim setlocal foldmethod=marker

  " Help windows big on the right
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END


""""""""""""""""""""""" }}}
" Misc file types       {{{
"""""""""""""""""""""""

augroup grass_miscfiles
  autocmd!

  " Set wrap and shift size for text files
  autocmd BufRead,BufNewFile *.txt setlocal wrap tabstop=4 softtabstop=4 shiftwidth=4

  " In Makefiles, use real tabs, not tabs expanded to spaces
  autocmd FileType make set noexpandtab

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Less
  autocmd BufNewFile,BufRead *.less set filetype=less
augroup END

" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"


""""""""""""""""""""""" }}}
" Shortcut commands     {{{
"""""""""""""""""""""""

" Edit hot files
command! Myrc :normal :edit $MYVIMRC<cr>
command! Notes :normal :silent! :CtrlP ~/Dropbox/Notes<cr>

nnoremap <leader>ki :Myrc<CR>
nnoremap <leader>kn :Notes<CR>
nnoremap <leader>kw :edit ~/Dropbox/Notes/Journals/Work.org<CR>
nnoremap <leader>kp :edit ~/Dropbox/Notes/Journals/Personal.org<CR>

""""""""""""""""""""""" }}}
" Snippets              {{{
"""""""""""""""""""""""

" <c-j> and <c-k> for moving through placeholders
let g:UltiSnipsSnippetDirectories    = ["UltiSnips", "mysnippets"]

" Overcome Vundle runtime path so snippet overrides work
let g:UltiSnipsDontReverseSearchPath = "1"


""""""""""""""""""""""" }}}
" Yank-Ring             {{{
"""""""""""""""""""""""

let g:yankring_replace_n_pkey = '<c-q>'
let g:yankring_history_file = '.yankring_history_file'
function! YRRunAfterMaps()
  nnoremap <silent> Y  :<C-U>YRYankCount 'y$'<CR>
endfunction
let g:yankring_clipboard_monitor=0

""""""""""""""""""""""" }}}
" Wordy                 {{{
"""""""""""""""""""""""

let g:wordy#ring = [
  \ 'weak',
  \ ['being', 'passive-voice', ],
  \ 'weasel',
  \ ['problematic', 'redundant', ],
  \ ['colloquial', 'idiomatic', 'similies', ],
  \ ]

nnoremap <silent> <F11> :NextWordy<cr>

""""""""""""""""""""""" }}}
" Mouse and terminal    {{{
"""""""""""""""""""""""

set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

set mouse=nicra " Allow mouse scrolling in terminal
" Allow mouse selection in tmux
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
  " Get <C-up> et al. working in tmux terminal
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

let g:tmux_navigator_save_on_switch = 2

" Change cursor shape
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

""""""""""""""""""""""" }}}
" GUI                   {{{
"""""""""""""""""""""""

" Toggle indent guides
noremap <leader>ui :IndentGuidesToggle<cr>

" Show the syntax group in place on the text under the cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

if has("gui_running")
  " Show my current line
  set cursorline

  " No left scrollbar
  set guioptions-=l
  set guioptions-=L

  " No toolbar
  set guioptions-=T

  " Hide mouse after chars typed
  set mousehide

  highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

if has("gui_macvim")
  let g:airline#extensions#tabline#enabled = 0

  set guifont=Operator\ Mono\ Book:h13

  " Automatically resize splits when resizing MacVim window
  augroup grass_gui
    autocmd!

    autocmd VimResized * wincmd =
  augroup END

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Hide some menus
  silent! aunmenu T&hemes
  silent! aunmenu Plugin
endif

