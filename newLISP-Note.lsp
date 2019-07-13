============================================================================

+=================+
| Note su newLISP |
| by cameyo 2019  |
+=================+

========

 INDICE

========

newLISP IN GENERALE
  Introduzione
  Installazione
  Eseguire newLISP
  Le funzioni utente
  Argomenti di una funzione
  Trasformare una funzione distruttiva in non-distruttiva
  Trasformare una funzione da due a n argomenti
  Applicare una funzione ad ogni sottolista di una lista
  Assegnazione globale: set, setq e setf (e define)
  Assegnazione locale: let, letn e local
  Effetti collaterali (side effect) di setq e let e local
  Passaggio per valore e passaggio per riferimento
  Nil, true e lista vuota '()
  La funzione quote e il simbolo '
  Funzioni con memoria
  Generare funzioni da funzioni
  Tipi di numeri
  Punto decimale o virgola decimale
  Formattazione dell'output
  Operazioni aritmetiche elementari
  Incremento/decremento di variabili
  Uso dei numeri big integer
  Introspezione
  Conversioni di tipo: implicite ed esplicite
  Quanto sono precisi i numeri floating point?
  Quanto sono strani i numeri floating-point?
  Tipi di errore
  Propagazione degli errori
  Rappresentazione dei numeri floating point (32-bit)
  Machine epsilon
  Infinito e not a number
  Confronto tra numeri floating-point
  Verifica delle operazioni floating-point
  Una strana successione
  Operazioni sicure
  Quanto vale pi greco?
  Quanto vale il numero di eulero?
  Tempo di esecuzione
  Lista o vettore?
  Vettori
  Indicizzazione di stringhe, liste e vettori
  Attraversamento di liste e vettori
  Attraversamento di stringhe
  Uscita anticipata da funzioni, cicli e blocchi
  Lavorare con file di dati (file i/o)
  Ambito (scope) dinamico e lessicale
  Contesti
  Uso dei moduli
    La variabile di ambiente newLISPdir
    Il file di inizializzazione init.lsp
    Esempi sull'utilizzo dei moduli
  Hash-Map e dizionari
  CAR e CDR in newLISP

FUNZIONI VARIE
  Tabella ASCII
  Pari o dispari
  Crono
  Cambiare di segno ad un numero
  Moltiplicazione solo con addizioni
  Divisione solo con sottrazioni
  Distanza tra due punti
  Conversione decimale <--> binario
  Conversione decimale <--> esadecimale
  Conversione numero intero <--> lista
  Numeri casuali in un intervallo
  Calcolo proporzione
  Estrarre l'elemento n-esimo da una lista
  Verificare se una lista è palindroma
  Verificare se una stringa è palindroma
  Zippare due liste
  Sostituire gli elementi di una lista con un determinato valore
  Raggruppare gli elementi di una lista
  Enumerare gli elementi di una lista
  Creare una stringa come ripetizione di un carattere/stringa
  Massimo annidamento di una lista ("s-espressione")
  Run Length Encode di una lista
  Run Length Decode di una lista
  Massimo Comun Divisore e Minimo Comune Multiplo
  Funzioni booleane
  Estrazione dei bit di un numero
  Conversione gradi decimali <--> gradi sessagesimali
  Conversione RGB <--> HSV
  Calcolo della media di n numeri
  Istogramma
  Stampare una matrice
  Retta passante per due punti
  Coordinate dei punti di una funzione
  Leggere e stampare un file di testo
  Criptazione e decriptazione di un file
  Funzioni per input utente
  Emettere un beep
  Disabilitare l'output delle espressioni
  Trasformare una lista di stringhe in lista di simboli
  Simboli creati dall'utente
  Il programma è in esecuzione ? (progress display)
  Ispezionare una cella newLISP
  Informazioni sul sistema (sys-info)
  Valutazione di elementi di una lista

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
  N-99-16 Eliminare gli elementi da una lista per ogni k
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
  N-99-27 Raggruppare gli elementi di un insieme in sottoinsiemi disgiunti (no)
  N-99-28 Ordinare una lista in base alla lunghezza delle sottoliste

ROSETTA CODE
  FizzBuzz
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
  Problema dello zaino (Knapsack)
  Giorno della settimana
  Triangolo di Pascal
  Codice Morse
  Problema di Babbage
  Cifrario di Cesare
  Cifrario di Vigenere
  Anagrammi
  Numeri primi cuban
  Data di Pasqua

PROJECT EULERO
  Problemi 1..50

PROBLEMI VARI
  BubbleSort
  QuickSort
  Simulare una matrice con un vettore
  Implementare una pila (stack) con un vettore
  Implementare una coda (queue) con un vettore
  Coda circolare (Ring Buffer)
  Fattoriale
  Coefficiente binomiale
  Lancio di dadi
  Quadrati magici
  Quadrati magici 3x3
  Mastermind numerico
  Algoritmo babilonese sqrt(x)
  Radice quadrata intera di un numero intero (2^64 bit)
  Ricerca binaria (Binary search)
  Frazione generatrice
  Il numero aureo
  Equazione di secondo grado
  Equazione di terzo grado
  Sistemi lineari
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
  The Game of Pig
  Il gioco dei salti
  Ricerca stringa in un testo (algoritmo base)
  Ricerca stringa in un testo (algoritmo Z)
  Distanza di Levenshtein
  Social Network
  Skyline
  Knuth-shuffle
  Bussola e direzioni
  Puzzle (a b c + a b c + a b c = c c c)
  Numero mancante
  Somma massima di una sottolista (Algoritmo Kadane)
  Prodotto massimo di una sottolista
  Problema delle N-Regine
  Somma delle cifre di un numero
  Coppia di punti
  Moltiplicazione tra numeri interi (stringhe)
  Numeri pandigitali
  Somma dei divisori propri di un numero
  Labirinti (calcolo percorsi)
  Moltiplicazioni di fattori
  Problemi patologici dei numeri floating point

DOMANDE PER ASSUNZIONE DI PROGRAMMATORI (CODING INTERVIEW QUESTIONS)
  Notazione Big O
  Contare i bit di un numero (McAfee)
  Scambiare il valore di due variabili (McAfee)
  Funzione "atoi" (McAfee)
  Somma di numeri in una lista (Google)
  Aggiornamento di una lista (Uber)
  Ricerca numero su una lista (Stripe)
  Decodifica di un messaggio (Facebook)
  Implementazione di un job-scheduler (Apple)
  Massimo raccoglitore d'acqua (LeetCode)
  Quantità d'acqua in un bacino (Facebook)
  Sposta gli zeri (Facebook)
  Intersezione di segmenti (byte-by-byte)
  Trovare l'elemento mancante (LeetCode)
  Verifica lista/sottolista (Visa)
  Controllo ordinamento lista (Visa)
  Caramelle (Visa)
  Unire due liste ordinate (Facebook)
  Salire le scale (Amazon)
  Numeri interi con segni opposti (MacAfee)
  Parità di un numero (McAfee)
  Minimo e massimo di due numeri (McAfee)
  Numero potenza di due (Google)
  Stanze e riunioni (Snapchat)
  Bilanciamento parentesi (Facebook)
  K punti più vicini - K Nearest points (LinkedIn)
  Ordinamento Colori (LeetCode)
  Unione di intervalli (Google)

LIBRERIE
  Operazioni con i numeri complessi
  Operazioni con le frazioni
  Operazioni con i tempi
  Operazioni con gli insiemi
  Funzioni winapi

APPENDICI
  Lista delle funzioni newLISP
  Sul linguaggio newLISP - FAQ (Lutz Mueller)
  F-expression - FEXPR
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
  Valutazione delle espressioni, Indicizzazione Implicita, Contesti e Funtori di Default (Lutz Mueller)
  Gestione Automatica della Memoria in newLISP (Lutz Mueller)
  Frasi Famose sulla Programmazione e sul Linguaggio Lisp

BIBLIOGRAFIA / WEB

============================================================================

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

In questo capitolo definiremo alcune funzioni che operano sulle liste e altre funzioni di carattere generale. Alcune di queste ci serviranno successivamente per risolvere i problemi che andremo ad affrontare.
Poichè newLISP permette sia lo stile funzionale che quello imperativo, le funzioni sono implementate in modo personale e possono essere sicuramente migliorate.

-------------
Tabella ASCII
-------------

ASCII (acronimo di American Standard Code for Information Interchange, Codice Standard Americano per lo Scambio di Informazioni) è un codice per la codifica di caratteri. Lo standard ASCII è stato pubblicato dall'American National Standards Institute (ANSI) nel 1968. Il codice era composto originariamente da 7 bit (2^7 = 128 caratteri).
I caratteri del codice ASCII sono di due tipi: stampabili e non stampabili (caratteri di controllo).
I caratteri stampabili sono 95 (da 32 a 126), mentre quelli non stampabili sono 33 (da 0 a 31 e il 127). Quindi il totale dei caratteri vale 95 + 33 = 128.
Scriviamo una funzione che crea una lista dei caratteri ASCII stmapabili.

(define (asciiTable)
  (let (out '())
    (for (i 32 126)
      (push (list i (char i)) out -1)
    )
    out
  )
)

(asciiTable)
;-> ((32 " ")  (33 "!")  (34 "\"") (35 "#")  (36 "$")  (37 "%")  (38 "&")
;->  (39 "'")  (40 "(")  (41 ")")  (42 "*")  (43 "+")  (44 ",")  (45 "-")
;->  (46 ".")  (47 "/")  (48 "0")  (49 "1")  (50 "2")  (51 "3")  (52 "4")
;->  (53 "5")  (54 "6")  (55 "7")  (56 "8")  (57 "9")  (58 ":")  (59 ";")
;->  (60 "<")  (61 "=")  (62 ">")  (63 "?")  (64 "@")  (65 "A")  (66 "B")
;->  (67 "C")  (68 "D")  (69 "E")  (70 "F")  (71 "G")  (72 "H")  (73 "I")
;->  (74 "J")  (75 "K")  (76 "L")  (77 "M")  (78 "N")  (79 "O")  (80 "P")
;->  (81 "Q")  (82 "R")  (83 "S")  (84 "T")  (85 "U")  (86 "V")  (87 "W")
;->  (88 "X")  (89 "Y")  (90 "Z")  (91 "[")  (92 "\\") (93 "]")  (94 "^")
;->  (95 "_")  (96 "`")  (97 "a")  (98 "b")  (99 "c")  (100 "d") (101 "e")
;->  (102 "f") (103 "g") (104 "h") (105 "i") (106 "j") (107 "k") (108 "l")
;->  (109 "m") (110 "n") (111 "o") (112 "p") (113 "q") (114 "r") (115 "s")
;->  (116 "t") (117 "u") (118 "v") (119 "w") (120 "x") (121 "y") (122 "z")
;->  (123 "{") (124 "|") (125 "}") (126 "~"))

In newLISP i caratteri numero 34 (doppi apici) e numero 92 (backslash) sono preceduti dal carattere di controllo '\' quando vengono stampati.


--------------
Pari o dispari
--------------

Definiamo le funzioni "pari" e "dispari":

(define (pari n) (if (= n 0) true (dispari (- n 1))))

(define (dispari n) (if (= n 0) nil (pari (- n 1))))

(pari 5)
;-> nil
(pari 0)
;-> true
(dispari 0)
;-> nil
(dispari 5)
;-> true

Altro metodo (più veloce) per definire le funzioni "pari " e "dispari":

(define (pari n) (if (= (% n 2) 0) true nil))

(define (dispari n) (if (= (% n 2) 0) nil true))


-----
Crono
-----

Definiamo una funzione che prende un numero come argomento e costruisce una lista con tutti i numeri dall'argomento fino a 1 in ordine decrescente:

(define (crono n)
  (if (<= n 0)
      '()
      (cons n (crono (- n 1)))
  )
)

; Nota: '() rappresenta la lista vuota

(crono 10)
;-> (10 9 8 7 6 5 4 3 2 1)


------------------------------
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

Terzo metodo (bitwise not "~") (valido solo per numeri interi)
(setq n -10)
;-> -10
(setq n (add (~ n) 1))
;-> 10
(setq n (add (~ n) 1))
;-> -10

Test terzo metodo:
(time (map (lambda (x) (add (~ n) 1)) (sequence 1 1000000)) 10)
;-> 1207.781

Questo metodo è più lento.

Quarto metodo (segno meno "-")
(setq n -10)
;-> 10
(setq n (- n))
;-> 10
(setq n (- n))
;-> -10

Test quarto metodo:
(time (map (lambda (x) (- n)) (sequence 1 1000000)) 10)
;-> 914.067

Stessa velocità dei primi due metodi, ma quest'ultimo è più leggibile.


----------------------------------
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

------------------------------
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


----------------------
Distanza tra due punti
----------------------

P1 = (x1, y1)
P2 = (x2, y2)

Distanza al quadrato (piano cartesiano):

(define (dist2 x1 y1 x2 y2)
  (add (mul (sub x1 x2) (sub x1 x2))
       (mul (sub y1 y2) (sub y1 y2)))
)

Distanza (piano cartesiano):

(define (dist x1 y1 x2 y2)
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2))))
)

Distanza griglia manhattan (4 movimenti - esempio: torre):

(define (distM4 x1 y1 x2 y2)
  (add (abs (sub x1 x2)) (abs (sub y1 y2)))
)

Distanza griglia manhattan (8 movimenti - esempio: regina):

(define (distM8 x1 y1 x2 y2)
  (max (abs (sub x1 x2)) (abs (sub y1 y2)))
)

(dist 1 2 5 5)
;-> 5
(distM4 1 2 5 5)
;-> 7
(distM8 1 2 5 5)
;-> 4


---------------------------------
Conversione decimale <--> binario
---------------------------------

Questa funzione converte un numero decimale in un numero binario (lista):

(define (decimale2binario n)
  (reverse (d2b n)))

(define (d2b n)
  (if (zero? n) '(0)
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
;-> (0)

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


-------------------------------------
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
      ; Ponendo val prima del numero 16 forza newLISP a considerare big integer
      ; il risultato dell'operazione di moltiplicazione.
      ;(setq val (+ (* 16 val) (find (char c) digit)))
      ; Comunque usando 16L al posto di 16 tutto funziona:
      ;(setq val (+ (* 16L val) (find (char c) digit)))
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


------------------------------------
Conversione numero intero <--> lista
------------------------------------

Da numero intero a lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

(int2list 1234567890)
;-> (1 2 3 4 5 6 7 8 9 0)

(define (int2list2 n)
  (map int (explode (string n))))

(int2list2 1234567890)
;-> (1 2 3 4 5 6 7 8 9 0)

Vediamo quale delle due è più veloce:

(time (int2list 9223372036854775807) 100000)
;-> 332.671

(time (int2list2 9223372036854775807) 100000)
;-> 442.561

Da lista a numero intero:

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

(list2int '(1 2 3 4 5 6 7 8 9 0))
;-> 1234567890

(define (list2int2 lst)
  (int (join (map string lst))))

(list2int2 '(1 2 3 4 5 6 7 8 9 0))
;-> 1234567890

Vediamo quale delle due è più veloce:

(time (list2int '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 622.365

(time (list2int2 '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 855.138


-------------------------------
Numeri casuali in un intervallo
-------------------------------

Generare un numero casuale n tale che: a <= n <= b

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1)))
)

(rand-range 1 10)
;-> 1

Facciamo un test sulla distribuzione dei risultati:

(define (test n a b)
  (local (vec r)
    (setq vec (array 10 '(0)))
    (for (i 0 n)
      (setq r (rand-range a b))
      (++ (vec r))
    )
    vec
  )
)

(test 100000 1 5)
;-> (0 19828 20179 20076 20263 19655 0 0 0 0)

(test 100000 0 9)
;-> (9855 9809 9951 10199 9978 10006 9934 10110 10058 10101)


-------------------
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


----------------------------------------
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


------------------------------------
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


--------------------------------------
Verificare se una stringa è palindroma
--------------------------------------

(define (palindroma? str)
  (= str (reverse (copy str))))

(palindroma? "ababa")
;-> true

Vediamo una soluzione con gli indici:

(define (palindroma? str)
  (catch
    (local (start end)
      (setq start 0)
      (setq end (- (length str) 1))
        (while (< start end)
          (if (!= (str start) (str end)) (throw nil))
          (++ start)
          (-- end)
        )
      true
    );local
  );catch
)

(palindroma? "epresalaserpe")
;-> true

(palindroma? "abbai")
;-> nil


---------------
Zippare N liste
---------------

La funzione "zip" prende due liste e raggruppa in coppie gli elementi delle due liste che hanno lo stesso indice.
Il risultato è una lista costituita da sottoliste con due elementi ciascuna.La lunghezza della lista è uguale a quella della lista più corta (cioè, la funzione deve fermarsi quando termina una delle due liste).

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


--------------------------------------------------------------
Sostituire gli elementi di una lista con un determinato valore
--------------------------------------------------------------

Si tratta di sostituire tutti gli elementi di una lista con un determinato valore con un altro valore.

La funzione è la seguente:

(define (sostituisci x y lst)
    (if (null? lst) '()
      (if (= x (first lst))
        (cons y (sostituisci x y (rest lst)))
        (cons (first lst) (sostituisci x y (rest lst)))
      )
    )
)

(sostituisci 'd 'K '(a b c d 1 2 3 d))
;-> (a b c K 1 2 3 K)

Per rimpiazzare tutti gli elementi di una lista che hanno un determinato valore possiamo utilizzare la funzione built-in "replace":

(setq lst '(a b c d 1 2 3 d))
(replace 'd lst 'K)
;-> (a b c K 1 2 3 K)

(setq lst '((a b) (c d) (1 2 (3 d))))
(replace '(c d) lst 'K)
;-> ((a b) K (1 2 (3 d)))

Purtroppo "replace" non funziona quando vogliamo modificare un atomo che si trova all'interno di una lista nidificata:

(setq lst '((a b) (c d) (1 2 (3 d))))
(replace 'd lst 'K)
;-> ((a b) (c d) (1 2 (3 d)))

In questo caso dobbiamo utilizzare la funzione "set-ref-all":

(setq lst '((a b) (c d) (1 2 (3 d))))
(set-ref-all 'd lst 'K)
;-> ((a b) K (1 2 (3 K)))


-------------------------------------
Raggruppare gli elementi di una lista
-------------------------------------

La funzione "raggruppa" utilizza la ricorsione, prima raggruppiamo la prima parte della lista (presa con la funzione "take"), poi richiamiamo la stessa funzione "raggruppa" sulla lista rimanente (presa con la funzione "drop").

La funzione "take" restituisce i primi n elementi di una lista:

(define (take n lst) (slice lst 0 n))

La funzione "drop" restituisce tutti gli elementi di una lista tranne i primi n (cioè vengono esclusi dalla lista risultante i primi n elementi della lista passata:

(define (drop n lst) (slice lst n))

Adesso possiamo scrivere la funzione "raggruppa":

(define (raggruppa n lst)
   (if (null? lst) '()
      (cons (take n lst) (raggruppa n (drop n lst)))
   )
)

(setq lst '(0 1 2 3 4 5 6 7 8 9))
(raggruppa 2 lst)
;-> ((0 1) (2 3) (4 5) (6 7) (8 9))
(raggruppa 3 lst)
;-> ((0 1 2) (3 4 5) (6 7 8) (9))

(setq lst '(1 2 3 4 5 6 7 8 9 10 11 12))
(raggruppa 2 (raggruppa 2 lst))
;-> (((1 2) (3 4)) ((5 6) (7 8)) ((9 10) (11 12)))


-----------------------------------
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

(map (fn (x) (list $idx x)) '((a b) (c d) e))
;-> ((0 a) (1 b) (2 c))


-----------------------------------------------------------
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


--------------------------------------------------
Massimo annidamento di una lista ("s-espressione")
--------------------------------------------------

La seguente funzione calcola il livello massimo di annidamento di una lista:

(define (annidamento lst)
  (cond ((null? lst) 0)
        ((atom? lst) 0)
        (true (max (+ 1 (annidamento (first lst)))
                   (annidamento (rest lst))))
  )
)

Il trucco sta nell'utilizzare la funzione "max" per scoprire quale ramo della ricorsione è il più profondo, notando che ogni volta che ricorraimo su first aggiungiamo un altro livello.

(annidamento '())
;-> 0
(annidamento '(a b))
;-> 1
(annidamento '((a)))
;-> 2
(annidamento '(a (b) ((c)) d e f))
;-> 3
(annidamento '(a (((b c d))) (e) ((f)) g))
;-> 4
(annidamento '(a (((b c (d)))) (e) ((f)) g))
;-> 5

rickyboy:

(define (nesting lst)
  (if (null? lst) 0
      (atom? lst) 0
      (+ 1 (apply max (map nesting lst)))))

fdb:

(define (nesting lst prev (t 0))
   (if (= lst prev)
      t
     (nesting (flat lst 1) lst (inc t))))

(nesting '(a (((b c (d)))) (e) ((f)) g))
;-> 5


-------------------------------
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
                  (begin (push (list conta palo) out -1)
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           (push (list conta palo) out -1)
          )
    )
    out
  )
)

(rle-encode '(a a a a b c c a a d e e e e f))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f))


------------------------------
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


-----------------------------------------------
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


-----------------
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


-------------------------------
Estrazione dei bit di un numero
-------------------------------

; Restituisce il bit n-esimo del numero intero positivo x
; indice zero
(define (bit n x)
    (if (< x 0) (setq x (sub 0 x))) ; solo numeri positivi
    (& (>> x (- n 1)) 1)
)

(bits 123)
;-> 1111011

(bit 1 123) ;-> 1
(bit 2 123) ;-> 1
(bit 3 123) ;-> 0
(bit 4 123) ;-> 1
(bit 5 123) ;-> 1
(bit 6 123) ;-> 1
(bit 7 123) ;-> 1


---------------------------------------------------
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


------------------------
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


-------------------------------
Calcolo della media di n numeri
-------------------------------

; =====================================================
; (media lst) oppure (media x1 x2 ... xn)
; Calcola la media di n numeri
; =====================================================

(define (media)
  (if (or (= (args) '()) (= (args) '(()) )) nil
    (if (= (length (args)) 1) ;controlla se args è una lista o una serie di numeri
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

(media '(1 2 3 4 5 6 7 8 9))
;-> 5

(media (sequence 1 9999))
;-> 5000

(setq lst '(1 2 3 4 5 6))
(media lst)
;-> 3.5


----------
Istogramma
----------

Data una lista disegnare l'istogramma dei valori.
Deve essere possibile passare un parametro che indica che la lista passata non è una lista di frequenze, ma una lista di valori: in tal taso occorre calcolare la lista delle frequenze prima di disegnare l'istogramma.

Le seguenti espressioni creano una lista di valori con 1000 elementi ("res"):

(setq res '())
(for (i 0 999)
  (push (rand 11) res -1)
)
(length res)

Le seguenti espressioni creano la lista delle frquenzze della lista "res":

(setq f (array 11 '(0)))
(dolist (el res)
  (println el)
  (++ (f (- el 1)))
)

f
;-> (80 98 86 83 86 99 90 106 80 84 108)

La seguente funzione disegna l'istogramma, se il parametro "calc" vale true, allora calcola la lista delle frequenze dalla lista passata:

(define (istogramma lst hmax (calc nil))
  (local (linee hm scala f-lst)
    (if calc
      ;calcolo la lista delle frequenze partendo da lst
      (begin
        ;trovo quanti numeri diversi ci sono nella lista
        (setq unici (length (unique lst)))
        ;creo la lista delle frequenze
        (setq f-lst (array unici '(0)))
        ; calcolo dei valori delle frequenze
        (dolist (el lst)
          (++ (f-lst (- el 1)))
        )
      )
      ;else
      ;lst è la lista delle frequenze
      (begin (setq f-lst lst))
    )
    (setq hm (apply max f-lst))
    (setq scala (div hm hmax))
    (setq linee (map (fn (x) (round (div x scala))) f-lst))
    (dolist (el linee)
      ;(println (format "%3d %s %0.2f" (add $idx 1) (dup "*" el) (f-lst $idx)))
      (println (format "%3d %s %4d" $idx (dup "*" el) (f-lst $idx)))
    )
  );local
)

(istogramma f 20)
;->   0 ***************   80
;->   1 ******************   98
;->   2 ****************   86
;->   3 ***************   83
;->   4 ****************   86
;->   5 ******************   99
;->   6 *****************   90
;->   7 ********************  106
;->   8 ***************   80
;->   9 ****************   84
;->  10 ********************  108

(istogramma res 20 true)
;->   0 ***************   80
;->   1 ******************   98
;->   2 ****************   86
;->   3 ***************   83
;->   4 ****************   86
;->   5 ******************   99
;->   6 *****************   90
;->   7 ********************  106
;->   8 ***************   80
;->   9 ****************   84
;->  10 ********************  108


--------------------
Stampare una matrice
--------------------

(define (print-matrix matrix)
  (local (row col nmax nmin digit fmtstr)
    ; converto matrice in lista ?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice (da rivedere)
    (setq col (length (first matrix)))
    ; valore massimo
    (setq nmax (string (apply max (flat matrix))))
    ; valore minimo
    (setq nmin (string (apply min (flat matrix))))
    ; calcolo spazio per i numeri
    (setq digit (add 1 (max (length nmax) (length nmin))))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "d"))
    ; stampa
    (for (i 0 (sub row 1))
      (for (j 0 (sub col 1))
        (print (format fmtstr (matrix i j)))
      )
      (println)
    )
  )
)


----------------------------
Retta passante per due punti
----------------------------

(define (retta2p x1 y1 x2 y2)
  (local (m q)
    (cond ((zero? (sub x1 x2))
              (setq m (div 1 0))
              (setq q 0)
          )
          ((zero? (sub y1 y2))
              (setq m 0)
              (setq q y1)
          )
          (true
              (setq m (div (sub y1 y2) (sub x1 x2)))
              (setq q (sub y1 (mul m x1)))
          )
    )
    (list m q)
  )
)

(retta2p 2 -3 3 -1)
;-> (2 -7)

(retta2p 2 2 3 3)
;-> (1 0)

;retta verticale
(retta2p 2 4 2 3)
;-> (1.#INF 0)

;retta orizzontale
(retta2p 1 4 2 4)
;-> (0 4)


------------------------------------
Coordinate dei punti di una funzione
------------------------------------

Supponiamo di avere la seguente funzione e di voler ottenere una serie di coordinate (x,y):

y = f(x) = (3*x^2 - 4*x + 6)

Definiamo la funzione:

(define (fx x) (add (mul 3 (mul x x)) (- (mul 4 x)) 6))

Vogliamo calcolare 5 coppie di coordinate con x che va da 10 a 20.

Prima generiamo i valori delle x:

(setq l (sequence 10 20 2))
;-> (10 12 14 16 18 20)

Poi generiamo i valori delle y:

(setq k (map fx l))
;-> (266 390 538 710 906 1126)

Poi uniamo le due liste:

(transpose (list l k))
;-> ((10 266) (12 390) (14 538) (16 710) (18 906) (20 1126))

Possiamo scrivere una funzione che restituisce le coppie di coordinate:

(define (coordFX funzione xi xf passo)
  (local (lstX lstY)
    (setq lstX (sequence xi xf passo))
    (setq lstY (map funzione lstX))
    (transpose (list lstX lstY))
  )
)

(coordFX fx 10 20 2)
;-> ((10 266) (12 390) (14 538) (16 710) (18 906) (20 1126))

Definiamo la funzionde quadrato:

(define (gx x) (mul x x))

(coordFX gx 1 10 1)
;-> ((1 1) (2 4) (3 9) (4 16) (5 25) (6 36) (7 49) (8 64) (9 81) (10 100))


-----------------------------------
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


--------------------------------------
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


-------------------------
Funzioni per input utente
-------------------------

*********************
>>>funzione READ-KEY
*********************
sintassi: (read-key)

Legge un tasto dalla tastiera e restituisce un valore intero. Per i tasti di navigazione, è necessario effettuare più di una chiamata read-key. Per i tasti che rappresentano i caratteri ASCII, il valore di ritorno è lo stesso su tutti i Sistemi Operativi, ad eccezione dei tasti di navigazione e di altre sequenze di controllo come i tasti funzione, nel qual caso i valori di ritorno possono variare in base ai diversi SO e alle configurazioni.

(read-key)  → 97  ; after hitting the A key
(read-key)  → 65  ; after hitting the shifted A key
(read-key)  → 10  ; after hitting [enter] on Linux
(read-key)  → 13  ; after hitting [enter] on Windows

(while (!= (set 'c (read-key)) 1) (println c))

L'ultimo esempio può essere utilizzato per verificare le sequenze di ritorno dalla navigazione e dai tasti funzione. Per interrompere il ciclo, premere Ctrl-A.

Nota che read-key funziona solo quando newLISP è in esecuzione in una shell Unix o nella shell dei comandi di Windows. Non funziona nelle gui Java newLISP-GS e Tcl/Tk newLISP-Tk. Non funziona neanche nelle shared library newwLISP di UNIX o nella DLL newLISP di Windows (Dynamic Link Library).

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


----------------
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


---------------------------------------
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


-----------------------------------------------------
Trasformare una lista di stringhe in lista di simboli
-----------------------------------------------------

(setq str "Questa è la stringa da convertire")
;-> "Questa è la stringa da convertire"

(setq lst (parse str))
;-> ("Questa" "è" "la" "stringa" "da" "convertire")

(map sym lst)
;-> (Questa è la stringa da convertire)


--------------------------
Simboli creati dall'utente
--------------------------

Per vedere quali simboli crea la nostra funzione possiamo utilizzare il seguente procedimento:
1) lanciare una nuova REPL
2) impostare i simboli attuali su una variabile:
   (setq prima (symbols))
3) Lanciare la funzione
4) impostare i nuovi simboli su una variabile:
   (setq dopo (symbols))
5) Effettuare la differenza tra le due variabili:
   (difference dopo prima)

Esempio:
1) lancio una nuova REPL
2) creo una lista con i simboli attuali:
  (setq prima (symbols))
3) Scrivo la funzione:
  (define (doppio x) (mul x x))
4) creo una lista con i nuovi simboli:
  (setq dopo (symbols))
5) calcolo la differenza tra le due liste di simboli:
  (difference dopo prima)
;-> (dopo doppio x)

La seguente funzione restituisce una lista con due sottoliste, la prima sottolista contiene i nomi delle funzioni definite dall'utente (lambda), mentra la seconda sottolista contiene tutti gli altri simboli definiti dall'utente.

Definite la seguente funzione in una nuova sessione di newLISP (una nuova REPL) e poi eseguitela:

(define (user-symbols)
  (local (func other)
    (setq func '())
    (setq other '())
    (dolist (el (symbols))
      (if (lambda? (eval el))  (push el func -1))
      (if (and (not (lambda? (eval el)))
               (not (primitive? (eval el)))
               (not (protected? el))
               (not (global? el)))
          (push el other -1))
    )
    (list func other)
  )
)

(user-symbols)
;-> ((module user-symbols) (el func other))


-------------------------------------------------
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


-----------------------------
Ispezionare una cella newLISP
-----------------------------

Per conoscere il contenuto (tipo) di una cella lisp possiamo utilizzare la funzione "dump".

****************
>>>funzione DUMP
****************
sintassi: (dump [exp])

Mostra i contenuti binari di una nuova cella LISP. Senza argomenti, questa funzione restituisce un elenco di tutte le celle Lisp. Quando viene fornito exp, viene valutato e il contenuto della cella Lisp viene restituito in una lista.

(dump 'a)
;-> (9586996 5 9578692 9578692 9759280)

(dump 999)
;-> (9586996 130 9578692 9578692 999)

L'elenco contiene i seguenti indirizzi di memoria e informazioni:

offset  descrizione
0       indirizzo di memoria della cella Lisp
1       cella->tipo: maggiore/minore, vedi newLISP.h per i dettagli
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

Vedere il file newLISP.h nel programma sorgente per conoscere i bit superiori e il loro significato (e anche altre cose).

Un altro metodo simile:

(define types '("nil" "true" "int" "float" "string" "symbol" "context"
    "primitive" "import" "ffi" "quote" "expression" "lambda" "fexpr" "array"
    "dyn_symbol"))

(define (typeof v)
    (types (& 0xf ((dump v) 1))))


-----------------------------------
Informazioni sul sistema (sys-info)
-----------------------------------

Possiamo ottenere diverse informazioni sul sistema in uso utilizzando la funzione "sys-info".

********************
>>>funzione SYS-INFO
********************
sintassi: (sys-info [int-idx])

Chiamando sys-info senza int-idx viene restituito un elenco di informazioni sulle risorse. Dieci valori interi che hanno il seguente significato:

valore descrizione
  0     Numero di celle Lisp
  1     Numero massimo di celle Lisp (costante)
  2     Numero di simboli
  3     Livello di valutazione / ricorsione dell'ambiente
  4     Livello di stack dell'ambiente
  5     Numero massimo di chiamate allo stack (costante)
  6     Pid del processo genitore oppure 0
  7     Pid del processo newLISP
  8     Numero della versione come costante intera
  9     Costanti del sistema operativo:
        linux = 1, bsd = 2, osx = 3, solaris = 4, windows = 6, os/2 = 7, cygwin = 8, tru64 unix = 9, aix = 10, android = 11
        il bit 11 è impostato per le versioni ffilib (Extended Import / Callback API) (aggiungere 1024)
        il bit 10 è impostato per le versioni IPv6 (aggiungere 512)
        il bit  9 è impostato per le versioni a 64 bit (modificabili a runtime) (aggiungere 256)
        il bit  8 è impostato per le versioni UTF-8 (aggiungere 128)
        il bit  7 è aggiunto per le versioni di libreria (aggiungere 64)

I numeri da 0 a 9 indicano il valore l'indice int-idx (opzionale) nella lista restituita.

Si consiglia di utilizzare gli indici da 0 a 5 (includendo) "Numero massimo di chiamate allo stack costante") e utilizzare gli offset negativi da -1 a -4 per accedere alle ultime quattro voci nella lista delle informazioni di sistema. Le future nuove voci verranno inserite dopo l'indice 5. In questo modo i programmi scritti precedentemente non dovranno essere modificati.

Quando si usa int-idx, verrà restituito un solo elemento della lista.

(sys-info) → (429 268435456 402 1 0 2048 0 19453 10406 ​​1155)
(sys-info 3) → 1
(sys-info -2) → 10406 ​​;; versione 10.4.6

Il numero relativo al massimo di celle Lisp può essere modificato tramite l'opzione della riga di comando -m. Per ogni megabyte di memoria di celle Lisp, è possibile allocare 64k celle Lisp. La profondità massima dello stack di chiamata può essere modificata utilizzando l'opzione della riga di comando -s.

(bits (sys-info -1))
;-> "10110000110"
1 --> ffilib ON
0 --> IPv6 OFF
1 --> 64bit ON
1 --> UTF-8 ON
0 --> library OFF
0 --> (free)
0 --> (free)
0110 --> 6 = windows

Per rendere più leggibili le informazioni scriviamo la funzione "sysinfo":

(define (sysinfo)
  (local (info num num$ so)
    (setq info (sys-info))
    (println "Number of Lisp cells: " (info 0))
    (println "Maximum number of Lisp cells constant: " (info 1))
    (println "Number of symbols: " (info 2))
    (println "Evaluation/recursion level: " (info 3))
    (println "Environment stack level: " (info 4))
    (println "Maximum call stack constant: " (info 5))
    (println "Pid of the parent process or 0: " (info -4))
    (println "Pid of running newLISP process: " (info -3))
    (println "Version number as an integer constant: " (info -2))
    (setq num (sys-info -1))
    (setq num$ (bits num))
    (setq so (int (slice num$ (- (length num$) 4)) 0 2))
    (print "Operating System: ")
    (case so
        (1  (println "linux"))
        (2  (println "bsd"))
        (3  (println "osx"))
        (4  (println "solaris"))
        (5  (println "nil"))
        (6  (println "windows"))
        (7  (println "os/2"))
        (8  (println "cygwin"))
        (9  (println "tru64 unix"))
        (10 (println "aix"))
        (11 (println "android"))
        (true (println so))
    );case
    ; ffilib -> bit 11
    (print "ffilib: ")
    (if (zero? (& (>> num 10) 1)) (println "no") (println "yes"))
    ; IPV6 -> bit 10
    (print "IPV6: ")
    (if (zero? (& (>> num 9) 1)) (println "no") (println "yes"))
    ; 64 bit -> bit 9
    (print "64 bit: ")
    (if (zero? (& (>> num 8) 1)) (println "no") (println "yes"))
    ; library -> bit 8
    (print "UTF-8: ")
    (if (zero? (& (>> num 7) 1)) (println "no") (println "yes"))
    ; library -> bit 6
    (print "library: ")
    (if (zero? (& (>> num 6) 1)) (println "no") (println "yes"))
    info
  )
)

(sysinfo)
;-> Number of Lisp cells: 983
;-> Maximum number of Lisp cells constant: 576460752303423488
;-> Number of symbols: 425
;-> Evaluation/recursion level: 4
;-> Environment stack level: 1
;-> Maximum call stack constant: 2048
;-> Pid of the parent process or 0: 0
;-> Pid of running newLISP process: 6884
;-> Version number as an integer constant: 10705
;-> Operating System: windows
;-> ffilib: yes
;-> IPV6: no
;-> 64 bit: yes
;-> UTF-8: yes
;-> library: no
;-> (959 576460752303423488 425 2 0 2048 0 6884 10705 1414)


------------------------------------
Valutazione di elementi di una lista
------------------------------------

Supponiamo di aver creato la seguente lista:

(setq lst '( ((+ 6 2) (a) 2) ((- 2 5) (b) 5) ))
;-> (((+ 6 2) (a) 2) ((- 2 5) (b) 5))

La lista ha due elementi ((+ 6 2) (a) 2) e ((- 2 5) (b) 5).

Adesso vogliamo valutare il primo elemento di ogni sottolista: (+ 6 2) e (- 2 5).

Aggiorniamo questo elemento con la sua valutazione:

(dolist (el lst) (setf (first (lst $idx)) (eval (first el))))

Vediamo il risultato:

lst
;-> ((8 (a) 2) (-3 (b) 5))


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
N-99-16 Eliminare gli elementi da una lista per ogni k
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

Prima definizione (ordine lessicografico):

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

Seconda definizione:

(define (insert l n e)
  (if (= 0 n)
      (cons e l)
      (cons (first l)
            (insert (rest l) (- n 1) e))))

(define (seq start end)
  (if (= start end)
      (list end)
      (cons start (seq (+ start 1) end))))

(define (permute l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n) (insert p n (first l))) (seq 0 (length p))))
                         (permute (rest l))))))

(permute '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))

Usiamo la funzione di sistema "sequence" al posto della funzione utente "seq":

(define (insert lst n e)
  (if (= 0 n)
      (cons e lst)
      (cons (first lst)
            (insert (rest lst) (- n 1) e))))

(define (permutations l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n) (insert p n (first l))) (sequence 0 (length p))))
                         (permutations (rest l))))))

(permutations '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))

(time (length (permutazioni '(0 1 2 3 4 5 6 7 8 9))))
;-> 45412.572

(time (length (permute '(0 1 2 3 4 5 6 7 8 9))))
;-> 13398.311

(time (length (permutations '(0 1 2 3 4 5 6 7 8 9))))
;-> 18024.311 ; Strano: "sequence" è più lenta di "seq".

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

FIZZBUZZ
--------

Scrivere un programma che stampa i numeri interi da 1 a 100 (inclusi).
Ma:
- per multipli di tre, stampa Fizz (invece del numero)
- per multipli di cinque, stampa Buzz (invece del numero)
- per multipli di entrambi tre e cinque, stampa FizzBuzz (invece del numero)

(define (fizzbuzz)
  (for (i 1 100)
    (cond ((= 0 (% i 15)) (println "FizzBuzz"))
          ((= 0 (% i 3))  (println "Fizz"))
          ((= 0 (% i 5))  (println "Buzz"))
          (true           (println i))
    )
  )
)

(fizzbuzz)

Vediamo ora una generalizzazione del problema. Occorre scrivere una funzione che accetta una lista di fattori e una lista di parole associate. Un ulteriore parametro permette di specificare il numero massimo da stampare.
Come esempio possiamo usiare la seguente lista associativa:

(3 "Fizz")
(5 "Buzz")
(7 "Baxx")

Nel caso in cui un numero sia un multiplo di almeno due fattori, stampare ciascuna delle parole associate a tali fattori nell'ordine dal fattore minore a quello maggiore. Ad esempio, il numero 15 è un multiplo di entrambi 3 e 5, allora stampa FizzBuzz. Se il numero massimo vale 105, occorre stampare FizzBuzzBaxx perché è un multiplo di 3, 5 e 7.

(setq lst '((3 "Fizz") (5 "Buzz") (7 "Baxx")))

(define (fizzbuzzG n lst)
  (local (out)
    (for (i 1 n)
      (setq out "")
      (dolist (el lst)
        (if (= 0 (% i (first el))) (setq out (append out (last el))))
      )
      (if (= out "") (setq out (string i)))
      (print out {, })
    )
  )
)

(fizzbuzzG 20 lst)
;-> 1, 2, Fizz, 4, Buzz, Fizz, Baxx, 8, Fizz, Buzz, 11,
;-> Fizz, 13, Baxx, FizzBuzz, 16, 17, Fizz, 19, Buzz

(setq lst '((2 "Fizz") (3 "Buzz") (5 "Baxx")))

(fizzbuzzG 30 lst)
;-> 1, Fizz, Buzz, Fizz, Baxx, FizzBuzz, 7, Fizz, Buzz, FizzBaxx, 11,
;-> FizzBuzz, 13, Fizz, BuzzBaxx, Fizz, 17, FizzBuzz, 19, FizzBaxx, Buzz,
;-> Fizz, 23, FizzBuzz, Baxx, Fizz, Buzz, Fizz, 29, FizzBuzzBaxx


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

Ci sono miglioramenti sostanziali tra "primo-a?" e "primo-b?", comunque entrambe sono circa 10 volte più veloci della funzione "primo?".

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

Attenzione: la funzione è molto lenta con numeri grandi.

(fattori-primi 9223372036854775809L)
;-> (3L 3L 3L 19L 43L 5419L 77158673929L)

(apply * '(3L 3L 3L 19L 43L 5419L 77158673929L))
;-> 9223372036854775809L

(time (fattori-primi 9223372036854775809L))
;-> 551342.497 ; 9 minuti e 11 secondi


NUMERI DI SMITH
---------------

I numeri di Smith sono numeri in cui la somma delle cifre decimali che compongono il numero è uguale alla somma delle cifre decimali dei suoi fattori primi escluso 1.
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
Si noti che una divisione risultante in una parte costituita esclusivamente da 0 non è valida, poiché 0 non è considerato positivo.
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

   primoriale (0) = 1 (per definizione)
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
(setq a (explode (string 3435)))
;-> ("3" "4" "3" "5")
(setq b (map int a))
;-> (3 4 3 5)
(apply + (map (lambda (x) (nth x powers)) b))
;-> 3435

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
;-> 1814539.27 ; millisecondi (circa 30 minuti)


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


PROBLEMA DELLO ZAINO (KNAPSACK)
-------------------------------

Il problema dello zaino, detto anche problema di Knapsack, è un problema di ottimizzazione combinatoria definito nel modo seguente:
Dato uno zaino che può supportare determinato peso e dati N oggetti, ognuno dei quali caratterizzato da un peso e un valore, il problema si propone di scegliere quali di questi oggetti mettere nello zaino per ottenere il maggiore valore senza eccedere il peso sostenibile dallo zaino stesso.
In maniera formale la formulazione del problema diventa:
- ognuno degli N oggetti possiede un peso p(i) e un valore v(i)
- il valore W indica il peso massimo sopportabile dallo zaino;
- la possibilità che un oggetto venga inserito o meno nello zaino è espressa dalle variabili intere x(i)
La funzione obiettivo è:

max Z = Sum(ci*xi) (per i=1..N)

Con i vincoli:

W <= Sum(wi*xi) (per i=1..N)

Si indichino con w{i} il peso dell'i-esimo oggetto e con c{i} il suo valore. Si vuole massimizzare il valore totale rispettando il vincolo che il peso totale sia minore o uguale al peso massimo consentito W. Definiamo A(i,j) come il massimo valore che può essere trasportato con uno zaino di capacità j <= W avendo a disposizione solo i primi "i" oggetti.

Si può definire A(i,j) ricorsivamente come segue:

A(0,j) = 0
A(i,0) = 0
A(i,j) = A(i-1,j) se w(i) > j
A(i,j) = max[A(i-1,j), A(i-1,j-w(i)) + c(i)] se w(i) <= j.}

Cerchiamo di risolvere il problema con la forza bruta: calcolo tutte le combinazioni di oggetti con il relativo valore e poi scelgo quella combinazione che ha il valore maggiore (potrebbero esserci più di una combinazione con valore massimo).
I dati sono rappresentati da una lista i cui elementi hanno la seguente struttura:

(nome peso valore)

Supponiamo che la lista iniziale sia la seguente:

(setq k '((a 2 3) (b 3 4) (c 4 5) (d 5 6)))
;-> ((a 2 3) (b 3 4) (c 4 5) (d 5 6))

Definizmo tre funzioni che estraggono le liste dei noni, dei pesi e dei valori:

(define (getNomi lst) (map (fn(x) (first x)) lst))
(define (getPesi lst) (map (fn(x) (first (rest x))) lst))
(define (getValori lst) (map (fn(x) (last x)) lst))

(setq nomi (getNomi k))
;-> (a b c d)
(setq pesi (getPesi k))
;-> (2 3 4 5)
(setq valori (getValori k))
;-> (3 4 5 6)

Questa è la funzione per generare le combinazioni:

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(combinazioni 2 '(3 4 5 6))
;-> ((3 4) (3 5) (3 6) (4 5) (4 6) (5 6))

Dobbiamo generare le combinazioni (dei valori) relative a tutte le possibili liste (quindi quelle di qualunque lunghezza):

(setq allv '())
(for (i 1 (length valori))
  (extend allv (combinazioni i valori))
)
;-> ((3) (4) (5) (6) (3 4) (3 5) (3 6) (4 5) (4 6) (5 6) (3 4 5) (3 4 6) (3 5 6)
;->  (4 5 6) (3 4 5 6))

Notare che il numero di combinazioni da cansiderare vale (2^elementi + 1).
Ad esempio con 22 elementi dobbiamo considerare (pow 2 22) = 4194304 combinazioni.

Adesso dobbiamo calcolare la somma dei valori di ogni sottolista (peso):

(setq sumv (map (fn (x) (apply + x)) allv))
;-> (3 4 5 6 7 8 9 9 10 11 12 13 14 15 18)

Cerchiamo il valore massimo
(setq valmax (apply max sumvOK))
;-> 10

Adesso dobbiamo eliminare tutti i valori che sono superiori al peso massimo W:
(setq W 10)

(setq sumvOK (map (fn(x) (if (> x W) 0 x)) sumv))
;-> (3 4 5 6 7 8 9 9 10 0 0 0 0 0 0)

Troviamo gli indici dei valori che hanno valore massimo (10):
(setq sol-idx (flat (ref-all 10 sumvOK)))
;-> (8)

Adesso cerchiamo i valori che concorrono a creare il valore massimo:
(setq val-max '())
(dolist (el sol-idx)
  (push (allv el) val-max -1)
)
;-> ((4 6))

Troviamo gli indici degli elementi che hanno valore 4 e 6:

(setq ele-idx '())
(dolist (el val-max)
  (setq item '())
  (dolist (x el)
    (setq vv (ref x valori))
    (push (list (nomi vv) (valori vv)) item -1)
  )
  (push item ele-idx -1)
)
;-> (((b 4) (d 6)))

Finalmente abbiamo trovato la soluzione.

Come abbiamo anticipato, si può trovare la soluzione calcolando A(n,W). Per farlo in modo efficiente si può usare una tabella che memorizzi i calcoli fatti precedentemente (memoization o programmazione dinamica). Questa soluzione impiegherà quindi un tempo proporzionale a O(nW)} e uno spazio anch'esso proporzionale a O(nW).

(define (knapsack C items)
  (define (getNomi lst) (map (fn(x) (first x)) lst))
  (define (getPesi lst) (map (fn(x) (first (rest x))) lst))
  (define (getValori lst) (map (fn(x) (last x)) lst))
  (local (table x name weight val cp n nome peso valore)
    ;creazione i vettori dei dati
    (setq n (length items))
    (setq name (getNomi items))
    (setq weight (getPesi items))
    (setq val (getValori items))
    (setq table (array (add n 1) (add C 1) '(0)))
    ;(for (i 0 (sub n 1)) (setf (table i 0) 0))
    ;(for (j 0 (sub n 1)) (setf (table 0 j) 0))
    (for (i 1 n)
      (for (cp 1 C)
        (if (<= (weight (sub i 1)) cp)
            (begin
              ;(println (weight (sub i 1)) { } (val (sub i 1)))
              (setq x (sub cp (weight (sub i 1))))
              (setf (table i cp) (max (add (val (sub i 1)) (table (sub i 1) x))
                                      (table (sub i 1) cp)))
            )
        ;else
            (begin
              (setf (table i cp)  (table (sub i 1) cp))
            )
        )
      )
    )
    ;(println (table n C))
    ; Selezione elementi della soluzione
    (setq res '())
    (setq cp C)
    (setq ptot 0)
    (setq vtot 0)
    (for (i n 1 -1)
      (setq aggiunto (!= (table i cp) (table (sub i 1) cp)))
      (if aggiunto
        (begin
           (setq nome (name (sub i 1)))
           (setq peso (weight (sub i 1)))
           (setq valore (val (sub i 1)))
           (push (list nome peso valore) res)
           (setq ptot (add ptot peso))
           (setq vtot (add vtot valore))
           (setq cp (sub cp peso))
        )
      )
    )
    (println "Valore: " vtot { } "Peso: " ptot)
    res
  )
)

(setq item '((maps 9 150)
             (compass 13 35)
             (water 153 200)
             (sandwich 50 160)
             (glucose 15 60)
             (tin 68 45)
             (banana 27 60)
             (apple 39 40)
             (cheese 23 30)
             (beer 52 10)
             (suntan-cream 11 70)
             (camera 32 30)
             (T-shirt 24 15)
             (trousers 48 10)
             (umbrella 73 40)
             (waterproof-trousers 42 70)
             (waterproof-overclothes 43 75)
             (note-case 22 80)
             (sunglasses 7 20)
             (towel 18 12)
             (socks 4 50)
             (book 30 10)
            )
)

(knapsack 400 items)
;-> Valore: 1030 Peso: 396
;-> ((maps 9 150) (compass 13 35) (water 153 200) (sandwich 50 160) (glucose 15 60)
;->  (banana 27 60) (suntan-cream 11 70) (waterproof-trousers 42 70) (waterproof-overclothes 43 75)
;->  (note-case 22 80) (sunglasses 7 20) (socks 4 50))


GIORNO DELLA SETTIMANA
----------------------

Dato anno, mese e giorno, determinare il giorno della settimana.
Esistono diversi algoritmi per risolvere questo problema.

La prima funzione utilizza la regola di Zeller per calcolare il giorno della settimana nel calendario gregoriano prolettico (Domenica = 0)

(define (dayZ year month day)
  (local (adjust mm yy d)
    (setq adjust (/ (- 14 month) 12))
    (setq mm (+ month (* 12 adjust) (- 2)))
    (setq yy (- year adjust))
    (setq d (% (+ day (/ (- (* 13 mm) 1) 5) yy (/ yy 4) (- (/ yy 100)) (/ yy 400)) 7))
  )
)

(dayZ 2019 6 2)
;-> 0

La seconda funzione usa l'algoritmo di Gauss per determinare il giorno della settimana.
Questo metodo vale per il calendario gregoriano.
La funzione seguente è presa dal sito di newLISP (Lutz Mueller).

(define (dayG year month day) ; 0..6 --> Domenica..Sabato
    (letn ( d day
            m (+ (% (- month 3) 12) 1)
            Y (if (> m 10) (- year 1) year)
            y (% Y 100)
            c (/ (- Y y) 100)
            w (add d (floor (sub (mul 2.6 m) 0.2)) y (floor (div y 4)) (floor (div c 4)) (- (mul c 2)))
            w (% w 7)
          )
       (if (< w 0) (inc w 7) w))
)

(dayG 2019 6 2)
;-> 0

La terza funzione usa l'algoritmo di Tomohiko Sakamoto. Anche questo metodo vale per il calendario gregoriano.

Vediamo come funziona l'algoritmo.
Il 1 gennaio dell'anno 1 D.C. è un lunedì nel calendario gregoriano.
Prendiamo in considerazione il primo caso in cui non abbiamo anni bisestili, quindi il numero totale di giorni in ogni anno è 365. Gennaio ha 31 giorni cioè 7*4+3 giorni, quindi il giorno del 1° febbraio sarà sempre 3 giorni prima della giornata del 1° gennaio. Ora febbraio ha 28 giorni (esclusi gli anni bisestili) che è il multiplo esatto di 7 (7 * 4 = 28) Quindi non ci saranno cambiamenti nel mese di marzo e sarà anche 3 giorni prima del giorno del 1° gennaio dell'anno rispettivo. Considerando questo modello, se creiamo un vettore del numero iniziale di giorni per ogni mese, avremo: t = (0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5).
Ora diamo un'occhiata al caso reale quando ci sono anni bisestili. Ogni 4 anni, il nostro calcolo guadagnerà un giorno in più. Tranne ogni 100 anni quando non lo guadagna. Tranne ogni 400 anni quando lo guadagna. Come inseriamo questi giorni aggiuntivi? Basta aggiungere y / 4 - y / 100 + y / 400. Si noti che tutta la divisione è una divisione intera. Questo aggiunge esattamente il numero richiesto di giorni bisestili. Ma qui c'è un problema, il giorno bisestile è il 29 febbraio e non il 0 gennaio. Ciò significa che l'anno corrente non deve essere conteggiato per il calcolo del giorno bisestile per i primi due mesi. Supponiamo che se il mese fosse gennaio o febbraio, abbiamo sottratto 1 dall'anno. Ciò significa che durante questi mesi, il valore y/4 sarà quello dell'anno precedente e non verrà conteggiato. Se sottraiamo 1 dai valori t[] di ogni mese dopo febbraio? Ciò riempirebbe il vuoto e il problema degli anni bisestili verrà risolto. In altre parole, dobbiamo apportare le seguenti modifiche:
1. t[] diventa (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4).
2. se m corrisponde a Gen/Feb (ovvero, i mesi < 3) diminuiamo y di 1.
3. l'incremento annuo all'interno del modulo è ora y + y/4 - y/100 + y/400 al posto di y.

Adesso possiamo scrivere la funzione:

(define (dayT year month day) ; 0..6 --> Domenica..Sabato
  (local (t d)
    (setq t '(0 3 2 5 0 3 5 1 4 6 2 4))
    (if (< month 3) (-- year))
    (setq d (% (add year (/ year 4) (/ (- year) 100) (/ year 400) (t (- month 1)) day) 7))
  )
)

(dayT 2019 6 2)
;-> 0

(dayZ 2017 7 13) ;-> 4
(dayG 2017 7 13) ;-> 4
(dayT 2017 7 13) ;-> 4

(dayZ 2012 8 15) ;-> 3
(dayG 2012 8 15) ;-> 3
(dayT 2012 8 15) ;-> 3

(dayZ 2456 12 24) ;-> 0
(dayG 2456 12 24) ;-> 0
(dayT 2456 12 24) ;-> 0


TRIANGOLO DI PASCAL
-------------------

Il triangolo di Pascal (o di Tartaglia) è una matrice triangolare formata dai coefficienti binomiali (ossia dai coefficienti dello sviluppo del binomio (a + b) elevato ad una qualsiasi potenza n - Esempio: (a + b)^2 = 1*a^2 + 2*a*b + 1*b^2).

Ecco un triangolo con 9 linee, in cui le righe e le colonne sono state numerate (a base zero):

         colonne
         0  1  2  3  4  5  6  7  8
righe
    0    1  0  0  0  0  0  0  0  0
    1    1  1  0  0  0  0  0  0  0
    2    1  2  1  0  0  0  0  0  0
    3    1  3  3  1  0  0  0  0  0
    4    1  4  6  4  1  0  0  0  0
    5    1  5 10 10  5  1  0  0  0
    6    1  6 15 20 15  6  1  0  0
    7    1  7 21 35 35 21  7  1  0
    8    1  8 28 56 70 56 28  8  1

dove ogni elemento della matrice vale: matrice[riga][colonna] = binomiale[n, k]

Tutte le righe iniziano e terminano con il numero 1.

Ogni riga ha un elemento in più rispetto al suo predecessore.

Definiamo una funzione che calcola il triangolo di Pascal utilizzando i coeffiecienti binomiali.
La prima funzione permette di calcolare il coefficiente binomiale di n,k.

(define (binomiale n k)
  (local (M q)
    (setq M (array (+ n 1) (+ k 1) '(0)))
    (for (i 0 n)
      (setq q (min i k))
      (for (j 0 q)
        (if (or (= j 0) (= j i))
          (setq (M i j) 1)
          (setq (M i j) (+ (M (- i 1) (- j 1)) (M (- i 1) j)))
        )
      )
    )
    (M n k)
  );local
)

(binomiale 5 0)
;-> 1
(binomiale 5 3)
;-> 10

Poi definiamo la funzione che crea il triangolo di Pascal:

(define (pascal n)
  (local (P)
    (setq P (array n n '(0)))
    (for (riga 0 (- n 1))
      (for (i 0 riga)
        (setf (P riga i) (binomiale riga i))
      )
    )
    ; disabilitare la seguente istruzione per calcolare la velocità
    (print-matrix P)
  )
)

Definiamo la funzione che stampa la matrice:

(define (print-matrix matrix)
  (local (row col nmax nmin digit fmtstr)
    ; converto matrice in lista ?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice (da rivedere)
    (setq col (length (first matrix)))
    ; valore massimo
    (setq nmax (string (apply max (flat matrix))))
    ; valore minimo
    (setq nmin (string (apply min (flat matrix))))
    ; calcolo spazio per i numeri
    (setq digit (add 1 (max (length nmax) (length nmin))))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "d"))
    ; stampa
    (for (i 0 (sub row 1))
      (for (j 0 (sub col 1))
        (print (format fmtstr (matrix i j)))
      )
      (println)
    )
  )
)

(pascal 9)
;-> 1  0  0  0  0  0  0  0  0
;-> 1  1  0  0  0  0  0  0  0
;-> 1  2  1  0  0  0  0  0  0
;-> 1  3  3  1  0  0  0  0  0
;-> 1  4  6  4  1  0  0  0  0
;-> 1  5 10 10  5  1  0  0  0
;-> 1  6 15 20 15  6  1  0  0
;-> 1  7 21 35 35 21  7  1  0
;-> 1  8 28 56 70 56 28  8  1

Il matematico tedesco Stifel ha scoperto che gli elementi del triangolo di Pascal hanno la seguente proprietà (nota come Relazione di Stifel):

Se col = 0 o row = col,
  P(row,col) = 1

Se row >= col,
  P(row,col) = P(row-1,col) + P(row-1,col-1)

dove (row >= 0) e (col >= 0)

Quindi possiamo definire una nuova funzione per calcolare il triangolo di Pascal utilizzando la relazione di Stifel:

(define (pascalS n)
  (local (P)
    (setq P (array n n '(0L)))
    (for (row 0 (- n 1))
      (for (col 0 row)
        (if (or (= col 0) (= row col))
            (setf (P row col) 1L)
            (setf (P row col) (+ (bigint (P (- row 1) col)) (bigint  (P (- row 1) (- col 1)))))
        )
      )
    )
    ; disabilitare la seguente istruzione per calcolare la velocità
    (print-matrix P)
  );local
)

(pascalS 9)
;-> 1  0  0  0  0  0  0  0  0
;-> 1  1  0  0  0  0  0  0  0
;-> 1  2  1  0  0  0  0  0  0
;-> 1  3  3  1  0  0  0  0  0
;-> 1  4  6  4  1  0  0  0  0
;-> 1  5 10 10  5  1  0  0  0
;-> 1  6 15 20 15  6  1  0  0
;-> 1  7 21 35 35 21  7  1  0
;-> 1  8 28 56 70 56 28  8  1

(pascalS 14)
;-> 1    0    0    0    0    0    0    0    0    0    0    0    0    0
;-> 1    1    0    0    0    0    0    0    0    0    0    0    0    0
;-> 1    2    1    0    0    0    0    0    0    0    0    0    0    0
;-> 1    3    3    1    0    0    0    0    0    0    0    0    0    0
;-> 1    4    6    4    1    0    0    0    0    0    0    0    0    0
;-> 1    5   10   10    5    1    0    0    0    0    0    0    0    0
;-> 1    6   15   20   15    6    1    0    0    0    0    0    0    0
;-> 1    7   21   35   35   21    7    1    0    0    0    0    0    0
;-> 1    8   28   56   70   56   28    8    1    0    0    0    0    0
;-> 1    9   36   84  126  126   84   36    9    1    0    0    0    0
;-> 1   10   45  120  210  252  210  120   45   10    1    0    0    0
;-> 1   11   55  165  330  462  462  330  165   55   11    1    0    0
;-> 1   12   66  220  495  792  924  792  495  220   66   12    1    0
;-> 1   13   78  286  715 1287 1716 1716 1287  715  286   78   13    1

Per vedere quale funzione è più veloce commentiamo nelle due funzioni la riga che contiene l'istruzione per stampare la matrice:

; (print-matrix P)


(time (pascal 30) 100)
;-> 2914.029

(time (pascalS 30) 100)
;-> 34.966

La seconda funzione è velocissima perchè non calcola tutti i coefficienti binomiali, ma riempie la matrice ricorsivamente con una relazione matematica.

Per finire vediamo come calcolare la riga n-esima del triangolo di Pascal (valida anche per i big integer):

(define (pascaln n)
  (local (out)
    (setq out '(1L))
    (for (k 0 (- n 1))
      (push (/ (* (out k) (- n k)) (+ k 1)) out -1)
    )
    out
  )
)

(pascaln 9)
;-> (1L 9L 36L 84L 126L 126L 84L 36L 9L 1L)

(pascaln 20)
;-> (1L 20L 190L 1140L 4845L 15504L 38760L 77520L 125970L 167960L 184756L 167960L 125970L
;->  77520L 38760L 15504L 4845L 1140L 190L 20L 1L)

Questa funzione sfrutta la seguente identità matemetica sulle combinazioni:

C(n, k+1) = C(n,k) * (n-k) / (k+1)

Quindi iniziamo con C(n, 0) = 1 e poi calcoliamo il resto della riga usando questa identità, cioè moltiplichiamo ogni volta l'elemento precedente per (n-k)/(k+1).
Ricordiamo che il coefficiente binomiale rappresenta il numero di scelte di k elementi tra quelli di un insieme di n elementi (numero di combinazioni semplici).


CODICE MORSE
------------

Il codice Morse è un metodo per trasmettere informazioni, utilizzando sequenze standardizzate di brevi e lunghi segni o impulsi, comunemente noti come punti e linee ("dot and dashes"), per le lettere, i numeri e i caratteri speciali di un messaggio.
Originariamente creato per il telegrafo elettrico di Samuel Morse verso la metà del 1830, fu anche ampiamente utilizzato per le prime comunicazioni radio a partire dal 1890.

Rappresentazione del codice

A  • −         N  − •         0  − − − − −     .  • − • − • −
B  − • • •     O  − − −       1  • − − − −     ,  − − • • − −
C  − • − •     P  • − − •     2  • • − − −     :  − − − • • •
D  − • •       Q  − − • −     3  • • • − −     ?  • • − − • •
E  •           R  • − •       4  • • • • −     =  − • • • −
F  • • − •     S  • • •       5  • • • • •     -  − • • • • −
G  − − •       T  −           6  − • • • •     (  − • − − •
H  • • • •     U  • • −       7  − − • • •     )  − • − − • −
I  • •         V  • • • −     8  − − − • •     {"}  • − • • − •
J  • − − −     W  • − −       9  − − − − •     '  • − − − − •
K  − • −       X  − • • −                      /  − • • − •
L  • − • •     Y  − • − −                      @  • − − • − •
M  − −         Z  − − • •                      !  − • − • − −
                                               " "  "       "

Il codice Morse internazionale è composto da 5 elementi:

1) Impulso breve, punto (dot o "dit"): "dot duration" vale una unità di tempo
2) Impulso lungo, linea (dash o "dah"): "dash duration" vale tre unità di tempo
3) Intervallo di divisione tra dot e dash di un carattere: vale una unità di tempo
4) Intervallo breve (tra le lettere): vale tre unità di tempo
5) Intervallo lungo (tra le parole): vale sette unità di tempo

Il codice Morse viene trasmesso come un codice digitale usando solo due stati (acceso e spento). Il codice Morse può essere rappresentato come un codice binario: 1 acceso e 0 spento. Quindi una sequenza di codice Morse è costituita da una combinazione delle seguenti cinque stringhe di bit:

1) Impulso breve, punto (dot o "dit"): "dot duration" 1
2) Impulso lungo, linea (dash o "dah"): "dash duration" 111
3) Intervallo di divisione tra dot e dash di un carattere: 0
4) Intervallo breve (tra le lettere): 000
5) Intervallo lungo (tra le parole): 0000000

Notare che gli impulsi e gli intervalli (zeri) sono alternati: punti e linee sono sempre separati da uno degli intervalli vuoti e che gli intervalli sono sempre separati da un punto o da una linea.

In termini di spazio invece che di tempo, abbiamo:

1) Un punto (dot) occupa uno spazio "."
2) Una linea (dash) occupa 3 spazi "---"
3) Le parti di ogni lettera sono separate da uno spazio " "
4) Tra due lettere intercorrono 3 spazi. "   "
5) Tra due parole intercorrono 7 spazi.  "       "

Per scrivere le funzioni di conversione abbiamo bisogno di creare due liste di associazione:

; Lista di associazione carattere --> codice morse
(setq alfa-morse '(
("A"  ". -")
("B"  "- . . .")
("C"  "- . - .")
("D"  "- . .")
("E"  ".")
("F"  ". . - .")
("G"  "- - .")
("H"  ". . . .")
("I"  ". .")
("J"  ". - - -")
("K"  "- . -")
("L"  ". - . .")
("M"  "- -")
("N"  "- .")
("O"  "- - -")
("P"  ". - - .")
("Q"  "- - . -")
("R"  ". - .")
("S"  ". . .")
("T"  "-")
("U"  ". . -")
("V"  ". . . -")
("W"  ". - -")
("X"  "- . . -")
("Y"  "- . - -")
("Z"  "- - . .")
("0"  "- - - - -")
("1"  ". - - - -")
("2"  ". . - - -")
("3"  ". . . - -")
("4"  ". . . . -")
("5"  ". . . . .")
("6"  "- . . . .")
("7"  "- - . . .")
("8"  "- - - . .")
("9"  "- - - - .")
("."  ". - . - . -")
(","  "- - . . - -")
(":"  "- - - . . .")
("?"  ". . - - . .")
("="  "- . . . -")
("-"  "- . . . . -")
("("  "- . - - .")
(")"  "- . - - . -")
("\""  ". - . . - .")
("'"  ". - - - - .")
("/"  "- . . - .")
("@"  ". - - . - .")
("!"  "- . - . - -")
(" "  "       ")))

Sottolineato  ". . - - . -"

; Lista di associazione codice morse --> carattere
(setq morse-alfa (map (fn (n) (list (last n) (first n))) alfa-morse))

(lookup "A" alfa-morse)
;-> ". -"
(lookup "−" morse-alfa)
;-> "T"

Adesso possiamo scrivere la funzione che converte un messaggio di testo in una lista di codici morse:

(define (morse2alfa msg)
  (let (out '())
    (dolist (ch (explode msg))
      (if (lookup ch alfa-morse)
          (push (lookup ch alfa-morse) out -1)
          (push "$$$" out -1)
          ;(print (lookup ch alfa-morse){   })
          ;(print "$$$"{   })
      )
    )
    out
  )
)

(setq msg "Testo da tradurre.")
; conversione del messaggio in lettere maiuscole
(setq msg (upper-case msg))

(morse2alfa msg)
;-> ("-" "." ". . ." "-" "- - -" "       " "- . ." ". -" "       " "-" ". - ." ". -"
;->  "- . ." ". . -" ". - ." ". - ." "." ". - . - . -")

Definiamo la funzione inversa che converta da una lista di codici morse ad una lista di caratteri:

(define (alfa2morse msg)
  (let (out '())
    (dolist (ch msg)
      (if (lookup ch morse-alfa)
          (push (lookup ch morse-alfa) out -1)
          (push "$$$" out -1)
      )
    )
    out
  )
)

(join (alfa2morse (morse2alfa msg)))
;-> "TESTO DA TRADURRE."


PROBLEMA DI BABBAGE
-------------------

Qual è il più piccolo intero positivo il cui quadrato termina con le cifre 269.696?
Lettera di Charles Babbage a Lord Bowden, 1837.

Notiamo che solo i numeri che terminano con 4 o 6 posoono produrre un quadrato che ha il numero 6 come ultima cifra.

Inoltre risulta:

(sqrt 269696)
;-> 519.3226357477594

quindi qualsiasi numero inferiore a 520 produce un quadrato più piccolo di 269.696.
Allora, il numero più piccolo da provare vale 574.

(define (babbage)
  (catch
    (local (num quadrato)
      (setq num 524)
      (setq quadrato (* num num))
      (while true
        ; eleva il numero al quadrato
        (setq quadrato (* num num))
        ; controlla se è il numero cercato
        (if (= (slice (string quadrato) -6 6) "269696")
          ; numero trovato
          (throw (list num quadrato))
        )
        ; aumenta in numero di 2
        ; adesso il numero termina con la cifra 6
        (setq num (+ num 2))
        ; eleva il numero al quadrato
        (setq quadrato (* num num))
        ; controlla se è il numero cercato
        (if (= (slice (string quadrato) -6 6) "269696")
          ; numero trovato
          (throw (list num quadrato))
        )
        ; aumenta in numero di 8
        ; adesso il numero termina con la cifra 4
        (setq num (+ num 8))
      );while
    );local
  );catch
)

(babbage)
;-> (25264 638269696)

(time (babbage))
;-> 15.627


CIFRARIO DI CESARE
------------------

Il cifrario di Cesare è uno dei più antichi algoritmi crittografici conosciuti. È un cifrario a sostituzione monoalfabetica in cui ogni lettera del messaggio in chiaro è sostituita nel messaggio cifrato dalla lettera che si trova un certo numero di posizioni dopo (o prima) nell'alfabeto. La sostituzione avviene lettera per lettera, analizzando il testo dall'inizio alla fine.
Il cifrario prende il nome da Giulio Cesare, che lo utilizzava per proteggere i suoi messaggi segreti. Cesare utilizzava in genere una chiave di 3 per il cifrario. A quel tempo il metodo era sicuro perché la maggior parte della gente spesso non era neanche in grado di leggere.

Definiamo il nostro alfabeto:
(setq alfa (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

Definiamo l'alfabeto di partenza:
(setq s1 alfa)
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

Definiamo l'alfabeto di arrivo (con chiave 3):
(setq s2 (rotate (copy alfa) -3))
;-> ("D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "A" "B" "C")

Creiamo la lista di associazione tra le lettere in chiaro e le lettere cifrate:

(setq codice (transpose (list s1 s2)))
;-> (("A" "D") ("B" "E") ("C" "F") ("D" "G") ("E" "H") ("F" "I") ("G" "J")
;->  ("H" "K") ("I" "L") ("J" "M") ("K" "N") ("L" "O") ("M" "P") ("N" "Q")
;->  ("O" "R") ("P" "S") ("Q" "T") ("R" "U") ("S" "V") ("T" "W") ("U" "X")
;->  ("V" "Y") ("W" "Z") ("X" "A") ("Y" "B") ("Z" "C"))

Creiamo la lista di associazione tra le lettere cifrate e le lettere in chiaro:

(setq anticodice (transpose (list s2 s1)))
;-> (("D" "A") ("E" "B") ("F" "C") ("G" "D") ("H" "E") ("I" "F") ("J" "G")
;->  ("K" "H") ("L" "I") ("M" "J") ("N" "K") ("O" "L") ("P" "M") ("Q" "N")
;->  ("R" "O") ("S" "P") ("T" "Q") ("U" "R") ("V" "S") ("W" "T") ("X" "U")
;->  ("Y" "V") ("Z" "W") ("A" "X") ("B" "Y") ("C" "Z"))

Funzione di conversione da chiaro a cirato:

(define (chiaro-cifrato msg)
  (let (out '())
    (dolist (ch (explode (upper-case msg)))
      (if (lookup ch codice)
          (push (lookup ch codice) out -1)
          (push "$" out -1)
      )
    )
    (join out)
  )
)

(setq msg "Testo da tradurre")

(chiaro-cifrato msg)
;-> "WHVWR$GD$WUDGXUUH"

Funzione di conversione da cifrato a chiaro:

(define (cifrato-chiaro msg)
  (let (out '())
    (dolist (ch (explode (upper-case msg)))
      (if (lookup ch anticodice)
          (push (lookup ch anticodice) out -1)
          (push "$" out -1)
      )
    )
    (join out)
  )
)

(cifrato-chiaro "WHVWR$GD$WUDGXUUH")
;-> "TESTO$DA$TRADURRE"

Scriviamo una funzione generica che codifica e decodifica ed ha come parametro la chiave (numero):

(define (cesare msg tipo key)
  (local (s1 s2 codice anticodice)
    (setq out '())
    (setq s1 (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
    (setq s2 (rotate (copy s1) (- key)))
    (setq codice (transpose (list s1 s2)))
    (setq anticodice (transpose (list s2 s1)))
    (cond ((= tipo 0)
           (dolist (ch (explode (upper-case msg)))
              (if (lookup ch codice)
                  (push (lookup ch codice) out -1)
                  (push "$" out -1)
              )
           ))
          ((= tipo 1)
           (dolist (ch (explode (upper-case msg)))
              (if (lookup ch anticodice)
                  (push (lookup ch anticodice) out -1)
                  (push "$" out -1)
              )
           ))
          (true (println "tipo: 0 -> cifra, 1 -> decifra"))
    );cond
    (join out)
  ); local
)

(cesare "TESTO DA TRADURRE" 0 3)
;-> "WHVWR$GD$WUDGXUUH"

(cesare "WHVWR$GD$WUDGXUUH" 1 3)
;-> "TESTO$DA$TRADURRE"

(cesare "newLISP is great" 0 6)
;-> "TKCROYV$OY$MXKGZ"

(cesare "TKCROYV$OY$MXKGZ" 1 6)
;-> "newLISP$IS$GREAT"

(cesare "newLISP is great" 2 6)
;-> tipo: 0 -> cifra, 1 -> decifra


CIFRARIO DI VIGENERE
--------------------

Il cifrario di Vigenère è il più semplice dei cifrari polialfabetici. Il metodo è una generalizzazione del cifrario di Cesare: invece di spostare la lettera da cifrare di un numero fisso di posti, questa viene spostata di un numero di posti variabile, determinato in base ad una parola chiave, che deve essere conosciuta sia dal mittente che dal destinatario. La chiave (detta anche "verme") deve essere ripetuta per tutta la lunghezza del messaggio.
Per esempio:

Testo in chiaro: RICERCARETESORO
Verme          : VERMEVERMEVERMEVE
Testo cifrato  : MMTQVXEIQXZWFDS

Il testo cifrato si ottiene spostando la lettera chiara di un numero fisso di caratteri, pari al numero ordinale della lettera corrispondente del verme. Di fatto si esegue una somma aritmetica tra l'ordinale dei caratteri in chiaro (A = 0, B = 1, C = 2...) e quello del verme. Superando l'ultima lettera, Z, si ricomincia dalla A, secondo la logica delle aritmetiche modulari.

Il vantaggio rispetto ai cifrari monoalfabetici (come il cifrario di Cesare) è dovuto al fatto che il testo è cifrato con n alfabeti cifranti. In questo modo, la stessa lettera viene cifrata (se ripetuta consecutivamente) n volte e questo rende più complessa la crittoanalisi del testo.

Possiamo usare una funzione matematica per la cifratura e la decifratura:

L = Lunghezza del cifrario = Numero caratteri alfabeto (26)

Numero prima lettera del cifrario "A" = 0

Numero ultima lettera del cifrario "Z" = 25

a = Numero della lettera della parola in Chiaro (0-25)

b = Numero della lettera della parola Chiave/Verme (0-25)

c = Numero della lettera della parola Cifrata (0-25)

Formula per cifrare/criptare: n = a + b (mod L)

Formula per decifrare/decriptare: n = c - b + L

r = floor(n / L)

x = n - ( L * r ) = Numero della lettera della parola in Chiaro/Cifrata (0-25)

La funzione si basa sulla somma/sottrazione dei numeri delle lettere e sulla divisione per la lunghezza del cifrario per ottenere il numero della lettera cercata. Per avere sempre un numero n positivo (anche per la decriptazione) basta aggiungere la lunghezza del cifrario L, in quanto verrà poi eliminata grazie al metodo con cui calcoliamo r.

Esempio di criptazione per il carattere "R":

L = 26
a[R] = 17
b[V] = 21
n = 17 + 21 = 38
r = 38 / 26 = 1,461... = 1
x = 38 - ( 26 * 1 ) = 38 - 26 = 12
lettera(12) = M

Esempio di decriptazione per il carattere "M":

L = 26
b[V] = 21
c[M] = 12
n = 12 - 21 + 26 = 17
r = 17 / 26 = 0,653... = 0
x = 17 - ( 26 * 0 ) = 17 - 0 = 17
lettera(17) = R

; messaggio in chiaro
(setq msg "RICERCARETESORO")
; costruzione il cifrario
(setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
;-> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
(setq lettere (explode cifrario))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
;->  "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
; liste di associazione lettera <--> numero
(setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
;-> (("A" 0) ("B" 1) ("C" 2) ("D" 3) ("E" 4) ("F" 5) ("G" 6)
;->  ("H" 7) ("I" 8) ("J" 9) ("K" 10) ("L" 11) ("M" 12) ("N" 13)
;->  ("O" 14) ("P" 15) ("Q" 16) ("R" 17) ("S" 18) ("T" 19) ("U" 20)
;->  ("V" 21) ("W" 22) ("X" 23) ("Y" 24) ("Z" 25))
(setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
;-> ((0 "A") (1 "B") (2 "C") (3 "D") (4 "E") (5 "F") (6 "G") (7 "H")
;->  (8 "I") (9 "J") (10 "K") (11 "L") (12 "M") (13 "N") (14 "O")
;->  (15 "P") (16 "Q") (17 "R") (18 "S") (19 "T") (20 "U") (21 "V")
;->  (22 "W") (23 "X") (24 "Y") (25 "Z"))
; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
(setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
;-> "VERMEVERMEVERME"
(setq L (length cifrario))
;-> 26

cifratura:

(dolist (el (explode msg))
  (setq a (lookup el char-num))
  (setq b (lookup (chiave $idx) char-num))
  ;(println a { } b)
  (setq n (% (+ a b) L))
  (setq r (/ n L))
  (setq x (- n (* L r)))
  ;(println n { } r { } x)
  (print (lookup x num-char))
)
;-> MMTQVXEIQXZWFDS

Adesso scriviamo le due funzioni di cifratura/decifratura tenendo conto dei caratteri del messaggio che non si trovano nel cifrario (alfabeto). Inoltre aggiungiamo uno spazio " " al nostro alfabeto.

Funzione di cifratura:

(define (vige-cifra msg verme)
  (local (cifrario lettere char-num num-char chiave L out)
    (setq out '())
    (setq msg (upper-case msg))
    (setq verme (upper-case verme))
    ; costruzione del cifrario
    (setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ ")
    (setq lettere (explode cifrario))
    ; liste di associazione lettera <--> numero
    (setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
    (setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
    ; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
    (setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
    (setq L (length cifrario))
    ; ciclo di cifratura del messaggio
    (dolist (el (explode msg))
      ; controllo caratteri sconosciuti
      (cond ((or (nil? (lookup el char-num)) (nil? (lookup (chiave $idx) char-num)))
             (push "$" out -1)
            )
            (true
              (setq a (lookup el char-num))
              (setq b (lookup (chiave $idx) char-num))
              ;(println a { } b)
              (setq n (% (+ a b) L))
              (setq r (/ n L))
              (setq x (- n (* L r)))
              ;(println n { } r { } x)
              ;(print (lookup x num-char))
              (push (lookup x num-char) out -1)
            )
      );cond
    );dolist
    (join out)
  );local
)

(setq msg "CIFRARIO DI VIGENERE")
(vige-cifra msg "VERME")
;-> "XMWCELMELHCDLUKZRVCI"

(define (vige-decifra msg verme)
  (local (cifrario lettere char-num num-char chiave L out)
    (setq out '())
    (setq msg (upper-case msg))
    (setq verme (upper-case verme))
    ; costruzione del cifrario
    (setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ ")
    (setq lettere (explode cifrario))
    ; liste di associazione lettera <--> numero
    (setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
    (setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
    ; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
    (setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
    (setq L (length cifrario))
    ; ciclo di cifratura del messaggio
    (dolist (el (explode msg))
      ; controllo caratteri sconosciuti
      (cond ((or (nil? (lookup el char-num)) (nil? (lookup (chiave $idx) char-num)))
             (push "$" out -1)
            )
            (true
              (setq c (lookup el char-num))
              (setq b (lookup (chiave $idx) char-num))
              ;(println c { } b)
              (setq n (+ (- c b) L))
              (setq r (/ n L))
              (setq x (- n (* L r)))
              ;(println n { } r { } x)
              ;(print (lookup x num-char))
              (push (lookup x num-char) out -1)
            )
      );cond
    );dolist
    (join out)
  );local
)

(setq msg "XMWCELMELHCDLUKZRVCI")
(vige-decifra msg "VERME")
;-> "CIFRARIO DI VIGENERE"


ANAGRAMMI
---------

Quando due o più parole sono composte dagli stessi caratteri, ma in un ordine diverso, vengono chiamate anagrammi.
Usando l'elenco di parole: http://wiki.puzzlers.org/pub/wordlists/unixdict.txt trovare l'insieme di anagrammi che ha il maggior numero di parole (elementi).

Leggiamo tutto il file in una stringa:
(setq datafile (read-file "unixdict1.txt"))

Trasformiamo questa stringa in una lista di stringhe delimitate dal carattere di fine linea (eol - end of line). La funzione "parse" fa proprio questo, suddivide una stringa in sottostringhe basandosi su un delimitatore (in windows il delimitatore di fine linea è "\r\n", mentre su UNIX è "\n"):

(setq data (parse datafile "\r\n"))

Se volessi convertire le stringhe in simboli:
(setq data (map sym data))
;-> (10th 1st 2nd 3rd 4th 5th 6th 7th 8th 9th a a&m a&p a's aaa aaas aarhus aaron aau
;->  aba ababa aback abacus abalone abandon abase abash abate abater abbas abbe abbey
;->  abbot abbott abbreviate abc abdicate abdomen abdominal abduct abe abed abel abelian
;->  abelson aberdeen abernathy aberrant aberrate abet)

Creazione di una lista ordinata in cui ogni elemento è formato dalla parola ordinata e dalla parola di partenza:
(setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data)))
;-> (("&am" "a&m") ("&ap" "a&p") ("'as" "a's") ("01ht" "10th")
;->  ("1st" "1st") ("2dn" "2nd") ("3dr" "3rd") ("4ht" "4th")
;->  ("5ht" "5th") ("6ht" "6th") ("7ht" "7th") ("8ht" "8th")
;->  ("9ht" "9th") ("a" "a") ("aaa" "aaa") ("aaabb" "ababa")
;->  .......

Scriviamo una funzione che utilizza un metodo molto simile al Run-Length Encoding: raggruppa le parole che hanno lo stesso anagramma:

(define (rle lst)
  (local (palo conta ana out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq ana '())
           (setq palo (first (first lst)))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              ; e aggiungiamo l'anagramma alla lista degli anagrammi
              (if (= (first el) palo)
                  (begin (++ conta)
                         (push (last el) ana -1)
                  )
                  ; altrimenti costruiamo la lista (conta ana)
                  ; poi la aggiungiamo al risultato
                  ; e azzeriamo le variabili
                  (begin (push conta ana)
                         (push ana out -1)
                         (setq conta 1)
                         (setq palo (first el))
                         (setq ana (rest el))
                  )
              )
           )
           ; aggiungiamo l'ultima coppia di valori al risultato
           (push conta ana)
           (push ana out -1)
          )
    )
    out
  )
)

(rle lst)
;-> ((1 "a&m") (1 "a&p") (1 "a's") (1 "10th") (1 "1st") (1 "2nd") (1 "3rd")
;->  (1 "4th") (1 "5th") (1 "6th") (1 "7th") (1 "8th") (1 "9th") (1 "a") (1 "aaa")
;->  .....

Quindi la soluzione è la seguente:

  (silent (setq datafile (read-file "unixdict.txt")))
  (silent (setq data (parse datafile "\n")))
  (silent (setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data))))
  (silent (rle lst))
  (slice (sort (rle lst) >) 0 10)

Scriviamo la funzione:

(define (solveAna)
  (setq datafile (read-file "unixdict.txt"))
  (setq data (parse datafile "\n"))
  (setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data)))
  (rle lst)
  (slice (sort (rle lst) >) 0 10)
)

(solveAna)
;-> ((5 "evil" "levi" "live" "veil" "vile")
;->  (5 "elan" "lane" "lean" "lena" "neal")
;->  (5 "caret" "carte" "cater" "crate" "trace")
;->  (5 "angel" "angle" "galen" "glean" "lange")
;->  (5 "alger" "glare" "lager" "large" "regal")
;->  (5 "abel" "able" "bale" "bela" "elba")
;->  (4 "resin" "rinse" "risen" "siren")
;->  (4 "pare" "pear" "rape" "reap")
;->  (4 "nepal" "panel" "penal" "plane")
;->  (4 "mate" "meat" "tame" "team"))

(time (solveAna))
;-> 265.205 ;la funzione è molto veloce.

Usando il file "60000_parole_italiane.txt" otteniamo:

(solveAna)
;-> ((9 "avresti" "restavi" "stivare" "svitare" "versati"
;->     "vestira" "viraste" "vistare" "vistera")
;->  (8 "riavesti" "stiverai" "sviterai" "vestiari" "vestirai"
;->     "visitare" "visitera" "visterai")
;->  (8 "aperti" "aprite" "pareti" "patrie" "perita"
;->     "pietra" "rapite" "ripeta")
;->  (7 "cernite" "cretine" "incerte" "recenti" "recinte" "tenerci" "trincee")
;->  (7 "cavero" "covare" "covera" "creavo" "recavo" "revoca" "vorace")
;->  (7 "argenti" "girante" "granite" "ingrate" "integra" "regnati" "ritenga")
;->  (6 "piastre" "prestai" "rapiste" "sparite" "sperati" "spirate")
;->  (6 "piastra" "rapasti" "raspati" "sparati" "sparita" "spirata")
;->  (6 "perso" "porse" "poser" "preso" "prose" "spero")
;->  (6 "parati" "patria" "pirata" "rapati" "rapita" "tarpai"))

Adesso scriviamo una funzione che controlla se due parole sono anagrammi l'una dell'altra:

(define (anagram? str1 str2)
  (if (or (null? str1) (null? str2)) nil
      (if (!= (length str1) (length str2)) nil
          (if (= (sort (explode str1)) (sort (explode str2)))
              true
              nil
          )
      )
  )
)

(anagram? "pippo" "poppi")
;-> true

(anagram? "abcdefghi" "abcdefghij")
;-> nil

(anagram? "abcdefghi" "abcdefghj")
;-> nil

(time (anagram? "pippipappopoppi" "poppipappopippi") 10000)
;-> 71.007

Se le parole utilizzano solo le lettere maiuscole, allora possiamo scrivere la funzione con un altro algoritmo:

(define (anagram? str1 str2)
  (local (vec ret)
    (if (or (null? str1) (null? str2)) (setq ret nil)
        (if (!= (length str1) (length str2)) (setq ret nil)
          (begin
            (setq ret true)
            (setq str1 (upper-case str1))
            (setq str2 (upper-case str2))
            (setq vec (array 26 '(0)))
            (dostring (ch str1) (++ (vec (- ch 65))))
            (dostring (ch str2) (-- (vec (- ch 65))))
            (while (and ret (< i (length str1)))
               (if (!= (vec i) 0) (setq ret nil))
               (++ i)
            )
          )
        )
    )
    ;(println vec)
    ret
  );local
)

(anagram? "pippo" "poppi")
;-> true

(anagram? "abcdefghi" "abcdefghij")
;-> nil

(anagram? "abcdefghi" "abcdefghj")
;-> nil

(time (anagram? "pippipappopoppi" "poppipappopippi") 10000)
;-> 73.007

Per finire vediamo due funzioni per generare tutti gli anagrammi di una parola.
Il primo dei due algoritmi è stato fornito da Sam Cox e funziona direttamente sulla stringa stessa. Sottosezioni ricorsive della stringa vengono esplose, ruotate e poi unite per formare una nuova stringa.

(define (anagrams s)
    (if (<= (length s) 1)
        (list s)
        (flat (map (fn (n) (aux (rotate-string s n)))
                          (sequence 1 (length s))))))

(define (aux rs)
    (map (fn (x) (append (first rs) x)) (anagrams (rest rs))))

(define (rotate-string s n)
    (join (rotate (explode s) n)))

(anagrams "lisp")
;-> ("psil" "psli" "pils" "pisl" "plsi" "plis" "silp" "sipl" "slpi"
;->  "slip" "spil" "spli" "ilps" "ilsp" "ipsl" "ipls" "islp" "ispl"
;->  "lpsi" "lpis" "lsip" "lspi" "lips" "lisp")

Il secondo algoritmo è un po 'più lento ma si basa, su un algoritmo di permutazioni generalmente applicabile. La funzione permutazioni genera tutte le possibili permutazioni di offset nella stringa, quindi applica tali permutazioni.

(define (permutations lst)
  (if (= (length lst) 1)
   lst
   (apply append (map (fn (rot) (map (fn (perm) (cons (first rot) perm))
      (permutations (rest rot))))
    (rotations lst)))))

(define (rotations lst)
  (map (fn (x) (rotate lst)) (sequence 1 (length lst))))

(define (anagrams str)
  (map (fn (perm) (select str perm))
     (permutations (sequence 0 (- (length str) 1)))))

(anagrams "lisp")
;-> ("psil" "psli" "pils" "pisl" "plsi" "plis" "silp" "sipl" "slpi"
;->  "slip" "spil" "spli" "ilps" "ilsp" "ipsl" "ipls" "islp" "ispl"
;->  "lpsi" "lpis" "lsip" "lspi" "lips" "lisp")

Nota: numero di anagrammi = fattoriale(numero di caratteri)


NUMERI PRIMI CUBAN
------------------

Il nome "cuban" non ha nulla a che fare con Cuba, ma ha a che fare con il fatto che i cubi (le terze potenze) hanno un ruolo nella sua definizione.

I primi cuban sono tutti i numeri primi p che soddisfano:

p = (x^3 - y^3)/(x - y),    dove x = y + 1

I numeri primi cuban sono stati nominati nel 1923 da Allan Joseph Champneys Cunningham.

La seguente funzione brute-force è abbastanza veloce per trovare i numeri primi cubani sotto a 10000:

(define (isprime? n)
  (if (< n 2) nil
    (if (= 1 (length (factor n))))))

(define (primi_cuban N)
  (local (cubani cubo1 cubo2 conta i diff)
    (setq cubani (array (+ N 1) '(0L)))
    (setq cubo1 1L)
    (setq conta 0)
    (setq i 1L)
    (catch
      (while true
        (setq cubo2 (* i i i))
        (setq diff (- cubo2 cubo1))
        (if (isprime? diff)
          (begin
            (if (<= conta N) (setf (cubani conta) diff))
            (if (= conta N) (throw nil))
            (++ conta)
          )
        )
        (setq cubo1 cubo2)
        (++ i)
      )
    );catch
    cubani
  );local
)

(primi_cuban 100)
;-> (7L 19L 37L 61L 127L 271L 331L 397L 547L 631L 919L 1657L 1801L 1951L 2269L 2437L
;->  2791L 3169L 3571L 4219L 4447L 5167L 5419L 6211L 7057L 7351L 8269L 9241L 10267L 11719L
;->  12097L 13267L 13669L 16651L 19441L 19927L 22447L 23497L 24571L 25117L 26227L 27361L
;->  33391L 35317L 42841L 45757L 47251L 49537L 50311L 55897L 59221L 60919L 65269L 70687L
;->  73477L 74419L 75367L 81181L 82171L 87211L 88237L 89269L 92401L 96661L 102121L 103231L
;->  104347L 110017L 112327L 114661L 115837L 126691L 129169L 131671L 135469L 140617L
;->  144541L 145861L 151201L 155269L 163567L 169219L 170647L 176419L 180811L 189757L
;->  200467L 202021L 213067L 231019L 234361L 241117L 246247L 251431L 260191L 263737L
;->  267307L 276337L 279991L 283669L 285517L)

(time (primi_cuban 1000))
;-> 46.869
(time (primi_cuban 5000))
;-> 922.045
(time (primi_cuban 10000))
;-> 3797.161
(time (primi_cuban 20000))
;-> 16017.151
(time (primi_cuban 30000))
;-> 37065.96
(time (primi_cuban 50000))
;-> 108592.154
(time (primi_cuban 100000))
;-> 455520.319


DATA DI PASQUA
--------------

Calcolo della data di pasqua per gli anni 1583 a 4099
La domenica di Pasqua è la domenica successiva alla luna piena Paschal (PFM).
Questo algoritmo è un'interpretazione aritmetica del metod EDS "Easter Dating Method" sviluppato da Ron Mallen 1985.
Poichè i valori vengono ricavati in modo sequenziale da calcoli inter-dipendenti, non modificare l'ordine dei calcoli !
L'operatore / rappresenta la divisione intera, ad esempio: 30 / 7 = 4
Tutte le variabili sono tipi di dati interi.
Per maggiori informazioni: https://www.assa.org.au/edm

(define (pasqua y)
  (local (FirstDig Remain19 temp tA tB tC tD tD)
    (setq FirstDig (/ y 100)) ; prime 2 cifre anno
    (setq Remain19 (% y 19))   ; cifre restanti anno
    ;calcola data PFM
    (setq temp (+ (/ (- FirstDig 15) 2) 202 (- (* 11 Remain19))))
    (if (find FirstDig '(21 24 25 27 28 29 30 31 32 34 35 38))
      (setq temp (- temp 1))
    )
    (if (find FirstDig '(33 36 37 39 40))
      (setq temp (- temp 2))
    )
    (setq temp (% temp 30))
    (setq tA (+ temp 21))
    (if (= temp 29) (setq tA (- tA 1)))
    (if (and (= temp 28) (> Remain19 10)) (setq tA (- tA 1)))
    ; trova la domenica successiva
    (setq tB (% (- tA 19) 7))
    (setq tC (% (- 40 FirstDig) 4))
    (if (= tC 3) (setq tC (+ tC 1)))
    (if (> tC 1) (setq tC (+ tC 1)))
    (setq temp (% y 100))
    (setq tD (% (+ temp (/ temp 4)) 7))
    (setq tE (+ (% (- 20 tB tC tD) 7) 1))
    (setq d (+ tA tE))
    ;data
    (if (> d 31)
      (setq d (- d 31) m 4)
      (setq m 3)
    )
    (list d m y)
  );local
)

(pasqua 2000)
;-> (23 4 2000)

Definiamo una funzione che calcola tutte le domeniche di Pasqua partendo dall'anno x fino all'anno y:

(define (pasque x y)
  (for (i x y)
    (print (pasqua i) { })
    (if (= (% (+ (- i x) 1) 5) 0) (println { }))
  )
  'fine
)

(pasque 2020 2029)
;-> (12 4 2020) (4 4 2021) (17 4 2022) (9 4 2023) (31 3 2024)
;-> (20 4 2025) (5 4 2026) (28 3 2027) (16 4 2028) (1 4 2029)
;-> fine


================

 PROJECT EULERO

================

  Problema    Soluzione     Tempo (msec)
|    1     |  233168       |         0  |
|    2     |  4613732      |         0  |
|    3     |  6857         |         0  |
|    4     |  906609       |       297  |
|    5     |  232792560    |         0  |
|    6     |  25164150     |         0  |
|    7     |  104743       |        78  |
|    8     |  235146240    |       110  |
|    9     |  31875000     |        62  |
|    10    |  142913828    |      1563  |
|    11    |  70600674     |         0  |
|    12    |  76576500     |      5445  |
|    13    |  5537376230   |         0  |
|    14    |  837799       |     22487  |
|    15    |  137846528    |         0  |
|    16    |  1366         |         0  |
|    17    |  21124        |         0  |
|    18    |  1074         |        32  |
|    19    |  171          |         3  |
|    20    |  648          |         0  |
|    21    |  31626        |       672  |
|    22    |  871198282    |        20  |
|    23    |  4179871      |     40900  |
|    24    |  278391546    |     25309  |
|    25    |  4782         |      4926  |
|    26    |  983          |       488  |
|    27    |  -59231       |      2000  |
|    28    |  669171001    |         0  |
|    29    |  9183         |       141  |
|    30    |  443839       |       516  |
|    31    |  73682        |         1  |
|    32    |  45228        |      1625  |
|    33    |  100          |         0  |
|    34    |  40730        |      3797  |
|    35    |  55           |      1267  |
|    36    |  872187       |      1443  |
|    37    |  748317       |       778  |
|    38    |  932718654    |        94  |
|    39    |  840          |     13486  |
|    40    |  210          |       141  |
|    41    |  7652413      |       125  |
|    42    |  162          |        31  |
|    43    |  16695334890  |      1749  |
|    44    |  5482660      |      5589  |
|    45    |  1533776805   |       115  |
|    46    |  5777         |        31  |
|    47    |  134043       |         0  |
|    48    |  9110846700   |       266  |
|    49    |  296962999629 |        19  |
|    50    |  997651       |     27113  |

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
  (if (< n 2) nil
    (if (= 1 (length (factor n))))))
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
============================================================================

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
============================================================================

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
============================================================================

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

Un numero palindromo ha lo stesso valore leggendo da sinistra a destra o da destra a sinistra.
Il più grande numero palindromo ottenuto dal prodotto di due numeri da due cifre vale 9009 = 91 * 99.

Trova il più grande numero palindromo ottenuto dal prodotto di due numeri da tre cifre.
============================================================================

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
============================================================================

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
============================================================================

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
============================================================================

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
============================================================================

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
============================================================================

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

La somma dei numeri primi minori di 10 vale 2 + 3 + 5 + 7 = 17.

Trovare la somma di tutti i primi minori di 2 milioni.
============================================================================

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
Problema 11
===========

Il più grande prodotto in una griglia

Nella griglia 20 × 20 seguente, quattro numeri lungo una linea diagonale sono stati racchiusi con i caratteri > < (es. >26<).

08  02  22  97  38  15  00  40  00  75  04  05  07  78  52  12  50  77  91  08
49  49  99  40  17  81  18  57  60  87  17  40  98  43  69  48  04  56  62  00
81  49  31  73  55  79  14  29  93  71  40  67  53  88  30  03  49  13  36  65
52  70  95  23  04  60  11  42  69  24  68  56  01  32  56  71  37  02  36  91
22  31  16  71  51  67  63  89  41  92  36  54  22  40  40  28  66  33  13  80
24  47  32  60  99  03  45  02  44  75  33  53  78  36  84  20  35  17  12  50
32  98  81  28  64  23  67  10 >26< 38  40  67  59  54  70  66  18  38  64  70
67  26  20  68  02  62  12  20  95 >63< 94  39  63  08  40  91  66  49  94  21
24  55  58  05  66  73  99  26  97  17 >78< 78  96  83  14  88  34  89  63  72
21  36  23  09  75  00  76  44  20  45  35 >14< 00  61  33  97  34  31  33  95
78  17  53  28  22  75  31  67  15  94  03  80  04  62  16  14  09  53  56  92
16  39  05  42  96  35  31  47  55  58  88  24  00  17  54  24  36  29  85  57
86  56  00  48  35  71  89  07  05  44  44  37  44  60  21  58  51  54  17  58
19  80  81  68  05  94  47  69  28  73  92  13  86  52  17  77  04  89  55  40
04  52  08  83  97  35  99  16  07  97  57  32  16  26  26  79  33  27  98  66
88  36  68  87  57  62  20  72  03  46  33  67  46  55  12  32  63  93  53  69
04  42  16  73  38  25  39  11  24  94  72  18  08  46  29  32  40  62  76  36
20  69  36  41  72  30  23  88  34  62  99  69  82  67  59  85  74  04  36  16
20  73  35  29  78  31  90  01  74  31  49  71  48  86  81  16  23  57  05  54
01  70  54  71  83  51  54  69  16  92  33  48  61  43  52  01  89  19  67  48

Il prodotto di questi numeri vale 26 × 63 × 78 × 14 = 1788696.

Qual'è il valore più grande del prodotto di quattro numeri adiacenti nella stessa direzione (su, giù, sinistra, destra o diagonalmente) nella griglia 20 × 20?
============================================================================

(setq grid
'( 8  2 22 97 38 15  0 40  0 75  4  5  7 78 52 12 50 77 91  8
  49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48  4 56 62  0
  81 49 31 73 55 79 14 29 93 71 40 67 53 88 30  3 49 13 36 65
  52 70 95 23  4 60 11 42 69 24 68 56  1 32 56 71 37  2 36 91
  22 31 16 71 51 67 63 89 41 92 36 54 22 4  40 28 66 33 13 80
  24 47 32 60 99  3 45  2 44 75 33 53 78 36 84 20 35 17 12 50
  32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
  67 26 20 68  2 62 12 20 95 63 94 39 63  8 40 91 66 49 94 21
  24 55 58  5 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
  21 36 23  9 75  0 76 44 20 45 35 14  0 61 33 97 34 31 33 95
  78 17 53 28 22 75 31 67 15 94  3 80  4 62 16 14  9 53 56 92
  16 39  5 42 96 35 31 47 55 58 88 24  0 17 54 24 36 29 85 57
  86 56  0 48 35 71 89  7  5 44 44 37 44 60 21 58 51 54 17 58
  19 80 81 68  5 94 47 69 28 73 92 13 86 52 17 77  4 89 55 40
   4 52  8 83 97 35 99 16  7 97 57 32 16 26 26 79 33 27 98 66
  88 36 68 87 57 62 20 72  3 46 33 67 46 55 12 32 63 93 53 69
   4 42 16 73 38 25 39 11 24 94 72 18  8 46 29 32 40 62 76 36
  20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74  4 36 16
  20 73 35 29 78 31 90  1 74 31 49 71 48 86 81 16 23 57  5 54
   1 70 54 71 83 51 54 69 16 92 33 48 61 43 52  1 89 19 67 48))

(length grid)
;-> 400

(define (right i)
  (setq r (slice grid i 4))
  (apply * r))

(define (down i)
  (setq d (select grid i (+ i 20) (+ i 40) (+ i 60)))
  (apply * d))

(define (diag-down-right i)
  (setq dr (select grid i (+ i 21) (+ i 42) (+ i 63)))
  (apply * dr))

(define (diag-down-left i)
  (setq dl (select grid i (+ i 19) (+ i 38) (+ i 57)))
  (apply * dl))

(define (e011)
  (setq down-max (apply max (map (fn (x) (down x)) (sequence 0 339))))
  (setq diag-down-left-max (apply max (map (fn (x) (diag-down-left x)) (sequence 3 339))))
  (setq diag-down-right-max (apply max (map (fn (x) (diag-down-right x)) (sequence 0 333))))
  (max down-max diag-down-left-max diag-down-left-max)
)

(e011)
;-> 70600674

(time (e011))
;-> 0


===========
Problema 12
===========

Numero triangolare altamente divisibile

La sequenza di numeri triangolari viene generata aggiungendo i numeri naturali. Quindi il settimo numero di triangolo sarebbe 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. I primi dieci termini sarebbero:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

Cerchiamo di elencare i fattori dei primi sette numeri di triangolo:

  1: 1
  3: 1,3
  6: 1,2,3,6
10: 1,2,5,10
15: 1,3,5,15
21: 1,3,7,21
28: 1,2,4,7,14,28

Possiamo vedere che 28 è il primo numero di triangolo ad avere più di cinque divisori.

Qual'è il valore del primo numero di triangolo per avere oltre cinquecento divisori?
============================================================================

Funzione che calcola l'n-esimo numero triangolare:

(define (numtri n) (/ (+ (* n n) n) 2))
;-> (numtri 1)
;-> 1
;-> (numtri 2)
;-> 3
;-> (numtri 3)
;-> 6
;-> (numtri 4)
;-> 10

Funzione cha calcola il numero di divisori di un numero n:

(define (numdivisors n)
  (local (ndiv)
    (setq ndiv 0)
    (for (i 1 (+ n 1))
      (if (zero? (mod (div n i) 1) 0) (++ ndiv))
      ;(if (= (mod (div n i) 1) 0) (begin (++ ndiv) (println i)))
    )
    ndiv
  )
)

(numdivisors 10) ;(1 2 5 10)
;-> 4

(numdivisors 64) ;(1 2 4 8 16 32 64)
;-> 7

(define (e012)
  (let (look true)
    (for (i 1 99999 2 (not look))
      (if (> (* (numdivisors i) (numdivisors (div (numtri i) i))) 500)
        (begin
          (println "i = " i {; }
                   "tri = " (numtri i) {; }
                   "divisori = " (* (numdivisors i) (numdivisors (div (numtri i) i))))
          (setq look false)
        )
      )
    )
  )
)

(e012)
;-> i = 12375; tri = 76576500; divisori = 576
;-> true

(time (e012))
;-> 5444.521


===========
Problema 13
===========

Grande somma

Calcolare le prime dieci cifre della somma dei seguenti cento numeri di 50 cifre ognuno.
P==============

Suddividiamo la lista da 100 numeri in due liste da 50 numeri per evitare il limite dei 2048 caratteri che newLISP pone alla lunghezza di una espressione.

(setq numeriA '(
 37107287533902102798797998220837590246510135740250L
 46376937677490009712648124896970078050417018260538L
 74324986199524741059474233309513058123726617309629L
 91942213363574161572522430563301811072406154908250L
 23067588207539346171171980310421047513778063246676L
 89261670696623633820136378418383684178734361726757L
 28112879812849979408065481931592621691275889832738L
 44274228917432520321923589422876796487670272189318L
 47451445736001306439091167216856844588711603153276L
 70386486105843025439939619828917593665686757934951L
 62176457141856560629502157223196586755079324193331L
 64906352462741904929101432445813822663347944758178L
 92575867718337217661963751590579239728245598838407L
 58203565325359399008402633568948830189458628227828L
 80181199384826282014278194139940567587151170094390L
 35398664372827112653829987240784473053190104293586L
 86515506006295864861532075273371959191420517255829L
 71693888707715466499115593487603532921714970056938L
 54370070576826684624621495650076471787294438377604L
 53282654108756828443191190634694037855217779295145L
 36123272525000296071075082563815656710885258350721L
 45876576172410976447339110607218265236877223636045L
 17423706905851860660448207621209813287860733969412L
 81142660418086830619328460811191061556940512689692L
 51934325451728388641918047049293215058642563049483L
 62467221648435076201727918039944693004732956340691L
 15732444386908125794514089057706229429197107928209L
 55037687525678773091862540744969844508330393682126L
 18336384825330154686196124348767681297534375946515L
 80386287592878490201521685554828717201219257766954L
 78182833757993103614740356856449095527097864797581L
 16726320100436897842553539920931837441497806860984L
 48403098129077791799088218795327364475675590848030L
 87086987551392711854517078544161852424320693150332L
 59959406895756536782107074926966537676326235447210L
 69793950679652694742597709739166693763042633987085L
 41052684708299085211399427365734116182760315001271L
 65378607361501080857009149939512557028198746004375L
 35829035317434717326932123578154982629742552737307L
 94953759765105305946966067683156574377167401875275L
 88902802571733229619176668713819931811048770190271L
 25267680276078003013678680992525463401061632866526L
 36270218540497705585629946580636237993140746255962L
 24074486908231174977792365466257246923322810917141L
 91430288197103288597806669760892938638285025333403L
 34413065578016127815921815005561868836468420090470L
 23053081172816430487623791969842487255036638784583L
 11487696932154902810424020138335124462181441773470L
 63783299490636259666498587618221225225512486764533L
 67720186971698544312419572409913959008952310058822L ))

(setq numeriB '(
 95548255300263520781532296796249481641953868218774L
 76085327132285723110424803456124867697064507995236L
 37774242535411291684276865538926205024910326572967L
 23701913275725675285653248258265463092207058596522L
 29798860272258331913126375147341994889534765745501L
 18495701454879288984856827726077713721403798879715L
 38298203783031473527721580348144513491373226651381L
 34829543829199918180278916522431027392251122869539L
 40957953066405232632538044100059654939159879593635L
 29746152185502371307642255121183693803580388584903L
 41698116222072977186158236678424689157993532961922L
 62467957194401269043877107275048102390895523597457L
 23189706772547915061505504953922979530901129967519L
 86188088225875314529584099251203829009407770775672L
 11306739708304724483816533873502340845647058077308L
 82959174767140363198008187129011875491310547126581L
 97623331044818386269515456334926366572897563400500L
 42846280183517070527831839425882145521227251250327L
 55121603546981200581762165212827652751691296897789L
 32238195734329339946437501907836945765883352399886L
 75506164965184775180738168837861091527357929701337L
 62177842752192623401942399639168044983993173312731L
 32924185707147349566916674687634660915035914677504L
 99518671430235219628894890102423325116913619626622L
 73267460800591547471830798392868535206946944540724L
 76841822524674417161514036427982273348055556214818L
 97142617910342598647204516893989422179826088076852L
 87783646182799346313767754307809363333018982642090L
 10848802521674670883215120185883543223812876952786L
 71329612474782464538636993009049310363619763878039L
 62184073572399794223406235393808339651327408011116L
 66627891981488087797941876876144230030984490851411L
 60661826293682836764744779239180335110989069790714L
 85786944089552990653640447425576083659976645795096L
 66024396409905389607120198219976047599490197230297L
 64913982680032973156037120041377903785566085089252L
 16730939319872750275468906903707539413042652315011L
 94809377245048795150954100921645863754710598436791L
 78639167021187492431995700641917969777599028300699L
 15368713711936614952811305876380278410754449733078L
 40789923115535562561142322423255033685442488917353L
 44889911501440648020369068063960672322193204149535L
 41503128880339536053299340368006977710650566631954L
 81234880673210146739058568557934581403627822703280L
 82616570773948327592232845941706525094512325230608L
 22918802058777319719839450180888072429661980811197L
 77158542502016545090413245809786882778948721859617L
 72107838435069186155435662884062257473692284509516L
 20849603980134001723930671666823555245252804609722L
 53503534226472524250874054075591789781264330331690L ))

(length numeriA)
;-> 50
(length numeriB)
;-> 50

(apply + numeriA)
;-> 2739840008414248713350123647779193919724097856798098L

(apply + numeriB)
;-> 2797536221976627923951925099053792052049561975094574L

(+ (apply + numeriA) (apply + numeriB))

(define (e013)
  (slice (string (+ (apply + numeriA) (apply + numeriB))) 0 10))

(e013)
;-> "5537376230"

Il numero  completo vale:
5537376230390876637302048746832985971773659831892672L

(time (e013))
;-> 0


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
============================================================================

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
Problema 15
===========

Percorsi in una griglia

Partendo dall'angolo in alto a sinistra di una griglia 2 × 2, e potendo solo spostarsi verso destra e verso il basso, ci sono esattamente 6 percorsi diversi per raggiungere l'angolo in basso a destra.

Quanti percorsi ci sono attraverso una griglia 20 × 20?
P==============

Quello che ci interessa è la distanza tra le coordinate di inizio e fine, cioè la dimensione della griglia: 20.

Possiamo scrivere una funzione ricorsiva che utilizza questo valore di distanza per calcolare il numero totale dei percorsi (minimi) tra i due punti.
Poichè ogni volta ci dobbiamo muovere a destra o verso il basso possiamo richiamare la stesse funzioni con uno dei parametri (destra o basso) diminuito di 1. Queste funzioni vengono richiamate tante volte quanto vale la distanza tra le coordinate. Facendo la somma dei risultati di queste funzioni otteniamo il numero di percorsi (minimi) tra le coordinate di inizio e fine della griglia.

La funzione ricorsiva per il calcolo dei percorsi è la seguente:

(define (numPercorsi basso destra);
    (if (or (= basso 0) (= destra 0)) 1
        (+ (numPercorsi (- basso 1) destra)
           (numPercorsi basso (- destra 1)))
    )
)

(numPercorsi 2 2)
;-> 6

(numPercorsi 10 10)
;-> 184756

(time (numPercorsi 20 20))

Purtroppo questa funzione è molto lenta (O(2^n)) quindi dobbiamo utilizzare un'altro metodo. Dal punto di vista matematico, il numero di percorsi in una griglia dal punto (0,0) al punto (n,m) è uguale al coefficiente binomiale:

(n + m)      (n + m)!
        = -------------
(  n  )      n! * m!
                          (2*n)    (2*n)!    (40)      40!
Nel nostro caso diventa:        = -------- =      = ---------
                          ( n )    (n!)^2    (20)    (20!)^2

Definiamo la funzione fattoriale:

(define (fact n) (apply * (map bigint (sequence 1 n))))

Calcoliamo il numero di persorsi:

(define (e015)
  (div (fact 40) (mul (fact 20) (fact 20)))
)

(e015)
;-> 137846528820

(time (e015))
;-> 0


===========
Problema 16
===========

Somma cifre di una potenza

215 = 32768 e la somma delle sue cifre vale 3 + 2 + 7 + 6 + 8 = 26.

Quanto vale la somma delle cifre del numero 2^1000?
============================================================================

(Definiamo una funzione che calcola la potenza di un numero intero (big integer):

(define (potenza n m)
  (setq pot 1L)
  (dotimes (x m)
    (setq pot (* pot n))
  )
)

(potenza 3 50)
;-> 717897987691852588770249L

(define (e016)
  (setq num (potenza 2 1000))
  (setq n$ (string num))
  (setq n$ (slice n$ 0 (- (length n$) 1)))
  (apply + (map int (explode n$)))
)

(e016)
;-> 1366

(time (e016))
;-> 0


===========
Problema 17
===========

Contare il numero di lettere

Se i numeri da 1 a 5 sono scritti con le parole inglesi:
one, two, three, four, five allora sono state usate
 3  +  3  +  5  +  4  +  4 = 19 lettere in totale.

Se tutti i numeri da 1 a 1000 (one thousand) incluso fossero scritti con le parole inglesi, quante lettere occorrerebbe usare?

NOTA: non contare spazi o trattini. Ad esempio, 342 (three hundred and forty-two) contiene 23 lettere e 115 (one hundred and fifteen) contiene 20 lettere. L'uso di "and" quando si scrivono numeri è conforme all'uso britannico.
============================================================================

La soluzione è tediosa.

(setq n1-19 '("" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"))

(setq n20-90 '("" "" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))

(setq n100 "hundred")

; gli spazi non contano
(setq n100and "hundredand")

(setq n1000 "onethousand")

(define (e017)
  (local (n1-9 n10-19 n20-99 n100-999)
    (setq n1-9 (apply + (map length (1 9 n1-19))))
    (setq n10-19 (apply + (map length (10 19 n1-19))))
    (setq n20-99 (+ (* 10 (apply + (map length (2 9 n20-90))))
                    (* 8 n1-9)))
    (setq n100-999 (+ (* 100 (+ n1-9))
                      (* 9 (+ n1-9 n10-19 n20-99))
                            (* 9 (length n100))
                            (* 9 99 (length n100and))))
    (+ n1-9 n10-19 n20-99 n100-999 (length n1000))
  )
)

(e017)
;-> 21124


===========
Problema 18
===========

Percorso con somma massima

Iniziando dalla parte superiore del triangolo in basso e passando ai numeri adiacenti sulla riga sottostante, il totale massimo dall'alto verso il basso è 23.

   3
  7 4
 2 4 6
8 5 9 3

Cioè, 3 + 7 + 4 + 9 = 23.

Trova il totale massimo dall'alto al basso del triangolo sottostante:

                            75
                          95 64
                        17 47 82
                      18 35 87 10
                    20 04 82 47 65
                  19 01 23 75 03 34
                88 02 77 73 07 63 67
              99 65 04 28 06 16 70 92
            41 41 26 56 83 40 80 70 33
          41 48 72 33 47 32 37 16 94 29
        53 71 44 65 25 43 91 52 97 51 14
      70 11 33 28 77 73 17 78 39 68 17 57
    91 71 52 38 17 14 91 43 58 50 27 29 48
  63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

NOTA: poiché ci sono solo 16384 percorsi, è possibile risolvere questo problema provando ogni percorso.
============================================================================

La seguente soluzione è veramente "brutale".

(define (e018)
  (local (a aa b bb c cc d dd e ee f ff g gg h hh i ii j jj k kk l ll m mm n nn o oo somma sommaMax)
    (setq triangle '((75) (95 64) (17 47 82) (18 35 87 10) (20 4 82 47 65) (19 1 23 75 3 34) (88 2 77 73 7 63 67) (99 65 4 28 6 16 70 92) (41 41 26 56 83 40 80 70 33) (41 48 72 33 47 32 37 16 94 29) (53 71 44 65 25 43 91 52 97 51 14) (70 11 33 28 77 73 17 78 39 68 17 57) (91 71 52 38 17 14 91 43 58 50 27 29 48) (63 66 4 68 89 53 67 30 73 16 69 87 40 31) (4 62 98 27 23 9 70 98 73 93 38 53 60 4 23)))
    (setq a (triangle 0))
    (setq b (triangle 1))
    (setq c (triangle 2))
    (setq d (triangle 3))
    (setq e (triangle 4))
    (setq f (triangle 5))
    (setq g (triangle 6))
    (setq h (triangle 7))
    (setq i (triangle 8))
    (setq j (triangle 9))
    (setq k (triangle 10))
    (setq l (triangle 11))
    (setq m (triangle 12))
    (setq n (triangle 13))
    (setq o (triangle 14))
    (setq sommaMax 0)
    (setq somma 0)
    (for (bb 0 (- (length b) 1))
     (for (cc bb (+ bb 1))
       (for (dd cc (+ cc 1))
        (for (ee dd (+ dd 1))
         (for (ff ee (+ ee 1))
          (for (gg ff (+ ff 1))
           (for (hh gg (+ gg 1))
            (for (ii hh (+ hh 1))
             (for (jj ii (+ ii 1))
              (for (kk jj (+ jj 1))
               (for (ll kk (+ kk 1))
                (for (mm ll (+ ll 1))
                 (for (nn mm (+ mm 1))
                  (for (oo nn (+ nn 1))
                   (setq somma (+ (a 0) (b bb) (c cc) (d dd) (e ee) (f ff) (g gg) (h hh)
                                  (i ii) (j jj) (k kk) (l ll) (m mm) (n nn) (o oo)))
                   (if (> somma sommaMax) (swap somma sommaMax))
    ))))))))))))))
    sommaMax
  );local
)

(e018)
;-> 1074

(time (e018))
;-> 31.248


===========
Problema 19
===========

Conteggio delle domeniche

Ti vengono fornite le seguenti informazioni, ma potresti ricercare altre informazioni per te stesso.

- Il 1 gennaio 1900 era un lunedì.
- Trenta dì conta Novembre
  con April, Giugno e Settembre.
  Di ventotto ce n'è uno,
  Tutti gli altri ne han trentuno.

Un anno bisestile si verifica quando è divisibile per 4, ma non per un secolo (00) a meno che non sia divisibile per 400.

Quante domeniche caddero il primo del mese durante il ventesimo secolo (dal 1° gennaio 1901 al 31 dicembre 2000)?
============================================================================

Usiamo l'algoritmo di Gauss per determinare il giorno della settimana:

(define (day-of-week year month day) ; 0..6 --> Sun..Sat
    (letn ( d day
            m (+ (% (- month 3) 12) 1)
            Y (if (> m 10) (- year 1) year)
            y (% Y 100)
            c (/ (- Y y) 100)
            w (add d (floor (sub (mul 2.6 m) 0.2)) y (floor (div y 4)) (floor (div c 4)) (- (mul c 2)))
            w (% w 7)
          )
       (if (< w 0) (inc w 7) w))
)

Adesso la soluzione è abbastanza semplice:

(define (e019)
  (local (somma)
    (setq somma 0)
    (for (anno 1901 1999)
      (for (mese 1 12)
        (if (zero? (day-of-week anno mese 1)) (++ somma))
      )
    )
    somma
  )
)

(e019)
;-> 171

(time (e019))
;-> 2.997


===========
Problema 20
===========

Somma di cifre fattoriali

n! significa n × (n - 1) × ... × 3 × 2 × 1

Ad esempio, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
e la somma delle cifre nel numero 10! vale 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Trova la somma delle cifre nel numero 100!
============================================================================

Funzione fattoriale

(define (fact n) (apply * (map bigint (sequence 1 n))))

(explode (string (fact 10)))
;-> ("3" "6" "2" "8" "8" "0" "0" "L")

(map int (explode (string (fact 10))))
;-> (3 6 2 8 8 0 0 nil)

(define (e020)
  (apply + (map (fn (x) (int x 0)) (explode (string (fact 100)))))
)

(e020)
;-> 648

(time (e020))
;-> 0

Il creatore di newLISP (Lutz Mueller) ha scritto la seguente funzione che moltiplica due numeri interi passati come stringhe (è valida anche per numeri big-integer).

(define (big* x y) ; a and b are strings of decimal digits
    (letn ( nx (length x)
            ny (length y)
            np (+ nx ny)
            X (array nx (reverse (map int (explode x))))
            Y (array ny (reverse (map int (explode y))))
            Q (array (+ nx 1) (dup 0 (+ nx 1)))
            P (array np (dup 0 np))
            carry 0
            digit 0 )
        (dotimes (i ny) ; for each digit of the multiplier
            (dotimes (j nx) ; for each digit of the multiplicant
                (setq digit (+ (* (Y i) (X j)) carry) )
                (setq carry (/ digit 10))
                (setf (Q j) (% digit 10)) )
            (setf (Q nx ) carry)
            ; add Q to P shifted by i
            (setq carry 0)
            (dotimes (j (+ nx 1))
                (setq digit (+ (P (+ j i)) (Q j) carry))
                (setq carry (/ digit 10))
                (setf (P (+ j i)) (% digit 10)) )
        )
    ; translate P to string and return
    (setq P (reverse (array-list P)))
    (if (zero? (P 0)) (pop P))
    (join (map string P))
    )
)

Con la seguente soluzione al problema:

(define (e020-Lutz)
    (let (result "1")
        (for (i 2 100)
            (setq result (big* result (string i))))
        (apply + (map int (explode result))))
)

(e020-Lutz)
;-> 648

(time (e020-Lutz))
;-> 32.948


===========
Problema 21
===========

Numeri Amicabili

Definiamo d(n) come la somma dei divisori propri di n (tutti i numeri minori di n che dividono esattamente n).

Se d(a) = b e d(b) = a, dove a ≠ b,, allora a e b sono una coppia amicabile e a e b sono chiamati singolarmente numeri amicabili.

Per esempio, i divisori propri di 220 sono 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 e 110: quindi d(n) = 284. I divisori propri di 284 sono 1, 2, 4, 71 e 142: così d(284) = 220.

Calcolare la somma di tutti i numeri amicabili inferiori a 10000.
============================================================================

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


===========
Problema 22
===========

Punteggio dei nomi

Usando "names.txt", un file di testo 46K contenente oltre cinquemila nomi, inizia crando una lista dei nomi in ordine alfabetico. Quindi, calcolando il valore alfabetico per ciascun nome, moltiplica questo valore per la sua posizione alfabetica nella lista per ottenere un punteggio del nome.

Ad esempio, quando la lista è ordinata in ordine alfabetico, COLIN, che vale 3 + 15 + 12 + 9 + 14 = 53, è il 938-esimo nome nell'elenco. Quindi, COLIN otterrebbe un punteggio di 938 × 53 = 49714.

Qual è il totale di tutti i punteggi dei nomi contenuti nel file?
============================================================================

Il file ha questa struttura:
"MARY","PATRICIA","LINDA",...

Rimuoviamo tutti i caratteri doppio-apice "":

(define (remove-char c from-file to-file)
    (set 'in-file (open from-file "read"))
    (set 'out-file (open to-file "write"))
    (while (set 'chr (read-char in-file))
        (if (!= chr c)
          (write-char out-file chr)))
    (close in-file)
    (close out-file)
    "fatto")

(char {"})
;-> 34

(char 34)
;-> "\""

(remove-char 34 "p022_nomi.txt" "nomi22.txt")

Il file adesso ha questa struttura:

MARY,PATRICIA,LINDA,...

Importiamo il file in una lista di stringhe:

(silent (setq nomi (parse (read-file "nomi22.txt") ",")))

Vediamo i primi cinque nomi:

(slice nomi 0 5)
;-> ("MARY" "PATRICIA" "LINDA" "BARBARA" "ELIZABETH")

Ordiniamo la lista:

(silent (sort nomi))

Vediamo i primi cinque nomi:

(slice nomi 0 5)
;-> ("AARON" "ABBEY" "ABBIE" "ABBY" "ABDUL")

Vediamo dove si trova "COLIN":

(ref "COLIN" nomi )
;-> 937

Quindi dobbiamo aggiungere 1 all'indice della lista (+ $idx 1).
Adesso creiamo una lista associativa (association list) tra i caratteri e il numero del relativo ordine.

(setq alfa  '(("A" 1) ("B" 2) ("C" 3) ("D" 4) ("E" 5) ("F" 6) ("G" 7) ("H" 8) ("I" 9) ("J" 10) ("K" 11) ("L" 12) ("M" 13) ("N" 14) ("O" 15) ("P" 16) ("Q" 17) ("R" 18) ("S" 19) ("T" 20) ("U" 21) ("V" 22) ("W" 23) ("X" 24) ("Y" 25) ("Z" 26)))

(lookup '"A" alfa)
;-> 1

(define (e022)
  (local (somma nomesomma nome$)
    (setq somma 0)
    (dolist (el nomi)
      (setq nome$ (explode el))
      (setq nomesomma 0)
      (dolist (c nome$)
        (setq nomesomma (add nomesomma (lookup c alfa)))
      )
      (setq nomesomma (mul nomesomma (+ $idx 1)))
      (setq somma (add somma nomesomma))
    )
  )
)

(e022)
;-> 871198282

(time (e022))
;-> 20.016


===========
Problema 23
===========

Somma numeri non abbondanti

Un numero perfetto è un numero per il quale la somma dei relativi divisori è esattamente uguale al numero. Ad esempio, la somma dei divisori propri di 28 sarebbe 1 + 2 + 4 + 7 + 14 = 28, il che in dica che 28 è un numero perfetto.

Un numero n è chiamato carente se la somma dei suoi divisori è inferiore a n e viene chiamato abbondante se questa somma supera n.

Dato che 12 è il numero abbondante più piccolo, 1 + 2 + 3 + 4 + 6 = 12, il numero più piccolo che può essere scritto come somma di due numeri abbondanti è 24. Con l'analisi matematica, si può dimostrare che tutti gli interi superiori a 28123 possono essere scritti come somma di due numeri abbondanti. Tuttavia, questo limite superiore non può essere ulteriormente ridotto dall'analisi anche se è noto che il più grande numero che non può essere espresso come somma di due numeri abbondanti è inferiore a questo limite.

Trovare la somma di tutti i numeri interi positivi che non possono essere scritti come la somma di due numeri abbondanti.
============================================================================

Funzione che calcola la somma di tutti i divisori propri (tutti i divisori tranne se stesso) di un numero :
(vedi problema 21)

(define (factor-group x)
  (if (= x 1) '(1 1)
    (letn (fattori (factor x)
          unici (unique fattori))
      (transpose (list unici (count unici fattori)))
    )
  )
)

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

(somma-divisori-propri-fast 284235235345)
;-> 59865475031

Funzione che cerca una coppia di numeri in un vettore che sommano a num.
Questa funzione ha complessità temporale O(nlog(n)).

(define (trovaCoppia vec num)
  (local (low high a b out)
    ; ordina il vettore in ordine crescente
    (sort vec)
    ; indici che puntano all'inizio e alla fine dell'array
    (setq low 0)
    (setq high (- (length vec) 1))
    (while (and (< low high) (= out nil))
      (setq a (vec low))
      (setq b (vec high))
      ; vale anche la coppia formata dallo stesso numero ripetuto
      ; altrimenti il risultato vale: 4179935
      (if (or (= num (add a b)) (= num (add a a)) (= num (add b b)))
          ; coppia trovata
          (setq out true)
      )
      (if (< (add (vec low) (vec high)) num)
          ; incrementa l'indice basso se il totale è minore della somma
          (++ low)
          ; decrementa indice alto se è totale è maggiore della somma
          (-- high)
      )
    )
    out
  );local
)

(setq lst '( 123 73 64 7 8 6 5 4 3 4 5 6 7 ))
(setq v (array (length lst) lst))
(array? v)
;-> true

(trovaCoppia v 130)
;-> true

(trovaCoppia v 230)
;-> nil

(trovaCoppia v 246)
;-> true

Funzione che crea la lista dei numeri abbondanti fino al numero 28123.

(define (creaAbbondanti)
  (local (out)
    (setq out '())
    (for (i 1 28123)
      (if (< i (somma-divisori-propri-fast i))
        (push i out)
      )
    )
    out
  )
)

(silent (setq abbo (creaAbbondanti)))
(time (setq abbo (creaAbbondanti)))

(length abbo)
;-> 6965
(sort abbo)

(slice abbo 0 30)
;-> (12 18 20 24 30 36 40 42 48 54 56 60 66 70 72 78 80 84 88 90 96 100 102 104 108 112 114 120 126 132)

Adesso possiamo scrivere la funzione che trova i numeri richiesti dal problema:

(define (e023)
  (local (abbo-lst abbo somma out)
    (setq out '())
    (setq somma 0)
    (setq abbo-lst (creaAbbondanti))
    (setq abbo (array (length abbo-lst) abbo-lst))
    (for (i 1 28123)
      (if (not (trovaCoppia abbo i))
        (begin
          (setq somma (add somma i))
          (push i out -1)
        )
      )
    )
    (println somma)
    out
  )
)

(silent (setq res (e023)))
;-> 4179871

(slice res 0 100)
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 25 26 27 28 29 31 33
;->  34 35 37 39 41 43 45 46 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83
;->  85 87 89 91 93 95 97 99 101 103 105 107 109 111 113 115 117 119 121 123 125 127
;->  129 131 133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167
;->  169)

Sopra a 50 i numeri della somma sono tutti dispari, quindi dividiamo il ciclo for in due parti:

(define (e023)
  (local (abbo-lst abbo somma)
    (setq somma 0)
    (setq abbo-lst (creaAbbondanti))
    (setq abbo (array (length abbo-lst) abbo-lst))
    (for (i 1 50)
      (if (not (trovaCoppia abbo i))
          (setq somma (add somma i))
      )
    )
    (for (i 51 28123 2)
      (if (not (trovaCoppia abbo i))
          (setq somma (add somma i))
      )
    )
    somma
  )
)

(e023)
;-> 4179871

(time (e023))
;-> 40900.186 ; circa 41 secondi


===========
Problema 24
===========

Permutazioni lessicografiche

Una permutazione è una disposizione ordinata di oggetti. Ad esempio, 3124 è una possibile permutazione delle cifre 1, 2, 3 e 4. Se tutte le permutazioni sono ordinate numericamente o alfabeticamente, vengono chiamate in ordine lessicografico. Le permutazioni lessicografiche di 0, 1 e 2 sono:

012 021 102 120 201 210

Qual è la milionesima permutazione lessicografica delle cifre 0, 1, 2, 3, 4, 5, 6, 7, 8 e 9?
============================================================================

Definiamo la funzione che genera le permutazioni:

(define (seq start end)
  (if (= start end)
      (list end)
      (cons start (seq (+ start 1) end))))

(define (permute l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n) (insert p n (first l))) (seq 0 (length p))))
                         (permute (rest l))))))


Scriviamo la funzione finale:

(define (e024)
  (setq p (sort (permute '(0 1 2 3 4 5 6 7 8 9))))
  (int (join (map string (p 999999))))
)

Abbiamo ordinato le permutazioni poichè non vengono create in ordine lessicografico.

(e024)
;-> 2783915460

(time (e024))
;-> 25309.091  ;circa 25 secondi



===========
Problema 25
===========

Numero di Fibonacci a 1000 cifre

La sequenza di Fibonacci è definita dalla relazione di ricorrenza:

Fn = Fn-1 + Fn-2, dove F1 = 1 e F2 = 1.
Quindi i primi 12 termini saranno:

F1 = 1
F2 = 1
F3 = 2
F4 = 3
F5 = 5
F6 = 8
F7 = 13
F8 = 21
F9 = 34
F10 = 55
F11 = 89
F12 = 144

Il dodicesimo termine, F12, è il primo termine a contenere tre cifre.

Qual è l'indice del primo termine nella sequenza di Fibonacci per contenere 1000 cifre?
============================================================================

Funzione per calcolare i numeri di Fibonacci:

(define (fibo-i n)
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 (- n 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

(fibo-i 12)
;-> 144

(define (e025)
  (local (trovato num)
    (setq num 1)
    (while (not trovato)
      ; maggiore di 1000 (non 999), perchè i big integer finiscono con L
      (if (> (length (string (fibo-i num))) 1000)
        (setq trovato true)
      )
      (++ num)
    )
    (-- num)
  )
)

(e025)
;-> 4782

(time (e025))
;-> 4925.875


===========
Problema 26
===========

Periodo dei numeri reciproci

Una frazione unitaria contiene 1 nel numeratore. La rappresentazione decimale delle frazioni unitarie con i denominatori da 2 a 10 è data:

1/2 =  0.5
1/3 =  0. (3)
1/4 =  0.25
1/5 =  0.2
1/6 =  0.1 (6)
1/7 =  0. (142857)
1/8 =  0.125
1/9 =  0. (1)
1/10 = 0.1

Dove 0.1 (6) significa 0.166666 ... e ha un ciclo ricorrente di 1 cifra. Si può vedere che 1/7 ha un ciclo ricorrente di 6 cifre.

Trova il valore di d <1000 per cui 1 / d contiene il ciclo ricorrente più lungo nella sua parte della frazione decimale.
============================================================================

Calcoliamo i resti della divisione, quando troviamo lo stesso resto per la seconda volta, allora abbiamo trovato un ciclo (se il rsto è diverso da zero.
La lunghezza del ciclo è uguale alla distanza in cui si trovano i due valori uguali di resto.

Esempio: 1/14

(% 1 14)
;-> 1
(% 10 14)
;-> 10
(% 100 14)
;-> 2
(% 1000 14)
;-> 6
(% 10000 14)
;-> 4
(% 100000 14)
;-> 12
(% 1000000 14)
;-> 8
(% 10000000 14)
;-> 10 ; il numero 10 è stato già trovato ==> stop

La lista vale: (1 10 2 6 4 12 8 10)

La distanza tra i due numeri 10 è la differenza tra gli indici: 7 - 1 = 6.
Se i due numeri uguali del resto valgono 0, allora il reciproco non ha cicli.

Adesso possiamo scrivere la funzione che calcola la lunghezza del ciclo del reciproco di un numero:

(define (ciclo n)
  (local (trovato lst resto len-ciclo idx)
    (setq lst '())
    (setq pot 1)
    (while (not trovato)
      (setq resto (% pot n))
      (if (= (find resto lst) nil ) (push resto lst -1)
          (begin
            (setq trovato true)
            (push resto lst -1)
            (setq idx (ref-all resto lst))
            (setq len-ciclo (- (first (last idx)) (first (first idx))))
          )
      )
      (setq pot (* 10L pot))
      ;(println pot)
    )
    ;se i numeri uguali del resto valgono 0, allora il ciclo vale 0.
    (if (= resto 0) (setq len-ciclo 0))
    ;(list len-ciclo lst (div 1 n))
    (list len-ciclo (div 1 n))
  )
)

(ciclo 14)
;-> (6 (1 10 2 6 4 12 8 10) 0.07142857142857143)

(ciclo 7)
;-> (6 (1 3 2 6 4 5 1) 0.1428571428571429)

(ciclo 2)
;-> (0 0.5)

(ciclo 3)
;-> (1 0.3333333333333333)

(ciclo 983)
;-> (982 0.001017293997965412)

(define (e026)
  (local (num maxciclo)
    (setq maxciclo 0)
    (for (i 1 1000)
      (setq c (ciclo i))
      (if (> c maxciclo)
        (setq maxciclo c num i)
      )
    )
    (list num maxciclo)
  )
)

(e026)
;-> (983 (982 0.001017293997965412))

(time (e026))
;-> 488.049


===========
Problema 27
===========

Eulero scoprì la notevole formula quadratica:  n^2 + n + 41

La formula produce 40 numeri primi per i valori interi consecutivi 0≤n≤39. Tuttavia, quando n = 40, 40^2 + 40 + 41 = 40 (40 + 1) + 41 è divisibile per 41, e certamente quando n = 41, 41^2 + 41 + 41 è chiaramente divisibile per 41.

È stata scoperta l'incredibile formula n^2 - 79n + 1601, che produce 80 numeri primi per i valori consecutivi 0≤n≤79. Il prodotto dei coefficienti, -79 e 1601, è -126479.

Considerando forme quadratiche del tipo:

n^2 + a*n + b, dove |a| < 1000 e |b| ≤ 1000

dove |n| è il valore assoluto di n

Per esempio: |11| = 11 e |-4| = 4

Trova il prodotto dei coefficienti, a e b, per l'espressione quadratica che produce il numero massimo di numeri primi per valori consecutivi di n, iniziando con n = 0.
============================================================================

(define (primo? n)
  (if (= n 2) true
      (if (even? n) nil
          (if (< n 2) nil
              (= 1 (length (factor n)))))))

(define (e027)
  (local (aa bb num min_a max_a min_b max_b max_len primo lst)
    (setq min_a -999)
    (setq max_a 999)
    (setq min_b -1000)
    (setq max_b 1000)
    (for (a min_a max_a)
      (for (b min_b max_b)
        (setq primo true)
        (setq lst '())
        (setq num 0)
        (while primo
          (if (primo? (add (mul num num) (mul a num) b))
            (begin
              (push num lst)
              (if (> (length lst) max_len)
                (begin
                  (setq max_len (length lst))
                  (setq aa a)
                  (setq bb b)
                )
              )
              (++ num)
            )
          ;else
            (setq primo nil)
          );if
        );while
      );for
    );for
    (list (* aa bb) aa bb max_len)
  );local
)

(e027)
;-> (-59231 -61 971 71)

(time (e027))
;-> 2000.151

Proviamo a ricercare in un intervallo più grande (-10000 10000):

(define (test27 min_a max_a min_b max_b)
  (local (aa bb num max_len primo lst)
    (for (a min_a max_a)
      (for (b min_b max_b)
        (setq primo true)
        (setq lst '())
        (setq num 0)
        (while primo
          (if (primo? (add (mul num num) (mul a num) b))
            (begin
              (push num lst)
              (if (> (length lst) max_len)
                (begin
                  (setq max_len (length lst))
                  (setq aa a)
                  (setq bb b)
                )
              )
              (++ num)
            )
          ;else
            (setq primo nil)
          );if
        );while
      );for
    );for
    (list aa bb max_len)
  );local
)

(test27 -10000 10000 -10000 10000)
;-> (-79 1601 80)

Abbiamo trovato l'equazione presentata come esempio nel problema.

Facciamo un controllo:

(define (f n)
  (primo? (+ (* n n) (* (- 79) n) 1601)))

(f 2)

(count '(true) (map f (sequence 0 79)))
;-> (80)

(define (f1 n)
  (list (primo? (+ (* n n) (* (- 79) n) 1601)) (+ (* n n) (* (- 79) n) 1601)))

Proviamo ad eliminare la lista dei numeri primi ed usare solo un contatore per cercare di migliorare la velocità di esecuzione:

(define (e027-2)
  (local (aa bb num min_a max_a min_b max_b max_len primo lst_len)
    (setq min_a -999)
    (setq max_a 999)
    (setq min_b -1000)
    (setq max_b 1000)
    (for (a min_a max_a)
      (for (b min_b max_b)
        (setq primo true)
        (setq lst_len 0)
        (setq num 0)
        (while primo
          (if (primo? (add (mul num num) (mul a num) b))
            (begin
              (++ lst_len)
              (if (> lst_len max_len)
                (begin
                  (setq max_len lst_len)
                  (setq aa a)
                  (setq bb b)
                )
              )
              (++ num)
            )
          ;else
            (setq primo nil)
          );if
        );while
      );for
    );for
    (list (* aa bb) aa bb max_len)
  );local
)

(e027-2)
;-> (-59231 -61 971 71)

(time (e027-2))
;-> 2015.211

Non abbiamo migliorato, sembra che il tempo dipenda quasi esclusivamente dai due cicli for :-)


===========
Problema 28
===========

Diagonale di numeri a spirale

Partendo dal numero 1 e spostandosi verso destra in senso orario, si forma una spirale 5 per 5 come segue:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

Si può verificare che la somma dei numeri sulle diagonali sia 101:
(21 + 7 + 1 + 3 + 13 + 25 + 9 + 5 + 17) = 101 (l'elemento centrale (1) viene contato solo una volta).

Qual è la somma dei numeri sulle diagonali in una spirale 1001 per 1001 formata nello stesso modo?
============================================================================

Disegniamo una matrice più grande per poter individuare una funzione che possa generarer i valori dei numeri sulla diagonale in funzione della grandezza della matrice:

 73                      81
    43                49
       21 22 23 24 25
       20  7  8  9 10
       19  6  1  2 11
       18  5  4  3 12
       17 16 15 14 13
    37                31
 65                      57

(define (e028)
  (local (m somma a_d b_d b_s a_s alto_dx basso_dx basso_sx alto_sx)
    (setq m 1001)
    (setq somma 0)
    (setq a_d '())
    (setq b_d '())
    (setq a_s '())
    (setq b_s '())
    (for (i 1 (/ (- m 1) 2))
      (setq alto_dx (* (+ (* i 2) 1) (+ (* i 2) 1)))
      (setq basso_dx (- alto_dx (* 6 i)))
      (setq basso_sx (- alto_dx (* 4 i)))
      (setq alto_sx (- alto_dx (* 2 i)))
      ;(println alto_dx { } alto_sx { } basso_sx { } basso_dx)
      (push alto_dx a_d)
      (push basso_dx b_d)
      (push basso_sx b_s)
      (push alto_sx a_s)
    )
    (setq somma (+ (apply + a_d) (apply + a_s) (apply + b_d) (apply + b_s) 1))
  )
)

Con m = 5 e con l'espressione print attiva, otteniamo:

;-> 9 7 5 3
;-> 25 21 17 13
;-> 101

(e028)
;-> 669171001

(time (e028))
;-> 0


===========
Problema 29
===========

Potenze distinte

Considerare tutte le combinazioni intere di ab per 2 ≤ a ≤ 5 e 2 ≤ b ≤ 5:

2^2 = 4,  2^3 = 8,   2^4 = 16,  2^5 = 32
3^2 = 9,  3^3 = 27,  3^4 = 81,  3^5 = 243
4^2 = 16, 4^3 = 64,  4^4 = 256, 4^5 = 1024
5^2 = 25, 5^3 = 125, 5^4 = 625, 5^5 = 3125

Se vengono quindi posizionati in ordine numerico, con le eventuali ripetizioni rimosse, otteniamo la seguente sequenza di 15 termini distinti:

4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125

Quanti termini distinti sono nella sequenza generata da a^b per 2 ≤ a ≤ 100 e 2 ≤ b ≤ 100?
============================================================================

(define (potenza n m)
  (setq pot 1L)
  (dotimes (x m)
    (setq pot (* pot n))
  )
)

(define (e029)
  ;(local (a b lst)
  (local (a b)
    (setq lst '())
    (for (a 2 100)
      (for (b 2 100)
        (push (potenza a b) lst)
      )
    )
    (setq lst (unique lst))
    (length lst)
  )
)

(e029)
;-> 9183

(time (e029))
;-> 140.608


===========
Problema 30
===========

Quinta potenza delle cifre

Sorprendentemente ci sono solo tre numeri che possono essere scritti come la somma delle quarte potenze delle loro cifre:

1634 = 1^4 + 6^4 + 3^4 + 4^4
8208 = 8^4 + 2^4 + 0^4 + 8^4
9474 = 9^4 + 4^4 + 7^4 + 4^4

La somma di questi numeri è 1634 + 8208 + 9474 = 19316.

Il numero 1 = 1^4 non viene incluso perchè non è una somma.

Trova la somma di tutti i numeri che possono essere scritti come somma delle quinte potenze delle loro cifre.
============================================================================

Funzione che estrae le cifre di un numero da sinistra verso destra:

(define (estraiCifre n)
  (local (cifra)
    (while (!= n 0)
      (setq cifra (% n 10))
      (setq n (/ n 10))
      (print cifra { })
    )
  )
)

(estraiCifre 1234)
;-> 4 3 2 1 " "

Precalcoliamo la quinta potenza di ogni cifra:

(setq pot5 (map (fn (x) (pow x 5)) '(0 1 2 3 4 5 6 7 8 9)))
;-> (0 1 32 243 1024 3125 7776 16807 32768 59049)

Funzione che calcola la somma delle quinte potenze di tutte le cifre di un numero:

(define (pot5Cifre n)
  (local (cifra somma)
    (setq somma 0)
    (while (!= n 0)
      (setq cifra (% n 10))
      (setq somma (+ somma (pot5 cifra)))
      (setq n (/ n 10))
    )
    somma
  )
)

(pot5Cifre 1634)
;-> 9044

Limite superiore:
max numero con 1 cifra = 9^5 = 56049
max numero con 2 cifre = 9^5 + 9^5 = 118098
max numero con 3 cifre = 9^5 + 9^5 + 9^5 = 177147
max numero con 4 cifre = 9^5 + 9^5 + 9^5 + 9^5 = 236196
max numero con 5 cifre = 9^5 + 9^5 + 9^5 + 9^5 + 9^5 = 295245
max numero con 6 cifre = 9^5 + 9^5 + 9^5 + 9^5 + 9^5 + 9^5 = 354294
max numero con 7 cifre = 9^5 + 9^5 + 9^5 + 9^5 + 9^5 + 9^5 + 9^5 = 413343

Quindi per essere sicuri di considerare tutti i numeri di cinque cifre formati dalla somma delle quinte potenze di ogni cifra occorre prendere il numero 295245 (perchè questo numero ha 6 cifre).

(* 5 (pow 9 5))
;-> 295245

(define (e030)
  (local (maxVal tot)
    (setq maxVal 295245)
    (setq tot 0)
    (for (i 2 maxVal)
      (setq x (pot5Cifre i))
      (if (= x i) (setq tot (+ tot x)))
    )
    tot
  )
)

(e030)
;-> 443839

(time (e030))
;-> 515.564


===========
Problema 31
===========

Somme di monete

In Inghilterra la moneta è composta da sterline "£" e pence "p" e ci sono in circolazione otto tipi di monete:

1p, 2p, 5p, 10p, 20p, 50p, £ 1 (100p) e £ 2 (200p)

È possibile arrivare a £ 2 nel modo seguente:

1 × £ 1 + 1 × 50p + 2 × 20p + 1 × 5p + 1 × 2p + 3 × 1p

In quanti modi diversi si può arrivare a £ 2 usando un numero qualsiasi di monete?
============================================================================

Soluzione forza-bruta:

(define (e031)
  (local (A B C D E F G q tot)
    (setq A (sequence 0 200))
    (setq B (sequence 0 200 2))
    (setq C (sequence 0 200 5))
    (setq D (sequence 0 200 10))
    (setq E (sequence 0 200 20))
    (setq F (sequence 0 200 50))
    (setq G (sequence 0 200 100))
    (setq q 1)
    (setq tot 200)
    (dolist (a A)
      (dolist (b B (> (+ a b) tot))
        (dolist (c C (> (+ a b c) tot))
          (dolist (d D (> (+ a b c d) tot))
            (dolist (e E (> (+ a b c d e) tot))
              (dolist (f F (> (+ a b c d e f) tot))
                (dolist (g G)
                  (if (= (+ a b c d e f g) tot) (++ q))
    )))))))
    q
  );local
)

(e031)
;-> 73682

(time (e031))
;-> 3009.901

Soluzione programmazione dinamica:

(define (e031)
  (local (totale monete modi)
    ; valore obiettivo
    (setq totale 200)
    ; lista dei tagli di monete disponibili
    (setq monete '(1 2 5 10 20 50 100 200))
    ; crea un vettore di totale elementi con tutti valori 0 tranne il primo (modi[0]) che vale 1
    (setq modi (array (+ totale 1) (extend '(1) (dup 0 totale))))
    (dolist (el monete)
      (for (i el totale)
        (setq (modi i) (+ (modi i) (modi (- i el))))
      )
    )
    (modi totale)
  )
)

(e031)
;-> 73682

(time (e031))
;-> 0.971


===========
Problema 32
===========

Prodotti Pandigitali

Diciamo che un numero con n cifre è pandigitale se fa uso di tutte le cifre da 1 a n esattamente una volta. Ad esempio, il numero a 5 cifre, 15234, è pandigitale da 1 a 5.

Il prodotto 7254 è inusuale, poiché l'identità 39 × 186 = 7254, contenente moltiplicando, moltiplicatore e prodotto è pandigitale da 1 a 9.

Trovare la somma di tutti i prodotti la cui identità in moltiplicando/moltiplicatore/prodotto è pandigitale da 1 a 9.

SUGGERIMENTO: alcuni prodotti possono essere ottenuti in più di un modo, quindi assicurati di includerlo solo una volta nella somma.
============================================================================

La seguente funzione verifica se un numero è pandigitale (1-9):

(define (pan? n)
  (cond ((or (< n 123456789) (> n 987654321) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 -1 -1 -1 -1 -1 -1 -1 -1 -1))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            ;(println lst)
            (if (ref '-1 lst) nil true)
          )
        )
  )
)


(pan? 391867254)
;-> true

(pan? 391877254)
;-> nil

Calcoliamo i limiti dei numeri coinvolti:

(* 999 99)
;-> 98901

(* 9999 9)
;-> 89991

999 * 99 = 98901 => 10 cifre (moltiplicando/moltiplicatore/prodotto)
9999 * 9 = 89991 => 10 cifre (moltiplicando/moltiplicatore/prodotto)

Quindi, il massimo valore del primo indice vale 99 e il massimo valore del secondo indice 9999. Si tratta di una stima grossolana che potrebbe essere migliorata.

Possiamo scrivere la soluzione:

(define (e032)
  (local (somma sol p)
    (setq sol '())
    (for (i 1 99)
      (for (j (+ i 1) 9999)
        (setq p (int (string i j (* i j))))
        (if (pan? p) (push (* i j) sol))
        ;(if (pan? p) (begin (push (* i j) sol) (println i { * } j { = } (* i j))))
      )
    )
    (setq sol (unique sol))
    (apply + sol)
  )
)

(e032)
;-> 45228

(time (e032))
;-> 1625.291

Ecco tutti i prodotti pandigitali:

 4 * 1738 = 6952
 4 * 1963 = 7852
12 *  483 = 5796 (a)
18 *  297 = 5346 (b)
27 *  198 = 5346 (b)
28 *  157 = 4396
39 *  186 = 7254
42 *  138 = 5796 (a)
48 *  159 = 7632


(+ 6952 7852 5796 5346 4396 7254 7632)
;-> 45228

===========
Problema 33
===========

Cancellazione di cifre nelle frazioni

La frazione 49/98 è una frazione curiosa, poiché un matematico inesperto nel tentativo di semplificarlo potrebbe erroneamente credere che 49/98 = 4/8, che è corretto, si ottiene cancellando le due cifre 9.

Considereremo frazioni come, 30/50 = 3/5, come esempi banali.

Esistono esattamente quattro esempi non banali di questo tipo di frazione, che hanno valore minore di 1, e contenenti due cifre nel numeratore e nel denominatore.

Se il prodotto di queste quattro frazioni viene ridotto ai minimi termini (semplificato), trovare il valore del denominatore.
============================================================================

Funzione che converte un numero intero in una lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

La soluzione con la forza bruta è abbastanza semplice (e anche veloce):

(define (e033)
  (local (fraction frazione N D num numL den denL d d1 d2 n n1 n2 val)
    (setq fraction '())
    (for (num 11 100)
      (for (den (+ num 1) 100)
        (setq val (div num den))
        (setq frazione 0)
        (setq denL (int2list den))
        (setq d1 (int (denL 0)))
        (setq d2 (int (denL 1)))
        (setq numL (int2list num))
        (setq n1 (int (numL 0)))
        (setq n2 (int (numL 1)))
        (cond ((and (= n1 d2) (!= d1 0))
               (setq frazione (div n2 d1))
               (setq n n2)
               (setq d d1)
              )
              ((and (= n2 d1) (!= d2 0))
               (setq frazione (div n1 d2))
              )
              ((and (= n1 d1) (!= d2 0))
               (setq frazione (div n2 d2))
              )
              ((and (= n2 d2) (!= n2 0) (!= d1 0))
               (setq frazione (div n1 d1))
              )
        )
        (if (= frazione val) (push (list num den) fraction))
      )
    )
    (println fraction)
    (setq N (apply * (map first f)))
    (setq D (apply * (map last f)))
    (div D (gcd N D))
  );local
)

(e033)
;-> ((49 98) (26 65) (19 95) (16 64))
;-> 100

(time (e033))
;-> 31.235

Le quattro frazioni sono: 16/64 (1/4), 26/65 (2/5), 19/95 (1/5) e 49/98 (4/8).

Anche in questo problema possiamo utilizzare la matematica per trovare un algoritmo migliore.
Si può dimostrare che ogni frazione della soluzione deve essere della forma:

10*n + i    n
-------- = ---
10*i + d    d

dove numeratore "n" e denominatore "d" soddisfano la relazione: 1 <= n < d <= 9
e la variabile da eliminare "i" soddisfa la relazione: 1 <= i <= 9

Per evitare di utilizzare divisoni, troveremo le soluzioni verificando se vale l'uguaglianza:

d*(10*n + i) = n*(10*i + d)

(define (e033)
  (local (den num numtot dentot)
    (setq numtot 1 dentot 1)
    (for (i 1 9)
      (setq den 1)
      (while (< den i)
        (setq num 1)
        (while (< num den)
          (if (= (* den (+ (* num 10) i)) (* num (+ (* 10 i) den)))
            (begin
              (setq dentot (* dentot den))
              (setq numtot (* numtot num))
              ;(println num i {/} i den)
            )
          )
          (++ num)
        )
        (++ den)
      )
    )
    (/ dentot (gcd numtot dentot))
  )
)

(e033)
;-> 100

(time (e033))
;-> 0


===========
Problema 34
===========

Cifre fattoriali

145 è un numero curioso, poichè 1! + 4! + 5! = 1 + 24 + 120 = 145.

Trovare la somma di tutti i numeri che sono uguali alla somma del fattoriale delle loro cifre.

Nota: poichè 1! = 1 e 2! = 2 non sono somme, allora non vengono inclusi.
============================================================================

Precalcoliamo il fattoriale delle cifre 0..9:

(define (fact n) (if (= n 0) 1 (apply * (sequence 1 n))))

(setq fact-lst (map (fn(n) (fact n)) (sequence 0 9)))
;-> (1 1 2 6 24 120 720 5040 40320 362880)

Limiti dei numeri
Il numero 3 potrebbe andar bene, ma poiché il fattoriale di un numero di una cifra - eccetto 3 - ha sempre più di una cifra, allora possiamo iniziare con 10.
Il calcolo del limite superiore è un pò più complicato.
Se prendiamo un numero n con "d" cifre, possiamo scrivere:

 10^(d-1) <= n < 10^d

Per formare il numero massimo di "d" cifre dobbiamo utilizzare tutti 9, e la somma delle sue cifre fattoriali sarebbe d*9!, quindi:

 10^(d-1) <= d*9! < 10^d

Provando alcuni valori di "d" notiamo che 9!*7 = 2540160. Non esiste un valore più alto, poiché sia 9!*8 che 9!*9 generano ugualmente numeri di 7 cifre (9!*8 = 2903040, 9!*93265920). Quindi il numero 9999999 genera 7*9! = 2540160.

(define (e034)
  (local (fact-lst somma sol n)
    (setq fact-lst '(1 1 2 6 24 120 720 5040 40320 362880))
    (setq sol '())
    (for (i 10 2540160)
      (setq somma 0)
      (setq n i)
      (while (!= n 0)
        (setq somma (+ somma (fact-lst (% n 10))))
        (setq n (/ n 10))
      )
      (if (= somma i) (push i sol))
    )
    (list (apply + sol) sol)
  )
)

(e034)
;-> (40730 (40585 145))

(time (e034))
;-> 3797.395


===========
Problema 35
===========

Numeri primi circolari

Il numero, 197, è chiamato primo circolare perché tutte le rotazioni delle cifre: 197, 971 e 719, sono esse stesse prime.

Ci sono tredici tali numeri primi sotto 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79 e 97.

Quanti numeri primi circolari ci sono sotto un milione?
============================================================================

Abbiamo bisogno delle seguenti funzioni ausiliarie:

Verifica se un numero è primo:

(define (primo? n)
  (if (= n 2) true
      (if (even? n) nil
          (if (< n 2) nil
              (= 1 (length (factor n)))))))

Converte un numero intero in una lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

Converte una lista in un numero intero:

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

Crea una lista con tutte le rotazioni della lista passata:

(define (creaRotate lst)
  (let (out '())
    ;(for (i 1 (- (length lst) 1))
    (for (i 1 (length lst))
      (push (rotate lst) out)
    )
    out
  )
)

(creaRotate '(2))
;-> ((2))

(creaRotate '(1 2 3))
;-> ((1 2 3) (2 3 1) (3 1 2))

Adesso definiamo la funzione che risolve il problema:

(define (e035)
  (local (primicirco candidate stop k)
    (setq primicirco '(2)) ;lista risultato
    (setq candidate '())   ;lista rotazioni
    (for (i 3 999999 2)    ;solo numeri pari
      (if (primo? i)
        (begin
          ; creiamo la lista di tutti numeri ruotati del numero i
          (setq candidate (creaRotate (int2list i)))
          (setq stop nil)
          (setq k 0)
          (while (and (< k (length candidate)) (= stop nil))
            (if (!= k 0) ;il primo numero è sempre primo
              ;stop quando un numero della lista candidati non è primo
              (if (not (primo? (list2int (candidate k)))) (setq stop true))
            )
            (++ k)
          )
          ; se tutti i numeri nella lista candidati sono primi
          ; aggiungiamo la lista al risultato
          (if (= stop nil) (push (list2int (candidate (- k 1))) primicirco))
        )
      );if
    );for
    (list (length primicirco) primicirco)
  );local
)

(e035)
;-> (55 (199933 999331 193939 393919 993319 391939 939391 939193 933199 331999 319993
;->      919393 19937 19391 99371 39119 37199 93911 93719 71993 11939 91193 7937 1931 7793
;->      3779 9377 9311 1193 3119 199 197 991 373 971 337 733 131 919 719 113 311 79 97
;->      37 17 73 13 71 31 11 7 5 3 2))

(time (e035))
;-> 1266.715


===========
Problema 36
===========

Palindromi a doppia base

Il numero decimale, 585 = 10010010012 (binario), è palindromo in entrambe le basi.

Trova la somma di tutti i numeri, sotto al milione, che sono palindromi in base 10 e in base 2.

(Si noti che il numero palindromo, in entrambe le basi, non include gli zeri iniziali.)
============================================================================

Funzioni ausiliarie

Questa funzione controlla se un numero è palindromo:

(define (paliN n)
  (= (string n) (reverse (string n))))

(paliN 113311)
;-> true

(paliN 1123311)
;-> nil

Questa funzione controlla se una stringa è palindroma:

(define (paliS s)
  (= s (reverse (copy s))))

(paliS "1234321")
;-> true

(paliS "51234321")
;-> nil

Nota: I numeri pari non sono mai palindromi in base 2, perchè il bit a destra vale sempre 0 e il bit a sinistra vale sempre 1.

Nota: per controllare se un numero in base 2 è palindromo occorre utilizzare una stringa per rappresentarlo, perchè altrimenti il numero dovrebbe essere un big integer (con L alla fine).

La funzione finale è la seguente:

(define (e036)
  (let (somma 0)
    (for (i 1 999999 2) ;nessun numero pari palindromo in base 2
      (if (and (paliN i) (paliS (bits i)))
        (begin
          (setq somma (+ somma i))
          ;(println i { - } (bits i))
        )
      )
    )
    somma
  )
)

(e036)
;-> 872187

(time (e036))
;-> 1442.523

I numeri palindromi in entrambe le basi sono:

1 - 1
3 - 11
5 - 101
7 - 111
9 - 1001
33 - 100001
99 - 1100011
313 - 100111001
585 - 1001001001
717 - 1011001101
7447 - 1110100010111
9009 - 10001100110001
15351 - 11101111110111
32223 - 111110111011111
39993 - 1001110000111001
53235 - 1100111111110011
53835 - 1101001001001011
73737 - 10010000000001001
585585 - 10001110111101110001


===========
Problema 37
===========

Numeri primi troncabili

Il numero 3797 ha una proprietà interessante. Essendo primo se stesso, è possibile rimuovere continuamente i numeri da sinistra a destra, e rimanere primo in ogni fase: 3797, 797, 97 e 7. Allo stesso modo possiamo lavorare da destra a sinistra: 3797, 379, 37 e 3.

Trova la somma degli unici undici numeri primi che sono entrambi troncabili da sinistra a destra e da destra a sinistra.

NOTA: 2, 3, 5 e 7 non sono considerati numeri primi troncabili.
============================================================================

(define (creaTruncate lst)
  (let (out '())
    ; da destra
    (for (i 1 (- (length lst) 1))
      (push (slice lst 0 i) out)
    )
    ; da sinistra
    (for (i 1 (- (length lst) 1))
      (push (slice lst i) out)
    )
    out
  )
)

(setq lst '(3 7 9 7))

(creaTruncate lst)
;-> ((7) (9 7) (7 9 7) (3 7 9) (3 7) (3))

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

(define (primo? n)
  (if (= n 2) true
      (if (even? n) nil
          (if (< n 2) nil
              (= 1 (length (factor n)))))))

(define (e037)
  (local (primitrunca candidate trovati stop k i)
    (setq primitrunca '()) ;lista risultato
    (setq candidate '())   ;lista troncati
    (setq trovati 0)
    (setq i 11)
    (while (< trovati 11)
      (if (primo? i)
        (begin
          (setq candidate (creaTruncate (int2list i)))
          (setq stop nil)
          (setq k 0)
          (while (and (< k (length candidate)) (= stop nil))
            (if (not (primo? (list2int (candidate k)))) (setq stop true))
            (++ k)
          )
          (if (= stop nil)
            (begin
              ;(push (list2int (candidate (- k 1))) primitrunca)
              (push i primitrunca)
              (++ trovati)
            )
          )
        )
      );if
      (setq i (+ i 2))
      (if (= 0 (% i 10000)) (println i))
    );while
    (list (apply + primitrunca) primitrunca)
  );local
)

(e037)
;-> (748317 (739397 3797 3137 797 373 317 313 73 53 37 23))

(time (e037))
;-> 939.055

Proviamo a velocizzare l'algoritmo della funzione.
Considerazioni:
- non abbiamo bisogno di una lista per il risultato: basta usare una variabile (somma).
- non abbiamo bisogno di una lista per i numeri troncati: possiamo testarli appena generati.

Definiamo una funzione che controlla se un numero è truncabile a sinistra:

(define (truncaSX n)
  (local (i stop)
    (setq i 10)
    (while (and (<= i n) (= stop nil))
      (if (not (primo? (% n i))) (setq stop true))
      (setq i (* i 10))
    )
    (not stop)
  )
)

(truncaSX 3797)
;-> true

Definiamo una funzione che controlla se un numero è truncabile a destra:

(define (truncaDX n)
  (local (i stop)
    (setq i n)
    (while (and (!= 0 i) (= stop nil))
      (if (not (primo? i)) (setq stop true))
      (setq i (/ i 10))
    )
    (not stop)
  )
)

(truncaDX 3797)
;-> true

(define (e037)
  (local (trovati somma i)
    (setq somma 0)
    (setq i 11)
    (while (< trovati 11)
      (if (and (truncaDX i) (truncaSX i))
        (begin
          (setq somma (+ somma i))
          (++ trovati)
        )
      )
      (setq i (+ i 2))
    )
    somma
  )
)

(e037)
;-> 748317

(time (e037))
;-> 778.216


===========
Problema 38
===========

Multiplicazioni pandigitali

Prendi il numero 192 e moltiplicalo per i numeri 1, 2 e 3:

192 × 1 = 192
192 × 2 = 384
192 × 3 = 576

Concatenando ogni prodotto otteniamo il numero pandigitale da 1 a 9, 192384576. Chiameremo 192384576 il prodotto concatenato di 192 e (1,2,3)

Lo stesso può essere ottenuto iniziando con 9 e moltiplicando per 1, 2, 3, 4 e 5, che genera il pandigitale, 918273645, che è il prodotto concatenato di 9 e (1,2,3,4,5).

Qual è il più grande numero pandigitale da 1 a 9 (9 cifre) che può essere formato come prodotto concatenato di un numero intero con (1,2, ..., n) dove n > 1?
============================================================================

(define (pan? n)
  (cond ((or (< n 123456789) (> n 987654321) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 -1 -1 -1 -1 -1 -1 -1 -1 -1))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            ;(println lst)
            (if (ref '-1 lst) nil true)
          )
        )
  )
)

Per calcolare il limite superiore del ciclo basta considerare che con 10000 arriviamo a considerare numeri con 10 cifre (dobbiamo concatenare le stringhe delle moltiplicazioni), quindi questo valore è sufficiente.

(define (lim n)
  (length (append (string (* n 1)) (string (* n 2))))
)

(lim 9999)
;-> 9

(lim 10000)
;-> 10

(define (e038)
  (local (maxpandi theK theI pandisomma)
    (setq maxpandi 0)
    (setq theK 0)
    (setq theI 0)
    (for (k 1 10000)
      (setq pandisomma "")
      (for (i 1 9)
        (extend pandisomma (string (* k i)))
        (if (and (= (length pandisomma) 9) (> (int pandisomma) maxpandi) (pan? (int pandisomma)))
          (begin
            (setq maxpandi (int pandisomma))
            (setq theK k)
            (setq theI i)
          )
        )
      )
    )
    (list maxpandi theK theI)
  );local
)

(e038)
;-> (932718654 9327 2)

str(9327*1) + str(9327*2) = "932718654"

(time (e038))
;-> 93.757


===========
Problema 39
===========

Triangoli rettangoli interi

Se p è il perimetro di un triangolo rettangolo con lati di lunghezza intera, {a, b, c}, ci sono esattamente tre soluzioni per p = 120.

{20,48,52}, {24,45,51}, {30,40,50}

Per quale valore di p ≤ 1000, il numero di soluzioni è massimizzato?
============================================================================

(define (e039)
  (local (qmax lst a b p q)
    (setq qmax 0)
    (setq lst '())
    (for (p 12 1000 2)
      (setq q 0)
      (setq a 1)
      (while (< a (/ p 3))
        (setq b (+ a 1))
        (setq stop nil)
        (while (and (= stop nil) (< b (- p a)))
          (if (= (pow (- p a b) 2) (+ (* a a) (* b b)))
            (begin
              (++ q)
              (setq stop true)
            )
          )
          (++ b)
        )
        (++ a)
      )
      (if (> q qmax)
        (begin
          (setq lst (list p q))
          (setq qmax q)
        )
      )
    )
    lst
  );local
)

(e039)
;-> (840 8)

(time (e039))
;-> 13485.51


===========
Problema 40
===========

La costante di Champernowne

Una frazione decimale irrazionale viene creata concatenando gli interi positivi:

0.12345678910(1)112131415161718192021 ...

Si può vedere che la dodicesima cifra della parte frazionaria è (1).

Se d(n) rappresenta l'ennesima cifra della parte frazionaria, trovare il valore della seguente espressione:

d(1) × d(10) × d(100) × d(1000) × d(10000) × d(100000) × d(1000000)
============================================================================

La lunghezza della costante di Champernowne supera (di poco) il milione quando si arriva a concatenare il numero 186000:

(length (join (map string (sequence 0 186000))))
;-> 1004896

Quindi usiamo questo valore come limite per la creazione delle cifre del risultato:

(define (e040)
  (local (num cifre val x stop sol)
    (setq lst '())
    (setq stop nil)
    (setq num 1)
    (while (and (< num 186000) (= stop nil))
      (setq cifre (length (string num)))
      (setq val num)
      (for (i cifre 1 -1)
        (setq x (/ val (pow 10 (- i 1))))
        (setq val (- val (* x (pow 10 (- i 1)))))
        (push x lst -1)
      )
      ;(if (> (length lst) 1000000) (setq stop true))
      (++ num)
      ;(if (= (% num 10000) 0) (println num { } (length lst)))
    )
    (* (lst 0) (lst 9) (lst 99) (lst 999) (lst 9999) (lst 99999) (lst 999999))
  )
)

(e040)
;-> 210

(time (e040))
;-> 640.584

Proviamo un altro metodo, creiamo una stringa che contiene almeno 1000000 di cifre e poi calcoliamo il risultato della moltiplicazione:

(define (e040)
  (let (a$ (join (map string (sequence 1 186000))))
    (* (int (a$ 0)) (int (a$ 9)) (int (a$ 99)) (int (a$ 999)) (int (a$ 9999)) (int (a$ 99999)) (int (a$ 999999)))
  )
)

(e040)
;-> 210

(time (e040))
;-> 140.625


===========
Problema 41
===========

Primo Pandigitale

Diremo che un numero a una cifra è pandigitale se fa uso di tutte le cifre da 1 a n esattamente una volta. Ad esempio, 2143 è un pandigitale a 4 cifre ed è anche primo.

Qual è il più grande numero primo pandigitale ad n-cifre esistente?
============================================================================

I numeri pandigitali (0..9), quelli (1..9) e quelli (1..8) non sono primi perchè sono tutti divisibili per 9 (in quanto la somma delle loro cifre vale 9).
Quindi consideriamo solo i numeri pandigitali fino a 7 cifre.

Possiamo iniziare a creare tutte le permutazioni di 7 cifre e cercare il numero primo massimo (se esiste).
Poi potremmo passare ai numeri con 6 cifre, e via di questo passo.

Funzione per le permutazioni:

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

Funzione test numero primo:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Scriviamo la funzione finale:

(define (e041)
  (local (perm num primi)
    ;crea le permutazioni
    (setq perm (permutazioni '("1" "2" "3" "4" "5" "6" "7")))
    ; crea la lista dei numeri
    (setq num (map (fn (x) (int (join x))) perm))
    ;filtra i numeri primi e poi cerca il valore massimo
    (apply max (filter primo? num))
  )
)

(e041)
;-> 7652413

(time (e041))
;-> 125.004


===========
Problema 42
===========

Numeri triangolari codificati

L'ennesimo termine della sequenza di numeri triangolari è dato da, t(n) = ½*n*(n + 1), quindi i primi dieci numeri di triangolari sono:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

Convertendo ogni lettera di una parola in un numero corrispondente alla sua posizione alfabetica e aggiungendo questi valori formiamo un valore della parola. Ad esempio, il valore della parola per SKY è 19 + 11 + 25 = 55 = t10. Se il valore della parola è un numero triangolare, chiameremo la parola triangolo.

Usando il file words.txt, un file di testo 16K contenente quasi duemila parole inglesi comuni, quante sono le parole triangolari?
============================================================================

Il file ha questa struttura:
"A","ABILITY","ABLE","ABOUT","ABOVE","ABSENCE","ABSOLUTELY",...

Rimuoviamo tutti i caratteri doppio-apice "":

(define (remove-char c from-file to-file)
    (set 'in-file (open from-file "read"))
    (set 'out-file (open to-file "write"))
    (while (set 'chr (read-char in-file))
        (if (!= chr c)
          (write-char out-file chr)))
    (close in-file)
    (close out-file)
    "fatto")

(char {"})
;-> 34

(char 34)
;-> "\""

(remove-char 34 "p042_words.txt" "words42.txt")

Il file adesso ha questa struttura:
A,ABILITY,ABLE,ABOUT,ABOVE,ABSENCE,ABSOLUTELY,

MARY,PATRICIA,LINDA,...

Importiamo il file in una lista di stringhe:

(silent (setq parole (parse (read-file "words42.txt") ",")))

Vediamo i primi cinque nomi:

(slice parole 0 5)
;-> ("A" "ABILITY" "ABLE" "ABOUT" "ABOVE")

Calcoliamo la lunghezza della parola più lunga:

(apply max (map length parole))
;-> 14

Il valore massimo di una parola vale 14 volte "Z";
(* 14 26)
;-> 364

Adesso creiamo una lista associativa (association list) tra i caratteri e il numero del relativo ordine:

(setq alfa  '(("A" 1) ("B" 2) ("C" 3) ("D" 4) ("E" 5) ("F" 6) ("G" 7) ("H" 8) ("I" 9) ("J" 10) ("K" 11) ("L" 12) ("M" 13) ("N" 14) ("O" 15) ("P" 16) ("Q" 17) ("R" 18) ("S" 19) ("T" 20) ("U" 21) ("V" 22) ("W" 23) ("X" 24) ("Y" 25) ("Z" 26)))

(lookup '"A" alfa)
;-> 1

Creiamo una lista di numeri triangolari (almeno fino a 364):

(setq tri (map (fn (n) (/ (* n (+ n 1)) 2)) (sequence 1 27)))
;-> (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210 231 253 276 300 325 351 378)

Calcoliamo il valore della parola "ABILITY";

(setq valore 0)
(dolist (el (explode "ABILITY"))
  (setq valore (+ valore (lookup el alfa)))
)

;-> 78
A =  1
B =  2
I =  9
L = 12
I =  9
T = 20
Y = 25
   ----
    78

Vediamo se è un numero triangolare:

(ref 78 tri)
;-> (11)

Si tratta dell'undicesimo numero triangolare (se non fosse triangolare avremmo ottenuto nil dalla funzione "ref")

Possiamo scrivere la funzione finale:

(define (e042)
  (local (alfa tri valore out)
    (setq out 0)
    (setq alfa  '(("A" 1) ("B" 2) ("C" 3) ("D" 4) ("E" 5) ("F" 6) ("G" 7) ("H" 8) ("I" 9) ("J" 10) ("K" 11) ("L" 12) ("M" 13) ("N" 14) ("O" 15) ("P" 16) ("Q" 17) ("R" 18) ("S" 19) ("T" 20) ("U" 21) ("V" 22) ("W" 23) ("X" 24) ("Y" 25) ("Z" 26)))
    (setq tri (map (fn (n) (/ (* n (+ n 1)) 2)) (sequence 1 27)))
    (setq parole (parse (read-file "words42.txt") ","))
    (dolist (parola parole)
      (setq valore 0)
      (dolist (el (explode parola))
        (setq valore (+ valore (lookup el alfa)))
      )
      (if (ref valore tri) (++ out))
    )
    out
  )
)

(e042)
;-> 162

(time (e042))
;-> 31.244


===========
Problema 43
===========

Divisibilità sotto-stringhe

Il numero, 1406357289, è un numero da 0 a 9 pandigitale perché è composto da ciascuna delle cifre da 0 a 9 in un certo ordine, ma ha anche una proprietà di divisibilità della sotto-stringhe piuttosto interessante.

Sia d(1) la prima cifra, d(2) la seconda cifra e così via. In questo modo, notiamo quanto segue:

d(2)d(3)d(4) = 406 è divisibile per 2
d(3)d(4)d(5) = 063 è divisibile per 3
d(4)d(5)d(6) = 635 è divisibile per 5
d(5)d(6)d(7) = 357 è divisibile per 7
d(6)d(7)d(8) = 572 è divisibile per 11
d(7)d(8)d(9) = 728 è divisibile per 13
d(8)d(9)d(10) = 289 è divisibile per 17

Trovare la somma di tutti i numeri pandigital da 0 a 9 con questa proprietà.
============================================================================

Se d(4)d(5)d(6) è divisibile per 5, allora d(6) deve valere 5 (d(5) se zero-based).

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

(define (insert l n e)
  (if (= 0 n)
      (cons e l)
      (cons (first l)
            (insert (rest l) (- n 1) e))))

(define (seq start end)
  (if (= start end)
      (list end)
      (cons start (seq (+ start 1) end))))

(define (permute l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n) (insert p n (first l))) (seq 0 (length p))))
                         (permute (rest l))))))

(define (e043)
  (local (numeri p10 a)
    (setq numeri '())
    (setq p10 (permute '(0 1 2 3 4 6 7 8 9)))
    (dolist (p p10)
      (if (!= (p 0) 0) ;scartare le permutazioni che iniziano con 0
        (begin
          (push 5 p 5) ; p(5) deve valere 5
          (setq n1 (+ (* (p 1) 100) (* (p 2) 10) (p 3)))
          (setq n2 (+ (* (p 2) 100) (* (p 3) 10) (p 4)))
          (setq n3 (+ (* (p 3) 100) (* (p 4) 10) (p 5)))
          (setq n4 (+ (* (p 4) 100) (* (p 5) 10) (p 6)))
          (setq n5 (+ (* (p 5) 100) (* (p 6) 10) (p 7)))
          (setq n6 (+ (* (p 6) 100) (* (p 7) 10) (p 8)))
          (setq n7 (+ (* (p 7) 100) (* (p 8) 10) (p 9)))
          (if (and (= (% n1 2) 0) (= (% n2 3) 0) (= (% n3 5) 0) (= (% n4 7) 0)
                   (= (% n5 11) 0) (= (% n6 13) 0) (= (% n7 17) 0))
              (push (list2int p) numeri)
          )
        )
      )
    )
    (list (apply + numeri) numeri)
  )
)

(e043)
;-> (16695334890 (4130952867 1430952867 4160357289 4106357289 1460357289 1406357289))

(time (e043))
;-> 1748.593


===========
Problema 44
===========

Numeri pentagonali

I numeri pentagonali sono generati dalla formula, P(n) = n*(3n-1)/2. I primi dieci numeri pentagonali sono:

1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...

Si può vedere che P4 + P7 = 22 + 70 = 92 = P8. Tuttavia, la loro differenza, 70 - 22 = 48, non è pentagonale.

Trovare la coppia di numeri pentagonali, P(j) e P(k), per cui la loro somma e differenza sono pentagonali e D = |P(k) - P(j)| è ridotto al minimo: qual è il valore di D?
============================================================================

P(n) n-esimo numero pentagonale
N = numero dato

Affinchè un numero N sia pentagonale deve risultare:

P(n) = N  ==>  (3*n*n - n - 2*N) = 0  ==>  n = (1 + sqrt(24*N + 1))/6

Prima versione:

(define (penta? n)
; molto più veloce che cercare nella lista dei numeri pentagonali
  (let (i (div (add (sqrt (add 1 (mul 24 n))) 1) 6))
    (if (= 0 (sub i (int i))) true nil)
  )
)

Seconda versione (più veloce):

(define (penta? n)
; molto più veloce che cercare nella lista dei numeri pentagonali
  (if (= (mod (div (add (sqrt (+ 1 (mul 24 n))) 1) 6) 1) 0) true nil)
)

(penta? 176)
;-> true

(define (e044)
  (local (n penta stop i j out)
    (setq out nil)
    (setq penta (map (fn (n) (/ (* n (- (* 3 n) 1)) 2)) (sequence 1 10000)))
    (setq stop nil)
    (dolist (i penta (= stop true))
      (dolist (j penta (= stop true))
        (if (and (penta? (+ i j)) (penta? (abs (- i j))))
          (begin
            (setq stop true)
            (setq out (list i j (- j i)))
          )
        )
      )
    )
    out
  )
)

(e044)
;-> (1560090 7042750 5482660)

(time (e044))
;-> 5588.505


===========
Problema 45
===========

Triangolari, pentagonali ed esagonali

I numeri triangolari, pentagonali ed esagonali sono generati dalle seguenti formule:

Triangolari T(n) = n*(n + 1)/2 ==> 1, 3, 6, 10, 15, ...
Pentagonala P(n) = n*(3*n-1)/2 ==> 1, 5, 12, 22, 35, ...
Esagonale   H(n) = n*(2*n-1)   ==> 1, 6, 15, 28, 45, ...

Si può verificare che T(285) = P(165) = H(143) = (40755)

Trovare il prossimo numero triangolare che è anche pentagonale ed esagonale.
============================================================================

(define (tri n) (/ (* n (+ n 1)) 2))
(define (pen n) (/ (* n (- (* 3 n) 1)) 2))
(define (esa n) (* n (- (* 2 n) 1)))

(tri 285)
;-> 40755
(pen 165)
;-> 40755
(esa 143)
;-> 40755

Deve risultare:

t*(t + 1)/2 == p*(3*p-1)/2 == x*(2*x-1)

dove t -> indice triangolari
dove p -> indice pentagonali
dove x -> indice esagonali

La soluzione dell'uguaglianza:

t*(t + 1)/2 == x*(2*x-1)

vale: x = (t + 1)/2, t = 2*x - 1

Per t = 285 otteniamo x = (285 + 1)/2 = 143

Definiamo una funzione che genera l'indice del numero esagonale utilizzando l'indice del numero triangolare:

(define (xidx t) (/ (+ t 1) 2))

(xidx 285)
;-> 143

Vediamo come funziona:

(for (i 285 301 2)
  (println (tri i) { } (esa (xidx i))))
;-> 40755 40755
;-> 41328 41328
;-> 41905 41905
;-> 42486 42486
;-> 43071 43071
;-> 43660 43660
;-> 44253 44253
;-> 44850 44850
;-> 45451 45451

Adesso generiamo le tre sequenze di numeri:

(silent (setq trian (map tri (sequence 0 100000))))
(silent (setq penta (map pen (sequence 0 100000))))
(silent (setq esago (map esa (sequence 0 100000))))

Possiamo scrivere la soluzione controllando per ogni valore dell'indice del numero triangolare se esiste quel valore del numero triangolare nella lista dei numeri pentagonali:

(define (e045)
  (local (stop i)
    (setq i 287)
    (setq stop nil)
    (while (= stop nil)
      (setq x (xx i))
      ;(if (ref (esa x) penta) (begin (println i { } x { } (ref (esa x) penta) { } (esa x)) (setq stop true)))
      (if (ref (tri i) penta) (begin (println i { } x { } (ref (esa x) penta) { } (esa x)) (setq stop true)))
      (if (zero? (% i 1000))  (println i))
      (setq i (+ i 2))
    )
  )
)

(e045)
;-> 55385 27693 (31977) 1533776805

(time (e045))
;-> 19343.289

Possiamo usare la funzione "intersect" di newLISP per trovare il risultato:

(define (e045)
  (local (trian penta esago)
    (setq trian (map tri (sequence 1 100000)))
    (setq penta (map pen (sequence 1 100000)))
    (setq esago (map esa (sequence 1 100000)))
    (intersect (intersect trian penta) esago)
  )
)

(e045)
;-> (1 40755 1533776805)

(time (e045))
;-> 114.465

Questa soluzione è molto più veloce.


===========
Problema 46
===========

L'altra congettura di Goldbach

È stato proposto da Christian Goldbach che ogni numero composito dispari può essere scritto come la somma di un numero primo e due volte un quadrato.

9 = 7 + 2 × 1^2
15 = 7 + 2 × 2^2
21 = 3 + 2 × 3^2
25 = 7 + 2 × 3^2
27 = 19 + 2 × 2^2
33 = 31 + 2 × 1^2

Si scopre che la congettura era falsa.

Qual'è il più piccolo numero composito dispari che non può essere scritto come somma di un numero primo e due volte quadrato?
============================================================================

Per ogni numero dispari x:
- se x è un numero composito (cioè è un numero non primo) ==> non trovato
- per i che va da 1 a (* i i 2) se (x - i * i * 2) è primo ==> non trovato
  altrimenti ==> trovato

Funzione per i numeri primi:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Funzione che controlla se un numero soddisfa la congettura (se il numero è primo non soddisfa la congettura):

(define (check x)
  (local (out i stop limite)
    (cond ((primo? x) (setq out true))
          (true
            (setq i 1)
            (setq stop nil)
            (setq limite (* i i 2))
            (while (and (<= limite x) (= stop nil))
              (if (primo? (- x (* i i 2))) (begin (setq stop true) (setq out true)))
              (++ i)
              (setq limite (* i i 2))
            )
          )
    )
    out
  )
)

Scriviamo la funzione finale:

(define (e046)
  (local (num trovato)
    (setq num 11)
    (setq trovato false)
    (while (= trovato nil)
      (if (= (check num) nil) (setq trovato true))
      (setq num (+ num 2))
    )
    (- num 2)
  )
)


(e046)
;-> 5777

(time (e046))
;-> 31.247


===========
Problema 47
===========

Fattori primi distinti

I primi due numeri consecutivi con due fattori primi distinti sono:

14 = 2 × 7
15 = 3 × 5

I primi tre numeri consecutivi con tre fattori primi distinti sono:

644 = 2² × 7 × 23
645 = 3 × 5 × 43
646 = 2 × 17 × 19.

Trova i primi quattro numeri interi consecutivi con quattro fattori primi distinti ciascuno. Qual è il primo di questi numeri?
============================================================================

Funzione che calcola il numero di fattori primi distitni di un numero:

(define (numFattDist n) (length (unique (factor n))))

(numFattDist 12345)
;-> 3

Possiamo scrivere la funzione finale:

(define (e047)
  (local (stop i)
    (setq i 134043)
    (while (= stop nil)
      (if (and (= (numFattDist i) 4)
               (= (numFattDist (+ i 1)) 4)
               (= (numFattDist (+ i 2)) 4)
               (= (numFattDist (+ i 3)) 4))
          (setq stop true)
      )
      (++ i)
      (if (= (% i 1000000) 0) (println i))
    )
    (-- i)
  )
)

(e047)
;-> 134043

(time (e047))
;-> 0


===========
Problema 48
===========

Auto potenze

La serie, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

Trova le ultime dieci cifre della serie, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
============================================================================

Funzione che calcola la potenza di numeri interi (anche per numeri big integer):

(define (potenza n m)
  (setq pot 1L)
  (dotimes (x m)
    (setq pot (* pot n))
  )
  pot
)

Creiamo una lista con tutti i numeri da 1 a 1000 elevati a se stessi:
(setq a (map (fn (x) (potenza x x)) (sequence 1L 1000L)))

Sommiano tutti i valori della lista:
(setq b (apply + a))

Trasformiano il numero somma in stringa ed estraiamo le ultime 10 cifre (senza la L finale):
(setq c (pop (string b) -11 10))
;-> "9110846700"

Scriviamo la funzione:

(define (e048)
  (pop (string (apply + (map (fn (x) (potenza x x)) (sequence 1L 1000L)))) -11 10)
)

(e048)
;-> 9110846700

(time (e048))
;-> 265.614


===========
Problema 49
===========

Permutazioni prime

La sequenza aritmetica, 1487, 4817, 8147, in cui ciascun termine aumenta di 3330, è inusuale in due modi: (i) ciascuno dei tre termini è primo, e (ii) ciascuno dei numeri a 4 cifre è una permutazione degli altri.

Non ci sono sequenze aritmetiche composte da tre numeri primi di 1, 2 o 3 cifre, che esibiscono questa proprietà, ma esiste un'altra sequenza crescente di 4 cifre.

Quale numero di 12 cifre si forma concatenando i tre termini in questa sequenza?
============================================================================

Funzione per i numeri primi:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Funzione che converte un numero in una lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

Limiti da considerare nella ricerca della soluzione: da 1001 a 9999

Filtro i numeri primi:

(setq a (filter primo? (sequence 1001 9999)))
(length a)
;-> 1061

Funzione che controlla se due numeri hanno le stesse cifre:

(define (cifreUguali x y)
  (if (= (sort (int2list x)) (sort (int2list y))))
)

(cifreUguali 1234 4231)
;-> true

Controllo tutti gli elementi della lista dei numeri primi per vedere se soddisfano le condizioni del problema:

(dolist (el a)
  (setq a1 el)
  (setq a2 (+ a1 3330))
  (setq a3 (+ a2 3330))
  (if (and (primo? a2) (primo? a3) (cifreUguali a1 a2) (cifreUguali a2 a3))
    (println a1 { } a2 { } a3)
  )
)
;-> 1487 4817 8147
;-> 2969 6299 9629

Possiamo scrivere la funzione finale:

(define (e049)
  (local (primi a1 a2 a3 out)
    (setq primi (filter primo? (sequence 1001 9999)))
    (dolist (el primi)
      (setq a1 el)
      (setq a2 (+ a1 3330))
      (setq a3 (+ a2 3330))
      (if (and (primo? a2) (primo? a3) (cifreUguali a1 a2) (cifreUguali a2 a3))
        (setq out (string a1 a2 a3))
        ;(println a1 { } a2 { } a3)
      )
    )
    out
  )
)

(e049)
;-> "296962999629"

(time (e049))
;-> 9.01


===========
Problema 50
===========

Somma di primi consecutivi

Il primo 41 può essere scritto come la somma di sei numeri primi consecutivi:

41 = 2 + 3 + 5 + 7 + 11 + 13

Questa è la somma più lunga di numeri primi consecutivi che si aggiunge a un numero primo inferiore a cento.

La somma più lunga di numeri primi consecutivi al di sotto di un migliaio che aggiunge un numero primo, contiene 21 termini ed è uguale a 953.

Quale primo, inferiore a un milione, può essere scritto come la somma dei numeri primi più consecutivi?
============================================================================

Funzione per i numeri primi:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Limiti da considerare nella ricerca della soluzione: da 2 a 1000000

Filtro i numeri primi:

(silent (setq primi (filter primo? (sequence 2 1000000))))
(length primi)
;-> 78490

(slice primi 0 10)

(define (e050)
  (local (primi lenprimi somma sommaMax limite i j stop)
    (setq somma 0)
    (setq limite -1)
    (setq primi (filter primo? (sequence 2 1000000)))
    (setq lenprimi (length primi))
    (setq i 2)
    (while (< i lenprimi)
      (setq somma 0)
      (setq stop nil)
      (setq j i)
      (while (and (< j lenprimi) (= stop nil))
        (setq somma (+ somma (primi j)))
        (if (> somma 1000000) (setq stop true)
        ;else
        (if (and (> (- j i) limite) (> somma sommaMax) (primo? somma))
          (begin
            (setq sommaMax somma)
            (setq limite (- j i))
          )
        ))
        (++ j)
      )
      (++ i)
      ;(if (= (% i 10000)) (println i))
    )
    sommaMax
  )
)

(e050)
;-> 997651

(time (e050))
;-> 27113

I numeri coinvolti nella soluzione sono i seguenti:

(997651 543 (7 11 13 17 19 23 29 31 37 41 43 47 53
59 61 67 71 73 79 83 89 97 101 103 107 109 113 127
131 137 139 149 151 157 163 167 173 179 181 191 193
197 199 211 223 227 229 233 239 241 251 257 263 269
271 277 281 283 293 307 311 313 317 331 337 347 349
353 359 367 373 379 383 389 397 401 409 419 421 431
433 439 443 449 457 461 463 467 479 487 491 499 503
509 521 523 541 547 557 563 569 571 577 587 593 599
601 607 613 617 619 631 641 643 647 653 659 661 673
677 683 691 701 709 719 727 733 739 743 751 757 761
769 773 787 797 809 811 821 823 827 829 839 853 857
859 863 877 881 883 887 907 911 919 929 937 941 947
953 967 971 977 983 991 997 1009 1013 1019 1021 1031
1033 1039 1049 1051 1061 1063 1069 1087 1091 1093 1097
1103 1109 1117 1123 1129 1151 1153 1163 1171 1181 1187
1193 1201 1213 1217 1223 1229 1231 1237 1249 1259 1277
1279 1283 1289 1291 1297 1301 1303 1307 1319 1321 1327
1361 1367 1373 1381 1399 1409 1423 1427 1429 1433 1439
1447 1451 1453 1459 1471 1481 1483 1487 1489 1493 1499
1511 1523 1531 1543 1549 1553 1559 1567 1571 1579 1583
1597 1601 1607 1609 1613 1619 1621 1627 1637 1657 1663
1667 1669 1693 1697 1699 1709 1721 1723 1733 1741 1747
1753 1759 1777 1783 1787 1789 1801 1811 1823 1831 1847
1861 1867 1871 1873 1877 1879 1889 1901 1907 1913 1931
1933 1949 1951 1973 1979 1987 1993 1997 1999 2003 2011
2017 2027 2029 2039 2053 2063 2069 2081 2083 2087 2089
2099 2111 2113 2129 2131 2137 2141 2143 2153 2161 2179
2203 2207 2213 2221 2237 2239 2243 2251 2267 2269 2273
2281 2287 2293 2297 2309 2311 2333 2339 2341 2347 2351
2357 2371 2377 2381 2383 2389 2393 2399 2411 2417 2423
2437 2441 2447 2459 2467 2473 2477 2503 2521 2531 2539
2543 2549 2551 2557 2579 2591 2593 2609 2617 2621 2633
2647 2657 2659 2663 2671 2677 2683 2687 2689 2693 2699
2707 2711 2713 2719 2729 2731 2741 2749 2753 2767 2777
2789 2791 2797 2801 2803 2819 2833 2837 2843 2851 2857
2861 2879 2887 2897 2903 2909 2917 2927 2939 2953 2957
2963 2969 2971 2999 3001 3011 3019 3023 3037 3041 3049
3061 3067 3079 3083 3089 3109 3119 3121 3137 3163 3167
3169 3181 3187 3191 3203 3209 3217 3221 3229 3251 3253
3257 3259 3271 3299 3301 3307 3313 3319 3323 3329 3331
3343 3347 3359 3361 3371 3373 3389 3391 3407 3413 3433
3449 3457 3461 3463 3467 3469 3491 3499 3511 3517 3527
3529 3533 3539 3541 3547 3557 3559 3571 3581 3583 3593
3607 3613 3617 3623 3631 3637 3643 3659 3671 3673 3677
3691 3697 3701 3709 3719 3727 3733 3739 3761 3767 3769
3779 3793 3797 3803 3821 3823 3833 3847 3851 3853 3863
3877 3881 3889 3907 3911 3917 3919 3923 3929 3931))


===============

 PROBLEMI VARI

===============

BubbleSort
----------

Il Bubble sort (ordinamento a bolla) è un semplice algoritmo stabile di ordinamento di una lista o di un vettore di dati. Ogni coppia di elementi adiacenti viene comparata e invertita di posizione se sono nell'ordine sbagliato. L'algoritmo continua continuamente ad eseguire questi passaggi per tutta la lista finché non vengono più eseguiti scambi, situazione che indica che la lista è ordinata.

Complessità temporale media O(n^2).

Nota: Un metodo di ordinamento si dice stabile se preserva l'ordine relativo dei dati con chiavi uguali all'interno della struttura dati da ordinare.

Possiamo rappresentare l'algoritmo con questo pseudocodice:

procedure BubbleSort(A:lista di elementi da ordinare)
  ultimoScambiato ← n
  n ← length(A) - 1
  while (ultimoScambiato > 0) do
    ultimoScambiato ← 0
    for i ← 0 to n do
      if (A[i] > A[i + 1]) then  //sostituire '>' con '<' per ottenere un ordinamento decrescente
        swap ( A[i], A[i+1] )
        ultimoScambiato ← i
   //ad ogni passaggio si accorcia il ciclo di for
   //fermandosi in corrispondenza dell'ultimo scambio effettuato
    n ← ultimoScambiato

Versione ricorsiva:

(define (bubble-up lst)
    (if (null? (rest lst))
        lst
        (if (< (first lst) (first (rest lst)))
            (cons (first lst) (bubble-up (rest lst)))
            (cons (first (rest lst)) (bubble-up (cons (first lst) (rest (rest lst))))))))

(define (bubble-sort-aux n lst)
    (cond ((= n 1) (bubble-up lst))
          (true (bubble-sort-aux (- n 1) (bubble-up lst)))))

(define (bubbleSort lst)
    (bubble-sort-aux (length lst) lst))

(bubbleSort '(5 10 9 8 7 8 6 7 5 4 3 4 5))
;-> (3 4 4 5 5 5 6 7 7 8 8 9 10)

Versione iterativa:

(define (bubbleSort lst)
  (local (i j continua)
    (setq continua 1)
    (setq j (length lst))
    (while (= continua 1)
      (setq continua 0)
      (for (i 1 (- j 1))
        (cond ((< (lst i) (lst (- i 1)))
               (swap (lst i) (lst (- i 1)))
               (setq continua 1))
        )
      )
      (-- j)
    )
  )
  lst
)

(bubbleSort '(5 10 9 8 7 8 6 7 5 4 3 4 5))
;-> (3 4 4 5 5 5 6 7 7 8 8 9 10)


QuickSort
---------

Il Quicksort è un algoritmo di ordinamento ricorsivo. Appartiene alla classe degli algoritmi divide et impera, dal momento che scompone ricorsivamente i dati da processare in sottoprocessi. Tale procedura ricorsiva viene comunemente detta partizionamento: preso un elemento chiamato "pivot" da una struttura dati (es. lista o vettore) si pongono gli elementi minori a sinistra rispetto al pivot e gli elementi maggiori a destra. L'operazione viene quindi reiterata sui due insiemi risultanti fino al completo ordinamento della struttura.

Il Quicksort (ordinamento rapido), è l'algoritmo di ordinamento che ha, nel caso medio, prestazioni migliori tra quelli basati su confronto. È stato ideato da Richard Hoare nel 1961.

Complessità temporale media O(nlogn).

Lo pseudocodice per il Quicksort è:

Procedure Quicksort(A)
Input A, vettore a1, a2, a3 .. an
  begin
    if n ≤ 1 then return A
    else
      begin
        scegli un elemento pivot ak
        calcola il vettore A1 dagli elementi ai di A tali che i ≠ K e ai ≤ ak
        calcola il vettore A2 dagli elementi aj di A tali che j ≠ K e aj > ak
        A1 ← Quicksort(A1)
        A2 ← Quicksort(A2)
        return A1 U (ak) U A2;
      end

In newLISP possiamo scriverla in questo modo utilizzando la funzione "filter":

(define (quicksort lst)
  (cond ((or (null? lst)         ; la lista è vuota (ordinata)
             (null? (rest lst))) ; la lista ha un solo elemento (ordinata)
         lst)
        (true
          (let ((pivot (first lst)) ; Seleziona il primo elemento come pivot
                (resto (rest lst))) ; Prendi la lista rimanente (resto)
               (append (quicksort   ; Ricorsivamente ordina la lista dei valori più piccoli
                          (filter (lambda (x) (< x pivot)) resto)) ; Seleziona i valori più piccoli
                       (list pivot) ; Aggiungi il pivot al centro
                       (quicksort   ; Ricorsivamente ordina la lista dei valori più grandi
                          (filter (lambda (x) (>= x pivot)) resto)))  ; Seleziona i valori maggiori e uguali
          )
        )
  )
)

(quicksort '(89 3 4 5 3 2 2 4 6 7 8 9 7 8 9 3 2 4 89))
;-> (2 2 2 3 3 3 4 4 4 5 6 7 7 8 8 9 9 89 89)

Questo è l'algoritmo più veloce (in media) per ordinare una lista:

(silent (setq lst (rand 10000 100000)))

(time (quicksort lst))
;-> 989.971

Ma non è paragonabile alla funzione predefinita di newLISP "sort":

(time (sort lst))
;-> 55.94


Simulare una matrice con un vettore
-----------------------------------

Data la seguente matrice:

          | 1  2  3  4 |
Matrice = | 5  6  7  8 |
          | 9 10 11 12 |

Simuliamo l'indicizzazione della matrice con il vettore:

Vettore = (1 2 3 4 5 6 7 8 9 10 11 12)

In generale se la matrice ha N righe e M colonne, allora il vettore deve avere N*M elementi: matrice(NxM) ==> vettore(N*M)

La formula di conversione degli indici è la seguente:

Matrice(i,j) = Vettore(i*m + j) = vettore(k)

Definiamo una funzione che converte gli indici della matrice (i,j) nell'indice k del vettore:

(define (i-j->k i j n m) (+ (* i m) j))

(setq vec '(1 2 3 4 5 6 7 8 9 10 11 12))
(setq n 3)
(setq m 4)

(i-j->k 0 0 n m)
;-> 0
(vec (i-j->k 0 0 n m))
;-> 1

Stampiamo gli indici del vettore:

(for (i 0 (- n 1))
  (for (j 0 (- m 1))
    (print (i-j->k i j n m) { })
  )
)
;-> 0 1 2 3 4 5 6 7 8 9 10 11 " "

Stampiamo i valori del vettore:

(for (i 0 (- n 1))
  (for (j 0 (- m 1))
    (print (vec (i-j->k i j n m)) { })
  )
)
;-> 1 2 3 4 5 6 7 8 9 10 11 12 " "

Adesso definiamo la funzione inversa che mappa l'indice k del vettore negli indici (i,j) della matrice:

(define (k->i-j k n m)
  (local (i j)
    (setq i (/ k m))
    (setq j (- k (* m i)))
    (list i j)
  )
)

(k->i-j 0 n m)
;-> (0 0)
(k->i-j 11 n m)
;-> (2 3)

Stampiamo gli indici della matrice:

(for (k 0 (- (* n m) 1))
    (print (k->i-j k n m) { })
)
;-> (0 0) (0 1) (0 2) (0 3) (1 0) (1 1) (1 2) (1 3) (2 0) (2 1) (2 2) (2 3) " "


Implementare una pila (stack) con un vettore
--------------------------------------------

La pila (Stack) è una struttura dati lineare che segue un ordine particolare in cui vengono eseguite le operazioni. L'ordine può essere LIFO (Last In First Out) o FILO (First In Last Out).
Principalmente le seguenti quattro operazioni di base sono eseguite nello stack:

Push: aggiunge un elemento nello stack. Se lo stack è pieno, si dice che sia una condizione di Overflow.
Pop: rimuove un oggetto dalla pila. Gli articoli vengono visualizzati nell'ordine invertito in cui vengono inseriti. Se lo stack è vuoto, si dice che sia una condizione di Underflow.
Look o Peek o Top: restituisce l'elemento superiore dello stack.
isEmpty: restituisce true se lo stack è vuoto, altrimenti false.
pila

Come capire praticamente una pila?
Ci sono molti esempi di vita reale di una pila. Considera il semplice esempio di piatti impilati uno sull'altro in una mensa. Il piatto che è nella parte superiore è il primo ad essere rimosso, in altre parole il piatto che è stato posto nella posizione più bassa rimane nella pila per il periodo di tempo più lungo. Quindi, può essere semplicemente visto seguire l'ordine LIFO / FILO.

Complessità di tempo delle operazioni sullo stack:

Le funzioni push (), pop (), isEmpty () e look () richiedono tutte un tempo O(1). Non eseguiamo alcun ciclo in queste operazioni.

          ---------------------   <-- push
          | 1 | 2 | 3 | 4 | 5 |
          ---------------------   pop -->
  Indice    0   1   2   3   4

Crea le variabili per la gestione della pila:
(define (Screate n)
  (setq Ssize n) ; max size
  (setq Sidx 0)
  (setq Stack (array Ssize '(0)))
)

La pila è vuota?
(define (SisEmpty?) (= Sidx 0))

La pila è piena?
(define (SisFull?) (= Sidx Ssize))

Lunghezza della pila
(define (SgetLen) (Sidx)

Inserisce un elemento nella pila (in cima):
(define (Spush el)
  (if (SisFull?) (list nil "Overflow")
    (begin (setf (Stack Sidx) el) (++ Sidx))
  )
)

Estrae un elemento dalla pila (in cima):
(define (Spop)
  (if (SisEmpty?) (list nil "Underflow")
    (begin (-- Sidx) (Stack Sidx))
  )
)

Guarda un elemento dalla lista (in cima):
(define (Slook)
  (if (SisEmpty?) nil
      (Stack (- Sidx 1))
  )
)

Stampa elementi della pila:

(define (Sshow)
  (if (SisEmpty?) nil ; coda vuota ?
      (for (i 0 (- Sidx 1))
            (print (Stack i) { })
      )
  )
)

(Screate 3)
;-> (0 0 0)
(Spush 1)
;-> 1
(Spush 2)
;-> 2
(SisFull?)
;-> nil
(Spush 3)
;-> 3
(SisFull?)
;-> true
(Slook)
;-> 3
(Sshow)
;-> 1 2 3
(Spop)
;-> 3
(Spop)
;-> 2
(Spop)
;-> 1
(Spop)
;-> (nil "Overflow)
(Spush 1)
(Spush 2)
(Spush 3)
(Spush 4)
;-> (nil "Overflow")


Implementare una coda (queue) con un vettore
--------------------------------------------

In una coda (queue), l'inserimento e l'eliminazione degli elementi avvengono agli estremi opposti, quindi l'implementazione non è semplice come quella della pila (stack). Le operazioni su una coda sono basate sul principio FIFO (First In First Out).
Per implementare una coda usando un vettore, creare un vettore "vec" arr di dimensione n e utilizzare due variabili front e rear che verranno inizializzate a 0, il che significa che la coda è attualmente vuota. La variabile "rear" è l'indice in cui gli elementi sono memorizzati nel vettore e "front" è l'indice del primo elemento del vettore. Alcune delle operazioni sulle code sono le seguenti:

Enqueue: aggiunge di un elemento alla coda. L'aggiunta di un elemento verrà eseguita dopo aver controllato se la coda è piena o meno. Se (front < n) che indica che l'array non è pieno, allora memorizza l'elemento in vec[front] e incrementa rear di 1, ma se rear == n allora si ottiene una condizione di Overflow (il vettore è pieno).

Dequeue: rimuove un elemento dalla coda. Un elemento può essere cancellato solo quando è presente almeno un elemento da eliminare, ad esempio (rear > 0). Ora, l'elemento at vec[front] può essere cancellato, ma tutti gli elementi rimanenti devono essere spostati a sinistra di una posizione in modo che le successive operazioni sulla coda trovino il primo elemento della coda sulla prima cella (indice 0) del vettore.

Look: Ottiene l'elemento iniziale (front) dalla coda, ad esempio vec[front] se la coda non è vuota.

Show: Se la coda non è vuota, attraversa e stampa tutti gli elementi dall'indice anteriore a quello posteriore.

               -------------------------
  dequeue <--  | 1 | 2 | 3 | 4 | 5 |   |  <-- enqueue
               -------------------------
       Indice    0   1   2   3   4  ...

Crea le variabili per la gestione della coda:

(define (Qcreate n)
  (setq Qsize n) ; max size
  (setq Qfront 0)
  (setq Qrear 0)
  (setq Queue (array Qsize '(0)))
)

Inserisce un elemento nella coda (in fondo alla coda):

(define (Qenqueue el)
  ;controlla se la coda è piena
  (if (= Qsize Qrear)
      (list nil "overflow")
      ;else
      (begin
        (setf (Queue Qrear) el)
        (++ Qrear)
        el
      )
  )
)

Estrae un elemento dalla coda (all'inizio della coda):

(define (Qdequeue)
  (local (el)
    ;controlla se la coda è vuota
    (if (= Qfront Qrear)
        (list nil "overflow")
        ;else
        (begin
          (setq el (Queue Qfront)) ; estrae primo elemento della coda
          ; sposta tutti gli elementi a sinistra di un posto
          ; partendo dal secondo indice fino all'indice Qrear
          (for (i 0 (- Qrear 2)) (setf (Queue i) (Queue (+ i 1))))
          ; decrementa Qrear
          (-- Qrear)
          el
        )
    )
  );local
)

Stampa elementi della coda:

(define (Qshow)
  (if (= Qfront Qrear) nil ; coda vuota ?
      (for (i Qfront (- Qrear 1))
            (print (Queue i) { })
      )
  )
)

Guarda il primo elemento della coda:

(define (Qlook)
  (if (= Qfront Qrear) ; coda vuota ?
      nil
      (Queue Qfront)
  )
)

La coda è vuota?

(define (QisEmpty?) (= Qfront Qrear))

La coda è piena?

(define (QisFull?) (= Qrear Qsize))

Lunghezza della coda:

(define (QgetLen) (- Qfront Qrear))

(Qcreate 4)
;-> (0 0 0 0)
(Qenqueue 1)
;-> 1
(Qenqueue 2)
;-> 2
(Qenqueue 3)
;-> 3
(Qshow)
;-> 1 2 3
(QisEmpty?)
;-> nil
(QisFull?)
;-> nil
(Qenqueue 4)
;-> 4
(QisFull?)
;-> true
(Qenqueue 5)
;-> (nil "overflow")
(Qshow)
;-> (1 2 3 4)
(Qdequeue)
;-> (1)
(Qshow)
;-> (2 3 4)
(Qdequeue)
;-> 2
(Qdequeue)
;-> 3
(Qdequeue)
;-> 4
(Qdequeue)
;-> (nil "overflow")
(Qenqueue 4)
(Qshow)
;-> 4
(Qlook)
;-> 4
(Qshow)
;-> 4

Complessità temporale enqueue O(1)
Complessità temporale dequeue O(n)

È possibile ottenere una complessità temporale O(1) per la funzione dequeue se utilizziamo una lista circolare.

Con newLISP possiamo definire una coda (illimitata) utilizzando una lista in maniera "quick and dirty".
Dichiariamo una lista con lo stesso nome del contesto (funtore):

(setq k:k '())

Funzione che aggiunge (alla fine) un elemento alla coda:

(define (enqQ queue el) (push el queue -1))

Funzione che prende l'elemento iniziale della coda:

(define (deqQ queue) (if (not (emptyQ? queue)) (pop queue) nil))

Funzione che "guarda" il valore del primo elemento della coda:

(define (lookQ queue) (queue 0))

Funzione che restituisce true se la coda è vuota:

(define (emptyQ? queue) (= 0 (length queue)))

Funzione che restituisce il numero di elementi della coda:

(define (lenQ queue) (length queue))

Funzione che mostra tutti gli di elementi della coda:

(define (showQ queue) (println queue))

(enqQ k 1)
;-> (1)
(enqQ k 2)
;-> (2)
(enqQ k 3)
;-> (3)
k:k
;-> (1 2 3)
(deqQ k)
;-> 1
(println k:k)
;-> (2 3)
(emptyQ? k)
;-> nil
(lenQ k)
;-> 2
(k:k 1)
;-> 3
(showQ k:k)
;-> (2 3)
(lookQ k)
;-> 2

Con lo stesso metodo possiamo implementare anche una pila illimitata.


Coda circolare (Ring Buffer)
----------------------------

La Coda circolare (Circular Queue) è una struttura di dati lineare in cui le operazioni vengono eseguite in base al principio FIFO (First In First Out) e l'ultima posizione viene connessa alla prima posizione per creare un cerchio. Viene anche chiamato 'Ring Buffer'.

            front
 8      10   0       1  <--- indice
   -----------------
   |   |   | 2 | 1 |  <--- valore
   -----------------
 7 |   |       | 4 | 2
   -----------------
   |   | 7 | 8 | 5 |
   -----------------
 6       5   4       3
        rear

Crea le variabili per la gestione della coda circolare:

(define (CQcreate n)
  (setq CQsize n) ; max size
  (setq CQfront -1)
  (setq CQrear -1)
  (setq CQqueue (array CQsize '(0)))
)

(define (CQenqueue el)
  (cond ((or (and (= CQfront 0) (= CQrear (- CQsize 1)))
             (= CQrear (% (- CQfront 1) (- CQsize 1))))
          (list nil "Overflow") ; la coda è piena
        )
        ((= CQfront -1) ; primo inserimento
          (setq CQfront 0)
          (setq CQrear 0)
          (setq (CQqueue CQrear) el)
        )
        ((and (= CQrear (- CQsize 1)) (!= CQfront 0))
          (setq CQrear 0)
          (setq (CQqueue CQrear) el)
        )
        (true
          (++ CQrear)
          (setq (CQqueue CQrear) el)
        )
  )
)

(define (CQdequeue)
  (local (el)
    (cond ((= CQfront -1) (list nil "Underflow")) ; la coda è vuota
          (true
            (setq el (CQqueue CQfront))
            (setq (CQqueue CQfront) -1)
            (cond ((= CQfront CQrear) (setq CQfront -1 CQrear -1))
                  ((= CQfront (- CQsize 1)) (setq CQfront 0))
                  (true (++ CQfront))
            )
            el
          )
    )
  )
)

(define (CQshow)
  (cond ((= -1 CQfront) (list nil "Empty"))
        ((>= CQrear CQfront) (for (i CQfront CQrear) (print (CQqueue i) { })))
        (true (for (i CQfront (- CQsize 1) (print (CQqueue i) { })))
              (for (i 0 CQrear) (print (CQqueue i) { }))
        )
  )
)

(CQcreate 4)
;-> (0 0 0 0)
(CQenqueue 2)
;-> 2
(CQenqueue 1)
;-> 1
(CQshow)
;-> 2 1
(CQdequeue)
;-> 2
(CQdequeue)
;-> 1
(CQdequeue)
;-> (nil "Underflow")
(CQshow)
;-> (nil "Empty")

(CQenqueue 1)
(CQenqueue 2)
(CQenqueue 3)
(CQenqueue 5)
(CQenqueue 8)
;-> (nil "Overflow")
(CQshow)
;-> (1 2 3 5)

Complessità temporale:  O(1) per CQenqueue e CQdequeue poiché non vi è alcun ciclo in nessuna delle operazioni.

Applicazioni che utilizzano le code:
Gestione della memoria: le posizioni di memoria inutilizzate nel caso di code ordinarie possono essere utilizzate in code circolari.
Sistema di traffico: nel sistema di traffico controllato da computer, le code circolari vengono utilizzate per accendere ripetutamente i semafori secondo il tempo impostato.
Pianificazione della CPU: i sistemi operativi spesso mantengono una coda di processi pronti per l'esecuzione o che sono in attesa di un particolare evento.


Fattoriale
----------

In matematica, si definisce fattoriale di un numero naturale n, indicato con n!, il prodotto dei numeri interi positivi minori o uguali a tale numero. In formula:

n! = Prod[i], con (1 <= i <= n)

per la convenzione del prodotto vuoto si definisce inoltre: 0! = 1

Nota: 1 = 1! = 1 * (1-1)! = 1 * 0! = 0!

Metodo ricorsivo:

(define (fact n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))
  )
)

(fact 6L)
;-> 720L

Metodo iterativo:

(define (fact1 n)
  (let (fatt 1L)
    (for (x 1L n)
      (setq fatt (* fatt x))
    )
  )
)

(fact1 6)
;-> 720L

Metodo newLISP:

(define (fact2 n) (if (= n 0) 1 (apply * (map bigint (sequence 1 n)))))

(fact2 6)
;-> 720L

(fact2 100)
;-> 93326215443944152681699238856266700490715968264381621
;-> 46859296389521759999322991560894146397615651828625369
;-> 7920827223758251185210916864000000000000000000000000L

I fattoriali sono importanti nel calcolo combinatorio.
Per esempio, vi sono n! diverse sequenze formate da n oggetti distinti, cioè ci sono n! permutazioni di n oggetti.


Coefficiente binomiale
----------------------

Il coefficiente binomiale, cioè il numero di scelte di k elementi tra quelli di un insieme di n elementi (numero di combinazioni semplici), ha la seguente formula:

(n)        n!
   = ---------------
(k)   k! * (n - k)!

in altre parole, il coefficiente binomiale C(n, k) fornisce anche il numero di modi, trascurando l'ordine, che k oggetti possono essere scelti tra n oggetti.

Soluzione ricorsiva

(define (binomiale n k)
  (if (or (= k 0) (= k n))
      1
      (add (binomiale (- n 1) (- k 1)) (binomiale (- n 1) k))
  )
)

(binomiale 5 2)
;-> 10

Soluzione iterativa

Per calcolare il coefficiente binomiale, usiamo una matrice M[][] che memorizza i valori precedenti (si tratta di una tecnica della Programmazione Dinamica)

(define (binomiale n k)
  (local (M q)
    (setq M (array (+ n 1) (+ k 1) '(0)))
    (for (i 0 n)
      (setq q (min i k))
      (for (j 0 q)
        (if (or (= j 0) (= j i))
          (setq (M i j) 1)
          (setq (M i j) (+ (M (- i 1) (- j 1)) (M (- i 1) j)))
        )
      )
    )
    (M n k)
  );local
)

(debug (binomiale 5 2))
(binomiale 5 2)
;-> 10

(binomiale 100 5)
;-> 75287520

Complessità temporale: O(n*k)
Complessità spaziale: O(n*k)


Lancio di dadi
--------------

Definire una funzione che permetta di ottenere il risultato del lancio di n dadi con m facce.
Utilizziamo la funzione "rand".

*****************
>>>funzione RAND
*****************
sintassi: (rand int-range [int-N])

Valuta l'espressione in int-range e genera un numero casuale compreso tra 0 (zero) e (int-range - 1). Quando viene passato 0 (zero), il generatore casuale interno viene inizializzato utilizzando il valore corrente restituito dalla funzione C time (). Facoltativamente, è possibile specificare un secondo parametro per restituire un elenco di lunghezza int-N di numeri casuali.

(dotimes (x 100) (print (rand 2))) =>
11100000110100111100111101 ... 10111101011101111101001100001000

(rand 3 100) → (2 0 1 1 2 0 ...)

La prima riga nell'esempio stampa equamente distribuite 0 e 1, mentre la seconda riga produce un elenco di 100 interi con 0, 1 e 2 equamente distribuiti. Utilizzare le funzioni "random" e "normal" per generare numeri casuali in virgola mobile e utilizzare "seed" per variare il seme iniziale per la generazione di numeri casuali.

Per generare il numero prodotto dal lancio di n dadi con m facce, potremmo pensare di generare un numero casuale tra n (quando tutti i dadi valgono 1) e n*m (quando tutti i dadi valgono m).

(define (lancio n m)
  (add n (rand (sub (add (mul n m) 1) n)))
)

(lancio 2 6)
;-> 11

Purtroppo questo ragionamento è sbagliato perchè la nostra funzione considera equiprobabili i numeri tra n e n*m, mentre questo non è vero. Vediamo un esempio con due dadi a sei facce.
Le probabilità dei numeri non sono identiche, infatti risulta:

 1: nil (non può mai uscire 1)
 2: (1,1) --> (1 caso)
 3: (1,2) (2,1) --> (2 casi)
 4: (1,3) (3,1) (2,2) --> (3 casi)
 5: (1,4) (4,1) (2,3) (3,2) --> (4 casi)
 6: (1,5) (5,1) (2,4) (4,2) (3,3) --> (5 casi)
 7: (1,6) (5,2) (2,5) (5,2) (3,4) (4,3) --> (6 casi)
 8: (2,6) (6,2) (3,5) (5,3) (4,4) --> (5 casi)
 9: (3,6) (6,3) (4,5) (5,4) --> (4 casi)
10: (4,6) (6,4) (5,5) --> (4 casi)
11: (5,6) (6,5) --> (2 casi)
12: (6,6) --> (1 caso)

La seguente funzione fornisce il risultato corretto:

(define (lancio-dadi num-dadi num-facce)
  (+ num-dadi (apply + (rand num-facce num-dadi)))
)

(lancio-dadi 2 6)
;-> 9

Per capire meglio la differenza dei risultati tra le due funzioni, creiamo due liste con le frequenze di 10000 valori generati da ognuna delle due funzioni, poi disegniamo un istogramma per ogni lista.

Creiamo la prima lista.
Generiamo una lista con 10000 lanci:

(setq res1 '())
(for (i 0 9999)
  (push (lancio 2 6) res1 -1)
)
(length res1)

Creiamo la lista delle frequenze:

(setq f1 (array 13 '(0)))
(dolist (el res1)
  (println el)
  (++ (f1 (- el 1)))
)

f1
;-> (0 880 889 913 929 910 914 939 866 902 943 915 0)

Creiamo la seconda lista.
Generiamo una lista con 10000 lanci:

(setq res2 '())
(for (i 0 9999)
  (push (lancio-dadi 2 6) res2 -1)
)
(length res2)

Creiamo la lista delle frequenze:

(setq f2 (array 13 '(0)))
(dolist (el res2)
  (println el)
  (++ (f2 (- el 1)))
)

f2
;-> (0 288 515 870 1145 1354 1643 1385 1162 803 565 270 0)

Adesso dobbiamo creare una funzione che disegna l'istogramma di una lista. Per i nostri scopi sarà sufficiente la seguente funzione che disegna un istogramma ruotato di 90 gradi utilizzando il carattere "*". Il parametro "hmax" definisce l'altezza massima dell'istogramma.

(define (histo lst hmax)
  (local (linee hm scala)
    (setq hm (apply max lst))
    (setq scala (div hm hmax))
    (setq linee (map (fn (x) (round (div x scala))) lst))
    (dolist (el linee)
      ;(println (format "%3d %s %0.2f" (add $idx 1) (dup "*" el) (lst $idx)))
      (println (format "%3d %s %4d" (add $idx 1) (dup "*" el) (lst $idx)))
    )
  )
)

Proviamo a disegnare l'istogramma della prima lista:

(histo f1 50)
;->   1     0
;->   2 ***********************************************  909
;->   3 **********************************************  878
;->   4 **********************************************  892
;->   5 **********************************************  888
;->   6 *************************************************  946
;->   7 *********************************************  870
;->   8 *************************************************  942
;->   9 ************************************************  918
;->  10 **************************************************  962
;->  11 ************************************************  923
;->  12 *********************************************  872
;->  13     0

E poi l'istogramma della seconda lista:

(histo f2 50)
;->   1     0
;->   2 ********  251
;->   3 ****************  525
;->   4 **************************  852
;->   5 ********************************** 1142
;->   6 ***************************************** 1363
;->   7 ************************************************** 1663
;->   8 ****************************************** 1403
;->   9 ********************************** 1133
;->  10 *************************  846
;->  11 ****************  541
;->  12 ********  281
;->  13     0

La prima lista ha una distribuzione pressochè uniforme (tutti i numeri hanno la stessa probabilità).
La seconda lista ha una distribuzione gaussiana centrata sul numero più probabile.

Notazione internazionale

Una lancio di dadi viene codificato con la seguente espressione matematica:

XdY [<-> | <+> | <*> | </>] [N | AdB]

Al numero uscito dal lancio di X dadi con Y facce viene applicata una delle operazioni - o + o * o / con il numero N o con il numero uscito da un lancio di A dadi con B facce.

Esempi:
2d6 + 10
(al lancio di 2 dadi con 6 facce sommare il numero 10)
4d8 - 1d6
(al lancio di 4 dadi con 8 facce sottrarre il lancio di 1 dado con 6 facce)



Quadrati magici
---------------

Un quadrato magico è una matrice quadrata NxN i cui numeri consistono in numeri consecutivi (da 1 a N) disposti in modo tale che la somma di ogni riga e colonna e di entrambe le diagonali siano uguali alla stessa somma (che è chiamata numero magico o costante magica).
Il numero magico vale: n(n*n + 1)/2

Esistono tre tipi di quadrati magici (catalogati in base alla dimensione del lato)

- dispari (dove n = 3, 5, 7, 9, 11, ecc.)

- singolarmente pari (dove n è multiplodi di 2, ma non di 4, n = 6, 10, 14, 18, 22, ...)

- doppiamente pari (dove n è un multiplo di quattro, n = 4, 8, 12, ...

Dato un numero N, scrivere una funzione che crea un quadrato magico di ordine N.

Per la stampa utilizziamo la seguente funzione:

(define (print-matrix matrix)
  (local (row col nmax nmin digit fmtstr)
    ; converto matrice in lista ?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; valore massimo
    (setq nmax (string (apply max (flat matrix))))
    ; valore minimo
    (setq nmin (string (apply min (flat matrix))))
    ; calcolo spazio per i numeri
    (setq digit (add 1 (max (length nmax) (length nmin))))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "d"))
    ; stampa
    (for (i 0 (sub row 1))
      (for (j 0 (sub col 1))
        (print (format fmtstr (matrix i j)))
      )
      (println)
    )
  )
)

Dobbiamo scrivere una funzione per ogni tipo di quadrato magico. Cominciamo con quelli di ordine dispari.

1) Quadrati Magici Dispari

(define (qmDispari n)
  (define (f n x y) (% (add x (mul y 2) 1) n))
  (local (val nm row out)
    (setq out '())
    (setq row '())
    ;calcolo quadrato magico
    (for (i 0 (sub n 1))
      (for (j 0 (sub n 1))
        (setq val (add (mul (f n (sub n j 1) i) n)
                       (add (f n j i))
                       1))
        (push val row -1)
      )
      (push row out -1)
      (setq row '())
    )
    ;calcolo numero magico
    (setq nm (div (mul n (add 1 (mul n n))) 2))
    (println nm)
    out
  )
)

(print-matrix (qmDispari 9))
;-> 369
;->   2 75 67 59 51 43 35 27 10
;->  22 14  6 79 71 63 46 38 30
;->  42 34 26 18  1 74 66 58 50
;->  62 54 37 29 21 13  5 78 70
;->  73 65 57 49 41 33 25 17  9
;->  12  4 77 69 61 53 45 28 20
;->  32 24 16  8 81 64 56 48 40
;->  52 44 36 19 11  3 76 68 60
;->  72 55 47 39 31 23 15  7 80

Scriviamo una funzione che controlla la correttezza del quadrato generato

(define (check qm n somma)
  (local (valido srow scol)
    (setq valido true)
    ; controllo diagonali
    (setq srow 0 scol 0)
    (for (i 0 (sub n 1))
      (setq srow (add srow (qm i i)))
      (setq scol (add scol (qm i (sub n i 1))))
    )
    (if (or (!= srow somma) (!= scol somma))
        (setq valido nil))
    ;controllo righe e colonne
    (for (i 0 (sub n 1) 1 valido)
      (setq srow 0 scol 0)
      (for (j 0 (sub n 1) 1 valido )
        (setq srow (add srow (qm i j)))
        (setq scol (add scol (qm j i)))
      )
      (if (or (!= srow somma) (!= scol somma))
          (setq valido nil)
      )
    )
    valido
  )
)

(setq m (qmDispari 9))
;-> 369
(check m 9 369)
;-> true

2) Quadrati Magici Doppiamente Pari

(define (qm4 n)
  (local (r c i bit size mult bitPos nm out v)
    (setq bit 38505)
    (setq size (* n n))
    (setq mult (/ n 4))
    ;creazione della lista)
    (setq out (dup (dup 0 n) n))
    (setq r 0 c 0 i 0)
    (while (< r n)
      (while (< c n)
        (setq bitPos (+ (/ c mult) (* (/ r mult) 4)))
        (if (!= (& bit (<< 1 bitPos)) 0)
          (setq v (+ i 1))
          (setq v (- size i))
        )
        (setf (out r c) v)
        (++ c)
        (++ i)
      )
      (setq c 0)
      (++ r)
    )
    ;calcolo numero magico
    (setq nm (div (mul n (add 1 (mul n n))) 2))
    (println nm)
    out
  )
)

(setq m (qm4 4))
;-> 34
;-> ((1 15 14 4) (12 6 7 9) (8 10 11 5) (13 3 2 16))
(print-matrix m)
;->   1 15 14  4
;->  12  6  7  9
;->   8 10 11  5
;->  13  3  2 16
(check m 4 34)
;-> true

(setq m (qm4 12))
;-> 870
(print-matrix m)
;->    1   2   3 141 140 139 138 137 136  10  11  12
;->   13  14  15 129 128 127 126 125 124  22  23  24
;->   25  26  27 117 116 115 114 113 112  34  35  36
;->  108 107 106  40  41  42  43  44  45  99  98  97
;->   96  95  94  52  53  54  55  56  57  87  86  85
;->   84  83  82  64  65  66  67  68  69  75  74  73
;->   72  71  70  76  77  78  79  80  81  63  62  61
;->   60  59  58  88  89  90  91  92  93  51  50  49
;->   48  47  46 100 101 102 103 104 105  39  38  37
;->  109 110 111  33  32  31  30  29  28 118 119 120
;->  121 122 123  21  20  19  18  17  16 130 131 132
;->  133 134 135   9   8   7   6   5   4 142 143 144
(check m 12 870)
;-> true

3) Quadrati Magici Singolarmente Pari

; Funzione interna che crea un quadrato magico dispari
(define (oddMS n)
  (local (r c squaresize nm out value)
    (setq squaresize (* n n))
    (setq c (/ n 2))
    (setq r 0)
    ;creazione della lista
    (setq out (dup (dup 0 n) n))
    (setq value 1)
    (while (<= value squaresize)
      (setf (out r c) value)
      (cond ((= r 0)
              (if (= c (- n 1))
                  (++ r)
                  (begin
                  (setq r (- n 1))
                  (++ c))
              )
            )
            ((= c (- n 1))
              (-- r)
              (setq c 0)
            )
            ((= (out (- r 1) (+ c 1)) 0)
              (-- r)
              (++ c)
            )
            (true (++ r))
      )
      (++ value)
    )
    ;(println (div (mul n (add 1 (mul n n))) 2))
    out
  )
)

(setq m (oddMS 5))
;-> 65
;-> ((17 24 1 8 15) (23 5 7 14 16) (4 6 13 20 22) (10 12 19 21 3) (11 18 25 2 9))
(print-matrix m)
;->  17 24  1  8 15
;->  23  5  7 14 16
;->   4  6 13 20 22
;->  10 12 19 21  3
;->  11 18 25  2  9
(check m 5 65)
;-> true

(define (qm2 n)
  (local (r c size half grid gridFactors subGrid nColsLeft nColsRigth nm out)
    (setq size (* n n))
    (setq halfN (/ n 2))
    (setq subGridSize (/ size 4))
    (setq subGrid (oddMS halfN))
    (setq gridFactors '(0 2 3 1))
    ;creazione della lista
    (setq out (dup (dup 0 n) n))
    (for (r 0 (- n 1))
      (for (c 0 (- n 1))
        ;(println r { } c)
        (setq grid (+ (* (/ r halfN) 2) (/ c halfN)))
        (setf (out r c) (subGrid (% r halfN) (% c halfN)))
        (setf (out r c) (+ (out r c) (* (gridFactors grid) subGridSize)))
      )
    )
    (setq nColsLeft (/ halfN 2))
    (setq nColsRigth (- nColsLeft 1))
    (for (r 0 (- halfN 1))
      (for (c 0 (- n 1) 1 )
        (if (or (< c nColsLeft) (>= c (- n nColsRigth))
                (and (= c nColsLeft) (= r nColsLeft)))
            ;(if (and (!= c 0) (!= r nColsLeft))
            (if (and (= c 0) (= r nColsLeft))
                (setq c c) ; no operation (NOP)
                (swap (out r c) (out (+ r halfN) c))
            )
        )
      )
    )
    (println (div (mul n (add 1 (mul n n))) 2))
    out
  );local
)

(qm2 6)
;-> 111
;-> ((35 1 6 26 19 24) (3 32 7 21 23 25) (31 9 2 22 27 20) (8 28 33 17 10 15)
;-> (30 5 34 12 14 16) (4 36 29 13 18 11))

(setq m (qm2 6))
(print-matrix m)
;->  35  1  6 26 19 24
;->   3 32  7 21 23 25
;->  31  9  2 22 27 20
;->   8 28 33 17 10 15
;->  30  5 34 12 14 16
;->   4 36 29 13 18 11
(check m 6 111)
;-> true


Quadrati magici 3x3
-------------------

Nessun output sulla REPL:
(define (resume) (print "\r\n> "))

Esempio di utilizzo:
(silent <(function)> (print "Fatto") (resume))

Numero magico per i quadrati magici 3x3:
(setq nm (div (mul 3 (add 1 (mul 3 3))) 2))
;-> 15

Funzione che controlla se un quadrato è magico:

(define (check3 qm somma)
  (if (and (= somma (+ (qm 0) (qm 1) (qm 2))) ;riga 0
           (= somma (+ (qm 3) (qm 4) (qm 5))) ;riga 1
           (= somma (+ (qm 6) (qm 7) (qm 8))) ;riga 2
           (= somma (+ (qm 0) (qm 3) (qm 6))) ;colonna 0
           (= somma (+ (qm 1) (qm 4) (qm 7))) ;colonna 1
           (= somma (+ (qm 2) (qm 5) (qm 8))) ;colonna 2
           (= somma (+ (qm 0) (qm 4) (qm 8))) ;diagonale 1
           (= somma (+ (qm 2) (qm 4) (qm 6)))) ;diagonale 2
      true
      nil
  )
)

(check3 '(1 2 3 4 5 6 7 9 8) 15)
;-> nil

Questo è un quadrato magico:

  8 1 6
  3 5 7
  4 9 2

(check3 '(8 1 6 3 5 7 4 9 2) 15)
;-> true

Funzione che genera le permutazioni:

(define (rimuovi x lst)
  (cond
    ((null? lst) '())
    ((= x (first lst)) (rimuovi x (rest lst)))
    (true (cons (first lst) (rimuovi x (rest lst))))
  )
)

(define (permutazioni lst)
  (cond
    ((= (length lst) 1)(list lst))
    (true (apply append(map(lambda (i) (map (lambda (j)(cons i j))
                                            (permutazioni (rimuovi i lst)))) lst)))
  )
)

Generiamo tutte le permutazioni delle cifre da 1 a 9:
(silent (setq all (permutazioni '(1 2 3 4 5 6 7 8 9))) (print "Fatto") (resume))
;-> Fatto

Vediamo quante sono le permutazioni:
(length all)
;-> 362880

Vediamo una permutazione:
(all 1)
;-> (1 2 3 4 5 6 7 9 8)

Verifichiamo la correttezza della funzione di controllo:
(check3 (all 1) 15)
;-> nil

Verifichiamo quali permutazioni sono quadrati magici:

(setq out '())

(dolist (el all)
  (if (check3 el 15)
      (push el out -1)
  )
)

(length out)
;-> 8

out
;-> ((2 7 6 9 5 1 4 3 8)
;->  (2 9 4 7 5 3 6 1 8)
;->  (4 3 8 9 5 1 2 7 6)
;->  (4 9 2 3 5 7 8 1 6)
;->  (6 1 8 7 5 3 2 9 4)
;->  (6 7 2 1 5 9 8 3 4)
;->  (8 1 6 3 5 7 4 9 2)
;->  (8 3 4 1 5 9 6 7 2))

Per attraversare una lista la funzione "dolist" è molto più veloce dell'uso di un ciclo "for" con l'indicizzazione.

(setq out1 '())
(time
(for (i 0 (- (length all) 1))
  (setq el (all i))
  (if (check3 el 15)
      (push el out1 -1)
  )
  (if (= (% i 10000) 0 (println i)))
)
)
;->  1994673.832; 33 minuti...provatela solo se avete tempo...

Salviamo il risultato:

(save "qm3x3.lsp" 'out)
;-> true

Rendiamo il risultato più leggibile:

(dolist (el out)
  (println (el 0) { } (el 1) { } (el 2))
  (println (el 3) { } (el 4) { } (el 5))
  (println (el 6) { } (el 7) { } (el 8))
  (println)
)

                          Lo Shu
2 7 6    2 9 4    4 3 8    4 9 2    6 1 8    6 7 2    8 1 6    8 3 4
9 5 1    7 5 3    9 5 1    3 5 7    7 5 3    1 5 9    3 5 7    1 5 9
4 3 8    6 1 8    2 7 6    8 1 6    2 9 4    8 3 4    4 9 2    6 7 2

Il quarto quadrato magico è lo Shu (simbolo divinatorio e matematico cinese).
Ogni altro quadrato magico di ordine tre è ottenuto dallo Shu per rotazione e/o riflessione.


Mastermind numerico
-------------------

(define (guessNumber)
  (local (num num$ found guess turnlst digits numdigits numTurn guessValue digitOK orderOK)
    ; lista di ogni turno
    ; turno -> (numTurn guess$ digitOK orderOK)
    (setq turnlst '())
    ; Inserire il numero di cifre del numero random
    (setq numdigits (input-integer "Numero di cifre (2-10): " 2 10))
    ; Generazione del numero random con cifre tutte diverse
    ; Validi anche i numeri con 0 iniziale (es. 0342)
    (setq num$ "")
    (setq digits (explode "0123456789"))
    (setq num$ (join (slice (randomize digits) 0 numdigits 1)))
    (setq num (int num$))
    ;(println num$)
    (setq numTurn 0)
    (setq found nil)
    ; Ciclo del gioco
    (while (not found)
      ; Inserire il numero (tentativo)
      (setq guess$ (input-string "Numero da provare: "))
      (while (not (guessControl guess$ num$))
        (setq guess$ (input-string "Numero da provare: "))
      )
      (++ numTurn)
      ;confronto tra numero random e guess
      ;numero di cifre di guess$ presenti in num$
      (setq digitOK (checkDigitOK num$ guess$))
      ;numero di cifre di guess$ nello stesso ordine in num$
      (setq orderOK (checkOrderOK num$ guess$))
      ; aggiorno la lista dei turni
      (push (list numTurn guess$ digitOK orderOK) turnlst -1)
      ;stampo la lista dei turni
      (println "turno    numero    cifreOK  ordineOK")
      (dolist (el turnlst)
        (println (format "%3d %10s %9d %9d" el))
      )
      ;controllo fine del gioco (numero indovinato)
      (if (= num$ guess$)
        (begin
          (println "NUMERO INDOVINATO --> " num$)
          (setq found true))
      )
    )
  );local
)

; routine che controlla la correttezza del numero di input (guess)
(define (guessControl guess$ num$)
  (cond ((not (numero? guess$)) (println "Inserire solo cifre...") nil)
        ((!= (length num$) (length guess$))
          (println "Numero di cifre errato...") nil) ;numero di cifre errato
        ((!= (unique (explode guess$)) (explode guess$))
          (println "Numero con cifre ripetute...") nil) ;numero con cifre ripetute
        (true true)
  )
)

; routine che controlla se la stringa è composta solo da cifre
(define (numero? stringa)
  (while (= "0" (stringa 0))
    (setq stringa (slice stringa 1)))
  (if (= (string (int stringa 0)) stringa) true nil))

(numero? "1234")
;-> true
(numero? "012a5")
;-> nil
(numero? "012")
;-> true

;routine che permette l'input di una stringa
(define (input-string message)
  (print message)
  (while (not (string? (read-line)))
    (print message)
  )
  (current-line)
)

;routine che permette l'input di un numero intero (compreso tra minv e maxv)
(define (input-integer message minv maxv)
  (print message)
  (while (or (not (integer? (int (read-line))))
             (> (int (current-line)) maxv)
             (< (int (current-line)) minv))
    (print message)
  )
  (int (current-line))
)

; Restituisce il numero di cifre di str1 che
; hanno la stessa posizione in str2
(define (checkOrderOK str1 str2)
  (local (numOK)
    (setq numOK 0)
    (for (i 0 (- (length str1) 1))
      (if (= (str1 i) (str2 i)) (++ numOK))
    )
    numOK
  )
)

(checkOrderOK "1234" "4321")
;-> 0
(checkOrderOK "123" "124")
;-> 2

; Restituisce il numero di cifre di str1 presenti in str2
(define (checkDigitOK str1 str2)
  (local (numOK)
    (setq numOK 0)
    (for (i 0 (- (length str1) 1))
      (if (!= (find (str1 i) str2) nil) (++ numOK))
    )
    numOK
  )
)

(checkDigitOK "012" "123")
;-> 2

(checkDigitOK "123" "132")
;-> 3

Adesso possiamo provare il gioco:

(guessNumber)
Numero di cifre (2-10): 3
Numero da provare: 515
Numero con cifre ripetute...
Numero da provare: 428
turno    numero    cifreOK  ordineOK
  1        428         2         2
Numero da provare: 183
turno    numero    cifreOK  ordineOK
  1        428         2         2
  2        183         0         0
Numero da provare: 421
turno    numero    cifreOK  ordineOK
  1        428         2         2
  2        183         0         0
  3        421         2         2
Numero da provare: 426
turno    numero    cifreOK  ordineOK
  1        428         2         2
  2        183         0         0
  3        421         2         2
  4        426         2         2
Numero da provare: er4
Inserire solo cifre...
Numero da provare: 1
Numero di cifre errato...
Numero da provare: 12345
Numero di cifre errato...
Numero da provare: 427
turno    numero    cifreOK  ordineOK
  1        428         2         2
  2        183         0         0
  3        421         2         2
  4        426         2         2
  5        427         3         3
NUMERO INDOVINATO --> 427
true


Algoritmo babilonese sqrt(x)
----------------------------

Dato un valore x > 0, l'algoritmo babilonese permette di calcolare un valore approssimato della radice quadrata di x sqrt(x). Questo metodo funziona nel modo seguente:

1) Assegna un valore positivo alla stima-iniziale della radice (quanto più essa è prossima alla radice, tanto migliore è la convergenza dell'algoritmo)
2) calcola la nuova stima come la media di stima-iniziale e x/stima-iniziale
3) Se la differenza tra stima-iniziale e stima è minore della precisione desiderata, allora la stima è la soluzione (radice), altrimenti poni la stima-iniziale uguale alla stima e continua al passo 2.

Questo algoritmo può essere rappresentato dalla seguente formula:

          1              x
x(n+1) = --- * (x(n) + -----)
          2            x(n)

Scriviamo la funzione:

(define (rq x err)
  (local (stima-iniziale stima differenza n)
    (setq n 0)
    (setq stima-iniziale (div x 2)) ;stima iniziale vale x/2
    (setq differenza (add 2 err))   ;differenza iniziale > err
    (while (> differenza err)
      (setq stima (div (add stima-iniziale (div x stima-iniziale)) 2))
      (setq differenza (abs(sub stima-iniziale stima)))
      (setq stima-iniziale stima)
      (++ n)
    )
    (list stima n)
  )
)

(rq 0.38 0.00001)
;-> (0.6164414002968977 6)

(rq 0.09 0.00001)
;-> (0.3 7)

(rq 0.123456789 0.0000001)
;-> (0.3513641828644462 7)
(mul 0.3513641828644462 0.3513641828644462)
;-> 0.123456789

(rq 123456 0.0000001)
(351.363060095964 12)
(mul 351.363060095964 351.363060095964)
;-> 123456

(rq 123456789 0.0000001)
;-> (11111.11106055556 18)
(mul 11111.11106055556 11111.11106055556)
;-> 123456789.0000001

Vediamo una versione che sceglie la stima iniziale in base al valore di x:

(define (rq x err)
  (local (stima-iniziale stima differenza n)
    (setq n 0)
    (if (> x 1)  ;stima iniziale
        (setq stima-iniziale (div x 2))
        (setq stima-iniziale (mul x 2))
    )
    (setq differenza (add 2 err))   ;differenza iniziale > err
    (while (> differenza err)
      (setq stima (div (add stima-iniziale (div x stima-iniziale)) 2))
      (setq differenza (abs(sub stima-iniziale stima)))
      (setq stima-iniziale stima)
      (++ n)
    )
    (list stima n)
  )
)

(rq 0.38 0.00001)
;-> (0.6164414002968979 4)

(rq 0.09 0.00001)
;-> (0.3000000001396984 4)

(rq 0.09 0.0000001)
;-> (0.3 5)

(rq 0.123456789 0.0000001)
;-> (0.3513641828644462 5)
(mul 0.3513641828644462 0.3513641828644462)
;-> 0.123456789

(rq 123456 0.0000001)
(351.363060095964 12)
(mul 351.363060095964 351.363060095964)
;-> 123456

(rq 123456789 0.0000001)
;-> (11111.11106055556 18)
(mul 11111.11106055556 11111.11106055556)
;-> 123456789.0000001

Questa ultima versione ha una convergenza più rapida con i numeri minori di 1.

L'algoritmo può anche essere definito nel modo seguente:

1) Poni il valore iniziale della stima della radice x0 uguale al numero x
2) Inizializza y = 1.
3) Fino al raggiungimento della precisione desiderata:
   a) calcolare prossima stima: x0 = (x0 + y)/2
   b) Imposta y = x / x0

(define (rq x err)
  (local (x0 y)
    (setq y 1)
    (setq x0 (div x 2)) ; stima valore iniziale uguale al numero x
    (while (> (abs (sub x0 y)) err) ;
      (setq x0 (div (add x0 y) 2))
      (setq y (div x x0))
    )
    x0
  )
)

(rq 4.5 0.000001)
;-> 2.121320746178046
(mul (rq 4.5 0.000001) (rq 4.5 0.000001))
;-> 4.500001708165383

(rq 4 0.000001)
;-> 2.00000000000012

La complessità temporale di questo algoritmo è O(log(log(n))).


Radice quadrata intera di un numero intero (2^64 bit)
---------------------------------------------------

(define (isqrt x)
  (local (x1 s g0 g1)
    (cond ((<= x 1) 1)
          ((> x 4294967295) nil)
          (true
            (setq s 1)
            (setq x1 (- x 1))
            (if (> 4294967295 x1) (setq s (+ s 16) x1 (>> x1 32)))
            (if (> 65535 x1) (setq s (+ s 8) x1 (>> x1 16)))
            (if (> 255 x1) (setq s (+ s 4) x1 (>> x1 8)))
            (if (> 15 x1) (setq s (+ s 2) x1 (>> x1 4)))
            (if (> 3 x1) (setq s (+ s 1)))
            (setq g0 (<< 1 s))
            (setq g1 (>> (+ g0 (>> x s)) 1))
            (while (< g1 g0) ;while approssimazione
              (setq g0 g1) ; strettamente decrescente
              (setq g1 (>> (+ g0 (/ x g0))  1))
            )
          )
    )
    g0
  )
)

(isqrt 4)
;-> 2

(isqrt 18)
;-> 4

(isqrt 65536)
;-> 256

(isqrt 4294967295)
;-> (65535)

(isqrt 4294967296)
;-> nil

(* 4294967296L 4294967296L)
;-> 18446744073709551616L


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

1) il numero "n" (1.42703)
2) in numero di cifre del periodo "np" (3)
3) in numero di cifre dell'antiperiodo "na" (2)

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


Sistemi Lineari (Cramer)
------------------------
Proviamo a scrivere un programma che risolve i sistemi lineari.
Utilizzeremo il metodo di Cramer perchè newLISP mette a disposizione una funzione standard per calcolare il determinante di una matrice.

Esempio 1

  x + 2y + 3z =  1
-3x - 2y + 3z = -1
 4x - 5y + 2z =  1

Soluzione
 x = detX/det
 y = detY/det
 z = detZ/det

 x = 21/58, y = 4/29, z = 7/58
 x≈0.36207, y≈0.13793, z≈0.12069

Impostiamo i valori della matrice:

(setq m '((1 2 3) (-3 -2 3) (4 -5 2)))
m
;-> ((1 2 3) (-3 -2 3) (4 -5 2))

Calcoliamo il determinante:

(setq det-m (det m))
;-> 116

Impostiamo il vettore dei termini noti:

(setq n '(1 -1 1))

Calcoliamo determinante per la variabile x sostituendo prima la colonna 0 della matrice con i valori della colonna dei termini noti:

(setf (m 0 0) (n 0))
(setf (m 1 0) (n 1))
(setf (m 2 0) (n 2))
m
;-> ((1 2 3) (-1 -2 3) (1 -5 2))

Calcoliamo il determinante di x:

(setq detX (det m))
;-> 42

Calcoliamo la soluzione per x:

(setq x (div detX det-m))
;-> 0.3620689655172414

Impostiamo i valori della matrice:
(setq m '((1 2 3) (-3 -2 3) (4 -5 2)))

Calcoliamo determinante per la variabile y sostituendo prima la colonna 1 della matrice con i valori della colonna dei termini noti:

(setf (m 0 1) (n 0))
(setf (m 1 1) (n 1))
(setf (m 2 1) (n 2))
m
;-> ((1 1 3) (-3 -1 3) (4 1 2))

Calcoliamo il determinante di y:

(setq detY (det m))
;-> 16

Calcoliamo la soluzione per y:

(setq y (div detY det-m))
;-> 0.1379310344827586

Impostiamo i valori della matrice:
(setq m '((1 2 3) (-3 -2 3) (4 -5 2)))

Calcoliamo determinante per la variabile z sostituendo prima la colonna 2 della matrice con i valori della colonna dei termini noti:

(setf (m 0 2) (n 0))
(setf (m 1 2) (n 1))
(setf (m 2 2) (n 2))
m
;-> ((1 2 1) (-3 -2 -1) (4 -5 1))

Calcoliamo il determinante di z:

(setq detZ (det m))
;-> 14

Calcoliamo la soluzione per z:

(setq z (div detZ det-m))
;-> 0.1206896551724138

Esempio 2

 2x + y +  z =  1
 4x - y +  z = -5
 -x + y + 2z =  5

Soluzione
x = detX/det
y = detY/det
z = detZ/det

x = -1, y = 2, z = 1

Impostiamo i valori della matrice:

(setq m '((2 1 1) (4 -1 1) (-1 1 2)))
m
;-> ((2 1 1) (4 -1 1) (-1 1 2))

Calcoliamo il determinante:

(setq det-m (det m))
;-> -12
(setq n '(1 -5 5))

Calcoliamo determinante per la variabile x sostituendo prima la colonna 0 della matrice con i valori della colonna dei termini noti:

(setf (m 0 0) (n 0))
(setf (m 1 0) (n 1))
(setf (m 2 0) (n 2))
m

Calcoliamo il determinante di x:

(setq detX (det m))
;-> 12

Calcoliamo la soluzione per x:
(setq x (/ detX det-m))
;-> -1

Impostiamo i valori della matrice:
(setq m '((2 1 1) (4 -1 1) (-1 1 2)))

Calcoliamo determinante per la variabile y sostituendo prima la colonna 1 della matrice con i valori della colonna dei termini noti:

(setf (m 0 1) (n 0))
(setf (m 1 1) (n 1))
(setf (m 2 1) (n 2))
m

Calcoliamo il determinante di y:

(setq detY (det m))
;-> 24

Calcoliamo la soluzione per y:

(setq y (/ detY det-m))
;-> 2

Impostiamo i valori della matrice:

(setq m '((2 1 1) (4 -1 1) (-1 1 2)))

Calcoliamo determinante per la variabile z sostituendo prima la colonna 2 della matrice con i valori della colonna dei termini noti:

(setf (m 0 2) (n 0))
(setf (m 1 2) (n 1))
(setf (m 2 2) (n 2))
m

Calcoliamo il determinante di z:

(setq detZ (det m))
;-> -12

Calcoliamo la soluzione per z:

(setq z (/ detZ det-m))
;-> 1

Scriviamo la funzione:

(define (solve-linsys matrice noti)
  (local (dim detm det-i sol copia)
    (setq dim (length matrice))
    (setq sol '())
    (setq copia matrice)
    (setq detm (det copia))
    ; la soluzione è indeterminata se il determinante vale zero.
    (if (= detm 0) (setq sol nil)
    ;(println detm)
      (for (i 0 (sub dim 1))
        (for (j 0 (sub dim 1))
          (setf (copia j i) (noti j))
        )
        (setq det-i (det copia))
        ;(println det-i)
        (push (div det-i detm) sol -1)
        (setq copia matrice)
      );endfor
    );endif
    sol
  );local
)

(solve-linsys '((2 1 1) (4 -1 1) (-1 1 2)) '(1 -5 5))
;-> (-1 2 1)

(solve-linsys '((1 2 3) (-3 -2 3) (4 -5 2)) '(1 -1 1))
;-> (0.3620689655172414 0.1379310344827586 0.1206896551724138)

Proviamo con un sistema 8x8:

(solve-linsys
'((2 3 3 -4 -5 3 -2 3)
  (-3 3 -1 2 3 5 -2 3)
  (4 2 4 -4 -2 3 -1 -5)
  (-3 2 2 -4 -1 4 -1 -5)
  (2 6 -3 -4 -4 3 -2 -3)
  (2 -6 -1 3 -3 4 -1 -1)
  (3 -1 -2 -3 -1 3 1 1)
  (1 -2 -3 4 -1 -3 2 3))
'(1 -1 1 2 3 2 -2 2))
;-> (-0.2907517086232766 0.4541737926192612 0.1222139219887456 0.7272295937332997
;->  -0.9577686974650513 0.1669345810796059 0.682061578219236 -0.3880884752566235)


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
Il problema del compleanno è stato formulato nel 1939 da Richard von Mises.

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
(comunque per ottenere l'evento certo (1) occorre considerare un gruppo di almeno 366 persone)


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
  (let (pot 1L) (dotimes (x m) (setq pot (* pot n))))
)

(potenza 3 6)
;-> 729L

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

(time (karatsuba 12345 6789) 10000)
;-> 359.359

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

(time (karatsuba 12345 6789) 10000)
;-> 33347.174

Nota:
Nel caso di rappresentazioni binarie le operazioni di quoziente e prodotto relativi a una potenza di 2 (2^k) si riducono semplicemente a spostamenti (right/left shift) di k cifre.
Analogamente, il resto della divisione per 2^k corrisponde alla selezione delle ultime k cifre.

Per implementare l'algoritmo anche per i numeri big integer dobbiamo tenere conto del carattere "L" al termine di ogni numero intero big integer.

(define (karatsuba num1 num2)
  (local (len1 len2 m m2 high1 low1 high2 low2 z0 z1 z2)
    (cond ((or (< num1 10) (< num2 10)) (* num1 num2))
          (true
            (setq len1 (length (string num1)))
            (if (= (last (string num1)) "L") (-- len1))
            (setq len2 (length (string num2)))
            (if (= (last (string num1)) "L") (-- len2))
            (setq m (max len1 len2))
            (setq m2 (/ m 2))
            (setq n1$ (string num1))
            (if (= (last n1$) "L") (setq n1$ (chop n1$)))
            (setq n2$ (string num2))
            (if (= (last n2$) "L") (setq n2$ (chop n2$)))
            (setq high1 (bigint (slice n1$ 0 (- (length n1$) m2))))
            (setq low1  (bigint (slice n1$ (- (length n1$) m2) m2)))
            (setq high2 (bigint (slice n2$ 0 (- (length n2$) m2))))
            (setq low2  (bigint (slice n2$ (- (length n2$) m2) m2)))
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

(karatsuba 12345 6789)
;-> 83810205

(karatsuba 9223372036854775807 9223372036854775807)
;-> 85070591730234615847396907784232501249L

(* 9223372036854775807L 9223372036854775807L)
;-> 85070591730234615847396907784232501249L

(time (karatsuba 12345 6789) 10000)
;-> 687.468

La funzione per i big integer è veloce la metà della versione per interi.

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
Esempio: 83*154. Si dimezza il numero 83 (considerando i valori interi) e si raddoppia il 154. Si sommano le righe della colonna del 154 corrispondenti alle righe dispari nella colonna del numero 83. Totale: 12782.

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

Vediamo la velocità della funzione primitiva di addizione "*":

(* 12345232332323L 6782323232323239)
;-> 83729356055942287981803754197L

(time (* 12345232332323L 6782323232323239) 100000)
;-> 91.905


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
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 n)
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

(define (num-conigli mese)
  (fibo-i (add mese 1)))

(for (x 1 12) (print (num-conigli x) { }))
;-> 2L 3L 5L 8L 13L 21L 34L 55L 89L 144L 233L 377L

(num-conigli 35)
;-> 24157817L

(time (num-conigli 35))
;-> 0

Con la versione iterativa il calcolo è immediato.


The Game of Pig
---------------

Il gioco è stato inventato da John Scarne nel 1945.
Ad ogni turno, ogni giocatore lancia ripetutamente un dado finché non viene tirato un 1 o il giocatore decide di "passare":
Se il giocatore lancia un 1, il punteggio del turno è nullo e passa la mano al prossimo giocatore.
Se il giocatore lancia un altro numero (2..6), il numero viene aggiunto al punteggio del turno  e il turno del giocatore continua.
Se un giocatore decide di "passare", il suo punteggio del turno viene aggiunto al suo punteggio totale, e diventa il turno del prossimo giocatore.
Vince il giocatore che arriva o supera 100 (poichè il turno deve terminare per tutti i giocatori, potrebbero esserci più giocatori che superano 100, allora il vincitore è quello con il punteggio più alto).

Esempio:

Turno |  Player | punteggio Turno | punteggio Totale
----------------------------------------------------
1     |  A      | (2-2-3-5) 12    | 12
1     |  B      | (2-4-5-1)  0    |  0
2     |  A      | (6-1)      0    | 12
2     |  B      | (3-4-4)   11    | 11
3     |  A      | (3-4-2)    9    | 21
3     |  B      | (3-4)      7    | 18
4     |  ...    | ...       ...   | ...

Quale strategia massimizza le probabilità di vittoria ?

Quanto vale il valore medio dei punti ottenuti prima che esca un 1 ?

La seguente funzione crea una lista con n elementi del tipo (lanci totale):

(define (mediaVal n)
  (local (freq tot val lanci continua)
    (setq freq '())
    (for (i 0 n)
      (setq continua true)
      (setq tot 0)
      (setq val 0)
      (setq lanci 0)
      (while continua
        (setq val (add (rand 6) 1))
        (++ lanci)
        (if (= val 1)
          (begin
            (setq continua nil)
            (push (list lanci tot) freq -1)
          )
          (setq tot (add tot val))
        )
      )
    )
    freq
  )
)

(mediaVal 10)
;-> ((2 6) (7 25) (3 8) (3 9) (6 18) (4 15) (5 17) (2 6) (12 40) (2 5) (8 32))

Creiamo una lista con 100000 elementi:

(silent (setq f (mediaVal 100000)))

Analizziamo il risultato:

Numero totale di lanci:
(apply add (map first f))
;-> 600613 ;numero totale di lanci

Numero medio di lanci:
(div (apply add (map first f)) (length f))
;-> 6.006 ;numero medio di lanci

Punteggio totale:
(apply add (map last f))
;-> 2003171 ;punteggio totale

Punteggio medio per ogni turno:
(div (apply add (map last f)) (length f))
;-> 20.03 ;punteggio medio per ogni turno

Adesso scriviamo un programma che simula "The game of Pig":

(define (pigs n maxvalA maxlanciA maxvalB maxlanciB)
  (local (res vittA vittB)
    (setq vittA 0 vittB 0)
    (for (i 0 n)
      (setq res (game maxvalA maxlanciA maxvalB maxlanciB))
      (if (= res "A")
        (++ vittA)
        (++ vittB)
      )
    )
    (list vittA vittB)
  )
)

Vediamo la funzione che simula una partita tra due giocatori A e B. Con i parametri possiamo stabilire per ogni giocatore:
1) il numero massimo di lanci per ogni giocata (maxlanci)
2) il valore massimo per ogni giocata (maxval)
In questo modo possiamo variare la strategia dei giocatori per definire quale sia la migliore.

(define (game maxvalA maxlanciA maxvalB maxlanciB)
  (local (totA totB parA parB valA valB playgame continua)
    (setq totA 0 totB 0)
    ; "playgame" controlla il termine di una partita
    (setq playgame true)
    ; "playgame" diventa nil quando uno dei due giocatori ha superato i 100 punti
    (while playgame
      ; player A
      (setq parA 0)
      (setq lanciA 0)
      ; "continua" controlla se la giocata del giocatore è terminata
      ; "continua" diventa nil se:
      ; esce un 1 OR
      ; il giocatore ha raggiunto il numero massimo di lanci OR
      ; il giocatore ha raggiunto il valore massimo
      (setq continua true)
      (while continua
        ; lancio del dado
        (setq valA (add (rand 6) 1))
        (++ lanciA)
        (if (= valA 1)
          (begin ; è uscito 1
            ; annullo il punteggio parziale
            (setq parA 0)
            ; tocca al giocatore B
            (setq continua false)
          )
          (begin ; non è uscito 1 (2..6)
            ;aggiorno punteggio parziale A
            (setq parA (add parA valA))
          )
        )
        ;(println "valA = " valA { } "parA = " parA { } "lanciA = " lanciA)
        ;(println "totA = " totA)
        ;(read-key)
        ; controllo superamento max lanci
        (if (>= lanciA maxlanciA) (setq continua false))
        ; controllo superamento max lanci
        (if (>= parA maxvalA) (setq continua false))
      )
      ; aggiorno punteggio totale A
      (setq totA (add totA parA))
      ;(println "totA = " totA)
      ; controllo fine del gioco
      (if (> totA 100) (setq playgame false))
      ;--------------------------------------------
      ; player B
      (setq parB 0)
      (setq lanciB 0)
      ; "continua" controlla se la giocata del giocatore è terminata
      ; "continua" diventa nil se:
      ; esce un 1 OR
      ; il giocatore ha raggiunto il numero massimo di lanci OR
      ; il giocatore ha raggiunto il valore massimo
      (setq continua true)
      ;(while (and continua playgame) ;B non gioca l'ultimo turno
      (while continua
        ; lancio del dado
        (setq valB (add (rand 6) 1))
        (++ lanciB)
        (if (= valB 1)
          (begin ; è uscito 1
            ; annullo il punteggio parziale
            (setq parB 0)
            ; tocca al giocatore A
            (setq continua false)
          )
          (begin ; non è uscito 1 (2..6)
            ;aggiorno punteggio parziale B
            (setq parB (add parB valB))
          )
        )
        ;(println "valB = " valB { } "parB = " parB { } "lanciB = " lanciB)
        ;(println "totB = " totB)
        ;(read-key)
        ; controllo superamento max lanci
        (if (>= lanciB maxlanciB) (setq continua false))
        ; controllo superamento max lanci
        (if (>= parB maxvalB) (setq continua false))
      )
      ; aggiorno punteggio totale B
      (setq totB (add totB parB))
      ;(println "totB = " totB)
      ; controllo fine del gioco
      (if (> totB 100) (setq playgame false))
      ;(println totA { } totB)
    );while playgame
    ; determino il vincitore
    (if (> totA totB) "A" "B")
  )
)

(game 100 2 20 2)
;-> "B"

Giochiamo con i parametri (maxvalA maxlanciA maxvalB maxlanciB):

(pigs 100000 100 8 100 8)
;-> (49811 50190)
(pigs 100000 100 8 20 4)
;-> (45632 54369)
(pigs 100000 20 8 20 4)
;-> (56483 43518)
(pigs 100000 20 5 20 4)
;-> (53505 46496)
(pigs 100000 50 8 20 4)
;-> (45734 54267)
(pigs 100000 30 8 20 4)
;-> (46641 53360)
(pigs 100000 20 20 20 4)
;-> (56520 43481)
(pigs 100000 20 20 20 100)
;-> (49661 50340)
(pigs 100000 30 5 20 5)
;-> (49904 50097)
(pigs 100000 20 10 20 3)
;-> (66592 33409)
(pigs 100000 25 12 20 10)
;-> (50046 49955)
(pigs 100000 30 15 20 10)
;-> (38903 61098)
(pigs 100000 20 10 21 15)
;-> (51128 48873)
(pigs 100000 25 12 25 12)
;-> (49668 50333)
(pigs 1000000 25 12 25 12)
;-> (497380 502621)

Come si vede sembra che utilizzando 20 e 25 come valori massimi per ogni giocata (maxval) si massimizzano la probabilità di vittoria. Dalle prove effettuate sembra che 25 sia leggermente migliore che 20.
L'articolo "Practical Play of the Dice Game Pig" di Neller e Presser:
http://cs.gettysburg.edu/~tneller/papers/umap10.pdf
affronta il gioco matematicamente e raggiunge le stesse conclusioni: il numero 20 e il numero 25 massimizzano le probabilità di vittoria.


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


Ricerca stringa in un testo (algoritmo base)
--------------------------------------------

Dato un testo e una stringa (pattern), scrivere una funzione che ritorna gli indici di tutte le occorrenze della stringa contenute nel testo.
Si può presumere che il testo sia più lungo della stringa.
Esempi:
Input:  txt [] = "TESTO DI PROVA"
        str [] = "TEST"
Output: (0)

Input: txt [] = "OOHOOXOOWOOHOOHO"
       str [] = "OOHO"
Output: (0 9 12)

Questo algoritmo viene chiamato "naive pattern searching":
Facciamo scorrere la stringa (pattern) sul testo carattere per carattere per verificarne la corrispondenza. Se viene trovata una corrispondenza, scorriamo in avanti di uno per ricercare le occorrenze successive.

(define (trova pattern testo)
  (local (m n j out)
    (setq out '())
    (setq m (length pattern))
    (setq n (length testo))
    ; ciclo per far scorrere il pattern carattere per carattere
    (for (i 0 (sub n m))
      ; dall'indice corrente i, verifico la corrispondenza del pattern sul testo
      (setq j 0)
      (while (and (< j m) (= (testo (add i j)) (pattern j)))
        (++ j)
      )
      ;(if (= j m) (println i))
      ; se ho trovato una corrispondenza, aggiorno il risultato
      (if (= j m) (push i out -1))
    )
    out
  );local
)

(trova "TEST" "TEST: TESTO DI PROVA")
;-> (0 6)

(trova "OOHO" "OOHOOXOOWOOHOOHO")
;-> (0 9 12)

(trova "aba" "abababababa")
;-> (0 2 4 6 8)

Qual è il caso migliore?
Il caso migliore si verifica quando il primo carattere del pattern non è presente nel testo.
txt [] = "AABCCAADDEE";
pat [] = "FAA";
Il numero di confronti nel migliore dei casi è O(n).

Qual è il caso peggiore?
Il caso peggiore si verifica nei seguenti scenari.
1) Quando tutti i caratteri del testo e del pattern sono uguali.
txt [] = "AAAAAAAAAAAAAAAAAA";
pat [] = "AAAAA";
2) Il caso peggiore si verifica anche quando solo l'ultimo carattere è diverso.
txt [] = "AAAAAAAAAAAAAAAAAB";
pat [] = "AAAAB";
Il numero di confronti nel caso peggiore è O(m*(n-m+1)).

Nei testi italiani le lettere ripetute sono improbabili, ma questo potrebbero verificarsi in altri casi (ad esempio nei testi binari).


Ricerca stringa in un testo (algoritmo Z)
-----------------------------------------

Questo algoritmo trova tutte le occorrenze di una stringa (pattern) in un testo in tempo lineare. Sia "n" la lunghezza del testo, sia "m" quella del pattern, quindi il tempo totale impiegato è O(m+n) con complessità dello spazio lineare. La complessità di tempo e spazio è uguale all'algoritmo KMP, ma questo algoritmo è più semplice da capire.
In questo algoritmo, costruiamo una lista Z.
Cos'è la lista Z?
Per una stringa str[0..n-1], la lista Z ha la stessa lunghezza della stringa. Un elemento Z[i] di Z memorizza la lunghezza della sottostringa più lunga che inizia da str[i] che è anche un prefisso di str[0..n-1]. La prima voce dell'array Z non ha significato in quanto la stringa completa è sempre prefisso di se stessa.

Esempio:
Indice           0   1   2   3   4   5   6   7   8   9  10  11
Testo            a   a   b   c   a   a   b   x   a   a   a   z
Z Valori         x   1   0   0   3   1   0   0   2   2   1   0

Altri esempi:
str = "aaaaaa"
Z = (x 5 4 3 2 1)

str = "aabaacd"
Z = (x 1 0 2 1 0 0)

str = "abababab"
Z = (x 0 6 0 4 0 2 0)

In che modo la lista Z è utile nella ricerca di pattern in tempo lineare?
L'idea è quella di concatenare pattern e testo e creare una stringa "P$T" dove P è il pattern, $ è un carattere speciale che non deve essere presente nel pattern e nel testo, e T è il testo. Costruire la lista Z per la stringa concatenata. Nella lista Z, se il valore Z in qualsiasi punto è uguale alla lunghezza del pattern, allora il pattern è presente in quel punto.

Esempio:
Pattern P = "aab",  Testo T = "baabaa"

La stringa concatenata vale = "aab~baabaa"

La lista Z per la stringa concatenata vale (x 1 0 0 0 3 1 0 2 1).
Poichè la lunghezza del pattern vale 3, il valore 3 presente nella lista Z indica che il pattern si trova nel testo.

Come costruire la lista Z?
Una soluzione semplice è costituita da due cicli annidati, il ciclo esterno percorre ogni indice e il ciclo interno trova la lunghezza del prefisso più lungo che corrisponde (match) alla sottostringa che inizia con l'indice corrente. La complessità temporale di questa soluzione è O(n^2).
Possiamo costruire la lista Z in tempo lineare.
L'idea è di mantenere un intervallo [L, R] che è l'intervallo con Rmax tale che [L, R] è una sottostringa di prefisso (sottostringa che è anche prefisso).

I passaggi per mantenere questo intervallo sono i seguenti:

1) Se i > R allora non esiste una sottostringa di prefisso che inizi prima di e termina dopo i, quindi ripristiniamo L e R e calcoliamo nuovo [L, R] confrontando str [0 ..] in str [i ..] e ottenendo Z [i] (= R-L + 1).

2) Se i <= R allora lascia K = i-L, ora Z[i] >= min(Z[K], R-i+1) perché str[i ..] corrisponde a str[K ..] per almeno R-i+1 caratteri (essi si trovano nell'intervallo [L, R] che sappiamo essere una sottostringa di prefisso).
Ora bisogna trattare due sottocasi:

a) Se Z[K] < R-i+1 allora non esiste una sottostringa di prefisso a partire da str[i] (altrimenti Z[K] sarebbe più grande) quindi Z[i] = Z[K] e l'intervallo [L, R] rimane lo stesso.

b) Se Z[K] >= R-i+1, allora è possibile estendere l'intervallo [L, R], quindi imposteremo L come i e inizieremo il controllo della corrispondenza da str[R] in poi per calcolare una nuova R con cui aggiorneremo l'intervallo [L, R] e calcoleremo Z [i] (= R - L + 1).

Per una migliore comprensione della procedura, vedere la seguente animazione:
http://www.utdallas.edu/~besp/demo/John2010/z-algorithm.htm

L'algoritmo viene eseguito in tempo lineare perché non confrontiamo mai un carattere minore di R e con la corrispondenza aumentiamo R di uno, quindi ci sono al massimo T confronti. Nel caso di mancata corrispondenza, questa avviene solo una volta per ogni i (a causa della quale R si arresta), questo comporta al massimo T confronti, quindi la complessità totale rimane lineare.

La seguente funzione restituisce una lista di indici se il "pattern" (stringa) viene trovato nel "testo", altrimenti restituisce la lista vuota:

(define (trovaZ pattern testo)
  (local (concat ll Z out)
    (setq out '())
    ; Crea stringa concatenata "P~T"
    (setq concat (append pattern "~" testo))
    (setq ll (length concat))
    (setq Z (dup  0 ll))
    ; Costruisce la lista array
    (setq Z (creaZlista concat Z))
    ; Loop sulla lista Z per cercare i match
    (for (i 0 (sub ll 1))
      (if (= (Z i) (length pattern))
        ; aggiunge l'indice trovato al risultato
        (push (add i (- (length pattern)) (- 1)) out -1)
      )
    )
    out
  );local
)

; Crea la lista Z per la stringa str
(define (creaZlista str Z)
  (local (n L R k)
    (setq n (length str))
    ; [L,R] crea un a finestra che corrisponde con il prefisso di str
    (setq L 0 R 0)
    (for (i 0 (sub n 1))
      ; se i>R allora niente corrisponde,
      ; quindi calcoliamo Z[i] usando il metodo base.
      (if (> i R)
        (begin
          (setq L i R i)
          ; R-L = 0 all'inizio, per iniziare il controllo dall'indice 0.
          ; Per esempio, per "ababab" e i = 1,
          ; il valore di R rimane 0 e Z[i] diventa 0.
          ; Per la stringa "aaaaaa" e i = 1,
          ; Z[i] e R diventano 5
          (while (and (< R n) (= (str (sub R L)) (str R)))
            (++ R)
          )
          (setq (Z i) (sub R L))
          (-- R)
        )
        ;else
        ; k = i-L, in questo modo k è relativo al numero
        ; che corrisponde all'intervallo [L,R].
        (begin
          (setq k (sub i L))
          ; se Z [k] è inferiore all'intervallo rimanente
          ; allora Z [i] sarà uguale a Z [k].
          ; Ad esempio, str = "ababab", i = 3, R = 5 e L = 2
          (if (< (Z k) (add R (- i) 1))
              (setq (Z i) (Z k))
              ; Per esempio str = "aaaaaa" e i = 2, R vale 5,
              ; L vale 0
              ;else
              (begin
                (setq L i)
                (while (and (< R n) (= (str (sub R L)) (str R)))
                  (++ R)
                )
                (setq (Z i) (sub R L))
                (-- R)
              )
          )
        )
      );if
    );for
    Z
  );local
)

(trovaZ "max" "max is the maximum")
;-> (0 11)

(trovaZ "maxx" "max is the maximum")
;-> ()

(trovaZ "aba" "abababababa")
;-> (0 2 4 6 8)


Distanza di Levenshtein
-----------------------

La distanza di Levenshtein (LD) è una misura della somiglianza tra due stringhe A e B. La distanza è il numero di cancellazioni, inserimenti o sostituzioni richieste per trasformare A in B. Per esempio:

- se A è "pippo" e B è "pippo", le stringhe sono identiche e non sono necessarie trasformazioni, quindi LD (A, B) = 0

- se A è "pippo" e B è "pluto", allora LD (A, B) = 3, perché tre sostituzioni (modifica "i" in "l", "p" in "u" e "p" in "l" ) sono sufficienti per trasformare A in B.

Maggiore è la distanza di Levenshtein, minore è la somiglianza tra le stringhe.

L'algoritmo per il calcolo dell distanza di Levenshtein è stato inventato dal russo Vladimir Levenshtein nel 1965.

Questo algoritmo viene utilizzato per:
- Controllo ortografico
- Riconoscimento vocale
- Analisi del DNA
- Rilevamento di plagio

Algoritmo:
Passo | Descrizione
------|------------
   1  | Impostare n = lunghezza di A
      | Impostare m = lunghezza di B.
      | Se n = 0 e m = 0, restituire nil e uscire.
      | Se n = 0, restituire m e uscire.
      | Se m = 0, restituire n e uscire.
      | Costruire una matrice contenente 0..m righe e 0..n colonne (m + 1) x (n + 1).

   2  | Inizializzare la prima riga con l'intervallo dei valori 0..n.
      | Inizializzare la prima colonna con l'intervallo dei valori 0..m.

   3  | Esaminare ciascun carattere di s (i da 1 a n).

   4  | Esaminare ciascun carattere di t (j da 1 a m).

   5  | Se s [i] è uguale a [j], il costo è 0.
      | Se s [i] non è uguale a [j], il costo è 1.

   6  | Impostare la cella D[i, j] della matrice uguale al minimo di:
      | a. La cella immediatamente sopra più 1: D[i-1, j] + 1.
      | b. La cella immediatamente a sinistra più 1: D[i, j-1] + 1.
      | c. La cella diagonalmente sopra a sinistra più il costo: D[i-1, j-1] + costo.

   7  | Dopo le iterazioni dei passi (3, 4, 5, 6), la distanza si trova nella cella D[n,m].


Passi 1 e 2        Passi 3 -> 6 con i = 1      Passi 3 -> 6 con i = 2
    D U M B O           D U M B O                   D U M B O
  0 1 2 3 4 5         0 1 2 3 4 5                 0 1 2 3 4 5
D 1                D  1 0                      D  1 0 1
A 2                A  2 1                      A  2 1 1
M 3                M  3 2                      M  3 2 2
B 4                B  4 3                      B  4 3 3
O 5                O  5 4                      O  5 4 4
L 6                L  6 5                      L  6 5 5

                   Passi 3 -> 6 con i = 3      Passi 3 -> 6 con i = 4
                        D U M B O                   D U M B O
                      0 1 2 3 4 5                 0 1 2 3 4 5
                   D  1 0 1 2                  D  1 0 1 2 3
                   A  2 1 1 2                  A  2 1 1 2 3
                   M  3 2 2 1                  M  3 2 2 1 2
                   B  4 3 3 2                  B  4 3 3 2 1
                   O  5 4 4 3                  O  5 4 4 3 2
                   L  6 5 5 4                  L  6 5 5 4 3

                   Passi 3 -> 6 con i = 5     Passo 7  D[m, n] = 2
                        D U M B O                 D U M B O
                      0 1 2 3 4 5               0 1 2 3 4 5
                   D  1 0 1 2 3 4             D 1 0 1 2 3 4
                   A  2 1 1 2 3 4             A 2 1 1 2 3 4
                   M  3 2 2 1 2 3             M 3 2 2 1 2 3
                   B  4 3 3 2 1 2             B 4 3 3 2 1 2
                   O  5 4 4 3 2 1             O 5 4 4 3 2 1
                   L  6 5 5 4 3 2             L 6 5 5 4 3>2<

La distanza si trova nell'angolo in basso a destra della matrice, ovvero 2. Infatti "DUMBO" può essere trasformato in "DAMBOL" sostituendo "A" per "U" e aggiungendo "L" (una sostituzione e un inserimento = due modifiche).

Vediamo prima una versione ricorsiva:

(define (ld A B)
  (define (ld-aux A lstA B lstB)
    (cond ((zero? lstA) lstB)
          ((zero? lstB) lstA)
          (true
            (min (+ (ld-aux (rest A) (- lstA 1) B lstB) 1)
                 (+ (ld-aux A lstA (rest B) (- lstB 1)) 1)
                 (+ (ld-aux (rest A) (- lstA 1) (rest B) (- lstB 1))
                                 (if (= (first A) (first B)) 0 1))
            )
          )
    )
  );define
  (ld-aux (explode A) (length A) (explode B) (length B))
)

(ld "top" "do")
;-> 2

(ld "topo" "dopo")
;-> 1

(ld "mister" "mostro")
;-> 3

(ld "rosettacode" "raisethysword")
;-> 8

(time (ld "rosettacode" "raisethysword"))
;-> 166616.661 ; 167 secondi

Questa versione è molto lenta.

Adesso scriviamo una funzione iterativa:

(define (ld A B)
  (local (n m D costo)
    (setq n (length A))
    (setq m (length B))
    (setq D (array (add n 1) (add m 1)))
    (cond ((and (zero? n) (zero? m)) nil)
          ((zero? n) m)
          ((zero? m) n)
          (true
            (for (i 0 n) (setf (D i 0) i))
            (for (j 0 m) (setf (D 0 j) j))
            (for (i 1 n)
              (for (j 1 m)
                (if (= (A (sub i 1)) (B (sub j 1)))
                  (setq costo 0)
                  (setq costo 1)
                )
                (setf (D i j) (min (add (D (sub i 1) j) 1)
                                   (add (D i (sub j 1)) 1)
                                   (add (D (sub i 1) (sub j 1)) costo)))
              )
            )
          )
    );cond
    (D n m)
  );local
)

(ld "topo" "dopi")
;-> 2
(ld "top" "lo")
;-> 2
(ld "lo" "top")
;-> 2
(ld "mister" "mostro")
;-> 3
(ld "rosettacode" "raisethysword")
;-> 8
(time (ld "rosettacode" "raisethysword"))
;-> 1.002
(ld "massimo" "omissam")
;-> 4
(ld "massimiliano" (reverse "massimiliano"))
;-> 8
(ld "abcdefgh" (reverse "abcdefgh"))
;-> 8
(ld "newLISP" "Common LISP")
;-> 7


Social Network
--------------

Due parole sono amiche se hanno una distanza di Levenshtein pari a 1.
Cioè, possiamo aggiungere, rimuovere o sostituire esattamente una lettera nella parola A per creare la parola B.
Il Social Network di una parola è composto da tutti i suoi amici, a cui vanno sommati gli amici dei suoi amici, a cui vanno sommati gli amici degli amici dei suoi amici e così via.
Scrivere un programma per trovare il Social Network di una parola utilizzando il file "nomi.txt" che contiene circa 9000 nomi italiani.

Dobbiamo avere una funzione che, dato un nome, genera tutti i suoi amici (cioè tutti i nomi che hanno distanza pari a uno) utilizzando il file "nomi.txt". Le seguenti due funzioni fanno proprio questo e sono state prese e adattate dal forum di newLISP (autori: kanen e rickyboy).

; Distanza di Leveshtein
; (delete, insert, modify)
; by kanen/rickyboy
; Uso:
;  (setf found-words (get-friendsLD "benefit" word-list))
;

(define (get-friendsLD word word-list)
  (let ((new-words '())
        (alphabet (explode "abcdefghijklmnopqrstuvwxyz"))
        (tmpWord ""))
    ;; Deletes (removing one letter)
    (for (i 0 (- (length word) 1))
      (setf tmpWord word)
      (pop tmpWord i)
      (push tmpWord new-words -1))
    ;; Modifies (one letter to another)
    (for (i 0 (- (length word) 1))
      (set 'tmpWord word)
      (dolist (a alphabet)
        (when (not (= (word i) a))
          (setf (tmpWord i) a)
          (push tmpWord new-words -1))))
    ;; Inserts (add a letter)
    (for (i 0 (length word))
      (dolist (a alphabet)
        (set 'tmpWord word)
        (push (push a tmpWord i) new-words -1)))
    (intersect new-words word-list)))

Questa funzione permette anche lo scambio (swap) di lettere adiacenti (si tratta della distanza di Leveshtein-Damerau):

; Distanza di Leveshtein-Damerau
; (delete, insert, modify, swap)
; by kanen/rickyboy
; Uso:
;  (setf found-words (get-friendsLDD "benefit" word-list))
;
(define (get-friendsLDD word word-list)
  (let ((new-words '())
        (alphabet (explode "abcdefghijklmnopqrstuvwxyz"))
        (tmpWord ""))
    ;; Deletes (removing one letter)
    (for (i 0 (- (length word) 1))
      (setf tmpWord word)
      (pop tmpWord i)
      (push tmpWord new-words -1))
    ;; Swaps (swap adjacent letters)
    (for (i 0 (- (length word) 2))
      (set 'tmpWord word)
      (push (push (pop tmpWord i) tmpWord (+ 1 i)) new-words -1))
    ;; Modifies (one letter to another)
    (for (i 0 (- (length word) 1))
      (set 'tmpWord word)
      (dolist (a alphabet)
        (when (not (= (word i) a))
          (setf (tmpWord i) a)
          (push tmpWord new-words -1))))
    ;; Inserts (add a letter)
    (for (i 0 (length word))
      (dolist (a alphabet)
        (set 'tmpWord word)
        (push (push a tmpWord i) new-words -1)))
    (intersect new-words word-list)))

Per provarle useremo prima il file "nomi-prova.txt":

(define (resume) (print "\r\n> "))
(silent (setq word-list (parse (read-file "nomiA.txt" "\r\n"))) (print "Fatto") (resume))
word-list
;-> ("eva" "leana" "lena" "liana" "lina" "luana" "luano" "luca"
;->  "luce" "lucia" "luisa" "luna" "max" "roberta" "una" "uno")

(get-friendsLD "luca" word-list)
;-> ("luna" "luce" "lucia")

Adesso utilizziamo il file "nomi.txt":

(silent (setq word-list (parse (read-file "nomi.txt" "\r\n"))) (print "Fatto") (resume))
(length word-list)
;-> 8913

(setq amici (get-friendsLD "luca" word-list))
;-> ("luna" "luce" "lucia")

Abbiamo la funzione che calcola gli amici di una parola (nome). Adesso dobbiamo scrivere la funzione che calcola il Social Network di una parola (nome).
La funzione seguente non è ottimizzata, ma è abbastanza semplice: la spiegazione del metodo di calcolo si trova nei commenti:

(define (social x)
  (local (out lst tmp stop len-out)
    ; calcola la lista risultato per la prima volta
    (setq out (get-friendsLD x word-list))
    ; lista di nomi di cui cercare gli amici (lista ricerca)
    (setq lst out)
    (setq stop nil)
    ;lunghezza della lista risultato
    (setq len-out (length out))
    (while (= stop nil)
      ; per ogni nome della lista ricerca calcoliamo
      ; una lista con tutti gli amici e poi la uniamo alla lista risultato
      (setq tmp '())
      (dolist (el lst)
        (extend tmp (get-friendsLD el word-list))
      )
      (setq out (union out tmp))
      ; se la lista risultato ha la stessa lunghezza di quella precedente
      ; (vuol dire che non abbiamo aggiunto alcun nome)...
      (if (= (length out) len-out)
        ;allora stop
        (setq stop true)
        ;altrimenti...
        (begin
          ;(println len-out { } (length out))
          ;aggiorna la lunghezza della lista risultato
          (setq len-out (length out))
          ;crea la nuova lista ricerca partendo dalla lista risultato
          ;togliendo gli elementi della lista ricerca attuale
          (setq lst (difference out lst))
        )
      )
    )
    out
  );local
)

(silent (setq word-list (parse (read-file "nomi-demo.txt" "\r\n"))) (print "Fatto") (resume))
(social "luca")
;-> ("luna" "luce" "lucia" "una" "lena" "lina" "luca" "luana" "uno" "leana" "liana" "luano")

Adesso proviamo con il file "nomi.txt" senza visualizzare il risultato sulla REPL perchè la lista è molto grande. Salveremo il risultato nel file "social-luca.txt"

(silent (setq word-list (parse (read-file "nomi.txt" "\r\n"))) (print "Fatto") (resume))
;(social "luca")

(time (setq amici (social "luca")))
;-> 102772.905 ; 1 min 42 sec

(length amici)
;-> 5534

Adesso scriviamo il risultato nel file "social-luca.txt":

(setq datafile (open "social-luca.txt" "write"))
(write datafile (join amici " "))
(close datafile)


Skyline
-------

Viene data una serie di n rettangoli in nessun ordine particolare. Hanno larghezze e altezze variabili, ma i loro bordi inferiori sono collineari, in modo che sembrino edifici su un orizzonte. Per ogni rettangolo, viene data la posizione x del bordo sinistro, la posizione x del bordo destro e l'altezza. Il compito è disegnare un contorno attorno alla serie di rettangoli in modo che rappresenti la loro forma complessiva rispetto all'orizzonte (skyline).
Esempio:

Input lista Rettangoli
(setq ret '((1 3 3) (2 4 4) (5 8 2) (6 7 4) (8 9 4)))

Output lista Skyline:
((1 3) (2 4) (4 0) (5 2) (6 4) (7 2) (8 4) (9 0))

     Rettangoli                          Skyline

     |                                   |
   5 |                                 5 |
     |                                   |
     |                                   |
   4 |     +-----+     +--+  +--+      4 |     O-----+     O--+  O--+
     |     |     |     |  |  |  |        |     |     |     |  |  |  |
     |     |     |     |  |  |  |        |     |     |     |  |  |  |
   3 |  +--|--+  |     |  |  |  |      3 |  O--+     |     |  |  |  |
     |  |  |  |  |     |  |  |  |        |  |        |     |  |  |  |
     |  |  |  |  |     |  |  |  |        |  |        |     |  |  |  |
   2 |  |  |  |  |  +--|--|--+  |      2 |  |        |  O--+  O--+  |
     |  |  |  |  |  |  |  |  |  |        |  |        |  |           |
     |  |  |  |  |  |  |  |  |  |        |  |        |  |           |
   1 |  |  |  |  |  |  |  |  |  |      1 |  |        |  |           |
     |  |  |  |  |  |  |  |  |  |        |  |        |  |           |
     |  |  |  |  |  |  |  |  |  |        |  |        |  |           |
   0 |-----------------------------    0 |-----------O--------------O--
     0  1  2  3  4  5  6  7  8  9        0  1  2  3  4  5  6  7  8  9

I punti della lista skyline sono contrassegnati con la lettera "O".

Creazione di un vettore delle altezze massime "hmap"
Creiamo un vettore di (hmax + 1) elementi, dove hmax è l'altezza del rettangolo più alto.
Per ogni rettangolo (i j h) assegniamo a tutte le celle di hmap da i a (j-1) il valore massimo tra quello contenuto nella cella corrente e h.

Creazione della lista dei punti della linea
Visitiamo il vettore hmap e riportiamo sulla lista solo i punti (con il relativo valore) che sono diversi dal punto precedente.

Complessità Temporale: O(n)
Complessità Spaziale: O(max(h)) dove max(h) è l'altezza massima dei rettangoli

Considerando i rettangoli dell'esempio:

indice  0 1 2 3 4 5 6 7 8 9  vettore hmap
        0 0 0 0 0 0 0 0 0 0  valori iniziale
          3 3                valori dopo il primo ret (1 3 3)
            4 4              valori dopo il secondo ret (2 4 4)
                  2 2 2      valori dopo il terzo ret (5 8 2)
                    4        valori dopo il quarto ret (6 7 4)
                        4    valori dopo il quinto ret (8 9 4)
        0 3 4 4 0 2 4 2 4 0  valori finali

hmap = (0 3 4 4 0 2 4 2 4 0)

Possiamo scrivere la funzione:

(define (skyline lst)
  (local (len hmap linea)
    ;calcolo valore massimo altezza
    (setq len (add (apply max (flat lst)) 1))
    ; creazione vettore con tutti valori a zero
    (setq hmap (array len '(0)))
    ;Calcolo valori per hmap
    (dolist (el lst)
      (for (i (el 0) (sub (el 1) 1))
        (setf (hmap i) (max (el 2) (hmap i)))
      )
    )
    hmap
    ;calcolo punti visibili
    (setq out '())
    (for (i 0 (sub len 1))
      (if (zero? i)
        ; controllo primo punto hmap[0]
        ; se hmap[0] è diverso da zero, allora lo aggiungo al risultato
        (if (!= (hmap 0) 0) (push (list 0 (hmap i)) out -1))
        ; controllo punti successivi
        ; inserisco il valore di hmap[i] solo se è diverso dal precedente
        (if (!= (hmap i) (hmap (sub i 1))) (push (list i (hmap i)) out -1))
      )
    )
    out
  );local
)

(setq ret '((1 3 3) (2 4 4) (5 8 2) (6 7 4) (8 9 4)))
(skyline ret)
;-> ((1 3) (2 4) (4 0) (5 2) (6 4) (7 2) (8 4) (9 0))

(setq ret '((0 3 3) (2 4 4) (5 8 2) (6 7 4) (8 9 4)))

(setq ret '((2 9 10) (3 6 15) (5 12 12) (13 16 10) (15 17 5)))
(skyline ret)
;-> ((2 10) (3 15) (6 12) (12 0) (13 10) (16 5) (17 0))


Knuth-shuffle
-------------

Knuth-shuffle (oppure Fisher-Yates shuffle) è un algoritmo per mescolare casualmente gli elementi di un array.
Data una lista con N elementi (idx: 0..N-1), lo pseudo-codice dell'algoritmo è il seguente:

for i from N downto 1 do:
     let j = numero intero casuale nell'intervallo 0 <= j <= i
     swap lista[i] con lista[j]

(define (knuth-shuffle lst)
  (local (N j)
    (setq N (length lst))
    (for (i (- N 1) 0 -1)
      (setq j (rand (+ i 1)))
      (swap (lst i) (lst j))
    )
    lst
  )
)

(knuth-shuffle '(1 2 3 4 5 6 7 8 9 0))
;-> (3 7 9 5 1 0 4 6 8 2)
(knuth-shuffle '(1 2 3 4 5 6 7 8 9 0))
;-> (6 4 9 3 2 7 8 1 5 0)
(knuth-shuffle '(1 2 3 4 5 6 7 8 9 0))
;-> (9 0 7 5 8 1 3 4 6 2)
(knuth-shuffle '(1 2 3 4 5 6 7 8 9 0))
;-> (3 6 5 2 1 4 0 8 7 9)

Estrazione del lotto:
(knuth-shuffle (sequence 1 90))
;-> (13 28 18 32 62 56 19 67 89 54 63 81 61 27 78 75 10 39 46 48 52 4 57 55 29 42 16
;->  24 66 77 44 65 58 15 11 83 85 40 38 6 74 45 3 22 64 79 17 37 49 26 41 70 12 9 73
;->  68 35 72 84 36 7 47 60 30 80 90 14 33 51 59 50 43 20 21 82 1 5 86 8 31 2 69 25 23
;->  34 53 87 88 76 71)

Controlliamo il risultato:
(= (apply + (knuth-shuffle (sequence 1 90))) (apply + (sequence 1 90)))
;-> true

Controlliamo meglio:
(difference (knuth-shuffle (sequence 1 90)) (sequence 1 90))
;-> ()

newLISP ha anche una funzione apposita: "randomize":

(randomize (sequence 1 90))
;-> (41 43 55 59 78 76 4 67 3 40 25 70 56 83 33 30 61 68 17 44 9 27 73 65 24 12 5 37
;->  64 82 85 18 75 36 72 89 54 32 28 48 46 84 14 22 52 60 50 51 15 2 35 69 38 11 71
;->  23 62 53 16 45 31 34 87 47 10 57 26 1 86 81 29 90 74 88 19 80 20 42 8 21 39 58 13
;->  77 63 49 6 79 7 66)


Bussola e direzioni
-------------------

La bussola è divisa principalmente nelle quattro direzioni cardinali: nord, sud, est e ovest. Questi punti possono essere ulteriormente suddivisi con l'aggiunta delle quattro direzioni intercardinali (o ordinali) - nord-est (NE), sud-est (SE), sud-ovest (SO) e nord-ovest (NO) - per indicare gli otto venti principali. Nell'uso meteorologico, vengono aggiunti ulteriori punti intermedi tra il cardinale e le direzioni intercardinali, come nord-nord est (NNE) per dare i sedici punti di una rosa di bussola.
La bussola del marinaio ha 32 punti poichè aggiunge punti come nord per est (NbE oppure NxE) tra nord e nord-nordest, e nordest per nord (NEbN oppure NExN) tra nord-nordest e nord-est. Un punto di bussola consente di fare riferimento a una direzione specifica (o azimut) in modo colloquiale, senza ricorrere ai gradi.

(define (bussola32-lista)
  (local (gradi nomi i j)
    (setq gradi '(0.0 16.87 16.88 33.75 50.62 50.63 67.5 84.37
                  84.38 101.25 118.12 118.13 135.0 151.87 151.88
                  168.75 185.62 185.63 202.5 219.37 219.38 236.25
                  253.12 253.13 270.0 286.87 286.88 303.75 320.62
                  320.63 337.5 354.37 354.38))
    (setq nomi '("North                " "North by east        " "North-northeast      "
                 "Northeast by north   " "Northeast            " "Northeast by east    "
                 "East-northeast       " "East by north        " "East                 "
                 "East by south        " "East-southeast       " "Southeast by east    "
                 "Southeast            " "Southeast by south   " "South-southeast      "
                 "South by east        " "South                " "South by west        "
                 "South-southwest      " "Southwest by south   " "Southwest            "
                 "Southwest by west    " "West-southwest       " "West by south        "
                 "West                 " "West by north        " "West-northwest       "
                 "Northwest by west    " "Northwest            " "Northwest by north   "
                 "North-northwest      " "North by west        " "North                " ))
    (for (i 0 31)
      (setq j (add 0.5 (div (mul 32 (gradi i)) 360)))
      (println (format "%2d  %.22s  %6.2f %6.2f" (add (mod j 32) 1) (nomi (mod j 32)) (gradi i) j))
    )
    nil
  )
)

(bussola32-lista)
;->  1  North                    0.00
;->  2  North by east           16.87
;->  3  North-northeast         16.88
;->  4  Northeast by north      33.75
;->  5  Northeast               50.62
;->  6  Northeast by east       50.63
;->  7  East-northeast          67.50
;->  8  East by north           84.37
;->  9  East                    84.38
;-> 10  East by south          101.25
;-> 11  East-southeast         118.12
;-> 12  Southeast by east      118.13
;-> 13  Southeast              135.00
;-> 14  Southeast by south     151.87
;-> 15  South-southeast        151.88
;-> 16  South by east          168.75
;-> 17  South                  185.62
;-> 18  South by west          185.63
;-> 19  South-southwest        202.50
;-> 20  Southwest by south     219.37
;-> 21  Southwest              219.38
;-> 22  Southwest by west      236.25
;-> 23  West-southwest         253.12
;-> 24  West by south          253.13
;-> 25  West                   270.00
;-> 26  West by north          286.87
;-> 27  West-northwest         286.88
;-> 28  Northwest by west      303.75
;-> 29  Northwest              320.62
;-> 30  Northwest by north     320.63
;-> 31  North-northwest        337.50
;-> 32  North by west          354.37
nil

(define (bussola32 gradi)
  (local (nomi j)
    (setq nomi '("North" "North by east" "North-northeast"
                  "Northeast by north" "Northeast" "Northeast by east"
                  "East-northeast" "East by north" "East"
                  "East by south" "East-southeast" "Southeast by east"
                  "Southeast" "Southeast by south" "South-southeast"
                  "South by east" "South" "South by west"
                  "South-southwest" "Southwest by south" "Southwest"
                  "Southwest by west" "West-southwest" "West by south"
                  "West" "West by north" "West-northwest"
                  "Northwest by west" "Northwest" "Northwest by north"
                  "North-northwest" "North by west" "North"))
    (setq j (add 0.5 (div (mul 32 gradi) 360)))
    (nomi (mod j 32))
  )
)

(bussola32 84.37)
;-> "East by north"

(bussola32 84.38)
;-> "East"


Puzzle (a b c + a b c + a b c = c c c)
--------------------------------------

Data la seguente operazione:

a b c +
a b c +
a b c =
--------
c c c

Trovare il valore delle cifre a, b e c.

Soluzione 1

Matematicamente risulta 3*(abc) = ccc che può essere scritto come:

  300a + 30b + 3c = 100c + 10c + c

Raggruppiamo il termine "c":

  300a + 30b = 108c

Dividiamo per 3:

  100a + 10b = 36c

Inoltre possiamo notare che deve risultare:

  c + c + c = [x]c

dove l'eventuale [x] può valere 1 o 2.

Vediamo quali cifre soddisfano questo vincolo:

(for (i 0 9)
  (if (< (* 3 i) 10)
      (if (= i (* 3 i)) (println i)) ; valori minori di 10 (una cifra)
      (if (= i (% (* 3 i) 10)) (println i)) ; valori maggiori di 10 (due cifre)
  )
)
;-> 0
;-> 5

Solo il numero 5 è una soluzione accettabile (altrimenti la somma sarebbe nulla).
Quindi abbiamo:

  a b 5 +
  a b 5 +
  a b 5 =
  --------
  5 5 5

Adesso deve risultare:

  b + b + b + 1 = [x]5

dove l'eventuale [x] può valere 1 o 2.

Vediamo quali cifre soddisfano questo vincolo:

(for (i 0 9)
  (if (< (* 3 i) 10)
      (if (= 5 (+ 1 (* 3 i))) (println i)) ; valori minori di 10 (una cifra)
      (if (= 5 (% (+ 1 (* 3 i)) 10)) (println i)) ; valori maggiori di 10 (due cifre)
  )
)
;-> 8

Quindi abbiamo:

  a 8 5 +
  a 8 5 +
  a 8 5 =
  --------
  5 5 5

Adesso deve risultare:

  a + a + a + 2 = 5

Il termine [x] non compare perchè "a" deve essere minore di 10.

Quindi risolviamo quest'ultima equazione:

3*a = 3 ==> a = 1

  1 8 5 +
  1 8 5 +
  1 8 5 =
  --------
  5 5 5

Soluzione 2 (forza bruta)

Calcolare tutte le combinazioni delle cifre da 0 a 9:

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(setq prove (combinazioni 3 '(1 2 3 4 5 6 7 8 9 0)))
(length prove)
;-> 120

Calcolare tutte le permutazioni per ogni elemento della lista delle combinazioni:

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

(setq num (map (fn (x) (permutazioni x)) prove))

Eliminare un livello di annidamento:

(setq num (flat num 1))
(length num)
;-> 720

Calcolare il valore di ogni elemento della lista " num" (formato elemento (a b c)):
(setq numeri (map (fn (x) (+ (* 100 (first x)) (* 10 (first (rest x))) (last x))) num))

Ordinare i numeri:
(sort numeri)

Applicare la seguente funzione di controllo alla lista "numeri":

(define (calcola n)
  (local (val val$ n$ out)
    (setq n$ (string n))
    (setq val (+ n n n))
    (setq val$ (string val))
    (cond ((< n 100) nil)
          ((> val 999) nil)
          ((or (!= (val$ 0) (val$ 1)) (!= (val$ 0) (val$ 2)) (!= (val$ 1) (val$ 2))) nil)
          ((!= (val$ 2) (n$ 2)) nil)
          (true n)
    )
  )
)

(calcola 123)
;-> nil

(setq lsol (map (fn (x) (calcola x)) numeri))

Eliminare tutti gli elementi nil:

(clean null? lsol)
;-> (185)

Soluzione:
a = 1
b = 8
c = 5


Numero mancante
---------------

Data una lista contenente n numeri distinti presi da 0, 1, 2, ..., n, trovare quello mancante nella lista. Ad esempio, data la lista nums = (0  1  3), la funzione dovrebbe restituire 2.

Soluzione 1 - Matematica

(define (mancante lst)
  (local (somma n)
    (setq n (length lst))
    (setq somma (apply + lst))
    (- (/ (* n (+ n 1)) 2) somma)
  )
)

(setq lst '(9 0 5 4 7 1 6 8 2))
(mancante lst)
;-> 3

Soluzione 2 - Bitwise XOR

(define (mancante lst)
  (let (manca 0)
    (for (i 0 (- (length lst) 1))
      (setq manca (^ manca (^ (+ i 1) (lst i))))
    )
  manca
  )
)

(mancante lst)
;-> 3


Somma massima di una sottolista (Algoritmo Kadane)
--------------------------------------------------
Data una lista di numeri interi trovare il valore massimo della somma di una sua sottolista.
L'algoritmo di Kadane risolve questo problema per una lista di qualunque dimensione.
In questo caso lo applicheremo ad una lista semplice ad una sola dimensione (1D).

Prima vediamo la soluzione ottenuta con la forza bruta (brute-force).
Data la lista lst = (-1 2 -1 3) i valori delle somme di tutte le sottoliste valgono:

ELEMENTI     Somma   start-index   end-index
-1            -1       0             0
-1,2           1       0             1
-1,2,-1        0       0             2
-1,2,-1,3      3       0             3
2              2       1             1
2,-1           1       1             2
2,-1,3         4       1             3     <--- 4 somma massima sottoliste
-1            -1       2             2
-1,3           2       2             3
3              3       3             3

Dobbiamo scrivere una funzione che calcola la somma di tutte le sottoliste:

(define (maxSumSub lst)
  (local (n max_sum max_start max_end)
    (setq n (length lst))
    (setq max_sum (lst 0))
    (setq max_start 0)
    (setq max_end 0)
    (for (start 0 (- n 1))
      (for (end start (- n 1))
        (setq sum (calcSum lst start end))
        (if (> sum max_sum)
          (begin
            (setq max_sum sum)
            (setq max_start start)
            (setq max_end end))
        )
      )
    )
    (list max_sum max_start max_end)
  );local
)

(define (calcSum lst i j)
  (local (sum)
    (setq sum 0)
    (for (k i j)
      (setq sum (+ sum (lst k)))
    )
  )
)

(setq lst '(-1 2 -1 3))
;-> (-1 2 -1 3)
(maxSumSub lst)
;-> (4 1 3)

(setq lst '(5 7 -3 2 9 6 16 22 21 29 -14 10 12))
(maxSumSub lst)
;-> (122 0 12)

Questo algoritmo ha complessità temporale O(n^3).

Dobbiamo utilizzare un algoritmo più veloce.

L'algoritmo di Kadane inizia con un ragionamento induttivo: se conosciamo la somma massima del subarray che termina con la posizione i (si chiami questo B[i]), qual è la somma massima del subarray che termina alla positione i + 1 (equivalentemente, quanto vale B[i+1]) ? La risposta risulta essere relativamente semplice: o la somma massima del subarray che termina con la posizione i + 1 include la somma massima della subarray che termina alla posizione i come prefisso, oppure no (in altre parole, B[i+1] = max(A[i+1], A[i+1] + B[i]), dove A[i+1] è l'elemento all'indice i + 1).

L'algoritmo può essere codificato nel seguente modo:

(define (getMaxSum lst)
  (local (currentMax totalMax)
    (setq currentMax (lst 0))
    (setq totalMax (lst 0))
    (for (i 1 (- (length lst) 1))
      ; aggiorno il valore massimo della somma corrente
      ; sommandolo al valore corrente
      (setq currentMax (add (lst i) (max currentMax 0)))
      ; verifico se occorre aggiornare il valore massimo totale
      (setq totalMax (max totalMax currentMax 0))
    )
  )
)

(setq lst '(5 7 -3 2 9 6 16 22 21 29 -14 10 12))
(getMaxSum lst)
;-> 122

(setq lst '(-2 1 -3 4 -1 2 1 -5 4))
(getMaxSum lst)
;-> 6

La soluzione completa consiste nel restituire tre valori:
1) il valore della somma massima
2) l'indice di inizio della sottolista massima
2) l'indice di fine della sottolista massima
Inoltre bisogna trattare il caso della lista vuota e quello delle liste che hanno tutti valori negativi.

La funzione definitiva è la seguente:

(define (kadaneIdx lst)
  (local (currentMax totalMax startIdx endIdx tempIdx)
    (cond ((null? lst) (list nil nil nil))
          (true
            (setq currentMax (lst 0))
            (setq totalMax (lst 0))
            (setq startIdx 0)
            (setq endIdx 0)
            (setq tempIdx 0)
            (for (i 1 (- (length lst) 1))
              ; aggiorno il valore massimo della somma corrente
              (setq currentMax (add currentMax (lst i)))
              ; spezziamo la condizione che calcola
              ; il massimo tra totalMax currentMax e 0,
              ; per tenere conto degli indici coinvolti
              (cond ((< currentMax 0)
                      (setq currentMax 0)
                      (setq tempIdx (add i 1))
                    )
                    ((< totalMax currentMax)
                      (setq totalMax currentMax)
                      (setq startIdx tempIdx)
                      (setq endIdx i)
                    )
              )
            )
            ; controllo soluzione negativa ==> tutti i numeri sono negativi
            (if (< totalMax 0)
              (begin
                ; cerco il valore massimo della lista e il relativo indice
                (setq startIdx -1)
                (dolist (el lst)
                  (if (>= el totalMax) (setq totalMax el startIdx $idx))
                )
                (setq endIdx startIdx)
              )
            )
            (list totalMax startIdx endIdx)
          );true
    );cond
  );local
)

(setq lst '(5 7 -3 2 9 6 16 22 21 29 -14 10 12))
(kadaneIdx lst)
;-> (122 0 12)

(setq lst '(-2 1 -3 4 -1 2 1 -5 4))
(kadaneIdx lst)
;-> (6 3 6)

(setq lst '(1 2 3 -20 5 6))
(kadaneIdx lst)
;-> (11 4 5)

(setq lst '(10 -1 2 11))
(kadaneIdx lst)
;-> (22 0 3)

(setq lst '(-11 -10 -12))
(kadaneIdx lst)
(-10 1 1)

(setq lst '())
(kadaneIdx lst)
;-> (nil nil nil)

L'algoritmo Kadane ha complessità temporale O(n).


Prodotto massimo di una sottolista
----------------------------------

Data una lista di numeri interi trovare il valore massimo del prodotto di una sua sottolista.
Per risolvere questo problema potremmo utilizzare l'algoritmo di Kadane e modificarlo per tenere conto degli elementi con valore 0 e del fatto che il prodotto può cambiare segno in funzione del segno dei moltiplicandi.
Invece utilizziamo un metodo più semplice che però non è ottimale in termini di tempo e di spazio.

(define (maxProd lst)
  (local (n maxprod pos neg)
    (setq n (length lst))
    (setq pos (array n '(0)))
    (setq neg (array n '(0)))
    (setq (pos 0) (lst 0)) ; pos[i] contiene il prodotto positivo fino a lst[i]
    (setq (neg 0) (lst 0)) ; neg[i] contiene il prodotto negativo fino a lst[i]
    (setq maxprod (lst 0))
    (for (i 0 (- n 1))
      ; il massimo dei tre valori
      (setq (pos i) (max (max (mul (pos (- i 1)) (lst i)) (mul (neg (- i 1)) (lst i))) (lst i)))
      ; il minimo dei tre valori
      (setq (neg i) (min (min (mul (pos (- i 1)) (lst i)) (mul (neg (- i 1)) (lst i))) (lst i)))
      (setq maxprod (max maxprod (pos i)))
    )
    maxprod
  )
)

(setq lst '(6 -3 -10 0 2))
(maxProd lst)
;-> 180
Sottolista: (6 -3 -10)

(setq lst '(-1 -3 -10 0 60))
(maxProd lst)
;-> 60
Sottolista: (60)

(setq lst '(-2 -3 0 -2 -40))
(maxProd lst)
;-> 80
Sottolista: (-2 -40)

(setq lst '(-1 -2 -3))
(maxProd lst)
;-> 6

(setq lst '(0 -1))
(maxProd lst)
;-> 0

(setq lst '(0 0 0 0))
(maxProd lst)
;-> 0


Problema delle N-Regine
-----------------------

Il problema delle N-Regine consiste nel trovare il modo di posizionare N Regine (pezzo degli scacchi) su una scacchiera NxN in modo che nessuna di esse sia sotto cattura.
Il problema è risolvibile solo per N >= 4.
Risolveremo il problema con il metodo di backtracking (che è una forma di ricorsione).
Per capire il funzionamento dell'algoritmo, risolveremo prima il problema passo per passo utilizzando una scacchiera 4x4.

Algoritmo di backtracking
1) All'inizio, posizioniamo una regina (X) nella casella (1,1)

   X 0 0 0
   0 0 0 0
   0 0 0 0
   0 0 0 0

2) Ora la seconda regina non può essere piazzata nelle colonne 1 e 2 poiché tali posizioni possono essere attaccate dalla prima regina.
Quindi piazziamo la regina due inizialmente a (2,3)

   X 0 0 0
   0 0 X 0
   0 0 0 0
   0 0 0 0

3) La terza regina può essere piazzata a (4,2).

   X 0 0 0
   0 0 X 0
   0 0 0 0
   0 X 0 0

4) Ora, quando proviamo a piazzare una regina nella terza fila, non troviamo alcuna casella disponibile perché sono tutte attaccate dalla prima regina o dalla seconda regina.
Quindi torniamo indietro (backtracking) e cerchiamo di mettere la terza regina in una nuova posizione. Purtoppo non esiste nessuna posizione disponibile per la terza regina, allora torniamo indietro e riposizioniamo la seconda regina a (2,4) (che è la prima casella disponibile).

   X 0 0 0
   0 0 0 X
   0 0 0 0
   0 0 0 0

5) Ora, quando piazziamo la terza regina, c'è solo una posizione possibile che è (3,2), quindi poniamo la terza regina in (3,2).

   X 0 0 0
   0 0 0 X
   0 X 0 0
   0 0 0 0

6) Ancora una volta finiamo senza nessuna posizione per piazzare la prossima regina. Quindi torniamo indietro, ma non ci sono posizioni alternative nemmeno per la terza e la seconda regina. Quindi torniamo indietro e cambiamo la posizione della prima regina come (1,2)

   0 X 0 0
   0 0 0 0
   0 0 0 0
   0 0 0 0

7) Ora per mettere la seconda regina, abbiamo solo una scelta che è (2,4)

   0 X 0 0
   0 0 0 X
   0 0 0 0
   0 0 0 0

8) Allo stesso modo, per posizionare la terza regina, abbiamo una sola posizione possibile (3,1)

   0 X 0 0
   0 0 0 X
   X 0 0 0
   0 0 0 0

9) Infine, abbiamo una posizione possibile per posizionare la quarta regina che è (4,3)

   0 X 0 0
   0 0 0 X
   X 0 0 0
   0 0 X 0

In questo modo si ottiene una possibile soluzione al problema delle N-Regine e l'algoritmo termina.


(define (isAttacked x y board N)
  (local (out)
    ; controllo righe e colonne
    (for (i 0 (- N 1))
      ;righe
      (if (and (= (board x i) 1) (!= i y))
        (setq out true))
      ;colonne
      (if (and (= (board i y) 1) (!= i x))
        (setq out true))
    )
    ; controllo diagonali
    (for (i 0 (- N 1))
      (for (j 0 (- N 1))
        (if (or (= (+ i j) (+ x y)) (= (- i j) (- x y)))
            (if (and (or (!= i x) (!= j y)) (= 1 (board i j)))
                (setq out true)
            )
        )
      )
    )
    out
  );local
)

(setq board '((1 0 0 0) (0 0 0 0) (0 0 0 0) (0 0 0 0)))
(isAttacked 1 1 board 4)
;-> true
(isAttacked 2 2 board 4)
;-> true
(isAttacked 1 2 board 4)
;-> nil

(define (nQueens board level N)
  (local (out j)
    (cond ((= level N) (setq out true) (show board N))
          (true
            (setq j 0)
            (while (and (< j N) (!= out true))
              (if (isAttacked level j board N) (setq j j)
                  (begin
                    (setq (board level j) 1)
                    (if (nQueens board (+ level 1) N) (setq out true)
                        (setq (board level j) 0))
                  )
              )
              (++ j)
            )
          )
    )
    out
  )
  ;(println board)
)

(define (show board)
    (for (i 0 (- N 1))
      (for (j 0 (- N 1))
        (print (board i j) { })
      )
      (println { })
    )
)

(setq size 4)
(setq board (array size size '(0)))
(nQueens board 0 size)
;-> 0 1 0 0
;-> 0 0 0 1
;-> 1 0 0 0
;-> 0 0 1 0
;-> true

(setq size 8)
(setq board (array size size '(0)))
(nQueens board 0 size)
;-> 1 0 0 0 0 0 0 0
;-> 0 0 0 0 1 0 0 0
;-> 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 1 0 0
;-> 0 0 1 0 0 0 0 0
;-> 0 0 0 0 0 0 1 0
;-> 0 1 0 0 0 0 0 0
;-> 0 0 0 1 0 0 0 0
;-> true

(setq size 21)
(setq board (array size size '(0)))
(nQueens board 0 size)
;-> 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
;-> 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
;-> true

(setq size 21)
(setq board (array size size '(0)))
(time (nQueens board 0 size))
;-> 31058.105 ; 31 secondi


Somma delle cifre di un numero
------------------------------

Calcolare la somma delle cifre di un numero ripetutamente fino a quando la somma ha una sola cifra.

Esempi:

n = 1234 ==> 1 + 2 + 3 + 4 = 10 ==> 1 + 0 = 1

n = 5674 ==> 5 + 6 + 7 + 4 = 22 ==> 2 + 2 = 4

(define (digitSum n)
  (if (zero? n) 0
    (if (zero? (% n 9)) 9
      (% n 9)
    )
  )
)

(digitSum 1234)
;-> 1

(digitSum 5674)
;-> 4

(digitSum 2345345345343453453453535353453453451345678901)
;-> 5L

Complessità temporale O(1).

Ted Walther ha scritto una funzione più elegante:

(define (digital_root n)
    (+ 1 (% (- n 1) 9))

Vediamo la dimostrazione matematica.

Prendiamo un numero numero positivo N. Scrivendo N in termini di cifre abbiamo:

N = Sum[ d[i] * 10^i ], dove d[0], d[1], d[2], ... sono le cifre di N. la somma inizia con i = 0.

Nota che 10^1 = (9*1 + 1), 10^2 = (9*11 + 1), 10^3 = (9*111 + 1), e così via.

Quindi possiamo scrivere:

N = (9*1 + 1) d[0] + (9*11 + 1) d[1] + (9*111 + 1) d[2] + ...

= 9 * (1*d[0] + 11*d[1] + 111*d[2] + ...) + d[0] + d[1] + d[2] + ...

= (multiplo di 9) + d[0] + d[1] + d[2] + ...

Quindi (N mod 9) = d[0] + d[1] + d[2] + ...

In altre parole il risultato deriva da una proprietà fondamentale dell'aritmetica modulare, vale a dire:

a*b mod n ≡ (a mod n)*(b mod n)

Poichè 10 mod 9 ≡ 1 abbimo 10^i mod 9 ≡ (10 mod 9)^i = 1^i = 1 per qualunque potenza i di 10.

Nella notazione decimale, un intero positivo N è rappresentato come una sequenza inversa di cifre d (i) tale che:

N = ∑ d(i)*10^i ⇒ N mod 9 ≡ ∑ (d(i)*10^i mod 9) ≡ ∑ d(i) mod 9
    i                       i                     i

Notare che qualsiasi numero intero positivo in base b è congruente alla somma delle sue cifre modulo (b-1) per qualsiasi base.


Coppia di punti più vicina
--------------------------

Data una serie di n punti nel piano, trovare la coppia di punti che hanno distanza minore.

Esempio: L = ((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4)

      |
    6 |
      |
    5 |       O               O       O
      |
    4 |       O       O
      |
    3 |   O                   O
      |
    1 |           O
      |
    1 |   O                   O
      |
    0 ---------------------------------------
      0   1   2   3   4   5   6   7   8   9

(define (closestPairs lst)
  (local (cp vec dist minDist)
    (setq minDist 9223372036854775807) ; valore massimo int64
    (setq cp '())
    ; trasformo la lista in un vettore per guadagnare in velocità
    (setq vec (array (length lst) 2 (flat lst)))
    (for (p1 0 (- (length vec) 1))
      (for (p2 p1 (- (length vec) 1))
        (if (!= (vec p1) (vec p2))
          (begin
            (setq dist (add (mul (sub (vec p1 0) (vec p2 0)) (sub (vec p1 0) (vec p2 0)))
                            (mul (sub (vec p1 1) (vec p2 1)) (sub (vec p1 1) (vec p2 1)))))
            (if (< dist minDist)
              (begin
                (setq minDist dist)
                (setq cp (list (vec p1) (vec p2)))
                ;(println minDist)
              )
            )
          )
        )
      )
    )
    (println minDist)
    cp
  )
)

(setq lst '((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4)))
(closestPairs lst)
;-> 1
;-> ((2 4) (2 5))

Vediamo con una lista di 10000 punti:

(silent
  (setq a (rand 10000 10000))
  (setq b (rand 10000 10000))
  (setq c (map list a b))
  (setq d (unique c))
)

(time (closestPairs d))
;-> 1
;-> 31187.104

La funzione è lenta. Complessità temporale O(n^2)).

Vediamo la differenza del numero di cicli tra due for innestati (i = 0 e j = 0) e due for con il secondo ciclo che inizia da i = j:

(setq n 100)
(setq n 1000)
(setq n '(100 1000 10000 100000))
(dolist (el n)
  (setq num 0 num1 0)
  ; primo ciclo
  (for (i 0 (- el 1))
    (for (j 0 (- el 1))
      (++ num)
    )
  )
  ; secondo ciclo
  (for (i 0 (- el 1))
    (for (j i (- el 1))
      (++ num1)
    )
  )
  (println el { } num { } num1)
)

;-> 100 10000 5050
;-> 1000 1000000 500500
;-> 10000 100000000 50005000
;-> 100000 10000000000 5000050000

Il primo ciclo ha n^2 cicli, il secondo ha (n^2)/2 cicli.


Moltiplicazione tra numeri interi (stringhe)
--------------------------------------------

Il creatore di newLISP (Lutz Mueller) ha scritto la seguente funzione che moltiplica due numeri interi passati come stringhe (è valida anche per numeri big-integer).

(define (big* x y) ; a and b are strings of decimal digits
    (letn ( nx (length x)
            ny (length y)
            np (+ nx ny)
            X (array nx (reverse (map int (explode x))))
            Y (array ny (reverse (map int (explode y))))
            Q (array (+ nx 1) (dup 0 (+ nx 1)))
            P (array np (dup 0 np))
            carry 0
            digit 0 )
        (dotimes (i ny) ; for each digit of the multiplier
            (dotimes (j nx) ; for each digit of the multiplicant
                (setq digit (+ (* (Y i) (X j)) carry) )
                (setq carry (/ digit 10))
                (setf (Q j) (% digit 10)) )
            (setf (Q nx ) carry)
            ; add Q to P shifted by i
            (setq carry 0)
            (dotimes (j (+ nx 1))
                (setq digit (+ (P (+ j i)) (Q j) carry))
                (setq carry (/ digit 10))
                (setf (P (+ j i)) (% digit 10)) )
        )
    ; translate P to string and return
    (setq P (reverse (array-list P)))
    (if (zero? (P 0)) (pop P))
    (join (map string P))
    )
)


Numeri pandigitali
------------------

I numeri pandigitali sono numeri che contengono tutte le dieci (10) cifre 0..9 solo una volta.
Alcune volte sono consoderati pandigitali anche i numeri che contengono tutte le nove (9) cifre 1..9 solo una volta.
I numeri con zero all'inizio non vengono considerati.

Nota: I numeri pandigitali sono divisibili per 9.

Iniziamo con i numeri pandigitali (10):

(define (pan10a? n)
  (local (out)
    (cond ((or (< n 1023456789) (> n 9876543210) (!= 0 (% n 9))) (setq out nil))
          ((= (length (intersect (explode (string n)) '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))) 10)
           (setq out true))
    )
    out
  )
)

(define (pan10b? n)
  (cond ((or (< n 1023456789) (> n 9876543210) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 0 0 0 0 0 0 0 0 0))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            ;(println lst)
            (if (ref '0 lst) nil true)
          )
        )
  )
)

Primo numero pandigitale (10):     1023456789
Millesimo numero pandigitale (10): 1024658793

(define (test10a)
  (setq conta 0)
  (for (i 1023456789 1024658793) (if (pan10a? i) (++ conta)))
  conta
)

(test10a)
;-> 1000

(time (test10a))
;-> 1044.941

(define (test10b)
  (setq conta 0)
  (for (i 1023456789 1024658793) (if (pan10b? i) (++ conta)))
  conta
)

(test10b)
;-> 1000

(time (test10b))
;-> 605.393

Vediamo ora in numeri pandigitali (9):

(define (pan9a? n)
  (local (out)
    (cond ((or (< n 123456789) (> n 987654321) (!= 0 (% n 9))) (setq out nil))
          ((= (length (intersect (explode (string n)) '("1" "2" "3" "4" "5" "6" "7" "8" "9"))) 9)
           (setq out true))
    )
    out
  )
)

(define (pan9b? n)
  (cond ((or (< n 123456789) (> n 987654321) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 -1 -1 -1 -1 -1 -1 -1 -1 -1))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            ;(println lst)
            (if (ref '-1 lst) nil true)
          )
        )
  )
)

(define (test9a)
  (setq conta 0)
  (for (i 123456789 123987654) (if (pan9a? i) (++ conta)))
  conta
)

(test9a)
;-> 720

(time (test9a))
;-> 449.521

(define (test9b)
  (setq conta 0)
  (for (i 123456789 123987654) (if (pan9b? i) (++ conta)))
  conta
)

(test9b)
;-> 720

(time (test9b))
;-> 277.714


Somma dei divisori propri di un numero
--------------------------------------

Prima versione:

(define (sum-proper-divisors n)
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
  (+ 1 res)
)

Seconda versione:

(define (somma-divisori-propri n)
  (local (somma fine)
    (setq somma 0)
    (setq fine (int (sqrt n)))
    (for (i 2 fine)
      (if (zero? (% n i))
        (setq somma (+ somma i (/ n i)))
      )
    )
    (if (= n (* fine fine) (setq somma (- somma fine))))
    (+ 1 somma)
  )
)


Terza versione:

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

(sum-proper-divisors 12345678901234567)
;-> 1763668414462089
(somma-divisori-propri 12345678901234567)
;-> 1763668414462089
(somma-divisori-propri-fast 12345678901234567)
;-> 1763668414462089

(time (sum-proper-divisors 12345678901234567))
;-> 17358.122
(time (somma-divisori-propri 12345678901234567))
;-> 8089.74
(time (somma-divisori-propri-fast 12345678901234567))
;-> 199.812


Labirinti (calcolo percorsi)
============================

Un labirinto è un percorso o un insieme di percorsi, in genere con uno o più ingressi e con nessuna o più uscite.
Per risolvere un labirinto (maze) utilizzeremo il seguente algoritmo che trova la soluzione (se esiste) in modo ricorsivo. Si parte da un valore iniziale X e Y. Se i valori X e Y non sono su un muro, il metodo (funzione) richiama se stesso con tutti i valori X e Y adiacenti, assicurandosi di non aver utilizzato in precedenza quei valori X e Y. Se i valori X e Y sono quelli della posizione finale, salva tutte le istanze precedenti del metodo (risultati parziali) creando una matrice con il percorso risolutivo.
Questo metodo non garantisce che la soluzione trovata sia quella più breve.

(define (solveMaze matrice sRow sCol eRow eCol)
  (local (maze row col visited correctPath starRow startCol endRow endCol)
    ; matrice labirinto
    (setq maze matrice)
    ; righe della matrice
    (setq row (length maze))
    ; colonne della matrice
    (setq col (length (first maze)))
    ; matrice delle celle visitate
    (setq visited (array row col '(nil)))
    ; matrice soluzione del labirinto
    (setq correctPath (array row col '(nil)))
    ; posizione iniziale: riga
    (setq startRow sRow)
    ; posizione iniziale: colonna
    (setq startCol sCol)
    ; posizione finale: riga
    (setq endRow eRow)
    ; posizione finale: colonna
    (setq endCol eCol)
    ;
    ; funzione recursive solve
    ;
    (define (recursiveSolve x y)
      (catch
        (local (return)
          ;controllo se abbiamo raggiunto la fine e non è un muro
          (if (and (= x endRow) (= y endCol) (!= (maze x y) 2))
              (throw (setf (correctPath x y) true))
          )
          ; cella muro o cella visitata
          (if (or (= (maze x y) 2) (= (visited x y) true)) (throw nil))
          ; imposta cella come visitata
          (setf (visited x y) true)
          ; controllo posizione riga 0
          (if (!= x 0)
              ; richiama la funzione una riga in basso
              (if (recursiveSolve (- x 1) y)
                  (throw (setf (correctPath x y) true))
              )
          )
          ; controllo posizione riga (row - 1)
          (if (!= x (- row 1))
              ; richiama la funzione una riga in alto
              (if (recursiveSolve (+ x 1) y)
                  (throw (setf (correctPath x y) true))
              )
          )
          ; controllo posizione colonna 0
          (if (!= y 0)
              ; richiama la funzione una colonna a sinistra
              (if (recursiveSolve x (- y 1))
                  (throw (setf (correctPath x y) true))
              )
          )
          ; controllo posizione colonna (col - 1)
          (if (!= y (- col 1))
              ; richiama la funzione una colonna a destra
              (if (recursiveSolve x (+ y 1))
                  (throw (setf (correctPath x y) true))
              )
          )
          return
        );local
      ) ;catch
    ); recursiveSolve
    ;
    ; Chiama la funzione ricorsiva di soluzione
    ; Se (recursiveSolve startRow startCol) ritorna nil,
    ; allora il labirinto non ha soluzione.
    ; Altrimenti la matrice booleana "correctPath"
    ; contiene la soluzione (valori true).
    (if (recursiveSolve startRow startCol) (showPath correctPath))
  );local
)

(define (showPath matrix)
  (local (row col)
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; stampa
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (if (matrix i j) (print " 1") (print " 0"))
      )
      (println)
    )
    true
  )
)

Esempio 1:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 1 1
 2 2 1 1
 1 2 2 1
 2 2 2 1
 1 1 1 1

; definizione labirinto
(setq righe 5)
(setq colonne 4)
(setq matrice (array righe colonne '(1 1 1 1  2 2 1 1  1 2 2 1  2 2 2 1  1 1 1 1)))
(solveMaze matrice 0 0 4 3)
;-> 1 1 1 0
;-> 0 0 1 1
;-> 0 0 0 1
;-> 0 0 0 1
;-> 0 0 0 1

Esempio 2:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 2 1 2
 2 1 1 1 2
 2 1 2 2 2
 2 1 1 1 1

; definizione labirinto
(setq righe 4)
(setq colonne 5)
(setq matrice (array righe colonne '(1 1 2 1 2  2 1 1 1 2  2 1 2 2 2  2 1 1 1 1)))
(solveMaze matrice 0 0 3 4)
;-> 1 1 0 0 0
;-> 0 1 0 0 0
;-> 0 1 0 0 0
;-> 0 1 1 1 1

Esempio 3:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 2 1 2 1 1 1 2 1 2 1 2 1 2 2 1 1 1 2
 2 1 1 1 2 2 1 1 1 1 1 2 2 1 1 1 1 1 2 2
 2 1 2 2 2 2 2 1 1 2 2 2 1 2 2 2 2 1 2 1
 2 1 1 1 1 1 2 2 2 1 1 1 1 2 2 2 1 2 1 2
 1 2 2 2 2 1 2 2 1 2 1 2 1 2 2 1 1 2 2 2
 1 2 2 2 2 1 1 1 1 2 1 2 1 2 2 1 1 2 2 2
 1 2 2 2 2 2 2 2 1 2 1 2 1 2 2 1 2 1 2 2
 1 2 2 2 2 2 2 2 1 1 1 2 1 2 2 1 1 1 2 2
 1 2 2 2 2 2 2 2 1 2 2 2 1 1 1 1 2 1 1 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1

Soluzione:

 * * 2 1 2 1 1 1 2 1 2 1 2 1 2 2 1 1 1 2
 2 * 1 1 2 2 1 1 1 1 1 2 2 1 1 1 1 1 2 2
 2 * 2 2 2 2 2 1 1 2 2 2 1 2 2 2 2 1 2 1
 2 * * * * * 2 2 2 1 * * * 2 2 2 1 2 1 2
 1 2 2 2 2 * 2 2 1 2 * 2 * 2 2 1 1 2 2 2
 1 2 2 2 2 * * * * 2 * 2 * 2 2 1 1 2 2 2
 1 2 2 2 2 2 2 2 * 2 * 2 * 2 2 1 2 1 2 2
 1 2 2 2 2 2 2 2 * * * 2 * 2 2 * * * 2 2
 1 2 2 2 2 2 2 2 1 2 2 2 * * * * 2 * * *
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 *
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 *
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 *

; definizione labirinto
(setq righe 12)
(setq colonne 20)

(setq matrice (array righe colonne '(
 1 1 2 1 2 1 1 1 2 1 2 1 2 1 2 2 1 1 1 2
 2 1 1 1 2 2 1 1 1 1 1 2 2 1 1 1 1 1 2 2
 2 1 2 2 2 2 2 1 1 2 2 2 1 2 2 2 2 1 2 1
 2 1 1 1 1 1 2 2 2 1 1 1 1 2 2 2 1 2 1 2
 1 2 2 2 2 1 2 2 1 2 1 2 1 2 2 1 1 2 2 2
 1 2 2 2 2 1 1 1 1 2 1 2 1 2 2 1 1 2 2 2
 1 2 2 2 2 2 2 2 1 2 1 2 1 2 2 1 2 1 2 2
 1 2 2 2 2 2 2 2 1 1 1 2 1 2 2 1 1 1 2 2
 1 2 2 2 2 2 2 2 1 2 2 2 1 1 1 1 2 1 1 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1)))

(solveMaze matrice 0 0 11 19)
;-> 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 1 1 1 1 1 0 0 0 0 1 1 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 1 0 0 0 0 1 0 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 1 1 1 1 0 1 0 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 1 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 1 1 1
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1

Esempio 4:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 2 1 2 1 1 1 2
 2 1 1 1 2 2 1 1 1
 2 1 2 2 2 2 2 1 1
 2 1 1 1 1 1 2 2 2
 1 2 2 2 2 1 2 2 1
 1 2 2 2 2 1 2 1 1
 1 2 2 2 2 2 2 2 1
 1 2 2 2 2 2 2 2 1
 1 2 2 2 2 2 2 2 1

Nessuna soluzione.

; definizione labirinto
(setq righe 9)
(setq colonne 9)

(setq matrice (array righe colonne '(
 1 1 2 1 2 1 1 1 2
 2 1 1 1 2 2 1 1 1
 2 1 2 2 2 2 2 1 1
 2 1 1 1 1 1 2 2 2
 1 2 2 2 2 1 2 2 1
 1 2 2 2 2 1 2 1 1
 1 2 2 2 2 2 2 2 1
 1 2 2 2 2 2 2 2 1
 1 2 2 2 2 2 2 2 1)))

(solveMaze matrice 0 0 8 8)
;-> nil

(solveMaze matrice 0 0 5 5)
;-> 1 1 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0
;-> 0 1 1 1 1 1 0 0 0
;-> 0 0 0 0 0 1 0 0 0
;-> 0 0 0 0 0 1 0 0 0
;-> 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0

Esempio 5:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 2 1 2 1 1 2 1
 2 1 1 1 2 2 1 1 1
 2 1 2 2 2 2 2 1 2
 2 1 1 1 1 1 2 1 1
 1 2 2 2 2 1 2 2 1
 1 2 2 2 2 1 1 1 1
 1 1 1 1 1 2 1 2 1
 1 2 2 2 1 2 1 2 1
 1 2 2 2 1 1 1 2 1

Soluzione:

 1 1 2 1 2 1 1 2 *
 2 1 1 1 2 2 1 * *
 2 1 2 2 2 2 2 * 2
 2 1 1 1 1 1 2 * *
 1 2 2 2 2 1 2 2 *
 1 2 2 2 2 1 * * *
 * * * * * 2 * 2 1
 * 2 2 2 * 2 * 2 1
 * 2 2 2 * * * 2 1

; definizione labirinto
(setq righe 9)
(setq colonne 9)

(setq matrice (array righe colonne '(
 1 1 2 1 2 1 1 2 1
 2 1 1 1 2 2 1 1 1
 2 1 2 2 2 2 2 1 2
 2 1 1 1 1 1 2 1 1
 1 2 2 2 2 1 2 2 1
 1 2 2 2 2 1 1 1 1
 1 1 1 1 1 2 1 2 1
 1 2 2 2 1 2 1 2 1
 1 2 2 2 1 1 1 2 1)))

(solveMaze matrice 8 0 0 8)
;-> 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 0 1 1
;-> 0 0 0 0 0 0 0 1 0
;-> 0 0 0 0 0 0 0 1 1
;-> 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 1 1 1
;-> 1 1 1 1 1 0 1 0 0
;-> 1 0 0 0 1 0 1 0 0
;-> 1 0 0 0 1 1 1 0 0


Moltiplicazioni di Fattori
==========================

Dato un numero N, creare la lista dei numeri che possono essere ottenuti dal prodotto di tutte le combinazioni dei fattori primi del numero N.
Nota: i numeri primi restituiscono una lista vuota.

Esempio:
N = 12
Fattori = 2 2 3
Prodotti = 2*2 2*3 2*2*3 = 4 6 12

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(setq fattori (factor 12))

(setq c1 (combinazioni 1 fattori))
;-> ((2) (2) (3))
(setq c2 (combinazioni 2 fattori))
;-> ((2 2) (2 3) (2 3))
(setq c3 (combinazioni 3 fattori))
;-> ((2 2 3))

(setq r1 (map (fn (x) (apply * x)) c1))
;-> (2 2 3)
(setq r2 (map (fn (x) (apply * x)) c2))
;-> (4 6 6)
(setq r3 (map (fn (x) (apply * x)) c3))
;-> (12)
(setq r (append r1 r2 r3))
;-> (2 2 3 4 6 6 12)
(setq r (unique r))
;-> (2 3 4 6 12)
(setq r (difference r fattori))
;-> (4 6 12)

Esempio con N = 36:

(setq fattori (factor 36))
(setq c1 (combinazioni 1 fattori))
;-> ((2) (2) (3) (3))
(setq c2 (combinazioni 2 fattori))
;-> ((2 2) (2 3) (2 3) (2 3) (2 3) (3 3))
(setq c3 (combinazioni 3 fattori))
;-> ((2 2 3) (2 2 3) (2 3 3) (2 3 3))
(setq c4 (combinazioni 4 fattori))
;-> ((2 2 3 3))

(setq r1 (map (fn (x) (apply * x)) c1))
;-> (2 2 3 3)
(setq r2 (map (fn (x) (apply * x)) c2))
;-> (4 6 6 6 6 9)
(setq r3 (map (fn (x) (apply * x)) c3))
;-> (12 12 18 18)
(setq r4 (map (fn (x) (apply * x)) c4))
;-> (36)

(setq r (difference (unique(append r1 r2 r3 r4)) fattori))
;-> (4 6 9 12 18 36)

Possiamo scrivere la funzione:

(define (mult-fact n)
  (local (fattori c r out)
    (setq out '())
    (setq fattori (factor n))
    (if (= fattori nil) '()
      (begin
        (for (i 1 (length fattori))
          (setq c (combinazioni i fattori))
          (setq r (map (fn (x) (apply * x)) c))
          (push r out -1)
        )
        (sort (difference (unique (flat out)) fattori))
      )
    );if
  );local
)

(mult-fact 12)
;-> (4 6 12)

(mult-fact 36)
;-> (4 6 9 12 18 36)

(mult-fact 100)
;-> (4 10 25 20 50 100)

(mult-fact 31)
;-> ()

(mult-fact 1)
;-> ()

(mult-fact 10032)
;-> (4 6 8 12 16 22 24 33 38 44 48 57 66 76 88 114 132 152 176 209 228
;->  264 304 418 456 528 627 836 912 1254 1672 2508 3344 5016 10032)

Vediamo per curiosità quale numero fino a diecimila genera la lista più lunga.

(define (entro10000)
  (setq lungo 0)
  (setq val 0)
  (for (i 10 10000)
    (if (> (length (mult-fact i)) lungo)
      (setq lungo (length (mult-fact i)) val i)
    )
  )
  (println "numero: " val { --- } "lunghezza: " lungo)
)

(entro10000)
;-> numero: 7560 --- lunghezza: 59


Problemi patologici dei numeri floating point
=============================================

La Chaotic Bank Society offre questo investimento ai propri clienti.
Per prima cosa depositi $ e - 1 dove e è 2.7182818 ... la base dei logaritmi naturali.

Dopo ogni anno, il saldo del tuo account verrà moltiplicato per il numero di anni che sono passati e verranno rimossi $ 1 in costi di servizio.

Così ...

dopo 1 anno, il saldo verrà moltiplicato per 1 e $ 1 verrà rimosso per le spese di servizio.
dopo 2 anni il saldo sarà raddoppiato e $ 1 rimosso.
dopo 3 anni il saldo sarà triplicato e $ 1 rimosso.
...
dopo 10 anni, moltiplicato per 10 e $ 1 rimosso, e così via.

Quale sarà il tuo saldo dopo 25 anni?

Risultato corretto:
    Saldo iniziale: (e - 1)
    Saldo = (Saldo * anno) - 1 (per 25 anni)
    Saldo dopo 25 anni: 0.0399387296732302

Proviamo con una funzione che utilizza i numeri floating point:

(define (banca)
  (local (e deposito)
    ;definiamo il numero e
    (setq e (exp 1))
    (setq deposito (sub e 1))
    (for (i 1 25)
      (setq deposito (sub (mul deposito i) 1))
      (println i { } deposito)
    )
    deposito
  )
)

(banca)
;-> 1   0.7182818284590451
;-> 2   0.4365636569180902
;-> 3   0.3096909707542705
;-> 4   0.2387638830170822
;-> 5   0.1938194150854109
;-> 6   0.1629164905124654
;-> 7   0.1404154335872576
;-> 8   0.1233234686980609
;-> 9   0.1099112182825479
;-> 10  0.09911218282547907
;-> 11  0.09023401108026974
;-> 12  0.08280813296323686
;-> 13  0.07650572852207915
;-> 14  0.07108019930910814
;-> 15  0.06620298963662208
;-> 16  0.05924783418595325
;-> 17  0.007213181161205284
;-> 18 -0.8701627390983049
;-> 19 -17.53309204286779
;-> 20 -351.6618408573559
;-> 21 -7385.898658004473
;-> 22 -162490.7704760984
;-> 23 -3737288.720950264
;-> 24 -89694930.30280632
;-> 25 -2242373258.570158
;-> -2242373258.570158

Il risultato è sbagliato, poichè gli arrotondamenti delle operazioni floating point fanno divergere i calcoli.
Per risolvere il problema possiamo usare le frazioni, cioè eseguiamo tutti i calcoli con le frazioni (numeri interi) e usiamo la divisione solo per ottenere il valore del risultato come floating point. Per fare questo dobbiamo rappresentare anche il numero "e" con una frazione:

e = 106246577894593683 / 39085931702241241

Le funzioni per utilizzare le quattro operazioni delle frazioni sono le seguenti:

(define (semplifica frac)
  (local (num den n d temp, nums dens)
    (setq num (first frac))
    (setq den (last frac))
    (setq n (first frac))
    (setq d (last frac))
    ; calcola il numero massimo che divide esattamente numeratore e denominatore
    (while (!= d 0)
      (setq temp d)
      (setq d (% n temp))
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

(define (+f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (+ (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(define (-f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (- (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(define (*f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (* n1 n2))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(define (/f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (* n1 d2))
    (setq den (* d1 n2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

Adesso riscriviamo la funzione che calcola il valore finale dell'investimento:

(define (banca)
  (local (e deposito)
    ;definiamo il numero e
    (setq e '(106246577894593683L 39085931702241241L))
    (setq deposito (-f e '(1 1)))
    (for (i 1 25)
      (setq deposito (-f (*f deposito (list i 1)) '(1 1)))
      (println i { } deposito { } (div (first deposito) (last deposito)))
    )
    deposito
  )
)

(banca)
;-> 1  (28074714490111201L 39085931702241241L) 0.7182818284590452
;-> 2  (17063497277981161L 39085931702241241L) 0.4365636569180905
;-> 3  (12104560131702242L 39085931702241241L) 0.3096909707542714
;-> 4  (9332308824567727L 39085931702241241L) 0.2387638830170857
;-> 5  (7575612420597394L 39085931702241241L) 0.1938194150854282
;-> 6  (6367742821343123L 39085931702241241L) 0.1629164905125695
;-> 7  (5488268047160620L 39085931702241241L) 0.1404154335879862
;-> 8  (4820212675043719L 39085931702241241L) 0.1233234687038897
;-> 9  (4295982373152230L 39085931702241241L) 0.1099112183350075
;-> 10 (3873892029281059L 39085931702241241L) 0.09911218335007542
;-> 11 (3526880619850408L 39085931702241241L) 0.09023401685082953
;-> 12 (3236635735963655L 39085931702241241L) 0.08280820220995427
;-> 13 (2990332865286274L 39085931702241241L) 0.07650662872940559
;-> 14 (2778728411766595L 39085931702241241L) 0.07109280221167809
;-> 15 (2594994474257684L 39085931702241241L) 0.06639203317517139
;-> 16 (2433979885881703L 39085931702241241L) 0.06227253080274239
;-> 17 (2291726357747710L 39085931702241241L) 0.05863302364662064
;-> 18 (2165142737217539L 39085931702241241L) 0.05539442563917152
;-> 19 (2051780304892000L 39085931702241241L) 0.05249408714425882
;-> 20 (1949674395598759L 39085931702241241L) 0.04988174288517631
;-> 21 (1857230605332698L 39085931702241241L) 0.04751660058870241
;-> 22 (1773141615078115L 39085931702241241L) 0.04536521295145283
;-> 23 (1696325444555404L 39085931702241241L) 0.04339989788341503
;-> 24 (1625878967088455L 39085931702241241L) 0.04159754920196069
;-> 25 (1561042474970134L 39085931702241241L) 0.03993873004901714
;-> (1561042474970134L 39085931702241241L)

Questa volta il risultato è esatto.


======================================================================

 DOMANDE PER ASSUNZIONE DI PROGRAMMATORI (CODING INTERVIEW QUESTIONS)

======================================================================

Notazione Big-O
---------------
Valori della notazione Big-O in funzione del numero di ingresso

 n  costante logaritmo  lineare   nlogn      quadrato   cubo    esponenziale
 1    O(1)   O(log(n))   O(n)   O(n*log(n))   O(n^2)   O(n^3)       O(2^n)
 2     1        1          1        1             1        1            1
 4     1        1          2        2             4        8            4
 8     1        3          8       24            64      512          256
16     1        4         16       64           256     4096        65536
32     1        5         32      160          1024    32768   4294967296
64     1        6         64      384          4096   262144   1.84x10^19


Contare i bit di un numero (McAfee)
-----------------------------------
Dato un numero intero positivo n, contare il numero di bit che valgono 1 nella sua rappresentazione binaria.

Possiamo trasformare il numero in binario e contare quanti bit hanno valore 1.
Le funzioni di conversione decimale e binario sono le seguenti:

(define (bin2dec n)
  (if (zero? n) n
      (+ (% n 10) (* 2 (bin2dec (/ n 10))))))

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))))

Siccome non dobbiamo ricreare il numero binario, ci limiteremo a contare i bit con valore 1.

Con l'operazione modulo (% n 2), estraiamo il bit più a destra del numero n (il bit meno significativo).
Esempio: consideriamo il numero 25

(dec2bin 25)
;-> 11001

Calcoliamo (% 25 2):
(% 25 2)
;-> 1

Poi calcoliamo (% 12 2), con 25/2 = 12
(% 12 2)
;-> 0

(% 6 2)
;-> 0

(% 3 2)
;-> 1

(% 1 2)
;-> 1

Ed ecco la funzione per contare i bit con valore 1:

(define (bit1 n)
  (let (conta 0)
    (while (> n 0)
       (if (= (% n 2) 1) (++ conta))
       (setq n (/ n 2))
    )
    conta
  )
)

(bin2dec 10001011001)
;-> 1113
(bit1 1133)
;-> 6

(bin2dec 1110011010001)
;-> 7377
(bit1 7377)
;-> 7

Per estrarre il bit più a destra di un numero possiamo usare anche le funzioni bitwise:
Usando l'operatore bitwise AND "&", l'espressione (n & 1) produce un valore che è 1 o 0, a seconda del bit meno significativo di x: se l'ultimo bit è 1 allora il risultato di (x & 1) vale 1, altrimenti vale 0.
Usando l'operatore SHIFT ">>", l'espressione (n >> 1) sposta (shifta) di un bit verso destra il valore del numero n. In altre parole, divide il numero n per 2.
La funzione diventa:

(define (nbit1 n)
  (let (conta 0)
    (if (< n 0) (setq n (sub 0 n))) ; altrimenti il ciclo non termina
    (while (> n 0)
      (if (= (& n 1) 1) (++ conta))
      (setq n (>> n))
    )
    conta
  )
)

(bin2dec 10001011001)
;-> 1113
(nbit1 1133)
;-> 6

(bin2dec 1110011010001)
;-> 7377
(nbit1 7377)
;-> 7
(nbit1 -1133)
;-> 6
(int "-10001101101" 0 2)
;-> -1133

Nota: il valore del bit più significativo dopo lo spostamento è zero per i valori di tipo senza segno (unsigned). Per i valori di tipo con segno (signed), il bit più significativo viene copiato dal bit del segno del valore prima dello spostamento come parte dell'estensione del segno, quindi il ciclo non termina mai se n è di tipo con segno e il valore iniziale è negativo.

Ora vediamo quale metodo è più veloce:

(bit1 123456789)
;-> 16

(time (bit1 123456789) 100000)
;-> 527.479

(nbit1 123456789)
;-> 16

(time (nbit1 123456789) 100000)
;-> 494.247

La funzione che usa gli operatori bitwise è leggermente più veloce.


Scambiare il valore di due variabili (McAfee)
---------------------------------------------
Come scambiare il valore di due variabili (swap) senza utilizzare una variabile di appoggio?

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
4. calcolare il valore della stringa
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

Se vogliamo trovare la somma di ogni combinazione di due elementi di una lista il metodo più ovvio è quello di creare due for..loop sulla lista e verificare se soddisfano la nostra condizione.
Tuttavia, in questi casi, puoi sempre ridurre la complessità O(n^2) a O(log(n)) avviando il secondo ciclo dal corrente elemento della lista, perché, ad ogni passo del primo ciclo, tutti gli elementi precedenti sono già confrontati tra loro.
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


Quantità d'acqua in un bacino (Facebook)
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

Una soluzione semplice consiste nel percorrere ogni elemento dell'array e trovare le barre più alte sui lati sinistro e destro. Prendere la minore delle due altezze. La differenza tra altezza minima e altezza dell'elemento corrente è la quantità di acqua che può essere immagazzinata in questo elemento dell'array. La complessità temporale di questa soluzione è O(n^2).

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

(bacino '(1 1 1 1 1 1 1 1 1 1 1 1)) ; bacino piatto
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0

Vediamo un altro esempio:

lista: (2 3 5 3 4 3 4 3 3 7 9 3 8))

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
acqua: 15

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
acqua: 78

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

; collineari uniti (senza sovrapposizione)
(intersect-line 1 1 2 2 2 2 3 3)
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

Una soluzione semplice è quella di ordinare i punteggi in ordine crescente e poi assegnare le caramelle dando una caramella al punteggio più basso, due caramelle al successivo , tre a quello successivo e così via fino all'ultimo bambino.

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


Unire due liste ordinate (Facebook)
-----------------------------------
L'ordinamento delle liste può essere sia crescente che decrescente. Useremo un parametro "op" con il seguente significato:
- se "op" vale ">" le liste sono ordinate in modo crescente
- se "op" vale "<" le liste sono ordinate in modo decrescente

(define (unisce lst1 lst2 op)
  (local (i j k m n out)
    (if (< (length lst1) (length lst2)) (swap lst1 lst2)) ;la prima lista deve essere più lunga
    (setq m (length lst1))
    (setq n (length lst2))
    (setq i (sub m 1))
    (setq j (sub n 1))
    (setq k (add m n -1))
    (setq out (array (add m n))) ; vettore risultato
    (while (>= k 0)
      (if (or (< j 0) (and (>= i 0) (op (lst1 i) (lst2 j))))
          (begin (setf (out k) (lst1 i))
                 (-- k)
                 (-- i))
          (begin (setf (out k) (lst2 j))
                 (-- k)
                 (-- j))
      )
    )
    (array-list out) ;converte il vettore risultato in lista
  ); local
)

(unisce '(1 2 3 4 5) '(4 5) >)
;-> (1 2 3 4 4 5 5)

(unisce '(4 5) '(1 2 3 4 5) >)
;-> (1 2 3 4 4 5 5)

(unisce '(7 5 4 1) '(6 5 3) <)
;-> (7 6 5 5 4 3 1)


Salire le scale (Amazon)
------------------------
Esiste una scala con N scalini e puoi salire di 1 o 2 passi alla volta. Dato N, scrivi una funzione che restituisce il numero di modi unici in cui puoi salire la scala. L'ordine dei passaggi è importante.

Ad esempio, se N è 4, esistono 5 modi unici: (1, 1, 1, 1) (2, 1, 1) (1, 2, 1) (1, 1, 2) (2, 2).

Cosa succede se, invece di essere in grado di salire di 1 o 2 passi alla volta, è possibile salire qualsiasi numero da un insime di interi positivi X? Ad esempio, se X = {1, 3, 5}, potresti salire 1, 3 o 5 passi alla volta.

QUesto è un classico problema ricorsivo. Iniziamo con casi semplici e cercando di trovare una regola di calcolo (relazione).

N = 1: [1]
N = 2: [1, 1], [2]
N = 3: [1, 2], [1, 1, 1], [2, 1]
N = 4: [1, 1, 2], [2, 2], [1, 2, 1], [1, 1, 1, 1], [2, 1, 1]

Qual è la relazione?

Gli unici modi per arrivare a N = 3, è di arrivare prima a N = 1, e poi salire di 2 passi, oppure di arrivare a N = 2 e salire di 1 passo. Quindi f(3) = f(2) + f(1).

Questo vale per N = 4? Sì. Dal momento che possiamo arrivare al 4° scalino solo partendo dal 3° scalino e salendo di uno oppure partendo dal 2° scalino e salendo di due. Quindi f(4) = f(3) + f(2).

Generalizziamo, f (n) = f (n - 1) + f (n - 2). Questa è la nota sequenza di Fibonacci.

Versione ricorsiva:

(define (fibo n)
  (if (< n 2) 1
    (+ (fibo (- n 1)) (fibo (- n 2)))))


(fibo 35)
;-> 14930352

(time (fibo 35))
;-> 4456.463

Questa è molto lenta perchè stiamo facendo molti calcoli ripetuti: O(2^N).

Vediamo di velocizzare il calcolo scrivendo una versione ricorsiva memoized e una versione iterativa.

Versione ricorsiva memoized:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(memoize fibo-m
  (lambda (n)
    (if (< n 2) 1
      (+ (fibo-m (- n 1)) (fibo-m (- n 2))))))

(fibo-m 35)
;-> 14930352

(time (fibo-m 35))
;-> 0

Versione iterativa (che funziona anche per i big integer):

(define (fibo-i n)
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 n)
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

(fibo-i 35)
;-> 14930352L

(time (fibo-i 35))
;-> 0

Proviamo a generalizzare questo metodo in modo che funzioni usando un numero di passi dall'insieme X.
Un ragionamento simile ci dice che se X = {1, 3, 5}, allora il nostro algoritmo dovrebbe essere f(n) = f(n - 1) + f(n - 3) + f(n - 5).
Se n < 0, allora dobbiamo restituire 0 poiché non possiamo iniziare da un numero negativo di passi.
Se n = 0, allora dobbiamo restituire 1.
Altrimenti dobbiamo restituire ricorsivamente la somma di tutti i risultati delle chiamate alla funzione.

scala(n, X):
    if n < 0:      return 0
    elseif n == 0: return 1
    else: return sum(staircase(n - x, X) for x in X)

Tradotto in newLISP:

(define (scala n lst)
    (if (< n 0)
        0
         (if (= n 0)
            1
            (apply + (map (lambda (x) (scala (sub n x) lst)) lst))
         )
    )
)

(scala 4 '(1 2))
;-> 5

(scala 8 '(4))
;-> 1

(scala 10 '(1 2 3))
;-> 274

(scala 25 '(1 2 3))
;-> 2555757

(time (scala 25 '(1 2 3)))
;-> 2508.452

Anche questo funzione è lenta O(|X|^N), poichè ripetiamo molti calcoli.

Velocizziamo i calcoli scrivendo una versione ricorsiva memoized e una versione iterativa.

Versione ricorsiva memoized:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(memoize scala-m
  (lambda (n lst)
     (if (< n 0)
        0
         (if (= n 0)
            1
            (apply + (map (lambda (x) (scala-m (sub n x) lst)) lst))
         )
    )
  )
)

(scala-m 4 '(1 2))
;-> 5

(scala-m 8 '(4))
;-> 1

(scala-m 10 '(1 2 3))
;-> 274

(scala-m 25 '(1 2 3))
;-> 2555757

(time (scala-m 25 '(1 2 3)))
;-> 0

Varsione iterativa (programmazione dinamica):

Ogni i-esimo elemento della lista cache conterrà il numero di modi in cui possiamo arrivare al punto i con l'insieme X. Quindi costruiremo la lista da zero utilizzando i valori precedentemente calcolati per trovare quelli successivi:

(define (scala-i num lst)
  (local (ca)
    (setq ca (dup 0 (add num 1)))
    (setf (ca 0) 1)
    (for (i 1 num)
      (dolist (x lst)
        (if (>= (sub i x) 0)
          ;(begin (println "i= " i { } "x= " x)
            (setf (ca i) (add (ca i) (ca (sub i x))))
          ;)
        )
      )
    )
    (ca num)
  );local
)

(scala-i 4 '(1 2))
;-> 5

(scala-i 8 '(4))
;-> 1

(scala-i 10 '(1 2 3))
;-> 274

(scala-i 25 '(1 2 3))
;-> 2555757

(time (scala-i 25 '(1 2 3)))
;-> 0


Numeri interi con segni opposti (MacAfee)
-----------------------------------------
Determinare se due numeri interi hanno segni opposti (true).

Applicando l'operatore bitwise XOR "^" ai quattro casi possibili si ottiene:

(^ -2 3)
;-> -3
(^ -2 -3)
;-> 3
(^ 2 3)
;-> 1
(^ 2 -3)
;-> -1

Vediamo la tavola della verità:

   a   |   b  | XOR | segno
   -----------|-----|-------
  -2   |   3  | -3  | diverso
  -2   |  -3  |  3  | uguale
   2   |   3  |  1  | uguale
   2   |  -3  | -1  | diverso

Possiamo notare che:
- se il risultato dello XOR tra i numeri a e b è negativo, allora i numeri hanno segno diverso.
- se il risultato dello XOR tra i numeri a e b è positivo, allora i numeri hanno segno uguale.

Possiamo scrivere la funzione:

(define (opposti a b)
  (if (> (^ a b) 0) nil true))

(opposti -2 3)
;-> true

(opposti -2 -3)
;-> nil

(opposti 2 3)
;-> nil

(opposti 2 -3)
;-> true


Parità di un numero (McAfee)
----------------------------

Parità: la parità di un numero si riferisce al numero di bit che valgono 1.
Il numero ha "parità dispari", se contiene un numero dispari di 1 bit ed è "parità pari" se contiene un numero pari di 1 bit.

Se n non vale zero, allora creiamo un ciclo che, affinchè n non diventa 0, disattiva a destra uno dei bit impostati a 1 e inverte la parità.
L'algoritmo è il seguente:

A. Inizialmente parità = 0
B. Ciclo while n! = 0
       1. Invertire la parità
          parità = not parità
       2. Annullare il bit 1 più a destra del numero con l'operatore bitwise AND "&"
          n = n & (n-1)
C. Restituire parità (pari o dispari)

Scriviamo la funzione:

(define (parita n)
  (local (out)
    (setq out nil)
    (while (!= n 0)
      (setq out (not out))
      ; annulla il bit più a destra del numero
      (setq n (& n (- n 1))) ; "&" = operatore bitwise AND
      (println n)
    )
    (if (= out true) 'dispari 'pari)
  )
)

Vediamo come funziona (con l'epressione print attivata):

(parita 22) ; 22 -> 10110
;-> 20      ; 20 -> 10100
;-> 16      ; 16 -> 10000
;-> 0       ;  0 -> 0

Per controllare la correttezza utilizziamo le funzioni di conversione tra numero decimale e binario.

(define (bin2dec n)
  (if (zero? n) n
      (+ (% n 10) (* 2 (bin2dec (/ n 10))))))

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))
   )
)

(dec2bin 1133)
;-> 10001101101

(parita 1133)
;-> pari

(dec2bin 1113)
;-> 10001011001

(parita 1113)
;-> dispari


Numero potenza di due (Google)
------------------------------
Determinare se un numero intero positivo n è una potenza di due.

Primo metodo:
Il logaritmo in base 2 di un numero che è una potenza di due è un numero intero.

(define (isPower2 n)
  (if (zero? n) nil
      (= (log n 2) (int (log n 2)))
  )
)

(isPower2 1024)
;-> true

(isPower2 1000)
;-> nil

Secondo metodo:
Un numero potenza di due ha un solo 1 nella sua rappresentazione binaria.

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))))

(dec2bin 256)
;-> 100000000

(dec2bin 2048)
;-> 100000000000

Questa funzione conta i bit del numero n che hanno valore 1:

(define (bit1 n)
  (let (conta 0)
    (while (> n 0)
       (if (= (% n 2) 1) (++ conta))
       (setq n (/ n 2))
    )
    conta
  )
)

(setq n 1024)
(& n (sub n 1))

(setq n 1000)

(define (isPower2 n)
  (if (= (bit1 n) 1) true nil)
)

(isPower2 1024)
;-> true

(isPower2 1000)
;-> nil

Terzo metodo:
Se sottraiamo il valore 1 ad un numero che è potenza di due, l'unico bit con valore 1 viene posto a 0 e i bit con valore 0 vengono posti a 1:

(dec2bin 1024)
;-> ;-> 10000000000

(dec2bin (sub 1024 1))
;-> 1111111111 ; senza lo zero in testa

Quindi applicando l'operatore bitwise AND "&" ai numeri n e (n - 1) otteniamo 0 se e solo se n è una potenza di due: (n & (n -1)) == 0 se e solo se n è una potenza di due.
Nota: L'espressione n & (n-1) non funziona quando n vale 0.

(define (isPower2 n)
  (if (zero? n) nil
      (if (zero? (& n (sub n 1)) true nil))
  )
)

(isPower2 1024)
;-> true

(isPower2 1000)
;-> nil


Stanze e riunioni (Snapchat)
----------------------------
Data una serie di intervalli di tempo (inizio, fine) per delle riunioni (con tempi che si possono sovrapporre), trovare il numero minimo di stanze richieste.
Ad esempio, la lista ((30 75) (0 50) (60 150)) dovrebbe restituire 2.

Creiamo e ordiniamo due liste "inizio" e "fine", poi le visitiamo in ordine crescente di tempo.
Se troviamo un inizio aumentiamo il numero di stanze, se invece troviamo una fine, allora diminuiamo il numero di stanze.
Inoltre dobbiamo tenere conto del numero massimo di stanze raggiunto.

 | inizio | fine |  tipo  | stanze |
-------------------------------------
 |    0   |      | inizio |    1   |
 |   30   |      | inizio |    2   |
 |        |  50  |  fine  |    1   |
 |   60   |      | inizio |    2   |
 |        |  75  |  fine  |    1   |
 |        | 150  |  fine  |    0   |

(define (min-stanze lst)
  (local (inizio fine stanze_richieste massimo_stanze i j n)
    (setq inizio '())
    (setq fine '())
    (dolist (el lst)
      (push (first el) inizio -1)
      (push (last el) fine -1)
    )
    (sort inizio)
    (sort fine)
    (setq stanze_richieste 0)
    (setq massimo_stanze 0)
    i = j = 0
    (setq i 0 j 0)
    (setq n (length lst))
    (while (and (< i n) (< j n))
      (if (< (inizio i) (fine j))
        (begin
          (++ stanze_richieste)
          (setq massimo_stanze (max stanze_richieste massimo_stanze))
          (++ i))
        (begin
          (-- stanze_richieste)
          (++ j))
      )
    )
    massimo_stanze
  );local
)

(min-stanze '((20 30) (0 20) (30 40)))
;-> 1

(min-stanze '((30 75) (0 50) (60 150)))
;-> 2

(min-stanze '((90 91) (94 120) (95 112) (110 113) (150 190) (180 200)))
;-> 3

Questo metodo risponde anche ad un'altra domanda:
Data una serie di intervalli di tempo, una persona può assistere a tutte le riunioni?
Se il numero minimo di stanze è pari a uno, allora la risposta è affermativa, altrimenti ci sono due o più riunioni che si sovrappongono.
Possiamo risolvere questo problema in modo più semplice.
Se una persona può partecipare a tutte le riunioni, non deve esserci alcuna sovrapposizione tra una riunione e l'altra.
Dopo aver ordinato gli intervalli, possiamo confrontare la "fine" attuale con il prossimo "inizio".

public boolean canAttendMeetings(Interval[] intervals) {
    Arrays.sort(intervals, new Comparator<Interval>(){
        public int compare(Interval a, Interval b){
            return a.start-b.start;
        }
    });

    for(int i=0; i<intervals.length-1; i++){
        if(intervals[i].end>intervals[i+1].start){
            return false;
        }
    }

    return true;
}


Bilanciamento parentesi (Facebook)
----------------------------------
Data una stringa contenente parentesi tonde, quadre e graffe (aperte e chiuse), restituire
se le parentesi sono bilanciate (ben formate) e rispettano l'ordine ("{}" > "[]" > "()").
Ad esempio, data la stringa "[()] [] {()}", si dovrebbe restituire true.
Data la stringa "([]) [] ({})", si dovrebbe restituire false (le graffe non ossono stare dentro le tonde).
Data la stringa "([)]" o "((()", si dovrebbe restituire false.

Usiamo un contatore per ogni tipo di parentesi e verifichiamo la logica corretta durante la scansione della stringa.

La seguente funzione controlla la correttezza delle parentesi:

(define (par s op)
  (local (out p1o p2o p3o ch)
    (setq out true)
    (dostring (c s (= out nil))
      (setq ch (char c))
      (cond ((= ch "(")
              (++ p1o)
            )
            ((= ch "[")
              ; esiste una par "(" non chiusa
              (if (> p1o 0)
                  (setq out nil)
                  (++ p2o)
              )
            )
            ((= ch "{")
              ; esiste una par "(" o "[" non chiusa
              (if (or (> p1o 0) (> p2o 0))
                  (setq out nil)
                  (++ p3o)
              )
            )
            ((= ch ")")
              ; nessuna par "(" da chiudere
              (if (= p1o 0)
                  (setq out nil)
                  (-- p1o)
              )
            )
            ((= ch "]")
              ; esiste una par ")" da chiudere OR
              ; nessuna par "[" da chiudere
              (if (or (> p1o 0) (= p2o 0))
                  (setq out nil)
                  (-- p2o)
              )
            )
            ((= ch "}")
              ; esiste una par ")" da chiudere OR
              ; esiste una par "]" da chiudere OR
              ; nessuna par "{" da chiudere
              (if (or (> p1o 0) (> p2o 0) (= p3o 0))
                  (setq out nil)
                  (-- p3o)
              )
            )
      );cond
    );dostring
    ; controllo accoppiamento parentesi ed errore
    (if (and (zero? p1o) (zero? p2o) (zero? p3o) (= out true))
      true
      nil
    )
  );local
)

(par "{ { ( [ [ ( ) ] ] ) } }")
;-> nil
(par "{ { ( [ [ ( ( ) ] ] ) } }")
;-> nil
(par "{ { [ [ [ ( ) ] ] ] } }")
;-> true
(par "{ { [ [ } } [ ( ) ] ] ]")
;-> nil
(par "{ { [ [ [ ( ) ] ] ] } { [ ( ) ] }}")
;-> true


K punti più vicini (K Nearest points) (LinkedIn)
------------------------------------------------

Data una lista di N punti (xi, yi) sul piano cartesiano 2D, trova i K punti più vicini ad un punto centrale C (xc, yc). La distanza tra due punti su un piano è la distanza euclidea.
È possibile restituire la risposta in qualsiasi ordine.
Esempi
Input:  punti = ((0,0), (5,4), (3,1)), P=(1,2), K = 2
Output: ((0,0), (3,1))

   5 |
     |
   4 |              X
     |
   3 |  X
     |
   2 |  C
     |
   1 |
     |
   0 X---------------------------
     0  1  2  3  4  5  6  7  8  9

Input:  punti = ((3,3), (5,-1), (-2,4)), P=(0,0), K = 2
Output: ((3,3), (-2,4))

Soluzione A: Ordinamento semplice
Creare una lista con tutte le distanze di ogni punto dal punto centrale. Ordinare la lista delle distanze. Selezionare i primi k punti dalla lista ordinata.

Nota: meglio non usare la funzione sqrt (radice quadrata) nel calcolo della distanza. Le operazioni saranno molto più veloci, soprattutto se i punti hanno coordinate intere.

Lista di punti: ((x0 y0) (x1 y1)...(xn yn))
Punto centrale: P = (xp yp)
Elementi da selezionare: k

;calcola il quadrato della distanza tra due punti
(define (qdist P0 P1)
  (local (x0 y0 x1 y1)
    (setq x0 (first P0))
    (setq y0 (last P0))
    (setq x1 (first P1))
    (setq y1 (last P1))
    ; no radice quadrata (l'ordine dei punti rimane invariato)
    (+ (* (sub x1 x0) (sub x1 x0)) (* (sub y1 y0) (sub y1 y0)))
  )
)

(qdist '(0 0) '(1 1))
;-> 2

(qdist '(1 1) '(1 3))
;-> 4

(define (kClosest punti C k)
  (local (distlst n out)
    (setq out '())
    (setq distlst '())
    (setq n (length punti))
    ; creo la lista delle distanze
    (for (i 0 (- n 1))
      (push (list (qdist (punti i) C) (punti i)) distlst -1)
    )
    (sort distlst) ; sort usa il primo elemento di ogni sottolista
    ;k deve essere minore o uguale a n
    (if (> k n) (setq k n))
    ;trova i k punti con distanza minore dal punto centrale
    (for (i 0 (- k 1))
      (push (distlst i) out -1)
    )
    out
  )
)

(kClosest '((1 1) (8 9) (4 5) (32 12)) '(0 0) 2)
;-> ((2 (1 1)) (41 (4 5)))

Complessità temporale: O(NlogN), dove N è il numero di punti.
Complessità spaziale: O(N).

Soluzione B: Algoritmo Quickselect
Memorizzare tutte le distanze in un array. Trovare l'indice che fornisce l'elemento Kth più piccolo usando un metodo simile al quicksort. Quindi l'elemento dall'indice 0 a (K-1) darà tutti i K punti cercati. Vediamo come funziona questo algoritmo.

Cerchiamo un algoritmo più veloce di NlogN. Chiaramente, l'unico modo per farlo è usare il fatto che i K elementi possono essere in qualsiasi ordine, altrimenti dovremmo fare l'ordinamento che è almeno NlogN.

Supponiamo di scegliere un elemento casuale x = A [i] e di dividere l'array in due parti: una parte con tutti gli elementi minori di x e una parte con tutti gli elementi maggiori o uguali a x. Questo metodo è noto come "quickselect con il pivot x".

L'idea è che selezionando alcuni pivot, ridurremo il problema a metà della dimensione originale in tempo lineare (in media).

La funzione work(i, j, K) ordina parzialmente la sottolista (punti [i], punti [i + 1], ..., punti [j]) in modo che i K elementi più piccoli di questa sottolista si trovino nelle prime posizioni K (i, i + 1, ..., i + K-1).

Innanzitutto, selezioniamo dalla sottolista un elemento casuale da usare come pivot. Per farlo, utilizziamo due puntatori i e j, per spostarsi sugli elementi che si trovano nella parte sbagliata e poi scambiamo questi elementi.

Dopo, abbiamo due parti [oi, i] e [i + 1, oj], dove (oi, oj) sono i valori originali (i, j) quando si chiama work(i, j, K). Supponiamo che la prima parte abbia 10 articoli e che la seconda contenga 15 elementi. Se stessimo cercando di ordinare parzialmente, ad esempio K = 5 elementi, allora abbiamo bisogno di ordinare parzialmente soltanto la prima parte: work(oi, i, 5). Altrimenti, se provassimo a ordinare in parte, K = 17 elementi, allora i primi 10 elementi sono già parzialmente ordinati e abbiamo solo bisogno di ordinare parzialmente i successivi 7 elementi: work(i + 1, oj, 7).

(setq pun '((1 2)(2 2)(4 5)))

(define (kClosest punti C k)
  (local (out)
    ;
    ; Funzione che scambia i valori di due punti
    (define (scambia i j)
      (swap (punti i) (punti j))
    )
    ;
    ; Funzione che calcola il quadrato della distanza
    ; tra il punto C e il punto p(i)
    (define (qdist i)
      (+ (* (sub (first (punti i)) (first C)) (sub (first (punti i)) (first C)))
         (* (sub (last (punti i)) (last C)) (sub (last (punti i)) (last C))))
    )
    ;
    ; Funzione che ordina parzialmente A[i:j+1]
    ; in modo che i primi K elementi siano i più piccoli
    (define (ordina i j k)
      (local (r mid leftH)
        (if (< i j)
            (begin
              ; calcola il pivot
              (setq r (add (rand (+ i 1 (- j))) j))
              (scambia i r)
              (setq mid (partition i j))
              (setq leftH (+ mid 1 (- i)))
              (if (< k leftH)
                  (sort i (- mid 1) k)
              ;else
                  (if (> k leftH)
                    (sort (+ mid 1) j (- k leftH))
                  )
              )
            )
        )
      ); local
    ); ordina
    ;
    ; Partizionamento con il pivot A[i]
    ; Restituisce un indice "mid" tale che:
    ; A[i] <= A[mid] <= A[j] per i < mid < j.
    (define (partition i j)
      (local (oi pivot continua)
        (setq oi i)
        (setq pivot (qdist i))
        (++ i)
        (setq continua true)
        (while continua
          (while (and (< i j) (< (qdist i) pivot))
            (++ i))
          (while (and (<= i j) (> (qdist j) pivot))
            (-- j))
          (if (>= i j)
              (setq continua nil)
              ;(scambia (punti i) (punti j))
              (scambia i j)
          )
        )
        ;(scambia (punti oi) (punti j))
        (scambia oi j)
        j
      )
    );partition
    (ordina 0 (- (length punti) 1) k)
    (slice punti 0 k)
  )
)

(kClosest '((0 0)  (5 4)  (3 1))  '(1 2) 2)
;-> ((0,0), (3,1))

(kClosest '((3 3)  (5 -1) (-2 4)) '(0 0)  2)
;-> ((3 3 ) (-2 4)

(kClosest '((1 1) (8 9) (4 5) (32 12)) '(0 0) 2)
;-> ((1 1) (4 5))

Complessità temporale: in media O(N), dove N è il numero di punti.
Complessità spaziale: O(N)


Ordinamento colori (LeetCode)
-----------------------------
Data una lista con n elementi che hanno uno dei seguenti valori: "verde", "bianco", "rosso" o "blu". Restituire un'altra lista in modo che gli stessi colori siano adiacenti e l'ordine dei colori sia "verde", "bianco", "rosso" e "blu".
Un colore può non comparire nella lista (es. lista = ("rosso" "verde" "verde" "blu")
Esempio:
Input:  lista = ("rosso" "verde" "bianco" "bianco" "verde" "rosso" "rosso")
Output: lista = ("verde" "verde" "bianco" "bianco" "rosso" "rosso" "rosso")

Per semplificare i calcoli usiamo i numeri 0, 1, 2 e 3 per rappresentare rispettivamente i colori "verde", "bianco",  "rosso" e "blu".

(define (ordinaColori lst)
  (local (val numcolors vec out )
    (setq numcolors (length (unique lst)))
    (setq vec (array numcolors '(0)))
    (setq out '())
    ; riempio il vettore con le frequenze dei numeri (colori)
    (dolist (el lst)
      ; aumentiamo di uno il valore del vettore che si trova all'indice "el"
      (++ (vec el))
    )
    ; per ogni valore del vettore "vec" (vec[i])
    ; inseriamo nella lista l'elemento "i" per vec[i] volte.
    (for (i 0 (- numcolors 1))
      (setq val (vec i))
      (for (j 1 val)
        (push i out -1)
      )
    )
    out
  );local
)

(ordinaColori '(1 2 2 1 1 2 0 0 0 2 2 1))
;-> (0 0 0 1 1 1 1 2 2 2 2 2)

(ordinaColori '(0 1 2 3 0 1 2 3 0 1 2 3))
;-> (0 0 0 1 1 1 2 2 2 3 3 3)


Unione di intervalli (Google)
-----------------------------

Dato un insieme di intervalli (inizio fine), unire tutti gli intervalli sovrapposti.
Per esempio,

intervalli di ingresso: (8 10) (2 6) (1 3) (15 18)

intervalli di uscita: (1 6) (8 10) (15 18)

     -------
        -------------
                          --------             -----------
  0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18
     ----------------     --------             -----------

(define (unisci-intervalli lst)
  (local (t out)
    (sort lst)
    (setq out '())
    (setq t (first lst))
    (dolist (el lst)
      (if (> $idx 0) ; il primo elemento non ha confronti precedenti
        (begin
          ; confronto tra l'inizio dell'intervallo corrente
          ; e la fine di quello precedente
          (if (<= (first el) (last t))
              (setf (last t) (max (last t) (last el)))
              (begin (push t out -1) (setq t el))
          )
        )
      )
    )
    ; aggiunge l'ultimo invervallo calcolato
    (push t out -1)
    out
  );local
)

(setq lst '((8 10) (2 6) (1 3) (15 18)))

(unisci-intervalli lst)
;-> ((1 6) (8 10) (15 18))

Esempio:

     -------
        -------------
                          --------             -----------
           -------------------
  0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18
     -----------------------------             -----------

(setq lst '((8 10) (1 3) (2 6) (3 9) (15 18)))

(unisci-intervalli lst)
;-> ((1 10) (15 18))


==========

 LIBRERIE

==========

===================================
 OPERAZIONI CON I NUMERI COMPLESSI
===================================

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


============================
 OPERAZIONI CON LE FRAZIONI
============================

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
      (setq d (% n temp))
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
    (setq num (+ (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
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
    (setq num (- (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
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
    (setq num (* n1 n2))
    (setq den (* d1 d2))
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
    (setq num (* n1 d2))
    (setq den (* d1 n2))
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
    (setq num (int (pow n power)))
    (setq den (int (pow d power)))
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
    (setq num (/ (numf f) (gcd (numf f) (denf f))))
    (setq den (/ (denf f)  (gcd (numf f) (denf f))))
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
  (redux (list (+ (* (numf f1) (denf f2)) (* (numf f2) (denf f1)))
               (* (denf f1) (denf f2))))
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
    (setq num (/ (numf f) (gcd (numf f) (denf f))))
    (setq den (/ (denf f)  (gcd (numf f) (denf f))))
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
  (redux (list (+ (* (numf f1) (denf f2)) (* (numf f2) (denf f1)))
               (* (denf f1) (denf f2))))
)

;Addiziona tutte le frazioni passate come argomento a due a due
(define-macro (+f)
  (apply +f-aux (map eval (args)) 2))


========================
 OPERAZIONI CON I TEMPI
========================

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

(-tt '(1 20 30) '(1 20 35) '(0 0 5))
;-> (0 0 -5)

(+tt '(0 0 -5) '(0 0 5))
;-> (0 0 0)

(-tt '(2 20 30) '(2 20 35))
;-> (0 0 -5)

(-tt '(2 20 30) '(2 20 35) '(0 0 5))
;-> (0 0 -10)


============================
 OPERAZIONI CON GLI INSIEMI
============================

newLISP fornisce alcune funzioni per operare sugli insiemi (set).
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

(powerset '(a b c d))
;-> ((a b c) (a b) (a c) (a) (b c) (b) (c) ())


=================
 FUNZIONI WINAPI
=================

(context 'Win32API)

(import "user32.dll" "MessageBoxA")
(import "kernel32.dll" "GetShortPathNameA")
(import "kernel32.dll" "GetLongPathNameA")
(import "shell32.dll" "ShellExecuteA")

(define PATH_MAX 512)

(context MAIN)

;(define NULL 0)

(define (message-box text (title "newLISP"))
  (let ((MB_OK 0))
    (Win32API:MessageBoxA 0 text title MB_OK)))

(define (get-short-path-name pathname)
  (unless (file? pathname)
    (throw-error (list "No such file or directory" pathname)))
  (setq pathname (real-path pathname)) ; to fullpath
  (letn ((len Win32API:PATH_MAX)
         (buf (dup (char 0) (+ len 1)))
         (ret (Win32API:GetShortPathNameA pathname buf len)))
    (slice buf 0 ret)
    ;; (GetShortPathNameA pathname buf len) (get-string buf)
    ))

(define (get-longpathname pathname)
  (letn ((len Win32API:PATH_MAX)
         (buffer (dup (char 0) (+ len 1)))
         (r (Win32API:GetLongPathNameA pathname buffer len)))
    (if (= r 0) (throw-error '("GetLongPathNameA" "failure")))
    (slice buffer 0 r)))

(define (shell-execute app)
  (let ((SW_SHOWNORMAL 1) e)
    (setf e (Win32API:ShellExecuteA 0 "open" app 0 0 SW_SHOWNORMAL))
    ;(if (< e 32) )
    ))
;(shell-execute "C:\\PROGRA~1\\newLISP\\newLISP.exe")
;(shell-execute "C:/")
(shell-execute "http://www.newLISP.org/")

(context MAIN)
;;; EOF


===========

 APPENDICI 
 
===========

============================================================================
 Lista delle funzioni newLISP
============================================================================

List processing, flow control, and integer arithmetic
=====================================================
+, -, *, /, %     integer arithmetic
++                increment integer numbers
--                decrement integer numbers
<, >, =           compares any data type: less, greater, equal
<=, >=, !=        compares any data type: less-equal, greater-equal, not-equal
:                 constructs a context symbol and applies it to an object
and               logical and
append            appends lists ,arrays or strings to form a new list, array or string
apply             applies a function or primitive to a list of arguments
args              retrieves the argument list of a function or macro expression
assoc             searches for keyword associations in a list
begin             begins a block of functions
bigint            convert a number to big integer format
bind              binds variable associations in a list
case              branches depending on contents of control variable
catch             evaluates an expression, possibly catching errors
chop              chops elements from the end of a list
clean             cleans elements from a list
collect           repeat evaluating an expression and collect results in a list
cond              branches conditionally to expressions
cons              prepends an element to a list, making a new list
constant          defines a constant symbol
count             counts elements of one list that occur in another list
curry             transforms a function f(x, y) into a function fx(y)
define            defines a new function or lambda expression
define-macro      defines a macro or lambda-macro expression
def-new           copies a symbol to a different context (namespace)
difference        returns the difference between two lists
doargs            iterates through the arguments of a function
dolist            evaluates once for each element in a list
dostring          evaluates once for each character in a string
dotimes           evaluates once for each number in a range
dotree            iterates through the symbols of a context
do-until          repeats evaluation of an expression until the condition is met
do-while          repeats evaluation of an expression while the condition is true
dup               duplicates a list or string a specified number of times
ends-with         checks the end of a string or list against a key of the same type
eval              evaluates an expression
exists            checks for the existence of a condition in a list
expand            replaces a symbol in a nested list
explode           explodes a list or string
extend            extends a list or string
first             gets the first element of a list or string
filter            filters a list
find              searches for an element in a list or string
flat              returns the flattened list
fn                defines a new function or lambda expression
for               evaluates once for each number in a range
for-all           checks if all elements in a list meet a condition
if                evaluates an expression conditionally
index             filters elements from a list and returns their indices
intersect         returns the intersection of two lists
lambda            defines a new function or lambda expression
last              returns the last element of a list or string
length            calculates the length of a list or string
let               declares and initializes local variables
letex             expands local variables into an expression, then evaluates
letn              initializes local variables incrementally, like nested lets
list              makes a list
local             declares local variables
lookup            looks up members in an association list
map               maps a function over members of a list, collecting the results
match             matches patterns against lists; for matching against strings, see find and regex
member            finds a member of a list or string
not               logical not
nth               gets the nth element of a list or string
or                logical or
pop               deletes and returns an element from a list or string
pop-assoc         removes an association from an association list
push              inserts a new element into a list or string
quote             quotes an expression
ref               returns the position of an element inside a nested list
ref-all           returns a list of index vectors of elements inside a nested list
rest              returns all but the first element of a list or string
replace           replaces elements inside a list or string
reverse           reverses a list or string
rotate            rotates a list or string
select            selects and permutes elements from a list or string
self              Accesses the target object inside a FOOP method
set               sets the binding or contents of a symbol
setf setq         sets contents of a symbol or list, array or string reference
set-ref           searches for an element in a nested list and replaces it
set-ref-all       searches for an element in a nested list and replaces all instances
silent            works like begin but suppresses console output of the return value
slice             extracts a sublist or substring
sort              sorts the members of a list
starts-with       checks the beginning of a string or list against a key of the same type
swap              swaps two elements inside a list or string
unify             unifies two expressions
unique            returns a list without duplicates
union             returns a unique list of elements found in two or more lists.
unless            evaluates an expression conditionally
until             repeats evaluation of an expression until the condition is met
when              evaluates a block of statements conditionally
while             repeats evaluation of an expression while the condition is true

String and conversion functions
===============================
address           gets the memory address of a number or string
bigint            convert a number to big integer format
bits              translates a number into binary representation
char              translates between characters and ASCII codes
chop              chops off characters from the end of a string
dostring          evaluates once for each character in a string
dup               duplicates a list or string a specified number of times
ends-with         checks the end of a string or list against a key of the same type
encrypt           does a one-time–pad encryption and decryption of a string
eval-string       compiles, then evaluates a string
explode           transforms a string into a list of characters
extend            extends a list or string
find              searches for an element in a list or string
find-all          returns a list of all pattern matches found in string
first             gets the first element in a list or string
float             translates a string or integer into a floating point number
format            formats numbers and strings as in the C language
get-char          gets a character from a memory address
get-float         gets a double float from a memory address
get-int           gets a 32-bit integer from a memory address
get-long          gets a long 64-bit integer from a memory address
get-string        gets a string from a memory address
int               translates a string or float into an integer
join              joins a list of strings
last              returns the last element of a list or string
lower-case        converts a string to lowercase characters
member            finds a list or string member
name              returns the name of a symbol or its context as a string
nth               gets the nth element in a list or string
pack              packs newLISP expressions into a binary structure
parse             breaks a string into tokens
pop               pops from a string
push              pushes onto a string
regex             performs a Perl-compatible regular expression search
regex-comp        pre-compiles a regular expression pattern
replace           replaces elements in a list or string
rest              gets all but the first element of a list or string
reverse           reverses a list or string
rotate            rotates a list or string
select            selects and permutes elements from a list or string
setf setq         sets contents of a string reference
slice             extracts a substring or sublist
source            returns the source required to bind a symbol as a string
starts-with       checks the start of the string or list against a key string or list
string            transforms anything into a string
sym               translates a string into a symbol
title-case        converts the first character of a string to uppercase
trim              trims a string on one or both sides
unicode           converts ASCII or UTF-8 to UCS-4 Unicode
utf8              converts UCS-4 Unicode to UTF-8
utf8len           returns length of an UTF-8 string in UTF-8 characters
unpack            unpacks a binary structure into newLISP expressions
upper-case        converts a string to uppercase characters

Floating point math and special functions
=========================================
abs               returns the absolute value of a number
acos              calculates the arc-cosine of a number
acosh             calculates the inverse hyperbolic cosine of a number
add               adds floating point or integer numbers and returns a floating point number
array             creates an array
array-list        returns a list conversion from an array
asin              calculates the arcsine of a number
asinh             calculates the inverse hyperbolic sine of a number
atan              calculates the arctangent of a number
atanh             calculates the inverse hyperbolic tangent of a number
atan2             computes the principal value of the arctangent of Y / X in radians
beta              calculates the beta function
betai             calculates the incomplete beta function
binomial          calculates the binomial function
ceil              rounds up to the next integer
cos               calculates the cosine of a number
cosh              calculates the hyperbolic cosine of a number
crc32             calculates a 32-bit CRC for a data buffer
dec               decrements a number in a variable, list or array
div               divides floating point or integer numbers
erf               calculates the error function of a number
exp               calculates the exponential e of a number
factor            factors a number into primes
fft               performs a fast Fourier transform (FFT)
floor             rounds down to the next integer
flt               converts a number to a 32-bit integer representing a float
gammai            calculates the incomplete Gamma function
gammaln           calculates the log Gamma function
gcd               calculates the greatest common divisor of a group of integers
ifft              performs an inverse fast Fourier transform (IFFT)
inc               increments a number in a variable, list or array
inf?              checks if a floating point value is infinite
log               calculates the natural or other logarithm of a number
min               finds the smallest value in a series of values
max               finds the largest value in a series of values
mod               calculates the modulo of two numbers
mul               multiplies floating point or integer numbers
NaN?              checks if a float is NaN (not a number)
round             rounds a number
pow               calculates x to the power of y
sequence          generates a list sequence of numbers
series            creates a geometric sequence of numbers
sgn               calculates the signum function of a number
sin               calculates the sine of a number
sinh              calculates the hyperbolic sine of a number
sqrt              calculates the square root of a number
ssq               calculates the sum of squares of a vector
sub               subtracts floating point or integer numbers
tan               calculates the tangent of a number
tanh              calculates the hyperbolic tangent of a number
uuid              returns a UUID (Universal Unique IDentifier)

Matrix functions
================
det               returns the determinant of a matrix
invert            returns the inversion of a matrix
mat               performs scalar operations on matrices
multiply          multiplies two matrices
transpose         returns the transposition of a matrix

Array functions
===============
append            appends arrays
array             creates and initializes an array with up to 16 dimensions
array-list        converts an array into a list
array?            checks if expression is an array
det               returns the determinant of a matrix
first             returns the first row of an array
invert            returns the inversion of a matrix
last              returns the last row of an array
mat               performs scalar operations on matrices
multiply          multiplies two matrices
nth               returns an element of an array
rest              returns all but the first row of an array
setf              sets contents of an array reference
slice             returns a slice of an array
transpose         transposes a matrix

Bit operators
=============
<<, >>            bit shift left, bit shift right
&                 bitwise and
|                 bitwise inclusive or
^                 bitwise exclusive or
~                 bitwise not

Predicates
==========
atom?             checks if an expression is an atom
array?            checks if an expression is an array
bigint?           checks if a number is a big integer
context?          checks if an expression is a context
directory?        checks if a disk node is a directory
empty?            checks if a list or string is empty
even?             checks the parity of an integer number
file?             checks if a file exists
float?            checks if an expression is a float
global?           checks if a symbol is global
inf?              checks if a floating point value is infinite
integer?          checks if an expression is an integer
lambda?           checks if an expression is a lambda expression
legal?            checks if a string contains a legal symbol
list?             checks if an expression is a list
macro?            checks if an expression is a lambda-macro expression
NaN?              checks if a float is NaN (not a number)
nil?              checks if an expression is nil
null?             checks if an expression is nil, "", (), 0 or 0.0
number?           checks if an expression is a float or an integer
odd?              checks the parity of an integer number
protected?        checks if a symbol is protected
primitive?        checks if an expression is a primitive
quote?            checks if an expression is quoted
string?           checks if an expression is a string
symbol?           checks if an expression is a symbol
true?             checks if an expression is not nil
zero?             checks if an expression is 0 or 0.0

Date and time functions
=======================
date              converts a date-time value to a string
date-list         returns a list of year, month, day, hours, minutes, seconds from a time value in seconds
date-parse        parses a date string and returns the number of seconds passed since January 1, 1970, (formerly parse-date)
date-value        calculates the time in seconds since January 1, 1970 for a date and time
now               returns a list of current date-time information
time              calculates the time it takes to evaluate an expression in milliseconds
time-of-day       calculates the number of milliseconds elapsed since the day started

Statistics, simulation and modeling functions
=============================================
amb               randomly selects an argument and evaluates it
bayes-query       calculates Bayesian probabilities for a data set
bayes-train       counts items in lists for Bayesian or frequency analysis
corr              calculates the product-moment correlation coefficient
crit-chi2         calculates the Chi² statistic for a given probability
crit-f            calculates the F statistic for a given probability
crit-t            calculates the Student's t statistic for a given probability
crit-z            calculates the normal distributed Z for a given probability
kmeans-query      calculates distances to cluster centroids or other data points
kmeans-train      partitions a data set into clusters
normal            makes a list of normal distributed floating point numbers
prob-chi2         calculates the tail probability of a Chi² distribution value
prob-f            calculates the tail probability of a F distribution value
prob-t            calculates the tail probability of a Student's t distribution value
prob-z            calculates the cumulated probability of a Z distribution value
rand              generates random numbers in a range
random            generates a list of evenly distributed floats
randomize         shuffles all of the elements in a list
seed              seeds the internal random number generator
stats             calculates some basic statistics for a data vector
t-test            compares means of data samples using the Student's t statistic

Pattern matching
================
ends-with         tests if a list or string ends with a pattern
find              searches for a pattern in a list or string
find-all          finds all occurrences of a pattern in a string
match             matches list patterns
parse             breaks a string along around patterns
ref               returns the position of an element inside a nested list
ref-all           returns a list of index vectors of elements inside a nested list
regex             finds patterns in a string
replace           replaces patterns in a string
search            searches for a pattern in a file
starts-with       tests if a list or string starts with a pattern
unify             performs a logical unification of patterns

Financial math functions
========================
fv                returns the future value of an investment
irr               calculates the internal rate of return
nper              calculates the number of periods for an investment
npv               calculates the net present value of an investment
pv                calculates the present value of an investment
pmt               calculates the payment for a loan

Input/output and file operations
================================
append-file       appends data to a file
close             closes a file
current-line      retrieves contents of last read-line buffer
device            sets or inquires about current print device
exec              launches another program, then reads from or writes to it
load              loads and evaluates a file of newLISP code
open              opens a file for reading or writing
peek              checks file descriptor for number of bytes ready for reading
print             prints to the console or a device
println           prints to the console or a device with a line-feed
read              reads binary data from a file
read-char         reads an 8-bit character from a file
read-file         reads a whole file in one operation
read-key          reads a keyboard key
read-line         reads a line from the console or file
read-utf8         reads UTF-8 character from a file
save              saves a workspace, context, or symbol to a file
search            searches a file for a string
seek              sets or reads a file position
write             writes binary data to a file
write-char        writes a character to a file
write-file        writes a file in one operation
write-line        writes a line to the console or a file

Processes and the Cilk API
==========================
!                 shells out to the operating system
abort             aborts a child process started with spawn
destroy           destroys a process created with fork or process
exec              runs a process, then reads from or writes to it
fork              launches a newLISP child process
pipe              creates a pipe for interprocess communication
process           launches a child process, remapping standard I/O and standard error
receive           receive a message from another process
semaphore         creates and controls semaphores
send              send a message to another process
share             shares memory with other processes
spawn             launches a child process for Cilk process management
sync              waits for child processes launched with spawn and collects results
wait-pid          waits for a child process to end

File and directory management
=============================
change-dir        changes to a different drive and directory
copy-file         copies a file
delete-file       deletes a file
directory         returns a list of directory entries
file-info         gets file size, date, time, and attributes
make-dir          makes a new directory
real-path         returns the full path of the relative file path
remove-dir        removes an empty directory
rename-file       renames a file or directory

HTTP networking API
===================
base64-enc        encodes a string into BASE64 format
base64-dec        decodes a string from BASE64 format
delete-url        deletes a file or page from the web
get-url           reads a file or page from the web
json-error        returns error information from a failed JSON translation.
json-parse        parses JSON formatted data
post-url          posts info to a URL address
put-url           uploads a page to a URL address
xfer-event        registers an event handler for HTTP byte transfers
xml-error         returns last XML parse error
xml-parse         parses an XML document
xml-type-tags     shows or modifies XML type tags

Socket TCP/IP, UDP and ICMP network API
=======================================
net-accept        accepts a new incoming connection
net-close         closes a socket connection
net-connect       connects to a remote host
net-error         returns the last error
net-eval          evaluates expressions on multiple remote newLISP servers
net-interface     Sets the default interface IP address on multihomed computers.
net-ipv           Switches between IPv4 and IPv6 internet protocol versions.
net-listen        listens for connections to a local socket
net-local         returns the local IP and port number for a connection
net-lookup        returns the name for an IP number
net-packet        send a custom configured IP packet over raw sockets
net-peek          returns the number of characters ready to be read from a network socket
net-peer          returns the remote IP and port for a net connect
net-ping          sends a ping packet (ICMP echo request) to one or more addresses
net-receive       reads data on a socket connection
net-receive-from  reads a UDP on an open connection
net-receive-udp   reads a UDP and closes the connection
net-select        checks a socket or list of sockets for status
net-send          sends data on a socket connection
net-send-to       sends a UDP on an open connection
net-send-udp      sends a UDP and closes the connection
net-service       translates a service name into a port number
net-sessions      returns a list of currently open connections

API for newLISP in a web browser
================================
display-html      display an HTML page in a web browser
eval-string-js    evaluate JavaScript in the current web browser page

Reflection and customization
============================
command-event     pre-processes the command-line and HTTP requests
error-event       defines an error handler
history           returns the call history of a function
last-error        report the last error number and text
macro             create a reader expansion macro
ostype            contains a string describing the OS platform
prefix            Returns the context prefix of a symbol
prompt-event      customizes the interactive newLISP shell prompt
read-expr         reads and translates s-expressions from source
reader-event      preprocess expressions before evaluation event-driven
set-locale        switches to a different locale
source            returns the source required to bind a symbol to a string
sys-error         reports OS system error numbers
sys-info          gives information about system resources
term              returns the term part of a symbol or its context as a string

System functions
================
$                 accesses system variables $0 -> $15
callback          registers a callback function for an imported library
catch             evaluates an expression, catching errors and early returns
context           creates or switches to a different namespace
copy              copies the result of an evaluation
debug             debugs a user-defined function
delete            deletes symbols from the symbol table
default           returns the contents of a default functor from a context
env               gets or sets the operating system's environment
exit              exits newLISP, setting the exit value
global            makes a symbol accessible outside MAIN
import            imports a function from a shared library
main-args         gets command-line arguments
new               creates a copy of a context
pretty-print      changes the pretty-printing characteristics
read-expr         translates a string to an s-expression without evaluating it
reset             goes to the top level
signal            sets a signal handler
sleep             suspends processing for specified milliseconds
sym               creates a symbol from a string
symbols           returns a list of all symbols in the system
throw             causes a previous catch to return
throw-error       throws a user-defined error
timer             starts a one-shot timer, firing an event
trace             sets or inquires about trace mode
trace-highlight   sets highlighting strings in trace mode

Importing libraries
===================
address           returns the memory address of a number or string
callback          registers a callback function for an imported library
flt               converts a number to a 32-bit integer representing a float
float             translates a string or integer into a floating point number
get-char          gets a character from a memory address
get-float         gets a double float from a memory address
get-int           gets a 32-bit integer from a memory address
get-long          gets a long 64-bit integer from a memory address
get-string        gets a string from a memory address
import            imports a function from a shared library
int               translates a string or float into an integer
pack              packs newLISP expressions into a binary structure
struct            Defines a data structure with C types
unpack            unpacks a binary structure into newLISP expressions

newLISP internals API
=====================
command-event     pre-processes the command-line and HTTP requests
cpymem            copies memory between addresses
dump              shows memory address and contents of newLISP cells
prompt-event      customizes the interactive newLISP shell prompt
read-expr         reads and translates s-expressions from source
reader-event      preprocess expressions before evaluation event-driven


============================================================================
F-expression - FEXPR
============================================================================

Nei linguaggi di programmazione Lisp, una FEXPR è una funzione i cui operandi/parametri vengono passati ad essa senza essere valutati. Quando viene chiamato una FEXPR, viene valutato solo il corpo di FEXPR: non si effettuano altre valutazioni se non quando esplicitamente avviato/richiesto dalla FEXPR.

Al contrario, quando viene chiamata una normale funzione Lisp, gli operandi vengono valutati automaticamente e solo i risultati di queste valutazioni vengono passati alla funzione.

Quando viene chiamata una macro Lisp (tradizionale), gli operandi vengono passati in modo non valutato, ma qualunque sia il risultato ritornato dalla macro, questo viene valutato automaticamente.

Nel rigoroso utilizzo originale, una FEXPR è quindi una funzione definita dall'utente i cui operandi vengono passati senza essere valutati. Tuttavia, nell'uso successivo, il termine FEXPR descrive qualsiasi funzione di prima classe/ordine i cui operandi vengono passati non valutati, indipendentemente dal fatto che la funzione sia primitiva o definita dall'utente.
Le macro di newLISP sono FEXPR.

Kent M. Pitman, "Special Forms in Lisp", Proceedings of the 1980 ACM Conference on Lisp and Functional Programming, 1980, pag. 179–187.


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
Con newLISP installato sul tuo sistema, al prompt della riga di comando della shell (cmd in windows) inserisci newLISP per avviare la REPL (Read, Eval, Print, Loop).
Su Linux, la console sarebbe simile a questa:

$ newLISP
> _

E su piattaforme Windows, sarebbe simile a questa.

c:\> newLISP
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

A questo punto potresti essere intimorito dalle parentesi. Se iniziate newLISP conoscendo un normale linguaggio informatico, sembrerebbe più naturale scrivere una chiamata di funzione nel modo seguente:

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

$ newLISP hw.lsp
Ciao mondo!

O in Windows:

c: \> newLISP hw.lsp
Ciao mondo!

Eseguibili e librerie dinamiche (dll)
-------------------------------------
Creare eseguibili nativi della piattaforma (exe in windows) e collegarsi alle librerie di collegamenti dinamici (dll in windows e so in linux) con newLISP è semplice.
Nelle vecchie versioni, dovresti trovare il file link.lsp nella sottodirectory degli esempi oppure dovresti scaricare gli esempi e i moduli separatamente da www.newLISP.org.
Con la versione 10.4.7 il processo di collegamento dei file sorgente LISP con un nuovo eseguibile LISP è cambiato e il file link.lsp non è più necessario.
Il processo è ora disponibile utilizzando l'opzione della riga di comando -x.
Consideriamo il seguente programma:

;; uppercase.lsp - Link example
(println (upper-case (main-args 1)))
(exit)

Il programma uppercase.lsp prende il primo argomento e lo converte in maiuscolo:
Le operazioni per creare un file eseguibilie sono le seguenti:

# in OSX, Linux e altri UNIX
newLISP -x "uppercase.lsp" "uppercase"

# impostiamo i permessi di esecuzione
chmod 755 uppercase

# in Windows il file eseguibile deve avere estensione .exe
newLISP -x "uppercase.lsp" "uppercase.exe"

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
L’utente può definire nuove funzioni (come discusso in precedenza). La seguente funzione f restituisce la somma dei suoi due argomenti:

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

Quindi, quando newLISP si appresta a interpretare:

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
newLISP utilizza alberi binari red-black per l'accesso alla memoria associativa quando si gestiscono spazi dei nomi (namespace), dizionari e per l'accesso ai valori-chiave simili alla tecnica hash.

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

Download: https://github.com/cameyo42/notepadpp-newLISP

Add newLISP syntax highlighting
-------------------------------
Copy all the text of the file: newLISP-udl.xml
and paste it inside the section:<NotepadPlus> ... </NotepadPlus>
of the file: userDefineLang.xml (located at: c:\Users\<username>\AppData\Roaming\Notepad++\)
CODE: SELECT ALL
Example
<NotepadPlus>
    <UserLang name="newLISP" ext="lsp" udlVersion="2.1">
    ...
    </UserLang>
</NotepadPlus>

The newLISP keywords are from primes.h (newLISP source).
The actual highlight colors are for "obsidiane" theme of notepad++.
You can change (easily) the colors as you like.

Open newLISP help from notepad++
--------------------------------

Add the line:

<Command name="newLISP Help" Ctrl="yes" Alt="yes" Shift="no" Key="112">chrome file:///C:/Program%20Files%20(x86)/newLISP/newLISP_manual.html#$(CURRENT_WORD)</Command>

inside the section: <UserDefinedCommands> ... </UserDefinedCommands>
of the file: shortcut.xml (located at: c:\Users\<username>\AppData\Roaming\Notepad++\)

Example:
<UserDefinedCommands>
    <Command name="newLISP Help" Ctrl="yes" Alt="yes" Shift="no" Key="112">chrome file:///C:/Program%20Files%20(x86)/newLISP/newLISP_manual.html#$(CURRENT_WORD)</Command>

</UserDefinedCommands>

Note: change the path to point to your newLISP help file

Now you can select a word and press Ctrl+Alt+F1 to open newLISP help file.

The shortcut is Ctrl + Alt + F1, but you can change it.

Execute newLISP code from notepad++
-----------------------------------

Download and install autohotkey (http://www.autohotkey.com).

Run the script "npp-newLISP.ahk" (double click it).

Run notepad++

Press Win+F12 to start newLISP REPL (la cartella di default di newLISP è quella dove si trova  lo script "npp-newLISP.ahk")

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
The script npp-newLISP.ahk exchange the brackets () and [] in the keyboard.
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

Scaricare i sorgenti di newLISP (newLISP-10.7.5.tgz) da:

http://www.newLISP.org/downloads/development/inprogress/

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

Sostituire la riga:   $(CC) -m64 -shared *.o -Wl,--kill-at -lffi -lws2_32 -o newLISP.dll
Con la riga:          $(CC) -m64 -shared $(OBJS) -Wl,--kill-at -lffi -lws2_32 -o newLISP.dll

Salvare e chiudere il makefile.

Aprire una finestra DOS (command prompt - cmd.exe) e dalla cartella dei sorgenti digitare:

make -f makefile_mingw64_utf8_ffi

Se tutto va bene, dopo alcuni secondi avrete il vostro file "newLISP.exe" insieme a diversi altri file che  hanno estensione ".o".

Prima di creare la dll di newLISP dobbiamo eliminare tutti i file ".o" che sono stati creati.

Una volta eliminati i file ".o" digitare:

make -f "makefile_mingw64dll_utf8_ffi"

Questa volta avrete il vostro file "newLISP.dll" insieme a diversi altri file che  hanno estensione ".o".

Cancellate i file ".o" e copiate "newLISP.exe" e "newLISP.dll" nella cartella che preferite (la cartella deve trovarsi nella variabile di ambiente PATH).

Complimenti, avete creato la vostra versione di newLISP !!!

Nota: nelle versioni ffi di newLISP occorre copiare la libreria "libffi-6.dll" nella cartella dove si trova newLISP.exe e newLISP.dll

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

https://weblambdazero.blogspot.com/2010/06/newLISP-lisp-for-masses.html

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

https://weblambdazero.blogspot.com/2010/07/advanced-recursion-in-newLISP.html

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

http://www.newLISP.org/index.cgi?page=Links

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

;; self incrementer
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

  (define fact (lambda (n) (if (< n 2) 1 (* n (fact (- n 1))))))

L'originale fattoriale ridefinito come funzione anonima e prendendo il vero fattoriale in h:

  (lambda (h) (lambda (n) (if (< n 2) 1 (* n (h (- n 1))))))

Se questa funzione è chiamata F e il fattoriale vero è f allora ((F f) n) = (F n), f è un punto fisso di F.

Stiamo cercando una funzione Y con la proprietà: ((F (Y F)) x) = ((Y F) x)

Questa funzione è chiamata "Applicative-order Y fixed point operator" per i funzionali. Per ottenere ciò, trasformiamo la forma base della funzione fattoriale:

Il fattoriale base con il vero fattoriale:

  (lambda (n) (if (< n 2) 1 (* n (h (- n 1)))))

Passiamo la funzione fattoriale come parametro:

  (lambda (h n) (if (< n 2) 1 (* n (h h (- n 1)))))

Impacchettiamo come espressione anonima e proviamo:

  (let ((g (lambda (h n)
           (if (< n 2) 1 (* n (h h (- n 1)))))))
    (g g 10)); => 3628800

Fino a questo punto le espressioni sono identiche a quelle trovate in "The Why of Y" di Richard P. Gabriel. Il resto delle trasformazioni segue Gabriel, ma inserisce la funzione newLISP "expand" dove richiesto per ottenere un effetto di chiusura per la funzione passata come parametro nell'espressione (lambda (h) ...).

Curry (g g 10) a ((g g) 10):

  (let ((g (lambda (h)
          (espandi (lambda (n) (if (< n 2) 1 (* n ((h h) (- n 1))))) 'h))))
      ((g g) 10))

Estraiamo (h h) come f:

  (let ((g (lambda (h)
            (espandi (lambda (n)
              (let ((f (lambda (f n)
                      (if (< n 2) 1 (* n (f (- n 1)))))))
              (f (h h) n))) 'h))))
           ((g g) 10))

Curry la definizione di f per f interna a (lambda (f n) ...):

  (let ((g (lambda (h)
           (espandi (lambda (n)
            (let ((f (lambda (q)
                   (espandi (lambda (n)
                     (se (< n 2) 1 (* n (q (- n 1))))) 'q)))); in Schema
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
Valutazione delle espressioni, Indicizzazione Implicita, Contesti e Funtori di Default
di Lutz Mueller, 2007-2013.
============================================================================

L'indicizzazione esplicita e i funtori di default sono una estensione delle normali regole di valutazione delle espressioni in LISP. I contesti forniscono spazi di nomi lessicamente chiusi (con stato) in un linguaggio di programmazione con ambito (scope) dinamico.

Valutazione delle S-espressioni e indicizzazione implicita
----------------------------------------------------------
In un altro articolo viene spiegato come la valutazione delle S-espressioni si interfaccia con il metodo di gestione automatica della memoria ORO (One Reference Only) [1]. Il seguente pseudo-code della funzione di valutazione di newLISP mostra come l'indicizzazione implicita sia un'estensione delle regole di valutazione delle S-espressioni in LISP:

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

Il funzionamento generale della funzione riflette la struttura generale della funzione eval descritta da John McCarthy nel 1960, [2].

La funzione first elabora le espressione atomiche. Le costanti valutano su se stesse e vengono restituite. I simboli valutano al loro contenuto.

Se l'espressione è una lista, il primo elemento (first) viene applicato al resto della lista (rest). Come in Scheme, newLISP valuta il primo elemento prima di applicarlo ai suoi argomenti.

Lisp o Scheme tradizionali consentono solo una funzioni built-in, un operatore o una funzione lambda definita dall'utente come prima posizione (funtore) nella lista S-espression da valutare. In newLISP un simbolo del contesto, una lista, un vettore e un numero possono agire come funzioni se si trovano nella posizione del funtore (prima posizione).

Le funzioni built-in vengono valutate chiamando evaluateFunc(func, args), i funtori, che sono espressioni lambda, chiamano la funzione evaluateLambda(func, args). Entrambe le funzioni a loro volta chiameranno evaluateExpression(expr) di nuovo per la valutazione degli argomenti della funzione.

Il funzionamento di un simbolo di contesto nella posizione del functor di una 'S-espressione sarà spiegato più in basso nel capitolo sugli spazi di nomi (namespace) e i funtori predefiniti.

Il tipo lista fa sì che newLISP valuti l'intera S-espressione come l'elemento indicizzato dal numero/i che segue l'elenco e interpretato come indice o indici (in newLISP gli elementi nidificati possono essere indicizzati usando indici multipli).

(set 'lst '(a b (c d e) f g))
(lst 2)  → (c d e)
(lst 2 1)  → d

(set 'str "abcdefg")
(str 2)  → "c"

Un numero nella posizione del funtore assumerà funzionalità di slicing e applicherà la funzione slice alla lista seguente utilizzando come offset quel numero. Quando abbiamo due numeri, allora il secondo specifica la lunghezza dello slice della lista:

(1 lst)  → (b (c d e) f g)
(1 2 lst)  → (b (c d e))

(1 2 str)  → "bc"

A prima vista sembra logico estendere questo fuznionamento anche ai dati di tipo booleano. Un espressione condizionale ternaria potrebbe essere realizzata sernza utilizzare l'operatore if, ma in pratica questo porta a difficoltà nella lettura del codicee causa troppe ambiguità nei messaggi di errore. Nella maggior parte dei casi, l'indicizzazione implicita genera un codice più leggibile, poichè l'oggetto dati viene raggruppato insieme ai suoi indici. L'indicizzazione implicita è molto veloce, ma è opzionale. Le parole chiave "nth", "first", "last", "rest" e "slice" possono essere usate in quei pochi casi in cui la leggibilità è migliore con l'utilizzo di forme esplicite di indicizzazione.

Lo stack dell'ambiente e l'ambito dinamico (dynamic scoping)
------------------------------------------------------------
Nella funzione eval del Lisp originale, un variabile  d'ambiente viene implementata come una lista di associazioni di simboli e i loro valori. In newLISP un simbolo viene implementato come una struttura dati con uno slot per il valore e la variabile d'ambiente non è una lista di asssocizioni, ma un albero binario per i simboli e uno stack fi ambiente che memorizza i valori precedenti dei simboli nei livelli di valutazione più alti.

Quando incontriamo una funzione lambda, i parametri dei simboli e i loro valori correnti sono inseriti sullo stack d'ambiente. Qando lasciamo la funzione, i parametri dei simboli sono ripristinati ai valori precedenti, cioè ai valori che avevano immediatamente prima di entrare nello stack. Qualuqnque chiamata ad un'altra funzione vedrà il valore del simbolo così come definito nell'ambito della funzione chiamante. Le variabili d'ambiente cambiano dinamicamente durante le chiamate e il ritorno delle funzioni. L'ambito dei una variabile viene esteso dinamicamente nei livelli inferiori di chiamate.

Il seguente esempio imposta due mvariabili e definisce due funzioni lambda. Dopo la loro definizione, le funzioni vengono utilizzate in modo nidificato. La parte delle variabili d'ambiente che si modifica viene evidenziata con una freccia (==>):

; x  → nil, y  → nil;
; foo  → nil
; double  → nil
; environment stack: [ ]

(define (foo x y)
  (+ (double (+ x 1)) y))

; x → nil, y  → nil,
==> ; foo  → (lambda (x y) (+ (double (+ x 1)) y))
; double  → nil
; environment stack: [ ]

(define (double x)
  (* 2 x))

; x  → nil, y  → nil
; foo  → (lambda (x y) (+ (double (+ x 1)) y))
==> ; double  → (lambda (x) (* 2 x)))
; environment stack: [ ]

(set 'x 10) (set 'y 20)

==> ; x  → 10, y  → 20
; foo  → (lambda (x y) (+ (double (+ x 1)) y))
; double  → (lambda (x) (* 2 x)))
; environment stack: [ ]

In maniera simile a Scheme, newLISP utilizza lo stesso spazio di nomi (namespace) per memorizzare i simboli delle variabili e i simboli delle funzioni lambda definite dall'utente. La funzione "define" è solo un trucco per scrivere:

(set 'foo (lambda (x y) (+ (double (+ x 1)) y)))

Durante tutte queste operazioni lo stack d'ambiente rimane vuoto [ ]. I simboli che rappresentano espressioni lambda fanno parte dello stesso spazio di nomi dei simboli che contengono dati e vengono trattati allo stesso modo. Adesso la prima funzione "foo" viene chiamata:

(foo 2 4)

; after entering the function foo
==> ; x → 2, y → 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
==> ; environment stack: [x -> 10, y -> 20]

Dopo essere entrati nella funzione, i vecchi valori di x e y vengono inseriti nello stack d'ambiente. Questa operazione di push è iniziata dalla funzione evaluateLambda(func, args), che verrà discussa in seguito in questo articolo. Internamente a "foo" viene chiamata la funzone "double":

(double 3)
; after entering the function double
==> ; x -> 3, y -> 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
==> ; environment stack: [x -> 10, y -> 20, x -> 2]

; after return from double
==> ; x → 2, y → 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
==> ; environment stack: [x -> 10, y -> 20]

; after return from foo
==> ; x → 10, y → 20
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
==> ; environment stack: [ ]

Si noti che in newLISP l'ambito (scope) dinamico dei simboli dei parametri nelle espressioni lambda non crea chiusure di stato lessicale attorno a quei simboli come nel linguaggio Scheme (dialetto del Lisp). Al ritorno dalla funzione lambda il contenuto del simbolo viene distrutto e la memoria viene recuperata. I simboli dei parametri recuperano i loro vecchi valori all'uscita dalla funzione lambda prendendoli dallo stack d'ambiente.

In newLISP le chiusure lessicali con stato (lexical state-full closures) non vengono con le chiusure lambda, ma utilizzando spazi di nomi lessicali. Le funzioni lambda in newLISP non creano chiusure ma possono creare un nuovo ambito e un nuovo contenuto temporaneo per i simboli esistenti durante l'esecuzione della funzione lambda.

Valutazione delle funzioni lambda
---------------------------------
Tutti i processi appena descritti avvengono nella funzione evaluateLambda(func, args). Il seguente pseudo-codice mostra alcuni dettagli:

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

Le funzioni evaluateExpression(args) e evaluateLambda(func, args) si chiamano in modo reciproco in un ciclo  ricorsivo.

Si noti che gli argomenti delle funzioni lambda vengono valutati nell'ambiente delle variabili come definito precedentemente alla chiamata della funzione lambda. Le assegnazioni ai simboli dei parametri avvengono dopo tutte le valutazioni degli argomenti. Vengono valutati solo gli argomenti che hanno un simbolo di parametro corrispondente. Se sono presenti più simboli di parametro rispetto agli argomenti passati, i simboli dei parametri vengono assegnati a nil o a un valore predefinito.

Spazi di nomi (namespace) e il ciclo di traduzione e valutazione
----------------------------------------------------------------
Tutti gli oggetti dati di memoria in newLISP sono collegati direttamente o indirettamente a un simbolo. Gli oggetti di memoria sono referenziati direttamente da un simbolo o fanno parte di una S-espressione che li racchiude a cui fa riferimento un simbolo. Gli oggetti non legati (unbound) esistono solo come oggetti transitori come valori restituiti dalle valutazioni e sono referenziati sullo stack dei risultati per una eliminazione successiva [1].

Tranne che per i simboli, tutti i dati e gli oggetti del programma sono referenziati una sola volta. I simboli sono creati e organizzati in una struttura ad albero binario. Gli spazi di nomi (namespace), chiamati "context" in newLISP, sono sotto-rami in questo albero binario. Un contesto è associato a un simbolo nel contesto principale MAIN, che a sua volta è un simbolo nel contesto radice.

Con poche eccezioni, tutti i simboli vengono creati durante il caricamento del codice e la fase di traduzione dell'interprete newLISP. Solo le funzioni load, sym, eval-string e una speciale sintassi dei context creano simboli durante l'esecuzione del runtime.

I due simboli MAIN: x e CTX: x sono due simboli diversi in ogni momento. Un simbolo in nessun caso può cambiare il contesto dopo che è stato creato. Un contesto, ad esempio CTX, è di per sé un simbolo in MAIN contenente il puntatore di root a un sotto-ramo nell'albero dei simboli.

Il funzionamento del cambio di contesto è spiegato usando i seguenti due pezzi di codice:

(set 'var 123)
(define (foo x y)
    (context 'CTX)
    (println var " " x " " y))

L'istruzione (context 'CTX) è stata inclusa solo qui per mostrare, non ha alcun effetto in questa posizione. Un passaggio a un contesto di namespace diverso avrà influenza solo sulle successive creazione di simboli usando sym o eval-string. Nel momento in cui (context 'CTX) è eseguito, la funzione foo è già stata definita e tutti i simboli utilizzati in esso sono stati cercati e tradotti. Solo quando si utilizza (context ...) sul livello superiore influenzerà la creazione del simbolo con il codice che la segue:

(context 'CTX)
(set 'var 123)
(define (foo x y)
    (println var " " x " " y))
(context MAIN)

Adesso il contesto viene creato e passato al livello più alto. Quando newLISP traduce la successiva istruzione set e la definizione di funzione, tutti i simboli faranno parte di CTX come CTX:var, CTX:foo, CTX:x e CTX:y.

Durante il caricamento del codice newLISP legge un'espressione di livello superiore che traduce e poi valuta. Questo ciclo viene ripetuto fino a quando tutte le espressioni di livello superiore vengono lette e valutate.

(set 'var 123)
(define (foo x y)
    (println var " " x " " y))

Nello snippet di codice precedente due espressioni di livello superiore sono tradotte e valutate con conseguente creazione dei tre simboli: MAIN:var, MAIN:foo, MAIN:x, MAIN:y e MAIN:CTX.

Il simbolo MAIN:var conterrà il numero 123 e il simbolo MAIN:foo conterrà l'espressione lambda (lambda (x y) (println var " " x " " y)). I simboli MAIN:x e MAIN:y entrambi conterranno nil. La var all'interno della definizione di foo è la stessa della var precedentemente impostata a 123 e verrà stampata come 123 durante l'esecuzione di foo.

In dettaglio vengono eseguiti i seguenti passi:

1. il contesto attuale è MAIN

2. legge la parentesi di apertura di primo livello e crea una cella Lisp di tipo EXPRESSION.

3. legge e cerca set in MAIN e trova che è una primitiva built-in di MAIN, quindi lo traduce nell'indirizzo di memoria di questa funzione primitiva. Crea una cella Lisp di tipo PRIMITIVE che contiene internamente l'indirizzo della funzione.

4. legge il simbolo quote ' e crea una cella Lisp di tipo QUOTE.

5. Legge e cerca la variabile var in MAIN, non si trova in MAIN, lo crea in MAIN e lo traduce nell'indirizzo dell'albero binario dei simboli. Crea una cella Lisp di tipo SYMBOL contenente internamente l'indirizzo del simbolo. La cella di QUOTE precedentemente creata funge da inviluppo per la cella dei simboli.

6. Legge 123 e crea una cella Lisp di tipo INTEGER con 123 nello slot del contenuto.

7. legge la parentesi chiusa che chiude il primo livello e termina la seguente struttura di lista in memoria:

[ ]                          ; cell of type: EXPRESSION
  \
 [MAIN:set]  → [']  → [123]  ; three cells of type: PRIMITIVE, QUOTE, INTEGER
                 \
               [MAIN:var]    ; cell of type: SYMBOL

Il diagramma sopra mostra le cinque celle Lisp, che sono state create. Le celle List e quote sono celle di inviluppo che contengono una lista o un'espressione quotata.

L'istruzione (set 'var 123) non è ancora stata eseguita, ma la traduzione e la creazione dei simboli sono finite e l'istruzione esiste come una struttura di lista in memoria. L'intera struttura della lista può essere referenziata con un indirizzo di memoria, l'indirizzo della prima cella creata di tipo EXPRESSION.

8. Valutazione delle istruzioni
In modo simile newLISP leggerà e tradurrà la successiva espressione di primo livello, che è la definizione di funzione di foo. La valutazione di questa espressione di livello superiore comporterà un assegnamento di una espressione lambda al simbolo foo.

Nel codice sopra riportato, entrambe le istanze di var si riferiscono a MAIN:var. L'istruzione (context 'CTX) cambia solo il contesto, lo spazio di nomi per i nuovi simboli creati. Il simbolo var è stato creato durante il caricamento e la traduzione della funzione foo. Nel momento in cui foo viene chiamata ed eseguitola variabile var esiste già all'interno della funzione foo come MAIN:var. L'istruzione (context 'CTX) non ha alcun effetto sulla succesiva esecuzione di (println var).

Le istruzioni context come (context 'CTX) sopra, cambiano il contesto corrente per la creazione del simbolo durante la fase di caricamento e traduzione. Il contesto corrente definisce sotto quale ramo nell'albero dei simboli vengono creati nuovi simboli. Questo riguarda solo le funzioni sym, eval-string e una speciale sintassi di context per creare simboli. Una volta che un simbolo appartiene a un contesto, rimane lì.

Cambiamento di spazi di nomi (namespaces context)
-------------------------------------------------
I capitoli precedenti hanno mostrato come utilizzare il cambio di contesto al livello principale [top-level] di un  file sorgente newLISP per influenzare la creazione e la traduzione dei simboli durante il processo di caricamento della sorgente. Una volta che esistono spazi dei nomi diversi, chiamando una funzione che appartiene a un contesto diverso, si verificherà un cambio di contesto nello spazio dei nomi dove si trova la funzione lambda chiamata. Se la funzione chiamata non esegue alcuna istruzione sym o eval-string, allora questo cambio di contesto non hanno alcun effetto. Anche il comando load avvia sempre il caricamento del file relativamente al contesto MAIN, a meno che non venga specificato un contesto diverso come parametro speciale nellas funzione load. All'interno del file caricato i cambiamenti di contesto produrranno la creazioni di simboli durante il processo di load come spiegato precedentemente.

Ciò che causa i cambio di contesto è il simbolo che contiene la funzione lambda. Negli esempi di codice seguenti, la freccia ==> viene utilizzata per l'output generato dalle istruzioni println:

(context 'Foo)
(set 'var 123)
(define (func)
    (println "current context: " (context))
    (println "var: " var))
(context 'MAIN)

(Foo:func)
==> current context: Foo
==> var: 123

(set 'aFunc Foo:func)
(set 'var 999)

(aFunc)
==> current context: MAIN
==> var: 123

Si noti che la chiamata a aFunc fa sì che il contesto corrente venga visualizzato come MAIN, perché il simbolo aFunc appartiene al contesto MAIN. In entrambi i casi la variabile var viene stampata come 123. Il simbolo var è stato inserito nello spazio dei nomi di Foo durante la traduzione di func e resterà sempre lì, anche se una copia della funzione lambda viene creata e assegnata ad un simbolo in un contesto diverso.

Questo comportamento di cambio del contesto segue le stesse regole quando si applicano o si mappano le funzioni:

(apply 'Foo:func)
==> current context: Foo
==> var: 123

(apply Foo:func)
==> current context: MAIN
==> var: 123

La prima volta che Foo: func viene applicato come simbolo - quotato, la seconda volta la funzione lambda contenuta in Foo:func viene applicata direttamente, perchè apply valuta prima il suo primo argomento.

Spazi di nomi e il funtore di default
-------------------------------------
In newLISP, un simbolo è un funtore predefinito (default functor) se ha lo stesso nome del contesto a cui appartiene, es. Foo:Foo è il simbolo del funtore predefinito nel contesto Foo. In newLISP quando si utilizza un simbolo di contesto nella posizione del funtore, viene preso come il funtore predefinito:

(define (double:double x) (* 2 x))
(double 3)  → 6

(set 'my-list:my-list '(a b c d e f))
(my-list 3)  → d

Il secondo esempio combina l'indicizzazione implicita con l'uso di un funtore predefinito.

I funtori predefiniti possono essere applicati e mappati usando apply e map come qualsiasi altra funzione o simbolo di funtore:

(map my-list '(3 2 1 2))  → (d c b c)

(apply double '(10))  → 20

I funtori predefiniti sono un modo conveniente in newLISP per passare liste o altri oggetti big data per riferimento:

(set 'my-list:my-list '(a b c d e f))

(define (set-last ctx val)
  (setf (ctx -1) val))

(set-last my-list 99)  → f

my-list:my-list  → (a b c d e 99)

I funtori predefiniti sono anche un modo conveniente per definire funzioni full-state in uno spazio di nomi (functions with a closed state-full name space):

(context 'accumulator)
(define (accumulator:accumulator x)
  (if (not value)
    (set 'value x)
    (inc 'value x)))
(context MAIN)

(accumulator 10)  → 10
(accumulator 2)  → 12
(accumulator 3)  → 15

Nota che i simboli x e value appartengono entrambi allo spazio dei nomi accumulator. Poichè (context 'accumulator) è al livello più alto, la traduzione della seguente definizione di funzione accumulator:accumulator avviene all'interno dello spazio dei nomi corrente accumulator.

I namespace in newLISP possono essere passati per riferimento e possono essere utilizzati per creare chiusure lessicali full-state.

Il funtore di default usato come funzione pseudo-hash
-----------------------------------------------------
Un funtore predefinito che contiene nil e si trova nella posizione di operatore funzionerà in modo simile a una funzione di hash per la costruzione di dizionari con chiave associativa → accesso al valore:

(define aHash:aHash) ; create namespace and default functor containing nil

(aHash "var" 123) ; create and set a key "var" to 123

(aHash "var")  → 123 ; retrieve value from key

Riferimenti
-----------

[1] Lutz Mueller, 2004-2013
Automatic Memory Management in newLISP.

[2] John McCarthy, 1960
Recursive Functions of Symbolic Expressions and their Computation by Machine.


============================================================================
Gestione Automatica della Memoria in newLISP
di Lutz Mueller, 2004-2013
============================================================================

ORO (One Reference Only) La gestione automatica della memoria sviluppata per newLISP è un'alternativa rapida e in grado di risparmiare risorse rispetto ai classici algoritmi di garbage collection dei linguaggi di programmazione dinamici e interattivi. Questo articolo spiega come funziona la gestione della memoria di tipo ORO.

newLISP e qualsiasi altro sistema di linguaggio interattivo genererano costantemente nuovi oggetti in memoria durante la valutazione delle espressioni. I nuovi oggetti in memoria sono il risultato delle valutazioni intermedie, della riassegnazione di oggetti in memoria o della modifica di oggetti in memoria il cui contenuto è stato modificato. Se newLISP non eliminasse alcuni degli oggetti creati, alla fine esaurirebbe la memoria disponibile.

Per comprendere la gestione automatica della memoria in newLISP, è necessario prima rivedere i metodi tradizionali utilizzati da altri linguaggi.

Metodi tradizionali di gestione automatica della memoria (Garbage Collection)
-----------------------------------------------------------------------------
Nella maggior parte dei linguaggi di programmazione, un processo registra la memoria allocata e un altro processo trova e ricicla le parti inutilizzate del pool di memoria allocato. Il processo di riciclaggio può essere attivato da un limite di allocazione della memoria o può essere programmato tra una fase di valutazione e l'altra. Questa forma di gestione automatica della memoria si chiama Garbage Collection.

Gli schemi di garbage collection tradizionali sviluppati per LISP utilizzavano uno dei due seguenti algoritmi:¹

(1) L'algoritmo mark-and-sweep registra ogni oggetto di memoria allocato. Una fase mark contrassegna periodicamente ciascun oggetto nel pool di memoria allocato. Un oggetto con nome (un simbolo di variabile) fa riferimento direttamente o indirettamente a ciascun oggetto di memoria nel sistema. La fase di sweep libera la memoria degli oggetti contrassegnati quando non sono più in uso.

(2) Uno schema di conteggio di riferimento registra ogni oggetto di memoria allocato insieme con un conteggio di riferimenti all'oggetto. Questo conteggio dei riferimenti viene incrementato o decrementato durante la valutazione dell'espressione. Ogni volta che il conteggio dei riferimenti di un oggetto raggiunge lo zero, la memoria allocata dell'oggetto viene liberata.

Nel corso del tempo, sono stati elaborati molti schemi di garbage collection basati su queste tecniche. I primi algoritmi di garbage collection sono apparsi in LISP. Gli inventori del linguaggio Smalltalk utilizzavano schemi garbage collection più elaborati. La storia di Smalltalk-80 è un resoconto entusiasmante delle sfide poste dall'implementazione di metodi di gestione della memoria in linguaggi di programmazione interattivi, vedi [Glenn Krasner, 1983: Smalltalk-80, Bits of History, Words of Advice]. Una panoramica più recente dei metodi di garbage collection è disponibile in [Richard Jones, Rafael Lins, 1996: Garbage Collection, Algorithms for Automatic Dynamic Memory Management].

One reference only, (ORO) memory management
-------------------------------------------
La gestione della memoria in newLISP non si basa su un algoritmo di garbage collection. La memoria non è marcata o referenziata per conteggio. Invece, una decisione se eliminare un oggetto di memoria appena creato viene effettuata subito dopo la creazione dell'oggetto.

Studi empirici su LISP hanno dimostrato che la maggior parte delle celle LISP non sono condivise e quindi possono essere recuperate durante il processo di valutazione. A parte alcune ottimizzazioni per parte delle funzioni integrate, newLISP cancella la memoria di nuovi oggetti contenenti risultati di valutazione intermedi una volta raggiunto un livello di valutazione più alto. newLISP fa ciò spingendo un riferimento ad ogni oggetto di memoria creato su uno stack di risultati. Quando newLISP raggiunge un livello di valutazione superiore, rimuove il riferimento del risultato dell'ultima valutazione dallo stack dei risultati ed elimina l'oggetto di memoria del risultato della valutazione. Questo non dovrebbe essere confuso con il conteggio dei riferimenti a un bit. La gestione della memoria ORO non imposta bit come adesivi per contrassegnare gli oggetti.

newLISP segue la regola di un solo riferimento (ORO). Ogni oggetto di memoria non referenziato da un simbolo è obsoleto quando newLISP raggiunge un livello di valutazione più alto durante la valutazione dell'espressione. Gli oggetti in newLISP (esclusi simboli e contesti) vengono passati per copia del valore ad altre funzioni definite dall'utente. Di conseguenza, ogni nuovo oggetto LISP richiede solo un riferimento.

La regola ORO di newLISP ha dei vantaggi. Semplifica non solo la gestione della memoria, ma anche altri aspetti del nuovo linguaggio LISP. Ad esempio, mentre gli utenti di LISP tradizionali devono distinguere tra l'uguaglianza degli oggetti di memoria copiati e l'uguaglianza dei riferimenti agli oggetti di memoria, gli utenti newLISP non ne hanno bisogno.

La regola ORO di newLISP forza newLISP ad allocare e liberare celle LISP costantemente. newLISP ottimizza questo processo allocando grandi blocchi di memoria per le celle dal sistema operativo. newLISP richiederà celle LISP da un elenco di celle libere e quindi le riciclerà nuovamente in quell'elenco. Di conseguenza, sono necessarie solo alcune istruzioni della CPU (assegnazioni di puntatori) per scollegare una cella libera o per reinserire una cella eliminata.

L'effetto complessivo della gestione della memoria ORO è un tempo di valutazione più rapido e una memoria e un ingombro del disco più contenuti rispetto a quelli offerti dal tradizionale LISP interpretato. Il tempo impiegato per collegare e scollegare gli oggetti di memoria è più che compensato dalla mancanza di tempo di elaborazione causata dai metodi tradizionali di garbage collection. La gestione della memoria ORO evita anche le pause occasionali di elaborazione nei linguaggii che utilizzano la tradizionale garbage collection e l'ottimizzazione dei parametri di garbage collection richiesti durante l'esecuzione di programmi che fanno uso intensivo di memoria.

La gestione della memoria ORO avviene in modo sincrono rispetto ad altre elaborazioni nell'interprete, il che si traduce in tempi di elaborazione deterministici.

Nelle versioni precedenti alla 10.1.3, newLISP utilizzava un classico algoritmo di mark e sweep per liberare celle non referenziate in condizioni di errore. A partire dalla versione 10.1.3, questo è stato eliminato e sostituito da una corretta pulizia dello stack dei risultati in condizioni di errore.

Considerazioni sulle prestazioni con i parametri di copia
---------------------------------------------------------
In teoria, il passaggio dei parametri alle funzioni definite dall'utente in base al valore (by-value, copia della memoria) anziché al riferimento pone un potenziale svantaggio quando si gestiscono liste, matrici o stringhe di grandi dimensioni. Ma in pratica newLISP è più veloce o veloce come altri linguaggi di scripting e offre speciali sintassi per passare oggetti di memoria molto grandi per riferimento.

Poiché le funzioni newLISP versione 9.4.5 possono passare parametri di tipo list, array e string come riferimenti utilizzando gli identificativi dei funtori predefiniti ​​degli spazi dei nomi. I namespace (chiamati contesti in newLISP) hanno un overhead molto piccolo e possono essere utilizzati per avvolgere funzioni e dati. Ciò consente il passaggio di riferimento di un grande oggetto di memoria nelle funzioni definite dall'utente.

Dalla versione 10.2, FOOP (Functional Object Oriented Programming) in newLISP passa per riferimento anche l'oggetto target di una chiamata di metodo.

Ma anche nei casi in cui il passaggio di riferimento e altre ottimizzazioni non sono presenti, la velocità della gestione della memoria ORO compensa ampiamente il sovraccarico necessario per copiare ed eliminare oggetti.

Ottimizzazioni per la gestione della memoria ORO ²
------------------------------------------------
Dalla versione 10.1 di newLISP, tutte le liste, i vettori (array) e le stringhe vengono passati in e out dalle funzioni predefinite per riferimento. Tutte le funzioni integrate funzionano direttamente sugli oggetti di memoria restituiti per riferimento da altre funzioni incorporate. Ciò ha sostanzialmente ridotto la necessità di copiare ed eliminare oggetti di memoria e aumentato la velocità di alcune funzioni incorporate. Ora solo i parametri in funzioni definite dall'utente e i valori di ritorno passati da funzioni definite dall'utente sono gestiti da ORO.

Dalla versione 10.3.2, newLISP controlla lo stack dei risultati prima di copiare le celle LISP. Ciò ha ridotto la quantità di celle copiate di circa l'83% e ha aumentato significativamente la velocità di molte operazioni su liste più grandi.

Memoria e tipi di dati in newLISP
-------------------------------
Gli oggetti di memoria delle stringhe newLISP vengono allocati e liberati sul sistema operativo host, ogni volta che newLISP ricicla le celle dai suoi blocchi di allocazione delle celle di memoria. Ciò significa che newLISP gestisce la memoria delle celle in modo più efficiente rispetto alla memoria delle stringhe. Di conseguenza, è spesso preferibile utilizzare simboli anziché stringhe per un'elaborazione efficiente. Ad esempio, quando si gestisce il linguaggio naturale è più efficiente gestire le parole del linguaggio naturale come singoli simboli in uno spazio dei nomi separato, quindi come singole stringhe. La funzione bayes-train in newLISP utilizza questo metodo. newLISP può gestire milioni di simboli senza compromettere le prestazioni.

I programmatori provenienti da altri linguaggi di programmazione spesso trascurano che i simboli in LISP possono comportarsi come qualcosa di più di semplici variabili o riferimenti a oggetti. Il simbolo è un tipo di dati utile in sé, che in molti casi può sostituire il tipo di dati stringa.

I numeri interi e i numeri a virgola mobile (double) sono memorizzati direttamente nelle celle LISP di newLISP e non richiedono un ciclo di allocazione della memoria separato.

Per l'efficienza durante operazioni con matrici come la moltiplicazione o l'inversione della matrice, newLISP assegna oggetti di memoria non-cella per matrici, converte i risultati in celle LISP e quindi libera gli oggetti di memoria matrice.

newLISP alloca un array come un gruppo di celle LISP. Le celle LISP sono allocate in modo lineare. Di conseguenza, gli indici di array hanno un accesso casuale più rapido alle celle LISP. Solo un sottoinsieme delle funzioni di newLISP disponibilki per le liste può essere utilizzato sugli array. La gestione automatica della memoria in newLISP gestisce gli array in modo simile a come gestisce le liste.

Implementazione della gestione della memoria ORO
------------------------------------------------
Il seguente pseudo codice illustra l'algoritmo implementato in newLISP nel contesto della valutazione dell'espressione LISP. Sono necessarie solo due funzioni e una struttura dati per implementare la gestione della memoria ORO:

function pushResultStack(evalationResult)

function popResultStack() ; implies deleting

array resultStack[] ; preallocated stack area

Le prime due funzioni pushResultStack e popResultStack spingono (push) o estraggono (pop) un handle di un oggetto LISP avanti e indietro da una pila. pushResultStack aumenta il valore resultStackIndex mentre popResultStack lo diminuisce. In newLISP ogni oggetto è contenuto in una struttura di celle LISP. L'handle di oggetto di quella struttura è semplicemente il puntatore di memoria alla struttura della cella. La cella stessa può contenere indirizzi puntatore ad altri oggetti di memoria come buffer di stringa o altre celle LISP collegate all'oggetto originale. Oggetti piccoli come numeri vengono memorizzati direttamente. In questa funzione popResultStack() implica anche che l'oggetto estratto venga eliminato.

The first two functions pushResultStack and popResultStack push or pop a LISP object handle on or off a stack. pushResultStack increases the value resultStackIndex while popResultStack decreases it. In newLISP every object is contained in a LISP cell structure. The object handle of that structure is simply the memory pointer to the cell structure. The cell itself may contain pointer addresses to other memory objects like string buffers or other LISP cells linked to the original object. Small objects like numbers are stored directly. In this paper function popResultStack() also implies that the popped object gets deleted.

Le due funzioni di gestione resultStack descritte sono chiamate dalla funzione evaluateExpression di newLISP:³

;; function evaluateExpression(expr)
;;     {
;;     resultStackIndexSave = resultStackIndex
;;
;;     if typeOf(expr) is BOOLEAN or NUMBER or STRING
;;     return(expr)
;;
;;     if typeOf(expr) is SYMBOL
;;         return(symbolContents(expr))
;;
;;     if typeOf(expr) is QUOTE
;;         return(quoteContents(expr))
;;
;;     if typeOf(expr) is LIST
;;         {
;;         func = evaluateExpression(firstOf(expr))
;;         args = rest(expr)
;;         if typeOf(func) is BUILTIN_FUNCTION
;;                 result = evaluateFunc(func, args)
;;         else if typeOf(func) = LAMBDA_FUNCTION
;;                 result = evaluateLambda(func, args)
;;         }
;;     }
;;
;;     while (resultStackIndex > resultStackIndexSave)
;;         deleteList(popResultStack())
;;
;;     pushResultStack(result)
;;
;;     return(result)
;;     }

La funzione evaluateExpression introduce le due variabili resultStackIndexSave e resultStackIndex e alcune altre funzioni:

resultStackIndex è un indice che punta all'elemento superiore di resultStack. Maggiore è il livello di valutazione, maggiore è il valore di resultStackIndex.

resultStackIndexSave funge da memoria temporanea per il valore di resultStackIndex all'entrata della funzione evaluateExpression(func, args). Prima di uscire, il resultStack viene visualizzato al livello salvato di resultStackIndex. Estrarre il resultStack implica l'eliminazione degli oggetti di memoria indicati dalle voci nel resultStack.

resultStack[] è un'area di stack preallocata per il salvataggio di puntatori a celle LISP che sono indicizzate da resultStackIndex.

symbolContents(expr) e quoteContents(expr) estraggono il contenuto da simboli o da celle di memoria quotate (inviluppate con quote).

typeOf(expr) estrae il tipo di un'espressione, che è una costante BOOLEAN come nil o true o un NUMBER o STRING, oppure una variabile SYMBOL contenente alcuni contenuti, o un QUOTE che serve come una busta di inviluppo per un'altra espressione LIST expr.

evaluateFunc(func, args) è l'applicazione di una funzione built-in ai suoi argomenti. La funzione built-in è il primo membro valutato di una lista in expr e gli argomenti sono il resto della lista in expr. La funzione func viene estratta chiamando evaluateExpression(first (expr)) in modo ricorsivo. Ad esempio se l'espressione expr vale (foo x y) allora foo è una funzione built-in e x e y sono gli argomenti o parametri della funzione.

evaluateLambda(func, args) funziona in modo simile a evaluateFunc(func, args), applicando una funzione definita dall'utente first(expr) ai suoi argomenti definiti in rest(expr). Nel caso di una funzione definita dall'utente abbiamo due tipi di argomenti in rest(expr), un elenco di parametri locali seguiti da una o più espressioni del corpo valutate in sequenza.
Sia, evaluateFunc(func, args) e evaluateLambda(func, args) restituiranno un oggetto cella LISP appena creato o copiato, che può essere qualsiasi tipo di espressione sopra menzionata. Dalla versione 10.0, molte funzioni built-in elaborate con evaluateFunc(func, args) sono ottimizzate e restituiscono riferimenti invece di oggetti appena creati o copiati. Fatta eccezione per queste ottimizzazioni, i valori dei risultati saranno sempre gli oggetti di cella LISP appena creati destinati a essere distrutti al successivo livello di valutazione più alto, dopo che la funzione evaluateExpression (expr) corrente è stata eseguita.

Entrambe le funzioni chiamano ricorsivamente evaluateExpression(expr) per valutare i loro argomenti. Con l'aumentare della ricorsione, aumenta il livello di ricorsione della funzione.

Prima del ritorno di evaluateExpression(func, args), questa popolerà il resultStack eliminando i valori del risultato dal livello più profondo di valutazione e restituito da una delle due funzioni, evaluateFunc o evaluateLambda.

Qualsiasi espressione di risultato appena creata è destinata a essere distrutta in seguito, ma la sua cancellazione viene ritardata fino a raggiungere un livello di valutazione più alto, meno profondo. Ciò consente di utilizzare e/o copiare i risultati richiamando le funzioni.

L'esempio seguente mostra la valutazione di una piccola funzione LISP sum-of-squares definita dall'utente e la creazione e l'eliminazione di oggetti di memoria associati:

(define (sum-of-squares x y)
  (+ (* x x) (* y y)))

(sum-of-squares 3 4) => 25

sum-of-squares è una funzione lambda definita dall'utente che chiama le funzioni built-in + e *.

Il seguente trace mostra i passaggi rilevanti quando si definisce la funzione somma dei quadrati e quando si esegue con gli argomenti 3 e 4.

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

L'attuale implementazione del linguaggio C è ottimizzata in alcuni punti per evitare di inserire (pop) il resultStack ed evitare di chiamare evaluateExpression (expr). Vengono mostrati solo i passi più rilevanti. La funzione evaluateLambda (func, args) non ha bisogno di valutare i suoi argomenti 3 e 4 perché sono costanti, ma evaluateLambda(func, args) chiamerà evaluateExpression(expr) due volte per valutare le due espressioni del corpo (+ (* xx) e (+ (* xx). Linee precedute dal prompt > mostrano l'input della riga di comando.

evaluateLambda(func, args) salva anche l'ambiente per i simboli variabili x e y, copia i parametri in variabili locali e ripristina il vecchio ambiente all'uscita. Anche queste azioni comportano la creazione e la cancellazione di oggetti di memoria. I dettagli sono omessi perché sono simili ai metodi in altri linguaggi dinamici.

Riferimenti
– Glenn Krasner, 1983: Smalltalk-80, Bits of History, Words of Advice
Addison Wesley Publishing Company

– Richard Jones, Rafael Lins, 1996: Garbage Collection, Algorithms for Automatic Dynamic Memory Management
John Wiley & Sons

¹ Gli algoritmi Reference counting and mark-and-sweep sono stati  sviluppati appositamente per il LISP. Altri schemi come la copia o gli algoritmi generazionali sono stati sviluppati per altri linguaggi come Smalltalk e successivamente anche in LISP.

² Questo capitolo è stato aggiunto nell'ottobre 2008 ed è stato esteso ad agosto 2011.

³ Questa è una versione abbreviata della valutazione delle espressioni che non include la gestione dei funtori predefiniti e l'indicizzazione implicita. Per ulteriori informazioni sulla valutazione delle espressioni, consultare: "Valutazione dell'espressione, Indicizzazione implicita, Contesti e Funtori di default"


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
  http://www.newLISP.org/newLISP_in_21_minutes.html

  Forum ufficiale di newLISP
  http://www.newLISPfanclub.alh.net/forum/

  Johu's Blog
  https://johu02.wordpress.com/

  Cormullion's Blog
  https://newLISPer.wordpress.com/

  Kazimir Majorinc's Blog
  http://kazimirmajorinc.com/

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

  LeetCode - La piattaforma leader nel mondo per l'apprendimento online della programmazione:
  https://leetcode.com/

  GeeksforGeeks - Un portale di computer science per "geeks"
  https://www.geeksforgeeks.org/
