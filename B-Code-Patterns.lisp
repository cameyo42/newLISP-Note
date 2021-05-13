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

La funzione foo: foo è chiamata funzione di default, perché quando si usa il nome di contesto foo come una funzione, sarà di default foo:foo.

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
Tutte le funzioni di ciclo come doargs, dolist, dostring, dotimes, dotree e for usano le variabili locali. Durante l'esecuzione del ciclo, la variabile assume valori diversi. Ma dopo aver lasciato la funzione di ciclo, la variabile riacquista il suo vecchio valore. Le espressioni let, define e lambda sono un altro metodo per rendere le variabili locali.

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

Utilizzando la funzione integrata flat una lista annidata può essere trasformata in una lista semplice. Ora la lista può essere elaborata con dolist o con map:

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

newLISP dispone di funzionalità per l'indicizzazione multidimensionale in elenchi annidati. Ci sono funzioni distruttive come push, pop, setf, set-ref, set-ref-all, sort e reverse e molte altre per operazioni non distruttive, come nth, ref, ref-all, first, last e rest ecc .. In newLISP, molte delle funzioni per le lista funzionano anche sulle stringhe.

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
Per aggiungere a una lista usa push, per eliminare un elemento da una lista usa pop. Entrambe le funzioni sono distruttive e modificano il contenuto della lista:

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
Lists can be filtered, returning only those elements that meet a specific condition:
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
setf può essere utilizzato per modificare un elemento della lista facendo riferimento ad esso con nth o assoc:

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
La variabile di sistema anaforica interna $it contiene il vecchio elemento della lista. Questa può essere usata per creare il nuovo elemento:

(set 'L '(0 0 0))
(setf (L 1) (+ $it 1)) → 1 ; il nuovo valore
(setf (L 1) (+ $it 1)) → 2
(setf (L 1) (+ $it 1)) → 4
L → '(0 3 0)

Le seguenti funzioni usano l'anaforico $it: find-all, if, replace, set-ref, set-ref-all e setf setq.

Sostituzioni in liste semplici
==============================
Replace, che può essere utilizzato anche su stringhe, può cercare e sostituire più elementi contemporaneamente in una lista. Insieme a match e unify, è possibile specificare modelli di ricerca complessi. Come con setf, l'espressione di sostituzione può utilizzare il contenuto del vecchio elemento per formare la sostituzione.

(set 'aList '(a b c d e a b c d))

(replace 'b aList 'B) → (a B c d e a B c d)

La funzione replace può usare una funzione di confronto per selezionare gli elementi della lista:

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

Sostituzioni in elenchi annidati
================================
Sometimes lists are nested, e.g. the SXML results from parsing XML. The functions ref-set, set-ref and set-ref-all can be used to find a single element or all elements in a nested list, and replace it or all.

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(set-ref 'monday data tuesday)
→ ((tuesday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1)))
The function set-ref-all does a set-ref multiple times, replacing all found occurrences of an element.

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(set-ref-all 'apples data "Apples")
→ ((monday ("Apples" 20 30) (oranges 2 4 9)) (tuesday ("Apples" 5) (oranges 32 1)))

Like find, replace, ref and ref-all, more complex searches can be expressed using match or unify:

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(set-ref-all '(oranges *) data (list (first $0) (apply + (rest $it))) match)
→ ((monday (apples 20 30) (oranges 15)) (tuesday (apples 5) (oranges 33)))

The last example shows how $0 can be used to access the old list element in the updating expression. In this case the numbers for oranges records have been summed. Instead of $0 the anaphoric system variable $it can also be used.

Passing lists by reference
==========================
Sometimes a larger list (more than a few hundred elements) must be passed to a user-defined function for elements in it to be changed. Normally newLISP passes all parameters to user-defined functions by value. But the following snippet shows a technique that can be used to pass a bigger list or string object by reference:

(set 'data:data '(a b c d e f g h))

(define (change db i value)
    (setf (db i) value))

(change data 3 999) → d

data:data → '(a b c 999 d e f g h)
In this example the list is encapsulated in a context named data holding a variable data with the same name.

Whenever a function in newLISP looks for a string or list parameter, a context can be passed, which will then be interpreted as the default functor.

When returning a list or array or an element belonging to a list or array referenced by a symbol, many built-in functions return a //reference// to the list – not a copy. This can be used to nest built-in functions when modifying a list:

(set 'L '(r w j s r b))

(pop (sort L)) → b

L → (j r r s w)

Variable expansion
==================
Two functions are available to do macro-expansion: expand and letex. The expand function has three different syntax patterns.

Symbols get expanded to their value:

; expand from one or more listed symbols
(set 'x 2 'a '(d e))
(expand '(a x (b c x)) 'x 'a)  → ((d e) 2 (b c 2))

expand is useful when composing lambda expressions or when doing variable expansion inside functions and function macros (fexpr with define-macro):

; use expansion inside a function
(define (raise-to power)
    (expand (fn (base) (pow base power)) 'power))
(define square (raise-to 2))
(define cube (raise-to 3))
(square 5)  → 25
(cube 5)    → 125

expand can take an association list:

; expand from an association list
(expand '(a b c) '((a 1) (b 2)))                → (1 2 c)
(expand '(a b c) '((a 1) (b 2) (c (x y z))))    → (1 2 (x y z))

and the value part in associations can be evaluated first:

; evaluate the value parts in the association list before expansion
(expand '(a b) '((a (+ 1 2)) (b (+ 3 4))))      → ((+ 1 2) (+ 3 4))
(expand '(a b) '((a (+ 1 2)) (b (+ 3 4))) true) → (3 7)

expand does its work on variables starting with an uppercase letter when expansion variables have neither been specified stand-alone nor in an association list.

; expand from uppercase variables
(set 'A 1 'Bvar 2 'C nil 'd 5 'e 6)
(expand '(A (Bvar) C d e f))  → (1 (2) C d e f)

Using this, a previous function definition can be made even shorter.

; use expansion from uppercase variables in function factories
(define (raise-to Power)
    (expand (fn (base) (pow base Power))))
(define cube (raise-to 3)) → (lambda (base) (pow base 3))
(cube 4) → 64

The letex function works like expand, but expansion symbols are local to the letex expression.

; use letex for variable expansion
(letex ( (x 1) (y '(a b c)) (z "hello") ) '(x y z)) → (1 (a b c) "hello")

Note that in the example the body expression in letex: (x y z) is quoted to prevent evaluation.

Destructuring nested lists
==========================
The following method can be used to bind variables to subparts of a nested list:

; uses unify together with bind for destructuring
(set 'structure '((one "two") 3 (four (x y z))))
(set 'pattern '((A B) C (D E))) ; unify needs uppercase for binding
(bind (unify pattern structure))
A → one
B → "two"
C → 3
D → four
E → (x y z)

=========================
 7. FLUSSO DEL PROGRAMMA
=========================

Program flow in newLISP is mostly functional but it also has looping and branching constructs and a catch and throw to break out of the normal flow.

Looping expressions as a whole behave like a function or block returning the last expression evaluated.

Loops
=====
Most of the traditional looping patterns are supported. Whenever there is a looping variable, it is local in scope to the loop, behaving according the rules of dynamic scoping inside the current name-space or context:

; loop a number of times
; i goes from 0 to N - 1
(dotimes (i N)
    ....
)

; demonstrate locality of i
(dotimes (i 3)
    (print i ":")
    (dotimes (i 3) (print i))
    (println)
)

→ ; will output
 0:012
 1:012
 2:012

; loop through a list
; takes the value of each element in aList
(dolist (e aList)
    ...
)

; loop through a string
; takes the ASCII or UTF-8 value of each character in aString
(dostring (e aString)
    ...
)

; loop through the symbols of a context in
; alphabetical order of the symbol name
(dotree (s CTX)
    ...
)

; loop from to with optional step size
; i goes from init to <= N inclusive with step size step
; Note that the sign in step is irrelevant, N can be greater
; or less then init.
(for (i init N step)
    ...
)

; loop while a condition is true
; first test condition then perform body
(while condition
    ...
)

; loop while a condition is false
; first test condition then perform body
(until condition
    ...
)

; loop while a condition is true
; first perform body then test
; body is performed at least once
(do-while condition
    ...
)

; loop while a condition is false
; first perform body then test
; body is performed at least once
(do-until condition
    ...
)
Note that the looping functions dolist, dotimes and for can also take a break condition as an additional argument. When the break condition evaluates to true the loop finishes:

(dolist (x '(a b c d e f g) (= x 'e))
    (print x))
→ ; will output
 abcd
 
Blocks
======
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