================

 NOTE LIBERE 13

================

---------------------------------------------------
Moltiplicazione tra matrici - Algoritmo di Strassen
---------------------------------------------------

https://www.geeksforgeeks.org/implementing-strassens-algorithm-in-java/

Complessità temporale: O(n^(ln 7)) = O(n^2.807)

Ipotesi di questa implementazione:
Le matrici devono essere quadrate
Le matrici devono avere la stessa dimensione
La dimensione deve essere una potenza di 2 ((n & (n - 1)) == 0)

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
            (for (k 1 ext)
              (if (!= (matrix i j) (matrix i (+ j k))) (setq equal nil))
            )
            (if equal (push (list i j "e") out -1)))
        )
        ; search left - ovest
        (if (>= (- j ext) 0) (begin
            (setq equal true)
            (for (k 1 ext)
              (if (!= (matrix i j) (matrix i (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "o") out -1)))
        )
        ; search down - sud
        (if (< (+ i ext) rows) (begin
            (setq equal true)
            (for (k 1 ext)
              (if (!= (matrix i j) (matrix (+ i k) j)) (setq equal nil))
            )
            (if equal (push (list i j "s") out -1)))
        )
        ; search up - nord
        (if (>= (- i ext) 0) (begin
            (setq equal true)
            (for (k 1 ext)
              (if (!= (matrix i j) (matrix (- i k) j)) (setq equal nil))
            )
            (if equal (push (list i j "n") out -1)))
        )
        ; search up-right - nord-est
        (if (and (>= (- i ext) 0) (< (+ j ext) cols)) (begin
            (setq equal true)
            (for (k 1 ext)
              (if (!= (matrix i j) (matrix (- i k) (+ j k))) (setq equal nil))
            )
            (if equal (push (list i j "ne") out -1)))
        )
        ; search up-left - nord-ovest
        (if (and (>= (- i ext) 0) (>= (- j ext) 0)) (begin
            (setq equal true)
            (for (k 1 ext)
              (if (!= (matrix i j) (matrix (- i k) (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "no") out -1)))
        )
        ; search down-left - sud-ovest
        (if (and (< (+ i ext) rows) (>= (- j ext) 0)) (begin
            (setq equal true)
            (for (k 1 ext)
              (if (!= (matrix i j) (matrix (+ i k) (- j k))) (setq equal nil))
            )
            (if equal (push (list i j "so") out -1)))
        )
        ; search down-right - sud-est
        (if (and (< (+ i ext) rows) (< (+ j ext) cols)) (begin
            (setq equal true)
            (for (k 1 ext)
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

(straight 1 4 test
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

=============================================================================

