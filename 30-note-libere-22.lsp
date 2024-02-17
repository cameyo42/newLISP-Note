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

============================================================================

