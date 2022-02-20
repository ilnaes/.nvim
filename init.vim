let mapleader = ','
" let g:ale_disable_lsp = 1

let g:polyglot_disabled = ["markdown", "autoindent"]

call plug#begin()
  Plug 'vim-airline/vim-airline',

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim',
  Plug 'tpope/vim-commentary',
  Plug 'sheerun/vim-polyglot',
  " Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  Plug 'dense-analysis/ale', { 'for': ['go', 'rust', 'python', 'c', 'cpp', 'javascript', 'typescript', 'typescriptreact', 'json', 'rmd', 'r'] },
  " Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['python', 'typescript', 'javascript' ]},

  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' },
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'},
  Plug 'jpalardy/vim-slime',
call plug#end()

colorscheme cobalt2

syntax enable
filetype plugin on
autocmd FileType rmd source ~/.config/nvim/ftplugin/r.vim

autocmd FileType c,cpp,go setlocal commentstring=//\ %s
autocmd FileType go,r,rmd inoremap <buffer> <C-n> <C-x><C-o>

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
nmap <C-L><C-L> <Plug>SlimeLineSend
nmap <C-P><C-P> <Plug>SlimeParagraphSend
nmap <C-C><C-C> <Plug>SlimeSendCell

" set statusline+=%{gutentags#statusline()}

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
    \ 'c': ['clang-format'],
    \ 'cpp': ['clang-format'],
    \ 'go': ['goimports'],
    \ 'python': ['black', 'isort'],
    \ 'rust': ['rustfmt'],
    \ 'javascript': ['prettier'],
    \ 'typescript': ['prettier'],
    \ 'typescriptreact': ['prettier'],
    \ 'json': ['prettier'],
    \ 'html': ['prettier'],
    \ 'rmd': ['styler'],
    \ 'r': ['styler'],
    \}

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \ 'c': ['clang'],
    \ 'cpp': ['clang'],
    \ 'go': ['go vet'],
    \ 'python': ['pyflakes'],
    \ 'rust': ['analyzer'],
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint'],
    \ 'typescriptreact': ['eslint'],
    \ 'rmd': ['languageserver'],
    \ 'r': ['languageserver'],
    \}

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_section_y = ''
let g:airline_section_warning = ''
let g:airline_section_z = '%3p%% %3l/%L:%3v'

function! ToggleQuickFix()
  if exists("g:qwindow")
    lclose
    unlet g:qwindow
  else
    try
      lopen 10
      let g:qwindow = 1
    catch 
      echo "No Errors found!"
    endtry
  endif
endfunction

" open file in previous position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

inoremap <expr> <cr> ((pumvisible())?("\<C-y>"):("\<cr>"))

nnoremap <C-e> :call ToggleQuickFix()<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>a :Rg<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap ; :
noremap <Leader>y "*y
noremap <Leader>p "*p
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
noremap <Leader>h :noh<CR>

:command Q bd

set backspace=indent,eol,start
set vb                      " show visual bell instead of beeping
set noshowmode
set whichwrap=h,l,<,>,[,]   " wrap around line
set wildmenu                " have autocomplete on commands
set hlsearch                " highlight search term
set scrolloff=1             " keep context while scrolling
set title                   " show title
set ruler                   " show ruler
set wrapscan                " search wraps around file
set ttyfast                 " smoother changes
set showmatch               " show matching (), [], {}
set mouse=a
set expandtab               " convert tabs to spaces
set autoindent
set autoread                " reload if file on disk changes
set shortmess+=c            " no autocomplete messages
set hidden
set updatetime=500
set noshowcmd
set guicursor=

set signcolumn=yes
set tabstop=4
set shiftwidth=4
set number

autocmd FileType tex,c,ocaml,r,rmd,cpp,javascript,typescript setlocal shiftwidth=2 tabstop=2
