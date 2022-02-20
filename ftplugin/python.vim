let g:slime_cell_delimiter = "#%%"

function! NextChunk(pattern) range
    let rg = range(a:firstline, a:lastline)
    let chunk = len(rg)
    for var in range(1, chunk)
        let i = search(a:pattern, "nW")
        if i == 0
            return
        else
            call cursor(i+1, 1)
        endif
    endfor
    return
endfunction

function! PrevChunk(pattern) range
    let rg = range(a:firstline, a:lastline)
    let chunk = len(rg)
    for var in range(1, chunk)
        let curline = line(".")
        let i = search(a:pattern, "bnW")
        if i != 0
            call cursor(i-1, 1)
        endif
        let i = search(a:pattern, "bnW")
        if i == 0
            call cursor(curline, 1)
            return
        else
            call cursor(i+1, 1)
        endif
    endfor
    return
endfunction

au FileType python nnoremap <silent> <buffer> ]] :call NextChunk("^[ \t]*#%%")<CR>
au FileType python nnoremap <silent> <buffer> [[ :call PrevChunk("^[ \t]*#%%")<CR>

