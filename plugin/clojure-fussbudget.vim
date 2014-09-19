function! Fussbudget::align()
  execute "normal! gg/(ns \<CR>"

  let starting_line    = line('.')
  let ending_line      = starting_line
  let opening_brackets = 0
  let closing_brackets = 0
  let max_indentation  = 0

  while opening_brackets != closing_brackets || opening_brackets == 0
    let current_line = getline('.')

    "" count brackets so we know when we're done
    let opening_brackets = opening_brackets + strlen(substitute(current_line, "[^(]", "","g"))
    let closing_brackets = closing_brackets + strlen(substitute(current_line, "[^)]", "","g"))

    "" if this line has a :refer :as or :only keyword, work out its
    "" indentation
    if current_line =~ ":refer" || current_line =~ ":as" || current_line =~ ":only"
      execute "normal! 0/\\%" . line('.') . "l\\(:refer\\|:as\\|:only\\)\<CR>be"
      let current_indentation = virtcol('.')
      if current_indentation > max_indentation
        let max_indentation = current_indentation
      endif
    endif

    normal! j
    let ending_line = ending_line + 1
  endwhile

  "" indent all the lines to the correct column
  for linenum in range(starting_line, ending_line)
    execute "normal! " . linenum . "gg"
    let current_line = getline(linenum)
    if current_line =~ ":refer" || current_line =~ ":as" || current_line =~ ":only"
      execute "normal! 0/\\%" . line('.') . "l\\(:refer\\|:as\\|:only\\)\<CR>"
      let indentation_difference = (max_indentation + 2) - virtcol('.')
      if indentation_difference > 0
        execute "normal! " . indentation_difference . "i \<esc>"
      elseif indentation_difference < 0
        execute "normal! " . abs(indentation_difference) . "i\<bs>\<esc>"
      endif
    endif
  endfor
  normal! j

endfunction
