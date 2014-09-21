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


Fussbudget defines no mappings, so use whatever you want. I use the following so Fussbudget is run every time I indent the whole file:

```map gg=G gg0=G :call Fussbudget::align()<CR>
```

BEWARE: The `0` in `gg0=G` is very important. Even though it doesn't do anything as you'll already be in this position, it differentiates the command from `gg=G` so you don't get stuck in an infinite loop. If anyone knows of a nicer way to achieve this mapping, please let me know!

This plugin is still in its very early stages and I'm by no means an expert, or even proficient, in Vimscript, so please let me know if you encounter any problems.
