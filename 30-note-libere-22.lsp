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
  104, 105, 106, 107, 108, 109, 120, ...

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
    (print "  " (join (map string (sequence 0 (- col 1))) " "))
    (println "     " (join (map string (sequence 0 (- col 1))) " "))
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

Vedi anche "Generatore di numeri casuali" su "Note libere 1".
Vedi anche "Generatore casuale di Neumann" su "Note libere 26".
Vedi anche "Generatore casuale di Engel" su "Note libere 26".
Vedi anche "Generatore casuale LCG (Linear Congruential Generator)" su "Note libere 26".

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


--------------------------------
Posizioni valide del tic-tac-toe
--------------------------------

Data una posizione del tic-tac-toe, determinare se è valida o meno.
Il giocatore X muove per primo.
Per esempio:

Posizione valida:
  X O X
  O X O
  X O X

Posizione non valida (X e O non possono fare tris entrambi):
  X X X
  X X O
  O O O

Posizione non valida (deve risultare X = O oppure X = O + 1):
  X X O
  X . X
  . . O

La posizione viene data con una matrice/lista di valori:

  |a00 a01 a02|
  |a10 a11 a12|
  |a20 a21 a22|

I valori possono essere "X" o "O" o "." (casella vuota).

(define (print-tris board)
  (for (r 0 2) (for (c 0 2) (print " " (board r c))) (println)) '>)

(print-tris '(("X" "O" "X") ("X" "O" ".") ("." "O" ".")))
;-> X O X
;-> X O .
;-> . O .

(define (ttt? pos)
  (setq valida true)
  ; test per numero di X e O
  (setq num-x (first (count '("X") (flat pos))))
  (setq num-o (first (count '("O") (flat pos))))
  ;(println num-x { } num-o)
  (if (and (!= num-x num-o) (!= num-x (+ num-o 1)))
      (setq valida nil))
  ; test per vittorie multiple
  ; creazione stringa per la posizione
  (setq p "")
  (extend p (join (pos 0)) "-" (join (pos 1)) "-" (join (pos 2)))
  ; creazione stringa per la posizione trasposta
  (setq tpos (transpose pos))
  (setq t "")
  (extend t (join (tpos 0)) "-" (join (tpos 1)) "-" (join (tpos 2)))
  ;(println p)
  ;(print-tris pos)
  ;(println t)
  ;(print-tris tpos)
  ; ricerca delle configurazioni vincenti
  (if (and (or (find "XXX" p) (find "XXX" t))
           (or (find "OOO" p) (find "OOO" t)))
      (setq valida nil))
  (print-tris pos)
  valida)

Proviamo:

(ttt? '(("X" "O" "X") ("X" "O" ".") ("." "O" ".")))
;->  X O X
;->  X O .
;->  . O .
;-> true
(ttt? '(("X" "X" "X") ("X" "X" "X") ("X" "X" "X")))
;->  X X X
;->  X X X
;->  X X X
;-> nil
(ttt? '(("X" "O" "X") ("X" "O" "X") ("X" "O" "O")))
;->  X O X
;->  X O X
;->  X O O
;-> nil
(ttt? '(("O" "X" "O") ("X" "O" "O") ("O" "X" "X")))
;->  O X O
;->  X O O
;->  O X X
;-> nil
(ttt? '(("O" "X" ".") ("X" "O" "X") ("." "X" "O")))
;->  O X .
;->  X O X
;->  . X O
;-> true
(ttt? '(("O" "X" ".") ("X" "O" "X") ("." "." ".")))
;->  O X .
;->  X O X
;->  . . .
;-> true

Vedi anche "Tic-Tac-Toe" su "Note libere 3".
Vedi anche "Numero di partite nel Tic-Tac-Toe" su "Note libere 5".


-------------------------------------
Funzione da interi e interi gaussiani
-------------------------------------

Definiamo una funzione suriettiva che va dal dominio dagli interi positivi al codominio agli interi gaussiani.
Gli interi gaussiani sono numeri complessi in cui la parte reale e quella immaginaria sono numeri interi.
Una funzione f: X->Y è suriettiva se per ogni y in Y, esiste x in X tale che f(x) = y.
In altre parole, una funzione è suriettiva se ogni elemento del codominio Y è mappato da almeno un elemento del dominio X.
La funzione suriettiva prende un numero intero positivo e procede come segue:
   Numero = 2490
1) Esprimere il numero in binario
   100110111010
2) Eliminare gli eventuali 0 iniziali e finali
   10011011101
3) Sostituire qualsiasi sequenza di uno o più '0' con un singolo '+'
   1+11+111+1
4) Sostituire tutti gli 1 con i:
   i+ii+iii+i
5) Valutare l'espressione complessa risultante (che è un intero gaussiano)
   i+ii+iii+i = i+i*i+i*i*i+i = 2i+i^2+i^3 = 2i+(-1)+(-i) = -1+i

Algoritmo:
1) Calcolare il Run-length-encode del numero binario
2) Ciclo per ogni elemento di rle:
   2a) calcolare il valore:
       se valore reale metterlo nella lista dei reali
       se immaginario metterlo nella lista degli immaginari
3) Sommare la lista dei reali e sommare la lista degli immaginari

Come viene calcolato il valore di un elemento di rle?
Un elemento di rle ha la seguente struttura:
  (ripetizioni valore)
  dove ripetizioni è un numero intero,
       valore vale "0" o "1".

Vediamo un esempio:
  rle-encode "100110111010" =
  (1 "1") (2 "0") (2 "1") (1 "0") (3 "1") (1 "0") (1 "1") (1 "0")

Calcolo del valore di ogni elemento:
  (1 "1") --> +i
  (2 "0") --> 0
  (2 "1") --> i*i = -1
  (1 "0") --> 0
  (3 "1") --> i*i*i = -i
  (1 "0") --> 0
  (1 "1") --> +i
  (1 "0") --> 0

  lista dei reali = -1
  lista degli immaginari = +i -i + i = +i

Nota:
  i^k = +1, se k è pari e (k % 4) = 0
  i^k = -1, se k è pari e (k % 4) != 0
  i^k = -i, se k è dispari e ((k+1) % 4) = 0
  i^k = +i, se k è dispari e ((k+1) % 4) != 0

(define (rle-encode lst)
"Encode list with Run Length Encoding"
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
    out))

(rle-encode (explode "10110111010"))
;-> ((1 "1") (1 "0") (2 "1") (1 "0") (3 "1") (1 "0") (1 "1") (1 "0"))

Funzione suriettiva da interi a interi gaussiani:

(define (surie num)
  (local (real im binary rle)
    (setq real '())
    (setq im '())
    (setq binary (trim (bits num) "0"))
    (setq rle (rle-encode (explode binary)))
    ;(println rle)
    (dolist (el rle)
      (if (= (el 1) "1")
          (cond ((= (el 0) 1) (push 1 im))
                ((even? (el 0))
                  (if (zero? (% (el 0) 4))
                      ; i^k = +1, se k è pari e (k % 4) = 0
                      (push +1 real)
                      ; i^k = -1, se k è pari e (k % 4) != 0
                      (push -1 real)))
                ((odd? (el 0))
                  (if (zero? (% (+ (el 0) 1) 4))
                      ; i^k = -i, se k è dispari e ((k+1) % 4) = 0
                      (push -1 im)
                      ; i^k = +i, se k è dispari e ((k+1) % 4) != 0
                      (push 1 im)))
          )
      )
    )
    ;(println real { } im)
    (list (apply + real) (apply + im))))

Proviamo:

(surie 2490)
;-> (-1 1)

(surie 123456)
;-> (1 2)

(surie 654321)
;-> (-2 2)

(surie 1)
;-> (0 1)

(surie 375775)
;-> (0 1)

(surie 10101010)
;-> (-1 6)

(surie 170)
;-> (0 4)


----------------
Numeri Xenodromi
----------------

Uno xenodromo in base n è un numero intero in cui tutte le sue cifre in base n sono diverse.
Data una base di 2 <= n <= 10, generare gli xenodromi per quella base in base n e in base 10 fino ad un dato limite.

(define (b1-b2 num base1 base2)
"Convert an integer from base1 to base2 (2 <= base <= 10)"
  (if (zero? num) num
      (+ (% num base2) (* base1 (b1-b2 (/ num base2) base1 base2)))))

(b1-b2 123 10 4)

(define (xeno? num base)
  (local (num-base lst uniq)
    (setq num-base (b1-b2 num 10 base))
    (setq lst (explode (string num-base)))
    (setq uniq (unique lst))
    ;(println num-base { } lst { } uniq)
    (= lst uniq)))

Proviamo:

(xeno? 123 10)
;-> true

(xeno? 123 2)
;-> nil

(xeno? 123 4)
;-> nil

Funzione che calcola tutti i numeri xenodromi in una data base fino ad un dato limite:

(define (xenodrome base limite)
  (local (bn b10 num-base)
    (setq bn '())
    (setq b10 '())
    (for (num 1 limite)
      (setq num-base (b1-b2 num 10 base))
      (if (xeno? num base) (begin
          (push num-base bn -1)
          (push num b10 -1))
      )
    )
    (list b10 bn)))

Proviamo:

(xenodrome 2 100)
;-> ((1 2) (1 10))
Ultimo numero base 2: 10
Ultimo numero base 10: (b1-b2 10 2 10) --> 2

(xenodrome 3 100)
;-> ((1 2 3 5 6 7 11 15 19 21) (1 2 10 12 20 21 102 120 201 210))
Ultimo numero base 3: 210
Ultimo numero base 10: (b1-b2 210 3 10) --> 21

(xenodrome 4 100)
;-> ((1 2 3 4 6 7 8 9 11 12 13 14 18 19 24 27 28 30 33 35 36 39 44 45
;->   49 50 52 54 56 57 75 78 99)
;->  (1 2 3 10 12 13 20 21 23 30 31 32 102 103 120 123 130 132 201 203
;->   210 213 230 231 301 302 310 312 320 321 1023 1032 1203))
Ultimo numero base 4: 3210
Ultimo numero base 10: (b1-b2 3210 4 10) --> 228

(xenodrome 5 100)
;-> ((1 2 3 4 5 7 8 9 10 11 13 14 15 16 17 19 20 21 22 23 27 28 29 35
;->   38 39 40 42 44 45 47 48 51 53 54 55 58 59 65 66 69 70 71 73 76 77
;->   79 80 82 84 85 86 89 95 96 97)
;->  (1 2 3 4 10 12 13 14 20 21 23 24 30 31 32 34 40 41 42 43 102 103
;->   104 120 123 124 130 132 134 140 142 143 201 203 204 210 213 214
;->   230 231 234 240 241 243 301 302 304 310 312 314 320 321 324 340
;->   341 342))
Ultimo numero base 5: 43210
Ultimo numero base 10: (b1-b2 43210 5 10) --> 2930

(xenodrome 6 100)
;-> ((1 2 3 4 5 6 8 9 10 11 12 13 15 16 17 18 19 20 22 23 24 25 26 27
;->   29 30 31 32 33 34 38 39 40 41 48 51 52 53 54 56 58 59 60 62 63 65
;->   66 68 69 70 73 75 76 77 78 81 82 83 90 91 94 95 96 97 99)
;->  (1 2 3 4 5 10 12 13 14 15 20 21 23 24 25 30 31 32 34 35 40 41 42
;->   43 45 50 51 52 53 54 102 103 104 105 120 123 124 125 130 132 134
;->   135 140 142 143 145 150 152 153 154 201 203 204 205 210 213 214
;->   215 230 231 234 235 240 241 243))
Ultimo numero base 6: 543210
Ultimo numero base 10: (b1-b2 543210 6 10) --> 44790

(xenodrome 7 100)
;-> ((1 2 3 4 5 6 7 9 10 11 12 13 14 15 17 18 19 20 21 22 23 25 26 27
;->   28 29 30 31 33 34 35 36 37 38 39 41 42 43 44 45 46 47 51 52 53 54
;->   55 63 66 67 68 69 70 72 74 75 76 77 79 80 82 83 84 86 87 88 90 91
;->   93 94 95 96 99)
;->  (1 2 3 4 5 6 10 12 13 14 15 16 20 21 23 24 25 26 30 31 32 34 35 36
;->   40 41 42 43 45 46 50 51 52 53 54 56 60 61 62 63 64 65 102 103 104
;->   105 106 120 123 124 125 126 130 132 134 135 136 140 142 143 145
;->   146 150 152 153 154 156 160 162 163 164 165 201))
Ultimo numero base 7: 6543210
Ultimo numero base 10: (b1-b2 6543210 7 10) --> 800667

(xenodrome 8 100)
;-> ((1 2 3 4 5 6 7 8 10 11 12 13 14 15 16 17 19 20 21 22 23 24 25 26
;->   28 29 30 31 32 33 34 35 37 38 39 40 41 42 43 44 46 47 48 49 50 51
;->   52 53 55 56 57 58 59 60 61 62 66 67 68 69 70 71 80 83 84 85 86 87
;->   88 90 92 93 94 95 96 98 99)
;->  (1 2 3 4 5 6 7 10 12 13 14 15 16 17 20 21 23 24 25 26 27 30 31 32
;->   34 35 36 37 40 41 42 43 45 46 47 50 51 52 53 54 56 57 60 61 62 63
;->   64 65 67 70 71 72 73 74 75 76 102 103 104 105 106 107 120 123 124
;->   125 126 127 130 132 134 135 136 137 140 142 143))
Ultimo numero base 8: 76543210
Ultimo numero base 10: (b1-b2 76543210 9 10) --> 36993276

(xenodrome 9 100)
;-> ((1 2 3 4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 21 22 23 24 25 26 27
;->   28 29 31 32 33 34 35 36 37 38 39 41 42 43 44 45 46 47 48 49 51 52
;->   53 54 55 56 57 58 59 61 62 63 64 65 66 67 68 69 71 72 73 74 75 76
;->   77 78 79 83 84 85 86 87 88 89 99)
;->  (1 2 3 4 5 6 7 8 10 12 13 14 15 16 17 18 20 21 23 24 25 26 27 28
;->   30 31 32 34 35 36 37 38 40 41 42 43 45 46 47 48 50 51 52 53 54 56
;->   57 58 60 61 62 63 64 65 67 68 70 71 72 73 74 75 76 78 80 81 82 83
;->   84 85 86 87 102 103 104 105 106 107 108 120))
Ultimo numero base 9: 876543210
Ultimo numero base 10: (b1-b2 876543210 9 10) --> 381367044

(xenodrome 10 100)
;-> ((1 2 3 4 5 6 7 8 9 10 12 13 14 15 16 17 18 19 20 21 23 24 25 26 27
;->   28 29 30 31 32 34 35 36 37 38 39 40 41 42 43 45 46 47 48 49 50 51
;->   52 53 54 56 57 58 59 60 61 62 63 64 65 67 68 69 70 71 72 73 74 75
;->   76 78 79 80 81 82 83 84 85 86 87 89 90 91 92 93 94 95 96 97 98)
;->  (1 2 3 4 5 6 7 8 9 10 12 13 14 15 16 17 18 19 20 21 23 24 25 26 27
;->   28 29 30 31 32 34 35 36 37 38 39 40 41 42 43 45 46 47 48 49 50 51
;->   52 53 54 56 57 58 59 60 61 62 63 64 65 67 68 69 70 71 72 73 74 75
;->   76 78 79 80 81 82 83 84 85 86 87 89 90 91 92 93 94 95 96 97 98))
Ultimo numero base 10: 9876543210


-------------------------
Sequenza di Rudin-Shapiro
-------------------------

La sequenza di Rudin-Shapiro è una sequenza di 1 e −1 definita come segue:

  rs(n)=(−1)^g(n)

dove g(n) è il numero di occorrenze di (eventualmente sovrapposte) 11 nella rappresentazione binaria di n.

Sequenza OEIS A020985
The Rudin-Shapiro or Golay-Rudin-Shapiro sequence
  1, 1, 1, -1, 1, 1, -1, 1, 1, 1, 1, -1, -1, -1, 1, -1, 1, 1, 1, -1, 1, 1,
  -1, 1, -1, -1, -1, 1, 1, 1, -1, 1, 1, 1, 1, -1, 1, 1, -1, 1, 1, 1, 1, -1,
  -1, -1, 1, -1, -1, -1, -1, 1, -1, -1, 1, -1, 1, 1, 1, -1, -1, -1, 1, -1,
  1, 1, 1, -1, 1, 1, -1, 1, 1, 1, 1, -1, -1, -1, 1, -1, 1, ...

Formula di Brillhart and Carlitz:

  a(0) = a(1) = 1,
  a(2n) = a(n),
  a(2n+1) = a(n) * (-1)^n.

Per esprimere a(n) in funzione di un indice precedente, possiamo utilizzare la proprietà della ricorrenza:

  a(2n+1) = a(n)

Possiamo notare che questa ricorrenza dimezza l'indice in termini di n, quindi potremmo riscrivere la ricorrenza come:

 a(n) = a(n/2)

Se l'indice n è pari, allora abbiamo n = 2m, quindi:

  a(m) = a(2m/2) = a(m) --> a(n/2)

Quindi, se n è pari, a(n) = a(n/2).

Se invece n è dispari, n = 2m+1, quindi:

  a(m) = a((2m+1)/2) = a(m) --> a((n-1)/2)

Quindi, se n è dispari, a(n) = a((n-1)/2)

Quindi possiamo riscrivere la formula ricorsiva come segue:

  a(0) = 1
  a(1) = 1
  a(n) = a(n/2), per n pari
  a(n) = a((n-1)/2) * (-1)^((n-1)/2), per n dispari

Questa formula permette di esprimere a(n) in funzione di a con un indice precedente a n (a seconda che n sia pari o dispari).

Metodo 1 (definizione)
----------------------

(define (regex-all regexp str all)
  (local (out idx res)
    (setq out '())
    (setq idx 0)
    (setq res (regex regexp str 64 idx))
    (while res
      (push res out -1)
      (if all
          (setq idx (+ (res 1) 1)) ; contiguos pattern
          ;else
          (setq idx (+ (res 1) (res 2))) ; no contiguos pattern
      )
      (setq res (regex regexp str 64 idx))
    )
    out))

(regex-all "[1]{2}" "11011101" true)
;-> (("11" 0 2) ("11" 3 2) ("11" 4 2))

Vedi "regex-all (trova tutte le occorrenze)" su "Note libere 19".

(define (rs1 num)
  (if (even? (length (regex-all "[1]{2}" (bits num) true))) 1 -1))

Proviamo:

(rs1 123)
;-> 1

(map rs1 (sequence 0 50))
;-> (1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1
;->  -1 1 -1 -1 -1 1 1 1 -1 1 1 1 1 -1 1 1 -1 1 1 1 1 -1
;->  -1 -1 1 -1 -1 -1 -1)

Metodo 2 (formula)
------------------

(define (rs2 num)
  (cond ((= num 0) 1)
        ((= num 1) 1)
        ((even? num) (rs2 (/ num 2)))
        ((odd? num) (* (pow -1 (/ (- num 1) 2)) (rs2 (/ (- num 1) 2))))))

Proviamo:

(rs2 123)
;-> 1

(map rs2 (sequence 0 50))
;-> (1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1
;->  -1 1 -1 -1 -1 1 1 1 -1 1 1 1 1 -1 1 1 -1 1 1 1 1 -1
;->  -1 -1 1 -1 -1 -1 -1)

Metodo 3 
--------

(define (rs3 num)
  (pow -1 (first (count '("1") (explode (bits (& num (* num 2))))))))

Proviamo:

(rs3 123)
;-> 1

(map rs3 (sequence 0 50))
;-> (1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1
;->  -1 1 -1 -1 -1 1 1 1 -1 1 1 1 1 -1 1 1 -1 1 1 1 1 -1
;->  -1 -1 1 -1 -1 -1 -1)

Vediamo se le tre funzioni producono risultati uguali:

(= (map rs1 (sequence 0 1000)) 
   (map rs2 (sequence 0 1000))
   (map rs3 (sequence 0 1000)))
;-> true


---------------------
Calendario a due cubi
---------------------

Un calendario a due cubi utilizza due cubi con cifre sulle facce per visualizzare la data.
Per le date comprese nell'intervallo 1-9, viene utilizzato uno zero iniziale ("01", "02", ..., "09").

A prima vista sembra che questi calendari siano impossibili da realizzare.
I cubi hanno in totale 12 facce, poichè in entrambi i cubi devono apparire i numeri "0", "1" e "2" (es. per i numeri "01" "10", "02", "20", "11", "22")), questo significa che per gli altri sette numeri (3, 4, 5, 6, 7, 8, 9) rimangono solo sei facce.
Per risolvere il problema si utilizza un trucco in cui la faccia con un "6" può essere ruotata sottosopra per rappresentare un "9".
Ad esempio, un cubo può avere le facce "012345" e l'altro "012678" dove il "6" può anche essere un "9".
In questo modo abbiamo la seguente situazione:

  cubo1 = 0, 1, 2, x1, y1, z1 
  cubo2 = 0, 1, 2, x2, y2, z2

e dobbiamo inserire i numeri 3, 4, 5, 6/9, 7, 8 nella sei facce restanti (x1,y1,z1 e x2,y2,z2).
Qualunque combinazione dei sei numeri nelle sei facce soddisfa il requisito di poter mostrare tutti i numeri del mese da "01" a "31".

Verifichiamolo con un programma.

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
  (let ((i 0) (q 0) (out '()))
    (dolist (el lst-len)
      (setq i (+ i q))
      (setq q el)
      (push (slice lst i q) out -1)
    )
    out))

(define (groups parts lst)
"Groups the elements of a list into disjoint sublists"
  (local (tmp out)
    ;------------------------
    (define (loop parts xss lst)
      (cond ((null? parts) xss)
            ((null? xss) '())
            (true
            (letn ((xs (first xss)) (leftover (filter (lambda (e) (not (member e xs))) lst)))
              ;(append (map (lambda (ys) (list xs ys)))
              (append (map (lambda (ys) (flat (list xs ys)))
                            (loop (rest parts) (comb (first parts) leftover) leftover))
                      (loop parts (rest xss) lst))))))
    ;------------------------
    (setq tmp (loop (rest parts) (comb (first parts) lst) lst))
    (setq out '())
    (dolist (g tmp)
      (push (list-break g parts) out -1)
    )
    out))

(groups '(3 3) '(3 4 5 6 7 8))
;-> (((3 4 5) (6 7 8)) ((3 4 6) (5 7 8)) ((3 4 7) (5 6 8)) ((3 4 8) (5 6 7))
;->  ((3 5 6) (4 7 8)) ((3 5 7) (4 6 8)) ((3 5 8) (4 6 7)) ((3 6 7) (4 5 8))
;->  ((3 6 8) (4 5 7)) ((3 7 8) (4 5 6)) ((4 5 6) (3 7 8)) ((4 5 7) (3 6 8))
;->  ((4 5 8) (3 6 7)) ((4 6 7) (3 5 8)) ((4 6 8) (3 5 7)) ((4 7 8) (3 5 6))
;->  ((5 6 7) (3 4 8)) ((5 6 8) (3 4 7)) ((5 7 8) (3 4 6)) ((6 7 8) (3 4 5)))

(define (cubi)
  (local (lst cubo1 cubo2 day cifra1 cifra2)
    ; crea tutti i raggruppamenti possibili della divisione in due gruppi
    ; della lista di cifre (3 4 5 6 7 8)
    (setq lst (groups '(3 3) '(3 4 5 6 7 8)))
    ; elimina i raggruppamenti simmetrici
    ; (es. ((3 4 5) (6 7 8)) = ((6 7 8) (3 4 5)))
    (setq lst  (unique (map sort lst)))
    ; ciclo per ogni raggruppamento
    (dolist (el lst)
      ; facce del cubo 1
      (setq cubo1 (append '(0 1 2) (el 0)))
      ; facce del cubo 1
      (setq cubo2 (append '(0 1 2) (el 1)))
      (setq ok true)
      (for (i 1 31)
        ; giorno del calendario
        (setq day (format "%02d" i))
        ; cifra1 del giorno
        (setq cifra1 (int (day 0) 0 10))
        ; cambia 9 in 6 per cifra 1
        (if (= cifra1 9) (setq cifra1 6))
        ; cifra1 del giorno
        (setq cifra2 (int (day 1) 0 10))
        ; cambia 9 in 6 per cifra 1
        (if (= cifra2 9) (setq cifra2 6))
        ; controllo possibilità dei cubi di formare il giorno corrente
        (if (not (or (and (find cifra1 cubo1) (find cifra2 cubo2))
                     (and (find cifra1 cubo2) (find cifra2 cubo1))))
            (setq ok nil)
        )
      )
      (if ok (println cubo1 { } cubo2))
    )))

Proviamo:

(cubi)
;-> (0 1 2 3 4 5) (0 1 2 6 7 8)
;-> (0 1 2 3 4 6) (0 1 2 5 7 8)
;-> (0 1 2 3 4 7) (0 1 2 5 6 8)
;-> (0 1 2 3 4 8) (0 1 2 5 6 7)
;-> (0 1 2 3 5 6) (0 1 2 4 7 8)
;-> (0 1 2 3 5 7) (0 1 2 4 6 8)
;-> (0 1 2 3 5 8) (0 1 2 4 6 7)
;-> (0 1 2 3 6 7) (0 1 2 4 5 8)
;-> (0 1 2 3 6 8) (0 1 2 4 5 7)
;-> (0 1 2 3 7 8) (0 1 2 4 5 6)


-------------------------
Stringhe opposte (mirror)
-------------------------

Abbiamo una stringa di caratteri ASCII stampabili.
Restituire la stringa opposta (mirror) con le seguenti regole

Carattere  Opposto     Carattere  Opposto     Carattere  Opposto
    A        Z             a        z             0        9
    B        Y             b        y             1        8
    C        X             c        x             2        7
    D        W             d        w             3        6
    E        V             e        v             4        5
    F        U             f        u             5        4
    G        T             g        t             6        3
    H        S             h        s             7        2
    I        R             i        r             8        1
    J        Q             j        q             9        0
    K        P             k        p
    L        O             l        o
    M        N             m        n
    N        M             n        m
    O        L             o        l
    P        K             p        k
    Q        J             q        j
    R        I             r        i
    S        H             s        h
    T        G             t        g
    U        F             u        f
    V        E             v        e
    W        D             w        d
    X        C             x        c
    Y        B             y        b
    Z        A             z        a

Tutti gli altri caratteri rimangono gli stessi.

(setq upper "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
(setq lower "abcdefghijklmnopqrstuvwxyz")
(setq digit "0123456789")
(for (i 0 25) (println (upper i) { } (upper (- (+ i 1)))))
(for (i 0 25) (println (lower i) { } (lower (- (+ i 1)))))
(for (i 0 9) (println (digit i) { } (digit (- (+ i 1)))))
  
(map char '("a" "z" "A" "Z" "0" "9"))
;-> (97 122 65 90 48 57)

Per accoppiare i caratteri possiamo usare le seguenti formule:

Per le minuscole:
  new-char = char(219 - char(old-char))

Per le maiuscole:
  new-char = char(155 - char(old-char))

Per le cifre:
  new-digit = char(57 - (char(old-digit) - 48))

Funzione che restituisce la stringa opposta (mirror) di una stringa:

(define (mirror str)
  (let (out "")
    (dostring (ch str)
      (cond ((and (>= ch 97) (<= ch 122)) ; minuscole
              (extend out (char (- 219 ch))))
            ((and (>= ch 65) (<= ch 90))  ; maiuscole
              (extend out (char (- 155 ch))))
            ((and (>= ch 48) (<= ch 57))  ; cifre
              (extend out (char (- 57 (- ch 48)))))
            (true   ; tutti gli altri caratteri
              (extend out (char ch)))
      )
    )
    out))

Proviamo:

(mirror upper)
;-> "ZYXWVUTSRQPONMLKJIHGFEDCBA"

(mirror lower)
;-> "zyxwvutsrqponmlkjihgfedcba"

(mirror digit)
;-> "9876543210"

(mirror "Hello world from newLISP!!!")
;-> "Svool dliow uiln mvdORHK!!!"


---------------------------
Numeri indicibili di Cantor
---------------------------

Un numero indicibile è un numero divisibile per sette o che ha sette come cifra:

  1 2 3 4 5 6 ( ) 8 9 10 11 12 13 ( ) 15 16 ( ) 18 ...

La versione di Cantor è la sequenza definita riempiendo la sequenza "1 2 3 4 5 6 ( ) 8..." negli spazi vuoti ( ) con la sequenza progressiva 1, 2, 3, 4, 5, 6, ( ), 8, 9, 10, 11, 12, 13, ( ), 15,... in modo ricorsivo:

  1 2 3 4 5 6 (1) 8 9 10 11 12 13 (2) 15 16 (3) 18 19 20 (4) 22 23 24 25 26 (5) (6) 29 30 31 32 33 34 ( ) 36 (8) 38 ...
  
  1 2 3 4 5 6 (1) 8 9 10 11 12 13 (2) 15 16 (3) 18 19 20 (4) 22 23 24 25 26 (5) (6) 29 30 31 32 33 34 (1) 36 (8) 38 ...
  ...

Sequenza OEIS A328018:
If n is the k-th number divisible by 7 or containing a digit 7 (in base 10) then a(n) = a(k) otherwise a(n) = n
  1, 2, 3, 4, 5, 6, 1, 8, 9, 10, 11, 12, 13, 2, 15, 16, 3, 18, 19, 20, 4,
  22, 23, 24, 25, 26, 5, 6, 29, 30, 31, 32, 33, 34, 1, 36, 8, 38, 39, 40,
  41, 9, 43, 44, 45, 46, 10, 48, 11, 50, 51, 52, 53, 54, 55, 12, 13, 58, 
  59, 60, 61, 62, 2, 64, 65, 66, 15, 68, 69, 16, 3, ...

(setq oeis '(1 2 3 4 5 6 1 8 9 10 11 12 13 2 15 16 3 18 19 20 4
             22 23 24 25 26 5 6 29 30 31 32 33 34 1 36 8 38 39 40
             41 9 43 44 45 46 10 48 11 50 51 52 53 54 55 12 13 58 
             59 60 61 62 2 64 65 66 15 68 69 16 3))
(length oeis)
;-> 71

Funzione che verifica se un numero è divisibile per 7 o contiene 7 come cifra:

(define (seven? num) (or (zero? (% num 7)) (find "7" (string num))))

(map seven? '(7 14 23456 7))
;-> (true true nil true)

Funzione che genera gli indicibili di Cantor fino ad un certo limite:

(define (cantor limite)
  (local (base vuoti val)
    ; primo passaggio per creare la lista di base
    (setq base (map (fn(x) (if (seven? x) '() x)) (sequence 1 limite)))
    ; ciclo finchè troviamo dei valori che sono liste vuote '()
    ; nella di base
    (while (setq vuoti (ref-all '() base))
      ; primo valore da inserire
      (setq val 1)
      ; ciclo per ogni () che si trova nella lista base
      (dolist (v vuoti)
        ; modifica la corrente () della lista base 
        ; con il valore corrente o con ()
        (if (seven? val)
            (setf (base v) '())
            (setf (base v) val)
        )
        (++ val)
      )
      ;(print base) (read-line)
    )
    base))

Proviamo:

(cantor 50)
;-> (1 2 3 4 5 6 1 8 9 10 11 12 13 2 15 16 3 18 19 20 4 22 23 24 25 26
;->  5 6 29 30 31 32 33 34 1 36 8 38 39 40 41 9 43 44 45 46 10 48 11 50)

(= (cantor 71) oeis)
;-> true


--------------------------
Password cracking progress
--------------------------

Una semplice animazione durante la ricerca di una password alfanumerica.

(define (crack pwd wait)
  (local (code idx cur-char)
    (setq wait (or wait 0))
    (setq code "")
    (setq idx 0)
    ; ciclo fino a che la parola casuale non è uguale alla password
    (until (= code pwd)
      ; genera carattere casuale
      (setq cur-char (char (+ 32 (rand 95))))
      (cond ((= cur-char (pwd idx)) 
            ; carattere casuale = carettere password
              (push cur-char code -1)
              (print code)
              (++ idx))
            (true
            ; carattere casuale != carettere password
             (print (string code cur-char)))
      )
      ; tempo tra due tentativi
      (sleep wait)
      ; ritorna a capo il cursore
      (print "\r")
    )
    ; password trovata
    (println code)
    'end))

Proviamo (nella REPL si vede l'animazione dei caratteri trovati e della progressione dei tentativi durante la ricerca):

(crack "abc" 50)
;-> abc
;-> end

(time (crack "abcdef" 20))
;-> abcdef
;-> 7908.661

(time (crack "abcdef"))
;-> abcdef
;-> 21.884

(time (crack "password 123456789" 10))
;-> 32205.83

(time (crack "password 123456789"))
;-> 41.882


----------------
La funzione RADD
----------------

La funzione RADD prende un intero N e lo somma a N invertito.
Per esempio:

  RADD(12) = 12 + 21 = 33
  RADD(301) = 301 + 103 = 404
  RADD(100) = 100 + 1 = 101

Dato un numero scrivere una funzione che calcola l'inverso di RADD, per esempio il numero 110 dovrebbe produrre il numero 100.

Sequenza OEIS A056964: a(n) = n + reversal of digits of n
  0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 11, 22, 33, 44, 55, 66, 77, 88, 99,
  110, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 33, 44, 55, 66, 77, 88,
  99, 110, 121, 132, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 55, 66,
  77, 88, 99, 110, 121, 132, 143, 154, 66, 77, 88, 99, 110, ...

(define (radd num) (+ num (int (reverse (string num)) 0 10)))

(radd 12)
;-> 33
(radd 301)
;-> 404
(radd 100)
;-> 101

(map radd (sequence 1 50))
;-> (2 4 6 8 10 12 14 16 18 11 22 33 44 55 66 77 88 99 110 22 33 44 55 66
;->  77 88 99 110 121 33 44 55 66 77 88 99 110 121 132 44 55 66 77 88 99
;->  110 121 132 143 55)

Non tutti i numeri possono essere generati dalla funzione RADD.

(define (genera-radd limite)
  (unique (sort (map radd (sequence 1 limite)))))

(genera-radd 1000)
;-> (2 4 6 8 10 11 12 14 16 18 22 33 44 55 66 77 88 99 101 110 121 132
;->  141 143 154 161 165 176 181 187 198 201 202 221 222 241 242 261 262
;->  281 282 302 303 322 323 342 343 362 363 382 383 403 404 423 424 443
;->  444 463 464 483 484 504 505 524 525 544 545 564 565 584 585 605 606
;->  625 626 645 646 665 666 685 686 706 707 726 727 746 747 766 767 786
;->  787 807 808 827 828 847 848 867 868 887 888 908 909 928 929 948 949
;->  968 969 988 989 1001 1009 1010 1029 1030 1049 1050 1069 1070 1089
;->  1090 1110 1111 1130 1131 1150 1151 1170 1171 1190 1191 1211 1212
;->  1231 1232 1251 1252 1271 1272 1291 1292 1312 1313 1332 1333 1352
;->  1353 1372 1373 1392 1393 1413 1414 1433 1434 1453 1454 1473 1474
;->  1493 1494 1514 1515 1534 1535 1554 1555 1574 1575 1594 1595 1615
;->  1616 1635 1636 1655 1656 1675 1676 1695 1696 1716 1717 1736 1737
;->  1756 1757 1776 1777 1796 1797 1817 1818 1837 1838 1857 1858 1877
;->  1878 1897 1898 1918 1938 1958 1978 1998)

(length (genera-radd 1000))
;-> 207
(length (genera-radd 10000))
;-> 548

Adesso consideriamo l'operazione inversa di RADD che chiamiamo DDAR.
In questo caso abbiamo un numero x che è il risultato della funzione RADD(y) e vogliamo trovare il valore di y.
Proviamo con un metodo brute-force che esamina tutte le possibilità.

(define (ddar num)
  (local (out)
    (setq out '())
    (for (k 1 num)
      (if (= (radd k) num)
          (push (list k (int (reverse (string k)) 0 10) num) out -1))
    )
    out))

Proviamo:

(ddar 33)
;-> ((12 21 33) (21 12 33) (30 3 33))

(ddar 404)
;-> ((103 301 404) (202 202 404) (301 103 404) (400 4 404))

(ddar 101)
;-> ((100 1 101))

Non tutti i numeri possono essere generati dalla funzione DDAR.

(define (genera-ddar limite)
  (setq lst (map ddar (sequence 1 limite)))
  (setq lst (clean null? lst))
  (setq lst (flat lst 1))
  (setq lst (unique (sort (map first lst)))))

(genera-ddar 1000)
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
;->  26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
;->  48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
;->  70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
;->  92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 110 111
;->  112 113 114 115 116 117 118 120 121 122 123 124 125 126 127 128 130
;->  131 132 133 134 135 136 137 138 140 141 142 143 144 145 146 147 148
;->  150 151 152 153 154 155 156 157 160 161 162 163 164 165 166 167 170
;->  171 172 173 174 175 176 177 180 181 182 183 184 185 186 187 190 191
;->  192 193 194 195 196 197 200 201 202 203 204 205 206 207 210 211 212
;->  213 214 215 216 217 220 221 222 223 224 225 226 227 230 231 232 233
;->  234 235 236 237 240 241 242 243 244 245 246 247 250 251 252 253 254
;->  255 256 260 261 262 263 264 265 266 270 271 272 273 274 275 276 280
;->  281 282 283 284 285 286 290 291 292 293 294 295 296 300 301 302 303
;->  304 305 306 310 311 312 313 314 315 316 320 321 322 323 324 325 326
;->  330 331 332 333 334 335 336 340 341 342 343 344 345 346 350 351 352
;->  353 354 355 360 361 362 363 364 365 370 371 372 373 374 375 380 381
;->  382 383 384 385 390 391 392 393 394 395 400 401 402 403 404 405 410
;->  411 412 413 414 415 420 421 422 423 424 425 430 431 432 433 434 435
;->  440 441 442 443 444 445 450 451 452 453 454 460 461 462 463 464 470
;->  471 472 473 474 480 481 482 483 484 490 491 492 493 494 500 501 502
;->  503 504 510 511 512 513 514 520 521 522 523 524 530 531 532 533 534
;->  540 541 542 543 544 550 551 552 553 560 561 562 563 570 571 572 573
;->  580 581 582 583 590 591 592 593 600 601 602 603 610 611 612 613 620
;->  621 622 623 630 631 632 633 640 641 642 643 650 651 652 660 661 662
;->  670 671 672 680 681 682 690 691 692 700 701 702 710 711 712 720 721
;->  722 730 731 732 740 741 742 750 751 760 761 770 771 780 781 790 791
;->  800 801 810 811 820 821 830 831 840 841 850 860 870 880 890 900 910
;->  920 930 940)

(length (genera-ddar 1000))
;-> 504

(time (println (length (genera-ddar 10000))))
;-> 5094
;-> 29808.011


--------------------------------
Lunghezza ricorsiva di una lista
--------------------------------

La dimensione ricorsiva di una lista è definita come segue:
- se la lista non contiene sottoliste, allora la lunghezza è data dal numero dei suoi elementi
- se la lista conitne sottoliste, allora la lunghezza è data dalla somma delle lunghezze ricorsive delle sue sottoliste

Per esempio:
  
  lista = (a b c), lunghezza ricorsiva = 3
  a --> 1
  b --> 2
  c --> 3

  lista = (a b (c (d e))), lunghezza ricorsiva = 7
  a --> 1
  b --> 2
  (c (d e)) --> 3
  c --> 4
  (d e) --> 5
  d --> 6
  e --> 7

Metodo 1 (ricorsivo)
--------------------

(define (rlength lst)
  (cond
    ; caso base: elemento = lista vuota
    ((= lst '()) 0)
    ; caso 1: elemento = atomo
    ((atom? (lst 0)) (+ 1 (list-length (rest lst))))
    ; caso 2:
    ; elemento = lista
    ((list? (lst 0)) (+ 1 (list-length (lst 0)) (list-length (rest lst))))))

Proviamo:

(rlength '())
;-> 0

(rlength '(()))
;-> 1

(rlength '(a b c))
;-> 3

(rlength '(a b (c (d e))))
;-> 7

(rlength '(() (-1) (1 3) (5 (6)) (7 (8 9 (10 11 (12 13 14))))))
;-> 22

Metodo 2 (conta il numero di indici degli elementi)
---------------------------------------------------

(define (index-list lst)
"Create a list of indexes for all the elements of a list"
  (ref-all nil lst (fn(x) true)))

(index-list '(a b (c (d e))))
;-> ((0) (1) (2) (2 0) (2 1) (2 1 0) (2 1 1))

(define (rlength1 lst)
  (length (ref-all nil lst (fn (x) true))))

Proviamo:

(rlength1 '())
;-> 0

(rlength1 '(()))
;-> 1

(rlength1 '(a b c))
;-> 3

(rlength1 '(a b (c (d e))))
;-> 7

(rlength1 '(() (-1) (1 3) (5 (6)) (7 (8 9 (10 11 (12 13 14))))))
;-> 22


------------------
Cifratura di Bacon
------------------

La cifratura di Bacon è un metodo di codifica steganografica dei messaggi ideato da Francis Bacon nel 1605.
Questo cifrario è classificato sia come cifrario a sostituzione (in codice semplice) sia come cifrario a occultamento (utilizzando i due caratteri tipografici diversi).
Per codificare un messaggio, ogni lettera del testo in chiaro viene sostituita da un gruppo di cinque lettere "A" o "B".
Questa sostituzione è una codifica binaria a 5 bit e viene eseguita in base alla seguente tabella:

Lettera  Codifica       Lettera  Codifica
A        AAAAA          N        ABBAB
B        AAAAB          O        ABBBA
C        AAABA          P        ABBBB
D        AAABB          Q        BAAAA
E        AABAA          R        BAAAB
F        AABAB          S        BAABA
G        AABBA          T        BAABB
H        AABBB          U        BABAA
I        ABAAA          V        BABAB
J        ABAAB          W        BABBA
K        ABABA          X        BABBB
L        ABABB          Y        BBAAA
M        ABBAA          Z        BBAAB

Dopo aver codificato tutte le lettere del messaggio nelle lettere A e B sopra, bisogna selezionare due caratteri tipografici diversi da utilizzare nella stringa da trasmettere (es. lettere 'maiuscole' per le 'A' e lettere 'minuscole' per le 'B').

Vediamo un esempio:

messaggio = Ciao mamma

codifica del messaggio in A e B: AAABAABAAAAAAAAABBBAABBAAAAAAAABBAAABBAAAAAAA

stringa da trasmettere: oggi andiamo tutti a fare il bagno nella piscina riscaldata

Adesso dobbiamo applicare la codifica del messaggio nella stringa da trasmettere tramite le maiuscole e le minuscole.
Quando nella codifica incontriamo una 'A', allora la relativa lettera della stringa da trasmettere deve essere maiuscola.
Quando nella codifica incontriamo una 'B', allora la relativa lettera della stringa da trasmettere deve essere minuscola.

Codifica:
  "AAAB AABAAAA AAAAA B BBAA BB AAAAA AAABB AAABBAA AAAAA"

Stringa da trasmettere:
  "oggi andiamo tutti a fare il bagno nella piscina riscaldata"

Applicazione della codifica sulla stringa da trasmettere:
  "OGGi ANdIAMO TUTTI a faRE il BAGNO NELla PISciNA RISCAldata"

  "AAAB AABAAAA AAAAA B BBAA BB AAAAA AAABB AAABBAA AAAAA"
  "oggi andiamo tutti a fare il bagno nella piscina riscaldata"
  "OGGi ANdIAMO TUTTI a faRE il BAGNO NELla PISciNA RISCAldata"

Nota: la stringa da trasmettere deve essere lunga almeno quanto la codifica del messaggio.
Cioè deve avere tante lettere minuscole o maiuscole quanto è lunga la codifica.

(define (encode msg str)
  (local (out alst code lencode idx)
    (setq out "")
    (setq alst '(("A" "AAAAA") ("B" "AAAAB") ("C" "AAABA") ("D" "AAABB")
                ("E" "AABAA") ("F" "AABAB") ("G" "AABBA") ("H" "AABBB")
                ("I" "ABAAA") ("J" "ABAAB") ("K" "ABABA") ("L" "ABABB")
                ("M" "ABBAA") ("N" "ABBAB") ("O" "ABBBA") ("P" "ABBBB")
                ("Q" "BAAAA") ("R" "BAAAB") ("S" "BAABA") ("T" "BAABB")
                ("U" "BABAA") ("V" "BABAB") ("W" "BABBA") ("X" "BABBB")
                ("Y" "BBAAA") ("Z" "BBAAB")))
    (setq code "")
    (setq msg (upper-case msg))
    ; crea la codifica 
    (dolist (ch (explode msg))
      (cond ((and (>= (char ch) 65) (<= (char ch) 90)) ; A..Z
            (extend code (lookup ch alst)))
      )
    )
    (setq lencode (length code))
    (setq str (upper-case str))
    (setq idx 0)
    ; costruisce la stringa da trasmettere
    (dolist (ch (explode str))
      (cond ((and (>= (char ch) 65) (<= (char ch) 90)) ; A..Z
            (if (and (< idx lencode) (= (code idx) "A"))
                (extend out ch)
                (extend out (lower-case ch)))
              (++ idx))
            (true (extend out ch))
      )
    )
    out))

Proviamo:

(encode "Ciao mamma" "oggi andiamo tutti a fare il bagno nella piscina riscaldata")
;-> "OGGi ANdIAMO TUTTI a faRE il BAGNO NELla PISciNA RISCAldata"

La decodifica funzione in maniera inversa.

(define (decode str)
  (local (out alst code gruppi)
    (setq out "")
    (setq alst '(("AAAAA" "A") ("AAAAB" "B") ("AAABA" "C") ("AAABB" "D")
                ("AABAA" "E") ("AABAB" "F") ("AABBA" "G") ("AABBB" "H")
                ("ABAAA" "I") ("ABAAB" "J") ("ABABA" "K") ("ABABB" "L")
                ("ABBAA" "M") ("ABBAB" "N") ("ABBBA" "O") ("ABBBB" "P")
                ("BAAAA" "Q") ("BAAAB" "R") ("BAABA" "S") ("BAABB" "T")
                ("BABAA" "U") ("BABAB" "V") ("BABBA" "W") ("BABBB" "X")
                ("BBAAA" "Y") ("BBAAB" "Z")))
    (setq code "")
    ; crea la codifica
    (dolist (ch (explode str))
      (cond ((and (>= (char ch) 65) (<= (char ch) 90)) ; A..Z
            (extend code "A"))
            ((and (>= (char ch) 97) (<= (char ch) 122)) ; a..z
            (extend code "B"))
      )
    )
    ; converte la codifica nel messaggio
    (setq gruppi (explode code 5))
    (dolist (g gruppi)
      (if (lookup g alst)
          (extend out (lookup g alst))
      )
    )
    out))

Proviamo:

(decode "OGGi ANdIAMO TUTTI a faRE il BAGNO NELla PISciNA RISCAldata")
;-> "CIAOMAMMA"
Nota: non otteniamo "CIAO MAMMA", perchè lo spazio " " non è codificato.

(decode (encode "cattivik" "Personaggio immortale dei fumetti creato da Bonvi"))
;-> "CATTIVIK"


-------------------------------------------------------
N-esimo primo tale che (primo - 1) sia divisibile per N
-------------------------------------------------------

Dato un numero N, trovare l'N-esimo primo tale che (primo − 1) sia divisibile per N.

Vediamo un esempio per capire cosa stiamo cercando:

N = 4
Esaminare tutti (abbastanza) i numeri primi:

  2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 ...

Selezionare i numeri primi in cui risulta (primo − 1) divisibile per N (4 in questo caso):

  5 13 17 29 37 41 53 61 73 89 97 ...
 
Selezionare l'N-esimo termine in questa sequenza (il quarto in questo caso):

Output = 29

Sequenza OEIS A077317: a(n) is the n-th prime == 1 (mod n)
  2, 5, 19, 29, 71, 43, 211, 193, 271, 191, 661, 277, 937, 463, 691, 769,
  1531, 613, 2357, 1021, 1723, 1409, 3313, 1609, 3701, 2029, 3187, 2437, 
  6961, 1741, 7193, 3617, 4951, 3877, 7001, 3169, 10657, 6271, 7879, 5521,
  13613, 3823, 15137, 7349, 9091, 7499, ...

a(n) is the n-th prime in the arithmetic progression with first term 1 and common difference n.

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

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

(time (setq primi (primes-to 1e6)))
;-> 144.922

(define (seq num)
  (setq lst (filter (fn(x) (zero? (% (- x 1) num))) primi))
  (if (>= (length lst) num)
      (lst (- num 1))
      nil))

Proviamo:

(seq 4)
;-> 29

(seq 10)
;-> 191

(time (println (sequenza 100 1e6)))
;-> (2 5 19 29 71 43 211 193 271 191 661 277 937 463 691 769 1531 613 2357 
;->  1021 1723 1409 3313 1609 3701 2029 3187 2437 6961 1741 7193 3617 4951 
;->  3877 7001 3169 10657 6271 7879 5521 13613 3823 15137 7349 9091 7499 
;->  18049 6529 18229 7151 13159 10141 26501 7669 19801 11593 18127 13109
;->  32569 8221 34649 17981 21799 16001 28081 10429 39799 19381 29947 14771
;->  47713 16417 51539 25013 29101 26449 50051 16927 54037 23761 41149 31489
;->  68891 19237 51341 33713 45589 34057 84551 19531 64793 42689 54499 41737
;->  76001 27457 97583 40867 66529 39301)
;-> 1678.762

La lista dei numeri primi fino a 1e6 ci permette di calcolare 280 numeri della sequenza:

(sequenza 281 1e6)
;-> (2 5 19 29 71 43 211 193 271 191 661 277 937 463 691 769 1531 613
;->  2357 1021 1723 1409 3313 1609 3701 2029 3187 2437 6961 1741 7193
;->  ...
;->  828977 247369 691121 335161 581527 397981 944191 221941 918149 423233
;->  476659 438401 649001 288697 935707 468709 587017 320041 nil)

Infatti il 281-esimo numero vale nil, questo perchè la lista dei (primi - 1) divisibili per 281 è più corta di 281.

Vediamo il limite calcolando i primi fino a 1e7 (10 milioni):

(time (setq s (sequenza 500 1e7)))
;-> 65641.478

Cerchiamo (se esiste) il primo valore nil:

(ref nil s)
;-> nil

La lista dei numeri primi fino a 1e7 ci permette di calcolare almeno 500 numeri della sequenza.

Vediamo la soluzione proposta da Dennis (python 2):

  n=N=input();m=k=1
  while N:m*=k*k;k+=1;N-=m%k>~-k%n
  print k

Si tratta di un'implementazione compatta di un algoritmo per trovare il più piccolo intero positivo 'k' tale che k! fattoriale (indicato come `k!`) è divisibile per 'n'.

Una versione semplificata, ma equivalente:

  def calc(n):
      N = n
      m = 1
      k = 1
      while N:
          m *= k * k
          k += 1
          remainder = m % k
          if remainder > (k - 1) % n:
              N -= 1
      return k
  n = int(input("Enter a value for n: "))
  output = calc(n)
  print("Il numero k più piccolo tale che k! è divisibile da ", n, "vale", output)

Traduciamo la funzione in newLISP:

(define (python-mod a b) (% (+ (% a b) b) b))

(define (calc num)
  (local (N m k)
    (setq N num)
    (setq m 1L)
    (setq k 1L)
    (while (> N 0)
      (setq m (* m k k))
      (++ k)
      (if (> (python-mod m k) (python-mod (- k 1) num))
          (-- N)
      )
    )
    k))

Proviamo:

(calc 4)
;-> 29L

(calc 10)
;-> 191L

(map calc (sequence 1 10))
;-> (2L 5L 19L 29L 71L 43L 211L 193L 271L 191L)

Comunque questa funzione è più lenta:

(time (println (map calc (sequence 1 50))))
;-> (2L 5L 19L 29L 71L 43L 211L 193L 271L 191L 661L 277L 937L 463L 691L
;->  769L 1531L 613L 2357L 1021L 1723L 1409L 3313L 1609L 3701L 2029L 3187L
;->  2437L 6961L 1741L 7193L 3617L 4951L 3877L 7001L 3169L 10657L 6271L
;->  7879L 5521L 13613L 3823L 15137L 7349L 9091L 7499L 18049L 6529L 18229L
;->  7151L)
;-> 23461.581


-------------------
Da stringa a numero
-------------------

Data una stringa di caratteri minuscoli convertire i caratteri in numeri con il seguente algoritmo:
1) Convertire ogni lettera della stringa in un numero in base alla sua posizione nell'alfabeto (a = 1, b = 2, ecc.)
2) Formattare tutti i numeri con due cifre (con 0).
3) Unire tutti i numeri.

Esempio
stringa = newlisp
n = 14 --> "14"
e =  5 --> "05"
w = 23 --> "23"
l = 12 --> "12"
i =  9 --> "09"
s = 19 --> "19"
p = 16 --> "16"
Output = "14052312091916"

Scrivere la funzione più breve possibile che applica questo algoritmo ad una stringa.

(char "a")
;-> 97

(define (char-index ch) (- (char ch) 96))
(char-index "a")
;-> 1
(char-index "z")
;-> 26

(define (str-num str)
  (join (map (fn(x) (format "%02d" (- (char x) 96))) (explode str))))

Proviamo: 

(str-num "newlisp")
;-> "14052312091916"

(str-num "abcdefghijklmnopqrstuvwxyz")
;-> "0102030405060708091011121314151617181920212223242526"

Ridotta ai minimi termini (70 caratteri):

(define (f s)(join(map(fn(x)(format"%02d"(-(char x)96)))(explode s))))

(f "newlisp")
;-> "14052312091916"

(f "abcdefghijklmnopqrstuvwxyz")
;-> "0102030405060708091011121314151617181920212223242526"


-------------------
Semplici animazioni
-------------------

Alcune semplici animazioni nella REPL.

Funzione che pulisce lo schermo:

(define (cls) (print "\027[H\027[2J"))

Animazione 1:
-------------

(define (anim1 iter wait)
  (setq line1 '("+-----+" "|     |" "|     |" "|     |" "|     |" "|     |" "+-----+"))
  (setq line2 '("+-----+" "|  .  |" "|  .  |" "|  .  |" "|  .  |" "|  .  |" "+-----+"))
  (for (i 1 iter)
    (for (pos 1 5)
      (swap (line1 pos) (line2 pos))
      (cls)
      (map println line1)
      (swap (line2 pos) (line1 pos))
      (sleep wait)
    )
  )'>)

Proviamo:

(anim1 3 1000)

Animazione 2:
-------------

(define (anim2 iter wait)
  (setq s1 { #    #  ######  #    #  #       #   ####   #####  })
  (setq s2 { ##   #  #       #    #  #       #  #       #    # })
  (setq s3 { # #  #  #####   #    #  #       #   ####   #    # })
  (setq s4 { #  # #  #       # ## #  #       #       #  #####  })
  (setq s5 { #   ##  #       ##  ##  #       #  #    #  #      })
  (setq s6 { #    #  ######  #    #  ######  #   ####   #      })
  (setq s (list s1 s2 s3 s4 s5 s6))
  (for (i 1 iter)
    (for (space 1 10)
      (cls)
      (for (l 0 5) (println (dup " " space) (s l)))
      (sleep wait)
    )
    (for (space 9 2)
      (cls)
      (for (l 0 5) (println (dup " " space) (s l)))
      (sleep wait)
    )
  )'>)

Proviamo:

(anim2 3 200)

Animazione 3:
-------------

(define (anim3 iter wait)
  (setq s1 {                                       `7MMF'      `7MMF'  .M"""bgd `7MM"""Mq.  })
  (setq s2 {                                         MM          MM   ,MI    "Y   MM   `MM. })
  (setq s3 { `7MMpMMMb.   .gP"Ya `7M'    ,A    `MF'  MM          MM   `MMb.       MM   ,M9  })
  (setq s4 {   MM    MM  ,M'   Yb  VA   ,VAA   ,V    MM          MM     `YMMNq.   MMmmdM9   })
  (setq s5 {   MM    MM  8M""""""   VA ,V  VA ,V     MM      ,   MM   .     `MM   MM        })
  (setq s6 {   MM    MM  YM.    ,    VVV    VVV      MM     ,M   MM   Mb     dM   MM        })
  (setq s7 { .JMML  JMML. `Mbmmd'     W      W     .JMMmmmmMMM .JMML. P"Ybmmd"  .JMML.      })
  (setq s (list s1 s2 s3 s4 s5 s6 s7))
  (for (i 1 iter)
    (for (visible 1 (length s1))
      (cls)
      (for (l 0 6) (println (slice (s l) 0 visible)))
      (sleep wait)
    )
    (for (visible 1 (length s1))
      (cls)
      (for (l 0 6) (println (slice (s l) (- visible))))
      (sleep wait)
    )
  )
  '>)

Proviamo:

(anim3 3 50)

Animazione 4:
-------------

(define (cls)
"Clear screen of REPL (ANSI sequence)"
  (print "\027[H\027[2J"))

(define (print-matrix matrix)
  (local (rows cols)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (print (matrix r c))
      )
      (println))))

(setq linee '(
  "    *             *             *             *             *         " 
  "   * *           * *           * *           * *           * *        "
  "  *   *         *   *         *   *         *   *         *   *       "
  " *     *       *     *       *     *       *     *       *     *      "
  "*       *     *       *     *       *     *       *     *       *     "
  "         *   *         *   *         *   *         *   *         *   *"
  "          * *           * *           * *           * *           * * "
  "           *             *             *             *             *  "))

(define (anim4)
  (setq m (map explode linee))
  (for (i 10000 1)
    (cls)
    (print-matrix m)
    (setq m (transpose (rotate (transpose m))))
    (sleep 75)))

(anim4)

(setq linee '(
  "QQBQBQBBBQBQBBBQBBBQBBBQBQBBBBBQBBBQBBBBBBBBBBBBBBQQBBBQBBBQBBBQBgBBBQ"
  "QBQBQBQBQBBBBBBBQBQBQBQBQQZgMMQBBBBBBBQPqDDQBBBBQBBBBBBBBBBBBBBBBdQBBB"
  "BQBBBBBQBQBBBQBBBQQQQZMZDESqDgMEgQBBBQQPKPSvvjSbQBBBBBBBBQBBBBBBBBBBBB"
  "QBBBQBQBBBBBBBQQRQQQMgRMgRZgQQDggQBQRQQBBBBBBQbXSPgQRBBBBBBBQBBBBBBBBB"
  "BQBBBQBQBQBBBDgPDRBBRRgEQQBQQgEDDZRDMMBQBBBBBBBBBqrKQPZBBBBBBBBBBBBQBQ"
  "QBQBQBBBBBBDbK2EQQQQQRdgDRgMZPu1uIj5IPSSKZPbEMDRQBBXYd22MBBBQBQBBBBBQB"
  "BQBBBQBQBQPK2KBBBBQgbUJvjJJu1j2su11jL7sJs1IIPPDEPdBBR5PuKEBBBBBBBBBBBB"
  "BBQBBBBBgbPrqBBBDPIUJs77rriri77vJsvvrrrvrvLvvUIDRgqgBBQUqgMBBBBBBBBBBB"
  "BQBQBBBRRgiPBQZI1sJLY777ririi:iii:i:::i:iiiirr772qEdPZBM1RBMQQBBBBBBBQ"
  "QBBBBBgMB7bBPdIXUJLLrrii::::::..::.:.::::::iiiirr771dZdBQrZBQBBBBBBBBB"
  "BQBBBQXQUqBS1jKPuvLv7ii::.......:...:::.::::iiirvs2v72EgBZ7QBQBBBBBQBQ"
  "QBQBBPUQUBDdbEPIss77ri:::........:.....:.:::::irrvYPSvvqRBgEQBQBQBQBQB"
  "BQBQM5dRQQBMQZUJJ77ri::...............:...iirrvYY77Ydb7YbQBBggQQBBBBBQ"
  "QBBBDZMQQBQBDuJ1L7rrr7iriri:....   ..:::ivLYvv7LUK5IIZK1PQBBMgRQQBBBBB"
  "BBBQRMQQBQBR5vI2Y7s11L7irr777ri.:...::irr:.     .:YqdPM2SDQBBZRgQBBBBB"
  "QBQBQQQBBBRPj52SUP27:.     ..:ii:. ..:ri.::r7uUsLi:vSbXIjDdQBZbDgBQBBB"
  "BQBBQQQQBRZU25I1KJi.:iv5XYIri..ii.  :r7.iiSBQBg:KPvr7YJYqPZQBQDEERBBBB"
  "QBQBgBMgBBZK22u777iiUDiPBRBg:i i7i::i7vi:..YUKJirv7ri7vUPd1PQBBMqgBBBB"
  "BQQQRQQRBBBR5Juri:irY7ir5u7:..i777rr7vvv7:.   ..:.:i7rYuKZbQBZPQZdBQBQ"
  "QBQBQBQQgBBQg51viiir::..   .:r7vvviiirsu7rir:::::::ir7LuuRXqQBZQPdBBBB"
  "BBBQQQBRESrYRPuL7rr::...::iii.:Yj:.  .:J2:..::::iiiirr12bZY.:SjKPDBBBQ"
  "BBQQQQQRggL:2MYu77ii:::i:i:.. .vi7i..iviri   ...::irrvUqZKr. URMPQBBQB"
  "BBBMBQQZgE5rrv1Lj7iiiii::.. . .::i:::.:::..   ..::ii7vXPIiiv1MQgQQBBBQ"
  "QBQQQBgXMgs77715Yuri:i::...  ...::.....::i.....::iirrJKq..:PQBgdbQQQQB"
  "BQQQQQB5dQB5v:iJ7vLrrii::.. ...::iri7rrLv7ri:.:::ir7vv2QqUYEBQBQgZQQQB"
  "QBQBQBBQbQBB5usjsir7rr::::....rs5duij7rXIdPY...::irrrvDBBDv7QBBBQgdgRQ"
  "BQBQBQBBQZMMDDBBBd::iii:::....7jIU1jUuJYuJ7:....:iri7PBQMq2iIBBQBMRDRg"
  "QQQBQBQBQBgRQQBBQBgY7rii::...:...:::::::::...:..:rrvDBQIdULvLqQBQQRMQB"
  "BQBQBQBQBQBBBQBBBBBRP5Jri::.:..........   ..:::i7v1gQXBBQP7v7LSQBQQZDg"
  "QBBBQBQQQBBBPr7BBR5BqsIqULr:::....       ...iLvYJ5qQ: .KBBSU5U1XbgQBQM"
  "BQQQQQBQBBq   .MBQv.gP:rUXq21Lr::........:i7Ys1uUj5P.   rgBd5XqXKSPDBB"
  "QBQBQBBBBS     :BBBsvBZ:.iruUIU177rrirr77YLuJ2UY7vu7.     vBBEqPXbbEPZ"
  "QQBQBBBBr       iMBBQKBY....:ivYujuJusuJJYu1ILrirrUXi      PBBBggEgDgM"
  "QBQBBBBi         7RBMRQv.:.....:irr7777v7LvLi::i7rKB.   .. :QBBBBBBBQB"
  "BQBBYi.        .  uBqX2Ji.:.........::::iii:..i77iP:    .. .7:KZBQBBBB"))

(anim4)


------------------------------------------
Coppie di primi che sommano ad un intero N
------------------------------------------

Dato un numero intero positivo N, trovare tutte le coppie univoche di numeri primi la cui somma vale N.

Algoritmo:
Ciclo per un numero intero k da 2 a N - 2 
(poiché il numero primo minimo è 2 e la differenza massima possibile tra due numeri primi inferiori o uguali a N è N - 2)
  se sia K che (N - K) sono primi, aggiungerli alla lista delle coppie.

Per evitare coppie duplicate possiamo modificare l'algoritmo iterando solo fino a (N/2).
Ciò garantisce che ciascuna coppia (k, N - K) è unica (es. senza duplicati come (7 3) e (3 7) per N=10).

Sequenza OEIS A061358:
Number of ways of writing n = p+q with p, q primes and p >= q
  0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 0, 1, 1, 2, 1, 2, 0, 2, 1, 2, 1, 3, 0,
  3, 1, 3, 0, 2, 0, 3, 1, 2, 1, 4, 0, 4, 0, 2, 1, 3, 0, 4, 1, 3, 1, 4, 0,
  5, 1, 4, 0, 3, 0, 5, 1, 3, 0, 4, 0, 6, 1, 3, 1, 5, 0, 6, 0, 2, 1, 5, 0,
  6, 1, 5, 1, 5, 0, 7, 0, 4, 1, 5, 0, 8, 1, 5, 0, 4, 0, 9, 1, 4, 0, 5, 0,
  7, 0, 3, 1, 6, 0, 8, 1, 5, 1, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (pair-sum num)
  (let (out '())
    (for (k 2 (- num 2))
      (if (and (<= k (- num k)) (prime? k) (prime? (- num k)))
          (push (list k (- num k)) out -1)
      )
    )
    out))

Proviamo:

(pair-sum 5)
;-> ((3 2))
(pair-sum 10)
;-> ((3 7) (5 5))

Vediamo le coppie per i primi 10 numeri:

(map (fn(x) (list x (length (pair-sum x)))) (sequence 1 10))
;-> ((1 0) (2 0) (3 0) (4 1) (5 1) (6 1) (7 1) (8 1) (9 1) (10 2))

Generiamo la sequenza:

(map (fn(x) (length (pair-sum x))) (sequence 0 100))
;-> (0 0 0 0 1 1 1 1 1 1 2 0 1 1 2 1 2 0 2 1 2 1 3 0 3 1 3 0 2 0 3 1 2
;->  1 4 0 4 0 2 1 3 0 4 1 3 1 4 0 5 1 4 0 3 0 5 1 3 0 4 0 6 1 3 1 5 0
;->  6 0 2 1 5 0 6 1 5 1 5 0 7 0 4 1 5 0 8 1 5 0 4 0 9 1 4 0 5 0 7 0 3
;->  1 6)

Vediamo la funzione che itera fino a (N/2):

(define (pair-sum1 num)
  (let (out '())
    (for (k 2 (/ num 2))
      (if (and (prime? k) (prime? (- num k)))
          (push (list k (- num k)) out -1)
      )
    )
    out))

Proviamo:

(pair-sum1 5)
;-> ((3 2))
(pair-sum1 10)
;-> ((3 7) (5 5))

Vediamo se le due funzioni producono risultati uguali:

(= (map pair-sum (sequence 0 1e4))
   (map pair-sum1 (sequence 0 1e4)))
;-> true

(= (map (fn(x) (length (pair-sum x))) (sequence 0 1e4))
   (map (fn(x) (length (pair-sum1 x))) (sequence 0 1e4)))
;-> true

Vediamo il tempo di esecuzione delle due funzioni:

(time (map pair-sum (sequence 0 1e4)))
;-> 10337.865
(time (map pair-sum1 (sequence 0 1e4)))
;-> 7456.754

(time (map (fn(x) (length (pair-sum x))) (sequence 0 1e4)))
;-> 10355.053
(time (map (fn(x) (length (pair-sum1 x))) (sequence 0 1e4)))
;-> 7454.767

Scriviamo una funzione che genera la sequenza sfruttando il fatto che:
per un numero dispari N, a(N) = 0 se N-2 non è primo, altrimenti a(N) = 1.

(define (pair-sum-to2 limite)
  (let (out '())
    (for (num 0 limite)
      (setq conta 0)
      (cond ((odd? num) 
              (if (prime? (- num 2)) 
                  (push 1 out -1)
                  (push 0 out -1)))
            (true
              (for (k 2 (/ num 2))
                (if (and (prime? k) (prime? (- num k))) (++ conta))
              )
              (push conta out -1))
      )
    )
    out))

Proviamo:

(pair-sum-to2 100)
;-> (0 0 0 0 1 1 1 1 1 1 2 0 1 1 2 1 2 0 2 1 2 1 3 0 3 1 3 0 2 0 3 1 2
;->  1 4 0 4 0 2 1 3 0 4 1 3 1 4 0 5 1 4 0 3 0 5 1 3 0 4 0 6 1 3 1 5 0
;->  6 0 2 1 5 0 6 1 5 1 5 0 7 0 4 1 5 0 8 1 5 0 4 0 9 1 4 0 5 0 7 0 3
;->  1 6)

Vediamo se la funzione produce risultati uguali ai precedenti:

(= (pair-sum-to2 1e4)
   (map (fn(x) (length (pair-sum1 x))) (sequence 0 1e4)))
;-> true

Vediamo la velocità della funzione:

(time (pair-sum-to2 1e4))
;-> 3713.86

(time (pair-sum-to2 1e5))
;-> 494744.123 ;8m 14s 744ms


---------------------------
Creazione di liste di orari
---------------------------

Scriviamo una funzione che genera una lista con tutti gli orari dall'ora x all'ora y.
Gli orari in formato 24-ore sono rappresentati da una lista (ore minuti secondi) :
  
  HH-MM-SS, con HH=(0..23), MM=(0..59), SS=(0..59)

Per esempio:
(12 3 20), Mezzogiorno, 3 minuti e 20 secondi
(15 2 0),  Le 15 (o 3 di pomeriggio) e 2 minuti
(1 30 0),  L'una e mezza

(define (time-list t1 t2)
"Generates a list of times (HH MM SS) from t1 to t2"
  (local (out a b)
    (setq out '())
    (for (h (t1 0) (t2 0))
      (for (m 0 59)
        (for (s 0 59)
          (push (list h m s) out -1)
        )
      )
    )
    (setq a (find t1 out))
    (setq b (find t2 out))
    (slice out a (+ (- b a) 1))))

Proviamo:

(time-list '(1 0 0) '(1 1 1))
;-> ((1 0 0) (1 0 1) (1 0 2) (1 0 3) (1 0 4) (1 0 5) (1 0 6) (1 0 7) (1 0 8)
;->  (1 0 9) (1 0 10) (1 0 11) (1 0 12) (1 0 13) (1 0 14) (1 0 15) (1 0 16)
;->  (1 0 17) (1 0 18) (1 0 19) (1 0 20) (1 0 21) (1 0 22) (1 0 23) (1 0 24)
;->  (1 0 25) (1 0 26) (1 0 27) (1 0 28) (1 0 29) (1 0 30) (1 0 31) (1 0 32)
;->  (1 0 33) (1 0 34) (1 0 35) (1 0 36) (1 0 37) (1 0 38) (1 0 39) (1 0 40)
;->  (1 0 41) (1 0 42) (1 0 43) (1 0 44) (1 0 45) (1 0 46) (1 0 47) (1 0 48)
;->  (1 0 49) (1 0 50) (1 0 51) (1 0 52) (1 0 53) (1 0 54) (1 0 55) (1 0 56)
;->  (1 0 57) (1 0 58) (1 0 59) (1 1 0) (1 1 1))

Tutti i secondi che formano una giornata:

(length (time-list '(0 0 0) '(23 59 59)))
;-> 86400
(* 24 60 60)
;-> 86400


-----------------
Speed up the code
-----------------

Alcune raccomandazioni da parte di Lutz per velocizzare i programmi newLISP.
 
Several recommendations to speed up the code and other comments:

instead of:

(if (not (nil? suffix-match)) ...

say:

if( (not suffix-match) ...)
; or even faster
(unless suffix-match ...)

instead of:

(last (assoc 'suffix data))

say:

(lookup 'suffix data)

'lookup' will always pick the last in the association (if not given an index)

instead of:

 (if (nil? good-match) ...)

try also 'not', which will trigger on 'nil' and (), while 'nil?' means strictly 'nil'.
Not sure about the logic here and the impact is probably minimal, but its better English :-)

(if (not good-match) ...)

I also have a difficult time in newlisp deciding when to use nil params in the function def or let statements.

All parameters in p1,p2,p3 (define (foo p1 p2 p3) ...) are set to 'nil' if not filled in by the caller.

In a 'let' statement if you want to have the params imitialized to 'nil' then better use 'local' (much less overhead/faster):

instead of:

(let (param nil) ....)

do:

(local (param) ...)

It is reassigning the same global symbol over and over. 
That couldn't be causing the slowdown, could it?

If that global variable always gets the same value, I would set it only once.

Do not compose the name records bye doing 'replace-assoc' in the 'data' list:

 (set 'data '((first-name nil) (middle-name nil) (last-name nil)))

Would it not be better to compose the whole name records using list' statements instead of replace-assoc statements?

To speedup the name parser code:

(time (format "%s %s %s" "hi" "ho" "hum") 1000000)
;-> 4818
(time (append  "hi" " "  "ho" " " "hum") 1000000)
;-> 1723

when using 'format' for simple string appending with filling in text in between, 'append' can be a lot faster.

This is for the '(format "%s %s %s" $3 $1 $2)' pieces in the normalize function.


--------------------------------
Ottimizzare l'unione di stringhe
--------------------------------

Per unire due stringhe possiamo usare i seguenti metodi:

1) Uso di "append":

(define (test1)
  (setq a "filename")
  (setq a (append a ".txt"))
  a)

2) Uso di "extend":

(define (test2)
  (setq a "filename")
  (extend a ".txt")
  a)

3) Uso di "write":

(define (test3)
  (setq a "filename")
  (write a ".txt")
  a)

4) Uso di "string":

(define (test4)
  (setq a "filename")
  (setq a (string a ".txt"))
  a)

Proviamo:

(test1)
;-> "filename.txt"
(test2)
;-> "filename.txt"
(test3)
;-> "filename.txt"
(test4)
;-> "filename.txt"

Vediamo la velocità delle funzioni:

(time (test1) 1e6)
;-> 310.228

(time (test2) 1e6)
;-> 238.502

(time (test3) 1e6)
;-> 244.503

(time (test4) 1e6)
;-> 271.913

Per unire due o più stringhe è meglio usare la funzione "extend".


------------------------------
Crivello di Eratostene visuale
------------------------------

Il Crivello di Eratostene è un algoritmo antico e efficiente per trovare tutti i numeri primi fino a un certo limite dato.
Fu sviluppato dal matematico greco Eratostene circa 2300 anni fa.

Ecco come funziona l'algoritmo:

Inizializzazione:
1) Si inizia con una lista di numeri interi da 2 fino al limite superiore desiderato.
Inizialmente, tutti questi numeri sono considerati come potenziali numeri primi.
Il numero 1 non è un numero primo.

2) Individuazione dei multipli:
Si inizia con il primo numero della lista (2) e si cancellano tutti i suoi multipli dalla lista, tranne se stesso.
Successivamente, si passa al prossimo numero non cancellato e si ripete questo processo.
Questo viene fatto fino a quando non si supera la radice quadrata del limite.

3) Numeri rimanenti: Dopo aver completato il passaggio precedente, i numeri rimanenti nella lista sono tutti primi, poiché i loro multipli sono stati cancellati.

Output: I numeri rimanenti nella lista sono i numeri primi fino al limite desiderato.

L'algoritmo di Eratostene sfrutta il fatto che se un numero è divisibile per un altro numero primo, allora non può essere un numero primo stesso.
Pertanto, eliminando i multipli dei numeri primi dalla lista, rimangono solo i numeri primi.
Questo metodo è molto efficiente, poiché non richiede di controllare la primalità di ogni numero separatamente, ma opera soltanto sul filtraggio dei multipli.

Funzione di Eratostene (base):
------------------------------
(define (eratostene n)
  (local (primi p out)
    ; Crea una lista di booleani inizializzata a True, tranne l'indice 0 e 1
    (setq primi (array (+ n 1) '(true)))
    (setf (primi 0) nil)
    (setf (primi 1) nil)
    ; Inizia con il primo numero primo (2)
    (setq p 2)
    ; Ciclo fino a che (n >= p^2)
    (while (<= (* p p) n)
      ; Se primi(p) vale true, allora è un numero primo
      (if (primi p)
          ; Aggiorna tutti i multipli di p come non primi (nil)
          (for (i (* p p) n p) (setf (primi i) nil))
      )
      ; prossimo numero
      (++ p)
    )
    ; Ritorna la lista dei numeri primi
    (setq out '())
    (for (i 2 n)
      (if (primi i) (push i out -1))
    )
    out))

Proviamo:

(eratostene 50)
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47)

Funzione di Eratostene (visuale lineare)
----------------------------------------
(define (print-multipli arr val)
  (dolist (el arr)
    (cond ((and el (zero? (% $idx val)))
            ; multipli in rosso
            (print "\027[0;31m" $idx "\027[39;49m" " "))
          (el (print $idx " "))
    )
  )
  (println))

(define (print-nums arr)
  (for (i 1 (- (length arr) 1))
    (if (arr i) (print i " "))
  )
  (println))

(define (print-multipli-line arr val)
  (dolist (el arr)
    (cond ((and el (zero? (% $idx val)))
            (print (dup "*" (length $idx)) " "))
          (el (print (dup " " (length $idx)) " "))
    )
  )
  (println))

(define (eratostene-v n)
  (local (primi p out)
    ; Crea una lista di booleani inizializzata a True, tranne l'indice 0 e 1
    (setq primi (array (+ n 1) '(true)))
    (setf (primi 0) nil)
    (setf (primi 1) nil)
    (println "Tutti i numeri (senza 1):")
    (print-nums primi)
    (println)
    ; Inizia con il primo numero primo (2)
    (setq p 2)
    ; Ciclo fino a che (n >= p^2)
    (while (<= (* p p) n)
      ; Se primi(p) è true, allora è un numero primo
      (if (primi p)
        (begin
          (println "Togliamo i numeri multipli di " p " (tranne il " p "):")
          (print-multipli-line primi p)
          (print-multipli primi p)
          ; Aggiorna tutti i multipli di p come non primi
          (for (i (* p p) n p) (setf (primi i) nil))
          (println "Rimangono i numeri:")
          (print-nums primi) (read-line))
      )
      ; prossimo numero
      (++ p)
    )
    (println "(" p "*" p "=" (* p p) ") >= " n " --> Stop")
    ; Ritorna la lista dei numeri primi
    (setq out '())
    (for (i 2 n)
      (if (primi i) (push i out -1))
    )
    (println "Numeri primi: ")
    out))

Proviamo:

(eratostene-v 28)
;-> Tutti i numeri (senza 1):
;-> 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
;->
;-> Togliamo i numeri multipli di 2 (tranne il 2):
;-> *   *   *   *   **    **    **    **    **    **    **    **    **    **
;-> 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
;-> Rimangono i numeri:
;-> 2 3 5 7 9 11 13 15 17 19 21 23 25 27
;->
;-> Togliamo i numeri multipli di 3 (tranne il 3):
;->   *     *       **       **       **
;-> 2 3 5 7 9 11 13 15 17 19 21 23 25 27
;-> Rimangono i numeri:
;-> 2 3 5 7 11 13 17 19 23 25
;->
;-> Togliamo i numeri multipli di 5 (tranne il 5):
;->     *                  **
;-> 2 3 5 7 11 13 17 19 23 25
;-> Rimangono i numeri:
;-> 2 3 5 7 11 13 17 19 23
;->
;-> (6*6=36) >= 28 --> Stop
;-> Numeri primi:
;-> (2 3 5 7 11 13 17 19 23)

Funzione di Eratostene (visuale quadrata)
-----------------------------------------
In questo caso il parametro n è il lato del quadrato.

(define (print-quad arr)
  (for (i 1 (- (length arr) 1))
    ;(cond ((arr i) (print (format "%3d" i)))
    (cond ((arr i) (print (format (string "%" len-max "d") i)))
          ;(true (print (format "%3s" " "))))
          (true (print (format (string "%" len-max "s") " "))))
    (if (zero? (% i side)) (println))))

(define (eratostene-q n)
  (local (side len-max primi p out)
    (setq side n)
    (setq n (* n n))
    (setq len-max (+ (length n) 1))
    ; Crea una lista di booleani inizializzata a True, tranne l'indice 0 e 1
    (setq primi (array (+ n 1) '(true)))
    (setf (primi 0) nil)
    (setf (primi 1) nil)
    (println "Tutti i numeri (senza 1):")
    (print-quad primi)
    (read-line)
    ; Inizia con il primo numero primo (2)
    (setq p 2)
    ; Ciclo fino a che (n >= p^2)
    (while (<= (* p p) n)
      ; Se primi(p) vale true, allora è un numero primo
      (if (primi p)
        (begin
          (println "Togliamo i numeri multipli di " p " (tranne il " p "):")
          ; Aggiorna tutti i multipli di p come non primi (nil)
          (for (i (* p p) n p) (setf (primi i) nil))
          (print-quad primi) (read-line))
      )
      ; prossimo numero
      (++ p)
    )
    ; Ritorna la lista dei numeri primi
    (setq out '())
    (for (i 2 n)
      (if (primi i) (push i out -1))
    )
    (println "Numeri primi: ")
    out))

Proviamo:

(eratostene-q 9)
;-> Tutti i numeri (senza 1):
;->      2  3  4  5  6  7  8  9
;->  10 11 12 13 14 15 16 17 18
;->  19 20 21 22 23 24 25 26 27
;->  28 29 30 31 32 33 34 35 36
;->  37 38 39 40 41 42 43 44 45
;->  46 47 48 49 50 51 52 53 54
;->  55 56 57 58 59 60 61 62 63
;->  64 65 66 67 68 69 70 71 72
;->  73 74 75 76 77 78 79 80 81
;-> 
;-> Togliamo i numeri multipli di 2 (tranne il 2):
;->      2  3     5     7     9
;->     11    13    15    17
;->  19    21    23    25    27
;->     29    31    33    35
;->  37    39    41    43    45
;->     47    49    51    53
;->  55    57    59    61    63
;->     65    67    69    71
;->  73    75    77    79    81
;-> 
;-> Togliamo i numeri multipli di 3 (tranne il 3):
;->      2  3     5     7
;->     11    13          17
;->  19          23    25
;->     29    31          35
;->  37          41    43
;->     47    49          53
;->  55          59    61
;->     65    67          71
;->  73          77    79
;-> 
;-> Togliamo i numeri multipli di 5 (tranne il 5):
;->      2  3     5     7
;->     11    13          17
;->  19          23
;->     29    31
;->  37          41    43
;->     47    49          53
;->              59    61
;->           67          71
;->  73          77    79
;-> 
;-> Togliamo i numeri multipli di 7 (tranne il 7):
;->      2  3     5     7
;->     11    13          17
;->  19          23
;->     29    31
;->  37          41    43
;->     47                53
;->              59    61
;->           67          71
;->  73                79
;-> 
;-> Numeri primi:
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79)

(eratostene-q 15)
;-> Tutti i numeri (senza 1):
;->        2   3   4   5   6   7   8   9  10  11  12  13  14  15
;->   16  17  18  19  20  21  22  23  24  25  26  27  28  29  30
;->   31  32  33  34  35  36  37  38  39  40  41  42  43  44  45
;->   46  47  48  49  50  51  52  53  54  55  56  57  58  59  60
;->   61  62  63  64  65  66  67  68  69  70  71  72  73  74  75
;->   76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
;->   91  92  93  94  95  96  97  98  99 100 101 102 103 104 105
;->  106 107 108 109 110 111 112 113 114 115 116 117 118 119 120
;->  121 122 123 124 125 126 127 128 129 130 131 132 133 134 135
;->  136 137 138 139 140 141 142 143 144 145 146 147 148 149 150
;->  151 152 153 154 155 156 157 158 159 160 161 162 163 164 165
;->  166 167 168 169 170 171 172 173 174 175 176 177 178 179 180
;->  181 182 183 184 185 186 187 188 189 190 191 192 193 194 195
;->  196 197 198 199 200 201 202 203 204 205 206 207 208 209 210
;->  211 212 213 214 215 216 217 218 219 220 221 222 223 224 225
;-> 
;-> Togliamo i numeri multipli di 2 (tranne il 2):
;->        2   3       5       7       9      11      13      15
;->       17      19      21      23      25      27      29
;->   31      33      35      37      39      41      43      45
;->       47      49      51      53      55      57      59
;->   61      63      65      67      69      71      73      75
;->       77      79      81      83      85      87      89
;->   91      93      95      97      99     101     103     105
;->      107     109     111     113     115     117     119
;->  121     123     125     127     129     131     133     135
;->      137     139     141     143     145     147     149
;->  151     153     155     157     159     161     163     165
;->      167     169     171     173     175     177     179
;->  181     183     185     187     189     191     193     195
;->      197     199     201     203     205     207     209
;->  211     213     215     217     219     221     223     225
;-> ...
;-> ...
;-> ...
;-> Togliamo i numeri multipli di 13 (tranne il 13):
;->        2   3       5       7              11      13
;->       17      19              23                      29
;->   31                      37              41      43
;->       47                      53                      59
;->   61                      67              71      73
;->               79              83                      89
;->                           97             101     103
;->      107     109             113
;->                          127             131
;->      137     139                                     149
;->  151                     157                     163
;->      167                     173                     179
;->  181                                     191     193
;->      197     199
;->  211                                             223

Numeri primi:
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
;->  101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191
;->  193 197 199 211 223)


---------------------
Indent newLISP source
---------------------

Il seguente script permette di indentare un file contenente codice in newLISP.

Uso:
newlisp indent.lsp your-script.lsp 4 > output.lsp
oppure
newlisp indent.lsp your-script.lsp > output.lsp
In questo ultimo caso l'indentazione vale 2 spazi.

#!/usr/bin/env newlisp
;; indent.lsp
;; Author: ssqq
;; modified to newLISP 10.7.5: cameyo
;; http://www.newlisp.cn
;; usage:
;; -> newlisp indent.lsp your-script.lsp 4 > output.lsp

(define (indent-code input-file indent)
    (local (v-level new-level file-txt file-lines indent-line indent-lines)
        (setq indent (or indent 2))
        (setq v-level 0)
        (setq file-text (read-file input-file))
        (setq file-lines (map trim (parse file-text "\n")))
        (dolist (v-line file-lines)
            (setq new-level (get-new-level v-line v-level))
            (if (starts-with v-line ")")
                (setq indent-line (get-indent-line new-level v-line indent))
                (setq indent-line (get-indent-line v-level v-line indent))
            )
            (push indent-line indent-lines -1)
            (setq v-level new-level)
        )
        (println (join indent-lines "\n"))
    )
)

(define (get-new-level v-line v-level)
    (local (close-amount open-amount freeze-line)
        (setq freeze-str (replace {".*?[^\\]"}   v-line "" 0))
        (setq freeze-str (replace {{.*?[^\\]}}   v-line "" 0))
        (setq freeze-str (replace {\[.*?[^\\]\]} v-line "" 0))
        (setq freeze-str (replace {(?:^|\s)(?:\;|\#).*?$} v-line "" 0))
        (find-all {\(} freeze-str)
        (setq open-amount $count)
        (setq v-level (+ open-amount v-level))
        (find-all {\)} freeze-str)
        (setq close-amount $count)
        (setq v-level (- v-level close-amount))
    )
)

(define (get-indent-line v-level v-line indent)
    (let (indent-space {})
        (setq indent-space (dup " " (mul v-level (int indent))))
        (append indent-space v-line)
    )
)

(setq input-file (main-args 2))
(setq indent (main-args 3))
(indent-code input-file indent)

(exit)

Possiamo anche sfruttare newLISP per indentare il codice di una funzione:

(define (fibo-i num) "Calculates the Fibonacci number of an integer number"
  (if (zero? num) 0L
  (local (a b c) (setq a 0L b 1L c 0L) (for (i 0 (- num 1))
  (setq c (+ a b)) (setq a b) (setq b c)) a)))

fibo-i
;-> (lambda (num) "Calculates the Fibonacci number of an integer number"
;->  (if (zero? num)
;->   0L
;->   (local (a b c)
;->    (setq a 0L b 1L c 0L)
;->    (for (i 0 (- num 1))
;->     (setq c (+ a b))
;->     (setq a b)
;->     (setq b c)) a)))

Oppure possiamo avere il codice della funzione come stringa:

(source 'fibo-i)
"(define (fibo-i num)\r\n  \"Calculates the Fibonacci number of an integer number\" \r\n  (if (zero? num) \r\n   0L \r\n   (local (a b c) \r\n    (setq a 0L b 1L c 0L) \r\n    (for (i 0 (- num 1)) \r\n     (setq c (+ a b)) \r\n     (setq a b) \r\n     (setq b c)) a)))\r\n\r\n"


------------------------------------------------
Annidare i caratteri di una stringa in una lista
------------------------------------------------

Data una stringa annidare i caratteri in una lista nel modo seguente:
il primo carattere ha annidamento 1.
il secondo carattere ha annidamento 2.
...
il carattere n-esimo ha annidamento n.

Per esempio:
stringa = "newLISP"
output = ("n" ("e" ("w" ("L" ("I" ("S" ("P")))))))

Annidamento del primo carattere "n":
(ref "n" '("n" ("e" ("w" ("L" ("I" ("S" ("P"))))))))
;-> (0)
(length (ref "n" '("n" ("e" ("w" ("L" ("I" ("S" ("P")))))))))
;-> 1

Annidamento dell'ultimo carattere "P":
(ref "P" '("n" ("e" ("w" ("L" ("I" ("S" ("P"))))))))
;-> (1 1 1 1 1 1 0)
(length (ref "P" '("n" ("e" ("w" ("L" ("I" ("S" ("P")))))))))
;-> 7

Funzione che annida i caratteri di una stringa in una lista:

(define (nest-string str)
  ; inserisce l'ultimo carattere nella lista
  (let (out (list (str -1))) 
    (for (i (- (length str) 2) 0)
      ; annida il carattere corrente nella lista
      (setq out (list (str i) out))
    )
    out)

Proviamo:

(nest-string "newLISP")
;-> ("n" ("e" ("w" ("L" ("I" ("S" ("P")))))))

(nest-string "una stringa")
;-> ("u" ("n" ("a" (" " ("s" ("t" ("r" ("i" ("n" ("g" ("a")))))))))))


----------------------------------
Write the output of REPL in a file
----------------------------------

Possiamo impostare stdout anche su file con la funzione "device".
In questo modo tutto l'output di print/ln viene scritto anche in un file.

(device (open "log-file" "w"))
;-> 3
(println "hello world")
;-> "hello world"
(close (device))
;-> true
!type log-file
;-> hello world

Nota: il file deve essere chiuso prima di chiudere la REPL.


----------------
Il codice Baudot
----------------

Nel 1870 Émile Baudot inventò il codice Baudot, una codifica di caratteri a lunghezza fissa per la telegrafia.
Il codice veniva inserito tramite una tastiera manuale con soli cinque tasti.
Ognuno dei 32 simboli ha una codifica binaria di 5 bit.

Come è possibile rappresentare tutte le lettere, i numeri e i segni di punteggiatura con 32 simboli?

Il trucco di Baudot consiste nell'utilizzare due set di carateri distinti: Lettere e Cifre.
Per passare da un set all'altro si usano due codici speciali:
1) Letter Shift (LS), che passa alla modalità Lettere (tasto 5 (00001))
2) Figure Shift (FS), cha passa alla modalità Cifre (tasto 4 (00010)).

In questo caso usiamo solo i caratteri nella tabella seguente, che sono tutti caratteri ASCII stampabili tranne gli ultimi tre caratteri di controllo spiegati sotto.

La colonna "Lettere" mostra i caratteri in modalità Lettera e "Figure" mostra i caratteri in modalità Figura:

Lettera  Figura  Codice       Lettera  Figura  Codice
-------  ------  ------       -------  ------  ------
   A       1     10000           P       +     11111
   B       8     00110           Q       /     10111
   C       9     10110           R       -     00111
   D       0     11110           S             00101
   E       2     01000           T             10101
   F             01110           U       4     10100
   G       7     01010           V       '     11101
   H             11010           W       ?     01101
   I             01100           X             01001
   J       6     10010           Y       3     00100
   K       (     10011           Z       :     11001
   L       =     11011           -       .     10001
   M       )     01011           ER      ER    00011
   N             01111           FS      SP    00010
   O       5     11100           SP      LS    00001
   /             11000

SP è il carattere Spazio " ".

Caratteri di controllo
----------------------
ER (ERase):
Cancella il carattere precedente.
Funziona allo stesso modo sia in modalità Lettera che Figura.

FS (Figure Shift):
Cambia il set di caratteri da Lettere a Figure.
Se il decoder è già in modalità Figura, FS viene trattato come uno Spazio (cioè SP nella colonna "Lettere").
In modalità Figura rimane in modalità Figura finché non viene ricevuto un carattere LS.

LS (Letter Shift):
Cambia il set di caratteri da Figure a Lettere.
Se il decoder è già in modalità Lettera, LS viene trattato come Spazio.
In modalità Lettera rimane in modalità Lettera finché non viene ricevuto un carattere FS.

Ipotesi
-------
1) All'inizio il decoder si trova in modalità Lettera.
2) La stringa di codice è corretta sia sintatticamente che semanticamente (per esempio, ER non può trovarsi all'inizio della stringa).

(setq lettere
      '("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "/"
        "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "-" "ER" "FS" "SP"))
(length lettere)
;-> 31

(setq figure
      '("1" "8" "9" "0" "2" "7" "6" "(" "=" ")" "5"
        "+" "/" "-" "4" "'" "?" "3" ":" "." "ER" "SP" "LS"))
(length figure)
;-> 23

(setq codice-lettere
      '("10000" "00110" "10110" "11110" "01000" "01110" "01010" "11010"
        "01100" "10010" "10011" "11011" "01011" "01111" "11100" "11000"
        "11111" "10111" "00111" "00101" "10101" "10100" "11101" "01101"
        "01001" "00100" "11001" "10001" "00011" "00010" "00001"))
(length codice-lettere)
;-> 31

(setq codice-figure
      '("10000" "00110" "10110" "11110" "01000" "01010" "10010" "10011"
        "11011" "01011" "11100" "11111" "10111" "00111" "10100" "11101" "01101"
        "00100" "11001" "10001" "00011" "00010" "00001"))
(length codice-figure)
;-> 23

(setq cod-let (map list codice-lettere lettere))
;-> (("10000" "A") ("00110" "B") ("10110" "C") ("11110" "D")
;->  ("01000" "E") ("01110" "F") ("01010" "G") ("11010" "H")
;->  ("01100" "I") ("10010" "J") ("10011" "K") ("11011" "L")
;->  ("01011" "M") ("01111" "N") ("11100" "O") ("11000" "/")
;->  ("11111" "P") ("10111" "Q") ("00111" "R") ("00101" "S")
;->  ("10101" "T") ("10100" "U") ("11101" "V") ("01101" "W")
;->  ("01001" "X") ("00100" "Y") ("11001" "Z") ("10001" "-")
;->  ("00011" "ER") ("00010" "FS") ("00001" "SP"))
(length cod-let)
;-> 31

(setq cod-fig (map list codice-figure figure))
;-> (("10000" "1") ("00110" "8") ("10110" "9") ("11110" "0")
;->  ("01000" "2") ("01010" "7") ("10010" "6") ("10011" "(")
;->  ("11011" "=") ("01011" ")") ("11100" "5") ("11111" "+")
;->  ("10111" "/") ("00111" "-") ("10100" "4") ("11101" "'")
;->  ("01101" "?") ("00100" "3") ("11001" ":") ("10001" ".")
;->  ("00011" "ER") ("00010" "SP") ("00001" "LS"))
(length cod-fig)
;-> 23

(setq let-cod (map list lettere codice-lettere))
;-> (("A" "10000") ("B" "00110") ("C" "10110") ("D" "11110")
;->  ("E" "01000") ("F" "01110") ("G" "01010") ("H" "11010")
;->  ("I" "01100") ("J" "10010") ("K" "10011") ("L" "11011")
;->  ("M" "01011") ("N" "01111") ("O" "11100") ("/" "11000")
;->  ("P" "11111") ("Q" "10111") ("R" "00111") ("S" "00101")
;->  ("T" "10101") ("U" "10100") ("V" "11101") ("W" "01101")
;->  ("X" "01001") ("Y" "00100") ("Z" "11001") ("-" "10001")
;->  ("ER" "00011") ("FS" "00010") ("SP" "00001"))
(length let-cod)
;-> 31

(setq fig-cod (map list figure codice-figure))
;-> (("1" "10000") ("8" "00110") ("9" "10110") ("0" "11110")
;->  ("2" "01000") ("7" "01010") ("6" "10010") ("(" "10011")
;->  ("=" "11011") (")" "01011") ("5" "11100") ("+" "11111")
;->  ("/" "10111") ("-" "00111") ("4" "10100") ("'" "11101")
;->  ("?" "01101") ("3" "00100") (":" "11001") ("." "10001")
;->  ("ER" "00011") ("SP" "00010") ("LS" "00001"))

(length fig-cod)
;-> 23

Funzione di decodifica:

(define (decode binary)
  (local (out bit stato ch)
    (setq out "")
    (setq bit (explode binary 5))
    ; stato iniziale: Figure
    ;00010 SP in cod-fig
    ;00001 SP in cod-let
    (setq stato "L")
    (dolist (b bit)
            ; stato: Lettera
      (cond ((= stato "L")
              ; carattere corrente
              (setq ch (lookup b cod-let))
              (cond
                ; ERasure: cancella ultimo carattere
                ((= ch "ER") (pop out -1))
                ; Letter Shift: Inserisce Spazio
                ((= ch "LS") (extend out " "))
                ; Figure Shift: Cambia stato
                ((= ch "FS") (setq stato "F"))
                ; SPace: Inserisce Spazio
                ((= ch "SP") (extend out " "))
                ; Inserisce carattere corrente
                (true (extend out ch))
              )
            );cond (L)
            ; stato: Figura
            ((= stato "F")
              ; carattere corrente
              (setq ch (lookup b cod-fig))
              (cond
                ; ERasure: cancella ultimo carattere
                ((= ch "ER") (pop out -1))
                ; Figure Shift: Inserisce Spazio
                ((= ch "FS") (extend out " "))
                ; Letter Shift: Cambia stato
                ((= ch "LS") (setq stato "L"))
                ; SPace: Inserisce Spazio
                ((= ch "SP") (extend out " "))
                ; Inserisce carattere corrente
                (true (extend out ch))
              )
            );cond (F)
      );cond (L/F)
    )
  out))

Proviamo:

(decode "001101000010100111101110010101")
;-> "BAUDOT"

(decode "01111010000110111011011000010111111"))
;-> NEWLISP

(decode
  "1011001100100001110000010100000001000001101100110010000111000001001000")
;-> "CIAO1 CIAO2"

(decode
  "0000100010100000001000001100000000100010100110000100110000010001001011")
;-> ( 1 A ( B ))

Funzione di codifica:

(define (encode str)
  (local (out lst len stato codice ch)
    (setq out "")
    (setq lst (explode str))
    (setq len (length lst))
    ; Controllo primo carattere
    (cond ((= (lst 0) " ") ; Spazio
           (setq stato "L")
           ; inserisce il codice Spazio
           (extend out "00001"))
          ; in quale set di codici si trova il carattere?
          ; Lettere
          ((lookup (lst 0) let-cod)
            (setq stato "L")
            (setq codice (lookup (lst 0) let-cod))
            (extend out codice))
          ; Figure
          ((lookup (lst 0) fig-cod)
            (setq stato "F")
            ; inserisce carattere che imposta il set Figure
            (extend out "00010") ; FS
            (setq codice (lookup (lst 0) fig-cod))
            (extend out codice))
    )
    ; ciclo sulla stringa di input
    (for (i 1 (- len 1))
      (setq ch (str i))
      (cond ((= ch " ") ; Spazio
             (if (= stato "L") (extend out "00001")
                 (= stato "F") (extend out "00010")))
            ; in quale set di codici si trova il carattere?
            ; Lettere
            ((lookup ch let-cod)
              (setq codice (lookup ch let-cod))
              ; controllo cambio stato
              ; e aggiornamento stringa di output
              (cond ((= stato "F")
                      (setq stato "L")
                      (extend out "00001")
                      (extend out codice))
                    ((= stato "L")
                       (extend out codice))))
            ; Figure
            ((lookup ch fig-cod)
              (setq codice (lookup ch fig-cod))
              ; controllo cambio stato
              ; e aggiornamento stringa di output
              (cond ((= stato "L")
                      (setq stato "F")
                      (extend out "00010")
                      (extend out codice))
                    ((= stato "F")
                       (extend out codice))))
      )
    )
    out))

Proviamo:

(encode "NEWLISP")
;-> "01111010000110111011011000010111111"
(decode (encode "NEWLISP"))
;-> NEWLISP

(encode "CIAO1 CIAO2")
;-> "1011001100100001110000010100000001000001101100110010000111000001001000"
(decode (encode "CIAO1 CIAO2"))
;-> "CIAO1 CIAO2"

(encode " 1 A (B )")
;-> "0000100010100000001000001100000000100010100110000100110000010001001011"
(decode (encode " 1 A (B )"))
;-> ( 1 A ( B ))


-------------------------------------
Codici ANSI ESCape (ESCAPE ANSI CODE)
-------------------------------------

;
; ESCape ANSI codes for text attribute
;
; (for REPL in Command Prompt (DOS) of Windows)
;
; *** COLORS ***
; Basic colors
(define _black "\027[0;30m")
(define _red "\027[0;31m")
(define _green "\027[0;32m")
(define _yellow "\027[0;33m")
(define _blue "\027[0;34m")
(define _magenta "\027[0;35m")
(define _cyan "\027[0;36m")
(define _white "\027[0;37m")
;
; Bright colors
(define _black-b "\027[0;90m")
(define _red-b "\027[0;91m")
(define _green-b "\027[0;92m")
(define _yellow-b "\027[0;93m")
(define _blue-b "\027[0;94m")
(define _magenta-b "\027[0;95m")
(define _cyan-b "\027[0;96m")
(define _white-b "\027[0;97m")
;
; Restore color to default
; 39 = foreground, 49 = background
(define _reset-cols "\027[39;49m")
;(println _reset-all)
;
; Restore all attribute to default
; 0 = normal attribute (ex. color),; 0 = extended attribute (ex. underline)
(define _reset-all "\027[0;0m")
;(println _reset-all)
;
; Table with 16 colors:
;(define _col16 '(_black _red _green _yellow _blue _magenta _cyan _white
;        black-b _red-b _green-b _yellow-b _blue-b _magenta-b _cyan-b _white-b))
; Print colors
;(dolist (c _col16) (println (eval c) { } c) )
;
; *** EFFECTS ***
; Underline
; ---------
(define _underline "\027[4m")
;
; Clear-screen: clear screen of REPL (and put cursor 0,0)
; -------------------------------------------------------
(define (cls) (print "\027[H\027[2J"))

;
; Change the color (0..255) of terminal foreground (text)
; -------------------------------------------------------
(define (_fore color) (print (string "\027[38;5;" color "m")))
;
; Change the color (0..255) of terminal background
; ------------------------------------------------
(define (_back color) (print (string "\027[48;5;" color "m")))
;
; Examples:
;(for (i 0 255) (print (_fore i) i { }))
;(for (i 0 255) (print (_fore i) "█"))
;(for (i 0 255) (print (_fore i) "█" "(" i ") "))
;(for (i 0 255) (print (_fore i) "██" "(" i ") "))
;(println _green-b "Verde brillante" _reset-all)
;(println _red-b _underline "Rosso brillante sottolineato" _reset-all)
;(println (_back 220) (_fore 45) "Celeste su sfondo giallo" _reset-all)
;
; See "ANSI-colors.png" in "data" folder:
;(for (i 0 255) 
;  (print (_fore i) "██" "(" (format "%03d" i) ") ")
;  (if (zero? (% i 15)) (println)))

Vedi anche "Codici ansi escape" su "newLISP in generale".


--------------
Funzione matta
--------------

Scrivere una funzione che restituisce tutti i suoi caratteri in modo casuale.

(define (auto-random)
  (let (src (source 'auto-random))
    ;(replace "\r\n" src "")
    (setq src (explode src))
    (println (join src))
    (join (randomize src))))

(auto-random)
;-> (define (auto-random )
;->   (let (src (source 'auto-random))
;->    (setq src (explode src))
;->    (println (join src))
;->    (join (randomize src))))
;-> 
;-> "(()zca\rucjr)(\rdnuieo  cs(er) r s)oir(oioq\r a)n(\rno ednn)rtu
;-> (e\r(\nid)\n \n\n  olxrnc e(plc'sr -d\norn  n e\r)tt  sm eo-s f
;->   ed(am  l )ci\n)arrtt(j o)pamss  "


-----------------------------------------------------
Numeri interi come somma o differenza di due quadrati
-----------------------------------------------------

Dato un intero positivo N, trovare tutte le coppie di interi positivi (a,b) tali che:

  (a^2 + b^2 = N) oppure (a^2 - b^2 = N)

Funzione che verifica se un numero intero è un quadrato perfetto:

(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(square? 16)
;-> true
(square? 12)
;-> nil

(define (coppie N)
  (local (out1 out2 b1 b2)
    (setq out1 '())
    (setq out2 '())
    (for (a 0 (+ (int (sqrt N)) 1))
      ; caso della somma: a^2 + b^2
      (setq b1 (- N (* a a)))
      (if (and (>= b1 0) (square? b1))
          (push (list a (sqrt b1)) out1 -1)
      )
      ; caso della differenza: a^2 - b^2
      (setq b2 (- (* a a) N))
      (if (and (>= b2 0) (square? b2))
          (push (list a (sqrt b2)) out2 -1)
      )
    )
    ; test solutions
    (define (t1 a b) (+ (* a a) (* b b)))
    (define (t2 a b) (- (* a a) (* b b)))
    (dolist (el out1)
      (if (!= N (t1 (el 0) (el 1)))
          (println "Errore(+): " a { } b))
    )
    (dolist (el out2)
      (if (!= N (t2 (el 0) (el 1)))
          (println "Errore(-): " a { } b))
    )
    (list out1 out2)))

Proviamo:

(coppie 9)
;-> (((0 3) (3 0)) ((3 0)))

(coppie 16)
;-> (((0 4) (4 0)) ((4 0) (5 3)))

Dividiamo in due funzioni distinte:

1) caso della somma (a^2 + b^2)

(define (coppie-somma N)
  (local (out1 b1)
    (setq out1 '())
    (for (a 0 (+ (int (sqrt N)) 1))
      ; caso della somma: a^2 + b^2
      (setq b1 (- N (* a a)))
      (if (and (>= b1 0) (square? b1))
          (push (list a (sqrt b1)) out1 -1)
      )
    )
    ; test solutions
    (define (t1 a b) (+ (* a a) (* b b)))
    (dolist (el out1)
      (if (!= N (t1 (el 0) (el 1)))
          (println "Errore(+): " a { } b))
    )
    list out1))

(coppie-somma 9)
;-> ((0 3) (3 0))
(coppie-somma 16)
;-> ((0 4) (4 0))

Vediamo quanti modi di rappresentazione (a^2 + b^2) hanno i numeri da 0 a N:

Sequenza OEIS A000925:
Number of ordered ways of writing n as a sum of 2 squares of nonnegative integers.
  1, 2, 1, 0, 2, 2, 0, 0, 1, 2, 2, 0, 0, 2, 0, 0, 2, 2, 1, 0, 2, 0, 0, 0,
  0, 4, 2, 0, 0, 2, 0, 0, 1, 0, 2, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 0, 0,
  0, 2, 3, 0, 2, 2, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 2, 4, 0, 0, 2, 0, 0, 0,
  1, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 4, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0,
  0, 2, 1, 0, 4, ...

(define (coppie-plus N)
  (local (coppie b1)
    (setq coppie 0)
    (for (a 0 (+ (int (sqrt N)) 1))
      ; caso della somma: a^2 + b^2
      (setq b1 (- N (* a a)))
      (if (and (>= b1 0) (square? b1)) (++ coppie))
    )
    coppie))

Proviamo:

(map coppie-plus (sequence 0 20))
;-> (1 2 1 0 2 2 0 0 1 2 2 0 0 2 0 0 2 2 1 0 2)

2) caso della differenza (a^2 - b^2)

(define (coppie-diff N)
  (local (out2 b2)
    (setq out2 '())
    (for (a 0 (+ (int (sqrt N)) 1))
      ; caso della differenza: a^2 - b^2
      (setq b2 (- (* a a) N))
      (if (and (>= b2 0) (square? b2))
          (push (list a (sqrt b2)) out2 -1)
      )
    )
    ; test solutions
    (define (t2 a b) (- (* a a) (* b b)))
    (dolist (el out2)
      (if (!= N (t2 (el 0) (el 1)))
          (println "Errore(-): " a { } b))
    )
    out2))

(coppie-diff 9)
;-> ((3 0))
(coppie-diff 16)
;-> ((4 0) (5 3))

Vediamo quanti modi di rappresentazione (a^2 - b^2) hanno i numeri da 0 a N:

(define (coppie-minus N)
  (local (coppie b2)
    (setq coppie 0)
    (for (a 0 (+ (int (sqrt N)) 1))
      (setq b2 (- (* a a) N))
      (if (and (>= b2 0) (square? b2)) (++ coppie))
    )
    coppie))

Proviamo:

(map coppie-minus (sequence 0 20))
;-> (2 1 0 1 1 1 0 0 1 1 0 0 1 0 0 1 2 0 0 0 0)


---------------------
Multipli di un numero
---------------------

Dato un numero intero positivo N, scrivere la funzione più corta possibile per restituire i primi K multipli di N (N compreso).

; 39 caratteri
;(define (m n k) (sequence n (* n k) n))

; 35 caratteri
(define(m n k)(sequence n(* n k)n))

Proviamo:

(m 2 10)
;-> (2 4 6 8 10 12 14 16 18 20)

(m 5 12)
;-> (5 10 15 20 25 30 35 40 45 50 55 60)

(m 12 8)
;-> (12 24 36 48 60 72 84 96)


---------------
0, 1 e decimali
---------------

Dati due numeri interi Z e U (0 < (Z + U) <= 16), che rappresentano rispettivamente il numero di zeri (0) e di uno (1), generare tutti i possibili equivalenti decimali dei numeri binari creati utilizzando solo gli zeri e gli uno dati.

Per esempio:

  Z = 1, U = 1
  bin    dec
  01 --> 1
  10 --> 2
  Output = (1 2)

  Z = 3, U = 2
  bin       dec
  00011 -->  3  
  00101 -->  5  
  00110 -->  6  
  01001 -->  9  
  01010 --> 10 
  01100 --> 12 
  10001 --> 17 
  10010 --> 18 
  10100 --> 20 
  11000 --> 24 
  Output = (3 5 6 9 10 12 17 18 20 24)

Tutti i numeri positivi binari con Z zeri e U uno sono chiaramente minori di 2^(Z+U), poiché la rappresentazione binaria di quest'ultimo ha (Z + U + 1) cifre.
Quindi iteriamo gli interi nell'intervallo [0, 2^(Z+U)-1] e manteniamo tutti gli interi n che hanno U unità.
Poiché n < 2^(Z+U), questo può essere rappresentato con Z (o meno) zeri.

(define (find-decimal a b)
  (let (out '())
    (for (i 1 (- (pow 2 (+ a b)) 1))
      (if (= (length (find-all "1" (bits i))) b)
        (begin
          ;(println i { } (bits i))
          (push i out -1)
        )
      )
    )
  out))

Proviamo:

(find-decimal 1 1)
;-> (1 2)
(find-decimal 3 2)
;-> (3 5 6 9 10 12 17 18 20 24)
(find-decimal 5 5)
;-> (31 47 55 59 61 62 79 87 91 93 94 103 107 109 110 115 117 118 121
;->  122 124 143 151 155 157 158 167 171 173 174 179 181 182 185 186 188
;->  199 203 205 206 211 213 214 217 218 220 227 229 230 233 234 236 241
;->  242 244 248 271 279 283 285 286 295 299 301 302 307 309 310 313 314
;->  316 327 331 333 334 339 341 342 345 346 348 355 357 358 361 362 364
;->  369 370 372 376 391 395 397 398 403 405 406 409 410 412 419 421 422
;->  425 426 428 433 434 436 440 451 453 454 457 458 460 465 466 468 472
;->  481 482 484 488 496 527 535 539 541 542 551 555 557 558 563 565 566
;->  569 570 572 583 587 589 590 595 597 598 601 602 604 611 613 614 617
;->  618 620 625 626 628 632 647 651 653 654 659 661 662 665 666 668 675
;->  677 678 681 682 684 689 690 692 696 707 709 710 713 714 716 721 722
;->  724 728 737 738 740 744 752 775 779 781 782 787 789 790 793 794 796
;->  803 805 806 809 810 812 817 818 820 824 835 837 838 841 842 844 849
;->  850 852 856 865 866 868 872 880 899 901 902 905 906 908 913 914 916
;->  920 929 930 932 936 944 961 962 964 968 976 992)


------------------
BubbleSort visuale
------------------

Vedi anche "BubbleSort" su "Funzioni varie".

Funzione di base del BubbleSort:

(define (bubbleSort lst)
  (local (len cambio)
    (setq len (length lst))
    (setq cambio true)
    (while cambio
      (setq cambio nil)
      (for (i 1 (- len 1))
        (cond ((< (lst i) (lst (- i 1)))
               (swap (lst i) (lst (- i 1)))
               (setq cambio true))
        )
      )
      (-- j)
    )
  )
  lst)

(bubbleSort '(5 10 9 8 7 8 6 7 5 4 3 4 5))
;-> (3 4 4 5 5 5 6 7 7 8 8 9 10)

(bubbleSort (randomize (sequence 1 20)))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)

Funzione che visualizza l'algoritmo del BubbleSort:

(define (bs lst)
  (local (iter len cambio)
    (setq iter 0)
    (setq len (length lst))
    (setq cambio true)
    (while cambio
      (++ iter)
      (println "Iterazione: " iter)
      (println "Lista: " lst)
      (setq cambio nil)
      (for (i 1 (- len 1))
        (cond ((< (lst i) (lst (- i 1)))
               (print (lst i) " < " (lst (- i 1)) " --> scambio: ")
               (println "lista(" i ")=" (lst i) " e lista(" (- i 1) ")=" (lst (- i 1)))
               (swap (lst i) (lst (- i 1)))
               (print lst )(read-line)
               (setq cambio true))
        )
      )
      (-- j)
    )
    (println "Nessuno scambio --> lista ordinata")
  lst))

Proviamo:

(setq a '(4 6 3 8 2 9 1))
(bs a)
;-> Iterazione: 1
;-> Lista: (4 6 3 8 2 9 1)
;-> 3 < 6 --> scambio: lista(2)=3 e lista(1)=6
;-> (4 3 6 8 2 9 1)
;-> 2 < 8 --> scambio: lista(4)=2 e lista(3)=8
;-> (4 3 6 2 8 9 1)
;-> 1 < 9 --> scambio: lista(6)=1 e lista(5)=9
;-> (4 3 6 2 8 1 9)
;-> Iterazione: 2
;-> Lista: (4 3 6 2 8 1 9)
;-> 3 < 4 --> scambio: lista(1)=3 e lista(0)=4
;-> (3 4 6 2 8 1 9)
;-> 2 < 6 --> scambio: lista(3)=2 e lista(2)=6
;-> (3 4 2 6 8 1 9)
;-> 1 < 8 --> scambio: lista(5)=1 e lista(4)=8
;-> (3 4 2 6 1 8 9)
;-> Iterazione: 3
;-> Lista: (3 4 2 6 1 8 9)
;-> 2 < 4 --> scambio: lista(2)=2 e lista(1)=4
;-> (3 2 4 6 1 8 9)
;-> 1 < 6 --> scambio: lista(4)=1 e lista(3)=6
;-> (3 2 4 1 6 8 9)
;-> Iterazione: 4
;-> Lista: (3 2 4 1 6 8 9)
;-> 2 < 3 --> scambio: lista(1)=2 e lista(0)=3
;-> (2 3 4 1 6 8 9)
;-> 1 < 4 --> scambio: lista(3)=1 e lista(2)=4
;-> (2 3 1 4 6 8 9)
;-> Iterazione: 5
;-> Lista: (2 3 1 4 6 8 9)
;-> 1 < 3 --> scambio: lista(2)=1 e lista(1)=3
;-> (2 1 3 4 6 8 9)
;-> Iterazione: 6
;-> Lista: (2 1 3 4 6 8 9)
;-> 1 < 2 --> scambio: lista(1)=1 e lista(0)=2
;-> (1 2 3 4 6 8 9)
;-> Iterazione: 7
;-> Lista: (1 2 3 4 6 8 9)
;-> Nessuno scambio --> lista ordinata
;-> (1 2 3 4 6 8 9)

(setq b '(4 3 2 1))
(bs b)
;-> Iterazione: 1
;-> Lista: (4 3 2 1)
;-> 3 < 4 --> scambio: lista(1)=3 e lista(0)=4
;-> (3 4 2 1)
;-> 2 < 4 --> scambio: lista(2)=2 e lista(1)=4
;-> (3 2 4 1)
;-> 1 < 4 --> scambio: lista(3)=1 e lista(2)=4
;-> (3 2 1 4)
;-> Iterazione: 2
;-> Lista: (3 2 1 4)
;-> 2 < 3 --> scambio: lista(1)=2 e lista(0)=3
;-> (2 3 1 4)
;-> 1 < 3 --> scambio: lista(2)=1 e lista(1)=3
;-> (2 1 3 4)
;-> Iterazione: 3
;-> Lista: (2 1 3 4)
;-> 1 < 2 --> scambio: lista(1)=1 e lista(0)=2
;-> (1 2 3 4)
;-> Iterazione: 4
;-> Lista: (1 2 3 4)
;-> Nessuno scambio --> lista ordinata
;-> (1 2 3 4)

(setq c '(1 2 3 4))
(bs c)
;-> Iterazione: 1
;-> Lista: (1 2 3 4)
;-> Nessuno scambio --> lista ordinata
;-> (1 2 3 4)


--------------------------------------
slice all (sottoliste e sottostringhe)
--------------------------------------

Data una lista (o una stringa), generare tutte le sottoliste (sottostringhe) contigue:

  lista (a1, a2, ... an)
  sottoliste contigue:
  (a1) (a1 a2) ... (a1 a2 ... an)
  (a2) (a2 a3) ... (a2 ... an)
  ...
  (an)

Per esempio:

  lista = (1 2 3 4)
  Output:
  (1) (12) (123) (1234)
  (2) (23) (234)
  (3) (34)
  (4)

In pratica si tratta di effettuare ogni "slice" possibile della lista (stringa):

Prima riga:
(slice 0 1)
(slice 0 2)
...
(slice 0 n)

Seconda riga:
(slice 1 1)
(slice 1 2)
...
(slice 1 n)

I-esima riga:
(slice i 1)
(slice i 2)
...
(slice i n)

N-esima riga:
(slice n 1)

Possiamo scrivere una funzione unica che si applica sia alle liste che alle stringhe.

Funzione che genera tutte le sottoliste (sottostringhe) contigue:

(define (slice-all obj)
  (let ( (out '()) (len (length obj)) )
    (for (i 0 (- len 1))
      (for (j 1 (- len i))
        (push (slice obj i j) out -1)
      )
    )
    out))

Proviamo:

(slice-all "1234")
;-> ("1" "12" "123" "1234" "2" "23" "234" "3" "34" "4")
(slice-all '(1 2 3 4))
;-> ((1) (1 2) (1 2 3) (1 2 3 4) (2) (2 3) (2 3 4) (3) (3 4) (4))

(length (slice-all "1234"))
;-> 10
(length (slice-all "12345"))
;-> 15
(length (slice-all "123456"))
;-> 21
(length (slice-all "1234567"))
;-> 28
(length (slice-all "1234567"))

Nota: il numero delle sottoliste/sottostringhe è dato dalla somma dei numeri da 1 fino alla lunghezza della lista/stringa iniziale:

  lunghezza-output = Sum[1..lunghezza-input] = 
  = (lunghezza-input*(lunghezza-input+1))/2


-----------------
Numeri segmentati
-----------------

I numeri segmentati (OEIS A002048) è la sequenza di numeri tale che ciascun membro è il più piccolo numero positivo (maggiore di zero) che non può essere composto da una somma di numeri consecutivi precedenti, partendo con a(0) = 1.

Sequenza OEIS: A002048
  1, 2, 4, 5, 8, 10, 14, 15, 16, 21, 22, 25, 26, 28, 33, 34, 35, 36, 38,
  40, 42, 46, 48, 49, 50, 53, 57, 60, 62, 64, 65, 70, 77, 80, 81, 83, 85,
  86, 90, 91, 92, 100, 104, 107, 108, 116, 119, 124, 127, 132, 133, 137,
  141, 144, 145, 148, 150, 151, 154, 158, 159, 163, 165, ...

Esempio
  a(0) = 1
  a(1) = 2
  a(2) = 4 (perchè 3 può essere formato con 1 + 2)
  a(3) = 5
  a(4) = 8 (perchè 6=2+4 e 7=1+2+4)
  a(5) = 10 (perchè 9=4+5)
  a(6) = 14 (perchè 11=2+4+5, 12=1+2+4+5 e 13=5+8)
  ...

Funzione che calcola tutte le sottoliste contigue:

(define (slice-all obj)
  (let ( (out '()) (len (length obj)) )
    (for (i 0 (- len 1))
      (for (j 1 (- len i))
        (push (slice obj i j) out -1)
      )
    )
    out))

(slice-all '(1 2 4))
;-> ((1) (1 2) (1 2 4) (2) (2 4) (4))

(map (fn(x) (apply + x)) (slice-all '(1 2 4)))
;-> (1 3 7 2 6 4)

(define (segmentati limite)
  (local (out somme max-somme new-value)
    (setq out '(1))
    (for (i 1 (- limite 1))
      ; calcola tutte le somme possibili con gli elementi della lista out
      (setq somme (map (fn(x) (apply + x)) (slice-all out)))
      ; trova il valore massimo delle somme
      (setq max-somma (apply max somme))
      ; per trovare il nuovo valore da inserire nella sequenza
      ; calcoliamo la differenza tra la sequenza (1...(max-somma+1)) e
      ; la lista delle somme.
      ; Il primo numero della differenza è il nuovo valore da inserire
      (setq new-value (first (difference (sequence 1 (+ max-somma 1)) somme)))
      (push new-value out -1)
      ;(println new-value)
      ;(print out) (read-line)
    )
    out))

Proviamo:

(segmentati 10)
;-> (1 2 4 5 8 10 14 15 16 21)

(segmentati 100)
;-> (1 2 4 5 8 10 14 15 16 21 22 25 26 28 33 34 35 36 38 40 42 46 48 49
;->  50 53 57 60 62 64 65 70 77 80 81 83 85 86 90 91 92 100 104 107 108
;->  116 119 124 127 132 133 137 141 144 145 148 150 151 154 158 159 163
;->  165 172 173 174 175 178 180 182 184 187 188 195 198 201 206 207 208
;->  213 219 221 222 226 228 231 233 236 241 242 245 247 248 253 256 262
;->  266 268 272 274)

Nota: Senza il requisito che le somme siano formate solo con i termini minori consecutivi, la sequenza diventa la sequenza delle potenze di 2 (Sequenza OEIS: A000079).

La funzione è lenta.

(time (segmentati 100))
;-> 403.305

(time (segmentati 150))
;-> 4100.817

(time (segmentati 200))
;-> 20690.252

Vediamo una implementazione in C fornita da Samuel B. Reid:

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char **argv)
{
  if (argc == 2) {
    uint64_t max = strtoull(argv[1], NULL, 10);
    uint64_t *terms = calloc((((max + 1) >> 6) + 1), sizeof(*terms));
    for (uint64_t i = 1; i <= max; i++) {
      if (!((terms[i >> 6] >> (i & 0x3F)) & 1)) {
        printf("%lu ", i);
        uint64_t total = i;
        for (uint64_t j = i - 1; j >= 1; j--) {
          if (!((terms[j >> 6] >> (j & 0x3F)) & 1)) {
            total += j;
            if (total > max) {
              break;
            }
            terms[total >> 6] |= (1ULL << (total & 0x3F));
          }
        }
      }
    }
    free(terms);
  }
  printf("\n");
  return 0;
}


----------------------------------------
Poligoni costruibili con riga e compasso
----------------------------------------

Un n-gono costruibile è un poligono regolare con n lati che è possibile utilizzando solo un compasso e un righello non contrassegnato.

Gauss ha dimostrato che l'unico n per cui un n-gono è costruibile è un prodotto di un numero qualsiasi di numeri primi di Fermat distinti e una potenza di 2 (cioè n=2^k*p1*p2*... con k essendo un numero intero e ogni p(i) un primo di Fermat distinto).

Un primo di Fermat è un numero primo che può essere espresso come 2^(2^𝑛) + 1 con n un intero positivo.
Gli unici primi di Fermat conosciuti sono per n=0,1,2,3 e 4.

Inoltre risulta che un poligono con n lati è costruibile se il toziente di n è una potenza di 2.

Scrivere una funzione che genera la sequenza dei lati dei poligoni che sono costruibili.

Sequenza OEIS: A003401
Numbers of edges of regular polygons constructible with ruler and compass.
  1, 2, 3, 4, 5, 6, 8, 10, 12, 15, 16, 17, 20, 24, 30, 32, 34, 40, 48, 51,
  60, 64, 68, 80, 85, 96, 102, 120, 128, 136, 160, 170, 192, 204, 240, 255,
  256, 257, 272, 320, 340, 384, 408, 480, 510, 512, 514, 544, 640, 680, 768,
  771, 816, 960, 1020, 1024, 1028, 1088, 1280, 1285, ...

(define (totient num)
"Calculates the eulero totient of a given number"
  (if (= num 1) 1
    (let (res num)
      (dolist (f (unique (factor num)))
        (setq res (- res (/ res f))))
      res)))

(define (power-of-2? num)
"Checks if an integer is a power of 2"
  (zero? (& num (- num 1))))

(define (sides limite)
  (let (out '(1 2))
    (for (i 3 limite)
      (if (power-of-2? (totient i)) (push i out -1))
    )
    out))

Proviamo:

(sides 200)
;-> (1 2 3 4 5 6 8 10 12 15 16 17 20 24 30 32 34 40 48 51 60 
;->  64 68 80 85 96 102 120 128 136 160 170 192)


-------------------------
Caratteri con matrice 5x5
-------------------------

Funzione che genera i caratteri maiuscoli con matrici 5x5:

(define (load-data)
  (setq a '((0 0 1 0 0) (0 1 0 1 0) (1 0 0 0 1) (1 1 1 1 1) (1 0 0 0 1)))
  (setq b '((1 1 1 1 0) (1 0 0 0 1) (1 1 1 1 0) (1 0 0 0 1) (1 1 1 1 0)))
  (setq c '((0 1 1 1 1) (1 0 0 0 0) (1 0 0 0 0) (1 0 0 0 0) (0 1 1 1 1)))
  (setq d '((1 1 1 1 0) (1 0 0 0 1) (1 0 0 0 1) (1 0 0 0 1) (1 1 1 1 0)))
  (setq e '((1 1 1 1 1) (1 0 0 0 0) (1 1 1 0 0) (1 0 0 0 0) (1 1 1 1 1)))
  (setq f '((1 1 1 1 1) (1 0 0 0 0) (1 1 1 0 0) (1 0 0 0 0) (1 0 0 0 0)))
  (setq g '((0 1 1 1 1) (1 0 0 0 0) (1 0 0 1 1) (1 0 0 0 1) (0 1 1 1 1)))
  (setq h '((1 0 0 0 1) (1 0 0 0 1) (1 1 1 1 1) (1 0 0 0 1) (1 0 0 0 1)))
  (setq i '((1 1 1 1 1) (0 0 1 0 0) (0 0 1 0 0) (0 0 1 0 0) (1 1 1 1 1)))
  (setq j '((1 1 1 1 1) (0 0 0 1 0) (0 0 0 1 0) (1 0 0 1 0) (0 1 1 0 0)))
  (setq k '((1 0 0 0 1) (1 0 0 1 0) (1 1 1 0 0) (1 0 0 1 0) (1 0 0 0 1)))
  (setq l '((1 0 0 0 0) (1 0 0 0 0) (1 0 0 0 0) (1 0 0 0 0) (1 1 1 1 1)))
  (setq m '((1 0 0 0 1) (1 1 0 1 1) (1 0 1 0 1) (1 0 0 0 1) (1 0 0 0 1)))
  (setq n '((1 0 0 0 1) (1 1 0 0 1) (1 0 1 0 1) (1 0 0 1 1) (1 0 0 0 1)))
  (setq o '((0 1 1 1 0) (1 0 0 0 1) (1 0 0 0 1) (1 0 0 0 1) (0 1 1 1 0)))
  (setq p '((1 1 1 1 0) (1 0 0 0 1) (1 1 1 1 0) (1 0 0 0 0) (1 0 0 0 0)))
  (setq q '((0 1 1 1 0) (1 0 0 0 1) (1 0 1 0 1) (1 0 0 1 0) (0 1 1 0 1)))
  (setq r '((1 1 1 1 0) (1 0 0 0 1) (1 1 1 1 0) (1 0 0 0 1) (1 0 0 0 1)))
  (setq s '((0 1 1 1 1) (1 0 0 0 0) (0 1 1 1 0) (0 0 0 0 1) (1 1 1 1 0)))
  (setq t '((1 1 1 1 1) (0 0 1 0 0) (0 0 1 0 0) (0 0 1 0 0) (0 0 1 0 0)))
  (setq u '((1 0 0 0 1) (1 0 0 0 1) (1 0 0 0 1) (1 0 0 0 1) (0 1 1 1 0)))
  (setq v '((1 0 0 0 1) (1 0 0 0 1) (1 0 0 0 1) (0 1 0 1 0) (0 0 1 0 0)))
  (setq w '((1 0 0 0 1) (1 0 0 0 1) (1 0 1 0 1) (1 1 0 1 1) (1 0 0 0 1)))
  (setq x '((1 0 0 0 1) (0 1 0 1 0) (0 0 1 0 0) (0 1 0 1 0) (1 0 0 0 1)))
  (setq y '((1 0 0 0 1) (0 1 0 1 0) (0 0 1 0 0) (0 0 1 0 0) (0 0 1 0 0)))
  (setq z '((1 1 1 1 1) (0 0 0 1 0) (0 0 1 0 0) (0 1 0 0 0) (1 1 1 1 1)))
  (setq lst '(a b c d e f g h i j k l m n o p q r s t u v w x y z))
  (setq link (map (fn(ch) (list $idx (eval ch))) lst)))

Funzione che stampa una matrice (caratteri):

(define (print-matrix matrix ch)
  (setq rows (length matrix))
  (setq cols (length (matrix 0)))
  (for (r 0 (- rows 1))
    (for (c 0 (- cols 1))
      (if (= (matrix r c) 1) 
          (print ch)
          ;else
          (print " ")
      )
    )
    (println)
  )
  '>)

Funzione che crea la matrice di caratteri di una stringa:

(define (string-matrix str spaces)
  (local (len out cur-row idx)
    (load-data)
    (setq str (upper-case str))
    (setq len (length str))
    (setq out '())
    (for (r 0 4)
      (setq cur-row '())
      (for (k 0 (- len 1))
        (setq idx (- (char (str k)) (char "A")))
        ;(println idx)
        ;(print (lookup idx link)) (read-line)
        (extend cur-row ((lookup idx link) r) (dup 0 spaces))
      )
      (push cur-row out -1)
    )
    out))

Proviamo:

(print-matrix (string-matrix "newlisp" 2) "*")
;-> *   *  *****  *   *  *      *****   ****  ****
;-> **  *  *      *   *  *        *    *      *   *
;-> * * *  ***    * * *  *        *     ***   ****
;-> *  **  *      ** **  *        *        *  *
;-> *   *  *****  *   *  *****  *****  ****   *

(print-matrix (string-matrix "newlisp" 2) "■")
;-> ■   ■  ■■■■■  ■   ■  ■      ■■■■■   ■■■■  ■■■■
;-> ■■  ■  ■      ■   ■  ■        ■    ■      ■   ■
;-> ■ ■ ■  ■■■    ■ ■ ■  ■        ■     ■■■   ■■■■
;-> ■  ■■  ■      ■■ ■■  ■        ■        ■  ■
;-> ■   ■  ■■■■■  ■   ■  ■■■■■  ■■■■■  ■■■■   ■

(print-matrix (string-matrix "newlisp" 2) "█")
;-> █   █  █████  █   █  █      █████   ████  ████
;-> ██  █  █      █   █  █        █    █      █   █
;-> █ █ █  ███    █ █ █  █        █     ███   ████
;-> █  ██  █      ██ ██  █        █        █  █
;-> █   █  █████  █   █  █████  █████  ████   █


------------------------------------------------
Rettangolo minimo di inclusione di circonferenze
------------------------------------------------

Dato una lista di circonferenze (centro e raggio), generare le coordinate del rettangolo più piccolo che contiene tutti le circonferenze.

    ul (x-min y-max)                   ur (x-max y-max)
     +---------------------------------+              
     |             |                   | 
     |    |      --+--                 |
     |    |        | C2        |       |
     |----+----                |       |
     |    | C1                 |       |
     |    |             -------+-------|
     |                         | C3    |
     |                         |       |
     |                         |       |
     +---------------------------------+
    ll (x-min y-min)                   lr (x-max y-min)

(define (circle-xmax x y r) (list (sub x r) (add x r)))
(define (circle-ymax x y r) (list (sub y r) (add y r)))

lista = ((x1 y1 r1) (x2 y2 r2) ... (xn yn rn))

(setq lst '((0 0 5) (4 4 4) (2 2 2)))
(apply circle-xmax '(0 0 5))
;-> (-5 5)
(apply circle-ymax '(4 4 4))
;-> (0 8)

Funzione che calcola il rettangolo che include tutti i cerchi:

(define (rect-all lst ll ul ur lr area)
  (local (x-ccord y-coord x-max y-max x-min x-y-min)
    (setq x-coord (map (fn(z) (apply circle-xmax z)) lst))
    (setq y-coord (map (fn(z) (apply circle-ymax z)) lst))
    (setq x-coord (flat x-coord))
    (setq y-coord (flat y-coord))
    (setq x-max (apply max x-coord))
    (setq y-max (apply max y-coord))
    (setq x-min (apply min x-coord))
    (setq y-min (apply min y-coord))  
    ; lower-left
    (setq ll (list x-min y-min))
    ;upper-left
    (setq ul (list x-min y-max))
    ; upper-right
    (setq ur (list x-max y-max))
    ; lower-right
    (setq lr (list x-max y-min))
    (setq area (mul (sub x-max x-min) (sub y-max y-min)))
    (list area ll ul ur lr)))

Proviamo:

(rect-all lst)
;-> (169 (-5 -5) (-5 8) (8 8) (8 -5))

(rect-all '((-1 -1 5) (0 0 12) (-5 -3 8)))
;-> (600 (-13 -12) (-13 12) (12 12) (12 -12))

Nota: se le circonferenze sono libere di muoversi, allora ci troviamno di fronte ad un problema  "quadratically-constrained quadratic program" e trovare l'ottimo globale per un QCQP non convesso è NP-hard.
Per problemi di questo tipo possiamo utilizzare il programma free "SCIP", disponibile al seguente indirizzo web: https://www.scipopt.org/.
"SCIP is currently one of the fastest non-commercial solvers for mixed integer programming (MIP) and mixed integer nonlinear programming (MINLP). 
It is also a framework for constraint integer programming and branch-cut-and-price.
It allows for total control of the solution process and the access of detailed information down to the guts of the solver."


---------------------------------------------
Conversione da stringa numerica a big-integer
---------------------------------------------

Per convertire una stringa numerica in un numero intero possiamo usare la funzione "int".
Per esempio:

(int "3652")
;-> 3652

Purtroppo la funzione int non si applica ai numeri big-integer:

(int "34585725372834572357423475")
;-> -1

Scriviamo una funzione che converte una stringa numerica in big-integer:

(define (string-int str)
"Convert a numeric string to big-integer"
  (let (num 0L)
    (cond ((= (str 0) "-")
            (pop str)
            (dolist (el (explode str)) (setq num (+ (* num 10) (int el))))
            (* num -1))
          (true 
            (dolist (el (explode str)) (setq num (+ (* num 10) (int el))))))))

Proviamo:

(string-int "3652")
;-> 3652L
(integer? 3652L)
;-> true
(bigint? 3652L)
;-> true

(string-int "34585725372834572357423475")
;-> 34585725372834572357423475L
(integer? 34585725372834572357423475L)
;-> true
(bigint? 34585725372834572357423475L) 
;-> true

Per convertire un big-integer in intero (se possibile) possiamo usare la seguente funzione:

(define (bigint-int num)
  (let ( (MAX-INT 9223372036854775807) (MIN-INT -9223372036854775808) )
    (if (or (< num MIN-INT) (> num MAX-INT))
        num
        (+ 0 num))))

Proviamo:

(bigint-int 3652L)
;-> 3652

(bigint-int 34585725372834572357423475L)
;-> 34585725372834572357423475L


-----------------
Numeri biografici
-----------------

I numeri biografici sono numeri che descrivono un numero.
Vediamo come funziona il processo di descrizione di un numero:
  Per ogni cifra da 0 a 9 presente nel numero,
  prendere la frequenza di quella cifra e poi la cifra.

Per esempio:
  N = 102422
  cifra   frequenza   sequenza
    0        1        10
    1        1        11
    2        3        32
    4        1        14
  Output = 10113214

Altri esempi:
  0 --> Uno 0 --> 10
  1 --> Un 1 --> 11
  2 --> Un 2 --> 12
  ...
  30 --> Un 3 e Uno 0 --> 1013 (ordine crescente delle cifre del numero)

Sequenza OEIS: A047842
Describe n (count digits in order of increasing value, ignoring missing digits)
  10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 1011, 21, 1112, 1113, 1114, 1115,
  1116, 1117, 1118, 1119, 1012, 1112, 22, 1213, 1214, 1215, 1216, 1217, 1218,
  1219, 1013, 1113, 1213, 23, 1314, 1315, 1316, 1317, 1318, 1319, 1014, 1114,
  1214, 1314, 24, 1415, 1416, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che "descrive" un numero:

(define (descrizione num)
  (local (lst uniq conta coppie out)
    (setq lst (sort (int-list num)))
    ; cifre uniche
    (setq uniq (unique lst))
    ; conta la frequenza delle cifre uniche
    (setq conta (count uniq lst))
    ; crea la lista delle coppie frequenza-cifra
    (setq coppie (flat (map list conta uniq)))
    ; unisce le coppie in un unica stringa
    (setq out (join (map string coppie)))
    ; rimuove eventuali "L" per i big-integer
    (replace "L" out "")))

Nota: MAX-INT = 9223372036854775807

Proviamo:

(descrizione 102422)
;-> "10113214"

(descrizione 30)
;-> "1013"

(descrizione 12345678901234567890)
;-> "20212223242526272829"
     
(map descrizione (sequence 1 50))
;-> ("11" "12" "13" "14" "15" "16" "17" "18" "19" "1011" "21" "1112" "1113"
;->  "1114" "1115" "1116" "1117" "1118" "1119" "1012" "1112" "22" "1213"
;->  "1214" "1215" "1216" "1217" "1218" "1219" "1013" "1113" "1213" "23"
;->  "1314" "1315" "1316" "1317" "1318" "1319" "1014" "1114" "1214" "1314"
;->  "24" "1415" "1416" "1417" "1418" "1419" "1015")

Questo processo di descrizione non ci permette di risalire al numero originario perchè non è una funzione biunivoca, cioè alcuni numeri originari hanno la stessa rappresentazione.
Per esempio:

(descrizione 18)
;-> "1118"
(descrizione 81)
;-> "1118"

Questo è dovuto al fatto che ordiniamo le cifre in modo crescente.
Per poter risalire al numero originario basta non ordinare le cifre del numero:

(define (descrizione-lineare num)
  (local (lst uniq conta coppie out)
    (setq lst (int-list num))
    ; cifre uniche
    (setq uniq (unique lst))
    ; conta la frequenza delle cifre uniche
    (setq conta (count uniq lst))
    ; crea la lista delle coppie frequenza-cifra
    (setq coppie (flat (map list conta uniq)))
    ; unisce le coppie in un unica stringa
    (setq out (join (map string coppie)))
    ; rimuove eventuali "L" per i big-integer
    (replace "L" out "")))

Proviamo:

(descrizione-lineare 18)
;-> "1118"
(descrizione-lineare 81)
;-> "1811"


---------------------
Numeri autobiografici
---------------------

I numeri autobiografici sono numeri uguali alla loro descrizione.
Vediamo come funziona il processo di descrizione di un numero:
  Per ogni cifra da 0 a 9 presente nel numero,
  prendere la frequenza di quella cifra e poi la cifra.

Per esempio:
  N = 102422
  cifra   frequenza   sequenza
    0        1        10
    1        1        11
    2        3        32
    4        1        14
  Output = 10113214

Quindi un numero è autobiografico se risulta:

 N = Descrizione(N)

Esempi di numeri autobiografici:

  22
  10213223

Sequenza OEIS: A047841
Autobiographical numbers: Fixed under operator T (A047842): "Say what you see"
  22, 10213223, 10311233, 10313314, 10313315, 10313316, 10313317, 10313318,
  10313319, 21322314, 21322315, 21322316, 21322317, 21322318, 21322319,
  31123314, 31123315, 31123316, 31123317, 31123318, 31123319, ...
  ..., 101112213141516171819.

Questa sequenza è finita, poiché Descrizione(N) < N per ogni N con almeno 22 cifre.
L'ultimo termine è a(109) = 101112213141516171819 (Schimke).

Scrivere una funzione per trovare tutti i numeri autobiografici.

Funzione che "descrive" un numero (stringa):

(define (describe num)
  (local (lst uniq conta coppie out)
    (setq lst (sort (explode num)))
    ; cifre uniche
    (setq uniq (unique lst))
    ; conta la frequenza delle cifre uniche
    (setq conta (count uniq lst))
    ; crea la lista delle coppie frequenza-cifra
    (setq coppie (flat (map list conta uniq)))
    ; unisce le coppie in un unica stringa
    (setq out (join (map string coppie)))
    ; rimuove eventuali "L" per i big-integer
    (replace "L" out "")))

Proviamo:

(describe "102422")
;-> "10113214"

(describe "30")
;-> "1013"

(describe "12345678901234567890")
;-> "20212223242526272829"

Non è possibile verificare ogni numero da 1 a 101112213141516171819.
Possiamo sfruttare il fatto che ogni cifra ha un numero limitato di occorrenze:
  cifra 0: 1 volta al massimo
  cifra 1: 11 volte al massimo
  cifra 2: 3 volte al massimo
  cifra 3: 3 volte al massimo
  cifra 4: 2 volte al massimo
  cifra 5: 2 volte al massimo
  cifra 6: 2 volte al massimo
  cifra 7: 2 volte al massimo
  cifra 8: 1 volte al massimo
  cifra 9: 1 volte al massimo

Possiamo inserire i valori in una lista con elementi (frequenza cifra):

(setq coppie '((11 1) (3 2) (3 3) (2 4) (2 5) (2 6) (2 7) (1 8) (1 9) (1 0)))

Poi scriviamo la funzione che genera tutti i numeri che rispettano le occorrenze delle cifre specificate in una lista:

Usiamo la ricorsione per generare tutti i possibili numeri combinando le cifre fornite nella lista, rispettando il numero massimo di ripetizioni (frequenza) per ciascuna cifra. 

(define (genera-aux coppie idx cur-number)
  (local (freq-max digit new-number)
  (cond ((= idx (length coppie))
            (++ conta))
            ;(println cur-number))
        (true
          (setq freq-max (coppie idx 0))
          (setq digit (coppie idx 1))
          ;(println "freq-max: " freq-max { } "digit: "digit)
          (for (freq 0 freq-max)
            (setq new-number (string cur-number (dup (string digit) freq)))
            (genera-aux coppie (+ idx 1) new-number))))))

(define (genera lista-cifre)
  (let (conta 0)
    (genera-aux lista-cifre 0 "")
    (- conta 1)))

Proviamo:

Con (println cur-number):
(genera '((2 1) (3 2)))
;-> 2
;-> 22
;-> 222
;-> 1
;-> 12
;-> 122
;-> 1222
;-> 11
;-> 112
;-> 1122
;-> 11222
;-> 11 ; quantità di numeri generati

A prima vista sembra che manchino alcuni numeri, per esempio abbiamo il numero 122, ma non abbiamo il numero 221. In realtà il numero 221 non ci serve, perchè abbiamo bisogno solo di una rappresentazione per ogni combinazione di frequenze e cifre per scoprire se un numero è autobiografico.
Per esempio:
Numero autobiografico = 106132231526171891
Nella lista dei numeri generati non abbiamo il numero 106132231526171891, ma abbiamo un numero con la stessa frequenza di cifre (per esempio il suo inverso 198171625132231601).
Per vedere se il numero che abbiamo è autobigrafico applichiamo il seguente metodo:

   nuovo-numero = describe(numero)
   se (nuovo-numero = describe(nuovo-numero)) allora nuovo-numero è autobiografico.

(setq numero "198171625132231601")
;-> "198171625132231601"
(setq nuovo-numero (describe numero))
"106132231526171819"
(= nuovo-numero (describe nuovo-numero))
;-> true

Adesso vediamo quanti sono i numeri da controllare con la lista "coppie":

(genera coppie)
;-> 124415 ; quantità di numeri generati

Scriviamo la funzione che calcola tutti i numeri autobiografici:

(define (autobio-aux coppie idx cur-number)
  (local (freq-max digit new-number x)
  (cond ((= idx (length coppie))
         ;(println (int cur-number)) (read-line)
         ; controllo numero autobiografico
         (setq x (describe cur-number))
         (if (= x (describe x)) 
           (begin 
             ;(println "x: " x)
             (++ conta)
             (push x out -1))))
        (true
          (setq freq-max (coppie idx 0))
          (setq digit (coppie idx 1))
          (for (freq 0 freq-max)
            (setq new-number (string cur-number (dup (string digit) freq)))
            (autobio-aux coppie (+ idx 1) new-number)
          )))))

(define (autobio lista-cifre)
  (local (conta out)
    (setq out '())
    (setq conta 0)
    (autobio-aux lista-cifre 0 "")
    ;(println (- conta 1))
    ; rimuove il primo elemento che vale: ""
    (slice out 1)))

Proviamo:

(setq seq (autobio coppie))
;-> ("22" "10213223" "21322319" "21322318" "21322317" "21322316" "21322315"
;->  "21322314" "10313319" "10313318" "31331819" "10313317" "31331719" 
;->  "31331718" "10313316" "31331619" "31331618" "31331617" "10313315" 
;->  ...
;->  "1011112131415161718" "1111213141516171819" "101112213141516171819")

(length seq)
;-> 109

(time (setq seq (autobio coppie)))
;-> 3422.303


-------------------
Il gioco del Domino
-------------------

Il gioco del domino è un gioco da tavolo che coinvolge l'utilizzo di tessere rettangolari, comunemente chiamate "tessere", ciascuna delle quali è divisa in due parti da una linea centrale.
Ogni parte della tessera è contrassegnata con un certo numero di punti (o "pips") da 0 a 6.
Le regole di base del gioco del domino sono le seguenti:

Obiettivo del gioco:
Il giocatore cerca di sbarazzarsi di tutte le proprie tessere facendo corrispondere il numero dei pips sulle estremità delle tessere con quelli sul tavolo.

Inizio del gioco:
Si parte con tutte le tessere mescolate e disposte coperte sul tavolo.
I giocatori pescano un certo numero di tessere (di solito 7 a testa in un gioco a due giocatori, meno in giochi con più partecipanti).
Il resto delle tessere costituisce il "banco", che viene posizionato coperto al centro del tavolo per nascondere le tessere ai giocatori.

Giocare una tessera:
Il primo giocatore inizia ponendo una tessera sul tavolo.
Il giocatore successivo deve quindi giocare una tessera che corrisponda in numero a una delle estremità della tessera già in gioco.
Ad esempio, se la tessera sul tavolo ha un lato con tre pips, il giocatore successivo deve giocare una tessera con un lato che abbia anche tre pips.
Se un giocatore non ha tessere con cui giocare, deve pescarne una dal mazzo e passare il turno.

Punteggio:
Il punteggio viene assegnato ogni volta che un giocatore riesce a sbarazzarsi di tutte le sue tessere.
Il punteggio di ogni giocatore è la somma dei pips sulle tessere rimaste nelle mani degli altri giocatori.
Il primo giocatore a raggiungere un certo punteggio prestabilito (di solito 100 punti) vince la partita.

Doppio sei (opzionale):
Quando un giocatore pone la tessera "doppio sei" (cioè la tessera con due sezioni, ciascuna con sei pips) il giocatore successivo è bloccato e deve passare il suo turno
Questa regola è opzionale.

Queste sono solo le regole di base del gioco del domino.
Esistono molte varianti del gioco che possono includere regole aggiuntive o modifiche alle regole di base sopra descritte.

Tipi di domino [n:n]
I vari tipi di domino si differenziano per il numero maggiore n disponibile sulle tessere [n:n].
Ad esempio il set standard con numeri che vanno da 0 a 6 viene identificato con [6:6]
In commercio esistono i seguenti tipi di domino:

  Tipo        Numero di tessere
  [6-6]          28  (set standard)
  [9-9]          55
  [12-12]        91
  [15-15]        136
  [18-18]        190

Il numero di tessere in una serie di [n-n] tessere del domino è dato dalla formula:

  (n+1)*(n+2)/2  = (n^2 + 3n + 2)/2

Ad esempio, il numero di tessere in un set [6-6] è (6*6 + 3*6 + 2)/2 = 28.

  numero-tessere = (n+1)*(n+2)/2

Il numero di pips in una serie di [n-n] tessere del domino è dato dalla formula:

  pips = n * numero-tessere = n*(n+1)*(n+2)/2

Una delle proprietà più importanti di una serie [n-n] di tessere del domino è che qualsiasi numero k (dove 0 <= k <= n) apparirà (n+2) volte sulle tessere.
La ragione per cui questo è importante per un giocatore è che quando vuoi sapere se puoi bloccare un altro giocatore, puoi contare rapidamente le occorrenze di un numero nella tua mano e sul tavolo.
Se il conteggio è uguale a (n+2), sai che nessun altro giocatore può eguagliare quel numero.
Cerca un doppio, solitamente giocato come spinner nella maggior parte dei giochi, e troverai immediatamente quattro delle otto occorrenze.

Dato un set di [n-n] tessere del domino, è possibile disporre tutte le tessere in un unico treno?
Un treno è una linea di tessere, ciascuna delle cui estremità corrisponde all'estremità delle tessere immediatamente a sinistra e a destra, con l'eccezione delle due tessere finali che coincidono solo su un'estremità, ovviamente.
Quanti treni diversi si possono costruire con un le tessere del domino standard [6:6]?
Qualcuno ha calcolato che sono 7.959.229.931.520 se si contano le inversioni o la metà se non si contano.

Funzione che crea le tessere di un domino (lista di coppie):

(define (crea-tessere lst)
  (let ( (out '()) (len (length lst)) )
    (for (i 0 (- len 1))
      (for (j i (- len 1))
          (push (list (lst i) (lst j)) out -1)))))

(crea-tessere (sequence 0 6))
;-> ((0 0) (0 1) (0 2) (0 3) (0 4) (0 5) (0 6)
;->  (1 1) (1 2) (1 3) (1 4) (1 5) (1 6)
;->  (2 2) (2 3) (2 4) (2 5) (2 6)
;->  (3 3) (3 4) (3 5) (3 6)
;->  (4 4) (4 5) (4 6)
;->  (5 5) (5 6)
;->  (6 6))

Numero di tessere:
(length (crea-tessere (sequence 0 6)))
;-> 28

La formula per numero di tessere è la seguente:

  num-tessere = (n+1)*(n+2)/2

(define (numero-tessere n) (/ (* (+ n 1) (+ n 2)) 2))

(numero-tessere 6)
;-> 28

Numero di pips:
(apply + (flat (crea-tessere (sequence 0 6))))
;-> 168

La formula per numero di pips è la seguente:

  pips = n * numero-tessere = n*(n+1)*(n+2)/2

(* 28 6)
;-> 168

(define (pips n) (/ (* n (+ n 1) (+ n 2)) 2))
(pips 6)
;-> 168

Funzione che calcola le frequenze dei numeri (pips) in un domino:

(define (frequenza-numeri tessere)
  (setq t (flat tessere))
  (setq uniq (unique t))
  (setq conta (count uniq t))
  (map list uniq conta))

(setq domino6 (crea-tessere (sequence 0 6)))

(frequenza-numeri domino6)
;-> ((0 8) (1 8) (2 8) (3 8) (4 8) (5 8) (6 8))

Scriviamo alcune funzioni per simulare una partita a domino [6:6] tra due giocatori.

Come disegniamo le tessere del domino?

Primo tentativo:

(define (draw coppia)
  (let ( (a (coppia 0)) (b (coppia 1)) )
   (println "+-+")
   (println "|" a "|")
   (println "+-+")
   (println "|" b "|")
   (println "+-+")))

(draw '(1 2))
;-> +-+
;-> |1|
;-> +-+
;-> |2|
;-> +-+

Proviamo ad usare i seguenti caratteri:

(print "╔") (print "╗")
(print "══") (print "║")
(print "╚") (print "╝")
(print "╬") (print "╩") (print "╦") (print "╠") (print "╣")

Verticale:

(define (draw-v coppia)
  (let ( (a (coppia 0)) (b (coppia 1)) )
   (println "╔═╗")
   (println "║" a "║")
   (println "╠═╣")
   (println "║" b "║")
   (println "╚═╝")))

(draw-v '(1 2))
;-> ╔═╗
;-> ║1║
;-> ╠═╣
;-> ║2║
;-> ╚═╝

Orizzontale:

(define (draw-h coppia)
  (let ( (a (coppia 0)) (b (coppia 1)) )
    (println "╔═╦═╗")
    (println "║" a "║" b "║")
    (println "╚═╩═╝")))

(draw-h '(1 2))
;-> ╔═╦═╗
;-> ║1║2║
;-> ╚═╩═╝

Però dobbiamo stampare una lista di tessere in orizzontale:

  ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
  ║1║2║ ║2║3║ ║3║6║
  ╚═╩═╝ ╚═╩═╝ ╚═╩═╝...

Funzione che stampa una matrice di caratteri:

(define (print-matrix matrix)
  (local (rows cols)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (print (matrix r c))
      )
      (println))))

(setq m '(("╔" "═" "╦" "═" "╗")
          ("║" "a" "║" "b" "║")
          ("╚" "═" "╩" "═" "╝")))

(print-matrix m)
;-> ╔═╦═╗
;-> ║a║b║
;-> ╚═╩═╝

Elementi da modificare:

  "a" = (m 1 1)
  "b" = (m 1 3)

Funzione che crea la matrice di caratteri di una lista di tessere:

(define (create-matrix tessere spazi)
  (local (t len out cur-row)
    (setq t '(("╔" "═" "╦" "═" "╗")
              ("║" "a" "║" "b" "║")
              ("╚" "═" "╩" "═" "╝")))
    (setq len (length tessere))
    (for (row 0 2)
      (setq cur-row '())
      (dolist (coppia tessere)
        ; a
        (setf (t 1 1) (string (coppia 0)))
        ; b
        (setf (t 1 3) (string (coppia 1)))
        (extend cur-row (t row) (dup " " spazi true))
      )
      (push cur-row out -1)
    )))

(print-matrix (create-matrix '((0 0) (0 6) (6 6) (6 5)) 0))
;-> ╔═╦═╗╔═╦═╗╔═╦═╗╔═╦═╗
;-> ║0║0║║0║6║║6║6║║6║5║
;-> ╚═╩═╝╚═╩═╝╚═╩═╝╚═╩═╝

(print-matrix (create-matrix '((0 0) (0 6) (6 6) (6 5)) 1))
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║0║0║ ║0║6║ ║6║6║ ║6║5║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

Funzione che aggiunge una tessera (coppia) a destra di un treno di tessere:

(define (add-right coppia lst)
  (cond ((zero? (length lst)) ; lista vuota?
          (push coppia lst))
        ((= (coppia 0) (lst -1 1)) ; tessera a|b
          (push coppia lst -1))
        ((= (coppia 1) (lst -1 1)) ; tessera b|a
          (push (list (coppia 1) (coppia 0)) lst -1))
        (true
          (println "Error: number mismatch " (lst -1 1) " with ("(coppia 0) " " (coppia 1) ")."))
  )
  lst)

Funzione che aggiunge una tessera (coppia) a sinistra del treno di tessere:

(define (add-left coppia lst)
  (cond ((zero? (length lst)) ; lista vuota?
          (push coppia lst))
        ((= (coppia 1) (lst 0 0)) ; tessera a|b
          (push coppia lst))
        ((= (coppia 0) (lst 0 0)) ; tessera b|a
          (push (list (coppia 1) (coppia 0)) lst))
        (true
          (println "Error: number mismatch " (lst 0 0) " with ("(coppia 0) " " (coppia 1) ")."))
  )
  lst)

(setq d '((0 0) (0 6) (6 6) (6 5)))

(add-right '(3 4) d)
;-> Error: number mismatch 5 with (3 4).
;-> ((0 0) (0 6) (6 6) (6 5))

(add-right '(5 4) d)
;-> ((0 0) (0 6) (6 6) (6 5) (5 4))

(add-right '(4 5) d)
;-> ((0 0) (0 6) (6 6) (6 5) (5 4))

(add-left '(4 5) d)
;-> Error: number mismatch 0 with (4 5).
;-> ((0 0) (0 6) (6 6) (6 5))

(add-left '(0 5) d)
;-> ((5 0) (0 0) (0 6) (6 6) (6 5))

(print-matrix (create-matrix (add-left '(5 0) d) 1))
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║5║0║ ║0║0║ ║0║6║ ║6║6║ ║6║5║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

Funzione che stampa la situazione corrente del gioco:

(define (print-game)
  (println "Bank:")
  (println"╔═╦═╗")
  (println"║ ║ ║ " (length banco))
  (println"╚═╩═╝")
  (println "Player 1:")
  (print-matrix (create-matrix tile1 1))
  (println "Train:")
  (if (= treno '()) (begin
      (println"╔═╦═╗")
      (println"║ ║ ║")
      (println"╚═╩═╝"))
      ;else
      (print-matrix (create-matrix treno 0))
  )
  (println "Player 2:")
  (print-matrix (create-matrix tile2 1))
)

Funzione che inizia una nuova partita:

(define (new-game)
    (setq domino (randomize (crea-tessere (sequence 0 6))))
    (setq tile1 (slice domino 0 7))
    (setq tile2 (slice domino 7 7))
    (setq banco (slice domino 14))
    (setq treno '())
    (print-game))

(new-game)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 14
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║0║0║ ║2║5║ ║1║1║ ║4║5║ ║3║3║ ║0║1║ ║2║2║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗
;-> ║ ║ ║
;-> ╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║5║5║ ║4║6║ ║0║3║ ║0║6║ ║0║2║ ║1║3║ ║3║5║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

Funzione che permette ad un giocatore di prendere una carta dal banco:

(define (take player)
  (cond ((= banco '())
          (println ("Error: no more tile to get."))
          banco)
        (true
          (cond ((= player 1)
                  (push (pop banco) tile1 -1)
                  tile1)
                ((= player 2)
                  (push (pop banco) tile2 -1)
                  tile2)
                (true (println "Error: wrong player") banco)))
  )
  (print-game))

(take 2)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 13
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║0║0║ ║2║5║ ║1║1║ ║4║5║ ║3║3║ ║0║1║ ║2║2║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗
;-> ║ ║ ║
;-> ╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║5║5║ ║4║6║ ║0║3║ ║0║6║ ║0║2║ ║1║3║ ║3║5║ ║0║4║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

Funzione che permette ad un giocatore di inserire una tessera a sinistra del treno:

(define (sx coppia player)
  (let (len (length treno))
    (cond ((= player 1)
            (cond ((ref coppia tile1)
                    (setq treno (add-left coppia treno))
                    (if (!= len (length treno))
                        (pop tile1 (ref coppia tile1))))
                  (true (println "Error: " coppia " do not exists."))))
          ((= player 2)
            (cond ((ref coppia tile2)
                    (setq treno (add-left coppia treno))
                    (if (!= len (length treno))
                        (pop tile2 (ref coppia tile2))))
                  (true (println "Error: " coppia " do not exists."))))
          (true (println "Error: wrong player " player))
    )
    (print-game)))

Funzione che permette ad un giocatore di inserire una tessera a destra del treno:

(define (dx coppia player)
  (let (len (length treno))
    (cond ((= player 1)
            (cond ((ref coppia tile1)
                    (setq treno (add-right coppia treno))
                    (if (!= len (length treno))
                        (pop tile1 (ref coppia tile1))))
                    (true (println "Error: " coppia " do not exists."))))
          ((= player 2)
            (cond ((ref coppia tile2)
                    (setq treno (add-right coppia treno))
                    (if (!= len (length treno))
                        (pop tile2 (ref coppia tile2))))
                  (true (println "Error: " coppia " do not exists."))))
          (true (println "Error: wrong player " player))
    )
    (print-game)))

Facciamo una partita:

(new-game)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 14
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║2║6║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║2║2║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗
;-> ║ ║ ║
;-> ╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║ ║2║5║ ║5║6║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(dx '(5 5) 1)
;-> Error: (5 5) do not exists.
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 14
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║2║6║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║2║2║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗
;-> ║ ║ ║
;-> ╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║ ║2║5║ ║5║6║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(dx '(6 6) 2)
;-> Error: (6 6) do not exists.
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 14
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║2║6║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║2║2║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗
;-> ║ ║ ║
;-> ╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║ ║2║5║ ║5║6║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(dx '(2 6) 3)
;-> Error: wrong player 3
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 14
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║2║6║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║2║2║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗
;-> ║ ║ ║
;-> ╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║ ║2║5║ ║5║6║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(dx '(2 6) 1)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 14
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║2║2║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗
;-> ║2║6║
;-> ╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║ ║2║5║ ║5║6║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(dx '(5 6) 2)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 14
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║2║2║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗╔═╦═╗
;-> ║2║6║║6║5║
;-> ╚═╩═╝╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║ ║2║5║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(take 1)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 13
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║2║2║ ║1║4║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗╔═╦═╗
;-> ║2║6║║6║5║
;-> ╚═╩═╝╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║ ║2║5║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(dx '(2 5) 2)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 13
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║2║2║ ║1║4║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗╔═╦═╗╔═╦═╗
;-> ║2║6║║6║5║║5║2║
;-> ╚═╩═╝╚═╩═╝╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(sx '(2 2) 1)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 13
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║1║4║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗╔═╦═╗╔═╦═╗╔═╦═╗
;-> ║2║2║║2║6║║6║5║║5║2║
;-> ╚═╩═╝╚═╩═╝╚═╩═╝╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝

(take 2)
;-> Bank:
;-> ╔═╦═╗
;-> ║ ║ ║ 12
;-> ╚═╩═╝
;-> Player 1:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║2║4║ ║0║1║ ║1║1║ ║3║4║ ║0║0║ ║1║4║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
;-> Train:
;-> ╔═╦═╗╔═╦═╗╔═╦═╗╔═╦═╗
;-> ║2║2║║2║6║║6║5║║5║2║
;-> ╚═╩═╝╚═╩═╝╚═╩═╝╚═╩═╝
;-> Player 2:
;-> ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗ ╔═╦═╗
;-> ║1║2║ ║3║5║ ║4║5║ ║4║6║ ║0║4║ ║6║6║
;-> ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝ ╚═╩═╝
...
banco
;-> ((0 5) (4 4) (1 5) (1 3) (3 6) (1 6) (3 3) (0 6) (0 3) (2 3) (5 5) (0 2))

Nota:
Il tipo di gioco del domino più comune è quello delle "connessioni".
I giocatori, a turno, aggiungono tessere a un layout.
Le tessere vengono normalmente giocate l'una dopo l'altra, con il numero di pip sulle estremità che si toccano corrispondenti.
Tali layout possono assumere diverse forme a seconda delle regole di connessione:

1) braccio - quando il layout ha una sola estremità aperta alla quale è possibile aggiungere tessere, formando una linea che cresce in una sola direzione.
2) linea - quando il layout può estendersi da entrambe le estremità della tessera iniziale, formando una linea che può crescere ad entrambe le estremità.
3) croce - quando la disposizione inizia con un doppio da cui possono svilupparsi quattro bracci formando una forma a croce.
4) stella - quando i bracci del layout possono crescere in molte direzioni dalla tessera iniziale, a volte formando un braccio per ogni giocatore.
5) albero - quando non solo il doppio iniziale, ma ogni doppio giocato consente al layout di ramificarsi.
5) rete - quando il layout può non solo ramificarsi ma anche ricongiungersi, formando una struttura complessa che può includere circuiti chiusi.
6) griglia - quando le tessere vengono giocate in una griglia bidimensionale regolare.
7) layout disconnesso: quando sono presenti più righe, colonne o gruppi separati a cui è possibile aggiungere riquadri.

Sebbene la regola di connessione più comune sia che le estremità in contatto delle tessere adiacenti debbano avere lo stesso numero di pip, sono possibili altre regole di connessione.
Uno di questi è la connessione "matador" in cui il numero totale di punti sulle estremità che si toccano è un numero fisso - ad esempio 7 nel caso di un set [6:6], in modo che se un braccio termina con un 2, la tessera successiva giocata su quel braccio deve avere un 5 che tocca il 2.

La maggior parte dei giochi di connessione di domino sono giochi di perdita in cui l'obiettivo è essere il primo a terminare tutte le tue tessere.

Maggiori informazioni sul sito web: https://www.pagat.com/domino/


------------
Numeri densi
------------

Un numero denso è un numero che ha esattamente tanti divisori primi quanti divisori non primi (inclusi 1 e se stesso come divisori).
In modo equivalente, un numero denso è un numero primo o un prodotto di due numeri primi distinti.

Sequenza OEIS: A167171
Squarefree semiprimes together with primes
  2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 31, 33,
  34, 35, 37, 38, 39, 41, 43, 46, 47, 51, 53, 55, 57, 58, 59, 61, 62, 65,
  67, 69, 71, 73, 74, 77, 79, 82, 83, 85, 86, 87, 89, 91, 93, 94, 95, 97,
  101, 103, 106, 107, 109, 111, 113, 115, 118, 119, 122, 123, ...

Usiamo la seconda definizione.

(define (dense? num)
  (let (f (factor num))
    (or (= (length f) 1)
        (and (= (length f) 2) (!= (f 0) (f 1))))))

Proviamo:

(filter dense? (sequence 2 123))
;-> (2 3 5 6 7 10 11 13 14 15 17 19 21 22 23 26 29 31 33
;->  34 35 37 38 39 41 43 46 47 51 53 55 57 58 59 61 62 65
;->  67 69 71 73 74 77 79 82 83 85 86 87 89 91 93 94 95 97
;->  101 103 106 107 109 111 113 115 118 119 122 123)


------------
Life passing
------------

(define (life last-years current-years)
  (local (all-weeks gone-weeks y)
    (setq all-weeks (+ (/ (* 365 last-years) 7) (/ (/ last-years 4) 7)))
    (setq gone-weeks (+ (/ (* 365 current-years) 7) (/ (/ current-years 4) 7)))
    (setq y 1)
    (print "  1 ")
    (for (w 1 all-weeks)
      (cond ((<= w gone-weeks) (print "0"))
            ((> w gone-weeks)  (print "1"))
      )
      (if (zero? (% w 52)) (print "\n" (format "%3d" (++ y)) " "))
    ) '>))

(life 80 55)
;->   1 0000000000000000000000000000000000000000000000000000
;->   2 0000000000000000000000000000000000000000000000000000
;->   3 0000000000000000000000000000000000000000000000000000
;->  ...
;->  53 0000000000000000000000000000000000000000000000000000
;->  54 0000000000000000000000000000000000000000000000000000
;->  55 0000000000000000000000000000000000000000000000000000
;->  56 0000000011111111111111111111111111111111111111111111
;->  57 1111111111111111111111111111111111111111111111111111
;->  58 1111111111111111111111111111111111111111111111111111
;->  59 1111111111111111111111111111111111111111111111111111
;->  60 1111111111111111111111111111111111111111111111111111
;->  61 1111111111111111111111111111111111111111111111111111
;->  62 1111111111111111111111111111111111111111111111111111
;->  63 1111111111111111111111111111111111111111111111111111
;->  64 1111111111111111111111111111111111111111111111111111
;->  65 1111111111111111111111111111111111111111111111111111
;->  66 1111111111111111111111111111111111111111111111111111
;->  67 1111111111111111111111111111111111111111111111111111
;->  68 1111111111111111111111111111111111111111111111111111
;->  69 1111111111111111111111111111111111111111111111111111
;->  70 1111111111111111111111111111111111111111111111111111
;->  71 1111111111111111111111111111111111111111111111111111
;->  72 1111111111111111111111111111111111111111111111111111
;->  73 1111111111111111111111111111111111111111111111111111
;->  74 1111111111111111111111111111111111111111111111111111
;->  75 1111111111111111111111111111111111111111111111111111
;->  76 1111111111111111111111111111111111111111111111111111
;->  77 1111111111111111111111111111111111111111111111111111
;->  78 1111111111111111111111111111111111111111111111111111
;->  79 1111111111111111111111111111111111111111111111111111
;->  80 1111111111111111111111111111111111111111111111111111
;->  81 1111111111111>


------------------------------------------------
Operazioni diverse con gli elementi di due liste
------------------------------------------------

Abbiamo due liste di numeri interi con la stessa lunghezza L.
Per ogni coppia di numeri con lo stesso indice bisogna effettuare un'operazione diversa.
Per esempio:
lista1 = (1 2 6 4)
lista2 = (4 1 3 5)
Operazioni = (+ - / *)
Output = ((1+4) (2-1) (6/3) (4*5)) = (5 1 2 20)

Mettiamo le operazioni in una lista e poi usiamo "eval" per valutare le varie operazioni:

(setq f '(+ - / *))
((eval (f 0)) 1 2)
;-> 3
((eval (f 1)) 1 2)
;-> -1

(define (operazioni lst1 lst2 op)
  (map (fn(x y z) ((eval x) y z)) f lst1 lst2))

Proviamo:

(operazioni '(1 2 6 4) '(4 1 3 5) op)
;-> (5 1 2 20)


----------------------------------------------
Le caratteristiche di un linguaggio funzionale
----------------------------------------------

Immutability (Immutabilità)
---------------------------
L'aspetto più importante della FP è l'immutabilità.
In generale, questo significa mancanza di cambiamento. 
Qualcosa è considerato immutabile se non possiamo modificarlo in qualche modo.

Considera il seguente semplice ciclo for che stampa i numeri da 0 a 10.

(for (i 0 10) (println i))

Questo tipo di codice si utilizza continuamente.
In pratica il codice modifica in continuazione il valore di "i".

Come potremmo farlo esprimerlo in modo immutabile?
Un approccio comune in FP è l'uso di funzioni ricorsive:
una funzione ricorsiva è quella che chiama se stessa.

(define (ciclo i)
  (cond ((> i 10) nil)
        (true
          (println i)
          (ciclo (+ i 1)))))

(ciclo 0)

Questo codice è un po' più lungo, ma non modifica nessuno stato.

Referential Transparency (Trasparenza referenziale)
---------------------------------------------------
La prossima caratteristica cruciale della FP è la trasparenza referenziale.
Diciamo che un'espressione è referenzialmente trasparente se possiamo sostituirla con il suo valore in qualsiasi punto del codice.
Sembra che sia sempre possibile farlo. Vediamo un esempio eseguendo la funzione "now":

(now)
;-> (2024 3 16 15 28 29 184021 76 6 60 1)

Se sostituisco il corpo della funzione con questo risultato e chiamo nuovamente la funzione otterrò la risposta sbagliata. 
Quindi la funzione oggi non ha trasparenza referenziale.
Un concetto correlato FP è la "purezza".
In generale, una funzione si dice pura se non ha effetti collaterali e per un dato input,
restituisce sempre lo stesso output.
Ciò significa sostanzialmente che se l'input è x e l'output è y, non importa quante volte chiami la funzione con x come input, la funzione restituirà sempre y come output.
Un effetto collaterale è tutto ciò che accade all'esterno del contesto della funzione.

Higher Order Functions (Funzioni di ordine superiore)
-----------------------------------------------------
La FP è tutta una questione di funzioni. 
Ciò che vogliamo, in un linguaggio FP, è la capacità di trattare le funzioni come 'cittadini di prima classe'. 
Ciò significa che dovremmo essere in grado di passarle come parametri di funzione e restituirle dalle funzioni.

Lazy evaluation (Valutazione pigra)
-----------------------------------
Un'altra componente della FP è la Lazy evaluation.
Ciò significa semplicemente che un'espressione non è valutata finché non sarà necessario.
Ciò non è, in senso stretto, necessario per un linguaggio funzionale, ma spesso i linguaggi che sono per loro natura più funzionali tendono ad essere lazy.

Vedi anche "Programmazione Funzionale e Pensiero Funzionale" su "Note libere 7".


-------------------
The story of "null"
-------------------

Tony Hoare, the inventor of null, said it was his billion-dollar mistake:

I call it my billion-dollar mistake. 
It was the invention of the null reference in 1965.
At that time, I was designing the first comprehensive type system for references in an object-oriented language (ALGOL W).
My goal was to ensure that all use of references should be absolutely safe, with checking performed automatically by the compiler.
But I couldn't resist the temptation to put in a null reference, simply because it was so easy to implement.
This has led to innumerable errors, vulnerabilities, and system crashes, which have probably caused a billion dollars of pain and damage in the last forty years.

Hoare, Tony: "Null References: The Billion Dollar Mistake."
Historically Bad Ideas. Lecture presented at the QCon, 2009.


-----------------------------------------
Numeri divisibili dalla somma dei fattori
-----------------------------------------

Determinare la sequenza dei numeri che sono esattamente divisibili dalla somma dei loro fattori.

Sequenza OEIS: A036844
  Numbers k such that k/sopfr(k) is an integer.
  Where sopfr = sum-of-prime-factors
  2, 3, 4, 5, 7, 11, 13, 16, 17, 19, 23, 27, 29, 30, 31, 37, 41, 43, 47,
  53, 59, 60, 61, 67, 70, 71, 72, 73, 79, 83, 84, 89, 97, 101, 103, 105,
  107, 109, 113, 127, 131, 137, 139, 149, 150, 151, 157, 163, 167, 173,
  179, 180, 181, 191, 193, 197, 199, 211, 220, 223, ...

(define (div-soprf? num)
  (zero? (% num (apply + (factor num)))))

Proviamo:

(filter div-soprf? (sequence 2 200))
;-> (2 3 4 5 7 11 13 16 17 19 23 27 29 30 31 37 41 43 47
;->  53 59 60 61 67 70 71 72 73 79 83 84 89 97 101 103 105
;->  107 109 113 127 131 137 139 149 150 151 157 163 167 173
;->  179 180 181 191 193 197 199)


---------------------
Primi di Wolstenholme
---------------------

I primi di Wolstenholme sono quei primi p tale che:

  binomial(2p-1,p-1) == 1 (mod p^4)

Sequenza OEIS: A088164
Wolstenholme primes: primes p such that binomial(2p-1,p-1) == 1 (mod p^4)
  16843, 2124679, ...

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

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (wols? num)
  (and (prime? num) (= (% (binom (- (* 2 num) 1) (- num 1)) (* 1L num num num num)) 1)))

Proviamo:

(wols? 16843)
;-> true

(time (wols? 16843))
;-> 446.114

(* 1L 16843 16843 16843 16843)
;-> 80478114820849201L

(time (println (wols? 2124679)))
;-> true
;-> 7020543.3 ; 1h 57m 543ms

(* 1L 2124679 2124679 2124679 2124679)
;-> 20378551049298456998947681L


-------------------
Fibonacci invertito
-------------------

Dato un numero di fibonacci F(n), determinare il valore di n.

Primo metodo
------------
Calcolo di tutti i numeri di fibonacci da 0 al numero cercato.

(define (fibo-i num)
"Calculates the Fibonacci number of an integer number"
  (if (zero? num) 0L
  ;else
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 (- num 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a)))

(map fibo-i (sequence 0 10))
;-> (0L 1L 1L 2L 3L 5L 8L 13L 21L 34L 55L)

(define (number fibo)
  (let ( (found nil) (val -1) )
    (until found
      (++ val)
      (cond ((= (fibo-i val) fibo) (setq found true))
            ; se F(val) > fibo, allora fibo non è un numero di Fibonacci
            ((> (fibo-i val) fibo) (setq found true) (setq val nil))
      )
    )
    val))

Proviamo:

(number (fibo-i 10))
;-> 10

(number (fibo-i 25))
;-> 25

(number (fibo-i 100))
;-> 100

(number 77)
;-> nil

Secondo metodo
--------------
Inversione della formula di Binet:

  fibonacci(n) ≈ ((1 + sqrt(5)) / 2)^n / sqrt(5)

applichiamo il log ad entrambi i membri:

log(fibonacci(n)) ≈ n log((1 + sqrt(5)) / 2) - log(sqrt(5))

ed otteniamo:

   g(n) ≈ (log(n) + log(quadrato(5))) / log((1 + quadrato(5))/2)

(define (number2 fibo)
 (round (div (add (log fibo) (log (sqrt 5)))
             (log (div (add 1 (sqrt 5)) 2))) 0))

Proviamo:

(number2 (fibo-i 10))
;-> 10

(number2 (fibo-i 25))
;-> 25

(number2 (fibo-i 100))
;-> 100

(number2 77)
;-> 11 ; in questo caso non riconosciamo un numero non-fibonacci

Terzo metodo
------------
Inversione diretta della formula di Binet (analogo al precedente):

  F(n) = near-int((phi^n)/sqrt(5)), per n >= 0

dove "near-int" è la funzione nearest-integer (simile a "round" in newLISP).
e phi = (1 + sqrt(5))/2 = 1.618033988749895... (golden ratio)

  n(F) = near-int(log_phi(sqrt(5)*F)), per F >= 1

(round 0.999 0)
;-> 1
(round 1.0001 0)
;-> 1
(round 1.5 0)
;-> 2

(define (number3 fibo)
  (let (phi (div (add 1 (sqrt 5)) 2))
    (round (log (mul fibo (sqrt 5)) phi) 0)))

(number3 (fibo-i 10))
;-> 10

(number3 (fibo-i 25))
;-> 25

(number3 (fibo-i 100))
;-> 100

(number3 77)
;-> 11 ; in questo caso non riconosciamo un numero non-fibonacci

============================================================================

