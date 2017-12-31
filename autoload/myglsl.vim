
let myglsl#sequence = ['vert', 'geom', 'frag']

let myglsl#shaderTypeDict = {
      \ 'vert' : ['vs', 'vert'],
      \ 'geom' : ['gs', 'geom'],
      \ 'frag' : ['fs', 'frag']
      \ }

function! s:getShaderType(name) abort
  for [type, values] in items(g:myglsl#shaderTypeDict)
    for value in values
      if value == a:name
        return type
      endif
    endfor
  endfor
  return ''
endfunction

function! myglsl#alternate() abort
  let filename = expand('%:t')
  let dir = expand('%:h')

  let names = split(filename, '\.')

  if len(names) == 1
    echom printf('illegal filename %s', filename)
    return
  elseif len(names) == 2 " assume name.vs
    let type = names[1]
    let prefix = names[0] . '.'
    let postfix = ''
  else
    let type = names[-2]
    let prefix = join(names[0:-3], '.') . '.'
    let postfix = '.' . names[-1]
  endif

  let type = s:getShaderType(type)
  if type ==# ''
    echom printf('illegal filename %s', filename)
    return
  endif

  let idx = index(g:myglsl#sequence, type)
  let nextIdx = (idx+1)%len(g:myglsl#sequence)

  while nextIdx != idx
    let nextType = g:myglsl#sequence[nextIdx]

    for name in g:myglsl#shaderTypeDict[nextType]
      let altFilename = printf('%s%s%s', prefix, name, postfix)
      let altPath = printf('%s/%s', dir, altFilename)
      if filereadable(altPath)
        exec printf('edit %s', altPath)
        return 1
      endif
    endfor
    let nextIdx = (nextIdx+1)%len(g:myglsl#sequence)

  endwhile

  return 0
endfunction
