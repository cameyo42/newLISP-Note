==========================

 newLISP 99 PROBLEMI (28)

==========================

Questi problemi sono stati creati inizialmente per essere risolti con il linguaggio Prolog.
Poi è stata la volta dei linguaggi Lisp, Haskell e Scheme... e adesso newLISP.
Potete trovare l'elenco completo dei problemi in diversi siti:

https://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html
https://www.informatimago.com/develop/lisp/l99/index.html
http://beta-reduction.blogspot.com/search/label/L-99%3A%20Ninety-Nine%20Lisp%20Problems

In questo capitolo vengono risolti solo i primi 28 problemi relativi alla elaborazione di liste. 
Molti problemi successivi al numero 28 sono risolti in altri capitoli di questo documento e sono contrassegnati con il simbolo (+).
In alcuni problemi vengono presentate due soluzioni, una in stile LISP e una in stile newLISP.
-----------------------------------------------------------------------------

---------------
Elenco problemi
---------------

Elaborazione di liste
---------------------
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

Arithmetic (Aritmetica)
-----------------------
N-99-31  Determine whether a given integer number is prime (+)
N-99-32  Determine the greatest common divisor of two positive integer numbers (+)
N-99-33  Determine whether two positive integer numbers are coprime (+)
N-99-34  Calculate Euler's totient function phi(m) (+)
N-99-35  Determine the prime factors of a given positive integer (+)
N-99-36  Determine the prime factors of a given positive integer (2) (+)
N-99-37  Calculate Euler's totient function phi(m) (improved) (+)
N-99-38  Compare the two methods of calculating Euler's totient function (+)
N-99-39  A list of prime numbers (+)
N-99-40  Goldbach's conjecture (+)
N-99-41  A list of Goldbach compositions

Logic and Codes (Logica e Codici)
---------------------------------
N-99-46  Truth tables for logical expressions (+)
N-99-47  Truth tables for logical expressions (2) (+)
N-99-48  Truth tables for logical expressions (3) (+)
N-99-49  Gray code (+)
N-99-50  Huffman code

Binary trees (Alberi Binari)
----------------------------
N-99-54A Check whether a given term represents a binary tree
N-99-55  Construct completely balanced binary trees
N-99-56  Symmetric binary trees
N-99-57  Binary search trees (dictionaries)
N-99-58  Generate-and-test paradigm
N-99-59  Construct height-balanced binary trees
N-99-60  Construct height-balanced binary trees with a given number of nodes
N-99-61  Count the leaves of a binary tree
N-99-61A Collect the leaves of a binary tree in a list
N-99-62  Collect the internal nodes of a binary tree in a list
N-99-62B Collect the nodes at a given level in a list
N-99-63  Construct a complete binary tree
N-99-64  Layout a binary tree (1)
N-99-65  Layout a binary tree (2)
N-99-66  Layout a binary tree (3)
N-99-67  A string representation of binary trees
N-99-68  Preorder and inorder sequences of binary trees
N-99-69  Dotstring representation of binary trees
N-99-70  Tree construction from a node string

Multiway Trees (Alberi n-ari)
-----------------------------
N-99-70B Check whether a given term represents a multiway tree
N-99-70C Count the nodes of a multiway tree
N-99-71  Determine the internal path length of a tree
N-99-72  Construct the bottom-up order sequence of the tree nodes
N-99-73  Lisp-like tree representation

Graphs (Grafi)
--------------
N-99-80  Conversions
N-99-81  Path from one node to another one
N-99-82  Cycle from a given node
N-99-83  Construct all spanning trees
N-99-84  Construct the minimal spanning tree
N-99-85  Graph isomorphism
N-99-86  Node degree and graph coloration
N-99-87  Depth-first order graph traversal (alternative solution)
N-99-88  Connected components (alternative solution)
N-99-89  Bipartite graphs

Miscellaneous Problems (Problemi Vari)
--------------------------------------
N-99-90  Eight queens problem (+)
N-99-91  Knight's tour (+)
N-99-92  Von Koch's conjecture
N-99-93  An arithmetic puzzle (+)
N-99-94  Generate K-regular simple graphs with N nodes
N-99-95  English number words (+)
N-99-96  Syntax checker (alternative solution with difference lists)
N-99-97  Sudoku (+)
N-99-98  Nonograms
N-99-99  Crossword puzzle
-----------------------------------------------------------------------------


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

Metodo newLISP: indicizzazione implicita e esplicita

Indicizzazione implicita:
(setq lst '(1 2 3))
;-> (1 2 3)
(lst -2)
;-> 2
(lst -4)
;-> ERR: invalid list index

Indicizzazione esplicita:
(nth -2 lst)
;-> 2


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

Metodo newLISP: indicizzazione implicita e esplicita

Indicizzazione implicita:
('(1 2 3 4 5) 4)
;-> 5
('(1 2 3 4 5) 6)
;-> ERR: invalid list index

Indicizzazione esplicita:
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

Vediamo un altro esempio di applicazione di "fold-left":

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

La funzione "fold-right" con operatore "cons" e la lista vuota '() come valore iniziale, produce una copia della lista passata.

(fold-right cons '(4 3 2 1) '())
;-> (4 3 2 1)

Ritorniamo al nostro problema, scriviamo la funzione inverti-fold e vediamo come funziona la valutazione:

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

Funzione predefinita newLISP: (flat lst)

(flat '((1 2) ((2 (3)) (4 4)) (((7)))))
;-> (1 2 2 3 4 4 7)

Possiamo anche specificare quante annidamenti vogliamo rimuovere:

(flat '((1 2) ((2 (3)) (4 4)) (((7)))) 1)
;-> (1 2 (2 (3)) (4 4) ((7)))

(flat '((1 2) ((2 (3)) (4 4)) (((7)))) 2)
;-> (1 2 2 (3) 4 4 (7))


=======================================================
N-99-08 Elimina gli elementi duplicati consecutivi di una lista
=======================================================

Se una lista ordinata contiene elementi ripetuti, devono essere sostituiti con una singola copia dell'elemento. L'ordine degli elementi non deve essere cambiato.

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

Funzione predefinita newLISP: (unique lst)

(unique '(1 1 1 2 2 3 4 4 5 5 5 6 6 6))
;-> (1 2 3 4 5 6)

(unique '(a a b b c c c))
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

Metodo newLISP iterativo:

(define (regroup lst)
  (local (palo tmp out)
    (setq palo nil)
    (setq tmp '())
    (setq out '())
    (dolist (el lst)
      (cond ((nil? palo)
             (setq palo el)
             (push el tmp)
            )
            ((= palo el) (push el tmp))
            ((!= palo el)
             (push tmp out -1)
             (setq tmp (list el))
             (setq palo el)
            )
      )
    )
    (push tmp out -1)
    out))

(regroup '(a a a a b c c a a d e e e e))
;-> ((a a a a) (b) (c c) (a a) (d) (e e e e))

(regroup '(a a))
;-> ((a a))


=======================================================
N-99-10 Run-length encode di una lista
=======================================================

Implementiamo il metodo di compressione Run Length Encoding ad una lista. Gli elementi consecutivi duplicati sono codificati come liste (N E) dove N è il numero di duplicati dell'elemento E.

newLISP permette di utilizzare diversi stili di programmazione, infatti per questo problema scriveremo la funzione di rle encode sia in uno stile imperativo (iterativo), che in uno stile funzionale (ricorsivo).

Vediamo la versione imperativa (iterativa).

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
- se sono uguali si richiama la funzione di supporto sul resto della lista aumentando il conteggio
- se sono diversi si costruisce (con la funzione cons) il risultato parziale e poi si richiama la funzione di supporto sul resto della lista con il conteggio pari a uno.

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

(define (duplica xs)
    (if (null? xs) '()
      (cons (car xs)
            (cons (car xs) (duplica (cdr xs))))))

(define (duplicare lst)
    (if (null? lst) '()
      (cons (first lst)
            (cons (first lst) (duplicare (rest lst))))))

(duplicare '(a b c))
;-> (a a b b c c)

(duplicare '((a b) c (d (e))))
;-> ((a b) (a b) c c (d (e)) (d (e)))

Metodo newLISP iterativo:

(define (doppio lst)
  (let (out '())
    (dolist (el lst)
      (push el out -1)
      (push el out -1)
    )
  out))

(doppio '(a b c))
;-> (a a b b c c)

(doppio '((a b) c (d (e))))
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

Metodo newLISP iterativo:

(define (k-volte lst k)
  (let (out '())
    (if (> k 0)
        (dolist (el lst)
            (for (i 1 k)
              (push el out -1)
            )
        )
    )
  out))

(k-volte '(a b c) 3)
;-> (a a a b b b c c c)

(k-volte '(a b c) 1)
;-> (a b c)

(k-volte '(a b c) 0)
;-> ()

(k-volte '((a) (b c) d) 2)
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

Metodo newLISP iterativo:

(define (del-k lst k)
  (let (out '())
    (if (> k 0)
        (dolist (el lst)
          (if (!= (% (+ $idx 1) k) 0)
              (push el out -1)
          )
        )
        ;else
        (setq out lst)
    )
    out))

(del-k '(a b c d e f g) 2)
;-> (a c e g)

(del-k '(a b c d e f g) 3)
;-> (a b d e g)

(del-k '(a b c d e f g) 1)
;-> ()

(del-k '(a b c d e f g) 0)
;-> (a b c d e f g)


=======================================================
N-99-17 Dividere una lista in due parti
=======================================================

La lunghezza della prima lista è un parametro.

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

(divide-lista '(a b c d e f g h i k) 0)
;-> (() (a b c d e f g h i k))

(divide-lista '() 3)
;-> (() ())

Metodo newLISP iterativo:

(define (div-k lst k)
  (local (one two out)
    (setq one '())
    (setq two '())
    (setq out '())
    (cond ((null? lst '())
           (setq out (list '() '()))
          )
          ((zero? k)
           (setq out (list '() lst))
          )
          (true
            (dolist (el lst)
              (if (< $idx k)
                  (push el one -1)
                  (push el two -1)
              )
            )
            (setq out (list one two))
          )
    )
    out))

(div-k '(a b c d e f g h i k) 3)
;-> ((a b c) (d e f g h i k))

(div-k '(a b c d e f g h i k) 12)
;-> ((a b c d e f g h i k) ())

(div-k '(a b c d e f g h i k) 0)
;-> (() (a b c d e f g h i k))

(div-k '() 3)
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

Funzione newLISP predefinita: (slice lst int-index [int-length])

(define (get-val lst ind1 ind2)
  (slice lst ind1 (+ (- ind2 ind1) 1)))

(get-val '(a b c d e f g h i k) 3 7)
;-> (d e f g h)

(get-val '(a b c d e f g h i k) 3 3)
;-> (d)

(get-val '(a b c d e f g h i k) 0 1)
;-> (a b)

(get-val '(a b c d e f g h i k) 9 9)
;-> (k)


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

Funzione newLISP predefinita: (rotate lst int-index [int-length])

(define (rot-k lst k) (rotate lst (- k)))

(rot-k '(a b c d e f g h) 3)
;-> (d e f g h a b c)

(rot-k '(a b c d e f g h) -2)
;-> (g h a b c d e f)

(setq lst '("a" "b" "c"))

Nota: possiamo generare tutte le rotazioni di una lista con la seguente espressione:

(map (fn (x) (rotate lst)) (sequence 1 (length lst)))
;-> (("c" "a" "b") ("b" "c" "a") ("a" "b" "c"))


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

Funzione newLISP predefinita: (pop lst [int-index-1 [int-index-2 ... ]])
                              (pop lst [list-indexes])

(define (wipe-k lst k) (pop lst k) lst)

(wipe-k '(a b c d e) 2)
;-> (a b d e)

(wipe-k '(a b c d e) 0)
;-> (b c d e)

(wipe-k '(a b c d e) -2)
;-> (a b c e)

Il risultato è differente perchè quando l'indice k è negativo, "pop" considera -1 l'indice dell'ultimo elemento, mentre "elimina-a" considera 0 l'indice dell'ultimo elemento (-1 il penultimo e cosi via).

(wipe-k '(a b c d e) 25)
;-> ERR: invalid list index in function pop
;-> called from user function (wipe-k '(a b c d e) 25)


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

Funzione newLISP predefinita: (push expr lst [int-index-1 [int-index-2 ... ]])
                              (push expr lst [list-indexes])

(define (ins-k item lst k) (push item lst k lst))

I risultati sono differenti per tre motivi:
1) push indicizza partendo da 0.
2) quando l'indice k è negativo, "push" considera -1 l'indice dell'ultimo elemento, mentre "inserisci-a" considera 0 l'indice dell'ultimo elemento (-1 il penultimo e cosi via).
3) l'ultima funzione non controlla eventuali parametri errati.

(ins-k 'alfa '(a b c d) 2)
;-> (a b alfa c d)

(ins-k 'alfa '(a b c d) -2)
;-> (a b c alfa d)

(ins-k 'alfa '(a b c d) 0)
;-> (alfa a b c d)

(ins-k 'alfa '() 2)
;-> ERR: invalid list index in function push
;-> called from user function (ins-k 'alfa '() 2)

(ins-k 'alfa '() 1)
;-> ERR: invalid list index in function push
;-> called from user function (ins-k 'alfa '() 1)

(ins-k 'alfa '(a b c d) 1000)
;-> ERR: invalid list index in function push
;-> called from user function (ins-k 'alfa '(a b c d) 1000)


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
;-> (10 9 8 7 6 5 4 3 2)

Funzione newLISP predefinita: (sequence num-start num-end [num-step])

(define (sequenza start end step)
  (if step
      (sequence start end step)
      (sequence start end)))

(sequenza 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

(sequenza 10 2)
;-> (10 9 8 7 6 5 4 3 2)

(sequenza 10 2 2)
;-> (10 8 6 4 2)

(sequenza 10 2 -2)
;-> (10 8 6 4 2)


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

Possiamo creare le permutazioni utilizzando l'algoritmo di Heap: https://en.wikipedia.org/wiki/Heap%27s_algorithm.

Questo algoritmo produce tutte le permutazioni scambiando un elemento ad ogni iterazione.

(define (perm lst)
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    ; aggiungiamo la lista iniziale alla soluzione
    (setq out (list lst))
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i))
            )
            ;(println lst);
            (push lst out -1)
            (++ (indici i))
            (setq i 0)
          )
          (begin
            (setf (indici i) 0)
            (++ i)
          )
       )
    )
    out
  )
)

(length (perm '(0 1 2 3 4 5 6 7 8 9)))
;-> 36628800

(time (length (perm '(0 1 2 3 4 5 6 7 8 9))))
;-> 3928.519

Questa funzione è la più veloce tra tutte quelle presentate.


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

(define (car lst) (first lst))
(define (cdr lst) (rest lst))

(define (combination k xs)
  (cond ((null? xs) '())
        ((= k 1) (map list xs))
        (true (append (map (lambda (x) (cons (car xs) x))
                           (combination (- k 1) (cdr xs)))
                      (combination k (cdr xs))))))

(combination 2 '(1 2 3 4))
;-> ((1 2) (1 3) (1 4) (2 3) (2 4) (3 4))

(define (group gs lst)
   (define (ciclo gs xss lst)
     (cond ((null? gs) xss)
           ((null? xss) '())
           (true
            (letn ((xs (car xss)) (resto (filter (lambda (e) (not (member e xs))) lst)))
              (append (map (lambda (ys) (list xs ys))
                           (ciclo (cdr gs) (combination (car gs) resto) resto))
                      (ciclo gs (cdr xss) lst))))))
   (ciclo (cdr gs) (combination (car gs) lst) lst))

(group '(2 2 3) '(luca vale andrea eva tommy roby vero))
;-> (((luca vale) ((andrea eva) (tommy roby vero)))
;->  ((luca vale) ((andrea tommy) (eva roby vero)))
;->  ((luca vale) ((andrea roby) (eva tommy vero)))
;->  ((luca vale) ((andrea vero) (eva tommy roby)))
;->  ...
;->  ((tommy vero) ((andrea eva) (luca vale roby)))
;->  ((tommy vero) ((andrea roby) (luca vale eva)))
;->  ((tommy vero) ((eva roby) (luca vale andrea)))
;->  ((roby vero) ((luca vale) (andrea eva tommy)))
;->  ((roby vero) ((luca andrea) (vale eva tommy)))
;->  ((roby vero) ((luca eva) (vale andrea tommy)))
;->  ((roby vero) ((luca tommy) (vale andrea eva)))
;->  ((roby vero) ((vale andrea) (luca eva tommy)))
;->  ((roby vero) ((vale eva) (luca andrea tommy)))
;->  ((roby vero) ((vale tommy) (luca andrea eva)))
;->  ((roby vero) ((andrea eva) (luca vale tommy)))
;->  ((roby vero) ((andrea tommy) (luca vale eva)))
;->  ((roby vero) ((eva tommy) (luca vale andrea))))

GLi elementi della lista risultante non sono annidati correttamente.

Versione corretta:

(define (comb k lst (r '()))
"Generates all combinations of k elements without repetition from a list of items"
  (if (= (length r) k)
    (list r)
    (let (rlst '())
      (dolist (x lst)
        (extend rlst (comb k ((+ 1 $idx) lst) (append r (list x)))))
      rlst)))

(define (list-break lst lst-len)
"Breaks a list into sub-lists of specified lengths"
  (let ((i 0) (q 0) (res '()))
    (dolist (el lst-len)
      (setq i (+ i q))
      (setq q el)
      (push (slice lst i q) res -1)
    )
    res))

(define (groups gs lst)
"Groups the elements of a list into disjoint sublists"
  (local (tmp out)
    ;------------------------
    (define (loop gs xss lst)
      (cond ((null? gs) xss)
            ((null? xss) '())
            (true
            (letn ((xs (first xss)) (leftover (filter (lambda (e) (not (member e xs))) lst)))
              ;(append (map (lambda (ys) (list xs ys)))
              (append (map (lambda (ys) (flat (list xs ys)))
                            (loop (rest gs) (comb (first gs) leftover) leftover))
                      (loop gs (rest xss) lst))))))
    ;------------------------
    (setq tmp (loop (rest gs) (comb (first gs) lst) lst))
    (setq out '())
    (dolist (g tmp)
      (push (list-break g gs) out -1)
    )
    out))

(groups '(2 2 3) '(luca vale andrea eva tommy roby vero))
;-> (((luca vale) (andrea eva) (tommy roby vero)) 
;->  ((luca vale) (andrea tommy) (eva roby vero))
;->  ((luca vale) (andrea roby) (eva tommy vero))
;->  ((luca vale) (andrea vero) (eva tommy roby))
;->  ((luca vale) (eva tommy) (andrea roby vero))
;->  ((luca vale) (eva roby) (andrea tommy vero))
;->  ((luca vale) (eva vero) (andrea tommy roby))
;->  ((luca vale) (tommy roby) (andrea eva vero))
;->  ((luca vale) (tommy vero) (andrea eva roby))
;->  ((luca vale) (roby vero) (andrea eva tommy))
;->  ((luca andrea) (vale eva) (tommy roby vero))
;->  ...
;->  ((tommy vero) (eva roby) (luca vale andrea))
;->  ((roby vero) (luca vale) (andrea eva tommy))
;->  ((roby vero) (luca andrea) (vale eva tommy))
;->  ((roby vero) (luca eva) (vale andrea tommy))
;->  ((roby vero) (luca tommy) (vale andrea eva))
;->  ((roby vero) (vale andrea) (luca eva tommy))
;->  ((roby vero) (vale eva) (luca andrea tommy))
;->  ((roby vero) (vale tommy) (luca andrea eva))
;->  ((roby vero) (andrea eva) (luca vale tommy))
;->  ((roby vero) (andrea tommy) (luca vale eva))
;->  ((roby vero) (eva tommy) (luca vale andrea))) 

Nota: Se la lista delle parti "gs" contiene solo 1, allora la funzione "groups" genera gli stessi elementi della funzione che calcola le permutazioni "perm":
(length (groups '(1 1 1 1 1 1) '(1 2 3 4 5 6)))
;-> 720
(length (perm '(1 2 3 4 5 6)))
;-> 720


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

=============================================================================

