(load "_newlisper.lsp")

 +======================+
 | The little newLISPER |
 +======================+

Appunti in newLISP del libro "The Little Schemer" di Friedman e Felleisen

Dalla Prefazione del libro:

"The goal of this book is to teach the reader to think recursively"

"...writing programs recursively in Scheme is essentially simple patttern recognition."

"The Little Schemer will not introduce you to the practical world of programming, but a mastery of concepts in the book provide a start toward understanding the nature of computation."

Nota: newLISP non è uguale a Scheme e quindi ha uno stile/metodo diverso, ma alcune tecniche di programmazione sono comunque utili da conoscere. Il codice del libro è stato adattato per funzionare con newLISP.

----------------------
Coppie puntate e liste
----------------------

In LISP o Scheme, una coppia (a volte chiamata una coppia puntata) è una struttura di dati con due campi chiamati campi "car" e "cdr" (per motivi storici). Le coppie sono create dalla funzione "cons". In LISP i campi "car" e "cdr" sono accessibili dalle procedure "car" e "cdr" (oppure "first" e "rest").

Le coppie vengono utilizzate principalmente per rappresentare le liste. Una lista può essere definito in modo ricorsivo come una lista vuota o una coppia il cui "cdr" è un'altra lista. Più precisamente, l'insieme delle liste è definito come l'insieme X più piccolo in modo tale:

- La lista vuota appartiene a X.
- Se una lista appartiene a X, allora qualunque coppia il cui "cdr" contiene la lista appartiene a X

Se list è in X, anche qualsiasi coppia il cui campo "cdr" contiene list è anche in X.
Gli oggetti nei campi "car" delle coppie successive di una lista sono gli elementi della lista. Ad esempio, una lista di due elementi è una coppia la cui "car" è il primo elemento e il cui "cdr" è una coppia il cui "car" è il secondo elemento e il cui "cdr" è la lista vuota. La lunghezza di una lista è data dal numero di elementi, che è lo stesso del numero di coppie. L'elenco vuoto è un oggetto speciale del suo tipo (non è una coppia), non ha elementi e la sua lunghezza è zero.
La precedente definizione implica che tutte le liste hanno lunghezza finita e terminano con la lista vuota.

La notazione più generale (rappresentazione esterna) per le coppie è la notazione “puntata” (c1. C2) dove c1 è il valore del campo "car" e c2 è il valore del campo "cdr". Ad esempio, (4 . 5) è una coppia il cui "car" è 4 e il cui "cdr" è 5. Nota che (4 . 5) è la rappresentazione esterna di una coppia, non un'espressione che valuta ad una coppia.

Una notazione più snella può essere usata per le liste: gli elementi della lista sono semplicemente racchiusi tra parentesi e separati da spazi. La lista vuota è scritta (). Ad esempio, le seguenti sono notazioni equivalenti per una lista di simboli:

(a b c d e)

(a. (b. (c. (d. (e. ())))))

Una catena di coppie che non termina con la lista vuota viene chiamata lista impropria. Si noti che una lista impropria non è una lista. La lista e la notazione puntata possono essere combinati per rappresentare liste improprie, come mostrano le seguenti notazioni equivalenti:

(a b c. d)

(a. (b. (c. d)))

In newLISP non esistono coppie puntate e le liste sono rappresentate internamente come linked list.

In Common Lisp e Scheme, la parte cdr (rest) della cella Lisp può essere utilizzata per contenere un altro oggetto LISP, nel qual caso abbiamo una coppia puntata. In newLISP, non ci sono coppie puntate. Invece, ciascuna cella di newLISP contiene un oggetto e un puntatore ad un altro oggetto se la cella fa parte di una lista. Come risultato in newLISP la funzione "cons" si comporta diversamente dagli altri LISP.

Common Lisp e Scheme
(cons 'a' b) => (a . b)  ;una coppia puntata
[a | b]

newLISP
(cons 'a' b) => (a b)   ;una lista
[ ]
 \
 [a] -> [b]

La cella LISP in in newLISP
(+ 2 3 (* 4 3))
[ ]
 \
 [+] -> [2] -> [3] -> [ ]
                       \
                       [*] -> [4] -> [3]

------------------------
Operatori di uguaglianza
------------------------
In newLISP esiste un solo operatore di uguaglianza per numeri, atomi, liste, S-espressioni che è "=".
Quosto operatore sostituisce tutti gli operatori definiti:
"eq?", "o=", "eqan?", "equal?", "eqlist?" "eqset?"

-----------
Definizioni
-----------

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


********************
* CAPITOLO 1: Toys *
********************

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


***********************************************************
* CAPITOLO 2: Do It, Do It Again, And Again, And Again... *
***********************************************************

Che cosa fa la seguente funzione "lat?" ?
("lat" significa "List Atom", cioè una lista di atomi)

(define (lat? lst)
  (cond
    ((null? lst) true)
    ((atom? (first lst)) (lat? (rest lst)))
    (true nil)))

(lat? '(a b c))
;-> true
(lat? '((a) b))
;-> nil
(lat? '())
;-> true
(lat? 'nil)
;-> true
(lat? '(a b nil))
;-> true
(lat? 'true)
;-> ERR: array, list or string expected in function first : lst
;-> called from user function (lat? 'a)
(lat? 'a)
;-> ERR: array, list or string expected in function first : lst
;-> called from user function (lat? 'a)

La funzione "lat?" controlla se una lista contiene solo atomi:
in questo caso restituisce true, altrimenti restituisce nil.

Come funziona ?

(define (lat? lst)
Definisce una funzione "lat?" con un solo argomento "lst".

(cond
Controlla l'esecuzione delle tre condizioni che seguono:
  ((null? lst) true)
  ((atom? (first lst)) (lat? (rest lst)))
  (true nil)))

((null? lst) true)
Se lst è la lista vuota, allora il risultato è true.
Altrimenti esegue la condizione successiva.

((atom? (first lst)) (lat? (rest lst)))
Se (first lst) è un atomo, allora chiama "lat?" con parametro (rest lst).
Altrimenti esegue la condizione successiva.

(true nil)))
Se le due condizioni precedenti sono false, allora il risultato è nil.
Questa condizione può essere interpretata come un 'else':
se le precedenti condizioni sono tutte false, allora esegui 'else'
(poichè 'true' è sempre vero).

==============================================================
PRIMO COMANDAMENTO (preliminare)

Utilizzare sempre null? come prima questione
quando si definisce qualunque funzione.
==============================================================


************************************
* CAPITOLO 3: Cons The Magnificent *
************************************

Che cosa fa la seguente funzione "member?" ?

(define (member? atm lst)
  (cond
    ((null? lst) nil)
    (true (or (= (first lst) atm)
              (member? atm (rest lst))))))

(member? 'a '(a b c))
;-> true
(member? 'a '((a) b c))
;-> nil
(member? '() '(a b c))
;-> nil
(member? '() '(a b c ()))
;-> true
(member? '(a) '((a) b c))
;-> true
(member? '(c d) '((a) b c (c d)))
;-> true
(member? '(c d) '((a) b c ((c d))))
;-> nil
(member? 'a 'a)
;-> ERR: array, list or string expected in function first : lst
;-> called from user function (member? 'a 'a)

La funzione "member?" controlla se una lista contiene uno specifico atomo/lista:
in questo caso restituisce true, altrimenti restituisce nil.
Non controlla se lo specifico atomo/lista è annidato nella lista.

Come funziona ?

((null? lst) nil)
Se lst è la lista vuota, allora il risultato è nil.
Altrimenti esegue la condizione successiva.

(true (or (= (first lst) atm) (member? atm (rest lst))))
Se l'atomo è uguale al primo elemento della lista: (= (first lst) atm)
oppure: or
se l'atomo è membro del resto della lista: (member? atm (rest lst))
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

Che cosa fa la seguente funzione "rember" ?

(define (rember atm lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) atm) (rest lst))
            (true (rember atm (rest lst)))))))

(rember 'a '(a b c))
;-> (b c)
(rember 'a '(a b c a))
;-> (b c a)
(rember 'a '(b c d))
;-> ()

La funzione "rember" elimina da una lista la prima occorrenza di uno specifico atomo/lista.
Restituisce una lista priva dello specifico atomo/lista.

Non funziona come vorremmo, quindi vediamo come renderla corretta utilizzando la funzione "cons".

==============================================================
SECONDO COMANDAMENTO

Utilizzare sempre cons per costruire nuove liste.
==============================================================

(define (rember atm lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) atm) (rest lst))
            (true (cons (first lst) (rember atm (rest lst))))))))

(rember 'a '(a b c a))
;-> (b c a)
(rember 'a '(b c d))
;-> (b c d)
(rember 'a '(b c a d))
;-> (b c d)
(rember 'a '(b c d a))
;-> (b c d)

Come funziona ?

((null? lst) nil)
Se lst è la lista vuota, allora restituisce la lista vuota.
Altrimenti esegue la condizione successiva.

((= (first lst) atm) (rest lst))
Se l'atomo è uguale al primo elemento della lista: (= (first lst) atm),
allora restituisce il resto della lista (senza ulteriori remberzioni)
oppure:
unisce l'elemento corrente con il risultato della funzione "rember" sul resto della lista.

Semplifichiamo la funzione "rember":

(define (rember atm lst)
  (cond
    ((null? lst) '())
    ((= (first lst) atm) (rest lst))
    (true (cons (first lst) (rember atm (rest lst))))))

Cosa fa la funzione "firsts" ?

(firsts '((a b c))) ;-> (a)
(firsts '((a b) (c d) (e f))) ;-> (a c e)
(firsts '(((dentro) fuori) (3 4) ((r) t))) ;-> ((dentro) 3 (r))

La funzione "firsts" prende come argomento una lista (vuota o con sottoliste non-vuote).
Crea un'altra lista con i firsts elementi (s-expression) di ciascuna lista interna.

==============================================================
TERZO COMANDAMENTO

Quando si costruisce una lista, occorre descrivere il primo elemento tipico,
poi si applica "cons" su questo in maniera ricorsiva.
==============================================================

In questo caso il primo elemento tipico vale:
(first (first lst))

(define (firsts lst)
  (cond
      ((null? lst) '())
      (true (cons (first (first lst)) (firsts (rest lst))))))

(firsts '((a b c)))
;-> (a)
(firsts '((a b) (c d) (e f)))
;-> (a c e)
(firsts '(((dentro) fuori) (3 4) ((r) t)))
;-> ((dentro) 3 (r))

Nota:

(firsts '(a b c))
;-> ERR: array, list or string expected : (first lst)
;-> called from user function (firsts '(a b c))

Ricriviamo la funzione "firsts" che prende come argomento una lista di elementi
e costruisce una lista con le seguenti regole:
1) se l'elemento della lista è la lista vuota, allora aggiungi la lista vuota
2) se l'elemento della lista è un atomo, allora aggiungi l'atomo
3) se l'elemento della lista è una sottolista, allora aggiungi il primo elemento della sottolista.

(define (firsts lst)
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
      (reverse L))))

(firsts '(a b c))
;-> (a b c)
(firsts '(((dentro) fuori) (3 4) ((r) t)))
;-> ((dentro) 3 (r))
(firsts '((a b c) () b))
;-> (a () b)

Nota: Alle volte uno stile imperativo è più semplice e/o efficiente.

Cosa fa la funzione "insertR" ?

(insertR nuovo vecchio lst)
con nuovo = topping
vecchio = fudge
lst = (ice cream with fudge for dessert)

Restituisce: (ice cream with fudge topping for dessert)

Quindi la funzione prende tre argomenti, gli atomi "nuovo", "vecchio " e la lista "lst", poi inserisce il valore di "nuovo" dopo il valore di "vecchio" nella lista (solo la prima occorrenza). In altre parole, inserisce l'atomo di "nuovo" alla destra (Right) dell'atomo "vecchio".

(define (insertR nuovo vecchio lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) vecchio)
                (cons vecchio (cons nuovo (rest lst))))
            (true (cons (first lst) (insertR nuovo vecchio (rest lst))))))))

(insertR 'topping 'fudge '(ice cream with fudge for dessert))
;-> (ice cream with fudge topping for dessert))

Vediamo la funzione analoga "insertL" che inserisce l'atomo "nuovo" alla sinistra (Left) dell'atomo "vecchio":

(define (insertL nuovo vecchio lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) vecchio)
                (cons nuovo (cons vecchio (rest lst))))
            (true (cons (first lst) (insertL nuovo vecchio (rest lst))))))))

(insertL 'topping 'fudge '(ice cream with fudge for dessert))
;-> (ice cream with topping fudge for dessert)

Nota: L'espressione ((= (first lst) vecchio)
                     (cons nuovo (cons vecchio (rest lst)))),

è equivalente a: ((= (first lst) vecchio)
                  (cons nuovo lst)

poichè quando (= (first lst) vecchio ), allora risulta (= (cons (vecchio (rest lst))) lst).

Cosa fa la funzione "subst" ?

(subst nuovo vecchio lst)

con nuovo = topping
vecchio = fudge
lst = (ice cream with fudge for dessert)

Restituisce: (ice cream with topping for dessert)

Quindi la funzione prende tre argomenti, gli atomi "nuovo", "vecchio " e la lista "lst", poi sostituisce il valore di "vecchio" con il valore di "nuovo" nella lista (solo la prima occorrenza). In altre parole, aggiorna il valore di "vecchio" con il valore di "nuovo".

(define (subst nuovo vecchio lst)
    (cond
     ((null? lst) '())
     ((= (first lst) vecchio) (cons nuovo (rest lst)))
     (true (cons (first lst) (subst nuovo vecchio (rest lst))))))

(subst 'topping 'fudge '(ice cream with fudge for dessert))
;-> (ice cream with topping for dessert))
(subst 'a 'x '(x b c d x e))
;-> (a b c d x e))
(subst 'a 'x '())
;-> ()

Cosa fa la funzione "subst2"?

(subst2 nuovo vecchio1 vecchio2 lst)

con nuovo = vanilla
vecchio1 = chocolate
vacchio2 = banana
lst = (banana ice cream with chocolate topping)

Restituisce: (vanilla ice cream with chocolate topping)

Quindi la funzione modifica la prima occorrenza di "vecchio1" o di "vecchio2" con "nuovo".

(define (subst2 nuovo vecchio1 vecchio2 lst)
    (cond
      ((null? lst) '())
      ((or (= (first lst) vecchio1) (= (first lst) vecchio2))
       (cons nuovo (rest lst)))
      (true (cons (first lst) (subst2 nuovo vecchio1 vecchio2 (rest lst))))))

(subst2 'x 'a 'c '(a b c d e))
;-> (x b c d e)
(subst2 'x 'a 'c '(g b c d e))
;-> (g b x d e)

Cosa fa la funzione "multirember" ?

(multirember atm lst)

con atm = cup
lst = (coffee cup tea cup and hick cup)

Restituisce: (coffee tea and hick)

(define (multirember atm lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) atm) (multirember atm (rest lst)))
            (true (cons (first lst) (multirember atm (rest lst))))))))

Semplifichiamo la funzione "multirember":

(define (multirember atm lst)
  (cond
    ((null? lst) '())
    ((= (first lst) atm) (multirember atm (rest lst)))
    (true (cons (first lst) (multirember atm (rest lst))))
  )
)

(multirember 'cup '(coffee cup tea cup and hick cup))
;-> (coffee tea and hick)
(multirember 'a '(a b c a))
;-> (b c)
(multirember 'a '(b c d))
;-> (b c d)
(multirember 'a '(b c a d))
;-> (b c d)
(multirember 'a '(a a a a))
;-> ()
(multirember 'a '(1 a 2 a 3))
;-> (1 2 3)

Come funziona ?
((null? lst) nil)
Se lst è la lista vuota, allora restituisce la lista vuota.
Altrimenti esegue la condizione successiva.

((= (first lst) atm) (multirember atm (rest lst)))
Se l'atomo è uguale al primo elemento della lista: (= (first lst) atm),
allora applica la funzione "multirember" al resto della lista.
oppure:
unisce il primo elemento della lista con il risultato
della funzione "multirember" sul resto della lista.

Cosa fa la funzione "multiinsertR" ?

(multiinsertR: nuovo vecchio lst)

con nuovo = fried
vecchio = fish
lst = (chip and fish or ice and fish)

Retituisce: (chip and fish fried or ice and fish fried)

(define (multiinsertR nuovo vecchio lst)
    (cond
     ((null? lst) '())
     ((= (first lst) vecchio) (cons vecchio (cons nuovo (multiinsertR nuovo vecchio (rest lst)))))
     (true (cons (first lst) (multiinsertR nuovo vecchio (rest lst))))))

(multiinsertR 'fried 'fish '(chip and fish or ice and fish))
;-> (chip and fish fried or ice and fish fried)
(multiinsertR 'x 'c '(a b c d e c g h))
;-> (a b c x d e c x g h))
(multiinsertR 'x 'c '())
;-> ()
(multiinsertR 'x 'g '(a b c d c))
'(a b c d c))

Cosa fa la funzione "multiinsertL" ?

(multiinsertL: nuovo vecchio lst)

con nuovo = fried
vecchio = fish
lst = (chip and fish or ice and fish)

Retituisce: (chip and fried fish or ice and fried fish)

(define (multiinsertL nuovo vecchio lst)
    (cond
     ((null? lst) '())
     ((= (first lst) vecchio) (cons nuovo (cons vecchio (multiinsertL nuovo vecchio (rest lst)))))
     (true (cons (first lst) (multiinsertL nuovo vecchio (rest lst))))))

(multiinsertL 'fried 'fish '(chip and fish or ice and fish))
;-> (chip and fried fish or ice and fried fish)
(multiinsertL 'x 'c '(a b c d e c g h))
;-> (a b x c d e x c g h))
(multiinsertL 'x 'c '())
;-> ()
(multiinsertL 'x 'g '(a b c d c))
;-> (a b c d c))

==============================================================
QUARTO COMANDAMENTO (preliminare)

Cambiare sempre almeno un argomento durante la ricorsione.
Questo deve essere modificato per avvicinarsi alla soluzione.
L'argomento che viene modificato deve essere verificato nella condizione di terminazione:
quando si utilizza "rest", testare la terminazione con "null?".
==============================================================

Cosa fa la funzione "multisubst" ?

(multisubst: nuovo vecchio lst)

con nuovo = fried
vecchio = fish
lst = (chip and fish or ice and fish)

Restituisce: lst = (chip and fried or ice and fried)
Restituisce una lista con tutte le occorrenze di "vecchio" sostituite con "nuovo".

(define (multisubst nuovo vecchio lst)
    (cond
     ((null? lst) '())
     ((= (first lst) vecchio) (cons nuovo (multisubst nuovo vecchio (rest lst))))
     (true (cons (first lst) (multisubst nuovo vecchio (rest lst))))))

(multisubst 'fried 'fish '(chip and fish or ice and fish))
;-> (chip and fried or ice and fried)
(multisubst 'x 'c '(a b c d e c f g))
;-> (a b x d e x f g))
(multisubst 'x 'c '(c b c d e c f c))
;-> (x b x d e x f x))
(multisubst 'x 'c '())
;-> ())
(multisubst 'x 'c '(a b d e))
;-> (a b d e)


*****************************
* CAPITOLO 4: Numbers Games *
*****************************

Definiamo la funzione "add1":

(define (add1 n) (++ n))

(add1 67)
;-> 68
(add1 0)
;-> 1
(add1 -4)
;-> -3

Definiamo la funzione "sub1":

(define (sub1 n) (-- n))

(sub1 10)
;-> 9
(sub1 -4)
;-> -5

Definiamo la funzione che somma due numeri "o+":

(define (o+ n m)
    (cond
     ((zero? m) n)
     (true (add1 (o+ n (sub1 m))))))

(o+ 2 7)
;-> 9
(o+ 2 0)
;-> 2

Definiamo la funzione che sottrae due numeri "o-":

(define (o- n m)
    (cond
     ((zero? m) n)
     (true (sub1 (o- n (sub1 m))))))

(o- 5 2)
;-> 3
(o- 2 5)
;-> -3

Definiamo una "tupla" come una lista di numeri.

==============================================================
PRIMO COMANDAMENTO (prima revisione)

Quando usiamo la ricorsione su una lista di atomi, lst, occorrono due questioni (null? lst) e true (else).
Quando usiamo la ricorsione su un numero, n, occorrono due questioni (zero? n) e true (else).
==============================================================

Definiamo la funzione che somma tutti i numeri di una tupla "addtup":

(define (addtup tup)
    (cond
     ((null? tup) 0)
     (true (o+ (first tup) (addtup (rest tup))))))

(addtup '(3 5 2 8))
;-> 18
(addtup '(15 6 7 12 3))
;-> 43
(addtup '())
;-> 0

==============================================================
QUARTO COMANDAMENTO (prima revisione)

Cambiare sempre almeno un argomento durante la ricorsione.
Questo deve essere modificato per avvicinarsi alla soluzione.
L'argomento che viene modificato deve essere verificato nella condizione di terminazione:
quando si utilizza "rest", testare la terminazione con "null?".
quando si utilizza "sub1", testare la terminazione con "zero?".
==============================================================

Definiamo la funzione che moltiplica due numeri "o*":

(define (o* n m)
    (cond
     ((zero? m) 0)
     (true (o+ n (o* n (sub1 m))))))

(o* 12 3)
;-> 36
(o* 12 0)
;-> 0
(o* 0 3)
;-> 0

==============================================================
QUINTO COMANDAMENTO

Quando si crea un valore con "o+", utilizzare sempre 0 come valore della riga terminale, poichè l'aggiunta di 0 non cambia il valore di una addizione.
Quando si crea un valore con "o*", utilizzare sempre 1 come valore della riga terminale, poichè moltiplicare per 1 non cambia il valore di una moltiplicazione.
Quando si crea un valore con "cons", utilizzare sempre () come valore della riga terminale.
==============================================================

Cosa fa la funzione "tup+" ?

(tup+ tup1 tup2)
con tup1 = (2 3)
tup2 = (4 6)

Restituisce: tup = (6 9)
Restituisce una tupla con le somme degli elementi corrispondenti di tup 1 e tup2 (che devono avere la stessa lunghezza).

(define (tup+ tup1 tup2)
    (cond
     ((and (null? tup1) (null? tup2)) '())
     (true (cons (o+ (first tup1) (first tup2))
             (tup+ (rest tup1) (rest tup2))))))

(tup+ '(3 6 9 11 4) '(8 5 2 0 7))
;-> (11 11 11 11 11)

Tuple di lunghezza diversa generano un errore:

(tup+ '(3 6 9 11 4) '(8 5 2))
;-> ERR: list is empty in function first : tup2
(tup+ '(3 6 9) '(8 5 2 0 7))
;-> ERR: list is empty in function first : tup1
(tup+ '() '())
;-> ()

Scriviamo una funzione che funziona per tuple di qualunque lunghezza "tup+":

(define (tup+ tup1 tup2)
    (cond
     ((and (null? tup1) (null? tup2)) '())
     ((null? tup1) tup2)
     ((null? tup2) tup1)
     (true (cons (o+ (first tup1) (first tup2))
             (tup+ (rest tup1) (rest tup2))))))

Versione migliorata di "tup+":

(define (tup+ tup1 tup2)
    (cond
     ((null? tup1) tup2)
     ((null? tup2) tup1)
     (true (cons (o+ (first tup1) (first tup2))
             (tup+ (rest tup1) (rest tup2))))))

(tup+ '(3 6 9 11 4) '(8 5 2 0 7))
;-> (11 11 11 11 11))
(tup+ '(3 6 9 11 4) '(8 5 2))
;->  (11 11 11 11 4))
(tup+ '(3 6 9) '(8 5 2 0 7))
;-> (11 11 11 0 7))
(tup+ '(3 6 9 11 4) '())
;-> (3 6 9 11 4))
(tup+ '() '(8 5 2 0 7))
;-> (8 5 2 0 7)
(tup+ '() '())
;-> ()

Scriviamo una funzione di comparazione tra numeri "o>"

(define (o> n m)
    (cond
     ((zero? n) nil)
     ((zero? m) true)
     (true (o> (sub1 n) (sub1 m)))))

(o> 4 2)
;-> true
(o> 2 4)
;-> nil
(o> 3 3)
;-> nil

Scriviamo una funzione di comparazione tra numeri "o<":

(define (o< n m)
    (cond
     ((zero? m) nil)
     ((zero? n) true)
     (true (o< (sub1 n) (sub1 m)))))

(o< 2 4)
;-> true
(o< 4 2)
;-> nil
(o< 2 2)
;-> nil

Scriviamo una funzione di comparazione tra numeri "o=":

(define (o= n m)
    (cond
     ((zero? n) (zero? m))
     ((zero? n) nil)
     (true (o= (sub1 n) (sub1 m)))))

(o= 1 1)
;-> true
(o= 1 2)
;-> nil
(o= 2 1)
;-> nil

Versione equivalente di "o=":

(define (o= n m)
    (cond
     ((o> n m) nil)
     ((o< n m) nil)
     (else true)))

(o= 1 1)
;-> true
(o= 1 2)
;-> nil
(o= 2 1)
;-> nil

Scriviamo una funzione potenza di due numeri "oexpt":

(define (oexpt n m)
    (cond
     ((zero? m) 1)
     (true (o* n (oexpt n (sub1 m))))))

(oexpt 1 1)
;-> 1
(oexpt 2 3)
;-> 8
(oexpt 5 3)
;-> 125
(oexpt 5 0)
;-> 1
(oexpt 0 2)
;-> 0

Scriviamo una funzione divisione intera tra due numeri "oquotient":

(define (oquotient n m)
    (cond
     ((o< n m) 0)
     (true (add1 (oquotient (o- n m) m)))))

(oquotient 15 4)
;-> 3
(oquotient 1 1)
;-> 1
(oquotient 4 15)
;-> 0

Scriviamo una funzione che calcola la lunghezza di una lista "length-":

(define (length- lst)
    (cond
     ((null? lst) 0)
     (true (add1 (length- (rest lst))))))

(length- '(a b c))
;-> 3
(length- '())
;-> 0
(length- '(a))
;-> 1
(length- '(a (b c) (d)))
;-> 3

Scriviamo una funzione che seleziona l'n-esimo elemento di una lista "pick":
(Il primo indice della lista vale 1)

(define (pick n lst)
    (cond
     ((zero? (sub1 n)) (first lst))
     (true (pick (sub1 n) (rest lst)))))

(pick 4 '(lasagne spaghetti ravioli macaroni meatball))
;-> macaroni
(pick 5 '(lasagne spaghetti ravioli macaroni meatball))
;-> meatball)
(pick 0 '(lasagne spaghetti ravioli macaroni meatball))
;-> ERR: call or result stack overflow in function zero? : --
(pick 6 '(lasagne spaghetti ravioli macaroni meatball))
;-> ERR: list is empty in function first : lst

Scriviamo una funzione che elimina l'n-esimo elemento di una lista "pick":

(define (rempick n lst)
    (cond
     ((zero? (sub1 n)) (rest lst))
     (true (cons (first lst) (rempick (sub1 n) (rest lst))))))

(rempick 3 '(hotdogs with hot mustard))
;-> (hotdogs with mustard))
(rempick 0 '(hotdogs with hot mustard))
;-> ERR: list is empty in function first : lst
(rempick 5 '(hotdogs with hot mustard))
;-> (hotdogs with hot mustard)

Scriviamo una funzione che elimina tutti gli elementi di una lista che sono numeri "no-nums":

(define (no-nums lst)
    (cond
     ((null? lst) '())
     (true
      (cond
       ((number? (first lst)) (no-nums (rest lst)))
       (true (cons (first lst) (no-nums (rest lst))))))))

(no-nums '(5 pears 6 prunes 9 dates))
;-> (pears prunes dates)

Scriviamo una funzione che estrae tutti gli elementi di una lista che sono numeri "all-nums":
cioè trasforma una lista in una tupla)

(define (all-nums lst)
    (cond
     ((null? lst) '())
     ((number? (first lst)) (cons (first lst) (all-nums (rest lst))))
     (true (all-nums (rest lst)))))

(all-nums '(5 pears 6 prunes 9 dates))
;-> (5 6 9)

Scriviamo una funzione "eqan?" che ritorna "true" se due argomenti sono uguali:

Nota: la funzione "eqan?" riunisce le funzioni "o=" (che viene usata per i numeri) e la funzione "eq?" (che viene usata per gli atomi). In newLISP non esiste questa differenza perchè esiste una sola funzione per confrontare due argomenti "=".

(define (eqan? a1 a2)
    (cond
     ((and (number? a1) (number? a2)) (o= a1 a2))
     ((or (number? a1) (number? a2) nil))
     (true (= a1 a2))))

(eqan? 2 3)
;-> nil
(eqan? 2 2)
;-> true
(eqan? 'a 'a)
;-> true
(eqan? 'a 'b)
;-> nil

Scriviamo una funzione "occur" che ritorna il numero di volte che un atomo comapre in una lista:

(define (occur a lst)
    (cond
     ((null? lst) 0)
     ((= (first lst) a) (add1 (occur a (rest lst))))
     (true (occur a (rest lst)))))

(occur 'x '(a b c d e))
;-> 0
(occur 'x '(x b x d x))
;-> 3
(occur 'x '())
;-> 0

Scriviamo una funzione "one?" che verifica se un numero vale 1:

(define (one? n) (= n 1))

(one? 3)
;-> nil
(one? 0)
;-> nil
(one? 1)
;-> true

Utilizzando la funzione "uno?" possiamo riscrivere la funzione "rempick":

(define (rempick n lst)
    (cond
     ((one? n) (rest lst))
     (true (cons (first lst) (rempick (sub1 n) (rest lst))))))

(rempick 3 '(hotdogs with hot mustard))
;-> (hotdogs with mustard))
(rempick 0 '(hotdogs with hot mustard))
;-> ERR: list is empty in function first : lst
(rempick 5 '(hotdogs with hot mustard))
;-> (hotdogs with hot mustard)


************************************************
* CAPITOLO 5: *Oh My Gawd*: It's Full of Stars *
************************************************

Adesso scriviamo funzioni che hanno S-espressioni come argomenti.

Scriviamo una funzione "rember*" che rimuove un atomo da una S-espressione:

(define (rember* a S)
    (cond
     ((null? S) '())
     ((atom? (first S))
      (cond
       ((= (first S) a) (rember* a (rest S)))
       (true (cons (first S) (rember* a (rest S))))))
     (true (cons (rember* a (first S)) (rember* a (rest S))))))

(rember* 'cup '((coffee) cup ((tea) cup) (and (hick)) cup))
;-> ((coffee) ((tea)) (and (hick)))
(rember* 'sauce '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
;-> (((tomato)) ((bean)) (and ((flying))))
(rember* 'x '((a) (b (c))))
;-> '((a) (b (c))))

Nota: questa funzionem applica la ricorsione a first della lista e non soltanto al rest della lista.

Scriviamo la funzione "insertR*":

(define (insertR* nuovo vecchio S)
    (cond
     ((null? S) '())
     ((atom? (first S))
      (cond
       ((= (first S) vecchio) (cons vecchio (cons nuovo (insertR* nuovo vecchio (rest S)))))
       (true (cons (first S) (insertR* nuovo vecchio (rest S))))))
     (true (cons (insertR* nuovo vecchio (first S)) (insertR* nuovo vecchio (rest S))))))

(insertR* 'roast 'chuck '((how much (wood))
                          could
                          ((a (wood) chuck))
                          (((chuck)))
                          (if (a) (wood chuck))
                          could chuck wood))
;-> ((how much (wood)) could ((a (wood) chuck roast)) (((chuck roast)))
;->  (if (a) (wood chuck roast)) could chuck roast wood)

==============================================================
PRIMO COMANDAMENTO (versione finale)

Quando usiamo la ricorsione su una lista di atomi, lst, occorrono due questioni (null? lst) e true (else).
Quando usiamo la ricorsione su un numero, n, occorrono due questioni (zero? n) e true (else).
Quando usiamo la ricorsione su una lista di S-espressioni, S, occorrono tre questioni: (null? S), (atom? (first S) e true (else).
==============================================================

Tutte le funzioni "*" operano su liste che possono essere:
- liste vuote
- un atomo inserito ("consed") in una lista
- una lista inserita ("consed") in una lista

==============================================================
QUARTO COMANDAMENTO (versione finale)

Cambiare sempre almeno un argomento durante la ricorsione.
Quando usiamo la ricorsione su una lista di atomi, lst, usare (rest lst).
Quando usiamo la ricorsione su un numero, n, usare (sub1 n).
E quando usiamo la ricorsione su una lista di S-espressioni, S, usare (first S) e (rest S) se non sono veri (true) sia (null? S) che (atom? (first S)).
Questo deve essere modificato per avvicinarsi alla soluzione.
L'argomento che viene modificato deve essere verificato nella condizione di terminazione:
quando si utilizza "rest", testare la terminazione con "null?".
quando si utilizza "sub1", testare la terminazione con "zero?".
==============================================================

Scriviamo la funzione "occur*":

(define (occur* a S)
    (cond
     ((null? S) 0)
     ((atom? (first S))
      (cond
       ((= (first S) a) (add1 (occur* a (rest S))))
       (true (occur* a (rest S)))))
     (true (o+ (occur* a (first S)) (occur* a (rest S))))))

(occur* 'banana '((banana)
                  (split ((((banana ice)))
                          (cream (banana))
                          sherbet))
                  (banana)
                  (bread)
                  (banana brandy)))
;-> 5
(occur* 'x '(a (b (c d)) e))
;-> 0

Scriviamo la funzione "subst*":

(define (subst* nuovo vecchio S)
    (cond
     ((null? S) '())
     ((atom? (first S))
      (cond
       ((= (first S) vecchio) (cons nuovo (subst* nuovo vecchio (rest S))))
       (true (cons (first S) (subst* nuovo vecchio (rest S))))))
     (true (cons (subst* nuovo vecchio (first S)) (subst* nuovo vecchio (rest S))))))

(subst* 'orange 'banana '((banana)
                          (split ((((banana ice)))
                                  (cream (banana))
                                  sherbet))
                          (banana)
                          (bread)
                          (banana brandy)))
;-> ((orange)
;->  (split ((((orange ice)))
;->          (cream (orange))
;->          sherbet))
;->  (orange)
;->  (bread)
;->  (orange brandy)))

Scriviamo la funzione "insertL*":

(define (insertL* nuovo vecchio S)
    (cond
     ((null? S) '())
     ((atom? (first S))
      (cond
       ((= (first S) vecchio) (cons nuovo (cons vecchio (insertL* nuovo vecchio (rest S)))))
       (true (cons (first S) (insertL* nuovo vecchio (rest S))))))
     (true (cons (insertL* nuovo vecchio (first S)) (insertL* nuovo vecchio (rest S))))))

(insertL* 'pecker 'chuck '((how much (wood))
                           could
                           ((a (wood) chuck))
                           (((chuck)))
                           (if (a) (wood chuck))
                           could chuck wood))
;-> ((how much (wood))
;->  could
;->  ((a (wood) pecker chuck))
;->  (((pecker chuck)))
;->  (if (a) (wood pecker chuck))
;->  could pecker chuck wood))

Scriviamo la funzione "member*":

(define (member* a S)
    (cond
     ((null? S) nil)
     ((atom? (first S))
      (or (= (first S) a) (member* a (rest S))))
     (true (or (member* a (first S)) (member* a (rest S))))))

(member* 'chips '((potato) (chips ((with) fish) (chips))))
;-> true

Scriviamo la funzione "leftmost":

(define (leftmost S)
    (cond
     ((atom? S) S)
     (true (leftmost (first S)))))

(leftmost '((potato) (chips ((with) fish) (chips))))
;-> potato
(leftmost '(((hot) (tuna (and))) cheese))
;-> hot
(leftmost '(((() four)) 17 (seventeen)))))
;-> ERR: list is empty in function first : S

Scriviamo la funzione "eqan?":

(define (eqan? a1 a2)
    (cond
     ((and (number? a1) (number? a2)) (= a1 a2))
     ((or (number? a1) (number? a2) nil))
     (true (= a1 a2))))

(eqan? 2 3)
;-> nil
(eqan? 2 2)
;-> true
(eqan? 'a 'a)
;-> true
(eqan? 'a 'b)
;-> nil

Scriviamo la funzione "eqlist?":

(define (eqlist? S1 S2)
    (cond
     ((and (null? S1) (null? S2)) true)
     ((or (null? S1) (null? S2)) nil)
     ((and (atom? (first S1)) (atom? (first S2)))
      (and (eqan? (first S1) (first S2))
           (eqlist? (rest S1) (rest S2))))
     ((or (atom? (first S1)) (atom? (first S2))) nil)
     (true
      (and (eqlist? (first S1) (first S2))
           (eqlist? (rest S1) (rest S2))))))

(eqlist? '(strawberry ice cream) '(strawberry ice cream))
;-> true
(eqlist? '(strawberry ice cream) '(strawberry cream ice))
;-> nil
(eqlist? '(banana ((split))) '((banana) (split)))
;-> nil
(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda))))
;-> nil
(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda))))
;-> true

Scriviamo la funzione "equal?":

(define (equal? s1 s2)
    (cond
     ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
     ((or (atom? s1) (atom? s2)) nil)
     (true (eqlist? s1 s2))))

(equal? 'a 'a)
;-> true
(equal? 'a 'b)
;-> nil
(equal? '(a b) '(a b))
;-> true
(equal? '(a b) '(a c))
;-> nil
(equal? '(a b) 'a)
;-> nil

Riscriviamo la funzione "eqlist?":

(define (eqlist? lst1 lst2)
    (cond
     ((and (null? lst1) (null? lst2)) true)
     ((or (null? lst1) (null? lst2)) nil)
     (true
      (and (equal? (first lst1) (first lst2))
           (eqlist? (rest lst1) (rest lst2))))))

(eqlist? '(strawberry ice cream) '(strawberry ice cream))
;-> true
(eqlist? '(strawberry ice cream) '(strawberry cream ice))
;-> nil
(eqlist? '(banana ((split))) '((banana) (split)))
;-> nil
(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda))))
;-> nil
(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda))))
;-> true

==============================================================
SESTO COMANDAMENTO

Semplificare soltanto dopo che la funzione è corretta
==============================================================

Scriviamo la funzione "rember":

(define (rember S lst)
    (cond
     ((null? lst) '())
     ((= (first lst) S) (rest lst))
     (true
      (cons (first lst)
        (rember S (rest lst))))))

(rember 'a '(a b c))
;-> (b c)
(rember 'a '(b a c))
;-> (b c)
(rember 'a '(c b a))
;-> (c b))
(rember 'a '(a b a))
;-> (b a)
(rember 'a '(x y z))
;-> (x y z)
(rember 'a '(b (a) c))
;-> (b (a) c))
(rember 'a '(1 2 3 a 4))
;-> (1 2 3 4)
(rember 'a '())
;-> ()
(rember 'mint '(lamb chops and mint jelly))
;-> (lamb chops and jelly))
(rember 'mint '(lamb chops and mint flavored mint jelly))
;-> (lamb chops and flavored mint jelly))
(rember 'toast '(bacon lettuce and tomato))
;-> (bacon lettuce and tomato))
(rember 'cup '(coffee cup tea cup and hick cup))
;-> ;-> (coffee tea cup and hick cup))
(rember 'bacon '(bacon lettuce and tomato))
;-> (lettuce and tomato))
(rember 'and '(bacon lettuce and tomato))
;-> (bacon lettuce tomato))


***********************
* CAPITOLO 6: Shadows *
***********************

Scriviamo la funzione "numbered?":
È una funzione che determina se un'espressione aritmetica contiene solo numeri oltre a somme (+), moltiplicazioni (*) e potenze (^).

(define (numbered? aexp)
    (cond
     ((atom? aexp) (number? aexp))
     (true
      (and (numbered? (first aexp))
           (numbered? (first (rest (rest aexp))))))))

(numbered? 1)
;-> true
(numbered? '(3 + (4 oexpt 5)))
;-> true
(numbered? '(2 o* sausage))
;-> nil

==============================================================
SETTIMO COMANDAMENTO

Applicare la ricorsione sulle sotto-parti che sono della stessa natura:
- sulla sotto-lista di una lista
- sulla sotto-espressione di una espressione aritmetica
==============================================================

Scriviamo la funzione "value":
È una funzione che ritorna il valore di una espressione aritmetica numerica (numbered?).

(define (value nexp)
    (cond
     ((atom? nexp) nexp)
     ((= (first (rest nexp)) 'o+)
      (o+ (value (first nexp))
          (value (first (rest (rest nexp))))))
     ((= (first (rest nexp)) 'o*)
      (o* (value (first nexp))
          (value (first (rest (rest nexp))))))
     (true
      (oexpt (value (first nexp))
             (value (first (rest (rest nexp))))))))

(value '(1 o+ 3))
;-> 4
(value '(1 o+ (3 oexpt 4)))
;-> 82

Scriviamo un'altra funzione "value" che opera sulle seguenti espressioni aritmetiche:
- un numero oppure
- una lista con l'atomo + seguito da due espressioni aritmetiche oppure
- una lista con l'atomo * seguito da due espressioni aritmetiche oppure
- una lista con l'atomo ^ seguito da due espressioni aritmetiche

Abbiamo bisogno di alcune funzioni di supporto:

(define (first-sub-exp aexp)
    (first (rest aexp)))

(first-sub-exp '(o+ 1 3))
;-> 1

(define (second-sub-exp aexp)
    (first (rest (rest aexp))))

(second-sub-exp '(1 o+ 3))
;-> 3
(second-sub-exp '(o+ 1 3))
;-> 3

(define (operator aexp)
    (first aexp))

(operator '(o+ 1 3))
;-> o+

(define (value nexp)
    (cond
     ((atom? nexp) nexp)
     ((= (operator nexp) 'o+)
      (o+ (value (first-sub-exp nexp))
          (value (second-sub-exp nexp))))
     ((= (operator nexp) 'o*)
      (o* (value (first-sub-exp nexp))
          (value (second-sub-exp nexp))))
     (true
      (oexpt (value (first-sub-exp nexp))
             (value (second-sub-exp nexp))))))

(value '(o+ 1 3))
;-> 4
(value '(o+ 1 (oexpt 3  4)))
;-> 82

Questa versione di "value" funziona con il precedente tipo di dati astratto [aexp] se cambiamo la definizione delle seguenti funzione:

(define (first-sub-exp aexp)
    (first aexp))

(first-sub-exp '(2 op+ 5))
;-> 2

(define (operator aexp)
    (first (rest aexp)))

(operator '(1 o+ 3))
;-> o+
(operator '(1 o* 3))
;-> o*

==============================================================
OTTAVO COMANDAMENTO

Usare le funzioni di aiuto per astrarre dalla rappresentazione
==============================================================

Adeso usiamo un'altra rappresentazione per i numeri:

1 -> (())
2 -> (() ())
3 -> (() () ())

Le funzioni necessarie per trattare i numeri sono:
"number?", "zero?", "sub1" e "add1".

Riscriviamo queste funzioni adattandole alla nostra nuova rappresentazione dei numeri:

(define (sero? n) (null? n))

(sero? '())
;-> true
(sero? '(()))
;-> nil

(define (edd1 n)  (cons '() n))

(edd1 '())
;-> (())
(edd1 '(()))
;-> (() ())

(define (zub1 n) (rest n))

(zub1 '(()))
;-> '()
(zub1 '(() ()))
;-> '(())

(define (o+ n m)
    (cond
     ((sero? m) n)
     (true (edd1 (o+ n (zub1 m))))))

(o+ '(()()) '(()()()))
;-> (() () () () ())
(o+ '(() ()) '(() ()))
;->  (() () () ())

(define (lat? lst)
  (cond
    ((null? lst) true)
    ((atom? (first lst)) (lat? (rest lst)))
    (true nil)))

(lat? '(1 2 3))
;-> true
(lat? '(() (() ()) (() () ())))
;-> nil

Occorre fare attenzione alle ombre (shadows).


*************************************
* CAPITOLO 7: Friends and Relations *
*************************************

Un "set" (insieme) è una lista di atomi univoci (non sono ripetuti nella lista).
La lista vuota '() è un "set".

Un "l-set" è:
- ()
- (cons [set] [l-set])

Una "pair" (coppia) è:
- (cons [s-exp] [s-exp])

Una "rel" (relazione) è:
- [set di pair]

Una funzione "fun" è:
- [set di pair] dove (firsts rel) è un [set]

Una funzione "fullfun" è:
- [set di pair] dove (seconds rel) è un [set]

Vediamo quali funzioni precedenti ci servono:

Funzione "firsts"

(define (firsts l)
    (cond
     ((null? l) '())
     (true (cons (first (first l))
             (firsts (rest l))))))

(firsts '((a 1) (b 2)))
;-> (a b))
(firsts '(((f) a) ((g) b)))
;-> ((f) (g)))
(firsts '((a) (b)))
;-> (a b)
(firsts '())
;-> ()
(firsts '((a b) (c) (d)))
;-> (a c d)
(firsts '(((a b) c) (d e f) ((g) h)))
;-> ((a b) d (g))
(firsts '((apple peach pumpkin)
          (plum pear cherry)
          (grape raisin pea)
          (bean carrot eggplant)))
;-> (apple plum grape bean))
(firsts '((a b) (c d) (e f)))
;-> (a c e)
(firsts '((five plums)
          (four)
          (eleven green organges)))
;-> (five four eleven)
(firsts '(((five plums) four)
          (eleven green organges)
          ((no) more)))
;-> five plums) eleven (no)))

Funzione "member?"

(define (member? a lat)
    (cond
     ((null? lat) nil)
     (true (or (= (first lat) a)
               (member? a (rest lat))))))

(member? 'x '(a b c))
;-> nil
(member? 'x '(a x c))
;-> true
(member? 'x '(x b c))
;-> true
(member? 'x '(a b x))
;-> true
(member? '2 '(a 2 c))
;-> true
(member? 'b '(a (b) c))
;-> nil
(member? 'x '())
;-> nil

(define (multirember a lat)
    (cond
     ((null? lat) '())
     ((= (first lat) a) (multirember a (rest lat)))
     (true (cons (first lat) (multirember a (rest lat))))))

(multirember 'a '())
;-> ()
(multirember 'x '(x a b x c d x))
;-> (a b c d))
(multirember '(a b) '(x y (a b) z (a b)))
;-> (x y z))

Scriviamo la funzione "set?":

(define (set? lat)
    (cond
     ((null? lat) true)
     ((member? (first lat) (rest lat)) nil)
     (true (set? (rest lat)))))

(set? '(apple peaches apple plum))
;-> nil
(set? '(apple peaches pears plums))
;-> true
(set? '())
;-> true
(set? '(apple 3 pear 4 9 apple 3 4))
;-> nil
(set? '(apple banana apple))
;-> nil
(set? '(apple banana peaches banana))
;-> nil

Scriviamo la funzione "makeset?" con "member?":

(define (makeset lat)
    (cond
     ((null? lat) '())
     ((member? (first lat) (rest lat)) (makeset (rest lat)))
     (true (cons (first lat) (makeset (rest lat))))))

(makeset '(apple peach pear peach plum apple lemon peach))
;-> (pear plum apple lemon peach)
(makeset '(banana peach banana))
;-> (peach banana)
(makeset '(apple 3 pear 4 9 apple 3 4))
;-> (pear 9 apple 3 4)

Scriviamo la funzione "makeset?" con "multirember?":

(define (makeset lat)
    (cond
     ((null? lat) '())
     (true (cons (first lat)
             (makeset
              (multirember (first lat) (rest lat)))))))

(makeset '(apple peach pear peach plum apple lemon peach))
;-> (apple peach pear plum lemon))
(makeset '(banana peach banana))
;-> (banana peach))
(makeset '(apple 3 pear 4 9 apple 3 4))
;-> (apple 3 pear 4 9))

Scriviamo la funzione "subset?"

(define (subset? s1 s2)
    (cond
     ((null? s1) true)
     ((member? (first s1) s2) (subset? (rest s1) s2))
     (true nil)))

(subset? '(5 chicken wings) '(5 hamburgers 2 pieces fried chicken and light duckling wings))
;-> true
(subset? '(4 pounds of horseradish) '(four pounds chicken and 5 ounces horseradish))
nil

Scriviamo la funzione "subset?" con la funzione "and":

(define (subset? s1 s2)
    (cond
     ((null? s1) true)
     (true
      (and (member? (first s1) s2) (subset? (rest s1) s2)))))

(subset? '(5 chicken wings) '(5 hamburgers 2 pieces fried chicken and light duckling wings))
;-> true
(subset? '(4 pounds of horseradish) '(four pounds chicken and 5 ounces horseradish))
;-> nil

Scriviamo la funzione "eqset?":
Due set, set1 e set2, sono uguali se set1 è un sottoinsieme di set2 e set2 è un sottoinsieme di set1.

(define (eqset? set1 set2)
    (and (subset? set1 set2) (subset? set2 set1)))

(eqset? '(6 large chickens with wings) '(6 chickens with large wings))
;-> true
(eqset? '(6 large chickens with wings) '(6 chickens with wings))
;-> nil

Scriviamo la funzione "intersect?":
Un'intersezione di due insiemi è un insieme i cui membri sono membri di entrambi i set.
"intersect?" restituisce true se 'set1' ha elementi che sono anche membri di 'set2'.

(define (intersect? set1 set2)
    (cond
     ((null? set1) nil)
     (true (or (member? (first set1) set2)
               (intersect? (rest set1) set2)))))

(intersect? '(stewed tomatoes and macaroni) '(macaroni and cheese))
;-> true
(intersect? '(a b c) '(x y z))
;-> nil
(intersect? '(a b c) '())
;-> nil
(intersect? '() '(a b c))
;-> nil
(intersect? '() '())
;-> nil

Scriviamo la funzione "intersects":

(define (intersects set1 set2)
    (cond
     ((null? set1) '())
     ((member? (first set1) set2)
      (cons (first set1) (intersects (rest set1) set2)))
     (true (intersects (rest set1) set2))))

(intersect '(stewed tomatoes and macaroni) '(macaroni and cheese))
;-> (and macaroni)
(intersect '(a b c) '())
;-> ()
(intersect '() '(x y z))
;-> ()
(intersect '() '(x y z))
;-> ()

Scriviamo la funzione "unions":

(define (unions set1 set2)
    (cond
     ((null? set1) set2)
     ((member? (first set1) set2) (unions (rest set1) set2))
     (true (cons (first set1) (unions (rest set1) set2)))))

(unions '(stewed tomatoes and macaroni casserole) '(macaroni and cheese))
;-> (stewed tomatoes casserole macaroni and cheese)

(unions '(a b c) '())
;-> (a b c)
(unions '() '(x y z))
;-> (x y z))
(unions '() '())
;-> ())

Scriviamo la funzione "differences":

(define (differences  set1 set2)
    (cond
     ((null? set1) '())
     ((member? (first set1) set2) (differences (rest set1) set2))
     (true (cons (first set1) (differences (rest set1) set2)))))

(difference '(a b c) '(b c))
;-> (a)
(difference '(a b c) '(a b c))
;-> ()
(difference '(a b c) '(d e))
;-> (a b c)

Scriviamo la funzione "intersectall":
Restituisce l'intersezione di tutti gli insiemi in 'l-set'. Invece di (null? L-set), testiamo (null? (rest l-set)) e restituiamo (first l-set) come valore perché (intersects '(a b c)' ()) restituisce '().

(define (intersectall l-set)
    (cond
     ((null? (rest l-set)) (first l-set))
     (true (intersect (first l-set) (intersectall (rest l-set))))))

(intersectall '((6 pears and)
                (3 peaches and 6 peppers)
                (8 pears and 6 plums)
                (and 6 prunes with some apples)))
;-> (6 and)
(intersectall '((6 pears and)
                (3 peaches and 6 peppers)
                ()
                (and 6 prunes with some apples)))
;-> ()

Una coppia (pair) è una lista che contiene due S-espressioni.

Scriviamo la funzione "pair?":

(define (a-pair? l)
    (cond
     ((atom? l) nil)
     ((null? l) nil)
     ((null? (rest l)) nil)
     ((null? (rest (rest l))) true)
     (true nil)))

(a-pair? '(pear pear))
;-> true
(a-pair? '(3 7))
;-> true
(a-pair? '((2) (pair)))
;-> true
(a-pair? '())
;-> nil
(a-pair? 'a)
;-> nil

Scriviamo la funzione "firstp" che estrae il primo elemento di una coppia (pair) o lista :

(define (firstp p) (first p))

(firstp '(a b))
;-> a

Scriviamo la funzione "secondp" che estrae il secondo elemento di una coppia (pair) o lista:

(define (secondp p) (first (rest p)))

(secondp '(a b))
;-> b

Scriviamo la funzione "build" che crea una coppia (pair) con due S-espressioni:

(define (build s1 s2) (cons s1 (cons s2 '())))

(build 'a 'b)
;-> (a b)

Scriviamo la funzione "thirdp" che estrae il terzo elemento di una lista:

(define (thirdp l) (first (rest (rest l))))

(thirdp '(a b c d e))
;-> c

Una relazione (rel) è una lista di coppie (list of pairs).

Una funzione finita (fun) è una lista di coppie in cui i primi elementi delle coppie sono univoci tra loro.

Scriviamo la funzione "fun?":

(define (fun? rel) (set? (firsts rel)))

(fun? '((8 3) (4 2) (7 6) (6 2) (3 4)))
;-> true
(fun? '((d 4) (b 0) (b 9) (e 5) (g 4)))
;-> nil

Scriviamo la funzione "revrel" che restituisce una relazione con tutti gli elementi delle coppie invertiti:

(define (revrel rel)
    (cond
     ((null? rel) '())
     (true (cons (build (secondp (first rel))
                        (firstp (first rel)))
             (revrel (rest rel))))))

(revrel '((8 a) (pumpkin pie) (got sick)))
;-> '((a 8) (pie pumpkin) (sick got)))
(revrel '((a 1) (b 2) (c 3)))
;-> ((1 a) (2 b) (3 c)))

Riscriviamo "revrel" senza le funzioni "build", "firstp" and "secondp":

(define (revrel rel)
    (cond
     ((null? rel) '())
     (true (cons (cons (first (rest (first rel)))
                   (cons (first (first rel)) '()))
             (revrel (rest rel))))))

(revrel '((8 a) (pumpkin pie) (got sick)))
;-> ((a 8) (pie pumpkin) (sick got)))
(revrel '((a 1) (b 2) (c 3)))
;-> ((1 a) (2 b) (3 c)))

Scriviamo la funzione "revpair" che inverte i due elementi di una coppia (pair):

(define (revpair p)
    (build (secondp p) (first p)))

(revpair '(a b))
;-> (b a)

Riscriviamo "revrel" con la funzione "revpair":

(define (revrel rel)
    (cond
     ((null? rel) '())
     (true (cons (revpair (first rel))
             (revrel (rest rel))))))

(revrel '((8 a) (pumpkin pie) (got sick)))
;-> ((a 8) (pie pumpkin) (sick got)))

(revrel '((a 1) (b 2) (c 3)))
;-> ((1 a) (2 b) (3 c)))

Scriviamo la funzione "seconds":

(define (seconds s)
    (cond
     ((null? s) '())
     (true (cons (first (rest (first s)))
             (seconds (rest s))))))

(seconds '((a 1) (b 2) (c 3)))
;-> (1 2 3))

Scriviamo la funzione "fullfun?" che restituisce true se una S-espressione formata da coppie ha tutti i secondi elementi delle coppie diversi:

(define (fullfun? fun)
    (set? (seconds fun)))

(fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4)))
;-> true
(fullfun? '((grape raisin) (plum prune) (stewed prune)))
;-> nil

;; one-to-one?: [rel] -> boolean
;; This is another implementation of fullfun?.
;; Page 122

Scriviamo la funzione "one-to-one?" che è analoga a "fullfun?":

(define (one-to-one? fun)
    (fun? (revrel fun)))

(fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4)))
;-> true
(fullfun? '((grape raisin) (plum prune) (stewed prune)))
;-> nil


***********************************
* CAPITOLO 8: Lambda the Ultimate *
***********************************

(define (rember-f test? a lst)
    (cond
     ((null? lst) '())
     (true (cond
            ((test? (first lst) a) (rest lst))
            (true (cons (first lst)
                    (rember-f test? a (rest lst))))))))

(rember-f = 5 '(6 5 2 3))
;-> (6 2 3)
(rember-f = 'jelly '(jelly beans are good))
;-> (beans are good))
(rember-f equal? '(pop corn) '(lemonade (pop corn) and (cake)))
;-> (lemonade and (cake)))

Cosa significa la seguente espressione?

(lambda (a) (lambda (x) (= x a)))

È una funzione che prende l'argomento "a" e restituisce la funzione:

(lambda (x) (= x a))

"Curry-ing" Haskell B. Curry (1900-1982).

Definiamo la funzione in newLISP:

(define (eq?-c a)
     (letex (a a) (lambda (x) (= x a))))

(setq k 'salad)
(eq?-c k)
;-> (lambda (x) (= x salad))
(eq?-c 'salad)
(setq eq?-salad (eq-c? 'salad))
(define (eq?-salad (eq-c? 'salad)))
eq?-salad
(eq?-salad 'salad)

(define (eq?-c a)
  (lambda (x) (= x a)))

(define eq?-c
  (lambda (a)
    (lambda (x)
      (= x a))))

(setq k 10)
(eq?-c k)

(setq eq?-10 (eq?-c k))

(eq?-10 10)
(eq?-10 20)

(setq salad "val")

(setq z salad)
z
(eq?-c z)
(eq?-c salad)
(setq eq?-salad (eq?-c salad))

(eq?-salad)
(eq?-salad salad)
;-> true
(eq?-salad tuna)

(define rember-f
  (lambda (test?)
    ;; [atom] [listof sexp] -> [listof sexp]
    (lambda (a l)
      (cond
       ((null? l) '())
       ((test? (first l) a) (rest l))
       (true (cons (first l) ((rember-f test?) a (rest l))))))))

(define (rember-f test?)
    (lambda (a l)
      (cond
       ((null? l) '())
       ((test? (first l) a) (rest l))
       (true (cons (first l) ((rember-f test?) a (rest l)))))))


(test "rember-f - 2.revision"
      ((rember-f =) 5 '(6 5 2 3))
      '(6 2 3))

(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) '())
        ((test? (car l) a) (cdr l))
        (else (cons (car l) ((rember-f test?) a (cdr l))))))))
;
((rember-f =) 'tuna '(shrimp salad and tuna salad))


(define (eq?-c a)
    (lambda (x)
      (= x a)))

(setq k 'salad)
k

(eq?-c k)

(define (eq?-salad ))
(setq eq?-salad (eq?-c 'salad))

(eq?-salad salad)
(eq?-salad pippo)


(test "eq?-c"
      ((eq?-c 'x) 'x) #t)

(test "eq?-c"
      ((eq?-c 'x) 'b) #f)

(define (eq?-c a)
    (lambda (x)
      (eq? x a)))

((eq?-c 'x) 'x)

(test "eq?-c"
      ((eq?-c 'x) 'x) #t)

(test "eq?-c"
      ((eq?-c 'x) 'b) #f)

;; eq?-salad: [atom] -> boolean
;; Page 128
(define (eq?-salad (eq?-c 'salad)))

(test "eq?-salad"
      (eq?-salad 'salad) #t)

(test "eq?-salad"
      (eq?-salad 'tuna) #f)


=====================================================


===========
 APPENDICE
===========

The Ten Commandments
====================

The First Commandment
---------------------
When recurring on a list of atoms, lat, ask two questions about it: (null? lat) and else.
When recurring on a number, n, ask two questions about it: (zero? n) and else.
When recurring on a list of S-expressions, l, ask three question about it: (null? l), (atom? (car l)), and else.


The Second Commandment
----------------------
Use cons to build lists.


The Third Commandment
---------------------
When building a list, describe the first typical element, and then cons it onto the natural recursion.


The Fourth Commandment
----------------------
Always change at least one argument while recurring.
When recurring on a list of atoms, lat, use (cdr lat).
When recurring on a number, n, use (sub1 n).
And when recurring on a list of S-expressions, l, use (car l) and (cdr l) if neither (null? l) nor (atom? (car l)) are true.
It must be changed to be closer to termination. The changing argument must be tested in the termination condition:
When using cdr, test termination with null?
When using sub1, test termination with zero?


The Fifth Commandment
---------------------
When building a value with +, always use 0 for the value of the terminating line, for adding 0 does not change the value of an addition.
When building a value with x, always use 1 for the value of the terminating line, for multiplying by 1 does not change the value of a multiplication.
When building a value with cons, always consider () for the value of the terminating line.


The Sixth Commandment
---------------------
Simplify only after the function is correct.


The Seventh Commandment
-----------------------
Recur on the subparts that are of the same nature:
- On the sub-lists of a list.
- On the sub-expressions of an arithmetic expression.


The Eighth Commandment
----------------------
Use help functions to abstract from representations.


The Ninth Commandment
---------------------
Abstract common patterns with a new function.


The Tenth Commandment
---------------------
Build functions to collect more than one value at a time.


The Five Rules
==============

The Law of Car (first)
----------------------
The primitive car is defined only for non-empty lists.


The Law of Cdr (rest)
---------------------
The primitive cdr is defined only for non-empty lists. The cdr of any non-empty list is always another list.


The Law of Cons
---------------
The primitive cons takes two arguments. The second argument to cons must be a list. The result is a list.


The Law of Null?
----------------
The primitive null? is defined only for lists.


The Law of Eq? (=)
------------------
The primitive eq? takes two arguments. Each must be a non-numeric atom.


