" todo-list.vim - create todo-list with Vim
" Maintainer: vuchvu
" Version: 0.2

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = 'todo'

let s:highlight = get(g:, 'todolist#highlight', 1)
let s:titleMark = get(g:, 'todolist#titleMark', '▷')

if s:highlight==1
	execute "syntax match TodoTitle /".s:titleMark.".\\{,}/"
	syntax match Target /.├最終目標.\{,}/
	syntax match Done /■.\{,}/
	
	let s:TodoTitle_highlight = get(g:, 'todolist#TodoTitle_highlight', 'StatusLine')
	let s:Target_highlight = get(g:, 'todolist#Target_highlight', 'VertSplit')
	let s:Done_highlight = get(g:, 'todolist#Done_highlight', 'SpecialKey')
	
	execute "highlight link TodoTitle" s:TodoTitle_highlight
	execute "highlight link Target" s:Target_highlight
	execute "highlight link Done" s:Done_highlight
endif
