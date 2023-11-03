================

 NOTE LIBERE 19

================

------
Gomoku
------

Gomoku, chiamato anche "Five in a Row", è un gioco da tavolo di strategia.
Si gioca tradizionalmente con pezzi Go (pietre bianche e nere) su una scacchiera Go 15×15 oppure 19×19.
Poiché i pezzi non vengono spostati o rimossi dalla scacchiera, il gomoku può anche essere giocato con carta e matita.

Regole
I giocatori si alternano a turno posizionando una pietra del loro colore su un'intersezione vuota.
Il Nero gioca per primo.
Il vincitore è il primo giocatore che forma una linea ininterrotta di cinque pietre del proprio colore in orizzontale, verticale o diagonale.
In alcune regole, questa linea deve essere lunga esattamente cinque pietre (sei o più pietre di fila non contano come una vittoria e vengono chiamate overline).
Se la scacchiera è completamente piena e nessuno ha formato una linea di 5 pietre, allora la partita finisce in parità.

Un libro sul gomoku: https://github.com/cameyo42/gomoku

Scriviamo alcune funzioni che ci permettono di giocare al gomoku (tra due giocatori umani).

Funzione che stampa la scacchiera:

(define (print-grid grid)
  (local (row col)
    (setq row (length grid))
    (setq col (length (first grid)))
    (println " " (join (map (fn(x) (format "%3d" x)) (sequence 0 (- col 1)))))
    (for (i 0 (- row 1))
      ;(setq fmt (string "%2d "))
      (print (format "%2d " i))
      (for (j 0 (- col 1))
        (cond ((= (grid i j) 0) (print "·  ")) ; libera
              ((= (grid i j) 1) (print "1  ")) ; pietra nera
              ((= (grid i j) 2) (print "O  ")) ; pietra bianca
              (true (println "Error: cell " i j ": " (grid i j)))
        )
      )
      (println))))

(setq board '((1 2 0 1 0 1 0 1 2)
              (2 1 0 1 1 2 0 1 1)
              (0 2 0 2 0 1 1 0 0)
              (2 1 2 2 0 1 1 1 1)
              (1 0 2 2 1 1 1 0 2)
              (0 1 1 1 2 0 0 1 0)
              (0 1 1 1 1 1 0 1 1)
              (0 1 2 0 1 2 1 0 0)
              (2 0 0 2 1 1 0 0 1)))

Significato dei valori della matrice:

  2 --> pietra bianca
  1 --> pietra nera
  0 --> cella vuota

(print-grid board)
;->   0  1  2  3  4  5  6  7  8
;-> 0 1  O  ·  1  ·  1  ·  1  O
;-> 1 O  1  ·  1  1  O  ·  1  1
;-> 2 ·  O  ·  O  ·  1  1  ·  ·
;-> 3 O  1  O  O  ·  1  1  1  1
;-> 4 1  ·  O  O  1  1  1  ·  O
;-> 5 ·  1  1  1  O  ·  ·  1  ·
;-> 6 ·  1  1  1  1  1  ·  1  1
;-> 7 ·  1  O  ·  1  O  1  ·  ·
;-> 8 O  ·  ·  O  1  1  ·  ·  1

Funzione di setup per una nuova partita:

(define (setup dimension)
  ; all symbols/variables are global
  (setq dim dimension)
  (setq board (dup (dup 0 dim) dim))
  (setq move-white 0)
  (setq move-black 0)
  (print-grid board))

Funzione per la mossa del Nero (Black):

(define (black row col)
  (cond ((or (< row 0) (>= row dim)) (println "Error: non-existent row " row))
        ((or (< col 0) (>= col dim)) (println "Error: non-existent col " col))
        ((or (= (board row col) 1) (= (board row col) 2))
          (println  "Error: not-free cell " row { } col))
        ; put stone on board
        (true (setf (board row col) 1) (++ move-black)))
  (print-grid board))

Funzione per la mossa del Bianco (White):

(define (white row col)
  (cond ((or (< row 0) (>= row dim)) (println "Error: non-existent row " row))
        ((or (< col 0) (>= col dim)) (println "Error: non-existent col " col))
        ((or (= (board row col) 1) (= (board row col) 2))
          (println  "Error: not-free cell " row { } col))
        ; put stone on board
        (true (setf (board row col) 2) (++ move-white)))
  (print-grid board))

Adesso dobbiamo scrivere la funzione che verifica se uno dei due giocatori ha vinto (cioè ha creato una linea di 5 pietre).

Algoritmo
Ricerca orizzontale
1) unire tutti i valori delle righe in una stringa separando ogni riga con il valore "0" (cella vuota)
2) ricercare nella stringa dei pattern "11111" (vince in nero) e "22222" (vince il bianco).

Ricerca orizzontale
1) unire tutti i valori delle colonne in una stringa separando ogni riga con il valore "0" (cella vuota)
2) ricercare nella stringa dei pattern "11111" (vince in nero) e "22222" (vince il bianco).

Ricerca diagonale '/':
1) unire tutti i valori delle diagonali '/' in una stringa separando ogni riga con il valore "0" (cella vuota)
2) ricercare nella stringa dei pattern "11111" (vince in nero) e "22222" (vince il bianco).

Ricerca diagonale '\':
1) unire tutti i valori delle diagonali '\' in una stringa separando ogni riga con il valore "0" (cella vuota)
2) ricercare nella stringa dei pattern "11111" (vince in nero) e "22222" (vince il bianco).

Vediamo un esempio con una matrice 3x3:

(setq t '((1 0 2)
          (1 2 0)
          (1 2 0)))

Ricerca orizzontale:
1) stringa = "10201200120"
2) ricerca "111" --> non trovato, ricerca "222" --> non trovato

Ricerca verticale:
1) stringa = "11100220200"
2) ricerca "111" --> trovato, ricerca "222" --> non trovato

Ricerca diagonale '/':
1) stringa = "1001022100210"
2) ricerca "111" --> non trovato, ricerca "222" --> non trovato

Ricerca diagonale '\':
1) stringa = "2000012001201"
2) ricerca "111" --> non trovato, ricerca "222" --> non trovato

Per ottenere le stringhe delle diagonali utilizziamo le funzioni "diag1" e "diag2" (leggermente modificate per creare una stringa) definite in "Attraversamento di matrici lungo le diagonali" in "Note libere 18".

(define (diag1 matrix)
  (local (out row cols)
    (setq out '())
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    ; prima metà
    (for (i 0 (- cols 1))
      (setq tmp '())
      (for (j i 0)
        (if (< (- i j) rows) (push (matrix (- i j) j) tmp -1))
      )
      (push tmp out -1)
    )
    ;(println out)
    ; seconda metà
    (for (i 1 (- rows 1))
      (setq tmp '())
      (setq k i)
      (for (j (- cols 1) 0)
        (if (< k rows) (begin (push (matrix k j) tmp -1) (++ k)))
      )
      (push tmp out -1)
    )
    out))

(print-grid t)
;->   0  1  2
;-> 0 1  ·  O
;-> 1 1  O  ·
;-> 2 1  O  ·

(diag1 t)
;-> ((1) (0 1) (2 2 1) (0 2) (0))

(define (swap-cols matrix)
  (local (rows cols)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (for (r 0 (- rows 1))
      (for (c 0 (- (/ cols 2) 1))
        (swap (matrix r c) (matrix r (- cols c 1)))
      )
    )
  matrix))

(define (diag2 matrix) (diag1 (swap-cols matrix)))

(diag2 t)
;-> ((2) (0 0) (1 2 0) (1 2) (1))

Funzione per verificare se una posizione è vinta da un giocatore:

(define (endgame? grid)
  (local (winner hrow vrow d1 d2)
    (setq winner nil)
    ; Ricerca orizzontale
    (setq hrow (join (map join (map (fn(x) (map string x)) board)) "0"))
    ;(println hrow)
    (cond ((find "11111" hrow) (setq winner "1")
          (println "trovato 11111 in orizzontale"))
          ((find "22222" hrow) (setq winner "2")
          (println "trovato 11111 in orizzontale")))
    ; Ricerca verticale
    ; per unire le colonne trasponiamo la matrice e poi uniamo le righe
    (setq vrow (join (map join (map (fn(x) (map string x)) (transpose board))) "0"))
    ;(println vrow)
    (cond ((find "11111" vrow) (setq winner "1")
          (println "trovato 11111 in verticale:"))
          ((find "22222" vrow) (setq winner "2")
          (println "trovato 22222 in verticale:")))
    ; Ricerca diagonale'/'
    (setq d1 (join (map join (map (fn(x) (map string x)) (diag1 board))) "0"))
    ;(println d1)
    (cond ((find "11111" d1) (setq winner "1")
          (println "trovato 11111 in diagonale '/'"))
          ((find "22222" d1) (setq winner "2")
          (println "trovato 22222 in diagonale '/'")))
    ; Ricerca diagonale'\'
    ;(println d2)
    (setq d2 (join (map join (map (fn(x) (map string x)) (diag2 board))) "0"))
    (cond ((find "11111" d2) (setq winner "1")
          (println "trovato 11111 in diagonale '\\'"))
          ((find "22222" d2) (setq winner "2")
          (println "trovato 22222 in diagonale '\\'")))
    winner))

Facciamo una prova:
(print-grid board)
;->   0  1  2  3  4  5  6  7  8
;-> 0 1  O  ·  1  ·  1  ·  1  O
;-> 1 O  1  ·  1  1  O  ·  1  1
;-> 2 ·  O  ·  O  ·  1  1  ·  ·
;-> 3 O  1  O  O  ·  1  1  1  1
;-> 4 1  ·  O  O  1  1  1  ·  O
;-> 5 ·  1  1  1  O  ·  ·  1  ·
;-> 6 ·  1  1  1  1  1  ·  1  1
;-> 7 ·  1  O  ·  1  O  1  ·  ·
;-> 8 O  ·  ·  O  1  1  ·  ·  1

(endgame? grid)
;-> trovato 11111 in orizzontale
;-> trovato 11111 in diagonale '/'
;-> trovato 22222 in diagonale '\'
;-> "2"

Nota: in una partita regolare ci può essere un solo vincitore.

Riscriviamo la funzione "endgame?" in modo più compatto:

(define (end-game? grid)
  (local (winner str)
    (setq winner "")
    ; Ricerca orizzontale
    (setq str (join (map join (map (fn(x) (map string x)) board)) "0"))
    (cond ((find "11111" str) (setq winner "nero"))
          ((find "22222" str) (setq winner "bianco")))
    ; Ricerca verticale
    ; per unire le colonne trasponiamo la matrice e poi uniamo le righe
    (setq str (join (map join (map (fn(x) (map string x)) (transpose board))) "0"))
    (cond ((find "11111" str) (setq winner "nero"))
          ((find "22222" str) (setq winner "bianco")))
    ; Ricerca diagonale'/'
    (setq str (join (map join (map (fn(x) (map string x)) (diag1 board))) "0"))
    (cond ((find "11111" str) (setq winner "nero"))
          ((find "22222" str) (setq winner "bianco")))
    ; Ricerca diagonale'\'
    (setq str (join (map join (map (fn(x) (map string x)) (diag2 board))) "0"))
    (cond ((find "11111" str) (setq winner "nero"))
          ((find "22222" str) (setq winner "bianco")))
    (if (= winner "") (println "la partita continua...")
                      (println "Vince il " winner))))

(end-game? board)
;-> "Vince il bianco"

Adesso possiamo fare una partita (9x9):

(setup 9)
;->    0  1  2  3  4  5  6  7  8
;->  0 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  1 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  2 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  3 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  4 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  5 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  6 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  7 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  8 ·  ·  ·  ·  ·  ·  ·  ·  ·
(black 1 1)
;->    0  1  2  3  4  5  6  7  8
;->  0 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  1 ·  1  ·  ·  ·  ·  ·  ·  ·
;->  2 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  3 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  4 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  5 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  6 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  7 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  8 ·  ·  ·  ·  ·  ·  ·  ·  ·
(white 3 1)
;->    0  1  2  3  4  5  6  7  8
;->  0 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  1 ·  1  ·  ·  ·  ·  ·  ·  ·
;->  2 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  3 ·  O  ·  ·  ·  ·  ·  ·  ·
;->  4 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  5 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  6 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  7 ·  ·  ·  ·  ·  ·  ·  ·  ·
;->  8 ·  ·  ·  ·  ·  ·  ·  ·  ·
(end-game? board)
;-> la partita continua...
...


------------------------
Rotazione di una matrice
------------------------

Problema: ruotare di un posto gli elementi di una data matrice in senso orario. 
Prima occore ruotare gli elementi della matrice in modo che ciascun di essi si sposti un passo avanti in senso orario lungo il confine più esterno della matrice. 
Poi questa operazione viene eseguita iterativamente per ogni "anello" o strato della matrice, partendo dallo strato più esterno e procedendo verso il centro.

Consideriamo ad esempio la seguente matrice:

   1  2  3  4  5
   6  7  8  9 10
  11 12 13 14 15
  16 17 18 19 20
  21 22 23 24 25

Dopo aver eseguito l’operazione di rotazione, la matrice diventa:

   6  1  2  3  4
  11 12  7  8  5
  16 17 13 9  10
  21 18 19 14 15
  22 23 24 25 20

Dividiamo il problema in sottoproblemi. 
Ogni sottoproblema comporta la rotazione degli elementi di un "anello" della matrice. 
Per ruotare gli elementi di un singolo anello, eseguiamo quattro diverse operazioni:

Caso A (da basso-destra a sinistra) (0 -> 1)
sposta gli elementi dalla riga inferiore dell'anello corrente, da destra a sinistra.
  2----------3
  |          |
  |          |
  1----------0

Caso B (da basso-sinistra in alto) (0 -> 1)
sposta gli elementi dalla colonna più a destra dell'anello corrente, dal basso verso l'alto.
  1----------2
  |          |
  |          |
  0----------3

Caso C (da alto-sinistra a destra) (0 -> 1)
sposta gli elementi dalla riga superiore dell'anello corrente, da sinistra a destra.
  0----------1
  |          |
  |          |
  3----------2

Caso D (da alto-destra in basso) (0 -> 1)
sposta gli elementi dalla colonna più a sinistra dell'anello corrente, dall'alto verso il basso.
  3----------0
  |          |
  |          |
  2----------1

Applichiamo questa operazione partendo dall'anello più esterno e poi agli anelli interni fino al centro.

Funzione che ruota di un posto un anello di una matrice:

(define (rotate-ring matrix row col idx)
  (local (i value temp)
    (setq value (matrix row col))
    (setq temp 0)
    (setq i (- col 1))
    ; case A
    ; 2----------3
    ; |          |
    ; |          |
    ; 1----------0
    ; Bottom right to left    
    (while (>= i idx)
      (setq temp (matrix row i))
      (setf (matrix row i) value)
      (setq value temp)
      (-- i)
    )
    ; case B
    ; 1----------2
    ; |          |
    ; |          |
    ; 0----------3
    ; Bottom left to top    
    (setq i (- row 1))
    (while (>= i idx)
      (setq temp (matrix i idx))
      (setf (matrix i idx) value)
      (setq value temp)
      (-- i)
    )
    ; case C
    ; 0----------1
    ; |          |
    ; |          |
    ; 3----------2
    ; Top left to right    
    (setq i (+ idx 1))
    (while (<= i col)
      (setq temp (matrix idx i))
      (setf (matrix idx i) value)
      (setq value temp)
      (++ i)
    )  
    ; case D
    ; 3----------0
    ; |          |
    ; |          |
    ; 2----------1
    ; Top right to bottom    
    (setq i (+ idx 1))
    (while (<= i row)
      (setq temp (matrix i col))
      (setf (matrix i col) value)
      (setq value temp)
      (++ i)
    )
    matrix))

(setq m '((1 2 3)
          (4 5 6)
          (7 8 9)))

(rotate-ring m 2 2 0)
;-> ((4 1 2)
;->  (7 5 3)
;->  (8 9 6)

(setq q '(( 1  2  3  4  5)
          ( 6  7  8  9 10)
          (11 12 13 14 15) 
          (16 17 18 19 20) 
          (21 22 23 24 25)))

(rotate-ring q 4 4 0)
;-> (( 6  1  2  3  4) 
;->  (11  7  8  9  5) 
;->  (16 12 13 14 10) 
;->  (21 17 18 19 15) 
;->  (22 23 24 25 20))

Funzione che ruota di un posto una matrice:

(define (rotate-one matrix)
  (local (row col size ring)
    (setq row (length matrix))
    (setq col (length (matrix 0)))
    (setq size (min row col))
    (setq ring 0)
    ; rotate one ring at time (outside -> inside)
    (while (< ring (/ size 2))
      (-- row)
      (-- col)
      (setq matrix (rotate-ring matrix row col ring))
      (++ ring)
    )
    matrix))

(rotate-one q)
;-> (( 6  1  2  3  4) 
;->  (11 12  7  8  5) 
;->  (16 17 13  9 10) 
;->  (21 18 19 14 15) 
;->  (22 23 24 25 20))

(rotate-one m)
;-> (4 1 2)
;-> (7 5 3)
;-> (8 9 6)

(setq r '((1 2 3)
          (8 9 4)
          (7 6 5)))

(rotate-one r)
;-> ((8 1 2) 
;->  (7 9 3)
;->  (6 5 4))


--------
Bar Dice
--------

Bar Dice è un semplice gioco usato nei bar per stabilire chi paga da bere.
Si lanciano 5 dadi a sei facce cercando di ottenere la mano migliore.
Il punteggio si basa sulla frequenza delle facce con le stesse cifre.
Ogni mano deve includere almeno un "uno", per essere una mano valida.
Gli "Uno" fungono da "jolly" e possono essere abbinati a qualsiasi altra cifra.
Il punteggio di una mano dipende innanzitutto dalla frequenza delle cifre e poi dal loro valore, cioè dalla coppia: (frequenza cifra).
Per esempio:

(1 3 3 3 5)->(3 4) vince contro (6 1 6 2 4)->(6 3) perchè la frequenza della prima coppia (4) è maggiore di quella della seconda coppia (2).

(1 1 3 4 5)->(5 3) pareggia con (5 2 3 5 5)->(5 3).

(1 1 2 3 4)->(4 3) perde con (6 1 2 3 6)->(6 3)).

Questo significa che la mano con il punteggio più alto è composta interamente da 6 e 1, mentre la mano con il punteggio più basso è qualsiasi mano senza 1.

Nota: 1-1-1-1-1 vale quanto 6-6-6-6-6.

Funzione che calcola il valore di una mano.
Restituisce una coppia: (numero con frequenza massima, frequenza massima)

(define (value p)
  (local (faces conta lst pat coppia)
    (setq faces '(1 2 3 4 5 6))
    ; conta la frequenza delle facce uscite dal lancio
    (setq conta (count faces p))
    (cond
      ; se non esiste alcun 1, allora il valore è 0.
      ((zero? (conta 0)) (setq coppia '(0 0)))
      (true
        ; lst = (1 frequenza) (2 frequenza) ... (6 frequenza)
        (setq lst (map list faces (count faces p)))
        ; frequenza massima
        (setq fmax (apply max conta))
        ; crea il pattern per cercare la frequenza massima e il numero associato
        (setq pat (list '? fmax))
        ; coppia = numero, frequenza massima
        (setq coppia (last (find-all pat lst)))
        (cond ((= (coppia 0) 1) ; 1 è il numero con maggiore frequenza
                (if (= (coppia 1) 5)  ; se sono tutti 1
                    (setq coppia '(6 5))
                    ; altrimenti
                    ; coppia = numero massimo del lancio, (numero di 1) + 1
                    (setq coppia (list (apply max p) (+ (coppia 1) 1)))))
              (true ; 1 non è il numero con maggiore frequenza
              ; coppia = numero della coppia, (frequenza della coppia + numero di 1)
                (setq coppia (list (coppia 0) (+ (coppia 1) (lst 0 1)))))
        )
      )
    )
    coppia))

Facciamo alcune prove:

(value '(1 1 1 1 1))
;-> (6 5)
(value '(1 4 4 3 3))
;-> (4 3)
(value '(1 5 5 5 5))
;-> (5 5)
(value '(2 5 5 5 5))
;-> (0 0)
(value '(1 1 5 1 1))
;-> (5 5)
(value '(1 1 1 1 1))
;-> (6 5)
(value '(1 4 4 3 3))
;-> (4 3)
(value '(1 5 5 5 5))
;-> (5 5)
(value '(2 5 5 5 5))
;-> (0 0)
(value '(1 1 5 1 1))
;-> (5 5)
(value '(2 3 4 5 6))
;-> (0 0)

Funzione che calcola il vincitore tra due lanci:

(define (winner p1 p2)
  (local (res1 res2 num1 num2 freq1 freq2)
    (setq res1 (value p1))
    (setq res2 (value p2))
    (println res1 { } res2)
    (setq num1 (res1 0))
    (setq freq1 (res1 1))
    (setq num2 (res2 0))
    (setq freq2 (res2 1))
    (cond ((= freq1 freq2)
            (cond ((= num1 num2) 0)
                  ((> num1 num2) 1)
                  ((< num1 num2) 2)))
          ((> freq1 freq2) 1)
          ((< freq1 freq2) 2))))

Facciamo alcune prove:

(winner '(2 1 5 6 6)  '(6 2 6 6 6))
;-> (6 3) (0 0)
;-> 1

(winner '(2 4 5 6 6)  '(6 2 6 6 6))
;-> (0 0) (0 0)
;-> 0

(winner '(1 2 3 4 5)  '(5 4 3 2 1))
;-> (5 2) (5 2)
;-> 0

(winner '(1 5 5 3 2)  '(5 4 1 6 6))
;-> (5 3) (6 3)
;-> 2

(winner '(3 2 2 2 1)  '(4 1 3 6 6))
;-> (2 4) (6 3)
;-> 1

(winner '(1 1 1 1 1)  '(6 1 1 6 6))
;-> (6 5) (6 5)
;-> 0

(winner '(1 3 3 4 4)  '(1 2 2 5 5))
;-> (4 3) (5 3)
;-> 2

(winner '(1 3 3 5 5)  '(1 3 3 2 2))
;-> (5 3) (3 3)
;-> 1

(winner '(1 3 3 3 4)  '(1 1 3 3 3))
;-> (3 4) (3 5)
;-> 2

(winner '(2 2 2 6 1)  '(5 3 3 1 2))
;-> (2 4) (3 3)
;-> 1

(winner '(5 5 5 1 5)  '(1 1 1 1 1))
;-> (5 5) (6 5)
;-> 2

(winner '(1 1 1 1 1)  '(1 1 5 1 1))
;-> (6 5) (5 5)
;-> 1


-----------------
Numeri bilanciati
-----------------

Un numero bilanciato è un numero la cui somma delle cifre a sinistra del punto centrale è uguale alla somma delle cifre a destra del punto centrale.

Vediamo alcuni esempi:
12721 è un numero bilanciato, perché la somma delle cifre a sinistra del punto medio (che è la cifra al centro del numero quando il numero di cifre è dispari) vale 3 (1 + 2), che è uguale alla somma delle cifre a destra del punto medio (2 + 1).
1203 è un numero bilanciato, perchè 1 + 2 = 0 + 3 = 3
13425 non è un numero bilanciato perchè 1 + 3 != 2 + 5

(define (balanced? num)
  (local (lst len mid)
    (setq lst (explode (string num)))
    (setq len (length lst))
    (setq mid (/ len 2))
    (= (apply + (map int (slice lst 0 mid)))          ; somma sx
       (apply + (map int (slice lst (- mid) mid)))))) ; somma dx

Facciamo alcune prove:

(balanced? 12721)
;-> true

(balanced? 1203)
;-> true

(balanced? 13425)
;-> nil

(balanced? 1234567890987654321)
;-> true


-----------------
Numeri di Euclide
-----------------

I numeri di Euclide sono una sequenza di numeri interi positivi generati utilizzando la formula:

E(n) = p1*p2*p3* ... *pn + 1

dove p1, p2, p3, ..., pn sono i primi n numeri primi.

In altre parole, E(n) è il prodotto dei primi n numeri primi + 1

I primi numeri di Euclide sono:

E(1) = 3
E(2) = 7
E(3) = 31
E(4) = 211
E(5) = 2311
E(6) = 30031
E(7) = 510511
...

I numeri di Euclide sono rari e diventano rapidamente molto grandi all’aumentare di n.

Sequenza OEIS A006862:
  2, 3, 7, 31, 211, 2311, 30031, 510511, 9699691, 223092871, 6469693231, 
  200560490131, 7420738134811, 304250263527211, 13082761331670031, 
  614889782588491411, 32589158477190044731, ...

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

Per semplicità calcoliamo sempre 10000 numeri primi.
Vedi "Quanti numeri primi ci sono?" in "Note libere 15".

(define (euclide limit)
  (setq out '())
  (setq primi (primes-to 10000))
  (setq prod 1L)
  (for (i 0 (- limit 1))
    (setq prod (* prod (primi i)))
    (push (+ prod 1) out -1)
  )
  out)

(euclide 16)
;-> (3L 7L 31L 211L 2311L 30031L 510511L 9699691L 223092871L 
;->  6469693231L 200560490131L 7420738134811L 304250263527211L
;->  13082761331670031L 614889782588491411L 32589158477190044731L)


---------------
Numeri di Moran
---------------

Un numero N è un numero di Moran se N diviso per la somma delle sue cifre produce un numero primo.
I numeri di Moran sono un sottoinsieme dei numeri di Harshad.

Sequenza OEIS A001101:
  18, 21, 27, 42, 45, 63, 84, 111, 114, 117, 133, 152, 153, 156, 171, 190,
  195, 198, 201, 207, 209, 222, 228, 247, 261, 266, 285, 333, 370, 372, 399,
  402, 407, 423, 444, 465, 481, 511, 516, 518, 531, 555, 558, 592, 603, ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (moran? num)
  (let (sum (digit-sum num))
    (and (zero? (% num sum))
        (prime? (/ num sum)))))

Facciamo alcune prove:

(moran? 61)
;-> nil
(moran? 63)
;-> true

(setq m (map moran? (sequence 1 100)))
(filter true? (map (fn(x) (if x (+ $idx 1))) m))
;-> (18 21 27 42 45 63 84)

Vediamo la velocità:

(time (map moran? (sequence 1 100000)))
;-> 100.128
(time (map moran? (sequence 1 1000000)))
;-> 1080.027
(time (map moran? (sequence 1 10000000)))
;-> 12052.906

(define (moran-to limit)
  (local (out)
    (setq out '())
    (for (i 1 limit)
      (if (moran? i) (push i out -1))
    )
    out))

(moran-to 200)
;-> (18 21 27 42 45 63 84 111 114 117 133 152 153 156 171 190 195 198)


----------------------------------------
Crivello di Sundaram (Sieve of Sundaram)
----------------------------------------

Il Crivello di Sundaram è un algoritmo per generare numeri primi fino a un dato numero.
È stato ideato nel 1934 dal matematico indiano Sundaram.

Algoritmo
Dalla lista degli interi fra 1 ed n vengono rimossi tutti i numeri della forma i + j + 2ij, dove:
- i,j sono interi naturali e 1<= i <= j
- i + j + 2ij <= n
I numeri rimasti vengono moltiplicati per due e ai risultati viene addizionato uno.
Si ottiene così la lista dei numeri primi dispari inferiori a 2n + 2.

(define (sundaram num)
  (if (< num 2) '()
  (if (= num 2) '(2)
  ;else
  (local (out limit sieve i j)
    (++ num)
    (setq out '(2))
    (setq limit (+ (/ (- num 2) 2) 1))
    (setq sieve (array limit '(nil)))
    (setq i 1 j 0)
    (while (< i limit)
      (setq j i)
      (while (< (+ i j (* 2 i j)) limit)
        ; (i + j + 2ij) true (unset)
        (setf (sieve (+ i j (* 2 i j))) true)
        (++ j)
      )
      (++ i)
    )
    (for (i 1 (- limit 1))
      (if (nil? (sieve i)) (push (+ (* i 2) 1) out -1))
    )
  out))))

Facciamo alcune prove:

(sundaram 2)
;-> (2)
(sundaram 3)
;-> (2 3)
(sundaram 25)
; (2 3 5 7 11 13 17 19 23)
(sundaram 97)
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)


--------------------------------------
Numeri pari e dispari in un intervallo
--------------------------------------

Quanti sono i numeri interi pari e dispari all'interno di un dato intervallo?
Ad esempio, nell'intervallo [2, 10], ci sono 5 numeri pari (2, 4, 6, 8 e 10) e 4 numeri dispari (3, 5, 7 e 9).

Dato un intervallo [a, b]:
Controlla se "a" è maggiore di "b".
In caso positivo, scambiare i valori (deve essere "a" minore di "b")
Calcolare la lunghezza dell'intervallo: lunghezza = (b - a) + 1.
Determinare se "a" è pari o dispari.
Determinare se "b" è pari o dispari.
Determinare la lunghezza in base alle seguenti ipotesi:
  Se "a" è pari e "b" pari,
  Se "a" è dispari e "b" pari,
  Se "a" è pari e "b" dispari,
  Se "a" è dispari e "b" dispari,

(define (even-odd a b)
  (local (len pari dispari)
    (if (> a b) (swap a b))
    (setq len (+ (- b a) 1))
    (cond ((even? a) 
            (if (even? b) 
                (setq pari (+ (/ len 2) 1))
                (setq pari (/ len 2))
            )
            (setq dispari (- len pari)))
          ((odd? a)
            (if (odd? b)
                (setq dispari (+ (/ len 2) 1))
                (setq dispari (/ len 2))
            )
            (setq pari (- len dispari)))
    )
    (list pari dispari)))

Facciamo alcune prove:

(even-odd 2 10)
;-> (5 4)

(even-odd 2 2)
;-> (1 0)

(even-odd 3 3)
;-> (0 1)

(even-odd 1 100)
;-> (50 50)


-----------------------------------------------------------
Numeri con somma delle cifre uguale ad un quadrato perfetto
-----------------------------------------------------------

Trovare la sequenza dei numeri in cui la somma delle cifre è uguale ad un quadrato perfetto.

Sequenza OEIS A028839:
  1, 4, 9, 10, 13, 18, 22, 27, 31, 36, 40, 45, 54, 63, 72, 79, 81, 88, 90,
  97, 100, 103, 108, 112, 117, 121, 126, 130, 135, 144, 153, 162, 169, 171,
  178, 180, 187, 196, 202, 207, 211, 216, 220, 225, 234, 243, 252, 259, 261,
  268, 270, 277, 286, 295, 301, 306, ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (square? num)
"Check if an integer is a perfect square"
  (local (a)
    (setq a (bigint num))
    (while (> (* a a) num)
      (setq a (/ (+ a (/ num a)) 2))
    )
    (= (* a a) num)))

; alternative faster version (non big-integer)
(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(define (check? num)
  (square? (digit-sum num)))

(filter check? (sequence 1 200))
;-> (1 4 9 10 13 18 22 27 31 36 40 45 54 63 72 79 81 88 90 97 100 103 
;->  108 112 117 121 126 130 135 144 153 162 169 171 178 180 187 196)


----------------------------------------
Numeri senza radice digitale nelle cifre
----------------------------------------

Trovare la sequenza di numeri che non contengono la radice digitale nelle loro cifre.

Sequenza OEIS A119247:
  11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, 24, 25, 26, 27, 28, 31, 32,
  33, 34, 35, 36, 37, 38, 41, 42, 43, 44, 45, 46, 47, 48, 51, 52, 53, 54,
  55, 56, 57, 58, 61, 62, 63, 64, 65, 66, 67, 68, 71, 72, 73, 74, 75, 76,
  77, 78, 81, 82, 83, 84, 85, 86, 87, 88, 101, ...

(define (digit-root num)
"Calculates the repeated sum of the digits of an integer"
    (+ 1 (% (- (abs num) 1) 9)))

(define (check? num) (nil? (find (string (digit-root num)) (string num))))

(filter check? (sequence 1 101))
;-> (11 12 13 14 15 16 17 18 21 22 23 24 25 26 27 28 31 32
;->  33 34 35 36 37 38 41 42 43 44 45 46 47 48 51 52 53 54
;->  55 56 57 58 61 62 63 64 65 66 67 68 71 72 73 74 75 76
;->  77 78 81 82 83 84 85 86 87 88 101)


--------------------------------------------------------
Generazione di tutte le sottoliste contigue di una lista
--------------------------------------------------------

Data una lista, generare tutte le possibili sottoliste contigue.
Per esempio:

lista = (1 2 3 4)
sottoliste contigue = (1) (1 2) (1 2 3) (1 2 3 4)
                      (2) (2 3) (2 3 4)
                      (3) (3 4)
                      (4)

(define (contigue lst)
  (setq out '())
  (setq len (length lst))
  (for (i 0 (- len 1))
    (for (j 1 (- len i))
      ;(println i { } j)
      (push (slice lst i j) out -1)
    )
  )
  out)

(contigue '(1 2 3 4))
;-> ((1) (1 2) (1 2 3) (1 2 3 4) (2) (2 3) (2 3 4) (3) (3 4) (4))

(contigue (sequence 1 5))
;-> ((1) (1 2) (1 2 3) (1 2 3 4) (1 2 3 4 5) 
;->  (2) (2 3) (2 3 4) (2 3 4 5) 
;->  (3) (3 4) (3 4 5)
;->  (4) (4 5)
;->  (5))


-----------------------
Percorsi in una matrice
-----------------------

Data una matrice di caratteri, determinare tutti i possibili percorsi dall'angolo in alto a sinistra all'angolo in basso a destra della matrice. 
I percorsi possono muoversi solo nelle direzioni verso il basso e verso destra.

Per risolvere il problema usiamo un approccio ricorsivo. 
Ad ogni passaggio abbiamo due opzioni: spostarci verso il basso o spostarci a destra. 
Esploriamo ricorsivamente entrambe le opzioni tenendo traccia del percorso corrente.

(define (paths matrix)
  (local (rows cols percorso out)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (setq percorso (array (+ rows cols (- 1)) '("")))
    (setq out '())
    (find-paths 0 0 0 (+ rows cols (- 1)))
    out))

(define (find-paths row col conta k)
  (cond ((or (>= row rows) (>= col cols)) nil)
        (true
          (setf (percorso conta) (matrix row col))
          (find-paths (+ row 1) col (+ conta 1) k)
          (find-paths row (+ col 1) (+ conta 1) k)
          (if (= (+ conta 1) k) (push (array-list percorso) out -1))
        )))

(setq a '(("A" "B")
          ("C" "D")))
(paths a)
(pow 2 4)
(pow 2 3)
(setq b '(("A" "B" "C" "D")
          ("E" "F" "G" "H")
          ("I" "J" "K" "L")
          ("M" "N" "O" "P")
          ("Q" "R" "S" "T")))
(paths b)
;-> (("A" "E" "I" "M" "Q" "R" "S" "T") ("A" "E" "I" "M" "N" "R" "S" "T") 
;->  ("A" "E" "I" "M" "N" "O" "S" "T") ("A" "E" "I" "M" "N" "O" "P" "T")
;->  ("A" "E" "I" "J" "N" "R" "S" "T") ("A" "E" "I" "J" "N" "O" "S" "T")
;->  ("A" "E" "I" "J" "N" "O" "P" "T") ("A" "E" "I" "J" "K" "O" "S" "T")
;->  ("A" "E" "I" "J" "K" "O" "P" "T") ("A" "E" "I" "J" "K" "L" "P" "T")
;->  ("A" "E" "F" "J" "N" "R" "S" "T") ("A" "E" "F" "J" "N" "O" "S" "T")
;->  ("A" "E" "F" "J" "N" "O" "P" "T") ("A" "E" "F" "J" "K" "O" "S" "T")
;->  ("A" "E" "F" "J" "K" "O" "P" "T") ("A" "E" "F" "J" "K" "L" "P" "T")
;->  ("A" "E" "F" "G" "K" "O" "S" "T") ("A" "E" "F" "G" "K" "O" "P" "T")
;->  ("A" "E" "F" "G" "K" "L" "P" "T") ("A" "E" "F" "G" "H" "L" "P" "T")
;->  ("A" "B" "F" "J" "N" "R" "S" "T") ("A" "B" "F" "J" "N" "O" "S" "T")
;->  ("A" "B" "F" "J" "N" "O" "P" "T") ("A" "B" "F" "J" "K" "O" "S" "T")
;->  ("A" "B" "F" "J" "K" "O" "P" "T") ("A" "B" "F" "J" "K" "L" "P" "T")
;->  ("A" "B" "F" "G" "K" "O" "S" "T") ("A" "B" "F" "G" "K" "O" "P" "T")
;->  ("A" "B" "F" "G" "K" "L" "P" "T") ("A" "B" "F" "G" "H" "L" "P" "T")
;->  ("A" "B" "C" "G" "K" "O" "S" "T") ("A" "B" "C" "G" "K" "O" "P" "T")
;->  ("A" "B" "C" "G" "K" "L" "P" "T") ("A" "B" "C" "G" "H" "L" "P" "T")
;->  ("A" "B" "C" "D" "H" "L" "P" "T"))

(length (paths b))
;-> 35

Numero di percorsi su una matrice MxN: binom((M + N - 2) (N - 1))

(define (binom num k)
"Calculates the binomial coefficient (n k) = n!/(k!*(n - k)!) (combinations of k elements without repetition from n elements)"
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(binom (+ 5 4 (- 2)) (- 4 1))
;-> 35L


------------------
Equipaggio di volo
------------------

Alan, David, Tom e Bob formano un equipaggio di volo:
pilota, copilota, navigatore e ingegnere ma non necessariamente in quest'ordine.
Assegnare i nomi giusti al lavoro giusto sulla base delle seguenti informazioni:
(alcune delle quali potrebbero non esserti di alcun aiuto)

   1. Il pilota e il copilota sono buoni amici.
   2. Alan e Bob non sono buoni amici.
   3. La moglie dell'ingegnere è una passeggera.
   4. Alan e Bob non portano gli occhiali.
   5. Ma non sono sicuro di David o Tom.
   6. Solo Tom e Bob sono sposati.
   7. Tom ha pranzato con il copilota.
   8. Il pilota non porta gli occhiali.
   9. Ma il navigatore sì.
  1O. Il navigatore è fidanzato con l'hostess.
  11. L'hostess è di bell'aspetto.

Estrapolazione di altre informazioni:
  12. Alan non può essere il navigatore (da 4. e 9.)
  12. Bob non può essere il navigatore (da 4. e 9.)
  14. Tom o Bob è ingegnere (da 3. e 6.)
  15. Tom non è il copilota (da 7.)
  16. Il navigatore non è sposato (da 10.)
  17. Alan e Bob non possono essere insieme pilota e copilota (da 1. e 2.)

Da queste informazioni si ottiene:

  Bob ingegnere    
  Tom pilota       
  Alan copilota      
  David navigatore


----------------------
Triangoli in una lista
----------------------

Data una lista non ordinata di numeri interi positivi, scrivere una funzione per generare/contare il numero di possibili triangoli che possono essere formati con tre elementi qualsiasi della lista.
I tre elementi, che rappresentano le lunghezze dei lati di un triangolo, devono soddisfare la disuguaglianza del triangolo: la somma di due lati qualsiasi deve essere maggiore del terzo lato.
In altre parole, affinché la terna (x, y, z) formi un triangolo valido devono essere vere tutte le seguenti disuguaglianze:

  1) x + y > z
  2) y + z > x
  3) z + x > y

Soluzione brute-force
---------------------
Una soluzione è considerare ogni combinazione di tre elementi nella lista e verificare se soddisfano la disuguaglianza del triangolo.

(define (conta-triangoli lst show)
  (local (out conta len)
    (setq out '())
    (setq conta 0)
    (setq len (length lst))
    (for (i 0 (- len 3))
      (for (j (+ i 1) (- len 2))
        (for (k (+ j 1) (- len 1))
          (if (and (> (+ (lst i) (lst j)) (lst k))
                   (> (+ (lst i) (lst k)) (lst j))
                   (> (+ (lst k) (lst j)) (lst i)))
              (begin
                (++ conta)
                (if show (push (sort (list (lst i) (lst j) (lst k))) out -1))
              )))))
    (if show
      (list out conta)
      conta)))

Facciamo alcune prove:

(conta-triangoli '(4 6 3 8))
;-> 3
(conta-triangoli '(4 6 3 8) true)
;-> ((3 4 6) (4 6 8) (3 6 8)) 3)

(conta-triangoli '(10 21 22 100 101 200 300))
;-> 6
(conta-triangoli '(10 21 22 100 101 200 300) true)
;-> (((10 21 22) (10 100 101) (21 100 101)
;->   (22 100 101) (100 101 200) (101 200 300)) 6)

Complessità temporale:
  (tre cicli innestati) = O(n^3)

Soluzione con due puntatori
---------------------------
Ordinare la lista ed eseguire un ciclo annidato che, preso un indice, poi prova a trovare un indice superiore e inferiore all'interno del quale tutte le lunghezze formano un triangolo con quell'indice preso.

Ordinare la lista e utilizzare tre variabili sx, dx, e i, che puntano all'inizio, alla fine e all'elemento della lista a partire dalla fine.
Attraversare l'array dalla fine (da n-1 a 2) e per ogni iterazione mantieni il valore di sx = 0 e dx = i-1.
Ora, se è possibile formare un triangolo utilizzando lst(x) e lst(dx), è ovvio che si possano formare dei triangoli da lst[sx+1], lst[sx+2]...lst[r-1], con la coppia lst(dx) e ls(ti), perché la lista è ordinata,. Il numero di questi triangoli vale (dx - sx).
A questo punto diminuire il valore di dx e continuare il ciclo finché sx è inferiore a dx.
Se non è possibile formare un triangolo utilizzando lst(sx) e lst(dx), incrementare il valore di sx e continuare il ciclo finché sx è inferiore a dx.

(define (conta-tri lst show)
  (local (out len conta sx dx)
    (setq out '())
    (sort lst)
    (setq len (length lst))
    (setq conta 0)
    (for (i (- len 1) 2 -1)
      (setq sx 0)
      (setq dx (- i 1))
      (while (< sx dx)
        (if (> (+ (lst sx) (lst dx)) (lst i))
          (begin
            ; Se è possibile con lst(sx), lst(dx) e lst(i) allora
            ; è possibile anche con lst(sx+1)...lst(dx-1),
            ; insieme a lst(dx) e lst(i)
            (if show
                (for (k sx (- dx 1))
                  (push (sort (list (lst k) (lst dx) (lst i))) out -1)
                )
            )
            (setq conta (+ conta dx (- sx)))
            (-- dx)
          )
          ;else
          (++ sx)
        )
      )
    )
    (if show
      (list out conta)
      conta)))

Facciamo alcune prove:

(conta-tri '(4 6 3 8))
;-> 3
(conta-tri '(4 6 3 8) true)
;-> (((3 6 8) (4 6 8) (3 4 6)) 3)

(conta-tri '(10 21 22 100 101 200 300))
;-> 6
(conta-tri '(10 21 22 100 101 200 300) true)
;-> (((101 200 300) (100 101 200) (10 100 101)
;->   (21 100 101) (22 100 101) (10 21 22)) 6)

Complessità temporale:
  (sort) + (due cicli innestati) =
  = O(n*log(n)) + O(n^2) = O(n^2)

Vediamo la velocità delle due funzioni:

(define (test elementi iterazioni)
  (let (lst (rand elementi (+ (rand elementi) 3)))
    (println (time (conta-triangoli lst) iterazioni))
    (println (time (conta-tri lst) iterazioni))
    '------------))

(test 10 100)
;-> 2.991
;-> 0.998

(test 100 100)
;-> 85.798
;-> 5.985

(test 100 1000)
;-> 36187.195
;-> 779.916

=============================================================================

