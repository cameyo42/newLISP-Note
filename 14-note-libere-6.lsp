===============

 NOTE LIBERE 6

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

Funzione per creare una hash-map:

(define (new-hash str) (new Tree (sym str)))

(new-hash "pippo")
(pippo "1" "a")
;-> "a"
(pippo)
;-> (("1" "a"))

Altra funzione per creare un contesto/hash-map (Lutz):

(define (create-context-from-name str)
   (sym str (sym str MAIN))
)

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

Aggiornamento di un valore di una chiave utilizzando il valore attuale:

(myhash "2" (string "a" (myhash "2")))
;-> "ab"

Elenco delle coppie in una hash-map:

(myhash)
;-> (("1" "a") ("2" "ab"))

Aggiornamento di un valore di una chiave:

(myhash "2" "b")
;-> "b"

Eliminazione di una coppia (chiave-valore) nella hash-map:

(myhash "1" nil)
;-> nil
(myhash)
;-> (("2" "b"))

(myhash "1" "a")
;-> "a"

Lunghezza di una hash-map:

(length (myhash))
;-> 2

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

Possiamo generare le frazioni egiziane usando l'algoritmo Greedy di Fibonacci. Un algoritmo Greedy una soluzione ammissibile da un punto di vista globale attraverso la scelta della soluzione più appetibile (definita in precedenza dal programmatore) per quel determinato programma ad ogni passo locale. Quando applicabili, questi algoritmi consentono di trovare soluzioni ottimali per determinati problemi in un tempo polinomiale.

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

Adesso scriviamo una funzione iterativa che calcola le frazioni egiziane di una frazione qualunque:

(define (egizia a b)
  (local (n)
    ;(if (zero? (% a b))
    ;    (println (/ a b)))
    (while (> (div b a) (/ b a))
      (setq n (/ b a))
      (print "1/" (+ n 1) " + ")
      (setq a (- (* (+ n 1) a) b))
      (setq b (* (+ n 1) b))
    )
    (println "1/" (/ b a))
    "end"
))

(egizia 21 34)
;-> 1/2 + 1/9 + 1/153
(egypt 21 34)
;-> ((1 2) (1 9) (1 153))
(egizia 20 10)
;-> 1/1 + 1/1
(egypt 20 10)
;-> ((2 1))
(egizia 20 3)
;-> 1/1 + 1/1 + 1/1 + 1/1 + 1/1 + 1/1 + 1/2 + 1/6
(egypt 20 3)
;-> ((6 1) (1 2) (1 6))
(egizia 21 17)
;-> 1/1 + 1/5 + 1/29 + 1/1233 + 1/303934
(egypt 21 17)
;-> ((1 1) (1 5) (1 29) (1 1233) (1 3039345))

Nota: questo algoritmo non produce sempre la sequenza di frazioni egiziane di lunghezza minima.

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
    (map (curry * 1)
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

(from-egypt '((1 3) (1 5) (1 7)))
;-> (71 105)
(egypt 71 105)
;-> ((1 2) (1 6) (1 105))
(from-egypt '((1 2) (1 6) (1 105)))
;-> (71 105)

Nota: le seguenti formule permettono di creare altre sequenze di frazioni egizie equivalenti ad una sequenza data:

   1         1             1
  --- = ----------- + -----------
  a*b    a*(a + b)     b*(a + b)

   1              1                     1                     1
------- = ------------------- + ------------------- + -------------------
 a*b*c    a*(a*b + b*c + c*a)   b*(a*b + b*c + c*a)   b*(a*b + b*c + c*a)

Esistono altri metodi per costruire le frazioni egizie ed ognuno ha le proprie caratteristiche:

(vedi "Egyptians Fractions"
https://pls.scienze.unipd.it/matematica/wp-content/uploads/sites/3/2018/07/2018.-MJ-Casagrande.-Articolo-Egypt.pdf)

1) Metodo di Fibonacci
   7/2 = 1/2 + 1/4 + 1/36

2) Metodo di Golomb
   7/9 = 1/2 + 1/6 + 1/12 + 1/36

3) Metodo dei numeri pratici
   7/9 = 1/2 + 1/6 + 1/9

4) Metodo geometrico
   7/9 = 1/2 + 1/6 + 1/12 + 1/36
   7/9 = 1/2 + 1/6 + 1/9
   ...


------------------------------------
Formule polinomiali per numeri primi
------------------------------------

Trovare una funzione che generi tutti i numeri primi o infiniti numeri primi è un desiderio irrealizzabile.

Si può dimostrare che non esiste alcun polinomio non costante a valori interi che generi esclusivamente numeri primi: infatti, se questo esistesse (sia ad esempio P(n)), allora P(1)=p sarebbe primo e P(1) ≡ 0 (mod p). Allora, per qualunque intero k vale anche P(1 + k*p) ≡ 0 (mod p) (in quanto aggiungere dei multipli di p non varia la congruenza modulo p), ma questo comporta che P(1+kp) sarebbe allora primo e divisibile per p, cioè sarebbe proprio uguale a p. Ma allora P(n) assumerebbe infinite volte lo stesso valore, cosa impossibile per il principio d'identità dei polinomi.

Comunque esistono dei polinomi che generano diversi numeri primi consecutivi (cioè non intervallati da numeri non primi).

1) x² + x + 41 (Eulero)

Questa polinomiale genera 40 numeri primi consecutivi con x da 0 a 39.

(define (eulero x) (+ (* x x) x 41))

(for (x 0 39) (print "(" x { } (eulero x) ") "))
;-> (0 41) (1 43) (2 47) (3 53) (4 61) (5 71) (6 83) (7 97) (8 113) (9 131)
;-> (10 151) (11 173) (12 197) (13 223) (14 251) (15 281) (16 313) (17 347)
;-> (18 383) (19 421) (20 461) (21 503) (22 547) (23 593) (24 641) (25 691)
;-> (26 743) (27 797) (28 853) (29 911) (30 971) (31 1033) (32 1097)
;-> (33 1163) (34 1231) (35 1301) (36 1373) (37 1447) (38 1523) (39 1601)

2) 2x² + 29 (Legendre)

Questa polinomiale genera 29 numeri primi consecutivi con x da 0 a 28.

(define (legendre x) (+ (* 2 x x) 29))
(for (x 0 28) (print "(" x { } (legendre x) ") "))
;-> (0 29) (1 31) (2 37) (3 47) (4 61) (5 79) (6 101) (7 127) (8 157) (9 191)
;-> (10 229) (11 271) (12 317) (13 367) (14 421) (15 479) (16 541) (17 607)
;-> (18 677) (19 751) (20 829) (21 911) (22 997) (23 1087) (24 1181)
;-> (25 1279) (26 1381) (27 1487) (28 1597)

3) x² + x + 17 (Legendre)

Questa polinomiale genera 16 numeri primi consecutivi con x da 0 a 15.

(define (legendre2 x) (+ (* x x) x 17))
(for (x 0 28) (print "(" x { } (legendre2 x) ") "))
;-> (0 17) (1 19) (2 23) (3 29) (4 37) (5 47) (6 59) (7 73) (8 89) (9 107)
;-> (10 127) (11 149) (12 173) (13 199) (14 227) (15 257) (16 289) (17 323)
;-> (18 359) (19 397) (20 437) (21 479) (22 523) (23 569) (24 617) (25 667)
;-> (26 719) (27 773) (28 829)

4) abs(36x² – 810x + 2753)

Genera 45 numeri primi da 0 a 44

(define (poly4 x) (abs (+ (* 36 x x) (* x (- 810)) 2753)))
(for (x 0 44) (print "(" x { } (poly4 x) ") "))

5) abs(47x² – 1701x + 10181)

Genera 43 numeri primi da 0 a 42

(define (poly5 x) (abs (+ (* 47 x x) (* x (- 1701)) 10181)))
(for (x 0 42) (print "(" x { } (poly5 x) ") "))

6) abs(43x² – 537x + 2971)

Genera 35 numeri primi da 0 a 34

(define (poly6 x) (abs (+ (* 43 x x) (* x (- 537)) 2971)))
(for (x 0 34) (print "(" x { } (poly6 x) ") "))

7) abs(7x² – 371x + 4871)

Genera 24 numeri primi da 0 a 23

(define (poly7 x) (abs (+ (* 7 x x) (* x (- 371)) 4871)))
(for (x 0 23) (print "(" x { } (poly7 x) ") "))

Scriviamo una funzione che verifica la correttezza di queste polinomiali:

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (check func a b)
  (local (out)
  (for (x a b)
    (if (prime? (func x)) ;se il numero è primo...
        ; allora lo inserisce nella lista
        (push (func x) out -1)
        ; altrimenti stampa un messaggio di errore
        (println "error: " x "," (func x))
    )
  )
  (println (length out) " numeri primi.")
  out))

Verifichiamo se le polinomiali sono corrette, cioè producono solo numeri primi:

(check eulero 0 39)
;-> 40 numeri primi.
;-> (41 43 47 53 61 71 83 97 113 131 151 173 197 223 251 281 313 347 383
;->  421 461 503 547 593 641 691 743 797 853 911 971 1033 1097 1163 1231
;->  1301 1373 1447 1523 1601)
(check legendre 0 28)
;-> 29 numeri primi.
;-> (29 31 37 47 61 79 101 127 157 191 229 271 317 367 421 479
;->  541 607 677 751 829 911 997 1087 1181 1279 1381 1487 1597)
(check legendre2 0 15)
;-> 16 numeri primi.
;-> (17 19 23 29 37 47 59 73 89 107 127 149 173 199 227 257)
(check poly4 0 44)
;-> 45 numeri primi.
;-> (2753 1979 1277 647 89 397 811 1153 1423 1621 1747 1801 1783
;->  1693 1531 1297 991 613 163 359 953 1619 2357 3167 4049 5003
;->  6029 7127 8297 9539 10853 12239 13697 15227 16829 18503 20249
;->  22067 23957 25919 27953 30059 32237 34487 36809)
(check poly5 0 42)
;-> 43 numeri primi.
;-> (10181 8527 6967 5501 4129 2851 1667 577 419 1321 2129 2843 3463
;->  3989 4421 4759 5003 5153 5209 5171 5039 4813 4493 4079 3571 2969
;->  2273 1483 599 379 1451 2617 3877 5231 6679 8221 9857 11587 13411
;->  15329 17341 19447 21647)
(check poly6 0 34)
;-> 35 numeri primi.
;-> (2971 2477 2069 1747 1511 1361 1297 1319 1427 1621 1901 2267 2719 3257
;->  3881 4591 5387 6269 7237 8291 9431 10657 11969 13367 14851 16421 18077
;->  19819 21647 23561 25561 27647 29819 32077 34421)
(check poly7 0 23)
;-> 24 numeri primi.
;-> (4871 4507 4157 3821 3499 3191 2897 2617 2351 2099 1861 1637 1427 1231
;->  1049 881 727 587 461 349 251 167 97 41)

Infine un polinomio che genera 57 numeri primi (per x da 0 a 56):

  (1/4)*(x^5 - 133x^4 + 6729x^3 - 158379x^2 + 1720294x - 6823316)
  per (0<= x <=56)

(define (poly x)
  (abs (div (+ (* x x x x x)
               (* x x x x (- 133))
               (* x x x 6729)
               (* x x (- 158379))
               (* x 1720294)
               (- 6823316))
            4)))

(check poly 0 56)
;-> 57 numeri primi.
;-> (1705829 1313701 991127 729173 519643 355049 228581 134077 65993
;->  19373 10181 26539 33073 32687 27847 20611 12659 5323 383 3733
;->  4259 1721 3923 12547 23887 37571 53149 70123 87977 106207 124351
;->  142019 158923 174907 189977 204331 218389 232823 248587 266947
;->  289511 318259 355573 404267 467617 549391 653879 785923 950947
;->  1154987 1404721 1707499 2071373 2505127 3018307 3621251 4325119)


------------------------------------------------------
Nomi delle variabili/funzioni e velocità di esecuzione
------------------------------------------------------

Newlisp è un linguaggio interpretato. Quindi uno potrebbe chiedersi:
la lunghezza delle variabili influenza la velocità di esecuzione/valutazione?
In altre parole, il mio programma è più veloce se uso, diciamo, x invece di xxxxxx?

Per rispondere sperimentalmente alla domanda utilizziamo due esempi di Kazimir Majorinc (leggermente modificati):

Primo esempio
-------------
(setq varname 'a)
(for (i 1 9)
     (set 'expr
          (expand '(for (varname 1 100)
                        (+ (- varname 1) (- varname 2)))
                   'varname))
     (set 'evtime
          (time (eval (eval expr)) 10000))
     (print "length(var)=" (length (string varname)))
     (print ", length(expression)=" (length (string expr)))
     (print ", time=" evtime)
     (setq varname (sym (dup (string varname) 2)))
     (println))
;-> a
;-> length(var)=1, length(expression)=35, time=68.848
;-> length(var)=2, length(expression)=38, time=69.842
;-> length(var)=4, length(expression)=44, time=68.84399999999999
;-> length(var)=8, length(expression)=56, time=68.848
;-> length(var)=16, length(expression)=80, time=68.845
;-> length(var)=32, length(expression)=128, time=68.84399999999999
;-> length(var)=64, length(expression)=224, time=68.845
;-> length(var)=128, length(expression)=416, time=69.81399999999999
;-> length(var)=256, length(expression)=800, time=68.848

Secondo esempio
---------------
(setq varname1 'a)
(setq varname2 'b)
(for (i 1 9)
     (set 'expr
          (expand '(begin (set 'varname1
                               (lambda(varname2)
                                      (if (< varname2 3)
                                          1
                                          (+ (varname1 (- varname2 1))
                                             (varname1 (- varname2 2))))))
                          (varname1 12))
                  'varname1
                  'varname2))
     (set 'evtime
          (time (eval expr) 10000))
     (print "length(var)=" (length (string varname1)))
     (print ", length(expression)=" (length (string expr)))
     (print ", time=" evtime)
     (setq varname1 (sym (dup (string varname1) 2)))
     (setq varname2 (sym (dup (string varname2) 2)))
     (println))
;-> a
;-> b
;-> length(var)=1, length(expression)=79, time=301.224
;-> length(var)=2, length(expression)=87, time=301.196
;-> length(var)=4, length(expression)=103, time=304.201
;-> length(var)=8, length(expression)=135, time=299.23
;-> length(var)=16, length(expression)=199, time=299.229
;-> length(var)=32, length(expression)=327, time=302.22
;-> length(var)=64, length(expression)=583, time=301.239
;-> length(var)=128, length(expression)=1095, time=301.196
;-> length(var)=256, length(expression)=2119, time=304.184

I risultati affermano che la lunghezza del nome delle variabili non influenza la velocità di esecuzione del programma.

Perche?

Prima che newLISP valuti un'espressione, il reader/parser trasforma internamente ogni espressione in una struttura ad albero di celle lisp, dove una variabile è solo un puntatore di memoria a un simbolo dell'albero.
Quindi qualsiasi differenza nel tempo di esecuzione sarebbe visibile solo durante il caricamento del codice sorgente o durante l'esecuzione delle funzioni newLISP, che a loro volta traducono i nomi delle variabili durante la creazione di simboli, come (sym ...).


-----------------------------------
Radici primitive di un numero primo
-----------------------------------

Il piccolo Teorema di Fermat afferma che, se P è un numero primo, allora, per ogni intero a minore di P:

 a^(P-1) ≡ 1 (modulo P)

Cioè il resto della divisione di a^(P-1) diviso P è sempre 1.

Si definisce ordine di "a modulo P" il più piccolo esponente x tale che:

 a^x ≡ 1 (modulo P)

Se l’ordine di "a modulo P" è proprio (P-1), allora "a" si definisce "radice primitiva di P".

Per esempio con il numero primo 13 abbiamo:

Ordine di  2  modulo 13 = 12, per cui 2 è una radice primitiva di 13
Ordine di  3  modulo 13 = 3
Ordine di  4  modulo 13 = 6
Ordine di  5  modulo 13 = 4
Ordine di  6  modulo 13 = 12, per cui 6 è una radice primitiva di 13
Ordine di  7  modulo 13 = 12, per cui 7 è una radice primitiva di 13
Ordine di  8  modulo 13 = 4
Ordine di  9  modulo 13 = 3
Ordine di 10  modulo 13 = 6
Ordine di 11  modulo 13 = 12, per cu 11 è una radice primitiva di 13
Ordine di 12  modulo 13 = 2

Scriviamo alcune funzioni:

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (** num power)
"Calculates the integer power of an integer"
  (let (out 1L)
    (dotimes (i power)
      (setq out (* out num)))))

(define (pm a b q)
"Calculates  a^b mod q"
  (let (out 1L)
    (while (> b 0)
      (if (odd? b)
          (setq out (% (* out a) q)))
      (setq a (% (* a a) q))
      (setq b (/ b 2)))
    out))

Funzione che calcola l'ordine di "a modulo primo":

(define (ordine a primo)
  (local (res stop)
    (setq res 0)
    (setq stop nil)
    (for (x 1 primo 1 stop)
      (if (= (% (** a x) primo) 1)
          (setq res x stop true)
      )
    )
    res))

(for (i 2 12) (print (ordine i 13) { }))
;-> 12 3 6 4 12 12 4 3 6 12 2

Funzione che calcola le radici primitive di un numero primo:

(define (radici primo)
  (local (ord out)
    (setq out '())
    (for (i 1 (- primo 1))
       (setq ord (ordine i primo))
       (if (= ord (- primo 1))
           (push i out -1)
       )
     )
     out))

Facciamo alcune prove:

(radici 13)
;-> (2 6 7 11)
(radici 2)
;-> (1)
(radici 3)
;-> (2)
(radici 7)
;-> (3 5)
(radici 11)
;-> (2 6 7 8)
(radici 31)
;-> (3 11 12 13 17 21 22 24)

(radici 383)
;-> (5 10 11 13 15 20 22 26 30 33 35 37 39 40 41 44 45 47 52 53 59 60 61
;->  66 70 74 77 78 79 80 82 83 85 88 89 90 91 94 95 97 99 104 105 106 107
;->  109 111 115 117 118 120 122 123 125 127 131 132 135 140 141 145 148
;->  151 154 155 156 157 158 159 160 163 164 166 167 170 176 177 178 179
;->  180 181 182 183 187 188 190 191 194 197 198 199 208 209 210 211 212
;->  214 215 218 221 222 230 231 233 234 236 237 239 240 241 244 245 246
;->  247 249 250 253 254 255 257 259 262 264 267 269 270 271 273 275 280
;->  281 282 283 285 287 290 291 296 297 299 302 307 308 310 311 312 314
;->  315 316 318 319 320 321 325 326 327 328 329 332 333 334 335 337 340
;->  341 345 347 349 351 352 354 355 356 358 359 360 362 364 365 366 367
;->  369 371 374 375 376 377 379 380 381)

(radici 761)
;-> (6 7 11 12 14 22 24 26 30 31 43 44 48 51 52 53 54 55 56 57 60 63 70 71
;->  73 83 88 97 99 102 104 106 108 109 110 111 112 114 120 122 123 124 126
;->  127 130 131 138 141 142 146 147 151 155 161 163 172 173 174 175 177 187
;->  191 192 193 194 197 198 199 201 204 206 209 211 215 216 218 220 221 222
;->  223 224 227 228 229 231 234 237 240 241 244 247 248 251 253 255 257 260
;->  265 266 267 269 270 273 275 276 279 280 282 284 285 287 293 294 300 302
;->  303 313 314 315 317 319 321 322 326 329 332 337 339 343 344 346 348 350
;->  352 354 355 359 363 365 367 373 374 377 379 382 384 387 388 394 396 398
;->  402 406 407 409 411 413 415 417 418 422 424 429 432 435 439 440 442 444
;->  446 447 448 458 459 461 467 468 474 476 477 479 481 482 485 486 488 491
;->  492 494 495 496 501 504 506 508 510 513 514 517 520 521 524 527 530 532
;->  533 534 537 538 539 540 541 543 545 546 550 552 555 557 560 562 563 564
;->  567 568 569 570 574 584 586 587 588 589 598 600 606 610 614 615 619 620
;->  623 630 631 634 635 637 638 639 641 647 649 650 651 652 653 655 657 659
;->  662 664 673 678 688 690 691 698 701 704 705 706 707 708 709 710 713 717
;->  718 730 731 735 737 739 747 749 750 754 755)

(time (radici 761))
;-> 27260.93

Per verificare i risultati possiamo sfruttare il fatto che ogni primo p ha ϕ(P−1) radici primitive (dove ϕ è la funzione di Eulero o "toziente", cioè una funzione definita, per ogni intero positivo n, come il numero degli interi compresi tra 1 e n che sono coprimi con n).

(define (totient num)
"Calculate the eulero totient of a given number"
  (if (= num 1) 1
    (let (res num)
      (dolist (f (unique (factor num)))
        (setq res (- res (/ res f))))
      res)))

Verifichiamo i risultati precedenti:

(totient 12)
;-> 4
(totient 1)
;-> 1
(totient 2)
;-> 1
(totient 6)
;-> 2
(totient 10)
;-> 4
(totient 30)
;-> 8

(length (radici 383))
;-> 190
(totient 382)
;-> 190
(length (radici 761))
;-> 288
(totient 760)
;-> 288

Anche se i risultati sonoo corretti, le funzioni sono molto lente. Allora, proviamo ad utilizzare la funzione esponenziale modulare:

(define (pm a b q)
"Calculates a^b mod q"
  (let (out 1L)
    (while (> b 0)
      (if (odd? b)
          (setq out (% (* out a) q)))
      (setq a (% (* a a) q))
      (setq b (/ b 2)))
    out))

E poi riscriviamo la funzione "ordine":

(define (ordine a primo)
  (local (res stop)
    (setq res 0)
    (setq stop nil)
    (for (x 1 primo 1 stop)
      ; linea modificata
      ;(if (= (% (** a x) primo) 1)
      (if (= (pm a x primo) 1)
          (setq res x stop true)
      )
    )
    res))

Facciamo alcune prove:

(radici 13)
;-> (2 6 7 11)
(radici 2)
;-> (1)
(radici 3)
;-> (2)
(radici 7)
;-> (3 5)
(radici 11)
;-> (2 6 7 8)
(radici 31)
;-> (3 11 12 13 17 21 22 24)

(time (radici 761))
;-> 872.282

Questa modifica rende il programma molto più veloce, ma... non abbastanza:

(time (radici 5003))
;-> 66742.514 ; 66 secondi

(time (radici 10181))
;-> 236409.836 ; quasi 4 minuti

Comunque spesso viene richiesto di trovare solo la radice primitiva più piccola, allora possiamo utilizzare la seguente funzione (molto simile a "radici"):

(define (radice primo)
  (local (ord stop res)
    (setq res 0)
    (setq stop nil)
    (for (i 1 (- primo 1) 1 stop)
       (setq ord (ordine i primo))
       (if (= ord (- primo 1))
           (setq res i stop true)
       )
     )
     res))

Verifichiamo i risultati precedenti:

(radice 11)
;-> 2
(radice 31)
;-> 3
(radice 383)
;-> 5
(radice 761)
;-> 6
(radice 5003)
;-> 2
(radice 10181)
;-> 2

Le radici primitive sono anche collegate con il "periodo della frazione 1/P":
in generale, la lunghezza del periodo di 1/P è uguale all’ordine di 10 modulo P.

Nell’esempio precedente abbiamo visto che l’ordine di 10 modulo 13 è 6 e possiamo verificare che la lunghezza del periodo della frazione 1/ 13 è proprio 6:

1/13 = 0.(076923)076923076923076923…

(div 13)
;-> 0.07692307692307693
(ordine 10 13)
;-> 6

Proviamo con altri numeri primi:

1/7 = 0.(142857)1428571429

(div 7)
;-> 0.1428571428571429
(ordine 10 7)
;-> 6

(div 11)
;-> 0.09090909090909091
(ordine 10 11)
;-> 2

(div 71)
(ordine 10 71)
;-> (35)

(div 383)
;-> 0.002610966057441253
(ordine 10 383)
;-> 382


------------------
Salto della rana 1
------------------

Una rana vuole raggiungere l'altro lato della strada. La rana si trova attualmente nella posizione X e vuole raggiungere una posizione maggiore o uguale a Y. La rana salta sempre a una distanza fissa, D. Scrivere una funzione che, dati tre interi X, Y e D, restituisce il numero minimo di salti dalla posizione X ad una posizione uguale o maggiore di Y.

Prima soluzione
---------------
(define (jump-basic x y d)
  (let (conta 0)
    (cond ((zero? d) 0)
    (true
      (while (< x y)
        (setq x (+ x d))
        (++ conta)
      )
      conta))))

(jump-basic 10 20 0)
;-> 0
(jump-basic 10 20 2)
;-> 5
(jump-basic 10 21 2)
;-> 6

Seconda soluzione
-----------------
Possiamo notare che:
- se Y - X è divisibile per D, allora ci vogliono (Y - X) / D salti
- se Y - X non è divisibile per D, allora ci vogliono (Y - X) / D + 1 salti

(define (jump x y d)
  (let (conta 0)
    (cond ((zero? d) 0)
    (true
      (if (zero? (% (- y x) d))
          (/ (- y x) d)
          (+ (/ (- y x) d) 1))))))

(jump 10 20 0)
;-> 0
(jump 10 20 2)
;-> 5
(jump 10 21 2)
;-> 6


------------------
Salto della rana 2
------------------

Una rana vuole attraversare il fiume. Supponiamo che il fiume sia diviso equamente in celle, e che in ogni cella ci sia una pietra o l'acqua. La rana può saltare sulle pietre, ma non può saltare sull'acqua.

Data una lista di pietre con numeri di celle crescenti. Determinare se la rana può attraversare con successo il fiume (cioè saltare sull'ultima pietra nell'ultimo passaggio).

All'inizio, la rana si trova sulla prima pietra e può saltare solo un'unità nel primo passaggio (cioè, può saltare solo dalla prima cella alla seconda cella).

Se la rana compie un salto di k unità, allora la sua distanza del salto successivo può essere (k - 1), k o (k + 1) unità. Inoltre la rana può solo saltare in avanti (nella direzione del punto finale).

Esempio 1:
Input: pietre = (0 1 3 5 6 8 12 17)
Output: true
La rana può attraversare il fiume saltando come segue:
da 0  a 1  (d=1)
da 1  a 3  (d=2)
da 3  a 5  (d=2)
da 5  a 8  (d=3)
da 8  a 12 (d=4)
da 12 a 17 (d=5)

Esempio 2:
Input: pietre = (0 1 2 3 4 8 9 11)
Output: nil
Questo è dovuto al fatto che c'è troppo spazio tra la quinta (4) e la sesta (8) pietra perché la rana possa saltare.

Possiamo risolvere il problema utilizzando la ricorsione.

(define (rana pietre)
  (rana-aux pietre 0 0))

(define (rana-aux pietre ind salto)
(catch
  (local (i dist)
    (setq i (+ ind 1))
    (while (<= i (- (length pietre) 1))
      (setq dist (- (pietre i) (pietre ind)))
      ; se salto possibile...
      (if (and (>= dist (- salto 1)) (<= dist (+ salto 1)))
          ;allora verifica da quella posizione
          (if (rana-aux pietre i dist) (throw true))
      )
      (++ i)
    )
    ; raggiunta la fine delle pietre?
    (= ind (- (length pietre) 1)))))

(rana '(0 1 3 5 6 8 12 17))
;-> true
(rana '(0 1 2 3 4 8 9 11))
;-> nil


--------------------------
Numeri regolari (5-smooth)
--------------------------

I numeri regolari sono numeri che dividono equamente le potenze di 60 (o, equivalentemente, le potenze di 30). Ad esempio, 60^2 = 3600 = 48 × 75, quindi sia 48 che 75 sono divisori di una potenza di 60. Pertanto, sono numeri regolari. Equivalentemente, sono i numeri i cui unici divisori primi sono 2, 3 e 5.

Sequenza OEIS: A051037
  1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 27, 30, 32,
  36, 40, 45, 48, 50, 54, 60, 64, 72, 75, 80, 81, 90, 96, 100, 108,
  120, 125, 128, 135, 144, 150, 160, 162, 180, 192, 200, 216, 225,
  240, 243, 250, 256, 270, 288, 300, 320, 324, 360, 375, 384, 400, 405

Nella teoria dei numeri, questi numeri sono chiamati 5-smooth, perché hanno solo 2, 3 o 5 come fattori primi. Questo è un caso specifico dei più generali numeri k-smooth, cioè un insieme di numeri che non hanno un fattore primo maggiore di k.

In informatica, i numeri regolari sono spesso chiamati numeri di Hamming, in onore di Richard Hamming, che propose il problema di trovare un algoritmo efficiente per generare l'elenco, in ordine crescente, di tutti i numeri della forma 2^i 3^j 5^k per i,j,k >= 0. Il problema fu reso popolare da Edsger Dijkstra. (vedi "Numeri di Hamming" nel documento "Rosetta Code") algoritmi informatici per generare questi numeri in ordine crescente.

Per scrivere la funzione che genera i numeri 5-smooth utilizziamo le primitive "factor" e "difference":

(setq a '(2 2 3 5 7))
(setq b '(2 2 3 5 5))
(setq c '(7 11 13))
(setq d '(2 2 2 3))
(setq e '(3 3 3 3))
(difference a base)
;-> (7)
(difference b base)
;-> ()
(difference c base)
;-> (7 11 13)
(difference d base)
;-> ()
(difference e base)
;-> ()

Funzione che genera i numeri regolari (5-smooth) fino ad un dato numero:

(define (regular-to num)
  (local (base out)
    (setq base '(2 3 5))
    (setq out '(1))
    (for (i 2 num)
      (setq ff (factor i))
      (if (= (difference ff base) '())
        (push i out -1)
      )
    )
    out))

(regular-to 1000)
;-> (1 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 27 30 32 36 40 45 48 50
;->  54 60 64 72 75 80 81 90 96 100 108 120 125 128 135 144 150 160
;->  162 180 192 200 216 225 240 243 250 256 270 288 300 320 324 360
;->  375 384 400 405 432 450 480 486 500 512 540 576 600 625 640 648
;->  675 720 729 750 768 800 810 864 900 960 972 1000)

(length (regular-to 1000))
;-> 86

(length (regular-to 1000000))
;-> 507

Funzione che calcola il numero regolare n-esimo:

(define (regular-nth num)
  (local (base conta idx res)
    (setq base '(2 3 5))
    (setq res 1)
    (setq conta 1)
    (setq idx 2)
    (while (< conta num)
      (setq ff (factor idx))
      (if (= (difference ff base) '())
        (begin (++ conta) (setq res idx))
      )
      (++ idx)
    )
    res))

(regular-nth 1)
;-> 1
(regular-nth 2)
;-> 2
(regular-nth 86)
;-> 1000
(regular-nth 85)
;-> 972

Vediamo i tempi di esecuzione:

(time (println (regular-nth 200)))
;-> 16200
;-> 14.967
(time (println (regular-nth 500)))
;-> 937500
;-> 1228.965 1.2 secondi
(time (println (regular-nth 1000)))
;-> 51200000
;-> 196706.779 3 minuti 16 secondi


------------------------------------------------
Conversione di una lista in un file .csv (excel)
------------------------------------------------

Scriviamo una funzione che prende una lista e salva le righe in un file di testo .csv adatto per essere importato da un foglio elettronico (excel).
I parametri della funzione sono:
- nome della lista
- nome del file di output
- carattere di separazione (opzionale, default ",")

(define (list-xls lst file sepchar)
  (local (outfile)
    (if (nil? sepchar)
        (setq sepchar ",")
    )
    (setq outfile (open file "write"))
    (dolist (el lst)
      (setq line (join (map string el) sepchar))
      (write-line outfile line)
    )
    ;(print outfile { })
    (close outfile)))

Esempio 1:

Creiamo una lista di punti:
(setq points (map list (randomize (sequence 1 100)) (randomize (sequence 1 100))))

Esportiamo la lista:
(list-xls points "punti.csv")
;-> 3 true

Esempio 2:

Creiamo una tabella:
(setq data '(("eva" "tommy" "max" "roby")
             (20 24 31 89)
             ("f" "t" "t" "f")
             (1.622 2.44 45.2 100.1)))

Lista con i nomi delle colonne:
(setq nomi '("nome" "test" "tipo" "valore"))

Per creare il formato corretto occorre trasporre la lista:
(setq all (append (list nomi) (transpose data)))
;-> (("nome" "test" "tipo" "valore")
;->  ("eva" 20 "f" 1.622)
;->  ("tommy" 24 "t" 2.44)
;->  ("max" 31 "t" 45.2)
;->  ("roby" 89 "f" 100.1))

Esportiamo la lista/tabella:

(list-xls all "demo.csv")
;-> 3 true


-----------------------------------------------
Selezione di elementi con indice pari o dispari
-----------------------------------------------

Data una lista scrivere due funzioni, una che seleziona gli elementi che hanno indice pari e una che seleziona gli elementi che hanno indice dispari.

Metodo iterativo:

(setq data '(1 2 3 4 5 6 7 8 9 10))
(setq data1 '(1 2 3 4 5 6 7 8 9 10 11))

(define (select-odd lst)
  (let (out '())
    (dolist (el lst)
      ; l'indice 0 è il primo elemento (dispari)
      (if (even? $idx) (push el out -1)))
    out))

(select-odd data)
;-> (1 3 5 7 9)
(select-odd data1)
;-> (1 3 5 7 9 11)

(define (select-even lst)
  (let (out '())
    (dolist (el lst)
      ; l'indice 0 è il primo elemento (dispari)
      (if (odd? $idx) (push el out -1)))
    out))

(select-even data)
;-> (2 4 6 8 10)
(select-even data1)
;-> (2 4 6 8 10)

Primo metodo funzionale:

(define (select-odd2 lst)
    (if (odd? (setq len (length lst)))
        (select lst (sequence 0 len 2))
        (select lst (sequence 0 (- len 1) 2))))

(select-odd2 data)
;-> (1 3 5 7 9)
(select-odd2 data1)
;-> (1 3 5 7 9 11)

(define (select-even2 lst)
    (if (even? (setq len (length lst)))
        (select lst (sequence 1 len 2))
        (select lst (sequence 1 (- len 1) 2))))

(select-even2 data)
;-> (2 4 6 8 10)
(select-even2 data1)
;-> (2 4 6 8 10)

Secondo metodo funzionale:

(define (select-odd3 lst)
  (select lst (index odd? lst)))

(select-odd3 data)
;-> (1 3 5 7 9)
(select-odd3 data1)
;-> (1 3 5 7 9 11)

(define (select-even3 lst)
  (select lst (index even? lst)))

(select-even3 data)
;-> (2 4 6 8 10)
(select-even3 data1)
;-> (2 4 6 8 10)

Test di velocità tra le tre funzioni:

(silent (setq test (sequence 1 1001)))

(time (select-odd test) 10000)
;-> 564.974
(time (select-odd2 test) 10000)
;-> 141.665
(time (select-odd3 test) 10000)
;-> 544.01
(time (select-even test) 10000)
;-> 580.453
(time (select-even2 test) 10000)
;-> 141.65
(time (select-even3 test) 10000)
;-> 543.01

(silent (setq test (sequence 1 1000000)))
(time (select-odd test) 10)
;-> 668.664
(time (select-odd2 test) 10)
;-> 208.706
(time (select-odd3 test) 10)
;-> 600.422
(time (select-even test) 10)
;-> 674.777
(time (select-even2 test) 10)
;-> 206.541
(time (select-even3 test) 10)
;-> 597.54

La funzione del primo metodo funzionale è 3 volte più veloce delle altre due funzioni.


-----------------------------
Numero interno all'intervallo
-----------------------------

Dati tre numeri x,y e z scrivere due funzioni che restituiscono true:
1) se y <= x <= z (cioè x incluso nell'intervallo chiuso)
2) se y < x < z (cioè x incluso nell'intervallo aperto))

(define (between-close x y z)
  "Return true iff number x is >= y and <= z."
  (or (<= y x z) (>= y x z)))

(define (between-open x y z)
  "Return true iff number x is > y and < z."
  (or (< y x z) (> y x z)))

(between-open -0.1 -0.1 2)
;-> nil
(between-close -0.1 -0.1 2)
;-> true
(between-close 2 4 -2)
;-> true
(between-close 2 -2 4)
;-> true
(between-close 2 -7 5)
;-> true
(between-close 2 -5 -7)
;-> nil

Possiamo scrivere una funzione unica:

(define (between x y z mode)
  "Return true iff number x is >= y and <= z or iff number x is > y and < z."
  (if (or (nil? mode) (= mode "c"))
      (or (<= y x z) (>= y x z))
      (or (< y x z) (> y x z))))

(between -0.1 -0.1 2 "o")
;-> nil
(between -0.1 -0.1 2 "c")
;-> true
(between 2 4 -2)
;-> true
(between 2 -2 4)
;-> true
(between 2 -7 5 "o")
;-> true
(between 2 -5 -7)
;-> nil


------------
Love newLISP
------------

(setq data '((5 6 7 6)
             (3 10 3 10)
             (1 13 1 13)
             (0 29)
             (0 29)
             (0 29)
             (1 27)
             (3 23)
             (5 19)
             (7 15)
             (9 11)
             (11 7)
             (13 3)
             (14 1)))

(define (decode-data mtx)
  (local (line)
    (println "")
    (for (i 0 (- (length mtx) 1))
      (setq line "")
      (dolist (el (mtx i))
        (if (even? $idx)
            (extend line (dup " " el))
            (extend line (dup "*" el))
        )
      )
      (println line)
  )
  "end"))

(decode-data data)

;->      ******       ******
;->    **********   **********
;->  ************* *************
;-> *****************************
;-> *****************************
;-> *****************************
;->  ***************************
;->    ***********************
;->      *******************
;->        ***************
;->          ***********
;->            *******
;->              ***
;->               *
;-> end


-------------------------------
Creazione dinamica dei contesti
-------------------------------

Come abbiamo visto precedentemente i contesti possono essere creati solo globalmente, cioè non è possibile avere un contesto locale.
Comunque possiamo creare dinamicamente un contesto durante il runtime utilizzando la seguente funzione che prende come parametro il nome del contesto da creare (stringa):

(define (create-context-from-name str)
   (sym str (sym str MAIN))
)

Creiamo un contesto di nome "demo" con il relativo funtore di default:

(create-context-from-name "demo")
;-> demo:demo

(length (demo))
;-> 0
(demo)
;-> ()

Per simulare un contesto locale possiamo scrivere una funzione che crea il contesto, lo utilizza e alla fine lo elimina. Per esempio:

(define (test x)
  (println "ctx:" ctx)
  (context 'ctx)
  (set 'ctx:x x)
  (println "current context:" (context))
  (println "symbols in ctx: " (symbols ctx))
  (println "ctx:x: " ctx:x)
  (println "x:" x)
  (context MAIN)
  (delete 'ctx)
)

(test 10)
;-> ctx:nil
;-> current context:ctx
;-> symbols in ctx: (x)
;-> ctx:x: 10
;-> x:10
;-> true

Nota: la creazione di un contesto è un'operazione molto veloce, mentre la cancellazione di un contesto è un'operazione abbastanza onerosa.


----------------------------------------------
Ricerca elementi dalla fine (stringhe o liste)
----------------------------------------------

La funzione "find" è equivalente a "Instr()" di VBScript. Qual è l'equivalente per "InstrRev()" di VBScript in cui si cerca la prima occorrenza dalla fine della stringa?

Vediamo esempi delle funzioni "find-all" e "find":

(find-all "pippo" "paodhjsdpippoaskdhjaskdhjpippoasmasdj")
;-> ("pippo" "pippo")
(find "pippo" "paodhjsdpippoaskdhjaskdhjpippoasmasdj")
;-> 8
(find (reverse "pippo") (reverse "paodhjsdpippoaskdhjaskdhjpippoasmasdj"))
;-> 7

La nostra funzione inverte entrambi i parametri e poi calcola l'offset dell'indice cercato:

(define (find-rev findThis inThis)
  (- (length inThis) (find (reverse findThis) (reverse inThis)) (length findThis)))

Alcune prove e un confronto di ciò che trova "find-rev" contro ciò che trova "find".

(set 'toFind "dog")
(set 'sentence "My first dog's fleas are on my second dog's blanket")

(find-rev toFind sentence)
;-> 38
(println (slice sentence (find-rev toFind sentence) (length toFind)))
; "dog"
(println (slice sentence (find-rev toFind sentence)))
; "dog's blanket"
(println (slice sentence (find toFind sentence)))
; "dog's fleas are on my second dog's blanket"

Purtroppo questa funzione opera solo sulle stringhe, allora proviamo a scrivere una funzione che lavora sulle liste utilizzando la funzione "ref-all" e poi invertendo la lista degli indici risultanti:

(setq num '(1 0 2 4 5 6 7 1))

(define (find-rev2 findThis inThis)
  (reverse (ref-all findThis inThis)))

(find-rev2 1 num)
;-> ((7) (0))
(num 7)
;-> 1

Vediamo come funziona su una lista annidata:

(setq data '(1 (0 2) 2 (3 (0 2)) 4 5 6 7 1))
(find-rev2 '(0 2) data)
;-> ((3 1) (1))
(data 3 1)
;-> (0 2)
(data '(3 1))
;-> (0 2)
(data (first (find-rev2 '(0 2) data)))
;-> (0 2)


----------------------------
eval, eval-string, read-expr
----------------------------

Supponiamo di voler permettere ad un utente di effettuare le quattro operazioni in una mini-REPL.
Per valutare l'input dell'utente è necessario convertire la stringa in un'operazione, qualcosa del tipo:

(define (mini-repl)
  (print "Enter the 1st number: ")
  (set 'num1 (int (read-line)))
  (print "Enter the 2nd number: ")
  (set 'num2 (int (read-line)))
  (print "Enter an operator [+ - * /]: ")
  (set 'op (eval-string (read-line)))
  (set 'result (op num1 num2))
  (println result)
  (mini-repl))

(mini-repl)
;-> Enter the 1st number: 2
;-> Enter the 2nd number: 3
;-> Enter an operator [+ - * /]: *
;-> 6
;-> Enter the 1st number:
;-> ...

L'espressione (set 'op (eval-string (read-line))) potrebbe essere scritta anche nel modo seguente:

(set 'op (eval (sym (read-line))))

newLISP ha non una, ma due funzioni "eval". La prima, "eval", accetta un'espressione e la valuta:

(set 'expr '(+ 1 2))
(eval expr)
;-> 3

La seconda, "eval-string", accetta una stringa e la valuta:

(set 'expr "(+ 1 2)")
(eval-string expr)
;-> 3

La parte centrale della funzione è:

(op num1 num2)

op è ovviamente un simbolo.

Dobbiamo assicurarci che questo simbolo venga valutato in una funzione per operare correttamente. In questo caso viene costruito dalla funzione primitiva per la moltiplicazione "*". "*" di per sé non è una primitiva, è il simbolo che valuta in una primitiva (in modo simile dopo (set 'f (lambda(x) x)), f è un simbolo che valuta/restituisce la lambda-list.)

È necessario definire op nello stesso modo che "*" valuta nella primitiva di moltiplicazione. Non al simbolo *.
Possiamo farlo in diversi modi, il modo più semplice:

(set 'op *)
(setq op *)

che equivale a:

(set 'op (eval '*)) ;

che equivale a:

(set 'op (eval (sym "*")));

che equivale a:

(set 'op (eval-string "*"))

ma (set 'op '*) non funziona, perchè imposta il valore di op su SYMBOL *.

Infine, c'è una terza funzione di valutazione che vale la pena menzionare:
"read-expr" che prende una stringa e la traduce in un'espressione:

(read-expr "(+ 3 4)")
;-> (+ 3 4)
(eval (read-expr "(+ 3 4)"))
;-> 7

"eval-string" è una combinazione di "read-expr" e "eval".


--------------------
newLISP from newLISP
--------------------

Senza parole...

(exec "newlisp -e \"(+ 1 2)\"")
;-> ("3")
(char "\"")
;-> 34
(setq expr "(+ 1 2)")
(exec (string "newlisp -e " (char 34) expr (char 34)))
;-> ("3")


---------------------------
Valutazione di una funzione
---------------------------

Una funzione/programma deve essere progettata, scritta e valutata tenendo conto delle seguenti caratteristiche:

0) correttezza del programma
1) velocità di esecuzione
2) spazio di memoria
3) chiarezza ed eleganza della soluzione (algoritmo)
4) facilità di scrittura
5) facilità di lettura
6) facilità di debug
7) documentazione/manuale

Ovviamente, la caratteristica fondamentale è la correttezza della funzione (che deve essere sempre presente), mentre le altre dipendono da diversi fattori del contesto in cui operiamo.

In genere non è possibile avere tutte le caratteristiche in ogni programma ed è un peccato quando dobbiamo sacrificarne una per migliorarne altre (esempio, la leggibilità e l'eleganza per la velocità), ma spesso occorre farlo (anche con newLISP è necessario farlo a volte...).

Per capire quali caratteristiche sono più importanti per una dato programma/funzione possiamo porci alcune domande (elencate in ordine sparso):

1) il programma deve essere mantenuto per lungo tempo?
2) il programma deve essere modificato da altri programmatori?
3) la velocità di esecuzione è accettabile?
4) l'algoritmo di soluzione è implementato in modo chiaro?
5) l'algoritmo di soluzione è implementato in modo elegante?
6) lo spazio di memoria utilizzato è accettabile?
7) la documentazione è esaustiva?
8) Possiamo migliorare una caratteristica senza intaccare le altre?

Nota: i bravi programmatori riescono a soddisfare la maggior parte delle caratteristiche elencate.


---------------------
Metodi di Monte Carlo
---------------------

I metodi Monte Carlo, sono una classe di algoritmi computazionali che si basano sul campionamento casuale ripetuto di eventi per ottenere un risultato numerico. Il concetto di base è quello di usare la casualità per risolvere problemi che pur essendo deterministici in linea di principio, non siamo in grado di risolvere analiticamente. Sono spesso utilizzati in problemi fisici e matematici e sono più utili quando è difficile o impossibile utilizzare altri approcci. I metodi Monte Carlo sono utilizzati principalmente in tre classi di problemi: ottimizzazione, integrazione numerica e calcolo delle probabilità.

Questo metodo è stato formalizzato da Enrico Fermi, John von Neumann e Stanislaw Ulam nel 1945 nell'ambito del Progetto Manhattan. Il nome Monte Carlo fu inventato in seguito da Nicholas Metropolis riferendosi al noto casinò.

In modo naif possiamo pensare che i metodi di MonteCarlo siano la soluzione del seguente dilemma:

1. Non importa quanto tu sia intelligente, ci saranno sempre problemi di calcolo delle probabilità che risultano "troppo difficili" da risolvere analiticamente.

2. Nonostante (1), se conosci un (buon) linguaggio di programmazione che incorpora un (buon) generatore di numeri casuali, potresti ancora essere in grado di ottenere risposte numeriche a quei problemi "troppo difficili".

Per utilizzare il metodo di Monte Carlo occorre definire e codificare un algoritmo che effettua la simulazione.
Questa simulazione utilizza una serie di parametri per calcolare una serie di eventi possibili del fenomeno in esame, ognuno con il proprio peso di probabilità, cercando di esplorare in modo più completo possibile tutto lo spazio del fenomeno. Una volta calcolato questo campione casuale, si eseguono delle misure delle grandezze di interesse su di esso. La simulazione Monte Carlo è eseguita correttamente se il valore medio di queste misure sul campione casuale converge al valore vero.

Vediamo un semplice esempio:

Un missile ha probabilità 1/3 di colpire il bersaglio. Quanti missili occorre lanciare per essere sicuri di colpire un bersaglio prestabilito? (I lanci sono eventi indipendenti tra loro)

La risposta (errata) è 3. Infatti, se lanciamo 3 missili la probabilità di colpire il bersaglio vale: 1/3 + 1/3 + 1/3 = 1. Con tre missili abbiamo il 100% di sicurezza di colpire il bersaglio.

Per scoprire se questo ragionamento è corretto o meno possiamo percorrere due strade:

1) soluzione analitica del problema
2) simulazione del problema tramite un algoritmo

Scriviamo prima la funzione di simulazione (con il numero di missili lanciati come parametro):

(define (shot n iter)
  ; n = numero di colpi lanciati per ogni evento simulato
  ; iter = numero di eventi da simulare
  (let ((conta 0) (res 0))
    ; conta = numero di eventi positivi (bersaglio colpito)
    ; res = risultato di un evento (0,1,2)
    ; ripetiamo l'evento iter volte...
    (for (i 1 iter)
      (setq res 0)
      ; evento: spariamo il missile n volte...
      (for (i 1 n)
        ; se esce il numero 0, allora abbiamo colpito il bersaglio
        (if (zero? (rand 3)) (++ res))
      )
      ; se colpito il bersaglio, allora aumentiamo il contatore
      (if (> res 0) (++ conta))
    )
    ; restituisce la probabilità di colpire il bersaglio con n missili
    (div conta iter)))

Proviamo la funzione con valori crescenti di iterazioni:

(shot 3 1000)
;-> 0.704
(shot 3 100000)
;-> 0.70266
(shot 3 10000000)
;-> 0.703621

Adesso vediamo la soluzione analitica.
L'errore del ragionamento è che le probabilità 1/3 non possono essere sommate. Dobbiamo ragionare sulla probabilità che il bersaglio NON venga colpito, poichè in questo modo le probabilità risultanti possono essere moltiplicate tra loro per ottenere la soluzione.
La probabilità che un missile non colpisca il bersaglio vale: 1 - 1/3 = 2/3.
Quindi la probabilità che 3 missili non colpiscano il bersaglio vale: 2/3 * 2/3 * 2/3 = 8/27.
Di conseguenza la probabilità che 3 missili colpiscano il bersaglio vale: 1 - 8/27 = 19/27.
Calcoliamo il valore numerico di 19/27:

(div 19 27)
;-> 0.7037037037037037

Come si vede i risultati della simulazione convergono verso i risultati analitici (aumentando il numero di iterazioni del processo).

Nota: se il problema è complesso, allora la simulazione è spesso l'unica strada percorribile.

Nota: il metodo di Monte Carlo è utile anche per verificare un'eventuale soluzione analitica del problema e viceversa (dipende se ci fidiamo di più delle nostre capacità matematiche o di quelle di programmatore).

Vediamo un altro esempio da un problema del 1708 dal libro "Essay d’analyse sur les jeux de hazard" (Analisi dei giochi d'azzardo) del matematico francese Pierre Remond de Montmort (1678–1719). Nel libro Montmort descrive il seguente processo:
dato un mazzo coperto e mischiato di carte numerate da 1 a 13, estrarre una carta alla volta e indicare l'ordine dalla carta (1, 2, 3, ... fino a 13).
Se ripetiamo questo processo tante volte, quante carte, in media, qual'è la probabilità che nessuna carta abbia lo stesso valore del relativo numero ordinale di estrazione?
In altre parole, qual'è la probabilità che nessuna delle k carte estratte abbia valore k ?
Montmort discute una versione generalizzata di questo problema nella sua corrispondenza con Nicholas Bernoulli (1687-1759) in cui si estraggono N carte (contando da 1 a N) da un mazzo di N carte.

Vediamo di scrivere una simulazione per questo processo con N carte.

(define (montmort num iter)
  (local (uguali out)
    ; mazzo di carte da 1 a N
    (setq mazzo (sequence 1 num))
    ; vettore di output:
    ; i-esimo indice = numero totale di eventi con "i" successi
    (setq out (array (+ num 1) '(0)))
    ; ripetiamo l'evento iter volte...
    (for (i 1 iter)
      ; mischia il mazzo
      (setq nuovo (randomize mazzo true))
      ;(println nuovo)
      ;(read-line)
      ; numero di carte uguali
      (setq uguali 0)
      ; conteggio degli accoppiamenti favorevoli
      (dolist (el nuovo)
        (if (= el (+ 1 $idx))
            (++ uguali)
        )
      )
      ; aggiornamento del vettore di output:
      ; aumenta di 1 il valore che all'indice "uguali"
      (++ (out uguali))
    )
    out))

Se non abbiamo una soluzione analitica con cui confrontare il risultato della simulazione, dobbiamo "testare" la nostra funzione con dei valori limite per verificare la sua correttezza. Ad esempio, in questo caso se utilizziamo un mazzo con 1 carta e 1000 iterazioni dovremmo ottenere il risultato (0 1000), cioè zero (0) eventi in cui non ci sono accoppiamenti e 1000 eventi con un (1) accoppiamento (cioè per 1000 volte estraiamo la prima carta che vale 1):

(montmort 1 1000)
;-> (0 1000)

Con 2 carte e 1000 iterazioni otteniamo:

(montmort 2 1000)
;-> (495 0 505)

che è corretto, perchè con un mazzo di 2 carte possiamo ottenere o zero accoppiamenti (495 volte) o due accoppiamenti (505 volte). Non è possibile ottenere un solo accoppiamento.

Con 3 carte e 1000 iterazioni:

(montmort 3 1000)
;-> (309 514 0 177)

In questo caso non è possibile ottenere due accoppiamenti con tre carte, infatti il valore che ha indice 2 vale 0.

Un altro controllo, la somma di tutti gli eventi deve essere uguale al numero di iterazioni:

(apply + (montmort 10 100))
;-> 100
(apply + (montmort 13 1000))
;-> 1000

La funzione sembra corretta, allora proviamola con altri valori:

(montmort 13 1000000)
;-> (367758 367669 184120 61535 15147 3111 569 82 9 0 0 0 0 0)

(montmort 40 1000000)
;-> (368102 368228 183133 61533 15314 3074 536 70 8 1 1 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)

(montmort 100 1000000)
;-> (368497 366961 183994 61410 15428 3119 504 71 15 1 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)

Da questi risultati sembra che il numero di accoppiamenti sia indipendente dal numero di carte contenute nel mazzo.

Dal punto di vista analitico risulta che la probabilità di nessun accoppiamento (cioè nessuna corrispondenza) è approssimativamente 1/e per n grande (dove "e" è il numero di Eulero). Calcoliamo questo valore:

(setq e 2.7182818284590451)
(div e)
;-> 0.3678794411714423

Quindi anche questa volta la simulazione converge al risultato analitico.

Nota: la convergenza della soluzione simulata verso la soluzione analitica aumenta con l'aumentare delle simulazioni effettuate (cioè con l'aumentare del numero di iterazioni).

Consideriamo ora il seguente problema, originariamente presentato nel 1955 dalla rivista "The American Mathematical Monthly".
Disegnando un triangolo casuale all'interno di un rettangolo arbitrario, qual è la probabilità che il triangolo sia ottuso?
Si tratta di un problema di "probabilità geometrica", cioè quella classe di problemi in cui le probabilità sono associate alle lunghezze, aree, e volumi delle varie figure geometriche (l'esempio classico è il problema dell'ago di Buffon). Questo problema è facile da capire, ma non così facile da analizzare teoricamente, infatti non è stato risolto analiticamente fino al 1970.

Per iniziare, supponiamo di disegnare il nostro rettangolo in modo che uno dei lati più corti giace sull'asse x positivo, cioè 0 ≤ x ≤ X, mentre uno dei lati più lunghi giace sull'asse y positivo, cioè 0 ≤ y ≤ Y. Cioè, abbiamo un rettangolo con dimensioni X per Y. Adesso applichiamo il principio di "invarianza di scala" il che significa che se scaliamo sia X che Y verso l'alto (o verso il basso) dello stesso fattore, la soluzione non cambierà. Quindi, non perdiamo alcuna generalità prendendo il valore effettivo di X e scalandolo verso l'alto (o verso il basso) a 1, e quindi ridimensionando Y dello stesso fattore. Poniamo che scalando Y in questo modo arriviamo a L, cioè, il nostro nuovo rettangolo ridimensionato è 1 per L. Poichè abbiamo assunto Y ≥ X, allora L ≥ 1. Se L = 1, ad esempio, il nostro rettangolo è in realtà un quadrato. Disegnare un triangolo "a caso" in questo rettangolo significa semplicemente scegliere tre punti indipendenti (x1, y1), (x2, y2) e (x3, y3) come essere i vertici del triangolo tali che gli x(i) sono ciascuno selezionato da una distribuzione uniforme nell'intervallo (0,1) e y(i) sono selezionati ciascuno da una distribuzione uniforme nell'intervallo (0,L).

Affinchè un triangolo sia ottuso è necessario e sufficiente che abbia un angolo interno maggiore di 90 gradi (ovviamente solo uno dei tre angoli interni di un triangolo può essere maggiore di 90 gradi). Conoscendo le coordinate dei vertici del triangolo come possiamo determinare se è ottuso?
Indichiamo i tre angoli interni di un triangolo con A, B, e C e le lunghezze dei lati opposti a quegli angoli con a, b e c. Poi utilizziamo la "legge dei coseni" e otteniamo:

  a² = b² + c² − 2bc cos(A)
  b² = a² + c² − 2ac cos(B)
  c² = a² + b² − 2ab cos(C)

Estrapolando i coseni:

  cos(A) = (b² + c² − a²)/2bc
  cos(B) = (a² + c² − b²)/2ac
  cos(C) = (a² + b² − c²)/2ab

Poiché il coseno di un angolo acuto, cioè un angolo nell'intervallo (0..90°), è positivo, mentre il coseno di un angolo nell'intervallo (90°..180°) è negativo, abbiamo il seguente test per verificare se un angolo è ottuso: la somma dei quadrati delle lunghezze dei lati che formano quell'angolo, meno il quadrato della lunghezza del lato opposto a quell'angolo, deve essere negativo. Per calcolare questo è sufficiente calcolare i numeratori delle espressioni precedenti. In altre parole, un triangolo per essere acuto (cioè non ottuso) deve avere i coseni degli angoli interni tutti positivi. Con queste informazioni possiamo scrivere la funzione di simulazione.

(define (obtuse lato iter)
  (local (x1 y1 x2 y2 x3 y3 a b c test res)
    (setq res 0)
    (for (k 1 iter)
      (setq test 0)
      ; crea tre punti casuali (x(i), y(i))
      (setq x1 (random)) (setq y1 (mul lato (random)))
      (setq x2 (random)) (setq y2 (mul lato (random)))
      (setq x3 (random)) (setq y3 (mul lato (random)))
      ; calcola a², b² e c²
      (setq a (add (mul (sub x1 x2) (sub x1 x2))
                        (mul (sub y1 y2) (sub y1 y2))))
      (setq b (add (mul (sub x2 x3) (sub x2 x3))
                        (mul (sub y2 y3) (sub y2 y3))))
      (setq c (add (mul (sub x3 x1) (sub x3 x1))
                        (mul (sub y3 y1) (sub y3 y1))))
      ; verifica se il triangolo è ottuso o acuto
      (if (and (< a (add b c))
               (< b (add a c))
               (< c (add a b)))
          (setq test 0)
          (setq test 1)
      )
      ; aggiorna il risultato (numero di eventi positivi)
      (setq res (+ res test))
    )
    (div res iter)))

Facciamo alcune simulazioni:

(obtuse 1 100000)
;-> 0.726

(obtuse 1 1000000)
;-> 0.725145

(obtuse 2 100000)
;-> 0.7974

(obtuse 2 1000000)
;-> 0.7983

La soluzione analitica (per tutti i valori di L>=1) è stata pubblicata da Eric Langford nell'articolo "A Problem in Geometric Probability" (Mathematics Magazine, November–December 1970, pp. 237–244).
La formula finale è complicata e lunga, ma i risultati per L=1 e L=2 valgono:

P(1) = 97/150 + π/40 = 0.72520648...

P(2) = 1199/1200 + 13π/128 - (3/4)ln(2) = 0.79837429...

Quindi anche questa simulazione converge verso il risultato analitico.

Numero di iterazioni
--------------------
L'analisi matematica della tecnica Monte Carlo mostra che l'errore del metodo diminuisce come N^(-1/2), dove N è il numero di simulazioni. Quindi, passando da N = 100 = 10^2 a N = 10000 = 10^4 (un aumento di N di un fattore 10^2) si dovrebbe ridurre l'errore di un fattore di circa sqrt(10^2) = 10).
Quindi più simulazioni facciamo, migliore sarà il risultato (cioè, il risultato delle simulazioni sarà più vicino al risultato analitico). Possiamo vedere un esempio di questo concetto con l'algoritmo di Monte Carlo per calcolare pi greco "π" (che è il rapporto tra la circonferenza di un cerchio e il suo diametro).

Algoritmo di Monte Carlo per il calcolo approssiamto di π:

1) Definire un piano cartesiano (con coordinate x,y) con l'asse x da -1 a 1 e l'asse y da -1 a 1 (si tratta di un quadrato 2x2).
2) Generare N punti casuali interni al quadrato.
3) Contare il numero di punti (A) che hanno una distanza minore/uguale a 1 dall'origine (0,0) (cioè sono interni al cerchio di raggio 1 e origine in (0,0)).
4) Calcolare il valore approssimato di pi greco con la seguente formula:

   π*r²     A
  ------ ≈ ---
   4*r²     N

Nota: questa formula, π ≈ (4*A)/N, approssima pi greco perchè il rapporto tra l'area di un cerchio e l'area dei bordi rettangolari dovrebbe essere uguale al rapporto tra i punti interni al cerchio e quelli esterni al cerchio.

Nota: la seguente funzione utilizza solo un quadrante (0,1) del quadrato 2x2 per semplificare i calcoli.

(define (pigreco iter)
  (local (x y a)
    (setq pi 3.1415926535897931)
    (setq a 0)
    (for (i 1 iter)
      (setq x (random))
      (setq y (random))
      (if (<= (add (mul x x) (mul y y)) 1)
          (++ a)
      )
    )
    (setq res (div (mul 4 a) iter))
    (list res (sub pi res))))

Facciamo alcune simulazioni:

(pigreco 100000)
;-> (3.13936 0.002232653589793188)
(pigreco 1000000)
;-> (3.139636 0.001956653589793245)
(pigreco 10000000)
;-> (3.141994 -0.0004013464102068376)

Quindi, più aumentano le iterazioni e migliore è la soluzione ottenuta.


-------------------
Metodi di Las Vegas
-------------------

Oltre ai metodi di Monte Carlo, esiste un'altra categoria chiamata metodi di Las Vegas. Potete trovare maggiori informazioni su tutto questo nell'articolo di Don Fallis, "The Reliability of Randomized Algorithms" (British Journal for the Philosophy of Science, giugno 2000, pp. 255-271).

Gli algoritmi di Las Vegas sono stati introdotti da Laszla Babai nel 1979, insieme ad un algoritmo di esempio che riguarda i lanci di monete: l'algoritmo dipende da una serie di lanci di monete indipendenti e c'è una piccola possibilità di fallimento (nessun risultato). Tuttavia, a differenza degli algoritmi di Monte Carlo, l'algoritmo di Las Vegas può garantire la correttezza di qualsiasi risultato ottenuto.

Un algoritmo di Las Vegas è un algoritmo casuale (random) che dà sempre risultati corretti. In altre parole, produce sempre il risultato corretto o informa sull'errore. Tuttavia, il tempo di esecuzione di un algoritmo di Las Vegas differisce a seconda dell'input. Un algoritmo di Las Vegas ha la restrizione che il tempo di esecuzione sia finito e che termini sempre (sia efficace), ma può produrre un simbolo speciale per indicare il fallimento nella ricerca di una soluzione. La natura degli algoritmi di Las Vegas li rende adatti in situazioni in cui il numero delle possibili soluzioni è limitato e dove verificare la correttezza di una soluzione candidata è relativamente facile, mentre trovare una soluzione è complesso.

Gli algoritmi di Las Vegas sono importanti nel campo dell'intelligenza artificiale e in altre aree dell'informatica e della ricerca operativa.

Esempio di algoritmo di Las Vegas:

(define (lasvegas n)
(catch
  (local (k vet conta)
    (seed (time-of-day))
    (setq conta 0)
    (setq vet (array n (randomize (sequence 1 n))))
    (while true
      (setq k (rand n))
      (++ conta)
      (if (= (vet k) 1)
          (throw (list k (vet k) conta)))
    ))))

(lasvegas 100)
;-> (24 1 11)

La funzione restituisce l'indice dell'elemento che ha valore 1, il valore del vettore con quell'indice (1), e il numero di tentativi per individuare la soluzione.
Come detto sopra, gli algoritmi di Las Vegas restituiscono sempre risultati corretti. Il codice sopra illustra questa proprietà. Una variabile k e una vettore vet vengono generati casualmente. Dopo la generazione di k, k viene utilizzato per indicizzare il vettore vet. Se questo indice contiene il valore 1, allora viene restituito k, in caso contrario, l'algoritmo ripete questo processo finché non trova 1. Sebbene sia garantito che questo algoritmo di Las Vegas trovi la risposta corretta, non ha un tempo di esecuzione fisso (a causa della funzione "rand"). Il tempo di esecuzione dipende dal numero di input "n", ma la funzione non impiega sempre lo stesso tempo con due valori di n uguali.

(time (println (lasvegas 25000)))
;-> (18737 1 53847)
;-> 10.002
(time (println (lasvegas 25000)))
;-> (22235 1 3710)
;-> 3.989
(time (println (lasvegas 25000)))
;-> (20452 1 35423)
;-> 6.982
(time (println (lasvegas 25000)))
;-> (11855 1 20172)
;-> 4.962
(time (println (lasvegas 25000)))
;-> (9200 1 79008)
;-> 12.036

Gli algoritmi di Las Vegas si presentano frequentemente nei problemi di ricerca. Ad esempio, nelle ricerche on-line si passa dall'essere "fortunati" e trovare immediatamente il sito web cercato, all'essere "sfortunati" e sprecare molto tempo nella ricerca.

Relazione con i metodi Monte Carlo
----------------------------------
Gli algoritmi di Las Vegas possono essere contrapposti agli algoritmi di Monte Carlo, in cui le risorse utilizzate sono limitate, ma la risposta può essere errata con una certa (tipicamente piccola) probabilità. Un algoritmo di Las Vegas può essere convertito in un algoritmo di Monte Carlo eseguendolo per un tempo prestabilito e generando una risposta casuale quando non riesce a terminare.
La seguente tabella confronta gli algoritmi di Las Vegas e Monte Carlo:

Algoritmo     Tempo di esecuzione    Correttezza
------------------------------------------------
Las Vegas     probabilistico         certa
Monte Carlo   certo                  probabilistica

Se è disponibile un modo deterministico per verificare la correttezza, è possibile trasformare un algoritmo Monte Carlo in un algoritmo di Las Vegas. Tuttavia, è difficile convertire un algoritmo di Monte Carlo in un algoritmo di Las Vegas senza un modo per testare l'algoritmo. Cambiare un algoritmo di Las Vegas in un algoritmo di Monte Carlo può essere fatto eseguendo un algoritmo di Las Vegas per un periodo di tempo specifico dato dal parametro di confidenza. Se l'algoritmo trova la soluzione entro il tempo, allora abbiamo trovato una soluzione, mentre in caso contrario, l'output può essere semplicemente un messaggio di fallimento.

Ad esempio, modifichiamo l'algoritmo della funzione precedente "lasvegas" per renderlo un algoritmo Monte Carlo.

(define (montecarlo n)
(catch
  (local (k vet conta idx)
    (seed (time-of-day))
    (setq conta 0)
    (setq idx 0)
    (setq vet (array n (randomize (sequence 1 n))))
    (while (< idx 500)
      (++ idx)
      (setq k (rand n))
      (++ conta)
      (if (= (vet k) 1)
          (throw (list k (vet k) conta)))
    )
    (println "not found!"))))

Proviamo la funzione:

(montecarlo 1000)
;-> not found!
(montecarlo 1000)
;-> (651 1 245)

La funzione "lasvegas" non termina fino a che non ha trovato il valore 1 nel vettore, mentre la funzione "montecarlo" termina se trova il valore 1 nel vettore oppure quando ha eseguito 500 volte la ricerca.
La funzione "lasvegas" mira alla correttezza della soluzione a scapito del tempo di esecuzione (incerto).
La funzione "montecarlo" mira ad un tempo di esecuzione certo a scapito di un certo margine di errore nel trovare la soluzione.

Nota: la funzione "amb" di newLISP sembra utile per questo tipo di algoritmi.

Algoritmi di Atlantic City
--------------------------
Gli algoritmi di Monte Carlo sono sempre veloci e probabilmente corretti, mentre gli algoritmi di Las Vegas sono a volte veloci, ma sempre corretti. C'è un altro tipo di algoritmo che si trova proprio nel mezzo dei due e cerca di unire il meglio di entrambi e si chiama algoritmo di Atlantic City: è quasi sempre veloce e quasi sempre corretto. Tuttavia, la progettazione di questi algoritmi è estremamente complessa.


-----------------------
Vincere 2 volte su 3...
-----------------------

Ci sono tre giocatori di scacchi A, B e C. Il giocatore C è il più forte dei tre.
La sfida del giocatore A consiste nel giocare tre partite di seguito alternando tra i giocatori B e C.
Il giocatore A vince la sfida se vince due partite di seguito.
Il giocatore A può scegliere con quale giocatore iniziare, cioè se giocare la sequenza B-C-B oppure la sequenza C-B-C.

Quale sequenza ha la maggiore probabilità di far vincere la sfida ad A?

Chiamiamo "p" la probabilità di vittoria di A su B
Chiamiamo "q" la probabilità di vittoria di A su C

poichè C è il giocatore più forte, allora risulta p > q.

Per vincere la sfida il giocatore A ha due possibilità:

1) vincere la prima e la seconda partita, oppure
2) vincere la seconda e la terza partita

Chiamiamo la prima sequenza S1 = B-C-B
Chiamiamo la seconda sequenza S2 = C-B-C

Chiamiamo P1 la probabilità che A vinca la sfida utilizzando la sequenza S1
Chiamiamo P2 la probabilità che A vinca la sfida utilizzando la sequenza S2

Per la sequenza S1 abbiamo: P1 = pq + (1 - p)pq
Per la sequenza S2 abbiamo: P2 = pq + (1 - q)pq

Nota: le formule per calcolare P1 e P2 valgono per qualunque valore di p e q compresi tra 0 e 1.

Calcoliamo la differenza tra le due probabilità:

  P2 - P1 = [pq + (1 - q)pq] - [pq + (1 - p)pq] =
          = (1 - q)pq - (1 - p)pq =
          = pq[(1 - q) - (1 - p)] = pq(p - q)

Poichè nel nostro caso p > q, allora risulta:

  P2 - P1 = pq(1 - q) > 0

cioè la sequenza S2 ha la maggiore probabilità di vittoria.

Il risultato è controintuitivo perchè con la sequenza S2 il giocatore A sfida il giocatore più forte C per ben due volte.

Scriviamo una funzione che calcola il risultato teorico:

(define (teoria p q)
  (list (add (mul p q) (mul (sub 1 p) p q))
        (add (mul p q) (mul (sub 1 q) p q))))

Facciamo alcune prove:

(teoria 0.9 0.8)
;-> (0.792 0.864)
(teoria 0.9 0.4)
;-> (0.396 0.576)
(teoria 0.4 0.3)
;-> (0.192 0.204)
(teoria 0.5 0.1)
;-> (0.075 0.095)
(teoria 0.4 0.6)
;-> (0.384 0.336)
(teoria 0.5 0.3)
;-> (0.225 0.255)

Adesso scriviamo una funzione per simulare questo processo.

(define (chess p q iter)
  (local (s1w s2w g1 g2 g3)
    (set 's1w 0 's2w 0)
    (for (i 1 iter)
      ; play S1 sequence B-C-B
      ; game1 A vs B
      (setq g1 (>= p (random)))
      ; game2 A vs C
      (setq g2 (>= q (random)))
      ; game3 A vs B
      (setq g3 (>= p (random)))
      ; check result of sequence S1
      (if (or (and g1 g2) (and g2 g3))
          (++ s1w)
      )
      ; play S2 sequence C-B-C
      ; game1 A vs C
      (setq g1 (>= q (random)))
      ; game2 A vs B
      (setq g2 (>= p (random)))
      ; game3 A vs C
      (setq g3 (>= q (random)))
      ; check result of sequence S1
      (if (or (and g1 g2) (and g2 g3))
          (++ s2w)
      )
    )
    ; probability of S1 and S2
    (list (div s1w iter) (div s2w iter))))

Proviamo la simulazione con gli stessi valori precedenti per verificare la correttezza:

(chess 0.9 0.8 100000)
;-> (0.791623 0.86277)
Valore teorico: (0.792 0.864)

(chess 0.9 0.4 100000)
;-> (0.39542 0.57534)
Valore teorico: (0.396 0.576)

(chess 0.4 0.3 100000)
;-> (0.19117 0.20427)
Valore teorico: (0.192 0.204)

(chess 0.5 0.1 100000)
;-> (0.075501 0.09506)
Valore teorico: (0.075 0.095)

(chess 0.4 0.6 100000)
;-> (0.38347 0.33727)
Valore teorico: (0.384 0.336)

(chess 0.5 0.3 100000)
;-> (0.22461 0.25452)
Valore teorico: (0.225 0.255)

Anche la simulazione ha confermato che la sequenza S2 è quella che ha la maggiore probabilità, quindi il giocatore A deve sfidare due volte il giocatore più forte (C-B-C).


--------
Ombrelli
--------

Eva ogni giorno parte da casa e raggiunge a piedi l'ufficio di lavoro.
Alla fine della giornata parte dall'ufficio e torna a casa a piedi.
Quando piove prende un ombrello (se disponibile) dal punto di partenza (casa o ufficio) e lo lascia nel punto di arrivo (ufficio o casa). Non prende mai l'ombrello quando non piove.
Inizialmente a casa possiede N ombrelli e in ufficio M ombrelli.
Supponiamo che ogni giorno p sia la probabilità che piova e (1 - p) la probabilità che non piova.
Domanda: quanti giorni passeranno, in media, prima che Eva si bagni? (cioè quanti giorni viaggia senza bagnarsi?)

(define (drywalk n m p iter)
  (local (continue k dry nn mm)
    (setq dry 0)
    (for (i 1 iter)
      (setq continue true)
      (setq k 1)
      (setq nn n)
      (setq mm m)
      ; ciclo fino a che non si bagna...
      (while continue
        ; se piove...
        (if (>= p (random))
            (cond ((odd? k) ; giorno dispari: casa -> ufficio
                   ;(println "giorno: " k )
                   (-- nn)
                   (++ mm)
                   ;(println "ombrelli: " nn { } mm)
                   (if (= nn -1) (setq continue nil))
                  )
                  (true ; giorno pari: ufficio -> casa
                   ;(println "giorno: " k )
                   (-- mm)
                   (++ nn)
                   ;(println "ombrelli: " nn { } mm)
                   (if (= mm -1) (setq continue nil))
                  )
            )
            ;(println "giorno non piove: " k { } p)
        )
        ; nuovo giorno
        (++ k)
      )
      (setq dry (+ dry (- k 1)))
      ;(setq dry (+ dry k))
      ;(println "iterazione: " i)
      ;(println (- k 1) { } dry)
      ;(read-line)
    )
    (div dry iter)))

Quando p = 1 (piove tutti i giorni) Eva non rimane mai senza ombrello:

(drywalk 1 1 1 10)
Premi Ctrl-C per bloccare il ciclo infinito...

Quando p = 0 (non piove mai) Eva non rimane mai senza ombrello:

(drywalk 1 1 0 10)
Premi Ctrl-C per bloccare il ciclo infinito...

Quando p = 0.5 Eva si bagna (cioè rimane senza ombrello) dopo, in media, 12 giorni:

(drywalk 1 1 0.5 100000)
;-> 12.01733

Adesso scriviamo una funzione che effettua questa simulazione con p che varia:
  da p-step a (p-step - 1) con incremento di p-step

(define (ombrelli a b p-step iter)
  (let (out '())
    (for (i p-step (sub 1 p-step) p-step)
      (push (list i (drywalk a b i iter)) out -1)
    )
    out))

Generiamo due liste di coppie (probabilità, giorni) una con n=1 e m=1 e l'altra con n=2 e m=2:

(setq punti (ombrelli 1 1 0.02 10000))
(setq punti2 (ombrelli 2 2 0.02 10000))

E poi le esportiamo in formato csv:

(define (list-csv lst file-str sepchar)
"Creates a file csv from a list"
  (local (outfile)
    (if (nil? sepchar)
        (setq sepchar ",")
    )
    (setq outfile (open file-str "write"))
    (dolist (el lst)
      (setq line (join (map string el) sepchar))
      (write-line outfile line)
    )
    (close outfile)))

(list-csv punti "umbrella.csv" ",")
;-> true
(list-csv punti2 "umbrella2.csv" ",")
;-> true

Con i file esportati possiamo creare un grafico utilizzando un foglio elettronico.
Potete vedere i risultati (due grafici a forma di "U") nell'immagine "ombrelli.png" nella cartella "data".


---------------
Duello continuo
---------------

Ci sono N persone disposte in modo equidistante lungo una circonferenza. Ad ogni turno ogni persona "spara" ad un'altra persona a caso (tranne che a se stesso). Tutti gli spari di ogni turno avvengono simultaneamente (es. se 1 spara a 3 e 3 spara a 1, allora muoiono entrambi). Non è possibile sparare ad una persona morta. Il duello continua fino a che non rimane soltanto una o nessuna persona viva.
In media, quanto turni dura ogni duello?
In media, rimane di più una persona o zero persone al termine del duello?
Come cambiano i risultati se ogni persona può sparare anche a se stessa?

Prima scriviamo la funzione "spara" che prende una persona e una lista di persone e restituisce a chi ha sparato la persona:

(define (spara x lst)
  (let (s (rand (length lst)))
       (if (= x (lst s)) ; la persona non può sparare a se stessa
           (spara x lst)
           (lst s))))

Facciamo una prova sulla correttezza della funzione:

(setq mm '(1 2 3 4 5 6 7 8 9))
(spara 1 mm)
(setq ff (array 10 '(0)))
(for (i 1 1000000)
  (for (j 1 9)
    (++ (ff (spara j mm)))
  ))
ff
;-> (0 999495 999518 1000714 999219 999376 1000509 1000503 1001101 999565)

Adesso scriviamo la funzione di simulazione:
(define (duello num iter)
  (local (men spari step total zero uno out)
    (setq total 0)
    (setq uno 0)
    (setq zero 0)
    (for (i 1 iter)
      (setq men (sequence 1 num))
      (setq step 0)
      (while (> (length men) 1)
        (setq spari '())
        ; crea la lista delle persone "sparate"
        (dolist (el men)
          (push (spara el men) spari)
        )
        ;(println men { } spari)
        ; elimina le persone "sparate" dalla lista delle persone
        (setq men (difference men spari))
        (++ step)
        ;(println step { } men)
        ;(read-line)
      )
      ; aggiorna i valori da restituire
      (if (= men '()) (++ zero) (++ uno))
      (setq total (+ total step))
      ;(println "total: " total)
      ;(read-line)
    )
    ; (durata media dei duelli, % duelli zero persone, % duelli una persona)
    (list (div total iter) (div zero iter) (div uno iter) (+ zero uno))))

Proviamo la simulazione iniziando con 10 persone e 10000 iterazioni (duelli):

(duello 10 1000)
;-> (2.161 0.421 0.579 1000)
(duello 10 10000)
;-> (2.1648 0.4393 0.5607 10000)

(duello 100 1000)
;-> (4.447 0.489 0.511 1000)
(duello 100 10000)
;-> (4.4311 0.484 0.516 10000)

(duello 1000 100)
;-> (6.75 0.49 0.51 100)
(duello 1000 1000)
;-> (6.75 0.528 0.472 1000)
(duello 1000 10000) ; un paio di minuti di attesa...
;-> (6.7484 0.5206 0.4794 10000)

Adesso vediamo il caso in cui ogni persona può sparare anche a se stessa. In questo caso basta cambiare la funzione "spara":

(define (spara x lst) (lst (rand (length lst))))

Facciamo una prova sulla correttezza della funzione:

(setq mm '(1 2 3 4 5 6 7 8 9))
(spara 1 mm)
(setq ff (array 10 '(0)))
(for (i 1 1000000)
  (for (j 1 9)
    (++ (ff (spara j mm)))
  ))
ff
;-> (0 1000651 999271 999863 998948 999620 1000890 1000994 999965 999798)

Facciamo alcune simulazioni:

(duello 10 1000)
;-> (2.209 0.294 0.706 1000)
(duello 10 10000)
;-> (2.2284 0.3037 0.6963 10000)

(duello 100 1000)
;-> (4.473 0.317 0.683 1000)
(duello 100 10000)
;-> (4.49 0.3074 0.6926 10000)

(duello 1000 100)
;-> (6.76 0.26 0.74 100)
(duello 1000 1000)
;-> (6.825 0.323 0.677 1000)
(duello 1000 10000) ; un paio di minuti di attesa...
(time (println (duello 1000 10000)))
;-> (6.8181 0.3286 0.6714 10000)
;-> 121776.85

(duello 10000 10)
;-> (9 0.2 0.8 10)
(duello 10000 100)
;-> (9.09 0.34 0.66 100)
(time (println (duello 10000 1000)))
;-> (9.124 0.289 0.711 1000)
;-> 3199524.038 ; circa 53 minuti


----------
Cucciolata
----------

Un cane ha un parto di quattro cuccioli.
Qual'è la probabilità che siano due maschi e due femmine?

Gli eventi della cucciolata possono essere i seguenti:

  0 maschi 4 femmine
  1 maschi 3 femmine
  2 maschi 2 femmine
  3 maschi 1 femmine
  4 maschi 0 femmine

Quindi scriviamo la funzione di simulazione:

(define (cuccioli iter)
  (local (c res out)
    (setq out '((0 (0 4)) (0 (1 3)) (0 (2 2)) (0 (3 1)) (0 (4 0))))
    (for (i 1 iter)
      (setq c (rand 2 4))
      (setq res (count '(0 1) c))
      (cond ((= res '(0 4)) (++ (out 0 0)))
            ((= res '(1 3)) (++ (out 1 0)))
            ((= res '(2 2)) (++ (out 2 0)))
            ((= res '(3 1)) (++ (out 3 0)))
            ((= res '(4 0)) (++ (out 4 0)))
            (true (println "error:" res))
      )
    )
    (println out)
    (for (i 0 3)
      (setf (out i 0) (div (out i 0) iter))
    )
    out))

(cuccioli 10000)
;-> ((649 (0 4)) (2470 (1 3)) (3768 (2 2)) (2518 (3 1)) (595 (4 0)))
;-> ((0.0649 (0 4)) (0.247 (1 3)) (0.3768 (2 2)) (0.2518 (3 1)) (595 (4 0)))

Siamo sicuri di questo risultato?
Possiamo verificarlo analiticamente considerando tutti gli eventi possibili.
Gli eventi della cucciolata possono anche essere visti come le sequenza possibili del parto di quattro cuccioli:

 1) 0 0 0 0    femmina femmina femmina femmina   (0 4)
 2) 0 0 0 1    femmina femmina femmina maschio   (1 3)
 3) 0 0 1 0    femmina femmina maschio femmina   (1 3)
 4) 0 0 1 1    femmina femmina maschio maschio   (2 2)
 5) 0 1 0 0    femmina maschio femmina femmina   (1 3)
 6) 0 1 0 1    femmina maschio femmina maschio   (2 2)
 7) 0 1 1 0    femmina maschio maschio femmina   (2 2)
 8) 0 1 1 1    femmina maschio maschio maschio   (3 1)
 9) 1 0 0 0    maschio femmina femmina femmina   (1 3)
10) 1 0 0 1    maschio femmina femmina maschio   (2 2)
11) 1 0 1 0    maschio femmina maschio femmina   (2 2)
12) 1 0 1 1    maschio femmina maschio maschio   (3 1)
13) 1 1 0 0    maschio maschio femmina femmina   (2 2)
14) 1 1 0 1    maschio maschio femmina maschio   (3 1)
15) 1 1 1 0    maschio maschio maschio femmina   (3 1)
16) 1 1 1 1    maschio maschio maschio maschio   (4 0)

Come si vede questa volta gli eventi sono 16, mentre prima erano 5:

1) 0 maschi 4 femmine
2) 1 maschi 3 femmine
3) 2 maschi 2 femmine
4) 3 maschi 1 femmine
5) 4 maschi 0 femmine

In questo caso possiamo calcolare direttamente probabilità di ognuno dei 5 eventi:

1) (0 4) ha 1 su 16 probabilità
2) (1 3) ha 4 su 16 probabilità
3) (2 2) ha 6 su 16 probabilità
4) (3 1) ha 4 su 16 probabilità
5) (4 0) ha 1 su 16 probabilità

Calcoliamo i valori:

(div 1 16)
;-> 0.0625
(div 4 16)
;-> 0.25
(div 6 16)
;-> 0.375

Proviamo un'altra simulazione con 1 milione di iterazioni:

(cuccioli 1e6)
;-> ((62811 (0 4)) (250088 (1 3)) (373855 (2 2)) (250736 (3 1)) (62510 (4 0)))
;-> ((0.062811 (0 4)) (0.250088 (1 3)) (0.373855 (2 2))
;->  (0.250736 (3 1)) (0.062510 (4 0)))

In generale, se ci sono n nascite, con la probabilità p che sia femmina (e quindi con la probabilità (1 - p) che sia maschio), allora la probabilità di k femmine e (n - k) maschi è data da:

  (binom n k) * (1-p)^(n-k) * p^k


-----------------------------------------------------------------------
Cancellare/modificare gli elementi di una lista mentre la si attraversa
-----------------------------------------------------------------------

Quando attraversiamo una lista (per esempio con "dolist") possiamo modificare o addirittura eliminare gli elementi della lista stessa. Per esempio:

(setq data '(1 2 3 4 5))

(define (del lst)
  (dolist (el lst)
        (println el)
        (println "prima: " lst)
        (pop lst)
        (println "dopo: " lst)
  )
  (push 111 lst)
  lst)

(del data)
;-> 1
;-> prima: (1 2 3 4 5)
;-> dopo: (2 3 4 5)
;-> 2
;-> prima: (2 3 4 5)
;-> dopo: (3 4 5)
;-> 3
;-> prima: (3 4 5)
;-> dopo: (4 5)
;-> 4
;-> prima: (4 5)
;-> dopo: (5)
;-> 5
;-> prima: (5)
;-> dopo: ()

Questo è possibile perchè "dolist" opera su una copia di "lst".

Naturalmente la lista "data" non viene modificata, perchè viene passata solo una sua copia alla funzione "del".

data
;-> (1 2 3 4 5)

Per modificare la lista "data" avremmo dovuto scrivere:

(setq data (del data))
data
;-> ()

È possibile anche aggiungere elementi alla lista (ad esempio con "push").

Possiamo passare la lista per riferimento (call by-reference):

(define (update lst)
  (dolist (el lst)
        (setf (lst $idx) (+ el 1))
  )
  lst)

(setq a:a '(1 2 3))
(update a:a)
;-> (2 3 4)
(context? a)
;-> true
a:a
;-> (2 3 4)


--------------------------
Punto interno ad una sfera
--------------------------

Data una sfera con centro di coordinate (cx, cy, cz) e di raggio r, determinare se un generico punto (x, y, z) si trova all'interno, all'esterno o sulla superficie della sfera.

Se un punto si trova all'interno di una sfera o no, dipende dalla sua distanza dal centro della sfera e dal raggio r.

Nel nostro caso:
1) il punto è interno alla sfera se

  (x - cx)^2 + (y - cy)^2 + (z - cz)^2 < r^2

2) il punto giace sulla superficie della sfera se:

  (x - cx)^2 + (y - cy)^2 + (z - cz)^2 = r^2

3) il punto è esterno alla sfera se:

  (x - cx)^2 + (y - cy)^2 + (z - cz)^2 > r^2

Poichè vogliamo sapere solo se il punto è interno/esterno/tangente alla sfera, allora calcoliamo la distanza al quadrato (quiesto per evitare di effettuare la radice quadrata):

(define (dist3d-2 x1 y1 z1 x2 y2 z2)
"Calculates the square of 3D Cartesian distance of two points P1=(x1 y1 z1) e P2=(x2 y2 z2)"
  (add (mul (sub x1 x2) (sub x1 x2))
       (mul (sub y1 y2) (sub y1 y2))
       (mul (sub z1 z2) (sub z1 z2))))

Nota: Per calcolare il quadrato di un numero è più veloce la moltiplicazione "mul" che l'elevazione a potenza "pow":

(define (a x) (mul x x))
(define (b x) (pow x 2))

(time (a 123456789123456789) 10000000)
;-> 524.63
(time (b 123456789123456789) 10000000)
;-> 663.162

La funzione "point-sphere" restituisce un numero:
  -1 se il punto è interno alla sfera
   0 se il punto è sulla superficie della sfera
  +1 se il punto è esterno alla sfera

(define (point-sphere cx cy cz r x y z)
  (let (d (sub (dist3d-2 cx cy cz x y x) (mul r r)))
    (cond ((> d 0) 1)
          ((= d 0) 0)
          ((< d 0) -1))))

(point-sphere 1 2 3 5 4 5 2)
;-> -1
(point-sphere 0 0 0 3 2 1 2)
;-> 0
(point-sphere 0 0 0 3 10 10 10)
;-> 1
(point-sphere 0 0 0 3 1 1 1)
;-> -1


-------------------
Correttori di bozze
-------------------

Questo problema è stato proposto da George Polya.
Due correttori di bozze, A e B, leggono indipendentemente lo stesso manoscritto e fanno una lista degli
errori che trovano. La lista di A registra "a" errori, mentre la lista di B registra "b" errori. Le due liste hanno "c" errori in comune. Stimare il numero totale di errori che non sono stati rilevati sia da A che da B.

Questo problema è stato proposto da George Polya e la soluzione (di Polya) è (a - c)*(b - c)/c.
Il manoscritto deve essere "sufficientemente lungo" da giustificare l'utilizzo della frequenza relativa come interpretazione della probabilità.

(define (stima a b c)
  (div (* (- a c) (- b c)) c))

(stima 10 10 10)
;-> 0
(stima 10 10 5)
;-> 5
(stima 12 10 5)
;-> 7
(stima 30 20 5)
;-> 75
(stima 11 19 4)
;-> 26.25


-------------------------
Probabilità: 1 su quanti?
-------------------------

La probabilità P è un valore cha varia da 0 (evento impossibile) a 1 (evento certo). Spesso viene al posto di questo valore viene usata l'espressione "ha una probabilità di 1 su N" dove "N" è un numero intero.

La seguente funzione converte una valore di probabilità tra 0 e 1 nell'espressione "1 su N" (si tratta semplicemente di applicare la formula P = 1/N).

(define (prob-1suN p) (list 1 (int (add (div p) 0.5))))

(prob-1suN 0.1)
;-> (1 10)
(prob-1suN 0.0063)
;-> (1 159)
(prob-1suN 0.0099)
;-> (1 101)


---------------------
Sondaggi imbarazzanti
---------------------

Supponiamo di voler fare un sondaggio per sapere quante persone praticano un certo atto privato. Se l'atto è imbarazzante (ad esempio, avere un amante), allora interrogando direttamente le persone difficilmente le risposte saranno veritiere. Anche un voto "segreto" (ad esempio, in una cabina elettorale) non renderebbe le persone così tranquille da rivelare la verità.

Per rispettare la privacy delle persone è stato proposto il seguente metodo:

Ogni persona entra tutta sola in una stanza e lancia una moneta.
Se esce la croce, la persona scrive la risposta (SI o NO) alla domanda privata su un foglio.
Se invece esce testa, allora la persona lancia la moneta una seconda volta e scrive la risposta (SI o NO) alla seguente domanda:  "È uscita testa al secondo lancio?"
Dopodiché, la persona infila il foglio in una cassetta ed esce.
Ora, su ogni foglio ci sarà un singolo SI o NO e, alla fine avremo N fogli di questo tipo.
Non sappiamo a quale domanda ogni particolare la persona stava effettivamente rispondendo, eppure ora possiamo calcolare quale percentuale di popolazione (o, almeno, delle persone nel sondaggio) ha risposto SI alla domanda privata (cioè effettua l'atto privato).

Suponiamo che ci siano N persone che hanno risposto alla domanda.
Poniamo che K sia il numero di risposte SI.
La metà delle persone, cioè (1/2)N, hanno risposto direttamente alla domanda privata (poichè la probabilità che esca croce vale 1/2).
L'altra metà delle persone ha risposto il 50% SI e il 50% NO (perchè sia croce che testa hanno probabilità pari a 1/2). Quindi il numero di SI della seconda metà di persone vale (1/4)N e questi sono i SI in risposta alla seconda domanda.
Quindi K - (1/4)N sono i SI in risposta alla domanda privata generati da (1/2)N persone.
Adesso possiamo calcolare la probabilità cercata:

       casi favorevoli      K - (1/4)N
  P = ----------------- = -------------- = 2*(K/N - 1/4)
       casi possibili         (1/2)N

(define (query num-people num-yes)
  (mul 2 (sub (div num-yes num-people) 0.25)))

Proviamo con un campione di 10000 persone e 4150 risposte SI:

(query 10000 4150)
;-> 0.33

Il 33% del campione pratica l'atto privato.

(div 0.33)
;-> 3.03030303030303

Cioè 1 su 3 pratica l'atto privato.

Questo è un ottimo metodo poiché rispetta la privacy e non c'è motivo di mentire. L'idea originale è di Stanley Warner e si trova nel suo articolo "Randomized Response: A Survey Technique for Eliminating Evasive Answer Bias" Journal of the American Statistical Association, vol.60, 1965.


------------------
Corte di giustizia
------------------

Una corte di giustizia è composta da 5 giudici: A, B, C, D, E.
Le percentuali di decisione corrette dei 5 giudici valgono rispettivamente: a, b, c, d, e.
La decisione della corte (innocenza o colpevolezza) è quella della maggioranza dei giudici (cioè 3 giudici che decidono allo stesso modo).
Scrivere una funzione che calcola le probabilità di una decisione errata della corte al variare delle percentuali di correttezza dei giudici.
Inoltre calcolare la stessa probabilità se il giudice più scarso vota come il giudice più bravo.

Nota: non importa se la decisione riguarda l'innocenza o la colpevolezza, a noi interessa soltanto se la decisione della corte è corretta o meno.

Funzione che restituisce l'indice dell'elemento di una lista che ha il valore maggiore:

(define (max-idx lst)
  (let ((val -9223372036854775808) (idx 0))
    (dolist (el lst)
      (if (> el val) (set 'idx $idx 'val el))
    )
    idx))

Funzione che restituisce l'indice dell'elemento di una lista che ha il valore minore:

(define (min-idx lst)
  (let ((val 9223372036854775807) (idx 0))
    (dolist (el lst)
      (if (< el val) (set 'idx $idx 'val el))
    )
    idx))

La funzione di simulazione accetta una lista di probabilità di lunghezza qualunque (cioè la simulazione può essere fatta con un numero variabile di giudici) e un parametro "val" che, se impostato a "true", simula il fatto che il giudice più scarso vota come il giudice più bravo (cioè copia il voto).

(define (corte prob iter var)
  (local (errori soglia a b voti res out)
    ; soglia della maggioranza
    (setq soglia (/ (length prob) 2))
    ; indice del giudice più bravo
    (setq a (max-idx prob))
    ; indice del giudice più scarso
    (setq b (min-idx prob))
    (setq errori 0)
    (for (i 1 iter)
      (setq voti (dup 0 (length prob)))
      ; decisione corretta (valore 0)
      (setq deciso 0)
      (dolist (el prob)
        ; errore del giudice $idx?
        (if (> (random) el)
            (setf (voti $idx) 1)
        )
      )
      ;(println voti)
      ;(println deciso { } errori)
      ;(read-line)
      ; Variante:
      ; Il giudice che sbaglia di più,
      ; vota come giudice che sbaglia di meno.
      (if var (setf (voti b) (voti a)))
      ;
      ; calcolo della maggioranza
      (setq res (apply + voti))
      ; calcolo della decisione:
      ; se più di N/2 giudici hanno sbagliato decisione,
      ; allora la decisione della corte è errata (valore 1)
      (if (> res soglia) (setq deciso 1))
      ; aggiorna il numero totale degli errori
      (setq errori (+ errori deciso))
    )
    (div errori iter)))

Test sulla correttezza della funzione:

1) se poniamo tutte le probabilità a 1 (cioè i giudici non sbagliano mai), allora il risultato della simulazione deve essere 0
(corte '(1 1 1 1 1) 1e3)
;-> 0

2) se poniamo tutte le probabilità a 0 (cioè i giudici sbagliano sempre), allora il risultato della simulazione deve essere 1
(corte '(0 0 0 0 0) 1e3)
;-> 1

Facciamo alcune prove:

(corte '(0.95 0.95 0.9 0.9 0.8) 1e7)
;-> 0.0070649 (circa 0.7% di decisioni errate)

Copia del voto:
(corte '(0.95 0.95 0.9 0.9 0.8) 1e7 true)
;-> 0.0120196 (circa 1.2% di decisioni errate)

Il risultato è controintuitivo, infatti se il giudice scarso copia il voto del giudice più bravo, allora le probabilità di una decisione errata della corte passano dallo 0.7% al 1.2% (aumento degli errori).

Adesso supponiamo che il giudice scarso sia "molto scarso", con una probabilità di decisioni corrette pari a 0.2:

(corte '(0.95 0.95 0.9 0.9 0.2) 1e7)
;-> 0.0239772 (circa 2.3% di decisioni errate)

Copia del voto:
(corte '(0.95 0.95 0.9 0.9 0.2) 1e7 true)
;-> 0.0120143 (circa 1.2% di decisioni errate)

In questo caso il risultato ci conforta, infatti se il giudice copia il voto, allora la corte passa dal 2.3% al 1.2% di decisioni errate (diminuzione degli errori).

Quindi esisterà un valore di equilibrio in cui le due probabilità sono uguali (cioè non importa se il giudice copia o meno). Dopo alcuni tentativi questo punto di equilibrio si trova quando la probabilità del giudice scarso vale circa 0.62:

(corte '(0.95 0.95 0.9 0.9 0.62) 1e7)
;-> 0.0120096 (circa 1.2% di decisioni errate)

Copia del voto:
(corte '(0.95 0.95 0.9 0.9 0.2) 1e7 true)
;-> 0.0120143 (circa 1.2% di decisioni errate)

La morale sembra quella che "copiare conviene solo se si copia da uno molto più bravo".


-----------------
Programs Launcher
-----------------

Un programma per lanciare qualunque applicazione Windows dalla REPL di newLISP.
Il metodo utilizzato è molto spartano, ma serve per evitare diversi problemi che insorgono quando l'applicazione da eseguire ha un percorso che contiene il carattere spazio " ".

Operazioni preliminari
----------------------
1) Creare una cartella il cui percorso non contiene spazi (es. c:\links)
2) Creare i links dei programmi che vogliamo eseguire e copiarli nella cartella creata (anche i nomi di questi link non devono contenere spazi)

La funzione seguente accetta un parametro opzionale "id" che rappresenta il numero del link del programma da lanciare (se lo conosciamo priori). Se il parametro non è presente, allora viene presentata la lista dei link disponibili da cui si può selezionare quello desiderato.
Per eseguire il link utilizziamo la funzione predefinita "!" che esegue un comando della shell (in questo caso il comando è "start").

(define (run id)
  (local (link-folder prog)
    ; cartella dei link
    (setq link-folder "c:\\util\\links\\")
    ; lista dei link della cartella
    (setq prog (sort (directory link-folder {\.lnk})))
    (cond ((nil? id) ; id non presente nei parametri
            ; lista dei link con id (numero)
            (dolist (p prog)
              (println $idx ". " p)
            )
            ; Input utente: id da eseguire?
            ; "Enter" per uscire...
            (print "run id: ")
            (read-line)
            (setq id (int (current-line)))
            ; controllo correttezza id
            (if (and (>= id 0) (< id (length prog)))
                ; run id link
                (! (append "start " link-folder (prog id)))
            )
          )
          (true ; id presente nei parametri
            ;run id link
            (! (append "start " link-folder (prog id)))
          ))))

(run)
;-> 0. CormanLisp.lnk
;-> 1. ForthCalc.lnk
;-> 2. alarm.lnk
;-> 3. foobar2000.lnk
;-> 4. gimp.lnk
;-> run id: 1 ;input utente
;-> 0

Per eseguire l'applicazione ForthCalc direttamente:

(run 1)
;-> 0


-----------------
Duello tra idioti
-----------------

Due individui, A e B, si sfidano a un duello che ha le seguenti regole:
- Una pistola con cilindro a sei colpi è caricata con un solo proiettile.
- Il cilindro viene ruotato in modo che il proiettile sia posizionato casualmente.
- La pistola ha 1/6 di possibilità di sparare il proiettile (indipendentemente da chi dei due spara).
- Se la pistola spara, allora l'avversario muore.
- Se la pistola non spara, allora l'altro individuo prende la pistola, fa girare il cilindro e preme il grilletto contro l'avversario.
- Il duello continua fino alla morte di uno dei due individui.
- Il primo a sparare è A.

Quali sono le probabilità di vittoria dei due contendenti?

Qual è la durata media/prevista del duello? Cioè, quanti spari durerà (in media) il duello?

Soluzione analitica
In ciascuno dei turni di A, c'è 1/6 di possibilità che A vinca e 5/6 di possibilità che il duello continui. A può vincere solo in un turno dispari (1, 3, 5, ...) e B può vincere solo in un turno pari (2, 4, 6, ...). A non può vincere se B vince per primo. La probabilità che A vinca è la probabilità totale di vincita in ogni turno dispari. Questo può essere espresso come la somma infinita:

         ∞
  P(A) = ∑ (5/6)^(2i) * (1/6) = 6/11 = 0.5454545454545454...
        i=0

(define (duello2 iter)
  (local (p spari colpito wa wb)
    (setq p (div 6))
    (setq tot-spari 0)
    (for (i 1 iter)
      (setq spari 0)
      (setq colpito nil)
      (until colpito
        (++ spari)
        (cond ((and (<= (random) p) (odd? spari))
               (++ wa)
               (setq colpito true)
              )
              ((and (<= (random) p) (even? spari))
               (++ wb)
               (setq colpito true)
              )
        )
      )
      (setq tot-spari (+ tot-spari spari))
    )
    (list (div wa (+ wa wb)) (div tot-spari iter))))

(duello2 1e6)
;-> (0.545109 6.001953)
(duello2 1e7)
;-> (0.5452551 5.9991003)
(duello2 1e8)
;-> (0.54552161 5.99913707)


--------------------
Formula di Bernoulli
--------------------

Sia dato un evento che può avere due risultati (A o B), uno con probabilità p e l'altro con probabilità (p - 1).
Nell'ipotesi che gli eventi siano indipendenti tra loro, la probabilità che l'evento A si verifichi k volte su n vale:

PA(k) = binom(n k) * p^k * (1 - p)^(n-k)

                         n!
dove, binom(n k) = ---------------
                     k!*(n - k)!

rappresenta il numero delle disposizioni di n elementi di cui k di un tipo e (n - k) di un altro tipo.

(define (binom num k)
"Calculates the binomial coefficient (n k) = n!/(k!*(n - k)!) (combinations of k elements without repetition from n elements)"
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(define (bernoulli n k p)
  (mul (binom n k) (pow p k) (pow (sub 1 p) (- n k))))

Esempio: Lancio di una moneta
Dopo 100 lanci di una moneta equa, qual'è la probabilità che siano uscite 50 teste e 50 croci?

(bernoulli 100 50 0.5)
;-> 0.07958923738717877


------------------
Palestre e autobus
------------------

Eva si allena in due palestre (P1 e P2) che si trovano alla stessa distanza da casa, ma in direzioni opposte. Per andare nella palestra P1 prende l'autobus A1, mentre per andare nella palestra P2 prende l'autobus A2. Gli autobus partono dalla stessa fermata, ma vanno in direzioni opposte. Entrambi gli autobus passano con frequenza oraria (ma non nello stesso momento). Siccome ad Eva non piace aspettare, quando si trova alla fermata prende il primo autobus che arriva (o A1 o A2).
Dopo un pò di tempo Eva si accorge che è andata molto di più in una palestra, esattamente 30 volte nella palestra P1 e 6 volte nella palestra P2.
Sapendo che l'autobus P1 parte all'ora X (es. 12:20), a che ora parte l'autobus P2?

Poichè Eva può arrivare alla fermata in qualunque momento nell'intervallo di un'ora, ha 30 probabilità di prendere l'autobus A1 e 6 di prendere l'autobus A2:

P(A1) = 30/(30+6) = 30/36 = 5/6
P(A2) = 6/(30+6) = 6/36 = 1/6

Adesso queste probabilità vanno "spalmate" su 60 minuti (un'ora), cioè per X minuti prende l'autobus A1 e per Y minuti prende l'autobus A2:

P(A1) = (5/6)*60 = 50 minuti
P(A2) = (1/6)*60 = 10 minuti

In altre parole, in un'ora ci sono 50 minuti in cui può prendere l'autobus A1 e 10 minuti in cui può prendere l'autobus A2. Questo è possibile quando l'orario di partenza di P1 vale X e l'orario di partenza di P2 vale X + 10.

Vediamo un esempio, se l'autobus A1 parte alle 12:20, allora l'autobus A2 parte alle 12:30, perchè solo in questo modo si hanno 50 minuti per prendere A1 (dalle 12:30 alle 13:20) e 10 minuti per prendere A2 (dalle 12:20 alle 12:30). In altre parole, se Eva arriva tra le 12:30 e le 13:20 prende l'autobus A1, se arriva tra le 12:20 e le 12:30 prende l'autobus A2.

Questo spiega il motivo per cui Eva frequenta più spesso la palestra P1.


------------------------------------------------
Somma di una serie di numeri: algoritmo di Kahan
------------------------------------------------

In analisi numerica, l'algoritmo di Kahan per la somma di una serie di numeri in virgola mobile (conosciuto anche come "sommatoria compensata") riduce significativamente l'errore numerico totale, rispetto al procedimento consueto. Ciò è ottenuto mantenendo separatamente una compensazione progressiva, cioè una variabile per accumulare piccoli errori che compensa gli errori dovuti alla finitezza delle cifre decimali.

Quando rappresentiamo un generico numero reale in virgola mobile con precisione finita, ossia con un numero finito di cifre significative, tale rappresentazione, rispetto al numero reale considerato, differisce di un certo valore, il quale corrisponde all'errore di arrotondamento ed è lo scarto tra la rappresentazione in virgola mobile e il numero stesso. Eseguendo una semplice sommatoria di più numeri reali, utilizzando però le rispettive rappresentazioni in virgola mobile, il totale ottenuto presenta un certo errore dato dalla somma algebrica dei singoli errori di arrotondamento, ossia dei singoli scarti, e un certo scarto quadratico medio.
In particolare, la sommatoria semplice di n numeri in sequenza presenta un errore che, nel caso peggiore, cresce proporzionalmente ad n ed uno scarto quadratico medio che cresce come sqrt(n) per addendi casuali. Invece, utilizzando la sommatoria compensata, l'errore peggiore possibile è indipendente da n, dunque un gran numero di valori possono essere sommati con un errore che dipende solo dalla precisione della rappresentazione in virgola mobile.

function KahanSum(input)
    var sum = 0.0
    ; Una compensazione in esecuzione per i bit meno significativi persi.
    var c = 0.0
    for i = 1 to input.length do
        ; Fin qui, tutto bene: c è zero.
        var y = input[i] - c
        ; Purtroppo, sum è grande, y è piccola, dunque le cifre meno significative di y vengono perse.
        var t = sum + y
        ; (t - sum) annulla la parte più significativa di y e sottraendo y si recupera la parte meno significativa di y cambiata di segno
        c = (t - sum) - y
        ; Algebricamente, c dovrebbe sempre essere zero. Occorre prestare attenzione ai compilatori con ottimizzazione troppo aggressiva!
        sum = t
        ; La volta successiva, la parte meno significativa persa verrà aggiunta a "y" in un nuovo tentativo. .
    next i
    return sum

Esempio:
Supponiamo di utilizzare l'aritmetica in virgola mobile decimale a sei cifre e che sum, la somma, abbia raggiunto il valore 10000.0 e che i prossimi due valori degli input(i) siano 3.14159 e 2.71828. Il risultato esatto è 10005.85987, che si arrotonda a 10005.9. Con una sommatoria semplice ogni valore introdotto sarebbe allineato a sum, la somma, e molte cifre meno significative andrebbero perse (per troncamento o arrotondamento). Il primo risultato, dopo l'arrotondamento, sarebbe 10003.1. Il secondo risultato sarebbe 10005.81828 prima dell'arrotondamento e 10005.8 dopo. Ciò non è corretto.

Tuttavia, con la sommatoria compensata, otteniamo il risultato arrotondato corretto di 10005,9.

Assumiamo che c abbia il valore iniziale zero.

  y = 3.14159 - 0                   y = input[i] - c
  t = 10000.0 + 3.14159
    = 10003.14159                   Ma solo sei cifre vengono mantenute.
    = 10003.1                       Molte cifre sono andate perse!
  c = (10003.1 - 10000.0) - 3.14159 Questo deve essere valutato come scritto!
    = 3.10000 - 3.14159             La parte assimilata di y, recuperata, in contrapposizione al valore originale completo di y.
    = -.0415900                     Gli zeri finali vengono visualizzati perché si tratta di aritmetica a sei cifre.
sum = 10003.1                       Dunque, poche cifre da input(i) sono rimaste in quelle di sum.

La somma è così grande che solo le cifre più significative dei numeri inseriti vengono accumulate. Ma, al passo successivo, c dà un errore.

  y = 2.71828 - -.0415900           Il deficit ottenuto al passo precedente viene incluso.
    = 2.75987                       È di dimensioni simili a  y : le cifre più significative sono rimaste.
  t = 10003.1 + 2.75987             Ma poche sono rimaste nelle cifre di sum
    = 10005.85987                   e il risultato è arrotondato
    = 10005.9                       a sei cifre.
  c = (10005.9 - 10003.1) - 2.75987 Ciò estrae qualunque cosa sia stata ottenuta.
    = 2.80000 - 2.75987             In tal caso, c'è un eccesso.
    = .040130                       Ma non importa, l'eccesso verrebbe sottratto alla volta successiva.
sum = 10005.9                       Il risultato esatto è 10005.85987, esso è correttamente arrotondato a 6 cifre.

In tal modo, la sommatoria è accumulata utilizzando due variabili: sum che si riferisce alla somma e c in cui si accumulano le parti non assimilate in sum, per spostare nuovamente la parte meno significativa di sum la volta successiva. Quindi la sommatoria procede con delle "cifre di guardia" in c che è meglio di niente, ma che non è ottimale quanto sarebbe effettuare i calcoli con precisione doppia rispetto all'input. Tuttavia, aumentare semplicemente la precisione dei calcoli, in generale, non è pratico (se l'input è già in precisione doppia, pochi sistemi forniscono una precisione quadrupla)

Pur essendo più accurato di una sommatoria semplice, questo metodo può ancora dare grandi errori relativi nel caso di somme in particolari cattive condizioni.

Neumaier ha introdotto una modifica dell'algoritmo di Kahan che copre anche il caso in cui il termine successivo da aggiungere è maggiore in valore assoluto rispetto alla somma corrente, scambiando efficacemente il ruolo di ciò che è grande e ciò che è piccolo. In pseudocodice, l'algoritmo è:

 function NeumaierSum(input)
    var sum = input[1]
    ; Una compensazione in corso per i bit meno significativi persi.
    var c = 0.0
    for i = 2 to input.length do
        var t = sum + input[i]
        if |sum| >= |input[i]| do
            ; Se sum è più grande, le cifre meno significative di input[i] vanno perse.
            c += (sum - t) + input[i]
        else
            ; Altrimenti, le cifre meno significative di sum vanno perse.
            c += (input[i] - t) + sum
        sum = t
    ; Correzione applicata solo una volta alla fine.
    return sum + c

Per molte sequenze di numeri, entrambi gli algoritmi concordano, ma il seguente esempio dovuto a Peters mostra che essi possono differire. Sommando (1.0 10^(100) 1.0 -10^100) in doppia precisione, l'algoritmo di Kahan produce 0.0 mentre l'algoritmo di Neumaier fornisce il valore corretto 2.0.

Nota: in teoria un'ottimizzazione del compilatore sufficientemente aggressiva potrebbe compromettere l'efficacia della sommatoria di Kahan semplificando delle espressioni in base alle regole di associatività dell'aritmetica reale( per esempio, potrebbe semplificare il secondo passo della sequenza da:

 t = sum + y
 c = (t - sum) - y

a:

 c = ((sum + y) - sum) - y

poi a:

c = 0, eliminando la compensazione dell'errore.


-----------------------
Numeri in base negativa
-----------------------

Dato un numero intero e una base negativa, scrivere una funzione che converte il numero in quella base.
Per rappresentare un numero con una base "positiva", ad esempio in base 2, moltiplichiamo i bit per 1, 2, 4, 8 ecc. per ottenere il numero decimale.
Per rappresentare un numero con una base "nagativa", ad esempio in base -2, moltiplichiamo i bit per 1, -2, 4, -8 ecc. per ottenere il numero decimale (in questo caso possiamo rappresentare sia gli interi positivi che quelli negativi)

Esempio:
Input: num = 13, base-negativa = -2
Output: 11101
Verifica: 1*(16) + 1*(-8) + 1*(4) + 0*(-2) + 1*(1) = 13

E' possibile rappresentare un numero in qualsiasi base negativa con la stessa procedura, ma in questo caso la base è compresa tra -2 e -10.

L'algoritmo è lo stesso di quello con basi positive, ma bisogna assicurarsi che il "resto" sia sempre positivo una cosa importante da ricordare è che il resto sarà sempre positivo sia che lavoriamo con una base positiva che con una base negativa, ma nella maggior parte dei linguaggi/compilatori, il risultato della divisione di un numero negativo per un numero negativo viene arrotondato verso 0, lasciando di solito un resto negativo. Quindi ogni volta che otteniamo un resto negativo, possiamo convertirlo in positivo nel modo seguente:

Quindi se dopo aver fatto "resto = n % negBase" e "n = n/negBase", otteniamo resto negativo, allora applichiamo:
  resto = resto + (-negBase)
  n = n + 1

Esempio: n = -4, negBase = -3
  resto = n % negBase = -4/-3 = -1
  n = n/negBase [Passo successivo per la conversione della base]
    = -4/-3
    = 1
Per evitare resto negativo, facciamo,
  resto = -1 + (-negBase) = -1 - (-3) = 2
  n = n + 1 = 1 + 1 = 2.

Quindi, quando otterremo un resto negativo, lo renderemo positivo aggiungendo il valore assoluto di base e aggiungendo 1 al nostro

Nota: questo metodo è applicabile a tutti gli interi negativi utilizzati come base (non solo -2).

Vediamo meglio il procedimento iniziando con il caso in cui viene utilizzato un numero intero positivo come base.
Usando n come base, possiamo avere i seguenti passaggi:
a % n == r, a /= n, ans = str(r) + ans
Quindi continua a ripetere a turno, unendo tutti i resti insieme.
Poiché n è un numero intero positivo, il resto deve essere un numero non negativo e il resto deve essere compreso nell'intervallo [0, n-1]. (Indipendentemente dal caso in cui il dividendo sia un numero negativo, in quanto è impossibile utilizzare una base positiva n  per rappresentare un numero negativo)

Adesso, consideriamo la situazione in cui viene utilizzato un numero intero negativo come base.
Sia: a = n * b + r, in questo momento poiché n è un numero negativo, quando a è anche un numero negativo, r può essere un numero negativo.
Questo non è consentito nel nostro processo di conversione, quindi in questo momento il nostro requisito per r è: il più piccolo possibile (vicino a 0) intero non negativo (questo risultato potrebbe essere leggermente diverso dalla normale operazione modulo)

Esempio: Il numero 146 espresso in base -3

146 / -3 = -48 resto 2
-48 / -3 = 16 resto 0
 16 / -3 = -5 resto 1
 -5 / -3 = 2 resto 1
  2 / -3 = 0 resto 2

Da notare che il risultato di -5 / -3 dovrebbe essere 1 resto -2, ma per rendere il resto un numero non negativo,
Abbiamo aggiustato il risultato -2 -(-3) = 1, in modo che -5 / -3 = 2 resto 1
Il risultato è: (((2*(–3)+1)*(–3)+1)*(–3)+0)*(–3)+2 = 146

Pertanto, affinché il residuo ottenuto soddisfi le condizioni, è necessario eseguire la seguente elaborazione:

  se r < 0 allora r = r + abs(n), a = a / n + 1

(Perché la prossima operazione assegnerà b ad a, che equivale a b += 1, il valore del quoziente +1)

La dimostrazione è la seguente:
Qui per comodità di comprensione e presentazione, sia n un numero intero positivo, e sappiamo che se r è un numero negativo, allora l'intervallo di r deve essere superiore a [-n+1, ​​​​0]:

  a = (-n)*b + r ==> a = (-n)*b + (r + n) - n ==> a = (-n)*(b + 1) + (r + n)

Pertanto, nell'intervallo di r, possiamo garantire che il resto r sia un intero non negativo attraverso l'operazione r+n, e allo stesso tempo porre il dividendo del turno successivo a b = b + 1

Nota: quando la base n è un intero negativo, sia gli interi negativi che gli interi positivi possono essere rappresentati in base n.

Scriviamo la funzione che converte un numero intero decimale in basi negative (con base che può variare da -2 a -10):

(define (to-negative-base num neg-base)
  (local (rem out)
    ; default: neg-base = -2
    (if (nil? neg-base) (setq neg-base -2))
    (setq out '())
    (while (!= num 0)
     (setq rem (% num neg-base))
     (setq num (/ num neg-base))
     ; check resto minore di zero
     (if (< rem 0)
         (set 'rem (- rem neg-base) 'num (+ num 1))
     )
     (push rem out)
    )
    out))

(to-negative-base 2 -2)
;-> (1 1 0)
(to-negative-base 3)
;-> (1 1 1)
(to-negative-base 4 -2)
;-> (1 0 0)
(to-negative-base 13)
;-> (1 1 1 0 1)
(to-negative-base 146 -3)
;-> (2 1 1 0 2)
(to-negative-base 146 -10)
;-> (2 6 6)
(to-negative-base 15 -10)
;-> (1 9 5)

Adesso scriviamo la funzione inversa che converte una lista che rappresenta un numero in base negativa in un numero decimale:

(define (from-negative-base lst-num neg-base)
  (let (res 0)
    ; default: neg-base = -2
    (if (nil? neg-base) (setq neg-base -2))
    (dolist (el (reverse lst-num))
      (setq res (add res (mul (pow neg-base $idx) el)))
    )
    res))

(from-negative-base '(1 1 0))
;-> 2
(from-negative-base '(1 1 1 0 1))
;-> 13
(from-negative-base '(2 1 1 0 2) -3)
;-> 146
(from-negative-base '(2 6 6) -10)
;-> 146
(from-negative-base '(1 9 5) -10)
;-> 15

Per maggiori informazioni vedi l'articolo di Gilbert, Green "Negative Based Number Systems":
https://www.math.uwaterloo.ca/~wgilbert/Research/GilbertNegBases.pdf


----------------------
Serie e somma armonica
----------------------

La serie armonica è definita nel modo seguente:

  ∞
  ∑ 1/k = 1 + 1/2 + 1/3 + 1/4 + 1/5 + ...
 k=1

Nota: la serie armonica è divergente, cioè per un valore "m" sufficientemente grande, la somma parziale dei termini da 1 a m può superare qualunque numero prefissato (comunque questa serie cresce molto lentamente).

La somma armonica è una serie armonica troncata (finita):

  n
  ∑ 1/k = 1 + 1/2 + 1/3 + ... + 1/n
 k=1

Il calcolo esatto  di una somma armonica può essere fatto con la seguente funzione:

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))

(define (+rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (+ (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1L) (r2 1L))))

(define (harmonic-f num)
  (let (res '(1 1))
    (for (i 2 num)
      (setq res (+rat res (list 1 i)))
    )
    (println res)
    (div (first res) (last res))))

(harmonic-f 10)
;-> (7381L 2520L)
;-> 2.928968253968254

Il valore di una serie armonica può essere approssimato dalla seguente formula:

  n
  ∑ 1/k ≈ ln(n) + K + 1/(2*n)
 k=1

La costante K è la costante di Eulero-Mascheroni ed è definita come limite della differenza tra la somma armonica e il logaritmo naturale:

           n
K = limite(∑ 1/k - ln(n)) = 0.577215664901532860606512090082402431042159335...
    n->∞  k=1

Scriviamo una funzione che calcola la somma armonica con la formula di approssimazione:

(define (harmonic num)
  (add (log num) 0.57721566490153286 (div (mul 2 num))))

(harmonic 10)
;-> 2.929800757895579

Vediamo la differenza tra le due funzioni:

(sub (harmonic-f 10) (harmonic 10))
;-> -0.0008325039273247015

(sub (harmonic-f 50) (harmonic 50))
;-> -3.333200025412708e-005


--------------------
Raccolta di figurine
--------------------

Un album contiene 100 figurine. Se la probabilità di ogni figurina vale 1/100, quante figurine dobbiamo acquistare, in media, per riempire l'album?

Partiamo con un semplice esempio, se abbiamo un dado a sei facce, quante volte dobbiamo lanciarlo, in media, per ottenere un 6?
La risposta ovvia è 6 volte, ma perchè?
Sia p la probabilità che esca un 6 e q = (1 - p) la probabilità che non esca un 6. Possiamo scrivere la seguente tabella:

Lancio   Probabilità che esca un 6
-------+--------------------------------------------------------------------
  1    |  p
  2    |  q * p (cioè primo lancio non-sei e secondo sei)
  3    |  q * q * p (cioè primo lancio non-sei, secondo non-sei e terzo sei)
  4    |  q * q * q * p
 ...      ...

La somma delle probabilità vale:

  p + p*q + p*q^2 + p*q^3 + ... = p(1 + q + q^2 + q^3 + ...)
                                = p/(1 - q) = p/p = 1

Per definizione, il valore medio del numero di lanci "m" vale:

  m = p + 2*p*q + 3*p*q^2 + 4*p*q^3 + ...

Moltiplichiamo per q:

  q*m = p*q + 2*p*q^2+ 3*p*q^3 + 4*p*q^4 + ...

Calcoliamo (m - q*m):

  (m - q*m) = p + p*q + p*q^2 + p*q^3 + ...

Il termine destro di questa uguaglianza è la somma delle probabilità che abbiamo calcolato sopra e vale 1, quindi possiamo calcolare il valore medio "m":

  (m - q*m) = 1  ==> m*p = 1 ==> m = 1/p

Quindi, nel caso del lancio del nostro dado, il numero medio di lanci per ottenere un sei vale 6 (come avevamo intuito all'inizio).

Verifichiamolo con una funzione casuale:

(define (test-dado num iter)
  (local (parz tot)
    (setq tot 0)
    (for (i 1 iter)
      (setq parz 1)
      (until (= (- num 1) (rand 6))
        (++ parz)
      )
      (setq tot (+ tot parz))
    )
    (div tot iter)))

(test-dado 6 1e6)
;-> 6.008322

Adesso supponiamo che il nostro album sia composto da 5 figurine soltanto.
Otteniamo la prima figurina giusta al primo acquisto.
La probabilità di ottenere una figurina giusta con il secondo acquisto vale 4/5. Seguendo lo stesso ragionamento fatto per il dado, il numero medio di acquisti per ottenere la seconda figurina giusta vale 1/(4/5) = 5/4.
La terza figurina ha una probabilità di 3/5 e richiede 1/(3/5) = 5/3 di acquisti.
La quarta figurina ha una probabilità di 2/5 e richiede 1/(2/5) = 5/2 di acquisti.
La quinta figurina ha una probabilità di 1/5 e richiede 1/(1/5) = 5 acquisti.
In totale abbiamo:

(5/5 + 5/4 + 5/3 + 5/2 + 5) = 5*(1/5 + 1/4 + 1/3 + 1/2 + 1) = 11.4166666...

(mul 5 (add (div 5) (div 4) (div 3) (div 2) 1)) = 11.4166666...

Quindi occorrono in media acquistare 11 figurine per completare un album di 5 figurine.

Da notare che l'epressione (1/5 + 1/4 + 1/3 + 1/2 + 1) è una somma armonica.

La funzione approssimata per calcolare la somma armonica è la seguente (vedi "Serie e somma armonica"):

(define (harmonic num)
  (add (log num) 0.57721566490153286 (div (mul 2 num))))

Verifichiamo la funzione con il nostro album di 5 figurine:

(mul 5 (harmonic 5))
;-> 11.43326788667817

Il risultato è molto vicino al valore vero 11.41(6).

Adesso possiamo utilizzare questa formula per risolvere il problema originale, cioè quante figurine occorre comprare, in media, se l'album contiene 100 figurine:

(define (album fig) (mul fig (harmonic fig)))

(album 100)
;-> 518.7385850889624

Dobbiamo comprare 518 figurine...

Proviamo con album di 100, 1000, 10000, 100000 figurine:

(for (i 2 5) (println (pow 10 i) { } (album (pow 10 i))))
;-> 100 518.7385850889624
;-> 1000 7485.470943883669
;-> 10000 97876.06036877717
;-> 100000 1209014.612987176

Possiamo scrivere una funzione che simula il processo per verificare i risultati:

(define (album2 num iter)
  (local (fig tot alb)
    (setq tot 0)
    (for (i 1 iter)
      ; album vuoto
      (setq alb (array num '(0)))
      (setq fig 0)
      ; fino a che non completo l'album...
      (until (= (apply + (array-list alb)) num)
        ; compro una figurina
        (setf (alb (rand num)) 1)
        (++ fig)
      )
      (setq tot (+ tot fig))
    )
    (div tot iter)))

(album2 5 10000)
;-> 11.4022
(album2 5 100000)
;-> 11.40983
(time (println (album2 100 10000)))
;-> 522.0433
;-> 9162.55

Anche se questa funzione è estremamente lenta, conferma i risultati teorici:

(time (println (album2 1000 10000)))
;-> 7491.9656
;-> 1690626.211 ; circa 28 minuti

Riscriviamo la funzione utilizzando una hash-map al posto del vettore:

(define (album3 num iter)
  (local (parz conta fig tot)
    (setq tot 0)
    (for (i 1 iter)
      ; album vuoto
      (new Tree 'hash)
      (setq parz 0)
      (setq conta 0)
      (until (= conta num)
        ; compro una figurina
        (setq fig (rand num))
        (++ parz)
        ;(println "fig = " fig)
        (if (= (hash fig) nil)
            (begin
              ;(println fig " aggiunta.")
              (hash fig fig)
              (++ conta)))
        ;(println "parz = " parz)
        ;(println "conta = " conta)
        ;(println "hash len = " (length (hash)))
        ;(read-line)
      )
      (delete 'hash)
      (setq tot (+ tot parz))
    )
    (div tot iter)))

(album3 5 10000)
;-> 11.4421
(album3 5 100000)
;-> 11.42954

(time (println (album3 100 10000)))
;-> 518.5324
;-> 1803.015

(time (println (album3 1000 10000)))
;-> 7498.3045
;-> 27392.915 ; circa 27 secondi


--------------
Strano ma vero
--------------

Generare N numeri casuali uniformi da 0 a 1 e metterli in N "contenitori" di uguale larghezza. Quindi, contare il numero di contenitori Z che sono vuoti (cioè non contengono alcun numero casuale). A quale numero tende il rapporto Z/N?

(define (stima num-seg)
  (local (segments len empty)
    ; larghezza dei contenitori
    (setq len (div num-seg))
    ; numero segmenti
    (setq segments (array (+ num-seg 1) '(0)))
    ; genera num-seg numeri random
    ; e per ogni numero aggiorna il valore del segmento (nel vettore)
    ; in cui cade quel numero
    (for (j 1 num-seg)
      (++ (segments (int (div (random) len))))
    )
    ; calcola numero di segmenti/intervalli vuoti
    (setq empty (first (count '(0) (array-list segments))))
    (div empty num-seg)))

Proviamo la funzione:

(stima 1e4)
;-> 0.3696
(stima 1e5)
;-> 0.68803
(stima 1e6)
;-> 0.967233
(time (println (stima 1e7)))
;-> 0.9967233
;-> 4837.121
(time (println (stima 1e8)))
;-> 0.99967233
;-> 57422.156

Sembra che il rapporto Z/N tende a 1 per N che tende all'infinito.

Il problema può essere formulato anche in questo modo: generare N numeri casuali da 1 a N. Quanti numeri da 1 a N non sono stati generati (Z)? Il rapporto Z/N dovrebbe tendere allo stesso valore.

(define (stima1 num-seg)
  (local (segments len empty)
    (setq segments (array (+ num-seg 1) '(0)))
    ; genera num-seg numeri random
    ; e per ogni numero aggiorna il valore del segmento (nel vettore)
    ; in cui cade quel numero
    (for (j 1 num-seg)
      (++ (segments (rand num-seg)))
    )
    ; calcola numero di valori vuoti
    (setq empty (first (count '(0) (array-list segments))))
    (div empty num-seg)))

Proviamo la funzione:

(stima1 1e4)
;-> 0.3697
(stima1 1e5)
;-> 0.68784
(stima1 1e6)
;-> 0.967234
(time (println (stima1 1e7)))
;-> 0.9967234
;-> 4256.015
(time (println (stima1 1e8)))
;-> 0.99967234
;-> 52394.689

Anche in questo caso il rapporto Z/N tende a 1 per N che tende all'infinito.

Proviamo con un'altra funzione: mettiamo tutti i numeri random in una lista (lst) e poi usiamo la funzione "unique" per trovare solo i numeri univoci. Il numero degli zeri (Z), cioè quanti numeri non abbiamo estratto, sono dati dall'espressione (- num-seg (length (unique lst))).

(define (stima2 num-seg)
  (local (segments len empty)
    (setq segments '())
    ; genera num-seg numeri random
    ; e li inserisce in una lista
    ; in cui cade quel numero
    (for (j 1 num-seg)
      (push (rand num-seg) segments)
    )
    ; calcola numero di segmenti/intervalli vuoti
    (setq empty (- num-seg (length (unique segments))))
    (div empty num-seg)))

Proviamo la funzione:

(stima2 1e4)
;-> 0.3743
(stima2 1e5)
;-> 0.68799
(stima2 1e6)
;-> 0.967233
(time (println (stima2 1e7)))
;-> 0.9967233
;-> 10445.33
(time (println (stima2 1e8)))
;-> 0.99967233
;-> 127722.023

Anche in questo caso il rapporto Z/N tende a 1 per N che tende all'infinito.

Nota: anche tutti i valori di output sono quasi uguali per tutte e tre le funzioni.

Il fatto che Z/N tende a 1 vuol dire che il numero di numeri non estratti si avvicina al numero totale di estrazioni, cioè il numero di numeri estratti tende a 0 (non molto chiaro però?!).


---------------------------------
Passeggiata casuale (random-walk)
---------------------------------

Dato un piano cartesiano con coordinate intere (lattice), scrivere un programma che simula una passeggiata casuale di un agente sul piano. Ad ogni passo l'agente può muoversi in una delle seguenti direzioni: nord, est, sud, ovest.

Usiamo una lista "pos" con le coordinate (x y) per ogni posizione visitata dal punto.
I movimenti del punto possono essere i seguenti:

Nord  --> x = x    , y = y + 1
Est   --> x = x + 1, y = y
Sud   --> x = x    , y = y - 1
Ovest --> x = x - 1, y = y

Per primo scriviamo una funzione che restituisce il percorso dell'agente, cioè una lista con tutte le coordinate dei punti visitati (anche quelli multipli, cioè visitati più volte):

(define (rnd-walk start iter)
  (local (pos moves path)
    ; inizializzazione generatore numeri random
    (seed (time-of-day))
    ; mosse possibili: -1 o +1 lungo x o lungo y
    (setq moves '(-1 +1))
    ; posizione iniziale
    (setq pos start)
    ; percorso dell'agente
    ; lista dei punti visitati (anche quelli multipli)
    (setq path '())
    ; posizione iniziale visitata
    (push pos path -1)
    ; inizio della passeggiata...
    (for (i 1 iter)
      ; aggiorna coordinate x o y (pos)
      (++ (pos (rand 2)) (moves (rand 2)))
      ; aggiorna la lista del percorso
      (push pos path -1)
      ;(println pos) (read-line)
    )
    ; stampa ultima posizione dell'agente
    ;(println pos)
    path))

Simuliamo una passeggiata di 10 passi partendo da 0,0:

(rnd-walk '(0 0) 10)
;-> (5 3)
;-> ((0 0) (0 1) (1 1) (1 2) (2 2) (3 2) (3 3) (3 2) (4 2) (4 3) (5 3))

Con la lista di tutti i punti visitati dall'agente, possiamo cercare quello che ci interessa.

Ad esempio, calcoliamo le frequenze dei punti visitati (cioè quante volte un punto è stato visitato):

Simuliamo una passeggiata casuale:

(setq percorso (rnd-walk '(0 0) 20))
;-> ((0 0) (-1 0) (-1 1) (-1 0) (-2 0) (-3 0) (-4 0) (-4 -1) (-3 -1) (-2 -1)
;->  (-2 -2) (-2 -3) (-3 -3) (-4 -3) (-4 -4) (-4 -5) (-3 -5) (-3 -6) (-3 -7)
;->  (-4 -7) (-3 -7))

Calcoliamo i punti unici visitati:

(setq unici (unique percorso))
;-> ((0 0) (-1 0) (-1 1) (-2 0) (-3 0) (-4 0) (-4 -1) (-3 -1) (-2 -1) (-2 -2)
;->  (-2 -3) (-3 -3) (-4 -3) (-4 -4) (-4 -5) (-3 -5) (-3 -6) (-3 -7) (-4 -7))

Calcoliamo/contiamo la frequenza di ogni punto del percorso:

(setq conta (count unici percorso))
;-> (1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1)

Infine creiamo una lista ordinata con la frequenza dei punti unici e le relative coordinate:

(sort (map list conta unici))
;-> ((1 (-4 -7))
;->  (1 (-4 -5))
;->  (1 (-4 -4))
;->  (1 (-4 -3))
;->  (1 (-4 -1))
;->  (1 (-4 0))
;->  (1 (-3 -6))
;->  (1 (-3 -5))
;->  (1 (-3 -3))
;->  (1 (-3 -1))
;->  (1 (-3 0))
;->  (1 (-2 -3))
;->  (1 (-2 -2))
;->  (1 (-2 -1))
;->  (1 (-2 0))
;->  (1 (-1 1))
;->  (1 (0 0))
;->  (2 (-3 -7))
;->  (2 (-1 0)))

Scriviamo una funzione per calcolare questa lista:

(define (freq-path path)
  (let (unici (unique path))
    (sort (map list (count unici path) unici))))

Usiamo la funzione su una nuova passeggiata:

(freq-path (rnd-walk '(0 0) 20))
;-> ((1 (0 -2)) (1 (0 -1)) (1 (0 0)) (1 (1 -4)) (1 (1 -1)) (1 (2 -6))
;->  (1 (2 -5)) (1 (2 -3)) (1 (3 -6)) (1 (3 -5)) (1 (3 -4)) (1 (3 -3))
;->  (1 (4 -8)) (1 (4 -7)) (1 (4 -6)) (1 (4 -4)) (1 (4 -3)) (2 (1 -3))
;->  (2 (1 -2)))

Data una passeggiata/percorso:

(silent (setq percorso (rnd-walk '(0 0) 2000)))

Possiamo calcolare il punto visitato di più:

(last (freq-path percorso))
;-> (15 (26 17))

Oppure quante volte è passato per (0 0):

(ref '(0 0) (freq-path percorso))
;-> (12 1)
((freq-path percorso) 12)
;-> (1 (0 0))

Possiamo esportare i punti del percorso e poi visualizzarli con un foglio elettronico:

(define (list-csv lst file-str sepchar)
"Creates a file csv from a list"
  (local (outfile)
    (if (nil? sepchar)
        (setq sepchar ",")
    )
    (setq outfile (open file-str "write"))
    (dolist (el lst)
      (setq line (join (map string el) sepchar))
      (write-line outfile line)
    )
    ;(print outfile { })
    (close outfile)))

(list-csv (rnd-walk '(0 0) 2000) "agente.csv")
;-> true

Lanciamo "excel" o "calc" con il nostro file "agente.csv":

(! "start excel agente.csv")

e poi facciamo i grafici/calcoli che vogliamo.


---------
Per gioco
---------

Definiamo una lista che contine un simbolo: il punto ".":

(setq a '(.))
;-> (.)
(a 0)
;-> .

Adesso definiamo una funzione che si chiama punto "." che stampa la parola "punto":

(define (.) (println "punto"))
;-> (lambda () (println "punto"))

Eseguiamo la funzione:

(.)
;-> punto

Adesso valutando il valore di (a 0), cioè il simbolo ".", otteniamo la definizione della funzione associata al simbolo ".":
(a 0)
;-> .
(eval (a 0))
;-> (lambda () (println "punto"))

Possiamo eseguire questa funzione racchiudendola tra parentesi () come per qualunque altra funzione:

((eval (a 0)))
;-> punto

Se assegniamo il simbolo/funzione "." ad un altro simbolo (es. "b"), allora a quest'ultimo viene associata una funzione uguale a quello di ".":

(setq b .)
;-> (lambda () (println "punto"))
(b)
;-> punto
(.)
;-> punto
(eval .)
;-> (lambda () (println "punto"))
(eval b)
;-> (lambda () (println "punto"))

Modifichiamo la funzione (che è una lista) associata al simbolo "b":

(list? b)
;-> true

Vogliamo cambiare la stringa "punto" con la stringa "b":

(nth 1 b)
;-> (println "punto")

(last (nth 1 b))
;-> "punto"

Effettuiamo la modifica:

(setf (last (nth 1 b)) "b")

Verifichiamo se la funzione è stata modificata:

(eval b)
;-> (lambda () (println "b"))

Valutiamo le due funzioni "b" e ".":

(b)
;-> b

(.)
;-> punto


------------
Carta attesa
------------

Dato un mazzo di carte Francesi (52 carte) e un mazzo di carte Napoletane (40 carte). Entrambi i mazzi sono ben mischiati. Cominciando ad estrarre dalla prima carta di un mazzo, quante carte occorrono, in media, per estrarre un Asso?
E quante ne occorrono per l'altro mazzo?
Cosa accade se scegliamo/attendiamo un'altra carta, ad esempio il "9"?

Scriviamo prima la funzione di simulazione:

(define (primo num carte iter)
  (local (mazzo tot)
    ; creazione del mazzo
    ; carte = 10 ==> mazzo napoletano
    ; carte = 13 ==> mazzo francese
    (setq mazzo (flat (dup (sequence 1 carte) 4)))
    (setq tot 0)
    (for (i 1 iter)
      ; mischia mazzo
      (setq mazzo (randomize mazzo))
                       ; dove sta la carta?
      (setq tot (+ tot (+ (find num mazzo) 1)))
    )
    (println tot)
    (div tot iter)))

(primo 1 13 1000000)
;-> 10.609797

Nel mazzo francese occorrono, in media, 10.6 carte prima che compaia un Asso.

(primo 1 10 1000000)
;-> 8.193944999999999

Nel mazzo napoletano occorrono, in media, 8.2 carte prima che compaia un Asso.

Qualunque altra carta produce gli stessi risultati:

Carte francesi:

(primo 9 13 1000000)
;-> 10.60951

Carte napoletane:

(primo 9 10 1000000)
;-> 8.194067

Dal punto di vista matematico possiamo utilizzare il "principio di simmetria":
quando n punti sono posizionati casualmente lungo un intervallo, la lunghezza degli (n + 1) sgmenti hanno una distribuzione identica.

I 4 Assi dividono un mazzo in 5 segmenti che possono avere una lunghezza da 0 a k.
Il valore di k è dato dal numero delle carte meno il numero degli Assi.
Se due Assi sono uno di seguito all'altro, allora il segmento tra loro ha lunghezza 0.
Se la prima carta è un Asso, allora il segmento precedente ha lunghezza 0.
Se l'ultima carta è un Asso, allora il segmento seguente ha lunghezza 0.
Il principio di simmetria afferma che i 5 segmenti dovrebbero avere una lunghezza media pari a k/5 carte. Quindi dopo k/5 carte la prossima è un Asso, così per ottenere un Asso dobbiamo estrarre, in media (1 + (k/5)) carte.

Verifichiamo il ragionamento con i due mazzi di carte:

Carte Francesi
  carte = 52
  k = carte - 4 = 48
  Media = 1 + 48/5 = 10.6
(add 1 (div 48 5))
;-> 10.6

Carte Napoletane
  carte = 40
  k = carte - 4 = 36
  Media = 1 + 36/5 = 8.2
(add 1 (div 36 5))
;-> 8.199999999999999


--------------
Scontro al bar
--------------

Due persone vanno tutti i giorni al bar tra le 5 e le 6 in modo casuale. Ogni persona entra nel bar e dopo 5 minuti esce. Se le due persone si incontrano fanno sempre a botte. Qual'è la probabilità che le due persone si incontrino?

Utilizziamo prima i minuti per dividere l'ora tra le 5 e le 6:

(define (duel iter)
  (local (x y tot)
    (setq tot 0)
    (for (i 1 iter)
      (setq x (rand 60))
      (setq y (rand 60))
      ; se y è compreso tra (x - 5) o (x + 5)
      ; allora si incontrano
      (if (<= (abs (- x y)) 5) (++ tot))
    )
    (div tot iter)))

(duel 10000000)
;-> 0.1750184

(div 10.5 60)
;-> 0.175

Utilizzando i secondi al posto dei minuti otteniamo un risultato più preciso:

(define (duel2 iter)
  (local (x y tot)
    (setq tot 0)
    (for (i 1 iter)
      (setq x (rand 3600))
      (setq y (rand 3600))
      ; se y è compreso tra (x - 300) o (x + 300)
      ; allora si incontrano
      (if (<= (abs (- x y)) 300) (++ tot))
    )
    (div tot iter)))

(duel2 10000000)
;-> 0.159961

Normalizziamo l'ora tra 0 e 1:

(define (duel3 iter)
  (local (x y tot)
    (setq tot 0)
    ; tempo di permanenza al bar
    (setq delta (div 1 12))
    (for (i 1 iter)
      (setq x (random))
      (setq y (random))
      ; se y è compreso tra (x - 1/12) o (x + 1/12)
      ; allora si incontrano
      (if (<= (abs (sub x y)) delta) (++ tot))
    )
    (div tot iter)))

(duel3 10000000)
;-> 0.1596549

Nota: il risultato matematico vale (1 - (11/12)^2) = 23/144 = 0.1597222222222222


-------------------------------
La fallacia dello scommettitore
-------------------------------

La fallacia dello scommettitore è un errore logico che riguarda l'errata convinzione che eventi occorsi nel passato influiscano su eventi futuri nell'ambito di attività governate dal caso, quali ad esempio molti giochi d'azzardo. L'espressione descrive una delle seguenti erronee convinzioni:

Un evento casuale ha "più" probabilità di verificarsi perché non si è verificato per un periodo di tempo;
Un evento casuale ha "meno" probabilità di verificarsi perché non si è verificato per un periodo di tempo;
Un evento casuale ha "più" probabilità di verificarsi perché si è verificato di recente;
Un evento casuale ha "meno" probabilità di verificarsi perché si è verificato di recente;

Quelle esposte sono convinzioni errate, comuni nel diffuso ragionare sulle probabilità, che sono state oggetto di studi molto dettagliati. Molte persone perdono soldi nei giochi d'azzardo per via di tali errate convinzioni.

In realtà, le possibilità che un qualche evento si verifichi nelle prove successive non sono necessariamente correlate con ciò che si è verificato in passato, specialmente in molti giochi d'azzardo. Tale fenomeno è noto alla teoria della probabilità come la proprietà della "mancanza di memoria".

La fallacia dello scommettitore può essere esemplificata prendendo ad esempio il ripetuto lancio di una moneta. Usando una moneta priva di irregolarità la probabilità di ottenere T=Testa è esattamente 0,5 (una su due), quella di ottenere due volte consecutive T è 0.5×0.5=0.25 (una su quattro), quella di ottenere tre volte consecutive T è 0.5×0.5×0.5= 0.125 (una su otto), e via di seguito.

Ora si supponga di avere ottenuto per quattro volte consecutive Testa. Un individuo vittima della fallacia dello scommettitore potrebbe dire, "Se la prossima volta esce Testa, si avrebbe una successione di cinque volte consecutive in cui esce Testa. La probabilità di una successione di cinque Testa consecutive è di {\displaystyle (1/2)^{5}=1/32}(1/2)^{5}=1/32; dunque, al prossimo tentativo c'è una probabilità di solo 1 su 32 che esca testa."

Questo è un ragionamento errato. Se la moneta è regolare, per definizione la probabilità che esca C=Croce deve sempre essere 0,5, mai superiore (o inferiore), e la probabilità che esca Testa deve sempre essere 0,5, mai inferiore (o superiore). Mentre la probabilità di una successione di cinque Testa consecutive è solo 1 su 32, ciò vale solo prima del primo lancio della moneta. Dopo i primi quattro lanci i risultati non sono più sconosciuti, per cui non vengono contati. La probabilità di cinque Testa consecutive è la medesima di quattro Testa consecutive seguite da una Croce. Il fatto che esca Croce non è maggiormente probabile. Infatti, il calcolo della probabilità di 1 su 32 si basava sull'assunto che Testa o Croce siano egualmente probabili in ciascuna prova. Ciascuno dei due possibili eventi ha una probabilità identica indipendentemente dal numero di volte che la moneta è stata lanciata precedentemente e indipendentemente dai risultati già verificatisi. Ritenere che nel lancio successivo sia più probabile che esca Croce piuttosto che Testa basandosi sui precedenti lanci è un errore. L'errore è nell'idea che l'essere stati fortunati in passato influenzi in qualche modo l'andamento delle prove future.

Ad esempio, la popolare strategia del "raddoppio" (cominciare con 1 €, se si perde puntare 2 €, poi 4 € ecc., finché non si vince una determinata quantità) non ha alcun senso. Con un capitale infinito si potrebbe anche avere successo usando tale strategia, avendo un capitale limitato, invece, si va incontro alla rovina.

Esempi:
1) Qual è la probabilità di ottenere 21 volte consecutive Testa, lanciando una moneta regolare? (Risposta: 1/2097152 = circa 0.000000477.) Qual è la probabilità di ottenere lo stesso risultato, dato che è già uscito 20 volte consecutive Testa? (Risposta: 0.5).

2) Una coppia ha nove figlie. Qual è la probabilità che il prossimo figlio sia un'altra femmina? (Risposta: 0.5, assumendo che il genere dei bambini sia indipendente).

3) È più probabile vincere al Lotto scegliendo gli stessi numeri tutte le volte o scegliendone di diversi ogni volta? (Risposta: Con entrambe le strategie è egualmente probabile).

3) È utile, sempre nel Lotto, affidarsi ai numeri «ritardatari»? (Risposta: è statisticamente irrilevante puntare sui numeri «ritardatari», poiché la speranza matematica è la medesima ad ogni estrazione, indipendentemente dall'esito delle estrazioni precedenti).

In molti casi si potrebbe erroneamente ritenere di poter applicare la teoria della fallacia dello scommettitore, quando in realtà questa non è applicabile:

a) Qualora la probabilità di taluni eventi è non indipendente, la probabilità di eventi futuri può variare sulla base degli eventi già verificatisi. Formalmente, in tali casi il sistema si dice essere dotato di memoria. Un esempio di questo è l'estrarre delle carte da un mazzo senza rimetterle nel mazzo dopo averle estratte. È vero che una volta che un jack è stato tolto dal mazzo, alla prossima estrazione c'è una minore probabilità di estrarre un jack e una maggiore probabilità di estrarre una carta dotata di un altro numero. Infatti, la probabilità di estrarre un jack, assumendo che questa sia stata la prima carta estratta e che nel mazzo non ci siano jolly è scesa da 4/52 (7.69%) a 3/51 (5.88%), mentre la probabilità che si estragga una carta appartenente ad un altro numero è salita da 4/52 (7.69%) a 4/51 (7.84%). Ma ciò è perché la prova (l'estrazione della carta) ha alterato lo stato del sistema (il mazzo).

b) Quando la probabilità di ciascuno degli eventi possibili è irregolare. Ad esempio con un dado truccato un numero che è uscito più frequentemente in passato può sicuramente continuare ad essere più frequente degli altri, se il fatto che esca tale numero è reso più probabile da pesi presenti nel dado. Tale circostanza è stata denominata Nerd's Gullibility Fallacy - ossia l'assumere che la moneta sia regolare e che i giocatori siano onesti quando nella realtà non è così. Questo è un esempio del principio di Hume: se esce venti volte consecutive croce è più probabile che la moneta sia truccata, piuttosto che non lo sia e che al prossimo lancio si abbia un'eguale probabilità che esca testa o croce. Il Chernoff bound può essere utilizzato per determinare quante volte una moneta deve essere lanciata per individuare (con alta probabilità) quale dei due lati è truccato.

c) La probabilità di eventi futuri può variare in funzione di fattori esterni che abbiano influenza sulla probabilità stessa (ad esempio, la modifica delle regole di uno sport che influisce sulla performance di una squadra). Come esempio aggiuntivo, uno sportivo esordiente può vedere minacciato il proprio successo se la squadra avversa ne scopre i punti deboli e li sfrutta. Il giocatore può in questo caso cercare di compensare questo svantaggio rendendo casuale la propria strategia, sulla base di quanto insegnato dalla teoria dei giochi.

Vediamo una funzione che simula la strategia del "raddoppio" (Martingala). La funzione prende tre parametri, il numero di monete iniziali, il guadagno che vogliamo ottenere per smettere, e il numero di prove che vogliamo ripetere. L'output è una lista che contiene i risultati di tutte le prove.

(define (raddoppio monete guadagno prove)
  (local (actual posta res out)
    (seed (time-of-day))
    (setq out '())
    (for (i 1 prove)
      (setq actual monete)
      (setq posta 1)
      ; giochiamo finchè non andiamo in rovina
      ; o guadagniamo almeno "guadagno" monete...
      (until (or (<= actual 0) (>= actual (+ monete guadagno)))
        (setq res (rand 2))
        (cond ((zero? res)
               (setq actual (- actual posta))
               (setq posta (* posta 2))
              )
              (true
               (setq actual (+ actual posta))
               (setq posta 1)
              )
        )
        ;(println res { } actual { } posta) (read-line)
      )
      (if (<= actual 0)
          ; perdita delle monete + actual
          (push (+ actual (- monete)) out -1)
          ; vincita di actual - monete
          (push (- actual monete) out -1)
      )
      ;(println out) (read-line)
    )
    out))

Simuliamo 10 partite con 1000 monete e un guadagno di 1000 monete:

(raddoppio 1000 1000 10)
;-> (-1586 -1870 1000 -1160 -1760 -1295 1000 1000 -1798 -1493)

Proviamo con 10 monete e un guadagno di 10 monete:

(raddoppio 10 10 100)
;-> (10 10 -12 10 -10 -23 10 -13 10 -15 10 -14 10 -11 10 10 10 -13 -14 10
;->  10 -15 10 -12 10 10 10 10 10 10 -23 -11 -24 -23 10 -12 -15 -23 10 -22
;->  10 10 10 -11 10 10 10 -13 10 10 10 10 10 -11 10 -15 10 -10 -15 10 10
;->  10 10 10 -25 -15 10 -15 10 -23 -14 10 10 10 -15 10 10 10 10 -23 10 10
;->  10 10 -12 10 -12 10 10 10 -14 -15 10 10 10 10 10 10 -15 -12)

Proviamo con 10 monete e un guadagno di 100 monete:

(raddoppio 10 100 100)
;-> (-65 -14 -11 -15 100 -55 -14 100 -14 -13 -30 100 -11 -15 -19 -70 -13
;->  100 -23 100 100 -10 -14 100 -10 100 -12 100 100 -51 -13 -15 -13 100
;->  -15 -19 -13 100 -10 -14 100 -72 -21 -16 -12 100 -20 -41 -16 -10 -11
;->  -27 -14 -13 -24 100 -10 -11 -21 -17 100 -15 -12 -11 100 -15 -14 -33
;->  -12 100 -10 -20 100 -13 -10 -39 -13 -25 -13 -27 100 100 -38 -36 -73
;->  100 -41 -14 -11 -30 -12 -10 -12 -12 -10 -47 100 -20 -13 -25)

Vediamo alcuni risultati totali:

(apply + (raddoppio 10 50 100))
;-> -153
(apply + (raddoppio 10 50 100))
;-> -385
(apply + (raddoppio 10 50 100))
;-> 292

Con questo metodo, se le probabilità sono le stesse per entrambi gli eventi positivo e negativo, si vince e si perde, ma bisogna avere un conto illimitato per far fronte alle perdite

Nota: poichè in tutti i casinò viene stabilito un limite alla puntata, questo metodo non è utilizzabile.


--------------------------------------------------
La rovina del giocatore d'azzardo (Gambler's ruin)
--------------------------------------------------

Il termine "rovina del giocatore d'azzardo" è un concetto statistico, che stabilisce la certezza del fallimento di un giocatore d'azzardo in un gioco con un valore atteso negativo (indipendentemente dal suo sistema di scommesse).

Il concetto vale anche per un giocatore d'azzardo ostinato che aumenta la propria scommessa a una frazione fissa del proprio conto dopo una vincita, ma non la riduce dopo una perdita. Anche questo giocatore alla fine e inevitabilmente andrà in bancarotta, anche se ogni scommessa ha un valore atteso positivo.

Un altro significato comune è che un giocatore d'azzardo ostinato con conto finito, giocando un gioco equo (cioè, ogni scommessa ha un valore atteso zero per entrambe le parti) finirà inevitabilmente in bancarotta contro un avversario con conto infinita.

Nota: Una tale situazione può essere simulata con una passeggiata aleatoria sulla retta dei numeri interi. In questo caso è probabile che l'agente ritorni, con virtuale certezza, al suo punto di origine, il che significa fallire, e questo accade un numero infinito di volte se le passeggiate continuano per sempre.

Il teorema generale è stato pubblicato da Christian Huygens in "De ratiociniis in ludo aleae" ("Sul ragionamento nei giochi d'azzardo", 1657) e mostra come calcolare la probabilità che ogni giocatore ha di vincere una serie di scommesse che continuano fino a perdere l'intero conto iniziale.

Problema originale
Ogni giocatore inizia con 12 punti, e un tiro riuscito dei tre dadi per un giocatore (ottenendo un 11 per il primo giocatore o un 14 per il secondo) aggiunge uno al punteggio di quel giocatore e sottrae uno dal punteggio di un altro giocatore. Il perdente del gioco è il primo a raggiungere zero punti. Qual è la probabilità di vittoria per ogni giocatore?

Questa è la classica formulazione della rovina del giocatore d'azzardo: due giocatori iniziano con puntate fisse, trasferendo punti fino a quando l'uno o l'altro viene "rovinato" arrivando a zero punti.

Il giocatore che gioca una partita equo (con 0.5 probabilità di vincita) finirà per fallire o raddoppierà la sua ricchezza.
Definiamo che il gioco finisce per entrambi gli eventi. Questi eventi sono ugualmente probabili, altrimenti il ​​gioco non sarebbe equo. Quindi ha una probabilità di 0.5 di fallire prima di raddoppiare i suoi soldi. Se raddoppia i suoi soldi, inizia un nuovo gioco e ha ancora una possibilità di 0.5 di raddoppiare i suoi soldi prima di fallire. Dopo il secondo gioco c'è una possibilità 1/2 * 1/2 che non sia andato in rovina nel primo e nel secondo gioco. Continuando in questo modo, la sua possibilità di non andare in rovina dopo n partite successive è 1/2 * 1/2 * 1/2 * ... * 1/2^n che si avvicina a 0. La sua possibilità di fallire dopo n partite consecutive è 0.5 + 0.25 + 0.125 + . . . 1 - 1/2^n che si avvicina a 1

Nel caso di un giocatore che gioca una partita con un valore atteso negativo, il suo risultato non può essere migliore di quello del giocatore in una partita equa, quindi anche lui andrà in rovina.

Esempio: lancio di una moneta equa
----------------------------------
Considera il lancio di una moneta con due giocatori in cui ogni giocatore ha una probabilità del 50% di vincere ad ogni lancio della moneta. Dopo ogni lancio il perdente trasferisce una moneta al vincitore. Il gioco termina quando un giocatore ha tutte le monete (ovvero un giocatore ha zero monete "ruined").

Se non ci sono altre limitazioni al numero di lanci, la probabilità che il gioco finisca in questo modo è 1. (Intutitivamente: per vincere tutte le monete deve verificarsi una certa sequenza di teste e croci. La probabilità che non si verifichi questa sequenza è alta all'inizio, ma decade in modo esponenziale e quindi, primo o poi, la sequenza apparirà.

Se il giocatore 1 ha x monete e il giocatore 2 ha y monete, le probabilità P1 e P2 che i giocatori finiscano senza una moneta sono:

         y
P1 = ---------
      (x + y)

         x
P2 = ---------
      (x + y)

Vediamo il caso in cui i due giocatori hanno la stessa quantita di monete (x = y = 10):

P1 = 10/20 = 1/2
P2 = 10/20 = 1/2

In questo caso i due giocatori hanno le stesse probabilità di vittoria

Adesso il caso in cui un giocatore ha un amggior numero di monete dell'altro (x = 10 y = 5):

P1 = 10/15 = 2/3 = 0.6666666666...
P2 = 5/15 = 1/3 = 0.3333333333...

In questo caso il giocatore con più monete ha una probabilità maggiore di vincita.

Esempio: lancio di una moneta non-equa
--------------------------------------
Nel caso di una moneta non-equa, in cui il giocatore 1 vince ogni lancio con probabilità p e il giocatore 2 vince con probabilità q = 1 − p, allora le probabilità che i giocatori finiscano le proprie monete valgono:

        1 - (p/q)^y
P1 = -----------------
      1 - (p/q)^(x+y)

        1 - (q/p)^x
P2 = -----------------
      1 - (q/p)^(x+y)

(define (prob p q x y)
  (local (v1 v2)
    (setq v1 (div (sub 1 (pow (div p q) y))
                  (sub 1 (pow (div p q) (add x y)))))
    (setq v2 (div (sub 1 (pow (div q p) x))
                  (sub 1 (pow (div q p) (add x y)))))
    (list v1 v2)))

Nota: quando p = q, allora la moneta è equa.

Se le probabilità di vittoria del gioco (p e q) sono quasi uguali, allora la probabilità di finire in rovina è la stessa (quasi) per entrambi i giocatori (anche le monete devono essere le stesse):

(prob 0.500000001 0.499999999 10 10)
;-> (0.4999999888977704 0.5000000104083413)

Altrimenti il giocatore più sfortunato finisce il rovina facilmente:

(prob 0.6 0.4 10 10)
;-> (0.01704592745492985 0.9829540725450702)

(prob 0.7 0.3 10 10)
;-> (0.0002089976346871697 0.9997910023653129)

Facciamo delle simulazioni in cui il giocatore più sfortunato ha molte più monete dell'altro:

(prob 0.7 0.3 1 100)
;-> (0.4285714285714286 0.5714285714285714)
(prob 0.7 0.3 5 100)
;-> (0.01445826143868625 0.9855417385613138)
(prob 0.7 0.3 10 100)
;-> (0.0002090413238294019 0.9997909586761706)


--------
Roulette
--------

La roulette francese ha 37 numeri (da 0 a 36), di cui 18 sono rossi e 18 sono neri. Lo zero è verde.
Un giocatore ha una certa quantità di monete e può scegliere tra due strategie di gioco:
1) puntare tutte le monete sul rosso con una sola giocata (e perdere tutto o guadagnare il doppio)
2) puntare 1 moneta per ogni giocata sul rosso e fermarsi quando non ha più monete oppure quando ha il doppio delle monete iniziali.
Quale strategia è quella migliore?

Nel primo caso la probabilità di vincita vale:

           casi favorevoli     18
P(win) = ------------------ = ---- = ;-> 0.4864864864864865
           casi possibili      37

Per la seconda strategia scriviamo una funzione di simulazione:

(define (roulette money iter)
  (local (actual win lose)
    (for (i 1 iter)
      (setq actual money)
      (until (or (zero? actual) (= (* 2 money) actual))
        (if (> (rand 37) 18)
            (++ actual)
            (-- actual)
        )
      )
      (if (zero? actual)
          (++ lose)
          (++ win)
      )
      ;(println win { } lose { } iter)
    )
    (div win iter)))

Per verificare la correttezza della funzione possiamo giocare con una sola moneta e quindi, in media, dovremmo ottenere le stesse probabilità della prima strategia:

(roulette 1 10000000)
;-> 0.4867276

che è corretto, perchè risulta:

(div 18 37)
;-> 0.4864864864864865

Adesso simuliamo di giocare con un numero crescente di monete iniziali:

(roulette 2 100000)
;-> 0.47132
(roulette 5 100000)
;-> 0.43458
(roulette 10 100000)
;-> 0.36605
(roulette 20 100000)
;-> 0.25414
(roulette 50 100000)
;-> 0.06164

Come si nota, all'aumentare delle monete iniziali, diminuisce la probabilità di vincita. Questo è un risultato che deriva dal concetto statistico "la rovina del giocatore d'azzardo" (Gambler's ruin).


-----------------------------
Separazione dei numeri uguali
-----------------------------

Data una lista di numeri interi compresi tra 1 e 100 non necessariamente distinti, ordinare la lista in modo che gli eventuali elementi uguali non siano contigui (cioè non devono essere uno di seguito all'altro).

L'algoritmo è il seguente:
1) trovare il numero più frequente f
2) inserire il numero nelle posizioni/indici pari (0,2,4,...)
3) per gli elementi rimanenti, inserire ancora i numeri a intervalli, ma adesso non è importante quale numero inserire per primo (la funzione inserisce i restanti gruppi in ordine decrescente di frequenza).

In altre parole, trovare l'elemento più frequente e metterlo nelle posizioni pari, quindi mettere il resto dei gruppi di elementi in qualsiasi ordine.

Per esempio:
lista = (1 1 2 2 2 2 2 3 4)
frequenze = (5 2) (2 1) (1 3) (1 4)

Inserimento dei 5 numeri 2: (2 – 2 – 2 – 2 – 2)
Inserimento dei 2 numeri 1: (2 1 2 1 2 – 2 – 2)
Inserimento dell'unico 3:   (2 1 2 1 2 3 2 – 2)
Inserimento dell'unico 4:   (2 1 2 1 2 3 2 4 2)

se iniziamo con qualsiasi altro gruppo invece dei cinque numeri 2 (ad esempio con i due numeri 1), avremo:

(1 - 1 - - - - - -)
(1 2 1 2 - 2 - 2 -) finita la lista dobbiamo inserire il quinto due...
(1 2 1 2 2 2 - 2 -) che è sbagliato.

(define (separa lst)
  (local (len freqs max-f max-v out idx)
    (setq len (length lst))
    (setq freqs (array 101 '(0)))
    (setq max-f 0)
    (setq max-v 0)
    (dolist (el lst)
      ; aggiorna la frequenza di el
      (++ (freqs el))
      ; aggiorna il valore del numero più frequente
      (if (> (freqs el) max-f)
          (set 'max-f (freqs el) 'max-v el)
      )
    )
    ;(println freqs { } max-f { } max-v)
    ; controllo sull'esistenza di una soluzione
    (cond ((odd? len)
          (if (> max-f (+ 1 (/ len 2))) (println "impossibile")))
          ((even? len)
          (if (>= max-f (+ 1 (/ len 2))) (println "impossibile")))
    )
    (setq out (array len '(0)))
    (setq idx 0)
    ; inserimento gruppo di elementi con maggiore frequenza
    (while (> (freqs max-v) 0)
      (-- (freqs max-v))
      (setf (out idx) max-v)
      ; inserisce prima gli indici pari
      ; quando sono finiti usa quelli dispari
      (if (>= (+ idx 2) len)
          (setq idx 1)
          (setq idx (+ idx 2))
      )
    )
    ; inserimento dei rimanenti gruppi di elementi
    ; con frequenza decrescente
    (for (k 1 (- (length freqs) 1))
      (while (> (freqs k) 0)
        (-- (freqs k))
        (setf (out idx) k)
        ; inserisce prima gli indici pari
        ; quando sono finiti usa quelli dispari
        (if (>= (+ idx 2) len)
          (setq idx 1)
          (setq idx (+ idx 2))
        )
      )
    )
    out))

(separa '(1 2 1 2 1 2 3 3))
;-> (1 2 1 2 1 3 2 3)
(separa '(2 2 1 1))
;-> (2 1 2 1)

La funzione riconosce quando è impossibile separare i numeri, ma produce lo stesso una risposta:

(separa '(2 2 1 1 1 1))
;-> impossibile
;-> (1 1 1 2 1 2)
(separa '(1 1 1 1 2))
;-> impossibile
;-> (1 1 1 2 1)


-------------------
Spezzare un bastone
-------------------

Dato un bastone di lunghezza L dividerlo in 3 pezzi e determinare la loro lunghezza media.

Cerchiamo di risolvere il problema con una simulazione di tipo MonteCarlo.

(define (pair-func lst func rev)
"Produces a list applying a function to each pair of elements of a list"
      (if rev
          (map func (chop lst) (rest lst))
          (map func (rest lst) (chop lst))))

(pair-func '(1 4 7 8 10 12) -)
;-> (3 3 1 2 2)

Adesso scriviamo la funzione che spezza un segmento da 0 a 1 in in un certo numero di pezzi:

(define (break-line num-seg)
  (local (rnd segs)
    (setq rnd '())
    ; genera i numeri casuali tra 0 e 1
    ; ma scartiamo 0 e 1 perchè
    ; non rappresentano una "spezzatura"
    (while (< (length rnd) (- num-seg 1))
      (push (random) rnd -1)
    )
    ;(println rnd)
    ; calcola la lunghezza dei segmenti
    (setq segs (pair-func (sort rnd) sub))
    ; aggiunge la lunghezza del primo segmento
    (push (rnd 0) segs)
    ; aggiunge la lunghezza dell'ultimo segmento
    (push (sub 1 (rnd -1)) segs -1)
    ; ordina le lunghezze dei segmenti
    (sort segs)))

(setq t (break-line 3))
;-> (0.1974852748191778 0.2756431775872067 0.5268715475936155)

La somma delle lunghezze di tutti i segmenti spezzati deve valere 1:

(apply add t)
;-> 1

Adesso scriviamo la funzione di simulazione:

(define (test num-seg iter)
  (local (tot)
    (setq tot (dup 0 num-seg))
    (for (i 1 iter)
      (setq tot (map add tot (break-line num-seg)))
      ;(println tot) (read-line)
    )
    ; calcola la lunghezza media di tutti i segmenti
    (map (fn(x) (div x iter)) tot)))

Facciamo alcune prove:

(test 3 100000)
;-> (0.1113972692037817 0.2779632947782865 0.6106394360179404)
(test 5 100000)
;-> (0.04023883785515883 0.09053392132328156 0.1578873256630123 0.2551521042512249 0.4561878109073145)

Dal punto di vista matematico risulta che le lunghezze dei vari segmenti hanno, in media, i seguenti valori:

il più piccolo (1/n) * (1/n)
il secondo     (1/n) * (1/n + 1/(n-1))
il terzo       (1/n) * (1/n + 1/(n-1) + 1/(n-2))
...
il più grande  (1/n) * (1/n + 1/(n-1) + 1/(n-2) + ... + 1/(n - (n-1)))

Definiamo una funzione che calcola i valori matematici:

(define (theory ns)
  (setq out '())
  (for (k 1 ns)
    (setq val 0)
    (for (i 0 (- k 1))
      (setq val (add val (div (sub ns i))))
    )
    (push (mul (div ns) val) out -1)
  )
  out)

Facciamo alcune verifiche:

(theory 3)
;-> (0.1111111111111111 0.2777777777777777 0.6111111111111111)
(theory 5)
;-> (0.04 0.09 0.1566666666666667 0.2566666666666667 0.4566666666666667)

Calcoliamo il massimo errore tra la simulazione (10000 prove) e la formula teorica con 100 segmenti:

(apply max (map sub (test 100 10000) (theory 100)))
;-> 7.495372768848152e-005

I valori teorici e quelli simulati concordano.


---------------------
Modello  di Ehrenfest
---------------------

Il modello di Ehrenfest della diffusione fu proposto da Tatiana e Paul Ehrenfest nel 1907 per spiegare il secondo principio della termodinamica. È un esempio di catena di Markov.

Il modello è costituito da N particelle in due contenitori.

Ad ogni istante t=1,2,... una particella viene scelta a caso (ogni particella ha una probabilità 1/N di essere scelta) e spostata nell'altro contenitore.

Sia X(t) la variabile aleatoria che rappresenta il numero di particelle in uno dei due contenitori al tempo t.

Il sistema evolve secondo la probabilità di transizione p(i j):

         | 1 - i/N  se i = j + 1
p(i j) = | i/N      se i = j - 1
         | 0        altrimenti

Possiamo simulare questo processo con due urne contenenti N palline ciascuna (all'istante t = 0). La prima urna contiene tutte palline bianche. La seconda urna contiene tutte palline nere. Ad ogni istante successivo (t = 1,2,3,...) una pallina viene sezionata casualmente da ogni urna e messa nell'altra urna.
La distribuzione delle palline si stabilizza dopo un certo numero di istanti di tempo?
In caso affermativo, a che valore medio si stabilizza?

Funzione che simula il processo di Ehrenfest:

(define (ehrenfest numA numB iter)
  (local (A B res)
    (setq res '())
    (setq A (dup 'a numA))
    (setq B (dup 'b numB))
    (for (i 1 iter)
      ; select random indexes
      (setq idx-a (rand numA))
      (setq idx-b (rand numB))
      ; find colors of selected balls
      (setq col-a (A idx-a))
      (setq col-b (B idx-b))
      ; exchange balls (first remove, then add)
      (pop A idx-a)
      (pop B idx-b)
      (push col-a B -1)
      (push col-b A -1)
      ; update ball count list
      (push (first (count '(a) A)) res -1)
      ;(println A)
      ;(println B)
    )
    (println (count '(a b) A))
    (println (count '(a b) B))
    ; create a list of points
    (map (fn(x) (list (+ $idx 1) x)) res)))

Funzione per esportare una lista in un file:

(define (list-csv lst file-str sepchar)
"Creates a file csv from a list"
  (local (outfile)
    (if (nil? sepchar)
        (setq sepchar ",")
    )
    (setq outfile (open file-str "write"))
    ;(println "file: " outfile)
    (dolist (el lst)
      (setq line (join (map string el) sepchar))
      ;(println line { } outfile) (read-line)
      (write-line outfile line)
    )
    (print outfile { })
    (close outfile)))

Creiamo due simulazioni con i relativi punti:

(list-csv (setq urne (ehrenfest 20 20 500)) "erhe.csv")
;-> (13 7)
;-> (7 13)
;-> 3 true

(list-csv (setq urne2 (ehrenfest 1000 1000 10000)) "erhe2.csv" ";")
;-> (486 514)
;-> (514 486)
;-> 3 true

In entrambi i casi, dopo un certo numero di iterazioni, il valore delle palline oscilla intorno alla metà delle palline iniziali (partendo con le due urne che contengono con lo stesso numero di palline).

I grafici ottenuti con questi punti sono nel file "ehrenfest.png" nella cartella "data".

Vediamo cosa accade se le urne contengono inizialmente un numero diverso di palline:

(setq urne (ehrenfest 100 50 1000))
;-> (74 26)
;-> (26 24)

(silent (setq urne (ehrenfest 1000 100 10000)))
;-> (910 90)
;-> (90 10)


--------------------
Modello di Ehrenfest
--------------------

Il modello di Ehrenfest della diffusione fu proposto da Tatiana e Paul Ehrenfest nel 1907 per spiegare il secondo principio della termodinamica. È un esempio di catena di Markov.

Il modello è costituito da N particelle in due contenitori.

Ad ogni istante t=1,2,... una particella viene scelta a caso (ogni particella ha una probabilità 1/N di essere scelta) e spostata nell'altro contenitore.

Sia X(t) la variabile aleatoria che rappresenta il numero di particelle in uno dei due contenitori al tempo t.

Il sistema evolve secondo la probabilità di transizione p(i j):

         | 1 - i/N  se i = j + 1
p(i j) = | i/N      se i = j - 1
         | 0        altrimenti

Possiamo simulare questo processo con due urne contenenti N palline ciascuna (all'istante t = 0). La prima urna contiene tutte palline bianche. La seconda urna contiene tutte palline nere. Ad ogni istante successivo (t = 1,2,3,...) una pallina viene sezionata casualmente da ogni urna e messa nell'altra urna.
La distribuzione delle palline si stabilizza dopo un certo numero di istanti di tempo?
In caso affermativo, a che valore medio si stabilizza?

Funzione che simula il processo di Ehrenfest:

(define (ehrenfest numA numB iter)
  (local (A B res)
    (setq res '())
    (setq A (dup 'a numA))
    (setq B (dup 'b numB))
    (for (i 1 iter)
      ; select random indexes
      (setq idx-a (rand numA))
      (setq idx-b (rand numB))
      ; find colors of selected balls
      (setq col-a (A idx-a))
      (setq col-b (B idx-b))
      ; exchange balls (first remove, then add)
      (pop A idx-a)
      (pop B idx-b)
      (push col-a B -1)
      (push col-b A -1)
      ; update ball count list
      (push (first (count '(a) A)) res -1)
      ;(println A)
      ;(println B)
    )
    (println (count '(a b) A))
    (println (count '(a b) B))
    ; create a list of points
    (map (fn(x) (list (+ $idx 1) x)) res)))

Funzione per esportare una lista in un file:

(define (list-csv lst file-str sepchar)
"Creates a file csv from a list"
  (local (outfile)
    (if (nil? sepchar)
        (setq sepchar ",")
    )
    (setq outfile (open file-str "write"))
    ;(println "file: " outfile)
    (dolist (el lst)
      (setq line (join (map string el) sepchar))
      ;(println line { } outfile) (read-line)
      (write-line outfile line)
    )
    (print outfile { })
    (close outfile)))

Creiamo due simulazioni con i relativi punti:

(list-csv (setq urne (ehrenfest 20 20 500)) "erhe.csv")
;-> (13 7)
;-> (7 13)
;-> 3 true

(list-csv (setq urne2 (ehrenfest 1000 1000 10000)) "erhe2.csv" ";")
;-> (486 514)
;-> (514 486)
;-> 3 true

In entrambi i casi, dopo un certo numero di iterazioni, il valore delle palline oscilla intorno alla metà delle palline iniziali ( partendo con le due urne che contengono con lo stesso numero di palline).

I grafici ottenuti con questi punti sono nel file "ehrenfest.png" nella cartella "data".

Vediamo cosa accade se le urne contengono inizialmente un numero diverso di palline:

(setq urne (ehrenfest 100 50 1000))
;-> (74 26)
;-> (26 24)

(setq urne (ehrenfest 1000 100 10000))
;-> (910 90)
;-> (90 10)


--------------------------
Media delle corrispondenze
--------------------------

Due mazzi di carte uguali con N carte ciascuno. Dopo aver mischiato bene i due mazzi, prendiamo la prima carta dal primo mazzo e la prima carta del secondo mazzo e le confrontiamo, se sono uguali abbiamo una corrispondenza. Poi continuiamo con le seconde carte del mazzo, confrontiamo e andiamo avanti fino alla fine dei due mazzi.
Quante corrispondenze, in media, ci aspettiamo?

La probabilità che due carte siano uguali vale 1/N, poichè facciamo N tentativi, allora il valore medio delle corrispondeze vale:
  Media = (1/N)*N = 1

Possiamo effettuare la simulazione nel modo seguente:
Usiamo due liste con N elementi ciascuna
"Mischiamo" i valori di ogni lista.
Contiamo quanti sono i valori uguali delle due liste che hanno lo stesso indice.

(define (check num)
    (first (count '(true) (map =
           (randomize (sequence 1 num)) (randomize (sequence 1 num))))))

(check 100)
;-> 0
(check 100)
;-> 2

Scriviamo la funzione che effettua la simulazione per un determinato numero di volte:

(define (test num iter)
  (let (tot 0)
    (for (i 1 iter)
      (setq tot (+ tot (check num)))
    )
    (div tot iter)))

Facciamo alcune prove:

(test 40 10000)
;-> 1.0053

(test 52 10000)
;-> 1.0033

(test 1000 10000)
;-> 1.0105

(time (println (test 2000 100000)))
;-> 1.00234
;-> 34366.847 ; 34 secondi

Nota: esistono diversi problemi equivalenti:
1) Imbustare a caso N lettere in N buste
2) Scegliere a caso N cappelli per gli N proprietari
eccetera

Si può dimostrare, ma non proprio facilmente, che la probabilità di k corrispondenze vale:

                                                             (-1)^(n-k)
  P(k|N) = 1/k! * (1/0! - 1/1! + 1/2! - 1/3! + 1/4! - ... + ------------
                                                              (n - k)!

Quando (N - r) è abbastanza grande, l'espressione tra parentesi contiene parecchi termini della serie di e^(-1), quindi possiamo approssimare la formula:

  P(k) ≈ (1/k!)* e^(-1), per (n - k) grande.

Per la dimostrazione vedi "Fifty Challenging Problems in Probability with Solutions" di Frederick Mosteller, Dover, 1965.


-----------------------------------------------------------------------
Media delle percentuali dei valori = Percentuale della media dei valori
-----------------------------------------------------------------------

Dato un valore V e una lista di numeri, vogliamo sapere se la media delle percentuali dei valori è uguale alla percentuale della media dei valori. Facciamo una prova:

Valore = 200
numeri = 102, 110, 88, 120, 60

(setq val 200)
(setq a '(102 110 88 120 60))

Calcolo della media delle percentuali:
(setq a% (map (fn(x) (div x val)) a))
;-> (0.51 0.55 0.44 0.6 0.3)
(setq media% (div (apply add a%) (length a%)))
;-> 0.48

Calcolo della percentuale della media:
(setq a-med (div (apply add a) (length a)))
;-> 96
(setq perc-med (div a-med val))
;-> 0.48

Scriviamo una funzione per la verifica:

(define (qed val nums)
  (local (nums% media% nums-media perc-media)
    ; calcolo della media delle percentuali
    (setq nums% (map (fn(x) (div x val)) nums))
    (setq media% (div (apply add nums%) (length nums%)))
    ; calcolo della percentuale della media
    (setq nums-media (div (apply add nums) (length nums)))
    (setq perc-media (div nums-media val))
    (list media% perc-media)))

(qed 133 '(24 346 -36 10))
;-> (0.6466165413533835 0.6466165413533834)

(qed 236 '(12 -58 -39 16))
;-> (-0.07309322033898306 -0.07309322033898305)

Esempio algebrico:

val = v
nums = n1, n2, n3

media-perc = (n1/v + n2/v + n3/v)/3
perc-medie = ((n1 + n2 + n3)/3)/v 


------------
Quanti sono?
------------

Una persona ferma sul ciglio della strada guarda una corsa campestre. Vede passare 6 concorrenti con i seguenti numeri 5, 10, 35 42, 63, 21. Quanti sono, presumibilmente, gli N partecipanti alla corsa?

Si può dimostrare che la media (valore atteso) del valore massimo di una serie (X1, X2, ...Xn) abbastanza ampia di n elementi osservati è data da:

                n*(N + 1)
  max(X(i)) = -------------
                 (n + 1)

Se poniamo max(X(i)) = max(n), cioè supponiamo che il valore atteso sia uguale al valore massimo osservato, allora possiamo stimare il numero risulta:

             n*(N + 1)              (n + 1)
  max(n) = -------------  ==>  N = ---------*max(n) - 1
              (n + 1)                  n

Scriviamo una funzione per calcolare questo valore e facciamo alcune prove.

(define (stima lst)
  (let (oss (length lst))
    (sub (div (mul (add oss 1) (apply max lst)) oss) 1)))

(stima '(5 10 35 42 63 21))
;-> 72.5

Facciamo alcune considerazioni:

1) il valore massimo osservato in qualsiasi campione di dimensione n deve essere almeno n, quindi la stima per N deve essere almeno:

  (n + 1)
  -------*n - 1 = n
     n

cioè, la stima per N non può mai essere inferiore al valore più grande osservato.

2) se il numero n di campioni osservati vale N (cioè abbiamo visto tutti i campioni), allora la stima per N dovrebbe essere esatta (perchè in questo caso abbiamo sicuramente osservato il valore massimo N):

   (N + 1)
  ---------*N - 1 = N
      N

Comunque la nostra stima compie errori grossolani per alcune liste di osservazione. Per esempio:

a) con N=800 e lst=(1 2 3 4 5), la nostra stima vale N = 5 (troppo bassa)
b) con N=800 e lst=(1 2 3 4 800), la nostra stima vale N = 959 (troppo alta)

Quindi vogliamo sapere quanto è "precisa" la formula della stima. Per fare questo usiamo una simulazione.

Per un determinato valore di N calcoliamo tante (iter) volte la stima (Ncalc) e il relativo errore percentuale (err%) e infine  calcoliamo l'errore percentuale medio. Questo viene fatto partendo da una percentuale (step) di elementi osservati e aumentando il passo dello stesso valore (step) fino a raggiungere il 100% degli elementi osservati. Alla fine avremo una lista di coppie: "percentuali di elementi selezionati" e il relativo "errore percentuale medio".

(define (test N step iter)
  (local (ele num-oss sum-err% oss Ncalc med-err% out)
    ; lista di tutti gli elementi
    (setq ele (sequence 1 N))
    ; per ogni valore di percentuale...
    (for (perc step 100 step)
      ; calcola il numero di osservazioni
      (setq num-oss (int (mul (div N 100) perc)))
      ;(println num-oss)
      ; azzera la somma degli errori percentuali
      (setq sum-err% 0)
      (for (i 1 iter)
        ; seleziona gli elementi osservati
        (setq oss (slice (randomize ele) 0 num-oss))
        ; calcola il valore atteso
        (setq Ncalc (stima oss))
        ; calcola errore percentuale corrente
        ; (valore assoluto, altrimenti si potrebbero elidere)
        (setq err% (div (abs (sub Ncalc N)) N))
        ;(setq err% (div (sub Ncalc N) N))
        ; aggiorna la somma degli errori percentuali
        (setq sum-err% (add sum-err% err%))
        ;(println oss { } Ncalc { } err% { } sum-err%)
      )
      ; calcola errore medio percentuale
      (setq med-err% (round (mul 100 (div sum-err% iter)) -3))
      ; inserisce una coppia di valori nella lista di output
      ; (%-osservati errore-percentuale-medio)
      (push (list perc med-err%) out -1)
    )
    out))

Facciamo alcune prove.

1) 100 elementi - passo 2% - 2 prove
(setq a1 (test 100 2 2))
;-> ((2 22.75) (4 9) (6 6.5) (8 9.875) (10 5.7) (12 1.917) (14 4) (16 2.656)
;->  (18 4.417) (20 2.425) (22 2.205) (24 3.646) (26 2.327) (28 2.054)
;->  (30 4.9) (32 1.547) (34 2.059) (36 1.264) (38 1.539) (40 0.512)
;->  (42 0.869) (44 0.511) (46 0.663) (48 0.573) (50 0.51) (52 0.51)
;->  (54 0.509) (56 0.786) (58 0.724) (60 0.667) (62 0.508) (64 0.563)
;->  (66 0.515) (68 0.471) (70 0.429) (72 0.389) (74 0.351) (76 0.507)
;->  (78 0.282) (80 0.25) (82 0.22) (84 0.506) (86 0.163) (88 0.136)
;->  (90 0.111) (92 0.087) (94 0.064) (96 0.042) (98 0.02) (100 0))

2) 100 elementi - passo 2% - 10 prove
(setq a2 (test 100 2 10))
;-> ((2 31.7) (4 16.925) (6 9.183) (8 11.213) (10 5.59) (12 7.1) (14 5.186)
;->  (16 3.506) (18 4.856) (20 2.965) (22 3.659) (24 3.238) (26 2.75)
;->  (28 1.964) (30 1.553) (32 2.203) (34 1.988) (36 2.158) (38 1.437)
;->  (40 1.53) (42 0.931) (44 1.123) (46 1.185) (48 1.237) (50 0.706)
;->  (52 1.083) (54 1.257) (56 0.611) (58 1.134) (60 0.642) (62 0.795)
;->  (64 0.631) (66 0.508) (68 0.601) (70 0.546) (72 0.585) (74 0.382)
;->  (76 0.671) (78 0.417) (80 0.455) (82 0.277) (84 0.254) (86 0.231)
;->  (88 0.21) (90 0.111) (92 0.171) (94 0.152) (96 0.227) (98 0.117)
;->  (100 0)))

3) 100 elementi - passo 2% - 100 prove
(setq a3 (test 100 2 100))
(setq aa (test 1000 2 2))
;-> ((2 29.235) (4 17.297) (6 12.432) (8 8.725) (10 7.376) (12 4.889) (14 4.743)
;->  (16 4.371) (18 3.652) (20 3.008) (22 3.484) (24 2.949) (26 2.504) (28 2.471)
;->  (30 2.059) (32 1.86) (34 1.717) (36 1.671) (38 1.462) (40 1.75) (42 1.48)
;->  (44 1.261) (46 1.286) (48 1.061) (50 1.007) (52 0.95) (54 0.927) (56 0.834)
;->  (58 0.697) (60 0.794) (62 0.637) (64 0.703) (66 0.623) (68 0.646) (70 0.659)
;->  (72 0.655) (74 0.519) (76 0.505) (78 0.436) (80 0.368) (82 0.361) (84 0.371)
;->  (86 0.272) (88 0.267) (90 0.214) (92 0.162) (94 0.099) (96 0.107) (98 0.02)
;->  (100 0))

4) 1000 elementi - passo 10% - 2 prove
(setq a4 (test 1000 10 2))
;-> ((10 0.959) (20 0.253) (30 0.1) (40 0.1) (50 0.201)
;->  (60 0.05) (70 0.1) (80 0.025) (90 0.011) (100 0))

5) 1000 elementi - passo 10% - 10 prove
(setq a5 (test 1000 10 10))
;-> ((10 0.645) (20 0.25) (30 0.248) (40 0.2) (50 0.1)
;->  (60 0.067) (70 0.047) (80 0.03) (90 0.011) (100 0))

6) 1000 elementi - passo 10% - 100 prove
(setq a6 (test 1000 10 100))
;-> ((10 0.755) (20 0.276) (30 0.213) (40 0.131) (50 0.095)
;->  (60 0.079) (70 0.063) (80 0.039) (90 0.019) (100 0))

Quindi l'errore percentuale diminuisce con l'aumentare del campione osservato e con l'aumentare del numero di prove effettuate.

Inoltre l'errore percentuale diminuisce, a parità delle altre condizioni, con l'aumentare di N:

7) 100 elementi - passo 25% - 100 prove
(setq a7 (test 100 25 100))
;-> ((25 2.208) (50 0.942) (75 0.494) (100 0))

8) 1000 elementi - passo 25% - 100 prove
(setq a8 (test 10000 25 100))
;-> ((25 0.024) (50 0.011) (75 0.005) (100 0))

La formula produce, in media, buoni risultati, ma qual è l'errore massimo che possiamo commettere in tutte le nostre misurazioni?
Per fare questo modifichiamo la nostra funzione in modo che restituisca una lista di coppie con "percentuali di elementi selezionati" e il relativo "errore assoluto massimo".

(define (test-max N step iter)
  (local (ele num-oss max-err err oss Ncalc out)
    ; lista di tutti gli elementi
    (setq ele (sequence 1 N))
    ; per ogni valore di percentuale...
    (for (perc step 100 step)
      ; calcola il numero di osservazioni
      (setq num-oss (int (mul (div N 100) perc)))
      ;(println num-oss)
      ; azzera il valore massimo della percentuale corrente
      (setq max-err 0)
      (for (i 1 iter)
        ; seleziona gli elementi osservati
        (setq oss (slice (randomize ele) 0 num-oss))
        ; calcola il valore atteso
        (setq Ncalc (stima oss))
        ; calcola errore assoluto
        (setq err (abs (sub Ncalc N)))
        ; controllo sul valore massimo
        (if (> err max-err)
            (setq max-err err)
        )
      )
      ; inserisce una coppia di valori nella lista di output
      (push (list perc max-err) out -1)
    )
    out))

1) 100 elementi - passo 10% - 1 prova
(test-max 100 10 1)
;-> ((10 3.5) (20 1.25) (30 2.833) (40 0.55) (50 3.08)
;->  (60 0.6) (70 1.6) (80 0.25) (90 0.9) (100 0))

2) 100 elementi - passo 10% - 10 prove
(test-max 100 10 10)
;-> ((10 9) (20 4.4) (30 8) (40 3.625) (50 5.12)
;->  (60 2.383) (70 0.586) (80 0.25) (90 0.111) (100 0))

3) 100 elementi - passo 10% - 100 prove
(test-max 100 10 100)
;-> ((10 29.5) (20 14.9) (30 13.166) (40 7.725) (50 8.18)
;->  (60 6.45) (70 1.6) (80 1.775) (90 0.9) (100 0))

4) 100 elementi - passo 10% - 1000 prove
(test-max 100 10 1000)
;-> ((10 38.3) (20 31.7) (30 15.233) (40 9.775) (50 9.2)
;->  (60 5.433) (70 4.643) (80 4.812) (90 1.911) (100 0))

5) 100 elementi - passo 2% - 1000 prove
(test-max 100 2 1000)
;-> ((2 92) (4 88.5) (6 68.333) (8 52.625) (10 38.3) (12 34.916) (14 27.071)
;->  (16 26.625) (18 26.055) (20 28.55) (22 18.409) (24 19.75) (26 18.961)
;->  (28 18.143) (30 17.3) (32 15.406) (34 12.470) (36 13.638) (38 13.763)
;->  (40 8.75) (42 15) (44 8.955) (46 11.087) (48 9.125) (50 10.22)
;->  (52 7.231) (54 7.296) (56 8.375) (58 6.397) (60 7.466) (62 5.484)
;->  (64 4.515) (66 4.560) (68 4.602) (70 4.642) (72 7.722) (74 4.716)
;->  (76 4.75) (78 5.794) (80 3.799) (82 3.829) (84 1.833) (86 2.872)
;->  (88 1.886) (90 1.911) (92 1.934) (94 1.957) (96 1.979) (98 0.989)
;->  (100 0))


-----------------------------
Variabile random esponenziale
-----------------------------

La funzione primitiva "random" di newLISP restituisce un numero tra 0 e 1 con una distribuzione uniforme (con media 0.0 e deviazione standard pari a 1).
Questo significa che i numeri generati da "random" sono distribuiti in modo "lineare" tra 0 e 1. Ad esempio, generiamo 10000 numeri casuali, li ordiniamo, li esportiamo in un file csv e infine tracciamo il grafico dei valori (con un foglio elettronico):

Generiamo i 10000 numeri casuali (con distribuzione uniforme):
(setq linear '())
(silent (for (i 1 10000) (push (random) linear -1)))

Ordiniamo i valori:
(sort linear)

Esportiamo in un file ascii comma delimited (.csv):
(list-csv (sort linear) "linear.csv")

Il grafico è riportato nella parte superiore del file "random.png" nella cartella "data" e rappresenta una funzione lineare.

Qualche volta nelle simulazioni con il metodo di Monte Carlo si ha la necessità di utilizzare una variabile random esponenziale, cioè una variabile che può assumere valori da 0 a infinito con una distribuzione esponenziale (che non è uniforme).

La funzione è definita nel modo seguente:

         | k*e^(-k*t),  0 <= t <= infinito
  T(t) = |
         | 0,           t < 0

Si può dimostrare che per ottenere una distribuzione esponenziale è possibile utilizzare la seguente formula:

         log(random)
  T = - -------------
             k

che genera numeri compresi tra 0 e infinito con distribuzione esponenziale.

Per verificare che la formula genera effettivamente numeri con distribuzione esponenziale creiamo due file analoghi al precedente:

(define (rand-exp k)
  (sub (div k (log (random)))))

(rand-exp 10)
;-> 6.084612759169907

(rand-exp 10)
;-> 47.10821990505478

Nota: quando nella funzione "rand-exp" la primitiva "random" genera il numero 0, allora avviene il processo di "obscured INF", cioè il valore infinito di (log 0) viene "oscurato" dall' operazione di divisione "div" (vedi "INFINITO E NOT A NUMBER (INF e NaN)").

(log 0)
;-> -1.#INF
(div 1 (log 0))
;-> -0
(div 1 inf)

Primo file (k=1)
Generiamo i 10000 numeri casuali (con distribuzione esponenziale e k=1):
(setq espo '())
(silent (for (i 1 10000) (push (rand-exp 1) espo -1)))

Ordiniamo i valori:
(sort espo)
(slice espo 0 5)
;-> (0 0.1162058638414357 0.1162058638414357 
;->  0.1250112210453761 0.1341788711293629)

Esportiamo in un file ascii comma delimited (.csv):
(list-csv espo "espo.csv")

Il grafico di "espo.csv" è riportato nella parte centrale del file "random.png" nella cartella "data" e rappresenta una funzione esponenziale.

Secondo file (k=10):
Generiamo i 10000 numeri casuali (con distribuzione esponenziale e k=10):
(setq espo10 '())
(silent (for (i 1 10000) (push (rand-exp 10) espo10 -1)))

Ordiniamo i valori:
(sort espo10)
(slice espo10 0 5)
;-> (1.202250278486829 1.219519242601827 1.235392701660629 
;->  1.250112210453761 1.300537761175834)

Esportiamo in un file ascii comma delimited (.csv):
(list-csv espo10 "espo10.csv")

Il grafico di "espo10.csv" è riportato nella parte inferiore del file "random.png" nella cartella "data" e rappresenta una funzione esponenziale.

Nota: questo metodo di simulare una variabile casuale non uniforme utilizzando una variabile casuale uniforme è valido solo se T(t) è analiticamente invertibile, cioè possiamo passare analiticamente da T(t) a T'(t) (dove T'(t) è la funzione inversa di T(t)). Ad esempio, una distribuzione gaussiana non è invertibile e quindi non possiamo utilizzare un generatore uniforme per simularla.

(define (list-csv lst file-str sepchar)
"Creates a file csv from a list"
  (local (outfile)
    (if (nil? sepchar)
        (setq sepchar ",")
    )
    (setq outfile (open file-str "write"))
    (dolist (el lst)
      (if (list? el)
          (setq line (join (map string el) sepchar))
          (setq line (string el))
      )
      (write-line outfile line)
    )
    (print outfile { })
    (close outfile)))
    
=============================================================================

