================

 NOTE LIBERE 15

================

-------------------------------
Potenze più vicine ad un numero
-------------------------------

Dati due numeri interi N e K, trovare la prima potenza di K inferiore a N e la prima potenza di K superiore a N.

Per esempio, con N = 8 e K = 3:
Le potenze di 3 sono: 3, 9, 27, 81, ...
La prima potenza di 3 inferiore a 8 vale: 3
La prima potenza di 3 superiore a 8 vale: 9

In generale:
- la prima potenza minore di K vale K^floor(log-k(N)).
- la prima potenza maggiore di K vale K^ceil(log-k(N)).

Dobbiamo solo stare attenti quando N è una potenza perfetta di K (perchè i numeri floating point sono pericolosi).

(define (close-power num k)
  (local (eps lg p1 p2 a b)
    (setq eps 1e-6)
    (setq lg (log num k))
    (setq p1 (floor lg))
    (setq p2 (ceil  lg))
    (setq a (pow k p1))
    (setq b (pow k p2))
    ; controllo se num è una potenza perfetta di k
    (cond ((> eps (abs (sub num a)))
            (setq a (pow k (- p1 1)))
            (setq b (pow k (+ p1 1))))
          ((> eps (abs (sub num b)))
            (setq a (pow k (- p2 1)))
            (setq b (pow k (+ p2 1))))
    )
    (list a b)))

Facciamo alcune prove:  
  
(close-power 8 3)
;-> (3 9)
(close-power 81 3)
;-> (27 243)
(close-power 1000 10)
;-> (100 10000)
(close-power 100 10)
;-> (10 1000)
(close-power 78125 5)
;-> (15625 390625)
(close-power 100 10)

=============================================================================

