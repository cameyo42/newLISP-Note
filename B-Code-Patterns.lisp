===============

 CODE PATTERNS

===============

Questo file contiene la traduzione libera di alcuni capitoli del documento ufficiale "Code Patterns in newLISP" che si trova al seguente indirizzo web:

http://www.newlisp.org/CodePatterns.html

Il documento ufficiale ha il seguente copyright:

----------------------------------------------------------------------------
Code Patterns in newLISP®
Version 2018 July 12th
newLISP v.10.7.1

Copyright © 2015 Lutz Mueller, www.nuevatec.com. All rights reserved.
Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.2 or any later version published by the Free Software Foundation, with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts. A copy of the license is included in the section entitled GNU Free Documentation License.

newLISP is a registered trademark of Lutz Mueller.
----------------------------------------------------------------------------

=================
 1. INTRODUZIONE
=================

Quando si programma in newLISP, alcune funzioni e modelli (pattern) di utilizzo si verificano ripetutamente. Per alcuni problemi un modo ottimale per risolverli si evolve nel tempo. I capitoli seguenti presentano codice di esempio e spiegazioni per la soluzione di problemi specifici durante la programmazione in newLISP.
Alcuni contenuti si sovrappongono al materiale trattato nel manuale "newLISP Users manual and Reference" o vengono presentati qui con un'angolazione diversa.
Utilizzeremo solo un sottoinsieme del repertorio delle funzioni totali di newLISP. Alcune funzioni presentate hanno metodi di chiamata aggiuntivi o applicazioni non menzionate in queste pagine.
Questa raccolta di modelli e soluzioni è un lavoro in corso. Nel tempo, il materiale verrà aggiunto o il materiale esistente migliorato.

========================
 2. newLISP SCRIPT FILE
========================

Opzioni della linea di comando
==============================
Su Linux/Unix, inserisci quanto segue nella prima riga del file di script/programma:

#!/usr/bin/newlisp

specificando uno stack più grande:

#!/usr/bin/newlisp -s 100000

oppure

#!/usr/bin/newlisp -s100000

Le shell dei sistemi operativi si comportano in modo diverso durante l'analisi della prima riga e l'estrazione dei parametri. newLISP accetta entrambi i parametri collegati o scollegati. Inserisci le seguenti righe in un piccolo script per testare il comportamento del sistema operativo e della piattaforma sottostanti. Lo script modifica la dimensione dello stack allocata a 100.000 e limita la memoria della cella newLISP a circa 10 Mbyte.

#!/usr/bin/newlisp -s 100000 -m 10

(println (main-args))
(println (sys-info))

(exit) ; importante

Un tipico output che esegue lo script dalla shell di sistema sarebbe:

./arg-test

("/usr/bin/newlisp" "-s" "100000" "-m" "10" "./arg-test")
;-> (308 655360 299 2 0 100000 8410 2)

Notare che pochi programmi in newLISP necessitano di uno stack più grande di quello di base. La maggior parte dei programmi viene eseguita sul valore predefinito di 2048. Ogni posizione dello stack richiede una media di 80 byte. Sono disponibili altre opzioni per avviare newLISP. Vedere il Manuale dell'utente per i dettagli.

Script come pipe
================
The following example shows how a file can be piped into a newLISP script.
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

Il file verrà stampato in uscita standard tradotto in maiuscolo. Il seguente programma funzionerà anche con informazioni binarie non testuali contenenti 0:

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

Imposta la dimensione del buffer per ottenere le migliori prestazioni.

Filtro di File
==============
Lo script seguente funziona come un'utilità grep di Unix che itera i file e filtra ogni riga in un file utilizzando un modello (pattern) di espressione regolare.

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

Restituisce una lista di tutti i nomi di file. Questa forma di specificare gli indici per il resto è chiamata indicizzazione implicita. Vedere il Manuale d'uso per l'indicizzazione implicita con altre funzioni. L'espressione (main-args 2) estrae il terzo argomento dalla riga di comando contenente il modello (pattern) di espressione regolare.

newLISP come pipe
=================
Inserisci una riga direttamente nell'eseguibile per la valutazione di espressioni brevi:

~> echo '(+ 1 2 3)' | newlisp
6
~>

==============================
 3. SCRIVERE CODICE IN MODULI
==============================

Strutturare una applicazione
============================
Quando si scrivono applicazioni più grandi o quando più programmatori stanno lavorando sulla stessa base di codice, è necessario dividere la base di codice in moduli. I moduli in newLISP vengono implementati utilizzando i contesti, che sono spazi dei nomi. Gli spazi dei nomi consentono l'isolamento lessicale tra i moduli. Le variabili con lo stesso nome in un modulo non possono entrare in conflitto con le variabili con lo stesso nome in un altro modulo.

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

Più di un contesto in un file
=============================
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

Si noti che nelle istruzioni dello spazio dei nomi per i contesti A e B i nomi dei contesti sono quotati perché sono stati appena creati, ma MAIN può rimanere non quotato perché esiste già all'avvio di newLISP. Tuttavia, quotarlo non rappresenta un problema.

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

La funzione predefinita (default)
=================================
Una funzione in un contesto può avere lo stesso nome del contesto stesso. Questa funzione ha caratteristiche speciali:

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
    (inc acc)) ; when acc is nil, assumes 0

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

Questo esempio mostra anche come una funzione di default viene definita al volo senza la necessità di istruzioni di contesto esplicite. In alternativa, la funzione potrebbe anche essere stata scritta in modo che il contesto sia creato esplicitamente:

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
Gli esempi precedenti presentavano funzioni già pacchettizzate con dati in uno spazio dei nomi. Nell'esempio del generatore la variabile acc mantiene lo stato. Nell'esempio del fibo la variabile mem mantiene una lista che cresce. In entrambi i casi, funzioni e dati convivono in uno spazio dei nomi. L'esempio seguente mostra come uno spazio dei nomi contiene solo dati nel funtore predefinito:

(set 'db:db '(a "b" (c d) 1 2 3 x y z))

Proprio come abbiamo usato la funzione predefinita per fare riferimento a fibo e generatore, possiamo fare riferimento alla lista in db:db usando solo db. Funzionerà in tutte le situazioni in cui utilizziamo l'indicizzazione delle liste:

(db 0)    → a
(db 1)    → "b"
(db 2 1)  → d
(db -1)   → z
(db -3)   → x

(3 db)    → (1 2 3 x y z)
(2 1 db)  → ((c d))
(-6 2 db) → (1 2)

Passaggio di oggetti per riferimento (by reference)
===================================================
Quando il funtore predefinito (di default) viene utilizzato come argomento in una funzione definita dall'utente, il funtore predefinito viene passato per riferimento. Ciò significa che viene passato un riferimento al contenuto originale, non una copia della lista o della stringa. Ciò è utile quando si gestiscono liste o stringhe di grandi dimensioni:

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

I dati in db:db vengono passati tramite i dati dei parametri della funzione di aggiornamento, che ora contengono un riferimento al contesto db. Il parametro expr passato viene controllato per determinare se si tratta di una funzione integrata, di un operatore o di un'espressione lambda definita dall'utente e quindi funziona su $it, la variabile anaforica di sistema che contiene il vecchio valore a cui fa riferimento (data idx).

Ogni volta che una funzione in newLISP richiede una stringa o una lista in un parametro, un funtore predefinito può essere passato tramite il suo simbolo di contesto. Un altro esempio:

(define (pop-last data)
(pop data -1))

(pop-last db) → z

db:db         → (99 "B" (c d) 1 2.2 3 x y)

L'aggiornamento della funzione è anche un buon esempio di come passare operatori o funzioni come argomento di una funzione (lavorando in maiuscolo su $it). Maggiori informazioni su questo argomento nel capitolo "Funzioni come dati".

=====================
 4. VARIABILI LOCALI
=====================

Variabili locali nei cicli
==========================
Tutte le funzioni di ciclo come "doargs", "dolist", "dostring", "dotimes", "dotree" e "for" usano le variabili locali. Durante l'esecuzione del ciclo, la variabile assume valori diversi. Ma dopo aver lasciato la funzione di ciclo, la variabile riacquista il suo vecchio valore. Le espressioni "let", "define" e "lambda" sono un altro metodo per rendere le variabili locali.

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

Le variabili x e y vengono inizializzate, quindi viene valutata l'espressione (+ x y). La forma let è solo una versione ottimizzata e una comodità sintattica dell'espressione:

((lambda (sym1 [sym2 ...]) exp-body ) exp-init1 [ exp-init2 ...])

Quando si inizializzano diversi parametri, è possibile utilizzare un let annidato, letn, per fare riferimento a variabili inizializzate in precedenza nelle successive espressioni di inizializzazione:

(letn ((x 1) (y (+ x 1)))
    (list x y))              → (1 2)

local funziona allo stesso modo ma le variabili sono inizializzate a zero:

(local (a b c)
   ...          ; espressioni che utilizzano le variabili locali a b c
)

letex funziona in modo simile a let ma le variabili vengono espanse nel corpo ai valori assegnati:

; assegna alla variabile locale ed espande nel corpo

(letex ( (x 1) (y '(a b c)) (z "hello") ) '(x y z))
→ (1 (a b c) "hello")

; as in let, parentheses around the initializers can be omitted

(letex (x 1 y 2 z 3) '(x y z))    → (1 2 3)

Dopo essere usciti da una qualsiasi delle espressioni let, letn, local o letex, i simboli delle variabili usati come locali recuperano i loro vecchi valori.

Parametri inutilizzati come variabili locali
============================================
In newLISP, tutti i parametri nelle funzioni definite dall'utente sono opzionali. I parametri inutilizzati vengono inizializzati a nil e sono di ambito locale rispetto all'ambito dinamico della funzione. La definizione di una funzione utente con più parametri di quelli richiesti è un metodo conveniente per creare simboli di variabili locali:

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

args come sostituto di local
============================
Utilizzando la funzione args non è necessario utilizzare alcun simbolo di parametro e args restituisce un elenco di tutti i parametri passati, ma non presi dai parametri dichiarati:

(define (foo)
    (args))

(foo 1 2 3)   → (1 2 3)

(define (foo a b)
    (args))

(foo 1 2 3 4 5)   → (3 4 5)

Il secondo esempio mostra come args contenga solo l'elenco di argomenti non associati dai simboli delle variabili a e b.

Gli indici possono essere utilizzati per accedere ai membri della lista (args):

(define (foo)
      (+ (args 0) (args 1)))

(foo 3 4)   → 7

Uso combinato di args e local per le variabili con nome
=======================================================

(define-macro (foo)
   (local (len width height)
      (bind (args) true)
      (println "len:" len " width:" width " height:" height)
   ))

(foo (width 20) (height 30) (len 10))

len:10 width:20 height:30

local nasconderà/proteggerà i valori delle variabili len, width e height ai livelli di scoping dinamico più elevati.

==============================
 5. ATTRAVERSARE LISTE E DATI
==============================

Ricorsione o iterazione?
========================
Sebbene la ricorsione sia una caratteristica potente per esprimere molti algoritmi in una forma leggibile, in alcuni casi può anche essere inefficiente. newLISP ha molti costrutti iterativi e funzioni di alto livello come flat o le funzioni XML integrate, che usano la ricorsione internamente. In molti casi ciò rende superflua la definizione di un algoritmo ricorsivo.

Alcune volte una soluzione non ricorsiva può essere molto più veloce e leggera sulle risorse di sistema.

; ricorsione classica
; lenta e affamata di risorse
(define (fib n)
    (if (< n 2) 1
        (+  (fib (- n 1))
            (fib (- n 2)))))

La soluzione ricorsiva è lenta a causa del frequente overhead di chiamata. Inoltre, la soluzione ricorsiva utilizza molta memoria per contenere risultati intermedi e, spesso, ridondanti.

; iterazione
; veloce e restituisce anche l'intera lista
(define (fibo n , f)
    (set 'f '(1 0))
    (dotimes (i n)
         (push (+ (f 0) (f 1)) f)) )

La soluzione iterativa è veloce e utilizza pochissima memoria.

Velocizzare con la memoizzazione (memoization)
==============================================
Una funzione di memoizzazione mantiene nella cache i risultati intermedi per un recupero più rapido quando viene chiamata di nuovo con gli stessi parametri. La seguente funzione crea una funzione di memoizzazione da qualsiasi funzione integrata o definita dall'utente con un numero arbitrario di argomenti. Viene creato uno spazio dei nomi (contesto) come cache di dati per la funzione di memoizzazione:

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

La funzione fibo nell'ultimo esempio richiederebbe ore per essere calcolata senza memoizzazione. La versione memoizzata richiede solo circa un milli-secondo con un argomento di 100.

Attraversare un albero (tree)
=============================
Gli attraversamenti di alberi sono un modello tipico nel LISP tradizionale e anche in newLISP per attraversare una lista annidata. Ma molte volte un attreversmaneto degli alberi viene utilizzato solo per scorrere tutti gli elementi di un albero esistente o di una lista annidata. In questo caso la funzione flat incorporata è molto più veloce rispetto all'utilizzo della ricorsione:

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

Utilizzando la funzione integrata "flat" una lista annidata può essere trasformata in una lista semplice. Ora la lista può essere elaborata con "dolist" o con "map":

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

newLISP dispone di funzionalità per l'indicizzazione multidimensionale in elenchi annidati. Ci sono funzioni distruttive come "push", "pop", "setf", "set-ref", "set-ref-all", "sort" e "reverse" e molte altre per operazioni non distruttive, come "nth", "ref", "ref-all", "first", "last" e "rest" ecc .. In newLISP, molte delle funzioni per le lista funzionano anche sulle stringhe.

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
============
Per aggiungere a una lista usa "push", per eliminare un elemento da una lista usa "pop". Entrambe le funzioni sono distruttive e modificano il contenuto della lista:

(set 'L '(b c d e f))

(push 'a L) → (a b c d e f)
(push 'g L -1) ; push alla fine con indice negativo
(pop L)        ; pop la prima a
(pop L -1)     ; pop l'ultima g
(pop L -2)     ; pop seconda dalla fine e
(pop L 1)      ; pop seconda c

L → (b d f)

; push / pop multidimensionale
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
Usando extend le liste possono essere aggiunto in modo distruttivo. Come push e pop, extent modifica la lista nel primo argomento.

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

L'indicizzazione implicita mostrata nell'ultimo esempio può rendere il codice più leggibile. Gli indici prima di una lista selezionano le sottosezioni di una lista, che a loro volta sono sempre liste.

L'indicizzazione implicita è disponibile anche per rest e slice:

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
A volte è necessario selezionare più di un elemento da una lista. Questo viene fatto usando select:

; seleziona diversi elementi da una lista
(set 'L '(a b c d e f g))
(select L 1 2 4 -1) → (b c e g)

; gli indici possono essere forniti da un vettore di indici:
(set 'vec '(1 2 4 -1))
(select L vec) → (b c e g)

Il processo di selezione può riorganizzare o raddoppiare gli elementi contemporaneamente:

(select L 2 2 1 1) → (c c b b)

Filtrare e differenziare liste
==============================
Le liste possono essere filtrate, restituendo solo quegli elementi che soddisfano una condizione specifica:

(filter (fn(x) (< 5 x)) '(1 6 3 7 8))    → (6 7 8)
(filter symbol? '(a b 3 c 4 "hello" g)) → (a b c g)
(difference '(1 3 2 5 5 7) '(3 7)) → (1 2 5)

Il primo esempio potrebbe essere scritto in modo più conciso, come segue:

(filter (curry < 5) '(1 6 3 7 8))

La funzione curry crea una funzione a un argomento da una funzione a due argomenti:

(curry < 5) → (lambda (_x) (< 5 _x))

Con curry, una funzione che accetta due argomenti può essere rapidamente convertita in un predicato che accetta un argomento.

Modifica degli elementi della lista
===================================
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
La variabile di sistema anaforica interna "$it" contiene il vecchio elemento della lista. Questa può essere usata per creare il nuovo elemento:

(set 'L '(0 0 0))
(setf (L 1) (+ $it 1)) → 1 ; il nuovo valore
(setf (L 1) (+ $it 1)) → 2
(setf (L 1) (+ $it 1)) → 4
L → '(0 3 0)

Le seguenti funzioni usano l'anaforico "$it": "find-all", "if", "replace", "set-ref", "set-ref-all", "setf" e "setq".

Sostituzioni in liste semplici
==============================
"replace", che può essere utilizzato anche su stringhe, può cercare e sostituire più elementi contemporaneamente in una lista. Insieme a "match" e "unify", è possibile specificare modelli di ricerca complessi. Come con "setf", l'espressione di sostituzione può utilizzare il contenuto del vecchio elemento per formare la sostituzione.

(set 'aList '(a b c d e a b c d))

(replace 'b aList 'B) → (a B c d e a B c d)

La funzione "replace" può usare una funzione di confronto per selezionare gli elementi della lista:

; sostituire tutti i numeri dove 10 < numero
(set 'L '(1 4 22 5 6 89 2 3 24))

(replace 10 L 10 <) → (1 4 10 5 6 10 2 3 10)

Utilizzando le funzioni integrate match e unify è possibile definire criteri di selezione più complessi:

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

Sostituzioni in liste annidate
==============================
A volte le liste sono nidificati, ad es. l'SXML risulta dall'analisi dell'XML. Le funzioni "ref-set", "set-ref" e "set-ref-all" possono essere utilizzate per trovare un singolo elemento o tutti gli elementi in una lista annidata e sostituirli in parte o tutti.

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

L'ultimo esempio mostra come utilizzare $0 per accedere al vecchio elemento della lista nell'espressione di aggiornamento. In questo caso i numeri per i record delle arance sono stati sommati. Invece di $0 può essere utilizzata anche la variabile di sistema anaforica $it.

Passaggio di liste per riferimento
==================================
A volte una lista più grande (più di poche centinaia di elementi) deve essere passato a una funzione definita dall'utente affinché gli elementi in essa contenuti possano essere modificati. Normalmente newLISP passa tutti i parametri alle funzioni definite dall'utente in base al valore. Ma il seguente frammento mostra una tecnica che può essere utilizzata per passare un elenco più grande o un oggetto stringa per riferimento:

(set 'data:data '(a b c d e f g h))

(define (change db i value)
    (setf (db i) value))

(change data 3 999) → d

data:data → '(a b c 999 d e f g h)

In questo esempio la lista è incapsulata in un contesto denominato data contenente una variabile data con lo stesso nome.

Ogni volta che una funzione in newLISP cerca una stringa o una lista come parametro, è possibile passare un contesto, che verrà quindi interpretato come il funtore predefinito.

Quando si restituisce una lista o un array o un elemento appartenente a una lista o un array a cui fa riferimento un simbolo, molte funzioni integrste restituiscono un //riferimento// alla lista, non una copia. Questo può essere utilizzato per annidare le funzioni integrate durante la modifica di una lista:

(set 'L '(r w j s r b))

(pop (sort L)) → b

L → (j r r s w)

Espansione delle variabili
==========================
Sono disponibili due funzioni per eseguire la macro-espansione: "expand" e "letex". La funzione "expand" ha tre diversi modelli di sintassi.

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

Destrutturare liste annidate
============================
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

Il flusso del programma in newLISP è per lo più funzionale, ma ha anche costrutti di loop e ramificazione e la coppia catch e throw per interrompere il normale flusso.

Le espressioni di un ciclo nel loro insieme si comportano come una funzione o un blocco che restituisce l'ultima espressione valutata.

Cicli (Loops)
=============
Sono supportati la maggior parte dei modelli di loop tradizionali. Ogni volta che è presente una variabile di ciclo, è di ambito locale rispetto al ciclo, comportandosi secondo le regole dello scoping dinamico all'interno dello spazio dei nomi o del contesto corrente:

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

Si noti che le funzioni di ciclo dolist, dotimes e for possono anche accettare una condizione di interruzione come argomento aggiuntivo. Quando la condizione di interruzione restituisce true, il ciclo termina:

(dolist (x '(a b c d e f g) (= x 'e))
    (print x))
→ ; output
 abcd

Blocchi
=======
Blocks are collections of s-expressions evaluated sequentially. All looping constructs may have expression blocks after the condition expression as a body.

Blocks can also be constructed by enclosing them in a begin expression:

(begin
    s-exp1
    s-exp2
     ...
    s-expN)

Looping constructs do not need to use an explicit begin after the looping conditions. begin is mostly used to block expressions in if and cond statements.

The functions and, or, let, letn and local can also be used to form blocks and do not require begin for blocking statements.

Branching
=========
(if condition true-expr false-expr)

;or when no false clause is present
(if condition true-expr)

;or unary if for (filter if '(...))
(if condition)

; more than one statement in the true or false
; part must be blocked with (begin ...)
(if (= x y)
    (begin
        (some-func x)
        (some-func y))
    (begin
        (do-this x y)
        (do-that x y))
)

; the when form can take several statements without
; using a (begin ...) block
(when condition
    exp-1
    exp-2
    ...
)

; unless works like (when (not ...) ...)
(unless condition
    exp-1
    exp-2
    ...
)

Depending on the condition, the exp-true or exp-false part is evaluated and returned.

More than one condition/exp-true pair can occur in an if expression, making it look like a cond:

(if condition-1 exp-true-1
    condition-2 exp-true-2
    ...
    condition-n exp-true-n
    expr-false
)

The first exp-true-i for which the condition-i is not nil is evaluated and returned, or the exp-false if none of the condition-i is true.

cond works like the multiple condition form of if but each part of condition-i exp-true-i must be braced in parentheses:

(cond
    (condition-1 exp-true-1 )
    (condition-2 exp-true-2 )
                ...
    (condition-n exp-true-n )
    (true exp-true)
)

Fuzzy flow
==========
Using amb the program flow can be regulated in a probabilistic fashion:

(amb
    exp-1
    exp-2
    ...
    exp-n
)
One of the alternative expressions exp-1 to exp-n is evaluated with a probability of p = 1/n and the result is returned from the amb expression.

Flow with catch and throw
=========================
Any loop or other expression block can be enclosed in a catch expression. The moment a throw expression is evaluated, the whole catch expression returns the value of the throw expression.

(catch
    (dotimes (i 10)
    (if (= i 5) (throw "The End"))
    (print i " "))
)
; will output
0 1 2 3 4
; and the return value of the catch expression will be
→ "The End"
Several catch expressions can be nested. The function catch can also catch errors. See the chapter on //Error Handling// below.

Leave loops with a break condition
==================================
Loops built using dotimes, dolist or for can specify a break condition for leaving the loop early:

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

Change flow with and or or
==========================
Similar to programming in the Prolog language, the logical and and or can be used to control program flow depending on the outcome of expressions logically connected:


(and
   expr-1
   expr-2
    ...
   expr-n)

Expressions are evaluated sequentially until one expr-i evaluates to nil or the empty list () or until all expr-i are exhausted. The last expression evaluated is the return value of the whole and expression.

(or
   expr-1
   expr-2
    ...
   expr-n)

Expressions are evaluated sequentially until one expr-i evaluates to not nil and not () or until all expr-i are exhausted. The last expression evaluated is the return value of the whole or expression.

====================
 8. ERROR HANDLING
====================

Several conditions during evaluation of a newLISP expression can cause error exceptions. For a complete list of errors see the Appendix in the newLISP Reference Manual.

newLISP errors
==============
newLISP errors are caused by the programmer using the wrong syntax when invoking functions, supplying the wrong number of parameters or parameters with the wrong data type, or by trying to evaluate nonexistent functions.

; examples of newLISP errors
;
(foo foo)   → invalid function : (foo foo)
(+ "hello") → value expected in function + : "hello"

User defined errors
===================
User errors are error exceptions thrown using the function throw-error:

; user defined error
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
Error event handlers
newLISP and user defined errors can be caught using the function error-event to define an event handler.

; define an error event handler
;
(define (MyHandler)
    (println  (last (last-error))  " has occurred"))

(error-event 'MyHandler)

(foo) → ERR: invalid function : (foo) has occurred

Catching errors
===============
A finer grained and more specific error exception handling can be achieved using a special syntax of the function catch.

(define (double x)
    (if (= x 99) (throw-error "illegal number"))
    (+ x x))

catch with a second parameter can be used to catch both system and user-defined errors:

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

The catch expression returns true when no error exception occurred, and the result of the expression is found in the symbol result specified as a second parameter.

If an error exception occurs, it is caught and the catch clause returns nil. In this case the symbol result contains the error message.

Operating system errors
=======================
Some errors originating at operating system level are not caught by newLISP, but can be inspected using the function sys-error. For example the failure to open a file could have different causes:

; trying to open a nonexistent file
(open "blahbla" "r")  →  nil
(sys-error)           →  (2 "No such file or directory")

; to clear errno specify 0
(sys-error 0)         →  (0 "Unknown error: 0")

Numbers returned may be different on different Unix platforms. Consult the file /usr/include/sys/errno.h on your platform.

=======================
 9. FUNZIONI COME DATI
=======================

Manipulate after definition
===========================

(define (double x) (+ x x))
→ (lambda (x) (+ x x))

(first double) → (x)
(last double)  → (+ x x)

; make a fuzzy double
(setf (nth 1 double) '(mul (normal x (div x 10)) 2))

(double 10) → 20.31445313
(double 10) → 19.60351563

lambda in newLISP is not an operator or symbol, but rather a special s-expression or list attribute:

(first double) → (x)   ; not lambda

The lambda attribute of an s-expression is right-associative in append:

(append (lambda) '((x) (+ x x))) → (lambda (x) (+ x x))
; or shorter
(append (fn) '((x) (+ x x))) → (lambda (x) (+ x x))

(set 'double (append (lambda) '((x) (+ x x)))

(double 10) → 20

and left-associative when using cons:

(cons '(x) (lambda) → (lambda (x))

Lambda expressions in newLISP never lose their first class object property.

The word lambda can be abbreviated as fn, which is convenient when mapping or applying functions to make the expression more readable and shorter to type.

Mapping and applying
====================
Functions or operators can be applied to a list of data at once and all results are returned in a list

(define (double (x) (+ x x))

(map double '(1 2 3 4 5)) → (2 4 6 8 10)
Functions can be applied to parameters occurring in a list:

(apply + (sequence 1 10)) → 55

Functions making functions
==========================
Here an expression is passed as a parameter:

; macro expansion using expand
(define (raise-to power)
    (expand (fn (base) (pow base power)) 'power))

; or as an alternative using letex
(define (raise-to power)
    (letex (p power) (fn (base) (pow base p))))

(define square (raise-to 2))

(define cube (raise-to 3))

(square 5)   → 25
(cube 5)     → 125

The built-in function curry can be used to make a function taking one argument from a function taking two arguments.

(define add-one (curry add 1))  → (lambda () (add 1 ($args 0)))

(define by-ten (curry mul 10))  → (lambda () (mul 10 ($args 0)))

(add-one 5)    → 6

(by-ten 1.23)  → 12.3

Note that the 'curried' parameter is always the first parameter of the original function.

Functions with memory
=====================
newLISP can create local state variables using a name-space context:

; newLISP generator

(define (gen:gen)
    (setq gen:sum
    (if gen:sum (inc gen:sum) 1)))

; this could be written even shorter, because
; 'inc' treats nil as zero

(define (gen:gen)
    (inc gen:sum))

(gen) → 1
(gen) → 2
(gen) → 3

The example uses a default functor — functions name equals names-space name — to give it the appearance of a normal function. Other functions could be added to the namespace, e.g. for initializing the sum.

(define (gen:init x)
    (setq gen:sum x))

(gen:init 20) → 20

(gen) → 21
(gen) → 22
Functions using self modifying code
The first class nature of lambda expressions in newLISP makes it possible to write self modifying code:

;; sum accumulator
(define (sum (x 0)) (inc 0 x))

(sum 1)    → 1
(sum 2)    → 3
(sum 100)  → 103
(sum)      → 103

sum  → (lambda ((x 0)) (inc 103 x))

The following example shows a function making a self modifying stream function using expand :

(define (make-stream lst)
    (letex (stream lst)
        (lambda () (pop 'stream))))

(set 'lst '(a b c d e f g h))
(define mystream (make-stream lst))

(mystream)  → a
(mystream)  → b
(mystream)  → c
Because pop works on both: lists and strings, the same function factory can be used for a string stream:

(set 'str "abcddefgh")
(define mystream (make-stream str))

(mystream)  → "a"
(mystream)  → "c"

=====================
 10. TEXT PROCESSING
=====================

Regular expressions
===================
Regular expressions in newLISP can be used in a number of functions:

function	function description
directory	Return a list of files whose names match a pattern.
ends-with	Test if a string ends with a key string or pattern.
find	Find the position of a pattern.
find-all	Assemble a list of all patterns found.
parse	Break a string into tokens at patterns found between tokens.
regex	Find patterns and returns a list of all sub patterns found, with offset and length.
replace	Replace found patterns with a user defined function, which can take as input the patterns themselves.
search	Search for a pattern in a file.
starts-with	Test if a string starts with a key string or pattern.
The functions find, regex, replace and search store pattern matching results in the system variables $0 to $15. See the newLISP Users Manual for details.

The following paragraphs show frequently-used algorithms for scanning and tokenizing text.

Scanning text
=============
The replace function, together with a regular expression pattern, can be used to scan text. The pattern in this case describes the tokens scanned for. As each token is found, it is pushed on a list. The work is done in the replacement expression part of replace. This example saves all files linked on a web page:

#!/usr/bin/newlisp

; tokenize using replace with regular expressions
; names are of the form <a href="example.lsp">example.lsp</a>

(set 'page (get-url "http://newlisp.digidep.net/scripts/"))
(replace {>(.*lsp)<} page (first (push $1 links)) 0) ; old technique
;(set 'links (find-all {>(.*lsp)<} page $1)) ; new technique

(dolist (fname links)
   (write-file fname (get-url (append "http://newlisp.digidep.net/scripts/" fname)))
   (println "->" fname))

(exit)

Curly braces ({,}) are used in the regular expression pattern to avoid having to escape the quotes ("") or other characters that have special meanings in regular expressions.

The following alternative technique is even shorter. The find-all function puts all matching strings into a list:

(set 'links (find-all {>(.*lsp)<} page $1)) ; new technique

In an additional expression find-all can be directed to do additional work with the sub expressions found:

(find-all {(new)(lisp)} "newLISPisNEWLISP" (append $2 $1) 1)
→ ("LISPnew" "LISPNEW")

In the last example find-all appends the sub expressions found in reverse order before returning them in the result list.

Another technique for tokenizing text uses parse. Whereas with replace and find-all the regular expression defined the token, when using parse, the regex pattern describes the space between the tokens:

; tokenize using parse
(set 'str "1 2,3,4 5, 6 7  8")
(parse str {,\ *|\ +,*} 0)
→ ("1" "2" "3" "4" "5" "6" "7" "8")

Without the curly braces in the parse pattern, the backslashes would need to be doubled. Note that there is a space after each backslash.

Appending strings
=================
When appending strings append and join can be used to form a new string:

(set 'lstr (map string (rand 1000 100)))
→ ("976" "329" ... "692" "425")

; the wrong slowest way
(set 'bigStr "")
(dolist (s lstr)
    (set 'bigStr (append bigStr s)))

; smarter way - 50 times faster
;
(apply append lstr)

Sometimes strings are not readily available in a list like in the above examples. In this case push can be used to push strings on a list while they get produced. The list then can be used as an argument for join, making the fastest method for putting strings together from existing pieces:

; smartest way - 300 times faster
; join an existing list of strings
;
(join lstr) → "97632936869242555543 ...."

; join can specify a string between the elements
; to be joined
(join lstr "-") → "976-329-368-692-425-555-43 ...."

Growing strings
===============
Often it is best to grow a string in place. The function extend can be used to append to a string at the end. The function push can be used to insert new content at any place in the string.

; smartest way - much faster on big strings
; grow a string in place

; using extend
(set 'str "")
(extend str "AB" "CD")
str → "ABCD"

; extending in a place
(set 'L '(a b "CD" (e f)))
(extend (L 2) "E")
L → (a b "CDE" (e f))

; using push
(set 'str "")
(push "AB" str -1)
(push "CD" str -1)
str → "ABCD"

Rearranging strings
===================
The function select for selecting elements from lists can also be used to select and re-arrange characters from strings:

(set 'str "eilnpsw")
(select str '(3 0 -1 2 1 -2 -3)) → "newlisp"

; alternative syntax
(select str 3 0 -1 2 1 -2 -3) → "newlisp"

The second syntax is useful when indexes are specified not as constants but occur as variables.

Modifying strings
=================
newLISP has a variety of functions, which can destructively change a string:

function	description
extend	Extend a string with another string.
push pop	Insert or extract one or more characters at a specific position.
replace	Replace all occurrences of a string or string pattern with a string.
setf	Replace a character in a string with one or more characters.
replace can also be used to remove all occurrences of string or string pattern when specifying an empty string "" as replacement.

When indexing strings with either nth or implicit indexing, the string is addressed at character rather than byte boundaries to work correctly on UTF-8 enabled versions of newLISP. A UTF-8 character can contain more than one byte.

=============================
 11. DICTIONARIES AND HASHES
==============================

Hash-like key → value access
============================
newLISP has functions to create and manipulate symbols using the functions sym and a special syntax of the function context. In older versions of newLISP, these functions were used to program hash-like creation and access of key-value pairs. Now a shorter and more convenient method is available, using the un-initialized default functor of a namespace context:

(define Myhash:Myhash) ; establish the namespace and default functor

As an alternative to the above methods, the predefined namespace and default functor Tree can be used to instantiate a new one:

(new Tree 'Myhash)

Both methods produce the same result, but the second method also protects the default functor Myhash:Myhash from change.

A default functor is the symbol with the same name as the namespace (context) it belongs to. If this default functor symbol does not contain anything except nil, it works like a hash function:

(Myhash "var" 123) ; create and set variable/value pair

(Myhash "var") → 123 ; retrieve value

(Myhash "foo" "hello")

(Myhash "bar" '(q w e r t y))

(Myhash "!*@$" '(a b c))

; numbers can be used too and will be converted to strings internally

(Myhash 555 42)

(Myhash 555) → 42

Setting a hash symbol to nil will effectively erase it:

(Myhash "bar" nil)

The key can be any string; newLISP prevents symbol clashes with built-in newLISP symbols by prepending an underscore character (_) to all key strings internally. The value can be any string, number or any other newLISP s-expression.

The Myhash namespace can be transformed in an association list:

(Myhash) → (("!*@$" (a b c)) ("foo" "hello") ("var" 123))

Or the raw contents of Myhash can be shown using the symbols function:

(symbols Myhash) → (Myhash:Myhash Myhash:_!*@$ Myhash:_foo Myhash:_var)

Dictionaries can be built by converting an existing association list:

(set 'aList '(("one" 1) ("two" 2) ("three")))

(Myhash aList)

(Myhash) → (("!*@$" (a b c)) ("foo" "hello") ("one" 1) ("three" nil) ("two" 2) ("var" 123))

Saving and loading dictionaries
===============================
The dictionary can be easily saved to a file by serializing the namespace Myhash:

(save "Myhash.lsp" 'Myhash)

The whole namespace is saved to the file Myhash.lsp and can be reloaded into newLISP at a later time:

(load "Myhash")

Note that hashes create contexts similar to the bayes-train function. All string keys are prepended with an underscore and then transformed into a symbol. This means that namespaces created using bayes-train can be used like hashes to retrieve words and their statistics. See the bayes-train function in the manual for more detail.

==========================
 12. TCP/IP client server
==========================

Open connection
===============
In this pattern the server keeps the connection open until the client closes the connection, then the server loops into a new net-accept:

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
and the client:

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

Closed transaction
==================
In this pattern the server closes the connection after each transaction exchange of messages.

; sender
(while (not (net-error))
    (set 'connection (net-accept listen)) ; blocking here
    (net-receive connection message-from-client max-bytes)
        .... process message from client ...
        .... configure message to client ...
    (net-send connection message-to-client)
    (close connection)
)

and the client again tries to connect to the sender:

; client
(unless (set 'connection (net-connect "host.com" 123))
    (println (net-error))
    (exit))
; maximum bytes to receive
(constant 'max-bytes 1024)
  .... configure message to server ...
(net-send connection message-to-server)
(net-receive connection message-from-server max-bytes)
  .... process message-from-server ...

There are many different ways to set up a client/server connection, see also the examples in the newLISP manual.

========================
 13. UDP communications
========================

They are fast and need less setup than TCP/IP and offer multi casting. UDP is also less reliable because the protocol does less checking, i.e. of correct packet sequence or if all packets are received. This is normally no problem when not working on the Internet but in a well controlled local network or when doing machine control. A simple more specific protocol could be made part of the message.

Open connection
===============
In this example the server keeps the connection open. UDP communications with net-listen, net-receive-from and net-send-to can block on receiving.

Note that both, the client and server use net-listen with the "udp" option. In this case net-listen is used only for binding the socket to the address, it is not used for listening for a connection. The server could receive messages from several clients. The net-send-to function extracts the target address from the message received.

The sender:

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

and the client:

(set 'socket (net-listen 10002 "" "udp"))
(if (not socket) (println (net-error)))
(while (not (net-error))
    (print "enter something -> ")
    (net-send-to  "127.0.0.1" 10001 (read-line) socket)
    (net-receive socket buff 255)
    (println "=> " buff))
(exit)

Closed transaction
==================
This form is sometimes used for controlling hardware or equipment. No setup is required, just one function for sending, another one for receiving.

; wait for data gram with maximum 20 bytes
(net-receive-udp 1001 20)
; or
(net-receive-udp 1001 20 5000000)  ; wait for max 5 seconds
; the sender
(net-send-udp "host.com" 1001 "Hello")

Win32 and Unix's show different behavior when sending less or more bytes than specified on the receiving end.

Multi-cast communications
=========================
In this scheme the server subscribes to one of a range of multi cast addresses using the net-listen function.

; example server
(net-listen 4096 "226.0.0.1" "multi") → 5
(net-receive-from 5 20)

; example client I
(net-connect "226.0.0.1" 4096 "multi") → 3
(net-send 3 "hello")
; example client II
(net-connect "" 4096 "multi") → 3
(net-send-to "226.0.0.1" 4096 "hello" 3)
The connection in the example is blocking on net-receive but could be de-blocked using net-select or net-peek

=================================
 14. NON-BLOCKING COMMUNICATIONS
=================================

Using net-select
================

In all previous patterns the client blocks when in receive. The net-select call can be used to unblock communications:

; optionally poll for arriving data with 100ms timeout
(while (not (net-select connection "r" 100000))
    (do-something-while-waiting ...))

(net-receive...)

connection can be a single number for a connection socket or a list of numbers to wait on various sockets.

Using net-peek
==============
net-peek returns the number of characters pending to read.

(while ( = (net-peek aSock) 0)
    (do-something-while-waiting ...))
(net-receive...)

====================================
 15. CONTROLLING OTHER APPLICATIONS
====================================

Using exec
==========
This method is only suited for short exchanges, executing one command and receiving the output.

> (exec "ls *.c")
("newlisp.c" "nl-debug.c" "nl-filesys.c" "nl-import.c" "nl-list.c" "nl-liststr.c"
 "nl-math.c" "nl-matrix.c" "nl-sock.c" "nl-string.c" "nl-symbol.c" "nl-utf8.c" "nl-web.c"
 "nl-xml-json.c" "pcre-chartables.c" "pcre.c" "unix-lib.c" "win-dll.c" "win-path.c"
 "win-util.c")
>
The exec function opens a process pipe for the Unix command-line utility ls and collects each line of STDOUT into a list of strings.

Most following examples use process to launch an application. This function returns immediately after launching the other application and does not block.

In all of the following patterns the server is not independent but controlled by the client, which launches the server and then communicates via a line oriented protocol:

     → launch server
     → talk to server
     ← wait for response from server
     → talk to server
     ← wait for response from server
          ...
Sometimes a sleep time is necessary on the client side to wait for the server to be ready loading. Except for the first example, most of these are condensed snippets from GTK-Server from [http://www.gtk-server.org www.gtk-server.org]. The basic program logic will be the same for any other application.

STD I/O pipes
The process function allows specifying 2 pipes for communications with the launched application.

; setup communications
(map set '(myin tcout) (pipe))
(map set '(tcin myout) (pipe))
(process "/usr/bin/wish" tcin tcout)

; make GUI
(write myout
[text]
wm geometry . 250x90
wm title . "Tcl/Tk and newLISP"
bind . <Destroy> {puts {(exit)}}
[/text])

; run event loop
(while (read-line myin)
    (eval-string (current-line))
)

This is the preferred way to set up longer lasting, bidirectional communications with Unix command line utilities and languages. For one-command exchanges the exec function does the job shorter.

For a more elaborate Tcl/Tk example see the application examples/tcltk.lsp in the source distribution.

Communicate via TCP/IP
======================
; Define communication function
(define (gtk str , tmp)
    (net-send connection str)
    (net-receive connection tmp 64)
    tmp)

; Start the gtk-server
(process "gtk-server tcp localhost:50000")
(sleep 1000)

; Connect to the GTK-server
(set 'connection (net-connect "localhost" 50000))
(set 'result (gtk "gtk_init NULL NULL"))
(set 'result (gtk "gtk_window_new 0"))
               .....

Communicate via named FIFO
==========================
Make a FIFO first (looks like a special file node):

(exec "mkfifo myfifo")

; or alternatively

(import "/lib/libc.so.6" "mkfifo")
(mkfifo "/tmp/myfifo" 0777)

; Define communication function
(define (gtk str)
	(set 'handle (open "myfifo" "write"))
	(write handle str)
	(close handle)
	(set 'handle (open "myfifo" "read"))
	(read handle tmp 20)
	(close handle)
tmp)

Communicate via UDP
===================
Note that the listen function with "udp" option just binds the sockets to a address/hardware but not actually listens as in TCP/IP.

; Define communication function
(define (gtk str , tmp)
(net-send-to "localhost" 50000 str socket)
(net-receive socket 'tmp net-buffer)
tmp)

; Start the gtk-server
(define (start)
	(process "gtk-server udp localhost:50000")
	(sleep 500)
	(set 'socket (net-listen 50001 "localhost" "udp")) )

(set 'result (gtk "gtk_init NULL NULL"))

(set 'result (gtk "gtk_window_new 0"))
.....

=============================
 16. LAUNCHING APPS BLOCKING
=============================

Shell execution
===============

This is frequently used from newLISP's interactive command line to execute processes in a blocking fashion, which need a shell to run:

(! "ls -ltr")

There is an interesting variant of this form working not inside a newLISP expression, but only on the command line:

!ls -ltr

The ! should be the first character on the command line. This form works like a shell escape in the VI editor. It is useful for invoking an editor or doing quick shell work without completely leaving the newLISP console.

Capturing std-out
=================
(exec "ls /") → ("bin" "etc" "home" "lib")

Feeding std-in
==============
(exec "script.cgi" cgi-input)

In this example cgi-input could contain a string feeding a query input, normally coming from a web server. Note that output in this case is written directly to the screen, and cannot be returned to newLISP. Use process and pipe for two way std i/o communications with other applications.

===============================
 17. SEMAPHORES, SHARED MEMORY
===============================

Shared memory, semaphores and processes work frequently together. Semaphores can synchronize tasks in different process threads and shared memory can be used to communicate between them.

The following is a more complex example showing the working of all three mechanisms at the same time.

The producer loops through all n values from i = 0 to n - 1 and puts each value into shared memory where it is picked up by the consumer thread. Semaphores are used to signal that a data value is ready for reading.

Although controlling processes with semaphores and shared memory is fast, it is also error prone, specially when more the two processes are involved. It is easier to control multiple processes using the Cilk API and messaging between processes. See chapters 18. and 19. for these topics.

#!/usr/bin/newlisp
# prodcons.lsp -  Producer/consumer
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
    (set 'prod-sem (semaphore)) ; get semaphores
    (set 'cons-sem (semaphore))
    (set 'prod-pid (fork (producer n))) ; start processes
    (set 'cons-pid (fork (consumer n)))
    (semaphore prod-sem sig) ; get producer started
    (wait-pid prod-pid) ; wait for processes to finish
    (wait-pid cons-pid) ;
    (semaphore cons-sem release) ; release semaphores
    (semaphore prod-sem release))

(run 10)

(exit)

==============================
 18. MULTIPROCESSING AND CILK
==============================

On multiprocessor CPUs the operating system will distribute processes and child processes created on different processor cores in an optimized fashion. newLISP offers a simple API which does all the work of launching processes and does the synchronized collection of evaluation results. The Cilk API consists of only 3 function calls, implemented in newLISP as spawn, sync and abort

Since v.10.1 newLISP's message function enables communications between parent and child processes. For more details about this, see the next chapter 19. Message exchange.

Starting concurrent processes
=============================
; calculate primes in a range
(define (primes from to)
    (let (plist '())
    (for (i from to)
        (if (= 1 (length (factor i)))
        (push i plist -1)))
plist))

; start child processes
(set 'start (time-of-day))

(spawn 'p1 (primes 1 1000000))
(spawn 'p2 (primes 1000001 2000000))
(spawn 'p3 (primes 2000001 3000000))
(spawn 'p4 (primes 3000001 4000000))

; wait for a maximum of 60 seconds for all tasks to finish
(sync 60000) ; returns true if all finished in time
; p1, p2, p3 and p4 now each contain a lists of primes

The example shows how the task of generating a range of prime numbers can be organized for parallel processing by splitting the range into sub-ranges. All spawn calls will return immediately, but sync will block until all child processes have finished and the result lists are available in the four variables p1 to p4.

Watching progress
=================
When the timeout value specified is too short for all processes to finish, sync will return nil. This can be used to watch progress:

; print a dot after each 2 seconds of waiting
(until (sync 2000) (println "."))

When sync is called without parameters, it returns a list of still active process ids:

; show a list of pending process ids after
;each three-tenths of a second
(until (sync 300) (println (sync)))

Invoking spawn recursively
==========================
(define (fibo n)
    (let (f1 nil f2 nil)
        (if (< n 2) 1
            (begin
                (spawn 'f1 (fibo (- n 1)))
                (spawn 'f2 (fibo (- n 2)))
                (sync 10000)
                (+ f1 f2)))))

(fibo 7)  → 21

Event driven notification
=========================
When processes launched with spawn finish, an inlet function specified in the sync statement can be called.

(define (report pid)
    (println "process: " pid " has returned"))

; call the report function, when a child returns
(sync 10000 report)

======================
 19. MESSAGE EXCHANGE
======================

Parent and child processes started with spawn can exchange messages. Messages flow either from the parent to child processes or from child processes to the parent. By means of evaluating messages in the parent process, the parent process can be used as a proxy routing messages between child peers.

Internally newLISP uses UNIX local domain sockets for dual message queues between parent and child processes. When the receiving side of a queue is empty a receive call will return nil. Likewise when a queue is full, a send call will return nil. The looping function until can be used to make send and receive statements blocking.

Blocking message sending and receiving
======================================
     ; blocking sender
     (until (send pid msg))     ; true when a msg queued up

     ; blocking receiver
     (until (receive pid msg))  ; true after a msg is read

Blocking messages exchange
==========================
The parent process loops through all child process IDs and uses the (until (receive cpid msg)) form of receive to wait for pending messages. (sync) returns a list of all child PIDs from processes launched by spawn.

#!/usr/bin/newlisp

; child process transmits random numbers
(define (child-process)
    (set 'ppid (sys-info -4)) ; get parent pid
    (while true
        (until (send ppid (rand 100))))
)

; parent starts 5  child processes, listens and displays
; the true flag enables usage of send and receive

(dotimes (i 5) (spawn 'result (child-process) true))

(for (i 1 3)
    (dolist (cpid (sync)) ; iterate thru pending child PIDs
        (until (receive cpid msg))
        (print "pid:" cpid "->>" (format "%-2d  " msg)))
    (println)
)

(abort) ; cancel child-processes
(exit)

generates this output:

pid:53181->47  pid:53180->61  pid:53179->75  pid:53178->39  pid:53177->3
pid:53181->59  pid:53180->12  pid:53179->20  pid:53178->77  pid:53177->47
pid:53181->6   pid:53180->56  pid:53179->96  pid:53178->78  pid:53177->18

Non blocking message exchange
=============================
Neither the sending child process nor the receiving parent process block. Each sends and receives messages as fast as possible. There is no guarantee that all messages will be delivered. It depends on the size of the sending queue and the speed of pick-up of messages by the parent process. If the sending queue for a child process is full, the (send ppid (rand 100)) call will fail and return nil.

#!/usr/bin/newlisp

; child process transmits random numbers non-blocking
; not all calls succeed
(set 'start (time-of-day))

(define (child-process)
    (set 'ppid (sys-info -4)) ; get parent pid
    (while true
        (send ppid (rand 100)))
)

; parent starts 5  child processes, listens and displays
(dotimes (i 5) (spawn 'result (child-process) true))

(set 'N 1000)

(until finished
    (if (= (inc counter) N) (set 'finished true))
    (dolist (cpid (receive)) ; iterate thru ready child pids
        (receive cpid msg)
    (if msg (print "pid:" cpid "->" (format "%-2d  \r" msg))))
)

(abort) ; cancel child-processes
(sleep 300)

(exit)

Message timeouts
================
A messaging statement can be made to block for a certain time:

(define (receive-timeout pid msec)
    (let ( (start (time-of-day)) (msg nil))
        (until (receive pid msg)
            (if (> (- (time-of-day) start) 1000) (throw-error "timeout")))
    msg)
)
; use it

(receive-timeout pid 1000)  ; return message or throw error after 1 second

In this example blocking will occur for 1000 ms. Many methods exist to implement timeout behavior.

Evaluating messages
===================
Messages sent can contain expressions which can be evaluated in the recipient's environment. This way variables can be set in the evaluator's environment, and messages can be routed to other processes. The following example implements a message router:

#!/usr/bin/newlisp

; sender child process of the message
(set 'A (spawn 'result
    (begin
        (dotimes (i 3)
            (set 'ppid (sys-info -4))
            /* the following statement in msg will be evaluated in the proxy */
            (set 'msg '(until (send B (string "greetings from " A))))
            (until (send ppid msg)))
        (until (send ppid '(begin
            (sleep 200) ; make sure all else is printed
            (println "parent exiting ...\n")
            (set 'finished true))))) true))

; receiver child process of the message
(set 'B (spawn 'result
    (begin
        (set 'ppid (sys-info -4))
        (while true
            (until (receive ppid msg))
            (println msg)
            (unless (= msg (string "greetings from " A))
                (println "ERROR in proxy message: " msg)))) true))

(until finished (if (receive A msg) (eval msg))) ; proxy loop

(abort)
(exit)

Acting as a proxy
=================
In the last example program the expression:

; content of message to be evaluated by proxy
(until (send B (string "greetings from " A)))

A programming statement sent from child process ID A to the parent, where it is evaluated, causing a message to be sent to child process B. The parent process acts as a proxy agent for the child process A.

; the set statement is evaluated in the proxy
(until (send ppid '(set 'finished true)))

The expression (set 'finished true) is sent to the parent where it gets evaluated and causes the parent's until loop to finish.

The sleep statement in the A process ensures that the "parent exiting ..." message does not appear before all received messages are reported by process identified with B.

=================================
 20. DATABASES AND LOOKUP TABLES
=================================

For smaller tables of not more than a few hundred entries association lists can be used. For larger databases use dictionaries and hashes as described in chapter 11.

Association lists
=================
The association list is a classic LISP data structure for storing information for associative retrieval:

; creating association lists
; pushing at the end with -1 is optimized and
; as fast as pushing in front

(push '("John Doe" "123-5555" 1200.00) Persons -1)
(push '("Jane Doe" "456-7777" 2000.00) Persons -1)
.....

Persons →  (
("John Doe" "123-5555" 1200.00)
("Jane Doe" "456-7777" 2000.00) ...)

; access/lookup data records
(assoc "John Doe" Persons)

→ ("John Doe" "123-5555" 1200.00 male)

(assoc "Jane Doe" Persons)

→ ("Jane Doe" "456-7777" 2000.00 female)

newLISP has a lookup function similar to what is used in spreadsheet software. This function which works like a combination of assoc and nth can find the association and pick a specific member of the data record at the same time:

(lookup "John Doe" Persons 0)   → "123-555"
(lookup "John Doe" Persons -1)  → male
(lookup "Jane Doe" Persons 1)   → 2000.00
(lookup "Jane Doe" Persons -2)  → 2000.00

; update data records
(setf (assoc "John Doe" Persons)
    '("John Doe" "123-5555" 900.00 male))

; replace as a function of existing/replaced data
(setf (assoc "John Doe" Persons) (update-person $it))

; delete data records
(replace (assoc "John Doe" Persons) Persons)

Nested associations
===================
If the data part of an association is itself an association list, we have a nested association:

(set 'persons '(
    ("Anne" (address (country "USA") (city "New York")))
    ("Jean" (address (country "France") (city "Paris")))
))

A different syntax of the assoc function can be used to specify multiple keys:

; one key
(assoc "Anne" persons) → ("Anne" (address (country "USA") (city "New York")))

; two keys
(assoc '("Anne" address) persons) → (address (country "USA") (city "New York"))

; three keys
(assoc '("Anne" address city) persons) → (city "New York")

; three keys in a vector
(set 'anne-city '("Anne" address city))
(assoc anne-city persons) → (city "New York")

When all keys are symbols, as is in address, country and city, simple and nested associations in newLISP have the same format as newLISP FOOP (Functional Object Oriented Programming) objects. See the users manual chapter "18. Functional object-oriented programming" for details.

Updating nested associations
============================
The functions assoc and setf can be used to update simple or nested associations:

(setf (assoc '("Anne" address city) persons) '(city "Boston")) → (city "New York")
setf always returns the newly set element.

Combining associations and hashes
=================================
Hashes and FOOP objects can be combined to form an in-memory database with keyed access.

In the following example, data records are stored in a hash namespace and access is with the name of the person as a key.

setf and lookup are used to update nested FOOP objects:

(new Tree 'Person)
(new Class 'Address)
(new Class 'City)
(new Class 'Telephone)

(Person "John Doe" (Address (City "Small Town") (Telephone 5551234)))

(lookup 'Telephone (Person "John Doe"))
(setf (lookup 'Telephone (Person "John Doe")) 1234567)
(setf (lookup 'City (Person "John Doe")) (lower-case $it))

(Person "John Doe") → (Address (City "small town") (Telephone 1234567))

===========================
 21. DISTRIBUTED COMPUTING
===========================

Many of todays applications are distributed on to several computers on the network or distributed on to several processes on one CPU. Often both methods of distributing an application are used at the same time.

newLISP has facilities to evaluate many expressions in parallel on different network nodes or processes running newLISP. The net-eval function does all the work necessary to communicate to other nodes, distribute expressions for evaluation and collect results in either a blocking or event driven fashion.

The functions read-file, write-file, append-file and delete-file can also be used to access with files on remote nodes when using URLs in file specifications. In a similar way the functions load and save can be used to load and save code from and to remote nodes.

newLISP uses existing HTTP protocols and newLISP command line behavior to implement this functionality. This means that programs can be debugged and tested using standard Unix applications like terminal, telnet or a web browser. This also enables easy integration of other tools and programs into distributed applications built with newLISP. For example the Unix utility netcat (nc) could be used to evaluate expressions remotely or a web browser could be used to retrieve webpages from nodes running a newLISP server.

Setting up in server mode
=========================
A newLISP server node is essentially a newLISP process listening to a network port and behaving like a newLISP command-line console and HTTP server for HTTP GET, PUT, POST and DELETE requests. Since version 9.1 newLISP server mode also answers CGI queries received by either GET or POST request.

Two methods are used to start a newLISP server node. One results in a state full server, maintaining state in between communications with different clients, the other method a server with no state, reloading for every new client connection.

Start a state-full server
=========================
newlisp -c -d 4711 &

newlisp myprog.lsp -c -d 4711 &

newlisp myprog.lsp -c -w /home/node25 -d 4711 &
newLISP is now listening on port 4711, the & (ampersand) sign tells newLISP to run in the background (Unix only). The -c switch suppresses command line prompts. newLISP now behaves like a newLISP console without prompts listening on port 4711 for command line like input. Any other available port could have been chosen. Note that on Unix, ports below 1024 need administrator access rights.

The second example also pre-loads code. The third example also specifies a working directory using the -w option. If no working directory is specified using -w, the startup directory is assumed to be the working directory.

After each transaction, when a connection closes, newLISP will go through a reset process, reinitialize stack and signals and go to the MAIN context. Only the contents of program and variable symbols will be preserved.

Stateless server with inetd
===========================
On Unix the inetd or xindetd facility can be used to start a stateless server. In this case the TCP/IP net connections are managed by a special Unix utility with the ability to handle multiple requests at the same time. For each connection made by a client the inetd or xinetd utility will start a fresh newLISP process. After the connection is closed the newLISP process will shut down.

When nodes are not required to keep state, this is the preferred method for a newLISP server node, for handling multiple connections at the same time.

The inetd or xinetd process needs to be configured using configuration files found in the /etc directory of most Unix installations.

For both the inetd and xinetd configurations add the following line to the /etc/services file:

net-eval        4711/tcp     # newLISP net-eval requests

Note that any other port than 4711 could be supplied.

When configuring inetd add also the following lines to the /etc/inetd.conf file:

net-eval  stream  tcp  nowait  root  /usr/bin/newlisp -c

# as an alternative, a program can also be preloaded

net-eval  stream  tcp  nowait  root  /usr/bin/newlisp myprog.lsp -c

# a working directory can also be specified

net-eval  stream  tcp  nowait  newlisp  /usr/bin/newlisp -c -w /usr/home/newlisp

The last line also specified a working directory and a user newlisp instead of the root user. This is a more secure mode limiting newLISP server node access to a specific user account with restricted permissions.

On some Unix system a modern flavor of inetd: the xinetd facility can be used. Add the following configuration to a file /etc/xinet.d/net-eval:

service net-eval
    {
    socket_type = stream
    wait = no
    user = root
    server = /usr/bin/newlisp
    port = 4711
    server_args = -c -w /home/node
    }

Note that a variety of parameter combinations are possible to restrict access from different places or limit access to certain users. Consult the man-pages for inetd and xinetd for details.

After configuring inetd or xinetd either process must be restarted to re-read the configuration files. This can be accomplished by sending the Unix HUP signal to either the inetd or xinetd process using the Unix kill or Unix nohup utility.

On Mac OS X the launchd facility can be used in a similar fashion. The newLISP source distribution contains the file org.newlisp.newlisp.plist in the util/ directory. This file can be used to launch newlisp server during OS boot time as a persistent server.

Test the server with telnet
===========================
A newLISP server node can be tested using the Unix telnet utility:

telnet localhost 4711

; or when running on a different computer i.e. ip 192.168.1.100

telnet 192.168.1.100 4711

Multi-line expressions can be entered by enclosing them in [cmd], [/cmd] tags, each tag on a separate line. Both the opening and closing tags should be on separate lines. Although newLISP has a second, new multi-line mode for the interactive shell since version 10.3.0 without tags, when using netcat or other Unix utilities, multi-line expressions still have to be enclosed in [cmd], [/cmd] tags.

Test with netcat on Unix
========================
echo '(symbols) (exit)' | nc localhost 4711

Or talking to a remote node:

echo '(symbols) (exit)' | nc 192.168.1.100 4711

In both examples netcat will echo back the result of evaluating the (symbols) expression.

Multi-line expressions can be entered by enclosing them in [cmd], [/cmd] tags, each tag on a separate line.

Test from the command line
==========================
The net-eval function as a syntax form for connecting to only one remote server node. This mode is practical for quick testing from the newLISP command line:

(net-eval "localhost" 4711 "(+ 3 4)" 1000) → 7

; to a remote node

(net-eval "192.168.1.100" 4711 {(upper-case "newlisp")} 1000) → "NEWLISP"

In the second example curly braces {,} are used to limit the program string for evaluation. This way quotes can be used to limit a string inside the expression.

No [cmd], [/cmd] tags are required when sending multi-line expressions. net-eval supplies these tags automatically.

Test HTTP with a browser
========================
A newLISP server also understands simple HTTP GET and PUT requests. Enter the full path of a file in the address-bar of the browser:

http://localhost:4711//usr/share/newlisp/doc/newlisp_manual.html

The manual file is almost 800 Kbyte in size and will take a few seconds to load into the browser. Specify the port-number with a colon separated from the host-name or host IP. Note the double slash necessary to specify a file address relative to the root directory.

Evaluating remotely
===================
When testing the correct installation of newLISP server nodes, we were already sending expressions to remote node for evaluation. Many times remote evaluation is used to split up a lengthy task into shorter subtasks for remote evaluation on different nodes.

The first example is trivial, because it only evaluates several very simple expressions remotely, but it demonstrates the principles involved easily:

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

Running this program will produce the following output:

result: (7 11 15 19 23)

When running Unix and using an inetd or xinetd configured newLISP server, the servers and programs can be run on just one CPU, replacing all IP numbers with "localhost" or the same local IP number. The indetd or xinetd daemon will then start 5 independent newLISP processes. On Win32 5 state-full newLISP servers could be started on different port numbers to accomplish the same.

Instead of collecting all results at once on the return of net-eval, a callback function can be used to receive and process results as they become available:

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

While net-eval is waiting for results, it calls the function idle-loop repeatedly with parameter p. The parameter p is nil when no result was received during the last 1000 milli seconds, or p contains a list sent back from the remote node. The list contains the remote address and port and the evaluation result. The example shown would generate the following output:

("192.168.1.100" 4711 7)
("192.168.1.101" 4711 11)
("192.168.1.102" 4711 15)
("192.168.1.103" 4711 19)
("192.168.1.104" 4711 23)

For testing on just one CPU, replace addresses with "localhost"; the Unix inetd or xinetd daemon will start a separate process for each connection made and all listening on port 4711. When using a state-full server on the same Win32 CPU specify a different port number for each server.

Setting up the 'net-eval' parameter structure
=============================================
In a networked environment where an application gets moved around, or server nodes with changing IP numbers are used, it is necessary to set up the node parameters in the net-eval parameter list as variables. The following more complex example shows how this can be done. The example also shows how a bigger piece of program text can be transferred to a remote node for evaluation and how this program piece can be customized for each node differently:

#!/usr/bin/newlisp

; node parameters
(set 'nodes '(
    ("192.168.1.100" 4711)
    ("192.168.1.101" 4711)
    ("192.168.1.102" 4711)
    ("192.168.1.103" 4711)
    ("192.168.1.104" 4711)
))

; program template for nodes
(set 'program [text]
    (begin
        (map set '(from to node) '(%d %d %d))
        (for (x from to)
		(if (= 1 (length (factor x)))
        (push x primes -1)))
    primes)
[/text])

; call back routine for net-eval
(define (idle-loop p)
    (when p
        (println (p 0) ":" (p 1))
        (push (p 2) primes))
)

(println "Sending request to nodes, and waiting ...")

; machines could be on different IP addresses.
; For this test 5 nodes are started on localhost
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

At the beginning of the program a nodes list structure contains all the relevant node information for hostname and port.

The program calculates all prime numbers in a given range. The from, to and node variables are configured into the program text using format. All instructions are placed into a begin expression block, so only one expression result will be send back from the remote node.

Many other schemes to configure a net-eval parameter list are possible. The following scheme without idle-loop would give the same results:

(set 'node-eval-list (list
    (list (nodes 0 0) (nodes 0 1) (format program 0 99999 1))
    (list (nodes 1 0) (nodes 1 1) (format program 100000 199999 2))
    (list (nodes 2 0) (nodes 2 1) (format program 200000 299999 3))
    (list (nodes 3 0) (nodes 3 1) (format program 300000 399999 4))
    (list (nodes 4 0) (nodes 4 1) (format program 400000 499999 5))
))

(set 'result (net-eval node-eval-list  20000))

The function idle-loop aggregates all lists of primes received and generates the following output:

192.168.1.100:4711
192.168.1.101:4711
192.168.1.102:4711
192.168.1.103:4711
192.168.1.104:4711

As with the previous examples all IP numbers could be replaced with "localhost" or any other host-name or IP number to test a distributed application on a single host before deployment in a distributed environment with many networked hosts.

Transferring files
==================
Files can be read from or written to remote nodes with the same functions used to read and write files to a local file system. This functionality is currently only available on Unix systems when talking to newLISP servers. As functions are based on standard GET and PUT HTTP protocols they can also be used communicating with web servers. Note that few Apache web-server installations have enabled the PUT protocol by default.

The functions read-file, write-file and append-file can all take URLs in their filename specifications for reading from and writing to remote nodes running a newLISP server or a web-server:

(write-file "http://127.0.0.1:4711//Users/newlisp/afile.txt" "The message - ")
→ "14 bytes transferred for /Users/newlisp/afile.txt\r\n"

(append-file "http://127.0.0.1:4711//Users/newlisp/afile.txt" "more text")
→ "9 bytes transferred for /Users/newlisp/afile.txt\r\n"

(read-file "http://127.0.0.1:4711//Users/newlisp/afile.txt")
→ "The message - more text"

The first two function return a message starting with the numbers of bytes transferred and the name of the remote file affected. The read-file function returns the contents received.

Under all error conditions an error message starting with the characters ERR: would be returned:

(read-file "http://127.0.0.1:4711//Users/newlisp/somefile.txt")
→ "ERR:404 File not found: /Users/newlisp/somefile.txt\r\n"

Note the double backslash necessary to reference files relative to root on the server node.

All functions can be used to transfer binary non-ascii contents containing zero characters. Internally newLISP uses the functions get-url and put-url, which could be used instead of the functions read-file, write-file and append-file. Additional options like used with get-url and put-url could be used with the functions read-file, write-file and append-file as well. For more detail see the newLISP function reference for these functions.

Loading and saving data
=======================
The same load and save functions used to load program or LISP data from a local file system can be used to load or save programs and LISP data from or to remote nodes.

By using URLs in the file specifications of load and save these functions can work over the network communicating with a newLISP server node.:

(load "http://192.168.1.2:4711//usr/share/newlisp/mysql5.lsp")

(save "http://192.168.1.2:4711//home/newlisp/data.lsp" 'db-data)

Although the load and save functions internally use get-url and put-url to perform its works they behave exactly as when used on a local file system, but instead of a file path URLs are specified. Both function will timeout after 60 seconds if a connection could not be established. When finer control is necessary use the functions get-url and put-url together with eval-string and source to realize a similar result as when using the load and save in HTTP mode.

Local domain Unix sockets
=========================
newLISP supports named local domain sockets in newLISP server mode and using the built-in functions net-eval, net-listen, net-connect together with the functions net-accept, net-receive, net-select and net-send.

Using local domain sockets fast communications between processes on the same file system and with newLISP servers is possible. See the Users Manual for more details.

================================
 22. HTTPD WEB SERVER ONLY MODE
================================

In all previous chapters the -c server mode was used. This mode can act as a net-eval server and at the same time answer HTTP requests for serving web pages or transfer of files and programs. The -c mode is the preferred mode for secure operation behind a firewall. newLISP also has a -http mode which works like a restricted -c mode. In -http mode only HTTP requests are served and command-line like formatted requests and net-eval requests are not answered. In this mode newLISP can act like a web server answering HTTP GET, PUT, POST and DELETE requests as well as CGI requests, but additional efforts should be made to restrict the access to unauthorized files and directories to secure the server when exposed to the internet.

Environment variables
=====================
In both server modes -c and -http the environment variables DOCUMENT_ROOT, REQUEST_METHOD, SERVER_SOFTWARE and QUERY_STRING are set. The variables CONTENT_TYPE, CONTENT_LENGTH, HTTP_HOST, HTTP_USER_AGENT and HTTP_COOKIE are set too if present in the HTTP header sent by the client.

Pre-processing the request
==========================
When the newLISP server answers any kind of requests (HTTP and command line), the newLISP function command-event can be used to pre-process the request. The pre-processing function can be loaded from a file httpd-conf.lsp when starting the server:

server_args = httpd-conf.lsp -http -w /home/node

The above snippet shows part of a xinetd configuration file. A startup program httpd-conf.lsp has been added which will be loaded upon invocation of newLISP. The -c options has been replaced with the -http option. Now neither net-eval nor command-line requests will be answered but only HTTP requests.

The startup file could also have been added the following way when starting the server in the background from a command shell, and httpd-conf.lsp is in the current directory:

newlisp httpd-conf.lsp -http -d 80 -w /home/www &

All requests will be pre-processed with a function specified using command-event in httpd-conf.lsp:

; httpd-conf.lsp
;
; filter and translate HTTP request for newLISP
; -c or -http server modes
; reject query commands using CGI with .exe files

(command-event (fn (s)
    (let (request nil)
    (if (find "?" s) ; is this a query
        (begin
            (set 'request (first (parse s "?")))
            ; discover illegal extension in queries
            (if (ends-with request ".exe")
                (set 'request "GET /errorpage.html")
                (set 'request s)))
        (set 'request s))
    request)
))
 ; eof

All CGI requests files ending with .exe would be rejected and the request translated into the request of an error page.

CGI processing in HTTP mode
===========================
On http://www.newlisp.org various CGI examples can be found. In the download directory at http://www.newlisp.org/downloads two more complex applications can be found: newlisp-ide is a web based IDE and newlisp-wiki is a content management system which also runs the [http://www.newlisp.org www.newlisp.org] website.

CGI program files must have the extension .cgi and have executable permission on Unix.

The following is a minimum CGI program:

#!/usr/bin/newlisp

(print "Content-type: text/html\r\n\r\n")
(println "<h2>Hello World</h2>")
(exit)

newLISP normally puts out a standard HTTP/1.0 200 OK\r\n response header plus a Server: newLISP v. ...\r\n header line. If the first line of CGI program output starts with "Status:" then newLISP's standard header output is suppressed, and the CGI program must supply the full status header by itself. The following example redirects a request to a new location:

#!/usr/bin/newlisp
(print "Status: 301 Moved Permanently\r\n")
(print "Location: http://www.newlisp.org/index.cgi\r\n\r\n")
(exit)

A newLISP installation contains a module file cgi.lsp. This module contains subroutines for extracting parameters from HTTP GET and POST requests, extract or set cookies and other useful routines when writing CGI files. See the modules section at: http://www.newlisp.org/modules/.

Media types in HTTP modes
=========================
In both the -c and -http HTTP modes the following file types are recognized and a correctly formatted Content-Type: header is sent back:

file extension	media type
.avi	video/x-msvideo
.css	text/css
.gif	image/gif
.htm	text/htm
.html	text/html
.jpg	image/jpg
.js	application/javascript
.mov	video/quicktime
.mp3	audio/mpeg
.mpg	video/mpeg
.pdf	application/pdf
.png	image/png
.wav	audio/x-wav
.zip	application/zip
any other	text/plain

=======================
 23. EXTENDING NEWLISP
=======================

newLISP has an import function, which allows importing function from DLLs (Dynamic Link Libraries) on Win32 or shared libraries on Linux/Unix (ending in .so, ending in .dylib on Mac OS X).

Simple versus extended FFI interface
====================================
In version 10.4.0 newLISP introduced an extended syntax for the import, callback and struct functions and for the pack and unpack support functions. This extended syntax is only available on newLISP versions built with libffi . All standard binary versions distributed on www.newlisp.org are enabled to use the new extensions additionally to the simpler API. The simpler API is used by all standard extension modules part of the distribution except for the module gsl.lsp.

The extended syntax allows specifying C-language types for parameter and return values of imported functions and for functions registered as callbacks. The extended syntax also allows handling of floating point values and C-structures in parameters and returns. Handling of floating point types was either impossible or unreliable using the simple API that depended on pure cdecl calling conventions. These are not available on all platforms. The extended API also handles packing and unpacking of C-structures with automatic alignment of C-types on different CPU architectures. See the extended syntax of the pack and unpack functions in the User Manual and Reference and OpenGL demo.

The following chapters describe the older simple API. Much of it is applicable to the extended API as well. For details on the new API, consult the User Manual and Reference for the functions import, callback, struct, pack and unpack.

A shared library in C
=====================
This chapter shows how to compile and use libraries on both, Win32 and Linux/Unix platforms. We will compile a DLL and a Linux/Unix shared library from the following 'C' program.

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

Both functions foo1 and foo2 print their arguments, but while foo1 returns the number multiplied 10 times, foo2 returns the uppercase of a string to show how to return strings from 'C' functions.

Compile on Unix
===============
On Mac OS X and Linux/Unix we can compile and link testlib.so in one step:

gcc testlib.c -shared -o testlib.so

Or On Mac OSX/darwin do:

gcc testlib.c -bundle -o testlib.dylib

The library testlib.so will be built with Linux/Unix default cdecl conventions. Importing the library is very similar on both Linux and Win32 platforms, but on Win32 the library can be found in the current directory. You may have to specify the full path or put the library in the library path of the os:

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

Again, the number returned from foo2 is the string address pointer and get-string can be used to access the string. When using get-string only character up to a zero byte are returned. When returning the addresses to binary buffers different techniques using unpack are used to access the information.

Compile a DLL on Win32
======================
DLLs on Win32 can be made using the MinGW, Borland or CYGWIN compilers. This example shows, how to do it using the MinGW compiler.

Compile it:

gcc -c testlib.c -o testlib.o

Before we can transform testlib.o into a DLL we need a testlib.def declaring the exported functions:

LIBRARY  testlib.dll
EXPORTS
         foo1
         foo2

Now wrap the DLL:

dllwrap testlib.o --def testlib.def -o testlib.dll -lws2_32

The library testlib.dll will be built with default Win32 stdcall conventions. The following shows an interactive session, importing the library and using the functions:

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

>
; import a library compiled for cdecl
; calling conventions
> (import "foo.dll" "func" "cdecl")

Note that the first time using foo2 the return value 4054088 is the memory address of the string returned. Using get-string the string belonging to it can be accessed. If the library is compiled using cdecl calling conventions, the cdecl keyword must be used in the import expression.

Importing data structures
=========================
Just like 'C' strings are returned using string pointers, 'C' structures can be returned using structure pointers and functions like get-string, get-int or get-char can be used to access the members. The following example illustrates this:

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

The newLISP program would access the structure members as follows:

> (set 'astruc (foo3 "hello world" 123))
4054280

> (get-string (get-integer (+ astruc 4)))
"hello world"

> (get-integer astruc)
123
>
The return value from foo3 is the address to the structure astruc. To access the string pointer, 4 must be added as the size of an integer type in the 'C' programming language. The string in the string pointer then gets accessed using get-string.

Memory management
=================
Any allocation performed by imported foreign functions has to be deallocated manually if there's no call in the imported API to do so. The libc function free can be imported and used to free memory allocated inside imported functions:

(import "/usr/lib/libc.so" "free")

(free astruc) ; astruc contains memory address of allocated structure

In case of calling foreign functions with passing by reference, memory for variables needs to be allocated beforehand by newLISP, and hence, memory needs not be deallocated manually.

Unevenly aligned structures
===========================
Sometimes data structures contain data types of different length than the normal CPU register word:

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

The x and y variables are 16 bit wide and only z takes 32 bit. When a compiler on a 32-bit CPU packs this structure the variables x and y will each fill up 32 bits instead of the 16 bit each. This is necessary so the 32-bit variable z can be aligned properly. The following code would be necessary to access the structure members:

> (import "/usr/home/nuevatec/test.so" "foo")
foo <281A1588>

> (unpack "lu lu lu" (foo))
(123 12 456)

The whole structure consumes 3 by 4 = 12 bytes, because all members have to be aligned to 32 bit borders in memory.

The following data structure packs the short 16 bit variables next to each other. This time only 8 bytes are required: 2 each for x and y and 4 bytes for z. Because x and y are together in one 32-bit word, none of the variables needs to cross a 32-bit boundary:

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

This time the access code in newLISP reflects the size of the structure members:

> (import "/usr/home/nuevatec/test.so" "foo")
foo <281A1588>

> (unpack "u u lu" (foo))
(123 456 8)

Passing parameters
==================
data Type	newLISP call	C function call
integer	(foo 123)	foo(int number)
double float	(foo 1.234)	foo(double number)
float	(foo (flt 1.234))	foo(float number)
string	(foo "Hello World!")	foo(char * string)
integer array	(foo (pack "d d d" 123 456 789))	foo(int numbers[])
float array	(foo (pack "f f f" 1.23 4.56 7.89))	foo(float[])
double array	(foo (pack "lf lf lf" 1.23 4.56 7.89)	foo(double[])
string array	(foo (pack "lu lu lu" "one" "two" "three")))	foo(char * string[])

Note that floats and double floats are only passed correctly on x86 platforms with cdecl calling conventions or when passed by pointer reference as in variable argument functions, i.e: printf(). For reliable handling of single and double precision floating point types and for advanced usage of pack and unpack for handling C-structures, see the descriptions of the import, callback and struct functions in the newLISP User Manual and Reference.

pack can receive multiple arguments after the format specifier in a list too:

(pack "lu lu lu" '("one" "two" "three"))

Extracting return values
========================
data Type	newLISP to extract return value	C return
integer	(set 'number (foo x y z))	return(int number)
double float	n/a - only 32bit returns, use double float pointer instead	not available
double float ptr	(set 'number (get-float (foo x y z)))	return(double * numPtr)
float	not available	not available
string	(set 'string (get-string (foo x y z)	return(char * string)
integer array	(set 'numList (unpack "ld ld ld" (foo x y z)))	return(int numList[])
float array	(set 'numList (unpack "f f f" (foo x y z)))	return(float numList[])
double array	(set 'numList (unpack "lf lf lf" (foo x y z)))	return(double numList[])
string array	(set 'stringList (map get-string (unpack "ld ld ld" (foo x y z))))	return(char * string[])

Floats and doubles can only be returned via address pointer references.

When returning array types the number of elements in the array must be known. The examples always assume 3 elements.

All pack and unpack and formats can also be given without spaces, but are spaced in the examples for better readability.

The formats "ld" and "lu" are interchangeable, but the 16-bit formats "u" and "d" may produce different results, because of sign extension when going from unsigned 16 bits to signed 32 or 64-bits bits of newLISP's internal integer format.

Flags are available for changing endian byte order during pack and unpack.

Writing library wrappers
========================
Sometimes the simple version of newLISP's built-in import facility cannot be used with a library. This happens whenever a library does not strictly adhere to cdecl calling conventions expecting all parameters passed on the stack. E.g. when running Mac OS X on older PPC CPUs instead of Intel CPUs, the OpenGL libraries installed by default on Mac OS X cannot be used.

Since newLISP version 10.4.0, the problem can be solved easiest using the newer extended syntax of import, which automatically resolves platform and architectural differences. On very small systems or whenever the needed libffi system library is not present on a platform, a special wrapper library can be built to translate cdecl conventions expected by newLISP into the calling conventions expected by the target library.

/* wrapper.c - demo for wrapping library function

compile:

    gcc -m32 -shared wrapper.c -o wrapper.so
or:
    gcc -m32 -bundle wrapper.c -o wrapper.dylib

usage from newLISP:

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

Registering callbacks in external libraries
===========================================
Many shared libraries allow registering callback functions to call back into the controlling program. The function callback is used in newLISP to extract the function address from a user-defined newLISP function and pass it to the external library via a registering function:

(define (keyboard key x y)
    (if (= (& key 0xFF) 27) (exit)) ; exit program with ESC
    (println "key:" (& key 0xFF) " x:" x  " y:" y))

(glutKeyboardFunc (callback 1 'keyboard))

The example is a snippet from the file opengl-demo.lsp in the newlisp-x.x.x/examples/ directory of the source distribution. A file win32demo.lsp can be found in the same directory demonstrating callbacks on the Windows platform.

For an advanced syntax of callback using C-type specifiers see newLISP User Manual and Reference.

=================================
 24. NEWLISP AS A SHARED LIBRARY
=================================

On all platforms, newLISP can be compiled as a shared library. On Win32, the library is called newlisp.dll, on Mac OS X newlisp.dylib and on Linux and BSDs, the library is called newlisp.so. Makefiles are included in the source distribution for most platforms. Only on Win32, the installer comes with a precompiled newlisp.dll and will install it in the Program Files/newlisp/ directory.

Evaluating code in the shared library
=====================================
The first example shows how to import newlispEvalStr from newLISP itself as the caller:

(import "/usr/lib/newlisp.so" "newlispEvalStr")
(get-string (newlispEvalStr "(+ 3 4)")) →  "7\n"

When calling the library function newlispEvalStr, output normally directed to the console (e.g. return values or print statements) is returned in the form of an integer string pointer. The output can be accessed by passing this pointer to the get-string function. To silence the output from return values, use the silent function. All Results, even if they are numbers, are always returned as strings and a trailing linefeed as in interactive console mode. Use the int or float functions to convert the strings to other data types.

When passing multi-line source to newlispEvalStr, that source should be bracketed by [cmd], [/cmd] tags, each on a different line:

(set 'code [text][cmd]
...
...
...
[/cmd][/text])

The second example shows how to import newlispEvalStr into a C-program:

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

This program will accept quoted newLISP expressions and print the evaluated results.

Registering callbacks
=====================
Like many other share libraries, callbacks can be registered in newLISP library. The function newlispCallback must be imported and is used for registering callback functions. The example shows newLISP importing newLISP as a library and registering a callback callme:

#!/usr/bin/newlisp

; path-name of the library depending on platform
(set 'LIBRARY (if (= ostype "Win32") "newlisp.dll" "newlisp.dylib"))

; import functions from the newLISP shared library
(import LIBRARY "newlispEvalStr")
(import LIBRARY "newlispCallback")

; set calltype platform specific
(set 'CALLTYPE (if (= ostype "Win32") "stdcall" "cdecl"))

; the callback function
(define (callme p1 p2 p3 result)
    (println "p1 => " p1 " p2 => " p2 " p3 => " p3)
    result)

; register the callback with newLISP library
(newlispCallback "callme" (callback 0 'callme) CALLTYPE)

; the callback returns a string
(println (get-string (newlispEvalStr
    {(get-string (callme 123 456 789 "hello world"))})))

; the callback returns a number
(println (get-string (newlispEvalStr
    {(callme 123 456 789 99999)})))

Depending on the type of the return value, different code is used. The program shows the following output:

p1 => 123 p2 => 456 p3 => 789
"hello world"

p1 => 123 p2 => 456 p3 => 789
99999

Note that Win32 and many Unix flavors will look for newlisp.dll in the system library path, but Mac OS X will look for newlisp.dylib first in the current directory, if the full file path is not specified. The program above can also be found as callback in the source distribution in the newlisp-x.x.x/examples directory.

