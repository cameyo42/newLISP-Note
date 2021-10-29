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

=============================================================================

