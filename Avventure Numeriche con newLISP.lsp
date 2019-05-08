+=================================+
| AVVENTURE NUMERICHE con newLISP |
| by cameyo 2019                  |
+=================================+

========
 INDICE
========

INTRODUZIONE
INSTALLAZIONE
ESEGUIRE newLISP
LE FUNZIONI UTENTE
ARGOMENTI DI UNA FUNZIONE
TRASFORMARE UNA FUNZIONE DISTRUTTIVA IN NON-DISTRUTTIVA
TRASFORMARE UNA FUNZIONE DA DUE A N ARGOMENTI
FUNZIONI CON MEMORIA
GENERARE FUNZIONI DA FUNZIONI
ASSEGNAZIONE GLOBALE: SET, SETQ e SETF (e DEFINE)
ASSEGNAZIONE LOCALE: LET, LETN e LOCAL
EFFETTI COLLATERALI (side effect) DI SETQ e LET
NIL, TRUE e LISTA VUOTA '()
TIPI DI NUMERI
PUNTO DECIMALE O VIRGOLA DECIMALE
FORMATTAZIONE DELL'OUTPUT
OPERAZIONI ARITMETICHE ELEMENTARI
USO DEI NUMERI BIG INTEGER
INTROSPEZIONE
CONVERSIONI DI TIPO: IMPLICITE ED ESPLICITE
QUANTO SONO PRECISI I NUMERI FLOATING POINT?
QUANTO SONO STRANI I NUMERI FLOATING-POINT?
TIPI DI ERRORE
PROPAGAZIONE DEGLI ERRORI
RAPPRESENTAZIONE DEI NUMERI FLOATING POINT (32-bit)
MACHINE EPSILON
INFINITO E NOT A NUMBER
CONFRONTO TRA NUMERI FLOATING-POINT
VERIFICA DELLE OPERAZIONI FLOATING-POINT
UNA STRANA SUCCESSIONE
OPERAZIONI SICURE
QUANTO VALE PI GRECO?
QUANTO VALE IL NUMERO DI EULERO?
TEMPO DI ESECUZIONE
LISTA O VETTORE?
VETTORI
INDICIZZAZIONE DI STRINGHE, LISTE E VETTORI
CONTESTI
CAR E CDR IN newLISP

FUNZIONI VARIE
  Cambiare di segno ad un numero
  Moltiplicazione solo con addizioni
  Divisione solo con sottrazioni
  Conversione decimale <--> binario
  Conversione decimale <--> esadecimale
  Calcolo proporzione
  Trasformare una lista di stringhe in lista di simboli
  Estrarre l'elemento n-esimo da una lista
  Verificare se una lista è palindroma
  Zippare due liste
  Enumerare gli elementi di una lista
  Creare una stringa come ripetizione di un carattere/stringa
  Run Length Encode di una lista
  Run Length Decode di una lista
  Massimo Comun Divisore e Minimo Comune Multiplo
  Funzioni booleane
  Conversione gradi decimali <--> gradi sessagesimali
  Conversione RGB <--> HSV
  Calcolo della media di n numeri
  Leggere e stampare un file di testo
  Criptazione e decriptazione di un file
  Funzioni per input utente
  Emettere un beep
  Disabilitare l'output delle espressioni
  Il programma è in esecuzione ? (progress display)
  Ispezionare una cella newLISP

newLISP 99 PROBLEMI (28)
  N-99-01 Estrarre l'ultimo elemento di una lista
  N-99-02 Estrarre il penultimo elemento di una lista
  N-99-03 Estrarre il k-esimo elemento di una lista
  N-99-04 Determinare il numero di elementi di una lista
  N-99-05 Invertire una lista
  N-99-06 Determinare se una lista è palindroma
  N-99-07 Appiattire una lista annidata
  N-99-08 Elimina gli elementi duplicati consecutivi di una lista
  N-99-09 Unire gli elementi duplicati consecutivi di una lista in sottoliste.
  N-99-10 Run-length encode di una lista
  N-99-11 Run-length encode di una lista (modificato)
  N-99-12 Run-length decode di una lista
  N-99-13 Run-length encode di una lista (diretto)
  N-99-14 Duplicare gli elementi di una lista
  N-99-15 Replicare per n volte gli elementi di una lista
  N-99-16 Eliminare l'elemento k-esimo di una lista
  N-99-17 Dividere una lista in due parti (la lunghezza della prima lista è un parametro)
  N-99-18 Estrarre una parte di una lista
  N-99-19 Ruotare una lista di N posti a sinistra
  N-99-20 Eliminare l'elemento k-esimo di una lista
  N-99-21 Inserire un elemento in una data posizione di una lista
  N-99-22 Creare una lista che contiene tutti i numeri interi di un intervallo
  N-99-23 Estrarre un dato numero di elementi da una lista in maniera casuale (random)
  N-99-24 Lotto: estrarre N numeri differenti da un intervallo 1..M
  N-99-25 Generare le permutazioni degli elementi di una lista
  N-99-26 Generare le combinazioni di K oggetti distinti tra gli N elementi di una lista
  N-99-27 Raggruppare gli elementi di un insieme in sottoinsiemi disgiunti
  N-99-28 Ordinare una lista in base alla lunghezza delle sottoliste

ROSETTA CODE
  Numeri Primi
  Numeri di Smith
  Numeri di Hamming
  Numeri di Catalan
  Numeri di Kaprekar
  Numeri Felici
  Numeri Primoriali
  Numeri Perfetti
  Numeri Amicabili
  Numeri Perniciosi
  Numeri di Munchausen
  Sequenza di Collatz
  Permutazioni
  Combinazioni
  Regola di Horner

PROJECT EULERO
  Problema 1
  Problema 2
  Problema 3
  Problema 4
  Problema 5
  Problema 6
  Problema 7
  Problema 8
  Problema 9
  Problema 10
  Problema 14
  Problema 21

PROBLEMI VARI
  Ricerca binaria (Binary search)
  Frazione generatrice
  Il numero aureo
  Equazione di secondo grado
  Equazione di terzo grado
  Numeri Brutti
  Numeri Poligonali
  Torre di Hanoi
  Indovina il numero
  Il problema Monty Hall
  Il problema del compleanno
  Algoritmo di Karatsuba
  Formati A0, A1, A2, A3, A4, ...
  Moltiplicazione del contadino russo
  Distanza di Manhattan
  Modello di crescita di una popolazione di conigli
  Il gioco dei salti

DOMANDE PER ASSUNZIONE DI PROGRAMMATORI (coding interview questions)
  Swap di due variabili (McAfee)
  Funzione "atoi" (McAfee)
  Somma di numeri in una lista (Google)
  Aggiornamento di una lista (Uber)
  Ricerca numero su una lista (Stripe)
  Decodifica di un messaggio (Facebook)
  Implementazione di un job-scheduler (Apple)
  Massimo raccoglitore d'acqua (LeetCode)
  Quantità d'acqua in un bacino (LeetCode)
  Sposta gli zeri (Facebook)
  Intersezione di segmenti (byte-by-byte)
  Trovare l'elemento mancante (LeetCode)
  Verifica lista/sottolista (Visa)
  Controllo ordinamento lista (Visa)
  Caramelle (Visa)

CALCOLI CON I NUMERI COMPLESSI

CALCOLI CON LE FRAZIONI

CALCOLI CON I TEMPI

OPERAZIONI CON GLI INSIEMI

APPENDICI
  Sul linguaggio newLISP - FAQ (Lutz Mueller)
  newLISP in 21 minuti (John W. Small)
  notepad++ plugin
  Debugger
  Compilare i sorgenti di newLISP
  Ricorsione e ottimizzazione della chiamata di coda (Tail Call Optimization)
  newLISP - Lisp per tutti (Krzysztof Kliś)
  Ricorsione avanzata in newLISP (Krzysztof Kliś)
  Differenze tra newLISP, Scheme e Common LISP (Lutz Mueller)
  Chiusure, contesti e funzioni con stato (Lutz Mueller)
  Creazione di funzioni con ambito lessicale in newLISP (Lutz Mueller)
  "The Y of Why" in newLISP (Lutz Mueller)
  Expression evaluation, Implicit Indexing, Contexts and Default Functors (Lutz Mueller)
  Automatic Memory Management in newLISP (Lutz Mueller)
  Frasi Famose sulla Programmazione e sul Linguaggio Lisp

BIBLIOGRAFIA / WEB

============================================================================

==============
 INTRODUZIONE
==============

Questo documento introduce all'uso del linguaggio newLISP per le elaborazioni numeriche (e anche per altre cose). È necessaria una conoscenza di base della programmazione in newLISP. Un ottima scelta per imparare questo linguaggio è il libro "Introduction to newLISP" disponibile come WikiBooks all'indirizzo:  http://en.wikibooks.org/wiki/Introduction_to_newLISP
Comunque per avere una panoramica sul linguaggio potete anche consultare "newLISP in 21 minuti" di John W. Small riportato in appendice.
Maggiori informazioni sono reperibili al sito ufficiale del linguaggio:

http://www.newLISP.org/

Il documento è in continua evoluzione e aggiornamento ed è scritto non da un programmatoree professionista, ma da un principiante che studia ed utilizza newLISP per divertimento.
In genere uso newLISP per risolvere problemi di matematica ricreativa.
Consigli, correzioni e suggerimenti sono i benvenuti.

Per convenzione i comandi di input della REPL non contengono il prompt di newLISP ">".
L'output della REPL viene preceduto dalla stringa ";-> ".

Caratteristiche del sistema utilizzato
--------------------------------------
S.O. Windows 10 Professional 64-bit
Linguaggio: newLISP 10.7.4 UTF-8
Motherboard: ASUS GTX750-PH
CPU: Intel Core i5-4460
RAM: 16Gb DDR3 800mHz
GPU: NVIDIA Geforce GTX 750 SDRAM: 2Gb GDDR5


===============
 INSTALLAZIONE
===============

Scaricate il file di installazione dal sito http://www.newLISP.org/index.cgi?Downloads
Esistono versioni per Windows 32 e 64-bit, Mac OS X, Linux, FreeBSD, ecc.
Per windows 64-bit il file si chiama: newLISP-10701-win64-gs-166.exe
Questo manuale utilizza la versione 10.7.4 UTF-8 di newLISP.
Potete scaricare l'ultima versione del linguaggio dal sito http://www.newLISP.org/downloads/ dove potete trovare anche la versione UTF-8.
Per installare il programma è sufficiente eseguire il programma scaricato.
Terminata l'installazione abbiamo a disposizione due modalità per eseguire newLISP:
1) modalità console (REPL)
2) modalità grafica (GUI)
Utilizzeremo solo la modalità REPL (Read Evaluate Print Loop).
Questo manuale e i sorgenti in esso contenuti si trovano al sito:

https://github.com/cameyo42/numeric-newLISP

Scaricate e copiate i file in una cartella a piacere (es. c:\newLISP\numeric).
Potete leggere il file PDF oppure utilizzare il file di testo. In quest'ultimo caso per seguire gli esempi potete usare l'editor notepad++ con il plugin che si trova al sito:

https://github.com/cameyo42/notepadpp-newLISP

Seguendo le istruzioni riportate in appendice potete leggere il documento e contemporaneamente eseguire il codice che ritenete oppportuno.


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
;-> c:\newLISP\numeric

Se non ci troviamo nella cartella corretta possiamo cambiare cartella con il comando "change-dir":

(change-dir "c://newLISP/numeric")
;-> true

Verifichiamo:

!cd
;-> c:\newLISP\numeric


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
;-> -> argumento 0 vale ok

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
   (println a "" b "" c))

I simboli "a" e "c" assumono i valori 1 e 2 se non si forniscono valori nella chiamata, ma "b" avrà valore nil a meno che non venga fornito un valore per questo.

(test)
;-> 1 nil 2


=========================================================
 TRASFORMARE UNA FUNZIONE DISTRUTTIVA IN NON-DISTRUTTIVA
=========================================================

Una funzione viene detta "distruttiva" quando modifica il proprio argomento.

Most of the primitives in newLISP are nondestructive (no side effects) and leave existing objects untouched, although they may create new ones. There are a few destructive functions, however, that do change the contents of a variable, list, array, or string:
La maggior parte delle funzione primitive in newLISP sono non-distruttive (senza effetti collaterali) e lasciano intatti gli oggetti esistenti, sebbene possano crearne di nuovi. Esistono tuttavia alcune funzioni distruttive che modificano il contenuto di una variabile, una lista, un vettore o una stringa:

Funzione	      Descrizione
--------        -----------
++	            increments numbers in integer mode
--	            decrements numbers in integer mode
bind	          binds variable associations in a list
constant	      sets the contents of a variable and protects it
extend	        extends a list or string
dec	            decrements a number referenced by a variable, list or array
define	        sets the contents of a variable
define-macro	  sets the contents of a variable
inc	            increments a number referenced by a variable, list or array
let           	declares and initializes local variables
letn	          initializes local variables incrementally, like nested lets
letex	          expands local variables into an expression, then evaluates
net-receive	    reads into a buffer variable
pop	            pops an element from a list or string
pop-assoc	      removes an association from an association list
push	          pushes a new element onto a list or string
read	          reads into a buffer variable
receive	        receives a message from a parent or child process
replace	        replaces elements in a list or string
reverse	        reverses a list or string
rotate	        rotates the elements of a list or characters of a string
set	            sets the contents of a variable
setf setq	      sets the contents of a variable, list, array or string
set-ref	        searches for an element in a nested list and replaces it
set-ref-all	    searches for an element in a nested list and replaces all instances
sort	          sorts the elements of a list or array
swap	          swaps two elements inside a list or string

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

funzione APPLY
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

funzione MAP
sintassi: (map exp-functor list-args-1 [list-args-2 ... ])

Applica la funzione "func" (primitiva, funzione utente, espressione lambda) ad ogni gruppo di argomenti specificati dalle liste "list-args-1", "list-args-2", etc.
La funzione "func" viene applicata tante volte quanti sono i gruppi di argomenti:
gli argomenti della prima chiamata sono i primi elementi di ogni lista,
gli argomenti della seconda chiamata sono i secondi elementi di ogni lista,
gli argomenti della n-esima chiamata sono gli n-esimi elementi di ogni lista,
In numero degli argomenti usati viene determinato dalla lunghezza di "list-args1".
Restituisce una lista di risultati.

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

funzione EVAL
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

funzione CURRY
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

curry può essere usato con tutte le funzioni che prendono due argomenti.

Vediamo come usare "curry" insieme alla funzione "map".
Possiamo utilizzare map con una funzione che riceve più di un argomento (ad esempio la funzione "pow") in questo modo:

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

Quando si scrive gen:gen, viene creato un context chiamato gen. gen è uno spazio di nomi (namespace)  lessicale contenente i propri simboli usati come variabili e come funzioni. In questo caso il nome-spazio gen contiene due simboli: "gen" (funzione) e "sum" (variabile).
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

Come prova di concetto, Joel Ericson ha definito due funzioni fattoriali che valutano in modo simile. In una di

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


===================================================
 ASSEGNAZIONE GLOBALE: SET, SETQ e SETF (e DEFINE)
===================================================

funzione SET
sintassi: (set sym-1 exp-1 [sym-2 exp-2 ... ])

Valuta entrambi gli argomenti e poi assegna il risultato di exp al simbolo trovato in sym.
La funzione "set" restituisce il risultato dell'assegnazione.
Il vecchio contenuto del simbolo viene cancellato.
Viene visualizzato un messaggio di errore quando si tenta di modificare il contenuto dei simboli nil, true o un simbolo del contesto.
"set" può effettuare assegnazioni multiple sulle coppie di argomenti.

funzione SETQ e SETF
sintassi: (setq place-1 exp-1 [place-2 exp-2 ... ])
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

funzione DEFINE
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

Abbiamo problemi anche nel caso di variabili globali, per esempio:

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

La variabile "fa" viene ridefinita nella funzione "g" quindi il suo valore non cambia per la funzione "f" (in altre parole esistono due varibili locali "fa", una interna alla funzione "f" e l'altra interna alla funzione "g").
La varibile "fb" non viene ridefinita in "g" quindi il suo valore cambia anche all'interno della funzione "f" (in altre parole esiste una sola variabile "fb" visibile da entrambe le funzioni "f" e "g").


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

Quindi in newLisp tutto viene considerato vero (true) tranne la lista vuota '() e "nil" che vengono considerati falso (nil). Comunque la lista vuota '() e "nil" sono diversi se confrontati tra loro.

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

dove digits sono le cifre decimali, bytes sono a 8 bit e "ceil" è la funzione che arrotonda un numero intero al numero intero successivo più grande.

Attenzione: Numeri grandi che vengono convertiti da numeri floating point sono troncati ai limiti dei numeri integer. Per esempio:

(setq f 2e20)
;-> 2e+020
(int f)
;-> 9223372036854775807

newLISP gestisce anche numeri con altre basi:

123 → 123 intero decimale  (base 10)
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
Precision is optional. When using the precision field on strings, the number of characters displayed is limited to the number in p.

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


============================
 USO DEI NUMERI BIG INTEGER
============================

I numeri interi a 64-bit hanno il seguente intervallo: da -9223372036854775808 a 9223372036854775807.
Se aggiungiamo 1 al più grande numero intero a 64-bit, ritoraniamo al primo numero dell'intervallo:

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

number?	  controlla se una espressione è un integer o un floating point

float?    controlla se una espressione è floating point

integer?	controlla se una espressione è un integer

bigint?	  controlla se una espressione è un big integer

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

Lo standard IEE754 prevede, per i numeri binari in virgola mobile a 32-bits ( quattro
bytes), la seguente rappresentazione:

X       XXXXXXXX    XXXXXXXXXXXXXXXXXXXXXXX
Segno   Esponente   Mantissa
1 bit   8 bit       23 bit

Campo Segno
Il primo campo della rappresentazione IEE754, lungo un bit, rappresenta il segno del
numero binario. Se vale 0 indica che il numero è positivo, se vale 1 indica che il numero
è negativo.
Il numero 1.01101(2b) * (2²)(10b) è positivo per cui questo campo deve valere 0 come
illustrato nella figura seguente:

0 XXXXXXXX XXXXXXXXXXXXXXXXXXXXXXX

Campo Esponente
Il secondo campo, lungo otto bit (un byte), rappresenta l'esponente del numero
binario espresso in notazione scientifica. Come è noto, un byte può assumere valori
che vanno da 0 a 255. Come si fa per rappresentare gli esponenti negativi? Per poter
rappresentare sia gli esponenti positivi che negativi si usa, per questo campo, la
notazione eccesso 127. Quest'ultima prevede che al vero esponente vada sommato 127.
Perciò, per il numero 1.01101(2b) * (2²)(10b) l'esponente da inserire nel secondo campo
della rappresentazione vale: 2 + 127 = 129 ovvero in binario: 1000 0001.

0 1000 0001 XXXXXXXXXXXXXXXXXXXXXXX

Campo Mantissa
Il terzo campo, lungo ventitrè bits, rappresenta la mantissa del numero binario
espresso in notazione scientifica. Nel caso in esame vale 1.01101. A questo punto
occorre notare che tutti i numeri binari espressi in notazione scientifica hanno un “1”
prima della virgola, per cui nella rappresentazione IEE754 questo viene sottointeso.
Inoltre, al valore effettivo della mantissa dell' esempio: 01101, vengono aggiunti tanti
“0” quanti ne servono per completare il campo a 23 bits è perciò si ha:

0110100 00000000 00000000

In definitiva il numero 101.101(b2) = 1.01101(b2) * (2²)(10) viene rappresentato ,in floating
point, nel modo seguente:

0 1000 0001 0110100 00000000 00000000

Riarrangiando i 32-bits della rappresentazione come quattro byte si ha:

0100 0000 1011 0100 0000 0000 0000 0000(b2)

che in esadecimale equivale a:

40 B4 00 00

Nota: La codifica IEEE754 è complicata dalla necessità di rappresentare alcuni valori particolari:
1) NaN (Not a Number, risultato di operazioni non ammesse, es. 0/0)
2) +∞ e -∞ (es. 3/0 = infinito )
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

Il numero binario successivo è rapprsentato da:

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

Lo standard IEEE 754 per i numeri floating-point definisce, oltre i numeri ordinari, anche due numeri particolri: INF e NaN.
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

La matematica a virgola mobile non è esatta. Valori semplici come 0.1 non possono essere rappresentati con precisione usando numeri floating-point binari, e la precisione limitata di questa rappresentazione  significa che lievi cambiamenti nell'ordine delle operazioni o la precisione dei valori intermedi possono cambiare il risultato. Ciò significa che confrontare due numeri floating-point per vedere se sono uguali di solito non sempre genera un risultato corretto.

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
Double.MIN_VALUE  = 2^-1074 =
= 4.940656458412465441765687928682213723650598026143247... × 10^-324
Double.MAX_VALUE  = (2 - 2^-52)·2^1023 =
= 1.7976931348623157081452742373170435679807056752584499... × 10^308
Float.MIN_NORMAL = 2^-126 =
= 1.1754943508222875079687365372222456778186655567720875... × 10^-38
Float.MIN_VALUE  = 2^-149 =
= 1.4012984643248170709237295832899161312802619418765157... × 10^-45
Float.MAX_VALUE  = (2 - 2^-23) * 2^127 =
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
Comunque possiamo trovarlo utilizzando la funzione exponenziale:

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

funzione ARRAY
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


================
 FUNZIONI VARIE
================

In questo paragrafo definiremo alcune funzioni che operano sulle liste e altre funzioni di carattere generale. Alcune di queste ci serviranno successivamente per risolvere i problemi che andremo ad affrontare.
Poichè newLISP permette sia lo stile funzionale che quello imperativo, le funzioni sono implementate in modo personale e possono essere sicuramente migliorate.

Cambiare di segno ad un numero
------------------------------

Primo metodo (sottrazione)
(setq n -1.24)
;-> -1.24
(setq n (sub 0 n))
;-> 1.24
(setq n (sub 0 n))
;-> -1.24

Secondo metodo (moltiplicazione)
(setq n -1.24)
;-> -1.24
(setq n (mul -1 n))
;-> 12.4
(setq n (mul -1 n))
;-> -1.24

Vediamo quale metodo è più veloce:

(map (lambda (x) (sub 0 x))  (sequence 1 10))
;-> (-1 -2 -3 -4 -5 -6 -7 -8 -9 -10)

(map (lambda (x) (mul -1 x)) (sequence 1 10))
;-> (map (lambda (x) (mul -1 x)) (sequence 1 10))

Test primo metodo:
(time (map (lambda (x) (sub 0 x))  (sequence 1 1000000)) 10)
;-> 906.196

Test secondo metodo:
(time (map (lambda (x) (mul -1 x)) (sequence 1 1000000)) 10)
;-> 906.343

I due metodi hanno la stessa velocità.


Moltiplicazione solo con addizioni
----------------------------------

Moltiplicare due numeri naturali (interi positivi)

(define (moltiplica n m)
  (local (p)
    (setq p 0)
    (while (> n 0)
      (setq p (+ p m))
      (-- n)
    )
    p
  )
)

(moltiplica 1 12)
;-> 12

(moltiplica 20 30)
;-> 600


Divisione solo con sottrazioni
------------------------------

Dividere due numeri naturali (interi positivi)

(define (dividi n m)
  (local (q r)
    (setq r n)
    (setq q 0)
    (while (>= r m)
      (++ q)
      (setq r (- r m))
    )
    (list q r)
  )
)

(dividi 10 3)
;-> (3 1)

(dividi 121 11)
;-> (11 0)


Conversione decimale <--> binario
---------------------------------

Questa funzione converte un numero decimale in un numero binario (lista):

(define (decimale2binario n)
  (reverse (d2b n)))

(define (d2b n)
  (if (zero? n) '()
      (cons (% n 2) (d2b (/ n 2)))
  )
)

(decimale2binario 1133)
;-> (1 0 0 0 1 1 0 1 1 0 1)

(decimale2binario 1233)
;-> (1 0 0 1 1 0 1 0 0 0 1)

(decimale2binario 2)
;-> (1 0)

(decimale2binario 0)
;-> ()

Questa funzione converte un numero binario (lista) in un numero decimale:

(define (binario2decimale n)
  (b2d (reverse n)))

(define (b2d n)
    (if (null? n) 0
        (+ (first n) (* 2 (b2d (rest n))))
    )
)

(binario2decimale '(1 0 0 0 1 0 1 1 0 0 1))
;-> 1133

(binario2decimale '(1 0 0 1 1 0 1 0 0 0 1))
;-> 1233

(binario2decimale '(0))
;-> 0

Queste funzione converte un numero binario in un numero intero:

(define (bin2dec n)
  (if (zero? n) n
      (+ (% n 10) (* 2 (bin2dec (/ n 10))))))

(bin2dec 10001011001)
;-> 1113

(bin2dec 10011010001)
;-> 1233

(bin2dec 0)
;-> 0

Queste funzione converte un numero intero in un numero binario:

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))
   )
)

(dec2bin 1133)
;-> 10001101101

(dec2bin 1233)
;-> 10011010001

(dec2bin 0)
;-> 0

(bin2dec (dec2bin 1133))
;-> 1133

(dec2bin (bin2dec 10011010001))
;-> 10011010001

Possiamo scrivere una funzione generale che converte un numero da una base (b1) ad un'altra base (b2):

(define (b1-b2 n b1 b2)
  (if (zero? n) n
      (+ (% n b2) (* b1 (b1-b2 (/ n b2) b1 b2)))))

(b1-b2 1133 10 2)
;-> 10001101101

(b1-b2 10001101101 2 10)
;-> 1133

Anche le funzioni predefinite "int" e "bits" di newLISP servono per convertire numeri da una base all'altra.

Vediamo alcuni esempi:

Converte una stringa esadecimale in decimale (il parametro 0 è il valore predefinito che viene restituito quando la conversione genera un errore):

(int "0xdecaff" 0 16)
;-> 14600959

Converte una stringa binaria nel numero decimale corrispondente:

(int "10101010" 0 2)
;-> 170

Converte un numero in una stringa o in una lista (1 -> true, 0 -> nil) che contiene il numero binario corrispondente:

(bits 170)
;-> "10101010"

(bits 170 true)
;-> (nil true nil true nil true nil true)

(int (bits 1234) 0 2)
;-> 1234


Conversione decimale <--> esadecimale
-------------------------------------

Questa funzione converte un numero intero positivo in una stringa esadecimale:

(define (d2h n)
  (setq digit "0123456789ABCDEF")
  (setq x (% n 16))
  (setq y (/ n 16))
  (if (= y 0) (nth x digit)
      (cons (nth x digit) (d2h y))
  )
)

(define (dec2hex n)
  (if (= n 0) "0"
      (join (reverse(d2h n)))
  )
)

(dec2hex 16)
;-> "10"
(dec2hex 0)
;-> "0"
(dec2hex 100001)
;-> "186A1"

Questa funzione converte una stringa esadecimale in un numero intero positivo:

(define (hex2dec s)
  (local (digit val)
    (setq digit "0123456789ABCDEF")
    (setq val 0L)
    (dostring (c s)
      (setq val (+ (* val 16) (find (char c) digit)))
      ; la seguente istruzione converte la variabile val in un numero intero,
      ; quindi genera un risultato sbagliato quando superiamo il limite.
      ; Ponendo val prima del numero 16 forza newlisp a considerare big integer
      ; il risultato dell'operazione di moltiplicazione.
      ;(setq val (+ (* 16 val) (find (char c) digit)))
    )
  )
)

(hex2dec "0")
;-> 0L

(hex2dec "FF")
;-> 255L

(hex2dec "0123456789ABCDEF")
;-> 81985529216486895L


(hex2dec "FFFFFFFFFFFFFFFFFFFF")
;-> 1208925819614629174706175L

Nota:
Se il numero esadecimale non è intero per trasformarlo in numero decimale bisogna:
- convertire la parte intera scrivendo la somma dei prodotti delle cifre del numero, per le potenze decrescenti del 16.
- convertire la parte frazionaria scrivendo la somma dei prodotti delle cifre del numero, per le potenze crescenti negative del 16.


Calcolo proporzione
-------------------

Calcolare il valore ignoto (che viene rappresentato con il numero zero) di una proporzione: A/B = C/D

(define (proporzione a b c d)
  (cond ((= a 0) (div (mul b c) d))
        ((= b 0) (div (mul a d) c))
        ((= c 0) (div (mul a d) b))
        ((= d 0) (div (mul b c) a))
  )
)

(proporzione 4 2 10 0)
;-> 5
(proporzione 0 2 10 5)
;-> 4
(proporzione 4 2 0 5)
;-> 10
(proporzione 4 0 10 5)
;-> 2


Trasformare una lista di stringhe in lista di simboli
-----------------------------------------------------

(setq str "Questa è la stringa da convertire")
;-> "Questa è la stringa da convertire"

(setq lst (parse str))
;-> ("Questa" "è" "la" "stringa" "da" "convertire")

(map sym lst)
;-> (Questa è la stringa da convertire)


Estrarre l'elemento n-esimo da una lista
----------------------------------------

; ======================================
; (n-esimo n lst)
; Estrae l'elemento n-esimo da una lista
; ======================================

(define (n-esimo n lst)
  (if (= lst '()) '()
    (if (= n 0)
        (first lst)
        (n-esimo (- n 1) (rest lst))
    )
  )
)

(n-esimo 1 '(1 (2 3) 4))
;-> (2 3)

(n-esimo 0 '(1 (2 3) 4))
;-> 1

(n-esimo 5 '(1 (2 3) 4))
;-> ()


Verificare se una lista è palindroma
------------------------------------

; ======================================
; (palindroma? lst)
; Controlla se la lista lst è palindroma
; ======================================
(define (palindroma? lst)
  (= lst (reverse (copy lst))))

Nota: senza la funzione "copy", la condizione (= lst (reverse lst)) è sempre vera (perchè (reverse lst) è una funzione distruttiva.

(palindroma? '(n e w L I S P))
;-> nil

(palindroma? '(e p r e s a l a s e r p e))
;-> true


Zippare N liste
---------------

La funzione "zip" prende due liste e raggruppa in coppie gli elementi delle due liste che hanno lo stesso indice.
Il risultato è una lista costituita da sottoliste con due welementi ciascuna.La lunghezza della lista è uguale a quella della lista più corta (cioè, la funzione deve fermarsi quando termina una delle due liste).

; zippa due liste
(define (zip l1 l2)
  (if (or (null? l1) (null? l2))
      '()
      (cons (list (first l1) (first l2))
            (zip (rest l1) (rest l2)))))

Se una delle due liste è vuota, allora ritorna la lista vuota. Altrimenti, formiamo una lista dei primi elementi di ciascuna lista e la associamo alla versione zippata delle parti rimanenti di ciascuna lista. Il risultato è la nostra lista formata da sottoliste di due elementi.

(zip '(1 2 3) '(a b c))
;-> ((1 a) (2 b) (3 c))

(zip '(1 2 3) '(a))
;-> ((1 a))

(zip '(1) '(a b c))
;-> ((1 a))

(zip '(1 3 5) '(2 4 6))
;-> ((1 2) (3 4) (5 6))

Possiamo scrivere la funzione "zip" utilizzando "map" e "apply":

; zip due liste
(define (zip l1 l2) (map list l1 l2))

(zip '(1 2 3) '(a b c))
;-> ((1 a) (2 b) (3 c))

(zip '(1 2 3) '(a))
;-> ((1 a) (2) (3))

(zip '(1) '(a b c))
;-> ((1 a))

Questa ultima funzione può essere facilmente estesa per trattare N liste:

; zippa N liste
(define (zip lst)
  (apply map (cons list lst)))

(zip '((1 a x) (2 b y)))
;-> ((1 2) (a b) (x y))

(zip '((1 2) (a b) (x y)))
;-> (1 a x) (2 b y))

Calcoliamo il tempo di esecuzione:

(time (zip '((1 a x) (2 b y))) 100000)
;-> 78.116 msec

La funzione "zip" è uguale alla funzione che traspone una matrice (scambia le righe con le colonne). Poichè newLISP fornisce la funzione "transpose" possiamo scrivere:

(transpose '((1 2 3) (a b c)))
;-> ((1 a) (2 b) (3 c))

Quindi la funzione che zippa N liste diventa:

; =============================================
; (zip lst)
; Zippa (traspone) una lista di liste (matrice)
; =============================================
; zippa N liste
(define (zip lst)
  (transpose lst))

(zip '((1 a x) (2 b y)))
;-> ((1 2) (a b) (x y))

Calcoliamo il tempo di esecuzione e notiamo che è più veloce della funzione iniziale:

(time (zip '((1 a x) (2 b y))) 100000)
;-> 31.87 msec


Enumerare gli elementi di una lista
-----------------------------------

; =====================================================
; (emumera lst)
; Crea una nuova lista numerando gli elementi di lst
; =====================================================
(define (enumera lst)
  (cond ((null? lst) '())
        (true (setq _out '())
              (dolist (el lst)
                ;(push (list $idx el) _out)
                ;(push (list $idx el) _out -1)
                (extend _out (list(list $idx el)))
              )
              ;(reverse _out)
        )
  )
)

(enumera '(a b c))
;-> ((0 a) (1 b) (2 c))

(enumera '((a b) (c d) e))
;-> ((0 (a b)) (1 (c d)) (2 e))

Oppure:

(define (enumera lst)
  (map list (sequence 0 (sub (length lst) 1)) lst))

(enumera '(a b c))
;-> ((0 a) (1 b) (2 c))

(enumera '((a b) (c d) e))
;-> ((0 (a b)) (1 (c d)) (2 e))

Oppure:

(map (fn (x) (list $idx x)) '(a b c))
;-> ((0 a) (1 b) (2 c))


Creare una stringa come ripetizione di un carattere/stringa
-----------------------------------------------------------

newLISP possiede la funzione "dup" che funzione anche con i simboli:

(dup "A" 6)       → "AAAAAA"
(dup "A" 6 true)  → ("A" "A" "A" "A" "A" "A")
(dup "A" 0)       → ""
(dup "AB" 5)      → "ABABABABAB"
(dup 9 7)         → (9 9 9 9 9 9 9)
(dup 9 0)         → ()
(dup 'x 8)        → (x x x x x x x x)
(dup '(1 2) 3)    → ((1 2) (1 2) (1 2))
(dup "\000" 4)    → "\000\000\000\000"
(dup "*")         → "**"

Proviamo a scrivere la nostra funzione:

; =====================================================
; (duplica str num)
; Duplica la stringa str per num volte
; =====================================================

(define (duplica str num , newstr)
   (setq newstr "")
   (dotimes (x num)
    (extend newstr str)
   )
)

(duplica "prova" 4)
;-> "provaprovaprovaprova"


Run Length Encode di una lista
-------------------------------

Esempio: (rle '(a a a b b c c a d d))
;-> ((3 a) (2 b) (2 c) (1 a) (2 d))

Implementiamo il metodo di compressione Run Length Encoding ad una lista. Gli elementi consecutivi duplicati sono codificati come liste (N E) dove N è il numero di duplicati dell'elemento E.

; =====================================================
; (rle-encode lst)
; Codifica una lista con il metodo Run Length Encoding
; =====================================================
(define (rle-encode lst)
  (local (palo conta out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq palo (first lst))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              (if (= el palo) (++ conta)
                  ; altrimenti costruiamo la coppia (conta el) e la aggiungiamo al risultato
                  (begin (extend out (list(list conta palo)))
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           (extend out (list(list conta palo)))
          )
    )
    out
  )
)

(rle-encode '(a a a a b c c a a d e e e e f))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f))


Run Length Decode di una lista
------------------------------

Esempio: (rle-decode '((3 a) (2 b) (2 c) (1 a) (2 d)))
;-> (a a a b b c c a d d))

; =====================================================
; (rle-decode lst)
; Decodifica una lista compressa con il metodo Run Length Encoding
; =====================================================
(define (rle-decode lst)
  (local (out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (dolist (el lst)
              (extend out (dup (last el) (first el)))
           )
          )
    )
    out
  )
)

(rle-decode '((3 a) (2 b) (2 c) (1 a) (2 d)))
;-> (a a a b b c c a d d))

(rle-decode '((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f)))
;-> (a a a a b c c a a d e e e e f)

(rle-decode (rle-encode '(a a a a b c c a a d e e e e f)))
;-> (a a a a b c c a a d e e e e f)


Massimo Comun Divisore e Minimo Comune Multiplo
-----------------------------------------------

In inglese:
GCD -> Greatest Common Divisor
LCM -> Least Common Multiple

; =============================================
; (my-gcd x1 x2 x3 ... xn)
; Calcola il massimo comun divisore di N numeri
; =============================================
(define (gcd_ a b) ; gcd funzione ausiliaria
  (let (r (% b a))
    (if (= r 0) a (gcd_ r a))))

(gcd_ 12 30)
;-> 6

(define-macro (my-gcd)
  ; ritorna il massimo comun divisore di tutti i numeri interi passati
  (apply gcd_ (args) 2))

(my-gcd 12 30 4)
;-> 2

; =============================================
; (my-lcm x1 x2 x3 ... xn)
; Calcola il minimo comune multiplo di N numeri
; =============================================
(define (lcm_ a b)
  ; lcm funzione ausiliaria
  (/ (* a b) (gcd_ a b)))

(lcm_ 12 30)
;-> 60

(define-macro (my-lcm)
  ; ritorna il minimo comune multiplo di tutti i numeri interi passati
  (apply lcm_ (args) 2))

(my-lcm 12 60 130)
;-> 780

Possiamo anche utilizzare una funzione lambda al posto della funzione ausiliaria:

(define-macro (lcm)
  (apply (fn (x y) (/ (* x y) (gcd_ x y))) (args) 2))

(lcm 12 60 130)
;-> 780


Funzioni booleane
-----------------

; =====================================================
; Funzioni booleane e bitwise
; nand, nor, xor xnor
; =====================================================

;; boolean functions
(define (nand a b) (not (and a b)))
(define (nor a b) (not (or a b)))
(define (xor a b) (if (nand a b) (or a b) nil))
(define (xnor a b) (not (xor a b)))

;; bitwise versions:
(define (~& a b) (~ (& a b))) ; nand, bitwise
(define (~| a b) (~ (| a b))) ; nor, bitwise
;; xor is already in the language as ^
(define (~^ a b) (~ (^ a b))) ; xnor, bitwise


Conversione gradi decimali <--> gradi sessagesimali
---------------------------------------------------

; =====================================================
; (dd-to-dms degrees)
; Converte gradi decimali in gradi, minuti, secondi
; =====================================================

(define (dd-to-dms degrees)
  (if (> 0.0 degrees)
      (setq udegree (abs degrees))
      (setq udegree degrees)
  )
  (setq d (int udegree))
  (setq m (int (mul 60.0 (sub udegree d))))
  (setq s (mul 3600.0 (sub udegree d (div m 60.0))))
  (if (> 0.0 degrees) (set 'd (sub d 0)))
  ;(println d { } m { } s { })
  result d m s
)

(dd-to-dms 30.263888889)
;-> 30 15 50.00000040000145

; =====================================================
; (dms-to-decimal degrees minutes seconds)
; Converte gradi, minuti, secondi in gradi decimali
; =====================================================

(define (dms-to-dd degrees minutes seconds)
  (if (< 0.0 degrees)
      (setq dd (add degrees (div minutes 60.0) (div seconds 3600.0)))
      (setq dd (add degrees (- 0.0 (div minutes 60.0)) (- 0.0 (div seconds 3600.0))))
  )
  result dd
)

(dms-to-dd 30.0 15.0 50.0)
;-> 30.26388888888889


Conversione RGB <--> HSV
------------------------

Conversione di un colore dallo spazio RGB (Red, Green, Blu) allo spazio HSV (Hue Saturation Value) e viceversa. Per ulteriori informazioni consultare il sito:

http://www.easyrgb.com/en/math.php

Conversione RGB -> HSV:

(define (rgb2hsv r g b)
  (local (h s v var-r var-g var-b var-min var-max del-max del-r del-g del-b)
    (setq var-r (div r 255))
    (setq var-g (div g 255))
    (setq var-b (div b 255))
    (setq var-min (min var-r var-g var-b)) ; valore minimo di RGB
    (setq var-max (max var-r var-g var-b)) ; valore massimo di RGB
    (setq del-max (sub var-max var-min))   ; delta RGB
    (setq v var-max)
    (cond ((= 0 del-max) (setq h 0) (setq s 0)) ; tono di grigio
           (true ; colore
              (setq s (div del-max var-max))
              (setq del-r (div (add (div (sub var-max var-r) 6) (div del-max 2)) del-max))
              (setq del-g (div (add (div (sub var-max var-g) 6) (div del-max 2)) del-max))
              (setq del-b (div (add (div (sub var-max var-b) 6) (div del-max 2)) del-max))
              (cond ((= var-r var-max) (setq h (sub del-b del-g)))
                    ((= var-g var-max) (setq h (add (div 1 3) (sub del-r del-b))))
                    ((= var-b var-max) (setq h (add (div 2 3) (sub del-g del-r))))
                    (true println "errore")
              )
              (if (< h 0) (setq h (add 1 h)))
              (if (> h 1) (setq h (sub 1 h)))
           );end true
    )
    (list h s v)
  );end local
)

(rgb2hsv 255 255 255)
;-> (0 0 1)

(rgb2hsv 0 0 0)
;-> (0 0 0)

(rgb2hsv 80 80 80)
;-> (0 0 0.3137254901960784)

(rgb2hsv 155 55 20)
;-> (0.04320987654320985 0.8709677419354838 0.6078431372549019)

Conversione HSV -> RGB:

(define (hsv2rgb h s v)
  (local (r g b var-h var-i var-1 var-2 var-3 var-4 var-r var-g var-b)
    (cond ((= 0 s) (setq r (mul v 255)) (setq g (mul v 255)) (setq b (mul v 255)))
          (true
             (setq var-h (mul h 6))
             (if (= var-h 6) (setq var-h 0)) ; h deve essere minore di 1
             (setq var-i (floor var-h))
             (setq var-1 (mul v (sub 1 s)))
             (setq var-2 (mul v (sub 1 (mul s (sub var-h var-i)))))
             (setq var-3 (mul v (sub 1 (mul s (sub 1 (sub var-h var-i))))))
             (cond ((= 0 var-i) (setq var-r v)     (setq var-g var-3) (setq var-b var-1))
                   ((= 1 var-i) (setq var-r var-2) (setq var-g v)     (setq var-b var-1))
                   ((= 2 var-i) (setq var-r var-1) (setq var-g v)     (setq var-b var-3))
                   ((= 3 var-i) (setq var-r var-1) (setq var-g var-2) (setq var-b v))
                   ((= 4 var-i) (setq var-r var-3) (setq var-g var-1) (setq var-b v))
                   (true        (setq var-r v    ) (setq var-g var-1) (setq var-b var-2))
             )
             (setq r (mul var-r 255))
             (setq g (mul var-g 255))
             (setq b (mul var-b 255))
          )
    );end cond
    (list r g b)
  );end local
)

(hsv2rgb 0 0 1)
;-> (255 255 255)

(hsv2rgb 0 0 0)
;-> (0 0 0)

(hsv2rgb 0 0 0.3137254901960784)
;-> (80 80 80)

(hsv2rgb 0.04320987654320985 0.8709677419354838 0.6078431372549019)
;-> (155 54.99999999999998 20.00000000000001)

(hsv2rgb 0.5 0.5 0.5)
;-> (63.75 127.5 127.5)

(rgb2hsv 63.75 127.5 127.5)
;-> (0.4999999999999999 0.5 0.5)


Calcolo della media di n numeri
-------------------------------

; =====================================================
; (media lst) oppure (media x1 x2 ... xn)
; Calcola la media di n numeri
; =====================================================

(define (media)
  (if (or (= (args) '()) (= (args) '(()) )) nil
    (if (= (length (args)) 1)
        (div (apply add (first (args))) (length (first (args))))
        (div (apply add (args)) (length (args)))
    )
  )
)

(media)
;-> nil

(media '())
;-> nil

(media 1 2 3)
;-> 2

(media (sequence 1 9999))
;-> 5000


Leggere e stampare un file di testo
-----------------------------------

;==================================
; (stampa file)
; Legge e stampa un file di testo
; Il parametro "file" è una stringa
;==================================

(define (stampa file)
  (local (afile linea)
    (setq afile (open file "read"))
    (while (read-line afile)
      (setq linea (current-line))
      (println linea)
    )
    (close afile)
  )
)

(stampa "stampa.txt")
;-> riga 1 del file da stampare
;-> riga 2 del file da stampare
;-> fine del file
;-> true


Criptazione e decriptazione di un file
--------------------------------------

La funzione "encrypt" di newLISP funziona in modo biunivoco:
(encrypt (encrypt "testo")) = "testo".
In altre parole una doppia criptazione restituisce il file originale, quindi possiamo scrivere una funzione unica:

;========================================
; Cripta/Decripta un file con buffer read
;========================================
(define (cripta inputfile outputfile key)
  (local (infile outfile crypt)
    (setq infile (open inputfile "read"))
    (setq outfile (open outputfile "write"))
    (while (!= (read infile buffer 256) nil)
        (setq crypt (encrypt buffer key))
        (write outfile crypt 256)
        ;(print (encrypt buffer key))
    )
    (close infile)
    (close outfile)
  )
)

Per criptare un file:
(cripta "testo.txt" "testo.enc" "chiave")

Per decriptare un file:
(cripta "testo.enc" "testo.out" "chiave")


Funzioni per input utente
-------------------------

; =====================================================
; yes-no
; Ask user to input "Y" or "N" (all other keys)
; =====================================================

(define (yes-no message)
  (print message)
  (if (= "Y" (upper-case (read-line)))
    true
    nil
  )
)

(yes-no "Do you want to exit (y/n)? ")

; =====================================================
; input-symbol
; Ask user to input a symbol
; read-line function return a string
; =====================================================

(define (input-symbol message)
  (print message)
  ; a symbol can't begin with number
  (while (number? (int (read-line)))
    (print message)
  )
  (sym (current-line))
)

(input-symbol "Insert a symbol: ")


; =====================================================
; input-string
; Ask user to input a string
; read-line function return a string
; =====================================================

(define (input-string message)
  (print message)
  (while (not (string? (read-line)))
    (print message)
  )
  (current-line)
)

(input-string "Insert a string: ")

; =====================================================
; input-number
; Ask user to input a number (float)
; =====================================================

(define (input-number message)
  (print message)
  (while (not (number? (float (read-line))))
    (print message)
  )
  (float (current-line))
)

(input-number "Insert a number: ")

; =====================================================
; input-integer
; Ask user to input a number
; =====================================================

(define (input-integer message)
  (print message)
  (while (not (integer? (int (read-line))))
    (print message)
  )
  (int (current-line))
)

(input-integer "Insert an integer: ")


Emettere un beep
----------------

newLISP emette un suono/beep quando si stampa il carattere 'bell':

(println (char 7))
;-> "\007"

; =============================================
; (beep)
; Emette un beep
; =============================================
(define (beep)
  (silent (print (char 7))))

La funzione "silent" sopprime l'output sulla console, quindi non compare "\007".

(beep)

Può essere utile per segnalare il termine delle operazioni.


Disabilitare l'output delle espressioni
---------------------------------------

La funzione "silent" è simile a "begin": valuta una sequenza di espressioni sopprimendo l'output e il prompt. Per ritornare al prompt occorre premere "invio" due volte.

(silent (setq a 10) (println a))
;-> 10 ; premere "invio" due volte per ritornare al prompt

Un modo elegante per ritornare al prompt senza intervento dell'utente è il seguente:

; funzione che ritorna al prompt dopo una chiamata a "silence"
(define (resume) (print "\r\n> "))

; funzione generica
(define (myfunction) "valore di ritorno")

; Come utilizzare il metodo:
(silent (myfunction) (print "Fatto") (resume))


Il programma è in esecuzione ? (progress display)
-------------------------------------------------

Qualche volta abbiamo bisogno di sapere se un programma è in esecuzione (e a che punto si trova) oppure si è bloccato in qualche parte del nostro codice. Ci sono due metodi per questo:
il primo metodo stampa ciclicamente una serie di simboli sulla console per dimostrare che il programma sta girando:

(define (controllo)
    (setq i 1)
    (dotimes (x 100000)
      (case i
        (1 (print "wait... |\r"))
        (2 (print "wait... /\r"))
        (3 (print "wait... -\r"))
        (4 (print "wait... \\\r"))
        (true "errore")
      )
      (inc i)
      (if (> i 4) (setq i 1))
    )
    (println "Programma terminato")
)

Il programma stampa ciclicamente un carattere della serie "|", "/". "-", "\\".
Poichè ad ogni print stampiamo anche un "carriage return" (\r) stampiamo sempre sulla stessa linea a partire dalla colonna zero. Questo genera la semplice animazione che vedete quando eseguite la funzione.

(controllo)
;-> wait... (animazione dei caratteri)
;-> Programma terminato
;-> "Programma terminato"

Per migliorare l'output possiamo scrivere:

(define (resume) (print "\r\n> "))

(silent (controllo) (resume))
;-> Programma terminato

Possiamo diminuire il numero dei caratteri nell'animazione scegliendo due caratteri ":" e "-":

(define (controllo)
    (setq i 0)
    (dotimes (x 100000)
      (if (= 0 i) (print "wait... :\r")
                  (print "wait... -\r")
      )
      (inc i)
      (if (> i 1) (setq i 0))
    )
    (println "Programma terminato")
)

(silent (controllo) (resume))
;-> wait... (animazione dei caratteri)
;-> Programma terminato

Il secondo metodo è più informativo, poichè visualizza il valore della iterazione corrente:

(define (controllo)
    (setq iter 10000000)
    (dotimes (x 100000000)
      ; ogni iter iterazioni stampiamo il valore
      (if (= 0 (mod x iter)) (print "Iter: " x "\r"))
    )
    (println "Programma terminato")
)

(silent (controllo) (resume))
;-> Iter: 0 ... ;-> Iter: 900000000
;-> Programma terminato

Da notare che entrambi i metodi rallentano leggermente l'esecuzione del programma.


Ispezionare una cella newLISP
-----------------------------

Per conoscere il contenuto (tipo) di una cella lisp possiamo utilizzare la funzione "dump".

Funzione DUMP
sintassi: (dump [exp])

Mostra i contenuti binari di una nuova cella LISP. Senza argomenti, questa funzione restituisce un elenco di tutte le celle Lisp. Quando viene fornito exp, viene valutato e il contenuto della cella Lisp viene restituito in una lista.

(dump 'a) 
;-> (9586996 5 9578692 9578692 9759280)

(dump 999) 
;-> (9586996 130 9578692 9578692 999)

L'elenco contiene i seguenti indirizzi di memoria e informazioni:

offset  descrizione
0       indirizzo di memoria della cella Lisp
1       cella->tipo: maggiore/minore, vedi newlisp.h per i dettagli
2       cella->successivo: puntatore alla linked list
3       cella->aux:
           lunghezza della stringa + 1 o
           low (little endian) o high (big endian) word di numero intero a 64 bit o
           low word di double float IEEE 754
4       cella->contenuto:
           indirizzo della stringa/simbolo o
           high (little endian) o low (big endian) word di numero intero a 64 bit o
           high di double float IEEE 754

Questa funzione è utile per modificare i bit di tipo nelle celle o per hackerare altre parti dei nuovi interni di LISP.

La seguente funzione estrae il tipo di dato contenuto in una cella newLISP:

(define (type x) (& 15 (nth 1 (dump x))))

(type nil)
;-> 0            ;; nil
(type true)
;-> 1            ;; true
(type 123)
;-> 2            ;; integer
(type 1.23)
;-> 3            ;; float
(type "abcd")
;-> 4            ;; string
(type 'asymbol)
;-> 5            ;; symbol
(type MAIN)
;-> 6            ;; context
(type +)
;-> 7            ;; primitive
;; 8             ;; imports cdecl, dll
;; 9             ;; imports ffi
(type ''asym)
;-> 10           ;; quote
(type '(1 2 3))
;-> 11           ;; list expression
(type type)
;-> 12           ;; lambda
;; 13            ;; fexpr
;; 14            ;; array
;; 15            ;; dynamic symbol

Vedere il file newlisp.h nel programma sorgente per conoscere i bit superiori e il loro significato (e anche altre cose).

Un altro metodo simile:

(define types '("nil" "true" "int" "float" "string" "symbol" "context"
    "primitive" "import" "ffi" "quote" "expression" "lambda" "fexpr" "array"
    "dyn_symbol"))

(define (typeof v)
    (types (& 0xf ((dump v) 1))))


==========================
 newLISP 99 PROBLEMI (28)
==========================

Questi problemi sono stati creati per essere risolti con il linguaggio Prolog.
Poi è stata la volta dei linguaggi Lisp, Haskell e Scheme.
Potete trovare l'elenco completo dei problemi al sito:

https://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html
http://beta-reduction.blogspot.com/search/label/L-99%3A%20Ninety-Nine%20Lisp%20Problems

In questo documento vengono risolti solo i 28 problemi relativi alla elaborazione di liste.

Elenco problemi
---------------

Elaborazione di liste
N-99-01 Estrarre l'ultimo elemento di una lista
N-99-02 Estrarre il penultimo elemento di una lista
N-99-03 Estrarre il k-esimo elemento di una lista
N-99-04 Determinare il numero di elementi di una lista
N-99-05 Invertire una lista
N-99-06 Determinare se una lista è palindroma
N-99-07 Appiattire una lista annidata
N-99-08 Elimina gli elementi duplicati consecutivi di una lista
N-99-09 Unire gli elementi duplicati consecutivi di una lista in sottoliste.
N-99-10 Run-length encode di una lista
N-99-11 Run-length encode di una lista (modificato)
N-99-12 Run-length decode di una lista
N-99-13 Run-length encode di una lista (diretto)
N-99-14 Duplicare gli elementi di una lista
N-99-15 Replicare per n volte gli elementi di una lista
N-99-16 Eliminare l'elemento k-esimo di una lista
N-99-17 Dividere una lista in due parti (la lunghezza della prima lista è un parametro)
N-99-18 Estrarre una parte di una lista
N-99-19 Ruotare una lista di N posti a sinistra
N-99-20 Eliminare l'elemento k-esimo di una lista
N-99-21 Inserire un elemento in una data posizione di una lista
N-99-22 Creare una lista che contiene tutti i numeri interi di un intervallo
N-99-23 Estrarre un dato numero di elementi da una lista in maniera casuale (random)
N-99-24 Lotto: estrarre N numeri differenti da un intervallo 1..M
N-99-25 Generare le permutazioni degli elementi di una lista
N-99-26 Generare le combinazioni di K oggetti distinti tra gli N elementi di una lista
N-99-27 Raggruppare gli elementi di un insieme in sottoinsiemi disgiunti.
N-99-28 Ordinare una lista in base alla lunghezza delle sottoliste

=======================================================
N-99-01 Estrarre l'ultimo elemento di una lista
=======================================================

(define (ultimo lst)
  (if (null? lst) nil
    (if (null? (rest lst))  ; se è rimasto solo un elemento allora...
        (first lst)         ; prendilo
        (ultimo (rest lst)) ; altrimenti processa il resto della lista
    )
  )
)

(ultimo '(1 2 3))
;-> 3

(ultimo '())
;-> ()

Funzione newLISP predefinita: (last lst)

(last '(1 2 3))
;-> 3

(last '())
;-> ERR: list is empty in function last : '()

=======================================================
N-99-02 Estrarre il penultimo elemento di una lista
=======================================================

(define (penultimo lst)
  (when (not (null? (rest lst)))
    (if (null? (rest (rest lst)))
      (first lst)
      (penultimo (rest lst))
    )
  )
)

(penultimo '(1 2 3))
;-> 2

(penultimo '(1 2))
;-> 1

(penultimo '(1))
;-> nil

=======================================================
N-99-03 Estrarre il k-esimo elemento di una lista
=======================================================
Nota: il primo elemento della lista ha indice zero (zero-based index)

(define (k-esimo lst k)
  (if (< (length lst) (+ k 1))
    nil
    (if (= k 0)
      (first lst)
      (k-esimo (rest lst) (- k 1))
    )
  )
)

(k-esimo '(1 2 3 4 5) 4)
;-> 5

(k-esimo '(1 2 3 4 5) 6)
;-> nil

(k-esimo '() 1)
;-> nil

(k-esimo '() 0)
;-> nil

Funzione predefinita newLISP: (nth int-index lst)

(nth 4 '(1 2 3 4 5))
;-> 5

(nth 6 '(1 2 3 4 5))
;-> ERR: invalid list index in function nth

(nth 0 '())
;-> ERR: invalid list index in function nth

=======================================================
N-99-04 Determinare il numero di elementi di una lista
=======================================================

(define (lunghezza lst)
  (if (null? lst)
    0
    (+ 1 (lunghezza (rest lst)))))

(lunghezza '((1 2) 1 4 (3) 5))
;-> 5

(lunghezza '())
;-> 0

Funzione predefinita newLISP: (length lst)

(length '((1 2) 1 4 (3) 5))
;-> 5

(length '())
;-> 0

=======================================================
N-99-05 Invertire una lista
=======================================================
Per invertire una lista, possiamo salvare il primo elemento, invertire il resto, quindi inserire il vecchio primo elemento in fondo al "resto invertito".

(define (inverti lst)
    (if (null? lst)
        lst
        (append (inverti (rest lst)) (list (first lst)))))

(inverti '(1 2 3))
;-> (3 2 1)

Comunque questo approccio è abbastanza inefficiente, perchè la funzione "append" ha bisogno di attraversare ripetutamente il risultato per aggiungere elementi in fondo.

Allora usiamo una versione ricorsiva in coda (tail-recursive).

Possiamo capire meglio questa implementazione tail-recursive se la scomponiamo in due funzioni, una funzione principale e una funzione di "aiuto".

(define (inverti-aiuto lst acc)
  (if (null? lst)
      acc
      (inverti-aiuto (rest lst) (cons (first lst) acc))))

(define (inverti2 lst)
  (inverti-aiuto lst '()))

(inverti2 '(1 2 3))
;-> (3 2 1)

La differenza principale è che costruire il risultato nel parametro acc significa che possiamo usare la funzione "cons" e non aver bisogno di attraversare ripetutamente il risultato per aggiungere elementi in fondo ad esso (che è ciò che faceva "append" nella funzione precedente).

fold-left e fold-right
----------------------
Per invertire una lista possiamo anche "ripiegare a sinistra (left folding)" la lista in una nuova lista costruita utilizzando la funzione "cons".

(define (inverti-fold lst)
  (fold-left cons '() lst))

Per capire il funzionamento bisogna conoscere come funziona la funzione "fold-left".
Supponiamo di voler sommare una lista di numeri (1 2 3 4). Il modo più immediato è il seguente:

1 + 2 + 3 + 4

In altre parole, abbiamo inserito l'operatore "+" in mezzo ad ogni elemento. Valutiamo l'espressione:

((1 + 2) + 3) + 4

(3 + 3) + 4

6 + 4  ⇒  10

La funzione "fold-left" fa esattamente questo: prende una procedura binaria, un valore iniziale e una lista. Nel nostro caso la procedura è "+", il valore iniziale è 0 e la lista è (1 2 3 4). Vediamo la stessa valutazione in termini di s-espressioni in notazione prefissa.

(fold-left + '(1 2 3 4) 0)

(+ 4 (+ 3 (+ 2 (+ 1 0))))

(+ 4 (+ 3 (+ 2 1)))

(+ 4 (+ 3 3))

(+ 4 6)  ==>  10

Il valore iniziale è importante perchè se la lista di input è vuota, allora questo è il valore che ritorna la funzione "fold-left".

(fold-left + '() 0)  ==>  0

Così possiamo definire una funzione somma in termini di "fold-left":

(define (somma lst) (fold-left + lst 0))

(somma '(1 2 3 4))   ==>  10

(somma '())          ==>  0

La procedura "fold-left" riduce la lista ad un singolo valore, quindi nel caso dell'inversione riduciamo la lista di ingresso ad una singola lista di uscita.

Vediamo un altro esempio di applicazioe di "fold-left":

Rivediamo brevemente la valutazione della somma: la procedura è l'operatore "+" e il valore inziale vale zero.

(fold-left + '(1 2 3 4) 0)

(+ 4 (+ 3 (+ 2 (+ 1 0))))

(+ 4 (+ 3 (+ 2 1)))

(+ 4 (+ 3 3))

(+ 4 6)  ==>  10

Adesso vediamo la valutazione della funzione inverti. La procedura con cui "ripieghiamo" la lista è "cons" e il valore iniziale è la lista vuota '().

(fold-left cons '(1 2 3) '())

(cons 3 (cons 2 (cons 1 '())))

(cons 3 (cons 2 '(1)))

(cons 3 '(2 1))

==> '(3 2 1)

Implementiamo la funzione "fold-left":

(define (fold-left op lst init)
    (if (null? lst) init
        (fold-left op
               (rest lst)
               (op (first lst) init))))

(fold-left - '(1 2 3 4) 0)
;-> 2

(fold-left - '(4 3 2 1) 0)
;-> -2

Per completezza implementiamo anche la funzione "fold-right":

(define (fold-right op lst init)
    (if (null? lst) init
        (op
            (first lst)
            (fold-right op (rest lst) init))))

(fold-right - '(1 2 3 4) 0)
;-> -2

Vediamo la valutazione di questa funzione:

(fold-right - (- 1 (- 2 (- 3 (- 4 0)))))
  (- 1 (- 2 (- 3 (- 4 0))))
= (- 1 (- 2 (- 3 4)))
= (- 1 (- 2 -1))
= (- 1 3)
= -2

Altro esempio:

(fold-right - '(4 3 2 1) 0)
;-> 2

La funzione "folder-right" con operatore "cons" e lista vuota '() come valore iniziale, produce una copia della lista.

(fold-right cons '(4 3 2 1) '())
;-> (4 3 2 1)

Ritorniamo al nostro problema, iscriviamo la funzione inverti-fold e vediamo come funziona la valutazione:

(define (inverti-fold lst)
  (fold-left cons lst '()))

(inverti-fold '(1 2 3)) ; ==> ?

;; prima iterazione
(cons 1 '())    ; ==> '(1)

;; seconda iterazione
(cons 2 '(1))   ; ==> '(2 1)

;; terza iterazione
(cons 3 '(2 1)) ; ==> '(3 2 1)

(inverti-fold '(1 2 3 4 5 6 7 8 9))
;-> (9 8 7 6 5 4 3 2 1)

Funzione predefinita newLISP: (reverse lst)

Vediamo il tempo di esecuzione di queste funzioni:

(inverti '(1 2 3 4 5 6 7 8 9))
;-> (9 8 7 6 5 4 3 2 1)
(time (inverti '(1 2 3 4 5 6 7 8 9)) 100000)
;-> 296.81

(inverti2 '(1 2 3 4 5 6 7 8 9))
;-> (9 8 7 6 5 4 3 2 1)
(time (inverti2 '(1 2 3 4 5 6 7 8 9)) 100000)
;-> 281.463

(inverti-fold '(1 2 3 4 5 6 7 8 9))
;-> (9 8 7 6 5 4 3 2 1)

(time (inverti-fold '(1 2 3 4 5 6 7 8 9)) 100000)
;-> 281.237

(reverse '(1 2 3 4 5 6 7 8 9))
;-> (9 8 7 6 5 4 3 2 1)

(time (reverse '(1 2 3 4 5 6 7 8 9)) 100000)
; 15.622

Morale: implementate le funzioni per conto vostro in modo da imparare nuovi metodi, ma usate quelle predefinite (se esistono).

=======================================================
N-99-06 Determinare se una lista è palindroma
=======================================================

(define (palindroma? lst)
  (= lst (reverse (copy lst))))

(palindroma? '(e p r e s a l a s e r p e))
;-> true

(palindroma? '(e p r e s a l))
;-> nil

=======================================================
N-99-07 Appiattire una lista annidata
=======================================================
Una lista piatta e' una lista senza sottoliste, cioe' una lista costituita solo da atomi.

(define (piatta lst)
  (if (null? lst)
      '()
      (if (atom? lst)
          (list lst)
          (append (piatta (first lst)) (piatta (rest lst)))
      )
   )
)

(piatta '((1 2) ((2 (3)) (4 4)) (((7)))))
;-> (1 2 2 3 4 4 7)

Note:
Punto primo
La definizione ha tre casi:
a) l'argomento e' la lista vuota: restituisce una lista vuota;
b) l'argomento non e' una lista, quindi e' un atomo: allora lo mettiamo in lista con la funzione "list";
c) in tutti gli altri casi ci sono chiamate ricorsive per appiattire il primo elemento e il resto della lista, ed aggiungere i due risultati con "append".
Punto secondo
 Usa i due predicati "null?" ed "atom?".
Punto terzo
 Contiene due chiamate ricorsive sulle parti "first" e "rest" della lista.

Questi tre punti sono caratteristici per ogni funzione che lavora sulle liste di liste.

=======================================================
N-99-08 Elimina gli elementi duplicati consecutivi di una lista
=======================================================
Se una lista contiene elementi ripetuti, devono essere sostituiti con una singola copia dell'elemento. L'ordine degli elementi non deve essere cambiato.

Esempio: (elimina-duplicati '(1 1 1 2 2 3 4 4 5 5 5 6 6 6)) ==> (1 2 3 4 5 6)

(define (elimina-duplicati lst)
    (cond ((null? lst) '())
          ((null? (rest lst)) lst)
          ((= (first lst) (first (rest lst))) (elimina-duplicati (rest lst)))
          (true (cons (first lst) (elimina-duplicati (rest lst))))
    )
)

(elimina-duplicati '(1 1 1 2 2 3 4 4 5 5 5 6 6 6))
;-> (1 2 3 4 5 6)

(elimina-duplicati '(a a b b c c c))
;-> (a b c)

=======================================================
N-99-09 Unire gli elementi duplicati consecutivi di una lista in sottoliste
=======================================================

(define (raggruppa lst)
	(if (= lst '()) '()
		(cons (gruppo lst) (raggruppa (striscia lst)))
	)
)

(define (gruppo lst)
    (cond ((= lst '()) '())
          ((= (rest lst) '()) lst)
          ((= (first lst) (first (rest lst)))
              (cons (first lst) (gruppo (rest lst))))
          (true (list (first lst)))
    )
)

(define (striscia lst)
    (cond ((= lst '()) '())
          ((= (rest lst) '()) '())
          ((= (first lst) (first (rest lst)))
              (striscia (rest lst)))
          (true (rest lst))
    )
)

(raggruppa '(a a a a b c c a a d e e e e))
;-> ((a a a a) (b) (c c) (a a) (d) (e e e e))

(raggruppa '(a a))
;-> ((a a))

=======================================================
N-99-10 Run-length encode di una lista
=======================================================
Implementiamo il metodo di compressione Run Length Encoding ad una lista. Gli elementi consecutivi duplicati sono codificati come liste (N E) dove N è il numero di duplicati dell'elemento E.

newLISP permette di utilizzare diversi stili di programmazione, infatti per questo problema scriveremo la funzione di rle encode sia in uno stile imperativo (iterativo), che in uno stile funzionale (ricorsivo).

Cominciamo con la versione imperativa (iterativa).

; =====================================================
; (rle-encode lst)
; Codifica una lista con il metodo Run Length Encoding
; =====================================================
(define (rle-encode lst)
  (local (palo conta out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq palo (first lst))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              (if (= el palo) (++ conta)
                  ; altrimenti costruiamo la coppia (conta el) e la aggiungiamo al risultato
                  (begin (extend out (list(list conta palo)))
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           ; aggiungiamo l'ultima coppia di valori
           (extend out (list(list conta palo)))
          )
    )
    out
  )
)

(rle-encode '(a a a a b c c a a d e e e e f))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f))

Adesso scriviamo la stessa funzione in stile funzionale (ricorsiva).

Abbiamo bisogno di una funzione di supporto (helper) che ha come argomento aggiuntivo il conteggio degli elementi duplicati. Si controllano i primi due elementi l'uno con l'altro:
- se sono uguali si richiama la funzione di supporto sul resto della lista e aumentando il conteggio
- se sono diversi si costruisce (con la funzione cons) il risultato parziale e poi si richiama la funzione di appoggio sul resto della lista con il conteggio pari a uno.

(define (encode lst)
  (define (helper lst conta)
    (cond ((null? lst) '())
          ((null? (rest lst)) (cons (cons conta lst)))
          ((= (first lst) (first (rest lst))) (helper (rest lst) (+ conta 1)))
          (true (cons (cons conta (first lst)) (helper (rest lst) 1)))
    )
  )
  (helper lst 1))

(encode '(a a a a b c c a a d e e e e f))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f))

(encode '())
;-> ()

Vediamo la differenza di velocità tra le due funzioni (iterativa e ricorsiva).

Versione iterativa

(rle-encode '(a a a a b c c a a d e e e e f))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f))

(time (rle-encode '(a a a a b c c a a d e e e e f)) 50000)
;-> 187.481

Versione ricorsiva:

(encode '(a a a a b c c a a d e e e e f))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f))

(time (encode '(a a a a b c c a a d e e e e f)) 50000)
;-> 468.707

La versione iterativa è 2.5 volte più veloce.

=======================================================
N-99-11 Run-length encode di una lista (modificato)
=======================================================
A differenza dell'esercizio precedente se un elemento non ha duplicati, allora viene semplicemente copiato nella lista risultante.
Solo gli elementi con duplicati assumono la forma (num elemento).

Esempio:
(rle-encode-2 '(a a a a b c c a a d e e e e))
;-> ((4 a) b (2 c) (2 a) d (4 e))

(define (car x)    (first x))
(define (cdr x)    (rest x))
(define (caar x)   (first (first x)))
(define (cadr x)   (first (rest x)))
(define (cadar x)  (first (rest (first x))))

Riscriviamo in un altro modo la funzione per il metodo rle encode standard:

(define (raccogli lst1)
  (define (raccogli-aux lst1 lst2)
    (cond ((null? lst1) '())
          ((and (not (null? (cdr lst1)))
                (= (car lst1) (cadr lst1)))
           (raccogli-aux (cdr lst1) (cons (car lst1) lst2)))
          (true (cons (cons (car lst1) lst2) (raccogli-aux (cdr lst1) '())))))
  (raccogli-aux lst1 '()))

(raccogli '(a a a a b c c a a d e e e e))
;-> ((a a a a) (b) (c c) (a a) (d) (e e e e))

(define (rle-encode-1 lst1)
  (define (rle-encode-1-aux lst1)
    (cond ((null? lst1) '())
          (true (cons (cons (length (car lst1)) (cons (caar lst1) '()))
                      (rle-encode-1-aux (cdr lst1))))))
  (rle-encode-1-aux (raccogli lst1)))

(rle-encode-1 '(a a a a b c c a a d e e e e))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e))

Adesso definiamo la funzione per il metodo rle encode modificato:

(define (rle-encode-2 lst1)
  (define (rle-encode-2-aux lst1)
    (cond ((null? lst1) '())
          ((= 1 (caar lst1)) (cons (cadar lst1) (rle-encode-2-aux (cdr lst1))))
          (true (cons (car lst1) (rle-encode-2-aux (cdr lst1))))))
  (rle-encode-2-aux (rle-encode-1 lst1)))

(rle-encode-2 '(a a a a b c c a a d e e e e))
;-> ((4 a) b (2 c) (2 a) d (4 e))

=======================================================
N-99-12 Run-length decode di una lista
=======================================================
Esempio: (rle-decode '((3 a) (2 b) (2 c) (1 a) (2 d)))
;-> (a a a b b c c a d d))

; =====================================================
; (rle-decode lst)
; Decodifica una lista compressa con il metodo Run Length Encoding
; =====================================================
(define (rle-decode lst)
  (local (out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (dolist (el lst)
              (extend out (dup (last el) (first el)))
           )
          )
    )
    out
  )
)

(rle-decode '((3 a) (2 b) (2 c) (1 a) (2 d)))
;-> (a a a b b c c a d d))

(rle-decode '((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f)))
;-> (a a a a b c c a a d e e e e f)

(rle-decode (rle-encode '(a a a a b c c a a d e e e e f)))
;-> (a a a a b c c a a d e e e e f)

=======================================================
N-99-13 Run-length encode di una lista (diretto)
=======================================================
Implementare il metodo di compressione dei dati run-length encode direttamente. Cioè non creare in modo esplicito le sottoliste che contengono l'elemento duplicato, come nel problema P09, ma contarli direttamente. Come nel problema P11, semplificare la lista dei risultati sostituendo le liste dei singleton (1 X) con X.

(define (rle-encode-direct lst1)
  (define (rle-encode-direct-aux lst1 n)
    (cond ((null? lst1) '())
          ((and (not (null? (cdr lst1))) (= (car lst1) (cadr lst1)))
                                         (rle-encode-direct-aux (cdr lst1) (+ 1 n)))
          (true (if (= n 0)
                    (cons (car lst1)
                          (rle-encode-direct-aux (cdr lst1) 0))
                    (cons (list (+ 1 n) (car lst1))
                          (rle-encode-direct-aux (cdr lst1) 0))))))
  (rle-encode-direct-aux lst1 0))

(rle-encode-direct '(a a a a b c c a a d e e e e))
;-> ((4 a) b (2 c) (2 a) d (4 e))

=======================================================
N-99-14 Duplicare gli elementi di una lista
=======================================================
Esempio: (duplicare '(a b c c d)) ==> (a a b b c c c c d d)

(define duplica
  (lambda (xs)
    (if (null? xs) '()
      (cons (car xs)
            (cons (car xs) (duplica (cdr xs)))))))

(define (duplicare lst)
    (if (null? lst) '()
      (cons (first lst)
            (cons (first lst) (duplicare (rest lst))))))

(duplicare '(a b c))
;-> (a a b b c c)

(duplicare '((a b) c (d (e))))
;-> ((a b) (a b) c c (d (e)) (d (e)))

=======================================================
N-99-15 Replicare per n volte gli elementi di una lista
=======================================================

Esempio: (replica '(a b c) 3)  ==>  (a a a b b b c c c)

(define (ripeti x n)
  (if (zero? n) '()
      (cons x (ripeti x (- n 1)))))

(define (replica lst n)
  (if (null? lst) '()
      (append (ripeti (first lst) n) (replica (rest lst) n))))

(replica '(a b c) 3)
;-> (a a a b b b c c c)

(replica '(a b c) 1)
;-> (a b c)

(replica '(a b c) 0)
;-> ()

(replica '((a) (b c) d) 2)
;-> ((a) (a) (b c) (b c) d d)

=======================================================
N-99-16 Eliminare gli elementi da una lista per ogni k
=======================================================

Esempio: (elimina-ogni '(a b c d e f g) 2) ==> (a c e g)

 (define (elimina-ogni lst k)
   (define (helper lst k lst-orig)
     (if (null? lst) '()
       (if (= k 1) (helper (rest lst) lst-orig lst-orig)
         (cons (first lst) (helper (rest lst) (- k 1) lst-orig)))))
   (helper lst k k))

(elimina-ogni '(a b c d e f g) 2)
;-> (a c e g)

(elimina-ogni '(a b c d e f g) 3)
;-> (a b d e g)

(elimina-ogni '(a b c d e f g) 1)
;-> ()

(elimina-ogni '(a b c d e f g) 0)
;-> (a b c d e f g)

=======================================================
N-99-17 Dividere una lista in due parti (la lunghezza della prima lista è un parametro)
=======================================================

(define (divide-lista lst n)
  (define (divide-aux lst lst2 n)
    (cond ((null? lst) (list lst2 '()))
          ((= n 0)     (list lst2 lst))
          (true        (divide-aux (rest lst) (append lst2 (list (first lst))) (- n 1)))))
  (divide-aux lst '() n))

(divide-lista '(a b c d e f g h i k) 3)
;-> ((a b c) (d e f g h i k))

(divide-lista '(a b c d e f g h i k) 12)
;-> ((a b c d e f g h i k) ())

(divide-lista '() 3)
;-> (() ())

=======================================================
N-99-18 Estrarre una parte di una lista
=======================================================
Dati due indici, I e K, creare una lista contenente gli elementi tra l'I-esimo e il K-esimo della lista originale (entrambi i limiti inclusi). Il primo elemento ha indice 1 (uno).

(define (prendi-1 lst n)
  (if (or (zero? n) (null? lst)) '()
      (cons (first lst) (prendi-1 (rest lst) (- n 1)))))

(define (estrai-1 lst start end)
  (cond ((null? lst) '())
        ((> start 1)  (estrai-1 (rest lst) (- start 1) (- end 1)))
        (true         (prendi-1 lst end))))

(estrai-1 '(a b c d e f g h i k) 3 7)
;-> (c d e f g)

(estrai-1 '(a b c d e f g h i k) 35 35)
;-> ()

(estrai-1 '(a b c d e f g h i k) 1 2)
;-> (a b)

Se invece consideriamo che il primo elemento ha indice 0 (zero), basta modificare la funzione estrai in questo modo:
1) da (> start 1) a (> start 0)
2) da (prendi lst end) a (prendi lst (+ end 1))

(define (prendi-0 lst n)
  (if (or (zero? n) (null? lst)) '()
      (cons (first lst) (prendi-0 (rest lst) (- n 1)))))

(define (estrai-0 lst start end)
  (cond ((null? lst) '())
        ((> start 0)  (estrai-0 (rest lst) (- start 1) (- end 1)))
        (true         (prendi-0 lst (+ end 1)))))

(estrai-0 '(a b c d e f g h i k) 3 7)
;-> (d e f g h)

(estrai-0 '(a b c d e f g h i k) 3 3)
;-> (d)

(estrai-0 '(a b c d e f g h i k) 0 1)
;-> (a b)

=======================================================
N-99-19 Ruotare una lista di N posti a sinistra
=======================================================

(define (divide-lista lst n)
  (define (divide-aux lst lst2 n)
    (cond ((null? lst) (list lst2 '()))
          ((= n 0)     (list lst2 lst))
          (true        (divide-aux (rest lst) (append lst2 (list (first lst))) (- n 1)))))
  (divide-aux lst '() n))

(define (ruota-lista lst1 n)
  (if (or (null? lst1) (= n 0))
      lst1
      (if (> n 0)
          (let (lst2 (divide-lista lst1 n))
            (append (cadr lst2) (car lst2)))
          (let (lst2 (divide-lista lst1 (+ n (length lst1))))
            (append (cadr lst2) (car lst2))))))

(ruota-lista '(a b c d e f g h) 3)
;-> (d e f g h a b c)

(ruota-lista '(a b c d e f g h) -2)
;-> (g h a b c d e f)


=======================================================
N-99-20 Eliminare l'elemento k-esimo di una lista
=======================================================
Il primo elemento della lista ha indice 0 (zero).

(define (elimina-a lst k)
  (if (< k 0)
      (reverse (elimina-a (reverse lst) (- k)))
      (cond ((null? lst) '())
            ((= k -1)    lst)
            ((= k 0)     (rest lst))
            (true        (cons (first lst) (elimina-a (rest lst) (- k 1)))))))

(elimina-a '(a b c d e) 2)
;-> (a b d e)

(elimina-a '(a b c d e) 0)
;-> (b c d e)

(elimina-a '(a b c d e) -2)
;-> (a b d e)

(elimina-a '(a b c d e) 25)
;-> (a b c d e)

=======================================================
N-99-21 Inserire un elemento in una data posizione di una lista
=======================================================
Il primo elemento della lista ha indice 1 (uno).

Esempio: (inserisci-a 'z '(a b c d) 2)  ==>  (a z b c d)

(define (inserisci-a x lst k)
  (if (< k 0)
      (reverse (inserisci-a x (reverse lst) (- k)))
      (cond ((zero? k)   lst)
            ((= k 0)     (cons x lst))
            ((null? lst) '())
            (true        (cons (first lst) (inserisci-a x (rest lst) (- k 1)))))))

(inserisci-a 'alfa '(a b c d) 2)
;-> (a alfa b c d)

(inserisci-a 'alfa '(a b c d) -2)
;-> (a b c alfa d)

(inserisci-a 'alfa '(a b c d) 0)
;-> (a b c d)

(inserisci-a 'alfa '() 2)
;-> ()

(inserisci-a 'alfa '() 1)
;-> (alfa)

(inserisci-a 'alfa '(a b c d) 1000)
;-> (a b c d)

=======================================================
N-99-22 Creare una lista che contiene tutti i numeri interi di un intervallo
=======================================================

(define (seq start end (step 1))
  (cond ((= start end) (list end))
        ((> start end) '())
        (true (cons start (seq (+ start step) end step)))
  )
)

(seq 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

(seq 1 10 2)
;-> (1 3 5 7 9)

Un altro metodo per la stessa funzione (gestisce anche intervalli decrescenti):

(define (range lower upper)
  (define (helper lower upper)
    (if (> lower upper) '()
        (cons lower (helper (+ lower 1) upper))))
  (if (> lower upper)
    (reverse (helper upper lower))
    (helper lower upper)))

(range 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

(range 10 2)
(;-> (10 9 8 7 6 5 4 3 2)

=======================================================
N-99-23 Estrarre un dato numero di elementi da una lista in maniera casuale (random)
=======================================================

(define (estrai-random lst n)
  (slice (randomize lst) 0 n))

(estrai-random '(a b c d e f g h) 3)
;-> (h g b)

=======================================================
N-99-24 Lotto: estrarre N numeri differenti da un intervallo 1..M
=======================================================

(define (lotto-estrai n m)
  (estrai-random (sequence 1 m) n))

(lotto-estrai 6 90)
;-> (61 7 3 83 28 29)

(lotto-estrai 90 90)
;-> (69 76 37 47 81 8 90 55 13 53 26 78 61 64 30 79 11 17 72 42 86 41 45 33 73 80 19
;->  65 75 23 39 32 36 16 82 4 43 67 31 15 63 12 29 1 48 28 6 77 9 38 60 74 25 40 51
;->  10 89 18 88 46 71 50 7 2 22 68 35 70 20 57 49 59 44 54 87 62 34 21 56 84 85 3 2
;->  7 66 58 5 52 14 83 24)

=======================================================
N-99-25 Generare le permutazioni degli elementi di una lista
=======================================================

(define (rimuovi x lst)
  (cond
    ((null? lst) '())
    ((= x (first lst)) (rimuovi x (rest lst)))
    (true (cons (first lst) (rimuovi x (rest lst))))))

(define (permutazioni lst)
  (cond
    ((= (length lst) 1)(list lst))
    (true (apply append(map(lambda (i) (map (lambda (j)(cons i j))
                                            (permutazioni (rimuovi i lst)))) lst)))))
(permutazioni '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))

=======================================================
N-99-26 Generare le combinazioni di K oggetti distinti tra gli N elementi di una lista
=======================================================

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(combinazioni 2 '(1 2 3 4))
;-> ((1 2) (1 3) (1 4) (2 3) (2 4) (3 4))

(combinazioni 3 '(1 2 3 4))
;-> ((1 2 3) (1 2 4) (1 3 4) (2 3 4))

(combinazioni 1 '(a b c))
;-> ((a) (b) (c))

(combinazioni 2 '(a b c))
;-> ((a b) (a c) (b c))

(combinazioni 3 '(a b c))
;-> ((a b c))

=======================================================
N-99-27 Raggruppare gli elementi di un insieme in sottoinsiemi disgiunti
=======================================================

=======================================================
N-99-28 Ordinare una lista in base alla lunghezza delle sottoliste
=======================================================

Calcoliamo le lunghezze delle sottoliste:

(map length '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
;-> (3 2 3 2 4 2 1)

Definiamo una funzione che crea una lista con la seguente struttura:
((indice-lista lunghezza-lista)...(indice-lista lunghezza-lista))

(define (enumera-lunghezza lst)
  (local (out)
    (cond ((null? lst) '())
          (true (setq out '())
                (dolist (el lst)
                  ;(push (list $idx el) _out)
                  (extend out (list(list $idx (length el))))
                )
                ;(reverse _out)
          )
    )
  )
)

(setq lst '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
(enumera-lunghezza lst)
;-> ((0 3) (1 2) (2 3) (3 2) (4 4) (5 2) (6 1))

Adesso ordiniamo questa lista in base al secondo elemento di ogni sottolista (che rappresenta la lunghezza della sottolista originale)

(define (comp x y)
    (>= (last x) (last y)))

(sort (enumera-lunghezza lst) comp)
;-> ((4 4) (0 3) (2 3) (1 2) (3 2) (5 2) (6 1))

Adesso possiamo creare la lista ordinata utilizzando come indice il primo elemento di ogni sottolista:

(define (ordina-lunghezza lst)
  (local (out)
    (cond ((null? lst) '())
          (true (setq out '())
                (setq lst-t (sort (enumera-lunghezza lst) comp))
                (dolist (el lst-t)
                  (extend out (list (nth (first el) lst)))
                )
          )
    )
  )
)

(ordina-lunghezza '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
;-> ((i j k l) (a b c) (f g h) (d e) (d e) (m n) (o))


==============
 ROSETTA CODE
==============

https://rosettacode.org/wiki/Category:Programming_Tasks

Rosetta Code è un sito di programmazione "chrestomathy" (proviene dal greco χρηστομάθεια e significa "desiderio di imparare"). L'idea è di risolvere/presentare la soluzione per lo stesso problema in quanti più linguaggi possibili, per dimostrare le analogie e le differenze dei linguaggi, e per aiutare chi conosce un linguaggio ad apprenderne un altro.
Il sito contiene moltissimi problemi risolti in 714 linguaggio (non tutti problemi sono stati risolti con tutti i linguaggi).
Di seguito vengono presentanti alcuni di questi problemi e la loro soluzione.
Per avere una migliore comprensione si consiglia di provare a risolverli per conto proprio prima di leggere la soluzione.


NUMERI PRIMI
------------

In matematica, un numero primo (in breve anche primo) è un numero intero positivo che ha esattamente due divisori distinti. In modo equivalente si può definire come un numero naturale maggiore di 1 che è divisibile solamente per 1 e per sé stesso. Al contrario, un numero maggiore di 1 che abbia più di due divisori è detto composto.
L'algoritmo di base per calcolare i numeri primi è il cosiddetto Crivello di Eratostene.
Di seguito è riportato l'algoritmo che trova tutti i numeri primi minori o uguali a un intero dato n con il metodo di Eratostene:

1) Creare una lista di numeri interi consecutivi da 2 a n: (2, 3, 4, ..., n).

2) Inizialmente, sia p uguale a 2, il primo numero primo.

3) A partire da p^2, contare ad incrementi di p e marca nella lista tutti quei numeri che sono maggiori o uguali a p^2 stesso. Questi numeri saranno p(p + 1), p(p + 2), p(p + 3), ecc.

4) Trova nella lista il primo numero maggiore di p che non è marcato. Se non esiste tale numero, fermati algoritmo terminato). Altrimenti, lascia p ora uguale a questo numero (che è il prossimo primo), e ripeti dal punto 3.

Quando l'algoritmo termina, tutti i numeri nell'elenco che non sono contrassegnati sono primi.

(setq n 1000)
;definiamo un vettore di n+1 elementi tutti con valore true
;al termine dell'algoritmo i valori del vettore "primi" che hanno valore true sono numeri primi ()
(setq primi (array (add 1 n) '(true)))
(setq p 2)

(while (<= (* p p) n)
  (if (= (primi p) true)) ; se primi[p} non è cambiato, allora è un numero primo)
  ; Poniamo a nil tutti i multipli di p che sono maggiori o uguali al quadrato di p
  ; I numeri che sono multipli di p e sono minori di p^2 sono già stati marcati (posti a nil).
  (for (i (* p p) n p) (setq (primi i) nil))
  (++ p)
)

; stampiamo solo gli indici del vettore primi che hanno valore true (cioè sono numeri primi).
(for (p 2 n 1)
   (if (= (primi p) true)
      (print p { })
   )
)

Adesso possiamo scrivere la funzione completa:

(define (Eratostene n)
  (setq primi (array (add 1 n) '(true)))
  (setq p 2)
  (while (<= (* p p) n)
    (if (= (primi p) true))
    (for (i (* p p) n p) (setq (primi i) nil))
    (++ p)
  )
  (for (p 2 n 1)
    (if (= (primi p) true)
        (print p { })
    )
  )
)

(Eratostene 1000)
;-> 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113
;-> 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 211 223 227 229 233 239 241
;-> 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337 347 349 353 359 367 373 379 383
;-> 389 397 401 409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509 521 523
;-> 541 547 557 563 569 571 577 587 593 599 601 607 613 617 619 631 641 643 647 653 659 661 673
;-> 677 683 691 701 709 719 727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829
;-> 839 853 857 859 863 877 881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 991 997

(prime 137)
;-> true

(prime 889)
;-> nil

Se vogliamo sapere soltanto se un certo numero è primo possiamo utilizzare altri metodi.
Il test di primalità più semplice è la "prova della divisione": Dato un numero n, controlla se ogni numero intero m, che va da 2 a sqrt(n), divide precisamente n (la divisione non lascia resto). Se n è divisibile per uno qualsiasi dei valori di m allora n è composto, altrimenti è primo.

Ad esempio, per testare la primalità di 100 con questo metodo, considera tutti i divisori interi di 100:

2, 4, 5, 10, 20, 25, 50

Il fattore più grande è 100/2 = 50. Questo è vero per tutti n: tutti i divisori sono inferiori o uguali a n/2. Ispezionando i divisori, si determina che alcuni di essi sono ridondanti. L'elenco dei divisori può essere scritto come:

100 = 2 × 50 = 4 × 25 = 5 × 20 = 10 × 10 = 20 × 5 = 25 × 4 = 50 × 2

che dimostra la ridondanza. Una volta testato il divisore 10, che è sqrt(100), il primo divisore è semplicemente il dividendo di un precedente divisore. Pertanto, è possibile eliminare i divisori di prova superiori a sqrt(n). Tutti i numeri pari maggiori di 2 possono anche essere eliminati, poiché se un numero pari può dividere n, anche 2 può dividere quel numero.

Diamo un'occhiata ad un altro esempio e usiamo la prova della divisione per testare la primalità di 17. Poiché ora sappiamo che non abbiamo bisogno di testare usando divisori superiori a sqrt(n), abbiamo solo bisogno di usare divisori interi minori o uguali a sqrt(17) circa uaguale 4.12. Quindi sarebbero 2, 3 e 4. Come detto sopra, possiamo saltare 4 perché se 4 divide precisamente 17, 2 deve anche dividere precisamente 17, che avremmo già controllato prima. Questo ci lascia solo con 2 e 3. Dopo la divisione, troviamo che 17 non è divisibile per 2 o 3, e possiamo confermare che 17 deve essere primo.

L'algoritmo può essere ulteriormente migliorato osservando che tutti i numeri primi sono della forma 6k ± 1, con l'eccezione di 2 e 3. Ciò è dovuto al fatto che tutti gli interi possono essere espressi come (6k + i) per alcuni interi k e per i = - 1, 0, 1, 2, 3 o 4, poi 2 divide (6k + 0), (6k + 2), (6k + 4) e 3 divide (6k + 3). Quindi, un metodo più efficiente è quello di verificare se n è divisibile per 2 o 3, quindi controllare tutti i numeri della forma (6k ± 1 <= sqrt(n)). Questo è 3 volte più veloce di testare tutti i valori di m.
Lo pseudocodice della funzione è il seguente:

 function is_prime(n)
     if n ≤ 3
        return n > 1
     else if n mod 2 = 0 or n mod 3 = 0
        return false
     let i ← 5
     while i * i ≤ n
        if n mod i = 0 or n mod (i + 2) = 0
            return false
        i ← i + 6
     return true

Adesso scriviamo la nostra funzione:

(define (primo? n)
  (setq out true) ; il numero viene considerato primo fino a che non troviamo un divisore preciso
  (cond ((<= n 3) (setq out true))
        ((or (= (% n 2) 0) (= (% n 3) 0)) (setq out nil))
        (true (setq i 5)
              (while (<= (* i i) n)
                (if (or (= (% n i) 0) (= (% n (+ i 2)) 0)) (setq out nil))
                (setq i (+ i 6))
              )
        )
  )
  out
)

(primo? 100)
;-> nil

(primo? 3347833720307)
;-> nil

(primo? 100000017239)
;-> true

Calcoliamo il tempo di esecuzione:

(time (primo? 3347833720307) 100)
;-> 9468.2
(time (primo? 100000017239) 100)
;-> 1640.4

newLISP mette a disposizione la funzione "factor" per calcolare i fattori primi di un numero.
Ad esempio:

(factor 67456)
;-> (2 2 2 2 2 2 2 17 31)

"factor" restituisce una lista con i numeri della scomposizione in fattori del numero fornito.
Possiamo scrivere un'altra funzione per verificare se un dato numero è primo:
se la lunghezza della lista restituita dalla funzione "factor" vale 1, allora il numero è primo.

(define (primo-a? n)
  (= 1 (length (factor n))))

(primo-a? 3347833720307)
;-> nil
(primo-a? 100000017239)
;-> true

Poichè "factor" è una funzione predefinita (compilata) è molto veloce. Se proviamo a migliorare la nostra funzione (ad esempio eliminando i numeri pari dalla fattorizzazione) otteniamo miseri risultati:

(define (primo-b? n)
  (if (even? n) nil
      (= 1 (length (factor n)))))

(primo-b? 3347833720307)
;-> nil
(primo-b? 100000017239)
;-> true

Adesso vediamo la velocità di esecuzione delle due funzioni primo-a e primo-b:

(time (primo-a? 3347833720307) 100)
;-> 203.1
(time (primo-a? 100000017239) 100)
;-> 156.2

(time (primo-b? 3347833720307) 100)
;-> 203.2
(time (primo-b? 100000017239) 100)
;-> 156.2

Non ci sono miglioramenti sostanziali tra "primo-a?" e "primo-b?", comunque entrambe sono circa 10 volte più veloci della funzione "primo?".

Nota: le funzioni "primo-a" e "primo-b" non funzionano con i big integer perchè la funzione "factor" non funziona con i big integer. Il numero massimo possibile (int64) vale: 9223372036854775807.

Riscriviamo la nostra funzione "primo?" in modo da funzionare con i big integer:

(define (primoBig? n)
  (setq out true) ; il numero viene considerato primo fino a che non troviamo un divisore preciso
  (cond ((<= n 3L) (setq out true))
        ((or (= (% n 2L) 0L) (= (% n 3L) 0L)) (setq out nil))
        (true (setq i 5L)
              (while (<= (* i i) n)
                (if (or (= (% n i) 0L) (= (% n (+ i 2L)) 0L)) (setq out nil))
                (setq i (+ i 6L))
              )
        )
  )
  out
)

La funzione è lenta con numeri grandi:

(time (primoBig? 3347833720307) 100)
;-> 17672.8

(time (primoBig? 100000017239) 100)
;-> 3066.7

E raggiunge rapidamente il limite pratico di utilizzo con i big integer:

(primoBig? 1111235916285193) ; numero con 16 cifre
;-> true

(time (primoBig? 1111235916285193)) ; numero con 16 cifre
;-> 3250.1

(primoBig? 76912895956636885) ; numero con 17 cifre
;->  nil
(time (primoBig? 76912895956636885))
;-> 27235.75

Adesso scriviamo una funzione che fattorizza un numero raggruppando i termini uguali.
Ad esempio (fattorizza 45) deve produrre ((3 2) (5 1)), cioè 45 = 3^2 * 5^1.

(define (fattorizza x)
  (setq fattori (factor x))
  (setq unici (unique fattori))
  (transpose (list unici (count unici fattori)))
  ;(map (list unici (count unici fattori)))
)

(fattorizza 45)
;-> ((3 2) (5 1))

(fattorizza 232792560)
;-> ((2 4) (3 2) (5 1) (7 1) (11 1) (13 1) (17 1) (19 1))

(time (fattorizza 232792560) 100000)
;-> 342.6

(factor 9223372036854775807)
;-> (7 7 73 127 337 92737 649657)

(fattorizza 9223372036854775807)
;-> ((7 2) (73 1) (127 1) (337 1) (92737 1) (649657 1))

Può essere utile avere due funzioni che ricostruiscono il numero originale partendo dai due tipi di fattorizzazione:

Operazione inversa di "factor":

(setq f (factor 45))
;-> (3 3 5)

(setq num-f (apply * f))
;-> 45

Operazione inversa di "fattorizza":

(setq fg (fattorizza 45))
;-> ((3 2) (5 1))

(setq num-fg (apply * (map (lambda (x) (pow (first x) (last x))) fg)))
;-> 45

(setq fg (fattorizza 232792560))
;-> ((2 4) (3 2) (5 1) (7 1) (11 1) (13 1) (17 1) (19 1))

(setq num-fg (apply * (map (lambda (x) (pow (first x) (last x))) fg)))
;-> 232792560

Per finire scriviamo una funzione "fattori-primi" che fa lo stesso lavoro di "factor":

(define (fattori-primi numero)
  (define (fattori divisore numero)
    (if (> (* divisore divisore) numero)
        (list numero)
        (if (= (mod numero divisore) 0)
            (cons divisore (fattori divisore (/ numero divisore)))
            (fattori (+ divisore 1) numero)
        )
    )
  )
  (fattori 2L numero)
)

(fattori-primi 3434344L)
;-> (2L 2L 2L 151L 2843L)

(apply * (fattori-primi 3434344L))
;-> 3434344L

(factor 3434344L)
;-> (2 2 2 151 2843)

Ricordiamo che il valore massimo per i numeri int64 è 9223372036854775807.

(factor 9223372036854775807L)
;-> (7 7 73 127 337 92737 649657)

(fattori-primi 9223372036854775807L)
;-> ERR: call or result stack overflow in function > : *

Purtroppo "fattori-primi" è una funzione ricorsiva che consuma tutto lo stack di newLISP.

Proviamo allora a scrivere una versione iterativa che funziona con i big integer:

(define (fattori-primi n)
  (local (fp lim i)
    (setq fp '())
    (while (zero? (% n 2L))  ; quante volte il numero 2 divide esattamente il numero n
      (setq fp (cons 2L fp))
      (setq n (/ n 2L))
    )
    ; adesso n è un numero dispari
    (setq i 3L)
    (setq lim (sqrt n))
    (while (<= i lim)
      (while (zero? (% n i))  ; quante volte il numero "i" divide esattamente il numero n
        (setq fp (cons i fp))
        (setq n (/ n i))
      )
      (setq i (+ 2L i))
    )
    ; questa condizione verifica il caso che il numero n sia un numero primo maggiore di 2
    (if (> n 2L) (setq fp (cons n fp)))
    (reverse fp)
  )
)

(fattori-primi 256)
;-> (2L 2L 2L 2L 2L 2L 2L 2L)

(fattori-primi 3434344L)
;-> (2L 2L 2L 151L 2843L)

Questa volta la funzione "fattori-primi" produce i risultati corretti, ma è molto lenta con numeri grandi:

(time (fattori-primi 9223372036854775807L))
;-> 432092.716 ; 7 minuti e 12 secondi

(time (factor 9223372036854775807L))
;-> 1.998 ;

(fattori-primi 9223372036854775808L)
;-> (2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L)

(time (fattori-primi 9223372036854775808L))
;-> 0

(factor 9223372036854775808L)
;-> ERR: number out of range in function factor

(fattori-primi 9223372036854775809L)
;-> (3L 3L 3L 19L 43L 5419L 77158673929L)

(apply * '(3L 3L 3L 19L 43L 5419L 77158673929L))
;-> 9223372036854775809L

(time (fattori-primi 9223372036854775809L))


NUMERI DI SMITH
---------------

I numeri di Smith sono numeri in cui la somma delle cifre decimali degli interi che compongono il numero è uguale alla somma delle cifre decimali dei suoi fattori primi escluso 1.
Per definizione, tutti i numeri primi sono esclusi in quanto (naturalmente) soddisfano questa condizione!

Esempio utilizzando il numero 166
I fattori primi di 166 sono: 2 x 83 = 166
Somma tutte le loro cifre decimali: 2 + 8 + 3 = 13
Somma le cifre decimali di 166: 1 + 6 + 6 = 13
Allora, il numero 166 è un numero Smith.

Scrivere un programma per trovare tutti i numeri Smith inferiori a 10000.

Le seguenti istruzioni verificano se un numero x è un numero di Smith:

(setq x 1234567890)
;-> 1234567890
(setq s (string x))
;-> "1234567890"
(setq a (slice (explode s) 0))
;-> ("1" "2" "3" "4" "5" "6" "7" "8" "9" "0")
(setq b (apply + (map int a)))
;-> 45

(setq f (factor x))
;-> (2 3 3 5 3607 3803)
(setq sf (apply string f))
;-> "233536073803"
(setq af (slice (explode sf) 0))
;-> ("2" "3" "3" "5" "3" "6" "0" "7" "3" "8" "0" "3")
(setq bf (apply + (map int af)))
;-> 43
(if (= b bf) true nil)
;-> nil

Adesso possiamo scrivere la funzione richiesta:

(define (smith? x)
  (cond
    ((bigint? x) -1) ; do not work with big integer
    ( true
        (setq s (string x))
        (setq a (slice (explode s) 0))
        (setq b (apply + (map int a)))
        (setq f (factor x))
        (if (= 1 (length f)) (setq f '(0))) ; trovato numero primo
        (setq sf (apply string f))
        (setq af (slice (explode sf) 0))
        (setq bf (apply + (map int af)))
        (= b bf)
        ;(if (= b bf) true nil)
    )
  )
)

(smith? 166)
;-> true
(smith? 1234567890)
;-> nil
(smith? 123456789012938347464736374657484756578)
;-> -1

(define (smith10000)
  (setq n '())
  (for (i 1 10000)
    (if (smith? i) (setq n (append (list i) n)))
  )
  (println (reverse n))
  (println "Fino a 10000 ci sono " (length n) " numeri di Smith.")
)

(smith10000)
;-> (4 22 27 58 85 94 121 166 202 265 274 319 346 355 378 382 391 438 454 483 517 526
;->  535 562 576 588 627 634 636 645 648 654 663 666 690 706 728 729 762 778 825 852
;->  861 895 913 915 922 958 985 1086 1111 1165 1219 1255 1282 1284 1376 1449 1507 1581
;->  1626 1633 1642 1678 1736 1755 1776 1795 1822 1842 1858 1872 1881 1894 1903 1908
;->  1921 1935 1952 1962 1966 2038 2067 2079 2155 2173 2182 2218 2227 2265 2286 2326
;->  2362 2366 2373 2409 2434 2461 2475 2484 2515 2556 2576 2578 2583 2605 2614 2679
;->  2688 2722 2745 2751 2785 2839 2888 2902 2911 2934 2944 2958 2964 2965 2970 2974
;->  3046 3091 3138 3168 3174 3226 3246 3258 3294 3345 3366 3390 3442 3505 3564 3595
;->  3615 3622 3649 3663 3690 3694 3802 3852 3864 3865 3930 3946 3973 4054 4126 4162
;->  4173 4185 4189 4191 4198 4209 4279 4306 4369 4414 4428 4464 4472 4557 4592 4594
;->  4702 4743 4765 4788 4794 4832 4855 4880 4918 4954 4959 4960 4974 4981 5062 5071
;->  5088 5098 5172 5242 5248 5253 5269 5298 5305 5386 5388 5397 5422 5458 5485 5526
;->  5539 5602 5638 5642 5674 5772 5818 5854 5874 5915 5926 5935 5936 5946 5998 6036
;->  6054 6084 6096 6115 6171 6178 6187 6188 6252 6259 6295 6315 6344 6385 6439 6457
;->  6502 6531 6567 6583 6585 6603 6684 6693 6702 6718 6760 6816 6835 6855 6880 6934
;->  6981 7026 7051 7062 7068 7078 7089 7119 7136 7186 7195 7227 7249 7287 7339 7402
;->  7438 7447 7465 7503 7627 7674 7683 7695 7712 7726 7762 7764 7782 7784 7809 7824
;->  7834 7915 7952 7978 8005 8014 8023 8073 8077 8095 8149 8154 8158 8185 8196 8253
;->  8257 8277 8307 8347 8372 8412 8421 8466 8518 8545 8568 8628 8653 8680 8736 8754
;->  8766 8790 8792 8851 8864 8874 8883 8901 8914 9015 9031 9036 9094 9166 9184 9193
;->  9229 9274 9276 9285 9294 9296 9301 9330 9346 9355 9382 9386 9387 9396 9414 9427
;->  9483 9522 9535 9571 9598 9633 9634 9639 9648 9657 9684 9708 9717 9735 9742 9760
;->  9778 9840 9843 9849 9861 9880 9895 9924 9942 9968 9975 9985)
;-> Fino a 10000 ci sono 376 numeri di Smith.


NUMERI DI HAMMING
-----------------

I numeri di Hamming sono numeri della forma:

        H = 2^i × 3^j × 5^k

dove: i, j, k ≥ 0

Scrivere un programma per calcolare i numeri di hamming nel corretto ordine.

Questa funzione restituisce il più piccolo tra due numeri (anche big integer):

(define (minimo x y)
  (if (< x y) x y)
)

(define (hamming n bool)
  (setq h (array n '(0L))) ; utilizziamo un vettore big integer
  (setf (h 0) 1L)
  (setq i 0L)  (setq j 0L)  (setq k 0L)
  (setq x2 2L)  (setq x3 3L)  (setq x5 5L)
  (for (m 1 (-- n) 1)
    (setf (h m) (minimo x2 (minimo x3 x5)))
    ;(setf (h m) (min x2 (min x3 x5))) ; la funzione "min" non funziona con i big integer
    (if (= (h m) x2) (begin (++ i) (setq x2 (* (h i) 2L))))
    (if (= (h m) x3) (begin (++ j) (setq x3 (* (h j) 3L))))
    (if (= (h m) x5) (begin (++ k) (setq x5 (* (h k) 5L))))
  )
  (if bool h (last h)) ; se bool = true, allora stampa tutti i numeri, altrimenti solo l'ultimo
)

(hamming 20 true)
;-> (1L 2L 3L 4L 5L 6L 8L 9L 10L 12L 15L 16L 18L 20L 24L 25L 27L 30L 32L 36L)

(hamming 1691)
;-> 2125764000L

(hamming 1000000)
;-> 519312780448388736089589843750000000000000000000000000000000000000000000000000000000L

(time (hamming 1000000))
;-> 2130.027 (millisecondi)


NUMERI DI CATALAN
-----------------

I numeri di Catalan formano una successione di numeri naturali utile in molti calcoli combinatori. Prendono il nome dal matematico belga Eugène Charles Catalan.
Esistono diverse definizioni equivalenti per calcolare questi numeri.
Prendiamo in considerazione una definizione ricorsiva:

C(0) = 1

         2*(2*n - 1)
C(n) = --------------- * C(n-1)
           (n + 1)

Quindi scriviamo una funzione che utilizza i big integer per il calcolo:

(define (catalan n)
  (if (< n 2) 1L
      (/ (* (- (* 4L n) 2L) (catalan (- n 1L))) (+ n 1L))
  )
)

(catalan 5L)
;-> 42L

(catalan 500L)
;-> 53949748691703906090941056611971112873483434819670316767942689642041003733637164
;-> 45082085507475097208889473175349731459177688817366281036278441002389211945617238
;-> 83202123256952806711505149177419849031086149939116975191706558395784192643914160
;-> 118616272189452807591091542120727401415762287153293056320L

Possiamo scrivere anche una versione iterativa, ma non possiamo usare i big integer poichè la divisione altera il risultato, quindi dobbiamo usare i floating-point.
Utilizziamo una funzione diversa:

C(0) = C(1) = 1

C(n) = Prod[ (n + k)/k ] (dove k va da 2 a n) (per n > 1)

Iterativo
Non possiamo usare i big integer poichè la divisione altera il risultato, quindi dobbiamo usare i floating-point.

(define (catalan-i n)
  (setq res 1.0)
  (for (k 2 n)
      (setq res (mul res (div (add n k) k)))
  )
)

(catalan-i 5L)
;-> 41.99999999999999

(ceil (catalan-i 5L))
;-> 42

(catalan-i 500L)
;-> 5.394974869170395e+296


NUMERI DI KAPREKAR
------------------

Un numero intero positivo è un numero di Kaprekar se la rappresentazione decimale del suo quadrato può essere divisa una volta in due parti costituite da numeri interi positivi che sommano al numero originale.
Si noti che una divisione risultante in una parte costituita esclusivamente da 0 s non è valida, poiché 0 non è considerato positivo.
Per convenzione 1 è un numero di Kaprekar.

(setq x 45)
;-> 45
(setq xx (* x x))
;-> 2025
(setq s (string (* x x)))
;-> "2025"

(for (i 0 (length s))
  (setq num1 (int (slice s 0 i) 0 10))
  (setq num2 (int (slice s i (length s)) 0 10))
  (println num1 { } num2)
)
;-> 0 2025
;-> 2 25
;-> 20 25 (la loro somma vale 45, quindi 45 è un numero di Kaprekar)
;-> 202 5
;-> 2025 0

Adesso possiamo scrivere la funzione:

(define (kaprekar? n)
  (setq kap nil)
  (setq i 0)
  (setq xx (* n n))
  (setq s (string xx))
  (while (and (<= i (length s)) (= kap nil))
    (setq num1 (int (slice s 0 i) 0 10))
    (setq num2 (int (slice s i (length s)) 0 10))
    (if (and (> num2 0) (= n (+ num1 num2))) (setq kap true))
    (++ i)
  )
  kap
)

(kaprekar? 1)
;-> true
(kaprekar? 10)
;-> nil
(kaprekar 2223)
;-> true

(define (kaprekar10000)
  (setq out '())
  (for (j 1 10000)
    (if (kaprekar? j) (setq out (append (list j) out)))
  )
  (println (reverse out))
  (println "Fino a 10000 ci sono " (length out) " numeri di Kaprekar.")
)

(kaprekar10000)
;-> (1 9 45 55 99 297 703 999 2223 2728 4950 5050 7272 7777 9999)
;-> Fino a 10000 ci sono 15 numeri di Kaprekar.

(define (kaprekar1milione)
  (setq out '())
  (for (m 1 1000000)
    (if (kaprekar? m) (setq out (append (list m) out)))
  )
  (println (reverse out))
  (println "Fino a 1000000 ci sono " (length out) " numeri di Kaprekar.")
)

(kaprekar1milione)
;-> (1 9 45 55 99 297 703 999 2223 2728 4879 4950 5050 5292 7272 7777 9999 17344 22222
;->  38962 77778 82656 95121 99999 142857 148149 181819 187110 208495 318682 329967 351352
;->  356643 390313 461539 466830 499500 500500 533170 538461 609687 627615 643357 648648
;->  670033 681318 791505 812890 818181 851851 857143 961038 994708 999999)
;-> Fino a 1000000 ci sono 54 numeri di Kaprekar.

(time (kaprekar1milione))
;-> 11532 (millisecondi)


NUMERI FELICI
-------------

Un numero felice è definito dal seguente processo:
Iniziando con un numero intero positivo, sostituisci il numero con la somma dei quadrati delle sue cifre e ripeti il processo fino a quando il numero è uguale a 1 (dove rimarrà), o si genera un ciclo infinito che non include 1. Quei numeri per cui questo processo finisce in 1 sono numeri felici, mentre quelli che non terminano in 1 sono numeri infelici.
Vediamo un esempio:

(setq lista '())
;-> ()
(setq x 31)
;-> 31
(setq s (string x))
;-> "31"
(setq a (slice (explode s) 0))
;-> ("3" "1")
(setq b (apply + (map (lambda (x) (* (int x) (int x)))  a)))
;-> 10 (3*3 + 1*1)

(cond ((= b 1) (setq felice true) (setq continua nil))
      ((!= (ref b lista) nil) (setq felice nil) (setq continua nil))
      (true (setq lista (cons b lista)) (setq n b))
)

se (b = 1) allora (felice = true) e (continua = nil)                  ;(il numero è felice)
se (b si trova nella lista) allora (felice = nil) e (continua = nil)  ;(il numero non è felice)
altrimenti inserisci il numero nella lista e continua                 ;continua creazione lista

(define (felice? n)
  (setq continua true)
  (setq lista '())
  (setq x n)
  (while (= continua true)
    (setq s (string x))
    (setq a (slice (explode s) 0))
    (setq b (apply + (map (lambda (x) (* (int x) (int x)))  a)))
    (cond ((= b 1) (setq felice true) (setq continua nil))
          ((!= (ref b lista) nil) (setq felice nil) (setq continua nil))
          (true (setq lista (cons b lista)) (setq x b))
    )
  )
  felice
)

(felice? 10)
;-> true
(felice? 11)
;-> nil
(felice? 31)
;-> true

(define (felici1000)
  (setq out '())
  (for (j 1 1000)
    (if (felice? j) (setq out (append (list j) out)))
  )
  (println (reverse out))
  (println "Fino a 1000 ci sono " (length out) " numeri felici.")
)

(felici1000)
;-> (1 7 10 13 19 23 28 31 32 44 49 68 70 79 82 86 91 94 97 100 103 109 129 130 133 139
;->  167 176 188 190 192 193 203 208 219 226 230 236 239 262 263 280 291 293 301 302
;->  310 313 319 320 326 329 331 338 356 362 365 367 368 376 379 383 386 391 392 397
;->  404 409 440 446 464 469 478 487 490 496 536 556 563 565 566 608 617 622 623 632
;->  635 637 638 644 649 653 655 656 665 671 673 680 683 694 700 709 716 736 739 748
;->  761 763 784 790 793 802 806 818 820 833 836 847 860 863 874 881 888 899 901 904
;->  907 910 912 913 921 923 931 932 937 940 946 964 970 973 989 998 1000)
;-> Fino a 1000 ci sono 143 numeri felici.


NUMERI PRIMORIALI
-----------------

I numeri primoriali sono quelli formati moltiplicando i numeri primi successivi.
La serie di numeri primoriali vale:

   primorial (0) = 1 (per definizione)
   primoriale (1) = 2 (2)
   primoriale (2) = 6 (2 * 3)
   primoriale (3) = 30 (2 * 3 * 5)
   primoriale (4) = 210 (2 * 3 * 5 * 7)
   primoriale (5) = 2310 (2 * 3 * 5 * 7 * 11)
   primoriale (6) = 30030 (2 * 3 * 5 * 7 * 11 * 13)
   ...

Per esprimere questo matematicamente, primoriale(n) è il prodotto dei primi n numeri primi (successivi):

primorial(n) = prod[prime(k)] (con k che va da 1 a n)

Un metodo semplice, anche se relativamente lento, è quello di generare n numeri primi con il metodo di Eratostene e poi calcolare i numeri primoriali.
Il teorema dei numeri primi ci dice che l'ennesimo numero primo viene delimitato dalla seguente espressione:

n*ln(n) + n*ln(ln(n)) - 1 < p(n) < n*ln(n) + n*ln(ln(n)) per n ≥ 6

La funzione è la seguente (utilizza i big integer):

(define (primoriale n bool)
  (cond ((= n 0L) (setq pn '(1L)))
        ((= n 1L) (setq pn '(1L 2L)))
        (
          (if (<= n 6L) (setq maxnum 20L)
              (setq maxnum (ceil (mul n (add (log n) (log (log n)))))) ; limite superiore
          )
          ;(println maxnum)
          ; generiamo la lista con tutti i numeri primi esistenti fino a maxnum
          (setq primi (array (+ 1L maxnum) '(true)))
          (setq p 2L)
          (while (<= (* p p) maxnum)
            (if (= (primi p) true))
            (for (i (* p p) maxnum p) (setq (primi i) nil))
            (++ p)
          )
          (setq lista-primi '())
          (for (p 2L maxnum)
            (if (= (primi p) true)
                ;(print p { })
                (setq lista-primi (cons p lista-primi))
            )
          )
          (reverse lista-primi) ; funzione distruttiva (cambia direttamente lista-primi)
          ;(println lista-primi)
          ;(println (length lista-primi))
          (if (> n (length lista-primi)) (println "Errore")
              ; Calcoliamo i numeri primoriali fino a n
              (begin
                (setq pn '(1L))
                (setq sum 1L)
                (for (i 0L (- n 1L))
                  ;(println {i =} i)
                  (for (k 0L i)
                    ;(println k)
                    (setq sum (* sum (nth k lista-primi)))
                  )
                  (setq pn (cons sum pn))
                  (setq sum 1L)
                )
                (reverse pn)
                ; risultato
                (if (= bool true) pn
                    (last pn)
                )
              )
          )
        )
  ); end cond
)

(primoriale 0)
;-> 1L

(primoriale 1)
;-> (1L 2L)

(primoriale 6 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L)

(primoriale 10 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L 510510L 9699690L 223092870L 6469693230L)

(primoriale 20 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L 510510L 9699690L 223092870L 6469693230L 200560490130L
;->  7420738134810L 304250263527210L 13082761331670030L 614889782588491410L 32589158477190044730L
;->  1922760350154212639070L 117288381359406970983270L 7858321551080267055879090L
;->  557940830126698960967415390L)

(primoriale 20)
;-> 557940830126698960967415390L

(primoriale 40)
;-> 166589903787325219380851695350896256250980509594874862046961683989710L


NUMERI PERFETTI
---------------

Un numero è perfetto quando è uguale alla somma dei suoi divisori propri.
Oppure, un numero è perfetto quando è uguale alla metà della somma di tutti i suoi divisori positivi (incluso se stesso).
I divisori propri di un numero sono tutti i divisori del numero tranne il numero stesso.
Ad esempio, i divisori di 6 sono {1,2,3,6}, mentre i divisori propri di 6 sono {1,2,3}.
Inoltre, poichè 1 + 2 + 3 = 6, allora 6 è un numero perfetto.
Si conoscono pochi numeri perfetti perchè diventano enormi velocemente.

Per calcolare questi numeri scriviamo per primo una funzione che restituisce i divisori propri di un numero:

(define (divisori n)
  (setq lista-div '(1L))
  (setq m (sqrt n))
  (setq i 2L)
  (while (<= i m)
      (if (zero? (% n i))   ; se 'i' è divisore di 'n'
          (if (= i (/ n i)) ; se entrambi i divisori sono gli stessi aggiungine uno,
                            ; altrimenti aggiungili entrambi
            (setq lista-div (cons i lista-div))
            (setq lista-div (cons (/ n i) (cons i lista-div)))
          )
      )
      (setq i (+ i 1L))
  )
  (sort lista-div)
)

(divisori 128)
;-> (1 2 4 8 16 32 64)

(divisori 20)
;-> (1 2 4 5 10)

(define (perfetto? n)
  (if (= n (apply + (divisori n))) true nil)
)

(perfetto? 6)
;-> true

(perfetto? 8)
;-> nil

(define (perfetti n)
  (setq res '())
  (for (x 2 n)
    (if (= true (perfetto? x)) (setq res (cons x res)))
  )
  (reverse res)
)

(perfetti 10000)
;-> (6 28 496 8128)

La funzione è corretta, ma molto lenta. Proviamo a scrivere una versione ottimizzata:

(define (perfetto-fast? n)
  (cond ((< n 2) (setq somma nil))
        ((!= (mod n 2) 0) (setq somma nil)) ; i numeri dispari non sono perfetti
        (true (setq somma 1)
              (for (i 2 (sqrt n))
                   (if (= (mod n i) 0) (begin (setq somma (+ somma i))
                                              (setq q (/ n i))
                                              (if (> q i) (setq somma (+ somma q)))
                                        )
                   )
               )
        )
  )
  (= n somma)
)

(perfetto-fast? 6)
;-> true

(perfetto-fast? 8128)
;-> true

(perfetto-fast? 33550336)
;-> true

(define (perfetti-fast n)
  (setq res '())
  (for (x 2 n)
    (if (= true (perfetto-fast? x)) (setq res (cons x res)))
  )
  (reverse res)
)

(perfetti-fast 10000)
;-> (6 28 496 8128)

Non provare ad eseguire (perfetti-fast 35000000) per trovare il prossimo numero perfetto (che vale 33550336) perchè impiega molto tempo (alcune ore sul mio computer).

(time (perfetti-fast 34000000))

Vediamo la differenza di velocità:

(time (perfetti 10000) 100)
;-> 12625.9

(time (perfetti-fast 10000) 100)
;-> 6797.5

(div 12625.9 6797.5)
;-> 1.857432879735197

La funzione "perfetti-fast" è 1.86 volte più veloce della funzione "perfetti".

Nota: i numeri perfetti hanno come espressione binaria p valori uguali a uno seguiti da (p-1) zeri (con p numero primo). Qui il numero tra parentesi denota la base in cui il numero viene espresso:

6(10)        = 110(2)
28(10)       = 11100(2)
496(10)      = 111110000(2)
4128(10)     = 1111111000000(2)
33550336(10) = 1111111111111000000000000(2)

Proviamo con il numero 17 (17 valori 1 seguiti da 16 valori 0)
(binary2decimal "111111111111111110000000000000000")
(perfetto-fast? 8589869056)
;-> true

Quindi possiamo cercare i numeri perfetti con il seguente algoritmo:
1) Prendere il primo numero primo pk ()
2) Costruire il numero binario con pk volte 1 e (pk - 1) volte 0
3) Convertire il numero in decimale
4) Controllare se il numero covertito è perfetto
5) Prendere il successivo numero primo e ripeti dal passo 2)

Prima di tutto definiamo una funzione che converte una stringa binaria in un numero decimale (big integer):

(define (binary2decimal _b)
  (setq _l (length _b))
  (setq _d 0L)
  (setq _r (reverse _b))
  (dostring (_c _r)
    ;(println c { } (char c) { } $idx)
    (setq _d (+ _d (* (int (char _c)) (pow 2 $idx))))
  )
)

(binary2decimal "1111111")
;-> 127L

(binary2decimal "1111111111111000000000000")
;-> 33550336L

Adesso scriviamo la funzione per trovare i numeri perfetti con il nostro algoritmo:

(define (perfetti-primi)
  ; lista di numeri primi (attenzione che la funzione "divisori" è lenta)
  (setq primi '(2L 3L 5L 7L 11L 13L 17L 19L 23L))
  (setq res '())
  (dolist (p primi)
    ; creo il numero binario
    (setq ns (join (list (dup "1" p) (dup "0" (- p 1)))))
    ; converto il numero binario in decimale
    (setq dp (binary2decimal ns))
    ; se il numero decimale è perfetto, allora lo stampo
    (if (= dp (apply + (divisori dp))) (print dp { (} p {), }))
  )
)

(perfetti-primi)
;-> 6L (2L), 28L (3L), 496L (5L), 8128L (7L), 33550336L (13L), 8589869056L (17L), 137438691328L
;-> (19L), nil

(perfetto-fast? 2305843008139952128)
;-> true ; ma ci vuole tanto tempo


NUMERI AMICABILI
----------------

Due interi N e M sono considerati coppia di numeri amicabili se N != M e la somma dei divisori propri di N è uguale a M e la somma dei divisori propri di M è uguale a N.
I divisori propri di un intero positivo N sono quei numeri, diversi da N, che dividono N senza resto.
Per N > 1 includeranno sempre 1, ma per N == 1 non ci sono divisori propri.

Scrivere una funzione per trovare le coppie di numeri amicabili fino a N = 100.000

(define (somma-divisori n)
  (setq res 0)
  (setq m (sqrt n))
  (setq i 2)
  (while (<= i m)
      (if (zero? (% n i))   ; se 'i' è un divisore di 'n'
          (if (= i (/ n i)) ; se entrambi i divisori sono uguali...
            (setq res (+ res i)) ; aggiungili una volta
            (setq res (+ res i (/ n i))) ; altrimenti aggiungili entrambi
          )
      )
      (setq i (+ i 1))
  )
  res
)

(somma-divisori 10)
;-> 7

(define (somma-divisori-propri n)
  (+ 1 (somma-divisori n))
)

(define (amicabili)
  (for (j 1 100000)
      (setq spd (somma-divisori-propri j))
      (setq spd2 (somma-divisori-propri spd))
      (if (and (= j spd2) (!= spd spd2))
          (println j { } spd)
      )
  )
)

(amicabili)
;-> 220 284
;-> 284 220
;-> 1184 1210
;-> 1210 1184
;-> 2620 2924
;-> 2924 2620
;-> 5020 5564
;-> 5564 5020
;-> 6232 6368
;-> 6368 6232
;-> 10744 10856
;-> 10856 10744
;-> 12285 14595
;-> 14595 12285
;-> 17296 18416
;-> 18416 17296
;-> 63020 76084
;-> 66928 66992
;-> 66992 66928
;-> 67095 71145
;-> 69615 87633
;-> 71145 67095
;-> 76084 63020
;-> 79750 88730
;-> 87633 69615
;-> 88730 79750


NUMERI PERNICIOSI
-----------------

Un numero pernicioso è un numero intero positivo il cui conteggio della popolazione è un numero primo.
Il numero di abitanti è il numero di uno (1) nella rappresentazione binaria di un numero intero non negativo.

Esempio
22 (che è 10110 in binario) ha un numero di abitanti pari a 3, che è primo, e quindi 22 è un numero pernicioso.

Funzione per verificare se un numero è primo:

(define (primo? n)
  (= 1 (length (factor n))))

Funzione che conta elementi in una lista:

(define (conta item lst)
    (cond ((null? lst) 0)
          ((= (first lst) item) (+ 1 (conta item (rest lst))))
          (true (conta item (rest lst)))))

(conta 'a '(a b c a n a c a a d f))
;-> 5

Funzione predefinita che conta elementi in una lista:

(count '(a) '(a b c a n a c a a d f))
;-> (5)

Funzione che converte un numero decimale in un numero binario:

(define (decimal2binary n)
  (cond ((zero? n) '())
        (true (cons (% n 2)
                    (decimal2binary (/ n 2))))))

(decimal2binary 63)
;-> (1 1 1 1 1 1)

Funzione che verifica se un numero è pernicioso:

(define (pernicioso? n)
  (setq np (count '(1) (decimal2binary n)))
  (if (= true (primo? (first np))) true nil)
)

(pernicioso? 22)
;-> true

Funzione che calcola i numeri perniciosi fino a n:

(define (pernicioso n)
  (setq res '())
  (for (x 2 n)
    (if (= true (pernicioso? x)) (setq res (cons x res)))
  )
  (reverse res)
)

(pernicioso 25)
;-> (3 5 6 7 9 10 11 12 13 14 17 18 19 20 21 22 24 25)


NUMERI DI MUNCHAUSEN
--------------------

Un numero di Munchausen è un numero naturale n la cui somma di cifre (in base 10), ciascuna (tranne la cifra zero) elevata alla potenza di se stessa, è uguale a n.

Ad esempio: 3435 = 3^3 + 4^4 + 3^3 + 5^5

Precalcoliamo i valori delle potenze:

(setq powers (cons '0 (map (lambda (x) (pow x x)) (sequence 1 9))))
;-> (0 1 4 27 256 3125 46656 823543 16777216 387420489)

Facciamo una prova:
(setq a (explode (string "3435")))
(setq b (map int a))
(apply + (map (lambda (x) (nth x powers)) b))

Adesso definiamo la funzione che verifica se un dato numero è di Munchausen:

(define (munchausen n)
  (apply + (map (lambda (x) (nth x powers)) (map int (explode (string n)))))
)

(munchausen 3435)
;-> 3435

(munchausen 438579088)
;-> 438579088

Infine scriviamo la funzione che ricerca i numeri di Munchausen:

(define (cerca-munchausen m)
  (setq powers (cons '0 (map (lambda (x) (pow x x)) (sequence 1 9))))
  ;-> (0 1 4 27 256 3125 46656 823543 16777216 387420489)
  (dotimes (0 m)
    (if (= i (munchausen i)) (println i))
  )
)

(cerca-munchausen 10000)
;-> 1
;-> 3435
;-> nil

(time (cerca-munchausen 500000000))
;-> 0
;-> 1
;-> 3435
;-> 438579088
;-> 1814539.27 ; millisecondi (circa 30 minuti]


SEQUENZA DI COLLATZ
-------------------

La sequenza di numeri di Collatz (o Hailstone) può essere generata da un numero intero positivo iniziale, n da:

   se n è 1, la sequenza termina.
   se n è pari anche allora il successivo n della sequenza vale n / 2
   se n è dispari allora il successivo n della sequenza vale (3 * n) + 1

(define (collatz n)
  (if (= n 1) '(1)
    (cons n (collatz (if (even? n) (/ n 2) (+ 1 (* 3 n)))))))

(define (collatz-lenght n)
  (length (collatz n))
)

(collatz 13123)
;-> (13123 39370 19685 59056 29528 14764 7382 3691 11074 5537 16612 8306 4153 12460
;->  6230 3115 9346 4673 14020 7010 3505 10516 5258 2629 7888 3944 1972 986 493 1480 740
;->  370 185 556 278 139 418 209 628 314 157 472 236 118 59 178 89 268 134 67 202 101 304
;->  152 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)

(collatz-lenght 13123)
;-> 77


PERMUTAZIONI
------------

; =====================================================
; (permutations lst)
; Permutazioni di n elementi
; =====================================================

(define (remove x lst)
  (cond
    ((null? lst) '())
    ((= x (first lst))(remove x (rest lst)))
    (true (cons (first lst) (remove x (rest lst))))))

(define (permutations lst)
  (cond
    ((= (length lst) 1)(list lst))
    (true (apply append(map(lambda (i) (map (lambda (j)(cons i j))
                                            (permutations (remove i lst)))) lst)))))
(permutations '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))

Come funziona?

Quali sono le permutazioni di una lista e come le troveresti?

Le permutazioni di una lista con un singolo elemento sono la lista stessa.
Le permutazioni di (1 2) sono l'insieme: [(1 2) (2 1)].
Le permutazioni di (1 2 3) sono l'insieme: [(1 2 3) (1 3 2) (2 3 1) (2 1 3) (3 1 2) (3 2 1)]

In generale ci sono n! permutazioni in un elenco di lunghezza n - abbiamo n scelte per il primo elemento, e una volta che abbiamo scelto quello, (n-1) scelte per il secondo elemento, (n-2) per il terzo elemento, e così via. Questa diminuzione dei gradi di libertà ci suggerisce di trovare le permutazioni di un elenco di lunghezza n in termini di permutazioni di un elenco di lunghezza (n - 1), e così via fino a raggiungere le permutazioni di un elenco di elementi singoli.
Si scopre che le permutazioni di una lista sono precisamente l'insieme [elemento anteposto alle permutazioni di [lista - elemento], per ogni elemento nella lista].

Osservando il caso (1 2 3) si conferma che questo è vero - abbiamo 1 che prece (2 3) e (3 2), che sono le permutazioni di (2 3), 2 che precede (1 3) e (3 1) e così via. Questa operazione di anteporre l'elemento alla sottolista potrebbe essere definita come:

(define (prepend j)
  (cons element j))

e l'operazione per applicarlo a tutte le permutazioni della sottolista potrebbe essere:

(map prepend (permutations sublist))

Questa operazione è molto onerosa (considerando che hanno tutti la stessa forma), quindi utilizziamo un approccio lambda che cattura il valore dell'elemento considerato. L'operazione che vogliamo diventa:

(map (lambda (j) (cons element j)) (permutations sublist))

Adesso vogliamo applicare questa operazione ad ogni elemento della lista, quindi utilizziamo la funzione map con un'altra funzione lambda:

(map (lambda (element)
       (lambda (j) (cons element j) (permutations sublist)))
     list)

Sembra che vada tutto bene, ma c'è un problema: ogni ciclo di ricorsione prende un elemento e lo converte in una lista. Questo va bene per una lista di lunghezza 1, ma per liste più lunghe ogni elemento genera un annidamento della lista. Per inserire allo stesso livello ogni permutazione generata dobbiamo utilizzare la funzione (apply append...).
Adesso l'unica cosa che manca è come generare la prima sottolista? Questo viene ottenuto utilizzando la funzione "remove": la sottolista è uguale a (remove element list).
La funzione "remove" elimina l'elemento x dalla lista lst:

(remove '1 '(1 2 3 1 1))
;-> (2 3)

In definitiva l'istruzione completa è la seguente:

(apply append (map (lambda (i) (lambda (j) (cons i j))
                               (permutations (remove i lst))) lst))

che risove tutti i casi tranne quello base che viene preso in conasiderazione da:

((= (length lst) 1)(list lst))

Questo è tutto, ma per capire meglio la funzione "permutations" facciamo un esempio partendo dall'interno e proseguendo verso l'esterno.
Applichiamo l'espressione interna (permutations (remove i lst)) ad uno degli elementi:

(define lst '(1 2 3))
(define i 1)
(permutations (remove i lst))
;-> ((2 3) (3 2))

L'espressione rimuove un elemento e genera, ricorsivamente, le permutazioni del resto della lista.
Adesso applichiamo map con la funzione lambda sulle permutazioni ottenute:

(define j 1)
(map (lambda (j) (cons i j)) (permutations (remove i lst)))
;-> ((1 2 3) (1 3 2))

Quindi il map interno produce tutte le permutazioni per un dato i (in questo caso i=1)
Il map esterno assicura che tutte le permutazioni sono generate considerando tutti gli elementi della lista lst come primo elemento:

(map (lambda (i) (map (lambda (j) (cons i j))
                      (permutations (remove i lst))))
     lst)
;-> (((1 2 3) (1 3 2)) ((2 1 3) (2 3 1)) ((3 1 2) (3 2 1)))

Ma questo genera troppe liste innestate, quindi l'applicazione di append appiattisce una lista di liste:

(append '(1 2) '(3 4) '(5 6))
;-> (1 2 3 4 5 6)

(apply append '(((1 2 3) (1 3 2)) ((2 1 3) (2 3 1)) ((3 1 2) (3 2 1))))
;-> ((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))

In questo modo otteniamo la lista corretta delle permutazioni.

Anche la seguente funzione calcola le permutazioni, ma con un metodo diverso:

(define (insert lst n e)
  (if (= 0 n)
      (cons e lst)
      (cons (first lst)
            (insert (rest lst) (- n 1) e))))

(define (permutations l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n)
                                  (insert p n (first l)))
                                (sequence 0 (length p))))
                         (permutations (rest l))))))

(permutations '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))


COMBINAZIONI
------------

; =====================================================
; (combinazioni k nlst)
; Calcola le combinazioni di k elementi da n elementi
; senza ripetizione
; =====================================================

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(combinazioni 2 '(1 2 3 4))
;-> ((1 2) (1 3) (1 4) (2 3) (2 4) (3 4))

(combinazioni 3 '(1 2 3 4))
;-> ((1 2 3) (1 2 4) (1 3 4) (2 3 4))

(combinazioni 1 '(a b c))
;-> ((a) (b) (c))

(combinazioni 2 '(a b c))
;-> ((a b) (a c) (b c))

(combinazioni 3 '(a b c))
;-> ((a b c))


REGOLA DI HORNER
----------------

Calcolare il valore del polinomio: y = 6*x^3 - 4*x^2 + 7*x - 19 per x = 3.
La regola di Horner è un algoritmo inventato da William George Horner che permette di valutare un polinomio: Pn(x) = a(0)*x^n + a(1)*x^(n-1) +...+ a(n-1)*x + a(n) svolgendo n addizioni ed n moltiplicazioni (algoritmo ottimale). Infatti è possibile riscrivere il polinomio nella forma:

Pn(x) = a(n) + x*(a(n-1) + x*(a(n-2) + ... + x*(a(1) + a(0)*x)...))

Pertanto, il valore di tale polinomio si può calcolare sfruttando la definizione ricorsiva:

p(0) = a(0)
p(k+1) = p(k)*x + a(k+1)

Scriviamo la funzione prima in stile funzionale:

(define (horner lst x)
  (define (*horner lst x acc)
    (if (null? lst) acc
        (*horner (rest lst) x (+ (* acc x) (first lst)))))
  (*horner (reverse lst) x 0))

(horner '(-19 7 -4 6) '3)
;-> 128

Adesso la scriviamo in stile iterativo:

(define (horner lst-coeffs x)
  (setq acc 0)
  (reverse lst-coeffs) ; funzione distruttiva
  (dolist (el lst-coeffs)
		acc = acc * x + c
    (setq acc (add (mul acc x) el))
  )
	acc
)

(horner '(-19 7 -4 6) '3)
;-> 128


================
 PROJECT EULERO
================

https://projecteuler.net/archives

Cos'è Project Euler?
Project Euler è una serie di stimolanti problemi di programmazione matematica/informatica che richiedono molto più di semplici approfondimenti matematici da risolvere. Sebbene la matematica ti aiuti ad arrivare a metodi eleganti ed efficienti, per risolvere la maggior parte dei problemi sarà necessario l'uso di un computer e competenze di programmazione.

La motivazione per l'avvio di Project Euler, e la sua continuazione, è di fornire una piattaforma per la mente indagatrice per addentrarsi in aree non familiari e apprendere nuovi concetti in un contesto divertente e ricreativo.

A chi sono rivolti i problemi?
Il pubblico previsto comprende studenti per i quali il curriculum di base non alimenta la loro fame per imparare, adulti il ​​cui background non era principalmente la matematica ma aveva un interesse per le cose matematiche, e professionisti che vogliono mantenere le loro capacità di solving e la matematica all'avanguardia.

Chiunque può risolvere i problemi?
I problemi sono di diversa difficoltà e per molti l'esperienza è l'apprendimento a catena induttivo. Cioè, risolvendo un problema ti esporrà ad un nuovo concetto che ti permette di intraprendere un problema precedentemente inaccessibile. Quindi il partecipante determinato lentamente ma sicuramente farà il suo lavoro attraverso ogni problema.

Cosa fare in seguito?
Per tenere traccia dei tuoi progressi è necessario impostare un account e abilitare i cookie. Se hai già un account, accedi, altrimenti devi registrati - è completamente gratuito!

Tuttavia, poiché alcuni problemi sono difficili, potresti voler visualizzare i Problemi prima di registrarti.

"Il progetto Eulero esiste per incoraggiare, sfidare e sviluppare le capacità e il divertimento di chiunque abbia un interesse per l'affascinante mondo della matematica."

In questo paragrafo affronteremo e risolveremo alcuni di questi problemi. Comunque prima di vedere la soluzione dovresti provare a risolverli per conto proprio in modo da migliorare le tue capacità di problem-solver e di programmatore.

Vengono prima presentate alcune funzioni comuni che servono per la soluzione di diversi problemi.

;=============================================
; (isprime? n)
; Controlla se n è un numero primo
; Non funziona con i big integer
; numero massimo (int64): 9223372036854775807
(define (isprime? n)
  (if (= 1 (length (factor n)))))
;=============================================

;=============================================
; (factor-group n)
; fattorizza il numero x raggruppando i termini uguali
; Non funziona con i big integer
; numero massimo (int64): 9223372036854775807
;=============================================

(define (factor-group x)
  (if (= x 1) '(1 1)
    (letn (fattori (factor x)
          unici (unique fattori))
      (transpose (list unici (count unici fattori)))
    )
  )
)

(factor-group 1)
;-> (1 1)

(factor-group 2000)
;-> ((2 4) (5 3))

(factor-group 232792560)
;-> ((2 4) (3 2) (5 1) (7 1) (11 1) (13 1) (17 1) (19 1))

E la funzione inversa a factor-group che genera il numero partendo dalla fattorizzazione:

(define (inv-factor-group lst)
      (apply * (map (lambda (x) (pow (first x) (last x))) lst))
)

(inv-factor-group (factor-group 232792560))
;-> 232792560


==========
Problema 1
==========

Multipli di 3 e di 5

Se elenchiamo i numeri sotto a 10 che sono multipli di 3 o di 5, otteniamo 3, 5, 6 e 9.
La loro somma vale 23.

Trova la somma di tutti i multipli di 3 o di 5 sotto a 1000.
===================================================================

La funzione "sequence" genera una lista di numeri:

(sequence 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

(sequence 1 10 2)
;-> (1 3 5 7 9)

Possiamo anche scrivere una funzione che si comporta come "sequence":

(define (seq start end (step 1))
  (cond ((= start end) (list end))
        ((> start end) '())
        (true (cons start (seq (+ start step) end step)))
  )
)

(seq 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

(seq 1 10 2)
;-> (1 3 5 7 9)

Un numero n è divisibile esattamente per m se risulta (n mod m == 0),
cioè il resto della divisione tra n e m vale zero.
In newLISP "%" è la funzione mod per i numeri interi.

(zero? (% 10 2))
;-> true
(zero? (% 130 11))
;-> nil

La funzione "filter" seleziona tutti i valori che soddisfano un predicato:
(filter (fn(x) (> x 5)) '(6 4 5 2 6 7 3 4 8 9))
;-> (6 6 7 8 9)

La funzione "apply" applica una funzione utilizzando tutti gli argomenti:
(apply + '(1 3 5))
;-> 9

Adesso possiamo scrivere la funzione:

(define (e001)
  (apply + (filter (fn(x) (or (zero? (% x 3)) (zero? (% x 5)))) (sequence 1 999)))
)

(e001)
;-> 233168

(time (e001))
;-> 0

Soluzione alternativa:

generiamo due sequenze (una con i multipli di 3 e l'altra con i multipli di 5)
(setq a (sequence 3 20 3))
;-> (3 6 9 12 15 18)
(setq b (sequence 5 20 5))
;-> (5 10 15 20)
uniamo le sequenze (la funzione union mantiene solo valori unici)
(setq c (union a b))
;-> (3 6 9 12 15 18 5 10 20)
infine sommiamo tutti i numeri:
(apply + c)
;-> 18

Ed ecco la funzione:

(define (e001)
    (apply + (union (sequence 3 999 3) (sequence 5 999 5)))
)

(time (e001))
;-> 0


==========
Problema 2
==========

I numeri di Fibonacci pari

Ciascun nuovo termine della sequenza di Fibonacci viene generato addizionando i due termini precedenti.
Partendo da 1 e 2, i primi 10 termini valgono:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

Considerando i termini della sequenza di Fibonacci i cui valori non superano quttro milioni, trovare la somma dei termini pari.
===================================================================

Questa è la funzione per il calcolo dei numeri di fibonacci:

(define (fibonacci n)
  (let (L '(0 1))
    (dotimes (i n)
      (setq L (list (L 1) (apply + L)))
    )
    ;(L 1)
    (last L)
  )
)

Il numero 32 è quello che genera l'ultimo valore utile (minore di 4.000.000):

(fibonacci 32)
;-> 3524578

(fibonacci 33)
;-> 5702887

Modifichiamo l'espressione "dotimes" con "while" per controllare il valore ottenuto.
Inoltre aggiorniamo il valore del risultato (res) quando il numero calcolato è dispari.

(define (e002)
  (let (L '(0 1) res 0)
    ;(dotimes (i n)
    (while (< (last L) 4000000)
      (setq L (list (L 1) (apply add L)))
      (if (even? (last L)) (inc res (last L)))
    )
    ;(last L)
    res
  )
)

(e002)
;-> 4613732

(time (e002))
;-> 0

Soluzione alternativa:

(define (e002)
  (let (a 2 b 1 ans 0)
    (until (> b 4000000)
      (if (even? a)
        (inc ans a))
      (inc b a)
      (swap a b))
     ans))

(e002)
;-> 4613732

(time (e002))
;-> 0


==========
Problema 3
==========

Il più grande fattore primo

I fattori primi di 13195 sono 5, 7, 13 e 29.

Qual'è il fattore primo più grande del numero 600851475143 ?
===================================================================

La funzione "factor" di newLISP restituisce tutti i fattori di un numero:

(factor 600851475143)
;-> (71 839 1471 6857)

Non resta che trovare il valore massimo:

(apply max (factor 600851475143))
;-> 6857

Definiamo la funzione:

(define (e003)
  (apply max (factor 600851475143))
)

(e003)
;-> 6857

(time (e003))
;-> 0


==========
Problema 4
==========

Il più grande prodotto palindromo

Un numero palindromo ha lo stesso valore leggendo da sinistra a destra o da destrab a sinistra.
Il più grande numero palindromo ottenuto dal prodotto di due numeri da due cifre vale 9009 = 91 * 99.

Trova il più grande numero palindromo ottenuto dal prodotto di due numeri da tre cifre.
===================================================================

(define (e004)
    (let (out 0  val 0)
        (for (i 100 999)
          (for (j i 999)
            (setq val (string (* i j)))
            (when (= val (reverse (copy val)))
                (setq out (max out (int val)))
            )
          )
        )
 out)
)

(e004)
;-> 906609

(time (e004))
;-> 296.849


==========
Problema 5
==========

Il multiplo minore

2520 è il più piccolo numero che può essere diviso esattamente (senza resto) da tutti i numeri da 1 a 10.

Qual'è il più piccolo numero positivo che è divisibile esattamente per tutti i numeri da 1 a 20 ?
===================================================================

La soluzione non vale 1*2*3*4*5*6*7*8*9*10*11*12*13*14*15*16*17*18*19*20 perchè, per esempio, quando il numero cercato è divisibile per 3 e per 5 è anche divisibile per 15.

La soluzione consiste nel trovare tutti i numeri che sono fattori unici con gli esponenti massimi e moltiplicarli tra loro.

Proviamo con il numero 10:

Troviamo tutte scomposizioni in fattori:

2  -> (2)
3  -> (3)
4  -> (2 2)
5  -> (5)
6  -> (2 3)
7  -> (7)
8  -> (2 2 2)
9  -> (3 3)
10 -> (2 5)

I fattori unici sono: 2, 3, 5, e 7.

Questi hanno esponenete massimo rispettivamente: 3 2 1 1.

Quindi i numeri da moltiplicare sono: 2^3, 3^2, 5^1 e 7^1.

Otteniamo: 8 * 9 * 5 * 7 = 2520.

; lista con le fattorizzazioni dei numeri da 2 a 10
(setq a (map factor (sequence 2 10)))
;-> ((2) (3) (2 2) (5) (2 3) (7) (2 2 2) (3 3) (2 5))

; lista con tutti i numeri dei fattori
(setq b (flat (map factor (sequence 2 10))))
;-> (2 3 2 2 5 2 3 7 2 2 2 3 3 2 5)

; lista con tutti i numeri dei fattori presi una sola volta
(setq c (unique (flat (map factor (sequence 2 10)))))
;-> (2 3 5 7)

Adesso dobbiamo trovare gli esponenti massimi di 2,3,5 e 7 nella lista con le fattorizzazioni dei numeri da 2 a 10.

Vediamo prima come funziona funzione "count":

(setq a '((1 2) (5 5) (2 3)))
(setq c '(2 3 5))

Vogliamo trovare quante volte gli elementi di c compaiono in a:

(map (curry count c) a)
;-> ((1 0 0) (0 0 2) (1 1 0)

cosa significa il risultato?

(1 0 0) -> conto il 2 una  volta su (1 2)
        -> conto il 3 zero volte su (1 2)
        -> conto il 5 zero volte su (1 2)

(0 0 2) -> conto il 2 zero volte su (5 5)
        -> conto il 3 zero volte su (5 5)
        -> conto il 5 due  volte su (5 5)

(1 1 0) -> conto il 2 una  volta su (2 3)
        -> conto il 3 una  volta su (2 3)
        -> conto il 5 zero volte su (2 3)

Se trasponiamo la lista:

(transpose(map (curry count c) a))
;-> ((1 0 1) (0 0 1) (0 2 0))

Che significa:

(1 0 1) -> conto il 2 una  volta su (1 2)
        -> conto il 2 zero volte su (5 5)
        -> conto il 2 una  volta su (2 3)
(0 0 1) -> conto il 3 zero volte su (1 2)
        -> conto il 3 zero volte su (5 5)
        -> conto il 3 una  volta su (2 3)
(0 2 0) -> conto il 5 zero volte su (1 2)
        -> conto il 5 due  volte su (5 5)
        -> conto il 5 zero volte su (2 3)

Nel nostro caso:

; lista con le fattorizzazioni dei numeri da 2 a 10
(setq a (map factor (sequence 2 10)))
;-> ((2) (3) (2 2) (5) (2 3) (7) (2 2 2) (3 3) (2 5))

; lista con tutti i numeri dei fattori
(setq b (flat (map factor (sequence 2 10))))
;-> (2 3 2 2 5 2 3 7 2 2 2 3 3 2 5)

; lista con tutti i numeri dei fattori presi una sola volta
(setq c (unique (flat (map factor (sequence 2 10)))))
;-> (2 3 5 7)

Adesso troviamo quante volte gli elementi di c compaiono in a:

(setq d (transpose(map (curry count c) a)))
;-> ((1 0 2 0 1 0 3 0 1) (0 1 0 0 1 0 0 2 0) (0 0 0 1 0 0 0 0 1) (0 0 0 0 0 1 0 0 0))

Adesso dobbiamo trovare il valore massimo di ogni sottolista (che sono gli esponenti massimi rispettivamente di 2,3,5 e 7).

(setq e (map (curry apply max)
            (transpose(map (curry count c) a))))
;-> (3 2 1 1)

Per capire meglio come funziona l'ultima espressione vediamo un esempio.

Se vogliamo applicare la funzione "sin" ad una lista di valori possiamo usare la funzione "map":

(map sin '(10 20 30))
;-> (-0.5440211108893698 0.9129452507276277 -0.9880316240928618)

Ma se i valori sono in sottoliste questo non funziona:

(map sin '((10) (20) (30)))
;-> ERR: value expected in function sin : '(10)

La soluzione si ottiene utilizzando la funzione "curry" e "apply":

(map (curry apply sin) '((10) (20) (30)))
;-> (-0.5440211108893698 0.9129452507276277 -0.9880316240928618)

Oppure in modo equivalente:

(map (lambda (x) (apply sin x)) '((10) (20) (30)))

"curry" transforma una funzione f(x, y) che prende due argomenti in una funzione fx(y) che prende un singolo argomento.
In questo modo "curry" dice ad "apply" di applicare la funzione "sin" solo alla sottolista.

Tornando al problema abbiamo:

; lista con tutti i numeri dei fattori presi una sola volta
(setq c (unique (flat (map factor (sequence 2 10)))))
;-> (2 3 5 7)

; lista con gli esponenti massimi rispettivamente di 2,3,5 e 7).
(setq e (map (curry apply max)
            (transpose(map (curry count c) a))))
;-> (3 2 1 1)

Adesso calcoliamo i numeri con la funzione "pow" e li moltiplichiamo tra loro:

(apply * (map pow c e))
;-> 2520

Scriviamo la funzione finale:

(define (e005)
  (setq a (map factor (sequence 2 20)))
  (setq b (flat a))
  (setq c (unique b))
  (setq e (map (curry apply max)
               (transpose(map (curry count c) a))))
  (apply * (map pow c e))
)

(e005)
;-> 232792560

(time (e005))
;-> 0

Dopo tutti questi ragionamenti per trovare la soluzione notiamo che il problema richiedeva semplicemente di trovare il minimo comune multiplo dei primi venti numeri interi...
Quindi utilizzando la seguente funzione che calcola il Minimo Comune Multiplo di una serie di numeri:

(define-macro (mcm)
  (apply (fn (x y) (/ (* x y) (gcd x y))) (args) 2))

Potevamo calcolare la soluzione con:

(mcm 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
;-> 232792560


==========
Problema 6
==========

Somma quadrati differenza

La somma dei quadrati dei primi dieci numeri naturali vale,

1^2 + 2^2 + ... + 10^2 = 385

Il quadrato della somma dei primi dieci numeri naturali vale,

(1 + 2 + ... + 10)^2 = 55^2 = 3025

Quindi la differenza tra la somma dei quadrati e il quadrato della somma dei primi dieci numeri naturali vale 3025 − 385 = 2640.

Trovare la differenza tra la somma dei quadrati e il quadrato della somma dei primi cento numeri naturali.
===================================================================

I primi dieci numeri li otteniamo da:

(setq num (sequence 1 10))
;-> (1 2 3 4 5 6 7 8 9 10)

La loro somma vale:

(setq sum (apply add num))
;-> 55

Il quadrato della somma vale:

(setq qs (* sum sum))
;-> 3025

La somma dei quadrati vale:

(setq sq (apply add (map * num num)))

Nota che:

(setq lst (sequence 1 10))
(map * lst lst)
;-> (1 4 9 16 25 36 49 64 81 100)
(map * lst lst lst)
;-> (1 8 27 64 125 216 343 512 729 1000)

La loro differenza vale:

(sub qs sq)
;-> 2640

Scriviamo la funzione:

(define (e006)
  (setq num (sequence 1 100))
  (setq sum (apply add num))
  (setq qs (* sum sum))
  (setq sq (apply add (map * num num)))
  (sub qs sq)
)

(e006)
;-> 25164150

(time (e006))
;-> 0

Soluzione alternativa:

(define (e006)
    (let (lst (sequence 1 100))
        (- (pow (apply + lst)) (apply + (map * lst lst))) )
)


==========
Problema 7
==========

Il 10001-esimo numero primo

Elencando i primi sei numeri primi: 2, 3, 5, 7, 11, e 13, si nota che il sesto primo è 13.

Qual'è il 10001-esimo numero primo?
===================================================================

La soluzione con la forza bruta è semplice, cerchiamo progressivamente tutti i numeri primi partendo dal primo fino ad arrivare al 10001 numero primo:

(define (e007)
  (setq cnt 1 n 3) ; partiamo da 3 (il numero 2 è primo)
  (while (!= 10001 cnt)
      (if (isprime? n) (setq cnt (+ cnt 1))) ; se è un numero primo incrementiamo il conto
      (setq n (+ n 2)) ; non consideriamo i numeri pari
  )
  (- n 2)
)

(e007)
;-> 104743

(time (e007))
;-> 78.133


==========
Problema 8
==========

Il maggior prodotto in una serie

Le quattro cifre adiacenti che hanno il più grande prodotto nel numero da 1000 cifre riportato di seguito sono 9 × 9 × 8 × 9 = 5832.

73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450

Trovare, nel numero da 1000 cifre, le tredici cifre adiacenti che hanno il più grande prodotto. Qual'è il valore di questo numero ?
====================================================================

Assegniamo il numero ad una variabile di tipo stringa:

(set 'x "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450")

(length x)
;-> 1000

Possiamo anche assegnare la variabile in un altro modo:

; elimina gli spazi (line-feeds)
(setq x (replace "\\s+" [text]
73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450
[/text] "" 0))

(length x)
;-> 1000

Dividiamo la stringa in blocchi da 13 caratteri (con passo 1 da 0 a 987):

(slice (explode x) 0 5) ; 5 al posto di 13
;-> ("7" "3" "1" "6" "7")

(setq a (map (fn (i) (slice (explode x) i 5))
             (sequence 0 4))) ; 4 al posto di 987

;-> (("7" "3" "1" "6" "7")
;->  ("3" "1" "6" "7" "1")
;->  ("1" "6" "7" "1" "7")
;->  ("6" "7" "1" "7" "6")
;->  ("7" "1" "7" "6" "5"))

(setq b (map join a))
;-> ("73167" "31671" "16717" "67176" "71765")

Mettiamo tutto insieme:

(setq c (map join (map (fn (i) (slice (explode x) i 5))
                       (sequence 0 4))))

;-> ("73167" "31671" "16717" "67176" "71765")

Convertiamo ogni carattere del blocco in integer:

(map explode c)
;-> (("7" "3" "1" "6" "7")
;->  ("3" "1" "6" "7" "1")
;->  ("1" "6" "7" "1" "7")
;->  ("6" "7" "1" "7" "6")
;->  ("7" "1" "7" "6" "5"))

(setq d (map (fn (i) (map int i)) (map explode c)))
;-> ((7 3 1 6 7) (3 1 6 7 1) (1 6 7 1 7) (6 7 1 7 6) (7 1 7 6 5))

Adesso moltiplichiamo tra loro i numeri in ogni sottolista:

(setq e (map (fn (i) (apply * i)) d))
;-> (882 126 294 1764 1470)

Infine troviamo il valore massimo delle moltiplicazioni:

(apply max e)
;-> 1764

Possiamo scrivere la funzione:

(define (e008)
  (set 'x "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450")
  ;(setq a (map join (map (fn (i) (slice (explode x) i 4)) ; for test: 5832
  ;                       (sequence 0 996))))
  (setq a (map join (map (fn (i) (slice (explode x) i 13)); for final result
                         (sequence 0 987))))
  (setq b (map (fn (i) (map int i)) (map explode a)))
  (setq c (map (fn (i) (apply * i)) b))
  (setq _res (apply max c))
  (println (nth (ref _res c) b)) ;-> (5 5 7 6 6 8 9 6 6 4 8 9 5)
  ;(println (last b)) ;-> (0 4 2 0 7 5 2 9 6 3 4 5 0)
  _res
)

(e008) ; con il valore 4 di test
;-> 5832

(e008) ; con il valore 13
;-> (5 5 7 6 6 8 9 6 6 4 8 9 5)
;-> 23514624000

(* 5 5 7 6 6 8 9 6 6 4 8 9 5)
;-> 23514624000

(time (e008))
;-> 109.557


==========
Problema 9
==========

Triple Pitagoriche speciali

Una tripla pitagorica è un insieme di tre numeri naturali, a < b < c, per cui risulta,

a^2 + b^2 = c^2

Per esempio, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

Esiste solo una tripla pitagorica per cui risulta: a + b + c = 1000.

Trovare il prodotto a*b*c.
====================================================================

(define (e009)
    (catch
      (for (a 1 1000)
        (for (b a 1000)
            (let (c (sqrt (+ (pow a) (pow b))))
                (when (and
                      (= (add a b c) 1000)
                      (< a b c)) ; a < b < c
                    (println a { } b { } c)
                    (throw (* a b c))
                 )
             )
         )
      )
    )
)

(e009)
;-> 200 375 425
;-> 31875000

(time (e009))
;-> 62.491


===========
Problema 10
===========

Sommatoria dei numeri primi

La somma dei pnumeri primi minori di 10 vale 2 + 3 + 5 + 7 = 17.

Trovare la somma di tutti i primi minori di 2 milioni.
====================================================================

(sequence 2 10)
;-> (2 3 4 5 6 7 8 9 10)

(isprime? 2)
;-> true

(filter isprime? (sequence 2 10))
;-> (2 3 5 7)

(filter isprime? (sequence 2 1000))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107
;->  109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 211 223
;->  227 229 233 239 241 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337
;->  347 349 353 359 367 373 379 383 389 397 401 409 419 421 431 433 439 443 449 457
;->  461 463 467 479 487 491 499 503 509 521 523 541 547 557 563 569 571 577 587 593
;->  599 601 607 613 617 619 631 641 643 647 653 659 661 673 677 683 691 701 709 719
;->  727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829 839 853 857
;->  859 863 877 881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 991 997)

(apply add (filter isprime? (sequence 2 10)))
;-> 17

(apply add (filter isprime? (sequence 2 10000)))
;-> 5736396

(apply add (filter isprime? (sequence 2 2000000)))
;-> 142913828922

(time (apply add (filter isprime? (sequence 2 2000000))))
;-> 2265.831

(+ 2 (apply + (filter isprime? (sequence 3 2000000 2 ))))
;-> 142913828922

(time (+ 2 (apply + (filter isprime? (sequence 3 2000000 2 )))))
;-> 1893.077

Proviamo con una funzione iterativa:

(define (e010)
    (let (somma 2)
        (for (i 3 1999999 2)
            (if (= 1 (length (factor i)))
                (setq somma (+ somma i)))
        )
        somma
    )
)

(e010)
;-> 142913828922

(time (e010))
;-> 1562.567


===========
Problema 14
===========

La sequenza di Collatz più lunga

La seguente sequenza iterativa è definita per l'insieme di numeri interi positivi:

n = 1 -> stop
n -> n / 2 (n è pari)
n -> 3 * n + 1 (n è dispari)

Usando la regola sopra e iniziando con 13, generiamo la seguente sequenza:
13 40 20 10 5 16 8 4 2 1
Si può vedere che questa sequenza (che inizia a 13 e finisce a 1) contiene 10 termini.
Anche se non è stato ancora dimostrato (Collatz Problem), si ritiene che tutti i numeri iniziali conducano al numero 1.

Quale numero iniziale, inferiore a un milione, produce la catena più lunga?

NOTA: una volta avviata la sequenza, i termini possono superare il milione.
===================================================================

Scriviamo una funzione che costruisce la sequenza di Collatz per un numero n:

(define (collatz n)
  (if (= n 1) '(1)
    (cons n (collatz (if (even? n) (/ n 2) (+ 1 (* 3 n)))))))

Poi scriviamo una funzione che calcola la lunghezza della sequenza di Collatz di un numero n:

(define (collatz-lenght n)
  (length (collatz n))
)

(collatz 24)
;-> (24 12 6 3 10 5 16 8 4 2 1)

(collatz-lenght 24)
;-> 11

Utilizzando le due funzioni direttamente (senza alcun tipo di ottimizzazione) possiamo scrivere la seguente soluzione:

(define (e014)
  (local (maxlun out num)
    (setq maxlun 0)
    (setq out '())
    (setq num 0)
    (for (i 1 1000000)
      (if (> (length (collatz i)) maxlun)
          (begin
            (setq maxlun (length (collatz i)))
            (setq num i)
          )
      )
    )
    (list num maxlun)
  )
)

Questa funzione è molto lenta...

(e014)
;-> (837799 525)

(time (e014))
;-> 107039.434 ; 107 secondi

Proviamo a scrivere una funzione unica che calcola la lunghezza di collatz senza costruire la lista:

(define (e014)
  (local (maxlun lun num c)
    (setq maxlun 0)
    (setq num 0)
    (for (i 1 1000000)
      (setq c i)
      (setq lun 1)
      ; calcolo della lunghezza della sequenza
      (while (!= c 1)
         (if (even? c) (setq c (/ c 2))
                       (setq c (+ 1 (* 3 c)))
         )
         (inc lun)
      )
      (if (> lun maxlun) ; se la sequenza è più lunga di quella massima,
          (begin         ; allora aggiorno il valore massimo e il relativo numero di collatz
            (setq maxlun lun)
            (setq num i)
          )
      )
    )
    (list num maxlun)
  )
)

(e014)
;-> (837799 525)

(time (e014))
;-> 22486.695 ; 22.4 secondi


===========
Problema 21
===========

Numeri Amicabili

Definiamo d(n) come la somma dei divisori propri di n (tutti i numeri minori di n che dividono esattamente n).

Se d(a) = b e d(b) = a, dove a ≠ b,, allora a e b sono una coppia amicabile e a e b sono chiamati singolarmente numeri amicabili.

Per esempio, i divisori propri di 220 sono 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 e 110: quindi d(n) = 284. I divisori propri di 284 sono 1, 2, 4, 71 e 142: così d(284) = 220.

Calcolare la somma di tutti i numeri amicabili inferiori a 10000.
====================================================================

Definiamo la funzione che calcola la somma dei divisori di un numero:

(define (sum-divisors n)
  (setq res 0)
  (setq m (sqrt n))
  (setq i 2)
  (while (<= i m)
      (if (zero? (% n i))   ; se 'i' è divisore di 'n'
          (if (= i (/ n i))              ; se entrambi i divisori sono uguali...
            (setq res (+ res i))         ; allora aggiungilo una volta,
            (setq res (+ res i (/ n i))) ; altrimenti aggiungili entrambi.
          )
      )
      (setq i (+ i 1))
  )
  res
)

(sum-divisors 10)
;-> 7

Adesso dobbiamo definire la funzione che calcola i divisori propri:

(define (sum-proper-divisors n)
  (+ 1 (sum-divisors n))
)

(sum-proper-divisors 10)
;-> 8
(sum-proper-divisors 3)
;-> 1

(sum-proper-divisors 18)
;-> 21

(sum-proper-divisors 220)
;-> 284
(sum-proper-divisors 284)
;-> 220

Adesso scriviamo la funzione che calcola i numeri amicabili:

(define (e021)
  (setq _res 0)
  (for (j 1 9999)
      (setq spd (sum-proper-divisors j))
      (setq spd2 (sum-proper-divisors spd))
      (if (and (= j spd2) (!= spd spd2))
            (begin
              (setq _res (+ _res spd spd2))
              ;(println j { } spd { } spd2)
            )
      )
  )
  (/ _res 2)
)

(e021)
;-> 220 284 220
;-> 284 220 284
;-> 1184 1210 1184
;-> 1210 1184 1210
;-> 2620 2924 2620
;-> 2924 2620 2924
;-> 5020 5564 5020
;-> 5564 5020 5564
;-> 6232 6368 6232
;-> 6368 6232 6368
;-> 31626

(time (e021) 10)
;-> 1937.7

Una soluzione più efficiente si ottiene usando la seguente formula:
Siano p1, p2, … pk i fattori primi del numero n.
Siano a1, a2, .. ak le potenze massime rispettivamente di p1, p2, .. pk che dividono n (es. n = (p1^a1)*(p2^a2)*...*(pk^ak)).

Somma dei divisori = (1 + p1 + p1^2 ... p1^a1) *
                     (1 + p2 + p2^2 ... p2^a2) *
                     ......................... *
                     (1 + pk + pk^2 ... pk^ak)

Notiamo che i termini individuali di questa formula sono progressioni geometriche.
Possiamo riscrivere la formula come:

Somma dei divisori = (p1^(a1+1) - 1)/(p1 - 1) *
                     (p2^(a2+1) - 1)/(p2 - 1) *
                     ........................ *
                     (pk^(ak+1) - 1)/(pk - 1)

Vediamo un'applicazione della formula:

Consideriamo il numero 18.

(factor 18)
;-> (2 3 3)

Somma dei divisori = 1 + 2 + 3 + 6 + 9 + 18
(+ 1 2 3 6 9 18)
;-> 39

Scrivendo i divisori come potenze dei fattori primi otteniamo:

Somma di divisori = (2^0)(3^0) + (2^1)(3^0) + (2^0)(3^1) +
                    (2^1)(3^1) + (2^0)(3^2) + (2^1)(3^2)
                  = (2^0)(3^0) + (2^0)(3^1) + (2^0)(3^2) +
                    (2^1)(3^0) + (2^1)(3^1) + (2^1)(3^2)
                  = (2^0)(3^0 + 3^1 + 3^2) +
                    (2^1)(3^0 + 3^1 + 3^2)
                  = (2^0 + 2^1)(3^0 + 3^1 + 3^2)

Guardando attentamente, possiamo notare che l'ultima espressione è del tipo:

(1 + p1) * (1 + p2 + p2^2)

dove p1 = 2, p2 = 3.

Quindi: (1 + 2) * (1 + 3 + 9) = 3*13 = 39

Per trovare la somma dei divisori di un numero è sufficiente conoscere la sua scomposizione in fattori primi e applicare la seguente formula:

Somma dei divisori = Prod [(1 + f(i)^1 + ... + f(i)^k(i)]

dove [f(i), k(i)] è il fattore i-esimo con f = valore del fattore e k = potenza del fattore
e l'indice i varia da 1 al numero dei fattori.

Per trovare la somma dei divisori propria di un numero, basta sottrarre il numero stesso alla somma dei divisori ottenuta con la formula.

Esempio:

(fattorizza 18)
;-> ((2 1) (3 2))

somma dei divisori = (1 + p1 + p1^2 ... p1^a1) * (1 + p2 + p2^2 ... p2^a2) =
= (1 + 2) * (1 + 3 + 3^2) = 3 * 13 = 39

somma dei divisori propri = somma dei divisori - n = 39 - 18 = 21

Esempio:

(fattorizza 220)
;-> ((2 2) (5 1) (11 1))

p1 = 2  a1 = 2
p2 = 5  a2 = 1
p3 = 11 a3 = 1

(p1^(a1+1) - 1)/(p1 - 1) = (2^3 - 1)/(2 - 1) = 7
(p2^(a2+1) - 1)/(p2 - 1) = (5^2 - 1)/(5 - 1) = 6
(p3^(a3+1) - 1)/(p3 - 1) = (11^2 - 1)/(11 - 1) = 12

(* 6 7 12)
;-> 504

(- 504 220)
;-> 284 ; somma dei divisori propri di 220

Adesso possiamo scrivere la funzione che calcola i numeri amicabili:

(define (factor-group x)
  (if (= x 1) '(1 1)
    (letn (fattori (factor x)
          unici (unique fattori))
      (transpose (list unici (count unici fattori)))
    )
  )
)

(factor-group 220)
;-> ((2 2) (5 1) (11 1))

(factor-group 1)
;-> (1 1)

(define (somma-divisori-propri-fast n)
  (if (= n 1) '0
    (begin (setq res 1)
     (setq lst (factor-group n))
     (dolist (el lst)
       (setq somma-el 0)
       (for (i 0 (last el))
         (setq somma-el (+ somma-el (pow (first el) i)))
       )
       (setq res (* res somma-el))
     )
     (- res n)) ;somma divisori propri (tutti tranne se stesso)
  )
)

(somma-divisori-propri-fast 220)
;-> 284

(somma-divisori-propri-fast 284)
;-> 220

(somma-divisori-propri-fast 1)
;-> 0

Scriviamo la funzione richiesta dal problema:

(define (e021-fast)
  (setq _res 0)
  (for (j 2 9999)
      (setq spd (somma-divisori-propri-fast j))
      (setq spd2 (somma-divisori-propri-fast spd))
      (if (and (= j spd2) (!= spd spd2))
            (begin
              (setq _res (+ _res spd spd2))
              ;(println j { } spd { } spd2)
            )
      )
  )
  (/ _res 2)
)

(e021-fast)
;-> 31626

(time (e021-fast) 10)
;-> 672.0

la funzione "e021-fast" è tre volte più veloce della funzione "e021".


===============
 PROBLEMI VARI
===============

Ricerca binaria (binary search)
-------------------------------
La "ricerca binaria" è un algoritmo di ricerca che individua l'indice di un determinato valore in un insieme ordinato di dati. Se il valore non esiste allora l'indice vale -1.
Questo algoritmo cerca un elemento all'interno di una lista ordinata, effettuando mediamente meno confronti rispetto ad una ricerca sequenziale, e quindi più rapidamente rispetto ad essa perché, sfruttando l'ordinamento, dimezza l'intervallo di ricerca ad ogni passaggio.
L'algoritmo è simile q quella della ricerca di una parola sul dizionario: sapendo che il vocabolario è ordinato alfabeticamente, l'idea è quella di iniziare la ricerca non dal primo elemento, ma da quello centrale, cioè a metà del dizionario. Si confronta questo elemento con quello cercato:
- se corrisponde, la ricerca termina indicando che l'elemento è stato trovato;
- se è superiore, la ricerca viene ripetuta sugli elementi precedenti (ovvero sulla prima metà del dizionario), scartando quelli successivi;
- se invece è inferiore, la ricerca viene ripetuta sugli elementi successivi (ovvero sulla seconda metà del dizionario), scartando quelli precedenti.
Se tutti gli elementi vengono scartati, la ricerca termina senza aver trovato il valore.
La ricerca binaria non usa mai più di floor(log(2) N) (logaritmo base 2 di N approssimato per eccesso) confronti.

Scriviamo questo algoritmo sia in versione iterativa che in versione ricorsiva.

Versione iterativa:

(define (bs num lst)
  (local (basso alto indice)
    (setq out -1) ; elemento non trovato
    (setq basso 0) ; inizio lista
    (setq alto (sub (length lst) 1)) ; fine lista
    (while (and (>= alto basso) (= out -1))
      (setq indice (>> (add basso alto))) ; valore centrale indice
      (cond ((> (lst indice) num)
             (setq alto (sub indice 1))) ; aggiorno l'indice "alto"
            ((< (lst indice) num)
             (setq basso (add indice 1))) ; aggiorno l'indice "basso"
            (true (setq out indice)) ; elemento trovato
      )
    );while
    out
  );local
)

(bs 2 '(-31 0 1 2 3 4 65 83 99 782))
;-> 3

(bs -2 '(-31 0 1 2 2 4 65 83 99 782))
;-> -1

La funzione non è in grado di trovare il numero se la lista è ordinata in modo decrescente:

(bs 2 '(782 99 83 65 4 3 2 1 0 -31))
;->  -1 ;il valore 2 esiste con indice 6.

Aggiungiamo un parametro che ci permette di specificare l'ordinamento della lista:
1) > la lista è ordinata in modo crescente
2) < la lista è ordinata in modo decrescente

(define (bs num lst op)
  (local (basso alto indice)
    (setq out -1)
    (setq basso 0)
    (setq alto (sub (length lst) 1))
    (while (and (>= alto basso) (= out -1))
      (setq indice (>> (add basso alto))) ;; right shift
      (cond ((> (lst indice) num)
             (if (= op >) ;controllo dell'ordinamento della lista
                (setq alto (sub indice 1))
                (setq basso (add indice 1))
             ))
            ((< (lst indice) num)
             (if (= op >) ;controllo dell'ordinamento della lista
                (setq basso (add indice 1))
                (setq alto (sub indice 1))
             ))
            (true (setq out indice))
      )
    );while
    out
  );local
)

(bs 2 '(-31 0 1 2 3 4 65 83 99 782) >)
;-> 3

(bs -2 '(-31 0 1 2 2 4 65 83 99 782) >)
;-> -1

(bs 2 '(782 99 83 65 4 3 2 1 0 -31) <)
;-> 6

(bs -2 '(782 99 83 65 4 3 2 1 0 -31) <)
;-> -1

Vediamo la versione ricorsiva:

(define (bs-r num lst op)
  (define (bsr num lst basso alto op)
    (setq indice (>> (add basso alto)))
    (cond ((< alto basso) -1)
          ((> (lst indice) num)
              (if (= op >)
                  (bsr num lst basso (sub indice 1) op)
                  (bsr num lst (add indice 1) alto op)))
          ((< (lst indice) num)
              (if (= op >)
                  (bsr num lst (add indice 1) alto op)
                  (bsr num lst basso (sub indice 1) op)))
          (true indice)
    );cond
  )
  (bsr num lst 0 (length lst) op)
)

(bs-r 2 '(-31 0 1 2 3 4 65 83 99 782))

(bs-r 2 '(-31 0 1 2 3 4 65 83 99 782) >)
;-> 3

(bs-r -2 '(-31 0 1 2 2 4 65 83 99 782) >)
;-> -1

(bs-r 2 '(782 99 83 65 4 3 2 1 0 -31) <)
;-> 6

(bs-r -2 '(782 99 83 65 4 3 2 1 0 -31) <)
;-> -1


Frazione generatrice
--------------------

Qual è la frazione generatrice di 1.42703703703...? (il 703 si ripete infinite volte)

1.42703 = (142703 - 152)/99900

Come verifica possiamo calcolare:

152651 / 99900 = 1.42703703703...

Definiamo l'algoritmo di calcolo della frazione generatrice:

Consideriamo ad esempio il numero 1.42703703703..., con le cifre 703 che si ripetono infinite volte.

- si dice periodo il gruppo di cifre che si ripete (nell'esempio, il periodo è 703)
- si dice antiperiodo il gruppo di cifre che sta tra la virgola (punto) e il periodo (nell'esempio, l'antiperiodo è 42)

se l’antiperiodo non c’è, si parla di numero periodico semplice (ad esempio 1,6666... è un numero periodico semplice)

se invece l’antiperiodo è presente, si parla di numero periodico misto (ad esempio 1,3777... è un numero periodico misto)

L'algoritmo è il seguente:

Per costruire la frazione generatrice di un numero decimale periodico si calcola:

1) al numeratore, il numero dato senza la virgola (punto) e senza il segno di periodo, meno (sottrazione) tutto ciò che sta prima del periodo;

2) al denominatore, tanti 9 quante sono le cifre del periodo, seguiti da tanti 0 quante sono le cifre dell’antiperiodo.

3) Dopo aver fatto queste operazioni dobbiamo ridurre la frazione numeratore/denominatore ai minimi termini.

Nel nostro caso:

numero = 1.42(703)
periodo = 703
numero cifre periodo = 3
antiperiodo = 42
numero cifre antiperiodo = 2

Quindi:

N = 142708 - 142

D = 99900 (perchè periodo di 3 cifre --> 999 e antiperiodo di 2 cifre --> 00)

La nostra funzione avrà tre parametri:

1) il numero (1.42703)
2) in numero di cifre del periodo (3)
3) in numero di cifre dell'antiperiodo (2)

(define (fraz-gen num np na)
  (local (n n1 n2 d d1 d2 t1 t2 temp)
     ; calcolo numeratore
    (setq n1 (mul num (pow 10 (add np na))))
    ;(setq n2 (int (mul num (pow 10 na))))
    (setq n2 (int (mul num (pow 10 na))) 0 10)
    (setq n (sub n1 n2))
    ; calcolo denominatore
    (setq d1 (dup "9" np))
    (setq d2 (dup "0" na))
    (setq d (int (append d1 d2)))
    ;semplifica numeratore/denominatore
    (setq t1 n)
    (setq t2 d)
    (while (!= t2 0)
      (setq temp t2)
      (setq t2 (% t1 temp))
      (setq t1 temp)
    )
    (setq n (/ n t1))
    (setq d (/ d t1))
    ; risultato
    (list n d (div n d))
  )
)

(fraz-gen 1.42703 3 2)
;-> (3853 2700 1.427037037037037)

(fraz-gen 10.52803 2 3)
;-> (13897 1320 10.5280303030303)

(fraz-gen 1.2 1 0)
;-> (11 9 1.222222222222222)

(fraz-gen 3.141592 1 5)
;-> (2827433 900000 3.141592222222222)

Nota:
I numeri che hanno come periodo la sola cifra 9 non esistono.
Infatti matematicamente 1.999... = 2.

(fraz-gen 1.9 1 0)
;-> (2 1 2)

(frac-gen 3.14159 1 4)
;-> (3927 1250 3.1416)


Il numero aureo
---------------

Il numero aureo (o rapporto aureo) è il numero ottenuto effettuando il rapporto fra due lunghezze disuguali delle quali la maggiore "a" è medio proporzionale tra la minore "b" e la somma delle due (a+b):
                        (a + b)     a
numero aureo (phi) --> --------- = ---
                           a        b

Quindi possiamo scrivere:

            1
phi = 1 + -----
           phi

Che porta alla seguente equazione di secondo grado:

phi^2 - phi - 1 = 0

Che ha la seguente soluzione (positiva):

phi = (1 + (sqrt 5))/2 = 1.6180339887...

Quindi phi è un numero irrazionale.

Cerchiamo di calcolarlo con il metodo del punto fisso.
La funzione di cui ricerchiamo il punto fisso vale:

phi = 1 + 1/phi

Poniamo il punto fisso iniziale a uno: phi0 = 1

(setq phi0 1)
(setq phi phi0)
(while (!= phi (add 1 (div 1 phi)))
  (setq phi (add 1 (div 1 phi)))
)
;-> 1.618033988749895


Equazioni di secondo grado
--------------------------

Scriviamo una funzione che calcola le soluzioni di una equazione di secondo grado:

; Equazione di secondo grado: (a*x^2 + b*x + c = 0)
; Soluzioni:
; x1 = -b/(2*a) + (sqrt(b*b - 4*a*c))/(2*a)
; x2 = -b/(2*a) - (sqrt(b*b - 4*a*c))/(2*a)

(define (solve-quadratic a b c)
  (if (and (null? a) (null? b) (null? c))
      (begin
        (println "(solve-quadratic a b c)")
        (println "Calcola le soluzioni dell'equazione: a*x^2 + b*x + c = 0")
        (print {})
      )
  ; else
  (local (x1 i1 x2 i2 delta)
    (setq delta (sub (mul b b) (mul 4 a c)))
    (println delta)
    (cond ((= a 0) ; equazione di primo grado
            (if (!= b 0) (setq x1 (sub 0 (div c b)))))
          ((> delta 0) ; due radici reali
            (setq x1 (div (add (sub 0 b) (sqrt delta)) (mul 2 a)))
            (setq x2 (div (sub (sub 0 b) (sqrt delta)) (mul 2 a)))
            (setq i1 0.0)
            (setq i2 0.0))
          ((< delta 0) ; due radici complesse
            (setq x1 (div (sub 0 b) (mul 2 a)))
            (setq x2 (div (sub 0 b) (mul 2 a)))
            (setq i1 (div (sqrt (sub 0 delta)) (mul 2 a)))
            (setq i2 (sub 0 (div (sqrt (sub 0 delta)) (mul 2 a)))))
          (true
          ;((= delta 0) ; due radici coincidenti
            (setq x1 (sub 0 (div b (mul 2 a))))
            (setq x2 (sub 0 (div b (mul 2 a)))))
    )
    (list (list x1 i1) (list x2 i2))
  )
  ) ;endif
)

(solve-quadratic)
;-> (solve-quadratic a b c)
;-> Calcola le soluzioni dell'equazione: a*x^2 + b*x + c = 0

(solve-quadratic -3 -3 -20)
;-> -231
;-> ((-0.5 -2.533114025595111) (-0.5 2.533114025595111))

(solve-quadratic 3 3 -20)
;-> 249
;-> ((2.129955639676583 0) (-3.129955639676583 0))

(solve-quadratic 3 -3 -20)
;-> 249
;-> ((3.129955639676583 0) (-2.129955639676583 0))

(solve-quadratic -3 -3 20)
;-> 249
;-> ((-3.129955639676583 0) (2.129955639676583 0))

(solve-quadratic 3 3 20)
;-> -231
;-> ((-0.5 2.533114025595111) (-0.5 -2.533114025595111))

(solve-quadratic 0 10 20)
;-> 100
;-> ((-2 nil) (nil nil))


Equazione di terzo grado
------------------------

Scriviamo una funzione che calcola le soluzioni di una equazione di terzo grado:

; Equazione di terzo grado: (a*x^3 + b*x^2 + c*x + d = 0)
; Per l'algoritmo di soluzione vedere i seguenti link:
; http://mathworld.wolfram.com/CubicFormula.html
; https://courses.cs.washington.edu/courses/cse590b/13au/lecture_notes/solvecubic_p2.pdf

(define (solve-cubic a b c d)
  (local (x1 x2 x3 i1 i2 i3 F G H I J K L M N P Q R S T U)
    (setq x1 0 x2 0 x3 0 i1 0 i2 0 i3 0)
    ; Calcolo discriminanti F, G, H
    ; F = (3*(c/a) - (b*b)/(a*a)) / 3
    (setq F (div (sub (mul 3 (div c a)) (div (mul b b) (mul a a))) 3))
    ; (println "F = " F)
    ; G = ((2*(b*b*b)/(a*a*a)) - (9*b*c/(a*a)) + (27*(d/a))) / 27
    (setq G (div (add (sub (mul 2 (div (mul b b b) (mul a a a))) (div (mul 9 b c) (mul a a))) (mul 27 (div d a))) 27))
    ; (println "G = " G)
    ; H = ((G*G)/4) + ((F*F*F)/27)
    (setq H (add (div (mul G G) 4) (div (mul F F F) 27)))
    ; (println "H = " H)
    ; Controllo discriminanti per determinare il tipo delle radici
    (cond ((> H 0) ; una radice reale e due radici complesse
            ; I = -(G/2) + Math.sqrt(H)
            (setq I (sub (sqrt H) (div G 2)))
            ;(println "I = " I)
            ; J = Math.cbrt(I)
            (setq J (my-pow I (div 1 3)))
            ;(println "J = " J)
            ; K = (-G/2) - Math.sqrt(H)
            (setq K (sub (sub 0 (div G 2)) (sqrt H)))
            ;(println "K = " K)
            ; L = Math.cbrt(K)
            (setq L (my-pow K (div 1 3)))
            ;(println "L = " L)
            ; x1 =  (J + L) - (b/(3*a))
            (setq x1 (sub (add J L) (div b (mul 3 a))))
            ; x2 = -(J + L)/2 - (b/(3*a))
            (setq x2 (sub (sub 0 (div (add J L) 2)) (div b (mul 3 a))))
            ; i2 =  (J - L) * Math.sqrt(3)/2
            (setq i2 (mul (sub J L) (div (sqrt 3) 2)))
            ; x3 =  x2
            (setq x3 x2)
            ; i3 = -i2
            (setq i3 (sub 0 i2)))
          ((and (zero? F) (zero? G) (zero? H)) ; tre radici reali coincidenti
            ; x1 = Math.cbrt(d/a) * (-1)
            (setq x1 (sub 0 (my-pow (div d a) (div 1 3))))
            (setq x2 x1)
            (setq x3 x1))
          ((<= H 0) ; tre radici reali
            ; M = Math.sqrt((G*G)/4 - H)
            (setq M (sqrt (sub (div (mul G G) 4) H)))
            ;(println "M = " M)
            ; N = Math.cbrt(M)
            (setq N (my-pow M (div 1 3)))
            ;(println "N = " N)
            ; P = Math.acos(-(G/(2*M)))
            (setq P (acos (sub 0 (div G (mul M 2)))))
            ;(println "P = " P)
            ; Q = N*(-1)
            (setq Q (sub 0 N))
            ;(println "Q = " Q)
            ; R = Math.cos(P/3)
            (setq R (cos (div P 3)))
            ;(println "R = " R)
            ; S = Math.sqrt(3) * Math.sin(P/3)
            (setq S (mul (sqrt 3) (sin (div P 3))))
            ;(println "S = " S)
            ; T = (b/(3*a)) * (-1)
            (setq T (sub 0 (div b (mul 3 a))))
            ;(println "T = " T)
            ; x1 = 2*N*Math.cos(P/3) - (b/(3*a))
            (setq x1 (sub (mul 2 N (cos (div P 3))) (div b (mul 3 a))))
            ; x2 = Q * (R + S) + T
            (setq x2 (add T (mul Q (add R S))))
            ; x3 = Q * (R - S) + T;
            (setq x3 (add T (mul Q (sub R S)))))
          (true (println "errore"))
    );cond
    (list x1 i1 x2 i2 x3 i3)
  );local
)

; calcola anche le potenze di numeri negativi
(define (my-pow x n)
  (if (< x 0)
      (sub 0 (pow (sub 0 x) n)) ;cambio segno a x, calcolo la potenza, cambio segno al risultato
      (pow x n)))

Vediamo alcuni esempi:

; una radice reale e due radici complesse
; (x-2)*(x-(2+8i))*(x-(2-8i)) = 0
; x^3 - 6x^2 + 76x - 136 = 0
(solve-cubic 1 -6 76 -136)
;-> (2 0 2 7.999999999999999 2 -7.999999999999999)

; tre radici reali coincidenti
; (x - 2)*(x - 2)*(x - 2) = 0
; x^3 - 6 x^2 + 12 x - 8 = 0
(solve-cubic 1 -6 12 -8)
;-> (2 0 2 0 2 0)

; tre radici reali distinte
; (x-1)*(x+4)*(x-2) = 0
; x^3 + x^2 - 10 x + 8 = 0
(solve-cubic 1 1 -10 8)
;-> (2 0 -4 0 1 0)

; una radice reale e due radici complesse
; 3x^3 - 2x^2 + 4x - 3 = 0
(solve-cubic 3 -2 4 -3)
;-> (0.7263732804864121 0 -0.02985330690987276 1.172949872052025 -0.02985330690987276 -1.172949872052025)


Numeri Brutti
-------------

I numeri Brutti sono numeri positivi i cui fattori primi includono solo 2, 3, 5. Ad esempio, 6, 8
sono brutti mentre 14 non è brutto in quanto include un altro fattore primo 7. Notare che 1 è
trattato come un numero brutto.
Scrivere un programma per trovare l'n-esimo numero Brutto.

Prima scriviamo una funzione per verificare se un dato numero è un numero Brutto:

(define (brutto? num)
  (cond ((= 0 num) nil)
        ((= 1 num) true)
        ((= 0 (% num 2)) true)
        ((= 0 (% num 3)) true)
        ((= 0 (% num 5)) true)
  )
)

(map brutto? (sequence 1 10))
;-> (true true true true true true nil true true true)

Poi scriviamo il programma per trovare l'n-esimo numero Brutto:

(define (brutto num)
  (local (conta out)
    (setq out '())
    (setq conta 0)
    (setq n 0)
    (while (< conta num)
      (if (brutto? n) (begin (++ conta) (push n out -1)))
      (++ n)
    )
    (last out)
  )
)

(brutto 10)
;-> 12

(brutto 10000)
;-> 13635


Numeri poligonali
-----------------

Un numero poligonale è un numero che può essere rappresentato mediante uno schema geometrico regolare in modo da raffigurare un poligono regolare.

I numeri poligonali derivano dalle seguenti operazioni:

1 + 1 + 1 + 1 + 1 + ...    genera numeri interi       1, 2, 3, 4, 5 ...
1 + 2 + 3 + 4 + 5 + ...    genera numeri triangulari  1, 3, 6, 10, 15 ...
1 + 3 + 5 + 7 + 9 + ...    genera numeri quadrati     1, 4, 9, 16, 25 ...
1 + 4 + 7 + 10 + 13 + ...  genera numeri pentagonali  1, 5, 12, 22, 35 ...
1 + 5 + 9 + 13 + 17 + ...  genera numeri esagonali    1, 6, 15, 28, 45 ...
1 + 6 + 11 + 16 + 21 + ... genera numeri eptagonali   1, 7, 18, 34, 55 ...
1 + 7 + 13 + 19 + 25 + ... genera numeri ottagonali   1, 8, 21, 40, 65 ...

Formule:
numeri triangolari = (n * (n - 1))/2
numeri quadrati    = n * n
numeri pentagonali = (n * (3*n - 1))/2
numeri esagonali   = n * (2*n - 1)
numeri eptagonali  = (5*n*n - 3*n)/2
numeri ottagonali  = (3*n*n - 2*n)
...
numeri p-gonali = p*n*(n - 1)/2 - n*(n - 2)

I numeri triangolari possono essere ottenuti anche in modo ricorsivo:

T(1) = 1
T(n) = T(n-1) + n per n > 1

Definiamo una funzione che calcola il numero n-esimo del numero poligonale con p lati:

(define (numpoligonale p n)
  (- (/ (* p n (- n 1)) 2) (* n (- n 2)))
)

(numpoligonale 3 2)
;-> 3

(numpoligonale 3 3)
;-> 6

(numpoligonale 8 5)
;-> 65

Adesso definiamo una funzione che costruisce una lista di n numeri poligonali con p lati:

(define (numpoligonale-list tipo num)
  (local (out)
    (setq out '())
    (for (x 1 num)
       ;(println out)
       (extend out (list(numpoligonale tipo x)))
    )
    ;(reverse _out)
  )
)

(numpoligonale-list 3 20)
;-> (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210)

(numpoligonale-list 6 10)
;-> 1 6 15 28 45 66 91 120 153 190)

Nota: Ogni numero esagonale è anche un numero triangolare.

(numpoligonale-list 4 10)
;-> (1 4 9 16 25 36 49 64 81 100)


Torre di Hanoi
--------------

La Torre di Hanoi è un rompicapo matematico composto da tre paletti e un certo numero di dischi di grandezza decrescente, che possono essere infilati in uno qualsiasi dei paletti.

               paletto A              paletto B           paletto C

                   ||                    ||                  ||
                   ||                    ||                  ||
                   ||                    ||                  ||
                +------+                 ||                  ||
disco 1         +------+                 ||                  ||
                   ||                    ||                  ||
             +------------+              ||                  ||
disco 2      +------------+              ||                  ||
                   ||                    ||                  ||
          +------------------+           ||                  ||
disco 3   +------------------+           ||                  ||
                   ||                    ||                  ||

Il gioco inizia con tutti i dischi incolonnati su un paletto in ordine decrescente (il disco più piccolo si trova in cima). Lo scopo del gioco è spostare tutti i dischi su un paletto diverso potendo muovere solo un disco alla volta e potendo mettere un disco solo su un altro disco più grande, mai su uno più piccolo.
Il gioco fu inventato nel 1883[1] dal matematico francese Edouard Lucas. La leggenda narra che in un tempio Indù alcuni monaci sono impegnati a spostare su tre colonne di diamante 64 dischi d'oro secondo le regole della Torre di Hanoi: quando i monaci completeranno il lavoro, il mondo finirà.
La proprietà matematica base è che il numero minimo di mosse necessarie per completare il gioco è (2^n - 1), dove n è il numero di dischi. Ad esempio con 3 dischi, il numero minimo di mosse vale 7. Quindi i monaci di Hanoi dovrebbero effettuare almeno 18.446.744.073.709.551.615 mosse prima che il mondo finisca (n = 64).
La soluzione generale è data dal seguente algoritmo ricorsivo.
Identifichiamo i paletti con le lettere A, B e C, e i dischi con i numeri da 1 (il più piccolo) a n (il più grande). I passi necessari sono:
 - Spostare i primi n-1 dischi da A a B. (Questo lascia il disco n da solo sul paletto A)
 - Spostare il disco n da A a C
 - Spostare n-1 dischi da B a C
Per spostare n dischi si richiede di compiere un'operazione elementare (spostamento di un singolo disco) ed una complessa, ossia lo spostamento di n-1 dischi. Tuttavia anche questa operazione si risolve nello stesso modo, richiedendo come operazione complessa lo spostamento di n-2 dischi. Iterando questo ragionamento si riduce il processo complesso ad uno elementare, ovvero lo spostamento di n - (n-1) = 1 disco.
Questo algoritmo ha una complessità esponenziale.
Si può dimostrare che la Torre di Hanoi è risolvibile per qualsiasi valore di "n".

La seguente funzione risolve la torre di hanoi:

(define (solve-hanoi n from to using)
  (cond ((> n 0)
         (solve-hanoi (- n 1) from using to)
         (println "da " from " a " to)
         (solve-hanoi (- n 1) using to from))
         (true nil)
  )
)

(solve-hanoi 3 1 3 2)
;-> da 1 a 3
;-> da 1 a 2
;-> da 3 a 2
;-> da 1 a 3
;-> da 2 a 1
;-> da 2 a 3
;-> da 1 a 3
;-> nil


Indovina il numero
------------------

Si tratta di un gioco con due giocatori, il primo pensa ad un numero da 1 a 100 (ad esempio 45).
Il secondo giocatore prova ad indovinare il numero (ad esempio con 40).
Il primo giocatore deve dire se il numero proposto è "uguale" (fine del gioco) "maggiore" (bigger) o "minore" (smaller) del numero che pensato. A questo punto il secondo giocatore propone un nuovo numero, il primo risponde e si continua in questo modo fino a quando non viene indovinato il numero pensato.
Scrivere un programma in cui il computer cerca di indovinare il numero da voi pensato.

(define (indovina-numero)
  (>> (+ small big))) ; restituisce il valore (small + big)/2

(define (smaller)
  (setf big (dec (indovina-numero)))
  (indovina-numero))

(define (bigger)
  (setf small (inc (indovina-numero)))
  (indovina-numero))

(define (inizia-gioco)
  (setf small 1)
  (setf big 100)
  (indovina-numero))

Supponiamo di aver scelto il numero 80 e iniziamo il gioco:

(inizia-gioco)
;-> 50    ; il computer prova con 50
(bigger)  ; il nostro numero è più grande
;-> 75    ; il computer prova con 75
(bigger)  ; il nostro numero è più grande
;-> 88    ; il computer prova con 88
(smaller) ; il nostro numero è più piccolo
;-> 81    ; il computer prova con 88
(smaller) ; il nostro numero è più piccolo
;-> 78    ; il computer prova con 88
(bigger)  ; il nostro numero è più grande
;-> 79    ; il computer prova con 88
(bigger)  ; il nostro numero è più grande
;-> 80    ; il computer ha indovinato il nostro numero


Il problema Monty Hall
----------------------

Si tratta di un gioco in cui vengono mostrate al concorrente tre porte chiuse. Dietro ad una si trova il premio, mentre ciascuna delle altre due sono vuote. Il giocatore può scegliere una delle tre porte, vincendo il premio corrispondente. Dopo che il giocatore ha selezionato una porta, ma non l'ha ancora aperta, il conduttore del gioco – che conosce ciò che si trova dietro ogni porta – apre una delle altre due, rivelando una delle due porte vuote, e offre al giocatore la possibilità di cambiare la propria scelta iniziale, passando all'unica porta restante.
Quale comportamento del giocatore (cambiare la porta o rimanere con la scelta iniziale) massimizza la probabilità di vincere il premio?
La soluzione può essere ottenuta in diversi modi (Teorema di Bayes, Diagrammi di Venn, Teorema della probabilità totale), ma noi cercheremo di risolvere il problema tramite la scrittura di funzioni che calcolano le probabilità delle diverse azioni.

Iniziamo con la funzione che cambia sempre la prima scelta:

(define (monty-cambiaporta n)
  (setq vincita 0)
  (dotimes (i n)
    (setq premio (+ 1 (rand 3)))      ; il premio si trova in 1 o 2 o 3
    (setq scelta (+ 1 (rand 3)))      ; la prima scelta vale 1 o 2 o 3
    ; se il premio è diverso dalla scelta, allora abbiamo vinto.
    ; Questo perchè abbiamo scelto sempre di cambiare la scelta con la porta che rimane.
    ; Ricorda che il conduttore elimina sempre una porta vuota,
    ; quindi se non abbiamo indovinato con la prima scelta, cambiando abbiamo sicuramente vinto.
    (if (!= premio scelta) (++ vincita))
  )
  (setq prob-vincita (mul (div vincita n) 100)) ; calcoliamo la percentuale di vincite
)

(monty-cambiaporta 10000)
;-> 66.25 ;il risultato teorico vale 2/3 = 0.666666 [66.66 %]

Adesso scriviamo la funzione che tiene sempre la prima scelta (non cambia mai la porta):

(define (monty-tieneporta n)
  (setq vincita 0)
  (dotimes (i n)
    (setq premio (+ 1 (rand 3)))      ; il premio si trova in 1 o 2 o 3
    (setq scelta (+ 1 (rand 3)))      ; la prima scelta vale 1 o 2 o 3
    ; se il premio è uguale alla scelta, allora abbiamo vinto.
    (if (= premio scelta) (++ vincita))
  )
  (setq prob-vincita (mul (div vincita n) 100)) ; calcoliamo la percentuale di vincite
)

(monty-tieneporta 10000)
;-> 33.42  ;il risultato teorico vale 1/3 = 0.333333 [33.33 %]

Teoricamente cambiare la porta migliora la probabilità del giocatore di vincere il premio, portandola da 1/3 a 2/3.


Il problema del compleanno
--------------------------

Considerando n persone, quanto vale la probabilità che due persone compiano gli anni nello stesso giorno?
Il problema del compleanno è stato concepito nel 1939 da Richard von Mises.

Per effettuare il calcolo, si ricorre alla formula per la probabilità condizionata con le seguenti ipotesi:
- gli anni sono tutti di 365 giorni
- i giorni dell'anno sono tutti equiprobabili

Il modo più semplice per calcolare la probabilità P(n) che ci siano almeno due persone di un gruppo di n persone che compiano gli anni lo stesso giorno è calcolare dapprima la probabilità P1(n) che ciò non accada. Il ragionamento è questo: data una qualunque persona del gruppo (indipendentemente dalla data del suo compleanno), vi sono 364 casi su 365 in cui il compleanno di una seconda persona avvenga in un giorno diverso, se si considera una terza persona, ci sono 363 casi su 365 in cui compie gli anni in un giorno diverso dalle prime due persone e via dicendo.
In formule, la probabilità che tutti gli n compleanni cadano in date diverse vale:

        364   363         365-n+1           364!
P1(n) = --- * --- * ... * ------- = ----------------------
        365   365           365     365^(n-1) * (365 - n)!

Quindi la probabilità del suo evento complementare, cioè che esistano almeno due compleanni uguali, vale:

                               364!
P(n) = 1 - P1(n) = 1 - ---------------------- =
                       365^(n-1) * (365 - n)!

Definiamo la funzione fattoriale (per i numeri big integer):

(define (fattoriale n)
  (setq fact 1L)
  (for (x 1L n)
    (setq fact (* fact x))
  );for end
)

La seguente funzione calcola il valore di x!/y! (con x > y)

(define (fattoriali-semplifica x y)
  (setq fact 1L)
  (for (i x (+ 1 y))
    (setq fact (* fact i))
  );for end
)

(fattoriali-semplifica 300 200)
;-> 38807387193016483645683371924167275439580023008808434498936549308160840242981998
;-> 71839239153657492092277838092154244528689124699666247577409105786352279708206119
;-> 37899469540337072285732213325595760757119468974039367680000000000000000000000000L

(/ (fattoriale 300) (fattoriale 200))
;-> 38807387193016483645683371924167275439580023008808434498936549308160840242981998
;-> 71839239153657492092277838092154244528689124699666247577409105786352279708206119
;-> 37899469540337072285732213325595760757119468974039367680000000000000000000000000L

(- (fattoriali-semplifica 300 200) (/ (fattoriale 300) (fattoriale 200)))
;-> 0L

Definiamo la funzione potenza (per i numeri big integer):

(define (potenza n m)
  (setq pot 1L)
  (dotimes (x m)
    (setq pot (* pot n))
  )
  pot
)

;-> 81402749386839761113321L

Adesso possiamo scrivere la funzione finale che calcola le probabilità del problema del compleanno:

(define (compleanno n)
  (setq num (fattoriali-semplifica 364 (- 365 n)))
  (setq den (potenza 365 (- n 1)))
  (sub 1 (div num den))
)

Più concisamente:

(define (compleanno n)
  (sub 1 (div (fattoriali-semplifica 364 (- 365 n)) (potenza 365 (- n 1))))
)

(compleanno 22)
0.4756953076625502

(compleanno 23)
;-> 0.5072972343239853

(compleanno 30)
;-> 0.7063162427192686

(compleanno 50)
;-> 0.9703735795779884

(compleanno 100)
;-> 0.9999996927510721

I risultati ci dicono che la probabilità che almeno due persone in un gruppo compiano gli anni lo stesso giorno è molto superiore a quanto si potrebbe pensare intuitivamente:
infatti già con 23 persone la probabilità è circa 0.51,
con 30 persone essa supera 0.70,
con 50 persone arriva addirittura a 0.97,
con 100 persone siamo quasi sicuri 0.99999969.
(comunque per ottenere l'evento certo occorre considerare un gruppo di almeno 366 persone)


Algoritmo di Karatsuba
----------------------

L'algoritmo di Karatsuba (1960) è un algoritmo di moltiplicazione rapida per moltiplicare numeri interi. La sua complessità è  O(n^log2(3)) (circa O(n^1.585)) mentre la complessità della moltiplicazione normale vale O(n^2). Il metodo di Karatsuba è asintoticamente molto più veloce.

Prendiamo due numeri, x e y.
Esempio: 12345 e 6789.
Troviamo una base b e potenza m per separarli.
Usiamo la base = 10 con m che vale la metà della lunghezza delle cifre dei numeri.
In questo caso, m sarà 2, quindi 10 ^ 2 = 100. Divideremo i 2 numeri usando questo moltiplicatore.
La forma che vogliamo è:

x = x1*b^m + x0
y = y1*b^m + y0

Utilizzando l'esempio:

x1 = 123
x0 = 45

y1 = 67
y2 = 89

b = 10 e m = 2

Quindi:

12345 = 123 * 10^2 + 45
6789 = 67 * 10^2 + 89

L'algoritmo ricorsivo è il seguente:

Se x < 10 o y < 10, restituire x * y. La moltiplicazione a una cifra è il caso base.
Altrimenti:
Sia z2 = karatsuba(x1, y1). x1 e y1 sono le cifre più significative (le variabili locali "alte").
Sia z0 = karatsuba(x0, y0). x0 e y0 sono le cifre meno significative (le variabili locali "basse").
Sia z1 = karatsuba (x1 + y0, x0 + y1) - z0 - z2.

E il risultato è la seguente somma: z2 * b^2m + z1 * b^m + z0

Definiamo la funzione potenza per i numeri interi:

(define (potenza n m)
  (local (pot)
    (setq pot 1)
    (dotimes (x m) (setq pot (* pot n)))
    pot
  )
)

(potenza 3 6)
;-> 729

Definiamo la funzione che implementa l'algoritmo di karatsuba:

(define (karatsuba num1 num2)
  (local (m m2 high1 low1 high2 low2 z0 z1 z2)
    (cond ((or (< num1 10) (< num2 10)) (* num1 num2))
          (true
            (setq m (max (length (string num1)) (length (string num2))))
            (setq m2 (/ m 2))
            (setq n1$ (string num1))
            (setq n2$ (string num2))
            (setq high1 (int (slice n1$ 0 (- (length n1$) m2))))
            (setq low1  (int (slice n1$ (- (length n1$) m2) m2)))
            (setq high2 (int (slice n2$ 0 (- (length n2$) m2))))
            (setq low2  (int (slice n2$ (- (length n2$) m2) m2)))
            ;(println high1 { } low1)
            ;(println high2 { } low2)
            (setq z0 (karatsuba low1 low2))
            (setq z1 (karatsuba (+ low1 high1) (+ low2 high2)))
            (setq z2 (karatsuba high1 high2))
            (+ (* z2 (potenza 10 (* m2 2))) (* (- z1 z2 z0) (potenza 10 m2)) z0)
          )
    )
  );local
)

(>> 12345)
(karatsuba 12 12)
;-> 144

(karatsuba 13 17)
;-> 221

(karatsuba 120 11)
;-> 1320

(karatsuba 12345 6789)
;-> 83810205

(mul 12345 6789)
;-> 83810205

Ecco un'altra implementazione dell'algoritmo di Karatsuba:

(define (karatsuba x y)
    (karatsuba1 x y 256)  ; in generale, opportuna potenza di 2 p (x , y < 2p)
)

(define (karatsuba1 x y p)  ; x, y, p: interi non negativi, p potenza di 2
    (if (= p 1)
        (* x y)
        (let ((x1 (/ x p)) (x0 (% x p))
              (y1 (/ y p)) (y0 (% y p))
              (q (/ p 2)))
          (let ((z2 (karatsuba1 x1 y1 q))
                (z0 (karatsuba1 x0 y0 q)))
            (let ((z1 (- (karatsuba1 (+ x1 x0) (+ y1 y0) q) (+ z2 z0))))
              (+ (* z2 p p) (* z1 p) z0)
            )
          )
        )
     )
)

(karatsuba 12 12)
;-> 144

(karatsuba 12345 6789)
;-> 83810205

Nota:
Nel caso di rappresentazioni binarie le operazioni di quoziente e prodotto relativi a una potenza di 2 (2^k) si riducono  semplicemente a spostamenti (right/left shift) di k cifre.
Analogamente, il resto della divisione per 2^k corrisponde alla selezione delle ultime k cifre.


Formati A0, A1, A2, A3, A4, ...
-------------------------------

Formato A0:
Similitudine rettangoli:   s(1)/s(0) = s(2)/s(1) = s(0)/2s(1)
Superficie convenzionale:  s(0)*s(1) = A(0) = 1 mq = 10000 cmq

Lato maggiore formato A0 in cm:
(setq s0 (mul 100 (pow 2 (div 1 4))))
;-> 118.9207115002721

Lato minore formato A0 in cm:
(setq s1 (mul 100 (pow 2 (div -1 4))))
;-> 84.08964152537145

Lato maggiore dei fogli in formato Ak:  s(k)

  s(k+2) = s(k) / 2
  s(0) = s0 = 118.9207115002721
  s(1) = s1 = 84.08964152537145

(define (lato k)
; lato: numero reale (misura lato)
; k: numero naturale (indice formato)
    (if (< k 2)
        (if (= k 0) s0 s1)      ; misure conosciute
        (div (lato (- k 2)) 2)  ; piegando due volte la lunghezza dei lati si dimezza
    )
)

(define (formato k)
  (local (s0 s1)
    (setq s0 (mul 100 (pow 2 (div 1 4))))
    (setq s1 (mul 100 (pow 2 (div -1 4))))
    (list (lato (+ k 1)) (lato k))
  )
)

Esempio: lati formato A4
(formato 4)
;-> (21.02241038134286 29.73017787506803)

Esempio: lati formato A2
(formato 2)
;-> (42.04482076268572 59.46035575013605)

Esempio: lati formato A0
(formato 0)
;-> (84.08964152537145 118.9207115002721)


Moltiplicazione del contadino russo
-----------------------------------

Si esegue per mezzo di raddoppi e dimezzamenti successivi.
Esempio: 83x154. Si dimezza il numero 83 (considerando i valori interi) e si raddoppia il 154. Si sommano le righe della colonna del 154 corrispondenti alle righe dispari nella colonna del numero 83. Totale: 12782.

      dispari  -->  83  |   154  <--
      dispari  -->  41  |   308  <--
                    20  |   616
                    10  |  1232
      dispari  -->   5  |  2464  <--
                     2  |  4928
      dispari  -->   1  |  9856  <--
                         -------
154 + 308 + 2464 + 9856 = 12782

(* 83 154)
;-> 12782

(+ 154 308 2464 9856)
;-> 12782

;; Algoritmo del contadino Russo per la moltiplicazione:

(define (moltiplicazione-russa a b)
  (molt-russa a b 0L))

(define (molt-russa x y z)
    (cond ((= y 0) z)
          ((even? y) ; y pari
           (molt-russa (* 2L x) (/ y 2L) z))
          (true      ; y dispari
           (molt-russa (* 2L x) (/ y 2L) (+ z x))
          )
    ) ; valore risultante: z + xy
)

(moltiplicazione-russa 12 12)
;-> 144L

(moltiplicazione-russa 12345 6789)
;-> 83810205L

(moltiplicazione-russa 12345232332323 6782323232323239)
;-> 83729356055942287981803754197L

(time (moltiplicazione-russa 12345232332323 6782323232323239) 100000)
;-> 2406.6

Notiamo che la nostra funzione è ricorsiva di coda, quiondi possiamo usare la tecnica di "memoization":

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(define (moltiplicazione-russa-m a b)
  (molt-russa-m a b 0L))

(memoize molt-russa-m (lambda (x y z)
    (cond ((= y 0L) z)
          ((even? y) ; y pari
           (molt-russa-m (* 2L x) (/ y 2L) z))
          (true      ; y dispari
           (molt-russa-m (* 2L x) (/ y 2L) (+ z x))
          )
    ) ; valore risultante: z + xy
))

(moltiplicazione-russa-m 12 12)
;-> 144L

(moltiplicazione-russa-m 12345 6789)
;-> 83810205L

(moltiplicazione-russa-m 12345232332323 6782323232323239)
;-> 83729356055942287981803754197L

(time (moltiplicazione-russa-m 12345232332323 6782323232323239) 100000)
;-> 328.118

Con la tecnica di memoization la nostra funzione è diventata 7 volte più veloce.


Distanza di Manhattan
---------------------

Date le coordinate di due punti su una griglia (scacchiera), determinare la loro distanza minima (distanza di manhattan) e il numero di percorsi tra i due punti con distanza minima.
È possibile muoversi solo lungo gli assi x e y (solo in verticale e in orizzontale, non in diagonale)

Esempio:

Punto A = (ax,ay) = (4,3)
Punto B = (bx,by) = (2,1)

 4 +--+--+--+--+--+
   |  |  |  |  |  |
 3 +--+--+--+--A--+
   |  |  |  |  |  |
 2 +--+--+--+--+--+
   |  |  |  |  |  |
 1 +--+--B--+--+--+
   |  |  |  |  |  |
 0 +--+--+--+--+--+
   0  1  2  3  4  5

distanza di manhattan = somma del valore assoluto delle differenze delle coordinate.
distanza di manhattan = abs(bx - ax) + abs(by - ay)
distanza di manhattan = (+ (abs (- 2 4)) (abs (- 1 3))) = 4

Quanti percorsi esistono che vanno da A a B e hanno lunghezza 4?

Notiamo che la distanza è simmetrica, cioè dist(A,B) = dist(B,A), quindi possiamo supporre di spostarci solo verso "destra" e verso l'"alto".
Quello che ci interessa è la distanza tra le coordinate:
dist(x) = abs(bx-ax) = 2
dist(y) = abs(by-ay) = 2

Adesso scriviamo una funzione ricorsiva che utilizza questi valori di distanza per calcolare il numero totale dei percorsi minimi tra i due punti.
Poichè ogni volta ci dobbiamo muovere a destra o verso l'alto possiamo richiamare la stesse funzioni con uno dei parametri (destra o alto) diminuito di 1. Queste funzioni vengono chiamate tante volte quanto vale la distanza tra le coordinate. Facendo la somma di queste funzioni otteniamo il numero di percorsi minimi.

La funzione ricorsiva per il calcolo dei percorsi è la seguente:

(define (percorsi-manhattan alto destra);
    (if (or (= alto 0) (= destra 0)) 1
        (+ (percorsi-manhattan (- alto 1) destra)
           (percorsi-manhattan alto (- destra 1)))
    )
)

(percorsi-manhattan 2 2)
;-> 6

(define (manhattan x1 y1 x2 y2)
  (list
    (+ (abs (- x2 x1)) (abs (- y2 y1)))
    (percorsi-manhattan (abs (- x2 x1)) (abs (- y2 y1)))
  )
)

(manhattan 4 3 2 1)
;-> (4 6)

(manhattan 1 1 10 10)
;-> (18 48620)


Modello di crescita di una popolazione di conigli
-------------------------------------------------

Questo modello è stato discusso nel libro "Liber Abbaci" di Leonardo Pisano (Fibonacci) scritto nell'anno 1202.

- All'istane iniziale t=0 c'e' una coppia di conigli fertili
- I conigli nati all'istante t diventano fertili esattamente dopo un mese, all'istante t+1
- Una coppia di conigli fertile all'istante t genera una nuova coppia di conigli ad ogni mese successivo t+1, t+2, ...
- I conigli non muoiono nell'intervallo di tempo considerato
- I conigli nascono sempre a coppie: un maschio e una femmina.

Quante coppie di conigli ci saranno dopo un anno?

Stiamo parlando del numero di Fibonacci:

(define (coppie-fertili n)       ; valore: naturali
    (if (= n 0) 1
        (+ (nascita-nuove-coppie (- n 1)) (coppie-fertili (- n 1)))
    )
)

(define (nascita-nuove-coppie n)
    (if (= n 0) 0
        (coppie-fertili (- n 1))
    )
)

(for (x 1 10) (print (coppie-fertili x) { }))
;-> 1 2 3 5 8 13 21 34 55 89

Il numero di conigli al mese x è dato da C(x+1) (dove C è la funzione coppie-fertili):

(define (num-conigli mese)
  (coppie-fertili (add mese 1)))

(for (x 1 12) (print (num-conigli x) { }))
;-> 2 3 5 8 13 21 34 55 89 144 233 377

(time (num-conigli 35)) ;24157817
;-> 14656.997 ;14.7 secondi

La funzione è lenta possiamo utilizzare la macro "memoize" oppure scrivere una funzione iterativa. Vediamo entrambi i casi per la formula di Fibonacci: F(n+2) = F(n+1) + F(n)

Versione memoized:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(define (fibo n)
  (if (< n 2) 1
    (+ (fibo (- n 1)) (fibo (- n 2)))))

(memoize fibo-m
  (lambda (n)
    (if (< n 2) 1
      (+ (fibo-m (- n 1)) (fibo-m (- n 2))))))

(define (num-conigli mese)
  (fibo-m (add mese 2)))

(for (x 1 12) (print (num-conigli x) { }))
;-> 2L 3L 5L 8L 13L 21L 34L 55L 89L 144L 233L 377L

(num-conigli 35)
;-> 24157817L

(time (num-conigli 35))
;-> 0

Versione iterativa:

(define (fibo-i n)
  (local (a b c lim)
    (setq a 0L b 1L c 0L)
    (setq lim (- n 1))
    (for (i 0 lim)
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

(define (num-conigli mese)
  (fibo-i (add mese 2)))

(for (x 1 12) (print (num-conigli x) { }))
;-> 2L 3L 5L 8L 13L 21L 34L 55L 89L 144L 233L 377L

(num-conigli 35)
;-> 24157817L

(time (num-conigli 35))
;-> 0

Con la versione iterativa il calcolo è immediato.


Il gioco dei salti
------------------
Dato una lista di numeri interi non negativi, si è inizialmente posizionati nel primo indice della lista. Ogni elemento della lista rappresenta la massima lunghezza di salto in avanti da quella posizione. La funzione deve restituire il numero minimo di passi per raggiungere la fine della lista oppure "nil" se non è possibile raggiungere la fine della lista (cioè l'ultimo indice).
Ad esempio:
A = (2 3 1 1 4) restituisce 2.
A = (3 2 1 0 4) restituisce falso.
A = (3 2 2 0 4) restituisce true.

Dobbiamo calcolare l'indice massimo che può essere raggiunto.
Possiamo avere due casi:
1) dalla posizione attuale non è possibile raggiungere la prossima posizione
2) dalla posizione attuale è possibile raggiungere la prossima posizione (in questo caso occorre controllare se abbiamo raggiunto la fine della lista).
Dalla posizione "i" l'indice più grande che può essere raggiunto vale: i + A(i).

Ecco un esempio
idx 0 1 2 3 4
A   3 2 1 0 4
max 3 3 3 0

(define (salto? lst)
  (local (lun idxMax passi)
    (cond ((<= (length lst) 1) 0) ;siamo già alla fine della lista
          (true
           (setq idxMax (lst 0))
           (setq passi 0)
           (setq lun (length lst))
           (for (i 0 (sub lun 1) 1 (or (and (<= idxMax i) (= (lst i) 0)) (>= idxMax (sub lun 1))))
              (if (> (add i (lst i)) idxMax)
                (begin
                ; aggiorno idxMax e passi
                  (setq idxMax (add i (lst i)))
                  (setq passi (add passi 1)))
              )
           )
           ; controllo della posizione finale
           (if (>= idxMax (sub lun 1))
               (setq passi (add passi 1))
               nil
           )
          );true
     );cond
  );local
)

Da notare l'espressione (or (and (<= idxMax i) (= (lst i) 0)) (>= idxMax (sub lun 1))) che fa uscire dal ciclo for quando:

(and (<= idxMax i) (= (lst i) 0)) non possiamo procedere e non abbiamo raggiunto la fine

oppure

(>= idxMax (sub lun 1)) siamo arrivati alla fine della lista.

(salto? '(2 3 1 1 4))
;-> 2
(salto? '(3 2 1 0 4))
;-> nil
(salto? '(3 2 2 0 4))
;-> 2
(salto? '(1 2 3 0 5))
;-> 3
(salto? '(6 2 3 0 0 0 1 5))
;-> 2
(salto? '(1 2 5 1 1 1 1 1))
;-> 3


======================================================================
 DOMANDE PER ASSUNZIONE DI PROGRAMMATORI (coding interview questions)
======================================================================

Swap di due variabili (McAfee)
------------------------------
Come scambiare il valore di due variabili senza utilizzare una variabile di appoggio?

Primo metodo (somma/sottrazione):

Vediamo il funzionamento algebrico:
a = 1
b = 2

a = a + b --> a = a + b = 3 e b = 2
b = a - b --> b = ((a + b) - b) = 1 e a = 3
a = a - b --> a = (a + b) - ((a + b) - b) = 2

(setq a 1 b 2)
(println {a = } a { - b = } b)
;-> a = 1 - b = 2
(setq a (+ a b))
(setq b (- a b))
(setq a (- a b))
(println {a = } a { - b = } b)
;->  a = 2 - b = 1

(define (scambia x y)
  (setq x (+ x y))
  (setq y (- x y))
  (setq x (- x y))
  (list x y)
)

(scambia 2 3)
;-> (3 2)
(scambia -2 -3)
;-> (-3 -2)

Secondo metodo (map):

(setq a 1 b 2)
(println {a = } a { - b = } b)
;-> a = 1 - b = 2
(map set '(a b) (list b a))
(println {a = } a { - b = } b)
;-> a = 2 - b = 1

Terzo metodo (xor):

(setq a 5 b 10)
(setq a (^ a b))
;-> 15
(setq b (^ a b))
;-> 5
(setq a (^ a b))
;-> 10

Ricordiamo che lo XOR ha la seguente tabella di verità:

x y | out
---------
0 0 |  0
0 1 |  1
1 0 |  1
1 1 |  0

Quando si applica lo XOR a due variabili, i bit della prima variabile vengono utilizzati per alternare i bit nell'altro. A causa della natura di questo cambiamento, non importa quale variabile venga usata per alternare l'atra poichè i risultati sono gli stessi. Lo stesso bit nella stessa posizione in entrambi i numeri produce uno 0 in quella posizione nel risultato. I bit opposti producono un 1 in quella posizione.

(setq a (^ a b))
a è ora impostato sulla maschera di bit combinata di a e b. b ha ancora il valore originale.

(setq b (^ a b))
b è ora impostato sulla maschera di bit combinata di (a XOR b) e b. La b si cancella, quindi ora b è impostato sul valore originale di a. a è ancora impostato sulla maschera di bit combinata di a e b.

(setq a (^ a b))
a è ora impostato sulla maschera di bit combinata di (a XOR b) e a. (ricorda, b contiene effettivamente il valore originale di a adesso) La a si cancella, e quindi a è ora impostato sul valore originale di b.

Scriviamo la funzione (dobbiamo controllare che le variabili non contengano lo stesso numero, altrimenti il risultato sarebbe zero per entrambe):

(define (scambia x y)
  (cond ((= x y) (list x y))
        (true (setq x (^ x y))
              (setq y (^ x y))
              (setq x (^ x y))
              (list x y)
        )
  )
)

(scambia 5 25)
;-> (25 5)

(scambia 15 5)
;-> (5 15)

Quarto metodo (newLISP):

(setq a 1 b 2)
;-> 2
(swap a b)
;-> 1
(list a b)
;-> (2 1)


Funzione "atoi" (McAfee)
------------------------
La funzione "atoi" del linguaggio C converte una stringa in un numero intero.
Implementare la funzione "atoi".

Le seguenti operazioni devono essere svolte:

1. stringa di input vuota o nulla
2. spazi vuoti nella stringa di input
3. segno +/-
4. calculare il valore della stringa
5. trattare i valori min & max

(define (atoi s)
  (local (flag i val)
    (cond ((or (null? s) (< (length s) 1)) 0) ; stringa nulla, valore nullo
          (true
            (setq s(trim s))
            (setq flag "+")
            (setq i 0)
            ; acquisizione segno
            (if (= (s 0) "-")
                (begin (setq flag "-") (++ i))
                (if (= (s 0) "+") (++ i))
            )
            (setq val 0)
            (while (and (> (length s) i) (>= (s i) "0") (<= (s i) "9"))
              (setq val (add (mul val 10) (sub (char (s i)) (char "0"))))
              (++ i)
            )
            ; controllo segno del risultato
            (if (= flag "-") (setq val (sub 0 val)))
            ; controllo overflow
            (if (> val 9223372036854775807) (setq val -9223372036854775808))
            (if (< val -9223372036854775808) (setq val 9223372036854775807))
          );true
    );cond
    (int val)
  );local
)

(atoi "9223372036854775808")
;-> -9223372036854775808
(int "9223372036854775808")
;-> -9223372036854775808

(atoi "-9223372036854775809")
;-> 9223372036854775807
(int "-9223372036854775809")
;-> 9223372036854775807

(atoi "123")
;-> 123
(int "123")
;-> 123

(atoi " -345hj5")
;-> -345
(int " -345hj5")
;-> -345

(atoi "")
;-> nil
(int "")
;-> nil

(atoi nil)
;-> nil
(int nil)
;-> nil


Somma di numeri in una lista (Google)
-------------------------------------
Data una lista di numeri e un numero k, restituire se due numeri dalla lista si sommano a k.
Ad esempio, dati (10 15 3 7) e k di 17, restituisce true da 10 + 7 che vale 17.
Bonus: puoi farlo in un solo passaggio?

Se vogliamo trovare la somma di ogni combinazione di due elementi di una lista il metodo più ovvio è  quello di creare due for..loop sulla lista e verificare se soddisfano la nostra condizione.
Tuttavia, in questi casi, puoi sempre ridurre la complessità O (n ^ 2) a O (log (n)) avviando il secondo ciclo dal corrente elemento della lista, perché, ad ogni passo del primo ciclo, tutti gli
elementi precedenti sono già confrontati tra loro.
Quindi la soluzione è iterare sulla lista e per ogni elemento cercare se qualsiasi elemento della lista successiva somma fino a 17.

(define (sol lst n)
  (local (out ll)
    (setq out nil)
    (setq ll (- (length lst) 1))
    (for (i 0 ll 1 (= out true)) ; se out vale true, allora esce dal for..loop
      (for (j i ll)
        (if (= n (add (nth i lst) (nth j lst)))
          (setq out true)
        )
      )
    )
    out
  )
)

(sol '(10 15 3 7) 17)
;-> true

(sol '(3 15 10 7) 17)
;-> true

(sol '(3 15 10 7) 21)
;-> nil


Aggiornamento di una lista (Uber)
---------------------------------
Data una lista di interi, restituire una nuova lista in modo tale che ogni elemento nell'indice i della nuova lista sia il prodotto di tutti i numeri nella lista originale tranne quello in i.
Ad esempio, se il nostro input fosse (1 2 3 4 5), l'uscita prevista sarebbe (120 60 40 30 24).
Se il nostro input fosse (3 2 1), l'output atteso sarebbe (2 3 6).
Se il nostro input fosse (3 2 1 0), l'output previsto sarebbe (0 0 0 6).
Se il nostro input fosse (0 3 2 1 0), l'output previsto sarebbe (0 0 0 0).

La soluzione intuitiva porta alla funzione seguente:

(define (sol1 lst)
  (setq out '())
  (dolist (i lst)
    (setq p 1)
    (setq idx $idx)
    (dolist (j lst)
      (if (!= idx $idx)
          (setq p (mul p j)))
    )
    ;(push p out)
    (push p out -1)
  )
)

(sol1 '(1 2 3 4 5))
;-> (120 60 40 30 24)

(sol1 '(1 0 3 4 5))
;-> (0 60 0 0 0)

(sol1 '(3 2 1 0))
;-> (0 0 0 6)

(sol1 '(1 0 3 0 5))
;-> (0 0 0 0 0)

Un altro metodo deriva dalla seguente osservazione: nella nuova lista il valore dell'elemento i vale il prodotto di tutti i numeri diviso il numero dell'elemento i. Ad esempio con una lista di tre elementi (a b c) otteniamo:

primo elemento:    a * b * c / a = b * c
secondo elemento:  a * b * c / b = a * c
terzo elemento:    a * b * c / c = a * b

Quindi dobbiamo calcolare il prodotto di tutti gli elementi della lista e poi dividere questo valore con il valore di ogni elemento. In questo modo otteniamo il prodotto di tutti gli elementi tranne quello corrente.
Adesso dobbiamo tenere conto degli elementi con valore zero:

1. Uno zero nella lista.
In questo caso, il risultato dovrebbe essere tutti zero tranne l'elemento che ha valore 0: questo elemento dovrebbe contenere il prodotto di tutti gli altri.

2. Due zeri o più nella lista.
Questo caso è più o meno come il primo, ma la lista risultante contiene sempre solo zeri. Perché 'cè sempre uno zero nel prodotto.

Per considerare questi due casi calcoliamo il prodotto di tutti gli elementi tranne quelli che hanno valore zero e contiamo anche quanti zeri ci sono nella lista.
Quindi se abbiamo due o più zeri nella lista iniziale, possiamo restituire una list con tutti zeri.
Altrimenti, iteriamo la lista per sostituire gli elementi che valgono zero con il prodotto che abbiamo calcolato e assegnare il valore zero a tutti gli altri elementi.

La funzione è la seguente:

(define (sol2 lst)
  (local (prod numzeri out)
    (if (< (length lst) 2) (setq out lst) ; lista con meno di due elementi --> lista
        (begin
          (setq out '())
          (setq prod 1)
          (setq numzeri 0)
          ; calcolo del prodotto degli elementi e del numero di zeri
          (dolist (el lst)
            (if (zero? el) (++ numzeri)
                (setq prod (mul prod el))
            )
          )
          (cond ((> numzeri 1) (setq out (dup 0 (length lst)))) ; restituisco una lista con tutti zeri
                ((= numzeri 1) (dolist (el lst)
                                  (if (zero? el) (push prod out -1) ; valore del prodotto sugli elementi che hanno valore zero
                                      (push 0 out -1) ; valore zero su tutti gli altri elementi
                                  )
                               )
                )
                (true (dolist (el lst)
                        (push (div prod el) out -1) ; assegnazione di prodotto / elemento
                      )
                )
          )
        );begin
    );if
    out
  );local
)

(sol2 '(1 2 3 4 5))
;-> (120 60 40 30 24)

(sol2 '(3 2 1))
;-> (2 3 6)

(sol2 '(3 2 1 0))
;-> (0 0 0 6)

(sol2 '(0 3 2 1 0))
;-> (0 0 0 0 0)


Ricerca numero su una lista (Stripe)
------------------------------------
Data una lista di numeri interi, trova il primo intero positivo mancante in tempo lineare e spazio costante. In altre parole, trova il numero intero positivo più basso che non esiste nelll lista. La lista può contenere anche duplicati e numeri negativi.
Ad esempio, l'input (3 4 -1 1) dovrebbe dare 2.
L'input (1 2 0) dovrebbe dare 3.
È possibile modificare la lista di input.

Possiamo notare che gli indici di una lista e i numeri interi sono la stessa cosa.
Quindi inseriamo ogni numero intero positivo di una lista al suo posto e poi iteriamo di nuovo per trovare il primo numero mancante. Se non troviamo il numero mancante (la lista è completa di tutti i numeri), allora restituiamo la lunghezza della lista.

(define (sol lst)
  (local (out ll)
    (setq out -1)
    (setq ll (- (length lst) 1))
    (dolist (el lst)
      (cond ((< el 0) nil) ; numero negativo: non fare niente
            ((>= el (length lst)) nil) ; numero oltre la lista: non fare niente
            (true   (setf (nth el lst) el))
      )
    )
    (for (x 1 ll 1 (!= out -1))
      (if (!= (nth x lst) x) (setq out x))
    )
    (if (= out -1) (setq out (+ ll 1)))
    (list out lst)
  )
)

(sol '(6 5 4 3 2 1 0))
;-> (7 (0 1 2 3 4 5 6))

(sol '(4 4 -1 1))
;-> (2 (4 1 -1 1))

(sol '(4 0 -1 1 2 5 7 9))
;-> (3 (0 1 2 1 4 5 7 7))


Decodifica di un messaggio (Facebook)
-------------------------------------
Data la mappatura a = 1, b = 2, ... z = 26 e un messaggio codificato, contare il numero di modi in cui può essere decodificato.
Ad esempio, il messaggio "111" restituirebbe 3, poiché potrebbe essere decodificato come "aaa" (1)(1)(1), "ka" (11)(1) e "ak" (1)(11).
Puoi presumere che i messaggi siano decodificabili. Per esempio, "001" non è permesso.

Molti dei problemi di analisi delle liste e delle stringhe sono basati sulla ricorsione.
Per iniziare è sempre utile risolvere manualmente alcuni casi banali, cercando di utilizzare i risultati di un caso precedente:

- se la lunghezza di una stringa è uno, c'è sempre un modo per decodificarlo,

"1": ("1")
----------
F ("1") = 1

- se la lunghezza è 2, abbiamo sempre un modo con tutte le cifre separatamente, più uno se un numero è inferiore a 26.

"12": ("1","2") e ("12")
------------------------
F ("12 ") = f ("12") + 1

- se la lunghezza è 3, possiamo usare i risultati del precedente calcoli, perché sappiamo già come affrontare le stringhe più brevi.

F ("123") = f ("1") * F ("23 ") + F ("12") * f ("3") = 3

- Tutti i casi successivi possono essere calcolati utilizzando le definizioni precedentemente definite:

F ("4123") = f ("4") * F ("123") + f ("41") * F ("23") = 3

Inoltre utilizzeremo una funzione (decodifica?) che ritorna "1" se la stringa è decodificabile e "0" altrimenti.

(define (sol s)
  (local (lun p)
    (setq lun (length s))
    (setq p (s 0))
    (cond ((= 1 lun) (decodifica? s))
          ((= 2 lun) (if (= p "0") (decodifica? s) (add (decodifica? s) 1)))
          (true (add (mul (decodifica? (slice s 0 1)) (sol (slice s 1)))
                     (mul (decodifica? (slice s 0 2)) (sol (slice s 2)))))
    )
  )
)

(define (decodifica? ss)
  (setq v (int ss 0 10))
  (if (= (s 0) "0") ; la forma "01" non è valida
      0
      (if (and (> v 0) (<= v 26))
          1
          0
      )
  )
)

(sol "111")
;-> 3

(sol "111233423421")
;-> 32

(sol "4123")
;-> 3

(sol "101")
;-> 1


Implementazione di un job-scheduler (Apple)
-------------------------------------------

Implementare un job scheduler che prende come parametri una funzione "f" e un intero "n" e chiama "f" dopo "n" millisecondi.

Definiamo una funzione che rende un numero pari o dispari in maniera casuale.

(define (g)
  (if (zero? (rand 2))
      ; se esce 0, allora diventa o rimane pari
      (if (odd? num)  (println "diventa pari: " (++ num))
                      (println "rimane pari: " num))
      ; se esce 1, allora diventa o rimane dispari
      (if (even? num) (println "diventa dispari: " (++ num))
                      (println "rimane dispari: " num))
  )
)

Definiamo il valore iniziale del numero:

(define num 1)

E infine scriviamo il nostro job-scheduler:

(define (job f n)
  ; funziona anche in questo modo perchè "num" è una variabile globale
  ; e viene vista anche dalla funzione "g".
  ;(setq num 1)
  (while true
    (sleep n)
    (g)
  )
)

Lanciamo il nostro job-scheduler che eseguirà la funzione "g" ogni 2 secondi:

(job fun 2000)
;-> rimane dispari: 1
;-> rimane dispari: 1
;-> diventa pari: 2
;-> diventa dispari: 3
;-> rimane dispari: 3
;-> diventa pari: 4
;-> rimane pari: 4
;-> diventa dispari: 5
;-> rimane dispari: 5
;-> rimane dispari: 5
;-> diventa pari: 6
;-> diventa dispari: 7
;-> rimane dispari: 7
;-> rimane dispari: 7
;-> diventa pari: 8
;-> rimane pari: 8
;-> rimane pari: 8
;-> rimane pari: 8
;-> rimane pari: 8
;-> rimane pari: 8
;-> diventa dispari: 9
;-> diventa pari: 10


Massimo raccoglitore d'acqua (Facebook)
---------------------------------------
Dati n numeri interi non negativi a1, a2, ..., an, dove ognuno rappresenta un punto di coordinate
(i, ai). n linee verticali sono disegnate in modo tale che i due estremi della linea i siano ad (i, ai)
e (i, 0). Trova due linee, che insieme all'asse x formano un contenitore, in modo tale che il
il contenitore contenga più acqua.

Esempio:
                           6
     6         5           |
     5         |     4     |
     4      3  |  3  |  3  |  3
     3   2  |  |  |  |  |  |  |
     2   |  |  |  |  |  |  |  |
     1   |  |  |  |  |  |  |  |
         ----------------------
         0  1  2  3  4  5  6  7

(setq lst '(2 3 5 3 4 3 6 3))

Questa è la soluzione grafica:

                         6
   6         5           |
   5         |OOOOOOOOOOO|
   4      3  |OOOOOOOOOOO|  3
   3   2  |  |OOOOOOOOOOO|  |
   2   |  |  |OOOOOOOOOOO|  |
   1   |  |  |OOOOOOOOOOO|  |
       ----------------------
       0  1  2  3  4  5  6  7

In questo caso le linee del contenitore che contengono più acqua sono la 2 (con valore 5) e la 6 (con valore 6).
L'altezza h del contenitore è data dal valore minore, cioè quello della linea 2 che vale 5.
La larghezza d del contenitore è la distanza tra le due linee (cioè la differenza degli indici), che vale (6 - 2) = 4.
L'area del contenitore massimo vale A = h*d = 5*4 = 20.

Attenzione: l'area massima non sempre è delimitata dai due valori massimi. Il seguente esempio mostra un caso in cui i valori massimi non delimitano l'area massima:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |     4     4        |  |     |
     4      3  |  3  |  3  |  3  3  |  |  3  |
     3   2  |  |  |  |  |  |  |  |  |  |  |  |
     2   |  |  |  |  |  |  |  |  |  |  |  |  |
     1   |  |  |  |  |  |  |  |  |  |  |  |  |
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

(setq lst '(2 3 5 3 4 3 4 3 3 7 9 3 8))

Questa è la soluzione grafica:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     4      3  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     3   2  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     2   |  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     1   |  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

Poniamo l'area del contenitore a 0.
Iniziamo a scansionare la lista di numeri da sinistra (sx) e da destra (dx).
Se (valore di sinistra) < (valore di destra), allora spostarsi da sinistra verso destra e trovare un valore maggiore del (valore di sinistra).
Se (valore di sinistra) > (valore di destra), allora spostarsi da destra verso sinistra e trovare un valore maggiore del (valore di destra).
Durante la scansione occorre tenere traccia del valore massimo dell'area del contenitore.
Tale area è data dalla moltiplicazione tra differenza degli indici correnti (larghezza) e il valore minimo dei valori correnti (altezza).

Possiamo scrivere la soluzione:

(define (sol lst)
  (local (areamax dx sx i1 i2 v1 v2 dmax vmax d h)
    (setq areamax 0)
    (setq sx 0)
    (setq dx (sub (length lst) 1))
    (while (< sx dx)
      (setq d (sub dx sx))
      (setq h (min (lst sx) (lst dx)))
      (if (> (mul d h) areamax)
        (begin  (setq areamax (mul d h))
                (setq i1 sx i2 dx)
                (setq v1 (lst i1))
                (setq v2 (lst i2))
                (setq vmax h)
                (setq dmax d)
        )
      )
      (if (< (lst sx) (lst dx))
          (++ sx)
          (-- dx)
      )
      ;(println "isx = " sx " - idx" dx)
    )
    (list areamax dmax vmax i1 i2 v1 v2)
  )
)

(sol '(2 3 5 3 4 3 6 3))
;-> (20 4 5 2 6 5 6)
; 5 e 6 --> h=5, distanza indici tra 5 e 6 d = (6-2) = 4  ==> area = h*d = 5*4 = 20

(sol '(2 8 5 3 4 3 7 3))
;-> (35 5 7 1 6 8 7)
;-> 35 ; 7 e 8 --> h=7, distanza indici tra 7 e 8 d = (6-1) = 5  ==> area = h*d = 7*5 = 35

(sol '(2 3 5 3 4 3 4 3 3 7 9 3 8))
;-> (50 10 5 2 12 5 8)

Se vogliamo sapere solo l'area massima, allora la soluzione è la seguente:

(define (sol lst)
  (local (areamax dx sx)
    (setq areamax 0)
    (setq sx 0)
    (setq dx (sub (length lst) 1))
    (while (< sx dx)
      (setq areamax (max areamax (mul (sub dx sx) (min (lst sx) (lst dx)))))
      (if (< (lst sx) (lst dx))
          (++ sx)
          (-- dx)
      )
    )
    areamax
  )
)

(sol '(1 5 4 3))
;-> 6

(sol '(3 1 2 4 5))
;-> 12

(sol '(2 3 5 3 4 3 6 3))
;-> 20

(sol '(2 8 5 3 4 3 7 3))
;-> 35

(sol '(2 3 5 3 4 3 4 3 3 7 9 3 8))
;-> (50)

Consideriamo nuovamente questo ultimo esempio:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |     4     4        |  |     |
     4      3  |  3  |  3  |  3  3  |  |  3  |
     3   2  |  |  |  |  |  |  |  |  |  |  |  |
     2   |  |  |  |  |  |  |  |  |  |  |  |  |
     1   |  |  |  |  |  |  |  |  |  |  |  |  |
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

(setq lst '(2 3 5 3 4 3 4 3 3 7 9 3 8))

(sol '(2 3 5 3 4 3 4 3 3 7 9 3 8))
;-> (50 10 5 2 12 5 8)

Come abbiamo visto questa è la soluzione grafica:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     4      3  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     3   2  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     2   |  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
     1   |  |  |OOOOOOOOOOOOOOOOOOOO|OO|OOOOO|
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

Ma se invece vogliamo considerare la soluzione seguente:

                                       9
     9                                 |     8
     8                              7  |     |
     7                              |  |     |
     6         5                    |  |     |
     5         |OOOOOOOOOOOOOOOOOOOO|  |     |
     4      3  |OOOOOOOOOOOOOOOOOOOO|  |  3  |
     3   2  |  |OOOOOOOOOOOOOOOOOOOO|  |  |  |
     2   |  |  |OOOOOOOOOOOOOOOOOOOO|  |  |  |
     1   |  |  |OOOOOOOOOOOOOOOOOOOO|  |  |  |
        ---------------------------------------
         0  1  2  3  4  5  6  7  8  9  10 11 12

allora dobbiamo scrivere una nuova funzione per calcolare la soluzione.


Quantità d'acqua in un bacino (LeetCode)
----------------------------------------
Dati n interi non negativi che rappresentano una mappa di elevazione in cui la larghezza di ciascuna barra è 1, calcolare la quantità massima di acqua che è in grado di contenere

Esempi:

lista = (2 0 2)
acqua = 2

   202
2  |x|
1  |x|
0  ---
   012

Possiamo avere "2 unità di acqua" (x) nello spazio intermedio.

lista: (3 0 0 2 0 4)
acqua: 10

  300204
       |
3 |xxxx|
2 |xx|x|
1 |xx|x|
0 ------
  012345

"3 * 2 unità" di acqua tra 3 e 2,
"1 unità" in cima alla barra 2,
"3 unità" tra 2 e 4.

lista: (0 1 0 2 1 0 1 3 2 1 2 1)
acqua: 6

  010210132121
3        |
2    |xxx||x|
1  |x||x||||||
0 ------------
  012345678901

"1 unità" tra i primi 1 e 2,
"4 unità" tra i primi 2 e 3,
"1 unità" in cima alla barra 9 (tra il penultimo 1 e l'ultimo 2).

Un elemento dell'array può immagazzinare acqua se ci sono barre più alte a sinistra e a destra. Possiamo trovare quantità di acqua da immagazzinare in ogni elemento trovando l'altezza delle barre sui lati sinistro e destro. L'idea è di calcolare la quantità d'acqua che può essere immagazzinata in ogni elemento dell'array. Ad esempio, considera l'array (3 0 0 2 0 4), possiamo memorizzare due unità di acqua agli indici 1 e 2, e una unità di acqua all'indice 2.

Una soluzione semplice consiste nel percorrere ogni elemento dell'array e trovare le barre più alte sui lati sinistro e destro. Prendi la minore delle due altezze. La differenza tra altezza minima e altezza dell'elemento corrente è la quantità di acqua che può essere immagazzinata in questo elemento dell'array. La complessità temporale di questa soluzione è O(n^2).

Una soluzione efficiente consiste nel pre-calcolare la barra più alta a sinistra e a destra di ogni barra nel tempo O(n). Quindi utilizzare questi valori pre-calcolati per trovare la quantità di acqua in ogni elemento dell'array. Di seguito vediamo l'implementazione di questa ultima soluzione.

(define (bacino lst)
  (local (lun sx dx acqua)
      (setq lun (length lst))
      (setq sx (array lun))
      (setq dx (array lun))
      (setq acqua 0)
      ; riempimento sx
      (setf (sx 0) (lst 0))
      (for (i 1 (sub lun 1))
        (setf (sx i) (max (sx (sub i 1)) (lst i)))
      )
      ; riempimento dx
      (setf (dx (sub lun 1)) (lst (sub lun 1)))
      (for (i (sub lun 2) 0 -1)
        (setf (dx i) (max (dx (add i 1)) (lst i)))
      )
      ; bar vale min(sx[i], dx[i]) - arr[i]
      (for (i 0 (sub lun 1))
        (setq bar-acqua (sub (min (sx i) (dx i)) (lst i)))
        (print bar-acqua { })
        (setq acqua (add acqua bar-acqua))
      )
   )
)

(bacino '(2 0 2))
;-> 2 0 2

(bacino '(3 0 0 2 0 4))
;-> 0 3 3 1 3 0 10

(bacino '(0 1 0 2 1 0 1 3 2 1 2 1))
;-> 0 0 1 0 1 2 1 0 0 1 0 0 6

Vediamo un altro esempio:

lista: (2 3 5 3 4 3 4 3 3 7 9 3 8))
acqua: 78

         2353434337938
     9             |
     8             | |
     7            || |
     6            || |
     5     |      || |
     4     | | |  || |
     3    ||||||||||||
     2   |||||||||||||
     1   |||||||||||||
        ---------------
         0123456789012

Soluzione:

         2353434337938
     9             |
     8             |x|
     7            ||x|
     6            ||x|
     5     |xxxxxx||x|
     4     |x|x|xx||x|
     3    ||||||||||||
     2   |||||||||||||
     1   |||||||||||||
        ---------------
         0123456789012

Totale x = 15

(bacino '(2 3 5 3 4 3 4 3 3 7 9 3 8))
;-> 0 0 0 2 1 2 1 2 2 0 0 5 0 15

Un ultimo esempio:

lista: (2 0 3 0 5 0 3 0 4 0 3 0 4 0 3 0 3 0 7 0 9 0 3 0 8)
acqua: 78

         2030503040304030307090308

     9                       |
     8                       |   |
     7                     | |   |
     6                     | |   |
     5       |             | |   |
     4       |   |   |     | |   |
     3     | | | | | | | | | | | |
     2   | | | | | | | | | | | | |
     1   | | | | | | | | | | | | |
        ---------------------------
         0123456789012345678901234

Soluzione:

         2030503040304030307090308

     9                       |
     8                       |xxx|
     7                     |x|xxx|
     6                     |x|xxx|
     5       |xxxxxxxxxxxxx|x|xxx|
     4       |xxx|xxx|xxxxx|x|xxx|
     3     |x|x|x|x|x|x|x|x|x|x|x|
     2   |x|x|x|x|x|x|x|x|x|x|x|x|
     1   |x|x|x|x|x|x|x|x|x|x|x|x|
        ---------------------------
         0123456789012345678901234

Totale x = 78

(bacino '(2 0 3 0 5 0 3 0 4 0 3 0 4 0 3 0 3 0 7 0 9 0 3 0 8))
;-> 0 2 0 3 0 5 2 5 1 5 2 5 1 5 2 5 2 5 0 7 0 8 5 8 0 78


Sposta gli zeri (LeetCode)
--------------------------
Data una lista di numeri, scrivere una funzione per spostare tutti gli 0 alla fine della lista mantenendo l'ordine relativo degli elementi diversi da zero.
Ad esempio, data la lista (0 1 0 3 12), dopo aver chiamato la funzione, la lista dovrebbe essere (1 3 12 0 0).

Risolviamo questo problema in due modi: il primo con le funzioni predefinite di newLISP e il secondo considerando la lista come un vettore ed utilizzando gli indici

Nel primo caso notiamo che:

con find-all possiamo creare la lista degli zeri:
(setq zeri (find-all 0 '(0 1 0 3 12)))
;-> (0 0)

con filter possiamo creare la lista di tuti inumeri diversi da zero:
(define (pos? x) (> x 0))
(setq numeri (filter pos? '(0 1 0 3 12)))
;-> (1 3 12)

infine uniamo le due liste con append:
(append numeri zeri)
;-> (1 3 12 0 0)

Quindi la funzione è la seguente:

(define (sol lst)
  (define (pos? x) (> x 0))
  (append (filter pos? lst) (find-all 0 lst))
)

(sol '(0 1 0 3 12))
;-> (1 3 12 0 0)
(sol '(1 0 1 0 3 0 4 0 0))
;-> (1 1 3 4 0 0 0 0 0)

Nel secondo caso utilizziamo due cicli con due indici "i" e "j". Il primo ciclo salta gli zeri e sposta in numeri nella lista, mentre il secondo ciclo scrive gli zeri alla fine della lista. L'indice "i" tiene conto della posizione dove vanno spostati i numeri (e implicitamente conta anche il numero di zeri), mentre l'indice "j" scansiona la lista.

(define (sol lst)
  (local (lun i j)
    (setq i 0 j 0)
    (setq lun (length lst))
    ; ciclo che salta gli zeri e sposta i numeri
    (while (< j lun)
      (if (!= 0 (lst j))
        (begin (setq (lst i) (lst j)) (++ i))
      )
      (++ j)
    )
    ; ciclo che scrive gli zeri alla fine della lista
    (while (< i lun)
      (setq (lst i) 0)
      (++ i)
    )
    lst
  )
)

(sol '(0 1 0 3 12))
;-> (1 3 12 0 0)
(sol '(1 0 1 0 3 0 4 0 0))
;-> (1 1 3 4 0 0 0 0 0)


Intersezione di segmenti (byte-by-byte)
---------------------------------------
La soluzione è basata su un algoritmo del libro di Andre LeMothe "Tricks of the Windows Game Programming Gurus".
In generale, una linea ha una delle forme seguenti (interscambiabili):

Y-Intercetta:  y=m*x+b
Pendenza:      (y–y0)=m*(x–x0)
Due punti:     (y–y0)=(x–x0)*(y1–y0)/(x1–x0)
Generale:      a*x+b*y=c
Parametrica:   P=p0+V*t

Il caso generale dell'intersezione è il seguente:

     y
     |                 (x1,y1)
     |                    /
     |                   /
     |                  /
     |      (x2,y2)    / p0
     |         \      /
     |          \    /
     |        p1 \  /
     |            \/ (ix,iy)
     |            /\
     |           /  \
     |          /    \
     |       (x0,y0)  \
     |                 \
     |               (x3,y3)
    -|-------------------------------- x

Il primo segmento di linea p0 ha coordinate (x0, y0) e (x1, y1).
Il secondo segmento di linea p1 ha coordinate (x2, y2) e (x3, y3).
Comunque p0 e p1 possono avere qualsiasi orientamento.

Equazione 1 - Pendenza del punto di p0: (x - x0) = m0 * (y - y0)
Data da m0 = (y1 - y0) / (x1 - x0) e (x - x0) = m0 * (y - y0)

Equazione 2 - Pendenza del punto di p2: Equazione 2: (x - x2) = m1 * (y - y2)
data da m1 = (y3 - y2) / (x3 - x2) e (x - x2) = m1 * (y - y2)

Ora abbiamo un sistema di due equazioni in due incognite:
Equazione 1: (x - x0) = m0 * (y - y0)
Equazione 2: (x - x2) = m1 * (y - y2)

Risolvendo il sistema con le matrici o per sostituzione otteniamo la seguente soluzione:

Equazione 3:
x = (-m0 / (m1 - m0)) * x2 + m0 * (y2 - y0) + x0

Equazione 4:
y = (m0 * y0 - m1 * y2 + x2 - x0) / (m0 - m1)

Prima di vedere come trattare i casi particolari (ad esempio m0 = m1) scriviamo la funzione:

(define (intersect-line p0x p0y p1x p1y p2x p2y p3x p3y)
  (local (ix iy s1x s1y s2x s2y s t)
    (setq s1x (sub p1x p0x))
    (setq s1y (sub p1y p0y))
    (setq s2x (sub p3x p2x))
    (setq s2y (sub p3y p2y))
    (println "numer = " (add (mul (sub 0 s1y) (sub p0x p2x)) (mul s1x (sub p0y p2y))))
    (println "denom = " (add (mul (sub 0 s2x) s1y) (mul s1x s2y)))
    (setq s (div (add (mul (sub 0 s1y) (sub p0x p2x)) (mul s1x (sub p0y p2y)))
                (add (mul (sub 0 s2x) s1y) (mul s1x s2y))))
    (setq t (div (sub (mul s2x (sub p0y p2y)) (mul s2y (sub p0x p2x)))
                (add (mul (sub 0 s2x) s1y) (mul s1x s2y))))
    (println "s = " s)
    (println "t = " t)
    (cond ((and (>= s 0) (<= s 1) (>= t 0) (<= t 1)) ;intersezione
           (setq ix (add p0x (mul t s1x)))
           (setq iy (add p0y (mul t s1y)))
          )
          (true (setq ix nil) (setq iy nil))
    )
    (list ix iy)
  )
)

Vediamo come si comporta la funzione nei casi normali e nei casi particolari:

; intersezione
(intersect-line 0 0 2 2 0 1 1 0)
;-> numer = -2
;-> denom = -4
;-> s = 0.5
;-> t = 0.25
;-> (0.5 0.5)

; no intersezione
(intersect-line 1 1 3 3 2 3 2 5)
;-> numer = -2
;-> denom = 4
;-> s = -0.5
;-> t = 0.5
;-> (nil nil)

; no intersezione
(intersect-line 1 1 5 6 3 1 4 0)
;-> numer = 10
;-> denom = -9
;-> s = -1.111111111111111
;-> t = 0.2222222222222222
;-> (nil nil)

; paralleli
(intersect-line 1 1 3 1 1 3 3 3)
;-> numer = -4
;-> denom = 0
;-> s = -1.#INF
;-> t = -1.#INF
;-> (nil nil)

; collineari (senza sovrapposizione)
(intersect-line 1 2 3 2 5 2 7 2)
;-> numer = 0
;-> denom = 0
;-> s = -1.#IND
;-> t = -1.#IND
;-> (nil nil)

; collineari (con sovrapposizione)
(intersect-line 1 2 3 2 4 2 6 2)
;-> numer = 0
;-> denom = 0
;-> s = -1.#IND
;-> t = -1.#IND
;-> (nil nil)

; uniti (punto-punto)
(intersect-line 1 2 3 2 3 2 5 4)
;-> numer = 0
;-> denom = 4
;-> s = 0
;-> t = 1
;-> (3 2)

; uniti (segmento-punto)
(intersect-line 1 1 3 3 2 2 5 1)
;-> numer = 0
;-> denom = -8
;-> s = -0
;-> t = 0.5
;-> (2 2)

Se vogliamo trattare i casi particolari in modo diverso da (nil nil) possiamo utilizzare i seguenti predicati:

; indeterminato (0/0)
(NaN? (div 0 0))
;-> true

; infinito (inf)
(NaN? (div 5 0))
;-> nil

; infinito (inf)
(inf? (div 5 0))
;-> true

; indeterminato (inf/inf)
(NaN? (div (div 5 0) (div 5 0)))
;-> true

Trovare l'elemento mancante (LeetCode)
--------------------------------------
Abbiamo due liste con gli stessi elementi, ma una lista ha un elemento in meno. Trovare l'elemento mancante della lista più corta.
Esempio:
lista 1: (1 3 4 6 8)
lista 2: (3 1 6 8)
Elemento mancante: 4

Invece di usare due cicli for annidati per trovare l'elemento, possiamo notare che sottraendo la somma degli elementi della lista più corta alla somma degli elementi di quella più lunga otteniamo il valore dell'elemento mancante.

(define (sol lst1 lst2)
  (abs (sub (apply + lst1) (apply + lst2)))
)

(sol '(1 3 4 6 8) '(3 1 6 8))
;-> 4

Possiamo usare anche la funzione difference:

(difference '(1 3 4 6 8) '(3 1 6 8))
;-> (4)

Nota: Dati due valori di una lista con tre scelte (1 2 3), individuare il terzo valore.

(define (altro x y)
    (- 6 (+ x y))
)

(altro 1 2)
;-> 3


Verifica lista/sottolista (Visa)
--------------------------------
Date due liste A e B composte da n e m interi, verificare se la lista B è una sottolista della lista A.
Esempi:

Lista A (2 3 0 5 1 1 2)
Lista B (3 0 5 1)
B sottolista di A? si

Lista A (1 2 3 4 5)
Lista B (2 5 6)
B sottolista di A? no

Utilizziamo due indici "i" e "j" per attraversare contemporaneamentele le liste A e B.
Se gli elementi delle due liste sono uguali, allora incrementiamo entrambi gli indici (e controllo anche che la lista B non sia terminata);
altrimenti incrementiamo l'indice "i" della lista A e resettiamo a zero l'indice "j" della lista B.
Ecco la funzione:

(define (sol lstA lstB)
  (local (i j lunA lunB out)
    (setq i 0 j 0)
    (setq lunA (length lstA))
    (setq lunB (length lstB))
    (while (and (< i lunA) (< j lunB))
      (cond ((= (lstA i) (lstB j))
             (++ i)
             (++ j)
             (if (= j lunB) (setq out true))
            )
            (true (setq j 0) (++ i))
      )
    )
    out
  )
)

(sol '(2 3 0 5 1 1 2) '(3 0 5 1))
;-> true

(sol '(1 2 3 4 5) '(2 5 6))
;-> nil

(time (sol '(2 3 0 5 1 1 2) '(3 0 5 1)) 100000)
;-> 203

Oppure:

(define (sol A B)
  (if (or (= B (intersect A B)) (= B '())) ;() è sempre una sottolista
    true nil))

(sol '(2 3 0 5 1 1 2) '(3 0 5 1))
;-> true

(sol '(1 2 3 4 5) '(2 5 6))
;-> nil

(time (sol '(2 3 0 5 1 1 2) '(3 0 5 1)) 100000)
;-> 140


Controllo ordinamento lista (Visa)
----------------------------------
Scrivere una funzione per controllare se una lista è ordinata o meno. La funzione deve avere un parametro che permette di specificare il tipo di ordinamento (crescente o decrescente).

Usiamo la tecnica della ricorsione per risolvere il problema: applico l'operatore di confronto tra il primo e il secondo elemento e poi richiamo la stessa funzione con il resto della lista.
L'operatore di confronto può avere i seguenti valori:
1) >= (lista crescente)
2) >  (lista strettamente crescente)
3) <= (lista decrescente)
4) <  (lista strettamente decrescente)
5) =  (lista con elementi identici)

(define (ordinata? lst operatore)
      (cond ((null? lst) true)
            ((= (length lst) 1) true)
            ; se l'attuale coppia di elementi rispetta l'operatore...
            ((operatore (first (rest lst)) (first lst))
              ; allora controlla la prossima coppia
              (ordinata? (rest lst) operatore))
              ; altrimenti restituisce nil
            (true nil))
)

; lista crescente ?
(ordinata? '(1 1 2 3) >=)
;-> true

; lista strettamente crescente ?
(ordinata? '(1 1 2 3) >)
;-> nil

; lista decrescente ?
(ordinata? '(3 2 1 1) <=)
;-> true

; lista strettamente decrescente ?
(ordinata? '(3 2 1 1) <)
;-> nil

; lista con elementi identici ?
(ordinata? '(1 1 1 1) =)
;-> true

; lista con elementi identici ?
(ordinata? '(3 2 1 1) =)
;-> nil

Per verificare se una lista ha tutti gli elementi identici possiamo usare la seguente funzione:

(define (lista-identica? lst)
  (apply = lst))

; lista con elementi identici ?
(lista-identica? '(2 2 2 2))
;-> true

; lista con elementi identici ?
(lista-identica? '(3 2 1 1))
;-> nil

Possiamo scrivere una funzione più generale che non necessita del parametro relativo all'operatore di confronto e restituisce il tipo di ordinamento della lista.
Usiamo la funzione apply per applicare tutti gli operatori di confronto alla lista:

(apply > '(8 5 3 2))
;-> true

(define (order? lst)
  (cond ((apply =  lst) '= ) ;lista con elementi uguali
        ((apply >  lst) '> ) ;lista decrescente
        ((apply <  lst) '< ) ;lista decrescente
        ((apply >= lst) '>=) ;lista strettamente decrescente
        ((apply <= lst) '<=) ;lista strettamente crescente
        (true nil)           ;lista non ordinata
  )
)

(order? '(-1 -1 -1 -1))
;-> =
(order? '(1 2 3 4))
;-> <
(order? '(4 3 2 1))
;-> >
(order? '(4 3 2 1 1))
;-> >=
(order? '(-1 -1 3 4))
;-> <=


Caramelle (Visa)
----------------
Ci sono N bambini in fila. Ad ogni bambino viene assegnato un punteggio.
Devi distribuire caramelle questi bambini in base ai seguenti vincoli:
1. Ogni bambino deve avere almeno una caramella.
2. I bambini con punteggio maggiore ottengono più caramelle rispetto a quelli con punteggio minore (almeno una caramella in più).
3. I bambini che hanno punteggi uguali ottengono lo stesso numero di caramelle
Qual'è il numero minimo di caramelle da distribuire?

Una soluzione semplice è quella di ordinare i punteggi in ordine crescente e poi assegnare le caramelle dando una caramella al punteggio più basso, due caramelle al successivo e così via fino all'ultimo bambino.

(define (caramelle lst)
  (local (somma num doppio)
    (sort lst <)
    (println lst)
    (setq somma 1)
    (setq doppio nil)
    (setq num 1)
    (for (i 1 (sub (length lst) 1))
      (cond ((= (lst i) (lst (sub i 1)))
             (setq doppio true)
             (setq somma (add somma num))
            )
            (true
             (setq doppio nil)
             (++ num) ;aumento le caramelle da distribuire per questo bambino
             (setq somma (add somma num))
            )
      );cond
      ;(println i { } num { } somma)
    );for
    somma
  );local
)

(caramelle '(1 3 3 4))
;-> 8

(caramelle '(0 1 1 1))
;-> 7

(caramelle '(10 2 1 1 1 3 5 4))


================================
 CALCOLI CON I NUMERI COMPLESSI
================================

newLISP non fornisce alcun tipo di numeri e operazioni per gestire i calcoli con i numeri complessi.
Possiamo scrivere alcune funzioni per supportare alcuni calcoli con questi numeri.
Ogni numero complesso (a + ib), dove a = parte_reale e b = parte_immaginaria o complessa, viene rappresentato con una lista (a b).
Per esempio, il numero (2 + i3) viene rappresentata dalla lista (2 3).

Definiamo due funzioni che estraggono la parte reale e quella immaginaria di un numero complesso:

Funzione estrazione parte reale "re"
------------------------------------
(define (re num) (first num))

Funzione estrazione parte immaginaria "im"
------------------------------------------
(define (im num) (last num))

(setq n1 '(3 -12))
(setq n2 '(-2 8))

(re n1)
;-> 3

(im n2)
;-> 8

I numeri complessi possono essere rappresentati in due modi:
1) forma cartesiana (o algebrica) -->  (a + ib)
2) forma esponenziale             -->  |z|*e^it (dove z = modulo, t = angolo)

Vediamo le formule che permettono di trasformare un numero complesso tra le due forme:

Cartesiana --> Esponenziale
Dato il numero complesso z = a + ib:

|z| = sqrt(a^2 + b^2)

    +arccos(a/|z|)   se b >= 0
t =
    -arccos(a/|z|)   se b < 0

Esponenziale --> Cartesiana
Dato il numero complesso z = |z|*e^it:

a = Re(z) = |z|*cos(t)
b = Im(z) = |z|*sin(t)

Adesso dobbiamo scrivere due funzioni che convertono un numero complesso tra le forme cartesiana ed esponenziale. Anche il numero complesso in forma esponenziale può essere rappresentato da una lista con due valori:

 |z|e^it  -->  (z t)

dove z è il valore del modulo e t è il valore dell'angolo.

Anche in questo caso scriviamo due funzioni che estraggono il modulo e l'angolo da un numero complesso in forma esponenziale:

Funzione estrazione modulo "|z|"
------------------------------------
(define (z num) (first num))

Funzione estrazione angolo "t"
------------------------------------------
(define (t num) (last num))

Inoltre utilizziamo anche la costante di Eulero e la costante pi greco:

(constant '*e*  2.7182818284590451)
(constant '*pi* 3.1415926535897931)

Adesso possiamo scrivere le funzioni di conversione tra le due forme:

Conversione Cartesiana --> Esponenziale
---------------------------------------

(define (ccx2ecx num)
  (let (z (sqrt (add (mul (re num) (re num)) (mul (im num) (im num)))))
       (list z
             (if (< (im num) 0)
                 (acos(div (re num) z))
                 (sub 0 (acos(div (re num) z)))
             )
       )
  )
)

cartesiana: sqrt(3) + 1i

(setq num (list (sqrt 3) 1))
;-> (1.732050807568877 1)

(ccx2ecx num)
;-> (2 -0.5235987755982987)

esponenziale: 2*e^-0.5235987755982987i
(dove -0.5235987755982987 = *pi*/6)

(div *pi* 6)
;-> 0.5235987755982988

Conversione Esponenziale --> Cartesiana
---------------------------------------

(define (ecx2ccx num)
  (list (mul (z num) (cos (t num)))
        (mul (z num) (sin (t num))))
)

esponenziale: 2*e^-0.5235987755982987i

(setq num (list 2 -0.5235987755982987))
;-> (2 -0.5235987755982987)

(ecx2ccx num)
;-> (1.732050807568877 -0.9999999999999997)

cartesiana: 1.732050807568877 -0.9999999999999997i
(dove 1.732050807568877 = sqrt(3))

(sqrt 3)
;-> 1.732050807568877

Siamo pronti per scrivere le funzioni di base per la gestione di calcoli con i muneri complessi:
1) addizione
2) sottrazione
3) moltiplicazione
4) divisione
5) reciproco (o inverso)
6) potenza

Addizione di due numeri complessi "+cx"
---------------------------------------

(define (+cx n1 n2)
  (list (add (re n1) (re n2)) (add (im n1) (im n2)))
)

(+cx n1 n2)
;-> (1 -4)

Sottrazione di due numeri complessi "-cx"
-----------------------------------------

(define (-cx n1 n2)
  (list (sub (re n1) (re n2)) (sub (im n1) (im n2)))
)

(-cx n1 n2)
;-> (5 -20)

Moltiplicazione di due numeri complessi "*cx"
---------------------------------------------

(define (*cx n1 n2)
  (list (sub (mul (re n1) (re n2)) (mul (im n1) (im n2)))
        (add (mul (im n1) (re n2)) (mul (re n1) (im n2))))
)

(*cx n1 n2)
;-> (90 48)

(*cx n2 n1)
;-> (90 48)

Divisione di due numeri complessi "/cx"
---------------------------------------

(define (/cx n1 n2)
  (if (and (zero? (re n2)) (zero? im n2))
    (list nil nil())
    (list (div (add (mul (re n1) (re n2)) (mul (im n1) (im n2)))
               (add (mul (re n2) (re n2)) (mul (im n2) (im n2))))
          (div (sub (mul (im n1) (re n2)) (mul (re n1) (im n2)))
               (add (mul (re n2) (re n2)) (mul (im n2) (im n2)))))
  )
)

(/cx n1 n2)
;->(-1.5 0)

(/cx n2 n1)
;->

Reciproco di un numero complesso "|cx"
-------------------------------------

Il reciproco (o l'inverso) di un numero complesso z = a + i b ≠ 0 è quel numero che moltiplicato per z ha come risultato 1.

(define (|cx n)
  (if (and (= (re n) 0) (= (im n) 0))
      ; (list (nil nil)
      (list (div 1 0) (div 1 0))
      (list (div (re n) (add (mul (re n) (re n)) (mul (im n) (im n))))
            (div (sub 0 (im n)) (add (mul (re n) (re n)) (mul (im n) (im n))))))
)

(setq n '(3 4))
(add (mul (re n) (re n)) (mul (im n) (im n)))

(|cx '(3 4))
;-> (0.12 -0.16)

(*cx '(3 4) '(0.12 -0.16))
;-> (1 0)

Potenza di un numero complesso "^cx"
------------------------------------

(define (^cx n p)
  (cond ((zero? p) (if (= 0 (re n)) (list 0 0) (list 1 0))) ;potenza nulla
        ((= p 1) (list (re n) (im n))) ;potenza uguale ad 1
        ((> p 1) ;potenza positiva maggiore di 1
          (setq t n)
          (for (i 1 (sub p 1))
            (setq t (*cx (list (re t) (im t)) (list (re n) (im n))))
          )
          (list (re t) (im t))
        )
        ((< p 0) ;potenza negativa
          (setq t n)
          (setq p (abs p))
          (for (i 1 (sub p 1))
            (setq t (*cx (list (re t) (im t)) (list (re n) (im n))))
          )
          (|cx (list (re t) (im t))) ; calcolo numero inverso
        )
  )
)

(^cx '(4 2) 2)
;-> (12 16)

(^cx '(4 2) -2)
;-> (0.03 -0.04)

(^cx '(12 16) -2)
;-> (-0.0007 -0.0024)


=========================
 CALCOLI CON LE FRAZIONI
=========================

newLISP non fornisce alcun tipo di numeri e operazioni per gestire i calcoli con le frazioni.
Possiamo scrivere alcune funzioni per supportare il calcolo frazionario con numeri interi.

Ogni frazione numeratore e denominatore (N/D) viene rappresentata con una lista (N D).
Per esempio, la frazione 2/3 viene rappresentata dalla lista (2 3).
Prima di tutto scriviamo una funzione che semplifica una frazione (in altre parole, riduce una frazione ai minimi termini):

Funzione che semplifica una frazione "semplifica"
-------------------------------------------------

(define (semplifica frac)
  (local (num den n d temp, nums dens)
    (setq num (first frac))
    (setq den (last frac))
    (setq n (first frac))
    (setq d (last frac))
    ; calcola il numero massimo che divide esattamente numeratore e denominatore
    (while (!= d 0)
      (setq temp d)
      (setq d (mod n temp))
      (setq n temp)
    )
    (setq nums (/ num n))
    (setq dens (/ den n))
    ; controllo del segno
    (cond ((or (and (< dens 0) (< nums 0)) (and (< dens 0) (> nums 0)))
           (setq nums (* nums -1))
           (setq dens (* dens -1))
          )
    )
    (list nums dens)
  )
)

(semplifica '(4 8))
;-> (1 2)

(semplifica '(1000 2500))
;-> (2 5)

(semplifica '(-2 -4))
;-> (1 2)

(semplifica '(-2 4))
;-> (-1 2)

Adesso possiamo scrivere le funzioni per le quattro operazioni.

Funzione che somma due frazioni "+f"
------------------------------------

(define (+f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (add (mul n1 d2) (mul n2 d1)))
    (setq den (mul d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

Se l'argomento "redux" vale true, allora il risultato non viene semplificato.

(+f '(3 4) '(2 3))
;-> (17 12)

(+f '(2 4) '(2 3))
;-> (7 6)

(+f '(2 4) '(2 3) true)
;-> (14 12)

(+f '(10 100) '(40 100))
;-> (1 2)

Funzione che sottrae due frazioni "-f"
--------------------------------------

(define (-f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (sub (mul n1 d2) (mul n2 d1)))
    (setq den (mul d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(-f '(12 13) '(13 13))
;-> (-1 13)

(-f '(-12 -13) '(-13 -13))
;-> (-1 13)

(+f '(-12 -13) '(-14 -13) true)
;-> (338 169)

(+f '(-12 -13) '(-14 -13))
;-> (2 1)

Funzione che moltiplica due frazioni "*f"
-----------------------------------------

(define (*f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (mul n1 n2))
    (setq den (mul d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(*f '(3 6) '(3 5))
;-> (3 10)

(*f '(-3 6) '(3 5) true)
;-> -9 30)

Funzione che divide due frazioni "/f"
-------------------------------------

(define (/f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (mul n1 d2))
    (setq den (mul d1 n2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(/f '(2 4) '(1 -3))
;-> (-3 2)

(/f '(2 4) '(3 2) true)
;-> (4 12)

Funzione che calcola la potenza di una frazione "^f"
----------------------------------------------------

(define (^f frac power redux)
  (local (num den n d)
    (setq n (first frac))
    (setq d (last frac))
    (setq num (pow n power))
    (setq den (pow d power))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(^f '(3 4) 4)
;-> (81 256)

(^f '(3 5) 2)
;-> (9 25)

Per generalizzare le funzioni che abbiamo scritto, dobbiamo permettere che queste siano in grado di gestire un numero variabile di argomenti (attualmente possiamo passare solo due frazioni alle nostre funzioni).
Usiamo le seguenti funzioni per estrarre il numeratore e il denominatore da una frazione (num den):

Numeratore di (num den)
-----------------------
(define (numf f) (first f))

Denominatore di (num den)
-------------------------
(define (denf f) (last f))

Poi riscriviamo la funzione che semplifica (riduce ai minimi termini) una frazione:

(define (redux f)
  (local (num den)
    (setq num (div (numf f) (gcd (numf f) (denf f))))
    (setq den (div (denf f)  (gcd (numf f) (denf f))))
    (cond ((or (and (< den 0) (< num 0)) (and (< den 0) (> num 0)))
            (setq num (* num -1))
            (setq den (* den -1)))
    )
    (list num den)
  )
)

Testiamo la funzione "redux":

(redux '(-30 5))
;-> (-6 1)

(redux '(-30 -5))
;-> (6 1)

(redux '(30 -5))
;-> (-6 1)

(redux '(30 5))
;-> (6 1)

Adesso riscriviamo (in modo più conciso) la funzione che somma due frazioni:

(define (+f-aux f1 f2)
  (redux (list (add (mul (numf f1) (denf f2)) (mul (numf f2) (denf f1)))
               (mul (denf f1) (denf f2))))
)

Si tratta di una funzione (ausiliaria) che prende come parametro due frazioni.
Adesso scriviamo una macro che permette di applicare la funzione "+f-aux" ad un numero qualunque di frazioni:

(define-macro (+f)
  ; somma tutte le frazioni passate come argomento a due a due
  (apply +f-aux (map eval (args)) 2))

Nota:
L'espressione (apply +f-aux (map eval (args)) 2) permette di chiamare la macro "+f" con gli argomenti quotati (es. (+f '(1 2) '(1 2) '(1 2))).
Se avessimo scritto (apply +f-aux (args) 2) dovremmo chiamare la macro "+f" con gli argomenti non quotati (es. (+f (1 2) (1 2) (1 2))).
Questo è dovuto al fatto che le macro non valutano gli argomenti, quindi è necessario utilizzare la funzione "eval" per valutare gli argomenti.
Vediamo un esempio:

(define-macro (a)
  (args))

(a (1 2) (1 2) (1 2))
;-> ((1 2) (1 2) (1 2))

(define-macro (a)
  (map eval (args)))

(a '(1 2) '(1 2) '(1 2))
;-> ((1 2) (1 2) (1 2))

Adesso possiamo testare la nostra nuova funzione "f+":

(+f '(1 2) '(1 3))
;-> (5 6)

(+f '(1 2) '(1 2) '(1 2))
;-> (3 2)

(+f '(20 2) '(-1 -2) '(1 2))
;-> (11 1)

Riscriviamo tutte le funzioni che operano sulle frazioni:
1) addizione
2) sottrazione
3) moltiplicazione
4) divisione
5) potenza

Funzioni varie
--------------

;numeratore di (num den)
(define (numf f) (first f))

;denominatore di (num den)
(define (denf f) (last f))

;riduzione minimi termini
(define (redux f)
  (local (num den)
    (setq num (div (numf f) (gcd (numf f) (denf f))))
    (setq den (div (denf f)  (gcd (numf f) (denf f))))
    (cond ((or (and (< den 0) (< num 0)) (and (< den 0) (> num 0)))
            (setq num (* num -1))
            (setq den (* den -1)))
    )
    (list num den)
  )
)

Addizione frazioni "+f"
-----------------------

;ausiliaria
(define (+f-aux f1 f2)
  (redux (list (add (mul (numf f1) (denf f2)) (mul (numf f2) (denf f1)))
               (mul (denf f1) (denf f2))))
)

;Addiziona tutte le frazioni passate come argomento a due a due
(define-macro (+f)
  (apply +f-aux (map eval (args)) 2))


=====================
 CALCOLI CON I TEMPI
=====================

In questo capitolo definiremo due funzioni che permettono di addizionare e sottrarre due o più tempi.
Un valore tempo viene definito in ore, minuti, secondi e lo rappresenteremo con una lista con tre valori (h m s). Ad esempio, il tempo 3 ore, 34 minuti e 20 secondi è rappresentato dalla lista (3 34 20). Cominciamo con la funzione che somma due tempi.

Addizione di due tempi "+t"
---------------------------

Definiamo alcune funzioni di estrazione delle ore, minuti e secondi da un tempo:

(define (hh t) (first t))
(define (mm t) (first (rest t)))
(define (ss t) (last t))

Definiamo una funzione che normalizza il tempo, cioè controlla e ricalcola i tempi che hanno valori di minuti e/o secondi maggiori o uguali a 60.

(define (redux-t t)
  (local (h m s)
    (setq h (hh t)) (setq m (mm t)) (setq s (ss t))
    ; normalizza secondi (il valore dei secondi deve essere minore di 60)
    (while (>= s 60) (setq s (sub s 60)) (++ m))
    ; normalizza minuti (il valore dei minuti deve essere minore di 60)
    (while (>= m 60) (setq m (sub m 60)) (++ h))
    (list h m s)
  )
)

(redux-t '(0 6000 12000))
;-> (103 20 0)

Nota: la funzione "redux-t" non riduce valori negativi

; redux-t non riduce valori negativi
(redux-t '(0 -61 0))
;-> (0 -61 0)

(define (+t t1 t2)
  (local (h m s ch)
    ; riduzione dei tempi ai minimi termini
    (setq t1 (redux-t t1))
    (setq t2 (redux-t t2))
    (setq h (add (hh t1) (hh t2)))
    (setq m (add (mm t1) (mm t2)))
    (setq s (add (ss t1) (ss t2)))
    (redux-t (list h m s))
  )
)

(+t '(10 60 60) '(10 30 30))
;-> (21 31 30)

(+t '(60 1200 1200) '(60 120 300))
;-> (142 25 0)

Adesso definiamo la funzione che sottrae due tempi (un pò più complicata).

Sottrazione di due tempi "+t"
-----------------------------

(define (-t t1 t2)
  (local (h m s h1 m1 s1 h2 m2 s2 ch)
    ; riduzione dei tempi ai minimi termini
    (setq t1 (redux-t t1))
    (setq t2 (redux-t t2))
    ; estrazione ore (h), minuti (m), secondi (s)
    (setq h1 (hh t1)) (setq m1 (mm t1)) (setq s1 (ss t1))
    (setq h2 (hh t2)) (setq m2 (mm t2)) (setq s2 (ss t2))
    ; trova il tempo maggiore
    (if (< (add s1 (mul m1 1000) (mul h1 10000))
           (add s2 (mul m2 1000) (mul h2 10000)))
        (begin (swap h1 h2) (swap m1 m2) (swap s1 s2) (setq ch true))
    )
    ; sottrazione dei tempi
    (if (<= s2 s1) (setq s (sub s1 s2))
        (begin (setq s (add 60 (sub s1 s2))) (++ m2))
    )
    (if (<= m2 m1) (setq m (sub m1 m2))
        (begin (setq m (add 60 (sub m1 m2))) (++ h2))
    )
    (setq h (sub h1 h2))
    ; se abbiamo scambiato i due tempi (perchè il primo tempo era minore)
    ; allora cambiamo il segno delle ore o dei minuti o dei secondi
    (if (= ch true)
      (begin
        (setq h (sub 0 h))
        (if (= h 0) (setq m (sub 0 m)))
        (if (and (= h 0) (= m 0) (setq s (sub 0 s))))
      )
    )
    ; risultato
    (list h m s)
  );local
)

(redux-t '(150 300 200))
;-> (155 3 20)

(redux-t '(120 130 201))
;-> (122 13 21)

(-t '(155 3 20) '(122 13 21))
;-> (32 49 59)

(-t '(150 300 200) '(120 130 201))
;-> (32 49 59)

(-t '(120 130 201) '(150 300 200))
;-> (-32 49 59)

(-t '(24 58 2) '(24 58 1))
;-> (0 0 1)

(-t '(24 58 1) '(24 58 2))
;-> (0 0 1)

(-t '(24 58 1) '(24 59 2))
;-> (0 -1 1)

(-t '(-3 0 0) '(-2 0 0))
;-> (-1 0 0)

(-t '(0 0 -1) '(0 0 -2))
;-> (0 0 1)

(+t '(0 0 -1) '(0 0 -2))
;-> (0 0 -3)

Adesso definiamo due macro che ci permettono di sommare o sottrarre un numero qualsiasi di tempi:

Addizione tempi "+tt"
---------------------

(define-macro (+tt)
  ; somma tutte i tempi passati come argomento a due a due
  (apply +t (map eval (args)) 2))

(+tt '(2 20 20) '(2 20 20) '(2 20 20))
;-> (7 1 0)

Sottrazione tempi "-tt"
-----------------------

(define-macro (-tt)
  ; sottrae tutti i tempi passati come argomento a due a due
  (apply -t (map eval (args)) 2))

(-tt '(2 20 20) '(2 20 20) '(2 20 20))
;-> (-2 20 20)

(+tt '(1 20 40) '(0 20 40) '(1 0 0))
;-> (2 41 20)


============================
 OPERAZIONI CON GLI INSIEMI
============================

newLISP fornisce alcune funzioni per operare sugli insiemi (sets).
Vediamo quali sono e come implementare le funzioni che mancano (alcune di queste funzioni sono prese dal libro "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015).

Definiamo due insiemi (liste) per i test:

 (setq A '(a b c d e))

 (setq B '(a c e f g))

;------------------------------------------------------
; intersect (built-in)
;------------------------------------------------------
sintassi 1: (intersect list-A list-B)
sintassi 2: (intersect list-A list-B bool)
output: list

Nella prima sintassi, ritorna una lista che contiene una copia di ogni elemento che si trova sia nella list-A che nella list-B.

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5))
;-> (2 4 1)

Nella seconda sintassi, ritorna una lista con tutti gli elementi della list-A che si trovano anche nella list-B, senza eliminazione dei duplicati della list-A.
bool è un espressione che deve essere true o nil.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5) true)
;-> (1 2 4 2 1)

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5) nil)
;-> (1 2 4)

;------------------------------------------------------
; difference (built-in)
;------------------------------------------------------
sintassi 1: (difference list-A list-B)
sintassi 2: (difference list-A list-B bool)
output: list

Questa funzione mantiene l'ordine degli elementi della lista originale.

Nella prima sintassi, restituisce la differenza tra gli insieme list-A e list-B.
La lista risultante ha solo gli elementi che si trovano nella list-A, ma non nella list-B.
Tutti gli elementi della lista risultante sono unici, ma le liste possono anche essere non uniche
Gli elementi della lista possono essere qualunque espressione lisp.

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1))
;-> (5 6 0)
(difference '(1 1 2 3 4) '(2 4 6 8))
;->  (1 3)
(difference '(1 1 2 3 4) '(2 4 6 8) true)
;-> (1 1 3)

Nella seconda sintassi, la differenza funziona in modalità elenco
bool è un espressione che deve essere true o nil.
Nelle lista risultante, tutti gli elementi di list-B sono eliminati nella list-A, ma i duplicati che si trovano nella list-A vengono mantenuti.

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1) true)
;-> (5 6 0 5 0)

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1) nil)
;-> (5 6 0)

;------------------------------------------------------
; unique (built-in)
;------------------------------------------------------
sintassi: (unique list)
output: list

Restituisce una lista in cui tutti i duplicati vengono rimossi.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(unique '(2 3 4 4 6 7 8 7))
;-> (2 3 4 6 7 8)

La lista può essere non ordinata, ma una lista ordinata rende il calcolo più veloce.

;------------------------------------------------------
; union (built-in)
;------------------------------------------------------
sintassi: (union list-1 list-2 [list-3 ... ])
output: list

Restituisce una lista con tutti i valori diversi trovati nelle liste passate come argomento.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(union '(1 3 1 4 4 3) '(2 1 5 6 4))
;-> (1 3 4 2 5 6)

;------------------------------------------------------
; belongs?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (belongs? x A)
output: boolean

Restituisce true se un elemento x appartiene all'insieme A (nil altrimenti).

(define (belongs? x A)
  (if (or (intersect (list x) A) (= x '())) ;() is always a subset
    true nil))

(belongs? 'a '(a b c d e))
;-> true
(belongs? '() '(a b c d e))
;-> true

;------------------------------------------------------
; subset?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi (subset? A B)
output: boolean

Restituisce true se l'insieme A è sottoinsieme dell'insieme B (nil altrimenti).

(define (subset? A B)
  (if (or (= A (intersect A B)) (= A '())) ;() is always a subset
    true nil))

(subset? '(a b c d e) '(a c e f g))
;-> nil
(subset? '(a b c d e) '(a b c d e))
;-> true

;------------------------------------------------------
; cardinality
;"A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (cardinality A)
output: integer

Restituisce la cardinalità (numero degli elementi) di un insieme.

(define (cardinality S)
  (length S)
)

;------------------------------------------------------
; equivalent?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (equivalent? A B)
output: boolean

Restituisce true se due insiemi sono equipotenti, cioè se hanno lo stesso numero di elementi (nil altrimenti).

(define (equivalent? A B)
  (if (= (cardinality A) (cardinality B)))
)

;------------------------------------------------------
; idem?
;------------------------------------------------------
sintassi: (idem? A B)
output: boolean

Restituisce true se due insiemi hanno gli stessi elementi nello stesso ordine (nil altrimenti).

(define (idem? A B)
  (if (= A B))
)

;------------------------------------------------------
; equal?
;------------------------------------------------------
sintassi: (equal? A B)
output: boolean

Restituisce true se due insiemi hanno gli stessi elementi, anche in ordine diverso (nil altrimenti).

(define (equal? A B)
  (if (= (sort A) (sort B)))
)

(setq A '(a b c))
(setq B '(a c b))
a

(equal? '(a b c) '(b a c))
(equal? A B)
(sort B)
B

;------------------------------------------------------
; disjoint?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (disjoint? A B)
output: boolean

Restituisce true se due insiemi non hanno elementi in comune (nil altrimenti).

(define (disjoint? A B)
  (if (= (intersect A B) '()))
)

;------------------------------------------------------
; complement
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (complement A U)
output: list

Restituisce il complemento di un insieme rispetto all'insieme universo U.

(define (complement A U, lU i set-out)
  (setq set-out '())
  (setq lU (cardinality U))
  (setq i 0)
  (while (< i lU)
    (if (!= (belongs? (nth i U) A) true)
      (setq set-out (cons (nth i U) set-out))
    )
    (++ i) ;this is equivalent to (setq i (+ 1 i))
  );end while
  (reverse set-out)
)

(setq U '(a b c d e f g h))
(setq A '(c d e b h g))

(complement A U)
;-> (a f)

(difference U A) it is the same
;-> (a f)

;------------------------------------------------------
; cartesian-product
;------------------------------------------------------
sintassi: (cartesian-product A B)
output: list

Restituisce il prodotto cartesiano di due insiemi.

; iterative
(define (cartesian-product A B , lA lB i j set-out)
  (setq lA (cardinality A))
  (setq lB (cardinality B))
  (setq i 0 j 0) ;initializes i and j at the same time to zero
  (setq set-out '())
  (while (< i lA)
    (while (< j lB)
    (setq set-out (cons (list (nth i A) (nth j B)) set-out))
      (++ j) ;equivalent to (setq j (+ 1 j))
    );end while j
    (++ i) ;equivalent to (setq i (+ 1 i))
    (setq j 0) ;reinitializes j
  );end while i
  (reverse set-out)
)

(cartesian-product '(a b) '(a c))
;-> ((a a) (a c) (b a) (b c))
(cartesian-product '(a b) '(a b c))
;-> ((a a) (a b) (a c) (b a) (b b) (b c))

; recursive
(define (cart-one x lst)
  (cond
   ((null? lst) '())
   (true (cons (list x (first lst))
               (cart-one x (rest lst))))))

(dist-one 'b '(x y z))
;-> ((b x) (b y) (b z))

(define (cartesian A B)
  (cond
    ((null? A) '())
    (true (append (cart-one (first A) B)
              (cartesian (rest A) B)))))

(cartesian '(a b) '(x y z))
;-> ((a x) (a y) (a z) (b x) (b y) (b z))

;------------------------------------------------------
; powerset
;------------------------------------------------------
sintassi: (powerset A)
output: list

Restituisce l'insieme potenza di un insieme.

(define (powerset lst)
  (if (empty? lst)
      (list '())
      (let ( (element (first lst))
             (p (powerset (rest lst))))
           (append (map (fn (subset) (cons element subset)) p) p) )))

(powerset '(a b c))
;-> ((a b c) (a b) (a c) (a) (b c) (b) (c) ())


+===========+
| APPENDICI |
+===========+

============================================================================
newLISP in 21 minuti di John W. Small
============================================================================

newLISP: un tutorial interattivo
--------------------------------
Questo documento è stato riformattato per HTML con alcune correzioni e aggiornamenti fatti da Rick Hanson nel maggio 2006, cryptorick@gmail.com. Ulteriori aggiornamenti da LM gennaio 2008, dicembre 2011, novembre 2014, maggio 2018.
Traduzione in italiano, aggiornamenti e adattamenti fatti da cameyo 2019.

Copyright 2004, John W. Small, Tutti i diritti riservati

Puoi scaricare e installare newLISP dal sito web www.newLISP.org.

Si prega di inviare eventuali commenti o domande riguardanti questo tutorial a jsmall@atlaol.net.

Indice
------
Ciao Mondo!
Codice sorgente e dati sono intercambiabili
Argomenti di funzione
Effetti collaterali e contesti
Sequenze di espressioni
Eseguibili e librerie dinamiche (dll)
Binding (associazione/legame)
Lista come struttura ricorsiva
Funzioni
Funzioni di ordine superiore
Liste lambda
Ambito dinamico (Dynamic scope)
Lista degli argomenti di una funzione
Lambda-macro
Contesti
Ambito lessicale (Lexical scope)

Ciao Mondo!
-----------
Con newLISP installato sul tuo sistema, al prompt della riga di comando della shell (cmd in windows) inserisci newlisp per avviare la REPL (Read, Eval, Print, Loop).
Su Linux, la console sarebbe simile a questa:

$ newlisp
> _

E su piattaforme Windows, sarebbe simile a questa.

c:\> newlisp
> _

Dopo l'avvio, newLISP risponde con il simbolo del prompt.

> _

Nota del traduttore:
per utilizzare questo documento con notepad++ e la REPL di newLISP ho eliminato il simbolo del prompt ">" quando viene seguito da un'espressione (in questo modo è possibile eseguire l'espressione direttamente). Inoltre l'output della REPL viene preceduto dalla stringa "->".

Inserisci l'espressione qui sotto per stampare "Ciao Mondo!" sulla console.

(println "Ciao Mondo!")

newLISP stampa il valore dell'espressione immessa nel prompt della REPL prima di eseguire il ciclo e richiedere un nuovo input.

(println "Ciao Mondo!")
;-> Ciao Mondo!
;-> "Ciao Mondo!"
> _

Perché è stato stampato due volte?

La funzione println stampa la prima riga, es. Ciao Mondo! nella console a causa effetto collaterale (side effect) della chiamata di funzione.
Inoltre la funzione println restituisce la stringa di valore "Ciao Mondo!", cioè il suo ultimo argomento, alla REPL che a sua volta stampa la seconda riga, cioè

"Ciao Mondo!"

La REPL valuta qualsiasi espressione e non solo le chiamate di funzione:

"Ciao Mondo!"
;-> "Ciao Mondo!"
> _

Se inserisci l'espressione stringa "Ciao Mondo!", come mostrato sopra, questa restituisce semplicemente se stessa come qualsiasi espressione letterale e come i numeri letterali.

1
;-> 1
> _

A questo punto potresti essere intimorito dalle parentesi. Se iniziate NewLISP conoscendo un normale linguaggio informatico, sembrerebbe più naturale scrivere una chiamata di funzione nel modo seguente:

println ("Ciao Mondo!")

Dovrai solo credermi sulla parola - nel tempo preferirai di gran lunga:

(println "Ciao Mondo!")

a

println ("Ciao Mondo!")

per ragioni che non possono essere adeguatamente spiegate fino a quando non avrai visto molti più esempi di elaborazione di liste simboliche.

Codice sorgente e dati sono intercambiabili
-------------------------------------------
Lisp è l'acronimo di List Processor. Poiché le liste sono utilizzate per rappresentare sia il codice che i dati in Lisp, questi ultimi sono essenzialmente intercambiabili.
La precedente espressione println è in realtà una lista con due elementi:

(println "Ciao mondo!")

Il primo elemento è:

println

e l'ultimo elemento è:

"Ciao Mondo!"

Lisp interpreta sempre una lista come una chiamata di funzione, a meno che non venga "quotata", indicando così che dovrebbe essere presa come un'espressione simbolica, cioè come un dato.
Per "quotare" occorre inserire il carattere " ' " davanti all'espressione.

'(println "Ciao Mondo!")
;-> (println "Ciao Mondo!")
> _

Un'espressione simbolica può tuttavia essere valutata come codice sorgente con la funzione "eval".

(eval '(println "Ciao Mondo!"))
;-> Ciao Mondo!
;-> "Ciao Mondo!"
> _

Un programma Lisp può modificare se stesso durante l'esecuzione (runtime) costruendo liste di dati ed eseguendoli come codice sorgente!

(eval '(eval '(println "Ciao Mondo!")))
;-> Ciao Mondo!
;-> "Ciao Mondo!"
> _

In realtà il carattere " ' " rappresenta la funzione quote (syntactical sugar).

(quote (println "Ciao Mondo!"))
;-> (println "Ciao Mondo!")
> _

Pensa alla funzione quote come una funzione che utilizza i suoi argomenti letteralmente, cioè come simboli.

'x
;-> x
(quote x)
;-> x
'(1 2 tre "quattro")
;-> (1 2 tre "quattro")
> _

I simboli, come x e tre sopra, e le liste simboliche svolgono un ruolo di vitale importanza nell'intelligenza artificiale (AI). Questo tutorial non riguarderà argomenti di AI. Tuttavia, una volta che avrai imparato a programmare in Lisp, sarai in grado di seguire tranquillamente gli esempi Lisp che si trovano nella maggior parte dei libri di testo su AI.
Considera il seguente esempio.

'Ciao
;-> Ciao
"Ciao"
;-> "Ciao"
> _

Il simbolo 'Ciao non è lo stesso della stringa "Ciao". Ora puoi capire perché la REPL stampa le virgolette per indicare una stringa, distinguendola quindi da un simbolo con le stesse lettere.

Argomenti di funzione
---------------------
La funzione println può avere un numero variabile di argomenti.

(println "Ciao " "Mondo!")
;-> Ciao Mondo!
;-> "Mondo!"
> _

Gli argomenti sono semplicemente concatenati attraverso il flusso di output mentre l'ultimo argomento viene restituito come valore della chiamata di funzione.
In genere, gli argomenti passati a una funzione vengono valutati da sinistra a destra e i valori risultanti vengono quindi passati alla funzione. Si dice che gli argomenti correnti di una funzione sono valutati in modo rigoroso. Questo è noto come valutazione applicata in base all'ordine (applicative-order evaluation).
Ma notate che, per la funzione quote, questo non è il caso:

(quote (println "Ciao Mondo!"))
;-> (println "Ciao Mondo!")
> _

Se il suo argomento, vale a dire:

(println "Ciao Mondo!")

fosse stato rigorosamente valutato, avremmo visto:

Ciao Mondo!

visualizzato sulla console.
La funzione di quote è una funzione atipica a volte definita "forma speciale".
Puoi scrivere le tue funzioni speciali con newLISP. Queste sono chiamate macro e i loro argomenti sono detti "chiamati per nome", cioè letteralmente.
Questo è noto come ordine di valutazione normale e diciamo che la strategia di valutazione è pigra (lazy). In altre parole, gli argomenti di una macro non vengono valutati fino a quando, e solo se, si specifica direttamente l'esecuzione della valutazione (come vedremo in seguito).
Quindi, l'argomento della funzione quote viene preso alla lettera e restituito. In un certo senso, quote è una funzione di identità con una strategia di valutazione pigra (lazy evaluation). Non si preoccupa mai di valutare i sui argomenti, invece la restituisce letteralmente nella sua forma simbolica di codice sorgente.
Senza forme speciali, i costrutti di controllo del flusso trovati in altri linguaggi non potrebbero essere implementati in una linguaggio con solo liste di espressioni come sintassi con cui lavorare. Ad esempio,  considera il seguente if:

(if true (println "Ciao") (println "Arrivederci"))
;-> Ciao
;-> "Ciao"
> _

La forma speciale if prende tre argomenti:

sintassi: (if condizione conseguenza alternativa)

condizione  => vero
conseguenza => (println "Ciao")
alternativa => (println "Arrivederci")

L'argomento della condizione viene sempre valutato (strict evaluation), ma le conseguenze e le espressioni alternative sono valutate in modo pigro (lazy). Inoltre l'espressione alternativa è facoltativa.
Si noti che if è un'espressione. Restituisce il valore della espressione conseguenza o dell'espressione alternativa a seconda che la condizione sia rispettivamente vera (true) o falsa. Nell'esempio sopra, sappiamo che l'espressione alternativa non è stata valutata, perché il suo effetto collaterale della stampa "Arrivederci" sulla console non si è mai verificato.
Il valore di un'espressione if con una condizione falsa che non ha alternative e vale semplicemente nil (nullo). Il valore nil (nullo) indica vuoto o falso a seconda dell'interpretazione richiesta.
Nota: nella maggior parte dei linguaggi di programmazione tradizionali if è un'istruzione, e quindi non ha un valore di ritorno.
Se il Lisp non avesse avuto una strategia di valutazione pigra (lazy), non sarebbe possibile implementare forme speciali o macro. Senza una strategia di valutazione pigra, sarebbe stato necessario aggiungere parole chiave e/o sintassi al linguaggio. Quale tipi di sintassi hai visto fino ad ora, oltre alla parentesi e alle virgolette? Risposta: non molto!
Il rovescio della valutazione pigra (lazy) è che ora possibile aggiungere il proprio controllo di flusso al linguaggio estendendo così la "sintassi" di Lisp che consente di incorporare mini-linguaggi specifici dell'applicazione. La scrittura di funzioni e di macro sarà trattata in una sezione successiva di questo tutorial.

Effetti collaterali e contesti
------------------------------
Senza effetti collaterali, avere un REPL sarebbe inutile. Per capire il perché, consideriamo la seguente sequenza di espressioni:

(set 'ciao "Ciao")
;-> "Ciao"
(set 'mondo " Mondo")
;-> " Mondo"
(println ciao mondo)
;-> Ciao Mondo
;-> "Mondo"
> _

La funzione set sopra ha un effetto collaterale, come dimostrato di seguito:

ciao
;-> "Ciao"
mondo
;-> " Mondo"
> _

I simboli 'ciao e 'mondo sono legati nel contesto corrente a "Ciao" e "Mondo" rispettivamente.
Tutte le funzioni integrate (built-in) sono associate a simboli del contesto MAIN.

println
println@<409040>
set
set@<4080D0>
> _

Questo ci dice che println è associato a una funzione chiamata println con un punto di ingresso di 409040 (Versioni (build) diverse di newLISP avranno ovviamente punti di ingresso diversi per println).
Il contesto predefinito è MAIN. Un contesto è essenzialmente uno spazio dei nomi di stato. Impareremo in seguito i contesti definiti dall'utente.
Si noti che il simbolo letterale 'ciao valuta se stesso:

'ciao
;-> ciao
> _

La valutazione del simbolo 'ciao restituisce il valore a cui è associato nel contesto corrente:

(eval 'ciao)
;-> "Ciao"
> _

Se il simbolo non è associato quando viene valutato, restituisce semplicemente nil:

(eval 'z)
;-> nil
> _

In realtà non abbiamo bisogno di eval, dal momento che il simbolo senza la funzione quote viene automaticamente valutato nel contesto attuale:

ciao
;-> "Ciao"
z
;-> nil
> _

Quindi il valore di ciao e di mondo sono "Ciao" e "Mondo" rispettivamente:

(println ciao mondo)
;-> Ciao Mondo
;-> "Mondo"
> _

Cosa verrebbe visualizzato se inseriamo quanto segue?

(println 'ciao 'mondo)
?

Pensaci per un momento.

La funzione println visualizza i simboli uno immediatamente dopo l'altro sulla prima riga:

(println 'ciao 'mondo)
;-> ciaomondo
;-> mondo
> _

Sequenze di espressioni
-----------------------
Una sequenza di espressioni può essere combinata in un'espressione composta con la funzione begin:

(begin "Ciao" " Mondo!")
;-> " Mondo!"
> _

Cosa è successo a "Ciao"? Poiché un'espressione composta restituisce un singolo valore, restituisce il valore della sua ultima espressione. Ma le espressioni sono infatti valutate in sequenza. È solo che l'espressione "Ciao" non ha alcun effetto collaterale, quindi il suo valore di ritorno viene scartato e non si vede mai alcuna prova della sua valutazione:

(begin (print "Ciao") (println " Mondo!"))
;-> Ciao Mondo!
;-> " Mondo!"
> _

Questa volta, gli effetti collaterali di print e println sono evidenziati nella finestra della console e l'ultimo valore restituito viene visualizzato dal REPL.
La funzione begin è utile per combinare espressioni in una singola espressione. Ricordiamo la forma speciale if:

(if true
  (begin
    (print "Ciao" )
    (println " newLISP!"))
  (println "Java/Python/Ruby!"))

;-> Ciao newLISP!
;-> "newLISP!"
> _

Le istruzioni multilinea e le funzioni devono essere immesse premendo il tasto [invio] al prompt. Per uscire dalla modalità multilinea, premere di nuovo il tasto [invio] al prompt.
Ricorda che l’espressione if accetta solo tre argomenti:

sintassi: (if condizione conseguenza alternativa)

L'espressione (begin ...) viene utilizzata per combinare due espressioni in un'unica espressione, che viene quindi considerata come argomento conseguenza.
Terminiamo questa sezione vedendo come trasformare il nostro esempio in un programma eseguibile (exe).
Si noti che è possibile uscire dalla REPL in qualsiasi momento con la funzione (exit):

> (exit)
$ (linux) oppure c:\> (windows)

Puoi anche uscire con un argomento intero opzionale:

> (exit 3)

Questo può essere utile nell'elaborazione di shell o file batch creando punti di uscita con valori diversi in base agli errori avvenuti.
Ora possiamo mettere la nostra sequenza di espressioni in un file sorgente:

 ;Questo è un commento
 ;hw.lsp
 (println "Ciao mondo!")
 (exit)

E possiamo eseguirlo dalla riga di comando, in questo modo:

$ newlisp hw.lsp
Ciao mondo!

O in Windows:

c: \> newlisp hw.lsp
Ciao mondo!

Eseguibili e librerie dinamiche (dll)
-------------------------------------
Creare eseguibili nativi della piattaforma (exe in windows) e collegarsi alle librerie di collegamenti dinamici (dll in windows e so in linux) con newLISP è semplice.
Nelle vecchie versioni, dovresti trovare il file link.lsp nella sottodirectory degli esempi oppure dovresti scaricare gli esempi e i moduli separatamente da www.newlisp.org.
Con la versione 10.4.7 il processo di collegamento dei file sorgente LISP con un nuovo eseguibile LISP è cambiato e il file link.lsp non è più necessario.
Il processo è ora disponibile utilizzando l'opzione della riga di comando -x.
Consideriamo il seguente programma:

;; uppercase.lsp - Link example
(println (upper-case (main-args 1)))
(exit)

Il programma uppercase.lsp prende il primo argomento e lo converte in maiuscolo:
Le operazioni per creare un file eseguibilie sono le seguenti:

# in OSX, Linux e altri UNIX
newlisp -x "uppercase.lsp" "uppercase"

# impostiamo i permessi di esecuzione
chmod 755 uppercase

# in Windows il file eseguibile deve avere estensione .exe
newlisp -x "uppercase.lsp" "uppercase.exe"

In questo modo vengono messi insieme newLISP.exe e uppercase.lsp per creare il file eseguibile uppercase.exe. Per eseguire il programma occorre scrivere dal prompt dei comandi:

uppercase "testo da convertire"

L'output della console sarà:

TESTO DA CONVERTIRE

Nota: i file di inizializzazione (init.lsp o .init.lsp) non vengono caricati prima dell'esecuzione del programma.

Anche il collegamento a una libreria di collegamento dinamico è semplice. Sulle piattaforme Windows, le seguenti espressioni visualizzeranno una finestra di dialogo:

(import "user32.dll" "MessageBoxA")
(MessageBoxA 0 "Ciao mondo!" "newLISP Scripting Demo" 0)

Si noti che MessageBoxA è l'interfaccia di una funzione C nella libreria utente del sistema win32.
L'esempio seguente mostra come chiamare una funzione echo esterna scritta in C e compilata con Visual C ++:

// echo.c

#include <STDIO.H>
#define DLLEXPORT _declspec (dllexport)

DLLEXPORT void echo (const char * msg)
{
  printf (msg);
}

Dopo aver compilato il file echo.c in una DLL, può essere importata con il seguente codice:

(import "echo.dll" "echo")

(echo "Hello newLISP scripting World!")

La facilità con cui newLISP può collegarsi alle DLL è una caratteristica che lo rende un linguaggio di scripting ideale.
Assicurati di studiare gli altri esempi e i moduli che mostrano come programmare con i socket, connettersi ai database, ecc.

Binding (associazione/legame)
-----------------------------
Come mostrato in precedenza, la funzione set viene utilizzata per associare un valore a un simbolo:

(set 'y 'x)
;-> x
> _

In questo caso il valore 'x, un simbolo, è stato associato alla variabile denominata y .
Ora considera il seguente legame:

(set y 1)
;-> 1
> _

Dato che y non è quotato, esso viene valutato come 'x e di conseguenza 1 è legato alla variabile di nome x.

y
;-> x
x
;-> 1
> _

E ovviamente y rimane legato a 'x come mostrato sopra.

La funzione setq ti evita di dover scrivere quote ogni volta.

(setq y 1)
;-> 1
> _

Ora la variabile chiamata y è stata associata al valore 1.

y
;-> 1
> _

La funzione define funziona allo stesso modo:

(define y 2)
;-> 2
y
;-> 2
> _

Si noti che sia set che setq possono associare più variabili alla volta.

(set 'x 1 'y 2)
;-> 2
(setq x 3 y 4)
;-> 4
x
;-> 3
y
;-> 4
> _

(Dovresti verificare questi esempi mentre procediamo in modo che rimangano nella tua memoria.)
A differenza di setq, la funzione define può associare solo un'associazione alla volta. Tuttavia ci sono altri usi per define che saranno discussi a breve.
Ovviamente le funzioni set, setq e define hanno effetti collaterali oltre a restituire un valore. L'effetto collaterale è che l'associazione che lega la variabile ad un valore viene memorizzata nella tabella corrente dei simboli (implicita).
Possiamo visualizzare questa tabella di simboli implicita come una lista di associazioni:

'((x 1) (y 2))
;-> ((x 1) (y 2))
> _

L'elenco di associazioni sopra riportato è una lista di liste. Le liste annidate hanno due elementi ciascuna, vale a dire una coppia chiave-valore. Il primo elemento rappresenta il nome dell'associazione mentre l'ultimo elemento rappresenta il suo valore.

(first '(x 1))
;-> x
(last '(x 1))
;-> 1
> _

Il primo elemento di una lista di associazioni è naturalmente un'associazione:

(first '((x 1) (y 2)))
;-> (x 1)
> _

Le funzioni incorporate assoc e lookup sono fornite per facilitare il lavoro con gli elenchi di associazioni:

(assoc 'x' ((x 1) (y 2) (x 3)))
;-> (x 1)
(lookup 'x' ((x 1) (y 2) (x 3)))
;-> 1
> _

(La funzione lookup ha anche altri usi che puoi trovare nella documentazione di newLISP)
Nota che sia assoc e lookup restituiscono il legame e il valore rispettivamente della prima associazione che ha come chiave 'x. Questo punto sarà importante in seguito, man mano che si svilupperà la discussione sulle tabelle dei simboli e sui contesti di visibilità delle variabili (scope).

Lista come struttura ricorsiva
------------------------------
Qualsiasi lista che includa una lista di associazioni può essere vista come una struttura dati ricorsiva, probabilmente annidata. Una lista, per definizione, ha un primo elemento, una coda e un ultimo elemento:

(first '(1 2 3))
;-> 1
(rest '(1 2 3))
;-> (2 3)
(last '(1 2 3))
;-> 3

Ma considera quanto segue:

(rest '(1))
;-> ()
(rest '())
;-> ()
(first '())
;-> ERR: list is empty in function first : '()
(last '())
;-> ERR: list is empty in function last : '()

Il rest di una lista vuota o di un elenco con un solo elemento è di nuovo la lista vuota. Cercare di estrarre il primo o l'ultimo elemento da una lista vuota genera un errore. Si noti che (diversamente dal LISP) nil non rappresenta mai una lista vuota! Solo gli elementi inesistenti sono rappresentati con il valore nil!

(Si noti che la definizione di lista di newLISP è diversa da quella definita nel LISP e in Scheme)

Una lista può essere processata con un algoritmo ricorsivo.

Ad esempio, un algoritmo ricorsivo per calcolare la lunghezza di una lista generico potrebbe essere definito come segue:

(define (list-length a-list)
   (if a-list
   (+ 1 (list-length (rest a-list)))
   (0)))

Prima di tutto, si noti che define può essere utilizzata non solo per definire variabili, ma anche funzioni. Il nome della nostra funzione è list-length e richiede un argomento e precisamente una lista (a-list). Tutti gli altri argomenti di define costituiscono il corpo della funzione.
I nomi dei simboli (a differenza dei linguaggi principali) possono utilizzare tutti (quasi) i caratteri, permettendo uno stile di denominazione estrememente ampio. Assicurati di consultare la documentazione di newLISP per vedere le regole complete per la denominazione dei simboli!
La condizione if interpreta qualsiasi valore che non sia nil o la lista vuota (),  come true (vero). Così abbiamo potuto semplicemente fare il test sulla lista a-list ottenendo lo stesso risultato:

 (if a-list
     ...

Fintanto che una lista contiene il primo elemento (first) rimanente, il conteggio continua aggiungendo 1 al risultato della chiamata list-length sul resto (rest) della lista. Quando il primo elemento di una lista vuota è nil, viene restituito il valore alternativo zero che permette anche di uscire dalle chiamate ricorsive dell’algoritmo annidate nello stack (pila).
Diciamo che una lista è una struttura dati ricorsiva perché la sua definizione è ricorsiva e non semplicemente perché è suscettibile di algoritmi di elaborazione ricorsivi.
Una definizione ricorsiva di una lista potrebbe eseere qualcosa di simile:

 type list :: = empty-list |  first * list

Una lista è o la lista vuota o una lista con un primo elemento e una coda che è di per sé una lista.
Poiché il calcolo della lunghezza di una lista è abbastanza comune, esiste una funzione di libreria predefinita chiamata length che fa il lavoro per noi:

 (list-length '(1 2 5))
 ;-> 3
 (length '(1 2 5))
 ;-> 3
 > _

Torneremo alla nostra discussione sulle funzioni definite dall'utente più avanti.
Il concetto di una tabella di simboli implicita può essere visto come una successione di valutazioni delle espressioni:

 (set 'x 1)
 ;-> 1
 (+ x 1)
 ;-> 2
 > _

Quindi gli effetti collaterali tipicamente influenzano il flusso di output o questo contesto implicito. Una lista di associazioni è solo un modo per visualizzare concettualmente questa tabella di simboli implicita.

Supponiamo di voler ora cambiare momentaneamente il legame di una variabile senza sovrascriverlo in modo permanente.

 (set 'x 1' y 2)
 ;-> 2
 (let ((x 3) (y 4))
    (println x)
    (list x y))
 ;-> 3
 ;-> (3 4)
 x
 ;-> 1
 y
 ;-> 2
 > _

Si noti che x e y sono legati rispettivamente a 1 e 2 nella tabella dei simboli impliciti. L'espressione let associa momentaneamente (dinamicamente) x e y a 3 e 4 per la durata dell'espressione let. In altre parole, il primo argomento di let è un elenco di associazioni e gli argomenti rimanenti vengono eseguiti in sequenza.

La funzione list prende un numero variabile di argomenti che vengono valutati rigorosamente restituendo ogni valore risultante in una lista.

La forma let è simile alla forma iniziale mostrata in precedenza, tranne che estende dinamicamente la tabella dei simboli implicita per la durata del “blocco let” che include tutti gli argomenti dell'espressione let . Questo è possibile perché questi argomenti vengono pigramente valutati all'interno del contesto esteso del “blocco let”. Se visualizzassimo la tabella dei simboli implicita all'interno del blocco let, avremmo la seguente lista di associazioni estesa:

 '((y 4) (x 3) (y 2) (x 1))

Poiché la ricerca inizia da sinistra, i valori di associazione di x e y vengono restituiti, in modo da “nascondere: i loro valori originali al di fuori dell’espressione let.
Quando l'espressione let termina, la tabella dei simboli si presenta come segue:

 '((y 2) (x 1))

E di conseguenza x e y assumono i valori originali (cioè quelli che avevano prima dell’esecuzione dell’espressione let).

Per capire meglio, confronta quanto segue:

 (begin (+ 1 1) (+ 1 2) (+ 1 3))
 ;-> 4
 (list (+ 1 1) (+ 1 2) (+ 1 3))
 ;-> (2 3 4)
 (quote (+ 1 1) (+ 1 2) (+ 1 3))
 ;-> (+ 1 1)
 (quote (2 3 4))
 ;-> (2 3 4)
 (let () (+ 1 1) (+ 1 2) (+ 1 3))
 ;-> 4

Nota che la funzione quote prende solo un argomento (impareremo in seguito come tale funzione è in grado di ignorare ulteriori argomenti estranei). L'espressione let senza nessuna associazione dinamica (cioè senza la dichiarazione di nuove variabili) si comporta come se fosse la funzione begin.

Ora determina che cosa restituiscono le seguenti espressioni (le risposte sono di seguito).

 (setq x 3 y 4)
 (let ((x 1) (y 2)) x y)
 ;-> ?
 x
 ;-> ?
 y
 ;-> ?

 (setq x 3 y 4)
 (begin (set 'x 1 'y 2) x y)
 ;-> ?
 x
 ;-> ?
 y
 ;-> ?

Risposte:

 (setq x 3 y 4)
 (let ((x 1) (y 2)) x y)
 ;-> 2
 x
 ;-> 3
 y
 ;-> 4

 (setq x 3 y 4)
 (begin (set 'x 1 'y 2) x y)
 ;-> 2
 x
 ;-> 1
 y
 ;-> 2

Adesso proviamo qualcosa di un pò più difficile.

 (setq x 3 y 4)
 (let ((y 2)) (setq x 5 y 6) x y)
 ;-> ?
 x
 ;-> ?
 y
 ;-> ?

Risposte:

 (setq x 3 y 4)
 (let ((y 2)) (setq x 5 y 6) x y)
 ;-> 6
 x
 ;-> 5
 y
 ;-> 4

Per capire perché la risposta sopra è corretta, considera quanto segue.

 '((y 2) (y 4) (x 3))

La lista di associazioni sopra riportata rappresenta la tabella dei simboli quando si entra nel corpo dell'espressione let subito dopo il l’associazione (dinamica) di y .

Dopo:

 (setq x 5 y 6)

la tabella dei simboli estesa diventa la sequente:

 '((y 6) (y 4) (x 5))

E al ritorno dall'espressione let viene modificata in questo modo:

 '((y 4) (x 5))

Quindi set, setq e define associano il simbolo se viene trovato nella tabella dei simboli oppure inseriscono la nuova associazione all’inizio (sulla parte anteriore) della lista di associazioni. Torneremo sulla visibilità delle variabili (scoping) dopo aver esplorato ulteriormente le funzioni.

Funzioni
--------
L’uente può definire nuove funzioni (come discusso in precedenza). La seguente funzione f restituisce la somma dei suoi due argomenti:

 (define (f x y) (+ x y))

Questa è in realtà una scorciatoia per qualsiasi delle seguenti definizioni:

 (define f (lambda (x y) (+ x y)))

 (setq f (lambda (x y) (+ x y)))

 (set 'f (lambda (x y) (+ x y)))

L'espressione "lambda" definisce una funzione anonima, cioè una funzione senza nome. Il primo argomento dell'espressione lambda è la sua lista di argomenti formali e le restanti espressioni costituiscono una sequenza (ritardata) di espressioni che costituiscono il corpo della funzione (questa sequenza di espressioni viene detta “ritardata” perchè viene valutata solamente quando chiamiamo la funzione).

 (f 1 2)
 ;-> 3
 ((lambda (x y) (+ x y)) 1 2)
 ;-> 3
 > _

Ricorda che una lista non quotata viene interpretata come una chiamata di funzione in cui tutti gli argomenti sono valutati rigorosamente. Il primo elemento della lista sopra è un'espressione lambda, quindi viene valutata restituendo una funzione anonima che viene poi applicata agli argomenti 1 e 2.

Si noti che le seguenti due espressioni sono essenzialmente le stesse:

 (let ((x 1) (y 2)) (+ x y))
 ;-> 3
 ((lambda (x y) (+ x y)) 1 2)
 ;-> 3
 > _

L'unica vera differenza è che la sequenza di espressioni nell'espressione lambda viene ritardata fino a quando non viene applicata agli argomenti. Applicare l'espressione lambda agli argomenti in effetti crea un’associazione tra gli argomenti formali e gli argomenti effettivi a cui viene applicata la funzione.

Quali sono i valori nelle seguenti espressioni?

 (setq x 3 y 4)
 ((lambda (y) (setq x 5 y 6) (+ x y)) 1 2)
 ;-> ?
 x
 ;-> ?
 y
 ;-> ?

Ricorda che le espressioni lambda e let sono essenzialmente le stesse.

 (setq x 3 y 4)
 ((lambda (y) (setq x 5 y 6) (+ x y)) 1 2)
 ;-> 11
 x
 ;-> 5
 y
 ;-> 4

Gli argomenti 1 e 2 sono superflui. L'argomento formale y nasconde la y definita al di fuori dell'espressione lambda in modo che l'impostazione di x al valore 5 sia l'unica che ha effetto dopo l’esecuzione (il ritorno) della funzione lambda.

Funzioni di primo ordine
------------------------
Le funzioni in Lisp sono valori di prima classe (ordine). Come i dati, possono essere create in fase di esecuzione e passate come qualsiasi altro valore di dati per effettuare una programmazione funzionale di ordine superiore. Si noti che i puntatori di funzione che troviamo nel linguaggio in C (e anche gli event-listener in Java/Csharp), ad esempio, non sono funzioni di prima classe. Sebbene possano essere trasmessi come dati, non possono mai essere creati in fase di esecuzione (come i dati).

Forse la funzione di ordine superiore più comunemente utilizzata è la funzione map (talvolta chiamata collect in linguaggi object oriented che hanno trasferito l'idea dal Lisp tramite Smalltalk).

 (map eval '((+ 1) (+ 1 2 3) 11))
 ;-> (1 6 11)
 > _

La funzione map applica la funzione eval a ciascun elemento della lista data. Si noti che la funzione + accetta un numero variabile di argomenti.

In questo caso avremmo potuto semplicemente scrivere quanto segue:

 (lista (+ 1) (+ 1 2 3) 11)
 ;-> (1 6 11)
 > _

Ma la funzione map può anche eseguire operazioni più interessanti.

 (map string? '(1 "Hello" 2 "World!")))
 ;-> (nil true true true)
 > _

La funzione map può processare più di una lista come argomento.

 (map + '(1 2 3 4)' (4 5 6 7) '(8 9 10 11))
 ;-> (13 16 19 22)
 > _

Alla prima iterazione + viene applicato il primo elemento di ciascuna lista.

 (+ 1 4 8)
 ;-> 13
 > _

Supponiamo di voler rilevare quali elementi di una lista sono pari:

 (map (fn (x) (= 0 (% x 2))) '(1 2 3 4))
 (nil true true true)
 > _

"fn" è una scorciatoia per "lambda":

 (fn (x) (= 0 (% x 2)))) (lambda (x) (= 0 (% x 2))))
 > _

L'operatore rimanente % viene utilizzato per determinare se un numero è divisibile per 2 (senza resto).

La funzione filter è un'altra funzione di ordine superiore comunemente utilizzata (talvolta chiamata select nelle librerie dei linguaggi Object-Oriented):

 (filter (fn (x) (= 0 (% x 2))) '(1 2 3 4))
 ;-> (2 4)
 > _

La funzione index può essere utilizzata invece per identificare gli indici degli elementi nell'elenco originale.

 (index (fn (x) (= 0 (% x 2))) '(1 2 3 4))
 ;-> (1 3)
 > _

La funzione apply è un'altra funzione di ordine superiore.

 (apply + '(1 2 3))
 ;-> 6
 > _

Perché non scrivere semplicemente (+ 1 2 3) ?

A volte potresti non sapere in anticipo quale funzione verrà applicata.

 (setq op +)
 ;-> + <40727D>
 (applica op '(1 2 3))
 ;-> 6
 > _

Questo approccio potrebbe essere utilizzato, per esempio, per implementare un dispatcher  dinamico.

Liste lambda
------------
Considera la seguente funzione:

 (define (f x y) (+ x y z))
 ;-> (lambda (x y) (+ x y z))
 f
 ;-> (lambda (x y) (+ x y z))
 > _

La funzione è un tipo speciale di lista noto come "lista lambda".

 (first f)
 ;-> (x y)
 (last f)
 ;-> (+ x y z)
 > _

Quindi una funzione "compilata" può essere esaminata (introspezione) in fase di esecuzione. In effetti può anche essere modificata in fase di esecuzione!

 (setf (n 1 f) '(+ x y z 1))
 (lambda (x y) (+ x y z 1))
 > _

(Assicurati di controllare la funzione nth-set nella documentazione di newLISP)

La funzione expand è utile in generale per modificare le liste, comprese le liste lambda.

 (let ((z 2)) (expand f 'z))
 ;-> (lambda (x y) (+ x y 2 1))
 > _

La funzione expand prende una lista di argomenti e sostituisce i simboli al suo interno con i valori simbolici di tutti gli argomenti rimanenti.

Ambito dinamico (Dynamic scope)
-------------------------------
Considera la seguente definizione di funzione:

 (define f
  (let ((x 1) (y 2))
    (lambda (z) (lista x y z))))

 ;-> (lambda (z) (lista x y z))
 > _

Da notare che il valore di f è solo lambda:

 f
 ;-> (lambda (z) (lista x y z))
 (setq x 3 y 4 z 5)
 ;-> 5
 (f 1)
 ;-> (3 4 1)
 (let ((x 5) (y 6) (z 7)) (f 1))
 ;-> (5 6 1)

Anche se l'espressione lambda è definita all'interno dell'ambito lessicale della espressione let che associa x a 1 e y a 2, al momento della sua chiamata è l'ambito dinamico che conta. Diciamo che l’associazione delle espressioni lambda in newLISP è dinamico (rispetto all’associazione lessicale del Common Lisp e di Scheme).

Qualsiasi variabile libera di un'espressione lambda viene associata dinamicamente nel momento in cui viene valutato il corpo delle espressioni. Le variabili non specificate (non associate) nella lista degli argomenti formali sono chiamate libere (free).

Possiamo usare la funzione di expand mostrata in precedenza per “chiudere” un'espressione lambda, cioè per associare tutte le variabili libere:

 (define f
  (let ((x 1) (y 2))
    (expand (lambda (z) (lista x y z)) 'x 'y)))

 ;-> (lambda (z) (lista 1 2 z))
 > _

Si noti che l'espressione lambda non ha variabili libere ora.

Tuttavia, "chiudere" l'espressione lambda con la funzione expand non è la stessa cosa della chiusura lessicale lambda che si trova in CL (Common Lisp) e Scheme. Le chiusure lessicali esistono in newLISP e saranno discusse in una sezione successiva basata sui contesti.

Lista degli argomenti di una funzione
-------------------------------------
Una funzione in newLISP può avere un numero qualsiasi di argomenti (entro limiti ragionevoli):

 (define (f z , x y)
  (setq x 1 y 2)
  (list x y z))

 ;-> (lambda (z , x y) (setq x 1 y 2) (list x y z))
 > _

I quattro argomenti formali di f sono:

 z , x y

Si noti che la virgola è il nome di un argomento (vedere le regole di denominazione dei simboli). Qui viene usato come espediente visivo.

L'unico argomento intenzionale è z .

Se il numero di argomenti formali supera il numero di argomenti effettivi a cui viene applicata la funzione, gli argomenti formali rimanenti vengono semplicemente inizializzati a nil.

 (f 3)
 ;-> (1 2 3)
 > _

In questo caso:
 , x y

sono tutti e tre inizializzati a nil. Poiché x e y appaiono come argomenti formali, agiscono come variabili locali, quindi:

 (setq x 1 y 2)

non sovrascrive il legame di x e y al di fuori dell'ambito dell'espressione lambda.

Avremmo potuto scrivere quanto segue per ottenere lo stesso effetto delle variabili locali:

 (define (f z)
  (let ((x 1) (y 2))
    (list x y z)))

;->  (lambda (z)
;->   (let ((x 1) (y 2))
;->     (list x y z)))
 > _

La virgola e gli argomenti formali inutilizzati sono un idioma utilizzato spesso in newLISP per fornire variabili locali.

Una funzione può anche essere chiamata con più argomenti di quelli che sono specificati nella sua lista di argomenti formali. In questo caso gli argomenti in eccesso vengono semplicemente ignorati.

Gli argomenti formali in eccedenza possono quindi essere trattati come argomenti opzionali:

 (define (f z x y)
  (if (not x) (setq x 1))
  (if (not y) (setq y 2))
  (lista x y z))

Ora se f viene chiamata con un solo argomento, x e y sono associati rispettivamente con i valori 1 e 2.

Lambda-macro
------------
Gli argomenti effettivi di una funzione lambda-macro non vengono valutati rigorosamente (come nel caso di una funzione lambda):

 (define-macro (my-setq _key _value)
  (set _key (eval _value)))

Poiché _key non viene valutato, si trova in forma simbolica (cioè, è come se fosse quotato). Anche _value è in forma simbolica, quindi deve essere ancora valutato:

 (my-setq key 1)
 ;-> 1
 key
 ;-> 1
 > _

Il carattere underscore “_” viene utilizzato per impedire la “cattura” delle variabili.
Considera quanto segue:

 (my-setq _key 1)
 ;-> 1
 _key
 ;-> nil
 > _

Che cosa è successo?

L’espressione:

 (set _key 1)

imposta semplicemente la variabile locale _key . Diciamo che la variabile _key è stata catturata dalla "espansione" della macro. Scheme ha macro “igieniche” (hygenic) che sono “pulite” (clean) nel senso che garantiscono la protezione delle variabili (cioè impediscono la cattura delle variabili). Normalmente, utilizzare il carattere underscore “_” nei nomi degli argomenti formali della macro è sufficiente per impedire la cattura delle variabili.
La funzione define-macro è una scorciatoia per associare un'espressione lambda-macro in un unico passaggio.

 (define my-setq
  (lambda-macro (_key _value)
  (set _key (eval _value))))

La definizione sopra è equivalente alla precedente definizione di my-setq.

Oltre alla valutazione lazy, le lambda-macro permettono anche di fornire un numero variabile di argomenti:

 (define-macro (my-setq)
  (eval (cons 'setq (args))))

La funzione cons unisce una lista con un nuovo primo elemento (inserisce un elemento al primo posto di una lista):

 (cons 1 '(2 3))
 ;-> (1 2 3)
 > _

La definizione di my-setq è ora un'implementazione più completa che consente di associare/utilizzare un numero variabile di argomenti:

 (my-setq x 10 y 11)
 ;-> 11
 x
 ;-> 10
 y
 ;-> 11
 > _

La chiamata alla funzione (args) restituisce l'elenco di tutti gli argomenti alla lambda-macro, cioè quelli non valutati.

Quindi la macro my-setq prima costruisce l'espressione simbolica mostrata sotto:

 '(setq x 10 y 11)

Poi questa espressione viene valutata.

Tuttavia, lo scopo principale delle macro è estendere la sintassi del linguaggio.

Supponiamo di voler introdurre il controllo del flusso repeat...until come estensione della sintassi del linguaggio.

 (repeat-until condition body ...)

La seguente macro permette proprio questo:

 (define-macro (repeat-until _condition)
  (let ((body (cons 'begin (rest (args)))))
  (eval (expand (cons 'begin
    (list body
      '(while (not _condition) body))) 'body '_condition))))

Usando il nostro repeat-until possiamo scrivere:

 (setq i 0)

 (repeat-until (> i 5)
  (println i)
  (inc i))

  ;  => 0 1 2 3 4 5

Le macro possono diventare complesse abbastanza rapidamente. Un trucco per convalidarle è sostituire eval con list o println per verificare l'aspetto dell'espansione appena prima di essere valutata:

 (define-macro (repeat-until _condition )
  (let ((body (cons 'begin (rest (args)))))
    (list (expand (cons 'begin
      (list body
        '(while _condition body))) 'body '_condition))))

Ora possiamo controllare l'aspetto dell'espansione.

 (repeat-until (> i 5)
 (println i) (inc i))

 ((begin
    (begin
      (println i)
      (inc i))
    (while (> i 5)
      (begin (println i) (inc i)))))
 > _

Contesti
--------
All'avvio il contesto predefinito è MAIN .

 (context)
 ;-> MAIN

Un contesto è uno spazio di nomi:

 (setq x 1)
 ;-> 1
 x
 ;-> 1
 MAIN:x
 ;-> 1
 > _

Una variabile di contesto può essere utilizzata per qualificare completamente un nome di variabile. MAIN:x si riferisce alla variabile x nel contesto MAIN.

Per creare un nuovo spazio di nomi usa la funzione "context":

 (context 'FOO)
 ;-> FOO
 FOO> _

L'istruzione sopra crea lo spazio di nomi (namespace) FOO, se non esiste già e passa ad esso. Il prompt indica lo spazio di nomi corrente soltanto se è diverso da MAIN.

Usa il predicato "context?" per determinare se una variabile è associata ad un contesto:

 FOO> (context? FOO)
 ;-> true
 FOO> (context? MAIN)
 ;-> true
 FOO> (context? Z)
 ;-> nil
 FOO> _

Le funzioni set, setq e define creano le associazioni nel contesto corrente (cioè nello spazio di nomi):

 FOO> (setq x 2)
 ;-> 2
 FOO> x
 ;-> 2
 FOO> FOO:x
 ;-> 2
 FOO> MAIN:x
 ;-> 1
 FOO> _

Per specificare una variabile, ad esempio FOO:x, non è richiesto un nome completo quando è associata al contesto corrente.

Per tornare al contesto MAIN (o a qualsiasi altro) utilizzare la variabile MAIN o il simbolo 'MAIN:

 FOO> (context MAIN)
 ;-> MAIN
 > _

 Oppure

 FOO> (context 'MAIN)
 ;-> MAIN
 > _

La funzione quote deve essere utilizzata solamente quando si creano nuovi contesti.

I contesti non possono essere nidificati: risiedono tutti allo stesso.

Si noti nell'esempio seguente che il nome y, che è definito in MAIN, non è noto nel contesto FOO:

 (setq y 3)
 ;-> 3
 (context FOO)
 ;-> FOO
 FOO> y
 ;-> nil
 FOO> MAIN:y
 ;-> 3
 FOO> _

Il prossimo esempio mostra che MAIN non è speciale in alcun modo: è soltanto il contesto predefinito. MAIN non conosce z, ad esempio:

 FOO> (setq z 4)
 ;-> 4
 FOO> (context MAIN)
 ;-> MAIN
 z
 ;-> nil
 FOO:z
 ;-> 4

Tutti i nomi delle funzione predefinite si trovano in una sezione globale speciale del contesto MAIN:

 println
 ;-> println <40AC99>
 (context FOO)
 FOO
 FOO> println
 ;-> println <40AC99>
 FOO>

La funzione built-in di println è nota in entrambi i contesti MAIN e FOO.
La funzione println è stata "esportata" nello stato globale.

La sequenza di espressioni qui sotto mostra che MAIN:t non è conosciuto inizialmente nei contesti FOO o BAR finché non è stato elevato allo stato globale:

 FOO> (context MAIN)
 ;-> MAIN
 (setq t 5)
 ;-> 5
 (context 'BAR)
 ;-> BAR
 BAR> t ;questa istruzione genera il simbolo t nel contesto BAR
 ;-> nil
 BAR> (context FOO)
 ;-> FOO
 FOO> t ;questa istruzione genera il simbolo t nel contesto BAR
 ;-> nil
 FOO> (context MAIN)
 ;-> MAIN

Eleviamo t allo stato globale (che si trova nel contesto MAIN):

 (global 't)
 ;-> t
 (context FOO)
 ;-> FOO
 FOO> t
 ;-> 5 ;purtroppo si ottiene nil perchè t è già stato creato in FOO
 FOO> (context BAR)
 ;-> BAR
 BAR> t
 ;-> 5 ;purtroppo si ottiene nil perchè t è già stato creato in BAR

Solo i nomi definiti nel contesto MAIN possono essere elevati allo stato globale.

Nota del traduttore
Le seguenti istruzioni funzionano correttamente con lo stato globale:
; partiamo dal contesto MAIN
(context MAIN)
; definiamo il contesto A1
(context 'A1)
;-> A1
; ritorniamo al contesto MAIN
(context MAIN)
;-> MAIN
; definiamo il contesto A1
(context 'A2)
;-> A2
; ritorniamo al contesto MAIN
(context MAIN)
;-> MAIN
; definiamo una variabile
(setq a 2)
;-> 2
; eleviamo la variabile allo stato globale
(global 'a)
;-> a
(context 'A1)
;-> A1
a
;-> 2
(context 'A2)
;-> A2
a
;-> 2
(context MAIN)
;-> MAIN

; Continuiamo l'esempio per vedere cosa accade:
(context 'A3)
;-> A3
(symbols)
;-> () ; la lista dei simboli del contesto A3 è vuota
; Quando si esegue una istruzione, i simboli dell'istruzione vengono associati a quelli esistenti (nel contesto corrente e nello stato globale) oppure, se non esistono, vengono creati nel contesto corrente.
a ; questa istruzione crea il simbolo a nel contesto corrente
;-> nil
(symbols)
;-> (a) ; come volevasi dimostrare.

Ambito lessicale
----------------
Le funzioni set, setq e define associano i nomi nel contesto corrente:

 (context 'F)
 ;-> F
 F> (setq x 1 y 2)
 ;-> 2
 ; elenco dei simboli definiti nel contesto corrente
 F> (symbols)
 ;-> (x y)
 F> _

Si noti che la funzione symbols restituisce i nomi dei simboli associati al contesto corrente.

 F> (define (id z) z)
 ;-> (lambda (z) z)
 F> (symbols)
 ;-> (id x y z)
 F> _

L’ambito lessicale del contesto corrente continua fino al prossimo cambio di contesto. Poiché è possibile in seguito tornare a un particolare contesto, è possibile aumentare il suo ambito lessicale e potrebbe apparire frammentato nel file sorgente.

 F> (context 'B)
 ;-> B
 B> (setq a 1 b 2)
 ;-> 2
 B> _

Per ambito lessicale, intendiamo l'ambito definito dal codice sorgente. I nomi x ed y sono definiti nell'ambito lessicale del contesto F mentre i nomi a e b sono definiti nell'ambito lessicale del contesto B.

Tutte le espressioni lambda sono associate all’ambito lessicale del contesto in cui sono definite. Di conseguenza le espressioni lambda sono in definitiva "chiuse" dal contesto.

L'espressione lambda sottostante si trova nell’ambito lessicale di MAIN e anche nell’ambito lessicale dell'espressione (let ((x 3)) ...).

 (context MAIN)
 (setq x 1 y 2)
 ;-> 2

 (define foo
    (let ((x 3))
      (lambda () (list x y))))

 ;-> (lambda () (list x y))

 (foo)
 ;-> (1 2)
 > _

Ricordiamo che le invocazioni lambda in generale hanno un ambito dinamico. Anche se questo è vero occorre notare che la chiamata alla funzione lambda è in definitiva "chiusa" dall'ambito lessicale del contesto MAIN e non dall'espressione let .

Continuando con l'ultimo esempio possiamo vedere questo ibrido ambito lessicale/dinamico al lavoro:

 (let ((x 4)) (foo))
 ;-> (4 2)
 > _

Questa volta il contesto con ambito lessicale viene ampliato dinamicamente durante l'esecuzione dell'espressione let in modo che (foo) venga richiamato nell'ambito dinamico dell'espressione let.

Cosa succederà se invochiamo (foo) in un contesto alieno?

 (context 'FOO)
 ;-> FOO
 FOO> (let ((x 5)) (MAIN:foo))
 ?

Pensaci per un momento. L'espressione let in alto estende dinamicamente l'ambito lessicale di FOO anziché MAIN.

 FOO> (let ((x 5)) (MAIN:foo))
 ;-> (1 2)
 FOO> _

Che cosa è successo? L’ambito dinamico di MAIN:foo include solo l'ambito del contesto MAIN eventualmente esteso dinamicamente. Poiché l'espressione let estende l'ambito dinamico di FOO, l'invocazione di MAIN:foo non vede l’associazione FOO:x => 5.

La seguente espressione è rivelatrice:

 FOO> MAIN:foo
 ;-> (lambda () (list MAIN:x MAIN:y))
 FOO> _

Quando abbiamo introspettato foo nel contesto MAIN, non abbiamo visto il qualificatore predefinito MAIN.

 (context MAIN)
 foo
 (lambda () (lista x y))
 > _

Quindi, anche se il contesto FOO è stato ampliato in modo dinamico con l’associazione FOO:x => 5, possiamo vedere che quando MAIN:foo viene eseguito esecuzione, limita la sua ricerca solo al contesto MAIN (possibilmente esteso dinamicamente).

Quale sarebbe il valore della seguente espressione?

 (context FOO)
 FOO> (let ((MAIN:x 5)) (MAIN:foo))
 ?

Se hai risposto quanto segue, hai indovinato:

 (context FOO)
 FOO> (let ((MAIN: x 5)) (MAIN:foo))
 ;-> (5 2)
 FOO> _

Diciamo che il contesto, o spazio dei nomi, è la chiusura lessicale di tutte le funzioni definite all'interno di quel contesto.

Comprendere come newLISP traduce e valuta il codice sorgente è fondamentale per capire correttamente il funzionamento dei contesti.

Ogni espressione di livello superiore viene prima tradotta e quindi valutata in ordine da newLISP prima di passare alla successiva espressione di livello superiore. Durante la fase di traduzione tutti i simboli (non qualificati) sono considerati da associare nel contesto corrente. Quindi l'espressione di contesto è semplicemente una direttiva per passare (o creare e passare) al contesto indicato. Questo ha importanti implicazioni come vedremo tra poco:

; prima espressione
(context 'FOO)

;seconda espressione
(setq r 1 s 2)

Ciascuna delle espressioni di cui sopra sono espressioni di livello superiore, nonostante l’indentazione suggerisca diversamente. La prima espressione viene tradotta nel contesto corrente. In questo modo, FOO diventa un simbolo associato al contesto corrente (ad es. MAIN, se non lo è già) prima che l'espressione venga effettivamente valutata. Una volta che l'espressione tradotta viene valutata, avviene il cambio di contesto, che può essere visto chiaramente quando si opera in modalità interprete:

(context MAIN)
(context 'FOO)
;-> FOO
FOO>

Quindi, quando NewLISP si appresta a interpretare:

FOO> (setq r 1 s 2)

il contesto attuale è ora FOO.

Considerare ora il seguente frammento di codice:

(context MAIN)
(begin (context 'FOO) (setq z 5))
;-> 5
FOO> z
;-> nil
FOO> MAIN:z
;-> 5
FOO> _

Che cosa è successo?

Prima la singola espressione di primo livello:

(begin (context 'FOO) (setq z 5))

è stato tradotta nel contesto MAIN. Quindi z è diventata:

(setq MAIN:z 5)

Appena l'espressione composta begin inizia ad essere valutata viene cambiato il contesto, ma la variabile MAIN:z è già impostata a 5 (perchè prima della valutazione vengono associati i simboli). Al ritorno della valutazione dell'espressione composta, il contesto rimane commutato su FOO.

Per capire correttamente questo funzionamento dobbiamo considerare il comportamento del codice sorgente nelle sue due fasi, cioè la traduzione e l'esecuzione, specialmente quando utilizziamo i contesti.

I contesti possono essere utilizzati per organizzare dati e/o funzioni come record o strutture, classi e moduli:

(context MAIN)
(context 'POINT)
;-> POINT
POINT> (setq x 0 y 0)
(context MAIN)

Il contesto POINT mostrato sopra può essere pensato per una struttura che ha due campi (o slot):

POINT:x
;-> 0
> _

Ma poichè i contesti possono anche essere clonati, possono servire da semplice classe o prototipo. La funzione new mostrata di seguito crea un nuovo contesto chiamato p se non esiste già e quindi unisce una copia delle associazioni trovate nel contesto POINT:

(new POINT 'p)
;-> p
p:x
;-> 0
(setq p:x 1)
;-> 1
p:x
;-> 1
POINT:x
;-> 0

La sequenza di espressioni sopra mostra che il contesto p è una copia distinta e separata di POINT.

L'esempio seguente mostra come i contesti potrebbero essere utilizzati per fornire un semplice meccanismo di ereditarietà della struttura dati:

(context 'POINT)
;-> POINT
(setq x 0 y 0)
;-> 0
(context MAIN)
;-> MAIN

(context 'CIRCLE)
;-> CIRCLE
(new POINT CIRCLE)
;-> CIRCLE
(setq radius 1)
;-> 1
(context MAIN)
;-> MAIN

(context 'RECTANGLE)
;-> RECTANGLE
(new POINT RECTANGLE)
;-> RECTANGLE
(setq width 1 height 1)
;-> 1
(context MAIN)

Si noti come la funzione new unisce i campi x e y di POINT in CIRCLE che aggiunge un campo aggiuntivo chiamato radius. RECTANGLE "eredita" da POINT in modo simile.

La macro def-make qui sotto ci consente di definire istanze nominali di un contesto e facoltativamente specificare gli inizializzatori:

(define-macro (def-make _name _ctx)
  (let ((ctx (new (eval _ctx) _name))
        (kw-args (rest (rest (args)))))
  (while kw-args
    (let ((slot (pop kw-args))
          (val (eval (pop kw-args))))
         (set (sym (name slot) ctx) val)))
ctx))

Ad esempio, è possibile creare un'istanza RECTANGLE di nome r e sovrascrivere i valori predefiniti per x e height con la seguente espressione:

(def-make r RECTANGLE x 2 height 2)

La seguente funzione convertirà una "istanza" di contesto in una stringa:

(define (context->string _ctx)
  (let ((str (list (format "#S(%s" (string _ctx)))))
  (dotree (slot _ctx)
    (push (format "%s:%s" (name slot)
           (string (eval (sym (name slot) _ctx))))
            str -1))
    (push ")" str -1)
(join a str)))

Ora possiamo verificare il contenuto di r:

(context->string r)
"#S(r height:2 width:1 x:2 y:0)"
> _

Si noti come vari caratteri come " -> " possono essere usati nei nomi degli identificatori.

Adesso dovresti conoscere abbastanza su newLISP ora per decifrare le funzioni def-make e context->string che abbiamo definito. Assicurati di cercare nella documentazione di newLISP eventuali operazioni primitive come dotree, push, join, ecc. che non ti sono familiari.

Sia Common Lisp che Scheme hanno funzioni lessical scope, questo significa che una chiusura è esclusiva per una particolare funzione. Le funzioni in newLISP possono condividere una chiusura lessicale, cioè il contesto, che è simile a un oggetto i cui metodi condividono uno stato comune. Gli esempi di contesto mostrati finora potrebbero aver incluso anche funzioni. La documentazione di newLISP fornisce diversi esempi di utilizzo dei contesti come semplice oggetti.
 

============================================================================
Sul linguaggio newLISP - FAQ di Lutz Mueller
============================================================================

Questa è la traduzione della pagina web relativa alle FAQ (Frequently Asked Questions) su newLISP:

http://www.newLISP.org/index.cgi?FAQ

1.  Cos'è newLISP e cosa posso fare con questo linguaggio?
2.  Perché newLISP, perché non uno degli altri LISP standard?
3.  Come posso studiare newLISP?
4.  Quanto è veloce newLISP?
5.  newLISP ha le matrici?
6.  newLISP ha le tabelle hash?
7.  newLISP ha una gestione automatica della memoria?
8.  newLISP può passare i dati per riferimento?
9.  Come funziona il variable scoping in newLISP?
10. newLISP gestisce il multiprocessing?
11. Posso usare newLISP per compiti di calcolo distribuiti?
12. Possiamo utilizzare la metodologia di programmazione orientata agli oggetti?
13. Cosa sono di pacchetti e moduli?
14. Quali sono alcune differenze tra newLISP e altri LISP?
15. newLISP funziona sul sistema operativo XYZ?
16. newLISP può gestire i caratteri speciali del mio paese e della mia lingua?
17. L'indicizzazione implicita non infrange le regole di sintassi del LISP?
18. newLISP può essere incorporato in altri programmi?
19. Posso mettere il copyright ai miei script anche se newLISP è concesso in licenza GPL?
20. Dove posso segnalare eventuali bug?

1. Cos'è newLISP e cosa posso fare con questo linguaggio?
---------------------------------------------------------
newLISP è un linguaggio di scripting simile a LISP per fare quelle cose che si fanno tipicamente con linguaggi di scripting: programmazione per internet, amministrazione di sistema, elaborazione testi, incollare diversi altri programmi insieme, ecc. newLISP è un LISP di scripting per persone che sono affascinate dalla bellezza e dal potere espressivo del LISP, ma che hanno bisogno di una versione ridotta per imparare facilmente l'essenziale.

2. Perché newLISP, perché non uno degli altri LISP standard?
------------------------------------------------------------
LISP è un vecchio linguaggio nato, cresciuto e standardizzato in tempi molto diversi da oggi, tempi in cui la programmazione era per persone altamente istruite che hanno progettato programmi. newLISP è un LISP rinato come linguaggio di scripting: pragmatico e casuale, semplice da imparare senza che tu debba conoscere concetti avanzati di informatica. Come ogni buon linguaggio di scripting, newLISP è relativamente semplice da imparare e potente per terminare il proprio lavoro senza problemi.

Vedi anche: "In Praise of Scripting: Real Programming Pragmatics" di Ronald P. Loui

http://web.cs.mun.ca/~harold/Courses/Old/CS2500.F09/Diary/04563874.pdf

newLISP ha un tempo di avvio molto veloce, ha bisogno di poche risorse come spazio su disco e memoria ed ha una pratica API con funzioni native per networking, statistica, machine learning, espressioni regolari, multiprocessing e calcolo distribuito, non aggiunte successivamente con moduli esterni.

3. Come posso studiare newLISP?
-------------------------------
Almeno all'inizio, studia principalmente newLISP utilizzandolo. Se capisci questo:

(+ 1 2 3); calcola la somma di 1,2,3 => 6

e questo:

(define (double x) (+ x x)); definisce una funzione

(doppio 123); calcola il doppio di 123 => 246

allora hai imparato abbastanza per iniziare a programmare in newLISP. Ci sono alcuni altri concetti come le funzioni anonime, l'applicazione di funzioni, spazi dei nomi (contesti) e l'indicizzazione implicita. Imparerai queste tecniche mentre usi newLISP.
I libri su LISP o Scheme, che sono due standard di LISP diversi e più vecchi, insegnano concetti che non hai la necessità di imparare per programmare in newLISP. Molte volte newLISP esprime le cose in modo diverso dai LISP tradizionali e in modi più applicabili ai compiti di programmazione odierni e ad un livello superiore più vicino al problema in questione.
Impara a risolvere i problemi con il modo newLISP! Per una comprensione più approfondita di newLISP, leggi la sezione del "manuale utente" di newLISP, con meno teoria e più esempi. Dai uno sguardo al "manuale di riferimento" per avere un'idea della profondità e dell'ampiezza delle funzioni API integrate.
Per lavorare seriamente con newLISP occorre leggere il manuale "Code Patterns" con altri suggerimenti e pezzi di codice. Una buona introduzione per principianto è il libro "Introduction to newLISP" oppure i video tutorial che sono disponibili nella pagina ufficiale della documentazione.
Molte funzioni in newLISP hanno una funzionalità facile da capire, ma sono molto più potenti quando si conoscono e si usano le opzioni speciali di quella funzione. La profondità della API di newLISP non è basata sulla quantità delle funzioni, ma piuttosto sulle opzioni e sulle sintassi multipla di ogni specifica funzione
Inizia a scrivere il tuo primo programma ora. Guarda le porzioni di codice (snippet) riportate in tutto il manuale e su questo sito web. Se hai domande, iscriviti al forum di discussione di newLISP e chiedi.

4. Quanto è veloce newLISP?
---------------------------
La velocità di calcolo di newLISP è confrontabile con quella dei popolari strumenti di scripting come Perl o Python, ma si comporta meglio quando si tratta di tempi di avvio e di memoria / spazio su disco.
Dai un'occhiata ad alcuni benchmark: http://www.newLISP.org/benchmarks/
Molte funzioni per cui altri linguaggi richiedono l'utilizzo di moduli esterni sono già incorporate in newLISP. Funzioni di networking e metodi matematici come FFT (Fast Fourier Analysis) o funzioni di apprendimento automatico bayesiano sono rapidissime in newLISP. Sono funzioni integrate e non richiedono alcun modulo esterno. Nonostante ciò, newLISP è più piccolo di altri linguaggi di scripting.

5. newLISP ha le matrici?
-------------------------
Sì. Per le applicazioni con accesso random a liste di grandi dimensioni, l'accesso può essere effettuato più velocemente utilizzando gli array di newLISP.

6. newLISP ha le tabelle hash?
------------------------------
newLISP utilizza alberi binari red-black per l'accesso alla memoria associativa quando si gestiscono spazi dei nomi (namespace), dizionari e per l'accesso ai valori-chiave simili alla tencica hash.

7. newLISP ha una gestione automatica della memoria?
----------------------------------------------------
Sì. Ma non è il tipico processo di garbage collection che trovi in altri linguaggi interattivi. Proprio come la garbage collection dei tradizionali linguaggi, newLISP ricicla la memoria inutilizzata. Tuttavia, newLISP lo fa in un modo nuovo, molto più efficiente. La gestione della memoria di newLISP è sincrona senza pause improvvise nell'elaborazione che vengono osservate in linguaggi con garbage collection vecchio stile. L'esclusiva gestione automatica della memoria di newLISP è una delle ragioni della sua velocità, delle sue dimensioni ridotte e dell'uso efficiente della memoria.
Vedi anche: "Automatic Memory Management in newLISP" di Lutz Mueller

http://www.newLISP.org/MemoryManagement.html

8. newLISP può passare i dati per riferimento?
----------------------------------------------
Tutte le funzioni integrate passano liste e stringhe per riferimento sia in ingresso che in uscita. Per passare per riferimento a funzioni definite dall'utente, liste e stringhe possono essere raggruppati in spazi dei nomi particolari (context). Maggiori informazioni su questo argomento sul manuale utente. Dalla versione 10.2, FOOP passa per riferimento anche l'oggetto.

9. Come funziona il variable scoping in newLISP?
------------------------------------------------
newLISP ha uno scope dinamico applicato all'interno di contesti o spazi dei nomi separati lessicalmente. I namespace hanno un overhead molto piccolo e possono esisterne a milioni. I contesti in newLISP consentono la chiusura lessicale di più di una funzione lambda e di un oggetto. I contesti possono essere utilizzati per scrivere funzioni con scope lessicale con memoria, moduli software e oggetti. Ciò evita le insidie dello scope dinamico e aiuta a strutturare programmi più grandi.

10. newLISP gestisce il multiprocessing?
----------------------------------------
Le versioni Linux / UNIX di newLISP possono eseguire il fork e lo spawn dei processi. Le versioni di Windows possono avviare processi figlio indipendenti. I semafori vengono utilizzati per sincronizzare i processi e la memoria condivisa può essere utilizzata per le comunicazioni tra i processi.
Su macOS, Linux e altri Unix, l'API Cilk è integrata per facilitare il lancio e la sincronizzazione di più processi, in modo trasparente senza preoccuparsi di semafori, blocchi, ecc. È disponibile un'API di messaggistica asincrona per comunicare tra processi.

11. Posso usare newLISP per compiti di calcolo distribuiti?
-----------------------------------------------------------
Alcune delle applicazioni più grandi di oggi vengono distribuite su più computer, dividendo le loro complesse attività tra più nodi su una rete. newLISP può essere eseguito come server per valutare i comandi inviati da altri client newLISP ad esso connessi. La funzione "net-eval" incapsula tutta la gestione della rete necessaria per comunicare con altri computer sulla rete, distribuire il codice e le attività di calcolo e raccogliere i risultati in un modo bloccante o basato sugli eventi. newLISP può anche fungere da server Web che gestisce le richieste HTTP incluso CGI.

12. Possiamo utilizzare la metodologia di programmazione orientata agli oggetti?
--------------------------------------------------------------------------------
newLISP offre un nuovo modo di programmazione orientata agli oggetti funzionale chiamata FOOP. Usa gli spazi dei nomi per raccogliere tutti i metodi per una classe di oggetti e usa le normali espressioni S per rappresentare gli oggetti. Per ulteriori dettagli su questo nuovo modo di programmazione orientata agli oggetti in newLISP consultare la serie di video di addestramento "Towards FOOP" nella sezione documentazione e il capitolo "Functional object-oriented programming" nel manuale utente. Dalla versione 10.2 gli oggetti FOOP sono mutabili.

13. Cosa sono  pacchetti e moduli?
----------------------------------
newLISP utilizza gli spazi dei nomi per la creazione di pacchetti e moduli. Esistono moduli per l'accesso ai database come MySQL, PostgreSQL e SQLite, nonché ODBC. I moduli aggiuntivi supportano i protocolli Internet FTP, POP3, SMTP e REST. Poiché i nuovi spazi dei nomi di LISP vengono chiusi lessicamente, newLISP consente ai programmatori di trattare i moduli come black box. Questo metodologia è adatta per gruppi di programmatori che lavorano su applicazioni di grandi dimensioni.
newLISP può anche chiamare funzioni di librerie C condivise su Linux / UNIX e sistemi operativi Windows per espandere le sue funzionalità.
I moduli possono essere documentati utilizzando il sistema di documentazione automatica  newLISPdoc.

14. Quali sono alcune differenze tra newLISP e altri LISP?
----------------------------------------------------------
Le nuove differenze di LISP dagli altri LISP includono: il funzionamento delle espressioni lambda, l'esistenza di namespace (o contesti), il passaggio parametri e, naturalmente, la  API di newLISP (repertorio di funzioni). Nel complesso, il nuovo modo di programmazione del LISP di newLISP lo rendono più veloce, più piccolo e più facile da capire e da apprendere. Per una discussione più dettagliata, vedere "Comparison to Common Lisp and Scheme":

http://www.newLISP.org/index.cgi?page=Differences_to_Other_LISPs

15. newLISP funziona sul sistema operativo XYZ?
-----------------------------------------------
Probabilmente si. newLISP ha un minimo di dipendenze. Utilizza solo librerie C standard per la compilazione. Se il tuo sistema ha strumenti GNU come il compilatore GCC e l'utility make, allora newLISP dovrebbe compilare e linkare immediatamente usando uno dei makefile contenuti nella sua distribuzione sorgente.
newLISP viene creato utilizzando uno dei numerosi makefile, ciascuno scritto per una piattaforma specifica. Non ci sono script di make complessi. I makefile sono brevi e facili da modificare e adattare se  non sono già inclusi nella tua piattaforma o configurazione.

16. newLISP può gestire i caratteri speciali del mio paese e della mia lingua?
------------------------------------------------------------------------------
Nella maggior parte del mondo occidentale, è sufficiente impostare le impostazioni internazionali utilizzando la funzione newLISP "set-locale".
Più della metà dei paesi del mondo usano una virgola decimale invece di un punto decimale. newLISP leggerà e scriverà correttamente le virgole decimali quando passerà alla corretta locale.
La maggior parte degli alfabeti nell'emisfero occidentale si adattano a tabelle di codici carattere a 256 codici e ogni carattere richiede un solo byte di 8 bit da codificare. Se la lingua del tuo paese richiede caratteri multibyte per codificarla, allora hai bisogno della versione di newLISP con supporto UTF-8 abilitato. I Makefile per Windows e Linux sono inclusi per compilare le versioni UTF-8 di newLISP. Nella versione UTF-8, molte funzioni di gestione dei caratteri sono in grado di gestire caratteri multibyte. Vedere il capitolo sulla localizzazione e UTF-8 nel manuale per i dettagli.

17. L'indicizzazione implicita non infrange le regole di sintassi del LISP?
---------------------------------------------------------------------------
Al contrario, l'indicizzazione implicita è un'estensione logica della sintassi LISP. Quando si valutano le espressioni S, il primo elemento viene applicato come una funzione agli elementi restanti nell'espressione che servono come argomenti della funzione. L'indicizzazione implicita consiste semplicemente nel considerare i membri dei tipi di dati numerici, di stringa e di elenco come operatori speciali di indicizzazione quando si trovano nella prima posizione di un'espressione S.

18. newLISP può essere incorporato in altri programmi?
------------------------------------------------------
newLISP può essere compilato come libreria condivisa UNIX o DLL Windows (libreria a collegamento dinamico). Di conseguenza, le versioni di libreria condivisa di newLISP possono essere utilizzate all'interno di altri programmi che sono in grado di importare funzioni di libreria condivisa. Altri modi per integrare la tua applicazione con newLISP includono i pipe I/O e le porte di rete.
Sui sistemi Win32, newLISP è stato utilizzato all'interno di MS Excel, MS Visual Basic e del generatore di applicazioni GUI NeoBook. Su UNIX, newLISP è stato utilizzato all'interno del foglio di calcolo di GNumeric. Su macOS, newLISP è stato utilizzato come linguaggio di estensione per l'editor di BBEdit grazie alla nuova LISP che comunica con BBEdit tramite i pipe di I/O standard. Il Guiserver basato su Java e il vecchio frontend Tcl/Tk per newLISP sono esempi di integrazione di newLISP tramite porte di rete.

19. Copyright sui miei script anche se newLISP è concesso in licenza GPL?
-------------------------------------------------------------------------
Si, puoi. Le FAQ di gnu.org per la GPL lo spiegano. Finché i tuoi script non usano altro software GPL di terze parti sotto forma di librerie importate o moduli caricati, i tuoi script in newLISP non devono necessariamente avere una licenza GPL. La maggior parte dei moduli sul sito Web di newLISP non ha licenza e non importa altre librerie. Se lo fanno, consultare le licenze di quelle librerie di terze parti.
newLISP ti permette di distribuire un binario dell'interprete insieme al closed source. Quando si utilizza newLISP nel software, menzionare sempre il sito Web www.newLISP.org nella documentazione come luogo in cui è disponibile il codice sorgente per newLISP.

20. Dove posso segnalare eventuali bug?
---------------------------------------
La maggior parte delle segnalazioni di bug risulta dalla mancata lettura della documentazione o dal ritenere che newLISP funzioni come Common Lisp o Scheme. Le domande, i commenti e le segnalazioni di bug sono pubblicati sul forum ufficiale, dove vengono letti da molti altri, dando loro l'opportunità di commentare o dare consigli. Il forum consente anche di inviare messaggi privati.

21. Posso compilare i miei script in programmi eseguibili?
----------------------------------------------------------
Si. Il comando: newLISP -x "myscript.lsp" "myscript.exe" genera un file eseguibile sul proprio sistema operativo.


============================================================================
Notepad++ bundle
============================================================================

Download: https://github.com/cameyo42/notepadpp-newlisp

Add newlisp syntax highlighting
-------------------------------
Copy all the text of the file: newlisp-udl.xml
and paste it inside the section:<NotepadPlus> ... </NotepadPlus>
of the file: userDefineLang.xml (located at: c:\Users\<username>\AppData\Roaming\Notepad++\)
CODE: SELECT ALL
Example
<NotepadPlus>
    <UserLang name="newLISP" ext="lsp" udlVersion="2.1">
    ...
    </UserLang>
</NotepadPlus>

The newlisp keywords are from primes.h (newlisp source).
The actual highlight colors are for "obsidiane" theme of notepad++.
You can change (easily) the colors as you like.

Open newlisp help from notepad++
--------------------------------

Add the line:

<Command name="newLISP Help" Ctrl="yes" Alt="yes" Shift="no" Key="112">chrome file:///C:/Program%20Files%20(x86)/newlisp/newlisp_manual.html#$(CURRENT_WORD)</Command>

inside the section: <UserDefinedCommands> ... </UserDefinedCommands>
of the file: shortcut.xml (located at: c:\Users\<username>\AppData\Roaming\Notepad++\)

Example:
<UserDefinedCommands>
    <Command name="newLISP Help" Ctrl="yes" Alt="yes" Shift="no" Key="112">chrome file:///C:/Program%20Files%20(x86)/newlisp/newlisp_manual.html#$(CURRENT_WORD)</Command>

</UserDefinedCommands>

Note: change the path to point to your newlisp help file

Now you can select a word and press Ctrl+Alt+F1 to open newlisp help file.

The shortcut is Ctrl + Alt + F1, but you can change it.

Execute newlisp code from notepad++
-----------------------------------

Download and install autohotkey (http://www.autohotkey.com).

Run the script "npp-newlisp.ahk" (double click it).

Run notepad++

Press Win+F12 to start newlisp REPL (la cartella di default di newLISP è quella dove si trova  lo script "npp-newlisp.ahk")

Now, from notepad++, you can:

1) Execute the expression of current line pressing: Left-Shift + Enter

2) Execute a selected block of expression pressing: Right-Shift + Enter

After the execution of the expressions, notepad++ is the active application.

3) Shortcut (Ctrl + F8) to evaluate expression inside notepad ++ (get the result in notepad++ console)

4) Shortcut (Ctrl + Alt + =) to insert:
[cmd]

[/cmd]

Note:
When selecting a block of expression be sure to begin and end the selection
with a blank line (or use [cmd] [/cmd]).

Note:
The script npp-newlisp.ahk exchange the brackets () and [] in the keyboard.
You can edit the file to disable this (you must comment two lines).
The script also enable other shortcuts... see the source.


============================================================================
Debugger
============================================================================

Il debugger in newLISP è molto spartano, ma è comunque un aiuto indispensabile nello sviluppo dei programmi.

La funzione principale è "trace".
Per fa partire o terminare  il debugger, usare il paraemtro true o nil:

Per iniziare la sessione di debugging: (trace true)

Per terminare la sessione di debugging: (trace nil)

Per verificare lo stato del debugger (nessun argomento):
(trace) ; Senza argomento, ritorna true se la sessione è attiva.
;-> true

Il comando trace-highlight permette di controllare alcune modalità di visualizzazione dell'espressione che è attualmente in fase di valutazione. Se utilizziamo un terminale che supporta i codici ANSI possiamo modificare anche il colore e altri parametri (grassetto, sottolineato, ecc.)
Questo rende l'espressione da valutare di colore rosso:

(trace-highlight "\027[0;31m" "\027[0;0m") ;red text color

Questo rende l'espressione di colore negativo:

(trace-highlight "\027[0;7m" "\027[0;0m")  ;negative

Nota: \027 = ESC

Nota: per attivare i codici ANSI in windows 10 occorre creare nella chiave di registro [HKEY_CURRENT_USER\Console] la variabile "VirtualTerminalLevel" di tipo DWORD e porre il suo valore a 1 (uno).
Dal prompt della console (cmd.exe):
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1
Per disattivare i codici ANSI impostare il valore della variabile "VirtualTerminalLevel" a 0 (zero).

Se il terminale non supporta i codici ANSI, allora potete modificare solo il prompt con dei caratteri:

(trace-highlight ">>>" "<<<")

Potete inserire questo comando nel file init.lsp che viene eseguito quando eseguiamo newLISP.

Per fare un esempio definiamo una funzione ricorsiva che calcola la potenza di un numero x^n:

(define (expn x n)
  (if (= n 0) 1 (mul x (expn x (- n 1))))
)

(expn 3 3)
;-> 27

Per fare il debug di una funzione attiviamo la funzione "trace":

(trace true)

(trace (expn 2 3))

(define (expn x n)
  #(if (= n 0) 1 (mul x (expn x (- n 1))))#
)

[-> 2 ] s|tep n|ext c|ont q|uit >

Vediamo come interpretare l'output:

L'espressione attualmente tracciata (cioè quella in attesa di valutazione) e' quella compresa tra i caratteri "#" e "#":

 #(if (= n 0) 1 (mul x (expn x (- n 1))))#

[-> 2]: indica la direzione (avanti o indietro) e il numero della chiamata

s|tep: valuta ogni subespressione dell'espressione e si ferma

n|ext: valuta tutta l'espressione e si ferma

c|ont: valuta tutte le espressioni della funzione fino al termine

q|uit: esce dal comando "trace"

Nota: Durante il tracciamento, l'espressione tracciata cambia a seconda delle scelte dell'utente.

Per disabilitare la funzione "trace" occorre chiamarla con un valore nil:

(trace nil)

La funzione "debug" è una semplificazione dell'uso di "trace". Passiamo la funzione da tracciare a "debug" che si occupa di attivare e terminare la sessione di debug:

(debug (expn 2 3))

-----

(define (expn x n)
  #(if (= n 0)
   1
   (mul x (expn x (- n 1))))#)


[-> 3 ] s|tep n|ext c|ont q|uit >

Vediamo una sessione completa di debug con delle funzioni annidate. Definiamo le funzioni "pari" e "dispari" (in stile LISP):

(define (pari n)
  (if (= n 0) true (dispari (- n 1)))
)

(define (dispari n)
  (if (= n 0) nil (pari (- n 1)))
)

(pari 8)
;-> true

(dispari 11)
;-> true

(pari 11)
;-> nil

(dispari 8)
;-> nil

Per fare il debug (tracciamento) della funzione pari dobbiamo attivare la funzione "trace" e poi chiamare la funzione da tracciare (oppure (debug (pari 3))):

(trace true)
;-> true

(pari 3)

-----

(define (pari n)
  #(if (= n 0)
   true
   (dispari (- n 1)))#)

[-> 2 ] s|tep n|ext c|ont q|uit >

s

(define (pari n)
  (if #(= n 0)#
   true
   (dispari (- n 1))))

[-> 3 ] s|tep n|ext c|ont q|uit >

s

(define (pari n)
  (if #(= n 0)#
   true
   (dispari (- n 1))))

RESULT: nil ; risultato dell'espressione: (= n 0)

[<- 3 ] s|tep n|ext c|ont q|uit >

s

(define (pari n)
  (if (= n 0)
   true
   #(dispari (- n 1))#))

[-> 3 ] s|tep n|ext c|ont q|uit >

n

(define (pari n)
  (if (= n 0)
   true
   #(dispari (- n 1))#))

RESULT: nil ; risultato dell'espressione: (dispari (- n 1))

[<- 3 ] s|tep n|ext c|ont q|uit >

s

(define (pari n)
  #(if (= n 0)
   true
   (dispari (- n 1)))#)

RESULT: nil

[<- 2 ] s|tep n|ext c|ont q|uit >

c

;-> nil

Questo è il risultato finale della funzione (il numero 3 non è pari) e la sessione di debug è terminata.

Durante il debug possiamo usare la REPL per verificare il valore delle variabili, scrivere funzioni o altro codice necessario (si consiglia di non ridefinire la funzione attualmente in fase di debug).

Vediamo un altro esempio:

(define (conta n)
  (dotimes (i n)
    (setq somma (+ somma i))
    (println n))
)

(debug (conta 5))

-----

(define (conta n)
  #(dotimes (i n)
   (setq somma (+ somma i))
   (println n))#)

[-> 3 ] s|tep n|ext c|ont q|uit >

s ; valuta (dotimes (i n) --> dotimes (0 5)) e avanza alla prossima subespressione

(define (conta n)
  (dotimes (i n)
   #(setq somma (+ somma i))#
   (println n)))

[-> 4 ] s|tep n|ext c|ont q|uit >

s; valuta (somma) e avanza alla prossima subespressione

(define (conta n)
  (dotimes (i n)
   (setq somma #(+ somma i)#)
   (println n)))

[-> 5 ] s|tep n|ext c|ont q|uit >

s ; valuta il risultato della subespressione

(define (conta n)
  (dotimes (i n)
   (setq somma #(+ somma i)#)
   (println n)))

RESULT: 0 ; risultato di (+ somma i)

[<- 5 ] s|tep n|ext c|ont q|uit >

i ; vediamo il valore di i
;-> 0

[<- 5 ] s|tep n|ext c|ont q|uit >

s ; la subespressione è stata valutata quindi valuta l'intera espressione

(define (conta n)
  (dotimes (i n)
   #(setq somma (+ somma i))#
   (println n)))

RESULT: 0 ; risultato di (setq somma (+ somma i))

[<- 4 ] s|tep n|ext c|ont q|uit >

s ;

(define (conta n)
  (dotimes (i n)
   (setq somma (+ somma i))
   #(println n)#))

RESULT: 0

[<- 4 ] s|tep n|ext c|ont q|uit >

s ; avanza alla prossima espressione da tracciare

(define (conta n)
  (dotimes (i n)
   #(setq somma (+ somma i))#
   (println n)))

[-> 4 ] s|tep n|ext c|ont q|uit >

n ; valuta tutta l'espressione attiva (valutando tutte le subespressioni)

(define (conta n)
  (dotimes (i n)
   #(setq somma (+ somma i))#
   (println n)))

RESULT: 1 ; risultato di (setq somma (+ somma i))

[<- 4 ] s|tep n|ext c|ont q|uit >

i ; vediamo il valore di i
;-> 1

[<- 4 ] s|tep n|ext c|ont q|uit >

n ; valuta tutta l'espressione che segue
;-> 5

(define (conta n)
  (dotimes (i n)
   (setq somma (+ somma i))
   #(println n)#))

RESULT: 5 ; risultato di (println n)

[<- 4 ] s|tep n|ext c|ont q|uit >

c ; valuta tutta la funzione fino al termine
;-> 5
;-> 5
;-> 5
;-> 5
;-> 5

Occorre fare molta pratica per utilizzare proficuamente il debugger.

Per fare il debug di un file (es. test.lsp) possiamo scrivere:

(debug (load "test.lsp"))

In questo caso il file deve terminare con delle espressioni che devono essere valutate immediatamente appena il file viene caricato. In altre parole, il file deve terminare con una chiamata di funzione.

Al fine di evitare la valutazione completa di una funzione, possiamo inserire il comando trace all'interno della funzione stessa. In questo modo il debug può essere attivato nel punto desiderato.
Vediamo un modo per far partire il debug a metà di un ciclo. Prima salvate le seguenti linee di codice in un file (es. test-debug.lsp)

(setq i 0)

(define (f1) (inc i))

(define (f2)
  (dotimes (x 100)
    (f1)
    (if (= i 50) (trace true))))

(f2)

Poi eseguite dalla console:

(load "test-debug.lsp")

-----

(define (f1)
  (inc i))

[-> 5 ] s|tep n|ext c|ont q|uit >

i
;-> 50

[-> 5 ] s|tep n|ext c|ont q|uit >

(setq i 60) ; possiamo anche modificare il valore di i
;-> 60

[-> 5 ] s|tep n|ext c|ont q|uit > n

(define (f1 ) (inc i))

RESULT: 61

[<- 5 ] s|tep n|ext c|ont q|uit >

Come potete notare il tracciamento appare quando i vale 50 (che abbiamo verificato visualizzando il valore di i).

Il debugger non visualizza i commenti che si trovano nelle funzioni. Per fare apparire un testo durante la sessione di debug possiamo utilizzare il marcatore [text] [/text]:

(define (f1)
  [text]Questo testo appare nel debugger.[/text]
  ; Questo testo no appare nel debugger.
  (inc i))

Per finire riportiamo la traduzione del manuale di riferimento delle funzioni "trace", "trace-highlight" e "debug".

Funzione DEBUG
--------------
sintassi: (debug func)

Chiama la funzione "trace" e inizia la valutazione della funzione definita dall'utente "func".
"debug" è una scorciatoia per eseguire (trace true) ed entrare nella funzione da tracciare ("func").

; Invece di digitare...
(trace true)
(my-func a b c)
(trace nil)

; Possiamo utilizzare "debug"...
(debug (my-func a b c))

Durante il tracciamento con "trace" o "debug" i messaggi di errore vengono stampati. La funzione che ha causato l'eccezione ritorna zero o nil e l'esecuzione continua. In questo modo le variabili e lo stato del programma può essere ispezionato durante il debugging.

Funzione TRACE
--------------
sintassi: (trace int-device)
sintassi: (trace true)
sintassi: (trace nil)
sintassi: (trace)

Nella prima sintassi il parametro è un intero associato ad un dispositivo (es. un file aperto). L'output viene scritto continuamente su quel dispositivo. Se "int-device" vale 1, allora l'output è scritto su stdout.

; write all entries and exits from expressions to trace.txt
(trace (open "trace.txt"))

; write all entries and exits from expressions to trace.txt
(foo x y)
(bar x)

; close the trace.txt file
(trace nil)

Nella seconda sintassi il debugger diviene attivo quando il parametro vale true.
In the second syntax debugger mode is switched on when the parameter evaluates true. In modalità di debug newLISP si arresta all'ingresso e all'uscita di ogni espressione e attende eventuali input dell'utente.
L'espressione attiva viene visualizzata tra due caratteri "#" (number sign). I caratteri possono essere modificati con la funzione "trace-highlight".
Ad ogni prompt del debugger:

[-> 2] s|tep n|ext c|ont q|uit >

possiamo inserire "s", "n", "c" o "q" per proseguire la valutazione in modi diversi (es. valutare ogni subespressione o valutare tutta l'espressione). Al prompt possiamo anche inserire una espressione qualsiasi da valutare. Ad esempio se inseriamo il nome di una variabile, allora verrà restituito il suo valore. In questo modo possiamo verificare il contenuto delle variabili e possiamo anche modificarlo.

; Imposta newLISP in modalità di debug
(trace true) 
;-> true

; il debugger mostra ogni passo
(my-func a b c)

; Imposta newLISP in modalità normale (esce dalla modalità di debug)
(trace nil) 
;-> nil

Per inserire dei break point dove newLISP dovrebbe interrompere l'esecuzione normale del programma ed entrare in modalità di debug, possiamo inserire l'espression (trace true) prima delle espressioni che devono essere tracciate.
To set break points where newLISP should interrupt normal execution and go into debugging mode, put
(trace true) statements into the newLISP code where execution should switch on the debugger.
Puoi usare la funzione "debug" come scorciatoia per l'esempio sopra:

(debug (my-func a b c))

La terza sintassi chiude la modalità di debug o il file usato per il tracciamento.

La quarta e ultima sintassi riporta il valore corrente della modalità di debug (true o nil).

Funzione TRACE-HIGHLIGHT
------------------------
sintassi: (trace-highlight str-pre str-post [str-header str-footer])

Imposta i caratteri o la stringa di caratteri che racchiude l'espressione attiva durante il tracciamento. Il valore di default che racchide l'espressione è "#" (number sign). Questo può essere cambiato con una stringa lunga fino a sette caratteri. Se il tterminale accetta caratteri di controllo (ANSI sequenze di Esc), possiamo utilizzarli per cambiare il colore dell'espressione, visualizzarla in grassetto o reverse, ecc.
Due ulteriori stringhe opzionali "str-header" e "str-footer" che controllano il separatore e il prompt del debugger. Un massimo di 15 caratteri è consentito per "str-header" e 31 caratteri per "str-footer".

;; l'espressione attiva è racchiusa con ">>" e "<<"
(trace-highlight ">>" "<<")

;; colore brillante ('bright') su terminali VT-100 o compatibili
(trace-highlight ">>\027[1m" "\027[0m")


================================
Compilare i sorgenti di newLISP
================================

In questa appendice vediamo i passi necessari per compilare newLISP con windows 10 partendo dai sorgenti. In particolare compileremo la versione di newLISP a 64 bit con estensioni UTF8 e FFI.

Scaricare i sorgenti di newLISP (newlisp-10.7.5.tgz) da:

http://www.newlisp.org/downloads/development/inprogress/

Attualmente la versione è la 10.7.5

Scompattare il file nella cartella: c:\newLISP-10.7.5

Scaricare il compilatore gcc 5.1 "TDM64 Bundle" da: http://tdm-gcc.tdragon.net/

Installare il programma nella cartella: c:\TDM-GCC-64

Scaricare la libreria "libffi" versione 3.2.1 (precompilata per windows) da:

https://proj.goldencode.com/downloads/libffi/libffi_3.2.1_prebuilt_mingw_4.9.0_64bit.zip

Scompattare il file nella cartella: c:\newLISP-10.7.5\libffi-3.2.1-prebuilt_mingw490_64bit

Copiare i file "libffi.a" e "libffi.dll.a" nella cartella:

c:\TDM-GCC-64\lib\gcc\x86_64-w64-mingw32\5.1.0\

(c:\TDM-GCC-64\lib\gcc\x86_64-w64-mingw32\5.1.0\libffi.a)
(c:\TDM-GCC-64\lib\gcc\x86_64-w64-mingw32\5.1.0\libffi.dll.a)

Adesso dobbiamo modificare un makefile che si trova nella cartella dei sorgenti.

Spostarsi nella cartella c:\newLISP-10.7.5 e aprire il file "makefile_mingw64dll_utf8_ffi" con un editor di testo.

Sostituire la riga: 	$(CC) -m64 -shared *.o -Wl,--kill-at -lffi -lws2_32 -o newlisp.dll
Con la riga:          $(CC) -m64 -shared $(OBJS) -Wl,--kill-at -lffi -lws2_32 -o newlisp.dll

Salvare e chiudere il makefile.

Aprire una finestra DOS (command prompt - cmd.exe) e dalla cartella dei sorgenti digitare:

make -f makefile_mingw64_utf8_ffi

Se tutto va bene, dopo alcuni secondi avrete il vostro file "newlisp.exe" insieme a diversi altri file che  hanno estensione ".o".

Prima di creare la dll di newLISP dobbiamo eliminare tutti i file ".o" che sono stati creati.

Una volta eliminati i file ".o" digitare:

make -f "makefile_mingw64dll_utf8_ffi"

Questa volta avrete il vostro file "newlisp.dll" insieme a diversi altri file che  hanno estensione ".o".

Cancellate i file ".o" e copiate "newlisp.exe" e "newlisp.dll" nella cartella che preferite (la cartella deve trovarsi nella variabile di ambiente PATH).

Complimenti, avete creato la vostra versione di newLISP !!!

Nota: nelle versioni ffi di newLISP occorre copiare la libreria "libffi-6.dll" nella cartella dove si trova newlisp.exe e newlisp.dll

Nota: l'installazione completa di newLISP comprende anche altri file. Comunque questi file devono semplicemente essere copiati dalla cartella dei sorgenti (moduli, manuali, util, ecc.).
Puoi vedere la cartella dove è installato newLISP per capire quali file sono necessari.

Nota: In questo modo abbiamo solamente installato la REPL di newLISP, tralasciando la versione GUI.


============================================================================
Ricorsione e ottimizzazione della chiamata di coda (Tail Call Optimization)
============================================================================

Questo è un concetto molto importante quando utilizziamo funzioni ricorsive.
Parliamo di "ottimizzazione della chiamata di coda" (TCO - Tail Call Optimization) quando è possibile evitare di allocare un nuovo stack frame per una funzione poichè la funzione chiamante restituirà semplicemente il valore che ottiene dalla funzione chiamata.
L'uso più comune è la "ricorsione in coda" (tail recursion), quando una funzione ricorsiva è in grado di utilizzare una dimensione costante dello stack.

Scheme (o Javascript ES6) è uno dei pochi linguaggi che garantisce nelle specifiche di essere in grado di effettuare questa ottimizzazione.
Vediamo due esempi in Scheme (con sintassi newLISP)

(define (fact x)
  (if (= x 0) 1
      (mul x (fact (- x 1)))))

(fact 10)
;-> 3628800

(fact 2500)
;-> ERR: call or result stack overflow

(define (fact x)
  (define (fact-tail x accum)
    (if (= x 0) accum
      (fact-tail (- x 1) (mul x accum))))
  (fact-tail x 1))

La prima funzione non ha la ricorsione di coda perchè quando viene effettuata la chiamata ricorsiva la funzione deve tenere traccia della moltiplicazione necessaria per ottenere il risultato dopo che è ritornata la chiamata.
Quindi lo stack è simile al seguente:

(fact 3)
(* 3 (fact 2))
(* 3 (* 2 (fact 1)))
(* 3 (* 2 (* 1 (fact 0))))
(* 3 (* 2 (* 1 1)))
(* 3 (* 2 1))
(* 3 2)
6

In contrasto lo stack per la seconda funzione si comporta nel modo seguente:

(fact 3)
(fact-tail 3 1)
(fact-tail 2 3)
(fact-tail 1 6)
(fact-tail 0 6)
6

Come puoi vedere, abbiamo soltanto bisogno di memorizzare la stessa quantità di dati per ogni chiamata perchè dobbiamo semplicemente restituire il valore che otteniamo dalla chiamata superiore. Questo significa che anche la chiamata (fact 1000000) ha bisogno della stessa quantità di spazio della chiamata (fact 3).
Questo non accade nelle funzioni senza ottimizzazione della chiamata di coda (non-tail recursive), infatti valori elevati dell'argomento possono causare l'errore di esaurimento dello stack (stack overflow).

A rigor di termini, l'ottimizzazione della chiamata di coda non sostituisce necessariamente lo stack frame del chiamante con i chimati, ma, piuttosto, garantisce che un numero illimitato di chiamate nella posizione di coda richieda solo una quantità limitata di spazio.

In altre parole la TCO (Tail Call Optimization) è il processo mediante il quale un compilatore intelligente può effettuare una chiamata a una funzione e non occupare ulteriore spazio di stack. L'unica situazione in cui ciò accade è se l'ultima istruzione eseguita in una funzione f è una chiamata a una funzione g (Nota: g può essere f). Il punto è che f non ha più bisogno di spazio nello stack - semplicemente chiama g e restituisce qualsiasi cosa restituisca g. In questo caso si può fare l'ottimizzazione: la funzione g viene eseguita e ritorna il suo valore a quello che ha chiamato f.

Questa ottimizzazione può far sì che le chiamate ricorsive occupino uno spazio di stack costante, anziché facciano esplodere lo stack.

Esempio: questa funzione fattoriale non è TCOttimizzabile:

def fact(n):
    if n == 0:
        return 1
    return n * fact(n-1)

Questa funzione fa anche altre cose oltre a chiamare un'altra funzione nella sua ultima istruzione (dichiarazione di ritorno).

Esempio: questa funzione fattoriale non è TCOttimizzabile:

def fact_h(n, acc):
    if n == 0:
        return acc
    return fact_h(n-1, acc*n)

def fact(n):
    return fact_h(n, 1)

Questo perché l'ultima istruzione in una di queste funzioni è la chiamata un'altra funzione.
Il TCO riguarda l'ottimizzazione dello spazio utilizzato nello stack di chiamate (da O(n) a costante).

Purtroppo newLISP non supporta Tail Call Optimization (TCO), ma è possibile superare il problema dell'esplosione dello stack delle funzioni ricorsive tramite la tecnica di "memoization".
Questa tecnica viene spiegata nell'articolo "Advanced Recursion in newLISP":
https://weblambdazero.blogspot.com/2010/07/advanced-recursion-in-newLISP.html di Krzysztof Kliś che trovate tradotto più avanti.


============================================================================
newLISP - Lisp per tutti
============================================================================

Traduzione dell'articolo "newLISP - Lisp for the masses" di Krzysztof Kliś

https://weblambdazero.blogspot.com/2010/06/newlisp-lisp-for-masses.html

Esiste un detto popolare tra gli hacker Lisp: pianta un albero, scrivi un libro e crea un dialetto personale del Lisp. Sebbene non ci siano in giro molti Lisp popolari (persino il Common Lisp non è mai stato usato in maniera massiccia) sembra proprio che nel caso di varie distribuzioni Linux, spesso "di più" significa semplicemente "migliore". Un buon esempio di questa storia di successo è Clojure, e adesso arriva un altro candidato a prendere il comando.
newLISP è un dialetto moderno del Lisp, progettato da Lutz Mueller per essere (come dice lui stesso) "veloce da imparare e per finire il lavoro". Devo dire che questa frase non potrebbe essere più vera - risolvere il problema 10 di ProjectEuler (trovare la somma di tutti i numeri primi sotto 2 milioni) dopo soli due giorni di manipolazione con newLISP mi ci sono voluti meno di 3 minuti, tra cui progettazione, scrittura, test per eseguire il seguente codice:

(println (apply + (filter (fn (n) (= 1 (length (factor n)))) (sequence 2 2000000))))

Nonostante sia un linguaggio interpretato, i programmi creati con newLISP girano in modo incredibilmente veloce. Il codice sopra è una soluzione che utilizza la forza bruta, ma viene eseguito in meno di 10 secondi su Core 2 Duo a 1,66 GHz (2931 ms su Core i5 3.4 GHz).
Tuttavia, la semplicità ha un prezzo. Se cerchi di utilizzare un approccio più sofisticato, come il classico setaccio di Eratostene, potresti rimanere un pò sorpreso:

(define (sieve seq out)
  (let ((n (first seq)))
    (setf seq (filter (fn (x) (!= 0 (mod x n))) seq))
    (push n out)
    (if (not seq) out (sieve seq out))))

(print (apply + (sieve (sequence 2 2000000))))

Con questa funzione, sebbene sia correttamente ricorsiva in coda, newLISP consuma rapidamente tutto lo stack oppure, se si fornisce abbastanza spazio per lo stack, consuma tutta la memoria disponibile. Questo avviene perché newLISP non ottimizza la ricorsione in coda. Se per qualche motivo non puoi convivere con questa limitazione, puoi comunque utilizzare il Common Lisp per implementare tali ricorsioni:

(defun range (min max) (loop for i from min to max collect i))

(defun sieve (seq &optional out)
  (let ((n (car seq)))
    (setf seq (delete-if #'(lambda (x) (= 0 (mod x n))) seq))
    (push n out)
    (if (not seq) out (sieve seq out))))

(print (apply #'+ (sieve (range 2 2000000))))

Come puoi vedere, il codice delle due funzioni 'sieve' è molto simile, quindi è abbastanza facile passare a newLISP se conosci il Common Lisp. Le differenze con altri dialetti Lisp sono ben documentate, così come il linguaggio stesso. La documentazione è un altro punto di forza di newLISP: puoi imparare come risolvere diversi problemi reali usando i "code patterns" di newLISP oppure curiosare tra i molti frammenti di codice interessanti.
Quello che personalmente apprezzo di newLISP rispetto ad altri Lisp è il suo piccolo ingombro (davvero minuscolo). È possibile creare un eseguibile standalone contenente il motore newLISP (circa 300kB) e il vostro programma con un semplice comando dal terminale:

newLISP -x "mycode.lsp" "mycode.exe"

Nonostante sia così piccolo, il nuovo LISP offre una sorprendente quantità di funzionalità "out of the box": espressioni regolari, networking TCP/IP (inclusi i protocolli FTP e HTTP), accesso a database (tramite librerie esterne), OpenGL, XML e gestione XML-RPC, matrici, statistica (comprese formule bayesiane), supporto per Unicode e un insieme di moduli C/C++ che ne estendono ancora di più le capacità.
newLISP supporta anche l'elaborazione parallela tramite le API Cilk-like e l'elaborazione distribuita tramite la funzione integrata "net-eval".
newLISP non è sicuramente un Nuovo Common Lisp, e in alcuni punti (come ad esempio la ricorsione di coda) è ancora inferiore. Ma newLISP è un esempio perfetto che nel settore IT: a volte peggio è meglio  (sometimes worse is better).

Commento di Kazimir Majorinc:
newLISP insiste sull'idea di "codice = dati" di più della maggior parte dei dialetti Lisp non attivamente sperimentati e attivamente mantenuti.

(1) A causa di alcuni motivi, newLISP sfrutta molto di più la funzione "eval" della maggior parte degli altri dialetti Lisp. Una delle ragioni è che "eval" è veloce, solo Eligis OpenLisp e Picolisp hanno delle funzioni "eval" ancora più veloci.

(2) newLISP ha uno ambito (scope) dinamico e non lessicale. L'ambito dinamico funziona meglio con la funzione "eval".
Per esempio,

(let ((x 1)) (eval 'x))

è legale nell'ambito dinamico e restituisce l'errore "x not defined" in ambito lessicale. Emacs Lisp, Picolisp e newLISP supportano l'ambito dinamico, CL supporta entrambi, altri dialetti supportano solo l'ambito lessicale.

(3) Le macro in newLISP sono in realtà di FEXPR: vale a dire qualcosa come macro del primo ordine (first-class) definite a runtime (durante l'esecuzione). A differenza delle macro, è possibile assegnare FEXPR come valori, applicate, mappate e utilizzate come dati durante il runtime. Le FEXPRS esistevano nelle prime implementazioni del Lisp, ma sono state abbandonate perché si supponeva che renderessero impossibili alcune ottimizzazioni del compilatore. Questa affermazione è, a mio avviso, fuorviante, ma è irrilevante per i linguaggi interpretati. Attualmente nessun altro dialetto Lisp supporta le fexprs. (newLISP supporta anche reader-macro e alcune macro tradizionali - ma attraverso librerie.)

(4) A differenza delle macro, FEXPRS collabora bene con "eval", quindi se il programma combina (fexprs o macros) ed "eval", è probabile che sarà molto più veloce in newLISP rispetto ad altri dialoghi Lisp.

(5) Funzioni e macro (es. FEXPRS) in newLISP sono *espressioni*, non i risultati della valutazione delle espressioni. Quindi, queste possono essere (comprese quelle anonime) analizzate e modificate durante il runtime.


============================================================================
Ricorsione avanzata in newLISP
============================================================================

Traduzione dell'articolo "Advanced Recursion in newLISP" di Krzysztof Kliś

https://weblambdazero.blogspot.com/2010/07/advanced-recursion-in-newlisp.html

Nel precedente post su newLISP ho menzionato che non supporta l'ottimizzazione delle chiamate di coda. In realtà, molti Lisp non lo fanno. Come indicato da Bill Six, anche lo standard ANSI del Common Lisp non impone (a differenza dello Scheme) un'eliminazione delle chiamate di coda fornita dall'implementazione del linguaggio, anche se sembra che tutti i maggiori compilatori ANSI Common Lisp lo facciano comunque.

Mi chiedevo se esiste un modo per aggirare questo problema e la prima soluzione che ho trovato è stata l'utilizzo della macro "memoize" descritta nell'eccellente documentazione online di newLISP, "Code Pattern in newLISP":

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

È possibile applicare questa macro a qualsiasi funzione con qualsiasi numero di argomenti. Il trucco qui è che ogni volta che viene chiamata una funzione, il suo risultato viene scritto in memoria per un'altra chiamata. Questo può velocizzare enormemente la tua applicazione, e può essere osservato confrontando il tempo di esecuzione di queste funzioni di Fibonacci:

(define (fibo n)
  (if (< n 2) 1
    (+ (fibo (- n 1)) (fibo (- n 2)))))

(memoize fibo-m
  (lambda (n)
    (if (< n 2) 1
      (+ (fibo-m (- n 1)) (fibo-m (- n 2))))))

(time (fibo 35))
;-> 4479 msec
(time (fibo-m 35))
;-> 0.016

Sul mio portatile (fibo 35) impiega 12.98 secondi, mentre (fibo-m 35) viene eseguita in 0.016 millisecondi.

Sfortunatamente la macro memoize non può gestire la ricorsione reciproca. Un classico esempio di tale ricorsione appare come segue:

(define (f1 n)
  (println n)
    (if (= n 0)
      (println "Blastoff!")
      (f2 n)))

(define (f2 n)
  (f1 (- n 1)))

newLISP esaurisce rapidamente lo spazio dello stack se eseguiamo (f1 1000), per non parlare di numeri più grandi. Cosa succede se definiamo una versione "memoized" di f1 e f2 ? Vediamo:

(memoize f1
  (lambda (n)
    (println n)
    (if (= n 0)
      (println "Blastoff!")
      (f2 n))))

(memoize f2
  (lambda (n)
    (f1 (- n 1))))

Ancora una volta, l'esecuzione di (f1 1000) esaurisce immediatamente lo stack di newLISP.

Una soluzione a questo problema si ottiene utilizzando una tecnica chiamata "trampolining" (trampolino). Bill Clementson sul suo blog non solo ha spiegato in modo eccellente il concetto di usare i trampolini, ma ha anche fornito un'implementazione in Common Lisp, che è diventata la mia ispirazione per scrivere una versione in newLISP:

(define (trampoline fun arg)
  (catch
    (while true
      (let ((run (apply fun arg)))
        (setf fun (first run) arg (rest run)))) 'result)
  result)

Un trampolino esegue iterativamente i "thunk" [1] di codice restituiti da una funzione e in questo modo evita di far esplodere lo stack di applicazioni. Tuttavia, per utilizzare il trampolino, la funzione deve restituire la continuazione (un puntatore al passaggio successivo) anziché il valore. Di seguito è riportata una versione delle funzioni di cui sopra modificate per utilizzare il trampolino:

(define (f1 n)
  (println n)
  (if (= n 0)
    (throw "Blastoff!")
    (list f2 n)))

(define (f2 n)
  (list f1 (- n 1)))

Ora puoi testarlo con:

(trampoline f1 '(1000))
(trampoline f1 '(10000))
(trampoline f1 '(100000))
...

Buon divertimento!

[1]
Un "thunk" è una subroutine usata per iniettare un calcolo addizionale in un'altra subroutine. I thunk vengono principalmente utilizzati per ritardare un calcolo finché non è necessario il risultato o per inserire operazioni all'inizio o alla fine di un'altra subroutine. Può semplicemente essere pensato come una funzione che non accetta argomenti, in attesa di essere chiamata a fare il suo lavoro.


============================================================================
Differenze tra newLISP, Scheme e Common LISP di Lutz Mueller
============================================================================

Cerchiamo di capire quali sono le differenze tra newLISP, Scheme e Common LISP.
Lo scopo di questo confronto non è quello di dimostrare che un linguaggio è migliore di un altro.
Diversi stili di programmazione si adattano a personalità diverse. Ogni approccio ha differenti punti di forza e di debolezza. L'idea che si possa progettare un unico linguaggio per tutti gli usi è una illusione. L'autore di newLISP utilizza 'C' e Java contemporaneamente a newLISP. Altri usano un diverso set di strumenti adatto al loro stile di programmazione e ai progetti che devono realizzare.
L'estetica di newLISP, che ha uno stile disinvolto e flessibile, ha attirato non solo il tradizionale programmatore, ma anche molte persone di altre professioni. Molti contributi alla progettazione di newLISP provengono da persone che non sono programmatori di professione. Per molti, newLISP non è solo un linguaggio di programmazione, ma anche uno strumento per modellare e organizzare il pensiero creativo.

Linguaggi di scripting contro linguaggi compilati
-------------------------------------------------
newLISP è un linguaggio di scripting progettato per non essere compilato ma per essere completamente dinamico e introspettivo. Molte delle differenze con altri LISP derivano da questa distinzione.
Entrambi gli approcci hanno il loro posto nell'informatica moderna. Per una discussione su questo argomento vedi:

"In Praise of Scripting: Real Programming Pragmatics" di Ronald P. Loui

http://web.cs.mun.ca/~harold/Courses/Old/CS2500.F09/Diary/04563874.pdf

Per ulteriori informazioni su storia, critica e altri aspetti del Lisp, consultare la pagina web:

http://www.newlisp.org/index.cgi?page=Links

Apertura e trasparenza
----------------------
newLISP è completamente aperto. Non ci sono stati nascosti. Tutti gli oggetti del linguaggio e i dati sono di primo ordine (classe). Sebbene newLISP inizialmente compili il sorgente del programma in un albero di s-espressioni, ogni oggetto può essere riportato in ogni momento in una forma comprensibile. Questo vale sia per gli spazi dei nomi (namespaces/context) sia per le espressioni lambda. Questa apertura facilita il funzionamento e il debug interattivo e facilita la comprensione del linguaggiolingua. I programmi newLISP sono completamente auto-riflessivi e possono essere ispezionati e modificati in ogni momento (anche a quando sono in esecuzione).
newLISP è in grado di gestire le risorse di rete per quanto riguarda i file in modo trasparente. Nella maggior parte dei casi dove vengono usati dei file, si possono usare anche gli indirizzi URL.
I file possono essere letti, scritti e aggiornati, i programmi possono essere caricati o salvato utilizzando lo stesso codice per sia per l'accesso locale che quello di rete. Questo facilita la scrittura di applicazioni distribuite.

Applicazione delle funzioni come in Scheme
------------------------------------------
A differenza di Common Lisp, newLISP e Scheme valutano prima l'operatore di un'espressione e poi lo applicano ai suoi argomenti.

Espressioni Lambda
------------------
In newLISP, le espressioni lambda sono costanti che valutano su se stesse. Sono un sottotipo del tipo di dati lista, quindi un oggetto dati di primo ordine che può essere manipolato come qualsiasi altra lista. In Common Lisp e Scheme, le espressioni lambda, una volta valutate, restituiscono come tipo di dati, una funzione speciale che formano un chiusura lessicale dopo aver vincolato (associato) le sue variabili libere all'ambiente corrente.
In newLISP, il binding delle variabili libere nelle espressioni lambda avviene durante l'applicazione dell'espressione lambda senza creare una chiusura.
Le espressioni Lambda in newLISP possono essere trattate come dati in ogni momento, anche dopo essere state associate ad una  definizione di funzione:

(define (foo x) (+ x x))
;-> (lambda (x) (+ x x))

(last foo)
;-> (+ x x)

Altri LISP usano le chiusure lambda per creare funzioni con stato (memoria). Mantenere lo stato è una condizione necessaria per un linguaggio di programmazione per permettere la programmazione orientata agli oggetti. In newLISP, i contesti (spazi dei nomi)chiusi lessicalmente possono essere usati per scrivere funzioni con stato. Come le espressioni lambda, i contesti in newLISP sono oggetti di primo ordine. I contesti possono essere creati e distrutti durante il runtime, passati come parametri, e referenziati con dei simboli.
Vedi l'appendice "Chiusure, contesti e funzioni con stato" per un confronto tra le chiusure di Scheme e i contesti di newLISP.
Vedi anche l'appendice "Creazione di funzioni con ambito lessicale in newLISP".

Un solo spazio dei simboli
--------------------------
In newLISP e Scheme, le variabili, le primitive e le funzioni definite dall'utente condividono lo stesso spazio dei simboli. In Common Lisp, i simboli di funzione e i simboli delle variabili utilizzano ciascuno uno spazio di nomi dedicato.
Questo è il motivo per cui a volte i simboli di funzione Common Lisp devono essere preceduti dal carattere #'.
I simboli in newLISP distinguono tra maiuscole e minuscole.

Ambito dinamico all'interno di spazi di nomi isolati
-----------------------------------------------------
newLISP a volte viene criticato per l'utilizzo di ambiti (scope) dinamici e di fexprs. Queste critiche ignorano che
i contesti (namespace) di newLISP proteggono i simboli delle funzioni dagli svantaggi tradizionali dell'ambito dinamico e delle fexprs.
In newLISP, tutte le variabili hanno un ambito dinamico come impostazione predefinita. Tuttavia, definendo una funzione nel proprio contesto, può essere utilizzato l'ambito statico/lessicale. I nomi dei parametri usati nelle fexprs sono inseriti con il loro valore su una pila all'entrata della funzione e vengono ripristinati al ritorno della funzione. In newLISP, diverse funzioni e dati possono condividere uno spazio dei nomi. Includendo le funzioni nel proprio spazio dei nomi, si ottiene un meccanismo di chiusura lessicale. Common Lisp e Scheme hanno un ambito lessicamente predefinito e utilizzano le espressioni lambda come meccanismo di chiusura. Common Lisp offre anche speciali variabili per l'ambito dinamico.
I problemi delle variabili libere in ambito dinamico possono essere evitati. Nei rari casi in cui devono essere utilizzate variabili libere, è possibile suddividere il codice in moduli di spazi di nomi per un controllo più semplice delle variabili libere. È quindi possibile sfruttare i vantaggi dell'ambito dinamico. Con un ambito dinamico all'interno di spazi di nomi chiusi lessicamente, newLISP combina il meglio di entrambi i mondi degli ambiti (scoping).
newLISP non ha problemi di funarg perché segue una semplice regola: le variabili mostrano sempre l'associazione (binding) del loro ambiente attuale. Quando vengono inserite espressioni con variabili locali, newLISP salva lo stato delle variabili in una pila e lo ripristina al termine dell'espressione. In newLISP sono espressioni locali, oltre ai parametri delle funzioni e alle variabili definite con let, anche le variabili di loop di tutti i cicli.

La cella LISP e cons
--------------------
In Common Lisp and Scheme, la parte cdr (rest) della cella Lisp può essere utilizzata per contenere un altro oggetto LISPoggetto, nel qual caso abbiamo una coppia puntata. In newLISP, non ci sono coppie puntate. Invece, ciascuna cella di newLISP contiene un oggetto e un puntatore ad un altro oggetto se la cella fa parte di una lista. Come risultato in newLISP la funzione "cons" si comporta diversamente dagli altri LISP.

Common Lisp e Scheme
(cons 'a' b) => (a. b)  ;una coppia puntata
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

Gli argomenti di una funzione sono opzionali
--------------------------------------------
In newLISP, tutti gli argomenti relativi a una funzione definita dall'utente sono facoltativi. Le variabili degli argomenti non assegnati assumeranno il valore nil all'interno della funzione.

Creazione di simboli impliciti
------------------------------
Logicamente, non ci sono simboli non associati o non esistenti in newLISP. Qualsiasi simbolo non associato o non esistente viene creato ed associato a nil nello spazio di nomi corrente quando viene visualizzato per la prima volta da newLISP.

nil e true sono costanti booleane
---------------------------------
nil e true sono costanti booleane in newLISP.
In Common Lisp, nil ha un ruolo aggiuntivo come terminatore di lista:

newLISP
(cons 'x nil) => (x nil)

Scheme
(cons 'x #f) => (x . #f)

Common Lisp
(cons 'x nil) => (x)

Scheme ha due costanti booleane #t e #f per vero e falso.
In newLISP la funzione first e in Scheme la funzione car generano un errore quando vengono usate su una lista vuota.
Il Common Lisp, la funzione car restituisce nil:

newLISP
(first '()) => error

Scheme
(car '()) => error

Common Lisp
(car '()) => nil

Gestione della memoria con un unico riferimento (ORO)
-----------------------------------------------------
In newLISP, ogni oggetto viene referenziato una sola volta (ORO), ad eccezione dei simboli e dei contesti. La regola ORO di newLISP consente la gestione automatica della memoria, basata su stack, senza i problemi degli algoritmi di garbage collection tradizionali usati in altri linguaggi di scripting.
La gestione della memoria ORO di newLISP è più veloce e utilizza meno risorse.
newLISP passa i parametri per valore-copia (pass by value) e memorizza i risultati intermedi su uno stack di risultati. La memoria creata per i risultati intermedi viene riciclata dopo il ritorno della funzione. Come la tradizionale garbage collection, la gestione della memoria ORO libera il programmatore dal gestire l'allocazione e la riallocazione della memoria.
Per evitare di copiare gli oggetti di dati quando si passa per valore-copia, possiamo passare questi dati per riferimento (by reference) racchiudendoli in contesti (context).
Il seguente frammento di codice mostra il passaggio per riferimento utilizzando il funtore di predefinito di uno spazio di nomi:
(define (modify data value)
  (push value data))

(set 'reflist:reflist '(b c d e f g))

(modify reflist 'a) ; passato per riferimento

reflist:reflist => (a b c d e f g)

La gestione automatica della memoria di newLISP è completamente trasparente per il programmatore, ma più veloce e
è richiede meno risorse rispetto ai classici algoritmi di garbage collection.
Poiché la gestione della memoria ORO è sincrona, il codice newLISP ha un tempo di esecuzione è costante e ripetibile. I linguaggi di programmazione che utilizzano la garbage collection tradizionale mostrano ritardi e pause improvvis.
La combinazione tra il passaggio per valore-copia e la gestione unica della memoria rendono newLISP il linguaggio di scripting interattivo (non compilato) più veloce in generale tra quelli disponibili. Come mostrato sopra, è comunque possibile anche il passaggio per riferimento. Per le funzioni integrate il passaggio per riferimento è quello predefinito.
Come sottoprodotto della gestione della memoria ORO di newLISP, è necessario solo il segno di uguale "=" per verificare l'uguaglianza tra due oggetti. Common Lisp richiede eq, eql, equal, equalp, =, string=, string-equal, char= e char-eq per i test di uguaglianza di espressioni, tipi di dati, oggetti identici e oggetti referenziati.

Macro Fexpr e macro di riscrittura
----------------------------------
In newLISP, le forme speciali (special form) vengono create usando fexprs definite con la funzione define-macro. Il Common Lisp utilizza dei template di espansione e compilazione per creare le forme speciali. Le forme speciali non valutano i loro argomenti o li valutano solo in condizioni speciali. In newLISP, le fexprs sono chiamate macro perché servono allo stesso scopo delle macro utilizzate in altri dialetti LISP: esse consentono la definizione di forme speciali.
Le fexpr create con define-macro controllano completamente quando gli argomenti vengono valutati. Come risultato, le macro di newLISP possono funzionare come forme speciali integrate:

(define-macro (my-setq x y) (set x (eval y)))

; come macro igienica evitando la cattura delle variabili
(define-macro (my-setq) (set (args 0) (eval (args 1)))))

newLISP può avviare l'espansione delle variabili esplicitamente usando le funzioni expand e letex:

(define (raise-to power)

(expand (fn (base) (pow base power)) 'power))

(define square (raise-to 2))

(define cube (raise-to 3))

(quadrato 5) => 25

(cubo 5) => 125

L'espansione delle variabili può essere utilizzata per catturare lo stato di variabili libere. Vedi un'applicazione di questo concetto nell'appendice: "The Y of Why in newLISP". newLISP combina frequentemente define-macro e i template di espansione usando expand o letex.
In newLISP la cattura delle variabili nelle fexpr può essere evitata racchiudendole in uno spazio di nomi, oppure usando la funzione args per recuperare i parametri passati, cioè (args 0) per il primo (args 1) per il secondo e così via. In entrambi i casi, le fexpr risultanti sono completamente igieniche senza pericolo di cattura delle variabili.
Nella versione 10.1.6, newLISP ha introdotto macro di riscrittura-espansione in un modulo caricabile. Dalla versione 10.6.0, la stessa funzionalità è disponibile con una funzione macro nativa integrata che funziona in modo identico:

; registra un template macro
(macro (cubo X) (pow X 3))

; durante il caricamento del codice, le macro vengono espanse.
(cubo 3) => 27

La funzione di espansione delle macro si aggancia tra il processo di lettura/traduzione del sorgente e il processo di valutazione. Nell'esempio, ogni occorrenza di (cubo n) verrebbe tradotta in (pow n 3). In questo modo si evita il sovraccarico di lavoro delle fexpr.

Indicizzazione implicita (Implicit Indexing)
-------------------------------------------
newLISP ha la capacità di indicizzazione implicita. Questa è un'estensione logica delle regole di valutazione LISP che permette di indicizzare implicitamente le liste e le stringhe in aggiunta alle normali funzionalità di indicizzazione integrate disponibili (nth, rest, slice):

(set 'myList '(a b c (d e) f g))

; utilizzando la funzione  nth
(nth 2 myList) => c

; con un vettore di indici
(nth '(3 1) myList) => e
(nth '(3 0) myList) => d

; utilizzando l'indicizzazione implicita
(myList 2) => c
(myList 3 1) => e
(myList -3 0) => d

; con un vettore di indici
(set 'v '(3 1))
(myList v) => e

; rest implicito, slice
(1 myList) => (b c (d e) f g)
(-3 myList) => ((d e) f g)
(1 2 myList) => (b c)

L'utilizzo dell'indicizzazione implicita è opzionale. In parecchi casi permette di aumentare la velocità e la leggibilità dei programmi.


============================================================================
Chiusure, contesti e funzioni con stato di Lutz Mueller
============================================================================

Scheme utilizza le chiusure per scrivere funzioni generatrici, funzioni con stato e oggetti software. newLISP usa l'espansione delle variabili e spazi di nomi chiamati contesti (context) per fare lo stesso.
Gli spazi di nomi di newLISP sono sempre aperti all'ispezione. Sono oggetti di primo ordine che possono essere copiati e passati come parametri alle primitive di newLISP o alle funzioni lambda definite dall'utente.
Un contesto newLISP può contenere più funzioni contemporaneamente. Questo è il metodo usato da newLISP per costruire moduli software.
Come una chiusura Scheme, un contesto newLISP è uno spazio lessicamente chiuso. In newLISP all'interno di tale spazio di nomi l'ambito è dinamico. newLISP consente di combinare l'ambito (scope) lessicale e quello dinamico in modo flessibile.

Funzioni generatrici (Function factories)
-----------------------------------------
Il primo è un semplice esempio di una funzione generatrice. La funzione crea una funzione somma (adder) specifica per ogni numero da aggiungere. Mentre Scheme utilizza una chiusura di funzione per acquisire il numero in una variabile statica, newLISP utilizza la funzione expand per creare una funzione lambda specifica che contiene il numero come costante:

; Chiusura in Scheme

(definire make-adder
    (lambda (n)
        (lambda (x) (+ x n))))

(definire add3 (make-adder 3)) => # <procedure add3>

(add3 10) => 13

newLISP usa exp o letex per rendere il numero n una parte dell'espressione lambda come costante, oppure usa la funzione curry:

; newLISP usando expand

(define (make-adder n)
    (expand (lambda (x) (+ x n)) 'n))

(define add3 (make-adder 3))

(add3 10) => 13

; newLISP usando letex

(define (make-adder n)
    (letex (c n) (lambda (x) (+ x c))))

; oppure letex sullo stesso simbolo

(define (make-adder n)
    (letex (n n) (lambda (x) (+ x n)))))

(define add3 (make-adder 3))

(add3 10) => 13

; newLISP usando curry

(define add3 (curry + 3))

(add3 10) => 13

In entrambi i casi creiamo un'espressione lambda con il numero 3 contenuto come costante.

Funzioni con memoria
--------------------
Il prossimo esempio usa una chiusura per scrivere una funzione generatore. Produce un risultato diverso ogni volta che viene chiamata e ricorda uno stato interno:

; generatore in Scheme

(define gen
    (let ((acc 0))
         (lambda () (set! acc (+ acc 1)))))

(gen) => 1
(gen) => 2

In newLISP creiamo una variabile di stato locale usando un contesto come spazio di nomi:

; generatore newLISP

(define (gen:gen)
   (setq gen:sum
       (if gen:sum (inc gen:sum) 1)))

; Possiamo scriverlo più concisamente perchè "inc" tratta nil come zero

(define (gen:gen)
    (inc gen:sum))

(gen) => 1
(gen) => 2

Quando scriviamo gen:gen, viene creato un contesto chiamato gen. gen è uno psazio di nomi lessicale contenente i propri simboli usati come variabili e funzioni. In questo caso il lo spazio di nomi gen ha le variabili gen e sum.
Il primo simbolo gen ha lo stesso nome del gen del contesto genitore. Questo tipo di simbolo è chiamato un funtore predefinito in newLISP.
Quando si utilizza un nome di contesto al posto di un nome di funzione, newLISP assume il functor predefinito. Possiamo chiamare la nostra funzione generatore usando (gen). Non è necessario chiamare la funzione usando (gen:gen), (gen) viene riferito a (gen:gen) per default.
Vedi anche l'appendice successiva che crea la funzione "def-static" per automatizzare il processo di creazione di funzioni con ambito lessicale.

Introspezione
-------------
In newLISP è sempre possibile interrogare lo stato interno di una funzione. In Scheme lo stato di una chiusura è nascosto e non aperto all'introspezione senza codice aggiuntivo:

; in Scheme gli stati sono nascosti

add3 #<procedure add3>

gen => #<procedure gen>

; in newLISP gli stati sono visibili

add3 => (lambda (x) (+ x 3))

gen:sum => 2

gen:gen => (lambda () (inc gen:sum))

In Scheme la chiusura lambda è nascosta dall'ispezione, una volta che è stata valutata e assegnata.

Le funzioni in newLISP sono liste di primo ordine
-------------------------------------------------

(define (double x) (+ x x)))
(setf (nth 1 double) '(mul 2 x))

double => (lambda (x) (mul 2 x))

La natura di prima classe delle espressioni lambda in newLISP consente di scrivere codice auto-modificante.

Funzioni con memoria (stateful) che utilizzano la modifica in-place
-------------------------------------------------------------------

;; sum accumulator
(define (sum (x 0)) (inc 0 x))

(sum 1) ;=> 1
(sum 2) ;=> 3

sum ;=> (lambda ((x 0)) (inc 3 x))

;; self incremeneter
(define (incre) (inc 0))

(incre) ;=> 1
(incre) ;=> 2
(incre) ;=> 3

incre ;=> (lambda () (inc 3)

;; make stream function with expansion closure

(define (make-stream lst)
    (letex (stream lst)
        (lambda () (pop 'stream))))

(set 'lst '(a b c d e f g h))
(define mystream (make-stream lst))

(mystream) ;=> a
(mystream) ;=> b
(mystream) ;=> c

(set 'str "abcddefgh")
(define mystream (make-stream str))

(mystream) ;=> "a"
(mystream) ;=> "c"

Un altro interessante pattern automodificante è mostrato da Kazimir Majorinc all'indirizzo:
http://kazimirmajorinc.com/Documents/Crawler-tractor/index.html

(define (f)
  (begin
    (println (inc cnt))
    (push (last f) f -1)
    (if (> (length f) 3) (pop f 1))))

Il pattern chiamato "Crawler tractor" (trattore cingolato) verrà eseguito per sempre senza utilizzare iterazione o ricorsione. Il nuovo codice da eseguire viene copiato dal vecchio codice e aggiunto alla fine della funzione. Il vecchio codice eseguito viene estratto dall'inizio della funzione.
newLISP ha la possibilità unica di scrivere funzioni auto-modificanti.


============================================================================
Creazione di funzioni con ambito lessicale in newLISP di Lutz Mueller
============================================================================

Una funzione predefinita appare e si comporta in modo analogo alle funzioni con ambito statico trovate in altri linguaggi di programmazione. Diverse funzioni possono condividere uno spazio di nomi.

Utilizzando la primitiva integrata "def-new", è possibile definire una funzione o una macro per creare altre funzioni racchiuse nel proprio spazio di nomi:

(define (def-static s body)
    (def-new 'body (sym s s)))

(setq sum 0)

(def-static 'acc (lambda (x)
        (inc sum x)))

(acc 5)  → 5
(acc 5)  → 10
(acc 2)  → 12

acc:sum  → 12
acc:x    → nil

acc:acc  → (lambda (acc:x) (inc acc:sum acc:x))

sum      → 0

La funzione lavora creando un contesto e un functor predefinito dal nome della funzione. Il valore di acc:sum viene inizializzato a 0 copiando il valore di MAIN:sum.

Utilizzando acc come prototipo, è possibile creare nuove funzioni con ambito statico:

  (new 'acc 'myacc)

  (myacc 3) → 15

La nuova funzione inizierà con myacc:sum come presente in acc:sum quando viene copiato con new.

Utilizzando un metodo più complesso, una def-static può essere definita come una macro che può essere utilizzata come la normale funzione di definizione:

;; define static functions (use only in context MAIN)
;;
;; Example:
;;
;; (def-static (foo x) (+ x x))
;;
;; foo:foo   → (lambda (foo:x) (+ foo:x foo:x))
;;
;; (foo 10)  → 20
;;
(define-macro (def-static)
   (let (temp (append (lambda) (list (1 (args 0)) (args 1))))
       (def-new 'temp (sym (args 0 0) (args 0 0)))))

(def-static (acc x)
       (inc sum x))

(acc 5)  → 5
(acc 5)  → 10
(acc 2)  → 12

acc:sum  → 12
acc:x    → nil

La macro def-static crea innanzitutto un'espressione lambda della funzione da definire nello spazio di nomi attuale e la assegna alla variabile temp. In una seconda fase, la funzione lambda in temp viene copiata nel proprio spazio di nomi. Ciò accade assegnandolo al functor predefinito acc:acc costruito partendo dal nome della funzione.


============================================================================
The Y of Why in newLISP di Lutz Mueller
============================================================================

Il compito è trovare una funzione Y, che può trasformare una funzione ricorsiva in una funzione veramente funzionale senza effetti collaterali, senza variabili libere e con la proprietà del punto fisso (fixed point). Quanto segue è una versione di "The Why of Y" [1] di Richard P. Gabriel modificata per newLISP.

Trovare Y
---------
Questa è la definizione ricorsiva originale del fattoriale:

  (define fact (lambda (n) (if (<n 2) 1 (* n (fact (- n 1))))))

L'originale fattoriale ridefinito come funzione anonima e prendendo il vero fattoriale in h:

  (lambda (h) (lambda (n) (if (<n 2) 1 (* n (h (- n 1))))))

Se questa funzione è chiamata F e il fattoriale vero è f allora ((F f) n) = (F n), f è un punto fisso di F.

Stiamo cercando una funzione Y con la proprietà: ((F (Y F)) x) = ((Y F) x)

Questa funzione è chiamata "Applicative-order Y fixed point operator" per i funzionali. Per ottenere ciò, trasformiamo la forma base della funzione fattoriale:

Il fattoriale base con il vero fattoriale:

  (lambda (n) (if (<n 2) 1 (* n (h (- n 1)))))

Passiamo la funzione fattoriale come parametro:

  (lambda (h n) (if (<n 2) 1 (* n (h h (- n 1)))))

Impacchettiamo come espressione anonima e proviamo:

  (let ((g (lambda (h n)
           (if (<n 2) 1 (* n (h h (- n 1)))))))
    (g g 10)); => 3628800

Fino a questo punto le espressioni sono identiche a quelle trovate in "The Why of Y" di Richard P. Gabriel. Il resto delle trasformazioni segue Gabriel, ma inserisce la funzione newLISP "expand" dove richiesto per ottenere un effetto di chiusura per la funzione passata come parametro nell'espressione (lambda (h) ...).

Curry (g g 10) a ((g g) 10):

  (let ((g (lambda (h)
          (espandi (lambda (n) (if (<n 2) 1 (* n ((h h) (- n 1))))) 'h))))
      ((g g) 10))

Estraiamo (h h) come f:

  (let ((g (lambda (h)
            (espandi (lambda (n)
              (let ((f (lambda (f n)
                      (if (<n 2) 1 (* n (f (- n 1)))))))
              (f (h h) n))) 'h))))
           ((g g) 10))

Curry la definizione di f per f interna a (lambda (f n) ...):

  (let ((g (lambda (h)
           (espandi (lambda (n)
            (let ((f (lambda (q)
                   (espandi (lambda (n)
                     (se (<n 2) 1 (* n (q (- n 1))))) 'q)))); in Schema
             ((f (h h)) n))) 'h))))
    ((g g) 10))

Riscriviamo per portare f in cima:

  (let ((f (lambda (q) (expand (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q))))
    (let ((g (lambda (h) (expand (lambda (n) ((f (h h)) n)) 'h))))
       ((g g) 10)))

La funzione Y
-------------
Ora definiamo Y come la corretta espansione e sostituzione di h e f:

  (define Y (lambda (f) (expand
      (let ((g (lambda (h) (expand (lambda (x) ((f (h h)) x)) 'h))))
            (g g)) 'f)))

Evitando il let e portando fuori l'espressione (g g) si ottiene:

  (define  Y (lambda (f) (expand
      ((lambda (h) (expand (lambda (x) ((f (h h)) x)) 'h))
       (lambda (h) (expand (lambda (x) ((f (h h)) x)) 'h))) 'f)) )

newLISP deve applicare expand per ottenere l'effetto di chiusura per la procedura passata q:

  (define f
    (lambda (q) (expand (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q)))

  ((Y f) 10) ;=> 3628800

Mostriamo la proprietà del punto fisso:

  (= ((Y f) 10) ((f (Y f)) 10) ) ;=> true

  ((f (Y f)) 10) ;=> 3628800

  ((f (f (Y f))) 10) ;=> 3628800

Il valore di ritorno di (Y f) mostra che (Y f) è puramente funzionale, senza effetti collaterali e senza variabili libere:

  (lambda (x)
  (((lambda (q) (expand (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q))
    ((lambda (h) (expand (lambda (x) (((lambda (q) (expand
       (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q)) (h h)) x)) 'h))
     (lambda (h) (expand (lambda (x) (((lambda (q) (expand
       (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q)) (h h)) x)) 'h)))) x))

Controlla un'altra funzione ricorsiva fibo:

  (define f (lambda (q) (expand
           (lambda(n) (if(< n 2) 1 (+  (q (- n 1)) (q (- n 2))))) 'q)) )

  (define fibo (Y f))

  (fibo 10) ;=> 89

[1] "The Why of Y" di Richard P. Gabriel - 2001
http://www.dreamsongs.com/NewFiles/WhyOfY.pdf


Note
----
Il Lambda calcolo in newLISP è basato sulla ridefinizione di Lambda - expand espande le variabili maiuscole:

    (define-macro (LAMBDA)
      (append (lambda ) (expand (args))))

Per una differente versione di Y, ma con identiche funzionalità, vedi: "The Y Combinator (Slight Return)" di Mike Vanier
https://mvanier.livejournal.com/2897.html


============================================================================
Expression evaluation, Implicit Indexing, Contexts and Default Functors
Lutz Mueller, 2007-2013. Last edit December 6th 2013, rev r9
============================================================================

Implicit indexing and Default Functors in newLISP are an extension of normal LISP expression evaluation rules. Contexts provide lexically closed state-full namespaces in a dynamically scoped programming language.

S-expression evaluation and implicit indexing
---------------------------------------------
In an earlier paper it was explained how s-expression evaluation in newLISP relates to ORO (One Reference Only) automatic memory management [1]. The following pseudo code of the expression evaluation function in newLISP shows how implicit indexing is an extension of Lisp s-expression evaluation rules:

function evaluateExpression(expr)
    {
    if typeOf(expr) is constant (BOOLEAN, NUMBER, STRING, CONTEXT)
        return(expr)

    if typeOf(expr) is SYMBOL
        return(symbolContents(expr))

    if typeOf(expr) is QUOTED
        return(unQuotedContents(expr))

    if typeOf(expr) is LIST
        {
        func = evaluateExpression(firstOf(expr))
        args = rest(expr)
        if typeOf(func) is BUILTIN_FUNCTION
            result = evaluateFunc(func, args)
        else if typeOf(func) = LAMBDA_FUNCTION
            result = evaluateLambda(func, args)
		/* extensions for default functor */
        if typeOf(func) is CONTEXT
            func = defaultFunctor(func)
                if typeOf(func) = LAMBDA_FUNCTION
                    result = evaluateLambda(defaultFunctor(func), args)
        /* extensions for implicit indexing */
        else if typeOf(func) = LIST
            result = implicitIndexList(func, args)
        else if typeOf(func) = STRING
            result = implicitIndexString(func, args)
        else if typeOf(func) = ARRAY
            result = implicitIndexArray(func, args)
        else if typeOf(func) = NUMBER
            result = implicitNrestSlice(func, args)
        }
    }

    return(result)
    }

The general working of the function reflects the general structure of the eval function as described by John McCarthy in 1960, [2].

The function first processes atomic expression types. Constants evaluate to themselves and are returned. Symbols evaluate to their contents.

If the expression is a list the first element gets applied to the rest elements. As in Scheme, newLISP evaluates the first element before applying it the result to its arguments.

Traditional Lisp or Scheme only permit a built-in function, operator or user defined lambda expression in the first, functor position of the s-expression list for evaluation. In newLISP the context symbol type, list, array and number type also act as functions when in the functor position.

Built-in functions are evaluated calling evaluateFunc(func, args), functors which are lambda expressions call the evaluateLambda(func, args) function. Both functions in turn will call evaluateExpression(expr) again for evaluation of function arguments.

The working of a context symbol in the functor position of an s-expression will be explained further down in the chapter about namespaces and default functors.

The list type causes newLISP to evaluate the whole s-expression to the element indexed by the number(s) following the list and interpreted as index or indices (in newLISP elements in nested lists can be addressed using multiple indices):

(set 'lst '(a b (c d e) f g))
(lst 2)  → (c d e)
(lst 2 1)  → d

(set 'str "abcdefg")
(str 2)  → "c"

A number in the functor position will assume slicing functionality and slice the following list at the offset expressed by the number. When the number is followed by a second number, the second number specifies the size or length of the sliced part of the list:

(1 lst)  → (b (c d e) f g)
(1 2 lst)  → (b (c d e))

(1 2 str)  → "bc"

On first sight it seems logical to extend the same principle to the boolean data type. A ternary conditional expressions could be constructed without the necessity of the if operator, but in practical programming this leads to difficulties when reading code and causes too much ambiguity in error messages. Most of the time implicit indexing leads to better readable code, because the data object is grouped together with it's indices. Implicit indexing performs faster, but is also optional. The keywords nth, first, last and rest and slice can be used in the few cases where readability is better when using the explicit form of indexing.

The environment stack and dynamic scoping
-----------------------------------------
In the original Lisp eval function a variable environment is implemented as an association list of symbols and their values. In newLISP a symbol is implemented as a data structure with one value slot and the environment is not an association list but a binary tree structure of symbols and an environment stack storing previous values of symbols in higher evaluation levels.

When entering a lambda function, the parameter symbols and their current values are pushed on to the environment stack. When leaving the function, the symbols are restored to their previous values when popping the environment stack. Any other function called will see symbol values as currently defined in the scope of the calling function. The variable environment changes dynamically while calling and returning from functions. The scope of a variable extends dynamically into lower call levels.

The following example sets two variables and defines two lambda functions. After the function definitions the functions are used in a nested fashion. The changing parts of the variable environment are shown in bold type face:

; x  → nil, y  → nil;
; foo  → nil
; double  → nil
; environment stack: [ ]

(define (foo x y)
	(+ (double (+ x 1)) y))

; x → nil, y  → nil,
; foo  → (lambda (x y) (+ (double (+ x 1)) y))
; double  → nil
; environment stack: [ ]

(define (double x)
	(* 2 x))

; x  → nil, y  → nil
; foo  → (lambda (x y) (+ (double (+ x 1)) y))
; double  → (lambda (x) (* 2 x)))
; environment stack: [ ]

(set 'x 10) (set 'y 20)

; x  → 10, y  → 20
; foo  → (lambda (x y) (+ (double (+ x 1)) y))
; double  → (lambda (x) (* 2 x)))
; environment stack: [ ]

Similar to Scheme newLISP uses the same namespace for variable symbols and symbols holding user-defined lambda functions. The define function is just a short-cut for writing:

(set 'foo (lambda (x y) (+ (double (+ x 1)) y)))
During all these operations the environment stack stays empty [ ]. Symbol variables holding lambda expressions are part of the same namespace and treated the same way as variables holding data. Now the the first function foo gets called:

(foo 2 4)

; after entering the function foo
; x → 2, y → 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
; environment stack: [x -> 10, y -> 20]

After entering the functions, the old values of x and y are pushed on the environment stack. This push-operation is initiated by the function evaluateLambda(func, args), discussed later in this paper. Inside foo the second function double is called:

(double 3)
; after entering the function double
; x -> 3, y -> 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
; environment stack: [x -> 10, y -> 20, x -> 2]

; after return from double
; x → 2, y → 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
; environment stack: [x -> 10, y -> 20]

; after return from foo
; x → 10, y → 20
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
; environment stack: [ ]

Note that in newLISP dynamic scoping of parameter symbols in lambda expressions does not create lexical state-full closures around those symbols as in the Scheme dialect of Lisp. On return from the lambda function the symbol contents gets destroyed and memory is reclaimed. The parameter symbols regain their old values on exit from the lambda function by popping them from the environment stack.

In newLISP lexical state-full closures are not realized using lambda closures but using lexical namespaces. Lambda functions in newLISP do not create closures but can create a new scope and new temporary content for existing symbols during lambda function execution.

Lambda function evaluation
--------------------------
All of the processing just described happens in evaluateLambda(func, args). The following pseudo code shows more detail:

function evaluateLambda(lambda-func, args)
    {
    for each parameter symbol in lambda-func
        pushEnvironmentStack(symbol, value)

    for each arg in args and the symbol belonging to arg
        ; evaluation of arg happens in old symbol environment
        assignSymbolValue(symbol, evaluateExpression(arg))

    for each body expression expr in lambda-func
        result = evaluateExpression(expr)

    for each parameter symbol in lambda-func
        popEnvironmentStack()

    return(result)
    }

The evaluateExpression(args) function and evaluateLambda(func, args) call each other in a recursive cycle.

Note that arguments to lambda functions are evaluated in the variable environment as defined previous to the lambda function call. Assignments to parameters symbols do happen after all argument evaluations. Only the arguments are evaluated which have a corresponding parameter symbol. If there are more parameter symbols than arguments passed, then parameter symbols are assigned nil or a default value.

Namespaces and the translation and evaluation cycle
All memory data objects in newLISP are bound directly or indirectly to a symbol. Either memory objects are directly referenced by a symbol or they are part of an enclosing s-expression memory object referenced by a symbol. Unbound objects only exist as transient objects as returned values from evaluations and are referenced on the result stack for later deletion [1].

Except for symbols, all data and program objects are referenced only once. Symbols are created and organized in a binary tree structure. Namespaces, called contexts in newLISP, are sub-branches in this binary tree. A context is bound to a symbol in the root context MAIN, which itself is a symbol in the root context.

With few exceptions all symbols are created during the code loading and translation phase of the newLISP interpreter. Only the functions load, sym, eval-string and a special syntax of context create symbols during runtime execution.

The two symbols MAIN:x and CTX:x are two different symbols at all times. A symbol under no circumstances can change it's context after it was created. A context, e.g CTX, itself is a symbol in MAIN containing the root pointer to a sub-branch in the symbol tree.

The working of context switching is explained using the following two code pieces:

(set 'var 123)
(define (foo x y)
    (context 'CTX)
    (println var " " x " " y))

The (context 'CTX) statement only has been included here to show, it has no effect in this position. A switch to a different namespace context will only have influence on subsequent symbol creation using sym or eval-string. By the time (context 'CTX) is executed foo has already been defined and all symbols used in it have been looked up and translated. Only when using (context ...) on the top level it will influence the symbol creation of code following it:

(context 'CTX)
(set 'var 123)
(define (foo x y)
    (println var " " x " " y))
(context MAIN)

Now the context is created and switched to on the top-level. When newLISP translates the subsequent set-statement and function definition, all symbols will be part of CTX as CTX:var, CTX:foo, CTX:x and CTX:y.

When loading code newLISP reads a top-level expression translating then evaluating it. This cycle is repeated until all top-level expression are read and evaluated.

(set 'var 123)
(define (foo x y)
    (println var " " x " " y))

In the previous code snippet two top-level expressions are translated and evaluated resulting in the creation of the three symbols: MAIN:var, MAIN:foo, MAIN:x, MAIN:y and MAIN:CTX.

The symbol MAIN:var will contain the number 123 and the MAIN:foo symbols will contain the lambda expression (lambda (x y) (println var " " x " " y)). The symbols MAIN:x and MAIN:y both will contain nil. The var inside the definition of foo is the same as the var previously set to 123 and will be printed as 123 during execution of foo.

In detail the following steps are happening:

1. current context is MAIN
2. read the opening top-level parenthesis I and create a Lisp cell of type EXPRESSION.
3. read and lookup set in MAIN and find it to be a built-in primitive in MAIN, translate it to the address of this primitive function in memory. Create a Lisp cell of type PRIMITIVE containing the functions address in its contents slot.
4. read the quote ' and create a Lisp cell of type QUOTE.
5. read and lookup lookup var in MAIN, it is not found in MAIN, create it in MAIN and translate it to the address in the binary symbol tree. Create a Lisp cell of type SYMBOL containing the symbols address in its contents slot. The previously created quote cell serves as an envelop for the symbols cell.
6. read 123 and create a Lisp cell of type INTEGER with 123 in its contents slot.
7. read the closing top-level parenthesis finish the following list structure in memory:

[ ]                          ; cell of type: EXPRESSION
  \
 [MAIN:set]  → [']  → [123]  ; three cells of type: PRIMITIVE, QUOTE, INTEGER
                 \
               [MAIN:var]    ; cell of type: SYMBOL

The above list diagram shows the five Lisp cells, which are created. List and quote cells are envelope cells containing a list or a quoted expression.

The statement (set 'var 123) is not executed yet, but symbol translation and creation have finished and the statement exists as a list structure in memory. The whole list structure can be referenced with one memory address, the address of the first created cell of type EXPRESSION.

8. Evaluate the statement

In similar fashion newLISP will read and translate the next top-level expression, which is the function definition of foo. Evaluating this top-level expression will result in an assignment of a lambda expression to the foo symbol.

In the above code snippet both instances of var refer to MAIN:var. The (context 'CTX) statement only changes the context, namespaces for newly created symbols. The symbol var was created during loading translating the foo function. By the time foo is called and executed var already exists inside the foo function as MAIN:var. The (context 'CTX) statement doesn't have any effect of the subsequent execution of (println var).

Context statements like (context 'CTX) above, change the current context for symbol creation during the loading and translation phase. The current context defines under which branch in the symbol tree new symbols are created. This affects only the the functions sym, eval-string and a special syntax of context to create symbols. Once a symbol belongs to a context it stays there.

Namespace context switching
---------------------------
Previous chapters showed how to use context switching on the top-level of a newLISP source file to influence symbol creation and translation during the source loading process. Once different namespaces exist, calling a function which belongs to different context, will cause a context switch to the namespace the called lambda function resides in. If the called function doesn't execute any sym or eval-string statements, then these context switches don't have any effect. Even the load command will always start file loading relative to context MAIN unless a different context is specified as a special parameter in load. Inside the file loaded context switches will have an effect of symbol creation during the load process as explained previously.

What causes the context switch is the symbol holding the lambda function. In the following code examples bold face is used for output generated by println statements:

(context 'Foo)
(set 'var 123)
(define (func)
    (println "current context: " (context))
    (println "var: " var))
(context 'MAIN)

(Foo:func)
current context: Foo
var: 123

(set 'aFunc Foo:func)
(set 'var 999)

(aFunc)
current context: MAIN
var: 123

Note that the call to aFunc causes the current context to be shown as MAIN, because the symbol aFunc belongs to context MAIN. In both cases var is printed as 123. The symbol var was put into the Foo namespace during translation of func and will always stay there, even if a copy of the lambda function is made and assigned to a symbol in a different context.

This context switching behaviour follows the same rules when applying or mapping functions:

(apply 'Foo:func)
current context: Foo
var: 123

(apply Foo:func)
current context: MAIN
var: 123

The first time Foo:func is applied as a symbol – quoted, the second time the lambda function contained in Foo:func is applied directly, because apply evaluates it's first argument first.

Namespaces and the default functor
----------------------------------
In newLISP a symbol is a default functor if it has the same name as the context it belongs too, e.g. Foo:Foo is the default functor symbol in the context Foo. In newLISP when using a context symbol in the functor position, it is taken as the default functor:

(define (double:double x) (* 2 x))
(double 3)  → 6

(set 'my-list:my-list '(a b c d e f))
(my-list 3)  → d

The second example combines implicit indexing with usage of a default functor.

Default functors can be applied and mapped using apply and map like any other function or functor symbol:

(map my-list '(3 2 1 2))  → (d c b c)

(apply double '(10))  → 20

Default functors are a convenient way in newLISP to pass lists or other big data objects by reference:

(set 'my-list:my-list '(a b c d e f))

(define (set-last ctx val)
	(setf (ctx -1) val))

(set-last my-list 99)  → f

my-list:my-list  → (a b c d e 99)

Default functors are also a convenient way to define functions with a closed state-full name space:

(context 'accumulator)
(define (accumulator:accumulator x)
	(if (not value)
		(set 'value x)
		(inc 'value x)))
(context MAIN)

(accumulator 10)  → 10
(accumulator 2)  → 12
(accumulator 3)  → 15

Note that the symbols x and value both belong to the namespace accumulator. Because (context 'accumulator) is at the top level, the translation of following function definition for accumulator:accumulator happens inside the current namespace accumulator.

Namespaces in newLISP can be passed by reference and can be used to create state-full lexical closures.

The default functor used as a pseudo hash function
--------------------------------------------------
A default functor containing nil and in operator position will work similar to a hash function for building dictionaries with associative key → value access:

(define aHash:aHash) ; create namespace and default functor containing nil

(aHash "var" 123) ; create and set a key "var" to 123

(aHash "var")  → 123 ; retrieve value from key

References
----------

[1] Lutz Mueller, 2004-2013
Automatic Memory Management in newLISP.

[2] John McCarthy, 1960
Recursive Functions of Symbolic Expressions and their Computation by Machine.

Copyright © 2007-2013, Lutz Mueller http://newlisp.org. All rights reserved.


============================================================================
Automatic Memory Management in newLISP
Lutz Mueller, 2004-2013. Last edit 2013-11-07
============================================================================

ORO (One Reference Only) automatic memory management developed for newLISP is a fast and resources saving alternative to classic garbage collection algorithms in dynamic, interactive programming languages. This article explains how ORO memory management works.

newLISP and any other interactive language system will constantly generate new memory objects during expression evaluation. The new memory objects are intermediate evaluation results, reassigned memory objects, or memory objects whose content was changed. If newLISP did not delete some of the objects created, it would eventually run out of available memory.

In order to understand newLISP's automatic memory management, it is necessary to first review the traditional methods employed by other languages.

Traditional automatic memory management (Garbage Collection)
------------------------------------------------------------
In most programming languages, a process registers allocated memory, and another process finds and recycles the unused parts of the allocated memory pool. The recycling process can be triggered by some memory allocation limit or can be scheduled to happen between evaluation steps. This form of automatic memory management is called Garbage Collection.

Traditional garbage collection schemes developed for LISP employed one of two algorithms: ¹

(1) The mark-and-sweep algorithm registers each allocated memory object. A mark phase periodically flags each object in the allocated memory pool. A named object (a variable symbol) directly or indirectly references each memory object in the system. The sweep phase frees the memory of the marked objects when they are no longer in use.

(2) A reference-counting scheme registers each allocated memory object together with a count of references to the object. This reference count gets incremented or decremented during expression evaluation. Whenever an object's reference count reaches zero, the object's allocated memory is freed.

Over time, many elaborate garbage collection schemes have been attempted based on these principles. The first garbage collection algorithms appeared in LISP. The inventors of the Smalltalk language used more elaborate garbage collection schemes. The history of Smalltalk-80 is an exciting account of the challenges of implementing memory management in an interactive programming language, see [Glenn Krasner, 1983: Smalltalk-80, Bits of History, Words of Advice]. A more recent overview of garbage collection methods can be found in [Richard Jones, Rafael Lins, 1996: Garbage Collection, Algorithms for Automatic Dynamic Memory Management].

One reference only, (ORO) memory management
-------------------------------------------
Memory management in newLISP does not rely on a garbage collection algorithm. Memory is not marked or reference-counted. Instead, a decision whether to delete a newly created memory object is made right after the memory object is created.

Empirical studies of LISP have shown that most LISP cells are not shared and so can be reclaimed during the evaluation process. Aside from some optimizations for part of the built-in functions, newLISP deletes memory new objects containing intermediate evaluation results once it reaches a higher evaluation level. newLISP does this by pushing a reference to each created memory object onto a result stack. When newLISP reaches a higher evaluation level, it removes the last evaluation result's reference from the result stack and deletes the evaluation result's memory object. This should not be confused with one-bit reference counting. ORO memory management does not set bits to mark objects as sticky.

newLISP follows a one reference only (ORO) rule. Every memory object not referenced by a symbol is obsolete once newLISP reaches a higher evaluation level during expression evaluation. Objects in newLISP (excluding symbols and contexts) are passed by value copy to other user-defined functions. As a result, each newLISP object only requires one reference.

newLISP's ORO rule has advantages. It simplifies not only memory management but also other aspects of the newLISP language. For example, while users of traditional LISP have to distinguish between equality of copied memory objects and equality of references to memory objects, newLISP users do not.

newLISP's ORO rule forces newLISP to constantly allocate and then free LISP cells. newLISP optimizes this process by allocating large chunks of cell memory from the host operating system. newLISP will request LISP cells from a free cell list and then recycle those cells back into that list. As a result, only a few CPU instructions (pointer assignments) are needed to unlink a free cell or to re-insert a deleted cell.

The overall effect of ORO memory management is a faster evaluation time and a smaller memory and disk footprint than traditional interpreted LISP's can offer. Time spent linking and unlinking memory objects is more than compensated for by the lack of processing time used in traditional garbage collection. ORO memory management also avoids occasional processing pauses seen in languages using traditional garbage collection and the tuning of garbage collection parameters required when running memory intensive programs.

ORO memory management happens synchronous to other processing in the interpreter, which results in deterministic processing times.

In versions before 10.1.3, newLISP employed a classic mark and sweep algorithm to free un-referenced cells under error conditions. Starting version 10.1.3, this has been eliminated and replaced by a proper cleanup of the result stack under error conditions.

Performance considerations with copying parameters
--------------------------------------------------
In theory, passing parameters to user-defined functions by value (memory copying) instead by reference poses a potential disadvantage when dealing with large lists, arrays or strings. But in practice newLISP performs faster or as fast than other scripting languages and offers language facilities to pass very large memory object by reference.

Since newLISP version 9.4.5 functions can pass list, array and string type parameters as references using default functor namespace ids. Namespaces (called contexts in newLISP) have very little overhead and can be used to wrap functions and data. This allows reference passing of large memory object into user-defined functions.

Since version 10.2 FOOP (Functional Object Oriented Programming) in newLISP also passes the target object of a method call by reference.

But even in instances where reference passing and other optimizations are nor present, the speed of ORO memory management more than compensates for the overhead required to copy and delete objects.

Optimizations to ORO memory management ²
--------------------------------------
Since newLISP version 10.1, all lists, arrays and strings are passed in and out of built-in functions by reference. All built-in functions work directly on memory objects returned by reference from other built-in functions. This has substantially reduced the need for copying and deleting memory objects and increased the speed of some built-in functions. Now only parameters into user-defined functions and return values passed out of user-defined functions are ORO managed.

Since version 10.3.2, newLISP checks the result stack before copying LISP cells. This has reduced the amount of cells copied by about 83% and has significantly increased the speed of many operations on bigger lists.

Memory and datatypes in newLISP
-------------------------------
The memory objects of newLISP strings are allocated from and freed to the host's OS, whenever newLISP recycles the cells from its allocated chunks of cell memory. This means that newLISP handles cell memory more efficiently than string memory. As a result, it is often better to use symbols rather than strings for efficient processing. For example, when handling natural language it is more efficient to handle natural language words as individual symbols in a separated name-space, then as single strings. The bayes-train function in newLISP uses this method. newLISP can handle millions of symbols without degrading performance.

Programmers coming from other programming languages frequently overlook that symbols in LISP can act as more than just variables or object references. The symbol is a useful data type in itself, which in many cases can replace the string data type.

Integer numbers and double floating-point numbers are stored directly in newLISP's LISP cells and do not need a separate memory allocation cycle.

For efficiency during matrix operations like matrix multiplication or inversion, newLISP allocates non-cell memory objects for matrices, converts the results to LISP cells, and then frees the matrix memory objects.

newLISP allocates an array as a group of LISP cells. The LISP cells are allocated linearly. As a result, array indices have faster random access to the LISP cells. Only a subset of newLISP list functions can be used on arrays. Automatic memory management in newLISP handles arrays in a manner similar to how it handles lists.

Implementing ORO memory management
----------------------------------
The following pseudo code illustrates the algorithm implemented in newLISP in the context of LISP expression evaluation. Only two functions and one data structure are necessary to implement ORO memory management:

function pushResultStack(evalationResult)

function popResultStack() ; implies deleting

array resultStack[] ; preallocated stack area
The first two functions pushResultStack and popResultStack push or pop a LISP object handle on or off a stack. pushResultStack increases the value resultStackIndex while popResultStack decreases it. In newLISP every object is contained in a LISP cell structure. The object handle of that structure is simply the memory pointer to the cell structure. The cell itself may contain pointer addresses to other memory objects like string buffers or other LISP cells linked to the original object. Small objects like numbers are stored directly. In this paper function popResultStack() also implies that the popped object gets deleted.

The two resultStack management functions described are called by newLISP's evaluateExpression function: ³

function evaluateExpression(expr)
    {
    resultStackIndexSave = resultStackIndex

    if typeOf(expr) is BOOLEAN or NUMBER or STRING
		return(expr)

    if typeOf(expr) is SYMBOL
        return(symbolContents(expr))

    if typeOf(expr) is QUOTE
        return(quoteContents(expr))

    if typeOf(expr) is LIST
        {
        func = evaluateExpression(firstOf(expr))
        args = rest(expr)
        if typeOf(func) is BUILTIN_FUNCTION
                result = evaluateFunc(func, args)
        else if typeOf(func) = LAMBDA_FUNCTION
                result = evaluateLambda(func, args)
        }
    }

    while (resultStackIndex > resultStackIndexSave)
        deleteList(popResultStack())

    pushResultStack(result)

    return(result)
    }

The function evaluateExpression introduces the two variables resultStackIndexSave and resultStackIndex and a few other functions:

resultStackIndex is an index pointing to the top element in the resultStack. The deeper the level of evaluation the higher the value of resultStackIndex.

resultStackIndexSave serves as a temporary storage for the value of resultStackIndex upon entry of the evaluateExpression(func, args) function. Before exit the resultStack is popped to the saved level of resultStackIndex. Popping the resultStack implies deleting the memory objects pointed to by entries in the resultStack.

resultStack[] is a preallocated stack area for saving pointers to LISP cells and indexed by resultStackIndex.

symbolContents(expr) and quoteContents(expr) extract contents from symbols or quote-envelope cells.

typeOf(expr) extracts the type of an expression, which is either a BOOLEAN constant like nil or true or a NUMBER or STRING, or is a variable SYMBOL holding some contents, or a QUOTE serving as an envelope to some other LIST expression expr.

evaluateFunc(func, args) is the application of a built-in function to its arguments. The built-in function is the evaluated first member of a list in expr and the arguments are the rest of the list in expr. The function func is extracted calling evaluateExpression(first(expr)) recursively. For example if the expression (expr is (foo x y) than foo is a built-in function and x and y are the function arguments or parameters.

evaluateLambda(func, args) works similar to evaluateFunc(func, args), applying a user-defined function first(expr) to its arguments in rest(expr). In case of a user-defined function we have two types of arguments in rest(expr), a list of local parameters followed by one or more body expressions evaluated in sequence.
Both, evaluateFunc(func, args) and evaluateLambda(func, args) will return a newly created or copied LISP cell object, which may be any type of the above mentioned expressions. Since version 10.0, many built-in functions processed with evaluateFunc(func, args) are optimized and return references instead of a newly created or copied objects. Except for these optimizations, result values will always be newly created LISP cell objects destined to be destroyed on the next higher evaluation level, after the current evaluateExpression(expr) function execution returned.

Both functions will recursively call evaluateExpression(expr) to evaluate their arguments. As recursion deepens, the recursion level of the function increases.

Before evaluateExpression(func, args) returns, it will pop the resultStack deleting the result values from deeper level of evaluation and returned by one of the two functions, either evaluateFunc or evaluateLambda.

Any newly created result expression is destined to be destroyed later but its deletion is delayed until a higher, less deep, level of evaluation is reached. This permits results to be used and/or copied by calling functions.

The following example shows the evaluation of a small user-defined LISP function sum-of-squares and the creation and deletion of associated memory objects:

(define (sum-of-squares x y)
	(+ (* x x) (* y y)))

(sum-of-squares 3 4) => 25
sum-of-squares is a user-defined lambda-function calling to built-in functions + and *.

The following trace shows the relevant steps when defining the sum-of-squares function and when executing it with the arguments 3 and 4.

> (define (sum-of-squares x y) (+ (* x x) (* y y)))

level 0: evaluateExpression( (define (sum-of-squares x y)
 (+ (* x x) (* y y))) )
level 1: evaluateFunc( define <6598> )
level 1: return( (lambda (x y) (+ (* x x) (* y y))) )

→ (lambda (x y) (+ (* x x) (* y y)))

> (sum-of-squares 3 4)

level 0: evaluateExpression( (sum-of-squares 3 4) )
level 1:   evaluateLambda( (lambda (x y) (+ (* x x) (* y y))), (3 4) )
level 1:   evaluateExpression( (+ (* x x) (* y y)) )
level 2:     evaluateFunc( +, ((* x x) (* y y)) )
level 2:     evaluateExpression( (* x x) )
level 3:       evaluateFunc( *, (x x) )
level 3:       pushResultStack( 9 )
level 3:       return( 9 )
level 2:     evaluateExpression( (* y y) )
level 3:       evaluateFunc( *, (y y) )
level 3:       pushResultStack( 16 )
level 3:       return( 16 )
level 2:     popResultStack() → 16
level 2:     popResultStack() → 9
level 2:     pushResultStack( 25 )
level 2:     return( 25 )
level 1:   return( 25 )

→ 25

The actual C-language implementation is optimized in some places to avoid pushing the resultStack and avoid calling evaluateExpression(expr). Only the most relevant steps are shown. The function evaluateLambda(func, args) does not need to evaluate its arguments 3 and 4 because they are constants, but evaluateLambda(func, args) will call evaluateExpression(expr) twice to evaluate the two body expressions (+ (* x x) and (+ (* x x). Lines preceded by the prompt > show the command-line entry.

evaluateLambda(func, args) also saves the environment for the variable symbols x and y, copies parameters into local variables and restores the old environment upon exit. These actions too involve creation and deletion of memory objects. Details are omitted, because they are similar to methods in other dynamic languages.

References
– Glenn Krasner, 1983: Smalltalk-80, Bits of History, Words of Advice
Addison Wesley Publishing Company

– Richard Jones, Rafael Lins, 1996: Garbage Collection, Algorithms for Automatic Dynamic Memory Management
John Wiley & Sons

¹ Reference counting and mark-and-sweep algorithms where specifically developed for LISP. Other schemes like copying or generational algorithms where developed for other languages like Smalltalk and later also used in LISP.

² This chapter was added in October 2008 and extended August 2011.

³ This is a shortened rendition of expression evaluation not including handling of default functors and implicit indexing. For more information on expression evaluation see: Expression evaluation, Implicit Indexing, Contexts and Default Functors in the newLISP Scripting Language.

Copyright © 2004-2013, Lutz Mueller http://newlisp.org. All rights reserved.


============================================================================
Frasi Famose sulla Programmazione e sul Linguaggio Lisp
============================================================================

"Programs must be written for people to read, and only incidentally for machines to execute."
- Abelson & Sussman, SICP, preface to the first edition

"Lisp is a programmable programming language."
- John Foderaro, CACM, September 1991

"Lisp is worth learning for the profound enlightenment experience you will have when you finally get it; that experience will make you a better programmer for the rest of your days, even if you never actually use Lisp itself a lot."
- Eric Raymond, "How to Become a Hacker"

"Lisp has jokingly been called: 'the most intelligent way to misuse a computer'. I think that description is a great compliment because it transmits the full flavor of liberation: it has assisted a number of our most gifted fellow humans in thinking previously impossible thoughts."
- Edsger Dijkstra, CACM, 15:10

"Lisp isn't a language, it's a building material."
- Alan Kay

"Lisp was far more powerful and flexible than any other language of its day; in fact, it is still a better design than most languages of today, twenty-five years later. Lisp freed ITS's hackers to think in unusual and creative ways. It was a major factor in their successes, and remains one of hackerdom's favorite languages."
- Eric Raymond, in "Open Sources: Voices from the Open Source Revolution", 1999

"I suppose I should learn Lisp, but it seems so foreign."
- Paul Graham, Nov 1983

"The only way to learn a new programming language is by writing programs in it."
- Kernighan and Ritchie

"Most languages in computer science describe how their author learned what someone else already developed."
- unknown

"It is better to look for semplicity, clarity and correctness and to make programs efficient only if really needed."
- unknown


====================
 BIBLIOGRAFIA / WEB
====================

  Documentazione ufficiale:
  http://www.newLISP.org/index.cgi?Documentation

  Tutorial "Introduction to newLISP" su WikiBooks:
  http://en.wikibooks.org/wiki/Introduction_to_newLISP

  "newLISP in 21 minutes" di John W. Small
  http://www.newlisp.org/newLISP_in_21_minutes.html

  Forum ufficiale di newLISP
  http://www.newLISPfanclub.alh.net/forum/

  "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015

  Informazioni sui numeri Floating Point:
  https://floating-point-gui.de
  http://pages.cs.wisc.edu/~david/courses/cs552/S12/handouts/goldberg-floating-point.pdf

  "Numerical Computing with IEEE Floating Point Arithmetic", Michael Overton

  "Handbook of Floating-Point Arithmetic" AA.VV.

  Articoli su newLISP:
  "Crawler Tractor" di Kazimir Majorinc
  http://kazimirmajorinc.com/Documents/Crawler-tractor/index.html

  "newLISP - Lisp for the masses" di Krzysztof Kliś
  https://weblambdazero.blogspot.com/2010/06/newLISP-lisp-for-masses.html

  "Advanced Recursion in newLISP" di Krzysztof Kliś
  https://weblambdazero.blogspot.com/2010/07/advanced-recursion-in-newLISP.html

  Computer e Matematica:
  https://www.nayuki.io

  Mathematica on-line:
  https://www.wolframalpha.com

  Enciclopedia on-line delle sequenze dei numeri interi:
  https://oeis.org

  StackOverflow è una sito web in cui studenti e professionisti inviano richieste e rispondono a domande sulla programmazione:
  https://stackoverflow.com

  Enciclopedia libera:
  https://www.wikipedia.org/