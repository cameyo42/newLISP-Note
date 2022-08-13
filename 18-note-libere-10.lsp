================

 NOTE LIBERE 10

================

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
Come esempio usiamo il modiulo "infix.lsp":

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

vVrsione leggermente più concisa con "eval":

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

It's like placeholders in function format but named so instead of %s you are using named placeholders
The effect should be like in PHP where you write something like this
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
 -  Cambiamenti continui della formazione dei lavoratori
 - Adeguamento dell'orario della riunione in base all'ultimo orario effettivo di inizio.
 - Uso dell'ultimo pezzo lavorato come motivo per il pezzo successivo.
 - Seduto in cerchio con un certo numero di persone. Una persona sussurra un segreto alla persona successiva che a sua volta lo sussurra alla persona successiva e così via.

=============================================================================

