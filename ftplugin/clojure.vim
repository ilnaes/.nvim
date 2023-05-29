function! Format()
    let save_pos = getpos(".")
    mkview
    silent exe "normal! gg=G"
    call setpos('.', save_pos)
    loadview
endfunction

nmap <buffer> <silent> \tt :lua require("util").send_form(0)<CR>
nmap <buffer> <silent> \cc :lua require("util").send_form(1)<CR>
nmap <buffer> <silent> \cp :lua require("util").send_form(2)<CR>

autocmd BufWritePre <buffer> call Format()

let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = "clojure -Arepl"

" :let g:conjure#client_on_load = v:false
