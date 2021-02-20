
function! easycomplete#util#filetype()
  " SourcePost 事件中 &filetype 为空，应当从 bufname 中根据后缀获取
  " TODO 这个函数需要重写
  let filename = fnameescape(fnamemodify(bufname('%'),':p'))
  let ext_part = substitute(filename,"^.\\+[\\.]","","g")
  let filetype_dict = {
        \ 'js':'javascript',
        \ 'ts':'typescript',
        \ 'jsx':'javascript.jsx',
        \ 'tsx':'javascript.jsx',
        \ 'py':'python',
        \ 'rb':'ruby',
        \ 'sh':'shell'
        \ }
  if index(['js','ts','jsx','tsx','py','rb','sh'], ext_part) >= 0
    return filetype_dict[ext_part]
  else
    return ext_part
  endif
endfunction

" 运行一个全局的 Timer，只在 complete 的时候用
" method 必须是一个全局方法
" method, args
function! easycomplete#util#AsyncRun(...)

  let method = a:1
  let args = exists('a:2') ? a:2 : []
  let g:_easycomplete_popup_timer = timer_start(1, { -> easycomplete#util#call(method, args)})
  return g:_easycomplete_popup_timer
endfunction

function! easycomplete#util#StopAsyncRun()
  if exists('g:_easycomplete_popup_timer') && g:_easycomplete_popup_timer > 0
    call timer_stop(g:_easycomplete_popup_timer)
  endif
endfunction

function! easycomplete#util#call(method, args) abort
  try
    call call(a:method, a:args)
    let g:_easycomplete_popup_timer = -1
    redraw
  catch /.*/
    return 0
  endtry
endfunction

function! easycomplete#util#NotInsertMode()
  return mode()[0] != 'i' ? 1 : 0
endfunction

function! easycomplete#util#Sendkeys(keys)
  call feedkeys( a:keys, 'in' )
endfunction

function! s:log(msg)
  call easycomplete#log(a:msg)
endfunction