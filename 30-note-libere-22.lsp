================

 NOTE LIBERE 22

================

"Un minuto o un bacio sono eterni"

----------------------------
Inverso di un numero binario
----------------------------

Dato un numero intero positivo è invertire le cifre binarie e restituire quel numero in base 10.
Ci sono due modi di 'invertire' un numero binario:
1) invertire la stringa di tutto il numero binario
2) invertire ogni singolo bit (1 in 0 e 0 in 1)

Primo caso: inversione dell'intero numero binario

(define (invert1 num) (int (reverse (bits num)) 0 2))

(map invert1 (sequence 0 50))
;-> (0 1 1 3 1 5 3 7 1 9 5 13 3 11 7 15 1 17 9 25 5 21 13 29 3 19 11 27
;->  7 23 15 31 1 33 17 49 9 41 25 57 5 37 21 53 13 45 29 61 3 35 19)

Sequenza OEIS A030101:
a(n) is the number produced when n is converted to binary digits, the binary digits are reversed and then converted back into a decimal number.
  0, 1, 1, 3, 1, 5, 3, 7, 1, 9, 5, 13, 3, 11, 7, 15, 1, 17, 9, 25, 5, 21, 
  13, 29, 3, 19, 11, 27, 7, 23, 15, 31, 1, 33, 17, 49, 9, 41, 25, 57, 5, 
  37, 21, 53, 13, 45, 29, 61, 3, 35, 19, 51, 11, 43, 27, 59, 7, 39, 23, 
  55, 15, 47, 31, 63, 1, 65, 33, 97, 17, 81, 49, 113, 9, 73, 41, 105, 
  25, 89, 57 , ...

La sequenza può essere generata anche dalla seguente funzione f:

  f(0) = 0
  f(1) = 1
  f(3) = 3
  f(2n) = f(n)
  f(4n+1) = 2f(2n+1) - f(n)
  f(4n+3) = 3f(2n+1) - 2f(n)

(define (f n)
  (local (t)
    (cond ((= n 0) 0)             ; caso 0
          ((= n 1) 1)             ; caso 1
          ((= n 3) 3)             ; caso 2
          ((even? n) (f (/ n 2))) ; caso 3
          ((zero? (% (- n 1) 4))  ; caso 4
            (setq t (/ (- n 1) 4))
            (- (* 2 (f (+ (* 2 t) 1))) (f t)))
          ((zero? (% (- n 3) 4))  ; caso 5
            (setq t (/ (- n 3) 4))
            (- (* 3 (f (+ (* 2 t) 1))) (* 2 (f t)))))))

(map f (sequence 0 50))
;-> (0 1 1 3 1 5 3 7 1 9 5 13 3 11 7 15 1 17 9 25 5 21 13 29 3 19 11 27
;->  7 23 15 31 1 33 17 49 9 41 25 57 5 37 21 53 13 45 29 61 3 35 19)

Secondo caso: inversione dei singoli bit del numero binario

(define (invert2 num) 
  (int (join (map (fn(x) (if (= x "0") "1" "0")) (explode (bits num)))) 0 2))

(map invert2 (sequence 0 50))
;-> (1 0 1 0 3 2 1 0 7 6 5 4 3 2 1 0 15 14 13 12 11 10 9 8 7 6 5 4 3 2
;->  1 0 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13)

Sequenza OEIS A035327:
Write n in binary, interchange 0's and 1's, convert back to decimal.
  1, 0, 1, 0, 3, 2, 1, 0, 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10,
  9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21,
  20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0,
  63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 51, 50, 49, 48, 47, 4, ...

La sequenza può essere generata anche dalla seguente funzione g:

  g(0)=1
  g(n) = 2^(1+floor(log2(n))) - n - 1, per n >= 1

(define (g n)
  (- (pow 2 (+ 1 (floor (log (max n 1) 2)))) n 1))

(map g (sequence 0 50))
;-> (1 0 1 0 3 2 1 0 7 6 5 4 3 2 1 0 15 14 13 12 11 10 9 8 7 6 5 4 3 2
;->  1 0 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13)


---------------------------------------------
Numero con i bit 1 spostati a sinistra/destra
---------------------------------------------

Dato un numero intero positivo, calcolare la sua rappresentazione binaria, spostare tutti i bit 1 a sinistra/destra e riconvertire il numero in decimale.

Spostamento dei bit 1 a sinistra (left)
---------------------------------------

Primo metodo:

Sequenza OEIS A073138:
Largest number having in its binary representation the same number of 0's and 1's as n.
  0, 1, 2, 3, 4, 6, 6, 7, 8, 12, 12, 14, 12, 14, 14, 15, 16, 24, 24, 28, 24,
  28, 28, 30, 24, 28, 28, 30, 28, 30, 30, 31, 32, 48, 48, 56, 48, 56, 56, 60,
  48, 56, 56, 60, 56, 60, 60, 62, 48, 56, 56, 60, 56, 60, 60, 62, 56, 60, 60,
  62, 60, 62, 62, 63, 64, 96, 96, 112, 96, 112, 112, ...

(define (left num)
  (int (join (sort (explode (bits num)) >)) 0 2))

(map left (sequence 0 50))
;-> (0 1 2 3 4 6 6 7 8 12 12 14 12 14 14 15 16 24 24 28 24 28 28 30 24
;->  28 28 30 28 30 30 31 32 48 48 56 48 56 56 60 48 56 56 60 56 60 60
;->  62 48 56 56)

Secondo metodo:

Il valore di un numero binario con N "1" all'inizio e M "0" alla fine è dato dalla somma delle potenze di 2 corrispondenti alle posizioni delle "1" all'inizio che viene poi raddoppiata per ogni "0".
Ad esempio,
  binario = 11100
  Con 3 "1" all'inizio la somma vale:
  1*2^0 + 1*2^1 + 1*2^2 = 1 + 2 + 4 = 7
  Adesso con 2 "0" alla fine raddoppiamo per 2 volte la somma:
  (7 * 2 * 2) = 28

Funzione che calcola il numero di bit a 1 di un numero decimale:

(define (pop-count num)
  (let (counter 0)
    (while (> num 0)
      ; In questo modo arriviamo al prossimo bit impostato (successivo '1')
      ; invece di eseguire il ciclo per ogni bit e controllare se vale '1'.
      ; Quindi il ciclo non verrà eseguito per tutti i bit,
      ; ma verrà eseguito solo tante volte quanti sono gli '1'.
      (setq num (& num (- num 1)))
      (++ counter)
    )
    counter))

Funzione che calcola il valore decimale di un numero binario con N '1' all'inizio e M '0' alla fine.

(define (binario n m)
  (let ((decimale 0))
    (dotimes (i n)
      (setq decimale (+ (* decimale 2) 1)))
    (dotimes (i m)
      (setq decimale (* decimale 2)))
    decimale))

(binario 3 2)
;-> 28

(define (left2 num)
  (let (p (pop-count num))
    (binario p (- (length (bits num)) p))))

(map left2 (sequence 0 50))
;-> (0 1 2 3 4 6 6 7 8 12 12 14 12 14 14 15 16 24 24 28 24 28 28 30 24
;->  28 28 30 28 30 30 31 32 48 48 56 48 56 56 60 48 56 56 60 56 60 60
;->  62 48 56 56)

Vediamo la velocità delle due funzioni:

(time (map left (sequence 0 1e5)))
;-> 991.605
(time (map left2 (sequence 0 1e5)))
;-> 237.256

Spostamento dei bit 1 a sinistra (left)
---------------------------------------

Sequenza OEIS A038573:
a(n) = 2^(bit=1 in n) - 1
  0, 1, 1, 3, 1, 3, 3, 7, 1, 3, 3, 7, 3, 7, 7, 15, 1, 3, 3, 7, 3, 7, 7, 15,
  3, 7, 7, 15, 7, 15, 15, 31, 1, 3, 3, 7, 3, 7, 7, 15, 3, 7, 7, 15, 7, 15,
  15, 31, 3, 7, 7, 15, 7, 15, 15, 31, 7, 15, 15, 31, 15, 31, 31, 63, 1, 3,
  3, 7, 3, 7, 7, 15, 3, 7, 7, 15, 7, 15, 15, 31, 3, 7, 7, 15, 7, ...

Primo metodo:

(define (right num)
  (int (join (sort (explode (bits num)) <)) 0 2))

(map right (sequence 0 50))
;-> (0 1 1 3 1 3 3 7 1 3 3 7 3 7 7 15 1 3 3 7 3 7 7 15 3 7 7 15 7 15 15
;->  31 1 3 3 7 3 7 7 15 3 7 7 15 7 15 15 31 3 7 7)

Secondo metodo:

(define (right2 num) (- (pow 2 (pop-count num)) 1))

(map right2 (sequence 0 50))
;-> (0 1 1 3 1 3 3 7 1 3 3 7 3 7 7 15 1 3 3 7 3 7 7 15 3 7 7 15 7 15 15
;->  31 1 3 3 7 3 7 7 15 3 7 7 15 7 15 15 31 3 7 7)

Vediamo la velocità delle ultime due funzioni:

(time (map right (sequence 0 1e5)))
;-> 962.845
(time (map right2 (sequence 0 1e5)))
;-> 125.354


-----------------------------
Conteggio popolazione (1 e 0)
-----------------------------

Funzione che calcola il numero di 1 nel valore binario di un numero decimale:

Versione 1:

(define (pop-1a num)
  (let (counter 0)
    (while (> num 0)
      ; In questo modo arriviamo al prossimo bit impostato (successivo '1')
      ; invece di eseguire il ciclo per ogni bit e controllare se vale '1'.
      ; Quindi il ciclo non verrà eseguito per tutti i bit,
      ; ma verrà eseguito solo tante volte quanti sono gli '1'.
      (setq num (& num (- num 1)))
      (++ counter)
    )
    counter))

Versione 2:

(define (pop-1b num)
  (first (count '("1") (explode (bits num)))))

Versione 3:

(define (pop-1c num)
  (- (length (bits num)) (pop-0c num)))

Funzione che calcola il numero di 0 nel valore binario di un numero decimale:

Versione 1:

(define (pop-0a num)
  (let (counter 0)
    (while (> num 0)
      ; Se l'ultimo bit è 0, incrementa il conteggio
      ;(if (zero? (% num 2)) (++ counter))
      (if (even? num) (++ counter))
      ; Sposta il numero a destra (right shift) di 1 posizione
      ; (equivalente a dividere per 2)
      (setq num (>> num))
    )
    counter))

Versione 2:

(define (pop-0b num)
  (first (count '("0") (explode (bits num)))))

Versione 3:

(define (pop-0c num)
  (- (length (bits num)) (pop-1a num)))

Vediamo se le funzioni restituiscono gli stessi risultati:

(= (map pop-0a (sequence 1 1000))
   (map pop-0b (sequence 1 1000))
   (map pop-0c (sequence 1 1000)))
;-> true

(= (map pop-1a (sequence 1 1000))
   (map pop-1b (sequence 1 1000))
   (map pop-1c (sequence 1 1000)))
;-> true

Vediamo la velocità delle funzioni:

(time (map pop-0a (sequence 1 1e5)))
;-> 179.583
(time (map pop-0b (sequence 1 1e5)))
;-> 537.472
(time (map pop-0c (sequence 1 1e5)))
;-> 131.555

(time (map pop-1a (sequence 1 1e5)))
;-> 115.868
(time (map pop-1b (sequence 1 1e5)))
;-> 542.82
(time (map pop-1c (sequence 1 1e5)))
;-> 131.562

Quindi le due versioni più veloci sono "pop-0c" e "pop-1a".

Versioni finali:

(define (pop-count1 num)
  (let (counter 0)
    (while (> num 0)
      (setq num (& num (- num 1)))
      (++ counter)
    )
    counter))

(define (pop-count0 num)
  (- (length (bits num)) (pop-count1 num)))


-----------------------------------
Numero minimo con divisori da 1 a N
-----------------------------------

Dato un intero positivo N restituire il più piccolo numero positivo che abbia tutti i numeri interi da 1 a N come divisori.

Si tratta semplicemente di calcolare il minimo comune multiplo (lcm - least common multiple) della sequenza 1..N.

(define (lcm_ a b) (/ (* a b) (gcd a b)))
(define-macro (lcm)
"Calculates the lcm of two or more number"
  (apply lcm_ (map eval (args)) 2))

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn ( (fattori (factor num))
            (unici (unique fattori)) )
      (transpose (list unici (count unici fattori))))))

(define (divisors num)
"Generate all the divisors of an integer number"
  (local (f out)
    (cond ((= num 1) '(1))
          (true
           (setq f (factor-group num))
           (setq out '())
           (divisors-aux 0 1)
           (sort out)))))
; auxiliary function
(define (divisors-aux cur-index cur-divisor)
  (cond ((= cur-index (length f))
         (push cur-divisor out -1)
        )
        (true
         (for (i 0 (f cur-index 1))
           (divisors-aux (+ cur-index 1) cur-divisor)
           (setq cur-divisor (* cur-divisor (f cur-index 0)))
         ))))

(define (smallest num) (apply lcm (sequence 1 num)))

Proviamo:

(smallest 12)
;-> 27720
(factor 27720)
;-> (2 2 2 3 3 5 7 11)
(divisors 27720)
;-> (1 2 3 4 5 6 7 8 9 10 11 12 14 15 18 20 21 22 24 28 30 33 35 36 40
;->  42 44 45 55 56 60 63 66 70 72 77 84 88 90 99 105 110 120 126 132
;->  140 154 165 168 180 198 210 220 231 252 264 280 308 315 330 360 385
;->  396 420 440 462 495 504 616 630 660 693 770 792 840 924 990 1155
;->  1260 1320 1386 1540 1848 1980 2310 2520 2772 3080 3465 3960 4620
;->  5544 6930 9240 13860 27720)

(smallest 21)
;-> 232792560
(factor 232792560)
;-> (2 2 2 2 3 3 5 7 11 13 17 19)
(divisors 232792560)
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 24 26 28
;->  30 33 34 35 36 38 39 40 42 44 45 48 51 52 55 56 57 60 63 65 66 68
;-> ...
;->  17907120 19399380 21162960 23279256 25865840 29099070 33256080 38798760
;->  46558512 58198140 77597520 116396280 232792560)


-------------------------------------
Moltiplicazione simbolica tra matrici
-------------------------------------

Date due matrici di simboli, calcolare la loro moltiplicazione simbolica.
Per esempio,

    |a11 a12|
A = |a21 a22|       B =|b11 b12 b13|
    |a31 a32|          |b21 b22 b23|

       |(a11*b11)+(a12*b21) (a11*b12)+(a12*b22) (a11*b13)+(a12*b23)|
AxB =  |(a21*b11)+(a22*b21) (a21*b12)+(a22*b22) (a21*b13)+(a22*b23)|
       |(a31*b11)+(a32*b21) (a31*b12)+(a32*b22) (a31*b13)+(a32*b23)|

BxA =  |(b11*a11)+(b12*a21)+(b13*a31) (b11*a12)+(b12*a22)+(b13*a32)|
       |(b21*a11)+(b22*a21)+(b23*a31) (b21*a12)+(b22*a22)+(b23*a32)|

(define (print-matrix lst)
"Print a matrix (list) m x n as a table"
  (local (tab plus minus ver rows cols col-len-max len-max
          line-len line ind)
    ; conversione di tutti i valori della lista in stringa
    ;(setq tab (map-all string lst))
    ; suppone che gli elementi siano tutte stringhe
    (setq tab lst)
    ; caratteri grafici
    (setq plus "+")
    (setq minus "-")
    (setq ver "|")
    ; calcolo righe e colonne della lista
    (setq rows (length tab))
    (setq cols (length (tab 0)))
    ; vettore per le lunghezze massime dei valori di ogni colonna
    (setq col-len-max (array cols '(0)))
    ; calcola la lunghezza massima dei valori di ogni colonna
    (for (c 0 (- cols 1))
      (setq len-max 0)
      (for (r 0 (- rows 1))
        (setf len-max (max len-max (length (tab r c))))
      )
      (setf (col-len-max c) len-max)
    )
    ;(println col-len-max)
    ; lunghezza della linea =
    ; (somma delle lunghezze massime) +
    ; (2 spazi x ogni colonna) +
    ; (colonne + 1 per "|")
    (setq line-len (+ (apply + col-len-max) (* cols 2) (+ cols 1)))
    (setq line (dup minus line-len))
    (setf (line 0) plus)
    (setf (line -1) plus)
    ; calcola i limiti di stampa dei valori
    ; (inserisce "+" nella linea "line")
    (setq ind 1)
    (dolist (c col-len-max)
      (setq ind (+ ind 2 c))
      (setf (line ind) plus)
      (++ ind)
    )
    ; stampa della lista come tabella
    (dolist (r tab)
      (println line)
      (dolist (c r)
        (print ver { } c (dup " " (- (col-len-max $idx) (length c))) { })
      )
      (println ver)
    )
    (println line)
  'end))

Funzione che unisce due stringhe/simboli con "+":

(define (adds a b) (string a "+" b))
;(define (adds a b) (string "(" a "+" b ")"))

Proviamo:

(adds 2 3)
;-> "2+3"
(adds "a" "b")
;-> "a+b"

Funzione che unisce due stringhe/simboli con "(", "*" e ")":

(define (muls a b) (string "(" a "*" b ")"))

Proviamo:

(muls "a" "b")
;-> (a*b)
(muls (adds "abc" "def") (adds 3 4))
;-> "(abc+def*3+4)"
(adds (muls "abc" "def") (muls 3 4))
;-> "(abc*def)+(3*4)"
(muls "abc+def" "3+4")
;-> "(abc+def*3+4)"
(muls "(abc+def)" "(3+4)")
;-> "((abc+def)*(3+4))"

Funzione che moltiplica due matrici in forma simbolica:

(define (mul-mat m1 m2)
  (local (r1 c1 r2 c2 out)
    (setq r1 (length m1))
    (setq c1 (length (m1 0)))
    (setq r2 (length m2))
    (setq c2 (length (m2 0)))
    (setq out (array r1 c2 '("")))
    (for (i 0 (- r1 1))
      (for (j 0 (- c2 1))
        (setq (out i j) "")
        (for (k 0 (- r2 1))
          ;(setq (res i j) (+ (res i j) (* (m1 i k) (m2 k j))));
          (setq (out i j) (adds (out i j) (muls (m1 i k) (m2 k j))))
        )
      )
    )
    out))

Moltiplichiamo alcune matrici:

(setq m1 '(("a11" "a12") ("a21" "a22") ("a31" "a32")))
(setq m2 '(("b11" "b12" "b13") ("b21" "b22" "b23")))
(print-matrix (mul-mat m1 m2))
;-> +----------------------+----------------------+----------------------+
;-> | +(a11*b11)+(a12*b21) | +(a11*b12)+(a12*b22) | +(a11*b13)+(a12*b23) |
;-> +----------------------+----------------------+----------------------+
;-> | +(a21*b11)+(a22*b21) | +(a21*b12)+(a22*b22) | +(a21*b13)+(a22*b23) |
;-> +----------------------+----------------------+----------------------+
;-> | +(a31*b11)+(a32*b21) | +(a31*b12)+(a32*b22) | +(a31*b13)+(a32*b23) |
;-> +----------------------+----------------------+----------------------+
(print-matrix (mul-mat m2 m1))
;-> +--------------------------------+--------------------------------+
;-> | +(b11*a11)+(b12*a21)+(b13*a31) | +(b11*a12)+(b12*a22)+(b13*a32) |
;-> +--------------------------------+--------------------------------+
;-> | +(b21*a11)+(b22*a21)+(b23*a31) | +(b21*a12)+(b22*a22)+(b23*a32) |
;-> +--------------------------------+--------------------------------+

(setq m1 '((a11 a12) (a21 a22) (a31 a32)))
(setq m2 '((b11 b12 b13) (b21 b22 b23)))
(print-matrix (mul-mat m2 m1))
;-> +--------------------------------+--------------------------------+
;-> | +(b11*a11)+(b12*a21)+(b13*a31) | +(b11*a12)+(b12*a22)+(b13*a32) |
;-> +--------------------------------+--------------------------------+
;-> | +(b21*a11)+(b22*a21)+(b23*a31) | +(b21*a12)+(b22*a22)+(b23*a32) |
;-> +--------------------------------+--------------------------------+

(setq m1 '((1 2 3) (4 5 6) (7 8 9)))
(setq m2 '((11 22 33) (44 55 66) (77 88 99)))
(print-matrix (mul-mat m2 m1))
;-> +-----------------------+-----------------------+-----------------------+
;-> | +(11*1)+(22*4)+(33*7) | +(11*2)+(22*5)+(33*8) | +(11*3)+(22*6)+(33*9) |
;-> +-----------------------+-----------------------+-----------------------+
;-> | +(44*1)+(55*4)+(66*7) | +(44*2)+(55*5)+(66*8) | +(44*3)+(55*6)+(66*9) |
;-> +-----------------------+-----------------------+-----------------------+
;-> | +(77*1)+(88*4)+(99*7) | +(77*2)+(88*5)+(99*8) | +(77*3)+(88*6)+(99*9) |
;-> +-----------------------+-----------------------+-----------------------+


-----------------------------------
Numero più piccolo che non divide N
-----------------------------------

Dato un intero positivo N restituire il più piccolo intero positivo che non sia un divisore di N.
Per esempio,
  N = 10
  Divisori di 10 = 1 2 5 10
  Numero minimo non divisore = 3

  N = 24
  Divisori di 10 = 1 2 5 10
  Numero minimo non divisore = 3

Sequenza OEIS A007978:
Least non-divisor of n
  2, 3, 2, 3, 2, 4, 2, 3, 2, 3, 2, 5, 2, 3, 2, 3, 2, 4, 2, 3, 2, 3, 2, 5,
  2, 3, 2, 3, 2, 4, 2, 3, 2, 3, 2, 5, 2, 3, 2, 3, 2, 4, 2, 3, 2, 3, 2, 5,
  2, 3, 2, 3, 2, 4, 2, 3, 2, 3, 2, 7, 2, 3, 2, 3, 2, 4, 2, 3, 2, 3, 2, 5,
  2, 3, 2, 3, 2, 4, 2, 3, 2, 3, 2, 5, 2, 3, 2, 3, 2, 4, 2, 3, 2, 3, 2, 5,
  2, 3, 2, 3, ...

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn ( (fattori (factor num))
            (unici (unique fattori)) )
      (transpose (list unici (count unici fattori))))))

(define (divisors num)
"Generate all the divisors of an integer number"
  (local (f out)
    (cond ((= num 1) '(1))
          (true
           (setq f (factor-group num))
           (setq out '())
           (divisors-aux 0 1)
           (sort out)))))
; auxiliary function
(define (divisors-aux cur-index cur-divisor)
  (cond ((= cur-index (length f))
         (push cur-divisor out -1)
        )
        (true
         (for (i 0 (f cur-index 1))
           (divisors-aux (+ cur-index 1) cur-divisor)
           (setq cur-divisor (* cur-divisor (f cur-index 0)))
         ))))

(define (minore1 num)
  (let (diff (difference (sequence 1 num) (divisors num)))
    (if (= diff '())
        (+ num 1)
        (first diff))))

Proviamo:

(minore1 10)
;-> 3

(map minore1 (sequence 1 100))
;-> (2 3 2 3 2 4 2 3 2 3 2 5 2 3 2 3 2 4 2 3 2 3 2 5 2 3 2 3 2 4 2 3 2
;->  3 2 5 2 3 2 3 2 4 2 3 2 3 2 5 2 3 2 3 2 4 2 3 2 3 2 7 2 3 2 3 2 4
;->  2 3 2 3 2 5 2 3 2 3 2 4 2 3 2 3 2 5 2 3 2 3 2 4 2 3 2 3 2 5 2 3 2
;->  3)

La funzione è lenta perchè il calcolo dei divisori è oneroso.
Inoltre i valori di output sono piccoli.

(time (println (apply max (map minore1 (sequence 1 10000)))))
;-> 11
;-> 10310.828

Usiamo un altro metodo, dividiamo il numero N per k = 1,2,3,4,... fino a che non troviamo il primo numero non divisore di N.
Se raggiungiamo N, allora il numero minimo non divisore vale (N + 1).

(define (minore2 num)
  (let (k 1)
    (while (and (zero? (% num k)) (< k num)) (++ k))
    (if (= k num) (+ num 1) k)))

Proviamo:

(minore2 10)
;-> 3

(map minore2 (sequence 1 100))
;-> (2 3 2 3 2 4 2 3 2 3 2 5 2 3 2 3 2 4 2 3 2 3 2 5 2 3 2 3 2 4 2 3 2
;->  3 2 5 2 3 2 3 2 4 2 3 2 3 2 5 2 3 2 3 2 4 2 3 2 3 2 7 2 3 2 3 2 4
;->  2 3 2 3 2 5 2 3 2 3 2 4 2 3 2 3 2 5 2 3 2 3 2 4 2 3 2 3 2 5 2 3 2
;->  3)

(time (println (apply max (map minore2 (sequence 1 10000)))))
;-> 11
;-> 5.546

(time (println (apply max (map minore2 (sequence 1 1e7)))))
;-> 17
;-> 4075.675


---------------------------
Somma degli orari in 24 ore
---------------------------

Dato un numero intero compreso tra 0 e 141 (incluso), elencare tutti gli orari di 24 ore in cui la somma delle ore, dei minuti e dei secondi è uguale al numero dato.

Formato 24-ore (input e output):
  (H)H-MM-SS, con (H)H=(0..23), MM=(0..59), SS=(0..59)

Esempi:

  00:00:00 --> 0 + 0 + 0 = 0
  23:59:59 --> 23 + 59 + 59 = 141
  21:08:42 --> 21 + 8 + 42 = 71 
  09:08:01 --> 9 + 8 + 1 = 18 
   9:08:01 --> 9 + 8 + 1 = 18 

(define (ore num)
  (let (out '())
    (for (h 0 23)
      (for (m 0 59)
        (for (s 0 59)
          (if (= num (+ h m s)) (push (format "%02d:%02d:%02d" h m s) out -1))
        )
      )
    )
    out))

Proviamo:

(ore 0)
;-> ("0:00:00")
(ore 141)
;-> ("23:59:59")
(ore 4)
;-> ("00:00:04" "00:01:03" "00:02:02" "00:03:01" "00:04:00" "01:00:03"
;->  "01:01:02" "01:02:01" "01:03:00" "02:00:02" "02:01:01" "02:02:00"
;->  "03:00:01" "03:01:00" "04:00:00")

Calcoliamo una lista i cui elementi hanno la seguente struttura:
  (numero, numero degli orari con somma uguale al numero)

(define (all)
  (let (out '())
    (for (i 1 141) (push (list i (length (ore i))) out -1))))

(all)
;-> ((1 3) (2 6) (3 10) (4 15) (5 21) (6 28) (7 36) (8 45) (9 55) (10 66)
;->  (11 78) (12 91) (13 105) (14 120) (15 136) (16 153) (17 171) (18 190)
;->  (19 210) (20 231) (21 253) (22 276) (23 300) (24 324) (25 348) (26 372)
;->  (27 396) (28 420) (29 444) (30 468) (31 492) (32 516) (33 540) (34 564)
;->  (35 588) (36 612) (37 636) (38 660) (39 684) (40 708) (41 732) (42 756)
;->  (43 780) (44 804) (45 828) (46 852) (47 876) (48 900) (49 924) (50 948)
;->  (51 972) (52 996) (53 1020) (54 1044) (55 1068) (56 1092) (57 1116)
;->  (58 1140) (59 1164) (60 1186) (61 1206) (62 1224) (63 1240) (64 1254)
;->  (65 1266) (66 1276) (67 1284) (68 1290) (69 1294) (70 1296) (71 1296)
;->  (72 1294) (73 1290) (74 1284) (75 1276) (76 1266) (77 1254) (78 1240)
;->  (79 1224) (80 1206) (81 1186) (82 1164) (83 1140) (84 1116) (85 1092)
;->  (86 1068) (87 1044) (88 1020) (89 996) (90 972) (91 948) (92 924)
;->  (93 900) (94 876) (95 852) (96 828) (97 804) (98 780) (99 756)
;->  (100 732) (101 708) (102 684) (103 660) (104 636) (105 612) (106 588)
;->  (107 564) (108 540) (109 516) (110 492) (111 468) (112 444) (113 420)
;->  (114 396) (115 372) (116 348) (117 324) (118 300) (119 276) (120 253)
;->  (121 231) (122 210) (123 190) (124 171) (125 153) (126 136) (127 120)
;->  (128 105) (129 91) (130 78) (131 66) (132 55) (133 45) (134 36)
;->  (135 28) (136 21) (137 15) (138 10) (139 6) (140 3) (141 1))

Tracciamo un istogramma di questi valori.

(define (histogram lst hmax calc)
"Print the histogram of a list of integer numbers"
  (local (unici linee hm scala f-lst)
    (if calc
      ; calcolo la lista delle frequenze partendo da lst
      (begin
        ; trovo quanti numeri diversi ci sono nella lista
        (setq unici (length (unique lst)))
        ; creo la lista delle frequenze
        (setq f-lst (array unici '(0)))
        ; calcolo dei valori delle frequenze
        (dolist (el lst)
          (++ (f-lst (- el 1)))
        )
      )
      ; else
      ; lst è la lista delle frequenze
      (begin (setq f-lst lst))
    )
    (setq hm (apply max f-lst))
    (setq scala (div hm hmax))
    (setq linee (map (fn (x) (round (div x scala))) f-lst))
    (dolist (el linee)
      ; (println (format "%3d %s %0.2f" (add $idx 1) (dup "*" el) (f-lst $idx)))
      (println (format "%3d %s %4d" $idx (dup "*" el) (f-lst $idx)))
    )))

La funzione "histogram" prende una lista di valori e li indicizza da 0, quindi inseriamo uno 0 all'inizio della lista di valori:

(histogram (push 0 (map last (all))) 70)
  0     0
  1     3
  2     6
  3 *   10
  4 *   15
  5 *   21
  6 **   28
  7 **   36
  8 **   45
  9 ***   55
 10 ****   66
 11 ****   78
 12 *****   91
 13 ******  105
 14 ******  120
 15 *******  136
 16 ********  153
 17 *********  171
 18 **********  190
 19 ***********  210
 20 ************  231
 21 **************  253
 22 ***************  276
 23 ****************  300
 24 ******************  324
 25 *******************  348
 26 ********************  372
 27 *********************  396
 28 ***********************  420
 29 ************************  444
 30 *************************  468
 31 ***************************  492
 32 ****************************  516
 33 *****************************  540
 34 ******************************  564
 35 ********************************  588
 36 *********************************  612
 37 **********************************  636
 38 ************************************  660
 39 *************************************  684
 40 **************************************  708
 41 ****************************************  732
 42 *****************************************  756
 43 ******************************************  780
 44 *******************************************  804
 45 *********************************************  828
 46 **********************************************  852
 47 ***********************************************  876
 48 *************************************************  900
 49 **************************************************  924
 50 ***************************************************  948
 51 ****************************************************  972
 52 ******************************************************  996
 53 ******************************************************* 1020
 54 ******************************************************** 1044
 55 ********************************************************** 1068
 56 *********************************************************** 1092
 57 ************************************************************ 1116
 58 ************************************************************** 1140
 59 *************************************************************** 1164
 60 **************************************************************** 1186
 61 ***************************************************************** 1206
 62 ****************************************************************** 1224
 63 ******************************************************************* 1240
 64 ******************************************************************** 1254
 65 ******************************************************************** 1266
 66 ********************************************************************* 1276
 67 ********************************************************************* 1284
 68 ********************************************************************** 1290
 69 ********************************************************************** 1294
 70 ********************************************************************** 1296
 71 ********************************************************************** 1296
 72 ********************************************************************** 1294
 73 ********************************************************************** 1290
 74 ********************************************************************* 1284
 75 ********************************************************************* 1276
 76 ******************************************************************** 1266
 77 ******************************************************************** 1254
 78 ******************************************************************* 1240
 79 ****************************************************************** 1224
 80 ***************************************************************** 1206
 81 **************************************************************** 1186
 82 *************************************************************** 1164
 83 ************************************************************** 1140
 84 ************************************************************ 1116
 85 *********************************************************** 1092
 86 ********************************************************** 1068
 87 ******************************************************** 1044
 88 ******************************************************* 1020
 89 ******************************************************  996
 90 ****************************************************  972
 91 ***************************************************  948
 92 **************************************************  924
 93 *************************************************  900
 94 ***********************************************  876
 95 **********************************************  852
 96 *********************************************  828
 97 *******************************************  804
 98 ******************************************  780
 99 *****************************************  756
100 ****************************************  732
101 **************************************  708
102 *************************************  684
103 ************************************  660
104 **********************************  636
105 *********************************  612
106 ********************************  588
107 ******************************  564
108 *****************************  540
109 ****************************  516
110 ***************************  492
111 *************************  468
112 ************************  444
113 ***********************  420
114 *********************  396
115 ********************  372
116 *******************  348
117 ******************  324
118 ****************  300
119 ***************  276
120 **************  253
121 ************  231
122 ***********  210
123 **********  190
124 *********  171
125 ********  153
126 *******  136
127 ******  120
128 ******  105
129 *****   91
130 ****   78
131 ****   66
132 ***   55
133 **   45
134 **   36
135 **   28
136 *   21
137 *   15
138 *   10
139     6
140     3
141     1

Sembra una distribuzione gaussiana.


-----------------------
Funzioni autoreplicanti
-----------------------

Scrivere una funzione che si autoreplica.
La funzione prende come parametro il nome della nuova funzione replicata.

(define (replica name)
  (let (s (source 'replica)) ; stringa che contiene il codice della funzione
    ; sostituisce "replica" con il nome della nuova funzione
    (replace "replica" s name)
    ; crea la nuova funzione valutando la stringa s
    (setq name (eval-string s))))

Proviamo:

(replica "go")
;-> (lambda (name)
;->  (let (s (source 'go))
;->   (replace "go" s name)
;->   (setq name (eval-string s))))

Vediamo come è fatta la funzione "go":

(source 'go)
;-> "(define (go name)\r\n
;->   (let (s (source 'go)) \r\n
;->   (replace \"go\" s name) \r\n
;->   (setq name (eval-string s))))\r\n\r\n"

Usiamo "go" per creare un'altra funzione:

(go "altra")
;-> (lambda (name)
;->  (let (s (source 'altra))
;->   (replace "altra" s name)
;->   (setq name (eval-string s))))

Vediamo come è fatta la funzione "altra":

(source 'altra))
;-> "(define (altra name)\r\n
;->   (let (s (source 'altra)) \r\n
;->   (replace \"altra\" s name) \r\n
;->   (setq name (eval-string s))))\r\n\r\n"


-----------------
Sequenza 1, 81, ?
-----------------

Dato un numero intero positivo N calcolare la seguente potenza:

  pot = (numero di 1 in binario di N)^(numero di 0 in binario di N)

Per esempio:

  N = 124
  binario = 1111100 (5 '1' e 2 '0')
  pot = 5^2 = 25

  N = 81
  binario = 1010001 (3 '1' e 4 '0')
  pot = 3^4 = 81

Qual'è la sequenza dei numeri interi che hanno lo stesso valore della potenza?

(define (pop-count1 num)
"Calculate the number of 1 in binary value of an integer number"
  (let (counter 0)
    (while (> num 0)
      (setq num (& num (- num 1)))
      (++ counter)
    )
    counter))

(define (pop-count0 num)
"Calculate the number of 0 in binary value of an integer number"
  (- (length (bits num)) (pop-count1 num)))

(define (seq limit)
  (let (out '())
    (for (num 1 limit)
      (setq p (pop-count1 num))
      ;(print (bits num) { } p { } (- (length (bits num)) p))
      ;(read-line)
      (if (= num (pow p (- (length (bits num)) p)))
          (push num out -1)
      )
    )
    out))

Proviamo:

(seq 10000)
;-> (1 81)

(seq 1e6)
;-> (1 81)

Fino a 1e8 (100 milioni) esistono solo i numeri 1 e 81.

(time (println (seq 1e8)))
;-> (1 81)
;-> 182244.822

(time (println (seq 1e9)))
(1 81)
;-> 2040003.693

Credo che non esistano altri numeri oltre a 1 e 81, ma bisognerebbe dimostrarlo matematicamente.


----------------------------------
Primi di Mills e costante di Mills
----------------------------------

La costante di Mills è il numero reale positivo A tale che la funzione:

  f(n) = floor(A^(3^n))

generi numeri primi per ogni n intero positivo,

Assumendo come vera l'ipotesi di Riemann la costante vale:

  A = 1.30637788386308069046861449260260571291678458515671364436805375996643...

I numeri primi generati da A vengono chiamati primi di Mills.

Sequenza OEIS A051254: Mills primes
  2, 11, 1361, 2521008887, 16022236204009818131831320183,
  4113101149215104800030529537915953170486139
  623539759933135949994882770404074832568499, ...

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (genera n)
  ; 1.306377883863081
  (setq A 1.306377883863080690468)
  (floor (add .5 (pow A (** 3 n)))))

Proviamo:

(genera 1)
;-> 2
(genera 2)
;-> 11
(genera 3)
;-> 1361
(genera 4)
;-> 2521008887

Il quinto primo è errato perchè A^(3^5) è maggiore del massimo intero Int64.
(genera 5)
;-> 1.602223620400958e+028

Non si conosce una formula chiusa per la costante di Mills, quindi è impossibile fare un'approssimazione a priori. 
Comunque è possibile determinare la successione dei primi di Mills tramite una stima del valore della costante, e da questi ricavarne un valore più preciso (ricorsione).


----------------------
Sequenza di Baum-Sweet
----------------------

Un numero intero positivo appartiene alla sequenza di Baum-Sweet se la sua rappresentazione binaria non contiene un numero dispari di zeri consecutivi in qualsiasi punto del numero.
Per esempio,
  N = 252
  binario = 11111100
  Baum-Sweet = true (nessuna sequenza di zeri dispari)

  N = 37
  binario = 100101
  Baum-Sweet = nil (contiene una sequenza dispari: 0)

  N = 69
  binario = 1000101
  Baum-Sweet = nil (contiene due sequenze dispari: 000 e 0)

Sequenza OEIS A086747:
Baum-Sweet sequence: a(n) = 1 if binary representation of n contains no block of consecutive zeros of odd length, otherwise a(n) = 0.
  0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0,
  0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
  1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0,
  0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 1, 0, 0, 1, 0, 0, 1, 0, ...

(define (baum? num)
  (setq binary (explode (bits num)))
  (setq dispari nil)
  (setq zeri 0)
  ;(print binary { })
  (dolist (b binary dispari)
    (cond ((= b "0") (++ zeri))
          ((= b "1")
            (if (odd? zeri) (setq dispari true))
            (setq zeri 0))
    )
  )
  (if (or (odd? zeri) (= dispari true)) 0 1))

Proviamo:

(baum? 252)
;-> 1
(baum? 37)
;-> 0
(baum? 69)
;-> 0

(map baum? (sequence 0 95))
;-> (0 1 0 1 1 0 0 1 0 1 0 0 1 0 0 1 1 0 0 1 0 0 0 0
;->  0 1 0 0 1 0 0 1 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0
;->  1 0 0 1 0 0 0 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 0 0
;->  0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)


--------------------------
Siamo connessi a Internet?
--------------------------

Per vedere se siamo connessi a Internet possiamo usare la primitiva "net-connect".

************************
>>>funzione NET-CONNECT
************************
sintassi: (net-connect str-remote-host int-port [int-timeout-ms])
sintassi: (net-connect str-remote-host int-port [str-mode [int-ttl]])
sintassi: (net-connect str-file-path)

Nella prima sintassi, si connette a un computer host remoto specificato in str-remote-host e a una porta specificata in int-port.
Restituisce un handle di socket dopo essersi connesso con successo, in caso contrario, restituisce nil.

(set 'socket (net-connect "example.com" 80))
(net-send socket "GET /\r\n\r\n")
(net-receive socket buffer 10000)
(println buffer)
(exit)

In caso di successo, la funzione net-connect restituisce un numero di socket che può essere utilizzato per inviare e ricevere informazioni dall'host.
Nell'esempio viene inviata una richiesta HTTP GET e successivamente viene ricevuta una pagina web.
Si noti che newLISP ha già una funzione incorporata get-url che offre la stessa funzionalità.

Facoltativamente è possibile specificare un valore di timeout int-timeout in millisecondi.
Senza un valore di timeout la funzione attenderà fino a 10 secondi per una porta aperta.
Con un valore di timeout è possibile far sì che la funzione ritorni su una porta non disponibile molto prima o dopo.
L'esempio seguente mostra uno scanner di porte che cerca porte aperte:

(set 'host (main-args 2))
(println "Scanning: " host)
(for (port 1 1024)
    (if (set 'socket (net-connect host port 500))
        (println "open port: " port " " (or (net-service port "tcp") ""))
        (print port "\r"))
)

Il programma prende la stringa host dalla riga di comando della shell come nome di dominio o numero IP in notazione punto, quindi tenta di aprire ciascuna porta da 1 a 1024.
Per ogni porta aperta viene stampato il numero della porta e la stringa di descrizione del servizio.
Se non è disponibile alcuna descrizione, viene emessa una stringa vuota "".
Per le porte chiuse la funzione restituisce i numeri nella finestra della shell rimanendo sulla stessa riga.

Su Unix net-connect può restituire un valore pari a nil prima della scadenza del timeout, quando la porta non è disponibile.
Su MS Windows la connessione di rete attenderà sempre la scadenza del timeout prima di fallire con nil.
------------

Per vedere se siamo connessi possiamo provare a raggiungere alcuni siti (Google, Amazon, Youtube, ecc.).

(define (web? time-out)
  (setq time-out (or time-out 5000)) ;5000 msec
  (if (net-connect "www.google.com" 80 time-out)
      (println "Google: ON")
      (println "Google: OFF")
  )
  (if (net-connect "www.amazon.com" 80 time-out)
      (println "Amazon: ON")
      (println "Amazon: OFF")
  )
  '-----------)

(web?)
;-> Google: ON
;-> Amazon: ON
;-> -----------

Stacchiamo la wi-fi...

(web?)
;-> Google: OFF
;-> Amazon: OFF
;-> -----------


--------------------
Coprimi di una lista
--------------------

Data una lista di numeri interi, estrarre la lista dei numeri coprimi più piccoli.

Per esempio,
  lista = (3 5 4 8 11)
  coprimi = (3 4 5 11)

Algoritmo
1) Ordinare la lista
2) Inserire il primo elemento della lista nella lista dei coprimi
3) ciclo sulla lista data
   se elemento corrente coprimi con tutti gli elementi della lista coprimi,
   allora inserire l'elemento corrente nella lista dei coprimi
   altrimenti inserire l'elemento corrente nella lista dei non-coprimi

Due numeri interi a e b sono coprimi se e solo se gcd(a,b) = 1.

(define (filter-coprimi lst)
  (local (coprimi non-coprimi)
    (sort lst)
    (setq coprimi (list (pop lst)))
    (setq non-coprimi '())
    (dolist (el lst)
      (if (for-all (fn(x) (= (gcd x el) 1)) coprimi)
          (push el coprimi -1)
          (push el non-coprimi -1)
      )
    )
    (list coprimi non-coprimi)))

Proviamo:

(filter-coprimi '(3 5 4 8 11))
;-> ((3 4 5 11) (8))

(filter-coprimi '(-3 -7 3 -5 5 4 8 11 22 21))
;-> ((-7 -5 -3 4 11) (3 5 8 21 22))

Nota: in una lista (a1..an) di numeri coprimi risulta lcm(a1..an)=Prod(a1..an).

Vedi "Lista di numeri coprimi" su "Note libere 17".


--------------------------
Lista di numeri divisibili
--------------------------

Data una sequenza di numeri interi positivi da 1 a N e una lista di numeri interi positivi (divisori), trovare tutti i numeri della sequenza che:
1) sono divisibili almeno per un elemento della lista divisori
2) sono divisibili per tutti gli elementi della lista divisori
3) sono divisibili soltanto per un elemento della lista divisori
4) non sono divisibili per alcun elemento della lista divisori

La lista dei divisori contiene numeri tutti diversi.

(define (lcm_ a b) (/ (* a b) (gcd a b)))
(define-macro (lcm)
"Calculates the lcm of two or more number"
  (apply lcm_ (map eval (args)) 2))

1) Numeri divisibili almeno per un divisore
-------------------------------------------

Per ogni divisore 'd' creiamo la sequenza da d fino a N con passo d.
Uniamo tutte le sequenze in una lista, eliminiamo tutti gli elementi multipli e ordiniamo la lista.

(define (at-least-one-divisor N lst)
  (let (out '())
    (dolist (d lst)
      (extend out (sequence d N d))
    )
    (unique (sort out))))

Proviamo:

(at-least-one-divisor 10 '(2 3))
;-> (2 3 4 6 8 9 10)

(at-least-one-divisor 20 '(2 3 4))
;-> (2 3 4 6 8 9 10 12 14 15 16 18 20)

2) Numeri divisibili per tutti i divisori
-----------------------------------------
Per ogni elemento della sequenza verifichiamo se è divisibile per tutti i divisori.

(define (all-divisors N lst)
  (let (out '())
    (dolist (el (sequence 1 N))
      (if (for-all (fn(d) (zero? (% el d))) lst) (push el out -1))
    )
    out))

Proviamo:

(all-divisors 10 '(2 3))
;-> (6)

(all-divisors 20 '(2 3))
;-> (6 12 18)

(all-divisors 20 '(2 3 4))
;-> (12)

(all-divisors 50 '(2 3 4))
;-> (12 24 36 48)

Possiamo notare che un numero è divisibile per tutti i numeri divisori della lista (d1..dn) se e solo se il numero è divisibile per lcm(d1..dn).

(define (all-divisors N lst)
  (let (val (apply lcm lst))
    (sequence val N val)))

Proviamo:

(all-divisors 10 '(2 3))
;-> (6)

(all-divisors 20 '(2 3))
;-> (6 12 18)

(all-divisors 20 '(2 3 4))
;-> (12)

(all-divisors 50 '(2 3 4))
;-> (12 24 36 48)

3) numeri divisibili soltanto per un divisore
---------------------------------------------
Per ogni elemento della sequenza verifichiamo se è divisibile solo per un divisore.

(define (only-one-divisor N lst)
  (let ( (out '()) (divide 0) )
    (dolist (el (sequence 1 N))
      (setq divide 0)
      (dolist (d lst)
        (if (zero? (% el d)) (++ divide))
      )
      (if (= divide 1) (push el out))
    )
    (sort out)))

Proviamo:

(only-one-divisor 20 '(2 3 4))
;-> (2 3 9 10 14 15)

(only-one-divisor 20 '(2 3 4 5))
;-> (2 3 5 9 14)

(only-one-divisor 50 '(2 3 4))
;-> (2 3 9 10 14 15 21 22 26 27 33 34 38 39 45 46 50)

(only-one-divisor 20 '(2 6))
;-> (2 4 8 10 14 16 20)

3) Numeri con nessun divisore
-----------------------------
Per ogni elemento della sequenza verifichiamo se non è divisibile da alcun divisore.

(define (no-divisors N lst)
  (let ( (out '()) (divide 0) )
    (dolist (el (sequence 1 N))
      (setq divide 0)
      (dolist (d lst)
        (if (zero? (% el d)) (++ divide))
      )
      (if (zero? divide) (push el out))
    )
    (sort out)))

Proviamo:

(no-divisors 20 '(2 3 4))
;-> (1 5 7 11 13 17 19)

(no-divisors 20 '(2 3 4 5))
;-> (1 7 11 13 17 19)

(no-divisors 50 '(2 3 4))
;-> (1 5 7 11 13 17 19 23 25 29 31 35 37 41 43 47 49)

(no-divisors 50 '(2 3 4 6))
;-> (1 5 7 11 13 17 19 23 25 29 31 35 37 41 43 47 49)

Nota:
(setq lst '(2 3 4))
(sort (union (no-divisors 20 lst) (at-least-one-divisor 20 lst)))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)

(setq lst '(4 6))
(sort (union (no-divisors 20 lst) (at-least-one-divisor 20 lst)))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)


----------
Sever sort
----------

Data una lista di interi:

(2 4 3 8 4 3 2 9))

1) Dividerla in sotto-liste in cui nessun elemento è più grande del precedente:

((2) (4 3) (8 4 3 2) (9))

2) Invertire ogni sotto-lista:

((2) (3 4) (2 3 4 8) (9))

3) Infine, concatenare tutte le sotto-liste:

(2 3 4 2 3 4 8 9)

Ripetendo questa procedura abbastanza volte la lista sarà completamente ordinata (crescente):

1) ((2) (3) (4 2) (3) (4) (8) (9))
2) ((2) (3) (2 4) (3) (4) (8) (9))
3) (2 3 2 4 3 4 8 9)

1) ((2) (3 2) (4 3) (4) (8) (9))
2) ((2) (2 3) (3 4) (4) (8) (9))
3) (2 2 3 3 4 4 8 9)

(define (sever-aux lst)
  (local (out len tmp)
    (setq out '())
    (setq len (length lst))
    (setq tmp (list (lst 0)))
    (for (i 1 (- len 1))
      (cond ((<= (lst i) (tmp -1))
              (extend tmp (list (lst i))))
            ((> (lst i) (tmp -1))
              (push tmp out -1)
              (setq tmp (list (lst i))))
      )
    )
    (push tmp out -1)
    (flat (map reverse out))))

(define (sever lst)
  (local (cur tmp)
    (setq cur (sever-aux lst))
    (until (= cur (setq tmp (sever-aux cur)))
      (setq cur tmp))))

Proviamo:

(setq a '(2 4 3 8 4 3 2 9))
(sever a)
;-> (2 2 3 3 4 4 8 9)

(setq a '(14 94 14 90 69 30 42 7 96 68 15 87 82 58 19 17 81 47 15 
           50 73 40 27 56 68 75 72 47 12 36 83 3 51 66 42 10 94 92 
           54 34 47 37 84 31 45 27 98 29 73 56))

(sever a)
;-> (3 7 10 12 14 14 15 15 17 19 27 27 29 30 31 34 36 37 40 
;->  42 42 45 47 47 47 50 51 54 56 56 58 66 68 68 69 72 73 
;->  73 75 81 82 83 84 87 90 92 94 94 96 98)

Nota: è un miglioramento dell'algoritmo bubble-sort, perchè scambia due o più numeri ad ogni passaggio (comunque dobbiamo implementare il 'reverse' durante il ciclo di attraversamento della lista).


------------------------------------
Sequenza di numeri con cifre diverse
------------------------------------

Scrivere una funzione che restituisce tutti i numeri interi positivi con cifre decimali distinte nell'intervallo [a..b].

Sequenza OEIS A010784: Numbers with distinct decimal digits.
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
  23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 34, 35, 36, 37, 38, 39, 40, 41,
  42, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 56, 57, 58, 59, 60, 61,
  62, 63, 64, 65, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81,
  82, 83, 84, 85, 86, 87, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 102, 103,
  104, 105, 106, 107, 108, 109, 120, 000

(define (genera from to)
  (let (out'())
    (for (i from to)
      (setq digits (explode (string i)))
      (if (= digits (unique digits)) (push i out -1))
    )
    out))

Proviamo:

(genera 0 50)
;-> (0 1 2 3 4 5 6 7 8 9 10 12 13 14 15 16 17 18 19 20 21 23 24 25 26
;->  27 28 29 30 31 32 34 35 36 37 38 39 40 41 42 43 45 46 47 48 49 50)

(genera 123456 123500)
;-> (123456 123457 123458 123459 123460 123465 123467 123468 123469 123470
;->  123475 123476 123478 123479 123480 123485 123486 123487 123489 123490
;->  123495 123496 123497 123498)

Nota: la sequenza dei numeri con cifre decimali distinte è una sequenza finita.


--------------------------
Decimalizzare una frazione
--------------------------

Data una frazione, numeratore e denominatore, restituire il relativo numero decimale esatto (se possibile). Altrimenti restituire la frazione semplificata (ridotta ai minimi termini).

Data una qualunque frazione a/b, possiamo sempre calcolare il numero decimale relativo facendo la divisione di a e b. Il numero ottenuto dalla divisione può essere un numero decimale esatto o può essere un numero decimale periodico.

Teorema
La divisione di due numeri interi a e b produce un numero decimale esatto se e solo se il denominatore della frazione semplificata contiene solo i fattori 2 e 5.

(define (decimalizza a b)
  (setq mcd (gcd a b))
  (setq a (/ a mcd))
  (setq b (/ b mcd))
  ;(println a { } b { } (factor b))
  (setq uniq (unique (factor b)))
  (if (or (= uniq '(2)) (= uniq '(5)) (= uniq '(2 5)))
      (div a b)
      (list a b (div a b))
  ))

Proviamo:

(decimalizza 16322 4)
;-> 4080.5

(decimalizza 121 400)
;-> 0.3025

(decimalizza 32001 20000)
;-> 1.60005

(decimalizza 22763 16384)
;-> 1.38934326171875

(decimalizza 1 2)
;-> 0.5

(decimalizza 1 3)
;-> (1 3 0.3333333333333333)

(decimalizza  3598  2261)
;-> (514 323 1.591331269349845)

(decimalizza 12211  2113)
;-> (12211 2113 5.7789872219593)

Vedi anche "Approssimazione dei numeri decimali con frazioni" su "Note libere 18".


-----------
Memory game
-----------

Memory è un gioco di carte che richiede concentrazione e memoria in cui occorre accoppiare le carte uguali.
Può essere giocato come solitario o in competizione tra due giocatori.
Si parte con tutte le carte coperte.
A turno ogni giocatore scopre due carte:
se le due carte sono uguali, allora il giocatore guadagna un punto e le due carte rimangono scoperte.
se le due carte sono diverse, allora le carte vengono coperte.
Il gioco termina quando tutte le carte sono state scoperte.
Il vincitore è il giocatore con il maggior numero di punti.
Come solitario bisogna scoprire le carte nel minor numero di mosse possibili.

In questo caso implementiamo il gioco come solitario e usiamo le lettere dell'alfabeto al posto delle carte.
Il gioco si presenta visivamente nel modo seguente (es. 12 lettere):

Inizio:
  0  1  2  3  4  5  6  7  8  9 10 11  ; indice delle lettere
  *  *  *  *  *  *  *  *  *  *  *  *  ; lettere tutte coperte

Scelta delle lettere da scoprire:
(view 0 2)

Visualizzazione temporanea
  0  1  2  3  4  5  6  7  8  9 10 11
  a  *  a  *  *  *  *  *  *  *  *  *  ; lettere minuscole (temporanee)

Poichè le lettere sono uguali, allora restano scoperte:

  0  1  2  3  4  5  6  7  8  9 10 11
  A  *  A  *  *  *  *  *  *  *  *  *

Scelta delle lettere da scoprire:
(view 4 5)
  0  1  2  3  4  5  6  7  8  9 10 11
  A  *  A  *  e  b  *  *  *  *  *  *

Poichè le lettere non sono uguali, allora vengono coperte:

  0  1  2  3  4  5  6  7  8  9 10 11
  A  *  A  *  *  *  *  *  *  *  *  *

(view 5 6)
  0  1  2  3  4  5  6  7  8  9 10 11
  A  *  A  *  *  b  e  *  *  *  *  *

Poichè le lettere sono uguali, allora vengono coperte:

  0  1  2  3  4  5  6  7  8  9 10 11
  A  *  A  *  *  *  *  *  *  *  *  *

(view 4 6)
  0  1  2  3  4  5  6  7  8  9 10 11
  A  *  A  *  e  *  e  *  *  *  *  *

Poichè le lettere sono uguali, allora restano scoperte:

  0  1  2  3  4  5  6  7  8  9 10 11
  A  *  A  *  E  *  E  *  *  *  *  *

eccetera

Nota: la visualizzazione delle lettere minuscole rimane solo per poco tempo e poi viene cancellata.

La posizione corrente del gioco viene rappresentata dalla lista seguente:

Position = ("letter0" <0|1|2>) ("letter1" <0|1|2>) ... ("letterN-1" < 0|1|2 >)
  0 = lettera coperta
  1 = lettera scoperta
  2 = lettera temporaneamente visibile

Funzione per pulire lo schermo:

(define (clear-screen) (print "\027[H\027[2J"))

Funzione che stmpa la posizione corrente del gioco:

(define (print-position)
  (for (i 0 (- len 1)) (print (format "%3d" i)))
  (println)
  (dolist (c pos)
    (if (= 0 (c 1)) (print "  *") ; coperta
        (= 1 (c 1)) (print "  " (c 0)) ; scoperta
        (= 2 (c 1)) (print "  " (lower-case (c 0))) ; scoperta temporanea
    )
  )
  (println)
  '>)

Funzione che inizia un nuovo gioco:
num-lettere = numero di lettere da utilizzare
time-out = tempo di visualizzazione temporanea (millisecondi)

(define (new-game num-lettere time-out)
  (clear-screen)
  (setq wait time-out)
  (setq mosse 0)
  ; creazione della posizione iniziale delle lettere
  (setq lettere (explode (slice "ABCDEFGHIJKLMNOPQRSTUVWXYZ" 0 num-lettere)))
  (setq pos (map (fn(x) (list x 0)) (randomize (extend lettere lettere))))
  (setq len (length pos))
  (print-position)
)

Funzione che verifica se il gioco è terminato:

(define (end-game?) (for-all (fn(x) (= (x 1) 1)) pos))

Funzione che permette di scegliere le lettere da scoprire (indice):

(define (view x y)
  (cond ((and (>= x 0) (< x len) (>= y 0) (< y len))
          (++ mosse)
          (setq c1 (first (pos x)))
          (setq c2 (first (pos y)))
          ;(println c1 { } c2)
          ; imposta gli elementi come visibili temporaneamente (2)
          (setf (pos x) (list c1 2))
          (setf (pos y) (list c2 2))
          ;(print pos) (read-line)
          ;(print c1 { } c2) (read-line)
          (print-position)
          ;(sleep wait)
          ;(clear-screen)
          ;(println c1 { } c2)
          (cond ((= c1 c2)
                  ; imposta gli elementi come visibili (1)
                  (setf (pos x) (list c1 1))
                  (setf (pos y) (list c2 1)))
                ((!= c1 c2)
                  ; imposta gli elementi come invisibili "*" (0)
                  (setf (pos x) (list c1 0))
                  (setf (pos y) (list c2 0)))
          )
        )
        (true nil)
  )
  (println "  mosse: " mosse)
  (if (end-game?) (println "  ****** GAME-OVER ******"))
  (print-position))

Facciamo una prova:

(new-game 6 2000)
  0  1  2  3  4  5  6  7  8  9 10 11
  *  *  *  *  *  *  *  *  *  *  *  *
>
> (view 0 1)
  0  1  2  3  4  5  6  7  8  9 10 11
  f  d  *  *  *  *  *  *  *  *  *  *
  mosse: 1
  0  1  2  3  4  5  6  7  8  9 10 11
  *  *  *  *  *  *  *  *  *  *  *  *
>
> (view 4 6)
  0  1  2  3  4  5  6  7  8  9 10 11
  *  *  *  *  b  *  b  *  *  *  *  *
  mosse: 2
  0  1  2  3  4  5  6  7  8  9 10 11
  *  *  *  *  B  *  B  *  *  *  *  *
>
> (view 10 11)
  0  1  2  3  4  5  6  7  8  9 10 11
  *  *  *  *  B  *  B  *  *  *  f  a
  mosse: 3
  0  1  2  3  4  5  6  7  8  9 10 11
  *  *  *  *  B  *  B  *  *  *  *  *
>
> (view 0 2)
  0  1  2  3  4  5  6  7  8  9 10 11
  f  *  d  *  B  *  B  *  *  *  *  *
  mosse: 4
  0  1  2  3  4  5  6  7  8  9 10 11
  *  *  *  *  B  *  B  *  *  *  *  *
>
> (view 1 2)
  0  1  2  3  4  5  6  7  8  9 10 11
  *  d  d  *  B  *  B  *  *  *  *  *
  mosse: 5
  0  1  2  3  4  5  6  7  8  9 10 11
  *  D  D  *  B  *  B  *  *  *  *  *
>
> (view 0 10)
  0  1  2  3  4  5  6  7  8  9 10 11
  f  D  D  *  B  *  B  *  *  *  f  *
  mosse: 6
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  *  B  *  B  *  *  *  F  *
>
> (view 3 5)
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  c  B  e  B  *  *  *  F  *
  mosse: 7
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  *  B  *  B  *  *  *  F  *
>
> (view 7 9)
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  *  B  *  B  a  *  c  F  *
  mosse: 8
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  *  B  *  B  *  *  *  F  *
>
> (view 11 7)
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  *  B  *  B  a  *  *  F  a
  mosse: 9
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  *  B  *  B  A  *  *  F  A
>
> (view 3 9)
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  c  B  *  B  A  *  c  F  A
  mosse: 10
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  C  B  *  B  A  *  C  F  A
>
> (view 5 8)
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  C  B  e  B  A  e  C  F  A
  mosse: 11
  ****** GAME-OVER ******
  0  1  2  3  4  5  6  7  8  9 10 11
  F  D  D  C  B  E  B  A  E  C  F  A

Nota: se si sceglie una lettera già scoperta, allora quella lettera verrà coperta.


---------------------
Sigarette e mozziconi
---------------------

Una sigaretta può essere fatta con quattro mozziconi di sigaretta (che genera un mozzicone dopo essere stata fumata).

1) Dato un numero di mozziconi N quante sigarette possiamo fumare?
2) Dato un numero di sigarette N quante sigarette possiamo fumare?


1) N mozziconi
--------------
Il problema può essere risolto in maniera ricorsiva oppure si può notare che:
con N mozziconi, psossiamo trasformarne 4 in una sigaretta, fumarla e guadagnare un mozzicone per raggiungere (N-3).
Quindi dobbiamo contare il numero di volte che possiamo sottrarre 3 N prima di raggiungere N < 4.
Se N <= 3, allora il risultato vale 0 (nessuna sigaretta).

(define (mozziconi num)
  (if (<= num 3) 0
      (+ (div (- num 4) 3) 1)))

Proviamo:

(mozziconi 3)
;-> 0
(mozziconi 8)
;-> 2
(mozziconi 10)
;-> 3
(mozziconi 42)
;-> 13

2) N sigarette
--------------
Possiamo risolvere il problema 'fumando' le sigarette per ottenere il numero di mozziconi e poi utilizzare la funzione precedente "mozziconi".

(define (sigarette num)
  (+ num (mozziconi num)))

Proviamo:

(sigarette 3)
;-> 3

(sigarette 4)
;-> 5

(sigarette 10)
;-> 13

(sigarette 20)
;-> 26

(sigarette 42)
;-> 55


--------------------------
La funzione matematica TAK
--------------------------

La funzione TAK (Takeuchi 1978) è definita come segue per gli interi x,y,z:

 t(x,y,z) = | y, se x <= y
            | t(t(x-1,y,z), t(y-1,z,x), t(z-1,x,y)), altrimenti

Oppure, in modo più semplice:

            | y, se x <= y
 t(x,y,z) = | z, se (x > y) e (y <= z)
            | x, altrimenti

Metodo semplificato 1:
----------------------

(define (ts1 x y z)
  (cond ((<= x y) y)
        ((and (> x y) (<= y z)) z)
        (true x)))

Proviamo:

(ts1 3 5 15)
;-> 5
(ts1 5 5 15)
;-> 5
(ts1 5 3 15)
;-> 15
(ts1 5 3 3)
;-> 3
(ts1 5 3 0)
;-> 5

Metodo semplificato 2:
----------------------

(define (ts2 x y z)
  (if (> x y)
      (if (> y z) x z)
      y))

(ts2 3 5 15)
;-> 5
(ts2 5 5 15)
;-> 5
(ts2 5 3 15)
;-> 15
(ts2 5 3 3)
;-> 3
(ts2 5 3 0)
;-> 5

Metodo ricorsivo 1:
-------------------

(define (tr1 x y z)
  (cond ((<= x y) y)
        (true (tr1 (tr1 (- x 1) y z) (tr1 (- y 1) z x) (tr1 (- z 1) x y)))))

Proviamo: 

(tr1 3 5 15)
;-> 5
(tr1 5 5 15)
;-> 5
(tr1 5 3 15)
;-> 15
(tr1 5 3 3)
;-> 3
(tr1 5 3 0)
;-> 5

Attenzione: il caso z > x > y genera molte chiamate.

(time (tr1 5 3 13))
;-> 31.234
(time (tr1 5 3 14))
;-> 124.928
(time (tr1 5 3 15))
;-> 624.816
(time (tr1 5 3 16))
;-> 4000.816
(time (tr1 5 3 17))
;-> 27236.815

Metodo ricorsivo 2 (smart):
---------------------------

(define (tr2 x y z) (if (> x y) (tr2 y z x) y))

Proviamo:

(tr2 3 5 15)
;-> 5
(tr2 5 5 15)
;-> 5
(tr2 5 3 15)
;-> 15
(tr2 5 3 3)
;-> 3
(tr2 5 3 0)
;-> 5

Vediamo se le funzioni ts1, ts2, tr1 e tr2 producono gli stessi risultati:

(define (test n)
  (setq out1 '())
  (setq out2 '())
  (setq out3 '())
  (setq out4 '())
  (for (x 0 n)
    (for (y 0 n)
      (for (z 0 n)
        (push (ts1 x y z) out1 -1)
        (push (ts2 x y z) out2 -1)
        (push (tr1 x y z) out3 -1)
        (push (tr2 x y z) out4 -1))))
  (= out1 out2 out3 out4))

(test 10)
;-> true

(time (println (test 11)))
;-> true
;-> 9875.835

(time (println (test 12)))
;-> true
;-> 67237.798

Vediamo quante volte viene chiamata la funzione tr1 per x, y e z.

(define (caller x y z)
  (let (calls 0)
    (define (tr1 x y z)
      (++ calls)
      (cond ((<= x y) y)
            (true (tr1 (tr1 (- x 1) y z) (tr1 (- y 1) z x) (tr1 (- z 1) x y)))))
    (println (tr1 x y z) { } calls)))

Proviamo:

(caller 5 3 13)
;-> 13 173241
(caller 5 3 14)
;-> 14 976669
(caller 5 3 15)
;-> 5899313
(caller 5 3 16)
;-> 37913361

37 milioni 913 mila e 361 chiamate, ecco perchè tr2 è lentissima.


--------------------------------------------------
Numeri come somma di un numero e del suo contrario
--------------------------------------------------

In quanti modi possiamo esprimere un intero positivo N come somma di due interi positivi k e il contrario di k.
Per esempio:

  N = 132
  93 + 39 = 132
  84 + 48 + 132
  75 + 57 + 132
  66 + 66 + 132

  N = 101
  100 + 001 = 100 + 1 = 101

(define (mirror num)
  (let (out '())
    (for (k 0 num)
      ; calcola il contrario (inverso) del numero
      (setq kappa (int (reverse (string k)) 0 10))
      (if (= (+ k kappa) num)
          (if (> k kappa)
            (push (list k kappa) out -1)
            (push (list kappa k) out -1)
          )
      )
    )
    (unique out)))

Proviamo:

(mirror 132)
;-> ((93 39) (84 48) (75 57) (66 66))

(mirror 101)
;-> ((100 1))

(mirror 0)
;-> ((0 0))

(mirror 1)
;-> ()

(mirror 2)
;-> ((1 1))

(mirror 64)
;-> ()

(mirror 128)
;-> ()

Vediamo come varia il numero di somme uguali al crescere di N:

(length (mirror 132))
;-> 4
(length (mirror 955548))
;-> 113
(length (mirror 49886))
;-> 0
(length (mirror 1100000))
;-> 450

Vediamo per i primi 101 numeri:

(map length (map mirror (sequence 0 100)))
;-> (1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 0 1 0 1 0 0 0 2 0 0 0 0 0 0 0 0 0 0
;->  2 0 0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0
;->  4 0 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0
;->  5 0)

(mirror 99)
;-> ((81 18) (72 27) (63 36) (54 45) (90 9))

Vediamo quali numeri fanno scattare il numero successivo di somme uguali:

(define (mirror-length limit)
  (setq somma 1)
  (for (num 0 limit)
    (setq lst (mirror num))
    (setq len (length lst))
    (if (= somma len)
      (begin
        (println num { : } len)
        (println lst "\n")
        (++ somma)))))

Proviamo:

(mirror-length 10000)
;-> 0 : 1
;-> ((0 0))
;-> 
;-> 22 : 2
;-> ((11 11) (20 2))
;-> 
;-> 44 : 3
;-> ((31 13) (22 22) (40 4))
;-> 
;-> 66 : 4
;-> ((51 15) (42 24) (33 33) (60 6))
;-> 
;-> 88 : 5
;-> ((71 17) (62 26) (53 35) (44 44) (80 8))
;-> 
;-> 1111 : 6
;-> ((902 209) (803 308) (704 407) (605 506) (1010 101) (1100 11))
;-> 
;-> 1661 : 7
;-> ((1060 601) (1150 511) (1240 421) (1330 331) (1420 241) (1510 151) 
;->  (1600 61))
;-> 
;-> 1771 : 8
;-> ((1070 701) (1160 611) (1250 521) (1340 431) (1430 341) (1520 251)
;->  (1610 161) (1700 71))
;-> 
;-> 1881 : 9
;-> ((1080 801) (1170 711) (1260 621) (1350 531) (1440 441) (1530 351)
;->  (1620 261) (1710 171) (1800 81))
;-> 
;-> 1991 : 10
;-> ((1090 901) (1180 811) (1270 721) (1360 631) (1450 541) (1540 451)
;->  (1630 361) (1720 271) (1810 181) (1900 91))
;-> 
;-> 2662 : 11
;-> ((1601 1061) (1511 1151) (1421 1241) (1331 1331) (2060 602) (2150 512)
;->  (2240 422) (2330 332) (2420 242) (2510 152) (2600 62))
;-> 
;-> 2772 : 12
;-> ((1701 1071) (1611 1161) (1521 1251) (1431 1341) (2070 702) (2160  612)
;->  (2250 522) (2340 432) (2430 342) (2520 252) (2610 162) (2700 72))
;-> 
;-> 4444 : 13
;-> ((3401 1043) (3311 1133) (3221 1223) (3131 1313) (3041 1403) (2402 2042)
;->  (2312 2132) (2222 2222) (4040 404) (4130 314) (4220 224) (4310 134)
;->  (4400 44))
;-> 
;-> 6336 : 14
;-> ((5301 1035) (5211 1125) (5121 1215) (5031 1305) (4302 2034) (4212 2124)
;->  (4122 2214) (4032 2304) (3303 3033) (3213 3123) (6030 306) (6120 216)
;->  (6210 126) (6300 36))
;-> 
;-> 6545 : 15
;-> ((4951 1594) (4861 1684) (4771 1774) (4681 1864) (4591 1954) (3952 2593)
;->  (3862 2683) (3772 2773) (3682 2863) (3592 2953) (5590 955) (5680 865)
;->  (5770 775) (5860 685) (5950 595))
;-> 
;-> 7337 : 16
;-> ((6301 1036) (6211 1126) (6121 1216) (6031 1306) (5302 2035) (5212 2125)
;->  (5122 2215) (5032 2305) (4303 3034) (4213 3124) (4123 3214) (4033 3304)
;->  (7030 307) (7120 217) (7210 127) (7300 37))


-----------------------
Sequenza Mephisto Waltz
-----------------------

La sequenza Mephisto Waltz è definita iniziando con 0 e poi sostituendo 0 con 001 e 1 con 110.
Questi numeri non contengono le quarte potenze (Allouche e Shallit 2003).

Sequenza OEIS A064990:
  If A_k denotes the first 3^k terms, 
  then A_0 = 0, A_{k+1} = A_k A_k B_k, 
  where B_k is obtained from A_k by interchanging 0's and 1's.
  0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0,
  0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0,
  1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1,
  0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1,
  1, 1, 0, ...

(define (mw num)
  (setq out '("0"))
  (for (i 1 num)
    (setq s (out -1))
    (setq val "")
    (for (i 0 (- (length s) 1))
      (cond ((= (s i) "0") (extend val "001"))
            ((= (s i) "1") (extend val "110"))
      )
    )
    (push val out -1)
  )
  out)

Proviamo:

(mw 5)
;-> ("0" "001" "001001110" "001001110001001110110110001" 
;->  "001001110001001110110110001001001110001001110110110
;->   001110110001110110001001001110"
;->  "001001110001001110110110001001001110001001110110110
;->   001110110001110110001001001110001001110001001110110
;->   110001001001110001001110110110001110110001110110001
;->   001001110110110001110110001001001110110110001110110
;->   001001001110001001110001001110110110001")


--------------------------
Trova le differenze (game)
--------------------------

Il classico gioco della settimana enigmistica in cui ci sono due vignette quasi identiche che differiscono solo per alcuni perticolari che bisogna individuare.
In questo caso usiamo due matrici al posto delle vignette.

Funzione che stampa le due matrici:

(define (print-grids grid1 grid2)
  (local (row col)
    (setq row (length grid1))
    (setq col (length (first grid1)))
    (print "  " (join (map string (sequence 0 (- row 1))) " "))
    (println "     " (join (map string (sequence 0 (- row 1))) " "))
    (for (i 0 (- row 1))
      (print i { })
      (for (j 0 (- col 1))
        (cond ((= (grid1 i j) 0) (print ". "))
              ((= (grid1 i j) 1) (print "* "))
              (true (println "ERROR" ))
        )
      )
      (print {  } i { })
      (for (j 0 (- col 1))
        (cond ((= (grid2 i j) 0) (print ". "))
              ((= (grid2 i j) 1) (print "* "))
              (true (println "ERROR"))
        )
      )
      (println))))

Funzione che cambia 0 in 1 e 1 in 0:

(define (flip x) (- 1 x))

Funzione che inizia un nuovo gioco:

(define (new-game dim num-diff)
  ; m1, m2 e start-time sono globali
  (local (selected diff r c)
    ; genera la prima matrice
    (setq m1 (array dim dim (rand 2 (* dim dim))))
    ; seconda matrice uguale alla prima
    (setq m2 m1)
    ; crea le differenze cambiando num-diff elementi di m2
    (setq selected '())
    (setq diff 0)
    (while (< diff num-diff)
      (setq r (rand dim))
      (setq c (rand dim))
      (cond ((not (ref (list r c) selected))
             (setq (m2 r c) (flip (m2 r c)))
             (push (list r c) selected)
             (++ diff))
            (true nil)
      )
    )
    ; partenza del timer
    (setq start-time (time-of-day))
    (print-grids m1 m2)
    '>))

Funzione che formatta i millisecondi in giorni:ore:minuti:secondi:millisec:

(define (periodo msec show)
  (local (conv unit expr val)
    (setq conv '(("d" 86400000) ("h" 3600000) ("m" 60000) ("s" 1000) ("ms" 1)))
    (setq msec (int msec))
    (dolist (el conv)
      (setq unit (el 0))
      (setq expr (el 1))
      (setq val (/ msec expr))
      ; numero di millisecondi rimasti
      ; (resto della divisione)
      (setq msec (% msec expr))
      (if (> val 0) (print val unit " "))
    )
    (println)
    '>))

Funzione che modifica la seconda matrice:

(define (change row col)
  (local (rows cols)
    (setq rows (length m2))
    (setq cols (length (m2 0)))
    (if (and (>= row 0) (< row rows) (>= col 0) (< col cols))
        (setq (m2 row col) (flip (m2 row col)))
    )
    (print-grids m1 m2)
    (if (= m1 m2)
        (println "\n****** GAME OVER ******\n"
                 "Tempo: " (periodo (- (time-of-day) start-time)) "\n")
    )'>))

Proviamo:

(new-game 4 3)
;->   0 1 2 3     0 1 2 3
;-> 0 . * * *   0 . . * *
;-> 1 . * . *   1 . . . *
;-> 2 . . * .   2 . * * .
;-> 3 . * . .   3 . * . .

(change 0 1)
;->   0 1 2 3     0 1 2 3
;-> 0 . * * *   0 . * * *
;-> 1 . * . *   1 . . . *
;-> 2 . . * .   2 . * * .
;-> 3 . * . .   3 . * . .

(change 1 1)
;->   0 1 2 3     0 1 2 3
;-> 0 . * * *   0 . * * *
;-> 1 . * . *   1 . * . *
;-> 2 . . * .   2 . * * .
;-> 3 . * . .   3 . * . .

(change 2 1)
;->   0 1 2 3     0 1 2 3
;-> 0 . * * *   0 . * * *
;-> 1 . * . *   1 . * . *
;-> 2 . . * .   2 . . * .
;-> 3 . * . .   3 . * . .
;-> 
;-> ****** GAME OVER ******
;-> Tempo: 23s 399ms


------------------------------------------
Sequenza da completare con le sue distanze
------------------------------------------

Data una sequenza di interi A = a(1), a(2), ..., a(n) con n>=2, applicare il seguente algoritmo:

A partire da i=2, per tutti gli a(i) in A (fino all'ultimo elemento):
  Se d = |a(i) - a (i-1)| non è già in A, aggiungere d ad A
  Aumentare i
Restituire la sequenza completa.

Per esempio,

  lista = (2 3 5 7 11)

   ---
  (2 3 5 7 11), 3 - 2 = 1,
  1 non esiste e lo aggiungiamo (2 3 5 7 11 1)

     ---
  (2 3 5 7 11 1), 5 - 3 = 2,
  2 esiste e non lo aggiungiamo: (2 3 5 7 11 1)

       ---
  (2 3 5 7 11 1), 7 - 5 = 2,
  2 esiste e non lo aggiungiamo: (2 3 5 7 11 1)

         ----
  (2 3 5 7 11 1 4), 11 - 7 = 4,
  4 non esiste e lo aggiungiamo (2 3 5 7 11 1 4)

           ----
  (2 3 5 7 11 1 4), 11 - 1 = 10,
  10 non esiste e lo aggiungiamo (2 3 5 7 11 1 4 10)

              ---
  (2 3 5 7 11 1 4 10), 4 - 1 = 3,
  3 esiste e non lo aggiungiamo: (2 3 5 7 11 1 4 10)

                ----
  (2 3 5 7 11 1 4 10), 10 - 4 = 6,
  6 non esiste e lo aggiungiamo (2 3 5 7 11 1 4 10 6)

                  ----
  (2 3 5 7 11 1 4 10 6), 10 - 6 = 4,
  4 esiste e non lo aggiungiamo: (2 3 5 7 11 1 4 10 6)

  La lista è terminata, risultato: (2 3 5 7 11 1 4 10 6).

Prima di scrivere la funzione vediamo le differenze tra i cicli "dolist" e "while" nell'attraversamento e la modifica di una lista.

Uso della funzione "dolist":

(define (test lst)
  (dolist (el lst)
    (push el lst -1)
    (print lst) (read-line)
  ))

(test '(1 2 3))
;-> (1 2 3 1)
;-> (1 2 3 1 2)
;-> (1 2 3 1 2 3)

Il ciclo non continua all'infinito perchè la lista nel ciclo "(dolist (el lst)" è una copia di lst.

Uso della funzione "while":

(define (test2 lst)
  (setq k 0)
  (while (< k (length lst))
    (push (lst k) lst -1)
    (print lst) (read-line)
    (++ k)))

(test2 '(1 2 3))
;-> (1 2 3 1)
;-> (1 2 3 1 2)
;-> (1 2 3 1 2 3)
;-> (1 2 3 1 2 3 1)
;-> (1 2 3 1 2 3 1 2)
;-> (1 2 3 1 2 3 1 2 3)
;-> (1 2 3 1 2 3 1 2 3 1)
;-> (1 2 3 1 2 3 1 2 3 1 2)
;-> (1 2 3 1 2 3 1 2 3 1 2 3)
;-> (1 2 3 1 2 3 1 2 3 1 2 3 1)
;-> ...

In questo caso il ciclo continua all'infinito perchè la lista nel ciclo "(while (< k (length lst))" è quella originale (cioè quella stiamo modificando).
Da notare che se scriviamo:

  (setq (len (length lst)))
  (while (< k len))

Allora il ciclo termina come nel caso del ciclo "dolist".

(define (distanze lst)
  (let (k 1)
    (while (< k (length lst))
      (setq dist (abs (- (lst k) (lst (- k 1)))))
      (if (nil? (ref dist lst)) (push dist lst -1))
      (print lst) (read-line)
      (++ k)
    )
    lst))

Proviamo:

(distanze '(2 3 5 7 11))
;-> (2 3 5 7 11 1 4 10 6)

(distanze '(1 2))
;-> (1 2)

(distanze '(2 3 7 11 17 24))
;-> (2 3 7 11 17 24 1 4 6 23)

(distanze '(24 3 -16 11 -17 21))
;-> (24 3 -16 11 -17 21 19 27 28 38 2 8 1 10 36 6 7 9 26 30 17 4 13)

(length (distanze '(2 -3 7 -11 17 -24)))
;-> (2 -3 7 -11 17 -24 5 10 18 28 41 29 8 13 12 21 1 9 20 11)

Domande:

1) L'algoritmo termina sempre?
Se i numeri della lista iniziale sono tutti positivi, allora ogni volta aggiungiamo sempre un termine minore del valore massimo presente nella lista. Quindi possiamo ottenere solo una lista di output finita.
Se abbiamo anche numeri negativi, allora possiamo inserire anche valori maggiori del valore massimo presente nella lista. Comunque aggiungiamo sempre un numero positivo, quindi anche in questo caso, dopo aver calcolato tutte le differenze con i numeri negativi, l'algoritmo deve terminare.

2) Con una lista di input lunga N quanto può essere lunga al massimo la lista di output?
Con N elementi facciamo (N-1) sottrazioni e possiamo generare (N-1) elementi.
Però il primo elemento generato deve essere sottratto all'ultimo elemento della lista precedente, quindi facciamo sempre (N-1) sottrazioni (al massimo) e possiamo generare (N-1) elementi.
Comunque non ho la minima idea se esiste e quale potrebbe essere la soluzione a questa domanda.


----------------------------------------
Sequenza di numeri compositi consecutivi
----------------------------------------

Per generare numeri compositi consecutivi ci sono diversi metodi.
Le formule più comuni sono le seguenti:

Per generare N numeri compositi consecutivi:

  (N+1)! + 2, (N+1)! + 3, ..., (N+1)! + (N+1)
  
Per generare (N-1) numeri compositi consecutivi:

    N! + 2, N! + 3, ..., N! + N

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (genera1 num)
  (let (f (fact-i (+ num 1)))
    (map (fn(x) (+ f x)) (sequence 2 (+ num 1)))))

(map (fn(x) (list $idx (genera1 x))) (sequence 1 5))
;-> ((0 (4L)) (1 (8L 9L)) (2 (26L 27L 28L)) (3 (122L 123L 124L 125L)) 
;->  (4 (722L 723L 724L 725L 726L)))

(define (genera2 num)
  (let (f (fact-i num))
    (map (fn(x) (+ f x)) (sequence 2 num))))

(map (fn(x) (list $idx (genera2 x))) (sequence 1 5))
;-> ((0 (3L 2L)) (1 (4L)) (2 (8L 9L)) (3 (26L 27L 28L)) 
;->  (4 (122L 123L 124L 125L)))


--------------------------------------------------------
Tavola delle moltiplicazioni (pitagorica) in esadecimale
--------------------------------------------------------

Scrivere una funzione che stampa la tavola delle moltiplicazioni (tavola pitagorica) con numeri in esadecimale.

Per esempio la seguente è una tavola delle moltiplicazioni con i numeri che vanno da 0 (00) a 15 (0f):

  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
  00 02 04 06 08 0a 0c 0e 10 12 14 16 18 1a 1c 1e 
  00 03 06 09 0c 0f 12 15 18 1b 1e 21 24 27 2a 2d 
  00 04 08 0c 10 14 18 1c 20 24 28 2c 30 34 38 3c 
  00 05 0a 0f 14 19 1e 23 28 2d 32 37 3c 41 46 4b 
  00 06 0c 12 18 1e 24 2a 30 36 3c 42 48 4e 54 5a 
  00 07 0e 15 1c 23 2a 31 38 3f 46 4d 54 5b 62 69 
  00 08 10 18 20 28 30 38 40 48 50 58 60 68 70 78 
  00 09 12 1b 24 2d 36 3f 48 51 5a 63 6c 75 7e 87 
  00 0a 14 1e 28 32 3c 46 50 5a 64 6e 78 82 8c 96 
  00 0b 16 21 2c 37 42 4d 58 63 6e 79 84 8f 9a a5 
  00 0c 18 24 30 3c 48 54 60 6c 78 84 90 9c a8 b4 
  00 0d 1a 27 34 41 4e 5b 68 75 82 8f 9c a9 b6 c3 
  00 0e 1c 2a 38 46 54 62 70 7e 8c 9a a8 b6 c4 d2 
  00 0f 1e 2d 3c 4b 5a 69 78 87 96 a5 b4 c3 d2 e1 

(define (print-ff a b)
  (local (max-len fmt)
    (setq max-len (length (format "%X" (* b b))))
    (setq fmt (string "%0" max-len "X "))
    (for (row a b)
      (for (col a b) (print (format fmt (* row col))))
      (println)
    )
    '>))

Proviamo:

(print-ff 0 15)
;-> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
;-> 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
;-> 00 02 04 06 08 0A 0C 0E 10 12 14 16 18 1A 1C 1E
;-> 00 03 06 09 0C 0F 12 15 18 1B 1E 21 24 27 2A 2D
;-> 00 04 08 0C 10 14 18 1C 20 24 28 2C 30 34 38 3C
;-> 00 05 0A 0F 14 19 1E 23 28 2D 32 37 3C 41 46 4B
;-> 00 06 0C 12 18 1E 24 2A 30 36 3C 42 48 4E 54 5A
;-> 00 07 0E 15 1C 23 2A 31 38 3F 46 4D 54 5B 62 69
;-> 00 08 10 18 20 28 30 38 40 48 50 58 60 68 70 78
;-> 00 09 12 1B 24 2D 36 3F 48 51 5A 63 6C 75 7E 87
;-> 00 0A 14 1E 28 32 3C 46 50 5A 64 6E 78 82 8C 96
;-> 00 0B 16 21 2C 37 42 4D 58 63 6E 79 84 8F 9A A5
;-> 00 0C 18 24 30 3C 48 54 60 6C 78 84 90 9C A8 B4
;-> 00 0D 1A 27 34 41 4E 5B 68 75 82 8F 9C A9 B6 C3
;-> 00 0E 1C 2A 38 46 54 62 70 7E 8C 9A A8 B6 C4 D2
;-> 00 0F 1E 2D 3C 4B 5A 69 78 87 96 A5 B4 C3 D2 E1

(print-ff 1 18)
;-> 001 002 003 004 005 006 007 008 009 00A 00B 00C 00D 00E 00F 010 011 012
;-> 002 004 006 008 00A 00C 00E 010 012 014 016 018 01A 01C 01E 020 022 024
;-> 003 006 009 00C 00F 012 015 018 01B 01E 021 024 027 02A 02D 030 033 036
;-> 004 008 00C 010 014 018 01C 020 024 028 02C 030 034 038 03C 040 044 048
;-> 005 00A 00F 014 019 01E 023 028 02D 032 037 03C 041 046 04B 050 055 05A
;-> 006 00C 012 018 01E 024 02A 030 036 03C 042 048 04E 054 05A 060 066 06C
;-> 007 00E 015 01C 023 02A 031 038 03F 046 04D 054 05B 062 069 070 077 07E
;-> 008 010 018 020 028 030 038 040 048 050 058 060 068 070 078 080 088 090
;-> 009 012 01B 024 02D 036 03F 048 051 05A 063 06C 075 07E 087 090 099 0A2
;-> 00A 014 01E 028 032 03C 046 050 05A 064 06E 078 082 08C 096 0A0 0AA 0B4
;-> 00B 016 021 02C 037 042 04D 058 063 06E 079 084 08F 09A 0A5 0B0 0BB 0C6
;-> 00C 018 024 030 03C 048 054 060 06C 078 084 090 09C 0A8 0B4 0C0 0CC 0D8
;-> 00D 01A 027 034 041 04E 05B 068 075 082 08F 09C 0A9 0B6 0C3 0D0 0DD 0EA
;-> 00E 01C 02A 038 046 054 062 070 07E 08C 09A 0A8 0B6 0C4 0D2 0E0 0EE 0FC
;-> 00F 01E 02D 03C 04B 05A 069 078 087 096 0A5 0B4 0C3 0D2 0E1 0F0 0FF 10E
;-> 010 020 030 040 050 060 070 080 090 0A0 0B0 0C0 0D0 0E0 0F0 100 110 120
;-> 011 022 033 044 055 066 077 088 099 0AA 0BB 0CC 0DD 0EE 0FF 110 121 132
;-> 012 024 036 048 05A 06C 07E 090 0A2 0B4 0C6 0D8 0EA 0FC 10E 120 132 144


---------------------------
Sequenze binarie bilanciate
---------------------------

Scrivere due funzioni:

a) una per generare la lista di sequenze bilanciate di 2n cifre binarie scritte in base 10.
Una sequenza bilanciata di 2n cifre binarie contiene lo stesso numero di 0 e 1.
Per esempio,
101010 è bilanciata, 1011 non è bilanciata

Sequenza OEIS A031443:
Digitally balanced numbers: positive numbers that in base 2 have the same number of 0's as 1's.
  2, 9, 10, 12, 35, 37, 38, 41, 42, 44, 49, 50, 52, 56, 135, 139, 141, 142,
  147, 149, 150, 153, 154, 156, 163, 165, 166, 169, 170, 172, 177, 178, 180,
  184, 195, 197, 198, 201, 202, 204, 209, 210, 212, 216, 225, 226, 228, 232,
  240, 527, 535, 539, 541, 542, 551, ...

b) una per generare la lista di sequenze totalmente bilanciate di 2n cifre binarie scritte in base 10.
Una sequenza totalmente bilanaciata di 2n cifre binarie contiene lo stesso numero di 0 e 1 e leggendo da sinistra a destra (dal bit più significativo a quello meno significativo), il numero di 0 non supera mai il numero di 1.
Per esempio,
101010 è bilanciata, 100011 non è bilanciata

Sequenza OEIS A014486:
List of totally balanced sequences of 2n binary digits written in base 10.
Binary expansion of each term contains n 0's and n 1's and reading from left to right (the most significant to the least significant bit), the number of 0's never exceeds the number of 1's.
  0, 2, 10, 12, 42, 44, 50, 52, 56, 170, 172, 178, 180, 184, 202, 204, 210,
  212, 216, 226, 228, 232, 240, 682, 684, 690, 692, 696, 714, 716, 722, 724,
  728, 738, 740, 744, 752, 810, 812, 818, 820, 824, 842, 844, 850, 852, 856,
  866, 868, 872, 880, 906, 908, 914, ...

a) Sequenze binarie bilanciate

(define (balanced? num)
  (local (binary len conta)
    (setq binary (explode (bits num)))
    (setq len (length binary))
    (setq conta (count '("1" "0") binary))
    (cond ((odd? len) nil)
          ((!= (conta 0) (conta 1)) nil)
          (true true))))

Proviamo:

(filter balanced? (sequence 0 600))
;-> (2 9 10 12 35 37 38 41 42 44 49 50 52 56 135 139 141 142 147 149 150
;->  153 154 156 163 165 166 169 170 172 177 178 180 184 195 197 198 201
;->  202 204 209 210 212 216 225 226 228 232 240 527 535 539 541 542 551
;->  555 557 558 563 565 566 569 570 572 583 587 589 590 595 597 598)

b) Sequenze binarie totalmente bilanciate

(define (totally-balanced? num)
  (local (binary len conta)
    (setq binary (explode (bits num)))
    (setq len (length binary))
    (setq conta (count '("1" "0") binary))
    (cond ((odd? len) nil)
          ((!= (conta 0) (conta 1)) nil)
          (true 
            (let ( (exceed nil) (n1 0) (n0 0) )
              (dolist (b binary exceed)
                (cond ((= b "1") (++ n1))
                      ((= b "0") (++ n0))
                )
                (if (> n0 n1) (setq exceed true))
              )
              (not exceed))))))

Proviamo:

(filter totally-balanced? (sequence 0 1000))
;-> (2 10 12 42 44 50 52 56 170 172 178 180 184 202 204 210 212 216 226
;->  228 232 240 682 684 690 692 696 714 716 722 724 728 738 740 744 752
;->  810 812 818 820 824 842 844 850 852 856 866 868 872 880 906 908 914
;->  916 920 930 932 936 944 962 964 968 976 992)


-------------------------------------------------
Perimetro e area di figure geometriche 2D di base
-------------------------------------------------

(constant (global 'PI) 3.1415926535897931)
Figure 2D
---------
(define (triangolo-perimetro a b c) (add a b c))
(define (triangolo-area a b c)
  (let (s (div (add a b c) 2))
    (sqrt (mul s (sub s a) (sub s b) (sub s c)))))
(define (quadrato-perimetro a) (mul 4 a))
(define (quadrato-area a) (mul a a))
(define (rettangolo-perimetro a b) (mul 2 (add a b)))
(define (rettangolo-area a b) (mul a b))
(define (rombo-area d1 d2) (/ (mul d1 d2) 2))
(define (rombo-perimetro a) (mul 4 a))
(define (parallelogramma-perimetro a b) (mul 2 a b))
(define (parallelogramma-area b h) (mul b h))
(define (trapezio-perimetro a b b1 b2) (add a b b1 b2))
(define (trapezio-area b1 b2 h) (/ (mul (add b1 b2) h) 2))
(define (cerchio-perimetro r) (mul 2 PI r))
(define (cerchio-area r) (mul PI r r))
; Formula esatta
; 2p = 4a*Integral[0,2PI](sqrt(1 - e^2*sin^2(t))dt)
; e^2 = sqrt(a^2 + a^2) / a
; Formula approssimata per eccesso
(define (ellisse-perimetro a b c d) (mul 2 PI (sqrt (/ (add (mul a a) (mul b b)) 2))))
(define (ellisse-area a b) (mul PI  a b))

Vedi immagine "figure2D.png" nella cartella "Data".


------------------------------------
Lunghezza di una stringa + lunghezza
------------------------------------

Data una stringa di caratteri ASCII, determinare la lunghezza della stringa quando aggiungiamo la lunghezza della stringa alla stringa stessa.

Per esempio,
  str = "abc"
  output = "abc4" = 4
  Partendo da str = "abc"
  Aggiungiamo la lunghezza della stringa alla stringa = "abc3"
  Lunghezza della nuova stringa = 4
  Aggiungiamo la lunghezza della stringa alla stringa = "abc4"
  Lunghezza della nuova stringa = 4

Algoritmo
1) Partendo dalla stringa data aggiungiamo la lunghezza della stringa (k).
2) Se lunghezza della nuova stringa è uguale a k:
   allora abbiamo trovato il risultato,
   altrimenti aumentare k a tornare al passo 1).

(define (auto-len str)
  (local (len k ok tmp)
    (setq len (length str))
    (setq k (- len 1))
    (setq ok nil)
    (until ok
      (++ k)
      ; lunghezza della stringa con (ipotesi di) lunghezza
      (setq tmp (length (string str k)))
      (if (= k tmp)
        (begin
          (setq ok true)
          (println (string str k)))))))

Proviamo:

(auto-len "newLISP")
;-> newLISP8

(auto-len "programmazione")
;-> programmazione16

(auto-len "123456789")
;-> 12345678911


-----------------
Numeri ordinabili
-----------------

I numeri ordinabili sono quei numeri interi in cui due cifre decimali consecutive differiscono di 1 dopo aver ordinato le cifre in ordine decrescente.
Per esempio:

  N = 2013
  N ordinato = 3210
  (3-2) = 1
  (2-1) = 1
  (1-0) = 1
  Quindi 2013 è un numero ordinabile.

  N = 3254
  N ordinato = 5432
  (5-4) = 1
  (4-3) = 1
  (3-2) = 1
  Quindi 3254 è un numero ordinabile.

  N = 769
  N ordinato = 967
  (9-7) = 2
  (7-6) = 1
  Quindi 769 non è un numero ordinabile.

Sequenza OEIS A215014:
Numbers where any two consecutive decimal digits differ by 1 after arranging the digits in decreasing order.
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 21, 23, 32, 34, 43, 45, 54, 56, 65,
  67, 76, 78, 87, 89, 98, 102, 120, 123, 132, 201, 210, 213, 231, 234, 243,
  312, 321, 324, 342, 345, 354, 423, 432, 435, 453, 456, 465, 534, 543, 546,
  564, 567, 576, 645, 654, 657, 675, 678, 687, 756, 765, 768, 786, 789, 798,
  867, ..., a(4091131) = 9876543210 è l'ultimo termine.

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (ordinabile? num)
  (local (lst len)
    (setq lst (sort (int-list num) >))
    (setq len (length lst))
    (or (= len 1)
        (for-all (fn(x) (= 1 x)) (map - (chop lst) (rest lst))))))

Poichè risulta: (for-all (fn(x) (= 1 x)) '())  --> true, allora possiamo scrivere:

(define (ordinabile? num)
  (let (lst (sort (int-list num) >))
    (for-all (fn(x) (= 1 x)) (map - (chop lst) (rest lst)))))

Proviamo:

(ordinabile? 3254)
;-> true

(filter ordinabile? (sequence 0 1000))
;-> (0 1 2 3 4 5 6 7 8 9 10 12 21 23 32 34 43 45 54 56 65 67 76 78 87
;->  89 98 102 120 123 132 201 210 213 231 234 243 312 321 324 342 345
;->  354 423 432 435 453 456 465 534 543 546 564 567 576 645 654 657 675
;->  678 687 756 765 768 786 789 798 867 876 879 897 978 987)
;-> (0 1 2 3 4 5 6 7 8 9 10 12 21 23 32 34 43 45 54 56 65 67 76 78 87
;->  89 98 102 120 123 132 201 210 213 231 234 243 312 321 324 342 345
;->  354 423 432 435 453 456 465 534 543 546 564 567 576 645 654 657 675
;->  678 687 756 765 768 786 789 798 867 876 879 897 978 987)

Vediamo la velocità della funzione:

(time (filter ordinabile? (sequence 0 1e5)))
;-> 218.725
(time (filter ordinabile? (sequence 0 1e6)))
;-> 2635.978
(time (filter ordinabile? (sequence 0 1e7)))
;-> 30409.818 ; 30 sec
(time (filter ordinabile? (sequence 0 1e8)))
;-> 343904.709 ; 343 sec (5min 43 sec)

Non possiamo arrivare a 9876543210 (che vale quasi 1e10) in tempi brevi.

Se si esclude lo zero, il numero di termini con k cifre vale:

  termini(k) = (11-k)*k! - (k-1)! con 1 <= k <= 10
  (Franklin T. Adams-Watters, Aug 01 2012)

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (termini k) (- (* (fact-i k) (- 11 k)) (fact-i (- k 1))))

(termini 1)
;-> 9L
(termini 2)
;-> 17L

Vediamo quanti sono tutti i termini della sequenza (+ 1 che è lo 0 iniziale):

(+ (apply + (map terms (sequence 1 10))) 1)
;-> 4091131L

Quindi l'intera sequenza è composta da 4091131 termini/numeri.
L'ultimo termine/numero della sequenza è 9876543210.

Proviamo un altro metodo per calcolare tutti i numeri ordinabili.
I numeri ordinabili sono composti da n cifre ordinate che differiscono di 1 (con 1 <= N <=10).
Date le cifre 0 1 2 3 4 5 6 7 8 9 possiamo prendere tutti i gruppi composti da 1,2,3,4,5,6,7,8,9,10 cifre, calcolare le permutazioni di ogni elemento di ogni gruppo e aggiungere ogni permutazione al risultato finale.

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

(define (group-block lst num)
"Creates a list with blocks of elements: (0..num) (1..num+1) (n..num+n)"
  (local (out items len)
    (setq out '())
    (setq len (length lst))
    (if (>= len num) (begin
        ; numero di elementi nella lista di output (numero blocchi)
        (setq items (- len num (- 1)))
        (for (k 0 (- items 1))
          (push (slice lst k num) out -1)
        )
    ))
  out))

Calcoliamo i gruppi da 1 a 10 cifre:

(group-block '(9 8 7 6 5 4 3 2 1 0) 1)
;-> ((9) (8) (7) (6) (5) (4) (3) (2) (1) (0))
(group-block '(9 8 7 6 5 4 3 2 1 0) 2)
;-> ((9 8) (8 7) (7 6) (6 5) (5 4) (4 3) (3 2) (2 1) (1 0))
(group-block '(9 8 7 6 5 4 3 2 1 0) 3)
;-> ((9 8 7) (8 7 6) (7 6 5) (6 5 4) (5 4 3) (4 3 2) (3 2 1) (2 1 0))
...
(group-block '(9 8 7 6 5 4 3 2 1 0) 9)
;-> ((9 8 7 6 5 4 3 2 1) (8 7 6 5 4 3 2 1 0))
(group-block '(9 8 7 6 5 4 3 2 1 0) 10)
;-> ((9 8 7 6 5 4 3 2 1 0))

Per esempio prendiamo il gruppo con N=3:

(group-block '(9 8 7 6 5 4 3 2 1 0) 3)
;-> ((9 8 7) (8 7 6) (7 6 5) (6 5 4) (5 4 3) (4 3 2) (3 2 1) (2 1 0))

Le permutazioni del termine (9 8 7) sono:
  
  (7 8 9) (8 7 9) (9 7 8) (7 9 8) (8 9 7) (9 8 7)

Ognuna di queste permutazioni rappresenta un numero ordinabile.
Quindi possiamo aggiungerle tutte alla lista dei numeri ordinabili.
Bisogna stare attenti al caso in cui un termine contiene lo 0, per esempio prendiamo l'ultimo termine (2 1 0), le permutazioni sono:

  (2 1 0) (1 2 0) (0 2 1) (2 0 1) (1 0 2) (0 1 2)

In questo caso le permutazioni (0 2 1) e (0 1 2) non devono essere aggiunte perchè i valori 21 e 12 vengono aggiunti dal gruppo con N=2.

Vediamo due funzioni, una per calcolare il numero totale di numeri ordinabili e una per alcolare i valori di tutti i numeri ordinabili.

Funzione che calcola il numero totale dei numeri ordinabili:

(define (totale-numeri-ordinabili)
  (local (totale blocchi permutazioni)
    (setq totale 0)
    ; ciclo per i blocchi lunghi da 1 a 10
    (for (i 1 10)
      (setq blocchi (group-block '(0 1 2 3 4 5 6 7 8 9) i))
      ; ciclo per ogni blocco
      (dolist (bl blocchi)
          ; calcola la permutazioni del blocco corrente
          (setq permutazioni (perm bl))
          ; ciclo per ogni permutazione del blocco corrente
          (dolist (p permutazioni)
            ; se il numero iniziale della permutazione corrente
            ; è diverso da 0, allora aumenta il totale dei numeri ordinabili
            (if (!= (p 0) 0) (++ totale))
          )
      )
    )
    ; aggiunge il numero 0 come termine
    (+ totale 1)))

Proviamo:

(time (println (totale-numeri-ordinabili)))
;-> 4091131L
;-> 4765.965

Funzione che calcola la lista di tutti i numeri ordinabili:

(define (lista-numeri-ordinabili)
  (local (totale blocchi permutazioni)
    (setq totale '())
    ; ciclo per i blocchi lunghi da 1 a 10
    (for (i 1 10)
      (setq blocchi (group-block '(0 1 2 3 4 5 6 7 8 9) i))
      ; ciclo per ogni blocco
      (dolist (bl blocchi)
          ; calcola la permutazioni del blocco corrente
          (setq permutazioni (perm bl))
          ; elimina le permutazioni che iniziano con 0
          (setq permutazioni (filter (fn(x) (!= (x 0) 0)) permutazioni))
          ; aggiunge le permutazioni correnti alla soluzione
          (extend totale permutazioni)
      )
    )
    ; ordina in base al numero che rappresentano le liste
    (sort totale)    
    ; aggiunge il numero 0 come termine
    (push '(0) totale)))

Proviamo:

(time (println (length (setq ord (lista-numeri-ordinabili)))))
;-> 4091131
;-> 19705.801

(ord -1)
;-> (9 8 7 6 5 4 3 2 1 0)
(ord 4091130)
;-> (9 8 7 6 5 4 3 2 1 0)

(ord 0)
;-> (0)


-------------------
Moltiplicazione zip
-------------------

Definiamo una nuova operazione aritmetica: la moltiplicazione zip.

Algoritmo
1) aggiungere eventuali zeri all'inizio del numero minore per far corrispondere le lunghezze dei numeri,
2) moltiplicare le cifre corrispondenti dei numeri,
3) aggiungere uno zero iniziale ad ogni moltiplicazione per ottenere numeri a 2 cifre,
4) concatenare i numeri a 2 cifre
5) eliminare gli eventuali 0 iniziali.

Vediamo un esempio con N = 3277 e M = 54871:

1) aggiungere gli zeri iniziali

  N = 03277
  M = 54871

2) moltiplicazione cifra x cifra

  N = 0  3  2  7  7
  M = 5  4  8  7  1
  * = 0 12 16 49  7

3) formattare le moltiplicazioni a 2 cifre con eventuale 0 iniziale

  00 12 16 49 07

4) concatenare le moltiplicazioni formattate

   0012164907

5) eliminare gli zeri iniziali

   12164907

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))


(define (sign x)
"Return the sign of a float number"
  (cond ((> x 0) 1)
        ((< x 0) -1)
        (true 0)))

(define (mulzip num1 num2)
  ; memorizza i segno dei numeri
  (setq segno1 (sign num1))
  (setq segno2 (sign num2))
  ; valore assoluto dei numeri
  (setq num1 (abs num1))
  (setq num2 (abs num2))
  ; lunghezza dei numeri
  (setq len1 (length num1))
  (setq len2 (length num2))
  ; conversione dei numeri in liste
  (setq lst1 (int-list num1))
  (setq lst2 (int-list num2))
  ; aggiunge gli eventuali zeri iniziali
  (cond ((> len1 len2)
          (setq lst2 (append (dup 0 (- len1 len2)) lst2)))
        ((< len1 len2)
          (setq lst1 (append (dup 0 (- len2 len1)) lst1)))
  )
  ; moltiplica le cifre
  (setq res (map * lst1 lst2))
  ; formatta le moltiplicazioni a 2 cifre
  (setq res (map (fn(x) (format "%02d" x)) res))
  ; concatena le moltiplicazioni a 2 cifre
  ; ed elimina gli zeri iniziali (convertendo a numero intero)
  (setq res (int (join res) 0 10))
  ; ripristina il valore corretto del segno del risultato
  (if (= segno1 segno2) res (- res))
)

Proviamo:

(mulzip 3277 54871)
;-> 12164907

(mulzip 1 -1)
;-> -1

(mulzip -10 10)
;-> -100

(mulzip -77 -77)
;-> 4949

(mulzip 22 222)
;-> 404


-----------------------------
Shuffle di una lista annidata
-----------------------------

Questo è un problema relativo alla redistribuzione casuale di caratteristiche in un gioco di ruolo.
Abbiamo una lista composta da liste di interi (es. ((2 5 3) (8 2) (1) (9 4 7))).
Bisogna mischiare gli interi e ridistribuirli nella lista mantenendo la stessa struttura della lista iniziale.
Nell'esempio una soluzione valida è: ((8 2 9) (1 4) (2) (7 3 5))).

(define (list-break lst lst-len)
"Breaks a list into sub-lists of specified lengths"
  (let ((i 0) (q 0) (out '()))
    (dolist (el lst-len)
      (setq i (+ i q))
      (setq q el)
      (push (slice lst i q) out -1)
    )
    out))

(define (shuffle lst)
  (let (nums (randomize (flat lst)))
    (list-break nums (map length lst))))

Proviamo:

(shuffle '((2 5 3) (8 2) (1) (9 4 7)))
;-> ((2 1 8) (4 9) (2) (3 7 5))

(shuffle '((1) () (2 3)))
;-> ((3) () (1 2))

(shuffle '((1 2 3) (4 5 6) (7 8) (9)))
;-> ((2 8 7) (3 6 5) (4 1) (9))


---------------------------------------------------
Il metodo middle-square per generare numeri casuali
---------------------------------------------------

Il metodo del quadrato centrale è un metodo per generare numeri pseudocasuali.
In pratica è un metodo altamente imperfetto per molti scopi pratici, poiché il suo periodo è solitamente molto breve e presenta alcuni gravi punti deboli: ripetuto abbastanza volte, il metodo del quadrato centrale inizierà ripetutamente a generare lo stesso numero o passerà a un numero precedente nella sequenza e si ripeterà indefinitamente.

Il metodo fu presentato da John von Neumann nel 1949 che disse scherzando:
"Anyone who considers arithmetical methods of producing random digits is, of course, in a state of sin"
"Chiunque consideri metodi aritmetici per produrre cifre casuali è, ovviamente, in uno stato di peccato"
John von Neumann, "Various techniques used in connection with random digits".

Per generare una sequenza di numeri pseudocasuali di N cifre, un valore iniziale di N cifre viene creato ed elevato al quadrato, producendo un numero di 2N cifre.
Se il risultato ha meno di 2N cifre, vengono aggiunti degli zeri iniziali per compensare.
Le N cifre centrali del risultato sarebbero il numero successivo nella sequenza e restituite come risultato.
Questo processo viene quindi ripetuto per generare più numeri.
I numeri generati non possono essere più di 8^N (periodo).

Il valore di N deve essere pari affinché il metodo funzioni: se il valore di N è dispari, non ci sarà necessariamente "N cifre centrali" da selezionare definite in modo univoco.

Vediamo un esempio di applicazione del metodo con N=6:

    seed = 456749
  seed^2 = 208619649001
  number = ...619649...
    seed = 619649
  seed^2 = 383964883201
  number = ...964883...
    seed = 964883
  eccetera

(define (pseudo seme out)
  (setq totale 0)
  (setq len (length seme))
  (setq stop nil)
  (setq generati (list seme))
  (until stop
    (setq seme2 (* seme seme))
    ;(println seme2)
    (setq fmt (string "%0" (* 2 len) "s"))
    ;(println fmt)
    (setq s (format fmt (string seme2)))
    ;(println s)
    (setq numero (int (slice s (/ len 2) len) 0 10))
    ;(print numero) (read-line)
    (setq seme numero)
    (if (find numero generati) (setq stop true))
    (push numero generati -1)
    (++ totale)
  )
  (println totale)
  (println (ref-all (generati -1) generati))
  (if out generati))

Proviamo:

(pseudo 456749)
;-> 394
;-> ((184) (394))

(pseudo 192837)
;-> 284
;-> ((283) (284))

(pseudo 675248)
;-> 211
;-> ((210) (211))

(pseudo 42 true)
;-> 15
;-> ((14) (15))
;-> (42 76 77 92 46 11 12 14 19 36 29 84 5 2 0 0)


---------------------------------------
Programma autoriavviante dopo N secondi
---------------------------------------

Scrivere una funzione/programma che si riavvia dopo N secondi.

(define (ora-esatta pausa)
  ; creazione della funzione ausiliaria 'run' 
  ; che chiama la funzione 'ora-esatta' 
  ; dopo un dato numero di millisecondi
  ;(eval-string "(define (run delay) (sleep delay) (ora-esatta delay))")
  (define (run delay) (sleep delay) (ora-esatta delay))
  (println (date))
  ; esecuzione della funzione ausiliria 'run'
  (run pausa))

Proviamo:

(ora-esatta 3000)
;-> Tue Feb 27 13:57:23 2024
;-> Tue Feb 27 13:57:26 2024
;-> Tue Feb 27 13:57:29 2024
;-> Tue Feb 27 13:57:32 2024
;-> ...


============================================================================

