call plug#begin()
  Plug 'vim-airline/vim-airline',

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim',
  Plug 'tpope/vim-commentary',
  Plug 'sheerun/vim-polyglot',
  " Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  Plug 'dense-analysis/ale', { 'for': ['go', 'rust', 'python', 'c', 'cpp', 'javascript', 'typescript', 'typescriptreact', 'json', 'rmd', 'r', 'clojure', 'lua'] },
  Plug 'jpalardy/vim-slime',
  " Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['python', 'typescript', 'javascript' ]},

  Plug 'Olical/conjure', { 'for': ['clojure', 'fennel'] },
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' },
  Plug 'guns/vim-sexp',

  Plug 'vimwiki/vimwiki',
  Plug 'windwp/nvim-autopairs',
call plug#end()

let NextCell = luaeval('require("util").next_cell')
let PrevCell = luaeval('require("util").prev_cell')
