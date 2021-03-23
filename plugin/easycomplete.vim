" File:         easycomplete.vim
" Author:       @jayli <https://github.com/jayli/>
"               更多信息请访问 <https://github.com/jayli/vim-easycomplete>
"               帮助信息请执行
"                :helptags ~/.vim/doc
"                :h EasyComplete

if get(g:, 'easycomplete_plugin_init')
  finish
endif
let g:easycomplete_plugin_init = 1

if v:version < 802
  echom "EasyComplete requires vim version upper than 802"
  finish
endif

" augroup FileTypeChecking
"   let ext = substitute(expand('%p'),"^.\\+[\\.]","","g")
"   if ext ==# "ts"
"     finish
"   endif
" augroup END

if has('vim_starting')
  augroup EasyCompleteStart
    autocmd!
    autocmd BufReadPost * call easycomplete#Enable()
  augroup END
else
  call easycomplete#Enable()
endif

" Buildin Plugins
augroup EasyCompleteRegistSources
  call easycomplete#RegisterSource({
      \ 'name': 'buf',
      \ 'whitelist': ['*'],
      \ 'completor': 'easycomplete#sources#buf#completor',
      \ })

  call easycomplete#RegisterSource(easycomplete#sources#ts#getConfig({
      \ 'name': 'ts',
      \ 'whitelist': ['javascript','typescript','javascript.jsx'],
      \ 'completor': function('easycomplete#sources#ts#completor'),
      \ 'constructor' :function('easycomplete#sources#ts#constructor')
      \  }))

  call easycomplete#RegisterSource({
      \ 'name': 'directory',
      \ 'whitelist': ['*'],
      \ 'completor': function('easycomplete#sources#directory#completor'),
      \  })

  call easycomplete#RegisterSource({
      \ 'name': 'snips',
      \ 'whitelist': ['*'],
      \ 'completor': 'easycomplete#sources#snips#completor',
      \  })
augroup END
