================

 NOTE LIBERE 23

================

  "Il samsara è in nulla differente dal nirvana.
   Il nirvana è in nulla differente dal samsara.
   I confini del nirvana sono i confini del samsara.
   Tra questi due non c'è alcuna differenza."
   Nagarjuna

-----------------
Dijstra challenge
-----------------

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

============================================================================

