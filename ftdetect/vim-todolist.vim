" todo-list.vim - create todo-list with Vim
" Maintainer: vuchvu
" Version: 0.1

if did_filetype()
	finish
endif

augroup todo
	au!
	au BufRead,BufNewFile *.todo set filetype=todo
augroup END
