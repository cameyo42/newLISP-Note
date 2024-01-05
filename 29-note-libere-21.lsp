================

 NOTE LIBERE 21

================

--------------------------------------
Media delle medie di due numeri interi
--------------------------------------

Consideriamo le seguenti medie per due numeri interi a e b:

  La radice quadrata media: sqrt((a^2 + b^2)/2).

  La media aritmetica: (a + b)/2.

  La media geometrica: sqrt(a*b)

  La media armonica: 2/(1/a + 1/b) = 2*a*b/(a + b).

Scrivere una funzione che calcola la media delle medie sopra riportate.

(define (media a b)
  (div (add (sqrt (div (add (mul a a) (mul b b)) 2))
            (div (add a b) 2)
            (sqrt (mul a b))
            (div (mul 2 a b) (add a b)))
        4))

Proviamo:

(media 7 6)
;-> 6.490370391287243
(media 10 10)
;-> 10
(media 23 1)
;-> 8.747829696519773
(media 2 4)
;-> 2.914342862895309
(media 200 400)
;-> 291.4342862895309

============================================================================

