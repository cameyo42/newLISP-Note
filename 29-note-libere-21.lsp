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

============================================================================
