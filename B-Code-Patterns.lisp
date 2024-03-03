===============

 CODE PATTERNS

===============

Questo file contiene la traduzione libera del documento "Code Patterns in newLISP" che si trova al seguente indirizzo web:

http://www.newlisp.org/CodePatterns.html

Il documento ufficiale ha il seguente copyright:

----------------------------------------------------------------------------
Code Patterns in newLISP®
Version 2018 July 12th
newLISP version 10.7.1

Copyright © 2015 Lutz Mueller, www.nuevatec.com. All rights reserved.
Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.2 or any later version published by the Free Software Foundation, with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts. A copy of the license is included in the section entitled GNU Free Documentation License.

newLISP is a registered trademark of Lutz Mueller.
----------------------------------------------------------------------------

========
 INDICE
========

01. INTRODUZIONE
----------------

02. FILE DI SCRIPT NEWLISP
--------------------------
    Opzioni della riga di comando
    Script come pipe
    Filtri di file
    newLISP come pipe

03. SCRITTURA DEL SOFTWARE IN MODULI
------------------------------------
    Strutturare un'applicazione
    Più di un contesto per file
    La funzione predefinita (default function)
    Inserire dati nei contesti
    Passaggio di oggetti per riferimento

04. VARIABILI LOCALI
--------------------
    Variabili locali nei cicli (loop)
    Variabili locali in let, letn, local e letex
    Parametri inutilizzati come variabili locali
    Valori di default delle variabili
    args come sostituto delle variabili locali
    Uso combinato di args e variabili locali per le variabili con nome

05. ESPLORAZIONE DI LISTE E DATI
--------------------------------
    Ricorsione o iterazione?
    Velocizzare con la memoizzazione (memoization)
    Attraversare un albero (tree)
    Attraversare l'albero di una cartella (directory/folder)

06. MODIFICA E RICERCA NELLE LISTE
----------------------------------
    push e pop
    Estendere con extend
    Accedere alle liste
    Selezione di più elementi
    Filtrare e differenziare le liste
    Modifica degli elementi di una lista
    La variabile anaforica
    Sostituzioni nelle liste semplici
    Sostituzioni nelle liste annidate
    Passaggio di liste per riferimento
    Espansione delle variabili
    Destrutturare le liste annidate

07. FLUSSO DEL PROGRAMMA
------------------------
    Cicli (Loop)
    Blocchi
    Ramificazione (branching)
    Flusso fuzzy
    Flusso con catch e throw
    Uscire dai cicli con una condizione di interruzione
    Modificare il flusso con and o or

08. GESTIONE DEGLI ERRORI
-------------------------
    Errori newLISP
    Errori definiti dall'utente
    Gestione degli eventi di errore
    Cattura degli errori
    Errori del sistema operativo

09. FUNZIONI COME DATI
----------------------
    Manipolazione dopo la definizione
    Map e apply
    Funzioni che creano funzioni
    Funzioni con memoria
    Funzioni con codice auto-modificante

10. ELABORAZIONE DEL TESTO
-------------------
    Espressioni regolari
    Scansione del testo
    Aggiunta di stringhe
    Stringhe che crescono
    Riorganizzare le stringhe
    Modifica delle stringhe

11. DIZIONARI E HASH
---------------------------
    hash come chiave → valore
    Salvataggio e caricamento di dizionari

12. SERVER CLIENT TCP/IP
------------------------
    Connessione aperta
    Connessione chiusa

13. COMUNICAZIONI UDP
----------------------
    Connessione aperta
    Connessione chiusa
    Comunicazioni multi-cast

14. COMUNICAZIONI NON BLOCCANTI
-------------------------------
    Utilizzando net-select
    Utilizzando net-peek

15. CONTROLLARE ALTRE APPLICAZIONI
----------------------------------
    Utilizzando exec
    Pipe STD I/O
    Comunicazione tramite TCP/IP
    Comunicazione tramite FIFO con nome
    Comunicazione tramite UDP

16. ESEGUIRE APPLICAZIONI BLOCCANTI
-----------------------------------
    Esecuzione della shell
    Catturare std-out
    Alimentare std-in

17. SEMAFORI, MEMORIA CONDIVISA
-------------------------------

18. MULTIPROCESSING E CILK
--------------------------
    Avvio di processi concorrenti
    Monitorare i progressi
    Invocare spawn in modo ricorsivo
    Notifica guidata dagli eventi

19. SCAMBIO DI MESSAGGI
-----------------------
    Blocco dell'invio e della ricezione di messaggi
    Blocco dello scambio di messaggi
    Scambio di messaggi non bloccante
    Timeout dei messaggi
    Valutazione dei messaggi
    Agire come proxy

20. DATABASE E TABELLE DI LOOKUP
--------------------------------
    Liste di associazioni
    Associazioni annidate
    Aggiornamento delle associazioni annidate
    Combinazione di associazioni e hash

21. CALCOLO DISTRIBUITO
-----------------------
    Configurazione in modalità server
    Avviare un server state-full
    Server state-less con inetd
    Test del server con telnet
    Test con netcat su Unix
    Test dalla riga di comando
    Test HTTP con un browser
    Valutazione da remoto
    Impostazione della struttura dei parametri net-eval
    Trasferimento di file
    Caricamento e salvataggio dei dati
    Socket Unix di dominio locale

22. MODALITÀ SOLO SERVER WEB HTTPD
----------------------------------
    Variabili ambientali
    Pre-elaborazione della richiesta
    Elaborazione CGI in modalità HTTP
    Tipi di file supportati in modalità HTTP

23. ESTENDERE NEWLISP
---------------------
    Interfaccia FFI semplice rispetto a quella estesa
    Una libreria condivisa (shared library) in C
    Compilare su Unix
    Compilare una DLL su Win32
    Importazione di strutture dati
    Gestione della memoria
    Strutture allineate in modo non uniforme
    Passaggio di parametri
    Estrazione dei valori di ritorno
    Scrivere wrapper di librerie
    Registrazione di callback in librerie esterne

24. NEWLISP COME LIBRERIA CONDIVISA (SHARED LIBRARY)
----------------------------------------------------
    Valutazione del codice nella libreria condivisa
    Registrazione dei callback

=============================================================================


=================
 1. INTRODUZIONE
=================

Quando si programma in newLISP, alcune funzioni e modelli (pattern) di utilizzo si verificano ripetutamente.
Per alcuni problemi un modo ottimale per risolverli si evolve nel tempo.
I capitoli seguenti presentano codice di esempio e spiegazioni per la soluzione di problemi specifici durante la programmazione in newLISP.
Alcuni contenuti si sovrappongono al materiale trattato nel manuale "newLISP Users manual and Reference" o vengono presentati qui con un'angolazione diversa.
Utilizzeremo solo un sottoinsieme del repertorio delle funzioni totali di newLISP.
Alcune funzioni presentate hanno metodi di chiamata aggiuntivi o applicazioni non menzionate in queste pagine.
Questa raccolta di modelli e soluzioni è un lavoro in corso. Nel tempo, il materiale verrà aggiunto o il materiale esistente migliorato.


===========================
 2. FILE DI SCRIPT NEWLISP
===========================

Opzioni della riga di comando
=============================
Su Linux/Unix, inserisci quanto segue nella prima riga del file di script/programma:

#!/usr/bin/newlisp

specificando uno stack più grande:

#!/usr/bin/newlisp -s 100000

oppure

#!/usr/bin/newlisp -s100000

Le shell dei sistemi operativi si comportano in modo diverso durante l'analisi della prima riga e l'estrazione dei parametri.
newLISP accetta entrambi i parametri collegati o scollegati.
Inserisci le seguenti righe in un piccolo script per testare il comportamento del sistema operativo e della piattaforma sottostanti.
Lo script modifica la dimensione dello stack allocata a 100.000 e limita la memoria della cella newLISP a circa 10 Mbyte.

#!/usr/bin/newlisp -s 100000 -m 10

(println (main-args))
(println (sys-info))

(exit) ; importante

Un tipico output eseguendo lo script dalla shell di sistema sarebbe:

./arg-test

("/usr/bin/newlisp" "-s" "100000" "-m" "10" "./arg-test")
;-> (308 655360 299 2 0 100000 8410 2)

Notare che pochi programmi in newLISP necessitano di uno stack più grande di quello di base.
La maggior parte dei programmi viene eseguita sul valore predefinito di 2048.
Ogni posizione dello stack richiede una media di 80 byte.
Sono disponibili altre opzioni per avviare newLISP.
Vedere il Manuale dell'utente per i dettagli.

Script come pipe
================
L'esempio seguente mostra come un file può essere reindirizzato (pipe) in uno script newLISP.

#!/usr/bin/newlisp
#
# uppercase - demo filter script as pipe
#
# usage:
#          ./uppercase < file-spec
#
# example:
#          ./uppercase < my-text
#
#

(while (read-line) (println (upper-case (current-line))))

(exit)

Il file verrà stampato nello standard output tradotto in maiuscolo.
Il seguente programma funzionerà anche con informazioni binarie non testuali contenenti 0:

#!/usr/bin/newlisp
;
; inout - demo binary pipe
;
; read from stdin into buffer
; then write to stdout
;
; usage: ./inout < inputfile > outputfile
;

(while (read 0 buffer 1024)
    (write 1 buffer 1024))

(exit)

Impostare la dimensione del buffer per ottenere prestazioni migliori.

Filtri di File
==============
Lo script seguente funziona come l'utilità grep di Unix che itera sui file e filtra ogni riga di ogni file utilizzando un modello (pattern) di espressione regolare.

#!/usr/bin/newlisp
#
# nlgrep - grep utility on newLISP
#
# usage:
#          ./nlgrep "regex-pattern" file-spec
#
# file spec can contain globbing characters
#
# example:
#          ./nlgrep "this|that" *.c
#
# will print all lines containing 'this' or 'that' in *.c files
#

(dolist (fname (3 (main-args)))
    (set 'file (open fname "read"))
    (println "file ---> " fname)
    (while (read-line file)
        (if (find (main-args 2) (current-line) 0)
            (write-line)))
    (close file))

(exit)

L'espressione:

(3 (main-args))

è una forma breve di:

(rest (rest (rest (main-args))))

Restituisce una lista di tutti i nomi di file.
Questa forma di specificare gli indici per il resto è chiamata indicizzazione implicita.
Vedere il Manuale d'uso per l'indicizzazione implicita con altre funzioni.
L'espressione (main-args 2) estrae il terzo argomento dalla riga di comando contenente il modello (pattern) di espressione regolare.

newLISP come pipe
=================
Inserire una riga direttamente nell'eseguibile per la valutazione di espressioni brevi:

~> echo '(+ 1 2 3)' | newlisp
6
~>


=====================================
 3. SCRITTURA DEL SOFTWARE IN MODULI
=====================================

Strutturare un'applicazione
===========================
Quando si scrivono applicazioni più grandi o quando più programmatori stanno lavorando sulla stessa base di codice, è necessario dividere la base di codice in moduli.
I moduli in newLISP vengono implementati utilizzando i contesti, che sono spazi dei nomi.
Gli spazi dei nomi consentono l'isolamento lessicale tra i moduli.
Le variabili con lo stesso nome in un modulo non possono entrare in conflitto con le variabili con lo stesso nome in un altro modulo.

In genere, i moduli sono organizzati in un contesto per ogni file.

Un modulo file può contenere routine di accesso al database:

; database.lsp
;
(context 'db)


(define (update x y z)
...
)

(define (erase x y z)
...
)

Un altro modulo può contenere varie utilità:

; auxiliary.lsp
;
(context 'aux)

(define (getval a b)
...
)

In genere, ci sarà un modulo MAIN che carica e controlla tutti gli altri:

; application.lsp
;

(load "auxiliary.lsp")
(load "database.lsp")

(define (run)
    (db:update ....)
    (aux:putval ...)
    ...
    ...
)

(run)

Più di un contesto per file
===========================
Quando si utilizza più di un contesto per file, ogni sezione del contesto deve essere chiusa con un'istruzione (context MAIN):

; myapp.lsp
;
(context 'A)

(define (foo ...) ...)

(context MAIN)

(context 'B)

(define (bar ...) ...)

(context MAIN)

(define (main-func)
    (A:foo ...)
    (B:bar ...)
)

Si noti che nelle istruzioni dello spazio dei nomi per i contesti A e B i nomi dei contesti sono quotati perché sono stati appena creati, ma MAIN può rimanere non quotato perché esiste già all'avvio di newLISP.
Tuttavia, quotarlo non rappresenta un problema.

La riga (context MAIN) che chiude un contesto può essere omessa utilizzando la seguente tecnica:

; myapp.lsp
;
(context 'A)

(define (foo ...) ...)

(context 'MAIN:B)

(define (bar ...) ...)

(context 'MAIN)

(define (main-func)
    (A:foo ...)
    (B:bar ...)
)

La riga (contesto 'MAIN:B) torna a MAIN quindi apre il nuovo contesto B.

La funzione predefinita (default function)
==========================================
Una funzione in un contesto può avere lo stesso nome del contesto stesso.
Questa funzione ha caratteristiche speciali:

(context 'foo)

(define (foo:foo a b c)
...
)

La funzione foo:foo è chiamata funzione di default, perché quando si usa il nome di contesto foo come una funzione, sarà di default foo:foo.

(foo x y z)
; same as
(foo:foo x y z)

La funzione predefinita rende possibile scrivere funzioni che assomigliano a funzioni normali, ma portano il proprio spazio dei nomi lessicale. Possiamo usarlo per scrivere funzioni che mantengono lo stato:

(context 'generator)

(define (generator:generator)
    (inc acc)) ; quando acc vale nil, viene considerato 0

(context MAIN)

(generator) → 1
(generator) → 2
(generator) → 3

Quello che segue è un esempio più complesso per una funzione che genera una sequenza di Fibonacci:

(define (fibo:fibo)
    (if (not fibo:mem) (set 'fibo:mem '(0 1)))
    (last (push (+ (fibo:mem -1) (fibo:mem -2)) fibo:mem -1)))

(fibo) → 1
(fibo) → 2
(fibo) → 3
(fibo) → 5
(fibo) → 8
...

Questo esempio mostra anche come una funzione di default viene definita al volo senza la necessità di istruzioni di contesto esplicite.
In alternativa, la funzione potrebbe anche essere stata scritta in modo che il contesto sia creato esplicitamente:

(context 'fibo)
(define (fibo:fibo)
        (if (not mem) (set 'mem '(0 1)))
        (last (push (+ (mem -1) (mem -2)) mem -1)))
(context MAIN)

(fibo) → 1
(fibo) → 2
(fibo) → 3
(fibo) → 5
(fibo) → 8

Sebbene la prima forma sia più breve, la seconda è più leggibile.

Inserire dati nei contesti
==========================
Gli esempi precedenti presentavano funzioni già pacchettizzate con dati in uno spazio dei nomi.
Nell'esempio del generatore la variabile acc mantiene lo stato.
Nell'esempio del fibo la variabile mem mantiene una lista che cresce.
In entrambi i casi, funzioni e dati convivono in uno spazio dei nomi.
L'esempio seguente mostra come uno spazio dei nomi contiene solo dati nel funtore predefinito:

(set 'db:db '(a "b" (c d) 1 2 3 x y z))

Proprio come abbiamo usato la funzione predefinita per fare riferimento a fibo e generatore, possiamo fare riferimento alla lista in db:db usando solo db.
Funzionerà in tutte le situazioni in cui utilizziamo l'indicizzazione delle liste:

(db 0)    → a
(db 1)    → "b"
(db 2 1)  → d
(db -1)   → z
(db -3)   → x

(3 db)    → (1 2 3 x y z)
(2 1 db)  → ((c d))
(-6 2 db) → (1 2)

Passaggio di oggetti per riferimento
====================================
Quando il funtore predefinito (di default) viene utilizzato come argomento in una funzione definita dall'utente, il funtore predefinito viene passato per riferimento.
Ciò significa che viene passato un riferimento al contenuto originale, non una copia della lista o della stringa.
Ciò è utile quando si gestiscono liste o stringhe di grandi dimensioni:

(define (update data idx expr)
    (if (not (or (lambda? expr) (primitive? expr)))
        (setf (data idx) expr)
        (setf (data idx) (expr $it))))

(update db 0 99) → a
db:db → (99 "b" (c d) 1 2 3 x y z)

(update db 1 upper-case) → "b"
db:db → (99 "B" (c d) 1 2 3 x y z)

(update db 4 (fn (x) (mul 1.1 x))) →
db:db → (99 "B" (c d) 1 2.2 3 x y z)

I dati in db:db vengono passati tramite i dati dei parametri della funzione di aggiornamento, che ora contengono un riferimento al contesto db.
Il parametro expr passato viene controllato per determinare se si tratta di una funzione integrata, di un operatore o di un'espressione lambda definita dall'utente e quindi funziona su $it, la variabile anaforica di sistema che contiene il vecchio valore a cui fa riferimento (data idx).

Ogni volta che una funzione in newLISP richiede una stringa o una lista in un parametro, un funtore predefinito può essere passato tramite il suo simbolo di contesto.
Un altro esempio:

(define (pop-last data)
(pop data -1))

(pop-last db) → z

db:db         → (99 "B" (c d) 1 2.2 3 x y)

L'aggiornamento della funzione è anche un buon esempio di come passare operatori o funzioni come argomento di una funzione (lavorando in maiuscolo su $it).
Maggiori informazioni su questo argomento nel capitolo "Funzioni come dati".


=====================
 4. VARIABILI LOCALI
=====================

Variabili locali nei cicli (loop)
=================================
Tutte le funzioni di ciclo come "doargs", "dolist", "dostring", "dotimes", "dotree" e "for" usano le variabili locali.
Durante l'esecuzione del ciclo, la variabile assume valori diversi.
Ma dopo aver lasciato la funzione di ciclo, la variabile riacquista il suo vecchio valore.
Le espressioni "let", "define" e "lambda" sono un altro metodo per rendere le variabili locali.

Variabili locali in let, letn, local e letex
============================================
let è il modo usuale in newLISP di dichiarare i simboli come locali in un blocco.

(define (sum-sq a b)
    (let ((x (* a a)) (y (* b b)))
        (+ x y)))

(sum-sq 3 4) → 25

; sintassi alternativa
(define (sum-sq a b)
    (let (x (* a a) y (* b b))
        (+ x y)))

Le variabili x e y vengono inizializzate, quindi viene valutata l'espressione (+ x y).
La forma "let" è solo una versione ottimizzata e una comodità sintattica dell'espressione:

((lambda (sym1 [sym2 ...]) exp-body ) exp-init1 [ exp-init2 ...])

Quando si inizializzano diversi parametri, è possibile utilizzare un "let" annidato, "letn", per fare riferimento a variabili inizializzate in precedenza nelle successive espressioni di inizializzazione:

(letn ((x 1) (y (+ x 1)))
    (list x y))              → (1 2)

"local" funziona allo stesso modo ma le variabili sono inizializzate a zero:

(local (a b c)
   ...          ; espressioni che utilizzano le variabili locali a b c
)

"letex" funziona in modo simile a "let" ma le variabili vengono espanse nel corpo ai valori assegnati:

; assegna alla variabile locale ed espande nel corpo

(letex ( (x 1) (y '(a b c)) (z "hello") ) '(x y z))
→ (1 (a b c) "hello")

; come in let, le parentesi intorno agli inizializzatori possono essere omesse

(letex (x 1 y 2 z 3) '(x y z))    → (1 2 3)

Dopo essere usciti da una qualsiasi delle espressioni "let", "letn", "local" o "letex", i simboli delle variabili usati come locali recuperano i loro vecchi valori.

Parametri inutilizzati come variabili locali
============================================
In newLISP, tutti i parametri nelle funzioni definite dall'utente sono opzionali.
I parametri inutilizzati vengono inizializzati a nil e sono di ambito locale rispetto all'ambito dinamico della funzione.
La definizione di una funzione utente con più parametri di quelli richiesti è un metodo conveniente per creare simboli di variabili locali:

(define (sum-sq a b , x y)
    (set 'x (* a a))
    (set 'y (* b b))
    (+ x y))

La virgola non è una caratteristica di sintassi speciale, ma solo un aiuto visivo per separare i parametri normali dai simboli delle variabili locali (tecnicamente, la virgola, come x e y, è una variabile locale ed è impostata a nil).

Valore di default delle variabili
=================================
Nella definizione di una funzione si possono specificare valori di default:

(define (foo (a 1) (b 2))
    (list a b))

    (foo)      →  (1 2)
    (foo 3)    →  (3 2)
    (foo 3 4)  →  (3 4)

args come sostituto delle variabili locali
==========================================
Utilizzando la funzione "args" non è necessario utilizzare alcun simbolo di parametro e "args" restituisce una lista di tutti i parametri passati, ma non presi dai parametri dichiarati:

(define (foo)
    (args))

(foo 1 2 3)   → (1 2 3)

(define (foo a b)
    (args))

(foo 1 2 3 4 5)   → (3 4 5)

Il secondo esempio mostra come "args" contenga solo la lista di argomenti non associati dai simboli delle variabili a e b.

Gli indici possono essere utilizzati per accedere ai membri della lista (args):

(define (foo)
      (+ (args 0) (args 1)))

(foo 3 4)   → 7

Uso combinato di args e variabili locali per le variabili con nome
===================================================================

(define-macro (foo)
   (local (len width height)
      (bind (args) true)
      (println "len:" len " width:" width " height:" height)
   ))

(foo (width 20) (height 30) (len 10))

len:10 width:20 height:30

"local" nasconderà/proteggerà i valori delle variabili len, width e height ai livelli di scoping dinamico più elevati.


=================================
 5. ESPLORAZIONE DI LISTE E DATI
=================================

Ricorsione o iterazione?
========================
Sebbene la ricorsione sia una caratteristica potente per esprimere molti algoritmi in una forma leggibile, in alcuni casi può anche essere inefficiente.
newLISP ha molti costrutti iterativi e funzioni di alto livello come "flat" o le funzioni XML integrate, che usano la ricorsione internamente.
In molti casi ciò rende superflua la definizione di un algoritmo ricorsivo.

Alcune volte una soluzione non ricorsiva può essere molto più veloce e leggera sulle risorse di sistema.

; ricorsione classica
; lenta e affamata di risorse
(define (fib n)
    (if (< n 2) 1
        (+  (fib (- n 1))
            (fib (- n 2)))))

La soluzione ricorsiva è lenta a causa del frequente overhead di chiamata.
Inoltre, la soluzione ricorsiva utilizza molta memoria per contenere risultati intermedi e, spesso, ridondanti.

; iterazione
; veloce e restituisce anche l'intera lista
(define (fibo n , f)
    (set 'f '(1 0))
    (dotimes (i n)
         (push (+ (f 0) (f 1)) f)) )

La soluzione iterativa è veloce e utilizza pochissima memoria.

Velocizzare con la memoizzazione (memoization)
==============================================
Una funzione di memoizzazione mantiene nella cache i risultati intermedi per un recupero più rapido quando viene chiamata di nuovo con gli stessi parametri.
La seguente funzione crea una funzione di memoizzazione da qualsiasi funzione integrata o definita dall'utente con un numero arbitrario di argomenti.
Viene creato uno spazio dei nomi (contesto) come cache di dati per la funzione di memoizzazione:

; velocizza una funzione ricorsiva utilizzando la memoizzazione
(define-macro (memoize mem-func func)
    (set (sym mem-func mem-func)
        (letex (f func  c mem-func)
          (lambda ()
              (or (context c (string (args)))
              (context c (string (args)) (apply f (args))))))))

(define (fibo n)
    (if (< n 2)  1
        (+  (fibo (- n 1))
            (fibo (- n 2)))))

(memoize fibo-m fibo)

(time (fibo 25)) → 148
(time (fibo-m 25)) → 0

La funzione crea un contesto e una funzione di default per la funzione originale con un nuovo nome e memorizza tutti i risultati in simboli dello stesso contesto.

Quando si memoizzano funzioni ricorsive, includere la specifica grezza "lambda" della funzione in modo che anche le chiamate ricorsive vengano memoizzate:

(memoize fibo
    (lambda (n)
        (if(< n 2) 1
            (+  (fibo (- n 1))
                (fibo (- n 2))))))

(time (fibo 100)) → 1
(fibo 80)         → 37889062373143906

La funzione fibo nell'ultimo esempio richiederebbe ore per essere calcolata senza memoizzazione.
La versione memoizzata richiede solo circa un milli-secondo con un argomento di 100.

Attraversare un albero (tree)
=============================
Gli attraversamenti di alberi sono un modello tipico nel LISP tradizionale e anche in newLISP per attraversare una lista annidata.
Ma molte volte un attreversmaneto degli alberi viene utilizzato solo per scorrere tutti gli elementi di un albero esistente o di una lista annidata.
In questo caso la funzione "flat" incorporata è molto più veloce rispetto all'utilizzo della ricorsione:

(set 'L '(a b c (d e (f g) h i) j k))

; ricorsione e car/cdr classico
;
(define (walk-tree tree)
    (cond ((= tree '()) true)
          ((atom? (first tree))
             (println (first tree))
             (walk-tree (rest tree)))
          (true
             (walk-tree (first tree))
             (walk-tree (rest tree)))))

; ricorsione classica
; 3 volte più veloce
;
(define (walk-tree tree)
    (dolist (elmnt tree)
        (if (list? elmnt)
            (walk-tree elmnt)
            (println elmnt))))

(walk-tree L) →
     a
     b
     c
     d
     e
     ...

Utilizzando la funzione integrata "flat" una lista annidata può essere trasformata in una lista semplice.
Ora la lista può essere elaborata con "dolist" o con "map":

; veloce e breve usando 'flat'
; 30 volte più veloce con map
;
(map println (flat L))

; uguale a

(dolist (item (flat L)) (println item))

Attraversare l'albero di una cartella (directory/folder)
========================================================
Attraversare l'albero di una cartella (directory) è un'attività in cui la ricorsione funziona bene:

; attraversa una directory del disco
; e stampa tutti i nomi dei file (con percorso)
(define (show-tree dir)
    (when (directory? dir)
        (dolist (nde (directory dir))
            (if (and (directory? (append dir "/" nde))
                     (!= nde ".") (!= nde ".."))
                (show-tree (append dir "/" nde))
                (println (append dir "/" nde))))))

In questo esempio la ricorsione è l'unica soluzione, perché l'intera lista annidata di file non è disponibile quando la funzione viene chiamata, ma viene creata in modo ricorsivo durante l'esecuzione della funzione.


===================================
 6. MODIFICA E RICERCA NELLE LISTE
===================================

newLISP dispone di funzionalità per l'indicizzazione multidimensionale in liste annidate.
Ci sono funzioni distruttive come "push", "pop", "setf", "set-ref", "set-ref-all", "sort" e "reverse" e molte altre per operazioni non distruttive, come "nth", "ref", "ref-all", "first", "last" e "rest" ecc..
In newLISP, molte delle funzioni per le lista funzionano anche sulle stringhe.

Nota che qualsiasi indice di lista o di stringa in newLISP può essere negativo a partire da -1 dal lato destro di una lista:

(set 'L '(a b c d))
(L -1)   → d
(L -2)   → c
(-3 2 L) → (b c)

(set 'S  "abcd")

(S -1)   → d
(S -2)   → c
(-3 2 S) → "bc")

push e pop
==========
Per aggiungere a una lista usa "push", per eliminare un elemento da una lista usa "pop".
Entrambe le funzioni sono distruttive e modificano il contenuto della lista:

(set 'L '(b c d e f))

(push 'a L) → (a b c d e f)
(push 'g L -1) ; push alla fine con indice negativo
(pop L)        ; pop la prima a
(pop L -1)     ; pop l'ultima g
(pop L -2)     ; pop seconda dalla fine e
(pop L 1)      ; pop seconda c

L → (b d f)

; push/pop multidimensionale
(set 'L '(a b (c d (e f) g) h i))

(push 'x L 2 1) → (a b (c x d (e f) g) h i)

L → (a b (c x d (e f) g) h i)

(pop L 2 1) → x

; la lista da modificare ha un riferimento
; nella funzione push
(set 'lst '((a 1) (b 2) (c 3) (d)))

(push 4 (assoc 'd lst) -1) → (d 4)

lst → ((a 1) (b 2) (c 3) (d 4))

Inserire (push) ripetutamente alla fine di una lista è un'operazione ottimizzata in newLISP ed è veloce quanto inserire (push) all'inizio della lista.

Quando si inserisce un elemento usando un indice di un vettore V, questo può essere estratto con lo stesso indice del vettore V:

(set 'L '(a b (c d (e f) g) h i))
(set 'V '(2 1))
(push 'x L V)
L → (a b (c x d (e f) g) h i))
(ref 'x L) → (2 1) ; ricerca di un elemento annidato
(pop L V) → 'x

Estendere usando extend
=======================
Usando "extend" le liste possono essere aggiunto in modo distruttivo.
Come "push" e "pop", "extent" modifica la lista nel primo argomento.

(set 'L '(a b c))
(extend L '(d e) '(f g))

L → '(a b c d e f g)

; estendere sul posto

(set 'L '(a b "CD" (e f)))
(extend (L 3) '(g))
L → (a b "CD" (e f g))

Accedere alle liste
===================
È possibile specificare indici multipli per accedere agli elementi in una lista con struttura annidata:

(set 'L '(a b (c d (e f) g) h i))

; vecchia sintassi solo per un indice
(nth 2 L) → (c d (e f) g)

; utilizzare la nuova sintassi per più indici
(nth '(2 2 1) L) → f
(nth '(2 2) L) → (e f)

; indicizzazione vettoriale
(set 'vec '(2 2))
(nth vec L) → (e f)

; indicizzazione implicita
(L 2 2 1) → f
(L 2 2)   → (e f)

; indicizzazione implicita con un vettore
(set 'vec '(2 2 1))
(L vec)   → f

L'indicizzazione implicita mostrata nell'ultimo esempio può rendere il codice più leggibile.
Gli indici prima di una lista selezionano le sottosezioni di una lista, che a loro volta sono sempre liste.

L'indicizzazione implicita è disponibile anche per "rest" e "slice":

(rest '(a b c d e))      → (b c d e)
(rest (rest '(a b c d e) → (c d e)
; uguale a
(1 '(a b c d e)) → (b c d e)
(2 '(a b c d e)) → (c d e)

; indici negativi
(-2 '(a b c d e)) → (d e)

; slicing (affettare)
(2 2 '(a b c d e f g))  → (c d)
(-5 3 '(a b c d e f g)) → (c d e)

Selezione di più elementi
=========================
A volte è necessario selezionare più di un elemento da una lista.
Questo viene fatto usando "select":

; seleziona diversi elementi da una lista
(set 'L '(a b c d e f g))
(select L 1 2 4 -1) → (b c e g)

; gli indici possono essere forniti da un vettore di indici:
(set 'vec '(1 2 4 -1))
(select L vec) → (b c e g)

Il processo di selezione può riorganizzare o raddoppiare gli elementi contemporaneamente:

(select L 2 2 1 1) → (c c b b)

Filtrare e differenziare le liste
=================================
Le liste possono essere filtrate, restituendo solo quegli elementi che soddisfano una condizione specifica:

(filter (fn(x) (< 5 x)) '(1 6 3 7 8))    → (6 7 8)
(filter symbol? '(a b 3 c 4 "hello" g)) → (a b c g)
(difference '(1 3 2 5 5 7) '(3 7)) → (1 2 5)

Il primo esempio potrebbe essere scritto in modo più conciso, come segue:

(filter (curry < 5) '(1 6 3 7 8))

La funzione "curry" crea una funzione a un argomento da una funzione a due argomenti:

(curry < 5) → (lambda (_x) (< 5 _x))

Con curry, una funzione che accetta due argomenti può essere rapidamente convertita in un predicato che accetta un argomento.

Modifica degli elementi di una lista
====================================
"setf" può essere utilizzato per modificare un elemento della lista facendo riferimento ad esso con "nth" o "assoc":

; modificare una lista in corrispondenza di un indice
(set 'L '(a b (c d (e f) g) h i))

(setf (L 2 2 1) 'x) → x
L → (a b (c d (e x) g) h i)
(setf (L 2 2) 'z) → z
L → (a b (c d z g) h i)

; modificare una lista di associazioni
(set 'A '((a 1) (b 2) (c 3)))

; usare setf con assoc
(setf (assoc 'b A) '(b 22)) → (b 22)
A → ((a 1) (b 22) (c 3))

; usare setf con lookup
(setf (lookup 'c A) 33) → 33
A → ((a 1) (b 22) (c 33))

La variabile anaforica
======================
La variabile di sistema anaforica interna "$it" contiene il vecchio elemento della lista.
Questa può essere usata per creare il nuovo elemento:

(set 'L '(0 0 0))
(setf (L 1) (+ $it 1)) → 1 ; il nuovo valore
(setf (L 1) (+ $it 1)) → 2
(setf (L 1) (+ $it 1)) → 4
L → '(0 3 0)

Le seguenti funzioni usano l'anaforico "$it": "find-all", "if", "replace", "set-ref", "set-ref-all", "setf" e "setq".

Sostituzioni nelle liste semplici
=================================
"replace", che può essere utilizzato anche su stringhe, può cercare e sostituire più elementi contemporaneamente in una lista.
Insieme a "match" e "unify", è possibile specificare modelli di ricerca complessi.
Come con "setf", l'espressione di sostituzione può utilizzare il contenuto del vecchio elemento per formare la sostituzione.

(set 'aList '(a b c d e a b c d))

(replace 'b aList 'B) → (a B c d e a B c d)

La funzione "replace" può usare una funzione di confronto per selezionare gli elementi della lista:

; sostituire tutti i numeri dove 10 < numero
(set 'L '(1 4 22 5 6 89 2 3 24))

(replace 10 L 10 <) → (1 4 10 5 6 10 2 3 10)

Utilizzando le funzioni integrate "match" e "unify" è possibile definire criteri di selezione più complessi:

; sostituire solo le sottoliste che iniziano con "maria"
(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))

(replace '(mary *)  AL (list 'mary (apply + (rest $it))) match)
→ ((john 5 6 4) (mary 14) (bob 4 2 7 9) (jane 3))

; fare la somma in tutte le espressioni
(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))

(replace '(*) AL (list ($it 0) (apply + (rest $it))) match)
→ ((john 15) (mary 14) (bob 22) (jane 3))

$0 → 4  ; sostituzioni effettuate

; modificare solo le sotto-liste in cui entrambi gli elementi sono uguali
(replace '(X X) '((3 10) (2 5) (4 4) (6 7) (8 8)) (list ($it 0) 'double ($it 1)) unify)
→ ((3 10) (2 5) (4 double 4) (6 7) (8 double 8))

$0 → 2  ; sostituzioni effettuate

Durante le sostituzioni $0 e la variabile di sistema anaforica $it contengono l'espressione trovata corrente.

Dopo che un'istruzione di sostituzione è stata eseguita, la variabile di sistema newLISP $0 contiene il numero di sostituzioni effettuate.

Sostituzioni nelle liste annidate
=================================
A volte le liste sono nidificati, ad es. l'SXML risulta dall'analisi dell'XML.
Le funzioni "ref-set", "set-ref" e "set-ref-all" possono essere utilizzate per trovare un singolo elemento o tutti gli elementi in una lista annidata e sostituirli in parte o tutti.

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(set-ref 'monday data tuesday)

→ ((tuesday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1)))

La funzione "set-ref-all" esegue più volte un "set-ref", sostituendo tutte le occorrenze trovate di un elemento.

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(set-ref-all 'apples data "Apples")

→ ((monday ("Apples" 20 30) (oranges 2 4 9)) (tuesday ("Apples" 5) (oranges 32 1)))

Come "find", "replace", "ref" e "ref-all", le ricerche più complesse possono essere espresse utilizzando "match" o "unify":

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(set-ref-all '(oranges *) data (list (first $0) (apply + (rest $it))) match)
→ ((monday (apples 20 30) (oranges 15)) (tuesday (apples 5) (oranges 33)))

L'ultimo esempio mostra come utilizzare "$0" per accedere al vecchio elemento della lista nell'espressione di aggiornamento.
In questo caso i numeri per i record delle arance sono stati sommati.
Invece di "$0" può essere utilizzata anche la variabile di sistema anaforica "$it".

Passaggio di liste per riferimento
==================================
A volte una lista più grande (più di poche centinaia di elementi) deve essere passato a una funzione definita dall'utente affinché gli elementi in essa contenuti possano essere modificati.
Normalmente newLISP passa tutti i parametri alle funzioni definite dall'utente in base al valore.
Ma il seguente frammento mostra una tecnica che può essere utilizzata per passare una lista più grande o un oggetto stringa per riferimento:

(set 'data:data '(a b c d e f g h))

(define (change db i value)
    (setf (db i) value))

(change data 3 999) → d

data:data → '(a b c 999 d e f g h)

In questo esempio la lista è incapsulata in un contesto denominato data contenente una variabile data con lo stesso nome.

Ogni volta che una funzione in newLISP cerca una stringa o una lista come parametro, è possibile passare un contesto, che verrà quindi interpretato come il funtore predefinito.

Quando si restituisce una lista o un array o un elemento appartenente a una lista o un array a cui fa riferimento un simbolo, molte funzioni integrste restituiscono un //riferimento// alla lista, non una copia.
Questo può essere utilizzato per annidare le funzioni integrate durante la modifica di una lista:

(set 'L '(r w j s r b))

(pop (sort L)) → b

L → (j r r s w)

Espansione delle variabili
==========================
Sono disponibili due funzioni per eseguire la macro-espansione: "expand" e "letex".
La funzione "expand" ha tre diversi modelli di sintassi.

I simboli vengono espansi al loro valore:

; espandere da uno o più simboli in una lista
(set 'x 2 'a '(d e))
(expand '(a x (b c x)) 'x 'a)  → ((d e) 2 (b c 2))

"expand" è utile quando si compongono espressioni lambda o quando si esegue l'espansione di variabili all'interno di funzioni e macro di funzioni (fexpr con define-macro):

; usare l'espansione dentro una funzione
(define (raise-to power)
    (expand (fn (base) (pow base power)) 'power))
(define square (raise-to 2))
(define cube (raise-to 3))
(square 5)  → 25
(cube 5)    → 125

"expand" può prendere una lista di associazioni:

; espandere da una lista di associazione
(expand '(a b c) '((a 1) (b 2)))                → (1 2 c)
(expand '(a b c) '((a 1) (b 2) (c (x y z))))    → (1 2 (x y z))

e la parte di valore nelle associazioni può essere valutata per prima:

; valutare le parti di valore nella lista di associazioni prima dell'espansione
(expand '(a b) '((a (+ 1 2)) (b (+ 3 4))))      → ((+ 1 2) (+ 3 4))
(expand '(a b) '((a (+ 1 2)) (b (+ 3 4))) true) → (3 7)

"expand" fa il suo lavoro sulle variabili che iniziano con una lettera maiuscola quando le variabili di espansione non sono state specificate singolarmente né in una lista di associazioni.

; espandere da una variabile con iniziale maiuscola
(set 'A 1 'Bvar 2 'C nil 'd 5 'e 6)
(expand '(A (Bvar) C d e f))  → (1 (2) C d e f)

Usando questo, la definizione della funzione precedente può essere resa ancora più breve.

; usa l'espansione da variabili maiuscole nelle creazione di funzioni
(define (raise-to Power)
    (expand (fn (base) (pow base Power))))
(define cube (raise-to 3)) → (lambda (base) (pow base 3))
(cube 4) → 64

La funzione "letex" funziona come "expand", ma i simboli di espansione sono locali all'espressione "letex".

; usare letex per espandere variabili
(letex ( (x 1) (y '(a b c)) (z "hello") ) '(x y z)) → (1 (a b c) "hello")

Si noti che nell'esempio l'espressione del corpo in "letex": (x y z) viene quotata per impedire la valutazione.

Destrutturare le liste annidate
===============================
Il metodo seguente può essere utilizzato per associare ("bind") le variabili alle sottoparti di una lista annidata:

; utilizza unify insieme a bind per la destrutturazione
(set 'structure '((one "two") 3 (four (x y z))))
(set 'pattern '((A B) C (D E))) ; unify necessita di lettere maiuscole per il binding
(bind (unify pattern structure))
A → one
B → "two"
C → 3
D → four
E → (x y z)


=========================
 7. FLUSSO DEL PROGRAMMA
=========================

Il flusso del programma in newLISP è per lo più funzionale, ma ha anche costrutti di loop e ramificazione e la coppia "catch" e "throw" per interrompere il normale flusso.

Le espressioni di un ciclo nel loro insieme si comportano come una funzione o un blocco che restituisce l'ultima espressione valutata.

Cicli (Loop)
============
Sono supportati la maggior parte dei modelli di loop tradizionali.
Ogni volta che è presente una variabile di ciclo, è di ambito locale rispetto al ciclo, comportandosi secondo le regole dello scoping dinamico all'interno dello spazio dei nomi o del contesto corrente:

; loop un numero di volte
; "i" va da 0 a N - 1
(dotimes (i N)
    ....
)

; dimostra che "i" è locale
(dotimes (i 3)
    (print i ":")
    (dotimes (i 3) (print i))
    (println)
)

→ ; output
 0:012
 1:012
 2:012

; ciclo attraverso una lista
; prende il valore di ogni elemento in aList
(dolist (e aList)
    ...
)

; ciclo attraverso una stringa
; prende il valore ASCII o UTF-8 (numero) di ogni carattere in aString
(dostring (e aString)
    ...
)

; ciclo attraverso i simboli di un contesto in
; ordine alfabetico del nome del simbolo
(dotree (s CTX)
    ...
)

; ciclo da init a N con dimensione opzionale del passo (step)
; Parte da init fino a <= N compreso con passo uguale a step
; Notare che il segno del passo è irrilevante,
; N può essere maggiore o minore di init.
(for (i init N step)
    ...
)

; ciclo affinché una condizione è vera
; prima valuta la condizione e poi esegue il corpo
(while condition
    ...
)

; ciclo affinché una condizione è falsa
; prima valuta la condizione e poi esegue il corpo
(until condition
    ...
)

; ciclo affinché una condizione è vera
; prima esegue il corpo e poi valuta la condizione
; il corpo viene eseguito almeno una volta
(do-while condition
    ...
)

; ciclo affinché una condizione è falsa
; prima esegue il corpo e poi valuta la condizione
; il corpo viene eseguito almeno una volta
(do-until condition
    ...
)

Si noti che le funzioni di ciclo "dolist", "dotimes" e "for" possono anche accettare una condizione di interruzione come argomento aggiuntivo.
Quando la condizione di interruzione restituisce true, il ciclo termina:

(dolist (x '(a b c d e f g) (= x 'e))
    (print x))
→ ; output
 abcd

Blocchi
=======
I blocchi sono un insieme di s-espressioni valutate sequenzialmente.
Tutti i costrutti di ciclo possono avere blocchi di espressioni come corpo dopo l'espressione della condizione.

I blocchi possono anche essere costruiti racchiudendoli in un'espressione di inizio "begin":

(begin
    s-exp1
    s-exp2
     ...
    s-expN)


I costrutti di ciclo non necessitano di utilizzare un "begin" esplicito dopo le condizioni dei cicli.
"begin" è usato principalmente per creare blocchi di espressioni nell' istruzione "if".

Le funzioni "and", "or", "let", "letn" e "local" possono anche essere utilizzate per formare blocchi e non richiedono l'istruzione "begin" per il blocco.

Ramificazione (branching)
=========================
(if condizione true-expr false-expr)

;o quando non è presente alcuna false-expr
(if condizione true-expr)

;o unario se usato per (filter if '(...))
(if condizione)

; più di un'espressione nel blocco true o false;
; il blocco deve essere raccchiuso con (begin...)
(if (= x y)
    (begin
        (some-func x)
        (some-func y))
    (begin
        (do-this x y)
        (do-that x y))
)

; la forma "when" può avee diverse espressioni senza
; usare il blocco (begin ...)
(when condition
    exp-1
    exp-2
    ...
)

; "unless" funziona come (when (not ...) ...)
(unless condition
    exp-1
    exp-2
    ...
)

A seconda della condizione, viene valutata e restituita la parte exp-true o exp-false.

In un'espressione "if" può verificarsi più di una coppia condizione/exp-true, facendola assomigliare ad una "cond":

(if condition-1 exp-true-1
    condition-2 exp-true-2
    ...
    condition-n exp-true-n
    expr-false
)

Viene valutata e restituita la prima exp-true-i per cui la condizione-i non è nulla, oppure exp-false se nessuna delle condizioni-i è vera.

"cond" funziona come la forma di condizioni multiple di "if", ma ogni parte di condition-i exp-true-i deve essere tra parentesi:

(cond
    (condition-1 exp-true-1 )
    (condition-2 exp-true-2 )
                ...
    (condition-n exp-true-n )
    (true exp-true)
)

Flusso fuzzy
============
Utilizzando "amb" il flusso del programma può essere regolato in modo probabilistico:

(amb
    exp-1
    exp-2
    ...
    exp-n
)

Una delle espressioni alternative da exp-1 a exp-n viene valutata con una probabilità di p = 1/n e il risultato viene restituito dall'espressione "amb".

Flusso con catch e throw
========================
Qualsiasi loop/ciclo o altro blocco di espressioni può essere racchiuso in un'espressione "catch".
Nel momento in cui viene valutata un'espressione "throw", l'intera espressione "catch" restituisce il valore dell'espressione "throw".

(catch
    (dotimes (i 10)
    (if (= i 5) (throw "The End"))
    (print i " "))
)
; output
0 1 2 3 4
; e il valore di ritorno dell'espressione "catch" vale
→ "The End"

È possibile annidare diverse espressioni "catch".
La funzione "catch" può anche rilevare gli errori.
Vedere il capitolo seguente "Gestione degli errori".

Uscire dai cicli con una condizione di interruzione
===================================================
I cicli creati usando "dotimes", "dolist" o "for" possono specificare una condizione di interruzione per lasciare il loop in anticipo:

(dotimes (x 10 (> (* x x) 9))
    (println x))
→
 0
 1
 2
 3

(dolist (i '(a b c nil d e) (not i))
    (println i))
→
 a
 b
 c

Modificare il flusso con and o or
=================================
Simile alla programmazione in linguaggio Prolog, gli operatori logici "and" e "or" può essere utilizzato per controllare il flusso del programma a seconda del risultato delle espressioni logicamente connesse:

(and
   expr-1
   expr-2
    ...
   expr-n)

Le espressioni vengono valutate sequenzialmente fino a quando un expr-i restituisce nil o la lista vuota () o fino a quando tutti gli expr-i sono esauriti.
L'ultima espressione valutata è il valore restituita dall'intero blocco di espressioni.

(or
   expr-1
   expr-2
    ...
   expr-n)

Le espressioni vengono valutate sequenzialmente fino a quando un expr-i restituisce not nil o not lista vuota () o fino a quando tutti gli expr-i sono esauriti.
L'ultima espressione valutata è il valore restituita dall'intero blocco di espressioni.


==========================
 8. GESTIONE DEGLI ERRORI
==========================

Durante la valutazione di un'espressione newLISP diverse condizioni possono causare eccezioni di errore.
Per un elenco completo degli errori, vedere l'appendice nel newLISP Reference Manual.

Errori newLISP
==============
Gli errori newLISP sono causati dal programmatore che utilizza la sintassi sbagliata quando invoca le funzioni, fornisce il numero sbagliato di parametri o parametri con il tipo di dati sbagliato, o cerca di valutare funzioni inesistenti.

; esempi di errori newLISP
;
(foo foo)   → invalid function : (foo foo)
(+ "hello") → value expected in function + : "hello"

Errori definiti dall'utente
===========================
Gli errori dell'utente sono eccezioni di errore generate utilizzando la funzione "throw-error":

; errore definito dall'utente
;
(define (double x)
    (if (= x 99) (throw-error "illegal number"))
    (+ x x)
)

(double 8)   → 16
(double 10)  → 20
(double 99)
→
user error : illegal number
called from user defined function double

Gestori degli eventi di errore
==============================
newLISP e gli errori definiti dall'utente possono essere rilevati utilizzando la funzione "error-event" per definire un gestore di eventi.

; definisce un gestore di errori (error event handler)
;
(define (MyHandler)
    (println  (last (last-error))  " has occurred"))

(error-event 'MyHandler)

(foo) → ERR: invalid function : (foo) has occurred

Cattura degli errori
====================
Una gestione delle eccezioni degli errori più dettagliata e più specifica può essere ottenuta utilizzando una sintassi speciale della funzione "catch".

(define (double x)
    (if (= x 99) (throw-error "illegal number"))
    (+ x x))

"catch" con un secondo parametro può essere utilizzato per rilevare gli errori di sistema e quelli definiti dall'utente:

(catch (double 8) 'result) → true
result → 16

(catch (double 99) 'result) → nil
(print result)
 →
user error : illegal number
called from user defined function double

(catch (double "hi") 'result) → nil
(print result)
→
value expected in function + : x
called from user defined function double

L'espressione "catch" restituisce true quando non si è verificata alcuna eccezione di errore e il risultato dell'espressione si trova nel simbolo specificato come secondo parametro.

Se si verifica un'eccezione di errore, viene rilevata e la clausola "catch" restituisce nil.
In questo caso il risultato del simbolo contiene il messaggio di errore.

Errori del sistema operativo
============================
Alcuni errori originati a livello di sistema operativo non vengono rilevati da newLISP, ma possono essere controllati utilizzando la funzione "sys-error".
Ad esempio la mancata apertura di un file potrebbe avere diverse cause:

; cerca di aprire un file non esistente
(open "blahbla" "r")  →  nil
(sys-error)           →  (2 "No such file or directory")

; per cancellare errno specificare 0
(sys-error 0)         →  (0 "Unknown error: 0")

I numeri restituiti possono essere diversi su diverse piattaforme Unix.
Consulta il file /usr/include/sys/errno.h della tua piattaforma.


=======================
 9. FUNZIONI COME DATI
=======================

Manipolazione dopo la definizione
=================================

(define (double x) (+ x x))
→ (lambda (x) (+ x x))

(first double) → (x)
(last double)  → (+ x x)

; modifica la funzione "double"
(setf (nth 1 double) '(mul (normal x (div x 10)) 2))

(double 10) → 20.31445313
(double 10) → 19.60351563

"lambda" in newLISP non è un operatore o un simbolo, ma piuttosto una s-espressione speciale o un attributo di una lista:

(first double) → (x)   ; non lambda

L'attributo "lambda" di una s-espressione è associativo a destra in "append":

(append (lambda) '((x) (+ x x))) → (lambda (x) (+ x x))

; o più brevemente

(append (fn) '((x) (+ x x))) → (lambda (x) (+ x x))

(set 'double (append (lambda) '((x) (+ x x))))

(double 10) → 20

e associativo a sinistra quando si usa "cons":

(cons '(x) (lambda) → (lambda (x)))

Le espressioni "lambda" in newLISP non perdono mai la proprietà di oggetto di prima classe.

La parola lambda può essere abbreviata in "fn", il che è utile quando si mappano o si applicano funzioni per rendere l'espressione più leggibile e più breve da digitare.

Map e Apply
===========
È possibile applicare funzioni o operatori a una lista di dati contemporaneamente e tutti i risultati vengono restituiti in una lista:

(define (double (x) (+ x x)))

(map double '(1 2 3 4 5)) → (2 4 6 8 10)

Le funzioni possono essere applicate ai parametri che si trovano in una lista:

(apply + (sequence 1 10)) → 55

Funzioni che creano funzioni
============================
Ecco un'espressione che viene passata come parametro:

; espansione in una macro usando expand
(define (raise-to power)
    (expand (fn (base) (pow base power)) 'power))

; o usando letex in alternativa
(define (raise-to power)
    (letex (p power) (fn (base) (pow base p))))

(define square (raise-to 2))

(define cube (raise-to 3))

(square 5)   → 25
(cube 5)     → 125

La funzione built-in "curry" può essere usata per fare in modo che una funzione prenda un argomento da una funzione che ne prende due.

(define add-one (curry add 1))  → (lambda () (add 1 ($args 0)))

(define by-ten (curry mul 10))  → (lambda () (mul 10 ($args 0)))

(add-one 5)    → 6

(by-ten 1.23)  → 12.3

Nota che il parametro 'curried' è sempre il primo parametro della funzione originale.

Funzioni con memoria
====================
newLISP può creare variabili di stato locale utilizzando un contesto (spazio dei nomi):

; generatore newLISP

(define (gen:gen)
    (setq gen:sum
    (if gen:sum (inc gen:sum) 1)))

; questo potrebbe essere scritto più brevemente
; perché "inc" considera nil come zero

(define (gen:gen)
    (inc gen:sum))

(gen) → 1
(gen) → 2
(gen) → 3

L'esempio utilizza un funtore predefinito - il nome della funzione è uguale al nome dello spazio dei nomi (contesto) - per dargli l'aspetto di una normale funzione.
Altre funzioni potrebbero essere aggiunte allo spazio dei nomi, ad es. per inizializzare la somma.

(define (gen:init x)
    (setq gen:sum x))

(gen:init 20) → 20

(gen) → 21
(gen) → 22

Funzioni con codice auto-modificante
====================================
In newLISP la natura di prima classe delle espressioni lambda rende possibile scrivere codice auto-modificante:

; accumulatore sum
(define (sum (x 0)) (inc 0 x))

(sum 1)    → 1
(sum 2)    → 3
(sum 100)  → 103
(sum)      → 103

sum  → (lambda ((x 0)) (inc 103 x))

L'esempio seguente mostra una funzione che si modifica automaticamente, creando un flusso di elementi, utilizzando "expand":

(define (make-stream lst)
    (letex (stream lst)
        (lambda () (pop 'stream))))

(set 'lst '(a b c d e f g h))
(define mystream (make-stream lst))

(mystream)  → a
(mystream)  → b
(mystream)  → c

Poiché "pop" funziona su entrambe liste e stringhe, la stessa funzione può essere utilizzata per un flusso di stringhe:

(set 'str "abcddefgh")
(define mystream (make-stream str))

(mystream)  → "a"
(mystream)  → "c"


=====================
 10. TEXT PROCESSING
=====================

Espressioni regolari
====================
Le espressioni regolari in newLISP possono essere utilizzate in numerose funzioni:

Function      Description
--------      -----------
directory     Return a list of files whose names match a pattern.
ends-with     Test if a string ends with a key string or pattern.
find          Find the position of a pattern.
find-all      Assemble a list of all patterns found.
parse         Break a string into tokens at patterns found between tokens.
regex         Find patterns and returns a list of all sub patterns found, with offset and length.
replace       Replace found patterns with a user defined function, which can take as input the patterns themselves.
search        Search for a pattern in a file.
starts-with   Test if a string starts with a key string or pattern.

Funzione      Descrizione
--------      --------------------
directory     Restituisce una lista di file i cui nomi corrispondono a un modello (pattern).
ends-with     Verifica se una stringa termina con una stringa chiave o un modello.
find          Trova la posizione di un modello.
find-all      Crea una lista di tutti i modelli trovati.
parse         Divide una stringa in token in corrispondenza dei modelli trovati tra i token.
regex         Trova modelli e restituisce una lista di tutti i modelli secondari trovati, con indici (offset) e lunghezza.
replace       Sostituisce i modelli trovati con una funzione definita dall'utente, che può prendere come input i modelli stessi.
search        Cerca un modello in un file.
starts-with   Verifica se una stringa inizia con una stringa chiave o un modello.

Le funzioni "find", "regex", "replace" e "search" memorizzano i risultati di pattern matching nelle variabili di sistema da $0 a $15.
Vedere il Manuale Utente di newLISP per i dettagli.

I paragrafi seguenti mostrano gli algoritmi utilizzati di frequente per la scansione e la tokenizzazione del testo.

Scansione del testo
===================
La funzione di "replace", insieme a un modello di espressione regolare, può essere utilizzata per eseguire la scansione del testo.
Il modello in questo caso descrive i token da analizzare.
Quando ogni token viene trovato, viene inserito in una lista.
Il lavoro viene svolto nella parte dell'espressione di sostituzione di replace.
Questo esempio salva tutti i file collegati a una pagina web:

#!/usr/bin/newlisp

; tokenizzare utilizzando "replace" con espressioni regolari
; i nomi sono nella forma <a href="example.lsp">example.lsp</a>

(set 'page (get-url "http://newlisp.digidep.net/scripts/"))
(replace {>(.*lsp)<} page (first (push $1 links)) 0) ; vecchia tecnica
;(set 'links (find-all {>(.*lsp)<} page $1)) ; nuova tecnica

(dolist (fname links)
   (write-file fname (get-url (append "http://newlisp.digidep.net/scripts/" fname)))
   (println "->" fname))

(exit)

Le parentesi graffe ({,}) vengono utilizzate nel modello delle espressioni regolari per evitare di dover eseguire l'escape delle virgolette ("") o di altri caratteri che hanno significati speciali nelle espressioni regolari.

La seguente tecnica alternativa è ancora più breve.
La funzione "find-all" inserisce tutte le stringhe corrispondenti in una lista:

(set 'links (find-all {>(.*lsp)<} page $1)) ; nuova tecnica

In un'espressione aggiuntiva "find-all" può essere indirizzato a fare ulteriore lavoro con le sottoespressioni trovate:

(find-all {(new)(lisp)} "newLISPisNEWLISP" (append $2 $1) 1)
→ ("LISPnew" "LISPNEW")

Nell'ultimo esempio, "find-all" aggiunge le sottoespressioni trovate in ordine inverso prima di restituirle nella lista dei risultati.

Un'altra tecnica per la tokenizzazione del testo utilizza "parse".
Mentre con "replace" e "find-all" l'espressione regolare definisce il token, quando si utilizza "parse", il modello di regex descrive lo spazio tra i token:

; tokenizzare usando parse
(set 'str "1 2,3,4 5, 6 7  8")
(parse str {,\ *|\ +,*} 0)
→ ("1" "2" "3" "4" "5" "6" "7" "8")

Senza le parentesi graffe nel modello di analisi, le barre rovesciate dovrebbero essere raddoppiate.
Notare che c'è uno spazio dopo ogni barra rovesciata (backslash).

Aggiunta di stringhe
====================
Quando si aggiungono stringhe, è possibile utilizzare "append" e "join" per formare una nuova stringa:

(set 'lstr (map string (rand 1000 100)))
→ ("976" "329" ... "692" "425")

; il modo lento e sbagliato
(set 'bigStr "")
(dolist (s lstr)
    (set 'bigStr (append bigStr s)))

; modo più intelligente: 50 volte più veloce
(apply append lstr)

A volte le stringhe non sono prontamente disponibili in una lista come negli esempi precedenti.
In questo caso può essere utilizzato "push" per inserire stringhe in una lista mentre vengono prodotte.
L'elenco può quindi essere utilizzato come argomento per "join", che è il metodo più veloce per mettere insieme le stringhe da pezzi esistenti:

; modo più intelligente - 300 volte più veloce
; unire una lista esistente di stringhe
(join lstr) → "97632936869242555543 ...."

; join può specificare una stringa tra gli elementi
; che li unisce
(join lstr "-") → "976-329-368-692-425-555-43 ...."

Stringhe che crescono
=====================
Spesso è meglio far crescere (aumentare) una stringa sul posto.
La funzione "extend" può essere utilizzata per aggiungere ad una stringa alla fine.
La funzione "push" può essere utilizzata per inserire nuovi contenuti in qualsiasi punto della stringa.

; modo più intelligente - molto più veloce su grandi stringhe
; aumenta una stringa sul posto utilizzando extend
(set 'str "")
(extend str "AB" "CD")
str → "ABCD"

; ; estendere sul posto
(set 'L '(a b "CD" (e f)))
(extend (L 2) "E")
L → (a b "CDE" (e f))

; usare push
(set 'str "")
(push "AB" str -1)
(push "CD" str -1)
str → "ABCD"

Riorganizzare le stringhe
=========================
La funzione "select", utilizzata per selezionare gli elementi dalle liste, funzonaa anche per selezionare e riorganizzare i caratteri delle stringhe:

(set 'str "eilnpsw")
(select str '(3 0 -1 2 1 -2 -3)) → "newlisp"

; sintassi alternativa
(select str 3 0 -1 2 1 -2 -3) → "newlisp"

La seconda sintassi è utile quando gli indici non sono specificati come costanti, ma si presentano come variabili.

Modifica delle stringhe
=======================
newLISP ha diverse funzioni che possono modificare in modo distruttivo una stringa:

Function  Description
--------  -----------
extend    Extend a string with another string.
push pop  Insert or extract one or more characters at a specific position.
replace   Replace all occurrences of a string or string pattern with a string.
setf      Replace a character in a string with one or more characters.

Funzione  Descrizione
--------  -----------
extend    Estende una stringa con un'altra stringa
push pop  Inserisce o estrae uno o più caratteri alle posizioni (indici) specificate
replace   Sostituisce tutte le occorrenze di una stringa o di un modello di stringa con una stringa.
setf      Sostituisce un carattere in una stringa con uno o più caratteri.

"replace" può essere utilizzato anche per rimuovere tutte le occorrenze di stringa o modello di stringa quando si specifica una stringa vuota "" come sostituzione.

Quando si indicizzano stringhe con nth o con l'indicizzazione implicita, la stringa viene indicizzata con i limiti dei caratteri anziché con i byte per funzionare correttamente sulle versioni UTF-8 di newLISP.
Un carattere UTF-8 può contenere più di un byte.


======================
 11. DIZIONARI E HASH
======================

Hash-like chiave → valore
=========================
newLISP ha funzioni per creare e manipolare simboli usando la funzione "sym" e una sintassi speciale del funtore di contesto.
Nelle versioni precedenti di newLISP, queste funzioni venivano utilizzate per programmare la creazione di tipo hash e l'accesso a coppie chiave-valore.
Ora è disponibile un metodo più breve e più conveniente, utilizzando il funtore di default non inizializzato di un contesto di spazio dei nomi (context):

(define Myhash:Myhash) ; definisce lo spazio dei nomi (contesto) e il funtore di default

In alternativa ai metodi precedenti, possiamo usare la funzione "Tree" per instanziare un nuovo contesto e il relativo funtore di default:

(new Tree 'Myhash)

Entrambi i metodi producono lo stesso risultato, ma il secondo metodo protegge anche il funtore di default Myhash: Myhash dalle modifiche.

(Myhash "var" 123) ; crea e imposta una coppia chiave/valore

(Myhash "var") → 123 ; recupera il valore

(Myhash "foo" "hello")

(Myhash "bar" '(q w e r t y))

(Myhash "!*@$" '(a b c))

; anche i numeri possono essere utilizzati e saranno convertiti internamente in stringhe

(Myhash 555 42)

(Myhash 555) → 42

Impostare un simbolo di un hash a nil lo elimina effettivamente:

(Myhash "bar" nil)

La chiave può essere qualsiasi stringa.
newLISP impedisce conflitti con i simboli newLISP integrati (built-in) anteponendo internamente un carattere di sottolineatura (_) a tutte stringhe chiave.
Il valore può essere qualsiasi stringa, numero o una s-epressione di newLISP.

Lo spazio dei nomi Myhash può essere trasformato in una lista di associazioni:

(Myhash) → (("!*@$" (a b c)) ("foo" "hello") ("var" 123))

Oppure i contenuti grezzi di Myhash possono essere visualizzati utilizzando la funzione "symbols":

(symbols Myhash) → (Myhash:Myhash Myhash:_!*@$ Myhash:_foo Myhash:_var)

I dizionari possono essere creati convertendo una lista di associazioni esistente:

(set 'aList '(("one" 1) ("two" 2) ("three")))

(Myhash aList)

(Myhash) → (("!*@$" (a b c)) ("foo" "hello") ("one" 1) ("three" nil) ("two" 2) ("var" 123))

Salvataggio e caricamento di dizionari
======================================
Il dizionario può essere facilmente salvato in un file serializzando lo spazio dei nomi Myhash:

(save "Myhash.lsp" 'Myhash)

L'intero spazio dei nomi viene salvato nel file Myhash.lsp e può essere ricaricato in newLISP in un secondo momento:

(load "Myhash")

Nota che gli hash creano contesti simili alla funzione "bayes-train".
Tutte le chiavi delle stringhe sono precedute da un trattino basso "_" (underscore) e quindi trasformate in un simbolo.
Ciò significa che gli spazi dei nomi creati utilizzando "bayes-train" possono essere utilizzati come hash per recuperare le parole e le loro statistiche.
Vedere la funzione "bayes-train" nel manuale per maggiori dettagli.


==========================
 12. TCP/IP client server
==========================

Connessione aperta
==================
In questo modello il server mantiene la connessione aperta fino a quando il client non chiude la connessione, quindi il server esegue il loop in una nuova "net-accept":

; sender listens
(constant 'max-bytes 1024)
(if (not (set 'listen (net-listen 123)))
    (print (net-error)))
(while (not (net-error))
    (set 'connection (net-accept listen)) ; blocking here
    (while (not (net-error))
         (net-receive connection message-from-client max-bytes)
         .... process message from client ...
         .... configure message to client ...
         (net-send connection message-to-client))
)

e il client:

; client connects to sender
(if (not (set 'connection (net-connect "host.com" 123)))
    (println (net-error)))
; maximum bytes to receive
(constant 'max-bytes 1024)
; message send-receive loop
(while (not (net-error))
     .... configure message to server ...
     (net-send connection message-to-server)
     (net-receive connection message-from-server max-bytes)
     .... process message-from-server ...
)

Connesione chiusa
=================
In questo modello il server chiude la connessione dopo ogni scambio di messaggi di transazione:

; sender
(while (not (net-error))
    (set 'connection (net-accept listen)) ; blocking here
    (net-receive connection message-from-client max-bytes)
        .... process message from client ...
        .... configure message to client ...
    (net-send connection message-to-client)
    (close connection)
)

e il client prova di nuovo a connettersi al sender:

; client
(unless (set 'connection (net-connect "host.com" 123))
    (println (net-error))
    (exit))
; numero massimo di byte da ricevere
(constant 'max-bytes 1024)
  .... configure message to server ...
(net-send connection message-to-server)
(net-receive connection message-from-server max-bytes)
  .... process message-from-server ...

Esistono molti modi diversi per impostare una connessione client/server, vedere anche gli esempi nel manuale newLISP.


=======================
 13. Comunicazioni UDP
=======================

Sono veloci e richiedono una configurazione inferiore rispetto a TCP/IP e offrono il multi casting.
UDP è anche meno affidabile perché il protocollo esegue meno controlli, per esempio sulla corretta sequenza dei pacchetti o se vengono ricevuti tutti i pacchetti.
Normalmente questo non è un problema quando non si lavora su Internet ma in una rete locale ben controllata o quando si esegue controlla una macchina.
Un protocollo più semplice e specifico potrebbe essere incluso nel messaggio.

Connessione aperta
==================
In questo esempio il server mantiene la connessione aperta.
Le comunicazioni UDP con "net-listen", "net-receive-from" e "net-send-to" possono bloccarsi in ricezione.

Notare che sia il client che il server utilizzano "net-listen" con l'opzione "udp".
In questo caso "net-listen" utilizzato solo per associare il socket all'indirizzo, non viene utilizzato per l'ascolto di una connessione.
Il server potrebbe ricevere messaggi da diversi client.
La funzione "net-send-to" estrae l'indirizzo di destinazione dal messaggio ricevuto.

Il sender:

; sender
(set 'socket (net-listen 10001 "localhost" "udp"))
(if socket (println "server listening on port " 10001)
   (println (net-error)))
(while (not (net-error))
    (set 'msg (net-receive-from socket 255))
    (println "-> " msg)
    (net-send-to (first (parse (nth 1 msg) ":"))
                 (nth 2 msg) (upper-case (first msg)) socket))
(exit)

e il client:

(set 'socket (net-listen 10002 "" "udp"))
(if (not socket) (println (net-error)))
(while (not (net-error))
    (print "enter something -> ")
    (net-send-to  "127.0.0.1" 10001 (read-line) socket)
    (net-receive socket buff 255)
    (println "=> " buff))
(exit)

Connessione chiusa
==================
Questo modulo viene talvolta utilizzato per controllare hardware o apparecchiature.
Non è richiesta alcuna configurazione, solo una funzione per l'invio, un'altra per la ricezione.

; attende per un data gram con 20 byte al massimo
(net-receive-udp 1001 20)
; o
(net-receive-udp 1001 20 5000000)  ; aspetta al massimo per 5 secondi
; sender
(net-send-udp "host.com" 1001 "Hello")

Win32 e Unix mostrano un comportamento diverso quando inviano più o meno byte di quelli specificati all'estremità ricevente.

Comunicazioni multi-cast
=========================
In questo schema il server si abbona a uno di una gamma di indirizzi multi cast utilizzando la funzione "net-listen".

; esempio server
(net-listen 4096 "226.0.0.1" "multi") → 5
(net-receive-from 5 20)

; esempio client I
(net-connect "226.0.0.1" 4096 "multi") → 3
(net-send 3 "hello")
; esempio client II
(net-connect "" 4096 "multi") → 3
(net-send-to "226.0.0.1" 4096 "hello" 3)

La connessione nell'esempio si sta bloccando su "net-receive", ma potrebbe essere sbloccata usando "net-select" o "net-peek".


=================================
 14. COMUNICAZIONI NON BLOCCANTI
=================================

Utilizzando net-select
======================
In tutti i modelli precedenti il client si blocca quando è in ricezione.
La chiamata "net-select" può essere utilizzata per sbloccare le comunicazioni:

; pool facoltativo per i dati in arrivo con timeout di 100 ms
(while (not (net-select connection "r" 100000))
    (do-something-while-waiting ...))

(net-receive...)

connessione può essere un singolo numero per un socket di connessione o una lista di numeri da attendere su vari sockets.

Utilizzando net-peek
====================
"net-peek" restituisce il numero di caratteri in attesa da leggere.

(while ( = (net-peek aSock) 0)
    (do-something-while-waiting ...))

(net-receive...)


====================================
 15. CONTROLLARE ALTRE APPLICAZIONI
====================================

Utilizzando exec
================
Questo metodo è adatto solo per scambi brevi, l'esecuzione di un comando e la ricezione dell'output.

> (exec "ls *.c")
("newlisp.c" "nl-debug.c" "nl-filesys.c" "nl-import.c" "nl-list.c" "nl-liststr.c"
 "nl-math.c" "nl-matrix.c" "nl-sock.c" "nl-string.c" "nl-symbol.c" "nl-utf8.c" "nl-web.c"
 "nl-xml-json.c" "pcre-chartables.c" "pcre.c" "unix-lib.c" "win-dll.c" "win-path.c"
 "win-util.c")
>

La funzione exec apre una processo pipe per l'utilità della riga di comando Unix ls e raccoglie ogni riga di STDOUT in una lista di stringhe.

La maggior parte degli esempi seguenti utilizza "process" per avviare un'applicazione.
Questa funzione ritorna immediatamente dopo aver avviato l'altra applicazione e non è bloccante.

In tutti i seguenti modelli il server non è indipendente, ma controllato dal client, che avvia il server e quindi comunica tramite un protocollo orientato alla linea:

      → avvia server
      → parla al server
      ← attende risposta dal server
      → parla al server
      ← attende la risposta dal server
           ...
A volte è necessario un tempo di sospensione sul lato client per attendere che il server sia pronto per il caricamento.
Ad eccezione del primo esempio, la maggior parte di questi sono frammenti condensati del codice di GTK-Server da [http://www.gtk-server.org www.gtk-server.org].
La logica di base del programma sarà la stessa per qualsiasi altra applicazione.

Pipe STD I/O
============
La funzione "process" consente di specificare 2 pipe per comunicare con l'applicazione avviata.

; imposta la comunicazione
(map set '(myin tcout) (pipe))
(map set '(tcin myout) (pipe))
(process "/usr/bin/wish" tcin tcout)

; crea GUI
(write myout
[text]
wm geometry . 250x90
wm title . "Tcl/Tk and newLISP"
bind . <Destroy> {puts {(exit)}}
[/text])

; esegue il ciclo degli eventi (run event loop)
(while (read-line myin)
    (eval-string (current-line))
)

Questo è il modo migliore per impostare comunicazioni bidirezionali durature con le utilità della riga di comando Unix e i linguaggi.
Per gli scambi con un solo comando, la funzione "exec" fa il lavoro più brevemente.

Per un esempio Tcl/Tk più elaborato, vedere l'applicazione examples/tcltk.lsp nella distribuzione dei sorgenti.

Comunicazione tramite TCP/IP
============================
; Definisce le funzioni di comunicazione
(define (gtk str , tmp)
    (net-send connection str)
    (net-receive connection tmp 64)
    tmp)

; Avvia il gtk-server
(process "gtk-server tcp localhost:50000")
(sleep 1000)

; Connssione con il gtk-server
(set 'connection (net-connect "localhost" 50000))
(set 'result (gtk "gtk_init NULL NULL"))
(set 'result (gtk "gtk_window_new 0"))
               .....

Comunicazione tramite FIFO con nome
===================================
Creare prima un FIFO (assomiglia a un file nodo speciale):

(exec "mkfifo myfifo")

oppure in modo alternativo:

(import "/lib/libc.so.6" "mkfifo")
(mkfifo "/tmp/myfifo" 0777)

; Definisce le funzioni di comunicazione
(define (gtk str)
  (set 'handle (open "myfifo" "write"))
  (write handle str)
  (close handle)
  (set 'handle (open "myfifo" "read"))
  (read handle tmp 20)
  (close handle)
tmp)

Comunicazione tramite UDP
=========================
Notare che la funzione di ascolto con l'opzione "udp" associa semplicemente i socket a un indirizzo/hardware, ma non ascolta effettivamente come in TCP/IP.

; Definisce le funzioni di comunicazione
(define (gtk str , tmp)
(net-send-to "localhost" 50000 str socket)
(net-receive socket 'tmp net-buffer)
tmp)

; Avvia il gtk-server
(define (start)
  (process "gtk-server udp localhost:50000")
  (sleep 500)
  (set 'socket (net-listen 50001 "localhost" "udp")) )

(set 'result (gtk "gtk_init NULL NULL"))

(set 'result (gtk "gtk_window_new 0"))
.....


=====================================
 16. ESEGUIRE APPLICAZIONI BLOCCANTI
=====================================

Esecuzione della shell
======================
Questo è spesso usato dalla riga di comando interattiva di newLISP per eseguire processi in modo bloccante, che richiedono una shell per essere eseguiti:

(! "ls -ltr")

Esiste una variante interessante di questa forma che non funziona all'interno di un'espressione newLISP, ma solo sulla riga di comando:

!ls -ltr

Il ! dovrebbe essere il primo carattere sulla riga di comando.
Questo forma agisce come la shell di escape nell'editor VI.
È utile per richiamare un editor o eseguire operazioni veloci sulla shell senza lasciare completamente la console di newLISP.

Catturare std-out
=================
(exec "ls /") → ("bin" "etc" "home" "lib")

Alimentare std-in
=================
(exec "script.cgi" cgi-input)

In questo esempio cgi-input potrebbe contenere una stringa che alimenta un input di query, normalmente proveniente da un server web.
Notare che l'output in questo caso viene scritto direttamente sullo schermo e non può essere restituito a newLISP.
Utilizzare "process" e "pipe" per comunicazioni i/o standard bidirezionali con altre applicazioni.


=================================
 17. SEMAFORI, MEMORIA CONDIVISA
=================================

Memoria condivisa (shared memory), semafori e processi lavorano frequentemente insieme.
I semafori possono sincronizzare le attività in diversi thread di processo e la memoria condivisa può essere utilizzata per comunicare tra di loro.

Quello che segue è un esempio più complesso che mostra il funzionamento di tutti e tre i meccanismi contemporaneamente.

Il produttore esegue il ciclo di tutti gli n valori da i = 0 a n - 1 e inserisce ogni valore nella memoria condivisa dove viene raccolto dal thread del consumatore.
I semafori vengono utilizzati per segnalare che un valore di dati è pronto per la lettura.

Sebbene il controllo dei processi con semafori e memoria condivisa sia veloce, è anche soggetto a errori, specialmente quando sono coinvolti più processi.
È più facile controllare più processi utilizzando l'API Cilk e la messaggistica tra i processi.
Vedere i capitoli 18. e 19. per questi argomenti.

#!/usr/bin/newlisp
# prodcons.lsp -  Producer/consumer
# produttore/consumatore
#
# usage of 'fork', 'wait-pid', 'semaphore' and 'share'

(when (= ostype "Win32")
    (println "this will not run on Win32")
    (exit))

(constant 'wait -1 'sig 1 'release 0)

(define (consumer n)
    (set 'i 0)
    (while (< i n)
        (semaphore cons-sem wait)
        (println (set 'i (share data)) " <-")
        (semaphore prod-sem sig))
    (exit))

(define (producer n)
    (for (i 1 n)
        (semaphore prod-sem wait)
        (println "-> " (share data i))
        semaphore cons-sem sig))
    (exit))

(define (run n)
    (set 'data (share))
    (share data 0)
    (set 'prod-sem (semaphore)) ; ottiene semafori
    (set 'cons-sem (semaphore))
    (set 'prod-pid (fork (producer n))) ; avvia processi
    (set 'cons-pid (fork (consumer n)))
    (semaphore prod-sem sig) ; avvia il produttore
    (wait-pid prod-pid) ; attende la fine dei processi
    (wait-pid cons-pid)
    (semaphore cons-sem release) ; rilascia semafori
    (semaphore prod-sem release))

(run 10)

(exit)


============================
 18. MULTIPROCESSING E CILK
============================

Sulle CPU multiprocessore il sistema operativo distribuirà processi e processi figlio creati su diversi core del processore in modo ottimizzato.
newLISP offre una semplice API che fa tutto il lavoro di avvio dei processi e fa la raccolta sincronizzata dei risultati della valutazione.
L'API Cilk consiste di sole 3 chiamate di funzione, implementate in newLISP come "spawn", "sync" e "abort".

Dalla v.10.1 la funzione di messaggio di newLISP abilita le comunicazioni tra i processi padre e figlio.
Per maggiori dettagli su questo, vedere il prossimo capitolo 19. Scambio di messaggi.

Nota: questa funzionalità non è disponibile in windows.

Avvio di processi concorrenti
=============================
; calcola i numeri primi in un intervallo
(define (primes from to)
    (let (plist '())
    (for (i from to)
        (if (= 1 (length (factor i)))
        (push i plist -1)))
plist))

; avvia i processi figli
(set 'start (time-of-day))

(spawn 'p1 (primes 1 1000000))
(spawn 'p2 (primes 1000001 2000000))
(spawn 'p3 (primes 2000001 3000000))
(spawn 'p4 (primes 3000001 4000000))

; attende un massimo di 60 secondi per il completamento di tutte le attività
(sync 60000) ; restituisce vero se tutto è finito in tempo
; p1, p2, p3 e p4 ora contengono ciascuno una lista di numeri primi

L'esempio mostra come il compito di generare un intervallo di numeri primi possa essere organizzato per l'elaborazione parallela suddividendo l'intervallo in sottointervalli.
Tutte le chiamate di "spawn" torneranno immediatamente, ma la sincronizzazione si bloccherà fino a quando tutti i processi figli non saranno terminati e gli elenchi dei risultati saranno disponibili nelle quattro variabili da p1 a p4.

Monitorare i progressi
======================
Quando il valore di timeout specificato è troppo breve per il completamento di tutti i processi, la sincronizzazione restituirà zero.
Questo può essere usato per monitorare i progressi:

; stampa un punto dopo ogni 2 secondi di attesa
(until (sync 2000) (println "."))

Quando la sincronizzazione viene chiamata senza parametri, restituisce una lista con gli ID processo ancora attivi:

; mostra una lista di ID di processo in sospeso dopo
; ogni tre decimi di secondo
(until (sync 300) (println (sync)))

Invocare spawn in modo ricorsivo
================================
(define (fibo n)
    (let (f1 nil f2 nil)
        (if (< n 2) 1
            (begin
                (spawn 'f1 (fibo (- n 1)))
                (spawn 'f2 (fibo (- n 2)))
                (sync 10000)
                (+ f1 f2)))))

(fibo 7)  → 21

Notifica guidata dagli eventi
=============================
Quando i processi vengono avviati con "spawn" finiscono, è possibile chiamare una funzione specificata nell'istruzione sync.

(define (report pid)
    (println "process: " pid " has returned"))

; chiama la funzione report, quando ritorna un processo figlio
(sync 10000 report)


=========================
 19. SCAMBIO DI MESSAGGI
=========================

I processi padre e figlio avviati con "spawn" possono scambiare messaggi.
I messaggi fluiscono dai genitore ai processi figli o dai processi figli ai genitore.
Mediante la valutazione dei messaggi nel processo genitore, il processo genitore può essere utilizzato come un proxy di instradamento dei messaggi tra i figli.

Internamente newLISP utilizza i socket UNIX di dominio locale per doppie code di messaggi tra i processi padre e figlio.
Quando il lato ricevente di una coda è vuoto, una chiamata "receive" restituirà nil.
Allo stesso modo, quando una coda è piena, una chiamata "send" restituirà nil.
Il ciclo "until" può essere utilizzato per rendere "send" e "receive" istruzioni bloccanti.


Blocco dell'invio e della ricezione di messaggi
===============================================
     ; blocco del sender
     (until (send pid msg))     ; vero quando un messaggio è in coda

     ; blocco del receiver
     (until (receive pid msg))  ; vero dopo la lettura di un messaggio

Blocco dello scambio di messaggi
================================
Il processo padre esegue un ciclo attraverso tutti gli ID dei processi figlio e utilizza la forma (until (receive cpid msg)) come forma di "receive" per attendere i messaggi in sospeso.
(sync) restituisce una lista con tutti i PID figlio dei processi avviati da spawn.

#!/usr/bin/newlisp

; il processo figlio trasmette numeri casuali
(define (child-process)
    (set 'ppid (sys-info -4)) ; acquisisce il pid (process id) del genitore
    (while true
        (until (send ppid (rand 100))))
)

; genitore avvia 5 processi figlio, ascolta e visualizza
; il flag true consente l'utilizzo di "send" e "receive"
(dotimes (i 5) (spawn 'result (child-process) true))

(for (i 1 3)
    (dolist (cpid (sync)) ; itera attraverso i pid figlio in sospeso
        (until (receive cpid msg))
        (print "pid:" cpid "->>" (format "%-2d  " msg)))
    (println)
)

(abort) ; elimina i processi figlio
(exit)

Genera questo output:

pid:53181->47  pid:53180->61  pid:53179->75  pid:53178->39  pid:53177->3
pid:53181->59  pid:53180->12  pid:53179->20  pid:53178->77  pid:53177->47
pid:53181->6   pid:53180->56  pid:53179->96  pid:53178->78  pid:53177->18

Scambio di messaggi non bloccante
=================================
Né il processo figlio mittente né il processo padre ricevente si bloccano.
Ciascuno invia e riceve messaggi il più velocemente possibile.
Non vi è alcuna garanzia che tutti i messaggi verranno recapitati.
Dipende dalle dimensioni della coda di invio e dalla velocità di raccolta dei messaggi da parte del processo padre.
Se la coda di invio per un processo figlio è piena, la chiamata (send ppid (rand 100)) fallirà e restituirà nil.

#!/usr/bin/newlisp

; il processo figlio trasmette numeri casuali non bloccanti
; non tutte le chiamate vanno a buon fine
(set 'start (time-of-day))

(define (child-process)
    (set 'ppid (sys-info -4)) ; acquisisce il pid del genitore
    (while true
        (send ppid (rand 100)))
)

; genitore avvia 5 processi figlio, ascolta e visualizza
(dotimes (i 5) (spawn 'result (child-process) true))

(set 'N 1000)

(until finished
    (if (= (inc counter) N) (set 'finished true))
    (dolist (cpid (receive)) ; itera attraverso i pid figlio in sospeso
        (receive cpid msg)
    (if msg (print "pid:" cpid "->" (format "%-2d  \r" msg))))
)

(abort) ; elimina i processi figlio
(sleep 300)

(exit)

Timeout dei messaggi
====================
È possibile creare una'istruzione di messaggio bloccante per un certo tempo:

(define (receive-timeout pid msec)
    (let ( (start (time-of-day)) (msg nil))
        (until (receive pid msg)
            (if (> (- (time-of-day) start) 1000) (throw-error "timeout")))
    msg)
)
; use it

(receive-timeout pid 1000)  ; ritorna un messaggio o genera un errore

In questo esempio il blocco avverrà per 1000 ms.
Esistono molti metodi per implementare il comportamento di timeout.

Valutazione dei messaggi
========================
I messaggi inviati possono contenere espressioni che possono essere valutate nell'ambiente del destinatario.
In questo modo le variabili possono essere impostate nell'ambiente del valutatore e i messaggi possono essere indirizzati ad altri processi.
L'esempio seguente implementa un router di messaggi:

#!/usr/bin/newlisp

; processo figlio sender del messaggio
(set 'A (spawn 'result
    (begin
        (dotimes (i 3)
            (set 'ppid (sys-info -4))
            ; la seguente espressione in msg sarà valutata nel ciclo proxy
            (set 'msg '(until (send B (string "greetings from " A))))
            (until (send ppid msg)))
        (until (send ppid '(begin
            (sleep 200) ; assicura che tutto il resto sia stampato
            (println "parent exiting ...\n")
            (set 'finished true))))) true))

; processo figlio receiver del messaggio
(set 'B (spawn 'result
    (begin
        (set 'ppid (sys-info -4))
        (while true
            (until (receive ppid msg))
            (println msg)
            (unless (= msg (string "greetings from " A))
                (println "ERROR in proxy message: " msg)))) true))

(until finished (if (receive A msg) (eval msg))) ; ciclo proxy

(abort)
(exit)

Agire come proxy
================
Nell'ultimo programma di esempio l'espressione:

; contenuto del messaggio da valutare tramite proxy
(until (send B (string "greetings from " A)))

Un'istruzione di programmazione inviata dall'ID del processo figlio A al genitore, dove viene valutata, causa l'invio di un messaggio al processo figlio B.
Il processo genitore funge da agente proxy per il processo figlio A.

; l'istruzione impostata viene valutata nel proxy
(until (send ppid '(set 'finished true)))

L'espressione (set 'finished true) viene inviata al genitore dove viene valutata e provoca la fine del ciclo "until" del genitore.

L'istruzione "sleep" nel processo A garantisce che il messaggio "parent exiting ..." non venga visualizzato prima che tutti i messaggi ricevuti siano segnalati dal processo identificato con B.


==================================
 20. DATABASE E TABELLE DI LOOKUP
==================================

Per tabelle più piccole di non più di qualche centinaio di voci possono essere utilizzate liste di associazione.
Per database più grandi utilizzare dizionari e hash come descritto nel capitolo 11.

Liste di associazioni
=====================
La lista delle associazioni è una classica struttura dati LISP per la memorizzazione delle informazioni per il recupero associativo:

; creazione di liste di associazioni
; inserire alla fine con -1 è ottimizzata ed
; è veloce come inserire all'inizio della lista
(push '("John Doe" "123-5555" 1200.00) Persons -1)
(push '("Jane Doe" "456-7777" 2000.00) Persons -1)
.....

Persons →  (
("John Doe" "123-5555" 1200.00)
("Jane Doe" "456-7777" 2000.00) ...)

; access/lookup record di dati
(assoc "John Doe" Persons)

→ ("John Doe" "123-5555" 1200.00 male)

(assoc "Jane Doe" Persons)

→ ("Jane Doe" "456-7777" 2000.00 female)

newLISP ha una funzione di "lookup" simile a quella utilizzata nel software per fogli di calcolo.
Questa funzione che agisce come una combinazione di "assoc" e "nth" può trovare l'associazione e, allo stesso tempo, selezionare un membro specifico del record di dati:

(lookup "John Doe" Persons 0)   → "123-555"
(lookup "John Doe" Persons -1)  → male
(lookup "Jane Doe" Persons 1)   → 2000.00
(lookup "Jane Doe" Persons -2)  → 2000.00

; aggiorna record di dati
(setf (assoc "John Doe" Persons)
    '("John Doe" "123-5555" 900.00 male))

; sostituire utilizzando dati esistenti/sostituiti
(setf (assoc "John Doe" Persons) (update-person $it))

; elimina record di dati
(replace (assoc "John Doe" Persons) Persons)

Associazioni annidate
=====================
Se la parte dati di un'associazione è essa stessa un elenco di associazioni, abbiamo un'associazione nidificata:

(set 'persons '(
    ("Anne" (address (country "USA") (city "New York")))
    ("Jean" (address (country "France") (city "Paris")))
))

È possibile utilizzare una sintassi diversa della funzione "assoc" per specificare più chiavi:

; una chiave (key)
(assoc "Anne" persons) → ("Anne" (address (country "USA") (city "New York")))

; due chiavi
(assoc '("Anne" address) persons) → (address (country "USA") (city "New York"))

; tre chiavi
(assoc '("Anne" address city) persons) → (city "New York")

; tre chiavi in un vettore
(set 'anne-city '("Anne" address city))
(assoc anne-city persons) → (city "New York")

Quando tutte le chiavi sono simboli, come nell'indirizzo, il paese e la città, le associazioni semplici e nidificate in newLISP hanno lo stesso formato degli oggetti newLISP FOOP (Functional Object Oriented Programming).
Vedere il capitolo del manuale utente "18. Programmazione funzionale orientata agli oggetti" per i dettagli.

Aggiornamento delle associazioni annidate
=========================================
Le funzioni "assoc" e "setf" possono essere utilizzate per aggiornare associazioni semplici o annidate:

(setf (assoc '("Anne" address city) persons) '(city "Boston")) → (city "New York")

"setf" restituisce sempre l'elemento appena impostato.

Combinazione di associazioni e hash
===================================
Gli hash e gli oggetti FOOP possono essere combinati per formare un database in memoria con accesso con chiave.

Nell'esempio seguente, i record di dati vengono archiviati in uno spazio dei nomi hash e l'accesso avviene con il nome della persona come chiave.

"setf" e "lookup" vengono utilizzati per aggiornare gli oggetti FOOP nidificati:

(new Tree 'Person)
(new Class 'Address)
(new Class 'City)
(new Class 'Telephone)

(Person "John Doe" (Address (City "Small Town") (Telephone 5551234)))

(lookup 'Telephone (Person "John Doe"))
(setf (lookup 'Telephone (Person "John Doe")) 1234567)
(setf (lookup 'City (Person "John Doe")) (lower-case $it))

(Person "John Doe") → (Address (City "small town") (Telephone 1234567))


=========================
 21. CALCOLO DISTRIBUITO
=========================

Molte delle applicazioni odierne vengono distribuite su più computer della rete o distribuite su più processi su una CPU.
Spesso vengono utilizzati contemporaneamente entrambi i metodi di distribuzione di un'applicazione.

newLISP dispone di funzionalità per valutare molte espressioni in parallelo su diversi nodi di rete o processi che eseguono newLISP.
La funzione "net-eval" fa tutto il lavoro necessario per comunicare con altri nodi, distribuire espressioni per la valutazione e raccogliere i risultati in modo bloccante o guidato dagli eventi.

Anche le funzioni "read-file", "write-file", "append-file" e "delete-file" possono essere utilizzate per accedere a file su nodi remoti quando si utilizzano URL nelle specifiche del file.
In modo simile, le funzioni "load" e "save" possono essere utilizzate per caricare e salvare codice da e verso nodi remoti.

newLISP utilizza i protocolli HTTP esistenti e il comportamento della riga di comando newLISP per implementare questa funzionalità.
Ciò significa che i programmi possono essere sottoposti a debug e testati utilizzando applicazioni Unix standard come il terminale, telnet o un browser web.
Ciò consente anche una facile integrazione di altri strumenti e programmi in applicazioni distribuite create con newLISP.
Ad esempio, l'utilità Unix netcat (nc) potrebbe essere utilizzata per valutare le espressioni in remoto oppure un browser Web potrebbe essere utilizzato per recuperare le pagine Web dai nodi che eseguono un nuovo server LISP.

Configurazione in modalità server
=================================
Un nodo del server newLISP è essenzialmente un processo newLISP che ascolta una porta di rete e si comporta come una console della riga di comando newLISP e un server HTTP per le richieste HTTP GET, PUT, POST e DELETE.
Dalla versione 9.1 la modalità server newLISP risponde anche alle query CGI ricevute da una richiesta GET o POST.

Vengono utilizzati due metodi per avviare un nodo server in newLISP.
Uno si traduce in un server state-full (con stato pieno), che mantiene lo stato tra le comunicazioni con client diversi, l'altro metodo un server senza stato (state-less), che si ricarica per ogni nuova connessione client.

Avviare un server state-full
============================
newlisp -c -d 4711 &

newlisp myprog.lsp -c -d 4711 &

newlisp myprog.lsp -c -w / home / node25 -d 4711 &

newLISP è ora in ascolto sulla porta 4711, il segno & (e commerciale) dice a newLISP di funzionare in background (solo Unix).
L'opzione -c elimina i prompt della riga di comando.
newLISP ora si comporta come una console newLISP senza prompt in ascolto sulla porta 4711 per input dalla riga di comando.
Si sarebbe potuto scegliere qualsiasi altra porta disponibile.
Nota che su Unix, le porte inferiori a 1024 richiedono diritti di accesso di amministratore.

Il secondo esempio precarica anche il codice.
Il terzo esempio specifica anche una cartella di lavoro utilizzando l'opzione -w.
Se non viene specificata alcuna cartella di lavoro utilizzando -w, si presume che la cartella di avvio sia la cartella di lavoro.

Dopo ogni transazione, quando una connessione si chiude, newLISP eseguirà un processo di ripristino, reinizializzerà stack e segnali e passerà al contesto MAIN.
Verranno conservati solo il contenuto del programma e dei simboli delle variabili.

Serve state-less con inetd
==========================
Su Unix le funzionalità inetd o xindetd possono essere utilizzate per avviare un server senza stato.
In questo caso le connessioni di rete TCP/IP sono gestite da una speciale utility Unix con la capacità di gestire più richieste contemporaneamente.
Per ogni connessione effettuata da un client, l'utilità inetd o xinetd avvierà un nuovo processo newLISP.
Dopo la chiusura della connessione, il processo newLISP verrà chiuso.

Quando ai nodi non viene richiesto di mantenere lo stato, questo è il metodo preferito per un nuovo nodo del server LISP, per gestire più connessioni contemporaneamente.

Il processo inetd o xinetd deve essere configurato utilizzando i file di configurazione che si trovano nella cartella /etc della maggior parte delle installazioni Unix.

Per entrambe le configurazioni inetd e xinetd aggiungere la seguente riga al file /etc/services:

  net-eval        4711/tcp     # richiesta newLISP net-eval

Si noti che potrebbe essere fornita qualsiasi altra porta oltre alla 4711.

Quando si configura inetd, aggiungere anche le seguenti righe al file /etc/inetd.conf:

  net-eval  stream  tcp  nowait  root  /usr/bin/newlisp -c

  # in alternativa un programma può essere precaricato

  net-eval  stream  tcp  nowait  root  /usr/bin/newlisp myprog.lsp -c

  # è possibile anche specificare una cartella di lavoro (working directory)

  net-eval  stream  tcp  nowait  newlisp  /usr/bin/newlisp -c -w /usr/home/newlisp

L'ultima riga specifica anche una cartella di lavoro e un utente newlisp invece dell'utente root.
Questa è una modalità più sicura che limita l'accesso al nodo del server newLISP ad un account utente specifico con autorizzazioni limitate.

Su alcuni sistemi Unix è possibile utilizzare una versione moderna di inetd: la funzionalità xinetd può essere utilizzata.
Aggiungi la seguente configurazione a un file /etc/xinet.d/net-eval:

service net-eval
    {
    socket_type = stream
    wait = no
    user = root
    server = /usr/bin/newlisp
    port = 4711
    server_args = -c -w /home/node
    }

Si noti che una varietà di combinazioni di parametri è possibile limitare l'accesso da luoghi diversi o limitare l'accesso a determinati utenti.
Consultare le pagine man di inetd e xinetd per i dettagli.

Dopo aver configurato inetd o xinetd, entrambi i processi devono essere riavviati per rileggere i file di configurazione.
Ciò può essere ottenuto inviando il segnale Unix HUP al processo inetd o xinetd utilizzando l'utilità Unix kill o nohup.

Su Mac OS X la funzione launchd può essere utilizzata in modo simile.
La distribuzione dei sorgenti newLISP contiene il file org.newlisp.newlisp.plist nella cartella util/.
Questo file può essere utilizzato per avviare il server newlisp durante l'avvio del sistema operativo come server persistente.

Test del server con telnet
===========================
Un nuovo nodo del server LISP può essere testato utilizzando l'utilità telnet di Unix:

telnet localhost 4711

; o quando si esegue su un computer diverso, ad esempio ip 192.168.1.100

telnet 192.168.1.100 4711

Le espressioni su più righe possono essere inserite racchiudendole in tag [cmd], [/cmd], con ogni tag su una riga separata.
Entrambi i tag di apertura e di chiusura devono essere su righe separate.
Sebbene newLISP abbia una seconda, nuova modalità multi-riga per la shell interattiva dalla versione 10.3.0 senza tag, quando si usa netcat o altre utilità Unix, le espressioni multi-riga devono ancora essere racchiuse nei tag [cmd], [/ cmd].

Test con netcat su Unix
=======================
echo '(symbols) (exit)' | nc localhost 4711

O parlando con un nodo remoto:

echo '(symbols) (exit)' | nc 192.168.1.100 4711

In entrambi gli esempi "netcat" restituirà il risultato della valutazione dei simboli dell'espressione.

Le espressioni su più righe possono essere inserite racchiudendole in tag [cmd], [/cmd], ogni tag su una riga separata.

Test dalla riga di comando
==========================
La funzione "net-eval" ha una forma di sintassi per connettersi a un solo nodo server remoto.
Questa modalità è pratica per test rapidi dalla riga di comando newLISP:

(net-eval "localhost" 4711 "(+ 3 4)" 1000) → 7

; a un nodo remoto

(net-eval "192.168.1.100" 4711 {(upper-case "newlisp")} 1000) → "NEWLISP"

Nel secondo esempio le parentesi graffe {,} vengono utilizzate per limitare la stringa per la valutazione.
In questo modo è possibile utilizzare le virgolette per limitare una stringa all'interno dell'espressione.

Non sono richiesti tag [cmd], [/ cmd] quando si inviano espressioni su più righe. "net-eval" fornisce questi tag automaticamente.

Test HTTP con un browser
========================

Un server newLISP gestisce anche semplici richieste HTTP GET e PUT.
Inserire il percorso completo di un file nella barra degli indirizzi del browser:

http://localhost:4711//usr/share/newlisp/doc/newlisp_manual.html

Il file del manuale ha una dimensione di quasi 800 Kbyte e impiegherà alcuni secondi per essere caricato nel browser.
Specificare il numero di porta con i due punti separati dal nome host o dall'IP host.
Notare la doppia barra necessaria per specificare un indirizzo di file relativo alla cartella principale (root directory).

Valutazione da remoto
=====================
Durante il test della corretta installazione dei nodi del server newLISP, stavamo già inviando le espressioni al nodo remoto per la valutazione.
Molte volte la valutazione remota viene utilizzata per suddividere un'attività lunga in sotto-attività più brevi per la valutazione remota su nodi diversi.

Il primo esempio è banale, perché valuta solo alcune espressioni molto semplici in remoto, ma dimostra facilmente i principi coinvolti:

#!/usr/bin/newlisp

(set 'result (net-eval '(
    ("192.168.1.100" 4711 {(+ 3 4)})
    ("192.168.1.101" 4711 {(+ 5 6)})
    ("192.168.1.102" 4711 {(+ 7 8)})
    ("192.168.1.103" 4711 {(+ 9 10)})
    ("192.168.1.104" 4711 {(+ 11 12)})
) 1000))

(println "result: " result)

(exit)

L'esecuzione di questo programma produrrà il seguente output:

result: (7 11 15 19 23)

Quando si esegue Unix e si utilizza un server newLISP configurato con "inetd" o "xinetd", i server e i programmi possono essere eseguiti su una sola CPU, sostituendo tutti i numeri IP con "localhost" o lo stesso numero IP locale.
Il demone di indetd o xinetd avvierà quindi 5 processi newLISP indipendenti.
Su Win32 devono essere avviati 5 server newLISP con stato completo su numeri di porta diversi per ottenere lo stesso risultato.

Invece di raccogliere tutti i risultati contemporaneamente sul ritorno di "net-eval", è possibile utilizzare una funzione di callback per ricevere ed elaborare i risultati non appena diventano disponibili:

#!/usr/bin/newlisp

(define (idle-loop p)
    (if p (println p)))

(set 'result (net-eval '(
    ("192.168.1.100" 4711 {(+ 3 4)})
    ("192.168.1.101" 4711 {(+ 5 6)})
    ("192.168.1.102" 4711 {(+ 7 8)})
    ("192.168.1.103" 4711 {(+ 9 10)})
    ("192.168.1.104" 4711 {(+ 11 12)})
) 1000 idle-loop))

(exit)

Mentre "net-eval" è in attesa di risultati, chiama ripetutamente la funzione idle-loop con il parametro p.
Il parametro p è nil se non è stato ricevuto alcun risultato durante gli ultimi 1000 millisecondi, oppure p contiene una lista inviata dal nodo remoto.
La lista contiene l'indirizzo remoto con la porta e il risultato della valutazione.
L'esempio mostrato genererebbe il seguente output:

("192.168.1.100" 4711 7)
("192.168.1.101" 4711 11)
("192.168.1.102" 4711 15)
("192.168.1.103" 4711 19)
("192.168.1.104" 4711 23)

Per i test su una sola CPU, sostituire gli indirizzi con "localhost".
Il demone Unix inetd o xinetd avvierà un processo separato per ogni connessione effettuata e tutti in ascolto sulla porta 4711.
Quando si utilizza un server state-full sulla stessa CPU su Win32, specificare un numero di porta diverso per ciascun server.

Impostazione della struttura dei parametri 'net-eval'
=====================================================
In un ambiente di rete in cui un'applicazione viene spostata o vengono utilizzati nodi server con numeri IP variabili, è necessario impostare i parametri del nodo nells lista dei parametri di "net-eval" come variabili.
Il seguente esempio più complesso mostra come ciò può essere fatto.
L'esempio mostra anche come un testo di un programma più grande può essere trasferito a un nodo remoto per la valutazione e come questo di programma può essere personalizzato in modo diverso per ciascun nodo:

#!/usr/bin/newlisp

; parametri dei nodi
(set 'nodes '(
    ("192.168.1.100" 4711)
    ("192.168.1.101" 4711)
    ("192.168.1.102" 4711)
    ("192.168.1.103" 4711)
    ("192.168.1.104" 4711)
))

; modello di programma per i nodi
(set 'program [text]
    (begin
        (map set '(from to node) '(%d %d %d))
        (for (x from to)
    (if (= 1 (length (factor x)))
        (push x primes -1)))
    primes)
[/text])

; routine di call-back per net-eval
(define (idle-loop p)
    (when p
        (println (p 0) ":" (p 1))
        (push (p 2) primes))
)

(println "Sending request to nodes, and waiting ...")

; le macchine potrebbero trovarsi su indirizzi IP diversi.
; Per questo test vengono avviati 5 nodi su localhost
(set 'result (net-eval (list
    (list (nodes 0 0) (nodes 0 1) (format program 0 99999 1))
    (list (nodes 1 0) (nodes 1 1) (format program 100000 199999 2))
    (list (nodes 2 0) (nodes 2 1) (format program 200000 299999 3))
    (list (nodes 3 0) (nodes 3 1) (format program 300000 399999 4))
    (list (nodes 4 0) (nodes 4 1) (format program 400000 499999 5))
) 20000 idle-loop))

(set 'primes (sort (flat primes)))
(save "primes" 'primes)

(exit)

All'inizio del programma una struttura della lista dei nodi contiene tutte le informazioni rilevanti sui nodi per nome host e porta.

Il programma calcola tutti i numeri primi in un dato intervallo.
Le variabili from, to e node sono configurate nel testo del programma utilizzando la funzione "format".
Tutte le istruzioni vengono inserite in un blocco di espressioni "begin", quindi solo un risultato dell'espressione verrà restituito dal nodo remoto.

Sono possibili molti altri schemi per configurare una lista di parametri di "net-eval".
Il seguente schema senza la funzione "idle-loop" darebbe gli stessi risultati:

(set 'node-eval-list (list
    (list (nodes 0 0) (nodes 0 1) (format program 0 99999 1))
    (list (nodes 1 0) (nodes 1 1) (format program 100000 199999 2))
    (list (nodes 2 0) (nodes 2 1) (format program 200000 299999 3))
    (list (nodes 3 0) (nodes 3 1) (format program 300000 399999 4))
    (list (nodes 4 0) (nodes 4 1) (format program 400000 499999 5))
))

(set 'result (net-eval node-eval-list  20000))

La funzione "idle-loop" aggrega tutte le liste di numeri primi ricevuti e genera il seguente output:

192.168.1.100:4711
192.168.1.101:4711
192.168.1.102:4711
192.168.1.103:4711
192.168.1.104:4711

Come negli esempi precedenti, tutti i numeri IP possono essere sostituiti con "localhost" o qualsiasi altro nome host o numero IP per testare un'applicazione distribuita su un singolo host prima della distribuzione in un ambiente distribuito con molti host in rete.

Trasferimento di file
=====================
I file possono essere letti o scritti su nodi remoti con le stesse funzioni utilizzate per leggere e scrivere file su un file-system locale.
Questa funzionalità è attualmente disponibile solo sui sistemi Unix quando si parla con i server newLISP.
Poiché le funzioni si basano sui protocolli HTTP standard GET e PUT, possono essere utilizzate anche per comunicare con i server web.
Si noti che poche installazioni di server Web Apache hanno abilitato il protocollo PUT per impostazione predefinita.

Le funzioni "read-file", "write-file" e "append-file" possono tutte prendere URL nelle loro specifiche di nome file per leggere e scrivere su nodi remoti che eseguono un server newLISP o un server web:

(write-file "http://127.0.0.1:4711//Users/newlisp/afile.txt" "The message - ")
→ "14 bytes transferred for /Users/newlisp/afile.txt\r\n"

(append-file "http://127.0.0.1:4711//Users/newlisp/afile.txt" "more text")
→ "9 bytes transferred for /Users/newlisp/afile.txt\r\n"

(read-file "http://127.0.0.1:4711//Users/newlisp/afile.txt")
→ "The message - more text"

Le prime due funzioni restituiscono un messaggio che inizia con il numero di byte trasferiti e il nome del file remoto interessato.
La funzione "read-file" restituisce i contenuti ricevuti.

In tutte le condizioni di errore verrebbe restituito un messaggio di errore che inizia con i caratteri "ERR:":

(read-file "http://127.0.0.1:4711//Users/newlisp/somefile.txt")
→ "ERR:404 File not found: /Users/newlisp/somefile.txt\r\n"

Notare la doppia barra rovesciata necessaria per fare riferimento ai file relativi alla radice sul nodo del server.

Tutte le funzioni possono essere utilizzate per trasferire contenuti binari non ascii contenenti zero caratteri.
Internamente newLISP usa le funzioni "get-url" e "put-url", che potrebbero essere usate al posto delle funzioni "read-file", "write-file" e "append-file".
Opzioni aggiuntive come quelle usate con "get-url" e "put-url" possono essere usate anche con le funzioni "read-file", "write-file" e "append-file".
Per maggiori dettagli, vedere il manuale di riferimento delle funzioni newLISP.

Caricamento e salvataggio dei dati
==================================
Le stesse funzioni di caricamento "load" e salvataggio "save" utilizzate per caricare programmi o dati LISP da un file-system locale possono essere utilizzate per caricare o salvare programmi e dati LISP da o verso nodi remoti.

Utilizzando gli URL nelle specifiche del file di caricamento e salvataggio, queste funzioni possono funzionare in rete comunicando con un nodo server di newLISP:

(load "http://192.168.1.2:4711//usr/share/newlisp/mysql5.lsp")

(save "http://192.168.1.2:4711//home/newlisp/data.lsp" 'db-data)

Sebbene le funzioni di caricamento "load" e salvataggio "save" utilizzino internamente "get-url" e "put-url" per eseguire i propri lavori, si comportano esattamente come quando vengono utilizzate su un file-system locale, ma invece di un percorso di file vengono specificati gli URL.
Entrambe le funzioni scadranno dopo 60 secondi se non è stato possibile stabilire una connessione.
Quando è necessario un controllo più preciso, utilizzare le funzioni "get-url" e "put-url" insieme a "eval-string" e "source" per ottenere un risultato simile a quando si utilizza "load" e "save" in modalità HTTP.

Socket Unix di dominio locale
=============================
newLISP supporta socket di dominio locale con nome in modalità newLISP server utilizzando le funzioni integrate "net-eval", "net-listen", "net-connect" insieme alle funzioni "net-accept", "net-receive", "net-select" e "net-send".

Utilizzando socket di dominio locale è possibile una comunicazione veloce tra processi sullo stesso file system e con i server newLISP.
Vedere il Manuale utente per maggiori dettagli.


====================================
 22. MODALITÀ SOLO SERVER WEB HTTPD
====================================

In tutti i capitoli precedenti è stata utilizzata la modalità server -c.
Questa modalità può fungere da server di valutazione della rete e allo stesso tempo rispondere alle richieste HTTP per servire pagine Web o trasferire file e programmi.
La modalità -c è la modalità preferita per operazioni sicure dietro un firewall.
newLISP ha anche una modalità -http che funziona come una modalità -c ristretta.
In modalità -http vengono servite solo le richieste HTTP e le richieste formattate come riga di comando, mentre le richieste "net-eval" non ricevono risposta.
In questa modalità newLISP può agire come un server Web che risponde alle richieste HTTP GET, PUT, POST e DELETE nonché alle richieste CGI, ma è necessario compiere ulteriori sforzi per limitare l'accesso non autorizzato a file e cartella per proteggere il server quando esposto a Internet.

Variabili d'ambiente
====================
In entrambe le modalità server -c e -http vengono impostate le variabili d'ambiente DOCUMENT_ROOT, REQUEST_METHOD, SERVER_SOFTWARE e QUERY_STRING.
Vengono impostate anche le variabili CONTENT_TYPE, CONTENT_LENGTH, HTTP_HOST, HTTP_USER_AGENT e HTTP_COOKIE se presenti nell'header HTTP inviato dal client.

Pre-elaborazione della richiesta
================================

Quando il server newLISP risponde a qualsiasi tipo di richiesta (HTTP e riga di comando), la funzione newLISP "command-event" può essere utilizzata per pre-elaborare la richiesta.
La funzione di pre-elaborazione può essere caricata da un file httpd-conf.lsp all'avvio del server:

server_args = httpd-conf.lsp -http -w /home/node

Il frammento di cui sopra mostra parte di un file di configurazione di xinetd.
È stato aggiunto un programma di avvio httpd-conf.lsp che verrà caricato all'invocazione di newLISP.
L'opzione -c è stata sostituita con l'opzione -http.
Ora non verrà data risposta né alle richieste "net-eval" né a quelle da riga di comando, ma solo alle richieste HTTP.

Il file di avvio potrebbe anche essere stato aggiunto nel modo seguente quando si avvia il server in background da una shell dei comandi e httpd-conf.lsp si trova nella cartella corrente:

newlisp httpd-conf.lsp -http -d 80 -w /home/www &

Tutte le richieste verranno pre-elaborate con una funzione specificata utilizzando "command-event" in httpd-conf.lsp:

; httpd-conf.lsp
;
; filter and translate HTTP request for newLISP
; -c or -http server modes
; reject query commands using CGI with .exe files

(command-event (fn (s)
    (let (request nil)
    (if (find "?" s) ; è una query?
        (begin
            (set 'request (first (parse s "?")))
            ; scopre le estensioni illegali nelle query
            (if (ends-with request ".exe")
                (set 'request "GET /errorpage.html")
                (set 'request s)))
        (set 'request s))
    request)
))
; eof

Tutti i file di richieste CGI che terminano con .exe verrebbero rifiutati e la richiesta tradotta nella richiesta di una pagina di errore.

Elaborazione CGI in modalità HTTP
=================================
Su http://www.newlisp.org si possono trovare vari esempi CGI.
Nella cartella di download all'indirizzo http://www.newlisp.org/downloads si possono trovare due applicazioni più complesse: newlisp-ide è un IDE basato sul web e newlisp-wiki è un sistema di gestione dei contenuti che esegue anche il sito web http://www.newlisp.org

I file di programma CGI devono avere l'estensione .cgi e avere i permessi eseguibili su Unix.

Il seguente è un programma CGI minimo:

#!/usr/bin/newlisp

(print "Content-type: text/html\r\n\r\n")
(println "<h2>Hello World</h2>")
(exit)

newLISP normalmente emette un'intestazione di risposta standard HTTP/1.0 200 OK\r\n più una riga di intestazione Server: newLISP v. ...\r\n.
Se la prima riga dell'output del programma CGI inizia con "Status:", l'output dell'intestazione standard di newLISP viene soppresso e il programma CGI deve fornire da solo l'intestazione di stato completa.
L'esempio seguente reindirizza una richiesta a una nuova locazione:

#!/usr/bin/newlisp
(print "Status: 301 Moved Permanently\r\n")
(print "Location: http://www.newlisp.org/index.cgi\r\n\r\n")
(exit)

Una installazione di newLISP contiene un file di modulo cgi.lsp.
Questo modulo contiene subroutine per estrarre parametri da richieste HTTP GET e POST, estrarre o impostare cookie e altre routine utili durante la scrittura di file CGI.
Vedere la sezione moduli su: http://www.newlisp.org/modules/.

Tipi di file supportati on modalità HTTP
========================================
In entrambe le modalità HTTP -c e -http vengono riconosciuti i seguenti tipi di file e viene restituita un'intestazione Content-Type: formattata correttamente:

File extension   Media type
.avi             video/x-msvideo
.css             text/css
.gif             image/gif
.htm             text/htm
.html            text/html
.jpg             image/jpg
.js              application/javascript
.mov             video/quicktime
.mp3             audio/mpeg
.mpg             video/mpeg
.pdf             application/pdf
.png             image/png
.wav             audio/x-wav
.zip             application/zip
any other        text/plain


=======================
 23. ESTENDERE newLISP
=======================

newLISP ha una funzione di importazione, che consente di importare funzioni da DLL (Dynamic Link Libraries) su Win32 o librerie condivise su Linux/Unix (che terminano con .so su Linux, e con .dylib su Mac OS X).

Interfaccia ffi semplice rispetto a quella estesa
=================================================
Nella versione 10.4.0 newLISP ha introdotto una sintassi estesa per le funzioni "import", "callback" e "struct" e per le funzioni di supporto "pack" e "unpack". Questa sintassi estesa è disponibile solo nelle versioni newLISP compilate con libffi.
Tutte le versioni binarie standard distribuite su www.newlisp.org sono abilitate a utilizzare le nuove estensioni in aggiunta all'API più semplice.
L'API più semplice viene utilizzata da tutti i moduli standard che fanno parte della distribuzione ad eccezione del modulo gsl.lsp.

La sintassi estesa consente di specificare i tipi di linguaggio C per i parametri e per i valori restituiti delle funzioni importate e per le funzioni registrate come callback.
La sintassi estesa consente anche la gestione di valori in virgola mobile e strutture C nei parametri e nei valori di ritorno.
La gestione dei tipi in virgola mobile era impossibile o inaffidabile utilizzando la semplice API che dipendeva dalle convenzioni di chiamata cdecl pure.
Queste non sono disponibili su tutte le piattaforme.
L'API estesa gestisce anche il packing e l'unpacking delle strutture C con allineamento automatico dei tipi C sulle diverse architetture CPU.
Vedere la sintassi estesa delle funzioni "pack" e "unpack" nel Manuale dell'utente, in quello di riferimento e nella demo OpenGL.

I capitoli seguenti descrivono la vecchia API semplice.
Gran parte di questoè applicabile anche all'API estesa.
Per i dettagli sulla nuova API, consultare il Manuale dell'utente e quello di riferimento per le funzioni "import", "callback", "struct", "pack" e "unpack".

Una libreria condivisa (shared library) in C
============================================
Questo capitolo mostra come compilare e utilizzare le librerie su entrambe le piattaforme Win32 e Linux/Unix.
Compileremo una DLL e una libreria condivisa Linux/Unix dal seguente programma in C.

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int foo1(char * ptr, int number)
     {
     printf("the string: %s the number: %d\n", ptr, number);
     return(10 * number);
     }

char * foo2(char * ptr, int number)
     {
     char * upper;
     printf("the string: %s the number: %d\n", ptr, number);
     upper = ptr;
     while(*ptr) { *ptr = toupper(*ptr); ptr++; }
     return(upper);
     }

/* eof */

Entrambe le funzioni foo1 e foo2 stampano i loro argomenti, ma mentre foo1 restituisce il numero moltiplicato 10 volte, foo2 restituisce il maiuscolo di una stringa per mostrare come restituire le stringhe dalle funzioni 'C'.

Compilare on Unix
=================
Su Mac OS X e Linux/Unix possiamo compilare e collegare testlib.so in un solo passaggio:

gcc testlib.c -shared -o testlib.so

Oppure su Mac OSX/darwin eseguire:

gcc testlib.c -bundle -o testlib.dylib

La libreria testlib.so sarà compilata con le convenzioni cdecl predefinite di Linux/Unix.
L'importazione della libreria è molto simile su entrambe le piattaforme Linux e Win32, ma su Win32 la libreria si trova nella cartella corrente.
Potrebbe essere necessario specificare il percorso completo o inserire la libreria nel percorso della libreria del sistema operativo:

> (import "/home/newlisp/testlib.so" "foo1")
foo1 <6710118F>

> (import "/home/newlisp/testlib.so" "foo2")
foo2 <671011B9>

> (foo1 "hello" 123)
the string: hello the number: 123
1230

> (foo2 "hello" 123)
the string: hello the number: 123
4054088

> (get-string (foo2 "hello" 123))
the string: hello the number: 123
"HELLO"
>

Di nuovo, il numero restituito da foo2 è il puntatore dell'indirizzo della stringa e "get-string" può essere utilizzato per accedere alla stringa.
Quando si utilizza "get-string" vengono restituiti solo i caratteri fino a zero byte.
Quando si restituiscono gli indirizzi ai buffer binari, vengono utilizzate diverse tecniche che utilizzano "unpack" per accedere alle informazioni.

Compilare una DLL su Win32
==========================
Le DLL su Win32 possono essere create utilizzando i compilatori MinGW, Borland o CYGWIN.
Questo esempio mostra come farlo usando il compilatore MinGW.

Compiliamo il programma:

gcc -c testlib.c -o testlib.o

Prima di poter trasformare testlib.o in una DLL abbiamo bisogno di un testlib.def che dichiari le funzioni esportate:

LIBRARY  testlib.dll
EXPORTS
         foo1
         foo2

Adesso creiamo il wrapper per la DLL:

dllwrap testlib.o --def testlib.def -o testlib.dll -lws2_32

La libreria testlib.dll verrà compilata con le convenzioni stdcall Win32 predefinite.
Di seguito viene mostrata una sessione interattiva, importando la libreria e utilizzando le funzioni:

> (import "testlib.dll" "foo1")
foo1 <6710118F>

> (import "testlib.dll" "foo2")
foo2 <671011B9>

> (foo1 "hello" 123)
the string: hello the number: 123
1230

> (foo2 "hello" 123)
the string: hello the number: 123
4054088

> (get-string (foo2 "hello" 123))
the string: hello the number: 123
"HELLO"

; importare una libreria compilata
; con convenzioni di chiamata cdecl
> (import "foo.dll" "func" "cdecl")

Si noti che la prima volta che si utilizza foo2 il valore restituito 4054088 è l'indirizzo di memoria della stringa restituita.
Usando "get-string" è possibile accedere alla stringa che gli appartiene.
Se la libreria viene compilata utilizzando le convenzioni di chiamata cdecl, la parola chiave cdecl deve essere utilizzata nell'espressione di importazione.

Importazione di strutture dati
==============================
Proprio come le stringhe "C" vengono restituite utilizzando puntatori stringa, le strutture "C" possono essere restituite utilizzando puntatori struttura e funzioni come "get-string", "get-int" o "get-char" possono essere utilizzate per accedere ai membri.
Il seguente esempio lo illustra:

typedef struct mystruc
   {
   int number;
   char * ptr;
   } MYSTRUC;

MYSTRUC * foo3(char * ptr, int num )
   {
   MYSTRUC * astruc;
   astruc = malloc(sizeof(MYSTRUC));
   astruc->ptr = malloc(strlen(ptr) + 1);
   strcpy(astruc->ptr, ptr);
   astruc->number = num;
   return(astruc);
   }

Il programma newLISP accederebbe ai membri della struttura come segue:

> (set 'astruc (foo3 "hello world" 123))
4054280

> (get-string (get-integer (+ astruc 4)))
"hello world"

> (get-integer astruc)
123

Il valore restituito da foo3 è l'indirizzo della struttura astruc.
Per accedere al puntatore di stringa, è necessario aggiungere 4 come dimensione di un tipo integer nel linguaggio di programmazione 'C'.
La stringa nel puntatore di stringa viene quindi recuperata utilizzando "get-string".

Gestione della memoria
======================
Qualsiasi allocazione eseguita da funzioni esterne importate deve essere deallocata manualmente se non è presente alcuna chiamata nell'API importata per farlo.
La funzione "free" della libreria libc può essere importata e utilizzata per liberare memoria allocata all'interno delle funzioni importate:

(import "/usr/lib/libc.so" "free")

(free astruc) ; astruc contiene l'indirizzo di memoria della struttura allocata

In caso di chiamata di funzioni esterne con passaggio per riferimento, la memoria per le variabili deve essere allocata in anticipo da newLISP e, quindi, la memoria non deve essere deallocata manualmente.

Strutture allineate in modo non uniforme
========================================
A volte le strutture dati contengono tipi di dati di lunghezza diversa rispetto alla normale parola (word) di registro della CPU:

struct mystruct
    {
    short int x;
    int z;
    short int y;
    } data;

struct mystruct * foo(void)
    {
    data.x = 123;
    data.y = 456;
    data.z = sizeof(data);
    return(&data);
    }

Le variabili x e y sono lunghe 16 bit e solo z richiede 32 bit.
Quando un compilatore su una CPU a 32 bit comprime questa struttura, le variabili x e y riempiranno ciascuna 32 bit anziché 16 bit ciascuna.
Ciò è necessario affinché la variabile z a 32 bit possa essere allineata correttamente.
Il seguente codice sarebbe necessario per accedere ai membri della struttura:

> (import "/usr/home/nuevatec/test.so" "foo")
foo <281A1588>

> (unpack "lu lu lu" (foo))
(123 12 456)

L'intera struttura consuma 3 x 4 = 12 byte, perché tutti i membri devono essere allineati ai bordi di 32 bit in memoria.

La seguente struttura dati raggruppa le variabili a 16 bit una accanto all'altra.
Questa volta sono necessari solo 8 byte: 2 ciascuno per x e y e 4 byte per z.
Poiché x e y sono insieme in una parola a 32 bit, nessuna delle variabili attraversa il limite di 32 bit:

struct mystruct
     {
     short int x;
     short int y;
     int z;
     } data;

 struct mystruct * foo(void)
    {
    data.x = 123;
    data.y = 456;
    data.z = sizeof(data);
    return(&data);
    }

Questa volta il codice di accesso in newLISP riflette la dimensione dei membri della struttura:

> (import "/usr/home/nuevatec/test.so" "foo")
foo <281A1588>

> (unpack "u u lu" (foo))
(123 456 8)

Passaggio di parametri
======================
data Type      newLISP call                                  C function call
---------      ------------                                  ---------------
integer        (foo 123)                                     foo(int number)
double float   (foo 1.234)                                   foo(double number)
float          (foo (flt 1.234))                             foo(float number)
string         (foo "Hello World!")                          foo(char * string)
integer array  (foo (pack "d d d" 123 456 789))              foo(int numbers[])
float array    (foo (pack "f f f" 1.23 4.56 7.89))           foo(float[])
double array   (foo (pack "lf lf lf" 1.23 4.56 7.89)         foo(double[])
string array   (foo (pack "lu lu lu" "one" "two" "three")))  foo(char * string[])

Nota che i float e i double float vengono passati correttamente solo su piattaforme x86 con le convenzioni di chiamata cdecl o quando sono passati per riferimento a un puntatore come nelle funzioni di argomento variabile, ad esempio: printf().
 Per una gestione affidabile dei tipi in virgola mobile a precisione singola e doppia e per l'utilizzo avanzato di "pack" e "unpack" per la gestione di strutture C, vedere le descrizioni delle funzioni di "import", "callback" e "struct" nel Manuale utente e riferimento di newLISP.

"pack" può ricevere più argomenti dopo l'identificatore di formato anche in una lista:

(pack "lu lu lu" '("one" "two" "three"))

Estrazione dei valori di ritorno
================================
data Type         newLISP to extract return value                                     C return
--------------------------------------------------------------------------------------------------------------
integer           (set 'number (foo x y z))                                           return(int number)
double float      n/a - only 32bit returns, use double float pointer instead          not available
double float ptr  (set 'number (get-float (foo x y z)))                               return(double * numPtr)
float             not available                                                       not available
string            (set 'string (get-string (foo x y z)))                              return(char * string)
integer array     (set 'numList (unpack "ld ld ld" (foo x y z)))                      return(int numList[])
float array       (set 'numList (unpack "f f f" (foo x y z)))                         return(float numList[])
double array      (set 'numList (unpack "lf lf lf" (foo x y z)))                      return(double numList[])
string array      (set 'stringList (map get-string (unpack "ld ld ld" (foo x y z))))  return(char * string[])

I float e i double possono essere restituiti solo tramite riferimenti a puntatore di indirizzo.

Quando si restituiscono tipi di array, è necessario conoscere il numero di elementi nell'array.
Gli esempi assumono sempre 3 elementi.

Tutti i formati pack e unpack e possono essere forniti anche senza spazi, ma sono distanziati negli esempi per una migliore leggibilità.

I formati "ld" e "lu" sono intercambiabili, ma i formati a 16 bit "u" e "d" possono produrre risultati diversi, a causa dell'estensione del segno quando si passa da 16 bit senza segno a bit con segno a 32 o 64 bit di newLISP formato intero interno.

Sono disponibili flag per modificare l'ordine dei byte endian durante il confezionamento e l'estrazione.

Scrivere wrapper di librerie
============================
A volte la versione semplice della funzione integrata "import" di newLISP non può essere utilizzata con una libreria.
Questo accade ogni volta che una libreria non aderisce strettamente alle convenzioni di chiamata cdecl aspettandosi che tutti i parametri siano passati nello stack.
Per esempio, quando si esegue Mac OS X su vecchie CPU PPC invece che su CPU Intel, le librerie OpenGL installate per impostazione predefinita su Mac OS X non possono essere utilizzate.

Dalla versione 10.4.0 di newLISP, il problema può essere risolto più facilmente utilizzando la nuova sintassi estesa di "import", che risolve automaticamente le differenze di piattaforma e architettura.
Su sistemi molto piccoli o ogni volta che la libreria di sistema libffi necessaria non è presente su una piattaforma, è possibile creare una libreria wrapper speciale per tradurre le convenzioni cdecl previste da newLISP nelle convenzioni di chiamata previste dalla libreria di destinazione.

/* wrapper.c - demo for wrapping library function

compilazione:

    gcc -m32 -shared wrapper.c -o wrapper.so
oppure:
    gcc -m32 -bundle wrapper.c -o wrapper.dylib

utilizzo da newLISP:

    (import "./wrapper.dylib" "wrapperFoo")

    (define (glFoo x y z)
        (get-float (wrapperFoo 5 (float x) (int y) (float z))) )

 (glFoo 1.2 3 1.4) => 7.8

*/

#include <stdio.h>
#include <stdarg.h>

/* the glFoo() function would normally live in the library to be
   wrapped, e.g. libopengl.so or libopengl.dylib, and this
   program would link to it.
   For demo and test purpose the function has been included in this
   file
*/

double glFoo(double x, int y, double z)
    {
    double result;

    result = (x + z) * y;

    return(result);
    }

/* this is the wrapper for glFoo which gets imported by newLISP
   declaring it as a va-arg function guarantees 'cdecl'
   calling conventions on most architectures
*/

double * wrapperFoo(int argc, ...)
    {
    va_list ap;
    double x, z;
    static double result;
    int y;

    va_start(ap, argc);

    x = va_arg(ap, double);
    y = va_arg(ap, int);
    z = va_arg(ap, double);

    va_end(ap);

    result = glFoo(x, y, z);
    return(&result);
    }

/* eof */

Registrazione di callback in librerie esterne
=============================================
Molte librerie condivise consentono di registrare le funzioni di callback per tornare indietro al programma di controllo.
Il La funzione callback viene utilizzata in newLISP per estrarre l'indirizzo della funzione da una funzione newLISP definita dall'utente e passarlo alla libreria esterna tramite una funzione di registrazione:

(define (keyboard key x y)
    (if (= (& key 0xFF) 27) (exit)) ; esce dal programma con ESC
    (println "key:" (& key 0xFF) " x:" x  " y:" y))

(glutKeyboardFunc (callback 1 'keyboard))

L'esempio è un frammento del file opengl-demo.lsp nella cartella newlisp-x.x.x/examples/ della distribuzione dei sorgenti.
Nella stessa cartella si trova un file win32demo.lsp che mostra i callback sulla piattaforma Windows.

Per una sintassi avanzata di callback utilizzando identificatori di tipo C, vedere il manuale utente e di riferimento di newLISP.


======================================================
 24. NEWLISP COME LIBRERIA CONDIVISA (SHARED LIBRARY)
======================================================

Su tutte le piattaforme, newLISP può essere compilato come una libreria condivisa.
Su Win32, la libreria si chiama newlisp.dll, su Mac OS X newlisp.dylib e su Linux e BSD, la libreria si chiama newlisp.so.
I makefile sono inclusi nella distribuzione dei sorgenti per la maggior parte delle piattaforme.
Solo su Win32, il programma di installazione viene fornito con un newlisp.dll precompilato e lo installerà nella cartella Program Files/newlisp/.

Valutazione del codice nella libreria condivisa
===============================================
Il primo esempio mostra come importare "newlispEvalStr" da newLISP stesso come chiamante:

(import "/usr/lib/newlisp.so" "newlispEvalStr")
(get-string (newlispEvalStr "(+ 3 4)")) →  "7\n"

Quando si chiama la funzione di libreria "newlispEvalStr", l'output normalmente diretto alla console (ad esempio valori restituiti o istruzioni "print") viene restituito sotto forma di puntatore intero a una stringa.
È possibile accedere all'output passando questo puntatore alla funzione "get-string".
Per silenziare l'output dai valori restituiti, utilizzare la funzione "silent".
Tutti i risultati, anche se sono numeri, vengono sempre restituiti come stringhe e un avanzamento riga finale (linefeed) come nella modalità console interattiva.
Utilizzare le funzioni "int" o "float" per convertire le stringhe in altri tipi di dati.

Quando si passa una stringa multiriga a "newlispEvalStr", tale stringa deve essere racchiusa tra i tag [cmd], [/cmd], ciascuno su una riga diversa:

(set 'code [text][cmd]
...
...
...
[/cmd][/text])

Il secondo esempio mostra come importare "newlispEvalStr" in un programma C:

/* libdemo.c - demo for importing newlisp.so
 *
 * compile using:
 *    gcc -ldl libdemo.c -o libdemo
 *
 * use:
 *
 *    ./libdemo '(+ 3 4)'
 *    ./libdemo '(symbols)'
 *
 */
#include <stdio.h>
#include <dlfcn.h>

int main(int argc, char * argv[])
{
void * hLibrary;
char * result;
char * (*func)(char *);
char * error;

if((hLibrary = dlopen("/usr/lib/newlisp.so",
                       RTLD_GLOBAL | RTLD_LAZY)) == 0)
    {
    printf("cannot import library\n");
    exit(-1);
    }

func = dlsym(hLibrary, "newlispEvalStr");
if((error = dlerror()) != NULL)
    {
    printf("error: %s\n", error);
    exit(-1);
    }

printf("%s\n", (*func)(argv[1]));

return(0);
}

/* eof */

Questo programma accetterà le espressioni newLISP citate e stamperà i risultati valutati.

Registrazione dei callback
==========================
Come molte altre librerie condivise, i callback possono essere registrati nella libreria newLISP.
La funzione "newlispCallback" deve essere importata e viene utilizzata per registrare le funzioni di callback.
L'esempio mostra newLISP che importa newLISP come libreria e registra un callback "callme":

#!/usr/bin/newlisp

; nome del percorso della libreria a seconda della piattaforma
(set 'LIBRARY (if (= ostype "Win32") "newlisp.dll" "newlisp.dylib"))

; importa funzioni dalla libreria condivisa newLISP
(import LIBRARY "newlispEvalStr")
(import LIBRARY "newlispCallback")

; imposta il tipo di chiamata specifico per la piattaforma
(set 'CALLTYPE (if (= ostype "Win32") "stdcall" "cdecl"))

; la funzione di call-back
(define (callme p1 p2 p3 result)
    (println "p1 => " p1 " p2 => " p2 " p3 => " p3)
    result)

; registra la call-back con la libreria newLISP
(newlispCallback "callme" (callback 0 'callme) CALLTYPE)

; il callback restituisce una stringa
(println (get-string (newlispEvalStr
    {(get-string (callme 123 456 789 "hello world"))})))

; il callback restituisce un numero
(println (get-string (newlispEvalStr
    {(callme 123 456 789 99999)})))

A seconda del tipo di valore restituito, viene utilizzato un codice diverso. Il programma mostra il seguente output:

p1 => 123 p2 => 456 p3 => 789
"hello world"

p1 => 123 p2 => 456 p3 => 789
99999

Nota che Win32 e molte versioni Unix cercheranno newlisp.dll nel percorso della libreria di sistema, ma Mac OS X cercherà prima newlisp.dylib nella cartella corrente, se il percorso completo del file non è specificato.
Il programma sopra può anche essere trovato come callback nella distribuzione dei sorgenti nella cartella newlisp-x.x.x/examples.

