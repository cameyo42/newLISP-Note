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

=============================================================================

