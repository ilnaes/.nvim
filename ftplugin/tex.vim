nnoremap J j
nnoremap K k

nnoremap <leader>gv :execute '!open ' . substitute(expand("%:r"), " ", "\\\\ ", "") . '.pdf'
nnoremap <leader>lp :w<CR>:execute '!latexmk -pdf -g -halt-on-error "' . expand("%") . '"'
nnoremap <leader>f :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR> <C-L><CR>

nnoremap <silent> <buffer> ]] :call NextCell("^\\\\\\(sub\\)*section")<CR>
nnoremap <silent> <buffer> [[ :call PrevCell("^\\\\\\(sub\\)*section")<CR>

" latex macros
iab ca<Bslash> \begin{cases}<NL>\end{cases}<ESC>O<BACKSPACE><SPACE>
iab pf<Bslash> \begin{proof}<NL>\end{proof}<ESC>O<BACKSPACE><SPACE>
iab mm<Bslash> \begin{align*}<NL>\end{align*}<ESC>O<BACKSPACE><SPACE>
iab ml<Bslash> \begin{multline*}<NL>\end{multline*}<ESC>O<BACKSPACE><SPACE>
iab ma<Bslash> \left(\begin{array}<NL>\end{array}\right)<ESC>kA
iab enn<Bslash> \begin{enumerate}[label=(\arabic*)]<NL>\end{enumerate}<ESC>O\item
iab ena<Bslash> \begin{enumerate}[label=(\alph*)]<NL>\end{enumerate}<ESC>O\item
iab it<Bslash> \begin{itemize}<NL>\end{itemize}<ESC>O\item
iab th<Bslash> \begin{theorem}<NL>\end{theorem}<ESC>O<BACKSPACE><SPACE>
iab pr<Bslash> \begin{proposition}<NL>\end{proposition}<ESC>O<BACKSPACE><SPACE>
iab co<Bslash> \begin{corollary}<NL>\end{corollary}<ESC>O<BACKSPACE><SPACE>
iab lm<Bslash> \begin{lemma}<NL>\end{lemma}<ESC>O<BACKSPACE><SPACE>
iab rm<Bslash> \begin{remark}<NL>\end{remark}<ESC>O<BACKSPACE><SPACE>

set signcolumn=no
set nonumber
setlocal commentstring=%\ %s | setlocal smartindent | setlocal nornu  | :NoMatchParen

function! SetServerName()
  if has('win32')
    let nvim_server_file = $TEMP . "/curnvimserver.txt"
  else
    let nvim_server_file = "/tmp/curnvimserver.txt"
  endif
  let cmd = printf("echo %s > %s", v:servername, nvim_server_file)
  call system(cmd)
endfunction

call SetServerName()
