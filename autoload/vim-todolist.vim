" todo-list.vim - create todo-list with Vim
" Maintainer: vuchvu
" Version: 0.1

" 下の行に新しいタイトルを追加する
function! todolist#NewTodo() abort
	call append('.',['','▷', '□├最終目標', '□│├'])
endfunction

" 下の行に新しい項目を追加する
function! todolist#NewLine() abort
	call append('.', '□├')
	execute ":" line('.') + 1
endfunction

" 今の行の完了状態を切り替える
function! todolist#CheckToggle() abort
	if match(getline('.'), '□')==0
		execute ":s/□/■/e"
	elseif match(getline('.'), '■')==0
		execute ":s/■/□/e"
	endif
endfunction

" 上の行の罫線を修正する
function! todolist#FixLine() abort
	" ├の右隣に罫線が続く場合は
	" ├を│に置き換える
	let s:line = line('.')
	while match(getline(s:line - 1), '├├') > -1
		execute ":" s:line - 1 "s/├/│/e | :" s:line
	endwhile

	" │の下の行に罫線が続かない場合は
	" │を全角スペースに置き換える
	let s:sepaLen = len('│')
	let s:col1 = matchend(getline(s:line - 2), '│*├') != -1 ?
				\ matchend(getline(s:line - 2), '│*├') : 0
	let s:col2 = matchend(getline(s:line - 1), '│*├') != -1 ?
				\ matchend(getline(s:line - 1), '│*├') : 0
	let s:col3 = matchend(getline(s:line), '│*├') != -1 ?
				\ matchend(getline(s:line), '│*├') : 0
	let s:str = ''
	if s:col1 != 0
		if (s:col2 - s:col1)/s:sepaLen >= 1
			for i in range(1, (s:col2 - s:col1)/s:sepaLen)
				let s:str .= '│'
			endfor
		endif
	endif
	if s:col3 != 0
		if (s:col2 - s:col3)/s:sepaLen >= 2
			for i in range(2, (s:col2 - s:col3)/s:sepaLen)
				let s:str .= '　'
			endfor
		endif
	endif
	if len(s:str) > 0
		execute ":" s:line -1 "s/│*├/". s:str ."├/e | :" s:line
	endif

	" ├の右隣と下の行に罫線が続かない場合は
	" ├を└に置き換える
	let s:col2 = matchend(getline(s:line -1), '├\+')
	let s:col3 = matchend(getline(s:line), '├\+')
	if s:col2 > s:col3
		execute ":" s:line -1 "s/├/└/e | :" s:line
	endif
endfunction

" 全ての罫線を修正する
function! todolist#FixLinesAll() abort
	for i in range(2,line('$'))
		execute ":" i
		call todolist#FixLine()
	endfor
endfunction

" 全ての罫線を├に置き換える
function! todolist#ReplaceLinesAll() abort
	execute ":%s/│/├/ge"
	execute ":%s/└/├/ge"
endfunction
