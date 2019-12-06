+======================+
| The little newLISPER |
+======================+

Appunti in newLISP del libro "The Little Schemer" di Friedman e Felleisen

Nota: newLISP non è uguale a Scheme e quindi ha uno stile/metodo diverso, ma alcune tecniche di programmazione sono comunque utili da conoscere. Il codice del libro è stato adattato per funzionare con newLISP.

Atomo => stringa di caratteri

Lista => collezione di atomi delimitata da parentesi

Tutti gli atomi sono S-expression

Tutti le liste sono S-expression oppure una collezione di S-expression.

Lista vuota => ()

true => true

nil => false

Trace on
(define (dbg-on) (trace true))

Trace off
(define (dbg-off) (trace nil))

CAR function
(define (car x) (first x))

CDR function (pronuncia 'could-er')
(define (cdr x) (rest x))

==============================================================
(first '(a b c))
;-> a

(first '((a) b c))
;-> (a)

(first 'a)
;-> ERR: array, list or string expected in function first : a
Non possiamo applicare la funzione "first" a un atomo.

(first '())
;-> ERR: array, list or string expected in function first : a
Non possiamo applicare la funzione "first" alla lista vuota.

==============================================================
LA LEGGE DI "FIRST"
La funzione "first" è applicabile solo a liste non vuote.
==============================================================

(rest '(a b c))
;-> (b c)

(rest '((a b c) x y z))
;-> (x y z)

(rest '(a))
;-> ()

(rest 'a)
;-> ERR: array, list or string expected in function first : a
Non possiamo applicare la funzione "rest" ad un atomo.

(rest '())
;-> ()
Il "rest" di una lista vuota è una lista vuota.

==============================================================
LA LEGGE DI "REST"
La funzione "rest" è applicabile solo a liste.
Il "rest" di una lista vuota è una lista vuota.
==============================================================

"first" ha come argomento una lista non vuota.
"rest" ha come argomento una lista (anche vuota).

(cons exp-1 exp-2)
Significa: Unisci exp-1 a exp-2
In pratica, "cons" aggiunge exp-1 davanti a exp-2.

(cons atomo lista) => lista
(cons 'a '(b c))
;-> (a b c)

(cons lista-1 lista-2) => lista
(cons '(a b) '(c d))
;-> ((a b) c d)

(cons atomo-1 atomo-2) => lista
(cons 'a 'b)
;-> (a b)
Nota: Non ci sono coppie puntate (a.b) in newLISP.
La funzione "cons" applicata a due atomi produce una lista.

(cons lista atomo) => lista
(cons '(a b) 'c)
((a b) c)

(cons atomo lista-vuota) => lista
(cons 'a '())
;-> (a)

(cons lista-vuota atomo) => lista
(cons '() 'a)
;-> (() a)

(cons lista lista-vuota) => lista
(cons '(a b) '())
;-> ((a b))

(cons lista-vuota lista) => lista
(cons '() '(a b))
;-> ( () a b)

(cons lista-vuota lista-vuota) => lista
(cons '() '())
;-> (())

(cons 'a 'nil)
;-> (a nil)

In newLISP "nil" è un valore booleano e non è equivalente alla lista vuota.

(= 'nil '())
;-> nil

Nota: Le funzioni "first", "rest" e "cons" sono legate tra loro:

A)  (first (cons exp-1 exp-2)) => exp-1

B)  (rest  (cons exp-1 exp-2)) => exp-2

(first (cons '(a b) '(c d)))
;-> (a b)

(rest (cons '(a b) '(c d)))
;-> (c d)

==============================================================
LA LEGGE DI "CONS"
La funzione "cons" ha due argomenti.
Gli argomenti possono essere liste o atomi.
Il risultato è una lista.
==============================================================

(null? '())
;-> true

(null? '(a b c))
;-> nil

(null? 'a)
;-> nil

(null? 'nil)
;-> true

==============================================================
LA LEGGE DI "NULL?"
Il predicato "null?" controlla se una espressione vale:
nil oppure lista vuota. In questi casi restituisce true.
==============================================================

(atom? 'a)
;-> true

(atom? '(a b c))
;-> nil

(atom? '())
;-> nil

(atom? 'nil)
;-> true

==============================================================
LA LEGGE DI "ATOM?"
Il predicato "atom?" controlla se l'argomento è un atomo.
==============================================================

(= 'a 'a)
;-> true

(= 'a 'b)
;-> nil

(= '(a) '(b))
;-> nil

(= 'a '(a b))
;-> nil

(= '(a b c) '(a b c))
;-> true

(= '() 'nil)
;-> nil

==============================================================
LA LEGGE DI "="
La funzione "=" ha due S-espression come argomenti.
Restituisce true solo se gli argomenti sono uguali.
==============================================================

Che cosa fa la seguente funzione "piatta?" ?

(define (piatta? lst)
  (cond
    ((null? lst) true)
    ((atom? (first lst)) (piatta? (rest lst)))
    (true nil)))

(piatta? '(a b c))
;-> true

(piatta? '((a) b))
;-> nil

(piatta? '())
;-> true

(piatta? 'nil)
;-> true

(piatta? '(a b nil))
;-> true

(piatta? 'true)
;-> ERR: array, list or string expected in function first : lst
;-> called from user function (piatta? 'a)

(piatta? 'a)
;-> ERR: array, list or string expected in function first : lst
;-> called from user function (piatta? 'a)

La funzione "piatta?" controlla se una lista contiene solo atomi:
in questo caso restituisce true, altrimenti restituisce nil.

Come funziona ?

(define (piatta? lst)
Definisce una funzione "piatta?" con un solo argomento "lst".

(cond
Controlla l'esecuzione delle tre condizioni che seguono:
  ((null? lst) true)
  ((atom? (first lst)) (piatta? (rest lst)))
  (true nil)))

((null? lst) true)
Se lst è la lista vuota, allora il risultato è true.
Altrimenti esegue la condizione successiva.

((atom? (first lst)) (piatta? (rest lst)))
Se (first lst) è un atomo, allora chiama "piatta?" con parametro (rest lst).
Altrimenti esegue la condizione successiva.

(true nil)))
Se le due condizioni precedenti sono false, allora il risultato è nil.
Questa condizione può essere interpretata come un 'else':
se le precedenti condizioni sono tutte false, allora esegui 'else'
(poichè 'true' è sempre vero).

==============================================================
PRIMO COMANDAMENTO (temporaneo)
Utilizzare sempre null? come prima questione
quando si definisce qualunque funzione.
==============================================================

Che cosa fa la seguente funzione "membro?" ?

(define (membro? atm lst)
  (cond
    ((null? lst) nil)
    (true (or (= (first lst) atm)
              (membro? atm (rest lst)))
    )
  )
)

(membro? 'a '(a b c))
;-> true

(membro? 'a '((a) b c))
;-> nil

(membro? '() '(a b c))
;-> nil

(membro? '() '(a b c ()))
;-> true

(membro? '(a) '((a) b c))
;-> true

(membro? '(c d) '((a) b c (c d)))
;-> true

(membro? '(c d) '((a) b c ((c d))))
;-> nil

(membro? 'a 'a)
;-> ERR: array, list or string expected in function first : lst
;-> called from user function (membro? 'a 'a)

La funzione "membro?" controlla se una lista contiene uno specifico atomo/lista:
in questo caso restituisce true, altrimenti restituisce nil.
Non controlla se lo specifico atomo/lista è annidato nella lista.

Come funziona ?

((null? lst) nil)
Se lst è la lista vuota, allora il risultato è nil.
Altrimenti esegue la condizione successiva.

(true (or (= (first lst) atm) (membro? atm (rest lst))))
Se l'atomo è uguale al primo elemento della lista: (= (first lst) atm)
oppure: or
se l'atomo è membro del resto della lista: (membro? atm (rest lst))
allora restituisce true.

LA RICORSIONE
Una funzione è detta ricorsiva se chiama se stessa.
Se due funzioni si chiamano l’un l’altra, sono dette mutuamente ricorsive.
La funzione ricorsiva risolve direttamente solo casi particolari di un problema, detti casi di base.
Se viene chiamata con dei dati che costituiscono uno dei casi di base,
allora restituisce un risultato.
Se invece viene chiamata con dei dati che NON costituiscono uno dei casi di base,
allora chiama se stessa (passo ricorsivo) passando dei DATI semplificati/ridotti.
Ad ogni chiamata si semplificano/riducono i dati, in modo di arrivare ad uno dei casi di base.
Quando la funzione chiama se stessa, sospende la sua esecuzione per eseguire la nuova chiamata.
L’esecuzione riprende quando la chiamata interna a se stessa termina.
La sequenza di chiamate ricorsive termina quando quella più interna (annidata) incontra uno dei casi di base.
Il risultato della funzione viene quindi calcolato ricostruendo all'indietro la sequenza delle chiamate.

RICORSIONE IN CODA (TAIL RECURSION)
La ricorsione di coda si ha quando la chiamata ricorsiva è l'ultima istruzione eseguita nella funzione.
La ricorsione di coda può essere trasformata in una versione iterativa.

Che cosa fa la seguente funzione "cancella" ?

(define (cancella atm lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) atm) (rest lst))
            (true (cancella atm (rest lst)))
          )
    )
  )
)

(cancella 'a '(a b c))
;-> (b c)

(cancella 'a '(a b c a))
;-> (b c a)

(cancella 'a '(b c d))
;-> ()

Non funziona come vorremmo !!!

La funzione "cancella" elimina da una lista la prima occorrenza di uno specifico atomo/lista.
Restituisce una lista priva dello specifico atomo/lista.

==============================================================
SECONDO COMANDAMENTO
Utilizzare sempre cons per costruire nuove liste.
==============================================================

(define (cancella atm lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) atm) (rest lst))
            (true (cons (first lst) (cancella atm (rest lst))))
          )
    )
  )
)

(cancella 'a '(a b c a))
;-> (b c a)

(cancella 'a '(b c d))
;-> (b c d)

(cancella 'a '(b c a d))
;-> (b c d)

(cancella 'a '(b c d a))
;-> (b c d)

Come funziona ?

((null? lst) nil)
Se lst è la lista vuota, allora restituisce la lista vuota.
Altrimenti esegue la condizione successiva.

((= (first lst) atm) (rest lst))
Se l'atomo è uguale al primo elemento della lista: (= (first lst) atm),
allora restituisce il resto della lista (senza ulteriori cancellazioni)
oppure:
unisce l'elemento corrente con il risultato della funzione "cancella" sul resto della lista.

Semplifichiamo la funzione "cancella":

(define (cancella atm lst)
  (cond
    ((null? lst) '())
    ((= (first lst) atm) (rest lst))
    (true (cons (first lst) (cancella atm (rest lst))))
  )
)

Cosa fa la funzione "cancella-tutti" ?

(define (cancella-tutti atm lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) atm) (cancella-tutti atm (rest lst)))
            (true (cons (first lst) (cancella-tutti atm (rest lst))))
          )
    )
  )
)

Semplifichiamo la funzione "cancella-tutti":

(define (cancella-tutti atm lst)
  (cond
    ((null? lst) '())
    ((= (first lst) atm) (cancella-tutti atm (rest lst)))
    (true (cons (first lst) (cancella-tutti atm (rest lst))))
  )
)

(cancella-tutti 'a '(a b c a))
;-> (b c)

(cancella-tutti 'a '(b c d))
;-> (b c d)

(cancella-tutti 'a '(b c a d))
;-> (b c d)

(cancella-tutti 'a '(a a a a))
;-> ()

Come funziona ?
((null? lst) nil)
Se lst è la lista vuota, allora restituisce la lista vuota.
Altrimenti esegue la condizione successiva.

((= (first lst) atm) (cancella-tutti atm (rest lst)))
Se l'atomo è uguale al primo elemento della lista: (= (first lst) atm),
allora applica la funzione "cancella-tutti" al resto della lista.
oppure:
unisce il primo elemento della lista con il risultato
della funzione "cancella-tutti" sul resto della lista.

Cosa fa la funzione "primi" ?

(primi '((a b c))) ;-> (a)
(primi '((a b) (c d) (e f))) ;-> (a c e)
(primi '(((dentro) fuori) (3 4) ((r) t))) ;-> ((dentro) 3 (r))

La funzione "primi" prende come argomento una lista (vuota o con sottoliste non-vuote).
Crea un'altra lista con i primi elementi (s-expression) di ciascuna lista interna.

==============================================================
TERZO COMANDAMENTO
Quando si costruisce una lista, occorre descrivere il primo elemento tipico,
poi si applica "cons" su questo in maniera ricorsiva.
==============================================================

In questo caso il primo elemento tipico vale:
(first (first lst))

(define (primi lst)
  (cond
      ((null? lst) '())
      (true (cons (first (first lst)) (primi (rest lst))))
  )
)

(primi '((a b c)))
;-> (a)
(primi '((a b) (c d) (e f)))
;-> (a c e)
(primi '(((dentro) fuori) (3 4) ((r) t)))
;-> ((dentro) 3 (r))

Nota:

(primi '(a b c))
;-> ERR: array, list or string expected : (first lst)
;-> called from user function (primi '(a b c))

Scriviamo una funzione "primi2" che prende come argomento una lista di elementi 
e costruisce una lista con le seguenti regole:
1) se l'elemento della lista è la lista vuota, allora aggiungi la lista vuota
2) se l'elemento della lista è un atomo, allora aggiungi l'atomo
3) se l'elemento della lista è una sottolista, allora aggiungi il primo elemento della sottolista.

(define (primi2 lst)
  (if (null? lst) '()
    (let (L '())
      (dolist (x lst)
        (cond
            ((null? x) (push '() L))
            ((atom? x) (push x L))
            ((atom? (first x)) (push (first x) L))
            ((list? (first x)) (push (first x) L))
        )
      )
      (reverse L)
    )
  )
)  

(primi2 '(a b c))
;-> (a b c)

(primi2 '(((dentro) fuori) (3 4) ((r) t)))
;-> ((dentro) 3 (r))

(primi2 '((a b c) () b))
;-> (a () b)

Nota: Alle volte uno stile imperativo è più semplice e/o efficiente.

