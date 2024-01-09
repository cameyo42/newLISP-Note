================

 NOTE LIBERE 21

================

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

============================================================================

