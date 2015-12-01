# clojure-fussbudget

To help you with the pointless things you fuss over endlessly when formatting your clojure code.

Currently Fussbudget supports one command, `Fussbudget::align()`, which properly lines up all the `:refer`, `:only`, and `:as` lines in the current file's `ns` definition, like this:

```clojure
;; Before
(ns user
  (:require [user.system             :refer :all]
            [example.system                     :refer [new-api-system]]
            [clojure.tools.namespace.repl :refer [refresh]]
            [com.stuartsierra.component :as component]))

;; After
(ns user
  (:require [user.system                  :refer :all]
            [example.system               :refer [new-api-system]]
            [clojure.tools.namespace.repl :refer [refresh]]
            [com.stuartsierra.component   :as component]))
```


Fussbudget defines no mappings, so use whatever you want. I use the following:

```
function! CleanupWhitespace()
  try
    exec ':%s/\s\+$//g'
  catch "E486: Pattern not found: \s\+$"
  endtry
endfunction

autocmd Filetype clojure map <leader>c :call CleanupWhitespace() \| :call Fussbudget()<CR>
```
