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

