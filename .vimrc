syntax on
filetype plugin indent on

" {{{ Plug List
call plug#begin('~/.vim/bundle')
" Plug 'tpope/vim-pathogen'
Plug 'altercation/vim-colors-solarized'
Plug 'endel/vim-github-colorscheme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug '907th/vim-auto-save'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-vinegar'
Plug 'rking/ag.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'wakatime/vim-wakatime'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'elixir-editors/vim-elixir'
Plug 'itchyny/lightline.vim'
"Extra plugins
runtime! plugin/matchit.vim
runtime! macros/matchit.vim
call plug#end()
" }}}

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
" Convert tabs to spaces
set expandtab
" Tab takes 2 columns
set tabstop=2
" Take 2 columns when format code
set shiftwidth=2
" Take 2 columns when hit tab
set softtabstop=2
" Display extra whitespace
set list listchars=tab:»·,trail:·
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
" Numbers
set number
set numberwidth=5
" set relativenumber
set ruler
set report=0

" swap files
set backup
set noswapfile
set undodir=~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/backup

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
set matchpairs+=<:>
set hlsearch
set background=dark
colorscheme solarized

color hlcfan

if ((&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700) || has("gui_running")
  set listchars=trail:·,precedes:«,extends:»,tab:▸-
  set showbreak=↪
else
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<
  set showbreak='+++ '
endif
set backspace=indent,eol,start "backspace over everything!
set guifont=Monospace\ 9

" Use 256 colors all the time
set t_Co=256
set showmatch "show matching pairs

" Don't show mode, as lightline integrated it
set noshowmode

" Highlight current line
" Without activate cursor column
au WinLeave * set nocursorline " nocursorcolumn
au WinEnter * set cursorline " cursorcolumn
set cursorline " cursorcolumn

" Add recently accessed projects menu (project plugin)
set viminfo^=!
set wildignore+=.hg,.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.sw?
set wildignore+=*.DS_Store?
set wildignore+=vendor/bundle
set wildignore+=vendor/gems
set wildignore+=vendor/ruby
set wildignore+=log/**
set wildignore+=node_modules/**
set autochdir

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:rubycomplete_rails = 1
" let g:auto_save = 1  " enable AutoSave on Vim startup
" let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
" Change which file opens after executing :Rails command

let g:AutoPairsShortcutFastWrap   = '´' " <m-m>
let g:AutoPairsShortcutToggle     = 'π' " <m-p>
let g:AutoPairsShortcutJump       = '∆' " <m-j>
let g:AutoPairsShortcutBackInsert = '∫' " <m-b>

let g:rails_default_file='config/database.yml'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_cmd = 'CtrlPMixed'

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" Set high visibility for diff mode
" let g:Powerline_symbols = 'unicode'
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline_theme = "dark"
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_symbols.branch = '⎇ '
" let g:airline_symbols.paste = 'ρ'
" let g:airline_mode_map = {
"             \ '__' : '-',
"             \ 'n'  : 'N',
"             \ 'i'  : 'I',
"             \ 'R'  : 'R',
"             \ 'c'  : 'C',
"             \ 'v'  : 'V',
"             \ 'V'  : 'V',
"             \ '' : 'V',
"             \ 's'  : 'S',
"             \ 'S'  : 'S',
"             \ '' : 'S',
"             \ }

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd Filetype gitcommit setlocal spell textwidth=72
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" alt+n or alt+p to navigate between entries in QuickFix
"map   :cp 
"map   :cn 
" Fugitive/Git mappings
map ,gs :Gstatus<CR>
map ,gpl :Git pull<CR>
map ,gpr :Git pull --rebase<CR>
map ,gpu :Git push<CR>
map ,gdi :Git diff<CR>
map ,gdc :Git diff --cached<CR>
map ,ga :update \| Git add %<CR>

" NERD tree
let NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
" Automatically open a NERDTree if no files where specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Open a NERDTree
nmap <F5> :NERDTreeToggle<cr>

" Mappings for numbering
map ,nr :set rnu!<CR>
map ,na :set nu!<CR>

" Ctrl-Shift-F for Ag
map <C-F> :Ag<Space>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
vnoremap // y/<C-R>"<CR>
" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

" Make <leader>' switch between ' and "
nnoremap ,' ""yls<C-r>={'"': "'", "'": '"'}[@"]<CR><Esc>

" Hashrocket with <C-l>
imap <C-l> <space>=><space>

noremap H ^
noremap L $

" File type setup for files unknown to Vim {{{
if has("autocmd")
    "File types and stuff
    au BufRead,BufNewFile {GemFile,Rakefile,VagrantFile,Thorfile,config.ru} set ft=ruby
    au BufRead,BufNewFile *.thor set ft=ruby
    au BufRead,BufNewFile *.god set ft=ruby
    au BufRead,BufNewFile *.json set ft=javascript
    au BufRead,BufNewFile *.jasmine_fixture set ft=html
endif

if executable('ag')
  " Use Ag over Grep
  let g:ag_working_path_mode="r"
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
  let g:ctrlp_use_caching = 0
endif

if executable('matcher')
  let g:ctrlp_match_func = { 'match': 'GoodMatch' }

  function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

    " Create a cache file if not yet exists
    let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
    if !( filereadable(cachefile) && a:items == readfile(cachefile) )
      call writefile(a:items, cachefile)
    endif
    if !filereadable(cachefile)
      return []
    endif

    " a:mmode is currently ignored. In the future, we should probably do
    " something about that. the matcher behaves like "full-line".
    let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
    if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
      let cmd = cmd.'--no-dotfiles '
    endif
    let cmd = cmd.a:str

    return split(system(cmd), "\n")

  endfunction
end
"}}}

