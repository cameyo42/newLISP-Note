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

=============================================================================

