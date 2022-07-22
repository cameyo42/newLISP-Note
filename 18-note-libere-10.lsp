================

 NOTE LIBERE 10

================

---------
Turochamp
---------

Turochamp è un programma di scacchi sviluppato da Alan Turing e David Champernowne nel 1948. Si tratta del primo programma per computer per giocare a scacchi, ma non è mai stato completato da Turing e Champernowne, poiché il suo algoritmo era troppo complesso per essere eseguito dai computer del tempo.
Turing ha giocato una partita contro l'informatico Alick Glennie utilizzando il programma su carta nell'estate del 1952, eseguendolo manualmente passo dopo passo.
Questa è la partita:

 1. e2-e4   e7-e5   
 2. Nb1-c3  Ng8-f6  
 3. d2-d4   Bf8-b4  
 4. Ng1-f3  d7-d6   
 5. Bc1-d2  Nb8-c6  
 6. d4-d5   Nc6-d4  
 7. h2-h4   Bc8-g4  
 8. a2-a4   Nd4xf3+ 
 9. g2xf3   Bg4-h5  
10. Bf1-b5+ c7-c6   
11. d5xc6   O-O     
12. c6xb7   Ra8-b8  
13. Bb5-a6  Qd8-a5  
14. Qd1-e2  Nf6-d7  
15. Rh1-g1  Nd7-c5  
16. Rg1-g5  Bh5-g6  
17. Ba6-b5  Nc5xb7  
18. O-O-O   Nb7-c5  
19. Bb5-c6  Rf8-c8  
20. Bc6-d5  Bb4xc3  
21. Bd2xc3  Qa5xa4  
22. Kc1-d2  Nc5-e6  
23. Rg5-g4  Ne6-d4  
24. Qe2-d3  Nd4-b5  
25. Bd5-b3  Qa4-a6  
26. Bb3-c4  Bg6-h5  
27. Rg4-g3  Qa6-a4  
28. Bc4xb5  Qa4xb5  
29. Qd3xd6  Rc8-d8  

17. Aa6-c4!          (+/-)
18. Aa6-c4!          (+/-)
21. ......  Da5-d8   (=)
22. h5!              (+/-)
23. Ad5xe6           (=)
23. ......  Tb8xb2!! (+/-)
29. Qd3xb5           (=)

Analisi con il programma di scacchi gratuito SlowChess 2.9:
https://www.3dkingdoms.com/chess/slow.htm


------------
Chess puzzle
------------

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

=============================================================================

