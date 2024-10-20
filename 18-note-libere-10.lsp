================

 NOTE LIBERE 10

================

  "I love the impurity of the purity of newLISP"

---------
Turochamp
---------

Turochamp è un programma di scacchi sviluppato da Alan Turing e David Champernowne nel 1948. Si tratta del primo programma per computer per giocare a scacchi, ma non è mai stato completato da Turing e Champernowne, poiché il suo algoritmo era troppo complesso per essere eseguito dai computer del tempo.
Turing ha giocato una partita contro l'informatico Alick Glennie utilizzando il programma su carta nell'estate del 1952, eseguendolo manualmente passo dopo passo.
Questa è la partita:

 1. e2-e4     e7-e5
 2. Nb1-c3    Ng8-f6
 3. d2-d4     Bf8-b4
 4. Ng1-f3    d7-d6
 5. Bc1-d2    Nb8-c6
 6. d4-d5     Nc6-d4
 7. h2-h4     Bc8-g4
 8. a2-a4     Nd4xf3+
 9. g2xf3     Bg4-h5
10. Bf1-b5+   c7-c6
11. d5xc6     O-O
12. c6xb7     Ra8-b8
13. Bb5-a6    Qd8-a5
14. Qd1-e2    Nf6-d7
15. Rh1-g1    Nd7-c5
16. Rg1-g5    Bh5-g6
17. Ba6-b5    Nc5xb7
18. O-O-O     Nb7-c5
19. Bb5-c6    Rf8-c8
20. Bc6-d5    Bb4xc3
21. Bd2xc3    Qa5xa4
22. Kc1-d2    Nc5-e6
23. Rg5-g4    Ne6-d4
24. Qe2-d3    Nd4-b5
25. Bd5-b3    Qa4-a6
26. Bb3-c4    Bg6-h5
27. Rg4-g3    Qa6-a4
28. Bc4xb5    Qa4xb5
29. Qd3xd6??  Rc8-d8

17. Aa6-c4!          (+/-)
18. Aa6-c4!          (+/-)
21. ......  Da5-d8   (=)
22. h5!              (+/-)
23. Ad5xe6           (=)
23. ......  Tb8xb2!! (+/-)
29. Qd3xb5           (=)

Analisi con il programma di scacchi gratuito SlowChess 2.9:
https://www.3dkingdoms.com/chess/slow.htm


--------------------------
Riempimento di contenitori
--------------------------

Dato un numero N e un'unità di tempo X, trovare il numero di contenitori che vengono riempiti completamente nell'unità X se i contenitori sono disposti nel modo seguente (esempio con N=3):


                 ...+-----+...
                 :  |  1  |  :
                 :  +-----+  :
                 :           :
           ...+-----+.. ..+-----+...
           :  |  2  | : : |  3  |  :
           :  +-----+ : : +-----+  :
           :          : :          :
        +-----+     +-----+     +-----+
        |  4  |     |  5  |     |  6  |
        +-----+     +-----+     +-----+

Nella disposizione piramidale N indica il numero di livelli dei contenitori in modo tale che il livello 1 abbia 1 contenitore, il livello 2 abbia 2 contenitori e così via fino al livello N. Il liquido è sempre versato nel contenitore più in alto al primo livello. Quando il contenitore di un livello trabocca da entrambi i lati, i contenitori dei livelli inferiori vengono riempiti. La quantità di liquido versato in ogni secondo è uguale al volume del contenitore.

Per esempio:
N = 3, X = 5
Dopo 1 secondo, il contenitore al livello 1 si riempie completamente.
Dopo 2 secondi, i 2 contenitori al livello 2 sono pieni a metà.
Dopo 3 secondi, i 2 contenitori al livello 2 sono completamente pieni.
Dopo 4 secondi, dei 3 contenitori al livello 3, i 2 contenitori alle estremità sono riempiti per un quarto e il contenitore al centro è riempito a metà.
Dopo 5 secondi, dei 3 contenitori al livello 3, i 2 contenitori alle estremità sono riempiti a metà e il contenitore al centro è completamente riempito.
Quindi dopo 5 secondi abbiamo 4 contenitori completamente riempiti.

Dopo che un contenitore è stato riempito, il liquido trabocca in modo uguale da entrambi i lati del contenitore e riempie i contenitori sottostanti.
Consideriamo questa piramide di contenitori come una matrice: cont[i][j] è il liquido nel j-esimo contenitore della i-esima riga.
Quindi, quando si verifica un riempimento, il liquido scorre verso i contenitori cont[i+1][j] e cont[i+1][j+1].
Poiché il liquido verrà versato per X secondi, la quantità totale di liquido versato sarà X unità.
Quindi il valore massimo che può essere versato in un contenitore può essere X unità e il valore minimo che può essere versato per riempirlo completamente è 1 unità.

Iniziare il ciclo esterno da 1 a N per n contenitori a ogni livello. All'interno di questo ciclo, avviare un altro ciclo da 1 a i, per ogni contenitore di ogni riga. Dichiarare un contatore, conta = 0, per contare i contenitori che vengono riempiti.
Se il valore di cont[i][j] è maggiore o uguale a 1 (significa che è riempito), il conteggio viene incrementato di 1, quindi in cont[i+1][j] e cont[i+1][j+1] il liquido viene versato e il loro valore viene aumentato rispettivamente del valore di (cont[i][j]-1)/2, perché il liquido è diviso a metà in entrambi.
In questo modo continuare il ciclo, incrementando il conteggio per ogni contenitore riempito. Quando il ciclo finisce, il conteggio sarà la risposta richiesta.

(define (container n x)
  (setq secchio (array 1000 1000 '(0)))
  (setq conta 0)
  ; contenitore del primo livello
  (setf (secchio 1 1) x)
  (for (i 1 n)
    (for (j 1 (+ i 1))
      ; contenitore pieno?
      (if (>= (secchio i j) 1)
        (begin
          (++ conta)
          ; metà liquido nei due contenitori
          ; del livello successivo
          (setf (secchio (+ i 1) j) (add (secchio (+ i 1) j)
                                         (div (sub (secchio i j) 1) 2)))
          (setf (secchio (+ i 1) (+ j 1)) (add (secchio (+ i 1) (+ j 1))
                                              (div (sub (secchio i j) 1) 2)))
        )
      )
    )
  )
  conta)

Facciamo alcune prove:

(container 3 5)
;-> 4

(container 4 8)
;-> 6


--------------
Chess puzzle 1
--------------

Nel diagramma seguente ci sono due Cavalli Bianchi (CB) e due Cavalli Neri (CN).
Scambiare le posizioni dei Cavalli Bianchi con quelli Neri nel minor numero di mosse.
Il cavallo degli scacchi si muove a L.

           +--------+
           |        |
           |   CB   |
           |        |
           +--------+--------+
           |        |        |
           |        |        |
           |        |        |
           +--------+--------+--------+
           |        |        |        |
           |        |   CB   |        |
           |        |        |        |
  +--------+--------+--------+--------+
  |        |        |        |        |
  |   CN   |        |   CN   |        |
  |        |        |        |        |
  +--------+--------+--------+--------+

Suggerimento: la forma irregolare della scacchiera e i movimenti a forma di L dei cavalli sono irrilevanti. Ciò che conta sono le relazioni tra le caselle.

           +--------+
           |        |
           |   1    |
           |        |
           +--------+--------+
           |        |        |
           |   2        3    |
           |        |        |
           +--------+--------+--------+
           |        |        |        |
           |   4    |   5    |   6    |
           |        |        |        |
  +--------+--------+--------+--------+
  |        |        |        |        |
  |   7    |   8    |   9    |   10   |
  |        |        |        |        |
  +--------+--------+--------+--------+

Rappresentiamo la scacchiera come un grafo dove le caselle sono i nodi e il movimento del cavallo genera gli archi tra i nodi.

(setq grafo '((1  (5))     ; da 1 si va a 5
              (2  (6 7 9)) ; da 2 si va a 5 o 6 o 9
              (3  (8 10))  ; da 3 sia va a 8 o 10
              (4  (10))    ; ecc.
              (5  (1 7))
              (6  (2 8))
              (7  (2 5))
              (8  (3 6))
              (9  (2))
              (10 (4 3))))

Il disegno del grafo è il seguente:

   CB1      CB2      CN1
  +---+    +---+    +---+    +---+    +---+    +---+    +---+    +---+
  | 1 |----| 5 |----| 7 |----| 2 |----| 6 |----| 8 |----| 10|----| 4 |
  +---+    +---+    +---+    +---+    +---+    +---+    +---+    +---+
                               |
                             +---+
                             | 9 |
                             +---+
                              CN2

Dal disegno notiamo che per scambiare di posto i cavalli bianchi e neri occorre usare in qualche modo la casella 9 come "casella di scambio".

Invece di risolvere il problema con carta e penna (o a mente per i più bravi) scriviamo una funzione che ci permette di muovere i cavalli nel grafo.

Rappresentazione della posizione iniziale:

(setq cur-pos '((1 "(CB1)") (2 "") (3 "") (4 "") (5 "(CB2)") (6 "") (7 "(CN1)") (8 "") (9 "(CN2)") (10 "")))

Funzione che stampa la posizione corrente del grafo.
Esempio per lo stato iniziale:

  1(CB1)----5(CB2)----7(CN1)----2----6----8----3----10----4
                                |
                                9(CN2)

(define (print-position)
  (local (a-line b-line c-line)
    (setq a-line " 1----5----7----2----6----8----3----10----4 ")
    (setq b-line "|")
    (setq c-line "9")
    (dolist (cell cur-pos)
      (if (!= (cell 1) "")
          (cond ((= (cell 0) 9)
                  (replace "9" c-line (string "9" (cell 1))))
                (true
                  (replace (string (cell 0)) a-line
                          (string (cell 0) (cell 1)) 0x8000))
          )
      )
    )
    ; add space to b-line and c-line
    (setq b-line (append (dup " " (+ 1 (find "-2" a-line))) b-line))
    (setq c-line (append (dup " " (+ 1 (find "-2" a-line))) c-line))
    (println a-line) (println b-line) (println c-line)
  ))

(print-position)
;->  1(CB1)----5(CB2)----7(CN1)----2----6----8----3----10----4
;->                                |
;->                                9(CN2)

Funzione che muove un cavallo da una casella ad un altra:
Attenzione: nessun controllo di correttezza della mossa

(define (move from to)
  (local (piece-move1 piece-move2)
    (setq piece-move1 (lookup from cur-pos))
    (replace (list from piece-move1) cur-pos (list from ""))
    (setq piece-move2 (lookup to cur-pos))
    (replace (list to piece-move2) cur-pos (list to piece-move1))))

(move 7 6)
;-> ((1 "(CB1)") (2 "") (3 "") (4 "") (5 "(CB2)") (6 "(CN1)")
;->  (7 "") (8 "") (9 "(CN2)") (10 ""))
(print-position)
;->  1(CB1)----5(CB2)----7----2----6(CN1)----8----3----10----4
;->                           |
;->                           9(CN2)

Funzione che permette di simulare il problema:

(define (knights)
  (local (nmosse cur-pos end-pos1 end-pos2 end-pos3 end-pos4
          input from to)
    (setq cur-pos  '((1 "(CB1)") (2 "") (3 "") (4 "") (5 "(CB2)") (6 "") (7 "(CN1)") (8 "") (9 "(CN2)") (10 "")))
    ; 4 posizioni finali sono possibili
    (setq end-pos1 '((1 "(CN1)") (2 "") (3 "") (4 "") (5 "(CN2)") (6 "") (7 "(CB1)") (8 "") (9 "(CB2)") (10 "")))
    (setq end-pos2 '((1 "(CN1)") (2 "") (3 "") (4 "") (5 "(CN2)") (6 "") (7 "(CB2)") (8 "") (9 "(CB1)") (10 "")))
    (setq end-pos3 '((1 "(CN2)") (2 "") (3 "") (4 "") (5 "(CN1)") (6 "") (7 "(CB1)") (8 "") (9 "(CB2)") (10 "")))
    (setq end-pos4 '((1 "(CN2)") (2 "") (3 "") (4 "") (5 "(CN1)") (6 "") (7 "(CB2)") (8 "") (9 "(CB1)") (10 "")))
    (setq nmosse 0)
    (until (or (= cur-pos end-pos1) (= cur-pos end-pos2)
               (= cur-pos end-pos3) (= cur-pos end-pos4))
      (print-position)
      ; read two integer: "from" cell and "to" cell
      ; no error check!!
      (print "Move (from to): ")
      (setq input (parse (read-line) " "))
      (setq from (int (input 0)))
      (setq to (int (input 1)))
      (move from to)
      (++ nmosse)
    )
    (println "Puzzle solved with " nmosse " moves.")
    (print-position)
    '----))

Proviamo a risolvere il problema:

(knights)
;->  1(CB1)----5(CB2)----7(CN1)----2----6----8----3----10----4
;->                                |
;->                                9(CN2)
;-> Move (from to): 9 4
;->  1(CB1)----5(CB2)----7(CN1)----2----6----8----3----10----4(CN2)
;->                                |
;->                                9
;-> Move (from to): 7 10
;->  1(CB1)----5(CB2)----7----2----6----8----3----10(CN1)----4(CN2)
;->                           |
;->                           9
;-> Move (from to): 5 9
;->  1(CB1)----5----7----2----6----8----3----10(CN1)----4(CN2)
;->                      |
;->                      9(CB2)
;-> Move (from to): 10 5
;->  1(CB1)----5(CN1)----7----2----6----8----3----10----4(CN2)
;->                           |
;->                           9(CB2)
;-> Move (from to): 4 7
;->  1(CB1)----5(CN1)----7(CN2)----2----6----8----3----10----4
;->                                |
;->                                9(CB2)
;-> Move (from to): 9 4
;->  1(CB1)----5(CN1)----7(CN2)----2----6----8----3----10----4(CB2)
;->                                |
;->                                9
;-> Move (from to): 7 9
;->  1(CB1)----5(CN1)----7----2----6----8----3----10----4(CB2)
;->                           |
;->                           9(CN2)
;-> Move (from to): 5 10
;->  1(CB1)----5----7----2----6----8----3----10(CN1)----4(CB2)
;->                      |
;->                      9(CN2)
;-> Move (from to): 1 3
;->  1----5----7----2----6----8----3(CB1)----10(CN1)----4(CB2)
;->                 |
;->                 9(CN2)
;-> Move (from to): 9 1
;->  1(CN2)----5----7----2----6----8----3(CB1)----10(CN1)----4(CB2)
;->                      |
;->                      9
;-> Move (from to): 3 9
;->  1(CN2)----5----7----2----6----8----3----10(CN1)----4(CB2)
;->                      |
;->                      9(CB1)
;-> Move (from to): 10 5
;->  1(CN2)----5(CN1)----7----2----6----8----3----10----4(CB2)
;->                           |
;->                           9(CB1)
;-> Move (from to): 4 7
;->  1(CN2)----5(CN1)----7(CB2)----2----6----8----3----10----4
;->                                |
;->                                9(CB1)
;-> Puzzle solved with 13 moves.


--------------
Chess puzzle 2
--------------

Nel diagramma seguente ci sono due Cavalli Bianchi (CB) e due Cavalli Neri (CN).
Scambiare le posizioni dei Cavalli Bianchi con quelli Neri nel minor numero di mosse.
Il cavallo degli scacchi si muove a L.

  +--------+--------+--------+          +--------+--------+--------+
  |        |        |        |          |        |        |        |
  |   CN1  |        |   CN2  |          |   CB   |        |   CB   |
  |        |        |        |          |        |        |        |
  +--------+--------+--------+          +--------+--------+--------+
  |        |        |        |          |        |        |        |
  |        |        |        |    ==>   |        |        |        |
  |        |        |        |          |        |        |        |
  +--------+--------+--------+          +--------+--------+--------+
  |        |        |        |          |        |        |        |
  |   CB1  |        |   CB2  |          |   CN   |        |   CN   |
  |        |        |        |          |        |        |        |
  +--------+--------+--------+          +--------+--------+--------+

Etichettiamo la scacchiera:

  +---+---+---+
  | 1 | 2 | 3 |
  +---+---+---+
  | 4 | 5 | 6 |
  +---+---+---+
  | 7 | 8 | 9 |
  +---+---+---+

Rappresentiamo le mosse possibili da ogni casella con una lista i cui elementi sono del tipo:

  (casella (lista-caselle-raggiungibili))

(setq mosse '((1 (6 8))
              (2 (7 9))
              (3 (4 8))
              (4 (3 9))
              (5 ())
              (6 (1 7))
              (7 (2 6))
              (8 (1 3))
              (9 (2 4))))

Disegniamo il grafo dalle mosse possibili:

   CN1               CB1
  +---+    +---+    +---+
  | 1 |----| 6 |----| 7 |
  +---+    +---+    +---+
    |                 |
  +---+    +---+    +---+
  | 8 |    | 5 |    | 2 |
  +---+    +---+    +---+
    |                 |
  +---+    +---+    +---+
  | 3 |----| 4 |----| 9 |
  +---+    +---+    +---+
   CN2               CB2

Notiamo che la soluzione (16 mosse) consiste nel muovere 4 volte a turno i 4 cavalli in senso orario (o antiorario):

1)  (CN1: 1 -> 6) (CB1: 7 -> 2) (CB2: 9 -> 4) (CN2: 3 -> 8)
2)  (CN1: 6 -> 7) (CB1: 2 -> 9) (CB2: 4 -> 3) (CN2: 8 -> 1)
3)  (CN1: 7 -> 2) (CB1: 9 -> 4) (CB2: 3 -> 8) (CN2: 1 -> 6)
4)  (CN1: 2 -> 9) (CB1: 4 -> 3) (CB2: 8 -> 1) (CN2: 6 -> 7)

   CB2               CN2
  +---+    +---+    +---+
  | 1 |----| 6 |----| 7 |
  +---+    +---+    +---+
    |                 |
  +---+    +---+    +---+
  | 8 |    | 5 |    | 2 |
  +---+    +---+    +---+
    |                 |
  +---+    +---+    +---+
  | 3 |----| 4 |----| 9 |
  +---+    +---+    +---+
   CB1               CN1

Scriviamo un programma che cerca la soluzione in modo casuale.

Funzione che genera la lista delle mosse possibili da una data casella:

(define (move-list-from cell)
  (setq out '())
  ;(setq move-list (moves (- cur-from 1) 1))
  (setq move-list (moves (- cell 1) 1))
  (dolist (m move-list)
    ; casella di destinazione vuota?
    (if (= (lookup m cur-pos) "")
        (push m out -1)
    )
  )
  out)

Funzione che aggiorna la posizione corrente date le caselle di partenza e arrivo del pezzo da muovere:

(define (move-pieces from to)
  (local (piece-move1 piece-move2)
    (setq piece-move1 (lookup from cur-pos))
    (replace (list from piece-move1) cur-pos (list from ""))
    (setq piece-move2 (lookup to cur-pos))
    (replace (list to piece-move2) cur-pos (list to piece-move1))))

Funzione che stampa la posizione corrente:

(define (print-position) (println cur-pos))

Funzione che prova a risolvere il puzzle con mosse casuali:

(define (rand-game iter)
  (local (knights cur-pos cur-pieces cur-to cur-from num-mosse mossa-valida
          endpos1 endpos2 endpos3 endpos4)
  ; numero delle mosse
  (setq num-mossa 0)
  ; lista dei pezzi
  (setq knights '("CN1" "CB1" "CB2" "CN2"))
  ; posizione iniziale
  (setq cur-pos '((1 "CN1") (6 "") (7 "CB1") (2 "") (9 "CB2") (4 "") (3 "CN2") (8 "")))
  ; possibili posizioni finali
  (setq end-pos1 '((1 "CB1") (6 "") (7 "CN1") (2 "") (9 "CN2") (4 "") (3 "CB2") (8 "")))
  (setq end-pos2 '((1 "CB2") (6 "") (7 "CN1") (2 "") (9 "CN2") (4 "") (3 "CB1") (8 "")))
  (setq end-pos3 '((1 "CB1") (6 "") (7 "CN2") (2 "") (9 "CN1") (4 "") (3 "CB2") (8 "")))
  ; in realtà solo questa è possibile...
  (setq end-pos4 '((1 "CB2") (6 "") (7 "CN2") (2 "") (9 "CN1") (4 "") (3 "CB1") (8 "")))
  ; lista delle mosse: (casella (lista-caselle-raggiungibili))
  (setq moves '((1 (6 8))
                (2 (7 9))
                (3 (4 8))
                (4 (3 9))
                (5 ())
                (6 (1 7))
                (7 (2 6))
                (8 (1 3))
                (9 (2 4))))
  (until (or (= cur-pos end-pos1) (= cur-pos end-pos2)
             (= cur-pos end-pos3) (= cur-pos end-pos4))
    (print-position)
    ;(read-line)
    ; generazione della mossa casuale
    (setq mossa-valida nil)
    (until mossa-valida
      ; seleziona casualmente il cavallo da muovere
      (setq cur-pieces (knights (rand 4)))
      ;(println "cur-pieces: " cur-pieces)
      ; casella dove si trova il cavallo da muovere
      (setq cur-from (cur-pos (first (ref cur-pieces cur-pos)) 0))
      ;(println "cur-from: " cur-from)
      ; lista delle mosse possibili da cur-from
      (setq possible-move (move-list-from cur-from))
      ;(println "possible-move: " possible-move)
      (if (!= possible-move '())
        (begin
          (setq mossa-valida true)
          ; scelta della mossa casuale tra le mosse possibili
          (setq cur-to (possible-move (rand (length possible-move))))
          ;(println cur-to)
          ; aggiorna posizione corrente
          (move-pieces cur-from cur-to)
          (++ num-mosse)))
    )
  )
  (print-position)
  (println "Puzzle solved in " num-mosse " moves.")))

Proviamo a risolvere il puzzle:

(rand-game)
;-> ...
;-> ((1 "CB2") (6 "") (7 "CN2") (2 "") (9 "CN1") (4 "") (3 "CB1") (8 ""))
;-> Puzzle solved in 124 moves.

(rand-game)
;-> ...
;-> ((1 "CB2") (6 "") (7 "CN2") (2 "") (9 "CN1") (4 "") (3 "CB1") (8 ""))
;-> Puzzle solved in 260 moves.

(rand-game)
;-> ...
;-> ((1 "CB2") (6 "") (7 "CN2") (2 "") (9 "CN1") (4 "") (3 "CB1") (8 ""))
;-> Puzzle solved in 152 moves.


------------
Quale gioco?
------------

Gioco 1: Lanciare un dado una volta e venir pagato un milione di volte il numero della faccia uscito.
Gioco 2: Lanciare un dado un milione di volte. Per ogni lancio, venir pagato il numero della faccia uscito.

Quale gioco preferisci?

Speranza matematica
-------------------
La speranza (o aspettativa) matematica di una variabile casuale X è il numero che esprime il valore medio del fenomeno che questa variabile rappresenta.

L'speranza matematica, chiamata anche valore atteso, è uguale alla somma delle probabilità di un evento casuale, moltiplicata per il valore dell'evento casuale. In altre parole, è il valore medio di un set di dati. Questo, tenendo conto che il termine aspettativa matematica è coniato dalla teoria della probabilità.

In matematica, il valore medio degli eventi che si è verificati è chiamato media matematica.
Nelle distribuzioni discrete, se ogni evento ha la stessa probabilità, allora la media aritmetica è la stessa della speranza matematica.

      N
  S = ∑ [x(i) * P(xi)]
     i=1

dove: x(i) è il valore dell'evento i-esimo
      P(i) è la probabilità dell'evento i-esimo
      N è il numero di eventi

Nel gioco dei dadi, considerando gli eventi 1,2,3,4,5,6 con la stessa probabilità 1/6, il valore atteso vale:

 S = 1*(1/6) + 2*(1/6) + 3*(1/6) + 4*(1/6) + 5*(1/6) + 6*(1/6) = 3.5

Nel caso dei due giochi proposti, la speranza matematica è la stessa in tutte i due casi e vale 3.5 milioni.

Scriviamo una simulazione.

(define (game1) (* (+ (rand 6) 1) 1e6))

(define (game2)
  (let (s 0)
    (for (i 1 1e6)
      (++ s (+ (rand 6) 1)))))

Facciamo alcune prove:

(game1)
;-> 1000000
(game1)
;-> 3000000
(game1)
;-> 1000000
(game1)
;-> 6000000
(game1)
;-> 4000000

Con il gioco 1 qualche volta si vince di più di 3.5 milioni e qualche volta si vince di meno.

(game2)
;-> 3498892
(game2)
;-> 3500115
(game2)
;-> 3499542
(game2)
;-> 3498975
(game2)
;-> 3496147

Con il gioco 2 si vince sempre 3.5 milioni (più o meno).

Quindi la risposta dipende da quanto sia propenso al rischio il giocatore.

Esempio di speranza matematica
------------------------------
Un gioco ha le seguenti regole:
- si lancia un dado
- vince 4 euro se esce il 5
- vince 2 euro se esce un numero minore di 3
- in tutti gli altri casi deve pagare 1 euro

+-----------------+-----+-----+-----+
| Vincita Evento  |  4  |  2  | -1  |
+-----------------------------------+
| Probabilità     | 1/6 | 2/6 | 3/6 |
+-----------------------------------+

La speranza matematica vale:

S = 4*(1/6) + 2*(2/6) -1*(3/6) = 0.8333333...

Scriviamo una simulazione.

(define (game iter)
  (local (s val)
    (setq s 0)
    (for (i 1 iter)
      (setq val (+ (rand 6) 1))
      (cond ((= val 1) (++ s 2))
            ((= val 2) (++ s 2))
            ((= val 3) (-- s 1))
            ((= val 4) (-- s 1))
            ((= val 5) (++ s 4))
            ((= val 6) (-- s 1))
            (true (println "error: " val))
      )
    )
    (div s iter)))

Proviamo:

(game 1e4)
;-> 0.8478
(game 1e5)
;-> 0.82551
(game 1e6)
;-> 0.835291
(game 1e7)
;-> 0.8330925

Superenalotto
-------------
Giocando 1 euro al superenalotto si possono vincere 100.000.000 (cento milioni) di euro se si indovinano i sei numeri estratti su 90.

Vediamo di calcolare la speranza matematica:

1) Speranza matematica per "uscita di 6 numeri"

Somma da vincere 100000000 euro

Probabilita' di uscita di 6 numeri in ordine =
 = 1/90 · 1/89 · 1/88 · 1/87 · 1/86 · 1/85 = 1/448282533600

Pero' i numeri possono uscire in qualunque ordine, quindi occorre considerare le possibili sestine cioe' le permutazioni semplici su 6 oggetti:

Permutazioni su 6 oggetti p6 = 6! =6 · 5 · 4 · 3 · 2 · 1 = 720

Probabilita' di uscita di 6 numeri in ordine qualunque =
 = 720/448282533600 = 1.606129942690232e-009
(cioè quasi 2 possibilita' su un miliardo)

Speranza1 = S1*p1 =
 = 100000000 * 1.606129942690232e-009 = 0.1606129942690232 euro

2) Speranza matematica per "non uscita di tutti e sei i numeri"

Somma da vincere -1 euro (negativo perchè' si perde)

Probabilita' di non uscita di tutti e sei i numeri = probabilità contraria =
 = 1 - 1.606129942690232e-009 = 0.9999999983938701

Speranza2 = S2*p2 = -1 * 0.9999999983938701 = -0.9999999983938701 euro

La Speranza matematica totale vale S1p1 + S2p2 =

 = 0.1606129942690232 -0.9999999983938701 = -0.8393870041248469 euro

La speranza matematica del gioco vale 0.84 euro circa.
Questo significa che, in media, ad ogni giocata si perdono 0.84 euro.


-----------------------------
Usare una funzione come macro
-----------------------------

Questo metodo è stato mostrato da ralph.ronnquist.
Come esempio usiamo il modulo "infix.lsp":

(module "infix.lsp")
;-> MAIN

Adesso possiamo scrivere:

(INFIX:xlate "(4 + 5 - (7 * 2))")
;-> (sub (add 4 5) (mul 7 2))

(eval (INFIX:xlate "(4 + 5 - (7 * 2))"))
;-> -5

Per usare la funzione "xlate" come macro, cioè effettuare l'espansione dell'espressione durante l'interpretazione del sorgente, prima definiamo una macro vuota:

(macro (mix) nil)
;-> (lambda-macro () (expand 'nil))

Poi lo ridefiniamo per eseguire la chiamata "xlate" nel modo desiderato:

(constant 'mix (lambda-macro () (INFIX:xlate (join (map string (args)) " "))))
(lambda-macro () (INFIX:xlate (join (map string (args)) " ")))

A questo punto possiamo utilizzare la macro "mix" nei modi seguenti:

(define (foo a b) (mix a + b))
;-> (lambda (a b) (add a b))

'(mix 4 * 5 + sin(34) * 8)
;-> (add (mul 4 5) (mul (sin 34) 8))

(mix 4 * 5 + sin(34) * 8)
;-> 24.23266148896019

Come funziona questo metodo?
In altre parole, come fa la la macro a diventare "eseguibile" a causa della sua ridefinizione?

ralph.ronnquist:
"Well, being or not being a macro is, I believe, some flag attached to the symbol, which is set by the "(macro ..)" term. That term also wraps the given "body" into an "expand" term, as is typically useful for these kinds of macros. But not in this case, where you want the xlate-ion to be invoked at read time.
The "(constant ...)" term simply attaches a new definition to the symbol without messing with the flag, and thus redefines it. The manual has some discussion about this point."

Altro esempio:
;(module "infix.lsp")

;(macro (mix) nil)
;(constant 'mix (lambda-macro ()
;       (INFIX:xlate (join (map string (args)) " "))))

(define (quatmul q1 q2)
  (let ((x1 (nth 0 q1))   (y1 (nth 1 q1))   (z1 (nth 2 q1)) (w1 (nth 3 q1))
   (x2 (nth 0 q2))   (y2 (nth 1 q2))   (z2 (nth 2 q2)) (w2 (nth 3 q2)))
    (mix w = 0 - x1 * x2 - y1 * y2 - z1 * z2 + w1 * w2)
    (mix x =     x1 * w2 + y1 * z2 - z1 * y2 + w1 * x2)
    (mix y = 0 - x1 * z2 + y1 * w2 + z1 * x2 + w1 * y2)
    (mix z =     x1 * y2 - y1 * x2 + z1 * w2 + w1 * z2)))
;-> (lambda (q1 q2)
;->  (let ((x1 (nth 0 q1)) (y1 (nth 1 q1)) (z1 (nth 2 q1)) (w1 (nth 3 q1))
;->        (x2 (nth 0 q2)) (y2 (nth 1 q2)) (z2 (nth 2 q2)) (w2 (nth 3 q2)))
;->   (setq w (add (sub (sub (sub 0 (mul x1 x2)) (mul y1 y2)) (mul z1 z2)) (mul w1 w2)))
;->   (setq x (add (sub (add (mul x1 w2) (mul y1 z2)) (mul z1 y2)) (mul w1 x2)))
;->   (setq y (add (add (add (sub 0 (mul x1 z2)) (mul y1 w2)) (mul z1 x2)) (mul w1 y2)))
;->   (setq z (add (add (sub (mul x1 y2) (mul y1 x2)) (mul z1 w2)) (mul w1 z2)))))

(quatmul '(1 2 3 4) '(-9 -4 4 4))
;-> 42

(string (source 'quatmul))
"(define (quatmul q1 q2) ...
... (mul z1 w2)) (mul w1 z2)))))\r\n\r\n"


-----------------------------
Operazioni tra numeri stringa
-----------------------------

Qualche volta occorre fare operazioni su numeri che sono rappresentati come stringhe.
Ad esempio dobbiamo sommare i numeri-stringa "145634" e "3452".
Potremmo scrivere una serie di funzioni per ogni operazione, ad esempio per l'operazione "add":

(define (str-add str1 str2)
  (string (add (float str1) (float str2))))

(str-add "145634" "3452")
;-> "149086"

Comunque possiamo risolvere il problema con una sola funzione che ha come parametro anche l'operazione da effettuare:

(define (str-math op str1 str2)
  (string (op (float str1) (float str2))))

Questa unica funzione è generale perchè accetta qualunque operazione matematica tra due numeri-stringa:

(str-math + "1" "2")
;-> "3"
(str-math + 1 2)
;-> "3"
(str-math + "1.1" "2.1")
;-> "3"

(str-math add "1.0" "2")
;-> "3"
(str-math add "1.1" "2.1")
;-> "3.2"
(str-math add 1.1 2.1)
;-> "3.2"

Nota: i numeri-stringa possono anche essere numeri (integer o float).

(str-math add 1e5 2e5)
;-> "300000"

(str-math add "1e5" "2e5")
;-> "300000"


---------------------------------------
Confronto tra gli elementi di una lista
---------------------------------------

Data una lista di elementi ordinabili (numeri, stringhe, ecc.) verificare:

1) se gli elementi sono tutti uguali
2) se gli elementi sono ordinati in modo strettamente crescente

Possiamo scrivere due funzioni:

Lista con elementi tutti uguali?

(define (all-equal? lst) (apply = lst))

(setq a '(1 1 1))
(all-equal? a)
;-> true
(setq b '(1 2 2))
(all-equal? b)
;-> nil

(setq c '("1" "1" "1"))
(all-equal? c)
;-> true
(setq d '("3" "2" "1"))
(all-equal? d)
;-> nil

Lista ordinata in modo strettamente crescente?

(define (stret-crescente lst) (apply <  lst))

(setq e '("a" "b" "c"))
(stret-crescente e)
;-> true
(setq f '("a" "b" "b"))
(stret-crescente f)
;-> nil

Possiamo anche scrivere una funzione più generale:

(define (order-type lst)
"Check the sort order of a list"
  (cond ((apply =  lst) '= ) ;lista con elementi uguali
        ((apply >  lst) '> ) ;lista strettamente decrescente
        ((apply <  lst) '< ) ;lista strettamente crescente
        ((apply >= lst) '>=) ;lista decrescente
        ((apply <= lst) '<=) ;lista crescente
        (true nil)))         ;lista non ordinata

Facciamo alcune prove:

(order-type a)
;-> =
(order-type b)
;-> <=
(order-type c)
;-> =
(order-type d)
;-> >
(order-type e)
;-> <
(order-type f)
;-> <=
(order-type '(1 3 2))
;-> nil


---------------
Numeri colorati
---------------

Un numero colorato (colorful) è un numero intero non negativo in base 10 in cui il prodotto di ogni sottogruppo di cifre consecutive è unico.

Per esempio,
24753 è un numero colorato. 2, 4, 7, 5, 3, (2×4)=8, (4×7)=28, (7×5)=35, (5×3)=15, (2×4×7)=56, (4×7×5)=140, (7×5×3)=105, (2×4×7×5)=280, (4×7×5×3)=420, (2×4×7×5×3)=840
Ogni prodotto è unico.

2346 non è un numero colorato. 2, 3, 4, 6, (2×3)=6, (3×4)=12, (4×6)=24, (2×3×4)=48, (3×4×6)=72, (2×3×4×6)=144
Il prodotto 6 viene ripetuto.

I numeri a una cifra sono considerati colorati.
Un numero colorato maggiore di 9 non può contenere una cifra ripetuta, la cifra 0 o la cifra 1. Di conseguenza, esiste un limite superiore fisso per i numeri colorati: nessun numero colorato può avere più di 8 cifre.

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (colorato? num)
  (local (out lst len start cifre)
    (setq out '())
    (cond ((< num 10) true)
          ((> num 99999999) nil)
          (true
            (setq lst (int-list num))
            (cond ((find 0 lst) nil) ; nessuna cifra 0
                  ((find 1 lst) nil) ; nessuna cifra 1
                  ((!= lst (unique lst)) nil) ; solo numeri unici
                  (true
                    (setq len (length lst))
                    (setq cifre start)
                    (setq mult (- len 1))
                    ; calcola prodotti
                    (for (cifre 2 mult)
                      (for (start 0 (- len cifre))
                        (push (apply * (slice lst start cifre)) out -1)
                        ;(println start { } cifre)
                        ;(println (slice lst start cifre))
                      )
                    )
                    (if (> len 2)
                      (begin
                        ; aggiungiamo il prodotto di tutte le cifre alla lista
                        (push (apply * lst) out -1)
                        ; aggiungiamo le cifre alla lista
                        (extend out lst)
                      )
                    )
                    ;(println out)
                    (= (unique out) out))
            ))
    )))

(colorato? 24753)
;-> true
(colorato? 2346)
;-> nil
(colorato? 1111111)
;-> nil

(filter colorato? (sequence 0 100))
;-> ( 0  1  2  3  4  5  6  7  8  9
;->  23 24 25 26 27 28 29 32 34 35
;->  36 37 38 39 42 43 45 46 47 48
;->  49 52 53 54 56 57 58 59 62 63
;->  64 65 67 68 69 72 73 74 75 76
;->  78 79 82 83 84 85 86 87 89 92
;->  93 94 95 96 97 98)

Calcoliamo l'ultimo numero colorato:

(setq t (filter colorato? (sequence 99999999 98500000)))
;-> (98746253 98745362 98745263 98736254 98735462 98735264 98726453 98726354
;->  98674352 98673452 98672543 98672534 98654372 98653472 98652743 98652734
;->  98647352 98647253 98645372 98645273 98637452 98637254 98635472 98635274
;->  98627453 98627354 98625473 98625374 98547362 98547263 98546273 98537462
;->  98537264 98536274 98526473 98526374)

Ultimo numero colorato: 98.746.253

(time (setq all-colors (filter colorato? (sequence 0 999999))))
;-> 6152.286

Calcoliamo quali sono tutti i numeri colorati:

(time (setq all-colors (filter colorato? (sequence 0 99999999))))
;-> 230349.787 ; 230 secondi -> 3min 50sec

(length all-colors)
;-> 57256

Numeri colorati totali: 57256


----------------
Numeri brillanti
----------------

I numeri brillanti (brilliant) sono un sottoinsieme dei numeri semiprimi. Nello specifico, sono numeri che sono il prodotto esattamente di due numeri primi che hanno entrambi lo stesso numero di cifre quando espressi in base 10.
I numeri brillanti sono utili in crittografia e durante il test di algoritmi di fattorizzazione primi.

Esempi:
3 × 3 (9) è un numero brillante
2 × 7 (14) è un numero brillante
113 × 691 (78083) è un numero brillante
2 × 31 (62) non è un numero brillante (diverso numero di cifre nei due fattori 2 e 31)

Sequenza OEIS: A078972
 4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209,
 221, 247, 253, 289, 299, 319, 323, 341, 361, 377, 391, 403,
 407, 437, 451, 473, 481, 493, 517, 527, 529, 533, 551, 559,
 583, 589, 611, 629, 649, 667, 671, 689, 697, 703, 713, 731,
 737, 767, 779, 781 ...

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

Algoritmo:
Calcoliamo tutti i primi con "digits" cifre.
Raggruppiamo i primi in base al numero di cifre:
  1 <= p1 <= 9
  10 <= p1 <= 99
  100 <= p1 <= 999
  ....
E per ogni raggruppamento calcoliamo i numeri brillanti e li aggiungiamo alla lista soluzione.

(define (brilliant digits)
  (local (out limite primi filtrati)
    (setq out '())
    ; digits = 2 -> limite = 99
    ; digits = 3 -> limite = 999
    (setq limite (- (pow 10 digits) 1))
    (setq primi (primes-to limite))
    (for (i 1 digits)
      ; (1 9) (10 99) (100 999)...
      (setq val-min (pow 10 (- i 1)))
      (setq val-max (- (pow 10 i) 1))
      ;(println val-min { } val-max)
      (setq filtrati (filter (fn(x) (and (>= x val-min) (<= x val-max))) primi))
      ; aggiorna la lista soluzione con i numeri brillanti
      ; creati dai numeri primi da val-min a val-max
      (dolist (p1 filtrati)
        (dolist (p2 filtrati)
              ;(push (list p1 p2 (* p1 p2)) out -1)
              (push (* p1 p2) out -1)
        )
      )
    )
    (unique (sort out))))

Facciamo alcune prove:

(brilliant 2)
;-> (4 6 9 10 14 15 21 25 35 49 121 143 169 187 209 221 247 253 289 299 319
;->  323 341 361 377 391 403 407 437 451 473 481 493 517 527 529 533 551 559
;->  583 589 611 629 649 667 671 689 697 703 713 731 737 767 779 781 793 799
;->  803 817 841 851 869 871 893 899 901 913 923 943 949 961 979 989 1003 1007
;->  1027 1037 1067 1073 1079 1081 1121 1139 1147 1157 1159 1189 1207 1219
;->  1241 1247 1261 1271 1273 1333 1343 1349 1357 1363 1369 1387 1403 1411
;->  1457 1501 1513 1517 1537 1541 1577 1591 1633 1643 1649 1679 1681 1691
;->  1711 1739 1763 1769 1817 1829 1843 1849 1891 1909 1927 1943 1961 2021
;->  2047 2059 2077 2117 2173 2183 2201 2209 2231 2257 2263 2279 2291 2407
;->  2419 2449 2479 2491 2501 2537 2573 2581 2623 2627 2701 2747 2759 2773
;->  2809 2813 2867 2881 2911 2923 2993 3007 3053 3071 3127 3139 3149 3233
;->  3239 3293 3337 3397 3403 3431 3481 3551 3569 3589 3599 3649 3713 3721
;->  3763 3827 3869 3901 3953 3977 4087 4171 4183 4187 4189 4307 4331 4399
;->  4453 4489 4559 4661 4717 4757 4819 4891 4897 5041 5063 5141 5183 5251
;->  5293 5329 5429 5561 5609 5723 5767 5893 5917 5963 6059 6241 6319 6497
;->  6499 6557 6887 6889 7031 7081 7387 7663 7921 8051 8633 9409)

(length (brilliant 3))
;-> 10537

(length (brilliant 4))
;-> 573928

(time (println (length (brilliant 5))))
;-> 35547994
;-> 88158.245 ;88 secondi


--------------
StrappaCamicia
--------------

StrappaCamicia o StracciaCamicia o Scamicia è un gioco di carte diffuso in Italia con il mazzo napoletano da 40 carte divise in 4 semi (coppe, denari, bastoni, spade) di 10 carte ciascuno e giocato da 2 persone o più persone, anche in numero dispari.

Una volta mischiate le carte e smezzate dal giocatore alla propria sinistra vengono suddivise in mazzetti uguali, tanti quanti sono i giocatori.

Quando un giocatore gioca una delle tre carte vincenti il giocatore successivo è obbligato a giocare il numero di carte indicate (1 per l'asso, 2 per il due e 3 per il tre). Se durante queste giocata esce una delle carte vincenti l'obbligo si interrompe e tocca al giocatore successivo giocare il numero di carte indicate. Se il giocatore obbligato a giocare le carte non pone una carta vincente il mazzetto di carte presente sul tavolo viene preso dall'altro giocatore (che ha giocato un 1 o un 2 o un 3). Questo riporrà le carte sotto le proprie e inizierà un nuovo turno.

Il vincitore è quello che avrà l'intero mazzo (cioè quando tutti gli avversari non avranno più carte).

Esiste una configurazione del mazzo che porta ad una partita infinita, ovvero nella quale i giocatori non arriveranno mai a zero carte, in quanto dopo una certa sequenza di mosse ritorneranno allo stato iniziale. È stata trovata nel 2017, ed è la seguente (con 0 si indica una carta diversa da 1, 2 e 3):

Giocatore 1: 0 0 3 0 2 0 2 0 3 0 3 1 0 0 0 0 0 3 1 0
Giocatore 2: 0 0 1 0 0 2 0 0 0 0 2 0 0 0 0 0 0 0 1 0

(setq s1 '(0 0 3 0 2 0 2 0 3 0 3 1 0 0 0 0 0 3 1 0))
(setq s2 '(0 0 1 0 0 2 0 0 0 0 2 0 0 0 0 0 0 0 1 0))

Scriviamo un programma che simula una partita a StrappaCamicia:

(define (strappa stampa)
(local (carte mazzo shuffle s1 s2 pegno player grab scoperte carta)
  (setq carte (sequence 1 10))
  (setq mazzo (flat (dup carte 4)))
  ; mazzo mischiato
  (setq shuffle (randomize mazzo))
  ; carte del giocatore 1
  (setq s1 (slice shuffle 0 20))
  ; carte del giocatore 2
  (setq s2 (slice shuffle 20))
  ; uncomment the following two lines to run an infinite game
  (setq s1 '(0 0 3 0 2 0 2 0 3 0 3 1 0 0 0 0 0 3 1 0))
  (setq s2 '(0 0 1 0 0 2 0 0 0 0 2 0 0 0 0 0 0 0 1 0))
  (setq pegno 0)
  (setq player 1)
  (setq grab nil)
  (setq scoperte '())
  (until (or (= s1 '()) (= s2 '()))
    (if stampa (println "player: " player))
    (cond ((= player 1)
            ; estrazione prima carta e suo
            ; inserimento nelle carte scoperte
            (push (setq carta (pop s1)) scoperte -1)
            ; se carta = 1 o 2 o 3, allora imposta il nuovo pegno,
            ; tocca all'altro player e le carte scoperte
            ; possono essere catturate (al termine del pegno)
            (cond ((= carta 1) (setq pegno 1) (setq player 2) (setq grab true))
                  ((= carta 2) (setq pegno 2) (setq player 2) (setq grab true))
                  ((= carta 3) (setq pegno 3) (setq player 2) (setq grab true))
                  (true ;altrimenti
                    ; se il pegno vale 0, significa che il turno
                    ; passa all'altro player (non sta pagando pegno)
                    (if (= 0 pegno) (setq player 2))
                    ; se il pegno vale 1, significa che il turno
                    ; passa all'altro player e ...
                    (if (= 1 pegno)
                      (begin
                        (setq player 2)
                        (-- pegno)
                        ; se anche grab vale true, significa che
                        ; che questo giocatore ha finito di pagare il pegno e
                        ; l'altro giocatore deve prendere le carte scoperte
                        (if grab
                          (begin
                            (extend s2 scoperte)
                            (setq scoperte '())
                            (setq grab nil)
                          )
                        )
                      )
                    )
                    ; se il pegno maggiore di 1, significa che
                    ; stiamo pagando pegno e quindi
                    ; diminuiamo il suo valore
                    (if (> pegno 1) (-- pegno))
                  )
            )
          )
          ((= player 2)
            ; estrazione prima carta e suo
            ; inserimento nelle carte scoperte
            (push (setq carta (pop s2)) scoperte -1)
            ; se carta = 1 o 2 o 3, allora imposta il nuovo pegno,
            ; tocca all'altro player e le carte scoperte
            ; possono essere catturate (al termine del pegno)
            (cond ((= carta 1) (setq pegno 1) (setq player 1) (setq grab true))
                  ((= carta 2) (setq pegno 2) (setq player 1) (setq grab true))
                  ((= carta 3) (setq pegno 3) (setq player 1) (setq grab true))
                  (true ;altrimenti
                    ; se il pegno vale 0, significa che il turno
                    ; passa all'altro player (non sta pagando pegno)
                    (if (= 0 pegno) (setq player 1))
                    ; se il pegno vale 1, significa che il turno
                    ; passa all'altro player e ...
                    (if (= 1 pegno)
                      (begin
                        (setq player 1)
                        (-- pegno)
                        ; se anche grab vale true, significa che
                        ; che questo giocatore ha finito di pagare il pegno e
                        ; l'altro giocatore deve prendere le carte scoperte
                        (if grab
                          (begin
                            (extend s1 scoperte)
                            (setq scoperte '())
                            (setq grab nil)
                          )
                        )
                      )
                    )
                    ; se il pegno maggiore di 1, significa che
                    ; stiamo pagando pegno e quindi
                    ; diminuiamo il suo valore
                    (if (> pegno 1) (-- pegno))
                  )
            )
          )
    )
    (if stampa (begin
      (println "carta estratta: " carta)
      (println "pegno: " pegno)
      (println "scoperte: " scoperte)
      (println "mazzo 1: " s1 { } (length s1))
      (println "mazzo 2: " s2 { } (length s2))
      (println "new player: " player)
      (read-line)))
  )
  player))

Simuliamo una partita:

(strappa true)
;-> player: 1
;-> carta estratta: 5
;-> pegno: 0
;-> scoperte: (5)
;-> mazzo 1: (4 5 7 10 4 9 6 7 2 3 4 6 9 7 6 8 2 3 1) 19
;-> mazzo 2: (2 3 3 8 7 10 5 1 8 8 6 10 5 9 10 1 2 4 1 9) 20
;-> new player: 2
;->
;-> player: 2
;-> carta estratta: 2
;-> pegno: 2
;-> scoperte: (5 2)
;-> mazzo 1: (4 5 7 10 4 9 6 7 2 3 4 6 9 7 6 8 2 3 1) 19
;-> mazzo 2: (3 3 8 7 10 5 1 8 8 6 10 5 9 10 1 2 4 1 9) 19
;-> new player: 1
;-> ...
;-> player: 1
;-> carta estratta: 2
;-> pegno: 2
;-> scoperte: (2)
;-> mazzo 1: (8 4 9 1 4 7 7 3 8 6 9 3 3 3 9 6 5 10 5 5 9 10 1 7 4 1 2 8 10 10 2 6 6 4 2 7 1 5) 38
;-> mazzo 2: (8) 1
;-> new player: 2
;->
;-> player: 2
;-> carta estratta: 8
;-> pegno: 1
;-> scoperte: (2 8)
;-> mazzo 1: (8 4 9 1 4 7 7 3 8 6 9 3 3 3 9 6 5 10 5 5 9 10 1 7 4 1 2 8 10 10 2 6 6 4 2 7 1 5) 38
;-> mazzo 2: () 0
;-> new player: 2

Facciamo alcuni test per vedere se la simulazione del gioco è equa:

(define (test limite)
  (setq p1 0)
  (setq p2 0)
  (for (i 1 limite)
    (setq res (strappa))
    (cond ((= res 1) (++ p2))
          ((= res 2) (++ p1))
          (true (println res))
    )
  )
  (list p1 p2))

Facciamo alcune prove (sperando di non incappare in qualche partita infinita):

(test 1e2)
;-> (50 50)
(test 1e2)
;-> (48 52)
(test 1e3)
;-> (499 501)
(test 1e3)
;-> (509 491)
(test 1e3)
;-> (484 516)
(test 1e4)
;-> (4934 5066)
(test 1e5)
;-> (50073 49927)
(time (println (test 1e6)))
;-> (499372 500628)
;-> 74640.609

Per simulare una partita infinita togliere (nella funzione "strappa") il commento alle righe:
  ;(setq s1 '(0 0 3 0 2 0 2 0 3 0 3 1 0 0 0 0 0 3 1 0))
  ;(setq s2 '(0 0 1 0 0 2 0 0 0 0 2 0 0 0 0 0 0 0 1 0))


------------------------------------
Circonferenza passante per tre punti
------------------------------------

Dati tre punti, trovare il centro (x0, y0) e il raggio (r0) del cerchio che li attraversa.
Tre punti individuano un'unico cerchio se, e solo se, non sono allineati.

Primo metodo
------------
Dalla geometria analitica, il cerchio unico che passa per i tre punti:

   (x1, y1), (x2, y2), (x3, y3)

può essere trovato risolvendo la seguente equazione:

  | (x^2 + y^2)    x   y   1 |
  | (x1^2 + y1^2)  x1  y1  1 | = 0
  | (x2^2 + y2^2)  x2  y2  1 |
  | (x3^2 + y3^2)  x3  y3  1 |

Per la dimostrazione vedi "Center and Radius of a Circle from Three Points" di Stephen R. Schmitt.
http://www.abecedarical.com/zenosamples/zs_circle3pts.html

Una volta risolto il sistema si ricavano la formule per il calcolo del centro (x0, y0) e del raggio r0 che sono le seguenti:

         M01
  x0 = -------
        2*M00

           M02
  y0 = - -------
          2*M00

                           M03
  r0 = sqrt(x0^2 + y0^2 + -----)
                           M00

dove Mij = det[m(i,j)]

Il minore m(i,j) di una matrice A è la matrice (n-1)x(n-1) formata rimuovendo l'i-esima riga e la j-esima colonna dalla matrice A.

Nel nostro caso abbiamo:

(setq a
  '(( "(x^2 + y^2)"    x   y   1 )
    ( "(x1^2 + y1^2)"  x1  y1  1 )
    ( "(x2^2 + y2^2)"  x2  y2  1 )
    ( "(x3^2 + y3^2)"  x3  y3  1 )))

Scriviamo una funzione per calcolare i minori di una matrice:

(define (minor matrix row col)
  (local (tmp)
    (pop matrix row)
    (setq tmp (transpose matrix))
    (pop tmp col)
  (transpose tmp)))

Calcoliamo i minori che ci servono:

(minor a 0 0)
;-> ((x1 y1 1)
;->  (x2 y2 1)
;->  (x3 y3 1))
(minor a 0 1)
;-> (("(x1^2 + y1^2)" y1 1)
;->  ("(x2^2 + y2^2)" y2 1)
;->  ("(x3^2 + y3^2)" y3 1))
(minor a 0 2)
;-> (("(x1^2 + y1^2)" x1 1)
;->  ("(x2^2 + y2^2)" x2 1)
;->  ("(x3^2 + y3^2)" x3 1))
(minor a 0 3)
;-> (("(x1^2 + y1^2)" x1 y1)
;->  ("(x2^2 + y2^2)" x2 y2)
;->  ("(x3^2 + y3^2)" x3 y3))

Adesso possiamo scrivere la funzione finale:

(define (circle3p x1 y1 x2 y2 x3 y3)
  (local (a m00 m01 m02 m03 q1 q2 q3 x0 y0 r0)
    (setq a (array 3 3 '(0)))
    (setq q1 (add (mul x1 x1) (mul y1 y1)))
    (setq q2 (add (mul x2 x2) (mul y2 y2)))
    (setq q3 (add (mul x3 x3) (mul y3 y3)))
    ; minor m00
    (setf (a 0 0) x1)
    (setf (a 0 1) y1)
    (setf (a 0 2) 1)
    (setf (a 1 0) x2)
    (setf (a 1 1) y2)
    (setf (a 1 2) 1)
    (setf (a 2 0) x3)
    (setf (a 2 1) y3)
    (setf (a 2 2) 1)
    (setq m00 (det a))
    ; minor m01
    (setf (a 0 0) q1)
    (setf (a 0 1) y1)
    (setf (a 0 2) 1)
    (setf (a 1 0) q2)
    (setf (a 1 1) y2)
    (setf (a 1 2) 1)
    (setf (a 2 0) q3)
    (setf (a 2 1) y3)
    (setf (a 2 2) 1)
    (setq m01 (det a))
    ; minor m02
    (setf (a 0 0) q1)
    (setf (a 0 1) x1)
    (setf (a 0 2) 1)
    (setf (a 1 0) q2)
    (setf (a 1 1) x2)
    (setf (a 1 2) 1)
    (setf (a 2 0) q3)
    (setf (a 2 1) x3)
    (setf (a 2 2) 1)
    (setq m02 (det a))
    ; minor m03
    (setf (a 0 0) q1)
    (setf (a 0 1) x1)
    (setf (a 0 2) y1)
    (setf (a 1 0) q2)
    (setf (a 1 1) x2)
    (setf (a 1 2) y2)
    (setf (a 2 0) q3)
    (setf (a 2 1) x3)
    (setf (a 2 2) y3)
    (setq m03 (det a))
    ; controllo sui valori dei determinanti
    (if (nil? m01) (setq m01 0))
    (if (nil? m02) (setq m02 0))
    (if (nil? m03) (setq m03 0))
    ;(println m00 { } m01 { } m02 { } m03)
    ; calcolo parametri del cerchio
    (if (nil? m00) nil
    (begin
      (setq x0 (div m01 (mul 2 m00)))
      (setq y0 (div m02 (mul -2 m00)))
      (setq r0 (sqrt (add (mul x0 x0) (mul y0 y0) (div m03 m00))))
      (list x0 y0 r0)))))

Facciamo alcune prove:

(circle3p 0 1 1 0 0 -1)
;-> (0 0 1)

(circle3p 1 1 2 4 5 3)
;-> (3 2 2.23606797749979) ; (3 2 sqrt(5))

(circle3p 4 2 5 1 4 0)
;-> (4 0.9999999999999998 1)

(circle3p 1 -6 2 1 5 2)
;-> (4.999999999999999 -3 5)


Secondo metodo
--------------
Equazione del cerchio in forma generale vale:

  x² + y² + 2gx + 2fy + c = 0

oppure in altra forma:

  (x – x0)² + (y - y0)² = r0²,

dove (x0, y0) è il centro del cerchio e r0 è il raggio.

Mettendo le coordinate nell'equazione del cerchio e risolvendo per 2f e 2g e c, otteniamo:

  2f = ((x1^2 - x3v2)*(x1 - x2) + (y1^2 - y3v2)*(x1 - x2) +
        (x2^2 - x1^2)*(x1 - x3) + (y2^2 - y1^2)*(x1 - x3))
       /
       ((y3 - y1)*(x1 - x2) - (y2 - y1)*(x1 - x3))

  2g = ((x1^2 - x3^2)*(y1 - x2) + (y1^2 - y3^2)*(y1 - y2) +
        (x2^2 - x1^2)*(y1 - y3) + (y2^2 - y1^2)*(y1 - y3))
       /
       ((x3 - x1)*(y1 - y2) - (x2 - x1)*(y1 - y3))

  c = x1^2 + y1^2 - 2*g*x1 - 2*f*y1

Implementiamo queste formule:

(define (cerchio3p x1 y1 x2 y2 x3 y3)
  (setq x12 (sub x1 x2))
  (setq x13 (sub x1 x3))
  (setq y12 (sub y1 y2))
  (setq y13 (sub y1 y3))
  (setq y31 (sub y3 y1))
  (setq y21 (sub y2 y1))
  (setq x31 (sub x3 x1))
  (setq x21 (sub x2 x1))
  (setq sx13 (sub (mul x1 x1) (mul x3 x3)))
  (setq sy13 (sub (mul y1 y1) (mul y3 y3)))
  (setq sx21 (sub (mul x2 x2) (mul x1 x1)))
  (setq sy21 (sub (mul y2 y2) (mul y1 y1)))
  (setq f (div (add (mul sx13 x12) (mul sy13 x12) (mul sx21 x13) (mul sy21 x13))
               (mul 2 (sub (mul y31 x12) (mul y21 x13)))))
  (setq g (div (add (mul sx13 y12) (mul sy13 y12) (mul sx21 y13) (mul sy21 y13))
               (mul 2 (sub (mul x31 y12) (mul x21 y13)))))
  (setq c (sub 0 (mul x1 x1) (mul y1 y1) (mul 2 g x1) (mul 2 f y1)))
  (setq x0 (mul -1 g))
  (setq y0 (mul -1 f))
  (setq r0 (sqrt (sub (add (mul x0 x0) (mul y0 y0)) c)))
  (list x0 y0 r0))

Facciamo alcune prove:

(cerchio3p 0 1 1 0 0 -1)
;-> (0 -0 1)

(cerchio3p 1 1 2 4 5 3)
;-> (3 2 2.23606797749979) ; (3 2 sqrt(5))

(cerchio3p 4 2 5 1 4 0)
;-> (4 1 1)

(cerchio3p 1 -6 2 1 5 2)
;-> (5 -3 5)


---------------------------
Determinante di una matrice
---------------------------

Per calcolare il determinante di una matrice, prima trasformiamo la matrice data in una matrice triangolare superiore usando le operazioni sulle righe. Al termine il prodotto degli elementi diagonali della matrice diagonale è il determinante.

(define (deter matrix)
  (setq n (length matrix))
  ; trasforma la matrice data in una matrice triangolare superiore
  ; "fd" significa "focus diagonal"
  (for (fd 0 (- n 1))
    ; trucco: zero + ~zero
    ;(if (zero? (matrix fd fd)) (setf (matrix fd fd) 1.0e-18))
    # salta le righe con "fd"
    (if (<= (+ fd 1) (- n 1))
      (begin
        (for (i (+ fd 1) (- n 1))
          ; trucco: zero + ~zero
          (if (zero? (matrix fd fd)) (setf (matrix fd fd) 1.0e-18))
          ; "crs" significa "current row scaler".
          (setq crs (div (matrix i fd) (matrix fd fd)))
          (for (j 0 (- n 1))
            ; scala un elemento per volta
            (setf (matrix i j) (sub (matrix i j) (mul crs (matrix fd j))))
          )
        )
      )
    )
  )
  ; adesso la matrice è in forma triangolare superiore
  ; quindi il prodotto della diagonale è il determinante
  (setq product 1.0)
  (for (i 0 (- n 1))
    (setq product (mul product (matrix i i)))
  )
  product)

Facciamo alcune prove e verifiche:

(deter '((1 2) (2 1)))
;-> -3
(det '((1 2) (2 1)))
;-> -3
(deter '((1 3) (3 1)))
;-> -8
(det '((1 3) (3 1)))
;-> -8
(deter '((1 2 3) (4 5 6) (7 8 9)))
;-> 0
(det '((1 2 3) (4 5 6) (7 8 9)))
;-> 6.661338147750939e-016
(deter '((-1 -2 -3) (4 -5 6) (-7 -8 -9)))
;-> 120
(det '((-1 -2 -3) (4 -5 6) (-7 -8 -9)))
;-> 120

Vediamo la differenza di velocità tra la nostra funzione "deter" e la funzione integrata "det":

Creiamo una matrice casuale 10x10 con numeri da 1 a 100:

(setq test (explode (rand 10 100) 10))

Calcoliamo il determinate con le due funzioni:

(deter test)
;-> 36134858.0000001

(det test)
;-> 36134858.00000002

Vediamo la velocità di esecuzione:

(time (deter test) 10000)
;-> 799.727

(time (det test) 10000)
;-> 14.961

La funzione integrata "det" è 50 volte più veloce.


-------------------------
Multiple Value Bind macro
-------------------------

Emulazione del "multiple-value-bind" con una macro (by hds1).

;; @syntax (m-v-b symlist valuelist body)
;;
;; @param  symlist valuelist body
;; symlist: List of var names
;; valuelist: List of values or function call which returns list of values
;; body: Operation with var names
;; @return Expanded 'let with body
;; @example
;; (m-v-b '(a b c) '(1 2 3) (+ a b c)) -> (let (a 1 b 2 c 3) (+ a b c))
;; Supposed to emulate Common Lisp multiple-value-bind macro
;; Expansion is done during Read Time.
;; Evaluation of the returned 'let body during Run Time.
(macro (m-v-b) nil)
(constant 'm-v-b (lambda-macro ()
         ;; Read Time part
        (when (or (not (quote? (args 0)))
             (not (list? (eval (args 0)))))
          (throw-error "m-v-b: first argument must be a quoted list i.e. '(a b c)"))
        (let ((lst1 (eval (args 0)))
         (lst2 (map quote (eval (args 1))))) ; quote elements so that list of lists can be used
          (when (!= (length lst1)
               (length lst2))
            (throw-error
             (append "m-v-b: Argument lists length unequal. " (string lst1) " " (string lst2))))
          ;; Run Time part
          (list 'let
           (flat (transpose (list lst1 lst2)))
           (args 2)))))

(m-v-b '(a b) (transpose '((1 2)(3 4))) (println a b))
;->  (1 3)(2 4)

(m-v-b '(a b) '(3 4) (println a { } b))
;-> 3 4

(m-v-b '(a b) '(3 4) (list a b))
;-> (3 4)

Nota: le variabili della macro (es. "a" e "b") esistono solo durante l'esecuzione della macro stessa:

(m-v-b '(a b) '(3 4) (println a { } b))
;-> 3 4

a
;-> nil
b
;-> nil


---------------
100 prigionieri
---------------

100 prigionieri sono numerati da 1 a 100.
Una stanza con un armadio di 100 cassetti numerati da 1 a 100.
All'inizio un mazzo di carte numerate da 1 a 100 vengono messe casualmente, una per ogni cassetto, e tutti i cassetti vengono chiusi.
I prigionieri iniziano fuori dalla stanza.
Possono decidere una strategia prima di entrare nella stanza.
I prigionieri entrano nella stanza uno alla volta, possono aprire un cassetto, controllare il numero della carta nel cassetto, quindi chiudere il cassetto.
Un prigioniero non può aprire più di 50 cassetti.
Un prigioniero che trova il proprio numero viene separato dagli altri.
Se tutti i 100 prigionieri trovano il proprio numero, saranno tutti graziati. In caso contrario, saranno tutti giustiziati.

Simulare diverse migliaia di prove del gioco in cui i prigionieri aprono casualmente i cassetti.
Simulare diverse migliaia di prove del gioco in cui i prigionieri usano la seguente strategia ottimale:
- Per prima cosa il prigioniero apre il cassetto il cui numero esterno è il suo numero di prigioniero.
- Se la carta all'interno ha il suo numero allora ha successo, altrimenti apre il cassetto con lo stesso numero della carta scoperta (e così via finché non raggiunge il massimo di 50 cassetti aperti o trova il suo numero).

Calcolare le probabilità delle due strategie.

Funzione per la simulazione della strategia casuale:

(define (casuale)
  (local (cassetti carte armadio num-graziati trovato cassetto carta)
    ; strategia casuale (random)
    (setq cassetti (sequence 1 100))
    (setq carte (sequence 1 100))
    (setq armadio (map list (randomize cassetti) (randomize carte)))
    (push '(0 0) armadio)
    (setq num-graziati 0)
    ; ciclo per ogni prigioniero
    (for (p 1 100)
      (setq trovato nil)
      ; 50 prove per ogni prigioniero
      (for (i 1 50 1 trovato)
        ; apertura di un cassetto a caso
        (setq cassetto (+ (rand 100) 1))
        (setq carta (lookup cassetto armadio))
        ; carta nel cassetto uguale numero prigioniero?
        (cond ((= carta p)
                (++ num-graziati)
                (setq trovato true))
        )
      )
    )
    ; se tutti graziati restituisce true, altrimenti nil
    (if (= num-graziati 100) true nil)))

(define (test-casuale iter)
  (let (totale 0)
    (for (i 1 iter) (if (casuale) (++ totale)))
    (div totale iter)))

Calcolo delle probabilità della strategia casuale:

(test-casuale 1e3)
;-> 0
(test-casuale 1e4)
;-> 0
(test-casuale 1e5)
;-> 0

Nota: la probabilità teorica vale P(casuale) = 1/(2^100) =

  = 1/1267650600228229401496703205376 ≈ 0

Funzione per la simulazione della strategia ottimale:

(define (ottimale)
  (local (cassetti carte armadio num-graziati trovato cassetto carta prove)
    ; strategia ottimale
    (setq cassetti (sequence 1 100))
    (setq carte (sequence 1 100))
    (setq armadio (map list (randomize cassetti) (randomize carte)))
    (push '(0 0) armadio)
    (setq num-graziati 0)
    ; ciclo per ogni prigioniero
    (for (p 1 100)
      (setq trovato nil)
      (setq prove 0)
      (setq cassetto p)
      (until (or trovato (>= prove 50))
        (++ prove)
        (setq carta (lookup cassetto armadio))
        (if (= carta p)
          (begin
            (setq trovato true)
            (++ num-graziati)
          )
          ;else
          (setq cassetto carta)
        )
      )
    )
    ; se tutti graziati restituisce true, altrimenti nil
    (if (= num-graziati 100) true nil)))

(define (test-ottimale iter)
  (let (totale 0)
    (for (i 1 iter) (if (ottimale) (++ totale)))
    (div totale iter)))

Calcolo delle probabilità della strategia ottimale:

(test-ottimale 1e3)
;-> 0.306
(test-ottimale 1e4)
;-> 0.3034
(test-ottimale 1e5)
;-> 0.31218

Nota: la probabilità teorica vale P(ottimale) = 0.30685281


------------
Morra cinese
------------

La morra cinese (o Sasso-Carta-Forbici) è un gioco tra due persone che mostrano contemporaneamente uno dei tre simboli con la mano:

- Sasso: la mano chiusa a pugno.
- Carta: la mano aperta con tutte le dita stese.
- Forbici: mano chiusa con indice e medio estesi a formare una "V".

Lo scopo è sconfiggere l'avversario scegliendo un segno in grado di battere quello dell'altro, secondo le seguenti regole:

1) Il Sasso spezza le Forbici (vince il Sasso)
2) Le Forbici tagliano la Carta (vincono le Forbici)
3) La Carta avvolge il Sasso (vince la Carta)

Se i due giocatori scelgono lo stesso simbolo, il gioco è pari e si gioca di nuovo.

La strategia tra giocatori umani comporta l'uso della psicologia per predire o influenzare le scelte dell'avversario.
Secondo la teoria dei giochi la strategia ottimale è quella di selezionare i simboli casualmente. In questo caso "ottimale" significa solo "incapace di essere sconfitto più di quanto ci si attenda dal caso", mentre non implica che questa strategia casuale sia la migliore contro un avversario non ottimale. Infatti, se l'avversario è un essere umano, è molto probabile che giochi in modo sub-ottimale e che una strategia modificata possa sfruttare tale comportamento (debolezza).

Scrivere una funzione per simulare un determinato numero di partite a morra cinese con strategia casuale.

Utilizzando la seguente tabella (matrice):

                 Player 2
  Player 1   Sasso Carta Forbici
   Sasso       0     -1     1
   Carta       1      0    -1
   Forbici    -1      1     0

(setq table '((0 -1 1) (1 0 -1) (-1 1 0)))

possiamo calcolare il risultato di un gioco con l'espressione:

(setq res (table (rand 3) (rand 3)))

Che può produrre i seguenti risultati:

  res =  1 -> vince il giocatore 1
  res = -1 -> vince il giocatore 2
  res =  0 -> pareggio

Funzione per simulare il gioco della morra cinese:

(define (morra partite)
  (local (table diff p1 p2)
    (setq table '((0 -1 1) (1 0 -1) (-1 1 0)))
    (setq diff 0)
    (for (i 1 partite)
      ; calcoliamo la differenza tra vincite e perdite (+1 e -1)
      (++ diff (table (rand 3) (rand 3)))
    )
    ; ricostruzione dei punteggi p1 e p2 che non rappresentano
    ; il numero di vittorie, ma i punteggi dei due giocatori,
    ; perchè non è possibile calcolare il numero di partite patte
    (setq p1 (/ (+ diff partite) 2))
    (setq p2 (- p1 diff))
    (list p1 p2 diff (div p1 p2))
  ))

Facciamo alcune prove:

(morra 1)
;-> (0 1 -1 0)
(morra 10)
;-> (6 4 2 1.5)
(morra 1e4)
;-> (4980 5020 -40 0.9920318725099602)
(morra 1e5)
;-> (49909 50090 -181 0.9963865042922739)
(morra 1e6)
;-> (500340 499660 680 1.001360925429292)
(morra 1e7)
;-> (5000828 4999172 1656 1.000331254855804)
(morra 1e8)
;-> (50003626 49996373 7253 1.000145070523416)
(time (morra 1e8))
;-> 11814.346
Scriviamo un'altra funzione più completa per simulare la morra cinese:

(define (cinese partite)
  (local (table p p1 p2 res)
    (setq table '((0 -1 1) (1 0 -1) (-1 1 0)))
    (set 'p 0 'p1 0 'p2 0)
    (for (i 1 partite)
      (setq res (table (rand 3) (rand 3)))
      (case res
        ( 0 (++ p))
        ( 1 (++ p1))
        (-1 (++ p2))
      )
    )
    (list p1 p2 p (div p1 p2))
  ))

Facciamo le stesse prove:

(cinese 1)
;-> (0 1 0 0)
(cinese 10)
;-> (6 2 2 3)
(cinese 1e4)
;-> (3294 3330 3376 0.9891891891891892)
(cinese 1e5)
;-> (33453 33303 33244 1.004504098729844)
(cinese 1e6)
;-> (334087 332557 333356 1.004600715065387)
(cinese 1e7)
;-> (3334859 3333208 3331933 1.00049531862398)
(cinese 1e8)
;-> (33331386 33334613 33334001 0.9999031937163933)
(time (cinese 1e8))
;-> 15609.656

I risultati delle due funzioni sono congruenti.

Funzione ottimizzata:

(define (fast partite)
  ; (arr 0) = patte, (arr 1) = vittorie p1, (arr 2) = vittorie p2
  (let (arr (array 3 '(0)))
    (for (i 1 partite) (++ (arr (rand 3))))
    (list (arr 1) (arr 2) (arr 0) (div (arr 1) (arr 2)))))

(time (println (fast 1e8)))
;-> (33333857 33333261 33332882 1.0000178800388)
;-> 6737.767


---------
Rubamazzo
---------

Il rubamazzo è un gioco tra due persone che viene fatto con le carte italiane (40 carte divise in 4 semi di 10 carte ciascuno).

Regole
------
Dopo che le carte sono state mischiate vengono distribuite 3 carte a ciascun giocatore e poi vengono messe 4 scoperte sul tavolo.
Ogni giocatore nel rispettivo turno può prendere solo una carta dello stesso valore dal tavolo obbligatoriamente (ad es. se in mano ha un 7, allora dal tavolo può prendere solo un altro 7).
Ogni volta che viene effettuata una presa, il giocatore deve tenere scoperta l'ultima carta del proprio mazzo.
Se l'avversario ne ha una dello stesso valore in mano può "rubare" il suo mazzo (che va tenuto sempre girato). Se la carta in tavola è la stessa del mazzo dell'avversario si prende quella che si preferisce.
Una volta concluso il turno, le carte del mazzo saranno distribuite (3 + 3) ai due giocatori per iniziare un nuovo turno.
Dopo l'ultima mano, le carte rimaste sulla tavola vengono prese dal giocatore che ha fatto l'ultima presa.
Il vincitore è quello che ha il maggior numero di carte (ogni carta vale 1).

Funzione che stampa la posizione corrente:

(define (print-position)
  (println)
  (print "[ ")
  (dolist (c mano2) (print c " "))
  (print "]")
  (println "  (" scoperta2 ") " num-carte2)
  (println)
  (dolist (v visibili) (print " " v " "))
  (println) (println)
  (print "[ ")
  (dolist (c mano1) (print c " "))
  (print "]")
  (println "  (" scoperta1 ") " num-carte1)
  (println "---------------------")
)

Funzione che seleziona una carta casuale da una mano di carte:

(define (random-play mano) (mano (rand (length mano))))

Funzione che cattura il mazzetto dell'avversario (se ha la stessa carta) oppure seleziona una carta casuale da una mano di carte:

(define (grab-play mano player)
  (cond ((= player 1)
          (if (find scoperta2 mano)
              scoperta2
              (mano (rand (length mano)))))
        ((= player 2)
          (if (find scoperta1 mano)
              scoperta1
              (mano (rand (length mano)))))
  ))

(setq mano1 '(9 10 3))
(setq scoperta1 6)
(setq mano2 '(2 1 6))
(setq scoperta2 9)

(grab-play mano1 1)
;-> 9
(grab-play mano2 2)
;-> 6

Funzione che esegue una partita di rubamazzo passo-passo.
Se tipo = 1, allora viene scelta la strategia casuale
Se tipo è diverso da 1, allora viene scelta la strategia "cattura mazzetto"
;;;
;;; OK
;;;
(define (rubamazzo-log tipo)
  ; setup posizione iniziale
  (setq carte (flat (dup (sequence 1 10) 4)))
  (setq mazzo (randomize carte))
  ; carte scoperte dei due giocatori
  (setq scoperta1 "") (setq scoperta2 "")
  ; carte visibili sul tavolo
  (setq visibili (list (pop mazzo 0) (pop mazzo 0) (pop mazzo 0) (pop mazzo 0)))
  ; carte catturate di ogni giocatore
  (setq num-carte1 0) (setq num-carte2 0)
  ; giocatore corrente
  (setq player 1)
  ; inizio della partita
  (while mazzo ; finchè ci sono carte nel mazzo...
    ; distribuzione carte ai giocatori (per una mano)
    (setq mano1 (list (pop mazzo 0) (pop mazzo 0) (pop mazzo 0)))
    (setq mano2 (list (pop mazzo 0) (pop mazzo 0) (pop mazzo 0)))
    (print-position)
    (println "mazzo: " mazzo) (read-line)
    ; per ogni mano...
    (while (or mano1 mano2)
      (cond ((= player 1)
              (if (= tipo 1) ; carta giocata casuale
                (setq carta (random-play mano1))
                ;else cattura mazzetto se possibile
                (setq carta (grab-play mano1 1))
              )
              (pop mano1 (find carta mano1))
              (println "player 1: " carta { } scoperta2)
                    ;carta uguale a carta scoperta dell'avversario
              (cond ((= carta (int scoperta2))
                      (println "cattura mazzetto")
                      ; cattura del mazzetto dell'avversario
                      (setq num-carte1 (+ num-carte1 num-carte2 1))
                      (setq num-carte2 0)
                      (setq scoperta1 (string carta))
                      (setq scoperta2 "")
                      (setq ultimo 1)
                      (setq player 2))
                    ; carta uguale ad una carta visibile
                    ((find carta visibili)
                      (println "prende carta dal tavolo")
                      ; cattura della carta visibile
                      (pop visibili (ref carta visibili))
                      (setq num-carte1 (+ num-carte1 2))
                      (setq scoperta1 (string carta))
                      (setq ultimo 1)
                      (setq player 2))
                    ; carta diversa da tutte le carte visibili
                    (true
                      (println "aggiunge carta sul tavolo")
                      (push carta visibili -1)
                      (setq player 2))
              ))
            ((= player 2)
              (if (= tipo 1) ; carta giocata casuale
                  (setq carta (random-play mano2))
                  ;else cattura mazzetto se possibile
                  (setq carta (grab-play mano2 2))
              )
              (pop mano2 (find carta mano2))
              (println "player 2: " carta)
                    ;carta uguale a carta scoperta dell'avversario
              (cond ((= carta (int scoperta1))
                      (println "cattura mazzetto")
                      ; cattura del mazzetto dell'avversario
                      (setq num-carte2 (+ num-carte2 num-carte1 1))
                      (setq num-carte1 0)
                      (setq scoperta2 (string carta))
                      (setq scoperta1 "")
                      (setq ultimo 2)
                      (setq player 1))
                    ; carta uguale ad una carta visibile
                    ((find carta visibili)
                      (println "prende carta dal tavolo")
                      ; cattura della carta visibile
                      (pop visibili (ref carta visibili))
                      (setq num-carte2 (+ num-carte2 2))
                      (setq scoperta2 (string carta))
                      (setq ultimo 2)
                      (setq player 1))
                    ; carta diversa da tutte le carte visibili
                    (true
                      (println "aggiunge carta sul tavolo")
                      (push carta visibili -1)
                      (setq player 1))
              ))
      )
    )
    (println "num-carte 1 = " num-carte1)
    (println "num-carte 2 = " num-carte2)
    (println "ultimo: " ultimo)
    (println "visibili: " (length visibili))
  )
  ; aggiunge le carte visibili al giocatore che ha preso per ultimo
  (cond ((= ultimo 1)
          (setq num-carte1 (add num-carte1 (length visibili))))
        ((= ultimo 2)
          (setq num-carte2 (add num-carte2 (length visibili))))
  )
  ; fine della partita
  (println "\ncarte player 1 = " num-carte1)
  (println "carte player 2 = " num-carte2)
)

Vediamo una partita:

(rubamazzo-log 1)

;-> [ 10 6 9 ]  () 0
;->
;->  8  6  1  3
;->
;-> [ 10 10 2 ]  () 0
;-> ---------------------
;-> mazzo: (7 2 5 7 9 3 1 7 10 3 2 5 9 4 7 3 1 4 6 9 5 4 1 8 4 6 8 5 8 2)
;->
;-> player 1: 10
;-> aggiunge carta sul tavolo
;-> player 2: 6
;-> prende carta dal tavolo
;-> player 1: 2 6
;-> aggiunge carta sul tavolo
;-> player 2: 9
;-> aggiunge carta sul tavolo
;-> player 1: 10 6
;-> prende carta dal tavolo
;-> player 2: 10
;-> cattura mazzetto
;-> num-carte 1 = 0
;-> num-carte 2 = 5
;-> ultimo: 2
;-> visibili: 5
;->
;-> [ 7 9 3 ]  (10) 5
;->
;->  8  1  3  2  9
;->
;-> [ 7 2 5 ]  () 0
;-> ---------------------
;-> mazzo: (1 7 10 3 2 5 9 4 7 3 1 4 6 9 5 4 1 8 4 6 8 5 8 2)
;->
;-> player 1: 5 10
;-> aggiunge carta sul tavolo
;-> player 2: 9
;-> prende carta dal tavolo
;-> player 1: 2 9
;-> prende carta dal tavolo
;-> player 2: 3
;-> prende carta dal tavolo
;-> player 1: 7 3
;-> aggiunge carta sul tavolo
;-> player 2: 7
;-> prende carta dal tavolo
;-> num-carte 1 = 2
;-> num-carte 2 = 11
;-> ultimo: 2
;-> visibili: 3
;->
;-> [ 3 2 5 ]  (7) 11
;->
;->  8  1  5
;->
;-> [ 1 7 10 ]  (2) 2
;-> ---------------------
;-> mazzo: (9 4 7 3 1 4 6 9 5 4 1 8 4 6 8 5 8 2)
;->
;-> player 1: 7 7
;-> cattura mazzetto
;-> player 2: 3
;-> aggiunge carta sul tavolo
;-> player 1: 10
;-> aggiunge carta sul tavolo
;-> player 2: 2
;-> aggiunge carta sul tavolo
;-> player 1: 1
;-> prende carta dal tavolo
;-> player 2: 5
;-> prende carta dal tavolo
;-> num-carte 1 = 16
;-> num-carte 2 = 2
;-> ultimo: 2
;-> visibili: 4
;->
;-> [ 3 1 4 ]  (5) 2
;->
;->  8  3  10  2
;->
;-> [ 9 4 7 ]  (1) 16
;-> ---------------------
;-> mazzo: (6 9 5 4 1 8 4 6 8 5 8 2)
;->
;-> player 1: 4 5
;-> aggiunge carta sul tavolo
;-> player 2: 3
;-> prende carta dal tavolo
;-> player 1: 9 3
;-> aggiunge carta sul tavolo
;-> player 2: 4
;-> prende carta dal tavolo
;-> player 1: 7 4
;-> aggiunge carta sul tavolo
;-> player 2: 1
;-> cattura mazzetto
;-> num-carte 1 = 0
;-> num-carte 2 = 23
;-> ultimo: 2
;-> visibili: 5
;->
;-> [ 4 1 8 ]  (1) 23
;->
;->  8  10  2  9  7
;->
;-> [ 6 9 5 ]  () 0
;-> ---------------------
;-> mazzo: (4 6 8 5 8 2)
;->
;-> player 1: 9 1
;-> prende carta dal tavolo
;-> player 2: 8
;-> prende carta dal tavolo
;-> player 1: 5 8
;-> aggiunge carta sul tavolo
;-> player 2: 4
;-> aggiunge carta sul tavolo
;-> player 1: 6 8
;-> aggiunge carta sul tavolo
;-> player 2: 1
;-> aggiunge carta sul tavolo
;-> num-carte 1 = 2
;-> num-carte 2 = 25
;-> ultimo: 2
;-> visibili: 7
;->
;-> [ 5 8 2 ]  (8) 25
;->
;->  10  2  7  5  4  6  1
;->
;-> [ 4 6 8 ]  (9) 2
;-> ---------------------
;-> mazzo: ()
;->
;-> player 1: 4 8
;-> prende carta dal tavolo
;-> player 2: 2
;-> prende carta dal tavolo
;-> player 1: 6 2
;-> prende carta dal tavolo
;-> player 2: 8
;-> aggiunge carta sul tavolo
;-> player 1: 8 2
;-> prende carta dal tavolo
;-> player 2: 5
;-> prende carta dal tavolo
;-> num-carte 1 = 8
;-> num-carte 2 = 29
;-> ultimo: 2
;-> visibili: 3
;->
;-> carte player 1 = 8
;-> carte player 2 = 32

La seguente funzione simula una partita di rubamazzo e restituisce un numero:
  numero = 0 --> partita pari (20 carte per ogni giocatore)
  numero = 1 --> vince il giocatore 1
  numero = 2 --> vince il giocatore 2

(define (rubamazzo tipo)
  (setq carte (flat (dup (sequence 1 10) 4)))
  (setq mazzo (randomize carte))
  (setq scoperta1 "") (setq scoperta2 "")
  (setq visibili (list (pop mazzo 0) (pop mazzo 0) (pop mazzo 0) (pop mazzo 0)))
  (setq num-carte1 0) (setq num-carte2 0)
  (setq player 1)
  (while mazzo
    (setq mano1 (list (pop mazzo 0) (pop mazzo 0) (pop mazzo 0)))
    (setq mano2 (list (pop mazzo 0) (pop mazzo 0) (pop mazzo 0)))
    ;(print-position)
    (while (or mano1 mano2)
      (cond ((= player 1)
              (if (= tipo 1)
                (setq carta (random-play mano1))
                (setq carta (grab-play mano1 1))
              )
              (pop mano1 (find carta mano1))
              (cond ((= carta (int scoperta2))
                      (setq num-carte1 (+ num-carte1 num-carte2 1))
                      (setq num-carte2 0)
                      (setq scoperta1 (string carta))
                      (setq scoperta2 "")
                      (setq ultimo 1)
                      (setq player 2))
                    ((find carta visibili)
                      (pop visibili (ref carta visibili))
                      (setq num-carte1 (+ num-carte1 2))
                      (setq scoperta1 (string carta))
                      (setq ultimo 1)
                      (setq player 2))
                    (true
                      (push carta visibili -1)
                      (setq player 2))
              ))
            ((= player 2)
              (if (= tipo 1)
                  (setq carta (random-play mano2))
                  (setq carta (grab-play mano2 2))
              )
              (pop mano2 (find carta mano2))
              (cond ((= carta (int scoperta1))
                      (setq num-carte2 (+ num-carte2 num-carte1 1))
                      (setq num-carte1 0)
                      (setq scoperta2 (string carta))
                      (setq scoperta1 "")
                      (setq ultimo 2)
                      (setq player 1))
                    ((find carta visibili)
                      (pop visibili (ref carta visibili))
                      (setq num-carte2 (+ num-carte2 2))
                      (setq scoperta2 (string carta))
                      (setq ultimo 2)
                      (setq player 1))
                    (true
                      (push carta visibili -1)
                      (setq player 1))
              ))
      )
    )
  )
  (cond ((= ultimo 1)
          (setq num-carte1 (add num-carte1 (length visibili))))
        ((= ultimo 2)
          (setq num-carte2 (add num-carte2 (length visibili))))
  )
  (cond ((= num-carte1 num-carte2) 0)
        ((> num-carte1 num-carte2) 1)
        ((< num-carte1 num-carte2) 2)
  )
)

Scriviamo una funzione per simulare N partite a rubamazzo:

(define (test iter tipo)
  (local (p p1 p2 res)
    (set 'p 0 'p1 0 'p2 0)
    (for (i 1 iter)
      (setq res (rubamazzo tipo))
      (cond ((= res 0) (++ p))
            ((= res 1) (++ p1))
            ((= res 2) (++ p2))
      )
    )
    (list p p1 p2 (div p1 p2))))

Facciamo alcune prove:

(seed (time-of-day))

(test 1e4 1)
;-> (414 4590 4996 0.9187349879903923)
(test 1e4 2)
;-> (403 4694 4903 0.9573730369161738)

(test 1e5 1)
;-> (4279 45947 49774 0.9231124683569735)
(test 1e5 2)
;-> (4319 46093 49588 0.9295192385254497)

(test 1e6 1)
;-> (43137 461137 495726 0.9302255681566026)
(test 1e6 2)
;-> (42768 461268 495964 0.9300433095950512)

Sembra che il giocatore 2 sia leggermente avvantaggiato (se il programma non è errato...).


------------------
Numeri dei reparti
------------------

C'è una città altamente organizzata che ha deciso di assegnare un numero a ciascuno dei suoi reparti:

   Polizia
   Sanità
   Vigili del fuoco

Ogni reparto può avere un numero compreso tra 1 e 7 (compreso).

I tre numeri di reparto devono essere univoci (diversi l'uno dall'altro) e devono sommarsi fino a 12.

Al capo della polizia non piacciono i numeri dispari e vuole avere un numero pari per il suo dipartimento.

Prima versione:

(define (distretti)
  (local (p s v valid out)
    (setq out '(("P" "S" "V")))
    (for (p 2 7)
      (for (s 1 7)
        (for (v 1 7)
          (setq valid true)
          (cond ((odd? p)
                  (setq valid nil))
                ((or (= p s) (= s v) (= v p))
                  (setq valid nil))
                ((!= (+ p s v) 12)
                  (setq valid nil))
          )
          (if valid (push (list p s v) out -1))
        )
      )
    )
    out))

(distretti)
;-> (("P" "S" "V") (2 3 7) (2 4 6) (2 6 4) (2 7 3) (4 1 7) (4 2 6)
;->  (4 3 5) (4 5 3) (4 6 2) (4 7 1) (6 1 5) (6 2 4) (6 4 2) (6 5 1))

Seconda versione:

(define (label)
  (local (p s v break out)
    (setq out '(("P" "S" "V")))
    (for (p 2 7 2)
      (setq break nil)
      (for (s 1 7 1 break)
        (setq v (- 12 p s))
        (cond ((>= s v) (setq break true))
              ((> v 7) nil)
              ((or (= s p) (= v p)) nil)
              (true
                (push (list p s v) out -1)
                (push (list p v s) out -1))
        )))
    out))

(label)
;-> (("P" "S" "V") (2 3 7) (2 7 3) (2 4 6) (2 6 4) (4 1 7) (4 7 1)
;->  (4 2 6) (4 6 2) (4 3 5) (4 5 3) (6 1 5) (6 5 1) (6 2 4) (6 4 2))

Verifichiamo che i risultati delle due funzioni siano uguali:

(= (sort (label)) (sort (distretti)))
;-> true

Vediamo la velocità delle due funzioni:

(time (distretti) 1e4)
;-> 441.846
(time (label) 1e4)
;-> 42.912


--------------------
Generatore circolare
--------------------

Versione automodificante:

(setf rotating-tasklet^ (fn (loc body)
 (rotate body)
  (letex (loc loc body body)
   (expand (setf loc (fn (arg)
    (pop loc -1)
    (push (first (rotate 'body -1)) loc -1)
    'first-of-body-goes-here))))))

Versione leggermente più concisa con "eval":

(setf rotating-tasklet^ (fn (loc body)
 (rotate body)
  (letex (loc loc body body)
   (expand (setf loc (fn (arg)
   (eval (first (rotate 'body -1)))))))))

Uso:

(rotating-tasklet^ 'rotX
 '((+ 10 arg)
   (+ 11 arg)
   (+ 12 arg)))

(rotating-tasklet^ 'rotX
  '((println "first")
    (println "second")
    (println "third")))

(rotX)
;-> "first"

(println (rotX 1000))
;-> second
;-> second

(rotX)
;-> "third"

(println (rotX 2500))
;-> first
;-> first

(rotX)
;-> second

(println (rotX 333))
;-> third
;-> third

Versione leggermente più breve senza "eval" che utilizza "setf" invece di "pop/push":

(setf rotating-tasklet^ (fn (loc body)
 (rotate body)
  (letex (loc loc body body)
   (expand (setf loc (fn (arg)
    (setf (last loc) (first (rotate 'body -1)))
    'first-of-body-goes-here))))))


-----------------------------
Numero di linea di uno script
-----------------------------

newLISP non mostra il numero di linea degli script in esecuzione.
Un modo per ottenere questa informazione è quello di utilizzare la funzione "reader-event":

(setq $exprno 0)
(reader-event (fn (x) (inc $exprno) x))

Per esempio:

(define (divide x y)
    (if (= y 0)
      (println "line " $exprno ": first argument cannot be 0")
      (div x y)))

(divide 10 0)
;-> line 3: first argument cannot be 0

$exprno
;-> 4

Non è proprio il massimo, ma meglio di niente.


-----------------------------
Interpolazione di una stringa
-----------------------------

Problema: come sostituire i segnaposto in una stringa con i valori dei simboli?
Si tratta dei "segnaposto" della funzione "format", ma invece di %s possiamo usare i nomi dei segnaposti.
L'effetto dovrebbe essere come in PHP dove possiamo scrivere qualcosa del genere:

$one = 1;
$two = 2;
$str = "here $one and there $two";

In questo modo invece di scrivere:

(println (format "here %d and there %d" one two))

Possiamo usare:

(myprintln "here :one: and there :two:")

Primo metodo
------------
(set 'name "John" 'age 37 'city "NY")

;; P replaces symbol name in string with its value, symbol name is enclosed
;; between colons (or choose your own), symbol must be defined

(define (P str (sep ":"))
    (set 'fields '())
    (find-all (format {%s([a-z0-9-]+)%s} sep sep) str (push $1 fields -1))
    (dolist (f fields)
        (if (set 'val (eval (sym f MAIN nil)))
            (replace (string sep f sep) str (string val))))
    (println str))

;; default call
(P ":name: lives in :city: and is :age: years old.")
;-> John lives in NY and is 37 years old

;; custom separator
(P "!name! lives in !city! and is !age! years old." "!")
;-> John lives in NY and is 37 years old.

;; custom separator, one symbol undefined
(P "~name~ lives in ~city~ and is ~blah~ years old." "~")
;-> John lives in NY and is ~blah~ years old.

Secondo metodo
--------------
(define (fill-template TEMPLATE VALUES)
  (replace ":([a-z]+):"
           TEMPLATE
           (if (lookup (sym $1) VALUES)
               (string $it)
               "<<value does not exist>>")
           0))

Questa funzione riempie il modello TEMPLATE con i valori di VALUES.

TEMPLATE è una stringa contenente "slot" (da compilare) denotati da nomi di simboli circondati dai due punti ':', ad esempio ":name: is at :place:."

VALUES è un elenco che associa quei simboli (senza i due punti) ai valori corrispondenti, ad esempio '((nome "Tom") (luogo "casa")).

Vediamo un esempio:

(fill-template ":name: is at :place:." '((name "Tom") (place "home")))
;-> "Tom is at home."

Altro esempio:

(define *template* ":name: lives in :city: and is :age: years old.")

Lista di persone (database):

(define *people*
  '(((name "John")
     (age  37)
     (city "NY"))
    ((name "Giorgos")
     (age  25)
     (city "Athens"))
    ((name "Elena")
     (age  43)
     (city "Amsterdam"))))

E i loro collegamenti:

(map (curry fill-template *template*) *people*)
;-> ("John lives in NY and is 37 years old."
;->  "Giorgos lives in Athens and is 25 years old."
;->  "Elena lives in Amsterdam and is 43 years old.")

(dolist (p *people*) (println (fill-template *template* p)))
;-> John lives in NY and is 37 years old.
;-> Giorgos lives in Athens and is 25 years old.
;-> Elena lives in Amsterdam and is 43 years old.

Terzo metodo
------------
(define *people*
      '((("name" "John")
         ("age"  37)
         ("city" "NY"))
        (("name" "Giorgos")
         ("age"  25)
         ("city" "Athens"))
        (("name" "Elena")
         ("age"  43)
         ("city" "Amsterdam"))))

(define *template* ":name: lives in :city: and is :age: years old.")
;-> ":name: lives in :city: and is :age: years old."

(setq parsed-template (parse *template* ":"))
;-> ("" "name" " lives in " "city" " and is " "age" " years old.")

; definiamo un contesto per contenere i dati di una persona

(define data:data)
;-> nil

Stampa dei risultati:

(dolist (p *people*)
   (data p)
   (dolist (str parsed-template)
      (print (or (data str) str)))
   (println))
;-> John lives in NY and is 37 years old.
;-> Giorgos lives in Athens and is 25 years old.
;-> Elena lives in Amsterdam and is 43 years old.

Quarto metodo (by Lutz)
-------------

(define-macro (repvar str)
    (dolist (_v (args))
        (replace (append "#" (term _v)) (eval str) (eval _v)))) 

(set 'var "foo")

(repvar "Goodnight #var" var)
;-> "Goodnight foo"


-------------
Testing macro
-------------

(define (make-node value action name) (list value action name))
(define (node? n) (list? n))
(define (node-value n) (nth 0 n))
(define (node-action n) (nth 1 n))
(define (node-name n) (nth 2 n))
(define (node-eval n) (if (nil? (node-action n)) (node-value n) (throw-error "unevaluable node")))
(define (merge nodelist)
  (letn
    (priority '(+ - * / ^)
     lowerpri? (lambda (n1 n2) (< (find (node-name n1) priority) (find (node-name n2) priority)))
     _R (lambda (n1 n2) (make-node ((node-action n1) (node-value n1) (node-value n2)) (node-action n2) (node-name n2)))
     _M (lambda (_l _c)
          (cond
            ((and (empty? _c) (empty? (rest _l))) (first _l))  ; length 1
            ((and (empty? _c) (= 2 (length _l))) (_R (nth 0 _l) (nth 1 _l)))  ; length 2
            ((lowerpri? (nth 0 _l) (nth 1 _l)) (_M (cons (nth 1 _l) (rest (rest _l))) (append _c (list (nth 0 _l)))))
            (true (_M (append _c (cons (_R (nth 0 _l) (nth 1 _l)) (rest (rest _l)))) '())) )))
    (_M nodelist '())))
(define (evaluate nodelist) (let (n (merge nodelist)) (node-eval n)))

;---- testing macro
(define (test test-name test-cond) (if test-cond (println test-name " OK") (println test-name " Fail!!!!")))

;---- macros for easy typing
(define-macro (N v a t) (make-node (eval v) (or (eval a) nil) (or t a nil)))

;---- testing examples
(define l1 (list (N 3 +) (N 8)))
(define l2 (list (N 3 +) (N 8 *) (N 4) ))
(define l3 (list (N 2 +) (N 3 *) (N 4 pow ^) (N 2 +) (N 1) ))
(define l4 (list (N 4 +) (N 2 *) (N 6 -) (N 4 pow ^) (N 3 +) (N 5) ))

;---- tests
(test "4" (= 4 (evaluate (list (N 4)))))
(test "3+8" (= 11 (evaluate l1)))
(test "3+8*4" (= 35 (evaluate l2)))
(test "2+3*4^2+1" (= 51 (evaluate l3)))
(test "4+2x6-4^3+5" (= -43 (evaluate l4)))
(test "not evaluating 4+" (or (catch (evaluate (list (N 4 +))) 'res)
                              (= "unevaluable node" ((parse ((parse res "\r") 0) ": ") -1))))

(test "4" (= 4 (evaluate (list (N 4)))))
;-> 4 OK

(test "3+8" (= 11 (evaluate l1)))
;-> 3+8 OK

(test "3+8*4" (= 35 (evaluate l2)))
;-> 3+8*4 OK

(test "2+3*4^2+1" (= 51 (evaluate l3)))
;-> 2+3*4^2+1 OK

(test "4+2x6-4^3+5" (= -43 (evaluate l4)))
;-> 4+2x6-4^3+5 OK

(test "not evaluating 4+" (or (catch (evaluate (list (N 4 +))) 'res)
                              (= "unevaluable node" ((parse ((parse res "\r") 0) ": ") -1))))
;-> not evaluating 4+ OK


-------------------------
Trasformazione Box-Muller
-------------------------

La trasformazione di Box-Muller (George Edward Pelham Box e Mervin Edgar Muller, 1958) è un metodo per generare coppie di numeri casuali indipendenti e distribuiti gaussianamente con media nulla e varianza uno partendo da due serie di numeri casuali uniformemente distribuiti e indipendenti.

Nota: vedi immagine "box-muller.png" nella cartella "data".

Algoritmo Box-Muller
1. Generare U1 uniforme(0,1) e U2 uniforme(0,1) dove U1 indipendente da U2
2. Calcolare R = sqrt(−2*log(U1)) e Theta = 2*π*U2
3. Calcolare X = R*cos(θ) e Y = R*sin(θ)

Nota: log -> logaritmo naturale

(define (box-muller points)
  (local (pi ua1 ua2 r theta x y)
    (setq pi 3.1415926535897931)
    ; Inizializza il generatore di numeri casuali
    (seed (time-of-day))
    ; Genera U1 con points numeri che sono uniformi in (0, 1)
    (setq u1 (random 0 1 points))
    ; Inizializza il generatore di numeri casuali
    (seed (time-of-day))
    ; Genera U2 con points numeri che sono uniformi in (0, 1)
    (setq u2 (random 0 1 points))
    ; Trasforma U1 in R (log -> logaritmo naturale)
    (setq r (map (fn(x) (sqrt (mul -2 (log x)))) u1))
    ; Trasforma U2 in Theta
    (setq theta (map (fn(x) (mul 2 pi x)) u2))
    ; Calcola x e y da R e theta
    (setq x (map (fn(x y) (mul x (cos y))) r theta))
    (setq y (map (fn(x y) (mul x (sin y))) r theta))
    (list x y)))

Vediamo un esempio:

(setq ga (box-muller 1000))
(setq gx (ga 0))
(setq gy (ga 1))
(setq xy (map list gx gy))
(save "u1.txt" 'u1)
(save "u2.txt" 'u2)
(save "xy.txt" 'xy)

I risultati sono riportati nel file "box-muller.xlsx" nella cartella "data".

Nota: per generare numeri con distribuzione gaussiana (normale) è possibile utilizzare la funzione integrata "normal".

*******************
>>>funzione NORMAL
*******************
sintassi: (normal float-mean float-stdev int-n)
sintassi: (normal float-mean float-stdev)

Nella prima forma, "normal" restituisce un elenco di lunghezza "int-n" di numeri in virgola mobile casuali e distribuiti in modo continuo con una media di "float-mean" e una deviazione standard di "float-stdev". Il generatore casuale utilizzato internamente può essere seminato utilizzando la funzione "seed".

(normal 10 3 10)
;-> (7 6.563476562 11.93945312 6.153320312 9.98828125
;->  7.984375 10.17871094 6.58984375 9.42578125 12.11230469)

Nella seconda forma, "normal" restituisce un singolo numero a virgola mobile con distribuzione normale:

(normal 1 0.2)
;-> 0.646875

Quando non vengono forniti parametri, "normal" assume una media di 0.0 e una deviazione standard di 1.0.

Vedi anche le funzioni "random" e "rand" per numeri distribuiti uniformemente, "amb" per randomizzare la valutazione in un elenco di espressioni e "seed" per impostare un punto di partenza diverso per la generazione di numeri pseudo casuali.


-------------------------------------------------------
Cerchio minimo di inclusione (Minimum Enclosing Circle)
-------------------------------------------------------

Data una lista contenente N punti con coordinate 2D. Trovare il centro e il raggio del cerchio minimo di inclusione (MEC). Un cerchio minimo di inclusione è un cerchio in cui tutti i punti giacciono all'interno del cerchio o sulla sua circonferenza.

Esempi:
Input: punti = ((0, 0) (0, 1) (1, 0))
Output: centro = (0.5, 0.5), raggio = 0.7071

Input: punti ((5, -2) (-3, -2) (-2, 5) (1, 6) (0, 2))
Output: centro = (1.0, 1.0), reggio = 5

Per risolvere il problema dobbiamo fare alcune osservazioni:

1) Il MEC interseca almeno un punto. Questo perché se il MEC non si interseca in nessun punto, il cerchio potrebbe essere ulteriormente ridotto fino a quando non si interseca uno dei punti.

2) Dato un cerchio che racchiude tutti i punti e si interseca in un unico punto, il cerchio può essere ulteriormente rimpicciolito spostando il centro verso quel punto mantenendo il punto sul bordo del cerchio finché il cerchio non si interseca uno o più punti aggiuntivi.

3) Se il cerchio si interseca in due punti (A e B) e la distanza AB è uguale al diametro del cerchio, il cerchio non può più essere rimpicciolito. Altrimenti, il centro del cerchio può essere spostato verso il punto medio di AB finché il cerchio non interseca un terzo punto (in corrispondenza del quale il cerchio non può più essere ridotto).

Dalle osservazioni di cui sopra, si può concludere che il MEC:

a) Interseca 2 punti A e B, dove AB = diametro del cerchio. In questo caso, il centro del cerchio sarebbe il punto medio di A e B e il raggio sarebbe la metà della distanza AB.
b) Interseca 3 o più punti.

Pertanto, la soluzione a questo problema è banale per N <= 3. Per gli altri casi utilizziamo tutte le coppie e le triple dei punti per ottenere il cerchio definito da quei punti. Dopo aver ottenuto il cerchio, verifichiamo se gli altri punti sono racchiusi dal cerchio e restituiamo il cerchio valido più piccolo trovato.

I punti e i cerchi sono definiti dalle seguenti strutture:
  - point -> (x y)
  - circle -> (point radius) -> ((x y) r)

Funzione che calcola la distanza euclidea tra due punti:

(define (dist a b)
  (sqrt (add (pow (sub (a 0) (b 0)) 2) (pow (sub (a 1) (b 1)) 2))))

(dist '(0 0) '(1 1))
;-> 1.414213562373095
(dist '(2 2) '(2 4))
;-> 2

Funzione che verifica se un punto è interno o giace sul perimetro di un cerchio:

(define (is-inside c p)
  (<= (dist (c 0) p) (c 1)))

(is-inside '((0 0) 5) '(0 4))
;-> true
(is-inside '((0 0) 5) '(0 6))
;-> nil

Funzione che calcola il centro di un cerchio da due punti dati:

(define (get-circle-center bx by cx cy)
  (local (b c d)
    (setq b (add (mul bx bx) (mul by by)))
    (setq c (add (mul cx cx) (mul cy cy)))
    (setq d (sub (mul bx cy) (mul by cx)))
    (list (div (sub (mul cy b) (mul by c)) (mul 2 d))
          (div (sub (mul bx c) (mul cx b)) (mul 2 d)))))

(get-circle-center 1 1 2 3)
;-> (-3.5 4.5)

Funzione che calcola il centro e il raggio del cerchio che passa per tre punti dati:

(define (circle-from a b c)
  (local (i)
    (setq i (get-circle-center (sub (b 0) (a 0)) (sub (b 1) (a 1))
                               (sub (c 0) (a 0)) (sub (c 1) (a 1))))
    (setf (i 0) (add (i 0) (a 0)))
    (setf (i 1) (add (i 1) (a 1)))
    (list i (dist i a))))

(circle-from '(1 0) '(0 1) '(0 -1))
;-> ((0 0) 1)

(circle-from '(2 0) '(4 2) '(0 2))
;-> ((2 2) 2)

Funzione  che verifica se un cerchio include tutti i punti:

(define (is-valid-circle c p)
  (let (outside nil)
    (dolist (el p outside)
      (if (not (is-inside c el)) (setq outside true))
    )
    (not outside)))

(is-valid-circle '((2 2) 2) '((2 2) (1 1) (3 2) (4 2)))
;-> true

(is-valid-circle '((2 2) 2) '((2 2) (1 1) (3 2) (4 2.1)))
;-> nil

Funzione finale che calcola il MEC di un insieme di punti:

(define (find-mec pts)
  (local (len mec tmp j k)
  (setq len (length pts))
  ; MEC iniziale con centro in (0,0) e raggio infinito
  (setq mec '((0 0) 1e18))
  ; per tutte le coppie di punti
  (for (i 0 (- len 1))
    (setq j (+ i 1))
    (while (< j len)
      ; trova il mec che interseca pts(i) e pts(j)
      ;(println " i j " i { } j) (read-line)
      (setq tmp (circle-from2 (pts i) (pts j)))
      ;(println tmp) (read-line)
      ; aggiorna il MEC se tmp include tutti i punti
      ; e ha un raggio minore
      (if (and (< (tmp 1) (mec 1)) (is-valid-circle tmp pts))
          (setq mec tmp)
      )
      (++ j)
    )
  )
  ; per tutte le triple di punti
  (for (i 0 (- len 1))
    (setq j (+ i 1))
    (while (< j len)
      (setq k (+ j 1))
      (while (< k len)
        ; trova il mec che interseca pts(i), pts(j) e pts(k)
        ;(println " i j " i { } j) (read-line)
        (setq tmp (circle-from (pts i) (pts j) (pts k)))
        ;(println tmp) (read-line)
        ; aggiorna il MEC se tmp include tutti i punti
        ; e ha un raggio minore
        (if (and (< (tmp 1) (mec 1)) (is-valid-circle tmp pts))
            (setq mec tmp)
        )
        (++ k)
      )
      (++ j)
    )
  )
  mec))

Facciamo alcune prove:

(setq pts1 '((0 0) (0 1) (1 0)))
(find-mec pts1)
;-> ((0.5 0.5) 0.7071067811865476)

(setq pts2 '((5 -2) (-3 -2) (-2 5) (1 6) (0 2)))
(find-mec pts2)
;-> ((1 1) 5)

Complessità temporale: O(N^4)

Un'altro metodo di soluzione del problema utilizza l'algoritmo convex-hull.
Calcoliamo il convex-hull dei punti dati e poi utilizziamo la funzione "find-mec" per trovare il MEC con i punti che formano il convex-hull. Se il numero di vertici del convex-hull è considerevolmente inferiore a N, la complessità sarebbe O(H^4 + N*Log(N)) dove H rappresenta il numero di vertici del convex-hull e il fattore NLog(N) è la complessità temporale dell'algoritmo di convex-hull (Graham Scan). Infine, se il numero di vertici, H, del convex-hull è molto piccolo, allora può essere considerato come un fattore costante e quindi la complessità temporale diventa O(NLog(N)).


---------------------
Prodotto di Kronecker
---------------------

Il prodotto di Kronecker, indicato con " ** ", è un'operazione tra due matrici di dimensioni arbitrarie, sempre applicabile, al contrario della normale moltiplicazione di matrici.

Se A è una matrice (m x n) e B è una matrice (p x q), allora il loro prodotto di Kronecker A**B è una matrice (m*p x n*q) definita a blocchi nel modo seguente:

           | a11*B ... a1n*B |
  A ** B = |  ...  ... ...   |
           | am1*B ... amn*B |

Per esempio se A è una matrice 2x2:

                             | a11*b11 a11*b12  a12*b11 a12*b12 |
           | a11*B a12*B |   | a11*b21 a11*b22  a12*b21 a12*b22 |
  A ** B = |             | = |                                  |
           | a21*B a22*B |   | a21*b11 a21*b12  a22*b11 a22*b12 |
                             | a21*b21 a21*b22  a22*b21 a22*b22 |

Scriviamo una funzione che calcola il prodotto di kronecker tra due matrici:

  Matrice A   Matrice B
   (m x n)     (p x q)
   (r1xc1)     (r2xc2)

(define (kron m1 m2)
  (local (kro r1 c1 r2 c2)
    (setq r1 (length m1))
    (setq c1 (length (m1 0)))
    (setq r2 (length m2))
    (setq c2 (length (m2 0)))
    (setq kro (array (mul r1 r2) (mul c1 c2) '(0)))
    (for (i 0 (- r1 1))
      (for (j 0 (- c1 1))
        (for (k 0 (- r2 1))
          (for (l 0 (- c2 1))
            ; ogni elemento della matrice A (m1) viene
            ; moltiplicato per tutta la matrice B (m2)
            ; e memorizzato nella matrice C (kro)
            (setf (kro (+ (* i r2) k) (+ (* j c2) l)) (mul (m1 i j) (m2 k l)))
          )
        )
      )
    )
    kro))

Facciamo alcune prove:

(setq mat1 '((1 2)
             (3 4)))

(setq mat2 '((0 5)
             (6 7)))

(kron mat1 mat2)
;-> (( 0  5  0 10)
;->  ( 6  7 12 14)
;->  ( 0 15  0 20)
;->  (18 21 24 28))

(setq mat1 '((1 2)
             (3 4)
             (1 0)))
(setq mat2 '((0 5 2)
             (6 7 3)))

(kron mat1 mat2)
;-> (( 0  5  2  0 10  4)
;->  ( 6  7  3 12 14  6)
;->  ( 0 15  6  0 20  8)
;->  (18 21  9 24 28 12)
;->  ( 0  5  2  0  0  0)
;->  ( 6  7  3  0  0  0))

(setq mat1 '((0 1 0)
             (1 1 1)
             (0 1 0)))
(setq mat2 '((1 1 1 1)
             (1 0 0 1)
             (1 1 1 1)))

(kron mat1 mat2)
;-> ((0 0 0 0 1 1 1 1 0 0 0 0)
;->  (0 0 0 0 1 0 0 1 0 0 0 0)
;->  (0 0 0 0 1 1 1 1 0 0 0 0)
;->  (1 1 1 1 1 1 1 1 1 1 1 1)
;->  (1 0 0 1 1 0 0 1 1 0 0 1)
;->  (1 1 1 1 1 1 1 1 1 1 1 1)
;->  (0 0 0 0 1 1 1 1 0 0 0 0)
;->  (0 0 0 0 1 0 0 1 0 0 0 0)
;->  (0 0 0 0 1 1 1 1 0 0 0 0))

Complessità temporale: O(r1*c1*r2*c2)


-------------
Numeri di Lha
-------------

In matematica , i numeri di Lah , scoperti da Ivo Lah nel 1954, [1] [2] sono coefficienti che esprimono fattoriali crescenti in termini di fattoriali decrescenti . Sono anche i coefficienti delle derivate th di . [3]n{\displaystyle e^{1/x}}

I numeri Lah senza segno hanno un significato interessante in combinatoria : contano il numero di modi in cui un insieme di n elementi può essere partizionato in k sottoinsiemi ordinati linearmente non vuoti . [4] I numeri di Lah sono correlati ai numeri di Stirling . [5]

Numeri Lah senza segno (sequenza OEIS: A105278):

L(n,k) = binom[(n-1) (k-1)]*(n!/k!)

Numeri Lah con segno (sequenza OEIS: A108297):

L(n,k) = ((-1)^n)*binom[(n-1) (k-1)]*(n!/k!)

Scriviamo una funzione per calcolare i numeri di Lha senza segno:

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (lah-u1 n k)
  (cond ((= k 1) (fact-i n))
        ((= k n) 1)
        ((> k n) 0)
        ((or (< k 1) (< n 1)) 0)
        (true
          (/ (/ (* (fact-i n) (fact-i (- n 1)))
                (* (fact-i k) (fact-i (- k 1))))
             (fact-i (- n k))))))

(lah-u1 12 5)
;-> 1317254400L

(lah-u1 21 3)
;-> 1617879835437465600000L

Proviamo ad ottimizzare la funzione "lah-u1" utilizzando una nuova funzione per calcolare il binomiale:

(define (binom num k)
"Calculates the binomial coefficient (n k) = n!/(k!*(n - k)!)"
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(define (lah-u2 n k)
  (cond ((= k 1) (fact-i n))
        ((= k n) 1)
        ((> k n) 0)
        ((or (< k 1) (< n 1)) 0)
        (true
           (* (binom (- n 1) (- k 1))
              (/ (fact-i n) (fact-i k))))))

(lah-u2 12 5)
;-> 1317254400L

(lah-u2 21 3)
;-> 1617879835437465600000L

Vediamo la velocità delle due funzioni:

(time (lah-u1 21 3) 10000)
;-> 120.648
(time (lah-u2 21 3) 10000)
;-> 56.849

Proviamo ad ottimizzare la funzione "lah-u2" calcolando n!/k! in modo diverso:

(define (fact-div n k)
"Calculates n!/k! with n > k"
  (setq out 1L)
  ; solo (n - k) moltiplicazioni
  (dotimes (i (- n k))
    (setq out (* out n))
    (-- n)
  )
  out)

(define (lah-u3 n k)
  (cond ((= k 1) (fact-i n))
        ((= k n) 1)
        ((> k n) 0)
        ((or (< k 1) (< n 1)) 0)
        (true
           (* (binom (- n 1) (- k 1))
              (fact-div n k)))))

(lah-u3 12 5)
;-> 1317254400L

(lah-u3 21 3)
;-> 1617879835437465600000L

Vediamo la velocità di questa funzione:

(time (lah-u3 21 3) 10000)
;-> 47.077


-----------------
Settore circolare
-----------------

Un settore circolare è la porzione di un cerchio racchiusa tra due raggi e un arco, dove l'area più piccola è il "settore minore" e la più grande è il "settore maggiore". Chiamiamo "theta" l'angolo minore racchiuso tra i due raggi. Chiamiamo L la lunghezza della parte circolare del settore.

  Area-Settore = π*r^2 * (theta/360)

(define (sector-area r theta)
  (let (pi 3.1415926535897931)
    (div (mul pi r r theta) 360)))

(sector-area 10 45)
;-> 39.26990816987242

(sector-area 20 180)
;-> 628.3185307179587

(sector-area 1 360)
;-> 3.141592653589793

  Lunghezza-Settore = 2*π*r * (theta/360)

(define (sector-length r theta)
  (let (pi 3.1415926535897931)
    (div (mul 2 pi r theta) 360)))

(sector-length 10 45)
;-> 7.853981633974483

(sector-length 20 180)
;-> 62.83185307179586

(sector-length 20 0)
;-> 0


-----------------
Corda del cerchio
-----------------

In un cerchio, se viene disegnata una corda, quella corda divide l'intero cerchio in due parti chiamate segmenti del cerchio. L'area più piccola è conosciuta come il "segmento minore" e l'area più grande è chiamata il "segmento maggiore".
Dato il raggio del cerchio e l'angolo che forma il segmento minore, trovare l'area del "segmento minore".

Vedi immagine "corda.png" nella cartella "data".

Chiamiamo "theta" l'angolo del settore.

  angolo AOP = angolo BOP = theta/2

  Area-Triangolo AOB = 1/2 * base * altezza  = 1/2 * AB * OP

Dalla trigonometria risulta:

  cos(theta/2) = OP/AO  -->  OP = AO * cos(theta/2)  -->  OP = r * cos(theta/2)

  sin(theta/2) = AP/AO  -->  AP = AO * sin(theta/2)  -->  AP = r * Sin(theta/2)

  Base = AB = AP + PB = 2 * AP = 2 * r * sin(theta/2)

  Altezza = OP = r * cos(theta/2)

  Area-Triangolo = 1/2 * (2 * r * sin(theta/2)) * (r * cos(theta/2)) =
                 = 1/2 * r^2 * sin(theta)

  Area-Settore = π*r^2 * (theta/360)

  Area-Segmento = Area-Settore - Area-Triangolo =
                = π * r^2 * (theta/360) - 1/2 * r^2 * sin(theta)

Scriviamo la funzione:

(define (segment r theta)
  (local (pi area-segmento area-settore area-triangolo)
   (setq pi 3.1415926535897931)
   (setq area-settore (div (mul pi r r theta) 360))
   (setq area-triangolo (mul 0.5 r r (sin (div (mul theta pi) 180))))
   (setq area-segmento (sub area-settore area-triangolo))))

(segment 20 120)
;-> 245.6739397217513

(segment 10 45)
;-> 3.914569110545045


-------------------------------------------
Esperimento dell'imbuto (Funnel Experiment)
-------------------------------------------

Il Dr. Deming ha affermato: "Se qualcuno regola un processo stabile a causa di un risultato indesiderato, o per un risultato molto buono, l'output che ne conseguirà sarà peggiore che se avesse lasciato il processo da solo (indisturbato)". Questo è spesso chiamato manomissione del processo. È qualcosa che viene fatto spesso dal personale in prima linea e molto spesso dal management. Ciò aumenta la variazione e i fallimenti in un processo. Fare del proprio meglio non è più sufficiente: devi sapere cosa fare.

Un esempio di controllo eccessivo è l'esperimento a imbuto descritto dal Dr. Deming.
L'obiettivo dell'esperimento dell'imbuto è far cadere una biglia attraverso un imbuto e colpire un bersaglio.
Un punto su una superficie piana è designato come bersaglio.
Un imbuto è tenuto a una certa distanza dalla superficie.
Una biglia viene fatta cadere attraverso l'imbuto.
Il punto in cui la biglia cade sulla superficie viene segnato.
Questa operazione viene ripetuta per almeno 50 volte per ciascuna delle seguenti quattro regole:

Regola 1:
lasciare l'imbuto fisso sopra il bersaglio.

Regola 2:
Per ogni lancio, la biglia si fermerà a una distanza "z" dal bersaglio.
La regola 2 è spostare l'imbuto di una distanza -z dalla sua ultima posizione.

Regola 3:
Spostare l'imbuto di una distanza -z dal bersaglio per ogni biglia che finisce a una distanza z dal bersaglio. Nota che la regola 2 sposta l'imbuto in base all'ultima posizione dell'imbuto stesso.
La regola 3 sposta l'imbuto a una certa distanza dal bersaglio.

Regola 4:
La regola 4 è semplicemente quella di posizionare l'imbuto sul punto in cui si è caduta l'ultima biglia.

Applichiamo le regole ai seguenti dati sperimentali:

(setq dxs
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

(setq dys
  '(0.136 0.717 0.459 -0.225 1.392 0.385 0.121 -0.395 0.490 -0.682 -0.065
    0.242 -0.288 0.658 0.459 0.000 0.426 0.205 -0.765 -2.188 -0.742 -0.010
    0.089 0.208 0.585 0.633 -0.444 -0.351 -1.087 0.199 0.701 0.096 -0.025
    -0.868 1.051 0.157 0.216 0.162 0.249 -0.007 0.009 0.508 -0.790 0.723
    0.881 -0.508 0.393 -0.226 0.710 0.038 -0.217 0.831 0.480 0.407 0.447
    -0.295 1.126 0.380 0.549 -0.445 -0.046 0.428 -0.074 0.217 -0.822 0.491
    1.347 -0.141 1.230 -0.044 0.079 0.219 0.698 0.275 0.056 0.031 0.421 0.064
    0.721 0.104 -0.729 0.650 -1.103 0.154 -1.720 0.051 -0.385 0.477 1.537
    -0.901 0.939 -0.411 0.341 -0.411 0.106 0.224 -0.947 -1.424 -0.542 -1.032))

Formule per il calcolo della media:

  media = (∑x(i))/N

Funzione per il calcolo della media di una lista di numeri:

(define (media lst)
  (div (apply add lst) (length lst)))

(media dxs)
;-> 0.0003999999999999896
(media dys)
;-> 0.07023000000000002

Formule per il calcolo della deviazione standard:

  stdev = sqrt( (∑[|x(i) - media|^2])/N )

  stdev2 = sqrt( (∑[|x(i) - media|^2])/(N - 1) )

Funzioni per il calcolo della deviazione standard di una lista di numeri:

(define (stdev lst) ; diviso N
  (let (m (media lst))
    (sqrt (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
               (length lst)))))

(define (stdev2 lst) ; diviso (N - 1)
  (let (m (media lst))
    (sqrt (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
               (- (length lst) 1)))))

(stdev dxs)
;-> 0.7152712073053128
(stdev dys)
;-> 0.6462060794359645
(stdev2 dxs)
;-> 0.7188746115079505
(stdev2 dys)
;-> 0.6494615462835427

Scriviamo una funzione che calcola le liste con le varie posizioni di x e y in funzione della regola applicata:

(define (funnel regola)
  (setq base-x 0)
  (setq base-y 0)
  (setq xvec '())
  (setq yvec '())
  (dolist (x dxs)
    (push (add base-x x) xvec -1)
    (cond ((= regola 1) (setq base-x 0))
          ((= regola 2) (setq base-x (sub x)))
          ((= regola 3) (setq base-x (sub (sub x) base-x)))
          ((= regola 4) (setq base-x (add x base-x)))
    )
  )
  (dolist (y dys)
    (push (add base-y y) yvec -1)
    (cond ((= regola 1) (setq base-y 0))
          ((= regola 2) (setq base-y (sub y)))
          ((= regola 3) (setq base-y (sub (sub y) base-y)))
          ((= regola 4) (setq base-y (add y base-y)))
    )
  )
  (println "regola: " regola)
  (println "media x: " (media xvec))
  (println "stdev x: " (stdev xvec))
  (println "media y: " (media yvec))
  (println "stdev y: " (stdev yvec)))

Funzione per il plottaggio dei punti x,y:

(define (plot-xy lst-xy width height)
"Plot a list of points on terminal"
  (local (lst-x lst-y x-min x-max y-min y-max
          range-x range-y xx yy zero-x zero-y matrix)
    ; crea lista delle x
    (setq lst-x (map first lst-xy))
    ; crea lista delle y
    (setq lst-y (map last  lst-xy))
    ; calcola valori min,max x
    (setq x-min (apply min lst-x))
    (setq x-max (apply max lst-x))
    ; calcola valori min,max x
    (setq y-min (apply min lst-y))
    (setq y-max (apply max lst-y))
    ; calcolo intervallo valori x
    (setq range-x (sub x-max x-min))
    ; calcolo intervallo valori y
    (setq range-y (sub y-max y-min))
    ; calcolo valori normalizzati lista x
    ; (i valori vengono arrotondati e poi resi interi)
    (setq xx (normal-zero lst-x 0 width))
    (setq xx (map (fn(w) (int (round w))) xx))
    ; estrazione valore dello zero x normalizzato
    (setq zero-x (pop xx))
    ; calcolo valori normalizzati lista y
    (setq yy (normal-zero lst-y 0 height))
    (setq yy (map (fn(w) (int (round w))) yy))
    ; estrazione valore dello zero y normalizzato
    (setq zero-y (pop yy))
    ; Creazione matrice di caratteri di stampa
    ; Matrice = Sistema di coordinate (row col)
    ; x --> colonna della matrice
    ; y --> riga della matrice
    ; Valore cella vuota: " "
    (setq matrix (array (+ height 2) (+ width 2) '(" ")))
    ; Inserisce asse x sulla matrice
    ;(for (i 0 (- (length (matrix 0)) 1))
    ;  (setf (matrix zero-y i) "·")
    ;)
    ; asse x nella matrice
    (if (and (>= zero-y 0) (< zero-y (+ height 2)))
        (for (i 0 (- (length (matrix 0)) 1))
          (setf (matrix zero-y i) "·")
        )
    )
    ; Inserisce asse y sulla matrice (se visibile)
    ; asse y nella matrice
    (if (and (>= zero-x 0) (< zero-x (+ width 2)))
        (for (i 0 (- (length matrix) 1))
          (setf (matrix i zero-x) "·")
        )
    )
    ; Inserisce punti (x y) nella matrice (se visibile)
    ; (inserisce "■" nelle celle (y x) della matrice)
    (for (i 0 (- (length xx) 1))
      (setf (matrix (yy i) (xx i)) "■")
    )
    ; Inserisce origine degli assi (0 0) nella matrice (se visibile)
    ; (0,0) nella matrice
    (if (and (>= zero-x 0) (>= zero-y 0)
             (< zero-x (+ width 2)) (< zero-y (+ height 2)))
        (if (= (matrix zero-y zero-x) "■")
            (setf (matrix zero-y zero-x) "O")
            (setf (matrix zero-y zero-x) "∙")
        )
    )
    ; stampa valori reali min e max
    (println (format "x: %-12.3f %-12.3f" x-min x-max))
    (println (format "y: %-12.3f %-12.3f" y-min y-max))
    ; stampa matrice di caratteri
    ; (le righe della matrice vengono invertite)
    (dolist (el (reverse (array-list matrix)))
      (println " " (join el))
    )
    nil))
; auxiliary function
(define (normal-zero lst-num val-min val-max)
  (local (hi lo k out)
    (setq out '())
    (setq hi (apply max lst-num))
    (setq lo (apply min lst-num))
    (setq k (div (sub val-max val-min) (sub hi lo)))
    (dolist (val lst-num)
      (push (add val-min (mul (sub val lo) k)) out -1)
    )
    ; Zero (0) value in normalized list
    (push (add val-min (mul (sub 0 lo) k)) out)
    out))

Applichiamo la funzione "funnel" con ogni regola calcolando la media e la deviazione standard e plottando i punti risultanti (x,y).

Situazione iniziale:

(setq xy0 (map list dxs dys))
(plot-xy xy1 40 20)
;-> x: -2.436       2.080
;-> y: -2.188       1.537
;->                        ·
;->                        · ■
;->                      ■ ·      ■
;->                ■■      ·
;->                      ■ ·  ■
;->              ■     ■ ■■■■■
;->              ■  ■  ■   ·■    ■ ■
;->              ■ ■  ■■■■■■      ■  ■■    ■
;->                  ■ ■ ■ ■■■   ■        ■
;->  ·················■·■■■O■■··■··············
;->                    ■■ ■■          ■
;->  ■                ■  ■ · ■■■
;->              ■ ■       · ■           ■
;->   ■                  ■ ■       ■
;->                 ■      ·  ■■ ■
;->             ■          ■       ■
;->                        ·
;->                   ■    ·
;->                      ■ ·
;->                        ·
;->                        ·
;->                        ·                 ■

Regola 1:

(funnel 1)
;-> regola: 1
;-> media x: 0.0003999999999999896
;-> stdev x: 0.7152712073053128
;-> media y: 0.07023000000000002
;-> stdev y: 0.6462060794359645

(setq xy1 (map list xvec yvec))
(plot-xy xy1 40 20)
;-> x: -2.436       2.080
;-> y: -2.188       1.537
;->                        ·
;->                        · ■
;->                      ■ ·      ■
;->                ■■      ·
;->                      ■ ·  ■
;->              ■     ■ ■■■■■
;->              ■  ■  ■   ·■    ■ ■
;->              ■ ■  ■■■■■■      ■  ■■    ■
;->                  ■ ■ ■ ■■■   ■        ■
;->  ·················■·■■■O■■··■··············
;->                    ■■ ■■          ■
;->  ■                ■  ■ · ■■■
;->              ■ ■       · ■           ■
;->   ■                  ■ ■       ■
;->                 ■      ·  ■■ ■
;->             ■          ■       ■
;->                        ·
;->                   ■    ·
;->                      ■ ·
;->                        ·
;->                        ·
;->                        ·                 ■

La regola 1 è lasciare l'imbuto fisso sopra il bersaglio. Il modello risultante è mostrato nella figura sopra. Il bersaglio (obiettivo) è dove le linee continue si incrociano (0, 0).
Come si può vedere nella figura, la variazione è un cerchio approssimativo ed è stabile.
Sicuramente possiamo fare di meglio! Questo cerchio è troppo grande.
Perché non regoliamo semplicemente l'imbuto dopo ogni lancio in modo che il prossimo lancio sia più vicino al bersaglio?

Regola 2:

(funnel 2)
;-> regola: 2
;-> media x: 0.0008699999999999942
;-> stdev x: 1.037139967940682
;-> media y: -0.01032
;-> stdev y: 0.8999482749580666

(setq xy2 (map list xvec yvec))
(plot-xy xy2 40 20)
;-> x: -4.417       2.449
;-> y: -2.438       1.919
;->                            ·
;->                          ■ ·  ■
;->                           ■·
;->  ■                  ■   ■  ·
;->                       ■   ■·      ■
;->                          ■ ·■■
;->            ■        ■   ■■ ·    ■  ■■    ■
;->                         ■ ■·   ■
;->           ■            ■■■■·■  ■      ■
;->                        ■■ ■·■ ■■ ■
;->  ······················■··■∙■■■············
;->                            ■■■■
;->                     ■■   ■ ·■■ ■■■
;->                      ■ ■  ■■ ■    ■      ■
;->                         ■ ■■   ■ ■
;->                   ■ ■      ·     ■
;->              ■  ■          ·     ■■   ■
;->                       ■    ·
;->                       ■    ·       ■
;->                            ·
;->                            ·
;->                      ■     ·

Per ogni lancio, la biglia si fermerà a una distanza "z" dal bersaglio.
La regola 2 è spostare l'imbuto di una distanza -z dalla sua ultima posizione.
Il modello risultante è mostrato nella figura sopra.
Come si può vedere anche lo schema della Regola 2 è circolare e stabile.
Tuttavia, il cerchio è più grande rispetto alla Regola 1.
L'uso della Regola 2 aumenta effettivamente la varianza del processo di un fattore 2 rispetto alla Regola 1.
La regola 2 è spesso utilizzata negli affari da persone che cercano solo di fare del loro meglio.
Questo è il motivo per cui è importante comprendere quali sono i parametri che causano una variazione.
Rispondendo ad una variazione che è dovuta ad una causa comune come se fosse dovuta ad una causa speciale, si aumenta la variazione del processo.

Regola 3:

(funnel 3)
;-> media x: 0.04385999999999997
;-> stdev x: 7.98711558701888
;-> media y: -0.006299999999999955
;-> stdev y: 4.778416812083266

(setq xy3 (map list xvec yvec))
(plot-xy xy3 40 20)
;-> x: -12.560      12.584
;-> y: -8.283       8.267
;->                      ·
;->  ■                   ·
;->  ■■   ■■             ·
;->     ■ ■■■            ·
;->    ■■■ ■             ·
;->      ■               ·
;->   ■■ ■■■     ■■      ·
;->    ■       ■    ■■   ·
;->           ■   ■■     ·■■
;->               ■      ■ ■
;->                      ■■
;->  ···················■O·····················
;->                      ■
;->                    ■ ■      ■ ■
;->                    ■■·   ■■  ■         ■
;->                      ·■   ■ ■   ■■  ■■
;->                      ·      ■■     ■■■  ■
;->                      ·              ■■
;->                      ·             ■ ■■ ■
;->                      ·            ■ ■ ■ ■
;->                      ·           ■ ■■   ■■
;->                      ·             ■     ■

La regola 3 è spostare l'imbuto di una distanza -z dal bersaglio dopo ogni lancio della biglia che finisce a una distanza z dal bersaglio. Notare che la regola 2 sposta l'imbuto in base all'ultima posizione dell'imbuto. La regola 3 sposta l'imbuto a una distanza dal bersaglio.
I risultati sono mostrati nella figura sopra.
In questo caso il lancio delle biglie oscilla avanti e indietro. Il motivo sembra simile a una farfalla. Questo non è un processo stabile. L'ampiezza delle oscillazioni continuerà ad aumentare.

Regola 4:

(funnel 4)
;-> regola: 4
;-> media x: 3.13412
;-> stdev x: 1.587393298965319
;-> media y: 5.42102
;-> stdev y: 3.930362593909116

(setq xy4 (map list xvec yvec))
(plot-xy xy4 40 20)
;-> x: -0.533       6.680
;-> y: -0.037       12.149
;->     ·
;->     ·                 ■■■
;->     ·                 ■■■
;->     ·    ■■ ■■ ■       ■■  ■ ■  ■ ■
;->     ·      ■          ■       ■
;->     ·         ■■  ■         ■■  ■
;->     ·                          ■■
;->     ·   ■          ■
;->     ■
;->     ■         ■■  ■ ■
;->     ·            ■  ■■  ■ ■
;->     ·
;->     ·                         ■■
;->     ·                          ■  ■
;->     ·                   ■         ■
;->     ·                  ■  ■       ■■
;->     ·■       ■     ■   ■  ■  ■  ■■
;->     · ■   ■■■ ■          ■     ■
;->     ·                ■■■■      ■■
;->     ·  ■        ■■   ■■ ■ ■     ■        ■
;->   ■ ·            ■          ■
;->  ■··∙············■··■······················

La regola 4 consiste semplicemente nel posizionare l'imbuto sul punto in cui si è fermata l'ultima biglia. Il modello per questa variazione è mostrato nella figura sopra.
In base a questa regola, la biglia continua a spostarsi in una direzione.
Non tornerà. Questo non è un processo stabile.

Esempi di regole
----------------
Nel libro del 1968 "Out of the Crisis" di Edward Deming, vengono presentati alcuni esempi di regole comuni.

Esempi della regola 2:
 - Meccanismi di feedback che rispondono a dati di un punto singolo
 - Regolazione di un processo quando una parte manca delle specifiche
 - Regolazioni dell'operatore senza l'ausilio di carte di controllo
 - Modifica della politica aziendale in base all'ultimo sondaggio sulle tendenze
 - Ricalibrazione degli strumenti su uno standard
 - Utilizzo delle varianze per impostare i budget
 - Reazione del mercato azionario al deficit del mese scorso

Esempi della regola 3:
 - Droghe illegali. Se la droga diminuisce, allora aumentano i prezzi. E questo stimola l'importazione di droga. Il ciclo si ripete.
 - Il giocatore aumenta la sua scommessa per coprire le perdite

Esempi della regola 4:
 - Storia tramandata di generazione in generazione.
 - Cambiamenti continui della formazione dei lavoratori
 - Adeguamento dell'orario della riunione in base all'ultimo orario effettivo di inizio.
 - Uso dell'ultimo pezzo lavorato come motivo per il pezzo successivo.
 - Seduto in cerchio con un certo numero di persone. Una persona sussurra un segreto alla persona successiva che a sua volta lo sussurra alla persona successiva e così via.


---------------
Fase della luna
---------------

Scriviamo una funzione per calcolare la fase della luna di un dato giorno.
Il ciclo completo della luna viene diviso in 30 fasi da 0 a 29.
Da 0 a 14 la luna è crescente, da 15 a 29 la luna è calante.
La luna piena è nei giorni 14 e 15.
Vedi immagine  "moonPhases.jpg" nella cartella "data".

(define (julian gdate)
"Convert gregorian date to julian day number (valid only from 15 ottobre 1582 A.D.)"
  (local (a y m)
    (setq a (/ (- 14 (gdate 1)) 12))
    (setq y (+ (gdate 0) 4800 (- a)))
    (setq m (+ (gdate 1) (* 12 a) (- 3)))
    (+ (gdate 2) (/ (+ (* 153 m) 2) 5) (* y 365) (/ y 4) (- (/ y 100)) (/ y 400) (- 32045))))

Funzione che ritorna la parte frazionaria di un numero float:

(define (getfrac fr) (sub fr (floor fr)))

Funzione che calcola la fase della luna in un determinato giorno:

; Calculate the approximate moon's age in days of a particular date
; This is based on some Basic code by Roger W. Sinnot
; from Sky & Telescope magazine, March 1985.
; I don't understand it very well :-)
; Return the day of the moon (0..29)
; (0..14) crescent moon (luna crescente)
; (15..29) decrescent moon (luna calante)
(define (moon theYear theMonth theDay)
  (local (thisJD degToRad K0 T T2 T3 J0 F0 M0 M1 M5 M6 B1 B6 F
          phase jtheDay oldJ)
    (setq thisJD (julian (list theYear theMonth theDay)))
    ;(println "julian: " thisJD)
    ;;thisJD = jultheDay(theYear,theMonth,theDay);
    (setq degToRad (div 3.1415926535897931 180))
    ;;degToRad = 3.14159265 / 180;
    (setq K0 (floor (mul (sub theYear 1900) 12.3685)))
    ;;K0 = Math.floor((theYear-1900)*12.3685);
    (setq T (div (sub theYear 1899.5) 100))
    ;;T = (theYear-1899.5) / 100;
    (setq T2 (mul T T))
    ;;T2 = T*T;
    (setq T3 (mul T T T))
    ;;T3 = T*T*T;
    (setq J0 (add 2415020 (mul 29 K0)))
    ;;J0 = 2415020 + 29*K0;
    (setq F0 (add (mul 0.0001178 T2) (- (mul 0.000000155 T3))
                  (add 0.75933 (mul 0.53058868 K0))
                  (- (add 0.000837 (mul 0.000335 T2)))))
    ;;F0 = 0.0001178*T2 - 0.000000155*T3 + (0.75933 + 0.53058868*K0) - (0.000837*T + 0.000335*T2);
    (setq M0 (add (mul 360 (getfrac (mul K0 0.08084821133))) 359.2242
                  (- (mul 0.0000333 T2))
                  (- (mul 0.00000347 T3))))
    ;;M0 = 360*(GetFrac(K0*0.08084821133)) + 359.2242 - 0.0000333*T2 - 0.00000347*T3;
    (setq M1 (add (mul 360 (getfrac (mul K0 0.07171366128))) 306.0253
                  (mul 0.0107306 T2)
                  (mul 0.00001236 T3)))
    ;;M1 = 360*(GetFrac(K0*0.07171366128)) + 306.0253 + 0.0107306*T2 + 0.00001236*T3;
    (setq B1 (add (mul 360 (getfrac (mul K0 0.08519585128))) 21.2964
                  (- (mul 0.0016528 T2))
                  (- (mul 0.00000239 T3))))
    ;;B1 = 360*(GetFrac(K0*0.08519585128)) + 21.2964 - (0.0016528*T2) - (0.00000239*T3);
    (setq phase 0.0)
    ;;double phase = 0.0;
    (setq jtheDay 0.0)
    ;;double jtheDay = 0.0;
    (setq oldJ 0.0)
    ;;oldJ = 0.0;
    (while (< jtheDay thisJD)
      (setq F (add F0 (mul 1.530588 phase)))
      ;;double F = F0 + 1.530588*phase;
      (setq M5 (mul (add M0 (mul phase 29.10535608)) degToRad))
      ;;double M5 = (M0 + phase*29.10535608)*degToRad;
      (setq M6 (mul (add M1 (mul phase 385.81691806)) degToRad))
      ;;double M6 = (M1 + phase*385.81691806)*degToRad;
      (setq B6 (mul (add B1 (mul phase 390.67050646)) degToRad))
      ;;double B6 = (B1 + phase*390.67050646)*degToRad;
      (setq F (sub F
              (add (mul 0.4068 (sin M6))
                  (mul (sub 0.1734 (mul 0.000393 T)) (sin M5)))))
      ;;F -= 0.4068*Math.sin(M6) + (0.1734 - 0.000393*T)*Math.sin(M5);
      (setq F (add F
              (add (mul 0.0161 (sin (mul 2 M6)))
                  (mul 0.0104 (sin (mul 2 B6))))))
      ;;F += 0.0161*Math.sin(2*M6) + 0.0104*Math.sin(2*B6);
      (setq F (sub F
              (sub (mul 0.0074 (sin (sub M5 M6)))
                  (mul 0.0051 (sin (add M5 M6))))))
      ;;F -= 0.0074*Math.sin(M5 - M6) - 0.0051*Math.sin(M5 + M6);
      (setq F (add F
              (add (mul 0.0021 (sin (mul 2 M5)))
                  (mul 0.0010 (sin (sub (mul 2 B6) M6))))))
      ;;F += 0.0021*Math.sin(2*M5) + 0.0010*Math.sin(2*B6-M6);
      (setq F (add F  (div 0.5 1440)))
      ;;F += 0.5 / 1440;
      (setq oldJ jtheDay)
      ;;oldJ=jtheDay;
      (setq jtheDay (add J0 (mul 28 phase) (floor F)))
      ;;jtheDay = J0 + 28*phase + Math.floor(F);
      (++ phase)
      ;;phase++;
    )
    ;(println "F: " F)
    ;;return (thisJD-oldJ)%30;
    (mod (sub thisJD oldJ) 30)))

(moon 2022 8 17)
;-> 20

(moon 1977 6 15)
;-> 29

(moon 2022 12 31)
;-> 9


-----------------------------------------------
Varianza e deviazione standard, (N-1) oppure N?
-----------------------------------------------

Data una lista di valori x1, x2, ..., xN,

La deviazione standard "s" viene calcolata con le seguenti formule:

Deviazione standard della popolazione [D1]:

              ∑[(x(i) - media)²]
   s = sqrt(----------------------)   [D1]
                      N

Deviazione standard del campione [D2]:

              ∑[(x(i) - media)²]
   s = sqrt(----------------------)   [D2]
                   (N - 1)

dove media vale:

            ∑x(i)
  media = ---------
              N

La varianza viene calcolata con le seguenti formule:

Varianza della popolazione [V1]:

         ∑[(x(i) - media)²]
  s² = ----------------------         [V1]
                N

Varianza del campione [V2]:

         ∑[(x(i) - media)²]
  s² = ----------------------         [V2]
             (N - 1)

Perchè esistono due formule? E quale dobbiamo utilizzare?

In pratica, la deviazione standard sintetizza le deviazioni dalla media.
Tutto dipende da come abbiamo calcolato/stimato della media.
Se abbiamo la media effettiva, usiamo la formula della deviazione standard della popolazione [D1] che divide per N.
Se avviamo una stima della media, allora è necessario utilizzare la deviazione standard campionaria [D2] che divide per (N - 1).
In altre parole, se dobbiamo calcolare la deviazione standard di una serie completa di dati, allora dobbiamo usare la formula della deviazione standard della popolazione [D1] (perchè siamo in grado di calcolare la media effettiva).
Invece se dobbiamo calcolare la deviazione standard di un campione dei dati, allora dobbiamo usare la formula della deviazione standard del campione [D2] (poichè la media che calcoliamo è una stima della media effettiva).
Nota: si usa la formula [D2] quando vogliamo effettuare delle previsioni sui prossimi valori della serie di dati.

Perchè si divide per (N - 1)?

Si tratta del metodo "Correzione di Bessel" che corregge il bias nella stima della varianza della popolazione e, parzialmente, il bias nella stima della deviazione standard della popolazione. Tuttavia, la correzione spesso aumenta l'errore quadratico medio in queste stime.

newLISP mette a disposizione la funzione "stats" per calcolare la varianza e la deviazione standard di una lista di numeri.

******************
>>>funzione STATS
******************
sintassi: (stats list-vector)

La funzione calcola alcuni valori statistici dei valori in list-vector.
I seguenti valori vengono restituiti in una lista:

  Name   Description
  ----   -----------
  N      Number of values
  mean   Mean of values
  avdev  Average deviation from mean value
  sdev   Standard deviation (population estimate)
  var    Variance (population estimate)
  skew   Skew of distribution
  kurt   Kurtosis of distribution

L'esempio seguente formatta l'output della lista con "format":

(set 'data '(90 100 130 150 180 200 220 300 350 400))

(println (format [text]
    N        = %5d
    mean     = %8.2f
    avdev    = %8.2f
    sdev     = %8.2f
    var      = %8.2f
    skew     = %8.2f
    kurt     = %8.2f
[/text] (stats data)))
;->     N        =    10
;->     mean     =   212.00
;->     avdev    =    84.40
;->     sdev     =   106.12
;->     var      = 11262.22
;->     skew     =     0.49
;->     kurtosis =    -1.34

Scriviamo alcune funzioni per calcolare varianza e deviazione standard utilizzando la seguente lista di dati per i test:

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

Funzione per il calcolo della media di una lista di numeri:

(define (media lst)
  (div (apply add lst) (length lst)))

(media dat)
;-> 0.0003999999999999896

Funzioni per il calcolo della deviazione standard di una lista di numeri:

(define (devst lst) ; popolazione -> diviso N
  (let (m (media lst))
    (sqrt (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
               (length lst)))))

(define (devst2 lst) ; campione -> diviso (N - 1)
  (let (m (media lst))
    (sqrt (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
               (- (length lst) 1)))))

(devst dat)
;-> 0.7152712073053128
(devst2 dat)
;-> 0.7188746115079505

Funzioni per il calcolo della varianza:

(define (varianza lst) ; popolazione -> diviso N
  (let (m (media lst))
    (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
         (length lst))))

(define (varianza2 lst) ; campione -> diviso (N - 1)
  (let (m (media lst))
    (div (apply add (map (fn(x) (mul (sub x m) (sub x m))) lst))
         (- (length lst) 1))))

(varianza dat)
;-> 0.5116128999999997
(varianza2 dat)
;-> 0.5167807070707068

Vediamo i valori restituiti dalla funzione "stats":

(define (varianza-stat lst) ((stats lst) 4))
(define (devst-stat lst) ((stats lst) 3))

(varianza-stat dat)
;-> 0.5167807070707071
(devst-stat dat)
;-> 0.7188746115079507

Quindi la funzione "stats" calcola con il metodo del campione, cioè divide per (N - 1).

Possiamo scrivere due funzioni che utilizzano la primitiva "stats" per calcolare la varianza e la deviazione standard con il metodo della popolazione (cioè dividendo per N):

(define (stdev lst)
  (setq stat (stats lst))
  (setq var (stat 4))
  (setq n (stat 0))
  (sqrt (div (mul var (sub n 1)) n)))

(stdev dat)
;-> 0.715271207305313

(define (variance lst)
  (setq stat (stats lst))
  (setq var (stat 4))
  (setq n (stat 0))
  (div (mul var (sub n 1)) n))

(variance dat)
;-> 0.5116129

L'algoritmo cha abbiamo usato per il calcolo della varianza è numericamente stabile se N è piccolo. Tuttavia, i suoi risultati possono dipendere non commutativamente dall'ordinamento dei dati e possono dare scarsi risultati per molti dati a causa degli errori di arrotondamento che si accumulano nelle somme. Tecniche quali la somma compensata possono essere usate per ridurre questo errore.
Vediamo la versione dell'algoritmo base con somma compensata:

(define (varianza-compensata lst tipo)
  (local (m n sum2 sum3)
    (setq m (media lst))
    (setq n (length lst))
    (set 'sum2 0 'sum3 0)
    (dolist (x lst)
      (setq sum2 (add sum2 (mul (sub x m) (sub x m))))
      (setq sum3 (add sum3 (sub x m)))
    )
    (if tipo
      (div (sub sum2 (div (mul sum3 sum3) n)) n) ; diviso N
      (div (sub sum2 (div (mul sum3 sum3) n)) (sub n 1))))) ;diviso (N - 1)

(varianza-compensata dat)
;-> 0.5167807070707068

(varianza-compensata dat true)
;-> 0.5116128999999997


-------------
Jensen Device
-------------

Il dispositivo di Jensen è una tecnica di programmazione ideata dal danese Jørn Jensen dopo aver studiato il rapporto ALGOL 60.
Il seguente programma è stato proposto per illustrare la tecnica.
Calcola il centesimo numero armonico (5.18737751763962):

begin
   integer i;
   real procedure sum (i, lo, hi, term);
      value lo, hi;
      integer i, lo, hi;
      real term;
      comment term is passed by-name, and so is i;
   begin
      real temp;
      temp := 0;
      for i := lo step 1 until hi do
         temp := temp + term;
      sum := temp
   end;
   comment note the correspondence between the mathematical notation and the call to sum;
   print (sum (i, 1, 100, 1/i))
end

Vedaimo di scrivere una cosa simile in newLISP (non proprio uguale...):

(define (somma var start end func)
  (local (expr s)
    (setq s 0)
    (setq expr (replace (string " " var) (string func) " k"))
    ;(println expr)
    (for (k start end)
      (setq s (add s (eval-string expr)))
    )))

(somma 'i 1 100 '(div i))
;-> 5.187377517639621

(somma 'x 1 100 '(div x))
;-> 5.187377517639621

(somma 'x 1 100 '(div (mul x x)))
;-> 1.634983900184892


--------------------------------------------------
Il principio dei cassetti ("pigeonhole principle")
--------------------------------------------------

Il principio dei cassetti (o della piccionaia "pigeonhole principle"), afferma che se n+k oggetti sono messi in n cassetti, allora almeno un cassetto deve contenere più di un oggetto.
Un altro modo di vedere il principio è che una piccionaia con m caselle può contenere al più m piccioni, se non se ne vogliono mettere più di uno in nessuna casella: un ulteriore volatile dovrà necessariamente condividere la casella con un suo simile.
Formalmente, il principio afferma che se A e B sono due insiemi finiti e B ha cardinalità strettamente minore di A, allora non esiste alcuna funzione iniettiva da A a B.
Questo principio è stato usato per la prima volta da Dirichlet nel 1834 col nome Schubfachprinzip ("principio del cassetto").

Estensione del principio della piccionaia
-----------------------------------------
Se p(iccioni) > n*c(aselle) per qualche intero n, allora almeno una casella contiene n + 1 piccioni.
Esempio:
Se ci sono 27 piccioni in 8 caselle, allora, poiché 27 > 3*8, almeno una casella contiene 3 + 1 = 4 piccioni.

Il principio afferma che:

1) Se A è il numero medio di piccioni per buca, dove A non è un intero allora,
almeno una buca contiene ceil[A] (numero intero più piccolo maggiore o uguale ad A) piccioni.
Le buche rimanenti contengono al massimo floor(A) (numero intero maggiore minore o uguale ad A) piccioni.

2) Possiamo dire che, se n + 1 oggetti vengono inseriti in n caselle, allora almeno una casella contiene due o più oggetti.

Definizione del principio della piccionaia di Dijkstra
------------------------------------------------------
Dato un qualunque insieme non-vuoto di numeri reali, il valore massimo tra essi è almeno pari alla media dei valori.

Consideriamo di nuovo il problema di infilare i piccioni nelle buche e consideriamo la media. Se abbiamo più di n piccioni e n buche, il valore medio di (piccioni/buche) è maggiore di uno. Ciò significa che anche il valore massimo dovrebbe essere maggiore di uno. In altre parole, ci deve essere un valore con più di un piccione per buca.

Formulazione astratta del principio
-----------------------------------
Siano X e Y insiemi finiti e sia f: A -> B una funzione:
  se X ha più elementi di Y, allora f non è uno a uno.
  se X e Y hanno lo stesso numero di elementi ed f è su, allora f è uno a uno.
  se X e Y hanno lo stesso numero di elementi ed f è uno a uno, allora f è su.

Esempio
-------
Se (K*n+1) piccioni sono tenuti in n buche dove K è un intero positivo, qual è il numero medio di piccioni per buca?
Soluzione:
numero medio di piccioni per buca = (K*n+1)/n = K + 1/n
Pertanto ci sarà almeno una buca che conterrà almeno (K+1) piccioni, cioè ceil(K + 1/n) e le rimaneti buche conterranno al massimo K  piccioni (cioè floor(K+1/n).
In altre parole, il numero minimo di piccioni richiesto per garantire che almeno una buca contenga (K+1) piccioni è (K*n+1).

Questo principio permette di risolvere problemi di varia natura, se si è in grado di applicarlo correttamente.

Problema 1
----------
Da "Giochi di aritmetica e problemi interessanti" di Giuseppe Peano.
Si stima che la superficie del capo umano portante capelli è di 775 cm2 e che ogni cm2 contiene al massimo 165 capelli. Dimostrare che in una città di 150.000 abitanti vi sono due persone che hanno lo stesso numero di capelli.
Soluzione: poiché il massimo numero di capelli che può avere una persona vale:

  775 * 165 = 125875 < 150.00

allora si deduce la tesi come conseguenza del principio dei cassetti.
Per esempio, per una città come Roma, che ha circa 2.788.000 abitanti (ISTAT 2020), esistono almeno 22 persone che hanno lo stesso numero di capelli.

Problema 2
----------
Una borsa contiene 10 biglie rosse, 10 biglie bianche e 10 biglie blu. Qual è il minimo n. di biglie devi scegliere a caso dal sacchetto per assicurarti di ottenere 4 biglie dello stesso colore?
Soluzione: applichiamo il principio della piccionaia.
N. di colori (buche) n = 3
N. di biglie (piccioni) K+1 = 4
Pertanto il minimo n. di biglie richieste = K*n+1
Semplificando otteniamo K*n+1 = 10.
Verifica: ceil(media) è [K*n+1/n] = 4
(K*n+1/3) = 4
K*n+1 = 10
cioè, 3 rosse + 3 bianche + 3 blu + 1 (rossa o bianca o blu) = 10

Forma forte del Principio della Piccionaia
------------------------------------------
Teorema: Siano q1, q2, ... , qn numeri interi positivi.
Se q1 + q2 + ... + qn – n + 1 oggetti vengono inseriti in n caselle, quindi o la prima casella contiene almeno q1 oggetti o la seconda casella contiene almeno q2 oggetti, ..., o l'ennesima casella contiene almeno qn oggetti.

Problema 3
----------
In una scuola, una squadra può essere formato con 10 alunni del primo anno o 8 del secondo anno o 6 del terzo anno o 4 dell'ultimo anno. Scegliendo gli alunni a caso, qual è il numero minimo di studenti che dobbiamo scegliere per garantire che si formi una squadra?
Soluzione: possiamo applicare direttamente dalla formula sopra dove,

  q1 = 10, q2 = 8, q3 = 6, q4 = 4 e n=4

Pertanto il numero minimo di studenti richiesto per garantire la formazione del club di dipartimento vaLe:

  10 + 8 + 6 + 4 – 4 + 1 = 25

Problema 4
----------
Una scatola contiene 6 palline rosse, 8 verdi, 10 blu, 12 gialle e 15 bianche. Scegliendo a caso, qual è il numero minimo di palline che dobbiamo scegliere dalla scatola per essere certi di ottenere 9 palline dello stesso colore?
Soluzione: in questo caso non possiamo applicare direttamente la formula.
Infatti vediamo cosa accade se la applichiamo direttamente:

 q1  q2   q3   q4   q5   n
  6 + 8 + 10 + 12 + 15 - 5 + 1 = 47

Ma questo risultato è sbagliato.
Per ottenere la risposta corretta dobbiamo includere solo le palline blu, gialle e bianche perché le palline rosse e verdi sono meno di Ma, poichè stiamo selezionando casualmente, dobbiamo includere le palline rosse e blu dopo aver applicato il principio del piccione.
Quindi prima applichiamo la formula con le palline blu, gialle e bianche:

       q1      q2         q3          n
       9 blu + 9 gialle + 9 bianche – 3 + 1 = 25

E poi aggiungiamo le palline rosse e quelle verdi:

  6 rosse + 8 verde + 25 = 39

Possiamo concludere che per essere certi di avere 9 palline dello stesso colore, si devono prelevare, in modo casuale, 39 palline dalla scatola.

Problema 5
----------
Dato un qualunque insieme A di n+1 numeri naturali compresi tra 1 e 2n.
Esiste sempre in A una coppia di numeri in cui un numero divide l'altro?
Soluzione:
Ogni numero a si può dividere successivamente per 2, zero o più volte fino ad arrivare ad un numero dispari, ovvero a=(2^k)*m con m dispari. Si avrà k >= 0 e m <= a.
Poichè a appartiene ad A si ha m <= 2n.
Ma ci sono solo n numeri dispari tra 1 e 2n, mentre in A ci sono n+1 numeri, quindi un valore di m si ripete almeno due volte (principio della piccionaia):

  a=(2^i)*m   b=(2^j)*m

con a e b appartenenti ad A e quindi uno divide l'altro.

Problema 6
----------
Non è possibile inventare un algoritmo di compressione dati senza perdita di informazioni ("lossless") che funzioni sempre, cioè che a partire da un qualunque file in ingresso ne produca in uscita sempre uno più corto.
Soluzione:
Consideriamo i file di lunghezza k bit. Il loro numero è per definizione 2^k: ma i file di lunghezza tra 1 e k−1 sono solo 2^k−1, e pertanto dobbiamo avere due file che vengono "compressi" nello stesso file.
Come facciamo allora a decomprimere il file compresso e scegliere il risultato corretto?

From wikipedia:
Lossless data compression algorithms (that do not attach compression id labels to their output data sets) cannot guarantee compression for all input data sets. In other words, for any lossless data compression algorithm, there will be an input data set that does not get smaller when processed by the algorithm, and for any lossless data compression algorithm that makes at least one file smaller, there will be at least one file that it makes larger. This is easily proven with elementary mathematics using a counting argument called the pigeonhole principle:

- Assume that each file is represented as a string of bits of some arbitrary length.
- Suppose that there is a compression algorithm that transforms every file into an output file that is no longer than the original file, and that at least one file will be compressed into an output file that is shorter than the original file.
- Let M be the least number such that there is a file F with length M bits that compresses to something shorter. Let N be the length (in bits) of the compressed version of F.
- Because N<M, every file of length N keeps its size during compression. There are 2^N such files possible. Together with F, this makes 2^N + 1 files that all compress into one of the 2^N files of length N.
- But 2^N is smaller than 2^N + 1, so by the pigeonhole principle there must be some file of length N that is simultaneously the output of the compression function on two different inputs. That file cannot be decompressed reliably (which of the two originals should that yield?), which contradicts the assumption that the algorithm was lossless.
- We must therefore conclude that our original hypothesis (that the compression function makes no file longer) is necessarily untrue.

Problema 7
----------
Dimostrare che ad una festa ci sono due persone che hanno lo stesso numero di amici (l'amicizia è reciproca, cioè se A è amico di B, allora anche B è amico di A).
Soluzione:
detto n il numero di persone ad una festa, allora ogni partecipante può avere da 0 a (n - 1) amici. Se tutte le persone avessero un numero diverso di amici, allora ce ne sarebbe una con 0 amici e un'altra con (n - 1) amici, il che è impossibile in quanto la persona con(n - 1) amici sarebbe amica di tutti (compreso di colui che ha 0 amici).
Un altro modo di ragionare
Ognuno degli n partecipanti può essere amico di un numero di persone variabile tra 0 e n-1. Iniziamo a supporre che ciascuno abbia almeno un amico, e associamogli il numero di amici che ha: ci sono allora n persone a cui sono associati i numeri da 1 a n−1, e per il principio dei cassetti due di loro devono avere lo stesso numero. Cosa succede se esiste uno senza amici (imbucato)? In questo caso nessuno degli altri può avere n−1 amici, visto che non conosce l'imbucato. Quindi alle n persone si associano i numeri da 0 a n−2, che vale di nuovo n−1.

Nota: nel 2014 è stato dimostrato che in meccanica quantistica il principio dei cassetti può essere violato.


----------------------------------
Principio di inclusione-esclusione
----------------------------------

Nella teoria degli insiemi, il principio di inclusione-esclusione è un'identità che mette in relazione la cardinalità di un insieme, espresso come unione di insiemi finiti, con le cardinalità delle intersezioni tra questi insiemi.
Denotiamo |A| la cardinalità di un insieme A e consideriamo una famiglia finita di insiemi finiti: A1,A2,...,An.
La cardinalità dell'unione di tale famiglia vale:

  | n     |   n        {coppie}     {terne}                          {ennupla}
  | ∪ A(i)| = ∑|Ai| - ∑|Ai ∩ Aj| + ∑|Ai ∩ Aj ∩ Ak| - ... +(-1)^(n+1)*|A1 ∩ A2 ∩ ... ∩ An|
  |i=1    |  i=1    1<=i<j<=n   1<=i<j<k<=n

oppure in modo equivalente:

  | n     |   n
  | ∪ A(i)| = ∑(-1)^(i+1) *        ∑ |Ai1 ∩ Ai2 ∩ ... ∩ Ain|
  |i=1    |  i=1             1<=i1<...<ik<=n

Nel caso n = 2:

  |A ∪ B| = |A| + |B| - |A ∩ B|

Nel caso n = 3:

  |A ∪ B ∪ C| = |A| + |B| + |C| - |A ∩ B| - |A ∩ C| - |B ∩ C| + |A ∩ B ∩ C|

Nel caso n = 4:

  |A ∪ B ∪ C ∪ D| =
  = |A| + |B| + |C| + |D| ;tutte le singole
  - |A ∩ B| - |A ∩ C| - |A ∩ D| - |B ∩ C| - |B ∩ D| - |C ∩ D| ;tutte le coppie
  + |A ∩ B ∩ C| + |A ∩ B ∩ D| + |A ∩ C ∩ D| + |B ∩ C ∩ D| ;tutte le terne
  - |A ∩ B ∩ C ∩ D| ;tutte le quaterne

Verifichiamo il principio implementando la relativa funzione.

Funzione inclusione-esclusione con 2 liste:

(define (include-exclude2 A B)
  (- (+ (length A) (length B)) (length (intersect A B))))

Facciamo una prova:

(setq a '(1 2 3 4 5))
(setq b '(3 4 5))
(include-exclude2 a b)
;-> 5

Funzione che effettua l'intersezione di N liste:

(define (intersects)
  (let (tmp (intersect (args 0)))
    (doargs (arg)
      (setq tmp (intersect tmp arg)))
    tmp))

(setq a1 '(1 2 3 4 5))
(setq b1 '(4 5))
(setq c1 '(5 6 7 8))

(intersects a1 b1 c1)
;-> (5)

La funzione che effettua l'unione di N liste non serve...perchè la primitiva "union" accetta N liste.

(union a1 b1 c1)
;-> (1 2 3 4 5 6 7 8)

;(define (unions)
;  (let (tmp '())
;    (doargs (arg)
;      (setq tmp (union tmp arg)))
;    tmp))

;(unions a1 b1 c1)
;-> (1 2 3 4 5 6 7 8)

Funzione inclusione-esclusione con 3 liste:

(define (include-exclude3 A B C)
  (+ (length A) (length B) (length C)
     (- (+ (length (intersect A B))
           (length (intersect A C))
           (length (intersect B C))))
     (length (intersects A B C))))

(include-exclude3 a1 b1 c1)
;-> 8

Funzione inclusione-esclusione con 4 liste:

(define (include-exclude4 A B C D)
  (+ (length A) (length B) (length C) (length D)
     (- (+ (length (intersect A B))
           (length (intersect A C))
           (length (intersect A D))
           (length (intersect B C))
           (length (intersect B D))
           (length (intersect C D))))
     (length (intersects A B C))
     (length (intersects A B D))
     (length (intersects A C D))
     (length (intersects B C D))
     (- (length (intersects A B C D)))))

Facciamo una prova:

(setq a2 '(1 2 3 4 5 6))
(setq b2 '(4 5 6 9))
(setq c2 '(5 6 7 8 10))
(setq d2 '(5 6 7 8 10 11 12))

(include-exclude4 a2 b2 c2 d2)
;-> 12

(unions a2 b2 c2 d2)
;-> (1 2 3 4 5 6 7 8 9 10 11 12)

Tutto in un'unica funzione:

(define (include-exclude)
  (cond ((= (length (args)) 2)
          (- (+ (length (args 0)) (length (args 1)))
          (length (intersect (args 0) (args 1)))))
        ((= (length (args)) 3)
          (+ (length (args 0)) (length (args 1)) (length (args 2))
             (- (+ (length (intersect (args 0) (args 1)))
                   (length (intersect (args 0) (args 2)))
                   (length (intersect (args 1) (args 2)))))
             (length (intersects (args 0) (args 1) (args 2)))))
        ((= (length (args)) 4)
          (+ (length (args 0)) (length (args 1)) (length (args 2)) (length (args 3))
             (- (+ (length (intersect (args 0) (args 1)))
                   (length (intersect (args 0) (args 2)))
                   (length (intersect (args 0) (args 3)))
                   (length (intersect (args 1) (args 2)))
                   (length (intersect (args 1) (args 3)))
                   (length (intersect (args 2) (args 3)))))
             (length (intersects (args 0) (args 1) (args 2)))
             (length (intersects (args 0) (args 1) (args 3)))
             (length (intersects (args 0) (args 2) (args 3)))
             (length (intersects (args 1) (args 2) (args 3)))
             (- (length (intersects (args 0) (args 1) (args 2) (args 3))))))
        (true (println "Error:" (args)) nil)
  )
)

Verifichiamo i risultati delle funzioni precedenti:

(include-exclude a b)
;-> 5
(include-exclude a1 b1 c1)
;-> 8
(include-exclude a2 b2 c2 d2)
;-> 12

Problema
--------
In un gruppo di 100 persone, 70 hanno un cane e 50 hanno un gatto.
Quante persone hanno sia un cane sia un gatto?
Soluzione
Indichiamo con A e B i gruppi di possessori di cani e gatti.
Per ipotesi abbiamo: |A|=70 e |B|=50.
Per il principio di inclusione-esclusione abbiamo:

  |A ∪ B| = |A| + |B| – |A ∩ B|

Ora |A∪B| non può essere maggiore di 100. Quindi possiamo dedurre:

  100 ≥ 70 + 50 – |A ∩ B|

e quindi:

  |A ∩ B| ≥ 70 + 50 − 100 = 20

In questo caso quindi non siamo in grado di dare una risposta univoca, tuttavia possiamo essere sicuri che ci sono almeno 20 persone che hanno un cane e un gatto.

Complementary counting
----------------------
Un'altra tecnica frequente è quella del complementary counting, cioè si vanno a contare tutti i casi non richiesti (il complementare) per poi sottrarli al numero totale di casi. Ad esempio, se volessi conoscere tutte le parole lunghe 5 lettere con almeno una A, possiamo sottrarre il numero di parole che non contengono la A(25^5) al numero totale di parole con 5 lettere (26^5).

Problema
--------
Quante parole di 3 lettere non contengono la stessa lettera due volte di seguito?
Soluzione
Il numero totale di parole di 3 lettere è pari a 26^3.
Contiamo in quanti modi le parole hanno almeno due lettere di seguito.
Potrebbe accadere che le due lettere uguali occupano la prima e seconda posizione, per un totale di 26^2 modi  infatti la prima coppia di lettere la posso scegliere in 26 modi, la terza lettera nuovamente in 26 modi).
Stesso conto nel caso in cui la coppia di lettere uguali occupano la seconda e terza posizione.
Invece le parole in cui tutte e 3 le lettere sono uguali sono 26. Dunque la risposta cercata è data da:

  26^3 - 26^2 - 26^2 + 26 = 16250

Principio fondamentale del contare
----------------------------------
"Se un evento si può verificare una prima volta in n1 modi diversi, una seconda in n2, una terza in n2, e così via, allora il numero di sequenze di eventi nell'ordine indicato sarà n1*n2*n3*...".


---------------------------------------------
Fattoriale crescente e fattoriale decrescente
---------------------------------------------

Fattoriale decrescente (falling factorial)
------------------------------------------

                        n fattori
              +-----------------------------+
  fact-fall = x*(x - 1)*(x - 2)...(x - n + 1) =

             (n-1)
  fact-fall =  ∏ (x - k)
              k=0

Relazione con i numeri fattoriali:

                  x!
  fact-fall = ----------
               (x - n)!

Scriviamo la funzione:

(define (fact-fall x n)
  (let (f 1)
    (cond ((zero? n) (setq f 0))
          (true
            (for (k 0 (- n 1))
              (setq f (mul f (- x k)))))
    )
    f))

Esempi:

(fact-fall 10 0)
;-> 0

(fact-fall 10 4)
;-> 5040
(* 10 9 8 7)
;-> 5040

(fact-fall 8 3)
;-> 336
(* 8 7 6)
;-> 336

(fact-fall 4 4)
;-> 24
(* 4 3 2 1)
;-> 24

(fact-fall 4 5)
;-> 0
(* 4 3 2 1 0)
;-> 0

Fattoriale crescente (rising factorial)
---------------------------------------

                        n fattori
              +-----------------------------+
  fact-rise = x*(x + 1)*(x + 2)...(x + n + 1) =

             (n-1)
  fact-rise =  ∏ (x + k)
              k=0

Relazione con i numeri fattoriali:

               (x + n + 1)!
  fact-rise = --------------
                 (x - 1)!

Scriviamo la funzione:

(define (fact-rise x n)
  (let (f 1)
    (cond ((zero? n) (setq f 0))
          (true
            (for (k 0 (- n 1))
              (setq f (mul f (+ x k)))))
    )
    f))

Esempi:

(fact-rise 10 0)
;-> 0

(fact-rise 10 4)
;-> 17160
(* 10 11 12 13)
;-> 17160

(fact-rise 8 3)
;-> 720
(* 8 9 10)
;-> 720

(fact-rise 4 4)
;-> 840
(* 4 5 6 7)
;-> 840

(fact-rise 4 5)
;-> 6720
(* 4 5 6 7 8)
;-> 6720


----------------
Parentesi quadre
----------------

Le parentesi quadre "[ ]" sono un metodo rapido per creare simboli legali senza utilizzare la funzione "sym".
Nel tokenizer di newLISP il carattere "[" inizia un nome di simbolo e non lo finisce fino a quando non viene trovato un "]" di chiusura:

(set '[     ^$#@ () ] 123)
;-> 123
[     ^$#@ () ]
;-> 123
(symbol? '[     ^$#@ () ])
;-> true


-----------
cons e push
-----------

In newLISP le seguenti espressioni producono lo stesso effetto, cioè aggiungono un elemento x alla lista s:

1) (set 's (cons x) s)
2) (push x s)

Verifichiamolo:

(= (let (s '()) (dotimes (i 100) (set 's (cons (sqrt i) s))))
   (let (s '()) (dotimes (i 100) (push (sqrt i) s))))
;-> true

Vediamo i tempi di esecuzione delle due espressioni con un numero maggiore di elementi:

(time (let (s '()) (dotimes (i 10000) (set 's (cons (sqrt i) s))) 'end))
;-> 1150.942 ;millisecondi

(time (let (s '()) (dotimes (i 10000) (push (sqrt i) s)) 'end))
;-> 1.994 ;millisecondi

La funzione "cons" è molto lenta.
In newLISP "cons" crea una nuova lista che poi viene inserita in s.
Invece "push" prende il riferimento/puntatore di s e modifica s direttamente, questo è molto più veloce perchè non viene creata e/o copiata nessuna lista aggiuntiva.


-----------------
newLISP "leggero"
-----------------

Un piccolo trucco per "alleggerire" newLISP durante l'avvio.

;;
;; SlimLine Newlisp.
;;
;; A small trick to SlimLine Newlisp during startup.
;; To be used for i.e. a more secure newlisp.
;;
;; Removes all "network" "file-io" "system" access functions from current context 'MAIN in newlisp
;; and replaces them with a warning message.
;;
;; Executed from interactive mode you'll have the "press enter to return!"
;; else remove the text line.
;;
;; (thanks to "Lutz" for the 'constant tip instead of 'cpymem)
;;
;; Enjoy, Norman
;;

(define (default-message)
  (silent (println "Removed from newLisp, press enter to return!" )))

(dolist (x '( "dump" "cpymem" "!" "exec" "fork" "pipe" "process" "wait-pid"
  "close" "command-line" "current-line" "device" "exec" "get-url" "load" "open"
  "post-url" "put-url" "read-buffer" "read-char" "read-file" "read-line" "save"
  "search" "seek" "write-buffer" "write-char" "write-file" "write-line"
  "change-dir" "copy-file" "delete-file" "directory" "file-info" "make-dir"
  "remove-dir" "rename-file" "trace" "putenv" "getenv" "import" "file?" "env"
  "directory?" "net-accept" "net-close" "net-connect" "net-error" "net-listen"
  "net-local" "net-lookup" "net-peer" "net-peek" "net-receive"
  "net-receive-from" "net-receive-udp" "net-select" "net-send" "net-send-to"
  "net-send-udp" "net-service" "net-sessions"))
(constant (symbol x) default-message))


--------
Hex dump
--------

Una "vecchia" funzione per fare il dump esadecimale di un file ASCII:

(pretty-print 100)

(define (hex-dump file)
"hex-dump of ASCII file"
  (local (infile line sofar buff)
    (setq infile (open file "read"))
    (setq line 0)
    ; read file with buffer of 16 char
    (while (> (setq sofar (read-buffer infile buff 16)) 0)
      ; print number of char (es. 00000016)
      (print (format "%08d - " (++ line 16)))
      ; fill buffer to 16 char (if necessary)
      (if (< sofar 16)
          (dotimes (x (- 16 sofar))
            (extend buff (char 0)))
      )
      ; print hex value of chars of buffer
      (dolist (x (explode buff)) (print (format "%02X " (char x))))
      ; format last line with space
      (if (< sofar 16) (print (dup " " (* 3 (- 16 sofar)))))
      ; print chars of buffer
      (dolist (x (explode buff))
        (if (and (>= (char x) 32) (<= (char x) 126))
            (print x)   ; ASCII char: x
            (print ".") ; non-ASCII char: "."
        )
      )
      (print "\n")
    )
    (close infile)))

(save "dump.lsp" 'hex-dump)
(hex-dump "dump.lsp")
;-> 00000016 - 28 64 65 66 69 6E 65 20 28 68 65 78 2D 64 75 6D (define (hex-dum
;-> 00000032 - 70 20 66 69 6C 65 29 0D 0A 20 20 22 68 65 78 2D p file)..  "hex-
;-> 00000048 - 64 75 6D 70 20 6F 66 20 41 53 43 49 49 20 66 69 dump of ASCII fi
;-> 00000064 - 6C 65 22 20 0D 0A 20 20 28 6C 6F 63 61 6C 20 28 le" ..  (local (
;-> 00000080 - 69 6E 66 69 6C 65 20 6C 69 6E 65 20 73 6F 66 61 infile line sofa
;-> 00000096 - 72 20 62 75 66 66 29 20 0D 0A 20 20 20 28 73 65 r buff) ..   (se
;-> 00000112 - 74 71 20 69 6E 66 69 6C 65 20 28 6F 70 65 6E 20 tq infile (open
;-> 00000128 - 66 69 6C 65 20 22 72 65 61 64 22 29 29 20 0D 0A file "read")) ..
;-> 00000144 - 20 20 20 28 73 65 74 71 20 6C 69 6E 65 20 30 29    (setq line 0)
;-> 00000160 - 20 0D 0A 20 20 20 28 77 68 69 6C 65 20 28 3E 20  ..   (while (>
;-> 00000176 - 28 73 65 74 71 20 73 6F 66 61 72 20 28 72 65 61 (setq sofar (rea
;-> 00000192 - 64 2D 62 75 66 66 65 72 20 69 6E 66 69 6C 65 20 d-buffer infile
;-> 00000208 - 62 75 66 66 20 31 36 29 29 20 30 29 20 0D 0A 20 buff 16)) 0) ..
;-> 00000224 - 20 20 20 28 70 72 69 6E 74 20 28 66 6F 72 6D 61    (print (forma
;-> 00000240 - 74 20 22 25 30 38 64 20 2D 20 22 20 28 2B 2B 20 t "%08d - " (++
;-> 00000256 - 6C 69 6E 65 20 31 36 29 29 29 20 0D 0A 20 20 20 line 16))) ..
;-> 00000272 - 20 28 69 66 20 28 3C 20 73 6F 66 61 72 20 31 36  (if (< sofar 16
;-> 00000288 - 29 20 0D 0A 20 20 20 20 20 28 64 6F 74 69 6D 65 ) ..     (dotime
;-> 00000304 - 73 20 28 78 20 28 2D 20 31 36 20 73 6F 66 61 72 s (x (- 16 sofar
;-> 00000320 - 29 29 20 0D 0A 20 20 20 20 20 20 28 65 78 74 65 )) ..      (exte
;-> 00000336 - 6E 64 20 62 75 66 66 20 28 63 68 61 72 20 30 29 nd buff (char 0)
;-> 00000352 - 29 29 29 20 0D 0A 20 20 20 20 28 64 6F 6C 69 73 ))) ..    (dolis
;-> 00000368 - 74 20 28 78 20 28 65 78 70 6C 6F 64 65 20 62 75 t (x (explode bu
;-> 00000384 - 66 66 29 29 20 0D 0A 20 20 20 20 20 28 70 72 69 ff)) ..     (pri
;-> 00000400 - 6E 74 20 28 66 6F 72 6D 61 74 20 22 25 30 32 58 nt (format "%02X
;-> 00000416 - 20 22 20 28 63 68 61 72 20 78 29 29 29 29 20 0D  " (char x)))) .
;-> 00000432 - 0A 20 20 20 20 28 69 66 20 28 3C 20 73 6F 66 61 .    (if (< sofa
;-> 00000448 - 72 20 31 36 29 20 0D 0A 20 20 20 20 20 28 70 72 r 16) ..     (pr
;-> 00000464 - 69 6E 74 20 28 64 75 70 20 22 20 22 20 28 2A 20 int (dup " " (*
;-> 00000480 - 33 20 28 2D 20 31 36 20 73 6F 66 61 72 29 29 29 3 (- 16 sofar)))
;-> 00000496 - 29 29 20 0D 0A 20 20 20 20 28 64 6F 6C 69 73 74 )) ..    (dolist
;-> 00000512 - 20 28 78 20 28 65 78 70 6C 6F 64 65 20 62 75 66  (x (explode buf
;-> 00000528 - 66 29 29 20 0D 0A 20 20 20 20 20 28 69 66 20 28 f)) ..     (if (
;-> 00000544 - 61 6E 64 20 28 3E 3D 20 28 63 68 61 72 20 78 29 and (>= (char x)
;-> 00000560 - 20 33 32 29 20 28 3C 3D 20 28 63 68 61 72 20 78  32) (<= (char x
;-> 00000576 - 29 20 31 32 36 29 29 20 0D 0A 20 20 20 20 20 20 ) 126)) ..
;-> 00000592 - 28 70 72 69 6E 74 20 78 29 20 0D 0A 20 20 20 20 (print x) ..
;-> 00000608 - 20 20 28 70 72 69 6E 74 20 22 2E 22 29 29 29 20   (print ".")))
;-> 00000624 - 0D 0A 20 20 20 20 28 70 72 69 6E 74 20 22 5C 6E ..    (print "\n
;-> 00000640 - 22 29 29 20 0D 0A 20 20 20 28 63 6C 6F 73 65 20 ")) ..   (close
;-> 00000656 - 69 6E 66 69 6C 65 29 29 29 0D 0A 0D 0A          infile)))....
;-> true


----------------------------------------
Da quanto tempo newLISP è in esecuzione?
----------------------------------------

A volte è utile vogliamo sapere da quanto tempo stiamo usando la REPL, cioè da quanto tempo newLISP è in esecuzione.
All'interno di newLISP non è definito alcun contatore per questo valore, ma possiamo crearlo nel modo seguente:

;; newLISP Uptime
;; by newdep
;;
(define (uptime?) (- (date-value) sys-uptime))
;;
;; syntax (uptime?)
;; returns time in seconds newlisp is running.
;; Note: place this in your init.lsp
;; (constant 'sys-uptime (date-value))
;;
;; example
;; (uptime?) => 10


-----------------------------------------------------
ORO, passaggio per valore e passaggio per riferimento
-----------------------------------------------------

Perché la maggior parte delle funzioni in newlisp passano argomenti per valore?

Question: Why do most newlisp functions pass arguments by value?
---------
Answer (by Kazimir Majorinc):
-----------------------------
I think that the main reason for that is - ORO. Each object in memory is referenced by only one symbol. If you have function (define (f x) ... ) and it accepts arguments by reference, and you call it with (f y), then y and x both point on the same value.
The trick is: think about Newlisp symbols not as variables, but as (generalized) memory addresses in other languages. Just like in other languages, one object in memory cannot be stored in two memory adresses, on the same way, it cannot be stored in two symbols in Newlisp.

Because of that, Newlisp frequently requires one indirection more than other languages (just like assembler does).
 But Newlisp is powerful enough so we do not notice it at the first moment, but only when we need to pass large objects as arguments - and our experience with other languages (including other Lisps) might be misleading.
 And why ORO? There are two other memory management model - manual and garbage collection. Lutz has find some middle ground that allow programmer to do some things without manual memory allocation and deallocation, which is hard on programmer - and without garbage collection - which has its own contra's.

But - for those who really want passing by reference - they can redefine whole Newlisp to do something like:

(set-indirect 'x <expression>) <==> (begin (set 'x 'x-indirection) (set 'x-indirection <expression>))

and then redefine *all* functions in Newlips to accept not only normal arguments, but also the symbols of the form x-indirect and make that indirection.

This is how it can be done:

(define (indirection? ix)
  (and (symbol? ix)
       (ends-with (string (eval ix)) "-indirection")))

(dolist (function-name (filter (lambda(x)(primitive? (eval x))) (symbols)))
  (letex((new-function-name (sym (append (string function-name) "-indirect")))
         (function-name function-name))
      (println "Defining " 'new-function-name " using " 'function-name "... ")

      (define (new-function-name)
           (let ((indirected-vars (filter indirection? (args))))
           (eval (append (list 'expand (append '(function-name) (args))) (map quote indirected-vars)))))))

(define (set-indirect s1 expr1)
   (let ((s1-indirection-name (sym (append (string s1) "-indirection"))))
        (set s1 s1-indirection-name)
        (set s1-indirection-name expr1)))

;-----------

(set-indirect 'L '(1 2 3 4 5))

(define (my-reverse-and-insert-zeroes z)
        (reverse-indirect z)
        (push-indirect 0 z)
        (push-indirect 0 z -1))

(my-reverse-and-insert-zeroes L)
(println-indirect "And finally ... " L) ; And finally ... (0 5 4 3 2 1 0)

(set 'M L)
(my-reverse-and-insert-zeroes M)
(println-indirect "Where is ORO? " L M) ;Where is ORO? (0 0 1 2 3 4 5 0 0)(0 0 1 2 3 4 5 0 0)

;(exit)

Don't take this code seriously, it is 15 lines written in some half of the hour. It is only proof of the concept, i.e. how Newlisp can be developed in that direction. You can say that one goes through hoops only to achieve what other languages have out of the box, but that kind of flexibility is the essence of Lisp.
Kazimir Majorinc


--------------------
Segmenti sovrapposti
--------------------

Dati n segmenti lungo l'asse X determinare quali si sovrappongono.
Un segmento è rappresentato da una lista che contine la x iniziale e la X fnale, es. (3 5).
Esempio:

(setq seg '((1 5) (6 7) (4 6) (3 4)))
  (1 5) si sovrappone con (3 4)
  (1 5) si sovrappone con (4 6)

Per ogni segmento i, controlla se si sovrappone ai segmenti i+1, i+2, ... n.
La complessità temporale di questo metodo è O(n^2).

Funzione che verifica se due intervalli si sovrappongo:

(define (overlap? i1 i2)
  (and (< (i1 0) (i2 1)) (< (i2 0) (i1 1))))

(overlap? '(1 5) '(3 7))
;-> true
(overlap? '(5 6) '(3 7))
;-> true
(overlap? '(1 4) '(4 7))
;-> nil

Funzione che verifica le sovrapposizioni tra segmenti:

(define (check ap)
  (sort ap)
  (setq len (length ap))
  (for (i 0 (- len 2))
    (for (j (+ i 1) (- len 1))
      (if (overlap? (ap i) (ap j))
          (println "overlap: " (ap i) {, } (ap j))))))

Facciamo alcune prove:

(check seg)
;-> overlap: (1 5), (3 4)
;-> overlap: (1 5), (4 6)

(setq ap '((1 5) (3 7) (2 6) (10 15) (5 6) (4 10)))
(check ap)
;-> overlap: (1 5), (2 6)
;-> overlap: (1 5), (3 7)
;-> overlap: (1 5), (4 10)
;-> overlap: (2 6), (3 7)
;-> overlap: (2 6), (4 10)
;-> overlap: (2 6), (5 6)
;-> overlap: (3 7), (4 10)
;-> overlap: (3 7), (5 6)
;-> overlap: (4 10), (5 6)

Nota: i segmenti potrebbero rappresentare degli appuntamenti (ora iniziale, ora finale).


--------------------------
Media di numeri "nascosti"
--------------------------

Tre programmatori vogliono conoscere la media dei loro stipendi, ma non sono autorizzati a condividere i loro stipendi individuali.

Soluzione
Suponiamo che gli stipendi siano X, Y e Z.
1) X aggiunge un numero casuale al suo stipendio e dice la somma a Y.
    R1 = X + rnd-X
2) Y aggiunge un numero casuale al suo stipendio alla somma detta da X e dice la nuova somma a Z.
    R2 = Y + rnd-Y + R1
3) Z aggiunge un numero casuale al suo stipendio alla somma detta da Y e dice la nuova somma a X.
    R3 = Z + rnd-Z + R2
4) X sottrae il suo numero casuale dalla somma detta da Z e comunica il nuovo numero a Y.
    R4 = R3 - rnd-X
5) Y sottrae il suo numero casuale dalla somma detta da X e comunica il nuovo numero a Z.
    R5 = R4 - rnd-Y
6) Z sottrae il suo numero casuale dalla somma detta da Y e comunica il nuovo numero.
    R6 = R5 - rnd-Z
7) Il nuovo numero è ora la somma dei tre stipendi e la media può essere calcolata dividendolo per 3.
   media = R6/3

Nessuno conosce lo stipendio degli altri, ma tutti conoscono la media.
Questo metodo può essere esteso anche a più di 3 persone.

(define (media lst)
  (setq rndX (rand 1000))
  (setq rndY (rand 1000))
  (setq rndZ (rand 1000))
  (set 'X (lst 0) 'Y (lst 1) 'Z (lst 2))
  (setq R1 (add X rndX))
  (setq R2 (add Y rndY R1))
  (setq R3 (add Z rndZ R2))
  (setq R4 (sub R3 rndX))
  (setq R5 (sub R4 rndY))
  (setq R6 (sub R5 rndZ))
  (div R6 3))

(setq lst '(100 150 110))
(media lst)
;-> 120


------------------
Chiavi e lucchetti
------------------

Dati due contenitori, uno con N chiavi e l'altro con N lucchetti, trovare tutte le coppie chiave-lucchetto che funzionano. Le chiavi e i lucchetti sono in relazione biunivoca (una chiave per ogni lucchetto e viceversa).

Possiamo rappresentare il problema con due liste di caratteri, una che rappresenta le chiavi e una che rappresenta i lucchetti. Le due liste contengono gli stessi caratteri disposti in ordine casuale.
Il risultato potrebbe essere una lista in cui ogni elemento è una sottolista che contiene il carattere, l'indice del carattere sulla prima lista (chiavi) e l'indice del carattere sulla seconda lista (lucchetti).

Per esempio:
chiavi = ("q" "f" "z")
lucchetti = ("f" "z" "q")
soluzione = (("q" (0) (2)) ("f" (1) (0)) ("z" (2) (1)))

Algoritmo:
Trovare tutti gli indici delle chiavi e creare una lista ordinata con elementi (chiave indice):
  (("f" (1)) ("q" (0)) ("z" (2)))
Trovare tutti gli indici delle chiavi e creare una lista ordinata con elementi (lucchetto indice):
  (("f" (0)) ("q" (2)) ("z" (1)))
Creare una lista con i valori uguali di chiave e lucchetto e relativi indici:
  (("f" (1) (0)) ("q" (0) (2)) ("z" (2) (1)))
Inoltre controllare se chiavi e lucchetti sono in corrispondenza biunivoca e, in caso negativo, applicare la ricerca esaustiva di ogni lucchetto per ogni chiave.

(define (index-list lst)
"Create a list of indexes for all the elements of a list"
  (ref-all nil lst (fn (x) true)))

(define (link chiavi lucchetti)
  (local (keys locks out)
    (setq out '())
    ; controlla se chiavi è lucchetti sono
    ; in corrispondenza biunivoca
    (cond ((!= (count chiavi lucchetti) (dup 1 (length chiavi) true))
            (println "Attenzione: chiavi e lucchetti non corrispondono")
            (dolist (k chiavi)
              (if (ref k lucchetti)
                  (push (list k $idx (ref k lucchetti)) out -1))))
          (true
            (setq keys (sort (map list chiavi (index-list chiavi))))
            (setq locks (sort (map list lucchetti (index-list lucchetti))))
            (setq out (map (fn(x y) (list (x 0) (x 1) (y 1))) keys locks)))
    )
    out))

Facciamo alcune prove:

(setq ch '("$" "%" "!" "/" "#" "@" "&"))
(setq lu '("%" "$" "@" "&" "#" "!" "/"))
(link ch lu)
;-> (("!" (2) (5)) ("#" (4) (4)) ("$" (0) (1)) ("%" (1) (0))
;->  ("&" (6) (3)) ("/" (3) (6)) ("@" (5) (2)))

(setq ch2 '("a" "b" "c"))
(setq lu2 '("c" "d" "a" "f"))
(link ch2 lu2)
;-> Attenzione: chiavi e lucchetti non corrispondono
;-> (("a" 0 (2)) ("c" 2 (0)))


------------------------------------------------
Golden ratio, SuperGolden ratio e Plastic number
------------------------------------------------

Golden ratio
------------
Due quantità sono in rapporto aureo (golden ratio) se il loro quoziente è uguale al rapporto tra la loro somma e la maggiore delle due quantità.
Algebricamente, con le due quantità a, b con a > b:

   a + b     a
  ------- = --- = phi
     a       b

         1 + sqrt(5)
  phi = -------------
             2

che è soluzione dell'equazione: x^2 = x + 1

L'espansione decimale di questo numero vale 1.61803398874989484820...

(define (phi) (div (add 1 (sqrt 5)) 2))

(phi)
;-> 1.618033988749895

SuperGolden ratio
-----------------
Due quantità sono in rapporto super-aureo (supergolden ratio) se il quoziente del numero maggiore diviso per quello minore è uguale a:

                     29 + 3*square(93)            29 - 3*square(93)
          1 + cubic(-------------------) + cubic(-------------------)
                             2                            2
  psi = -------------------------------------------------------------
                                      3

che è l'unica soluzione reale dell'equazione: x^3 = x^2 + 1.

L'espansione decimale di questo numero vale 1.465571231876768026656731...

(define (cubic x) (pow x (div 3)))

(define (psi)
  (div (add 1 (cubic (div (add 29 (mul 3 (sqrt 93))) 2))
              (cubic (div (sub 29 (mul 3 (sqrt 93))) 2)))
       3))

(psi)
;-> 1.465571231876768

Plastic number
--------------
Il numero plastico "ro" è una costante matematica che è l'unica soluzione reale dell'equazione cubica: x^3 = x + 1.

              9 + square(69)            9 - square(69)
  ro = cubic(----------------) + cubic(----------------)
                    18                        18

L'espansione decimale di questo numero vale 1.324717957244746025960908854...

(define (ro)
  (add (cubic (div (add 9 (sqrt 69)) 18))
       (cubic (div (sub 9 (sqrt 69)) 18))))

(ro)
;-> 1.324717957244746


----------------------
Costante di Feigenbaum
----------------------

La prima costante di Feigenbaum (le costanti di Feigenbaum sono due) è una costante universale per funzioni che si avvicinano al caos tramite il raddoppio del periodo. Fu scoperta da Feigenbaum nel 1975 mentre studiava il punto fisso della funzioni iterativa:

  f(x) = 1 - u*|x|^r,

La prima costante di Feigenbaum (le costanti di Feigenbaum sono due), è un numero che esprime il seguente concetto fisico:

"Dato un qualsiasi fenomeno fisico, di qualsiasi natura, il primo numero di Feigenbaum permette di predire quando il caos irromperà nel sistema."

L'espansione decimale di questo numero vale 4.66920160910299067185320382...

Scriviamo una funzione che calcola la prima costante di Feigenbaum:

(define (feigenbaum)
  (local (maxIt maxItJ a1 a2 d1 a d x y)
    (setq maxIt 13)
    (setq maxItJ 10)
    (setq a1 1.0)
    (setq a2 0.0)
    (setq d1 3.2)
    (for (i 2 maxIt)
      (setq a (add a1 (div (sub a1 a2) d1)))
      (for (j 1 maxItJ)
        (setq x 0.0)
        (setq y 0.0)
        (for (k 1 (<< 1 i))
          (setq y (sub 1.0 (mul 2.0 x y)))
          (setq x (sub a (mul x x)))
        )
        (setq a (sub a (div x y)))
      )
      (setq d (div (sub a1 a2) (sub a a1)))
      (println i { } d)
      (setq d1 d)
      (setq a2 a1)
      (setq a1 a)
    )
    'end))

(feigenbaum)
;-> 2 3.218511422038087
;-> 3 4.385677598568337
;-> 4 4.600949276538056
;-> 5 4.655130495391965
;-> 6 4.666111947822846
;-> 7 4.668548581451485
;-> 8 4.66906066077106
;-> 9 4.669171554514976
;-> 10 4.669195154039278
;-> 11 4.669200256503637
;-> 12 4.669200975097843
;-> 13 4.669205372040318


---------------
Numeri estetici
---------------

Un numero estetico è un numero intero positivo in cui ogni cifra adiacente differisce di 1 dalla sua vicina.
Per esempio:
- 12 è un numero estetico. 1 e 2 differiscono di 1.
- 5654 è un numero estetico. Ogni cifra è esattamente a 1 distanza dal suo vicino.
- 890 non è un numero estetico. 9 e 0 differiscono di 9.

(define (uabs a b)
  (if (> a b)
      (- a b)
      (- b a)))

Funzione che verifica se un numero è estetico:

(define (estetico? num)
  (local (out i j)
    (setq out true)
    (setq i (% num 10))
    (setq num (/ num 10))
    (while (and (> num 0) out)
      (setq j (% num 10))
      (if (!= (uabs i j) 1) (setq out nil))
      (setq num (/ num 10))
      (setq i j)
    )
    out))

(estetico? 12)
;-> true
(estetico? 5654)
;-> true
(estetico? 890)
;-> nil
(estetico? 9876543210)
;-> true
(estetico? 98765432109)
;-> nil

Sequenza OEIS: A033075
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 21, 23, 32, 34, 43, 45, 54, 56, 65,
  67, 76, 78, 87, 89, 98, 101, 121, 123, 210, 212, 232, 234, 321, 323,
  343, 345, 432, 434, 454, 456, 543, 545, 565, 567, 654, 656, 676, 678,
  765, 767, 787, 789, 876, ...

Funzione che calcola i numeri estetici in un intervallo di numeri:

(define (estetici start end)
  (let (out '())
    (for (i start end)
      (if (estetico? i) (push i out -1))
    )
    out))

(estetici 1 1000)
;-> (1 2 3 4 5 6 7 8 9 10 12 21 23 32 34 43 45 54 56 65 67 76 78 87 89
;->  98 101 121 123 210 212 232 234 321 323 343 345 432 434 454 456
;->  543 545 565 567 654 656 676 678 765 767 787 789 876 878 898 987 989)

(time (println (estetici 1e8 1.3e8)))
;-> (101010101 101010121 101010123 101012101 101012121 101012123 101012321
;->  101012323 101012343 101012345 101210101 101210121 101210123 101212101
;->  101212121 101212123 101212321 101212323 101212343 101212345 101232101
;->  101232121 101232123 101232321 101232323 101232343 101232345 101234321
;->  101234323 101234343 101234345 101234543 101234545 101234565 101234567
;->  121010101 121010121 121010123 121012101 121012121 121012123 121012321
;->  121012323 121012343 121012345 121210101 121210121 121210123 121212101
;->  121212121 121212123 121212321 121212323 121212343 121212345 121232101
;->  121232121 121232123 121232321 121232323 121232343 121232345 121234321
;->  121234323 121234343 121234345 121234543 121234545 121234565 121234567
;->  123210101 123210121 123210123 123212101 123212121 123212123 123212321
;->  123212323 123212343 123212345 123232101 123232121 123232123 123232321
;->  123232323 123232343 123232345 123234321 123234323 123234343 123234345
;->  123234543 123234545 123234565 123234567 123432101 123432121 123432123
;->  123432321 123432323 123432343 123432345 123434321 123434323 123434343
;->  123434345 123434543 123434545 123434565 123434567 123454321 123454323
;->  123454343 123454345 123454543 123454545 123454565 123454567 123456543
;->  123456545 123456565 123456567 123456765 123456767 123456787 123456789)
;-> 21134.084 ; 21 secondi circa

Vedi anche "Numeri progressivi (Stepping)" in "Note libere 19".


-------------------
Colore dei cappelli
-------------------

Ci sono 10 persone in fila, una dietro l'altra.
Ognuno indossa un cappello, che può essere bianco o nero.
Ci può essere un numero qualsiasi di cappelli bianchi o neri tra 0 e 10.
Ogni persona può vedere il cappello di tutte le persone davanti a sé nella fila, ma non quelli delle persone dietro.
Ogni persona (partendo dall'ultimo della fila) è tenuta a indovinare (ad alta voce) il colore del proprio cappello.
L'obiettivo è quello di ottenere il maggior numero possibile di ipotesi corrette.
Il gruppo può discutere e formulare una strategia prima della prova.
Trovare una strategia (la migliore se possibile).
Qual è il numero di ipotesi corrette con la strategia trovata?

Soluzione:
L'ultimo in coda, dietro a tutti, conta il numero di cappelli bianchi in testa alle 9 persone presenti davanti a lui.
Se questo numero è pari, (ad alta voce) indovina il cappello in testa come "Nero".
Se il numero è dispari, indovina come "Bianco".
La probabilità che il cappello in testa sia quello che ha indovinato è del 50%.
Non c'è modo che questa persona possa indovinare correttamente il cappello in testa.
Tuttavia, la sua ipotesi funziona come un messaggio per tutti gli altri di fronte a lui.

Supponiamo che la decima persona indovini "Nero". Ora, la persona che è nona in coda sa che il numero di cappelli bianchi sulle prime 9 persone (le 8 persone davanti a lui e se stesso) è pari.
Quindi controlla se il numero di cappelli bianchi davanti a lui è pari o dispari.
Se il numero è pari, significa che il cappello in testa è nero.
Se il numero è dispari, significa che il cappello sulla sua testa è bianco e quindi indovina il suo cappello.
Pertanto, la nona persona nella coda indovina sempre correttamente, in base al messaggio trasmesso dalla decima persona.

Una strategia simile è seguita da ogni persona che segue nella fila.
Pertanto, tutti tranne l'ultima (decima) persona indovinano di sicuro.

Questa strategia permette di indovinare il colore di 9 cappelli al 100% e il colore di 1 cappello al 50% (quello della decima persona della fila).


----------------------------------------
push all'inizio o alla fine della lista?
----------------------------------------

newLISP permette di inserire un elemento all'inizio o alla fine di una lista:

(setq lst '(a b c))

inserimento all'inizio:
(push "inizio" lst)
;-> ("inizio" a b c)

inserimento alla fine:
(push "fine" lst -1)
;-> ("inizio" a b c "fine")

Per capire quale metodo è più efficace vediamo un post di Sammo sul forum di newLISP:

---------------------
Sammo:
It seems that pushing those character indices onto the end of lists gets very, very expensive when the lists get large. The following uncommented solution (I hope you can read it) was running as slowly as yours (or even more slowly) until I tried pushing onto the front of the lists -- that is, (push value list-of-stacks stack-index 0) instead of (push value list-of-stacks stack-index -1). When I made this change, I can index the newlisp_manual.html file (455KB) in about 8 seconds -- including writing the resulting 3.2MB file to the disk.

;(set 'time-begin (time-of-day))
(define (test1)
  (set 'infile "c:/newlisp/newlisp_manual.html")
  (set 'outfile "c:/newlisp/test-coords.txt")
  (set 'orig (explode (read-file infile)))
  (set 'indiv (unique orig))
  (set 'coord (dup '() (length indiv)))
  (set 'ilist (map (fn (x) (find x indiv)) orig))
  (set 'x -1)
  (dolist (i ilist) (push (inc 'x) coord i 0))
  (save outfile 'indiv 'coord)
)
;(println (- (time-of-day) time-begin))
(time (test1))
;-> 2640.59

Pushing the character indicies onto the front of the lists is okay and doesn't need correcting later on. The only thing that matters is that each character's index get pushed onto the correct stack.

If you really want the indicies in ascending order in each stack, the following one-line modification to the above does the trick:

(define (test2)
  (set 'infile "c:/newlisp/newlisp_manual.html")
  (set 'outfile "c:/newlisp/test-coords.txt")
  (set 'orig (explode (read-file infile)))
  (set 'indiv (unique orig))
  (set 'coord (dup '() (length indiv)))
  (set 'ilist (map (fn (x) (find x indiv)) orig))
  (set 'x -1)
  (dolist (i ilist) (push (inc 'x) coord i 0))
  (set 'coord (map reverse coord))
  (save outfile 'indiv 'coord)
)

(time (test2))
;-> 2209.525

(define (tilt) (throw-error "newLISP reset"))
(tilt)
On a big file (e.g., newlisp_manual.html), reversing the stacks after populating them took about six percent more time on my WIN2K 1.4GHz laptop.

A couple of more trial runs suggests that this scales pretty well.

62KB file --> 0.75 seconds
445KB file --> 8.5 seconds
1.17MB file --> 20.8 seconds
Sammo
---------------------
---------------------
Lutz:
Sammo's solution seems to be the best, but there is one other potential bottle neck in:

(set 'ilist (map (fn (x) (find x indiv)) orig))

which is the: (find x indiv)

It doesn't matter in Norman's task because 'indiv' is such a short list. But imagine you deal with an 'indiv' with thousands of members.

This is where newLISP arrays come in handy:

; old code
; (set 'ilist (map (fn (x) (find x indiv)) orig))

; new code
(set 'ivec (array 256))
(set 'pos -1)
(dolist (i indiv) (nth-set (char i) ivec (inc 'pos)))

(set 'ilist (map (fn (x) (nth (char x) ivec)) orig))

This builds an array vector where each character is at the position of its value. So at "A" index 65 you have the index position of "A" in indiv.

Now the sequential (find x indiv) is replaced with (nth (char x) ivec) which does random access.

This method worth doing it in situations with very long indexing vectors.
Lutz
---------------------
---------------------
Norman:
Should I use 'index above 'find or always switch to 'array's when it comes
to performance and what will 'map do on performace ?
Norman
---------------------
---------------------
Lutz:
'map' is pretty good performance wise, because it goes sequentially thru the list one by one, so 'map' will always scale well. The problem with 'find' is that it searches sequentially, so if the list is very long it becomes an issue.

I would use 'index' only if you are really interested to get various positions back in a list. But that was not the case in your riddle, because every letter occured only once in the individual vector and 'find' returns as soon as it found one. 'index' keeps on searching hoping to find more until the end of the list.

The array versus list issue is difficult to decide. In your riddle it did not make a real difference and Sam's pure list code was much shorter. I always start coding as a list and only goto arrays when time seems to get a problem. As a thumb rule I would say when the list doesn't exceed a few hundred elements its not worth thinking about arrays. But then again in an individual case things may be different.

Lists are very good when going thru it sequentially (like map), but as soon as you have to jump around in it randomly it can get a problem.

When you are using 'nth-set' or 'set-nth' be also aware of the difference between the two. 'nth-set' is much faster becuase it doesn't need to return the whole list or array.
Lutz

Nota: "push" può essere usato anche su un simbolo non esistente:

(push "1" lista)
;-> ("1")
lista
;-> ("1")


---------------
Funzione "itoa"
---------------

La funzione "itoa" converte un intero (anche negativo) in una stringa (null terminated). La definizione standard della funzione itoa è la seguente:

  char* itoa(int num, char* buffer, int base)

Il parametro "base" specifica la base di conversione.
Se la base è 10 e il valore è negativo, allora la stringa risultante è preceduta da un segno meno (-). Con qualsiasi altra base, il valore è sempre considerato senza segno (unsigned).

Scriviamo la funzione:

(define (itoa num base)
  (local (str negative rem)
    (setq str "")
    (setq negative nil)
    (if (< num 0)
      (begin
        (setq negative true)
        (setq num (- num)))
    )
    (cond ((zero? num) (setq str "0"))
          (true
            (while (!= num 0)
              (setq rem (% num base))
              (if (> rem 9)
                  (push (char (+ 97 (- rem 10))) str)
                  (push (char (+ 48 rem)) str)
              )
              (setq num (/ num base))
            ))
    )
    (if negative (push "-" str))
    str))

Facciamo alcune prove:

(itoa 1567 10)
;-> "1567"
(itoa -1567 10)
;-> "-1567"
(itoa -1567 16)
;-> "-61f"
(itoa 1567 2)
;-> "11000011111"
(itoa -1567 8)
;-> "-3037"
(itoa 7a1 10)
;-> ERR: value expected in function % : base
;-> called from user function (itoa 7 a1 10)
(itoa abc 10)
;-> ERR: value expected in function - : nil
;-> called from user function (itoa abc 10)


-----------------
Medie statistiche
-----------------

Funzioni per il calcolo di varie medie statistiche di una lista di numeri.

  L = (x1, x2,..., xn)

(setq st '(1 2 4 2 1 6 7 8 4 5 6 8 9 2 3 4 5 6 3 2 6 5 7 2 7 2 8 5 2 3))

Media Aritmetica
----------------

                      x1 + x2 +...+ xn
  Media-Aritmetica = ------------------
                             n

(define (media-aritmetica lst)
  (div (apply add lst) (length lst)))

(media-aritmetica st)
;-> 4.5
(media-aritmetica '(0 0 3 1 4 1 5 9 0 0))
;-> 2.3
(media-aritmetica (sequence 1 10))
;-> 5.5

Media Geometrica
----------------

  Media-Geometrica = nth-root(x1*x2*...*xn)

(define (media-geometrica lst)
  (pow (apply mul lst) (div (length lst))))

(media-geometrica st)
;-> 3.81711148049494
(media-geometrica '(0 0 3 1 4 1 5 9 0 0))
;-> 0
(media-geometrica (sequence 1 10))
;-> 4.528728688116765

Media Armonica
--------------

                              n
  Media-Armonica = -------------------------
                    (1/x1 + 1/x2 +...+ 1/n)

(define (media-armonica lst)
  (let (sum-rec 0)
    (dolist (x lst)
      (setq sum-rec (add sum-rec (div x)))
    )
    (div (length lst) sum-rec)))

(media-armonica st)
;-> 3.114828396028181
(media-armonica '(0 0 3 1 4 1 5 9 0 0))
;-> 0
(media-armonica (sequence 1 10))
;-> 3.414171521474055

Radice quadrata media
---------------------
La radice quadrata media (RMS Root Mean Square) è la radice quadrata della media aritmetica dei quadrati dei numeri.

                                x1^2 + x2^2 +...+ xn^2
  Radice-Quadrata-Media = sqrt(------------------------)
                                          n

(define (rms lst)
  (sqrt(div (apply add (map (fn(x) (mul x x)) lst)) (length lst))))

(rms st)
;-> 5.062937223917884
(rms '(0 0 3 1 4 1 5 9 0 0))
;-> 3.646916505762094
(rms (sequence 1 10))
;-> 6.204836822995429

Mediana
-------
La mediana di una lista finita di numeri è il numero che si trova "in mezzo ", quando i numeri sono ordinati dal più piccolo al più grande (ordine crescente).

             x[(n+1)/2],                 se n è pari
  Mediana =
             (x[(n/2)] + x[(n/2+1)])/2,  se n è dispari

(define (mediana lst)
  (let (mid (/ (length lst) 2))
    (sort lst)
    (if (even? (length lst))
        (div (add (lst mid) (lst (- mid 1))) 2)
        ;else
        (lst mid))))

(mediana st)
;-> 4.5
(mediana '(0 0 3 1 4 1 5 9 0 0))
;-> 1
(mediana (sequence 1 10))
;-> 5.5
(mediana '(4.1 5.6 7.2 1.7 9.3 4.4 3.2))
;-> 4.4
(mediana '(4.1 7.2 1.7 9.3 4.4 3.2))
;-> 4.25

Moda
----
La moda è il valore/numero che appare più spesso nella lista di numeri.

(define (moda lst)
  (letn ((uniq (unique lst))
        (conta (count uniq lst)))
    (uniq (find (apply max conta) conta))))

(moda st)
;-> 2
(moda '(0 0 3 1 4 1 5 9 0 0))
;-> 0
(moda (sequence 1 10))
;-> 1
(moda '(4.1 5.6 7.2 1.7 9.3 4.4 3.2))
;-> 4.1
(moda '(4.1 7.2 1.7 9.3 4.4 3.2 7.2))
;-> 7.2

Nota: potremmo scrivere la funzione "moda" utilizzando una hash-map per renderla più veloce.

Conteggio
---------
La funzione "conteggio" restituisce una lista ordinata di coppie che hanno la seguente struttura:

- (val(i) (conta(i)), se il parametro "ordered" vale nil
  in questo caso la lista è ordinata per valori crescenti di val(i))

- (conta(i) val(i)), se il parametro "ordered" vale true
  in questo caso la lista è ordinata per valori crescenti di conta(i))

dove: val(i) è il valore dell'i-esimo numero
      conta(i) è il numero di occorrenze dell'i-esimo numero

(define (conteggio lst ordered)
  (local (uniq conta out)
    (setq uniq (unique lst))
    (setq conta (count uniq lst))
    (if ordered
      (sort (map list conta uniq))
      (sort (map list uniq conta)))))

(conteggio '(3 1 1 1 1 0 0 1 1 4 1 1 2 2 3))
;-> ((0 2) (1 8) (2 2) (3 2) (4 1))
(conteggio '(3 1 1 1 1 0 0 1 1 4 1 1 2 2 3) true)
;-> ((1 4) (2 0) (2 2) (2 3) (8 1))

(conteggio st)
;-> ((1 2) (2 7) (3 3) (4 3) (5 4) (6 4) (7 3) (8 3) (9 1))
(conteggio st true)
;-> ((1 9) (2 1) (3 3) (3 4) (3 7) (3 8) (4 5) (4 6) (7 2))


-----------------------------
Numeri duffiniani (Duffinian)
-----------------------------

Un numero duffiniano è un numero composto n che è relativamente primo a sigma(n).
Il sigma(n) è la somma di tutti i divisori di n.

Esempio: 161 è un numero duffiniano perchè è composito (7 × 23) e sigma(n) = 192 (1 + 7 + 23 + 161) è relativamente primo a 161.

I numeri duffiniani sono molto comuni.
Non è raro che due interi consecutivi siano duffiniani (un gemello duffiniano): (8, 9), (35, 36), (49, 50), ecc.
Meno comuni sono le terne duffinane (tre numeri duffiniani consecutivi: (63, 64, 65), (323, 324, 325), ecc.
Molto, molto meno comuni sono le quadruple e le quintuple duffiniane.
La prima quintupla duffiniana è (202605639573839041, 202605639573839042, 202605639573839043, 202605639573839044, 202605639573839045).
Non è possibile avere sei numeri duffiniani consecutivi.

Sequenza OEIS: A003624
  4, 8, 9, 16, 21, 25, 27, 32, 35, 36, 39, 49, 50, 55, 57, 63, 64, 65,
  75, 77, 81, 85, 93, 98, 100, 111, 115, 119, 121, 125, 128, 129, 133,
  143, 144, 155, 161, 169, 171, 175, 183, 185, 187, 189, 201, 203, 205,
  209, 215, 217, 219, 221, 225, 235, 237, 242, 243, 245, 247, ...

(define (factor-group num)
"Factorize an integer number"
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

(define (divisors-sum num)
"Sum all the divisors of integer number"
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
            (setq out (* out sum)))))))

Funzione che verifica se un numero è duffiniano:

(define (duffinian? num)
  ; calcola la somma di tutti i divisori del numero
  (let (sumdiv (divisors-sum num))
        ; se il numero è primo non è duffinian
    (if (= sumdiv (+ num 1))
        nil
        ; else
        ; se num e sumdiv sono relativamente primi tra loro (coprimi),
        ; allora il numero è Duffinian
        (= (gcd num sumdiv) 1))))

(duffinian? 161)
;-> true

(filter duffinian? (sequence 2 100))
;-> (4 8 9 16 21 25 27 32 35 36 39 49 50 55 57 63 64 65 75 77 81 85 93 98 100)

(map duffinian? (sequence 2 100))
;-> (nil nil true nil nil nil true true nil nil nil nil nil nil true nil
;->  nil nil nil true nil nil nil true nil true nil nil nil nil true nil
;->  nil true true nil nil true nil nil nil nil nil nil nil nil nil true
;->  true nil nil nil nil true nil true nil nil nil nil nil true true
;->  true nil nil nil nil nil nil nil nil nil true nil true nil nil nil
;->  true nil nil nil true nil nil nil nil nil nil nil true nil nil nil
;->  nil true nil true)

(time (filter duffinian? (sequence 1 100000)))
;-> 277.258
(time (map duffinian? (sequence 1 100000)))
;-> 257.34

Funzione che calcola le coppie di numeri consecutivi duffiniani fino ad un dato numero:

(define (duffi-pair limit)
  (local (out duff-curr duff-next)
    (setq out '())
    ; (duffinian? 2) is nil
    (setq duff-curr nil)
    (for (i 2 limit)
      (setq duff-next (duffinian? (+ i 1)))
      (if (and duff-curr duff-next)
          (push (list i (+ i 1)) out -1)
      )
      ; aggiorna il valore del numero da considerare
      ; per la prossima iterazione
      (setq duff-curr duff-next)
    )
    out))

(duffi-pair 100)
;-> ((8 9) (35 36) (49 50) (63 64) (64 65))

(length (duffi-pair 1e6))
;-> 713
(time (duffi-pair 1e6))
;-> 3088.713

Funzione che calcola le triple di numeri consecutivi duffiniani fino ad un dato numero:

(define (duffi-triplet limit)
  (local (out duff-prev duff-curr duff-next)
    (setq out '())
    ; (duffinian? 2) is nil
    (setq duff-prev nil)
    ; (duffinian? 3) is nil
    (setq duff-curr nil)
    (for (i 3 limit)
      (setq duff-next (duffinian? (+ i 1)))
      (if (and duff-prev duff-curr duff-next)
          (push (list (- i 1) i (+ i 1)) out -1)
      )
      ; aggiorna i valori dei numeri da considerare
      ; per la prossima iterazione
      (setq duff-prev duff-curr)
      (setq duff-curr duff-next)
    )
    out))

(duffi-triplet 100)
;-> ((63 64 65))

(length (duffi-triplet 1e6))
;-> 131
(time (duffi-triplet 1e6))
;-> 3110.684

(duffi-triplet 10000)
;-> ((63 64 65) (323 324 325) (511 512 513) (721 722 723) (899 900 901)
;->  (1443 1444 1445) (2303 2304 2305) (2449 2450 2451) (3599 3600 3601)
;->  (3871 3872 3873) (5183 5184 5185) (5617 5618 5619) (6049 6050 6051)
;->  (6399 6400 6401) (8449 8450 8451))

Funzione che calcola le quadruple di numeri consecutivi duffiniani fino ad un dato numero:

(define (duffi-quadruplet limit)
  (local (out d1 d2 d3 d4 )
    (setq out '())
    ; (duffinian? 2) is nil
    (setq d1 nil)
    ; (duffinian? 3) is nil
    (setq d2 nil)
    ; (duffinian? 4) is true
    (setq d3 true)
    (for (i 4 limit)
      (setq d4 (duffinian? (+ i 1)))
      (if (and d1 d2 d3 d4)
          (push (list (- i 2) (- i 1) i (+ i 1)) out -1)
      )
      ; aggiorna i valori dei numeri da considerare
      ; per la prossima iterazione
      (setq d1 d2)
      (setq d2 d3)
      (setq d3 d4)
    )
    out))

(time (println (duffi-quadruplet 1e8)))
;-> ()
;-> 673358.296

Fino a 100 milioni (fino a 1e8 non esistono quadruple duffiniane).
Cerchiamo ancora:

(define (duffi-quadruplets start end)
  (local (out d1 d2 d3 d4)
    (setq out '())
    (setq d1 (duffinian? (- start 2)))
    (setq d2 (duffinian? (- start 1)))
    (setq d3 (duffinian? start))
    (for (i start end)
      (setq d4 (duffinian? (+ i 1)))
      (if (and d1 d2 d3 d4)
        (begin
          (push (list (- i 2) (- i 1) i (+ i 1)) out -1)
          (println (list (- i 2) (- i 1) i (+ i 1))))
      )
      ; aggiorna i valori dei numeri da considerare
      ; per la prossima iterazione
      (setq d1 d2)
      (setq d2 d3)
      (setq d3 d4)
    )
    out))

(time (println (duffi-quadruplets 1e8 1e9)))
;-> ()
;-> 12853470.987 circa 214 minuti

Questo algoritmo non è adatto per trovare quadruple duffiniane.


-------------------
Numeri equidigitali
-------------------

Un numero n si dice equidigitale se il numero di cifre nella fattorizzazione di n (incluse le potenze) è uguale al numero di cifre in n.
Ad esempio 16 è un numero equidigitale poiché la sua fattorizzazione primi è 2^4 e la sua fattorizzazione primi ha un totale di due cifre (2 e 4) che è uguale al numero di cifre di 16.
Come altro esempio, 128 non è un equidigitale, infatti la sua fattorizzazione vale è 2^7 e ha un totale di 2 cifre (2 e 7), ma il numero ha 3 cifre.
Tutti i numeri primi sono equidigitali.

Sequenza OEIS: A046758
  1, 2, 3, 5, 7, 10, 11, 13, 14, 15, 16, 17, 19, 21, 23, 25, 27, 29, 31,
  32, 35, 37, 41, 43, 47, 49, 53, 59, 61, 64, 67, 71, 73, 79, 81, 83, 89,
  97, 101, 103, 105, 106, 107, 109, 111, 112, 113, 115, 118, 119, 121,
  122, 123, 127, 129, 131, 133, 134, 135, 137, 139, ...

(define (equidigital? num)
  ; 1 è equidigitale
  (if (= num 1) true
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (cond ((= (length lst) 1) true)
              (true
                ; raggruppa i fattori di (factor num)
                ; es. (factor 153) --> (3 3 17)
                ; (3 3 17) --> ((3 2) (17))
                (dolist (el lst)
                  (if (= el cur-val) (++ cur-count)
                      (begin
                        (if (= 1 cur-count)
                            (push (list cur-val) out -1)
                            (push (list cur-val cur-count) out -1)
                        )
                        (setq cur-count 1 cur-val el))
                   )
                )
                (if (= 1 cur-count)
                    (push (list cur-val) out -1)
                    (push (list cur-val cur-count) out -1)
                )
                ; test numero equidigitale
                (= (length num) (apply + (map length (flat out)))))
         )
       )
  )
)

(filter equidigital? (sequence 1 140))
;-> (1 2 3 5 7 10 11 13 14 15 16 17 19 21 23 25 27 29 31 32 35 37 41 43 47
;->  49 53 59 61 64 67 71 73 79 81 83 89 97 101 103 105 106 107 109 111 112
;->  113 115 118 119 121 122 123 127 129 131 133 134 135 137 139)


---------------------------------------------
Costante di Eulero-Mascheroni 0.5772156649...
---------------------------------------------

Scoperta da Leonhard Euler intorno al 1730, è la costante matematica più onnipresente dopo pi ed e, ma appare più arcana di queste.

Viene chiamata gamma e misura quanto le somme parziali della serie armonica (la più semplice serie divergente) differiscono dalla funzione logaritmica (il suo integrale approssimativo):

  lim[1 + 1/2 + 1/3 + ... + 1/n − log(n)] = lim[Hn - log(n)]
  n->inf                                    n->inf

La costante gamma vale:

 0.57721 56649 01532 86060 65120 90082 40243 10421 59335 93992 35988...

La definizione di gamma converge troppo lentamente per essere numericamente utile, ma nel 1735 Eulero applicò la sua formula di somma recentemente scoperta per calcolare gamma con una precisione di 15 cifre.
Per un'implementazione a precisione singola questo è ancora l'algoritmo più economico.

Vediamo cinque metodi per calcolare gamma in singola precisione.

Metodo 1
--------

(define (eu01)
  (local (n h a)
    (println "From the definition, err. 3e-10")
    (setq n 400)
    (setq h 1)
    (for (k 2 n)
      (setq h (add h (div k)))
    )
    ; faster convergence: Negoi, 1997
    (setq a (log (add n 0.5 (div (mul 24 n)))))
    (println "Hn = " h)
    (println "gamma = " (sub h a))
    (println "k = " n)))

(eu01)
;-> From the definition, err. 3e-10
;-> Hn = 6.569929691176506
;-> gamma = 0.5772156645765731
;-> k = 400

Metodo 2
--------

(define (eu02)
  (local (n s r k eps)
    (println "Sweeney, 1963, err. idem");
    (setq eps 1e-6)
    (setq n 21)
    (setq s (list 0 n))
    (setq r n)
    (setq k 1)
    (do-while (> r eps)
      (++ k)
      (setq r (mul r (div n k)))
      (if (even? k)
        (setf (s 0) (add (s 0) (div r k)))
        ;else
        (setf (s 1) (add (s 1) (div r k)))
      )
      ;(setf (s (& k 1)) (add (s (& k 1)) (div r k)))
    )
    (println "gamma = " (sub (s 1) (s 0) (log n)))
    (println "k = " k)))

(eu02)
;-> Sweeney, 1963, err. idem
;-> gamma = 0.5772156645636311
;-> k = 68

Metodo 3
--------

(define (eu03)
  (local (n a b h n2 r k eps)
    (println "Bailey, 1988");
    (setq eps 1e-6)
    (setq n 5)
    (setq a 1)
    (setq h 1)
    (setq n2 (pow 2 n))
    (setq r 1)
    (setq k 1)
    (do-while (> (abs (sub b a)) eps)
      (++ k)
      (setq r (mul r (div n2 k)))
      (setq h (add h (div k)))
      (setq b a)
      (setq a (add a (mul r h)))
    )
    (setq a (mul a (div n2 (exp n2))))
    (println "gamma = " (sub a (mul n (log 2))))
    (println "k = " k)))

(eu03)
;-> Bailey, 1988
;-> gamma = 0.5772156649015341
;-> k = 89

Metodo 4
--------

(define (eu04)
  (local (n a b u v n2 k2 k eps)
    (println "Brent-McMillan, 1980");
    (setq eps 1e-6)
    (setq n 13)
    (setq a (sub (log n)))
    ;(println "a = " a)
    (setq b 1)
    (setq u a)
    (setq v b)
    (setq n2 (mul n n))
    (setq k2 0)
    (setq k 0)
    (do-while (> (abs a) eps)
      (setq k2 (add k2 (mul 2 k) 1))
      (++ k)
      (setq a (mul a (div n2 k)))
      (setq b (mul b (div n2 k2)))
      (setq a (div (add a b) k))
      (setq u (add u a))
      (setq v (add v b))
    )
    (println "gamma = " (div u v))
    (println "k = " k)))

(eu04)
;-> Brent-McMillan, 1980
;-> gamma = 0.5772156649015329
;-> k = 40

Metodo 5
--------

(define (eu05)
  (local (B2 m n h a n2 r)
  (println "How Euler did it in 1735")
  ; Bernoulli numbers with even indices
  (setq B2 (list 1.0 (div 6) (div -1 30) (div 42) (div -1 30)
                 (div 5 66) (div -691 2730) (div 7 6)
                 (div -3617 510) (div 43867 798)))
  (setq m 7)
  (if (> m 9) (println "ERROR"))
  (setq n 10)
  ; n-th harmonic number
  (setq h 1)
  (for (k 2 n)
    (setq h (add h (div k)))
  )
  (println "Hn = " h)
  (setq h (sub h (log n)))
  (println "ln = " h)
  ; expansion C = -digamma(1)
  (setq a (sub (div (mul 2 n))))
  (setq n2 (mul n n))
  (setq r 1)
  (for (k 1 m)
    (setq r (mul r n2))
    (setq a (add a (div (B2 k) (mul 2 k r))))
  )
  (println "err = " a)
  (println "gamma = " (add h a))
  (println "k = " (add n m))
  (println "C  =  0.57721566490153286...")))

(eu05)
;-> How Euler did it in 1735
;-> Hn = 2.928968253968254
;-> ln = 0.6263831609742079
;-> err = -0.04916749607267539
;-> gamma = 0.5772156649015325
;-> k = 17
;-> C  =  0.57721566490153286...


-----------------------------
Stampare un testo molto lungo
-----------------------------

Per stampare un testo molto lungo basta racchiuderlo nel tag "[text] [/text]".

(print [text]
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
[/text])
;-> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
;-> Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
;-> Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
;-> Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


----------------
Flip matrix game
----------------

Data una matrice quadrata N×N di 0 e 1 (configurazione iniziale) e un'altra una matrice quadrata N×N di 0 e 1 (configurazione finale).
Il gioco consiste nel trasformare la configurazione iniziale nella configurazione finale nel minor numero di mosse possibile, invertendo tutti i valori di intere righe o intere colonne (per ogni mossa).
L'operazione di inversione consiste nel trasformare 0 in 1 e 1 in 0 per quell'intera riga o colonna.
Il gioco crea in modo casuale una configurazione iniziale e una configurazione finale.

Bisogna assicurarsi che:
1) la posizione di partenza sia diversa dalla posizione finale
2) la posizione finale deve essere raggiungibile dalla posizione di partenza.
Per risolvere questo problema partiamo da una posizione finale casuale e generiamo la posizione di partenza con lanci casuali partendo da una posizione finale casuale.
Questo metodo ci permette anche di definire una specie di "difficoltà" del gioco: più lanci casuali usiamo per creare la posizione di partenza iniziando da quella finale e maggiore dovrebbe essere la difficoltà di risolvere il gioco.

Funzione che stampa la matrice:

(define (print-matrix matrix)
  (local (row col)
    ;(if (array? matrix) (setq matrix (array-list matrix)))
    (setq row (length matrix))
    (setq col (length (first matrix)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print " " (matrix i j) " ")
      )
      (println))))

Funzione che "flippa" una riga della matrice:

(define (flip-row matrix row)
  (for (c 0 (- (length (matrix 0)) 1))
    (setf (matrix row c) (^ (matrix row c) 1)))
  matrix)

Funzione che "flippa" una colonna della matrice:

(define (flip-col matrix col)
  (for (r 0 (- (length matrix) 1))
    (setf (matrix r col) (^ (matrix r col) 1)))
  matrix)

Funzione che gestisce il gioco "flip-matrix":

(define (flip-game N level)
  (local (m e move row col a b num-moves)
    (setq row N)
    (setq col N)
    ; matrice finale
    (setq e (array N N (rand 2 (mul N N))))
    ; matrice di partenza
    (setq m e)
    ; generazione della matrice di partenza
    ; con flip casuali della matrice finale.
    ; "level" è il numero di flip effettuati
    (while (= m e)
      (for (i 1 level)
        ; flip di riga o colonna casuali
        (if (zero? (rand 2))
            (setq m (flip-row m (rand row)))
            (setq m (flip-col m (rand col)))
        )
      )
    )
    (setq num-moves 0)
    ; start game...
    (while (!= m e)
      (println "Target Matrix:")
      (print-matrix e)
      (println "Current Matrix:")
      (print-matrix m)
      ; gestione input utente
      (setq move (get-move row col))
      ; trasform matrix...
      (setq a (move 0)) ; "r" or "c"
      (setq b (int (move 1))) ; row number or column number
      (if (= a "r") (setq m (flip-row m b)))
      (if (= a "c") (setq m (flip-col m b)))
      ; update number of moves
      (++ num-moves)
      (println "\nMove: " num-moves)
    )
    ; end game
    (println "Target Matrix:")
    (print-matrix e)
    (println "Current Matrix:")
    (print-matrix m)
    (println "Solved !!!")
    'game-over))

Funzione che gestisce l'input utente:
; input = "ab"
; where: 'a' must be "r" or "c"
;        'b' must be a number (string) lesser than rows or columns
; ex. "r1" or "c2" or "c0" ...
(define (get-move row col)
  (local (ask val ch num)
    (setq ask true)
    (while ask
      (setq ask nil)
      (print "row or col to flip (ex. r0)? ")
      (setq val (read-line))
            ; almeno due caratteri
      (cond ((< (length val) 2)
              (setq ask true))
            ; il promo carattere deve essere "r" o "c"
            ((and (!= "r" (val 0)) (!= "c" (val 0)))
              (setq ask true))
            ; il secondo carattere deve essere un intero
            ((not (integer? (int (val 1))))
              (setq ask true))
            ; il numero intero deve essere "dentro" la matrice
            (true
              (setq num (int (val 1)))
              (setq ch (val 0))
              (if (or (and (= ch "r") (>= num row))
                      (and (= ch "c") (>= num col)))
                  (setq ask true)))
      )
   )
   (list (val 0) (val 1))))

Facciamo una partita molto semplice:

(flip-game 3 1)
;-> Target Matrix:
;->  0  1  0
;->  1  1  0
;->  0  1  1
;-> Current Matrix:
;->  1  1  0
;->  0  1  0
;->  1  1  1
;-> row or col to flip (ex. r0)? c2
;->
;-> Move: 1
;-> Target Matrix:
;->  0  1  0
;->  1  1  0
;->  0  1  1
;-> Current Matrix:
;->  1  1  1
;->  0  1  1
;->  1  1  0
;-> row or col to flip (ex. r0)? r1
;->
;-> Move: 2
;-> Target Matrix:
;->  0  1  0
;->  1  1  0
;->  0  1  1
;-> Current Matrix:
;->  1  1  1
;->  1  0  0
;->  1  1  0
;-> row or col to flip (ex. r0)? r1
;->
;-> Move: 3
;-> Target Matrix:
;->  0  1  0
;->  1  1  0
;->  0  1  1
;-> Current Matrix:
;->  1  1  1
;->  0  1  1
;->  1  1  0
;-> row or col to flip (ex. r0)? c2
;->
;-> Move: 4
;-> Target Matrix:
;->  0  1  0
;->  1  1  0
;->  0  1  1
;-> Current Matrix:
;->  1  1  0
;->  0  1  0
;->  1  1  1
;-> row or col to flip (ex. r0)? c0
;->
;-> Move: 5
;-> Target Matrix:
;->  0  1  0
;->  1  1  0
;->  0  1  1
;-> Current Matrix:
;->  0  1  0
;->  1  1  0
;->  0  1  1
;-> Solved !!!
;-> game-over

Test variabili libere:

(free-vars)
;-> nil


-------------------
Entropia di Shannon
-------------------

Data una stringa X di N caratteri che contiene d caratteri distinti, l'entropia di Shannon di X vale:

          n   count(i)          count(i)
  H(X) = -∑ (----------)*(log2(----------))
         i=1     N                 N

Lista dei caratteri:
(setq x (explode "1223334444"))
;-> ("1" "2" "2" "3" "3" "3" "4" "4" "4" "4")
Lunghezza della lista/parola:
(setq len (length x))
;-> 10
Caratteri unici della lista/parola:
(setq u (unique x))
;-> ("1" "2" "3" "4")
Conteggio dei caratteri unici nella list/parola:
(setq c (count u x))
;-> (1 2 3 4)
Applicazione della formula dell'entropia:
(sub (apply add (map (fn(x) (mul (div x len) (log (div x len) 2))) c)))
;-> 1.846439344671015

Scriviamo la funzione:

(define (shannon-entropy str)
  (local (x len u c)
    (setq x (explode str))
    (setq len (length x))
    (setq u (unique x))
    (setq c (count u x))
    (sub (apply add (map (fn(x) (mul (div x len) (log (div x len) 2))) c)))))

(shannon-entropy "1223334444")
;-> 1.846439344671015

(shannon-entropy "newlisp")
;-> 2.807354922057605
(shannon-entropy "haskell")
;-> 2.521640636343319
(shannon-entropy "julia")
;-> 2.321928094887362
(shannon-entropy "lisp")
;-> 2
(shannon-entropy "c++")
;-> 0.9182958340544896
(shannon-entropy "c")
;-> 0


------------------
Triangolo di Floyd
------------------

Il triangolo di Floyd elenca i numeri naturali in un triangolo rettangolo allineato a sinistra dove:

- la prima riga è 1
- le righe successive iniziano verso sinistra con il numero successivo seguito da numeri naturali successivi che elencano un numero in più rispetto alla riga sopra.

Le prime righe di un triangolo di Floyd si presentano così:

  1
  2  3
  4  5  6
  7  8  9 10
 11 12 13 14 15

(define (pad-string str ch len left)
"Pad a string to a predefinite length with a predefinite char"
  (local (out len-str)
    (setq out "")
    (setq len-str (length str))
    (cond ((zero? len-str) (setq out (dup ch len)))
          ((= len-str len) (setq out str))
          ((> len-str len) (setq out (slice str 0 len)))
          ((< len-str len)
           (if left
               (setq out (push (dup ch (- len len-str)) str))
               (setq out (push (dup ch (- len len-str)) str -1)))))))

(pad-string (string 12) " " 3 true)
;->" 12"

(pad-string (string 123) " " 4 true)
;-> " 123"

Funzione che calcola il numero massimo di un dato numero di righe:

(define (max-num rows)
  (div (mul rows (+ rows 1)) 2))

(max-num 14)
;-> 105

Funzione che stampa il triangolo di Floyd con un dato numero di righe:

(define (floyd rows)
  (local (len val)
    ; lunghezza del numero massimo
    (setq len (+ (length (max-num rows)) 1))
    ; valore da stampare
    (setq val 1)
    ; ciclo per ogni riga
    (for (r 1 rows)
      ; stampa dei valori per la riga corrente
      (for (i 1 r)
        ; formattazione valore
        (if (= i 1)
          (print (pad-string (string val) " " (- len 1) true))
          ;else
          (print (pad-string (string val) " " len true))
        )
        (++ val)
      )
      (println)
    )))

Facciamo alcune prove:

(floyd 3)
;-> 1
;-> 2 3
;-> 4 5 6

(floyd 10)
;->  1
;->  2  3
;->  4  5  6
;->  7  8  9 10
;-> 11 12 13 14 15
;-> 16 17 18 19 20 21
;-> 22 23 24 25 26 27 28
;-> 29 30 31 32 33 34 35 36
;-> 37 38 39 40 41 42 43 44 45
;-> 46 47 48 49 50 51 52 53 54 55

(floyd 14)
;->   1
;->   2   3
;->   4   5   6
;->   7   8   9  10
;->  11  12  13  14  15
;->  16  17  18  19  20  21
;->  22  23  24  25  26  27  28
;->  29  30  31  32  33  34  35  36
;->  37  38  39  40  41  42  43  44  45
;->  46  47  48  49  50  51  52  53  54  55
;->  56  57  58  59  60  61  62  63  64  65  66
;->  67  68  69  70  71  72  73  74  75  76  77  78
;->  79  80  81  82  83  84  85  86  87  88  89  90  91
;->  92  93  94  95  96  97  98  99 100 101 102 103 104 105


------------------
Problema algebrico
------------------

Trovare il valore di x + y sapendo che x e y sono interi positivi e soddisfano la seguente equazione:

  x + xy + y = 54

Soluzione
---------
Raccogliamo la x:

  x + xy + y = 54  -->  x(y + 1) + y = 54

Aggiungiamo 1 ad entrambi i membri dell'equazione:

  x(y + 1) + y = 54  -->  x(y + 1) + y + 1 = 55

Raccogliamo (y + 1):

  x(y + 1) + y + 1 = 55  -->  (x + 1)(y + 1) = 55

L'equazione (x + 1)(y + 1) = 55 ci dice che 55 è dato dal prodotto di due numeri (x + 1) e (y + 1).
Elenchiamo tutte le coppie di numeri che producono 55:

  1 * 55 = 55
  55 * 1 = 55
  11 * 5 = 55
  5 * 11 = 55

Poichè x e y sono numeri interi positivi il loro valore minimo vale 1, quindi risulta:

  (x + 1) >= 2 e
  (y + 1) >= 2

Queste due condizioni permettono di eliminare le prime due coppie che producono 55, cioè 1*55 e 55*1.
Rimangono da considerare le seguenti equazioni:

  (x + 1) = 11
  (y + 1) = 5

e

  (x + 1) = 5
  (y + 1) = 11

Nel primo caso la soluzione vale x = 10 e y = 4.
Nel secondo caso la soluzione vale x = 4 e y = 10.

In entrambi i casi risulta: (x + y) = 14

In newLISP:

(define (solve limit)
  (for (x 1 limit)
    (for (y 1 limit)
      (if (= (+ x (mul x y) y) 54)
          (println "x = " x ", y = " y ", (x + y) = " (+ x y))))))

(solve 100)
;-> x = 4, y = 10, (x + y) = 14
;-> x = 10, y = 4, (x + y) = 14


------------------
Horizontal sundial
------------------

Creare un programma che calcoli l'ora, l'angolo dell'ora solare, l'angolo della linea dell'ora di composizione dalle 6:00 alle 18:00 per una posizione determinata.
Ad esempio, latitudine = 4°57'S,
            longitudine = 150°30'W,
            Meridiano legale = 150°W.

Nota: il "meridiano" è approssimativamente lo stesso concetto di "longitudine" - la distinzione è che il meridiano viene utilizzato per determinare quando è "mezzogiorno" per scopi ufficiali. Questo sarà in genere leggermente diverso da quando il sole appare nella sua posizione più alta, a causa della struttura dei fusi orari. Per la maggior parte dei fusi orari (tranne quei fusi orari con l'ora zero centrata su Greenwich), il meridiano legale sarà un multiplo pari di 15 gradi).

(define (deg60-deg10 degs mins secs)
"Convert sexagesimal degrees to decimal degrees"
  (local (dd)
    (if (< 0.0 degs)
        (setq dd (add degs (div mins 60.0) (div secs 3600.0)))
        (setq dd (add degs (- 0.0 (div mins 60.0)) (- 0.0 (div secs 3600.0))))
    )
    dd))

(deg60-deg10 21 31 21)
;-> 21.5225
(deg60-deg10 11 42 21)
;-> 11.70583333333333

(define (sign x)
"Return the sign of a real number"
  (cond ((> x 0) 1)
        ((< x 0) -1)
        (true 0)))

(setq PI 3.1415926535897931)

(define (deg2rad deg) (div (mul deg (atan 1)) 45))
(deg2rad 180)
;-> 3.141592653589793

(define (rad2deg rad) (div (mul rad 45) (atan 1)))
(rad2deg 3.141592653589793)
;-> 180

(define (deg-rad deg)
"Convert decimal degrees to radiants"
  (div (mul deg PI) 180))

(define (rad-deg rad)
"Convert radiants to decimal degrees"
  (div (mul rad 180) PI))

Funzione finale:

(define (sundial lat lon mer)
  (local (hla hra slat hraRad)
    (setq slat (sin (deg-rad lat)))
    (println "Hour  Sun hour angle  Dial hour line angle")
    (for (h -6 6) ;6AM-6PM
      (setq hra (add (mul h 15) mer (sub lon)))
      (setq hraRad (deg-rad hra)
      (setq hla (rad-deg (atan2 (mul (sin hraRad) slat) (cos hraRad))))
      (println (format "%4d %15.3f %21.3f" (+ h 12) hra hla))))))

(sundial -4.95 -150.5 -150)
;-> Hour  Sun hour angle  Dial hour line angle
;->    6         -89.500                84.225
;->    7         -74.500                17.283
;->    8         -59.500                 8.334
;->    9         -44.500                 4.847
;->   10         -29.500                 2.795
;->   11         -14.500                 1.278
;->   12           0.500                -0.043
;->   13          15.500                -1.371
;->   14          30.500                -2.910
;->   15          45.500                -5.018
;->   16          60.500                -8.671
;->   17          75.500               -18.451
;->   18          90.500               -95.775


-----------------
FizzBuzz generico
-----------------

Scrivere una versione generalizzata di FizzBuzz che opera con qualsiasi lista di fattori, insieme alle loro parole.

Esempio: Stampare i numeri da 1 a 20, sostituendo ogni multiplo di 3 con "Fizz", ogni multiplo di 5 con "Buzz" e ogni multiplo di 7 con "Baxx".

Nel caso in cui un numero sia un multiplo di almeno due fattori, stampare ciascuna delle parole associate a tali fattori nell'ordine dal minimo al massimo fattore.

Ad esempio, per il numero 15, che è un multiplo sia di 3 che di 5, stampare "FizzBuzz".
Se il numero massimo fosse 105 anziché 20, stampere "FizzBuzzBaxx" perché è un multiplo di 3, 5 e 7.

Numero massimo: 20
Lista di fattori: (3 5 7)
Lista di parole: ("Fizz" "Buzz" "Baxx")
Output:
  1
  2
  Fizz
  4
  Buzz
  Fizz
  Baxx
  8
  Fizz
  Buzz
  11
  Fizz
  13
  Baxx
  FizzBuzz
  16
  17
  Fizz
  19
  Buzz

Scriviamo la funzione:

(define (general fattori parole limit)
  (for (i 1 limit)
    (setq s "")
    (dolist (f fattori)
      (if (zero? (% i f)) (extend s (parole $idx)))
    )
    (if (= s "")
        (println i)
        (println s)
    )
  ))

(setq factors '(3 5 7))
(setq words '("Fizz" "Buzz" "Baxx"))
(general factors words 20)
;-> 1
;-> 2
;-> Fizz
;-> 4
;-> Buzz
;-> Fizz
;-> Baxx
;-> 8
;-> Fizz
;-> Buzz
;-> 11
;-> Fizz
;-> 13
;-> Baxx
;-> FizzBuzz
;-> 16
;-> 17
;-> Fizz
;-> 19
;-> Buzz

(general factors words 105)
;-> 1
;-> 2
;-> Fizz
;-> 4
;-> Buzz
;-> Fizz
;-> Baxx
;-> 8
;-> ...
;-> 92
;-> Fizz
;-> 94
;-> Buzz
;-> Fizz
;-> 97
;-> Baxx
;-> Fizz
;-> Buzz
;-> 101
;-> Fizz
;-> 103
;-> 104
;-> FizzBuzzBaxx

(general '(1 2 3 4 5 6 7 8 9 10) '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10") 10)
;-> 1
;-> 12
;-> 13
;-> 124
;-> 15
;-> 1236
;-> 17
;-> 1248
;-> 139
;-> 12510


---------------------------------------
Numeri di Jacobsthal e Jacobsthal-Lucas
---------------------------------------

I numeri di Jacobsthal sono una sequenza correlata ai numeri di Fibonacci.
Nella sequenza di Fibonacci ogni termine è la somma dei due termini precedenti.
Nella sequenza di Jacobsthal ogni termine è la somma del precedente, più il doppio di quello precedente.
La sequenza inizia con i termini indicati 0, 1.

   J0 = 0
   J1 = 1
   J(n) = J(n-1) + 2*J(n-2)

I termini possono essere calcolati anche utilizzando la seguente formula:

    J(n) = (2^n - (-1)^n)/3

Sequenza OEIS: A001045
  0, 1, 1, 3, 5, 11, 21, 43, 85, 171, 341, 683, 1365, 2731, 5461,
  10923, 21845, 43691, 87381, 174763, 349525, 699051, 1398101,
  2796203, 5592405, 11184811, 22369621, 44739243, 89478485,
  178956971, 357913941, 715827883, 1431655765, 2863311531, 5726623061, ...

I numeri di Jacobsthal-Lucas sono molto simili. Hanno la stessa relazione di ricorrenza, l'unica differenza è il valore iniziale J0 = 2 anziché J0 = 0.

I termini possono essere calcolati anche utilizzando la seguente formula:

  JL(n) = 2^n + (-1)^n

Sequenza OEIS: A014551
  2, 1, 5, 7, 17, 31, 65, 127, 257, 511, 1025, 2047, 4097, 8191, 16385,
  32767, 65537, 131071, 262145, 524287, 1048577, 2097151, 4194305, 8388607,
  16777217, 33554431, 67108865, 134217727, 268435457, 536870911, 1073741825,
  2147483647, 4294967297, 8589934591, ...

Numeri di Jacobsthal
--------------------
1) Ricorsione

Funzione che calcola l'n-esimo numero di Jacobsthal:

(define (Jacob n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (true
          (+ (Jacob (- n 1)) (* 2 (Jacob (- n 2)))))))

Calcoliamo i primi 25 numeri di Jacobsthal:

(map Jacob (sequence 0 25))
;-> (0 1 1 3 5 11 21 43 85 171 341 683 1365 2731 5461 10923 21845 43691
;->  87381 174763 349525 699051 1398101 2796203 5592405 11184811)

2) Formula: J(n) = (2^n - (-1)^n)/3

Funzione che calcola l'n-esimo numero di Jacobsthal:
(define (J n)
  ;(div (- (pow 2 n) (pow-1 n)) 3)) ; stessa velocità
  (div (- (pow 2 n) (pow -1 n)) 3))

Calcoliamo i primi 25 numeri di Jacobsthal:

(map J (sequence 0 25))
;-> (0 1 1 3 5 11 21 43 85 171 341 683 1365 2731 5461 10923 21845 43691
;->  87381 174763 349525 699051 1398101 2796203 5592405 11184811)

Vediamo la differenza di velocità tra le due funzioni "Jacob" e "J":

(time (map Jacob (sequence 0 25)) 10)
;-> 966.947
(time (map J (sequence 0 25)) 10)
;-> 0

La versione ricorsiva non è utilizzabile praticamente.

Numeri di Jacobsthal-Lucas
--------------------------
1) Ricorsione

Funzione che calcola l'n-esimo numero di Jacobsthal-Lucas:

(define (Jacob-Lucas n)
  (cond ((= n 0) 2)
        ((= n 1) 1)
        (true
          (+ (Jacob-Lucas (- n 1)) (* 2 (Jacob-Lucas (- n 2)))))))

Calcoliamo i primi 25 numeri di Jacobsthal-Lucas:

(map Jacob-Lucas (sequence 0 25))
;-> (2 1 5 7 17 31 65 127 257 511 1025 2047 4097 8191 16385 32767 65537 131071
;->  262145 524287 1048577 2097151 4194305 8388607 16777217 33554431)

2) Formula: JL(n) = 2^n + (-1)^n

Funzione che calcola l'n-esimo numero di Jacobsthal-Lucas:

(define (JL n)
  (add (pow 2 n) (pow -1 n)))

Calcoliamo i primi 25 numeri di Jacobsthal-Lucas:

(map JL (sequence 0 25))
;-> (2 1 5 7 17 31 65 127 257 511 1025 2047 4097 8191 16385 32767 65537 131071
;->  262145 524287 1048577 2097151 4194305 8388607 16777217 33554431)

Vediamo la differenza di velocità tra le due funzioni "Jacob-Lucas" e "JL":

(time (map Jacob-Lucas (sequence 0 25)) 10)
;-> 967.959
(time (map JL (sequence 0 25)) 10)
;-> 0

Anche in questo caso la versione ricorsiva non è utilizzabile praticamente.

Possiamo utilizzare anche la Programmazione dinamica.

Programmazione dinamica: Jacobsthal

(define (Jacob-dp n all)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (true
          (let (dp (array (+ n 1) '(0)))
            (setf (dp 0) 0)
            (setf (dp 1) 1)
            (for (i 2 n)
              (setf (dp i) (+ (dp (- i 1)) (* 2 (dp (- i 2)))))
            )
            ; if all is true, then return all Jacob numbers from 0 to n
            ; else return n-th Jacobsthal number
            (if all dp (dp n))))))

(map Jacob-dp (sequence 0 25))
;-> (0 1 1 3 5 11 21 43 85 171 341 683 1365 2731 5461 10923 21845 43691 87381
;->  174763 349525 699051 1398101 2796203 5592405 11184811)

Vediamo la differenza di velocità tra le funzioni "J" e "Jacob-dp":

(time (map J (sequence 0 100000)) 100)
;-> 2389.525
(time (Jacob-dp 100000 true ) 100)
;-> 1834.358

Programmazione dinamica: Jacobsthal-Lucas

(define (JL-dp n all)
  (cond ((= n 0) 2)
        ((= n 1) 1)
        (true
          (let (dp (array (+ n 1) '(0)))
            (setf (dp 0) 2)
            (setf (dp 1) 1)
            (for (i 2 n)
              (setf (dp i) (+ (dp (- i 1)) (* 2 (dp (- i 2)))))
            )
            ; if all is true, then return all Jacobsthal-Lucas numbers (0, n)
            ; else return n-th Jacobsthal-Lucas number
            (if all dp (dp n))))))

(map JL-dp (sequence 0 25))
;-> (2 1 5 7 17 31 65 127 257 511 1025 2047 4097 8191 16385 32767 65537 131071
;->  262145 524287 1048577 2097151 4194305 8388607 16777217 33554431)

Vediamo la differenza di velocità tra le funzioni "JL" e "JL-dp":

(time (map JL (sequence 0 100000)) 100)
;-> 2115.345
(time (JL-dp 100000 true ) 100)
;-> 1818.167


-------------------------------------
La formica di Langton (Langton's ant)
-------------------------------------

La formica di Langton è un automa cellulare che parte con formica posizionata su un piano di celle, inizialmente tutte bianche, con la formica rivolta in una delle quattro direzioni.
Ogni cella può essere nera o bianca.
La formica si muove in base al colore della cella in cui si trova attualmente, con le seguenti regole:
   a) Se la cella è nera, diventa bianca e la formica gira a sinistra;
   b) Se la cella è bianca, diventa nera e la formica gira a destra;
   c) La formica si sposta quindi alla cella successiva e ripete dal passaggio 1.

Questo insieme di regole piuttosto semplice porta a uno schema di movimento inizialmente caotico e, dopo circa 10000 passaggi, appare un ciclo in cui la formica si allontana costantemente dalla posizione di partenza in un "corridoio" diagonale largo circa 10 celle. Potenzialmente la formica può quindi arrivare infinitamente lontano.

(define (print-grid matrix)
  (local (row col)
    ;(if (array? matrix) (setq matrix (array-list matrix)))
    (setq row (length matrix))
    (setq col (length (first matrix)))
    (for (i 0 (- row 1))
      ; do not print empty row
      (if (!= '(0) (count '(1) (array-list (matrix i))))
        (begin
          (for (j 0 (- col 1))
            (cond ((= (matrix i j) 0) (print " "))
                  ((= (matrix i j) 1) (print "*"))
                  ; formica su cella bianca
                  ((= (matrix i j) "a") (print "a"))
                  ; formica su cella nera
                  ((= (matrix i j) "A") (print "A"))
            )
          )
          (println))
      )
    )))

(define (langton iter step)
  (local (x y grid dir)
    (setq grid (array 101 101 '(0)))
    (setq x 50) (setq y 50)
    ; direction: (0 nord) (1 est) (2 sud) (3 ovest)
    (setq dir (rand 4))
    (for (i 1 iter)
      ; step = true --> print grid for each step/movement
      (if step (begin
        (println i)
        (print-grid grid)
        (read-line))
      )
      (if (= (grid x y) 0) ; cella bianca (0)?
        (begin ; gira a sinistra
          (cond ((= dir 0)
                  ; nuova direzione
                  (setq dir 3)
                  ; la cella corrente cambia colore
                  (setf (grid x y) 1)
                  ; aggiornamento posizione formica
                  (-- x)
                  (setq y y)
                )
                ((= dir 1)
                  (setq dir 0)
                  (setf (grid x y) 1)
                  (setq x x)
                  (-- y)
                )
                ((= dir 2)
                  (setq dir 1)
                  (setf (grid x y) 1)
                  (++ x)
                  (setq y y)
                )
                ((= dir 3)
                  (setq dir 2)
                  (setf (grid x y) 1)
                  (setq x x)
                  (++ y)
                )
          )
        )
        (begin ; gira a destra
          (cond ((= dir 0)
                  (setq dir 1)
                  (setf (grid x y) 0)
                  (++ x)
                  (setq y y)
                )
                ((= dir 1)
                  (setq dir 2)
                  (setf (grid x y) 0)
                  (setq x x)
                  (++ y)
                )
                ((= dir 2)
                  (setq dir 3)
                  (setf (grid x y) 0)
                  (-- x)
                  (setq y y)
                )
                ((= dir 3)
                  (setq dir 0)
                  (setf (grid x y) 0)
                  (setq x x)
                  (-- y)
                )
          )
        )
      )
    )
    ; posizione finale della formica
    (if (= 0 (grid x y))
        (setf (grid x y) "a")
        (setf (grid x y) "A")
    )
    (println "iterazione: " iter)
    ; stampa la griglia
    (print-grid grid)
  )
)

(langton 11300)
;-> iterazione: 11300
;->                                                                     **
;->                                                                      **
;->                                               **  **            *** ** *
;->                                              *  **  ***        **** *  *
;->                                             *    **   *      ** **  * *
;->                                          ** *     *     ******* *** **
;->                                         *  *  *   ** *   *  ***** *  *
;->                                        ***   *   ****  ** *** *      **
;->                                     ** * *  **  *   * **  **** ******
;->                                    *  *   *    *     **  **   * * ***** *
;->                                   *** **  *  *    *   ***** * ** *    ***
;->                                   **     ** ***   ** ***   ** ****  *  *
;->                                     ***  *** *   * * ***     *  *    **
;->                                       * *   ********* *****   ****
;->                                 *** ***  ** *  *      *   **  *
;->                                  ***** *****  **   *****    * * *
;->                               ** * ******* *** ****** ***** * ***
;->                              *    **  **   ***  *  *  *  *   * *
;->                             ***      ***  * ** **    *  * ** *
;->                             * *  *    *    * *****  *    * **
;->                                  ** ***  * *  ** **    *  * *
;->                              * *     * *     * * ** * *  *** ** *
;->                             *   ***  *  *  * *  **** **   ** ****
;->                             *   ** *** ** *  *   *     **** * **
;->                             *  **   ***      *  **** *** **   **
;->                             *      ***     ***  ***   **  *    *
;->                             *     * * * ****    ****  ** **
;->                             *     ** *** **   * ** **** ***   * *
;->                             *      * *    ***** * * ***       ***
;->                             *    **** *    *** ** ***   * *    *
;->                             *     *  ** ** ** ****  ** **  ****
;->                             *     * ** **  *    *******
;->                             ***   **  **  * *** * ** *   *
;->                             ***    ** ****** *  *   ****    *
;->                              * ** * **  **    **** * ** **** *
;->                              *   ******* ******  * ** * *    *
;->                             *   *   ** *  *   ** ******  *  *
;->                             * **    ***  *   * ******* *  **
;->                              ** * **   * * * ** *  **  ***
;->                               ****** **          *****   *
;->                                   *   *  ***** *      * *
;->                                    **     * * **   *    *
;->                                 ** *  ** *     ** *    ***
;->                                 * ** *      * *   *    ***
;->                                  *   **** **   *   *    *
;->                                  ***  *   *   ***   ****
;->                                  *   **  ** **   *
;->                                     **  **  *   ***
;->                                      **  * ** **   *
;->                                           **  *   ***
;->                                            * ** **   *
;->                                             **  *   ***
;->                                              * ** **   *
;->                                               **  *   ***
;->                                                * ** **   *
;->                                                 **  *   ***
;->                                                  * ** **   *
;->                                                   **  *   ***
;->                                                    * ** **   *
;->                                                     **  *   ***
;->                                                      * ** **   *
;->                                                       **  *   ***
;->                                                        * ** **   *
;->                                                         **  *   ***
;->                                                          * ** **   *
;->                                                           **  *   ***
;->                                                            * ** **   *
;->                                                             **  * *****
;->                                                              * *** ****
;->                                                               ** * *  a *
;->                                                                * **   ***
;->                                                                 *****  *
;->                                                                  **  **

Nota: la direzione del "corridoio" dipende dall'orientamento iniziale della formica.


------------------
Il gioco di Penney
------------------

Il gioco di Penney è un gioco in cui due giocatori scommettono sull'uscita della propria particolare sequenza di testa o croce in lanci consecutivi di una moneta.
Le sequenze scelte dai giocatori sono lunghe tre. Per esempio, le sequenze scelte potrebbero essere le seguenti:

  sequenza 1: TTC (Testa - Testa - Croce)
  sequenza 2: CTC (Croce - Testa - Croce)

A questo punto la moneta viene lanciata e il primo giocatore che vede la sua sequenza nella sequenza di lanci delle monete vince.

Esempio:
Sequenza Giocatore 1 =  TTC
Sequenza Giocatore 2 =  CTC

                             1 2 3 4 5
Successivi lanci di monete = T C C T C  --> vince il giocatore 2 perchè le ultime tre monete uscite sono uguali alla sua sequenza (CTC).

Se il giocatore 2 può scegliere la sequenza dopo aver visto la sequenza del giocatore 1, allora può massimizzare le sue probabilità di vittoria.
Questo perché il gioco è "non transitivo", cioè per una data sequenza, di lunghezza tre o più, si può sempre trovare un'altra sequenza che ha una maggiore probabilità di verificarsi per prima.
La relazione tra le otto triple è la seguente:

      TCT   *TCC ----* CCC
       *   /    \
       |  /      \
       | /        \
      TTC          *
       *          CCT ----* CTC
        \        /
         \      /
          \    *
  TTT *---- CTT

Non importa quale delle otto triple il giocatore 1 sceglie, c'è sempre una tripla che il giocatore 2 può scegliere che ha maggiori possibilità di arrivare prima (cioè la tripla che punta con l'astrerisco "*" alla scelta del giocatore 1).
Per esempio, CTT batte TTT, CCT batte CTC, ecc.
Le migliori scelte del giocatore 2 formano una relazione ad anello tra le quattro triple interne in questa figura.
Quindi le scelte ottime del secondo giocatore sono le seguenti:

  Sequenza 1     Sequenza 2     Probabilità a favore del giocatore 2
  ----------     ----------     ------------------------------------
  TTT            CTT            7 a 1
  TTC            CTT            3 a 1
  TCT            TTC            2 a 1
  TCC            TTC            2 a 1
  CTT            CCT            2 a 1
  CTC            CCT            2 a 1
  CCT            TCC            3 a 1
  CCC            TCC            7 a 1

La formula per trovare la sequenza ottimale data una qualunque sequenza è la seguente:

  Sequenza iniziale: abc
  dove a,b,c possono essere T (Testa) o C (Croce)

  Sequenza ottimale:  (!b)ab
  dove (!a) è l'inverso di a: se a = T, allora (!a) = C
                              se a = C, allora (!a) = T

Funzione che simula il lancio di una moneta:

(define (moneta) (if (zero? (rand 2)) "T" "C"))

Funzione che inverte (flip) "T" con "C" e viceversa:

(define (flip x) (if (= x "T") "C" "T"))

Funzione che simula un gioco di Penney:

(define (penney fair)
  (local (winner seq1 seq2 game-over lst)
    (setq seq1 (list (moneta) (moneta) (moneta)))
    (cond ((= fair 0) ; seq2 random
            (setq seq2 (list (moneta) (moneta) (moneta)))
            ; seq2 deve essere diversa da seq1
            (while (= seq1 seq2)
              (setq seq2 (list (moneta) (moneta) (moneta)))
            ))
          ((= fair 1) ; seq2 = flip (seq1)
            (setq seq2 (list (flip (seq1 0)) (flip (seq1 1)) (flip (seq1 2)))))
          (true ; seq2 ottimale
            (setq seq2 (list (flip (seq1 1)) (seq1 0) (seq1 1))))
    )
    (setq winner nil)
    (setq lst (list (moneta) (moneta) (moneta)))
    (until winner
            ; qualcuno ha vinto?
      (cond ((= lst seq1) (setq winner 1))
            ((= lst seq2) (setq winner 2))
            (true ; nuovo lancio
              ; aggiorna lista delle tre monete
              (setq (lst 0) (lst 1))
              (setq (lst 1) (lst 2))
              (setq (lst 2) (moneta))
            )
      )
      ;(println seq1 seq2 lst)
      ;(read-line)
    )
    winner))

Funzione che simula un numero predefinito di giochi di Penney:

(define (penney-prob iter fair)
  (let ((res 0) (out '()) (w1 0) (w2 0))
    (for (i 1 iter)
      (if fair
        (setq res (penney fair))
        ;else
        (setq res (penney))
      )
      (if (= res 1) (++ w1) (++ w2))
    )
    (list w1 w2 (div w1 iter) (div w2 iter))))

Simulazione con Sequenza 2 casuale:

(penney-prob 1e6 0)
;-> (499385 500615 0.499385 0.500615)

In questo caso la probabilità di vittoria è al 50%.

Simulazione con Sequenza 2 inversa di Sequenza 1:

(penney-prob 1e6 1)
;-> (501014 498986 0.501014 0.498986)

In questo caso la probabilità di vittoria è al 50%.

Simulazione con Sequenza 2 ottimale:

(penney-prob 1e6)
;-> (260864 739136 0.260864 0.739136)

In questo caso la probabilità di vittoria del giocatore 1 vale il 26%, mentre la probabilità del giocatore 2 vale il 74%.

Adesso calcoliamo i valori della tabella con le sequenze ottimali.

Funzione che simula un gioco di Penney con predeterminate sequenze:

(define (penney-single s1 s2)
  (local (winner seq1 seq2 game-over lst)
    (setq seq1 s1)
    (setq seq2 s2)
    (setq winner nil)
    (setq lst (list (moneta) (moneta) (moneta)))
    (until winner
            ; qualcuno ha vinto?
      (cond ((= lst seq1) (setq winner 1))
            ((= lst seq2) (setq winner 2))
            (true ; nuovo lancio
              ; aggiorna lista delle tre monete
              (setq (lst 0) (lst 1))
              (setq (lst 1) (lst 2))
              (setq (lst 2) (moneta))
            )
      )
    )
    winner))

(penney-single (explode "TTT") (explode "CTT"))
;-> 2

Funzione che calcola le probabilità di vittoria del giocatore 2 per ogni combinazione ottimale:

(define (penney-optimal iter)
  (local (w1 w2 s1 s2 ss)
    (setq ss '(("TTT" "CTT") ("TTC" "CTT") ("TCT" "TTC") ("TCC" "TTC")
               ("CTT" "CCT") ("CTC" "CCT") ("CCT" "TCC") ("CCC" "TCC")))
    (println "Sequenza 1    Sequenza 2    % Gioc1  % Gioc2  Rapporto")
    (dolist (el ss)
      (setq w1 0)
      (setq w2 0)
      (setq s1 (explode (el 0)))
      (setq s2 (explode (el 1)))
      ;(println s1 { } s2) (read-line)
      (for (i 1 iter)
        (if (= (penney-single s1 s2) 1) (++ w1) (++ w2))
      )
      (println s1 { } s2 { } (div w1 iter) { } (div w2 iter) { }
              (div (div w2 iter) (div w1 iter)))
    )))

(penney-optimal 1e6)
;-> Sequenza 1    Sequenza 2    % Gioc1  % Gioc2  Rapporto
;-> ("T" "T" "T") ("C" "T" "T") 0.124644 0.875356 7.022849074163217
;-> ("T" "T" "C") ("C" "T" "T") 0.249992 0.750008 3.000128004096131
;-> ("T" "C" "T") ("T" "T" "C") 0.333136 0.666864 2.001777052014793
;-> ("T" "C" "C") ("T" "T" "C") 0.332826 0.667174 2.004572960045189
;-> ("C" "T" "T") ("C" "C" "T") 0.333177 0.666823 2.001407660192631
;-> ("C" "T" "C") ("C" "C" "T") 0.333699 0.666301 1.996712606270921
;-> ("C" "C" "T") ("T" "C" "C") 0.249698 0.750302 3.004837844115692
;-> ("C" "C" "C") ("T" "C" "C") 0.124870 0.875130 7.008328661808281

I risultati della simulazione sono conformi ai valori della tabella.

Vediamo adesso le probabilità di vittoria per ogni incrocio possibile di sequenze.

Funzione per calcolare il prodotto cartesiano di due liste:

(define (cp lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

(cp '(1 2) '(3 4))
;-> ((1 3) (1 4) (2 3) (2 4))

(define (penney-all iter)
  (local (a b w1 w2 s1 s2 ss)
    (setq a '("TTT" "TTC" "TCT" "TCC" "CTT" "CTC" "CCT" "CCC"))
    (setq b '("TTT" "TTC" "TCT" "TCC" "CTT" "CTC" "CCT" "CCC"))
    ; crea tutte le coppie possibili di sequenze
    (setq ss (filter (fn(x) (!= (x 0) (x 1))) (cp a b)))
    (println "Sequenza 1    Sequenza 2    % Gioc1  % Gioc2  Rapporto")
    (dolist (el ss)
      (setq w1 0)
      (setq w2 0)
      (setq s1 (explode (el 0)))
      (setq s2 (explode (el 1)))
      ;(println s1 { } s2) (read-line)
      (for (i 1 iter)
        (if (= (penney-single s1 s2) 1) (++ w1) (++ w2))
      )
      (println s1 { } s2 { } (div w1 iter) { } (div w2 iter) { }
              (div (div w2 iter) (div w1 iter)))
    )))

Calcoliamo le probabilità di ogni gioco possibile:

(penney-all 1e6)
;-> Sequenza 1    Sequenza 2    % Gioc1  % Gioc2  Rapporto
;-> ("T" "T" "T") ("T" "T" "C") 0.499313 0.500687 1.002751780947021
;-> ("T" "T" "T") ("T" "C" "T") 0.400304 0.599696 1.498101442903393
;-> ("T" "T" "T") ("T" "C" "C") 0.399732 0.600268 1.501676123002412
;-> ("T" "T" "T") ("C" "T" "T") 0.124959 0.875041 7.002624860954393
;-> ("T" "T" "T") ("C" "T" "C") 0.417280 0.582720 1.396472392638037
;-> ("T" "T" "T") ("C" "C" "T") 0.299926 0.700074 2.33415575842041
;-> ("T" "T" "T") ("C" "C" "C") 0.499633 0.500367 1.001469078303475
;-> ("T" "T" "C") ("T" "T" "T") 0.500340 0.499660 0.9986409241715634
;-> ("T" "T" "C") ("T" "C" "T") 0.666352 0.333648 0.5007083343338055
;-> ("T" "T" "C") ("T" "C" "C") 0.666052 0.333948 0.5013842763027512
;-> ("T" "T" "C") ("C" "T" "T") 0.250122 0.749878 2.99804895211137
;-> ("T" "T" "C") ("C" "T" "C") 0.624836 0.375164 0.6004199501949312
;-> ("T" "T" "C") ("C" "C" "T") 0.500196 0.499804 0.9992163072075747
;-> ("T" "T" "C") ("C" "C" "C") 0.700017 0.299983 0.4285367355364227
;-> ("T" "C" "T") ("T" "T" "T") 0.601581 0.398419 0.662286541629473
;-> ("T" "C" "T") ("T" "T" "C") 0.333578 0.666422 1.99779961508253
;-> ("T" "C" "T") ("T" "C" "C") 0.499195 0.500805 1.003225192560022
;-> ("T" "C" "T") ("C" "T" "T") 0.500469 0.499531 0.9981257580389593
;-> ("T" "C" "T") ("C" "T" "C") 0.499413 0.500587 1.002350759791996
;-> ("T" "C" "T") ("C" "C" "T") 0.375744 0.624256 1.661386475898484
;-> ("T" "C" "T") ("C" "C" "C") 0.583225 0.416775 0.714604140769
;-> ("T" "C" "C") ("T" "T" "T") 0.600184 0.399816 0.6661557122482438
;-> ("T" "C" "C") ("T" "T" "C") 0.334018 0.665982 1.993850630804328
;-> ("T" "C" "C") ("T" "C" "T") 0.500222 0.499778 0.9991123940970208
;-> ("T" "C" "C") ("C" "T" "T") 0.499724 0.500276 1.001104609744579
;-> ("T" "C" "C") ("C" "T" "C") 0.501011 0.498989 0.9959641604675347
;-> ("T" "C" "C") ("C" "C" "T") 0.749516 0.250484 0.3341943334098271
;-> ("T" "C" "C") ("C" "C" "C") 0.874730 0.125270 0.1432099047706149
;-> ("C" "T" "T") ("T" "T" "T") 0.875181 0.124819 0.142620783586481
;-> ("C" "T" "T") ("T" "T" "C") 0.750134 0.249866 0.3330951536658784
;-> ("C" "T" "T") ("T" "C" "T") 0.499956 0.500044 1.000176015489363
;-> ("C" "T" "T") ("T" "C" "C") 0.500190 0.499810 0.9992402886902976
;-> ("C" "T" "T") ("C" "T" "C") 0.500333 0.499667 0.9986688865215765
;-> ("C" "T" "T") ("C" "C" "T") 0.333456 0.666544 1.998896406122547
;-> ("C" "T" "T") ("C" "C" "C") 0.600633 0.399367 0.6649101864199937
;-> ("C" "T" "C") ("T" "T" "T") 0.582876 0.417124 0.7156307688084602
;-> ("C" "T" "C") ("T" "T" "C") 0.374916 0.625084 1.667264133832645
;-> ("C" "T" "C") ("T" "C" "T") 0.500352 0.499648 0.9985929905346636
;-> ("C" "T" "C") ("T" "C" "C") 0.499795 0.500205 1.000820336337899
;-> ("C" "T" "C") ("C" "T" "T") 0.499914 0.500086 1.000344059178179
;-> ("C" "T" "C") ("C" "C" "T") 0.333520 0.666480 1.998320940273447
;-> ("C" "T" "C") ("C" "C" "C") 0.599993 0.400007 0.6666861113379656
;-> ("C" "C" "T") ("T" "T" "T") 0.699968 0.300032 0.4286367376794368
;-> ("C" "C" "T") ("T" "T" "C") 0.500129 0.499871 0.9994841330936618
;-> ("C" "C" "T") ("T" "C" "T") 0.624246 0.375754 0.6019325714542023
;-> ("C" "C" "T") ("T" "C" "C") 0.250206 0.749794 2.996706713667938
;-> ("C" "C" "T") ("C" "T" "T") 0.667345 0.332655 0.498475301380845
;-> ("C" "C" "T") ("C" "T" "C") 0.666032 0.333968 0.5014293607514354
;-> ("C" "C" "T") ("C" "C" "C") 0.500071 0.499929 0.9997160403222741
;-> ("C" "C" "C") ("T" "T" "T") 0.499511 0.500489 1.001957914840714
;-> ("C" "C" "C") ("T" "T" "C") 0.299189 0.700811 2.342368870513288
;-> ("C" "C" "C") ("T" "C" "T") 0.417410 0.582590 1.395726024771807
;-> ("C" "C" "C") ("T" "C" "C") 0.125206 0.874794 6.986837691484433
;-> ("C" "C" "C") ("C" "T" "T") 0.400194 0.599806 1.498788087777428
;-> ("C" "C" "C") ("C" "T" "C") 0.399576 0.600424 1.502652811980699
;-> ("C" "C" "C") ("C" "C" "T") 0.499100 0.500900 1.003606491685033


-----------------
Prezzi frazionati
-----------------

Dato un valore in virgola mobile compreso tra 0.00 e 1.00, ridimensionare in base alla tabella seguente:

  >=  0.00  <  0.06  :=  0.10
  >=  0.06  <  0.11  :=  0.18
  >=  0.11  <  0.16  :=  0.26
  >=  0.16  <  0.21  :=  0.32
  >=  0.21  <  0.26  :=  0.38
  >=  0.26  <  0.31  :=  0.44
  >=  0.31  <  0.36  :=  0.50
  >=  0.36  <  0.41  :=  0.54
  >=  0.41  <  0.46  :=  0.58
  >=  0.46  <  0.51  :=  0.62
  >=  0.51  <  0.56  :=  0.66
  >=  0.56  <  0.61  :=  0.70
  >=  0.61  <  0.66  :=  0.74
  >=  0.66  <  0.71  :=  0.78
  >=  0.71  <  0.76  :=  0.82
  >=  0.76  <  0.81  :=  0.86
  >=  0.81  <  0.86  :=  0.90
  >=  0.86  <  0.91  :=  0.94
  >=  0.91  <  0.96  :=  0.98
  >=  0.96  <  1.01  :=  1.00

(define (rescale x)
  (cond ((< x 0) (println "Invalid Value") nil);
        ((< x 0.06) 0.10)
        ((< x 0.11) 0.18)
        ((< x 0.16) 0.26)
        ((< x 0.21) 0.32)
        ((< x 0.26) 0.38)
        ((< x 0.31) 0.44)
        ((< x 0.36) 0.50)
        ((< x 0.41) 0.54)
        ((< x 0.46) 0.58)
        ((< x 0.51) 0.62)
        ((< x 0.56) 0.66)
        ((< x 0.61) 0.70)
        ((< x 0.66) 0.74)
        ((< x 0.71) 0.78)
        ((< x 0.76) 0.82)
        ((< x 0.81) 0.86)
        ((< x 0.86) 0.90)
        ((< x 0.91) 0.94)
        ((< x 0.96) 0.98)
        ((< x 1.01) 1.00)
        (true (println "Invalid Value") nil)))

(map rescale '(0.7388727 0.8593103 0.826687 0.3444635))
;-> (0.82 0.9 0.9 0.5)


------------------
Tre cifre centrali
------------------

Scrivere una funzione che prende un valore intero e restituisce, se possibile, le tre cifre centrali come stringa oppure "" se ciò non è possibile.
L'ordine delle cifre centrali deve essere mantenuto.

(length -13)
(string "a" "b" "c")

(define (mid3 num)
  (let (len (length num))
       (setq num (string (abs num)))
       (cond ((< len 3) "")
             ((even? len) "")
             (true (string (num (- (/ len 2) 1))
                           (num (/ len 2))
                           (num (+ (/ len 2) 1)))))))

(setq lst1 '(123 12345 1234567 987654321 10001 -10001 -123 -100 100 -12345))
(setq lst2 '(1 2 -1 -10 2002 -2002 0))

(map mid3 lst1)
;-> ("123" "234" "345" "654" "000" "000" "123" "100" "100" "234")

(map mid3 lst2)
;-> ("" "" "" "" "" "" "")


-------------------
Inversioni di frase
-------------------

Data una stringa di parole separate da spazi:
1) Invertire i caratteri della stringa.
2) Invertire i caratteri di ogni singola parola nella stringa, mantenendo l'ordine delle parole originale all'interno della stringa.
3) Invertire l'ordine di ogni parola della stringa, mantenendo l'ordine dei caratteri in ogni parola.

(define (reverser str)
  (setq s (parse str " "))
  (println (reverse (copy str)))
  (println (reverse (join (reverse s) " ")))
  (println (join s " ")))

(setq s1 "newlisp code phrase reversal")

(reverser s1)
;-> lasrever esarhp edoc psilwen
;-> psilwen edoc esarhp lasrever
;-> reversal phrase code newlisp


-------------------
map range - rescale
-------------------

Dati due intervalli (a1..a2) e (b1..b2) e un valore s nel range (a1..a2), calcolare il valore t che rappresenta la mappatura lineare del valore s nell'intervallo (b1..b2).
Il valore t viene calcolato con la seguente formula:

             (s - a1)*(b2 - b1)
  t = b1 + ----------------------
                 (a2 - a1)

Scriviamo la funzione di mappatura:

(define (map-range a1 a2 b1 b2 s)
  (add b1
       (div (mul (sub s a1) (sub b2 b1)) (sub a2 a1))))

(map-range 0 100 10 20 50)
;-> 15

Facciamo un test da (0..10) a (-1 0) con valori di s da 0 a 10:

(define (test)
  (println "0..10   -1..0")
  (for (i 0 10)
    (println i {       } (map-range 0 10 -1 0 i))))

(test)
;-> 0..10   -1..0
;-> 0       -1
;-> 1       -0.9
;-> 2       -0.8
;-> 3       -0.7
;-> 4       -0.6
;-> 5       -0.5
;-> 6       -0.4
;-> 7       -0.3
;-> 8       -0.2
;-> 9       -0.09999999999999998
;-> 10       0


------------------------------------------
I cinque numeri di Tukey (Tukey's fivenum)
------------------------------------------

Il riepilogo "fivenum" (cinque numeri) di Tukey è un insieme di statistiche descrittive che fornisce informazioni su un insieme di dati. È costituito dai cinque percentili più importanti del campione:

  - il campione minimo (osservazione più piccola)
  - il quartile inferiore o il primo quartile
  - la mediana (il valore medio)
  - il quartile superiore o il terzo quartile
  - il massimo del campione (osservazione più grande)

Se i dati sono ordinati, il quartile inferiore è al centro della metà inferiore dei dati e il quartile superiore è al centro della metà superiore dei dati.
Questi quartili vengono utilizzati per calcolare l'intervallo interquartile, che aiuta a descrivere la variabilità (spread) dei dati e determinare se i punti dati sono valori anomali o meno (outliers).

I valori dell'insieme "fivenum" vengono usati per rappresentare graficamente i dati con i "boxplot":

1) Minimo (Q0 o 0° percentile):
il punto dati più basso nel set di dati escludendo eventuali valori anomali (outliers)

2) Primo quartile (Q1 o 25° percentile):
noto anche come quartile inferiore qn(0.25), è la mediana della metà inferiore del set di dati.

3) Mediana (Q2 o 50° percentile):
il valore medio nel set di dati

4) Terzo quartile (Q3 o 75° percentile):
noto anche come quartile superiore qn(0.75), è la mediana della metà superiore del set di dati.

5) Massimo (Q4 o 100° percentile):
il punto dati più alto nel set di dati escludendo eventuali valori anomali

Oltre ai valori minimo e massimo utilizzati per costruire un box-plot, un altro elemento importante che può essere impiegato anche per ottenere un box-plot è l'intervallo interquartile (IQR), come indicato di seguito:

Interquartile range (IQR) = la distanza tra i quartili superiore e inferiore

   IQR = Q3 - Q1 = q(n)(0,75) - q(n)(0,25)

Funzione che calcola la mediana:

(define (median x start end)
  (local (size m)
    (setq size (+ (- end start) 1))
    (if (< size 0) (println "ERROR"))
    (setq m (+ start (/ size 2)))
    (if (odd? size)
        (x m)
        (div (add (x (- m 1)) (x m)) 2))))

Funzione che calcola i cinque numeri di Tukey:
(minimum, lower-hinge, median, upper-hinge, maximum)

(define (fivenum x)
  (local (res m len lower)
    (setq len (length x))
    (setq res (array 5 '(0)))
    (sort x)
    (setf (res 0) (x 0))
    (setf (res 2) (median x 0 (- len 1)))
    (setf (res 4) (x -1))
    (setq m (/ len 2))
    (if (odd? len)
        (setq lower m)
        ;else
        (setq lower (- m 1))
    )
    (setf (res 1) (median x 0 lower))
    (setf (res 3) (median x m (- len 1)))
    res))

Facciamo alcune prove:

(fivenum (sequence 1 10))
;-> (1 3 5.5 8 10)

(fivenum (sequence 1 100))
;-> (1 25.5 50.5 75.5 100)

(fivenum '(10 10 11 12 12 13 13 15 15 16 18 18))
;-> (10 11.5 13 15.5 18)

(fivenum '(0 0 1 2 63 61 27 13))
;-> (0 0.5 7.5 44 63)

(setq a '(15.0 6.0 42.0 41.0 7.0 36.0 49.0 40.0 39.0 47.0 43.0))
(setq b '(36.0 40.0 7.0 39.0 41.0 15.0))
(setq c '(0.14082834  0.09748790  1.73131507  0.87636009
          -1.95059594  0.73438555  -0.03035726  1.46675970
          -0.74621349 -0.72588772  0.63905160  0.61501527
          -0.98983780 -1.00447874 -0.62759469  0.66206163
          1.04312009 -0.10305385  0.75775634  0.32566578))

(fivenum a)
;-> (6 25.5 40 42.5 49)
(fivenum b)
;-> (7 15 37.5 40 41)
(fivenum c)
;-> (-1.95059594 -0.676741205 0.23324706 0.746070945 1.73131507)


--------
Modulino
--------

È utile poter eseguire una funzione main() solo quando un programma viene eseguito direttamente. Questa è una caratteristica centrale negli script.
Uno script che si comporta in questo modo è chiamato "modulino".

newLISP manca di script "main", ma la funzionalità può eseere aggiunta facilmente.

From Rosetta Code: https://rosettacode.org/wiki/Modulinos#newLISP
; scriptedmain.lsp
(context 'SM)
(define (SM:meaning-of-life) 42)
(define (main)
  (println (format "Main: The meaning of life is %d" (meaning-of-life)))
  (exit))
(if (find "scriptedmain" (main-args 1)) (main))
(context MAIN)

; test.lsp
(load "scriptedmain.lsp")
(println (format "Test: The meaning of life is %d" (SM:meaning-of-life)))
(exit)


----------------------
I limiti del ciclo for
----------------------

Tempi di esecuzione di funzioni con cicli "for" multipli.

1 for
-----
(define (one iter)
  (for (i 1 iter)))

(time (one 5e8))
;-> 3624.958

2 for
-----
(define (two iter)
  (for (i 1 iter)
    (for (j 1 iter))))

(time (two 2e4))
;-> 2875.373
(time (two 3e4))
;-> 6469.251
(time (two 5e4))
;-> 18001.799

3 for
-----
(define (three iter)
  (for (i 1 iter)
    (for (j 1 iter)
      (for (k 1 iter)))))

(time (three 100))
;-> 15.586
(time (three 500))
;-> 906.358
(time (three 1000))
;-> 7203.743

4 for
-----
(define (four iter)
  (for (i 1 iter)
    (for (j 1 iter)
      (for (k 1 iter)
        (for (m 1 iter))))))

(time (four 100))
;-> 758.251
(time (four 200))
;-> 11901.573
(time (four 300))
;-> 59888.763

5 for
-----
(define (five iter)
  (for (i 1 iter)
    (for (j 1 iter)
      (for (k 1 iter)
        (for (m 1 iter)
          (for (n 1 iter)))))))

(time (five 50))
;-> 2469.593
(time (five 100))
;-> 75553.391

Vedi anche "Il ciclo for" su "Note libere 2".


--------
Topswops
--------

Topswops è un gioco di carte creato da John Conway negli anni '70.

Supponiamo di avere una particolare permutazione di un insieme di n carte numerate 1..n su entrambe le facce, per esempio la disposizione di quattro carte data da (2 4 1 3) dove la carta più a sinistra è in cima.
Un round è composto dall'inversione delle prime m carte dove m è il valore della carta più a sinistra (in cima).
I round vengono ripetuti finché la carta a sinistra (più in alto) non è il numero 1.

Per il nostro esempio i round producono:

    # Riproduzione casuale iniziale
    (2 4 1 3) ; invertiamo le prime 2 carte: 2 4 in 4 2
1)  (4 2 1 3) ; invertiamo le prime 4 carte: 4 2 1 3 in 3 2 1 4
2)  (3 1 2 4) ; invertiamo le prime 3 carte: 3 2 1 in 2 1 3
3)  (2 1 3 4) ; invertiamo le prime 2 carte: 2 1 in 1 2
4)  (1 2 3 4) ; la prima cifra a sinistra vale 1: stop.

Per un totale di quattro round dall'ordine iniziale ottenere la posione di stop con il valore 1 a sinistra.

Per un particolare numero n di carte, topswops(n) è il numero massimo di round necessari per arrivare alla posizione di stop considerando tutte le permutazioni iniziali delle n carte.

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

Funzione che effettua un round su una lista:

(define (swop lst)
  (let (this (lst 0))
    (setq lst (append (reverse (slice lst 0 this))
                      (slice lst this (- (length lst) this))))))

Funzione che calcola i valori massimi di turni per tutte le liste da 1 ad un determinasto numero di elementi:

(define (topswops num)
  (local (out permutazioni lst cambi cambimax)
    (setq out '())
    ; ciclo per ogni numero (lunghezza della lista)
    (for (i 1 num)
      ; calcola tutte le permutazioni
      (setq permutazioni (perm (sequence 1 i)))
      ; numero massimo di cambi
      (setq cambimax 0)
      ; ciclo per ogni permutazione della lista corrente
      (dolist (p permutazioni)
        (setq lst p)
        ;(println lst { } (lst 0)) (read-line)
        (setq cambi 0)
        ; calcola il numero di cambi (swop)...
        (until (= (lst 0) 1)
          (++ cambi)
          (setq lst (swop lst))
        )
        ; calcola il valore massimo dei cambi
        (setq cambimax (max cambi cambimax))
      )
      ; aggiorna la lista soluzione
      (push (list i cambimax) out -1)
    )
    out))

Questo metodo permette di calcolare la soluzione fino a 10 carte:

(time (println (topswops 9)))
;-> ((1 0) (2 1) (3 2) (4 4) (5 7) (6 10) (7 16) (8 22) (9 30))
;-> 1547.994

(time (println (topswops 10)))
;-> ((1 0) (2 1) (3 2) (4 4) (5 7) (6 10) (7 16) (8 22) (9 30) (10 38))
;-> 17937.455

Ho provato con 11 carte e la prima volta windows è andato in crash.
Hp riprovato con una repl nuova e questo è il risultato:

(time (println (topswops 11)))
;-> ((1 0) (2 1) (3 2) (4 4) (5 7) (6 10) (7 16) (8 22) (9 30) (10 38) (11 51))
;-> 331821.656

Le permutazioni da calcolare sono 11! = 39916800.

(time (perm (sequence 1 11)))
;-> 39577.207

Proviamo con un altro algoritmo. 
Dal sito Rosetta Code riportiamo la soluzione scritta in linguaggio julia:
https://rosettacode.org/wiki/Topswops#Julia

function fannkuch(n)
  n == 1 && return 0
  n == 2 && return 1
  p = [1:n]
  q = copy(p)
  s = copy(p)
  sign = 1
  maxflips = sum = 0
  while true
    q0 = p[1]
    if q0 != 1
      for i = 2:n
        q[i] = p[i]
      end
      flips = 1
      while true
        qq = q[q0] #??
        if qq == 1
          sum += sign*flips
          flips > maxflips && (maxflips = flips)
          break
        end
        q[q0] = q0
        if q0 >= 4
          i = 2
          j = q0-1
          while true
            t = q[i]
            q[i] = q[j]
            q[j] = t
            i += 1
            j -= 1
            i >= j && break
          end
        end
        q0 = qq
        flips += 1
      end
    end
    #permute
    if sign == 1
      t = p[2]
      p[2] = p[1]
      p[1] = t
      sign = -1
    else
      t = p[2]
      p[2] = p[3]
      p[3] = t
      sign = 1
      for i = 3:n
        sx = s[i]
        if sx != 1
          s[i] = sx-1
          break
        end
        i == n && return maxflips
        s[i] = i
        t = p[1]
        for j = 1:i
          p[j] = p[j+1]
        end
        p[i+1] = t
      end
    end
  end
end

Dalla REPL di julia:

julia> function main()
for i = 1:10
  println(fannkuch(i))
end
end

julia> @time main()
0
1
2
4
7
10
16
22
30
38
elapsed time: 0.299617582 seconds

La versione newLISP (non proprio immediata da convertire e sicuramente migliorabile) è la seguente:

(define (fannkuch n)
(catch
  (local (p q s sign maxflips sum q0 flips w1 qq w2 sx t i j)
    (cond ((= n 1) 0)
          ((= n 2) 1)
          (true
          (setq p (array (+ n 1) (sequence 0 n)))
          (setq q p)
          (setq s p)
          (set 'sign 1 'maxflips 0 'sum 0)
          (while true
            (setq q0 (p 1))
            (if (!= q0 1)
              (begin
                (for (i 2 n)
                  (setf (q i) (p i))
                )
                (setq flips 1)
                (setq w1 true)
                (while w1
                  (setq qq (q q0))
                  (cond ((= qq 1)
                          (setq sum (+ sum (* sign flips)))
                          (if (> flips maxflips) (setq maxflips flips))
                          (setq w1 nil))
                        (true
                          (setf (q q0) q0)
                          (if (>= q0 4)
                            (begin
                              (set 'i 2 'j (- q0 1))
                              (setq w2 true)
                              (while w2
                                (swap (q i) (q j))
                                (++ i)
                                (-- j)
                                (if (>= i j) (setq w2 nil))
                              );while
                            )
                          );if
                          (setq q0 qq)
                          (++ flips))
                  )
                );while
              )
            );if
            ; permute
            (cond ((= sign 1)
                    (swap (p 1) (p 2))
                    (setq sign -1))
                  (true
                    (swap (p 2) (p 3))
                    (setq sign 1)
                    (setq stop nil)
                    (for (i 3 n 1 stop)
                      (setq sx (s i))
                      (cond ((!= sx 1)
                              (setf (s i) (- sx 1))
                              (setq stop true))
                            (true
                              (if (= i n) (throw maxflips)) ; function exit
                              (setf (s i) i)
                              (setq t (p 1))
                              (for (j 1 i)
                                (setf (p j) (p (+ j 1)))
                              )
                              (setf (p (+ i 1)) t))
                      )
                    );for
                  )
            );cond
          );while
        )
      );cond
    );let
  );catch
)

Proviamo questa funzione:

(fannkuch 5)
;-> 7
(fannkuch 7)
;-> 16

Vediamo il tempo di esecuzione con mazzi da 1 a 10 carte:

(time (println (map fannkuch (sequence 1 10))))
;-> 14431.258

Proviamo con 11 carte:

(time (println (fannkuch 11)))
;-> 51
;-> 169971.807

Questo algoritmo è molto più veloce ed utilizzabile (perchè non crea una lista con tutte le permutazioni).


---------------------
Musica maestro (beep)
---------------------

Come fare musica con la funzione "Beep" di windows.
Vediamo la definizione della funzione "Beep" dalla documentazione Microsoft:

Beep function (utilapiset.h) (kernel32.dll)
-------------------------------------------
Generates simple tones on the speaker. The function is synchronous, it performs an alertable wait and does not return control to its caller until the sound finishes.

Syntax C++:

BOOL Beep(
  [in] DWORD dwFreq,
  [in] DWORD dwDuration
);

Parameters:
[in] dwFreq
The frequency of the sound, in hertz. This parameter must be in the range 37 through 32,767 (0x25 through 0x7FFF).

[in] dwDuration
The duration of the sound, in milliseconds.

Return value:
If the function succeeds, the return value is nonzero.
If the function fails, the return value is zero.

Per prima cosa dobbiamo importare la funzione:

(import "kernel32.dll" "Beep")
;-> Beep@D00668C0

Poi scriviamo una funzione che genera un suono (beep) con un dato tono (freq) e una data lunghezza (duration):

(define (beep freq duration)
  (and (> freq 36) (Beep freq duration)))

Facciamo alcune prove:

(beep 280 150)
(beep 700 150)
(beep 1200 150)
(beep 300 150)

Funzione per resettare l'altoparlante:

(define (nobeep) (Beep 0 0))

Una pianola spartana:

(define (pianola)
  (setq sound '((113 523) (119 587) (101 659) (114 698)
                (116 784) (121 880) (117 988) (105 1046)))
  (println "Press the keys QWERTYUI to play the piano! ESC to exit.")
  (while (!= (setq c (read-key)) 27)
    (beep (lookup c sound) 100)))

(pianola)

Scale musicali:

(setq scale1 '(9121 8609 8126 7670 7239 6833 6449
               6087 5746 5423 5119 4831 4560))
(dolist (el scale1) (beep el 150))

(setq scale2 '(4560 4304 4063 3834 3619 3416 3224
               3043 2873 2711 2559 2415 2280))
(dolist (el scale2) (beep el 150))

(setq scale3 '(2280 2152 2031 1917 1809 1715 1612
               1521 1436 1355 1292 1207 1140))
(dolist (el scale3) (beep el 150))

Una pianola estesa:

(define (piano)
  (setq sound '((113 4560) (50 4304) (119 4063) (51 3834) (101 3619)
                (114 3416) (53 3224) (116 3043) (54 2873) (121 2711)
                (55 2559) (117 2415) (105 2280) (122 2280) (115 2152)
                (120 2031) (100 1917) (99 1809) (118 1715) (103 1612)
                (98 1521) (104 1436) (110 1355) (106 1292) (109 1207)
                (44 1140)))
  (println "Press the keys to play the piano! ESC to exit.")
  (while (!= (setq c (read-key)) 27)
    (beep (lookup c sound) 100)))

(piano)


-------------------------
Numeri primi ultra-useful
-------------------------

Un primo ultra-useful è un elemento della sequenza in cui ogni a(n) è il più piccolo intero positivo k tale che 2^(2^n) - k è primo.
Il numero k deve essere sempre dispari poiché 2 a qualsiasi potenza è sempre pari.

Nota: I numeri diventano estremamente grandi molto velocemente. Ad oggi (2022) sono stati identificati solo diciannove elementi.

Sequenza OEIS: A058220
  1, 3, 5, 15, 5, 59, 159, 189, 569, 105, 1557, 2549, 2439, 13797,
  25353, 5627, 24317, 231425, 164073, ...

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che calcola i numeri primi ultra-useful:

(define (ultra n)
  (local (k p stop res)
   (setq k 1)
   (setq p (- (** 2 (** 2 n)) k))
   (setq stop nil)
   (until stop
     (cond ((prime? p)
             (setq stop true)
             (setq res k))
           (true
             (-- p 2)
             (++ k 2))
     )
   )
  res))

Calcoliamo i primi numeri della sequenza:

(map ultra (sequence 1 5))

Con questa funzione è possibile calcolare solo i primi cinque numeri della sequenza perchè la funzione "prime?" non accetta i big-integer.

(ultra 6)
;-> ERR: number out of range in function factor
;-> called from user function (prime? p)
;-> called from user function (ultra 6)

Proviamo con una funzione che calcola (lentamente) la fattorizzazione di un numero big-integer:

(define (factorbig n)
  (local (f k i dist out)
    ; Distanze tra due elementi consecutivi della ruota (wheel)
    (setq dist (array 48 '(2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4
                           6 8 4 2 4 2 4 8 6 4 6 2 4 6 2 6 6 4
                           2 4 6 2 6 4 2 4 2 10 2 10)))
    (setq out '())
    (while (zero? (% n 2)) (push '2L out -1) (setq n (/ n 2)))
    (while (zero? (% n 3)) (push '3L out -1) (setq n (/ n 3)))
    (while (zero? (% n 5)) (push '5L out -1) (setq n (/ n 5)))
    (while (zero? (% n 7)) (push '7L out -1) (setq n (/ n 7)))
    (setq k 11L i 0)
    (while (<= (* k k) n)
      (if (zero? (% n k))
        (begin
        (push k out -1)
        (setq n (/ n k)))
        (begin
        ;(++ k (dist i))
        (setq k (+ k (dist i)))
        (if (< i 47) (++ i) (setq i 0)))
      )
    )
    (if (> n 1) (push (bigint n) out -1))
    out
  )
)

(factorbig 9223372036854775809L)
;-> (3L 3L 3L 19L 43L 5419L 77158673929L)

Riscriviamo la funzione "prime?":

(define (prime? num)
   (if (< num 2) nil
       (= 1 (length (factorbig num)))))

(time (println (ultra 6)))
;-> 59
;-> 971848.45 circa 16 minuti

Per curiosità ecco lo stesso algoritmo scritto con il linguaggio di programmazione Arturo:

; start script
ultraUseful: function [n]
[
    k: 1
    p: (2^2^n) - k
    while ø
    [
        if prime? p -> return k
        p: p-2
        k: k+2
    ]
]

print [pad "n" 3 "|" pad.right "k" 4]
print repeat "-" 10
loop 1..12 'x ->
    print [(pad to :string x 3) "|" (pad.right to :string ultraUseful x 4)]
; end script

Possiamo eseguire il programma direttamente nel sito web:

https://arturo-lang.io/

In pochi secondi si ottiene il seguente risultato:

    n | k
  ----------
    1 | 1
    2 | 3
    3 | 5
    4 | 15
    5 | 5
    6 | 59
    7 | 159
    8 | 189
    9 | 569
   10 | 105
   11 | 1557
   12 | 2549


------------------------------
Lista dei file di una cartella
------------------------------

Ecco un semplice metodo per avere la lista di tutti i file di una cartella.

Valore della cartella corrente:
(real-path)
;-> "F:\\Lisp-Scheme\\newLisp\\newLISP-Note"

Cambio della cartella corrente:
(change-dir "F:\\Lisp-Scheme\\newLisp\\newLISP-Note")

Funzione che ritorna una lista con tutti i file di una cartella:

(define (list-files str-path)
  (if (null? str-path)
      (clean directory? (directory (real-path)))
      (clean directory? (directory str-path))))

(list-files)
;-> ("00-indice.lsp" "01-generale.lsp" "02-funzioni-varie.lsp"
;->  "03-99-problemi.lsp" "04-rosetta-code.lsp" "05-project-euler.lsp"
;->  "06-problemi-vari.lsp" "07-domande.lsp" "08-librerie.lsp"
;->  "09-note-libere-1.lsp" "10-note-libere-2.lsp" "11-note-libere-3.lsp"
;->  "12-note-libere-4.lsp" "13-note-libere-5.lsp" "14-note-libere-6.lsp"
;->  "15-note-libere-7.lsp" "16-note-libere-8.lsp" "17-note-libere-9.lsp"
;->  "18-note-libere-10.lsp" "20-appendici.lsp" "21-bibliografia.lsp"
;->  "A-Introduction-to-newLISP.lisp" "B-Code-Patterns.lisp"
;->  "C-The-little-newLISPER.lisp" "D-Kazimir-Blog.lisp"
;->  "data.zip" "LICENSE.txt" "make-newLISP-Note.bat" "newLISP-Note.lsp.old"
;->  "README.md" "yo.zip" "_npp-newlisp.ahk")
> (list-files "c:\\")
;-> ("$Recycle.Bin" "$WinREAgent" "acl10.1express" "AdwCleaner"
;->  "ASUS" "BOOTNXT" "bootTel.dat" "CLISP" "Documents and Settings"
;->  "DumpStack.log.tmp" "gforth64" "hiberfil.sys" "inetpub"
;->  "Intel" "MapInfo15" "Microsoft" "MSOCache" "newlisp"
;->  "pagefile.sys" "PDE3" "PDE4" "PerfLogs" "Program Files"
;->  "Program Files (x86)" "ProgramData" "Python27" "Recovery"
;->  "sqlite" "swapfile.sys" "System Volume Information"
;->  "TDM-GCC-64" "totalcmd" "Users" "util" "Windows")


------------------------------------
Creazione di immagini in formato PPM
------------------------------------
;
; File: ppm-explore.lsp
; Exploration with the PPM file format
;
; Format of ppm file
; P3           # "P3" means this is a RGB color image in ASCII
; 3 2          # "3 2" is the width and height of the image in pixels
; 255          # "255" is the maximum value for each color
; # The part above is the header
; # The part below is the image data: RGB triplets (ASCII)
; 255   0   0  # red
;   0 255   0  # green
;   0   0 255  # blue
; 255 255   0  # yellow
; 255 255 255  # white
;   0   0   0  # black
;
; An RGB triplets (ASCII) cn be saved in pached string binary format
;
; Function to convert a rgb list (r g b) to a ppm packed string
;( define ( ppm mrgb )  ( join ( map char mrgb ))) ; original by didi
(define (ppm mrgb) (pack (dup "b" (length mrgb)) mrgb)) ; lutz
;
; set colors
(setq white '(255 255 255))
(setq black '(0 0 0))
(setq red '(255 0 0))
(setq green '(0 255 0))
(setq blue '(0 0 255))
;
; background ppm color
(setq backcolor (ppm white))
; foreground ppm color
(setq forecolor (ppm red))
;
; width and height of ppm image
(set 'width 200 'height 200)
;
; range of x,y coords
(set 'xmin 0 'ymin 0 'xmax (- width 1) 'ymax (- height 1))
; array for store pixel of ppm image
(silent (set 'bmparray (array (* width height) (list backcolor))))
;
; Function to convert a rgb color to ppm color
(define (rgb2ppm-color) (ppm rgb))
;
; Function to write a point at x,y on ppm array
; pcolor must be a ppm color
(define (point x y pcolor)
  (if (and (>= x xmin) (>= y ymin) (<= x xmax) (<= y ymax))
    (begin
      (setq idx (+  x  (*  (- ymax y) width)))
      (setf (bmparray idx) pcolor))))
;
;Function to save the ppm array in a file (PPM format)
(define (save-ppm file)
  ; output as ppm-file, colormax-value is "255"
  ; header
  (write-file file
     (append "P6\n" (string width) " " (string height) "\n255\n" ))
  ; convert bitmap to string and append to ppm-file
  ; Image data (pixel values)
  (append-file file (join (array-list bmparray))))
;
; test: create image with random colors
(define (rnd-image width height filename)
  (set 'xmin 0 'ymin 0 'xmax (- width 1) 'ymax (- height 1))
  (setq white '(255 255 255))
  (setq backcolor (ppm white))
  ; array for store pixel of ppm image
  (setq bmparray (array (* width height) (list backcolor)))
  (for (x xmin xmax)
    (for (y ymin ymax)
      (setq col (ppm (list (rand 256) (rand 256) (rand 256))))
      (point x y col)
    )
  )
  (save-ppm filename))
;  
(rnd-image 200 200 "ppm-rnd.ppm")
;-> 120000
; eof

The PPM format (from http://netpbm.sourceforge.net/doc/ppm.html)
----------------------------------------------------------------
Updated: 09 October 2016

The PPM format is a lowest common denominator color image file format.

It should be noted that this format is egregiously inefficient. It is highly redundant, while containing a lot of information that the human eye can't even discern. Furthermore, the format allows very little information about the image besides basic color, which means you may have to couple a file in this format with other independent information to get any decent use out of it. However, it is very easy to write and analyze programs to process this format, and that is the point.

It should also be noted that files often conform to this format in every respect except the precise semantics of the sample values. These files are useful because of the way PPM is used as an intermediary format. They are informally called PPM files, but to be absolutely precise, you should indicate the variation from true PPM. For example, "PPM using the red, green, and blue colors that the scanner in question uses."

The name "PPM" is an acronym derived from "Portable Pixel Map." Images in this format (or a precursor of it) were once also called "portable pixmaps."

The Format
----------
The format definition is as follows. You can use the libnetpbm C subroutine library to read and interpret the format conveniently and accurately.

A PPM file consists of a sequence of one or more PPM images. There are no data, delimiters, or padding before, after, or between images.

Each PPM image consists of the following:

A "magic number" for identifying the file type. A ppm image's magic number is the two characters "P6".
Whitespace (blanks, TABs, CRs, LFs).
A width, formatted as ASCII characters in decimal.
Whitespace.
A height, again in ASCII decimal.
Whitespace.
The maximum color value (Maxval), again in ASCII decimal. Must be less than 65536 and more than zero.
A single whitespace character (usually a newline).
A raster of Height rows, in order from top to bottom. Each row consists of Width pixels, in order from left to right. Each pixel is a triplet of red, green, and blue samples, in that order. Each sample is represented in pure binary by either 1 or 2 bytes. If the Maxval is less than 256, it is 1 byte. Otherwise, it is 2 bytes. The most significant byte is first.
A row of an image is horizontal. A column is vertical. The pixels in the image are square and contiguous.

In the raster, the sample values are "nonlinear." They are proportional to the intensity of the ITU-R Recommendation BT.709 red, green, and blue in the pixel, adjusted by the BT.709 gamma transfer function. (That transfer function specifies a gamma number of 2.2 and has a linear section for small intensities). A value of Maxval for all three samples represents CIE D65 white and the most intense color in the color universe of which the image is part (the color universe is all the colors in all images to which this image might be compared).

BT.709's range of channel values (16-240) is irrelevant to PPM.

ITU-R Recommendation BT.709 is a renaming of the former CCIR Recommendation 709. When CCIR was absorbed into its parent organization, the ITU, ca. 2000, the standard was renamed. This document once referred to the standard as CIE Rec. 709, but it isn't clear now that CIE ever sponsored such a standard.

Note that another popular color space is the newer sRGB. A common variation from PPM is to substitute this color space for the one specified. You can use pnmgamma to convert between this variation and true PPM.

Note that a common variation from the PPM format is to have the sample values be "linear," i.e. as specified above except without the gamma adjustment. pnmgamma takes such a PPM variant as input and produces a true PPM as output.

Strings starting with "#" may be comments, the same as with PBM.

Note that you can use pamdepth to convert between a the format with 1 byte per sample and the one with 2 bytes per sample.

All characters referred to herein are encoded in ASCII. "newline" refers to the character known in ASCII as Line Feed or LF. A "white space" character is space, CR, LF, TAB, VT, or FF (I.e. what the ANSI standard C isspace() function calls white space).

Plain PPM
---------
There is actually another version of the PPM format that is fairly rare: "plain" PPM format. The format above, which generally considered the normal one, is known as the "raw" PPM format. See pbm for some commentary on how plain and raw formats relate to one another and how to use them.

The difference in the plain format is:

There is exactly one image in a file.
The magic number is P3 instead of P6.
Each sample in the raster is represented as an ASCII decimal number (of arbitrary size).
Each sample in the raster has white space before and after it. There must be at least one character of white space between any two samples, but there is no maximum. There is no particular separation of one pixel from another -- just the required separation between the blue sample of one pixel from the red sample of the next pixel.
No line should be longer than 70 characters.
Here is an example of a small image in this format.

P3
# feep.ppm
4 4
15
 0  0  0    0  0  0    0  0  0   15  0 15
 0  0  0    0 15  7    0  0  0    0  0  0
 0  0  0    0  0  0    0 15  7    0  0  0
15  0 15    0  0  0    0  0  0    0  0  0
There is a newline character at the end of each of these lines.

Programs that read this format should be as lenient as possible, accepting anything that looks remotely like a PPM image.

Internet Media Type
-------------------
No Internet Media Type (aka MIME type, content type) for PPM has been registered with IANA, but the value image/x-portable-pixmap is conventional.
Note that the PNM Internet Media Type image/x-portable-anymap also applies.

File Name
---------
There are no requirements on the name of a PPM file, but the convention is to use the suffix ".ppm". "pnm" is also conventional, for cases where distinguishing between the particular subformats of PNM is not convenient.

Compatibility
-------------
Before April 2000, a raw format PPM file could not have a maxval greater than 255. Hence, it could not have more than one byte per sample. Old programs may depend on this.

Before July 2000, there could be at most one image in a PPM file. As a result, most tools to process PPM files ignore (and don't read) any data after the first image.


---------
Wave Sort
---------

Data una lista di numeri interi, ordinare la lista come un'onda (wave).
Una lista di n elementi (0..n-1) viene ordinata come un'onda se:

  lst(0) >= lst(1) <= lst(2) >= lst(3) <= lst(4) >= ...

Cioè i numeri sono disposti in modo tale che il loro grafico sarà simile a un onda (up-down) piuttosto che a una linea retta di una lista ordinata in modo crescente/decrescente.

Esempio:
Input: lst = (10 5 6 3 2 20 100 80)
Output: lst = (10 5 6 2 20 3 100 80)
Nell'output il primo elemento è più grande del secondo, il secondo è più grande del terzo elemento e la stessa cosa si ripete fino alla fine della lista: elemento maggiore – elemento minore - elemento maggiore - elemento minore ecc.

Nota: data una lista iniziale, la soluzione non è univoca, cioè ci possono essere più liste che soddisfano la forma wave.

Primo metodo
------------
1) Ordinare la lista
2) Scambiare gli elementi adiacenti

(define (wave1 lst)
  (sort lst)
  (for (i 0 (- (length lst) 2) 2)
    (swap (lst i) (lst (+ i 1))))
  lst)

(wave1 '(10 5 6 3 2 20 100 80))
;-> (3 2 6 5 20 10 100 80)
(wave1 '(10 90 49 2 1 5 23))
;-> (2 1 10 5 49 23 90)

Secondo metodo
--------------
L'idea si basa sul fatto che se ci assicuriamo che tutti gli elementi posizionati pari (all'indice 0, 2, 4, ..) siano maggiori dei loro elementi dispari adiacenti, allora abbiamo trovato una soluzione.
1) Attraversare tutti gli elementi posizionati pari della lista:
  1a) Se l'elemento corrente è più piccolo dell'elemento dispari precedente, scambia precedente e corrente.
  1b) Se l'elemento corrente è più piccolo dell'elemento dispari successivo, scambia successivo e corrente.

(define (wave2 lst)
  (let (len (length lst))
    (for (i 0 (- len 1) 2)
      (if (and (> i 0) (> (lst (- i 1)) (lst i)))
        (swap (lst i) (lst (- i 1)))
      )
      (if (and (< i (- len 1)) (< (lst i) (lst (+ i 1))))
        (swap (lst i) (lst (+ i 1)))
      )
    )
    lst))

(wave2 '(10 5 6 3 2 20 100 80))
;-> (10 5 6 2 20 3 100 80)

(wave2 '(10 90 49 2 1 5 23))
;-> (90 10 49 1 5 2 23)

Nota: se nella lista esistono elementi multipli, allora il risultato può essere un onda che in qualche punto è piatta (due o più elementi uguali).

(wave1 '(3 2 1 3 6 9 8 6 7 6))
;-> (2 1 3 3 6 6 7 6 9 8)
(wave2 '(3 2 1 3 6 9 8 6 7 6))
;-> (3 1 3 2 9 6 8 6 7 6)


-------------
1 o 2 (again)
-------------

Scrivere una funzione che restituisce 2 con input 1 e restituisce 1 con input 2.
Nota: questa è una domanda semplice per vedere in quanti modi siamo in grado di risolvere il problema.
Inoltre non è specificato cosa deve ritornare la funzione per valori di input diversi da 1 e 2.

Metodo 1: soluzione standard
----------------------------
(define (sol01 x)
  (if (= x 1) 2 1))

(sol01 1)
;-> 2
(sol01 2)
;-> 1
(sol01 3)
;-> 1

Metodo 2: soluzione algebrica
-----------------------------
(define (sol02 x)
  (- 3 x))

(sol02 1)
;-> 2
(sol02 2)
;-> 1
(sol02 3)
;-> 0

Metodo 3: operatore xor (bitwise)
---------------------------------
(define (sol03 x)
  (^ x 1 2))

(sol03 1)
;-> 2
(sol03 2)
;-> 1
(sol03 3)
;-> 0

Vedi anche "1 o 2" su "Note libere 5".


--------------------------
Little Endian e Big Endian
--------------------------

Little e big endian sono due modi per memorizzare tipi di dati multibyte (int, float, ecc.). Nelle macchine little endian, l'ultimo byte della rappresentazione binaria del tipo di dati multibyte viene memorizzato per primo. Invece, nelle macchine big endian, il primo byte della rappresentazione binaria del tipo di dati multibyte viene memorizzato per primo.
Supponiamo che il numero intero sia memorizzato come 4 byte, quindi una variabile x con valore 0x01234567 verrà memorizzata come segue:
 
Big endian

            0x100   0x101   0x102   0x103
  +-------+-------+-------+-------+-------+-------+          
  |       |   01  |   23  |   45  |   67  |       |
  +-------+-------+-------+-------+-------+-------+

Little endian

            0x100   0x101   0x102   0x103
  +-------+-------+-------+-------+-------+-------+          
  |       |   67  |   45  |   23  |   01  |       |
  +-------+-------+-------+-------+-------+-------+

Come facciamo a sapere quale tipo di rappresentazione (little o big endian) usa il nostro computer?

Possiamo utilizzare la funzione primitiva "address".

********************
>>>funzione ADDRESS
********************
sintassi: (address int)
sintassi: (address float)
sintassi: (address string)

Restituisce l'indirizzo di memoria del numero intero (int), del numero a doppia virgola mobile (float) o la stringa (string). Questa funzione viene utilizzata per passare parametri alle funzioni di libreria che sono state importate utilizzando la funzione "import".

(set 's "\001\002\003\004")

(get-char (+ (address s) 3))   → 4

(set 'x 12345) ; x is a 64-bit long int
(get-long (address x))         → 12345

; on a big-endian CPU, i.e. PPC or SPARC 
; the 32-bit int is in high 32-bit part of the long int
(get-int (+ (address x) 4))    → 12345

; on a little-endian CPU, i.e. Intel i386
; the 32-bit int is in the low 32-bit part of the long int
(get-int (address x))          → 12345

; on both architectures (integers are 64 bit in newLISP)
(set 'x 1234567890)
(get-long (address x))         →  1234567890

Quando una stringa viene passata alla funzione di libreria C, l'indirizzo della stringa viene utilizzato automaticamente e in tal caso non è necessario utilizzare la funzione "address". Come mostra l'esempio, "address" può essere utilizzata per eseguire operazioni aritmetiche del puntatore sull'indirizzo della stringa.

"address" dovrebbe essere utilizzato solo su indirizzi persistenti di oggetti di dati a cui si fa riferimento da un simbolo di variabile, non da oggetti di espressioni intermedie volatili.

Possiamo scrivere la funzione che trova il tipo di memorizzazione del nostro computer:

(define (endian)
  (let (x 12345)
    (cond ((= x (get-int (+ (address x) 4))) "little")
          ((= x (get-int (address x))) "big"))))

(endian)
;-> "big"


---------------------------------------
Conversione Binario-Gray e Gray-Binario
---------------------------------------

Questa conversione può essere effettuata applicando le seguenti regole:

Da binario a gray:
1) Il bit più significativo (MSB) del codice gray è sempre uguale all'MSB del codice binario.
2) Gli altri bit del codice gray di uscita possono essere ottenuti XORing il bit del codice binario in corrispondenza di quell'indice e dell'indice precedente.

Da gray a binario:
1) Il bit più significativo (MSB) del codice binario è sempre uguale all'MSB del codice gray.
2) Gli altri bit del codice binario di uscita possono essere ottenuti controllando il bit del codice gray in quell'indice. Se il bit del codice gray corrente è 0, copiare il bit del codice binario precedente, altrimenti copiare l'inversione del bit del codice binario precedente.

; funzione di xor tra due caratteri
(define (xor-char a b)
  (if (= a b) "0" "1"))

; funzione che inverte un bit
(define (flip b)
  (if (= b "0") "1" "0"))

(define (binary-gray binary)
  ; MSB è lo stesso del codice binario
  (let ((len (length binary)) (gray (binary 0)))
    ; i bit rimanenti, vengono calcolati
    ; eseguendo lo XOR tra il precedente
    ; e il corrente binario  
    (for (i 1 (- len 1))
      (extend gray (xor-char (binary (- i 1)) (binary i)))
  )
  gray))

(binary-gray "01001")
;-> "01101"

(define (gray-binary gray)
  (let ((len (length gray)) (binary (gray 0)))
    ; MSB è lo stesso del codice gray
    (for (i 1 (- len 1))
      ; Se il bit corrente vale 0, 
      (if (= (gray i) "0")
          ; allora concatena il bit precedente
          (extend binary (binary (- i 1)))
          ; altrimenti concatena l'inverso del bit precedente
          (extend binary (flip (binary (- i 1))))
      )
  )
  binary))

(gray-binary "01101")
"01001"

(binary-gray (gray-binary "1111"))
;-> "1111"
(binary-gray (gray-binary "0000"))
;-> "0000"

(gray-binary (binary-gray "1111"))
;-> "1111"
(gray-binary (binary-gray "0000"))
;-> "0000"

=============================================================================

