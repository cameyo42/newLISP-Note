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

=============================================================================

