# clojure-fussbudget

To help you with the pointless things you fuss over endlessly when formatting your clojure code.

Currently Fussbudget supports one command, Fussbudget::align(), which properly lines up all the `:refer`, `:only`, and `:as` lines in the current file's `ns` definition.

Have the function run on entering a Clojure file by adding the below into you .vimrc:

```vimL
  autocmd BufRead *.erl call Fussbudget::align()
```
