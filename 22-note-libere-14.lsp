================

 NOTE LIBERE 14

================

-------------------
Triangolo di Hosoya
-------------------

Il triangolo di Hosoya (o di Fibonacci) è una disposizione triangolare di numeri basata sui numeri di Fibonacci.
Ogni numero è la somma di due numeri sopra nella diagonale sinistra o destra.
Le prime righe sono:

               1
              1 1
             2 1 2
            3 2 2 3
           5 3 4 3 5
          8 5 6 6 5 8
       13 8 10 9 10 8 13
     21 13 16 15 15 16 13 21
   34 21 26 24 25 24 26 21 34
  55 34 42 39 40 40 39 42 34 55
...

I numeri in questo triangolo seguono le seguenti relazioni di ricorsive:

  H(0,0) = H(1,0) = v = H(1,1) = H(2,1) = 1
  H(n,i) = H(n-1,i) + H(n-2,i) = H(n-1,i-1) + H(n-2,i-2)

I numeri nel triangolo soddisfano l'identità:

  H(n,j) = F(i+1) * F(n-i+1)

In altre partole, le due diagonali più esterne sono i numeri di Fibonacci, mentre i numeri sulle linee verticali centrali sono i quadrati dei numeri di Fibonacci. Tutti gli altri numeri nel triangolo sono il prodotto di due distinti numeri di Fibonacci maggiori di 1.

Versione ricorsiva

(define (hosoya1 n m)
  (cond ((and (zero? n) (zero? m)) 1)
        ((and (= n 1) (zero? m)) 1)
        ((and (= n 1) (= m 1)) 1)
        ((and (= n 2) (= m 1)) 1)
        (true
          (cond ((> n m)
                  (add (hosoya1 (- n 1) m) (hosoya1 (- n 2) m)))
                ((= n m)
                  (add (hosoya1 (- n 1) (- m 1)) (hosoya1 (- n 2) (- m 2))))
                ((< n m)
                  0)
                (true (println "error:" n { } m))
          ))))

(define (print-hosoya1 n)
  (for (i 0 (- n 1))
    (for (j 0 i)
      (print (hosoya1 i j) " ")
    )
    (println)))

(print-hosoya1 12)
;-> 1
;-> 1 1
;-> 2 1 2
;-> 3 2 2 3
;-> 5 3 4 3 5
;-> 8 5 6 6 5 8
;-> 13 8 10 9 10 8 13
;-> 21 13 16 15 15 16 13 21
;-> 34 21 26 24 25 24 26 21 34
;-> 55 34 42 39 40 40 39 42 34 55
;-> 89 55 68 63 65 64 65 63 68 55 89
;-> 144 89 110 102 105 104 104 105 102 110 89 144

Versione programmazione dinamica

(setq dp (array 3 3 '(0)))

(define (print-hosoya2 n)
  (let (dp (array n n '(0)))
    ; fill dp matrix
    (setq (dp 0 0) 1)
    (setq (dp 1 0) 1)
    (setq (dp 1 1) 1)
    (for (i 2 (- n 1))
      (for (j 0 (- n 1))
        (if (> i j)
            (setf (dp i j) (add (dp (- i 1) j) (dp (- i 2) j)))
        ;else
            (setf (dp i j) (add (dp (- i 1) (- j 1)) (dp (- i 2) (- j 2))))
        )
      )
    )
    ; print triangle
    (for (i 0 (- n 1))
      (for (j 0 i)
        (print (dp i j) " ")
      )
    (println))))

(print-hosoya2 12)
;-> 1
;-> 1 1
;-> 2 1 2
;-> 3 2 2 3
;-> 5 3 4 3 5
;-> 8 5 6 6 5 8
;-> 13 8 10 9 10 8 13
;-> 21 13 16 15 15 16 13 21
;-> 34 21 26 24 25 24 26 21 34
;-> 55 34 42 39 40 40 39 42 34 55
;-> 89 55 68 63 65 64 65 63 68 55 89
;-> 144 89 110 102 105 104 104 105 102 110 89 144



=============================================================================

