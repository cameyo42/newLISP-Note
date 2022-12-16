================

 NOTE LIBERE 13

================

---------------------------------------------------
Moltiplicazione tra matrici - Algoritmo di Strassen
---------------------------------------------------

https://www.geeksforgeeks.org/implementing-strassens-algorithm-in-java/

Complessità temporale: O(n^(ln 7)) = O(n^2.807)

Ipotesi di questa implementazione:
- Le matrici devono essere quadrate
- Le matrici devono avere la stessa dimensione
- La dimensione deve essere una potenza di 2 ((n & (n - 1)) == 0)

L'algoritmo è valido anche per matrici non quadrate e con dimensioni che non sono potenza di 2. In pratica si rendono quadrate queste matrici con numeri fittizi.

(define (print-matrix matrix)
"Print a matrix m x n"
  (local (row col lenmax digit fmtstr)
    (if (array? matrix) (setq matrix  (array-list matrix)))
    (setq row (length matrix))
    (setq col (length (first matrix)))
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    (setq digit (+ 1 lenmax))
    (setq fmtstr (append "%" (string digit) "s"))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println))))

(define (sub-matrix M i j rows cols)
  (local (sub-mat ic jc)
    ; no passing rows, cols then
    ; select all sub-matrix from M(i j)
    (if (= rows nil) (setq rows (- (length M) i)))
    (if (= cols nil) (setq cols (- (length (M 0)) j)))
    ; create the result array (empty)
    (setq sub-mat (array rows cols '(0)))
    ; index for rows of sub-mat
    (setq ic 0)
    (for (rr i (+ rows i -1))
      ; index for cols of sub-mat
      (setq jc 0)
      (for (cc j (+ cols j -1))
        (setf (sub-mat ic jc) (M rr cc))
        (++ jc)
      )
      (++ ic)
    )
    (array-list sub-mat)))

(define (merge-matrix A B position)
  (local (out rowsA colsA rowsB colsB)
    (setq rowsA (length A))
    (setq colsA (length (A 0)))
    (setq rowsB (length B))
    (setq colsB (length (B 0)))
    (cond ((= position "n") ; B sopra A (nord) con (colsA == colsB)
            (setq out '())
            (dolist (r B) (push r out -1))
            (dolist (r A) (push r out -1)))
          ((= position "s") ; B sotto A (sud) con (colsA == colsB)
            (setq out '())
            (dolist (r A) (push r out -1))
            (dolist (r B) (push r out -1)))
          ((= position "e") ; B a destra di A (est) con (rowsA == rowsB)
            (dolist (r A)
              (push (append r (B $idx)) out -1)))
          ((= position "o") ; B a sinistra di A (ovest) con (rowsA == rowsB)
            (dolist (r A)
              (push (append (B $idx) r) out -1)))
    )
    out))


(define (strassen A B)
  (local (R n A11 A12 A21 A22 B11 B12 B21 B22
              C11 C12 C21 C22
              M1 M2 M3 M4 M5 M6 M7 T1 T2)
    (setq n (length A))
    (cond ((= n 1)
            (setq R '((nil)))
            (setf (R 0 0) (mul (A 0 0) (B 0 0)))
            R)
          (true
            (setq A11 (sub-matrix A 0 0 (/ n 2) (/ n 2)))
            (setq A12 (sub-matrix A 0 (/ n 2) (/ n 2) (/ n 2)))
            (setq A21 (sub-matrix A (/ n 2) 0 (/ n 2) (/ n 2)))
            (setq A22 (sub-matrix A (/ n 2) (/ n 2) (/ n 2) (/ n 2)))
            (setq B11 (sub-matrix B 0 0 (/ n 2) (/ n 2)))
            (setq B12 (sub-matrix B 0 (/ n 2) (/ n 2) (/ n 2)))
            (setq B21 (sub-matrix B (/ n 2) 0 (/ n 2) (/ n 2)))
            (setq B22 (sub-matrix B (/ n 2) (/ n 2) (/ n 2) (/ n 2)))
            (setq M1 (strassen (mat + A11 A22) (mat + B11 B22)))
            (setq M2 (strassen (mat + A21 A22) B11))
            (setq M3 (strassen A11 (mat - B12 B22)))
            (setq M4 (strassen A22 (mat - B21 B11)))
            (setq M5 (strassen (mat + A11 A12) B22))
            (setq M6 (strassen (mat - A21 A11) (mat + B11 B12)))
            (setq M7 (strassen (mat - A12 A22) (mat + B21 B22)))
            (setq C11 (mat + (mat - (mat + M1 M4) M5) M7))
            (setq C12 (mat + M3 M5))
            (setq C21 (mat + M2 M4))
            (setq C22 (mat + (mat - (mat + M1 M3) M2) M6))
            (setq T1 (merge-matrix C11 C12 "e"))
            (setq T2 (merge-matrix C21 C22 "e"))
            (setq R (merge-matrix T1 T2 "s")))
    )))

Proviamo la funzione:

(strassen '((2)) '((9)))
;-> ((18))

(setq m1 '( (1 2 3 4)
            (4 3 0 1)
            (5 6 1 1)
            (0 2 5 6)))

(setq m2 '((1 0 5 1)
           (1 2 0 2)
           (0 3 2 3)
           (1 2 1 2)))

(print-matrix (setq s (strassen m1 m2)))
;->  7 21 15 22
;->  8  8 21 12
;-> 12 17 28 22
;->  8 31 16 31

(print-matrix (multiply m1 m2))
;->  7 21 15 22
;->  8  8 21 12
;-> 12 17 28 22
;->  8 31 16 31


---------------------------------------------------
Ricerca in una matrice di numeri uguali in sequenza
---------------------------------------------------

Abbiamo una matrice MxN di numeri interi.
Cercare tutte le celle della matrice che sono i numeri iniziali di una linea di una determinata lunghezza con numeri tutti uguali.
La linea può trovarsi lungo una delle 8 direzioni (n,e,s,o,ne,se,so,no).
Per esempio: cercare l'inizio di una linea di numeri 1 di lunghezza 3 -> 1 1 1.


Funzione che analizza ogni cella della matrice per vedere se si tratta dell'inizio di una linea:

Parametri:
num = numero intero da cercare
len = lunghezza della linea di numeri uguali
matrix = matrice NxM di interi

Restituisce una lista di punti iniziali del tipo:
( ((i0 j0 dir0) (i0 j0 (dir1) ... (i0 j0 dirn)))
  ((i1 j1 dir0) (i1 j1 (dir1) ... (i1 j1 dirn)))
  ...
  ((in jn dir0) (in jn (dir1) ... (in jn dirn))) )

(define (straight num len matrix)
  (local (out rows cols res)
    (setq out '())
    (setq rows (length matrix))
    (setq cols (length (first matrix)))
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (setq res (check num len r c matrix))
        ;(print r { } c { } res) (read-line)
        (if res (push res out -1))
      )
    )
    out))

Funzione ausiliaria che crea una lista con tutte le linee che partono dalla cella (i j):

Se esistono linee dalla cella (i j), allora restituisce una lista di linee:
  ((i0 j0 dir0) (i1 j1 (dir1) ... (in jn dirn)))
Se la cella non è un estremo, restituisce nil.

(define (check num len i j matrix)
  (local (rows cols ext out)
    (setq out nil)
    (setq rows (length matrix))
    (setq cols (length (first matrix)))
    (setq ext (- len 1))
    ; il numero corrente deve essere uguale a quello da cercare
    (if (= num (matrix i j))
      (begin
        ; search right - est
        (if (< (+ j ext) cols) (begin
            (setq equal true)
            ;(for (k 1 ext)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix i (+ j k))) (setq equal nil))
            )
            (if equal (push (list i j "e") out -1)))
        )
        ; search left - ovest
        (if (>= (- j ext) 0) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix i (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "o") out -1)))
        )
        ; search down - sud
        (if (< (+ i ext) rows) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (+ i k) j)) (setq equal nil))
            )
            (if equal (push (list i j "s") out -1)))
        )
        ; search up - nord
        (if (>= (- i ext) 0) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (- i k) j)) (setq equal nil))
            )
            (if equal (push (list i j "n") out -1)))
        )
        ; search up-right - nord-est
        (if (and (>= (- i ext) 0) (< (+ j ext) cols)) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (- i k) (+ j k))) (setq equal nil))
            )
            (if equal (push (list i j "ne") out -1)))
        )
        ; search up-left - nord-ovest
        (if (and (>= (- i ext) 0) (>= (- j ext) 0)) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (- i k) (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "no") out -1)))
        )
        ; search down-left - sud-ovest
        (if (and (< (+ i ext) rows) (>= (- j ext) 0)) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (+ i k) (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "so") out -1)))
        )
        ; search down-right - sud-est
        (if (and (< (+ i ext) rows) (< (+ j ext) cols)) (begin
            (setq equal true)
            (for (k 1 ext 1 (not equal))
              (if (!= (matrix i j) (matrix (+ i k) (+ j k))) (setq equal nil))
            )
            (if equal (push (list i j "se") out -1)))
        )
      ) ;begin
    ) ;if
    out))

Facciamo alcune prove:

(setq test '((1 1 1 1)
             (1 1 1 1)
             (1 1 1 1)
             (1 1 1 1)))

(straight 1 4 test)
;-> (((0 0 "e") (0 0 "s") (0 0 "se"))
;->  ((0 1 "s"))
;->  ((0 2 "s"))
;->  ((0 3 "o") (0 3 "s") (0 3 "so"))
;->  ((1 0 "e"))
;->  ((1 3 "o"))
;->  ((2 0 "e"))
;->  ((2 3 "o"))
;->  ((3 0 "e") (3 0 "n") (3 0 "ne"))
;->  ((3 1 "n"))
;->  ((3 2 "n"))
;->  ((3 3 "o") (3 3 "n") (3 3 "no")))

(straight 1 2 test)
;-> (((0 0 "e") (0 0 "s") (0 0 "se"))
;->  ((0 1 "e") (0 1 "o") (0 1 "s") (0 1 "so") (0 1 "se"))
;->  ((0 2 "e") (0 2 "o") (0 2 "s") (0 2 "so") (0 2 "se"))
;->  ((0 3 "o") (0 3 "s") (0 3 "so"))
;->  ((1 0 "e") (1 0 "s") (1 0 "n") (1 0 "ne") (1 0 "se"))
;->  ((1 1 "e") (1 1 "o") (1 1 "s") (1 1 "n") (1 1 "ne") (1 1 "no") (1 1 "so") (1 1 "se"))
;->  ((1 2 "e") (1 2 "o") (1 2 "s") (1 2 "n") (1 2 "ne") (1 2 "no") (1 2 "so") (1 2 "se"))
;->  ((1 3 "o") (1 3 "s") (1 3 "n") (1 3 "no") (1 3 "so"))
;->  ((2 0 "e") (2 0 "s") (2 0 "n") (2 0 "ne") (2 0 "se"))
;->  ((2 1 "e") (2 1 "o") (2 1 "s") (2 1 "n") (2 1 "ne") (2 1 "no") (2 1 "so") (2 1 "se"))
;->  ((2 2 "e") (2 2 "o") (2 2 "s") (2 2 "n") (2 2 "ne") (2 2 "no") (2 2 "so") (2 2 "se"))
;->  ((2 3 "o") (2 3 "s") (2 3 "n") (2 3 "no") (2 3 "so"))
;->  ((3 0 "e") (3 0 "n") (3 0 "ne"))
;->  ((3 1 "e") (3 1 "o") (3 1 "n") (3 1 "ne") (3 1 "no"))
;->  ((3 2 "e") (3 2 "o") (3 2 "n") (3 2 "ne") (3 2 "no"))
;->  ((3 3 "o") (3 3 "n") (3 3 "no")))

(setq test1 '((1 0 1 0)
              (1 0 1 0)
              (1 0 1 0)
              (1 0 1 0)))

(straight 1 2 test1)
;-> (((0 0 "s"))
;->  ((0 2 "s"))
;->  ((1 0 "s") (1 0 "n"))
;->  ((1 2 "s") (1 2 "n"))
;->  ((2 0 "s") (2 0 "n"))
;->  ((2 2 "s") (2 2 "n"))
;->  ((3 0 "n"))
;->  ((3 2 "n")))

(straight 0 3 test1)
;-> (((0 1 "s"))
;->  ((0 3 "s"))
;->  ((1 1 "s"))
;->  ((1 3 "s"))
;->  ((2 1 "n"))
;->  ((2 3 "n"))
;->  ((3 1 "n"))
;->  ((3 3 "n")))


------------------
Potere di acquisto
------------------

A) Se il nostro stipendio aumenta del 30% (e i prezzi rimangono stabili) di quanto aumenta il nostro potere di acquisto?

B) Se i prezzi scendono del 30% (e lo stipendio rimane stabile) di quanto diminuisce il nostro potere di acquisto?

Situazione iniziale:
Guadagniamo 100 e spendiamo 100 --> potere = 100/100 = 1 = 100%

Situazione A (+30% stipendio):
Guadagniamo 130 e spendiamo 100 --> potere = 130/100 = 1.3 = 100% + 30%

Situazione B (-30% prezzi):
Guadagniamo 100 e spendiamo 70  --> potere = 100/70 = 1.4286 = 100% + 42.86%

Quindi è più conveniente che diminuiscano i prezzi.


-------------------------------
Copertura di segmenti con punti
-------------------------------

Trovare il numero minimo di punti necessari per individuare tutti i segmenti lungo una linea.

Data una lista di segmenti costituita da coppie di numeri interi positivi che denotano rispettivamente i punti iniziale e finale di ogni segmento (start end), il compito è trovare il numero minimo di numeri interi che si trovano in almeno uno dei segmenti dati e ogni segmento contiene almeno uno di loro.

Il modo matematico di descrivere il problema è considerare ogni dato intervallo di numeri interi come un segmento di linea definito da due coordinate intere (x1 x2) su una linea.
Quindi il numero minimo di numeri interi richiesti per coprire ciascuno dell'intervallo dato è il numero minimo di punti tale che ogni segmento contenga almeno un punto.

Esempi
------

Input: segmenti = ((1 3) (2 5) (3 6))
Output: 3
Spiegazione:
Tutti e tre gli intervalli (1 3), (2 5), (3 6) contengono il numero intero 3.

              |
              3-----------6
              |
          2-----------5
              |
      1-------3
              |
  +---+---+---+---+---+---+---+
  0   1   2   3   4   5   6   7

Input: segmenti = ((4 7) (1 3) (2 5) (5 6)))
Output: 3 6 oppure 2 5 oppure ...
Spiegazione:
I segmenti (1 3) e (2 5) contengono il numero intero 3.
I segmenti (4 7) e (5 6) contengono il numero intero 6.

I segmenti (1 3) e (2 5) contengono il numero intero 2.
I segmenti (2 5) (4 7) e (5 6) contengono il numero intero 5.


              |           |                    |           |
              |       5---6                    |           5---6
              |           |                    |           |
          2-----------5   |                    2-----------5
              |           |                    |           |
      1-------3           |                1-------3       |
              |           |                    |           |
              |   4-----------7                |       4-----------7
              |           |                    |           |
  +---+---+---+---+---+---+---+        +---+---+---+---+---+---+---+
  0   1   2   3   4   5   6   7        0   1   2   3   4   5   6   7

In alcuni casi ci possono essere diverse soluzioni.

Algortimo 1
-----------
Trovare il valore minimo di tutti i punti iniziali e il valore massimo di tutti i punti finali di tutti i segmenti.
Iterare su questo intervallo e per ogni punto in questo intervallo tenere traccia del numero di segmenti che possono essere coperti usando questo punto.
Utilizzare un array per memorizzare il numero di segmenti come:

arr(punto) = numero di segmenti che sono attraversati da questo punto

1. Trovare il valore massimo nell'array arr[].
2. Se questo valore massimo è uguale a N, l'indice corrispondente a questo valore è il punto che copre tutti i segmenti.
3. Se questo valore massimo è minore di N, allora l'indice corrispondente a questo valore è un punto che copre alcuni segmenti.
4. Ripetere i passaggi da 1 a 3 per l'array arr[] escludendo questo valore massimo finché la somma di tutti segmenti relativi ai valori massimi trovati non è uguale a N.
Nota: ogni valore massimo ha associati i relativi segmenti che attraversa. Non è corretto sommare i valori massimi, bisogna sommare i segmenti nuovi (per la soluzione) associati ad ogni valore massimo.

Vediamo una funzione che mostra la situazione:

(define (within x a b) (and (>= x a) (<= x b)))

(define (max-idx lst)
  (let ((massimo (apply max lst)))
    (list massimo (first (ref massimo lst)))))

(define (pts-seg-status lst)
  (local (x1 x2 min-x max-x arr out x-seg seg maxidx idx)
    (setq all '())
    ; numero di segmenti
    (setq n (length lst))
    ; coordinate iniziali
    (setq x1 (map first lst))
    ; coordinate finali
    (setq x2 (map last lst))
    ; valore minimo iniziale
    (setq min-x (apply min x1))
    ; valore massimo finale
    (setq max-x (apply max x2))
    ; arr(i) = numero di segmenti che contengono/attraversano "i"
    (setq arr (array (+ max-x 2 (- min-x)) '(0)))
    ; ciclo per ogni punto intero
    (for (x min-x max-x)
      (setq x-seg '())
      (dolist (s lst)
        (if (within x (s 0) (s 1))
          (begin
            (push s x-seg -1)
            (++ (arr x))
          )
        )
      )
      ; (numero segmenti lista-segmenti)
      (push (list x (length x-seg) x-seg) all -1)
    )
    all))

Vediamo cosa abbiamo dopo i primi 3 passi dell'agoritmo:

(setq p1 '((1 3) (2 5) (3 6)))
(pts-seg-status p1)
;-> ((1 1 ((1 3)))
;->  (2 2 ((1 3) (2 5)))
;->  (3 3 ((1 3) (2 5) (3 6)))
;->  (4 2 ((2 5) (3 6)))
;->  (5 2 ((2 5) (3 6)))
;->  (6 1 ((3 6))))

(setq p2 '((4 7) (1 3) (2 5) (5 6)))
(pts-seg-status p2)
;-> ((1 1 ((1 3)))
;->  (2 2 ((1 3) (2 5)))
;->  (3 2 ((1 3) (2 5)))
;->  (4 2 ((4 7) (2 5)))
;->  (5 3 ((4 7) (2 5) (5 6)))
;->  (6 2 ((4 7) (5 6)))
;->  (7 1 ((4 7))))

Adesso il passo 4 consiste nel selezionare i punti massimi e contare quanti segmenti nuovi aggiungono alla soluzione fino ad arrivare al numero totale di segmenti.

Invece di scrivere questa parte, utilizziamo un algoritmo greedy più veloce.

Algoritmo 2
-----------
1) Ordinare in modo ascendente i segmenti in base ai loro punti finali.
2) Inizializzare il punto corrente come primo punto finale (punto finale minimo).
3) Inserire il punto corrente nella lista soluzione.
4) Loop sui punti finali
     se il punto corrente non si trova nel segmento corrente,
     allora aggiornare il punto corrente come punto finale del segmento corrente
            e
            inserire il punto corrente nella soluzione.
5) Restituire la lista soluzione.

(define (pts-seg seg)
  (local (pts p)
    ; ordina lista ind modo crescente rispetto al punto finale dei segmenti
    (sort seg (fn (x y) (<= (last x) (last y))))
    ; lista soluzione
    (setq pts '())
    ; il primo punto corrente è il punto finale del primo segmento
    (setq p (seg 0 1))
    ; il punto finale del primo segmento fa parte della soluzione
    (push p pts -1)
    (for (i 1 (- (length seg) 1))
      ; se in punto corrente non si trova nel segmento corrente
      (if (or (< p (seg i 0)) (> p (seg i 1)))
        (begin
          ; aggiorna il punto corrente
          (setq p (seg i 1))
          ; inserisce il punto corrente nella soluzione
          (push p pts -1)
        )
      )
    )
    pts))

Complessità temporale:v O(n*log(n))

Proviamo la funzione:

(setq p1 '((1 3) (2 5) (3 6)))
(pts-seg p1)
;-> (3)

(setq p2 '((4 7) (1 3) (2 5) (5 6)))
(pts-seg p2)
;-> (3 6)

(setq p3 '((1 2) (5 7) (8 9)))
(pts-seg p3)
;-> (2 7 9)

(setq p4 '((5 6) (4 7) (3 8) (2 9)))
(pts-seg p4)
;-> (6)


------------------------------------------------------------
Distanza approssimata tra due punti - Fast square root trick
------------------------------------------------------------

Per trovare la distanza approssimata tra due punti 2D abbiamo a disposizione diversi metodi.

  P1 = (x1 y1)
  P2 = (x2 y2)

1) Fast square root trick (Max + Min/2)
  dx = abs(x2 - x1)
  dy = abs(y2 - y1)
  Se dx>dy, distanza-approssimata = dx + dy/2
  Se dx<dy, distanza-approssimata = dx/2 + dy

                      P2
                       + +
                      /| |
                     / | |
                    /  | |
                   /   | dy
                  /    | |
                 /     | |
             P1 +------+ +
                +--dx--+

2) Max + Min/4
  dx = abs(x2 - x1)
  dy = abs(y2 - y1)
  Se dx>dy, distanza-approssimata = dx + dy/4
  Se dx<dy, distanza-approssimata = dx/4 + dy

3) Max + 3*Min/8
  dx = abs(x2 - x1)
  dy = abs(y2 - y1)
  Se dx>dy, distanza-approssimata = dx + (3/8)*dy
  Se dx<dy, distanza-approssimata = (3/8)*dx + dy

4) Octagonal (0.941246*Max + 0.41*Min)
  dx = abs(x2 - x1)
  dy = abs(y2 - y1)
  Se dx>dy, distanza-approssimata = 0.941246dx + 0.41dy
  Se dx<dy, distanza-approssimata = 0.41dx + 0.941246dy

Scriviamo le funzioni per tutte le distanze:

; distanza esatta
(define (dist2d x1 y1 x2 y2)
"Calculates 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2)))))
; Max + Min/2
(define (distance1 x1 y1 x2 y2)
  (local (dx dy)
    (setq dx (abs (sub x2 x1)))
    (setq dy (abs (sub y2 y1)))
    (if (> dx dy)
      (add dx (div dy 2))
      (add dy (div dx 2)))))
; Max + Min/4
(define (distance2 x1 y1 x2 y2)
  (local (dx dy)
    (setq dx (abs (sub x2 x1)))
    (setq dy (abs (sub y2 y1)))
    (if (> dx dy)
      (add dx (div dy 4))
      (add dy (div dx 4)))))
; Max + 3*Min/8
(define (distance3 x1 y1 x2 y2)
  (local (dx dy)
    (setq dx (abs (sub x2 x1)))
    (setq dy (abs (sub y2 y1)))
    (if (> dx dy)
      (add dx (div (mul 3 dy) 8))
      (add dy (div (mul 3 dx) 8)))))
; (0.941246*Max + 0.41*Min)
(define (distance4 x1 y1 x2 y2)
  (local (dx dy)
    (setq dx (abs (sub x2 x1)))
    (setq dy (abs (sub y2 y1)))
    (if (> dx dy)
      (add (mul dx 0.941246) (mul dy 0.41))
      (add (mul dx 0.41) (mul dy 0.941246)))))

Facciamo alcune prove:

(setq pp (rand 10 4))
;-> (8 1 2 9)
(apply dist2d pp) ;distanza esatta
;-> 10
(apply distance1 pp)
;-> 11
(apply distance2 pp)
;-> 9.5
(apply distance3 pp)
;-> 10.25
(apply distance4 pp)
;-> 9.989968

Adesso vediamo quale errore si commette nell'uso di queste funzioni.

Errore assoluto
---------------

ErroreAssoluto = ValoreMisurato - ValoreEsatto

L'errore assoluto è un valore con segno.

Errore relativo
---------------

                   ErroreAssoluto
ErroreRelativo = -----------------
                    ValoreMedio

Nel caso di due misure "a" = valore misurato e "b" = valore esatto, il valore medio delle misurazioni vale "b":
                         (a - b)
  ErroreRelativo(a,b) = ---------
                         abs(b)

L'errore relativo è un valore con segno.

Funzioni per il calcolo dell'errore relativo:

(define (err a b)
  ; errore relativo
  (if (zero? a)
      0
      (div (sub a b) (abs b))))

(define (err% a b)
  ; errore relativo %
  (if (zero? a)
      0
      (mul 100 (div (abs (sub a b)) (abs b)))))

Nota: attenzione ai valori assoluti e ai valori negativi. Calcolare un valore assoluto o meno di una espressione dipende dal tipo di risultato che vogliamo ottenere.

La seguente funzione calcola l'errore relativo massimo e l'errore relativo medio per ogni funzione di distanza:

(define (errors iter)
  (local (func coords dist err-max err-sum err-avg e)
    (setq func '(dist2d distance1 distance2 distance3 distance4))
    (setq dist (array 5 '(0)))
    (setq err-max (array 5 '(0)))
    (setq err-sum (array 5 '(0)))
    (setq err-avg (array 5 '(0)))
    (setq error 0)
    (setq all 0)
    (for (i 1 iter)
      (setq coords (rand 10 4))
      ; calcola tutte le distanze
      (dolist (f func)
        (setf (dist $idx) (apply f coords))
      )
      ; aggiorna err-max e err-sum per ogni distanza
      (for (i 0 4)
        ; calcola errore distanza corrente
        (setq e (err (dist i) (dist 0)))
        (if (< (abs (err-max i)) (abs e))
            (setf (err-max i) e)
        )
        (setf (err-sum i) (add (err-sum i) (abs e)))
      )
    )
    ; calcola errore relativo medio
    (for (i 0 4)
      (setf (err-avg i) (div (err-sum i) iter))
    )
    (setq err-max (map (fn(x) (round (mul 100 x) -2)) err-max))
    (setq err-avg (map (fn(x) (round (mul 100 x) -2)) err-avg))
    (println err-max)
    (println err-avg)
    ))

(errors 1e4)
;-> (0 11.8 -11.61 6.8 -5.88)
;-> (0 7.73 3.22 3.87 2.7)

In definitiva abbiamo la seguente tabella:

                   Metodo    err-max    err-avg
                   ------    -------    -------
              Max + Min/2      11.80       7.73
              Max + Min/4     -11.61       3.22
            Max + 3*Min/8       6.80       3.87
(0.941246*Max + 0.41*Min)      -5.88       2.70

A questo punto bisogna vedere la velocità di queste funzioni.

(define (test func iter) (for (i 1 iter) (apply func (rand 100 4))))

(time (test dist2d 1e5))
;-> 63.961
(time (test distance1 1e5))
;-> 65.961
(time (test distance2 1e5))
;-> 78.571
(time (test distance3 1e5))
;-> 80.512
(time (test distance4 1e5))
;-> 82.605

Il risultato è abbastanza sorprendente, la funzione "dist2d" che calcola la distanza esatta è la più veloce (anche se calcola una radice quadrata).

Per cercare di capire cosa accade vediamo le seguenti funzioni (una con "sqrt" e una con un "if"):

(define (t1 a b) (sqrt (add (mul a a) (mul b b))))
(define (t2 a b)
    (if (< a b) (add (mul a a) (mul b b))
                (add (mul a a) (mul b b))))

Calcoliamo la loro velocità:

(time (t1 120 140) 1e6)
;-> 128.359
(time (t2 120 140) 1e6)
;-> 128.402

Sembra che in newLISP la funzione "if" pesa come "sqrt"  (?!).

Nota: nello spazio 3D, ordinando i lati in decrescente di lunghezza dx1, dx2, dx3 possiamo utilizzare la seguente formula per calcolare la distanza approssimata tra due punti P1(x1 y1 z1) e P2(x2 y2 z2):

  0.9398*dx1 + 0.3893*dx2 + 0.2987*dx3

con un errore massimo del 6.0%.


----------------------------------------------------------------
Errore quadratico medio (RMSE) e errore medio percentuale (MAPE)
----------------------------------------------------------------

Errore quadratico medio - Root Mean Square error (RMSE)
-------------------------------------------------------

             Sum[i=1,n]((Vp(i) - Vr(i))^2)
RMSE = sqrt(-------------------------------)
                           n

Vp = valore previsto (misurato)
Vr = valore reale

RMSE è sempre non negativo e un valore pari a 0 (quasi mai raggiunto nella pratica) indica un adattamento perfetto ai dati.
In generale, un RMSE più basso è migliore di uno più alto.
Tuttavia, i confronti tra diversi tipi di dati non sarebbero validi perché la misura dipende dalla scala dei numeri utilizzati.

RMSE è la radice quadrata della media degli errori al quadrato.
L'effetto di ciascun errore su RMSE è proporzionale alla dimensione dell'errore al quadrato, quindi errori più grandi hanno un effetto sproporzionatamente grande su RMSE.
Di conseguenza, RMSE è sensibile ai valori anomali (outliers).

Purtroppo non è un valore facile da spiegare (è la deviazione standard dei valori residui cioè Vp(i) - Vr(i)), ma più basso è questo valore, più il modello predice bene i risultati futuri (in genere).

(define (RMSE lst1 lst2)
  (sqrt (div
          (apply add (map (fn(x y) (mul (sub x y) (sub x y))) lst1 lst2))
          (length lst1))))

(setq vr '(11 20 19 17 10))
(setq vp '(12 18 19.5 18 9))
(RMSE vr vp)
;-> 1.45
(RMSE vp vr)
;-> 1.45

Errore medio percentuale - Mean Absolute Percentage Error (MAPE)
----------------------------------------------------------------

        Sum[i=1,n](abs((Vr(i) - Vp(i))/Vr(i)))
MAPE = -----------------------------------------
                           n

Vr = valore reale
Vp = valore previsto (misurato)

Questo valore esprime l'accuratezza del modello, ovvero quanto il modello sbaglia in % rispetto al valore reale.

(define (MAPE lst1 lst2)
  (div
    (apply add (map (fn(x y) (abs (div (sub x y) x))) lst1 lst2))
    (length lst1)))

(setq vr '(11 20 19 17 10))
(setq vp '(12 18 19.5 18 9))
(MAPE vr vp)
;-> 0.07520968195890795
(MAPE vp vr)
;-> 0.07735042735042734

Vediamo un altro esempio:

(setq vr '(95 120 110 75))
(setq vp '(90 110 130 85))
(RMSE vp vr)
;-> 12.5
(MAPE vr vp)
;-> 0.1127791068580542


-------
TimSort
-------

TimSort è un algoritmo di ordinamento basato su Insertion Sort e Merge Sort.
Viene usato in Java e in Python.
L'idea di base è quella dividere la lista in piccoli pezzi ordinati con l'Insertion Sort e poi unire il tutto con il Merge Sort.
I pezzi della lista vengono ordinati con l'Insertion Sort perchè è un algoritmo che funziona molto bene con liste piccole.
In genere il numero di "Run" è una potenza di 2, perchè in questo caso la loro unione con il Merge Sort funziona in modo ottimale.
Il numero di "Run" può variare da 32 a 64 a seconda della dimensione della lista.

L'algoritmo implementato è il seguente:
1) Numero di "Run": 32
2) Ordinare uno per uno i "Run" di dimensioni uguali con Insertion Sort
3) Unire i "Run" uno per uno con il Merge Sort.
La dimensione delle sottoliste unite viene raddoppiata dopo ogni iterazione.

Nota: per semplicità questa implementazione ha il vincolo che quando "Run" è minore della lunghezza della lista, allora "Run" deve essere un sottomultiplo della lunghezza della lista.
Quando "Run" è maggiore della lunghezza della lista, allora viene utilizzato solo l'algoritmo di InsertionSort e non c'è alcun vincolo (ma non sfruttiamo l'idea del TimSort).

Complessità temporale
Caso migliore: O(n)
Caso medio:    O(n*log(n))
Caso peggiore: O(n*log(n))

; Funzione che ordina la lista dall'indice sinistro all'indice destro;
; (che è di dimensioni al massimo RUN)
(define (insertionSort arr left right)
  (local (j temp)
    (for (i (+ left 1) right)
      (setq temp (arr i))
      (setq j (- i 1))
      (while (and (>= j left) (> (arr j) temp))
        (setf (arr (+ j 1)) (arr j))
        (-- j)
      )
      (setf (arr (+ j 1)) temp)
    )
    arr))

Facciamo alcune prove:

(setq lst '(8 3 6 9 7 4 10 0 2 -2))
(insertionSort lst 0 3)
;-> (3 6 8 9 7 4 10 0 2 -2)
(insertionSort lst 0 9)
;-> (-2 0 2 3 4 6 7 8 9 10)

; Funzione che unisce i RUN ordinati
(define (mergeSort arr l m r)
  (local (len1 len2 left right i j k)
    ; la lista originale viene divisa in due parti:
    ; lista sinistro e lista destra
    (setq len1 (+ m 1 (- l)))
    (setq len2 (- r m))
    (setq left (array len1 '(0)))
    (setq right (array len2 '(0)))
    (for (x 0 (- len1 1))
      (setf (left x) (arr (+ l x)))
    )
    (for (x 0 (- len2 1))
      (setf (right x) (arr (+ m 1 x)))
    )
    (setq i 0) (setq j 0) (setq k l)
    ; Dopo il confronto, unisce due liste in una lista più grande
    (while (and (< i len1) (< j len2))
      (if (<= (left i) (right j))
          (begin (setf (arr k) (left i)) (++ i))
          (begin (setf (arr k) (right j)) (++ j))
      )
      (++ k)
    )
    ; Copia gli elementi rimanenti di sinistra, se presenti
    (while (< i len1)
      (setf (arr k) (left i))
      (++ k)
      (++ i)
    )
    ; Copia gli elementi rimanenti di destra, se presenti
    (while (< j len2)
      (setf (arr k) (right j))
      (++ k)
      (++ j)
    )
    arr))

Facciamo alcune prove:

(setq lst1 '(1 2 3 4 5 6 7 8))
(mergeSort lst1 0 4 7)
;-> (1 2 3 4 5 6 7 8)

(setq lst2 '(5 6 7 1 2 3 4))
(mergeSort lst2 0 2 6)
;-> (1 2 3 4 5 6 7)

(setq lst3 '(5 6 7 8 1 2 3 4))
(mergeSort lst3 0 3 7)
;-> (1 2 3 4 5 6 7 8)

; Funzione iterativa Timsort per ordinare una lista (0..n-1)
(define (timSort arr run)
  (local (n size mid right)
    (setq n (length arr))
    ; Sort individual subarrays of size RUN
    ; Ordina le singole sottoliste di dimensioni Run
    (for (i 0 (- n 1) run)
      (setq arr (insertionSort arr i (min (+ i run -1) (- n 1))))
      ;(println arr) (read-line)
    )
    ; Inizia l'unione dalla dimensione Run.
    ; L'unione lavora con dimensioni 64, poi 128, 256 e così via....
    (setq size run)
    (while (< size n)
      ; Trova il punto di partenza della sottolista sinistra.
      ; Unisce arr[left..left+size-1] e arr[left+size, left+2*size-1]
      ; Dopo ogni unione, aumenta a sinistra di 2*size
      (for (left 0 (- n 1) (* 2 size))
        ; Trova il punto finale della sottolista sinistra
        ; mid+1 è il punto di partenza della sottolista destra
        (setq mid (+ left size -1))
        (setq right (min (+ left (* 2 size) -1) (- n 1)))
        ; Merge sub array arr[left.....mid] e arr[mid+1....right]
        (if (< mid right)
          (setq arr (mergeSort arr left mid right))
        )
        ;(println arr) (read-line)
      )
      (setq size (* 2 size))
    )
    arr))

Facciamo alcune prove:

(setq lst '(8 3 6 9 7 4 10 0 2 -2 11 12 13 16 15 14))
(timSort lst 32)
;-> (-2 0 2 3 4 6 7 8 9 10 11 12 13 14 15 16) ; solo InsertionSort

(timSort lst 4)
;-> (-2 0 2 3 4 6 7 8 9 10 11 12 13 14 15 16) ; InsertionSort e MergeSort

(setq a '(3 -4 -5 6 8 -3))
(timSort a 2)
;-> (-5 -4 -3 3 6 8)

Nota: questa implementazione è solo per capire come funziona l'algoritmo TimSort, la funzione integrata "sort" è molto più veloce di qualunque altra funzione di ordinamento.


-------------
Counting Sort
-------------

L'algoritmo Counting Sort appartiene alla categoria degli algoritmi di ordinamento che non richiedono confronti tra valori (algoritmi di ordinamento non basati sul confronto).
Questo algoritmo utilizza uno intricato metodo per calcolare correttamente le posizioni di ciascun valore nella lista.

Si effettuano diversi passaggi sulla lista dei numeri durante il processo di ordinamento.
Il primo passaggio è necessario per trovare il numero massimo nell'elenco.
Quindi usiamo questo numero per generare un elenco di dimensioni di numero massimo + 1.
Quindi contiamo il numero di istanze di ogni numero che appare nella lista e memorizziamo questo valore di conteggio nella lista che abbiamo appena creato.
Dopo aver completato questo tipo di conteggio, iteriamo sull'intera nuova lista, sommando cumulativamente tutti i valori al suo interno.

Infine, utilizzando una formula è possibile determinare correttamente l'indice di ciascun numero, all'interno di una nuova lista di dimensione n, dove n è il numero di cifre nella lista originale. Questa nuova lista è una versione completamente ordinata della lista originale di numeri non ordinati.

(define (counting-sort lst)
  (local (val-max conteggi arr idx)
    ; calcola valore massimo della lista
    (setq val-max (apply max lst))
    # Crea vettore di val-max elementi
    (setq conteggi (array (+ val-max 1) '(0)))
    (println conteggi)
    ; Calcola il conteggio di ogni numero della lista
    (dolist (el lst)
      (++ (conteggi el))
    )
    (println conteggi)
    ; Cacola la somma cumulativa dei punteggi
    (for (i 1 (- (length conteggi) 1))
      (setf (conteggi i) (+ (conteggi i) (conteggi (- i 1))))
    )
    (println conteggi)
    ; Fase di ordinamento (applicazione della formula)
    (setq arr (array (length lst) '(0)))
    (dolist (el lst)
      (setq idx (- (conteggi el) 1))
      (setf (arr idx) el)
      (-- (conteggi el))
    )
    arr))

(setq a '(8 1 3 5 2 0 10 2 5))
(counting-sort a)
;-> (0 0 0 0 0 0 0 0 0 0 0)
;-> (1 1 2 1 0 2 0 0 1 0 1)
;-> (1 2 4 5 5 7 7 7 8 8 9)
;-> (0 1 2 2 3 5 5 8 10)

Cosa accade se la lista contiene numeri negativi?

(setq b '(-1 3 -5 8 4 -3 -1))
(counting-sort b)
;-> (0 0 0 0 0 0 0 0 0)
;-> (0 0 0 1 2 0 1 0 3)
;-> (0 0 0 1 3 3 4 4 7)
;-> (3 4 -5 -3 -1 8 -1)

(setq c '(-1 3 -5 -8 4 -3 -1))
(counting-sort c)
;-> ERR: array index out of bounds in function ++ : -3
;-> called from user function (counting-sort c)

Nel primo caso l'algoritmo non produce i risultati corretti perchè la formula usa indici negativi.
Nel secondo caso il vettore dei conteggi contiene solo 3 elementi (perchè 3 è il numero massimo della lista) e viene generata un errore di indicizzazione.

Per ordinare una lista con numeri negativi possiamo usare il seguente metodo:

1) Calcolare il valore assoluto del valore minimo della lista
2) Sommare il valore minimo ad ogni elemento della lista
3) Ordinare la lista
4) Sottrarre il valore minimo ad ogni elemento della lista
5) Calcolare il valore assoluto del valore minimo della lista

Per esempio:

Sommare il valore minimo ad ogni elemento della lista:
(setq b1 (map (fn(x) (+ x minimo)) b))
;-> (4 8 0 13 9 2 4)

Ordinare la lista:
(setq b2 (counting-sort b1))
;-> (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
;-> (1 0 1 0 2 0 0 0 1 1 0 0 0 1)
;-> (1 1 2 2 4 4 4 4 5 6 6 6 6 7)
;-> (0 2 4 4 8 9 13)

Sottrarre il valore minimo ad ogni elemento della lista:
(setq b3 (map (fn(x) (- x minimo)) b2))
;-> (-5 -3 -1 -1 3 4 8)


-------------------------------------------------------
Caratteristiche dei principali algoritmi di ordinamento
-------------------------------------------------------

                   +-----------------------------------------------+
                   |             Complessità-temporale             |
  +----------------+---------------+---------------+---------------+
  | Algoritmo      | Caso-medio    | Caso-migliore | Caso-peggiore |
  +----------------+---------------+---------------+---------------+
  | Bubble-Sort    | O(n^2)        | O(n)          | O(n^2)        |
  +----------------+---------------+---------------+---------------+
  | Insertion-Sort | O(n^2)        | O(n)          | O(n^2)        |
  +----------------+---------------+---------------+---------------+
  | Selection-Sort | O(n^2)        | O(n^2)        | O(n^2)        |
  +----------------+---------------+---------------+---------------+
  | Quick-Sort     | O(n*log(n))   | O(n*log(n))   | O(n^2)        |
  +----------------+---------------+---------------+---------------+
  | Merge-Sort     | O(n*log(n))   | O(n*log(n))   | O(n*log(n))   |
  +----------------+---------------+---------------+---------------+
  | Heap-Sort      | O(n*log(n))   | O(n*log(n))   | O(n*log(n))   |
  +----------------+---------------+---------------+---------------+
  | Counting-Sort  | O(n+k)        | O(n+k)        | O(n+k)        |
  +----------------+---------------+---------------+---------------+
  | Radix-Sort     | O(n*k)        | O(n*k)        | O(n*k)        |
  +----------------+---------------+---------------+---------------+
  | Bucket-Sort    | O(n+k)        | O(n+k)        | O(n^2)        |
  +----------------+---------------+---------------+---------------+

  +----------------+----------------------+
  | Algoritmo      | Complessità-spaziale |
  +----------------+----------------------+
  | Bubble-Sort    | O(1)                 |
  +----------------+----------------------+
  | Insertion-Sort | O(1)                 |
  +----------------+----------------------+
  | Selection-Sort | O(1)                 |
  +----------------+----------------------+
  | Quick-Sort     | O(log(n))            |
  +----------------+----------------------+
  | Merge-Sort     | O(n)                 |
  +----------------+----------------------+
  | Heap-Sort      | O(1)                 |
  +----------------+----------------------+
  | Counting-Sort  | O(k)                 |
  +----------------+----------------------+
  | Radix-Sort     | O(n+k)               |
  +----------------+----------------------+
  | Bucket-Sort    | O(n)                 |
  +----------------+----------------------+

  +----------------+----------+-----------+
  | Algoritmo      | Stabile? | In-Place? |
  +----------------+----------+-----------+
  | Bubble-Sort    | Si       | Si        |
  +----------------+----------+-----------+
  | Insertion-Sort | Si       | Si        |
  +----------------+----------+-----------+
  | Selection-Sort | No       | Si        |
  +----------------+----------+-----------+
  | Quick-Sort     | No       | Si        |
  +----------------+----------+-----------+
  | Merge-Sort     | Si       | No        |
  +----------------+----------+-----------+
  | Heap-Sort      | No       | Si        |
  +----------------+----------+-----------+
  | Counting-Sort  | Si       | No        |
  +----------------+----------+-----------+
  | Radix-Sort     | Si       | No        |
  +----------------+----------+-----------+
  | Bucket-Sort    | Si       | No        |
  +----------------+----------+-----------+

Un algoritmo di ordinamento è "Stabile" se due oggetti con chiavi uguali appaiono nell'output ordinato nello stesso ordine in cui appaiono nel set di dati di input. Formalmente la stabilità può essere definita come il modo in cui l'algoritmo tratta elementi uguali.

Un algoritmo di ordinamento è "In-place" se non utilizza di spazio aggiuntivo.

Nota: la funzione primitiva "sort" si comporta in maniera "greedy", cioè cerca di ordinare tutti gli elementi:

(setq a '((9 8) (1 8) (9 7) (4 1) (2 6)))
(sort (copy a))
;-> ((1 8) (2 6) (4 1) (9 7) (9 8))

La lista viene ordinata rispetto ai primi elementi di ogni coppia e, in caso di primi elementi uguali, allora ordina anche i relativi secondi elementi (es. (9 7) e (9 8)).
Vediamo altri due esempi:

(setq b '((9 (8)) (1 (8)) (9 (7)) (4 (1)) (2 (6))))
(sort (copy b))
;-> ((1 (8)) (2 (6)) (4 (1)) (9 (7)) (9 (8)))

(setq c '((9 (8 1)) (1 (8 3)) (9 (7 4)) (4 (1 6)) (2 (6 6)) (9 (7 3))))
(sort (copy c))
;-> ((1 (8 3)) (2 (6 6)) (4 (1 6)) (9 (7 3)) (9 (7 4)) (9 (8 1)))


------------------------
Il quadrato magico SATOR
------------------------

Il quadrato del Sator è una ricorrente iscrizione latina, in forma di quadrato magico, composta dalle seguenti cinque parole: SATOR, AREPO, TENET, OPERA, ROTAS.

L'iscrizione è stata trovata in molti siti archeologici, sia nelle epigrafi delle lapidi sia come graffiti, ma il senso e/o il significato simbolico rimangono ancora oscuri, nonostante i diversi studi compiuti e le numerose ipotesi formulate.

  +---+---+---+---+---+
  | S | A | T | O | R |
  +---+---+---+---+---+
  | A | R | E | P | O |
  +---+---+---+---+---+
  | T | E | N | E | T |
  +---+---+---+---+---+
  | O | P | E | R | A |
  +---+---+---+---+---+
  | R | O | T | A | S |
  +---+---+---+---+---+

Si nota subito che il quadrato è formato da 5 parole che si possono leggere sia in orizzontale sia in verticale (palindrome).

Scriviamo le cinque parole una di seguito all'altra:

  SATOR-AREPO-TENET-OPERA-ROTAS

Questa è una stringa palindroma (si legge sia da destra che da sinistra).

(setq sator
    '((S A T O R)
      (A R E P O)
      (T E N E T)
      (O P E R A)
      (R O T A S)))

(print-table sator)
;-> +---+---+---+---+---+
;-> | S | A | T | O | R |
;-> +---+---+---+---+---+
;-> | A | R | E | P | O |
;-> +---+---+---+---+---+
;-> | T | E | N | E | T |
;-> +---+---+---+---+---+
;-> | O | P | E | R | A |
;-> +---+---+---+---+---+
;-> | R | O | T | A | S |
;-> +---+---+---+---+---+

Nota: La funzione "print-table" si trova nel modulo "yo.lsp".

Quello che ci interessa è stabilire se sia possibile attribuire un valore numerico a ciascuna lettera in modo che il quadrato numerico risultante sia un quadrato magico.

Un quadrato magico di ordine N è una matrice numerica quadrata di N×N caselle, in cui la somma dei numeri su ciascuna riga, colonna o diagonale (principale e secondaria) dà sempre lo stesso valore, detto costante C del quadrato.

Un quadrato magico "canonico" di ordine N contiene nelle sue caselle tutti e soli i numeri da 1 a N^2.
In questo caso, la costante C del quadrato ha un valore univoco e può essere calcolato tramite la seguente formula:

       N^3 + N
  C = ---------
          2

Nel nostro caso N = 5, quindi C = 65.

(div (add (pow 5 3) 5) 2)
;-> 65

Guardando la disposizione e il valore della lettere del quadrato risulta chiaro che il quadrato magico risultante non sarà del tipo canonico, perché, a parte la "N" centrale, ogni lettera compare almeno un'altra volta nello schema, quindi ci saranno dei valori ripetuti.

Quindi il problema consiste nel trovare i valori da attribuire alle varie lettere in modo che venga soddisfatto il seguente sistema di 5 equazioni e 9 incognite (R O T A S P E N C):

  R + O + T + A + S = C
  O + P + E + R + A = C
  T + E + N + E + T = C
  S + R + N + R + S = C
  R + P + N + P + R = C

Le ultime due equazioni possono essere riscritte nel modo seguente:

  R + S + N + S + R = C
  R + P + N + P + R = C

Quindi deve risultare S = P e il nuovo sistema ha 4 equazioni e 8 incognite (R O T A X E N C):

X = S = P

  R + O + T + A + X - C = 0
  O + X + E + R + A - C = 0
  T + E + N + E + T - C = 0
  X + R + N + R + X - C = 0
  R + X + N + X + R - C = 0

Le prime due equazione possono essere riscritte nel modo seguente:

  X + A + T + O + R - C = 0
  X + A + E + O + R - C = 0

Quindi deve risultare T = E e il nuovo sistema ha 3 equazioni e 7 incognite (A C N O R X Y):

Y = T = E

  R + O + Y + A + X - C = 0
  Y + Y + N + Y + Y - C = 0
  X + R + N + R + X - C = 0
  R + X + N + X + R - C = 0

Riscriviamo il sistema:

  A + O + R + X + Y - C = 0
  2X + 2R + N - C = 0
  4Y + N - C = 0

Il quadrato Sator diventa:

(setq qm
    '((X A Y O R)
      (A R Y X O)
      (Y Y N Y Y)
      (O X Y R A)
      (R O Y A X)))

  +---+---+---+---+---+
  | X | A | Y | O | R |
  +---+---+---+---+---+
  | A | R | Y | X | O |
  +---+---+---+---+---+
  | Y | Y | N | Y | Y |
  +---+---+---+---+---+
  | O | X | Y | R | A |
  +---+---+---+---+---+
  | R | O | Y | A | X |
  +---+---+---+---+---+

Adesso per risolvere il sistema dobbiamo scegliere le variabili libere (3) e le variabili fisse (4).
Ci sono 35 modi diversi di scegliere i due gruppi di variabili:

(setq modi (groups '(3 4) '(A C N O R X Y)))
;-> (((A C N) (O R X Y)) ((A C O) (N R X Y)) ((A C R) (N O X Y))
;->  ((A C X) (N O R Y)) ((A C Y) (N O R X)) ((A N O) (C R X Y))
;->  ((A N R) (C O X Y)) ((A N X) (C O R Y)) ((A N Y) (C O R X))
;->  ((A O R) (C N X Y)) ((A O X) (C N R Y)) ((A O Y) (C N R X))
;->  ((A R X) (C N O Y)) ((A R Y) (C N O X)) ((A X Y) (C N O R))
;->  ((C N O) (A R X Y)) ((C N R) (A O X Y)) ((C N X) (A O R Y))
;->  ((C N Y) (A O R X)) ((C O R) (A N X Y)) ((C O X) (A N R Y))
;->  ((C O Y) (A N R X)) ((C R X) (A N O Y)) ((C R Y) (A N O X))
;->  ((C X Y) (A N O R)) ((N O R) (A C X Y)) ((N O X) (A C R Y))
;->  ((N O Y) (A C R X)) ((N R X) (A C O Y)) ((N R Y) (A C O X))
;->  ((N X Y) (A C O R)) ((O R X) (A C N Y)) ((O R Y) (A C N X))
;->  ((O X Y) (A C N R)) ((R X Y) (A C N O)))

(length modi)
;-> 35

Nota: La funzione "groups" si trova nel modulo "yo.lsp".

Ad esempio, ponendo come variabili fisse C, X, Y e O e come varibili libere A, R e N otteniamo la seguente soluzione:

  A = C - O - 3Y
  R = 2Y - X
  N = C - 4Y

Possiamo ottenere la soluzione per ogni modo calcolando algebricamente la soluzione oppure utilizzando il sito web:

  https://www.wolframalpha.com/

Per esempio:

((A C N) (O R X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, C, N}]
  { }

((A C O) (N R X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, C, O}]
  { }

((A C R) (N O X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, C, R}]
  {A -> N - O + Y, C -> N + 4Y, R -> -X + 2Y}

((A C X) (N O R Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, C, X}]
  {A -> N - O + Y, C -> N + 4Y, X -> -R + 2Y}

((A C Y) (N O R X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, C, Y}]
  {A -> N - O + R/2 + X/2, C -> N + 2 R + 2X, Y -> (R + X)/2}

((A N O) (C R X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, N, O}]
  { }

((A N R) (C O X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, N, R}]
  {A -> C - O - 3Y, N -> C - 4Y, R -> -X + 2Y}}

((A N X) (C O R Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, N, X}]
  {A -> C - O - 3Y, N -> C - 4Y, R -> -X + 2Y}}

((A N Y) (C O R X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, N, Y}]
  {A -> 1/2 (2C - 2 O - 3R - 3 X), N -> C - 2R - 2X, Y -> (R + X)/2}

((A O R) (C N X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, O, R}]
  { }

((A O X) (C N R Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, O, X}]
  { }

((A O Y) (C N R X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, O, Y}]
  { }

((A R X) (C N O Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, R, X}]
  { }

((A R Y) (C N O X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, R, Y}]
  {A -> C/4 + (3N)/4 - O, R -> C/2 - N/2 - X, Y -> C/4 - N/4}

((A X Y) (C N O R))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {A, X, Y}]
  {A -> C/4 + (3N)/4 - O, X -> C/2 - N/2 - R, Y -> C/4 - N/4}

((C N O) (A R X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, N, O}]
  { }

((C N R) (A O X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, N, R}]
  {C -> A + O + 3Y, N -> A + O - Y, R -> -X + 2Y}}

((C N X) (A O R Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, N, X}]
  {C -> A + O + 3Y, N -> A + O - Y, X -> -R + 2Y}

((C N Y) (A O R X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, N, Y}]
 {C -> 1/2 (2A + 2O + 3R + 3X), N -> 1/2 (2A + 2O - R - X), Y -> (R + X)/2}

((C O R) (A N X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, O, R}]
  {C -> N + 4Y, O -> -A + N + Y, R -> -X + 2Y}}

((C O X) (A N R Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, O, X}]
  {C -> N + 4Y, O -> -A + N + Y, X -> -R + 2Y}}

((C O Y) (A N R X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, O, Y}]
  {C -> N + 2R + 2X, O -> 1/2 (-2A + 2N + R + X), Y -> (R + X)/2}

((C R X) (A N O Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, R, X}]
  { }

((C R Y) (A N O X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, R, Y}]
  {C -> 4A - 3N + 4O, R -> 2A - 2N + 2O - X, Y -> A - N + O}

((C X Y) (A N O R))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {C, X, Y}]
  {C -> 4A - 3N + 4O, X -> 2A - 2N + 2O - R, Y -> A - N + O}}

((N O R) (A C X Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {N, O, R}]
  {N -> C - 4Y, O -> -A + C - 3Y, R -> -X + 2Y}

((N O X) (A C R Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {N, O, X}]
  {N -> C - 4Y, O -> -A + C - 3Y, X -> -R + 2Y}

((N O Y) (A C R X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {N, O, Y}]
  {N -> C - 2R - 2X, O -> 1/2 (-2A + 2C - 3R - 3X), Y -> (R + X)/2}}

((N R X) (A C O Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {N, R, X}]
  {N -> 1/3 (4A - C+ 4O), X -> 1/3 (-2A + 2C - 2O - 3R), Y -> 1/3 (-A + C - O)}

((N R Y) (A C O X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {N, R, Y}]
  { }

((N X Y) (A C O R))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {N, X, Y}]
 {N -> 1/3 (4A - C + 4O), X -> 1/3 (-2A + 2C - 2O - 3R), Y -> 1/3 (-A + C - O)}

((O R X) (A C N Y))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {O, R, X}]
  { }

((O R Y) (A C N X))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {O, R, Y}]
  {O -> -A + C/4 + (3N)/4, R -> C/2 - N/2 - X, Y -> C/4 - N/4}

((O X Y) (A C N R))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {O, X, Y}]
  {O -> -A + C/4 + (3N)/4, X -> C/2 - N/2 - R, Y -> C/4 - N/4}

((R X Y) (A C N O))
  Solve[A + O + R + X + Y - C == 0 && 2X + 2R + N - C == 0 &&
    4Y + N - C == 0, {R, X, Y}]
  { }

A questo punto è necessario fare un pò di prove.
Per ogni tipo di raggruppameNto scelto occorre dare dei valori arbitrari alle quattro variabili indipendenti e calcolare le altre tre.
In alcuni casi si otterranno dei valori negativi in quanto le soluzioni possono essere dei numeri qualunque (interi o floating).

Come esempio scegliamo (A C R) come variabili libere e (N O X Y) come variabili fisse.
La soluzione vale:

  A = N - O + Y
  C = N + 4Y
  R = -X + 2Y

Funzione che verifica se una matrice è un quadrato magico:

(define (magico? lst)
  (let ((tr (transpose lst)))
    (= (apply add (lst 1))
       (apply add (lst 2))
       (apply add (lst 3))
       (apply add (lst 4))
       (apply add (tr 1))
       (apply add (tr 2))
       (apply add (tr 3))
       (apply add (tr 4))
       (add (lst 0 0) (lst 1 1) (lst 2 2) (lst 3 3) (lst 4 4))
       (add (tr 0 0) (tr 1 1) (tr 2 2) (tr 3 3) (tr 4 4)))))

Generatore di quadrati magici sator con numeri in sequenza:

(define (genera1 start end)
  (local (a c r n o x y qm qt)
    (setq qm '((x a y o r)
               (a r y x o)
               (y y n y y)
               (o x y r a)
               (r o y a x)))
    (setq qt '((0 0 0 0 0) (0 0 0 0 0) (0 0 0 0 0) (0 0 0 0 0) (0 0 0 0 0)))
    (for (n start end)
      (for (o start end)
        (for (x start end)
          (for (y start end)
            (setq a (+ n y (- o)))
            (setq c (+ n (* 4 y)))
            (setq r (- (* 2 y) x))
            ; creazione del quadrato magico corrente
            (for (i 0 4)
              (for (j 0 4)
                (setf (qt i j) (eval (qm i j)))
              )
            )
            (if (not (magico? qt)) (println "ERRORE: quadrato non magico"))
            ; stampa del quadrato magico corrente
            (print-table qt)
            (read-line)))))))

(genera1 3 5)
;-> ...
;-> +---+---+---+---+---+
;-> | 3 | 6 | 4 | 3 | 5 |
;-> +---+---+---+---+---+
;-> | 6 | 5 | 4 | 3 | 3 |
;-> +---+---+---+---+---+
;-> | 4 | 4 | 5 | 4 | 4 |
;-> +---+---+---+---+---+
;-> | 3 | 3 | 4 | 5 | 6 |
;-> +---+---+---+---+---+
;-> | 5 | 3 | 4 | 6 | 3 |
;-> +---+---+---+---+---+
;-> ...

Generatore di quadrati magici sator con numeri casuali:

(define (genera2 max-val iter)
  (local (a c r n o x y qm qt)
    (setq qm '((x a y o r)
               (a r y x o)
               (y y n y y)
               (o x y r a)
               (r o y a x)))
    (setq qt '((0 0 0 0 0) (0 0 0 0 0) (0 0 0 0 0) (0 0 0 0 0) (0 0 0 0 0)))
    (for (i 1 iter)
      (setq n (+ (rand max-val)))
      (setq o (+ (rand max-val)))
      (setq x (+ (rand max-val)))
      (setq y (+ (rand max-val)))
      (setq a (+ n y (- o)))
      (setq c (+ n (* 4 y)))
      (setq r (- (* 2 y) x))
      ; creazione del quadrato magico corrente
      (for (i 0 4)
        (for (j 0 4)
          (setf (qt i j) (eval (qm i j)))
        )
      )
      (if (not (magico? qt)) (println "ERRORE: quadrato non magico"))
      ; stampa del quadrato magico corrente
      (print-table qt)
      ; numero magico
      (println (apply + (qt 0)))
      (read-line))))

(genera2 100 10)
;-> ...
;-> +----+----+----+----+----+
;-> | 60 | 75 | 69 | 18 | 78 |
;-> +----+----+----+----+----+
;-> | 75 | 78 | 69 | 60 | 18 |
;-> +----+----+----+----+----+
;-> | 69 | 69 | 24 | 69 | 69 |
;-> +----+----+----+----+----+
;-> | 18 | 60 | 69 | 78 | 75 |
;-> +----+----+----+----+----+
;-> | 78 | 18 | 69 | 75 | 60 |
;-> +----+----+----+----+----+
;-> 300
;-> ...

In definitiva possiamo generare un numero infinito di quadrati magici derivanti dal quadrato sator, il problema è trovarne uno con un significato particolare.

Si potrebbe provare ad inserire numeri particolari (es. numeri legati alle tradizioni religiose), per scoprire se viene generato qualche quadrato magico particolare.

I valori della Gematria ebraica:
S (Shin) = 21, A (Aleph) = 1,
T (Taw) = 22,  O (Wav) = 6,
R (Res) = 20,  E (He) = 5,
P (Pe) = 17,   N (Nun) = 14.

I simboli numerici nella Bibbia:
1, 3, 4, 7, 12, 40, 666, 1000


----------------------------------------
Alberi binari completi con vettori/liste
----------------------------------------

Un albero binario "completo" ha tutti i livelli tranne quello inferiore completamente compilati e il livello inferiore ha tutti i suoi nodi riempiti da sinistra a destra.
Pertanto, un albero binario completo di n nodi ha una sola forma possibile.

Iniziamo assegnando dei numeri alle posizioni dei nodi nell'albero binario completo, livello per livello, da sinistra a destra, come mostrato nella seguente figura:

                     +------------------0------------------+
                     |                                     |
           +---------1---------+                 +---------2---------+
           |                   |                 |                   |
    +------3------+     +------4------+   +------5                   6
    |             |     |             |   |
    7             8     9            10   11

  Un albero binario completo di 12 nodi, numerati a partire da 0 (0..11).

Vediamo in dettaglio i termini di un albero:

"Root" (Radice): la radice di un albero è il nodo più alto dell'albero che non ha un nodo padre. C'è solo un nodo radice in ogni albero.

"Parent Node" (Nodo padre): il nodo che è un predecessore di un nodo è chiamato nodo padre di quel nodo.

"Nodo figlio" (Nodo figlio): il nodo che è l'immediato successore di un nodo è chiamato nodo figlio di quel nodo.

"Sibling" (Fratello): i figli dello stesso nodo genitore sono chiamati fratelli.

"Edge" (Arco): un arco funge da collegamento tra il nodo padre e il nodo figlio.

"Leaf" (Foglia): un nodo che non ha figli è noto come nodo foglia. È l'ultimo nodo dell'albero. Ci possono essere più nodi foglia in un albero.

"SubTree" (Sottoalbero): il sottoalbero di un nodo è l'albero che considera quel particolare nodo come nodo radice.

"Depth" (Profondità): la profondità del nodo è la distanza dal nodo radice a quel particolare nodo.

"Height" (Altezza): l'altezza del nodo è la distanza da quel nodo al nodo più profondo di quel sottoalbero.

"Height of Tree" (Altezza dell'albero): l'altezza dell'albero è l'altezza massima di qualsiasi nodo. Questo è lo stesso dell'altezza del nodo radice.

"Level" (Livello): Un livello è il numero di nodi padre corrispondenti a un dato nodo dell'albero.

"Degree of node" (Grado di un nodo): il grado di un nodo è il numero dei suoi figli.

Un array può memorizzare i valori dei dati dell'albero in modo efficiente, posizionando ogni valore di dati nella posizione dell'array corrispondente alla posizione di quel nodo all'interno dell'albero.

La tabella elenca gli indici dell'array per "child" (figli), "parent" (genitori) e "sibling" fratelli di ogni nodo:

+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  | 11  |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| nil | 0   | 0   | 1   | 1   | 2   | 2   | 3   | 3   | 4   | 4   | 5   |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| 1   | 3   | 5   | 7   | 9   | 11  | nil | nil | nil | nil | nil | nil |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| 2   | 4   | 6   | 8   | 10  | nil | nil | nil | nil | nil | nil | nil |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| nil | nil | 1   | nil | 3   | nil | 5   | nil | 7   | nil | 9   | nil |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| nil | 2   | nil | 4   | nil | 6   | nil | 8   | nil | 10  | nil | nil |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+

Un albero binario è un albero binario perfetto in cui tutti i nodi interni hanno due figli (child) e tutti i nodi foglia (leaf) sono allo stesso livello.

Un albero binario "perfetto" è un tipo di albero binario in cui ogni nodo interno ha esattamente due nodi figli e tutti i nodi foglia sono allo stesso livello.

La seguente figura mostra un albero seguenti sono esempi di alberi binari perfetti.

                     +------------------0------------------+
                     |                                     |
           +---------1---------+                 +---------2---------+
           |                   |                 |                   |
    +------3------+     +------4------+   +------5------+     +------6------+
    |             |     |             |   |             |     |             |
    7             8     9            10   11           12     13           14

  Un albero binario perfetto di 15 nodi, numerati a partire da 0 (0..14).

Un albero perfetto è un albero completo.

La tabella relativa all'albero perfetto di 15 nodi vale:

+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  | 11  | 12  | 13  | 14  |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| nil | 0   | 0   | 1   | 1   | 2   | 2   | 3   | 3   | 4   | 4   | 5   | 5   | 6   | 6   |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| 1   | 3   | 5   | 7   | 9   | 11  | 13  | nil | nil | nil | nil | nil | nil | nil | nil |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| 2   | 4   | 6   | 8   | 10  | 12  | 14  | nil | nil | nil | nil | nil | nil | nil | nil |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| nil | nil | 1   | nil | 3   | nil | 5   | nil | 7   | nil | 9   | nil | 11  | nil | 13  |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
| nil | 2   | nil | 4   | nil | 6   | nil | 8   | nil | 10  | nil | 12  | nil | 14  | nil |
+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+

Guardando la tabella, possiamo notare uno schema riguardante le posizioni dei vari parenti di un nodo all'interno dell'array.
È possibile derivare formule semplici per calcolare l'indice dell'array per ogni parente di un nodo r dall'indice di r.
Non sono necessari puntatori espliciti per raggiungere il figlio sinistro o destro di un nodo. Ciò significa che non vi è alcun sovraccarico per l'implementazione dell'array se l'array è selezionato per essere di dimensione N per un albero di N nodi.

Il numero totale di nodi nell'albero è N.
L'indice del nodo in questione è "r", che deve rientrare nell'intervallo da 0 a N−1.
Le formule per il calcolo degli indici dell'array dei vari parenti di un nodo sono le seguenti.

  Parent(r) = floor((r−1)/2) se r≠0.

  Left child(r) = 2r+1 se 2r+1<n.

  Right child(r) = 2r+2 se 2r+2<n.

  Left sibling(r) = r−1 se r is pari e r≠0

  Right sibling(r) = r+1 se r is dispari e r+1<n

La scelta della dimensione dell'array può consistere nel fissare l'altezza massima dell'albero (H) e rendere l'array abbastanza grande da contenere qualsiasi albero binario di questa altezza (o inferiore). In questo caso avremo bisogno di un array di dimensioni (2^H - 1).

A causa del modo in cui abbiamo assegnato i nodi alle posizioni, se ci sono N nodi in un albero completo, corrisponderanno alle prime N posizioni dell'array.
In questo modo abbiamo la necessità di conoscere solo N per sapere quali posizioni dell'array contengono informazioni valide.
Se aggiungiamo un nuovo valore, deve andare in posizione N+1;
Se cancelliamo un valore, dobbiamo riorganizzare l'albero in modo che il 'vuoto' creato dalla cancellazione sia colmato.
Si può attraversare l'albero livello per livello semplicemente scorrendo l'array dall'inizio alla fine:

  (for (i 0 (- N 1) 1)
    (nodo corrente in posizione i)

Vediamo le funzioni per individuare gli indici dell'array:

(define (make-empty-tree n)
  (let (tree (array n '(-1)))
    ; root --> idx = 0
    (setf (tree 0) 0)
    tree))
(setq tr (make-empty-tree 15))

(define (parent idx)
  (if (zero? idx)
      nil
      (floor (div (- idx 1) 2))))

(define (left-child idx)
  (if (< (+ (* 2 idx) 1) n)
      (+ (* 2 idx) 1)
      nil))

(define (right-child idx)
  (if (< (+ (* 2 idx) 2) n)
      (+ (* 2 idx) 2)
      nil))

(define (left-sibling idx)
  (if (and (even? idx) (!= idx 0))
      (- idx 1)
      nil))

(define (right-sibling idx)
  (if (and (odd? idx) (< (+ idx 1) n))
      (+ idx 1)
      nil))

(left-child 3)
;-> 7
(left-sibling 4)
;-> 3
(right-sibling 4)
;-> nil

(setq n 12)
(for (i 0 (- n 1))
  (print i { })
  (print (parent i) { })
  (print (left-child i) { })
  (print (right-child i) { })
  (print (left-sibling i) { })
  (println (right-sibling i)))

;-> 0 nil 1 2 nil nil
;-> 1 0 3 4 nil 2
;-> 2 0 5 6 1 nil
;-> 3 1 7 8 nil 4
;-> 4 1 9 10 3 nil
;-> 5 2 11 nil nil 6
;-> 6 2 nil nil 5 nil
;-> 7 3 nil nil nil 8
;-> 8 3 nil nil 7 nil
;-> 9 4 nil nil nil 10
;-> 10 4 nil nil 9 nil
;-> 11 5 nil nil nil nil

Associazione dei dati ai nodi di un albero
------------------------------------------

Associazione indiretta dei dati con una lista associativa:

(setq alst (map (fn(x) (list x (char (+ 65 x)))) (sequence 0 11)))
(lookup (left-sibling 4) alst)
;-> "D"

Associazione diretta dei dati con una lista:

(setq letter '("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L"))
(letter (left-sibling 4))
;-> "D"

(letter (left-sibling (find "E" letter)))
;-> "D"

(letter (left-child (find "A" letter)))
;-> "B"

(letter (parent (find "A" letter)))
;-> ERR: invalid list index : (parent (find "A" letter))

(define (find-relationship tree node-value func)
  (let (idx (find node-value tree))
    (setq rel (func idx))
    (if rel (tree rel) nil)))

(find-relationship letter "A" parent)
;-> nil
(find-relationship letter "A" left-child)
;-> "B"

Proprietà di un albero binario completo
---------------------------------------
- Un albero binario è un albero binario completo se tutte le foglie hanno la stessa profondità.
- In un albero binario completo il numero di nodi alla profondità d è 2d.
- In un albero binario completo con N nodi l'altezza dell'albero è log(N+1).
- Tutti i livelli tranne l'ultimo livello sono completamente pieni.

Proprietà di un albero binario perfetto
---------------------------------------
Un albero binario di altezza 'h' con il numero massimo di nodi è un albero binario perfetto.
Per una data altezza h, il numero massimo di nodi è 2^(h+1) - 1.

Attraversamento di un albero binario (Binary Tree Traversals)
-------------------------------------------------------------
Gli algoritmi Tree Traversal possono essere classificati sostanzialmente in due categorie:
- Algoritmi di ricerca in profondità (DFS Depth-First-Search)
- Algoritmi di ricerca in ampiezza (BFS Breadth-First-Search)

L'attraversamento dell'albero utilizzando l'algoritmo Depth-First-Search (DFS) può essere ulteriormente classificato in tre categorie:

"Preorder Traversal" (current-left-right): Visita il nodo corrente prima di visitare qualsiasi nodo all'interno dei sottoalberi sinistro o destro. Qui, l'attraversamento è root – left child – right child. Significa che il nodo radice viene attraversato prima del suo figlio sinistro e finalmente il figlio giusto.

"Inorder Traversal" (left-current-right): visita il nodo corrente dopo aver visitato tutti i nodi all'interno del sottoalbero sinistro ma prima di visitare qualsiasi nodo all'interno del sottoalbero destro. Qui l'attraversamento è figlio sinistro – radice – figlio destro. Significa che viene attraversato prima il figlio sinistro, poi il suo nodo radice e infine il figlio destro.

"Postorder Traversal" (left-right-current): visita il nodo corrente dopo aver visitato tutti i nodi dei sottoalberi sinistro e destro. Qui l'attraversamento è figlio sinistro – figlio destro – radice. Significa che il figlio sinistro ha attraversato prima il figlio destro e infine il suo nodo radice.

L'attraversamento dell'albero utilizzando l'algoritmo BFS (Breadth-First-Search) può essere ulteriormente classificato in una categoria:

"Level-order Traversal": visita i nodi livello per livello e da sinistra a destra allo stesso livello. Qui, l'attraversamento è in piano. Significa che il figlio più a sinistra ha attraversato per primo e poi hanno attraversato gli altri figli dello stesso livello da sinistra a destra.

Vediamo tutti i tipi di attraversamento utilizzando il seguente albero:

         0
        / \
       /   \
      1     2
     / \   / \
    3   4 5   6

Pre-order Traversal:   0-1-3-4-2-5-6

In-order Traversal:    3-1-4-0-5-2-6

Post-order Traversal:  3-4-1-5-6-2-0

Level-order Traversal: 0-1-2-3-4-5-6

Vediamo alcune funzioni per l'attraversamento degli alberi:

(setq albero (sequence 0 6))
(setq n (length albero))
;-> 7

Funzione "pre-order":

(define (pre-order root)
  (cond ((nil? root) nil)
        (true
          (print root { })
          (pre-order (left-child root))
          (pre-order (right-child root)))))

(pre-order 0)
;-> 0 1 3 4 2 5 6

Funzione "in-order":

(define (in-order root)
  (cond ((nil? root) nil)
        (true
          (in-order (left-child root))
          (print root { })
          (in-order (right-child root)))))

(in-order 0)
;-> 3 1 4 0 5 2 6

Funzione "post-order":

(define (post-order root)
  (cond ((nil? root) nil)
        (true
          (post-order (left-child root))
          (post-order (right-child root))
          (print root { }))))

(post-order 0)
;-> 3 4 1 5 6 2 0

Funzione "level-order":

Metodo semplificato (valido solo con la struttura dell'albero con un vettore):

(define (level-order root)
  (for (i root (- n 1)) (print i { })))

(level-order 0)
;-> 0 1 2 3 4 5 6

Metodo generico:
Useremo una struttura dati Queue (FIFO) per implementare l'attraversamento level-order.
Dopo aver visitato un nodo, inseriamo i suoi figli sinistro e destro in sequenza nella coda.
L'ordine di aggiunta dei figli nella coda è importante in quanto dobbiamo attraversare da sinistra a destra allo stesso livello.

(define (level-order2 root)
  (cond ((nil? root) nil)
        (true
          (let ((queue '()) (node root))
            (push root queue)
            (while queue
              (setq node (pop queue -1))
              (print node { })
              (if (!= (left-child node) nil)
                (push (left-child node) queue)
              )
              (if (!= (right-child node) nil)
                (push (right-child node) queue)
              ))))))

(setq n 15)
(level-order2 0)
;-> 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14

Nota: se al posto dell'espressione:

  (setq node (pop queue -1))

usiamo:

  (setq node (pop queue))

allora si ottiene il seguente attraversamento:

  0 2 6 14 13 5 12 11 1 4 10 9 3 8 7

Vediamo un'altro esempio con un albero perfetto di 15 nodi:

(setq albero (sequence 0 14))
(setq n (length albero))
;-> 15

(post-order 0)
;-> 7 8 3 9 10 4 1 11 12 5 13 14 6 2 0

(in-order 0)
;-> 7 3 8 1 9 4 10 0 11 5 12 2 13 6 14

(pre-order 0)
;-> 0 1 3 7 8 4 9 10 2 5 11 12 6 13 14

(post-order 0)
;-> 7 8 3 9 10 4 1 11 12 5 13 14 6 2 0

(level-order 0)
;-> 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14

L'attraversamento può iniziare da un nodo qualsiasi:

(in-order 1)
;-> 7 3 8 1 9 4 10 nil

Numero di nodi di un albero binario completo/perfetto
-----------------------------------------------------

(define (nodes root)
  (cond ((= root nil) 0)
        (true (+ 1 (nodes (left-child root)) (nodes (right-child root))))))

(setq n 15)
(nodes 0)
;-> 15
(nodes 1)
;-> 7

(setq n 8)
(nodes 0)
;-> 8


-------------------
Algoritmo Undo/Redo
-------------------

Esistono due metodi principali per implementare il meccanismo di undo/redo in un programma.

Memorizzazione dello Stato 
Per ogni operazione viene prima memorizzato lo stato del sistema. Quando si desidera eseguire un annullamento (undo), è sufficiente cambiare lo stato corrente con quello memorizzato.

Generazione dello Stato
Per ogni operazione viene memorizzata la relativa operazione inversa. Quando si desidera eseguire un annullamento (undo), occorre applicare l'azione inversa allo stato corrente.

La scelta di un metodo dipende da diversi fattori tra cui:
- memoria richiesta dagli stati
- velocità di ripristino dgli stati
- esecuzione di azioni irreversibili

Inoltre è possibile utilizzare entrambi i metodi in un meccanismo di undo/redo.

L'algoritmo standard per la gestione di undo/redo è il seguente:

Mantieniamo due pile (stack) UNDO e REDO.
Usiamo lo stack UNDO per mantenere la cronologia di tutte le operazioni che sono state elaborate nel programma.
Ogni volta che vogliamo effettuare un'operazione di annullamento (undo), estraiamo il primo elemento (quello superiore) dallo stack UNDO e lo spingiamo nello stack REDO.
Quando vogliamo effettuare un'operazione di ripristino (redo), estraiamo il primo elemento dello stack REDO e lo spingiamo nello stack UNDO.
Quando eseguiamo una nuova operazione azzeriamo lo stack REDO.

Naturalmente prima effettuare le operazioni di undo e erdo occorre controllare che i relativi stack UNDO e REDO non siano vuoti.

Vediamo un esempio minimale:

(setq UNDO '())
(setq REDO '())
(setq TEXT "")

(define (writes ch)
  (push ch TEXT -1)
  ; insert operation on undo stack
  (push ch UNDO)
  ; no more redo operations
  (setq REDO '())
)

(define (undo)
  ; if there are operations to undo
  (cond ((null? UNDO) nil)
        (true  
          (let (u (pop UNDO)) ; extract operation from stack UNDO
            (pop TEXT -1) ; redo operation on TEXT
            (push u REDO))))) ; insert operation on stack REDO

(define (redo)
  ; if there are operations to redo
  (cond ((null? REDO) nil)
        (true
          (let (r (pop REDO))
            (push r TEXT -1)
            (push r UNDO)))))

(define (show) 
  (println "Text: " TEXT ", Undo: " UNDO ", Redo: " REDO))

Facciamo alcune prove:

(writes "A")
;-> ("A")
(show)
;-> Text: A, Undo: ("A"), Redo: ()
(writes "B")
;-> ("B" "A")
(show)
;-> Text: AB, Undo: ("B" "A"), Redo: ()
(undo)
;-> ("B")
(show)
;-> Text: A, Undo: ("A"), Redo: ("B")
(undo)
;-> ("A" "B")
(show)
;-> Text: , Undo: (), Redo: ("A" "B")
(redo)
;-> ("A")
(show)
;-> Text: A, Undo: ("A"), Redo: ("B")
(redo)
;-> ("B" "A")
(show)
;-> Text: AB, Undo: ("B" "A"), Redo: ()
(redo)
;-> nil

=============================================================================

