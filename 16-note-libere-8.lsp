===============

 NOTE LIBERE 8

===============

Un buon programmatore LISP cerca di utilizzare uno stile funzionale puro il più possibile usando funzioni con effetti-collaterali (side-effect) con parsimonia (il minimo indispensabile).

McCarthy (l'inventore originale di LISP) ha dimostrato che qualsiasi algoritmo/funzione può essere formulato completamente senza effetti collaterali solo con funzioni.

-----------------------------------------
Creazione di un contesto da una variabile
-----------------------------------------

Vediamo come creare un contesto dal contenuto di una variabile.

Primo metodo:
-------------
Definiamo la variabile che contiene il nome del contesto da creare come stringa ("TEST1"):

(setq name "TEST1")

E definiamo il contesto nel modo seguente:

(context (sym name))

(context? TEST1)
;-> true

Secondo metodo:
---------------

Definiamo la variabile che contiene il nome del contesto da creare come simbolo quotato ('TEST2):

(setq name 'TEST2)

E definiamo il contesto nel modo seguente:

(context name)

(context? TEST2)
;-> true

Terzo metodo:
---------------
Creiamo prima un contesto vuoto TEMP:

(context 'TEMP)
(context MAIN)

Definiamo la variabile che contiene il nome del contesto da creare come stringa ("TEST3"):

(setq var "TEST3")

Adesso possiamo creare il contesto DEMO copiando il contesto TEMP:

(new TEMP (sym var))
(context? TEST3)
;-> true

Quarto metodo:
---------------
Creiamo prima un contesto vuoto TEMP:

(context 'TEMP)
(context MAIN)

Definiamo la variabile che contiene il nome del contesto da creare come simbolo quotato ('TEST4):

(setq var 'TEST4)

Adesso possiamo creare il contesto TEST4 copiando il contesto TEMP:

(new TEMP (sym var))
(context? TEST4)
;-> true

Possiamo scrivere anche una funzione:

(define (create-context str)
  (local (temp ctx)
    (setq temp (sym str))
    (new MAIN temp)
    (setq ctx (eval temp))
    (setq ctx:name (string "I am " c))))

Adesso possiamo creare un contesto qualunque con una variabile che contiene il nome del contesto come stringa:

(setq c "DEMO")
(create-context c)
;-> "I am DEMO"
DEMO:name
;-> "I am DEMO"


Per finire vediamo come creare un contesto da un contesto esistente che contiene una funzione "create" (costruttore) che crea un contesto:

(context 'DEMO)

(define (create str)
    (context MAIN)
    (new DEMO (sym str))
    (context DEMO))

(define (echo)
    (println "Hello world"))

(context MAIN)

A questo punto possiamo creare un nuovo contesto (A) e assegnarlo ad una variabile (ctx):

(setq ctx (DEMO:create "A"))
(ctx:echo)
;-> Hello world


--------------------------------------
Creazione di contesti con una funzione
--------------------------------------

Per elencare la lista dei constesti attivi basta scrivere:

(filter context? (map eval (symbols 'MAIN)))

Vediamo come creare dei contesti con una funzione:

(context 'ITEM)
   (set 'title "")
   (set 'link "")
   (set 'content "")
   (set 'item_date "")
   (set 'author "")
(context 'MAIN)

(context 'MY_CONTEXT)
(set 'items '())
(define (create_item this_item)
   ;(println this_item)
   (new ITEM this_item)
   (set 'this_item (eval this_item))
   ;;Item Title
   (set 'this_item:title "some title")
   ;;Item Author
   (set 'this_item:author "some author")
   ;;Item Date
   (set 'this_item:item_date "some date")
   ;;Item Body
   (set 'this_item:content "foo body")
   ;;Item Link/URL
   (set 'this_item:link "some URL")
   (push this_item items)
)
(context 'MAIN)

Adesso possiamo scrivere:

(MY_CONTEXT:create_item 'TEST-1)
;-> (TEST-1)
(MY_CONTEXT:create_item 'TEST-2)
;-> (TEST-2)

MY_CONTEXT:items
;-> (TEST-2 TEST-1)

E dal contesto MY_CONTEXT possiamo scrivere:

(context 'MY_CONTEXT)
(create_item 'MAIN:TEST-3)
;-> (TEST-3 TEST-2 TEST-1)
(create_item 'MAIN:TEST-4)
;-> (TEST-4 TEST-3 TEST-2 TEST-1)
items
;-> (TEST-4 TEST-3 TEST-2 TEST-1)

Questo perché i simboli di contesto appartengono sempre a MAIN.

Questa è l'espressione critica:

(set 'this_item (eval this_item))

Poiché vogliamo accedere al contesto che è all'interno di this_item, ma "this_item" contiene il simbolo 'TEST-1 (che conterrà il contesto TEST-1). Quindi con "eval" rimuoviamo un livello di valutazione. Nell'ultima espressione viene usato "push", perché "cons" non è distruttivo e non cambierebbe la lista.




=============================================================================

