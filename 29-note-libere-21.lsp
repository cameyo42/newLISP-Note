================

 NOTE LIBERE 21

================

  "21 è soltanto mezza verità"

------------------------
I Visir sulla scacchiera
------------------------

Il Visir è un pezzo degli scacchi inventato.
Un Visir può spostarsi da una posizione (x, y) a:

   (x+1, y)
   (x, y+1)
   (x-1, y)
   (x, y-1)

Cioè si muove come la torre, ma solo un passo alla volta come il re.
Quanti Visir possono essere posizionati su una scacchiera NxN in modo che due Visir non si attacchino a vicenda?

Sequenza OEIS A000982:
  0, 1, 2, 5, 8, 13, 18, 25, 32, 41, 50, 61, 72, 85, 98, 113, 128, 145,
  162, 181, 200, 221, 242, 265, 288, 313, 338, 365, 392, 421, 450, 481,
  512, 545, 578, 613, 648, 685, 722, 761, 800, 841, 882, 925, 968, 1013,
  1058, 1105, 1152, 1201, 1250, 1301, 1352, 1405, ...

Su una scacchiera 1x1 può esserci solo 1 Visir:

   +---+
   | V |
   +---+

Su una scacchiera 2x2 possono esserci 2 Visir:

   +---+---+
   | V |   |
   +---+---+
   |   | V |
   +---+---+

Su una scacchiera 3x3 possono esserci 5 Visir:

   +---+---+---+
   | V |   | V |
   +---+---+---+
   |   | V |   |
   +---+---+---+
   | V |   | V |
   +---+---+---+

Matematicamente risulta: visir(N) = ceiling(N^2/2)

(define (visir n) (ceil (div (mul n n) 2)))

(map visir (sequence 0 50))
;-> (0 1 2 5 8 13 18 25 32 41 50 61 72 85 98 113 128 145 162 181 200 221
;->  242 265 288 313 338 365 392 421 450 481 512 545 578 613 648 685 722
;->  761 800 841 882 925 968 1013 1058 1105 1152 1201 1250)

Prova della formula visir(N) = ceiling(N^2/2)
Possiamo sempre posizionare almeno ceil(N^2/2) Visir: basta disporli secondo uno schema a scacchiera.
In una scacchiera NxN, supponendo che la casella in alto a sinistra sia bianca abbiamo:
ceil(N^2/2) caselle bianche e floor(n^2/2) caselle nere.
Se posizioniamo i visir sulle caselle bianche, non ci possono essere due di essi che si attaccano, poiché ogni visir "vede" solo le caselle nere.

Per esempio ecco come vengono posizionati i 25 Visir su una scacchiera 7x7:

(visir 7)
;-> 25

   +---+---+---+---+---+---+---+
   | V |   | V |   | V |   | V |
   +---+---+---+---+---+---+---+
   |   | V |   | V |   | V |   |
   +---+---+---+---+---+---+---+
   | V |   | V |   | V |   | V |
   +---+---+---+---+---+---+---+
   |   | V |   | V |   | V |   |
   +---+---+---+---+---+---+---+
   | V |   | V |   | V |   | V |
   +---+---+---+---+---+---+---+
   |   | V |   | V |   | V |   |
   +---+---+---+---+---+---+---+
   | V |   | V |   | V |   | V |
   +---+---+---+---+---+---+---+

Non possiamo fare di meglio: riempiamo la scacchiera con tessere 2x1, eventualmente utilizzando una tessera 1x1 per l'angolo finale di una scacchiera di lunghezza dispari, in questo modo:

   +-------+-------+-------+---+
   | V     | V     | V     | V |
   +---+---+-------+-------+   |
   |     V |     V |     V |   |
   +-------+-------+-------+---+
   | V     | V     | V     | V |
   +-------+-------+-------+   |
   |     V |     V |     V |   |
   +-------+-------+-------+---+
   | V     | V     | V     | V |
   +-------+-------+-------+   |
   |     V |     V |     V |   |
   +---------------+-------+---+
   | V     | V     | V     | V |
   +-------+-------+-------+---+

Abbiamo bisogno ceil(n^2/2) tessere per coprire la scacchiera.
Chiaramente, non è possibile mettere due Visir sulla stessa tessera.
Quindi ogni tessera può contenere al massimo un Visir, il che significa che non possiamo posizionare più di ceil(n^2/2) Visir sulla scacchiera.

Nota: se al posto del Visir usiamo il Re, allora la tessera deve essere 2x2, quindi in una scacchiera di lato N possiamo mettere floor(NxN/4) Re che non si attaccano a vicenda.


--------------------------
I Cavalli sulla scacchiera
--------------------------

Data una scacchiera NxM trovare il numero massimo di cavalli che possono essere posizionati sulla scacchiera in modo tale che nessun cavallo attacchi un altro cavallo.

Un cavallo attacca nel modo seguente:

   +---+---+---+---+---+
   |   | x |   | x |   |
   +---+---+---+---+---+
   | x |   |   |   | x |
   +---+---+---+---+---+
   |   |   | C |   |   |
   +---+---+---+---+---+
   | x |   |   |   | x |
   +---+---+---+---+---+
   |   | x |   | x |   |
   +---+---+---+---+---+

Il cavallo attacca solo caselle di colore opposto aall casella dove si trova.
Se si trova su una casella bianca, allora attacca solo caselle nere.
Se si trova su una casella nera, allora attacca solo caselle bianche.
Quindi mettendo tutti i cavalli su uno stesso colore otteniamo il numero massimo di cavalli che possono essere posizionati senza che si attacchino a vicenda.

Il numero di caselle bianche o nere di una scacchiera MxN dipende anche dal colore della prima casella in alto a sinistra.
Vediamo qualche esempio suppondendo che la casella in alto a sinistra sia bianca:

2x2: 2 bianche, 2 nere
Bianche = (N*M)/2
   +---+---+
   | B | N |
   +---+---+
   | N | B |
   +---+---+

2x3: 3 bianche, 3 nere
Bianche = (N*M)/2
  +---+---+---+
  | B | N | B |
  +---+---+---+
  | N | B | N |
  +---+---+---+

5x2: 5 bianche, 5 nere
Bianche = (N*M)/2
  +---+---+
  | B | N |
  +---+---+
  | N | B |
  +---+---+
  | B | N |
  +---+---+
  | N | B |
  +---+---+
  | B | N |
  +---+---+

3x3 -> 5 bianche, 4 nere
Bianche = (N*M + 1)/2
  +---+---+---+
  | B | N | B |
  +---+---+---+
  | N | B | N |
  +---+---+---+
  | B | N | B |
  +---+---+---+

3x5 -> 8 bianche, 7 nere
Bianche = (N*M + 1)/2
  +---+---+---+---+---+
  | B | N | B | N | B |
  +---+---+---+---+---+
  | N | B | N | B | N |
  +---+---+---+---+---+
  | B | N | B | N | B |
  +---+---+---+---+---+

Se NxM è pari, metà delle caselle su una scacchiera NxM saranno bianche e l'altra metà sarà nera.
Quindi per NxM pari:
Numero di caselle bianche = (N x M)/2

Se NxM è dispari, ci sarà un quadrato in più e la distribuzione tra bianco e nero non sarà uguale.
Tuttavia, per il numero di quadrati bianchi risulta:
Numero di caselle bianche = (N*M + 1)/2

Quindi la formula per il numero di caselle bianche in una scacchiera NxM è la seguente:

Bianche = (N*M)/2,     se N*M è pari
Bianche = ((N*M)+1)/2, se N*M è dispari

Casi particolari
----------------
Dobbiamo considerare i casi in cui N=1,2 e/o M=1,2.
Vediamo qualche esempio di questi casi:

N=1, M = 5
  +---+---+---+---+---+
  | B | N | B | N | B |
  +---+---+---+---+---+
In questo caso possiamo mettere 5 cavalli nel modo seguente:
  +---+---+---+---+---+
  | C | C | C | C | C |
  +---+---+---+---+---+

N=3, M=1
  +---+
  | B |
  +---+
  | N |
  +---+
  | B |
  +---+
In questo caso possiamo mettere 3 cavalli nel modo seguente:
  +---+
  | C |
  +---+
  | C |
  +---+
  | C |
  +---+

N=2, M=2
  +---+---+
  | B | N |
  +---+---+
  | N | B |
  +---+---+

In questo caso possiamo mettere 4 cavalli nel modo seguente:
  +---+---+
  | C | C |
  +---+---+
  | C | C |
  +---+---+

N=2, M=6
  +---+---+---+---+---+---+
  | B | N | B | N | B | N |
  +---+---+---+---+---+---+
  | N | B | N | B | M | B |
  +---+---+---+---+---+---+

In questo caso possiamo mettere 8 cavalli nel modo seguente:
  +---+---+---+---+---+---+
  | C | C | B | N | C | C |
  +---+---+---+---+---+---+
  | C | C | N | B | C | C |
  +---+---+---+---+---+---+

N=5, M=2
  +---+---+
  | B | N |
  +---+---+
  | N | B |
  +---+---+
  | B | N |
  +---+---+
  | N | B |
  +---+---+
  | B | N |
  +---+---+
In questo caso possiamo mettere 6 cavalli nel modo seguente:
  +---+---+
  | C | C |
  +---+---+
  | C | C |
  +---+---+
  | B | N |
  +---+---+
  | N | B |
  +---+---+
  | C | C |
  +---+---+

In generale abbiamo:

Cavalli = M, se N = 1
Cavalli = N, se M = 1

Cavalli = (int(M/4) * 4),     se N = 2 e M%4 = 0
Cavalli = (int(M/4) * 4) + 2, se N = 2 e M%4 = 1
Cavalli = (int(M/4) * 4) + 4, se N = 2 e M%4 > 1

Cavalli = (int(N/4) * 4),     se M = 2 e N%4 = 0
Cavalli = (int(N/4) * 4) + 2, se M = 2 e N%4 = 1
Cavalli = (int(N/4) * 4) + 4, se M = 2 e N%4 > 1

Adesso possiamo scrivere la funzione finale.

(define (cavalli N M)
  (cond ((or (= N 1) (= M 1)) (max N M)) ; N o M = 1
        ((or (= N 2) (= M 2)) ; N o M = 2
            (cond ((= (% (max N M) 4) 0)
                    (* (/ (max M N) 4) 4))
                  ((= (% (max N M) 4) 1)
                    (+ (* (/ (max M N) 4) 4) 2))
                  ((> (% (max N M) 4) 1)
                  (+ (* (/ (max M N) 4) 4) 4))))
        (true ; N e M > 2
          (if (odd? (* N M))
              (/ (+ (* N M) 1) 2)
              ;else
              (/ (* N M) 2)))))

Proviamo:

(cavalli 8 8)
;-> 32

(cavalli 5 5)
;-> 13

(cavalli 1 1)
;-> 1

(cavalli 2 3)
;-> 4

(cavalli 1 12)
;-> 12


--------------------------------------------------
Livello di annidamento degli elementi di una lista
--------------------------------------------------

In una lista annidata ogni elemento ha un livello di annidamento.
Vediamo un esempio:

  lista = (1 (3 5) (2 (7 8) 9) 6))

  Elemento       Indice
  1              (0)
  (3 5)          (1)
  3              (1 0)
  5              (1 1)
  (2 (7 8) 9)    (2)
  2              (2 0)
  (7 8)          (2 1)
  7              (2 1 0)
  8              (2 1 1)
  9              (2 2)
  6              (3)

  (lst 2) = (2 (7 8) 9)
  (lst '(1 0)) = 3

Il livello di annidamento di un elemento è la lunghezza della lista dei suoi indici meno 1 (perchè elementi non annidati hanno livello 0).

  Elemento       Indice      Annidamento
  1              (0)         0
  (3 5)          (1)         0
  3              (1 0)       1
  5              (1 1)       1
  (2 (7 8) 9)    (2)         0
  2              (2 0)       1
  (7 8)          (2 1)       1
  7              (2 1 0)     2
  8              (2 1 1)     2
  9              (2 2)       1
  6              (3)         0

Possiamo risolvere il problema nel modo seguente:

(define (index-list lst)
"Create a list of indexes for all the elements of a list"
  (ref-all nil lst (fn (x) true)))

(setq lst '(1 (3 5) (2 (7 8) 9) 6))
;-> (1 (3 5) (2 (7 8) 9) 6)

Lista degli indici degli elementi:

(setq idx (index-list lst))
;-> ((0) (1) (1 0) (1 1) (2) (2 0) (2 1) (2 1 0) (2 1 1) (2 2) (3))

Stampa di Elemento - Indice - Annidamento:

(dolist (ind idx) (println (lst ind) { } ind { } (ind (- (length ind) 1))))
;-> 1 (0) 0
;-> (3 5) (1) 1
;-> 3 (1 0) 0
;-> 5 (1 1) 1
;-> (2 (7 8) 9) (2) 2
;-> 2 (2 0) 0
;-> (7 8) (2 1) 1
;-> 7 (2 1 0) 0
;-> 8 (2 1 1) 1
;-> 9 (2 2) 2
;-> 6 (3) 3

Se ci interessano solo gli elementi atomici (in questo caso i numeri interi della lista), allora possiamo scrivere:

(dolist (ind idx)
  (if (atom? (lst ind))
      (println (lst ind) { } ind { } (ind (- (length ind) 1)))))
;-> 1 (0) 0
;-> 3 (1 0) 0
;-> 5 (1 1) 1
;-> 2 (2 0) 0
;-> 7 (2 1 0) 0
;-> 8 (2 1 1) 1
;-> 9 (2 2) 2
;-> 6 (3) 3

Scriviamo una funzione generica che restituisce una lista con elementi del tipo (elemento annidamento):

(define (annidamento lst atom)
  (local (out idx)
    (setq out '())
    (setq idx (ref-all nil lst (fn (x) true)))
    (dolist (ind idx)
      (if atom
          (if (atom? (lst ind))
              (push (list (lst ind) (ind (- (length ind) 1))) out -1))
          ;else
          (push (list (lst ind) (ind (- (length ind) 1))) out -1))
    )
  out))

Proviamo:

(annidamento lst)
;-> ((1 0) ((3 5) 1) (3 0) (5 1) ((2 (7 8) 9) 2) (2 0) ((7 8) 1)
;->  (7 0) (8 1) (9 2) (6 3))

Solo elementi atomici:

(annidamento lst true)
;-> ((1 0) (3 0) (5 1) (2 0) (7 0) (8 1) (9 2) (6 3))

(annidamento '(1 (2 (3 4) 5 (6 7) 1) ((((5 2) 4 (5 2))) 6) 3))
;-> ((1 0) ((2 (3 4) 5 (6 7) 1) 1) (2 0) ((3 4) 1) (3 0) (4 1) (5 2)
;->  ((6 7) 3) (6 0) (7 1) (1 4) (((((5 2) 4 (5 2))) 6) 2)
;->  ((((5 2) 4 (5 2))) 0) (((5 2) 4 (5 2)) 0) ((5 2) 0) (5 0) (2 1)
;->  (4 1) ((5 2) 2) (5 0) (2 1) (6 1) (3 3))

(annidamento '(1 (2 (3 4) 5 (6 7) 1) ((((5 2) 4 (5 2))) 6) 3) true)
;-> ((1 0) (2 0) (3 0) (4 1) (5 2) (6 0) (7 1) (1 4) (5 0)
;->  (2 1) (4 1) (5 0) (2 1) (6 1) (3 3))

Vedi anche "Lista degli indici di una lista" su "Note libere 4".


--------------------
Il tipo intero Int64
--------------------

newLISP gestisce i numeri interi con il tipo Int64 (cioè interi a 64 bit).
L'intervallo dei valori di Int64 è il seguente:

      (valore minimo)      (valore massimo)
da -9223372036854775808 a 9223372036854775807

; Maximum value of int64
(setq MAX-INT 9223372036854775807)

; Minimum value of int64
(setq MIN-INT -9223372036854775808)

Oppure in modo più sicuro:

;; (constant (global 'MIN-INT) -9223372036854775808)
;; (constant (global 'MAX-INT)  9223372036854775807)

Cosa accade quando un operazione genera un numero al di fuori dell'intervallo?

Sottraiamo 1 dal valore minimo:
(- -9223372036854775808 1)
;-> 9223372036854775807 ;valore massimo

Aggiungiamo 1 al valore massimo:
(+ 9223372036854775807 1)
;-> -9223372036854775808 ; valore minimo

Raddoppiamo il valore minimo:
(* -9223372036854775808 2)
;-> 0
Triplichiamo il valore minimo:
(* -9223372036854775808 3)
;-> -9223372036854775808
Quadruplichiamo il valore minimo:
(* -9223372036854775808 4)
;-> 0

Raddoppiamo il valore massimo (+2):
(+ (* 9223372036854775807 2) 2)
;-> 0
Triplichiamo il valore massimo (+2):
(+ (* 9223372036854775807 3) 2)
;-> 9223372036854775807
Triplichiamo il valore massimo (+3):
(+ (* 9223372036854775807 3) 3)
;-> -9223372036854775808
Quaduplichiamo il valore massimo (+4):
(+ (* 9223372036854775807 4) 4)
;-> 0

Quindi i valori formano un circolo chiuso:

-9223372036854775808 ... -1 0 1 ... 9223372036854775807 -9223372036854775808 ... -1 0 1 ... 9223372036854775807


---------------------------------------------------
Massima serie di 1 consecutivi in un numero binario
---------------------------------------------------

Dato un numero intero positivo, dopo averlo trasformarto in binario calcolare:
1) la posizione iniziale della serie con il massimo numero di 1 consecutivi
2) la lunghezza della serie (cioè quanti 1 consecutivi ci sono al massimo).
Se il numero ha più serie della stessa lunghezza, restituire la posizione della prima serie.

La funzione permette di inserire come parametro o il numero intero o una stringa che rappresenta un numero binario.

Primo metodo (tipo RLE-encode):

(char "0")
;-> 38
(char "1")
;-> 49

(define (max-1a num)
  (local (binary idx max-len cur-len)
    ; valore binario
    (if (string? num)
        (setq binary num)
        ;else
        (setq binary (bits num))
    )
    ;(println binary)
    (setq idx nil)
    (setq max-len 0)
    (setq cur-len 0)
    (dostring (b binary)
      (cond ((= b 48) ;"0"
              (if (> cur-len max-len)
                (begin
                  (setq max-len cur-len)
                  (setq idx (- $idx max-len))
                )
              )
              (setq cur-len 0))
            ((= b 49) ; "1"
              (++ cur-len))
      )
    )
    ; controllo se ultima cifra vale "1"
    ; ed è la serie più lunga
    (if (and (= (binary -1) "1") (> cur-len max-len))
      (begin
        (setq max-len cur-len)
        (setq idx (- (length binary) max-len))
      )
    )
    (list idx max-len)))

Proviamo:

(max-1a 123)
;-> 1111011
;-> (0 4)
(max-1a 223)
;-> 11011111
;-> (3 5)
(max-1a 443)
;-> 110111011
;-> (3 3)
(max-1a 113615)
;-> 11011101111001111
;-> (7 4)
(max-1a "11011101111001111")
;-> 11011101111001111
;-> (7 4)
(max-1a 227231)
;-> 110111011110011111
;-> (13 5)
(max-1a 0)
;-> 0
;-> (nil 0)

Secondo metodo: (funzione "parse")

(setq binary (bits 443))
;-> "110111011"
(setq serie (parse binary "0"))
;-> ("11" "111" "11")
(setq len-serie (map length serie))
;-> (2 3 2)
(setq max-len (apply max len-serie))
;-> 3
(setq pattern (dup "1" max-len))
;-> "111"
(find pattern binary)
;-> 3

(define (max-1b num)
  (local (binary max-len idx)
    ; valore binario
    (if (string? num)
        (setq binary num)
        ;else
        (setq binary (bits num))
    )
    ;(println binary)
    (setq max-len (apply max (map length (parse binary "0"))))
    (setq idx (find (dup "1" max-len) binary))
    (list idx max-len)))

Proviamo:

(max-1b 123)
;-> 1111011
;-> (0 4)
(max-1b 223)
;-> 11011111
;-> (3 5)
(max-1b 443)
;-> 110111011
;-> (3 3)
(max-1b 113615)
;-> 11011101111001111
;-> (7 4)
(max-1b 227231)
;-> 110111011110011111
;-> (13 5)
(max-1b "110111011110011111")
;-> 110111011110011111
;-> (13 5)
(max-1b 0)
;-> 0
;-> (nil 0)

Vediamo la velocità della due funzioni:

(setq s1 (join (map string (rand 2 10))))
(setq s2 (join (map string (rand 2 100))))
(setq s3 (join (map string (rand 2 1000))))
(setq s4 (join (map string (rand 2 10000))))

Le funzioni restituiscono gli stessi valori?

(= (max-1a s1) (max-1b s1))
;-> true
(= (max-1a s2) (max-1b s2))
;-> true
(= (max-1a s3) (max-1b s3))
;-> true
(= (max-1a s4) (max-1b s4))
;-> true

(time (max-1a s1) 1e5)
;-> 176.266
(time (max-1b s1) 1e5)
;-> 144.735

(time (max-1a s2) 1e4)
;-> 105.248
(time (max-1b s2) 1e4)
;-> 90.041

(time (max-1a s3) 1e4)
;-> 940.053
(time (max-1b s3) 1e4)
;-> 740.316

(time (max-1a s4) 1e3)
;-> 938.116
(time (max-1b s4) 1e3)
;-> 625.325

La seconda funzione è più veloce.


--------------------
Delta di una matrice
--------------------

Il delta di una lista di numeri interi è la lista ottenuto calcolando le differenze degli elementi consecutivi della lista (il secondo meno il primo, il terzo meno il secondo, il quarto meno il terzo, ecc.).
Per esempio, la lista (1 3 -2 5 -3 6 2) ha la seguente lista delta: (2 -5 7 -8 9 -4).

Analogamente il delta di una matrice di numeri interi è la lista di tutti i delta delle righe e delle colonne della matrice.
Per esempio, calcoliamo il delta della seguente matrice:

   1  6 -3 -6
   4 -4  6 -1
  -7 -1  8  2

Delta righe:

   1  6 -3 -6  -->  (5 -9 -3)
   4 -4  6 -1  -->  (-8 10 -7)
  -7 -1  8  2  -->  (6 9 -6)

Delta colonne (righe della matrice trasposta):

   1  4 -7  -->  (3 -11)
   6 -4 -1  -->  (-10 3)
  -3  6  8  -->  (9 2)
  -6 -1  2  -->  (5 3)

Delta matrice = Unione di tutti i delta (righe e colonne):

  (5 -9 -3 -8 10 -7 6 9 -6 3 -11 -10 3 9 2 5 3)

(define (delta-matrix matrix)
  (let ( (delta '()) (transposed (transpose matrix)) )
    ; crea il delta delle righe della matrice
    (dolist (row matrix)
      ;(println (map - (rest row) (chop row)))
      (extend delta (map - (rest row) (chop row)))
    )
    ; crea il delta delle colonne della matrice
    ; (righe della matrice trasposta)
    (dolist (row transposed)
      ;(println (map - (rest row) (chop row)))
      (extend delta (map - (rest row) (chop row)))
    )
    delta))

Proviamo:

(delta-matrix m)
;-> (5 -9 -3 -8 10 -7 6 9 -6 3 -11 -10 3 9 2 5 3)

(setq a '(( 1  2  3  4)
          ( 5  6  7  8)
          ( 9 10 11 12)
          (13 14 15 16)))

(delta-matrix a)
;-> (1 1 1 1 1 1 1 1 1 1 1 1 4 4 4 4 4 4 4 4 4 4 4 4)


------------
Parole Forti
------------

Le parole Forti (strong) sono parole in cui ogni consonante (BCDFGHJKLMNPQRSTVWXYZ) è seguita da una vocale (AEIOU).
Se la parola non contiene alcuna consonante, è una parola forte.
Praticamente abbiamo un automa a stati finiti con la seguente rappresentazione:

   +--------+
   |        |
   +--->+--------+       +------------+
        | Vocale |------>| Consonante |
   +--->+--------+       +-----+------+
   |                           |
   +---------------------------+

Da una vocale possiamo passare ad un vocale o ad una consonante
Da una consonante possiamo passare solo ad una vocale.

Poniamo stato = 0 se abbiamo letto una vocale e stato = 1 se abbiamo letto una consonante.
Se dallo stato = 1 passiamo ad uno stato = 1, allora la parola non è Forte.

(setq conso '("B" "C" "D" "F" "G" "H" "J" "K" "L" "M" "N" "P" "Q" "R" "S" "T" "V" "W" "X" "Y" "Z"))
(setq vowel '("A" "E" "I" "O" "U"))

(define (conso? ch) (if (find ch conso) true nil))
(define (vowel? ch) (if (find ch vowel) true nil))

(define (strong? word)
  (local (stato stop)
    (setq stop nil)
    (setq stato 0) ; 0 = vocale, 1 = consonante
    (dolist (ch (explode word) stop)
      (cond ((vowel? ch) ; vocale
              (setq stato 0))
            ((conso? ch) ; consonante
              ; se prima avevamo una consonante (stato = 1),
              ; allora la parola non è 'strong'
              (if (= stato 1) (setq stop true))
              (setq stato 1))
      )
    )
    ; se la parola termina con una consonante, allora non è 'strong'.
    (if (= stato 1) nil (not stop))))

Proviamo:

(strong? "NEWLISP")
;-> nil
(strong? "LOVE")
;-> true
(strong? "BEST")
;-> nil
(strong? "EVA")
;-> true
(strong? "YOU")
;-> true
(strong? "GIOVANE")
;-> true
(strong? "AEIOU")
;-> true
(strong? "BABILONIA")

Versione ridotta:

(define (strong? word)
  (local (stato stop)
    (setq stop nil)
    (setq stato 0) ; 0 = vocale, 1 = consonante
    (dolist (ch (explode word) stop)
      (cond ((ref ch '("A" "E" "I" "O" "U"))
              (setq stato 0))
            (true
              (if (= stato 1) (setq stop true))
              (setq stato 1))
      )
    )
    ; se la parola termina con una consonante, allora non è 'strong'.
    (if (= stato 1) nil (not stop))))

Proviamo:

(strong? "NEWLISP")
;-> nil
(strong? "LOVE")
;-> true
(strong? "BEST")
;-> nil
(strong? "EVA")
;-> true
(strong? "YOU")
;-> true
(strong? "GIOVANE")
;-> true
(strong? "AEIOU")
;-> true
(strong? "BABILONIA")
;-> true


------------------
Numeri primi forti
------------------

Un numero primo è definito forte se è maggiore della media aritmetica tra il numero primo immediatamente successivo e il numero primo immediatamente precedente.
In altri termini, è un numero più prossimo al suo numero primo successivo che al suo precedente.
In formule:

  p(n) è forte se p(n) > (p(n-1) + p(n+1))/2

Sequenza OEIS A051634:
Strong primes: prime(k) > (prime(k-1) + prime(k+1))/2
  11, 17, 29, 37, 41, 59, 67, 71, 79, 97, 101, 107, 127, 137, 149, 163,
  179, 191, 197, 223, 227, 239, 251, 269, 277, 281, 307, 311, 331, 347,
  367, 379, 397, 419, 431, 439, 457, 461, 479, 487, 499, 521, 541, 557,
  569, 587, 599, 613, 617, 631, 641, 659, 673, 701, ...

(define (primes-to num)
"Generates all prime numbers less than or equal to a given number"
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let ((lst '(2)) (arr (array (+ num 1))))
          (for (x 3 num 2)
            (when (not (arr x))
              (push x lst -1)
              (for (y (* x x) num (* 2 x) (> y num))
                (setf (arr y) true)))) lst))))

Funzione che calcola i primi forti fino ad un dato limite:

(define (primi-forti limite)
  (setq out '())
  (setq primi (primes-to (+ limite 1)))
  (setq len (length primi))
  (setq primi (array len primi))
  (for (i 1 (- len 2))
    (setq media (/ (+ (primi (- i 1)) (primi (+ i 1))) 2))
    (if (> (primi i) media) (push (primi i) out -1))
  )
  out)

Proviamo:

(primi-forti 100)
;-> (11 17 29 37 41 59 67 71 79 97)

(primi-forti 1000)
;-> (11 17 29 37 41 59 67 71 79 97 101 107 127 137 149 163 179 191 197
;->  223 227 239 251 269 277 281 307 311 331 347 367 379 397 419 431 439
;->  457 461 479 487 499 521 541 557 569 587 599 613 617 631 641 659 673
;->  701 719 727 739 751 757 769 787 809 821 827 853 857 877 881 907 929
;->  937 967 991)

Vediamo la velocità:

(time (primi-forti 1e6))
;-> 163.405
(time (primi-forti 1e7))
;-> 1841.35

Adesso vediamo una funzione che verifica se un numero è un numero primo forte:

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che calcola il primo precedente ad un dato numero:

(define (previous-prime num) (until (prime? (-- num))) num)

Funzione che calcola il primo successivo ad un dato numero:

(define (next-prime num) (until (prime? (++ num))) num)

Funzione che verifica se un numero è un numero primo forte:

(define (forte? num)
  (and (prime? num)
       (> num (/ (+ (previous-prime num) (next-prime num)) 2))))

Proviamo:

(forte? 11)
;-> true

(forte? 19)
;-> nil

(filter forte? (sequence 3 1000))
;-> (11 17 29 37 41 59 67 71 79 97 101 107 127 137 149 163 179 191 197
;->  223 227 239 251 269 277 281 307 311 331 347 367 379 397 419 431 439
;->  457 461 479 487 499 521 541 557 569 587 599 613 617 631 641 659 673
;->  701 719 727 739 751 757 769 787 809 821 827 853 857 877 881 907 929
;->  937 967 991)

Vediamo la velocità:

(time (filter forte? (sequence 3 1e6)))
;-> 2475.158
(time (filter forte? (sequence 3 1e7)))
;-> 51663.436


------------------------------------------------------
Ordinamento di punti 3D in base alla distanza euclidea
------------------------------------------------------

Dati una lista di punti in 3D e un punto P in 3D, scrivere una funzione che restituisce una lista ordinata delle distanze (crescenti) dei punti della lista dal punto P.

Per esempio,
lista = (0 0 0) (-2 3 5) (3 2 4)
P = (1 1 1)
Output:
(1.732051 (0 0 0))   ; il punto (0 0 0) dista 1.732051 dal punto (1 1 1)
(3.741657 (3 2 4))   ; il punto (3 2 4) dista 3.741657 dal punto (1 1 1)
(5.385165 (-2 3 5))) ; il punto (-2 3 5) dista 5.385165 dal punto (1 1 1)

(define (dist3d p1 p2)
"Calculates 3D Cartesian distance of two points P1=(x1 y1 z1) e P2=(x2 y2 z2)"
  (let ( (x1 (p1 0)) (y1 (p1 1)) (z1 (p1 2))
         (x2 (p2 0)) (y2 (p2 1)) (z2 (p2 2)) )
    (sqrt (add (mul (sub x1 x2) (sub x1 x2))
               (mul (sub y1 y2) (sub y1 y2))
               (mul (sub z1 z2) (sub z1 z2))))))

Funzione che ordina i punti di una lista in base alla distanza da un punto P:

(define (dist-points pt points)
  (sort (map list
            (map (curry dist3d pt) points)
            points)))

Proviamo:

(setq lst '((0 0 0) (-2 3 5) (3 2 4)))
(setq p '(1 1 1))
(dist-points p lst)
;-> ((1.732050807568877 (0 0 0))
;->  (3.741657386773941 (3 2 4))
;->  (5.385164807134504 (-2 3 5)))

(setq lst '((3 0 4) (5 0 3) (0 2 4) (0 3 5) (4 2 1) (2 2 2) (3 1 2) (3 1 0)))
(setq p '(2 3 3))
(dist-points p lst)
;-> ((1.414213562373095 (2 2 2))
;->  (2.449489742783178 (0 2 4))
;->  (2.449489742783178 (3 1 2))
;->  (2.82842712474619 (0 3 5))
;->  (3 (4 2 1))
;->  (3.3166247903554 (3 0 4))
;->  (3.741657386773941 (3 1 0))
;->  (4.242640687119285 (5 0 3)))


---------------
Primi di Satana
---------------

Un primo di Satana è un numero primo che contiene le cifre "666".

(define (primes-to num)
"Generates all prime numbers less than or equal to a given number"
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let ((lst '(2)) (arr (array (+ num 1))))
          (for (x 3 num 2)
            (when (not (arr x))
              (push x lst -1)
              (for (y (* x x) num (* 2 x) (> y num))
                (setf (arr y) true)))) lst))))

(define (satan limite)
  (local (out primi)
    (setq out '())
    (setq primi (primes-to limite))
    (dolist (p primi)
      (if (find "666" (string p)) (push p out -1))
    )
    out))

Proviamo:

(satan 1e4)
;-> (6661)

(satan 1e5)
;-> (6661 16661 26669 46663 56663 66601 66617 66629 66643 66653
;->  66683 66697 76667 96661 96667)

(length (satan 1e6))
;-> 214

(time (println (length (satan 1e7))))
;-> 2432
;-> 2351.071


----------------
Liste divisibili
----------------

Date due liste A e B della stessa lunghezza, possiamo dire che la lista A è divisibile dalla lista B se A(i) è divisibile esattamente per B(i) per ogni indice i.
Inoltre la lista A è potenzialmente divisibile se esiste una permutazione degli elementi di B, tale che A(i) è divisibile esattamente per B(i) per ogni indice i.
Per esempio:
  A = (45 12 15)
  B = (5 4 9)
La lista A non è divisibile per B (45/5=9, 12/4=3, 15/9=).
La lista A è potenzialmente divisibile per B con la permutazione (9 4 5), infatti (45/9=5, 12/4=3, 15/5=3).

Nota: se la lista B contiene 0, allora A non può essere divisibile per nessuna permutazione di B.

(define (perm lst)
"Generates all permutations without repeating from a list of items"
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    ; aggiungiamo la lista iniziale alla soluzione
    (setq out (list lst))
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i))
            )
            ;(println lst);
            (push lst out -1)
            (++ (indici i))
            (setq i 0)
          )
          (begin
            (setf (indici i) 0)
            (++ i)
          )
       )
    )
    out))

Funzione che verifica se una lista lst1 è divisibile per un'altra lista lst2:

(define (divisible lst1 lst2)
  (cond ((!= (length lst1) (length lst2)) nil)
        ((find 0 lst2) nil)
        (true
          (let (divide true)
            ; ciclo per ogni elemento
            (dolist (a lst1 (not divide))
              ; se gli elementi correnti delle due liste non sono divisibili,
              ; allora 'divide' vale nil e il ciclo si ferma.
              (if (!= (% a (lst2 $idx)) 0) (setq divide nil))
            )
            divide))))

Proviamo:

(divisible '(12 34 21) '(2 17 3))
;-> true

(divisible '(1 2 3) '(1 2 3 4))
;-> nil

(divisible '(2 8 12) '(2 0 12))
;-> nil

(divisible '(3 32 21 4) '(4 3 2 7))
;-> nil

Funzione che verifica se una lista lst1 è potenzialmente divisibile per un'altra lista lst2:

(define (divisible-perm lst1 lst2)
  (cond ((!= (length lst1) (length lst2)) nil)
        ((find 0 lst2) nil)
        (true
          (let ( (permute (perm lst2)) (divide true) (trovato nil) (sol '()) )
            ; ciclo per ogni permutazione
            (dolist (p permute trovato)
              ; verifica se la prima lista è divisibile
              ; per la permutazione corrente
              (setq divide true)
              (dolist (a lst1 (not divide))
                (if (!= (% a (p $idx)) 0) (setq divide nil))
              )
              ; se è divisibile, allora abbiamo trovato la soluzione
              (if divide (set 'trovato true 'sol p))
            )
            (list trovato sol)))))

Proviamo:

(divisible-perm '(12 34 21) '(3 2 17))
;-> (true (2 17 3))

(divisible-perm '(3 32 21 4) '(4 3 7 2))
;-> true (3 4 7 2)

(divisible-perm '(1 2 3 4 5 6) '(6 5 4 3 2 1))
;-> (true '(1 2 3 4 5 6))


---------------------------
Phi-fattoriale di un numero
---------------------------

Il "phi-fattoriale" (phi-torial o phi-factorial) di un numero n, indicato come phi(n)! consiste nel prendere il prodotto di tutti i tozienti (valori della funzione totiente di Eulero) da 1 a n.
La funzione toziente, chiamata phi(n), calcola il numero degli interi positivi inferiori a quelli coprimi con n.
La formula per il phi-torial è la seguente:

  phi(1) = 1
  phi(n)! = phi(1) * phi(2) * ... * phi(n), per n > 1

Sequenza OEIS A001783:
phi-torial of n: Product k, 1 <= k <= n, k relatively prime to n
  1, 1, 2, 3, 24, 5, 720, 105, 2240, 189, 3628800, 385, 479001600, 19305,
  896896, 2027025, 20922789888000, 85085, 6402373705728000, 8729721,
  47297536000, 1249937325, 1124000727777607680000, 37182145,
  41363226782215962624, 608142583125, 1524503639859200000, ...

Funzione che calcola il phi-fattoriale di un numero:

(define (phi-torial num)
  (cond ((= num 1) 1)
        (true
          (let (coprimi (filter (fn(x) (= (gcd x num) 1)) (sequence 1 num)))
            (apply * coprimi)))))

Proviamo:

(phi-torial 1)
;-> 1
(phi-torial 10)
;-> 189

(map phi-torial (sequence 1 20))
;-> (1 1 2 3 24 5 720 105 2240 189 3628800 385 479001600 19305 896896
;->  2027025 20922789888000 85085 6402373705728000 8729721)

Comunque con num=25 il risultato supera il tipo Int64 e bisogna utilizzare i big-integer:

(phi-torial 25)
;-> 4469738634796859392 ; risultato errato
Risultato corretto: 41363226782215962624

Funzione che calcola il phi-fattoriale (big-integer) di un numero:

(define (phi-torial num)
  (cond ((= num 1) 1)
        (true
          (let (coprimi (filter (fn(x) (= (gcd x num) 1)) (sequence 1 num)))
            (apply * (map bigint coprimi))))))

Proviamo:

(phi-torial 25)
;-> 41363226782215962624L

(map phi-torial (sequence 1 30))
;-> (1 1L 2L 3L 24L 5L 720L 105L 2240L 189L 3628800L 385L 479001600L 19305L
;->  896896L 2027025L 20922789888000L 85085L 6402373705728000L 8729721L
;->  47297536000L 1249937325L 1124000727777607680000L 37182145L
;->  41363226782215962624L 608142583125L 1524503639859200000L 1452095555625L
;->  304888344611713860501504000000L 215656441L)


-----------------------------
Radici primitive di un numero
-----------------------------

Una radice primitiva di un numero n è un intero g tale che le potenze di g modulo n generano tutti i numeri da 1 a n−1.
Un numero n ha una radice primitiva se non esiste un intero x dove 1 < x < n-1 e (x^2 mod n) = 1.

Sequenza OEIS A033948:
Numbers that have a primitive root (the multiplicative group modulo n is cyclic)
  1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 13, 14, 17, 18, 19, 22, 23, 25, 26, 27,
  29, 31, 34, 37, 38, 41, 43, 46, 47, 49, 50, 53, 54, 58, 59, 61, 62, 67,
  71, 73, 74, 79, 81, 82, 83, 86, 89, 94, 97, 98, 101, 103, 106, 107, 109,
  113, 118, 121, 122, 125, 127, 131, 134, 137, 139, ...

Funzione che verifica se un numero dato ha una radice primitiva:

(define (primit num)
  (cond ((< num 4) true)
        (true
          (let (radice true)
            (for (x 2 (- num 2) 1 (not radice))
              (if (= (% (* x x) num) 1) (setq radice nil))
            )
            radice))))

(filter primit (sequence 1 40))
;-> (1 2 3 4 5 6 7 9 10 11 13 14 17 18 19 22 23 25 26 27 29 31 34 37 38)

Vediamo una funzione più compatta che usa la funzione "for-all":

Funzione che verifica se un numero dato ha una radice primitiva:

(define (primitive num)
  (if(< num 4)
    true
    ;else
    (for-all (fn(x) (!= (% (* x x) num) 1)) (sequence 2 (- num 2)))))

(filter primitive (sequence 1 40))
;-> (1 2 3 4 5 6 7 9 10 11 13 14 17 18 19 22 23 25 26 27 29 31 34 37 38)

Il calcolo delle radici primitive implica trovare un generatore del gruppo moltiplicativo di interi modulo n.

Trovare le radici primitive per i numeri non primi è più complesso.
In generale, potrebbe non esserci una radice primitiva per ogni modulo non primo e l'esistenza di radici primitive dipende dalla fattorizzazione del modulo.
Per un modulo composito n, possiamo trovare radici primitive se e solo se n è della forma 2 o 4 o p^k o 2*p^k dove p è un numero primo dispari.
Ignoriamo i casi espliciti 2 e 4.
Quindi possiamo dire che:
Se g è una radice primitiva modulo p, allora g è una radice primitiva modulo tutte le potenze p^k, a meno che g^(p-1) ≡ 1 (mod p^2).
Nel caso g^(p-1) ≡ 1 (mod p^2) abbiamo che g+p è radice primitiva.
Il problema si riduce quindi a quello dei numeri primi.

Per calcolare le radici primitive di un numero primo vedi "Radici primitive di un numero primo" su "Note libere 6".

Funzione di base per calcolare le radici primitive di un numero (non primo):
Nota: trovare radici primitive per moduli non primi è più complesso e potrebbe non essere sempre possibile.
Il codice seguente fattorizza il modulo e quindi tenta di trovare una radice primitiva basata su tali fattori.
Non vengono verificate le proprietà specifiche del modulo prima di applicare tale algoritmo (cioè non viene controllato se il numero vale p^k o 2*p^k (con p primo dispari))

(define (primitive-root? g num fattori)
  (for-all (fn(x) (!= (% (pow g (/ num x)) num) 1)) fattori))

(define (primitive-root num)
  (cond ((= num 2) 1)
        ((= num 4) 3)
        (true
          (let ( (fattori (factor num)) (sol nil) )
            (for (g 2 (- num 1) 1 sol)
              (if (primitive-root? g num fattori) (setq sol g))
            )
            sol))))

Proviamo:

(primitive-root (pow 3 3))
;-> 2
(primitive-root (pow 7 4))
;-> 2

Comunque non sono molto sicuro sulla correttezza di questa funzione.


---------------------------------
Quozienti di Wilson generalizzati
---------------------------------

Dato un intero positivo n, calcolare il quoziente di Wilson generalizzato W(n):

         Prod[i=1..n]i (se mcd(i,n)=1) + e
  W(n)= -----------------------------------
                         n

dove e(n) = +1 se n = 1, 2, 4, p^k o 2p^k, dove p è un numero primo dispari e k > 0, altrimenti e = -1.

Sequenza OEIS A157249:
Generalized Wilson quotients (or Wilson quotients for composite moduli)
  2, 1, 1, 1, 5, 1, 103, 13, 249, 19, 329891, 32, 36846277, 1379, 59793,
  126689, 1230752346353, 4727, 336967037143579, 436486, 2252263619,
  56815333, 48869596859895986087, 1549256, 1654529071288638505, ...

Algoritmo
1) Filtrare tutti i coprimi (gcd(i,n)=1) nell'intervallo [1..n],
2) calcolare il loro prodotto
3) aumentare questo prodotto di 1
4) dividere questa somma per n

Perchè 'e' non viene calcolato?
Poichè bisogna dividere per n, quando risulta e=-1, il risultato della divisione è lo stesso anche con e=1.

Vediamo se questo è vero:

Funzione di Wilson con e=-1:

(define (w-1 num)
  (setq coprimi (filter (fn(x) (= (gcd x num) 1)) (sequence 1 num)))
  (setq prodotto (apply * coprimi))
  (setq a (+ prodotto -1))
  (/ a num))

(map w-1 (sequence 1 15))
;-> (0 0 0 0 4 0 102 13 248 18 329890 32 36846276 1378 59793)

Funzione di Wilson con e=+1:

(define (w+1 num)
  (setq coprimi (filter (fn(x) (= (gcd x num) 1)) (sequence 1 num)))
  (setq prodotto (apply * coprimi))
  (setq a (+ prodotto 1))
  (/ a num))

(map w+1 (sequence 1 15))
;-> (2 1 1 1 5 1 103 13 249 19 329891 32 36846277 1379 59793)

Vedi anche "Radici primitive di un numero primo" su "Note libere 6".
Vedi anche "Radici primitive di un numero" su "Note libere 21".


---------------------------------------
Perimetro e area di un n-agono regolare
---------------------------------------

Formule per il calcolo del perimetro e dell'area di un n-agono regolare.

  Perimetro = 2*n*r*sin(pi/n)
  Area = (1/2)*n*r^2*sin(2*pi/n)

  dove r è il raggio del cerchio che circoscrive l'n-agono.

  Perimetro = n*s
  Area = (n*s*a)/2 = (Perimetro*a)/2
  dove s è la lunghezza del lato dell'n-agono,
       a è la lunghezza dell'apotema

L'apotema 'a' è il raggio del cerchio inscritto all'n-agono:

  a = s/(2*tan(pi/n))

(setq pi 3.1415926535897931)
(define (apotema n s) (div s (mul 2 (tan (div pi n)))))

Proviamo con s=1 (otteniamo i 'numeri fissi' dei vari n-agoni):

(apo 3 1)
;-> 0.288675134594813
(apo 4 1)
;-> 0.5000000000000001
(apo 5 1)
;-> 0.6881909602355869
(apo 6 1)
;-> 0.8660254037844387
(apo 7 1)
;-> 1.038260698286168
(apo 8 1)
;-> 1.207106781186548
(apo 9 1)
;-> 1.373738709727311
(apo 10 1)
;-> 1.538841768587627


------------
Torna a casa
------------

Per giocare a "Torna a casa" occorre una scacchiera e un unico pezzo.
L'unico pezzo viene mosso da entrambi i giocatori a turno.
Ad ogni turno un giocatore deve effettuare una delle seguenti mosse:

  n caselle in alto oppure
  n caselle a sinistra oppure
  n caselle in alto e a sinistra (diagonale da dx a sx)

Vince la partita il giocatore che posiziona il pezzo nell'angolo in alto a sinistra della scacchiera.
Nella seguente figura la posizione (0,0) della X è la casella da raggiungere.

      0   1   2   3   4   5   6   7
    +---+---+---+---+---+---+---+---+
  0 | X |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+
  1 |   |   | P |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+
  2 |   | P |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+
  3 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+
  4 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+
  5 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+
  6 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+
  7 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+

Le caselle che contengono P sono "caselle perdenti".
Una casella perdente è una casella da cui il giocatore che ha il turno sarà costretto a fare una mossa consentendo all'avversario di forzare la vittoria.
Per esempio,

      0   1   2
    +---+---+---+
  0 | X | 0 | 0 |
    +---+---+---+
  1 | 0 | 0 | P |
    +---+---+---+
  2 | 0 | P | 0 |
    +---+---+---+

Dalla casella P (1,2) o (2,1) un giocatore può spostare il pezzo solo nelle caselle 0.
In questo modo permette all'avversario di raggiungere la casella X (0,0) con la prossima mossa.
Da una casella perdente non è possibile arrivare ad un'altra casella perdente.

Nota: la casella è 'perdente' per il giocatore che deve muovere da quella casella, quindi chi arriva con la propria mossa su una casella perdente ha la vittoria assicurata (se continua a giocare in modo ottimo).

Matematicamente si può dimostrare che tutte le caselle perdenti giacciono su due linee rette radianti e sono un'approssimazione razionale di Phi = (sqrt(5)+1)/2.
Questo comporta che una casella è perdente se risulta:

  floor(abs(r - c)*phi) = min(r,c)

dove r = righe della matrice
     c = colonne della matrice
     phi = (1 + sqrt(5))/2 (Golden Ratio)

(setq phi (div (add 1 (sqrt 5)) 2))
;-> 1.618033988749895

(define (perdente x y) (= (min x y) (floor (mul (abs (- x y)) phi))))

(perdente 2 1)
;-> true
(perdente 1 2)
;-> true
(perdente 0 0)
;-> true
(perdente 2 2)
;-> nil

Funzione che stampa le caselle perdenti di una scacchiera con dimensione data:

(define (torna size)
  (setq board (array size size '(".")))
  (for (r 0 (- size 1))
    (for (c 0 (- size 1))
      (if (perdente r c) (setf (board r c) "P"))))
  (for (r 0 (- size 1))
    (for (c 0 (- size 1))
      (print (board r c) { }))
    (println)))

Proviamo:

(torna 8)
;-> P . . . . . . .
;-> . . P . . . . .
;-> . P . . . . . .
;-> . . . . . P . .
;-> . . . . . . . P
;-> . . . P . . . .
;-> . . . . . . . .
;-> . . . . P . . .

(torna 36)
;-> P . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . P . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . P . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . P . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . P . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . P . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . P . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . P . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . P . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . P . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . P . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . P . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . P . . . . . . . . . . . . . . .
;-> . . . . . . . . P . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . P . . . . . . . . . . . .
;-> . . . . . . . . . P . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . P . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . P . . . . . . .
;-> . . . . . . . . . . . P . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . P . . . .
;-> . . . . . . . . . . . . P . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . P .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . P . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . P . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . P . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . P . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . P . . . . . . . . . . . . . .
;-> . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .


------------------------------
Percorso minimo in una matrice
------------------------------

Data una matrice MxN composta da numeri interi, restituire il percorso con la somma minima partendo dall'elemento in alto a sinistra (0,0) e arrivando a quello in basso a destra (M-1,N-1).
È possibile muoversi verticalmente, orizzontalmente e diagonalmente, cioè è possibile spostarsi su/giù, destra/sinistra e in diagonale.

Algoritmo:
Usiamo la programmazione dinamica per riempire una matrice 'dp' e calcolare la somma minima del percorso considerando i valori degli elementi vicini.
Manteniamo una matrice separata per il percorso in cui ogni cella contiene il percorso che porta a quella particolare cella con la somma minima.
Il percorso minimo finale si trova nella cella in basso a destra della matrice del percorso.

(define (min-path matrix)
  (setq rows (length matrix))
  (setq cols (length (matrix 0)))
  ; Crea una matrice dp per memorizzare le somme minime dei percorsi
  (setq dp (array rows cols '(0)))
  ; Crea una matrice path per memorizzare il percorso
  (setq path (array rows cols '(0)))
  (setf (dp 0 0) (matrix 0 0))
  (setf (path 0 0) "00")
  ; Inizializza la prima riga
  (for (i 1 (- cols 1))
    (setf (dp 0 i) (+ (dp 0 (- i 1)) (matrix 0 i)))
    (setf (path 0 i) (string "00" i))
  )
  ; Inizializza la prima colonna
  (for (i 1 (- rows 1))
    (setf (dp i 0) (+ (dp (- i 1) 0) (matrix i 0)))
    (setf (path i 0) (string i "00"))
  )
  ; Riempie il resto delle matrici dp e path
  (for (i 1 (- rows 1))
    (for (j 1 (- cols 1))
      (setq left (dp i (- j 1)))
      (setq up (dp (- i 1) j))
      (setq diagonal (dp (- i 1) (- j 1)))
      (setq min-vicino (min left up diagonal))
      (setf (dp i j) (+ (matrix i j) min-vicino))
      (cond ((= min-vicino left)
              (setf (path i j) (string (path i (- j 1)) i j)))
            ((= min-vicino up)
              (setf (path i j) (string (path (- i 1) j) i j)))
            ((= min-vicino diagonal)
              (setf (path i j) (string (path (- i 1) (- j 1)) i j)))
      )
    )
  )
  ; L'elemento in basso a destra della matrice dp contiene la somma minima del percorso
  ; L'elemento in basso a destra della matrice del percorso contiene il percorso
  (list (dp (- rows 1) (- cols 1))
        (explode (path (- rows 1) (- cols 1)) 2)))

Facciamo qualche prova:

(setq m '((1 3 1 -1)
          (2 2 1 -2)
          (5 0 2 -2)))
(min-path m)
;-> (0 ("00" "11" "12" "13" "23"))

(setq m '(( 1    9    7    3   10    2    2)
          (10    4    1    1    1    7    8)
          ( 3    6    3    8    9    5    7)
          ( 8   10    2    5    2    1    4)
          ( 5    1    1    3    6    7    9)))
(min-path m)
;-> (23 ("00" "11" "12" "13" "14" "25" "35" "46"))

(setq m '(( 5    8    7    2    4)
          (12   10   -2    2    2)
          ( 9    4   -2    9    5)
          ( 7    4   -2    1   12)
          ( 1    2    3    4    4)))
(min-path m)
;-> (12 ("00" "11" "22" "23" "23" "34" "4"))


----------------------
Lista delle differenze
----------------------

Data la lista delle differenze di una lista, ricostruire la lista originale.

Per esempio,
  lista originale = (2 4 -2 5 3)
  lista di differenze = (2 -6 7 -2)

Per ricostruire la lista delle differenze occorre sapere il valore del primo valore della lista originale, altrimenti possiamo solo creare una lista generica che produce la lista delle differenze data.
Se non conosciamo il primo valore della lista originale possiamo impostarlo ad un valore a piacere (ad esempio 1) e poi costruire la lista nel modo seguente:

  lst(0) = 1 (valore a piacere)
  lst(i) = lst(i-1) + diff(i)

Nell'esempio:
  primo valore = 1
  secondo valore = 1 + 2 = 3
  terzo valore = 3 + (-6) = -3
  quarto valore = -3 + 7 = 4
  quinto valore = 4 + (-2) = 2

lista (non) originale = (1 3 -3 4 2)

(define (original diff val)
  (local (cur out))
    (setq cur (or val 1))
    (setq out (list cur))
    (dolist (d diff)
      (setq cur (+ cur d))
      (push cur out -1)
    )
    out)

Proviamo:

(setq originale '(2 4 -2 5 3))
(setq diff '(2 -6 7 -2))

Senza il primo valore della lista originale:
(original diff)
;-> (1 3 -3 4 2)

Con il primo valore della lista originale:
(original diff 2)
;-> (2 4 -2 5 3)

Se vogliamo calcolare la lista delle differenze di una lista possiamo usare la seguente espressione:

(setq lst originale)
(map - (rest lst) (chop lst))
;-> (2 -6 7 -2)

Versione compatta della funzione "originale":

(define (original diff val)
    (let (cur (or val 1))
      (push (or val 1) (map (fn(x) (++ cur x)) diff))))

(original diff)
;-> (1 3 -3 4 2)

(original diff 2)
;-> (2 4 -2 5 3)


------------------------------
Coppie di interi di Ruth-Aaron
------------------------------

Una coppia Ruth-Aaron è una coppia di interi positivi consecutivi n e n+1 tali che la somma dei fattori primi (contando i fattori primi ripetuti) di ciascun intero sia uguale.
Ad esempio, 714 e 715 formano una coppia Ruth-Aaron, poiché:
  714 = 2*3*7*17, 715 = 5*11*13 e 2+3+7+17 = 5+11+13 = 29

Sequenza OEIS A039752:
 Ruth-Aaron numbers (2): sum of prime divisors of n = sum of prime divisors of n+1 (both taken with multiplicity)
  5, 8, 15, 77, 125, 714, 948, 1330, 1520, 1862, 2491, 3248, 4185, 4191,
  5405, 5560, 5959, 6867, 8280, 8463, 10647, 12351, 14587, 16932, 17080,
  18490, 20450, 24895, 26642, 26649, 28448, 28809, 33019, 37828, 37881,
  41261, 42624, 43215, 44831, 44891, 47544, 49240, ...

(factor 714)
;-> (2 3 7 17)
(factor 715)
;-> (5 11 13)
(apply + (factor 714))
;-> 29
(apply + (factor 715))
;-> 29

Funzione che calcola le coppie di Ruth-Aaron fino ad un dato limite:

(define (ruth-aaron limit)
  (let (out '())
    (for (i 1 (- limit 1))
      (if (= (apply + (factor i)) (apply + (factor (+ i 1))))
          (push (list i (+ i 1)) out -1)))
    out))

(ruth-aaron 10000)
;-> ((5 6) (8 9) (15 16) (77 78) (125 126) (714 715) (948 949) (1330 1331)
;->  (1520 1521) (1862 1863) (2491 2492) (3248 3249) (4185 4186) (4191 4192)
;->  (5405 5406) (5560 5561) (5959 5960) (6867 6868) (8280 8281) (8463 8464))

(map first (ruth-aaron 10000))
;-> (5 8 15 77 125 714 948 1330 1520 1862 2491 3248 4185 4191
;->  5405 5560 5959 6867 8280 8463)

Funzione che verifica se un dato numero appartiene ad una coppia di Ruth-Aaron:

(define (ruth-aaron? n) (= (apply + (factor n)) (apply + (factor (+ n 1)))))

(filter ruth-aaron? (sequence 1 10000))
;-> (5 8 15 77 125 714 948 1330 1520 1862 2491 3248 4185 4191
;->  5405 5560 5959 6867 8280 8463)


-----------------------
Sequenza prepend-append
-----------------------

La sequenza prepend-append è definita in modo ricorsivo in questo modo:

  a(1) = 1
  a(n) = a(n-1) U n , se n è pari
  a(n) = n U a(n-1) , se n è dispari

dove l'operatore U concatena due numeri interi (es. 12 U 65 = 1265)

Sequenza OEIS A053064:
Alternately append n to end or beginning of previous term
  1, 12, 312, 3124, 53124, 531246, 7531246, 75312468, 975312468, 97531246810,
  1197531246810, 119753124681012, 13119753124681012, 1311975312468101214,
  151311975312468101214, 15131197531246810121416, 1715131197531246810121416,
  171513119753124681012141618, ...

(define (sequenza limit)
  (let ( (out '("1")) (prev "1") )
    (for (i 2 limit)
      (if (even? i)
          (push (setq prev (string prev i)) out -1)
          ;else (i is odd)
          (push (setq prev (string i prev)) out -1)
      )
    )
    out))

Proviamo:

(sequenza 20)
;-> ("1" "12" "312" "3124" "53124" "531246" "7531246" "75312468" "975312468"
;->  "97531246810" "1197531246810" "119753124681012" "13119753124681012"
;->  "1311975312468101214" "151311975312468101214" "15131197531246810121416"
;->  "1715131197531246810121416" "171513119753124681012141618"
;->  "19171513119753124681012141618" "1917151311975312468101214161820")


----------------------------------------------------------
Rimozione di elementi da una lista con una lista di indici
----------------------------------------------------------

Data una lista E di elementi e una lista I di indici, rimuovere gli elementi dalla lista E i cui indici sono contenuti nella lista I.
Attenzione, esistono due metodi per effettuare questa operazione.

Primo metodo
------------
Gli indici della lista I fanno sempre riferimento agli elementi della lista E iniziale.
Esempio:
  lista = (4 8 5 9)
  indici = (1 2 0)

  indice = 1 -> lista(1) = 8 (elemento da rimuovere)
  indice = 2 -> lista(2) = 5 (elemento da rimuovere)
  indice = 0 -> lista(0) = 4 (elemento da rimuovere)
  output = (9)

In questo caso gli indici devono essere tutti diversi.
Il numero massimo di indici vale lunghezza(lista).
Il valore massimo degli indici vale lunghezza(lista) - 1.

Secondo metodo
--------------
Gli indici della lista I fanno riferimento agli elementi della lista E modificata dopo ogni rimozione.
Esempio:
  lista = (4 8 5 9)
  indici = (1 2 0)

  indice = 1 -> lista(1) = 8 (elemento da rimuovere)
  lista = (4 5 9)
  indice = 2 -> lista(2) = 9 (elemento da rimuovere)
  lista = (4 5)
  indice = 0 -> lista(0) = 4 (elemento da rimuovere)
  output = (5)

In questo caso gli indici possono anche essere uguali.
Il numero massimo di indici vale lunghezza(lista).
Il valore massimo degl indici vale lunghezza(lista) - 1.
Attenzione, bisogna anche considerare il caso che un indice sia al di fuori dell'intervallo della lista.

Per esempio:
  lista = (1 2 3)
  indici = (0 2)

  indice = 1 -> lista(0) = 1 (elemento da rimuovere)
  lista = (2 3)
  indice = 2 -> lista(2) = error (elemento non esiste)

Se (posizione-indice + valore-indice) >= lunghezza-lista,
Allora indice-fuori-intervallo.

Primo metodo
------------
Calcoliamo gli indici degli elementi da tenere con:
  indici-da-tenere = tutti-gli-indici - indici-da-togliere
dove: tutti-gli-indici = (sequence 0 (- (length lst) 1))
      indici-da-togliere = lista degli indici
E poi usiamo "select" per selezionare gli elementi dalla lista data.

(define (remove1 lst indici)
  (select lst (difference (sequence 0 (- (length lst) 1)) indici)))

Proviamo:

(setq ls '(4 8 5 9))
(setq ix '(1 2 0))
(remove1 ls ix)
;-> (9)

(remove1 '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3))
;-> (3 3 4 4 5 5 5)

(remove1 '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3 4 5 6))
;-> (4 5 5 5)

Secondo metodo
--------------
Attraversiamo la lista degli indici ed eliminiamo uno ad uno gli elementi corrispondenti della lista data.
Vediamo due implementazioni simili (che non controllano la correttezza degli indici):

(define (remove2a lst indici)
  (dolist (idx indici) (pop lst idx))
  lst)

(remove2a ls ix)
;-> (5)

(remove2a '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3))
;-> (1 2 3 4 5 5 5)

(remove2a '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3 4 5 6))
;-> ERR: invalid list index in function pop
;-> called from function (remove2a '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3 4 5 6))

(define (remove2b lst indici) (map (fn(x) (pop lst x)) indici) lst)

(remove2b ls ix)
;-> (5)

(remove2b '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3))
;-> (1 2 3 4 5 5 5)

(remove2b '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3 4 5 6))
;-> ERR: invalid list index in function pop
;-> called from function (remove2a '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3 4 5 6))

Vediamo una funzione che rimuove solo gli elementi con indici corretti (e quindi non genera un errore "invalid list index"):

(define (remove2c lst indici)
  (let (len (length lst))
    (dolist (idx indici)
      (if (< (+ $idx idx) len)
          (pop lst idx))
    )
    lst))

Proviamo:

(remove2c ls ix)
;-> (5)

(remove2c '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3))
;-> (1 2 3 4 5 5 5)

(remove2c '(1 1 2 2 3 3 4 4 5 5 5) '(0 1 2 3 4 5 6))
;-> (1 2 3 4 5)


--------------------------------------
Primi di un numero cambiando una cifra
--------------------------------------

Dato un intero n > 0, restituire la lista dei numeri primi (con n stesso se è primo) che possono essere prodotti modificando una cifra del numero n (senza modificare il numero di cifre).
(Occorre modificare tutte le cifre di n, una per volta).

Esempi:
n = 3
Modificando una cifra otteniamo i seguenti numeri:
  0 1 2 3 4 5 6 7 8 9
In questi numeri i primi sono: 2 3 5 7

n = 13
Modificando una cifra (prima la 1 e poi la 3) otteniamo i seguenti numeri:
  03 13 23 33 43 53 63 73 83 93 10 11 12 13 14 15 16 17 18 19
In questi numeri i primi sono: 3 11 13 17 19 23 43 53 73 83

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

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (quanti num)
  (local (out lst tmp val)
    (setq out '())
    ; converte il numero in una lista
    (setq lst (int-list num))
    (setq len (length lst))
    ; ciclo per ogni cifra del numero (lista)
    (dolist (d lst)
      ; copia la lista
      (setq tmp lst)
      ; ciclo per la cifra all'indice $idx
      (for (i 0 9)
        ; modifica il numero (lista)
        (setf (tmp $idx) i)
        ; converte la lista in intero
        (setq val (list-int tmp))
        (print val) (read-line)
        ; numero primo con la stessa lunghezza del numero dato?
        ;(if (and (prime? val) (= len (length val)))
        ; numero primo?
        (if (prime? val) (push val out -1))
      )
    )
    (unique (sort out))))

Proviamo:

(quanti 1)
;-> (2 3 5 7)
(quanti 3)
;-> (2 3 5 7)
(quanti 13)
;-> (3 11 13 17 19 23 43 53 73 83)
(quanti 42)
;-> (2 41 43 47)
(quanti 100)
;-> (101 103 107 109)
(quanti 1000)
;-> (1009)

(map length (map quanti (sequence 1 50)))
;-> (4 4 4 4 4 4 4 4 4 4 8 5 10 4 5 4 9 4 8 2 7 3 8 2 3
;->  2 8 2 6 2 6 3 9 2 3 2 7 2 7 3 7 4 9 3 4 3 8 3 8 2)


------------------------------------
Tabella cross-reference di un torneo
------------------------------------

In un torneo di scacchi ci sono N giocatori.
Ogni giocatore gioca al massimo una partita con ognuno degli altri giocatori.
Il risultato di una partita può essere:
"1-0"  -> vince il primo giocatore
"0-1"  -> vince il secondo giocatore
"1/2"  -> partita patta
Data una lista di partite con elementi del tipo ("giocatoreX" "giocatoreY" "risultato") costruire la tabella di cross-reference.

Per esempio:
lista partite = (("a" "b" "1-0") ("a" "c" "1-0") ("a" "d" "0-1")
                 ("b" "c" "1-0") ("b" "d" "1/2") ("c" "d" "1-0"))
tabella cross-reference =
  +---+-----+-----+-----+-----+-----+
  | b | *   | 0.5 | 0.5 | 1   | 2   |
  +---+-----+-----+-----+-----+-----+
  | d | 0.5 | *   | 1   | 0.5 | 2   |
  +---+-----+-----+-----+-----+-----+
  | a | 0.5 | 0   | *   | 1   | 1.5 |
  +---+-----+-----+-----+-----+-----+
  | c | 0   | 0.5 | 0   | *   | 0.5 |
  +---+-----+-----+-----+-----+-----+

(define (print-table lst)
"Print a matrix m x n as a table"
  (local (tab plus minus ver rows cols col-len-max len-max
          line-len line ind)
    ; conversione di tutti i valori della lista in stringa
    (setq tab (map-all string lst))
    ; caratteri grafici
    (setq plus "+")
    (setq minus "-")
    (setq ver "|")
    ; calcolo righe e colonne della lista
    (setq rows (length tab))
    (setq cols (length (tab 0)))
    ; vettore per le lunghezze massime dei valori di ogni colonna
    (setq col-len-max (array cols '(0)))
    ; calcola la lunghezza massima dei valori di ogni colonna
    (for (c 0 (- cols 1))
      (setq len-max 0)
      (for (r 0 (- rows 1))
        (setf len-max (max len-max (length (tab r c))))
      )
      (setf (col-len-max c) len-max)
    )
    ;(println col-len-max)
    ; lunghezza della linea =
    ; (somma delle lunghezze massime) +
    ; (2 spazi x ogni colonna) +
    ; (colonne + 1 per "|")
    (setq line-len (+ (apply + col-len-max) (* cols 2) (+ cols 1)))
    (setq line (dup minus line-len))
    (setf (line 0) plus)
    (setf (line -1) plus)
    ; calcola i limiti di stampa dei valori
    ; (inserisce "+" nella linea "line")
    (setq ind 1)
    (dolist (c col-len-max)
      (setq ind (+ ind 2 c))
      (setf (line ind) plus)
      (++ ind)
    )
    ; stampa della lista come tabella
    (dolist (r tab)
      (println line)
      (dolist (c r)
        (print ver { } c (dup " " (- (col-len-max $idx) (length c))) { })
      )
      (println ver)
    )
    (println line)
  'end))
(define (map-all func lst)
"Apply a function to all the elements of annidate list"
  (let (result '())
    (dolist (el lst)
      (if (list? el)
        (push (map-all func el) result -1)
        (push (func el) result -1)))
    result))

Funzione che stampa la tabella cross-reference di una lista di partite:

(define (cross lst)
  (local (players num-players classifica table row col val1 val2
          cross-ref max-len fmt nomi punteggi)
    ; crea la lista dei giocatori
    (setq players '())
    (setq players (unique (sort (flat
                  (map (fn(x) (extend players (list (x 0) (x 1)))) lst)))))
    ; numero totale dei giocatori
    (setq num-players (length players))
    ; crea la lista della classifica (nome punteggio-totale)
    (setq classifica (map (fn(x) (list x 0)) players))
    ; ciclo per creare la classifica
    (dolist (game lst)
      (cond ((= (game 2) "1-0")
              (setf (lookup (game 0) classifica) (add $it 1)))
            ((= (game 2) "0-1")
              (setf (lookup (game 1) classifica) (add $it 1)))
            ((= (game 2) "1/2")
              (setf (lookup (game 0) classifica) (add $it 0.5))
              (setf (lookup (game 1) classifica) (add $it 0.5)))
            (true (println "Error: " (game 0) "," (game 1) " : " (game 2)))
      )
    )
    ; ordina la classifica
    (define (comp x y) (>= (last x) (last y)))
    (sort classifica comp)
    ; ordina i giocatori in base alla classifica
    (setq players (map first classifica))
    ; matrice della tabella di cross-reference
    (setq table (array num-players num-players '("*")))
    ; crea la tabella d cross-reference
    (dolist (game lst)
      (setq row (first (ref (game 0) players)))
      (setq col (first (ref (game 1) players)))
      (cond ((= (game 2) "1-0")
              (setq val1 1) (setq val2 0))
            ((= (game 2) "0-1")
              (setq val1 0) (setq val2 1))
            ((= (game 2) "1/2")
              (setq val1 0.5) (setq val2 0.5))
            (true (println "Error: " (game 0) "," (game 1) " : " (game 2))
                  (setq val1 0) (setq val2 0))
      )
      ; aggiorna la tabella
      (setf (table row col) val1)
      (setf (table col row) val2)
    )
    ; crea la tabella finale aggiungendo:
    ; 1) la colonna dei nomi giocatori (a sinistra della tabella)
    ; 2) la colonna dei punteggi (a destra della tabella)
    (setq cross-ref (array-list table))
    ; lungheza del nome più lungo
    (setq max-len (apply max (map length players)))
    ; stringa di formattazione
    (setq fmt (string "%-" max-len "s"))
    ; crea la colonna dei nomi formattati
    (setq nomi (map (fn(x) (format fmt x)) players))
    ; aggiunge la colonna dei nomi
    (setq cross-ref (transpose (push nomi (transpose cross-ref))))
    ; crea la lista dei punteggi
    (setq punteggi (map last classifica))
    ; aggiunge la colonna dei nomi
    (setq cross-ref (transpose (push punteggi (transpose cross-ref) -1)))
    ; stampa la tabella di cross-reference
    (print-table cross-ref)))

Proviamo con la lista delle partite del Torneo di Linares del 1992:

(setq linares92 '(
      ("Timman" "Kasparov" "0-1") ("Ljubojevic" "Karpov" "0-1")
      ("Jussupow" "Anand" "1-0") ("Ivanchuk" "Salov" "0-1")
      ("Bareev" "Short" "1/2") ("Gelfand" "Illescas" "1-0")
      ("Beliavsky" "Speelman" "1/2") ("Speelman" "Jussupow" "0-1")
      ("Timman" "Ivanchuk" "1/2") ("Short" "Beliavsky" "0-1")
      ("Kasparov" "Karpov" "1-0") ("Salov" "Gelfand" "0-1")
      ("Illescas" "Bareev" "1-0") ("Anand" "Ljubojevic" "1/2")
      ("Ljubojevic" "Speelman" "1-0") ("Jussupow" "Short" "1-0")
      ("Ivanchuk" "Kasparov" "1/2") ("Beliavsky" "Illescas" "1/2")
      ("Bareev" "Salov" "1-0") ("Karpov" "Anand" "1/2")
      ("Gelfand" "Timman" "1/2") ("Timman" "Bareev" "1-0")
      ("Speelman" "Karpov" "1/2") ("Short" "Ljubojevic" "1-0")
      ("Salov" "Beliavsky" "1/2") ("Ivanchuk" "Gelfand" "1-0")
      ("Kasparov" "Anand" "1/2") ("Illescas" "Jussupow" "1-0")
      ("Ljubojevic" "Illescas" "0-1") ("Karpov" "Short" "1-0")
      ("Jussupow" "Salov" "1/2") ("Gelfand" "Kasparov" "0-1")
      ("Beliavsky" "Timman" "1-0") ("Bareev" "Ivanchuk" "1/2")
      ("Anand" "Speelman" "1/2") ("Timman" "Jussupow" "1-0")
      ("Salov" "Ljubojevic" "1-0") ("Short" "Anand" "1-0")
      ("Kasparov" "Speelman" "1/2") ("Ivanchuk" "Beliavsky" "1/2")
      ("Illescas" "Karpov" "0-1") ("Gelfand" "Bareev" "1-0")
      ("Speelman" "Short" "1/2") ("Ljubojevic" "Timman" "0-1")
      ("Karpov" "Salov" "1-0") ("Jussupow" "Ivanchuk" "0-1")
      ("Beliavsky" "Gelfand" "1-0") ("Bareev" "Kasparov" "1/2")
      ("Anand" "Illescas" "1-0") ("Timman" "Karpov" "1-0")
      ("Salov" "Anand" "1/2") ("Ivanchuk" "Ljubojevic" "1/2")
      ("Illescas" "Speelman" "1-0") ("Gelfand" "Jussupow" "1/2")
      ("Bareev" "Beliavsky" "1/2") ("Kasparov" "Short" "1-0")
      ("Short" "Illescas" "1/2") ("Karpov" "Ivanchuk" "1/2")
      ("Ljubojevic" "Gelfand" "1/2") ("Jussupow" "Bareev" "0-1")
      ("Beliavsky" "Kasparov" "1/2") ("Anand" "Timman" "1-0")
      ("Speelman" "Salov" "1/2") ("Timman" "Speelman" "1-0")
      ("Salov" "Short" "1-0") ("Kasparov" "Illescas" "1-0")
      ("Gelfand" "Karpov" "1/2") ("Ivanchuk" "Anand" "1/2")
      ("Beliavsky" "Jussupow" "0-1") ("Bareev" "Ljubojevic" "1/2")
      ("Speelman" "Ivanchuk" "0-1") ("Ljubojevic" "Beliavsky" "1-0")
      ("Karpov" "Bareev" "0-1") ("Illescas" "Salov" "1/2")
      ("Short" "Timman" "0-1") ("Jussupow" "Kasparov" "0-1")
      ("Anand" "Gelfand" "1/2") ("Timman" "Illescas" "1-0")
      ("Kasparov" "Salov" "1/2") ("Jussupow" "Ljubojevic" "1/2")
      ("Ivanchuk" "Short" "1/2") ("Gelfand" "Speelman" "1/2")
      ("Beliavsky" "Karpov" "0-1") ("Bareev" "Anand" "1/2")
      ("Speelman" "Bareev" "1/2") ("Short" "Gelfand" "0-1")
      ("Salov" "Timman" "1-0") ("Ljubojevic" "Kasparov" "0-1")
      ("Karpov" "Jussupow" "1/2") ("Illescas" "Ivanchuk" "0-1")
      ("Anand" "Beliavsky" "1-0")))

(cross linares92)

;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Kasparov   | *   | 0.5 | 1   | 1   | 0.5 | 1   | 0.5 | 0.5 | 0.5 | 1   | 1   | 1   | 1   | 0.5 | 10  |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Ivanchuk   | 0.5 | *   | 0.5 | 0.5 | 0.5 | 1   | 0   | 0.5 | 0.5 | 1   | 1   | 0.5 | 0.5 | 1   | 8   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Timman     | 0   | 0.5 | *   | 1   | 0   | 0.5 | 0   | 1   | 0   | 1   | 1   | 1   | 1   | 1   | 8   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Karpov     | 0   | 0.5 | 0   | *   | 0.5 | 0.5 | 1   | 0   | 1   | 0.5 | 1   | 1   | 1   | 0.5 | 7.5 |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Anand      | 0.5 | 0.5 | 1   | 0.5 | *   | 0.5 | 0.5 | 0.5 | 1   | 0   | 1   | 0.5 | 0   | 0.5 | 7   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Gelfand    | 0   | 0   | 0.5 | 0.5 | 0.5 | *   | 1   | 1   | 0   | 0.5 | 1   | 0.5 | 1   | 0.5 | 7   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Salov      | 0.5 | 1   | 1   | 0   | 0.5 | 0   | *   | 0   | 0.5 | 0.5 | 0.5 | 1   | 1   | 0.5 | 7   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Bareev     | 0.5 | 0.5 | 0   | 1   | 0.5 | 0   | 1   | *   | 0.5 | 1   | 0   | 0.5 | 0.5 | 0.5 | 6.5 |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Beliavsky  | 0.5 | 0.5 | 1   | 0   | 0   | 1   | 0.5 | 0.5 | *   | 0   | 0.5 | 0   | 1   | 0.5 | 6   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Jussupow   | 0   | 0   | 0   | 0.5 | 1   | 0.5 | 0.5 | 0   | 1   | *   | 0   | 0.5 | 1   | 1   | 6   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Illescas   | 0   | 0   | 0   | 0   | 0   | 0   | 0.5 | 1   | 0.5 | 1   | *   | 1   | 0.5 | 1   | 5.5 |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Ljubojevic | 0   | 0.5 | 0   | 0   | 0.5 | 0.5 | 0   | 0.5 | 1   | 0.5 | 0   | *   | 0   | 1   | 4.5 |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Short      | 0   | 0.5 | 0   | 0   | 1   | 0   | 0   | 0.5 | 0   | 0   | 0.5 | 1   | *   | 0.5 | 4   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
;-> | Speelman   | 0.5 | 0   | 0   | 0.5 | 0.5 | 0.5 | 0.5 | 0.5 | 0.5 | 0   | 0   | 0   | 0.5 | *   | 4   |
;-> +------------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+


-----------------------------
Operazioni con interi e float
-----------------------------

Nel forum di newLISP vashushpanov ha scritto le seguenti espressioni:

(sub 9999999999999999.0 9999999999999998.0)
;-> 0
(- 9999999999999999 9999999999999998)
;-> 1

Perchè la prima espressione produce un risultato  errato?

Dal manuale di newLISP:
"newLISP has two types of basic arithmetic operators: integer (+ - * /) and floating point (add sub mul div).
The arithmetic functions convert their arguments into types compatible with the function's own type: integer function arguments into integers, floating point function arguments into floating points."

Quindi la funzione "sub" prima converte gli argomenti in numeri float e poi li sottrae:

(float 9999999999999999.0)
;-> 9999999999999998 ; questo è il problema
(float 9999999999999998.0)
;-> 9999999999999998
(- (float 9999999999999999.0) (float 9999999999999998.0))
;-> 0

Un risultato diverso (ma sempre errato) si ottiene con gli stessi numeri senza virgola (numeri interi):
(sub 9999999999999999 9999999999999998)
;-> 2
(float 9999999999999999)
;-> 1e+016 ; questo è il problema
(float 9999999999999998)
;-> 9999999999999998
(- (float 9999999999999999) (float 9999999999999998))
;-> 2

In C++:

#include <iostream>
using namespace std;
int main()
{
  cout<<(1e16 - 1) << endl;
  cout<<(10000000000000000 - 1);
  return 0;
}
--> 1e+16
--> 9999999999999999

Un metodo per evitare (in parte) il problema è il seguente.

Addizione estesa:

(define (add-ex x y)
  (if (and (integer? x) (integer? y)) (+ x y) (add x y)))

Sottrazione estesa:

(define (sub-ex x y)
  (if (and (integer? x) (integer? y)) (- x y) (sub x y)))

(sub-ex )

Moltiplicazione estesa:

(define (mul-ex x y)
  (if (and (integer? x) (integer? y)) (* x y) (mul x y)))

(mul-ex 2 3)
;-> 6
(mul-ex 2.5 3)
;-> 7.5
(float? (mul-ex 2.0 3.0))
;-> true

;(define (div-ex x y)
;  (if (and (integer? x) (integer? y)) (/ x y) (div x y)))
Divisione estesa:
(define (div-ex x y real)
  (if (and (integer? x) (integer? y) (not real)) (/ x y) (div x y)))

(div-ex 10 4)
;-> 2
(div-ex 10 4 true)
;-> 2.5


------------------------
Primo elemento duplicato
------------------------

Data una lista di elementi, trovare il primo elemento duplicato.

Soluzione con hash-map (dizionario):

(define (duplicato1 lst)
  ; crea la hash-map
  (new Tree 'myHash)
  (let (elemento nil)
    (dolist (el lst elemento)
      ; se l'elemento non esiste nella hash-map...
      (if (nil? (myHash el))
          ; allora inserisce l'elemento nella hash-map
          (myHash el el)
          ; altrimenti imposta il risultato (che ferma il ciclo)
          (setq elemento el)
      )
    )
    ; elimina la hash-map
    (delete 'myHash)
    elemento))

Proviamo:

(duplicato1 '(1 3 7 -2 9 3 5 7))
;-> 3

(duplicato1 '())
;-> nil

(duplicato1 '(1 2 3))
;-> nil

Soluzione con lista associativa:

(define (duplicato2 lst)
  (let ( (lista '()) (elemento nil) )
    (dolist (el lst elemento)
      ; se l'elemento non esiste nella lista associativa...
      (if (nil? (assoc el lista))
          ; allora inserisce l'elemento nella lista associativa
          (push (list el el) lista)
          ; altrimenti imposta il risultato (che ferma il ciclo)
          (setq elemento el)
      )
    )
    elemento))

Proviamo:

(duplicato2 '(1 3 7 -2 9 3 5 7))
;-> 3

(duplicato2 '())
;-> nil

(duplicato2 '(1 2 3))
;-> nil

Vediamo la velocità delle due funzioni.

Una sola chiamata con una lista grande:

(time (duplicato1 (sequence 1 1e3)))
;-> 15.585
(time (duplicato2 (sequence 1 1e3)))
;-> 15.586

(time (duplicato1 (sequence 1 1e4)))
;-> 15.586
(time (duplicato2 (sequence 1 1e4)))
;-> 171.797

(time (duplicato1 (sequence 1 1e5)))
;-> 109.341
(time (duplicato2 (sequence 1 1e5)))
;-> 20751.976

Tante chiamate con una lista piccola/media:

(time (duplicato1 (sequence 1 100)) 100)
;-> 249.937
(time (duplicato2 (sequence 1 100)) 100)
;-> 0

(time (duplicato1 (sequence 1 100)) 1000)
;-> 2422.11
(time (duplicato2 (sequence 1 100)) 1000)
;-> 31.239

(time (duplicato1 (sequence 1 1000)) 100)
;-> 328.214
(time (duplicato2 (sequence 1 1000)) 100)
;-> 171.824

(time (duplicato1 (sequence 1 1000)) 1000)
;-> 3094.087
(time (duplicato2 (sequence 1 1000)) 1000)
;-> 1609.421

La parte più lenta della funzione "duplicato1" è la cancellazione della hash-map, quindi è migliore per poche chiamate e liste grandi.
Invece la funzione "duplicato2" è lenta con liste grandi, ma è conveniente se facciamo molte chiamate.


-----------------------------------
Convertire un numero float in lista
-----------------------------------

Dato un numero floating-point convertirlo in lista.

Un modo semplice:

(define (float-list x) (explode (string x)))

Proviamo:

(float-list -2347.42)
;-> ("-" "2" "3" "4" "7" "." "4" "2")

(float-list -32.753456e4)
;-> ("-" "3" "2" "7" "5" "3" "4" "." "5" "6")

(float-list -32.753456e88)
;-> ("-" "3" "." "2" "7" "5" "3" "4" "5" "6" "e" "+" "0" "8" "9")

Nota: newLISP converte il numero dato in una rappresentazione float che può essere diversa dal numero dato.

Funzione che converte un numero float in una lista di caratteri oppure in una lista di simboli:

(define (float-list x simboli)
  (if (not simboli)
      (explode (string x))
      ;else
      (let (out '())
        (dolist (ch (explode (string x)))
          (cond ((= ch "-") (push '- out -1))
                ((= ch "+") (push '+ out -1))
                ((= ch ".") (push '. out -1))
                ((= ch "e") (push 'e out -1))
                (true (push (int ch) out -1))
          )
        )
        out)))

Proviamo:

(float-list -32.753456e88)
;-> ("-" "3" "." "2" "7" "5" "3" "4" "5" "6" "e" "+" "0" "8" "9")
(float-list -32.753456e88 true)
;-> (- 3 . 2 7 5 3 4 5 6 e + 0 8 9)

Dalla lista di caratteri basta usare "join" e "float" per ricostruire il numero float:

(float (join (float-list -32.753456e88)))
;-> -3.2753456e+089

(float (join (float-list -32.753456e4)))
;-> -327534.56


------------------------------
Applicare un'onda ad una lista
------------------------------

Data una lista di numeri interi applicare la lista "onda" alla lista.
Per esempio,
  lista      = 1 2  3 4 5 6  7
  lista onda = 1 0 -1 0 1 0 -1
Per applicare la lista "onda" sommare gli elementi con lo stesso indice...
  output     = 2 2  2 4 6 6  6

La lista "onda" è una lista con gli elementi (1 0 -1 0) ripetuti.

Algoritmo
Raggruppare la lista data in gruppi di 4.
Sommare la lista (1 0 -1 0) ad ogni gruppo.

(setq data '(1 2 3 4 5 6 7))
(setq gruppi (explode data 4))
;-> ((1 2 3 4) (5 6 7))
(setq out (map (fn(x) (map + x '(1 0 -1 0))) gruppi))
;-> ((2 2 2 4) (6 6 6))
(setq out (flat out))
;-> (2 2 2 4 6 6 6)

(define (ondeggia lst)
  (flat (map (fn(x) (map + x '(1 0 -1 0))) (explode lst 4))))

(ondeggia data)
;-> (2 2 2 4 6 6 6)

Per un onda data:

(define (ondeggia lst onda)
  (flat (map (fn(x) (map + x onda)) (explode lst (length onda)))))

(ondeggia data '(1 0 -1 0))
;-> (2 2 2 4 6 6 6)

(ondeggia data '(2 1 0 -1 -2 -1 0 1))
;-> (3 3 3 3 3 5 7)


--------------------------------
Simboli newLISP e simboli utente
--------------------------------

Per memorizzare in una lista i simboli di newLISP possiamo usare la seguente espressione:

(constant (global 'SIMBOLI) (map string (symbols)))

Possiamo mettere l'espressione su "init.lsp" oppure eseguirla su una nuova REPL.

(length SIMBOLI)
;-> 398
(find "SIMBOLI" SIMBOLI)
;-> 46

Adesso definiamo una funzione che restituisce i simboli della REPL corrente:

(define (new-symbols) (difference (map string (symbols)) SIMBOLI))

Proviamo:

(new-symbols)
;-> ("new-symbols")

Notare che "new-symbols" è un nuovo simbolo rispetto alla situazione iniziale memorizzata in SIMBOLI.

Scriviamo una funzione prende come argomento una funzione e restituisce tutti i simboli della funzione che non si trovano in SIMBOLI.

(define (sym-func func)
  (difference (unique (parse (string func))) SIMBOLI))

Proviamo:

(sym-func new-symbols)
;-> ("(" "lambda" ")")

(sym-func sym-func)
;-> ("(" "lambda" "func" ")")

Notare che i simboli "(", ")" e "lambda" non appartengono a SIMBOLI.

Vediamo quali simboli sono stati creati dall'utente:

(new-symbols)
;-> ("func" "new-symbols" "sym-func")

Vedere anche "Simboli creati dall'utente" su "Funzioni varie".
Vedere anche "Variabili libere" su "Note libere 3".
Vedere anche la funzione "free-vars" su "yo.lsp".


-----------------------------------
Parole e testi maschili o femminili
-----------------------------------

In lingua italiana il 47.65% delle lettere usate sono vocali (a,e,i,o,u)
In lingua inglese il 38.1% delle lettere usate sono vocali (a,e,i,o,u) (in questo caso y non è una vocale).
In inglese:
definiamo "femminile" una parola che contiene almeno il 40% di vocali.
definiamo "maschile" una parola che contiene meno del 40% di vocali.
In italiano:
definiamo "femminile" una parola che contiene almeno il 50% di vocali.
definiamo "maschile" una parola che contiene meno del 50% di vocali.

Definiamo la "mascolinità" o la "femminilità" di una parola.
Sia C il numero di consonanti nella parola e V il numero di vocali:
Se una parola è femminile, la sua "femminilità" vale 1.5*V/(C+1).
Se una parola è maschile, la sua "mascolinità" vale C/(1.5*V+1).

Nota: i caratteri che non sono vocali o consonanti non vanno considerati.

Ad esempio, la parola "newlisp" è maschile, con mascolinità 5/(1.5*2+1) = 1.25.
La parola "mimosa" è femminile con femminilità 1.5*3/(3+1) = 1.125.

Funzione che data una stringa restituisce se "maschile" o "femminile" e il relativo indice di mascolinità/femminilità:

(define (gender word threshold)
  (let ( (conta-m 0) (conta-f 0) (conta-ch 0) (mm nil) (ff nil) )
    (setq threshold (or threshold 0.4))
    ; ciclo per calcolare numero di vocali e numero di consonanti
    (dolist (ch (explode word))
      (cond ((find ch "aeiou")
              (++ conta-f) (++ conta-ch))
            ((find ch "bcdfghjklmnpqrstvwxyz")
              (++ conta-m) (++ conta-ch))
      )
    )
    ;(println conta-f { } conta-m { } conta-ch)
    ; calcolo mascolinità o femminilità o nil
    (cond ((zero? conta-ch) (list nil nil)) ; nil
          ; femminilità
          ((>= (div conta-f conta-ch) threshold)
            (setq ff (div (mul 1.5 conta-f) (add conta-m 1)))
            (list "F" ff))
          ; mascolinità
          ((< (div conta-f conta-ch) threshold)
            (setq mm (div conta-m (add (mul 1.5 conta-f) 1)))
            (list "M" mm)))))

Proviamo:

(gender "newlisp" 0.4)
;-> ("M" 1.25)
(gender "newlisp!!!" 0.4)
;-> ("M" 1.25)

(gender "mimosa" 0.4)
;-> ("F" 1.125)
(gender "@mimosa$" 0.4)
;-> ("F" 1.125)

(gender "@#$%" 0.4)
;-> (nil nil)

Per quanto riguarda un testo possiamo usare una semplice tecnica NLP (Natural Language Processing):

Definiamo la "mascolinità" di un testo come la somma di tutte le mascolinità delle parole maschili: sum(M).
Definiamo la "femminilità" di un testo come la somma di tutte le mascolinità delle parole femminili: sum(F).
Se (sum(M) > sum(F)), allora il testo è "femminile", altrimenti è "maschile".

Infine definiamo il "livello di confidenza":

Se il testo è "femminile" il livello di confidenza vale:

  2*sum(F)/(sum(F) + sum(M)) - 1

Se il testo è "maschile" il livello di confidenza vale:

  2*sum(M)/(sum(F) + sum(M)) - 1

Funzione che analizza un testo e restituisce se "maschile" o "femminile" e l'indice di confidenza:

(define (genere testo threshold)
  (local (words f-word m-word sum-ff sum-mm)
    (setq threshold (or threshold 0.4))
    ; suddivisione del testo (spazi " ")
    (setq words (parse (lower-case testo " ")))
    (setq sum-ff 0)
    (setq sum-mm 0)
    ; ciclo per ogni parola per calcolare la somma della
    ; mascolinità/femminilità delle parole
    (dolist (w words)
      (setq res (gender w threshold))
      (cond ((= (res 0) "F") (setq sum-ff (add sum-ff (res 1))))
            ((= (res 0) "M") (setq sum-mm (add sum-mm (res 1))))
      )
      ;(print w { } res { } sum-ff { } sum-mm) (read-line)
    )
    ; calcolo indici di mascolinità/femminilità
    (cond ((and (zero? sum-ff) (zero? sum-mm))
            (list nil 0))
          ((> sum-mm sum-ff)  ; maschile
            (list "M" (sub (div (mul 2 sum-mm) (add sum-ff sum-mm)) 1)))
          ((<= sum-mm sum-ff) ; femminile
            (list "F" (sub (div (mul 2 sum-ff) (add sum-ff sum-mm)) 1)))
    )))

Proviamo:

Da "The Sign of the Four" di Sir Arthur Conan Doyle (1890)
(setq doyle
   "Three times a day for many months I had witnessed this performance, but
   custom had not reconciled my mind to it.  On the contrary, from day to
   day I had become more irritable at the sight, and my conscience swelled
   nightly within me at the thought that I had lacked the courage to
   protest.  Again and again I had registered a vow that I should deliver
   my soul upon the subject, but there was that in the cool, nonchalant
   air of my companion which made him the last man with whom one would
   care to take anything approaching to a liberty.  His great powers, his
   masterly manner, and the experience which I had had of his many
   extraordinary qualities, all made me diffident and backward in crossing
   him.")

(genere doyle)
;-> ("M" 0.2262586611446231)

Nota: in italiano le lettere hanno la seguente frequenza (wikipedia),

Lettera Frequenza
 a       11.74%
 b       0.92%
 c       4.50%
 d       3.73%
 e       11.79%
 f       0.95%
 g       1.64%
 h       1.54%
 i       11.28%
 l       6.51%
 m       2.51%
 n       6.88%
 o       9.83%
 p       3.05%
 q       0.51%
 r       6.37%
 s       4.98%
 t       5.62%
 u       3.01%
 v       2.10%
 z       0.49%

Frequenza vocali (a e i o u):
(add 11.74 11.79 11.28 9.83 3.01)
;-> 47.65


-------------------------------------------------------
Somma ripetuta del prodotto di cifre consecutive uguali
-------------------------------------------------------

Dato un intero positivo n (per esempio, n=122334665555999)

Separare il numero in sequenze di cifre consecutive:
  (1 22 33 4 66 5555 999)

Prendere il prodotto di ogni sequenza di cifre:
  (1 2*2 3*3 4 6*6 5*5*5*5 9*9*9) = (1 4 9 4 36 625 729)

Sommare tutti i valori:
  1 + 4 + 9 + 4 + 36 + 625 + 729 = 1408

Ripetere finché questo non converge in un singolo numero:

  (1 4 0 8) = (1 4 0 8) --> 1 + 4 + 0 + 8 = 13

  (1 3) = (1 3) --> 1 + 3 = 4

Risultato: 4

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (rle-encode lst)
"Encode list with Run Length Encoding"
  (local (palo conta out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq palo (first lst))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              (if (= el palo) (++ conta)
                  ; altrimenti costruiamo la coppia (conta el) e la aggiungiamo al risultato
                  (begin (extend out (list(list conta palo)))
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           ; aggiungiamo l'ultima coppia di valori
           (extend out (list(list conta palo)))
          )
    )
    out))

Funzione che calcola la somma ripetuta del prodotto di cifre consecutive uguali:

(define (rep-sum num)
  (local (rle nums)
    (while (> (length num) 1)
        (setq rle (rle-encode (int-list num)))
        (setq nums (map (fn(x) (pow (x 1) (x 0))) rle))
        (setq num (apply + nums))
        ;(println nums { } num)
    )
    num))

(rep-sum 122334665555999)
;-> 1

(rep-sum 22222222222)
;-> 5

(rep-sum 111222333444555666777888999)
;-> 9

(rep-sum 123456)
;-> 3

Vediamo la frequenza dei risultati per i primi 100000 numeri:

(count '(0 1 2 3 4 5 6 7 8 9) (map rep-sum (sequence 1 100000)))
;-> (0 17320 4873 10862 11358 10853 9688 11464 10878 12704)


-------------
Primi di Chen
-------------

Un numero è un primo di Chen se soddisfa due condizioni:

1) è un numero primo
2) se stesso più due è primo o semiprimo.
Un numero primo è un numero in cui ha esattamente due divisori e tali divisori sono costituiti da se stesso e da uno.
Un semiprimo è un numero che è il prodotto di due numeri primi (tranne 1 e se stesso).

Sequenza OEIS A109611:
Chen primes: primes p such that p + 2 is either a prime or a semiprime.
  2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 47, 53, 59, 67, 71, 83,
  89, 101, 107, 109, 113, 127, 131, 137, 139, 149, 157, 167, 179, 181, 191,
  197, 199, 211, 227, 233, 239, 251, 257, 263, 269, 281, 293, 307, 311, 317,
  337, 347, 353, 359, 379, 389, 401, 409, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (chen? num)
  (and (prime? num)
       (or (prime? (+ num 2)) (= (length (factor (+ num 2))) 2))))

(filter chen? (sequence 1 100))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 47 53 59 67 71 83 89)


-----------------------------------------
Numeri coprimi con le loro cifre decimali
-----------------------------------------

Calcolare la sequenza degli interi positivi maggiori di 1 che sono coprimi con tutte le loro cifre.
Due numeri sono coprimi se il loro massimo comun divisore vale 1.

Sequenza OEIS A061116:
Numbers coprime to each of their decimal digits.
  11, 13, 17, 19, 21, 23, 27, 29, 31, 37, 41, 43, 47, 49, 51, 53, 57, 59,
  61, 67, 71, 73, 79, 81, 83, 87, 89, 91, 97, 111, 113, 117, 119, 121, 127,
  131, 133, 137, 139, 141, 143, 149, 151, 157, 161, 163, 167, 169, 171, 173,
  177, 179, 181, 187, 191, 193, 197, 199, 211, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (coprime-digit? num)
  (for-all (fn(x) (= (gcd num x) 1)) (int-list num)))

Proviamo:

(coprime-digit? 2)
;-> nil
(coprime-digit? 11)
;-> true

(filter coprime-digit? (sequence 1 100))
;-> (1 11 13 17 19 21 23 27 29 31 37 41 43 47 49 51
;->  53 57 59 61 67 71 73 79 81 83 87 89 91 97)


---------
Numeri MU
---------

La sequenza dei numeri MU viene creata con le seguenti regole:

1) I primi due numeri MU sono 2 e 3.
2) Ogni altro numero MU è il più piccolo numero non ancora apparso che può essere espresso come il prodotto di due numeri MU distinti precedenti esattamente in un modo.

Sequenza OEIS A007335:
MU-numbers: next term is uniquely the product of 2 earlier terms.
  2, 3, 6, 12, 18, 24, 48, 54, 96, 162, 192, 216, 384, 486, 768, 864, 1458,
  1536, 1944, 3072, 3456, 4374, 6144, 7776, 12288, 13122, 13824, 17496,
  24576, 31104, 39366, 49152, 55296, 69984, 98304, 118098, 124416, 157464,
  196608, 221184, 279936, ...

Funzione che moltiplica tra loro tutti gli elementi di una lista:

(define (mult-list lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
          (push (* (lst i) (lst j)) out -1)))))

Proviamo:

(mult-list '(1 2 3))
;-> (2 3 6)

Vediamo il funzionamento dell'algoritmo:

Impostazione iniziale:
(setq mu '(2 3))

primo numero mu:
(sort (mult-list mu))
;-> (6)
(push 6 mu -1) ; scegliamo il numero più piccolo singolo (non in mu)
;-> (2 3 6)

secondo numero mu:
(sort (mult-list mu))
;-> (6 12 18)
(push 12 mu -1) ; scegliamo il numero più piccolo singolo (non in mu)
;-> (2 3 6 12)

terzo numero mu:
(sort (mult-list mu))
;-> (6 12 18 24 36 72)
(push 18 mu -1) ; scegliamo il numero più piccolo singolo (non in mu)
;-> (2 3 6 12 18)

quarto numero mu:
(sort (mult-list mu))
;-> (6 12 18 24 36 36 54 72 108 216)
(push 24 mu -1) ; scegliamo il numero più piccolo singolo (non in mu)
;-> (2 3 6 12 18 24)

quinto numero:
(sort (mult-list mu))
;-> (6 12 18 24 36 36 48 54 72 72 108 144 216 288 432)
(push 48 mu -1) ; scegliamo il numero più piccolo singolo (non in mu)
;-> (2 3 6 12 18 24 48)
In questo caso il numero 36 era più piccolo di 48, ma compariva 2 volte.

Adesso scriviamo la funzione che seleziona il numero più piccolo singolo (non in mu) che si trova in una lista data (cioè la lista degli elementi moltiplicati tra loro):

(define (find-unique-min lst)
  (let (numero nil)
    (dolist (el lst numero)
      (if (and (not (find el mu)) (= (first (count (list el) lst)) 1))
          (setq numero el)))))

Proviamo:

(setq mu '(2 3))
(setq a '(6))
(find-unique-min a)
;-> 6

(setq mu '(2 3 6 12 18 24))
(setq a '(6 12 18 24 36 36 48 54 72 72 108 144 216 288 432))
(find-unique-min a)
;-> 48

Funzione che calcola un dato numero di numeri mu:

(define (mu-list num)
  (local (mu k mult new-val)
    (setq k 2)
    (setq mu '(2 3))
    (until (= k num)
      (setq mult (sort (mult-list mu)))
      (setq new-val (find-unique-min mult))
      (push new-val mu -1)
      (++ k)
    )
    mu))

Proviamo:

(mu-list 5)
;-> (2 3 6 12 18)

(mu-list 50)
;-> (2 3 6 12 18 24 48 54 96 162 192 216 384 486 768 864 1458 1536 1944 3072
;->  3456 4374 6144 7776 12288 13122 13824 17496 24576 31104 39366 49152 55296
;->  69984 98304 118098 124416 157464 196608 221184 279936 354294 393216 497664
;->  629856 786432 884736 1062882 1119744 1417176)

Questa funzione non è ottimizzata ed è abbastanza lenta.

(time (mu-list 50))
;-> 249.965
(time (mu-list 60))
;-> 643.851
(time (mu-list 70))
;-> 1450.581
(time (mu-list 80))
;-> 3079.946
(time (mu-list 100))
;-> 10411.845


------------------------------
Compressione di matrici sparse
------------------------------

Una matrice "sparsa" è una matrice in cui la maggior parte degli elementi sono zero.
Al contrario, quando la maggior parte degli elementi della matrice sono diversi da zero, allora la matrice viene considerata "densa".
Una matrice viene considerata "sparsa" quando il numero di elementi diversi da zero sia uguale o maggiore al numero di righe o colonne.
Il numero di elementi con valore zero diviso per il numero totale di elementi (cioè m*n per una matrice con m righe e n colonne) viene definita "sparsità" della matrice.

Le matrici sparse compaiono nella modellazione di sistemi con poche interazioni a coppie oppure quando si risolvono equazioni alle derivate parziali. Inoltre esiste hardware specializzato per gestire tali matrici nela campo del machine-learning.

Per gestire le matrici "sparse" si utiizzano algoritmi specializzati e strutture dati che sfruttano la struttura sparsa della matrice.

Una matrice viene generalmente memorizzata come array bidimensionale.
Ciascuna posizione dell'array rappresenta un elemento a(i,j) della matrice ed è accessibile tramite i due indici i e j.
Convenzionalmente, i è l'indice della riga, numerato dall'alto verso il basso, e j è l'indice della colonna, numerato da sinistra a destra.
Per una matrice m*n, la quantità di memoria richiesta è proporzionale a m*n.

Nel caso di una matrice sparsa, è possibile diminuire i requisiti di memoria memorizzando solo le voci diverse da zero, cioè comprimendo la matrice.
Esistono diversi algoritmi per comprimere una matrice sparsa che si dividono in due gruppi:

1) Metodi che rendono efficienti le modifiche alla matrice, DOK (Dictionary of keys), LIL (List of lists), o COO (Coordinate list).

Dizionario delle chiavi (DOK)
DOK è costituito da un dizionario che mappa le coppie (riga, colonna) al valore degli elementi. Gli elementi mancanti nel dizionario vengono considerati pari a zero.

Lista di liste (LIL)
LIL memorizza una lista per riga, con posizione voce contenente l'indice della colonna e il valore.
In genere, queste voci vengono ordinate in base all'indice della colonna per una ricerca più rapida.

Lista delle coordinate (COO)
COO memorizza una lista di tuple (riga, colonna, valore).
In genere, le posizioni vengono ordinate prima per indice di riga e poi per indice di colonna, per migliorare i tempi di accesso.

2) Metodi che rendono efficienti l'accesso e le operazioni sulle matrici, come CSR (Compressed Sparse Row) o CSC (Compressed Sparse Column).

Riga sparsa compressa (formato CSR, CRS o Yale)
(sono tutte la stessa forma di compressione)

Vediamo un esempio con la seguente matrice:

(setq M '((0 0 0 0)
          (5 8 0 0)
          (0 0 3 0)
          (0 6 0 0)))

L'output dovrebbe essere tre liste, A, IA e JA:

   A = (5, 8, 3, 6)
  IA = (0, 0, 2, 3, 4)
  JA = (0, 1, 2, 1,)

Il procedimento è il seguente (da Wikipedia):

La lista A ha lunghezza NNZ e contiene tutte le voci diverse da zero di M in ordine da sinistra a destra dall'alto verso il basso ("riga principale").

La lista IA ha lunghezza m + 1. È definito da questa definizione ricorsiva:

  IA[0] = 0
  IA[i] = IA[i − 1] + (numero di elementi diversi da zero sulla (i − 1)-esima riga nella matrice originale)

Pertanto, i primi m elementi di IA memorizzano l'indice in A del primo elemento diverso da zero in ciascuna riga di M, e l'ultimo elemento IA[m] memorizza NNZ, il numero di elementi in A, che può anche essere pensato come indice in A del primo elemento di una riga fantasma posizionata dopo la fine della matrice M.
I valori della i-esima riga della matrice originale si trovano negli elementi da A[IA[i]] a A[IA[i + 1] − 1] (inclusi), cioè dall'inizio di una riga all'ultimo indice subito prima dell'inizio del successivo.

La terza lista, JA, contiene l'indice di colonna in M di ciascun elemento di A e quindi è anch'esso di lunghezza NNZ.

Funzione che comprime una matrice con metodo CSR (Compressed Sparse Row):

(define (compress matrix)
  (local (rows cols val roes0 A JA IA))
  (setq rows (length matrix))
  (setq cols (length (matrix 0)))
  ; creazione lista A e JA
  (setq A '())
  (setq JA '())
  (for (i 0 (- rows 1))
    (for (j 0 (- cols 1))
      ; elemento corrente
      (setq val (matrix i j))
      (if (not (zero? val)) (begin
          ; inserisce l'elemento corrente nella lista A
          (push val A -1)
          ; inserisce l'indice di colonna dell'elemento corrente nella lista JA
          (push j JA -1))
      )
    )
  )
  ; creazione lista IA
  (setq IA (list 0))
  ; lista con il numero di elementi non-zero di ogni riga
  (setq rows0 (map (fn(x) (length (clean zero? x))) matrix))
  (for (i 1 rows)
    (push (+ (IA (- i 1)) (rows0 (- i 1))) IA -1)
  )
  (list A IA JA))

Proviamo:

(compress M)
;-> ((5 8 3 6) (0 0 2 3 4) (0 1 2 1))

(setq mm '((10 20  0  0  0  0)
           ( 0 30  0 40  0  0)
           ( 0  0 50 60 70  0)
           ( 0  0  0  0  0 80)))

(compress mm)
;-> ((10 20 30 40 50 60 70 80) (0 2 4 7 8) (0 1 1 3 2 3 4 5))

(setq mm '((0 0 0)
           (0 0 0)
           (0 0 0)))

(compress mm)
;-> (() (0 0 0 0) ())

(setq mm '((1 1 1)
           (1 1 1)
           (1 1 1)))
(compress mm)
;-> ((1 1 1 1 1 1 1 1 1) (0 3 6 9) (0 1 2 0 1 2 0 1 2))

(setq mm '((0 0 0 0)
           (5 -9 0 0)
           (0 0 0.2 0)
           (0 -399 0 0)))

(compress mm)
;-> ((5 -9 0.2 -399) (0 0 2 3 4) (0 1 2 1))

Funzione che restituisce se una matrice è sparsa o densa e il relativo indice di sparsità:

(define (tipo-mat matrix)
  (local (rows cols zeri non-zeri indice)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (setq zeri (length (filter zero? (flat matrix))))
    (setq non-zeri (length (clean zero? (flat matrix))))
    (setq indice (div zeri (mul rows cols)))
    (if (or (>= zeri rows) (>= zeri cols))
        (list "S" indice)
        (list "D" indice))))

Proviamo:

(tipo-mat M)
;-> ("S" 0.75)

(setq mm '((0 0 0) (0 0 0) (0 0 0)))
(tipo-mat mm)
;-> ("S" 1)

(setq mm '((1 1 1) (1 1 1) (1 1 1)))
(tipo-mat mm)
;-> ("D" 0)


------------------------------------------------------------------
Numeri che sono divisibili dal doppio della somma delle loro cifre
------------------------------------------------------------------

Generare la sequenza dei numeri che sono divisibili dal doppio della somma delle loro cifre.

Sequenza OEIS A134516:
Numbers that are divisible by 2*(sum of their digits)
  10, 12, 18, 20, 24, 30, 36, 40, 48, 50, 54, 60, 70, 72, 80, 90, 100, 102,
  108, 112, 120, 126, 132, 140, 144, 162, 180, 192, 200, 204, 210, 216, 224,
  230, 234, 240, 252, 264, 270, 280, 288, 300, 306, 308, 312, 320, 322, 324,
  336, 342, 360, 364, 392, 396, 400, ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (div-2digit? num) (zero? (% num (* 2 (digit-sum num)))))

(filter div-2digit? (sequence 1 400))
;-> (10 12 18 20 24 30 36 40 48 50 54 60 70 72 80 90 100 102
;->  108 112 120 126 132 140 144 162 180 192 200 204 210 216 224
;->  230 234 240 252 264 270 280 288 300 306 308 312 320 322 324
;->  336 342 360 364 392 396 400)

Nota: i numeri che sono divisibili dalla somma delle loro cifre si chiamano numeri Harshad (o di Niven).
Vedere "Numeri Harshad" su "Rosetta Code".


-------------------------------------------------
Conversione da decimale a percentuale e viceversa
-------------------------------------------------

Funzione che converte un numero decimale in percentuale (stringa):

(define (num-perc num) (string (mul num 100) "%"))

(setq n -2.453)
(num-perc n)
;-> "-245.3%"

Funzione che converte una percentuale (stringa) in numero decimale:

(define (perc-num perc) (div (float perc) 100))

(setq p "-245.3%")
(perc-num p)
;-> -2.453


------------------------------------------
Numeri che generano tutti gli interi mod p
------------------------------------------

Consideriamo gli interi modulo p dove p è primo, un generatore è un qualsiasi intero 1 < x < p tale che x^1 mod p, x^2 mod p, ..., x^(p-1) mod p generi, insieme a x, tutti gli interi compresi tra 1 e p-1.
Consideriamo ad esempio gli interi modulo 7 (M_7):
Con il numero 3 otteniamo:
3^1 = 3 mod 7 = 3
3^2 = 9 mod 7 = 2,
3 ^ 3 = 27 mod 7 = 6,
3 ^ 4 = 81 mod 7 = 4,
3 ^ 5 = 243 mod 7 = 5,
3^6 = 729 mod 7 = 1
Quindi abbiamo generato i valori 3, 2, 6, 4, 5, 1 che coprono tutti i numeri interi 1..6 come richiesto.

Scrivere una funzione che dato un numero primo p, restituisce il numero generatore M_p.
Nell'esempio il numero generatore vale 3.

Nota: è possibile dimostrare che per ogni numero primo esiste almeno un numero generatore.

Metodo forza-bruta:

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Funzione che trova tutti i generatori di un dato numero primo:

(define (trova-generatori prime)
  (local (out base lst)
    (setq out '())
    (setq base (sequence 1 (- prime 1)))
    (for (num 2 (- prime 1))
      (setq lst (list num))
      (for (pot 2 (- prime 1))
      ;(print num { } pot { } (** num pot)) (read-line)
        (push (% (** num pot) prime) lst)
      )
      (sort lst)
      (if (= lst base) (begin
        ;(println "sol = " num)
        (push num out -1))
      )
    )
    out))

Proviamo:

(trova-generatori 7)
;-> (3 5)

(trova-generatori 41)
;-> (6 7 11 12 13 15 17 19 22 24 26 28 29 30 34 35)

Funzione che verifica il risultato della funzione "trova-generatore":

(define (check prime num)
  (let (out '())
    (for (pot 1 (- prime 1))
      (setq val (** num pot))
      (setq seq (% val prime))
      (println num "^" pot " = " val " mod " prime " = " seq)
      (push (list pot val seq) out)
    )
    out))

Proviamo:

(check 7 3)
;-> 3^1 = 3L mod 7 = 3L
;-> 3^2 = 9L mod 7 = 2L
;-> 3^3 = 27L mod 7 = 6L
;-> 3^4 = 81L mod 7 = 4L
;-> 3^5 = 243L mod 7 = 5L
;-> 3^6 = 729L mod 7 = 1L
;-> ((6 729L 1L) (5 243L 5L) (4 81L 4L) (3 27L 6L) (2 9L 2L) (1 3L 3L))

(check 7 5)
;-> 5^1 = 5L mod 7 = 5L
;-> 5^2 = 25L mod 7 = 4L
;-> 5^3 = 125L mod 7 = 6L
;-> 5^4 = 625L mod 7 = 2L
;-> 5^5 = 3125L mod 7 = 3L
;-> 5^6 = 15625L mod 7 = 1L
;-> ((6 15625L 1L) (5 3125L 3L) (4 625L 2L) (3 125L 6L) (2 25L 4L) (1 5L 5L))

(check 41 6)
;-> 6^1 = 6L mod 41 = 6L
;-> 6^2 = 36L mod 41 = 36L
;-> 6^3 = 216L mod 41 = 11L
;-> 6^4 = 1296L mod 41 = 25L
;-> 6^5 = 7776L mod 41 = 27L
;-> ...
;-> 6^36 = 10314424798490535546171949056L mod 41 = 23L
;-> 6^37 = 61886548790943213277031694336L mod 41 = 15L
;-> 6^38 = 371319292745659279662190166016L mod 41 = 8L
;-> 6^39 = 2227915756473955677973140996096L mod 41 = 7L
;-> 6^40 = 13367494538843734067838845976576L mod 41 = 1L
;-> ((40 13367494538843734067838845976576L 1L)
;->  (39 2227915756473955677973140996096L 7L)
;->  (38 371319292745659279662190166016L 8L)
;->  (37 61886548790943213277031694336L 15L)
;->  (36 10314424798490535546171949056L 23L)
;->  ...
;->  (6 46656L 39L)
;->  (5 7776L 27L)
;->  (4 1296L 25L)
;->  (3 216L 11L)
;->  (2 36L 36L)
;->  (1 6L 6L))

Metodo matematico:

Se p è il numero primo e n è il numero, sappiamo che (n^(p-1) mod p = 1), quindi dobbiamo solo verificare che (n^k mod p != 1) per qualsiasi k più piccolo.
Ma k deve essere un fattore di p-1 perché ciò sia possibile, e qualsiasi multiplo di k con quella proprietà avrà anche quella proprietà, quindi dobbiamo solo verificare che (n^((p-1)/q) mod p != 1) per tutti i fattori primi q di p-1.
Quindi basta controllare tutti gli interi n da 2 a (p - 1) in ordine crescente finché non ne troviamo uno che soddisfa la proprietà.

(define (powmod base expt modulo)
"Calculates (base^exponent % modulo)"
  (let (out 1L)
    (while (> expt 0)
      (if (odd? expt)
          (setq out (% (* out base) modulo)))
      (setq base (% (* base base) modulo))
      (setq expt (/ expt 2)))
    out))

Funzione che trova tutti i generatori di un dato numero primo:

(define (find-gen prime)
  (let ( (out '()) (p1 (- prime 1)) )
    (for (num 2 (- prime 1))
      (if (for-all (fn(x) (!= (powmod num (/ p1 x) prime) 1)) (factor p1))
          (push num out -1)
      )
    )
    out))

Proviamo:

(find-gen 7)
;-> (3 5)

(find-gen 41)
;-> (6 7 11 12 13 15 17 19 22 24 26 28 29 30 34 35)

Vediamo la velocità della funzione:

(time (find-gen 99991))
;-> 1376.739
(time (find-gen 998989))
;-> 49097.197

Se invece vogliamo trovare solo il primo numero generatore di un numero primo possiamo usare la seguente funzione:

(define (find-first-gen prime)
  (let ( (out nil) (p1 (- prime 1)) (found nil) )
    (for (num 2 (- prime 1) 1 found)
      (if (for-all (fn(x) (!= (powmod num (/ p1 x) prime) 1)) (factor p1))
          (set 'found true 'out num)
      )
    )
    out))

Proviamo:

(find-first-gen 7)
;-> 3

(find-first-gen 41)
;-> 6

(find-first-gen 99991)
;-> 6
(time (find-first-gen 99991))
;-> 0

(find-first-gen 998989)
;-> 2
(time (find-first-gen 998989))
;-> 0


----------------
Numeri staircase
----------------

Un numero staircase (scala) è un intero positivo k tale che la sua n-esima cifra (quella indicizzata a partire dalla cifra meno significativa) è uguale a k % (n + 2).
Vediamo un esempio con il numero 40210:

  40210 % 2 = 0
  40210 % 3 = 1
  40210 % 4 = 2
  40210 % 5 = 0
  40210 % 6 = 4

Le cifre ottenute 4,0,2,1,0 sono uguali (e nelle stesse posizioni) del numero dato, quindi è un numero staircase.

Sequenza OEIS A319599:
Numbers k such that k mod (2, 3, 4, ... , i+1) = (d_i, d_i-1, ..., d_1),
where d_1, d_2, ..., d_i are the digits of k,
with MSD(k) = d_1 and LSD(k) = d_i
  0, 1, 10, 20, 1101, 1121, 11311, 31101, 40210, 340210, 4620020, 5431101,
  7211311, 12040210, 24120020, 151651121, 165631101, 1135531101, 8084220020,
  9117311311, 894105331101, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (staircase? num)
  (let ( (lst (reverse (int-list num))) (stair true) )
    (dolist (el lst (not stair))
      (if (!= el (% num (+ $idx 2))) (setq stair nil))
    )
    stair))

Proviamo:

(staircase? 40210)
;-> true

(staircase? 1)
;-> true
(staircase? 1)
;-> true
(staircase? 2)
;-> nil

(filter staircase? (sequence 1 1e5))
;-> (1 10 20 1101 1121 11311 31101 40210)

(filter staircase? (sequence 1 1e6))
;-> (1 10 20 1101 1121 11311 31101 40210 340210)

(time (println (filter staircase? (sequence 1 1e7))))
;-> (1 10 20 1101 1121 11311 31101 40210 340210 4620020 5431101 7211311)
;-> 15832.717


--------------------------------
Conversione RGB-CMYK e viceversa
--------------------------------

Vediamo due funzioni per convertire un colore da RGB a CMYK e viceversa.

  RGB -> Red Green Blue (0..255)
  CMYK -> Cyan Magenta Yellow Black (0..1)

Formule utilizzate:

  Black   = 1 - max(Red Green Blue)/255
  Cyan    = (1 - Red/255 - Black)/(1 - Black)
  Magenta = (1 - Green/255 - Black)/(1 - Black)
  Yellow  = (1 - Blue/255 - Black)/(1 - Black)

  Red   = 255 * (1 - Cyan/100)    * (1 - Black/100)
  Green = 255 * (1 - Magenta/100) * (1 - Black/100)
  Blue  = 255 * (1 - Yellow/100)  * (1 - Black/100)

Funzione da RGB a CMYK:

(define (rgb-cmyk red green blue)
  (local (black cyan magenta yellow col)
    (setq black (sub 1 (div (max red green blue) 255)))
    (setq col (sub 1 black))
    (setq cyan    (div (sub 1 (div red 255) black) col))
    (setq magenta (div (sub 1 (div green 255) black) col))
    (setq yellow  (div (sub 1 (div blue 255) black) col))
    (list cyan magenta yellow black)))

Proviamo:

(rgb-cmyk 10 130 45)
;-> (0.9230769230769231 0 0.6538461538461537 0.4901960784313726)

(rgb-cmyk 0 255 255)
;-> (1 0 0 0)

(apply rgb-cmyk '(210 30 45))
;-> (0 0.8571428571428571 0.7857142857142857 0.1764705882352942)

Funzione da CMYK a RGB:

(define (cmyk-rgb black cyan magenta yellow)
  (local (red green blue col)
    (setq col (sub 1 (div black 100)))
    (setq red    (mul 255 (sub 1 (div cyan 100)) col))
    (setq green  (mul 255 (sub 1 (div magenta 100)) col))
    (setq blue   (mul 255 (sub 1 (div yellow 100)) col))
    (list red green blue)))

Proviamo:

(cmyk-rgb 0.9230769230769231 0 0.6538461538461537 0.4901960784313726)
;-> (45 225 210 45)

Nota:
Le funzioni riportate sono imprecise e potrebbero produrre colori al di fuori della gamma cromatica CMYK.
Non esiste un algoritmo per convertire tra RGB e CMYK, qualunque conversione da RGB a CMYK o viceversa fatta utilizzando una formula è sbagliata.
Infatti le formule presuppongono che tutti i colori siano nella stessa gamma e semplicemente rappresentati con modalità diverse (CMYK, RGB), ma non questo è il caso.
Per una conversione precisa da RGB a CMYK e viceversa, è necessario utilizzare un profilo di colore ICC.
I numeri non significano nulla a meno che non siano associati ad un profilo di colore.
Le scale (valori in RGB o CMYK) devono appartenere a uno "spazio colore (profilo)".
I valori quindi indicano un colore "reale" (per esempio LAB)
Convertire da RGB a CMYK significa innanzitutto capire quale colore (in LAB) è rappresentato in RGB e trovare valori (esatti o vicini) ai colori rappresentati in CMYK nello spazio colore di destinazione.
Sebbene sia importante convertire da RGB a CMYK, occorre eseguirlo solo una volta perché alcuni colori vengono eliminati, compressi e modificati ogni volta.
Il passaggio da RGB a CMYK e di nuovo a RGB e poi a CMYK può degradare notevolmente un'immagine.


--------------------------------------------------
Elementi che compaiono solo una volta in una lista
--------------------------------------------------

Data una lista restituire gli elementi che compaiono solo una volta.
Per esempio:
lista  = (1 2 3 4 5 5 6 2 8 9 8)
output = (1 3 4 6 9)

Questo è diverso dalla funzione primitiva "unique":

(setq lst '(1 2 3 4 5 5 6 2 8 9 8))
(unique lst)
;-> (1 2 3 4 5 6 8 9)

Primo metodo:
Contare le occorrenze di ogni elemento e poi selezionare solo gli elementi che hanno una occorrenza.

(define (univoci lst)
  (local (out unici all)
    (setq out '())
    (setq unici (unique lst))
    ; conta le occorrenze di ogni elemento
    (setq all (map list unici (count unici lst)))
    ; filtra gli elementi che compaiono solo una volta (occorrenza = 1)
    (dolist (el all)
      (if (= (el 1) 1) (push (el 0) out -1))
    )
    out))

Proviamo:

(univoci lst)
;-> (1 3 4 6 9)

(setq a '(2 2 3 3 4 4 4 5 6 7 8 9 8))
(univoci a)
;-> (5 6 7 9)

Secondo metodo:
Aggiungere l'elemento corrente se non esiste nella lista di output e nella lista dei rimossi.
Quando si incontra un elemento che si trova in output, allora eliminarlo dalla lista di output e aggiungerlo alla lista dei rimossi.

(define (univoci2 lst)
  (local (out removed)
    ; lista di output
    (setq out '())
    ; lista degli elementi rimossi
    (setq removed '())
    (dolist (el lst)
            ; elemento corrente non in output o nei rimossi
      (cond ((and (not (find el out)) (not (find el removed)))
              ; aggiunto all'output
              (push el out -1))
            ; elemento corrente nell'output
            ((find el out)
              ; rimosso dall'output e aggiunto ai rimossi
              (pop out (find el out) out)
              (push el removed))
      )
    )
    ; (println removed)
    out))

(univoci2 lst)
;-> (1 3 4 6 9)

(setq a '(2 2 3 3 4 4 4 5 6 7 8 9 8))
(univoci2 a)
;-> (5 6 7 9)

Vediamo le velocità delle funzioni:

(setq t (rand 1000 1e3))

(time (univoci t) 100)
;-> 58.947

(time (univoci2 t) 100)
;-> 334.989


-------------------
Coppie di una lista
-------------------

Data una lista restituire tutte possibili coppie degli elementi.
Ogni coppia è costituita da elementi con indici diversi (cioè un elemento non può fare coppia con se stesso).

Funzione che restituisce una lista con tutte le possibili coppie tra gli elementi di una lista data:

(define (pair-list lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
          (push (list (lst i) (lst j)) out -1)))))

Proviamo:

(pair-list '(1 2 3))
;-> ((1 2) (1 3) (2 3))

(pair-list '("a" "b" "c" "d"))
;-> (("a" "b") ("a" "c") ("a" "d") ("b" "c") ("b" "d") ("c" "d"))

(pair-list (sequence 1 10))
;-> ((1 2) (1 3) (1 4) (1 5) (1 6) (1 7) (1 8) (1 9) (1 10) (2 3) (2 4) (2 5)
;->  (2 6) (2 7) (2 8) (2 9) (2 10) (3 4) (3 5) (3 6) (3 7) (3 8) (3 9) (3 10)
;->  (4 5) (4 6) (4 7) (4 8) (4 9) (4 10) (5 6) (5 7) (5 8) (5 9) (5 10) (6 7)
;->  (6 8) (6 9) (6 10) (7 8) (7 9) (7 10) (8 9) (8 10) (9 10))


--------------------
Costo di una stringa
--------------------

Il "costo" di una stringa viene calcolato sommando i costi di ogni carattere.
Il costo di ciascun carattere è pari al numero di volte in cui il carattere è comparso fino a questo punto nella stringa.

Per esempio:
stringa = a b b a z i a
          1     2     3 (occorrenze di a)
            1 2         (occorrenze di b)
                  1     (occorrenze di z)
                    1   (occorrenze di i)
Costo della stringa = Somma dei costi dei caratteri =
                    = (1 + 2 + 3) + (1 + 2) + (1) + (1) = 11


(setq str (explode "abbazia"))
;-> ("a" "b" "b" "a" "z" "i" "a")

Conta le occorrenze dei caratteri:
(setq conta (count (unique str) str))
;-> (3 2 1 1)

Funzione che calcola la somma da 1 a num:

(define (sum num) (/ (* num (+ num 1)) 2))
(sum 3)
;-> 6

Calcola la somma dei costi di ogni carattere:
(setq somma (apply + (map sum conta)))
;-> 11

oppure

(setq somma (apply + (flat (map (curry sequence 1) conta))))
;-> 11

Funzione finale:

(define (costo str)
  (let (lst (explode str))
    (apply + (map (fn(x) (/ (* x (+ x 1)) 2)) (count (unique lst) lst)))))

Proviamo:

(costo "abbazia")
;-> 11
(costo "aAaA")
;-> 6
(costo "zuzzurellone")
;-> 18
(costo "----------")
;-> 55


----------------------------------------------
Stampare un numero con un display a 7 segmenti
----------------------------------------------

Data un numero intero, stampare il numero con i seguenti caratteri (display 7-segments):
  _       _   _         _    _   _    _    _
 | |  |   _|  _|  |_|  |_   |_    |  |_|  |_|
 |_|  |  |_   _|    |   _|  |_|   |  |_|   _|
 (0) (1) (2) (3)  (4)  (5)  (6)  (7) (8)  (9)

Per esempio dato il numero 467 l'output dovrebbe essere il seguente:
     _  _
 |_||_   |
   ||_|  |

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (segments)
  (local (d0 d1 d2 d3 d4 d5 d6 d7 d8 d9)
    ; dx rappresenta le righe (stringhe) che compongono la cifra x
    (setq d0 '(" _ " "| |" "|_|"))
    (setq d1 '("   " " | " " | "))
    (setq d2 '(" _ " " _|" "|_ "))
    (setq d3 '(" _ " " _|" " _|"))
    (setq d4 '("   " "|_|" "  |"))
    (setq d5 '(" _ " "|_ " " _|"))
    (setq d6 '(" _ " "|_ " "|_|"))
    (setq d7 '(" _ " "  |" "  |"))
    (setq d8 '(" _ " "|_|" "|_|"))
    (setq d9 '(" _ " "|_|" " _|"))
    (list d0 d1 d2 d3 d4 d5 d6 d7 d8 d9)))

Funzione che stampa un numero ato con un display a 7 segmenti:

(define (display num)
  (local (line segmenti altezza lst str)
   (setq line '())
   (setq segmenti (segments))
   ; numero caratteri dei segmenti in altezza
   (setq altezza (length (segmenti 0)))
   (setq lst (int-list num))
   ; ciclo per creare le linee di caratteri
   ; (numero-linee = altezza
   (for (i 0 (- altezza 1))
     (setq str '())
     ; ciclo per ogni cifra del numero
     (dolist (cifra lst)
       ; inserisce su 'str' la stringa ad altezza 'i' della cifra corrente
       (push (d cifra i) str -1)
     )
     ; inserisce la stringa 'str' sulle linee da stampare
     (push (join str) line -1)
   )
   ; stampa le linee
   (map println line)
   '------------))

Proviamo:

(display 467)
;->     _  _
;-> |_||_   |
;->   ||_|  |
;-> ------------

(display 1234567890)
;->     _  _     _  _  _  _  _  _
;->  |  _| _||_||_ |_   ||_||_|| |
;->  | |_  _|  | _||_|  ||_| _||_|
;-> ------------

Un altro modo di rappresentare le cifre del display a 7-segmenti è il seguente:

   0       1       2       3       4       5       6       7       8       9
  ■■■     ---     ■■■     ■■■     ---     ■■■     ■■■     ■■■     ■■■     ■■■
 █   █   |   █   |   █   |   █   █   █   █   |   █   |   |   █   █   █   █   █
  ---     ---     ■■■     ■■■     ■■■     ■■■     ■■■     ---     ■■■     ■■■
 █   █   |   █   █   |   |   █   |   █   |   █   █   █   |   █   █   █   |   █
  ■■■     ---     ■■■     ■■■     ---     ■■■     ■■■     ---     ■■■     ■■■
  (6)     (2)     (5)     (5)     (4)     (5)     (6)     (7)     (8)     (9)


-----------------------
Il gioco del monocolore
-----------------------

Il gioco si svolge nel modo seguente:
1) generare una matrice quadrata NxN di colori (numeri da 1 a 9)
2) convertire l'intera matrice ad un solo colore (numero) con una serie di mosse
3) Una mossa consiste nell'assegnare un nuovo colore (numero) alla cella in alto a sinistra.
   Tutte le celle adiacenti alla cella in alto a sinistra che hanno lo stesso colore (vecchio) prendono anch'esse il nuovo colore. Questo processo viene eseguito ricorsivamente per ogni cella adiacente a quelle che prendono il nuovo colore (flood-fill).

Vediamo un esempio:

Matrice iniziale
  1 2 3
  1 1 3
  2 2 2

Coloriamo la cella in altro a sinistra con il numero 3:

Nuova matrice
  3 2 3
  3 3 3
  2 2 2

Coloriamo la cella in altro a sinistra con il numero 2:

Nuova matrice
  2 2 2
  2 2 2
  2 2 2

Abbiamo raggiunto una matrice monocolore (mononumero).

Funzione che stampa la griglia di gioco (matrice):

(define (print-grid grid)
  (local (row col)
    (setq row (length grid))
    (setq col (length (first grid)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print " " (grid i j))
      )
      (println)))
      '-----------)

(setq m '((2 2 3 0)
          (3 2 2 1)
          (0 3 2 0)
          (3 3 2 0)))

(print-grid m)
;->  2 2 3 0
;->  3 2 2 1
;->  0 3 2 0
;->  3 3 2 0
;-> -----------

Funzione che genera una matrice casuale NxN con N colori (numeri):

(define (new-game N)
  ; numero di mosse effettuate
  (setq mosse 0)
  ; matrice di gioco NxN
  (setq grid (array-list (array N N (rand N (* N N)))))
  (print-grid grid))

(new-game 3)
;->  1 2 1
;->  1 0 2
;->  1 2 0
;-> -----------

Funzione che applica l'algoritmo flood-fill ad una matrice partendo da una cella predefinita con un colore predefinito:

(define (flood-fill img x y new-color)
  (local (old-color dir max-x max-y)
    (setq max-x (length img))
    (setq max-y (length (img 0)))
    (setq dir '((0 1) (0 -1) (1 0) (-1 0)))
    ;------------------
    ; recursive fill
    (define (fill x y)
    (catch
      (local (new-x new-y)
        (setq old-color (img x y))
        (if (= old-color new-color) (throw img))
        (setf (img x y) new-color)
        (for (i 0 (- (length dir) 1))
          (setq new-x (+ x (dir i 0)))
          (setq new-y (+ y (dir i 1)))
          (cond ((or (< new-x 0) (>= new-x max-x) (< new-y 0) (>= new-y max-y)) nil)
                ((!= (img new-x new-y) old-color) nil)
                (true (fill new-x new-y))
          )
        )
        img)))
     ;------------------
     (fill x y)))

Flood-fill con colore 3 dalla cella (0,0):

(print-grid (flood-fill m 0 0 1))
;->  1 1 3 0
;->  3 1 1 1
;->  0 3 1 0
;->  3 3 1 0
;-> -----------

Funzione che effettua una mossa:

(define (colore col)
  (setq grid (flood-fill grid 0 0 col))
  (print-grid grid)
  (if (end-game? grid) (println "Matrice monocolore"))
  (println "Mosse: " (++ mosse)))

Funzione che verifica se una matrice è costituita da un solo colore (numero):

(define (end-game? grid) (apply = (flat grid)))

Adesso abbiamo le seguenti funzioni per giocare una partita:
1) "(new-game N)", per iniziare un nuovo gioco con una matrice NxN
2) "(colore col)", per colorare ricorsivamente la matrice partendo dalla cella in alto a sinistra

Facciamo una prova:

(new-game 4)
;->  2 1 3 0
;->  0 3 2 2
;->  3 0 3 2
;->  1 0 2 0
;-> -----------
(colore 0)
;->  0 1 3 0
;->  0 3 2 2
;->  3 0 3 2
;->  1 0 2 0
;-> Mosse: 1
(colore 1)
;->  1 1 3 0
;->  1 3 2 2
;->  3 0 3 2
;->  1 0 2 0
;-> Mosse: 2
(colore 3)
;->  3 3 3 0
;->  3 3 2 2
;->  3 0 3 2
;->  1 0 2 0
;-> Mosse: 3
(colore 2)
;->  2 2 2 0
;->  2 2 2 2
;->  2 0 3 2
;->  1 0 2 0
;-> Mosse: 4
(colore 0)
;->  0 0 0 0
;->  0 0 0 0
;->  0 0 3 0
;->  1 0 2 0
;-> Mosse: 5
(colore 1)
;->  1 1 1 1
;->  1 1 1 1
;->  1 1 3 1
;->  1 1 2 1
;-> Mosse: 6
(colore 3)
;->  3 3 3 3
;->  3 3 3 3
;->  3 3 3 3
;->  3 3 2 3
;-> Mosse: 7
(colore 2)
;->  2 2 2 2
;->  2 2 2 2
;->  2 2 2 2
;->  2 2 2 2
;-> Matrice monocolore
;-> Mosse: 8


Versione a colori
-----------------

; nuova funzione
(define (make-colors num)
  ; definizione dei colori con codici ANSI Escape
  ; black is not visible on black background
  ;(setq black "\027[0;30m")
  (setq red "\027[0;31m")
  (setq green "\027[0;32m")
  (setq yellow "\027[0;33m")
  (setq blue "\027[0;34m")
  (setq magenta "\027[0;35m")
  (setq cyan "\027[0;36m")
  (setq white "\027[0;37m")
  ; bright color
  (setq black-b "\027[0;90m")
  (setq red-b "\027[0;91m")
  (setq green-b "\027[0;92m")
  (setq yellow-b "\027[0;93m")
  (setq blue-b "\027[0;94m")
  (setq magenta-b "\027[0;95m")
  (setq cyan-b "\027[0;96m")
  (setq white-b "\027[0;97m")
  ; restore color to default
  (setq reset-all "\027[39;49m")
  ;(println reset-all)
  ; restore all to default
  (setq default-all "\027[0;0m")
  ;(println default-all)
  ; Tabella con i 16 colori
  (setq col15 '(red green yellow blue magenta cyan white
                black-b red-b green-b yellow-b blue-b magenta-b cyan-b white-b))
  ; colori da usare nel gioco
  (setq colori (slice col15 0 num))
)

; funzione modificata
(define (new-game N)
  ; crea i colori
  (make-colors N)
  ; numero di mosse effettuate
  (setq mosse 0)
  ; matrice di gioco NxN
  (setq grid (array-list (array N N (rand N (* N N)))))
  (print-grid grid))

; funzione modificata
(define (print-grid grid)
  (local (row col)
    (setq row (length grid))
    (setq col (length (first grid)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (eval (colori (grid i j))) "██")
      )
      (println)))
    (println default-all)
    ; stampa di tutti i colori:
    (map (fn(x) (print (format "%2d " x))) (sequence 0 (- (length colori) 1)))
    (println)
    (dolist (c colori)
      (print (eval c) "██ ")
    )
    (println default-all)
    '-----------)

; stessa funzione
(define (flood-fill img x y new-color)
  (local (old-color dir max-x max-y)
    (setq max-x (length img))
    (setq max-y (length (img 0)))
    (setq dir '((0 1) (0 -1) (1 0) (-1 0)))
    ;------------------
    ; recursive fill
    (define (fill x y)
    (catch
      (local (new-x new-y)
        (setq old-color (img x y))
        (if (= old-color new-color) (throw img))
        (setf (img x y) new-color)
        (for (i 0 (- (length dir) 1))
          (setq new-x (+ x (dir i 0)))
          (setq new-y (+ y (dir i 1)))
          (cond ((or (< new-x 0) (>= new-x max-x) (< new-y 0) (>= new-y max-y)) nil)
                ((!= (img new-x new-y) old-color) nil)
                (true (fill new-x new-y))
          )
        )
        img)))
     ;------------------
     (fill x y)))

; stessa funzione
(define (colore col)
  (setq grid (flood-fill grid 0 0 col))
  (print-grid grid)
  (if (end-game? grid) (println "Matrice monocolore"))
  (println "Mosse: " (++ mosse)))

; stessa funzione
(define (end-game? grid) (apply = (flat grid)))

Una partita si trova nel file "monocolore.png" nella cartella "data".


---------------------------------------------------
Numeri in base fattoriale (Factorial number system)
---------------------------------------------------

Vediamo due funzioni per convertire un numero N da base decimale a base fattoriale e viceversa.
Il numero fattoriale viene rappresentato con una lista (es. (3 5 0 1))

Base 10
-------
numero = 56372

  10^4 10^3 10^2 10^1 10^0
    5    6    3    7    2

  (10000*5) + (1000*6) + (100*3) + (10*7) + (1*2) =
  = 50000 + 6000 + 300 + 70 + 2 = 56372

Base fattoriale
---------------
numero = (1 3 1 1 3 3 1 0 0)

  8! 7! 6! 5! 4! 3! 2! 1! 0!
  1  3  1  1  3  3  1  0  0

  (8!*1) + (7!*3) + (6!*1) + (5!*1) + (4!*3) +
  + (3!*3) + (2!*1) + (1!*0) + (0!*0) =
  = 40320 + 15120 + 720 + 120 + 72 + 18 + 2 = 56372

numero = (3 4 1 0 1 0)

  5! 4! 3! 2! 1! 0!
  3  4  1  0  1  0

  (5!*3) + (4!*4) + (3!*1) + (2!*0) + (1!*1) + (0!*0) =
  = 360 + 96 + 6 + 0 + 1 + 0 = 463

Algoritmo per convertire un numero da base decimale a base fattoriale
---------------------------------------------------------------------
È possibile convertire un numero da base decimale a base fattoriale (producendo le cifre da destra a sinistra), dividendo ripetutamente il numero per la radice (1, 2, 3, ...), prendendo il resto come cifra e continuando con il quoziente intero, finché questo quoziente diventa 0.

Ad esempio, 463 viene trasformato in base fattoriale nel modo seguente:

463 / 1 = 463, resto 0
463 / 2 = 231, resto 1
231 / 3 =  77, resto 0
 77 / 4 =  19, resto 1
 19 / 5 =   3, resto 4
  3 / 6 =   0, resto 3

Il processo termina quando il quoziente raggiunge lo zero.
Prendendo i resti all'indietro si ottiene il numero (3 4 1 0 1 0).

(define (fact num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

Funzione che converte dalla rappresentazione decimale a quella fattoriale:

(define (dec-fact num)
  (let ( (out '()) (radice 1) )
    (while (> num 0)
      (push (% num radice) out)
      (setq num (/ num radice))
      (++ radice)
    )
    out))

Proviamo:

(dec-fact 56372)
;-> (1 3 1 1 3 3 1 0 0)

(dec-fact 463)
;-> (3 4 1 0 1 0)

Funzione che converte dalla rappresentazione fattoriale a quella decimale:

(define (fact-dec fac)
  (let (num 0)
    (dolist (digit (reverse fac))
      (++ num (* (fact $idx) digit))
    )
    num))

Proviamo:

(fact-dec '(1 3 1 1 3 3 1 0 0))
;-> 56372

(fact-dec '(3 4 1 0 1 0))
;-> 463

(fact-dec (dec-fact 56372))
;-> 56372

Possiamo anche scrivere la funzione senza usare il fattoriale.
Infatti algebricamente risulta (per esempio):

  (5!*3) + (4!*4) + (3!*1) + (2!*0) + (1!*1) + (0!*0) =
  = ((((3*5 + 4)*4 + 1)*3 + 0)*2 + 1)*1 + 0

Quindi usando la seconda espressione non dobbiamo calcolare alcun fattoriale.

(define (fact-dec1 fac)
  (let (num 0)
    (setq len (length fac))
    (setq num (* (- len 1) (fac 0)))
    (for (i 1 (- len 2))
      (setq num (* (+ num (fac i)) (- len i 1)))
    )
    (++ num (fac -1))
    num))

(fact-dec1 '(1 3 1 1 3 3 1 0 0))
;-> 56372

(fact-dec1 '(3 4 1 0 1 0))
;-> 463

Vediamo la velocità di "fact-dec" e "fact-dec1":

(setq f '(1 2 3 4 5 6 7 8 9 0))
(fact-dec f)
;-> 462331
(fact-dec1 f)
;-> 462331

(time (fact-dec f) 1e5)
;-> 1158.624
(time (fact-dec1 f) 1e5)
;-> 129.96

Primi 100 numeri in base fattoriale (stringhe):

(map (fn(x) (format "%06s" x))
     (map join
          (map (fn(x) (map string x)) (map dec-fact (sequence 1 100)))))
;-> ("000010" "000100" "000110" "000200" "000210" "001000" "001010" "001100"
;->  "001110" "001200" "001210" "002000" "002010" "002100" "002110" "002200"
;->  "002210" "003000" "003010" "003100" "003110" "003200" "003210" "010000"
;->  "010010" "010100" "010110" "010200" "010210" "011000" "011010" "011100"
;->  "011110" "011200" "011210" "012000" "012010" "012100" "012110" "012200"
;->  "012210" "013000" "013010" "013100" "013110" "013200" "013210" "020000"
;->  "020010" "020100" "020110" "020200" "020210" "021000" "021010" "021100"
;->  "021110" "021200" "021210" "022000" "022010" "022100" "022110" "022200"
;->  "022210" "023000" "023010" "023100" "023110" "023200" "023210" "030000"
;->  "030010" "030100" "030110" "030200" "030210" "031000" "031010" "031100"
;->  "031110" "031200" "031210" "032000" "032010" "032100" "032110" "032200"
;->  "032210" "033000" "033010" "033100" "033110" "033200" "033210" "040000"
;->  "040010" "040100" "040110" "040200")


------------------------------------------------
Ordinamento di numeri in base all'Hamming weight
------------------------------------------------

Data una lista di numeri da 1 a N, ordinare i numeri (crescente) in base al loro Hamming weight e al valore del numero (cioè i numeri con la stessa distanza di Hamming devono essere ordinati in modo crescente).
L'Hamming weight (peso di Hamming) di un intero è il numero di uno nella sua rappresentazione binaria.

Funzione che calcola l'Hamming weight di un numero intero:

(define (hamming num)
  (let (counter 0)
    (while (> num 0)
      ; In questo modo arriviamo al prossimo bit impostato (successivo '1')
      ; invece di eseguire il ciclo per ogni bit e controllare se vale '1'.
      ; Quindi il ciclo non verrà eseguito per tutti i bit,
      ; ma verrà eseguito solo tante volte quanti sono gli '1'.
      (setq num (& num (- num 1)))
      (++ counter)
    )
    counter))

Algoritmo:

Costruire tutte le coppie (distanza-hamming numero) da 1 a 10:
(setq coppie (map (fn(x) (list (hamming x) x)) (sequence 1 10)))
;-> ((1 1) (1 2) (2 3) (1 4) (2 5) (2 6) (3 7) (1 8) (2 9) (2 10))

Ordinare le coppie in base alla distanza di Hamming e al numero:
(sort coppie)
;-> ((1 1) (1 2) (1 4) (1 8) (2 3) (2 5) (2 6) (2 9) (2 10) (3 7))

Estrarre i numeri da ogni coppia:
(map last coppie)
;-> (1 2 4 8 3 5 6 9 10 7)

(define (hamming-sort num)
  (let (coppie (map (fn(x) (list (hamming x) x)) (sequence 1 num)))
    (map last (sort coppie))))

Proviamo:

(hamming-sort 10)
;-> (1 2 4 8 3 5 6 9 10 7)

In genere l'ordinamento cambia usando un altro numero:

(hamming-sort 20)
;-> (1 2 4 8 16 3 5 6 9 10 12 17 18 20 7 11 13 14 19 15)
Infatti adesso il 16 viene prima del 3, oppure tra il 10 e il 7 adesso abbiamo 12,17,18,20.


-----------------
Pistola difettosa
-----------------

Abbiamo una pistola difettosa: quando spariamo non sempre funziona.
Sia N il numero iniziale di proiettili e I il numero di proiettili rimasti.
Al primo colpo la pistola funziona sempre.
Per i colpi successivi la probabilità che la pistola funzioni vale I/N (cioè, meno proiettili restano e più tentativi saranno necessari per sparare un proiettile).

Esempio:
N = 3
Primo tentativo sempre positivo
N = 2
Adesso abbiamo 2/3 di probabilità di sparare e 1/3 di non-sparare.
Quindi la probabilità di sparare tutti i colpi senza nessun malfunzionamento vale:
3/3 * 2/3 * 1/3 = 0.222222(2)

Trovare il trovare il numero medio di tentativi di tiro per utilizzare tutti i proiettili.

Scriviamo una funzione che simula la pistola.

(define (pistola N iter)
  (local (rimasti colpi colpi-tot)
    (setq colpi-tot 0)
    (for (i 1 iter)
      (setq rimasti N)
      (setq colpi 1)
      (-- rimasti)
      (while (> rimasti 0)
        (++ colpi)
        (setq sparo (random))
        (if (> sparo (div rimasti N)) (-- rimasti))
      )
      (++ colpi-tot colpi)
    )
    (div colpi-tot iter)))

Proviamo:

(pistola 3 1e6)
;-> 5.499439

(pistola 5 1e6)
;-> 11.420694

(pistola 10 1e6)
;-> 29.271898

Possiamo verificare i risultati con la soluzione matematica, infatti si può dimostrare che il numero medio di tentativi vale:

  media(N) = Sum[i=1..n](n/i)

(define (gun-math n)
  (apply add (map (curry div n) (sequence 1 n))))

Proviamo:

(map (fn(x) (list x (gun-math x))) (sequence 1 10))
;-> ((1 1) (2 3) (3 5.5) (4 8.333333) (5 11.41666666) (6 14.7) (7 18.15)
;->  (8 21.742857) (9 25.460714) (10 29.289683))


--------------------
Sequenze intrecciate
--------------------

Dato un numero N costruire una stringa intrecciando i numeri delle sequenze 1..N e N..1.
Intrecciare = primo elemento prima lista, primo elemento seconda lista,
              secondo elemento prima lista, secondo elemento seconda lista,
              ...
              ultimo elemento prima lista, ultimo elemento seconda lista.

Per esempio con N = 3:
  sequenza 1..3 = (1 2 3)
  sequenza 3..1 = (3 2 1)
  Output: 132231

Algoritmo:

(setq N 3)
(setq a (map list (sequence 1 N) (sequence N 1)))
;-> ((1 3) (2 2) (3 1))
(setq b (flat a))
;-> (1 3 2 2 3 1)
(setq c (map string b))
;-> ("1" "3" "2" "2" "3" "1")
(setq d (join c))
;-> "132231"

Funzione finale:

(define (intreccia N)
  (join (map string (flat (map list (sequence 1 N) (sequence N 1))))))

Proviamo:

(intreccia 3)
;-> "132231"

(intreccia 10)
;-> "1102938475665748392101"


---------------------
Sequenza di Divinacci
---------------------

La sequenza di Divinacci è definita nel modo seguente:

  d(1) = 1
  d(2) = 1
  d(n) = = sum(divisors(d(n-1))) + sum(divisors(d(n-2)))

Sequenza OEIS A000458:
a(0) = a(1) = 1, a(n) = sigma(a(n-1)) + sigma(a(n-2))
  1, 1, 2, 4, 10, 25, 49, 88, 237, 500, 1412, 3570, 12846, 36072, 126504,
  493920, 2358720, 12292224, 49984224, 171237888, 642804078, 1980490350,
  6380883000, 27032104440, 117961599600, 555861355920, ...

sigma(n) = somma dei divisori di n (1 e n compresi)

La sequenza è simile alla sequenza di Fibonacci:

  f(1) = 1
  f(2) = 1
  f(n) = f(n-1) + f(n-2)

Quindi partiamo dalla funzione che calcola la sequenza di Fibonacci e la modifichiamo per scrivere la sequenza di Divinacci.

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn ( (fattori (factor num))
            (unici (unique fattori)) )
      (transpose (list unici (count unici fattori))))))

(define (divisors-sum num)
"Sum all the divisors of integer number"
(if (zero? num) 0
  ;else
  (local (sum out)
    (if (= num 1)
        1
        (begin
          (setq out 1)
          (setq lst (factor-group num))
          (dolist (el lst)
            (setq sum 0)
            (for (i 0 (last el))
              (setq sum (+ sum (pow (first el) i)))
            )
            (setq out (* out sum))))))))

(define (fibo-i num)
"Calculates the Fibonacci number of an integer number"
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 (- num 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a))

Funzione che calcola il numero Divinacci di un numero intero:

(define (divinacci num)
  (local (a b c)
    (setq a 0 b 1 c 0)
    (for (i 0 (- num 1))
      (setq c (+ (divisors-sum a) (divisors-sum b)))
      (setq a b)
      (setq b c)
    )
    a))

Proviamo:

(map divinacci (sequence 1 20))
;-> (1 1 2 4 10 25 49 88 237 500 1412 3570 12846 36072
;->  126504 493920 2358720 12292224 49984224 171237888)


----------
List merge
----------

Date N liste L1, L2, ..., LN con lo stesso numero di elementi M generare una lista con il seguente formato:

  ((L1(0) L2(0) ... LN(0))
   (L1(1) L2(1) ... LN(1))
   ...
   (L1(M-1) L2(M-1) ... LN(M-1)))

In altre parole, la lista da generare è fatta nel modo seguente:

((primo elemento prima lista, primo elemento seconda lista, ... primo elemento N-esima lista)
 (secondo elemento prima lista, secondo elemento seconda lista, ... secondo elemento N-esima lista)
 ...
 (ultimo elemento prima lista, ultimo elemento seconda lista, ... ultimo elemento N-esima lista))

Esempio:

L1 = (1 2 3)
L2 = (a b c)
L3 = (+ - *)

Output = ((1 a +) (2 b -) (3 c *))

Funzione che effettua il merge di N liste:

(define (merge-list) (transpose (args)))

Proviamo:

(merge-list '(1 2 3) '(a b c) '(+ - *))
;-> ((1 a +) (2 b -) (3 c *))

(setq nomi '("sara" "marco" "luca"))
(setq eta '(32 40 28))
(setq peso '(50 72 78))
(setq altezza '(170 180 185))

(merge-list nomi eta peso altezza)
;-> (("sara" 32 50 170) ("marco" 40 72 180) ("luca" 28 78 185))

Vedere anche "List mix" su "Note libere 20".


---------------------
GCD e LCM di frazioni
---------------------

Il massimo comun divisore di due numeri interi 'a' e 'b' MCD(a,b) è il numero naturale più grande per il quale possono essere divisi entrambi.
Se i numeri 'a' e 'b' sono entrambi uguali a 0, allora MCD(a,b)=0.

Il minimo comune multiplo di due numeri interi 'a' e 'b', indicato con MCM(a,b), è il più piccolo numero intero positivo multiplo sia di 'a' sia di 'b'.
Nel caso in cui uno tra 'a' o 'b' è uguale a zero, allora si definisce MCM(a,b)=0.

Queste definizioni possono essere applicate anche alle frazioni.

Date due frazioni (numeri razionali) ridotte ai minimi termini a/b e c/d (dove b e d non valgono zero), mcd = MCD(a/b, c/d) e mcm = MCM(a/b, c/d) sono definiti in modo tale che ciascuna frazione divisa per mcd sia un numero intero e lcm divisa per ciascuna frazione sia un numero intero.

Le seguenti formule soddisfano questa definizione:

  MCD(a/b,c/d) = MCD(a,c) / MCM(b,d)
  MCM(a/b,c/d) = MCM(a,c) / MCD(b,d)

Nota che queste generalizzano le formule per gli interi poiché:

  MCD(a,c) = MCD(a/1,c/1) = MCD(a,c) / MCM(1, 1) = MCD(a,c)
  MCM(a,c) = MCM(a/1,c/1) = MCM(a,c) / MCD(1, 1) = MCM(a,c)

Una frazione n/d è ridotta ai minimi termini se gcd(n,d) = 1.

Per gli interi la formula del prodotto è la seguente:

  a*c = MCM(a,c) * MCD(a,c) per gli interi.

Quella equivalente per i numeri razionali è:

  (a/b) * (c/d) = (a*c) / (b*d) =
  = (MCM(a,c) * MCD(a,c)) / (MCM(b,d) * MCD(b,d)) =
  = (MCD(a,c) / MCM(b,d)) * (MCM(a,c) / MCD(b,d)) =
  = MCD(a/b, c/d) * LCM(a/b, c/d)

Nota: GCD (Greatest Common Divisor) = MCD (Massimo Comun Divisore),
      LCM (Least Common Divisor) = MCM (Minimo Comune Multiplo)

Formula generica per il calcolo del GCD di due frazioni:

                  GCD(a*d,b*c)
  GCD(a/b,c/d) = --------------
                      b*d

Se le frazioni sono ridotte ai minimi termini allora risulta:

                  GCD(a,c)
  GCD(a/b,c/d) = ----------, se GCD(a,b) = GCD(c,d) = 1    (1)
                  LCM(b,d)

                  LCM(a,c)
  LCM(a/b,c/d) = ----------, se GCD(a,b) = GCD(c,d) = 1    (2)
                  GCD(b,d)


Formula per il calcolo del GCD (Greatest Common Divisor) di N frazioni ridotte ai minimi termini:

          GCD of all the numerator of fractions
  GCD = -----------------------------------------          (3)
         LCM of all the denominator of fractions

Formula per il calcolo del LCM (Least Common Multiple) di N frazioni ridotte ai minimi termini:

          LCM of all the numerator of fractions
  LCM = -----------------------------------------          (4)
         GCD of all the denominator of fractions

Funzioni per il calcolo del lcm di numeri interi:

(define (lcm_ a b) (/ (* a b) (gcd a b)))
(define-macro (lcm)
"Calculates the lcm of two or more number"
  (apply lcm_ (map eval (args)) 2))

Funzioni per il calcolo delle quattro operazioni
aritmetiche con le frazioni: "+", "-" "*" "/"
(big-integer enabled)
Note: 0 is '(0 1)
La funzione 'rat' riduce una frazione n/d ai minimi termini.

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))
(define (+rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (+ (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1L) (r2 1L))))
(define (-rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (- (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1) (r2 1))))
(define (*rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 0L))
       (* (r1 1L) (r2 1L))))
(define (/rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 1L))
       (* (r1 1L) (r2 0L))))

Funzione che calcola gcd di due frazioni (formula (1)):

(define (gcd-r r1 r2)
    (setq r1 (rat (first r1) (last r1)))
    (setq r2 (rat (first r2) (last r2)))
    (rat (gcd (first r1) (first r2)) (lcm (last r1) (last r2))))

(gcd-r '(10 20) '(40 30))
;-> (1L 6L)
(gcd-r '(1 2) '(40 30))
;-> (1L 6L)

Funzione che calcola lcm di due frazioni (formula (2)):

(define (lcm-r r1 r2)
    (setq r1 (rat (first r1) (last r1)))
    (setq r2 (rat (first r2) (last r2)))
    (rat (lcm (first r1) (first r2)) (gcd (last r1) (last r2))))

(lcm-r '(10 20) '(40 30))
;-> (4L 1L)
(lcm-r '(1 2) '(40 30))
;-> (4L 1L)

Funzione che calcola gcd di due o più frazioni (formula (1)):

(define-macro (gcd-f)
"Calculates the gcd of two or more fractions"
  (apply gcd-r (map eval (args)) 2))

(gcd-f '(10 20) '(40 30))
;-> (1L 6L)
(gcd-f '(1 2) '(40 30))
;-> (1L 6L)

(gcd-f '(77 120) '(4 11) '(14 45))
;-> (1L 3960L)

Funzione che calcola lcm di due o più frazioni (formula (2)):

(define-macro (lcm-f)
"Calculates the lcm of two or more fractions"
  (apply lcm-r (map eval (args)) 2))

(lcm-f '(10 20) '(40 30))
;-> (4L 1L)
(lcm-f '(1 2) '(40 30))
;-> (4L 1L)

(lcm-f '(77 120) '(4 11) '(14 45))
;-> (308L 1L)

Funzione che calcola gcd di due o più frazioni (formula (3)):

(define (gcd-frac)
  (setq lst '())
  ; riduce le frazioni ai minimi termini
  (doargs (f) (push (apply rat f) lst))
  ; calcola gcd delle frazioni
  (rat (apply gcd (map first lst))
       (apply lcm (map last lst))))

(gcd-frac '(10 20) '(40 30))
;-> (1L 6L)
(gcd-frac '(1 2) '(40 30))
;-> (1L 6L)

(gcd-frac '(77 120) '(4 11) '(14 45))
;-> (1L 3960L)

Funzione che calcola lcm di due o più frazioni (formula (4)):

(define (lcm-frac)
  (setq lst '())
  ; riduce le frazioni ai minimi termini
  (doargs (f) (push (apply rat f) lst))
  ; calcola lcm delle frazioni
  (rat (apply lcm (map first lst))
       (apply gcd (map last lst))))

(lcm-frac '(10 20) '(40 30))
;-> (4L 1L)
(lcm-frac '(1 2) '(40 30))
;-> (4L 1L)

(lcm-frac '(77 120) '(4 11) '(14 45))
;-> (308L 1L)


----------------------------------------------
Alternare maiuscolo e minuscolo in una stringa
----------------------------------------------

Data una stringa convertire i caratteri alternando maiuscolo e minuscolo.
I caratteri non alfanumerici non devono essere convertiti.
Si inizia con il maiuscolo e si alterna per tutti i caratteri.
Per esempio:
stringa = "newLISP is great"
output  = "NeWlIsP iS gReAt"

(char "a")
;-> 97
(char "z")
;-> 122

(char "A")
;-> 65
(char "Z")
;-> 90

(define (alternate str)
  (setq out "")
  (setq upper true)
  (dostring (ch str)
    (cond ((or (and (>= ch 97) (<= ch 122))
                    (and (>= ch 65) (<= ch 90)))
            (if upper (push (upper-case (char ch)) out -1)
                      (push (lower-case (char ch)) out -1)
            )
            (setq upper (not upper)))
          (true (push (char ch) out -1))
    )
  )
  out)

Proviamo:

(alternate "newLISP is great")
;-> "NeWlIsP iS gReAt"

(alternate "newLISP is great")

Con tre pangrammi:

(alternate "Quel vituperabile xenofobo zelante assaggia il whisky ed esclama: alleluja!")
"QuEl ViTuPeRaBiLe XeNoFoBo ZeLaNtE aSsAgGiA iL wHiSkY eD eScLaMa: AlLeLuJa!"

(alternate "Fabrizio ha visto Max acquistandogli juta per New York")
;-> "FaBrIzIo Ha ViStO mAx AcQuIsTaNdOgLi JuTa PeR nEw YoRk"

(alternate "The quick brown fox jumps over the lazy dog")
;-> "ThE qUiCk BrOwN fOx JuMpS oVeR tHe LaZy DoG"


---------------------------------------
Rettangoli all'interno di un rettangolo
---------------------------------------

Dato un rettangolo MxN, determinare quanti rettangoli AxB possiamo posizionare al massimo all'interno del rettangolo dato.

Per disegnare un rettangolo più piccolo hai bisogno di un lato orizzontale e di un lato verticale.
Un lato orizzontale può essere scelto al massimo in M/A modi.
Un lato verticale può essere scelto al massimo in N/B modi.
Quindi per il Principio Fondamentale del Conteggio il rettangolo può essere formato al massimo dal seguente numero di rettangoli:

 (M/A)/(N/B) = (M*N)/(A*B)

(define (num-rect m n a b)
  (list (/ (* m n) (* a b))
        (div (* m n) (* a b))))

Proviamo:

(num-rect 4 5 1 1)
;-> (20 20)

(num-rect 10 20 1 2)
;-> (100 100)

(num-rect 11 21 1 2)
;-> (115 115.5)

Quando il risultato non è una coppia di interi, allora i rettangoli AxB non ricoprono completamente il rettangolo MxN (ma non sempre è .

Teorema di de Bruijn e Klarner
-------------------------------
Un rettangolo MxN può essere coperta (tiled) con rettangoli AxB se e solo se:
1) MN è divisibile per AB
2) Sia M che N possono essere scritti come Ax + By dove x e y sono numeri interi non negativi
   (cioè M è divisibile per gcd(A,B) e N è divisibile per gcd(A,B))
3) M o N sono divisibili per A
4) M o N sono divisibili per B

Per il punto 2):
Se hai M, N, A e B e vuoi trovare x e y tali che M = Ax + By, ecco i passaggi:
a) Utilizzare l'algoritmo euclideo esteso per trovare gli interi x e y tali che Ax + By = gcd(A, B).
b) Se gcd(A, B) è un divisore di M, moltiplicare l'intera equazione per M/mcd(A, B) per ottenere i valori di x e y.

(define (tileable? m n a b)
  (if (and (zero? (% (* m n) (* a b)))
           (zero? (% m (gcd a b)))
           (zero? (% n (gcd a b)))
           (or (zero? (% m a)) (zero? (% m b)))
           (or (zero? (% n a)) (zero? (% n b))))
      (list (/ (* m n) (* a b)) (div (* m n) (* a b)))
      nil))

Proviamo:

(tileable? 4 5 1 1)
;-> (20 20)

(tileable? 10 20 1 2)
;-> (100 100)

(tileable? 11 21 1 2)
;-> nil


-----------------------------------
Numeri di rettangoli in una griglia
-----------------------------------

Data una griglia MxN, quanti rettangoli contiene?

Per esempio, M = 2 e N = 2:

  +---+---+
  |   |   |
  +---+---+
  |   |   |
  +---+---+

Output = 9
Ci sono 4 rettangoli di dimensione 1 x 1.
Ci sono 2 rettangoli di dimensione 1 x 2
Ci sono 2 rettangoli di dimensione 2 x 1
C'è un rettangolo di dimensioni 2 x 2.

Algoritmo Brute-Force:
Ciclo su tutte le possibili coppie di linee orizzontali.
Ciclo su tutte le possibili coppie di linee verticali.
Contare il numero di rettangoli che si formano utilizzando queste linee.

(define (conta-rettangoli m n)
  (let (conta 0)
    (for (i 1 m)
      (for (j 1 n)
        (setq conta (+ conta (* (+ m 1 (- i)) (+ n 1 (- j)))))
      )
    )
    conta))

Proviamo:

(conta-rettangoli 2 2)
;-> 9
(conta-rettangoli 4 5)
;-> 150
(conta-rettangoli 10 10)
;-> 3025

Algoritmo matematico:
La griglia M*N può essere rappresentata come (M+1) linee verticali e (N+1) linee orizzontali.
In un rettangolo, abbiamo bisogno di due distinte linee orizzontali e due distinte linee verticali.
Quindi, dal punto di vista della matematica combinatoria, possiamo scegliere 2 linee verticali e 2 linee orizzontali per formare un rettangolo.
E il numero totale di queste combinazioni è il numero di rettangoli possibili nella griglia.

Numero totale di rettangoli in una griglia M*N = Comb(M+1,2) * Comb(N+1,2) =
= (M*(M+1)/2!)*(N*(N+1)/2!) = M*(M+1)*N*(N+1)/4

(define (conta-rettangoli-mat m n) (/ (* m (+ m 1) n (+ n 1)) 4))

(conta-rettangoli-mat 2 2)
;-> 9

(conta-rettangoli-mat 4 5)
;-> 150

(conta-rettangoli-mat 10 10)
;-> 3025


---------------------------------
Numeri di quadrati in una griglia
---------------------------------

Data una griglia MxN, quanti rettangoli contiene?

Per esempio:, M = 2 e N = 2:

  +---+---+
  |   |   |
  +---+---+
  |   |   |
  +---+---+

Output = 5
Ci sono 4 quadrati di dimensione 1x1 +
        1 quadrato di dimensione 2x2.

M = 3 N = 4

  +---+---+---+---+
  |   |   |   |   |
  +---+---+---+---+
  |   |   |   |   |
  +---+---+---+---+
  |   |   |   |   |
  +---+---+---+---+

Output = 20
Ci sono 12 quadrati di dimensione 1x1 +
         6 quadrati di dimensione 2x2 +
         2 quadrati di dimensione 3x3.

Il numero di quadrati in una griglia MxN è dato dalla seguente formula:

  M(M+1)(2M+1)/6 + (N-M)*M(M+1)/2 con N >= M

Dimostrazione
Vediamo prima il caso M = N:
Per M = N = 1, output: 1
Per M = N = 2, output: 4 + 1 (4 di dimensione 1×1 + 1 di dimensione 2×2)
Per M = N = 3, output: 9 + 4 + 1 (9 di dimensione 1×1 + 4 di dimensione 2×2 + 1 di dimensione 3×3)
Per M = N = 4, output 16 + 9 + 4 + 1 (16 di dimensione 1×1 + 9 di dimensione 2×2 + 4 di dimensione 3×3 + 1 di dimensione 4×4)
In generale risulta che il numero totale di quadrati è la somma dei quadrati dei primi n numeri interi: n^2 + (n-1)^2 + ... 1 = n(n+1)(2n+1)/6

Vediamo il caso N >= M:
Sappiamo che il numero di quadrati in una matrice MxM è M(M+1)(2M+1)/6
Cosa succede quando aggiungiamo una colonna, ovvero qual è il numero di quadrati nella griglia Mx(M+1)?
Quando aggiungiamo una colonna, il numero di quadrati aumenta di M + (M-1) + ... + 3 + 2 + 1
(M quadrati di dimensione 1×1 + (M-1) quadrati di dimensione 2×2 + ... + 1 quadrato di dimensione MxM), che è uguale a M(M+1)/2.
Quindi, quando aggiungiamo (N-M) colonne, il numero totale di quadrati aumenta di (N-M)*M(M+1)/2.
Numero totale di quadrati = M(M+1)(2M+1)/6 + (N-M)*M(M+1)/2 (se N >= M)

Per ultimo vediamo il caso N <= M:
Usando la stessa logica troviamo una formula analoga scambiando N con M:
Numero totale di quadrati = N(N+1)(2N+1)/6 + (M-N)*N(N+1)/2

(define (conta-quadrati m n)
  (if (>= m n) (swap m n))
  (+ (/ (* m (+ m 1) (+ (* 2 m) 1)) 6)
     (/ (* (- n m) n (- n 1)) 2)))

Proviamo:

(conta-quadrati 2 2)
;-> 5

(conta-quadrati 3 4)
;-> 20

(conta-quadrati 10 10)
;-> 385


-------------
Anni speciali
-------------

Un anno "speciale" è un anno che inizia di lunedì e termina di lunedì.

Calcoliamo il giorno della settimana di una data gregoriana con l'algoritmo di Zeller: (0 = domenica ... 6 = sabato):

(define (day-of-week year month day)
  (local (adjust mm yy d)
    (setq adjust (/ (- 14 month) 12))
    (setq mm (+ month (* 12 adjust) (- 2)))
    (setq yy (- year adjust))
    (setq d (% (+ day (/ (- (* 13 mm) 1) 5) yy (/ yy 4) (- (/ yy 100)) (/ yy 400)) 7))))

Da notare che tutti gli anni bisestili cominciano e finiscono in due giorni diversi.
Infatti un anno bisestile è formato da 366 giorni:

  366 giorni = = 52 settimane (52*7 = 364) + 2 giorni

Invece gli anni comuni (non bisestili) cominciano e finiscono sempre con lo stesso giorno.

  365 giorni = 52 settimane (52*7 = 364) + 1 giorno

Verifichiamo:

(day-of-week 2001 1 1)
;-> 1
(day-of-week 2001 12 31)
;-> 1

(day-of-week 2023 1 1)
;-> 0
(day-of-week 2023 12 31)
;-> 0

(day-of-week 2024 1 1)
;-> 1
(day-of-week 2024 12 31)
;-> 2

Adesso scriviamo la funzione che verifica se un anno è speciale:

(define (special? year)
  (and (= (day-of-week year 1 1) 1) (= (day-of-week year 12 31) 1)))

Calcoliamo gli anni speciali tra il 1900 e il 2100:

(filter special? (sequence 1900 2100))
;-> (1900 1906 1917 1923 1934 1945 1951 1962 1973 1979 1990
;->  2001 2007 2018 2029 2035 2046 2057 2063 2074 2085 2091)

Vedi anche "Giorno della settimana" su "Rosetta Code".


-------------------
Matrici di Toeplitz
-------------------

Una matrice è una matrice di Toeplitz se ogni diagonale discendente, da sinistra a destra, ha un solo elemento distinto. Cioè, dovrebbe essere nella forma:

      | a(0)   a(−1)  a(−2)  ...  a(1−n) |
      | a(1)   a(0)   a(−1)  ...  a(2−n) |
  A = | a(2)   a(1)   a(0)   ...  a(3−n) |
      | ...    ...    ...    ...   ...   |
      | ...    ...    ...    ...   ...   |
      | a(n−1) a(n−2) a(n−3) ...   a(0)  |

Per esempio:

      | 6 7 8 9 2 |
  M = | 4 6 7 8 9 |
      | 1 4 6 7 8 |
      | 2 1 4 6 7 |
Questa è una matrice di Toeplitz.

      | 1 1 1 1 1 |
  M = | 1 1 1 1 1 |
      | 1 1 1 1 1 |
      | 1 1 1 1 1 |
Questa è una matrice di Toeplitz.

      | 1 1 2 1 1 |
  M = | 2 1 1 3 1 |
      | 1 3 1 1 2 |
      | 1 1 2 1 1 |
Questa non è una matrice di Toeplitz.

(define (toeplitz? matrice)
  (local (out rows cols)
    (setq out nil)
    (setq rows (length matrice))
    (setq cols (length (matrice 0)))
    (for (i 1 (- rows 1) 1 out)
      (for (j 1 (- cols 1) 1 out)
        (if (!= (matrice i j) (matrice (- i 1) (- j 1)))
            (setq out true)
        )
      )
    )
    (not out)))

Proviamo:

(setq m '((6 7 8 9 2)
          (4 6 7 8 9)
          (1 4 6 7 8)
          (2 1 4 6 7)))
(toeplitz? m)
;-> true

(setq m '((1 1 1 1 1)
          (1 1 1 1 1)
          (1 1 1 1 1)
          (1 1 1 1 1)))
(toeplitz? m)
;-> true

(setq m '((1 1 2 1 1)
          (2 1 1 3 1)
          (1 3 1 1 2)
          (1 1 2 1 1)))
(toeplitz? m)
;-> nil


-----------------------------------
Numero di sequenze di 1 consecutivi
-----------------------------------

Calcolare la sequenza definita nel modo seguente:
 a(n) è il numero di sequenze di 1 consecutivi in tutte le sequenze binarie di lunghezza (n+1).

Sequenza OEIS A001792:
  1, 3, 8, 20, 48, 112, 256, 576, 1280, 2816, 6144, 13312, 28672, 61440,
  131072, 278528, 589824, 1245184, 2621440, 5505024, 11534336, 24117248,
  50331648, 104857600, 218103808, 452984832, 939524096, 1946157056,
  4026531840, 8321499136, 17179869184, 35433480192, ...

Per esempio con n = 3:
Sequenze di lunghezza 4     Numero di sequenze che hanno 1 consecutivi
  0000                        0
  0001                        0
  0010                        0
  0011                        1
  0100                        0
  0101                        0
  0110                        1
  0111                        1
  1000                        0
  1001                        0
  1010                        0
  1011                        1
  1100                        1
  1101                        1
  1110                        1
  1111                        1
                     Totale = 8 sequenze

Per esempio la sequenza binaria "10110011011101" ha 3 sequenze di 1 consecutivi: 11, 11 e 111.

Funzione che genera tutte le sequenze di lunghezza n:

(define (genera simboli num)
  (local (out len posizioni break numero pos)
    (setq out '())
    (setq len (length simboli))
    ; Creazione di un array con num zeri
    (setq posizioni (array num '(0)))
    (setq break nil)
    (until break
      ; Creazione del numero corrente
      (setq numero "")
      ; Con questo ciclo abbiamo a disposizione i simboli/caratteri
      ; per costruire il valore corrente
      (dolist (i posizioni) (extend numero (simboli i)))
      ;(println numero)
      (push numero out -1)
      ; Incrementa le posizioni dall'ultima
      (setq pos (- num 1))
      (while (and (>= pos 0) (= (posizioni pos) (- len 1)))
        (setf (posizioni pos) 0)
        (-- pos)
      )
      ; Se tutte le posizioni sono arrivate alla fine, esce
      (if (< pos 0)
          (setq break true)
          ;else
          ; Altrimenti, incrementa la posizione corrente
          (++ (posizioni pos))
      )
    )
    out))

Funzione che applica ripetutamente una regex ad una stringa:

(define (regex-all regexp str all)
  (local (out idx res)
    (setq out '())
    (setq idx 0)
    (setq res (regex regexp str 64 idx))
    (while res
      (push res out -1)
      (if all
          (setq idx (+ (res 1) 1)) ; contiguos pattern
          ;else
          (setq idx (+ (res 1) (res 2))) ; no contiguos pattern
      )
      (setq res (regex regexp str 64 idx))
    )
    out))

(regex-all "1+" "1011011111")
;-> (("1" 0 1) ("11" 2 2) ("11111" 5 5))

(regex-all "11+" "1011011111")
;-> (("11" 2 2) ("11111" 5 5))

Funzione che genera la sequenza:

(define (seq num)
  (local (values conta)
    (setq values (genera "01" (+ num 1)))
    (setq conta 0)
    (dolist (v values)
      ;(println v { } (length (regex-all "11+" v)))
      (++ conta (length (regex-all "11+" v)))
    )
    conta))

Proviamo:

(map seq (sequence 1 10))
;-> (1 3 8 20 48 112 256 576 1280 2816)

(time (map seq (sequence 1 15)))
;-> 705.14

(time (map seq (sequence 1 20)))
;-> 27594.19

Per rendere più veloce la funzione generiamo le sequenze binarie dai numeri interi:

(define (genera1 num) (map bits (sequence 1 (int (dup "1" num) 0 2))))

;-> (genera1 3)
;-> ("1" "10" "11" "100" "101" "110" "111")

Nuova funzione che genera la sequenza:

(define (seq1 num)
  (local (values conta)
    (setq values (genera1 (+ num 1)))
    (setq conta 0)
    (dolist (v values)
      ;(println v { } (length (regex-all "11+" v)))
      (++ conta (length (regex-all "11+" v)))
    )
    conta))

Proviamo:

(map seq1 (sequence 1 10))
;-> (1 3 8 20 48 112 256 576 1280 2816)

(= (map seq (sequence 1 15)) (map seq1 (sequence 1 15)))
;-> true

(time (map seq1 (sequence 1 15)))
;-> 245.348

(time (map seq1 (sequence 1 20)))
;-> 9287.176

Matematicamente la sequenza viene generata dalla seguente formula:

  a(n) = (n+2)*2^(n-1)

(define (seq-mat num)
  (-- num)
  (if (zero? num) 1
      (* (+ num 2) (pow 2 (- num 1)))))

Proviamo:

(map seq-mat (sequence 1 10))
;-> (1 3 8 20 48 112 256 576 1280 2816)

(= (map seq (sequence 1 15))
   (map seq1 (sequence 1 15))
   (map seq-mat (sequence 1 15)))
;-> true

(time (map seq-mat (sequence 1 15)))
;-> 0

(time (map seq-mat (sequence 1 20)))
;-> 0

(time (map seq-mat (sequence 1 1000)))
;-> 0.964


----------------------------------
Un altro bug della versione 10.7.6
----------------------------------

Un bug di "rotate" quando le rotazioni sono negative e il numero di rotazioni assolute sono multiple della lunghezza della lista.
Per esempio:

(rotate '("1" "A" "B" "2") 8)
;-> ("1" "A" "B" "2")
(rotate '("1" "A" "B" "2") -8)
;-> ("1") ;ERROR
(rotate '("1" "A" "B" "2") 12)
;-> ("1" "A" "B" "2")
(rotate '("1" "A" "B" "2") -12)
;-> ("1") ;ERROR

Workaround:

(rotate lst (- (% r (length lst))))
(rotate '("1" "A" "B" "2") (- (% 12 4)))
;-> ("1" "A" "B" "2")
(rotate '("1" "A" "B" "2") (- (% 8 4)))
;-> ("1" "A" "B" "2")

Workaround (by vashushpanov):

In file nl-liststr.c replace string:
  if (length <= 1 || count == 0 || length == labs(count))
to
  if (length <= 1 || count == 0 || length == labs(count) || count % length == 0)

and recompile NewLisp.


-----------------------------
Numero di settimana dell'anno
-----------------------------

Dati anno, mese e giorno (data), determinare in quale settimana dell'anno ricade.

Numero semplice della settimana:
Il numero semplice della settimana è definito nel modo seguente:
1) la settimana 1 inizia il 1 gennaio dell'anno,
2) la settimana n+1 inizia 7 giorni dopo la settimana n

Quindi per una data (year month day) il numero della settimana vale:

  Week-Number = 1 + (Day-Passed(year, month) + day - 1 )/7

La funzione Day-Passed conta i giorni dei mesi precedenti al parametro 'month'.

(setq days-month '(0 31 28 31 30 31 30 31 31 30 31 30 31))

Funzione che verifica se un anno è bisestile:

(define (isleap? year)
  (or (zero? (% year 400))
      (and (zero? (% year 4)) (not (zero? (% year 100))))))

Funzione che conta i Day-Passed:

(define (day-passed year month)
  (if (isleap? year)
    (apply + (slice '(0 31 29 31 30 31 30 31 31 30 31 30 31) 0 month))
    (apply + (slice '(0 31 28 31 30 31 30 31 31 30 31 30 31) 0 month))))

Per un anno comune:

(map (curry day-passed 2001) (sequence 1 13))
;-> (0 31 59 90 120 151 181 212 243 273 304 334 365)

Mese       Day-Passed
Gennaio      0
Febbraio    31
Marzo       59
Aprile      90
Maggio     120
Giugno     151
Luglio     181
Agosto     212
Settembre  243
Ottobre    273
Novembre   304
Dicembre   334

Per un anno bisestile:

(map (curry day-passed 2000) (sequence 1 13))
;-> (0 31 60 91 121 152 182 213 244 274 305 335 366)

Mese       Day-Passed
Gennaio      0
Febbraio    31
Marzo       60
Aprile      91
Maggio     121
Giugno     152
Luglio     182
Agosto     213
Settembre  244
Ottobre    274
Novembre   305
Dicembre   335

Adesso scriviamo la funzione Week-Number che, dati anno, mese e giorno, determina il relativo numero della settimana:

(define (week-number year month day)
  (+ 1 (/ (+ (days-passed year month) day (- 1)) 7)))

Proviamo:

(week-number 2024 2 6)
;-> 6
(week-number 2024 3 15)
;-> 11
(week-number 2024 1 1)
;-> 1
(week-number 2024 12 31)
;-> 53
(week-number 2023 1 1)
;-> 1
(week-number 2023 12 31)
;-> 53

Nota: esistono altre definizioni del "Numero della settimana", la più importante è qualla contenuta nello standard ISO-8601 dove le settimane cominciano di Lunedì.
La prima settimana dell'anno è la settimana che contiene il primo giovedì dell'anno (o contiene il 4 gennaio) (= 'Prima settimana di 4 giorni').


---------------------
ProgressBar dell'anno
---------------------

Dati anno, mese e giorno, scrivere una funzione che produce una ProgrssBar dei giorni trascorsi.

(define (isleap? year)
  (or (zero? (% year 400))
      (and (zero? (% year 4)) (not (zero? (% year 100))))))

Funzione che conta i giorni trascorsi:

(define (day-passed year month)
  (if (isleap? year)
    (apply + (slice '(0 31 29 31 30 31 30 31 31 30 31 30 31) 0 month))
    (apply + (slice '(0 31 28 31 30 31 30 31 31 30 31 30 31) 0 month))))

(define (bar year month day)
  (local (bar-length all passed perc filled empty)
    (setq bar-length 50)
    (setq all 365)
    (if (isleap? year) (++ all))
    (setq passed (+ (day-passed year month) day -1))
    (setq perc (div passed all))
    (setq filled (round (mul bar-length perc) 0))
    (setq empty (sub bar-length filled))
    (if (!= filled 0) (for (i 1 filled) (print "*")))
    (if (!= empty 0) (for (i 1 empty) (print "-")))
    (println " " (round (mul 100 perc) 0) "%")
    '>))

Proviamo:

(bar 2024 1 1)
;-> -------------------------------------------------- 0%

(bar 2024 10 15)
;-> ***************************************----------- 79%

(bar 2024 3 15)
;-> **********---------------------------------------- 20%

(bar 2024 2 2)
;-> ****---------------------------------------------- 9%


--------------
Comic Sequence
--------------

Original: https://www.smbc-comics.com/comic/puzzle-time
--------------------------------------------
   What is the pattern of this sequence:

     0 1 4 -13 -133 52 53 -155

   Answer:
   Every number was read by a dickhead
--------------------------------------------

Scrivere la funzione più corta per generare la seguente sequenza:

Prima funzione (lunghezza 49):

(define (f1) (println "110 101 119 108 105 115 112"))

(f1)
;-> 110 101 119 108 105 115 112

(length (string f1))
;-> 51

Seconda funzione (lunghezza 42):
(define (f2) '(110 101 119 108 105 115 112))

(f2)
;-> (0 1 4 -13 -133 52 53 -155)

(length (string f2))
;-> 42

Terza funzione (42):
(define (f3) (map char (explode "newlisp")))

(f3)
;-> (110 101 119 108 105 115 112)

(length (string f3))
;-> 43


-----------------------
Congettura di Gilbreath
-----------------------

Supponiamo di avere la lista infinita dei numeri primi:

(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 ...

Quindi prendiamo ripetutamente le differenze assolute tra ciascuna coppia di numeri consecutivi:

(1 2 2 4 2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 ...
(1 0 2 2 2 2 2 2 4 4 2 2 2 2 0 4 4 2 ...
(1 2 0 0 0 0 0 2 0 2 0 0 0 2 4 0 2 ...
(1 2 0 0 0 0 2 2 2 2 0 0 2 2 4 2 ...

Si noti che il numero iniziale vale sempre 1.
La Congettura di Gilbreath prevede che sarà così per sempre.

L'unico modo in cui il numero iniziale non sarebbe un 1 è se il numero successivo non fosse né uno 0 né un 2. L'unico modo in cui il secondo numero non sarebbe uno 0 o un 2 è se il numero successivo non fosse né un 0 né 2. E così via.

Vediamo un esempio:

(define (primes-to num)
"Generates all prime numbers less than or equal to a given number"
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let ((lst '(2)) (arr (array (+ num 1))))
          (for (x 3 num 2)
            (when (not (arr x))
              (push x lst -1)
              (for (y (* x x) num (* 2 x) (> y num))
                (setf (arr y) true)))) lst))))

Nei primi 100 numeri interi ci sono 25 primi:

(setq primi (primes-to 100))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)
(setq seq primi)
(setq len (length primi))
;-> 25
(for (i 1 (- len 1))
  (setq tmp (map (fn(x y) (abs (- x y))) (rest seq) (chop seq)))
  (setq seq tmp)
  (print i { } seq) (read-line)
  (if (!= (seq 0) 1) (println i { } tmp))
)
;-> 1 (1 2 2 4 2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4 6 8)
;-> 2 (1 0 2 2 2 2 2 2 4 4 2 2 2 2 0 4 4 2 2 4 2 2 2)
;-> 3 (1 2 0 0 0 0 0 2 0 2 0 0 0 2 4 0 2 0 2 2 0 0)
;-> 4 (1 2 0 0 0 0 2 2 2 2 0 0 2 2 4 2 2 2 0 2 0)
;-> 5 (1 2 0 0 0 2 0 0 0 2 0 2 0 2 2 0 0 2 2 2)
;-> 6 (1 2 0 0 2 2 0 0 2 2 2 2 2 0 2 0 2 0 0)
;-> 7 (1 2 0 2 0 2 0 2 0 0 0 0 2 2 2 2 2 0)
;-> 8 (1 2 2 2 2 2 2 2 0 0 0 2 0 0 0 0 2)
;-> 9 (1 0 0 0 0 0 0 2 0 0 2 2 0 0 0 2)
;-> 10 (1 0 0 0 0 0 2 2 0 2 0 2 0 0 2)
;-> 11 (1 0 0 0 0 2 0 2 2 2 2 2 0 2)
;-> 12 (1 0 0 0 2 2 2 0 0 0 0 2 2)
;-> 13 (1 0 0 2 0 0 2 0 0 0 2 0)
;-> 14 (1 0 2 2 0 2 2 0 0 2 2)
;-> 15 (1 2 0 2 2 0 2 0 2 0)
;-> 16 (1 2 2 0 2 2 2 2 2)
;-> 17 (1 0 2 2 0 0 0 0)
;-> 18 (1 2 0 2 0 0 0)
;-> 19 (1 2 2 2 0 0)
;-> 20 (1 0 0 2 0)
;-> 21 (1 0 2 2)
;-> 22 (1 2 0)
;-> 23 (1 2)
;-> 24 (1)

Per verificare la congettura in modo esaustivo occorre la lista infinita dei primi.
Comunque possiamo verificare la congettura fino ad un certo numero di primi.

(define (gilbreath num)
  (local (primi len seq tmp)
    (setq primi (primes-to num))
    (setq len (length primi))
    (println "Numero primi = " len)
    (setq seq primi)
    (for (i 1 (- len 1))
      (setq tmp (map (fn(x y) (abs (- x y))) (rest seq) (chop seq)))
      (setq seq tmp)
      (if (!= (seq 0) 1) (println i { } len))
    ))'>)

Proviamo:

(gilbreath 1e5)
;-> Numero primi = 9592

(gilbreath 1e6)
;-> Numero primi = 78498

(time (gilbreath 1e6))
;-> Numero primi = 78498
;-> 344277.337


--------------------------------
Funzioni che cancellano funzioni
--------------------------------

newLISP permette alle funzioni di eliminare altre funzioni:

(define (f1)
  (println "f1")
  (delete 'f2)
)

(define (f2)
  (println "f2")
  (delete 'f1)
)

Eseguiamo la funzione f1 che cancella f2:

(f1)
;-> f1
;-> true

Adesso la funzione f2 non esiste più:

(f2)
;-> ERR: invalid function : (f2)

Una funzione non può cancellare se stessa:

(define (test)
  (println "...")
  (delete 'test true)
)

(test)
;-> ...

La funzione non è stata cancellata (a causa del true di "delete"):

(find 'test (symbols))
;-> 361

Se togliamo il true dalla funzione "delete" otteniamo un crash e la chiusura della REPL:

(define (test)
  (println "...")
  (delete 'test true)
)

(test)
;-> ...
crash - REPL closed


--------------
Calcolo di 1/n
--------------

Dato un numero intero positivo n, calcolare k cifre decimali di 1/n.

Ovviamente non possiamo usare i numeri float perchè saremmo limitati calcolo delle cifre decimali.

Algoritmo (esempio)

  n = 13 k = 5
  resto = 1 (valore iniziale del resto)
  prima cifra = (10 * resto) / num = 10/13 = 0
  resto = 10%13 = 10
  seconda cifra = (10 * resto) / num = 100/13 = 7
  resto = 100%13 = 9
  terza cifra = (10 * resto) / num = 90/13 = 6
  resto = 90%13 = 12
  quarta cifra = (10 * resto) / num = 120/13 = 9
  resto = 120%13 = 3
  quinta cifra = (10 * resto) / num = 30/13 = 2
  resto = 30%13 = 4
  Risultato 0.07692

(div 1 13)
;-> 0.07692307692307693

Funzione che calcola l'inverso di un numero n con k cifre decimali (verbose):

(define (inverse-print num k)
  (let ( (out '("0.")) (resto 1) )
    (println "resto = " resto)
    (dotimes (x k)
      (println "cifra = (10 * resto) / num = "(* 10 resto) "/" num " = " (/ (* 10 resto) num))
      (push (string (/ (* 10 resto) num)) out -1)
      (println "resto = " (* 10 resto) "%" num " = " (% (* 10 resto) num))
      (setq resto (% (* 10 resto) num))
    )
    (join out)))

Proviamo:

(inverse-print 13 5)
;-> resto = 1
;-> cifra = (10 * resto) / num = 10/13 = 0
;-> resto = 10%13 = 10
;-> cifra = (10 * resto) / num = 100/13 = 7
;-> resto = 100%13 = 9
;-> cifra = (10 * resto) / num = 90/13 = 6
;-> resto = 90%13 = 12
;-> cifra = (10 * resto) / num = 120/13 = 9
;-> resto = 120%13 = 3
;-> cifra = (10 * resto) / num = 30/13 = 2
;-> resto = 30%13 = 4
;-> "0.07692"

(inverse-print 2 4)
;-> resto = 1
;-> cifra = (10 * resto) / num = 10/2 = 5
;-> resto = 10%2 = 0
;-> cifra = (10 * resto) / num = 0/2 = 0
;-> resto = 0%2 = 0
;-> cifra = (10 * resto) / num = 0/2 = 0
;-> resto = 0%2 = 0
;-> cifra = (10 * resto) / num = 0/2 = 0
;-> resto = 0%2 = 0
;-> "0.5000"

Funzione che calcola l'inverso di un numero n con k cifre decimali:

(define (inverse num k)
  (let ( (out '("0.")) (resto 1) )
    (dotimes (x k)
      (push (string (/ (* 10 resto) num)) out -1)
      (setq resto (% (* 10 resto) num))
    )
    (join out)))

Proviamo:

(inverse 13 10)
;-> "0.0769230769"

(inverse 13 50)
;-> "0.07692307692307692307692307692307692307692307692307"


-----------------
Vivere di rendita
-----------------

Supponiamo di avere un capitale iniziale da investire, un tasso di interesse annuale sul capitale investito e una spesa annuale per vivere.
Per esempio:
Capitale iniziale: 500.000 euro
Interesse annuale: 3%
Spesa annuale = 25.000 euro

Se l'interesse applicato al capitale è uguale o maggiore alla spesa annuale, allora il capitale non viene intaccato e possiamo vivere di rendita per sempre.
Nell'esempio, i soldi che derivano dall'interesse valgono:

  500000*0.3 = 15.000

Poichè spendiamo 25.000 euro all'anno (che è maggiore di 15.000 euro), allora ogni anno intacchiamo il capitale.

(define (survive capitale interesse spese-annuali)
  (let ( (anno 0) (limite (mul capitale interesse)) )
    (if (>= limite spese-annuali)
        (println "Rendita per sempre: " limite)
        ;else
        (while (> capitale 0)
          (++ anno)
          ; L'ordine delle seguenti due espressioni calcola l'interesse prima
          ; della spesa annuale (casa favorevole).
          ; Scambiando l'ordine delle seguenti due espressioni otteniamo
          ; la situazione in cui l'interesse viene calcolato dopo
          ; la spesa annuale (caso sfavorevole)
          (setq capitale (add capitale (mul capitale interesse)))
          (setq capitale (sub capitale spese-annuali))
          (println "Anno " anno ": capitale = " capitale)))))

Proviamo:

(survive 250000 0.05 20000)
;-> limite: 12500
;-> Anno 1: capitale = 242500
;-> Anno 2: capitale = 234625
;-> Anno 3: capitale = 226356.25
;-> Anno 4: capitale = 217674.0625
;-> Anno 5: capitale = 208557.765625
;-> Anno 6: capitale = 198985.65390625
;-> Anno 7: capitale = 188934.9366015625
;-> Anno 8: capitale = 178381.6834316406
;-> Anno 9: capitale = 167300.7676032227
;-> Anno 10: capitale = 155665.8059833838
;-> Anno 11: capitale = 143449.096282553
;-> Anno 12: capitale = 130621.5510966806
;-> Anno 13: capitale = 117152.6286515147
;-> Anno 14: capitale = 103010.2600840904
;-> Anno 15: capitale = 88160.7730882949
;-> Anno 16: capitale = 72568.81174270964
;-> Anno 17: capitale = 56197.25232984513
;-> Anno 18: capitale = 39007.11494633738
;-> Anno 19: capitale = 20957.47069365425
;-> Anno 20: capitale = 2005.344228336962
;-> Anno 21: capitale = -17894.38856024619

(survive 1e6 0.04 25000)
;-> Rendita per sempre: 40000

(survive 1e6 0.04 100000)
;-> limite: 40000
;-> Anno 1: capitale = 940000
;-> Anno 2: capitale = 877600
;-> Anno 3: capitale = 812704
;-> Anno 4: capitale = 745212.16
;-> Anno 5: capitale = 675020.6464000001
;-> Anno 6: capitale = 602021.472256
;-> Anno 7: capitale = 526102.33114624
;-> Anno 8: capitale = 447146.4243920896
;-> Anno 9: capitale = 365032.2813677732
;-> Anno 10: capitale = 279633.5726224841
;-> Anno 11: capitale = 190818.9155273835
;-> Anno 12: capitale = 98451.67214847886
;-> Anno 13: capitale = 2389.739034418017
;-> Anno 14: capitale = -97514.67140420526

(survive 2e6 0.04 100000)
;-> Anno 1: capitale = 1980000
;-> Anno 2: capitale = 1959200
;-> Anno 3: capitale = 1937568
;-> Anno 4: capitale = 1915070.72
;-> Anno 5: capitale = 1891673.5488
;-> Anno 6: capitale = 1867340.490752
;-> Anno 7: capitale = 1842034.11038208
;-> Anno 8: capitale = 1815715.474797363
;-> Anno 9: capitale = 1788344.093789257
;-> Anno 10: capitale = 1759877.857540828
;-> Anno 11: capitale = 1730272.971842461
;-> Anno 12: capitale = 1699483.890716159
;-> Anno 13: capitale = 1667463.246344806
;-> Anno 14: capitale = 1634161.776198598
;-> Anno 15: capitale = 1599528.247246542
;-> Anno 16: capitale = 1563509.377136404
;-> Anno 17: capitale = 1526049.75222186
;-> Anno 18: capitale = 1487091.742310734
;-> Anno 19: capitale = 1446575.412003163
;-> Anno 20: capitale = 1404438.42848329
;-> Anno 21: capitale = 1360615.965622621
;-> Anno 22: capitale = 1315040.604247526
;-> Anno 23: capitale = 1267642.228417427
;-> Anno 24: capitale = 1218347.917554124
;-> Anno 25: capitale = 1167081.834256289
;-> Anno 26: capitale = 1113765.107626541
;-> Anno 27: capitale = 1058315.711931603
;-> Anno 28: capitale = 1000648.340408867
;-> Anno 29: capitale = 940674.2740252215
;-> Anno 30: capitale = 878301.2449862303
;-> Anno 31: capitale = 813433.2947856794
;-> Anno 32: capitale = 745970.6265771067
;-> Anno 33: capitale = 675809.4516401909
;-> Anno 34: capitale = 602841.8297057985
;-> Anno 35: capitale = 526955.5028940304
;-> Anno 36: capitale = 448033.7230097917
;-> Anno 37: capitale = 365955.0719301833
;-> Anno 38: capitale = 280593.2748073906
;-> Anno 39: capitale = 191817.0057996863
;-> Anno 40: capitale = 99489.68603167369
;-> Anno 41: capitale = 3469.273472940637
;-> Anno 42: capitale = -96391.95558814173


----------------------------------
Numero casuale con N cifre diverse
----------------------------------

Dato un numero intero N tra 1 e 10 (inclusi), generare un numero casuale tra 0 e 1 con N cifre decimali diverse.

La soluzione è quella di utilizzare una lista con tutte le cifre diverse (0..9), poi mischiare casualmente le cifre e prendere le prime N.

(define (rand01 n)
  (setq digits (randomize (sequence 0 9)))
  (float (string "0." (slice (join (map string digits)) 0 n))))

Proviamo:

(rand01 4)
;-> 0.7865

(rand01 10)
;-> 0.1539082674

(rand01 10)
;-> 0.6415937028000001

(rand01 6)
;-> 0.019457

(rand01 1)
;-> 0.4

(rand01 1)
;-> 0.3


--------------------------
Numero casuale con N cifre
--------------------------

Dato un numero intero N tra 1 e 16 (inclusi), generare un numero casuale tra 0 e 1 con N cifre decimali.

La soluzione è quella di utilizzare la funzione "rand" N volte e concatenare i risultati.

(define (rand01 n)
  (setq digits (rand 10 n))
  (float (string "0." (slice (join (map string digits)) 0 n))))

Proviamo:

(rand01 4)
;-> 0.1194

(rand01 10)
;-> 0.1003556616

(rand01 50)
;-> 0.4306785387995143


-------------
Social puzzle
-------------

Alcuni anni fa sui social network circolava il seguente puzzle:

  8 op 2 = 16106
  5 op 4 = 2091
  4 op 5 = 2091
  9 op 6 = ?

Come funziona l'operatore 'op'?

Per avere un aiuto è possibile usare la seguente funzione che crea la funzione "op" che simula l'operatore 'op'.
In questo modo possiamo provare l'operatore con altri numeri in modo da facilitare la ricerca della soluzione.

(define (oops)
  (let (lst '(40 100 101 102 105 110 101 32 40 111 112 32 97 32 98 41 32 40
              112 114 105 110 116 108 110 32 40 42 32 97 32 98 41 32 40 43 32
              97 32 98 41 32 40 97 98 115 32 40 45 32 97 32 98 41 41 41 41))
  (eval-string (join (map char lst))))
  'fatto)

Eseguiamo la funzione "oops":

(oops)
;-> fatto

Proviamo:

(op 8 2)
;-> 16106

(op 1 1)
;-> 120

(op 2 2)
;-> 440

(op 3 3)
;-> 960

Se non trovate la soluzione potete sempre vedere cosa fa la funzione "op":

op
;-> (lambda (a b) (println (* a b) (+ a b) (abs (- a b))))


---------------------
Differenze periodiche
---------------------

Data una lista di numeri interi positivi applichiamo le seguenti operazioni.
1) aggiungiamo l'ultimo numero della lista all'inizio della lista
2) calcoliamo le differenze assolute tra le coppie di numeri adiacenti
3) se otteniamo una lista ottenuta in precedenza allora ci fermiano,
   altrimenti andare al passo 1)
Quando ci fermiamo raggiungiamo un punto fisso o l'inizio di una sequenza ciclica.

Vediamo un esempio:

lst = (2 3 6 1)
  aggiunge l'ultimo numero all'inizio: (1 2 3 6 1)
  calcolo delle differenze assolute: (1 1 3 5)

  aggiunge l'ultimo numero all'inizio: (5 1 1 3 5)
  calcolo delle differenze assolute: (4 0 2 2)

  aggiunge l'ultimo numero all'inizio: (2 4 0 2 2)
  calcolo delle differenze assolute: (2 4 2 0)

  aggiunge l'ultimo numero all'inizio: (0 2 4 2 0)
  calcolo delle differenze assolute: (2 2 2 2)

  aggiunge l'ultimo numero all'inizio: (2 2 2 2 2)
  calcolo delle differenze assolute: (0 0 0 0)

  aggiunge l'ultimo numero all'inizio: (0 0 0 0 0)
  calcolo delle differenze assolute: (0 0 0 0)
  Stop.

In questo caso abbiamo raggiunto un punto fisso: (0 0 0 0).

Vediamo un altro esempio :

lst = (0 1 0)
  aggiunge l'ultimo numero all'inizio: (0 0 1 0)
  liste precedenti: ((0 1 0))
  calcolo delle differenze assolute: (0 1 1)

  aggiunge l'ultimo numero all'inizio: (1 0 1 1)
  liste precedenti: ((0 1 1) (0 1 0))
  calcolo delle differenze assolute: (1 1 0)

  aggiunge l'ultimo numero all'inizio: (0 1 1 0)
  liste precedenti: ((1 1 0) (0 1 1) (0 1 0))
  calcolo delle differenze assolute: (1 0 1)

  aggiunge l'ultimo numero all'inizio: (1 1 0 1)
  liste precedenti: ((1 0 1) (1 1 0) (0 1 1) (0 1 0))
  calcolo delle differenze assolute: (0 1 1)
  Stop.

In questo caso abbiamo raggiunto una sequenza ciclica:

  ((0 1 0) (1 0 1) (1 1 0) (0 1 1) (0 1 0))

Scriviamo la funzione:

(define (diffy lst)
  (let (prev '())
    (until (find lst prev)
      (push lst prev)
      (push (lst -1) lst)
      ;(println lst)
      (setq lst (map (fn(x y) (abs (- y x))) (chop lst) (rest lst)))
      ;(println prev)
      ;(print lst) (read-line)
    )
    (push lst prev)
  (reverse prev)))

Proviamo:

(setq a '(2 3 6 1))
(setq b '(0 1 0))

(diffy a)
;-> ((2 3 6 1) (1 1 3 5) (4 0 2 2) (2 4 2 0) (2 2 2 2) (0 0 0 0) (0 0 0 0))

(diffy b)
;-> ((0 1 0) (0 1 1) (1 1 0) (1 0 1) (0 1 1))

(diffy '(1 2 3 3 2 1))
;-> ((1 2 3 3 2 1) (0 1 1 0 1 1) (1 1 0 1 1 0) (1 0 1 1 0 1) (0 1 1 0 1 1))

(diffy '(2 4 6 6 4 2))
;-> ((2 4 6 6 4 2) (0 2 2 0 2 2) (2 2 0 2 2 0) (2 0 2 2 0 2) (0 2 2 0 2 2))

(diffy '(2 4 1 1 4 2))
;-> ((2 4 1 1 4 2) (0 2 3 0 3 2) (2 2 1 3 3 1) (1 0 1 2 0 2) (1 1 1 1 2 2)
;->  (1 0 0 0 1 0) (1 1 0 0 1 1) (0 0 1 0 1 0) (0 0 1 1 1 1) (1 0 1 0 0 0)
;->  (1 1 1 1 0 0) (1 0 0 0 1 0))

(diffy '(2 4 1 7 4 5))
;-> ((2 4 1 7 4 5) (3 2 3 6 3 1) (2 1 1 3 3 2) (0 1 0 2 0 1) (1 1 1 2 2 1)
;->  (0 0 0 1 0 1) (1 0 0 1 1 1) (0 1 0 1 0 0) (0 1 1 1 1 0) (0 1 0 0 0 1)
;->  (1 1 1 0 0 1) (0 0 0 1 0 1))


--------------------
Alternare True e Nil
--------------------

Scrivere una funzione che restituisce alternativamente 'true' e 'nil' ogni volta che viene chiamata.
La funzione non ha parametri.

Soluzione che dipende da una variabile globale:

(define (go) (++ k) (odd? k))
(define(go)(++ k)(odd? k))

Proviamo:

(go)
;-> true
(go)
;-> nil
(go)
;-> true
(go)
;-> nil

(define (go1)
  (if (nil? (sym "go2" 'MAIN nil))
      (println "go2 non esiste")
      (println "go2 esiste")))

(go1)

Soluzione che utilizza un contesto:
Vedi "Funzioni con memoria" su "newLISP in generale".

(define (tn:tn) (odd? (inc tn:val)))

Proviamo:

(tn)
;-> true
(tn)
;-> nil
(tn)
;-> true
(tn)
;-> nil
(tn)
;-> true
(tn)
;-> nil
tn:val
;-> 6


-------------------------------------
Codifica e decodifica di una funzione
-------------------------------------

Scriviamo due funzioni che codificano una funzione come lista di codici di caratteri ASCII e decodificano la lista creando una nuova funzione.

Funzione da codificare:

(define (test a b) (+ a b))

Funzione di codifica:

(define (encode func f-name)
  (local (body f)
    ; get the function as string (newLISP internal representation)
    (setq body (string func))
    ; change head from "lambda" to "define"
    (setq f (replace "lambda (" body (string "define (" f-name " ")))
    ; encode function as list of ASCII char code
    (map char (explode (string f)))))

Funzione di decodifica:

(define (decode lst)
  ; convert the list of ASCII char code in to a string
  ; and evaluate it (creating the function f-name)
  (eval-string (join (map char lst))))

Convertiamo una funzione in una lista di codici ASCII:

(setq a (encode test "tt"))
;-> (40 100 101 102 105 110 101 32 40 116 116 32 97 32 98
;->  41 32 40 43 32 97 32 98 41 41)

La funzione "tt" non esiste:

tt
;-> nil

Decodifichiamo la lista:

(decode a)
;-> (lambda (a b) (+ a b))

Adesso la funzione "tt" esiste:

tt
;-> (lambda (a b) (+ a b))

E "tt" funziona come la funzione originale "test":

(tt 2 3)
;-> 5


-----------------
Maxima e wxMaxima
-----------------

Maxima (Computer Algebra System)
--------------------------------
https://maxima.sourceforge.io/

Maxima è un sistema per l'elaborazione di espressioni simboliche e numeriche, come derivate, integrali, serie di Taylor, trasformazioni di Laplace, equazioni differenziali ordinarie, sistemi di equazioni lineari, polinomiali, insiemi, listi, vettori, matrici e tensori.
Maxima produce risultati numerici di alta precisione grazie all'utilizzo di frazioni esatte, interi di precisione arbitraria e numeri in virgola mobile a precisione variabile.
Maxima può disegnare funzioni e dati in due e tre dimensioni.

Il codice sorgente di Maxima è compilabile su molti sistemi diversi, inclusi Windows, GNU/Linux, e MacOS X.
Il codice sorgente per tutti i sistemi e i binari precompilati per Windows e Linux sono disponibili su SourceForge.

Storia
Maxima deriva da Macsyma, il leggendario sistema algebrico computazionale sviluppato alla fine degli anni '60 al MIT.
È l'unico sistema basato su quello sforzo ancora pubblicamente disponibile e con una comunità di utenti attiva, grazie alla sua natura open source.
Macsyma era rivoluzionario ai suoi tempi, e molti sistemi successivi, come Maple e Mathematica, si sono ispirati ad esso.

Maxima come diramazione di Macsyma è stato mantenuto da William Schelter dal 1982 fino alla sua morte avvenuta nel 2001.
Nel 1998 egli ottenne il permesso di rilasciare il codice sorgente sotto i termini della licenza GNU General Public License (GPL).
Sono stati i suoi sforzi e la sua competenza che hanno reso possibile la sopravvivenza di Maxima, e tutti noi siamo debitori per il suo impegno volontario dedicato di tempo e di conoscenza grazie al quale è stato conservato e mantenuto vivo il codice originale di DOE Macsyma sino ad oggi.
Dalla sua morte, si è creato un gruppo di utenti e sviluppatori formatosi con lo scopo di portare Maxima ad un'utenza più vasta.

Maxima viene aggiornato molto frequentemente, per correggere errori e per migliorarne il codice e la documentazione.
A tale scopo sono benvenuti i suggerimenti e i contributi che provengono dalla comunità degli utenti di Maxima.
Molte discussioni a riguardo hanno luogo sulla mailing list di Maxima.

wxMaxima
--------
https://wxmaxima-developers.github.io/wxmaxima/

wxMaxima è un'interfaccia basata su documenti per il CAS Maxima.
wxMaxima fornisce menu e finestre di dialogo per molti comandi comuni di Maxima, completamento automatico, grafici inline e semplici animazioni.
wxMaxima è distribuito sotto licenza GPL.

Maxima e LISP
-------------
Oltre a descrivere problemi matematici, Maxima fornisce il proprio linguaggio di programmazione per scrivere programmi.
Inoltre, poiché è scritto in Lisp, fornisce anche un facile accesso a quel linguaggio di programmazione.
In una sessione Maxima l'utente può inserire singoli comandi Lisp utilizzando il prefisso ":lisp", come nel seguente esempio:

(%i1) :lisp (+ 2/7 (* 3 4 1/5))
94/35

L'utente può anche avviare una sessione Lisp da Maxima con il comando to_lisp().
E quella sessione Lisp può essere terminata, tornando a Maxima, con il comando Lisp (to-maxima).

Breve introduzione a Maxima
---------------------------
Vedi i file "maxima-test.html" e "maxima-test.wxmx" nella cartella "data".

Elenco di altri CAS
-------------------
Commerciali:
Mathematica, Magma, Maple, MatLab

OpenSource/Freeware:
Maxima, Octave, SymPy, SageMath, PARI/GP, GeoGebra, Axiom(friCAS), Reduce


------------------------
Alfabetico fonetico NATO
------------------------

L'alfabeto ortografico (internazionale) per la radiotelefonia, comunemente noto come alfabeto fonetico NATO (NATO phonetic alphabet), è l'insieme di parole più utilizzato per comunicare le lettere dell'alfabeto romano.
Altri nomi sono "alfabeto ortografico NATO", "alfabeto fonetico ICAO" e "alfabeto ortografico ICAO".

L'insieme di parole è il seguente:

  Lettera     Parola
     A        Alfa
     B        Bravo
     C        Charlie
     D        Delta
     E        Echo
     F        Foxtrot
     G        Golf
     H        Hotel
     I        India
     J        Juliett
     K        Kilo
     L        Lima
     M        Mike
     N        November
     O        Oscar
     P        Papa
     Q        Quebec
     R        Romeo
     S        Sierra
     T        Tango
     U        Uniform
     V        Victor
     W        Whiskey
     X        X-ray
     Y        Yankee
     Z        Zulu

I numeri si pronunciano normalmente, tranne che spesso il 9 viene pronunciato "Niner" quindi non viene confuso con 5:

  Numero   Parola
    0      zero
    1      one
    2      two
    3      three
    4      four
    5      five
    6      six
    7      seven
    8      eight
    9      niner

(setq nato '(("A" "Alfa") ("B" "Bravo") ("C" "Charlie") ("D" "Delta")
             ("E" "Echo") ("F" "Foxtrot") ("G" "Golf") ("H" "Hotel")
             ("I" "India") ("J" "Juliett") ("K" "Kilo") ("L" "Lima")
             ("M" "Mike") ("N" "November") ("O" "Oscar") ("P" "Papa")
             ("Q" "Quebec") ("R" "Romeo") ("S" "Sierra") ("T" "Tango")
             ("U" "Uniform") ("V" "Victor") ("W" "Whiskey") ("X" "X-ray")
             ("Y" "Yankee") ("Z" "Zulu")
             ("0" "zero") ("1" "one") ("2" "two") ("3" "three")
             ("4" "four") ("5" "five") ("6" "six")("7" "seven")
             ("8" "eight") ("9" "niner")))

(define (spelling str)
  (setq lst (explode (upper-case str)))
  (setq out "")
  (dolist (ch lst)
    (extend out (string (lookup ch nato) ", "))
  )
  (slice out 0 -2))

(spelling "newLISP")
;-> "November, Echo, Whiskey, Lima, India, Sierra, Papa"

Per far 'parlare' la stringa usiamo il programma Balabolka (Text2Speech).
https://www.cross-plus-a.com/balabolka.htm

Vedi "Da testo a parlato (Text to speech)" su "Note libere 18".

Poichè il testo da leggere deve essere racchiuso da doppi apici "", possiamo scrivere:

(println (string "c:\\util\\balcon -t " "\"" (spelling "newLISP") "\""))
;-> "c:\\util\\balcon -t \"November, Echo, Whiskey, Lima, India, Sierra, Papa\""

Sostituiamo "exec" a "println" ed ascoltiamo i i caratteri fonetici:

(exec (string "c:\\util\\balcon -t " "\"" (spelling "newLISP") "\""))
;-> ()

(exec (string "c:\\util\\balcon -t " "\"" (spelling "0123456789") "\""))


--------------------------------------------
Suddividere una lista in blocchi sequenziali
--------------------------------------------

Data una lista suddividerla in blocchi di lunghezza predefinita.
Per esempio:

lista = (1 3 5 8 2)
Lunghezza blocchi = 3
Output = (1 3 5) (3 5 8) (5 8 2)

lista = (1 3 5 8 2)
Lunghezza blocchi = 2
Output = (1 3) (3 5) (5 8) (8 2)

(define (group-block lst num)
"Creates a list with blocks of elements: (0..num) (1..num+1) (n..num+n)"
  (local (out items len)
    (setq out '())
    (setq len (length lst))
    (if (>= len num) (begin
        ; numero di elementi nella lista di output (numero blocchi)
        (setq items (- len num (- 1)))
        (for (k 0 (- items 1))
          (push (slice lst k num) out -1)
        )
    ))
  out))

Proviamo:

(group-block '(1 3 5 8 2) 3)
;-> ((1 3 5) (3 5 8) (5 8 2))

(group-block '(1 3 5 8 2) 2)
;-> ((1 3) (3 5) (5 8) (8 2))

(group-block '(1 3 5 8 2) 5)
;-> ((1 3 5 8 2))

(group-block '(1 3 5 8 2) 6)
;-> ()


------------------------------------
Filtraggio di caratteri alfanumerici
------------------------------------

Data una stringa che contiene caratteri ASCII, scrivere tre funzioni che filtrano i caratteri minuscoli (a..z), i caratteri maiuscoli (A..Z) e le cifre (0..9).

Funzione che filtra i caratteri minuscoli (a..z):

(define (filter-lower str space)
  (let (out "")
    (if space
        (dostring (ch str)
          ;             " "             "a"        "z"
          (if (or (= ch 32) (and (>= ch 97) (<= ch 122)))
              (extend out (char ch))))
    ;else
        (dostring (ch str)
          (if (and (>= ch 97) (<= ch 122))
              (extend out (char ch))))
    )
  out))

Funzione che filtra i caratteri maiuscoli (A..Z):

(define (filter-upper str space)
  (let (out "")
    (if space
        (dostring (ch str)
          ;             " "             "A"        "Z"
          (if (or (= ch 32) (and (>= ch 65) (<= ch 90)))
              (extend out (char ch))))
    ;else
        (dostring (ch str)
          (if (and (>= ch 65) (<= ch 90))
              (extend out (char ch))))
    )
  out))

Funzione che filtra le cifre (0..9):

(define (filter-digit str space)
  (let (out "")
    (if space
        (dostring (ch str)
          ;             " "             "0"        "9"
          (if (or (= ch 32) (and (>= ch 48) (<= ch 57)))
              (extend out (char ch))))
    ;else
        (dostring (ch str)
          (if (and (>= ch 48) (<= ch 57))
              (extend out (char ch))))
    )
  out))

Proviamo:

(setq a "Oh! hi there guy. What's up? 1 2 3.")
(setq b (lower-case "Oh! hi there guy. What's up? 1 2 3."))
(setq c (upper-case "Oh! hi there guy. What's up? 1 2 3."))

;-> "hhithereguyhatsup"
(filter-lower a true)
;-> "h hi there guy hats up   "
(filter-lower b)
;-> "ohhithereguywhatsup"
(filter-lower b true)
;-> "oh hi there guy whats up   "
(filter-lower c)
;-> ""
(filter-lower c true)
;-> "        "

(filter-upper a true)
;-> "O    W    "
(filter-upper b)
;-> ""
(filter-upper b true)
;-> "        "
(filter-upper c)
;-> "OHHITHEREGUYWHATSUP"
(filter-upper c true)
;-> "OH HI THERE GUY WHATS UP   "

(filter-digit a)
;-> "123"
(filter-digit a true)
;-> "      1 2 3"


------------
Golomb ruler
------------

Un insieme di interi A = (a(1),a(2),...,a(m)) con a(1)<a(2)<...<a(m) è un "Golomb ruler" se e solo se:

  Per tutti i,j,k,l in (1..m) tale che (i != j) e (k != l),
  a(i)- a(j) = a(k) - a(l) se e solo se (i = k) e (j = l)

L'ordine di un tale "Golomb ruler" vale m e la sua lunghezza vale a(m) - a(1).

In altre parole, un "Golomb ruler" è un insieme di numeri interi non negativi tali che non esistono due coppie di numeri interi nell'insieme che abbiano la stessa distanza (differenza assoluta).

Vediamo un esempio:

  A = (0 1 4 6)
  0, 1 -> distanza 1
  0, 4 -> distanza 4
  0, 6 -> distanza 6
  1, 4 -> distanza 3
  1, 6 -> distanza 5
  4, 6 -> distanza 2

Quindi A è un "Golomb ruler" perché tutte le distanze tra due numeri dell'insieme sono uniche.

The order of such a Golomb ruler is m and its length is am - a1.

La seguente formula (Paul Erdos e Pal Turan), produce un "Golomb ruler" per ogni numero primo dispari p:

  2*p*k + (k^2 mod p),  per k = 0..p-1

(define (golomb p)
  (let (out '())
    (for (k 0 (- p 1)) (push (+ (* 2 p k) (% (* k k) p)) out -1))
  out))

Proviamo:

(golomb 5)
;-> (0 11 24 34 41)

(golomb 13)
;-> (0 27 56 87 107 142 166 192 220 237 269 290 313)

Scriviamo una funzione per verificare i risultati della funzione "golomb".

Funzione che restituisce una lista con le distanze tra tutte le possibili coppie degli elementi di una lista data:

(define (diff-list lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
          (push (abs (- (lst i) (lst j))) out -1)))))

Proviamo:

(setq test (diff-list (golomb 13)))
;-> (27 56 87 107 142 166 192 220 237 269 290 313 29 60 80 115 139 165
;->  193 210 242 263 286 31 51 86 110 136 164 181 213 234 257 20 55 79
;->  105 133 150 182 203 226 35 59 85 113 130 162 183 206 24 50 78 95
;->  127 148 171 26 54 71 103 124 147 28 45 77 98 121 17 49 70 93 32 53
;->  76 21 44 23)
(= test (unique test))
;-> true

(setq test (diff-list (golomb 23)))
;-> (47 96 147 200 232 289 325 386 426 468 512 558 606 656 708 739 795
;->  830 890 929 970 1013 49 100 153 185 242 278 339 379 421 465 511 559
;->  609 661 692 748 783 843 882 923 966 51 104 136 193 229 290 330 372
;->  416 462 510 560 612 643 699 734 794 833 874 917 53 85 142 178 239
;->  279 321 365 411 459 509 561 592 648 683 743 782 823 866 32 89 125
;->  186 226 268 312 358 406 456 508 539 595 630 690 729 770 813 57 93
;->  154 194 236 280 326 374 424 476 507 563 598 658 697 738 781 36 97
;->  137 179 223 269 317 367 419 450 506 541 601 640 681 724 61 101 143
;->  187 233 281 331 383 414 470 505 565 604 645 688 40 82 126 172 220
;->  270 322 353 409 444 504 543 584 627 42 86 132 180 230 282 313 369
;->  404 464 503 544 587 44 90 138 188 240 271 327 362 422 461 502 545
;->  46 94 144 196 227 283 318 378 417 458 501 48 98 150 181 237 272 332
;->  371 412 455 50 102 133 189 224 284 323 364 407 52 83 139 174 234
;->  273 314 357 31 87 122 182 221 262 305 56 91 151 190 231 274 35 95
;->  134 175 218 60 99 140 183 39 80 123 41 84 43)
(= test (unique test))
;-> true


----------------
Costante di Brun
----------------

La costante di Brun è il valore al quale converge la somma di tutti i reciproci delle coppie di primi gemelli (1/p e 1/(p+2) dove p e p+2 sono entrambi primi).
Il suo valore è 1.902160583104....
Il valore della costante cresce lentamente aumentando L.

Per esempio:
L = 10
coppie = (3 5) (5 7)
costante di brun = (1/3) + (1/5) + (1/5) + (1/7) = 0.8761904761904762

Scrivere una funzione che dato un valore limite L, calcola la costante di Brun sommando i reciproci delle coppie di primi gemelli dove entrambi i primi nella coppia sono minori di L.

Funzione che restituisce una lista con tutte le coppie di primi gemelli dal numero a al numero b:
(Vedi "Coppie di primi gemelli" su "Rosetta Code")

(define (prime-pairs a b)
  (let ((out (list)) (x nil) (FX (* 2 3 5 7 11 13)) (M 0))
    (for (y (if (odd? a) a (inc a)) b 2)
      (if (if (< y FX) (1 (factor y))
             (or (= (setf M (% y FX))) (if (factor M) (<= ($it 0) 13)) (1 (factor y))))
        (setf y nil)
        x (push (list x y) out -1))
      (setf x y))
    out))

(prime-pairs 3 100)
;-> ((3 5) (5 7) (11 13) (17 19) (29 31) (41 43) (59 61) (71 73))

Funzione che calcola la somma dei reciproci di una coppia di primi gemelli:

(define (calc-brun p) (add (div p) (div (+ p 2))))
;(define (calc-brun2 p) (div (* 2 (+ p 1)) (* p (+ p 2))))

(calc-brun 3)
;-> 0.5333333333333333

Funzione che calcola la costante di Brun fino ad un dato limite:

(define (brun limit)
  (apply add (map (fn(x) (calc-brun (x 0))) (prime-pairs 3 limit))))

Proviamo:

(brun 1e5)
;-> 1.67279958482774

(time (println (brun 1e7)))
;-> 1.738357043917252
;-> 7859.952

(time (println (brun 1e8)))
;-> 1.758815621067936
;-> 175268.9 ;(2m 55s 268ms)

Vediamo una versione ottimizzata:

(define (brun-fast a b)
  (let ((out (list)) (x nil) (FX (* 2 3 5 7 11 13)) (M 0))
    (for (y (if (odd? a) a (inc a)) b 2)
      (if (if (< y FX) (1 (factor y))
             (or (= (setf M (% y FX))) (if (factor M) (<= ($it 0) 13)) (1 (factor y))))
        (setf y nil)
        x (extend out (list (div x) (div y))))
      (setf x y))
    (apply add out)))

(time (println (brun-fast 3 1e9)))
;-> 1.774735957638545
;-> 4508014.919 ;(1h 15m 8s 14ms)


-----------------------------------------
Numeri primi con numero di 1 e di 0 primi
-----------------------------------------

Trovare tutti gli interi non negativi fino a un dato intero positivo n incluso, che sono primi e anche il conteggio di 1 e 0 nella loro rappresentazione binaria (senza zeri iniziali) è primo.

Sequenza OEIS A144214:
Primes with both a prime number of 0's and a prime number of 1's in binary.
  17, 19, 37, 41, 79, 103, 107, 109, 131, 137, 151, 157, 167, 173, 179, 181,
  193, 199, 211, 227, 229, 233, 241, 257, 367, 379, 431, 439, 443, 463, 487,
  491, 499, 521, 541, 557, 563, 569, 577, 587, 601, 607, 613, 617, 631, 641,
  647, 653, 659, 661, 677, 701, 709, ...
  
(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (pop-count num)
  (let (counter 0)
    (while (> num 0)
      ; In questo modo arriviamo al prossimo bit impostato (successivo '1')
      ; invece di eseguire il ciclo per ogni bit e controllare se vale '1'.
      ; Quindi il ciclo non verrà eseguito per tutti i bit,
      ; ma verrà eseguito solo tante volte quanti sono gli '1'.
      (setq num (& num (- num 1)))
      (++ counter)
    )
    counter))

(define (primes-to num)
"Generates all prime numbers less than or equal to a given number"
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let ((lst '(2)) (arr (array (+ num 1))))
          (for (x 3 num 2)
            (when (not (arr x))
              (push x lst -1)
              (for (y (* x x) num (* 2 x) (> y num))
                (setf (arr y) true)))) lst))))

(define (primi01 limit)
  (setq out '())
  (setq primi (primes-to limit))
  (dolist (p primi)
    ; numero di 1 in p
    (setq uno (pop-count p))
    ; numero di 0 in p
    (setq zero (- (length (bits p)) uno))
    (if (and (prime? uno) (prime? zero)) (push p out -1))
  )
  out)

Proviamo:

(primi01 1000)
;-> (17 19 37 41 79 103 107 109 131 137 151 157 167 173 179 181 193 199
;->  211 227 229 233 241 257 367 379 431 439 443 463 487 491 499 521 541
;->  557 563 569 577 587 601 607 613 617 631 641 647 653 659 661 677 701
;->  709 719 727 733 743 757 761 769 787 809 823 827 829 859 877 883 911
;->  919 929 941 947 953 967 971 997)


-------------------------------
Che ora è (in linguaggio umano)
-------------------------------

Quando si chiede l'ora ad un essere umano in genere la risposta viene arrotondata a 5 minuti.
Inoltre i casi sono i seguenti (x = ora):

  x
  x e 5 (minuti)
  x e 10
  x e un quarto (1/4)
  x e 20
  x e 25
  x e mezza (1/2)
  x e 35
  x e 40 oppure (x + 1) meno 20
  x e tre quarti (3/4) oppure (x + 1) meno un quarto
  x e 50 oppure (x + 1) meno 10
  x e 55 oppure (x + 1) meno 5

Scrivere una funzione che data un ora in ore (hh = 0..23) e minuti (mm = 0..59) restituisce la risposta umana:

(setq ore '((0 "Mezzanotte") (1 "L'una") (2 "Le due") (3 "Le tre")
            (4 "Le quattro") (5 "Le cinque") (6  "Le sei") (7 "Le sette")
            (8 "Le otto") (9 "Le nove") (10 "Le dieci")
            (11 "Le undici") (12 "Mezzogiorno") (13 "L'una")
            (14 "Le due") (15 "Le tre") (16 "Le quattro") (17 "Le cinque")
            (18 "Le sei") (19 "Le sette")
            (20 "Le otto") (21 "Le nove") (22 "Le dieci")
            (23 "Le undici") (24 "Mezzanotte")))
(setq min1 '((0 "") (5 " e cinque") (10 " e dieci") (20 " e venti")
             (25 " e venticinque") (30 " e mezza") (35 " e trentacinque")
             (40 " e quaranta") (45 " e tre quarti") (50 " e cinquanta")
             (55 " e cinquantacinque")))
(setq min2 '((40 " meno venti") (45 " meno un quarto")
             (50 " meno dieci") (55 " meno cinque")))

Funzione che arrotonda un intero al 5 più vicino:

(define (round5 num) (* (round (div num 5)) 5))

Funzione che esprime una data ora in termini umani:

(define (cheora hh mm)
  (setq mm (round5 mm))
  (if (and (find mm '(40 45 50 55)) (zero? (rand 2)))
      (println (lookup (+ hh 1) ore) (lookup mm min2))
      (println (lookup hh ore) (lookup mm min1))
  )
)

Proviamo:

(cheora 0 42)
;-> Mezzanotte e quaranta
(cheora 0 42)
;-> L'una meno venti

(cheora 11 42)
;-> Mezzogiorno meno venti
(cheora 11 42)
;-> Le undici e quaranta

(cheora 23 42)
;-> Le undici e quaranta
(cheora 23 42)
;-> Mezzanotte meno venti

(cheora 21 45)
;-> Le dieci meno un quarto
(cheora 21 45)
;-> Le nove e tre quarti

(cheora 11 0)
;-> Le undici

(cheora 0 22)
;-> Mezzanotte e venti

(cheora 0 0)
;-> Mezzanotte

(cheora 12 0)
;-> Mezzogiorno

(cheora 12 21)
;-> Mezzogiorno e venti

(cheora 12 42)
;-> L'una meno venti
(cheora 12 42)
;-> Mezzogiorno e quaranta

(cheora 13 42)
;-> Le due meno venti
(cheora 13 42)
;-> L'una e quaranta

============================================================================

