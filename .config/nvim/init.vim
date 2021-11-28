" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'osyo-manga/vim-anzu'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-surround'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': 'v1.25' }
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'yuezk/vim-js'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'mileszs/ack.vim'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'

call plug#end()

" set termguicolors
" set nocompatible   " Disable vi-compatibility
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
" set smarttab
set cindent

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd Filetype gitcommit setlocal spell textwidth=72

"go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
set matchpairs+=<:>
set hlsearch

" let g:solarized_termcolors=256
" set background=dark
colorscheme gruvbox
color gruvbox

" Git diff color sets
hi DiffAdd      gui=none    guifg=NONE          guibg=#bada9f
hi DiffChange   gui=none    guifg=NONE          guibg=#e5d5ac
hi DiffDelete   gui=bold    guifg=#ff8080       guibg=#ffb0b0
hi DiffText     gui=none    guifg=NONE          guibg=#8cbee2

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

let mapleader = '\'

" NERD tree
let NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', 'node_modules', '.git', '_build']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
let NERDTreeShowHidden=1

let g:go_auto_sameids = 1
let g:go_auto_type_info = 1

" let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Automatically open a NERDTree if no files where specified
" autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Open a NERDTree
nmap <F5> :NERDTreeToggle<cr>
map <C-F> :Ack<Space>

let g:AutoPairsShortcutFastWrap   = '´' " <m-m>
let g:AutoPairsShortcutToggle     = 'π' " <m-p>
let g:AutoPairsShortcutJump       = '∆' " <m-j>
let g:AutoPairsShortcutBackInsert = '∫' " <m-b>
let g:AutoPairsMapCR=0

" Lightline
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Fugitive/Git mappings
map ,gs :Gstatus<CR>
map ,gpl :Git pull<CR>
map ,gpr :Git pull --rebase<CR>
map ,gpu :Git push<CR>
map ,gdi :Git diff<CR>
map ,gdc :Git diff --cached<CR>
map ,ga :update \| Git add %<CR>

" Mappings for numbering
map ,nr :set rnu!<CR>
map ,na :set nu!<CR>

" Ctrl-Shift-F for Ag
map <C-F> :Ack<Space>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
vnoremap // y/<C-R>"<CR>
" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

if has("unix")
  nnoremap <C-n> :tabnew<CR><Esc>
  nnoremap <C-b> :tabclose<CR>
endif

" Make <leader>' switch between ' and "
nnoremap ,' ""yls<C-r>={'"': "'", "'": '"'}[@"]<CR><Esc>

" Hashrocket with <C-l>
imap <C-l> <space>=><space>

noremap H ^
noremap L $

" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

" Set up fzf
map ,f :Files<CR>
map ,gf :GFiles<CR>
set rtp+=/usr/local/opt/fzf

" statusline
set statusline=%{anzu#search_status()}

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let $FZF_DEFAULT_COMMAND = 'ag -g "" --ignore {".beam"}'
endif

