=======================

  newLISP IN GENERALE

=======================

==============
 INTRODUZIONE
==============

Questi appunti introducono all'uso del linguaggio newLISP per le elaborazioni numeriche (e anche per altre cose). È necessaria una conoscenza di base della programmazione in newLISP. Un'ottima scelta per imparare questo linguaggio è il libro "Introduction to newLISP" disponibile come WikiBooks all'indirizzo:  http://en.wikibooks.org/wiki/Introduction_to_newLISP
Comunque per avere una panoramica sul linguaggio potete anche consultare "newLISP in 21 minuti" di John W. Small oppure "newLISP per programmatori" di Dmitry Chernyak entrambi riportati in appendice.
Maggiori informazioni sono reperibili al sito ufficiale del linguaggio:

http://www.newLISP.org/

Questo documento è in continua evoluzione e aggiornamento ed è scritto non da un programmatore professionista, ma da un principiante che studia ed utilizza newLISP per divertimento e per risolvere problemi di matematica ricreativa. Qualche volta (ultimamente sempre più spesso) uso newLISP anche nel mio lavoro quotidiano.
Consigli, correzioni e suggerimenti sono i benvenuti.

Per convenzione i comandi di input della REPL (Read Eval Print Loop) non contengono il prompt di newLISP ">".
L'output della REPL viene preceduto dalla stringa ";-> ".
Nel testo sono riportate le descrizioni di alcuni comandi predefiniti tradotte dal manuale di riferimento ("newLISP Reference"). Queste descrizioni sono precedute dalla stringa ">>>funzione". Ad esempio, per trovare la funzione "map", ricercare la stringa ">>>funzione MAP".

Caratteristiche del sistema utilizzato
--------------------------------------
S.O. Windows 10 Professional 64-bit
Linguaggio: newLISP 10.7.5 UTF-8
Motherboard: ASUS GTX750-PH/ASUS TUF Z390-PLUS
CPU: Intel Core i5-4460/Intel Core i7-9700
RAM: 16Gb DDR3 800mHz/32Gb DDR4 1330mHz
GPU: NVIDIA Geforce GTX 750 SDRAM: 2Gb GDDR5

Nota:
I riferimenti principali di questo documento sono:

1) "newLISP User Manual and Reference" di Lutz Mueller

2) "Code Patterns in newLISP" di Lutz Muller

3) "Introduction to newLISP" di Cormullion

Tutti gli articoli tradotti presenti in questo documento sono sotto il copyright dei rispettivi autori. Ogni errore di traduzione è imputabile soltanto a me.
Per quanto possibile ho sempre riportato il nome degli autori delle funzioni realizzate da altri programmatori utilizzate in questo documento (trovate e prese da forum, blog, ecc.).
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

Seguendo le istruzioni riportate in appendice potete leggere il documento e contemporaneamente eseguire il codice che ritenete opportuno. Questo è possibile anche utilizzando l'editor gratuito Visual Studio Code (disponibile per windows, mac e linux).


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

Oppure possiamo usare la funzione "real-path":

(real-path)
;-> "c:\newLISP\note"

Se non ci troviamo nella cartella corretta possiamo cambiare cartella con il comando "change-dir":

(change-dir "c://newLISP/note")
;-> true

Verifichiamo:

(real-path)
;-> "c:\newLISP\note"

Questa sarà la cartella di default per la REPL.

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
In newLISP viene usato (per convenzione e opzionale) come separatore tra:
gli argomenti di una funzione e le variabili locali di una funzione.
In questo modo si aumenta la leggibilità del programma (e non bisogna ridefinire le variabili locali).
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

Come detto prima, in genere la virgola viene usata come separatore tra gli argomenti di una funzione e le variabili locali di una funzione. In questo modo le variabili locali sono inizializzate al valore nil e non devono essere dichiarate nuovamente all'interno della funzione (per esempio con "let" o "local"):

(define (test a b , t1 t2)
  (println t1 " " t2)
  (if t1
    (setq t1 (* a t1))
    (setq t1 a)
  )
  (if t2
    (setq t2 (* b t2))
    (setq t2 b)
  )
  (list t1 t2)
)

Proviamo la funzione con due parametri:

(test 1 2)
;-> nil nil
;-> (1 2)
(list t1 t2)
;-> (nil nil)

Proviamo la funzione con 5 parametri (la virgola è un parametro!):

(test 1 2 , 10 20)
;-> 10 20
;-> (10 40)
(list t1 t2)
;-> (nil nil)

Le funzioni di incremento e decremento "inc", "++" ,"dec" e "--" considerano il valore nil come 0:

(define (test a , b) (inc b))
(test)
;-> 1

(define (test a , b) (++ b))
(test)
;-> 1

Altre funzioni generano un errore con una variabile di valore nil:

(define (test a , b)  (setq a (+ b 1)))
(test)
;-> ERR: value expected in function + : nil
;-> called from user function (test)

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

Risultato errato: newLISP associa solo i primi due argomenti 15 e 5 e non considera 21.

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
*****************
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
Applichiamo la funzione map con una funzione lambda che somma gli elementi della sottolista:

(map (lambda (x) (apply + x)) lst)
;-> (4 7 11)

Secondo metodo
Utilizziamo la funzione "curry" per rimpiazzare la funzione lambda:

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

Non serve quotare "a" ("setq" non valuta il primo argomento):

(setq a '(1 2 3))
;-> (1 2 3)

Assegnazione multipla:

(setq a 1 b 2 c 3)
;-> 3
a b c
;-> 1
;-> 2
;-> 3

Usando la funzione "nth" oppure l'indicizzazione implicita (gli indici iniziano da zero).

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

Assegnazione e modifica di stringhe:

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
Il primo simbolo di un contesto ha lo stesso nome del contesto in cui è contenuto e viene chiamato "funtore" di default del contesto. In questo caso il contesto si chiama "gen" e quindi il funtore si chiama "gen". Quando si utilizza un nome di contesto al posto di un nome di funzione, newLISP assume il funtore predefinito. Quindi possiamo chiamare la nostra funzione generatore usando (gen). Non è necessario chiamare la funzione usando (gen:gen), (gen) verrà impostato automaticamente su (gen:gen).


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

Nota: sebbene i numeri interi siano a 64 bit, se utilizziamo newLISP a 32 bit i puntatori di indirizzi di memoria rimangono a 32 bit.


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

Vediamo un altro esempio:

(define (pow2 n)
    (println (trim (format "%16.f" (pow 2 n))))
    (format "%16.f" (pow 2 n)))

(pow2 38)
;-> 274877906944
;-> "    274877906944"

(pow2 52)
;-> 4503599627370496
;-> "4503599627370496"

L'ultimo esempio mostra la massima risoluzione che possiamo avere con i numeri double float di newLISP.

La funzione "trim" rimuove gli spazi davanti per numeri inferiori a 16 cifre.
Se si stampa senza formattare newLISP sceglierà il formato "%g" e fornisce 9 cifre di precisione. Quando formattiamo a destra otteniamo fino a 15/16 cifre di precisione (52 bit)
quando si utilizzano double float a 64 bit.


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

Alcune funzioni convertono automaticamente i numeri floating-point in numeri interi e viceversa.
Se utilizziamo operatori composti da lettere dell'alfabeto (es. "add", "sub", etc)  allora newLISP converte i numeri in floating-point.
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
Comunque in alcuni casi è possibile perdere in precisione, per esempio se utilizziamo un numero intero molto grande con una funzione che lo converte in floating-point:

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
Il terzo campo, lungo ventitrè bits, rappresenta la mantissa del numero binario spresso in notazione scientifica. Nel caso in esame vale 1.01101. A questo punto occorre notare che tutti i numeri binari espressi in notazione scientifica hanno un "1" prima della virgola, per cui nella rappresentazione IEE754 questo viene sottointeso. Inoltre, al valore effettivo della mantissa dell'esempio: 01101, vengono aggiunti tanti "0" quanti ne servono per completare il campo a 23 bits è perciò si ha:

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
Per risolvere questo problema potremmo utilizzare le frazioni intere per i calcoli e convertire la frazione finale in un numero floating-point.


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
;-> 3.141592653589793
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
****************
sintassi: (nth int-index list)
sintassi: (nth int-index array)
sintassi: (nth int-index str)

sintassi: (nth list-indices list)
sintassi: (nth list-indices array)

Nel primo gruppo di sintassi "nth" usa il valore di int-index per individuare un indice in una lista, un vettore o una stringa e restituisce l'elemento trovato a quell'indice.
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

Definiamo un vettore di 100000 elementi:
(silent (setq arr (array 100000 (sequence 1 100000))))

Definiamo una lista di 100000 elementi:
(silent (setq lst (array-list arr)))

Definiamo tre funzioni che fanno la stessa cosa (costruiscono una lista) con le seguenti varianti:

1) Uso di "dolist" con la lista

(define (try-list lst)
  (setq outlst '())
  (dolist (el lst)
    (push el outlst -1)
  )
)

2) Uso di "dolist" con il vettore

(define (try-array-as-list arr)
  (setq outarr '())
  (dolist (el arr)
    (push el outarr -1)
  )
)

3) Uso di "for" per la lista:

(define (try-list-as-array arr)
  (setq outlst-arr '())
  (setq fine (- (length lst) 1))
  (for (i 0 fine)
    (push (arr i) outlst-arr -1)
  )
)

4) Uso di "for" per il vettore:

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

(time (try-array-as-list lst) 10)
;-> 93.578

(time (try-list-as-array lst) 10)
;-> 80869.0 ; 80 secondi
(length outlst-arr)
;-> 100000

(time (try-array arr) 10)
;-> 93.765
(length outarr)
;-> 100000

Nota: Usare "dolist" per attraversare le liste e usare "for" o "dolist" per attraversare i vettori.
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

L'esempio mostra come è possibile uscire da un ciclo iterativo prima che venga eseguito N volte.

Punti di ritorno multipli possono essere codificati usando l'espressione "throw":

(catch (begin
    (foo1)
    (foo2)
    (if condition-A (throw 'x))
    (foo3)
    (if condition-B (throw 'y))
    (foo4)
    (foo5)))

Se la condizione-A è vera, x sarà restituito dall'espressione "catch", se la condizione-B è vera, il valore restituito è y. In caso contrario, il risultato di foo5 verrà utilizzato come valore di ritorno.

Esempio di catch che simula l'espressione "continue" nella funzione "dolist":

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

*****************
>>>funzione READ
*****************
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

Il file myfile viene prima letto, poi criptato usando la password "secret" e infine scritto con un nuovo nome "myfile.enc" nella cartella corrente.

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

Nota: Quando vogliamo salvare delle liste di simboli occorre ricordare che i simboli devono avere un nome valido. Supponiamo di scrivere la seguente lista:

(setq lst '(aa bb 1c 1d))
;-> (aa bb 1 c 1 d)

Il risultato non è quello voluto perchè i nomi "1c" e "1d" non sono validi, quindi newLISP li analizza e modifica il loro nome. Questa analisi si verifica anche quando usiamo la funzione "LOAD".
Se i simboli "1c" e "1d" rappresentano dei valori esadecimali, allora dobbiamo scrivere:

(setq lst '(aa bb 0x1c 0x1d))
;-> (a bb 28 29)


===========================
 STRUTTURA DATI: IL RECORD
===========================

Un record (noto anche come struttura) è un tipo di dato strutturato che comprende diversi elementi (detti campi o membri) di tipo diverso. Nei record il numero e il tipo dei campi vengono stabiliti nella sua definizione iniziale. I record sono impiegati tipicamente nell'implementazione delle strutture dati plain old data (POD).
Nei linguaggi di programmazione orientata agli oggetti, un oggetto può avere dei campi che agiscono come funzioni o procedure che manipolano i dati memorizzati.

Un esempio di record è il seguente:

Nome record: PERSONA
Campi:
 1) nome (stringa)
 2) età  (intero)
 3) lavoro (true|false)
 4) indirizzo (sub-record)
4a)     via (stringa)
4b)   città (stringa)
4c)   paese (stringa)
 5) figli (sub-record)
5a)    nome (stringa)
5b)     età (intero)

In newLISP un record può essere implementato tramite le liste di associazione.
Una lista associativa è una "lista di liste", in cui il primo elemento è utilizzato come chiave per la ricerca:

((chiave1 valore1_1 valore1_2) (chiave2 valore2_1 valore2_2) ...)

Esempio:

(setq alst '( (1 Cuori) (2 Quadri)  (3 Fiori) (4 Picche)))

Per la ricerca nelle liste associative, si utilizzano le funzioni "assoc" e "lookup".

(assoc 2 alst)
;-> (2 Quadri)

(lookup 4 alst)
;-> Picche

Adesso vediamo la loro definizione:

*******************
>>> funzione ASSOC
*******************
sintassi: (assoc exp-key list-alist)
sintassi: (assoc list-exp-key list-alist)

Nella prima sintassi il valore di exp-key (chiave) viene utilizzato per cercare nella lista list-alist una sottolista il cui primo elemento corrisponde al valore della chiave. Se trovato, viene restituita la sottolista. In caso contrario, il risultato sarà nil.

(assoc 1 '((3 4) (1 2)))
;-> (1 2)

(set 'data '((apples 123) (bananas 123 45) (pears 7)))

(assoc 'bananas data)
;-> (bananas 123 45)
(assoc 'oranges data)
;-> nil

Insieme a "setf" la funzione "assoc" può essere usata per modificare un'associazione.

(setf (assoc 'pears data) '(pears 8))
data
;-> ((apples 123) (bananas 123 45) (pears 8))

Nella seconda sintassi è possibile specificare più espressioni-chiave per la ricerca di liste associative annidate in più livelli:

(set 'persons '(
    (id001 (name "Anne") (address (country "USA") (city "New York")))
    (id002 (name "Jean") (address (country "France") (city "Paris")))
))

(assoc '(id001 address) persons)
;-> (address (country "USA") (city "New York"))
(assoc '(id001 address city) persons)
;-> (city "New York")

La lista in list-aList può essere un contesto (context) che verrà interpretato come il suo funtore di default. In questo modo è possibile passare per riferimento liste molto grandi per un accesso più rapido e un minore utilizzo della memoria:

(set 'persons:persons '(
    (id001 (name "Anne") (address (country "USA") (city "New York")))
    (id002 (name "Jean") (address (country "France") (city "Paris")))
))

(define (get-city db id)
    (last (assoc (list id 'address 'city) db ))
)

(get-city persons 'id001)
;-> "New York"

Per effettuare sostituzioni nelle liste di associazioni, utilizzare "setf" insieme alla funzione "assoc". La funzione "lookup" viene utilizzata per eseguire la ricerca di associazione e l'estrazione dell'elemento in un solo passaggio.

********************
>>> funzione LOOKUP
********************
sintassi: (lookup exp-key list-assoc [int-index [exp-default]])

Cerca, nella lista di associazione list-assoc, una sottolista, il cui elemento chiave ha lo stesso valore di exp-key e restituisce l'elemento int-index dell'associazione (o l'ultimo elemento se int-index è assente).

Facoltativamente, è possibile specificare exp-default, che viene restituita se non è possibile trovare un'associazione corrispondente a exp-key. Se exp-default è assente e non è stata trovata alcuna associazione, viene restituito nil.

Vedi anche l'indicizzazione delle liste e delle stringhe.

La ricerca è simile a quella della funzione "assoc", ma fa un ulteriore passo estraendo un elemento specifico trovato nella lista.

(set 'params '(
    (name "John Doe")
    (age 35)
    (gender "M")
    (balance 12.34)
))

(lookup 'age params)
;-> 35

; utilizzata insieme a setf per modificare una lista di associazione

(setf (lookup 'age params) 42)
;-> 42
(lookup 'age params)
;-> 42

(set 'persons '(
    ("John Doe" 35 "M" 12.34)
    ("Mickey Mouse" 65 "N" 12345678)
))

(lookup "Mickey Mouse" persons 2)
;-> "N"
(lookup "Mickey Mouse" persons -3)
;-> 65
(lookup "John Doe" persons 1)
;-> 35
(lookup "John Doe" persons -2)
;-> "M"
(lookup "Jane Doe" persons 1 "N/A")
;-> "N/A"

Ritornando all'esempio iniziale del record, possiamo definire una lista di associazione per rappresentare la sua struttura:

Record                             Lista associativa

 1) nome (stringa)                 ( ("nome" "Pietro Rossi")
 2) età  (intero)                    ("eta" 42)
 3) lavoro (true|false)              ("lavoro" true)
 4) indirizzo (sub-record)           ("indirizzo" (
4a)     via (stringa)                    ("via" "Mazzini, 104.")
4b)   città (stringa)                    ("citta" "Roma")
4c)   paese (stringa)                    ("paese" "Italia")) )
 5) figli (sub-record)               ("figli" (
5a)    nome (stringa)                    (("nome" "Eva")  ("eta" 7))
5b)     età (intero)                     (("nome" "Lisa") ("eta" 4))
                                         (("nome" "Luca") ("eta" 3))) ) )

Notare che il campo "figli" ha un numero variabile di elementi.

Una volta definita la lista associativa che rappresenta il record, dobbiamo scivere le funzioni che operano su di essi, cioè le funzioni di creazione di un record, ricerca del record, aggiornamento del record, eliminazione del record, ecc.

Per esempio supponiamo di avere il seguente tipo di record:

(setq rec
 '( ("nome" "Pietro Rossi")
    ("eta" 42)
    ("lavoro" true)
    ("indirizzo" (
      ("via" "Mazzini, 104.")
      ("citta" "Roma")
      ("paese" "Italia")) )
    ("figli" (
      (("nome" "Eva")  ("eta" 7))
      (("nome" "Lisa") ("eta" 4))
      (("nome" "Luca") ("eta" 3))) ) )
)

I valori possono essere estratti con le funzioni "assoc", "lookup" o "ref":

; indirizzo
(lookup "indirizzo" rec)
;-> (("via" "Mazzini, 104.") ("citta" "Roma") ("paese" "Italia"))

; la citta dell'indirizzo
(lookup "citta" (lookup "indirizzo" rec))
;-> "Roma"

; una figlia di nome Eva
(ref '(( * "Eva") *) rec match true)
;-> (("nome" "Eva") ("eta" 7))

; tutti i nomi
(map last (ref-all '("nome" *) rec match true))
;-> ("Pietro Rossi" "Eva" "Lisa" "Luca")

; solo i nomi dei figli
(map last (ref-all '("nome" *) (lookup "figli" rec) match true))
;-> ("Eva" "Lisa" "Luca")

; solo i nomi dei figli (altro metodo)
(map last (map first (lookup "figli" rec)))
;-> ("Eva" "Lisa" "Luca")

I record possono essere memorizzati utilizzando una lista, un vettore, un file XML o JSON, ecc.
Comunque le prestazioni sono accettabili soltanto fino ad un migliaia di record, poi sarebbe meglio utilizzare un DBMS (esempio: SQLite).


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

Perchè newLISP usa l'ambito dinamico?
Lutz: I pericoli dell'ambito dinamico sono ampiamente sopravvalutati e per questo motivo, le possibilità dell'ambito dinamico sono quasi inesplorate.

Nel corso degli anni, non abbiamo quasi mai visto l'ambito dinamico come un problema. Laddove il pericolo è in qualche modo presente, si trova nelle fexprs 'define-macro' e tale pericolo può essere facilmente evitato usando gli spazi dei nomi. Esistono pochissime ragioni nello stile di programmazione di newLISP per passare simboli quotati alle funzioni "define", ci sono altri modi sicuri per passare i dati per riferimento in newLISP, ovvero tramite gli handle degli spazi dei nomi.

Puoi avere un isolamento lessicale usando gli spazi dei nomi, che hanno un sovraccarico minimo in newLISP: puoi letteralmente averne milioni. Le fexpr in stile 'define-macro' possono essere inserite nel proprio contesto dello spazio dei nomi e quindi sono completamente sicure. Generalmente, lo stile migliore di programmazione in newLISP è quello di inserire dati, funzioni e fexprs correlati in un contesto di spazio dei nomi.

L'assenza delle chiusure lessicali di Scheme consente a newLISP di eseguire un diverso tipo di gestione automatica della memoria - non la tradizionale garbage collection, ma un tipo sincrono di gestione della memoria - molto più veloce, senza pause inattese di garbage collection e molto più efficiente nell'uso delle risorse di memoria. Non c'è modo di scrivere un linguaggio completamente dinamico così piccolo e veloce come newLISP usando la tradizionale gestione della memoria della garbage collection.

Vediamo un esempio:

(define (sum f n)
    (set 'result 0)
    (for (i 1 n)
        (inc result (f i)))
    result)

; works because no clash of free j in f with i in sum
(for (j 1 5)
    (define (f x) (pow x j))
    (println j ": " (sum f 10)))

; does not work, free i in f clashes with i in sum
(for (i 1 5)
     (define (f x) (pow x i))
     (println i ": " (sum f 10)))

; works with previous expansion of free variable
(for (i 1 5)
     (letex (e i) (define (f x) (pow x e))) ; expansion of free variable
     (println i ": " (sum f 10)))

produce:

1: 55
2: 385
3: 3025
4: 25333
5: 220825
1: 1.040507132e+10
2: 1.040507132e+10
3: 1.040507132e+10
4: 1.040507132e+10
5: 1.040507132e+10
1: 55
2: 385
3: 3025
4: 25333
5: 220825

Le variabili libere nello scoping dinamico non sono pre-associate durante la definizione della funzione. Ma proprio come una chiusura di Scheme vincolerebbe le variabili libere al suo ambiente durante la definizione di f, lo stesso può essere fatto usando "letex" o "expand" associando la variabile libera durante la definizione della funzione.


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

(context 'FOO)

(setq 'var 123)

(define (func x y z)
    ...)

(context MAIN)

Se il contesto non esiste ancora, il simbolo di contesto deve essere citato. Se il simbolo non è quotato, newLISP assume che il simbolo sia una variabile che contiene il simbolo del contesto da creare. Poiché un contesto valuta se stesso, i contesti già esistenti come MAIN non richiedono la citazione.

Quando newLISP legge il codice sopra, leggerà, quindi valuterà la prima affermazione: (context 'FOO). Ciò fa sì che newLISP cambi lo spazio dei nomi in FOO ei seguenti simboli var, x, y e z verranno tutti creati nel contesto FOO durante la lettura e la valutazione delle espressioni rimanenti.

Un simbolo di contesto è protetto dal cambiamento. Una volta che un simbolo fa riferimento a un contesto, non può essere utilizzato per nessun altro scopo, tranne quando si utilizza l'eliminazione.

Per fare riferimento a var o func da qualsiasi altra parte al di fuori dello spazio dei nomi FOO, devono essere preceduti dal nome del contesto:

FOO: var
;-> 123

(FOO: func p q r)

Si noti che nell'esempio sopra, solo func appartiene allo spazio dei nomi FOO, i simboli p q r fanno tutti parte del contesto corrente da cui viene effettuata la chiamata FOO: func.

La funzione simboli è usata per mostrare tutti i simboli appartenenti ad un contesto:

(symbols FOO)
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
@echo off
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
 HASH-MAP E DIZIONARI
======================

Vediamo come simulare la struttura dati hash map con i contesti (namespace).
Un funtore predefinito di un contesto che contiene nil e si trova nella posizione di operatore simula a una funzione di hash per la costruzione di dizionari con (chiave associativa → accesso al valore).

Crea un contesto (namespace) e un funtore di default di nome myHash che contiene il valore nil:

(define myHash:myHash)
;-> nil

In alternativa al metodo precedente, è possibile utilizzare un contesto predefinito e il funtore di default Tree per instanziare un nuovo contesto:

(new Tree 'myHash)
;-> myHash

Entrambi i metodi producono lo stesso risultato, ma il secondo metodo protegge anche il funtore predefinito myHash:myHash da possibili modifiche.

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

Quindi esistono due metodi per iterare in una hash map:

; crea un dizionario
(context 'pippo "A" 111)
(context 'pippo "B" 222)
(context 'pippo "C" 333)

metodo 1:
; mostra tutte le coppie di valori/chiave in ordine alfabetico
(dotree (s pippo)
     (println s "->" (eval s)))
;-> pippo:A->111
;-> pippo:B->222
;-> pippo:C->333

metodo 2:
; metodo alternativo
(dolist (s (symbols pippo))
     (println s "->" (eval s)))
;-> pippo:A->111
;-> pippo:B->222
;-> pippo:C->333

Invece di "context" è possibile usare "sym" per creare/testare/modificare simboli.
A volte è più conveniente, dipende dalla situazione.

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

Le liste associative possono essere annidate:

(setq data '((1 ("Sara" (storia geografia italiano))) (2 ("Luca" (matematica storia)))))
;-> (1 ("Sara" (storia geografia italiano)))

(lookup 1 data)
;-> ("Sara" (storia geografia italiano))

(assoc 1 data)
;-> (1 ("Sara" (storia geografia italiano)))

Possiamo estrarre le materie associate a Sara:

(assoc "Sara" (assoc 1 data))
;-> ("Sara" (storia geografia italiano))

(lookup "Sara" (assoc 1 data))
;-> (storia geografia italiano)

In generale per aggiornare il valore associato ad una chiave esistente (di un dizionario data) possiamo scrivere:

(letn (key "chiave")
   (if (lookup key data)
       (setf (assoc key data) (list key "nuovo valore"))))

Invece, per aggiungere una materia a "Sara":

(if (lookup "Sara" (assoc 1 data))
    (setf (lookup "Sara" (assoc 1 data)) (push 'matematica (lookup "Sara" (assoc 1 data)) -1)))

Possiamo avere una chiave che si autoincrementa in una hash-map (dizionario):

(new Tree 'Hash)
;-> Hash
(Hash (format "%05d" (inc Hash:counter)) "A")
;-> "A"
(Hash (format "%05d" (inc Hash:counter)) "B")
;-> "B"
(Hash)
;-> (("00001" "A") ("00002" "B"))
(symbols Hash)
;-> (Hash:Hash Hash:_00001 Hash:_00002 Hash:counter)

La variabile 'Hash:counter' viene creata automaticamente quando newLISP legge l'espressione e la funzione "inc" cambia il suo valore da "nil" a 0 (zero). La funzione "format" assicura che l'ordine di creazione sia corretto. Lutz

Per creare una hashmap invece di (define hash:hash) usare (new Tree 'hash) che fa la stessa cosa, ma rende anche la funzione predefinita hash:hash una costante (contenente nil).

Un buon stile di programmazione è quello di definire tutti gli hash e gli altri contesti nel modulo di contesto MAIN come tutti gli altri simboli usati a livello globale. Nei progetti più grandi di newLISP o quando si lavora in un gruppo di programmatori sullo stesso progetto, i conflitti/problemi possono essere evitati/minimizzati in questo modo.
Chiamiamo i dizionari di contesto spesso "hash", ma non esiste una funzione di hash alla base di esso. "Hash" è solo un nome conveniente poiché la maggior parte degli altri linguaggi implementa la funzionalità di ricerca utilizzando le funzioni hash.
In newLISP i dizionari sono basati su alberi binari bilanciati rosso-nero (AVL red-black tree) separati e solo la radice del dizionario - il nome del contesto - fa parte dello spazio principale dei simboli MAIN.

Suggerimento:
il contesto è un valore, quindi possiamo usare (uuid) per generare un simbolo univoco in MAIN, quindi trasformarlo in un contesto. Ma non c'è garbage collection, devi eliminare tu stesso il contesto.

(set 'a (new Tree (sym (string "_" (uuid)) MAIN)))

Eliminare il contesto in questo modo:

(set 'name (sym (term a) MAIN)) ; trova il nome del contesto in MAIN
(delete name) ; elimina il contesto
(delete name) ; elimina il simbolo in MAIN

Cancellazione di un contesto
Quando si elimina un simbolo di contesto, la prima eliminazione rimuove il contenuto dello spazio dei nomi di contesto e riduce il simbolo a un normale simbolo mono-variabile. La seconda eliminazione rimuove quindi completamente il simbolo dalla tabella dei simboli. Questo metodo è necessario quando si utilizzano simboli di variabili locali in funzioni come contesti.

In generale: non cancellare di spazi dei nomi nei programmi newLISP di dimensioni non banali. Tranne quando si usa il flag nil nel comando delete, i simboli vengono controllati come riferimento nell'intero spazio di memoria delle celle newLISP, che può rallentare molto su programmi grandi con dati grandi.

I contesti non sono pensati per essere creati ed eliminati in modo frequente. Anche se è possibile farlo, ci sono altri modi per ottenere qualcosa di globale, che rimane attivo per l'intera esecuzione del programma.

Per tale motivo, nella FOOP i contesti vengono utilizzati principalmente come contenitori per le classi e i metodi, mentre i dati sono normali liste LISP, che sono gestite automaticamente dalla memoria di newLISP. Se usi i contesti come oggetti, la loro gestione della memoria è manuale e quindi non è molto efficiente.

Per cancellare un contesto dobbiamo usare:

(delete 'S) oppure (delete 'S true)

che non sono la stessa cosa anche se entrambi effettuano il controllo dei riferimenti.
Infatti, (delete 'S true) restituirà nil quando viene trovato un riferimento. (delete 'S) sostituisce tutti i riferimenti trovati con nil.
In definitiva abbiamo davvero 3 modalità:

(delete 'S) controlla i riferimenti e li sostituisce con nil.

(delete 'S true) controlla i riferimenti e restituisce nil quando vengono trovati riferimenti.

(delete 'S nil) ignora i riferimenti, elimina soltanto (metodo non sicuro se esistono riferimenti).

Con i contesti è un processo in due passaggi: il primo elimina i contenuti del contesto, il secondo elimina il simbolo del contesto.
L'eliminazione dei contesti in due fasi è necessaria quando lo stesso simbolo viene utilizzato come contesto, quindi il contenuto del contesto viene eliminato, e poi lo stesso simbolo ottiene nuovamente un contesto.


======================
 CAR E CDR IN newLISP
======================

La spiegazione del nome delle istruzioni CAR e CADR direttamente dall'autore Steve Russell:

"I wrote the first implementation of a LISP interpreter on the IBM 704 at MIT in early in 1959.
The 704 family (704, 709, 7090) had "Address" and "Decrement" fields that were 15 bits long in some of the looping instructions.
There were also special load and store instructions that moved these 15-bit addresses between memory and the index regiseters ( 3 on the 704, 7 on the others ).
We had devised a representation for list structure that took advantage of these instructions.
Because of an unfortunate temporary lapse of inspiration, we couldn't think of any other names for the 2 pointers in a list node than "address" and "decrement", so we called the functions CAR for "Contents of Address of Register" and CDR for "Contents of Decrement of Register".
After several months and giving a few classes in LISP, we realized that "first" and "rest" were better names, and we (John McCarthy, I and some of the rest of the AI Project) tried to get people to use them instead. Alas, it was too late! We couldn't make it stick at all.
So we have CAR and CDR."

newLISP chiama "first" la funzione "CAR" e chiama "rest" la funzione "CDR".

Sebbene auto e cdr siano stati nomi poco ispirati per quasi 50 anni, sono sopravvissuti perché offrono una geniale funzionalità: puoi aggiungere più lettere a e d tra "c" e "r", per produrre funzioni con nomi anche più strani.
Allora "caddr" trova il "car" del "cdr" del "cdr", leggiamo da sinistra a destra, sebbene le funzioni siano applicate da destra a sinistra come al solito.

Come vengono pronunciate queste funzioni?

Dal libro "Common Lisp: A Gentle Introduction to Symbolic Computation" di David S. Touretzky:

CAR/CDR Pronunciation Guide
---------------------------

Function       Pronunciation    Alternate Name
CAR            kar              FIRST
CDR            cou-der          REST
CAAR           ka-ar
CADR           kae-der          SECOND
CDAR           cou-dar
CDDR           cou-dih-der
CAAAR          ka-a-ar
CAADR          ka-ae-der
CADAR          ka-dar
CADDR          ka-dih-der       THIRD
CDAAR          cou-da-ar
CDADR          cou-dae-der
CDDAR          cou-dih-dar
CDDDR          cou-did-dih-der
CADDDR         ka-dih-dih-der   FOURTH
...

Possiamo definire queste funzioni in newLISP:

; =======================================
; Funzioni CAR e CDR
; C????R (quattro livelli)
; =======================================
(define (car x)    (first x))
(define (cdr x)    (rest x))
(define (caar x)   (first (first x)))
(define (cadr x)   (first (rest x)))
(define (cdar x)   (rest (first x)))
(define (cddr x)   (rest (rest x)))
(define (caaar x)  (first (first (first x))))
(define (caadr x)  (first (first (rest x))))
(define (cadar x)  (first (rest (first x))))
(define (caddr x)  (first (rest (rest x))))
(define (cdaar x)  (rest (first (first x))))
(define (cdadr x)  (rest (first (rest x))))
(define (cddar x)  (rest (rest (first x))))
(define (cdddr x)  (rest (rest (rest x))))
(define (caaaar x) (first (first (first (first x)))))
(define (caaadr x) (first (first (first (rest x)))))
(define (caadar x) (first (first (rest (first x)))))
(define (caaddr x) (first (first (rest (rest x)))))
(define (cadaar x) (first (rest (first (first x)))))
(define (cadadr x) (first (rest (first (rest x)))))
(define (caddar x) (first (rest (rest (first x)))))
(define (cadddr x) (first (rest (rest (rest x)))))
(define (cdaaar x) (rest (first (first (first x)))))
(define (cdaadr x) (rest (first (first (rest x)))))
(define (cdadar x) (rest (first (rest (first x)))))
(define (cdaddr x) (rest (first (rest (rest x)))))
(define (cddaar x) (rest (rest (first (first x)))))
(define (cddadr x) (rest (rest (first (rest x)))))
(define (cdddar x) (rest (rest (rest (first x)))))
(define (cddddr x) (rest (rest (rest (rest x)))))

(cadadr '(0 (1 2 3) 4 5))
;-> 2

(cadr (cdr '(7 3 5)))
;-> 5

(caddr '(7 3 5))
;-> 5

Per ottimizzare le funzioni sarebbe meglio scrivere:

(define car first)
;-> first@4071B9
(define cdr rest)
;-> rest@4072CA

In questo modo newLISP lavora molto più velocemente:

(define (car1 x) (first x))
(define (cdr1 x) (rest x))

(time (car '(1 2 3 4 5 6 7 8 9 0)) 10000000)
;-> 171.873

(time (car1 '(1 2 3 4 5 6 7 8 9 0)) 10000000)
;-> 1468.897

È possibile generare/definire queste funzioni in maniera automatica con una funzione (fornita da Kazimir Majorinc):

(define (car x) (first x))
(define (cdr x) (rest x))

(define (cdadderize x)
  (inc 'x)
  (set 'results '())
  (until (= x 0)
     (push   (% x 2) results)
     (set 'x (/ x 2)))
  (set 'results (rest results) 'f-name results)
  (map (fn (a b) (replace a results b)) '(0 1) '("(car " "(cdr "))
  (push (string "x"  (dup ")" (length results))) results -1)
  (set 'results (join results))
  (map (fn (a b) (replace a f-name b)) '(0 1) '("a" "d"))
  (letex ((fnm   (sym (string "c" (join f-name) "r")))
          (body results))
    (define (fnm x) (eval-string body))
    fnm))

Eseguiamo questa funzione:

(cdadderize 14)
;-> (lambda (x) (eval-string "(cdr (cdr (car x)))"))

Verifichiamo quali funzione sono state aggiunte controllando la tabella dei simboli:

(define (list-car-cdr)
  (filter (fn (s)
      (and (starts-with (string s) "ca|cd" 0)
          (ends-with (string s) "r")))
      (symbols)))

(list-car-cdr)
;-> (car cddar cdr)

Per generare le funzioni car e cdr fino ad un certo limite:

; genera tutte le funzioni cXXXr:
(for (i 3 14) (cdadderize i)) ; 1 e 2 sono già definite
;-> (lambda (x) (eval-string "(cdr (cdr (car x)))"))
(list-car-cdr)
;-> (caaar caadr caar cadar caddr cadr car cdaar cdadr cdar cddar cddr cdr)

; genera tutte le funzioni cXXXXr:
(for (i 3 30) (cdadderize i))
;-> (lambda (x) (eval-string "(cdr (cdr (cdr (car x))))"))
(list-car-cdr)
;-> (caaaar caaadr caaar caadar caaddr caadr caar cadaar cadadr cadar
;->  caddar cadddr caddr cadr car cdaaar cdaadr cdaar cdadar cdaddr
;->  cdadr cdar cddaar cddadr cddar cdddar cdddr cddr cdr)

; genera tutte le funzioni cXXXXXXXXXr:
(for (i 3 1022) (cdadderize i))
;-> (lambda (x) (eval-string "(cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr (car x)))))))))"))
(list-car-cdr)

Proviamo alcune di queste le funzioni:

(setq lst '((a (b (c (d)) (e) (f (g (h (i)) (j)) (k (l (m (n)) (o))))))
           (p (q (r (s)) (t) (u (v (x (y)) (w)) (z (z (z (z)) (z))))))))

(caar lst)
;-> a

(cadr lst)
;-> ((b (c (d)) (e) (f (g (h (i)) (j)) (k (l (m (n)) (o))))))

(cadadr lst)
;-> (q (r (s)) (t) (u (v (x (y)) (w)) (z (z (z (z)) (z)))))

(cadadadr lst)
;-> (r (s))

(cadaddar lst)
;-> ERR: list is empty : (cdr (cdr (car x)))
;-> called from user function (cadaddar lst)


======================
 ESPRESSIONI REGOLARI
======================

Le espressioni regolari (regex o regexp) sono estremamente utili per estrarre informazioni da qualsiasi testo cercando una o più corrispondenze di un modello (pattern) di ricerca specifico (ovvero una sequenza specifica di caratteri ASCII o unicode).
I campi di applicazione sono convalida di dati, analisi/sostituzione di stringhe, trasformazione di dati in altri formati, web scraping, syntax highlighting, ecc.
Una delle caratteristiche più interessanti è che una volta appresa la sintassi, puoi utilizzare questo strumento in (quasi) tutti i linguaggi di programmazione con minime distinzioni in base al tipo di supporto fornito dal linguaggio utilizzato.

newLISP utilizza le espressioni regolari di tipo PCRE (Perl Compatible Regular Expressions).
Per maggior informazioni consultare: https://www.pcre.org/

Le funzioni newLISP che utilizzano le regex sono:

1) directory
2) find
3) find-all
4) parse
5) regex
6) regex-comp
7) replace
8) search

Vediamo come viene definita nel manuale la funzione "regex".

******************
>>>funzione REGEX
******************
sintassi: (regex str-pattern str-text [regex-option [int-offset]])

Esegue una ricerca PCRE compatibile su str-text con il pattern (modello) specificato in str-pattern. La stesso modello di espressione regolare è supportato anche nelle funzioni directory, find, find-all, parse, replace, e search quando vengono usate con delle stringhe.

regex restituisce una lista con le stringhe e le sottostringhe trovate e l'inizio (offset) e la lunghezza di ciascuna stringa all'interno del testo. Se non viene trovata alcuna corrispondenza, restituisce nil. È possibile utilizzare i numeri di offset per una elaborazione successiva.

Inoltre, è possibile specificare una opzione regex per controllare alcune opzioni delle espressioni regolari definite in seguito. Le opzioni possono essere fornite da numeri o lettere in una stringa.

Il parametro int-offset aggiuntivo dice a regex di iniziare la ricerca di una corrispondenza non dall'inizio della stringa, ma da un offset specifico.

Quando non è presente alcuna opzione regex, i numeri di offset e i numeri di lunghezza di regex sono calcolati in base ai byte, anche quando si esegue la versione abilitata UTF-8 di newLISP. Quando si specifica l'opzione PCRE_UTF8 in regex-option, sono calcolati come caratteri UTF8 solo l'offset e la lunghezza in caratteri.

regex imposta anche le variabili $0, $1 e $2 relative all'espressione e alle sottoespressioni trovate. Proprio come qualsiasi altro simbolo in newLISP, queste variabili o le loro espressioni equivalenti ($0), ($1) e ($2), possono essere utilizzate in altre espressioni newLISP per ulteriori elaborazioni.

Le funzioni che usano espressioni regolari non resettano le variabili $0, $1 ... $15 a nil quando non viene trovata alcuna corrispondenza.

(regex "b+" "aaaabbbaaaa")  → ("bbb" 4 3)

; ricerca senza distinzione tra maiuscole e minuscole - opzione 1
(regex "b+" "AAAABBBAAAA" 1)  → ("BBB" 4 3)
; stessa opzione, ma passata come stringa "i"
(regex "b+" "AAAABBBAAAA" "i")  → ("BBB" 4 3)

(regex "[bB]+" "AAAABbBAAAA" )  → ("BbB" 4 3)

(regex "http://(.*):(.*)" "http://nuevatec.com:80")
→ ("http://nuevatec.com:80" 0 22 "nuevatec.com" 7 12 "80" 20 2)

$0  → "http://nuevatec.com:80"
$1  → "nuevatec.com"
$2  → "80"

(dotimes (i 3) (println ($ i)))
http://nuevatec.com:80
nuevatec.com
80
→ "80"

Il secondo esempio mostra l'uso di opzioni extra, mentre il terzo esempio mostra l'analisi più complessa di due sottoespressioni che sono state contrassegnate da parentesi nel modello di ricerca. Nell'ultimo esempio, l'espressione e le sottoespressioni vengono recuperate utilizzando le variabili di sistema da $0 a $2 o la loro espressione equivalente ($0) a ($2).

Quando i caratteri "" (virgolette) vengono utilizzate per delimitare le stringhe che includono caratteri di backslash \, il carattere backslash deve essere raddoppiato nel modello di espressione regolare "\\". In alternativa, è possibile utilizzare i caratteri {} (parentesi graffe) o [testo] e [/ testo] (tag di testo) per delimitare le stringhe di testo. In questi casi, non sono richieste backslash aggiuntivi.

I caratteri protetti con un backslash (escaped) in newLISP (ad esempio, il carattere quote \" o \n)" non devono essere raddoppiati in un modello di espressione regolare, che a sua volta è delimitato da virgolette.

; doppio backslash per le parentesi e altri caratteri speciali delle regex
(regex "\\(abc\\)" "xyz(abc)xyz")  → ("(abc)" 3 5)

; doppio backslash per il backslash (carattere speciale delle regex)
(regex "\\d{1,3}" "qwerty567asdfg")  → ("567" 6 3)

; un solo backslash per il carattere quote (carattere speciale in newLISP)
(regex "\"" "abc\"def")  → ("\"" 3 1)

; parentesi graffe (brackets) come delimitatori
(regex {\(abc\)} "xyz(abc)xyz")  → ("(abc)" 3 5)

; parentesi graffe (brackets) come delimitatori e carattere quote nel pattern
(regex {"} "abc\"def")  → ("\"" 3 1)

; tag [text] come delimitatore, utile per testi multilinea
(regex [text]\(abc\)[/text] "xyz(abc)xyz")  → ("(abc)" 3 5)
(regex [text]"[/text] "abc\"def")           → ("\"" 3 1)

Quando vengono utilizzate parentesi graffe o il tag [text] per delimitare la stringa del modello anziché le virgolette, è sufficiente un semplice backslash. Il modello e la stringa vengono quindi passati in forma grezza alle routine delle espressioni regolari. Quando le parentesi graffe vengono utilizzate all'interno di un modello delimitato da parentesi graffe, le parentesi interne devono essere bilanciate, come segue:

; le parentesi graffe nel pattern sono bilanciate
(regex {\d{1,3}} "qwerty567asdfg")  → ("567" 6 3)

Le seguenti costanti possono essere usate per regex-option.
Diverse opzioni possono essere combinate usando un operatore "or" binario | (pipe). Per esempio, (| 1 4) combina le opzioni 1 e 4 oppure la stringa "is" quando si usano le lettere per le due opzioni.

Le ultime due opzioni sono specifiche per newLISP.
L'opzione REPLACE_ONCE deve essere utilizzata solo in sostituzione e può essere combinata con altre opzioni PCRE.

È possibile combinare più opzioni usando + (più) o | (or) operatore, ad esempio, (| PCRE_CASELESS PCRE_DOTALL) oppure la stringa "is" quando si usano le lettere come opzioni.

PCRE name            num        description
---------            ---        -----------
PCRE_CASELESS          1 or i   treat uppercase like lowercase
PCRE_MULTILINE         2 or m   limit search at a newline like Perl's /m
PCRE_DOTALL            4 or s   . (dot) also matches newline
PCRE_EXTENDED          8 or x   ignore whitespace except inside char class
PCRE_ANCHORED         16 or A   anchor at the start
PCRE_DOLLAR_ENDONLY   32 or D   $ matches at end of string, not before newline
PCRE_EXTRA            64        additional functionality currently not used
PCRE_NOTBOL          128        first ch, not start of line; ^ shouldn't match
PCRE_NOTEOL          256        last char, not end of line; $ shouldn't match
PCRE_UNGREEDY       512i or U   invert greediness of quantifiers
PCRE_NOTEMPTY       1024        empty string considered invalid
PCRE_UTF8           2048 or u   pattern and strings as UTF-8 characters
REPLACE_ONCE      0x8000        replace only one occurrence only for use in replace
PRECOMPILED      0x10000 or p   pattern is pre-compiled, can only be combined with RREPLACE_ONCE 0x8000

Le impostazioni delle opzioni PCRE_CASELESS, PCRE_MULTILINE, PCRE_DOTALL e PCRE_EXTENDED possono essere modificate all'interno del modello da una sequenza di lettere di opzione racchiuse tra "(?" e ")". Le lettere delle opzioni sono:

  i for PCRE_CASELESS
  m for PCRE_MULTILINE
  s for PCRE_DOTALL
  x for PCRE_EXTENDED

Nota che la sintassi delle espressioni regolari è molto complessa e ricca di funzionalità con molti caratteri e forme speciali. Per ulteriori dettagli, consultare un libro o le pagine del manuale di PCRE. La maggior parte dei libri PERL o introduzioni a Linux o Unix contengono anche capitoli sulle espressioni regolari. Vedi anche http://www.pcre.org per ulteriori riferimenti e la consultazione delle pagine del manuale.

I pattern di espressione regolari possono essere precompilati, per una maggiore velocità quando si usano i pattern in modo ripetuto, con regex-comp.
-----------------------------------------------------------

Quindi per usare in modo proficuo le espressioni regolari occorre imparare come devono essere costruiti i pattern regex in relazione alle ricerche che vogliamo affettuare. In questo contesto ci limiteremo ad affrontare i pattern di ricerca e sostituzione più comuni e come utilizzarli all'interno di newLISP.

Le espressioni regolari sono stringhe che contengono caratteri e metacaratteri. I caratteri vengono valutati in modo letterale, mentre i metacaratteri assumono un significato speciale. Vediamo la lista dei metacaratteri principali:

Metacarattere	  Significato
-------------   -----------
  .	            qualsiasi carattere (tranne newline)
  *	            zero o più occorrenze (carattere o gruppo di caratteri)
  ?	            zero o una occorrenza (carattere o gruppo di caratteri)
  {}	          numero esatto o minimo o massimo o l’intervallo di occorrenze (carattere o gruppo di caratteri)
  +	            una o più occorrenze (carattere o gruppo di caratteri)
  ^	            inizio della stringa (o la negazione di un gruppo di caratteri)
  $	            fine della stringa
  |	            operatore OR
  \             carattere di escape per i caratteri speciali
  ()	          contengono una sottostringa
  []	          contengono una 'classe' di caratteri

Per utilizzare i metacaratteri come "valori letterali" devono essere preceduti dal carattere di escap backslash " \ ". Ad esempio, se volessimo ricercare il caratter punto interrogativo "?" all'interno di una stringa, dovremmo scrivere: \?

Esaminiamo meglio i singoli metacaratteri.

"[]"
Le parentesi quadre [], come si è accennato, racchiudono una 'classe' di caratteri. Questo vuol dire che il modello può o deve contenere alcuni o tutti i caratteri in esse contenute. Vediamo alcuni esempi:

[abc]
questo modello è soddisfatto quando viene trovata una delle lettere, senza tener conto dell’ordine in cui sono presenti:

[a-z]
in questo modello è presente un intervallo di caratteri (notare il segno -, sta per "dalla a alla z"), esso è soddisfatto quando viene trovato uno qualsiasi dei caratteri compresi nell’intervallo;

[0-9]
in questo modello è presente invece un intervallo di numeri, esso è soddisfatto quando viene trovato uno qualsiasi dei numeri compresi nell’intervallo;

[a-z0-9?]
questo modello è leggermente più complesso, ma dovrebbe essere di facile comprensione. La corrispondenza viene trovata quando la stringa contiene una lettera (minuscola in questo caso), un numero o il carattere ? (notate il segno prima di ?, perché il punto interrogativo è un carattere speciale, che qui però assumiamo per il suo valore letterale);

[^a-z]
questo modello è soddisfatto quando viene trovato un qualsiasi carattere che non sia una lettera minuscola (notate il segno ^ che all’interno della classe, la nega);

Naturalmente una classe di caratteri può essere seguita (e normalmente lo è) da uno dei metacaratteri che indicano il numero di volte in cui uno dei caratteri in essa contenuti, deve essere presente, riprendendo l’ultimo modello:

[a-z0-9?]?
i caratteri contenuti nella classe devono essere presenti zero o una volta;

[a-z0-9?]*
i caratteri contenuti nella classe devono essere presenti zero o più volte;

[a-z0-9?]{3}
i caratteri contenuti nella classe devonoo essere presenti esattamente tre volte;

[a-z0-9?]{1,3}
i caratteri contenuti nella classe devono essere presenti da una a tre volte;

[a-z0-9?]{3,}
i caratteri contenuti nella classe devono essere presenti minimo tre volte;

[a-z0-9?]{,3}
i caratteri contenuti nella classe devono essere presenti massimo tre volte.

Le parentesi graffe, come abbiamo già visto, indicano il numero esatto, minimo, massimo o l’intervallo di volte in cui una un’esatta sequenza o una classe di caratteri, devono essere presenti in una stringa:

{3} esattamente 3 volte;
{3,} minimo 3 volte;
{,3} massimo 3 volte;
{1,3} da 1 a 3 volte;

"()"
Le parentesi tonde, invece, fanno riferimento ad una sottostringa, o una parte di stringa se preferite, che viene assunta per il suo esatto valore letterale.

Quindi ad esempio (abc) si riferisce all’esatta sequenza di caratteri abc, a differenza, come abbiamo visto, di [abc] che si riferisce invece ad uno dei tre caratteri.

Ovviamente anche le parentesi tonde, possono essere usate con quei metacaratteri che indicano il numero di volte in cui la sottostringa deve ripetersi, per cui l’espressione (casa)? indica la presenza opzionale della parola casa (o, il che è lo stesso, che la parola deve essere presente zero o una volta).

Ma le parentesi tonde sono molto importanti anche e soprattutto perche le parti di stringa (o le espressioni) in esse contenute, possono essere "utilizzate" per vari scopi (un replace per dirne uno), ma lo vedremo più avanti quando faremo un cenno alle funzioni PHP sulle Espressioni Regolari.

Descriviamo adesso brevemente, gli altri metacaratteri.

"."
Partiamo dal punto che sta per qualsiasi carattere escluso un accapo, per cui, ad esempio, l’espressione (.)+ indica qualsiasi carattere ripetuto una o più volte (nella pratica è difficile che questo modello non trovi corrispondenza…).

"|"
Dei caratteri *,? e + abbiamo già detto in relazioni alle classi e alle sottostringhe. Il carattere | (pipe) indica l’operatore OR e consente, quindi, di presentare più alternative per un’espressione: ad esempio (bello|normale|brutto) va letta come "bello o normale o brutto" ed è quindi soddisfatta quando solo una delle tre parole viene trovata nella stringa analizzata.

"^"
Sul carattere ^ vale la pena di soffermarsi un attimo perchè, come accennato, esso assume una duplice valenza, a seconda del punto in cui si trovi all’interno dell’Espressione Regolare ed occorre quindi porre molta attenzione nel suo uso.

Se posto all’inizio del modello, tale carattere indica l’inizio esatto dello stesso: ^(ciao) indica infatti che la stringa deve iniziare con la parola ciao. Ma l’accento circonflesso, se posto all’interno di una classe di caratteri, nega la stessa: [^0-9] indica qualsiasi carattere che non sia un numero.

"$"
Infine, il carattere $ indica la fine di una stringa, per cui se viene usato in combinazione con ^, è possibile costruire un’Espressione Regolare che indichi un modello esattamente contenuto in una stringa, ad esempio ^Ciao come stai ?$, o che indichi l’esatto inizio e l’esatta fine di una stringa, ad esempio ^(Ciao) [a-zA-Z]+ (come stai ?)$

Le Espressioni Regolari, conoscono anche, per così dire, delle abbreviazioni per ottenere ciò che si desidera, in relazione, ad esempio, alle classi di caratteri usate più di frequente. Eccone di seguito un breve schema riepilogativo:

d equivale a [0-9]
D equivale a [^0-9]
w equivale a [0-9A-Za-z]
W equivale a [^0-9A-Za-z]
s equivale a [ tnr]
S equivale a [^ tnr]

Analogamente, esistono delle classi di caratteri predefinite:

[[:alpha:]] indica qualsiasi lettera, maiuscola o minuscola
[[:digit:]] indica qualsiasi cifra
[[:space:]] indica tutti i caratteri di spazio ( trn)
[[:upper:]] indica le lettere maiuscole
[[:lower:]] indica le lettere minuscole
[[:punct:]] indica i caratteri di punteggiatura
[[:xdigit:]] indica i valori esadecimali

Che ci crediate o no, le poche regole appena esplicate (che non esauriscono l’argomento, comunque) sono sufficienti a permetterci di lavorare con le Espressioni Regolari e a costruire modelli validi per gli scopi che ci proponiamo. Prima di costruire l’espressione, è fondamentale che abbiate in mente l’esatto modello che volete riprodurre, le parti di cui esso si compone, in altre parole, che sappiate esattamente ciò che volete cercare delimitandone correttamente i confini.

Adesso esaminiamo alcuni esempi generali non specifici a newLISP. Le spiegazioni degli esempi sono state lasciate in lingua inglese perchè sono più sintetiche.

Argomenti di base
-----------------

Ancoraggi: "^" e "$"
--------------------
^The
matches any string that starts with The

end$
matches a string that ends with end

^The end$
exact string match (starts and ends with The end)

roar
matches any string that has the text roar in it

Quantificatori: "*" "+" "?" e "{}"
----------------------------------
abc*
matches a string that has "ab" followed by zero or more "c"

abc+
matches a string that has "ab" followed by one or more "c"

abc?
matches a string that has "ab" followed by zero or one "c"

abc{2}
matches a string that has "ab" followed by 2 "c"

abc{2,}
matches a string that has "ab" followed by 2 or more "c"

abc{2,5}
matches a string that has "ab" followed by 2 up to 5 "c"

a(bc)*
matches a string that has "a" followed by zero or more copies of the sequence "bc"

a(bc){2,5}
matches a string that has "a" followed by 2 up to 5 copies of the sequence "bc"

Operatore OR: "|" oppure "[]"
-----------------------------
a(b|c)
matches a string that has "a" followed by "b" or "c"

a[bc]
same as previous

Classi di caratteri: "\d" "\w" "\s" e "."
-----------------------------------------
\d
matches a single character that is a digit

\w
matches a word character (alphanumeric character plus underscore)

\s
matches a whitespace character (includes tabs and line breaks)

.
matches any character

Usa l'operatore "." con attenzione poiché spesso le classi o le classi di caratteri negati (che tratteremo in seguito) sono più veloci e più precisi.

"\d", "\w" e "\s" hanno anche le rispettive negazioni con "\D", "\W" e "\S".

Per esempio, "\D" effettua il match inverso rispetto a quello ottenuto con "/d".

\D
matches a single non-digit character

Per specificare correttamente il carattere, occurre proteggere i caratteri ^.[$()|*?{}\ con il carattere '\' (barra rovesciata - backslash). Questa regola viene chiamata "escape rule".

\$\d
matches a string that has a "$" before one digit

Nota che possiamo utilizzare anche caratteri non stampabili come tab "\t", new-line "\n", ritorni a capo "\r".

Marcatori (flag)
----------------
I marcatori (flag) rappresentano un aspetto fondamentale delle espressioni regolari.
Una regex di solito si presenta nella forma /abc/, dove il modello di ricerca è delimitato da due caratteri barra /. Alla fine possiamo specificare un flag con questi valori (possiamo anche combinarli tra loro):

g (globale)
non ritorna dopo la prima corrispondenza, riavviando le ricerche successive dalla fine della corrispondenza precedente

m (multilinea)
quando abilitato, "^" e "$" corrisponderanno all'inizio e alla fine di una riga, anziché all'intera stringa

i (insensibile)
rende l'intera espressione senza distinzione tra maiuscole e minuscole (ad esempio /aBc/ corrisponde con AbC)

Argomenti intermedi
-------------------

Raggruppare e catturare: "()"
-----------------------------
a(bc)
parentheses create a capturing group with value bc

a(?:bc)*
using ?: we disable the capturing group

a(?<foo>bc)
using ?<foo> we put a name to the group

Questo operatore è molto utile quando abbiamo bisogno di estrarre informazioni da stringhe o dati usando il linguaggio di programmazione preferito. Eventuali ricorrenze multiple catturate da più gruppi saranno esposte sotto forma di un classico vettore/lista: accederemo ai loro valori specificando un indice del risultato della corrispondenza.

Se assegniamo un nome ai gruppi (usando (?<nome> ...)) saremo in grado di recuperare i valori del gruppo usando il risultato della corrispondenza come un dizionario in cui le chiavi saranno il nome di ciascun gruppo.

Espressioni con parentesi: "[]"
-------------------------------
[abc]
matches a string that has either an a or a b or a c -> is the same as a|b|c

[a-c]
same as previous

[a-fA-F0-9]
a string that represents a single hexadecimal digit, case insensitively

[0-9]%
a string that has a character from 0 to 9 before a % sign

[^a-zA-Z]
a string that has not a letter from a to z or from A to Z
In this case the ^ is used as negation of the expression

Ricorda che all'interno delle parentesi quadre tutti i caratteri speciali (inclusa la barra rovesciata \) perdono i loro poteri speciali: quindi non applicheremo la "escape rule".

Corrispondenza golosa (greedy) e pigra (lazy)
---------------------------------------------
I quantificatori (* + {}) sono operatori golosi, nel senso che espandono la corrispondenza il più possibile nel testo da analizzare.

Ad esempio, "<. +>" corrisponde a "<div>simple div</div>" nel testo "This is a <div> simple div</div>". Per catturare solo il tag div possiamo usare un "?" per renderlo pigro:

<.+?>
matches any character one or more times included inside < and >, expanding as needed

Si noti che una soluzione migliore dovrebbe evitare l'utilizzo di "." a favore di una regex più rigorosa:

<[^<>]+>
matches any character except < or > one or more times included inside < and >

Argomenti avanzati
------------------

Confini (Boundaries): "\b" e "\B"
---------------------------------
\babc\b
performs a "whole words only" search

\b rappresenta un punto di ancoraggio come il punto di inserimento (è simile a $ e ^) in corrispondenza delle posizioni in cui un lato è un carattere di una parola (come \w) e l'altro lato non è un carattere di parola (ad esempio potrebbe essere l'inizio della stringa o un carattere spazio).

Esiste anche la sua negazione, \B. Questo corrisponde a tutte le posizioni in cui \b non corrisponde e rappresenta un modello per la ricerca di pattern racchiusi da altri caratteri.

\Babc\B
matches only if the pattern is fully surrounded by word characters

Riferimento all'indietro (Back-references): "\1"
------------------------------------------------
([abc])\1
using \1 it matches the same text that was matched by the first capturing group

([abc])([de])\2\1
we can use \2 (\3, \4, etc.) to identify the same text that was matched by the second (third, fourth, etc.) capturing group

(?<foo>[abc])\k<foo>
we put the name foo to the group and we reference it later (\k<foo>). The result is the same of the first regex

Guarda-avanti (look-ahead) e (look-behind): "(?=)" e "(?<=)"
------------------------------------------------------------
d(?=r)
matches a d only if is followed by r, but r will not be part of the overall regex match

(?<=r)d
matches a d only if is preceded by an r, but r will not be part of the overall regex match

Possiamo anche usare l'operatore di negazione "!":

d(?!r)
matches a d only if is not followed by r, but r will not be part of the overall regex match

(?<!r)d
matches a d only if is not preceded by an r, but r will not be part of the overall regex match

Adesso vediamo alcuni esempi di regex e delle funzioni di newLISP che la utilizzano.

********************
>>>funzione REPLACE
********************
sintassi: (replace str-pattern str-data exp-replacement regex-option)

La presenza di un quarto parametro indica che è necessario eseguire una ricerca di espressioni regolari con un modello di espressione regolare specificato in str-pattern e un numero di opzione specificato in regex-option (ad es. 1 (uno) o "i" per la ricerca senza distinzione tra maiuscole e minuscole o 0 (zero) per una ricerca standard Perl compatibile con espressione regolare (PCRE) senza opzioni). Vedi regex sopra per i dettagli.

Per impostazione predefinita, replace sostituisce tutte le occorrenze di una stringa di ricerca anche se nel modello di ricerca è inclusa una specifica di inizio riga. Dopo ogni sostituzione, viene avviata una nuova ricerca in una nuova posizione in str-data. L'impostazione del bit di opzione su 0x8000 in regex-option forzerà la sostituzione solo della prima occorrenza. Viene restituita la stringa modificata.

replace con le espressioni regolari imposta anche le variabili interne $0, $1 e $2 con il contenuto delle espressioni e delle sottoespressioni trovate. La variabile di sistema anaforica $it è impostata sullo stesso valore di $0. Questi possono essere utilizzati per eseguire sostituzioni che dipendono dal contenuto trovato durante la sostituzione. I simboli $it, $0, $1 e $2  possono essere usati nelle espressioni come qualsiasi altro simbolo. Se l'espressione di sostituzione restituisce qualcosa di diverso da una stringa, non viene effettuata alcuna sostituzione. In alternativa, è possibile accedere al contenuto di queste variabili anche utilizzando ($ 0), ($ 1), ($ 2) e così via. Questo metodo consente l'accesso indicizzato (ad es. ($ i), dove i è un numero intero).

Dopo aver effettuato tutte le sostituzioni, il numero di sostituzioni è contenuto nella variabile di sistema $count.

;; using the option parameter to employ regular expressions

(set 'str "ZZZZZxZZZZyy")     → "ZZZZZxZZZZyy"
(replace "x|y" str "PP" 0)    → "ZZZZZPPZZZZPPPP"
str                           → "ZZZZZPPZZZZPPPP"

;; using system variables for dynamic replacement

(set 'str "---axb---ayb---")
(replace "(a)(.)(b)" str (append $3 $2 $1) 0)
→ "---bxa---bya---"

str  → "---bxa---bya---"

;; using the 'replace once' option bit 0x8000

(replace "a" "aaa" "X" 0)  → "XXX"

(replace "a" "aaa" "X" 0x8000)  → "Xaa"

;; URL translation of hex codes with dynamic replacement

(set 'str "xxx%41xxx%42")
(replace "%([0-9A-F][0-9A-F])" str
               (char (int (append "0x" $1))) 1)

str    → "xxxAxxxB"

$count → 2

Un'altra funzione che può usare le espressioni regolari è "search".

*******************
>>>funzione SEARCH
*******************
sintassi: (search int-file str-search [bool-flag [regex-option]])

Cerca un file specificato dal suo handle in int-file per una stringa in str-search. int-file può essere ottenuto da un precedente file aperto. Dopo la ricerca, il puntatore del file viene posizionato all'inizio o alla fine della stringa cercata o alla fine del file se non viene trovato nulla.

Per impostazione predefinita, il puntatore del file è posizionato all'inizio della stringa cercata. Se bool-flag vale true, il puntatore del file viene posizionato alla fine della stringa cercata.

In regex-option, i flag delle opzioni possono essere specificati per eseguire una ricerca di espressioni regolari PCRE. Vedi la funzione regex per i dettagli. Se l'opzione regex non viene specificata, viene eseguita una ricerca di stringhe più veloce e semplice. search restituisce la nuova posizione del file o zero se non viene trovato nulla.

Quando si utilizza il flag delle opzioni di espressione regolare, i modelli trovati vengono archiviati nelle variabili di sistema da $0 a $15.

(set 'file (open "init.lsp" "read"))
(search file "define")
(print (read-line file) "\n")
(close file)

(set 'file (open "program.c" "r"))
(while (search file "#define (.*)" true 0) (println $1))
(close file)

Il file init.lsp viene aperto e cercata la stringa "define" e viene stampata la linea in cui si trova la stringa.

Il secondo esempio cerca tutte le righe nel file program.c che iniziano con la stringa "#define" e stampa il resto della riga dopo la stringa "#define".

Vediamo adesso alcuni esempi di espressioni regolari:

Esempio 1
---------
(setq str "xyzabcXYZ")
; questo non funziona
(replace "x|y" str "e")
;-> "abcXYZ"

(setq str "xyzabcXYZ")
; funziona case insensitive
(replace "x|y" str "O" 0)
;-> "OOzabcXYZ"

; funziona case sensitive
(setq str "xyzabcXYZ")
(replace "x|y" str "O" 1)
;-> "OOzabcOOZ"

Esempio 2
----------


=======
 MACRO
=======

Iniziamo con la descrizione del manuale della funzione "define-macro":

*************************
>>>funzione DEFINE-MACRO
*************************
sintassi: (define-macro (sym-name [sym-param-1 ...]) body)
sintassi: (define-macro (sym-name [(sym-param-1 exp-default) ...]) body)

Le funzioni definite usando "define-macro" sono chiamate fexpr in altri LISP in quanto non effettuano l'espansione delle variabili. In newLISP sono ancora chiamate macro, perché sono scritte con lo stesso scopo di creare forme di sintassi speciali con schemi di valutazione non standard degli argomenti. Le funzioni create usando "define-macro" possono essere combinate con le funzioni di espansione "expand" o "letex".

Dalla v.10.5.8, newLISP ha anche una macro di espansione utilizzando la funzione "macro".

Definisce una nuova fexpr di nome sym-name, con argomenti opzionali sym-param-1. "define-macro" equivale ad assegnare un'espressione lambda-macro ad un simbolo. Quando viene chiamata una funzione "define-macro", gli argomenti non valutati vengono assegnati alle variabili in sym-param-1 .... Quindi vengono valutate le espressioni del corpo. Quando si valuta la funzione "define-macro", viene restituita l'espressione lambda-macro.

(define-macro (my-setq p1 p2) (set p1 (eval p2)))
→ (lambda-macro (p1 p2) (set p1 (eval p2)))

(my-setq x 123)  → 123
x                → 123

Nuove funzioni possono essere create per comportarsi come funzioni integrate che ritardano la valutazione di determinati argomenti. Poiché le fexpr possono accedere agli argomenti all'interno di una lista di parametri, possono essere utilizzate per creare funzioni di controllo del flusso come quelle già presenti in newLISP.

Tutti i parametri definiti sono opzionali. Quando una macro viene chiamata senza argomenti, tali parametri assumono il valore nil. Se tali parametri hanno un valore predefinito specificato in exp-default, assumono quel valore predefinito.

(define-macro (foo (a 1) (b 2))
  (list a b))

(foo)      → (1 2)
(foo 3)    → (3 2)
(foo 3 4)  → (3 4)

Le espressioni in exp-default vengono valutate nell'ambiente della funzione corrente.

(define-macro (foo (a 10) (b (div a 2)))
  (list a b))

(foo)      → (10 5)
(foo 30)   → (30 15)
(foo 3 4)  → (3 4)

Si noti che nelle fexprs esiste il pericolo di passare un parametro con lo stesso nome di una variabile usata nella definizione di "define-macro". In questo caso, la variabile interna della fexpr finirebbe per ricevere nil invece del valore previsto:

;; not a good definition!

(define-macro (my-setq x y) (set x (eval y)))

;; symbol name clash for x

(my-setq x 123)  → 123
x                → nil

Esistono diversi metodi che possono essere utilizzati per evitare questo problema, noto come "cattura delle variabili", scrivendo delle macro "igieniche":

Inserire la definizione nel proprio contesto dello spazio dei nomi lessicamente chiuso. Se la funzione ha lo stesso nome del contesto, può essere chiamata utilizzando solo il nome del contesto. Una funzione con questa caratteristica è chiamata funzione di default (funtore di default). Questo è il metodo preferito in newLISP per scrivere macro-definizioni.

Utilizzare args per accedere agli argomenti passati dalla funzione.

;; a define-macro as a lexically isolated function
;; avoiding variable capture in passed parameters

(context 'my-setq)

(define-macro (my-setq:my-setq x y) (set x (eval y)))

(context MAIN)

(my-setq x 123)  → 123  ; no symbol clash
x                → 123

La definizione nell'esempio è isolata dal punto di vista lessicale e non può verificarsi alcuna cattura di variabile. Invece di chiamare la funzione usando (my-setq:my-setq ...), può essere chiamata con solo (my-setq ...) perché è una funzione di default.

La seconda possibilità è di fare riferimento ai parametri passati usando args:

;; avoid variable capture in macros using the args function

(define-macro (my-setq) (set (args 0) (eval (args 1))))

Vedi anche la funzione di espansione "macro" che non risente della cattura delle variabili.
----------

In newLISP la differenza tra una funzione definita con 'define' e una con 'define-macro' è che 'define' valuterà tutti i suoi argomenti, mentre 'define-macro' no.

Con 'define-macro' è possibile creare funzioni che si comportano e sembrano fiunctions built-in. Cioè la funzione (setq x y) non valuta l'argomento 'x', ma passa direttamente 'x' come simbolo. La normale (set 'x y) non funziona nello stesso modo perchè valuta entrambi i suoi argomenti.

Un altro esempio è: (dolist (item mylist) .....). L'espressione (item mylist) non viene valutata ma passata in "dolist" per gestirla. Altrimenti, dovremmo citare facendo (dolist '(item mylist) ...).

Le macro non vengono utilizzate molto spesso, ma quando vengono utilizzate possono essere utili e importanti.

Abbiamo bisogno delle macro solo quando non vogliamo che una funzione valuti immediatamente i suoi argomenti. Per esempio:

(define (calc e)
  (println "the answer to " e " is " (eval e)))

(calc (+ 2 2))

;-> the answer to 4 is 4

(define-macro (calc e)
  (println "the answer to " e " is " (eval e)))

(calc (+ 2 2))

;-> the answer to (+ 2 2) is 4

La funzione non produce il risultato voluto, perché vede solo il '4', non l'espressione. La macro è migliore, perché "e" viene valutata solo quando vogliamo che sia valutata, dandoci la possibilità di utilizzarla anche come espressione non valutata.

Comunque le macro possono anche estendere il linguaggio con nuove funzioni. L'esempio seguente implementa la funzione "defun" come si trova nel Common LISP. Senza 'define-macro' questo sarebbe impossibile:

; Esempio d'uso: (defun foo (x y z) ....)

(define-macro (defun _func-name _arguments)
      (set _func-name (append
        '(lambda )
         (list _arguments)
         (args))))

;(defun foo (x y z) ....)

Senza 'define-macro' potremmo scrivere solo un 'defun' in cui sia il nome della funzione (cioè foo) che l'elenco dei parametri (cioè (x y z)) dovrebbero essere quotati.

Una macro è un tipo speciale di funzione che possiamo usare per modificare il modo in cui newLISP valuta il codice. Per esempio, è possibile creare nuovi tipi di funzioni di controllo di flusso, come la propria versione di if o di case.
Con le macro, possiamo creare dei costrutti altamente personalizzati. In verità, le macro di newLISP sono "fexprs", non macro. In newLISP, le "fexprs" vengono chiamate macro perché hanno uno scopo simile alle macro in altri LISP.

Il concetto fondamentale delle macro è il metodo di valutazione delle espressioni: in una funzione ordinaria gli argomenti delle espressioni vengono valutati per primi, mentre in una funzione macro possiamo decidere se e quando valutare gli argomenti.

In altre parole, in newLISP la funzione "define-macro" crea delle funzioni(macro) in cui gli argomenti non sono valutati: se abbiamo una variabile/simbolo x con valore 10 e la passiamo ad una macro, allora il valore visto dalla macro è x e non 10.

Vediamo un esempio, supponiamo di voler creare la nostra funzione "if" con una funzione ordinaria:

(define (iff test true-action nil-action)
  (if test true-action nil-action))

Adesso eseguiamo la nostra funzione con un test vero (true) e un test falso (nil):

(iff (> 3 2) (println "vero") (println "falso"))
;-> vero
;-> falso
;-> "vero"

(iff (< 3 2) (println "vero") (println "falso"))
;-> vero
;-> falso
;-> "falso"

Il risultato non è quello che volevamo: qualunque sia il risultato del test, vengono sempre stampati entrambi i valori (vero e falso) prima del risultato dell'azione. Questo perchè newLISP valuta gli argomenti prima della valutazione (applicazione) della funzione "iff".

Per risolvere il problema utilizziamo una macro:

(define-macro (iff test true-action nil-action)
  (if test true-action nil-action))

proviamo la nostra macro:

(iff (> 3 2) (println "vero") (println "falso"))
;-> (println "vero")

(iff (< 3 2) (println "vero") (println "falso"))
;-> (println "vero")

Anche in questo caso non abbiamo ottenuto il risultato sperato: questo è dovuto al fatto che la nostra macro non valuta affatto gli argomenti e quindi restituisce sempre un'espressione non valutata (in questo caso (println "vero")). Per fare in modo che la macro valuti gli argomenti occorre utilizzare la funzione "eval", che ci permette di effettuare la valutazione delle espressioni in modo sequenziale:

(define-macro (iff test true-action nil-action)
  (if (eval test) (eval true-action) (eval nil-action)))

(iff (> 3 2) (println "vero") (println "falso"))
;-> vero
;-> "vero"

(iff (< 3 2) (println "vero") (println "falso"))
;-> (println "vero")
;-> falso
;-> "falso"

Finalmente la nostra macro "iff" si comporta correttamente.

Adesso creiamo una macro che effettua un ciclo su una funzione. Il primo tentativo è quello di scrivere la funzione seguente:

(define (loop _func) (while true _func))

Proviamo:

(loop (println "."))
;-> .
Otteniamo un crash della REPL.

Quando l'argomento della funzione (println ".") viene passato alla funzione, viene valutato e restituisce ".". Poi all'interno della funzione troviamo (while true "."), che ferma l'esecuzione del programma senza alcun output.

Usando 'define-macro' lasciamo (println ".") non valutato e otteniamo:

(while true (eval '(println ".")))

che viene valutato correttamente.

Con la seguente macro otteniamo il comportamento voluto:

(define-macro (loop _func) (while true (eval _func)))

Proviamo (premere Ctrl-C per terminare il programma):

(loop (println "."))
;-> .
;-> .
;-> .
Ctrl-C
;-> ERR: received SIGINT - in function println
;-> called from user function (loop (println ".")).

Vediamo un altro esempio, questa volta creiamo una funzione di assegnazione "qset":

(define-macro (qset simb val)
  (set simb (eval val)))

In questo caso il simbolo "simb" non viene valutato e rimane in forma simbolica (è come se fosse quotato). Invece il simbolo "val" viene valutato e il valore risultante viene poi assegnato a "simb".

(qset a (+ 20 10))
;-> 30
a
;-> 30

Cerchiamo di capire come funziona una macro con altri esempi. Definiamo una macro che crea una lista con i due parametri passati alla macro:

(define-macro (f1 _x _y) (list _x _y))

La macro restituisce una lista con i valori passati:

(f1 1 2)
;-> (1 2)
(f1 a b)
;-> (a b)

Proviamo a cambiare la macro ponendo la funzione "list" all'interno di una funzione lambda:

(define-macro (f2 _x _y) (lambda () (list _x _y)))

Adesso la macro restituisce la funzione lambda non valutata:

(f2 1 2)
;-> (lambda () (list _x _y))

Quindi define-macro è define-lazy (non valuta la funzione lambda al suo interno).
Possiamo utilizare la funzione "expand" per espandere le variabili:

(define-macro (f3 _x _y) (expand (fn () (list _x _y)) '_x '_y))
(f3 1 2)
;-> (lambda () (list 1 2)

Questo spiega perchè il seguente esempio non funziona come vorremmo:

(define-macro (my-setq x y) (setq x (eval y)))
(my-setq x 123)
;-> 123
x
;-> nil

La variabile x è locale alla define-macro e non può impostare il valore per l'ambiente dinamico superiore: si tratta del "problema della cattura delle variabili".

Problema: la cattura delle variabili
------------------------------------
Il problema principale delle macro è dovuto alla possibile sovrapposizione (cioè nomi uguali) tra i simboli utilizzati dalla macro e i simboli utilizzati dal programma chiamante.
Vediamo un esempio per capire meglio di cosa si tratta. Supponiamo di chiamare la nostra ultima macro "qset" nel modo seguente:

(qset val (+ 20 10))
;-> 30
val
;-> nil

(qset simb (+ 20 10))
;-> 30
simb
;-> nil

In questi casi la nostra macro non ha effettuato alcuna assegnazione, poichè le espressioni:
(setq simb (+ 20 10)) e (setq val (+ 20 10)) impostano il valore delle variabili/simboli locali "simb" e "val". Quando questo accade, si dice che la variabile "val" (e "simb") è stata catturata durante l'"espansione" della macro.
Il linguaggio Scheme permette di scrivere macro "igieniche", nel senso che la sovrapposizione delle variabili viene risolta automaticamente dall'interprete del linguaggio, quind i simboli con lo stesso nome non creano effetti indesiderati. Purtroppo newLISP non ha questa funzionalità, quindi dobbiamo risolvere in altro modo il problema della "cattura delle variabili".

Possiamo utilizzare uno dei seguenti tre metodi per evitare la "cattura delle variabili".

Metodo 1: uso di variabili con underscore "_"
---------------------------------------------
Decidiamo di utilizziamo il carattere underscore "_" come prefisso per ogni variabile della macro.
Inoltre decidiamo di non utilizziamo il carattere underscore "_" come prefisso per le variabile del codice newLISP standard.
Ad esempio, la macro "qset" viene scritta nel modo seguente:

(define-macro (qset _simb _val)
  (set _simb (eval _val)))

(qset a (+ 20 10))
;-> 30
a
;-> nil

Abbiamo soltanto "aggirato" il problema, infatti:

(qset _simb (+ 20 10))
;-> 30
_simb
;-> nil

Si tratta di una soluzione naif, che però si adatta bene ai principi pratici di newLISP.

Nota: questa soluzione può essere considerata nel caso di un solo programmatore, oppure previo accordo tra il team di programmatori che lavorano al programma.

Metodo 2: uso della funzione "args"
-----------------------------------
Utilizziamo la funzione "args" per estrarre le variabili locali dai parametri.
In questo caso, la macro "qset" diventa:

(define-macro (qset)
  (set (args 0) (eval (args 1))))

(qset _simb (+ 20 10))
;-> 30
_simb
;-> 30

Possiamo anche utilizzare la funzione "letex" che ci permette di espandere gli argomenti ed assegnarli alle variabili locali della macro:

(define-macro (qset)
  (letex (_simb (args 0)
          _val  (args 1))
  (set _simb (eval _val))))

(qset _simb (+ 20 10))
;-> 30
_simb
;-> 30

La funzione "letex" funziona come qualsiasi altra espressione lambda in quanto localizza le variabili di un ambito dinamico che non è "igienico".

Comunque se esiste un simbolo globale con lo stesso nome di una variabile della macro, oppure se passiamo alla macro un parametro con lo stesso nome di una variabile (anche locale) della macro, oppure ricadiamo nella "cattura delle variabili".

Esempio:

(setq _simb 10)
;-> 10

(qset _simb (+ 20 10))
;-> 30
_simb
;-> 10 ; il valore della variabile _simb non è cambiato

Altro esempio:

(define-macro (demo param)
  (println "y globale = " y)
  (let (y 10)
    (println "y locale = " y)
    (setq param (add (eval param) y))))

(setq y 3)
(demo y)
;-> 20
y
;-> 3  ; anche in questo caso il valore della variabile y non è cambiato

Metodo 3: uso di un contesto (context)
--------------------------------------
Utilizziamo un contesto con lo stesso nome della macro. Inoltre utilizziamo la funzione "args" per assegnare i parametri alle variabili locali della macro.
In questo caso, la macro "qset" viene scritta nel modo seguente:

(context 'qset)

(define-macro (qset:qset)
  (letex (_simb (args 0)
          _val  (args 1))
  (setq _simb (eval _val))))

(context MAIN)

(qset a (+ 20 10))
;-> 30
a
;-> 30

(setq _simb 10)
(qset _simb (+ 20 10))
;-> 30
_simb
;-> 30 ; questa volta la variabile globale _simb è stata modificata.

Nota: questo è il metodo più sicuro per evitare la "cattura delle variabili". Anche perchè il simbolo "qset" è protetto perchè è un contesto (context).

(context? qset)
;-> true
(setq qset 1)
;-> ERR: symbol is protected in function setf : qset

La chiamata alla funzione (args) restituisce l'elenco di tutti gli argomenti passati alla lambda-macro (cioè tutti quelli che non vengono assegnati durante la chiamata tramite i parametri). Questo ci permette di estendere la funzione "qset" in modo che sia possibile effettuare assegnazioni multiple.
La nuova funzione "mset" è la seguente:

(define-macro (mset)
  (eval (cons 'setq (args))))

La funzione cons unisce una lista con un nuovo primo elemento (inserisce un elemento al primo posto di una lista):

(cons 1 '(2 3))
;-> (1 2 3)

Adesso possiamo associare/utilizzare un numero variabile di argomenti:

(mset x 10 y 11)
;-> 11
x
;-> 10
y
;-> 11

Quindi la macro prima costruisce l'espressione simbolica mostrata sotto:

'(setq x 10 y 11)

Poi questa espressione viene valutata.

Per capire le macro di newLISP dovresti anche familiarizzare con le seguenti funzioni: "expand", "letex" e "doargs".

Lo scopo principale delle macro è quello di estendere la sintassi del linguaggio.

Debug delle macro
-----------------
Le macro sono abbastanza complesse da scrivere, soprattutto quando dobbiamo testare e verificare la loro correttezza. Possiamo usare il debug di newLISP, ma è più difficile rispetto ad una funzione standard.
Un metodo utile è quello di sostituire la funzione "eval" con la funzione "list" o "println" per verificare l'aspetto dell'espressione espansa prima di essere valutata.
Infatti, non è possibile espandere le macro in Newlisp, poiché queste sono in realtà fexpr, che non si espandono. In molti casi è possibile sostituire eval esterno con println: in tal caso la chiamata alla macro stamperà ciò che si intendeva valutare.

Supponiamo di voler creare una macro che implementi il controllo "dolist-while":

(define-macro (dolist-while)
  (letex (_var (args 0 0) ; variabile del ciclo
          _lst (args 0 1) ; lista
          _cnd (args 0 2) ; condizione
          _body (cons 'begin (1 (args)))) ; corpo della funzione
    (let (_y)
    (println (args 0 0) { - } _lst)
    (catch (dolist (_var _lst)
    (if (set '_y _cnd) _body (throw _y)))))))

Abbiamo inserito una println per "vedere" cosa accade all'interno della macro.

Proviamo la nostra macro:

(dolist-while (x (sequence 15 0) (> x 10))
  (println {x is } (dec x 1)))
;-> x - (15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0)
;-> x is 14
;-> x is 13
;-> x is 12
;-> x is 11
;-> x is 10

Nota: questa macro non è immune dal problema della "cattura delle variabili", infatti se passiamo alla macro la variabile _y, otteniamo un errore:

(dolist-while (_y (sequence 15 0) (> _y 10))
  (println {_y is } (dec _y 1)))
;-> _y - (15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0)
;-> _y is
;-> ERR: value expected in function dec : true
;-> called from user function (dolist-while (_y (sequence 15 0) (> _y 10))
;-> (println "_y is " (dec _y 1)))

Vediamo altri esempi. Il primo è l'implementazone della funzione "inc":

(define-macro (my-inc _var)
  (eval (list 'setq _var (list '+ 1 _var) ))
)

Proviamo:

(setq i 0)
(while (< i 5) (println (my-inc i)))
;-> 1
;-> 2
;-> 3
;-> 4
;-> 5

Notiamo che la macro costruisce codice che viene valutato dalla funzione "eval". In questo caso costruisce una lista che contiene (setq i (+ 1 i)) e poi la valuta. Se sostituiamo "eval" con "println" possiamo vedere il codice che deve essere valutato:

(define-macro (my-inc _var)
  (println (list 'setq _var (list '+ 1 _var) ))
)

(setq i 0)
(while (< i 5) (println (my-inc i)))
;-> (setq i (+ 1 i))
;-> (setq i (+ 1 i))
;-> (setq i (+ 1 i))
...

Alternativamente la macro potrebbe restituire la lista non valutata pronta per essere elaborata ulteriormente.

Il secondo esempio è una replica del ciclo "for":

(define-macro (mi-for var from init to final do body)
  (eval
    (list 'let (list (list var init))
               (cons 'while (cons (list '<= var final)
                             (append (list body)
                               (list (list 'inc var))))))))

In modo analogo in questo caso la macro costruisce un ciclo while che viene eseguito un certo numero di volte.

Proviamo:

(mi-for i from 1 to 5 do (println i))
;-> 1
;-> 2
;-> 3
;-> 4
;-> 5
;-> 6 ; valore restituito da "mi-for"

Sostituiamo "eval" con "println":

(define-macro (mi-for var from init to final do body)
  (println
    (list 'let (list (list var init))
               (cons 'while (cons (list '<= var final)
                             (append (list body)
                               (list (list 'inc var))))))))

(mi-for i from 1 to 5 do (println i))
;-> (let ((i 1)) (while (<= i 5) (println i) (inc i)))

Quindi le macro possono servire per costruire codice che può essere valutato successivamente.

Adesso vediamo una macro scritta da John Small per capire come si applica la funzione "expand". La macro "expand-let" opera nello stesso modo della seguente espressione:

(let ((x 1)(y 2)(z 3))
  (expand '(x y z) 'x 'y 'z))
;-> (1 2 3)

(define (keys alist)
  (map (fn (pair) (first pair)) alist))

(keys '((x 1) (y 2) (z 3)))
;-> (x y z)

(define (bindings alist)
  (map (fn (pair) (cons (first pair) (eval (last pair)))) alist))

(bindings '((x 1) (y (+ 1 1)) (z 3)))
;-> ((x 1) (y 2) (z 3))

(define-macro (expand-let expr)
  (let ((ks (keys (rest (args))))
        (bs (bindings (rest (args)))))
  (eval (expand '(let bs
        (apply expand (cons (eval expr) (quote ks))))
  'ks 'bs))))

Comunque il risultato non è quello voluto:

(expand-let '(x y z) (x 1) (y 2) (z 3))
;-> (x 2 3)

Abbiamo ottenuto "x" al posto di "1" (e non ho ancora capito perchè).
Comunque se chiamiamo la macro aggiungendo un parametro con valore nil, allora tutto funziona:

(expand-let '(x y z) nil (x 1) (y 2) (z (+ 1 2)))
;-> (1 2 3)

Nel frattempo Lutz ha fornito una versione compatta:

(define-macro (expand-let)
  (eval (append (list 'let (rest (args)))
                (list (cons 'expand
                             (append (list (first (args)))
                             (map quote (map first (rest (args))))))))))

(expand-let '(x y z) (x 1) (y (+ 1 1)) (z 3))
;-> (1 2 3)

Macro di esempio
----------------
Vediamo altri esempi di macro presi dal forum di newLISP per avere un'idea di quanto sono potenti. Alcune di queste macro sono abbastanza complesse, ma non spaventatevi... andate avanti.

Nota: per ogni macro viene riportato anche il nome del creatore (quando conosciuto).

macro "ecase" (Dmitry)
----------------------
Questa macro (a differenza della funzione built-in "case") valuta le espressioni di confronto (test).

(define-macro (ecase _v)
  (eval (append
          (list 'case _v)
          (map (fn (_i) (cons (eval (_i 0)) (rest _i))) (args)))))

(define (test n)
  (ecase n
    ((/ 4 4) (println "n vale 1"))
    ((- 12 10) (println "n vale 2"))))

(define-macro (test n)
  (ecase n
    ((/ 4 4) (println "n vale 1"))
    ((- 12 10) (println "n vale 2"))
    (true (println "n diverso da 1 e 2"))))

(test 1)
;-> n vale 1

(test 2)
;-> n vale 2

(test 3)
;-> n diverso da 1 e 2

Come possiamo notare le espressioni (/ 4 4), (- 12 10) e true sono state tutte valutate. Con la versione standard di "case", queste espressioni non sarebbero state valutate.

macro "create-functions" (Cormullion)
-------------------------------------
Questa macro crea nuove funzioni.

(define-macro (create-functions group-name)
  (letex
    ((f1 (sym (append (term group-name) "1")))
     (f2 (sym (append (term group-name) "2"))))
    (define (f1 arg) (+ arg 1))
    (define (f2 arg) (+ arg 2))))

; creazione di due funzioni che iniziano con "foo":
(create-functions foo)
(foo1 10)
;-> 11
(foo2 10)
;-> 12
(create-functions bar)
; crea due funzioni che iniziano con "bar":
(bar1 12)
;-> 13
(bar2 12)
;-> 14

macro "tracer" (?)
------------------
Questa macro crea un file di log di tutte le funzioni eseguite (tracer).
Il codice seguente modifica il funzionamento di newLISP in modo che ogni funzione definita usando define aggiunga, quando valutata, il suo nome e i suoi argomenti in un file di log. Quando si esegue uno script, il file di log conterrà un record delle funzioni e degli argomenti che sono stati valutati.

(context 'tracer)

(define-macro (tracer:tracer farg)
  (set (farg 0)
    (letex (func (farg 0)
            arg (rest farg)
            arg-p (cons 'list (map (fn (x) (if (list? x) (first x) x))
                   (rest farg)))
            body (cons 'begin (args)))
            (lambda
                arg
                (append-file
                  (string (env "HOME") "/trace.log")
                  (string 'func { } arg-p "\n"))
             body))))

(context MAIN)

(constant (global 'newLISP-define) define)

; ridefinisce la funzione built-in "define"
(constant (global 'define) tracer)

Per verificare l'uso di questa macro occorre prima caricare lo script dalla REPL:

(load "tracer.lsp")

Il file di log generato contiene la lista di tutte le funzioni chiamate e gli argomenti che hanno ricevuto.

Nota: questa macro rallenta notevolmente l'esecuzione dei programmi.

macro "println-unix" (Lutz)
---------------------------
Questa macro permette di scrivere file con unix EOL (End Of Line) '\n' in windows.
In windows il carattere EOL vale '\r\n'.

(define-macro (println-unix)
    (apply print (map eval (args)))
    (print "\n"))

macro "multiple-replace" (Lutz)
-------------------------------
Questa macro permette di effettuare modifiche multiple ad un testo.

(set 'text "Sherlock Holmes")
(set 'repls '(("Sherlock" "Ellery") ("Holmes" "Queen")))

Codice standard:
(dolist (r repls)
    (replace (first r) text (last r)))

Macro:
(define-macro (replace-all)
    (dolist (r (eval (args 0)))
        (replace (first r) (eval (args 1)) (last r))))

(replace-all repls text)
;-> "Ellery Queen"
text
;-> "Ellery Queen"
Questo metodo permette di tenere insieme le coppie di sostituire nel caso ci sia una lista lunga di modifiche.

macro "destroy-func" (newdep)
-----------------------------
Questa macro permette di eseguire una funzione e poi eliminarla dal contesto.

(define-macro (destroy-func)
    (let (temp (eval (args)))
      (delete (args 0))
      temp))

(define (foo x) (+ x x))

(destroy-func foo 123)
;-> 246

(sym "foo" MAIN nil)
;-> nil ; il simbolo foo non esiste più

(foo 2)
;-> ERR: invalid function : (foo 2)

macro "rev-args" (Cormullion)
-----------------------------
Questa macro permette di eseguire una funzione/espressione con i parametri in ordine invertito.

(define-macro (rev-args expr)
  (apply (expr 0) (reverse (rest expr))))

(rev-args (div 3 6))
;-> 2

macro "define!" (Cormullion)
----------------------------
Questa macro permette di definire funzioni che hanno la variabile "_self" impostata con il loro nome.

(define-macro (define! farg)
  (set (farg 0)
    (letex (func   (farg 0)
            arg    (rest farg)
            arg-p  (cons 'list (map (fn (x) (if (list? x) (first x) x))
                     (rest farg)))
            body   (cons 'begin (args)))
           (lambda
               arg (let (_self 'func) body)))))

(define! (f a b c)
   (println "I'm " _self)
   (+ a b c))

(define! (g a b c)
   (println "and I'm " _self)
   (+ a b c))

(f 7 8 9)
;-> I'm f
;-> 24

(g 10 11 12)
;-> and I'm g
;-> 33

macro "second" (rickyboy)
-------------------------
Questa funzione estrae il secondo elemento di una lista e ritorna nil se questo elemento non esiste.

Codice standard:
(define (second xs)
  (if (> (length xs) 1) (xs 1)))

Macro:
(define-macro (second)
  (letex (xs (args 0)) (if (> (length xs) 1) (xs 1))))

Se abbiamo delle sequenze lunghe è meglio usare la macro poichè questa non crea una copia della sequenza, quindi è più veloce e utilizza meno memoria.

macro "->" e "->>" pipeline (William James, Johu)
-------------------------------------------------
Queste macro permettono di applicare una lista di funzioni una di seguito all'altra.

(context '->>)
(define-macro (->>:->> E form)
  (if (empty? (args))
    (if (list? form)
      (eval (push E form -1))
      (eval (list form E)))
    (eval (cons '->> (cons (list '->> E form) (args))))))

(context '->)
(define-macro (->:-> E form)
  (if (empty? (args))
    (if (list? form)
      (eval (cons (first form) (cons E (rest form))))
      (eval (list form E)))
    (eval (cons '-> (cons (list '-> E form) (args))))))

(context MAIN)

Supponiamo di voler applicare tre funzioni in in sequenza ad un argomento:

(exp (sqrt (abs -3)))
;-> 5.652233674034092

Con questa macro possiamo scrivere:
(-> -3 abs sqrt exp)
;-> 5.652233674034092

(-> (+ 2 1) abs sqrt exp)
;-> 5.652233674034092

La macro "->" prende il primo elemento come primo argomento della funzione:

(-> 8 (div 4))
;-> 2

The macro "->>" prende il primo elemento come ultimo argomento della funzione:

(->> 8 (div 4))
;-> 0.5

Un altro esempio, estraiamo da una lista associativa i valori che sono in feriori a 50 e li sommiamo:

(setq alist '((a 29)(b 25)(c 21)(d 64)))
(->> alist (map last) (filter (curry > 50)) (apply +))
;-> 75

Altro metodo di scrivere le due macro (johu):

(context 'MAIN:->>)
(define-macro (->>:->> E form)
  (letex (_func
            (if $args (cons '->> (cons (list '->> E form) $args))
                (list? form) (push E form -1)
                (list form E)))
  _func))

(context 'MAIN:->)
(define-macro (->:-> E form)
  (letex (_func
            (if $args (cons '-> (cons (list '-> E form) $args))
                (list? form) (push E form 1)
                (list form E)))
  _func))
(context MAIN)

Notare "(if $args" al posto di "(if (empty? (args))", chiaro e conciso.

Altro metodo di scrivere le due macro (William James):

(context '->>)
(define-macro (->>:->> E form)
  (eval
    (if $args
      (cons '->> (cons (list '->> E form) (args)))
      (if (list? form)
        (push E form -1)
        (list form E)))))

(context '->)
(define-macro (->:-> E form)
  (eval
    (if $args
      (cons '-> (cons (list '-> E form) (args)))
      (if (list? form)
        (cons (first form) (cons E (rest form)))
        (list form E)))))
(context MAIN)

macro "mvdolist" (johu)
-----------------------
Questa macro permette di usare indici multipli con la funzione dolist:

(define-macro (mvdolist)
  (letex (_vars (args 0 0)
          _vals (args 0 1)
          _body (cons 'begin (1 (args))))
    (local _vars
      (dolist (_x (explode _vals (length '_vars)))
        (bind (transpose (list '_vars _x)))
        _body))))

Esempi di utilizzo:
(mvdolist ( (i j k) '(1 2 3 4 5 6 7 8 9)) (println i "-" j "-" k))
;-> 1-2-3
;-> 4-5-6
;-> 7-8-9
(mvdolist ( (i j k) (sequence 1 9) ) (println i "-" j "-" k))
;-> 1-2-3
;-> 4-5-6
;-> 7-8-9
(mvdolist ( (i j k) (sequence 1 5) ) (println i "-" j "-" k))
;-> 1-2-3
;-> 4-5-nil

Altra macro simile:

(define-macro (mvdolist)
  (letex (_varlst (map list (args 0 0))
          _vars (args 0 0)
          _vals (args 0 1)
          _flag (and (= 3 (length (args 0))) (args 0 2))
          _body (cons 'begin (1 (args))))
    (let _varlst
      (dolist (_x (if _flag _vals (explode _vals (length '_vars))))
        (bind (transpose (list '_vars _x)))
        _body))))

Esempi di utilizzo:

(mvdolist ( (i j k) '((1 2 3)(4 5 6)(7 8 9)) ) (println i "-" j "-" k))
;-> (1 2 3)-(4 5 6)-(7 8 9)
(mvdolist ( (i j k) '((1 2 3)(4 5 6)(7 8 9)) true) (println i "-" j "-" k))
;-> 1-2-3
;-> 4-5-6
;-> 7-8-9
(mvdolist ( (i j k) (explode (sequence 1 9) 3) true) (println i "-" j "-" k))
;-> 1-2-3
;-> 4-5-6
;-> 7-8-9
(mvdolist ( (i j k) (explode (sequence 1 9) 4) true) (println i "-" j "-" k))
;-> 1-2-3
;-> 5-6-7
;-> 9-nil-nil
(mvdolist ( (i j k) (explode (sequence 1 9) 2) true) (println i "-" j "-" k))
;-> 1-2-nil
;-> 3-4-nil
;-> 5-6-nil
;-> 7-8-nil
;-> 9-nil-nil
(mvdolist ( (i j k) '(1 2 3) true) (println i "-" j "-" k))
;-> 1-1-1
;-> 2-2-2
;-> 3-3-3

Altra macro simile:

(define-macro (map-mv)
;(map-mv exp-functor nested-list)
   (letex (_func (args 0)
           _vals (args 1))
     (map (curry apply _func) _vals)))

(map-mv (fn (i j k) (println i "-" j "-" k)) (explode (sequence 1 9) 3))
;-> 1-2-3
;-> 4-5-6
;-> 7-8-9
(map-mv pow '((2 1) (2 2) (2 3)))
;-> (2 4 8)

macro "foreach" (Hans-Peter)
----------------------------
Questa macro è l'equivalente della funzione "foreach" del LISP e di Scheme.
Fondamentalmente "for-each" fa la stessa cosa della funzione "map", tranne il fatto che quest'ultima restituisce una lista, mentre "for-each" non ha un valore di ritorno definito (in Scheme).

(define-macro (foreach _foreachx _foreachlst)
  (eval (list 'dolist (list _foreachx _foreachlst)
                      (append (list 'begin) (args)))))

La seguente espressione protegge la macro "foreach" dalla sovrascittura.
(constant (global 'foreach))

Esempio di utilizzo:

(foreach i '(1 2 3 4) (println (* i i)))
;-> 1 4 9 16

Per vedere il risultato dell'espansione di una macro è possibile sostituire le funzione "eval" con la funzione "println":

(define-macro (foreach _foreachx _foreachlst)
  (println (list 'dolist (list _foreachx _foreachlst)
                         (append (list 'begin) (args)))))

(foreach i '(1 2 3 4) (println (* i i)))
;-> (dolist (i '(1 2 3 4))
;->  (begin
;->   (println (* i i))))
;-> (dolist (i '(1 2 3 4))
;->  (begin
;->   (println (* i i))))

Potremmo definire for-each anche senza definire una macro:

(setq foreach map)
(foreach (fn(x)(println(* x x))) '(1 2 3 4))
;-> 1
;-> 4
;-> 9
;-> 16
;-> (1 4 9 16)

Altro esempio fornito da Lutz:

(define-macro (foreach _x from _a to  _z _body)
  (for (_x (eval _a) (eval _z)) (eval _body)))

(foreach i from 1 to 5 (print _x { }))
;-> 1 2 3 4 5 " "


macro "doc" (Cormullion-jamesqiu-cameyo)
---------------------------------------
Questa macro permette di visualizzare il manuale di riferimento di una funzione.

(context 'doc)

(define-macro (doc:doc func-name)
  (let ((func-name (string func-name)))
     (set 'f (read-file {/c:/newlisp/newlisp_manual.html}))
     (set 'r (regex (string "<a name=\"" func-name "\"></a>") f))
     (set 'n0 (r 1))
     (set 'n1 ((regex "<a name=" f 0 (+ n0 (r 2))) 1))
     (set 'html-text (slice f n0 (- n1 n0)))
     (replace "<.*?>" html-text "" 0)
     (replace "&lt;"  html-text "<")
     (replace "&gt;"  html-text ">")
     (replace "&amp;" html-text "&")
     (replace "&nbsp;" html-text " ")
     (replace "&mdash" html-text "...")
     (replace "&rarr;" html-text "->")
     (replace "\n\n+" html-text "\n\n" 1)
     (replace "^\n+|\n+$" html-text "" 1)
     (replace "\t" html-text "" 1)
     ;(replace "[  ]" html-text " " 1)
     (println "--------------------------")
     (println html-text)
     (println "--------------------------")
     'end))

(context MAIN)

Esempio di utilizzo:

(doc curry)
(doc map)
(doc apply)
(doc println)

Purtroppo non funziona per i predicati (null?, zero?, ecc.)
(doc null?)
;-> ERR: invalid function in function set : (r 1)
;-> called from user function (doc null?)

macro "fnkeyword" (Lutz-Cormullion-cameyo)
------------------------------------------
Questa macro permette di passare argomenti con nome e valore alla macro:

(define-macro (fnkeyword)
   (local (len width height)
      (bind (args) true)
      (println "len:" len " width:" width " height:" height)
   ))

(fnkeyword (width 20) (height 30) (len 10))
;-> len:10 width:20 height:30

(fnkeyword (w 20) (h 30) (l 10))
;-> len:nil width:nil height:nil

Con una piccola modifica possiamo chiamare una funzione con i parametri passati ala macro:

(define-macro (fnkeyword func)
   (local (len width height)
      (bind (args) true)
      (println "len:" len " width:" width " height:" height)
      ((eval func) len width height)
   ))

(fnkeyword + (width 20) (height 30) (len 10))
;-> len:10 width:20 height:30
;-> 60

macro "ifnot" (cameyo)
----------------------
Questa macro implementa un "if negato".

(define-macro (ifnot _condition _else _then)
  (if (eval _condition)
      (eval _then)
      (eval _else)))

(ifnot (> 3 2) (setq a 4) (setq b 1))
;-> 1
(ifnot (< 3 2) (setq a 4) (setq b 1))
;-> 4

macro "until-0" (nallen05)
--------------------------
Questa macro implementa il controllo "until" con il test di confronto prefissato al valore zero:

(define-macro (until-0)
  (letex (zero-form (args 0)
         body      (cons 'begin (1 (args))))
   (let ($num nil)
    (until (= 0 (setq $num zero-form))
      body))))

Esempi di utilizzo:

(until-0 0 (println  $idx ":" $num " not 0"))
;-> nil

(until-0 (rand 10) (println  $idx ":" $num " not 0"))
;-> 0:5 not 0
;-> 1:6 not 0
;-> 2:4 not 0
;-> 3:1 not 0
;-> 4:9 not 0
;-> 5:9 not 0
;-> 6:5 not 0

macro "up-down" (William James)
-------------------------------
Questa macro simula una pseudo-closure utilizzando gensym.

(define (gensym:gensym)
  (sym (string "gensym-" (inc gensym:counter))))

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

Proviamo la funzione:

(up-down)
(1 98)
(up-down)
(2 97)
(up-down)
(3 96)

(println up-down)
;-> (lambda () (list (++ gensym:gensym-14) (-- gensym:gensym-15)))

Nota: la funzione gensym può essere scritta anche nel seguente modo:

(define (gensym:gensym)
  (sym (string "gs-" (sym (uuid)))))

Questo funziona perchè "uuid" genera una valore univoco. Comunque, la prima funzione "gensym" è leggermente più veloce e mantiene i simboli generati tutti nel relativo spazio dei nomi gensym. Se usiamo pochi valori, allora (sym (uuid)) è più pratico. Una pratica sicura è quella di definire le macro (fexprs) nel loro spazio dei nomi, che risolve anche il problema della cattura delle variabili creando una specie di chiusura lessicale.

macro "a-if"
------------
Un'altra macro che simula il controllo "if" con l'aggiunta di una variabile anaforica $it.

(define-macro (aif)
  (let ((_it (eval (args 0))))
    (if _it
      (eval (args 1))
      (eval (args 2)))))

Esempi d'uso:

(aif (> 4 2) (println _it) (println "else"))
;-> true
(aif (> 2 4) (println _it) (println "else"))
;-> else
(let (a 5) (aif a (println _it) (println "else")))
;-> 5

macro "loop" e "recur" (rickyboy)
----------------------
Macro che simulano le istruzioni

(constant '[loop/recur-marker] '[loop/recur-marker])

(define (loop- BODY-FN)
  (let (.args (args) .res nil)
    (while (begin
             (setq .res (apply BODY-FN .args))
             (when (and (list? .res) (not (empty? .res))
                        (= [loop/recur-marker] (first .res)))
               (setq .args (rest .res)))))
    .res))

(define (recur) (cons [loop/recur-marker] (args)))

(define (flat-shallow-pairs LIST)
  (let (i 0 acc '())
    (dolist (e LIST)
      (cond ((even? i) ; Indicator i is even = abscissa
             (cond ((and (list? e) (not (empty? e)))
                    (extend acc (0 2 (push nil e -1))))
                   ((symbol? e)
                    (push e acc -1)
                    (inc i))))
            ((odd? i) ; Indicator i is odd = ordinate
             (push e acc -1)
             (inc i))))
    acc))

(define (parms<-bindings BINDINGS)
  (map first (explode (flat-shallow-pairs BINDINGS) 2)))

(define-macro (loop INIT)
  (letn (.parms (parms<-bindings INIT)
         .body-fn (letex ([body] (args)
                          [parms] .parms)
                    (append '(fn [parms]) '[body]))
         .loop-call (letex ([body-fn] .body-fn
                            [parms] .parms)
                      (append '(loop- [body-fn]) '[parms])))
    (letex ([init] INIT [loop-call] .loop-call)
      (letn [init] [loop-call]))))

Vediamo due esempi di utilizzo delle macro:

(define (factorial x)
  (loop (x x acc 1)
    (if (< x 1)
        acc
        (recur (- x 1) (* x acc)))))

(factorial 10)
;-> 3628800

(define (fibo x)
  (loop (x x curr 0 next 1)
    (if (= x 0)
        curr
        (recur (- x 1) next (+ curr next)))))

(fibo 10)
;-> 55

macro "my-or" (Kazimir Majorinc)
--------------------------------
Questa macro simula la funzione boolena "or".

(set 'my-or
  (lambda-macro (x y)
     (first (list (eval (let ((temp (sym (append (string (last (symbols))) "+"))))
                    (expand
                     '(let ((temp (eval x)))
                            (if temp          ; Naive
                              temp          ; version
                              (eval y)))
                 'temp)))
             (delete (last (symbols)))    ))))

Esempio:

(setq temp 45)
(my-or 45 nil)
;-> 45
(my-or nil 45)
;-> 45

Commento di Lutz:
La soluzione corretta in newLISP è quella di evitare la cattura variabile in primo luogo racchiudendo il "my-or" in uno spazio dei nomi (contesto):

(define-macro (my-or:my-or)
   (let (my-or:temp (eval (args 0)))
      (if my-or:temp my-or: temp (eval (args 1)))))

(my-or 1 nil)
;-> 1
(my-or nil 1)
;-> 1

Questa funzione è più veloce e risolve il problema della cattura delle variabili.

Nelle versioni prcedenti del manuale di newLISP era riportata questa funzione di utilità per definire funzioni racchiuse automaticamente nel proprio contesto:

(define (def-static s body)
    (def-new 'body (sym s s)))

la funzione accetta un nuovo simbolo nome-funzione "s" e crea una nuova funzione racchiusa in uno spazio dei nomi. Qui "def-static" è usata per definire "my-or:my-or" come sopra trasformando la vecchia definizione in una nuova con ambito statico:

(def-static 'my-or
    (fn-macro (x y)
        (let (temp (eval x)) (if temp temp (eval y)))))

(my-or 1 nil)
;-> 1
(my-or nil 1)
;-> 1

In questo modo possiamo anche evitare di utilizzare (args ...) e nominare le variabili per una migliore leggibilità.

Non esiste il problema dell"esaurimento degli spazi dei nomi". Un overhead dello spazio dei nomi è costituito da nient'altro che un simbolo aggiuntivo, il simbolo di contesto. Potenzialmente possiamo avere milioni di contesti in newLISP senza alcun problema.

Un commento generale:

Invece di provare a emulare Scheme o altri LISP tradizionali, dovremmo enfatizzare le tipiche soluzioni di newLISP. Cercare di utilizzare le tecniche di Scheme in newLISP porta solo a un codice inefficiente e, spesso, brutto e newLISP viene percepito come un LISP di seconda classe a causa di ciò.

Proprio come Scheme è progettato attorno all'ambito lessicale e alle chiusure, newLISP è progettato attorno all'ambito dinamico e agli spazi dei nomi (contesti). Entrambi gli approcci sono progettati per evitare conflitti tra nomi di simboli e mantenere lo stato. Credo che il nuovo approccio LISP sia alla fine più facile da capire e più aperto all'esplorazione dei futuri paradigmi di programmazione.

Inoltre, newLISP non può generare contesti innestati, che introducono un complessità inutile.

Come nota a margine: il linguaggio non ha il meccanismo di "ricorsione della coda" (tail recursion) perché altrimenti la ricorsione sarebbe stato il principale meccanismo di controllo del flusso. Limitare il controllo del flusso alla ricorsione e alle continuazioni sarebbe stata una limitazione innaturale in newLISP, forse bella dal punto di vista matematico, ma ostica da usare e comprendere per le persone di altre discipline.
Lutz

Versione proposta da DrDave:

(define-macro (my-or)
   (let (temp (eval (args 0))
         temp1 (eval (args 1)))
     (if temp
         temp
         temp1)))

Versione proposta da Michael (però usa "or"):

(define-macro (my-or)
   (or (eval (args 0)) (eval (args 1)))
)

Versione proposta da newdep:

(define-macro (my-or)
 (let (temp
  (unless (eval (args 0))
   (eval (args 1))))
    temp))

Versione proposta da cgs1019:

Questa soluzione utilizza una funzione lambda per memorizzare il primo argomento valutato nella macro e rinviare la valutazione del secondo. Non è veloce come la soluzione presentata da Lutz, che ha un tempo di esecuzione di circa il 65% di questa, probabilmente perché  comporta una chiamata di funzione aggiuntiva. Ma almeno evita la necessità di creare un nuovo contesto solo per una semplice macro.

Il trucco è quello di usare una chiamata di funzione nidificata per trasferire argomenti nella funzione nidificata in modo da non dover usare alcuna variabile. Poiché (arg n) sono sempre locali, è impossibile la cattura delle variabili.

(define-macro (my-or)
  (
    (lambda ()
      (if (args 0)
        (args 0)
         (eval (args 1))
      )
    )
    (eval (args 0))
    (args 1)
  )
)

Possiamo riscriverla per capire meglio come funziona:

(define-macro (my-or)
  (let ( func (lambda () (if (args 0) (args 0) (eval (args 1)) )))
    (func (eval (args 0)) (args 1))
  )
)

cgs1019 utilizza un versione anonima di func. Questo è equivalente a:

((lambda (x) (+ x x)) 1)
;-> 2

macro "ncase" (Sammo, nigelbrown)
---------------------------------
Questa macro simula la funzione "case" con valori multipli di comparazione.

(define-macro (ncase _x)
    (eval (append (list 'case _x) (apply append (map expandit (rest (args)))))))

(define (expander c)
    (apply append (map expandit c)))

(define (expandit x)
    (if (list? (first x))
        ;((a b c) d e) --> ((a d e) (b d e) (c d e))
        (map (lambda (y) (append (list y) (rest x))) (first x))
    ;else
        ;(a d e) --> ((a d e))
        (list x) ))

Esempi:

(ncase "diane" () (("bob" "mary" "susie") 'friend) (("tim" "diane") 'boss) ("sam" 'self) ("sammo" 'clever-alias) (true 'stranger))
;-> boss

(ncase "bob" () (("bob" "mary" "susie") 'friend) (("tim" "diane") 'boss) ("sam" 'self) ("sammo" 'clever-alias) (true 'stranger))
;-> boss

(ncase 3 () ((1 3 5 7 9) "odd") (10 "ten") ((2 4 6 8) "even") (true "none"))
"odd"
(ncase 10 () ((1 3 5 7 9) "odd") (10 "ten") ((2 4 6 8) "even") (true "none"))
"ten"
(ncase 2 () ((1 3 5 7 9) "odd") (10 "ten") ((2 4 6 8) "even") (true "none"))
"even"
(ncase 35 () ((1 3 5 7 9) "odd") (10 "ten") ((2 4 6 8) "even") (true "none"))
"none"
(ncase 5 () ((1 3 5 7 9) "odd") (10 "ten") ((2 4 6 8) "even") (true "none"))

macro "+-" (Lutz)
-----------------
Questa macro permette di calcolare la seguente espressione:

(a + b - c + d - ...)

dove a,b,c,d,... sono valori numerici

(define-macro (+- )
  (let (signs (cons 1 (series 1 -1 (- (length (args)) 1))))
   (apply 'add (map 'mul (map eval (args)) signs))))

Esempi:

(+- 1 2 3 4 5)
;-> -1
(apply +- '(1 2 3 4))
;-> 4
(apply +- (sequence 1 5))
;-> -1
(+- 1.2 1.2 2.4)
;-> 0

Possiamo farlo anche con una funzione, che è anche più veloce (rickyboy).

(define (+-)
  (let (signs (cons 1 (series 1 -1 (- (length (args)) 1))))
    (apply add (map mul signs (args)))))

macro "try" (Lutz)
------------------
Questa macro permette di gestire errori come eccezioni.

(define-macro (try body else)
    (if (not (catch (eval body) 'result))
         (eval else)
         result))

(setq error-text "errore")
; now try this

(try (+ 3 4) (println error-text))
;-> 7

(try (xyz) (println error-text))
;-> errore

macro "+++" e "---" (Dmitry)
----------------------------
Queste macro simulano le funzioni di incremento/decremento "++" e "--".

(define-macro (+++ _a _b)
  (if (symbol? _a)
    (set _a (+ (eval _a) (or _b 1)))
  ;else
    (+ (eval _a) (or _b 1)) ))

(define (--- _a _b)
  (if (symbol? _a)
    (set _a (- (eval _a) (or _b 1)))
  ;else
    (- (eval _a) (or _b 1)) ))

Le seguenti versioni valutano l'espressione "_b" prima di essere usata, in questo modo possiamo scrivre: (+++ var (expression))

(define-macro (+++ _a _b)
  "(++ a b) - increment a by b. a can by either a symbol or a value"
  (if (symbol? _a)
    (set _a (+ (eval _a) (or (eval _b) 1)))
    (+ (eval _a) (or (eval _b) 1)) ))

(define-macro (--- _a _b)
  "(--- a b) - decrement a by b. a can by either a symbol or a value"
  (if (symbol? _a)
    (set _a (- (eval _a) (or (eval _b) 1)))
    (- (eval _a) (or (eval _b) 1)) ))

(--- (+ 3 3) (- 4 2))
;-> 4

Nota: "+++" e "---" funzionano solo con i numeri interi.

Infine, una versione senza utilizzare le macro:

(define (+++ _a01 _b01)
  "(++ int-a int-b) - increment int-a by int-b. int-a can be either a symbol or a value"
  (if (symbol? _a01)
    (set _a01 (+ (eval _a01) (or _b01 1)))
    (+ (eval _a01) (or _b01 1))))

(setq a 1)
(+++ 'a)
;-> 2
a
;-> 2

macro "dolist-index" (Lutz)
---------------------------
Questa macro simula la funzione "dolist".

(define-macro (dolist-index)
  (letex (var ((args) 0 0)
          lst ((args) 0 1)
          idx ((args) 0 2)
          body (cons 'begin (1 (args))))
          (setq idx 0)
          (dolist (var lst)
              body
              (inc idx) )
   )
)

(dolist-index (i '(a b c d e f) id) (println id ":" i))
0:a
1:b
2:c
3:d
4:e
5:f

Nota: l'uso di (args) rende la macro "igienica", ma l'utilizzo di un contesto e del relativo funtore di default rende il codice più leggibile e forse più veloce.

macro "rep-var" (Lutz)
----------------------
Questa macro permette di interpolare una variabile in una stringa.

(define-macro (rep-var str)
    (dolist (_v (args))
        (replace (append "#" (string _v)) (eval str) (eval _v))))

(setq var "pippo")
;-> "pippo"
(rep-var "Buonanotte #var" var)
;-> "Goodnight pippo"

macro "not-" e "if-" (Jeremy Dunn)
-----------------------------

;; Negate a boolean function
;; Write (not (= x y)) as (not- = x y)
(define-macro (not-) (not (eval (args))))

(setq x 2 y 3)
(not- = x y)
;-> true
(setq x 2 y 2)
(not- = x y)
;-> nil

;; Convert a boolean to an if statement
;; Write (if (= x 3) a b) as (if- = x 3 a b)
(define-macro (if-)
  (setq L (length (args)))
  (if (eval (0 (- L 2)(args)))
      (eval (nth -2 (args)))
      (eval (last (args)))
  ))

(if- > 4 5 (println "riga 1") (println "riga 2"))
;-> riga 2

(setq a (println "a"))
(setq b (println "b"))
(if- = 3 3 a b)
;-> "a"
(if- > 3 4 a b)
;-> "b"

macro "if*" (Cormullion)
------------------------
Questa macro simula un "if" senza "else", ma permette di eseguire multiple espressioni senza utilizzare la funzione "begin".

(define-macro (if* condition)
  (let (c (eval condition))
    (if c (map eval (args)))))

(if* true
   (println "uno")
   (println "due")
   (println "tre"))
;-> uno
;-> due
;-> tre
;-> ("uno" "due" "tre")

Comunque è meglio utilizzare la funzione "cond".

macro "defun" (kinghajj)
------------------------
Questa macro definisce la funzione "DEFUN" del Common LISP.

; This macro provides a classic defun.
; If I remember CL correctly, if an argument is prefixed with &, then it is not
; evaluated; that is hom CL makes macros. This macro checks if the argument name
; has a & at the start, and if it does it does not evaluate it. This makes it
; easy if you want to write a macro that needs no evaluate some arguments.
(define-macro (defun _name _args)
  (let (_body (args))
    ; go through to arguments
    (dolist (_arg _args)
        ; evaluate argument unless prefixed with &
        (unless (= (first (string _arg)) "&")
          (push (list 'eval _arg) _body)))
    ; create macro function
    (set _name (append (lambda-macro) (list _args) _body))))

Esempio:

(defun test (v1 &v2)
   (println "Got " v1 " and " &v2))

(test 37 (+ 40 2))
; => "Got 37 and (+ 40 2)"

macro "each" (Jeff)
-------------------
Questa macro implementa una struttura di controllo iterativa.

(define-macro (each object do iter)
  (set 'iter (trim (string iter) "|"))
  (dolist (obj (eval object))
          (eval (set (sym (eval iter)) obj))
          (catch (doargs (a)
                 (if (= a 'end) (throw nil) (eval a))))))

La sintassi è la seguente:

(each '(ruby is not a lisp) do |item| (println item) end)
;-> ruby
;-> is
;-> not
;-> a
;-> lisp

Altra versione senza "end" finale (rickyboy).

(define-macro (each object iter)
  (set 'iter (trim (string iter) "|"))
  (dolist (obj (eval object))
    (eval (set (sym (eval iter)) obj))
    (doargs (a) (eval a))))

(each '(ruby is not a lisp) |item| (println item))
;-> ruby
;-> is
;-> not
;-> a
;-> lisp

macro "my-define" (Cormullion, Fanda)
-----------------------------------
Questa macro crea una nuova versione di "define", in modo tale che quando viene chiamata la funzione che definisce, stampa i suoi argomenti (ad esempio su un file di log).

"define" crea una funzione/lista lambda. È necessario includere le funzioni di "print" nella nuova funzione da creare:

(define-macro (my-define @farg)
  (set (@farg 0)
    (letex (@fn (@farg 0)
            @arg (rest @farg)
            @arg-p (cons 'list (map (fn (@x) (if (list? @x) (first @x) @x)) (rest @farg)))
            @body (args))
      (append
           (lambda @arg (println "[" '@fn "] params: " @arg-p " args: " (args)))
        '@body))))

(constant (global 'define) my-define)

Esempi:

(define (f x) (+ x x))
;-> (lambda (x) (println "[" 'f "] params: " (list x) " args: " (args)) (+ x x))
(f 2)
;-> [f] params: (2) args: ()
;-> 4

(define (f (x 10) y) (+ x y))
;-> (lambda ((x 10) y) (println "[" 'f "] params: " (list x y) " args: " (args)) (+ x y))
(f 2 3)
;-> [f] params: (2 3) args: ()
;-> 5
(f 2 3 4 5)
;-> [f] params: (2 3) args: (4 5)
;-> 5

Nota: viene usato il carattere "@" (at) invece di "_" (underscore) perché in genere le macro hanno variabili che iniziano con "_" e quindi evitiamo il conflitto tra variabili.

Altra versione che ritorna anche il risultato della funzione:

(define-macro (my-define @farg)
  (set (@farg 0)
    (letex (@fn (@farg 0)
            @arg (rest @farg)
            @arg-p (cons 'list (map (fn (@x) (if (list? @x) (first @x) @x)) (rest @farg)))
            @body (cons 'begin (args)))
       (lambda @arg
         (println "[" '@fn "] params: " @arg-p " args: " (args))
         (println "[" '@fn "] result: " @body)))))

(constant (global 'define) my-define)

Esempi:

(define (f (x 10) y) (+ x y))
;-> (lambda ((x 10) y) (println "[" 'f "] params: " (list x y) " args: " (args))
  ;-> (println "[" 'f "] result: "  (begin  (+ x y))))
(f 2 3)
;-> [f] params: (2 3) args: ()
;-> [f] result: 5
;-> 5
(f 2 3 4 5)
;-> [f] params: (2 3) args: (4 5)
;-> [f] result: 5
;-> 5

macro "type" (Fanda)
--------------------
Questa macro permette di determinare il tipo dell'argomento.

(define-macro (type)
  (cond
    ((integer? (args 0)) "integer")
    ((float? (args 0)) "float")
    ((symbol? (args 0)) "symbol")
    ((string? (args 0)) "string")
    ((lambda? (args 0)) "lambda")
    ((macro? (args 0)) "macro")
    ((context? (args 0)) "context")
    ((list? (args 0)) "list")
    ((nil? (args 0)) "nil")
    (true nil)))

(type 1)
;-> "integer"

(type a)
;-> "symbol"

Un piccolo problema:

(type type)
;-> "symbol"
(macro? type)
;-> true

Nota: attenzione ad accettare troppi tipi di dati in una funzione. Soprattutto in un linguaggio con ambito dinamico, in cui è importante conoscere con sicurezza il tipo dei parametri in ingresso e di uscita.

macro "atag" (Lutz)
-------------------
Questa macro permette di formattare i tag HTML (JSON, XML).

(define-macro (atag )
  (append "<atag> " (join (map string (args)) " ") " </atag>"))

Esempio:

(atag a b c)
;-> "<atag> a b c </atag>"

Quindi l'idea è quella di definire una funzione o macro per ogni tag per formattarli agevolmente.

macro "func-lst" (Lutz)
-----------------------
Questa macro mostra come controllare quale parametro della macro sia una lista (cioè individuare quale indice ha il primo parametro di tipo lista).

(define-macro (func-lst) (nth (first (index list? (args))) (args)))
(func-lst 1 2 (a b c))
;-> (a b c)

(func-lst 1 2 (a b c) 4 5)
;-> (a b c)

Possiamo renderla più corta con la funzione "filter":

(define-macro (func-lst) (first (filter list? (args))))
(func-lst 1 2 (a b c) 4 5)
;-> (a b c)

Anche più corta con l'indicizzazione implicita (implicit indexing):

(define-macro (func-lst) ((filter list? (args)) 0))
(func-lst 1 2 (a b c) 4 5)
;-> (a b c)

macro "sq" (Jeremy Dunn)
------------------------
Questa macro effettua calcoli diversi in funzione del numero dei parametri:
un parametro: calcola il quadrato del parametro
N parametri: calcola la radice della somma dei quadrati dei parametri

;; This function takes one or more numbers as arguments. If there is a single
;; number the number is squared. If there is more than one number then the square
;; root of the sum of the squares (a^2 + b^2 + c^2 + ...)^1/2 is returned.
;; Example: (sq 3) -> 9
;;          (sq 2 3) -> 3.605551275
(define-macro (sq)
  (if (= (length (args)) 1)
      (mul (args 0)(args 0))
      (sqrt (apply add (map mul (args)(args))))))

macro "plist" (Jeff)
--------------------
Questa macro simula l'utilizzo delle property lists.

(define-macro (plist) (map rest (explode (args) 3)))

Esempio:

(println (plist :foo "bar" :baz "bat"))
;-> ((foo "bar") (baz "bat"))

macro "do" (Jeff)
-----------------
Ecco una macro che simula il controllo "do" del Common LISP (in realtà è più simile a do*, poiché usa "letn", piuttosto che "let" nella sua espansione):

(define-macro (do)
  (letex ((iter-forms (args 0))
        (break (args 1 0))
        (result (args 1 1))
        (body (cons begin (rest (rest (args))))))
   (letex ((init-forms (map (fn (form) (0 2 form)) 'iter-forms))
         (update-symbols (reverse (map first 'iter-forms)))
         (update-values (reverse (map last 'iter-forms))))
     (letn init-forms
      (do-until break body
              (map set 'update-symbols
                  (map eval 'update-values)))
      result))))

Questo è qualcosa che non si trova in newLISP. Tranne in casi specializzati come dolist, è più probabile che l'iterazione si verifichi su più variabili. La sintassi di questa macro è simile a quella del ciclo "for" (senza il valore del passo), con più espressioni init/update, quindi la lista della espressione di break e il risultato dell'espressione.

Ecco un esempio di fattoriale (da Ansi Common Lisp) che usa questo "do". Non ha nemmeno un corpo, perché i moduli di aggiornamento (update) fanno tutto il lavoro. Ho incluso un commento sulla posizione dove dove sarebbe il corpo.

(define (factorial n)
  (do ((j n (- j 1))
      (f 1 (* j f)))
     ((= j 0) f)
    ; (println j ", " f)
  ))

(println (factorial 10))
;-> 3628800

Sintassi:

(do ((sym1 init-form1 update-form1) [(sym2 init-form2 update-form2) ...])
     (exp-break sym-result) (expr-body*))

In altre parole, questa macro fa semplicemente la stessa cosa del ciclo "for", ma su più variabili, con una condizione di arresto e controllo sul valore restituito.

Considerazioni generali
-----------------------
L'idea alla base delle macro è quella di poter espandere la sintassi del linguaggio stesso quando necessario. Certo, le s-espressioni rendono questo meno necessario, dal momento che è possibile passare un lambda come "blocco di codice" a una funzione.

È generalmente accettato che l'utilizzo di macro per ottimizzare un programma è comunque una cattiva pratica. Le macro dovrebbero essere utilizzate per implementare funzionalità che non sarebbero altrimenti disponibili o che altrimenti richiederebbero la duplicazione della logica.

Le macro permettono di creare strutture sintattiche specifiche per scrivere un programma, spesso chiamati linguaggi specifici di dominio (DSL - Domain Specific Language). In questo modo la soluzione del problema viene definita (programmata) con espressioni (funzioni) che si adattano/descrivono meglio al dominio del problema stesso.

Nota: "define-macro" alone is just a "define" without arguments evaluation (Lutz).


=========================================================
 FOOP - PROGRAMMAZIONE FUNZIONALE ORIENTATA AGLI OGGETTI
=========================================================

La programmazione orientata agli oggetti funzionali (FOOP - Functional Object Oriented Programming) si basa sui seguenti cinque principi:

1) Gli attributi e i metodi delle classi sono memorizzati nello spazio dei nomi della classe di oggetti.

2) La funzione predefinita dello spazio dei nomi (functor) contiene il metodo di costruzione degli oggetti.

3) Un oggetto viene costruito utilizzando una lista, il cui primo elemento è il simbolo di contesto che descrive la classe dell'oggetto.

4) Il polimorfismo viene implementato usando l'operatore: (due punti), che seleziona la classe appropriata dall'oggetto.

5) Un oggetto target all'interno di una funzione dei metodi della classe è accessibile tramite la funzione "self".

I seguenti paragrafi sono una breve introduzione alla FOOP progettata da Michael Michaels:
http://neglook.com/

Al seguente indirizzo web potete trovare alcuni tutorial video sull'utilizzo della FOOP in newLISP:

http://neglook.com/index.cgi?page=newLISP

Classi e costruttori FOOP
-------------------------
Gli attributi e i metodi della classe sono memorizzati nello spazio dei nomi della classe di oggetti. Nessun dato dell'istanza di un oggetto è memorizzato in questo spazio dei nomi/contesto. Le variabili di dati nello spazio dei nomi della classe descrivono solo la classe di oggetti nel suo insieme, ma non contengono alcuna informazione specifica sull'oggetto. Un costruttore di oggetti FOOP generico può essere utilizzato come modello (template) per specifici costruttori di oggetti quando si creano nuove classi di oggetti con la funzione "new":

; built-in generic FOOP object constructor
(define (Class:Class)
    (cons (context) (args)))

; create some new classes

(new Class 'Rectangle)   → Rectangle
(new Class 'Circle)      → Circle

; create some objects using the default constructor

(set 'rect (Rectangle 10 20))   → (Rectangle 10 20)
(set 'circ (Circle 10 10 20))   → (Circle 10 10 20)

; create a list of objects
; building the list using the list function instead of assigning
; a quoted list ensures that the object constructors are executed

(set 'shapes (list (Circle 5 8 12) (Rectangle 4 8) (Circle 7 7 15)))
→ ((Circle 5 8 12) (Rectangle 4 8) (Circle 7 7 15))

Il costruttore FOOP generico è già predefinito e il codice FOOP può iniziare subito con (new Class ...).

Per motivi di stile, le nuove classi dovrebbero essere create solo nel contesto MAIN. Se si crea una nuova classe in uno spazio dei nomi diverso, il nome della nuova classe deve essere preceduto da MAIN e l'istruzione deve essere al livello superiore:

(context 'Geometry)

(new Class 'MAIN:Rectangle)
(new Class 'MAIN:Circle)

...

La creazione delle classi nello spazio dei nomi usando new riserva il nome della classe come contesto in newLISP e facilita i riferimenti diretti. Allo stesso tempo, viene definito un semplice costruttore per la nuova classe per creare istanze di nuovi oggetti. Come convenzione, si consiglia di iniziare i nomi delle classi in maiuscolo per segnalare che il nome sta per uno spazio dei nomi.

In alcuni casi, può essere utile sovrascrivere il costruttore semplice, creato durante la creazione della classe, con "new":

; overwrite simple constructor
(define (Circle:Circle x y radius)
    (list Circle x y radius))

Un costruttore può anche specificare i valori predefiniti:

; costruttore con valori predefiniti
(definisci (Cerchio: Cerchio (x 10) (y 10) (raggio 3))
    (elenco Cerchio x raggio y))

(Cerchio) → (Cerchio 10 10 3)
In molti casi il costruttore creato quando si utilizza new è sufficiente e non è necessario sovrascriverlo.

Oggetti e associazioni
----------------------
FOOP rappresenta gli oggetti come liste. Il primo elemento dell'elenco indica il tipo o la classe dell'oggetto, mentre gli elementi rimanenti contengono i dati. Le seguenti istruzioni definiscono due oggetti utilizzando uno dei costruttori definiti in precedenza:

(set 'myrect (Rectangle 5 5 10 20)) → (Rectangle 5 5 10 20)
(set 'mycircle (Circle 1 2 10)) → (Circle 1 2 10)

Un oggetto creato è identico alla funzione necessaria per crearlo (quindi FOOP). Gli oggetti nidificati possono essere creati in modo simile:

; create classes
(new Class 'Person)
(new Class 'Address)
(new Class 'City)
(new Class 'Street)

; create an object containing other objects
(set 'JohnDoe (Person (Address (City "Boston") (Street 123 "Main Street"))))
→ (Person (Address (City "Boston") (Street 123 "Main Street")))

Gli oggetti in FOOP non solo assomigliano a funzioni, ma assomigliano anche ad associazioni. La funzione assoc può essere utilizzata per accedere ai dati degli oggetti per nome:

(assoc Address JohnDoe) → (Address (City "Boston") (Street 123 "Main Street"))

(assoc (list Address Street) JohnDoe) → (Street 123 "Main Street")

In modo simile setf insieme ad assoc può essere usato per modificare i dati degli oggetti:

(setf (assoc (list Address Street) JohnDoe) '(Street 456 "Main Street"))
→ (Street 456 "Main Street")

Il numero civico "Street number" è stato cambiato da 123 a 456.

Si noti che nessuna delle dichiarazioni associate ad Address e Street contiene virgolette. Lo stesso vale per l'istruzione set: (set 'JohnDoe (Person ...)) per la parte di assegnazione dati. In entrambi i casi non trattiamo con simboli o con liste di simboli, ma piuttosto con contesti e oggetti FOOP che valutano su se stessi. Le virgolette non fanno alcuna differenza.

I due punti (colon) : operatore e polimorfismo
----------------------------------------------
In newLISP, il carattere due punti ":" viene utilizzato principalmente per connettere il simbolo di contesto con il simbolo che sta qualificando. In secondo luogo, la funzione due punti viene utilizzata in FOOP per risolvere l'applicazione di una funzione polimorfa.
Il codice seguente definisce due funzioni chiamate area, ognuna appartenente a un diverso spazio dei nomi/classe. Entrambe le funzioni avrebbero potuto essere definite in moduli diversi per una migliore separazione, ma in questo caso sono definite nello stesso file e senza istruzioni di contesto tra parentesi. Qui, solo i simboli rettangle:area e circle:area appartengono a spazi dei nomi diversi. I parametri locali p, c, dx e dy fanno tutti parte di MAIN, ma questo non è un problema.

;; class methods for rectangles

(define (Rectangle:area)
    (mul (self 3) (self 4)))

(define (Rectangle:move dx dy)
    (inc (self 1) dx)
    (inc (self 2) dy))

;; class methods for circles

(define (Circle:area)
    (mul (pow (self 3) 2) (acos 0) 2))

(define (Circle:move dx dy)
    (inc (self 1) dx)
    (inc (self 2) dy))

Prefissando il simbolo area con il carattere ":" (due punti), possiamo chiamare queste funzioni per ciascuna classe di oggetti. Sebbene non vi sia spazio tra i due punti e il simbolo che lo segue, newLISP li analizza come entità distinte. I due punti possono essere visti come una funzione che processa i parametri:

(:area myrect) → 200 ; same as (: area myrect)
(:area mycircle) → 314.1592654 ; same as (: area mycircle)

;; map class methods uses curry to enclose the colon operator and class function

(map (curry :area) (list myrect mycircle)) → (200 314.1592654)

(map (curry :area) '((Rectangle 5 5 10 20) (Circle 1 2 10))) → (200 314.1592654)

;; objects are mutable (since v10.1.8)

(:move myrect 2 3)
(:move mycircle 4 5)

myrect    → (Rectangle 7 8 10 20)
mycircle  → (Circle 5 7 10)

In questo esempio, il simbolo qualificato correttamente (rettangle:area o circle:area) viene costruito e applicato ai dati dell'oggetto in base al simbolo che segue i due punti e il nome del contesto (il primo elemento della lista che rappresenta l'oggetto).

Si noti che sebbene il chiamante specifica l'oggetto target della chiamata, la definizione del metodo non include l'oggetto come parametro. Quando si scrivono funzioni per modificare oggetti FOOP, viene utilizzata la funzione "self" per accedere e indicizzare l'oggetto.

Strutturare un programma FOOP grande
------------------------------------
In tutti gli esempi precedenti, i metodi delle funzioni della classe venivano scritti direttamente nello spazio dei nomi del contesto MAIN. Questo metodo funziona ed è adeguato per programmi piccoli scritti da un solo programmatore. Quando si scrivono sistemi più grandi, tutti i metodi di una classe dovrebbero essere rachhiusi da istruzioni di contesto per fornire un migliore isolamento delle variabili di parametro utilizzate e per creare una locazione isolata per le potenziali variabili di classe.

Le variabili di classe potrebbero essere utilizzate in questo esempio come contenitore per liste di oggetti, contatori o altre informazioni specifiche di una classe, ma non di un oggetto specifico. Il seguente codice riscrive l'esempio precedente in questo modo.

Ogni contesto/spazio dei nomi potrebbe essere memorizzato in un file aggiuntivo con lo stesso nome della classe contenuta. La creazione della classe, il codice di avvio e il codice di controllo principale si trovano nel file MAIN.lsp:

; file MAIN.lsp - declare all classes used in MAIN

(new Class 'Rectangle)
(new Class 'Circle)

; start up code

(load "Rectangle.lsp")
(load "Circle.lsp")

; main control code

; end of file

Ogni classe si trova in un file separato:

; file Rectangle.lsp - class methods for rectangles

(context Rectangle)

(define (Rectangle:area)
(mul (self 3) (self 4)))

(define (Rectangle:move dx dy)
(inc (self 1) dx)
(inc (self 2) dy))

; end of file

Segue la classe Circle:

; file Circle.lsp - class methods for circles

(context Circle)

(define (Circle:area)
    (mul (pow (self 3) 2) (acos 0) 2))

(define (Circle:move dx dy)
    (inc (self 1) dx)
    (inc (self 2) dy))

; end of file

Tutti gli insiemi delle funzioni di ogni classe sono ora separati lessicamente l'uno dall'altro.


-------------------
XML e S-espressioni
-------------------

newLISP ha alcune funzioni che permettono di lavorare con i file XML. Vediamo la definizione di queste funzioni dal manuale ("xml-parse", "xml-type-tags" e "xml-error"):

***********************
>>>funzione XML-PARSE
***********************
sintassi: (xml-parse string-xml [int-options [sym-context [func-callback]]])

Analizza una stringa contenente XML ben formato, conforme a XML 1.0. xml-parse non esegue la convalida DTD. Viene saltata DTD (Document Type Declarations) e le relative istruzioni di elaborazione. Vengono analizzati i nodi di tipo ELEMENT, TEXT, CDATA e COMMENT e viene restituita una struttura lista newLISP. Quando un nodo elemento non ha attributi o nodi figlio, contiene invece una lista vuota. Gli attributi vengono restituiti come liste di associazioni, a cui è possibile accedere utilizzando "assoc". Quando xml-parse fallisce a causa di XML non valido, viene restituito nil e si può usare "xml-error" per accedere alle informazioni di errore.

(set 'xml 
  "<person name='John Doe' tel='555-1212'>nice guy</person>")

(xml-parse xml) 
;-> (("ELEMENT" "person" 
;->   (("name" "John Doe") 
;->    ("tel" "555-1212"))
;->   (("TEXT" "nice guy"))))

Modifica del processo di traduzione
-----------------------------------
Facoltativamente, è possibile specificare il parametro int-options per eliminare spazi bianchi, liste di attributi vuote e commenti. Può anche essere usato per trasformare i tag da stringhe in simboli. Un'altra funzione, xml-type-tags, serve per tradurre i tag XML. È possibile utilizzare le varie opzioni tramite i seguenti numeri:

opzione   descrizione
   1      suppress whitespace text tags
   2      suppress empty attribute lists
   4      suppress comment tags
   8      translate string tags into symbols
  16      add SXML (S-expression XML) attribute tags (@ ...)

Le opzioni possono essere combinate aggiungendo i numeri (ad esempio, 3 combina le opzioni per sopprimere gli spazi bianchi dei tag/informazioni di testo e le liste che hanno attributi vuoti).

I seguenti esempi mostrano come utilizzare le diverse opzioni:

XML source:
<?xml version="1.0" ?>
<DATABASE name="example.xml">
<!--This is a database of fruits-->
    <FRUIT>
        <NAME>apple</NAME>
        <COLOR>red</COLOR>
        <PRICE>0.80</PRICE>
    </FRUIT>

    <FRUIT>
        <NAME>orange</NAME>
        <COLOR>orange</COLOR>
        <PRICE>1.00</PRICE>
    </FRUIT>

    <FRUIT>
       <NAME>banana</NAME>
       <COLOR>yellow</COLOR>
       <PRICE>0.60</PRICE>
    </FRUIT>
</DATABASE>

Parsing senza alcuna opzione:

(xml-parse (read-file "example.xml"))
;-> (("ELEMENT" "DATABASE" (("name" "example.xml")) (("TEXT" "\r\n\t") 
;->   ("COMMENT" "This is a database of fruits") 
;->   ("TEXT" "\r\n\t") 
;->   ("ELEMENT" "FRUIT" () (("TEXT" "\r\n\t\t") ("ELEMENT" "NAME" () 
;->      (("TEXT" "apple"))) 
;->     ("TEXT" "\r\n\t\t") 
;->     ("ELEMENT" "COLOR" () (("TEXT" "red"))) 
;->     ("TEXT" "\r\n\t\t") 
;->     ("ELEMENT" "PRICE" () (("TEXT" "0.80"))) 
;->     ("TEXT" "\r\n\t"))) 
;->   ("TEXT" "\r\n\r\n\t") 
;->   ("ELEMENT" "FRUIT" () (("TEXT" "\r\n\t\t") ("ELEMENT" "NAME" () 
;->      (("TEXT" "orange"))) 
;->     ("TEXT" "\r\n\t\t") 
;->     ("ELEMENT" "COLOR" () (("TEXT" "orange"))) 
;->     ("TEXT" "\r\n\t\t") 
;->     ("ELEMENT" "PRICE" () (("TEXT" "1.00"))) 
;->     ("TEXT" "\r\n\t"))) 
;->   ("TEXT" "\r\n\r\n\t") 
;->   ("ELEMENT" "FRUIT" () (("TEXT" "\r\n\t\t") ("ELEMENT" "NAME" () 
;->      (("TEXT" "banana"))) 
;->     ("TEXT" "\r\n\t\t") 
;->     ("ELEMENT" "COLOR" () (("TEXT" "yellow"))) 
;->     ("TEXT" "\r\n\t\t") 
;->     ("ELEMENT" "PRICE" () (("TEXT" "0.60"))) 
;->     ("TEXT" "\r\n\t"))) 
;->   ("TEXT" "\r\n"))))

The TEXT elements containing only whitespace make the output very confusing. As the database in example.xml only contains data, we can suppress whitespace, empty attribute lists and comments with option (+ 1 2 4):

Filtrare gli spazi vuoti in TEXT, i COMMENT tag, e le liste con attributi vuoti:

(xml-parse (read-file "example.xml") (+ 1 2 4))
;-> (("ELEMENT" "DATABASE" (("name" "example.xml")) ( 
;->    ("ELEMENT" "FRUIT" (
;->      ("ELEMENT" "NAME" (("TEXT" "apple"))) 
;->      ("ELEMENT" "COLOR" (("TEXT" "red"))) 
;->      ("ELEMENT" "PRICE" (("TEXT" "0.80"))))) 
;->    ("ELEMENT" "FRUIT" (
;->      ("ELEMENT" "NAME" (("TEXT" "orange"))) 
;->      ("ELEMENT" "COLOR" (("TEXT" "orange"))) 
;->      ("ELEMENT" "PRICE" (("TEXT" "1.00"))))) 
;->    ("ELEMENT" "FRUIT" (
;->      ("ELEMENT" "NAME" (("TEXT" "banana"))) 
;->      ("ELEMENT" "COLOR" (("TEXT" "yellow"))) 
;->      ("ELEMENT" "PRICE" (("TEXT" "0.60"))))))))

L'output risultante sembra molto più leggibile, ma può ancora essere migliorato utilizzando simboli anziché stringhe per i tag "FRUIT", "NAME", "COLOR" e "PRICE", nonché eliminando i tag di tipo XML "ELEMENT" e "TEXT" completamente utilizzando la funzione "xml-type-tags".

Soppressione dei tag XML con "xml-type-tags" e traduzione dei tag di stringhe in tag di simboli:

;; suppress all XML type tags for TEXT and ELEMENT
;; instead of "CDATA", use cdata and instead of "COMMENT", use !--

(xml-type-tags nil 'cdata '!-- nil) 

;; turn on all options for suppressing whitespace and empty
;; attributes, translate tags to symbols

(xml-parse (read-file "example.xml") (+ 1 2 8))
→ ((DATABASE (("name" "example.xml")) 
     (!-- "This is a database of fruits") 
     (FRUIT (NAME "apple") (COLOR "red") (PRICE "0.80")) 
     (FRUIT (NAME "orange") (COLOR "orange") (PRICE "1.00")) 
     (FRUIT (NAME "banana") (COLOR "yellow") (PRICE "0.60"))))

Quando i tag vengono tradotti in simboli utilizzando l'opzione 8, è possibile specificare un contesto in sym-context. Se non viene specificato alcun contesto, tutti i simboli verranno creati all'interno del contesto corrente.

(xml-type-tags nil nil nil nil)
(xml-parse "<msg>Hello World</msg>" (+ 1 2 4 8 16) 'CTX)
;-> ((CTX:msg "Hello World"))

Se si specifica nil per i tag XLM di tipo TEXT ed ELEMENT, questi scompaiono. Allo stesso tempo, le parentesi delle liste di nodi figli rimosse in modo che i nodi figlio vengano ora visualizzati come membri della lista, a partire dal simbolo tag tradotto dai tag stringa "FRUIT", "NAME", eccetera.

Parsing in formato SXML (S-espressioni XML):

Utilizzando xml-type-tags per sopprimere tutti i tag di tipo XML, insieme ai numeri di opzione 1, 2, 4, 8 e 16, è possibile generare output in formato SXML:

(xml-type-tags nil nil nil nil)
(xml-parse (read-file "example.xml") (+ 1 2 4 8 16))
;-> ((DATABASE (@ (name "example.xml")) 
;->   (FRUIT (NAME "apple") (COLOR "red") (PRICE "0.80")) 
;->   (FRUIT (NAME "orange") (COLOR "orange") (PRICE "1.00")) 
;->   (FRUIT (NAME "banana") (COLOR "yellow") (PRICE "0.6

Se i tag XML originali contengono uno spazio di nomi (namespace) separato da un ":", i due 
punti verranno tradotti in un "." (dot) nel simbolo newLISP risultante.

Si noti che l'utilizzo dell'opzione numero 16 comporta l'aggiunta di un simbolo "@" (simbolo "at") alla lista degli attributi.

Vedi anche la funzione "xml-type-tags" per ulteriori informazioni sul parsing XML.

Parsing in un contesto specifico:

Durante i parsing delle espressioni XML, i tag XML vengono tradotti in simboli newLISP, quando viene specificata l'opzione 8. L'opzione "sym-context" specifica il contesto di destinazione per la creazione del simbolo:

(xml-type-tags nil nil nil nil)
(xml-parse (read-file "example.xml") (+ 1 2 4 8 16) 'CTX)
;-> ((CTX:DATABASE (@ (CTX:name "example.xml")) 
;->    (CTX:FRUIT (CTX:NAME "apple") (CTX:COLOR "red") (CTX:PRICE "0.80")) 
;->    (CTX:FRUIT (CTX:NAME "orange") (CTX:COLOR "orange") (CTX:PRICE "1.00")) 
;->    (CTX:FRUIT (CTX:NAME "banana") (CTX:COLOR "yellow") (CTX:PRICE "0.60"))))

Se il contesto non esiste, verrà creato. Se esiste, il carattere quiote "'" può essere omesso o il contesto può essere indicato da una variabile.

Utilizzare una funzione call back
---------------------------------
Normalmente, xml-parse non ritorna fino al termine del parsing. Usando l'opzione func-callback, xml-parse ritornerà, dopo ogni tag che si chiude, con la S-espressione generata e una posizione iniziale e lunghezza nell'XML sorgente:

;; demo callback feature
(define (xml-callback s-expr start size)
    (if (or (= (s-expr 0) 'NAME) (= (s-expr 0) 'COLOR) (= (s-expr 0) 'PRICE))
        (begin
            (print "parsed expression:" s-expr)
            (println ", source:" (start size example-xml))
        )
    )
)

(xml-type-tags nil 'cdata '!-- nil)
(xml-parse  (read-file "example.xml") (+ 1 2 8) MAIN xml-callback)

Il seguente output verrà generato dalla funzione call back "xml-callback":

parsed expression:(NAME "apple"), source:<NAME>apple</NAME>
parsed expression:(COLOR "red"), source:<COLOR>red</COLOR>
parsed expression:(PRICE "0.80"), source:<PRICE>0.80</PRICE>
parsed expression:(NAME "orange"), source:<NAME>orange</NAME>
parsed expression:(COLOR "orange"), source:<COLOR>orange</COLOR>
parsed expression:(PRICE "1.00"), source:<PRICE>1.00</PRICE>
parsed expression:(NAME "banana"), source:<NAME>banana</NAME>
parsed expression:(COLOR "yellow"), source:<COLOR>yellow</COLOR>
parsed expression:(PRICE "0.60"), source:<PRICE>0.60</PRICE>

La funzione di callback dell'esempio filtra i tag di interesse e li elabora man mano che si verificano.

**************************
>>>funzione XML-TYPE-TAGS
**************************
sintassi: (xml-type-tags [exp-text-tag exp-cdata-tag exp-comment-tag exp-element-tags])

Può sopprimere completamente o sostituire i tag di tipo XML "TEXT", "CDATA", "COMMENT" e "ELEMENT" con qualcos'altro specificato nei parametri.

Si noti che xml-type-tag eliminano o traducono solo i tag stessi, ma non sopprimono o modificano le informazioni taggate. Quest'ultimo viene fatto usando i numeri delle opzioni in xml-parse.

L'uso di xml-type-tags senza argomenti restituisce i tag di tipo correnti:

(xml-type-tags)
;-> ("TEXT" "CDATA" "COMMENT" "ELEMENT")

(xml-type-tags nil 'cdata '!-- nil)

Il primo esempio mostra solo i tag di tipo attualmente utilizzati. Il secondo esempio specifica la soppressione dei tag "TEXT" ed "ELEMENT" e mostra "cdata" e "!--" invece di CDATA e COMMENT.

**************************
>>>funzione XML-ERROR
**************************
sintassi: (xml-error)

Restituisce una lista di informazioni sull'errore dall'ultima operazione di "xml-parse". In caso contrario, restituisce nil se non si è verificato alcun errore. Il primo elemento contiene il testo che descrive l'errore e il secondo elemento è un numero che indica l'ultima posizione di scansione nel sorgente XML di origine, a partire da 0 (zero).

(xml-parse "<atag>hello</atag><fin")
;-> nil

(xml-error)
;-> ("expected closing tag: >" 18)

Convertire le S-espressioni in XML
----------------------------------

Come abbiamo visto, newLISP ha il supporto integrato per convertire un file in S-espressioni usando "xml-parse", ma non possiede la funzione inversa, cioè la possibilità di convertire una S-espressione in XML.
La seguente funzione può essere utilizzata per tradurre una S-espressione in XML:

;; translate s-expr to XML
;;
(define (expr2xml expr (level 0))
 (cond
   ((or (atom? expr) (quote? expr))
       (print (dup "  " level))
       (println expr))
   ((list? (first expr))
       (expr2xml (first expr) (+ level 1))
       (dolist (s (rest expr)) (expr2xml s (+ level 1))))
   ((symbol? (first expr))
       (print (dup "  " level))
       (println "<" (first expr) ">")
       (dolist (s (rest expr)) (expr2xml s (+ level 1)))
       (print (dup "  " level))
       (println "</" (first expr) ">"))
   (true
      (print (dup "  " level)
      (println "<error>" (string expr) "<error>")))
 ))

;; a lisp expression for a person

(set 'expr '(person
              (name "John Doe")
              (address (street "Main Street") (city "Anytown"))))

;; translate to XML with default indentation 0

(expr2xml expr)   =>

<person>
   <name>
     John Doe
   </name>
   <address>
       <street>
         Main Street
       </street>
       <city>
         Anytown
       </city>
   </address>
</person>

Il secondo parametro 0 è il livello di indentazione per l'espressione di tag più esterna.


----------------------------------------------
Analisi dei tempi di esecuzione delle funzioni
----------------------------------------------

Per analizzare i tempi di esecuzione delle funzioni newLISP mette a disposizione la funzione "time".

*****************
>>>funzione TIME
*****************
sintassi: (time exp [int-count)
Valuta l'espressione in exp e restituisce il tempo impiegato per la valutazione in millisecondi a virgola mobile. A seconda della piattaforma, vengono visualizzati o meno i decimali dei millisecondi.

(time (myprog x y z)) → 450.340
(time (myprog x y z) 10) → 4420.021

Nel primo esempio, sono trascorsi 450 millisecondi durante la valutazione (myprog x y z).
Il secondo esempio restituisce il tempo per dieci valutazioni di (myprog x y z).

Per vedere come utilizzare questa funzione ci serviamo del seguente problema:

Data un lista di n numeri, calcolare la somma massima di una sua sottolista, cioè, la somma più grande possibile di una sequenza di valori consecutivi nella lista. Da notare che possono esserci valori negativi nella lista. Per esempio, la lista (-2 2 4 -3 5 2 -6 2) ha la seguente sottolista con somma massima: (2 4 -3 5 2), la cui somma vale 10.

Possiamo risolvere il problema in tre modi diversi, ognuno con una complessità temporale differente.

Algoritmo A  -->  O(n^3)
------------------------
Il modo più semplice per risolvere il problema è passare attraverso tutte le possibili sottoliste, calcolare la somma dei valori di ogni sottolista e mantenere il valore della somma massima.

(define (A lst)
  (let ((out 0) (somma 0) (fine (- (length lst) 1)))
    (for (i 0 fine)
      (for (j i fine)
        (setq somma 0)
        (for (k i j)
          (setq somma (+ somma (lst k)))
        )
        (setq out (max out somma))
      )
    )
    out))

(setq lst '(-2 2 4 -3 5 2 -6 2))
(A lst)
;-> 10

La complessità temporale dell'algoritmo è O(n^3), perché è costituito da tre cicli annidati che attraversano la lista.

Algoritmo B  -->  O(n^2)
------------------------
Possiamo rendere l'algoritmo A più efficiente rimuovendo un ciclo. Ciò è possibile calcolando la somma nello stesso momento in cui l'indice destro della sottolista si muove.

(define (B lst)
  (let ((out 0) (somma 0) (fine (- (length lst) 1)))
    (for (i 0 fine)
      (setq somma 0)
      (for (j i fine)
        (setq somma (+ somma (lst j)))
        (setq out (max out somma))
      )
    )
    out))

(setq lst '(-2 2 4 -3 5 2 -6 2))
(B lst)
;-> 10

La complessità temporale dell'algoritmo è O(n^2), perché è costituito da due cicli annidati che attraversano la lista.

Algoritmo C  -->  O(n)
----------------------
Possiamo risolvere il problema in tempo O(n), cioè con un solo ciclo. L'idea è di calcolare per ciascuna posizione della lista la somma massima della sottolista che termina in quella posizione. A questo punto la risposta al problema è il massimo di quelle somme.
Vediamo come trovare la sottolista della somma massima che termina con la posizione k.
Ci sono due possibilità:
1. La sottolista contiene solo l'elemento nella posizione k.
2. La sottolista è costituita da una sottolista che termina in posizione k - 1, seguita dall'elemento in posizione k.
In quest'ultimo caso, poiché vogliamo trovare un sottolista con somma massima, la sottolista che termina alla posizione k - 1 dovrebbe anche avere la somma massima. Quindi, possiamo risolvere il problema in modo efficiente calcolando la somma massima della sottolista per ciascuna posizione finale da sinistra a destra.

(define (C lst)
  (let ((out 0) (somma 0) (fine (- (length lst) 1)))
    (for (i 0 fine)
        (setq somma (max (lst i) (+ somma (lst i))))
        (setq out (max out somma))
    )
    out))

(setq lst '(-2 2 4 -3 5 2 -6 2))
(C lst)
;-> 10

La complessità temporale dell'algoritmo è O(n), perché è costituito solo da un ciclo che attraversa la lista.

Nota: Questo è anche l'algoritmo ottimo perchè dobbiamo attraversare la lista almeno una volta con qualunque algoritmo.

Vediamo di calcolare la velocità delle tre funzioni. Prima prepariamo i dati, altrimenti il tempo di esecuzione calcolato includerebbe anche quello di creazione dei dati stessi.

Nota: per fare dei test di velocità è meglio utilizzare una REPL "nuova", cioè appena lanciata.

(silent
  ;10
  (setq lst01 (randomize (sequence -5 5)))
  ;100
  (setq lst02 (randomize (sequence -50 50)))
  ;1000
  (setq lst03 (randomize (sequence -500 500)))
  ;10000
  (setq lst04 (randomize (sequence -5000 5000)))
  ;100000
  (setq lst05 (randomize (sequence -50000 50000)))
  ;1000000
  (setq lst06 (randomize (sequence -500000 500000)))
)

Adesso possiamo calcolare i tempi di esecuzione delle tre funzioni, stampando anche il risultato della funzione per verificare che siano tutte corrette:

Funzione A
----------
(time (println (A lst01)))
;-> 14 ; risultato
;-> 0  ; tempo di esecuzione (msec)
(time (println (A lst02)))
;-> 466
;-> 16.982
(time (println (A lst03)))
;-> 8132
;-> 83572.628

Non proviamo (time (A lst04)) perchè... ci vuole troppo tempo.

Funzione B
----------
(time (println (B lst01)))
;-> 14
;-> 0
(time (println (B lst02)))
;-> 466
;-> 0.963
(time (println (B lst03)))
;-> 8132
;-> 359.068
(time (println (B lst04)))
;-> 315922
;-> 456891.876

Non proviamo (time (B lst05)) perchè... ci vuole troppo tempo.

Funzione C
----------

(time (println (C lst01)))
;-> 14
;-> 0.984
(time (println (C lst02)))
;-> 466
;-> 0.997
(time (println (C lst03)))
;-> 8132
;-> 2.061
(time (println (C lst04)))
;-> 315922
;-> 456891.442
(time (println (C lst05)))
;-> 9871843
;-> 15751.873

Non proviamo (time (C lst06)) perchè... ci vuole troppo tempo.

Ricapitoliamo i risultati:

|   Numero   | Tempo (msec) | Tempo (msec) | Tempo (msec) |
|  Elementi  | Algoritmo A  | Algoritmo B  | Algoritmo C  |
|   Lista    |   O(n^3)     |   O(n^2)     |   O(n)       |
+------------+--------------+--------------+--------------+
|    10      |         0    |         0    |        1     |
|    10^2    |        16    |         1    |        1     |
|    10^3    |     83572    |       359    |        2     |
|    10^4    |         -    |    456891    |      139     |
|    10^5    |         -    |         -    |    15751     |
|    10^6    |         -    |         -    |        -     |
|    10^7    |         -    |         -    |        -     |
+------------+--------------+--------------+--------------+

La tabella mostra chiaramente che l'algoritmo C è nettamente il migliore.

Comunque, in questo caso, possiamo utilizzare i vettori al posto delle liste con le stesse funzioni. Vediamo quanto migliorano i tempi di esecuzione.

Salviamo le funzioni in un file:

(save "ABC.lsp" 'A 'B 'C)

Partiamo con una REPL nuova e ricarichiamo le funzioni A, B e C:

(load "ABC.lsp")

Creiamo i vettori:

(silent
  ;10
  (setq ar01 (array 11 (randomize (sequence -5 5))))
  ;100
  (setq ar02 (array 101 (randomize (sequence -50 50))))
  ;1000
  (setq ar03 (array 1001 (randomize (sequence -500 500))))
  ;10000
  (setq ar04 (array 10001 (randomize (sequence -5000 5000))))
  ;100000
  (setq ar05 (array 100001 (randomize (sequence -50000 50000))))
  ;1000000
  (setq ar06 (array 1000001 (randomize (sequence -500000 500000))))
  ;10000000
  (setq ar07 (array 10000001 (randomize (sequence -5000000 5000000))))
)

Calcoliamo i tempi di esecuzione:

Funzione A
----------
(time (println (A ar01)))
;-> 14 ; risultato
;-> 0  ; tempo di esecuzione (msec)
(time (println (A ar02)))
;-> 466
;-> 10.952
(time (println (A ar03)))
;-> 8132
;-> 8519.551
(time (println (A ar04)))

Non proviamo (time (A ar04)) perchè anche in questo caso... ci vuole troppo tempo.

Funzione B
----------
(time (println (B ar01)))
;-> 14
;-> 0
(time (println (B ar02)))
;-> 466
;-> 1.066
(time (println (B ar03)))
;-> 8132
;-> 44.144
(time (println (B ar04)))
;-> 315922
;-> 4083.084
(time (println (B ar05)))
;-> 9871843
;-> 578540.698

Non proviamo (time (B ar06)) perchè... ci vuole troppo tempo.

Funzione C
----------

(time (println (C ar01)))
;-> 14
;-> 1.193
(time (println (C ar02)))
;-> 466
;-> 0.992
(time (println (C ar03)))
;-> 8132
;-> 0.985
(time (println (C ar04)))
;-> 315922
;-> 5.2
(time (println (C ar05)))
;-> 9871843
;-> 14.192
(time (println (C ar06)))
;-> 289944784
;-> 248.444
(time (println (C ar07)))
;-> 10435936563
;-> 3083.781

Ricapitoliamo i risultati :

|   Numero   | Tempo (msec) | Tempo (msec) | Tempo (msec) |
|  Elementi  | Algoritmo A  | Algoritmo B  | Algoritmo C  |
|   Lista    |   O(n^3)     |   O(n^2)     |   O(n)       |
+------------+--------------+--------------+--------------+
|    10      |         0    |         0    |        1     |
|    10^2    |        10    |         1    |        1     |
|    10^3    |      8519    |        44    |        1     |
|    10^4    |         -    |      4083    |        5     |
|    10^5    |         -    |   9871843    |       14     |
|    10^6    |         -    |         -    |      248     |
|    10^7    |         -    |         -    |     3083     |
+------------+--------------+--------------+--------------+

I vettori sono molto più veloci delle liste (perchè l'accesso indicizzato delle liste è molto lento rispetto a quello dei vettori).

Per vedere la differenza di velocità tra le funzioni possiamo anche eseguirle un certo numero di volte con lo stesso input. Ad esempio:

(time (A ar02) 100)
;-> 937.535
(time (B ar02) 100)
;-> 46.79
(time (C ar02) 100)
;-> 0


