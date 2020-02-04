+===================+
| Primality Testing |
+===================+

In questo documento vengono implementati gli algoritmi tratti dal libro:

"Primality Testing in Polynomial Time" di Martin Dietzfelbinger

Lista:

Algoritmo "Trial Division"
Algoritmo "Lehmann's Primality Test"
Algoritmo "Fast Modular Exponentiation"
Algoritmo "Perfect Power Test"
Algoritmo "Euclidean Algorithm"
Algoritmo "Extended Euclidean Algorithm"
Algoritmo "The Sieve of Eratosthenes"
Algoritmo "Fermat Test"

---------------------------------------------------------------------

-------------------
Funzioni ausiliarie
-------------------

"primo?" verifica se un numero è primo:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

"sign" assegna -1 oppure 0 oppure +1 in base al segno del numero:

(define (sign n)
  (cond ((> n 0) 1)
        ((< n 0) -1)
        (true 0)))

(sign -10)
;-> -1
(sign 3)
;-> 1
(sign 0)
;-> 0

"rand-int" genera un numero casuale intero x tale che 1 <= x <= n
(non funziona con i biginteger):

(define (rand-int n) (+ 1 (rand n)))

"rand-range" genera un numero casuale intero x tale che a <= n <= b:

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1)))
)

"powmod" calcola l'esponenziazione modulare veloce (b^e mod m):

(define (powmod b e m)
  (local (r)
    (cond ((= m 1) (setq r 0))
          (true
            (setq r 1L)
            (setq b (% b m))
            (while (> e 0)
              (if (= (% e 2) 1) (setq r (% (* r b) m)))
              (setq e (/ e 2))
              (setq b (% (* b b) m))
            )
          )
    )
    r))

(powmod 1024 313 42)
;-> 16L

"ipow" calcola la potenza di due numeri interi:

(define (ipow x n)
  (local (pot out)
    (if (zero? n)
        (setq out 1L)
        (begin
          (setq pot (ipow x (/ n 2)))
          (if (odd? n) (setq out (* x pot pot))
                       (setq out (* pot pot)))
        )
    )
    out))

(ipow -2 15)
;-> -32768
(ipow 11L 12L)
;-> 3138428376721L

"psetq" macro che permette l'assegnazione multipla:

(define-macro (psetq)
  (let ((_var '()) (_ex '()))
    (for (i 0 (- (length (args 1)) 1))
      (setq _ex (expand (args 1 i) (args 0 0)))
      (for (j 1 (- (length (args 0)) 1))
        (setq _ex (expand _ex (args 0 j)))
      )
      (push _ex _var -1)
    )
    (dolist (el _var)
      (set (args 0 $idx) (eval el))
    )))

(setq x 2 y 3)
(psetq (x y) ((+ 1 y) (+ 1 x)))
(list x y)
;-> (4 3)

---------------------------------------------------------------------

---------
Algoritmi
---------

Algoritmo "Trial Division"
Input: integer n >= 2

(define (trial-div n)
  (catch
    (let (i 2L)
      (while (<= (* i i) n)
        (if (= zero? (% n i)) (throw nil))
        (++ i)
      )
      true)))

(trial-div 113)
;-> true

(= (map primo? (sequence 2 10000)) (map trial-div (sequence 2 10000)))
;-> true

---------------------------------------------------------------------

Algoritmo "Lehmann's Primality Test"
Input: odd integer n >= 3
       integer p >= 2

(define (lehmann n p)
  (catch
    (local (a b c)
      (if (= p nil) (setq p 20))
      (setq b (array (+ p 1) '(0)))
      (for (i 1 p)
        (setq a (rand-int (- n 1)))
        (setq c (powmod a (/ (- n 1) 2) n))
        (if (and (!= c 1) (!= c (- n 1)))
            (throw nil)
            (setq (b i) c)
        )
      )
      (for (i 1 p)
            (if (and (!= (b i) 1) (!= (b i) (- n 1)))
                (throw nil)
            )
      )
      true)))

(seed (time-of-day))

(lehmann 113)
;-> true

(= (map primo? (sequence 3 10001 2)) (map lehmann (sequence 3 10001 2)))
;-> true

---------------------------------------------------------------------

Algoritmo "Fast Modular Exponentiation"
Input: integer a, n e m >= 1

(define (fastmodexp a n m)
  (local (u s c)
    (setq u n)
    (setq s (% a m))
    (setq c 1L)
    (while (>= u 1)
      (if (odd? u) (setq c (% (* c s) m)))
      (setq s (* s (% s m)))
      (setq u (/ u 2))
    )
    c))

(fastmodexp 1024 313 42)
;-> 16L
(fastmodexp 1024 1024 77)
;-> 23L
(powmod 1024 1024 77)
;-> 23L

---------------------------------------------------------------------

Algoritmo "Perfect Power Test"
Input: integer n >= 2

(define (perfect-power-test n)
  (catch
    (local (a b c m)
      (setq b 2L)
      (while (<= (ipow 2L b) n)
        (setq a 1L)
        (setq c n)
        (while (>= (- c a) 2)
          (setq m (/ (+ a c) 2))
          ; "min" don't work with biginteger
          ;(setq p (min (ipow m b) (+ n 1)))
          (if (< (ipow m b) (+ n 1))
              (setq p (ipow m b))
              (setq p (+ n 1))
          )
          (if (= p n) (throw (list m b)))
          (if (< p n)
              (setq a m)
              (setq c m)
          )
        )
        (++ b)
      )
      nil)))

(perfect-power-test 2047)
;-> nil
(perfect-power-test 1024)
;-> (32L 2L)
(ipow 1194052296529L 2L)
;-> 1425760886846178945447841L
(perfect-power-test 1425760886846178945447841L)
;-> (1194052296529L 2L)

---------------------------------------------------------------------

Algoritmo "Euclidean Algorithm"
Input: integer n m

(define (euclidean n m)
  (local (a b ta tb)
    (setq n (abs n))
    (setq m (abs m))
    (if (>= n m)
        (setq a n b m)
        (setq a m b n)
    )
    (while (> b 0)
      ;(setq ta a)
      ;(setq tb b)
      ;(setq a tb)
      ;(setq b (% ta tb))
      (psetq (a b) (b (% a b)))
    )
    a))

(euclidean 4 31)
;-> 1
(euclidean 400 24)
;-> 8
(euclidean 400L 24L)
;-> 8L

---------------------------------------------------------------------

Algoritmo "Extended Euclidean Algorithm"
Input: integer n m

(define (extended-euclidean n m)
  (local (a b xa ya xb yb q)
    (if (> (abs n) (abs m))
        (begin (setq a (abs n))
               (setq b (abs m))
               (setq xa (sign n))
               (setq ya 0)
               (setq xb 0)
               (setq yb (sign m)))
        (begin (setq a (abs m))
               (setq b (abs n))
               (setq xa 0)
               (setq ya (sign m))
               (setq xb (sign n))
               (setq yb 0))
    )
    (while (> b 0)
      (setq q (/ a b))
      (psetq (a b) (b (- a (* q b))))
      (psetq (xa ya xb yb) (xb yb (- xa (* q xb)) (- ya (* q yb))))
    )
    (list a xa ya)
  )
)

(extended-euclidean 120 30)
;-> (30 0 1)
(extended-euclidean 120 23)
;-> (1 -9 47)

---------------------------------------------------------------------

Algoritmo "The Sieve of Eratosthenes"
Input: integer n >= 2

(define (eratosthenes n)
  (local (m i j)
    (setq m (array (+ n 1) '(0)))
    (setq j 2)
    (while (<= (* j j) n)
      (if (= (m j) 0)
        (begin (setq i (* j j))
               (while (<= i n)
                 (if (= (m i) 0) (setq (m i) j))
                 (setq i (+ i j))
               ))
      )
      (++ j)
    )
    (slice m 2 (- n 1))))

(eratosthenes 10)
;-> (0 0 2 0 2 0 2 3 2)
idx  2 3 4 5 6 7 8 9 10

Nota: i numeri primi sono gli indici per cui il valore vale 0 (il vettore parte dall'indice 2).

---------------------------------------------------------------------

Algoritmo "Fermat Test"
Input: odd integer n >= 3

(define (fermat-test n)
  (let (a (rand-range 2 (- n 2)))
    (if (!= (powmod a (- n 1) n) 1)
        nil
        true)))

(fermat-test 91)
;-> nil
(fermat-test 91)
;-> true ; output errato
(fermat-test 91)
;-> nil
(fermat-test 91)
;-> nil
(fermat-test 91)
;-> nil

---------------------------------------------------------------------

Algoritmo "Iterated Fermat Test"
Input: odd integer n >= 3
           integer p >= 1

(define (iterated-fermat-test n p)
  (catch
    (local (a)
      (if (= p nil) (setq p 20))
      (dotimes (x p)
        (setq a (rand-range 2 (- n 2)))
        (if (!= (powmod a (- n 1) n) 1)
            (throw nil))
      )
      true)))

(for (i 1 100000) (if (iterated-fermat-test 91 10) (println "error")))
;-> error
;-> error
;-> nil

(for (i 1 100000) (if (iterated-fermat-test 91 30) (println "error")))
;-> nil

---------------------------------------------------------------------

