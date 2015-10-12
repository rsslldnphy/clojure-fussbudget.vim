let s:indent_point_pattern = ':as \|:exclude \|:refer-macros \|:refer '

function! s:find_ns_definition()
  try
    execute "normal! gg/(ns \<CR>"
    let starting_line = line('.')
    execute "normal! %"
    let ending_line = line('.')
    return [starting_line, ending_line]
  catch "E486: Pattern not found: (ns"
    return [0, 0]
  endtry
endfunction

function! s:required_indentation(starting_line, ending_line)
  let lines       = getline(a:starting_line, a:ending_line)
  let matches     = filter(lines, 'v:val =~ ''' . s:indent_point_pattern . '''')
  let indentation = 0
  for m in matches
    let indentation = max([indentation, match(m, '\s*\(' . s:indent_point_pattern . '\)')])
  endfor
  return indentation + 2
endfunction

function! Fussbudget#align()
  let ns_bounds     = s:find_ns_definition()
  let starting_line = ns_bounds[0]
  let ending_line   = ns_bounds[1]
  if ! ending_line | return | endif
  let indentation   = s:required_indentation(starting_line, ending_line)
  for linenum in range(starting_line, ending_line)
    " " for linenum in range(starting_line, starting_line + 2)
    let current_line = getline(linenum)
    if current_line =~ s:indent_point_pattern
      execute "normal! " . linenum . "gg:s/" . '\s\+/ /g' . "\<CR>=="
      execute "normal! 0/" . s:indent_point_pattern . "\<CR>"
      let delta = indentation - virtcol('.')
      if delta > 0
        execute "normal! " . delta . "i\<space>\<esc>"
      elseif delta < 0
        execute "normal! bel" . abs(delta) . "x"
      endif
    endif
  endfor
endfunction
