=======================

  newLISP IN GENERALE

=======================

==============
 INTRODUZIONE
==============

Questi appunti introducono all'uso del linguaggio newLISP per le elaborazioni numeriche (e anche per altre cose). È necessaria una conoscenza di base della programmazione in newLISP. Un ottima scelta per imparare questo linguaggio è il libro "Introduction to newLISP" disponibile come WikiBooks all'indirizzo:  http://en.wikibooks.org/wiki/Introduction_to_newLISP
Comunque per avere una panoramica sul linguaggio potete anche consultare "newLISP in 21 minuti" di John W. Small riportato in appendice.
Maggiori informazioni sono reperibili al sito ufficiale del linguaggio:

http://www.newLISP.org/

Questo documento è in continua evoluzione e aggiornamento ed è scritto non da un programmatore professionista, ma da un principiante che studia ed utilizza newLISP per divertimento. In genere uso newLISP nel mio lavoro quotidiano e per risolvere problemi di matematica ricreativa.
Consigli, correzioni e suggerimenti sono i benvenuti.

Per convenzione i comandi di input della REPL non contengono il prompt di newLISP ">".
L'output della REPL viene preceduto dalla stringa ";-> ".
Nel testo sono riportate le descrizioni di alcuni comandi predefiniti tradotte dal manuale di riferimento ("newLISP Reference"). Queste descrizioni sono precedute dalla stringa ">>>funzione". Ad esempio, per trovare la funzione "map", ricercare la stringa ">>>funzione MAP".

Caratteristiche del sistema utilizzato
--------------------------------------
S.O. Windows 10 Professional 64-bit
Linguaggio: newLISP 10.7.5 UTF-8
Motherboard: ASUS GTX750-PH
CPU: Intel Core i5-4460
RAM: 16Gb DDR3 800mHz
GPU: NVIDIA Geforce GTX 750 SDRAM: 2Gb GDDR5

NOTA:
I riferimenti principali di questo documento sono:
1) "newLISP User Manual and Reference" di Lutz Mueller
2) "Code Patterns in newLISP" di Lutz Muller
3) "Introduction to newLISP" di Cormullion
Tutti gli articoli tradotti presenti in questo documento sono sotto il copyright dei rispettivi autori. Ogni errore di traduzione è imputabile soltanto a me.
Per quanto possibile ho sempre riportato il nome degli autori delle funzioni realizzate da altri programmatori utilizzate in questo documento (viste e prese da forum, blog, ecc.).
Ringrazio tutti quelli che vorranno suggerire critiche, correzioni e miglioramenti.

===============
 INSTALLAZIONE
===============

Scaricate il file di installazione dal sito http://www.newLISP.org/index.cgi?Downloads
Esistono versioni per Windows 32 e 64-bit, Mac OS X, Linux, FreeBSD, ecc.
Per windows 64-bit il file si chiama: newLISP-10701-win64-gs-166.exe
Questo manuale utilizza le versioni 10.7.1, 10.7.4 e 10.7.5 UTF-8 di newLISP.
Potete scaricare l'ultima versione del linguaggio dal sito http://www.newLISP.org/downloads/ dove potete trovare anche la versione UTF-8.
Per installare il programma seguire le semplici istruzioni riportate nel sito.
Terminata l'installazione abbiamo a disposizione due modalità per eseguire newLISP:
1) modalità console (REPL)
2) modalità grafica (GUI)
Utilizzeremo solo la modalità REPL (Read Evaluate Print Loop).
Questo manuale e i sorgenti in esso contenuti si trovano al sito:

https://github.com/cameyo42/notes-newLISP

Scaricate e copiate i file in una cartella a piacere (es. c:\newLISP\numeric).
Potete leggere il file PDF oppure utilizzare il file di testo. In quest'ultimo caso per seguire gli esempi potete usare l'editor notepad++ con il plugin che si trova al sito:

https://github.com/cameyo42/notepadpp-newLISP

Seguendo le istruzioni riportate in appendice potete leggere il documento e contemporaneamente eseguire il codice che ritenete opportuno.


==================
 ESEGUIRE newLISP
==================

Possiamo eseguire il programma newLISP utilizzando l'icona che viene creata durante l'installazione, oppure possiamo aprire una finestra DOS (command prompt) ed eseguire il comando: newLISP.exe.
Se ottenete un errore, allora probabilmente la variabile di ambiente PATH non contiene la cartella dove si trova l'eseguibile del programma (es. c:\Program Files (x86)\newLISP\).
Se tutto va bene otteniamo una finestra di testo con il prompt di newLISP (>):

newLISP v.10.7.4 64-bit on Windows IPv4/6 UTF-8 libffi, options: newLISP -h

>

Per vedere in quale cartella ci troviamo digitiamo il comando "!cd":

!cd
;-> c:\newLISP\note

Se non ci troviamo nella cartella corretta possiamo cambiare cartella con il comando "change-dir":

(change-dir "c://newLISP/note")
;-> true

Verifichiamo:

!cd
;-> c:\newLISP\note


====================
 LE FUNZIONI UTENTE
====================

La struttura di base di una funzione definita dall'utente è la seguente:

(define (nome-funzione v1 v2 ... vn)
  (expression-1)
  (expression-2)
  ...
  (expression-n)
)

I parametri della funzione v1 v2 ... vn sono opzionali.
Quando la funzione viene eseguita, ogni espressione viene valutata in sequenza.
Il valore dell'ultima espressione valutata viene restituito come valore della funzione.

Se vogliamo specificare esplicitamente il valore da restituire, aggiungiamo un'espressione alla fine che valuta al valore desiderato:

(define (maggiore a b)
  (setq out (> a b))
  (setq delta (- a b))
  out
)

(maggiore 2 3)
;-> nil

Per fare in modo che una funzione restituisca più di un valore possiamo restituire una lista:

(define (maggiore a b)
  (setq out (> a b))
  (setq delta (- a b))
  (list out delta)
)

(maggiore 2 3)
;-> (nil -1)

I simboli definiti nella lista degli argomenti della funzione sono locali alla funzione, anche se esistono simboli con lo stesso nome al di fuori della funzione.


===========================
 ARGOMENTI DI UNA FUNZIONE
===========================

Il carattere virgola "," è un simbolo.
In newLISP viene usato (per convenzione) come separatore tra:
gli argomenti di una funzione e le variabili locali di una funzione.
In questo modo si aumenta la leggibilità del programma.
Nella funzione test t1 e t2 sono variabili interne alla funzione, mentre out è il valore restituito dalla funzione. Questo è possibile perchè newLISP permette di chiamare una funzione con un numero di argomenti diverso da quello stabilito dalla sua definizione.
Tutti gli argomenti che non possono essere associati hanno valore nil.
I simboli degli argomenti sono locali alla funzione, anche se esistono al di fuori della funzione.

(define (test a b c , t1 t2 out)
  (setq t1 10)
  (setq t2 20)
  (setq , 42) ; La virgola "," è un simbolo
  (println ,)  ;
  (setq out (+ a b c t1 t2))
)

Esecuzione della funzione con tre parametri:

(test 1 2 3)
;-> 42
;-> 36

Esecuzione della funzione con sei parametri:

(test 1 2 3 100 200 300)
;-> 42
;-> 36

Possiamo scrivere funzioni che accettano un numero variabile di argomenti:

(define (test v1)
  (println "gli argomenti sono " v1 " e " (args)))

(test)
;-> gli argomenti sono nil e ()

(test 1 2 3)
;-> gli argomenti sono 1 e (2 3)

Notiamo che v1 contiene il primo argomento passato alla funzione, ma ogni argomento rimasto inutilizzato si trova nella lista ritornata da (args).

Con args è possibile scrivere funzione che accettano un numero variabile di argomenti (e di tipo).
La seguente funzione può essere chiamata senza argomenti, con un argomento di tipo stringa o di tipo numero, o con una lista:

(define (flessibile)
  (println "gli argomenti sono " (args))
  (dolist (a (args))
  (println "-> argomento " $idx " vale " a)))

(flessibile)
;-> gli argomenti sono ()
;-> nil

(flessibile "ok")
;-> gli argomenti sono ("ok")
;-> -> argomento 0 vale ok

(flessibile 1 2 3)
;-> gli argomenti sono (1 2 3)
;-> -> argomento 0 vale 1
;-> -> argomento 1 vale 2
;-> -> argomento 2 vale 3

Nota: $idx è una variabile interna di newLISP che tiene traccia dell'indice relativo all'elemento corrente.
Tale variabile può essere letta all'interno del ciclo (es. dolist, doargs, map, ecc), ma non può essere modificata dall'utente.

Vediamo un altro esempio di funzione che accetta un numero variabile di argomenti:

(define (somma)
  (apply + (args)))

(somma 1 2 3 4 5)
;-> 15

Per accedere agli argomenti ritornati da (args) possiamo usare la funzione "doargs" al posto di "dolist":

(define (flessibile)
  (println "gli argomenti sono " (args))
  (doargs (a) ; al posto della funzione dolist
    (println "-> argomento " $idx " vale " a)))

Le variabili locali definite nell'elenco degli argomenti della funzione possono avere valori predefiniti, che verranno utilizzati solo se non si specificano i valori quando si chiama la funzione.

(define (test (a 1) b (c 2))
   (println a " " b " " c))

I simboli "a" e "c" assumono i valori 1 e 2 se non si forniscono valori nella chiamata, ma "b" avrà valore nil a meno che non venga fornito un valore per questo.

(test)
;-> 1 nil 2

=========================================================
 TRASFORMARE UNA FUNZIONE DISTRUTTIVA IN NON-DISTRUTTIVA
=========================================================

Una funzione viene detta "distruttiva" quando modifica il proprio argomento.

La maggior parte delle funzione primitive in newLISP sono non-distruttive (non hanno effetti collaterali) e lasciano intatti gli oggetti esistenti, sebbene possano crearne di nuovi. Esistono tuttavia alcune funzioni distruttive che modificano il contenuto di una variabile, una lista, un vettore o una stringa:

Funzione        Descrizione
--------        -----------
++              increments numbers in integer mode
--              decrements numbers in integer mode
bind            binds variable associations in a list
constant        sets the contents of a variable and protects it
extend          extends a list or string
dec             decrements a number referenced by a variable, list or array
define          sets the contents of a variable
define-macro    sets the contents of a variable
inc             increments a number referenced by a variable, list or array
let             declares and initializes local variables
letn            initializes local variables incrementally, like nested lets
letex           expands local variables into an expression, then evaluates
net-receive     reads into a buffer variable
pop             pops an element from a list or string
pop-assoc       removes an association from an association list
push            pushes a new element onto a list or string
read            reads into a buffer variable
receive         receives a message from a parent or child process
replace         replaces elements in a list or string
reverse         reverses a list or string
rotate          rotates the elements of a list or characters of a string
set             sets the contents of a variable
setf setq       sets the contents of a variable, list, array or string
set-ref         searches for an element in a nested list and replaces it
set-ref-all     searches for an element in a nested list and replaces all instances
sort            sorts the elements of a list or array
swap            swaps two elements inside a list or string

Alcune funzioni distruttive possono essere rese non-distruttive applicando la funzione "copy" al parametro della funzione. In questo modo viene passata alla funzione una copia dei dati, impedendo così la modifica dei dati originali.

Per esempio la funzione distruttiva "replace":

(set 'aList '(a b c d e f))
(replace 'c aList)
;-> (a b d e f)

aList ; la lista originale viene modificata
;-> (a b d e f)

Diventa non-distruttiva utilizzando la funzione "copy":

(set 'aList '(a b c d e f))
(replace 'c (copy aList))
;-> (a b d e f)

aList ; la lista originale non viene modificata
;-> (a b c d e f)


===============================================
 TRASFORMARE UNA FUNZIONE DA DUE A N ARGOMENTI
===============================================

Ecco una funzione che calcola il Massimo Comun Divisore di due numeri interi:

(define (MCD a b)
  (let (r (% b a))
       (if (= r 0) a (MCD r a))
  )
)

(MCD 21 14)
;-> 7

Non possiamo calcolare il MCD per tre o piu' numeri:

(MCD 15 5 21)
;-> 5

Risultato errato: newLISP associa solo i primi due argomenti 15 e 5.

Per poter applicare alla funzione un numero arbitrario di argomenti, possiamo utilizzare una macro che applica tutti gli argomenti, chiamando la funzione originale con il corretto numero di parametri.

Modifichiamo il nome della funzione originale in "MCD-aux":

(define (MCD-aux a b)
  (let (r (% b a))
       (if (= r 0) a (MCD-aux r a))
  )
)

Adesso definiamo la macro:

(define-macro (MCD)
  (apply MCD-aux (args) 2))

(MCD 15 5 21)
;-> 1

Per capire come funziona dobbiamo analizzare la funzione "apply":

******************
>>>funzione APPLY
******************
sintassi: (apply func list [int-reduce])

Applica l'espressione "func" (primitiva, funzione utente, o lambda) agli argomenti di "list".
Gli argomenti vengono utilizzati tutti con un unica operazione.
Possiamo usare solo funzioni e operatori che hanno una valutazione normale dei loro argomenti.

(apply + '(1 2 3 4))
;-> 10
(set 'aList '(3 4 5))
;-> (3 4 5)
(apply * aList)
;-> 60
(apply sqrt '(25))
;-> 5
(apply (lambda (x y) (* x y)) '(3 4))
;-> 12

Il parametro opzionale "int-reduce" indica il numero di parametri della funzione "func".
In questo caso, "func" viene applicata ripetutamente utilizzando il risultato precedente come primo argomento, mentre gli altri argomenti vengono presi da "list".
(con ordine di associazione sinistro).

In altre parole, se la funzione "op" ha due argomenti, allora l'espressione:

(apply op '(1 2 3 4 5) 2)

equivale a:

(op (op (op (op 1 2) 3) 4) 5)

Tutte le volte che viene applicata, la funzione "op" viene chiamata con due argomenti.

Per esempio:

(apply max '(11 22 13 41 15) 2)
;-> 41

(max (max (max (max 11 22) 13) 41) 15)
;-> 41

Nel nostro caso risulta che: (MCD a b c ...) = (MCD (MCD (MCD a b) c) ...)

Gli argomenti di una funzione/macro che non vengono associati nella chiamata sono memorizzati nella lista "args".

Abbiamo definito la macro "MCD" senza alcun argomento, quindi la chiamata:
(MCD 15 5 21) non associa alcun argomento e la variabile "args" vale (15 5 21).
Sostituendo nella funzione "apply" otteniamo:

(apply MCD-aux '(15 5 21) 2)
;-> 1

(MCD-aux (MCD-aux 15 5) 21)
;-> 1

Proviamo ancora la macro:

(MCD 10 25)
;-> 5

(MCD 4 8 24)
;-> 4

Comunque se usiamo delle espressioni come parametri della macro, otteniamo un errore:

(MCD (+ 2 2) (- 10 2) 24)
;-> ERR: value expected in function % : (- 10 2)
;-> called from user function (MCD (+ 2 2) (- 10 2) 24)

Le espressioni non vengono valutate dalla nostra macro.
Infatti ci limitiamo a passare i parametri alla macro senza prima valutarli.

Per risolvere il problema possiamo utilizzare le funzioni "map" e "eval".

****************
>>>funzione MAP
****************
sintassi: (map func list-args-1 [list-args-2 ... ])

Applica la funzione "func" (primitiva, funzione utente, espressione lambda) ad ogni gruppo di argomenti specificati dalle liste "list-args-1", "list-args-2", etc.
La funzione "func" viene applicata tante volte quanti sono i gruppi di argomenti:
gli argomenti della prima chiamata sono i primi elementi di ogni lista,
gli argomenti della seconda chiamata sono i secondi elementi di ogni lista,
gli argomenti della n-esima chiamata sono gli n-esimi elementi di ogni lista,
In numero degli argomenti usati viene determinato dalla lunghezza di "list-args1" (prima lista).
Restituisce una lista di risultati.
list-args può essere un vettore, ma il risultato sarà sempre una lista.

Ad esempio:

(map max '(3 2 1) '(5 8 7) '(1 9 8))
;-> (5 9 8)

Il risultato viene costruito con le seguenti chiamate:

(max 3 5 1) ; prima chiamata
;-> 5
(max 2 8 9) ; seconda chiamata
;-> 9
(max 1 7 8) ; terza chiamata
;-> 8

Altri esempi:

(map pow '(1 2 3))
;-> (1 4 9)

(map + '(1 2 3) '(50 60 70))
;-> (51 62 73)

(map if '(true nil true nil true) '(1 2 3 4 5) '(6 7 8 9 10))
;-> '(1 7 3 9 5)

(map (fn (x y) (* x y)) '(3 4) '(20 10))
;-> (60 40)

map può utilizzare anche l'indice della lista interna $idx.

(map (fn (x) (list $idx x)) '(a b c))
;-> ((0 a) (1 b) (2 c))

Il numero di argomenti utilizzati è determinato dalla lunghezza della prima lista di argomenti.

*****************
>>>funzione EVAL
****************
sintassi: (eval exp)

"eval" calcola il risultato della valutazione dell'espressione "exp".
La valutazione viene effettuata nel contesto corrente delle variabili.

Esempi:

(set 'expr '(+ 3 4))
;-> (+ 3 4)
(eval expr)
;-> 7
(eval (list + 3 4))
;-> 7
(eval ''x)
;-> x
(set 'y 123)
(set 'x 'y)
;-> y
(eval x)
;-> 123

La valutazione delle variabili avviene nel contesto corrente:

(set 'x 3 'y 4)
(eval '(+ x y))
;-> 7

Vediamo "eval" in un contesto locale:

(let ( (x 33) (y 44) )
    (eval '(+ x y)))
;-> 77

Ancora "eval" nel vecchio contesto dopo essere usciti dal contesto locale:

(eval '(+ x y))
;-> 7

Ritornando al nostro problema, possiamo valutare tutti gli argomenti della macro "MCD" con la funzione "eval", utilizzando la funzione "map".

(define-macro (MCD)
  (apply MCD-aux (map eval (args)) 2))

Proviamo la nuova macro:

(MCD (+ 2 2) (- 10 2) 24)
;-> 4

Funziona !!!

Adesso vediamo la funzione "curry":

******************
>>>funzione CURRY
******************
sintassi: (curry func exp)

Trasforma "func" da una funzione f(x, y) che prende due argomenti, in una funzione fx(y) che prende un singolo argomento. "curry" funziona come una macro, nel senso che non valuta i suoi argomenti. Questi ultimi vengono valutati durante l'applicazione della funzione "func".

(set 'f (curry + 10))
;-> (lambda ($x) (+ 10 $x))

(f 7)
;-> 17

(filter (curry match '(a *)) '((a 10) (b 5) (a 3) (c 8) (a 9)))
;-> ((a 10) (a 3) (a 9))

(clean (curry match '(a *)) '((a 10) (b 5) (a 3) (c 8) (a 9)))
;-> ((b 5) (c 8))

(map (curry list 'x) (sequence 1 5))
;-> ((x 1) (x 2) (x 3) (x 4) (x 5))

"curry" può essere usato con tutte le funzioni che prendono due argomenti.

Vediamo come usare "curry" insieme alla funzione "map".
Possiamo utilizzare "map" con una funzione che riceve più di un argomento (ad esempio la funzione "pow") in questo modo:

(map pow '(2 1) '(3 4))
;-> (8 1)

dove: 8 = 2^3, 1 = 1^4

Ma se la lista degli argomenti si trova all'interno di un'altra lista, allora otteniamo un errore:

(setq lst '((2 1) (3 4)))
(map pow lst)
;-> ERR: value expected in function pow : '(2 1)

Possiamo utilizzare la funzione "curry" per risolvere questo problema:

(map (curry apply pow) lst)
;-> (2 81)

dove: 2 = 2^1, 81 = 3^4

Ok, non è il risultato che volevamo, ma se trasponiamo la lista degli argomenti:

(transpose lst)
;-> ((2 3) (1 4))

Quindi possiamo scrivere:

(map (curry apply pow) (transpose lst))
;-> (8 1)

Che è equivalente a:

(map (lambda(x) (apply pow x)) (transpose lst))
;-> (8 1)

Possiamo anche utilizzare una funzione definita dall'utente:

(define (mypow lst)
  (if (null? lst) '()
      (cons (pow (nth '(0 0) lst) (nth '(0 1) lst)) (mypow (rest lst)))
  )
)

(setq lst '((2 1) (3 4)))
(mypow (transpose lst))
;-> (8 1)

Un altro esempio con la funzione "max":

(map max '(3 5) '(2 7))
;-> (3 7)

(map (curry apply max) '((3 5) (2 7)))
;-> (5 7)

(map (curry apply max) (transpose '((3 5) (2 7))))
;-> (3 7)


========================================================
 APPLICARE UNA FUNZIONE AD OGNI SOTTOLISTA DI UNA LISTA
========================================================

Supponiamo di voler sommare gli elementi di ogni sottolista della seguente lista:

(setq lst '((1 3) (3 4) (5 6)))

Il risultato dovrebbe essere: (4 7 11).

Primo metodo
Applichiamo la funzione map con una funzione lambda che somma gli elementi della sottolista

(map (lambda (x) (apply + x)) lst)
;-> (4 7 11)

Secondo metodo
Utilizziamo la funzione "curry" per rimpiazzare la funzione lambda

(map (curry apply +) lst)
;-> (4 7 11)


===================================================
 ASSEGNAZIONE GLOBALE: SET, SETQ e SETF (e DEFINE)
===================================================

****************
>>>funzione SET
****************
sintassi: (set sym-1 exp-1 [sym-2 exp-2 ... ])

Valuta entrambi gli argomenti e poi assegna il risultato di exp al simbolo trovato in sym.
La funzione "set" restituisce il risultato dell'assegnazione.
Il vecchio contenuto del simbolo viene cancellato.
Viene visualizzato un messaggio di errore quando si tenta di modificare il contenuto dei simboli nil, true o un simbolo del contesto.
"set" può effettuare assegnazioni multiple sulle coppie di argomenti.

*****************
>>>funzione SETQ
*****************
sintassi: (setq place-1 exp-1 [place-2 exp-2 ... ])

*****************
>>>funzione SETF
*****************
sintassi: (setf place-1 exp-1 [place-2 exp-2 ... ])

In newLISP "setq" e "setf" funzionano allo stesso modo:
impostano il contenuto di un simbolo, una lista, un array o una stringa o di una loro parte.
Il primo argomento è un simbolo o un riferimento ad una parte di un simbolo.
Come "set", anche "setq" e "setf" possono assumere più coppie di argomenti.
Per convenzione si utilizza:
1) "setq" quando si imposta un simbolo
2) "setf" quando si imposta una parte di una lista o di un array
Sia "setq" che "setf" puntano internamente alla stessa funzione.

Esempi:

Il simbolo "a" è quotato poichè altrimenti verrebbe valutato.
("set" valuta anche il suo primo argomento)

(set 'a '(1 2 3))
;-> (1 2 3)

Non serve quotare "a" ("setq" non valuta il primo argomento)

(setq a '(1 2 3))
;-> (1 2 3)

Assegnazione multipla

(setq a 1 b 2 c 3)
;-> 3
a b c
;-> 1
;-> 2
;-> 3

Usando la funzione "nth" oppure l'indicizzazione implicita (gli indici iniziano da zero)

(setq L '(a b (c d) e f g))

(setf (L 1) 'C)
L
;-> (a C (c d) e f g)

(setf (nth 1 L) 'B)
L
;-> (a B (c d) e f g)

(setf (L 2 0) 'C)
L
;-> (a B (C d) e f g)

Assegnazione e modifica di stringhe

(set 's "NewISP")
;-> "NewISP"

(setf (s 0) "n")
;-> "n"

(setf (s 3) "LI")
;-> "LI"

Spesso il nuovo valore dipende dal vecchio valore. Con "setf" e "setq" possiamo usare la variabile interna di sistema "$it" per riferirsi al vecchio valore all'interno dell'espressione di assegnazione:

(setq L '((apples 4) (oranges 1)))
(setf (L 1 1) (+ $it 1))
L
;-> ((apples 4) (oranges 2))

(set 's "newLISP")
(setf (s 0) (lower-case $it))
s
;->"newLISP"

Vediamo adesso la funzione "define":

*******************
>>>funzione DEFINE
*******************
sintassi: (define sym-name exp)

In genere "define" viene utilizzata per definire una funzione.
In questo caso si comporta come la funzione "set", con la differenza che il primo argomento non viene valutato e quindi non deve essere quotato.
Se proviamo a ridefinire un simbolo protetto otteniamo un messaggio di errore.

Esempi:

(define x 123)
;-> 123
è uguale a:
(set 'x 123)
;-> 123

(define area (lambda (x y) (* x y)))
è uguale a:
(set 'area (lambda (x y) (* x y)))
è uguale a:
(define (area x y) (* x y))

Nota: l'assegnazione setq o setf è più veloce di set.

;; setq
(time (dotimes (i 100000) (setq a 10) (setq b 10)) 1000)
;-> 6145.725

;; set
(time (dotimes (i 100000) (set 'a 10) (set 'b 10)) 1000)
;-> 6911.922

;; setf
(time (dotimes (i 100000) (setf a 10) (setf b 10)) 1000)
;-> 6113.744

(time (setq a 10) 100000000)
;-> 2547.251
(time (set 'a 10) 100000000)
;-> 2859.788
(time (setf a 10) 100000000)
;-> 2594.358


========================================
 ASSEGNAZIONE LOCALE: LET, LETN e LOCAL
========================================

Usando le funzioni "let" e "letn", possiamo definire variabili (simboli) che esistono solo all'interno di una lista. Non sono valide al di fuori della lista e perdono il loro valore una volta che la lista ha finito di essere valutata.
Il primo elemento di una lista "let" è un sottolista contenente variabili (che non devono essere quotate) ed espressioni che servono ad inizializzare ogni variabile.
Gli elementi rimanenti della lista sono espressioni che possono accedere a tali variabili.
Si consiglia di allineare le coppie variabile/valore iniziale:

(let
  (x (* 2 2)
   y (* 3 3)
   z (* 4 4)
  ) ; fine dell'inizializzazione
  (println "somma = " (+ x y z))
) ; fine della lista
;-> somma = 29

Se vogliamo utilizzare una variabile locale anche nella parte successiva dell'inizializzazione, dobbiamo usare la funzione "letn" al posto di "let":

(letn
  (x 2 ; definiamo x
   y (pow x 3) ; poi usiamo x nell'inizializzazione
   z (pow x 4))
  (println "somma = " (+ x y z))
)
;-> somma = 26

Al posto di "let" e "letn" possiamo usare la funzione "local". In questo caso non dobbiamo fornire alcun valore, poichè vengono impostati tutti a nil da newLISP:

(define (test)
  (local (a b c)
    (println a " " b " " c)
    (set 'a 1 'b 2 'c 3)
    (println a " " b " " c)))

(test)

;-> nil nil nil
;-> 1 2 3

(define a 10)
(define b 20)
(define c 30)

(define (test a b c)
    (println a " " b " " c)
    (set 'a 1 'b 2 'c 3)
    (println a " " b " " c))

(test 100 200 300)
;-> 100 200 300
;-> 1 2 3

In genere l'uso di "local" è più comodo e rende il programma più leggibile.


========================================================
 EFFETTI COLLATERALI (side effect) DI SETQ, LET e LOCAL
========================================================

Un comportamento subdolo...

Definiamo la funzione "add2":

(define (add2 x)
  (setq i 2)
  (+ i x)
)

Proviamo:

(add2 5)
;-> 7

Definiamo una funzione "formula":

(define (formula x)
    (setq i 1)
    (+ i (add2 x))
    ;(println i { } out)
)

Proviamo:

(formula 3)
;-> 6

Riscriviamo la funzione "formula" spostando la variabile "i":

(define (formula x)
    (setq i 1)
    (+ (add2 x) i) ;scambiamo di posto alla variabile i
)

Proviamo:

(formula 3)
;-> 7 ; Non è il risultato voluto

Che cosa è successo?

Nell'espressione (setq out (+ 5 (add2 x) i)) la variabile "i" vale 2, perchè questo è il valore che ha dopo l'esecuzione della funzione "add2"
(vedi l'espressione (setq i 2))

Questo può essere evitato se utilizziamo "let" al post di "setq".
Le variabili dichiarate con "let" esistono solo all'interno del blocco e vengono eliminate quando termina il blocco stesso.

Riscriviamo la funzione "add2":

(define (add2 x)
  (let ((i 2))
        (+ i x)
  ) ;fine del blocco let: la variabile "i" del blocco non esiste
)

Proviamo:

(add2 5)
;-> 7

Riscriviamo la funzione "formula":

(define (formula x)
    (let ((i 1))
         (+ i (add2 x)))
)

Proviamo:

(formula 3)
;-> 6

Proviamo con la "i" scambiata di posto:

(define (formula x)
    (let ((i 1))
         (+ (add2 x) i))
)

(formula 3)
;-> 6

Adesso tutto funziona correttamente.

Occore fare attenzione anche nel caso di variabili globali, per esempio:

(setq tot 0)

(define (somma x y)
  (setq tot (+ x y))
)

(somma 2 3)
;-> 5

La funzione si comporta correttamente, ma la variabile "tot" adesso vale:

tot
;-> 5

Riscriviamo la funzione usando "let":

(define (somma x y)
  (let ((tot (+ x y)))
       tot
  )
)

Proviamo:

(setq tot 0)

(somma 2 3)
;-> 5

tot
;-> 0

Il valore globale della variabile "tot" non è cambiato.

Dentro il blocco "let" possiamo utilizzare "setq" senza problemi.

Definiamo una variabile globale:

(setq y 10)

Definiamo una funzione di test:

(define (test x)
  (let ((y 0))
    (setq y 2)
    (* x y)
  )
)

Proviamo:

(test 3)
;-> 6

La variabile globale non è stata modificata:
y
;-> 10

Per capire meglio modifichiamo la funzione di test:

(define (test x)
  (let ((y 0))
    (setq y 2)
    (println "Risultato funzione = " (* x y))
    (println "y let (locale) = " y)
  )
  (println "y setq (globale) = " y)
)

Riproviamo:

(setq y 10)

(test 3)
;-> Risultato funzione = 6
;-> y let (locale) = 2
;-> y setq (globale) = 10
;-> 10

Vediamo un altro comportamento delle variabili con la funzione "local":

(define (f)
  (local (fa fb)
    (println "da F prima di G")
    (setq fa 1)
    (setq fb 2)
    (println {fa = } fa { @ } {fb = } fb)
    (g)
    (println "da F dopo G")
    (println {fa = } fa { @ } {fb = } fb)
  )
)

(define (g)
  (local (fa)
    (println "da G")
    (println {fa = } fa { @ } {fb = } fb)
    (setq fa 22)
    (setq fb 33)
    (println {fa = } fa { @ } {fb = } fb)
  )
)

(f)
;-> da F prima di G
;-> fa = 1 @ fb = 2
;-> da G
;-> fa = nil @ fb = 2
;-> fa = 22 @ fb = 33
;-> da F dopo G
;-> fa = 1 @ fb = 33

La variabile "fa" viene ridefinita nella funzione "g" quindi il suo valore non cambia per la funzione "f" (in altre parole esistono due variabili locali "fa", una interna alla funzione "f" e l'altra interna alla funzione "g").
La variabile "fb" non viene ridefinita in "g" quindi il suo valore cambia anche all'interno della funzione "f" (in altre parole esiste una sola variabile "fb" visibile da entrambe le funzioni "f" e "g").

Un ultimo esempio:

(setq a 1 b 2)

(let (c (+ a b)) (println c))
;-> 3

(let (a 4 b 5 c (+ a b)) (println a { } b { } c))
;-> 4 5 3

c = 3 perchè nell'espressione (+ a b), a = 1 e b = 2.

Usiamo letn per risolvere il problema:

(letn (a 4 b 5 c (+ a b)) (println a { } b { } c))
;-> 4 5 9

Adesso c = 9 perchè dentro l'espressione letn a = 4 e b = 5.


==================================================
 PASSAGGIO PER VALORE E PASSAGGIO PER RIFERIMENTO
==================================================
 Pass by Value e Pass by Reference

Per default, il linguaggio newLISP passa i parametri per valore (Pass by Value), cioè passa alle funzioni una copia dei valori dei parametri.
Se vogliamo utilizzare il passaggio per riferimento (Pass by Reference) bisogna usare i contesti (CONTEXT).

Cosa significa questo?

Supponiamo di avere una lista m = (0 1 2 3) e di voler modificare il valore di alcuni elementi.
Scriviamo una funzione che prende tre parametri: una lista, un indice e un valore.

(define (aggiorna lst idx el) (setf (lst idx) el) (println lst))

Proviamo:

(setq m '(0 1 2 3))
;-> (0 1 2 3)
(aggiorna m 0 2)
;-> (2 1 2 3)

Sembra tutto a posto, ma se stampiamo la lista "m" abbiamo una sorpresa:

m
;-> (0 1 2 3)

La lista "m" non è cambiata !!!

In newLISP, alle funzioni viene sempre passata una copia dei parametri, quindi la lista "m" non può essere modificata perchè la funzione "aggiorna" lavora su una copia della lista "m".

Quindi se vogliamo aggiornare la lista "m" dobbiamo modificare la funzione in modo che ritorni la lista aggiornata e poi assegnare questa lista alla lista "m".

(define (demo lst el) (setf (lst 0) el) lst)

Assegniamo a "m" la lista modificata restituita dalla funzione "aggiorna".

(setq m (demo m 2))
;-> (2 1 2 3)
m
;-> (2 1 2 3)

Nota:
Quando abbiamo delle liste con molti elementi, il passaggio per valore rallenta l'esecuzione del programma perchè ad ogni chiamata di funzione deve sempre essere fatta una copia degli argomenti.

Per utilizzare il passaggio per riferimento dovremmo vedere come funzionano i contesti (CONTEXT), comunque, dal punto di vista pratico, questa è la tecnica pe usare il "passaggio per riferimento":

(setq m:m '(0 1 2 3 4 5 6 7))

(define (aggiorna lst idx el) (setf (lst idx) el))

Proviamo:

(aggiorna m 0 2)
;-> 2

m:m
(2 1 2 3 4 5 6 7))

In questo esempio, la lista viene incapsulata in un contesto denominato "m" che contiene una variabile con lo stesso nome.

Ogni volta che una funzione utilizza un parametro di tipo stringa o lista, è possibile passare un contesto, che verrà quindi interpretato come il funtore predefinito di quel contesto.


=============================
 NIL, TRUE e LISTA VUOTA '()
=============================

In newLISP il simbolo "nil" e la lista vuota non sono esattamente la stessa cosa, anche se in alcuni casi sono intercambiabili.

Facciamo alcuni test:

Ovviamente, due liste vuote sono uguali:

(= '() '())
;-> true

ma la seguente espressione genera un errore:

(= () '())
;-> ERR: invalid function in function = : ()

Invece per il valore "nil", abbiamo:

(= nil nil)
; true

ma la seguente espressione non genera un errore perchè "nil" valuta su se stesso:

(= nil 'nil)
; true

Come abbiamo detto all'inizio, la lista vuota '() e "nil" sono diversi:

(= '() 'nil)
;-> nil

In newLISP il valore falso non è rappresentato dal simbolo "false" (che non esiste), ma dal simbolo "nil".

Il simbolo "false" non esiste:

false
;-> nil

(= 'false false)
;-> nil

(= 'false nil)
;-> nil

In newLISP il valore vero è rappresentato dal simbolo "true" e da tutti i simboli che non valgono "nil".
Il simbolo "true" valuta su se stesso:

(= true 'true)
; true

Anche i numeri valutano su se stessi:

(= '0 0)
;-> true

(= '3.14 3.14)
;-> true

Vediamo come un valore venga considerato vero in quanto non "nil":

(if 0 'vero 'falso)
;-> vero

(if 1 'vero 'falso)
;-> vero

Comunque, anche se non sono uguali, la lista vuota '() e "nil" sono considerati come valore falso:

(= '() nil)
;-> nil

(if nil 'vero 'falso)
;-> falso

(if '() 'vero 'falso)
;-> falso

Qualunque altro valore viene considerato vero:

(if '(1 2) 'vero 'falso)
;-> vero

Quindi in newLISP tutto viene considerato vero (true) tranne la lista vuota '() e "nil" che vengono considerati falso (nil). Comunque la lista vuota '() e "nil" sono diversi se confrontati tra loro.

Quindi, "nil" e "true" rappresentano sia simboli che i valori booleani falso (nil) e vero (true). A seconda del loro contesto, "nil" e "true" sono trattati in modo diverso. I seguenti esempi usano "nil", ma possono essere applicati a "true" semplicemente invertendo la logica.

La valutazione di "nil" produce falso (in senso booleano) e viene trattato come tale all'interno di espressioni di controllo del flusso come "if", "unless", "while", "until", e "not". Allo stesso modo, la valutazione di "true" produce vero (cioè true).

(= nil 'nil)
;-> true

(= true 'true)
;-> true

(set 'lst '(nil nil nil))
;-> (nil nil nil)

(map symbol? lst)
;-> (true true true)

In newLISP, "nil" e la lista vuota () non sono uguali a quelli di altri Lisp. Solo nelle espressioni condizionali vengono trattati come falsi booleani, come in "and", "or", "if", "while", "unless", "until", e "cond".

La valutazione di (cons 'x' ()) produce (x), ma (cons 'x nil) produce (x nil) perché "nil" viene trattato come valore booleano quando viene valutato, non come una lista vuota. In newLISP l'applicazione di "cons" a due atomi non produce una coppia puntata, ma piuttosto una lista di due elementi. Il predicato "atom?" è vero per "nil", ma falso per la lista vuota. La lista vuota in newLISP è solo una lista vuota e non è uguale a nil.

Una lista in newLISP è una cella newLISP di tipo lista. Agisce come un contenitore per la lista (linked list) che collega gli elementi che formano il contenuto della lista. Non c'è una coppia puntata in newLISP perché la parte "cdr" (coda) di una cella Lisp punta sempre a un'altra cella Lisp e mai a un tipo di dati di base, come un numero o un simbolo. Solo la parte "car" (testa) può contenere un tipo di dati di base. Le prime implementazioni di Lisp utilizzavano "car" e "cdr" per i nomi head (testa) e tail (coda).


==================================
 LA FUNZIONE QUOTE E IL SIMBOLO '
==================================

Il carattere quote "'" serve per impedire la valutazione dell'espressione che lo segue.
Questa espressione quotata viene quindi valutata letteralmente.
Ricordiamoci che ogni espressione deve produrre un risultato. Infatti non possiamo valutare la lista vuota ():

()
;-> ERR: invalid function : ()

Quotando la lista vuota newLISP restituisce il valore non valutato, cioè la lista vuota:

'()
;-> ()

In newLISP tutto viene valutato come vero [true] tranne la lista vuota "()" e "nil" che vengono valutati come falso [nil]. Comunque la lista vuota "()" e "nil" sono diversi:

(= '() nil)
;-> nil

Il linguaggio newLISp ha hanche la funzione "quote" che è equivalente al carattere "'". Comunque possiamo notare il seguente problema:

(= '(quote 1) ''1)
;-> nil

oppure

(first (quote (quote 1)))
;-> quote

(first ''1)
;-> ERR: array, list or string expected in function first : ''1

C'è una sottile differenza tra i due. Il simbolo ' viene risolto durante la traduzione del codice sorgente, quando la cella quotata viene protetta dalla valutazione con un involucro. La funzione "quote" fa la stessa cosa, ma durante la valutazione dell'espressione. Per la maggior parte degli scopi la funzione e il simbolo si comportano in modo equivalente.
In questo modo la funzione "quote" è più simile alla funzione quote del LISP originale. L'uso del simbolo ' è un'ottimizzazione effettuata durante la traduzione del codice sorgente,Se vuoi saperne di più sulla traduzione e la valutazione del codice, confronta le funzioni "read-expr" e "eval-string".
Nel codice sorgente di newLISP la funzione "quote" viene trasformata in un simbolo (SYMBOL) e il simbolo ' viene trasformato come QUOTE.


======================
 FUNZIONI CON MEMORIA
======================

È possibile scrivere una funzione con memoria, cioè una funzione che produce un risultato diverso ogni volta che viene chiamata ricordando uno stato interno. Per fare questo occorre utilizzare una chiusura (closure). In altre parole scriviamo una funzione generatore.
In newLISP creiamo variabili di stato locali usando un spazio dei nomi chiamato "context":

; generatore newLISP
(define (gen:gen)
  (setq gen:sum
  (if gen:sum (inc gen:sum) 1)))

Questo potrebbe essere scritto più brevemente, perché "inc" considera nil come zero:

(define (gen:gen)
  (inc gen:sum))

(gen)
;-> 1
(gen)
;-> 2

Quando si scrive gen:gen, viene creato un context chiamato gen. gen è uno spazio di nomi (namespace) lessicale contenente i propri simboli usati come variabili e come funzioni. In questo caso il nome-spazio gen contiene due simboli: "gen" (funzione) e "sum" (variabile).
Il primo simbolo di un contesto ha lo stesso nome del contesto in cui è contenuto e viene chiamato "funtore" di default del contesto. In questo caso il contesto si chiama "gen" e quindi il funtore si chiama "gen". Quando si utilizza un nome di contesto al posto di un nome di funzione, newLISP assume il functor predefinito.
Possiamo chiamare la nostra funzione generatore usando (gen). Non è necessario chiamare la funzione usando (gen:gen), (gen) verrà impostato su (gen:gen).


===============================
 GENERARE FUNZIONI DA FUNZIONI
===============================

In newLISP possiamo scrivere programmi che generano programmi oppure funzioni che generano funzioni.
In newLISP codice e dati sono allo stesso livello, cioè le funzioni e le variabili sono nello stesso contesto.
Ad esempio possiamo assegnare la funzione "println" alla variabile "stampa":

(setq stampa println)
;-> print@40AC99

Adesso usiamo la funzione "stampa" come la funzione "println":

(stampa "CODICE = DATI")
;-> CODICE = DATI

Quando definiamo una funzione utente, newLISP la converte in una funzione lambda:

(define (doppio x) (add x x))
;-> (lambda (x) (add x x))

Anche le funzioni lambda possono essere associate alle variabili:

(setq dd (lambda (x) (add x x)))
;-> (lambda (x) (add x x))

(dd 5)
;-> 10

Le funzioni lambda hanno la seguente forma:
(lambda (<arg-1 arg-2 ... arg-n) (expr-1 expr-2 ... expr-n))

Possiamo crearle dinamicamente con una funzione:

(define (crea-lambda operazione parametro)
    (append (fn (x)) (list (list operazione parametro 'x))))

La funzione "crea-lambda" genera funzioni lambda che hanno un operatore (add) con un parametro (2) e un argomento (x):

(crea-lambda 'add 2)
;-> (lambda (x) (add 2 x))

La funzione "map" permette l'uso delle funzioni lambda:

(map (lambda (x) (add 2 x)) '(1 2 3 4 5))
;-> (3 4 5 6 7)

Quindi possiamo fare lo stesso con la nostra funzione "crea-lambda"

(map (crea-lambda add 2) '(1 2 3 4 5))
;-> (3 4 5 6 7)

; Ma anche:

(map (crea-lambda mul 3) '(1 2 3 4 5))
;-> (3 6 9 12 15)

Nota: Possiamo omettere il simbolo quote prima dell'operando (add oppure mul) perche' newLISP valuta sempre le primitive su se stesse.

Possiamo utilizzare la funzione "map" all'interno della funzione "crea-lambda" per applicare direttamente l'operazione (con il parametro) ad una lista:

(define (list-map operazione parametro lista)
    (map (lambda (x) (operazione parametro x)) lista))

(list-map + 2 '(1 2 3 4))
;-> (3 4 5 6)

(list-map mul 1.5 '(1 2 3 4))
;-> (1.5 3 4.5 6)

La funzione "map" rende disponibile anche un indice della lista $idx:

(map (fn (x) (list $idx x)) '(a b c))
;-> ((0 a) (1 b) (2 c))

In altre parole, in newLISP le funzioni sono liste di prima classe:

(define (double x) (+ x x)))
(setf (nth 1 double) '(mul 2 x))

double => (lambda (x) (mul 2 x))

La natura di prima classe delle espressioni lambda in newLISP consente di scrivere codice auto modificante.

Come ultimo esempio vediamo un interessante articolo di Kazimir Majorinc:
http://kazimirmajorinc.com/Documents/Crawler-tractor/index.html

Crawler Tractor (Trattore Cingolato) di Kazimir Majorinc
--------------------------------------------------------

Viene presentato un esempio del programma Lisp di auto-elaborazione. La funzione f incrementa continuamente il valore della variabile "counter" e ne stampa il valore. Tuttavia, l'implementazione di f non contiene alcun ciclo o ricorsione. Invece, la funzione cambia il codice della sua definizione durante la valutazione.

(set 'f
     (lambda()
       (begin (print "Hi for the "
                     (inc counter)
                     ". time. ")
              (push (last f) f -1)
              (if (> (length f) 3)
                  (pop f 1)))))

Il risultato della valutazione della funzione "f" vale:

Hi for the 1. time.
Hi for the 2. time.
Hi for the 3. time.
Hi for the 4. time.
...

La valutazione ricorda il funzionamento di un trattore cingolato, veicolo di costruzione popolare. Inizialmente, l'interprete generava un errore di "stack overflow" dopo che il contatore era stato incrementato alcune centinaia di migliaia di volte. Lutz Mueller, l'autore di newLISP, ha prontamente risolto il problema. La perdita di velocità era, secondo Mueller, molto bassa.

Come prova di concetto, Joel Ericson ha definito due funzioni fattoriali che valutano in modo simile. In una di queste non vengono usate nemmeno le variabili:

(define (f)
  (begin
    (when (> (length f) 2)
             (pop f -1))
    (push '(if (> 0 1)
               (begin ; Increase return value
                      (setf ((last f) -1)
                            (* $it ((last f) 1 1)))
                      ; Change exit condition
                      (dec ((last f) 1 1))
                      ; Shorten f if too long
                      (if (> (length f) 4)
                          (pop f 2))
                      (push (last f) f -1))
               1)
          f
          -1)
    (setq ((last f) 1 1) (args 0))))

Il risultato della valutazione di (f 4) è 24.


================
 TIPI DI NUMERI
================

newLISP gestisce due tipi di numeri: interi (integer) e reali detti anche a virgola mobile (floating-point).
I numeri interi si suddividono in integer e big integer.
Gli integer sono rappresentati con 64-bit includendo il bit del segno.
Gli integer vanno da -9,223,372,036,854,775,808 a +9,223,372,036,854,775,807.
Gli integer di newLISP a 32-bit vanno da -2,147,483,647 a +2,147,483,648.
I numeri floating point sono di tipo double e sono conformi allo standard IEEE 754 a 64-bit.
Questi numeri mantengono solo le prime 15 o 16 cifre più significative (cioè le cifre a sinistra del numero, che sono quelle di valore più alto).
Per maggiori informazioni: https://it.wikipedia.org/wiki/IEEE_754
Possiamo visualizzare numeri senza segno fino a 18,446,744,073,709,551,615 con il comando "format".
Il comando "format" ha una sintassi molto simile a quella del comando "printf" del linguaggio C.
I numeri big integer hanno precisione illimitata e sono limitati soltanto dalla memoria (RAM).

Un numero big integer richiede la seguente quantità di memoria:

bytes = 4 * ceil(digits / 9) + 4.

dove "digits" sono le cifre decimali, "bytes" sono a 8 bit e "ceil" è la funzione che arrotonda un numero intero al numero intero successivo più grande.

Attenzione: Numeri grandi che vengono convertiti da numeri floating point sono troncati ai limiti dei numeri integer. Per esempio:

(setq f 2e20)
;-> 2e+020
(int f)
;-> 9223372036854775807

newLISP gestisce anche numeri con altre basi:

123 → 123 intero decimale (base 10)
0xE8 → 232 intero esadecimale con prefisso 0x (base 16)
055 → 45 intero ottale con prefisso 0 (base 8)
0b101010 → 42 intero binario con prefisso 0b (base 2)

I numeri in virgola mobile possono essere rappresentati anche in notazione scientifica:

1.23 → 1.23    virgola mobile
123e-3 → 0.123 virgola mobile in notazione scientifica


===================================
 PUNTO DECIMALE O VIRGOLA DECIMALE
===================================

Molti paesi usano una virgola anziché un punto come separatore decimale nei numeri. newLISP analizza correttamente i numeri in base all'impostazione locale.

Per vedere l'impostazione del locale corrente:

(set-locale)
;-> ("English_United States.1252" ".")
oppure
;-> ("Italian_Italy.1252" ",")

Per impostare il locale predefinito:

(set-locale "")
;-> ("English_United States.1252" ".")

Per impostare il locale italiano (uso della virgola invece del punto):

(set-locale "Italian_Italy.1252")

Per impostare il locale di default POSIX C:

(set-locale "C")
;-> ("C" ".")

Nota: l'utilizzo di "set-locale" non modifica il comportamento delle espressioni regolari in newLISP.


===========================
 FORMATTAZIONE DELL'OUTPUT
===========================

La funzione utilizzata per formattare la stampa dei numeri si chiama "format".
Di seguito viene riportata la sintassi e alcuni esempi di utilizzo:

sintassi: (format str-format exp-data-1 [exp-data-2 ... ])
sintassi: (format str-format list-data)

Costruisce una stringa formattata da exp-data-1 utilizzando il formato specificato nella valutazione di str-format. Il formato specificato è identico a quello della funzione "printf()" del linguaggio ANSI C.

In str-format possono essere specificati due o più argomenti per un comando "format".

Nella sintassi alternativa i dati da formattare sono passati tramite una lista.

"format" controlla la validità della stringa di formato, la correttezza del tipo di dato, e il corretto numero di argomenti
Formati o tipi di dati errati producono un messaggio di errore
Possiamo usare int, float, o string per assicurare che il tipo di dato sia corretto ed evitare messaggi di errore.

La stringa di formattazione ha il seguente formato generale:

"%w.pf"

Il segno percentuale "%" definisce l'inizio di una stringa di formattazione.
Per visualizzare il carattere "%" con una stringa di formattazione occorre raddoppiarlo: "%%".

Con linux il segno percentuale può essere seguito da un carattere apice "%'" per inserire il separatore delle migliaia nel formato del numero.

Il carattere "w" rappresenta la larghezza del campo.
I dati sono allineati a destra, eccetto quando vengono preceduti da un segno meno, in tal caso vengono allineati a sinistra.
Se inseriamo il carattere "+" all'inizio di un numero, allora i numeri positivi vengono visualizzati con il segno "+".

Quando inseriamo il carattere "0" all'inizio, lo spazio non utilizzato viene riempito da zeri iniziali.

Il campo larghezza è opzionale e serve tutti i tipi di dati.

Il carattere "p" rappresenta il numero dei decimali dei numeri floating-point o stringhe ed è separato dal campo larghezza da un punto "." (period).
La precisione è opzionale. Quando si utilizza il campo precisione in una stringa, allora il numero di caratteri visualizzati è limitato dal valore del numero "p".

Il carattere "f" rappresenta il campo che definisce il tipo di dato ed è essenziale, non può essere omesso.

Di seguito vengono riportati i tipi specificati da "f":

-------------------------------------------------------------------------
|  Formato | Descrizione                                                |
-------------------------------------------------------------------------
|    s     | text string                                                |
|    c     | character (value 1 - 255)                                  |
|    d     | decimal (32-bit)                                           |
|    u     | unsigned decimal (32-bit)                                  |
|    x     | hexadecimal lowercase                                      |
|    X     | hexadecimal uppercase                                      |
|    o     | octal (32-bits) (not supported on all of newLISP flavors)  |
|    f     | floating point                                             |
|    e     | scientific floating point                                  |
|    E     | scientific floating point                                  |
|    g     | general floating point                                     |
-------------------------------------------------------------------------

Su sistemi a 32-bit quando formattiamo un numero a 64-bit utilizzando uno specificatore di formato a 32-bit il numero verrà troncato e formattato con i 32-bit inferiori e pone gli eventuali overflow a 0xFFFFFFFF.

Per numeri a 32-bit e 64-bit utilizzate le seguenti stringhe di formattazione.
Nei sistemi a 32-bit, i numeri a 64-bit saranno troncati a 32-bit.

-------------------------------------------------
| formato   | descrizione                       |
-------------------------------------------------
|   ld      | decimal (32/64-bit)               |
|   lu      | unsigned decimal (32/64-bit)      |
|   lx      | hexadecimal (32/64-bit)           |
|   lX      | hexadecimal uppercase (32/64-bit) |
-------------------------------------------------

Esempi:

(format ">>>%6.2f<<<" 1.2345)           → ">>>  1.23<<<"
(format ">>>%-6.2f<<<" 1.2345)          → ">>>1.23  <<<"
(format ">>>%+6.2f<<<" 1.2345)          → ">>> +1.23<<<"
(format ">>>%+6.2f<<<" -1.2345)         → ">>> -1.23<<<"
(format ">>>%-+6.2f<<<" -1.2345)        → ">>>-1.23 <<<"

(format "%e" 123456789)                 → "1.234568e+08"
(format "%12.10E" 123456789)            → "1.2345678900E+08"

(format "%10g" 1.23)                    → "      1.23"
(format "%10g" 1.234)                   → "     1.234"

(format "Result = %05d" 2)              → "Result = 00002"

(format "%14.2f" 12345678.12)           → "   12345678.12"

; solo su piattaforme UNIX glibc compatibili (Linux, MAC OS X 10.9)
(format "%'14.2f" 12345678.12)          → " 12,345,678.12"

(format "%8d" 12345)                    → "   12345"

; solo su piattaforme UNIX glibc compatibili (Linux, MAC OS X 10.9)
(format "%'8d" 12345)                   → "  12,345"

(format "%-15s" "hello")                → "hello          "
(format "%15s %d" "hello" 123)          → "          hello 123"
(format "%5.2s" "hello")                → "   he"
(format "%-5.2s" "hello")               → "he   "

(format "%o" 80)                        → "120"

(format "%x %X" -1 -1)                  → "ffffffff FFFFFFFF"

; numeri a 64-bit su Windows
(format "%I64X" 123456789012345678)     → "1B69B4BA630F34E"

; numeri a 64-bit su Unix (eccetto TRU64)
(format "%llX" 123456789012345678)      → "1B69B4BA630F34E"

(format "%c" 65)                        → "A"

I dati da formattare possono essere passsati con una lista:

(set 'L '("hello" 123))
(format "%15s %d" L)                    → "          hello 123"

Se la stringa di formattazione lo richiede, newLISP è in grado di convertire gli interi in floating-point e viceversa.

(format "%f" 123)                       → 123.000000

(format "%d" 123.456)                   → 123

In newLISP possiamo usare le parentesi graffe al posto dei doppi apici.

(format {%f %s %d} 3.14 "maggiore di" 3)
;-> "3.140000 maggiore di 3"


===================================
 OPERAZIONI ARITMETICHE ELEMENTARI
===================================

newLISP utilizza operatori matematici diversi in funzione del tipo di numero:
a) per i numeri interi occorre usare: "+", "-", "*" e "/"
b) per i numeri reali occorre usare: "add", "sub", "mul" e "div"

newLISP utilizza la notazione prefissa: prima l'operatore, poi gli argomenti.

Esempi di operazioni aritmetiche con i numeri interi:

(+ 3 9)
;-> 12

(- 4 2)
;-> 2

(* 3 2)
;-> 6

(/ 8 2)
;-> 4

Esempi di operazioni aritmetiche con i numeri reali:

(+ 3.0 1.2) ;oops, abbiamo usato l'operatore somma dei numeri interi
;-> 4

(add 3.0 1.2)
;-> 4.2

(/ 12 5) ;oops, abbiamo usato l'operatore divisione dei numeri interi
;-> 2

(div 12 5)
;-> 2.4


====================================
 INCREMENTO/DECREMENTO DI VARIABILI
====================================

Quando dobbiamo incrementare le variabili possiamo utilizzare diversi metdoi.
Il metodo normale consiste nell'utilizzare la funzione "setq":

(setq i 0)
(setq i (+ i 1))
;-> 1

Oppure possiamo utilizzare l'operatore "++" (per i numeri interi).

sintassi: (++ valore [num])

L'operatore ++ incrementa il valore di 1 o del numero opzionale num e restituisce il risultato. L'operatore ++ usa l'aritmetica intera. Senza l'argomento facoltativo in num, ++ incrementa il valore di 1. Se i numeri in virgola mobile vengono passati come argomenti, la parte frazionaria viene prima troncata. I calcoli risultanti in numeri superiori a 9.223.372.036.854.775.807 produrranno numeri negativi. Risultati inferiori a -9.223.372.036.854.775.808 produrranno numeri positivi. Il parametro "valore" è un simbolo o un valore indicizzato di una lista o il risultato di una espressione.

(set 'x 1)
(++ x)
;-> 2
(set 'x 3.8)
(++ x)
;-> 4
(++ x 1.3)
;-> 5
(set 'lst' (1 2 3))
(++ (lst 1) 2))
;-> 4
lst
;-> (1 4 3)

Se il simbolo per valore contiene nil, viene trattato come se contenga 0.

L'operatore "--" effettua le operazioni di decremento (numeri interi).

Oppure possiamo usare la funzione "inc" (per i numeri in virgola mobile).

sintassi: (inc valore [num])

Incrementa il valore di 1.0 o del numero opzionale num e restituisce il risultato. inc utilizza l'aritmetica in virgola mobile e converte i numeri interi passati in un tipo a virgola mobile. Senza l'argomento facoltativo in num, inc incrementa il valore di 1.0. Il parametro "valore" è un simbolo o un valore indicizzato di una lista o il risultato di una espressione.

(set 'x 0)
(inc x)
;-> 1
(inc x 0.25)
;-> 1.25
(inc x)
;-> 2.25

Se un simbolo per valore contiene nil, viene trattato come se contenga 0.0:

z
;-> nil
(inc z)
;-> 1

Possono essere aggiornati anche gli elementi di una lista o un numero restituito da un'altra espressione:

(set 'lst '(1 2 3 4))
(inc (lst 3) 0.1)
;-> 4.1
(inc (first lst))
;-> 2
lst
;-> (2 2 3 4.1)
(inc (+ 3 4))
;-> 8

La funzione "dec" effettua le operazioni di decremento (numeri in virgola mobile).

Nota: Le funzioni "inc" e "dec" hanno un comportamento diverso se il parametro "valore" viene quotato: le funzioni restituiscono il risultato corretto (incremento o decremento dal numero contenuto in valore, ma la la variabile "valore" mantiene inalterato il numero, cioè non viene incrementato.

Parametro "valore" non quotato:
(setq x 0)
(inc x)
;-> 1
x
;-> 1

Parametro "valore" quotato:
(inc 'x)
;-> 2
x
;-> 1

Invece le funzioni "++" e "--" generano un errore quando cerchiamo di appricarle ad un parametro quotato:

(setq x 0)
(++ 'x)
;-> ERR: value expected in function ++ : x


============================
 USO DEI NUMERI BIG INTEGER
============================

I numeri interi a 64-bit hanno il seguente intervallo: da -9223372036854775808 a 9223372036854775807.
Se aggiungiamo 1 al più grande numero intero a 64-bit, ritorniamo al primo numero dell'intervallo:

(setq intero64-max 9223372036854775807)
(+ intero64-max 1)
;-> -9223372036854775808

Analogamente per il limite inferiore:

(setq intero64-min -9223372036854775808)
(- intero64-min 1)
;-> 9223372036854775807

Quando abbiamo la necessità di calcolare con numeri più grandi dobbiamo utilizzare il tipo big integer.
newLISP permette di definire un numero di tipo big integer aggiungendo il carattere "L" alla fine del numero:

(setq grande-intero 9223372036854775807L)
(+ grande-intero 1)
;-> 9223372036854775808L

In alcuni casi newLISP converte automaticamente il tipo del numero in big integer, ad esempio:

(* 1000000000000000000000000000000 1000000000000000000000000000)
;-> 1000000000000000000000000000000000000000000000000000000000L  ;newLISP ha convertito il risultato in big integer

Ma questa conversione non avviene in ogni calcolo:

(* 1234567899990 1234567899990)
;-> -4329404533060271900 ;newLISP non ha convertito il risultato in big integer

Se tutti gli operandi sono numeri big integer (anche senza la "L" finale), allora il risultato sarà di tipo big integer.
Se gli operandi sono di tipo diverso, allora vale la seguente regola:
il primo operando determina se il risultato sarà di tipo big integer.

Vediamo un esempio:

(for (i 1 10) (println (+ 9223372036854775800 i)))
;-> 9223372036854775801
;-> 9223372036854775802
;-> 9223372036854775803
;-> 9223372036854775804
;-> 9223372036854775805
;-> 9223372036854775806
;-> 9223372036854775807
;-> -9223372036854775808  ;errore
;-> -9223372036854775807
;-> -9223372036854775806
;-> -9223372036854775806

Il primo operando non è un big integer e quindi il risultato non è di tipo big integer.

Per ottenere il risultato corretto dobbiamo scrivere:

(for (i 1 10) (println (+ 9223372036854775800L i))) nota la "L" finale

;-> 9223372036854775801L
;-> 9223372036854775802L
;-> 9223372036854775803L
;-> 9223372036854775804L
;-> 9223372036854775805L
;-> 9223372036854775806L
;-> 9223372036854775807L
;-> 9223372036854775808L
;-> 9223372036854775809L
;-> 9223372036854775810L
;-> 9223372036854775810L

In altre parole, il tipo del primo operando determina il tipo del risultato finale.

Possiamo convertire un numero intero in big integer usando la funzione "bigint":

(setq num (bigint 1000))
;-> 1000L

(setq grande (bigint 9223372036854775807))

(* grande grande)
;-> 85070591730234615847396907784232501249L

(setq atomi (bigint 1E+50))
100000000000000000000000000000000000000000000000000L

(++ atomi)
100000000000000000000000000000000000000000000000001L

I calcoli con i numeri big integer sono più lenti dei calcoli effettuati con gli interi a 64-bit.


===============
 INTROSPEZIONE
===============

Ci sono diversi predicati che consentono di conoscere il tipo di numero associato ad una variabile:

number?    controlla se una espressione è un integer o un floating point

float?    controlla se una espressione è floating point

integer?  controlla se una espressione è un integer

bigint?    controlla se una espressione è un big integer

inf?      controlla se un floating point vale infinito

NaN?      controlla se un floating point vale NaN (Not a Number)

zero?     controlla se una espressione vale 0 (zero)

Scriviamo una funzione che prende una espressione numerica e restituisce il tipo di numero:

(define (type? num)
  (if (number? num)
      (cond ((float? num) "reale")
            ((bigint? num) "grande_intero")
            ((integer? num) "intero")
            (true "sconosciuto"))
      nil ;se non è un numero restituisce nil
   )
)

(type? 10)
;-> "intero"

(type? 10.0)
;-> "reale"

(type? 1e-800)
;-> "reale"

(type? 2394782394578239457239472345723945723458723457234578)
;-> "grande_intero"

(type? 2394782394578239457239472345723945723458723457234578L)
;-> "grande_intero"

Nota: un numero big integer risulta anche integer.

(integer? 2394782394578239457239472345723945723458723457234578)
;-> true

(bigint?  2394782394578239457239472345723945723458723457234578)
;-> true

Nota: il tipo di numero viene definito anche dall'operatore usato.

(float? (add 3 2))
;-> true

(float? (+ 3 2))
;-> nil

(integer? (+ 3 2))
;-> true

(float? (+ 3.0 2.0))
;-> nil

(integer? (+ 3.1 2.1))
;-> true


=============================================
 CONVERSIONI DI TIPO: IMPLICITE ED ESPLICITE
=============================================

newLISP possiede tutte le funzioni necessarie per permettere all'utente di convertire il tipo di un numero, ma effettua autonomamente delle conversioni di tipo quando si verificano speciali condizioni (ad esempio quando nelle espressioni numeriche compaiono numeri che hanno tipi diversi).
Quindi abbiamo conversioni implicite (quelle fatte da newLISP) e conversioni esplicite (quelle richieste dall'utente).
Abbiamo visto alcuni esempi di conversioni durante l'uso dei numeri di tipo big integer.
Per convertire una stringa in numero, oppure convertire il tipo di un numero, possiamo usare le funzioni "int" e "float".

Per esempio, possiamo estrarre i numeri da una stringa:

(map int (find-all {\d+} {In questa stringa ci sono 3 numeri: 10, 20 e 30}))
;-> (3 10 20 30) una lista di interi

(map float (find-all {\d+(\.\d+)?} {pi vale 3.1415, e vale 2.7182}))
;-> (3.1415 2.7182) una lista di floating-point

Quando convertiamo un numero possiamo specificare un valore di default nel caso la conversione fallisca:

(int "x")
;-> nil

(int "x" 0)
;-> 0

Possiamo convertire un numero in un'altra base, ad esempio convertire una stringa esadecimale nel numero corrispondente in base 10:

(int "1F" 0 16) dobbiamo specificare il valore di default "0" e la base del numero "16"
;-> 31

oppure (prefisso "0x"):

(int "0x1F")
;-> 31

Conversione di un numero binario:

(int "1001001001010010010000000000000000" 0 2)
;-> 9819455488

oppure (prefisso "0b"):

(int "0b1001001001010010010000000000000000")
;-> 9819455488

Conversione di un numero ottale:

(int "35" 0 8)
;-> 29

oppure (prefisso "0"):

(int "035")
;-> 29

Alcune funzioni convertono automaticamente numeri floating-point in numeri interi e viceversa.
Se utilizziamo operatori composti da lettere dell'alfabeto, allora newLISP converte i numeri in floating-point.
Se utilizziamo operatori speciali (es. +, -, *, /), allora newLISP converte i numeri in interi.

(setq reale (sqrt 2))
;-> 1.414213562373095
(float? reale)
;-> true

(setq intero 2)
;-> 2
(integer? intero)
;-> true

Risultato di tipo intero:

(setq res (+ intero reale))
;-> 3
(float? res)
;-> nil
(integer? res)
;-> true

Risultato di tipo floating-point:

(setq res (add intero reale))
;-> 3.414213562373095
(float? res)
;-> true
(integer? res)
;-> nil

Risultato di tipo floating-point:

(setq num (inc intero))
;-> 3
(float? num)
;-> true
(integer? num)
;-> nil

Nella maggior parte dei casi le conversioni implicite non creano problemi.
Comunque in alcuni casi è possibile perdere precisione, per esempio se utilizziamo un numero intero molto grande con una funzione che lo converte in floating-point:

(format {%15.15f} (add 1 746575847474723219))
;-> "746575847474723200.000000000000000"

Nota: durante l'esecuzione del programma una variabile può assumere dei valori che hanno tipi diversi.


==============================================
 QUANTO SONO PRECISI I NUMERI FLOATING POINT?
==============================================

In questo documento vedremo solo informazioni pratiche sull'utilizzo dei numeri floating-point.
Per una trattazione più completa vedi:
https://en.wikipedia.org/wiki/Floating-point_arithmetic
https://floating-point-gui.de/
http://pages.cs.wisc.edu/~david/courses/cs552/S12/handouts/goldberg-floating-point.pdf

La filosofia di un numero floating-point è quella di essere "vicino abbastanza", piuttosto che memorizzare il valore vero. Questo è un compromesso tra velocità di esecuzione e accuratezza dei risultati.

Supponiamo di voler memorizzare il valore di pi greco con 20 decimali:

(constant 'PI 3.14159265358979323846)
;-> 3.141592653589793

(println PI)
;-> 3.141592653589793

Sembra che newLISP abbia eliminato 5 cifre della parte destra del numero!
In effetti sono stati memorizzate solo le 15 o 16 cifre più significative e le rimanenti 5 sono state scartate (quelle meno importanti).
Per vedere ome viene memorizzato questo numero all'interno di newLISP utilizziamo la funzione "format":

(format {%1.20f} PI)
;-> "3.14159265358979310000"

Adesso compariamo i numeri come stringhe e vediamo le differenze:

stringa con PI originale (con 20 cifre)
(setq pi-originale-str "3.14159265358979323846")
;-> "3.14159265358979323846")

numero floating-point convertito dalla stringa con PI originale
(setq pi (float pi-originale-str))
;-> 3.141592653589793

numero formattato (stringa) dal numero floating-point PI memorizzato
(setq numero-pi-str (format {%1.20f} pi))
;-> "3.14159265358979310000"

(println pi-originale-str " -> stringa PI originale")
(println pi " -> numero floating-point convertito dalla stringa PI originale")
(println numero-pi-str " -> numero formattato (stringa) dal numero floating-point ")
;-> 3.141592653589793 -> stringa PI originale
;-> 3.141592653589793 -> numero floating-point convertito dalla stringa PI originale
;-> 3.14159265358979310000 -> numero formattato (stringa) dal numero floating-point

(define (test)
  (dotimes (i (length pi-originale-str) (!= (pi-originale-str i) (numero-pi-str i)))
    (print (pi-originale-str i)))
(println " -> versione originale e versione memorizzata sono uguali fino a qui"))

(test)
;-> 3.141592653589793 -> versione originale e versione memorizzata sono uguali fino a qui

Il valore rimane accurato fino alle cifre 9793, poi le seguenti cifre non vengono memorizzate.
Questo è il modo in cui tutti i computer memorizzano i numeri floating-point, non dipende da newLISP.
Il numero floating-point più piccolo utilizzabile vale circa 2.2e-308.
Il numero floating-point più grande utilizzabile vale circa 1.8e+308.

         -1.8e308                 -2.2e-308            2.2e-308                     1.8e308
 ------------|--------------------------|------ 0 ------|--------------------------|------------
   Overflow  |  numeri rappresentabili  |   Underflow   |  numeri rappresentabili  |  Overflow


=============================================
 QUANTO SONO STRANI I NUMERI FLOATING-POINT?
=============================================

Facciamo una semplice somma:

(add 0.1 0.2)
;-> 0.3

Sembra tutto corretto, comunque se visualizziamo il numero con 20 cifre dopo la virgola:

(format {%1.20f} (add 0.1 0.2))
;-> "0.30000000000000004000"

Da dove è uscito quel 4?
Perché 0.1 + 0.2 non vale un preciso 0.3 e invece ottengo un risultato strano come 0.30000000000000004?
Perché internamente, i computer utilizzano un formato (binario a virgola mobile) che non può rappresentare con precisione un numero come 0.1, 0.2 o 0.3.
Il numero 0.1 viene memorizzato con il numero più vicino possibile in quel formato (floating-point).
Questo si traduce in un piccolo errore di arrotondamento ancor prima di effettuare il calcolo.
Quindi il risultato non è realmente 0.3, ma il valore più vicino rappresentabile nel formato floating-point.

Comunque le stranezze non sono terminate:

(sub (add 0.1 0.2) 0.3)
;-> 5.551115123125783e-017

Perchè non vale esattamente 0?
Perchè il numero 0.3 viene rappresentato in modo diverso dal numero 0.1 + 0.2.
Per capire il motivo vediamo il seguente esempio:

(setq a (add 0.1 0.2))
;-> 0.3

(setq b 0.3)
;-> 0.3

Vediamo come sono rappresentati con 20 cifre decimali dopo la virgola:

(format {%1.20f} a)
;-> "0.30000000000000004000"

(format {%1.20f} b)
;-> "0.29999999999999999000" il valore di b è diverso dal valore di a

Quindi abbiamo verificato che la rappresentazione floating point di 0.3 è diversa da quella del numero (0.1 + 0.2):

(sub a b)
;-> 5.551115123125783e-017

(sub 0.30000000000000004000 0.29999999999999999000)
;-> 5.551115123125783e-017

(format {%1.20f} (sub (add 0.1 0.2) 0.3))
"0.00000000000000005551"

Facciamo un altro esempio:

(add 0.1 0.4)
;-> 0.5

Visualizziamo il numero con 20 cifre dopo la virgola:

(format {%1.20f} (add 0.1 0.4))
;-> "0.50000000000000000000"

In questo caso il risultato (0.5) può essere rappresentato esattamente come un numero in virgola mobile, ed è anche possibile che gli errori di arrotondamento nei numeri di input si annullino a vicenda.

Per capire meglio, vediamo come vengono rappresentati i numeri da 0 a 1 con intervallo pari a 0.1:

(for (x 0 1 0.1) (println (format {%1.20f} x)))
;-> 0.00000000000000000000
;-> 0.10000000000000001000
;-> 0.20000000000000001000
;-> 0.30000000000000004000
;-> 0.40000000000000002000
;-> 0.50000000000000000000
;-> 0.60000000000000009000
;-> 0.70000000000000007000
;-> 0.80000000000000004000
;-> 0.90000000000000002000
;-> 1.00000000000000000000

Gli unici valori rappresentati in modo matematicamente corretto sono 0.0, 0.5 e 1.0.

Allora perchè utilizziamo questo sistema di rappresentazione?
1) Perchè i numeri binari sono i più veloci da trattare per i computer
2) Perchè nella maggior parte dei calcoli, un piccolo errore nella sedicesima posizione decimale non ha alcuna importanza, in quanto i numeri con cui si lavora non sono uguali (o comunque precisi)


================
 TIPI DI ERRORE
================

Dato un numero N e la sua rappresentazione M possiamo definire:

Errore = N - M

Errore Assoluto = abs(N - M)

Errore Relativo = abs(N - M) / abs(N)

Abbiamo bisogno di due tipi di errore (assoluto e relativo) per far fronte alla variabilità dei numeri, cioè per tener conto della magnitudine dei numeri.

Supponiamo di dover calcolare un numero piccolo sqrt(2)/e^20:

N = valore vero = 2.91491140698704220338218698754849111429863329048893 (50 cifre decimali)

M = valore calcolato = (div (sqrt 2) (exp 20)) = 2.914911406987042e-009

(format {%1.30f} (setq M (div (sqrt 2) (exp 20))))
;-> "0.000000002914911406987042300000"

Errore Assoluto =
= (2.91491140698704220338218698754849111429863329048893e-009 - 0.0000000029149114069870423) =
= -9.661781301245150888570136670951 × 10^-26

calcolato con Mathematica, poichè con newLISP:
(sub 2.91491140698704220338218698754849111429863329048893e-009 2.9149114069870423e-009)
;-> 0 per newLISP i due numeri sono uguali

Errore Relativo =
(2.91491140698704220338218698754849111429863329048893e-009 - 2.9149114069870423e-009) / 2.91491140698704220338218698754849111429863329048893e-009 =
= -3.314605472429063389421276668952 × 10^-17

calcolato con Mathematica, poichè con newLISP:
(div (sub 2.91491140698704220338218698754849111429863329048893e-009 2.9149114069870423e-009) 2.91491140698704220338218698754849111429863329048893e-009)
;-> 0 per newLISP i due numeri sono uguali

Supponiamo di dover calcolare un numero grande (e^(e^6)):

N = valore vero = 1.61027056677937207488718139872102038366075780678065 × 10^175 (50 cifre decimali)

M = valore calcolato = (setq M (exp (exp 6)))) = 1.610270566779352e+175

(format {%.3f} (setq M (exp (exp 6))))
"1610270566779352300000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000.000" = 1.6102705667793523e+175

Errore Assoluto =
= 1.61027056677937207488718139872102038366075780678065×10^175 - 1.610270566779352×10^175 =
= 2.007488718139872102038366075780678065 × 10^161

Errore Relativo =
= (1.61027056677937207488718139872102038366075780678065×10^175 - 1.610270566779352×10^175) / 1.61027056677937207488718139872102038366075780678065×10^175 =
= 1.2466778934890164076152223629835707813418896107248402 × 10^-14

Gli errori assoluti perdono di significato con l'aumentare della magnitudine dei numeri, cioè quando trattiamo con numeri grandi.


===========================
 PROPAGAZIONE DEGLI ERRORI
===========================

Mentre gli errori nei singoli numeri in virgola mobile sono molto piccoli, anche calcoli semplici su di essi possono contenere insidie ​​che aumentano l'errore nel risultato ben oltre l'avere i singoli errori "sommati".

In generale:

Moltiplicazione e divisione sono operazioni "sicure".
Addizione e sottrazione sono pericolose, perché quando sono coinvolti numeri di diversa grandezza, le cifre del numero di grandezza minore vengono perse.
Questa perdita di cifre può essere inevitabile e benigna (quando le cifre perse sono anche insignificanti per il risultato finale) o catastrofica (quando la perdita viene amplificata e distorce fortemente il risultato).
Più calcoli sono fatti (specialmente quando sono la base di un algoritmo iterativo) più è importante considerare questo tipo di problema.
Un metodo di calcolo può essere stabile (nel senso che tende a ridurre gli errori di arrotondamento) o instabile (ovvero gli errori di arrotondamento vengono ingranditi). Molto spesso, ci sono soluzioni stabili e instabili per un problema.
Esiste un intero sotto-campo della matematica (in analisi numerica) dedicato allo studio della stabilità numerica degli algoritmi. Per fare calcoli complessi che coinvolgono numeri in virgola mobile, è assolutamente necessario avere una certa comprensione di questa disciplina.
L'articolo "What Every Computer Scientist Should Know About Floating-Point Arithmetic" fornisce un'introduzione dettagliata anche se è necessario avere un background scientifico.


=====================================================
 RAPPRESENTAZIONE DEI NUMERI FLOATING POINT (32-bit)
=====================================================

Vediamo, come vengono rappresentati i numeri in floating-point (virgola mobile) secondo lo standard IEEE754.
Si consideri il numero reale 100.25(b10).
Esso può venire rappresentato come:

100.25 = 1 * (10)² + 0 * (10)¹ + 0 * (10)° + 2 * (10)¯¹ + 5 * (10)¯²

Analogamente, per il numero binario 101.001(b2) vale:

101.001(b2) =
 = 1 * (2)² + 0 * (2)¹ + 1 * (2)° + 0 * (2)¯¹ + 0 * (2)¯² + 1 *(2)¯³ =
 = (2)² + (2)° +(2)¯³ =
 = 5.125(b10)

Il numero reale 100.25(b10) espresso secondo la notazione scientifica è:

 1.0025 * 10²

dove 1.0025 è la mantissa, 10 è la base del sistema di numerazione e ² è l' esponente.
Anche in binario vale la stessa cosa.

Si consideri il numero binario corrispondente a 5.625, ovvero:

101.101(b2) = 1.01101(b2) * (2²)(b10)

dove 1.011101 è la mantissa, 2 è la base del sistema binario (in questo caso espressa in
base 10) e ² è l' esponente (anch'esso espresso in base 10).

Lo standard IEE754 prevede, per i numeri binari in virgola mobile a 32-bits (quattro bytes), la seguente rappresentazione:

X       XXXXXXXX    XXXXXXXXXXXXXXXXXXXXXXX
Segno   Esponente   Mantissa
1 bit   8 bit       23 bit

Campo Segno
Il primo campo della rappresentazione IEE754, lungo un bit, rappresenta il segno del numero binario. Se vale 0 indica che il numero è positivo, se vale 1 indica che il numero è negativo.
Il numero 1.01101(2b) * (2²)(10b) è positivo per cui questo campo deve valere 0 come illustrato nella figura seguente:

0 XXXXXXXX XXXXXXXXXXXXXXXXXXXXXXX

Campo Esponente
Il secondo campo, lungo otto bit (un byte), rappresenta l'esponente del numero binario espresso in notazione scientifica. Come è noto, un byte può assumere valori che vanno da 0 a 255. Come si fa per rappresentare gli esponenti negativi? Per poter rappresentare sia gli esponenti positivi che negativi si usa, per questo campo, la notazione eccesso 127. Quest'ultima prevede che al vero esponente vada sommato 127. Perciò, per il numero 1.01101(2b) * (2²)(10b) l'esponente da inserire nel secondo campo della rappresentazione vale: 2 + 127 = 129 ovvero in binario: 1000 0001.

0 1000 0001 XXXXXXXXXXXXXXXXXXXXXXX

Campo Mantissa
Il terzo campo, lungo ventitrè bits, rappresenta la mantissa del numero binario spresso in notazione scientifica. Nel caso in esame vale 1.01101. A questo punto occorre notare che tutti i numeri binari espressi in notazione scientifica hanno un “1” prima della virgola, per cui nella rappresentazione IEE754 questo viene sottointeso. Inoltre, al valore effettivo della mantissa dell'esempio: 01101, vengono aggiunti tanti “0” quanti ne servono per completare il campo a 23 bits è perciò si ha:

0110100 00000000 00000000

In definitiva il numero 101.101(b2) = 1.01101(b2) * (2²)(10) viene rappresentato ,in floating point, nel modo seguente:

0 1000 0001 0110100 00000000 00000000

Riarrangiando i 32-bits della rappresentazione come quattro byte si ha:

0100 0000 1011 0100 0000 0000 0000 0000(b2)

che in esadecimale equivale a:

40 B4 00 00

Nota: La codifica IEEE754 è complicata dalla necessità di rappresentare alcuni valori particolari:
1) NaN (Not a Number, risultato di operazioni non ammesse, es. 0/0)
2) +∞ e -∞ (es. 3/0 = infinito)
3) Il valore 0 (meno banale di quanto sembri)

Proprietà fondamentale della codifica
NB. I circa 4 miliardi di configurazioni (usati a 32-bit) consentono di coprire un campo di valori molto ampio grazie alla distribuzione non uniforme:
1) per numeri piccoli in valore assoluto i valori rappresentati sono «fitti»,
2) per numeri grandi in valore assoluto i valori rappresentati sono «diradati»

-∞---------------------------------------------0---------------------------------------------+∞
 |      |     |     |    |    |   |   | | | ||||||| | | |   |   |    |    |     |     |      |

newLISP rappresenta e usa tutti i numeri floating point in precisione doppia (double a 64-bit).

Nota: Si osservi che nell’intervallo [0.125, 0.25) abbiamo 2 numeri.
Nell’intervallo [0.25, 0.5), che è il doppio di quello precedente abbiamo ancora 2 numeri.
Nell’intervallo [0.5, 1) che è ancora il doppio di quello precedente abbiamo la possibilità di rappresentare ancora 2 numeri.
Nell’intervallo [1, 2) abbiamo infine ancora 2 numeri.
Man mano che ci muoviamo nella direzione crescente di valori in potenze di due (da 0.125 a 2) la densità dei numeri diminuisce. Abbiamo quindi una distribuzione non uniforme.
Questa considerazione ci fa pensare al concetto di precisione.
Nell’intervallo [0.125, 0.25) possiamo rappresentare solo 0.125 e 0.1875, ma non possiamo rappresentare l’entità 0.1415 se non attraverso un errore in difetto (0.125) o in eccesso (0.1875).
È evidente che non potremo rappresentare perfettamente tutti i numeri reali ma ci dovremo accontentare di un’approssimazione, tanto più efficiente quanti più bit destiniamo alla mantissa.

Complessità dei calcoli
Senza voler entrare in dettaglio basti osservare che supponendo che per la somma fra 2 numeri in virgola fissa ci voglia un tempo di 1 microsecondo (1 milionesimo di secondo), per la somma di 2 numeri in virgola mobile ci vogliono almeno 10 microsecondi (dovendo fare una quantità molto elevata di operazioni la differenza in termini di tempo non è per nulla trascurabile).


=================
 MACHINE EPSILON
=================

Il "machine epsilon" è il più piccolo numero ε, appartenente a un dato insieme F di numeri in virgola mobile, diverso in valore assoluto da zero, che sommato all'unità, dà un risultato diverso da 1.
Se prendiamo due numeri in F, per esempio a e b, per cui nell'insieme dei corrispondenti reali

 a - b < ε,

si ottiene nel detto insieme F

 a - b = 0

e si verifica un fenomeno di cancellazione dei dati.
Questo è dovuto al fatto che l'implementazione dell'aritmetica in virgola mobile nei comuni microprocessori è approssimata a causa della dimensione finita dei registri nei quali vengono memorizzati risultati e operandi.
Tale numero rappresenta la distanza tra 1 e il numero successivo rappresentabile in floating point, cioè secondo la precisione della macchina.
In altre parole "machine epsilon ε" è definito come il più piccolo numero tale che: ((1 + ε) > 1).
Si tratta della differenza tra 1 e il più vicino numero successivo rappresentabile in floating point.
Facciamo un esempio:
supponiamo di avere un sistema ad 8 bit che memorizza un numero reale con il primo bit che rappresenta il segno, i successivi tre bit rappresentano l'esponente e gli ultimi quattro bit la mantissa.
Il numero 1 in base 10 è rappresentato da:

| 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0

Il numero binario successivo è rappresentato da:

| 0 | 0 | 1 | 1 | 0 | 0 | 0 | 1

e vale 1.0625.

Quindi il machine epsilon vale: ε = 1.0625 - 1 = 0.0625

Possiamo scrivere una funzione che calcola il valore di machine epsilon per newLISP:

primo metodo:

(define (machine-epsilon1)
  (setq eps '()) lista per memorizzare la sequenza calcolata di machine epsilon
  (setq u 1.0)
  (while (!= 1.0 (add 1 u))
    (setq u (mul u 0.5))
    (push u eps))
  (println "machine epsilon: " (eps 0))
  eps
)

(machine-epsilon1)
;-> 1.110223024625157e-016

secondo metodo:

(define (machine-epsilon2)
  (setq eps 1.0)
  (while (> (add 1.0 eps) 1.0)
    (setq eps (div eps 2.0)))
  (println "machine epsilon: " eps)
)

(machine-epsilon2)
;-> 1.110223024625157e-016

Dal punto di vista dei calcoli numerici, il machine epsilon rappresenta il limite superiore dell'errore assoluto relativo alla rappresentazione di un numero.
In altre parole, l'errore assoluto relativo alla rappresentazione di un numero è sempre inferiore al machine epsilon.

Abbiamo visto che "machine epsilon ε" è definito come il più piccolo numero tale che: ((1 + ε) > 1).
Se utilizziamo un altro numero iniziale per il confronto (cioè tale che ((N + ε) > 1)) otteniamo un risultato diverso:

(define (machine-epsilonN num)
  (setq eps 1.0)
  (while (> (add num eps) num)
    (setq eps (div eps 2.0)))
  (println "machine epsilon: " eps)
)

(machine-epsilonN 1)
;-> 1.110223024625157e-016

(machine-epsilonN 10)
;-> 8.881784197001252e-016

(machine-epsilonN 100000)
;-> 7.275957614183426e-012

Come potete notare il machine-epsilon cambia in funzione della magnitudine del numero considerato (non è un valore stabile), in particolare il suo valore aumenta con l'aumentare del numero N considerato. Questo significa che la distanza nella rappresentazione floating-point di due numeri adiacenti non è costante. In altre parole:
1) per numeri piccoli in valore assoluto i valori rappresentati sono «fitti»
2) per numeri grandi in valore assoluto i valori rappresentati sono «diradati»

-∞---------------------------------------------0---------------------------------------------+∞
 |      |     |     |    |    |   |   | | | ||||||| | | |   |   |    |    |     |     |      |

Nota: il numero macchina (che è diverso dal machine-epsilon) viene definito come: nm = (b^(1-m))/2
dove:
b -> base
m -> mantissa


=========================
 INFINITO E NOT A NUMBER
=========================

Lo standard IEEE 754 per i numeri floating-point definisce, oltre i numeri ordinari, anche due numeri particolari: INF e NaN.
Si tratta di numeri con valore Infinito e di numeri che...non sono numeri (Not a Number).
In alcuni linguaggi la divisione per 0 genera un errore di sistema, mentre in newLISP genera il valore Infinito:

(setq a-inf (div 1 0))
;-> 1.#INF

(setq a-inf-neg (div -1 0))
;-> -1.#INF

(setq a-NaN (sqrt -1))
;-> -1.#IND


=====================================
 CONFRONTO TRA NUMERI FLOATING-POINT
=====================================

La matematica a virgola mobile non è esatta. Valori semplici come 0.1 non possono essere rappresentati con precisione usando numeri floating-point binari, e la precisione limitata di questa rappresentazione significa che lievi cambiamenti nell'ordine delle operazioni o la precisione dei valori intermedi possono cambiare il risultato. Ciò significa che confrontare due numeri floating-point per vedere se sono uguali di solito non sempre genera un risultato corretto.

Il compilatore GCC ha anche un avvertimento per questo:

"Avviso: confrontare i numeri in virgola mobile con == oppure != non è sicuro".

Vediamo con un esempio alcuni dei problemi che possiamo incontrare.
In questo caso produciamo il numero 1 in tre modi differenti:
1. partendo da 0.0 sommiamo 0.1 per 10 volte.
2. partendo da 2.0 sottraiamo 0.1 per 10 volte.
3. moltiplichiamo 0.1 per 10.

(setq f 0.1)
(setq val1 0.0)
(setq val2 2.0)
(for (i 1 10) (setq val1 (add val1 f)))
(for (i 1 10) (setq val2 (sub val2 f)))
(setq val3 (mul f 10))
(println (format {%1.20f %1.20f %1.20f} val1 val2 val3))
;-> 0.99999999999999989000 0.99999999999999922000 1.00000000000000000000

Otteniamo tre risultati differenti e il loro confronto non è quello che volevamo:

(= val1 val2)
;-> nil
(= val2 val3)
;-> nil
(= val1 val3)
;-> nil

Come possiamo confrontare due numeri floating point?

Se confrontare i float per l'uguaglianza è una cattiva idea, allora come controllare se la loro differenza rientra nei limiti di errore o in un valore di epsilon, come questo:

se (abs(val1 - val2) <= epsilon) allora i due numeri sono (quasi) uguali.

Con questo calcolo possiamo esprimere il concetto di due float abbastanza vicini da considerarli uguali. Ma quale valore dovremmo usare per epsilon?

Data la nostra sperimentazione sopra, potremmo essere tentati di usare il machine-epsilon.
Comunque abbiamo anche visto che questo non è un valore costante, ma dipende dalla magnitudine (grandezza) dei numeri. Purtroppo non abbiamo altri numeri epsilon da utilizzare, quindi invece della differenza assoluta dobbiamo usare una comparazione relativa di epsilon e dei valori. L'idea di un confronto relativo epsilon è trovare la differenza tra i due numeri e vedere quanto è grande rispetto alla loro grandezza. Non c'è una risposta semplice a questo problema, ma per ottenere risultati coerenti, devi sempre confrontare la differenza con il più grande dei due numeri. In altre parole: per confrontare f1 e f2 occorre calcolare diff = abs (f1-f2). Se diff è inferiore a n% di max(abs(f1), abs(f2)) allora f1 e f2 possono essere considerati uguali.
La risposta più generica a questo dilemma consiste nell'utilizzare una miscela di epsilon assoluti e relativi. Se i due numeri confrontati sono estremamente vicini - qualunque cosa significhi - trattali come uguali, indipendentemente dai loro valori relativi. Questa tecnica è necessaria ogni volta che ti aspetti una risposta prossima a zero a causa della sottrazione. Il valore di epsilon assoluto deve essere basato sulla grandezza dei numeri da sottrarre (es. maxInput * machine-epsilon). Sfortunatamente ciò significa che l'uguaglianza tra due numeri dipende dall'algoritmo e dai numeri di input.

La funzione finale per confrontare due numeri floating-point è la seguente:

(define (almostEqual x y maxDiff (maxRelDiff 1e-9))
  (local (diff a b largest)
    (setq diff (abs (sub x y))) ;controlla i numeri vicini allo zero
    (setq a (abs x))
    (setq b (abs y))
    (setq largest (if (> b a) b a))
    (if (<= diff maxDiff) true
        (if (<= diff (mul largest maxRelDiff)) true nil))
  )
)

(almostEqual 1 1.000001 1e-6)
;-> true

(almostEqual 1 1.000001 1e-12)
;-> nil

Una formulazione diversa, ma fondamentalmente equivalente, è la seguente funzione:

(define (nearlyEqual a b epsilon)
  (local (absA absB diff)
    (setq Float.MAX_VALUE 3.402823466E38)
    (setq Float.MIN_NORMAL 1.175494351E-45)
    (setq absA (abs a))
    (setq absB (abs b))
    (setq diff (abs (sub a b))) ;controlla i numeri vicini allo zero
    (cond ((= a b) true) ; controlla i numeri infiniti
          ; se a o b valgono 0 o sono molto vicini a 0,
          ; allora l'errore relativo non è significativo
          ((or (zero? a) (zero? b) (< diff Float.MIN_NORMAL))
              (< diff mul(epsilon Float.MIN_NORMAL)))
          ; altrimenti usiamo l'errore relativo
          (true (< (div diff (min (add absA absB) Float.MAX_VALUE)) epsilon))
    )
  )
)

con i seguenti valori:

Double.MIN_NORMAL = 2^-1022 =
= 2.225073858507201383090232717332404064219215980462331... × 10^-308
Double.MIN_VALUE = 2^-1074 =
= 4.940656458412465441765687928682213723650598026143247... × 10^-324
Double.MAX_VALUE = (2 - 2^-52)·2^1023 =
= 1.7976931348623157081452742373170435679807056752584499... × 10^308
Float.MIN_NORMAL = 2^-126 =
= 1.1754943508222875079687365372222456778186655567720875... × 10^-38
Float.MIN_VALUE = 2^-149 =
= 1.4012984643248170709237295832899161312802619418765157... × 10^-45
Float.MAX_VALUE = (2 - 2^-23) * 2^127 =
= 3.4028234663852885981170418348451692544 × 10^38

(nearlyEqual 1 1.000001 1e-6)
;-> true

(nearlyEqual 1 1.000001 1e-12)
;-> nil

Questa funzione è valida nella maggior parte dei casi, anche se non è sempre commutativa:

(nearlyEqual a b) != (nearlyEqual b a)

Questo metodo supera i test per molti casi speciali importanti, come puoi vedere ha una logica abbastanza consistente. In particolare, occorre usare una definizione completamente diversa del margine di errore quando a o b è zero, perché in quei casi la definizione classica di errore relativo diventa priva di significato.

Ci sono alcuni casi in cui il metodo sopra produce ancora risultati imprevisti (in particolare, è molto più severo quando un valore è quasi zero rispetto a quando è esattamente zero), e alcuni dei test che sono stati sviluppati per il controllo evidenziano un comportamento che non è adatto per alcune applicazioni. Prima di usarlo, assicuratevi che sia appropriato per la vostra applicazione!

Se non siete soddisfatti di queste informazioni pratiche, potete consultate il libro: "Numerical Computing with IEEE Floating Point Arithmetic" di Michael Overton.


==========================================
 VERIFICA DELLE OPERAZIONI FLOATING-POINT
==========================================

Nel codice sorgente di newLISP possiamo trovare uno script che verifica l'aderenza di newLISP allo standard IEEE 754 nelle operazioni floating-point.
Il file si chiama "qa-float.lsp" ed è riportato di seguito:

;------------------------------------------------------
#!/usr/bin/env newLISP

; Test IEEE compliance of some FP operations and handling of 'inf' and 'NaN'
; numbers. In all versions of newLISP (32Bit and 64Bit) floating point numbers
; are represented as IEE 754 64-bit: Double (binary64) numbers.

; Thanks to Nelson H.F. Beebe <beebe@math.utah.edu> for some of the tests
; in this file

(println)
(println "Testing floating point performance")
(set-locale "C")
(set 'aNan (sqrt -1))
(set 'aInf (div 1.0 0))
(set 'aNegInf (div -1 0))
; operation on NaN result in NaN
(set 'tests '(
  "operation on NaN result in NaN"
  (NaN? (mul 1.0 aNan))
  (NaN? (div 1.0 aNan))
  (NaN? (add 1.0 aNan))
  (NaN? (sub 1.0 aNan))
  (NaN? (sin aNan))
  (NaN? (cos aNan))
  (NaN? (tan aNan))
  (NaN? (atan aNan))
  "comparison with NaN is always nil"
  (not (< 1.0 aNan))
  (not (> 1.0 aNan))
  (not (>= 1.0 aNan))
  (not (<= 1.0 aNan))
  (not (= aNan aNan))
  "NaN is not equal to itself"
  (not (= aNan aNan))
  "integer operations assume NaN as 0"
  (= (- 1 aNan) 1)
  (= (+ 1 aNan) 1)
  (= (* 1 aNan) 0)
  (not (catch (/ 1 aNan) 'error))
  (= (>> aNan) 0)
  (= (<< aNan) 0)
  "integer operations assume inf as max-int"
  (= (* 1 aInf) 9223372036854775807)
  (= (- aInf 1) 9223372036854775806)
  (= (+ aInf 1) -9223372036854775808) ; wrap around
  "FP division by inf results in 0"
  (= (/ 1 aInf) 0)
  (= (div 1 aInf) 0)
  "inf specials"
  (= aInf aInf)
  (NaN? (sub aInf aInf))
  "retain sign of -0.0"
  (= (set 'tiny (div -1 aInf)) -0.0)
  (= (sqrt tiny) -0.0)
    (= (div -1 (div 1.0 0)) -0.0)
  "inf is signed too"
  (= aNegInf (div -1 0))
  (!= aNegInf (div 1 0))
    (= (int aNegInf) -9223372036854775808)
  "mod with 0 divisor is NaN"
  (NaN? (mod 10 0))
  "% with 0 divisor throws error"
  (not (catch (% 10 0) 'error))
  )
)
(dolist (t tests)
  (if (string? t)
    (println (format "\n%-47s\n%s" t (dup "-" 47)))
    (let (result (eval t))
      (println (format "%40s => %s" (string t) (string result)))
      (push result result-list))
  )
)
(println)
(set 'result '())
(set 'u 1.0)
(while (> u 0.0) (set 'u (mul u 0.5)) (push u result))
(println "support of subnormals: " (0 2 result) " => (0 4.940656458e-324)")
(set 'epsilon 1.0)
(while (!= 1.0 (add 1.0 epsilon))
    (set 'epsilon (mul epsilon 0.5))
)
(println "machine epsilon: " epsilon  " => 1.110223025e-16")
(println)
(if
    (and
         ;(= 2.2250738585072007e-308 2.2250738585072011e-308) ; true on OSX nil on FreeBSD and Win232
         ;(= 2.2250738585072011e-308 2.2250738585072012e-308) ; true on FreeBSD and Win32 nil on OSX

         ;(= (bits (first (unpack "Lu" (pack "lf" 2.2250738585072007e-308)))) ; true on FreeBSD and Win32 nil OSX
         ;"1111111111111111111111111111111111111111111111111110")
         ;(= (bits (first (unpack "Lu" (pack "lf" 2.2250738585072007e-308)))) ; true on OSX nil on FreeBSD and Win32
         ;"1111111111111111111111111111111111111111111111111111")

         ;(= (bits (first (unpack "Lu" (pack "lf" 2.2250738585072011e-308)))) ; true on OSX and Win32 nil on FreeBSD
         ;"1111111111111111111111111111111111111111111111111111") ; 52 bits
         ;(= (bits (first (unpack "Lu" (pack "lf" 2.2250738585072011e-308)))) ; true on FreeBS nil on OSX and Win32
         ;"10000000000000000000000000000000000000000000000000000") ; 53 bits

         ; work on FreeBSD and OSX but not on Win32 XP
;         (= (bits 2.2250738585072007e-308) "0")
;         (= (bits (first (unpack "Lu" (pack "lf" 2.2250738585072012e-308))))
;         "10000000000000000000000000000000000000000000000000000")  ; 53 bits

         ; works on FreeBSD, OSX and Win32
         (= (bits (first (unpack "Lu" (pack "lf" (sqrt -1)))))
         "1111111111111000000000000000000000000000000000000000000000000000") ; 64-bits
    )
    (println "bit patterns OK")
    (println "problems in bit patterns")
)
(println)
(if-not (apply and result-list)
  (println ">>>>> PROBLEM in floating point tests")
  (println ">>>>> Floating point tests SUCCESSFUL")
)
;(exit)

L'esecuzione di questo script (load "qa-float.lsp") genera il seguente output:

-----------------------------------------------
Testing floating point performance

operation on NaN result in NaN
-----------------------------------------------
                     (NaN? (mul 1 aNan)) => true
                     (NaN? (div 1 aNan)) => true
                     (NaN? (add 1 aNan)) => true
                     (NaN? (sub 1 aNan)) => true
                       (NaN? (sin aNan)) => true
                       (NaN? (cos aNan)) => true
                       (NaN? (tan aNan)) => true
                      (NaN? (atan aNan)) => true

comparison with NaN is always nil
-----------------------------------------------
                        (not (< 1 aNan)) => true
                        (not (> 1 aNan)) => true
                       (not (>= 1 aNan)) => true
                       (not (<= 1 aNan)) => true
                     (not (= aNan aNan)) => true

NaN is not equal to itself
-----------------------------------------------
                     (not (= aNan aNan)) => true

integer operations assume NaN as 0
-----------------------------------------------
                        (= (- 1 aNan) 1) => true
                        (= (+ 1 aNan) 1) => true
                        (= (* 1 aNan) 0) => true
         (not (catch (/ 1 aNan) 'error)) => true
                         (= (>> aNan) 0) => true
                         (= (<< aNan) 0) => true

integer operations assume inf as max-int
-----------------------------------------------
      (= (* 1 aInf) 9223372036854775807) => true
      (= (- aInf 1) 9223372036854775806) => true
     (= (+ aInf 1) -9223372036854775808) => true

FP division by inf results in 0
-----------------------------------------------
                        (= (/ 1 aInf) 0) => true
                      (= (div 1 aInf) 0) => true

inf specials
-----------------------------------------------
                           (= aInf aInf) => true
                  (NaN? (sub aInf aInf)) => true

retain sign of -0.0
-----------------------------------------------
        (= (set 'tiny (div -1 aInf)) -0) => true
                      (= (sqrt tiny) -0) => true
               (= (div -1 (div 1 0)) -0) => true

inf is signed too
-----------------------------------------------
                  (= aNegInf (div -1 0)) => true
                  (!= aNegInf (div 1 0)) => true
  (= (int aNegInf) -9223372036854775808) => true

mod with 0 divisor is NaN
-----------------------------------------------
                       (NaN? (mod 10 0)) => true

% with 0 divisor throws error
-----------------------------------------------
           (not (catch (% 10 0) 'error)) => true

support of subnormals: (0 4.940656458412465e-324) => (0 4.940656458e-324)
machine epsilon: 1.110223024625157e-016 => 1.110223025e-16

bit patterns OK

>>>>> Floating point tests SUCCESSFUL
-----------------------------------------------

========================
 UNA STRANA SUCCESSIONE
========================

Sebbene newLISP implementi lo standard IEEE 754 correttamente, esistono dei calcoli che non producono il risultato corretto (casi molto rari).
Ad esempio prendiamo la seguente successione:

u(0) =  2

u(1) = -4
               1130           3000
u(n) = 111 - -------- + -----------------   per n >= 2
              u(n-1)     u(n-1) * u(n-2)

Scriviamo una funzione che calcola questa successione:

(define (test-successione n)
  (setq u0 2.0)
  (setq u1 -4.0)
  (for (i 3 n 1)
      (setq w (add (sub 111.0 (div 1130.0 u1)) (div 3000.0 (mul u1 u0))))
      (setq u0 u1)
      (setq u1 w)
      (println (format {n = %d     u = %1.17g} i u1))
  )
)

(test-successione 31)

Analizzando i valori troviamo che il risultato non è corretto:

 n     Valore calcolato               Valore esatto (calcolato con Mathematica)
  3    18.5                           18.5
  4     9.378378378378379               9.3783783783783783783...
  5     7.8011527377521688              7.8011527377521613833...
  6     7.1544144809753334              7.1544144809752493535...
 11     6.2744386627281159              6.2744385982163279138...
 12     6.2186967685821628              6.2186957398023977883...
 16     6.1660865595980994              6.0947394393336811283...
 17     7.2350211655349312              6.0777223048472427363...
 18    22.062078463525793               6.0639403224998087553...
 19    78.575574887872236               6.0527217610161521934...
 20    98.349503122165359               6.0435521101892688678...
 21    99.898569266182903               6.0360318810818567800...
 22    99.993870988902785               6.0298473250239018567...
 23    99.999630387286345               6.0247496523668478987...
 30    99.999999999998934               6.0067860930312057585...
 31    99.999999999999929               6.0056486887714202679...

Che cosa è successo?

La spiegazione di questo strano fenomeno è abbastanza semplice.
In generale la soluzione per la successione sopra definita vale:

        A*100^(n+1) + B*6^(n+1) + C*5^(n+1)
u(n) = -------------------------------------
             A*100^n + B*6^n + C*5^n

dove A, B e C dipendono dai valori iniziali u0 e u1.
Pertanto, se A = 0, allora il limite della sequenza è 100, altrimenti (assumendo B = 0), è 6.
Nell' esempio, sono stati scelti i valori iniziali u0 = 2 e u1 = -4 in modo che A = 0 e B/C = -3/4.
Pertanto, il limite esatto di u(n) è 6.
Eppure, quando si calcolano i valori usando il nostro programma, l'aritmetica floating-point utilizzata produce piccoli errori di arrotondamento, e anche i primi termini calcolati sono leggermente differenti da quelli esatti.
In questo caso, il valore di A corrispondente a questi calcoli è molto piccolo, ma diverso da zero. Questo è sufficiente per far convergere la successione al numero errato 100.

Bisogna sempre stare attenti!


===================
 OPERAZIONI SICURE
===================

Consideriamo le operazioni (add, sub, mul e div) e due numeri floating-point x e y.
In generale il risultato di una operazione (es. (add x y)) può considerarsi come il risultato esatto dell’operazione tra x ed y seguito dall’arrotondamento o dal troncamento.
Quindi è improbabile che l’esatto valore di (add x y) sia un numero floating-point.
Mentre gli errori nei singoli numeri in virgola mobile sono molto piccoli, anche calcoli semplici su di essi possono contenere insidie che aumentano l'errore nel risultato ben oltre l'avere i singoli errori "sommati".
Per cercare di contenere la propagazione degli errori ricordiamo le seguenti regole generali:

Moltiplicazione e divisione sono operazioni "sicure".

Addizione e sottrazione sono pericolose, perché quando sono coinvolti numeri di diversa ampiezza, le cifre del numero di grandezza minore vengono perse.

Questa perdita di cifre può essere inevitabile e benigna (quando le cifre perse sono anche insignificanti per il risultato finale) o catastrofica (quando la perdita viene amplificata e distorce fortemente il risultato).
Più calcoli sono fatti (specialmente quando formano un algoritmo iterativo) più è importante considerare questo tipo di problema.
Un metodo di calcolo può essere stabile (nel senso che tende a ridurre gli errori di arrotondamento) o instabile (ovvero gli errori di arrotondamento vengono ingranditi). Molto spesso, ci sono soluzioni stabili e instabili per un problema.


=======================
 QUANTO VALE PI GRECO?
=======================

newLISP non definisce alcun valore costante per pi greco.
Comunque possiamo trovarlo utilizzando le funzioni trigonometriche inverse:

(setq pi1 (mul 2.0 (acos 0.0)))
;-> 3.141592653589793
(format {%1.20f} pi1)
;-> "3.14159265358979310000"

(setq pi2 (mul 2.0 (asin 1.0)))
3.141592653589793
(format {%1.20f} pi2)
;-> "3.14159265358979310000"

Un test abbastanza conosciuto per verificare la correttezza dei numeri floating point è il calcolo della seguente espressione:

((e^pi) - pi)

(format {%1.20f} (sub (exp 3.1415926535897931) 3.1415926535897931))
;-> "19.99909997918947400000"

Il valore esatto dell'espressione calcolato con mathematica (con 60 cifre):

19.99909997918947576726644298466904449606893684322510617247

Quindi abbiamo un errore pari a (calcolato con newLISP):

(sub 19.99909997918947576726644298466904449606893684322510617247 19.99909997918947400000)
;-> 3.552713678800501e-015

Invece con mathematica l'errore calcolato vale:

1.76726644298466904449606893684322510617247e-15


==================================
 QUANTO VALE IL NUMERO DI EULERO?
==================================

newLISP non definisce alcun valore costante per il numero di Eulero "e".
Comunque possiamo trovarlo utilizzando la funzione esponenziale:

(exp x) -> e^x

(setq e (exp 1))
;-> 2.718281828459045

(format {%1.20f} e)
;-> "2.71828182845904510000"

Il valore esatto dell'espressione calcolato con mathematica (con 50 cifre):

2.71828182845904523536028747135266249775724709369995

Possiamo scrivere una funzione per calcolare il valore del numero "e" utilizzando la formula che rappresenta "e" come somma di una serie infinita: e = sum [1/k!] (k da 0 a infinito)

Scriviamo prima la funzione cha calcola il fattoriale:

(define (fattoriale n)
  (setq fact 1)
  (for (x 1 n)
    (setq fact (mul fact x))
  );for end
)

Poi scriviamo la funzione che calcola "e":

(define (print-e)
  (setq eps 1e-15) ;precisione (deve essere maggiore di machine-epsilon)
  (setq n 1)
  (setq res 1.0)  ;valore iniziale del risultato
  (setq res0 0.0) ;valore precedente del risultato
  ; Continua il calcolo fino a che il valore assoluto della differenza tra
  ; il risultato attuale e quello precedente è maggiore del valore della precisione (eps)
  (while (>= (abs (sub res res0)) eps)
    (setq res0 res)
    (setq res (add res (div 1 (fattoriale n))))
    (setq n (add n 1))
    ;(println res { ### } n)
  )
  res
)

(print-e)
;-> 2.718281828459046

Con un errore rispetto al valore fornito da newLISP pari a:

(sub (exp 1) (print-e))
;-> -4.440892098500626e-016


=====================
 TEMPO DI ESECUZIONE
=====================

Per calcolare il tempo di esecuzione di una funzione o di una espressione possiamo usare la macro "time".
La macro ha la seguente sintassi:

(time exp [int-count])

Valuta l'espressione "exp" e restituisce il tempo dedicato alla valutazione in millisecondi.
Il parametro opzionale "int-count" determina quante volte deve essere eseguita la valutazione dell'espressione exp.

Calcoliamo il tempo di esecuzione dell'espressione (add 0 1):

(time (add 0 1))
;-> 0

Questo non significa che il tempo di valutazione sia 0 (zero), ma che è inferiore ad 1 millisecondo.
Se ripetiamo la valutazione per 10 milioni di volte:

(time (add 0 1) 10000000)
;-> 312.519

Otteniamo un tempo di valutazione pari a 312.519 millisecondi.

Quindi il tempo di esecuzione dell'espressione vale (circa):

(div (time (add 0 1) 10000000) 10000000)
;-> 3.12497e-005 millisecondi

Nota: nei sistemi windows la precisione della macro "time" è di 16 msec (circa).


==================
 LISTA O VETTORE?
==================

newLISP mette a disposizione sia le liste che i vettori (anche multidimensionali). In genere la soluzione di un problema può essere fatta utilizzando una delle due strutture dati (o anche entrambe). La scelta dipende dai gusti personali anche se in genere l'algoritmo di soluzione utilizza una struttura dati specifica.
A noi però interessa sapere quale struttura è più veloce nel gestire i dati.
Per confrontare la velocità tra le liste e i vettori possiamo utilizzare il seguente programma:

; codice modificato dall'originale del libro "Introduction to newLISP"
(for (size 25 100)
  ; crea un vettore con valori random
  (set 'vettore (array size (randomize (sequence 0 size))))
  ; crea una lista con valori random
  (set 'lista (randomize (sequence 0 size)))
  ; ripete 10000 volte per avere un tempo diverso da zero
  (set 'tempo-vettore
    (int (time (dotimes (x (/ size 2))
      (nth x vettore)) 100000)))
  ; ripete 10000 volte per avere un tempo diverso da zero
  (set 'tempo-lista
    (int (time (dotimes (x (/ size 2))
      (nth x lista)) 100000)))
  (println size " elementi: tempo vettore: " tempo-vettore
    " - tempo lista: " tempo-lista
    " - l/v: " (div tempo-lista tempo-vettore )))

Riportiamo solo una parte dei risultati che dipendono (in valore assoluto) dalla velocità del computer:

25 elementi: tempo vettore: 62 - tempo lista: 62 - l/v: 1
...
50 elementi: tempo vettore: 109 - tempo lista: 140 - l/v: 1.28
...
75 elementi: tempo vettore: 156 - tempo lista: 234 - l/v: 1.5
...
100 elementi: tempo vettore: 218 - tempo lista: 343 - l/v: 1.57
...
125 elementi: tempo vettore: 265 - tempo lista: 453 - l/v: 1.70
...
150 elementi: tempo vettore: 343 - tempo lista: 625 - l/v: 1.82
...
175 elementi: tempo vettore: 390 - tempo lista: 781 - l/v: 2.00
...
200 elementi: tempo vettore: 421 - tempo lista: 968 - l/v: 2.29
...
225 elementi: tempo vettore: 484 - tempo lista: 1140 - l/v: 2.35
...
250 elementi: tempo vettore: 546 - tempo lista: 1390 - l/v: 2.54

Notiamo che fino a 50 elementi la lista e il vettore hanno la stessa velocità e aumentando il numero di elementi il vettore aumenta la differenza di velocità con la lista: con 250 elementi il vettore è 2.5 volte più veloce della lista.

Inoltre, il calcolo della lunghezza di una lista è una operazione onerosa in termini di tempo (perchè non è un valore costante come nei vettori).

(silent (setq a (sequence 1 1000000)))
(time (length a))
;-> 15.629

(silent (setq vec (array (length a) a)))
(time (length vec))
;-> 0


=========
 VETTORI
=========

I vettori (array) di newLISP consentono un accesso rapido agli elementi all'interno di liste di grandi dimensioni. I vettori possono essere costruiti e inizializzati con il contenuto di una lista esistente. Le liste possono essere convertite in vettori e viceversa.
La maggior parte delle funzioni utilizzate per accedere e modificare le liste può essere applicata anche ai vettori. I vettori possono contenere qualsiasi tipo di dati o una combinazione di questi.
In particolare, è possibile utilizzare le seguenti funzioni per creare, accedere e modificare i vettori:

Funzione     Descrizione
--------     -----------
append       appends arrays
apply        apply a function or operator to a list of arguments.
array        creates and initializes an array with up to 16 dimensions
array-list   converts an array into a list
array?       checks if expression is an array
corr         calculates the product-moment correlation coefficient
det          returns the determinant of a matrix
dolist       evaluates once for each element in an array vector
first        returns the first row of an array
invert       returns the inversion of a matrix
last         returns the last row of an array
length       returns the number of rows in an array or elements in a vector
map          applies a function to vector(s) of arguments and returns results in a list.
mat          perform scalar operations on matrices
multiply     multiplies two matrices
nth          returns an element of and array
rest         returns all but the first row of an array
reverse      reverses the elements or rows in an array
setf         sets contents of an array reference
slice        returns a slice of an array
sort         sort the elements in an array
stats        calculates some basic statistics for a data vector
t-test       compares means of data samples using the Student's t statistic
transpose    transposes a matrix

newLISP rappresenta matrici multidimensionali con una matrice di matrici (vale a dire, gli elementi dell'array sono matrici stesse).
Se utilizzato in modo interattivo, newLISP stampa e visualizza i vettori come le liste, senza alcun modo di distinguerli.
Utilizzare le funzioni source o save per serializzare i vettori (o le variabili che li contengono). L'istruzione array è inclusa come parte della definizione durante la serializzazione degli array.
Come gli elenchi, è possibile utilizzare indici negativi per enumerare gli elementi di un array, a partire dall'ultimo elemento.
Un indice "out-of-bounds" causerà un messaggio di errore su un vettore o una lista.
Le matrici possono essere non rettangolari, ma sono rese rettangolari durante la serializzazione quando si utilizza source o save. La funzione array costruisce sempre matrici di forma rettangolare.
Le funzioni matriciali det, transpose, multiply e invert possono essere utilizzate su matrici costruite con liste annidate o vettori costruiti con array.

******************
>>>funzione ARRAY
******************
sintassi: (array int-n1 [int-n2 ...] [list-init])

Crea un vettore con elementi int-n1, inizializzandolo opzionalmente con il contenuto di list-init. Possono essere specificate fino a sedici dimensioni per i vettori multidimensionali (matrici).

Internamente, newLISP crea vettori multidimensionali usando i vettori come elementi di un vettore. I vettori in newLISP dovrebbero essere utilizzati ogni volta che l'indicizzazione random in una lista di grandi dimensioni diventa troppo lenta. Non tutte le funzioni applicabili alle liste possono essere utilizzate sui vettori.

(array 5)
;-> (nil nil nil nil nil)

(array 5 (sequence 1  5))
;-> (1 2 3 4 5)

(array 10 '(1 2))
;-> (1 2 1 2 1 2 1 2 1 2)

I vettori possono essere inizializzati con oggetti di qualsiasi tipo. Se vengono forniti meno valori di inizializzazione degli elementi disponibili, allora la lista viene ripetuto finché tutti gli elementi del vettore non vengono inizializzati.

(set 'myarray (array 3 4 (sequence 1 12)))
;-> ((1 2 3 4) (5 6 7 8) (9 10 11 12))

L'accesso e la modifica dei valori dei vettori vengono effettuati utilizzando la maggior parte delle stesse funzioni utilizzate per modificare le liste.

(setf (myarray 2 3) 99)
;-> 99
myarray
;-> ((1 2 3 4) (5 6 7 8) (9 10 11 99))

(setf (myarray 1 1) "hello")
;-> "hello"

myarray
;-> ((1 2 3 4) (5 "hello" 7 8) (9 10 11 99))

(setf (myarray 1) '(a b c d))
;-> (a b c d)
myarray
;-> ((1 2 3 4) (a b c d) (9 10 11 99))

(nth 1 myarray)
;-> (a b c d)  ; accesso ad una riga intera

;; indicizzazione implicita e slicing sui vettori

(myarray 1)
;-> (a b c d)

(myarray 0 -1)
;-> 4

(2 myarray)
;-> ((9 10 11 99))

(-3 2 myarray)
;-> ((1 2 3 4) (a b c d))

Bisogna fare attenzione ad usare un vettore quando si sostituisce un'intera riga.

La funzione array-list può essere usata per convertire un vettore in una lista:

(array-list myarray)
;-> ((1 2 3 4) (a b c d) (1 2 3 99))

Per riconvertire la lista in un vettore, applicare la funzione flat alla lista:

(set 'aList '((1 2) (3 4)))
;-> ((1 2) (3 4))

(set 'aArray (array 2 2 (flat aList)))
;->  ((1 2) (3 4))

La funzione "array?" la funzione può essere utilizzata per verificare se un'espressione è un vettore:

(array? myarray)
;-> true
                               
(array? (array-list myarray))
;-> nil

Quando si serializzano i vettori usando le funzioni "source" o "save", il codice generato include la dichiarazione necessaria per la loro creazione. In questo modo, le variabili che contengono i vettori sono serializzate correttamente quando si salva con la funzione "save" o si creano stringhe di sorgenti usando la funzione "source".

(set 'myarray (array 3 4 (sequence 1 12)))

(save "array.lsp" 'myarray)

;; contents of file arraylsp ;;

(set 'myarray (array 3 4 (flat '(
  (1 2 3 4)
  (5 6 7 8)
  (9 10 11 12)))))


=============================================
 INDICIZZAZIONE DI STRINGHE, LISTE E VETTORI
=============================================

Alcune funzioni accettano vettori, liste o gli elementi di una stringa (caratteri) specificati da uno o più int-index (indice intero). Gli indici positivi hanno valori in sequenza da 0, 1, ..., N-2, N-1, dove N è il numero di elementi nell'elenco. Se int-index è negativo, la sequenza è -N, -N + 1, ..., -2, -1. L'aggiunta di N ad un indice negativo di un elemento produce un indice positivo. A meno che una funzione non sia scritta appositamente, un indice maggiore di N-1 o minore di -N causa un errore "out-of-bounds" su liste e vettori.

Indicizzazione esplicita
------------------------
La funzione "nth" accede ad un elemento di una stringa, di una lista o di un vettore.

****************
>>>funzione NTH
*****************
sintassi: (nth int-index list)
sintassi: (nth int-index array)
sintassi: (nth int-index str)

sintassi: (nth list-indices list)
sintassi: (nth list-indices array)

Nel primo gruppo di sintassi nth usa il valore di int-index per individuare un indice in una lista, un vettore o una stringa e restituisce l'elemento trovato a quell'indice.
È possibile specificare più indici per accedere in modo ricorsivo a elementi in liste o vettori annidati. Se ci sono più indici che livelli di annidamento, gli indici extra vengono ignorati. Quando vengono utilizzati più indici, devono essere inseriti in una lista come mostrato nel secondo gruppo di sintassi.

(set 'L '(a b c))
(nth 0 L)
;->  a

; o semplicemente
(L 0)
;-> a

(set 'names '(john martha robert alex))
;-> (john martha robert alex)

(nth 2 names)
;-> robert

; o semplicemente
(names 2)
;-> robert

(names -1)
;-> lex

; indici multipli
(set 'persons '((john 30) (martha 120) ((john doe) 17)))

(persons 1 1)
;-> 120

(nth '(2 0 1) persons)
;-> doe

; o semplicemente
(persons 2 0 1)
;-> doe

; indici multipli in un vettore
(set 'v '(2 0 1))
(persons v)
;-> doe
(nth v persons)
;-> doe

; indici negativi
(persons -2 0)
;-> martha

; out-of-bounds indices cause error
(persons 10)
;-> ERR: list index out of bounds

(person -5)
;-> ERR: list index out of bounds

La lista L può essere il contesto del funtore predefinito L:L. Questo consente di passare liste per riferimento:

(set 'L:L '(a b c d e f g))

(define (second ctx)
  (nth 1 ctx))

(reverse L)
;-> (g f e d c b a)
L:L
;-> (g f e d c b a)

;; passare la lista in L:L per riferimento (by reference)
(second L)
;-> b

;; passare la lista in L:L per valore (by value)
(second L:L)
;-> b

Il passaggio di riferimenti è più veloce e utilizza meno memoria in elenchi di grandi dimensioni e deve essere utilizzato su elenchi con più di poche centinaia di elementi.

Si noti che la versione di indicizzazione implicita di nth non infrange le regole di sintassi di newLISP, ma dovrebbe essere intesa come un'espansione logica delle  regole di sintassi di newLISP in altri tipi di dati rispetto alle funzioni integrate o alle espressioni lambda. Una lista nella posizione del functor di una s-espressione assume la funzionalità di autoindicizzazione utilizzando gli argomenti seguenti come indici.

Le forme di sintassi indicizzate implicite sono più veloci, ma l'altra forma con "n-th" esplicito può essere più leggibile in alcune situazioni.

nth funziona sui vettori proprio come fa sulle liste:

(set 'aArray (array 2 3 '(a b c d e f)))
;->  ((a b c) (d e f))
(nth 1 aArray)
;->  (d e f)
(aArray 1)
;->  (d e f)

(nth '(1 0) aArray)
;-> d
(aArray 1 0)
;-> d
(aArray '(1 0))
;-> d

(set 'vec '(1 0))
(aArray vec)
;-> d

Nella versione per le stringhe, nth restituisce il carattere trovato nella posizione int-index della stringa str e lo restituisce come una stringa.

(nth  0 "newLISP")
;-> "n"

("newLISP" 0)
;-> "n"

("newLISP" -1)
;-> "P"

Nota che "nth" funziona sui caratteri piuttosto che sui limiti dei byte quando si utilizza la versione UTF-8 di newLISP. Per accedere ai buffer delle stringhe ASCII e binarie sui limiti dei singoli byte utilizzare la funzione "slice".

Vedi anche "setf" per la modifica di liste e matrici multidimensionali e "push" e "pop" per modificare gli elenchi.

Indicizzazione implicita
------------------------
È possibile utilizzare l'indicizzazione implicita anziché la funzione "nth" per accedere agli elementi di una lista o di un vettore o ai caratteri di una stringa:

(set 'lst '(a b c (d e) (f g)))

(lst 0)    → a      ; uguale a (nth 0 lst)
(lst 3)    → (d e)
(lst 3 1)  → e      ; uguale a (nth '(3 1) lst)
(lst -1)   → (f g)

(set 'myarray (array 3 2 (sequence 1 6)))

(myarray 1)     → (3 4)
(myarray 1 0)   → 3
(myarray 0 -1)  → 2

; indicizzazione di una stringa ASCII
("newLISP" 3)   → "L"

; indicizzaione di una stringa in newLISP UTF8
 ("我能吞下玻璃而不伤身体。" 3) → "下"

Gli indici possono anche essere forniti da una lista. In questo modo, l'indicizzazione implicita funziona insieme a funzioni che prendono o producono indici di vettori, come "push", "pop", "ref" e "ref-all".

(lst '(3 1))
;-> e
(set 'vec (ref 'e lst))
;-> (3 1)
(lst vec)
;-> e

Si noti che l'indicizzazione implicita non infrange le regole di sintassi di newLISP, ma è semplicemente un'espansione delle regole esistenti per altri tipi di dati nella posizione del funtore di una s-espressione. Nel Lisp originale, il primo elemento di un elenco di una s-espressione viene applicato come una funzione agli elementi restanti che vengono presicome argomenti. In newLISP, una lista nella posizione del funtore di una s-espressione assume la funzionalità di autoindicizzazione utilizzando gli argomenti che seguono come indici.

L'indicizzazione implicita è più veloce delle forme esplicite, ma le forme esplicite possono essere più leggibili a seconda del contesto.

Si noti che nella versione di newLISP abilitata a UTF-8, l'indicizzazione implicita delle stringhe o l'uso della funzione nth funzionano sul carattere anziché sui limiti di un a byte singolo.

Indicizzazione implicita e funtore predefinito
----------------------------------------------
Il funtore predefinito è un functor all'interno di un contesto con lo stesso nome del contesto. (vedi il capitolo sui Contesti). È possibile utilizzare un funtore predefinito insieme all'indicizzazione implicita per fungere da meccanismo di riferimento per le liste:

(set 'MyList:MyList '(a b c d e f g))

(MyList 0)
;-> a
(MyList 3)
;-> d
(MyList -1)
;-> g

(3 2 MyList)
;-> (d e)
(-3 MyList)
;-> (e f g)

(set 'aList MyList)

(aList 3)
;-> d

In questo esempio, aList fa riferimento a MyList:MyList, non ad una copia di essa.

Il funtore predefinito indicizzato può anche essere utilizzato con "setf" come mostrato nell'esempio seguente:

(set 'MyList:MyList '(a b c d e f g))

(setf (MyList 3) 999)
;-> 999
(MyList 3)
;-> 999

MyList:MyList
;-> (a b c 999 e f g)

Indicizzazione implicita per "rest" e "slice"
---------------------------------------------
È possibile creare forme implicite di "rest" e "slice" anteponendo ad una lista uno o due numeri per l'offset e la lunghezza. Se la lunghezza è negativa, il conto avviene dalla fine della lista o della stringa:

(set 'lst '(a b c d e f g))
; or as array
(set 'lst (array 7 '(a b c d e f g)))

(1 lst)      → (b c d e f g)
(2 lst)      → (c d e f g)
(2 3 lst)    → (c d e)
(-3 2 lst)   → (e f)
(2 -2 lst)   → (c d e)

; rest e slice funzionano sempre sui limiti dei caratteri a 8-bit anche con versioni abilitate per UTF8

(set 'str "abcdefg")

(1 str)      → "bcdefg"
(2 str)      → "cdefg"
(2 3 str)    → "cde"
(-3 2 str)   → "ef"
(2 -2 str)   → "cde"

Le funzioni "rest", "first" e "last" funzionano sui limiti dei caratteri multibyte nelle versioni abilitate UTF-8 di newLISP. Ma i moduli di indicizzazione impliciti per le funzioni "slice" e "rest"slicing e resting funzioneranno sempre sui limiti a byte singolo e possono essere utilizzati per il contenuto binario. I risultati di offset e lunghezza delle funzioni per le espressione regolare "find" e "regex" utilizzano il conteggio a byte singolo e possono essere ulteriormente elaborati con "slice" o la sua forma implicita.

Modifica degli elementi di una lista, un vettore o una stringa
--------------------------------------------------------------
Gli elementi a cui si fa riferimento per indici nelle liste, nei vettori e nelle stringhe possono essere modificati usando "setf":
; lists

(set 'lst '(a b c d (e f g)))

(lst 1)
;-> b

(setf (lst 1) 'z)
;-> z

lst
;-> (a z c d (e f g))

(setf (lst -1) '(E F G))
;-> (E F G)

lst
;-> (a z c d (E F G))

; arrays

(set 'myarray (array 2 3 (sequence 1 6)))
;-> ((1 2 3) (4 5 6))

(setf (myarray 1 2) 66)
;-> 66

myarray
;-> ((1 2 3) (4 5 66))

; strings

(set 's "newLISP")

(setf (s 0) "n")
;-> "n"

s
;-> "newLISP"

Si noti che solo gli elementi completi di liste annidate o dei vettori possono essere modificati in questo modo. Gli slice e il rest di una lista o di un vettore non possono essere modificati utilizzando "setf", ma dovrebbero essere sostituiti elemento per elemento. Nelle stringhe può essere sostituito un solo carattere alla volta, ma quel carattere può essere sostituito da una stringa multi-carattere.


====================================
 ATTRAVERSAMENTO DI LISTE E VETTORI
====================================

Proviamo la velocità di attraversare le liste e i vettori delle funzioni "dolist" e "for":

Definiamo un vettore di 10000 elementi:
(silent (setq arr (array 100000 (sequence 1 100000))))

Definiamo una lista di 10000 elementi:
(silent (setq lst (array-list arr)))

Definiamo tre funzioni che fanno la stessa cosa (costruiscono una lista) con le seguenti varianti:

1) Uso di "dolist" con la lista

(define (try-list lst)
  (setq outlst '())
  (dolist (el lst)
    (push el outlst -1)
  )
)

2) Uso di "for" per la lista:

(define (try-list-as-array arr)
  (setq outlst-arr '())
  (setq fine (- (length lst) 1))
  (for (i 0 fine)
    (push (arr i) outlst-arr -1)
  )
)

3) Uso di "for" per il vettore:

(define (try-array arr)
  (setq outarr '())
  (setq fine (- (length arr) 1))
  (for (i 0 fine)
    (push (arr i) outarr -1)
  )
)

Vediamo i tempi di calcolo:

(time (try-list lst) 10)
;-> 93.77
(length outlst)
;-> 100000

(time (try-list-as-array lst) 10)
;-> 80869.0 ; 80 secondi
(length outlst-arr)
;-> 100000

(time (try-array arr) 10)
(length outarr)
;-> 93.765

Nota: Usare "dolist" per attraversare le liste e usare "for" per attraversare i vettori.
Non usare "for" per attraversare una lista (l'indicizzazione di una lista (lst i) è un'operazione onerosa).


=============================
 ATTRAVERSAMENTO DI STRINGHE
=============================

Proviamo la velocità di attraversare le liste e i vettori delle funzioni " dostring", "dolist" e "for":

1) Uso di "dostring" con la stringa

(setq str "abcd")
;-> "abcd"
(dostring (c str)
  (println (char c) { } c)
)
;-> a 97
;-> b 98
;-> c 99
;-> d 100

Nota: L'indice di "dostring" (es. c) contiene il valore ASCII del carattere (intero).
Per ottenere il carattere occorre applicare la funzione "char" (es. (char c)).

2) Uso di "dolist" con la lista ottenuta dalla stringa con "explode"

(setq str "abcd")
;-> "abcd"
(setq lst (explode str))
;-> ("a" "b" "c" "d")
(dolist (c lst)
  (println (char c ) { } c)
)
;-> 97 a
;-> 98 b
;-> 99 c
;-> 100 d

3) Uso di "for" sulla stringa

(setq str "abcd")
;-> "abcd"
(for (i 0 (- (length str) 1))
  (println (char (str i)) { } (str i))
)
;-> 97 a
;-> 98 b
;-> 99 c
;-> 100 d

4) Uso di "for" con la lista ottenuta dalla stringa con "explode"

(setq str "abcd")
;-> "abcd"
(setq lst (explode str))
;-> ("a" "b" "c" "d")
(for (i 0 (- (length lst) 1))
  (println (lst i) { } (char (lst i)))
)
;-> a 97
;-> b 98
;-> c 99
;-> d 100

Proviamo la velocità dei quattro metodi:

(silent (setq str (dup "-" 2000)))
(silent (setq lst (explode str)))

(time (dostring (c str) (setq a (char c))) 10000)
;-> 3406.351
(time (dolist (c lst) (setq a (char c))) 10000)
;-> 3688.129
(time (for (i 0 (- (length str) 1)) (setq a (char (str i)))) 10000)
;-> 44769.743
(time (for (i 0 (- (length lst) 1)) (setq a (char (lst i)))) 10000)
;-> 33721.979

Nota: Usare "dostring" oppure "dolist" per attrversare le stringhe.


================================================
 USCITA ANTICIPATA DA FUNZIONI, CICLI E BLOCCHI
================================================

Quelli che seguono sono i metodi per interrompere il flusso di controllo all'interno dei cicli e delle espressioni "begin".

Le funzioni di ciclo "for", "dolist" e "dotimes" possono avere espressioni condizionali opzionali che permettono di uscire dal ciclo in anticipo. "catch" e throw sono una forma più generale per uscire da un ciclo e sono applicabili anche ad altre forme o blocchi di istruzioni.


Usando "catch" e "throw"
------------------------
Poiché newLISP è un linguaggio funzionale, non utilizza le istruzioni "break" o "return" per uscire da funzioni o iterazioni. Invece, è possibile uscire da un blocco o una funzione in qualsiasi momento usando le funzioni catch e throw:

(define (foo x)
    ...
    (if condition (throw 123))
    ...
    456
)

;; se la condizione è vera

(catch (foo p))
;-> 123

;; se la condizione non è vera

(catch (foo p))
;-> 456

L'interruzione dei cicli loop funziona in modo simile:

(catch
    (dotimes (i N)
        (if (= (foo i) 100) (throw i))))

;-> valore di i quando foo (i) è uguale a 100

L'esempio mostra come è possibile uscire da un ciclo iterativo prima di essere eseguito N volte.

Punti di ritorno multipli possono essere codificati usando il "throw":

(catch (begin
    (foo1)
    (foo2)
    (if condition-A (throw 'x))
    (foo3)
    (if condition-B (throw 'y))
    (foo4)
    (foo5)))

Se la condizione-A è vera, x sarà restituito dall'espressione "catch", se la condizione-B è vera, il valore restituito è y. In caso contrario, il risultato di foo5 verrà utilizzato come valore di ritorno.

Esempio di catch as "continue" in dolist:

(dolist (el lst)
  (catch
     (if (= el 'e) (throw nil)
         (println el))
  )
)

Esempio di catch in una funzione:

(define (prova n)
  (catch
    (local (x)
      (if (< n 0) (throw true))
      (for (i 0 100)
        (if (= i n) (throw i))
      )
      (throw "end")
    )
  )
)

(prova -1)
;-> true

(prova 10)
;-> 10

(prova 101)
;-> "end"

Esempio di catch nidificati in una funzione:

(define (prova2 n)
  (catch
    (local (x)
      (if (< n 0) (throw "primo catch"))
      (catch
        (for (i 0 100)
          (if (= i n) (throw (println i " secondo catch")))
        )
      )
      (println "...continua")
      (if (> n 100) (throw "maggiore: first catch"))
      (println "normale")
    )
  )
)

(prova2 -1)
;-> "primo catch"

(prova2 10)
;-> 10 secondo catch
;-> ...continua
;-> normale

(prova2 101)
;-> ...continua
;-> "maggiore: first catch"

Oltre alla funzione "catch", possiamo usare la funzione di "error-event" per rilevare errori causati da codice errato o eccezioni avviate dall'utente.

La funzione "throw-error" può essere utilizzata per generare errori definiti dall'utente.


======================================
 LAVORARE CON FILE DI DATI (FILE I/O)
======================================

In genere i dati sono memorizzati su file con differenti formati. La prima distinzione è il tipo di file: binario o testo (ASCII). Per adesso prendiamo in considerazione i file di testo (cioè quelli che possono essere letti e/o creati con un qualsiasi editor di testi).
Consideriamo i seguenti due file di dati:

data.txt
1 2 3 4 5
6 7 8 9 0
a b c d e
f g h i j

dataCSV.txt
1,2,3,4,5
6,7,8,9,0
a,b,c,d,e
f,g,h,i,j

newLISP ha la funzione "read-file" che permette di leggere tutto il contenuto di un file e restituirlo come stringa:

(setq datastring (read-file "data.txt"))
;-> "1 2 3 4 5\r\n6 7 8 9 0\r\na b c d e\r\nf g h i j"

Adesso dobbiamo trasformare questa stringa in una lista di stringhe delimitate dal carattere di fine linea (eol - end of line). La funzione "parse" fa proprio questo, suddivide una stringa in sottostringhe basandosi su un delimitatore (in windows il delimitatore di fine linea è "\r\n", mentre su UNIX è "\n"):

(setq data (parse datastring "\r\n"))
;-> ("1 2 3 4 5" "6 7 8 9 0" "a b c d e" "f g h i j")

Adesso se vogliamo ottenere una lista per ogni riga, basta mappare la funzione "list" sugli elementi della lista data:

(map list data)
;-> (("1 2 3 4 5") ("6 7 8 9 0") ("a b c d e") ("f g h i j"))

Notiamo che applicando la funzione "sym" otteniamo una lista di simboli:

(length (map sym data))
;-> (1 2 3 4 5 6 7 8 9 0 a b c d e f g h i j)

Quindi se vogliamo avere i simboli al posto delle stringhe nella lista finale, possiamo scrivere:

(setq data (map list (map sym data)))
;-> ((1 2 3 4 5) (6 7 8 9 0) (a b c d e) (f g h i j))

Abbiamo ottenuto una lista le cui sottoliste rappresentano le righe del file di dati.

Purtroppo non è il risultato voluto, poichè ogni sottolista è composta da un solo elemento:

(length (first data))
;-> 1

(first (first data))
;-> 1 2 3 4 5

Questo è dovuto al fatto che abbiamo applicato la funzione "sym" ad ogni elemento della lista (es. (1 2 3 4 5)),
non ad ogni elemento delle sottoliste (es. 1).

Per capire meglio, ripartiamo dall'inizio:

Leggiamo il file su una stringa:

(setq datastring (read-file "data.txt"))
;-> "1 2 3 4 5\r\n6 7 8 9 0\r\na b c d e\r\nf g h i j"

Dividiamo la stringa in sottostringhe delimitate da eol:

(setq data (parse datastring "\r\n"))
;-> ("1 2 3 4 5" "6 7 8 9 0" "a b c d e" "f g h i j")

Possiamo applicare nuovamente la funzione "parse" sulla striga "data" utilizzando come separatore il carattere spazio " ":

(setq data (map (fn (x) (parse x " ")) data))
;-> (("1" "2" "3" "4" "5") ("6" "7" "8" "9" "0") ("a" "b" "c" "d" "e") ("f" "g" "h" "i" "j"))

Adesso possiamo applicare la funzione "sym":

(setq data (map (fn (x) (map sym x)) data))
;-> ((1 2 3 4 5) (6 7 8 9 0) (a b c d e) (f g h i j))

Controlliamo il risultato:

(length (first data))
;-> 5

(first (first data))
;-> 1

Sembra tutto corretto, ma cosa succede se i valori nel file sono separati da un numero differente di spazi " "?

data2.txt
1  2   3 4   5
6   7 8 9   0
a b    c d   e
f g h    i j

Se vogliamo ignorare gli spazi ripetuti, allora possiamo usare una espressione regolare nella la funzione "parse":

(setq data (map (fn (x) (parse x " +" 0)) data))

Il parametro "0" indica a newLISP di trattare la stringa " +" come un pattern di una espressione regolare. In particolare " +" significa: qualunque numero di spazi.

Quindi le istruzioni finali sono le seguenti:

(setq datastring (read-file "data2.txt"))
(setq data (parse datastring "\r\n"))
(setq data (map (fn (x) (parse x " +" 0)) data))
(setq data (map (fn (x) (map sym x)) data))
;-> ((1 2 3 4 5) (6 7 8 9 0) (a b c d e) (f g h i j))

Per quanto riguarda il file "dataCSV.txt", notiamo che è in formato CSV (Comma Separated Value).
Possiamo utilizzare lo stesso metodo che abbiamo visto per il file "data.txt", purchè venga utilizzato il carattere virgola "," come separatore:

Leggiamo il file in una stringa:

(setq datastring (read-file "dataCSV.txt"))
;-> "1,2,3,4,5\r\n6,7,8,9,0\r\na,b,c,d,e\r\nf,g,h,i,j"

Dividiamo la stringa in sottostringhe delimitate da eol:

(setq data (parse datastring "\r\n"))
;-> ("1,2,3,4,5" "6,7,8,9,0" "a,b,c,d,e" "f,g,h,i,j")

Applichiamo la funzione "parse" sulla striga "data" utilizzando come separatore il carattere virgola ",":

(setq data (map (fn (x) (parse x ",")) data))
;-> (("1" "2" "3" "4" "5") ("6" "7" "8" "9" "0") ("a" "b" "c" "d" "e") ("f" "g" "h" "i" "j"))

Applichiamo la funzione "sym":

(setq data (map (fn (x) (map sym x)) data))
;-> ((1 2 3 4 5) (6 7 8 9 0) (a b c d e) (f g h i j))

Controlliamo il risultato:

(length (first data))
;-> 5

(first (first data))
;-> 1

Ok. Ma cosa succede se abbiamo dei valori mancanti nel file di dati?

data2CSV.txt
,2,3,4,5
6,7,,,0
a,b,c,,e
f,g,h,i,

(setq datastring (read-file "data2CSV.txt"))
;-> ",2,3,4,5\r\n6,7,,,0\r\na,b,c,,e\r\nf,g,h,i,"

Dividiamo la stringa in sottostringhe delimitate da eol:

(setq data (parse datastring "\r\n"))
;-> (",2,3,4,5" "6,7,,,0" "a,b,c,,e" "f,g,h,i,")

Applichiamo la funzione "parse" sulla striga "data" utilizzando come separatore il carattere virgola ",":

(setq data (map (fn (x) (parse x ",")) data))
;-> (("" "2" "3" "4" "5") ("6" "7" "" "" "0") ("a" "b" "c" "" "e") ("f" "g" "h" "i" ""))

Adesso prima di applicare la funzione "sym", trasformiamo i valori "" con quello che vogliamo (ad esempio "null"):

(setq data (map (fn (x) (replace "" x "null")) data))
;-> (("null" "2" "3" "4" "5") ("6" "7" "null" "null" "0") ("a" "b" "c" "null" "e") ("f" "g" "h" "i" "null"))

Adesso possiamo applicare la funzione "sym":

(setq data (map (fn (x) (map sym x)) data))
;-> ((null 2 3 4 5) (6 7 null null 0) (a b c null e) (f g h i null))

Quindi le istruzioni finali per un file CSV sono le seguenti:

(setq datastring (read-file "data2CSV.txt"))
(setq data (parse datastring "\r\n"))
(setq data (map (fn (x) (parse x ",")) data))
(setq data (map (fn (x) (replace "" x "null")) data))
(setq data (map (fn (x) (map sym x)) data))
;-> ((null 2 3 4 5) (6 7 null null 0) (a b c null e) (f g h i null))

A questo punto siamo in grado di scrivere una funzione che importa i nostri file di dati:

(define (leggi-dati file delim sep tipo vuoto)
  (local (datastring data)
    (setq datastring (read-file file))
    (setq data (parse datastring "\r\n"))
    (if (= sep " ")
        (setq data (map (fn (x) (parse x (append " " "+") 0)) data)) ; file separato da spazi
        (begin
          (setq data (map (fn (x) (parse x sep)) data)) ; file separato con altro separatore
          (setq data (map (fn (x) (replace "" x vuoto)) data)) ; modifica i valori vuoti
        )
    )
    ; converto in simboli?
    (if (= tipo "sim") (setq data (map (fn (x) (map sym x)) data)))
    data
  );local
)

Facciamo alcune prove:

(leggi-dati "data.txt" "\r\n" " " "str" "-1")
;-> (("1" "2" "3" "4" "5") ("6" "7" "8" "9" "0") ("a" "b" "c" "d" "e") ("f" "g" "h" "i" "j"))

(leggi-dati "data2.txt" "\r\n" " " "sim" "-1")
;-> ((1 2 3 4 5) (6 7 8 9 0) (a b c d e) (f g h i j))

(leggi-dati "dataCSV.txt" "\r\n" "," "sim" "-1")
;-> ((1 2 3 4 5) (6 7 8 9 0) (a b c d e) (f g h i j))

(leggi-dati "data2CSV.txt" "\r\n" "," "sim" "-1")
;-> ((-1 2 3 4 5) (6 7 -1 -1 0) (a b c -1 e) (f g h i -1))

Nota:
(setq lst (leggi-dati "data2CSV.txt" "\r\n" "," "sim" "-1"))
;-> ((-1 2 3 4 5) (6 7 -1 -1 0) (a b c -1 e) (f g h i -1))
(setq a 99999)
;-> 99999
(eval (nth '(2 0) lst))
;-> 99999

Possiamo quindi creare da un file una lista con sottoliste di simboli e poi assegnare i valori senza utilizzare alcun tipo di indicizzazione.

Nota: Questa funzione carica il file completamente in memoria.

In altri casi potremmo avere la necessità di leggere il file linea per linea ed elaborare ogni linea fino al raggiungimento della fine del file. Per fare questo dobbiano utilizzare le funzioni "open", "read-line" e "close".

(define (read-data file sep)
  (setq lst '()) ; lista dei dati
  ; apre il file in lettura (e assegna un numero di device a in-file)
  (setq in-file (open file "read"))
  (while (read-line in-file) ; legge il file linea per linea
    (setq data-linea (parse (current-line) sep)) ; lista con i dati della linea in formato stringa
    ; Adesso possiamo elaborare i dati della linea corrente ("1" "2" "3" "4" "5")...
    ;(println (current-line))
    (println data-linea)
    (setq lst (push data-linea lst -1)) ; aggiunge la linea corrente alla lista dati
  )
  (close in-file) ; chiude il file
  lst
)

Proviamo a leggere i nostri file di esempio:

(read-data "data.txt" " ")
;-> ("1" "2" "3" "4" "5")
;-> ("6" "7" "8" "9" "0")
;-> ("a" "b" "c" "d" "e")
;-> ("f" "g" "h" "i" "j")
;-> (("1" "2" "3" "4" "5") ("6" "7" "8" "9" "0") ("a" "b" "c" "d" "e") ("f" "g" "h" "i" "j"))

(read-data "data2.txt" " ")
("1" "" "2" "" "" "3" "4" "" "" "5")
("6" "" "" "7" "8" "9" "" "" "0")
("a" "b" "" "" "" "c" "d" "" "" "e")
("f" "g" "h" "" "" "" "i" "j")
(("1" "" "2" "" "" "3" "4" "" "" "5") ("6" "" "" "7" "8" "9" "" "" "0") ("a" "b" "" "" "" "c" "d" "" "" "e") ("f" "g" "h" "" "" "" "i" "j"))

(read-data "dataCSV.txt" ",")
;-> ("1" "2" "3" "4" "5")
;-> ("6" "7" "8" "9" "0")
;-> ("a" "b" "c" "d" "e")
;-> ("f" "g" "h" "i" "j")
;-> (("1" "2" "3" "4" "5") ("6" "7" "8" "9" "0") ("a" "b" "c" "d" "e") ("f" "g" "h" "i" "j"))

(read-data "data2CSV.txt" ",")
;-> ("" "2" "3" "4" "5")
;-> ("6" "7" "" "" "0")
;-> ("a" "b" "c" "" "e")
;-> ("f" "g" "h" "i" "")
;-> (("" "2" "3" "4" "5") ("6" "7" "" "" "0") ("a" "b" "c" "" "e") ("f" "g" "h" "i" ""))

Questo metodo ci permette di eleborare i dati linea per linea (e poi elemento per elemento).

Per scrivere in un file dobbiamo usare le funzioni  le funzioni "open", "write-line" e "close".
Le seguenti linee visualizzano il file "data.txt":

(setq datafile (open "data.txt" "read"))
;-> 4 ; numero device associato al file data.txt
(while (read-line datafile) (write-line)) ; stampiamo il file linea per linea
;-> 1 2 3 4 5
;-> 6 7 8 9 0
;-> a b c d e
;-> f g h i j
;-> 11
(close datafile) ; chiudiamo il file
;-> true

Usata senza parametri la funzione "write-line" scrive sulla REPL (standard output) il contenuto dell'ultima chiamata di "read-line" (cioè "current-line"). Inoltre "write-line" restituisce il numero di byte (caratteri) scritti.

Per capire meglio i parametri della funzione "write-line" e il funzionamento delle operazioni di Input/Output sui file, vediamo la definizione di tutte le funzioni interessate:

"device", "open", "close", "read-line", "current-line", "write-line", "read-char", "write-char", "read", "write".

*******************
>>>funzione DEVICE
*******************
sintassi: (device [int-io-handle])

int-io-handle è un numero di dispositivo I/O, che è impostato su 0 (zero) per l'I/O standard (0 per stdin, 1 per stdout e 2 per stderr). int-io-handle può anche essere un handle di file precedentemente ottenuto usando la funzione "open". In questo caso, sia l'input che l'output utilizzano questo handle. Se non viene fornito alcun argomento, viene restituito il numero corrente del dispositivo I/O.

Il canale I/O specificato da device viene utilizzato internamente dalle funzioni print, println, write, write-line e read-char, read-line. Quando il dispositivo I/O corrente è 0 o 1, la stampa invia l'output alla finestra della console e il read-line accetta l'input dalla tastiera. Se il dispositivo I/O corrente è stato impostato aprendo un file, allora la stampa e la lettura lavorano su quel file.

Si noti che su sistemi operativi Unix, il canale stdin (0) può essere utilizzato anche per l'output e il canale stdout (1) può essere utilizzato anche per la lettura dell'ingresso. Questo non è il caso di Windows, dove 0 è strettamente per input e stdout 1 strettamente per l'output.

(device (open "myfile" "write"))  → 5
(print "This goes in myfile")     → "This goes in myfile"
(close (device))                  → true

Nota che usare "close" su un "device" automaticamente impostano il valore di "device" a zero (0).

*****************
>>>funzione OPEN
*****************
sintassi: (open str-path-file str-access-mode [str-option])

Il file str-path è un nome di file e str-access-mode è una stringa che specifica la modalità di accesso al file. open restituisce un numero intero, che è un handle di file da utilizzare nelle successive operazioni di lettura o scrittura sul file. In caso di fallimento, open restituisce nil. La modalità di accesso "write" crea il file se non esiste, o tronca un file esistente a 0 (zero) byte di lunghezza.

Le seguenti stringhe sono le modalità di accesso disponibili:

"read"   o "r" per accesso in lettura (read)
"write"  o "w" per accesso in scrittura (write)
"update" o "u" per accesso in lettura/scrittura (read/write)
"append" o "a" per accesso in aggiungere/leggere/scrivere (append/read/write)

(device (open "newfile.data" "write"))  → 5
(print "hello world\n")  → "hello world"
(close (device))         → 5

(set 'aFile (open "newfile.data" "read"))
(seek aFile 6)
(set 'inChar (read-char aFile))
(print inChar "\n")
(close aFile)

Il primo esempio utilizza open per impostare il dispositivo per la stampa e scrive la parola "ciao mondo" nel file newfile.data. Il secondo esempio legge il valore di byte all'offset 6 dello stesso file (il valore ASCII di 'w' è 119). Si noti che l'utilizzo di close sul device ripristina automaticamente il device sul valore 0 (zero).

L'opzione aggiuntiva str-option, "non-block" o "n" possono essere specificati dopo l'opzione "read" o "write". Disponibile solo su sistemi Unix, la modalità non bloccante può essere utile quando si aprono pipe con nome, ma non è richiesto per eseguire I/O su pipe con nome.

******************
>>>funzione CLOSE
******************
sintassi: (close int-file)

Chiude il file specificato dall'handle del file int-file. L'handle dovrebbe essere stato ottenuto tramite una precedente chiamata alla funzione open. In caso di successo, chiude restituisce vero, altrimenti viene restituito nil.

(close (device))  → true
(close 7)         → true
(close aHandle)   → true

Si noti che l'utilizzo di close su un device lo reimposta automaticamente su 0 (zero, il device dello schermo).

**********************
>>>funzione READ-LINE
**********************
sintassi: (read-line [int-file])

Legge dal device I/O corrente una stringa delimitata da un carattere di avanzamento riga (line-feed ASCII 10). Non c'è limite alla lunghezza della stringa che può essere letta. Il carattere line-feed non fa parte della stringa restituita. La linea si spezza sempre su un line-feed, che viene poi scartato. Una riga si interrompe su un ritorno a capo (carriage-return ASCII 13) solo se seguito da un avanzamento riga, nel qual caso entrambi i caratteri vengono scartati. Un ritorno a capo da solo spezza la linea e viene scartato solo se è l'ultimo carattere del file.

Per impostazione predefinita, il dispositivo corrente è la tastiera (dispositivo 0). Utilizzare il dispositivo funzione predefinita "device" incorporato per specificare un diverso dispositivo I/O (ad es. un file). Facoltativamente, è possibile specificare un handle di file nel parametro int-file ottenuto da una precedente istruzione open.

L'ultimo contenuto del buffer da un'operazione di lettura riga può essere recuperato utilizzando la linea corrente.

Quando read-line sta leggendo da un file o da stdin in un programma o pipe CGI, restituirà zero quando l'input è esaurito.

Quando si utilizza read-line su stdin, la lunghezza della linea è limitata a 2048 caratteri e le prestazioni sono molto più veloci.

(print "Enter a num:")
(set 'num (int (read-line)))

(set 'in-file (open "afile.dat" "read"))
(while (read-line in-file)
        (write-line))
(close in-file)

Il primo esempio legge l'input dalla tastiera e lo converte in un numero. Nel secondo esempio, un file viene letto riga per riga e visualizzato sullo schermo. L'istruzione write-line si avvale del fatto che il risultato dell'ultima operazione di lettura (read-line) è memorizzato in un buffer interno al sistema.
Quando write-line viene utilizzata senza argomenti, scrive il contenuto del buffer ottenuto con l'ultima chiamata di read-line.

*************************
>>>funzione CURRENT-LINE
*************************
sintassi: (current-line)

Recupera il contenuto dell'ultima operazione di read-line. Il contenuto di current-line viene implicitamente usato quando write-line viene chiamata senza il parametro stringa.

Il seguente codice sorgente mostra il tipico pattern per la creazione di un filtro da riga di comando Unix:

#!/usr/local/bin/newLISP

(set 'inFile (open (main-args 2) "read"))
(while (read-line inFile)
  (if (starts-with (current-line) ";;")
    (write-line)))
(exit)

Il programma viene chiamato in questo modo:

./filter myfile.lsp

Questo comando mostra tutte le righe di commento che iniziano con ";;" del file fornito come argomento della riga di comando (myfile.lsp)

***********************
>>>funzione WRITE-LINE
***********************
sintassi: (write-line [int-file [str]])
sintassi: (write-line str-out [str]])

La stringa str e i caratteri di terminazione di riga vengono scritti nel device specificato dal parametro int-file. Quando l'argomento stringa viene omesso, write-line scrive il contenuto dell'ultima operazione read-line sul device individuato da int-file Se viene omesso anche il primo argomento, allora scrive su standard output (STDOUT) o sul dispositivo impostato dalla funzione device.

Nella seconda sintassi le righe vengono aggiunte alla stringa str-out.

write-line restituisce il numero di byte scritti.

(set 'out-file (open "myfile" "write"))
(write-line out-file "hello there")
(close out-file)

(set 'myFile (open "init.lsp" "read")
(while (read-line myFile) (write-line))

(set 'str "")
(write-line str "hello")
(write-line str "world")

str  →  "hello\nworld\n"

Il primo esempio apre/crea un file, scrive una riga e chiude il file. Il secondo esempio mostra l'uso di write-line senza argomenti. Il contenuto di init.lsp viene scritto sullo schermo della console.

**********************
>>>funzione READ-CHAR
**********************
sintassi: (read-char [int-file])

Legge un byte da un file specificato dall'handle in int-file o dal dispositivo di I/O corrente - ad es. stdin quando non viene specificato alcun handle di file. L'handle del file è ottenuto da una precedente chiamata alla funzione open. Ogni read-char avanza il puntatore del file di un byte. Una volta raggiunta la fine del file, viene restituito nil.

(define (slow-file-copy from-file to-file)
    (set 'in-file (open from-file "read"))
    (set 'out-file (open to-file "write"))
    (while (set 'chr (read-char in-file))
        (write-char out-file chr))
    (close in-file)
    (close out-file)
    "finished")

Usa read-line e device per leggere un'intera linea alla volta. Notare che newLISP fornisce una funzione predefinita molto veloce per copiare i file (copy-file).

***********************
>>>funzione WRITE-CHAR
***********************
sintassi: (write-char int-file int-byte1 [int-byte2 ... ])

Scrive il byte specificato in int-byte nel file specificato dall'handle int-file. L'handle del file è ottenuto da una precedente chiamata alla funzione open. Ogni chiamata write-char fa avanzare il puntatore del file di un byte (8 bit).

write-char restituisce il numero di byte scritti.

(define (slow-file-copy from-file to-file)
    (set 'in-file (open from-file "read"))
    (set 'out-file (open to-file "write"))
    (while (set 'chr (read-char in-file))
        (write-char out-file chr))
     (close in-file)
    (close out-file)
    "finished")

Utilizzare le funzioni print e device per scrivere grandi porzioni di dati alla volta. Notare che newLISP fornisce già una funzione integrata più veloce chiamata copy-file. Notare che newLISP fornisce una funzione predefinita molto veloce per copiare i file (copy-file).

******************
>>>funzione READ
******************
sintassi: (read int-file sym-buffer int-size [str-wait])

Legge al massimo int-size byte da un file specificato dall'handle int-file nel buffer sym-buffer. Tutti i dati a cui fa riferimento il simbolo sym-buffer prima della lettura vengono cancellati. L'handle int-file è ottenuto da una precedente istruzione open. Il simbolo sym-buffer contiene dati di tipo stringa dopo l'operazione di lettura. sym-buffer può anche essere un funtore predefinito specificato da un simbolo di contesto per il passaggio per riferimento di funzioni definite dall'utente.

read è un modo più breve di usare read-buffer. La forma più lunga funziona ancora, ma è deprecata e dovrebbe essere evitata nei nuovi programmia.

Opzionalmente, una stringa da attendere può essere specificata in str-wait. read leggerà una quantità massima di byte specificata in int-size o uscirà preventivamente se str-wait è stato trovato nei dati. La stringa di attesa è parte dei dati restituiti e non deve contenere caratteri binari 0 (zero).

Restituisce il numero di byte letti o nil quando non è stata trovata la stringa di attesa. In ogni caso, i byte letti vengono inseriti nel buffer puntato da sym-buffer e il puntatore del file del file in lettura viene spostato in avanti. Se non sono stati letti nuovi byte, sym-buffer conterrà nil.

(set 'handle (open "aFile.ext" "read"))
(read handle buff 200)
Legge 200 byte nel buff symbol dal file aFile.ext.

(leggi handle buff 1000 "password:")
Legge 1000 byte o fino a quando si incontra la stringa "password:". La stringa "password:" sarà parte dei dati restituiti.

******************
>>>funzione WRITE
******************
sintassi: (write)
sintassi: (write int-file str-buffer [int-size])
sintassi: (write str str-buffer [int-size])

Nella seconda sintassi write scrive int-size byte da un buffer in str-buffer in un file specificato da int-file, che è stato precedentemente ottenuto da un'operazione di apertura file (open). Se int-size non viene specificato, allora vengono scritti tutti i dati in sym-buffer o str-buffer. write restituisce il numero di byte scritti o nil in caso di errore.

Se tutti i parametri sono omessi, write scrive il contenuto ottenuto dall'ultima chiamata read-line sullo standard output (stdout).

write è una modo più breve di write-buffer. La forma più lunga funziona ancora, ma è deprecata e dovrebbe essere evitata nel nuovo codice.

(set 'handle (open "myfile.ext" "write"))
(write handle data 100)
(write handle "a quick message\n")

Il codice dell'esempio scrive 100 byte nel file myfile.ext presi dal contenuto di della variabile data.

Nella terza sintassi, la scrittura può essere utilizzata per unire stringhe in modo distruttivo:

(set 'str "")
(write str "hello world")

str   → "hello world"

**********************
>>>funzione READ-FILE
**********************
sintassi: (read-file str-file-name)

Legge un file dato in str-file-name in un colpo solo e restituisce una stringa (buffer) contenente i dati.

In caso di fallimento la funzione ritorna nil. Per informazioni sull'errore, utilizzare sys-error sul file. Se utilizzato su URL, net-error fornisce ulteriori informazioni sull'errore.

(write-file "myfile.enc"
    (encrypt (read-file "/home/lisp/myFile") "secret"))

Il file myfile viene prima letto, poi criptato usando la password "secret" e infine sritto con un nuovo nome "myfile.enc" nella cartella corrente.

read-file può usare http:// oppure file:// URL in str-file-name. Quando il prefisso vale http:// read-file funziona esattamente come get-url e può avere gli stessi parametri addizionali.

(read-file "http://asite.com/somefile.tgz" 10000)

Il file somefile.tgz viene caricato dalla locazione remota http://asite.com. Il trasferimento del file viene interrotto dopo un tempo di 10 secondi (time-out) anche se la lettura non è terminata. In questo modo, read-file può anche essere usato per trasferire file da un server remoto newLISP.

***********************
>>>funzione WRITE-FILE
***********************
sintassi: (write-file str-file-name str-buffer)

Scrive un file dato in str-file-name con il contenuto di str-buffer in un colpo solo e restituisce il numero di byte scritti.

In caso di fallimento la funzione ritorna nil. Per informazioni sull'errore, utilizzare sys-error sul file. Se utilizzato su URL, net-error fornisce ulteriori informazioni sull'errore.

(write-file "myfile.enc"
    (encrypt (read-file "/home/lisp/myFile") "secret"))

Il file myfile viene prima letto, poi criptato usando la password "secret" e infine sritto con un nuovo nome "myfile.enc" nella cartella corrente.

write-file può usare http:// oppure file:// URL in str-file-name. Quando il prefisso vale http:// allora write-file funziona esattamente come put-url e può avere gli stessi parametri addizionali.

(write-file "http://asite.com/message.txt" "This is a message" )

Il file message.txt viene creato e scritto nella locazione remota http://asite.com con il contenuto di str-buffer. In questo modo, write-file può anche essere usato per trasferire file a un server remoto newLISP.

************************
>>>funzione APPEND-FILE
************************
sintassi: (append-file str-filename str-buffer)

Funziona in modo simile a write-file, ma il contenuto di str-buffer viene aggiunto se il file str-filename esiste. Se il file non esiste, allora viene creato (in questo caso append-file funziona esattamente come write-file). Questa funzione ritorna il numero di byte scritti.

In caso di fallimento la funzione ritorna nil. Per informazioni sull'errore, utilizzare sys-error sul file. Se utilizzato su URL, net-error fornisce ulteriori informazioni sull'errore.

(write-file "myfile.txt" "ABC")
(append-file "myfile.txt" "DEF")

(read-file "myfile.txt")  → "ABCDEF"

append-file può usare a http:// oppure file:// URL in str-file-name. Quando il prefisso vale http:// allora append-file funziona esattamente come con l'opzione header "Pragma: append\r\n" e può avere gli stessi parametri addizionali. L'opzione "Pragma: append\r\n" viene aggiunta automaticamente.

(append-file "http://asite.com/message.txt" "More message text.")

Il file message.txt viene aggiunto nella locazione remota http://asite.com con il contenuto di str-buffer. Se il file non esiste, allora verrà creato. In questo modo, append-file può anche essere usato per trasferire file a un server remoto newLISP.


================================
 SALVARE E CARICARE GLI OGGETTI
================================

Una caratteristica importante di un linguaggio interpretato è la capacità di salvare gli oggetti creati dall'utente durante la sessione REPL.

Oltre alle funzioni I/O standard ("open", "close", "write-char", ecc), newLISP mette a disposizione le funzioni "save", "load", "source" e "pretty-print".

Vediamo la loro definizione:

*****************
>>>funzione SAVE
*****************
sintassi: (save str-file)
sintassi: (save str-file sym-1 [sym-2 ... ])

Nella prima sintassi, la funzione save scrive il contenuto dello spazio di lavoro di newLISP (in forma testuale) nel file str-file. save è la funzione inversa di load. L'utilizzo di load sui file creati con save fa sì che newLISP ritorni allo stesso stato di quando è stata utilizzata la funzione save. I simboli di sistema che iniziano con il carattere $ (ad es. $0 dalle espressioni regolari o $main-args dalla riga di comando), i simboli delle funzioni integrate e i simboli che contengono nil non vengono salvati.

Nella seconda sintassi, i simboli possono essere forniti come argomenti. Se viene fornito sym-n, viene salvata solo la definizione di quel simbolo. Se sym-n è un contesto, tutti i simboli di quel contesto vengono salvati. È possibile specificare più di un simbolo e possono essere combinati simboli e simboli di contesto. Quando i contesti vengono salvati, le variabili di sistema e i simboli che iniziano con il carattere $ non vengono salvati. Specificando esplicitamente i simboli di sistema causa il slavataggio degli stessi.

Ogni simbolo viene salvato mediante un'istruzione set o, se il simbolo contiene una funzione lambda o macro lambda, mediante le istruzioni define o define-macro.

save ritorna il valore true al termine.

(save "save.lsp")
(save "/home/myself/myfunc.LSP" 'my-func)
(save "file:///home/myself/myfunc.LSP" 'my-func)
(save "http://asite.com:8080//home/myself/myfunc.LSP" 'my-func)
(save "mycontext.lsp" 'mycontext)

;; argomenti multipli
;; multiple args
(save "stuff.lsp" 'aContext 'myFunc '$main-args 'Acontext)

Poiché tutti i simboli di contesto fanno parte del contesto MAIN, il salvataggio di MAIN salva tutti i contesti.

Il salvataggio su un indirizzo URL causerà l'invio di una richiesta HTTP PUT all'URL. In questa modo, è possibile utilizzare save anche per inviare i sorgenti di un programma a nodi/server newLISP remoti. Si noti che è necessario un doppio backslash quando i nomi dei percorsi sono specificati relativamente alla directory root. In modalità HTTP save osserverà un timeout di 60 secondi.

I simboli creati usando sym che sono incompatibili con le normali regole di sintassi per i simboli sono serializzati usando un'istruzione sym invece di un'istruzione set.

save serializza contesti e simboli come se il contesto corrente fosse MAIN. Indipendentemente dal contesto attuale, save genererà sempre lo stesso risultato.

Vedi anche le funzioni load (l'operazione inversa di save) e source, che salva simboli e contesti in una stringa anziché in un file.

*****************
>>>funzione LOAD
*****************
sintassi: (load str-file-name-1 [str-file-name-2 ... ] [sym-context])

Carica e traduce newLISP da un file sorgente specificato in uno o più str-nome-file e valuta le espressioni contenute in tutti i file. Quando il caricamento ha esito positivo, load restituisce il risultato dell'ultima espressione nell'ultimo file valutato. Se non è possibile caricare un file, load genera un errore.

È possibile specificare un simbolo di contesto (sym-context) facoltativo, che diventa il contesto di valutazione, a meno che un tale cambiamento di contesto non sia già presente nel file che si sta caricando. Per impostazione predefinita, i file che non contengono cambiamenti di contesto verranno caricati nel contesto MAIN.

Il parametro str-file-name può contenere URL. Entrambi i metodi http:// e file:// di URL sono supportati.

(load "myfile.lsp")

(load "a-file.lsp" "b-file.lsp")

(load "file.lsp" "http://mysite.org/mypro")

(load "http://192.168.0.21:6000//home/test/program.lsp")

(load "a-file.lsp" "b-file.lsp" 'MyCTX)

(load "file:///usr/local/share/newLISP/mysql.lsp")

Nel caso in cui le espressioni valutate durante il caricamento stiano cambiando il contesto, ciò non influenzerà il modulo di programmazione che esegue il caricamento.

Il contesto corrente dopo l'istruzione load sarà sempre lo stesso di quello prima dell'operazione load.

Le normali specifiche per i file e gli URL possono essere utilizzati nello stesso comando load.

Utilizzare load con URL HTTP può anche essere utilizzato per caricare il codice sorgente da nodi/server remoti di newLISP che hanno sistema operativo UNIX/Linux. In questa modo, load invierà una richiesta HTTP GET all'URL di destinazione. Si noti che è necessario un doppio backslash quando i nomi dei percorsi sono specificati relativamente alla directory root. In modalità HTTP load osserverà un timeout di 60 secondi.

La penultima riga fa caricare i file nel contesto MyCTX. Il carattere quote "'" forza la creazione del contesto se questo non esiste.

L'indirizzo URL file:// è seguito da un terzo / per le specifiche della directory.

*******************
>>>funzione SOURCE
*******************
sintassi: (source)
sintassi: (source sym-1 [sym-2 ... ])

Funziona in modo quasi identico a save, tranne che i simboli e i contesti vengono serializzati su una stringa anziché essere scritti su un file. È possibile specificare più simboli variabili, definizioni e contesti. Se non viene fornito alcun argomento, source serializza l'intero spazio di lavoro di newLISP. Quando i simboli di contesto sono serializzati, anche i simboli contenuti in quel contesto saranno serializzati. I simboli di sistema che iniziano con il carattere $ (simbolo del dollaro) vengono serializzati solo quando menzionati esplicitamente.

I simboli che non appartengono al contesto corrente sono scritti con il loro prefisso di contesto.

(define (double x) (+ x x))

(source 'double)  → "(define (double x)\n  (+ x x))\n\n"

Come con save, la formattazione delle interruzioni di riga e degli spazi iniziali o delle tabulazioni può essere controllata usando la funzione pretty-print.

*************************
>>>funzione PRETTY-PRINT
*************************
sintassi: (pretty-print [int-length [str-tab [str-fp-format]])

Riformatta le espressioni per la print, save o source e quando si stampa in una console interattiva. Il primo parametro, int-length, specifica la lunghezza massima della linea e str-tab specifica la stringa utilizzata per le righe di rientro (indentazione). Il terzo parametro str-fp-format descrive il formato predefinito per la stampa di numeri in virgola mobile. Tutti i parametri sono opzionali. pretty-print restituisce le impostazioni correnti o le nuove impostazioni quando vengono specificati i parametri.

(pretty-print)  → (80 " " "%1.15g")  ; default setting

(pretty-print 90 "\t")  → (90 "\t" "%1.15g")

(pretty-print 100)  → (100 "\t" "%1.15g")

(sin 1)    → 0.841470984807897
(pretty-print 80 " " "%1.3f")
(sin 1)    → 0.841

(set 'x 0.0)
x   → 0.000

Il primo esempio riporta le impostazioni predefinite di 80 per la lunghezza massima della linea e un carattere di spazio per il rientro. Il secondo esempio cambia la lunghezza della linea in 90 e il rientro nel carattere TAB. Il terzo esempio modifica solo la lunghezza della linea. L'ultimo esempio modifica il formato predefinito per i numeri in virgola mobile. Ciò è utile quando si stampano numeri in virgola mobile non formattati senza parti frazionarie e questi numeri dovrebbero essere ancora riconoscibili come numeri in virgola mobile. Senza il formato personalizzato, x verrebbe stampato come 0 indistinguibile dal numero in virgola mobile. Sono interessate tutte le situazioni in cui vengono stampati numeri in virgola mobile non formattati.

Si noti che non è possibile utilizzare la stampa fine per impedire la stampa delle interruzioni di riga. Per sopprimere completamente la stampa carina, utilizzare la stringa di funzioni per convertire l'espressione in una stringa non formattata come segue:

;; stampa senza formattazione
;; print without formatting

(print (string my-expression))


=====================================
 AMBITO (SCOPE) DINAMICO E LESSICALE
=====================================

newLISP utilizza l'ambito dinamico all'interno dei contesti. Un contesto è uno spazio di nomi lessicalmente chiuso. In questo modo, parti di un programma newLISP possono vivere in spazi di nomi diversi sfruttando l'ambito lessicale.

Quando i simboli dei parametri di un'espressione lambda sono associati ai relativi argomenti, i vecchi collegamenti vengono inseriti in una pila. newLISP ripristina automaticamente le associazioni originali  delle variabili quando termina la funzione lambda.

Nell'esempio seguente viene illustrato il meccanismo di ambito dinamico.

(set 'x 1)
;-> 1
(define (f) x)
;-> (lambda () x)
(f)
;-> 1
(define (g x) (f))
;-> (lambda (x) (f))
(g 0)
;-> 0
(f)
;-> 1
> _

La variabile x è prima impostata su 1. Ma quando viene chiamata (g 0), x è associato a 0 ed x viene è riconosciuto da (f) come 0 durante l'esecuzione di (g 0). Dopo l'esecuzione di (g 0), la chiamata a (f) riporterà x di nuovo al valore 1.

Questo comportamento è diverso dai meccanismi di ambito lessicale che troviamo in linguaggi come C o Java, dove il legame dei parametri locali avviene solo all'interno della funzione. Nei linguaggi lessicali come il C, (f) stamperebbe sempre i collegamenti globali del simbolo x con 1.

Tieni presente che il passaggio di simboli quotati a una funzione definita dall'utente causa un conflitto di nomi se lo stesso nome di variabile viene utilizzato come parametro di funzione:

(define (inc-symbol x y) (inc (eval x) y))
;-> (lambda (x y) (inc (eval x) y))
(set 'y 200)
;-> 200
(inc-symbol 'y 123)
;-> 246
y
;-> 200; y è ancora 200

Poiché la y globale condivide lo stesso simbolo del secondo parametro della funzione, inc-symbol restituisce 246 (123 + 123), lasciando inalterato il globale. La cattura delle variabili in ambito dinamico può essere uno svantaggio quando si passano i riferimenti dei simboli a funzioni definite dall'utente. newLISP offre diversi metodi per evitare la cattura delle variabili.

- La funzione "args" può essere utilizzata quando si passano simboli.
- Una o più funzioni definite dall'utente possono essere inserite in uno spazio dei nomi chiamato proprio contesto ("context"). Un conflitto di nomi di simboli non può verificarsi quando si accede a simboli e si chiamano funzioni dall'esterno del contesto di definizione.

I contesti devono essere utilizzati per raggruppare le funzioni correlate quando si creano interfacce o librerie di funzioni. Ciò racchiude le funzioni con un "recinto" lessicale, evitando così conflitti tra i nomi delle variabili e le funzioni chiamate.

In seguito vedremo che newLISP utilizza i contesti per diverse forme di ambiti lessicali.


==========
 CONTESTI
==========

In newLISP, i simboli possono essere separati in spazi dei nomi chiamati contesti. Ogni contesto ha una tabella di simboli privata separata da tutti gli altri contesti. I simboli noti in un contesto sono sconosciuti in altri, quindi lo stesso nome può essere usato in diversi contesti senza conflitti.

I contesti sono usati per costruire moduli di definizioni di variabili e funzioni isolate. Possono anche essere usati per costruire dizionari per coppie di valore e chiave. I contesti possono essere copiati e assegnati dinamicamente alle variabili o passati come argomenti per riferimento. Poiché i contesti in newLISP hanno spazi dei nomi separati lessicalmente, consentono la programmazione con scope lessicale e stili di programmazione software orientati agli oggetti.

I contesti sono identificati da simboli che fanno parte del contesto principale MAIN (radice). Sebbene i simboli di contesto siano in maiuscolo in questo capitolo, possono essere utilizzati anche i simboli in minuscolo.

Oltre ai nomi di contesto, MAIN contiene i simboli per funzioni incorporate (predefinite) e simboli speciali come true e nil. Il contesto MAIN viene creato automaticamente ogni volta che viene eseguito newLISP. Per vedere tutti i simboli in MAIN, inserere la seguente espressione dopo aver avviato newLISP:

(symbols)

Per vedere tutti i simboli in MAIN che puntano ai contesti (associati):

(filter context? (map eval (symbols)))

Per vedere tutti i simboli del contesto MAIN quando MAIN non è il contesto corrente:

(filter context? (map eval (symbols MAIN)))

Creazione di simboli nei contesti
---------------------------------
Le seguenti regole dovrebbero semplificare il processo di comprensione dei contesti identificando a quale contesto vengono assegnati i simboli creati.

1) newLISP dapprima analizza e traduce ogni espressione a partire dal livello più alto. Tutti i simboli vengono creati durante questa fase. Dopo che l'espressione è stata tradotta, viene valutata.

2) Un simbolo viene creato quando newLISP lo vede per la prima volta, mentre chiama le funzioni load, sym o eval-string. Quando newLISP legge un file sorgente, i simboli vengono creati "prima" che avvenga la valutazione. La funzione reader-event può essere utilizzata per ispezionare l'espressione dopo la lettura e la traduzione, ma prima della valutazione. La funzione read-expr può essere utilizzata per leggere e tradurre il sorgente newLISP senza valutazione.

3) Quando si incontra un simbolo sconosciuto durante la traduzione del codice, una ricerca per la sua definizione inizia nel contesto corrente. In caso contrario, la ricerca continua all'interno di MAIN per una funzione predefinita, un contesto o un simbolo globale. Se non viene trovata alcuna definizione, il simbolo viene creato localmente all'interno del contesto corrente.

4) Una volta che un simbolo viene creato e assegnato a un contesto specifico, apparterrà a tale contesto in modo permanente o finché non verrà eliminato utilizzando la funzione di eliminazione delete.

5) Quando viene valutata una funzione definita dall'utente, il contesto viene commutato allo spazio nome che possiede quel simbolo.

6) Il cambio di contesto influenza solo la creazione del simbolo durante load, sym o eval-string. load per default carica in MAIN tranne quando il contesto cambia al livello superiore del file caricato (all'inizio). Per uno stile migliore, è necessario specificare sempre il contesto quando vengono utilizzate le funzioni sym e eval-string. Normalmente uno switch di contesto dovrebbe essere effettuato solo al livello più alto di un programma (all'inizio), mai all'interno di una funzione.

Creare contesti
---------------
I contesti possono essere creati usando la funzione di contesto o tramite la creazione implicita. Il primo metodo è usato quando si scrivono porzioni più grandi di codice appartenenti allo stesso contesto:

(contesto 'FOO)

(imposta 'var 123)

(define (func x y z)
    ...)

(contesto PRINCIPALE)
Se il contesto non esiste ancora, il simbolo di contesto deve essere citato. Se il simbolo non è quotato, newLISP assume che il simbolo sia una variabile che contiene il simbolo del contesto da creare. Poiché un contesto valuta se stesso, i contesti già esistenti come MAIN non richiedono la citazione.

Quando newLISP legge il codice sopra, leggerà, quindi valuterà la prima affermazione: (context 'FOO). Ciò fa sì che newLISP cambi lo spazio dei nomi in FOO ei seguenti simboli var, x, y e z verranno tutti creati nel contesto FOO durante la lettura e la valutazione delle espressioni rimanenti.

Un simbolo di contesto è protetto dal cambiamento. Una volta che un simbolo fa riferimento a un contesto, non può essere utilizzato per nessun altro scopo, tranne quando si utilizza l'eliminazione.

Per fare riferimento a var o func da qualsiasi altra parte al di fuori dello spazio dei nomi FOO, devono essere preceduti dal nome del contesto:

FOO: var
;-> 123

(FOO: func p q r)
Si noti che nell'esempio sopra, solo func appartiene allo spazio dei nomi FOO, i simboli p q r fanno tutti parte del contesto corrente da cui viene effettuata la chiamata FOO: func.

La funzione simboli è usata per mostrare tutti i simboli appartenenti ad un contesto:

(simboli FOO)
;-> (FOO: func FOO: var FOO: x FOO: y FOO: z)

; o dall'interno del contesto i simboli sono mostrati senza prefisso di contesto
(contesto FOO)
;-> (func x y z)
(symbols)


================
 USO DEI MODULI
================

Un modulo è un file sorgente di newLISP che contiene funzioni specifiche relative ad un determinato argomento.
Questa è la lista dei moduli che newLISP mette a disposizione:

- canvas.lsp
Questo modulo genera pagine HTML adatte per i browser che riconoscono i tag grafici canvas HTML-5.

- cgi.lsp
Questo modulo definisce gli strumenti di base per la gestione CGI per l'elaborazione di richieste e cookie CGI GET e CGI POST.

- crypto.lsp
Modulo per il binding della libreria crypto SSL (algoritmi di hashing MD5 e SHA-1).

- ftp.lsp
Modulo con funzioni per il trasferimento di file tramite protocollo FTP.

- gsl.lsp
Modulo per l'utilizzo di alcune funzioni della libreria scientifica GNU (devono essere installate le librerie 'libgsl' e 'libgslcblas').

- infix.lsp
Modulo per analizzare le espressioni infisse, prefisse o postfisse passate come stringa. Restituisce una espressione newLISP che può essere valutata (cattura gli errori di sintassi).

- mysql.lsp
Modulo per interfacciare il database relazionale MySQL 5.x.

- odbc.lsp
Modulo per interfacciare i database tramite le librerie ODBC.

- plot.lsp
Modulo con funzioni per la creazione di grafici di dati.

- pop3.lsp
Modulo con funzioni per utilizzo della posta POP3.

- postgres.lsp
Modulo per interfacciare il database relazionale PostgreSQL (PostgreSQL 9.4).

- postscript.lsp
Modulo con funzioni per la creazione di file PostScript.

- smtp.lsp
Modulo per la gestione della posta tramite protocollo SMTP.

- smtpx.lsp
Modulo per la gestione della posta tramite protocollo SMTP (-nix).

- sqlite3.lsp
Modulo per interfacciare il database relazionale sqlite.

- stat.lsp
Modulo per statistiche di base e librerie di plottaggio.

- unix.lsp
Module with interface to various UNIX libc functions

- xmlrpc-client.lsp
Modulo con funzioni per interfaccia la libreria libc di UNIX.

- zlib.lsp
Modulo con funzioni per compressione/decompressione di file con la libreria zlib.


La variabile di ambiente newLISPDIR
-----------------------------------

Durante l'avvio newLISP imposta la variabile di ambiente newLISPDIR, se non è già impostata. Su Linux, BSDs, macOS e altri Unix la variabile /usr/local/share/newLISP. Su MS Windows la variabile viene impostata dove è stato installato newLISP.

La variabile d'ambiente newLISPDIR è utile quando si caricano moduli (file) installati con newLISP:

(load (append (env "newLISPDIR") "/modules/mysql.lsp"))

Una funzione predefinita "module" può essere utilizzata per abbreviare il parametro relativo alla cartella dell'istruzione load:

(module "mysql.lsp")


Il file di inizializzazione init.lsp
------------------------------------

Prima di caricare qualsiasi file specificato sulla riga di comando e prima che vengano visualizzati il banner e il prompt, newLISP tenta di caricare un file .init.lsp dalla cartella home dell'utente che esegue newLISP. Su macOS, Linux e altri Unix, la cartella home si trova nella variabile di ambiente HOME. Su MS Windows il nome della cartella è contenuto nella variabile di ambiente USERPROFILE (o DOCUMENT_ROOT).

Se un file .init.lsp non può essere trovato nella cartella home, allora newLISP prova a caricare il file init.lsp dalla cartella trovata nella variabile di ambiente newLISPDIR.

Quando newLISP viene eseguito come libreria condivisa, viene cercato un file di inizializzazione nella variabile di ambiente newLISPLIB_INIT. È necessario specificare il nome percorso completo del file di inizializzazione. Se newLISPLIB_INIT non è definita, nessun file di inizializzazione verrà caricato dal modulo della libreria.

Sebbene newLISP non richieda init.lsp per l'esecuzione, è utile per definire funzioni e variabili a livello di sistema.

Nota: nessun file di inizializzazione viene caricato durante il caricamento di programmi collegati (linked) o quando viene specificata una delle opzioni -n, -h, -x.

Nel mio sistema risulta:

(env "newLISPDIR")
;-> "C:\\newLISP"

(env "PROGRAMFILES")
;-> "C:\\Program Files"

(env "USERPROFILE")
;-> "C:\\Users\\u42"

(env "DOCUMENT_ROOT")
;-> nil

Esempi sull'utilizzo dei moduli
-------------------------------

Vediamo ora come utilizzare i moduli con alcuni esempi. Cominciamo con il modulo "postscript.lsp" che ci permette di creare file postscript. Il seguente programma crea un file pdf con alcune forme geometriche create con la superformula 2D.

; Per eseguire questo file, digitare: (load "superformula.lsp") nella REPL di newLISP.
; superformula2D.lsp
; by cameyo 2019
;
; Superformula 3D in coordinate polari:
; r(t) = (|cos(m1*t/4)/a|^n2 + |sin(m2*t/4)/b|^n3)^-1/n1
; x = mag*r*cos(t);
; y = mag*r*sin(t);

; Caricamento del modulo
;(load (append (env "newLISPDIR") "/modules/postscript.lsp"))
(module "postscript.lsp")

; Sfondo
(ps:goto 0 0)
(ps:fill-color 0 0 0)
(ps:line-color 0 0 0)
;(ps:shape '((0 792) (90 612) (90 792) (90 612)) true)
(ps:rectangle 612 792 true)
; Setup iniziale
(ps:line-join 2)
(ps:line-width 0.25)
(ps:fill-color 0.9 0.9 0.9)
(ps:circle 0 0)
; Centro della pagina
(setq xc (/ 612 2))
(setq yc (/ 792 2))
; Parametri
(setq m1 10)
(setq m2 10)
(setq a 1)
(setq b 1)
(setq n2 3)
(setq n3 3)
(setq n1 2)
(setq step 0.001)
(setq t 0.0)
;ciclo di disegno formula
(setq i 0)
(while (< i 6)
  (ps:fill-color (random) (random) (random))
  (setq mag (+ 150 (* i 20)))
  (while (< t 6.29)
    (setq r1 (pow (abs (div (cos (div (mul m1 t) 4)) a)) n2))
    (setq r2 (pow (abs (div (sin (div (mul m2 t) 4)) b)) n3))
    (setq r (pow (add r1 r2) (div -1.0 n1)))
    (setq x (add xc (mul mag r (cos t))))
    (setq y (add yc (mul mag r (sin t))))
    (setq t (add t step))
    (ps:goto x y)
    (ps:circle .5 true)
  )
  (++ i)
  (setq t 0.0)
)
; firma
(ps:line-color 0.77 0.77 0.77)
(ps:goto 12 12)
;(ps:angle 90)
(ps:angle 0)
(ps:font "Helvetica" 10)
(ps:text "newLISP 2019")
; salva il file postscript
(ps:save "sf2d01.ps")
; conversione del file .ps al file .pdf (ghostscript)
(! "ps2pdf sf2d01.ps sf2d03.pdf")
; eof

Questo è il file batch per la conversione da file .ps a file .pdf:

------ Inizio file batch
rem convert postscript (.ps) file to portable document format file (.pdf)
rem with ghostscript
rem ps2pdf <file.ps> <file.pdf>
rem cameyo 2019

rem standard
rem gs -sDEVICE=pdfwrite -dBATCH -sOutputFile=aFile.pdf -r300 aFile.ps

rem windows 64 bit ghostscript
rem "c:\Program Files\gs\gs9.15\bin\gswin64c.exe" -sDEVICE=pdfwrite -dBATCH -sOutputFile=%2.pdf -r300 %1

rem windows 64 bit ghostscript (no pause)
"c:\Program Files\gs\gs9.15\bin\gswin64c.exe" -q -dNOPAUSE -sDEVICE=pdfwrite -dBATCH -sOutputFile=%2 -r300 %1
------ Fine file batch

Vediamo ora il modulo "infix.lsp", che permette di trsformare le espressioni infisse, prefisse o suffisse passate come stringhe. Restituisce una espressione newLISP, che può essere valutata (cattura gli errori di sintassi).

Carichiamo il modulo:

(module "infix.lsp")

Conversione di formule dal formato infix a newLISP:

(INFIX:xlate "(cos(m1 * t / 4) / a)")
;-> (div (cos (div (mul m1 t) 4)) a)

(INFIX:xlate "(-b + (sqrt (b ^ 2 - 4 * a * c))) / (2 * a)")
;-> (div (add -b (sqrt (sub (pow b 2) (mul (mul 4 a) c)))) (mul 2 a))

(INFIX:xlate "(a*x*x + b*x + c)")
;-> (add (add a*x*x b*x) c)

(INFIX:xlate "(a + b)/(c - d)")
;-> (div (add a b) (sub c d))

Conversione di formule dal formato postfix (rpn) a newLISP:

(INFIX:xlate "(3 4 5 + +)")
;-> (add 3 (add 4 5))

(INFIX:xlate "(5 6 + 5 7 * +)")
;-> (add 5 (add 6 (mul 5 7)))

Come ultimo esempio vediamo l'utilizzo del modulo "plot.lsp" che permette di creare alcuni tipi di grafici.
Questo modulo utilizza guiserver.jar che deve essere installato sulla cartella di newLISP.
Importazione del modulo:

(module "plot.lsp")

Test del modulo (vengono creati due grafici, anche come file .png):

(test-plot)

Un altro modulo molto utile è quello che gestisce il protocollo ftp (File Transfer Protocol): "ftp.lsp". L'utilizzo è molto semplice:

; load ftp module
(module "ftp.lsp")

;; Functions:
;; (FTP:get <str-user-id> <str-password> <str-host> <str-dir> <str-file-name>)
;; (FTP:put <str-user-id> <str-password> <str-host> <str-dir> <str-file-name>)

(set 'FTP:debug-mode true)
(FTP:put "ADMIN" "pwd-admin" "ftpzone.com" "VAS" "ex01ftp.png")
;-> true

(FTP:get "USER" "pwd-user" "ftpzone.com" "VAS" "olmeco.png")
;-> true


======================
 HASH MAP E DIZIONARI
======================

Vediamo come simulare la struttura dati hash map con i contesti (namespace).
Un funtore predefinito di un contesto che contiene nil e si trova nella posizione di operatore simula a una funzione di hash per la costruzione di dizionari con (chiave associativa → accesso al valore).

Crea un contesto (namespace) e un funtore di default di nome myHash che contiene il valore nil:

(define myHash:myHash)
;-> nil

In alternativa al metodo precedente, è possibile utilizzare un contesto predefinito e il funtore di default Tree per instanziare un nuovo cotesto:

(new Tree 'myHash)
;-> myHash

Entrambi i metodi producono lo stesso risultato, ma il secondo metodo protegge anche il funtore predefinito Myhash: Myhash da possibili modifiche.

Adesso possiamo usare il contesto definito come una hash map.

Creaiamo la chiave key con valore 123:

(myHash "var" 123)
;-> 123

Recuperiamo il valore tramite la chiave:

(myHash "var")
;-> 123

Possiamo assegnare altri valori al dizionario:

(myHash "x" "stringa")
;-> "stringa"

(myHash "x")
;-> "stringa"

(myHash "var")
;-> 123

Se una chiave non esiste, allora newLISP restituisce nil:

(myHash "valore")
;-> nil

Per eliminare una chiave occorre assegnarle il valore nil:

(myHash "var" nil)
;-> nil

(myHash "var")
;-> nil

(myHash "var" 123)
;-> 123

Per conoscere tutti i simboli del contesto myHash:

(symbols myHash)
;-> (myHash:_var myHash:_x myHash:myHash)

Le chiavi (simboli) var e x vengono memorizzate precedute dal contesto e dal carattere underscore "_".
Aggiungiamo una chiave che inizia per "_":

(myHash "_y" '(1 2))
;-> (1 2)

(dolist (el (symbols myHash)) (println el))
;-> myHash:__y
;-> myHash:_var
;-> myHash:_x
;-> myHash:myHash
;-> myHash:myHash

I simboli delle variabili create in questo modo possono contenere spazi o altri caratteri normalmente non consentiti nei nomi dei simboli newLISP:

(myHash "il numero" 123)
;-> 123
(myHash "#1234" "hello world")
;-> "hello world"
(myHash "var" '(a b c d))
;-> (a b c d)
(myHash "il numero")
;-> 123
(myHash "#1234")
;-> "hello world"
(myHash "var")
;-> (a b c d)

Comunque è consigliabile di non eccedere nell'utilizzo di questi caratteri normalmente non consentiti.

Il simbolo chiave può anche essere un numero intero (che verrà internamente convertito in stringa in modo trasparente all'utente):

(myHash 1 "uno")
;-> "uno"

(myHash 1)
;-> "uno"

(myHash "1")
;-> "uno"

Possiamo vedere tutti gli elementi del dizionario (coppie chiave-valore) utilizzando (valutando) il nome del contesto:

(myHash)
;-> (("#1234" "hello world") ("1" "uno") ("_y" (1 2))
;->  ("il numero" 123) ("var" (a b c d)) ("x" "stringa"))

Ma myHash non è una lista:

(list? myHash)
;-> nil

Però possiamo usare lo stesso dolist su un contesto hash per elencare tutte le coppie chiave-valore del dizionario::

(dolist (cp (myHash)) (println (list (cp 0) (cp 1))))
;-> ("#1234" "hello world")
;-> ("1" "uno")
;-> ("_y" (1 2))
;-> ("il numero" 123)
;-> ("var" (a b c d))
;-> ("x" "stringa")
;-> ("x" "stringa")

Per creare una lista di associazione dal dizionario hash basta assegnare la valutazione del contesto (dizionario) ad una variabile:

(setq alst (myHash))
;-> (("#1234" "hello world") ("1" "uno") ("_y" (1 2))
;->  ("il numero" 123) ("var" (a b c d)) ("x" "stringa"))

(list? alst)
;-> true

Per popolare un dizionario possiamo anche usare una lista:

(myHash '((3 4) (5 6)))
;-> myHash

(myHash)
;-> (("#1234" "hello world") ("1" "uno") ("3" 4) ("5" 6) ("_y" (1 2))
;->  ("il numero" 123) ("var" (a b c d)) ("x" "stringa"))

Nota: le chiavi del dizionario sono ordinate in maniera lessicografica.

Come molte delle funzioni integrate, le espressioni hash restituiscono un riferimento al loro contenuto che può essere modificato direttamente:

(pop (myHash "var"))
;-> a

(myHash "var")
;-> (b c d)

(push 'z (myHash "var"))
;-> (z b c d)

(myHash "var")
;-> (z b c d)

Quando si impostano i valori hash, la variabile anaforica di sistema "$it" può essere utilizzata per riferirsi al vecchio valore quando si imposta il nuovo:

(myHash "bar" "hello world")
;-> "hello world"

(myHash "bar" (upper-case $it))
;-> "HELLO WORLD"

(myHash "bar")
;-> "HELLO WORLD"

I valori hash possono essere modificati anche usando "setf":

(myHash "bar" 123)
;-> 123

(setf (myHash "bar") 456)
;-> 456

(myHash "bar")
;-> 456

Ma fornire il valore come secondo parametro alle funzioni hash è più breve da scrivere ed è anche più veloce.

I dizionari possono essere facilmente salvati in un file e ricaricati in un secondo momento:

; save dictionary
(save "myHash.lsp" 'myHash)
;-> true

Ecco il contenuto del file "myHash.lsp":

(context 'myHash)
(set '_#1234 "hello world")
(set '_3 4)
(set '_5 6)
(set '__y '(1 2))
(set '_bar 456)
(set  (sym "_il numero" MAIN:myHash)  123)
(set '_var '(MAIN:a MAIN:b MAIN:c MAIN:d))
(set '_x "stringa")
(context MAIN)

; load dictionary
(load "myHash.lsp")

Internamente le stringhe chiave vengono create e memorizzate come simboli nel contesto dell'hash. Come abbiamo viato, tutte le stringhe chiave sono precedute da un carattere di sottolineatura "_". Questo protegge contro la sovrascrittura del simbolo di default a dalle funzioni set and sym che sono necessarie per caricare il contesto dell'hash (namespace) da disco o tramite http. Nota le seguente differenza:

(myHash)
;-> (("#1234" "hello world") ("1" "uno") ("3" 4) ("5" 6) ("_y" (1 2))
;->  ("bar" "HELLO WORLD") ("il numero" 123) ("var" (z b c d)) ("x" "stringa"))

(symbols myHash)
;-> (myHash:_#1234 myHash:_1 myHash:_3 myHash:_5 myHash:__y myHash:_bar
;->  myHash:_il numero myHash:_var myHash:_x myHash:myHash)

Nella prima riga i simboli di hash sono mostrati come stringhe senza i caratteri di sottolineatura. La seconda riga mostra la forma interna dei simboli con anteposti i caratteri di sottolineatura.

Per vedere se esiste un valore nel dizionario occorre interrogare tutte le chiavi:

(define (hasValue val hash)
  (catch
    (dolist (cp (hash))
      (if (= (cp 1) val) (throw true))
    )
  )
)

(hasValue '(1 2) myHash)
;-> true

(hasValue '(1) myHash)
;-> nil

Per vedere se esiste una chiave nel dizionario non occorre interrogare tutte le chiavi:

(myHash "var")
;-> (z b c d)

(myHash "k")
;-> nil

Quindi possiamo scrivere la seguente funzione:

(define (hasKey? key hash) (if (hash key) true nil))

(hasKey? "var" myHash)
;-> true

(hasKey? "#1234" myHash)
;-> true

Possiamo fare lo stesso con un ciclo dolist:

(define (hasKey? key hash)
  (catch
    (dolist (cp (hash))
      (if (= (cp 0) key) (throw true))
    )
  )
)

(hasKey? "var" myHash)
;-> true

(hasKey? "#1234" myHash)
;-> true

Definiamo alcune funzioni per gestire le hash map (dizionario).

Creazione di una nuova hash map:
--------------------------------

(define (newHash hash) (new Tree hash))

(newHash 'dictA)
;-> dictA
(dictA)
;-> ()
(newHash 'dictB)
;-> dictB

Creazione/modifica di una coppia chiave -> valore nella hash map:
-----------------------------------------------------------------

(define (addHash key value hash) (hash key value))

(addHash "var" 20 dictA)
;-> 10
(addHash "num" 42 dictA)
;-> 42
(dictA)
;-> (("num" 42) ("var" 20))

Cancellazione di una coppia chiave -> valore:
---------------------------------------------

(define (removeHash key hash) (hash key nil))

(removeHash "var" dictA)
;-> nil
(dictA)
;-> (("num" 42))
(addHash "var" 22 dictA)
;-> 22

Conversione da hash map a lista associativa:
--------------------------------------------
Creiamo una lista con tutte le coppie chiave-valore del dizionario

(define (hash2list hash) (hash))

(setq lstA (hash2list dictA))
;-> (("num" 42) ("var" 22))

Aggiornamento hash map da lista associativa:
--------------------------------------------

(define (list2hash lst hash) (if (= hash nil) nil (hash lst)))

(list2hash lstA dictB)
;-> dictB
(dictB)
;-> (("num" 42) ("var" 22))

Se la hash map non esiste, allora viene restituito nil:

(list2hash lstA dictC)
;-> nil

Lunghezza della hash map:
-------------------------

(define (lenHash hash) (if (= hash nil) nil (length (hash))))

(lenHash dictA)
;-> 2

(lenHash dictC)
;-> nil

Controllo presenza valore in hash map:
--------------------------------------

(define (hasValue val hash)
  (if (= hash nil) nil
    (catch
      (dolist (cp (hash))
        (if (= (cp 1) val) (throw true))
      )
    )
  )
)

(hasValue 22 dictA)
;-> true
(hasValue 22 dictC)
;-> nil

Controllo presenza chiave in hash map:
--------------------------------------

(define (hasKey key hash) (if (= hash nil) nil (if (hash key) true nil)))

(hasKey "num" dictA)
;-> true
(hasKey "nome" dictA)
;-> nil
(hasKey "num" dictC)
;-> nil

Estrazione di tutte le chiavi in una lista:
-------------------------------------------

(define (getKeys hash)
  (local (out)
    (dolist (cp (hash))
      (push (cp 0) out -1)
    )
  out
  )
)

(getKeys myHash)
;-> ("#1234" "1" "_y" "bar" "il numero" "var" "x")

Estrazione di tutti i valori in una lista:
------------------------------------------

(define (getValues hash)
  (local (out)
    (dolist (cp (hash))
      (push (cp 1) out -1)
    )
  out
  )
)

(getValues myHash)
;-> ("hello world" "uno" (1 2) "hello world" 123 (a b c d) "stringa")

Duplicazione (copia) di un hash:
--------------------------------
Basta assegnare il dizionario ad una variabile.

(setq Pippo myHash)
;-> myHash

(Pippo)
;-> (("#1234" "hello world") ("3" 4) ("5" 6) ("_y" (1 2)) ("bar" 456)
;->  ("il numero" 123) ("var" (a b c d)) ("x" "stringa"))
