=============

 NOTE LIBERE

=============

----------------
Perchè newLISP ?
----------------

LISP è uno dei linguaggi di programmazione più antichi del mondo, risalente agli anni '50 (progettato da John MacCarthy e sviluppato da Steve Russel nel 1958). Sorprendentemente è sopravvissuto fino ai giorni nostri, ed è ancora vivo e vegeto, anche dopo la nascita di nuovi linguaggi come Python, Ruby o Julia. newLISP è una versione di LISP rivolta principalmente allo scripting, ma in grado di realizzare anche programmi completi. Ecco le principali caratteristiche del linguaggio:

- facile da installare
- veloce
- open-source
- multipiattaforma
- librerie integrate
- espandibile con moduli e shared C-library
- compatibile con il web
- documentazione ottima

Inoltre, infastidisce i puristi del LISP, ed è spesso una buona cosa sfidare lo status quo.
Il creatore del linguaggio è Lutz Mueller (Don Lucio) e la seguente è la cronologia delle release:

Version Year  Changes and Additions
1.0     1991  First version running on Sun4 with SunOS/BSD 4.1
1.3     1993  Windows 3.0 Win16 version released on Compuserve
2.11    1994  Windows 3.0 Win16
3.0     1995  Windows 95 Win32 version
6.0     1999  Open Source UNIX multi platform, licensed GPL
6.3     2001  newLISP-tk Tcl/Tk IDE
6.5.8   2002  PCRE regular expressions
7.1-4   2003  Mac OS X and Solaris support. PDF manual, catch and throw, context variables, Win32 DLL
8.0-3   2004  Arrays, UTF-8 support, forked processes, semaphores, shared memory, default function
8.4-7   2005  Implicit indexing, comma locales, signals and timers, net-eval distributed computing
8.8-9   2006  Prolog-like unify, macro-like variable expansion, more implicit indexing support
9.0     2006  64-bit arithmetic and file support, more array functions, HTTP server mode
9.1     2007  Full 64-bit compile flavor, HTTP/CGI server mode, functors in ref, ref-all, find, replace
9.2     2007  newLISP-GS a Java based GUI library for writing platform independent user interfaces in newLISP
9.3     2008  FOOP – Functional Object Oriented Programming
9.4     2008  Cilk - multiprocessing API implemented in newLISP
10.0    2009  General API cleanup, reference passing, new unified destructive API with setf
10.1    2009  Actor messaging API on Mac OS X, Linux and other UNIX
10.2    2010  FOOP redone with Mutable Objects
10.3    2011  Switchable Internet Protocol between IPv4 and IPv6
10.4    2012  Rewritten message queue interface and extended import API using libffi
10.5    2013  Unlimited precision, integer arithmetic
10.5.2  2013  KMEANS cluster analysis
10.5.7  2014  newLISP in a web browser compiled to JavaScript with good performance
10.6.0  2014  native expansion macro function
10.6.2  2015  minor new functionality
10.7.0  2016  minor new functionality
10.7.1  2017  minor new functionality
10.7.5  2019  minor new functionality and fixed bugs

Indirizzi web:
Home: http://www.newlisp.org
Forum: http://www.newlispfanclub.alh.net/forum/


--------------
newLISP facile
--------------

In newLISP tutto è una lista (o s-expression).
Una lista è un insieme di elementi racchiusi da parentesi tonde "(" ")".
Gli elementi di una lista possono essere un'altra lista.
Il primo elemento della lista è "speciale" (funzione).
Il resto della lista sono "normali" (argomenti).
Tutte le liste vengono valutate tranne quelle quotate.


----------------
Funzioni e liste
----------------

Definiamo una funzione che somma due numeri:

(define (somma a b) (add a b))
;-> (lambda (a b) (add a b))

La variabile "somma" contiene la definizione (come lista) della funzione lambda:

somma
;-> (lambda (a b) (add a b))

La funzione viene restituita come lista:
(list? somma)
;-> true

Ma è anche una funzione lambda:
(lambda? somma)
;-> true

Quindi una funzione lambda può essere trattata come una lista.
Vediamo i parametri della funzione:

(first somma)
;-> (a b)

Vediamo il corpo della funzione:
(last somma)
;-> (add a b)

Modifichiamo la funzione in modo che calcoli la differenza invece che la somma delle variabili a e b:
(setf (first (last somma)) 'sub)
;-> sub

Controlliamo la modifica:
somma
;-> (lambda (a b) (sub a b))

Eseguiamo la funzione somma:
(somma 6 2)
;-> 4 ; abbiamo ottenuto la differenza

Mi piace questo aspetto del linguaggio: automodificante.

Nota: La funzione "define" è solo "syntactic sugar". Infatti le seguenti espressioni sono equivalenti:

(define (somma a b) (add a b))
;-> (lambda (a b) (add a b))

(setq somma '(lambda (a b) (add a b)))
;-> (lambda (a b) (add a b))

Definiamo la funzione "getdef" che prende come parametro il nome di una funzione utente e restituisce (come lista) la definizione lambda della funzione:

(define (getdef func) (if (lambda? func) func nil))

(getdef somma)
;-> (lambda (a b) (+ a b))

(getdef pow)
;-> nil

Adesso definiamo la funzione "funcall" che esegue la funzione passata.

(define (funcall func) (eval (func (args))))

I parametri di funcall non devono essere valutati quando viene chiamata, quindi quotiamo il parametro (lista) "func":

(funcall '(somma 10 20))
;-> 30

(funcall '(somma (somma 10 20) 6))
;-> 36

(funcall '(sin 12))
;-> -0.5365729180004349

Questo è uno dei motivi per cui mi piace newLISP.


----------
4-4 Puzzle
----------

Definire i seguenti simboli:

zero, uno, due, tre quattro, cinque, sei, sette, otto, nove

utilizzando per ogni numero una espressione matematica che contiene quattro volte il numero 4.
L'espressione può contenere: + add , - sub , * mul , / div , (), separatore decimale, potenza, radice quadrata, fattoriale e numero periodico (es. .4~ = .444444444444444...)

0 - (setq zero (- 44 44))
0 - (setq zero (+ 4 4 (- 4) (- 4)))
0 - (setq zero (+ 4 4 (- (+ 4 4))))
1 - (setq one (/ 44 44))
1 - (setq one (+ (/ 4 4) (- 4 4)))
1 - (setq one (+ (/ 4 4) (+ 4 (- 4))))
2 - (setq due (/ (* 4 4) (+ 4 4)))
2 - (setq due (+ (/ 4 4) (/ 4 4)))
2 - (setq due (- 4 (/ (+ 4 4) 4)))
3 - (setq tre (/ (+ 4 4 4) 4))
4 - (setq quattro (+ 4 (* 4 (- 4 4))))
5 - (setq cinque (/ (+ 4 (* 4 4)) 4))
6 - (setq sei (+ 4 (/ (+ 4 4) 4)))
7 - (setq sette (- (/ 44 4) 4))
7 - (setq sette (- (+ 4 4) (/ 4 4)))
8 - (setq otto (/ (* 4 (+ 4 4)) 4))
8 - (setq otto (- (* 4 4) (+ 4 4)))
8 - (setq otto (- (+ 4 4 4) 4))
9 - (setq nove (+ (+ 4 4) (/ 4 4)))

Possiamo provare anche con altri numeri:

 42  - (setq quarantadue (+ 44 (sqrt 4) (- 4)))
100  - (setq cento (div 44 .44))
200  - (setq duecento (+ (fact 4) (* 4 44)))
666  - (setq beast (div 444 (sqrt .4444444444444444)))
1000 - (setq mille (- (* 4 (pow 4 4)) (fact 4)))


--------------
Il primo Primo
--------------

Non c'è dubbio che per tutto il XVII secolo e l'inizio del XX secolo molti matematici hanno considerato il numero 1 come primo, ma è anche chiaro che questa definizione non è mai stata una visone unificata dei matematici. Euclide, Mersenne, Eulero, Gauss, Dirichlet, Lucas e Landau tutti hanno omesso 1 dai primi. Gli ultimi matematici a considerare il numero 1 come primo sono stati Lebesgue (1899) e Hardy (1933).
Ad oggi, il primo numero Primo è il numero 2.
"What is the Smallest Prime?" Caldwell, Xiong - Journal of Integer Sequences, Vol.15 (2012)


--------------
Uso delle date
--------------

La data in formato ISO 8601: YYYY-MM-DD hh:mm:ss

2019-06-31 12:42:22

Purtroppo la funzione "date-parse" non funziona in windows.

; (date-parse "2019-06-15 12:42:22" "%Y-%m-%d %H:%M:%S")
; (date-parse "2019-06-31" "%Y-%m-%d")
; (date-parse "2007.1.3" "%Y.%m.%d")

(date)

"Thu Jul 18 11:36:02 2019"

Trasformiamo la data dal formato ISO al formato RFC822:

(apply date-value (map int (parse "2005-10-16 12:12:12" { |-|:} 0)))
;-> 1129464732

(apply date-value (map int (parse "2019-06-15 12:42:22" { |-|:} 0)))
;-> 1560602542

(apply date-value (map int (parse "2007.1.3" { |\.} 0)))
;-> 1167782400

(date (apply date-value (map int (parse "2005-10-16 12:12:12" { |-|:} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Sun, 16 Oct 2005 14:12 W. Europe Daylight Time"

(date (apply date-value (map int (parse "2019-06-15 12:42:22" { |-|:} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Sat, 15 Jun 2019 14:42 W. Europe Daylight Time"

(date (apply date-value (map int (parse "2007.1.3" { |\.} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Wed, 03 Jan 2007 01:00 W. Europe Standard Time"


-------------------------------------------------
Chiusura transitiva e raggiungibilità in un grafo
-------------------------------------------------

ralph.ronnquist:
----------------
Vediamo come definire una "chiusura transitiva". Data una lista di coppie che rappresenta i link di un grafo, determinare le liste di tutti i nodi connessi transitivamente (in altre parole, unire tutte le sotto-liste che hanno in comune qualche elemento (transitivamente)).
↔↕
Esempio:

 19 ←→ 9 ←→ 4 ←→ 12    3 ←→ 15 ←→ 8    7 ←→ 5 ←→ 0 ←→ 11
            ↕
           13 ←→ 1

(setq grafo '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

Una soluzione ricorsiva potrebbe essere la seguente:

(define (trans s (x s) (f (and s (curry intersect (first s)))))
  (if s (trans (rest s) (cons (unique (flat (filter f x))) (clean f x))) x))

(trans grafo)
;-> ((7 5 0 11) (9 19 4 13 1 12) (15 8 3))

rickyboy:
---------
L'input s è una lista di insiemi in cui ogni membro è in relazione l'uno con l'altro. Ad esempio, se uno dei membri di s è (1 2 3) ciascuno di 1, 2 e 3 sono collegati a qualsiasi altro. In termini matematici, se l'input s descrive una relazione (simmetrica) R, allora risulta che 1R2, 2R1, 1R3, 3R1, 2R3 e 3R2 sono tutti veri.

Quindi, ad esempio, il primo membro dell'input di esempio (13 1) implica sia 13R1 che 1R13 (quando l'input di esempio descrive R). Questo perché, l'input di trans e il suo output sono simili, sono entrambi descrizioni di relazione - tranne che l'output è garantito per descriva una relazione di transitività.

Ora, guardando l'input invece come un insieme di link di un grafo, allora la funzione "trans" deve assumere che tutti i link che trova nell'input sono bidirezionali, cioè gli archi (collegamenti) del grafo non sono orientati.

La funzione "trans" unisce (cons) il membro che definisce le relazioni transitive parziali che contengono il link (first s) (per assorbimento/sussunzione) (cioè (unique (flat (filter f x)))), con il sottoinsieme dei membri che definiscono le relazioni transitive parziali in x che sono mutualmente esclusive al link (first s) (cioè clean f x)

Quando utilizziamo la funzione "trans" possiamo accoppiarla con la seguente funzione che crea un predicato per essa:

(define (make-symmetric-relation S)
  (letex ([S] S)
    (fn (x y)
      (exists (fn (s) (and (member x s) (member y s)))
              '[S]))))

Ecco un test che mostra la funzione in azione:

(define (test-trans input x y)
  (let (R     (make-symmetric-relation input)
        Rt    (make-symmetric-relation (trans input))
        yesno (fn (x) (if x 'yes 'no)))
    (list ;; is (x,y) in the original relation?
          (yesno (R x y))
          ;; is (x,y) in the transitive closure?
          (yesno (Rt x y)))))

Ad esempio,
(8 15) è nella relazione originale: quindi, sarà anche nella chiusura transitiva.
(9 13) non è nella relazione originale, ma è nella chiusura transitiva.
(9 15) non è in nessuna delle due.

(define input '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(test-trans input 8 15)
;-> (yes yes)

(test-trans input 9 13)
;-> (no yes)

(test-trans input 9 15)
;-> (no no)

ralph.ronnquist:
----------------
Esatto, la funzione "trans" tratta la sua lista di input s come una raccolta di classi di equivalenza e combina quelle che si sovrappongono nelle più piccole collezioni di classi.

La funzione simile per le relazioni non riflessive (o per gli archi diretti) riguarderebbe piuttosto la "raggiungibilità transitiva", da un elemento a quelli che sono raggiungibili quando si segue l'articolata relazione (links) in un solo senso (in avanti).

Le seguenti due funzioni svolgono questi metodi: una che determina il raggiungimento individuale di un dato elemento, e una che determina il raggiungimento individuale di tutti gli elementi (mappa di raggiungibilità).

The similar function for non-reflexive relations (or directed arcs) would rather concern transitive reachability, from one element to those that are reachable when following the articulated relation (links) in the forward direction only. I came up with the following for that, which is two functions: one that determines the individual reach from a given element, and an outer function that makes the map of all those for all the elements:

versione iniziale:
(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (flat (map (curry reach (clean f s))
                           (map (curry nth 1) (filter f s)))))))

Nota: usare la versione iniziale della funzione "reach".

============================================================================
versione finale (rimuove gli elementi multipli con "unique"):
(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (unique (flat (map (curry reach (clean f s))
                                   (map (curry nth 1) (filter f s))))))))
============================================================================

(define (reachability s)
  (map (fn (x) (reach s x)) (sort (unique (flat s)))))

 19 ← 9 → 4 → 12    3 → 15 → 8    7 → 5 ← 0 ← 11
          ↓
          13 → 1


(setq grafoD '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(reachability grafoD)
;-> ((0 5) (1) (3 15 8) (4 13 1 12) (5) (7 5) (8)
 ;-> (9 19 4 13 1 12) (11 0 5) (12) (13  1) (15 8) (19))

La "mappa di raggiungibilità" in ogni sottolista indica quali elementi sono raggiungibili dal primo elemento secondo la relazione orientata originale. Per creare la chiusura transitiva basta creare le coppie di associazione dalla mappa di raggiungibilità.

(define (transD s)
  (flat (map (fn (x) (if (1 x) (map (curry list (x 0)) (1 x)) '())) (reachability s)) 1))

(transD grafoD)
;-> ((0 5) (3 15) (3 8) (4 13) (4 1) (4 12) (7 5) (9 19)
;->  (9 4) (9 13) (9 1) (9 12) (11 0) (11 5) (13 1) (15 8))

Il nuovo input (grafoD) crea nuove coppie: (3 8) (4 1) (9 13) (9 1) (9 12) (11 5)

Adesso, come andiamo nell'altra direzione? Ovvero, come si riduce al minor numero di coppie, o almeno si trova una sottolista in modo che le relazioni implicite vengano omesse dall'elenco?

rickyboy:
---------
Ecco la funzione "untransD" che rimuove le relazioni implicite. LAvora considerando ogni arco in s che può essere visto come coppia (src dst) (sebbene dst non è necessario). La funzione "clean" risponde alla domanda "Questo arco è implicato?", che sarà vero (true) quando la raggiungibilità di src, dopo che abbiamo rimosso l'arco da s, è la stessa della raggiungibilità di src sotto s.

(define (untransD s)
  (clean (fn (edge)
           (let (src (edge 0)
                 remove (fn () (apply replace (args))))
             (= (reach s src)
                (reach (remove edge s) src))))
         s))

Per quelli che non hanno familiarità con newLISP, notare la funzione di "remove" (definita nell'associazioni let). Sembra che stia facendo solo ciò che fa la funzione intrinseca "replace": allora, perché non dire semplicemente (replace edge s) invece di (remove edge s)?
La ragione di questo è sottile. La primitiva "replace" è distruttiva e non vogliamo che s cambi durante il runtime di untransD. Definire "remove" come abbiamo fatto qui lo trasforma in una funzione di rimozione non distruttiva (a causa del modello di chiamata di newLISP: la funzione riceve una copia e non il riferimento dell'oggetto).

Ma forse da un punto di vista dei contratti (di ingegneria del software), non dovremmo fare affidamento sull'ordine degli output delle chiamate raggiunte (cioè la sua stabilità).
Anche se possiamo vedere il codice di raggiungibilità, possiamo anche giocare "giocare sicuro" assumendo che non possiamo vedere l'implementazione e quindi sostituire l'uso di = con l'uso di un altro predicato di uguaglianza in cui l'ordine non ha importanza. Potrebbe esserci un modo migliore di quello proposto di seguito:

(define (set-equal? A B)
  (= (sort A) (sort B)))

Anche la primitiva "sort" è distruttiva. Tuttavia, non abbiamo bisogno di A e B (che sono copie anche loro) per qualsiasi altra cosa nell'ambito di questa funzione (dopo che abbiamo finito possiamo distruggerli). Fortunatamente, possiamo riutilizzare set-equal? nei nostri test.

Innanzitutto, ricordiamo cosa fa "transD" in esecuzione sui dati di esempio (input).

(setq input '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(transD input)
;-> ((0 5) (3 15) (3 8) (4 13) (4 1) (4 12) (7 5) (9 19)
;->  (9 4) (9 13) (9 1) (9 12) (11 0) (11 5) (13 1) (15 8))

Adesso vediamo la funzione "untransD" in azione:

(untransD (transD input))
;-> ((0 5) (3 15) (4 13) (4 12) (7 5) (9 19) (9 4) (11 0) (13 1) (15 8))

L'output della funzione sembra uguale alla lista di ingresso.

Come facciamo a testare meglio queste funzioni? Sembra che dovremmo essere in grado di dire che transD e untransD sono una l'inversa dell'altra. Proviamo.

Innanzitutto, si noti che l'input di esempio stesso è privo di relazioni implicite.

(set-equal? input (untransD input))
;-> true

Questo significa che deve valere anche la seguente identità:

(set-equal? input (untransD (transD input)))
;-> nil

Esplorando tutto il codice, credo di aver trovato un bug.

La seguente identità dovrebbe essere vera: la raggiungibilità della chiusura transitiva dell'input è la stessa della raggiungibilità dell'input.

(set-equal? (reachability input)
            (reachability (transD input)))

;-> nil

Cosa succede?

(reachability (transD input))
;-> ((0 5) (1) (3 15 8 8) (4 13 1 1 12) (5) (7 5)
;->  (8) (9 19 4 13 1 1 12 13 1 1 12) (11 0 5 5)
;->  (12) (13 1) (15 8) (19))

Ok, sembra che alcune raggiungibilità non abbiano elementi unici. Eccone una in particolare.

(reach (transD input) 9)
;-> (9 19 4 13 1 1 12 13 1 1 12)

Sembra che abbiamo bisogno della funzione "unique" nella funzione "reach".

(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (unique (flat (map (curry reach (clean f s))
                                   (map (curry nth 1) (filter f s))))))))

Bene, adesso funziona.

(reach (transD input) 9)
;-> (9 19 4 13 1 12)

E l'identità viene rispettata, come atteso.

(set-equal? (reachability input)
            (reachability (transD input)))

;-> true

Grazie a ralph.ronnquist e rickyboy.


-----------
Stalin Sort
-----------

Ecco un algoritmo di ordinamento O(n) (single pass) chiamato StalinSort. L'algoritmo scorre l'elenco degli elementi controllando se sono in ordine. Qualsiasi elemento fuori ordine viene eliminato. Alla fine si ottiene un elenco ordinato.

(define (stalinsort lst op)
  (local (out)
    (setq out '())
    (cond ((null? lst) '())
          (true
            (let (base (first lst))
              (push (first lst) out -1)
              (for (i 1 (- (length lst) 1))
                (if (op (lst i) base)
                ;(if (not (op (lst i) base))
                  (begin
                  (push (lst i) out -1)
                  (setq base (lst i)))
                )
              )
              out
            )
          )
    )
  )
)

(stalinsort '(1 3 4 2 3 6 8 5) <=)
;-> (1)
(stalinsort '(1 3 4 2 3 6 8 5) >=)
;-> (1 3 4 6 8)
(stalinsort '(11 8 4 2 3 6 8 5) <=)
;-> (11 8 4 2)
(stalinsort '(11 8 4 2 3 6 8 5) >=)
;-> (11)
(stalinsort '(11 4 8 2 3 6 8 12) <=)
;-> (11 4 2)
(stalinsort '(11 4 8 2 3 6 8 12) >=)
;-> (11 12)


--------------------
Sequenza triangolare
--------------------

Consideriamo il seguente triangolo di numeri interi:

1
1 2
1 2 3
1 2 3 4
1 2 3 4 5
...

Quando il triangolo è appiattito (flattened), produce la lista (1 1 2 1 2 3 1 2 3 4 1 2 3 4 5 ...).
Il compito è scrivere un programma per generare la sequenza appiattita e per calcolare l'ennesimo elemento nella lista.

(define (triangle n idx)
  (local (out)
    (setq out '())
    (for (i 1 n)
      (push (sequence 1 i) out -1)
    )
    (setq out (flat out))
    (if idx (nth idx out) out)
  )
)

(triangle 3)
;-> (1 1 2 1 2 3)
(triangle 3 2)
;-> 2
(triangle 5)
;-> (1 1 2 1 2 3 1 2 3 4 1 2 3 4 5)
(triangle 5 10)
;-> 1


-------------------------
Vettore/lista di funzioni
-------------------------

Creiamo le funzioni:

(define (f0 x) (add x 1))
(define (f1 x) (mul x x))
(define (f2 x) (mul x x x))

Creiamo il vettore che contiene le funzioni:

(setq vet (array 3 (list f0 f1 f2)))
;-> ((lambda (x) (add x 1)) (lambda (x) (mul x x)) (lambda (x) (mul x x x)))

Ogni elemento del vettore contiene una funzione:

(vet 0)
;-> (lambda (x) (add x 1))

Possiamo chiamare le funzioni nel modo seguente:

((vet 0) 2)
;-> 3

((vet 1) 2)
;-> 4

((vet 2) 2)
;-> 8

Utilizzando una lista otteniamo lo stesso risultato:

(setq lst (list f0 f1 f2))
;-> ((lambda (x) (add x 1)) (lambda (x) (mul x x)) (lambda (x) (mul x x x)))

(dolist (el lst) (println (el 2)))
;-> 3
;-> 4
;-> 8


--------------------
Potenze di un numero
--------------------

Determinare se un numero n è potenza del numero 3.

(define (power-of-3? n)
  (if (zero? (% n 3))
        (power-of-3? (/ n 3))
        (= n 1)
  )
)

(power-of-3? 9)
;-> true
(power-of-3? 6)
;-> nil
(power-of-3? 81)
;-> true
(power-of-3? 847288609443)
;-> true

Vediamo la velocità della funzione:

(time (map power-of-3? (sequence 4 1e7)))
;-> 2676.189

Notiamo che la somma delle cifre di ogni numero che è potenza di 3 vale 9 (tranne 0 e 3).
Per calcolare la somma delle cifre di un numero usiamo la seguente funzione:

(define (digitSum n) (+ 1 (% (- n 1) 9)))

Verifichiamo la nostra ipotesi:

(for (i 4 1e6)
  (if (and (power-of-3? i) (!= 9 (digitSum i)))
    (println "Error: " i)
  )
)
;-> nil

Non è vero il contrario, cioè esistono tanti numeri che hanno come somma delle cifre il valore 9, ma non sono potenze del numero 3.

(for (i 4 1e2)
  (if (and (= 9 (digitSum i)) (not (power-of-3? i)))
    (println "Error: " i)
  )
)
;-> Error: 18
;-> Error: 36
;-> Error: 45
;-> Error: 54
;-> Error: 63
;-> Error: 72
;-> Error: 90
;-> Error: 99

Possiamo generalizzare la funzione per determinare se un numero m è potenza del numero n.

(define (power-of? n m)
  (if (zero? (% m n))
        (power-of? n (/ m n))
        (= m 1)
  )
)

(power-of? 3 117)
;-> nil
(power-of? 4 4096)
;-> true
(power-of? 4 20)
;-> nil
(power-of? 7 2401)
;-> true
(power-of-3? 847288609443)
;-> true


-----------------------
Coppie di primi gemelli
-----------------------

Due numeri sono primi gemelli se n e (n + 2) sono entrambi primi.
Le coppie di primi gemelli sono infinite, ma la loro frequenza diminuisce con l'aumentare di n.

Usiamo la seguente funzione per verificare se un numero n è primo:

(define (primo? n)
  (if (even? n) nil
      (= 1 (length (factor n)))))

(primo? 11)
;-> true

Definiamo una funzione per verificare se un numero n ha un gemello:

(define (gemelli? n) (if (and (primo? n) (primo? (+ n 2)))))

(gemelli? 5)
;-> true

Definiamo una funzione che trova tutte le coppie di gemelli dal numero a (dispari) al numero b:

(define (coppieGemelli a b)
  (local (somma)
    (setq somma 0)
    ;(for (i a b) (if (gemelli? i) (println (++ somma) { } i { } (+ i 2))))
    (for (i a b 2) (if (gemelli? i) (++ somma)))
    somma
  )
)

Con: (for (i a b) (if (gemelli? i) (println (++ somma) { } i { } (+ i 2))))

(coppieGemelli 3 1000)
;-> 1 3 5         2 5 7
;-> 3 11 13       4 17 19
;-> 5 29 31       6 41 43
;-> 7 59 61       8 71 73
;-> 9 101 103     10 107 109
;-> 11 137 139    12 149 151
;-> 13 179 181    14 191 193
;-> 15 197 199    16 227 229
;-> 17 239 241    18 269 271
;-> 19 281 283    20 311 313
;-> 21 347 349    22 419 421
;-> 23 431 433    24 461 463
;-> 25 521 523    26 569 571
;-> 27 599 601    28 617 619
;-> 29 641 643    30 659 661
;-> 31 809 811    32 821 823
;-> 33 827 829    34 857 859
;-> 35 881 883

Con: (for (i a b 2) (if (gemelli? i) (++ somma)))

Calcoliamo la velocità della funzione:

(time (coppieGemelli 3 2e7))
;-> 46361.619

Adesso definiamo una funzione "pairs" che restituisce una lista con tutte le coppie di primi gemelli dal numero a al numero b.

Prima scriviamo la funzione "twin?" che dato un numero n restituisce la coppia di primi n e (n + 2) oppure nil:

(define (twin? n)
  (if (and (primo? n) (primo? (+ n 2)))
    (list n (+ n 2))
    nil
  )
)

(twin? 9)
;-> nil

(twin? 881)
;-> (881 883)

(define (pairs a b)
  (filter true? (map twin? (sequence a b)))
)

(pairs 3 1000)
;-> ((3 5) (5 7) (11 13) (17 19) (29 31) (41 43) (59 61) (71 73) (101 103) (107 109)
;->  (137 139) (149 151) (179 181) (191 193) (197 199) (227 229) (239 241) (269 271)
;->  (281 283) (311 313) (347 349) (419 421) (431 433) (461 463) (521 523) (569 571)
;->  (599 601) (617 619) (641 643) (659 661) (809 811) (821 823) (827 829) (857 859)
;->  (881 883))

(length (pairs 3 1000))
;-> 35

Calcoliamo la velocità della funzione:

(time (pairs 3 2e7))
;-> 47479.457

Adesso definiamo la stessa funzione, ma in modo imperativo:

(define (pairs-i a b)
  (local (idx out)
    (setq idx a)
    (while (< idx b)
      (if (and (primo? idx) (primo? (+ idx 2)))
        (push (list idx (+ idx 2)) out -1)
      )
      (++ idx 2)
    )
    out
  )
)

(length (pairs-i 3 1000))
;-> 35

(time (pairs-i 3 2e7))
;-> 44355.696

Adesso riscriviamo la funzione ottimizzata (non ricalcoliamo un numero primo quando troviamo una coppia):

(define (pairs-i a b)
  (local (idx found out)
    (setq found nil)
    (setq idx a)
    ; solo il numero 5 appartiene a due coppie di numeri primi gemelli
    (setq out '((3 5) (5 7)))
    (while (< idx b)
      (if (and (primo? idx) (primo? (+ idx 2)))
        (begin
        (push (list idx (+ idx 2)) out -1)
        (setq found true))
      )
      (if found (++ idx 4) (++ idx 2))
      (setq found nil)
    )
    out
  )
)

(length (pairs-i 7 1000))
;-> 35

(time (pairs-i 7 2e7))
;-> 43177.908

Questo è il miglior risultato ottenuto in termini di velocità.

Cerchiamo di capire dove la funzione spende il tempo maggiore. Proviamo a testare solo la parte che calcola i numeri primi:

(define (test-a a b)
  (local (idx out)
    (setq idx a)
    (while (< idx b)
      (if (and (primo? idx) (primo? (+ idx 2))))
      (++ idx 2)
    )
  )
)

(time (test-a 3 2e7))
;-> 44295.723

Come avevamo intuito, quasi tutto il tempo di esecuzione della funzione è dedicato al calcolo dei numeri primi.

Calcoliamo la distanza tra le coppie di numeri primi:

(define (dist-pairs a b)
  (local (idx base out)
    (setq idx a)
    (setq base 3)
    (while (< idx b)
      (if (and (primo? idx) (primo? (+ idx 2)))
        (begin
          (push (- idx base) out -1)
          (setq base idx))
      )
      (++ idx 2)
    )
    out
  )
)

(dist-pairs 5 1000)
;-> (2 6 6 12 12 18 12 30 6 30 12 30 12 6 30 12 30 12
;->  30 36 72 12 30 60 48 30 18 24 18 150 12 6 30 24)

(silent (setq dp6 (dist-pairs 5 1e6)))
(length dp6)
;-> 8168

Infine salviamo dp6 come file di testo (per esempio per plottare i dati con un altro programma):

(save "dist-coppie.txt" 'dp6)
;-> true

Sul forum di newLISP, raph.ronnquist ha fornito due funzioni per calcolare le coppie:

(define (pairs-i a b)
  (let ((out (list)) (x nil))
    (for (y (if (odd? a) a (inc a)) b 2)
      (if (1 (factor y)) (setf y nil) x (push (list x y) out -1))
      (setf x y))
    out))

(length (pairs-i 3 1000))
;-> 35

(time (pairs-i 3 2e7))
;-> 40072.606

La seconda funzione sfrutta la seguente idea. Per migliorare la velocità (nei numeri grandi) possiamo controllare se il modulo di un generico prodotto di primi include uno dei numeri primi del prodotto.
Il codice è il seguente:

(define (pairs-i1 a b)
  (let ((out (list)) (x nil) (FX (* 2 3 5 7 11 13)) (M 0))
    (for (y (if (odd? a) a (inc a)) b 2)
      (if (if (< y FX) (1 (factor y))
             (or (= (setf M (% y FX))) (if (factor M) (<= ($it 0) 13)) (1 (factor y))))
        (setf y nil)
        x (push (list x y) out -1))
      (setf x y))
    out))

In questo esempio viene utilizzato il prodotto di primi (* 2 3 5 7 11 13). Per numeri maggiori di questo, controlla se il modulo è un prodotto di uno di quei numeri primi, nel qual caso il numero nel suo insieme è divisibile per quel numero primo (e quindi non è un numero primo). In particolare, la fattorizzazione del modulo è in genere più veloce perchè filtra questi i numeri controllati dal modulo.

(time (pairs-i1 3 2e7))
;-> 29964.396

Il miglioramento di velocità per la gestione di grandi numeri è significativo (+ 25%).


------------------------------------
Radice quadrata intera
------------------------------------
Calcolare la radice quadrata intera di un numero n.

Primo metodo:

(define (isqrt1 n)
  (local (xn xn1)
    (setq xn 1)
    (setq xn1 (/ (+ xn (/ n xn)) 2))
    (while (> (abs (- xn1 xn)) 1)
      (setq xn xn1)
      (setq xn1 (/ (+ xn (/ n xn)) 2))
    )
    (while (> (* xn1 xn1) n) (-- xn1))
    xn1
  )
)

(isqrt1 900) 
;-> 30

(isqrt1 899)
;-> 29

(isqrt1 6074020096)
;-> 77936

(time (map isqrt1 (sequence 2 1e6)))
;-> 4980.122

Test di correttezza: 

(for (i 2 1e6) (if (!= (isqrt1 (* i i)) (sqrt (* i i))) (println "error: " (* i i)) ))
;-> nil

Secondo metodo (algoritmo babilonese):

(define (isqrt2 n)
  (let ((x n) (y 1))
    (while (> x y)
      (setq x (/ (+ x y) 2))
      (setq y (/ n x))
    )
    x
  )
)

(isqrt2 900)
;-> 30

(isqrt2 899)
;-> 29

(isqrt2 6074020096)
;-> 77936

(time (map isqrt2 (sequence 2 1e6)))
;-> 3630.086

Test di correttezza:

(for (i 2 1e6) (if (!= (isqrt2 (* i i)) (sqrt (* i i))) (println "error: " (* i i)) ))
;-> nil

Terzo metodo:

(define (isqrt3 n) (int (sqrt n)))

(isqrt3 900)
;-> 30

(isqrt3 899)
;-> 29

(isqrt3 6074020096)
;-> 77936

(time (map isqrt3 (sequence 2 1e6)))
;-> 150.086

Test di correttezza:

(for (i 2 1e6) (if (!= (isqrt (* i i)) (sqrt (* i i))) (println "error: " (* i i)) ))
;-> nil

Quarto metodo (big integer):

(define (isqrt4 n)
  (catch
    (local (start mid end out)
      (setq start 1L)
      (setq end (bigint (/ n 2)))
      (while (<= start end)
        (setq mid (/ (+ start end) 2))
        (if (= n (* mid mid)) (throw mid))
        (if (< (* mid mid) n)
          (begin (setq start (+ mid 1)) (setq out mid))
          (setq end (- mid 1))
        )
      )
      (throw out)
    )
  )
)

oppure:

(define (isqrt4 n)
  (local (start mid end trovato out)
    (setq start 1L)
    (setq end (bigint (/ n 2)))
    (while (and (<= start end) (= trovato nil))
      (setq mid (/ (+ start end) 2))
      (if (= n (* mid mid)) 
          (begin (setq out mid) (setq trovato true))
          (if (< (* mid mid) n)
            (begin (setq start (+ mid 1)) (setq out mid))
            (begin (setq end (- mid 1))  (setq out mid)))
      )
    )
    out
  )
)

(isqrt4 900)
;-> 30L

(isqrt4 899)
;-> 29L

(isqrt4 6074020096)
;-> 77936L

(time (map isqrt4 (sequence 2 1e6)))
;-> 26274.627

Test di correttezza:

(for (i 2 1e6)
  (setq j (bigint i))
  (if (!= (isqrt4 (* j j)) (sqrt (* j j))) 
    (begin (println "error: " (* j j)))))
;-> nil


-----------------------
Numeri con tre divisori
-----------------------

Trovare tutti i numeri fino al milione che hanno tre divisori. 
Ad esempio, il numero 10 ha quattro divisori: 1, 2, 5 e 10.

Scriviamo una funzione per calcolare i divisori di un numero N.

(define (divisori n)
  (local (lista-div m i)
    (setq lista-div '(1)) ; aggiungo il numero 1
    (setq m (int (sqrt n)))
    (setq i 2)
    (while (<= i m)
        (if (zero? (% n i))   ; se 'i' è divisore di 'n'
            (if (= i (/ n i)) ; se entrambi i divisori sono gli stessi aggiungine uno,
                              ; altrimenti aggiungili entrambi
              (push i lista-div -1)
              (begin (push i lista-div -1) (push (/ n i) lista-div -1))
            )
        )
        (++ i)
    )
    (push n lista-div -1) ; aggiungo il numero stesso
    (sort lista-div)
  )
)

(divisori 1000)
;-> (1 2 4 5 8 10 20 25 40 50 100 125 200 250 500 1000)

Facciamo una prova per vedere quanto tempo occorre per trovare la soluzione:

(define (prova n)
  (for (i 2 n) 
    (if (= (length (divisori i)) 3) (println i { } (divisori i))))
)

(prova 1e6)
;-> 4 (1 2 4)
;-> 9 (1 3 9)
;-> 25 (1 5 25)
;-> 49 (1 7 49)
;-> 121 (1 11 121)
;-> 169 (1 13 169)
;-> 289 (1 17 289)
...
;-> 954529 (1 977 954529)
;-> 966289 (1 983 966289)
;-> 982081 (1 991 982081)
;-> 994009 (1 997 994009)

Vediamo quanti sono i numeri da ricercare:

(define (prova1 n)
  (let (out 0)
    (for (i 2 n) 
      (if (= (length (divisori i)) 3) (++ out)))
  out
  )
)

(prova1 1e6)
;-> 168

(time (prova1 1e6))
;-> 94695.56 ; circa 95 secondi

La funzione è molto lenta, quindi cerchiamo di ottimizzarla. Inannzitutto la funzione "divisori" calcola una lista di divisori, ma a noi in interessa sapere soltanto se un numero ha esattamente 3 divisori.
Riscriviamo la funzione per i divisori:

(define (numdiv3 n)
  (local (num m i)
    (setq num 1) ; il numero 1
    (setq m (int (sqrt n)))
    (setq i 2)
    (while (<= i m)
        (if (zero? (% n i))   ; se 'i' è divisore di 'n'...
            (if (= i (/ n i)) ; se entrambi i divisori sono gli stessi ...
              (++ num)   ; allora aggiungine uno,
              (++ num 2) ; altrimenti aggiungili entrambi
            )
        )
        (if (> num 2) (setq i m)) ;numero da scartare
        (++ i) 
    )
    (++ num 1) ; il numero stesso
  )
)

Proviamo questa nuova funzione:

(define (prova2 n)
  (let (out 0)
    (for (i 2 n) 
      (if (= (numdiv3 i) 3) (++ out)))
  out
  )
)

(prova2 1e6)
;-> 168

(time (prova2 1e6))
;-> 12788.932 ; circa 13 secondi

Abbiamo ottenuto un buon miglioramento della velocità, ma possiamo fare meglio.

I divisori vengono in coppie, quindi per la maggior parte dei numeri il conteggio dei divisori è un numero pari. Per esempio, i divisori di 24 sono 1 e 24, 2 e 12, 3 e 8, e 4 e 6, quindi 24 ha 8 divisori. 
L'unica volta in cui un numero può avere un numero dispari di divisori è quando il numero è un quadrato perfetto. Ad esempio, i divisori di 36 sono 1 e 36, 2 e 18, 3 e 12, 4 e 9 e 6 e 6, gli ultimi due sono duplicati, quindi 36 ha 9 divisori. 
E l'unica volta in cui un numero può avere 3 divisori è quando il numero è un quadrato di un numero primo. Ad esempio, i divisori di 25 sono 1, 5 e 25.

Quindi possiamo modificare il ciclo for e controllare solo i numeri quadrati. In questo modo il valore di n passato alla funzione vale 1000, poichè 1000x1000 = 1000000 (un milione). Inoltre controlliamo solo i quadrati dei numeri dispari (perchè non esistono numeri primi pari oltre al numero 2).

(define (prova3 n)
  (let (out 1) ; il numero 4
    (for (i 3 n 2)
      (if (= (numdiv3 (* i i)) 3) (++ out)))
  out
  )
)

(prova3 1000)
;-> 168

(time (prova3 1000))
;-> 32.965

Questo è un miglioramento enorme. Provamo a modificare la funzione per testare anche se il numero è primo:

(define (prova4 n)
  (let (out 1) ; il numero 4
    (for (i 3 n 2) 
      (if (= (length (factor i)) 1) ; se il numero è primo...
        (if (= (numdiv3 (* i i)) 3) (++ out)))
    )
  out
  )
)

(prova4 1000)
;-> 168

(time (prova4 1000))
;-> 30.968

I tempi di "prova3" e "prova4" sono quasi uguali (poichè il calcolo del numero primo pur eliminando molti numeri, ma richiede tempo).

Scriviamo la funzione finale che ritorna una lista con tutti i numeri che hanno 3 divisori:

(define (divisori3 n)
  (let (out '(4)); il numero 4
    (for (i 3 n 2) 
      (if (= (length (factor i)) 1) ; se il numero è primo...
        (if (= (numdiv3 (* i i)) 3) (push (* i i) out -1)))
    )
  out
  )
)

(divisori3 1000)
;-> (4 9 25 49 121 169 289 361 529 841 961 1369 1681 1849 2209 2809 
;->  3481 3721 4489 5041 5329 6241 6889 7921 9409 10201 10609 11449 
;->  11881 12769 16129 17161 18769 19321 22201 22801 24649 26569 
;->  27889 29929 32041 32761 36481 37249 38809 39601 44521 49729 
;->  51529 52441 54289 57121 58081 63001 66049 69169 72361 73441 
;->  76729 78961 80089 85849 94249 96721 97969 100489 109561 113569 
;->  120409 121801 124609 128881 134689 139129 143641 146689 151321 
;->  157609 160801 167281 175561 177241 185761 187489 192721 196249 
;->  201601 208849 212521 214369 218089 229441 237169 241081 249001 
;->  253009 259081 271441 273529 292681 299209 310249 316969 323761 
;->  326041 332929 344569 351649 358801 361201 368449 375769 380689 
;->  383161 398161 410881 413449 418609 426409 434281 436921 452929 
;->  458329 466489 477481 491401 502681 516961 528529 537289 546121 
;->  552049 564001 573049 579121 591361 597529 619369 635209 654481 
;->  657721 674041 677329 683929 687241 703921 727609 734449 737881 
;->  744769 769129 776161 779689 786769 822649 829921 844561 863041 
;->  877969 885481 896809 908209 935089 942841 954529 966289 982081 
;->  994009)

(length (divisori3 1000))
;-> 168

(time (divisori3 1000))
;-> 33.964


-----------------
Quadrati perfetti
-----------------

Determinare se un numero n è un quadrato perfetto.

Usiamo la funzione radice quadrata (sqrt):

(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(square? 400)
;-> true

(square? 1736364774)
;-> nil

(time (map square? (sequence 2 1000000)))
;-> 225.77

Facciamo un test per vedere se la funzione è corretta:

(for (i 2 1e7)
  (if (not (square? (* i i))) (println i { } (* i i))))
;-> nil

Un metodo alternativo:

(define (square1? n)
  (catch
    (let (i (max 1 (int (- (sqrt n) 1))))
      (while (<= (* i i) n)
        (if (and (= (% n i) 0) (= i (/ n i))) (throw true))
        (++ i)
      )
      (throw nil)
    )
  )
)

(square1? 400)
;-> true

(square1? 1736364774)
;-> nil

(time (map square1? (sequence 2 1000000)))
;-> 2253.451

Test:

(for (i 2 1e6)
  (if (not (square1? (* i i))) (println i { } (* i i))))
;-> nil

Un altro metodo è quello di fattorizzare il numero n e poi, se tutti gli esponenti dei fattori sono numeri pari, allora n è un quadrato perfetto.

Esempio:
n = 400
(factor 400)
;-> (2 2 2 2 5 5)

400 = 20*20 = 2^4 * 5^2

Poichè 4 e 2 (gli esponenti) sono numeri pari allora 400 è un quadrato perfetto.

Ecco la funzione:

(define (square2? n)
  (let (f (factor n))
    (catch
      (dolist (x (count (unique f) f))
        (if (odd? x) (throw nil))
        true
      )
    )
  )
)

(square2? 400)
;-> true

(square2? 1736364774)
;-> nil

(time (map square2? (sequence 2 1000000)))
;-> 3534.401

Test:

(for (i 2 1e5)
  (if (not (square2? (* i i))) (println i { } (* i i))))
;-> nil

Un altro algoritmo (molto lento).

Dato il numero n:
1) a = 5*n
2) b = 5
3) Affinchè (a >= b)
      a = a - b
      b = b + 10
4) Quando (a < b):
   se e solo se (a == 0) allora n è un quadrato perfetto

Ecco la funzione:

(define (square3? n)
  (let ((a (* 5 n)) (b 5))
    (while (>= a b)
      (setq a (- a b))
      (++ b 10)
    )
    (zero? a)
  )
)

(square3? 400)
;-> true

(square3? 1736364774)
;-> nil

(time (map square3? (sequence 2 1000000)))
;-> 80311.923

Test:

(for (i 2 1e4)
  (if (not (square3? (* i i))) (println i { } (* i i))))
;-> nil

Inoltre valgono le seguenti due regole:

1) Se un numero ha 2 o 3 o 7 o 8 nel posto dell'unità, allora non è un quadrato perfetto.

(define (digit-1 n)
  (if (zero? (/ n 10))
      n
      (digit-1 (/ n 10))
  )
)

(digit-1 (* 343 343))
;-> 1

2) Se la somma delle cifre di un numero non vale 1 o 4 o 7 o 9, allora non è un quadrato perfetto.

(define (digit-sum n) (+ 1 (% (- n 1) 9)))

(digit-sum (* 361 361))
;-> 1

Infine, ecco una soluzione abbastanza veloce che funzione anche per i numeri big integer:

(define (square4? n)
  (local (a)
    (setq a n)
    (while (> (* a a) n)
      (setq a (/ (+ a (/ n a)) 2L))
    )
    (= (* a a) n)
  )
)

(square4? 400L)
;-> true

(square4? 1736364774L)
;-> nil

(* 83968 83968)
;-> 7050625024

(square4? (* 83968L 83968L))
;-> true

Ma attenzione, occorre passare dei numeri big integer (L) per ottenere il risultato corretto:

(square4? (* 83968 83968))
;-> nil ;errore

(square4? (* 383747464646473736473647364736L 383747464646473736473647364736L))
;-> true

(time (map square4? (sequence 2L 1000000L)))
;-> 2578.611

Test:

(for (i 2 1e6)
  (if (not (square4? (* (bigint i) (bigint i))) (println i { } (* i i)))))
;-> nil


--------------------
Numeri di Carmichael
--------------------

In teoria dei numeri, un numero di Carmichael è un intero positivo composto n che soddisfa la congruenza

 b^(n-1) ≡ 1 mod n

per tutti gli interi b che sono coprimi con n o, equivalentemente, che verificano la congruenza

 b^n ≡ b mod n

per ogni b.

Il piccolo teorema di Fermat afferma che tutti i numeri primi hanno quella proprietà, ma il viceversa non è vero: ad esempio  2^(341) mod 341, ma 341 non è primo, essendo il prodotto di 11 e 31. Un numero tale che b^n ≡ b mod n è detto pseudoprimo di Fermat rispetto alla base b. I numeri di Carmichael sono pseudoprimi di Fermat in ogni base, cioè assoluti.

I numeri di Carmichael passano in ogni caso il test di primalità di Fermat pur essendo composti: la loro esistenza impedisce di utilizzare questo test per certificare con sicurezza la primalità di un numero, mentre rimane utilizzabile per dimostrare che un numero è composto.

I numeri di Carmichael sono tutti dispari.

Scriviamo una funxione che controlla se un dato numero è un numero di Carmichael:

(define (fattorizza x)
  (letn (fattori (factor x)
         unici (unique fattori))
    (transpose (list unici (count unici fattori)))))
    ;(map list unici (count unici fattori))))

(fattorizza 45)
;-> ((3 2) (5 1))

(fattorizza 561)
;-> ((3 1) (11 1) (17 1))

(define (carmichael? n)
  (local (out fattori)
    (setq out true)
    (cond ((or (= n 1) (even? n) (= 1 (length (factor n)))) (setq out nil))
          (true
            (setq fattori (fattorizza n))
            (dolist (f fattori (= out nil))
              (if (> (f 1) 1) (setq out nil))
              (if (!= (% (- n 1) (- (f 0) 1)) 0) (setq out nil))
            )
          )
    )
    out
  )
)  

Scriviamo una funzione che calcola i numeri di Carmichael fino al numero n:

(define (carmichael n)
  (let (out '())
    (for (i 3 n 2)
      (if (carmichael? i) (push i out -1))
    )
  out
  )
)

(carmichael 1000000)
;-> (561 1105 1729 2465 2821 6601 8911 10585 15841 29341 41041 46657 52633 62745 63973
;->  75361 101101 115921 126217 162401 172081 188461 252601 278545 294409 314821 334153
;->  340561 399001 410041 449065 488881 512461 530881 552721 656601 658801 670033 748657
;->  825265 838201 852841 997633)

(time (carmichael 1000000))
;-> 2043.545

(define (carmichael n)
  (filter carmichael? (sequence 3 n 2)))

(time (carmichael 1000000))
;-> 3510.422


-------------------------------------
Numeri dispari differenza di quadrati
-------------------------------------

Ogni numero dispari può essere espresso come differenza di due quadrati.

Dimostrazione:

Prendiamo il numero 5 e rappresentiamolo con delle O:
OOOOO

Dividiamo il numero in due parti:
OOO
O
O

Riempiamo il quadrato:
OOO
OXX
OXX

Quadrato totale (9) - quadrato interno (4) = 5

Scriviamo una funzione che calcola questi numeri:

(define (breaknum n)
  (if (even? n) nil
    (list (* (- n (/ n 2)) (- n (/ n 2))) (* (/ n 2) (/ n 2)) )
  )
)

(breaknum 11)
;-> (36 25)

(breaknum 9527)
;-> (22695696 22686169)


----------------
Numeri semiprimi
----------------

Un numero semi-primo è un numero che è il prodotto di due numeri primi.
Algoritmo:
1) Trovare un divisore del numero d1. 
2) Dividere il numero per d1 per ottenere un secondo divisore d2.
3) Se d1 e d2 sono entrambi primi, allora il numero originale è semiprimo.
4) ripetere 1), 2) e 3) per tutti i divisori del numero.

Scriviamo una funzione che verifica se un numero è primo:

(define (primo? n)
  (if (and (!= n 2) (even? n)) nil
      (= 1 (length (factor n)))))

Scriviamo una funzione che verifica se un numero è semiprimo:

(define (semiprimo? num)
  (local (d2 out)
    (for (d1 2 (int (+ (sqrt num) 1)) 1 (= out true))
      (if (= (% num d1) 0)
        (setq d2 (/ num d1)
              out (and (primo? d1) (primo? d2)))
      )
    )
    out
  )
)

(semiprimo? 21)
;-> true

(semiprimo? 4)
;-> true

Scriviamo una funzione che calcola i numeri semiprimi fino a n:

(define (semiprimi n)
  (let (out '())
    (for (i 2 n)
      (if (semiprimo? i) (push i out -1))
    )
  out
  )
)

(semiprimi 100)
;-> (4 6 9 10 14 15 21 22 25 26 33 34 35 38 39 46 49 51 55 
;->  57 58 62 65 69 74 77 82 85 86 87 91 93 94 95)

(length (semiprimi 1000))
;-> 299

(time (map semiprimi (sequence 10 1000)))
;-> 1473.389

Per migliorare la velocità possiamo inglobare il controllo dei numeri primi all'interno del ciclo while:

(define (semiprimo? num)
  (let ((cnt 0) (i 2))
    (while (and (< cnt 2) (<= (* i i) num))
      (while (zero? (% num i))
        (setq num (/ num i))
        (++ cnt)
      )
      (++ i)
    )
    (if (> num 1) (++ cnt))
    (= cnt 2)
  )
)

(semiprimi 100)
;-> (4 6 9 10 14 15 21 22 25 26 33 34 35 38 39 46 49 51 55 
;->  57 58 62 65 69 74 77 82 85 86 87 91 93 94 95)

(length (semiprimi 1000))
;-> 299

(time (map semiprimi (sequence 10 1000)))
;-> 1056.916


----------
Zero? test
----------

In newLISP abbiamo due modi per verificare se un numero n vale 0:

(zero? n) e (= n 0)

Vediamo se hanno la stesssa velocità. Scriviamo due funzioni che hanno una sola differenza: il modo con cui confrontiamo un valore con il numero zero.

(define (t1 num)
  (let (k 0)
    (dotimes (x num) (if (zero? (rand 2)) (++ k)))
    k))

(define (t2 num)
  (let (k 0)
    (dotimes (x num) (if (= 0 (rand 2)) (++ k)))
    k))

(time (map t1 (sequence 10 10000)))
;-> 5324.556

(time (map t2 (sequence 10 10000)))
;-> 5874.991

Il modo (zero? n) è più veloce.

Proviamo con un altro calcolo al posto di "rand":

(define (t1 num)
  (let (k 0)
    (dotimes (x num) (if (zero? (% num (+ x 1))) (++ k)))
    k))

(define (t2 num)
  (let (k 0)
    (dotimes (x num) (if (= 0 (% num (+ x 1))) (++ k)))
    k))

(time (map t1 (sequence 10 10000)))
;-> 5062.827

(time (map t2 (sequence 10 10000)))
;-> 5663.21

Quindi nei test numerici è meglio utilizzare la funzione "zero?"


--------------
Numeri coprimi
--------------

Due numeri a e b sono detti coprimi (o primi tra loro o relativamente primi) se e solo se essi non hanno nessun divisore comune eccetto 1 e -1 o, in modo equivalente, se il loro massimo comune divisore è 1, cioè MCD(a,b) = 1.

(define (coprimi? a b) (= (gcd a b) 1))

(coprimi? 10 11)

(define (coprimi n)
  (let ((out '()))
    (for (i 0 n)
      (for (j i n)
      ;(for (j (+ i 1) n)
        (if (coprimi? i j) (push (list i j) out -1))
      )
    )
    out
  )
)

(coprimi 10)
;-> ((0 1) (1 1) (1 2) (1 3) (1 4) (1 5) (1 6) (1 7) (1 8) (1 9) 
;->  (1 10) (2 3) (2 5) (2 7) (2 9) (3 4) (3 5) (3 7) (3 8) (3 10)
;->  (4 5) (4 7) (4 9) (5 6) (5 7) (5 8) (5 9) (6 7) (7 8) (7 9)
;->  (7 10) (8 9) (9 10))

Due teoremi interessanti sui numeri coprimi:

Teorema: Numeri naturali consecutivi n e (n + 1) sono sempre coprimi.

(coprimi? 310 311)
;-> true

Teorema: La probabilità che due interi scelti a caso siano primi tra loro è 6/(π^2).

Un altro metodo per calcolare tutte le coppie di coprimi è quello di utilizzare la sequenza di Farey.
La sequenza di Farey F(n), per ogni numero naturale positivo n, è definita come l'insieme ordinato secondo l'ordine crescente di tutti i numeri razionali irriducibili (cioè tali che numeratore e denominatore siano coprimi) espressi sotto forma di frazione con numeratore e denominatore compresi tra zero e n. 

La seguente funzione genera la n-esima sequenza di Farey in ordine crescente o decrescente:

(define (farey n desc)
  (local (a b c d k p q out)
    (setq out '())
    (setq a 0 b 1 c 1 d n)
    ;(println a { } b)
    (if desc (setq a 1 c (- n 1)))
    (push (list a b) out -1)
    (while (or (and (<= c n) (not desc)) (and (> a 0) desc))
      (setq k (int (div (+ n b) d)))
      (setq p (- (* k c) a))
      (setq q (- (* k d) b))
      (setq a c b d c p d q)
      (push (list a b) out -1)
      ;(println a { } b)
    )
    out
  )
)

(farey 3)
;-> ((0 1) (1 3) (1 2) (2 3) (1 1))

(farey 10)
;-> ((0 1) (1 10) (1 9) (1 8) (1 7) (1 6) (1 5) (2 9) (1 4) (2 7) 
;->  (3 10) (1 3) (3 8) (2 5) (3 7) (4 9) (1 2) (5 9) (4 7) (3 5)
;->  (5 8) (2 3) (7 10) (5 7) (3 4) (7 9) (4 5) (5 6) (6 7) (7 8)
;->  (8 9) (9 10) (1 1))

Verifichiamo che le due funzioni "coprimi" e "farey" generano le stesse sequenze :

(= (coprimi 100) (sort (farey 100)))
;-> true

Vediamo la differenza delle due funzioni in termin di velocità

(time (map coprimi (sequence 10 500)))
;-> 6391.329

(time (map farey (sequence 10 500)))
;-> 7297.73

Ottimizziamo un pò la funzione "farey":

(define (farey1 n)
  (local (a b c d k p q out)
    (setq out '())
    (setq a 0 b 1 c 1 d n)
    ;(println a { } b)
    (push (list a b) out -1)
    ;(while (or (and (<= c n) (not desc)) (and (> a 0) desc))
    (while (<= c n)
      ;(setq k (int (div (+ n b) d)))
      (setq k (/ (+ n b) d))
      (setq p (- (* k c) a))
      (setq q (- (* k d) b))
      (setq a c b d c p d q)
      (push (list a b) out -1)
      ;(println a { } b)
    )
    out
  )
)

(= (coprimi 100) (sort(farey1 100)))
;-> true

(time (map farey1 (sequence 10 500)))
;-> 6469.966

Le due funzioni hanno la stessa velocità.

