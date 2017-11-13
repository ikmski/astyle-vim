" エンコーディング指定
scriptencoding utf-8

" 既にロード済みなら終了する
if exists('g:loaded_astyle_vim')
    finish
endif
let g:loaded_astyle_vim = 1

" ユーザ設定を一時退避
let s:save_cpo = &cpoptions
set cpoptions&vim

autocmd BufWritePost *.c,*.h     silent call astyle#format_code("c")
autocmd BufWritePost *.cpp,*.hpp silent call astyle#format_code("c")
autocmd BufWritePost *.cs        silent call astyle#format_code("csharp")
autocmd BufWritePost *.java      silent call astyle#format_code("java")

" 退避していたユーザ設定を戻す
let &cpoptions = s:save_cpo
unlet s:save_cpo
