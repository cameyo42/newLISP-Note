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

Modificando la funzione è possibile aggiungere altri tipi oltre a "int", "flt" e "str".

=============================================================================

