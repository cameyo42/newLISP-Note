===============

 NOTE LIBERE 9

===============

-------------------
La lunghezza di nil
-------------------

In Common LISP:

(length nil)   --> 0
(length 'nil)  --> 0

In newLISP:

(length nil)
;-> 0
(length 'nil)
;-> 3

In newLISP, la funzione "length" applicata a un simbolo restituisce la lunghezza del nome del simbolo.


-----------------------------------------
Vocali, consonanti e cifre in una stringa
-----------------------------------------

Scrivere una funzione per calcolare quante vocali, consonanti e cifre ci sono in una data stringa.

Primo metodo:

(define (quanti str)
  (local (lst letters conta out)
    ; lista dei caratteri della stringa
    (setq lst (explode testo))
    ; lista dei caratteri da contare
    (setq letters '())
    ; aggiunge i numeri
    (for (i 48 57) (push (char i) letters -1))
    ; aggiunge le lettere minuscole
    (for (i 97 122) (push (char i) letters -1))
    ; conteggio
    (setq conta (count letters lst))
    ; creazione lista di associazione (char freq)
    (map list letters conta)))

(setq testo "super1cali2fragilissi3chespiralidoso")
(quanti testo)
;-> (("0" 0) ("1" 1) ("2" 1) ("3" 1) ("4" 0) ("5" 0) ("6" 0) ("7" 0) ("8" 0)
;->  ("9" 0) ("a" 3) ("b" 0) ("c" 2) ("d" 1) ("e" 2) ("f" 1) ("g" 1) ("h" 1)
;->  ("i" 6) ("j" 0) ("k" 0) ("l" 3) ("m" 0) ("n" 0) ("o" 2) ("p" 2) ("q" 0)
;->  ("r" 3) ("s" 5) ("t" 0) ("u" 1) ("v" 0) ("w" 0) ("x" 0) ("y" 0) ("z" 0))

Secondo metodo:

(define (howmany str)
  (local (lst vowel conso digit out)
    (setq lst (explode testo))
    (setq vowel '("a" "e" "i" "o" "u"))
    (setq conso '("b" "c" "d" "f" "g" "h" "j" "k" "l" "m" "n"
                  "p" "q" "r" "s" "t" "v" "w" "x" "y" "z"))
    (setq digit '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))
    (setq out '())
    ; conta vocali
    (setq tmp (map list vowel (count vowel lst)))
    (push tmp out -1)
    ; conta consonanti
    (setq tmp (map list conso (count conso lst)))
    (push tmp out -1)
    ; conta cifre
    (setq tmp (map list digit (count digit lst)))
    (push tmp out -1)
    out))

(howmany testo)
;-> ((("a" 3) ("e" 2) ("i" 6) ("o" 2) ("u" 1))
;->  (("b" 0) ("c" 2) ("d" 1) ("f" 1) ("g" 1) ("h" 1) ("j" 0) ("k" 0) ("l" 3)
;->   ("m" 0) ("n" 0) ("p" 2) ("q" 0) ("r" 3) ("s" 5) ("t" 0) ("v" 0) ("w" 0)
;->   ("x" 0) ("y" 0) ("z" 0))
;->  (("0" 0) ("1" 1) ("2" 1) ("3" 1) ("4" 0)
;->    ("5" 0) ("6" 0) ("7" 0) ("8" 0) ("9" 0)))


--------------------------
Pseudo-closures con gensym
--------------------------

Da un post di William James:

(define (gensym:gensym)
  (sym (string "gensym-" (inc gensym:counter))))
;-> (lambda () (sym (string "gensym-" (inc gensym:counter))))

(define-macro (closure varval-pairs body)
  (let (alist (map (fn(x) (list (x 0) (gensym) (eval (x 1))))
                   (explode varval-pairs 2)))
    (bind (map (fn (x) (rest x)) alist))
    (dolist (x alist)
      (set-ref-all (x 0) body (x 1)))
    body))

(set 'up-down
  (closure (a 0 b 99)
    (lambda () (list (++ a) (-- b)))))

(up-down)
;-> (1 98)
(up-down)
;-> (2 97)
(up-down)
;-> (3 96)

(println up-down)
;-> (lambda () (list (++ gensym:gensym-1) (-- gensym:gensym-2)))

Versione leggermente migliorata e con un esempio in cui due lambda condividono una variabile.

(define-macro (closure varval-pairs)
  (let (body (cons 'begin (args))
        alist (map (fn(x) (list (x 0) (gensym) (eval (x 1))))
                   (explode varval-pairs 2)))
    (bind (map (fn (x) (rest x)) alist))
    (dolist (x alist)
      (set-ref-all (x 0) body (x 1)))
    (eval body)))

(closure (count 0)
  (setq up (fn()(++ count))) (setq down (fn()(-- count))))

;-> (up)
;-> ;-> 1
;-> (up)
;-> ;-> 2
;-> (up)
;-> 3
;-> (down)
;-> 2
;-> (down)
;-> 1

Per un modo diverso di farlo vedere:

http://www.newlisp.org/index.cgi?def-static

La differenza di "def-static" rispetto a questa soluzione è che inserisce ogni funzione nel proprio spazio dei nomi (contesto) tramite un functor predefinito.

Al posto di "gensym" è possibile utilizzare (sym (uuid)).

Nota: la funzione "gensym" è leggermente più veloce e mantiene tutti i simboli generati nello stesso contesto (namespace) gensym. Ma se ne usiamo solo alcuni, allora (sym (uuid)) è più pratico.
Una buona pratica è spostare le define-macro (fexprs) nel proprio spazio dei nomi, che risolve anche l'acquisizione di variabili e crea una sorta di chiusura lessicale.


-------------------------------------------------------------
Passaggio di elementi di una lista come argomenti di funzione
-------------------------------------------------------------

Supponiamo di avere una funzione che accetta come argomenti due stringhe e tre numeri interi:

(myfunc "str1" "str2" 3 4 5)

Tuttavia abbiamo una lista che contiene questi valori interi:

(setq myvalues '(3 4 5))

Come passare gli elementi di questa lista come argomenti della funzione?

Un metodo immediato (ma non applicabile se non conosciamo il numero di elementi della lista) è il seguente:

(myfunc "str1" "str2" (myvalues 0) (myvalues 1) (myvalues 2))

Dobbiamo utilizzare le funzioni "apply", "append" e "list":

(define (my-func s1 s2 a b c)
  (dup (string s1 s2 a b) c))

(my-func "o" "-" 1984 9 3)
;-> "o-19849o-19849o-19849"

(apply my-func (cons "o" (cons "-" '(1984 9 3))))
;-> "o-19849o-19849o-19849"

(apply my-func (append '("o" "-") '(1984 9 3)))
;-> "o-19849o-19849o-19849"


--------------------------
Differenza tra let e letex
--------------------------

Per capire le differenze tra "let" e "letex" vediamo due esempi:

Primo esempio:

(letex ((x 2) (y 3))
   (+ x y))
;-> 5

(let ((x 2) (y 3))
    (+ x y))
;-> 5

Sembra che le funzioni si comportino allo stesso modo...

Secondo esempio:

(letex (x 1 y 2) '(x y))
;-> (1 2)

(let (x 1 y 2) '(x y))
;-> (x y)

Invece in questo caso le funzioni si comportano diversamente.

Nel caso "letex", quando "eval" è pronto per valutare l'espressione (+ x y), tutto ciò che "vede" è (+ 2 3) perché "letex" ha già macroespanso l'espressione (+ x y).

Nel caso let, quando "eval" è pronto per valutare la forma (+ x y), tutto ciò che "vede" è (+ x y), e quindi deve valutare x e y in base all'associazione corrente (dynamic binding) per trovare i rispettivi valori.

Può sembrare strano, ma ci sono momenti in cui si desidera espandere un'espressione prima che "eval" lo veda. Un po' come un doppio "eval", ma nel primo giro (espansione con "letex") possiamo scegliere quali parti dell'espressione target vengono "valutate" (espanse), e quindi "eval" prende l'espressione espansa (pre-processata, in un certo senso) e procede a fare la sua valutazione su quella.

Vediamo la definizione di "letex" dal manuale:

*******************
>>> funzione LETEX
*******************
sintassi: (letex ((sym1 [exp-init1]) [(sym2 [exp-init2]) ... ]) body)
sintassi: (letex (sym1 exp-init1 [sym2 exp-init2 ... ]) body)

Questa funzione combina "let" ed "expand" per espandere le variabili locali in un'espressione prima di valutarla. Nella prima sintassi completamente tra parentesi, gli inizializzatori di sintassi sono facoltativi e si presume "nil" se mancanti.

Entrambe le forme forniscono la stessa funzionalità, ma nella seconda sintassi le parentesi attorno agli inizializzatori possono essere omesse:

(letex (x 1 y 2 z 3) '(x y z))
;-> (1 2 3)

(letex ( (x 1) (y '(a b c)) (z "hello") ) '(x y z))
;-> (1 (a b c) "hello")

Prima che l'espressione '(x y z) venga valutata, x, y e z vengono letteralmente sostituiti con gli inizializzatori dall'elenco di inizializzatori "letex". L'espressione finale che viene valutata è '(1 2 3).

Nel secondo esempio viene definita una funzione make-adder per la creazione di funzioni che sommano:

(define (make-adder n)
    (letex (c n) (lambda (x) (+ x c))))

(define add3 (make-adder 3))
;-> (lambda (x) (+ x 3))

(add3 10)
;-> 13

; letex può espandere i simboli in se stessi
; funziona anche la seguente forma

(define (make-adder n)
     (letex (n n) (lambda (x) (+ x n))))

"letex" valuta n alla costante 3 e sostituisce c con essa nell'espressione lambda. Il secondo esempio mostra come una variabile "letex" può essere espansa in se stessa.


---------------
Ricorsione cond
---------------

Solo un gioco con la ricorsione:

(define (cond-recursion value)
  (cond ((= value 0) (println "value: " value) (cond-recursion (++ value)))
        ((= value 1) (println "value: " value) (cond-recursion (++ value)))
        ((= value 2) (println "value: " value) (cond-recursion (++ value)))
        ((= value 3) (println "value: " value) (cond-recursion (++ value)))
        ((= value 4) (println "value: " value) (cond-recursion (++ value)))
        ((= value 5) (println "value: " value) (cond-recursion (++ value)))
        ((= value 6) (println "value: " value) (cond-recursion (++ value)))
        ((= value 7) (println "value: " value) (cond-recursion (++ value)))
        ((= value 8) (println "value: " value) (cond-recursion (++ value)))
        ((= value 9) (println "value: " value) (cond-recursion (++ value)))
        (true 'end-cond)))

(cond-recursion 0)
;-> value: 0
;-> value: 1
;-> value: 2
;-> value: 3
;-> value: 4
;-> value: 5
;-> value: 6
;-> value: 7
;-> value: 8
;-> value: 9
;-> end-cond

(cond-recursion 8)
;-> value: 8
;-> value: 9
;-> end-cond


----------------------------------------------
Come funziona (define (sum (x 0)) (inc 0 x)) ?
----------------------------------------------

La seguente funzione si trova in "Code Patterns":

(define (sum (x 0)) (inc 0 x))

Eseguiamola per capire cosa fa e come funziona:

(sum)
;-> 0
(sum)
;-> 0
(sum 1)
;-> 1
(sum)
;-> 1
(sum 2)
;-> 3
(sum -1)
;-> 2

Quindi la funzione modifica un valore che viene mantenuto tra le varie chiamate (una specie di closure).
Ma come funziona internamente?

L'espressione (x 0) assegna/associa a x il valore 0.

Ma cosa fa (inc 0 x)?

Vediamo la struttura della funzione "sum":

sum
;-> (lambda ((x 0)) (inc 2 x))

Adesso (inc 0 x) si è trasformata in (inc 2 x). Infatti se eseguiamo la funzione senza parametro, allora restituisce il valore corrente (che vale 2):

(sum)
;-> 2

Innanzitutto, "inc" incrementa un/il numero in prima posizione e funziona sia con i simboli che con i numeri.

La primitiva "inc", quando invocata con il suo primo argomento un numero letterale, si comporta apparentemente aggiornando la cella di memoria di quel numero atomico. Se l'espressione "(inc 0 x)" viene valutata da sola sulla riga di comando, la cella "0" viene aggiornata e poi distrutta al completamento della funzione.

Tuttavia, poiché nell' esempio "(inc 0 x)" è contenuto nella definizione lambda di "sum", la cella "0" (in effetti l'intera espressione lambda) persiste in memoria. Quindi, quando si esegue "(sum 4)", la cella "0" viene aggiornata per contenere "4", che continua a persistere all'interno della definizione di "sum".

Si comporta come una funzione automodificante, ma la modifica del proprio codice (modifica dell'Abstract Syntax Tree AST) non è esplicita nel corpo della funzione (cioè non c'è nessuna espressione della funzione che modifica se stessa in qulache modo). La funzione viene modificata intrinsecamente durante l'esecuzione di "inc" che cambia il valore associato allo "0" iniziale.

Vediamo due esempi che mostrano questo funzionamento in azione:

primo esempio

(setf a '(inc 0 1))
;-> (inc 0 1)
a
;-> (inc 0 1)
(eval a)
;-> 1
a
;-> (inc 1 1)
(eval a)
;-> 2
a
;-> (inc 2 1)

secondo esempio

(define (pp x) (push x '()))
;-> (lambda (x) (push x '()))
(pp 1)
;-> (1)
pp
;-> (lambda (x) (push x '(1)))
(pp 3)
;-> (3 1)
pp
;-> (lambda (x) (push x '(3 1)))

Adesso vediamo un esempio di funzione automodificante (diretta):

(define (changeme x) (setf (last changeme) (+ (last changeme) 1)) 0)
(changeme)
;-> 1
(changeme)
;-> 2
(changeme)
;-> 3
changeme
;-> (lambda (x) (setf (last changeme) (+ (last changeme) 1)) 3)

In questo caso, la primitiva "setf" viene usata per modificare esplicitamente (direttamente) la definizione della funzione.


--------------------------------------
Estrazione da una lista con un pattern
--------------------------------------

Supponiamo di avere la seguente lista:

(setq lst '("1" "start" "0" "22" "a" "end" "f" "start" "b" "c" "9" "end"
            "start" "end"  "start" "nil"))

e di voler estrarre tutti i gruppi di elementi che iniziano con "start" e terminano con "end":

  (("start" "0" "22" "a" "end") ("start" "b" "c" "9" "end") ("start" "end"))
  (("0" "22" "a") ("b" "c" "9") ())

(setq lst '("1" "start" "0" "22" "a" "end" "f" "start" "b" "c" "9" "end" ))
            "start" "end"  "start" "nil"))

Primo metodo iterativo:

(define (estrazione str1 str2 lst)
  (local (tmp out s)
    (setq out '())
    (setq tmp '())
    (dolist (token lst)
      (cond ((= token str1)
              (setq s true))
            ((= token str2)
              (if s
                (begin
                  (push tmp out -1)
                  (setq s nil)
                  (setq tmp '()))))
            (true
              (if s (push token tmp -1)))
      )
    )
    out))

(estrazione "start" "end" lst)
;-> (("0" "22" "a") ("b" "c" "9") ())

Secondo metodo con "match" (Lutz):

(define (extract str1 str2 lst)
  (local (m out)
    (setq out '())
    (while (set 'm (match '(* "start" * "end" *) lst))
      (push (m 1) out -1)
      (set 'lst (last m)))
    out))

(extract "start" "end" lst)
;-> (("0" "22" "a") ("b" "c" "9") ())

Vediamo la velocità delle due funzioni:

(time (estrazione "start" "end" lst) 100000)
;-> 802.794
(time (extract "start" "end" lst) 100000)
;-> 741.265


-------------------------------------------------------------
Creazione di liste con struttura predefinita e valori casuali
-------------------------------------------------------------

Per effettuare dei test spesso ci servono delle strutture con molti elementi che non possono essere create manualmente. Vediamo come creare in modo automatico un dato numero di elementi di una lista che ha una struttura predefinita.

Supponiamo di voler creare una lista i cui ogni elemento è dato da una coppia (intero stringa):

  ((1 "a") (2 "c") (21 "g"))

Per rappresentare la struttura dell'elemento della lista utilizziamo il metodo seguente:

  Tipo            Rappresentazione
  -------------------------------------
  stringa   ==>   "str length"
  intero    ==>   "int val-min val-max"
  float     ==>   "flt val-min val-max"

Quindi la struttura del nostro esempio potrebbe essere:

  ("int 1 22" "str 1 1")

cioè un numero intero tra 1 e 22 e una stringa di lunghezza 1.

Adesso abbiamo bisogno delle funzioni che generano casualmente i numeri interi, i numeri in virgola mobile e le stringhe.

Funzione che genera una stringa di caratteri minuscoli di lunghezza compresa tra un valore minimo e massimo:

(define (rnd-string min-val max-val)
  (let (len (+ min-val (rand (+ (- max-val min-val) 1))))
    (if (zero? len)
        ""
        (let (str "")
          (for (i 1 len)
            (push (char (+ 97 (rand 26))) str -1)
          )
          str))))

(rnd-string 0 0)
;-> ""
(rnd-string 3 6)
;-> "rrezql"
(rnd-string 3 6)
;-> "wwos"

Funzione che genera un numero intero compreso tra un valore minimo e massimo:

(define (rnd-integer min-val max-val)
  (+ min-val (rand (+ (- max-val min-val) 1))))

(rnd-integer 10 50)
;-> 42

Funzione che genera un numero in virgola mobile (float) compreso tra un valore minimo e massimo:

(define (rnd-float min-val max-val)
  (add min-val (random 0 (sub max-val min-val))))

(rnd-float 10 20)
;-> 14.82741782891324

Adesso possiamo scrivere la funzione finale (spiegazione nei commenti):

(define (make-list struct-lst num-elements)
  (local (base indexes tipo val out)
    (setq out '())
    (setq base struct-lst)
    ; lista degli indici di struct-lst
    (setq indexes (ref-all nil struct-lst (fn (x) true)))
    ; ciclo per ogni elemento da creare
    (for (i 1 num-elements)
      ; ciclo sulla lista degli indici di struct-lst
      (dolist (idx indexes)
        (setq tipo (struct-lst idx))
        ; indice di un valore atomico?
        (if (atom? tipo)
          (begin
            ; estrazione dei parametri del tipo
            (setq p (parse tipo))
            ; creazione valori random
            (cond ((= (p 0) "str") ; string
                    (setq val (rnd-string (int (p 1)) (int (p 2))))
                    (setf (base idx) val))
                  ((= (p 0) "int") ; integer
                    (setq val (rnd-integer (int (p 1)) (int (p 2))))
                    (setf (base idx) val))
                  ((= (p 0) "flt") ; float
                    (setq val (rnd-float (float (p 1)) (float (p 2))))
                    (setf (base idx) val))
                (true (println "Error: " tipo))
            )
          )
        )
      )
      ; inserimento elemento corrente nella lista finale
      (push base out -1)
    )
    out))

Facciamo alcune prove:

(setq a '("int 0 22" "str 1 1"))
(make-list a 5)
;-> ((16 "r") (7 "v") (19 "r") (0 "b") (19 "o"))

(setq a '("str 2 4" "int 10 20" "flt 0 10"))
(make-list a 5)
;-> (("xy"   13 5.249794000061037)
;->  ("tmxz" 18 0.5508590960417493)
;->  ("hig"  11 6.011535996581927)
;->  ("hyg"  19 8.886684774315622)
;->  ("skh"  20 3.220313119907224))

(setq a '(("int 0 10" "int 0 10") (("int 3 3" ("str 3 3")) ("int 3 5" "str 1 2")) ((("flt 0.5 1.5")))))
(make-list a 15)
;-> (((0 6)  ((3 ("zln")) (3 "s"))  (((1.278923917355876))))
;->  ((1 0)  ((3 ("fts")) (3 "yh")) (((1.481566820276498))))
;->  ((1 10) ((3 ("tiu")) (4 "wo")) (((0.7101809747611927))))
;->  ((4 4)  ((3 ("sge")) (3 "m"))  (((0.5996429334391309))))
;->  ((3 5)  ((3 ("ncd")) (3 "op")) (((1.197653126621296))))
;->  ((9 2)  ((3 ("dkm")) (5 "fo")) (((0.9221015045625172))))
;->  ((2 10) ((3 ("gtz")) (5 "wx")) (((1.198751792962432))))
;->  ((8 6)  ((3 ("xfd")) (3 "a"))  (((1.121143223364971))))
;->  ((8 8)  ((3 ("zns")) (5 "y"))  (((0.8128757591479232))))
;->  ((7 4)  ((3 ("vqu")) (4 "pp")) (((1.275688955351421))))
;->  ((10 6) ((3 ("ide")) (4 "py")) (((1.000778221991638))))
;->  ((1 1)  ((3 ("qmz")) (3 "tv")) (((1.130817590868862))))
;->  ((3 3)  ((3 ("fyq")) (3 "dg")) (((1.110461745048372))))
;->  ((8 9)  ((3 ("xse")) (5 "n"))  (((1.179158909878842))))
;->  ((6 7)  ((3 ("xfy")) (5 "hz")) (((1.366176335947752)))))

(setq a '("int 1 100"))
(make-list a 5)
;-> ((64) (5) (32) (48) (21))
(flat (make-list a 5))
;-> (25 24 83 96 55)

Modificando la funzione è possibile aggiungere altri tipi oltre a "int", "flt" e "str".


--------------------------------
Assegnazione doppiamente quotata
--------------------------------

Partendo da una REPL nuova memorizziamo tutti i simboli in una lista:

(setq simboli (symbols))

Adesso assegniamo ai simboli "a", "b" e "c" i valori 1, 2 e 3 con tre metodi diversi:

Assegnazione con "set" (usando il simbolo quotato):
(set 'a 1)
;-> 1

Assegnazione con "setq" (senza il simbolo quotato):
(setq b 2)
;-> 2

Assegnazione con "setq" (usando il simbolo quotato):
(setq 'c 3)
;-> 3 ; esiste un output
Nota: questa assegnazione non ha una logica ed è sbagliato, ma produce risultato strani.

Vediamo quali simboli sono stati creati:

(difference (symbols) simboli)
;-> (a b c)

Vediamo i valori dei simboli creati:

(println "a = " a ", b = " b ", c = " c})
;-> a = 1, b = 2, c = nil

Dove è finito il valore 3?


---------
Esercizio
---------

Scrivere una funzione per generare la seguente lista:

  ((1 "a") (1 "b") (1 "c") (1 "d")
   (2 "a") (2 "b") (2 "c") (2 "d")
   (3 "a") (3 "b") (3 "c") (3 "d")
   (4 "a") (4 "b") (4 "c") (4 "d")
   (5 "a") (5 "b") (5 "c") (5 "d"))

Soluzione 1:

(define (sol01)
  (map list
    ; numbers
    (sort (flat (dup (sequence 1 5) 4)))
    ; letters
    (explode (dup "abcd" 5))))

(sol01)
;-> ((1 "a") (1 "b") (1 "c") (1 "d")
;->  (2 "a") (2 "b") (2 "c") (2 "d")
;->  (3 "a") (3 "b") (3 "c") (3 "d")
;->  (4 "a") (4 "b") (4 "c") (4 "d")
;->  (5 "a") (5 "b") (5 "c") (5 "d"))

Soluzione 2:

(define (sol02)
  (for (i 1 5) 
    (extend '() (map (curry list i) '("a" "b" "c" "d")))))

(sol02)
;-> ((1 "a") (1 "b") (1 "c") (1 "d")
;->  (2 "a") (2 "b") (2 "c") (2 "d")
;->  (3 "a") (3 "b") (3 "c") (3 "d")
;->  (4 "a") (4 "b") (4 "c") (4 "d")
;->  (5 "a") (5 "b") (5 "c") (5 "d"))


-----------------
Cicli senza cicli
-----------------

Creazione di un ciclo in stile funzionale, cioè senza utilizzare "for", "while", "until" "dolist", ecc.

Esempio 1: (by newdep)

(define (loop x) (or (zero? x) (go x)) )
;-> (lambda (x) (or (zero? x) (go x)))
(define (go y) (print y { }) (loop (dec y)))
;-> (lambda (y) (print y " "}) (loop (dec y)))

(go 10)
;-> 10 9 8 7 6 5 4 3 2 1 true

(loop 10)
;-> (loop 10)

Esempio 2: (by Kazimir Majorinc)

(setq counter 0)
(eval (setf code '(when (< counter 10)
                    (inc counter)
                    (print counter { })
                    (eval code))))
;-> 1 2 3 4 5 6 7 8 9 10 nil

Esempio 3: ("crawler-tractor" by Kazimir Majorinc)

(setq counter2 0)
(set 'f (lambda()
            (if (< counter2 5)
                (begin (println "Hi for the " (inc counter2) " time. ")
                          (push (last f) f -1)
                          (if (> (length f) 3) (pop f 1))))))

(f)
;-> Hi for the 1 time.
;-> Hi for the 2 time.
;-> Hi for the 3 time.
;-> Hi for the 4 time.
;-> Hi for the 5 time.
;-> nil

Esempio 4: (by newdep)

# loops y * 1-second
(define (loop y)
        (map (fn(x) (sleep (mul x 1000)) (println (++ y))  ) (dup 1 y))  )

#loops backwards from y to z
(setf loop (lambda(y z)
      (map (fn(x) (println (dup "@" x) )) (sequence y z))
           true ))

#loops backwards to 1
(setf loop (lambda(y)
      (map (fn(x) (println (dup "@" x) )) (sequence y 1))
           true ))

(loop 10)
;-> @@@@@@@@@@
;-> @@@@@@@@@
;-> @@@@@@@@
;-> @@@@@@@
;-> @@@@@@
;-> @@@@@
;-> @@@@
;-> @@@
;-> @@
;-> @
;-> true


-------------
Ciclo Sattolo
-------------

Il ciclo Sattolo è un algoritmo per mescolare casualmente uns lista in modo tale che ogni elemento finisca in una nuova posizione.

Data una lista di elementi con indici che vanno da 0 a N, l'algoritmo può essere definito come segue (pseudo-codice):

for i from N downto 1 do:
    let j = random integer in range 0 <= j < i
    swap items[i] with items[j]

L'unica differenza tra questo e il Knuth shuffle, è che j viene scelto dall'intervallo nell'intervallo 0 <= j < i, anziché 0 <= j <= i. Questo è ciò che garantisce che ogni elemento finisca in una nuova posizione, purché siano presenti almeno due elementi.

(define (sattolo lst)
  (let (len (length lst))
    (for (i (- len 1) 1)
      (setq j (rand i))
      ;(swap (lst i) (lst (rand i)))
      (swap (lst i) (lst j))
    )
  lst))

(sattolo '(1 2 3))
;-> (2 3 1)
(sattolo '(1 2 3))
;-> (3 2 1)

(setq lst '(1 2 3))
(unique (collect (setq lst (sattolo lst)) 1e3))
;-> ((1 2 3) (3 1 2) (2 3 1))

(setq lst '(1 2 3 4 5 6 7 8 9))
(sattolo lst)
;-> (2 8 6 3 1 5 4 9 7)

(length (unique (collect (setq lst (sattolo lst)) 1e6)))
;-> 180693
(length (unique (collect (setq lst (sattolo lst)) 1e7)))
;-> 181440


------------------------
Lewis Carrol e le biglie
------------------------

Lewis Carroll (pseudonimo di Charles Lutwidge Dodgson, 1832 - 1898) è stato uno scrittore, matematico e prete anglicano britannico. È conosciuto soprattutto per i due romanzi "Le avventure di Alice nel Paese delle Meraviglie" e "Attraverso lo specchio e quel che Alice vi trovò".

Vediamo uno dei suo problemi:

1. In un sacchetto c'è una biglia di colore verde o giallo.
2. Inseriamo nel sacchetto una biglia di colore giallo.
3. Estraiamo una biglia dal sacchetto e notiamo che è di colore giallo.

Quanto vale la probabilità che nel sacchetto (che adesso contiene una sola biglia) vi sia una biglia di colore giallo?

Il secondo quesito è uguale, tranne che nel passaggio 3:

3. Estraiamo una biglia senza vedere che colore è.

Quanto vale la probabilità che nel sacchetto (che adesso contiene una sola biglia) vi sia una biglia di colore giallo?

Prima risolviamo il problema con due simulazioni, poi vedremo la soluzione matematica.

Funzione che genera "G"iallo o "V"erde:

(define (g-v) (if (zero? (rand 2)) "G" "V"))

Funzione per il primo quesito:

(define (estrae1 iter)
  (local (sacchetto contag)
    (setq contag 0)
    (setq i 0)
    (while (< i iter)
      (setq sacchetto '())
      ; inseriamo una "G" o una "R"
      (push (g-v) sacchetto -1)
      ; inseriamo una "G"
      (push "G" sacchetto)
      ;estraiamo una biglia
      (setq num (rand 2))
      (cond ((= (pop sacchetto num) "G")
             ; evento valido (da conteggiare)
             (++ i)
             ; controllo colore biglia rimasta
             (if (= (sacchetto 0) "G") (++ contag)))
            (true ; estratta "R" ==> evento non valido
              nil)
      )
    )
    (println iter)
    (div contag iter)))

Proviamo la funzione:

(estrae1 1e5)
;-> 0.66609
(estrae1 1e6)
;-> 0.665354
(estrae1 1e7)
;-> 0.6667029

La prima simulazione produce una probabilità del 66.66% (2/3) che la biglia rimasta sia di colore giallo.

Funzione per il secondo quesito:

(estrae1 1e6)
(define (estrae2 iter)
  (local (sacchetto contag)
    (setq contag 0)
    (for (i 1 iter)
      (setq sacchetto '())
      ; inseriamo una "G" o una "R"
      (push (g-v) sacchetto -1)
      ; inseriamo una "G"
      (push "G" sacchetto)
      ; estraiamo una biglia senza vedere il suo colore
      (pop sacchetto (rand 2))
      ; controllo colore biglia rimasta
      (if (= (sacchetto 0) "G")
          (++ contag)
      )
    )
    (div contag iter)))

Proviamo la funzione:

(estrae2 1e5)
;-> 0.75031
(estrae2 1e6)
;-> 0.749505
(estrae2 1e7)
;-> 0.7497385

La seconda simulazione produce una probabilità del 75% (3/4) che la biglia rimasta sia di colore giallo.

Il risultato è controintuitivo, ma è esatto. Il calcolo matematico può essere svolto in due modi o con il teorema di Bayes o in maniera più intutitiva con il teorema fondamentale delle probabilità:

                numero eventi favorevoli
Probabilità = ----------------------------
                numero eventi possibili

Nel primo quesito, quando abbiamo due biglie nel sacchetto e estraiamo una biglia "Gialla", abbiamo i seguenti eventi possibili:

1) nel sacchetto ci sono una biglia "Rossa" e una biglia "Gialla" 
   ed estraiamo la biglia "Rossa" (rimane biglia "Gialla")
2) nel sacchetto ci sono una biglia "Rossa" e una biglia "Gialla" 
   ed estraiamo la biglia "Gialla" (rimane biglia "Rossa")
3) nel sacchetto ci sono una biglia "Gialla" e una biglia "Gialla" 
   ed estraiamo la prima biglia "Gialla" (rimane biglia "Gialla")
4) nel sacchetto ci sono una biglia "Gialla" e una biglia "Gialla" 
   ed estraiamo la prima seconda "Gialla" (rimane biglia "Gialla")

Il primo evento non accade mai (perchè viene scartato) quindi abbiamo 3 eventi possibili (2, 3 e 4) e in due di questi casi rimane una biglia "Gialla".
Quindi la probabilità che rimanga una biglia "Gialla" vale 2/3 = 66.66%

Nel secondo quesito abbiamo gli stessi eventi, con la differenza che l'evento 1 non deve essere scartato in quanto non controlliamo il colore della biglia estratta. Quindi abbiamo 4 evanti di cui 3 favorevoli (rimane una biglia "Gialla").
Quindi la probabilità che rimanga una biglia "Gialla" vale 3/4 = 75%.


--------------------------------------------------
Ricerca di elementi in una lista e in una hash-map
--------------------------------------------------

Supponiamo di avere una lista i cui (molti) elementi hanno la seguente struttura:

  (int1 int2 int3 int4)

Vediamo quando tempo occorre per ricercare un valore in questa lista.

Creiamo la lista con 1 milione di elementi:

(silent (dolist (s (sequence 1 1e6)) (push (rand 1000 4) lst -1)))

Impostiamo l'elemento da cercare:
; questo è il penultimo elemento
(set 'z (lst -2))
;-> (459 799 96 424)

Cerchiamo l'elemento con "find":

(find z lst)
;-> 999998
(time (find z lst))
; 18.122

Adesso utilizziamo una hash-map per fare la stessa ricerca. Prima dobbiamo verificare che gli elementi della lista siano unici (cioè non esistano elementi duplicati):

(= lst (unique lst))
;-> true

Inseriamo tutti gli elementi della lista in una hash-map:

(new Tree 'H) ; hash-map
(silent (dolist (el lst)
    (H (format "%03d%03d%03d%03d" el) el)))

Verifichiamo la lunghezza della hash-map:

(length (H))
;-> 1000000

Gli elementi della hash-map hanno la seguente struttura:

((H) 0)
;-> ("000002143414" (0 2 143 414))

Adesso ricerchiamo il valore di un elemento della lista:

(set 'z ((H) -2))
;-> ("999997717420" (999 997 717 420))

(H (format "%03d%03d%03d%03d" (last z)))
;-> (999 997 717 420)

(time (H (format "%03d%03d%03d%03d" (last z))))
;-> 0

La ricerca con la hash-map è immediata.


-----------------------------------
Aerei della seconda guerra mondiale
-----------------------------------

Non vuoi che i tuoi aerei vengano abbattuti dai nemici, quindi occorre rinforzare gli aerei con delle armature.
Ma l'armatura rende l'aereo più pesante e gli aerei più pesanti sono meno manovrabili e usano di più carburante. Proteggere troppo gli aerei è un problema, blindare troppo poco gli aerei è un problema.
Da qualche parte nel mezzo c'è un ottimo.
Quando gli aerei americani tornavano dalle missioni erano coperti di fori di proiettile. Ma il danno non era distribuito uniformemente su tutto il velivolo. C'erano più fori di proiettile nella fusoliera, non così tanti nei motori.
Questa è una tabella tipo dei danni riportati:
 
  Sezione dell'aereo           Fori di proiettile per piede quadrato
  ------------------           -------------------------------------
  Motore                       1.11
  Fusoliera                    1.73
  Sistema di alimentazione     1.55
  Resto dell'aereo             1.8

Abbiamo un'opportunità di efficienza: possiamo ottenere la stessa protezione con meno armatura se concentriamo l'armatura nei punti di maggiore necessità. Ma quali sono questi punti deboli?
Chiaramente dove gli aerei vengono colpiti... o no?!

L'armatura non va dove ci sono i fori dei proiettili, ma va dove i fori dei proiettili non ci sono: sui motori.

I danni sono distribuiti equamente su tutto l'aereo? Dove sono i buchi mancanti? 
I fori di proiettile mancanti erano sugli aerei scomparsi. 
Il motivo per cui gli aerei tornano indietro con meno colpi al motore è che gli aerei che sono stati colpiti nel motore non tornano. Invece i colpi alla fusoliera possono essere tollerati. 
In un ospedale di guerra troviamo molti più pazienti con fori di proiettile nelle gambe che pazienti con fori di proiettile nel petto. Ma non è perché le persone non vengono colpite al petto, è perchè le persone che vengono colpite al petto muoiono.
Questo è un vecchio trucco da matematico per rendere il quadro più chiaro: impostare alcune variabili su
zero.


----------------------------------
Il gioco del caos (the chaos game)
----------------------------------

In matematica, il termine gioco del caos originariamente si riferiva a un metodo per creare un frattale, utilizzando un poligono e un punto iniziale selezionato a caso al suo interno.[1][2] Il frattale viene costruito iterativamente creando una sequenza di punti, a partire dal punto casuale iniziale, in cui ogni punto della sequenza è una data frazione della distanza tra il punto precedente e uno dei vertici del poligono. Il vertice viene scelto a caso in ogni iterazione. Ripetendo questo processo iterativo un gran numero di volte, selezionando il vertice a caso su ogni iterazione ed eliminando i primi punti della sequenza, spesso (ma non sempre) si ottiene una forma frattale.

Utilizziamo ImageMagick per generare l'immaginew partendo da un file di punti. Per mggiori informazioni vedi "Creazione di immagini con ImageMagick" nel file/capitolo "15-note-libere-7.lsp".

Funzione per generare i punti in formato ImageMagick partendo da una lista di punti:

(define (list-IM lst file-str)
  (local (outfile x-width y-height line)
    (setq lst (sort (unique lst)))
    (setq outfile (open file-str "write"))
    (print outfile { })
    ; calcolo dimensioni immagine
    (setq x-width  (add 2 (int (apply max (map first lst)))))
    (setq y-height (add 2 (int (apply max (map last lst)))))
    ;(setq x-width  (add 1 (apply max (map first lst))))
    ;(setq y-height (add 1 (apply max (map last lst))))
    ; scrittura del file in formato ImageMagick
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                (string x-width) "," (string y-height) ",256,rgba"))
    (dolist (el lst)
      (setq line (string (string (el 0)) ", " (string (el 1))
            ": (0,0,0,255)")) ; colore nero con alpha=100%
      (write-line outfile line)
    )
    (close outfile)))

Esempio:

(list-IM '((1 1) (10 10) (20 30)) "pippo.txt")

(exec "convert pippo.txt pippo.png")

Nota: "convert" è un comando di ImageMagick.

Aprendo l'immagine "pippo.png" possiamo vedere i tre punti disegnati.

Triangolo di Sierpinski
-----------------------
A seconda del poligono scelto possiamo ottenere una diversa forma frattale. Partendo da un triangolo equilatero e un punto interno ad esso, e scegliendo il punto successivo come il punto medio tra il punto corrente e uno dei vertici del triangolo selezionato casualmente, otteniamo il frattale di Sierpinski.

Nota: se le coordinate dei vertici di un triangolo sono tutti numeri interi, allora il triangolo non può essere equilatero.
Infatti il teorema di Pick implica che un triangolo con vertici in un lattice abbia un'area razionale. Invece l'area di un triangolo equilatero è un multiplo razionale della radice quadrata di 3.

Per creare un triangolo equilatero partendo dalla lunghezza del lato L dobbiamo utilizzare alcune formule di geometria.
Consideriamo il seguente triangolo (vedi immagine geometrica "equilateral-triangle.jpg" nella cartella "data"):

                 C
                / \
               / O \
              /     \
             A-------B

  Lunghezza del lato del triangolo equilatero: L

  Centro del triangolo (e del cerchio circoscritto): O = (ox, oy)

  Altezza triangolo = L * sqrt(3)/2

  Raggio circonferenza circoscritta = R = 2/3 dell'altezza = 2/3 * L * sqrt(3)/2 = L * sqrt(3)/3

da cui: L = R * 3/sqrt(3)

In questo modo le coordinate dei vertici del triangolo valgono:

  C = (ox, oy + R) = (ox, oy + L * sqrt(3)/3)
  A = (ox - L/2, oy - L*(sqrt(3)/6))
  B = (ox + L/2, oy - L*(sqrt(3)/6))

Possiamo scrivere una funzione per creare il triangolo che prende come parametri le coordinate del centro e la lunghezza del lato del triangolo.
Inoltre verifichiamo che i risultati siano corretti misurando le distanze tra i vertici.

(define (dist2d x1 y1 x2 y2)
"Calculates 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2)))))

(define (make-triangle ox oy lato)
  (local (ax ay bx by cx cy)
    (setq ax (sub ox (div lato 2)))
    (setq ay (sub oy (div (mul lato (sqrt 3)) 6)))
    (setq bx (add ox (div lato 2)))
    (setq by (sub oy (div (mul lato (sqrt 3)) 6)))
    (setq cx ox)
    (setq cy (add oy (div (mul lato (sqrt 3)) 3)))
    (println "AB: " (dist2d ax ay bx by))
    (println "AC: " (dist2d ax ay cx cy))
    (println "BC: " (dist2d bx by cx cy))
    (list (list ax ay) (list bx by) (list cx cy))))

(make-triangle 100 100 220)
;-> AB: 220
;-> AC: 220
;-> BC: 220
;-> ((-10 36.49147038914117) (210 36.49147038914117) (100 227.0170592217177))

Per fare in modo che le coordinate di A siano (0, 0) occorre impostare:

  ox = L/2
  oy = L*(sqrt(3)/6)

In questo modo non abbiamo bisogno di passare il centro del triangolo, ma solo la lunghezza del lato:

(define (make-triangle00 lato)
  (local (ax ay bx by cx cy)
    (setq ox (div lato 2))
    (setq oy (div (mul lato (sqrt 3)) 6))
    (setq ax (sub ox (div lato 2)))
    (setq ay (sub oy (div (mul lato (sqrt 3)) 6)))
    (setq bx (add ox (div lato 2)))
    (setq by (sub oy (div (mul lato (sqrt 3)) 6)))
    (setq cx ox)
    (setq cy (add oy (div (mul lato (sqrt 3)) 3)))
    ;(println "AB: " (dist2d ax ay bx by))
    ;(println "AC: " (dist2d ax ay cx cy))
    ;(println "BC: " (dist2d bx by cx cy))
    (list (list ax ay) (list bx by) (list cx cy))))

Facciamo alcune prove:

(make-triangle00 220)
;-> AB: 220
;-> AC: 220
;-> BC: 220
;-> ((0 0) (220 0) (110 190.5255888325765))

(make-triangle00 1500)
;-> ((0 0) (1500 0) (750 1299.038105676658))

Adesso possiamo scrivere la funzione che genera i punti del triangolo di Sierpinski.

Algoritmo
  1) Il primo punto (punto corrente) è il centro del triangolo (non strettamente necessario)
  2) Il punto successivo si trova a metà tra il punto corrente e un vertice del triangolo scelto a caso.
  3) Il punto successivo diventa il punto corrente
  4) Andare al passo 2)

(define (sierpinski lato iter)
  (local (tri x y idx rx ry out)
    (setq out '())
    ; create equilateral triangle
    (setq tri (make-triangle00 lato))
    ; starting point: center of triangle
    (setq x (div lato 2))
    (setq y (div (mul lato (sqrt 3)) 6))
    ; iterations...
    (for (i 1 iter)
      ; select random vertex
      (setq idx (rand 3))
      (setq rx (first (tri idx)))
      (setq ry (last (tri idx)))
      ; calculate new point coordinates
      ; mid-point between (x,y) and (rx,ry)
      (setq x (div (add x rx) 2))
      (setq y (div (add y ry) 2))
      ; insert point on result list
      (push (list x y) out -1)
    )
    out))

Proviamo con un lato di 1500 pixel e 1e5 iterazioni:

(silent (setq s1 (sierpinski 1500 1e5)))
(list-IM s1 "s1.txt")
(exec "convert s1.txt s1.png")

Proviamo con un lato di 1500 pixel e 1e6 iterazioni:

(silent (setq s2 (sierpinski 1500 1e6)))
(list-IM s2 "s2.txt")
(exec "convert s2.txt sierpinski.png")

Il file "sierpinski.png" si trova nella cartella "data".

Quadrati chaos
--------------
Se il gioco del caos viene eseguito con un quadrato, non appare alcun frattale e l'interno del quadrato si riempie uniformemente di punti.
Tuttavia, se vengono poste restrizioni sulla scelta dei vertici, anche nel quadrato possono apparire i fraattali.
Per esempio, supponiamo che non sia possibile scegliere (casualmente) lo stesso vertice due volte consecutive.

(define (square01 iter)
  (local (quad ax ay bx by cx cy dx dy
          p-idx idx x y rx ry out)
    (setq out '())
    ; create square
    (setq ax 0)    (setq ay 0)
    (setq bx 1500) (setq by 0)
    (setq cx 1500) (setq cy 1500)
    (setq dx 0)    (setq dy 1500)
    (setq quad (list (list ax ay) (list bx by) (list cx cy) (list dx dy)))
    ; starting point: center of square
    (setq x 750)
    (setq y 750)
    ; previous vertex
    (setq p-idx -1)
    ; iterations...
    (for (i 1 iter)
      ; select random vertex
      ; different from previous
      (while (= (setq idx (rand 4)) p-idx)
        (setq idx (rand 4))
      )
      (setq rx (first (quad idx)))
      (setq ry (last (quad idx)))
      ; update previous vertex
      (setq p-idx idx)
      ; calculate new point coordinates
      ; mid-point between (x,y) and (rx,ry)
      (setq x (div (add x rx) 2))
      (setq y (div (add y ry) 2))
      ; insert point on result list
      (push (list x y) out -1)
    )
    out))

Proviamo con 1e6 iterazioni (e con un lato prefissato di 1500 pixel):

(silent (setq q1 (square01 1e6)))
(list-IM q1 "q1.txt")
(exec "convert q1.txt square1.png")

Il file "square1.png" si trova nella cartella "data".

Per maggiori informazioni vedi: https://en.wikipedia.org/wiki/Chaos_game

Un'ultima prova con distanza 2/3 invece che 1/2:

(define (square02 iter)
  (local (quad ax ay bx by cx cy dx dy
          p-idx idx x y rx ry out)
    (setq out '())
    ; create square
    (setq ax 0)    (setq ay 0)
    (setq bx 1500) (setq by 0)
    (setq cx 1500) (setq cy 1500)
    (setq dx 0)    (setq dy 1500)
    (setq quad (list (list ax ay) (list bx by) (list cx cy) (list dx dy)))
    ; starting point: center of square
    (setq x 750)
    (setq y 750)
    ; previous vertex
    (setq p-idx -1)
    ; iterations...
    (for (i 1 iter)
      ; select random vertex
      ; different from previous
      (while (= (setq idx (rand 4)) p-idx)
        (setq idx (rand 4))
      )
      (setq rx (first (quad idx)))
      (setq ry (last (quad idx)))
      ; update previous vertex
      (setq p-idx idx)
      ; calculate new point coordinates
      ; mid-point between (x,y) and (rx,ry)
      (setq x (mul 2 (div (add x rx) 3)))
      (setq y (mul 2 (div (add y ry) 3)))
      ; insert point on result list
      (push (list x y) out -1)
    )
    out))

Creiamo l'immagine:

(silent (setq q2 (square02 1e6)))
(list-IM q2 "q2.txt")
(exec "convert q2.txt q2.png")


-------------------------------------------------
Punto a distanza L e pendenza M da un altro punto
-------------------------------------------------

Dato un punto 2D P(x0, y0), trovare i (2) punti a una distanza L da esso, tale che la linea formata dall'unione di questi punti con P abbia una pendenza di M.

La distanza tra P(x0, y0) e Q(x, y) vale:

  (y - y0)² + (x - x0)² = L²  (*)

La linea che passa per P e Q ha una pendenza:

       y - y0
  m = --------
       x - x0

Isolando y otteniamo:

  y = y0 + m*(x - x0)

Inserendo questa espressione nell'equazione (*) otteniamo:

  m²*(x - x0)² + (x - x0)² = L²
  
Le cui soluzioni sono:

  x = x0 ± L*(sqrt 1/(1 + m²))
  y = y0 ± m*L*(sqrt 1/(1 + m²))

Scriviamo la funzione:

(define (find-points point dist m)
  (local (a b px py dx dy)
    (setq a '())
    (setq b '())
    (cond ((zero? m)
            ; primo punto
            (push (add (first point) dist) a)
            (push (last point) a -1)
            ; secondo punto
            (push (sub (first point) dist) b)
            (push (last point) b -1))
          ((inf? m)
            ; primo punto
            (push (first point) a)
            (push (add (last point) dist) a -1)
            ; secondo punto
            (push (first point) b)
            (push (sub (last point) dist) b -1))
          (true
            (setq dx (div dist (sqrt (add 1 (mul m m)))))
            (setq dy (mul m dx))
            ; primo punto
            (push (add (first point) dx) a)
            (push (add (last point) dy) a -1)
            (push (sub (first point) dx) b)
            (push (sub (last point) dy) b -1))
    )
    (list a b)))

Facciamo alcune prove:

(find-points '(2 1) (sqrt 2) 1)
;-> ((3 2) (1 0))

(find-points '(1 0) 5 0)
;-> ((6 0) (-4 0))

(find-points '(1 1) 3 (div 1 0))
;-> ((1 4) (1 -2))

Nota:
(div 1 0))
;-> 1.#INF
(inf? (div 1 0))
;-> true


---------------------------------------------
Ricerca di una lista di elementi in una lista
---------------------------------------------

Supponiamo di avere la seguente lista di elementi:

(setq lst '(1 2 3 4 5 6 7 8 9))

e un altra lista di elementi da ricercare:

(setq s '(3 5))

Scrivere una funzione che restituisce una lista con gli indici degli elementi della prima lista che sono uguali agli elementi della seconda lista, cioè dobbiamo trovare gli indici degli elementi della lista "s" (3 e 5) che si trovano nella lista "lst" (1 2 3 4 5 6 7 8 9).

Possiamo usare le funzioni "find" e "map":

(find 3 lst)
;-> 2
(find 5 lst)
;-> 4
s
(map (fn(x) (find x lst)) s)
;-> (2 4)

(setq s '(3 5 21))
(map (fn(x) (find x lst)) s)
;-> (2 4 nil)

(define (find-index s lst)
    (map (fn(x) (find x lst)) s))

(find-index '(4 9 10 101) (sequence 1 20))
;-> (3 8 9 nil)

(find-index '(2 102 10 42 101) (sequence 1 20))
;-> (1 nil 9 nil nil)


-----------------------------
Classificazione dei triangoli
-----------------------------

Un triangolo può essere classificato in base alla lunghezza dei lati come:
1) equilatero
2) isoscele
3) scaleno

Inoltre può essere classificato in base agli angoli:
1) retto
2) acuto
3) ottuso

Calcoliamo prima la lunghezza dei lati e poi classifichiamo confrontando le lunghezze dei lati:
1) se tutti i lati sono uguali il triangolo è equilatero,
2) se due lati sono uguali il triangolo è isoscele
3) altrimenti sarà scaleno (tutti i lati diversi).

Per gli angoli possiamo usare il teorema di Pitagora:
1) se (d1² + d2² = d3²), allora è un triangolo retto
2) se (d1² + d2² < d3²), allora è un triangolo acuto
3) se (d1² + d2² > d3²), allora è un triangolo ottuso

Dove d1 d2 e d3 sono le distanze tra i punti ordinate in modo crescente.

(define (dist2d-2 x1 y1 x2 y2)
"Calculates the square of 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (add (mul (sub x1 x2) (sub x1 x2))
       (mul (sub y1 y2) (sub y1 y2))))

Scriviamo la funzione:

(define (triangle-type x1 y1 x2 y2 x3 y3)
  (local (d1 d2 d3 tmp out)
    (setq out '())
    ; calcolo distanze
    (setq d1 (dist2d-2 x1 y1 x2 y2))
    (setq d2 (dist2d-2 x1 y1 x3 y3))
    (setq d3 (dist2d-2 x2 y2 x3 y3))
    ; sort d1 <= d2 <= d3
    (setq tmp (sort (list d1 d2 d3)))
    (setq d1 (tmp 0))
    (setq d2 (tmp 1))
    (setq d3 (tmp 2))
    ; classificazione per lati
    (cond ((and (= d1 d2) (= d2 d3))
            (push "equilatero" out))
          ((or (= d1 d2) (= d2 d3))
            (push "isoscele" out))
          (true
            (push "scaleno" out))
    )
    ; classificazione per angoli
    (cond ((> (add d1 d2) d3)
            (push "acuto" out -1))
          ((= (add d1 d2) d3)
            (push "retto" out -1))
          (true
            (push "ottuso" out -1))
    )
    out))

Facciamo alcune prove:

(triangle-type 3 0 0 4 4 7)
;-> ("isoscele" "retto")

(triangle-type 0 0 1 1 1 2)
;-> ("scaleno" "ottuso")

(triangle-type 1 1 3 1 2 4)
;-> ("isoscele" "acuto")


------------------
Coppie simmetriche
------------------

Data una lista di coppie trovare tutte le coppie simmetriche.
Due coppie (a b) e (c d) si dicono simmetriche se a=d e b=c. Ad esempio, (12 6) e (6 12) sono simmetriche.

Prima soluzione
---------------
Esaminare ogni coppia e controllare ogni altra coppia per la simmetria. Questa soluzione richiede tempo O(n^2).

Seconda soluzione
-----------------
Ordinare tutte le coppie in base al primo elemento. Per ogni coppia, eseguire una ricerca binaria per il secondo elemento nella lista data, ovvero controllare se il secondo elemento di questa coppia esiste come primo elemento nella lista. Se trovato, confrontare il primo elemento della coppia con il secondo elemento. La complessità temporale di questa soluzione è O(n*log(n)).

Terza soluzione
---------------
Una soluzione efficiente consiste nell'usare una hash-map. Il primo elemento della coppia viene utilizzato come chiave e il secondo elemento viene utilizzato come valore. L'idea è di attraversare tutte le coppie una per una. Per ogni coppia, controllare se il suo secondo elemento è nella hash-map. In caso positivo, confrontare il primo elemento con il valore della voce corrispondente della hash-map. Se il valore e il primo elemento corrispondono, abbiamo trovato coppie simmetriche. Altrimenti, inserire il primo elemento come chiave e il secondo elemento come valore.

Quarta soluzione
----------------
Creare una nuova lista con le coppie della lista data a valori invertiti e poi fare l'intersezione di questa nuova lista con la lista data.

Implementiamo quest'ultima soluzione.

(setq lst '((11 20) (30 40) (5 10) (40 30) (10 5)))

(setq tsl (map (fn(x) (list (x 1) (x 0))) lst))
;-> ((20 11) (40 30) (10 5) (30 40) (5 10))

(intersect lst tsl)
;-> ((30 40) (5 10) (40 30) (10 5))

(define (simmetry lst)
  (intersect lst (map (fn(x) (list (x 1) (x 0))) lst)))

(simmetry lst)
;-> ((30 40) (5 10) (40 30) (10 5))

La funzione restituisce solo una coppia di coppie simmetriche anche se compaiono più di una volta:

(setq lst '((11 20) (30 40) (5 10) (40 30) (10 5) (10 5) (5 10)))

(simmetry lst)
;-> ((30 40) (5 10) (40 30) (10 5))

Comunque la funzione "intersect" ha un parametro che permette di considerare anche gli elementi multipli (basta passare "true" alla funzione):

(define (simmetry lst all)
  (if all
      (intersect lst (map (fn(x) (list (x 1) (x 0))) lst) true)
      (intersect lst (map (fn(x) (list (x 1) (x 0))) lst))))

(setq lst '((11 20) (30 40) (5 10) (40 30) (10 5) (10 5) (5 10)))

(simmetry lst)
;-> ((30 40) (5 10) (40 30) (10 5))
(simmetry lst true)
;-> ((30 40) (5 10) (40 30) (10 5) (10 5) (5 10))


---------------------
Dirigenti e impiegati
---------------------

Supponiamo di avere una lista che contiene la gerarchia tra impiegati e dirigenti come un certo numero di coppie (impiegato dirigente):

  ("A" "C")
  ("B" "C")
  ("C" "F")
  ("D" "E")
  ("E" "F")
  ("F" "F")

In questo esempio C è dirigente di A, C è anche dirigente di B, F è dirigente di C e così via.
Nota: "F" è dirigente di se stesso.

Scrivere una funzione che crea una lista i cui elementi hanno la seguente struttura:

  (nome-impiegato (lista dei suoi dipendenti))
  
Per esempio, ("A" ()) oppure ("C" ("A" "B")).

Ovviamente la lista deve contenere tutti i dipendenti.

Nota: la rappresentazione grafica della struttura è un albero

Prima scriviamo una funzione che crea una lista i cui elementi sono del tipo:

  (nome-impiegato (lista dipendenti diretti))

dove i dipendenti diretti sono quelli direttamente sotto di lui.

Per fare questo usiamo la funzione "find-all":

(setq imp-dir '(("A" "C") ("B" "C") ("C" "F") ("D" "E") ("E" "F") ("F" "F")))

(setq a (find-all '(? "A") imp-dir (first $it)))
;-> ()
(setq b (find-all '(? "B") imp-dir (first $it)))
;-> ()
(setq c (find-all '(? "C") imp-dir (first $it)))
;-> ("A" "B")
(setq d (find-all '(? "D") imp-dir (first $it)))
;-> ()
(setq e (find-all '(? "E") imp-dir (first $it)))
;-> ("D")
(setq f (find-all '(? "F") imp-dir (first $it)))
;-> ("C" "E" "F")

(define (base lst)
  (local (out rgx)
    (setq out '())
    (dolist (el lst)
      ; build regex for find-all
      ; es. rgx = (? "A")
      (setq rgx (list (sym "?") (first el)))
      ; we need to use:
      ; (find-all rgx lst (first $it))
      ; because the following don't work:
      ; (find-all '(? (first el)) lst (first $it))
      ; ... because (first el) is within a quoted list
      ; and will not be evaluated.
      (push (list (first el)
                  (find-all rgx lst (first $it)))
            out -1)
    )
    out))

Vediamo come funziona:

(base imp-dir)
;-> (("A" ()) ("B" ()) ("C" ("A" "B")) ("D" ()) ("E" ("D")) ("F" ("C" "E" "F")))

Adesso scriviamo la funzione che prende la lista generata da "base" ed espande ricorsivamente la (lista dei dipendenti diretti) per ogni nome-dipendente. Per capire meglio il funzionamento togliere i commenti alle espressioni "print" e "read-line".

(define (espande lst)
  (local (out dirigente impiegati elementi)
    (setq out '())
    (dolist (g lst)
      (setq dirigente (first g))
      (setq impiegati (last g))
      (setq elementi impiegati)
      ;(println "elementi prima: " elementi)
      (espande-aux impiegati)
      ;(println "elementi dopo: " elementi)
      ;(read-line)
      (push (list dirigente (sort (flat elementi))) out -1)
    )
    out))

; funzione che espande ricorsivamente la lista degli elementi
; utilizzando la lista degli impiegati aggiunti
(define (espande-aux employed)
  (dolist (imp employed)
      (cond ((= imp dirigente) nil) ; caso "F" = "F"
            ((= imp '()) nil) ; caso imp = '()
            ((= (lookup imp lst) '()) nil) ; caso imp = ("A" ())
            (true
              ;(println "lookup: " (lookup imp lst))
              ; modifica la lista elementi
              (push (lookup imp lst) elementi -1)
              ;(println "elementi: " elementi)
              ;(read-line)
              ; ricorsione sulla lista appena aggiunta
              (espande-aux (lookup imp lst)))
      )
  ))

Proviamo la funzione

(espande (base imp-dir))
;-> (("A" ()) 
;->  ("B" ()) 
;->  ("C" ("A" "B")) 
;->  ("D" ()) 
;->  ("E" ("D")) 
;->  ("F" ("A" "B" "C" "D" "E" "F")))

Proviamo con un esempio un pò più complesso:

(setq em '(("E" "C") ("F" "C") ("C" "B") ("D" "B") ("B" "A") ("A" "A") ("G" "A") 
           ("H" "G") ("I" "H") ("L" "F") ("K" "F") ("J" "H") ("M" "F")))

(setq bem (sort (base em)))
;-> (("A" ("B" "A" "G")) 
;->  ("B" ("C" "D")) 
;->  ("C" ("E" "F")) 
;->  ("D" ()) 
;->  ("E" ()) 
;->  ("F" ("L" "K" "M"))
;->  ("G" ("H"))
;->  ("H" ("I" "J"))
;->  ("I" ())
;->  ("J" ())
;->  ("K" ())
;->  ("L" ())
;->  ("M" ()))

(espande bem)
;-> (("A" ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M")) 
;->  ("B" ("C" "D" "E" "F" "K" "L" "M"))
;->  ("C" ("E" "F" "K" "L" "M"))
;->  ("D" ())
;->  ("E" ())
;->  ("F" ("K" "L" "M"))
;->  ("G" ("H" "I" "J"))
;->  ("H" ("I" "J"))
;->  ("I" ())
;->  ("J" ())
;->  ("K" ())
;->  ("L" ())
;->  ("M" ()))

Nota: per verificare i risultati è consigliabile disegnare l'albero gerarchico partendo dalla lista iniziale di coppie (impiegato dirigente).


--------------------
Terne con somma zero
--------------------

Data una lista di numeri interi non necessariamente distinti, trovare tutte le terne della lista la cui somma è zero.

Esempi:
lista: (0 -1 2 -3 1)
Terne a somma zero: (0 -1 1), (2 -3 1)

lista: (1 -2 1 0 5)
Terne a somma zero: (1 -2  1)

L'idea più semplice è quella di eseguire tre cicli e controllare per ogni terna di elementi se la loro somma vale zero. In caso positivo aggiungere la terna alla lista soluzione.

Algoritmo:
Eseguire tre cicli annidati con contatori i, j, k
Il primo ciclo andrà da 0 a n-3, il secondo ciclo da i+1 a n-2 e il terzo ciclo da j+1 a n-1. 
I contatori dei cicli rappresentano i tre elementi della terna.
Controllare se la somma degli elementi i-esimo, j-esimo e k-esimo è uguale a zero o meno. 
In caso positivo aggiungere la terna corrente alla lista soluzione.

(define (find-triplet lst)
  (let ((len (length lst)) (out '()))
    (for (i 0 (- len 3))
      (for (j (+ i 1) (- len 2))
        (for (k (+ j 1) (- len 1))
          (if (zero? (add (lst i) (lst j) (lst k)))
              (push (list (lst i) (lst j) (lst k)) out -1)
          )
        )
      )
    )
    out))

Verifichiamo gli esempi:

(find-triplet '(0 -1 2 -3 1))
;-> ((0 -1 1) (2 -3 1))

(find-triplet '(1 -2 1 0 5))
;-> ((1 -2 1))

Un esempio con elementi non distinti:

(find-triplet '(1 1 -2 3 3 -2))
;-> ((1 1 -2) (1 1 -2))
 
Poiché usiamo tre cicli annidati, la complessità temporale è O(n^3).


------------------
for-each di Scheme
------------------

Il linguaggio Scheme ha la primitiva "for-each" che funziona nel modo seguente:

  (for-each (lambda (x) (display (* x x))) '(1 2 3 4))
  14916

Possiamo simulare questa funzione con una macro (by HPW):

(define-macro (foreach _foreachx _foreachlst)(eval (list 'dolist (list _foreachx _foreachlst) (append (list 'begin) (args)))))
(constant (global 'foreach))

(foreach i '(1 2 3 4) (print (* i i) { }))
;-> 1 4 9 16

Un altro metodo è quello di utilizzare la funzione "map" (by Kazimir Majorinc):

(setf for-each map)
(for-each (fn(x)(println(* x x))) '(1 2 3 4))
;-> 1
;-> 4
;-> 9
;-> 16
;-> (1 4 9 16)

In Scheme, map e for-each sono gli stessi, tranne che "valore di ritorno" di for-each non è specificato. Può essere lo stesso come risultato della map (almeno secondo R6RS).


--------------------------------------
Delete symbol vs setting symbol to nil
--------------------------------------

Quando vogliamo eliminare la memoria occupata da un simbolo (ad esempio una lista con molti elementi) possiamo usare due metodi:

1) assegnare nil al simbolo con (setq <symbol> nil)
2) eliminare il simbolo con (delete <symbol>)

Il primo metodo assegna nil al simbolo e quindi la memoria viene liberata (almeno in teoria).

Nel secondo metodo l'eliminazione di un simbolo influisce sull'albero dei simboli e viene effettuato un controllo per eventuali riferimenti nel codice o nei dati. 

Vediamo un test sulla velocità dei due metodi:

(time (dotimes (zCount 1e5) (set(sym(string "TEST" zCount)) 10)))
;-> 74.828
(time (dotimes (zCount 1e5) (set(sym(string "TEST" zCount)) 10) (set (sym (string "TEST" zCount)) nil)))
;-> 110.762
(time (dotimes (zCount 1e5) (set(sym(string "TEST" zCount)) 10) (delete (sym (string "TEST" zCount)))))
;-> 7809.166

Il primo metodo è molto più veloce (110 contro 7809).

Poichè l'utilizzo della memoria di un simbolo è molto ridotto con 28 byte più la stringa del nome su newLISP a 32 bit su Windows, sembra molto più conveniente porre il simbolo a nil.


---------------------------------------------------
Similarità tra stringhe con il metodo dei trigrammi
---------------------------------------------------

Da un post del forum di newLISP ecco una funzione che calcola la similarità tra due stringhe usando il metodo dei trigrammi.
Questo metodo consiste nel trovare tutte le combinazioni di 3 lettere sequenziali in entrambe le parole e misurare la loro sovrapposizione.

Versione clojure (by Ric Szopa)

# trigrams in clojure (author: Ric Szopa)
(defn- trigrams [str]
 (let [n 3
       padding (repeat (dec n) \$)
       cleaned (remove #(Character/isWhitespace %) (concat padding
(clojure.string/lower-case str)))
       freqs (frequencies (partition n 1 cleaned))
       norm (Math/sqrt (reduce + (map #(Math/pow % 2) (vals freqs))))]
   (into {} (for [[k v] freqs] [k (/ v norm)]))))

(defn similarity [left right]
 (if (= left right)
   1.0
   (let [left (trigrams left)
         right (trigrams right)]
     (apply + (for [[trigram value] left] (* value (or (right trigram) 0)))))))

Versione newLISP (by Nick):

(define (ngrams d str, (norm 0) (str-clean (append "  " (lower-case (replace " " str "")))))
  (dotimes (i (- (length str-clean) 2))
   (bayes-train (unpack "s3" (+ i (address str-clean))) d))
  (dotree (x d true)
    (inc norm (pow ((context d x) 0))))
  (setq norm (sqrt norm))
  (dotree (x d true)
    (context d x (div ((context d x) 0) norm)))
   d)

(define (similarity left right, (accum 0))
  (if (= left right)
     1.0
     (let ((left (ngrams 'Left left))
         (right (ngrams 'Right right)))
        (dotree (s left true)
         (inc accum (mul (context Left s) (or (context Right s) 0))))
      accum)))

(similarity "banana" "bananana")
;-> 0.9722718241

Per velocizzare l'autore ha provato le seguenti strategie:
* memorizzare il set di dati in un contesto e scorrere su di esso utilizzando dotree (invece di list + dolist)
* utilizzare la funzione low-level "unpack" per iterare sulle stringhe più velocemente
* utilizzare i metodi integrati quando possibile (ad es. bayes-train)

Considerazione dell'autore (Nick):
"One consequence of all the dotree's is that I felt like I ended up doing a lot more stateful variable manipulation (eg creating a variable and then calling "inc" on it within the block of the 'dotree') than I would have in other dialects of lisp (where I would have used eg 'reduce')."


-------------------------------
Crittografia one-time pad (OTP)
-------------------------------

In crittografia, il one-time pad (OTP) è una tecnica di crittografia che non può essere decifrata, ma richiede l'uso di una chiave pre-condivisa monouso non più piccola del messaggio inviato. In questa tecnica, un testo in chiaro viene associato a una chiave segreta casuale (denominata anche one-time pad). Ogni carattere del testo in chiaro viene crittografato combinandolo con il carattere corrispondente dal pad utilizzando l'addizione modulare.

Il testo cifrato risultante sarà impossibile da decifrare se sono soddisfatte le seguenti quattro condizioni:

1) La chiave deve essere lunga almeno quanto il testo in chiaro.
2) La chiave deve essere casuale (distribuita uniformemente nell'insieme di tutte le chiavi possibili e indipendente dal testo in chiaro), interamente campionata da una fonte caotica non algoritmica come un generatore di numeri casuali hardware.
3) La chiave non deve mai essere riutilizzata in tutto o in parte.
4) La chiave deve essere tenuta completamente segreta dai comunicanti.

Questa tecnica crittografica (in forma digitale) è stata utilizzata dalle nazioni per comunicazioni diplomatiche e militari critiche, ma i problemi di distribuzione sicura delle chiavi la rendono poco pratica per la maggior parte delle applicazioni.

newLISP mette a disposizione una funzione primitiva per utilizza questa tecnica: "encrypt".
Vediamo la definizione dal manuale di riferimento:

*********************
>>> funzione ENCRYPT
*********************

sintassi: (encrypt str-source str-pad)
Esegue una crittografia one-time pad (OTP) di "str-source" utilizzando il pad di crittografia in "str-pad". Più "str-pad" è lungo e più casuali sono i byte, più sicura è la crittografia. Se il pad è lungo quanto il testo di origine, è completamente casuale e viene utilizzato solo una volta, la crittografia one-time pad è praticamente impossibile da violare, poiché la crittografia sembra contenere solo dati casuali. Per recuperare l'originale, la stessa funzione e pad vengono nuovamente applicati al testo crittografato:

(set 'secret (encrypt "A secret message" "my secret key"))
;-> ",YS\022\006\017\023\017TM\014\022\n\012\030E"

(encrypt secret "my secret key")
;-> "A secret message"

Il secondo esempio cripta un intero file:

(write-file "myfile.enc" 
  (encrypt (read-file "myfile") "29kH67*"))

(setq lst '(a 3 "a" -3.2))
(setq k (encrypt (string lst) "pippo"))
;-> "X\bPCOR\bRPBCGBY"
(encrypt k "pippo")
;-> "(a 3 \"a\" -3.2)"

Per proteggere i piccoli segreti è più che sufficiente.


-----------------------------
Fern: il frattale di Barnsley
-----------------------------

Una felce (fern) di Barnsley è un frattale che prende il nome dal matematico britannico Michael Barnsley e può essere creata utilizzando un "iterated function system (IFS)".

Il frattale viene creato usando le seguenti trasformazioni:

  f1   (1% delle volte)
          xn + 1 = 0
          yn + 1 = 0.16 yn
  f2   (85% delle volte)
          xn + 1 = 0.85 xn + 0.04 yn
          yn + 1 = −0.04 xn + 0.85 yn + 1.6
  f3   (7% delle volte)
          xn + 1 = 0.2 xn − 0.26 yn
          yn + 1 = 0.23 xn + 0.22 yn + 1.6
  f4   (7% delle volte)
          xn + 1 = −0.15 xn + 0.28 yn
          yn + 1 = 0.26 xn + 0.24 yn + 0.44.

  Posizione iniziale: x = 0, y = 0

Funzione che genera una lista di punti del frattale di Barnsley:

(define (fern iter)
  (let ((out '()) (xn 0) (yn 0))
    (push (list xn yn) out -1)
    (for (i 1 iter)
      (map set '(xn yn) (fern-point xn yn))
      (push (list xn yn) out -1)
    )
    out))

Funzione che genera il punto successivo del frattale di Barnsley:

(define (fern-point xn yn)
  (let (r (rand 100))
    (cond ((< r 1) ; f1
            (list 0 (mul 0.16 yn)))
          ((< r 86) ; f2
            (list (add (mul 0.85 xn) (mul 0.04 yn))
                  (add (mul -0.04 xn) (mul 0.85 yn) 1.6)))
          ((< r 93) ; f3
            (list (sub (mul 0.2 xn) (mul 0.26 yn))
                  (add (mul 0.23 xn) (mul 0.22 yn) 1.6)))
          (true ; f4
            (list (add (mul -0.15 xn) (mul 0.28 yn))
                  (add (mul 0.26 xn) (mul 0.24 yn) 0.44)))
    )))

(fern 10)
;-> ((0 0)
;->  (0 1.6)
;->  (0.064 2.96)
;->  (0.1728 4.113440000000001)
;->  (0.3114176000000001 5.089512000000001)
;->  (0.4682854400000001 5.913628496000001)
;->  (0.63458776384 6.607852804000002)
;->  (-1 3.199682802563201)
;->  (-0.722012687897472 4.359730382178721)
;->  (-0.4393215694257023 5.334651332367811))

Poichè i punti possono avere coordinate negative e sono raggruppati in un piccolo spazio dobbiamo scrivere una funzione che sposta i punti nel quadrante positivo (traslazione) e moltiplica le coordinate dei punti di un certo fattore (scalatura).

Funzione che sposta i punti di una lista nel quadrante positivo e moltiplica le coordinate dei punti di un certo fattore:

(define (normalize points zoom)
  (local (norm max-x min-x max-y min-y trasla-x trasla-y out)
    ; moltiplica le coordinate dei punti per il valore "zoom"
    ; e li rende numeri interi
    (setq norm (explode (map (fn(x) (int (mul zoom x))) (flat points)) 2))
    (setq max-x (norm 0 0))
    (setq min-x (norm 0 0))
    (setq max-y (norm 0 1))
    (setq min-y (norm 0 1))
    (dolist (el norm)
      ;(setq max-x (max (el 0) max-x))
      (setq min-x (min (el 0) min-x))
      ;(setq max-y (max (el 1) max-y))
      (setq min-y (min (el 1) min-y))
    )
    ; calcola i valori per la traslazione dei punti
    (setq trasla-x (add 10 (abs min-x)))
    (setq trasla-y (add 10 (abs min-y)))
    ; traslazione dei punti
    ; (solo se min-x e/o min-y minori di zero)
    (cond ((and (< min-x 0) (< min-y 0))
           (setq norm (map (fn(n) (list (add trasla-x (n 0)) (add trasla-y (n 1)))) norm)))
          ((< min-x 0)
           (setq norm (map (fn(n) (list (add trasla-x (n 0)) (n 1))) norm)))
          ((< min-y 0)
           (setq norm (map (fn(n) (list (n 0) (add trasla-y (n 1)))) norm)))
    )
    norm))

(normalize (fern 10) 10)
;-> ((0 0) (0 16) (0 29) (1 41) (3 50) (4 59) (6 66) (8 71) (9 76) (11 80) (12 84))

Funzione per generare i punti in formato ImageMagick partendo da una lista di punti:

(define (list-IM lst file-str)
  (local (outfile x-width y-height line)
    ; rimozione punti multipli
    (setq lst (sort (unique lst)))
    (setq outfile (open file-str "write"))
    (print outfile { })
    ; calcolo dimensioni immagine
    (setq x-width  (add 2 (int (apply max (map first lst)))))
    (setq y-height (add 2 (int (apply max (map last  lst)))))
    ; scrittura del file in formato ImageMagick
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                (string x-width) "," (string y-height) ",256,rgba"))
    (dolist (el lst)
      (setq line (string (string (el 0)) ", " (string (el 1))
            ": (0,0,0,255)")) ; colore nero con alpha=100%
      (write-line outfile line)
    )
    (close outfile)))

Esempio:

(list-IM '((1 1) (10 10) (20 30)) "pippo.txt")

(exec "convert pippo.txt pippo.png")

Nota: "convert" è un comando di ImageMagick.

Aprendo l'immagine "pippo.png" possiamo vedere i tre punti disegnati.

Proviamo a generare alcuni frattali di Barnsley:

1000000 punti:
(list-IM (normalize (fern 1e6) 500) "fern01.txt")
(exec "convert fern01.txt fern01.png")

5000000 punti:
(list-IM (normalize (fern 5e6) 500) "fern02.txt")
(exec "convert fern02.txt fern02.png")

I due frattali sono raffigurati (in parte) nell'immagine "fern.png" nella cartella "data".


-----------------------------
Miller: gestione CSV,TSV,JSON
-----------------------------

https://github.com/johnkerl/miller

What is Miller?
Miller is like awk, sed, cut, join, and sort for data formats such as CSV, TSV, JSON, JSON Lines, and positionally-indexed.

What can Miller do for me?
With Miller, you get to use named fields without needing to count positional indices, using familiar formats such as CSV, TSV, JSON, JSON Lines, and positionally-indexed. Then, on the fly, you can add new fields which are functions of existing fields, drop fields, sort, aggregate statistically, pretty-print, and more.

Installare "miller" (mlr.exe) in una cartella che si trova nella PATH di windows.

Eseguiamo "miller" utilizzando la funzione "exec":

(exec "mlr")
;-> mlr: no verb supplied.
;-> Usage: mlr [flags] {verb} [verb-dependent options ...] {zero or more file names}
;-> 
;-> If zero file names are provided, standard input is read, e.g.
;->   mlr --csv sort -f shape example.csv
;-> 
;-> Output of one verb may be chained as input to another using "then", e.g.
;->   mlr --csv stats1 -a min,mean,max -f quantity then sort -f color example.csv
;-> 
;-> Please see 'mlr help topics' for more information.
;-> Please also see https://miller.readthedocs.io
;-> ()

File di esempio ("example.csv" si trova nella cartella "data"):

(exec "mlr --csv cat example.csv")
;-> ("color,shape,flag,k,index,quantity,rate" "yellow,triangle,true,1,11,43.6498,9.8870"
;->  "red,square,true,2,15,79.2778,0.0130" "red,circle,true,3,16,13.8103,2.9010" "red,square,false,4,48,77.5542,7.4670"
;->  "purple,triangle,false,5,51,81.2290,8.5910" "red,square,false,6,64,77.1991,9.5310"
;->  "purple,triangle,false,7,65,80.1405,5.8240" "yellow,circle,true,8,73,63.9785,4.2370"
;->  "yellow,circle,true,9,87,63.5058,8.3350" "purple,square,false,10,91,72.3735,8.2430")

Il risultato viene restituito come una lista. Ogni elemento della lista è una strina e rappresenta una riga di dati:

(list? (exec "mlr --csv cat example.csv"))
;-> true

Stampiamo questi dati:

(dolist (el (exec "mlr --csv cat example.csv"))  (println  el))
;-> color,shape,flag,k,index,quantity,rate
;-> yellow,triangle,true,1,11,43.6498,9.8870
;-> red,square,true,2,15,79.2778,0.0130
;-> red,circle,true,3,16,13.8103,2.9010
;-> red,square,false,4,48,77.5542,7.4670
;-> purple,triangle,false,5,51,81.2290,8.5910
;-> red,square,false,6,64,77.1991,9.5310
;-> purple,triangle,false,7,65,80.1405,5.8240
;-> yellow,circle,true,8,73,63.9785,4.2370
;-> yellow,circle,true,9,87,63.5058,8.3350
;-> purple,square,false,10,91,72.3735,8.2430

Possiamo usare anche "map":

(map println (exec "mlr --csv cat example.csv"))
;-> color,shape,flag,k,index,quantity,rate
;-> yellow,triangle,true,1,11,43.6498,9.8870
;-> red,square,true,2,15,79.2778,0.0130
;-> red,circle,true,3,16,13.8103,2.9010
;-> red,square,false,4,48,77.5542,7.4670
;-> purple,triangle,false,5,51,81.2290,8.5910
;-> red,square,false,6,64,77.1991,9.5310
;-> purple,triangle,false,7,65,80.1405,5.8240
;-> yellow,circle,true,8,73,63.9785,4.2370
;-> yellow,circle,true,9,87,63.5058,8.3350
;-> purple,square,false,10,91,72.3735,8.2430

Stampiamo i dati in forma allineata:

(exec "mlr --icsv --opprint cat example.csv")
;-> ("color  shape    flag  k  index quantity rate" 
;->  "yellow triangle true  1  11    43.6498  9.8870"
;->  "red    square   true  2  15    79.2778  0.0130" 
;->  "red    circle   true  3  16    13.8103  2.9010"
;->  "red    square   false 4  48    77.5542  7.4670" 
;->  "purple triangle false 5  51    81.2290  8.5910"
;->  "red    square   false 6  64    77.1991  9.5310" 
;->  "purple triangle false 7  65    80.1405  5.8240"
;->  "yellow circle   true  8  73    63.9785  4.2370" 
;->  "yellow circle   true  9  87    63.5058  8.3350"
;->  "purple square   false 10 91    72.3735  8.2430")

(list? (exec "mlr --icsv --opprint cat example.csv"))
;-> true

(map println (exec "mlr --icsv --opprint cat example.csv"))
;-> color  shape    flag  k  index quantity rate
;-> yellow triangle true  1  11    43.6498  9.8870
;-> red    square   true  2  15    79.2778  0.0130
;-> red    circle   true  3  16    13.8103  2.9010
;-> red    square   false 4  48    77.5542  7.4670
;-> purple triangle false 5  51    81.2290  8.5910
;-> red    square   false 6  64    77.1991  9.5310
;-> purple triangle false 7  65    80.1405  5.8240
;-> yellow circle   true  8  73    63.9785  4.2370
;-> yellow circle   true  9  87    63.5058  8.3350
;-> purple square   false 10 91    72.3735  8.2430

Stampiamo solo le righe che hanno color=yellow:

(map println (exec "mlr --csv filter '$color == \"yellow\"' example.csv"))
;-> color,shape,flag,k,index,quantity,rate
;-> yellow,triangle,true,1,11,43.6498,9.8870
;-> yellow,circle,true,8,73,63.9785,4.2370
;-> yellow,circle,true,9,87,63.5058,8.3350
;-> ("color,shape,flag,k,index,quantity,rate" "yellow,triangle,true,1,11,43.6498,9.8870"
;->  "yellow,circle,true,8,73,63.9785,4.2370" "yellow,circle,true,9,87,63.5058,8.3350")

Nota: i caratteri doppio apice ("") devono essere protetti dal carattere di escape (\):
Per esempio "yellow" diventa \" yellow\". Proteggere (").

Estrarre i primi record o gli ultimi (l'intestazione CSV è inclusa in entrambi i modi):

(map println (exec "mlr --csv head -n 4 example.csv"))
;-> color,shape,flag,k,index,quantity,rate
;-> yellow,triangle,true,1,11,43.6498,9.8870
;-> red,square,true,2,15,79.2778,0.0130
;-> red,circle,true,3,16,13.8103,2.9010
;-> red,square,false,4,48,77.5542,7.4670

(map println (exec "mlr --csv tail -n 4 example.csv"))
;-> color,shape,flag,k,index,quantity,rate
;-> purple,triangle,false,7,65,80.1405,5.8240
;-> yellow,circle,true,8,73,63.9785,4.2370
;-> yellow,circle,true,9,87,63.5058,8.3350
;-> purple,square,false,10,91,72.3735,8.2430

Estrarre gli ultimi due record in formato JSON:

(map println (exec "mlr --icsv --ojson tail -n 2 example.csv"))
;-> [
;-> {
;->   "color": "yellow",
;->   "shape": "circle",
;->   "flag": "true",
;->   "k": 9,
;->   "index": 87,
;->   "quantity": 63.5058,
;->   "rate": 8.3350
;-> },
;-> {
;->   "color": "purple",
;->   "shape": "square",
;->   "flag": "false",
;->   "k": 10,
;->   "index": 91,
;->   "quantity": 72.3735,
;->   "rate": 8.2430
;-> }
;-> ]
;-> ("[" "{" "  \"color\": \"yellow\"," "  \"shape\": \"circle\"," "  \"flag\": \"true\","
;->  "  \"k\": 9," "  \"index\": 87," "  \"quantity\": 63.5058," "  \"rate\": 8.3350"
;->  "}," "{" "  \"color\": \"purple\"," "  \"shape\": \"square\"," "  \"flag\": \"false\","
;->  "  \"k\": 10," "  \"index\": 91," "  \"quantity\": 72.3735," "  \"rate\": 8.2430"
;->  "}" "]")

Ordinamento per un campo (shape):

(map println (exec "mlr --icsv --opprint sort -f shape example.csv"))
;-> color  shape    flag  k  index quantity rate
;-> red    circle   true  3  16    13.8103  2.9010
;-> yellow circle   true  8  73    63.9785  4.2370
;-> yellow circle   true  9  87    63.5058  8.3350
;-> red    square   true  2  15    79.2778  0.0130
;-> red    square   false 4  48    77.5542  7.4670
;-> red    square   false 6  64    77.1991  9.5310
;-> purple square   false 10 91    72.3735  8.2430
;-> yellow triangle true  1  11    43.6498  9.8870
;-> purple triangle false 5  51    81.2290  8.5910
;-> purple triangle false 7  65    80.1405  5.8240

Ordinamento primario per un campo alfabetico (shape) e secondario decrescente su un campo numerico (index):

(map println (exec "mlr --icsv --opprint sort -f shape -nr index example.csv"))
;-> color  shape    flag  k  index quantity rate
;-> yellow circle   true  9  87    63.5058  8.3350
;-> yellow circle   true  8  73    63.9785  4.2370
;-> red    circle   true  3  16    13.8103  2.9010
;-> purple square   false 10 91    72.3735  8.2430
;-> red    square   false 6  64    77.1991  9.5310
;-> red    square   false 4  48    77.5542  7.4670
;-> red    square   true  2  15    79.2778  0.0130
;-> purple triangle false 7  65    80.1405  5.8240
;-> purple triangle false 5  51    81.2290  8.5910
;-> yellow triangle true  1  11    43.6498  9.8870

Se ci sono campi che non vogliamo vedere nei dati, possiamo usare "cut" per mantenere solo quelli che vogliamo, nello stesso ordine in cui appaiono nei dati di input:

(map println (exec "mlr --icsv --opprint cut -f flag,shape example.csv"))
;-> shape    flag
;-> triangle true
;-> square   true
;-> circle   true
;-> square   false
;-> triangle false
;-> square   false
;-> triangle false
;-> circle   true
;-> circle   true
;-> square   false

Possiamo anche usare cut -o per mantenere i campi specificati, ma nell'ordine preferito:

(map println (exec "mlr --icsv --opprint cut -o -f flag,shape example.csv"))
;-> flag  shape
;-> true  triangle
;-> true  square
;-> true  circle
;-> false square
;-> false triangle
;-> false square
;-> false triangle
;-> true  circle
;-> true  circle
;-> false square

Possiamo usare "cut -x" per togliere i campi che non ci interessano:

(map println (exec "mlr --icsv --opprint cut -x -f flag,shape example.csv"))
;-> color  k  index quantity rate
;-> yellow 1  11    43.6498  9.8870
;-> red    2  15    79.2778  0.0130
;-> red    3  16    13.8103  2.9010
;-> red    4  48    77.5542  7.4670
;-> purple 5  51    81.2290  8.5910
;-> red    6  64    77.1991  9.5310
;-> purple 7  65    80.1405  5.8240
;-> yellow 8  73    63.9785  4.2370
;-> yellow 9  87    63.5058  8.3350
;-> purple 10 91    72.3735  8.2430

Anche se il principale punto di forza di Miller è l'indicizzazione dei nomi, a volte si desidera davvero fare riferimento a un nome di campo tramite il suo indice di posizione. Usa $[[3]] per accedere al nome del campo 3 o $[[[3]]] per accedere al valore del campo 3:

(map println (exec "mlr --icsv --opprint put '$[[3]] = \"NEW\"' example.csv"))
;-> color  shape    NEW   k  index quantity rate
;-> yellow triangle true  1  11    43.6498  9.8870
;-> red    square   true  2  15    79.2778  0.0130
;-> red    circle   true  3  16    13.8103  2.9010
;-> red    square   false 4  48    77.5542  7.4670
;-> purple triangle false 5  51    81.2290  8.5910
;-> red    square   false 6  64    77.1991  9.5310
;-> purple triangle false 7  65    80.1405  5.8240
;-> yellow circle   true  8  73    63.9785  4.2370
;-> yellow circle   true  9  87    63.5058  8.3350
;-> purple square   false 10 91    72.3735  8.2430

(map println (exec "mlr --icsv --opprint put '$[[[3]]] = \"NEW\"' example.csv"))
;-> color  shape    flag k  index quantity rate
;-> yellow triangle NEW  1  11    43.6498  9.8870
;-> red    square   NEW  2  15    79.2778  0.0130
;-> red    circle   NEW  3  16    13.8103  2.9010
;-> red    square   NEW  4  48    77.5542  7.4670
;-> purple triangle NEW  5  51    81.2290  8.5910
;-> red    square   NEW  6  64    77.1991  9.5310
;-> purple triangle NEW  7  65    80.1405  5.8240
;-> yellow circle   NEW  8  73    63.9785  4.2370
;-> yellow circle   NEW  9  87    63.5058  8.3350
;-> purple square   NEW  10 91    72.3735  8.2430

Possiamo usare "filter" per estrarre solo i record che ci interessano:

(map println (exec "mlr --icsv --opprint filter '$color == \"red\"' example.csv"))
;-> color shape  flag  k index quantity rate
;-> red   square true  2 15    79.2778  0.0130
;-> red   circle true  3 16    13.8103  2.9010
;-> red   square false 4 48    77.5542  7.4670
;-> red   square false 6 64    77.1991  9.5310

Nota: Miller ha anche la possibilità di utilizzare una sintassi simile a quella di un linguaggio di programmazione.


---------------------------
La funzione labels del LISP
---------------------------

Vediamo una macro (scritta da johu) che simula la funzione LABELS del LISP.

Dal manuale del LISP:

Syntax:

labels bindings body (zero or more) => an object

Argument description:
  bindings list containing function definitions
  body     program code in which definitions above are effective, implicit progn

LABELS is special form for local function binding. Bindings can be recursive and can refer to each other. Each binding contains function name, arguments, and function body. See FLET, DEFUN, LAMBDA.

(labels ((fact2x (x) (fact (* 2 x)))
         (fact (x) (if (< x 2) 1 (* x (fact (1- x))))))
  (fact2x 3))
 => 720

From the Hyperspec: labels is equivalent to flet except that the scope of the defined function names for labels encompasses the function definitions themselves as well as the body.

What this means practically is that labels allows you to write recursive functions. For example:

(defun fact (n)
  (labels ((rec (x)
             (if (< x 1) 
                 1
                 (* x (rec (- x 1))))))
    (rec n)))

This function works fine, but the same function written with flet will cause an error because the symbol rec will not be bound in the function definition. The sample function you provided would cause an error if it was written with flet for the same reason.

Partendo da una REPL nuova:

labels
;-> nil

(context 'MAIN:labels)
(define-macro (labels:labels)
  (letex (_labels (append '(let)
                           (list (map (fn (x) (list (x 0) (append '(fn) (list (x 1)) (2 x)))) (args 0)))
                           (1 (args))))
     _labels))
;-> (lambda-macro ()
;->  (letex (_labels (append '(let) (list (map (lambda (x) (list (x 0) (append '(lambda )
;->          (list (x 1))
;->          (2 x))))
;->       (args 0)))
;->     (1 (args)))) _labels))

(context MAIN)
;-> MAIN

(define (test-a x)
        (labels ((in-test (x y) (println "test-a " x " " y))) (in-test x "a")))
;-> (lambda (x) 
;-> (labels ((in-test (x y) (println "test-a " x " " y))) (in-test x "a")))

(define (test-b x)
        (labels ((in-test (x y) (println "test-b " x " " y))) (in-test "b" x)))
;-> (lambda (x) 
;-> (labels ((in-test (x y) (println "test-b " x " " y))) (in-test "b" x)))

(define (in-test x)
        (println "test-out " x))
;-> (lambda (x) (println "test-out " x))

labels:labels
;-> (lambda-macro ()
;->  (letex (_labels (append '(let) (list (map (lambda (x) (list (x 0) (append '(lambda )
;->          (list (x 1))
;->          (2 x))))
;->       (args 0)))
;->     (1 (args)))) _labels))

(in-test "in-test")
;-> test-out in-test
;-> "in-test"

(test-a "test-a")
;-> test-a test-a a
;-> "a"

(test-b "test-b")
;-> test-b b test-b
;-> "test-b"

(in-test "in-test")
;-> test-out in-test
;-> "in-test"

(define (test-2 x y)
        (labels ((test-x (x) (println "test1 x=" x))
                 (test-y (x) (println "test2 y=" x)))
                (test-x x)
                (test-y y)))
;-> (lambda (x y) (labels ((test-x (x) (println "test1 x=" x)) (test-y (x) 
;->   (println "test2 y=" x)))
;->   (test-x x)
;->   (test-y y)))

(test-2 "a" "b")
;-> test1 x=a
;-> test2 y=b
;-> "b"

Nota: codice veramente interessante

Nota: newLISP non ha bisogno di costrutti come flet o labels. Questi hanno senso (in effetti, sono necessari) in linguaggi come Common Lisp in cui i nomi delle funzioni e i nomi delle variabili risiedono in spazi dei nomi diversi.
Nei linguaggi Lisp-1 come newLISP e Scheme i nomi delle funzioni e i nomi delle variabili risiedono nello stesso spazio dei nomi, quindi flet e labels non sono necessari in questi linguaggi.


---------------------------
A LISP programming exercise
---------------------------

"A LISP programming exercise" by Jan L.A. Van De Snepscheut
Department of Computer Science, California Institute of Technology, Pasadena, CA 91125, USA
Information Processing Letters 42 (1992) 103-108

Sono dati due oggetti (liste) LISP. Scrivere una funzione booleana che restituisca true solo quando i due argomenti hanno la stessa "frange".
La "frange" di un oggetto è la lista degli atomi nell'oggetto nel loro ordine di occorrenza e ignorando la struttura tra parentesi nell'oggetto dato.

Esempi:

  (same (a (b c)) ((a (b)) (c))) --> true

  (same (a (b c)) ((a (c)) (b))) --> nil

L'articolo propone il seguente programma LISP come (prima) soluzione:

(define (same (lambda (a b)
  (samefringe (fringe a) (fringe b))))

(fringe (lambda (x)
  (cond ((null x) nil)
        ((atom x) (cons x nil))
        (t (append (fringe (car x)) (fringe (cdr x)))))))

(samefringe (lambda (fra frb)
    (cond ((null fra) (null frb))
          ((null frb) nil)
          ((eq (car fra) (car frb))
           (samefringe (cdr fra) (cdr frb)))
          (t nil))))
)

Per convertire il programma in newLISP notiamo che in LISP (CLISP):

> (cons '(1) nil)
-> ((1))
> (cons 1 nil)
-> (1)

Mentre in newLISP:

(cons '(1) nil)
;-> ((1) nil)
(cons 1 nil)
;-> (1 nil)

Allora per ottenere lo stesso risultato del LISP usiamo "list" senza nil:

(list '(1))
;-> ((1))
(list 1)
;-> (1)

Versione del programma in newLISP:

(define car first)
(define cdr rest)

(define (same? a b)
  (samefringe (fringe a) (fringe b)))

(define (fringe x)
  (cond ((null? x) '())
        ((atom? x) (list x))
        (true (append (fringe (car x)) (fringe (cdr x))))))

(fringe '((a) (b) c))
;-> (a b c)

(define (samefringe fra frb)
    (cond ((null? fra) (null? frb))
          ((null? frb) nil)
          ((= (car fra) (car frb))
           (samefringe (cdr fra) (cdr frb)))
          (true nil)))

Proviamo la funzione:

(same? '(a (b c)) '((a (b)) (c)))
;-> true

(same? '(a (b c)) '((a (c)) (b)))
;-> nil

L'articolo prosegue con la scrittura di un programma più efficiente basandosi sull'osservazione che la soluzione sopra costruisce due frange complete e solo successivamente inizia a confrontarle. 
Per motivi di efficienza sarebbe molto meglio se potessimo combinare le due operazioni e, soprattutto, fermare sia il confronto che i processi di costruzione appena si riscontra una differenza tra le due frange.
Nel peggiore dei casi, quando le due frange sono uguali, non deriva alcun beneficio da tale soluzione, ma in tutti gli altri casi si ha una riduzione dei tempi di esecuzione. Inoltre, calcolare gli atomi e confrontarli al volo riduce il consumo di memoria in quanto viene memorizzato niente.

(define (same (lambda (a b)
  (samesplit (split a) (split b))))

(split (lambda (x)
  (cond ((null x) nil)
        ((atom x) (cons x nil))
        (t (f (split (car x)) (cdr x))))))

(f (lambda (scarx cdrx)
  (cond ((null scarx) (split cdrx))
        (t (cons (car (scarx)) (cons (cdr scarx) cdrx))))))
            
(samesplit (lambda (spa spb)
  (cond ((null spa) (null spb))
        ((null spb) nil)
        ((eq (car spa) (car spb))
          (samesplit (split (cdr spa)) (split (cdr spb))))
        (t nil)))))

Invece di convertire questo programma, vediamo come possiamo scrivere la funzione in newLISP. Usiamo la funzione "flat" per ottenere la "frange" di ogni lista e poi le confrontiamo:

(define (frange lst) (flat lst))
(define (same-frange? lst1 lst2)
  (= (frange lst1) (frange lst2)))

(define (same-frange? lst1 lst2)
  (= (flat lst1) (flat lst2)))

(same-frange? '(a (b c)) '((a (b)) (c)))
;-> true

(same-frange? '(a (b c)) '((a (c)) (b)))
;-> nil

Vediamo la velocità delle due funzioni:

(setq obj1 '(a (b) (c (d) (e) (f (g) (h) i) l) (m n) (o) (p q (r (s t (((u))) v z)))))
(setq obj2 '(a (b) (c (d) (e) (f (g) (x) i) l) (m n) (o) (p q (r (s t (((u))) v z)))))

(time (same? obj1 obj2) 1e5)
;-> 2847.412

(time (same-frange? obj1 obj2) 1e5)
;-> 94.774


--------------------
Formattazione di nil
--------------------

Supponiamo di avere una lista con alcuni elementi che valgono "nil":

(setq lst '("apple" "banana" nil nil "peach"))

e di voler stampare la lista come un file CSV (Comma Separated Value):

  apple,banana,,,peach

La seguente espressione provoca un errore perchè "nil" non è una stringa:

(format "%s,%s,%s,%s" lst)
;-> ERR: data type and format don't match in function format : nil

Allora possiamo sostituire "nil" con la stringa vuota "":

(format "%s,%s,%s,%s,%s" (replace nil lst ""))
;-> "apple,banana,,,peach"
lst
;-> ("apple" "banana" "" "" "peach")

La funzione "replace" è distruttiva, quindi se vogliamo mantenere la lista originale dobbiamo applicare "replace" ad una copia della lista:

(setq lst '("apple" "banana" nil nil "peach"))
(format "%s,%s,%s,%s,%s" (replace nil (copy lst) ""))
;-> "apple,banana,,,peach"
lst
;-> ("apple" "banana" nil nil "peach")

Un altro metodo è il seguente:

(format "%s,%s,%s,%s,%s" (map (fn (x) (or x "")) lst))
;-> "apple,banana,,,peach"

Vediamo la velocità dei due metodi:

(define (m1)
  (setq lst '("apple" "banana" nil nil "peach"))
  (replace nil lst ""))

(define (m2)
  (setq lst '("apple" "banana" nil nil "peach"))
  (map (fn (x) (or x "")) lst))

(time (m1) 100000)
;-> 74.803

(time (m2) 100000)
;-> 140.122

La seconda funzione è più lenta perchè usare "map" con funzioni anonime ne rallenta l'esecuzione.


---------------------------
La funzione juxt di Clojure
---------------------------

Il linguaggio clojure ha la funzione juxtaposition ("juxt") che prende un insieme di funzioni e restituisce una fn che è la giustapposizione di quelle fn. La fn restituita accetta un numero variabile di argomenti e restituisce una lista contenente il risultato dell'applicazione di ciascun fn agli argomenti (da sinistra a destra).
Esempio:
((juxt a b c) x) => ((a x) (b x) (c x))

Vediamo l'implementazione in newLISP di rickyboy:

(define (juxt)
  (letex (_args (args))
    (lambda (x)
      (let (fs '_args)
        (map (lambda (f) (f x)) fs)))))

((juxt sin cos tan) 10)
;-> (-0.5440211108893698 -0.8390715290764524 0.6483608274590866)

(sin 10)
;-> -0.5440211108893698
(cos 10)
;-> -0.8390715290764524
(tan 10)
;-> 0.6483608274590866


------------------
La funzione if-not
------------------

Dal manuale della versione 10.7.5:

"Since version 10.4.2 if-not is deprecated and will be removed in a future version."

Comunque la primitiva "if-not" è ancora presente nella versione 10.7.5, come si deduce analizzando i simboli di newLISP (partendo da una REPL nuova):

(filter (fn(x) (starts-with (string x) "if")) (symbols))
;-> (if if-not ifft)

Come funziona "if-not"?
if-not
- (if-not test then)
- (if-not test then else)

Evaluates test. If logical false, evaluates and returns then expr, otherwise else expr, if supplied, else nil.

Logica di un test con "if-not":

(if test then else)
(if-not test then else)

Logica dello stesso test senza "if-not":

(if test then else)
(if (not test) then else)

Dal punto di vista logico, la funzione "if-not" è complementare alla funzione "if".
Comunque le sintassi non sono perfettamente complementari, per esempio:

(if-not 1 2 3 4 5 6)
;-> 3

(if (not 1) 2 3 4 5 6)
;-> 4

Comunque non bisogna utilizzare clausole "true" multiple altrimenti il codice è di difficile lettura.

"The function will 'keep working for an indefinite time'."
"if-not will not be removed."
Lutz


----------------------------
Simulare un iteratore python
----------------------------

In python è possibile scrivere il seguente codice:

>>> lst = [3, 2, 1]
>>> s = iter(lst)
>>> s
<listiterator object at 0xb741e0cc>
>>> s.next()
3
>>> s.next()
2
>>> s.next()
1
>>> s.next()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration

Dove "s" è un oggetto e non una copia della lista originale.

Per simulare questo comportamento possiamo utilizzare la funzione "pop":

Per rimuovere un elemento dall'inizio della lista:

(setq s '(3 2 1))

(pop s)
;-> 3
(pop s)
;-> 2
(pop s)
;-> 1
(pop s)
;-> nil

Per rimuovere un elemento dalla fine della lista:

(setq s '(3 2 1))

(pop s -1) 
;-> 1
(pop s -1) 
;-> 2
(pop s -1) 
;-> 3
(pop s -1) 
;-> nil

Un altro metodo è quello di utilizzare la seguente macro (by conan):

(context 'next)

(setq seenSymbols '())

(define-macro (next:next aList)
    (unless (ref (string aList) next:seenSymbols)
        (push (list (string aList) (copy (eval aList))) next:seenSymbols))
    (pop (next:seenSymbols (first (ref (string aList) next:seenSymbols)) 1))
)

(context MAIN)
;-> MAIN

(setq lst '(1 2 3))
(next:next lst)
;-> 1
(next:next lst)
;-> 2
(next:next lst)
;-> 3
(next:next lst)
;-> nil
(next:next lst)
;-> nil


--------------------------------------------
Modifica/aggiornamento di una lista annidata
--------------------------------------------

Supponiamo di avere la seguente lista:

(set (global 'me) '(
  (80 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))) )
  (25 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))) )
  ))

Utilizzandola come lista associativa possiamo scrivere:

; returns all "80" results
(assoc 80 me)
;-> (80 (1010 
;-> ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))

; returns all "80" + "1010" results
(assoc (list 80 1010) me)
;-> (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101)))
; returns the list for 80 + 1010
(last (assoc (list 80 1010) me))
;-> ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))

La domanda è: come inserire una lista nei risultati di (last (assoc (list 80 1010) me))?

Possiamo usare "set-ref":

(set-ref (assoc (list 80 1010) me) me (append $it (list "more stuff")))
;-> ((80 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))
;->    "more stuff"))
;->  (25 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101)))
;-> ))

Questo può essere reso ancora più semplice. L'esempio cerca "me" due volte. Prima "assoc" cerca internamente a "me" poi
"set-ref" cerca di nuovo in "me" l'espressione trovata da "assoc".

In questo caso possiamo semplicemente usare "setf":

(set (global 'me) '(
  (80 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))) )
  (25 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))) )
  ))

(setf (assoc '(80 1010) me)  (append $it (list "more stuff")))
;-> (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101)) "more stuff")

Il riferimento restituito da "assoc" può essere utilizzato da "setf".. e possiamo renderlo ancora più breve usando "push":

(set (global 'me) '(
  (80 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))) )
  (25 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))) )
  ))

(push "more stuff" (assoc '(80 1010) me) -1)
;-> (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101)) "more stuff")

"push" può anche usare riferimenti di luogo e puoi controllare meglio dove posizionare esattamente il nuovo elemento:

(set (global 'me) '(
  (80 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))) )
  (25 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101))) )
  ))

(push "more stuff" (assoc '(80 1010) me) -1 -1)
;-> (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101) "more stuff"))

me
;-> ((80 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101)
;->     "more stuff")))
;->  (25 (1010 ((84 114 117 115 116 80 105 112 101 73 115 65 119 101 115 111 109 101)))))

in questo caso, il nuovo elemento viene inserito in un livello di annidamento più in alto.


-------------------------------------------
Algoritmo del punteggio (Scoring algorithm)
-------------------------------------------

Analizza i dati utilizzando un algoritmo di prossimità percentuale basato su un intervallo e calcola la stima lineare della massima verosimiglianza.
Il principio di base è che tutti i valori forniti verranno suddivisi in un intervallo da 0 a 1 e il punteggio di ciascuna colonna verrà sommato per ottenere il punteggio totale.
Praticamente, è una forma del metodo di Newton utilizzato in statistica per risolvere le equazioni di massima verosimiglianza.

Esempio:
Dati delle automobili
  prezzo | chilometraggio | anno di immatricolazione
  20     | 60             | 2012
  22     | 50             | 2011
  23     | 90             | 2015
  16     | 210            | 2010

Vogliamo l'automobile con il prezzo più basso, il chilometraggio più basso, ma l'anno di immatricolazione più recente. 
Pertanto i pesi per ciascuna colonna sono i seguenti: (0 0 1)

(define (scores data weights)
  (local (data-lists score-lists score min-el max-el final-scores)
    ; transpose data
    (setq data-lists (transpose data))
    (setq score-lists '())
    ; calcola il punteggio per ogni colonna
    (dolist (el data-lists)
      (setq min-el (apply min el))
      (setq max-el (apply max el))
      (setq score '())
      (setq w (weights $idx))
      (cond ((zero? w) ; peso zero --> score 1
              (dolist (item el)
                (if (zero? (sub max-el min-el))
                    (push 1 score -1)
                    (push (sub 1 (div (sub item min-el) (sub max-el min-el))) score -1)
                )
              )
            )
            ((= 1 w) ; peso 1 --> score 0
              (dolist (item el)
                (if (zero? (sub max-el min-el))
                    (push 0 score -1)
                    (push (div (sub item min-el) (sub max-el min-el)) score -1)
                )
              )
            )
            ; errore: peso diverso da 0 e 1
            (true (println "Wrong Weight: " w))
      )
      (push score score-lists -1)
    )
    ; calcola punteggi finali
    (setq final-scores '())
    (dolist (el (transpose score-lists))
      (push (apply add el) final-scores -1)
    )
    ; combina i dati iniziali e i punteggi finali
    (map list data final-scores)
))

Facciamo una prova:

(setq dati '((20 60 2012) (23 90 2015) (22 50 2011)))
(setq pesi '(0 0 1))

(scores dati pesi)
;-> (((20 60 2012) 2) 
;->  ((23 90 2015) 1) 
;->  ((22 50 2011) 1.333333333333334))


--------------------------
Alfabeto, cifre, caratteri
--------------------------

Alfabeto latino
---------------
Minuscole
(setq chr-lower '())
(for (i 97 122) (push (char i) chr-lowers -1 ))
;-> ("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
;->  "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
Maiuscole
(setq chr-upper '())
(for (i 65 90) (push (char i) chr-upper -1 ))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
;->  "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

Cifre
-----
(setq chr-digit '())
(for (i 48 57) (push (char i) chr-digit -1 ))
;-> ("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")

Caratteri esadecimali
---------------------
Minuscole
(setq chr-hexl (append chr-digit '("a" "b" "c" "d" "e" "f")))
;-> ("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f")
Maiuscole
(setq chr-hexu (append chr-digit '("A" "B" "C" "D" "E" "F")))
;-> ("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F")

Caratteri di punteggiatura
--------------------------
(setq chr-punct '("." "!" "?" "," ";" ":"))
;-> ("." "!" "?" "," ";" ":")

Caratteri ASCII
---------------
(setq chr-ascii '())
(for (i 32 126) (push (char i) chr-ascii -1))
;-> (" " "!" "\"" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-"
;->  "." "/" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" ":" ";"
;->  "<" "=" ">" "?" "@" "A" "B" "C" "D" "E" "F" "G" "H" "I"
;->  "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W"
;->  "X" "Y" "Z" "[" "\\" "]" "^" "_" "`" "a" "b" "c" "d" "e"
;->  "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
;->  "t" "u" "v" "w" "x" "y" "z" "{" "|" "}" "~")

Nota: i caratteri doppio apice "\"" e backslash "\\" hanno bisogno del carattere di escape (\).

=============================================================================

