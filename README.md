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


I have it mapped to `<leader>f` but the plugin itself defines no mappings so you can use whatever you like.

This plugin is still in its very early stages and I'm by no means an expert, or even proficient, in Vimscript, so please let me know if you encounter any problems.
