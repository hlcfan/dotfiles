syntax on
filetype plugin indent on

" {{{ Plug List
call plug#begin('~/.vim/bundle')
" Plug 'tpope/vim-pathogen'
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
" Plug 'tssm/fairyfloss.vim'
" Plug 'endel/vim-github-colorscheme'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-rails'
" Plug 'vim-ruby/vim-ruby'
Plug 'fatih/vim-go', { 'tag': 'v1.25', 'do': ':GoUpdateBinaries' }
" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
" Plug 'ervandew/supertab'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'henrik/vim-reveal-in-finder'
Plug 'osyo-manga/vim-anzu'
Plug 'thoughtbot/vim-rspec'
Plug 'mileszs/ack.vim'
" Plug '/usr/bin/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
"Extra plugins
runtime! plugin/matchit.vim
runtime! macros/matchit.vim
call plug#end()
" }}}

set termguicolors
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
set smarttab
set cindent

" swap files
set backup
set noswapfile
set undodir=~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/backup
set maxmempattern=5000

" Give more space for displaying messages.
set cmdheight=2

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

if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
set matchpairs+=<:>
set hlsearch

" let g:solarized_termcolors=256
set background=dark
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

" let g:polyglot_disabled = ['go']
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_auto_type_info = 0
" let g:go_auto_sameids = 0
" let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']

" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

" let g:go_metalinter_autosave = 1

" let g:go_metalinter_deadline = "5s"
" let g:go_fmt_command = "goimports"

" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'
"
" let g:go_rename_command = 'gopls'

" let g:go_list_autoclose = 0
" let go_debug=['shell-commands']

"" let g:go_jump_to_error = 0

let g:javascript_plugin_jsdoc = 1

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

let g:rubycomplete_rails = 1
let g:rails_default_file='config/database.yml'
" Change which file opens after executing :Rails command

let g:AutoPairsShortcutFastWrap   = '´' " <m-m>
let g:AutoPairsShortcutToggle     = 'π' " <m-p>
let g:AutoPairsShortcutJump       = '∆' " <m-j>
let g:AutoPairsShortcutBackInsert = '∫' " <m-b>
let g:AutoPairsMapCR=0


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

"javascript
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

"improve autocomplete menu color
" highlight Pmenu ctermbg=gray gui=bold
" highlight PmenuSel ctermbg=238 gui=bold

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

let g:rspec_command = "bundle exec rspec {spec}"

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
" let g:rspec_command = "!rspec --drb {spec}"

" NERD tree
let NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
let NERDTreeShowHidden=1

" Automatically open a NERDTree if no files where specified
" autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Open a NERDTree
nmap <F5> :NERDTreeToggle<cr>

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
  if has("mac")
    nnoremap ˜ :tabnew<CR><Esc>
    nnoremap ∑ :tabclose<CR>
  else
    nnoremap <C-n> :tabnew<CR><Esc>
    nnoremap <C-b> :tabclose<CR>
  endif
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
  let g:ackprg = 'ag --vimgrep'
  let $FZF_DEFAULT_COMMAND = 'ag -g "" --ignore {".beam"}'
endif

"}}}

