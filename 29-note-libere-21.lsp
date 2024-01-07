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

============================================================================

