let b:cell_pattern = "^```"

au FileType r,rmd nnoremap <silent> <buffer> ]] :call NextCell(b:cell_pattern)<CR>
au FileType r,rmd nnoremap <silent> <buffer> [[ :call PrevCell(b:cell_pattern)<CR>
