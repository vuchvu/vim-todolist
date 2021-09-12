" todo-list.vim - create todo-list with Vim
" Maintainer: vuchvu
" Version: 0.1

if exists('g:loaded_todorules')
	finish
endif

let g:loaded_todorules=1

command! FixLine
			\ call todolist#FixLine()
command! FixLinesAll
	 		\ call todolist#FixLinesAll()
command! NewTodo
	 		\ call todolist#NewTodo()
command! NewLine
	 		\ call todolist#NewLine()
command! CheckToggle
	 		\ call todolist#CheckToggle()
command! ReplaceLineAll
	 		\ call todolist#ReplaceLinesAll()
