===============

 NOTE LIBERE 7

===============

-------------------
Problema di Brocard
-------------------

In teoria dei numeri, il problema di Brocard chiede di trovare per quali interi n, l'espressione n! + 1 è un quadrato perfetto, in formule si tratta di una equazione diofantea:

  n! + 1 = m²

Le uniche soluzioni sono le coppie (4 5), (5 11) e (7 71) che vengono chiamate numeri di Brown.

Sono conosciute solo tre coppie (n,m) che soddisfano questa equazione diofantea e non è noto se ne esistano altre.

Le tre coppie sono (4, 5), (5, 11) e (7, 71) , infatti :

4! + 1 = 24 + 1 = 25 = 5²

5! + 1 = 120 + 1 = 121 = 11²

7! + 1 = 5.040 + 1 = 5.041 = 71²

Il problema fu posto per la prima volta da Henri Brocard nel 1876, e indipendentemente, nel 1913, da Srinivasa Ramanujan.

(define (fact num) (if (= num 0) 1 (apply * (map bigint (sequence 1 num)))))
(fact 2)

(define (square? n)
  (local (a)
    (setq a n)
    (while (> (* a a) n)
      (setq a (/ (+ a (/ n a)) 2L))
    )
    (= (* a a) n)))

(define (brocard num)
    (for (i 1 num)
      (if (square? (+ (fact i) 1))
          (println i { } (sqrt (+ (fact i) 1))))))

(brocard 10)
;-> 4 5
;-> 5 11
;-> 7 71
(brocard 100)
;-> 4 5
;-> 5 11
;-> 7 71
 (time (brocard 1000))
;-> 4 5
;-> 5 11
;-> 7 71
;-> 205732.508


-------------------------------------------------
Errore quadratico medio (Mean Square Error - MSE)
-------------------------------------------------

L'errore quadratico medio (Mean Squared Error - MSE) indica la discrepanza quadratica media fra i valori  osservati ed i valori stimati. Viene spesso utilizzato come metrica per determinare le prestazioni di un algoritmo.

La formula per calcolare il MSE è la seguente:

        1    n
  MSE = --- * ∑ [yo(i) - yp(i)]²
        n   i=1


dove, n è il numero di termini per i quali viene calcolato l'errore
      yo(i) è l'i-esimo valore osservato
      yp(i) è l'i-esimo valore previsto

L'errore quadratico medio è la media del quadrato della differenza tra i valori osservati e quelli previsti di una variabile.

(define (mean-squared-error lst1 lst2)
  (div
    (apply add
           (map (fn(x y) (mul (sub x y) (sub x y))) lst1 lst2))
    (length lst1)))

(setq yo '(11 20 19 17 10))
(setq yp '(12 18 19.5 18 9))

(mean-squared-error yo yp)
;-> 1.45
(mean-squared-error yp yo)
;-> 1.45

(setq yo '(1 2 3 4 5))
(setq yp '(2 3 4 5 7))
(mean-squared-error yo yp)
;-> 1.6

(setq yo '(1 2 3 4))
(setq yp '(2 3 4 5 7))
(mean-squared-error yo yp)
;-> 1

(setq yo '(1 2 3 4))
(setq yp '(2 3 4 5))
(mean-squared-error yo yp)
;-> 1

(setq yo '(1 2 3 4 5))
(setq yp '(2 3 4 5))
(mean-squared-error yo yp)
;-> ERR: value expected in function sub : y
;-> called from user function (mean-squared-error yo yp)
(mean-squared-error yp yo)
;-> 1


----------------
Sequenze aliquot
----------------
Una sequenza aliquot è una successione di numeri interi tale che ogni termine della serie è la somma dei divisori propri del termine precendente. I divisori propri di un numero sono tutti i divisori di quel numero, tranne il numero stesso.

Ad esempio la sequenza aliquot generata dal numero 44 sarà: 44, 40, 50, 43, 1.
In dettaglio: I divisori propri di 44 sono 1, 2, 4, 11 e 22.
Il termine successivo della sequenza sarà 40, perchè 1+2+4+11+22 = 40.
I divisori propri di 40 sono: 1, 2, 4, 5, 8, 10 e 20, per cui il terzo termine della successione sarà 50, dato che 1+2+4+5+8+10+20 = 50.
I divisori propri di 50 sono: 1, 2, 5, 10 e 25 per cui il termine successivo della serie sarà 43, dato che 1+2+5+10+25 =  43.
43 è un numero primo ed il suo unico divisore proprio è 1.

La maggioranza delle sequenze aliquot termina con 1.

Partiamo invece adesso dal numero 12496. Otterremo questa sequenza: 12496, 14288, 15472, 14536, 14264, 12496, ... La sequenza torna al numero iniziale! Questo tipo di sequenza aliquot viene definita sequenza di numeri socievoli (sociable numbers).
Partendo con 14316 otteniamo una sequenza formata da 28 termini diversi: 14316, 19116, 31704, 47616, 83328, 177792, 295488, 629072, 589786, 294896, 358336, 418904, 366556, 274924, 275444, 243760, 376736, 381028, 285778, 152990, 122410, 97946, 48976, 45946, 22976, 22744, 19916, 17716, 14316...

Possiamo anche trovare sequenze aliquot formate da due soli termini, come:
220,284,220,...  –  1184,1210,1184...  –  2620,2924,2620... –  5020,5564,5020... etc
In tal caso i due termini della serie vengono chiamati numeri amici (amichevoli, amicabili) ed ognuno è la somma dei divisori dell’altro.

Infine vi sono rare sequenze aliquot formate da un solo numero:
6,6...  –  28,28...  –  496,496...  –  8128,8128...  –  33550336,33550336...  etc
In tal caso siamo in presenza dei numeri perfetti, numeri uguali alla somma dei loro divisori propri.

In qualche raro caso, anche se il numero di partenza non è ne perfetto, ne amico, ne socievole, la sequenza  termina con un numero perfetto o con due numeri amici o con una serie di numeri socievoli. Ciò accade per esempio per il numero 95 che genera la sequenza: 95, 25, 6, 6...

Abbiamo individuato cinque tipi di sequenze aliquot e la congettura di Catalan asserisce che questi sono gli unici. 

Esistono però alcuni rari numeri che sembrano sfuggire a questa congettura: le loro sequenze aliquot, almeno per quanto se ne sa fin’ora, sembrano non terminare mai. I primi di essi sono: 276, 552, 564, 660 e 966. Per questi numeri sono stati calcolati decine di migliaia di termini della loro sequenza aliquot, ma ancora non si è riusciti a stabilire se la sequenza alla fine terminerà in uno dei modi predetti o proseguirà all’infinito.

(define (factor-i num)
"Factorize a big integer number"
  (local (f k i dist out)
    ; Distanze tra due elementi consecutivi della ruota (wheel)
    (setq dist (array 48 '(2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4
                           6 8 4 2 4 2 4 8 6 4 6 2 4 6 2 6 6 4
                           2 4 6 2 6 4 2 4 2 10 2 10)))
    (setq out '())
    (while (zero? (% num 2)) (push '2L out -1) (setq num (/ num 2)))
    (while (zero? (% num 3)) (push '3L out -1) (setq num (/ num 3)))
    (while (zero? (% num 5)) (push '5L out -1) (setq num (/ num 5)))
    (while (zero? (% num 7)) (push '7L out -1) (setq num (/ num 7)))
    (setq k 11L i 0)
    (while (<= (* k k) num)
      (if (zero? (% num k))
        (begin
          (push k out -1)
          (setq num (/ num k)))
        (begin
          (setq k (+ k (dist i)))
          (if (< i 47) (++ i) (setq i 0)))
      )
    )
    (if (> num 1) (push (bigint num) out -1))
    out))

(factor-i 12345678901234567L)
;-> (7L 1763668414462081L)

(define (factor-group num)
"Factorize an integer number"
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
      ; usa "factor-i" per usare i big-integer
      ;(letn ((out '()) (lst (factor-i num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

(define (divisors-sum num)
"Sum all the divisors of integer number"
(if (zero? num) 0
  (local (sum out)
    (if (= num 1)
        1
        (begin
          (setq out 1)
          (setq lst (factor-group num))
          (dolist (el lst)
            (setq sum 0)
            (for (i 0 (last el))
              (setq sum (+ sum (pow (first el) i)))
            )
            (setq out (* out sum))))))))

Funzione che calcola la sequenza aliquot di un determinato numero:

(define (make-chain num limit)
  (local (conta continua out)
    (if (nil? limit) (setq limit 100))
    (setq out (list num))
    (setq continua true)
    (setq conta 0)
    (while (and (< conta limit) continua)
      (setq val (- (divisors-sum num) num))
      (if (find val out)
          (setq continua nil)
      )
      (push val out -1)
      (++ conta)
      (setq num val)
      ; overflow int64
      (if (< num 0) (setq continua nil conta 999999999))
      ;(println num)
    )
    (if (>= conta limit)
      (println "Limite: " conta " raggiunto.")
    )
    out))

Numeri generici (terminano con (... 1 0 0)):

(make-chain 1)
;-> (1 0 0)
(make-chain 2)
;-> (2 1 0 0)
(make-chain 44)
;-> (44 40 50 43 1 0 0)

Numeri amici (amicabili):

(make-chain 220)
;-> (220 284 220)
(make-chain 284)
;-> (284 220 284)

Numeri socievoli:

(make-chain 12496)
;-> (12496 14288 15472 14536 14264 12496)
(make-chain 14316)
;-> (14316 19116 31704 47616 83328 177792 295488 629072 
;->  589786 294896 358336 418904 366556 274924 275444 
;->  243760 376736 381028 285778 152990 122410 97946 
;->  48976 45946 22976 22744 19916 17716 14316)

Numeri perfetti:
(make-chain 6)
;-> (6 6)
(make-chain 496)
;-> (496 496)

Numeri amici-socievoli-perfetti:
(make-chain 95)
;-> (95 25 6 6)

Numeri senza-fine:
276, 552, 564, 660 e 966

(make-chain 552)
;-> Limite: 100 raggiunto.
;-> (552 888 1392 2328 3552...
;->  ... 520472208892277964 947162005047505716)

Vediamo le sequenze aliquot dei primi 500 numeri:

(for (i 1 500) (println i { } (make-chain i 200)))
;-> 1 (1 0 0)
;-> 2 (2 1 0 0)
;-> 3 (3 1 0 0)
;-> 4 (4 3 1 0 0)
;-> 5 (5 1 0 0)
;-> 6 (6 6)
;-> ...
;-> 270 (270 450 759 393 135 105 87 33 15 9 4 3 1 0 0)
;-> 271 (271 1 0 0)
;-> 272 (272 286 218 112 136 134 70 74 40 50 43 1 0 0)
;-> 273 (273 175 73 1 0 0)
;-> 274 (274 140 196 203 37 1 0 0)
;-> 275 (275 97 1 0 0)
;-> 276 Limite: 999999999 raggiunto.
;-> (276 396 696 1104 1872 3770 3790
;->  ...
;->  8244565422068579772 -4705801703595252444)
;-> ...
;-> 498 (498 510 786 798 1122 1470 2634 2646 4194 4932 7626 8502 9978
;->      9990 17370 28026 35136 67226 33616 37808 40312 35288 37072 
;->      45264 79728 146448 281166 281178 363942 424638 526338 722961 
;->      321329 1 0 0)
;-> 499 (499 1 0 0)
;-> 500 (500 592 586 296 274 140 196 203 37 1 0 0)

Nota: per maggiori informazioni e novità sulle sequenze aliquot vedi il sito http://www.aliquotes.com/.


--------------------------------
Assegnazione di valori tra liste
--------------------------------

Supponiamo di avere due liste, una costituita da simboli/variabili e una costituita da valori numerici.

(setq var '(a b c d))
(setq num '(1 2 3 4))

Possiamo assegnare ai simboli della lista "var" i valori della lista "num" applicando la funzione "set" a tutti gli elementi della lista utilizzando la funzione "map":

(map set var num)
;-> (1 2 3 4)
;(map setq var num) ;sembra che dia lo stesso risultato

Adesso i simboli della lista hanno un valore:

(list a b c d)
;-> (1 2 3 4)
a
;-> 1
var
;-> (a b c d)

Stampa degli elementi della lista "var":

(dolist (el var) (print el { }))
;-> (a b c d)

Stampa dei valori degli elementi della lista "var":

(dolist (el var) (print (eval el) { }))
;-> 1 2 3 4

Comunque con le liste annidate otteniamo un errore:

(setq var '(a b (c d)))
(setq num '(1 2 3 4))
(map set var num)
;-> ERR: symbol expected in function set : '(c d)
a
;-> 1
b
;-> 2
c
;-> nil

Possiamo usare la funzione "flat" per le liste annidate:

(map set (flat var) num)
;-> (1 2 3 4)
(list a b c d)
;-> (1 2 3 4)
(dolist (el var) (print el { }))
;-> a b (c d)
(dolist (el (flat var)) (print (eval el) { }))
;-> 1 2 3 4

Questo tipo di assegnazione avviene in maniera parallela (cioè tutti i valori vengono assegnati simultaneamente). Ad esempio:

(setq var '(a b c d))
(setq num '(1 2 3 4))
(map set var num)
;-> (1 2 3 4)

Adesso calcoliamo in modo parallelo:

a = a + b = 1 + 2 = 3
b = b = 2 
c = c = 3
d = a + d = 1 + 4 = 5

Nell'ultima espressione "a" vale 1 (non 3 come dato da a = a + b), cioè i valori iniziali non cambiano quando avviene una valutazione parallela:

(map set '(a b c d) (list (+ a b) b c (+ a d)))
;-> (3 2 3 5)

Un valutazione seriale avrebbe prodotto il seguente risultato:

a = a + b = 1 + 2 = 3
b = b = 2 
c = c = 3
d = a + d = 3 + 4 = 7

Questo comportamento può servire per scambiare il valore di più variabili. Ad esempio:

(setq x 1 y 2 z 3)

  x = y => 2
  y = z => 3
  z = x => 1

(map set '(x y z) (list y z x))
;-> (2 3 1)

Un'assegnazione seriale produce un risultato diverso:

(setq x 1 y 2 z 3)
(setq x y y z z x)
(list x y z)
;-> (2 3 2)


----------
Help macro
----------

Una macro per aprire dalla REPL il manuale di riferimento di newLISP per una determinata funzione:

(define-macro (help _func)
   (setq _func (string _func))
   (if (ends-with _func "?") (setf (_func -1) "p"))
   ;(println (append "start chrome file:///C:/newlisp/newlisp_manual.html#" string _func))
   (! (append "start chrome file:///C:/newlisp/newlisp_manual.html#" _func)))

(help case)
;-> 0
(help list?)
;-> 0

=============================================================================

