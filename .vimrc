set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
execute pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

" {{{ Plugin List
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin '907th/vim-auto-save'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-vinegar'
" Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'wakatime/vim-wakatime'
Plugin 'junegunn/vim-easy-align'
" }}}

"Extra plugins
runtime! plugin/matchit.vim
runtime! macros/matchit.vim

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=2
" 设置格式化时制表符占用空格数
set shiftwidth=2
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=2
set number
" Add recently accessed projects menu (project plugin)
set viminfo^=!
set wildignore+=.hg,.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.sw?
set wildignore+=*.DS_Store?
set wildignore+=vendor/bundle
set wildignore+=vendor/gems
set wildignore+=log/**
set wildignore+=node_modules/**
set autochdir

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:rubycomplete_rails = 1
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:airline#extensions#tabline#enabled = 1
" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
" let g:ctrlp_working_path_mode = 0

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

" Mappings for numbering
map ,nr :set rnu!<CR>
map ,na :set nu!<CR>
" Ctrl-Shift-F for Ag
map <C-F> :Ag<Space>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" File type setup for files unknown to Vim {{{
if has("autocmd")
    "File types and stuff
    au BufRead,BufNewFile {GemFile,Rakefile,VagrantFile,Thorfile,config.ru} set ft=ruby
    au BufRead,BufNewFile *.thor set ft=ruby
    au BufRead,BufNewFile *.god set ft=ruby
    au BufRead,BufNewFile *.json set ft=javascript
    au BufRead,BufNewFile *.jasmine_fixture set ft=html
endif
"}}}
