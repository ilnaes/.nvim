let g:slime_cell_delimiter = "#%%"

au FileType python nnoremap <silent> <buffer> ]] :call NextCell("^[ \t]*#%%")<CR>
au FileType python nnoremap <silent> <buffer> [[ :call PrevCell("^[ \t]*#%%")<CR>

