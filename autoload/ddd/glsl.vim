
let s:sequence = ['vert', 'geom', 'frag']

let s:alias = {
      \ 'vert' : ['vs', 'vert'],
      \ 'geom' : ['gs', 'geom'],
      \ 'frag' : ['fs', 'frag']
      \ }

function s:get_shader_type(name) abort
  for [type, values] in items(g:s:alias)
    for value in values
      if value == a:name
        return type
      endif
    endfor
  endfor
  return ''
endfunction

function ddd#glsl#alternate() abort
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

  let type = s:get_shader_type(type)
  if type ==# ''
    echom printf('illegal filename %s', filename)
    return
  endif

  let idx = index(s:sequence, type)
  let next_idx = (idx+1)%len(s:sequence)

  while next_idx != idx
    let next_type = s:sequence[next_idx]

    for name in g:s:alias[next_type]
      let alt_filename = printf('%s%s%s', prefix, name, postfix)
      let alt_path = printf('%s/%s', dir, alt_filename)
      if filereadable(alt_path)
        exec printf('edit %s', alt_path)
        return 1
      endif
    endfor
    let next_idx = (next_idx+1)%len(s:sequence)

  endwhile

  return 0
endfunction
