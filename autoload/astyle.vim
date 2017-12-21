" エンコーディング指定
scriptencoding utf-8

" ロード済みでなければ終了する
if !exists('g:loaded_astyle_vim')
    finish
endif

" ユーザ設定を一時退避
let s:save_cpo = &cpoptions
set cpoptions&vim

function! astyle#format_code(mode)

    let l:option_file = astyle#find_option_file(a:mode)

    if l:option_file != ""
        let $ASTYLE_VIM_OPTION_FILE = l:option_file
        !astyle --options=${ASTYLE_VIM_OPTION_FILE} --suffix=none % 1>/dev/null 2>/dev/null
    endif

endfunction

function! astyle#find_option_file(mode)

    let l:file_name = ""

    if a:mode == "c"
        let l:file_name = "astyle_options_c"
    elseif a:mode == "csharp"
        let l:file_name = "astyle_options_csharp"
    elseif a:mode == "java"
        let l:file_name = "astyle_options_java"
    else
        return ""
    endif

    for l:dir in [".git/", "~/."]

        let l:option_file = l:dir . l:file_name
        if filereadable(l:option_file)
            return l:option_file
        endif

    endfor

    return ""

endfunction

" 退避していたユーザ設定を戻す
let &cpoptions = s:save_cpo
unlet s:save_cpo
