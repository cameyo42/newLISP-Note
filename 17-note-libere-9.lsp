===============

 NOTE LIBERE 9

===============

  Quadrato magico di Durer
       16  3  3 13
        5 10 11  8
        9  6  7 12
        4 15 14  1

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

Controlliamo che il simbolo esiste:
(sym "a" MAIN nil)
;-> a
a
;-> 1

Assegnazione con "setq" (senza il simbolo quotato):
(setq b 2)
;-> 2

Controlliamo che il simbolo esiste:
(sym "b" MAIN nil)
;-> b
b
;-> 2

Assegnazione con "setq" (usando il simbolo quotato):
(setq 'c 3)
;-> 3 ; esiste un output

Controlliamo che il simbolo esiste:
(sym "c" MAIN nil)
;-> c
c
;-> nil
Il simbolo "c" esiste, ma non ha il valore 3 associato.

Vediamo quali simboli sono stati creati:

(difference (symbols) simboli)
;-> (a b c)

Vediamo i valori dei simboli creati:

(println "a = " a ", b = " b ", c = " c})
;-> a = 1, b = 2, c = nil

Dove è finito il valore 3?

Inoltre (setq 'c 3) non è uguale a (set ''c 3):

(set ''c 3)
;-> ERR: symbol expected in function set : ''c

L'espressione (setq 'c 3) esegue la modifica sul posto del simbolo "c":

(setq 'c 3)
;-> 3
c
;-> nil
(define (foo) (setq 'c 3))
;-> (lambda () (setq 'c 3))
(foo)
;-> 3
foo
;-> (lambda () (setq '3 3))

Per ulteriori esempi, vedere l'ultimo capitolo su questa pagina: http://www.newlisp.org/index.cgi?Closures (Closures, Contexts and Stateful Functions).

Anche l'errore generato da (set ''c 3) è corretto, infatti il primo argomento di "set" dovrebbe essere un simbolo, ma ''c (che può essere considerato un'abbreviazione di (quote (quote c))) restituisce (quote c) che è di tipo quote, non un simbolo.

Inoltre risulta:

(quote? ''y)
;-> true
(quote? (quote (quote x)))
;-> nil

Questo perchè "quote" e "'" non sono la stessa cosa. La funzione "quote" viene eseguita in fase di esecuzione (run-time), mentre "'" viene risolta in fase di lettura/compilazione (reader/compile).
Prima della valutazione (quote x) è una lista, ma 'x è una x quotata. Quindi:

; uno è un simbolo quotato, l'altro una lista

(quote? ''x) => true
(list? '(quote x)) => true

; al livello superiore entrambi valutano allo stesso modo:

(= (quote 'x) ''x) => true
(= (quote (quote x)) '(quote x)) => true

; e
(quote? (quote 'x)) => true

; ma
(= '(quote x) ''x) => nil

; e
(quote? '(quote x)) => nil

A livello di valutazione, entrambi fanno la stessa, cioè che è creare uno "scudo" alla valutazione che non fa nulla.


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

Utilizziamo ImageMagick per generare l'immaginew partendo da un file di punti. Per mggiori informazioni vedi "Creazione di immagini con ImageMagick" nel capitolo "Note libere 7".

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


-------------
Algoritmo CYK
-------------

Il codice seguente, scritto da Patrick Lerner, implementa l'algoritmo CYK per rilevare se una parola può essere costruita utilizzando una grammatica context-free in forma normale di Chomsky.
Link: https://github.com/PatrickLerner/newLISP/blob/master/attic/cyk.lsp

#!/usr/local/bin/newlisp
;; Copyright (c) 2012, Patrick Lerner (patricklerner@me.com)
;; All rights reserved.
;; 
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met: 
;; 
;; 1. Redistributions of source code must retain the above copyright notice, 
;;    this list of conditions and the following disclaimer. 
;; 2. Redistributions in binary form must reproduce the above copyright 
;;    notice, this list of conditions and the following disclaimer in the 
;;    documentation and/or other materials provided with the distribution. 
;; 
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
;; POSSIBILITY OF SUCH DAMAGE.

;; Required: util:fold
;(load "/Users/patrick/Projects/newLISP/lib/util.lsp")
;; funct item (listof item) ~> item
;; folds an element using the function f so that initially we calculate
;; (f (first lst) i0) and then for subsequent items in lst (f item v), where
;; item is the next item and v is the result of the last function call
;; 
;; note that unlike the scheme function with the same name, this one only 
;; accepts a single list as argument
(define (fold f i0 lst)
  (apply (fn (v x) (f x v)) (cons i0 lst) 2))

;; ===========================================================================
;;  DESCRIPTION
;; ===========================================================================

;; This implements the CYK algorithm for detecting if a word can be build
;; using a context-free grammar in Chomsky normal form.
;; 
;; Created to test the correctness of a homework for the FGdI I class @
;; TU Darmstadt in the summer of 2012. Homework assignment 6, exercise 1.
;; 
;; Time to implement: ~4-5h+ (this is the rewrite of a quick and dirty 
;; version, so that's why it took so long. Second implementation alone took
;; ~2h).
;; 
;; Creation date: 2012-05-25 2:43 AM CEST.

;; ===========================================================================
;;  FUNCTIONS AREA
;; ===========================================================================

;; string grammar ~> (listof string)
;; Takes a constructed string which is the construct we are looking for
;; (e.g. "a" for a terminal or "TS" for a symbol construct) and a grammar
;; definition and returns a list of which variables can build this construct
(define (find-accepting-productions construct grammar)
  ;(util:fold
  (fold
        (fn (x v)
          (if (find construct (x 1))
              (cons (x 0) v)
              v))
        '()
        grammar))

;; number number string grammar ~> (listof string)
;; Calculates which symbols from the grammar are able to produce a cell in
;; the cyk-table.
(define (calculate-cell row col word grammar)
  (if (= row 0)
      ;; if we are looking at the first row, this is trivial
      ;; just look for a terminal:
      (find-accepting-productions (word col) grammar)
      ;; for subsequent rows it is less trivial, we need recursion
      ;;
      ;; First, we need to compare 0 to row-1 fields to eachother
      ;; the fields in question are calculated as:
      ;; k|col and (row - k - 1)|(row + k + 1) where the coordinates are
      ;; y|x in the table.
      ;;
      ;; Now basically, we always need to get the posibilies for these fields
      ;; recursively and then try all permuations of the possibilies for these
      ;; fields to each other and look if they can be produced by our grammar.
      (unique (apply append (map
          (fn (k)
             (apply append (map
                (fn (x) (find-accepting-productions x grammar))
                (permutations
                  (calculate-cell k col word grammar)
                  (calculate-cell (- row k 1) (+ col k 1) word grammar)))))
          (sequence 0 (- row 1)))))))

;; (listof string) (listof string) ~> (listof string)
;; Creates a list of all possible string permuations from two lists
;; the resulting strings are concatenated together to a single string
(define (permutations lst1 lst2)
  (if (or (empty? lst1) (empty? lst2))
      ;; if either one is empty, then there are no permuations
      '()
      ;; otherwise:
      (apply append
             ;; map over all elements in lst1, then for each of them
             ;; map again over those in lst2 and concatenate them
             (map (fn (x) (map (fn (y) (append x y)) lst2)) lst1))))

;; string grammar ~> nul
;; Generates the cyk table and prints it for you
(define (gen-and-print-table word grammar)
  ;; header
  (print "V_i/j\t")
  (dotimes (x (length word))
      (print (+ 1 x) "\t"))
  (println)
  ;; print vertical dimension
  (dotimes (y (length word))
      ;; print horizontal dimension
      (print (+ y 1) "\t")
      (dotimes (x (- (length word) y))
          (let ((result (calculate-cell x y word grammar)))
              (if (= result '())
                  (print "{}")
                  (print "{"
                         (join (sort result) ", ")
                         "}")))
                 (print "\t"))
          ;; new line
          (println)))

;; string grammar string ~> boolean
;; Returns whether the grammar detects a word based on the startsymbol.
(define (grammar-detects-word? word grammar startsymbol)
  (find startsymbol (calculate-cell (- (length word) 1) 0 word grammar)))

;; ===========================================================================
;;  MAIN / CONFIG AREA
;; ===========================================================================

;; Grammar must be in Chomsky normal form.
;; symbols are written in uppercase, terminals in lowercase
;; A -> BC becomes a list with the string "A" as the first element,
;; followed by another list (containing "BC") as the second element. If a 
;; symbol maps to more than one thing, then they can be added to the list
;; along with "BC".
;; 
;; The table here specifies the grammar:
;;    S -> TS | XS | a
;;    T -> TT | YY | YS
;;    X -> a
;;    Y -> b
(define grammar (list
  '("S" ("TS" "XS" "a"))
  '("T" ("TT" "YY" "YS"))
  '("X" ("a"))
  '("Y" ("b"))))

(define startsymbol "S")

;; the word as a string, note that every letter used here should also be a 
;; terminal somewhere in the grammar.
(define word "abbbaa")

(gen-and-print-table word grammar)
(println)
(if (grammar-detects-word? word grammar startsymbol)
    (println "~> Grammar detects word")
    (println "~> Grammar does not detect word"))


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


-----------------------------
La funzione "labels" del LISP
-----------------------------

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


-----------------------------
La funzione "juxt" di Clojure
-----------------------------

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


--------------------
La funzione "if-not"
--------------------

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

Il riferimento restituito da "assoc" può essere utilizzato da "setf"... e possiamo renderlo ancora più breve usando "push":

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


----------------------------------
Inverso modulare (modular inverse)
----------------------------------

L'inverso di un numero x vale 1/x --> x * 1/x = 1
Tutti i numeri reali diversi da 0 hanno un inverso.
Moltiplicare un numero per l'inverso di x equivale a dividere per x.

Che cos'è un inverso modulare?
Nell'aritmetica modulare non esiste un'operazione di divisione. Tuttavia, esistono gli inversi modulari:

- L'inverso modulare di x (mod m) è x^-1.
- (x * x^-1) ≡ 1 (mod m) o equivalente (x * x^-1) mod m = 1
- Solo i numeri coprimi a m (numeri che non condividono fattori primi con m) hanno un inverso modulare (mod m)

La seguente funzione utilizza una variante dell'algorimo di esteso di Euclide per calcolare l'inverso modulare (x^-1 mod m):

(define (inv-mod x m)
  ; Calcola x^-1 mod m.
  ; Nota: x * x^-1 mod m = x^-1 * x mod m = 1.
  (local (y z a b c)
    (cond ((or (< m 0) (< x 0) (>= x m)) nil)
          (true
            (setq y x)
            (setq x m)
            (setq a 0)
            (setq b 1)
            (until (zero? y)
              (setq z (% x y))
              (setq c (- a (/ (* b x) y)))
              (setq x y)
              (setq y z)
              (setq a b)
              (setq b c)
            )
            (if (= x 1)
                (% (+ a m) m)
                nil))
    )))

(inv-mod 3 7)
;-> 5


---------------------------------------
La lista vuota () e la stringa vuota ""
---------------------------------------

In newLISP esistono alcune inconsistenze. Per esempio indicizzando una lista vuota e una stringa vuota si ottengono risultati incongruenti:

Con la lista vuota:

('() 0)
;-> ERR: invalid string index
('() -1)
;-> ERR: invalid string index

Con la stringa vuota:

("" 0)
;-> ""
("" -1)
;-> ""

Con un altro indice si ottiene un errore:

("" -1)
;-> ERR: invalid string index

Questo perchè una stringa vuota non è come una lista vuota:

(push "" "")
;-> ""
(push '() '())
;-> (())

(atom? "")
;-> true
(atom? '())
;-> nil
>

Una lista vuota è ancora un contenitore. L'unica alternativa sarebbe restituire nil per ('()
0) - non il simbolo nil ma il valore booleano nil. Questo è stato fatto nelle prime versioni di
newLISP. Ma nella programmazione sembrava che sia più comodo restituire un messaggio di errore.

Invece la funzione "pop" restituisce nil con la lista vuota:

(pop '())
;-> nil

che è più pratico per elaborare liste con "pop".

Ci sono altre incongruenze come questa in newLISP: la funzione dup su liste e stringhe,
nil come valore booleano e simbolo, trattamento di () e nil - solo per citarne alcuni. Quando questi conflitti si verificano in newLISP, normalmente è perchè Lutz ha scelto la praticità verso il mondo reale piuttosto che cercare la coerenza del linguaggio.


-----------------
Multiple dispatch
-----------------

Il "Multiple dispatch" (o multimethods) è una caratteristica di alcuni linguaggi di programmazione in cui una funzione gestisce dinamicamente i tipi dei suoi parametri. In altre parole il risultato (e la logica eseguita) della funzione dipende dal tipo dei parametri e/o dal valore dei parametri.

La seguente soluzione è stata proposta da ralph.ronnquist.
Potrebbe non soddisfare un purista, ma è possibie implementarlo tramite contesti "doppi" e un oggetto FOOP falso, come nell'esempio seguente:

(collide-with "asteroid" "asteroid") =>
   ("POFF" spaceship-spaceship "asteroid" "asteroid")

(context 'MAIN:asteroid-asteroid)
(define (collide-with a b)  (list "BANG" (context) a b))

(context 'MAIN:asteroid-spaceship)
(define (collide-with a b) (list "BONG" (context) a b))

(context 'MAIN:spaceship-asteroid)
(define (collide-with a b) (list "ZING" (context) a b))

(context 'MAIN:spaceship-spaceship)
(define (collide-with a b) (list "POFF" (context) a b))

(context 'MAIN)

(define (dual a b) (list (context (sym (string a "-" b) MAIN))))

(define (collide-with a b) (:collide-with (dual a b) a b))

(println (collide-with "asteroid" "asteroid"))
;-> ("BANG" asteroid-asteroid "asteroid" "asteroid")
(println (collide-with "asteroid" "spaceship"))
;-> ("BONG" asteroid-spaceship "asteroid" "spaceship")
(println (collide-with "spaceship" "asteroid"))
;-> ("ZING" spaceship-asteroid "spaceship" "asteroid")
(println (collide-with "spaceship" "spaceship"))
;-> ("POFF" spaceship-spaceship "spaceship" "spaceship")

Qui la doppia funzione crea semplicemente il corretto contesto di composizione FOOP per consentire all'applicazione questo "singolare" polimorfismo.


---------------------
Palindromo più vicino
---------------------

Dato un numero intero positivo, determinare il numero palindromo più vicino:

(define (palindromo? num)
  (let (str (string num)) (= str (reverse (copy str)))))

(define (find-pali num)
  (local (up down found out)
    (setq up num)
    (setq down num)
    (setq found nil)
    (until found
            ; caso palindromo maggiore
      (cond ((palindromo? up)
              (set 'out up 'found true))
            ; caso palindromo minore
            ((palindromo? down)
              (set 'out down 'found true))
            ; incr e decr up e down
            (true
              (++ up)
              (-- down))
      )
    )
    out))

(find-pali 1234)
;-> 1221

(find-pali 1112)
;-> 1111

(find-pali 1)
;-> 1

(find-pali 10)
;-> 11

Proviamo a scrivere una versione più veloce della funzione "palindromo?":

(define (pali? num)
  (local (rev val)
    (setq rev 0)
    (setq val num)
    ; crea il numero invertito
    (until (zero? val)
      (setq rev (+ (* rev 10) (% val 10)))
      (setq val (/ val 10))
    )
    (= rev num)))

(pali? 23321)
;-> nil

(pali? 1234321)
;-> true

Test di velocità:

(setq test (rand 1e12 100))
(time (map pali? test) 1000)
;-> 179.984
(time (map palindromo? test) 1000)
;-> 493.379

Vedi anche "Palindromo precedente e successivo" su "Note libere 26".

---------------------
Comparative macrology
---------------------

https://www.wilfred.me.uk/blog/2014/09/15/comparative-macrology/

newLISP supporta le f-espressioni. Sono simili alle macro, ma vengono valutate in fase di esecuzione. Una macro è una funzione che accetta un albero della sintassi astratto (AST) e restituisce un altro AST. Una f-espressione è un'espressione di runtime che può scegliere quale dei suoi argomenti verrà valutato e quando.

Le f-espressioni sono in gran parte cadute in disgrazia oggi (la critica definitiva è questo documento: http://www.nhplace.com/kent/Papers/Special-Forms.html). Con le macro convenzionali, puoi espandere tutto il tuo codice ed eseguire analisi statiche, ad es. verificare la presenza di variabili non definite. Con le f-espressioni, perdiamo questa capacità (sebbene sia un argomento di ricerca attivo).

Le versioni recenti di newLisp supportano anche le macro di espansione, ma esploriamo come funzionano le f-espressioni.

;; swap is already defined in newlisp
(context 'my-swap)
(define-macro (my-swap:my-swap x y)
    (set 'tmp (eval x))
    (set x (eval y))
    (set y tmp))
(context MAIN)

Le f-espressioni di newLISP sono difficili da scrivere se hai scritto solo macro normali. Non ci sono macroexpand, quasiquote e lo scope è dinamico. Non abbiamo la stessa separazione tra runtime e compiletime, quindi possiamo semplicemente chiamare "set" direttamente.

(define-macro (each-it lst)
    (let ((template (list 'dolist (list 'it lst))))
      ;; args holds all the arguments that we
      ;; haven't bound in our parameter list
      (extend template (args))
      (eval template)))

"each-it" soffre anche della mancanza di quasiquote. newLisp è "unhygienic", quindi non abbiamo bisogno di fare alcun lavoro extra per catturare "it".


-------------------------
exit e reset negli script
-------------------------

I seguenti script si comportano in modo diverso quando eseguiti dal command prompt:

script1.lsp stampa gli argomenti e ritorno al prompt.

; newlisp script1.lsp
(println (main-args))
(println $main-args)
;(println (args))
;(println $args)
(exit)


script2.lsp stampa gli argomenti (ma non si vedono!) e rimane nella shell di newLISP.

; newlisp script2.lsp
(println (main-args))
(println $main-args)
;(println (args))
;(println $args)
(reset)

Basta aggiungere il comando (exit) alla fine del file .lsp per impedire l'ulteriore caricamento di file come codice...

Questa funzionalità permette di caricare in anticipo tutti i moduli (che non hanno il comando exit).

Usando (reset) alla fine dello script piuttosto che (exit) si entra in modalità interattiva della shell di newLISP.


----------
Tug of War
----------

Dato un insieme di n interi, dividere l'insieme in due sottoinsiemi di n/2 dimensioni ciascuno in modo da minimizzare la differenza della somma di due sottoinsiemi. Se n è pari, le dimensioni di due sottoinsiemi devono essere rigorosamente n/2 e se n è dispari, la dimensione di un sottoinsieme deve essere (n-1)/2 e la dimensione dell'altro sottoinsieme deve essere (n+1)/2 .
Esempio dove n è pari:
Dato l'insieme (3 4 5 -3 100 1 89 54 23 20) la dimensione dell'insieme è 10. L'output per questo insieme dovrebbe essere (4 100 1 23 20) e (3 5 -3 89 54). Entrambi i sottoinsiemi hanno dimensione 5 e la somma degli elementi in entrambi i sottoinsiemi è la stessa (148 e 148).
Esempio dove n è dispari:
Sia dato l'insieme (23 45 -34 12 0 98 -99 4 189 -1 4). I sottoinsiemi di output dovrebbero essere (45 -34 12 98 -1) e (23 0 -99 4 189 4). Le somme degli elementi in due sottoinsiemi sono rispettivamente 120 e 121.

La funzione seguente prova ogni possibile sottoinsieme di dimensione n/2. Se si forma un sottoinsieme di metà dimensione, allora gli elementi rimanenti formano l'altro sottoinsieme. Inizializziamo il set corrente come vuoto e aggiungiamo un elemento alla volta. Ci sono due possibilità per ogni elemento, o fa parte dell'insieme corrente, o fa parte degli elementi rimanenti (altro sottoinsieme). Consideriamo entrambe le possibilità per ogni elemento. Quando la dimensione dell'insieme corrente diventa n/2, controlliamo se questa soluzione è migliore della migliore soluzione disponibile finora. Se lo è, aggiorniamo la soluzione migliore.
Complessità temporale: O(2^n)

Vediamo la soluzione proposta in C++ da Ashish Anand per GeeksforGeeks reperibile al seguente indirizzo:

https://www.geeksforgeeks.org/tug-of-war/

#include <bits/stdc++.h>
using namespace std;

// function that tries every possible solution by calling itself recursively
void TOWUtil(int* arr, int n, bool* curr_elements, int no_of_selected_elements,
             bool* soln, int* min_diff, int sum, int curr_sum, int curr_position)
{
    // checks whether the it is going out of bound
    if (curr_position == n)
        return;

    // checks that the numbers of elements left are not less than the
    // number of elements required to form the solution
    if ((n/2 - no_of_selected_elements) > (n - curr_position))
        return;

    // consider the cases when current element is not included in the solution
    TOWUtil(arr, n, curr_elements, no_of_selected_elements,
              soln, min_diff, sum, curr_sum, curr_position+1);

    // add the current element to the solution
    no_of_selected_elements++;
    curr_sum = curr_sum + arr[curr_position];
    curr_elements[curr_position] = true;

    // checks if a solution is formed
    if (no_of_selected_elements == n/2)
    {
        // checks if the solution formed is better than the best solution so far
        if (abs(sum/2 - curr_sum) < *min_diff)
        {
            *min_diff = abs(sum/2 - curr_sum);
            for (int i = 0; i<n; i++)
                soln[i] = curr_elements[i];
        }
    }
    else
    {
        // consider the cases where current element is included in the solution
        TOWUtil(arr, n, curr_elements, no_of_selected_elements, soln,
                  min_diff, sum, curr_sum, curr_position+1);
    }

    // removes current element before returning to the caller of this function
    curr_elements[curr_position] = false;
}

// main function that generate an arr
void tugOfWar(int *arr, int n)
{
    // the boolean array that contains the inclusion and exclusion of an element
    // in current set. The number excluded automatically form the other set
    bool* curr_elements = new bool[n];

    // The inclusion/exclusion array for final solution
    bool* soln = new bool[n];

    int min_diff = INT_MAX;

    int sum = 0;
    for (int i=0; i<n; i++)
    {
        sum += arr[i];
        curr_elements[i] =  soln[i] = false;
    }

    // Find the solution using recursive function TOWUtil()
    TOWUtil(arr, n, curr_elements, 0, soln, &min_diff, sum, 0, 0);

    // Print the solution
    cout << "The first subset is: ";
    for (int i=0; i<n; i++)
    {
        if (soln[i] == true)
            cout << arr[i] << " ";
    }
    cout << "\nThe second subset is: ";
    for (int i=0; i<n; i++)
    {
        if (soln[i] == false)
            cout << arr[i] << " ";
    }
}

// Driver program to test above functions
int main()
{
    int arr[] = {23, 45, -34, 12, 0, 98, -99, 4, 189, -1, 4};
    int n = sizeof(arr)/sizeof(arr[0]);
    tugOfWar(arr, n);
    return 0;
}

Nota: in newLISP la funzione ausiliaria "tugwar-ex" viene chiamata solo con i parametri che sono locali alla funzione, mentre i parametri che vengono modificati a livello globale vengono passati alla funzione in maniera implicita sfruttando lo scopo dinamico (dynamic scope).
In particolare:

 int* arr,                      globale
 int n,                         locale
 bool* curr_elements,           globale
 int no_of_selected_elements,   locale
 bool* soln,                    globale
 int* min_diff,                 globale
 int sum,                       locale
 int curr_sum,                  locale
 int curr_position              locale

(define (tugwar-ex n num-selected sum curr-sum curr-pos)
        ; fine della lista?
  (cond ((= curr-pos n) nil)
        ; controllo numero elementi delle parti sinistra e destra
        ((> (- (/ n 2) num-selected) (- n curr-pos)) nil)
        (true
          ; caso in cui l'elemento corrente non è incluso nella soluzione
          (tugwar-ex n num-selected sum curr-sum (+ curr-pos 1))
          ; aggiunge l'elemento corrente alla soluzione
          (++ num-selected)
          (setq curr-sum (+ curr-sum (lst curr-pos)))
          (setf (curr-el curr-pos) true)
          ; raggiunta una soluzione?
          (if (= (/ n 2) num-selected)
              ; la soluzione corrente è migliore di quella migliore?
              (if (< (abs (- (/ sum 2) curr-sum)) min-diff )
                  (begin
                    ; aggiorna la soluzione migliore
                    (setf min-diff (abs (- (/ sum 2) curr-sum)))
                    (for (i 0 (- n 1))
                      (setf (soln i) (curr-el i))
                    )
                  )
              )
          ;else
          ; caso in cui l'elemento corrente è incluso nella soluzione
             (tugwar-ex n num-selected sum curr-sum (+ curr-pos 1))
          )
          ; rimuove l'elemento corrente prima di tornare
          ; alla funzione chiamante
          (setf (curr-el curr-pos) nil))))

(define (tugwar lst)
  (local (len curr-el min-diff soln lst1 lst2)
    (setq len (length lst))
    (setq curr-el (array len '(nil)))
    (setf soln (array len '(nil)))
    (setq min-diff 999999999)
    (tugwar-ex len 0 (apply + lst) 0 0)
    (setq lst1 '())
    (setq lst2 '())
    (dolist (s soln)
      (if s (push (lst $idx) lst1 -1)
            (push (lst $idx) lst2 -1))
    )
    (println (apply + lst1) {, } (apply + lst2))
    (list lst1 lst2)))

Facciamo alcune prove:

(setq vec '(23 45 -34 12 0 98 -99 4 189 -1 4))
(tugwar vec)
;-> 120, 121
;-> ((45 -34 12 98 -1) (23 0 -99 4 189 4))

(setq vec1 '(1 3 4 2 4 4))
(tugwar vec1)
;-> 9, 9
;-> ((3 2 4) (1 4 4))

(setq vec2 (dup 1 11))
;-> (1 1 1 1 1 1 1 1 1 1 1)
(tugwar vec2)
;-> 5, 6
;-> ((1 1 1 1 1) (1 1 1 1 1 1))


--------------------------------
Estrazione elementi da una lista
--------------------------------

Data una lista di numeri interi e due numeri interi x e y scrivere una funzione che restituisce gli elementi univoci della lista che soddisfano una delle seguenti condizioni:

1) se x e y sono valori numerici allora estrarre ogni elemento el che soddisfa:
  (el <= x) AND (el <= y),
  cioè bisogna estrarre tutti gli elementi che hanno valore compreso tra x e y
2) se x e y sono indici allora estrarre ogni elemento el che soddisfa:
  (el i) per x <= i <= y,
  cioè bisogna estrarre tutti gli elementi che hanno indice compreso tra x e y.

(define (find-unique-values lst a b idx)
  (local (out)
    (if idx
      ; idx = true --> a e b sono indici
      (unique (select lst (sequence a b)))
      ; idx = nil --> a e b sono valori
      (unique (filter (fn(x) (and (>= x a) (<= b x))) lst))
    )))

Facciamo alcune prove:

(setq w '(7 3 5 9 7 6 4 3 2))

(find-unique-values w 2 5)
;-> (7 5 9 6)

(find-unique-values w 1 5 true)
;-> ()


------------------------
Punti fissi di una lista
------------------------

Un "punto fisso" in una lista è un indice i tale che (lst i) è uguale a i.
Data una lista di numeri interi scrivere una funzione che restituisce i punti fissi della lista, oppure nil se non esistono punti fissi. I numeri interi nella lista possono essere negativi.

Un modo semplice è il seguente:

(define (fixed lst)
  (let (out '())
    (dolist (el lst)
      (if (= el $idx) (push $idx out -1))
    )
    out))

(setq w '(-7 4 2 -3 2 5 -1))

(fixed w)
;-> (2 5)

Comunque newLISP permette anche l'indicizzazione con indici negativi:

(w -1)
;-> -1

Quindi dobbiamo considerare anche questi casi:

(define (fixed-1 lst)
  (let (out '())
    ; ricerca punti fissi con indici positivi
    (dolist (el lst)
      (if (= el $idx) (push $idx out -1))
    )
    ; ricerca punti fissi con indici negativi
    (for (i (- (length lst)) -1)
      (if (= (lst i) i) (push i out -1))
    )
    out))

(fixed-1 w)
;-> (2 5 -7 -1)


----------------------------------------------
Numero mancante in una progressione aritmetica
----------------------------------------------

Abbiamo una lista di numeri interi in progressione aritmetica (ordinata) in cui manca un elemento della progressione. Trovare il numero mancante.
Per esempio:

lista = (2 4 6 10 12 14)
Manca il numero 8

lista = (1 6 11 16 26 31)
Manca il numero 21

La somma dei numeri di una progressione aritmetica vale:

  S = (n/2) * (x1 + xn) = (n * x1 * xn)/2

dove n  = lunghezza della lista
     x1 = primo elemento della lista
     xn = ultimo elemento della lista

(define (arit lst)
  ; se la lista completa è lunga n,
  ; allora la nostra lista è lunga (n - 1)
  (let (len (+ (length lst) 1))
       ; somma vera della progressione
    (- (/ (* len (+ (lst 0) (lst -1))) 2)
       ; somma della nostra progrssione (lista)
       (apply + lst))))


Facciamo alcune prove:

(setq w '(2 4 6 10 12 14))
(arit w)
;-> 8

(setq w '(1 6 11 16 26 31))
(arit w)
;-> 21

(setq w '(1 4 7 10 16))
(arit w)
;-> 13


-------------------
List comprehensions
-------------------

Vediamo come simulare le list comprehensions del linguaggio python in newLISP utilizzando l'iterazione innestata dele liste.

;;>>> a = range(10)
;;>>> b = range(11,20)
;;>>> [[x, y] for x in b for y in a]
;;[[11, 0], [11, 1], [11, 2], [11, 3], ......

(setq a (sequence 0 9))
(setq b (sequence 11 19))
(dolist (x b) (dolist (y a) (push (list x y) results -1)))
;-> ((11 0) (11 1) (11 2) (11 3)...

;; List Comprehensions in PYTHON

;;>>> vec = [2, 4, 6]
;;>>> [3*x for x in vec]
;;[6, 12, 18]

(set 'vec '(2 4 6))
(println (map (lambda (x) (* x 3)) vec))
;-> (6 12 18)

;;>>> vec = [2, 4, 6]
;;>>> [[x, x**2] for x in vec]
;;[[2, 4], [4, 16], [6, 36]]

(println (map (lambda (x) (list x (pow x))) vec))
;-> ((2 4) (4 16) (6 36))

;;>>> freshfruit = ['  banana', '  loganberry ', 'passion fruit  ']
;;>>> [weapon.strip() for weapon in freshfruit]
;;['banana', 'loganberry', 'passion fruit']

(set 'freshfruit '("  banana" "  loganberry " "passion fruit  "))
(println (map trim freshfruit))
;-> ("banana" "loganberry" "passion fruit")

;;>>> [3*x for x in vec if x > 3]
;;[12, 18]
;;>>> [3*x for x in vec if x < 2]
;;[]

(println (map (lambda (x) (when (> x 3)(* x 3)))vec))
;-> (nil 12 18)
(println (map (lambda (x) (when (< x 2)(* x 3))) vec))
;-> (nil nil nil)

;;>>> vec1 = [2, 4, 6]
;;>>> vec2 = [4, 3, -9]
;;>>> [x*y for x in vec1 for y in vec2]
;;[8, 6, -18, 16, 12, -36, 24, 18, -54]

(set 'vec1 '(2 4 6))
(set 'vec2 '(4 3 -9))
(dolist (x vec1)(dolist (y vec2) (print (* x y) " ")))
;-> 8 6 -18 16 12 -36 24 18 -54

;;>>> [x+y for x in vec1 for y in vec2]
;;[6, 5, -7, 8, 7, -5, 10, 9, -3]

(dolist (x vec1)(dolist (y vec2) (print (+ x y) " ")))
;-> 6 5 -7 8 7 -5 10 9 -3

;;>>> [vec1[i]*vec2[i] for i in range(len(vec1))]
;;[8, 12, -54]

(println (map * vec1 vec2))
;-> (8 12 -54)

;;>>> mat = [
;;...        [1, 2, 3],
;;...        [4, 5, 6],
;;...        [7, 8, 9],
;;...       ]
;;>>> print([[row[i] for row in mat] for i in [0, 1, 2]])
;;[[1, 4, 7], [2, 5, 8], [3, 6, 9]]
;; ou
;;>>> list(zip(*mat))
;;[(1, 4, 7), (2, 5, 8), (3, 6, 9)]

(set 'matrix '((1 2 3)(4 5 6)(7 8 9)))
(println (transpose matrix))
;-> ((1 4 7) (2 5 8) (3 6 9))

;;for i in [0, 1, 2]:
;;    for row in mat:
;;        print(row[i], end="")
;;    print()

(dolist (row (transpose matrix)) (println row))
;-> (1 4 7)
;   (2 5 8)
;   (3 6 9)


-------------------------------------
map e funzioni con argomenti multipli
-------------------------------------

Per utilizzare "map" con una funzione con argomenti multipli possiamo utilizzare la seguente funzione che utilizza (args) (by rickyboy):

(define (my-func) (cons 'op (args)))
;-> (lambda () (cons 'op (args)))

Alcuni esempi di applicazione:

(map my-func '(1 2 3))
;-> ((op 1) (op 2) (op 3))

(map my-func '(1 2 3) '(4 5 6))
;-> ((op 1 4) (op 2 5) (op 3 6))

(map my-func '(1 2 3) '(4 5 6) '(7 8 9))
;-> ((op 1 4 7) (op 2 5 8) (op 3 6 9))

Nota: se usiamo map con una funzione primitiva possiamo usarla direttamente, per esempio:

(map + '(1 2 3) '(4 5 6) '(7 8 9))
;-> (12 15 18)


-------------------
Divisione incongrue
-------------------

1. L'eredità degli 11 cammelli
------------------------------
Un ricco cammelliere arabo lasciò in eredità ai suoi tre figli 11 cammelli: al maggiore lasciò la metà dei cammelli, al secondo ne lasciò un quarto e al terzo un sesto.
Nel dividersi l'eredità, sorsero seri problemi e i tre fratelli entrarono in una lite furibonda fino a rischiare di arrivare ai coltelli. Infatti, gli 11 cammelli non erano dividibili né a metà, né a un quarto, né a un sesto. E ciascuno pretendeva di avere un cammello in più per sé.

Soluzione
---------
Sapendo del problema, il notaio incaricato si presentò ai tre fratelli e donò loro un suo cammello, gratuitamente.
Avendo 12 cammelli, i tre fratelli poterono avere facilmente ciò che spettava a ciascuno di loro secondo giustizia: il primo ebbe i suoi 6 cammelli (la metà), il secondo ebbe 3 cammelli (un quarto), il terzo ebbe 2 cammelli (un sesto). A conti fatti, si accorsero poi che 6 + 3 +2 dava per risultato 11, 11 cammelli, e ne avanzava ancora uno. Così, risolti i loro problemi con giustizia, decisero di ridare il cammello a colui che l'aveva donato esprimendogli la loro riconoscenza.

2. L'eredità di 17 cammelli
---------------------------
Uno sceicco lascia in eredità ai suoi tre figli rispettivamente 1/2, 1/3 e 1/9 dei suoi cammelli con la raccomandazione di non uccidere animali nella spartizione. Ma quando muore lascia 17 cammelli.
Come andranno suddivisi fra i tre figli?

Soluzione
---------
Poiché 1/2 + 1/3 + 1/9 = 17/18 il notaio, incaricato di suddividere l'eredità, aggiunge un suo cammello e consegna

1/2 di 18 = 9 cammelli al primo figlio;

1/3 di 18 = 6 cammelli al secondo figlio;

1/9 di 18 = 2 cammeli al terzo figlio.

In tutto ha consegnato 17 cammelli.
Il notaio si riprende il suo cammello e il gioco è fatto.
Nessun figlio protesta per il metodo di suddivisione, in quanto tutti hanno ricevuto più del dovuto.

3. L'eredità dei 35 cammelli
----------------------------
Uno sceicco lascia in eredità 35 cammelli ai suoi tre figli.
L'eredità dovrà essere divisa in parti direttamente proporzionali a 1/2, 1/3 e 1/9, senza uccidere animali.
Il notaio, inoltre, dovrà ricevere un cammello come ricompensa per il suo lavoro di esecutore testamentario.
Come andranno divisi i cammelli?
Richard A. Proctor, 1886

Soluzione
---------
Poiché 1/2 + 1/3 + 1/9 = 17/18 = 34/36
il notaio aggiunge un suo cammello e consegna

1/2 di 36 = 18 cammelli al primo figlio;

1/3 di 36 = 12 cammelli al secondo figlio;

1/9 di 36 = 4 cammeli al terzo figlio.

In tutto ha consegnato 34 cammelli.
Dunque si riprende il suo cammello e si tiene uno dei 35 cammelli come ricompensa.

3. L'eredità di un gregge di pecore
-----------------------------------
Un pastore lascia in eredità ai suoi cinque figli un gregge di pecore.
Al primo figlio toccherà 1/3 delle pecore, al secondo 1/4, al terzo 1/6, al quarto 1/8, al quinto 1/9.
Al momento della divisione, il notaio presta 2 pecore e ciascun figlio riceve la sua parte senza uccidere alcun animale.
Terminata la divisione, al notaio rimangono 2 pecore di ricompensa per il suo lavoro.
Quante erano le pecore del gregge?
Jerome S. Meyer, 1937

Poiché il mcm tra 3, 4, 6, 8 e 9 è 72, proviamo a calcolare quanti settantaduesimi spetterebbero agli eredi.

1/3 + 1/4 + 1/6 + 1/8 + 1/9 = 71/72

Soluzione
---------
Dobbiamo ora tener conto del fatto che alla fine il notaio deve riprendersi le sue due pecore PIU' ALTRE DUE come ricompensa: in tutto 4 pecore.
Quindi deve accadere che dopo aver tolto:
1/3 + 1/4 + 1/6 + 1/8 + 1/9 = 71/72
dal numero, deve avanzare 4.
Da ciò si deduce che 1/72 equivale a 4 pecore.
Perciò le pecore da suddividere in tutto sono 72*4 = 288.
In definitiva le pecore lasciate in eredità sono 286 e il notaio ne aggiunge 2.
I figli ricevono: 96 + 72 + 48 + 36 + 32 = 284 pecore.

4. Un pasticcio mediorientale
-----------------------------
Si devono dividere 41 barili di petrolio fra 3 persone.
Le tre persone devono ricevere rispettivamente 1/2, 1/3 e 1/7 dei barili.
Siccome:
1/2 + 1/3 + 1/7 = 41/42
il problema si può risolvere aggiungendo un barile e calcolando le frazioni indicate di 42.
Le tre persone ricevono rispettivamente: 21, 14 e 6 barili per un totale di 41 barili. Il barile aggiunto viene quindi restituito.
La domanda è: esistono altre quadruple di numeri interi, oltre a 2, 3, 7, 41 che danno luogo ad un puzzle di questo tipo?
(David Singmaster)

Soluzione
---------
Ecco le 12 soluzioni.
2, 3, 7, 41
2, 3, 8, 23
2, 3, 9, 17
2, 3, 12, 11
2, 4, 5, 19
2, 4, 6, 11
2, 4, 8, 7
2, 5, 5, 9
2, 6, 6, 5
3, 3, 4, 11
3, 3, 6, 5
4, 4, 4, 3

Ed ecco il procedimento per trovarle.
Trovare le quaterne (a, b, c, n-1) tali che
(1)   n/a + n/b + n/c = n - 1

Supponiamo di conoscere a e b e poniamo c = x
scriviamo r = m.c.m.(a, b) cioè r è il minimo comune multiplo di a e b;
qualunque valore abbia x avremo:
m.c.m.(a, b, x) = rt
dove t è un parametro a valori interi che varia in funzione di x.

Notare che il m.c.m. della terna è sempre multiplo di r,
il m.c.m. della coppia. Riscriviamo (1) usando le nuove definizioni:

(1)   rt/a + rt/b + rt/x = rt - 1

da cui ricaviamo x:

(2)   x = rt/(rt - rt/a - rt/b - 1)

Per comodità poniamo s = r - r/a - r/b per cui raccogliendo a fattor comune
la lettera t:

(2)   x = rt/(st - 1)

Poi riscrivendo la (2) in un'altra forma:

x(st - 1) - rt = 0
sxt - rt = x
(sx - r)t = x
t = x/(sx - r)

da cui, siccome t è intero, ricaviamo che:
x dev'essere congruo a 0 modulo (sx -r) ovvero:
(sx - r) divide esattamente x

e otteniamo anche un limite superiore per x:
x/(sx - r) >=2
e un limite inferiore per x:
x > r/s

Facciamo un esempio, siano a=2, b=4; allora
r = m.c.m.(2, 4) = 4
s = 4 - 4/2 - 4/4 = 1
bisogna trovare i valori di x per cui x è esattamente diviso da
(1x - 4)
con x > 4/1, cioè maggiore di 4.

Proviamo coi vari valori di x:
t = 5/(1*5 - 4) = 5
t = 6/(1*6 - 4) = 3
t = 7/(1*7 - 4) = 2,3...
t = 8/(1*8 - 4) = 2
t = 9/(1*9 - 4) = 1,8
e siccome l'ultimo rapporto è inferiore a 2 il calcolo si arresta.
Abbiamo trovato tre valori di x che danno risultato intero nella divisione, ovvero
x1=5, x2=6, x3=8
che ci danno le quaterne:
(2, 4, 5, 19)
(2, 4, 6, 11)
(2, 4, 8, 7)

Nota storica
Le prime versioni conosciute di questo problema si trovano nel papiro di Rhind (-1650) e in quello di Akhmim (+700).

Dividere 700 pagnotte in due parti proporzionali ai numeri 1/2 e 1/4
(Papiro di Rhind)

Dividere 1000 in parti proporzionali a 3 + 1/2  :  2 + 1/2  :  3 + 1/2 + 1/4  :  6 + 1/4  :  4
(Papiro di Akhmim)

Dividere 3 + 1/2 + 1/4 in parti proporzionali a 7 : 8 : 9.
(Papiro di Akhmim)

In origine questi problemi venivano risolti dividendo semplicemente l'eredità in parti proporzionali alle frazioni.
Secondo David Singmaster l'aggiunta del 18° cammello è una strategia recente, probabilmente del 1800, anche se alcuni autori ritengono che risalga a Tartaglia (1500) o addirittura alla cultura Araba, o Indiana o Cinese.


---------------------------------
Numeri causali e numero di eulero
---------------------------------

e = 2.7182818284590451

Generando numeri casuali tra 0 e 1, qual'è il numero atteso medio di numeri selezionati affinchè la loro somma superi 1?

(define (euler1 iter)
  (local (val somma conta)
    (setq val 0)
    (for (i 1 iter)
      (setq somma 0)
      (setq conta 0)
      (until (> somma 1)
        (setq somma (add somma (random)))
        (++ conta)
      )
      (setq val (+ val conta))
    )
    (div val iter)))

(euler1 1e6)
;-> 2.717473
(euler1 1e7)
;-> 2.7181288

Generiamo una serie di numeri casuali x1,x2,x3,... fintanto che la serie è monotona crescente. Qual'è la lunghezza media attesa della sequenza monotonica?
Per esempio, la sequenza 0.21, 0.71, 0.81, 0.42 ha una lunghezza pari a 4 (viene considerato anche l'ultimo numero che "spezza" la monotonicità della serie).
Invece, la serie 0.21, 0.35, 0.16 ha lunghezza 3.

(define (euler2 iter)
  (local (cur-lun lun change dir)
    (setq val 0)
    (for (i 1 iter)
      (setq prev-val (random))
      (setq lun 2)
      (setq change nil)
      (until change
        (setq cur-val (random))
        (cond ((> cur-val prev-val)
                (++ lun) 
                (setq prev-val cur-val))
              (true ; cambio monotonicità
                (setq change true)
                (setq val (+ val lun))
              )
        )
      )
    )
    (div val iter)))

(euler2 1e6)
;-> 2.718573

(euler2 1e7)
;-> 2.7184529

(define (euler3 iter)
  (local (out stop tot)
    (setq tot 0)
    (for (i 1 iter)
      (setq out (list (random)))
      (setq stop nil)
      (until stop
        (if (> (length out) 1)
            (cond ((apply < out) nil) ; valori crescenti
                  (true
                    (setq tot (+ tot (length out)))
                    (setq stop true))
            )
        )
        (push (random) out -1)
      )
    )
    (div tot iter)))

(euler3 1e6)
;-> 2.717245

(euler3 1e7)
;-> 2.7186064


--------------------------------
Funzioni e indici degli elementi
--------------------------------

La seguente funzione crea una lista con tutti gli indici della lista passata come parametro:

(define (index-list lst)
"Creates indexes of list elements"
  (ref-all nil lst (fn (x) true)))

Per esempio:
(setq alst '(1 (2 (3)) 4 (5 (6))))

(index-list alst)
;-> ((0) (1) (1 0) (1 1) (1 1 0) (2) (3) (3 0) (3 1) (3 1 0))

E con questi indici possiamo "recuperare" qualunque parte della lista:

(setq idx (index-list alst))
(dolist (el idx) (println el { - } (alst el)))
;-> (0) - 1
;-> (1) - (2 (3))
;-> (1 0) - 2
;-> (1 1) - (3)
;-> (1 1 0) - 3
;-> (2) - 4
;-> (3) - (5 (6))
;-> (3 0) - 5
;-> (3 1) - (6)
;-> (3 1 0) - 6

Adesso per scomporre una funzione basta ricordare che anche una funzione è una lista in newLISP. Quindi posso scomporre una funzione con lo stesso metodo.
Come esempio di funzione utilizziamo la "index-list" stessa:

index-list
;-> (lambda (lst) "Creates indexes of list elements"
;->   (ref-all nil lst (lambda (x) true)))

Creiamo la lista degli indici:

(setq indici (index-list index-list))
;-> ((0) (0 0) (1) (2) (2 0) (2 1) (2 2) (2 3) (2 3 0) (2 3 0 0) (2 3 1))

Visualizziamo tutti gli elementi della funzione/lista:

(dolist (el indici) (println el { - } (nth el index-list)))
;-> (0) - (lst)
;-> (0 0) - lst
;-> (1) - Creates indexes of list elements
;-> (2) - (ref-all nil lst (lambda (x) true))
;-> (2 0) - ref-all
;-> (2 1) - nil
;-> (2 2) - lst
;-> (2 3) - (lambda (x) true)
;-> (2 3 0) - (x)
;-> (2 3 0 0) - x
;-> (2 3 1) - true

Questo ci permette di individuare esattamente la posizione di una espressione all'interno di qualunque funzione e, eventualmente, di modificarla con facilità.
Per esempio:

(setf (nth '(1) index-list) "Crea una lista di tutti gli indici degli elementi della lista")
index-list
;-> (lambda (lst) "Crea una lista di tutti gli indici degli elementi della lista"
;->   (ref-all nil lst (lambda (x) true)))

Nota: quando indicizziamo una lista che rappresenta una funzione non possiamo utilizzare l'indicizzazione implicita (lista indice), ma dobbiamo usare l'indicizzazione esplicita (nth indice lista). Questo perchè con una funzione l'espressione (funzione indice) viene valutata invece che indicizzata in modo implicito.

Se invece vogliamo scomporre la funzione in token, possiamo usare la funzione "parse":

(parse (string index-list))
;-> ("(" "lambda" "(" "lst" ")"
;->  "Crea una lista di tutti gli indici degli elementi della lista"
;->  "(" "ref-all" "nil" "lst" "(" "lambda" "(" "x" ")" "true" ")" ")" ")")


------------------
Numeri cistercensi
------------------

I numeri cistercensi medievali, o "cifrari" nel gergo ottocentesco, furono sviluppati dall'ordine monastico cistercense all'inizio del XIII secolo, all'incirca nel periodo in cui i numeri arabi furono introdotti nell'Europa nordoccidentale. Sono più compatti dei numeri arabi o romani, con un solo glifo in grado di indicare qualsiasi numero intero compreso tra 1 e 9999.
I Cistercensi alla fine abbandonarono il sistema a favore dei numeri arabi, ma l'uso marginale al di fuori dell'ordine continuò fino all'inizio del XX secolo.

Nota: per una spiegazione approfondita vedi la pagina web "The Forgotten Number System - Numberphile":

https://www.youtube.com/watch?v=9p55Qgt7Ciw

Le cifre si basano su un pentagramma orizzontale o verticale, con la posizione della cifra sul pentagramma che ne indica il valore posizionale (unità, decine, centinaia o migliaia). Queste cifre sono composte su un singolo rigo per indicare numeri più complessi.

Il numero viene scritto in un piano cartesiano X-Y in cui ogni quadrante contiene una cifra/glifo:

I)   alto-destra:    quadrante delle unità
II)  alto-sinistra:  quadrante delle decine
III) basso-sinistra: quadrante delle migliaia
IV)  basso-destra:   quadrante delle centinaia

                     |
        (II)         |        (I)
                     |
       DECINE        |       UNITA'
       (tens)        |      (units)
                     |
                     |
  -------------------0-------------------
                     |
       (III)         |         (IV)
                     |
      MIGLIAIA       |       CENTINAIA
     (thousands)     |       (hundreds)
                     |
                     |

Le cifre/glifo cistercensi (unità, decine, centinaia, migliaia) sono le seguenti (con una matrice di 7x9 caratteri):

Unità
-----
   (1)          (2)          (3)          (4)          (5)
   ■■■■         ■            ■■           ■  ■         ■■■■
   ■            ■            ■ ■          ■ ■          ■ ■
   ■            ■■■■         ■  ■         ■■           ■■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■

   (6)         (7)           (8)          (9)          (0)
   ■  ■         ■■■■         ■  ■         ■■■■         ■
   ■  ■         ■  ■         ■  ■         ■  ■         ■
   ■  ■         ■  ■         ■■■■         ■■■■         ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■

Decine
------
   (10)         (20)         (30)         (40)         (50)
■■■■            ■           ■■         ■  ■         ■■■■
   ■            ■          ■ ■          ■ ■          ■ ■
   ■         ■■■■         ■  ■           ■■           ■■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■

   (60)         (70)         (80)         (90)
■  ■         ■■■■         ■  ■         ■■■■
■  ■         ■  ■         ■  ■         ■  ■
■  ■         ■  ■         ■■■■         ■■■■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■

Centinaia
---------
   (100)        (200)        (300)        (400)        (500)
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■■■■         ■  ■         ■■           ■■
   ■            ■            ■ ■          ■ ■          ■ ■
   ■■■■         ■            ■■           ■  ■         ■■■■

   (600)        (700)        (800)        (900)
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■  ■         ■  ■         ■■■■         ■■■■
   ■  ■         ■  ■         ■  ■         ■  ■
   ■  ■         ■■■■         ■  ■         ■■■■

Migliaia
--------
   (1000)       (2000)       (3000)       (4000)       (5000)
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■            ■            ■            ■            ■
   ■         ■■■■         ■  ■           ■■           ■■
   ■            ■          ■ ■          ■ ■          ■ ■
■■■■            ■           ■■         ■  ■         ■■■■

   (6000)       (7000)       (8000)       (9000)
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
   ■            ■            ■            ■
■  ■         ■  ■         ■■■■         ■■■■
■  ■         ■  ■         ■  ■         ■  ■
■  ■         ■■■■         ■  ■         ■■■■

Per esempio il numero 5555 viene rappresentato nel modo seguente:

  ■■■■■■■
   ■ ■ ■
    ■■■
     ■
     ■
     ■
    ■■■
   ■ ■ ■
  ■■■■■■■

Per una rappresentazione grafica migliore vedi l'immagine "glifi-cistercensi.jpg" nella cartella "data".

Scriviamo una funzione che prende un numero intero (da 1 a 9999) e stampa il relativo numero cistercense.
Per la rappresentazione del numero cistercense useremo una matrice 7x9. Per esempio il numero 0 e il numero 1 sono rappresentati dalle seguenti matrici:

  (0)         (1)
  0001000     0001111
  0001000     0001000
  0001000     0001000
  0001000     0001000
  0001000     0001000
  0001000     0001000
  0001000     0001000
  0001000     0001000
  0001000     0001000

Definiamo tutti i glifi cistercensi con le celle (pixel) che sono visibili (cioè tutte le celle che devono avere valore 1).

(define (setup)
  ; lista per ogni glifo
  ; Unità
  (setq c1 '((0 4) (0 5) (0 6)))
  (setq c2 '((2 4) (2 5) (2 6)))
  (setq c3 '((0 4) (1 5) (2 6)))
  (setq c4 '((2 4) (1 5) (0 6)))
  (setq c5 '((0 4) (0 5) (0 6) (2 4) (1 5) (0 6)))
  (setq c6 '((0 6) (1 6) (2 6)))
  (setq c7 '((0 4) (0 5) (0 6) (0 6) (1 6) (2 6)))
  (setq c8 '((2 4) (2 5) (2 6) (0 6) (1 6) (2 6)))
  (setq c9 '((0 4) (0 5) (0 6) (2 4) (2 5) (2 6) (0 6) (1 6) (2 6)))
  ; Decine
  (setq c10 '((0 0) (0 1) (0 2)))
  (setq c20 '((2 0) (2 1) (2 2)))
  (setq c30 '((0 2) (1 1) (2 0)))
  (setq c40 '((2 2) (1 1) (0 0)))
  (setq c50 '((0 0) (0 1) (0 2) (2 2) (1 1) (0 0)))
  (setq c60 '((0 0) (1 0) (2 0)))
  (setq c70 '((0 0) (0 1) (0 2) (0 0) (1 0) (2 0)))
  (setq c80 '((2 0) (2 1) (2 2) (0 0) (1 0) (2 0)))
  (setq c90 '((2 0) (2 1) (2 2) (0 0) (1 0) (2 0) (0 0) (0 1) (0 2)))
  ; Centinaia
  (setq c100 '((8 4) (8 5) (8 6)))
  (setq c200 '((6 4) (6 5) (6 6)))
  (setq c300 '((8 4) (7 5) (6 6)))
  (setq c400 '((6 4) (7 5) (8 6)))
  (setq c500 '((8 4) (8 5) (8 6) (6 4) (7 5) (8 6)))
  (setq c600 '((6 6) (7 6) (8 6)))
  (setq c700 '((8 4) (8 5) (8 6) (6 6) (7 6) (8 6)))
  (setq c800 '((6 6) (7 6) (8 6) (6 4) (6 5) (6 6)))
  (setq c900 '((6 6) (7 6) (8 6) (6 4) (6 5) (6 6) (8 4) (8 5) (8 6)))
  ; Migliaia
  (setq c1000 '((8 0) (8 1) (8 2)))
  (setq c2000 '((6 0) (6 1) (6 2)))
  (setq c3000 '((6 0) (7 1) (8 2)))
  (setq c4000 '((6 2) (7 1) (8 0)))
  (setq c5000 '((8 0) (8 1) (8 2) (6 2) (7 1) (8 0)))
  (setq c6000 '((6 0) (7 0) (8 0)))
  (setq c7000 '((6 0) (7 0) (8 0) (8 0) (8 1) (8 2)))
  (setq c8000 '((6 0) (7 0) (8 0) (6 0) (6 1) (6 2)))
  (setq c9000 '((6 0) (7 0) (8 0) (6 0) (6 1) (6 2) (8 0) (8 1) (8 2)))
  ; lista con tutti i glifi
  (setq gliph (list
              (list c1 c2 c3 c4 c5 c6 c7 c8 c9)
              (list c10 c20 c30 c40 c50 c60 c70 c80 c90)
              (list c100 c200 c300 c400 c500 c600 c700 c800 c900)
              (list c1000 c2000 c3000 c4000 c5000 c6000 c7000 c8000 c9000)))
  ; numero di partenza: 0
  (setq base '((0 0 0 1 0 0 0)
               (0 0 0 1 0 0 0)
               (0 0 0 1 0 0 0)
               (0 0 0 1 0 0 0)
               (0 0 0 1 0 0 0)
               (0 0 0 1 0 0 0)
               (0 0 0 1 0 0 0)
               (0 0 0 1 0 0 0)
               (0 0 0 1 0 0 0)))
)

Scriviamo la funzione che stampa il numero cistercense:

(define (print-num lst)
    (for (r 0 (- (length lst) 1)) ;8
      (for (c 0 (- (length (lst 0)) 1)) ;6
        (if (zero? (lst r c))
            (print " ")
            (print "■")
        )
      )
      (println)))

Adesso scriviamo la funzione di conversione da numero decimale a numero cistercense:

(define (cistercense num)
  (local (len digits)
    (setup)
    (setq len (length num))
    ; lista con le cifre del numero invertite
    ; 123 --> (3 2 1)
    (setq digits (map int (explode (reverse (string num)))))
    ; ciclo per ogni cifra del numero (nella lista)
    (for (i 0 (- len 1))
      (setq d (digits i))
      ; aggiorna il glifo totale del numero cistercense
      ; scrive il glifo corrente nel quadrante relativo
      (if (!= d 0)
        (dolist (g (gliph i (- d 1)))
          (setf (base g) 1)
        )
      )
    )
    ;(println base)
    (print-num base)
  ))

Test:

(cistercense 9999)
(cistercense 8888)
(cistercense 7777)
(cistercense 6666)
(cistercense 5555)
(cistercense 4444)
(cistercense 3333)
(cistercense 2222)
(cistercense 1111)

Convertiamo alcuni numeri:

(cistercense 1993)        (cistercense 4723)
;-> ■■■■■                 ;->    ■■
;-> ■  ■ ■                ;->    ■ ■
;-> ■■■■  ■               ;-> ■■■■  ■
;->    ■                  ;->    ■
;->    ■                  ;->    ■
;->    ■                  ;->    ■
;->    ■■■■               ;->   ■■  ■
;->    ■  ■               ;->  ■ ■  ■
;-> ■■■■■■■               ;-> ■  ■■■■

(cistercense 6859)        (cistercense 7085)
;-> ■■■■■■■               ;-> ■  ■■■■
;->  ■ ■  ■               ;-> ■  ■ ■
;->   ■■■■■               ;-> ■■■■■
;->    ■                  ;->    ■
;->    ■                  ;->    ■
;->    ■                  ;->    ■
;-> ■  ■■■■               ;-> ■  ■
;-> ■  ■  ■               ;-> ■  ■
;-> ■  ■  ■               ;-> ■■■■

(cistercense 9433)
;->   ■■■
;->  ■ ■ ■
;-> ■  ■  ■
;->    ■
;->    ■
;->    ■
;-> ■■■■■
;-> ■  ■ ■
;-> ■■■■  ■

(cistercense 1963)
;-> ■  ■■
;-> ■  ■ ■
;-> ■  ■  ■
;->    ■
;->    ■
;->    ■
;->    ■■■■
;->    ■  ■
;-> ■■■■■■■

Versione dei glifi con dimensione della griglia 15x11:

Unità
-----
       (1)            (2)            (3)            (4)           (5)
       ■■■■■■         ■              ■■             ■    ■        ■■■■■■
       ■              ■              ■ ■            ■   ■         ■   ■
       ■              ■              ■  ■           ■  ■          ■  ■
       ■              ■              ■   ■          ■ ■           ■ ■
       ■              ■■■■■■         ■    ■         ■■            ■■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■

       (6)            (7)            (8)            (9)           (0)
       ■    ■         ■■■■■■         ■    ■         ■■■■■■        ■
       ■    ■         ■    ■         ■    ■         ■    ■        ■
       ■    ■         ■    ■         ■    ■         ■    ■        ■
       ■    ■         ■    ■         ■    ■         ■    ■        ■
       ■    ■         ■    ■         ■■■■■■         ■■■■■■        ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■
       ■              ■              ■              ■             ■

Decine
------
       (10)           (20)           (30)           (40)           (50)
  ■■■■■■              ■             ■■         ■    ■         ■■■■■■
       ■              ■            ■ ■          ■   ■          ■   ■
       ■              ■           ■  ■           ■  ■           ■  ■
       ■              ■          ■   ■            ■ ■            ■ ■
       ■         ■■■■■■         ■    ■             ■■             ■■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■

       (60)           (70)           (80)           (90)
  ■    ■         ■■■■■■         ■    ■         ■■■■■■
  ■    ■         ■    ■         ■    ■         ■    ■
  ■    ■         ■    ■         ■    ■         ■    ■
  ■    ■         ■    ■         ■    ■         ■    ■
  ■    ■         ■    ■         ■■■■■■         ■■■■■■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■

Centinaia
---------
       (100)          (200)          (300)          (400)          (500)
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■■■■■■         ■    ■         ■■             ■■
       ■              ■              ■   ■          ■ ■            ■ ■
       ■              ■              ■  ■           ■  ■           ■  ■
       ■              ■              ■ ■            ■   ■          ■   ■
       ■■■■■■         ■              ■■             ■    ■         ■■■■■■

       (600)          (700)          (800)          (900)
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■    ■         ■    ■         ■■■■■■         ■■■■■■
       ■    ■         ■    ■         ■    ■         ■    ■
       ■    ■         ■    ■         ■    ■         ■    ■
       ■    ■         ■    ■         ■    ■         ■    ■
       ■    ■         ■■■■■■         ■    ■         ■■■■■■

Migliaia
--------
       (1000)         (2000)         (3000)         (4000)         (5000)
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■              ■              ■              ■              ■
       ■         ■■■■■■         ■    ■             ■■             ■■
       ■              ■          ■   ■            ■ ■            ■ ■
       ■              ■           ■  ■           ■  ■           ■  ■
       ■              ■            ■ ■          ■   ■          ■   ■
  ■■■■■■              ■             ■■         ■    ■         ■■■■■■

       (6000)         (7000)         (8000)         (9000)
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
       ■              ■              ■              ■
  ■    ■         ■    ■         ■■■■■■         ■■■■■■
  ■    ■         ■    ■         ■    ■         ■    ■
  ■    ■         ■    ■         ■    ■         ■    ■
  ■    ■         ■    ■         ■    ■         ■    ■
  ■    ■         ■■■■■■         ■    ■         ■■■■■■

Numero 5555:

  ■■■■■■■■■■■
   ■   ■   ■
    ■  ■  ■
     ■ ■ ■
      ■■■
       ■
       ■
       ■
       ■
       ■
      ■■■
     ■ ■ ■
    ■  ■  ■
   ■   ■   ■
  ■■■■■■■■■■■


-------------------
La funzione "match"
-------------------

******************
>>>funzione MATCH
******************
sintassi: (match list-pattern list-match [bool])

Il pattern (modello) in "list-pattern" viene confrontato con la lista in "list-match" e le espressioni corrispondenti vengono restituite in una lista. I tre caratteri jolly ?, + e * possono essere utilizzati in "list-pattern".

I caratteri jolly possono essere nidificati. "match" restituisce una lista di espressioni corrispondenti. Per ciascuno ? (punto interrogativo), viene restituito un elemento corrispondente dell'espressione. Per ogni + (segno più) o * (asterisco), viene restituito una lista contenente gli elementi corrispondenti. Se il pattern non può essere confrontato con la lista in "list-match", "match" restituisce nil. Se non sono presenti caratteri jolly nel pattern, viene restituito una lista vuota.

Opzionalmente, il valore booleano true (o qualsiasi altra espressione che non valuta nil) può essere fornito come terzo argomento. Ciò fa sì che "match" mostri tutti gli elementi nel risultato restituito.

"match" è spesso impiegato come parametro functor in "find", "ref", "ref-all" e "replace" ed è usato internamente da "find-all" per le liste.

(match '(a ? c) '(a b c))

;->(b)

(match '(a ? ?) '(a b c))
;->(b c)

(match '(a ? c) '(a (x y z) c))
;->((x y z))

(match '(a ? c) '(a (x y z) c) true)
;->(a (x y z) c)

(match '(a ? c) '(a x y z c))
;->nil

(match '(a * c) '(a x y z c))
;-> ((x y z))

(match '(a * c) '(a x y z c) true)
;->(a (x y z) c)

(match '(a (b c ?) x y z) '(a (b c d) x y z))
;-> (d)

(match '(a (*) x ? z) '(a (b c d) x y z))
;-> ((b c d) y)

(match '(+) '())
;-> nil

(match '(+) '(a))
;-> ((a))

(match '(+) '(a b))
;-> ((a b))

(match '(a (*) x ? z) '(a () x y z))
;-> (() y)

(match '(a (+) x ? z) '(a () x y z))
;-> nil

Nota che l'operatore * cerca di catturare il minor numero di elementi possibile, ma abbina i backtrack e cattura più elementi se non è possibile trovare una corrispondenza.

L'operatore + funziona in modo simile all'operatore *, ma richiede almeno una lista con un elemento.

L'esempio seguente mostra come le espressioni corrispondenti possono essere associate a variabili.

(map set '(x y) (match '(a (? c) d *) '(a (b c) d e f)))
x
;-> b
y
;-> (e f)

Si noti che "match" per le stringhe è stata eliminata. Per una corrispondenza di stringhe più potente, usa "regex", "find", "find-all" o "parse".

"unify" è un'altra funzione per abbinare le espressioni in modo simile al PROLOG.

Esempi:

Conversione da stringa a intero di tutti gli elementi di una lista annidata:

(set-ref-all '(*) '(("1" "2" "3") ("4")) (map int $it) match)
;-> ((1 2 3) (4))

Altro metodo senza usare "match":

(map (curry map int) '(("1" "2" "3") ("4")))
;-> ((1 2 3) (4))

Come usare un pattern con "match"
---------------------------------

(set 'numbers '(1 2 3 4 5 6 7))
(set 'matches (match '(* 5 * ) numbers))
;-> ((1 2 3 4) (6 7))

(set 'n 5)
(set 'matches (match '(* n * ) numbers))
;-> nil

La soluzione corretta è la seguente:

(set 'matches (match (list '* n '*) numbers))
;-> ((1 2 3 4) (6 7))

... ed ecco un secondo modo:

(letex (n 5) (match '(* n * ) numbers))
;-> ((1 2 3 4) (6 7))

Se abbiamo una lista di numeri:

(set 'numbers '(1 2 3 4 5 6 7))
(set 'p '(2 3))
(set 'matches (match (list '* p '*) numbers))
;-> nil

Questo non è possibile, perchè ogni specifica nel pattern descrive un elemento della lista di ricerca, che potrebbe essere un'altro lista (es. (1 2)) ma non una sottolista. Questo è il motivo per cui bisogna spezzare p in a e b.

(set 'a 2 'b 3)
(match (list '* a b '*) numbers)
;-> ((1) (4 5 6 7))

oppure:

(letex (a 2 b 3) (match '(* a b *) numbers))
;-> ((1) (4 5 6 7))

Il problema originale dovrebbe essere questo:

(set 'numbers '(1 (2 3) 4 5 6 7))
;-> (1 (2 3) 4 5 6 7)
(set 'p '(2 3))
;-> (2 3)
(set 'matches (match (list '* p '*) numbers))
;-> ((1) (4 5 6 7))


-----------
Analisi DNA
-----------

Data questa stringa che rappresenta un pezzo di DNA:

(setq s "CGTAAAAAATTACAACGTCCTTTGGCTATCTCTTAAACTCCTGCTAAATG
         CTCGTGCTTTCCAATTATGTAAGCGTTCCGAGACGGGGTGGTCGATTCTG
         AGGACAAAGGTCAAGATGGAGCGCATCGAACGCAATAAGGATCATTTGAT
         GGGACGTTTCGTCGACAAAGTCTTGTTTCGAGAGTAACGGCTACCGTCTT
         CGATTCTGCTTATAACACTATGTTCTTATGAAATGGATGTTCTGAGTTGG
         TCAGTCCCAATGTGCGGGGTTTCTTTTAGTACGTCGGGAGTGGTATTATA
         TTTAATTTTTCTATATAGCGATCTGTATTTAAGCAATTCATTTAGGTTAT
         CGCCGCGATGCTCGGTTCGGACCGCCAAGCATCTGGCTCCACTGCTAGTG
         TCCTAAATTTGAATGGCAAACACAAATAAGATTTAGCAATTCGTGTAGAC
         GACCGGGGACTTGCATGATGGGAGCAGCTTTGTTAAACTACGAACGTAAT")

Contare le occorrenze delle varie basi: Adenina, Citosina, Guanina e Timina (A,C,G,T)

Nota: nell'RNA al posto della Timina è presente l'Uracile.

Potremmo usare "find-all" per ogni base:

(find-all "A" s)
$count
;-> 129
...

Ma la funzione "count" è molto più comoda e veloce:

(define (stat-dna str)
  ; create list of chars
  (let (dna (explode str))
       ; accoppia le basi con il relativo numero di occorrenze
       (map list '("A" "C" "G" "T")
                  ; conta le occorrenze delle basi A, C, G e T
                  (count '("A" "C" "G" "T") dna))))

(stat-dna s)
;-> (("A" 129) ("C" 97) ("G" 119) ("T" 155))


----------------------------
Caratteri a matrice di punti
----------------------------

Vediamo un metodo per stampare caratteri personalizzati.
Definiamo una serie di caratteri utilizzando una matrice di punti 7x7.
Prima scriviamo le funzioni che ci permettono di unire una serie di caratteri e di stampare una serie di caratteri.

Funzione che stampa una matrice/carattere: se l'elemento della matrice vale 0, allora stmap uno spazio " ",
altrimenti stampa un carattere (es. "■").

Funzione che unisce due caratteri (matrici). Le matrici devono avere lo stesso numero di righe.

(define (join-chars)
  (local (rows out)
    (setq rows (length ((args 0) 0)))
    (setq out '())
    (for (r 0 (- rows 1))
      (setq riga '())
      (dolist (c (args))
        (setq riga (append riga (c r)))
      )
      (push riga out -1)
    )
    out))

Funzione che stampa una matrice/caratteri. Se l'elemento della matrice vale 0, allora stampa uno spazio " ",
altrimenti stampa un carattere (es. "█").

(define (print-chars m)
    (for (r 0 (- (length m) 1))
      (for (c 0 (- (length (m 0)) 1))
        (if (zero? (m r c))
            (print " ")
            (print "█")
            ;(print "■")
            ;(print "∙")
        )
        ;(print (m r c))
      )
      (println)))

(print-chars '((1 0 1) (0 1 0) (1 1 1)))
;-> █ █
;->  █
;-> ███

Adesso definiamo i caratteri dell'alfabeto:

; -----------------
; Lettere maiuscole
; -----------------
(setq a '((0 0 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 1 1 1 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)))
;
(setq b '((0 1 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 1 1 1 0 0)))
;
(setq c '((0 0 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 1 0)
          (0 0 1 1 1 0 0)))
;
(setq d '((0 1 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 1 1 1 0 0)))
;
(setq e '((0 1 1 1 1 1 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 1 1 1 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 1 1 1 1 0)))
;
(setq f '((0 1 1 1 1 1 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 1 1 1 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)))
;
(setq g '((0 0 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 1 1 0)
          (0 1 0 0 0 1 0)
          (0 0 1 1 1 0 0)))
;
(setq h '((0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 1 1 1 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)))
;
(setq i '((0 0 1 1 1 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 1 1 1 0 0)))
;
(setq j '((0 0 0 0 0 1 0)
          (0 0 0 0 0 1 0)
          (0 0 0 0 0 1 0)
          (0 0 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 0 1 1 1 0 0)))
;
(setq k '((0 1 0 0 0 1 0)
          (0 1 0 0 1 0 0)
          (0 1 0 1 0 0 0)
          (0 1 1 0 0 0 0)
          (0 1 0 1 0 0 0)
          (0 1 0 0 1 0 0)
          (0 1 0 0 0 1 0)))
;
(setq l '((0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 1 1 1 1 0)))
;
(setq m '((0 1 0 0 0 1 0)
          (0 1 1 0 1 1 0)
          (0 1 0 1 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)))
;
(setq n '((0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 1 0 0 1 0)
          (0 1 0 1 0 1 0)
          (0 1 0 0 1 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)))
;
(setq o '((0 0 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 0 1 1 1 0 0)))
;
(setq p '((0 1 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 1 1 1 0 0)
          (0 1 0 0 0 0 0)
          (0 1 0 0 0 0 0)))
;
(setq q '((0 0 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 1 0 1 0)
          (0 1 0 0 1 1 0)
          (0 0 1 1 1 1 0)))
;
(setq r '((0 1 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)))
;
(setq s '((0 0 1 1 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 0 0)
          (0 0 1 1 1 0 0)
          (0 0 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 0 1 1 1 0 0)))
;
(setq t '((0 1 1 1 1 1 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)))
;
(setq u '((0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 0 1 1 1 0 0)))
;
(setq v '((0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 0 1 0 1 0 0)
          (0 0 0 1 0 0 0)))
;
(setq w '((0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 1 0 1 0)
          (0 1 1 0 1 1 0)
          (0 1 0 0 0 1 0)))
;
(setq x '((0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 0 1 0 1 0 0)
          (0 0 0 1 0 0 0)
          (0 0 1 0 1 0 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)))
;
(setq y '((0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 1 0 0 0 1 0)
          (0 0 1 0 1 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)
          (0 0 0 1 0 0 0)))
;
(setq z '((0 1 1 1 1 1 0)
          (0 0 0 0 0 1 0)
          (0 0 0 0 1 0 0)
          (0 0 0 1 0 0 0)
          (0 0 1 0 0 0 0)
          (0 1 0 0 0 0 0)
          (0 1 1 1 1 1 0)))

; -------
; Cifre
; -------
(setq d0 '((0 1 1 1 1 1 0)
           (0 1 0 0 0 1 0)
           (0 1 0 0 1 1 0)
           (0 1 0 1 0 1 0)
           (0 1 1 0 0 1 0)
           (0 1 0 0 0 1 0)
           (0 1 1 1 1 1 0)))
;
(setq d1 '((0 0 0 1 0 0 0)
           (0 0 1 1 0 0 0)
           (0 0 0 1 0 0 0)
           (0 0 0 1 0 0 0)
           (0 0 0 1 0 0 0)
           (0 0 0 1 0 0 0)
           (0 0 1 1 1 0 0)))
;
(setq d2 '((0 1 1 1 1 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 1 1 1 1 1 0)
           (0 1 0 0 0 0 0)
           (0 1 0 0 0 0 0)
           (0 1 1 1 1 1 0)))
;
(setq d3 '((0 1 1 1 1 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 1 1 1 1 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 1 1 1 1 1 0)))
;
(setq d4 '((0 1 0 0 0 1 0)
           (0 1 0 0 0 1 0)
           (0 1 0 0 0 1 0)
           (0 1 1 1 1 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)))
;
(setq d5 '((0 1 1 1 1 1 0)
           (0 1 0 0 0 0 0)
           (0 1 0 0 0 0 0)
           (0 1 1 1 1 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 1 1 1 1 1 0)))
;
(setq d6 '((0 1 1 1 1 1 0)
           (0 1 0 0 0 0 0)
           (0 1 0 0 0 0 0)
           (0 1 1 1 1 1 0)
           (0 1 0 0 0 1 0)
           (0 1 0 0 0 1 0)
           (0 1 1 1 1 1 0)))
;
(setq d7 '((0 1 1 1 1 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)))
;
(setq d8 '((0 1 1 1 1 1 0)
           (0 1 0 0 0 1 0)
           (0 1 0 0 0 1 0)
           (0 1 1 1 1 1 0)
           (0 1 0 0 0 1 0)
           (0 1 0 0 0 1 0)
           (0 1 1 1 1 1 0)))
;
(setq d9 '((0 1 1 1 1 1 0)
           (0 1 0 0 0 1 0)
           (0 1 0 0 0 1 0)
           (0 1 1 1 1 1 0)
           (0 0 0 0 0 1 0)
           (0 0 0 0 0 1 0)
           (0 1 1 1 1 1 0)))

;---------------------
; Operatori aritmetici
;---------------------
(setq plus '((0 0 0 0 0 0 0)
             (0 0 0 1 0 0 0)
             (0 0 0 1 0 0 0)
             (0 1 1 1 1 1 0)
             (0 0 0 1 0 0 0)
             (0 0 0 1 0 0 0)
             (0 0 0 0 0 0 0)))
;
(setq minus '((0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 1 1 1 1 1 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)))
;
(setq mult '((0 0 0 0 0 0 0)
             (0 1 0 0 0 1 0)
             (0 0 1 0 1 0 0)
             (0 0 0 1 0 0 0)
             (0 0 1 0 1 0 0)
             (0 1 0 0 0 1 0)
             (0 0 0 0 0 0 0)))
;
(setq divis '((0 0 0 0 0 0 0)
              (0 0 0 1 0 0 0)
              (0 0 0 0 0 0 0)
              (0 1 1 1 1 1 0)
              (0 0 0 0 0 0 0)
              (0 0 0 1 0 0 0)
              (0 0 0 0 0 0 0)))
;
(setq equal '((0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 1 1 1 1 1 0)
              (0 0 0 0 0 0 0)
              (0 1 1 1 1 1 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)))

;---------------------------
; Caratteri non alfanumerici
;---------------------------
(setq space '((0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0)))
;
(setq lpar '((0 0 0 1 0 0 0)
             (0 0 1 0 0 0 0)
             (0 1 0 0 0 0 0)
             (0 1 0 0 0 0 0)
             (0 1 0 0 0 0 0)
             (0 0 1 0 0 0 0)
             (0 0 0 1 0 0 0)))
;
(setq rpar '((0 0 0 1 0 0 0)
             (0 0 0 0 1 0 0)
             (0 0 0 0 0 1 0)
             (0 0 0 0 0 1 0)
             (0 0 0 0 0 1 0)
             (0 0 0 0 1 0 0)
             (0 0 0 1 0 0 0)))
;
(setq gt '((0 1 0 0 0 0 0)
           (0 0 1 0 0 0 0)
           (0 0 0 1 0 0 0)
           (0 0 0 0 1 0 0)
           (0 0 0 1 0 0 0)
           (0 0 1 0 0 0 0)
           (0 1 0 0 0 0 0)))
;
(setq lt '((0 0 0 0 1 0 0)
           (0 0 0 1 0 0 0)
           (0 0 1 0 0 0 0)
           (0 1 0 0 0 0 0)
           (0 0 1 0 0 0 0)
           (0 0 0 1 0 0 0)
           (0 0 0 0 1 0 0)))

Facciamo alcune prove:

(print-chars (join-chars d2 plus d1 equal d3))
;->  █████           █           █████
;->      █    █     ██               █
;->      █    █      █    █████      █
;->  █████  █████    █           █████
;->  █        █      █    █████      █
;->  █        █      █               █
;->  █████          ███          █████

(print-chars (join-chars n e w l i s p))
;->  █   █  █████  █   █  █       ███    ███   ████
;->  █   █  █      █   █  █        █    █   █  █   █
;->  ██  █  █      █   █  █        █    █      █   █
;->  █ █ █  ████   █   █  █        █     ███   █   █
;->  █  ██  █      █ █ █  █        █        █  ████
;->  █   █  █      ██ ██  █        █    █   █  █
;->  █   █  █████  █   █  █████   ███    ███   █


----------------------------------------------------
Importazione di funzioni di libreria in linguaggio C
----------------------------------------------------

Per importare una funzione dalla libreria standard del C (windows) possiamo usare la funzione "import".

Ad esempio per importare la funzione "printf":

(import "msvcrt.dll" "printf")
printf <77C4186A>
(printf "pi = %f\n" 3.1415926)
pi = 3.141593
14

Nota: L'utilizzo errato di import può causare un errore del bus di sistema o può verificarsi un segfault e causare l'arresto anomalo di newLISP o lasciarlo in uno stato instabile.


---------------------
Problema di McNuggets
---------------------

Wah Anita and Picciotto Henri (1994) 
"Algebra: Themes, Tools, Concepts" p.186
"Lesson 5.8 Building-block Numbers" (PDF)
http://www.mathedpage.org/attc/lessons/ch.05/5.08-building-blocks.pdf

Problem
Eric tried to order 13 chicken nuggets at the fast food store. 
The employee informed him that he could order only 6, 9, or 20 nuggets. 
Eric realized he had to decide between ordering 6 + 6 = 12, or 6 + 9 = 15. 
What numbers of nuggets can be ordered by combining 6, 9, and 20? 
What numbers cannot be ordered? 
What is the greatest number that cannot be ordered? Explain.

Il problema delle monete (noto anche come problema di Frobenius) richiede quale sia il massimo importo monetario che non può essere ottenuto utilizzando solo monete di tagli specificati. Ad esempio, l'importo massimo che non può essere ottenuto utilizzando solo monete da 3 e 5 unità è 7 unità. 
La soluzione a questo problema per una data serie di denominazioni di monete è chiamata numero di Frobenius della serie. Il numero di Frobenius esiste fintanto che l'insieme dei tagli delle monete non ha un divisore comune maggiore di 1.

Quando ci sono solo due tagli di monete x e y, allora il numero di Frobenius vale xy − x − y. 
Con più di due tagli, non è nota alcuna formula esplicita. 

In termini matematici il problema può essere enunciato:

Dati interi positivi a1, a2, ..., an tali che gcd(a1, a2, ..., an) = 1, trovi l'intero più grande che non può essere espresso come combinazione conica intera di questi numeri, cioè come un somma

  k1*a1 + k2*a2 + ··· + kn*an,

dove k1, k2, ..., kn sono numeri interi non negativi.

Questo numero intero più grande è chiamato numero di Frobenius dell'insieme (a1, a2, ..., an).

Affinché il numero di Frobenius esista deve risultare MCD(a1, a2, ..., an) sia uguale a 1. In questo caso l'insieme di interi che non può essere espresso come combinazione (a1, a2, ..., an) è limitato secondo il teorema di Schur, e quindi esiste il numero di Frobenius.

Per il problema di Eric:

(define (mcnuggets)
  (local (val lst)
    (setq lst (array 101 '(nil)))
    (for (a 0 (/ 100 6))
      (for (b 0 (/ 100 9))
        (for (c 0 (/ 100 20))
          (setq val (+ (* a 6) (* b 9) (* c 20)))
          (if (<= val 100) (setf (lst val) true))
        )
      )
    )
  (dolist (el lst)
    (if (nil? el) (print $idx { }))
  )
  ))

(mcnuggets)
;-> 1 2 3 4 5 7 8 10 11 13 14 16 17 19 22 23 25 28 31 34 37 43 nil


----------------------------------
Frequenza delle parole di un testo
----------------------------------

Scriviamo una funzione che crea la lista delle parole di un testo e la loro frequenza.
Il risultato si trova nelle liste:
  "freq-num"  lista ordinata crescente: (frequenza - parola)
  "freq-word" lista ordinata crescente: (parola - frequenza)

(define (word-freq text)
  (local (w uniq)
    ; estra le parole in una lista
    (setq w (find-all "\\w+" (read-file text)))
    ; lista di parole univoche (vocabolario)
    (setq uniq (unique w))
    ; lista ordinata crescente: (frequenza - parola)
    (setq freq-num  (sort (map list (count uniq w) uniq)))
    ; lista ordinata crescente: (parola - frequenza)
    (setq freq-word (sort (map list uniq (count uniq w))))
    'done))

Carichiamo un testo:

(silent (setq dorian "F:\\Lisp-Scheme\\newLisp\\MAX\\dorian-grey.txt"))

E creiamo le liste di frequenza:

(word-freq dorian)
;-> done

Vediamo l'ultima parola del vocabolario:

(freq-word -1)
;-> ("zithers" 1)

Vediamo la parola più frequente del vocabolario:
(freq-num -1)
;-> (3351 "the")

Proviamo con un altro testo ("moby-dick.txt" che si trova nella cartella "data"):

(silent (setq moby "F:\\Lisp-Scheme\\newLisp\\MAX\\moby-dick.txt"))

(word-freq moby)
;-> done

(freq-word -1)
;-> ("zoology" 1)

(freq-num -1)
;-> (13770 "the")

Un altro metodo è quello di usare la primitiva "bayes-train":

(define (bayes-freq text)
  (let (words (find-all "\\w+" (read-file text)))
    (bayes-train words 'Vocab)))

(bayes-freq dorian)
;-> (80416)

In questo caso il risultato si trova nel contesto "Vocab".
Numero di parole nel vocabolario:

(length (Vocab))
;-> 7306

((Vocab) 100)
;-> ("Beatrice" (1))

((Vocab) 0)
;-> ("1" (1))

((Vocab) -1)
;-> ("zithers" (1))


--------------------------------------
Velocità di indicizzazione delle liste
--------------------------------------

Creiamo una lista di un milione di numeri:

(silent (setq s (sequence 1 1e6)))

Recuperiamo l'ultimo elemento in tre modi diversi:

1) Indicizzazione calcolando prima la lunghezza della lista

(define (i1 lst) (lst (- (length lst) 1)))

2) Indicizzazione diretta della lista

(define (i2 lst) (lst 999999))

3) Indicizzazione partendo dalla fine della lista

(define (i3 lst) (lst -1))

(println (i1 s) { } (i2  s) { } (i3 s))
;-> 1000000 1000000 1000000

Vediamo i tempi di esecuzione:

(time (i1 s) 100)
;-> 1388.86
(time (i2 s) 100)
;-> 1123.725
(time (i3 s) 100)
;-> 850.491

Facciamo una prova recuperando il penultimo elemento:

(define (p1 lst) (lst (- (length lst) 2)))
(define (p2 lst) (lst 999998))
(define (p3 lst) (lst -2))

(println (p1 s) { } (p2 s) { } (p3 s))
;-> 999999 999999 999999

(time (p1 s) 100)
;-> 1396.194
(time (p2 s) 100)
;-> 1120.531
(time (p3 s) 100)
;-> 1391.127

In questo caso non abbiamo alcun vantaggio nell'indicizzare dalla fine della lista. Infatti newLISP mantiene solo un puntatore all'ultimo elemento della lista.


---------------
Comma quibbling
---------------

Scrivere una funzione per generare una stringa che è la concatenazione delle stringhe di una lista di input dove:

- Un input senza parole produce la stringa di output vuota "".
- Un input di una sola parola, ad es. ("ABC"), produce la stringa di output della parola stessa, ad es. "ABC".
- Un input di due parole, ad es. ("ABC" "DEF"), produce la stringa di output delle due parole separate dalla stringa " e ", ad es. "ABC e DEF".
- Un input di tre o più parole, ad es. ("ABC" "DEF" "G" "H"), produce la stringa di output di tutte le parole (tranne l'ultima) separate da ", " con l'ultima parola separata da " e ", ad es. "ABC, DEF, G e H".

(define (comma lst)
  (local (len out)
    (setq len (length lst))
    (setq out '())
    (cond ((zero? len) (setq out '()))
          ((= len 1) (setq out lst))
          ((= len 2) (setq out (list (lst 0) " e " (lst 1))))
          (true
            (dolist (el lst)
              (push el out -1)
              (push ", " out -1)
            )
            ; remove last ","
            (pop out -1)
            ; change the penultimate element
            ; from "," to " e " 
            (setf (out -2) " e "))
    )
    (join out)))

Proviamo la funzione:

(comma '())
;-> ""
(comma '("ABC"))
;-> "ABC"
(comma '("ABC" "DEF"))
;-> "ABC e DEF"
(comma '("ABC" "DEF" "G" "H"))
;-> "ABC, DEF, G e H"


----------------
Numeri di Rhonda
----------------

Un intero positivo n si dice un numero Rhonda in base "b" se il prodotto delle cifre di n è uguale a "b" volte la somma dei fattori primi di n.

Per esempio, 25662 è un numero Rhonda in base 10:
  la base vale: 10
  la somma dei fattori del numero vale: 2 + 3 + 7 + 13 + 47 = 72
  la somma delle cifre del numero vale: 2 × 5 × 6 × 6 × 2 = 720

Quindi risulta:

  2 × 5 × 6 × 6 × 2 = 720 = 10 × (2 + 3 + 7 + 13 + 47)

I numeri di Rhonda esistono solo in basi che non sono numeri primi.

I numeri Rhonda in base 10 contengono sempre almeno 1 cifra 5 e contengono sempre almeno 1 cifra pari.

Sequenza OEIS A099542:
  1568, 2835, 4752, 5265, 5439, 5664, 5824, 5832, 8526, 12985, 
  15625, 15698, 19435, 25284, 25662, 33475, 34935, 35581, 45951, 
  47265, 47594, 52374, 53176, 53742, 54479, 55272, 56356, 56718, 
  95232, 118465, 133857, 148653, 154462, 161785, ...

Funzione che moltiplica le cifre di un numero:

(define (digit-mul num)
"Calculates the multiplication of the digits of an integer"
  (let (out 1)
    (while (!= num 0)
      (setq out (* out (% num 10)))
      (setq num (/ num 10))
    )
    out))

Funzione che verifica se un numero è di Rhonda:

(define (rhonda? num) ; base 10 only
  (= (* 10 (apply + (factor num))) (digit-mul num)))

(rhonda? 25662)
;-> true

(rhonda? 1)
;-> nil

Calcoliamo i numeri Rhonda fino a 100000:

(filter rhonda? (sequence 1 1e5))
;-> (1568 2835 4752 5265 5439 5664 5824 5832 8526 12985 15625 15698 
;->  19435 25284 25662 33475 34935 35581 45951 47265 47594 52374 
;->  53176 53742 54479 55272 56356 56718 95232)
 
Tempo per calcolare i numeri Rhonda fino a 10 milioni:

(time (filter rhonda? (sequence 1 1e7)))
;-> 28644.423  ; quasi 29 secondi

Modifichiamo le funzioni per calcolare i numeri di Rhonda nelle basi 4,6,8 e 10 (non esistono numeri di Rhonda per basi che sono numeri primi).

Funzione che moltiplica le cifre di un numero in una data base:

(define (digit-mul num base)
  (let (out 1)
    (while (!= num 0)
      (setq out (* out (% num base)))
      (setq num (/ num base))
    )
    out))

(digit-mul 3 2)
;-> 1

(digit-mul 123 4)
;-> 18

Funzione di conversione di un numero tra due basi:

(define (b1-b2 num base1 base2)
"Convert an integer from base1 to base2 (2 <= base <= 10)"
  (if (zero? num) num
      (+ (% num base2) (* base1 (b1-b2 (/ num base2) base1 base2)))))

(b1-b2 123 10 4)
;-> 1323

Funzione che verifica se un numero è di Rhonda:

(define (rhonda? num base)
  (= (* base (apply + (factor num))) (digit-mul num base)))

(rhonda? 25662 10)
;-> true

(rhonda? 10206 4)
;-> true

(b1-b2 10206 10 4)
;-> 2133132

Funzione che calcola i primi numeri di Rhonda in una data base.
L'output è una lista con elementi del tipo:

(num-rhonda-base10 num-rhonda-base)

(define (rhonda limite base)
  (local (out num conta)
    (setq out '())
    (setq num 2)
    (setq conta 0)
    (while (< conta limite)
      (if (rhonda? num base)  
        (begin
          (push (list num (b1-b2 num 10 base)) out -1)
          (++ conta)
        )
      )
      (++ num)
      (if (zero? (% num 100)) print num { }})
    )
    out))

(rhonda 10 10)
;-> ((1568 1568) (2835 2835) (4752 4752) (5265 5265) (5439 5439) 
;->  (5664 5664) (5824 5824) (5832 5832) (8526 8526) (12985 12985))

(rhonda 10 4)
;-> ((10206 2133132) (11935 2322133) (12150 2331312) (16031 3322133) 
;->  (45030 22333212) (94185 112333221) (113022 123211332)
;->  (114415 123323233) (191149 232222231) (244713 323233221))

(rhonda 10 6)
;-> ((855 3543) (1029 4433) (3813 25353) (5577 41453) (7040 52332) 
;->  (7304 53452) (15104 153532) (19136 224332) (35350 431354)
;->  (36992 443132))

(rhonda 10 8)
;-> ((1836 3454) (6318 14256) (6622 14736) (10530 24442) 
;->  (14500 34244) (14739 34623) (17655 42367) (18550 44166)
;->  (25398 61466) (25956 62544))


-----------------------------------
args, $args e main-args, $main-args
-----------------------------------

******************
>>>funzione ARGS
******************
sintassi: (args)
sintassi: (args int-idx-1 [int-idx-2 ... ])

Accede a una lista di tutti gli argomenti non associati passati all'espressione define, define-macro lambda o lambda-macro attualmente in fase di valutazione. Sono disponibili solo gli argomenti della funzione o della macro corrente che rimangono dopo che si è verificata l'associazione di variabili locali. La funzione "args" è utile per definire funzioni o macro con un numero variabile di parametri.

"args" può essere utilizzato per definire macro igieniche che evitano il pericolo di cattura delle variabili. Vedi define-macro.

(define-macro (print-line)
    (dolist (x (args))
        (print x "\n")))
                        
(print-line "hello" "World")

Questo esempio stampa un avanzamento riga dopo ogni argomento. La macro imita l'effetto della funzione integrata println.

Nella seconda sintassi, "args" può assumere uno o più indici (int-idx-n).

(define-macro (foo)
    (print (args 2) (args 1) (args 0)))

(foo x y z) 
zyx 

(define (bar)
  (args 0 2 -1))

(bar '(1 2 (3 4)))  → 4

La funzione foo stampa gli argomenti in ordine inverso. La funzione della barra mostra che "args" viene utilizzato con più indici per accedere agli elenchi nidificati.

Ricorda che (args) contiene solo gli argomenti non già legati alle variabili locali della funzione o della macro corrente:

(define (foo a b) (args))
  
(foo 1 2)        → ()
                 
(foo 1 2 3 4 5)  → (3 4 5

Nel primo esempio viene restituita una lista vuota perché gli argomenti sono legati ai due simboli locali, aeb. Il secondo esempio dimostra che, dopo che i primi due argomenti sono stati vincolati (come nel primo esempio), rimangono tre argomenti che vengono quindi restituiti da args.

(args) può essere usato come argomento per una chiamata di funzione incorporata o definita dall'utente, ma non dovrebbe essere usato come argomento per un'altra macro, nel qual caso (args) non verrebbe valutato e avrebbe quindi sbagliato contenuti nel nuovo ambiente macro.

---------------
Variabile $args
---------------
$args contiene la lista dei parametri non vincolati alle variabili locali. Normalmente la funzione args viene utilizzata per recuperare il contenuto di questa variabile.

**********************
>>>funzione MAIN-ARGS
**********************
sintassi: (main-args)
sintassi: (main-args int-index)

"main-args" restituisce una lista con diversi membri di stringa, uno per l'invocazione del programma e uno per ciascuno degli argomenti della riga di comando.

newlisp 1 2 3

> (main-args)
("/usr/local/bin/newlisp" "1" "2" "3")

Dopo che newlisp 1 2 3 è stato eseguito al prompt dei comandi, "main-args" restituisce un elenco contenente il nome del programma che esegue il richiamo e tre argomenti della riga di comando.

Facoltativamente, "main-args" può richiedere un int-index per l'indicizzazione nell'elenco. Si noti che un indice fuori intervallo causerà la restituzione di nil, non l'ultimo elemento dell'elenco come nell'indicizzazione dell'elenco.

newlisp a b c

> (main-args 0)   
"/usr/local/bin/newlisp"
> (main-args -1)  
"c"
> (main-args 2)   
"b"
> (main-args 10)
nil

Nota che quando newLISP viene eseguito da uno script, "main-args" restituisce anche il nome dello script come secondo argomento:

#!/usr/local/bin/newlisp
# 
# script to show the effect of 'main-args' in script file

(print (main-args) "\n")
(exit)

# end of script file

;; execute script in the OS shell:

script 1 2 3

("/usr/local/bin/newlisp" "./script" "1" "2" "3")

Prova a eseguire questo script con diversi parametri della riga di comando.

--------------------
Variabile $main-args
--------------------
$main-args Contiene la lista degli argomenti della riga di comando passati dal sistema operativo a newLISP quando è stato avviato. Normalmente la funzione "main-args" viene utilizzata per recuperare i contenuti.


------------
Unit testing
------------

Per "unit testing" si intende l'attività di testing (prova, collaudo) di singole unità software. Per unità si intende il minimo componente di un programma dotato di funzionamento autonomo.
Lo unit testing è tipicamente automatico, ed è implementato utilizzando librerie predisposte per ciascun linguaggio di programmazione (newLISP non ha un modulo/libreria per lo unit-testing).
Lo sviluppo dei test case (cioè delle singole procedure di test) può essere considerato parte integrante dell'attività di sviluppo ed è una best practice raccomandata durante lo sviluppo software in quanto è in grado di verificare il corretto funzionamento di ogni singola componente del software in poco tempo e con grande affidabilità.
Lo scopo dello unit testing è quello di verificare il corretto funzionamento di parti di programma, permettendo così una precoce individuazione dei bug.

Vediamo un modulo scritto da Dương "Yang" ヤン Hà Nguyễn che permette di svolgere lo unit testing con newLISP.

File: "nl-unittest.lsp" (nella cartella "Data")
;--------------------------------------------------------------------
;;; Copyright (C) 2011 by Dương "Yang" ヤン Hà Nguyễn <cmpitg@gmail.com>
;;; 
;;; Permission is hereby granted, free of charge, to any person obtaining
;;; a copy of this software and associated documentation files (the
;;; "Software"), to deal in the Software without restriction, including
;;; without limitation the rights to use, copy, modify, merge, publish,
;;; distribute, sublicense, and/or sell copies of the Software, and to
;;; permit persons to whom the Software is furnished to do so, subject to
;;; the following conditions:
;;; 
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;; 
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; This file is not designed to use as a standalone program but in
;;; conjuction with other programs.

;;; need cleaning up!!!!!!!!!!!!
(context 'TermColor)

;;; define some terminal color

(constant '+fg-light-red+     "\027[1;31m")
(constant '+fg-light-green+   "\027[1;32m")
(constant '+fg-light-yellow+  "\027[1;33m")
(constant '+fg-red+           "\027[31m")
(constant '+fg-green+         "\027[32m")
(constant '+fg-yellow+        "\027[33m")

(constant '+bg-cyan+          "\027[46m")
(constant '+bg-dark-gray+     "\027[1;40m")

(constant '+reset+            "\027[0m")

;;; colorize a string
(define (colorize color str)
  (letn ((color-name (term color))
         (const-str (append "+" color-name "+"))
         (color-sym (sym const-str)))
    (append (eval color-sym) str +reset+)))

(context 'UnitTest)

(setq *enable-term-color*       true)   ; use colors in console?
(setq *report-failed*           true)   ; report failed assertions?
(setq *report-passed*           nil)   ; report passed assertions?
(setq *continue-after-failure*  true)
(setq *verbose*                 nil)

;;; current test in a test-case, *cur-test* help tracking a test which
;;; contains other test cases
(setq *cur-test* '())

;;; convert and concat all the arguments into a string and colorize it
;;; if necessary
(define (colorize color)
  (letn (s (apply append (args)))
    (if *enable-term-color*
        (TermColor:colorize color s)
        s)))

(define (report-failure expression)
  (let (report
        (if (true? *verbose*)
            (colorize 'fg-red "--> " (string expression) " FAILED!")
            (colorize 'fg-red
                      ;; "--> Expression: " (string (expression 2))
                      "--> " (string expression)
                      " => Expected: " (string (eval (expression 1)))
                      " -> Received: " (string (eval (expression 2))) ".")))
    (if *report-failed*
        (println report)))
  nil)

(define (report-error expression msg)
  (let (report
        (colorize 'fg-light-yellow "--> " (string expression)
                  " got error(s):\n"
                  (join (map (lambda (s) (append "    " s))
                             (parse msg "\n"))
                        "\n")))
    (println report))
  nil)

;;; requert result of a passed test
(define (report-pass expression)
  (let (report (colorize 'fg-green "--> " (string expression) " passed"))
    (if *report-passed*
        (println report)))
  true)

(define (assertion? form)
  ;; a symbol is an assertion only if it contains "assert="
  (local (res)
    (catch (term (first form)) 'res)
    (ends-with res "assert=")))

(define (report-result expr res)
  ;; (println "-- debug; report-result => " expr " -> " res)
  (if (= true res) (report-pass expr)
      (= nil res) (report-failure expr)
      (report-error expr res)))

;;; run all the test cases and return the list of results
(define (run-and-report cases , res)
  (setq res '())
  (dolist (single-case cases)
    (let (*cur-results* '() *cur-expressions* '())
      (catch (eval single-case) 'some-error)

      ;; now, we have the list current results as well as their
      ;; corresponding expressions: ``*cur-results*`` and
      ;; ``*cur-expressions*``
      (dotimes (idx (length *cur-results*))
        (report-result (*cur-expressions* idx)
                       (*cur-results* idx)))

      (setq res (append res *cur-results*)))))

(define-macro (check test-cases cur-test)
;;  (println)
  (println "=== Testing " (eval cur-test))

  (letn (time-running 0 result-list '())

    ;; calculate result and time at the same time
    (setq time-running
          (time (setq result-list (run-and-report test-cases))))

    ;; because result-list may contain non-assertion expression, we
    ;; need to filter them out
    (letn ((passed-ass (length (filter (lambda (x) (= true x))
                                       result-list)))
           (failed-ass (length (filter (lambda (x) (!= true x))
                                       result-list)))
           (total-ass (+ passed-ass failed-ass))
           (msg-passed (append (string passed-ass) " pass(es)"))
           (msg-failed (append (string failed-ass) " fail(s)")))

      ;; colorize if necessary
      (if (< 0 passed-ass)
          (setq msg-passed (colorize 'fg-light-green msg-passed)))
      (if (< 0 failed-ass)
          (setq msg-failed (colorize 'fg-light-red msg-failed)))

      (println ">>> Total assertions: " total-ass)
      (println "  - " msg-passed)
      (println "  - " msg-failed)
      (println "  - Total time: " time-running "ms")
      (println)

      ;; the test case is considered passed only if there's no failure
      (= 0 failed-ass))))

;;; run all test cases, aka functions of the form ``test_``
(define (run-all cont)
  (println)
  (println "======================================================================")
  (letn (counter 0 failed 0 passed 0 time-running 0)
    (dotree (symbol cont)
      (if (starts-with (term symbol) "test_")
          (begin
            (inc time-running
                 (time (if (apply symbol)
                           (inc passed)
                           (inc failed))))
            (println "----------------------------------------------------------------------"))))

    ;; make report and colorize if necessary
    (setq counter (+ failed passed))

    (println "STATUS:")
    (println "==> RAN " counter " test(s) IN " time-running "ms")
    (println "==> "
             (if (zero? failed)
                 (colorize 'bg-dark-gray
                           (colorize 'fg-green "ALL PASSED!!!"))
                 (colorize 'bg-dark-gray
                           (colorize 'fg-red
                                     "FAILED (failures = "
                                     (string failed) ")"))))
    (println "======================================================================")
    (println)
    (zero? failed)))

;;;
;;; convenient methods in context 'MAIN
;;;

(context 'MAIN)

;;;
;;; alias for ``=`` for testing clarification
;;;
(define-macro (assert= expected expression , _ass-result)
  (catch
      (eval '(apply = (list (eval expected) (eval expression))))
    '_ass-result)
  ;; eval the expression and save the result
  (push _ass-result UnitTest:*cur-results* -1)
  ;; save the expression as symbol
  (push (list 'assert= expected expression)
        UnitTest:*cur-expressions* -1)
  ;; (println "-- debug => " (list 'assert= expected expression) " -> "
  ;;          _ass-result)
  _ass-result)

;;;
;;; what this functions does are
;;;   * setting the current test, tracking if the current test contains other tests
;;;   * evaluating every expression in the current test and return the result
(define-macro (define-test params)
  ;;
  ;; `params`     the function signature
  ;; `test_name`  is the name of the test, equals `(first params)`
  ;; `exps`       is the body of the
  ;;
  (eval (expand '(define signature
                  (let ((UnitTest:*cur-test*
                         (append UnitTest:*cur-test* '(test-name))))
                    (UnitTest:check exps UnitTest:*cur-test*)))
                (list (list 'signature  params)
                      (list 'exps       (args))
                      (list 'test-name  (params 0))))))

;;; make all symbol used for testing available
(global 'assert=)
(global 'define-test)
;;eof
;--------------------------------------------------------------------
File: "nl-unittest.lsp" (nella cartella "Data")

;;
;; Demo Test unit
;;

;; Load unit testing module
;(real-path)
;(change-dir "F:\\Lisp-Scheme\\newLisp\\MAX\\_unit-test")
(load "nl-unittest.lsp")

;; Functions to test
;(load "test.lsp")
(define (somma a b) (+ a b))
(define (sottrae a b) (- a b))

;; Tests

(define-test (test_somma_1)
  (assert= 2
           (somma 1 1)))

(define-test (test_somma_2)
 (assert= 0
          (somma 1 -1)))

(define-test (test_sottrae_1)
  (assert= (+ 2 2)
           (sottrae 8 4)))

(define-test (test_all)
  (assert= 0
           (somma 4 (sottrae 4 8))))

(UnitTest:run-all 'MAIN)
;-> ======================================================================
;-> === Testing (MAIN:test_all)
;-> >>> Total assertions: 1
;->   - 1 pass(es)
;->   - 0 fail(s)
;->   - Total time: 0ms
;-> 
;-> ----------------------------------------------------------------------
;-> === Testing (MAIN:test_somma_1)
;-> >>> Total assertions: 1
;->   - 1 pass(es)
;->   - 0 fail(s)
;->   - Total time: 0ms
;-> 
;-> ----------------------------------------------------------------------
;-> === Testing (MAIN:test_somma_2)
;-> >>> Total assertions: 1
;->   - 1 pass(es)
;->   - 0 fail(s)
;->   - Total time: 0ms
;-> 
;-> ----------------------------------------------------------------------
;-> === Testing (MAIN:test_sottrae_1)
;-> >>> Total assertions: 1
;->   - 1 pass(es)
;->   - 0 fail(s)
;->   - Total time: 0ms
;-> 
;-> ----------------------------------------------------------------------
;-> STATUS:
;-> ==> RAN 4 test(s) IN 0.996ms
;-> ==> ALL PASSED!!!
;-> ======================================================================
;-> 
;-> true
;(println)
;(exit)


--------------------------------------
Area di una circonferenza (montecarlo)
--------------------------------------

Calcoliamo pi greco con il metodo di Montecarlo e poi lo utilizziamo per calcolare l'area della circonferenza data.
Utilizziamo solo il quadrante in alto a destra di un cerchio di raggio 1 con centro in (0, 0).

(define (f x y)
  (if (<= (add (mul x x) (mul y y)) 1)
      1
      0))

(define (pi iter)
  (let (res 0)
    (seed (time-of-day))
    (for (i 1 iter)
      (++ res (f (random) (random)))
    )
    ; moltiplichiamo per i 4 quadranti
    (mul 4 (div res iter))))

(define (area-circle radius iter)
  (mul (pi iter) radius radius))

Facciamo alcune prove:

(area-circle 4 1e5)
;-> 50.41792

(area-circle 4 1e7)
;-> 50.2565184

(setq PI 3.1415926535897931)
(mul PI 4 4)
;-> 50.26548245743669

Vediamo l'errore in funzione del numero di iterazioni:

(define (diff radius iter)
  (local (m r err)
    (setq r (mul PI radius radius))
    (setq m (mul (pi iter) radius radius))
    (setq err (sub r m))
    (println "reale:" r)
    (println "montecarlo: " m)
    (println "err = " err)))

(diff 4 1e5)
;-> reale:50.26548245743669
;-> montecarlo: 50.2016
;-> err = 0.06388245743669074

(diff 4 1e6)
;-> reale:50.26548245743669
;-> montecarlo: 50.273664
;-> err = -0.008181542563306721

(diff 4 1e7)
;-> reale:50.26548245743669
;-> montecarlo: 50.2611264
;-> err = 0.004356057436687877


------------------------------------------
Area di intersezione tra due circonferenze
------------------------------------------

Calcolare l'area di intersezione di due circonferenze.

Vedi immagine "circles-intersection.png" nella cartella "data".

Cerchio 1: C1
  raggio = r1
  centro: (c1x, c1y)

Cerchio 2: C2
  raggio = r2
  centro: (c2x, c2y)

Con r1 >= r2

Distanza tra i centri = d

Dati due cerchi C1 e C2 rispettivamente di raggio r1 e r2 (con r1 ≥ r2) i cui centri sono ad una distanza d l'uno dall'altro, l'area di intersezione dei cerchi è:

1. zero, se d ≥ r1+r2, poiché in questo caso le circonferenze si intersecano al massimo fino ad un punto.

2. π*r2^2, se d ≤ r1−r2, poiché in questo caso C2 è interamente contenuto in C1.

3. data dall'equazione seguente in tutti gli altri casi:

  Area = r1^2 * acos (d1/r1) - d1 * sqrt(r1^2 - d1^2) +
         r2^2 * acos (d2/r2) - d2 * sqrt(r2^2 - d2^2)

dove:

  d1 = (r1^2 - r2^2 + d^2)/(2*d)

  d2 = (d - d1) (r2^2 - r1^2 + d^2)/(2*d)

  d = sqrt((c1x - c2x)^2 + (c1y - c2y)^2)

Scriviamo la funzione:

(setq PI 3.1415926535897931)

(define (area r1 r2 c1x c1y c2x c2y)
  (local (a b d d1 d2)
    ; r1 must be greater then r2
    (if (> r2 r1)
      (begin
        (swap r1 r2)
        (swap c1x c2x)
        (swap c1y c2y)
      )
    )
    (setq d (sqrt (add (mul (sub c1x c2x) (sub c1x c2x))
                       (mul (sub c1y c2y) (sub c1y c2y)))))
    ;(println "d: " d)
    (cond ((>= d (add r1 r2)) 0)
          ((<= d (sub r1 r2)) (mul PI r2 r2))
          (true
            (setq d1 (div (add (sub (mul r1 r1) (mul r2 r2)) (mul d d))
                          (mul 2 d)))
            (setq d2 (div (add (sub (mul r2 r2) (mul r1 r1)) (mul d d))
                          (mul 2 d)))
            (setq a (sub (mul r1 r1 (acos (div d1 r1)))
                         (mul d1 (sqrt (sub (mul r1 r1) (mul d1 d1))))))
            (setq b (sub (mul r2 r2 (acos (div d2 r2)))
                         (mul d2 (sqrt (sub (mul r2 r2) (mul d2 d2))))))
            (add a b))
    )))

Facciamo alcune prove:

(area 5 3 2 2 2 2)
;-> 28.27433388230814
(mul PI 3 3)
;-> 28.27433388230814

(area 5 3 2 2 5 5)
;-> 16.77037113300692

(area 5 3 2 2 9 9)
;-> 0

Per verificare i risultati scriviamo una funzione che calcola l'area di sovrapposizione tra due cerchi con il metodo di Montecarlo. L'algoritmo è il seguente:

1. calcolare il rettangolo di contenimento dei due cerchi (Minimal Bounded Rectangle - MBR)
2. generare N punti casuali all'interno del rettangolo
3. verificare quanti (K) degli N punti cadono all'interno dell'intersezione dei due cerchi
4. calcolare l'area di intersezione con la formula:

           K
   Area = --- * AreaMBR
           N

(define (rand-range-f min-val max-val)
"Generate a random float in a closed range"
  (if (> min-val max-val) (swap min-val max-val))
  (add min-val (random 0 (sub max-val min-val))))

(define (area-monte r1 r2 c1x c1y c2x c2y iter)
  (local (in xmin xmax ymin ymax square-area x y)
    (setq in 0)
    ; calculates coordinates of
    ; minimal bounded rectangle of circles (MBR)
    (setq xmin (min (sub c1x r1) (sub c2x r2)))
    (setq xmax (max (add c1x r1) (add c2x r2)))
    (setq ymin (min (sub c1y r1) (sub c2y r2)))
    (setq ymax (max (add c1y r1) (add c2y r2)))
    ; area of MBR
    (setq square-area (mul (sub xmax xmin) (sub ymax ymin)))
    ;(println "xmin, xmax: " xmin ", " xmax)
    ;(println "ymin, ymax: " ymin ", " ymax)
    ;(println "square-area: " square-area)
    ; iterazioni montecarlo
    (for (i 1 iter)
      ; generate random point within MBR
      (setq x (rand-range-f xmin xmax))
      (setq y (rand-range-f ymin ymax))
      ; random point (x, y) must be inside both circles
      (if (and (<= (sqrt (add (mul (sub x c1x) (sub x c1x))
                              (mul (sub y c1y) (sub y c1y)))) r1)
               (<= (sqrt (add (mul (sub x c2x) (sub x c2x))
                              (mul (sub y c2y) (sub y c2y)))) r2))
          ; update count of inside points
          (++ in)
      )
    )
    (mul square-area (div in iter))))

Facciamo alcune prove e verifiche:

(area 5 3 2 2 2 2)
;-> 28.27433388230814
(area-monte 5 3 2 2 2 2 1e6)
;-> 28.2903

(area 5 3 2 2 5 5)
;-> 16.77037113300692
(area-monte 5 3 2 2 5 5 1e6)
;-> 16.725225

(area 5 3 2 2 9 9)
;-> 0
(area-monte 5 3 2 2 9 9 1e6)
;-> 0


------------------
Gocce dal soffitto
------------------

Dal soffitto cadono casualmente una serie di gocce d'acqua sul pavimento (forse c'è una perdita d'acqua...). Le gocce d'acqua atterrano in posizioni casuali e ciascuna crea un cerchio bagnato di un determinato raggio sul pavimento.
Quanto vale l'area totale che risulta bagnata?

I dati sono memorizzati in una lista in cui ogni elemento rappresenta le caratteristiche di una goccia, cioè le coordinate (xc yc) del centro del cerchio e il raggio del cerchio:

  (xc yc raggio)

Calcolare l'area bagnata del pavimento.

(setq circles '(
;     xc             yc             raggio
    ( 1.6417233788   1.6121789534   0.0848270516)
    (-1.4944608174   1.2077959613   1.1039549836)
    ( 0.6110294452  -0.6907087527   0.9089162485)
    ( 0.3844862411   0.2923344616   0.2375743054)
    (-0.2495892950  -0.3832854473   1.0845181219)
    ( 1.7813504266   1.6178237031   0.8162655711)
    (-0.1985249206  -0.8343333301   0.0538864941)
    (-1.7011985145  -0.1263820964   0.4776976918)
    (-0.4319462812   1.4104420482   0.7886291537)
    ( 0.2178372997  -0.9499557344   0.0357871187)
    (-0.6294854565  -1.3078893852   0.7653357688)
    ( 1.7952608455   0.6281269104   0.2727652452)
    ( 1.4168575317   1.0683357171   1.1016025378)
    ( 1.4637371396   0.9463877418   1.1846214562)
    (-0.5263668798   1.7315156631   1.4428514068)
    (-1.2197352481   0.9144146579   1.0727263474)
    (-0.1389358881   0.1092805780   0.7350208828)
    ( 1.5293954595   0.0030278255   1.2472867347)
    (-0.5258728625   1.3782633069   1.3495508831)
    (-0.1403562064   0.2437382535   1.3804956588)
    ( 0.8055826339  -0.0482092025   0.3327165165)
    (-0.6311979224   0.7184578971   0.2491045282)
    ( 1.4685857879  -0.8347049536   1.3670667538)
    (-0.6855727502   1.6465021616   1.0593087096)
    ( 0.0152957411   0.0638919221   0.9771215985)))

Usiamo un algoritmo che effettua un campionamento con una griglia regolare. Per questo problema questo metodo è più efficiente di un campionamento Montecarlo (forse).

(define (droplets gocce cells)
  (local (xmin xmax ymin ymax dx dy in found)
    (setq xmin (gocce 0 0))
    (setq xmax (gocce 0 0))
    (setq ymin (gocce 0 1))
    (setq ymax (gocce 0 1))
    ; Calcolo del rettangolo di contenimento dei cerchi
    ; Minimal Bounding Rectangle - MBR
    (dolist (c gocce)
      (setq xmin (min xmin (sub (c 0) (c 2))))
      (setq xmax (max xmax (add (c 0) (c 2))))
      (setq ymin (min ymin (sub (c 1) (c 2))))
      (setq ymax (max ymax (add (c 1) (c 2))))
    )
    (setq dx (div (sub xmax xmin) cells))
    (setq dy (div (sub ymax ymin) cells))
    (println "dx: " dx ", dy: " dy)
    (setq in 0)
    (for (row 0 (- cells 1))
      (setq y (add ymin (mul row dy)))
      (for (col 0 (- cells 1))
        (setq x (add xmin (mul col dx)))
        (setq found nil)
        (dolist (c gocce found)
          (if (<= (add (mul (sub x (c 0)) (sub x (c 0)))
                      (mul (sub y (c 1)) (sub y (c 1))))
                  (mul (c 2) (c 2)))
              (set 'in (+ in 1) 'found true)
          )
        )
      )
    )
    (println "in: " in)
    (mul in dx dy)))

Facciamo alcune prove aumentando il numero di celle della griglia (cioè diminuendo la dimensione delle celle della griglia):

Valore vero: 21.56503660...

(droplets circles 500)
;-> dx: 0.0108681366854, dy: 0.0107522775546
;-> in: 184512
;-> 21.56155977200332

(droplets circles 1000)
;-> dx: 0.0054340683427, dy: 0.0053761387773
;-> in: 738126
;-> 21.5638384878351

(droplets circles 2000)
;-> dx: 0.00271703417135, dy: 0.00268806938865
;-> in: 2952616
;-> 21.5646564883901

(droplets circles 3000)
;-> dx: 0.001811356114233333, dy: 0.0017920462591
;-> in: 6643458
;-> 21.56489020283439

(droplets circles 4000)
;-> dx: 0.001358517085675, dy: 0.001344034694325
;-> in: 11810604
;-> 21.56491211356354

(droplets circles 5000)
;-> dx: 0.00108681366854, dy: 0.00107522775546
;-> in: 18454106
;-> 21.56495564287879

(time (droplets 5000))
;-> dx: 0.00108681366854, dy: 0.00107522775546
;-> in: 18454106
;-> 21.56495564287879

Vediamo un altro esempio:

(setq circles1 '(
;     xc         yc        raggio
     ( 0.479477  -0.634017  0.137317)
     (-0.568894  -0.450312  0.211238)
     (-0.907263  -0.434144  0.668432)
     ( 0.279875   0.309700  0.242502)
     (-0.999968  -0.910107  0.455271)
     ( 0.889064  -0.864342  1.292949)
     (-0.701553   0.285499  0.321359)
     (-0.947186   0.261604  0.028034)
     ( 0.805749  -0.175108  0.688808)
     ( 0.813269  -0.117034  0.340474)
     (-0.630897  -0.659249  0.298656)
     (-0.054129  -0.661273  0.270216)
     ( 0.042748   0.469534  0.759090)
     ( 0.079393  -0.803786  0.635903)
     (-0.987166   0.561186  0.740386)
     (-0.246960  -0.774309  1.035616)
     (-0.189155  -0.244443  0.187699)
     ( 0.683683  -0.569687  0.275045)
     (-0.249028  -0.452500  0.713051)
     (-0.070789  -0.898363  0.135069)))

Valore vero: 9.73178...

(droplets circles1 500)
;-> dx: 0.007819129999999999, dy: 0.006917726
;-> in: 179895
;-> 9.730628288824068

(droplets circles1 1000)
;-> dx: 0.003909564999999999, dy: 0.003458863
;-> in: 719643
;-> 9.731480215756719

(droplets circles1 2000)
;-> dx: 0.0019547825, dy: 0.0017294315
;-> in: 2878613
;-> 9.731618822916396

(droplets circles1 3000)
;-> dx: 0.001303188333333333, dy: 0.001152954333333333
;-> in: 6476925
;-> 9.731687563052494

Nota: questo metodo di campionamento raggiunge velocemente l'intorno del risultato esatto, ma poi converge lentamente.

Vediamo di risolvere il problema con il metodo di Montecarlo:

(define (rand-range-f min-val max-val)
"Generate a random float in a closed range"
  (if (> min-val max-val) (swap min-val max-val))
  (add min-val (random 0 (sub max-val min-val))))

(define (droplets-m gocce iter)
  (local (xmin xmax ymin ymax dx dy in found)
    (setq xmin (gocce 0 0))
    (setq xmax (gocce 0 0))
    (setq ymin (gocce 0 1))
    (setq ymax (gocce 0 1))
    ; Calcolo del rettangolo di contenimento dei cerchi
    ; Minimal Bounding Rectangle - MBR
    (dolist (c gocce)
      (setq xmin (min xmin (sub (c 0) (c 2))))
      (setq xmax (max xmax (add (c 0) (c 2))))
      (setq ymin (min ymin (sub (c 1) (c 2))))
      (setq ymax (max ymax (add (c 1) (c 2))))
    )
    (setq dx (sub xmax xmin))
    (setq dy (sub ymax ymin))
    (println "dx: " dx ", dy: " dy)
    (setq in 0)
    (for (i 1 iter)
      (setq x (add xmin (random 0 (sub xmax xmin))))
      (setq y (add ymin (random 0 (sub ymax ymin))))
      (setq found nil)
      (dolist (c gocce found)
        (if (<= (add (mul (sub x (c 0)) (sub x (c 0)))
                    (mul (sub y (c 1)) (sub y (c 1))))
                (mul (c 2) (c 2)))
            (set 'in (+ in 1) 'found true)
        )
      )
    )
    (println "in: " in)
    (mul (div in iter) dx dy)))

(droplets-m circles 1e5)
;-> dx: 5.4340683427, dy: 5.3761387773
;-> in: 73840
;-> 21.57184320755188

(droplets-m circles 1e6)
;-> dx: 5.4340683427, dy: 5.3761387773
;-> in: 738093
;-> 21.56287441575242

(droplets-m circles 1e7)
;-> dx: 5.4340683427, dy: 5.3761387773
;-> in: 7379963
;-> 21.56004939240712


-----------------------
La saggezza della folla
-----------------------

La saggezza della folla è una teoria sociologica e statistica secondo la quale, solo in determinate condizioni, la media delle valutazioni date da un insieme di individui inesperti indipendenti sarebbe in grado di fornire una risposta più adeguata e valida di un qualsiasi parere dato da un esperto. Il termine "folla" si riferisce ad un gruppo non necessariamente coeso di individui, che possono anche non conoscersi o non condividere le medesime idee.

Il tema si trova nel saggio "La saggezza delle folle" scritto da James Surowiecki.

Criteri di validità
-------------------
Ci sono quattro criteri che devono venire rispettati perché la teoria funzioni:

1) Diversità di opinione: ogni persona deve avere un'opinione differente
2) Indipendenza: le opinioni delle persone non devono venire influenzate da quelle altrui
3) Decentralizzazione: nessuno deve essere in grado di pilotarla dall'alto
4) Aggregazione: le opinioni devono poter essere aggregate in modo da ottenere un risultato finale

Secondo la teoria della saggezza della folla:
a) Deve essere possibile riassumere in un unico pensiero la moltitudine di pensieri delle persone che fanno parte della folla.
b) La folla è molto più intelligente della persona più intelligente che ne fa parte.
c) Devono venire rispettate le tre condizioni di diversità, indipendenza e decentralizzazione.
d) Troppa comunicazione può rendere il gruppo meno intelligente.
e) È necessario che vi sia un sistema di aggregazione dell'informazione.
f) Non deve esserci il bisogno di interrogare un esperto.
g) Le migliori decisioni nascono da una discussione.
h) L'informazione corretta deve essere raggiungibile dalle giuste persone, nel momento giusto e nel luogo giusto.
i) Vi sono dei casi in cui la teoria della saggezza della folla fallisce e la folla dà un giudizio errato. Questo avviene quando le persone si influenzano a vicenda invece che sviluppare le proprie opinioni indipendentemente.

Scott E. Page, nel libro "The Difference: How the Power of Diversity Creates Better Groups, Firms, Schools, and Societies"introduce il teorema di predizione della diversità: "L'errore al quadrato della previsione collettiva è uguale all'errore al quadrato medio meno la diversità predittiva". Pertanto, quando la diversità in un gruppo è grande, l'errore della folla è piccolo.

Vediamo di scrivere una funzione per calcolare i valori del teorema di predizione della diversità:

(define (mean lst)
  (div (apply + lst) (length lst)))

(define (diversity-theorem valore pred)
  (local val-medio, avg-sqr-err crowd-error diversity)
    (setq val-medio (mean pred))
    (setq avg-sqr-err (mean (map 
                            (fn(x) (mul (sub x valore) (sub x valore)))
                                  pred)))
    (setq crowd-error (pow (sub (mean pred) valore) 2))
    (setq diversity (mean (map 
                          (fn(x) (mul (sub x val-medio) (sub x val-medio))) 
                                pred)))
    (list avg-sqr-err crowd-error diversity))

Valore vero: 49

Predizione1:
(setq a '(48 47 51))

Predizione2:
(setq b '(48 47 51 42))

(diversity-theorem 49 a)
;-> (3 0.1111111111111127 2.333333333333334)
(diversity-theorem 49 b)
;-> (14.5 4 10.5)

Nota: per una visione più completa vedere il libro "Rumore" di Kahneman, Sibony, Sunstein.


--------------
Zodiaco cinese
--------------

Determinare il segno zodiacale cinese e le relative associazioni per un determinato anno.
Tradizionalmente, i cinesi hanno contato gli anni utilizzando due cicli simultanei, uno di lunghezza 10 (i "steli celesti") e uno di lunghezza 12 (i "rami terrestri"), la combinazione si traduce in uno schema ripetuto di 60 anni.
 La mappatura dei rami di dodici divinità animali tradizionali si traduce nel noto "zodiaco cinese", che assegna ogni anno a un determinato animale.
Gli steli celesti non hanno una mappatura uno a uno come quella dei rami degli animali. Tuttavia, le cinque coppie di steli consecutivi appartengono ciascuna a uno dei cinque elementi tradizionali cinesi (legno, fuoco, terra, metallo e acqua). Inoltre, uno dei due anni all'interno del governo di ciascun elemento è associato a yin, l'altro a yang.
- Il ciclo animale si svolge in questo ordine: Ratto, Bue, Tigre, Coniglio, Drago, Serpente, Cavallo, Capra, Scimmia, Gallo, Cane, Maiale.
- Il ciclo degli elementi si svolge in questo ordine: Legno, Fuoco, Terra, Metallo, Acqua.
- L'anno yang precede l'anno yin all'interno di ogni elemento.

Per esempio, il 2022 è l'anno yang dell'Acqua e della Tigre.

(define (chinese year)
  (local (yy elements animals y e a)
    (setq yy '("yang" "yin"))
    (setq elements '("Wood" "Fire" "Earth" "Metal" "Water"))
    (setq animals '("Rat" "Ox" "Tiger" "Rabbit" "Dragon" "Snake"
                    "Horse" "Goat" "Monkey" "Rooster" "Dog" "Pig"))
    (setq y (% year 2))
    (setq e (/ (% (- year 4) 10) 2))
    (setq a (% (- year 4) 12))
    (list year (elements e) (animals a) (yy y))))

(chinese 2022)
;-> (2022 "Water" "Tiger" "yang")
(chinese 1963)
;-> (1963 "Water" "Rabbit" "yin")
(chinese 1998)
;-> (1998 "Earth" "Tiger" "yang")

In italiano:

(define (cinese anno)
  (local (yy elements animals y e a)
    (setq yy '("yang" "yin"))
    (setq elements '("Legno" "Fuoco" "Terra" "Metallo" "Acqua"))
    (setq animals '("Topo" "Bue" "Tigre" "Coniglio" "Drago" "Serpente"
                    "Cavallo" "Capra" "Scimmia" "Gallo" "Cane" "Maiale"))
    (setq y (% anno 2))
    (setq e (/ (% (- anno 4) 10) 2))
    (setq a (% (- anno 4) 12))
    (list anno (elements e) (animals a) (yy y))))

(cinese 2022)
;-> (2022 "Acqua" "Tigre" "yang")
(cinese 1963)
;-> (1963 "Acqua" "Coniglio" "yin")
(cinese 1998)
;-> (1998 "Terra" "Tigre" "yang")


-----------------------------------------------
Kilometri e miglia (terrestre, marine/nautiche)
-----------------------------------------------

Pollice/Inch     --> 1 in = 0.0254 m = 2.54 cm
Piede/Foot       --> 1 ft = 12 in = 0.3048m = 30.48 cm
Iarda/Yard       --> 1 yd = 3 ft = 0.9144 m
Kilometro        --> 1 km = 1000 m  
Miglio Terrestre --> 1 mi = 1609.344 m
Miglio Marino    --> 1 nm = 1852 m

(define (convert val unit unit-name unit-value)
  (local (idx scala)
    (setq idx (find unit unit-name))
    (setq scala (mul val (unit-value idx)))
    (println val " " unit " is:")
    (dolist (el unit-name)
      (cond ((!= el unit)
            (println (format "%.6f %s" (div scala (unit-value $idx)) el)))
      ))))

(setq length-unit '("km" "m" "cm" "mm" "mi" "yd" "ft" "in" "nm"))

(setq length-value '(1000.0 1.0 0.01 0.001 1609.34 0.9144 0.3048 0.0254 1852))

(convert 5000 "ft" length-unit length-value)
;-> 5000 ft is:
;-> 1.524000 km
;-> 1524.000000 m
;-> 152400.000000 cm
;-> 1524000.000000 mm
;-> 0.946972 mi
;-> 1666.666667 yd
;-> 60000.000000 in
;-> 0.822894 nm


-----------
FOOP e self
-----------

Quella che segue è un'implementazione FOOP che sfrutta i contesti di newLISP (spazi dei nomi) e il passaggio di oggetti per riferimento utilizzando la funzione FOOP "self":

; FOOP stream implementation
(new Class 'Stream) ; creates a Stream context and constructor

; define Stream class methods
(context Stream)

(define (Stream:add elmnt)
    (push elmnt (self) -1))

(define (Stream:read)
    (pop (self) 1))

(context 'MAIN)

now you can do:

(set 'st (Stream 10 20)) ; create a new stream, with optional initial elements
;-> (Stream 10 20)
(:add st 30)
;-> (Stream 10 20 30)
(:read st)
;-> 10
st
;-> (Stream 20 30)

; create a second empty stream
; create empty stream in a-stream
(set 'a-stream (Stream)) 
;-> (Stream)
(:add a-stream 'a)
;-> (Stream a)
(:add a-stream 'b)
;-> (Stream a b)
(:add a-stream 'c)
;-> (Stream a b c)
a-stream
;-> (Stream a b c)
(:read a-stream)
;-> a
(:read a-stream)
;-> b

Non importa quanto sia grande lo stream, l'implementazione FOOP sarà sempre veloce. 
Possiamo aggiungere più metodi alla classe Stream e ridefinire anche il costruttore. 
L'espressione (new Class ‘Stream) è equivalente a:

(context 'Stream
(define (Stream:Stream) (cons (context) (args)))
(context MAIN)


-------------------------------------
exec e redirezione di stdout e stderr
-------------------------------------

newLISP cattura solo l'output standard del comando (stdout). Quindi, se il comando invia l'output allo schermo, probabilmente sta scrivendo in standard error (stderr). Per reindirizzare l'output di standard error su standard output bisogna aggiungere " 2>&1" alla fine del comando "exec".

Facciamo un esempio scrivendo e compilando il seguente progamma in C "test.c":

#include <stdio.h>

int main()
{
        fprintf(stdout, "Standard Output\n");
        fprintf(stderr, "Standard Error\n");
        return 0;
}

Per compilare il file con il compilatore gcc:

gcc test.c -o test.exe

Trovate i file "test.c" e "test.exe" nella cartella "data".

Adesso da una REPL di newLISP:

(exec "test.exe")
;-> Standard Error
;-> ("Standard Output")

(exec "test.exe 2>&1")
;-> ("Standard Output" "Standard Error")
;(exit)

Windows reindirizza anche l'errore standard allo standard output utilizzando la stessa sintassi per il reindirizzamento delle shell UNIX. 
Notare come nel primo esempio newLISP non include l'output inviato allo standard error nel valore restituito da
"exec", ma lo fa nel secondo esempio quando aggiungiamo " 2>&1".


----------------
Numeri magnanimi
----------------

Un numero magnanimo è un numero intero in cui ogni segno più "+" aggiunto tra due cifre genera una somma prima.
Per esempio:

6425 è un numero magnanimo:
6 + 425 = 431 che è primo
64 + 25 = 89 che è primo
642 + 5 = 647 che è primo

3538 non è un numero magnanimo:
3 + 538 = 541 che è primo
35 + 38 = 73 che è primo
ma 353 + 8 = 361 non è primo

I numeri a una cifra da 0 a 9 sono inclusi come numeri magnanimi poiché non c'è posto nel numero in cui è possibile aggiungere un "+" tra due cifre. Fatta eccezione per il valore 0, gli zeri iniziali non sono consentiti. Gli zeri interni vanno bene, 1001 --> 1 + 001 (primo), 10 + 01 (primo) 100 + 1 (primo).

Ci sono solo 571 numeri magnanimi conosciuti. Si sospetta, anche se non è stato dimostrato, che non ci siano numeri magnanimi superiori a 97393713331910.

Sequenza OEIS: A252996
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 14, 16, 20, 21, 23, 25, 29, 30,
  32, 34, 38, 41, 43, 47, 49, 50, 52, 56, 58, 61, 65, 67, 70, 74, 76, 83,
  85, 89, 92, 94, 98, 101, 110, 112, 116, 118, 130, 136, 152, 158, 170,
  172, 203, 209, 221, 227, 229, 245, 265, 281, 310, 316, 334, 338, 356, ...

Funzioni ausiliarie:

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che verifica se un numero è magnanimo:

(define (magnanimo? num)
  (local (lst somme a b stop)
    (setq somme '())
    (setq lst (int-list num))
    (dolist (el lst)
      (setq a (list-int (slice lst 0 $idx)))
      (setq b (list-int (slice lst $idx)))
      ;(println a { } b)
      (if a (push (+ a b) somme -1))
    )
    (setq stop nil)
    (dolist (val somme stop)
      (if-not (prime? val)
          (setq stop true)
      )
    )
  (not stop)))

Facciamo alcune prove:

(magnanimo? 6425)
;-> true
(magnanimo? 3538)
;-> nil
(magnanimo? 1001)
;-> true
(magnanimo? 97393713331910)
;-> true

Funzione che calcola i numeri magnanimi da 0 ad un dato limite:

(define (magnanimi limite)
  (let (out '())
    (for (i 0 limite)
      (if (magnanimo? i)
          (push i out -1)))
    out))

(magnanimi 10000)
;-> (0 1 2 3 4 5 6 7 8 9 11 12 14 16 20 21 23 25 29 30 32 34 38 41 43 47 49
;->  50 52 56 58 61 65 67 70 74 76 83 85 89 92 94 98 101 110 112 116 118 130
;->  136 152 158 170 172 203 209 221 227 229 245 265 281 310 316 334 338 356
;->  358 370 376 394 398 401 403 407 425 443 449 467 485 512 518 536 538 554
;->  556 574 592 598 601 607 625 647 661 665 667 683 710 712 730 736 754 772
;->  776 790 794 803 809 821 845 863 881 889 934 938 952 958 970 974 992 994
;->  998 1001 1112 1130 1198 1310 1316 1598 1756 1772 1910 1918 1952 1970 1990
;->  2209 2221 2225 2249 2261 2267 2281 2429 2447 2465 2489 2645 2681 2885
;->  3110 3170 3310 3334 3370 3398 3518 3554 3730 3736 3794 3934 3974 4001
;->  4027 4063 4229 4247 4265 4267 4427 4445 4463 4643 4825 4883 5158 5176
;->  5374 5516 5552 5558 5594 5752 5972 5992 6001 6007 6067 6265 6403 6425
;->  6443 6485 6601 6685 6803 6821 7330 7376 7390 7394 7534 7556 7592 7712
;->  7934 7970 8009 8029 8221 8225 8801 8821 9118 9172 9190 9338 9370 9374
;->  9512 9598 9710 9734 9752 9910)

(length (magnanimi 10000))
;-> 226

(length (magnanimi 1e5))
;-> 338
(time (length (magnanimi 1e5)))
;-> 559.836

(length (magnanimi 1e6))
;-> 434
(time (length (magnanimi 1e6)))
;-> 7199.944

(length (magnanimi 1e7))
;-> 505
(time (length (magnanimi 1e7)))
;-> 91147.258


------------------------------------
Aggiornamento dei valori dei simboli
------------------------------------

Supponiamo di avere alcuni simboli con valori numerici.
Vogliamo aggiornare i valori aumentando di 1 ogni numero.

Ad esempio supponiamo di avere i seguenti 5 simboli val1, ..., val5:

(for (i 1 5)
  (setq str (string "(setq val" i " " i ")"))
  (println str)
  (eval-string str)
)

(println val1 { } val2 { } val3 { } val4 { } val5)
;-> 1 2 3 4 5

Per aggiornare i valori possiamo usare il metodo seguente:

(dolist (s '(val1 val2 val3 val4 val5))
  (++ (eval s)))

(println val1 { } val2 { } val3 { } val4 { } val5)
;-> 2 3 4 5 6

Se prima vogliamo inserire i simboli in una lista:

(setq out '())
(for (i 1 5)
  ; inserisce numeri
  ;(setq str (string "(push val" i " out -1)"))
  ; inserisce simboli
  (setq str (string "(push 'val" i " out -1)"))
  (eval-string str)
)
out
;-> (val1 val2 val3 val4 val5)

Poi aggiorniamo i valori dei simboli della lista:

(dolist (s out) (++ (eval s)))
(println val1 { } val2 { } val3 { } val4 { } val5)
;-> 3 4 5 6 7 


------------------
Numeri aritmetici
------------------

Un intero positivo n è un numero aritmetico se la media dei suoi divisori positivi è un intero.

Chiaramente tutti i numeri primi dispari p devono essere numeri aritmetici perché i loro unici divisori sono 1 e p la cui somma è pari e quindi la loro media deve essere un intero. Tuttavia, il numero primo 2 non è un numero aritmetico perché la media dei suoi divisori vale 1.5.

Sequenza OEIS: A003601
  1, 3, 5, 6, 7, 11, 13, 14, 15, 17, 19, 20, 21, 22, 23, 27, 29, 30, 31,
  33, 35, 37, 38, 39, 41, 42, 43, 44, 45, 46, 47, 49, 51, 53, 54, 55, 56, 
  57, 59, 60, 61, 62, 65, 66, 67, 68, 69, 70, 71, 73, 77, 78, 79, 83, 85, 
  86, 87, 89, 91, 92, 93, 94, 95, 96, 97, 99, 101, 102, 103, 105, ...

Funzioni ausiliarie:

(define (factor-group num)
"Factorize an integer number"
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

(define (divisors-sum-len num)
"Sum all the divisors of integer number and calculate length"
  (local (sum out)
    (if (= num 1)
        (begin (setq len 1) 1)
        (begin
          (setq out 1)
          (setq lst (factor-group num))
          (setq len (apply * (map (fn(x) (+ 1 (last x))) lst)))
          (dolist (el lst)
            (setq sum 0)
            (for (i 0 (last el))
              (setq sum (+ sum (pow (first el) i)))
            )
            (setq out (* out sum)))))))

Funzione che verifica se un numero è aritmentico:

(define (arithmetic? num)
  (local (sum len)
  (setq sum (divisors-sum-len num))
    (= (div sum len) (/ sum len))
  ))

Facciamo alcune prove:

(arithmetic? 6)
;-> true
(arithmetic? 10)
;-> nil

Funzione che calcola i numeri aritmetici da 0 ad un dato limite:

(define (arithmetic limite)
  (let (out '())
    (for (i 1 limite)
      (if (arithmetic? i)
          (push i out -1)))
    out))

(arithmetic 110)
;-> (1 3 5 6 7 11 13 14 15 17 19 20 21 22 23 27 29 30 31 33 35 37 38 39 41
;->  42 43 44 45 46 47 49 51 53 54 55 56 57 59 60 61 62 65 66 67 68 69 70 71
;->  73 77 78 79 83 85 86 87 89 91 92 93 94 95 96 97 99 101 102 103 105 107
;->  109 110)

(length (arithmetic 10000))
;-> 7688

(length (arithmetic 1e5))
;-> 79412
(time (length (arithmetic 1e5)))
;-> 310.776

(length (arithmetic 1e6))
;-> 812513
(time (length (arithmetic 1e6)))
;-> 3561.75

(length (arithmetic 1e7))
;-> 8262497
(time (length (arithmetic 1e7)))
;-> 45631.26


-----------------------
Contesti come dizionari
-----------------------

Supponiamo di avere N utenti e di voler associare ad ogni utente una lista di processi.
In altre parole vogliamo una struttura dati del tipo:

  (User-Name Process-Name Start-Time Interval-sec End-Time)

che rappresenta un processo.

Supponendo che i nomi dei processi siano tutti differenti, allora possiamo usare il seguente metodo per creare i processi con i relativi attributi (by TedWalther):

(define schedules:schedules)
(define (schedules:add u)
  (let (s (sym (string "_" u)))
    (if (eval s)
      (push (args) (eval s) -1)
      (set (sym (string "_" u)) (list (args))))))

Quindi per inserire i dati possiamo scrivere:

(schedules:add "user1" "Feed plants" 1450754544 604800 1456197744)
;-> (("Feed plants" 1450754544 604800 1456197744))

(schedules:add "user1" "Manicure plants" 1450754544 259200 1453346544)
;-> (("Feed plants" 1450754544 604800 1456197744) 
;->  ("Manicure plants" 1450754544 259200 1453346544))

(schedules:add "user2" "Added" 1450754544 259200 1453346544)
;-> (("Added" 1450754544 259200 1453346544))

(println (schedules "user1"))
;-> (("Feed plants" 1450754544 604800 1456197744) 
;->  ("Manicure plants" 1450754544 259200 1453346544))
(println (schedules "user2"))
;-> (("Added" 1450754544 259200 1453346544))

Questo metodo utilizza i "contesti come dizionari" (cioè sfrutta l'implementazione red-black tree sottostante).


-------------------------------------------
Interazione tra context, constant, e global
-------------------------------------------

Quando un simbolo è dichiarato globale con "global", è possibile dichiararlo "constant" solo nel contesto MAIN.
Per esempio:

(global 'x)
;-> x
(context 'pippo)
;-> pippo

Se usiamo "constant" otteniamo un errore:

(constant 'x 2)
;-> ERR: symbol not in current context in function constant : x

Possiamo usare "set" o "setq":

(set 'x 1)
;-> 1
x
;-> 1

Invece nel contesto MAIN possiamo usare "constant":

(context 'MAIN)
;-> MAIN
(constant 'x 2)
;-> 2

Adesso il simbolo x è protetto in tutti i contesti:

(set 'x 3)
;-> ERR: symbol not in current context in function constant : x

(context 'pippo)
;-> pippo
(set 'x 3)
;-> ERR: symbol not in current context in function constant : foo

Dal manuale:
"Only symbols from the current context can be used with constant. This prevents the overwriting of symbols that have been protected in their home context."

Una buona pratica è quella di rendere un simbolo globale e costante all'inizio in MAIN. Questo lo rende costante, se globale o meno. Entrambi, l'ambito del simbolo ("global") e la protezione ("constant"), sono attributi principali di un simbolo che non dovrebbero essere modificati.
... ma se devi, puoi comunque farlo in questo modo non ovvio:

(eval-string "(constant 'x 4)" MAIN)


--------------
Indice di Gini
--------------

Il coefficiente di Gini è una misura statistica della diseguaglianza che descrive quanto omogenea (o diseguale) risulta la distribuzione di una risorsa (es. reddito) tra gli elementi di un insieme (es. popolazione)il reddito o la ricchezza sono distribuite tra la popolazione di un paese. Il coefficiente assume un valore tra 0 e 1, ed un coefficiente di Gini più elevato è associato ad una più elevata diseguaglianza.

La differenza media assoluta (o differenza media (semplice) di Gini) è una misura di variabilità che mette in evidenza la disuguaglianza dei dati tra loro, indipendentemente da qualsiasi valore medio.
Rappresenta la media aritmetica dei moduli degli scarti di ciascun valore da tutti i rimanenti e si calcola nel modo seguente (l'indicizzazione parte da 1):

           n n
           ∑ ∑|x(i) - x(j)|
           i j
 delta = -------------------- con i ≠ j 
                  n
              2*n*∑x(j)
                  j

Scriviamo due funzioni per calcolare l'indice, la prima è l'implementazione diretta della formula ed ha tempo O(n^2), la seconda utilizza la programmazione dinamica ed ha tempo O(n*log(n)).

(define (gini1 lst)
  ; gini with direct formula
  (local (len res)
    (setq len (length lst))
    (push 0 lst) ; index of data start at 1
    (setq res 0)
    (for (i 1 len)
      (for (j 1 len)
        (if (!= i j) (begin
            (setq res (add res (abs (sub (lst i) (lst j)))))))
      )
    )
    (setq res (div res (mul 2 len (apply add lst))))))

(define (gini2 lst)
  ; gini with dynamic programming
  (setq len (length lst))
  (sort lst)
  (setq sum-diff 0)
  (setq subsum 0)
  (dolist (x lst)
    (setq sum-diff (add sum-diff (mul x $idx) (- subsum)))
    (setq subsum (add subsum x))
  )
  (div sum-diff subsum len))

Facciamo alcune prove:

(setq a '(1 1 2 2)) ; 0.1666667
(setq b '(50 50 70 70 70 90 150 150 150 150)) ; 0.226
(setq c '(150 50 70 70 70 90 150 150 150 50)) ; 0.226
(setq d '(1 2 3 4 5 6 7 8 9 10)) ;0.3
(setq e '(5 1 2 3 4 5)) ; 0.25
(setq f '(5 1 0 3 4 0)) ; 0.5

(println (gini1 a) {, } (gini2 a))
(println (gini1 b) {, } (gini2 b))
(println (gini1 c) {, } (gini2 c))
(println (gini1 d) {, } (gini2 d))
(println (gini1 e) {, } (gini2 e))
(println (gini1 f) {, } (gini2 f))
;-> 0.1666666666666667, 0.1666666666666667
;-> 0.226, 0.226
;-> 0.226, 0.226
;-> 0.3, 0.3
;-> 0.25, 0.25
;-> 0.5, 0.5

=============================================================================

