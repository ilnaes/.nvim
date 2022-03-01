let g:slime_cell_delimiter = "#%%"
let b:cell_pattern = "^[ \t]*#%%"

au FileType python nnoremap <silent> <buffer> ]] :call NextCell(b:cell_pattern)<CR>
au FileType python nnoremap <silent> <buffer> [[ :call PrevCell(b:cell_pattern)<CR>
nmap \ca <Plug>SlimeSendCell \| :call NextCell(b:cell_pattern)<CR>
