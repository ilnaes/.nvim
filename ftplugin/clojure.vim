let skip = 'synIDattr(synID(line("."),col("."),1),"name") =~? "comment\\|string\\|char\\|regexp"'

function! Opfunc() abort
    let sel_save = &selection
    let cb_save = &clipboard
    let reg_save = @@
    try
        set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
        let open = '[[{(]'
        let close = '[]})]'
        if getline('.')[col('.')-1] =~# close
            let [line1, col1] = searchpairpos(open, '', close, 'bn', g:skip)
            let [line2, col2] = [line('.'), col('.')]
        else
            let [line1, col1] = searchpairpos(open, '', close, 'bcn', g:skip)
            let [line2, col2] = searchpairpos(open, '', close, 'n', g:skip)
        endif
        while col1 > 1 && getline(line1)[col1-2] =~# '[#''`~@]'
            let col1 -= 1
        endwhile
        call setpos("'[", [0, line1, col1, 0])
        call setpos("']", [0, line2, col2, 0])
        silent exe "normal! `[v`]y"
        return @@
    finally
        let @@ = reg_save
        let &selection = sel_save
        let &clipboard = cb_save
    endtry
endfunction


function! SendForm(num)
    let save_pos = getpos(".")
    let code = ""
    if a:num == 0
        let reg_save = @@
        call sexp#select_current_top_list('v', 0)
        silent exe "normal! y"
        let code = @@
        let @@ = reg_save
    else
        let code = Opfunc()
        let i = 1
        while i < a:num
            silent exe "normal! h"
            let code = Opfunc()
            let i += 1
        endwhile
    endif
    call slime#send(code . "\r")
    call setpos('.', save_pos)
endfunction

function! Format()
    let save_pos = getpos(".")
    mkview
    silent exe "normal! gg=G"
    call setpos('.', save_pos)
    loadview
endfunction

nmap <buffer> <silent> \tt :call SendForm(0)<CR>
nmap <buffer> <silent> \cc :<C-U>call SendForm(v:count1)<CR>
nmap <buffer> <silent> \cp :call SendForm(2)<CR>

autocmd BufWritePre <buffer> call Format()

let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = "clojure -Arepl"

" :let g:conjure#client_on_load = v:false
