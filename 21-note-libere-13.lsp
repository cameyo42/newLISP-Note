================

 NOTE LIBERE 13

================

    Hacker Logo
  +----+----+----+
  |    | ██ |    |
  +----+----+----+
  |    |    | ██ |
  +----+----+----+
  | ██ | ██ | ██ |
  +----+----+----+

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

Algoritmo 1
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


--------------------
Multiple stack/queue
--------------------

Vediamo come usare un'unica lista per gestire diverse pile (stack) e code (queue).
La struttura dati deve gestire tre operazioni:

- push(x, stack-num): inserimento di un valore in uno stack o in una queue

- pop(stack-num): estrazione del primo elemento di uno stack o di una queue

- read(stack-num): lettura del primo elemento di uno stack o di una queue

stack -> struttura LIFO (Last In First Out)
queue -> struttura FIFO (First In First Out)

Creazione della lista che contiene stack e queue:

(setq multi '())

Inserimento di contenitori per stack e queue (liste vuote) nella lista:

(push '() multi)
;-> '(())
(push '() multi)
;-> '(() ())

Funzioni per gestire stack e queue:

; push-stack
(define (push-stack idx value)
  (push value (multi idx)))

; pop-stack
(define (pop-stack idx)
  (if (multi idx)
      (pop (multi idx) 0)
      nil))

; read-stack
(define (read-stack idx)
  (if (multi idx)
      ((multi idx) 0)
      nil))

; push-queue
(define (push-queue idx value)
  (push value (multi idx)))

; pop-queue
(define (pop-queue idx)
  (if (multi idx)
    (pop (multi idx) -1)
    nil))

; read-queue
(define (read-queue idx)
  (if (multi idx)
      ((multi idx) -1)
      nil))

Vediamo un esempio:

multi
;-> (() ())

"multi" è una lista con due sottoliste vuote.
Usiamo la prima sottolista come uno stack (pila) e la seconda sottolista come una queue (coda).

Inseriamo elementi nello stack (idx = 0):

(push-stack 0 1)
(push-stack 0 2)
(push-stack 0 3)
(push-stack 0 4)
multi
;-> ((4 3 2 1) ())

Inseriamo elementi nella queue (idx = 1):

(push-queue 1 1)
(push-queue 1 2)
(push-queue 1 3)
(push-queue 1 4)
multi
;-> ((4 3 2 1) (4 3 2 1))

Estraiamo alcuni elementi dallo stack e dalla queue:

(pop-queue 1)
;-> 1
(pop-queue 1)
;-> 2
(read-queue 1)
;-> 3
(pop-stack 0)
;-> 4
(read-stack 0)
;-> 3
multi
;-> ((3 2 1) (4 3))
(push-queue 1 5)
;-> (5 4 3)
(pop-queue 1)
;-> 3
(pop-queue 1)
;-> 4
(pop-queue 1)
;-> 5
(pop-queue 1)
;-> nil ; queue vuota
multi
;-> ((3 2 1) ())


--------------------------------
FLAMES: il gioco delle relazioni
--------------------------------


FLAMES è un gioco che prende il nome dall'acronimo: Friends, Lovers, Affectionate, Marriage, Enemies, Sibling. Lo scopo è scoprire quale tipo di relazione esiste tra due persone.
Questo gioco prevede con precisione(?) la relazione tra due persone partendo dai loro nomi.

I passaggi sono i seguenti:

Si prendono due nomi.
Rimuovere i caratteri comuni con le rispettive occorrenze comuni.
Contare il numero dei caratteri rimasti (N).
Prendere le lettere FLAMES come ("F" "L" "A" "M" "E" "S")
Iniziare un processo di rimozione partendo dalla lettera N-esima.
La lettera che rimane al termine del processo di rimozione è il risultato.

Vediamo un esempio per capire come funziona il processo di rimozione:

  nome1 = "asd"
  nome2 = "abcd"

Rimuovere i caratteri comuni (due caratteri comuni "a" e "d")
Contare i caratteri rimasti. Rimossi "a" e "d" rimangono "s", "b" e "c": 3.
Processo di rimozione
Prendere le lettere FLAMES ("F" "L" "A" "M" "E" "S")
Inizia a rimuovere le lettere usando il numero di caratteri rimasti (3).

  FLAMES

la lettera al posto 3 è la "A", quindi la togliamo e otteniamo:

  FLMES

Adesso si parte dalla lettera successiva a quella appena rimossa "A", quindi partiamo da "M" e contiamo 3 lettere in avanti in modo ciclico ("M" = 1, "E" = 2, "S" = 3).
Arriviamo alla lettera "S" che dobbiamo togliere e otteniamo:

  FLME

La lettera successiva a quella appena rimossa "S" è "F".
Contiamo 3 partendo da "F" e arriviamo a "M" che togliamo e otteniamo:

  FLE

La lettera successiva a quella appena rimossa "M" è "E".
Contiamo 3 partendo da "E" e arriviamo a "L" che togliamo e otteniamo:

  FE

La lettera successiva a quella appena rimossa "L" è "E".
Contiamo 3 partendo da "E" e arriviamo a "E" che togliamo e otteniamo:

  F

Quindi il risultato è "Friends" (amici) e questa è la relazione tra le due persone.

Scriviamo una funzione per simulare il gioco.

Funzione che rimuove gli elementi in comune tra due liste.
L'eliminazione degli elementi avviene con una corrispondenza 1:1.
Per esempio:
  a = (1 1 2 3 4)
  b = (1 2 3 5 3)
  (remove-common a b) --> (1 4 5 3)

(define (remove-common a b)
  (local (a1 b1 f)
    ; lista copia della prima lista (a)
    (setq a1 a)
    ; lista copia della seconda lista (b)
    (setq b1 b)
    ; ciclo per ogni elemento della prima lista
    (dolist (el a)
      ; se elemento corrente della prima lista esiste nella seconda lista
      (if (setq f (find el b1))
        ; allora elimina l'elemento da entrambe le liste copia
        (begin (pop a1 (find el a1)) (pop b1 f))
      )
    )
    ;(println a1) (println b1)
    (append a1 b1)))

(remove-common '(1 1 2 3 4) '(1 2 3 5 3))
;-> (1 4 5 3)
(remove-common '("M" "a" "g" "o" "o") '("o" "o" "o" "m" "g" "b"))
;-> ("M" "a" "o" "m" "b")

(define (extract obj start end)
"Extract a list/string from a list/string (from start to (end -1) indexes)"
  (if (nil? end)
      (slice obj start)
      (slice obj start (- end start))))

Funzione che genera il risultato del gioco:

(define (flames a b)
  (local (f len n idx right left)
    (setq f '("Friends" "Lovers" "Attraction" "Married" "Enemies" "Siblings"))
    (setq len (length f))
    ; uppercase different from lowerscale
    (setq n (length (remove-common (explode a) (explode b))))
    (while (> len 1)
      ; index to cut list
      (setq idx (- (% n len) 1))
      (if (>= idx 0)
        (begin
          ; right part of list
          (setq right (extract f (+ idx 1)))
          ; left part of list
          (setq left (extract f 0 idx))
          ; merge parts
          (setq f (append right left))
        )
        ;else
        (setq f (extract f 0 (- len 1)))
      )
      (-- len)
    )
    (println a " + " b " = " (first f))))

Facciamo alcune prove:

(flames "Elisabeth" "Alexander")
;-> Elisabeth + Alexander = Attraction
;-> "Attraction"

(flames "elisabeth" "alexander")
;-> elisabeth + alexander = Lovers
;-> "Lovers"

(flames "Massimo" "newLISP")
;-> Massimo + newLISP = Friends
;-> "Friends"

Altri acronimi:

("Friends" "Lovers" "Affectionate" "Marriage" "Enemies" "Siblings")
("Friends" "Lovers" "Affectionate" "Married"  "Enemies" "Siblings")
("Friends" "Lovers" "Attraction"   "Married"  "Enemies" "Siblings")
("Friends" "Lovers" "Admirers"     "Marriage" "Enemies" "Secret Lovers")


-----------------------------------------
Newton forward and backward interpolation
-----------------------------------------

Per maggiori informazioni vedere:

https://www.geeksforgeeks.org/newton-forward-backward-interpolation/

Newton forward interpolation
----------------------------

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (u-cal-sub u k)
  (let (temp u)
    (if (> k 1)
      (for (i 1 (- k 1))
        (setq temp (mul temp (sub u i)))
      )
    )
    temp))

(define (forward-interp x y x-value)
  (local (n yy sum u)
    (setq n (length x))
    ; matrix of difference
    (setq yy (array n n '(0)))
    ; column 0 for input data values
    (dolist (val y)
      (setf (yy $idx 0) val)
    )
    ; calculating the forward difference table
    (for (i 1 (- n 1))
      (for (j 0 (- n i 1))
        (setf (yy j i) (sub (yy (+ j 1) (- i 1)) (yy j (- i 1))))
      )
    )
    ; print table
    ;(for (i 0 (- n 1))
    ;  (print (x i) { })
    ;  (for (j 0 (- n i 1))
    ;    (print (yy i j) { })
    ;  )
    ;  (println)
    ;)
    ; calculating interpolation value
    (setq sum (yy 0 0))
    (setq u (div (sub x-value (x 0)) (sub (x 1) (x 0))))
    (for (i 1 (- n 1))
      (setq sum (add sum (div (mul (u-cal-sub u i) (yy 0 i)) (fact-i i))))
    )
    sum))

Facciamo una prova:

(setq xx '(45 50 55 60))
(setq yy '(0.7071 0.7660 0.8192 0.8660))

(forward-interp xx yy 52)
;-> 0.7880032

Newton backward interpolation
-----------------------------

(define (u-cal-add u k)
  (let (temp u)
    (if (> k 1)
      (for (i 1 (- k 1))
        (setq temp (mul temp (add u i)))
      )
    )
    temp))

(define (backward-interp x y x-value)
  (local (n yy sum u)
    (setq n (length x))
    ; matrix of difference
    (setq yy (array n n '(0)))
    ; column 0 for input data values
    (dolist (val y)
      (setf (yy $idx 0) val)
    )
    ; calculating the backward difference table
    (for (i 1 (- n 1))
      (for (j (- n 1) (- i 1) -1)
        (setf (yy j i) (sub (yy j (- i 1)) (yy (- j 1) (- i 1))))
      )
    )
    ; print table
    ;(for (i 0 (- n 1))
    ;  (for (j 0 i)
    ;    (print (yy i j) { })
    ;  )
    ;  (println)
    ;)
    ; calculating interpolation value
    (setq sum (yy (- n 1) 0))
    (setq u (div (sub x-value (x (- n 1))) (sub (x 1) (x 0))))
    (for (i 1 (- n 1))
      (setq sum (add sum (div (mul (u-cal-add u i) (yy (- n 1) i)) (float (fact-i i)))))
    )
    sum))

Facciamo una prova:

(setq xx '(1891 1901 1911 1921 1931))
(setq yy '(46 66 81 93 101))

(backward-interp xx yy 1925)
;-> 96.836

Proviamo le due funzioni con gli stessi dati:

(setq xx '(45 50 55 60))
(setq yy '(0.7071 0.7660 0.8192 0.8660))
(forward-interp xx yy 52)
;-> 0.7880032
(backward-interp xx yy 52)
;-> 0.7880032

(setq xx '(1891 1901 1911 1921 1931))
(setq yy '(46 66 81 93 101))
(backward-interp xx yy 1925)
;-> 96.83680000000001
(forward-interp xx yy 1925)
;-> 96.83679999999998


-----------------
Ragazzi e ragazze
-----------------

Un sultano vuole aumentare il numero di donne disponibili per gli harem nel suo paese.
Per raggiungere questo scopo ha approvato una legge che vieta a ogni madre di avere un altro figlio dopo aver dato alla luce il suo primo figlio maschio: fintanto che i suoi figli fossero femmine, le sarebbe stato permesso di continuare a partorire.
Il sultano disse al suo popolo: "Come conseguenza di questa nuova legge, avremo famiglie con 8 femmine e 1 maschio, 5 femmine e 1 maschio, 4 femmine e 1 maschio, anche famiglie con un solo maschio. Ciò avrà l'effetto di aumentare il rapporto tra ragazzi e ragazze nella nostra terra".
Il sultano ha ragione?

Come spesso accade si capisce meglio il problema quando si prova a scrivere un programma per simulare il processo.

Supponiamo che ci siano N famiglie nel paese e cominicamo a "generare" i figli.
Quando una famiglia genera un maschio viene tolta dalle generazioni successive.
Quando non esistono più famiglie in grado di generare nuovi figli, allora calcoliamo il rapporto tra maschi e femmine che abbiamo ottenuto.

(define (genera famiglie show)
  (local (maschi femmine)
    (setq maschi 0)
    (setq femmine 0)
    ; finchè esistono famiglie in grado di generare nuovi figli...
    ; maschio = 0
    ; femmina = 1
    (while (> famiglie 0)
      ; generazione figli (numero di figli = numero famiglie)
      (setq g (rand 2 famiglie))
      ; conta i maschi e le femmine generati
      (setq conta (count '(0 1) g))
      ; aggiorna il numero totale di maschi e femmine
      (setq maschi (+ maschi (conta 0)))
      (setq femmine (+ femmine (conta 1)))
      ; stampa situazione corrente
      (if show (begin
        (println "Famiglie: " famiglie)
        (println "Maschi: " (conta 0) " - Maschi totale: " maschi)
        (println "Femmine: " (conta 1) " - Femmine totale: " femmine)
        (read-line)))
      ; aggiorna il numero di famiglie in grado di generare nuovi figli
      (setq famiglie (- famiglie (conta 0)))
    )
    (list maschi femmine (div maschi femmine))))

Facciamo alcune prove:

(genera 1e5)
;-> (100000 100394 0.9960754626770524)
(genera 1e7)
;-> (10000000 9998772 1.000122815081692)

Sembra che il sultano abbia torto.

Vediamo cosa accade durante il processo con 256 famiglie:

(genera 256 true)
;-> Famiglie: 256
;-> Maschi: 136 - Maschi totale: 136
;-> Femmine: 120 - Femmine totale: 120
;->
;-> Famiglie: 120
;-> Maschi: 51 - Maschi totale: 187
;-> Femmine: 69 - Femmine totale: 189
;->
;-> Famiglie: 69
;-> Maschi: 36 - Maschi totale: 223
;-> Femmine: 33 - Femmine totale: 222
;->
;-> Famiglie: 33
;-> Maschi: 18 - Maschi totale: 241
;-> Femmine: 15 - Femmine totale: 237
;->
;-> Famiglie: 15
;-> Maschi: 7 - Maschi totale: 248
;-> Femmine: 8 - Femmine totale: 245
;->
;-> Famiglie: 8
;-> Maschi: 4 - Maschi totale: 252
;-> Femmine: 4 - Femmine totale: 249
;->
;-> Famiglie: 4
;-> Maschi: 3 - Maschi totale: 255
;-> Femmine: 1 - Femmine totale: 250
;->
;-> Famiglie: 1
;-> Maschi: 1 - Maschi totale: 256
;-> Femmine: 0 - Femmine totale: 250
;->
;-> (256 250 1.024)

Ad ogni generazione (indipendentemente dal numero delle famiglie generatrici) vengono generati il 50% di maschi e il 50% di femmine (circa).
In questo modo il numero totale di maschi e il numero totale di femmine sono quasi uguali, quindi al termine del processo il loro rapporto vale 1 (circa).

La legge del sultano non produce i risultati sperati.


--------------------
Divisione del premio
--------------------

Due forti giocatori di ping-pong (A e B) giocano un match di 5 partite.
Il primo che vince 3 partite vince 300 euro.
Dopo 3 partite il giocatore A conduce per 2 a 1.
Il match viene sospeso per cause di forza maggiore.
Come deve essere diviso il premio tra i due giocatori?

La risposta sembra ovvia: 200 euro ad A e 100 euro a B.

Scriviamo una simulazione.

(define (premi pa pb tot iter)
  (local (vinteA vinteB punA punB end-match game)
    (setq vinteA 0)
    (setq vinteB 0)
    (for (i 1 iter)
      (setq punA pa)
      (setq punB pb)
      (setq end-match nil)
      ; inizio match
      (until end-match
        ; partita casuale
        ; ipotesi: i giocatori sono della stessa forza (50%)
        ; 0 -> vince la partita A
        ; 1 -> vince la partita B
        (setq game (rand 2))
        ; aggiorna il punteggio di chi ha vinto
        (if (zero? game)
            (++ punA)
            (++ punB)
        )
        ; match corrente terminato?
        (cond ((= punA tot)
                (++ vinteA)
                (setq end-match true))
              ((= punB tot)
                (++ vinteB)
                (setq end-match true))
              ;(true (println "punA: " punA " punB: " punB) (read-line))
        )
      )
    )
    (list vinteA vinteB (div vinteA vinteB))))

Facciamo alcune prove.

Prima vediamo un match che parte da 0 a 0 e si arriva a 3:

(premi 0 0 3 1e5)
;-> (49786 50214 0.9914764806627634)

In questo caso entrambi i giocatori hanno la stessa probabilità di vincere il match.

Adesso vediamo il nostro problema (2 a 1 e si arriva a 3):

(premi 2 1 3 1e6)
;-> (75167 24833 3.026899689928724)

In questo caso il giocatore A ha il 75% di probabilità di vincere il match. Quindi deve avere il 75% del premio:

giocatore A
(mul 300 0.75)
;-> 225

giocatore B
(mul 300 0.25)
;-> 75

In altre parole il rapporto tra le due probabilità vale 3, quindi il giocatore A deve avere 3 volte il premio di B (75*3 = 225).

Se i giocatori non sono della stessa forza, allora occorre modificare l'espressione che calcola il risultato di una partita.


--------------------------------------------
Codice numerico univoco per stringhe (ASCII)
--------------------------------------------

Codifica della parola "newLISP":

                ASCII code     format
(char "n")  -->    110    -->   110
(char "e")  -->    101    -->   101
(char "w")  -->    119    -->   119
(char "L")  -->     76    -->   076
(char "I")  -->     73    -->   073
(char "S")  -->     83    -->   083
(char "P")  -->     80    -->   080

(define (code str)
  (let (out "")
    (dostring (c str)
      (extend out (format "%03d" c)))))

(setq s "newLISP")
(code s)
;-> "110101119076073083080"


---------------
Hotel e turisti
---------------

In una città ci sono N hotel.
Per ogni hotel si conosce il numero di camere libere.
Il problema è quello di assegnare le camere d'albergo per gruppi di turisti.
Tutti i membri di un gruppo desiderano soggiornare nello stesso hotel.
Il numero di persone di ogni gruppo è il numero di stanze richiesto.
Si assegna sempre un gruppo al primo hotel che dispone di camere sufficienti.
Successivamente, il numero di camere libere nell'hotel diminuisce.
Stampare l'hotel assegnato per ogni gruppo.
Se a un gruppo non può essere assegnato un hotel, stampare -1.

Funzione che cerca l'hotel con i posti richiesti.
Se la lista hotel è ordinata in modo crescente viene selezionato il primo hotel in cui posti >= target. Ritorna nil se non esistono hotel che hanno posti >= target.

(define (find-hotel target lst)
  (local (valore indice stop)
    (setq stop nil)
    (dolist (el lst stop)
      (if (>= el target)
          (set 'indice $idx 'valore el 'stop true)
      )
    )
    (if (!= indice nil)
        (list valore indice)
        nil
    )))

(setq hotel '(10 20 3 5 8 12 4 5 2))
(sort hotel)
;-> (2 3 4 5 5 8 10 12 20)

(find-hotel 21 hotel)
;-> nil

(find-hotel 6 hotel)
;-> (8 5)

(define (coupling hotel group)
  (local ()
    (sort hotel)
    ; situazione iniziale posti hotel
    (println hotel)
    ; per ogni gruppo...
    (while group
      (setq g (pop group))
      ;(println g)
      ; cerca l'hotel più adatto (se esiste)
      (setq cc (find-hotel g hotel))
      ;(println cc)
      (cond ((= cc nil)
             (println "group: " g ", hotel: -1"))
            (true
              (setq h-val (cc 0))
              (setq h-idx (cc 1))
              ;(println h-val { } h-idx)
              (setf (hotel h-idx 0) (- h-val g))
              ;(println hotel)
              ;(if (zero? (hotel h-idx 0)) (pop hotel h-idx))
              (if (zero? (hotel h-idx 0)) (setf (hotel h-idx 0) -9999))
              (println "group: " g ", hotel: " h-idx)
              ;(println hotel)
              ;(read-line)
            )
      )
    )
    ; situazione finale posti hotel
    (println hotel)
    'end))

Facciamo alcune prove:

(setq hotel '(2 3 4 5 5 8 10 12 20))
(setq group '(1 3 5 4 3 2 7 4 1 5 7))
(coupling hotel group)
;-> (2 3 4 5 5 8 10 12 20)
;-> group: 1, hotel: 0
;-> group: 3, hotel: 1
;-> group: 5, hotel: 3
;-> group: 4, hotel: 2
;-> group: 3, hotel: 4
;-> group: 2, hotel: 4
;-> group: 7, hotel: 5
;-> group: 4, hotel: 6
;-> group: 1, hotel: 0
;-> group: 5, hotel: 6
;-> group: 7, hotel: 7
;-> (-9999 -9999 -9999 -9999 -9999 1 1 5 20)

(setq hotel '(1 2 2 3 4 5 5 6))
(setq group '(4 4 7 1 1))
(coupling hotel group)
;-> (1 2 2 3 4 5 5 6)
;-> group: 4, hotel: 4
;-> group: 4, hotel: 5
;-> group: 7, hotel: -1
;-> group: 1, hotel: 0
;-> group: 1, hotel: 1
;-> (-9999 1 2 3 -9999 1 5 6)

(setq hotel (sequence 10 1000 3))
(setq group (randomize (sequence 10 100)))
(coupling hotel group)
;-> ...
;-> ...

Nota: l'algoritmo non è ottimale. Credo che la soluzione migliore sarebbe quella di usare un albero di ricerca.


--------------
Ordinare 0 e 1
--------------

Data una lista/vettore di 0 e 1 in ordine casuale.
Spostare gli 0 sul lato sinistro e gli 1 sul lato destro della lista/vettore.
(Fondamentalmente occorre ordinare la lista/vettore).

(setq a (rand 2 100))
;-> (1 1 1 0 0 0 0 1 0 1 1 1 1 0 1 0 0 0 1 1 0 0 1 0 1 0 0 0 0 0 1 0 1
;->  1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 0 1 1 1 1 1 0 1 1 0 1 1 1 1 1 0 0 0
;->  0 0 1 1 0 0 0 1 0 1 0 0 0 0 0 1 0 1 1 1 0 1 0 1 0 0 1 1 1 0 0 0 0 1)

Soluzione veloce:

(define (alg01 lst)
  ; ordinamento ascendente
  (sort lst))

(alg01 a)
;-> (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1
;->  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)

Soluzione stile newLISP:

(define (alg02 lst)
    ; conta il numero di 0 e 1 nella lista
  (let (cc (count '(0 1) lst))
    ; unisce due liste di 0 e 1 lunghe (cc 0) e (cc 1)
    (append (dup 0 (cc 0)) (dup 1 (cc 1)))))

(alg02 a)

(define (alg03 lst)
  (local (c0 c1)
    ; calcola il numero di 1
    (setq c1 (apply + lst))
    ; calcola il numero di 0
    (setq c0 (- (length lst) c1))
    ; unisce due liste di 0 e 1 lunghe c0 e c1
    (append (dup 0 c0) (dup 1 c1))))

(alg03 a)

Soluzione elegante:

(define (alg04 lst)
  (let (out '())
    (dolist (el lst)
      (if (zero? el)
          ; 0 all'inizio (sinistra) della lista di output
          (push el out)
          ; 1 alla fine (destra) della lista di output
          (push el out -1)))))

(alg04 a)

Soluzione agnostica (lista e vettore):

(define (alg05 arr)
  (local (len sx dx)
    (setq len (length arr))
    (setq sx 0)
    (setq dx (- len 1))
    (while (< sx dx)
      (while (and (zero? (arr sx)) (< sx dx)) (++ sx))
      (while (and (= 1 (arr dx)) (< sx dx)) (-- dx))
      (if (< sx dx)
        (begin
          (setf (arr sx) 0)
          (setf (arr dx) 1)
          (++ sx)
          (-- dx)
        )
      )
    )
    arr))

(alg05 a)

(define (alg06 arr)
  (local (val0 val1)
    (setq val0 0)
    (setq val1 (- (length arr) 1))
    (while (< val0 val1)
      (if (= (arr val0) 1)
        (begin
          (if (!= (arr val1) 1)
              (swap (arr val0) (arr val1))
          )
          (-- val1)
        )
        ;else
        (++ val0)
      )
    )
    arr))

(alg06 a)

Vediamo se le funzioni restituiscono tutte lo stesso risultato:

(setq a (rand 2 100))
(= (alg01 a) (alg02 a) (alg03 a) (alg04 a) (alg05 a) (alg06 a))
;-> true

Vediamo la velocità della funzioni:
;
; test con lista/vettore di 1000 elementi
;
(silent
  (setq lista (rand 2 1000))
  (setq vettore (array (length lista) lista)))

(list? lista)
;-> true
(array? vettore)
;-> true

(time (alg01 lista) 1000)
;-> 70.011
(time (alg01 vettore) 1000)
;-> 70.105

(time (alg02 lista) 1000)
;-> 114.692
(time (alg02 vettore) 1000)
;-> ERR: list expected in function count : lst
;-> called from user function (alg02 vettore)

(time (alg03 lista) 1000)
;-> 28.951
(time (alg03 vettore) 1000)
;-> 35.934

(time (alg04 lista) 1000)
;-> 300.737
(time (alg04 vettore) 1000)
;-> 312.159

(time (alg05 lista) 1000)
;-> 1594.334
(time (alg05 vettore) 1000)
;-> 150.6

(time (alg06 lista) 1000)
;-> 1736.486
(time (alg06 vettore) 1000)
;-> 143.619

;
; test con lista/vettore di 100000 elementi
;
(silent
  (setq lista (rand 2 100000))
  (setq vettore (array (length lista) lista)))

(time (alg01 lista) 5)
;-> 60.836
(time (alg01 vettore) 5)
;-> 70.813

(time (alg02 lista) 5)
;-> 125.256
(time (alg02 vettore) 5)
;-> ERR: list expected in function count : lst
;-> called from user function (alg02 vettore)

(time (alg03 lista) 5)
;-> 20.077
(time (alg03 vettore) 5)
;-> 22.942

(time (alg04 lista) 5)
;-> 17867.665
(time (alg04 vettore) 5)
;-> 30067.452

(time (alg05 lista) 5)
;-> 210555.044
(time (alg05 vettore) 5)
;-> 84.774

(time (alg06 lista) 5)
;-> 244033.329
(time (alg06 vettore) 5)
;-> 78.626


---------------------------------------------------
Salvare la definizione di un simbolo in una stringa
---------------------------------------------------

Per salvare la definizione di un simbolo in una stringa possiamo usare la seguente funzione che gestisce i seguenti simboli:

- espressioni lambda e numeri (nessuna modifica)
- liste non lambda (aggiunge il carattere quote "'")
- stringhe (incapsula con carattere double quote "")

(define (save-string asym)
  (set 'contents (eval asym))
  (if (or (lambda? contents) (integer? contents) (float? contents))
      ; for lambda expressions and numbers leave like it is
      (append "(set '" (string asym " ") (string (eval asym)) ")")
      (list? contents)
      ; for lists which are not lambda put a single quote
      (append "(set '" (string asym " ") (string "'" (eval asym)) ")")
      (string? contents)
      ; for strings put quotes around it
      (append "(set '" (string asym " ") (string "\"" (eval asym)) ")")))

La stringa salvata può essere valutata con "eval-string".

Vediamo un paio di esempi:

(define (somma a b) (+ a b))
(save-string 'somma)
;-> "(set 'somma (lambda (a b) (+ a b)))"
(setq my-function (eval-string (save-string 'somma)))
;-> (lambda (a b) (+ a b))
(my-function 3 5)
;-> 8

(eval-string (save-string 'save-string))
;-> (lambda (asym) (set 'contents (eval asym))
;->  (if (or (lambda? contents) (integer? contents) (float? contents))
;->   (append "(set '" (string asym " ") (string (eval asym)) ")")
;->   (list? contents)
;->   (append "(set '" (string asym " ") (string "'" (eval asym)) ")")
;->   (string? contents)
;->   (append "(set '" (string asym " ") (string "\"" (eval asym)) ")")))

Nota: potremmo riscontrare problemi con i tag [text] [/text] nidificati.


-------------
Loop infinito
-------------

Come implementare un ciclo infinito?

Prima soluzione:

(while true func)

Seconda soluzione:

(dotimes (x 9223372036854775807) func)

Terza soluzione:

(define-macro (loop _func) (while true (eval _func)))

(loop (print "."))
;;; LOOP

Nota: (define (loop _func) (while true _func)) non funziona perchè quando l'argomento (println ".") viene passato alla funzione, viene valutato e restituisce ".". QUindi all'interno della tua funzione viene eseguita continuamente l'espressione (true ".") che non produce nessun output.
L'uso di "define-macro" lascia (println ".") non valutato e viene eseguita l'espressione:
(while true (eval '(println "."))) che stampa "." in continuazione.


-------------------------------
Simulazione della funzione LOAD
-------------------------------

La funzione LOAD carica e traduce codice newLISP da un file sorgente specificato in uno o più file e valuta le espressioni contenute in tutti i file. Quando LOAD ha esito positivo, restituisce il risultato dell'ultima espressione nell'ultimo file valutato.

Quello che ci interessa è una metodo per caricare uno script, valutarlo, ma NON eseguirlo.
Per fare questo possiamo creare il file seguente:

;; file: myprog.lsp ;;

(setq myprog '(print "hello world"))

;; eof ;;

Adesso carichiamo il file con LOAD:

(load "myprog.lsp")
myprog => (print "hello world")

(eval myprog)
;-> "hello world" ; return value
;-> hello world ; output from running myprog


-------------------------
Unione veloce di stringhe
-------------------------

Se tutte le stringhe da utilizzare sono già disponibili in una lista, allora "append", "join" o "string" vanno bene, ma in caso contrario "write-buffer" con device string è più veloce.

Si noti inoltre che "string" è molto più lenta di "append", perché converte anche da non stringa a stringa, mentre "append" presuppone che tutti gli argomenti siano stringhe.

Anche quando usiamo la funzione "string" su un tipo noto, ad esempio:

(string cognome "," età)

se siamo sicuri l'età sarà sempre un numero, allora "format" è 3 volte più veloce:

(format "%s,%d" età)


--------------
The nice thing
--------------

Lutz:
-----
The nice thing about LISP and Scheme is, that the syntax rules are very simple : the first list member is the functor/operator and the rest are the parameters/arguments. The only difference between LISP and Scheme/newLISP is that Scheme and newLISP evaluate the first list member first before applying it to the parameters:
;; newLISP and Scheme evaluate the operator part first (other LISPs don't):

((if (> A B) + *) A B)

;; in this example A and B are added if A > B else multiplied
Most of syntax changes suggestions could be implemented by defining functions or macros for it, i.e:

(define (<=> x y A B C)
   (if
    (< x y) A
    (= x y) B
    (> x y) C))

(<=> 3 4 10 20 30) => 10
(<=> 4 4 10 20 30) => 20
(<=> 5 4 10 20 30) => 30

In newLISP you also have the possibility to redefine the built-in functions using "constant".
Doing this and using functions and macros, you can completely tailor a language to your own taste, which is the reason people use these kind of languages in the first place, because they let you define your own language appropiate to the problem area you are developing in.
For example:
(constant (global 'const) constant)
(constant (global 'df) define)
(constant (global 'dm) define-macro)
(constant (global 'ap) apply)
(constant (global 'filt) filter)
(constant (global 'car) first)
(constant (global 'cdr) rest)
(constant (global 'cat) append)
(constant (global 'fmt) format)
(constant (global 'pr) print)
(constant (global 'prn) println)
(constant (global 'len) length)
(constant (global 'int) integer)
(constant (global 'int?) integer?)
(constant (global 'str) string)
(constant (global 'str?) string?)


---------------
Pigeonhole Sort
---------------

Il Pigeonhole sort ("buco della piccionaia") è un algoritmo di ordinamento particolarmente adatto quando il numero di elementi n e la lunghezza dell'intervallo dei possibili valori chiave (N) sono approssimativamente uguali.
L'algoritmo ha una complessità temporale e spaziale di O(n + N).
Il nome pigeonhole (tradotto in "buco della piccionaia") deriva dal nome inglese del principio dei cassetti, che ricorda il processo di assegnamento ad una cella all'interno dell'algoritmo.

L'algoritmo funziona nel modo seguente:

- Creare un array temporaneo composto inizialmente di celle vuote (i "pigeonhole"), ciascuna per ogni valore compreso nel range dell'array da ordinare.
- Scorrere l'array dato e inserire ogni valore nella cella corrispondente dell'array temporaneo, in modo che ogni cella alla fine contenga il numero dei valori che corrispondo alla stessa chiave.
- Iterare sull'array di appoggio e generare l'array ordinato combinando il valore dell'array di appoggio (che rappresenta il numero di ripetizioni del numero) e il suo indice (che rappresenta il valore del numero).

(define (pigeon lst)
  (local (vmax tmp out)
    (setq out '())
    (setq vmax (apply max lst))
    (setq tmp (array (+ vmax 1) '(0)))
    (dolist (el lst)
      (++ (tmp el))
    )
    (println tmp)
    (for (i 0 (- (length tmp) 1))
      (setq val (tmp i))
      (if (> val 0)
          (for (r 1 val) (push i out -1))
      )
    )
    out))

(pigeon '(3 7 9 7 2))
;-> (0 0 1 1 0 0 0 2 0 1)
;-> (2 3 7 7 9)

Possiamo ottimizzare la dimensione spaziale utilizzando un vettore con dimensione pari all'intervallo dei valori da ordinare:

  (Valore-Max - Valore-Min + 1)

In quest modo dobbiamo solo modificare l'indice del vettore temporaneo utilizzando il valore minimo:

(define (pigeon2 lst)
  (local (vmin vmax tmp out)
    (setq out '())
    ; valore massimo
    (setq vmax (apply max lst))
    ; valore minimo
    (setq vmin (apply min lst))
    (setq tmp (array (+ vmax (- vmin) 1) '(0)))
    ; ciclo per aggiornare l'array temporaneo
    ; in cui il valore dell'i-esimo elemento rappresenta quante volte viene
    ; ripetuto il valore i nell'array/lista originale
    ; l'indice vale (el - vmin)
    (dolist (el lst)
      (++ (tmp (- el vmin)))
    )
    (println tmp)
    ; ciclo per la creazione della lista ordinata
    (for (i 0 (- (length tmp) 1))
      (setq val (tmp i))
      ; se un valore è maggiore di 0,
      (if (> val 0)
          ; allora inseriamo il suo indice i nella lista
          ; tante volte quanto vale il valore
          ; l'indice vale (i + vmin)
          (for (r 1 val) (push (+ i vmin) out -1))
      )
    )
    out))

(pigeon2 '(3 7 9 7 2))
;-> (1 1 0 0 0 2 0 1)
;-> (2 3 7 7 9)

(pigeon2 (rand 3 10))
;-> (3 6 1)
;-> (0 0 0 1 1 1 1 1 1 2)


-----------
Bucket Sort
-----------

https://www.geeksforgeeks.org/bucket-sort-2/

Il bucket sort è efficiente quando i numeri da ordinare sono compresi nell'intervallo da 0.0 a 1.0 e sono distribuiti uniformemente nell'intervallo.

Algoritmo Bucket Sort
1) Creare n bucket (liste) vuote.
2) Per ogni elemento dell'array di input arr[i]
  2.1) Inserire arr[i] in bucket[n*array[i]]
3) Ordinare i singoli bucket utilizzando l'ordinamento per inserzione.
4) Concatenare tutti i bucket ordinati.

Funzione che ordina una lista con il metodo "insertion sort":

(define (insertion-sort b)
  (local (up j)
    (cond ((= b '()) '())
          ((= (length b) 1) b)
          (true
            (for (i 1 (- (length b) 1))
              (setq up (b i))
              (setq j (- i 1))
              (while (and (>= j 0) (> (b j) up))
                (setf (b (+ j 1)) (b j))
                (-- j)
              )
              (setf (b (+ j 1)) up)
            )
            b))))

(insertion-sort '(3 4 2 6 7 1 5 8 2))
;-> (1 2 2 3 4 5 6 7 8)

(insertion-sort '())
;-> ()
(insertion-sort '(1.23))
;-> (1.23)

Come struttura dati usiamo una lista "arr" che contiene i bucket (liste):

  arr = ((bucket1) (bucket2) ((bucket3)) ...)

(define (bucket1 x)
  (local (arr slot-num index-b)
    ; 10 means 10 slots, each slot's size is 0.1
    (setq slot-num 10)
    (setq arr (dup '() slot-num))
    ; put array elements in different buckets
    (dolist (j x)
      (setq index-b (int (mul slot-num j)))
      (push j (arr index-b))
    )
    (println arr)
    ; sort individual buckets
    (for (i 0 (- slot-num 1))
      (setf (arr i) (insertion-sort (arr i)))
    )
    ; concatenate result
    (flat arr)))

Facciamo alcune prove:

(bucket1 '(0.897 0.565 0.656 0.1234 0.665 0.3434))
;-> (() (0.1234) () (0.3434) () (0.565) (0.665 0.656) () (0.897) ())
;-> (0.1234 0.3434 0.565 0.656 0.665 0.897)

(bucket1 (random 0 1 20))
;-> ((0.008789330729087191 0.05621509445478683) (0.108279671620838)
;->  (0.2053590502639851 0.2728965117343669 0.2758873256630146)
;->  (0.3852351451155126)
;->  (0.4579607531968138 0.4684591204565569 0.4849391155735954)
;->  (0.5990478225043489 0.58790856654561)
;->  (0.6911832026123844 0.6772057252723777)
;->  (0.7444380016479996 0.7437360759300515 0.7264931180761132)
;->  (0.8376110110782189)
;->  (0.9491561632129887 0.9187902462843715))
;-> (0.008789330729087191 0.05621509445478683 0.108279671620838
;->  0.2053590502639851   0.2728965117343669  0.2758873256630146
;->  0.3852351451155126   0.4579607531968138  0.4684591204565569
;->  0.4849391155735954   0.58790856654561    0.5990478225043489
;->  0.6772057252723777   0.6911832026123844  0.7264931180761132
;->  0.7437360759300515   0.7444380016479996  0.8376110110782189
;->  0.9187902462843715   0.9491561632129887)

Adesso vediamo il Bucket Sort per i numeri con parte intera:

1. Trovare l'elemento massimo e minimo dell'array
2. Calcolare l'intervallo di ciascun bucket:
    intervallo = (max - min) / n
    n è il numero di bucket
3. Creare n bucket dell'intervallo calcolato
4. Distribuire gli elementi dell'array in questi bucket:
    BucketIndex = ( arr[i] - min ) / intervallo
5. Ordinare ogni bucket individualmente
6. Unire gli elementi ordinati dei bucket

(define (bucket2 arr buckets)
  (local (max-ele min-ele range temp diff)
    (setf max-ele (apply max arr))
    (setf min-ele (apply min arr))
    # range(for buckets)
    (setq range (div (sub max-ele min-ele) buckets))
    # create empty buckets
    (setq temp (dup '() buckets))
    # scatter the array elements
    # into the correct bucket
    (dolist (el arr)
      (setq diff (sub (div (sub el min-ele) range)
                      (int (div (sub el min-ele) range))))
      # append the boundary elements to the lower array
      (if (and (zero? diff) (!= el min-ele))
          (push el (temp (sub (int (div (sub el min-ele) range)) 1)))
          ;else
          (push el (temp (int (div (sub el min-ele) range))))
      )
    )
    # sort each bucket individually
    (for (i 0 (- buckets 1))
      ;(setf (temp i) (insertion-sort (temp i)))
      ;little cheat
      (sort (temp i))
    )
    ; concatenate result
    (flat temp)))

Facciamo alcune prove:

(bucket2 '(9.8 0.6 10.1 1.9 3.07 3.04 5.0 8.0 4.8 7.68) 5)
;-> (0.6 1.9 3.04 3.07 4.8 5 7.68 8 9.800000000000001 10.1)

(bucket2 (random 1 100 10) 5)
;-> (17.01916562395093 19.99472029786065 34.59477523117771 51.41352580339976
;->  54.2578508865627 58.78679769280068 63.86812952055421 70.5760979033784
;->  93.48023926511429 97.30420850245675)

(bucket2 (rand 100 10) 5)
;-> (11 37 38 49 49 50 53 66 68 79)


--------------------------------
Creazione automatica di contesti
--------------------------------

In newLISP non si possono creare contesti anonimi , ma è possibile utilizzare uno schema di numerazione, ad esempio:

(context 'BRICK)

(define color MAIN:red)

(define (BRICK:new ctx col x y z)
  (MAIN:new BRICK ctx)
  (set 'ctx (eval ctx))
  (set 'ctx:color col)
  ctx
)
(context 'MAIN)

(BRICK:new (sym (format "brick-%03d" 111)) 'blue)
;-> brick-111

brick-111:color
;-> blue

Possiamo anche creare una lista di contesti:

(map (fn(x) (BRICK:new (sym (format "brick%03d" x)) 'blue)) (sequence 1 5))
;-> (brick001 brick002 brick003 brick004 brick005)

Possiamo anche scrivere:

(set 'bricks (map (fn(x) (BRICK:new (sym (format "brick%03d" x)) 'blue)) (sequence 1 5)))
;-> (brick001 brick002 brick003 brick004 brick005)

(dolist (b bricks)
  (set 'b:color 'black))

brick003:color
;-> black

Possiamo fare riferimento ai vari contresti brick per variabile, ecc.


---------------------------------------------
Forum: A quasiquote implementation in newLISP
---------------------------------------------

jsmall:
-------

The following macro and function define a quasiquote / unquote mechanism in newlisp.

Note the use of uq and uq@.

  ;; usage:  (qq (x y (uq (+ 1 2)) (uq@ (list 1 2 3))))
  ;;  ==>  (x y 3 1 2 3)

  (define-macro (qq s-expr)
    (qq-eval s-expr))

  ;; Since qq is a macro you can't use (args) within.
  ;; Use qq-eval instead which is not a macro and thus
  ;; (args) will not capture the qq's (args).

  ;; usage:  (qq-eval '(x y (uq (+ 1 2)) (uq@ (list 1 2 3))))
  ;;  ==>  (x y 3 1 2 3)
  (define (qq-eval s-expr , i)
    (if (list? s-expr)
      (begin
        (setq i 0)
        (while (< i (length s-expr))
          (let ((ss-expr (nth i s-expr)))
            (if (list? ss-expr)
              (cond
                ((= 'uq (first ss-expr))
                  ;(nth-set i s-expr (eval (qq-eval (last ss-expr)))) ;original
                  (setf (s-expr i) (eval (qq-eval (last ss-expr))))
                  ;(inc 'i)) ;original
                  (inc i))
                ((= 'uq@ (first ss-expr))
                  (let ((ss-exprs (eval (qq-eval (last ss-expr)))))
                    (if (list? ss-exprs)
                      (begin
                        (pop s-expr i)
                        (dotimes (j (length ss-exprs))
                          (push (nth j ss-exprs) s-expr i)
                          (inc 'i)))
                      (begin
                        ;(nth-set i s-expr ss-exprs) ;original
                        (setf (s-expr i) ss-exprs)
                        ;(inc 'i))))) ;original
                        (inc i)))))
                 (true
                   ;(nth-set i s-expr (qq-eval ss-expr)) ;original
                   (setf (s-expr i) (qq-eval ss-expr))
                   ;(inc 'i))) ;original
                   (inc i)))
              (begin
                ;(inc 'i) ;original
                (inc i)
                s-expr))))
           s-expr)
      s-expr))

(qq-eval '(x y (uq (+ 1 2)) (uq@ (list 1 2 3))))
;-> x y 3 3 2 1

The following demonstrates the use of qq and qq-eval.

  ;; Abbreviation for lambda or fn

  (define-macro (\ )
    (eval (qq-eval '(lambda (uq (first (args))) (uq@ (rest (args)))))))

  ;; Abbreviation for define

  ;(define-macro (: _var-or-fn _value) ;original
  (define-macro ([:] _var-or-fn _value)
    (if (list? _var-or-fn)
      (eval (qq-eval '(define (uq _var-or-fn) (uq@ (rest (args))))))
      (eval (qq (set _var-or-fn (uq _value))))))

Notice that qq is not used whenever (args) appears in the expression being quasiquoted.

I'm hoping this makes writing macros more convenient in newLisp.

Warning: I've only briefly tested this.

Lutz:
-----

>>>
;; Since qq is a macro you can't use (args) within.
>>>

it is the other way around macros *can* use (args) normal functions *can not*:

(define-macro (foo) (println (args)))

(foo 1 2 3)
;-> (1 2 3)

(define (foo) (println (args)))
;-> (lambda () (println (args)))
(foo 1 2 3)
;-> (1 2 3)

Consider also using 'ref' for looking up 'uq' or 'uq@' expressions.
This is how a qq-macro could look like for just handling the unquoting of uq:

(define-macro (qq s-exp)
  (while (set 'idx (chop (ref 'uq s-exp)))
      (set 'qx (pop s-exp idx))
      (push (eval (first (rest qx))) s-exp idx))
  s-exp)

;; now use it
(set 'x 'hello)

(qq ( (uq (+ 1 2)) ((uq (+ 3 4)) (uq x))))
;-> ERR: list or string expected
;-> called from user function (qq ((uq (+ 1 2)) ((uq (+ 3 4)) (uq x))))

Nota: Ma funziona con "debug" (step-by-step):
(debug (qq ( (uq (+ 1 2)) ((uq (+ 3 4)) (uq x)))))
;-> (3 (7 hello))

;; something similar could be done for 'uq@'

'ref' returns the index positions of an expresssion found in a nested list in an index-list, which can be used directly in 'pop' or 'push' which can take index lists. 'pop' and 'push' are inverse of each other. The same index-list used to pop something can be used to push something else back into the same position.

jsmall:
-------

1. It would be nice if "ref" had a version that took a predicate, e.g.

     (ref? (lambda (s-expr) (or (= 'uq s-expr) (= 'uq@ s-expr)))
            s-exp)

and returned the ref path along with the value returned by
the predicate.

2. Also if the continuation bookmark could be captured and
returned as well so that the depth first? search could continue
from where it left off that would also be nice.

Essentially my longer version was taking this approach (1 & 2) but
the size and speed advantage of your approach is obvious.


------------------------------------------------------------------------
Raggruppare i valori di una lista associativa che hanno la stessa chiave
------------------------------------------------------------------------

Dato una lista associativa ((k1 v1) (k2 v2) ... (kn vn)), con possibilmente valori uguali per ki, restituire una lista associativa in cui tutti gli elementi (coppia ki vi) hanno chiavi distinte e dove i valori originariamente associati alla stessa chiave sono stati raggruppati in una lista. Per esempio:

input:  ((1 "a") (2 "b") (3 "c") (1 "A") (2 "B")))
output: ((1 ("a" "A")) (2 ("b" "B")) (3 ("c")))

(define (group-keys alst)
  (local (out indici keys tmp)
    (setq out '())
    ; lista delle chiavi uniche
    (setq keys (unique (map first alst)))
    ; ciclo per ogni chiave
    (dolist (k keys)
      ; trova tutti gli indici degli elementi con la chiave corrente
      (setq indici (ref-all k alst))
      (setq tmp '())
      ; costruisce la lista dei valori per la chiave corrente
      (dolist (i indici)
        (if (zero? (i 1)) ; indice di una chiave?
          (push (alst (i 0) 1) tmp -1)
        )
      )
      ; aggiorna la lista soluzione con (ki (v1 v2..vn))
      (push (list k tmp) out -1)
    )
    out))

Facciamo alcune prove:

(setq a '((1 "a") (2 "b") (3 "c") (1 "A") (2 "B")))
(group-keys a)
;-> ((1 ("a" "A")) (2 ("b" "B")) (3 ("c")))

(setq a '((1 1) (2 "b") (3 "c") (1 "A") (2 "B")))
(group-keys a)
;-> ((1 (1 "A")) (2 ("b" "B")) (3 ("c")))

(setq a '((1 "a") (2 "b") (3 "c")))
(group-keys a)
;-> ((1 "a") (2 "b") (3 "c")))

(setq a '((1 "a") (2 "b") (3 "c") (1 ())))
(group-keys a)
;-> ((1 ("a" ())) (2 ("b")) (3 ("c")))

Possiamo anche utilizzare una hash-map (dizionario):

(define (group-keys2 alst)
  (local (key out)
    (new Tree 'hh)
    (dolist (el alst)
      (setq key (el 0))
      ; se chiave esiste,
      ; allora aggiunge un valore alla lista associata alla chiave
      ; altrimenti aggiunge una nuova coppia (k v)
      (hh key (if $it (extend (list (el 1)) $it)  (list (el 1))))
    )
    ; assegna la hash-map ad una lista
    (setq out (hh))
    ;elimina la hash-map
    (delete 'hh)
    out))

Facciamo alcune prove:

(setq a '((1 "a") (2 "b") (3 "c") (1 "A") (2 "B")))
(group-keys2 a)
;-> (("1" ("A" "a")) ("2" ("B" "b")) ("3" ("c")))

(setq a '((1 1) (2 "b") (3 "c") (1 "A") (2 "B")))
(group-keys2 a)
;-> (("1" ("A" 1)) ("2" ("B" "b")) ("3" ("c")))

(setq a '((1 "a") (2 "b") (3 "c")))
(group-keys2 a)
;-> (("1" ("a")) ("2" ("b")) ("3" ("c")))

(setq a '((1 "a") (2 "b") (3 "c") (1 ())))
(group-keys2 a)
;-> (("1" (() "a")) ("2" ("b")) ("3" ("c")))

Differenze tra le due funzioni:
- la hash-map trasforma le chiavi in stringhe
- la hash-map ha tutti i valori come lista (anche per un solo valore)

Vediamo la velocità delle due funzioni:

(silent
(setq k (rand 100 1e3))
(setq v (rand 100 1e3))
(setq t (map list k v)))

(time (group-keys t) 10000)
;-> 213.953

(time (group-keys2 t) 10000)
;-> 407.212

La funzione che utilizza la hash-map è più lenta perchè deve "eliminare" la hash-map ad ogni chiamata.

; test senza cancellare la hash-map --> ;(delete 'hh)
; una sola chiamata con una lista da 1 milione di elementi

(silent
(setq k (rand 100 1e7))
(setq v (rand 100 1e7))
(setq t (map list k v)))

(time (group-keys t))
;-> 418.376

(time (group-keys2 t))
;-> 523.719

Possiamo generalizzare la funzione per utilizzare liste di associazione che hanno più di un valore associato ad una chaive.
Per esempio:

(setq cc
'(("User1" 1 20 4 9 1 10 2005)
  ("User3" 19 31 5 17 1 10 2005)
  ("User6" 13 44 15 18 1 10 2005)
  ("User6" 2 55 9 12 2 10 2005)
  ("User6" 5 44 58 14 2 10 2005)
  ("User2" 2 47 17 17 2 10 2005)
  ("User2" 3 28 19 17 2 10 2005)
  ("User1" 3 45 52 17 2 10 2005)))

(define (group-keys alst)
  (local (out indici keys tmp)
    (setq out '())
    ; lista delle chiavi uniche
    (setq keys (unique (map first alst)))
    ; ciclo per ogni chiave
    (dolist (k keys)
      ; trova tutti gli indici degli elementi con la chiave corrente
      (setq indici (ref-all k alst))
      (setq tmp '())
      ; costruisce la lista dei valori per la chiave corrente
      (dolist (i indici)
        (if (zero? (i 1)) ; indice di una chiave?
          ; inserisce tutti i valori associati alla chiave corrente
          (push (slice (alst (i 0)) 1) tmp -1)
          ;(push (alst (i 0) 1) tmp -1)
        )
      )
      ; aggiorna la lista soluzione con (ki (v1 v2..vn))
      (push (list k tmp) out -1)
    )
    out))

(group-keys cc)
;-> (("User1" ((1 20 4 9 1 10 2005) (3 45 52 17 2 10 2005)))
;->  ("User3" ((19 31 5 17 1 10 2005)))
;->  ("User6" ((13 44 15 18 1 10 2005) (2 55 9 12 2 10 2005) (5 44 58 14 2 10 2005)))
;->  ("User2" ((2 47 17 17 2 10 2005) (3 28 19 17 2 10 2005))))


------------------------
Ramanujan e il taxi 1729
------------------------

Nel 1940 il matematico G. H. Hardy andò a trovare il genio indiano Ramanujan che si trovava in ospedale. Hardy disse a Ramanujan che era arrivato con il taxi numero 1729, un numero che gli sembrava noioso e sperava non fosse di cattivo auspicio.
Immediatamente Ramanujan rispose che 1729 era un numero molto interessante:
era il numero più piccolo esprimibile come somma di cubi di due numeri in due modi diversi.
Infatti, 10^3 + 9^3 = 12^3 + 1^3 = 1729.

Scriviamo una funzione che calcola questi numeri fino ad un dato numero N.
In pratica dobbiamo cercare 4 numeri tali che:

  a^3 + b^3 = c^3 + d^3

(define (rama n)
  (local (out all-sumlimit idx)
    (setq out '())
    (setq all-sum '())
    ; limit number: cbrt(n) (cube root of n)
    (setq limit (int (pow n (div 3))))
    ; two loops for numbers a and b
    (for (i 1 (- limit 2))
      (for (j (+ i 1) limit)
        ; calculate current sum
        (setq sum (+ (* i i i) (* j j j)))
        ; search sum in all-sum
        (setq idx (ref sum all-sum))
        ; sum exists in list all-sum?
        ; (idx 1) must be 0
        ; otherwise sum is found on first or second number
        (if (and (!= idx nil) (zero? (idx 1)))
            ; put all values (sum a b c d) on solution list
            (push (list (all-sum (idx 0) 0) ; sum
                        (all-sum (idx 0) 1) ; first number
                        (all-sum (idx 0) 2) ; second number
                        i j)                ; current first and second number
                        out -1)
            ;else
            ; insert (sum i j) on all-sum
            (push (list sum i j) all-sum -1)
        )
      )
    )
    out))

Facciamo alcune prove:

(rama 1e5)
;-> ((1729 1 12 9 10) (4104 2 16 9 15) (39312 2 34 15 33)
;->  (40033 9 34 16 33) (13832 2 24 18 20) (32832 4 32 18 30)
;->  (20683 10 27 19 24) (64232 17 39 26 36) (46683 3 36 27 30)
;->  (65728 12 40 31 33))

(rama 1e7)
;-> ((1729 1 12 9 10)
;->  (4104 2 16 9 15)
;->  (39312 2 34 15 33)
;->  (40033 9 34 16 33)
;->  (13832 2 24 18 20)
;->  (32832 4 32 18 30)
;->  ...
;->  (9261729 9 210 161 172)
;->  (10702783 135 202 166 183)
;->  (10870119 126 207 168 183))

(time (println (length (rama 1e7))))
;-> 155
;-> 7121.324
(time (println (length (rama 1e8))))
;-> 497
;-> 162745.134

Sequenza OEIS: A001235
  1729, 4104, 13832, 20683, 32832, 39312, 40033, 46683, 64232,
  65728, 110656, 110808, 134379, 149389, 165464, 171288, 195841,
  216027, 216125, 262656, 314496, 320264, 327763, 373464, 402597,
  439101, 443889, 513000, 513856, 515375, 525824, 558441, 593047,
  684019, 704977, ...

(sort (map first (rama 1e6)))
;-> (1729 4104 13832 20683 32832 39312 40033 46683 64232 65728 110656
;->  110808 134379 149389 165464 171288 195841 216027 216125 262656 314496
;->  320264 327763 373464 402597 439101 443889 513000 513856 515375 525824
;->  558441 593047 684019 704977 805688 842751 885248 886464 920673 955016
;->  984067 994688 1009736 1016496)


------------------------
Numero somma di due cubi
------------------------

Scrivere una funzione che verifica se un numero è la somma di due cubi perfetti.

Utilizziamo due puntatori "low" e "high" e poniamo low = 1 e high = int(cbrt(n)).
Quindi effettuiamo un ciclo con la condizione (low <= high),
  se il valore corrente (low*low*low + high*high*high) è uguale a n, allora il numero n è la somma di due cubi.
  se il valore corrente (low*low*low + high*high*high) è minore di n incrementiamo low, altrimenti decrementiamo high.
Quando (low >= high) usciamo dal ciclo senza soluzione.

(define (cubesum? n)
  (local (low high val continua)
    (setq continua true)
    (setq low 1)
    (setq high (int (pow n (div 3))))
    (while (and (<= low high) continua)
      (setq val (+ (* low low low) (* high high high)))
      (if (= val n) (setq continua nil)
          (< val n) (++ low)
          (> val n) (-- high)
      )
    )
    (if continua (list high low) nil)))

(cubesum? 125)
;-> (3 4)

(cubesum? 1719)
;-> (9 10)

(cubesum? 2000)
;-> nil


-------------
Cubo perfetto
-------------

Scrivere una funzione per verificare su un dato numero N è un cubo perfetto.

Metodo 1:
---------
Si può dimostrare che tutti i cubi perfetti devono avere radice digitale 1, 8 o 9.
Tuttavia, non è sempre vero il contrario. Cioè, se un numero ha una radice digitale di 1, 8 o 9, ciò non significa che il numero dato deve essere un cubo perfetto.

Inoltre, la radice digitale del cubo di qualsiasi numero può essere calcolata anche nel modo seguente:

- Se il numero è divisibile per 3, il suo cubo ha radice numerica 9;
- Se ha resto 1 quando diviso per 3, il suo cubo ha radice numerica 1;
- Se ha un resto di 2 quando diviso per 3, il suo cubo ha radice numerica 8.

Quindi se un numero N non ha radice digitale pari a 1, 8 o 9, allora non è un cubo perfetto.

Rimane da verificare se il numero n che ha radice pari a 1, 8 o 9 è un numero perfetto o meno.

Per fare questo un metodo è quello di calcolare la fattorizzazione di N.
Se la frequenza di ogni fattore primo non è un multiplo di 3, allora il numero N non è un cubo perfetto.

(define (digit-root num)
"Calculates the repeated sum of the digits of an integer"
    (+ 1 (% (- (abs num) 1) 9)))

(define (cube? n)
  (local (out f)
    (setq out true)
    (setq f (factor n))
    ; il numero di fattori deve essere un multiplo di 3
    (cond ((!= (% (length f) 3) 0 (setq out nil)))
          (true
            (dolist (el (explode f 3) (not out))
              ; ogni gruppo di fattori deve avere tutti i valori uguali
              (if (not (apply = el)) (setq out nil))))
    )
    out))

(cube? 125)
;-> true
(cube? 216)
;-> true
(cube? 999)
;-> nil
(cube? 15625000)
;-> true

Scriviamo una funzione per verificare i risultati di "cube?":

(define (test iter)
  (for (i 2 iter)
    (if (nil? (cube? (* i i i)))
        (println "Error: " i {, } (* i i i)}))))

(time (println (test 1e5)))
;-> nil
;-> 2438.172

Metodo 2:
---------
Possiamo utilizzare la ricerca binaria per risolvere il problema.
I valori di i * i * i aumentano in modo monotono, quindi il problema può essere risolto utilizzando la ricerca binaria.
Vediamo i passi dell'algoritmo:

1) Inizializzare il minimo e il massimo rispettivamente come 1 e N.
2) Iterare fino a (low <= high):
   2.1) Trovare il valore di mid come = (low + high)/2.
   2.2) Se mid*mid*mid è uguale a N, allora output = true.
   2.3) Se il cubo di mid è minore di N aggiornare low a mid + 1.
   2.4) Se il cubo di mid è maggiore di N, aggiornare high to mid – 1.
3) Se non si ottiene il cubo di N nel ciclo precedente, allora output = nil.

Nota: questo algoritmo ha bisogno di utilizzare i big integer.

(define (cube?? n)
  (local (val low mid high continua out)
    (setq n (bigint n))
    (setq low 1L)
    (setq high n)
    (setq continua true)
    (setq out nil)
    (while (and (<= low high) continua)
      (setq mid (/ (+ low high) 2))
      (setq val (* mid mid mid))
      (if (= n val) (set 'out true 'continua nil)
          (> n val) (setq low (+ mid 1))
          (< n val) (setq high (- mid 1))
      )
      ;(println val { } low { } high { } mid)
      ;(read-line)
    )
    out))

(cube?? 125)
;-> true
(cube?? 216)
;-> true
(cube?? 999)
;-> nil
(cube?? 15625000)
;-> true

Scriviamo una funzione per verificare i risultati di "cube??":

(define (test iter)
  (for (i 2 iter)
    (setq k (bigint i))
    (if (nil? (cube?? (* k k k)))
        (println "Error: " i {, } (* i i i)))))

(time (println (test 1e5)))
;-> nil
;-> 3225.404


-----------------------------------------------------
Forum: Define-macro: new behind-the-curtains behavior
-----------------------------------------------------

Excalibor:
----------
How hard would it be for define-macro to automagically switch to a new context each time it's called?
This would avoid variable collision in a very elegant way, even if multiple expansions are being performed...
The idea is:

(define-macro (foo x)
  (begin (set 'M (symbol (random)))
         (context 'M)
         (*macro goes in here *)
         (context 'MAIN)))

(set 'x 1)
(print (foo 45)) ; in here 45 is referred by 'M:x and M is different everytime (or it should be) so it's not posible that the expansions collide...
(print x) ; => prints 1

Lutz:
-----
A Context switch only affects compiling statements like 'load', and 'eval-string'. For this reason a context statement only on the toplevel where it is evaluated when loading will affect the translation of symbols to follow. I.e.

(define (foo)
  (context 'Ctx)
  (set 'x 123)
  (eval-str "(set 'y 456"))
  (context 'MAIN))

(foo)

x => 123
Ctx:y 456

In this example 'x' will still be part of main, only 'y' is in Ctx, because when
'foo' is executed 'x' is already compiled in to the MAIN context.

If you want to force the macro arg vars into another context you could just do:

(define-macro (foo m:x)
  (func m:x))

Excalibor:
----------
Now I see how it works, thanks for the clarification... (I couldn't log in at the end last night)...

My comments are motivated by this:

"capture"
I took a quick look at it. It looked to me as if the way you're supposed to avoid variable capture is to use variables with unusual names. Is this really the plan? What about expansions that occur within expansions?

My idea goal is to avoid name collisions on variable expansions...
Would it be too difficult to make (context) work inside macros?

something similar to this:

> (set 'x 13)
13
> (define (foo a , x) (set 'x a) (println x))
(lambda (a , x) (set 'x a) (println x))
> (foo 8)
8
8
> x
13

but that happened automatically?
I thought contexts (random contexts) could work, because something similar is done in Tcl when you are toying around with unknown, and other interesting functions...just some thoughts.

Lutz:
-----
Variable capture is a potential danger in any dynamiccally soped language but only a potential problem in macros. In normal functions this is not of concern because the LISP evaluation algorithm saves the current variable environment on a stack and restores at function exit. This is what your example shows. Even if you would do (foo 'a) or (foo 'x) your function will still work correctly.

Where variable capture or name clash is a potential problem is in macros:

(define-macro (my-setq x y) (set x (eval y))) ;; bad definition

(my-setq x 123) => 123
x => nil ; x is still nil because of name clash

(my-setq z 123) => 123
z => 123 ; works becuase no name clash

(define-macro (my-setq _x _y) (set _x (eval _y))) ;; better to avoid name clashes

In my own work I never had a problem with variable capture and I have never seen code here on the discussion board affected by this.

If it is of concern in a specific situation, put your macros inside a context, which is lexically isolated or adhere to a naming convention for variables in macros. This is why all packages/modules shipped with newLISP are inside contexts, because nobody should have to look into them and should be able to treat them as black boxes.

Last not least dynamic scoping as also advantages i.e. in Aspect Oriented Programming. Nigel posted and interesting link a while ago to an article by Pascal Constanza "Dynamically Scoped Functions as the Essence of AOP".

Excalibor:
----------

Regarding the macros, imaging I want to write a foreach macro similar to CL for...:

(define-macro (foreach _x _from "from" _to "to" _foo)
  (for (_x '_from '_to)
    (_foo '_x)))

or similar, as this doesn't compile, probably due to the "from" and "to" strings... how does this work in newLISP?

Lutz:
-----

This could be a start for a foreach macro:

(define-macro (foreach _x from _a to  _z _body)
  (for (_x (eval _a) (eval _z)) (eval _body)))

(foreach x from 1 to 10 (println x))

1
2
...
10

Its doesn't check that 'from' really is 'from' etc. but it works. The (eval a) and (eval z) makes sure that you can say:

(foreach i from start to end (println i)

When start is a number etc.


--------------------------------
Invarianti e barre di cioccolato
--------------------------------

Una barretta di cioccolato rettangolare è composta da tanti quadrati della stessa dimensione.
Per esempio la seguente barretta è composta da 7x4=28 quadrati.

   +---+---+---+---+---+---+---+
   |   |   |   |   |   |   |   |
   +---+---+---+---+---+---+---+
   |   |   |   |   |   |   |   |
   +---+---+---+---+---+---+---+
   |   |   |   |   |   |   |   |
   +---+---+---+---+---+---+---+
   |   |   |   |   |   |   |   |
   +---+---+---+---+---+---+---+

Quanti tagli sono necessari per suddividere la barretta in 28 singoli quadrati?

Ogni volta che viene effettuato un taglio, il numero di tagli aumenta di uno e il numero di pezzi aumenta di uno.
Così, il numero di tagli e il numero di pezzi cambiano entrambi. Ciò che non cambia, invece, è la
differenza tra il numero di tagli e il numero di pezzi.
Questo è un "invariante", oppure una "costante", del processo di taglio della tavoletta di cioccolato.
Iniziamo con un pezzo (la tavoletta intera) e zero tagli.
La differenza tra il numero di pezzi e il numero di tagli, all'inizio, vale 1.
Possiamo quindi scrivere: pezzi - tagli = 1 - 0 = 1
Essendo una costante/invariante questo valore rimane sempre uguale indipendentemente dal numero di tagli effettuati.
Quindi per tagliare la tavoletta di cioccolato in tutti i suoi singoli quadrati, il numero di tagli necessari è uno in meno rispetto al numero di quadrati, cioè:

  tagli = pezzi - 1

Nota: pezzi - tagli = (pezzi + 1) - (tagli + 1)


----------------
Short Chess Game
----------------

Problema:
Una partita di scacchi inizia con 1.e4 e termina alla quinta mossa con un cavallo nero che dà scacco matto al re bianco.
Trovare le mosse della partita.

Suggerimento:
Provare il ragionamento inverso: immaginate quali posizioni di matto sono possibili nelle prime mosse.
L'idea è quella di cercare di arrivare alla soluzione partendo anche dalla posizione finale.

Soluzione:
1. e4   Nf6
2. f3   Nxe4
3. Qe2  Ng3
4. Qxe7 Qxe7+
5. Kf2  Nxh1#

Nota: N = kNight (Cavallo), Q = Queen (Regina), K = King (Re)
      B = Bishop (Alfiere), R = Rook (Torre)
      P = Pawn (Pedone) (simbolo non usato nella notazione PGN)


------------------------------
Quantili, quartili, percentili
------------------------------

In statistica i "quantili" sono indici di posizione che dividono le distribuzioni in determinate percentuali.
A seconda delle percentuali in cui la distribuzione viene suddivisa, si classificano diversi tipi di quantili:

- Mediana (quantile di ordine 1/2)
- Quartili (quantili di ordine 1/4, 1/2 e 3/4)
- Decili (quantili di ordine 1/10)
- Centili o percentili (quantili di ordine 1/100)

Quartili
--------
I quartili si ottengono dividendo l'insieme di dati ordinati in 4 parti uguali ed esattamente:

Il primo quartile Q1 è il valore che lascia alla sua sinistra il 25% degli elementi della distribuzione.
Q1 è anche detto 25-esimo percentile P(0.25).

Il secondo quartile Q2 coincide con la mediana dato che è quello che lascia alla sua sinistra il 50% dei dati della distribuzione.
Q2 è anche detto 50-esimo percentile P(0.5).

Il terzo quartile Q3 è il valore che lascia il 75% degli elementi a sinistra e il 25% a destra.
Q3 è anche detto 75-esimo percentile P(0.75).

Decili
------
I decili dividono la distribuzione in 10 parti, ad esempio:

Il primo decile P(0.1) lascia alla sua sinistra un decimo degli elementi della distribuzione, ossia il 10%;
Il terzo decile P(0.3) lascia alla sua sinistra il 30% degli elementi della distribuzione;
Il quinto decile (che coincide con la mediana e con il secondo quartile) lascia alla sua sinistra il 50% della distribuzione.

Percentili
----------
I percentili, invece, dividono la distribuzione in 100 parti, ad esempio:

Il 1° percentile P(0.01) lascia alla sua sinistra un centesimo degli elementi della distribuzione, ossia l'1%.
Il 10° percentile P(0.1) lascia alla sua sinistra il 10% degli elementi della distribuzione.
Il 50° percentile (che coincide con la mediana e con il secondo quartile) lascia alla sua sinistra il 50% della distribuzione.

Regola pratica per il calcolo dei quartili e dei percentili
-----------------------------------------------------------

Per calcolare i quartili (o anche i percentili) di una distribuzione, seguiamo i passi di seguito indicati:

Si ordinano gli n dati della distribuzione in ordine crescente:
Indicato con p il percentile in decimale (p=0.25 per il 25° percentile o 1° quartile, p=0.42 per il 42° percentile), si calcola il prodotto:

  k = n*p;

a) se k è un intero, il quartile (percentile) si ottiene facendo la media del k-esimo e del (k+1)-esimo valore dei dati ordinati.
b) se k non è un intero, si arrotonda k per eccesso al primo intero successivo e si sceglie come quartile (percentile) il corrispondente valore dei dati ordinati

Calcolare il primo, il secondo e il terzo quartile dell'insieme di dati:

(setq a '(32.2 32 30.4 31 31.2 31.3 30.3 29.6 30.5 30.7))

(define (quantile p lst)
  (sort lst)
  (cond ((zero? p) (lst 0)) ; min value
        ((= 1 p) (lst -1))  ; max value
        (true
          (let (k (mul p (length lst)))
            (if (= k (int k))
                (div (add (lst (- k 1)) (lst k)) 2) ; index are 0-based
                ;else
                (lst (int k))))))) ; index are 0-based

(quantile 0.25 a)
;-> 30.4
(quantile 0.5 a)
;-> 30.85
(quantile 0.75 a)
;-> 31.3

(setq b '(
     6.2  7.7  8.3  9.0  9.4  9.8 10.5 10.7 11.0 11.2
    11.8 12.3 12.8 13.2 13.3 13.5 13.9 14.4 14.5 14.7
    15.2 15.5 15.8 15.9 16.2 16.7 16.9 17.0 17.3 17.5
    17.6 17.9 18.0 18.0 18.1 18.1 18.4 18.5 18.7 19.0
    19.1 19.2 19.3 19.4 19.4 20.0 20.1 20.1 20.4 20.5
    20.8 20.9 21.4 21.6 21.9 22.3 22.5 22.7 22.7 22.9
    23.0 23.5 23.7 23.9 24.1 24.3 24.6 24.6 24.8 25.7
    25.9 26.1 26.4 26.6 26.8 27.5 28.5 28.6 29.6 31.8))

(quantile 0.95 b)
;-> 28

Che significato ha il "quantile"?
---------------------------------
Il valore dell'x-esimo quantile divide i dati in (1 - x) maggiori e x minori.
Ad esempio, nell'esempio precedente significa che:
Poichè il 95° quantile vale 28, questo significa che solo il 5% dei valori sono maggiori di 28.

(setq c '(1 5 4 6 7 2 5 6 3 1 2 4 4 7 7))

(quantile 0.25 c)
;-> 2
(quantile 0.75 c)
;-> 6

(setq d '(20 2 7 1 34))

(quantile 0.5 d)
;-> 7
(quantile 0.25 d)
;-> 2
(quantile 0.75 d)
;-> 20
(quantile 0.1 d)
;-> 1

(setq e '(1 1 2 2 2 3 3 3 3 4 5 5 6 6))
(quantile 0.25 e)
;-> 2
(quantile 0.5 e)
;-> 3
(quantile 0.75 e)
;-> 5
(quantile 0 e)
;-> 1 ; valore minimo
(quantile 1 e)
;-> 6 ; valore massimo

Nota: alcuni software (R, Gnumeric, Octave...) possono calcolare i quantili in modo leggermente diverso interpolando i valori.
Non esiste un modo univoco universalmente riconosciuto per il calcolo dei quantili.


-----------------------------------
Box-plot e valori anomali (outlier)
-----------------------------------

In statistica il diagramma box-plot è una rappresentazione grafica utilizzata per descrivere la località, la diffusione e l'asimmetria dei dati numerici attraverso i loro quartili.

          Q1   Q2   Q3
     min   +----+----+   max
      +----|    |    |----+
           +----+----+

------|----|----|----|----|-------> X
     x0   x1   x2   x3   x4

Box-plot stilizzato

      +----|----|----|----+
     x0   x1   x2   x3   x4

Scriviamo una funzione che visualizza il box-plot di una serie di dati.
L'implementazione è molto spartana.

Funzione che calcola i quantili:

(define (quantile p lst)
  (sort lst)
  (cond ((zero? p) (lst 0)) ; min value
        ((= 1 p) (lst -1))  ; max value
        (true
          (let (k (mul p (length lst)))
            (if (= k (int k))
                (div (add (lst (- k 1)) (lst k)) 2) ; index are 0-based
                ;else
                (lst (int k))))))) ; index are 0-based

(define (normalize lst-num val-min val-max)
"Normalize a list of numbers in the range (a,b)"
  (local (hi lo k out)
    (setq out '())
    (setq hi (apply max lst-num))
    (setq lo (apply min lst-num))
    ; if val-max == nil then val-max = hi
    (setq val-max (or val-max hi))
    ; if val-min == nil then val-min = 0
    (setq val-min (or val-min 0))
    (setq k (div (sub val-max val-min) (sub hi lo)))
    (dolist (val lst-num)
      (push (add val-min (mul (sub val lo) k)) out -1))
    out))

Funzione che stampa un box-plot di una lista di numeri:

(define (box-plot lst delta)
  (local (vmin vmax q1 q2 q3 lst-norm
          punti punti-norm line-box line-values segni idx v)
    (setq segni '("+" "|" "|" "|" "+"))
    (sort lst)
    ; calcolo quantili, minimo e massimo
    (setq vmin (lst 0))
    (setq vmax (lst -1))
    (setq q1 (quantile 0.25 lst))
    (setq q2 (quantile 0.50 lst))
    (setq q3 (quantile 0.75 lst))
    (setq punti (list vmin q1 q2 q3 vmax))
    ; normalizzazione dei dati
    (setq lst-norm (normalize lst 0 delta))
    ; normalizzazione dei punti
    (setq punti-norm (normalize punti 0 delta))
    ; crea la linea del box-plot
    (setq line-box (dup "-" (add delta 1)))
    ; crea la linea dei valori del box-plot
    (setq line-values (dup " " (add delta 1)))
    ; ciclo per inserire i simboli e i valori nelle due linee
    (dolist (p punti-norm)
      (setq idx (int (add 0.5 p)))
      (setf (line-box idx) (segni $idx))
      (setq v (format "%.2f" (punti $idx)))
      (push v line-values idx)
    )
    ; stampa il box-plot
    (println " " line-box)
    (println " " line-values)
    ; IQR = differenza tra Q3 e Q1
    (println "IQR = " (sub (punti 3) (punti 1)))))

Facciamo alcune prove:

(setq a '(2 4 3 6 8 6 9 11 3 5 9 15 14 7))
(box-plot a 60)
;->  +--------|-----------|----------|---------------------------+
;->  2.00     4.00        6.50       9.00                        15.00
;-> IQR = 5

(setq b (random 1 -100 100))
(box-plot b 60)
;->  +---------------|------------|---------------|--------------+
;->  -98.97          -72.94       -49.92          -24.08         0.87
;-> IQR = 48.86013367107151

(setq c (random 1 -100 100))
(box-plot c 60)
;->  +--------------|---------------|----------------|-----------+
;->  -98.46         -73.12          -47.81           -18.99      0.84
;-> IQR = 54.12610248115482

Identificare i valori anomali (outlier)
---------------------------------------
L'intervallo interquartile (IQR= Q3 - Q1) può essere utilizzato per identificare i valori anomali. I valori anomali sono osservazioni estremamente alte o basse. Una definizione di valore anomalo è qualsiasi osservazione che dista più di 1.5*IQR dal primo o dal terzo quartile.

(define (outlier lst)
  (local (iqr q1 q3 soglia1 soglia3 out)
    (setq out nil)
    (sort lst)
    ; calcolo quantili Q1 e Q3
    (setq q1 (quantile 0.25 lst))
    (setq q3 (quantile 0.75 lst))
    (setq iqr (sub q3 q1))
    (setq soglia1 (sub q1 (mul 1.5 iqr)))
    (setq soglia3 (add q3 (mul 1.5 iqr)))
    (println q1 { } q3 { } iqr { } soglia1 { } soglia3)
    (dolist (el lst)
      (if (< el soglia1) (push (list el (sub soglia1 el)) out -1))
      (if (> el soglia3) (push (list el (sub el soglia3)) out -1))
    )
    out))

(setq d '(2 4 3 6 8 6 9 11 3 5 9 15 14 7))
(outlier d)
;-> 4 9 5 -3.5 16.5
;-> nil

(setq d '(2 4 3 6 8 44 6 9 11 3 5 9 15 14 7 31 77))
(outlier d)
;-> 5 14 9 -8.5 27.5
;-> ((31 3.5) (44 16.5) (77 49.5))


-----------------------------------------------------------
Selezionare colonne in una matrice (lista a due dimensioni)
-----------------------------------------------------------

Data una matrice (lista a due dimensioni) scriviamo una funzione per selezionare una colonna.

(setq a '((1 2 3) (4 5 6) (7 8 9)))

(define (select-column1 lst col)
  (let (l '())
    (dolist (i lst)
       (push (i col) l -1))
   l))

(select-column1 a 1)
;-> (2 5 8)

(define (select-column2 lst col)
   (map (fn (row) (row col)) lst) )

(select-column2 a 1)
;-> (2 5 8)

Le precedenti funzioni estraggono una colonna come riga.
La prossima funzione permette di scegliere se selezionare i dati come colonna o come riga:

(define (select-column3 lst col row)
  (if row
      ((transpose lst) col)
      (transpose (list ((transpose lst) col)))))

Seleziona come colonna:
(select-column3 a 1)
;-> ((2) (5) (8))

Seleziona come riga:
(select-column3 a 1 true)
;-> (2 5 8)

-----------------------------
Forum: kazimir majorinc wrote
-----------------------------

Example for functions identical to their definitions:
-----------------------------------------------
Once I wanted to "infect" SOME functions with extra
code during runtime, and later to clean that extra
code from functions. Wraping around function was not
enough, code had to be inserted in function definitions.

It had to be done WITHOUT knowledge and cooperation of
infected function, these had to be ordinary,
user defined functions, not purposely prepared to be infected.

It turned to be easy in Newlisp, because functions are
just lambda-expressions, they can be processed like
any list.

Example for unrestricted eval:
-----------------------------

What macros actually do? They behave *like*
functions that produce code and - evaluate that
code in the caller environment once again.

Sure, macros have other specificities, they
are not functions, they are not evaluated but
expanded, etc, but those two things interest me
now: code generation and evaluation in the caller
environment.

Now, what if one wants code transformation, but
macros are not suitable (1) because they are
not the first class, (2) code transformation
is not known in macro expansion time, or especially
interesting (3) because they are just too big
to be used for every small code transformation
one can imagine? People do not define functions
for every expression they evaluate, why should
they define macros for every code transformation
they do?!

OK, in that case, code transformations can be done
without macros, using normal Lisp expressions,
possibly functions - but resulting code has to
be EVALUATED ONCE MORE in the caller environment,
explicitly. And Newlisp has exactly such eval,
eval able to access to local variables.

More specifically, lets say one need macro m
which has to be determined during runtime.
In CL, such macro cannot be defined (without
eval). But it can be replaced with function f
that does exactly the same code transformation.
So, instead of impossible

(m expr1 ... exprn)

it is possible to write

(eval (f 'expr1 ... 'exprn))

Functional version works, because functions
are the first class citizens. Macro version
doesn't. But, eval able to access to local
variables needs to be inserted.

If one takes a look on Newlisp code, it is
full of evals. Some of these evals could
be replaced with macros - but many of those
would be ultrasmall "define once - use once"
macros, it is just more trouble defining
macros than applying eval directly on the
result of some expression. Some evals couldn't
be replaced with macros at all.

Example for dynamic scope:
--------------------------
Define IF as function.

(set 'IF (lambda()
            (eval
              ((args)
                (find (true? (eval (first (args))))
                      '(* true nil))))))

(let ((x 2)(y 3))
      (IF '(< x y)
          '(println  x " is less than " y)
          '(println  x " is not less than " y))

      (IF '(> x y)
          '(println x " is greater than " y)
          '(println x " is not greater than " y)))

It works in Newlisp.

This particular definition of IF is complicated,
because I did it as game - IF is not only function,
but it is defined without built in operators
like IF and COND, and also, without using any variable.

Many other - less extravagant definitions are possible.

More generally, whenever one can define macro,
he can define equivalent function as well.

Example for first-class macros
--------------------------------------------
Experienced Lisper probably noted that he sometimes
write macros only because it is impossible to write
equivalent function. Also, that he sometimes write
functions although macros would be syntactically better,
but he needs the first class citizens.

In Newlisp, macros are fexprs, whenever one can write
the function, he can write macro that does the same
and vice versa. Both have the advantages and
disadvantages resulting from its syntax and semantics.
Because of that, it is possible to define two functions:

function-to-macro
macro-to-function

For example, after

(set 'for-function (macro-to-function for))
(set 'append-macro (function-to-macro append))

are evaluated the expressions

(for-function '(i 1 10) '(println i))
(append-macro (1 2 3) (4 5 6))

are valid and behave just like one might expect.

----------------------------------------
Forum: fnparse to get all used functions
----------------------------------------

HPW:
----
Would it be possible to get a command fnparse?

  (fnparse "Lsp_Source_String")

which would use the internal newlisp-parser to generate a list of all function-names (without duplicates) used in "Lsp_Source_String" without any evaluating.

Would return something like this:

  ("set" "define" .... .... "MyFn" "foo")

Background: To be able to check a Lsp-source before loading, that it does not contain malicious, bad Lisp-code. So a app can store a Lisp-Data-Table and can have a Load-Routine which is not a security hole for bad code. Using the internal parser should provide the speed.
Any ideas?

Sammo:
------
Would something like this work?

(define (fnparse SOURCE)
  (letn
    ( (LP    "(")     ;) left paren
      (SP    " ")     ;  space
      (LPSP  "( ")    ;) left paren and space
      (NULL  "")      ;  null string
      (keep  (lambda (L K) (dolist (x L) (if (= (x 0) LP) (push x K))) K))
      (s     (parse (replace LPSP (join (parse SOURCE) SP) LP) SP))
    )
  ;body of letn
    (unique (map (fn (x) (replace LP x NULL)) (keep s))) ))

(define (bob one two) (+ one two))
;-> (lambda (one two) (+ one two))

(source 'bob)
;-> "(define (bob one two)\r\n (+ one two))\r\n\r\n"

(fnparse (source 'bob))
;-> ("+" "bob" "define")


--------------------------
LISP syntax and evaluation
--------------------------

Lutz:
-----
LISP syntax and evaluation relies on one simple rule: that the first element in a list is an operator or function applied to the rest of the elements in the list, which constitute the arguments: (func arg1 arg2 ...). Anything changing this would only complicate the syntax and workings of LISP and create ambiguities when reading the language.

The term '(a b c) already constitutes a list. Writing (list a b c) is only necessary when you want the contents of the variables a, b and c be the elements of the list. I.e. if 'a is 1 and 'b is 2 and 'c is 3, then writing: (list a b c) is the same as writing (1 2 3).

There is probably no syntax more minimalistic and flexible than the LISP syntax, which is a mayor attraction to use LISP as a programming language and data modelling language at the same time ;)


--------------------------------------------------
Gestione degli elementi (nome valore) in una lista
--------------------------------------------------

Supponiamo di avere una lista i cui elementi sono coppie (nome valore).

Per esempio:

(setq a '((nome "Jack") (peso "67") (altezza "170")))

Estraiamo un valore (tag):

(setq the-name (assoc 'nome a))
;-> (nome "Jack")

the-name
;-> (nome "Jack")

Possiamo definire una funzione (per ogni valore/tag):

(define (nome s) (append "the name is: " s))

Poi valutiamo la struttura della lista:

(eval the-name)
;-> "the name is: Jack"

Nota: Questa tecnica può essere utilizzata anche per generare XML/HTML dalla struttura di una lista.


-------------------------------------
Controllo parentesi nei file sorgenti
-------------------------------------

Il seguente programma verifica la correttezza delle parentesi in un file sorgente newLISP.
Salvare il programma in un file (es. check.lsp).
Dal terminale:

  newlisp check.lsp source.lsp

#!/usr/bin/newlisp
#
# Simple program to check parantheses -version 1.0
#
# Shows the location of unanswered brackets
#
# March - Nov. 2005 by PvE.
# Revised for newLisp 10 at december 28, 2008 - PvE.
#
#------------------------------------------------------

# Open the file
(set 'file (open (last (main-args)) "read"))
(when (not file)
    (println "File not found!")
    (exit))

(set 'line 0)

# Avoid unexpected pop's
(set 'bpos (list))
(set 'epos (list))

(println {Checking file "} (last (main-args)) {" for unanswered opening brackets...})

# Read a line from the file
(while (read-line file)
    (set 'cur-line (current-line))
    # Replace standalone brackets mentioned as a string
    (replace {"("} cur-line "")
    (replace {")"} cur-line "")
    # Save program lines in list
    (push cur-line program)
    # Increment line number
    (inc line)
    # Count open brackets
    (set 'bopen (first (count '("(") (parse cur-line))))
    # Count close brackets
    (set 'bclose (first (count '(")") (parse cur-line))))
    # Now see if open brackets need to be remembered
    (while (> bopen bclose) (dec bopen) (push line opos))
    # Unremember when closing brackets have been found
    (while (> bclose bopen) (dec bclose) (pop opos)))

(println {Checking file "} (last (main-args)) {" for unanswered closing brackets...})
# Reading a line backwards from the file
(while (> line 0)
    (set 'cur-line (pop program))
    # Count open brackets
    (set 'bopen (first (count '("(") (parse cur-line))))
    # Count close brackets
    (set 'bclose (first (count '(")") (parse cur-line))))
    # Now see if closing brackets need to be remembered
    (while (> bclose bopen) (dec bclose) (push line epos))
    # Unremember when opening brackets have been found
    (while (> bopen bclose) (dec bopen) (pop epos))
    # Decrement line number
    (dec line))

# Close filehandle
(close file)

# Print what is left
(if (> (length opos) 0)
    (println (append "Unanswered opening bracket(s) at: " (string (reverse opos))))
    (println "No unanswered opening brackets found!"))

(if (> (length epos) 0)
    (println (append "Unanswered closing bracket(s) at: " (string (reverse epos))))
    (println "No unanswered closing brackets found!"))

# Exit newlisp
(exit)

c:\newlisp\> newlisp check.lsp ABC.lsp
;-> Checking file "ABC.lsp" for unanswered opening brackets...
;-> Checking file "ABC.lsp" for unanswered closing brackets...
;-> Unanswered opening bracket(s) at: (9 17)
;-> No unanswered closing brackets found!)


-------------------------------
Statistica: Skewness e Kurtosis
-------------------------------

Nota: per una rappresentazione grafica del significato di "skewness" e "kurtosis" vedere il file "skew-kurt.png" nella cartella "data".

Skewness
--------
Una distribuzione di valori (una distribuzione di frequenza) si dice "skewed" (distorta) se non è simmetrica.

Asimmetria positiva
La curva di distribuzione sale ripida a sinistra fino al suo apice e poi scende gradualmente a destra.

Asimmetria negativa
La curva di distribuzione sale gradualmente a sinistra fino al suo apice per poi diminuire bruscamente a destra.

Distorsione debole: -0.5 <= skew <= 0.5)
Distorsione moderata: 0.5 <= skew <= 1 oppure -0.5 <= skew <= -1
Distorsione forte: skew < -1 oppure skew > 1

Il valore di skewness (asimmetria) viene calcolato trovando il terzo momento rispetto alla media e dividendo per il cubo della deviazione standard.

          ∑[(x(i) - media)³]
  skew = --------------------
              N*devstd³

Tipo di deviazione standard (devstd):
type = 1 --> stdev (N)
type = 2 --> stdev2 (N-1)

Vediamo le funzioni statistiche che ci servono:

(define (media lst)
  (div (apply add lst) (length lst)))

(define (mediana lst)
  (let (len (length lst))
    (sort lst)
    (if (odd? len)
        (lst (/ len 2))
        (div (add (lst (- (/ len 2) 1)) (lst (/ len 2))) 2))))

(define (moda lst)
  (letn ((uniq (unique lst))
        (conta (count uniq lst)))
    (uniq (find (apply max conta) conta))))

(define (stdev lst) ; diviso N
  (let (m (media lst))
    (sqrt (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
               (length lst)))))

(define (stdev2 lst) ; diviso (N - 1)
  (let (m (media lst))
    (sqrt (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
               (- (length lst) 1)))))

(define (varianza lst) ; popolazione -> diviso N
  (let (m (media lst))
    (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
         (length lst))))

(define (varianza2 lst) ; campione -> diviso (N - 1)
  (let (m (media lst))
    (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
         (- (length lst) 1))))

(define (quantile p lst)
  (sort lst)
  (cond ((zero? p) (lst 0)) ; min value
        ((= 1 p) (lst -1))  ; max value
        (true
          (let (k (mul p (length lst)))
            (if (= k (int k))
                (div (add (lst (- k 1)) (lst k)) 2)
                ;else
                (lst (int k)))))))

Funzione che calcola la "skewness" di una lista di valori:

(define (skew lst type)
  (local (m sd)
    (setq type (or type 1))
    (setq m (media lst))
    (if (= type 1)
      (setq sd (stdev lst))
      (setq sd (stdev2 lst))
    )
    (div (apply add (map (fn(x) (mul (sub x m) (sub x m) (sub x m))) lst))
         (mul (length lst) sd sd sd))))

Facciamo alcune prove:

(setq dat
  '(-0.533 0.270 0.859 -0.043 -0.205 -0.127 -0.071 0.275 1.251 -0.231
    -0.401 0.269 0.491 0.951 1.150 0.001 -0.382 0.161 0.915 2.080 -2.337
    0.034 -0.126 0.014 0.709 0.129 -1.093 -0.483 -1.193 0.020 -0.051
    0.047 -0.095 0.695 0.340 -0.182 0.287 0.213 -0.423 -0.021 -0.134 1.798
    0.021 -1.099 -0.361 1.636 -1.134 1.315 0.201 0.034 0.097 -0.170 0.054
    -0.553 -0.024 -0.181 -0.700 -0.361 -0.789 0.279 -0.174 -0.009 -0.323
    -0.658 0.348 -0.528 0.881 0.021 -0.853 0.157 0.648 1.774 -1.043 0.051
    0.021 0.247 -0.310 0.171 0.000 0.106 0.024 -0.386 0.962 0.765 -0.125
    -0.289 0.521 0.017 0.281 -0.749 -0.149 -2.436 -0.909 0.394 -0.113 -0.598
    0.443 -0.521 -0.799 0.087))

Funzione "stats" di newLISP:

  Name   Description
  ----   -----------
  N      Number of values
  mean   Mean of values
  avdev  Average deviation from mean value
  sdev   Standard deviation (population estimate)
  var    Variance (population estimate)
  skew   Skew of distribution
  kurt   Kurtosis of distribution

(println (format [text]
  N        = %5d
  mean     = %8.6f
  avdev    = %8.6f
  sdev     = %8.6f
  var      = %8.6f
  skew     = %8.6f
  kurt     = %8.6f
[/text] (stats dat)))
;-> N        =   100
;-> mean     = 0.000400
;-> avdev    = 0.489892
;-> sdev     = 0.718875
;-> var      = 0.516781
;-> skew     = -0.070368
;-> kurt     = 2.034227

Nota: la funzione "stats" calcola la deviazione standard come "stdev2" e la varianza come "varianza2".

(media dat)
;-> 0.0003999999999999896
(mediana dat)
;-> 0.0075
(moda dat)
;-> 0.021
(stdev dat)
;-> 0.7152712073053128
(stdev2 dat)
;-> 0.7188746115079505
(varianza dat)
;-> 0.5116128999999997
(varianza2 dat)
;-> 0.5167807070707068
(skew dat 1)
;-> -0.07143695867549046
(skew dat 2)
;-> -0.07036808766294561

Kurtosis
--------
La "kurtosis" (curtosi) si riferisce al picco di una distribuzione. Ad esempio, una distribuzione di valori potrebbe essere perfettamente simmetrica, ma apparire molto "con picco" o molto "piatta".

Picco di curtosi "leptokurtic" (kurt > 3)
La curva sale alta ed è acuta al suo apice.

Curtosi piatta "platykurtic"  (kurt > 3)
La curva non sale tanto in alto ed è più piatta attorno al suo apice.

Una distribuzione normale, che di solito viene utilizzata come standard di riferimento, ha una curtosi di 3.

Il valore di "kurtosis" viene calcolato trovando il quarto momento sulla media e dividendo per il quadruplo della deviazione standard:

          ∑[(x(i) - media)^4]
  kurt = ---------------------
              N*devstd^4

Tipo di deviazione standard (devstd):
type = 1 --> stdev (N)
type = 2 --> stdev2 (N-1)

(define (kurt lst type)
  (local (m sd)
    (setq type (or type 1))
    (setq m (media lst))
    (if (= type 1)
      (setq sd (stdev lst))
      (setq sd (stdev2 lst))
    )
    (div (apply add (map (fn(x) (mul (sub x m) (sub x m) (sub x m) (sub x m))) lst))
         (mul (length lst) sd sd sd sd))))

(kurt dat 1)
;-> 5.136442008015037
(kurt dat 2)
;-> 5.03422681205554

Nota: Il valore di "kurt" della funzione "stats" è normalizzato, cioè al valore calcolato con la nostra funzione "kurt" viene sottratto 3 che è il valore di kurtosis della distribuzione normale.
(sub 5.03422681205554 3)
;-> 2.03422681205554

Valori anomali (outliers)
-------------------------
Il valore di kurtosis indica il grado di presenza di valori anomali nella distribuzione.
La kurtosis è una misura della forma della coda di una distribuzione.
Le code sono le estremità affusolate su entrambi i lati di una distribuzione. Rappresentano la probabilità o la frequenza di valori estremamente alti o bassi rispetto alla media. In altre parole, le code rappresentano la frequenza con cui si verificano valori anomali.
Le distribuzioni con kurtosis media (code medie) sono mesocurtiche.
Le distribuzioni con bassa kurtosis (code sottili) sono platicurtiche.
Le distribuzioni con alta kurtosis (code spesse) sono leptocurtiche.


---------------------------
Dadi e funzioni generatrici
---------------------------

Lanciamo due dadi equi a 6 facce (da 1 a 6).
Qual è la probabilità di ottenere 5?
Qual è la probabilità di ottenere 10?

Ci sono 6^2 = 36 casi possibili che possiamo elencare con una tabella:

     | 1  2  3  4  5  6
  ---+------------------
   1 | 2  3  4  5  6  7
   2 | 3  4  5  6  7  8
   3 | 4  5  6  7  8  9
   4 | 5  6  7  8  9 10
   5 | 6  7  8  9 10 11
   6 | 7  8  9 10 11 12

La probabilità di ottenere 5 vale 4/36 = 1/9
La probabilità di ottenere 10 vale 3/36 = 1/12

Scriviamo una funzione che crea questa tabella per due dadi con f1 e f2 facce:

(define (make-table f1 f2)
  (local (table)
    (setq table (array f1 f2 '(0)))
    (for (r 0 (- f1 1))
      (for (c 0 (- f2 1))
        (setf (table r c) (+ (+ r 1) (+ c 1)))
      )
    )
    (array-list table)))

(print-matrix (make-table 6 6))
;-> 2  3  4  5  6  7
;-> 3  4  5  6  7  8
;-> 4  5  6  7  8  9
;-> 5  6  7  8  9 10
;-> 6  7  8  9 10 11
;-> 7  8  9 10 11 12

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

Scriviamo una funzione che calcola la probabilità che esca un numero predefinito lanciando due dadi con f1 e f2 facce:

(define (prob num f1 f2)
  (local (out)
    (setq a (length (ref-all num (flat (make-table f1 f2)) = true)))
    (list a (* f1 f2))))

Facciamo alcune prove:

(prob 5 6 6)
;-> (4 36)
(prob 10 6 6)
;-> (3 36)
(prob 1 6 6)
;-> (0 36)

(print-matrix (make-table 4 6))
;-> 2  3  4  5  6  7
;-> 3  4  5  6  7  8
;-> 4  5  6  7  8  9
;-> 5  6  7  8  9 10

(prob 2 4 6)
;-> (1 24)
(prob 6 4 6)
;-> (4 24)
(prob 8 4 6)
;-> (3 24)

Questo metodo presenta diverse difficoltà se vogliamo lanciare più di due dadi.

Funzioni generatrici
--------------------
Un dado con N facce può essere rappresentato da un polinomio nel modo seguente:

  f(x) = p(1)*x + p(2)*x^2 + ... + p(n)*x^n

  dove p(i) è la probabilità della faccia i

Un dado a 6 facce viene rappresentato come:

  f(x) = (1/6)*x + (1/6)*x^2 + (1/6)*x^3 + (1/6)*x^4 + (1/6)*x^5 + (1/6)*x^6

Un dado a 4 facce viene rappresentato come:

  g(x) = (1/4)*x + (1/4)*x^2 + (1/4)*x^3 + (1/4)*x^4

Calcoliamo il prodotto delle due funzioni f(x) e g(x):

  q(x) = f(x)*g(x) =

  = (1/24)*x^2 + (1/12)*x^3 + (1/8)*x^4 + (1/6)*x^5 + (1/6)*x^6 +
    (1/6)*x^7 + (1/8)*x^8 + (1/12)*x^9 + (1/24)*x^10

Come si interpreta un termine, p(i)*x^i, del polinomio q(x)?
p(i) è la probabilità che esca il numero i dal lancio dei due dadi.
Ad esempio, la probabilità che esca il numero 3 vale 1/12.

Verifichiamo i valori:

(define (mul-poly p1 p2)
"Multiplication between two polynomials"
  (local (res l1 l2)
    (setq l1 (length p1))
    (setq l2 (length p2))
    (setq res (dup 0 (+ l1 l2 (- 1))))
    (for (i 0 (- l1 1))
      (for (j 0 (- l2 1))
        (setf (res (+ i j)) (add (res (+ i j)) (mul (p1 i) (p2 j))))
      )
    )
    res))

(mul-poly '(0 0.1666666666666667 0.1666666666666667 0.1666666666666667
              0.1666666666666667 0.1666666666666667 0.1666666666666667)
          '( 0 0.25 0.25 0.25 0.25))
;-> (0 0 0.04166666666666668 0.08333333333333336 0.125 0.1666666666666667 0.1666666666666667
;->  0.1666666666666667 0.125 0.08333333333333336 0.04166666666666668)

(div 1 24)
;-> 0.04166666666666668
(div 1 12)
;-> 0.08333333333333336
(div 1 8)
;-> 0.125
(div 1 6)
;-> 0.1666666666666667

Questo metodo permette di calcolare la probabilità di uscita di un numero con il lancio di N dadi moltiplicando tutti i relativi polinomi e valutando il polinomio risultante.

Dadi non equi
-------------
Un dado non equo ha numeri con probabilità diverse.
Questo avviene nei dadi truccati o in dadi con numerazione non standard (ad esempio un dado con 6 facce in cui i numeri sono 1,1,1,2,3,4).
Il metodo delle funzioni generatrici è in grado di trattare anche questo caso.
Basta associare la corretta probabilità ad ogni numero.
Ad esempio, con un dado a 6 facce numerato 1,1,1,2,3,4 abbiamo le seguenti probabilità per i numeri:

  1  --> prob = 1/2
  2  --> prob = 1/6
  3  --> prob = 1/6
  4  --> prob = 1/6

e il polinomio vale: f(x) = (1/2)*x + (1/6)*x^2 + (1/6)*x^3 + (1/6)*x^4

Facciamo un esempio:

Dado 1                 Dado 2
Faccia  Prob           Faccia  Prob
 1      1/4             1      1/3
 2      1/3             2      1/2
 3      1/5             3      1/8
 4      1/12            4      1/24
 5      1/30
 6      1/10

(add (div 1 3) (div 1 2) (div 1 8) (div 1 24))
;-> 0.9999999999999999
(add (div 1 4) (div 1 3) (div 1 5) (div 1 12) (div 1 30) (div 1 10))
;-> 0.9999999999999999

  f2(x) = (1/3)*x + (1/2)*x^2 + (1/8)*x^3 + (1/24)*x^4
  f1(x) = (1/4)*x + (1/3)*x^2 + (1/5)*x^3 + (1/12)*x^4 + (1/30)*x^5 + (1/10)*x^6

  q(x) = f1(x) * f2(x) =
       = (1/12)x^2 + (17/72)x^3 + (127/480)x^4 + (259/1440)x^5 + (11/120)x^6 +
         (11/160)x^7 + (83/1440)x^8 + (1/72)x^9 + (1/240)x^10

  Numero         Probabilità di uscita
     2    -->    (div 1 12)     =  0.08333333333333333
     3    -->    (div 17 72)    =  0.2361111111111111
     4    -->    (div 127 480)  =  0.2645833333333333
     5    -->    (div 259 1440) =  0.1798611111111111
     6    -->    (div 11 120)   =  0.09166666666666666
     7    -->    (div 11 160)   =  0.06875000000000001
     8    -->    (div 83 1440)  =  0.05763888888888889
     9    -->    (div 1 72)     =  0.01388888888888889
    10    -->    (div 1 240)    =  0.004166666666666667

Verifichiamo questo risultato con la funzione "mul-poly":

(setq d1 (list (div 1 3) (div 1 2) (div 1 8) (div 1 24)))
;-> (0.3333333333333333 0.5 0.125 0.04166666666666666)
(setq d2 (list (div 1 4) (div 1 3) (div 1 5) (div 1 12) (div 1 30) (div 1 10)))
;-> (0.25 0.3333333333333333 0.2 0.08333333333333333 0.03333333333333333 0.1)

(mul-poly d1 d2)
;-> (0.08333333333333333 0.2361111111111111 0.2645833333333333
;->  0.1798611111111111 0.09166666666666667 0.06875000000000001
;->  0.05763888888888889 0.01388888888888889 0.004166666666666667)

Adesso scriviamo una funzione che simula il lancio di N dadi con probabilità assegnate.

Funzione che genera un numero (0...length(lista) - 1) con le probabilità di lista.
Data una lista con dei valori di probabilità associati ai rispettivi indici, la funzione estrae casualmente un indice della lista seguendo le probabilità assegnate.

(define (rand-pick lst)
  (local (rnd stop out)
    ; generiamo un numero random diverso da 1
    ; (per evitare errori di arrotondamento)
    (while (= (setq rnd (random)) 1))
    ;(if (= rnd 1) (println rnd))
    (setq stop nil)
    (dolist (p lst stop)
      ; sottraiamo la probabilità corrente al numero random...
      (setq rnd (sub rnd p))
      ; se il risultato è minore di zero,
      ; allora restituiamo l'indice della probabilità corrente
      (if (< rnd 0)
          (set 'out $idx 'stop true)
      )
    )
    out))

Facciamo un esempio:

(setq p '(0.05 0.15 0.35 0.45))
(apply add p)
;-> 1
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick p))))
vet
;-> (50146 149694 350013 450147)
(apply + vet)
;-> 1000000

Funzione che effettua il lancio di N dadi con probabilità dei dadi assegnate:

(define (lancio lst)
  (let (somma 0)
    (dolist (el lst)
      (setq somma (+ somma (rand-pick el)))
    )
    somma))

(setq d1 (list 0 (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6)))
(setq d2 (list 0 (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6)))

(lancio (list d1 d2))
;-> 4

Proviamo la funzione per verificare il risultato precedente:

(setq d1 (list (div 1 3) (div 1 2) (div 1 8) (div 1 24)))
;-> (0.3333333333333333 0.5 0.125 0.04166666666666666)
(setq d2 (list (div 1 4) (div 1 3) (div 1 5) (div 1 12) (div 1 30) (div 1 10)))
;-> (0.25 0.3333333333333333 0.2 0.08333333333333333 0.03

(setq vet (array 10 '(0)))
(for (i 0 999999) (++ (vet (lancio (list d1 d2)))))
(map (fn(x) (div x 1e6)) vet)
;-> (0.083562 0.236468 0.264033 0.179512 0.091124
;->  0.06916600000000001 0.057875 0.013993 0.004267 0)

Quindi abbiamo:

  Numero   Probabilità teorica    Probabilità simulata
     2     0.08333333333333333    0.083562
     3     0.2361111111111111     0.236468
     4     0.2645833333333333     0.264033
     5     0.1798611111111111     0.179512
     6     0.09166666666666666    0.091124
     7     0.06875000000000001    0.069166
     8     0.05763888888888889    0.057875
     9     0.01388888888888889    0.013993
    10     0.004166666666666667   0.004267

I risultati teorici e quelli della simulazione sono congruenti.


--------------------------------------------
Forum: Tiny Lisp course - Lisp in 10 bullets
--------------------------------------------

Vishnu Vyas:
------------

1. In Lisp everything thats written is called a s-expression, which are basically of 2 types. Atoms and Forms.

2. Atoms are stuff like numbers (10, 234.56, etc..), characters , strings, boolean literals like T (true) and NIL (false) and variable names (called symbols in Lisp, which are associated with other values).

3. Forms, the 2nd type of s-expressions are always enclosed within paranthesis.

4. Lisp works by evaluating the s-expression and printing the output, which is the value of the s-expression. Each s-expression's value depends on what it is (atom/form) and what type of an atom or a form it is. The process of finding the value of an s-expression is called evaluation.

5. Literals (atoms like 12, #\a , "Hey", etc.. basically numbers, chars and strings) evaluate to themselves, i.e 10 evaluates to the number 10. Atoms like symbols evaluate to the value that they are associated to.

6. Forms are of two types - Functional application and Special forms. And they are always enclosed within paranthesis (this is just rule 3 again, but to drive home the point!)

7. Special forms are written as (special-form-name arg1 arg2 arg3 arg4 ... argN) and special forms dictates how and when (even wether) each of arg1 to argN is evaluated. Functional Application is simpler, even though written in the same manner as (function-name arg1 arg2... argN), it works by evaluating all the values from arg1 to argN first and then passing them to the function 'function-name'.

8. Functions in lisp are a bit different and there is a 2 step process to work with them. First the action of creating a function which is done using the lambda special form and then process of associating the function with a name. (i.e, its upto you to assign functions a name, you can leave it if you don't need it).

9. Lisp has a data structure called the list, whose written literal representation is indistinguishable from that of forms. Its enclosed within paranthesis and its elements seperated by whitespaces. So basically you can see any lisp program as a bunch of atoms (which are data anyway) and lists. This means that lisp code and lisp data are indistinguishable.

10. Since code is indistinguishable from data, you can write programs to change/generate code because its basically working by modifying lists. Since Lisp provides you with an eval function you can evaluate your generated code at runtime, and Lispniks call this feature 'Macros'.

Update 1: As far as point 10 goes, thats not what Lispniks call macros, Macros are simply programs which change/generate code, but this happens during compile time. (however the point is still valid, you can evaluate your code at runtime using eval.)

Update 2: Just a quibble with point 2. Symbols are not just variable names, and calling them such loses some of what makes lisp so unique and strange. It would be more accurate to say that symbols are just that, symbols, which can be bound to values.


-----------------
Funzione "filter"
-----------------

*******************
>>>funzione FILTER
*******************
sintassi: (filter exp-predicate exp-list)

Il predicato "exp-predicate" viene applicato a ogni elemento della lista "exp-list". Viene restituito una lista contenente gli elementi per i quali "exp-predicate" è vero (true). "filter" funziona come "clean", ma con un predicato negato.

(filter symbol? '(1 2 d 4 f g 5 h))  → (d f g h)

(define (big? x) (> x 5))  → (lambda (x) (> x 5))

(filter big? '(1 10 3 6 4 5 11))  → (10 6 11)

; filter with comparison functor

(set 'L '((a 10 2 7) (b 5) (a 8 3) (c 8) (a 9)))

(filter (curry match '(a *)) L)   → ((a 10 2 7) (a 8 3) (a 9))

(filter (curry match '(? ?)) L)   → ((b 5) (c 8) (a 9))

(filter (curry match '(* 8 *)) L) → ((a 8 3) (c 8))

Il predicato può essere un predicato predefinito, una funzione definita dall'utente o un'espressione lambda.

Per filtrare una lista di elementi con gli elementi di un'altra lista, utilizzare la funzione "difference" o "intersect" (con l'opzione list).

Vedere anche la funzione correlata "index", che restituisce gli indici degli elementi filtrati e "clean", che restituisce tutti gli elementi di una lista per i quali un predicato è falso.

Vediamo alcune funzioni che simulano la primitiva "filter":

Sammo
-----
;;  recursive version
;;
(define (myfilter pred? items)
  (reverse (myfilter-aux pred? items '())) )

(define (myfilter-aux pred? items result)
  (if (empty? items)
    result
    (myfilter-aux
          pred?
          (rest items)
          (if (pred? (first items)) (cons (first items) result) result ))))

(myfilter float? '(1 2.1 3.00001 4.1 5 6 7 3.2 8))
;-> (2.1 3.00001 4.1 3.2)

;;  map version
;;
(define (myfilter pred? items)
  (let
    ( keep '()
      keep-if-true (fn (p item) (if p (push item keep -1)))
    )
  ;body of let
    (map keep-if-true (map pred? items) items)
    keep ))

(myfilter float? '(1 2.1 3.00001 4.1 5 6 7 3.2 8))
;-> (2.1 3.00001 4.1 3.2)

Cormullion
----------
(define (myfilter f lst r)
   (cond ((= (length lst) 1)  ; the basic situation
            r )
         (true
            (if (f (first lst))
               (push (first lst) r -1))
            (myfilter f (rest lst) r ))))

(myfilter float? '(1 2.1 3.00001 4.1 5 6 7 3.2 8))
;-> (2.1 3.00001 4.1 3.2)


-----------------
Funzione "index"
-----------------

******************
>>>funzione INDEX
******************
sintassi: (index exp-predicate exp-list)

Applica il predicato "exp-predicate" a ciascun elemento della lista "exp-list" e restituisce una lista contenente gli indici degli elementi per i quali "exp-predicate" è vero (true).

(index symbol? '(1 2 d 4 f g 5 h))
;-> (2 4 5 7)

(define (big? x) (> x 5))
;-> (lambda (x) (> x 5))

(index big? '(1 10 3 6 4 5 11))
;-> (1 3 6)

(select '(1 10 3 6 4 5 11) '(1 3 6))
;-> (10 6 11)

Il predicato può essere un predicato predefinito, una funzione definita dall'utente o un'espressione lambda.

Utilizzare la funzione "filter" per restituire gli elementi stessi.

Altri esempi:

(index (fn(x) (= x "b")) '("a" "b" "c" "d" "e" "b"))
;-> (1 5)


----------------------------------------------------
Formattazione di numeri interi e float (no "format")
----------------------------------------------------

Funzioni per la formattazione di numeri interi e float.

alex
----
;; Transform integer to special string format (see example)
;;
;; syntax: (pretty-int num)
;; syntax: (pretty-int num delimiter)
;;
;; Example:
;;   (pretty-int 20482048) -> "20 482 048"
;;   (pretty-int 1234567890 "'") -> "1'234'567'890"
;;
(define (pretty-int num delimiter)
  (unless delimiter (setq delimiter " "))
  (trim (reverse (replace {(\d{3})} (reverse (string num)) (append $1 delimiter) 0)) delimiter)
)

(pretty-int 1234567 ",")
;-> "1,234,567"

cameyo
------
(define (pretty num del)
  (reverse (join (explode (reverse (string num)) 3) del)))

(pretty 1234567 ",")
;-> "1,234,567"

Sammo
-----
(define (pretty-integer num delim)
  (let
    ( pattern "(?<=[0-9])(?=(?:[0-9]{3})+(?![0-9]))" )
  ;body of let
    (replace pattern (string num) (or delim " ") 0) ))

(pretty-integer 1234567 ",")
;-> "1,234,567"

Dmi
---
Questa vale per i numeri float:

(define (format-sum a)
  (let (s (format "%18.2f" a) r "")
    (dotimes (i 5)
      (set 'r (append r " " ((* 3 i) 3 s))))
    (append r (-3 s))))

(format-sum 1234567)
;-> "           1 234 567.00"
(format-sum 1234567.3456789)
;-> "           1 234 567.35"


-----------------
Pack Length Bytes
-----------------

In case anyone's interested, here is function 'pack-length-bytes' to compute and return the number of bytes that a proper 'pack' format string would produce. It works by cleverly replacing the elements of the format string with the number of bytes for each element, then summing those numbers.

Ecco la funzione 'pack-length-bytes' per calcolare e restituire il numero di byte prodotto da una stringa formattata correttamente con "pack".
Funziona sostituendo gli elementi della stringa formattata con il numero di byte per ciascun elemento, quindi sommando quei numeri.

;; Sammo
;; pack-length-bytes
;; return the number of bytes defined by a well-formed
;; 'pack' format string
;;
;; e.g.,
;; (pack-length-bytes ">ucc c s27 s4 n1 s3 n22 n2") --> 64
;; (pack-length-bytes "cccccs27s4n1s3n22n2") --> 64
;;
;; Knowing that 'replace' is destructive is the key to
;; understanding this function.
;;
;; The (cons 0 (map ...)) hack returns 0 for the
;; legal "" str-format.
;;
(define (pack-length-bytes str-format)
  (let
    ( TABLE '((">"  ""  )   ;order of table entries matters
              ("<"  ""  )
              ("ld" "4 ")   ;"ld" must precede "d"
              ("lf" "8 ")   ;"lf" must precede "f"
              ("lu" "4 ")   ;"lu" must precede "u"
              ("b"  "1 ")
              ("c"  "1 ")
              ("d"  "2 ")
              ("f"  "4 ")
              ("u"  "2 ")
              ("s"  " " )
              ("n"  " " ))
    )
  ;body of let
    (map (fn (x) (replace (x 0) str-format (x 1))) TABLE)
    (apply + (cons 0 (map integer (parse str-format)))) ))


------------------------------------
Verificare la lunghezza di una lista
------------------------------------

La maggior parte delle volte che utilizzo "lenght" è per verificare se una lista ha una determinata lunghezza.
Una funzione potrebbe essere:

(define (len? lst n) (= (length lst) (or n 0)))

dove se non viene passato il numero n, allora n = 0.

(len? '(1 2 3 4) 4)
;-> true
(len? '(1 2 3 4) 2)
;-> nil
(len? '())
;-> true
(len? '() 1)
;-> nil


----------------------------------------------------
Suddividere gli elementi di una lista (no "explode")
----------------------------------------------------

;; Jeremy Dunn
;; This function performs a multiple slice on a given list
;; One supplies a list and an integer n. The list is broken into a list of sublists of
;; length n. If n is negative the list items are collected going from the end of the list
;; to the beginning. If the optional bool argument is supplied then remaining elements are
;; included in the result.
;; (group '(1 2 3 4 5 6 7) 3)       -> ((1 2 3) (4 5 6))
;; (group '(1 2 3 4 5 6 7) 3 true)  -> ((1 2 3) (4 5 6) (7))
;; (group '(1 2 3 4 5 6 7) -3 true) -> ((1) (2 3 4) (5 6 7))
(define (group lst n bool , len num rep rem start)
  (setq num (abs n))
  (if (< n 0)
      (reverse (map reverse (group (reverse lst) num bool)))
      (= n 0)
      nil
      (begin
        (setq len   (length lst)
              rep   (/ len num)
              rem   (% len num)
              start '()
        )
        (if (< num len)
            (begin
              (dotimes (x rep)
                (setq start (cons (slice lst (* x num) num) start)))
              (if (and bool (> rem 0))
                  (setq start (cons (slice lst (* num rep) rem) start)))
              (reverse start))
            (list lst)))))

(group '(1 2 3 4 5 6 7) 3)
;-> ((1 2 3) (4 5 6))
(group '(1 2 3 4 5 6 7) 3 true)
;-> ((1 2 3) (4 5 6) (7))
(group '(1 2 3 4 5 6 7) -3 true)
;-> ((1) (2 3 4) (5 6 7))


--------------------------
Funzioni di autoincremento
--------------------------

;; @syntax (p++ '<int-a> <int-b>)
;;
;; Post-increment <int-a> by <int-b>.
(define (p++ _a01 _b01)
  "(p++ int-sym int-num) - post-increment int-sym by int-num"
  (let (_old (eval _a01))
    (++ _a01 (or _b01 1))
  _old))

;; @syntax (p-- '<int-a> <int-b>)
;;
;; Post-decrement <int-a> by <int-b>.
(define (p-- _a01 _b01)
  "(p-- int-sym int-num) - post-decrement int-sym by int-num"
  (let (_old (eval _a01))
    (-- _a01 (or _b01 1))
  _old))

Le seguenti funzioni sono obsolete in quanto "++" e "--" sono delle primitive in newLISP 10.7.5.

(define (++ _a01 _b01)
  "(++ int-a int-b) - increment int-a by int-b. int-a can be either a symbol or a value"
  (if (symbol? _a01)
    (set _a01 (+ (eval _a01) (or _b01 1)))
    (+ (eval _a01) (or _b01 1))))

(define (p++ _a01 _b01)
  "(p-- int-sym int-num) - post-increment int-sym by int-num"
  (let (_old (eval _a01))
    (++ _a01 (or _b01 1))
  _old))


--------------------
Undocumented "apply"
--------------------

cormullion
----------
I discovered by accident (and from ignorance) that apply doesn't always need a list if the function doesn't need one. So you can do this:

(map apply '(directory real-path sys-info))

or something more useful. This is cool, and seems to work fine, even though the reference manual doesn't explicitly say that you can do it!


---------------------------------------
La funzione "replace-assoc" (deprecata)
---------------------------------------

****************************
>>>funzione "REPLACE-ASSOC"
****************************
syntax: (replace-assoc exp-key list-assoc exp-replacement)
syntax: (replace-assoc exp-key list-assoc)

In the first syntax, replace-assoc replaces an association element with exp-key in the association list-assoc with exp-replacement. An association list is a list whose elements are in turn lists, the first element serving as a key.

example:
(set 'aList '((a 1 2 3)(b 4 5 6)(c 7 8 9)))

(replace-assoc 'b aList '(q "I am the replacement"))
→ ((a 1 2 3)(q "I am the replacement")(c 7 8 9))

aList  → ((a 1 2 3)(q "I am the replacement")(c 7 8 9))

replace-assoc uses the system variable $0 for the association found. This can be used in the replacement expression:

(set 'lst '((a 1)(b 2)(c 3)))

(replace-assoc 'b lst (list 'b (+ 1 (last $0))))

lst → ((a 1)(b 3)(c 3))

replace-assoc returns the changed list or nil if no association is found. A destructive operation, replace-assoc changes the contents of the list.

In the second syntax, replace-assoc removes an association from the list and returns it, as follows:

example:
(set 'lst '((a 1) (b 2) (c 3)))

(replace-assoc 'c lst)

lst  → ((a 1) (b 3))
$0   → (c 3)

Storia della funzione deprecata "replace-assoc":

7.5
---
replace-assoc
now also uses the system variable $0 for the old  list, which can be reused in the replacement expression, i.e:

(set 'lst '((a 1)(b 2)(c 3)))
(replace-assoc 'b lst
    (list 'b (+ 1 (last $0))))
lst => ((a 1)(b 3)(c 3))

now returns the changed list not the replaced element,which now is in $0.

9.3
---
set-assoc – renamed replace-assoc changes an association, handles nested associations.

9.4
---
Deprecated replace-assoc has been removed. Use set-assoc and pop-assoc instead. (v.9.4.4)
------------

Comunque nella versione 10.7.5 anche "set-assoc" è deprecata.
Adesso al posto della funzione "replace-assoc" bisogna usare "set-ref" (o "set-ref-all") per modificare una lista di associazione.

Vediamo un esempio:

(set 'lst '((a 1) (b 2) (c 3)))

; funzione deprecata
(replace-assoc 'b lst
    (list 'b (+ 1 (last $0))))

; output
lst --> ((a 1)(b 3)(c 3))

; uso di set-ref

(set-ref (assoc 'b lst) lst (list 'b (+ ($it 1) 1)))
;-> ((a 1) (b 3) (c 3))

Come funziona?

(assoc 'b lst)
;-> (b 2) ; elemento trovato

(ref (assoc 'b lst) lst)
;-> (1) ; indice elemento da modificare

                                  $it
(list 'b (+ ($it 1) 1))) --> (b (+ 2 1)) --> (b 3) ; elemento nuovo ($it = 2)


--------------
Insertion Sort
--------------

Algoritmo Insertion Sort
1) Iterare la lista
2) Confrontare l'elemento corrente (chiave) con il suo predecessore.
3) Se l'elemento chiave è più piccolo del suo predecessore, confrontalo con gli elementi precedenti.
4) Sposta gli elementi più grandi di una posizione in alto per fare spazio all'elemento scambiato.

(define (insertion lst)
  (local (len key j)
    (setq len (length lst))
    (for (i 1 (- len 1))
      (setq key (lst i))
      (setq j (- i 1))
      ; Spostare gli elementi di lst[0..i-1], che sono maggiori di key,
      ; di una posizione avanti rispetto alla loro posizione attuale
      (while (and (>= j 0) (> (lst j) key))
        (setf (lst (+ j 1)) (lst j))
        (-- j)
      )
      (setf (lst (+ j 1)) key)
    )
    lst))

(insertion '(1 3 4 5 2 3 7 8 9 3 3 4))
;-> (1 2 3 3 3 3 4 4 5 7 8 9)

(insertion (randomize (sequence -10 10)))
;-> (-10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10)

Complessità temporale: O(n^2)
Insertion Sort impiega il tempo massimo O(n^2) se gli elementi sono ordinati in ordine inverso.
Insertion Sort impiega il tempo minimo O(n) quando gli elementi sono già ordinati.


--------------------
Rimuovere i commenti
--------------------

Ecco un paio di funzioni per rimuovere i commenti da un file sorgente:

HPW:
----
(define (striplinecomment completelinestr      complinelst newlinestr)
   (setq complinelst (parse completelinestr ";"))
   (if (>(length complinelst)1)
      (if (not(find "\""(last complinelst)))     ;when semicolon not part of a string
        (begin
          (pop complinelst -1)
          (setq newlinestr (trim(join complinelst ";")"" "\t"))
        )
        (setq newlinestr completelinestr)
      )
      (setq newlinestr completelinestr)
   )
   newlinestr
)

Sammo:
------
; not account for comments beginning with "#" or
; strings delimited with "{" and "}".
(define (uncomment str)
  (let
    ( loc (explode str)
      result '()
      comment nil
      in-quote nil
    )
  ;body of let
    (until (or comment (empty? loc))
      (let
        ( ch (pop loc) )
      ;body of let
        (case ch
          ("\"" (push ch result)
                (set 'in-quote (not in-quote)) )
          (";"  (if in-quote
                  (push ch result)
                  (set 'comment true) ))
          (true (push ch result) ))))
  ;return from outer let
    (trim (join (reverse result)) "" " ") ))

Modalità di utilizzo:

(set 'OUT "outfile.lsp"
(set 'IN "infile.lsp"
(set 'NL "\r\n")
(write-file OUT (join (map uncomment (parse (read-file IN) NL)) NL))

alex:
-----
; use newLISP's own parser
(define (no-comments src)
# Remove all comments from newlisp program
# ATTENTION! The program must have RIGHT SYNTAX
# Example:
#     (println (no-comments (read-file "prog.lsp")))
#
  (setq src (append "(let (____ (lambda ()\n" src "\n))(eval ____))"))
  (regex "^[(] *lambda *[(][)] *(.*) *[)]$" (string (eval-string src)) 4)
  $1
)

(define (no-comments src)
  (rest (chop (string (eval-string (append "'(" src ")"))))))


------------------------------------------------------
Rimuovere una sequenza di elementi uguali da una lista
------------------------------------------------------

Dato una lista con alcuni elementi raddoppiati:

(setq s '(1 1 4 2 2 3 3 4 4 5 5 4 4 3 3 4 2 2 1 1))

Qual è il modo migliore per rimuovere - ad esempio - le due coppie di 4 4?

Non è possibile usare "replace":

(replace 4 s)
;-> (1 1 2 2 3 3 5 5 3 3 2 2 1 1)

perché perdiamo anche i 4 singoli (quelli non raddoppiati).

Sammo:
------

(define (remove-pair L A)
  (reverse (remove-pair-aux (first L) (rest L) A '())) )

(define (remove-pair-aux head tail atom result)
  (cond
    ( (empty? tail)
      (cons head result)
    )
    ( (!= head atom)
      (remove-pair-aux (first tail) (rest tail) atom (cons head result))
    )
    ( (= head (first tail))
      (remove-pair-aux (first (rest tail)) (rest (rest tail)) atom result)
    )
    ( true
      (remove-pair-aux (first tail) (rest tail) atom (cons head result))
    ) ))

(setq s '(1 1 4 2 2 3 3 4 4 5 5 4 4 3 3 4 2 2 1 1))
(remove-pair s 4)
;-> (1 1 4 2 2 3 3 5 5 3 3 4 2 2 1 1)

Ecco la stessa funzione espressa con la notazione di indicizzazione implicita:

(define (remove-pair L A)
  (reverse (remove-pair-aux (L 0) (1 L) A '())) )

(define (remove-pair-aux head tail atom result)
  (cond
    ( (empty? tail)
      (cons head result)
    )
    ( (!= head atom)
      (remove-pair-aux (tail 0) (1 tail) atom (cons head result))
    )
    ( (= head (tail 0))
      (remove-pair-aux (tail 1) (2 tail) atom result)
    )
    ( true
      (remove-pair-aux (tail 0) (1 tail) atom (cons head result))
    ) ))

(setq s '(1 1 4 2 2 3 3 4 4 5 5 4 4 3 3 4 2 2 1 1))
(remove-pair s 4)
;-> (1 1 4 2 2 3 3 5 5 3 3 4 2 2 1 1)

Ecco una soluzione più generale che consente di rimuovere "gruppi" adiacenti di atomi (non solo gruppi di due) e che consente di specificare che desideri rimuovere gruppi di N o più grandi.

Iniziamo scrivendo la funzione "grouper" per creare liste di atomi identici adiacenti nella lista L:

; aggiunta da cameyo per newLISP 10.7.5
(define (car lst)
  (if lst
    (first lst)
    nil))

(define (grouper L)
  (reverse (grouper-aux (car L) (rest L) '())) )

(define (grouper-aux head tail result)
  (cond
    ( (= head nil)
      result
    )
    ( (empty? result)
      (grouper-aux (car tail) (rest tail) (cons (list head) result))
    )
    ( (member head (car result))
      (push head result 0 0)
      (grouper-aux (car tail) (rest tail) result)
    )
    ( true
      (grouper-aux (car tail) (rest tail) (cons (list head) result))
    ) ))

(setq s '(1 1 2 2 3 3 4 4 5 5 4 4 4 3 3 3 2 2 2 1 1 1))
(grouper s)
;-> ((1 1) (2 2) (3 3) (4 4) (5 5) (4 4 4) (3 3 3) (2 2 2) (1 1 1))

E ora una funzione per rimuovere dalla lista L gruppi di atomi A di lunghezza N o maggiore:

(define (remove-groups L A N)
  (let
    ( result '() )
  ;body of let
    (dolist (sublist L)
      (if (or (!= (sublist 0) A) (< (length sublist) (or N 1)))
        (push sublist result -1)) )
  ;return from let
    result ))

Infine, un esempio che rimuove i gruppi di 4 con lunghezza 3 o maggiore:

(setq s '(1 1 2 2 3 3 4 4 5 5 4 4 4 3 3 3 2 2 2 1 1 1))
(flat (remove-groups (grouper s) 4 3))
;-> (1 1 2 2 3 3 4 4 5 5 5 3 3 3 2 2 2 1 1 1)

Lutz:
-----
Questo sembra un lavoro per "match":

(setq s '(1 1 4 2 2 3 3 4 4 5 5 4 4 3 3 4 2 2 1 1))

(while (match '(* 4 4 *) s) (set 's (apply append (match '(* 4 4 *) s))))
;-> (1 1 4 2 2 3 3 5 5 3 3 4 2 2 1 1)

oppure in modo più breve e più veloce:

(set 's '(1 1 4 2 2 3 3 4 4 5 5 4 4 3 3 4 2 2 1 1))

(while (set 'L (match '(* 4 4 *) s)) (set 's (apply append L)))
(1 1 4 2 2 3 3 5 5 3 3 4 2 2 1 1)


-------------------------------------
Verificare l'esistenza di un contesto
-------------------------------------

Come verificare l'esistenza di un contesto dato da una stringa:

(set 'CON:demo 123)
;-> 123
(sym "CON" MAIN nil)
;-> CON
(context? CON)
;-> true
Questo non funziona:
(context? (sym "CON" MAIN nil))
;-> nil

Basta aggiungere "eval" all'ultima espressione:

(sym "CONT" MAIN nil)
;-> nil
(set 'CONT:foo 123)
;-> 123
(sym "CONT" MAIN nil)
;-> CONT

(context? (eval (sym "CONT" MAIN nil)))
;-> true


------------------
Lutz Computer 2006
------------------

Il 16 aprile 2006 Lutz ha fatto il seguente post:

(set 'a (sequence 1 200))
; indexing (nth)
(time (dotimes (i 1000) (dotimes (j 200) (set 'b (nth j a)))))
;-> ;-> 217
; indexing (implicit)
(time (dotimes (i 1000) (dotimes (j 200) (set 'b (a j)))))
;-> 212
; slicing (j a)
(time (dotimes (i 1000) (dotimes (j 200) (set 'b (j a))))) ; slicing
;-> 2262

Il mio computer il 12 gennaio 2023 è 10 volte più veloce:

(set 'a (sequence 1 200))
; indexing (nth)
(time (dotimes (i 1000) (dotimes (j 200) (set 'b (nth j a)))))
;-> 21.322
; indexing (implicit)
(time (dotimes (i 1000) (dotimes (j 200) (set 'b (a j)))))
;-> 18.23
; slicing (j a)
(time (dotimes (i 1000) (dotimes (j 200) (set 'b (j a))))) ; slicing
;-> 134.241


-------------------------------------------------------
Forum: Help with some basic object-oriented programming
-------------------------------------------------------

cormullion:
-----------

I thought I ought to learn a bit of "object-oriented" programming. Following the examples in the book, with some changes, I thought about something like this:

(context 'Account)
   (define (make-new nme bal ph)
      (println nme " "  bal " " ph)
      (set 'ctxt (replace " " (upper-case nme) ""))
      (new Account 'ctxt)
      (set 'ctxt (eval ctxt))
      (set 'ctxt:full-name nme 'ctxt:balance bal 'ctxt:phone ph))

   (define (Account:deposit amount)
      (inc 'balance amount)
      (println full-name "'s new balance is " balance))

   (define (Account:withdraw amount)
      (dec 'balance amount)
      (println full-name "'s new balance is " balance))

   (define (Account:statement)
      (println "Fullname: " full-name)
      (println "Balance: " balance))

(context 'MAIN)

(Account:make-new "John Doe" 123.45 "555-555-1212")

The idea is to create a context automatically from the name.
But at the moment it fails on (new Account) with
"symbol not in MAIN context in function new : ctxt
called from user defined function
Account:(make-new "John Doe" 123.45 "555-555-1212")"

What's the problem?

And then, having successfully created dozens of these accounts, how do I iterate across them?

Lutz:
-----

Here are the changes to make it work and comments after the important lines:

(context 'Account)
   (define (make-new nme bal ph)
      (println nme " "  bal " " ph)
      (set 'ctxt (replace " " (upper-case nme) ""))
      (set 'ctxt (sym ctxt MAIN)) ; MAIN is context MAIN, don't need to quote it
      (new Account ctxt)  ; new takes a symbol as second argument
      (set 'ctxt (eval ctxt)) ; unwrap the context inside the symbol in ctxt
      (set 'ctxt:full-name nme 'ctxt:balance bal 'ctxt:phone ph)
      ctxt)  ; return the new context to work with
 ......

(context MAIN) ; don't need to quote cuase MAIN contains MAIN (but doesn't harm)

Note that the function returns the new conetxt JOHNDOE, so you can do this:

(set 'customer (Account:make-new "John Doe" 123.45 "555-555-1212"))
;-> John Doe 123.45 555-555-1212
;-> JOHNDOE
(customer:deposit 200)
;-> John Doe's new balance is 323.45
;-> 323.45
> JOHNDOE:balance
323.45

cormullion:
-----------

Thanks Lutz!
Now, having got this working, how do I find all the new objects that I've created using Account:new. Say I want to list everyone's balance. Do I store them myself or can I ask newLISP for all Account objects?

Lutz:
-----

Yoy would keep a list yourself, i.e. you could push all accounts on a list during creation:

(push (Account:make-new "John Doe" 123.45) TheAccounts)
;-> John Doe 123.45 nil
;-> JOHNDOE
(push (Account:make-new "Mary Jane" 456.78) TheAccounts)
;-> Mary Jane 456.78 nil
;-> (MARYJANE JOHNDOE)
TheAccounts
;-> (MARYJANE JOHNDOE)
(map (fn (acc) (println acc:balance)) TheAccounts)
;-> 456.78
;-> 123.45
;-> (456.78 123.45)

The last list you see: (456.78 123.45), is the result of the 'map' statement, because the return value of the 'println' statement is the balance printed

cormullion:
-----------

OK, I think I get it. So, given a string, I can turn it into a symbol that should be a context name (continuing this example):

(set 'c (replace " " (upper-case "John Doe") ""))
;-> "JOHNDOE"

then how do I get the balance?

(set 'c (replace " " (upper-case "John Doe") ""))
;-> "JOHNDOE"
(println c "'s balance is " ...)
;-> JOHNDOE's balance is nil
;-> nil

I'm finding this a little tricky. Does everyone else find it really easy? :-)

Lutz:
-----

(set 'c (replace " " (upper-case "John Doe") ""))
;-> "JOHNDOE"
(set 'customer (eval (sym c MAIN)))
;-> JOHNDOE
customer:balance
123.45

It gets complicated when handling objects with their string instead of their contexts. Because now everytime you have to create the symbol from the name and then get the context.

Once an object is created you should handle it with its context not the name string.

I'm finding this a little tricky. Does everyone else find it really easy? :-)

Many would agree with you. There are two things to comment on this:

(1) handling contexts and symbols requires good knowledge of evaluation rules in newLISP. I.e. understanding the difference between a context and a symbol or the fact that contexts evaluate to themselves, that symbols can refer to contexts, i.e: (set 'foo aContext) etc.

(2) newLISP is primarily not an object oriented language. OO programming is possible using contexts (name spaces) but if you are into heavy OO programming then newLISP is not the right language to use. newLISP's preferred data structure is the list, and a list can also hold methods (functions).

cormullion:
-----------

Thanks. I'm more or less with you now. The confusing part is this, I think:

  ...
  (set 'ctxt (sym ctxt MAIN))
  (new Account ctxt)
  (set 'ctxt (eval ctxt))
  ...

It looks like a roundabout approach. But I can see (dimly) the logic behind it...

Lutz:
-----

The confusion comes from the fact, that 'new' and 'context' take a symbol, while in terms like (print ctx:var) the 'ctx' either is the context or contains one.

Let me expand on your example:

(set 'ctxt "Hello")  ; ctxt contains a string
;-> "Hello"
(set 'ctxt (sym ctxt MAIN))  ; we made the symbol Hello
;-> Hello
; above statement is the same as saying:
(set 'ctxt 'Hello) ; put the symbol Hello into ctxt
;-> Hello
(new Account ctxt) ; new takes a symbol in target (set '(ctxt (eval ctxt)) ; peel the context out of the symbol
;-> Hello

The symbol Hello now contains the context Hello.


-----------------------------------
Forum: Formatting of println output
-----------------------------------

Perchè l'output di newLISP è strano?

cormullion:
-----------

Just puzzled by the way newLISP outputs things.

(println (set 'l (map list (randomize (sequence 1 20)) (sequence 1 20))))

always prints the first 10 elements on one line, then prints the rest of the elements one per line:

((1 1) (10 2) (3 3) (16 4) (7 5) (12 6) (11 7) (17 8) (19 9) (18
  10)
 (8 11)
 (13 12)
 (6 13)
 (14 14)
 (4 15)
 (9 16)
 (15 17)
 (2 18)
 (5 19)
 (20 20))

Why is this?

HPW:
----

pretty-print is your friend:

> (pretty-print 7)
(7 " ")
> (silent(println (set 'l (map list (randomize (sequence 1 20)) (sequence 1 20)))))
((19 1)
(7 2)
(3 3)
(10 4)
(12 5)
(17 6)
(15 7)
(20 8)
(2 9)
(1 10)
(11 11)
(18 12)
(9 13)
(6 14)
(13 15)
(5 16)
(14 17)
(4 18)
(16 19)
(8 20))

Or do you want:

(silent(map println (set 'l (map list (randomize (sequence 1 20)) (sequence 1 20)))))
(16 1)
(9 2)
(2 3)
(19 4)
(11 5)
(14 6)
(6 7)
(13 8)
(10 9)
(3 10)
(7 11)
(15 12)
(4 13)
(8 14)
(5 15)
(18 16)
(1 17)
(20 18)
(12 19)
(17 20)

Lutz:
-----

Pretty printing in newLISP is optimized for saving/sourceing contents with "save" or "source", saving content with 'set' statements, and it works well for user defined functions when entering the function name on the interactive command line.

Whe you put your list into a variable and then do a

(save "myfile" 'var)
you will get a

(set 'var ....)
statement in "myfile" file which is well formatted.

Or try

(save "everything")
and get a well formatted file of all your newLISP contents you have in memory in a file.

Doing a

(load "everything")
will bring you back where you were.

Lutz

ps: and as HPW suggests, fine tune pretty printing using 'pretty-print'

cormullion:
-----------

Thanks. I hadn't thought of pretty-print.

PS - Why does println do what it does, though?. :-)

Dmi:
----

I done something like this for my not-yet-released newlisp-console:

(define (sys-cols) 80)

(define (format-expr lst cols indent , curline shift lstart lend)
  "format the nested list to simply indented wrapped string list"
  "use (indent (format-expr ...)) then for more fine wrap"
  (setq curline "" lstart true shift 0)
  (unless cols (setq cols (sys-cols)))
  (unless indent (setq indent 2)) ; indent step
  (let (outbuf (indent-wrap lst))
    (new-curline)
    outbuf))

; inner to indent-wrap
(define (new-curline value)
  (if (and curline (not (empty? curline)) (push-end curline outbuf)))
  (set 'curline (append (dup " " shift) (unless value "" value))
       'lstart true))

; supply string-like converter. needed workaround for \t etc.
(define (string-value s)
  (if (string? s) (append "\""
                          (replace "\n" (replace "\"" (replace "\\"
                            s "\\\\") "\\\"") "\\n")
                          "\"")
                  (string s)))

; if s-expr fit the line, we write it
; else we'll write subexpressions until they fill the line
(define (indent-wrap lst , lbuf)
  (let (outbuf '() s (string-value lst))
    (if (< (+ (length curline) 1 (length s)) cols)
      (write-buffer curline (append
                              (unless (or (empty? curline) lstart) " " "")
                              s))
      (unless (list? lst)
        (new-curline s)
        (begin
          (new-curline "(")
          (inc 'shift indent)
          (set 'lbuf (length outbuf))
          (dolist (l lst)
            (if lend (new-curline))
            (set 'lend nil)
            (set 'outbuf (append outbuf (indent-wrap l))))
          (write-buffer curline ")")
          (set 'lend (> (length outbuf) lbuf))
          (dec 'shift indent))))
    (set 'lstart nil)
    outbuf))

use: (format-expr lst)

Lutz:
-----

How does pretty print work?

There is a set of rules when to break the line and how much indenting steps to fill in before each line.

The rules count the the level and balance of open braces and watch if the stuff printed comes from a user-defined function. Certain primitives like i'if', 'dotimes', 'dolist', 'while', 'until' have an iternal flag telling when to break the line, this way braking after the parameter list or condition.

When saving lists formattting is optimized for 'save' and 'source'.

DMI's program does something similar, but I haven't looked into it enough to explain the differences.

HPW:
----

PS - Why does println do what it does, though?. :-)

I uses simply the default settings:

(pretty-print)         => (64 " ") ;; default setting

It should print a long list and reach that default boundry.

cormullion:
-----------

I see that it does that for the first line, but then it doesn't take any notice for the remaining lines...
Not a problem - a curiousity!

Dmi:
----
My one is mainly for printing the "data" lists. It trying to fill each line until possible, then do a line break with indenting (if it needed to reflect the structure).
The cormullion's example will be printed like this:

((17 1) (12 2) (14 3) (3 4) (10 5) (9 6) (11 7) (1 8) (8 9) (7 10) (16 11)
  (6 12) (4 13) (18 14) (19 15) (2 16) (15 17) (13 18) (5 19) (20 20))

It can also pretty indent a code too, for ex:
(join (format-expr indent-wrap) "\n")
but there is no sufficient euristics for smart line breaking according with lisp code etc. - only the list structure is checked for indenting and bracket closing.

Lutz:
-----

Pretty printing in newLISP is optimized for saving/sourceing contents with "save" or "source", saving content with 'set' statements:

> (set 'l (map list (randomize (sequence 1 20)) (sequence 1 20)))
((7 1) (6 2) (18 3) (19 4) (14 5) (13 6) (3 7) (12 8) (9 9) (16 10)
 (4 11)
 (2 12)
 (8 13)
 (15 14)
 (5 15)
 (11 16)
 (10 17)
 (17 18)
 (1 19)
 (20 20))
> (save "list" 'l)
true

> !cat list
(set 'l '(
  (7 1)
  (6 2)
  (18 3)
  (19 4)
  (14 5)
  (13 6)
  (3 7)
  (12 8)
  (9 9)
  (16 10)
  (4 11)
  (2 12)
  (8 13)
  (15 14)
  (5 15)
  (11 16)
  (10 17)
  (17 18)
  (1 19)
  (20 20)))

Note that 'cat' is a shell command the '!' has to come immedeately before it and in the first column and initiates the shell. Of course you also could open the file "list" in an editor.

Only a completely flat list will fill each line to the end.

> (set 'l (sequence 1 100))
(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
 92 93 94 95 96 97 98 99 100)
> (save "list" 'l)
true
> !cat list
(set 'l '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
  23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
  44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
  65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85
  86 87 88 89 90 91 92 93 94 95 96 97 98 99 100))

It is impossible to make a pretty print algorithm, which gets it right all the time. Remember that LISP has the same syntax for data and program. The current algorithm is optimized for displaying program text and does a reasonable well job on data, when using 'save' and 'source' for ouput.


-------------
Here document
-------------

Un documento "here" (o "heredoc") è un modo per specificare un blocco di testo, preservando le interruzioni di riga, i rientri e altri spazi bianchi all'interno del testo.

; here-document.lsp
; oofoe 2012-01-19
; http://rosettacode.org/wiki/Here_document

(print (format [text]
    Blast it %s! I'm a %s,
    not a %s!
       --- %s
[/text] "James" "magician" "doctor" "L. McCoy"))
;(exit)
;->    Blast it James! I'm a magician,
;->    not a doctor!
;->       --- L. McCoy

(silent
(println (format
[text]
    I tag sono utili...

    ... a volte.
[/text])))
;->   I tag sono utili...
;->
;->   ... a volte.

Nota: la riga vuota (seconda riga tra i tag) contiene uno spazio all'inizio (altrimenti viene generato un errore).


---------------
Numeri di Keith
---------------

Un numero intero X è un numero di Keith se appare in una sequenza (definita di seguito) generata utilizzando le sue N cifre.
La sequenza ha come primi N termini le cifre di X e gli altri termini sono valutati ricorsivamente come somma dei precedenti N termini.

Esempi:

X = 197
197 ha 3 cifre, quindi N = 3
Costruiamo la sequenza partendo dalle cifre del numero:
1 9 7 (+ 1 9 7) --> 1 9 7 17 (+ 9 7 17) --> 1 9 7 17 33 (+ 7 17 33) -->
1 9 7 17 33 57 (+ 17 33 57) --> 1 9 7 17 33 57 107 (+ 33 57 107) -->
1 9 7 17 33 57 107 197 ...
Il numero è di Keith perché compare nella sequenza che ha i primi tre termini come 1, 9, 7 e i termini rimanenti valutati utilizzando la somma dei 3 termini precedenti.

X = 12
12 ha 2 cifre, quindi N = 2
Costruiamo la sequenza: 1 2 3 5 8 13 21
Il numero non è di Keith perché non compare nella sequenza

Sequenza OEIS A130010:
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 14, 19, 28, 47, 61, 75, 197, 742, 1104, 1537, 2208, 2580, 3684, 4788, 7385, 7647, 7909, 31331, 34285, 34348, 55604, 62662, 86935, 93993, 120284, 129106, 147640, 156146, 174680, 183186, 298320, 355419, 694280, 925993, 1084051, 7913837, 11436171, 33445755,

Nota: i primi 10 numeri (0..9) sono tutti numeri di Keith per definizione (sono i primi termini della sequenza.

Algoritmo
Creare una lista con le cifre del numero X
Ciclo per generare i termini successivi della sequenza e aggiorna la sequenza stessa.
  Generare termini fino a che (X < termine)
Se il termine finale è uguale a x, allora X è un numero di Keith.
Se il termine finale è maggiore di x, allora X non è un numero di Keith.

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (keith? num)
  (local (values len next-val)
    (setq values (int-list num))
    (setq len (length values))
    (setq next-val 0)
    (while (< next-val num)
      (push (setq next-val (apply + (slice values (- len)))) values -1)
    )
    ; (println values)
    (= next-val num)))

Facciamo alcune prove:

(keith? 197)
;-> true

(filter keith? (sequence 0 100))
;-> (1 2 3 4 5 6 7 8 9 14 19 28 47)

(time (println (filter keith? (sequence 0 1e6))))
;-> (0 1 2 3 4 5 6 7 8 9 14 19 28 47 61 75 197 742 1104 1537 2208 2580 3684 4788 7385
;->  7647 7909 31331 34285 34348 55604 62662 86935 93993 120284 129106 147640 156146
;->  174680 183186 298320 355419 694280 925993)
;-> 5953.238
(time (println (filter keith? (sequence 0 1e7))))
;-> (0 1 2 3 4 5 6 7 8 9 14 19 28 47 61 75 197 742 1104 1537 2208 2580 3684 4788 7385
;->  7647 7909 31331 34285 34348 55604 62662 86935 93993 120284 129106 147640 156146
;->  174680 183186 298320 355419 694280 925993 1084051 7913837)
;-> 72725.268


---------------
Numeri ondulati
---------------

Un numero "ondulato" è un numero che ha solo due tipi di cifre e le cifre alternate sono uguali, cioè è della forma "ababab...".
I numeri ondulati non banali devono avere almeno 3 cifre e "a" non è uguale a "b".

Sequenza OEIS A046075:
  101, 121, 131, 141, 151, 161, 171, 181, 191, 202, 212, 232, 242, 252,
  262, 272, 282, 292, 303, 313, 323, 343, 353, 363, 373, 383, 393, 404,
  414, 424, 434, 454, 464, 474, 484, 494, 505, 515, 525, 535, 545, 565,
  575, 585, 595, 606, 616, 626, 636, 646, 656...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (ondulato? num)
  (local (s stop)
    (cond ((< num 100) nil)
          (true
            (setq s (int-list num))
            (setq stop nil)
            ; le prime due cifre devono essere diverse
            (if (= (s 0) (s 1) (setq stop true)))
            ; se le prime due cifre sono diverse, allora
            ; controlla se tutte le cifre alternate sono uguali o no
            (for (i 2 (- (length s) 1) 1 stop)
              (if (!= (s (- i 2)) (s i)) (setq stop true))
            )
            (not stop)))))

(ondulato? 121)
;-> true

(ondulato? 818182)
;-> nil

(filter ondulato? (sequence 100 1000))
;-> (101 121 131 141 151 161 171 181 191 202 212 232 242 252 262 272 282
;->  292 303 313 323 343 353 363 373 383 393 404 414 424 434 454 464 474
;->  484 494 505 515 525 535 545 565 575 585 595 606 616 626 636 646 656
;->  676 686 696 707 717 727 737 747 757 767 787 797 808 818 828 838 848
;->  858 868 878 898 909 919 929 939 949 959 969 979 989)


---------------------
La funzione "replace"
---------------------

********************
>>>funzione REPLACE
********************

sintassi: (replace exp-key list exp-replacement [func-compare])
sintassi: (replace exp-key list)

sintassi: (replace str-key str-data exp-replacement)
sintassi: (replace str-pattern str-data exp-replacement regex-option)

Sostituzioni nelle liste
------------------------
Se il secondo argomento è una lista, "replace" sostituisce tutti gli elementi nella lista list che sono uguali all'espressione in "exp-key". L'elemento viene sostituito con "exp-replacement". Se manca "exp-replacement", tutte le istanze di "exp-key" verranno eliminate dalla lista.

Si noti che "replace" è distruttiva. Cambia la lista che gli è stato passata e restituisce la lista modificata. Il numero di sostituzioni effettuate è contenuto nella variabile di sistema $count dopo il ritorno della funzione. Durante le esecuzioni dell'espressione di sostituzione, la variabile di sistema anaforica $it viene impostata sull'espressione da sostituire.

Facoltativamente, "func-compare" può specificare un operatore di confronto o una funzione definita dall'utente. Per impostazione predefinita, func-compare è il = (segno di uguale).

;; list replacement

(set 'aList '(a b c d e a b c d))

(replace 'b aList 'B)  → (a B c d e a B c d)
aList  → (a B c d e a B c d)
$count → 2  ; number of replacements

;; list replacement with special compare functor/function

; replace all numbers where 10 < number
(set 'L '(1 4 22 5 6 89 2 3 24))

(replace 10 L 10 <) → (1 4 10 5 6 10 2 3 10)
$count → 3

; same as:

(replace 10 L 10 (fn (x y) (< x y))) → (1 4 10 5 6 10 2 3 10)

; change name-string to symbol, x is ignored as nil

(set 'AL '((john 5 6 4) ("mary" 3 4 7) (bob 4 2 7 9) ("jane" 3)))

(replace nil AL (cons (sym ($it 0)) (rest $it))
                (fn (x y) (string? (y 0)))) ; parameter x = nil not used
→ ((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3))

; use $count in the replacement expression
(replace 'a '(a b a b a b) (list $count $it) =) →  ((1 a) b (2 a) b (3 a) b)

Usando le funzione "match" e "unify" le ricerche sulle liste sono potenti come le ricerche sulle stringhe con le espressioni regolari:

; calculate the sum in all associations with 'mary

(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))

(replace '(mary *)  AL (list 'mary (apply + (rest $it))) match)
→ ((john 5 6 4) (mary 14) (bob 4 2 7 9) (jane 3))

$count → 1

; make sum in all expressions

(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))

(replace '(*) AL (list ($it 0) (apply + (rest $it))) match)
→ ((john 15) (mary 14) (bob 22) (jane 3))
$count → 4

; using unify, replace only if elements are equal
(replace '(X X) '((3 10) (2 5) (4 4) (6 7) (8 8)) (list ($it 0) 'double ($it 1)) unify)
→ ((3 10) (2 5) (4 double 4) (6 7) (8 double 8))

Rimozioni nelle liste
---------------------
L'ultima forma di "replace" ha solo due argomenti: l'espressione "exp-key" e "list". Questa forma rimuove tutte le "exp-key" trovate nella lista.

;; removing elements from a list

(set 'lst '(a b a a c d a f g))
(replace 'a lst)  → (b c d f g)
lst               → (b c d f g)

$count → 4

Sostituzioni nelle stringhe senza espressioni regolari
------------------------------------------------------
Se tutti gli argomenti sono stringhe, "replace" sostituisce tutte le occorrenze di "str-key" in "str-data" con la "exp-replacement" valutata, restituendo la stringa modificata. L'espressione in "exp-replacement" viene valutata per ogni sostituzione. Il numero di sostituzioni effettuate è contenuto nella variabile di sistema $count. Questa forma di sostituzione può anche elaborare 0 binari (zero).

;; string replacement
(set 'str "this isa sentence")
(replace "isa" str "is a")  → "this is a sentence"

$count → 1

Sostituzioni nelle stringhe con espressioni regolari
----------------------------------------------------
La presenza di un quarto parametro indica che è necessario eseguire una ricerca di espressioni regolari con un modello di espressione regolare specificato in str-pattern e un numero di opzione specificato in regex-option (ad es. 1 (uno) o "i" per la ricerca senza distinzione tra maiuscole e minuscole o 0 (zero) per una ricerca standard Perl compatibile con espressione regolare (PCRE) senza opzioni). Vedi regex sopra per i dettagli.

Per impostazione predefinita, replace sostituisce tutte le occorrenze di una stringa di ricerca anche se nel modello di ricerca è inclusa una specifica di inizio riga. Dopo ogni sostituzione, viene avviata una nuova ricerca in una nuova posizione in str-data. L'impostazione del bit di opzione su 0x8000 in regex-option forzerà la sostituzione solo della prima occorrenza. Viene restituita la stringa modificata.

replace con le espressioni regolari imposta anche le variabili interne $0, $1 e $2 con il contenuto delle espressioni e delle sottoespressioni trovate. La variabile di sistema anaforica $it è impostata sullo stesso valore di $0. Questi possono essere utilizzati per eseguire sostituzioni che dipendono dal contenuto trovato durante la sostituzione. I simboli $it, $0, $1 e $2  possono essere usati nelle espressioni come qualsiasi altro simbolo. Se l'espressione di sostituzione restituisce qualcosa di diverso da una stringa, non viene effettuata alcuna sostituzione. In alternativa, è possibile accedere al contenuto di queste variabili anche utilizzando ($ 0), ($ 1), ($ 2) e così via. Questo metodo consente l'accesso indicizzato (ad es. ($ i), dove i è un numero intero).

Dopo aver effettuato tutte le sostituzioni, il numero di sostituzioni è contenuto nella variabile di sistema $count.

;; using the option parameter to employ regular expressions

(set 'str "ZZZZZxZZZZyy")     → "ZZZZZxZZZZyy"
(replace "x|y" str "PP" 0)    → "ZZZZZPPZZZZPPPP"
str                           → "ZZZZZPPZZZZPPPP"

;; using system variables for dynamic replacement

(set 'str "---axb---ayb---")
(replace "(a)(.)(b)" str (append $3 $2 $1) 0)
→ "---bxa---bya---"

str  → "---bxa---bya---"

;; using the 'replace once' option bit 0x8000

(replace "a" "aaa" "X" 0)  → "XXX"

(replace "a" "aaa" "X" 0x8000)  → "Xaa"

;; URL translation of hex codes with dynamic replacement

(set 'str "xxx%41xxx%42")
(replace "%([0-9A-F][0-9A-F])" str
               (char (int (append "0x" $1))) 1)

str    → "xxxAxxxB"

$count → 2

Anche la funzione "setf" insieme a "nth", "first" o "last" può essere utilizzata per modificare gli elementi in una lista.

Vedere "directory", "find", "find-all", "parse", "regex", e "search" per altre funzioni che utilizzano le espressioni regolari.


----------------------------------
Translating S-expressions into XML
----------------------------------

newLISP has built in support for parseing XML into s-expressions using xml-parse, but going the other way translating s-expressions into XML has to be coded. Fortunately this is a natural task for LISP with a recursive algorithm. The following function can be used to translate a LISP s-expression back into XML:

;;
;; translate s-expr to XML
;; written by Lutz Mueller
;; updated: 2007-01-08
;;
(define (expr2xml expr (level 0))
 (cond
   ((or (atom? expr) (quote? expr))
       (print (dup "  " level))
       (println expr))
   ((list? (first expr))
       (expr2xml (first expr) (+ level 1))
       (dolist (s (rest expr)) (expr2xml s (+ level 1))))
   ((symbol? (first expr))
       (print (dup "  " level))
       (println "<" (first expr) ">")
       (dolist (s (rest expr)) (expr2xml s (+ level 1)))
       (print (dup "  " level))
       (println "</" (first expr) ">"))
   (true
      (print (dup "  " level)
      (println "<error>" (string expr) "<error>")))
 ))

;; a lisp expression for a person

(set 'expr '(person
              (name "John Doe")
              (address (street "Main Street") (city "Anytown"))))

;; translate to XML with default indentation 0

(expr2xml expr)   =>

<person>
   <name>
     John Doe
   </name>
   <address>
       <street>
         Main Street
       </street>
       <city>
         Anytown
       </city>
   </address>
</person>

The second parameter 0 is the indentation level for the outermost tag expression.


------------------------------
Forum: On recursive procedures
------------------------------

rickyboy:
---------

; This roman numbers generator by Sam Cox
; is a nice example of recursive programming in LISP.
; roman.lsp
; Sam Cox December 8, 2003
;
; LM 2003/12/12: took out type checking of n
;
;
; This function constructs a roman numeral representation from its positive
; integer argument, N.  For example,
;
;     (roman 1988) --> MCMLXXXVIII
;
; The Roman method of writing numbers uses two kinds of symbols: the basic
; symbols are I=1, X=10, C=100 and M=1000; the auxiliary symbols are V=5,
; L=50 and D=500. A rule prescribes that the symbol for the larger number
; always stands to the left of that for the smaller number. An exception
; is motivated by the desire to use as few symbols as possible. For
; example, the number nine can be represented as VIIII (5+4) or IX (10-1);
; the latter is preferred.  Therefore, if the symbol of a smaller number
; stands at the left, the corresponding number has to be subtracted, not
; added.  It is not permitted to place several basic symbols or an
; auxiliary symbol in front.  For example, use CML for 950 instead of LM.
; ---
; The VNR Encyclopedia of Mathematics, W. Gellert, H. Kustner, M. Hellwich,
; and H. Kastner, eds., Van Nostrand Reinhold Company, New York, 1975.

(define (roman n)
        (roman-aux "" n (first *ROMAN*) (rest *ROMAN*)))

(define (roman-aux result n pair remaining)
    (roman-aux-2 result n (first pair) (second pair) remaining))

(define (roman-aux-2 result n val rep remaining)
    (if
        (= n 0)
            result
        (< n val)
            (roman-aux result n (first remaining) (rest remaining))
        ;else
            (roman-aux-2 (append result rep) (- n val) val rep remaining)))

(define (second x) (nth 1 x))

(setq *ROMAN*
         '(( 1000  "M" )
           (  999 "IM" )
           (  990 "XM" )
           (  900 "CM" )
           (  500  "D" )
           (  499 "ID" )
           (  490 "XD" )
           (  400 "CD" )
           (  100  "C" )
           (   99 "IC" )
           (   90 "XC" )
           (   50  "L" )
           (   49 "IL" )
           (   40 "XL" )
           (   10  "X" )
           (    9 "IX" )
           (    5  "V" )
           (    4 "IV" )
           (    1  "I" )))

; end of file

If I load the previous function in newlisp, I can time it like this:

> (time (roman 2006) 1000)
470

A version with less call overhead, but still recursive, will yield:

(define (roman* n val rep vrlist acc)
  (if (not val)
      (roman* n ((*ROMAN* 0) 0) ((*ROMAN* 0) 1) (1 *ROMAN*) "")
      (= n 0)
      acc
      (< n val)
      (roman* n ((vrlist 0) 0) ((vrlist 0) 1) (1 vrlist) acc)
      (roman* (- n val) val rep vrlist (string acc rep))))

> (time (roman* 2006) 1000)
266

Of course, as you know, the best performing version is the one with no extra call overhead:

(define (roman** n)
  (let ((val ((*ROMAN* 0) 0))
        (rep ((*ROMAN* 0) 1))
        (vrlist (1 *ROMAN*))
        (acc ""))
    (until (= n 0)
      (cond ((< n val)
             (set 'val ((vrlist 0) 0) 'rep ((vrlist 0) 1))
             (pop vrlist))
            (true
             (set 'acc (string acc rep) 'n (- n val)))))
    acc))

> (time (roman** 2006) 1000)
94

My only problem is that the recursive ones are easier to program, read, and understand. And it would be nice if, also, both 'roman' and 'roman*' could perform about as well as 'roman**'. That is, Lutz, will tail recursive call optimization ever be forthcoming in newLISP? Curious.

Dmi:
----

Btw, about tail recursion:
Imho, it isn't mandatory for newlisp - to analyze the code to determine "is this funcall - a tail recursion finisher?" - we can just to have a function, that will imitate tail-recursive call (i.e. replace current function in stack) whenever it called.
Something like an "exec()" libc function in unix...

How about this, Lutz?

rickyboy:
---------

Wow! This comment is very interesting to me because I was not aware that this could be done, in general. When I think about how this could be done, I can't avoid using a stack. (I am not a language implementor, so I am not surprised by any of my inabilities in this area :-) For instance, if I write a function which makes a non-tail recursive call, I find myself stuck thinking that there is some computation, at that level, which has to wait for the recursive call to complete, before it can complete its own computation. So, I naturally think of this as a continuation. Well, if we replace the current run-time on the stack with the recursive call, as you suggest, I'm thinking "what about the loss of the continuation?" Then I think, "well, we can remember this continuation and all further ones, down the line, by pushing them onto a list; when we then bottom out on the recursion, we call the continuations one by one, by popping them off of the list" -- the final answer ends up being a composition of the continuations. But this is just another stack! :-)
Dmi, could you elaborate on this concept for the feeble-minded among us (i.e. me). If you could also point to a written resource, I'd happily

Dmi:
----

Hmm... the thing I wrote isn't a big news. Look at this:

(define (recur a b c)
  (some code 1)
  (recur (x y z)
  (some code 2)

This is a "regular" recursion. It must be done with stack growing because after recursive call we must return to upper level, complete (some code 2 section) and return it's result to the top level.
Now this:

(define (recur a b c)
  (some code 1)
  (recur (x y z))

In this example we haven't a finish-section like (some code 2), so the result of the top-level recur will be the same as the result of recur of a sublevel and so forth. So in this case we won't need in top-level (recur) anymore and we can forgot about it - i.e., drop from stack. If the language can treat this, then we got the ability to write some of recursive code as effective as iterative one. Afaik, term "tail-recursive" is about this situation.

About implementation: PROLOG does this, "classic" LISP does this. newLISP doesn't this at present, but, really, I think this isn't a big cost for it's smallness/advantages rate.

Speaking about implementation, I think, this isn't simple. But we already have the (catch ... (throw)) construct, that perform a stack cleaning.
So, I have a think - is it possible to have something like (recurse .... (return)), so the return will first clean the stack and then somehow evaluate it's arguments.
Really only Lutz can know is it possible :-)

rickyboy:
---------

He, he, he. Yes, Dmi, I know what "tail recursion" means. :-)

I had just thought in your original message that you were claiming that it wouldn't be necessary for newlisp to determine if a recursive call was of the tail type, and I didn't know how this would be possible, i.e. not to check for "tailness" but still able to optimize the tail call. But I realize now that you were not originally claiming this. I'm sorry for any confusion.

However, this does not let Lutz off the hook. :-) So, Lutz, what do you think? Would it be a terribly difficult task to optimize tail calls in newlisp? Thanks, in advance, for any response. --Ricky

Dmi:
----

heh :-)
The only new, I mean, is that if we realize a function like "return" in C, then it will _always_ can be a tail-recursive. So, meeting such function, the interpreter will not need to gess. And a programmer will not need to guess too ;-)

Lutz:
-----

I have several thoughts and comments to this, some against, some for tail recursion optimization. Perhaps Dmitry's suggestion is a good compromise.

The memory overhead is about 80 stack bytes per call function call for an average of 2 parameters passed. Currently the stack default is 2048 levels, which can be increased to hundreds of thousands vi the -s command line switch when starting newLISP.

Tail recursive functions are easy to rewrite as iterating functions. The benefit of code elegance and and code readability is greatest for recursive functions which are not tail recursive. The same benefit for tail recursive functions is small. As a side note: much of this judgement is subjective and a matter of taste either way.

Tail recursion in newLISP would rather slow down performance than speed it up. Checking for tail recursion would be expensive and not justify the speed performance gain of minimizing function call overhead. The benefit would be mainly in saving stack memory.

From a practical, application oriented point of view there is not enough benefit. I prefer iterative solutions most of the time because they tend to be much faster. There are algorithms like "Translating S-expressions into XML" where recursion is the best way to do it. But algorithms like this one are not tail recursive anyway and tend to be shallow enough for the default 2048 level stack allocation.

To sum it up when tail recursion optimization is possible, it doesn't give us much benefit.

Still I have looked into it again and again, simply because the feature seemed to be interesting from a theoretical point of view and have some application benefits in (imho rare) situations. But I have not found a simple way to implement this without using much resources, checking for tail recursion would be expensive speed performance wise.

BUT, what I found interesting is Dmitry's comment/suggestion of implementing an explicit tail recursive function call (replacing the current function on the function call stack). So basically let the programmer decide when a recursive call is pushing the stack or not. This solution would not burden present performance, but give the programmer a way of optimizing a tail recursive function by saving stack and call overhead space. I will look into that.


---------------------
Sequenza di Sylvester
---------------------

La sequenza di Sylvester è una sequenza di numeri interi definita dalla seguente relazione:

  a(n+1) = a(n)^2 - a(n) + 1, con a(0) = 2

  a(1) = 2^2 - 2 + 1 = 3
  a(2) = 3^2 - 3 + 1 = 7
  ...

Sequenza OEIS A000058:
  2, 3, 7, 43, 1807, 3263443, 10650056950807, 113423713055421844361000443,
  12864938683278671740537145998360961546653259485195807, ...

(define (sylvester limit)
  (local (val cur out)
    (setq val 2L)
    (setq cur 0L)
    (setq out '(2))
    (for (i 1 (- limit 1))
      (setq cur (+ (* val val) (- val) 1L))
      (push cur out -1)
      (setq val cur)
    )
    out))

(sylvester 4)
;-> (2 3L 7L 43L)

(sylvester 9)
;-> (2 3L 7L 43L 1807L 3263443L 10650056950807L 113423713055421844361000443L
;->  12864938683278671740537145998360961546653259485195807L)


------------------------------------
Numeri di Cullen e di Woodall/Riedel
------------------------------------

Woodall/Riedel
--------------
w(n) = n*2^n - 1

Sequenza OEIS A003261:
  1, 7, 23, 63, 159, 383, 895, 2047, 4607, 10239, 22527, 49151, 106495,
  229375, 491519, 1048575, 2228223, 4718591, 9961471, 20971519, 44040191,
  92274687, 192937983, 402653183, 838860799, 1744830463, 3623878655,
  7516192767, ...

Cullen
------
c(n) = n*2^n + 1

Sequenza OEIS 002064:
  1, 3, 9, 25, 65, 161, 385, 897, 2049, 4609, 10241, 22529, 49153,
  106497, 229377, 491521, 1048577, 2228225, 4718593, 9961473, 20971521,
  44040193, 92274689, 192937985, 402653185, 838860801, 1744830465,
  3623878657, 7516192769, 15569256449, 32212254721, ...

Nota:
  c(n) = w(n-1) + 2, per n > 1
  w(n) = c(n+1) - 2, per n > 1

Funzioni per calcolare il numero di Woodall e Cullen per un dato intero:

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (woodall num) (- (* num (** 2 num)) 1))

(define (cullen num) (+ (* num (** 2 num)) 1))

(map woodall (sequence 1 20))
;-> (1 7 23 63 159 383 895 2047 4607 10239 22527 49151 106495
;->  229375 491519 1048575 2228223 4718591 9961471 20971519)
(map cullen (sequence 1 20))
;-> (3 9 25 65 161 385 897 2049 4609 10241 22529 49153 106497
;->  229377 491521 1048577 2228225 4718593 9961473 20971521)

Funzioni per verificare se un numero dato è di Woodall o di Cullen:

Possiamo osservare che tutti i numeri di Woodall e Cullen sono dispari.
Quindi, prima di tutto controlliamo se un determinato numero è dispari o meno.
 - Adesso per verificare se il numero è woodall o no, incrementare il numero dato per 1 e ora dividere il numero per 2 finché non è pari e contare il numero di volte in cui è divisibile. Ad ogni passaggio controllare se questo valore è uguale al numero oppure no.
 - Adesso per verificare se il numero è cullen o meno, decrementare il numero dato per 1 e ora dividere il numero per 2 finché non è pari e contare il numero di volte in cui è divisibile. Ad ogni passaggio controllare se questo valore è uguale al numero oppure no.

(define (woodall? num)
  (setq continua true)
  (cond ((even? num) nil); nessun numero pari
        ((= num 1) true)
        (true
          (++ num) ; adesso num è pari
          ; numero di divisioni (potenza)
          (setq pot 0)
          ; ciclo delle divisioni
          (while (and (zero? (% num 2)) continua)
            (setq num (/ num 2))
            (++ pot)
            ; se numero di divisioni uguale a num --> stop (true)
            (if (= pot num) (setq continua nil))
          )
          (not continua))))

(woodall? 383)
;-> true

(filter woodall? (sequence 1 1000))
;-> (1 7 23 63 159 383 895)

(define (cullen? num)
  (setq continua true)
  (cond ((even? num) nil) ; nessun numero pari
        ((= num 1) true)
        (true
          (-- num) ; adesso num è pari
          ; numero di divisioni (potenza)
          (setq pot 0)
          ; ciclo delle divisioni
          (while (and (zero? (% num 2)) continua)
            (setq num (/ num 2))
            (++ pot)
            ; se numero di divisioni uguale a num --> stop (true)
            (if (= pot num) (setq continua nil))
          )
          (not continua))))

(cullen? 385)
;-> true

(filter cullen? (sequence 1 1000))
;-> (1 3 9 25 65 161 385 897)



--------------------------------------------------------------------------
Moltiplicazione, divisione, addizione e sottrazione di interi solo con "+"
--------------------------------------------------------------------------

Scrivere delle funzioni che effettuano le operazioni di moltiplicazione, divisione, addizione e sottrazione utilizzando solo l'operatore di addizione "+".

Implementiamo le operazioni nel modo seguente:

  Moltiplicazione: a * b = a + a + a ... b times.
  Divisione:       a / b = contare quante volte possiamo sottrarre b da a
  Sottrazione:     a - b = a + (-1)*b.
  Addizione:       a + b = a + b

(define (same-sign? x y)
"Check if two numbers have same sign"
  (= (> x 0) (> y 0)))

Funzione per cambiare segno ad un intero utilizzando solo l'operatore "+":

(define (change-sign x)
; non possiamo usare l'operatore "-"
  (local (neg tmp)
    (setq neg 0)
    (if (< x 0)
        (setq tmp 1)
        ;else
        (setq tmp -1)
    )
    (while (!= x 0)
      (setq neg (+ neg tmp))
      (setq x (+ x tmp))
    )
    neg))

(change-sign 100)
;-> -100
(change-sign 0)
;-> 0

Funzione per addizionare due numeri interi x e y:

(define (addizione x y)
  (+ x y))

Funzione per sottrarre due numeri interi x e y:

(define (sottrazione x y)
  (+ x (change-sign y)))

(sottrazione -11 -7)
;-> -4
(sottrazione -10 6)
;-> -16
(sottrazione 12 3)
;-> 9
(sottrazione 11 -4)
;-> 15
(sottrazione 8 0)
;-> 8
(sottrazione 0 5)
;-> -5

Funzione per moltiplicare due numeri interi x e y:

(define (moltiplicazione x y)
  (if (or (zero? x) (zero? y))
      0
      ;else
      (let (out 0)
        ; perchè la funzione è più veloce se x > y
        (if (< x y) (swap x y))
        ; aggiuge x a se stesso y volte
        (for (i 1 (abs y))
          (setq out (+ out x))
        )
        ; controllo del segno
        (if (< y 0) (setq out (change-sign out)))
        out)))

(moltiplicazione -11 -7)
;-> 77
(moltiplicazione -10 6)
;-> -60
(moltiplicazione 12 3)
;-> 36
(moltiplicazione 11 -4)
;-> -44
(moltiplicazione 1 0)
;-> 0
(moltiplicazione 0 1)
;-> 0
(moltiplicazione 1 10)
;-> 10

Funzione per dividere due numeri interi x e y:

(define (divisione x y)
  (local (quoziente divisore dividendo)
    (cond ((zero? x) 0)
          ((zero? y) (div 1 0)) ; 1.#INF
          ((and (zero? x) (zero? y)) (div 0 0)) ; 1.#IND (NaN)
          (true
            (setq quoziente 0)
            (setq dividendo (abs x))
            (setq divisore (abs y))
            (while (>= dividendo divisore)
              (setq dividendo (- dividendo divisore))
              (++ quoziente)
            )
            (if (not (same-sign? x y))
              (setq quoziente (change-sign quoziente)))
            quoziente))))

(divisione -11 -7)
;-> 1
(divisione -10 6)
;-> -1
(divisione 12 3)
;-> 4
(divisione 11 -4)
;-> -2
(divisione 1 0)
;-> 1.#INF
(divisione 0 1)
;-> 0
(divisione 1 10)
;-> 0
(divisione 1234 12)
;-> 102


-----------------------------------
Primo elemento uguale tra due liste
-----------------------------------

Date due liste, trovare il primo elemento in comune (uguale) tra le due liste.
Per esempio le seguenti due liste:

(setq a '(1 3 -3 9 7 10 -4 -8))
(setq b '(2 4 11 -9 3 -5 -6 -8))

hanno 3 come primo elemento uguale in comune.

Primo metodo
------------
La soluzione più immediata è quella di usare due cicli per attraversare le due liste alla ricerca del primo elemento uguale:

(define (trova-primo lst1 lst2)
  (let ((stop nil) (out '()) (idx1 nil) (idx2 nil))
    (dolist (e1 lst1 stop)
      (setq idx1 $idx)
      (dolist (e2 lst2 stop)
        (setq idx2 $idx)
        (if (= e1 e2)
          (begin
            (setq stop true)
            (setq out (list e1 idx1 idx2))
          )
        )
      )
    )
    out))

(trova-primo a b)
;-> (3 1 4)

La funzione trova il primo elemento uguale tra due liste e i relativi indici:

  (numero-comune indice-lista1 indice-lista2)

Un caso particolare è il seguente:

(setq a1 '(10 3 2))
(setq b1 '(11 2 3))

dove le due liste hanno sia 3 che 2 come primo elemento in comune.
In questo caso prevale l'elemento che compare prima nella prima lista (in questo esempio 3).

(trova-primo a1 b1)
;-> (3 1 2)

(setq a2 '(4 3 1 2))
(setq b2 '(8 7 5 6))

(trova-primo a2 b2)
;-> ()

Secondo metodo
--------------
Un altro metodo è quello di usare la primitiva "intersect".

(define (find-first lst1 lst2)
  (let (c (intersect lst1 lst2))
    (if c (list (first c) (find (first c) lst1) (find (first c) lst2))
          '())))

(find-first a b)
;-> (3 1 4)
(find-first a1 b1)
;-> (3 1 2)
(find-first a2 b2)
;-> ()

Terzo metodo
------------
Un altro metodo è quello di usare una hash-map (per la seconda lista).

(define (encontrar-primero lst1 lst2)
  (let ((stop nil) (out '()))
    (new Tree 'hash)
    ; converte la seconda lista in una hash-map con elementi ("el" el)
    (hash (map list lst2 lst2))
    ;(println (hash))
    ; cerca gli elementi della prima lista nella hash-map
    (dolist (el lst1 stop)
      (if (hash el)
        (set 'stop true 'out (list el $idx (find el lst2)))
      )
    )
    ; elimina la hash-map (operazione onerosa in termini di tempo)
    (delete 'hash)
    out))

(encontrar-primero a b)
;-> (3 1 4)
(encontrar-primero a1 b1)
;-> (3 1 2)
(encontrar-primero a2 b2)
;-> ()

Quarto metodo
-------------
Un altro metodo è quello di usare la ricerca binaria:

(define (bs num lst)
  (local (basso alto indice out)
    (setq out -1) ; elemento non trovato
    (setq basso 0) ; inizio lista
    (setq alto (- (length lst) 1)) ; fine lista
    (while (and (>= alto basso) (= out -1))
      (setq indice (>> (+ basso alto))) ; valore centrale indice
      (cond ((> (lst indice) num)
             (setq alto (- indice 1))) ; aggiorno l'indice "alto"
            ((< (lst indice) num)
             (setq basso (+ indice 1))) ; aggiorno l'indice "basso"
            (true (setq out indice)) ; elemento trovato
      )
    )
    out))

(define (trouver-premier lst1 lst2)
  (let ((stop nil) (out '()) (indice -1))
    (setq sort2 (sort (copy lst2))) ; O(n*log(n))
    (dolist (el lst1 stop)
      ; cerca gli elementi della prima lista nella seconda lista
      ; utilizzando la ricerca binaria
      (setq indice (bs el sort2))
      (if (!= indice -1)
        (set 'stop true 'out (list el $idx (find el lst2)))
      )
    )
    out))

(trouver-premier a b)
;-> (3 1 4)
(trouver-premier a1 b1)
;-> (3 1 2)
(trouver-premier a2 b2)
;-> ()

Vediamo la velocità delle funzioni:

Con due liste casuali:

(silent
  (setq t1 (rand 1e6 1e5))
  (setq t2 (rand 1e6 1e5)))

vediamo prima se danno risultati uguali:

(= (trova-primo t1 t2) (find-first t1 t2)
   (encontrar-primero t1 t2) (trouver-premier t1 t2))
;-> true

(time (trova-primo t1 t2))
;-> 5.984
(time (find-first t1 t2))
;-> 48.344
(time (encontrar-primero t1 t2))
;-> 55.88
(time (trouver-premier t1 t2))
;-> 25.097

Con due liste inverse (1..n) e (n..1):

(silent
  (setq t1 (sequence 1 1e6))
  (setq t2 (sequence 1e6 1 1)))

(time (trova-primo t1 t2))
;-> 93.536
(time (find-first t1 t2))
;-> 490.071
(time (encontrar-primero t1 t2))
;-> 782.776
(time (trouver-premier t1 t2))
;-> 228.061

Comunque le funzioni trovano anche gli indici del primo numero in comune.
Riscriviamo le funzioni in modo che trovino solo il numero in comune (per vedere se e come cambiano i tempi di esecuzione).

(define (f1 lst1 lst2)
  (let ((stop nil) (out nil))
    (dolist (e1 lst1 stop)
      (dolist (e2 lst2 stop)
        (if (= e1 e2)
            (set 'stop true 'out e1))))
    out))

(define (f2 lst1 lst2)
  (let (c (intersect lst1 lst2))
    (if c (first c) nil)))

(define (f3 lst1 lst2)
  (let ((stop nil) (out nil))
    (new Tree 'hash)
    (hash (map list lst2 lst2))
    (dolist (el lst1 stop)
      (if (hash el) (set 'stop true 'out el))
    )
    ; elimina la hash-map (operazione onerosa in termini di tempo)
    (delete 'hash)
    out))

(define (f4 lst1 lst2)
  (let ((stop nil) (out nil))
    (sort lst2) ; O(n*log(n))
    (dolist (el lst1 stop)
      (if (!= (bs el lst2) -1) (set 'stop true 'out el))
    )
    out))

Vediamo la velocità delle funzioni:

Con due liste casuali:

(silent
  (setq t1 (rand 1e6 1e5))
  (setq t2 (rand 1e6 1e5)))

vediamo prima se danno risultati uguali:

(= (f1 t1 t2) (f2 t1 t2) (f3 t1 t2) (f4 t1 t2))
;-> true

(time (f1 t1 t2))
;-> 12.99
(time (f2 t1 t2))
;-> 56.916
(time (f3 t1 t2))
;-> 95.252
(time (f4 t1 t2))
;-> 47.351

Con due liste inverse (1..n) e (n..1):

(silent
  (setq t1 (sequence 1 1e6))
  (setq t2 (sequence 1e6 1 1)))

(time (f1 t1 t2))
;-> 102.236
(time (f2 t1 t2))
;-> 511.886
(time (f3 t1 t2))
;-> 812.303
(time (f4 t1 t2))
;-> 212.816

Qualche volta la soluzione più semplice (la prima) è anche la più veloce.

Nota: in altri linguaggi probabilmente la versione più veloce è diversa dalla prima. Molto dipende da quali primitive sono a disposizione e come sono state implementate nel linguaggio.


------------------------------
Modulo 10^9+7 (M = 1000000007)
------------------------------

In alcune delle competizioni di programmazione, occorre calcolare il risultato modulo 10^9+7.

Operazione modulo
-----------------
Il resto ottenuto dopo l'operazione di divisione su due operandi è noto come operazione modulo.
L'operatore per eseguire l'operazione del modulo è '%'.
Ad esempio: a % b = c che significa che quando a è diviso per b dà il resto c:
per esempio: 15 % 4 = 3, 22 % 3 = 1.

QUindi l'operazione modulo è la stessa di "il resto della divisione".
Se dico a modulo b è c, significa che quando a è diviso per b il resto è c.
L'operazione modulo è rappresentata dall'operatore '%' nella maggior parte dei linguaggi di programmazione.

Nota: il risultato di (a % b) è sempre minore di b.

Nota: nella maggior parte dei linguaggi (es. C/C++) quando si esegue l'operazione modulare con numeri negativi si ottiene un risultato negativo come -a % b = -c, ma il risultato di un'operazione modulare deve essere sempre positivo (da 0 a b-1), quindi si utilizza la seguente regola:

 - se x è positivo, allora x modulo 10^9+7 =  x % (10^9+7)
 - se x è negativo, allora x modulo 10^9+7 = (x % (10^9+7)) + (10^9+7)

(setq x 86714357681)
(setq y -86714357681)

(% x 1000000007)
;-> 714357079

(% y 1000000007)
;-> -714357079
(+ (% y 1000000007) 1000000007)
;-> 285642928

Perchè modulo 10^9+7 ?
----------------------
1) Se il problema coinvolge numeri interi grandi, solo algoritmi efficienti possono risolverlo nel tempo consentito.
2) viene usato il modulo per prevenire overflow di numeri interi. Per esempio, in C/C++ il tipo unsigned long long int ha 64 bit e può gestire numeri interi da 0 a (2^64 – 1).
3) In alcuni problemi è necessario calcolare il risultato modulo inverso e 10^9+7 è comodo perché è primo ed è abbastanza grande per poter eseguire correttamente le tecniche modulari inverse.

Nota: 10^9+7 = 1000000007 è il primo numero primo di 10 cifre (tipo int).
Qualsiasi numero primo inferiore a 2^30 è sufficiente per evitare possibili overflow.

Proprietà distributive dell'operazione modulo %
-----------------------------------------------
L'operazione modulo è distributiva rispetto a "+", "*" e "–", ma non rispetto a "/".

  1) (a + b) % c = ((a % c) + (b % c)) % c  (addizione)
  2) (a * b) % c = ((a % c) * (b % c)) % c  (moltiplicazione)
  3) (a – b) % c = ((a % c) – (b % c)) % c  (sottrazione)
  4) (a / b) % c != ((a % c) / (b % c)) % c (divisione) non vale la proprietà

Nei programmi eseguiamo il modulo ad ogni fase intermedia per evitare gli eventuali overflow.

; Maximum value of int64
(setq MAX-INT 9223372036854775807)
; Minimum value of int64
(setq MIN-INT -9223372036854775808)

(setq M 1000000007)

Moltiplicazione
---------------
Esempio:

(setq a 8272348623486123476)
(setq b 2678234723472347734)
(setq c 1238956721589712338)

Per calcolare (a*b*c)%M possiamo usare due metodi

1) calcolare direttamente il valore (a * b * c) % M:

(% (* a b c) M)
;-> 920119129 ; risultato errato

Infatti calcolando con i big-integer otteniamo il valore corretto:

(% (* (bigint a) (bigint b) (bigint c)) m2)
;-> 850869488L ; risultato corretto

2) Calcolare il modulo M ad ogni passo (moltiplicazione):

(setq res 1) ; res = 1
(setq res (% (* (bigint a) res) M)) ; res = (res*a) % M    // res = 579683521L
(setq res (% (* (bigint b) res) M)) ; res = (res*b) % M    // res = 687005916L
(setq res (% (* (bigint c) res) M)) ; res = (res*c) % M    // res = 850869488L
res
;-> 850869488L ; risultato corretto

Nota: dobbiamo usare lo stesso "bigint" perchè altrimenti è la moltiplicazione stessa che va in overflow.

Vediamo un altro esempio dove (a3*b3*c3) > MAX-INT, ma (a3*b3) < MAX-INT:

(setq aa 1234512345)
(setq bb 3458964859)
(setq cc 2346234635)

Usiamo il primo metodo:

(% (* aa bb cc) M)
;-> -251141583 ; risultato errato

Usiamo i big-integer per calcolare il risultato corretto:

(% (* (bigint aa) (bigint bb) (bigint cc)) M)
;-> 322955479L

Usiamo il secondo metodo:

(setq res 1) ; res = 1
(setq res (% (* aa res) M)) ; res = (res*a) % M    // res = 234512338
(setq res (% (* bb res) M)) ; res = (res*b) % M    // res = 465740832
(setq res (% (* cc res) M)) ; res = (res*c) % M    // res = 322955479
res
;-> 322955479

Addizione
---------
La stessa procedura può essere utilizzata per l'addizione.

  (a + b + c) % M è uguale a (((a + b) % M) + c) % M

Eseguire % M ogni volta che viene aggiunto un numero in modo da evitare l'overflow.

Nota: nella maggior parte dei linguaggi (es. C/C++) quando si esegue l'operazione modulare con numeri negativi si ottiene un risultato negativo come -a % b = -c, ma il risultato di un'operazione modulare deve essere sempre positivo (da 0 a b-1), quindi il risultato vale c.

(setq a 2347123489712345871)
(setq b 1223495723485712389)
(setq c 7234697823469023904)

1) calcolo diretto di ((+ a b c) % M)

(% (+ a b c ) M)
;-> -552480571 ; risultato errato

Usiamo i big-integer per calcolare il risultato corretto:

(% (+ (bigint a) (bigint b) (bigint c)) M)
;-> 29863437L

Usiamo il secondo metodo:

(setq res 0)
(setq res (abs (% (+ a res) M)))
;-> 282481560
(setq res (abs (% (+ b res) M)))
;-> 203723944
(setq res (abs (% (+ c res) M)))
;-> 29863437

Oppure più brevemente:

(setq res 0)
(setq res (abs (% (+ a b) M)))
;-> 203723944
(setq res (abs (% (+ c res) M)))
;-> 29863437

Quindi se in un problema scopriamo che qualsiasi passo di un ciclo può calcolare un valore che è fuori dall'intervallo degli interi, allora possiamo usare l'operatore modulo in quel passo stesso. La risposta finale sarà come se avessimo usato l'operatore modulo solo una volta.


-----------------------------------
Primo elemento uguale tra due liste
-----------------------------------

Date due liste, trovare il primo elemento in comune (uguale) tra le due liste.
Per esempio le seguenti due liste:

(setq a '(1 3 -3 9 7 10 -4 -8))
(setq b '(2 4 11 -9 3 -5 -6 -8))

hanno 3 come primo elemento uguale in comune.

Primo metodo
------------
La soluzione più immediata è quella di usare due cicli per attraversare le due liste alla ricerca del primo elemento uguale:

(define (trova-primo lst1 lst2)
  (let ((stop nil) (out '()) (idx1 nil) (idx2 nil))
    (dolist (e1 lst1 stop)
      (setq idx1 $idx)
      (dolist (e2 lst2 stop)
        (setq idx2 $idx)
        (if (= e1 e2)
          (begin
            (setq stop true)
            (setq out (list e1 idx1 idx2))
          )
        )
      )
    )
    out))

(trova-primo a b)
;-> (3 1 4)

La funzione trova il primo elemento uguale tra due liste e i relativi indici:

  (numero-comune indice-lista1 indice-lista2)

Un caso particolare è il seguente:

(setq a1 '(10 3 2))
(setq b1 '(11 2 3))

dove le due liste hanno sia 3 che 2 come primo elemento in comune.
In questo caso prevale l'elemento che compare prima nella prima lista (in questo esempio 3).

(trova-primo a1 b1)
;-> (3 1 2)

(setq a2 '(4 3 1 2))
(setq b2 '(8 7 5 6))

(trova-primo a2 b2)
;-> ()

Secondo metodo
--------------
Un altro metodo è quello di usare la primitiva "intersect".

(define (find-first lst1 lst2)
  (let (c (intersect lst1 lst2))
    (if c (list (first c) (find (first c) lst1) (find (first c) lst2))
          '())))

(find-first a b)
;-> (3 1 4)
(find-first a1 b1)
;-> (3 1 2)
(find-first a2 b2)
;-> ()

Terzo metodo
------------
Un altro metodo è quello di usare una hash-map (per la seconda lista).

(define (encontrar-primero lst1 lst2)
  (let ((stop nil) (out '()))
    (new Tree 'hash)
    ; converte la seconda lista in una hash-map con elementi ("el" el)
    (hash (map list lst2 lst2))
    ;(println (hash))
    ; cerca gli elementi della prima lista nella hash-map
    (dolist (el lst1 stop)
      (if (hash el)
        (set 'stop true 'out (list el $idx (find el lst2)))
      )
    )
    ; elimina la hash-map (operazione onerosa in termini di tempo)
    (delete 'hash)
    out))

(encontrar-primero a b)
;-> (3 1 4)
(encontrar-primero a1 b1)
;-> (3 1 2)
(encontrar-primero a2 b2)
;-> ()

Quarto metodo
-------------
Un altro metodo è quello di usare la ricerca binaria:

(define (bs num lst)
  (local (basso alto indice out)
    (setq out -1) ; elemento non trovato
    (setq basso 0) ; inizio lista
    (setq alto (- (length lst) 1)) ; fine lista
    (while (and (>= alto basso) (= out -1))
      (setq indice (>> (+ basso alto))) ; valore centrale indice
      (cond ((> (lst indice) num)
             (setq alto (- indice 1))) ; aggiorno l'indice "alto"
            ((< (lst indice) num)
             (setq basso (+ indice 1))) ; aggiorno l'indice "basso"
            (true (setq out indice)) ; elemento trovato
      )
    )
    out))

(define (trouver-premier lst1 lst2)
  (let ((stop nil) (out '()) (indice -1))
    (setq sort2 (sort (copy lst2))) ; O(n*log(n))
    (dolist (el lst1 stop)
      ; cerca gli elementi della prima lista nella seconda lista
      ; utilizzando la ricerca binaria
      (setq indice (bs el sort2))
      (if (!= indice -1)
        (set 'stop true 'out (list el $idx (find el lst2)))
      )
    )
    out))

(trouver-premier a b)
;-> (3 1 4)
(trouver-premier a1 b1)
;-> (3 1 2)
(trouver-premier a2 b2)
;-> ()

Vediamo la velocità delle funzioni:

Con due liste casuali:

(silent
  (setq t1 (rand 1e6 1e5))
  (setq t2 (rand 1e6 1e5)))

vediamo prima se danno risultati uguali:

(= (trova-primo t1 t2) (find-first t1 t2)
   (encontrar-primero t1 t2) (trouver-premier t1 t2))
;-> true

(time (trova-primo t1 t2))
;-> 5.984
(time (find-first t1 t2))
;-> 48.344
(time (encontrar-primero t1 t2))
;-> 55.88
(time (trouver-premier t1 t2))
;-> 25.097

Con due liste inverse (1..n) e (n..1):

(silent
  (setq t1 (sequence 1 1e6))
  (setq t2 (sequence 1e6 1 1)))

(time (trova-primo t1 t2))
;-> 93.536
(time (find-first t1 t2))
;-> 490.071
(time (encontrar-primero t1 t2))
;-> 782.776
(time (trouver-premier t1 t2))
;-> 228.061

Comunque le funzioni trovano anche gli indici del primo numero in comune.
Riscriviamo le funzioni in modo che trovino solo il numero in comune (per vedere se e come cambiano i tempi di esecuzione).

(define (f1 lst1 lst2)
  (let ((stop nil) (out nil))
    (dolist (e1 lst1 stop)
      (dolist (e2 lst2 stop)
        (if (= e1 e2)
            (set 'stop true 'out e1))))
    out))

(define (f2 lst1 lst2)
  (let (c (intersect lst1 lst2))
    (if c (first c) nil)))

(define (f3 lst1 lst2)
  (let ((stop nil) (out nil))
    (new Tree 'hash)
    (hash (map list lst2 lst2))
    (dolist (el lst1 stop)
      (if (hash el) (set 'stop true 'out el))
    )
    ; elimina la hash-map (operazione onerosa in termini di tempo)
    (delete 'hash)
    out))

(define (f4 lst1 lst2)
  (let ((stop nil) (out nil))
    (sort lst2) ; O(n*log(n))
    (dolist (el lst1 stop)
      (if (!= (bs el lst2) -1) (set 'stop true 'out el))
    )
    out))

Vediamo la velocità delle funzioni:

Con due liste casuali:

(silent
  (setq t1 (rand 1e6 1e5))
  (setq t2 (rand 1e6 1e5)))

vediamo prima se danno risultati uguali:

(= (f1 t1 t2) (f2 t1 t2) (f3 t1 t2) (f4 t1 t2))
;-> true

(time (f1 t1 t2))
;-> 12.99
(time (f2 t1 t2))
;-> 56.916
(time (f3 t1 t2))
;-> 95.252
(time (f4 t1 t2))
;-> 47.351

Con due liste inverse (1..n) e (n..1):

(silent
  (setq t1 (sequence 1 1e6))
  (setq t2 (sequence 1e6 1 1)))

(time (f1 t1 t2))
;-> 102.236
(time (f2 t1 t2))
;-> 511.886
(time (f3 t1 t2))
;-> 812.303
(time (f4 t1 t2))
;-> 212.816

Qualche volta la soluzione più semplice (la prima) è anche la più veloce.

Nota: in altri linguaggi probabilmente la versione più veloce è diversa dalla prima. Molto dipende da quali primitive sono a disposizione e come sono state implementate nel linguaggio.


---------------------------
Ordinare parte di una lista
---------------------------

Scrivere una funzione che ordina una parte di una lista definita da un indice di inizio e un indice di fine.
La funzione ha quattro parametri:

  lst   = lista di input
  start = indice di partenza (compreso)
  end   = indice di arrivo (compreso)
  op    = tipo di ordinamento (es. > o <)

L'output deve essere una lista uguale alla lista di input tranne il fatto che gli elementi da start a end (compresi) sono ordinati.

Dividiamo la lista in tre parti: (0..start) (start...end) (end...(length lst)).
Poi ordiniamo la parte centrale e infine riuniamo le tre sottoliste.

Nota: non viene fatto alcun controllo sulla correttezza degli indici start e end.

(define (sort-part lst start end op)
  (local (len1 len2 len3)
    ; default: ordinamento crescente "<"
    (setq op (or op '<))
    ; calcoliamo la lunghezza delle liste
    ; per le operazioni di "slice"
    (setq len1 (- start 0))
    (setq len2 (+ (- end start) 1))
    (setq len3 (- (length lst) len1 len2))
    ; slice, sort e append
    (append (slice lst 0 len1)                ; lista iniziale
            (sort (slice lst start len2) op)  ; lista centrale (ordinata)
            (slice lst (+ len1 len2) len3)))) ; lista finale

Facciamo alcune prove:

(setq a '("2" "3" "1" "7" "8" "6"))

(sort-part a 0 3)
;-> ("1" "2" "3" "7" "8" "6")
(sort-part a 1 3)
;-> ("2" "1" "3" "7" "8" "6")
(sort-part a 0 4)
;-> ("1" "2" "3" "7" "8" "6")
(sort-part a 0 5)
;-> ("1" "2" "3" "6" "7" "8")
(sort-part a 4 5)
;-> ("2" "3" "1" "7" "6" "8")

(sort-part a 0 3 >)
;-> ("7" "3" "2" "1" "8" "6")
(sort-part a 1 3 >)
;-> ("2" "7" "3" "1" "8" "6")
(sort-part a 0 4 >)
;-> ("8" "7" "3" "2" "1" "6")
(sort-part a 0 5 >)
;-> ("8" "7" "6" "3" "2" "1")
(sort-part a 4 5 >)
;-> ("2" "3" "1" "7" "8" "6")


-----------------------------------
Numero maggiore con le stesse cifre
-----------------------------------

Dato un numero intero positivo N, trovare il primo numero maggiore di N che ha le stesse cifre di N.
Se questo numero non esiste (perchè N è il numero più grande possibile con le sue cifre), allora restituire nil.

Esempi:

N = 123     -->  primo maggiore = 132
N = 12021   -->  primo maggiore = 12102
N = 348123  -->  primo maggiore = 348123
N = 54321   -->  primo maggiore = nil

Soluzione che utilizza le permutazioni:

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

(define (perm lst)
"Generates all permutations without repeating from a list of items"
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    (setq out (list lst))
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i))
            )
            (push lst out -1)
            (++ (indici i))
            (setq i 0)
          )
          (begin
            (setf (indici i) 0)
            (++ i))))
    out))

(define (prossimo num)
  (local (lst p idx-num)
    (setq lst (int-list num))
    (setq p (perm lst))
    ; unique serve per eliminare i numeri uguali che si creano
    ; quando abbiamo delle cifre uguali nel numero dato.
    (setq p (unique (map list-int (sort p))))
    (setq idx-num (find num p))
    (println p)
    (println idx-num)
    ; se il numero dato è l'ultimo delle permutazioni ordinate,
    ; allora non esiste un numero maggiore con le stesse cifre
    ; altrimenti restituisce il numero successivo al numero dato
    (if (= num (p -1))
        nil
        ;else
        (p (+ idx-num 1)))))

(prossimo 12021)
;-> 12102
(prossimo 218765)
;-> 251678
(prossimo 1234)
;-> 1243
(prossimo 4321)
;-> nil
(prossimo 534976)
;-> 536479
(prossimo 456)
;-> 465

Un pò più concisa:

(define (next num)
  (let (p (unique (map list-int (sort (perm (int-list num))))))
    (if (= num (p -1)) nil (p (+ (find num p) 1)))))

(next 123)
;-> 132
(next 12021)
;-> 12102
(next 348123)
;-> 348132
(next 54321)
;-> nil
(next 12345)
;-> 12354

Cosa possiamo osservare?
Se tutte le cifre sono ordinate in ordine decrescente (es. 8765), l'output è sempre "nil" perchè non esiste un numero maggiore.
Se tutte le cifre sono ordinate in ordine crescente (es. 3456), è sufficiente scambiare le ultime due cifre (es. 3465)
Per gli altri casi, usiamo il seguente algoritmo:

Attraversare il numero dato dalla cifra più a destra finché non si trova una cifra che è più piccola della cifra precedentemente attraversata. Ad esempio, con N = 134875, ci fermiamo a 4 perché 4 è più piccolo della cifra successiva 8.
Se non troviamo tale cifra non esiste un numero maggiore con le stesse cifre (output = nil).
Ora cercare, a destra della cifra sopra "d", la cifra più piccola maggiore di "d".
Per 134875, il lato destro di 4 contiene "875". La cifra più piccola maggiore di 4 è 5.
Scambiare le due cifre trovate sopra: otteniamo 135874 (scambiando 4 con 5).
Adesso ordinare tutte le cifre dalla posizione successiva di "d" alla fine del numero (a destra della posizione d).
Il numero che otteniamo dopo l'ordinamento è la soluzione.
Nell'esempio dobbiamo ordinare 874, in 135874, ottenendo il numero 135478, che è il numero successivo più grande di 134875.

Nota: partiamo dalla destra del numero perché dobbiamo trovare il più piccolo di tutti i numeri maggiori.

Funzione che ordina parte di una lista (dall'indice start all'indice end compresi):

(define (sort-part lst start end op)
  (local (len1 len2 len3)
    ; default: ordinamento crescente "<"
    (setq op (or op '<))
    (setq len1 (- start 0))
    (setq len2 (+ (- end start) 1))
    (setq len3 (- (length lst) len1 len2))
    (append (slice lst 0 len1)                ; lista iniziale
            (sort (slice lst start len2) op)  ; lista centrale (ordinata)
            (slice lst (+ len1 len2) len3)))) ; lista finale

(define (proximo lst)
  (local (s len idx stop base diff idx2)
    (setq s (int-list lst))
    (setq len (length lst))
    ; trova la prima cifra minore da destra
    (setq stop nil)
    (for (i (- len 1) 1 -1 stop)
      (if (> (s i) (s (- i 1)))
          (set 'stop true 'idx (- i 1))
      )
    )
    ; se non abbiamo trovato la cifra minore,
    ; allora il risultato è nil
    (cond ((= stop nil) nil)
          (true
            ; trova la cifra più piccola che è maggiore di (s idx)
            ; a destra di idx (fino alla fine del numero)
            (setq base (s idx))
            (setq diff 99)
            (for (i (+ idx 1) (- len 1))
              (if (> (s i) base)
                  (if (> diff (- (s i) base))
                      (set 'diff (- (s i) base) 'idx2 i)
                  )
              )
            )
            ; scambia le cifre degli indici idx e idx2
            (swap (s idx) (s idx2))
            ; ordina la parte del numero dopo l'indice idx
            (list-int (sort-part s (+ idx 1) (- len 1)))))))

Facciamo alcune prove:

(proximo 134875)
;-> 135478
(proximo 134855)
;-> 135458

Vediamo se le due funzioni restituiscono risultati identici.

(= (map next (sequence 100 1e5))
   (map proximo (sequence 100 1e5)))
;-> true


---------------------------------
Numero minore con le stesse cifre
---------------------------------

Dato un numero intero positivo N, trovare il primo numero minore di N che ha le stesse cifre di N.
Se questo numero non esiste (perchè N è il numero più piccolo possibile, con le sue cifre), allora restituire nil.

Esempi:

N = 123     -->  primo minore = 132
N = 12021   -->  primo minore = nil
N = 348123  -->  primo minore = 343821
N = 54321   -->  primo minore = 54312

Input:  N = "218765"
Output: 218756

Input:  N = "1234"
Output: Not Possible

Input: N = "262345"
Output: 256432

Soluzione che utilizza le permutazioni:

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

(define (perm lst)
"Generates all permutations without repeating from a list of items"
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    (setq out (list lst))
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i))
            )
            (push lst out -1)
            (++ (indici i))
            (setq i 0)
          )
          (begin
            (setf (indici i) 0)
            (++ i))))
    out))

(define (prossimo num)
  (local (lst p idx-num)
    (setq lst (int-list num))
    (setq p (perm lst))
    ; unique serve per eliminare i numeri uguali che si creano
    ; quando abbiamo delle cifre uguali nel numero dato.
    (setq p (unique (map list-int (sort p))))
    (setq idx-num (find num p))
    (println p)
    (println idx-num)
    ; se il numero dato è l'ultimo delle permutazioni ordinate,
    ; allora non esiste un numero maggiore con le stesse cifre
    ; altrimenti restituisce il numero successivo al numero dato
    (if (= num (p -1))
        nil
        ;else
        (p (+ idx-num 1)))))

(prossimo 12021)
;-> 12102
(prossimo 218765)
;-> 251678
(prossimo 1234)
;-> 1243
(prossimo 4321)
;-> nil
(prossimo 534976)
;-> 536479
(prossimo 456)
;-> 465

Un pò più concisa:

(define (next num)
  (let (p (unique (map list-int (sort (perm (int-list num))))))
    (if (= num (p -1)) nil (p (+ (find num p) 1)))))

(next 123)
;-> 132
(next 12021)
;-> 12102
(next 348123)
;-> 348132
(next 54321)
;-> nil
(next 12345)
;-> 12354


--------------------------------------------
Numero minore con le stesse cifre
--------------------------------------------

Dato un numero intero positivo N, trovare il primo numero minore di N che ha le stesse cifre di N.
Se questo numero non esiste (perchè N è il numero più grande possibile, o più piccolo possibile, con le sue cifre), allora restituire nil.

Esempi:

N = 123     -->  primo minore = nil
N = 12021   -->  primo minore = 12012
N = 348123  -->  primo minore = 343821
N = 54321   -->  primo minore = 54312

Soluzione che utilizza le permutazioni:

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

(define (perm lst)
"Generates all permutations without repeating from a list of items"
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    (setq out (list lst))
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i))
            )
            (push lst out -1)
            (++ (indici i))
            (setq i 0)
          )
          (begin
            (setf (indici i) 0)
            (++ i))))
    out))

(define (precedente num)
  (local (lst p idx-num)
    (setq lst (int-list num))
    (setq p (perm lst))
    ; unique serve per eliminare i numeri uguali che si creano
    ; quando abbiamo delle cifre uguali nel numero dato.
    (setq p (unique (map list-int (sort p))))
    (setq idx-num (find num p))
    (println p)
    (println idx-num)
    ; se il numero dato è il primo delle permutazioni ordinate,
    ; allora non esiste un numero minore con le stesse cifre
    ; altrimenti restituisce il numero precedente al numero dato
    (if (= num (p 0))
        nil
        ;else
        (p (- idx-num 1)))))

(precedente 12021)
;-> 12012
(precedente 218765)
;-> 218756
(precedente 1234)
;-> nil
(precedente 4321)
;-> 4312
(precedente 534976)
;-> 534967
(precedente 456)
;-> nil

Un pò più concisa:

(define (previous num)
  (let (p (unique (map list-int (sort (perm (int-list num))))))
    (if (= num (p 0)) nil (p (- (find num p) 1)))))

(previous 123)
;-> nil
(previous 12021)
;-> 12012
(previous 348123)
;-> 343821
(previous 54321)
;-> 54312
(previous 12345)
;-> nil

Cosa possiamo osservare?
Se tutte le cifre sono ordinate in ordine crescente (es. 3456), l'output è sempre "nil" perchè non esiste un numero minore.
Se tutte le cifre sono ordinate in ordine decrescente (es. 8765), è sufficiente scambiare le ultime due cifre (es. 8756).
Per gli altri casi, usiamo il seguente algoritmo:

Attraversare il numero dato dalla cifra più a destra finché non si trova una cifra che è più grande della cifra precedentemente attraversata. Ad esempio, con N = 262345, ci fermiamo a 6 perché 6 è più grande della cifra precedente 2.
Se non troviamo tale cifra non esiste un numero maggiore con le stesse cifre (output = nil).
Ora cercare, a destra della cifra sopra "d", la cifra più grande minore di "d".
Per 262345, il lato destro di 6 contiene "2345". La cifra più grande minore di 6 è 5.
Scambiare le due cifre trovate sopra: otteniamo 252346 (scambiando 6 con 5).
Adesso ordinare in modo decrescente tutte le cifre dalla posizione successiva di "d" alla fine del numero (a destra della posizione "d").
Il numero che otteniamo dopo l'ordinamento è la soluzione.
Nell'esempio dobbiamo ordinare 2345, in 252346, ottenendo il numero 256432, che è il numero precedente più piccolo di 262345.

Nota: partiamo dalla destra del numero perché dobbiamo trovare il più grande di tutti i numeri minori.

Funzione che ordina parte di una lista (dall'indice start all'indice end compresi):

(define (sort-part lst start end op)
  (local (len1 len2 len3)
    ; default: ordinamento crescente "<"
    (setq op (or op '<))
    (setq len1 (- start 0))
    (setq len2 (+ (- end start) 1))
    (setq len3 (- (length lst) len1 len2))
    (append (slice lst 0 len1)                ; lista iniziale
            (sort (slice lst start len2) op)  ; lista centrale (ordinata)
            (slice lst (+ len1 len2) len3)))) ; lista finale

(define (preximo lst)
  (local (s len idx stop base diff idx2)
    (setq s (int-list lst))
    (setq len (length lst))
    ; trova la prima cifra maggiore da destra
    (setq stop nil)
    (for (i (- len 1) 1 -1 stop)
      (if (< (s i) (s (- i 1)))
          (set 'stop true 'idx (- i 1))
      )
    )
    ; se non abbiamo trovato la cifra maggiore,
    ; allora il risultato è nil
    (cond ((= stop nil) nil)
          (true
            ; trova la cifra più grande che è minore di (s idx)
            ; a destra di idx (fino alla fine del numero)
            (setq base (s idx))
            (setq diff 99)
            (for (i (+ idx 1) (- len 1))
              (if (> base (s i))
                  (if (> diff (- base (s i)))
                      (set 'diff (- base (s i)) 'idx2 i)
                  )
              )
            )
            ; scambia le cifre degli indici idx e idx2
            (swap (s idx) (s idx2))
            ; ordina la parte del numero dopo l'indice idx
            (list-int (sort-part s (+ idx 1) (- len 1) >))))))

Facciamo alcune prove:

(preximo 262345)
;-> 256432
(preximo 134875)
;-> 134857
(preximo 134855)
;-> 134585

Vediamo se le due funzioni restituiscono risultati identici.

(= (map previous (sequence 100 1e5))
   (map preximo (sequence 100 1e5)))
;-> true


---------------------
x + y + z = x * y * x
---------------------

Scrivere un programma per trovare tutte le soluzioni intere positive dell'equazione:

 x + y + z = x * y * x

La prima soluzione (estremamente inefficiente) che viene in mente:

(define (solve iter show)
  (local (s p)
    (for (x 1 iter)
      (for (y x iter)
        (for (z y iter)
          (setq s (+ x y z))
          (setq p (* x y z))
          (if show (println "somma: " s ", prodotto: " p))
          (if (= p s)
              (println x " + " y " + " z " = " x " * " y " * " z " = " s)))))))

Facciamo una prova:

(solve 4 true)
;-> somma: 3, prodotto: 1
;-> somma: 4, prodotto: 2
;-> somma: 5, prodotto: 3
;-> somma: 6, prodotto: 4
;-> somma: 5, prodotto: 4
;-> somma: 6, prodotto: 6
;-> 1 + 2 + 3 = 1 * 2 * 3 = 6
;-> somma: 7, prodotto: 8
;-> somma: 7, prodotto: 9
;-> somma: 8, prodotto: 12
;-> somma: 9, prodotto: 16
;-> somma: 6, prodotto: 8
;-> somma: 7, prodotto: 12
;-> somma: 8, prodotto: 16
;-> somma: 8, prodotto: 18
;-> somma: 9, prodotto: 24
;-> somma: 10, prodotto: 32
;-> somma: 9, prodotto: 27
;-> somma: 10, prodotto: 36
;-> somma: 11, prodotto: 48
;-> somma: 12, prodotto: 64

Soluzione: 1 + 2 + 3 = 1 * 2 * 3 = 6

Sembra anche che questa sia l'unica soluzione in assoluto, perchè la somma di tre numeri positivi qualunque (quando x, y e z sono maggiori di 1) è sempre minore del loro prodotto (intuitivamente).

Vediamo la dimostrazione che 1+2+3=1*2*3=6 è l'unica soluzione.

1) La terna di numeri distinti (1, 2, 3) è una soluzione.
2) Incrementando o decrementando di un'unità un numero qualsiasi di una terna x, y, z, la relativa somma cambia allo stesso modo, invece il suo prodotto cambia almeno di xy, xz oppure yz. Queste quantità sono sempre >= 2, altrimenti la somma non sarebbe uguale al prodotto, contraddicendo l'assunto (se fosse 1, allora -> (1*1)*n = 1+1+n, il che è impossibile). Quindi, questa operazione rende sempre falsa l'equazione.
Siccome aumentando/diminuendo di 1 il generico elemento della terna il prodotto aumenta/diminuisce del prodotto degli altri due (detti y,z), l'unico modo per soddisfare l'uguaglianza 1 = yz ==> y=1 et z=1 (per ipotesi di numeri interi). Quindi tutte e sole le terne per le quali l'uguaglianza è verificata anche aumentando/diminuendo un termine di un'unità sarebbero del tipo (x,1,1). Ma per esse si ha che x+2 = x, il che contrasta l'ipotesi iniziale. Sbaglio?
3) Dalla terna (1, 2, 3) possiamo generare tutte le altre con la medesima operazione, che sappiamo già generare false equivalenze
Questo ragionamento è direttamente estendibile ad equazioni ad N variabili.


-----------------
chatGPT e newLISP
-----------------

Colloquio tra il sottoscritto e l'intelligenza artificiale chatGPT (2023-01-23).

-------------------------------
max:
are you able to write newlisp code?

chatGPT:
Yes, I am able to write newLISP code. newLISP is a Lisp-like programming language that is designed for general-purpose scripting and is often used for web development, artificial intelligence, natural language processing, and other tasks that involve manipulating symbols and lists. If you have a specific task or problem you would like me to help with, I would be happy to assist you.

max:
write a program to solve quadratic equation

chatGPT:
Sure, here is a program in newLISP that will solve a quadratic equation of the form ax^2 + bx + c = 0:

(define (solve-quadratic a b c)
  (let (
    (discriminant (* b b - (* 4 a c)))
    (x1 0)
    (x2 0)
  )
    (cond
      ((= discriminant 0)
        (set 'x1 (/ (- b) (* 2 a)))
        (println "The equation has one real solution: " x1)
      )
      ((> discriminant 0)
        (set 'x1 (/ (+ (- b) (sqrt discriminant)) (* 2 a)))
        (set 'x2 (/ (- (- b) (sqrt discriminant)) (* 2 a)))
        (println "The equation has two real solutions: " x1 " and " x2)
      )
      (else
        (println "The equation has no real solutions.")
      )
    )
  )
)

You can call this function by passing the values of a, b and c as arguments.
For example, to solve the equation x^2 + 2x + 1 = 0, you would call the function like this:

(solve-quadratic 1 2 1)

This will output "The equation has no real solutions."
Alternatively you can use the function like this

(define a 1)
(define b 2)
(define c 1)

(solve-quadratic a b c)
This will also output "The equation has no real solutions."

max:
can you write a program to calculate the complex solution too?

chatGPT:
Sure, here is a newLISP program that will solve a quadratic equation of the form ax^2 + bx + c = 0 and will return the complex solutions if any, otherwise returns the real solutions if any.

(define (solve-quadratic a b c)
  (let (
    (discriminant (* b b - (* 4 a c)))
    (x1 0)
    (x2 0)
  )
    (cond
      ((= discriminant 0)
        (set 'x1 (/ (- b) (* 2 a)))
        (println "The equation has one real solution: " x1)
      )
      ((> discriminant 0)
        (set 'x1 (/ (+ (- b) (sqrt discriminant)) (* 2 a)))
        (set 'x2 (/ (- (- b) (sqrt discriminant)) (* 2 a)))
        (println "The equation has two real solutions: " x1 " and " x2)
      )
      (else
        (set 'x1 (/ (- b) (* 2 a)))
        (set 'x2 (sqrt (/ (- discriminant) (* 4 a))))
        (println "The equation has no real solutions. Instead it has two complex solutions: " x1 "+" x2 "i and " x1 "-" x2 "i")
      )
    )
  )
)
You can call this function by passing the values of a, b and c as arguments.
For example, to solve the equation x^2 + 2x + 1 = 0, you would call the function like this:

(solve-quadratic 1 2 1)

This will output "The equation has no real solutions. Instead it has two complex solutions: -0.5+0.87i and -0.5-0.87i"
Please note that in newLISP the sqrt function returns the square root of a real number

max:
(discriminant (* b b - (* 4 a c))) is wrong. (discriminant (sub (mul b b) (mul 4 a c)))) is correct.

chatGPT:
You are correct, my apologies for the mistake. The correct code for the discriminant should be:

(define (solve-quadratic a b c)
  (let (
    (discriminant (sub (mul b b)  (mul 4 a c)))
    (x1 0)
    (x2 0)
  )
    (cond
      ((= discriminant 0)
        (set 'x1 (/ (- b) (* 2 a)))
        (println "The equation has one real solution: " x1)
      )
      ((> discriminant 0)
        (set 'x1 (/ (+ (- b) (sqrt discriminant)) (* 2 a)))
        (set 'x2 (/ (- (- b) (sqrt discriminant)) (* 2 a)))
        (println "The equation has two real solutions: " x1 " and " x2)
      )
      (else
        (set 'x1 (/ (- b) (* 2 a)))
        (set 'x2 (sqrt (/ (- discriminant) (* 4 a))))
        (println "The equation has no real solutions. Instead it has two complex solutions: " x1 "+" x2 "i and " x1 "-" x2 "i")
      )
    )
  )
)

In this corrected version, I've replaced (* b b - (* 4 a c)) with (sub (mul b b) (mul 4 a c)), which calculates the discriminant correctly.
Thank you for pointing this out, I apologize for any confusion caused by my mistake.

max:
you must use add,sub,div e mul. +,-,/ and * are only for integer

chatGPT:
I apologize for the confusion. In newLISP, mathematical operations must be done using the functions add, sub, div, and mul for addition, subtraction, division and multiplication respectively, not the mathematical operators +, -, /, and * which are only for integers.
Here is the corrected version of the program:

(define (solve-quadratic a b c)
  (let (
    (discriminant (sub (mul b b) (mul 4 a c)))
    (x1 0)
    (x2 0)
  )
    (cond
      ((= discriminant 0)
        (set 'x1 (div (- b) (mul 2 a)))
        (println "The equation has one real solution: " x1)
      )
      ((> discriminant 0)
        (set 'x1 (div (+ (- b) (sqrt discriminant)) (mul 2 a)))
        (set 'x2 (div (- (- b) (sqrt discriminant)) (mul 2 a)))
        (println "The equation has two real solutions: " x1 " and " x2)
      )
      (else
        (set 'x1 (div (- b) (mul 2 a)))
        (set 'x2 (sqrt (div (- discriminant) (mul 4 a))))
        (println "The equation has no real solutions. Instead it has two complex solutions: " x1 "+" x2 "i and " x1 "-" x2 "i")
      )
    )
  )
)

I apologize for any confusion caused by my previous mistake. I hope this clears up any confusion and that the program works as intended.

max:
Use 'add','sub','div' and 'mul' instead of '+', '-', '/' and '*'.

chatGPT:
You are correct, and I apologize for any confusion. In newLISP, mathematical operations must be done using the functions add, sub, div, and mul for addition, subtraction, division and multiplication respectively, not the mathematical operators +, -, /, and *.
Here is the corrected version of the program:

(define (solve-quadratic a b c)
  (let (
    (discriminant (sub (mul b b) (mul 4 a c)))
    (x1 0)
    (x2 0)
  )
    (cond
      ((= discriminant 0)
        (set 'x1 (div (sub 0 b) (mul 2 a)))
        (println "The equation has one real solution: " x1)
      )
      ((> discriminant 0)
        (set 'x1 (div (add (sub 0 b) (sqrt discriminant)) (mul 2 a)))
        (set 'x2 (div (sub (sub 0 b) (sqrt discriminant)) (mul 2 a)))
        (println "The equation has two real solutions: " x1 " and " x2)
      )
      (true
        (set 'x1 (div (sub 0 b) (mul 2 a)))
        (set 'x2 (div (sqrt (sub 0 discriminant)) (mul 4 a)))
        (println "The equation has no real solutions. Instead it has two complex solutions: " x1 " " x2 "i and " x1 " " x2 "i")
      )
    )
  )
)

Again, I apologize for any confusion caused by my previous mistake. I hope this clears up any confusion and that the program works as intended.

(solve-quadratic 1 2 1)
;-> The equation has one real solution: -1

(solve-quadratic -4 -2 -1)
;-> The equation has no real solutions. Instead it has two complex solutions: -0.25 -0.2165063509461097i and -0.25 -0.2165063509461097i
-------------------------------
Divertente...ma ancora non conosce bene newLISP :-)


---------------------
Forum: Context switch
---------------------

alex:
-----
What are reasons, that (context) is switch?
Why (context) is not standart lisp function?
Why we use

(context 'BLA-BLA-BLA)
  ..............
(context 'MAIN)

against

(context 'BLA-BLA-BLA
  ....................
)

Lutz:
-----
When newLISP loads it has a compile and evaluation phase. Each toplevel expression in a file gets at first compiled to an internal representation, then evaluated by an internal VM. Writing contexts in a functional manner, would break the separation of compile versus evaluation phase.

The toplevel (context 'FOO) declaration works like a compiler directive switching to a different name space (symbol tree).

The closure effect of the namespace is established during code translation not during run-time, as is the case i.e. in Scheme.

The way how contexts work went through some changes during the current series of development releases, to give it a more intuitive feel. The change was prompted by the experience working with newLISP in a group of programmers (all new to newLISP) and on a bigger multi-module distributed application.

These are in short the differences:

OLD: the runtime context is always the context where the original toplevel function is called from.
NEW: the runtime context is the context the function is written/compiled in (v.8.7.9):

(set 'x 123)
(context 'CTX)

(set 'x 456)

(define (foo) (context))

(define (bar) (eval-string "x"))

(context 'MAIN)

; OLD
(CTX:foo) => MAIN
(CTX:bar) => 123
; NEW
(CTX:foo)
;-> CTX
(CTX:bar)
;-> 456

OLD: In (load myfile) the code in myfile will be in the runtime context of caller, except when a (context ...) statement in 'myfile' switches it. The context after (load ...) returns may be changed.

NEW: If not specified differently in 'mylfile' myfile will always be translated for MAIN, but when (load ...) returns, the runtime context will always be the same as before the (load ...) statement regardless, of what happened inside 'myfile' (v. 8.7.11)

The changes in the context model only effect 'load', 'eval-string', 'net-eval' and 'sym' (when used without the context parameter). Most of anybody's code will not need changes. In all apps. published by newlisp.org only 'cgi.lsp' has changed.

The newer model seems to be more intuitive and behaves more like people expect it. The newer model also offers a better isolation of the context from the context-environment it is called into from.

These are the differences to other LISPs:
When using contexts for object oriented programming in newLISP all objects have to be bound to a symbol, but context-symbols can be assigned to variables and context-objects can be created and deleted during run-time. In Scheme and most other LISPs the object is defined by a lambda closure duing runtime and can stay anonymous. I believe that namespaces are easier to understand than lambda (static) closures.

Contexts as they appear in the official release 8.8.

=============================================================================

