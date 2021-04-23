===============

 NOTE LIBERE 4

===============

------------------------
Una relazione tra π ed e
------------------------

Tra il numero pi greco (π = 3.1415926535897931) e il numero di Eulero (Nepero) (e = 2.7182818284590451) esiste la seguente relazione:

(π^4 + π^5)^(1/6) = 2.718281808611915 ≈ e = 2.7182818284590451

(setq e 2.7182818284590451)
(setq π 3.1415926535897931)
(setq x (pow (add (pow π 4) (pow π 5)) (div 6)))
;-> 2.718281808611915

Differenza tra il valore x e il numero di eulero "e":

(sub e x)
;-> 1.984713016156547e-008


--------------------------
Ricerca del numero diverso
--------------------------

Una lista contiene tutti numeri positivi uguali tranne uno. Determinare l'indice del numero diverso.

Le spiegazioni della seguente implementazione si trovano nei commenti.

(define (diverso1 lst)
(catch
  (local (a b ia ib na nb)
    ; ripetizioni del numero "a"
    (setq na -1)
    ; ripetizioni del numero "b"
    (setq nb 0)
    ; Il numero "a" è il primo elemento della lista
    (setq a (lst 0)
    ; Il numero "b" vale -1
    ; perchè non ancora assegnato
    (setq b -1)
    ; indice del numero "a"
    (setq ia 0)
    ; per ogni numero della lista...
    (dolist (el lst)
            ; se l'elemento corrente è uguale ad "a"...
      (cond ((= el a)
             ; allora aumento il numero delle ripetizioni di "a"
             (++ na))
            ; altrimenti
            (true
             ; se b=-1 allora assegno l'elemento corrente a "b"
             ; e l'indice corrente all'indice del numero b"
             (if (= b -1) (setq b el ib $idx))
             ; aumento il numero delle ripetizioni di "b"
             (++ nb))
      )
      ; se le ripetizioni di "a" sono maggiori di 1 e
      ; "b" non vale -1 (cioè "b" è stato trovato)
      ; allora restituisco l'indice di b
      (if (and (> na 1) (!= b -1)) (throw ib))
      ; se le ripetizioni di "b" sono maggiori di 1
      ; allora restituisco l'indice di a
      (if (> nb 1) (throw ia))
    ))))

Facciamo alcune prove:

(setq lst '(11 4 11 11 11))
(diverso1 lst)
;-> 1

(setq lst '(4 11 11 11 11))
(diverso1 lst)
;-> 0

(setq lst '(11 11 11 11 4))
(diverso1 lst)
;-> 4

(setq lst '(11 11 4 11 11))
(diverso1 lst)
;-> 2

Possiamo scrivere un'altra funzione che sfrutta una proprietà dell'operatore bitwise "xor". Applicando ripetutamente lo "xor" agli elementi di una lista (xor (xor (xor (xor (el1)) el2) (el3)) ... elN), se la lista contiene un solo elemento diverso da tutti gli altri (e i numeri sono tutti positivi), allora il risultato è il valore del numero diverso.
Vediamo un paio di esempi:

(setq lst '(1 2 1 1 1))
(apply ^ lst)
;-> 2
(setq lst '(1 5 1 1 1))
(apply ^ lst)
;-> 5

Quindi la funzione può essere la seguente:

(define (diverso2 lst)
  (find (apply ^ lst) lst))

(setq lst '(11 4 11 11 11))
(diverso2 lst)
;-> 1

(setq lst '(4 11 11 11 11))
(diverso2 lst)
;-> 0

(setq lst '(11 11 11 11 4))
(diverso2 lst)
;-> 4

(setq lst '(11 11 4 11 11))
(diverso2 lst)
;-> 2

Vediamo i tempi di esecuzione delle due funzioni:

(setq test '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0))
(time (diverso1 test) 100000)
;-> 611.119
(time (diverso2 test) 100000)
;-> 75.414

La seconda funzione è 8 volte più veloce.


