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

Nell'ultima espressione "a" vale 1 (non 3 come dato da a = a + b), cioè i valori iniziali non cambiano quando avviene una valutazione parallela (che è quello che fa "map"):

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


-------------------
Sequenza di Recaman
-------------------

La sequenza di Recaman è una sequenza definita da una relazione di ricorrenza, poiché i suoi elementi sono correlati agli elementi precedenti in modo diretto.

La successione di Recaman a(0), a(1), ... a(n) è definita come:

       = 0           se n = 0
  a(n) = a(n-1) - n, se a(n-1) - n > 0 e non si trova nella sequenza
       = a(n-1) + n, altrimenti

I primi termini della sequenza sono:

  0, 1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23, 9, 24, 8, 25, 43, 62,
  42, 63, 41, 18, 42, 17, 43, 16, 44, 15, 45, 14, 46, 79, 113, 78, 114, 77,
  39, 78, 38, 79, 37, 80, 36, 81, 35, 82, 34, 83, 33, 84, 32, 85, 31, 86,
  30, 87, 29, 88, 28, 89, 27, 90, 26, 91, 157, 224, 156, 225, 155, ...

Funzione di Recaman con una lista semplice:

(define (recaman num)
  (local (curr prev out)
    (setq out '(0))
    (setq prev 0)
    (for (i 1 num)
      (setq curr (- prev i))
      (if (or (< curr 0) (find curr out))
          (setq curr (+ prev i))
      )
      (push curr out -1)
      (setq prev curr)
    )
    out))

(recaman 50)
;-> (0 1 3 6 2 7 13 20 12 21 11 22 10 23 9 24 8 25 43 62 42 63 
;->  41 18 42 17 43 16 44 15 45 14 46 79 113 78 114 77 39 78 38 
;->  79 37 80 36 81 35 82 34 83 33)


------------------------------
Hash-Map Quick Reference Guide
------------------------------

Creazione di una hash-map:

(new Tree 'myhash)
;-> myhash

Funzione per creare una hash-map

(define (new-hash str) (new Tree (sym str)))

(new-hash "pippo")
(pippo "1" "a")
;-> "a"
(pippo)
;-> (("1" "a"))

Eliminazione di una hash-map:

(delete 'myhash)
;-> true

Funzione per eliminare una hash-map:

(define (del-hash str) (delete (sym str)))
(del-hash "pippo")
;-> true
(pippo)
;-> ERR: invalid function : (pippo)

(del-hash "boh")
;-> true

Inserimento di una coppia (chiave-valore) nella hash-map:

(new Tree 'myhash)
(myhash "1" "a")
;-> "a"
(myhash "2" "b")
;-> "b"

Elenco delle coppie in una hash-map:

(myhash)
;-> (("1" "a") ("2" "b"))

Eliminazione di una coppia (chiave-valore) nella hash-map:

(myhash "1" nil)
;-> nil
(myhash)
;-> (("2" "b"))

(myhash "1" "a")
;-> "a"

Funzione che elenca le coppie chiave-valore di una hash-map:

(define (list-hash str)
  (eval-string (append "(" (string str) ")")))

(list-hash myhash)
;-> (("1" "a") ("2" "b"))

Creazione di hash-map da una variabile:

(setq a "demo")
(new Tree (sym (eval a)))
(demo)
;-> ()
 
(setq a "prova")
(new-hash a)
(prova)
;-> ()

Ricerca di una chiave sulla hash-map:

(myhash "1")
;-> "a"
(myhash 1)
;-> "a"
(myhash "a")
;-> nil
(myhash "4")
;-> nil
(true? (myhash "1"))
;-> true

Una hash-map non è una lista, ma possiamo usare lo stesso dolist per elencare tutte le coppie chiave-valore:

(list? myhash)
;-> nil
(dolist (cp (myhash)) (println (list (cp 0) (cp 1))))
;-> ("1" "a")
;-> ("2" "b")

Per creare una lista di associazione da una hash-map basta assegnare la valutazione della hash-map ad una variabile:

(setq alst (myHash))
;-> (("#1234" "hello world") ("1" "uno") ("_y" (1 2))
;->  ("il numero" 123) ("var" (a b c d)) ("x" "stringa"))

(list? alst)
;-> true

Per popolare una hash-map possiamo anche usare una lista:

(myhash '((3 4) (5 6)))
;-> myhash

(myhash)
;-> (("1" "a") ("2" "b") ("3" 4) ("5" 6))

Nota: le chiavi del dizionario sono ordinate in maniera lessicografica.

Cosa accade alle liste che hanno valori della chiave ripetuti?

Nella lista seguente le chiavi "1" e "3" sono ripetute:

(setq lst '(("4" 4) ("1" 0) ("2" 2) ("3" 0) ("1" 1) ("3" 3) ("5" 5)))

Quando assegniamo la lista ad una hash-map i valori con chiave multipla vengono memorizzati soltanto una volta...ma quali elementi sceglie e quali elimina newLISP?
Facciamo una prova:

(new Tree 'hash)
(hash lst)
;-> hash
(hash)
;-> (("1" 1) ("2" 2) ("3" 3) ("4" 4) ("5" 5))

Gli elementi ("1" 0) e ("3" 0) sono stati eliminati... cioè quelli che si trovavano prima.
In newLISP la hash-map inserisce gli elementi partendo dal fondo della lista (poi nella hash-map gli elementi sono ordinati in base alla chiave). Quindi quando incontra elementi multipli prende l'ultimo che compare nella lista (cioè il primo partendo dal fondo della lista).

Lista di tutti i simboli di una hash-map (contesto):

(symbols myhash)
;-> (myhash:_1 myhash:_2 myhash:_3 myhash:_5 myhash:myhash)

Nota: Le chiavi (simboli) vengono memorizzate precedute dal contesto e dal carattere underscore "_".

le espressioni hash restituiscono un riferimento al loro contenuto che può essere modificato direttamente:

(pop (myHash "var"))
;-> a

(myHash "var")
;-> (b c d)

(push 'z (myHash "var"))
;-> (z b c d)

(myHash "var")
;-> (z b c d)

Quando si impostano i valori hash, la variabile anaforica di sistema "$it" può essere utilizzata per riferirsi al vecchio valore quando si imposta il nuovo:

(myhash "bar" "hello world")
;-> "hello world"

(myhash "bar" (upper-case $it))
;-> "HELLO WORLD"

(myhash "bar")
;-> "HELLO WORLD"

Le hash-map possono essere salvate in un file e ricaricate in un secondo momento:

; save dictionary
(save "myhash.lsp" 'myhash)
;-> true

Caricamento di una hash-map dal file "myhash.lsp":

(load "myhash.lsp")
;-> MAIN
(myhash)
(("1" "a") ("2" "b") ("3" 4) ("5" 6) ("bar" "HELLO WORLD"))


-------------------------------
Strutture dati autoreferenziali
-------------------------------

In newLISP i simboli possono essere generati durante il runtime e possono essere considerati come indirizzi di memoria generalizzati.
Per esempio possiamo creare una lista in cui un elemento è il simbolo della lista stessa:

(set 'x (list 'x 1 2 3))
;-> (x 1 2 3)

(println x)
;-> (x 1 2 3)

(x 0)
;-> x

(first x)
;-> x

(last x)
;-> 3

(eval (x 0))
;-> (x 1 2 3)

(rest x)
;-> (1 2 3)

(eval x)
;-> 1

(dolist (el x) (print el { }))
;-> x 1 2 3

Possiamo anche creare strutture (liste) più complesse:

(set 'y (list 'y (list (list 1 2) 3 (list 3 4)) (list 5 6)))
;-> (y ((1 2) 3 (3 4)) (5 6))
y
;-> (y ((1 2) 3 (3 4)) (5 6))
(rest y)
;-> (((1 2) 3 (3 4)) (5 6))


-----------------
Calcoli nel tempo
-----------------

Nel 1876 Edouard Lucas dimostrò indirettamente che il numero (2^67 − 1) non poteva, come era stato ipotizzato dall'inizio del 1600, essere un numero primo. Tuttavia, Lucas non fu in grado di scomporre questo numero enorme in fattori primi. Quindi, nel 1903, il matematico americano Frank Cole (1861-1926) fece la seguente presentazione in una riunione dell'American Mathematical Society: senza dire una parola, si avvicinò alla lavagna e calcolò 2^67 − 1,

2^67 − 1 = 147.573.952.589.676.412.927

Poi moltiplicò a mano il prodotto,

193.707.721 * 761.838.257.287 = 147.573.952.589.676.412.927

I due calcoli portavano allo stesso risultato, e il pubblico esplose all'unisono in una fragorosa standing ovation. Cole in seguito disse che gli ci vollero vent'anni di domeniche pomeriggio per scomporre il numero 147.573.952.589.676.412,927 nei due fattori primi 193.707.721 e 761.838.257.287.

Nel 2021 con un computer (e newLISP) possiamo verificare velocemente il risultato (usando i big-integer):

Funzione che calcola la potenza di un numero intero

(define (** num power)
  (let (out 1L)
    (dotimes (i power)
      (setq out (* out num)))))

(- (** 2 67) 1)
;-> 147573952589676412927L

Risultato della moltiplicazione:

(* 193707721L 761838257287L)
;-> 147573952589676412927L

E possiamo anche fattorizzare il numero 147.573.952.589.676.412.927:

Funzione che fattorizza un numero intero (big-integer)

(define (factor-i num)
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

(time (println (factor-i 147573952589676412927L)))
;-> (193707721L 761838257287L)
;-> 20404.858 (20 secondi)


-------------------
Text file utilities
-------------------

Alcune semplici funzioni per la gestione di file di testo dalla REPL di newLISP.

Nota: per una gestione completa vedi le GNU CoreUtils, raccolta di utilità di base per la manipolazione di file di testo e della shell.

http://gnuwin32.sourceforge.net/packages/coreutils.htm
https://gitforwindows.org/
https://git-scm.com/

File di prova: "lines.txt" (si trova nella cartella "data")

  linea 1: lines words chars
  linea 6: newLISP
  linea 4: demo
  linea 6: newLISP
  linea 3: GNU Core Utilities
  linea 2: missing values
  linea 5: GNU Core Utilities
  linea 7: unique lines

Nota: i file senza percorso vengono cercati nella cartella corrente della REPL,
(real-path)
;-> "F:\\Lisp-Scheme\\newLisp\\MAX\\newLISP-NoteNEW"


Conteggio di linee, parole e caratteri di un file
-------------------------------------------------

(define (lwc-count file-in)
  (local (line lc wc cc)
    (setq lc 0 wc 0 cc 0)
    (setq file-in (open file-in "read"))
      ; lettura file di input
      (while (setq line (read-line file-in))
        ; lines count
        (++ lc)
        ; words count
        (setq wc (+ wc (length (parse (trim line) "\\s+" 0))))
        ; chars count 
        ; (+1 add back the line feed - Unix)
        ; (+2 add back the line feed/carriage return - Windows)
        ;(setq cc (+ cc (length line) 1))
        (setq cc (+ cc (length line) 2))
      )
      (close file-in)
    (list lc wc cc)))

(lwc-count "lines.txt")
;-> (8 32 201)

(lwc-count "F:\\Lisp-Scheme\\newLisp\\MAX\\newLISP-NoteNEW\\newLISP-Note.lsp")
;-> (124161 653567 4277748)

Stampa di un file (stdout)
--------------------------

(define (print-lines file-in)
    ; apertura file di input
    (setq file-in (open file-in "read"))
    ; lettura e stampa file di input su stdout
    (while (read-line file-in)
      (println (current-line))
    )
    ; chiusura file di input
    (close file-in))

(print-lines "lines.txt")

Linee uniche di un file
-----------------------

(define (unique-lines file-in file-out)
  (local (lst ext)
    (setq lst '())
    (setq ext "-unique.txt")
    ; apertura file di output
    (if (nil? file-out)
        (setq file-out (open (string file-in ext) "write"))
        (setq file-out (open file-out "write")))
    ; apertura file di input
    (setq file-in (open file-in "read"))
    ; lettura file di input su lista
    (while (read-line file-in)
      (push (current-line) lst -1))
    ; chiusura file di input
    (close file-in)
    ; creazione lista con elementi univoci
    (setq lst (unique lst))
    ; scrittura lista su file di output
    (map (fn(line) (write-line file-out line)) lst)
    ; chiusura file di output
    (close file-out)
  ))

(unique-lines "lines.txt")
(print-lines "lines.txt-unique.txt")

Ordinamento delle linee di un file
----------------------------------

(define (sort-lines file-in file-out)
  (local (lst ext)
    (setq lst '())
    (setq ext "-sort.txt")
    ; apertura file di output
    (if (nil? file-out)
        (setq file-out (open (string file-in ext) "write"))
        (setq file-out (open file-out "write")))
    ; apertura file di input
    (setq file-in (open file-in "read"))
    ; lettura file di input su lista
    (while (read-line file-in)
      (push (current-line) lst -1))
    ; chiusura file di input
    (close file-in)
    ; ordinamento della lista
    (sort lst)
    ; scrittura lista su file di output
    (map (fn(line) (write-line file-out line)) lst)
    ; chiusura file di output
    (close file-out)
  ))

(sort-lines "lines.txt")
(print-lines "lines.txt-sort.txt")

Estrazione di linee da un file
------------------------------

(define (extract-lines start end file-in file-out)
  (local (lst ext)
    (setq lst '())
    (setq ext "-extract.txt")
    ; apertura file di output
    (if (nil? file-out)
        (setq file-out (open (string file-in ext) "write"))
        (setq file-out (open file-out "write")))
    ; apertura file di input
    (setq file-in (open file-in "read"))
    ; lettura file di input su lista
    (while (read-line file-in)
      (push (current-line) lst -1))
    ; chiusura file di input
    (close file-in)
    ; estrazione linee dalla lista
    (setq lst (slice lst (- start 1) (+ (- end start) 1)))
    ; scrittura lista su file di output
    (map (fn(line) (write-line file-out line)) lst)
    ; chiusura file di output
    (close file-out)
  ))

; estrazione delle prime 4 linee
(extract-lines 1 4 "lines.txt" "lines-1-4.txt")
(print-lines "lines-1-4.txt")

; estrazione delle ultime 5 linee
(extract-lines -4 0 "lines.txt" "lines-4-0.txt")
(print-lines "lines-4-0.txt")
;->   linea 6: newLISP
;->   linea 3: GNU Core Utilities
;->   linea 2: missing values
;->   linea 5: GNU Core Utilities
;->   linea 7: unique lines

Unione sequenziale di due file
-------------------------------
(define (append-lines file1 file2 file-out)
  (local (lst ext)
    (setq lst '())
    (setq ext "-join.txt")
    ; apertura file di output
    (if (nil? file-out)
        (setq file-out (open (string file1 "-" file2 ext) "write"))
        (setq file-out (open file-out "write")))
    ; apertura primo file di input
    (setq file1 (open file1 "read"))
    ; lettura primo file di input su lista
    (while (read-line file1)
      (push (current-line) lst -1))
    ; chiusura primo file di input
    (close file1)
    ; apertura secondo file di input
    (setq file2 (open file2 "read"))
    ; lettura secondo file di input su lista
    (while (read-line file2)
      (push (current-line) lst -1))
    ; chiusura primo file di input
    (close file2)
    ; scrittura lista su file di output
    (map (fn(line) (write-line file-out line)) lst)
    ; chiusura file di output
    (close file-out)
  ))

(append-lines "lines.txt" "lines.txt" "lineslines.txt")
(print-lines "lineslines.txt")

Copia di un file
----------------

Funzione predefinita in newLISP:
--------------------------------
(copy-file str-from-name str-to-name)

(copy-file "lines.txt" "lines-copy.txt")
(print-lines "lines-copy.txt")

Copia di file di testo e di file binari:
----------------------------------------
(define (copy-chars from-file to-file)
    (setq from-file (open from-file "read"))
    (setq to-file (open to-file "write"))
    (while (setq chr (read-char from-file))
        (write-char to-file chr))
    (close from-file)
    (close to-file)
    "finished")

(copy-chars "lines.txt" "lines-copy-chars.txt")
(print-lines "lines-copy-chars.txt")

Copia di file di testo:
-----------------------
(define (copy-lines from-file to-file)
    (setq from-file (open from-file "read"))
    (setq to-file (open to-file "write"))
    (while (read-line from-file))
        (write-line to-file (current-line))
    (close from-file)
    (close to-file)
    "finished")

(copy-chars "lines.txt" "lines-copy-lines.txt")
(print-lines "lines-copy-lines.txt")

Inversione delle linee di un file
---------------------------------

(define (reverse-lines file-in file-out)
  (local (lst ext)
    (setq lst '())
    (setq ext "-reverse.txt")
    ; apertura file di output
    (if (nil? file-out)
        (setq file-out (open (string file-in ext) "write"))
        (setq file-out (open file-out "write")))
    ; apertura file di input
    (setq file-in (open file-in "read"))
    ; lettura file di input su lista
    (while (read-line file-in)
      (push (current-line) lst -1))
    ; chiusura file di input
    (close file-in)
    ; creazione lista inversa
    (setq lst (reverse lst))
    ; scrittura lista su file di output
    (map (fn(line) (write-line file-out line)) lst)
    ; chiusura file di output
    (close file-out)
  ))

(reverse-lines "lines.txt")
(print-lines "lines.txt-reverse.txt")

Mescolamento delle linee di un file
-----------------------------------

(define (shuffle-lines file-in file-out)
  (local (lst ext)
    (setq lst '())
    (setq ext "-shuffle.txt")
    ; apertura file di output
    (if (nil? file-out)
        (setq file-out (open (string file-in ext) "write"))
        (setq file-out (open file-out "write")))
    ; apertura file di input
    (setq file-in (open file-in "read"))
    ; lettura file di input su lista
    (while (read-line file-in)
      (push (current-line) lst -1))
    ; chiusura file di input
    (close file-in)
    ; creazione lista mescolata
    (setq lst (randomize lst))
    ; scrittura lista su file di output
    (map (fn(line) (write-line file-out line)) lst)
    ; chiusura file di output
    (close file-out)
  ))

(shuffle-lines "lines.txt")
(print-lines "lines.txt-shuffle.txt")

Lista con tutte le linee di un file
-----------------------------------

(define (list-lines file)
  (let (lst '())
    ; apertura file di input
    (setq file (open file "read"))
    ; lettura file di input su lista
    (while (read-line file)
      (push (current-line) lst -1))
    ; chiusura file di input
    (close file)
    lst))

(save "list-lines.lsp" 'list-lines)
;-> true

(list-lines "list-lines.lsp")
;-> ("(define (list-lines file)" 
;->  "  (let (lst '()) " 
;->  "   (setq file (open file \"read\")) "
;->  "   (while (read-line file) " 
;->  "    (push (current-line) lst -1)) " 
;->  "   (close file) lst))"
;->  "")


----------------
Code Obfuscation
----------------

L'offuscamento del codice è una delle tecniche preferite per la sicurezza delle applicazioni in modo da proteggersi dall'hacking. È una delle iniziative più consigliate dai professionisti della sicurezza di tutto il mondo e, il più delle volte, funge da meccanismo di difesa principale contro i tentativi di hacking e protegge da attacchi comuni, come l'iniezione di codice, il reverse engineering e la manomissione delle informazioni personali dei clienti e degli utenti delle applicazioni.

Code Obfuscation (offuscamento del codice) è il processo di modifica di un eseguibile (e/o del codice sorgente) in modo che non sia più utile per un hacker, ma rimanga completamente funzionante. Sebbene tale processo possa modificare il modello originale delle istruzioni o i metadati, non altera l'output del programma. 

Nota: con abbastanza tempo e impegno, quasi tutto il codice può essere decodificato.

L'offuscamento automatico del codice rende il "reverse engineering" di un programma difficile ed economicamente irrealizzabile.
Rendendo un'applicazione molto più difficile da decodificare, puoi proteggerti dal furto di segreti commerciali (proprietà intellettuale), dall'accesso non autorizzato, dall'elusione della licenza, dalla scoperta di vulnerabilità o da altri controlli.

Metodi di offuscamento
----------------------
L'offuscamento del codice consiste in molte tecniche diverse che possono completarsi a vicenda per creare una difesa a più livelli. È più efficace per i linguaggi che creano una qualche forma di istruzioni di livello intermedio come Java o i linguaggi .NET. Vediamo alcuni esempi tipici di tecniche di offuscamento e sicurezza delle applicazioni:

1) Rename Obfuscation
La ridenominazione altera il nome di metodi e variabili. Rende il sorgente decompilato più difficile da capire per un essere umano, ma non altera l'esecuzione del programma. I nuovi nomi possono utilizzare schemi diversi come "a", "b", "c" o numeri, caratteri non stampabili o caratteri invisibili. E i nomi possono essere gli stessi (overload) purché abbiano un ambito diverso. Questo offuscamento è una trasformazione di base utilizzata dalla maggior parte degli offuscatori.

2) String Encryption 
In un programma eseguibile, tutte le stringhe sono chiaramente individuabili e leggibili. Anche quando i metodi e le variabili vengono rinominati, le stringhe possono essere utilizzate per individuare sezioni di codice critiche cercando i riferimenti di stringa all'interno del file binario. Ciò include i messaggi (soprattutto i messaggi di errore) che vengono visualizzati all'utente. Per fornire una barriera efficace contro questo tipo di attacco, la crittografia delle stringhe nasconde le stringhe nell'eseguibile e ripristina il loro valore originale solo quando necessario. La decrittografia delle stringhe in fase di esecuzione in genere comporta una leggera riduzione delle prestazioni.

3) Aggregation Obfuscation
Ciò altera il modo in cui i dati vengono archiviati nel programma. Ad esempio, gli array potrebbero essere scomposti in molti sotto-array, che potrebbero quindi essere referenziati in punti diversi del programma.

4) Storage obfuscation
Questo cambia il modo stesso in cui i dati vengono archiviati in memoria. Ad esempio, gli sviluppatori possono passare dall'archiviazione locale a quella globale delle variabili, in modo da offuscare la vera natura del comportamento delle variabili.

5) Ordering obfuscation
Questo metodo riordina il modo in cui i dati vengono ordinati non alterando il comportamento del frammento di programma/codice. Gli sviluppatori lo realizzano sviluppando un modulo separato che viene chiamato per tutte le istanze di riferimento alle variabili.

6) Control Flow Obfuscation
L'offuscamento del flusso di controllo sintetizza costrutti condizionali, ramificati e iterativi che producono una logica eseguibile valida, ma producono risultati semantici non deterministici quando vengono decompilati. Detto più semplicemente, fa sembrare il codice decompilato una logica a "spaghetti" che è molto difficile da comprendere. Queste tecniche possono influire sulle prestazioni di runtime di un metodo.

7) Instruction Pattern Transformation
Converte le istruzioni comuni create dal compilatore in altri costrutti meno ovvi. Queste sono istruzioni in linguaggio macchina perfettamente legali che potrebbero non essere mappate in modo diretto in linguaggi di alto livello come Java. Un esempio è la memorizzazione nella cache delle variabili transitorie che sfrutta la natura basata sullo stack dei runtime Java e .NET.

8) Dummy Code Insertion
L'inserimento di codice nell'eseguibile che non influisce sulla logica del programma, ma interrompe i decompilatori o rende il codice decodificato molto più difficile da analizzare.

9) Unused Code and Metadata Removal
La rimozione delle informazioni di debug, dei metadati non essenziali e del codice utilizzato dalle applicazioni li rende più piccoli e riduce le informazioni disponibili per un utente malintenzionato. Questa procedura può migliorare leggermente le prestazioni di runtime.

10) Binary Linking/Merging
Questa trasformazione combina più eseguibili/librerie di input in uno o più file binari di output. Il linking può essere utilizzato per ridurre le dimensioni dell'applicazione, soprattutto se utilizzato con la ridenominazione e l'eliminazione. Può semplificare gli scenari di distribuzione e ridurre le informazioni disponibili per gli hacker.

11) Opaque Predicate Insertion
Offusca aggiungendo rami condizionali che valutano sempre a risultati noti, risultati che non possono essere facilmente determinati tramite l'analisi statica. Questo è un modo per introdurre codice potenzialmente errato che non verrà mai effettivamente eseguito, ma confonde gli aggressori che cercano di comprendere l'output decompilato.

12) Address Obfuscation
Gli attacchi che sfruttano gli errori di programmazione della memoria, in particolare con linguaggi non protetti dalla memoria, come C, C++, sono diventati all'ordine del giorno. Errori come l'accesso all'array non controllato spesso comportano vulnerabilità di sicurezza. Il metodo di offuscamento degli indirizzi rende difficile il processo di reverse engineering, poiché ogni volta che viene eseguito il codice trasformato, gli indirizzi virtuali del codice e dei dati del programma vengono randomizzati. Ciò rende l'effetto della maggior parte degli exploit di errore di memoria non deterministico, con solo una minima possibilità di successo.

13) Custom Encoding
Utilizzando questo metodo, gli sviluppatori codificano le stringhe utilizzando un algoritmo personalizzato e forniscono una funzione di decodifica per recuperare il codice originale.

14) Passing Arguments at Runtime
Il programma può essere modificato per ricevere argomenti in fase di esecuzione (runtime). Ciò richiede che l'utente disponga sia del codice che della chiave di decrittografia per decrittografare le variabili.

15) Anti-Tamper
Un offuscatore può inserire l'autoprotezione dell'applicazione nel codice per verificare che l'applicazione non sia stata in alcun modo manomessa. Se viene rilevata una manomissione, può chiudere l'applicazione, limitare la funzionalità, richiamare arresti anomali casuali (per mascherare il motivo dell'arresto anomalo) o eseguire qualsiasi altra azione personalizzata. Potrebbe anche inviare un messaggio a un servizio per fornire dettagli sulla manomissione rilevata.

16) Anti-Debug
Quando un hacker sta cercando di piratare o contraffare la tua app, rubare i tuoi dati o alterare il comportamento di un software di infrastruttura critico, quasi sicuramente inizierà con il reverse engineering e passerà la tua applicazione attraverso un debugger. Un offuscatore può sovrapporre l'autoprotezione dell'applicazione iniettando codice per rilevare se l'applicazione di produzione è in esecuzione all'interno di un debugger. Se viene utilizzato un debugger, può corrompere i dati sensibili (proteggendoli dal furto), invocare arresti anomali casuali (per nascondere che l'arresto anomalo è stato il risultato di un controllo di debug) o eseguire qualsiasi altra azione personalizzata. Potrebbe anche inviare un messaggio a un servizio per fornire un segnale di avviso.

Il successo dell'offuscamento del codice dipende da diversi parametri che determinano la qualità della trasformazione del codice. La qualità di una tecnica di offuscamento dovrebbe essere determinata dalla combinazione dei seguenti fattori:

Strength and resilience
-----------------------
Un codice offuscato è buono solo quanto il suo anello più debole. Quindi il modo migliore per verificare la qualità è verificare quanta resistenza viene mostrata dal codice offuscato quando viene provato il de-offuscamento. Maggiore è lo sforzo e il tempo necessari per violare il codice, migliore sarà l'offuscamento.

Differentiation and Potency
---------------------------
Questo mostra la misura in cui il codice offuscato è diverso dal codice originale. La profondità dei flussi di controllo, i livelli di nidificazione e i livelli di ereditarietà vengono utilizzati per aumentare la complessità del codice sorgente. L'offuscamento del codice aumenta questo livello di complessità

Stealth
-------
Il codice offuscato deve essere indistinguibile dal codice sorgente originale in modo che l'attaccante sia confuso riguardo alla sezione offuscata. Ciò rende il reverse engineering una proposta difficile da intraprendere per l'attaccante. Questo fattore dipende da un contesto all'altro ed è spesso un fattore cruciale per eludere gli attacchi automatizzati di reverse engineering.

Cost
----
È definito come il tempo e le risorse impiegate per eseguire il codice offuscato rispetto al codice non offuscato. Alcune considerazioni sulle prestazioni devono essere prese in considerazione durante l'implementazione di un codice offuscato. Un codice intelligentemente offuscato dovrebbe servire allo scopo di confondere l'attaccante utilizzando tecniche prudenti e senza spendere inutilmente costi/risorse.

Nota: in breve, più potente e complesso è l'offuscamento, maggiore è il rallentamento delle prestazioni.

Offuscamento e newLISP
----------------------
newLISP non crea file eseguibili compilati. L'eseguibile di newLISP (.EXE) contiene due parti: l'interprete newLISP e il codice del programma (in fondo al file .EXE in formato ASCII).
Se aprite con un editor di testo un eseguibile creato da newLISP, si può facilmente individuare il codice del programma, in formato testo, alla fine del file.

Non ho mai avuto la necessità di offuscare nessun programma (probabilmente perchè non sono un programmatore professionista).
Al mio livello, per rendere complicato il lavoro di un eventuale "copiatore", spesso è sufficiente rimuovere i commenti e l'indentazione di un programma.
Per esempio, prendiamo seguente funzione:

(define (eval-rpn lst)
"Evaluate a RPN expression"
  (local (_stack _a _b _op _op1 _op2)
    (setq _stack '())
    ; lista operatori con un argomento
    (setq _op1 '(abs sqrt exp sin cos tan asin acos atan))
    ; lista operatori con due argomenti
    (setq _op2 '(+ - * / % add sub mul div mod pow atan2))
    ; Valuto gli elementi della lista (espressione rpn) e
    ; assegno il valore alle variabili
    (setq lst (map (fn (x) (if (not (protected? x)) (eval x) x)) lst))
    ; Per ogni simbolo della lista...
    (dolist (el lst)
      (cond ((number? el)      ; se è un numero...
             (push el _stack)) ; lo metto nella pila
            (true ; altrimenti è un operatore
             (cond ((find el _op1) ;operatore unario
                    (setq _a (pop _stack))    ; prendo numeri dalla pila
                    (setq _op (eval el))     ; calcolo operazione
                    (push (_op _a) _stack))    ; inserisco risultato nella pila
                   ((find el _op2) ;operatore binario
                    (setq _a (pop _stack))    ; prendo numeri dalla pila
                    (setq _b (pop _stack))    ; prendo numeri dalla pila
                    (setq _op (eval el))     ; calcolo operazione
                    (push (_op _b _a) _stack))  ; inserisco risultato nella pila
                   (true (println "error:" el))
             ))
      )
    )
    ;restituisco il valore in cima alla pila
    (pop _stack)))

Per eliminare i commenti posso utilizzare la funzione con "save":

(save "eval-rpn.lsp" 'eval-rpn)
;-> true

Per vedere la funzione senza commenti possiamo caricarla con la funzione "load":

(load "eval-rpn.lsp")

Poi usiamo la seguente funzione per togliere la formattazione:

(define (xyz file)
  (local (lst line)
    (setq lst '())
    ; open output file
    (setq file-out (open (string file ".xyz") "write"))
    ; open input file
    (setq file (open file "read"))
    ; read file line by line...
    (while (setq line (read-line file))
      ; remove leading and trailing space
      ; and add a space " " at the end
      (setq line (append (trim line) " "))
      (push line lst -1)
      ; remove comments (full line only)
      ;(if (not (starts-with line ";"))
      ;    (push line lst -1))
    )
    ; close input file
    (close file)
    ; write lines of list without the line-terminating character
    (map (fn(linea) (write file-out linea)) lst)
    ; close output file
    (close file-out)))

(xyz "eval-rpn.lsp")
;-> true

Adesso il file "eval-rpn.lsp" è stato convertito nel file "eval-rpn.lsp.xyz":

(define (eval-rpn lst) "Evaluate a RPN expression" (local (_stack _a _b _op _op1 _op2) (setq _stack '()) (setq _op1 '(abs sqrt exp sin cos tan asin acos atan)) (setq _op2 '(+ - * / % add sub mul div mod pow atan2)) (setq lst (map (lambda (x) (if (not (protected? x)) (eval x) x)) lst)) (dolist (el lst) (cond ((number? el) (push el _stack)) (true (cond ((find el _op1) (setq _a (pop _stack)) (setq _op (eval el)) (push (_op _a) _stack)) ((find el _op2) (setq _a (pop _stack)) (setq _b (pop _stack)) (setq _op (eval el)) (push (_op _b _a) _stack)) (true (println "error:" el)))))) (pop _stack)))
;-> (lambda (lst) "Evaluate a RPN expression"
;->  (local (_stack _a _b _op _op1 _op2)
;->   (setq _stack '())
;->   (setq _op1 '(abs sqrt exp sin cos tan asin acos atan))
;->   (setq _op2 '(+ - * / % add sub mul div mod pow atan2))
;->   (setq lst (map (lambda (x)
;->      (if (not (protected? x))
;->       (eval x) x)) lst))
;->   (dolist (el lst)
;->    (cond
;->     ((number? el) (push el _stack))
;->     (true
;->      (cond
;->       ((find el _op1) (setq _a (pop _stack)) (setq _op (eval el)) (push (_op _a)
;->         _stack))
;->       ((find el _op2) (setq _a (pop _stack)) (setq _b (pop _stack)) (setq _op (eval
;->          el))
;->        (push (_op _b _a) _stack))
;->       (true (println "error:" el))))))
;->   (pop _stack)))

Vediamo se la funzione "offuscata" funziona correttamente:

(eval-rpn '(3 4 2 * 1 5 - 2 3 pow pow / +))
;-> 3
(setq a 10 b 20)
(eval-rpn '(a b + 5 - sqrt))
;-> 5


-----------------
newLISP compiler?
-----------------
newLISP è un linguaggio interpretato e non è destinato ad avere un compilatore. Mi chiedo solo se sia (teoricamente) possibile.
A questa domanda risponde il creatore di newLISP, Lutz Mueller:

"Yes, you could compile newLISP if you take away some of its dynamic nature. Like no other Lisp, newLISP implements the code-equals-data paradigm 100%. E.g. self modifying code like this (created by Kazimir):

; no iteration, no recursion, but runs forever
(define (f)
  (begin
    (println (inc cnt))
    (push (last f) f -1)
    (if (> (length f) 3) (pop f 1))))

or sequences like this:

(define (foo x) . . . )

(save "foo.lsp" 'foo)

... would not be allowed in code to be compiled. One would work around this by compiling incrementally only designated functions, e.g. by introducing a built-in 'compile' function. This is how Common Lisp systems work, selectively compiling functions in an interpreted environment.

Another obstacle is the data-type polymorphic nature of many newLISP functions. It doesn't make compilation impossible but produces less efficient compiled code, when data types are not known during compile time. This could be alleviated somewhat by introducing type-tags in newLISP source, to help the compiler where possible.

My philosophy is to keep newLISP 100% dynamic, giving the programmer a maximum freedom of expression and comfortable interactive working. A scripting language not limited by all sorts of constraints and extra features to make it a compilable language at the same time.

When analyzing programs, which do have performance bottle-necks, you will always find those problems isolated to specific portions of the code. These portions can be compiled in another language and 'import'ed.

Many times programs already exist to efficiently perform a certain complex function. In that case newLISP has functions like 'exec' and 'process' and facilities like pipes and networking, to interact with those programs.

Compilable Lisp and Scheme were created in a time where people still believed, they could create that one programming tool for every purpose. Today we know the optimal way is, to use different specialized tools together to solve complex problems."


---------------
Frazioni egizie
---------------

Nel 1858 uno scozzese di 25 anni, Henry Rhind, acquistò in un mercato di Luxor in Egitto un rotolo di papiro scoperto in una tomba di Tebe.
Dopo la sua morte all'età di 30 anni, il rotolo venne acquistato dal British Museum di Londra nel 1864 e da allora vi rimase, chiamato Rhind Mathematical Papyrus (o RMP in breve).

Cosa c'era scritto nel papiro?
(vedi l'immagine "rmp.png" sulla cartella "data")

I geroglifici (scrittura pittorica) sul papiro furono decifrati solo nel 1842 (e la scrittura cuneiforme su tavoletta d'argilla babilonese fu decifrata più tardi nello stesso secolo).

Inizia dicendo che lo scriba "Ahmes" lo sta scrivendo intorno al 1600 AC ma che lo aveva copiato da "antichi scritti" che, dalla sua descrizione del faraone di quel tempo, lo datano al 2000 AC o prima. 

Le prime civiltà utilizzavano la matematica per applicazioni in astronomia, in geometria e nella contabilità e gli egiziani del 3000 aC avevano un modo interessante di rappresentare le frazioni.

Sebbene avessero una notazione per 1/2 e 1/3 e 1/4 e così via (questi sono chiamati reciproci o frazioni unitarie poiché sono 1/n per un certo numero n), la loro notazione non permetteva loro di scrivere 2/ 5 o 3/4 o 4/7 come faremmo oggi.
Invece, sono stati in grado di scrivere qualsiasi frazione come somma di frazioni unitarie in cui tutte le frazioni unitarie erano diverse.

Per esempio,

3/4 = 1/2 + 1/4
6/7 = 1/2 + 1/3 + 1/42

Una frazione scritta come somma di frazioni unitarie distinte è chiamata Frazione Egizia (Egiziana).

Nel Papiro di Rhind sono esposte le regole per il calcolo delle frazioni unitarie con cui essi avevano risolto il problema dell'espressione di parti decimali di un numero non intero. La soluzione è riportata in una tabella che fornisce per ogni intero dispari n compreso tra 3 e 101, la scomposizione in frazioni unitarie della frazione 2/n.
Le iscrizioni geroglifiche egiziane presentano una notazione speciale per le frazioni aventi come numeratore l'unità. Il reciproco di un qualsiasi intero veniva indicato collocando al di sopra del segno indicante il numero, un ovale allungato (nella notazione ieratica, l'ovale allungato veniva sostituito da un puntino).
La frazione 2/3 era l'unica frazione composta rappresentata da un apposito geroglifico. Tutte le altre frazioni conosciute e usate nella matematica egizia erano unitarie.

La scomposizione di una frazione in frazioni egiziane non è unica e si può dimostrare che:
1) ogni frazione propria può essere scritta come somma di frazioni unitarie aventi i denominatori tutti diversi
2) esistono infinite scomposizioni di questo tipo per ogni frazione data.

Possiamo generare le frazioni egiziane usando il paradigma algoritmico Greedy. Un algoritmo Greedy una soluzione ammissibile da un punto di vista globale attraverso la scelta della soluzione più appetibile (definita in precedenza dal programmatore) per quel determinato programma ad ogni passo locale. Quando applicabili, questi algoritmi consentono di trovare soluzioni ottimali per determinati problemi in un tempo polinomiale.

Nel nostro caso, per un dato numero della forma "nr/dr" dove dr > nr, troviamo prima la frazione unitaria più grande possibile, quindi ripetiamo per la parte rimanente. Ad esempio, consideriamo 6/14, troviamo prima il massimale di 14/6, cioè 3. Quindi la prima frazione unitaria diventa 1/3, quindi usiamo la ricorsione per (6/14 – 1/3), cioè 4/42.

L'algoritmo Greedy funziona perché una frazione viene sempre ridotta a una forma in cui il denominatore è maggiore del numeratore e il numeratore non divide il denominatore. Per tali forme ridotte, la chiamata ricorsiva evidenziata viene effettuata per numeratore ridotto. Quindi le chiamate ricorsive continuano a ridurre il numeratore fino a raggiungere 1.

Scriviamo una funzione ricorsiva che calcola le frazioni egiziane di una frazione qualunque:

(define (egypt num den)
  (let (out '())
    (egypt-aux num den)
    out))

(define (egypt-aux nr dr)
        ; numeratore o denominatore nullo
  (cond ((or (zero? nr) (zero? dr)) nil)
        ; se il numeratore divide il denominatore
        ; allora con una semplice divisione
        ; costruiamo la frazione nella forma 1/n
        ((zero? (% dr nr))
         (push (list 1 (/ dr nr)) out -1))
        ; se il denominatore divide il numeratore
        ; allora la frazione è un numero intero
        ((zero? (% nr dr))
         (push (list (/ nr dr) 1) out -1))
        ; quando il numeratore è maggiore del denominatore
        ; la prima frazione è un numero intero >= 1
        ((> nr dr)
         (push (list (/ nr dr) 1) out -1)
         ; ricorsione sulla parte rimanente
         (egypt-aux (% nr dr) dr)
        )
        (true
         (let (n (+ (/ dr nr) 1))
          (push (list 1 n) out -1)
          ; ricorsione sulla parte rimanente
          (egypt-aux (- (* nr n) dr) (* dr n))
         )
        )
  ))

Facciamo alcune prove:

(egypt 6 14)
;-> ((1 3) (1 11) (1 231))
6/14 =  1/3 + 1/11 + 1/231 

(egypt 21 17)
;-> ((1 1) (1 5) (1 29) (1 1233) (1 3039345))
(div 21 17)
;-> 1.235294117647059
(add 1 (div 5) (div 29) (div 1233) (div 3039345))
;-> 1.235294117647059

(egypt 3 7)
;-> ((1 3) (1 11) (1 231))
(egypt 100 2)
;-> ((50 1))

Nota: Poichè la scomposizione di una frazione in una somma di frazioni unitarie non è unica, qual è quella migliore?
Quella di lunghezza minima? 
Quella con i denominatori più piccoli?

Adesso vediamo un semplice esempio di utilizzo delle frazioni egizie.

Problema
--------
Dividere 5 mele in parti uguali fra 8 ragazzi.
Dividereste forse tutte le mele in 8 parti e ne dareste 5 ad ogni ragazzo? In questo caso, dovreste fare 7 * 5 = 35 tagli.
Visto che: 5/8 = 1/2 + 1/8, è più pratico dividere 4 mele a metà e l'ultima in 8 parti e consegnare mezza mela e un ottavo di mela ad ogni ragazzo. In tutto abbiamo fatto 11 tagli.

Mela 1      Mela 2      Mela 3      Mela 4    
1/2 + 1/2   1/2 + 1/2   1/2 + 1/2   1/2 + 1/2   

Mela 5
1/8 + 1/8 + 1/8 + 1/8 + 1/8 + 1/8 + 1/8 + 1/8


Vediamo la funzione inversa che prende una serie di frazioni egiziane e le converte nella corrispondente frazione propria:

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))

(define (+rat r1 r2)
  (rat (+ (* (r1 0) (r2 1))
          (* (r2 0) (r1 1)))
       (* (r1 1) (r2 1))))

(define (from-egypt lst)
  (let (out '(0 1))
    (dolist (f lst)
      (setq out (+rat out f))
    )
    out))

(egypt 5 8)
;-> ((1 2) (1 8))

(from-egypt '((1 2) (1 8)))
;-> (5 8)

=============================================================================

