================

 NOTE LIBERE 23

================

  "Il samsara è in nulla differente dal nirvana.
   Il nirvana è in nulla differente dal samsara.
   I confini del nirvana sono i confini del samsara.
   Tra questi due non c'è alcuna differenza."
   Nagarjuna

------------------
Dijkstra challenge
------------------

Ken Iverson presentò il suo articolo "Formalism in Programming Languages" nell'agosto 1963 alla Working Conference on Mechanical Language Structures, Princeton, N.J.

https://www.jsoftware.com/papers/FPL.htm

L'articolo riporta anche la discussione avvenuta dopo la presentazione tra Gorn, Backus, Brooker, Iverson, Ross, Bauer, Holt, Green, Tompkins, Perlis, Gosden, Dijkstra, terminata con uno scambio tra Ken e Dijkstra, in cui la risposta di Ken alla domanda di Dijkstra era di una sola linea di codice.

Dijkstra: come rappresenteresti un'operazione più complessa, ad esempio la somma di tutti gli elementi di una matrice M che sono uguali alla somma degli indici di riga e colonna corrispondenti?

Data una matrice M con elementi a(i,j) restituire la somma di ogni a(i,j) dove a(i,j) = i + j.

(define (sum-idx matrix)
  (local (rows cols sum)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (setq sum 0)
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (if (= (matrix r c) (+ r c)) (++ sum (matrix r c)))
      )
    )
    sum))

Proviamo:

(setq m '(( 1 3  0  4)
          ( 1 4  1  4)
          ( 4 3  1  2)
          (-2 4 -2 -1)))

(sum-idx m)
;-> 12

(setq m '((1 1 1 4)
          (1 1 1 4)))
(sum-idx m)
;-> 6

Quando la somma ha il valore massimo?
Quando i valori di ogni cella sono uguali alla somma dei indici della cella.
Per una matrice 3x3 questo avviene per la matrice:

(setq m '((0 1 2)
          (1 2 3)
          (2 3 4)))
(sum-idx m)
;-> 18

Per una matrice 2x4 questo avviene per la matrice:

(setq m '((0 1 2 3)
          (1 2 3 4)))

(sum-idx m)
;-> 16

Il valore della somma massima è una funzione del numero delle righe e delle colonne della matrice.
Per una matrice R x C abbiamo la seguente situazione:
1. Ogni indice di riga "r" varia da 0 a (R - 1).
2. Ogni indice di colonna "c" 0 a (C - 1).
3. La somma degli indici di riga per ogni "r" vale sum[r=0,(R-1)](r) = R*(R - 1)/2
4. La somma degli indici di colonna per ogni "c" vale sum[c=0,(C - 1)](c) = C*(C - 1)/2
5. Per avere la somma degli indici di riga dobbiamo sommare C volte (0..(R-1)) --> C * (R*(R-1)/2)
6. Per avere la somma degli indici di colonna dobbiamo sommare R volte (0..(C-1)) --> R * (C*(C-1)/2)
7. La somma massima S è data dalla somma degli indici di riga e degli indici di colonna:

   S = C*(R*(R-1)/2) + R*(C*(C-1)/2) =
     = (1/2) * R * C * (R + C - 2)

(define (sum-max n m)
  (/ (* m n (+ m n -2)) 2))

Proviamo:

(sum-max 3 3)
;-> 48

(sum-max 2 4)
;-> 16

(sum-max 4 2)
;-> 16

(sum-max 5 5)
;-> 100

(sum-max 10 10)
;-> 900


-------------
n AND (n - 1)
-------------

Calcolare la sequenza di numeri generata dall'operazione di AND binario (n & (n - 1)).

Sequenza OEIS:
Bitwise AND of binary representation of n-1 and n
  0, 0, 2, 0, 4, 4, 6, 0, 8, 8, 10, 8, 12, 12, 14, 0, 16, 16, 18, 16, 20,
  20, 22, 16, 24, 24, 26, 24, 28, 28, 30, 0, 32, 32, 34, 32, 36, 36, 38,
  32, 40, 40, 42, 40, 44, 44, 46, 32, 48, 48, 50, ...

(define (f n) (& n (- n 1)))

(map f (sequence 1 51))
;-> (0 0 2 0 4 4 6 0 8 8 10 8 12 12 14 0 16 16 18 16 20
;->  20 22 16 24 24 26 24 28 28 30 0 32 32 34 32 36 36 38
;->  32 40 40 42 40 44 44 46 32 48 48 50)

Nota: quando (n and (n-1)) vale 0, allora n è una potenza di due.

(define (power2? n) (zero? (& n (- n 1))))

(filter power2? (sequence 1 100))
;-> (1 2 4 8 16 32 64)


-----------------------------
Prodotto quadrato delle cifre
-----------------------------

Generare la sequenza dei numeri in cui il prodotto delle cifre è un quadrato perfetto.
Generare la sequenza dei numeri in cui il prodotto delle cifre non-zero è un quadrato perfetto.

Sequenza OEIS: A174800
Number whose product of digits is a square
  0, 1, 4, 9, 10, 11, 14, 19, 20, 22, 28, 30, 33, 40, 41, 44, 49, 50, 55,
  60, 66, 70, 77, 80, 82, 88, 90, 91, 94, 99, 100, 101, 102, 103, 104,
  105, 106, 107, 108, 109, 110, 111, 114, 119, 120, 122, ...

Sequenza OEIS: A062371
Numbers the product of whose nonzero digits is a perfect square
  1, 4, 9, 10, 11, 14, 19, 22, 28, 33, 40, 41, 44, 49, 55, 66, 77, 82, 88,
  90, 91, 94, 99, 100, 101, 104, 109, 110, 111, 114, 119, 122, 128, 133,
  140, 141, 144, 149, 155, 166, 177, 182, 188, 190, 191, 194, 199, 202, ...

(define (digit-prod num)
"Calculates the product of the digits of an integer"
  (if (zero? num)
      0
      (let (out 1)
        (while (!= num 0)
          (setq out (* out (% num 10)))
          (setq num (/ num 10))
        )
    out)))

(digit-prod 1234)
;-> 24

(define (square? n)
  (let (v (int (sqrt n)))
    (= n (* v v))))

(square? 25)
;-> true
(square? 22)
;-> nil

(square? 0)
;-> true
(pow 0 2)
;-> 0

(define (a174800? num) (square? (digit-prod num)))

(a174800? 80)
;-> true

(filter a174800? (sequence 1 122))
;-> (1 4 9 10 11 14 19 20 22 28 30 33 40 41 44 49 50 55
;->  60 66 70 77 80 82 88 90 91 94 99 100 101 102 103 104
;->  105 106 107 108 109 110 111 114 119 120 122)

(define (digit-prod-0 num)
"Calculates the product of the digits of an integer (without 0)"
  (if (zero? num)
      0
      (let (out 1)
        (while (!= num 0)
          (if (!= (% num 10) 0) (setq out (* out (% num 10))))
          (setq num (/ num 10))
        )
    out)))

(digit-prod-0 1234)
;-> 24

(digit-prod 220)
;-> 0
(digit-prod-0 220)
;-> 4

(define (a062371? num) (square? (digit-prod-0 num)))

(a062371? 80)
;-> nil

(filter a062371? (sequence 1 202))
;-> (1 4 9 10 11 14 19 22 28 33 40 41 44 49 55 66 77 82 88
;->  90 91 94 99 100 101 104 109 110 111 114 119 122 128 133
;->  140 141 144 149 155 166 177 182 188 190 191 194 199 202)


--------------------------
Binary recurrence sequence
--------------------------

Una sequenza di ricorrenza binaria (binary recurrence sequence) è una sequenza definita ricorsivamente nel modo seguente:

  F(0)=a(0), F(1)=a(1), ..., F(y)=a(y), per n <= y
  F(n) = c1*F(n - x) + c2*F(n - y), per n > y

Si tratta della generalizzazione di altre sequenze, per esempio:

  Fibonacci: x=1, y=2, a=(0 1 1), c1=1, c2=1

  Lucas: x=1, y=2, a=(2 1), c1=1, c2=1

(define (effe n a x y c1 c2)
  (if (< n y)
      (a n)
      ;else
      (+ (* c1 (effe (- n x) a x y c1 c2))
         (* c2 (effe (- n y) a x y c1 c2)))))

Proviamo:

(effe 10 '(0 1 1) 1 2 1 1)
;-> 55

(effe 10 '(2 1) 1 2 1 1)
;-> 123


---------------------------
Sequenza (2x + 1) e (3x -1)
---------------------------

Una sequenza di numeri viene calcolata in base alla seguenti regole:
1) Il primo elemento è 1
2) La sequenza è crescente
3) Se x appare nella sequenza, allora lo fanno anche 2x+1 e 3x-1

Sequenza OEIS: A190810
Increasing sequence generated by these rules: a(1)=1, and if x is in a then 2x+1 and 3x-1 are in a
  1, 2, 3, 5, 7, 8, 11, 14, 15, 17, 20, 23, 29, 31, 32, 35, 41, 44, 47,
  50, 59, 63, 65, 68, 71, 83, 86, 89, 92, 95, 101, 104, 119, 122, 127,
  131, 137, 140, 143, 149, 167, 173, 176, 179, 185, 188, 191, 194, 203,
  209, 212, 239, 245, 248, 255, 257, 263, 266, 275, 281, ...

Primo metodo:
"iter" cicli degli elementi nella sequenza corrente e aggiunta dei numeri (2x + 1) e (3x -1).
Al termine calcolo degli elementi unici e ordinamento della sequenza.

(define (seq1 iter)
  (let (out '(1))
    (for (i 1 iter)
      (dolist (el out)
        (push (+ (* 2 el) 1) out)
        (push (- (* 3 el) 1) out)
      )
    )
    (unique (sort out))))

Proviamo:

(seq1 5)
;-> (1 2 3 5 7 8 11 14 15 17 20 23 29 31 32 35 41 44 47 50 59 63 65
;->  68 71 83 86 89 92 95 101 104 119 122 131 137 140 149 176 203)

Secondo metodo:
"iter" cicli degli elementi nella sequenza corrente e aggiunta dei numeri (2x + 1) e (3x -1), se i numeri non appartengono alla sequenza.
Al termine ordinamento della sequenza.

(define (seq2 iter)
  (setq out '(1))
  (for (i 1 iter)
    (dolist (el out)
      (if (not (ref (setq a (+ (* 2 el) 1)) out))
          (push a out))
      (if (not (ref (setq b (- (* 3 el) 1)) out))
          (push b out))
    )
  )
  (sort out))

Proviamo:

(seq2 5)
;-> (1 2 3 5 7 8 11 14 15 17 20 23 29 31 32 35 41 44 47
;->  50 59 63 65 68 71 83 86 89 92 95 101 104 119 122 131 137 140 149 176 203)

Nota: in entrambe le sequenze mancano alcuni termini (ad esempio, 127).
Questo perchè 127 può essere generato solo da 63 o 42.
In questo caso il 63 viene aggiunto con l'ultima iterazione e quindi non otteniamo il valore 127.
Aumentando le iterazioni compare il numero 127, ma mancheranno altri numeri.
La sequenza è completa fino ad un certo numero X che è dato dal numero intero:

  (last-number - 1)/2 oppure (last-number + 1)/3

(define (seq3 iter)
  (setq out '(1))
  (for (i 1 iter)
    (dolist (el out)
      (if (not (ref (setq a (+ (* 2 el) 1)) out))
          (push a out))
      (if (not (ref (setq b (- (* 3 el) 1)) out))
          (push b out))
    )
  )
  (sort out)
  (setq ultimo1 (div (- (out -1) 1) 2))
  (setq ultimo2 (div (+ (out -1) 1) 3))
  ;(println ultimo1 { } ultimo2 { } (min ultimo1 ultimo2))
  ; per sicurezza prendiamo il valore minore
  (setq ultimo (min ultimo1 ultimo2))
  (slice out 0 (+ (find ultimo out) 1)))

Proviamo:

(seq3 5)
;-> (1 2 3 5 7 8 11 14 15 17 20 23 29 31 32 35 41 44 47 50 59 63 65 68)

(seq3 8)
;-> (1 2 3 5 7 8 11 14 15 17 20 23 29 31 32 35 41 44 47 50 59 63 65 68
;->  71 83 86 89 92 95 101 104 119 122 127 131 137 140 143 149 167 173
;->  176 179 185 188 191 194 203 209 212 239 245 248 255 257 263 266 275
;->  281 284 287 299 302 311 335 347 353 356 359 365 371 377 380 383 389
;->  392 407 410 419 425 428 446 479 491 497 500 511 515 518 527 533 536
;->  551 554 563 569 572 575 581 599 605 608 623 626 635 671 695 707 713
;->  716 719 731 734 743 755 761 764 767 770 779 785 788 797 815 821 824
;->  839 842 851 857 860 893 896 905 932 959 983 995 1001 1004 1031 1037
;->  1040 1055 1058 1067 1073 1076 1094 1103 1109 1112 1127 1130 1139
;->  1145 1148 1163 1166 1175 1199 1211 1217 1220 1229 1247 1253 1256
;->  1271 1274 1283 1337 1415 1427 1433 1436 1463 1469 1472 1487 1490
;->  1499 1541 1544 1553 1571 1577 1580 1595 1598 1607 1631 1643 1649
;->  1652 1661 1679 1685 1688 1703 1706 1715 1742 1787 1793 1796 1811
;->  1814 1823)

(length (seq3 10))
;-> 893


--------------
Liste sum-free
--------------

Una lista è sum-free se nessuna coppia di elementi (non necessariamente distinti) somma ad un numero contenuto nella lista.

(define (sum-free? lst)
  (let (no nil)
    (dolist (el1 lst no)
      (dolist (el2 lst no)
        (if (find (+ el1 el2) lst) (setq no true))
      )
    )
    (not no)))

Proviamo:

(sum-free? '(4))
;-> true
(sum-free? '(1 5 7))
;-> true
(sum-free? '(16 1 4 9))
;-> true
(sum-free? '(1 4 5 7))
;-> nil
(sum-free? '(3 0))
;-> nil
(sum-free? '(16 1 4 8))
;-> nil;


------------------------------------------------------------
Ordinare un numero in base all'ordine alfabetico delle cifre
------------------------------------------------------------

Dato un numero intero non negativo n, crea una funzione che restituisca n in ordine alfabetico, secondo l'ortografia letterale di ciascuna cifra in n.

Esempi:
  Input: 101
  cifre letterali = one, zero, one
  cifre letterali ordinate = one, one, zero
  Output: 110

  Input: 101
  cifre letterali = uno, zero, uno
  cifre letterali ordinate = uno, uno, zero
  Output: 110

  Input: 31948
  cifre letterali = three, one, nine, four, eight
  cifre letterali ordinate = eight, four, nine, one, three
  Output: 84913

  Input: 31948
  cifre letterali = tre, uno, nove, quattro, otto
  cifre letterali ordinate = nove, otto, quattro, tre, uno
  Output: 98431

Input: 1234567890
Output: 8549176320

(define (ordina num lang)
  (local (out eng1 ita1 eng2 ita2)
    (setq lst '())
    (setq eng1 '(("0" "zero") ("1" "one") ("2" "two") ("3" "three")
                ("4" "four") ("5" "five") ("6" "six") ("7" "seven")
                ("8" "eight")("9" "nine")))
    (setq ita1 '(("0" "zero") ("1" "uno") ("2" "due") ("3" "tre")
                ("4" "quattro") ("5" "cinque") ("6" "sei") ("7" "sette")
                ("8" "otto") ("9" "nove")))
    (setq eng2 '(("zero" "0") ("one" "1") ("two" "2") ("three" "3")
                 ("four" "4") ("five" "5") ("six" "6") ("seven" "7")
                 ("eight" "8") ("nine" "9")))
    (setq ita2 '(("zero" "0") ("uno" "1") ("due" "2") ("tre" "3")
                 ("quattro" "4") ("cinque" "5") ("sei" "6") ("sette" "7")
                 ("otto" "8") ("nove" "9")))
    (if (= lang "ita")
        (set 'link1 ita1 'link2 ita2)
        (set 'link1 eng1 'link2 eng2)
    )
    ; creazione lista delle cifre ortografiche
    (dolist (digit (explode (string num)))
      (push (lookup digit link1) lst -1)
    )
    ; ordinamento delle cifre ortografiche
    (sort lst)
    (setq out "")
    ; conversione delle cifre ortografiche ordinate nel numero
    (dolist (el lst)
      (extend out (lookup el link2))
    )
    (int out)))

Proviamo:

(ordina 101)
;-> 110
(ordina 101 "ita")
;-> 110

(ordina 31948)
;-> 84913
(ordina 31948 "ita")
;-> 98431

(ordina 1234567890)
;-> 8549176320
(ordina 1234567890 "ita")
;-> 5298467310


----------------------------------------------------------------
Raggruppare in sottoliste tutti gli elementi uguali di una lista
----------------------------------------------------------------

Data una lista di elementi, raggruppare tutti gli elementi uguali.
Per esempio:

  lista = (3 5 4 1 3 4)
  output = ((1) (3 3) (4 4) (5))

  lista = (a b c a b c d)
  output = ((a a) (b b) (c c) (d))

(define (group-equal lst)
  (local (palo conta out)
    (sort lst)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq palo (first lst))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              (if (= el palo) (++ conta)
                  ; altrimenti costruiamo la coppia (conta el) e la aggiungiamo al risultato
                  (begin (push (dup palo conta true) out -1)
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           ; aggiungiamo l'ultima coppia di valori
           (push (dup palo conta true) out -1)
           out))))

Proviamo:

(group-equal '())
;-> ()

(group-equal '(3 5 4 1 3 4))
;-> ((1) (3 3) (4 4) (5))

(group-equal '(1 3 2 4 1 2 3 4 5))
;-> ((1 1) (2 2) (3 3) (4 4) (5))

(group-equal '(a b c a b c d))
;-> ((a a) (b b) (c c) (d))


------------------------
Inversione e sottrazione
------------------------

Prendiamo un intero positivo N, invertiamo le sue cifre per ottenere l'inverso e calcoliamo il valore assoluto della differenza di questi due numeri. Per esempio:

  N = 3985
  inverso(N) = 5893
  |3985 - 5893| = 1908

Continuando a ripetere l'operazione otteniamo:

 |3985 - 5893| = 1908
 |8091 - 1908| = 6183
 |3816 - 6183| = 2367
 |7632 - 2367| = 5265
 |5625 - 5265| = 360
    |63 - 360| = 297
   |792 - 297| = 495
   |594 - 495| = 99
     |99 - 99| = 0

La maggior parte dei numeri termina la sequenza con il numero 0, comuqnue esistono numeri in cui la sequenza entra in un ciclo infinito. Per esempio:

  N = 1584
  |4851 - 1584| = 3267
  |7623 - 3267| = 4356
  |6534 - 4356| = 2178
  |8712 - 2178| = 6534
  |4356 - 6534| = 2178

In questo caso il ciclo è (2178 6534 2178).

Funzione che calcola la sequenza e il ciclo (eventuale) di un numero:

(define (inv-sub num)
  (local (out stop rev idx ciclo)
    (setq out (list num))
    (setq stop nil)
    (until stop
      (setq rev (int (reverse (string num)) 0 10))
      ;(print rev { } num { } (abs (- num rev))) (read-line)
      (setq num (abs (- num rev)))
      (cond ((zero? num) ; sequenza che termina con 0
              (push num out -1)
              (setq stop true))
            ((find num out) ; sequenza che termina con un ciclo
              (push num out -1)
              (setq stop true)
              (setq idx (ref num out))
              (setq ciclo (slice out (idx 0)))
              (println ciclo))
            (true (push num out -1)) ; sequenza che continua
      )
    )
    out))

Proviamo:

(inv-sub 3985)
;-> (3985 1908 6183 2367 5265 360 297 495 99 0)

(inv-sub 1584)
;-> (2178 6534 2178)
;-> (1584 3267 4356 2178 6534 2178)

(inv-sub 2178)
;-> (2178 6534 2178)
;-> (2178 6534 2178)

(inv-sub 0)
;-> (0 0)

Vediamo di calcolare le lunghezze delle sequenze dei numeri da 0 ad un dato limite.

(define (len-seq num)
  (local (out stop rev idx ciclo)
    (setq out (list num))
    (setq stop nil)
    (until stop
      (setq rev (int (reverse (string num)) 0 10))
      ;(print rev { } num { } (abs (- num rev))) (read-line)
      (setq num (abs (- num rev)))
      (cond ((zero? num) ; sequenza che termina con 0
              (push num out -1)
              (setq stop true))
            ((find num out) ; sequenza che termina con un ciclo
              (push num out -1)
              (setq stop true))
            (true (push num out -1)) ; sequenza che continua
      )
    )
    (length out)))

Proviamo:

(len-seq 3985)
;-> 10
(len-seq 1584)
;-> 6
(len-seq 2178)
;-> 3
(len-seq 0)
;-> 2

(map len-seq (sequence 0 100))
;-> (2 2 2 2 2 2 2 2 2 2 3 2 3 7 5 6 4 4 6 5 7 3 2 3 7 5 6 4 4 6 5 7 3
;->  2 3 7 5 6 4 4 6 5 7 3 2 3 7 5 6 4 4 6 5 7 3 2 3 7 5 6 4 4 6 5 7 3
;->  2 3 7 5 6 4 4 6 5 7 3 2 3 7 5 6 4 4 6 5 7 3 2 3 7 5 6 4 4 6 5 7 3
;->  2 3)

Lunghezza massima della sequenza dei numeri da 0 a 1e5:

(apply max (map len-seq (sequence 0 1e5)))
;-> 15

Lista con le lunghezze delle sequenza dei numeri da 0 a 1e6:

(silent (setq seq (map len-seq (sequence 0 1e6))))

Lunghezza massima:

(apply max seq)
;-> 50

Numero che ha la sequenza con lunghezza massima:

(ref 50 seq)
;-> (150703)
(len-seq 150703)
;-> 50

Quanti sono i numeri che hanno la sequenza con lunghezza massima:

(length (ref-all 50 seq))
;-> 249

Adesso calcoliamo quali sono i numeri che hanno un ciclo.

(define (ciclico? num all)
  (local (seq stop rev idx ciclo cycle)
    (setq cycle nil)
    (setq seq (list num))
    (setq stop nil)
    (until stop
      (setq rev (int (reverse (string num)) 0 10))
      ;(print rev { } num { } (abs (- num rev))) (read-line)
      (setq num (abs (- num rev)))
      (cond ((zero? num) ; sequenza che termina con 0
              (push num seq -1)
              (setq stop true))
            ((find num seq) ; sequenza che termina con un ciclo
              (push num seq -1)
              (setq stop true)
              (setq idx (ref num seq))
              (setq cycle true)
              (setq ciclo (slice seq (idx 0))))
            (true (push num seq -1)) ; sequenza che continua
      )
    )
    (cond (all
            (if cycle (list (seq 0) (length ciclo) (length seq) ciclo seq)
                      nil))
          (true cycle))))

Proviamo:

(ciclico? 1584)
;-> true

(ciclico? 1584 true)
;-> (1584 3 6 (2178 6534 2178) (1584 3267 4356 2178 6534 2178))

(ciclico? 2024 true)
;-> (2024 3 4 (2178 6534 2178) (2024 2178 6534 2178))

(ciclico? 3985)
;-> nil

(ciclico? 150703)
;-> nil

(filter ciclico? (sequence 1 1500))
;-> (1012 1023 1034 1045 1067 1078 1089 1100 1122 1133 1144 1155 1177
;->  1188 1199 1210 1232 1243 1254 1265 1287 1298 1320 1342 1353 1364
;->  1375 1397 1408 1430 1452 1463 1474 1485)

Adesso sono interessato a vedere quali numeri iniziali compongono i cicli.

(define (cyclic-number limit)
  (setq out '())
  (for (num 0 limit)
    (setq c (ciclico? num true))
    (if (and c (not (ref (c 3 0) out)))
        (push (c 3 0) out -1))
  )
  (unique out))

(cyclic-number 1e6)
;-> (6534 2178 65934 21978 659934 219978)

(map (fn(x) (ciclico? x true)) '(6534 2178 65934 21978 659934 219978))
;-> ((6534 3 3 (6534 2178 6534) (6534 2178 6534))
;->  (2178 3 3 (2178 6534 2178) (2178 6534 2178))
;->  (65934 3 3 (65934 21978 65934) (65934 21978 65934))
;->  (21978 3 3 (21978 65934 21978) (21978 65934 21978))
;->  (659934 3 3 (659934 219978 659934) (659934 219978 659934))
;->  (219978 3 3 (219978 659934 219978) (219978 659934 219978)))

(time (println (cyclic-number 1e7)))
;-> (6534 2178 65934 21978 659934 219978 6599934 2199978)
;-> 106655.243
Sembra che i numeri iniziali hanno una delle seguenti due forme:

 a) 21[9...]78
 b) 65[9...]34

Nota: Non possono mai essere necessari più di 10*N passi per raggiungere un ciclo, perché la trasformazione non può aumentare il numero di cifre e ci sono meno di 10*N numeri che hanno non più cifre di N.


-----------
a*b + c = N
-----------

Dato un intero N trovare (se esistono) gli interi a, b e c che soddisfano tutte le seguenti condizioni:

1) a > b > c
2) a, b, c sono numeri primi
3) a*b + c = N

Primo metodo
------------
Calcolo dei primi fino a N/3.
Combinazioni di 3 elementi di tutti i primi calcolati.
Verifica della condizione 3) per ogni combinazione.

I primi vengono calcolatil limite è impostato su N/3 perché nell'equazione a*b c = N con a > b > c, se c fosse maggiore di N/3, allora a*b sarebbe maggiore di N, violando l'equazione.
Questo garantisce di non cercare valori c che supererebbero i vincoli dell'equazione.

(define (primes-to num)
"Generates all prime numbers less than or equal to a given number"
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let ((lst '(2)) (arr (array (+ num 1))))
          (for (x 3 num 2)
            (when (not (arr x))
              (push x lst -1)
              (for (y (* x x) num (* 2 x) (> y num))
                (setf (arr y) true)))) lst))))

(define (comb k lst (r '()))
"Generates all combinations of k elements without repetition from a list of items"
  (if (= (length r) k)
    (list r)
    (let (rlst '())
      (dolist (x lst)
        (extend rlst (comb k ((+ 1 $idx) lst) (append r (list x)))))
      rlst)))

(length (comb 3 (primes-to 100)))
;-> 2300

(define (abc-1 num)
  (local (out prove)
    (setq out '())
    (setq prove (comb 3 (primes-to (/ num 3))))
    (dolist (p prove)
      (if (= (+ (* (p 2) (p 1)) (p 0)) num)
          (push (list (p 2) (p 1) (p 0)) out -1)
      )
    )
    out))

Proviamo:

(abc-1 35)
;-> ((11 3 2))

(abc-1 101)
;-> ()

(abc-1 148)
;-> ((29 5 3) (13 11 5))

(abc-1 208)
;-> ((41 5 3) (29 7 5))

Secondo metodo
--------------
Calcolo dei primi fino a N/3.
Tre cicli for per a,b e c e verifica delle condizioni per ogni tripla.

(define (abc-2 N)
  (letn ( (limit (/ N 3))
          (primes (primes-to limit))
          (result '()) )
    (dolist (a primes)
      (dolist (b primes)
        (dolist (c primes)
          ;(print a { } b { } c) (read-line)
          (when (and (< c b) (< b a) (= (+ (* a b) c) N))
            (push (list a b c) result -1)))))
    result))

Proviamo:

(abc-2 35)
;-> ((11 3 2))

(abc-2 101)
;-> ()

(abc-2 148)
;-> ((13 11 5) (29 5 3))

(abc-2 208)
;-> ((29 7 5) (41 5 3))

Vediamo la velocità delle funzioni:

(abc-1 2007)
;-> ((401 5 2))
(abc-2 2007)
;-> ((401 5 2))

(time (abc-1 2007) 10)
;-> 3939.236
(time (abc-2 2007) 10)
;-> 1565.53

(time (abc-2 10000))
;-> 9301.794


----------------------------
Coppia di multipli invertita
----------------------------

Due numeri a e b sono una coppia di multipli invertita se risulta:

  a*b = reverse((a-1)*b)

(define (coppia? a b) (= (* a b) (int (reverse (string (* (- a 1) b))) 0 10)))

Proviamo:

(coppia? 34 2079)
;-> true

(coppia? 2079 34)
;-> nil

(define (show a b)
  (list (* a b) (int (reverse (string (* (- a 1) b))) 0 10)))

(show 34 2079)
;-> (70686 70686)

(define (find-coppie limite)
  (setq out '())
  (for (a 1 limite)
    (for (b (+ a 1) limite)
      (if (coppia? a b) (push (list a b) out -1))
      (if (coppia? b a) (push (list b a) out -1))
    )
  )
  out)

Proviamo:

(find-coppie 100)
;-> ((6 9) (6 99))

(find-coppie 1000)
;-> ((6 9) (6 99) (6 909) (6 999))

(time (println (setq c10000 (find-coppie 10000))))
;-> ((3 2178) (6 9) (6 99) (6 909) (6 999) (6 9009) (6 9999)
;->  (19 1089) (28 1089) (34 2079) (37 1089) (46 1089))
;-> 70932.871

(setq c10000
'((3 2178) (6 9) (6 99) (6 909) (6 999) (6 9009) (6 9999)
 (19 1089) (28 1089) (34 2079) (37 1089) (46 1089)))

(map (fn(x) (apply show x)) c10000)
;-> ((6534 6534) (54 54) (594 594) (5454 5454) (5994 5994) (54054 54054)
;->  (59994 59994) (20691 20691) (30492 30492) (70686 70686) (40293 40293)
;->  (50094 50094))


---------------------
Massima soddisfazione
---------------------

Abbiamo N persone e N oggetti non necessariamente distinti (con N <= 10).
Ogni persona compila una lista di preferenze degli oggetti (le preferenze vanno da 1 (prima scelta) a N (ultima scelta)). Vogliamo calcolare la distribuzione degli oggetti in modo da massimizzare la soddisfazione totale delle persone.
Per misurare la soddisfazione totale usiamo la seguente formula:

  Sum[i=1,N](valore-oggetto(i))

dove valore-oggetto(i) è il valore dell'oggetto (secondo le preferenze della i-esima persona) assegnato alla i-esima persona.
Questa somma deve essere minima per massimizzare la soddisfazione totale, quindi si tratta di minimizzare l'insoddisfazione totale.
Il valore minimo della (in)soddisfazione totale vale N, questo avviene quando ad ogni persona viene assegnato l'oggetto che questa aveva selezionato come prima scelta (con valore 1).
Il valore massimo della (in)soddisfazione totale vale N*N, questo avviene quando ad ogni persona viene assegnato l'oggetto che questa aveva selezionato come ultima scelta (con valore N).

Questo problema è un caso particolare dell'algoritmo dei matrimoni stabili di Gale-Shapley in cui le donne o gli uomini (in questo caso gli oggetti) non hanno liste di preferenza.

Vedi anche "Il problema dei matrimoni stabili" su "Rosetta code".
Vedi anche "Algoritmo di Gale-Shapley" su "Note libere 3".

In questo caso proviamo a risolvere il problema con la forza bruta.
Calcoliamo tutte le permutazioni delle possibili assegnazione degli N oggetti alle N persone e per ogni assegnazione calcoliamo la (in)soddisfazione totale e teniamo traccia del valore ottimale.

Le liste di preferenza devono essere complete (è sempre possibile assegnare in modo casuale i valori rimanenti agli oggetti non valutati) e contenere tutti i valori da 1 a N (nessun pari merito).

Per comodità facciamo iniziare le preferenze da 0 (invece che da 1).
In questo modo il valore minimo della (in)soddisfazione totale vale 0 e il valore massimo vale (N-1)*(N-1).

(define (perm lst)
"Generates all permutations without repeating from a list of items"
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
    out))

Funzione che massimizza la soddisfazione:

(define (satisfy pref)
  (local (N ottimo distr assegnazioni soddisfazione)
    (setq N (length pref))
    (setq ottimo (+ (* N N) 1))
    (setq distr '())
    (setq assegnazioni (perm (sequence 0 (- N 1))))
    (dolist (values assegnazioni)
      (setq soddisfazione 0)
      (dolist (v values)
        (setq soddisfazione (+ soddisfazione (find v (pref $idx))))
      )
      (if (< soddisfazione ottimo) (set 'ottimo soddisfazione 'distr values))
      ;(println soddisfazione { } values { } ottimo)
    )
    (list ottimo distr)))

Proviamo:

(setq pr '((3 0 2 1) (0 1 2 3) (2 1 0 3) (0 2 1 3)))
(satisfy pr)
;-> 5 (0 1 2 3) 5
;-> 6 (1 0 2 3) 5
;-> 6 (2 0 1 3) 5
;-> 7 (0 2 1 3) 5
;-> 10 (1 2 0 3) 5
;-> 8 (2 1 0 3) 5
;-> 4 (3 1 0 2) 4
;-> 9 (1 3 0 2) 4
;-> 6 (0 3 1 2) 4
;-> 2 (3 0 1 2) 2
;-> 7 (1 0 3 2) 2
;-> 6 (0 1 3 2) 2
;-> 8 (0 2 3 1) 2
;-> 7 (2 0 3 1) 2
;-> 2 (3 0 2 1) 2
;-> 6 (0 3 2 1) 2
;-> 9 (2 3 0 1) 2
;-> 6 (3 2 0 1) 2
;-> 3 (3 2 1 0) 2
;-> 6 (2 3 1 0) 2
;-> 6 (1 3 2 0) 2
;-> 1 (3 1 2 0) 1
;-> 6 (2 1 3 0) 1
;-> 8 (1 2 3 0) 1
;-> (1 (3 1 2 0))

(setq pr '((0 1 2 3) (1 2 3 0) (2 3 0 1) (3 0 1 2)))
(satisfy pr)
;-> (0 (0 1 2 3))

(setq pr '((0 1 2) (2 0 1) (1 2 0)))
(satisfy pr)
;-> (0 (0 2 1))


--------------------------------------------------
Selezionare k oggetti diversi da N oggetti diversi
--------------------------------------------------

Vogliamo trovare qual è la probabilità di scegliere k oggetti diversi scegliendo a caso tra N oggetti diversi.
Per esempio, qual è la probabilità di scegliere 3 cifre diverse su 10 (0..9)?
La prima scelta ha probabilità 1 di essere diversa perchè non abbiamo ancora nessuna cifra.
La seconda scelta ha probabilità 9/10, cioè ci sono 9 su 10 cifre diverse da quella che abbiamo scelto precedentemente.
La terza scelta ha probabilità 8/10, cioè ci sono 8 su 10 cifre diverse da quelle che abbiamo scelto precedentemente.
Quindi la probabilità di scegliere 3 cifre diverse su 10 vale:

  p(3) = 1 * 9/10 * 8/10 = 0.72

Possiamo estrapolare la formula generale:

  p(n,k) = Prod[i=1..(k-1)]((n-i)/n)

Nel caso delle cifre:

  p(k) = Prod[i=1..(k-1)]((10-i)/10)

Scriviamo la funzione generale:

(define (diverse k n)
  (let (prob 1)
    (for (i 0 (- k 1))
      (setq prob (mul prob (div (- n i) n)))
    )
    prob))

Proviamo:

(map (fn(x) (list x (diverse x 10))) (sequence 1 10))
;-> ((1 1) (2 0.9) (3 0.72) (4 0.504) (5 0.3024)
;->  (6 0.1512) (7 0.06048) (8 0.018144) (9 0.0036288) (10 0.00036288))

Scriviamo una funzione che simula il processo un certo numero di volte e calcola la probabilità di selezionare k cifre diverse su 10 cifre (0..9):

(define (simula k iter)
  (setq tot 0)
  (for (i 1 iter)
    (do-while (zero? (cifre 0)) (setq cifre (rand 10 k)))
    (if (= cifre (unique cifre)) (++ tot))
      ;(begin (print cifre) (read-line) (++ tot))
      ;(println "--" cifre))
  )
  (div tot iter))

Proviamo:

(map (fn(x) (list x (simula x 1e6))) (sequence 1 10))
;-> ((1 1) (2 0.899721) (3 0.72089) (4 0.504817) (5 0.302187)
;->  (6 0.151611) (7 0.060339) (8 0.01815) (9 0.003624) (10 0.000371))

(time (println (simula 10 1e7)))
;-> 0.0003573
;-> 14829.444
;-> 0.000360

I risultati simulati sono congruenti con quelli calcolati matematicamente.

La probabilità di selezionare k oggetti diversi su N oggetti diversi può essere calcolata anche con la seguente formula:

                N!
  P(k) = ----------------, con N >= k
          N^k * (N - k)!

e la probabilità che almeno due oggetti siano uguali è 1 – P(k).

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (prob n k)
  (div (fact-i n)
       (mul (pow n k) (fact-i (- n k)))))

Proviamo:

(prob 10 3)
;-> 0.72

(prob 10 10)
;-> 0.00036288

Comunque con valori moderatamente grandi di N e k è probabile che la formula produca un overflow se implementata direttamente.
Quindi, come al solito, il trucco è usare i logaritmi per evitare overflow o underflow.

(define (pr n k)
  (exp (sub (gammaln (+ n 1)) (gammaln (sub n k -1)) (mul k (log n)))))

Proviamo:

(pr 10 3)
;-> 0.7200000000005714
(pr 10 10)
;-> 0.0003628800000003172


-----------
Bit Weaving
-----------

Il linguaggio di programmazione esoterico "evil" ha una funzione di nome "weaving" che opera sui bit di un byte.
In pratica effettua una permutazione degli otto bit di un byte in base al seguente schema:

  0 1 2 3 4 5 6 7
  │┌┘ │┌┘ │┌┘ └┐│
  └┼┐ └┼─┐└┼──┐││
  ┌┘└─┐│ └┐│┌─┼┼┘
  │ ┌─┼┘┌─┼┘│ │└┐
  0 1 2 3 4 5 6 7

  Il Bit 0 viene spostato nel Bit 2
  Il Bit 1 viene spostato nel Bit 0
  Il Bit 2 viene spostato nel Bit 4
  Il Bit 3 viene spostato nel Bit 1
  Il Bit 4 viene spostato nel Bit 6
  Il Bit 5 viene spostato nel Bit 3
  Il Bit 6 viene spostato nel Bit 7
  Il Bit 7 viene spostato nel Bit 5

Analogamente:

  1 3 0 5 2 7 4 6
  | | | | | | | |
  | | | | | | | |
  | | | | | | | |
  | | | | | | | |
  0 1 2 3 4 5 6 7

  Il Bit 0 assume il valore del Bit 1
  Il Bit 1 assume il valore del Bit 3
  Il Bit 2 assume il valore del Bit 0
  Il Bit 3 assume il valore del Bit 5
  Il Bit 4 assume il valore del Bit 2
  Il Bit 5 assume il valore del Bit 7
  Il Bit 6 assume il valore del Bit 4
  Il Bit 7 assume il valore del Bit 6

Nota: non importa da quale estremità del byte iniziamo a contare, poiché lo schema è simmetrico.
Nota: applicando otto volte la funzione "weaving" il byte non cambia
Nota: la funzione "weaving" viene utilizzata per ridurre la quantità di comandi utilizzati per generare costanti.

Per simulare la funzione "weaving" possiamo usare la funzione "select":

(define (weaving byte) (select byte '(1 3 0 5 2 7 4 6)))

Proviamo:

(weaving "20416375")
;-> "01234567"
(weaving "01234567")
;-> "13052746"

(weaving '(2 0 4 1 6 3 7 5))
;-> (0 1 2 3 4 5 6 7)
(weaving '(0 1 2 3 4 5 6 7))
;-> (1 3 0 5 2 7 4 6)

(setq b "10011101")
(dotimes (x 8) (setq b (weaving b)))
;-> "10011101"

(weaving "11111111")
;-> "11111111"
(weaving "00000000")
;-> "00000000"

(weaving "10101010")
;-> "00101011"
(weaving "01010101")
;-> "11010100"

(weaving "11110000")
;-> "11101000"
(weaving "00001111")
;-> "00010111"

Vediamo cosa accade ai numeri decimali coinvolti nella trasformazione:

(define (decimali byte)
  (setq a (int byte 0 2))
  (setq wyte (weaving byte))
  (setq b (int wyte 0 2))
  (list (list byte a) (list wyte b) (abs (- a b))))

(decimali "11110000")
;-> (("11110000" 240) ("11101000" 232) 8)
(decimali "00001111")
;-> (("00001111" 15) ("00010111" 23) 8)

(decimali "01010101")
;-> (("01010101" 85) ("11010100" 212) 127)
(decimali "10101010")
;-> (("10101010" 170) ("00101011" 43) 127)

(decimali "11001100")
;-> (("11001100" 204) ("10110010" 178) 26)
(decimali "00110011")
;-> (("00110011" 51) ("01001101" 77) 26)

(decimali "10110111")
;-> (("10110111" 183) ("01111101" 125) 58)
(decimali "01001000")
;-> (("01001000" 72) ("10000010" 130) 58)


----------------------
Numeri escludivisibili
----------------------

Un numero escluidivisibile ha la seguente proprietà:
ogni cifra divide esattamente il numero formato con le altre cifre.
Vediamo un esempio:

N = 742
Prediamo la cifra 7, il resto delle cifre vale 42: 42/7 = 6
Prediamo la cifra 4, il resto delle cifre vale 72: 72/4 = 18
Prediamo la cifra 2, il resto delle cifre vale 74: 74/2 = 37
Quindi 742 è un numero escludivisibile.

Nota: se il numero contiene la cifra 0, allora non è escludivisibile.
I numeri da 1 a 9 sono tutti escludivisibili.

Sequenza OEIS: A353729
Numbers with property that if any digit is deleted then the result is divisible by that digit
  1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 55, 66, 77, 88, 99, 111, 122,
  124, 126, 142, 155, 162, 168, 186, 222, 244, 248, 284, 324, 333, 342,
  366, 444, 488, 555, 648, 666, 684, 728, 742, 777, 888, 999, 1111, 1113,
  1122, 1124, 1128, 1131, 1142, 1146, 1155, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

Funzione che verifica se un numero è escludivisibile:

(define (escludiv? num)
  (setq digits (int-list num))
  (cond ((find 0 digits) nil)
        ((= (length digits) 1) true)
        (true
          (setq stop nil)
          (dolist (d digits stop)
            (setq cur-num digits)
            (pop cur-num $idx)
            (setq cur-num (list-int cur-num))
            (if (!= (% cur-num d) 0) (setq stop true))
          )
          (not stop))))

Proviamo:

(escludiv? 324)
;-> true

(filter escludiv? (sequence 1 1000))
;-> (1 2 3 4 5 6 7 8 9 11 22 33 44 55 66 77 88 99 111 122 124 126 142
;->  155 162 168 186 222 244 248 284 324 333 342 366 444 488 555 648 666
;->  684 728 742 777 888 999)

(length (filter escludiv? (sequence 1 1e6)))
;-> 3201


----------------------------------------------------------------------
Probabilità di almeno r numeri uguali/diversi scegliendo k numeri su N
----------------------------------------------------------------------

Scegliendo k numeri su N qual è la probabilità che almeno r dei numeri scelti siano tutti uguali?
Scegliendo k numeri su N qual è la probabilità che almeno r dei numeri scelti siano tutti diversi?

Vediamo di scrivere le funzioni che simulano i processi.

Probabilità che almeno r numeri sui k scelti siano tutti uguali
---------------------------------------------------------------

(define (prob-uguali n k r iter)
  (local (eventi seq)
    (setq eventi 0)
    ; lista dei numeri (0..n-1)
    (setq seq (sequence 0 (- n 1)))
    (for (i 1 iter)
      ; selezione di k numeri su (0..n-1)
      (setq choice (rand n k))
      ; conta le occorrenze dei numeri 0..(n-1)
      ; nei k numeri selezionati
      (setq conta (count seq choice))
      ;(println choice)
      ;(print conta) (read-line)
      ; se la massima occorrenza di un numero scelto
      ; è uguale o supera r, allora abbiamo un evento positivo
      (if (>= (apply max conta) r) (++ eventi))
    )
    (div eventi iter)))

Proviamo:

Questo è il caso del problema del compleanno, abbiamo con 22 persone e vogliano sapere la probabilità che almeno 2 di loro abbia lo stesso compleanno.
valore vero = 0.4756953076625502
(prob-uguali 365 22 2 1e5)
;-> 0.4755
(compleanno 22)
;-> 0.4756953076625502

Problema del compleanno: 50 persone e 2 con lo stesso compleanno
valore vero = 0.9703735795779884
(prob-uguali 365 50 2 1e5)
;-> 0.97099

Problema del compleanno: 100 persone e 2 con lo stesso compleanno
valore vero = 0.9999996927510721
(prob-uguali 365 100 2 1e5)
;-> 1

(prob-uguali 1 1 1 1e5)
;-> 1

(prob-uguali 10 5 2 1e5)
;-> 0.69748

Probabilità che almeno r numeri sui k scelti siano tutti diversi
----------------------------------------------------------------

(define (prob-diversi n k r iter)
  (local (eventi seq)
    (setq eventi 0)
    ; lista dei numeri (0..n-1)
    (setq seq (sequence 0 (- n 1)))
    (for (i 1 iter)
      ; selezione di k numeri su (0..n-1)
      (setq choice (rand n k))
      ; conta le occorrenze dei numeri 0..(n-1)
      ; nei k numeri selezionati
      (setq conta (count seq choice))
      ;(println choice)
      ;(print conta) (read-line)
      ; se esistono almeno r occorrenze singole (1)
      ; allora abbiamo un evento positivo
      (if (>= (first (count '(1) conta)) r) (++ eventi))
    )
    (div eventi iter)))

Proviamo:

Questo è il caso in cui r=k.
Probabilità di selezionare r oggetti diversi da N oggetti diversi.
valore vero = 0.72
(prob-diversi 10 3 3 1e6)
;-> 0.72072

Questo è il caso in cui r=k.
Probabilità di selezionare r oggetti diversi da N oggetti diversi.
valore vero = 0.3024
(prob-diversi 10 5 5 1e6)
;-> 0.30284

Probabilità di selezionare 10 cifre diverse.
valore vero = 0.00036288
(prob-diversi 10 10 10 1e7)
;-> 0.000362

Vedi anche "Selezionare k oggetti diversi da N oggetti diversi" su "Note libere 23".

Vedi anche "Il problema del compleanno" su "Problemi vari".


--------------------
Funzioni finanziarie
--------------------

newLISP possiede alcune funzioni per il calcolo di operazioni finanziarie:
"fv", "irr", "nper", "npv", "pmt" e "pv".

*****************
>>>funzione NPER
*****************

Sintassi: (nper num-interest num-pmt num-pv [num-fv [int-type]])
Calcola il numero di pagamenti necessari per pagare un prestito di "num-pv" con un tasso di interesse costante di "num-interest" e pagamento "num-pmt".
Se il pagamento avviene alla fine del periodo, "int-type" è 0 (zero) oppure "int-type" viene omesso.
Per il pagamento all'inizio di ogni periodo, "int-type" è 1.

(nper (div 0.07 12) 775.30 -100000)
;-> 239.9992828

L'esempio calcola il numero di pagamenti mensili necessari per pagare un prestito di $100000 a un tasso di interesse annuo del 7% con pagamenti di $775.30.

Vedi anche le funzioni fv, irr, npv, pmt e pv.

****************
>>>funzione NPV
****************
Sintassi: (npv num-interest list-values)

Calcola il valore attuale netto di un investimento con un tasso di interesse fisso "num-interest" e una serie di pagamenti e redditi futuri in "list-values".
I pagamenti sono rappresentati da valori negativi in "list-values", mentre i redditi sono rappresentati da valori positivi in "list-values".

(npv 0.1 '(1000 1000 1000))
;-> 2486.851991

(npv 0.1 '(-2486.851991 1000 1000 1000))
;-> -1.434386832e-08  ; ~ 0.0 (zero)

Nell'esempio, un investimento iniziale di $2481.85 consentirebbe un reddito di $1000 dopo la fine del primo, secondo e terzo anno.

Vedi anche le funzioni fv, irr, npv, pmt e pv.

***************
>>>funzione FV
***************
Sintassi: (fv num-rate num-nper num-pmt num-pv [int-type])

Calcola il valore futuro di un prestito con pagamento costante "num-pmt" e tasso di interesse costante "num-rate" dopo un periodo di tempo "num-nper" e un valore del capitale iniziale di "num-pv".
Se il pagamento avviene alla fine del periodo, "int-type" è 0 (zero) oppure "int-type" viene omesso.
Per il pagamento all'inizio di ogni periodo, "int-type" è 1.

(fv (div 0.07 12) 240 775.30 -100000)
;-> -0.5544645052

L'esempio illustra come un prestito di $100000 viene rimborsato fino a un residuo di $0.55 dopo 240 pagamenti mensili a un tasso di interesse annuo del 7%.

Vedi anche le funzioni fv, irr, npv, pmt e pv.

****************
>>>funzione IRR
****************
Sintassi: (irr list-amounts [list-times [num-guess]])

Calcola il tasso di rendimento interno di un flusso di cassa per periodo di tempo.
Il tasso interno di rendimento è il tasso di interesse che rende il valore attuale di un flusso di cassa pari a 0,0 (zero).
Gli importi in entrata (valori negativi) e in uscita (valori positivi) sono specificati in "importi-elenco".
Se in "list-times" non sono specificati periodi di tempo, gli importi in "list-amounts" corrispondono a periodi di tempo consecutivi aumentati di 1 (1, 2, 3—).
L'algoritmo utilizzato è iterativo, con un'ipotesi iniziale di 0,5 (50%).
Facoltativamente, è possibile specificare un'ipotesi iniziale diversa.
L'algoritmo restituisce un risultato quando viene raggiunta una precisione pari a 0,000001 (0,0001%).
Viene restituito nil se l'algoritmo non può convergere dopo 50 iterazioni.

"irr" viene spesso utilizzato per decidere tra diversi tipi di investimenti.

(irr '(-1000 500 400 300 200 100))
;-> 0.2027

(npv 0.2027 '(500 400 300 200 100))
;-> 1000.033848 ; ~ 1000

(irr '(-1000 500 400 300 200 100) '(0 3 4 5 6 7))
;-> 0.0998

(irr '(-5000 -2000 5000 6000) '(0 3 12 18))
;-> 0.0321

Se un investimento iniziale di 1000 produce 500 dopo il primo anno, 400 dopo due anni e così via, fino a raggiungere 0.0 (zero) dopo cinque anni, ciò corrisponde a un rendimento annuo di circa il 20.2%.
La riga successiva dimostra la relazione tra "irr" e "npv".
Per il primo prelievo dopo tre anni è necessario un rimborso pari solo al 9.9%.

Nell'ultimo esempio i titoli sono stati acquistati inizialmente per 5000, poi per altri 2000 tre mesi dopo.
Dopo un anno vengono venduti titoli per 5000.
La vendita dei titoli rimanenti dopo 18 mesi rende 6000.
Il tasso di rendimento interno è del 3.2% al mese, ovvero circa il 57% in 18 mesi.

Vedi anche le funzioni fv, irr, npv, pmt e pv.

****************
>>>funzione PMT
****************
Sintassi: (pmt num-interest num-periods num-principal [num-future-value [int-type]])

Calculates the payment for a loan based on a constant interest of "num-interest" and constant payments over "num-periods" of time.
"num-future-value" is the value of the loan at the end (typically 0.0).
If payment is at the end of the period, "int-type is" 0 (zero) or "int-type" is omitted.
For payment at the beginning of each period, "int-type" is 1.

(pmt (div 0.07 12) 240 100000)
;-> -775.2989356

L'esempio precedente calcola un pagamento di $775.30 per un prestito di $100000 con un tasso di interesse annuo del 7%.
Viene calcolato mensilmente e pagato in 20 anni (20*12 = 240 periodi mensili).
Ciò illustra il modo tipico in cui viene calcolato il pagamento dei mutui.

Vedi anche le funzioni fv, irr, npv, pmt e pv.

***************
>>>funzione PV
***************
Sintassi: (pv num-int num-nper num-pmt [num-fv [int-type]])

Calcola il valore attuale di un prestito con il tasso di interesse costante "num-interest" e il pagamento costante "num-pmt" dopo il numero di pagamenti "num-nper".
Se omesso, si presuppone che il valore futuro "num-fv" sia 0.0.
Se il pagamento avviene alla fine del periodo, "int-type" è 0 (zero) oppure "int-type" viene omesso.
Per il pagamento all'inizio di ogni periodo, "int-type" è 1.

(pv (div 0.07 12) 240 775.30)
;-> -100000.1373

Nell'esempio, un prestito che verrebbe ripagato (valore futuro = 0.0) in 240 pagamenti di $775.30 a un tasso di interesse costante del 7% annuo inizierebbe a $100000.14.

(pv (div 0.07 12) 240 775.30)
;-> -100000.1373

In the example, a loan that would be paid off (future value = 0.0) in 240 payments of $775.30 at a constant interest rate of 7 percent per year would start out at $100000.14.

Vedi anche le funzioni fv, irr, npv, pmt e pv.


----------------
Puzzle cromatico
----------------

https://puzzling.stackexchange.com/questions/36479/is-this-chromatic-puzzle-always-solvable

Il puzzle consiste in una griglia 8x8 in cui a ogni quadrato viene assegnato casualmente uno di tre colori.
Una mossa consiste nel selezionare due quadrati adiacenti ortogonali qualsiasi (formando una forma di domino) che hanno colori differenti e colorarli con il terzo colore
L'obiettivo è raggiungere una griglia con un solo colore.

È stato dimostrato che è possibile risolvere qualsiasi rettangolo MxN, purché M e N non siano divisibili per 3.

Per risolvere il problema occorre applicare la seguente strategia:
Rendere tutti i quadrati di ogni riga di un unico colore, usando solo tessere del domino orizzontali.
Ripetere il processo verticalmente per rendere tutti i quadrati di ciascuna colonna di un unico colore, utilizzando solo tessere del domino verticali.

Scriviamo alcune funzione per giocare con questo tipo di puzzle:

Funzione che stampa il puzzle:

(define (print-matrix grid)
  (local (rows cols)
    (setq rows (length grid))
    (setq cols (length (first grid)))
    (println "  " (join (map string (sequence 0 (- cols 1))) " "))
    (for (i 0 (- rows 1))
      (print i { })
      (for (j 0 (- cols 1))
        ; print numbers instead of colors
        ;(print (grid i j) " ")
        ; print colors
        (cond ((= (grid i j) 0) (print _red "██" _reset-cols))
              ((= (grid i j) 1) (print _yellow  "██" _reset-cols))
              ((= (grid i j) 2) (print _green "██" _reset-cols))
              (true (println "ERROR" ))
        )
      )
      (println)
    ) '>))

Funzione che inizia un nuovo puzzle:

(define (new-game rows cols)
  (define _red "\027[0;31m")
  (define _green "\027[0;32m")
  (define _yellow "\027[0;33m")
  (define _reset-cols "\027[39;49m")
  (setq m (array rows cols (rand 3 (* rows cols))))
  (setq target 0)
  (print-matrix m)
)

(new-game 4 4)

Funzione che effettua una mossa:

(define (move r1 c1 r2 c2)
  (setq rows (length m))
  (setq cols (length (m 0)))
  (setq mossa true)
  (cond ((> r1 (- rows 1))
          (println "Error: row " r1 " not exists") (setq mossa nil))
        ((< r1 0)
          (println "Error: row " r1 " not exists") (setq mossa nil))
        ((> c1 (- cols 1))
          (println "Error: column " c1 " not exists") (setq mossa nil))
        ((< c1 0)
          (println "Error: column " c1 " not exists") (setq mossa nil))
        ((> r2 (- rows 1))
          (println "Error: row " r2 " not exists") (setq mossa nil))
        ((< r2 0)
          (println "Error: row " r2 " not exists") (setq mossa nil))
        ((> c2 (- cols 1))
          (println "Error: column " c2 " not exists") (setq mossa nil))
        ((< c2 0)
          (println "Error: column " c2 " not exists") (setq mossa nil))
        ((and (= r1 r2) (!= (abs (- c1 c2)) 1))
          (println "Error: " r1 "," c1 " and " r2 "," c2 " are not adjacent")
          (setq mossa nil))
        ((and (= c1 c2) (!= (abs (- r1 r2)) 1))
          (println "Error: " r1 "," c1 " and " r2 "," c2 " are not adjacent")
          (setq mossa nil))
        ((and (!= r1 r2) (!= c1 c2))
          (println "Error: " r1 "," c1 " and " r2 "," c2 " are not adjacent")
          (setq mossa nil))
        ((= (m r1 c1) (m r2 c2))
          (println "Error: same color " r1 "," c1 " and " r2 "," c2)
          (setq mossa nil))
        (true ; mossa regolare
          (setq new-value (first (difference '(0 1 2) (list (m r1 c1) (m r2 c2)))))
          (setf (m r1 c1) new-value)
          (setf (m r2 c2) new-value)
          (print-matrix m))))

Facciamo una partita:
(in realtà l'output è a colori, vedi l'immagine "chroma-puzzle.png" nela cartella "data")

(new-game 2 2)
  0 1
0 0 1
1 1 1
>
(move 0 0 0 1)
  0 1
0 2 2
1 1 1
>
(move 0 0 0 1)
;-> Error: same color 0,0 and 0,1
;-> nil
(move 0 0 1 0)
;->   0 1
;-> 0 1 2
;-> 1 1 0
>
(move 0 1 1 0)
;-> Error: 0,1 and 1,0 are not adjacent
;-> nil
(move 0 1 1 1)
;->   0 1
;-> 0 1 1
;-> 1 1 1


----------------
Pseudofattoriale
----------------

Lo pseudofattoriale di un numero intero N è il minimo comune multiplo dei numeri da 1 a N.
In altre parole, è il numero più basso che ha come fattori tutti i numeri da 1 a N.

Sequenza OEIS: A003418
Least common multiple (or LCM) of {1, 2, ..., n} for n >= 1, a(0) = 1
  1, 1, 2, 6, 12, 60, 60, 420, 840, 2520, 2520, 27720, 27720, 360360, 360360,
  360360, 720720, 12252240, 12252240, 232792560, 232792560, 232792560,
  232792560, 5354228880, 5354228880, 26771144400, 26771144400, 80313433200,
  80313433200, 2329089562800, 2329089562800, ...

(define (lcm_ a b) (/ (* a b) (gcd a b)))

(define-macro (lcm)
"Calculates the lcm of two or more number"
  (apply lcm_ (map eval (args)) 2))

(define (lcm-sum num) (apply lcm (sequence 1 num)))

(lcm-sum 2)
;-> 2520

Versione base:

(define (seq1 limit)
  (let (out '(1 1))
    (for (i 2 (- limit 1)) (push (lcm-sum i) out -1))
    out))

(seq1 20)
;-> (1 1 2 6 12 60 60 420 840 2520 2520 27720 27720 360360 360360 360360
;->  720720 12252240 12252240 232792560)

Nota: lcm(1..N) = lcm(N, lcm(1..(N-1)))

(lcm 1 2)
;-> 2
(lcm 2 2)
;-> 2
(lcm 2 3)
;-> 6
(lcm 6 4)
;-> 12
(lcm 12 5)
;-> 60
(lcm 60 6)
;-> 60
(lcm 60 7)
;-> 420
...

Versione ottimizzata:

(define (seq2 limit)
  (let ( (out '(1)) (a 1L) )
    (for (i 1 (- limit 1))
      (setq a (/ (* a i) (gcd a i)))
      (push a out -1))
    out))

(seq2 20)
;-> (1 1 2 6 12 60 60 420 840 2520 2520 27720 27720 360360 360360 360360
;->  720720 12252240 12252240 232792560)

(= (seq1 20) (seq2 20))
;-> true

(time (seq1 30) 1e4)
;-> 1335.459

(time (seq2 30) 1e4)
;-> 272.375


-----------------------------
Strette di mano (handshaking)
-----------------------------

Il problema delle strette di mano è un problema classico con la seguente formulazione: se ci sono N persone in una stanza e tutti si stringono la mano, qual è il numero totale di strette di mano che si verificano?

Per trovare la funzione che calcola le strette di mano per N persone utilizziamo il Metodo delle differenze.
Vedi "Polinomi generatori di sequenze - Metodo delle differenze" su "Note libere 15".

Persone: 1, 2, 3, 4, 5,  6,...
Strette: 0, 1, 3, 6, 10, 15, ...

Differenze: 1 2 3 4 5
             1 1 1 1

Equazione di secondo grado: P(N) = a*N^2 + b*N + c

Sistema di equazioni per trovare a, b e c:

  P(1) = a + b + c = 0
  P(2) = 4a + 2b + c = 1
  P(3) = 9a + 3b + c = 3

Soluzione: a = 1/2, b = -1/2, c = 0

P(N) = (1/2)N^2 - (1/2)N = (N*(N-1))/2

Formula che fornisce il numero di strette di mano tra N persone:

               N*(N-1) 
  handshake = ---------
                  2

Si tratta della formula della somma dei primi N numeri interi utilizzando (N-1) al posto di N.

 Sum[i=1..N](i) = (N*(N+1))/2

(define (handshake num) (/ (* num (- num 1)) 2))

(map handshake (sequence 1 20))
;-> (0 1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190)

(define (sum num) (/ (* num (+ num 1)) 2))

(map sum (sequence 1 20))
;-> (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210)


----------------
Orologio binario
----------------

La funzione "now" restituisce una lista con i seguenti elementi:

Name	                        Description
-----------------------------------------
year	                        Gregorian calendar
month	                        (1–12)
day	                          (1–31)
hour	                        (0–23) UTC
minute	                      (0–59)
second	                      (0–59)
microsecond	                  (0–999999) OS-specific, millisecond resolution
day of current year	          Jan 1st is 1
day of current week        	  (1–7) starting Monday
time zone offset in minutes	  west of GMT including daylight savings bias
daylight savings time type	  (0–6) on Linux/Unix or (0–2) on MS Windows

Prima rappresentazione
----------------------
Orario: 10:37:49
Binario: 1010:100101:110001

(define (binclock1 show)
  (local (orario bin-h bin-m bin-s)
    (setq orario (now))
    (setq hours (orario 3))
    (setq mins (orario 4))
    (setq secs (orario 5))
    (setq bin-h (bits hours))
    (setq bin-m (bits mins))
    (setq bin-s (bits secs))
    (if show (println hours ":" mins ":" secs))
    (println bin-h ":" bin-m ":" bin-s) '>))

(binclock1 true)
;-> 14:42:9
;-> 1110:101010:1001

Seconda rappresentazione
------------------------
Orario: 10:37:49
Binario:
     H M S
   1 0 1 1
   2 1 0 0
   4 0 1 0
   8 1 0 0
  16 0 0 1
  32 0 1 1

(define (print-matrix grid)
  (local (rows cols)
    (setq rows (length grid))
    (setq cols (length (first grid)))
    ;(println "  " (join (map string (sequence 0 (- cols 1))) " "))
    (for (i 0 (- rows 1))
      ;(print i { })
      (for (j 0 (- cols 1))
         (print (grid i j) " ")
      )
      (println)
    ) '>))

(define (binclock2 show)
  (local (orario binary hours mins secs bin-h bin-m bin-s matrix)
    (setq orario (now))
    (setq binary '(" 1" " 2" " 4" " 8" "16" "32"))
    (setq hours (orario 3))
    (setq mins (orario 4))
    (setq secs (orario 5))
    (setq bin-h (format "%06s" (bits hours)))
    (setq bin-m (format "%06s" (bits mins)))
    (setq bin-s (format "%06s" (bits secs)))
    (setq bin-h (reverse (explode bin-h)))
    (setq bin-m (reverse (explode bin-m)))
    (setq bin-s (reverse (explode bin-s)))
    (setq matrix (transpose (list binary bin-h bin-m bin-s)))
    (if show (println hours ":" mins ":" secs))
    (println "   H M S")
    (print-matrix matrix)) '>)

(binclock2 true)
;-> 15:43:49
;->    H M S
;->  1 1 1 1
;->  2 1 1 0
;->  4 1 0 0
;->  8 1 1 0
;-> 16 0 0 1
;-> 32 0 1 1

Terza rappresentazione
----------------------
Orario: 10:37:49
Binario:
     H H  M M  S S
  1  1 0  1 1  0 1
  2  0 0  1 1  0 0
  4  0 0  0 1  1 0
  8  0 0  0 0  0 1
  ----------------
     1 0  3 7  4 9

(define (binclock3 show)
  (local (orario binary hours mins secs bin-h bin-m bin-s matrix
          h1 h2 m1 m2 s1 s2 bin-h1 bin-h2 bin-m1 bin-m2 bin-s1 bin-s2)
    (setq orario (now))
    (setq binary '("1" "2" "4" "8"))
    (setq hours (orario 3))
    (setq mins (orario 4))
    (setq secs (orario 5))
    (if (< hours 10) 
        (set 'h1 0 'h2 hours)
        (set 'h1 (/ hours 10) 'h2 (% hours 10)))
    (if (< mins 10) 
        (set 'm1 0 'm2 mins)
        (set 'm1 (/ mins 10) 'm2 (% mins 10)))
    (if (< secs 10) 
        (set 's1 0 's2 hours)
        (set 's1 (/ secs 10) 's2 (% secs 10)))
    (setq bin-h1 (format "%04s" (bits h1)))
    (setq bin-h2 (format "%04s" (bits h2)))
    (setq bin-m1 (format "%04s" (bits m1)))
    (setq bin-m2 (format "%04s" (bits m2)))
    (setq bin-s1 (format "%04s" (bits s1)))
    (setq bin-s2 (format "%04s" (bits s2)))
    (setq bin-h1 (reverse (explode bin-h1)))
    (setq bin-h2 (reverse (explode bin-h2)))
    (setq bin-m1 (reverse (explode bin-m1)))
    (setq bin-m2 (reverse (explode bin-m2)))
    (setq bin-s1 (reverse (explode bin-s1)))
    (setq bin-s2 (reverse (explode bin-s2)))
    (setq matrix (transpose 
          (list binary bin-h1 bin-h2 bin-m1 bin-m2 bin-s1 bin-s2)))
    (if show (println hours ":" mins ":" secs))
    (println "  H H M M S S")
    (print-matrix matrix)) '>)

(binclock3 true)
;-> 15:56:34
;->   H H M M S S
;-> 1 1 1 1 0 1 0
;-> 2 0 0 0 1 1 0
;-> 4 0 1 1 1 0 1
;-> 8 0 0 0 0 0 0


---------------------------------------------------
Rimuovere le occorrenze di un elemento in una lista
---------------------------------------------------

Il problema è quello di rimuovere la prima o tutte le occorrenze di un elemento in una lista (annidata e non).

Per togliere la prima occorrenza di un elemento in una lista non annidata possiamo usare la seguente funzione:

(define (remove-first elt lst)
  (let ((elt-pos (find elt lst)))
    (if elt-pos (pop lst elt-pos))
    lst))

(setq lst '(a a b c b a b))
(remove-first 'a lst)
;-> (a b c b a b)

Sostituendo "find" con "ref" possiamo applicare la funzione anche alle liste annidate:

(define (remove-first elt lst)
  (let ((elt-pos (ref elt lst)))
    (if elt-pos (pop lst elt-pos))
    lst))

(setq lst '(a a b c b a b))
(remove-first 'a lst)
;-> (a b c b a b)

(setq lst '((a b) a (a b c) (b (c (a))) a))
(remove-first 'a lst)
;-> ((b) a (a b c) (b (c (a))) a)

Per rimuovere tutte le occorrenze di un elemento in una lista non annidata possiamo usare la funzione primitiva "replace":

(setq lst '(a a b c b a b))
(replace 'a lst)
;-> (b c b b)

Purtroppo se la lista è annidata "replace" rimuove solo le occorrenze di primo livello dell'elemento:

(setq lst '((a b) a (a b c) (b (c (a))) a))
(replace 'a lst)
;-> ((a b) (a b c) (b (c (a))))
Non vengono rimosse le occorrenze che sono annidate.

Scriviamo una funzione per rimuovere tutte le occorrenze di un elemento in una lista annidata.

Metodo ricorsivo:

(define (remove1 element lst)
  (cond
    ((atom? lst) lst)
    ((= (length lst) 0) '())
    ((= (first lst) element) (remove1 element (rest lst)))
    (true (cons (remove1 element (first lst))
                (remove1 element (rest lst))))))

(setq lst '((a b) a (a b c) (b (c (a))) a))
(remove1 'a lst)
;-> ((b) (b c) (b (c ())))

Metodo iterativo:

(define (remove2 element lst)
  (while (setq idx (ref element lst)) (pop lst idx))
  lst)

(setq lst '((a b) a (a b c) (b (c (a))) a))
(remove2 'a lst)
;-> ((b) (b c) (b (c ())))

Vediamo la velocità delle funzioni:

(setq t '((1 (2 (3 4 (5 6)) 5 )) 5 (4 (5 6 (7 5)) 5) (1 (5) 5 (5) 6 (7 (5)))))

(= (remove1 5 t) (remove2 5 t))
;-> true

(time (remove1 5 t) 1e5)
;-> 1099.06
(time (remove2 5 t) 1e5)
;-> 283.27

Scriviamo una funzione più generica che permette di eliminare la prima o tutte le occorrenze di un elemento per liste annidate e non annidate.

(define (remove elt lst all)
  (cond (all
          (while (setq idx (ref elt lst)) (pop lst idx))
          lst)
        (true
          (let ((elt-pos (ref elt lst)))
            (if elt-pos (pop lst elt-pos))
            lst))))

Se il parametro 'all' vale true, allora elimina tutte le occorrenze.

Proviamo:

(setq lst '((a b) a (a b c) (b (c (a))) a))
(remove 'a lst)
;-> ((b) a (a b c) (b (c (a))) a)
(remove 'a lst true)
;-> ((b) (b c) (b (c ())))

(setq lst '(a a b c b a b))
(remove 'a lst)
;-> (a b c b a b)
(remove 'a lst true)
;-> (b c b b)


---------------------------------------------------------------------------
Numero maggiore di N con somma digitale pari a N o alla somma digitale di N
---------------------------------------------------------------------------

1) Dato un numero intero positivo N, trovare il primo numero maggiore di N che ha la somma digitale pari a N.

Per esempio:
N = 1
Il primo numero successivo a 1 che ha somma digitale pari a 1 è 10.

Sequenza OEIS: A161561
The smallest number larger than n with digital sum equal to n
  10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 29, 39, 49, 59, 69, 79, 89, 99,
  199, 299, 399, 499, 599, 699, 799, 899, 999, 1999, 2999, 3999, 4999,
  5999, 6999, 7999, 8999, 9999, 19999, 29999, 39999, 49999, 59999, 69999,
  79999, 89999, 99999, 199999, 299999, 399999, ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (major1 num)
  (local (found cur-num)
    (setq found nil)
    (setq cur-num num)
    (until found
      (++ cur-num)
      (if (= num (digit-sum cur-num)) (setq found true))
    )
    cur-num))

Proviamo:

(map major1 (sequence 1 30))
;-> (10 11 12 13 14 15 16 17 18 19 29 39 49 59 69 79 89 99
;->  199 299 399 499 599 699 799 899 999 1999 2999 3999)


2) Dato un numero intero positivo N, trovare il primo numero maggiore di N che ha la stessa somma digitale di N.

Per esempio:
N = 10
La somma digitale di 10 vale 1.
Il primo numero successivo a 10 che ha somma digitale pari a 1 è 100.

Sequenza OEIS: 228915
Next larger integer with same digital sum as n
  10, 11, 12, 13, 14, 15, 16, 17, 18, 100, 20, 21, 22, 23, 24, 25, 26, 27,
  28, 101, 30, 31, 32, 33, 34,  35, 36, 37, 38, 102, 40, 41, 42, 43, 44,
  45, 46, 47, 48, 103, 50, 51, 52, 53, 54, 55, 56, 57, 58, 104, 60, 61,
  62, 63, 64, 65, 66, 67, 68, 105, 70, 71, 72, ...

(define (major2 num)
  (local (dsum found cur-num)
    (setq dsum (digit-sum num))
    (setq found nil)
    (setq cur-num num)
    (until found
      (++ cur-num)
      (if (= dsum (digit-sum cur-num)) (setq found true))
    )
    cur-num))

Proviamo:

(map major2 (sequence 1 30))
;-> (10 11 12 13 14 15 16 17 18 100 20 21 22 23 24 25
;->  26 27 28 101 30 31 32 33 34 35 36 37 38 102)


-------------------------
Scacchi e chicchi di riso
-------------------------

Una leggenda indiana racconta che l'inventore del gioco degli scacchi sarebbe stato ricompensato dal suo imperatore con qualsiasi cosa egli avesse chiesto.
L'uomo chiese di essere pagato in riso.
Voleva un chicco di riso per la prima casella della scacchiera, due per la seconda, quattro per la terza, otto per la quarta e così via, fino alla 64-esima casella.
L'imperatore rimase stupito che l'uomo chiedesse una ricompensa così piccola, ma quando i suoi matematici terminarono il conteggio si accorse di non avere abbastanza riso per pagare.

Data la lunghezza del lato di un'ipotetica scacchiera (valore standard 8) e il moltiplicatore tra le caselle (nella leggenda vale 2), calcolare il numero di chicchi di riso da pagare.

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1L
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Funzione che calcola i chicchi di riso necessari per una scacchiera di un certo lato e con un certo moltiplicatore:

(define (chicchi lato molt)
      ; se il moltiplicatore vale 1...
  (if (= molt 1) (* lato lato)
      ; se il moltiplicatoe è maggiore di 1...
      (let (out 0L)
        (for (i 0 (- (* lato lato) 1)) (++ out (** molt i)))
        out)))

Proviamo:

(chicchi 8 2)
;-> 18446744073709551615L

(chicchi 8 3)
;-> 1716841910146256242328924544640L

(chicchi 256 1)
;-> 65536

(chicchi 3 6)
;-> 2015539L

(chicchi 6 4)
;-> 1574122160956548404565L

(chicchi 5 -3)
;-> 211822152361L

Vedi anche "La leggenda della nascita degli scacchi" in "Note libere 12".


---------------------------
Sistema di numerazione Maya
---------------------------

Il sistema di numerazione usato dai Maya era vigesimale (a base venti), posizionale e comprendeva l'uso dello zero.
I numeri erano rappresentati attraverso tre simboli, una conchiglia vuota, un puntino ed una striscia.
A volte le cifre erano rappresentate come glifi a forma di faccia (questo uso è però raro).
Conversione da base 10 a base 20 e viceversa
La conchiglia rappresenta lo zero, mentre le cifre da 1 a 19 erano rappresentati nel modo seguente:

  1  2   3    4     5     
  *  **  ***  ****  ====
 
  6     7     8     9     10
  *     **    ***   ****  ====
  ====  ====  ====  ====  ====
  
  11    12    13    14    15
  *     **    ***   ****  ====
  ====  ====  ====  ====  ====
  ====  ====  ====  ====  ====

  16    17    18    19  
  *     **    ***   ****
  ====  ====  ====  ====
  ====  ====  ====  ====
  ====  ====  ====  ====

Vedi immagine "maya.png" nella cartella "data".

Funzione che converte un numero da base 10 a base 20:

(define (b10-b20 number)
  (let ((base 20)
        (charset "0123456789ABCDEFGHIJ")
        (result '())
        (quotient number))
    (while (>= quotient base)
      (push (charset (% quotient base)) result)
      (setq quotient (/ quotient base))
    )
    (push (charset quotient) result)
    (join result)))

Proviamo:

(b10-b20 123)
;-> "63"

Funzione che converte un numero (stringa) da base 20 a base 10:

(define (b20-b10 number-string)
  (let ((base 20)
        (charset "0123456789ABCDEFGHIJ")
        (result 0)
        (len (length number-string)))
    (dolist (digit (explode number-string))
      (setq result (+ (* result base) (find digit charset)))
    )
    result))

Proviamo:

(b20-b10 "63")
;-> 123

(b10-b20 4232)
;-> "ABC"
(b20-b10 "ABC")
;-> 4232

(b10-b20 123456789)
;-> "1IBC1J9"
(b20-b10 "1IBC1J9")
;-> 187456389


-------------------------------------------
Conversione da base 10 a base N e viceversa
-------------------------------------------

Per convertire un numero da base 10 a base N abbiamo bisogno di N simboli diversi.
Possiamo utilizzare le cifre da 0 a 9 (9), le lettere maiuscole da 'A' a 'Z' (26) e le lettere minuscole da 'a' a 'z' (26).
In totale abbiamo a disposizione 62 simboli diversi, quindi la base N è compresa tra 2 e 62.

Funzione che converte da base 10 a base N:

(define (base10-baseN number base)
  (let ((charset "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        (result '())
        (quotient number))
    (while (>= quotient base)
      (push (charset (% quotient base)) result)
      (setq quotient (/ quotient base))
    )
    (push (charset quotient) result)
    (join result)))

Proviamo:

(base10-baseN 123 20)
;-> "63"

(base10-baseN 123 60)
;-> "23"

Funzione che converte da base N a base 10::

(define (baseN-base10 number-string base)
  (let ((charset "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        (result 0)
        (len (length number-string)))
    (dolist (digit (explode number-string))
      (setq result (+ (* result base) (find digit charset)))
    )
    result))

Proviamo:

(baseN-base10 "23" 60)
;-> 123
(baseN-base10 "63" 20)
;-> 123

(base10-baseN 123456789 20)
;-> "1IBC1J9"
(baseN-base10 "1IBC1J9" 20)
;-> 123456789

Funzione che verifica la correttezza delle funzioni "base10-baseN" e "baseN-base10":

(define (test prove)
  (local (rnd base)
    (for (i 1 prove)
      (setq rnd (rand 1e8))
      (setq base (+ 2 (rand 61)))
      (if (!= rnd (baseN-base10 (base10-baseN rnd base) base))
          (println rnd)))))

(test 1e6)
;-> nil


--------------------------
Palindromi di Watson-Crick
--------------------------

Una stringa di DNA contiene quattro tipi di caratteri:

  A = Adenina
  T = Timina
  C = Citosina
  G = Guanina

Una stringa di DNA è un palindromo di Watson-Crick se il complemento del suo inverso è uguale a se stesso.
Data una stringa di DNA, prima invertirla e poi fare il complemento secondo la seguente trasformazione delle basi del DNA: (A <--> T e C <--> G).
Se la stringa originale è uguale al complemento della stringa inversa, allora è un palindromo di Watson-Crick.

(define (dna-pali str)
  (let ( (comp "") (inv (reverse (copy str))) )
    (dolist (ch (explode inv))
      (cond ((= ch "A") (extend comp "T"))
            ((= ch "T") (extend comp "A"))
            ((= ch "C") (extend comp "G"))
            ((= ch "G") (extend comp "C"))
            (true (println "Error: " ch " is not a DNA base"))
      )
    )
    (= comp str)))

Proviamo:

(dna-pali "ATCGCGAT")
;-> true
(dna-pali "AGT")
;-> nil
(dna-pali "GTGACGTCAC")
;-> true
(dna-pali "GTACGTAC")
;-> true
(dna-pali "GCAGTGA")
;-> nil
(dna-pali "GCGC")
;-> true
(dna-pali "AACTGCGTTTAC")
;-> nil
(dna-pali "ACTG")
;-> nil


----------------------------
Bit di parità di una stringa
----------------------------

Il bit di parità è un codice di controllo che viene utilizzato per prevenire errori nella trasmissione o nella memorizzazione dei dati. 
Tale sistema prevede l'aggiunta di un bit ridondante ai dati, calcolato a seconda che il numero di bit che valgono 1 sia pari o dispari. 
I bit di parità sono uno dei codici di rilevazione e correzione d'errore più semplici.
Ci sono due varianti del bit di parità: bit di parità pari e bit di parità dispari.
Bit di parità pari: vale 1 se il numero di "1" in un certo insieme di bit è dispari (facendo diventare il numero totale di "1" pari). 
Bit di parità dispari: vale 1 se il numero di "1" in un certo insieme di bit è pari (facendo diventare il numero totale di "1" dispari).
Il bit di parità è un caso particolare di cyclic redundancy check (CRC), quando il 1-bit CRC è generato dal polinomio (x + 1).

Il bit di parità per una stringa viene calcolato utilizzando come insieme di bit i valori binari dei caratteri ASCII che compongono la stringa.
Per esempio:

  stringa = "pippo"
  p = 112 --> 1110000 contiene (3 '1')
  i = 105 --> 1101001 contiene (4 '1')
  p = 112 --> 1110000 contiene (3 '1')
  p = 111 --> 1110000 contiene (3 '1')
  o = 111 --> 1101111 contiene (6 '1')
  Numero totale bit  = 3 + 4 + 3 + 3 + 6 = 19
  Bit di parità (pari): 1
  Bit di parità (dispari): 0

Questo metodo consente la rilevazione di un singolo errore e garantisce di rilevare solo un numero dispari di errori (infatti un numero pari di errori è impossibile da rilevare).

(define (parity str type)
  (let (binary "")
    (dostring (x str)
      (extend binary (bits x))
    )
    (setq uno (length (find-all "1" binary)))
    ; type = 0 --> parity even
    ; type = 1 --> parity odd
    (cond ((and (= type 0) (odd? uno)) 1)
          ((and (= type 0) (even? uno)) 0)
          ((and (= type 1) (odd? uno)) 0)
          ((and (= type 1) (even? uno)) 1))))

Proviamo:

(parity "pippo" 0)
;-> 1
(parity "pippo" 1)
;-> 0

(parity "newLISP" 0)
;-> 1
(parity "newLISP" 1)
;-> 0


------------------------------------------------------
Corrispondenza uno-a-uno tra interi e coppie di interi
------------------------------------------------------

In matematica, le corrispondenze biunivoche tra coppie di numeri interi e numeri interi positivi possono essere stabilite utilizzando varie tecniche. Un metodo comune consiste nell'utilizzare una funzione di abbinamento.
La formula per la funzione di accoppiamento, spesso indicata come P(x, y), che mappa coppie di numeri interi non negativi (x, y) in un unico numero intero positivo, è:

  P(x, y) = (x + y)*(x + y + 1)/2 + y

E l'inverso di questa funzione, che associa un intero positivo z alla corrispondente coppia di interi non negativi (x, y), è dato da:

  x = w - t
  y = t

dove w è il più grande intero tale che w*(w + 1)/2 <= z e t viene calcolato come:

  t = z - w*(w + 1)/2

Questa formula stabilisce una corrispondenza uno a uno tra coppie di numeri interi non negativi e numeri interi positivi.

(define (pairing-function x y)
  (+ (/ (* (+ x y) (+ x y 1)) 2) y))

Proviamo:

(pairing-function 3 4)
;-> 32
(pairing-function 5 7)
;-> 85

(define (inverse-pairing-function z)
  (letn ( (w (/ (floor (sub (sqrt (add (mul 8 z) 1)) 1)) 2))
          (t (- z (/ (* w (+ w 1)) 2))) )
  (list (- w t) t)))

Proviamo:

(inverse-pairing-function 32)
;-> (3 4)

(inverse-pairing-function 85)
;-> 5 7

Funzione di test:

(define (test prove)
  (local (x y z)
    (for (i 1 prove)
      (setq x (rand 1e6))
      (setq y (rand 1e6))
      (setq z (pairing-function x y))
      (if (!= (inverse-pairing-function z) (list x y))
          (println x { } y { } z)))))

(test 1e6)
;-> nil


------------------------------------------
Massimo prodotto di due interi con somma N
------------------------------------------

Dato un numero intero positivo N, determinare il prodotto massimo di due numeri interi la cui somma è N.

Sequenza OEIS: A002620
Quarter-squares: a(n) = floor(n/2)*ceiling(n/2) or a(n) = floor(n^2/4)
  0, 0, 1, 2, 4, 6, 9, 12, 16, 20, 25, 30, 36, 42, 49, 56, 64, 72, 81, 90,
  100, 110, 121, 132, 144, 156, 169, 182, 196, 210, 225, 240, 256, 272,
  289, 306, 324, 342, 361, 380, 400, 420, 441, 462, 484, 506, 529, 552,
  576, 600, 625, 650, 676, 702, 729, 756, 784, 812, ...

Possiamo trovare il prodotto massimo analizzando tutte le possibili coppie di numeri interi la cui somma dà come risultato N e tenendo traccia del prodotto massimo trovato.

(define (max-product-with-sum n)
  (let ( (max-product 0) (i-max -1) (j-max -1) )
    (for (i 1 (floor (/ n 2)))
      (let ((j (- n i)))
        (when (> (* i j) max-product)
          (set 'max-product (* i j) 'i-max i 'j-max j))))
    (list max-product i-max j-max)))

Proviamo:

(max-product-with-sum 10)
;-> (25 5 5)
(max-product-with-sum 11)
;-> (30 5 6)

(map first (map max-product-with-sum (sequence 0 20)))
;-> (0 0 1 2 4 6 9 12 16 20 25 30 36 42 49 56 64 72 81 90 100)

Possiamo anche utilizzare direttamente la formula:

  a(n) = floor(n^2/4)

(define (seq n)
  (floor (/ (* n n) 4)))

(map seq (sequence 0 20))
;-> (0 0 1 2 4 6 9 12 16 20 25 30 36 42 49 56 64 72 81 90 100)

============================================================================
