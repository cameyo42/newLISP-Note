===============

 NOTE LIBERE 5

===============

-------------------
Spostamento di zeri
-------------------

Data una lista di numeri interi, scrivere una funzione che sposta gli tutti gli zeri all'inizio o alla fine della lista. L'ordine degli elementi diversi da 0 deve rimanere lo stesso. Per esempio:

Input:
lista = (1 0 5 -4 0 3 0 4 -2 -1)

Output:
zeri all'inizio = (0 0 0 1 5 -4 3 4 -2 -1)
zeri alla fine  = (1 5 -4 3 4 -2 -1 0 0 0)

Un metodo per risolvere il problema è il seguente (zeri alla fine):
1) Per ogni elemento:
  se il numero corrente è diverso da zero,
  allora mettere il numero nella posizione disponibile nella lista.
2) Riempire tutti gli indici rimanenti con 0.

La seguente funzione utilizza questo metodo:

(define (move0 lst)
  ; "idx" memorizza l'indice della posizione disponibile
  (let ((idx 0) (len (length lst)))
    (for (i 0 (- len 1))
      ; se il numero corrente è diverso da zero,
      ; allora mette il numero nella posizione libera
      (if (!= (lst i) 0)
        (begin
          (setf (lst idx) (lst i))
          ; aggiorna posizione libera
          (++ idx)
        )
      )
    )
    ; sposta gli zeri (0) in fondo alla lista (gli indici rimanenti)
    (for (i idx (- len 1))
      (setf (lst i) 0)
    )
    lst))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
(move0 a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Per scrivere la funzione che mette gli zeri all'inizio è sufficiente cominciare il ciclo "for" dalla fine della lista e modificare l'inserimento di zeri al termine del ciclo.

La seguente funzione utilizza "dolist" invece del ciclo "for":

(define (move-0 lst)
  ; "idx" memorizza l'indice della posizione disponibile
  (let ((idx 0) (len (length lst)))
    (dolist (el lst)
      ; se il numero corrente è diverso da zero,
      ; allora mette il numero nella posizione libera
      (if (!= el 0)
        (begin
          (setf (lst idx) el)
          ; aggiorna posizione libera
          (++ idx)
        )
      )
    )
    ; sposta gli zeri (0) in fondo alla lista (gli indici rimanenti)
    (for (i idx (- len 1))
      (setf (lst i) 0)
    )
    lst))

(move-0 a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Adesso scriviamo una funzione che risolve lo stesso problema utilizzando le funzioni primitive "clean" e "filter":

(define (move-zero lst pos)
  (cond ((= pos 1) ; 1 ==> zeri alla fine
         (append (clean zero? lst) (filter zero? lst)))
        ((= pos 0) ; 0 ==> zeri all'inizio
         (append (filter zero? lst) (clean zero? lst)))
        (true ; default ==> zeri alla fine
         (append (clean zero? lst) (filter zero? lst)))))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
; zeri all'inizio (pos = 0)
(move-zero a 0)
;-> (0 0 0 1 5 -4 3 4 -2 -1)
; zeri alla fine (pos = 1)
(move-zero a 1)
;-> (1 5 -4 3 4 -2 -1 0 0 0)
; zeri alla fine (default)
(move-zero a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Vediamo i tempi di esecuzione delle tre funzioni:

(setq nums (rand 10 1000))
(time (move0 nums) 1000)
;-> 1552.321
(time (move-0 nums) 1000)
;-> 604.397
(time (move-zero nums) 1000)
;-> 103.849

(silent (setq nums (rand 10 10000)))
(time (move0 nums) 1000)
;-> 219458.513 ; ciclo "for" molto lento con liste con numero elementi > 1000
(time (move-0 nums) 1000)
;-> 74461.084  ; ciclo "dolist" più veloce sulle liste
(time (move-zero nums) 1000)
;-> 1042.734   ; le primitive newLISP vincono nettamente

Per velocizzare il calcolo le funzioni "move0" e "move-0" possono utilizzare anche dei vettori:

(silent (setq vec (array (length nums) nums)))
(time (move0 vec) 1000)
;-> 1368.295 ; ciclo "for" veloce con vettori
(time (move-0 vec) 1000)
;-> 1225.153 ; ciclo "dolist" veloce anche con vettori

Con l'uso dei vettori otteniamo quasi la stessa velocità della funzione "move-zero". Quindi, utilizzando i vettori i cicli "for" e "dolist" hanno velocità simili, mentre con le liste il ciclo "dolist" è molto più veloce del ciclo "for".

Un altro metodo per risolvere il problema è quello di utilizzare la logica del quicksort. L'idea è di usare 0 come elemento pivot e poi fare un ciclo per leggere tutti gli elementi e scambiare ogni elemento non pivot con la prima occorrenza del pivot.

La seguente funzione implementa questo metodo:

(define (zeri lst)
  (let (idx 0)
    ; se l'elemento è diverso da zero, 
    ; allora l'elemento viene posizionato prima del pivot 
    ; e "idx" viene incrementato
    (for (i 0 (- (length lst) 1))
      (if (!= (lst i) 0) ; 0 è il pivot
        (begin
          (swap (lst i) (lst idx))
          (++ idx)
        )
      )
    )
    lst))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
(zeri a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Vediamo la velocità di questa ultima funzione utilizzando un vettore:

(time (zeri vec) 1000)
;-> 1280.851


-----------------------
Quadratura approssimata
-----------------------

La funzione f(x) = x * ceil(x) viene chiamata "quadratura approssimata" ed è studiata nell'articolo "Approximate Squaring" di Lagarias e Sloane.
Consideriamo la frazione x = n/d quando n > d > 1. Prendiamo 8/7 come esempio e cominciamo a calcolare la funzione:

1) f(8/7) = 8/7 * (ceil 8/7) = 8/7 * 2 = 16/7, adesso applichiamo di nuovo la funzione:

2) f(16/7) = 16/7 * (ceil 16/7) = 16/7 * 3 = 48/7, adesso applichiamo di nuovo la funzione:

3) f(48/7) = 48/7 * (ceil 48/7) = 48/7 * 7 = 48 , adesso abbiamo raggiunto un numero intero e il ciclo è finito.

Il numero di passaggi dipende dalla frazioni iniziale e il suo comportamento è abbastanza caotico. Per esempio, con 6/5 si arriva in 18 passi ad un numero di 57735 cifre prima di raggiungere un numero intero, con 200/199 si arriva ad un numero di 10^435 cifre. È congetturato, ma non dimostrato, che iterando la quadratura approssimata si ottenga sempre un numero intero.
La seguente tabella mostra alcune frazioni di esempio con i relativi risultati:

  Frazione  Passi  Numero
  --------  -----  ------
  3/2       1      3
  5/2       2      60
  7/2       1      14
  9/2       3      268065
  11/2      1      33
  13/2      2      2093
  15/2      1      60
  17/2      4      1204154941925628
  19/2      1      95

Scrivere un programma che calcola il numero di passaggi per raggiungere un numero intero partendo da una frazione x = n/d con n > d > 1.

La funzione che calcola la squadratura approssimata è la seguente:

(define (approx n d)
  (div (* n (ceil (div n d))) d))

Purtroppo le funzioni "div" e "ceil" non possono essere utilizzate con i big-integer, allora simuliamo la funzione "ceil" nel modo seguente:
  se (% n d) = 0, allora (ceil (div n d)) = (/ n d)
              altrimenti (ceil (div n d)) = (+ (/ n d) 1)

Scriviamo la funzione:

(define (itera n d)
  (let (passi 0L)
    ; fintanto che n/d non è un numero intero...
    (do-until (zero? (% n d))
      (++ passi)
      ; calcola il nuovo numeratore
      (if (zero? (% n d))
        ;(setq n (* n (int (ceil (div n d)))))
        (setq n (* n (/ n d)))
        (setq n (* n (+ 1L (/ n d))))
      ))
    (list passi (/ n d))))

(itera 8L 7L)
;-> (3L 48L)
(itera 3 2)
;-> (1L 3)
(itera 9 2)
;-> (3L 268065)
(itera 17L 2L)
;-> (4L 1204154941925628L)
(itera 10L 6L)
;-> (6L 1484710602474311520L)

Vediamo il numero da 57735 cifre:

(length (last (itera 6L 5L)))
;-> 57735

La seguente espressione "crasha" newLISP...perchè  un numero di 10^435 cifre dove lo mette?

(length (last (itera 200L 199L)))
;->  puff

=============================================================================

