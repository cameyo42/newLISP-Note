================

 NOTE LIBERE 11

================

---------------------------
Il problema della celebrità
---------------------------

Ci sono N persone a una festa. A ogni persona è stato assegnato un ID univoco compreso tra 0 e N-1. Una celebrità è una persona che è nota a tutti, ma non conosce nessuno alla festa.
Il problema è quello di scoprire la celebrità alla festa:
  - se esiste la celebrità, allora restituire il suo ID.
  - se non esiste la celebrità, allora restituire nil.

Nota: Per risolvere il problema possiamo usare solo domande del tipo "A conosce B?".

Esempio: N = 4

Rappresentiamo la "conoscenza" tra due persone A e B con una matrice.
Il numero di riga rappresenta la persona A e il numero di colonna la persona B (A può conoscere più persone).
Se il valore è 1, allora A conosce B, altrimenti il valore è 0.
Il fatto che "A conosce A" viene codificato con il valore 0 (cioè la diagonale della matrice ha tutti i valori a 0).

Nel nostro esempio (0 conosce 2) (1 conosce 2) (2 conosce nessuno) (3 conosce 2):

                             0 1 2 3
                             ------- 
0 conosce 2    -->  (riga 0) 0 0 1 0
1 conosce 2    -->  (riga 1) 0 0 1 0
2 conosce nil  -->  (riga 2) 0 0 0 0
3 conosce 2    -->  (riga 3) 0 0 1 0

La matrice di input è la seguente:

(setq festa '((0 0 1 0)
              (0 0 1 0)
              (0 0 0 0)
              (0 0 1 0)))

Chiaramente la riga che ha tutti i valori a zero è l'ID della celebrità, ma dobbiamo risolvere il problema solo con domande "A conosce B?".

Funzione che effettua "A conosce B?":

(define (conosce? matrix a b) (matrix a b))

(conosce? festa 0 2)
;-> 1
(conosce? festa 0 0)
;-> 0

Metodo 1
--------

(define (celebrity matrix)
  (local (in out x len res stop)
    (setq len (length matrix))
    (setq in (array len '(0)))
    (setq out (array len '(0)))
    ; ciclo per ogni elemento della matrice
    (for (i 0 (- len 1))
      (for (j 0 (- len 1))
        (setq x (conosce? matrix i j))
        (++ (out i) x) ; i conosce --> aumenta il valore di out (out i)
        (++ (in j) x)  ; j è conosciuto --> aumenta il valore di (in j)
      )
    )
    (setq res -1)
    ; ricerca della celebrità
    (setq stop nil)
    (for (i 0 (- len 1) 1 stop)
      ; deve essere conosciuto da tutti: (in i) = n - 1
      ; non deve conoscere nessuno: (out i) = 0
      (if (and (= (in i) (- len 1)) (zero? (out i)))
          (set 'res i 'stop true)
      )
    )
    res))

(celebrity festa)
;-> 2

Complessità temporale: O(N^2)

Nota: Non può esistere più di una celebrità. 
Dimostrazione per assurdo: se A e B fossero entrambe celebrità, allora A non conoscerebbe nessuno, neanche B, quindi B non sarebbe conosciuta da tutti e non potrebbe essere una celebrità (e, viceversa, anche A non sarebbe conosciuta da B).

=============================================================================

