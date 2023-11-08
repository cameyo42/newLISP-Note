================

 NOTE LIBERE 19

================

------
Gomoku
------

Gomoku chiamato anche "Five in a Row", è un gioco da tavolo di strategia.
Si gioca tradizionalmente con pezzi Go (pietre bianche e nere) su una scacchiera Go 15×15 oppure 19×19.
Poiché i pezzi non vengono spostati o rimossi dalla scacchiera il gomoku può anche essere giocato con carta e matita.

Regole
I giocatori si alternano a turno posizionando una pietra del loro colore su un'intersezione vuota.
Il Nero gioca per primo.
Il vincitore è il primo giocatore che forma una linea ininterrotta di cinque pietre del proprio colore in orizzontale verticale o diagonale.
In alcune regole questa linea deve essere lunga esattamente cinque pietre (sei o più pietre di fila non contano come una vittoria e vengono chiamate overline).
Se la scacchiera è completamente piena e nessuno ha formato una linea di 5 pietre allora la partita finisce in parità.

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

Nota: se vogliamo ricercare 'esattamente' cinque "1" ("11111") o cinque "2" ("22222") possiamo usare le seguenti espressioni regolari:

(regex "(?<!1)11111(?!1)" "22111111122211111")
;-> ("11111" 12 5)
(regex "(?<!2)[2]{5}(?!2)" "11222222111222221")
;-> ("22222" 11 5)

Vediamo un esempio con una matrice 3x3:

(setq t '((1 0 2)
          (1 2 0)
          (1 2 0)))

Ricerca orizzontale:
1) stringa = "10201200120"
2) ricerca "111" --> non trovato ricerca "222" --> non trovato

Ricerca verticale:
1) stringa = "11100220200"
2) ricerca "111" --> trovato ricerca "222" --> non trovato

Ricerca diagonale '/':
1) stringa = "1001022100210"
2) ricerca "111" --> non trovato ricerca "222" --> non trovato

Ricerca diagonale '\':
1) stringa = "2000012001201"
2) ricerca "111" --> non trovato ricerca "222" --> non trovato

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
Poi questa operazione viene eseguita iterativamente per ogni "anello" o strato della matrice partendo dallo strato più esterno e procedendo verso il centro.

Consideriamo ad esempio la seguente matrice:

   1  2  3  4  5
   6  7  8  9 10
  11 12 13 14 15
  16 17 18 19 20
  21 22 23 24 25

Dopo aver eseguito l'operazione di rotazione la matrice diventa:

   6  1  2  3  4
  11 12  7  8  5
  16 17 13 9  10
  21 18 19 14 15
  22 23 24 25 20

Dividiamo il problema in sottoproblemi.
Ogni sottoproblema comporta la rotazione degli elementi di un "anello" della matrice.
Per ruotare gli elementi di un singolo anello eseguiamo quattro diverse operazioni:

Caso A (da basso-destra a sinistra) (0 -> 1)
sposta gli elementi dalla riga inferiore dell'anello corrente da destra a sinistra.
  2----------3
  |          |
  |          |
  1----------0

Caso B (da basso-sinistra in alto) (0 -> 1)
sposta gli elementi dalla colonna più a destra dell'anello corrente dal basso verso l'alto.
  1----------2
  |          |
  |          |
  0----------3

Caso C (da alto-sinistra a destra) (0 -> 1)
sposta gli elementi dalla riga superiore dell'anello corrente da sinistra a destra.
  0----------1
  |          |
  |          |
  3----------2

Caso D (da alto-destra in basso) (0 -> 1)
sposta gli elementi dalla colonna più a sinistra dell'anello corrente dall'alto verso il basso.
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
Il punteggio di una mano dipende innanzitutto dalla frequenza delle cifre e poi dal loro valore cioè dalla coppia: (frequenza cifra).
Per esempio:

(1 3 3 3 5)->(3 4) vince contro (6 1 6 2 4)->(6 3) perchè la frequenza della prima coppia (4) è maggiore di quella della seconda coppia (2).

(1 1 3 4 5)->(5 3) pareggia con (5 2 3 5 5)->(5 3).

(1 1 2 3 4)->(4 3) perde con (6 1 2 3 6)->(6 3)).

Questo significa che la mano con il punteggio più alto è composta interamente da 6 e 1 mentre la mano con il punteggio più basso è qualsiasi mano senza 1.

Nota: 1-1-1-1-1 vale quanto 6-6-6-6-6.

Funzione che calcola il valore di una mano.
Restituisce una coppia: (numero con frequenza massima frequenza massima)

(define (value p)
  (local (faces conta lst pat coppia)
    (setq faces '(1 2 3 4 5 6))
    ; conta la frequenza delle facce uscite dal lancio
    (setq conta (count faces p))
    (cond
      ; se non esiste alcun 1 allora il valore è 0.
      ((zero? (conta 0)) (setq coppia '(0 0)))
      (true
        ; lst = (1 frequenza) (2 frequenza) ... (6 frequenza)
        (setq lst (map list faces (count faces p)))
        ; frequenza massima
        (setq fmax (apply max conta))
        ; crea il pattern per cercare la frequenza massima e il numero associato
        (setq pat (list '? fmax))
        ; coppia = numero frequenza massima
        (setq coppia (last (find-all pat lst)))
        (cond ((= (coppia 0) 1) ; 1 è il numero con maggiore frequenza
                (if (= (coppia 1) 5)  ; se sono tutti 1
                    (setq coppia '(6 5))
                    ; altrimenti
                    ; coppia = numero massimo del lancio (numero di 1) + 1
                    (setq coppia (list (apply max p) (+ (coppia 1) 1)))))
              (true ; 1 non è il numero con maggiore frequenza
              ; coppia = numero della coppia (frequenza della coppia + numero di 1)
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
12721 è un numero bilanciato perché la somma delle cifre a sinistra del punto medio (che è la cifra al centro del numero quando il numero di cifre è dispari) vale 3 (1 + 2), che è uguale alla somma delle cifre a destra del punto medio (2 + 1).
1203 è un numero bilanciato perchè 1 + 2 = 0 + 3 = 3
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

dove p1 p2 p3 ..., pn sono i primi n numeri primi.

In altre parole E(n) è il prodotto dei primi n numeri primi + 1

I primi numeri di Euclide sono:

E(1) = 3
E(2) = 7
E(3) = 31
E(4) = 211
E(5) = 2311
E(6) = 30031
E(7) = 510511
...

I numeri di Euclide sono rari e diventano rapidamente molto grandi all'aumentare di n.

Sequenza OEIS A006862:
  2 3 7 31 211 2311 30031 510511 9699691 223092871 6469693231
  200560490131 7420738134811 304250263527211 13082761331670031
  614889782588491411 32589158477190044731 ...

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
  18 21 27 42 45 63 84 111 114 117 133 152 153 156 171 190
  195 198 201 207 209 222 228 247 261 266 285 333 370 372 399
  402 407 423 444 465 481 511 516 518 531 555 558 592 603 ...

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
Dalla lista degli interi fra 1 ed n vengono rimossi tutti i numeri della forma i + j + 2ij dove:
- ij sono interi naturali e 1<= i <= j
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
Ad esempio nell'intervallo [2 10], ci sono 5 numeri pari (2 4 6 8 e 10) e 4 numeri dispari (3 5 7 e 9).

Dato un intervallo [a b]:
Controlla se "a" è maggiore di "b".
In caso positivo scambiare i valori (deve essere "a" minore di "b")
Calcolare la lunghezza dell'intervallo: lunghezza = (b - a) + 1.
Determinare se "a" è pari o dispari.
Determinare se "b" è pari o dispari.
Determinare la lunghezza in base alle seguenti ipotesi:
  Se "a" è pari e "b" pari
  Se "a" è dispari e "b" pari
  Se "a" è pari e "b" dispari
  Se "a" è dispari e "b" dispari

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
  1 4 9 10 13 18 22 27 31 36 40 45 54 63 72 79 81 88 90
  97 100 103 108 112 117 121 126 130 135 144 153 162 169 171
  178 180 187 196 202 207 211 216 220 225 234 243 252 259 261
  268 270 277 286 295 301 306 ...

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
  11 12 13 14 15 16 17 18 21 22 23 24 25 26 27 28 31 32
  33 34 35 36 37 38 41 42 43 44 45 46 47 48 51 52 53 54
  55 56 57 58 61 62 63 64 65 66 67 68 71 72 73 74 75 76
  77 78 81 82 83 84 85 86 87 88 101 ...

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

Data una lista generare tutte le possibili sottoliste contigue.
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

Data una matrice di caratteri determinare tutti i possibili percorsi dall'angolo in alto a sinistra all'angolo in basso a destra della matrice.
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

Alan David Tom e Bob formano un equipaggio di volo:
pilota copilota navigatore e ingegnere ma non necessariamente in quest'ordine.
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

Data una lista non ordinata di numeri interi positivi scrivere una funzione per generare/contare il numero di possibili triangoli che possono essere formati con tre elementi qualsiasi della lista.
I tre elementi che rappresentano le lunghezze dei lati di un triangolo devono soddisfare la disuguaglianza del triangolo: la somma di due lati qualsiasi deve essere maggiore del terzo lato.
In altre parole affinché la terna (x y z) formi un triangolo valido devono essere vere tutte le seguenti disuguaglianze:

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
Ordinare la lista ed eseguire un ciclo annidato che preso un indice poi prova a trovare un indice superiore e inferiore all'interno del quale tutte le lunghezze formano un triangolo con quell'indice preso.

Ordinare la lista e utilizzare tre variabili sx dx e i che puntano all'inizio alla fine e all'elemento della lista a partire dalla fine.
Attraversare l'array dalla fine (da n-1 a 2) e per ogni iterazione mantieni il valore di sx = 0 e dx = i-1.
Ora se è possibile formare un triangolo utilizzando lst(x) e lst(dx), è ovvio che si possano formare dei triangoli da lst[sx+1], lst[sx+2]...lst[r-1], con la coppia lst(dx) e ls(ti), perché la lista è ordinata,. Il numero di questi triangoli vale (dx - sx).
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


---------------------
Teorema di Zeckendorf
---------------------

Il teorema di Zeckendorf afferma che ogni intero positivo può essere scritto unicamente come somma di numeri di Fibonacci distinti e non contigui.
Due numeri di Fibonacci sono contigui se si succedono uno dopo l'altro nella sequenza di Fibonacci:
 (0 1 1 2 3 5 ..).
Ad esempio 1 e 2 sono vicini ma 1 e 5 no.

Esempi:

n = 6
Zeckendorf: 5 1
5 e 1 sono numeri di Fibonacci non consecutivi e la loro somma è 6.

n = 42
Zeckendorf: 34 8
34 e 8 sono due numeri di Fibonacci non consecutivi e la loro somma è 42.

Scrivere una funzione che trova una rappresentazione di un numero come somma di numeri di Fibonacci non consecutivi.

Vedi anche "Rappresentazione di Zeckendorf" nel capitolo "Rosetta code".

Funzione che trova il più grande numero di Fibonacci minore o uguale ad un dato numero:

(define (fib-less num)
  (local (f1 f2 f3)
    (cond ((or (= num 0) (= num 1)) num)
          (true
            (set 'f1 0 'f2 1 'f3 1)
            (while (<= f3 num)
              (setq f1 f2)
              (setq f2 f3)
              (setq f3 (+ f1 f2))
            )
            f2))))

Funzione che trova la rappresentazione di Zeckendorf per un dato numero:

(define (zeck num)
  (local (f out)
    (setq out '())
    (while (> num 0)
      ; trova il numero di Fibonacci più vicino (minore o uguale) a num
      (setq f (fib-less num))
      (push f out -1)
      ; diminuiamo il numero (num) del numero di Fibonacci trovato (f)
      (-- num f)
    )
    out))

Facciamo alcune prove:

(zeck 6)
;-> (5 1)

(zeck 42)
;-> (34 8)

(zeck 2023)
;-> (1597 377 34 13 2)

(map (fn(x) (list x (zeck x))) (sequence 1 20))
;-> ((1 (1)) (2 (2)) (3 (3)) (4 (3 1)) (5 (5)) (6 (5 1)) (7 (5 2))
;->  (8 (8)) (9 (8 1)) (10 (8 2)) (11 (8 3)) (12 (8 3 1)) (13 (13))
;->  (14 (13 1)) (15 (13 2)) (16 (13 3)) (17 (13 3 1)) (18 (13 5))
;->  (19 (13 5 1)) (20 (13 5 2)))

Come funziona l'algoritmo (greedy strategy)?
Sia fib(i) [i-esimo numero di Fibonacci] il più grande numero di Fibonacci minore o uguale a 'num'.
Allora num – fib(i) avrà la propria rappresentazione come somma di numeri di Fibonacci non vicini.
Dobbiamo solo essere sicuri che non ci siano problemi con i contigui.
Per induzione num-fib(i) non ha problemi con i contigui quindi l'unico modo in cui num potrebbe avere un problema è se num-fib(i) utilizza fib(i-1) nella sua rappresentazione.
Possiamo dimostrare che num-fib(i) non usa fib(i-1) nella sua rappresentazione.
Dimostrazione per assurdo (contraddizione):
Se num-fib(i) = fib(i-1) + fib(i-x) +..., allora fib(i) non può essere il numero di Fibonacci più piccolo più vicino a num poiché fib(i) + fib(i-1) stesso è fib(i+1).
Quindi se num-fib(i) contiene fib(i-1) nella sua rappresentazione allora fib(i+1) sarebbe il numero di fib più piccolo più vicino a num contraddicendo la nostra ipotesi che fib(i) sia il numero di fib più piccolo più vicino a num.


---------------------------------------------------------------
Modello abeliano del mucchio di sabbia (Abelian sandpile model)
---------------------------------------------------------------

Il modello abeliano del mucchio di sabbia è un modello matematico utilizzato per studiare il comportamento di sistemi complessi che presentano criticità auto-organizzate.
È stato introdotto alla fine degli anni '80 da Per Bak Chao Tang e Kurt Wiesenfeld come semplice modello per simulare il comportamento di un mucchio di sabbia che lentamente si accumula e poi crolla sotto il proprio peso.

Il modello è costituito da una griglia bidimensionale di celle ciascuna delle quali può contenere una certa quantità di granelli di "sabbia".
Se una cella contiene più di una certa quantità di granelli di sabbia diventa "instabile" e invia un granello di sabbia a ciascuna delle celle vicine.
Se una qualsiasi di queste celle vicine supera la soglia anch'essa diventa instabile e distribuisce granelli di sabbia alle celle vicine e così via con il processo di "distribuzione" che può continuare a lungo.

La caratteristica notevole del modello abeliano dei cumuli di sabbia è che indipendentemente dalle condizioni iniziali il sistema alla fine raggiunge uno stato di “criticità auto-organizzata”, in cui piccole perturbazioni possono innescare valanghe su larga scala che dissipano rapidamente l'energia e ripristinano il sistema ad uno stato critico.
Questa proprietà ha reso il modello utile per studiare un''ampia gamma di fenomeni in fisica matematica e informatica tra cui la dinamica dei terremoti il flusso del traffico e la teoria dell'informazione.

Per simulare il modello utilizziamo una matrice bidimensionale per rappresentare il mucchio di sabbia.
Il metodo "distribute" seleziona casualmente una cella e vi aggiunge un granello di sabbia.
Se il numero di granelli in quella cella supera il parametro "accumulation", la cella cede e distribuisce i suoi granelli alle celle vicine.

La funzione "sand-pile" accetta i seguenti parametri:
  size = dimensione della matrice quadrata
  accumulation = numero di granelli di sabbia che fa cadere il mucchio
  iterations = numero di volte che immettiamo un granello di sabbia (iterazioni)
  showstep = stampa la matrice ad ogni iterazione

(define (print-matrix matrix)
"Print a matrix m x n"
  (local (row col lenmax digit fmtstr)
    ; converto matrice in lista?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; valore massimo della lunghezza di un elemento (come stringa)
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    ; calcolo spazio per gli elementi
    (setq digit (+ 1 lenmax))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "s"))
    ; stampa la matrice
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println))))

Funzione che crea un nuovo granello e ridistribuisce i granelli nelle celle:

(define (distribute)
  (setq x (rand size))
  (setq y (rand size))
  (++ (grid x y))
  (while (>= (grid x y) accumulation)
    (-- (grid x y) accumulation)
    (if (> x 0) (++ (grid (- x 1) y)))
    (if (< x (- size 1) (++ (grid (+ x 1) y))))
    (if (> y 0) (++ (grid x (- y 1))))
    (if (< y (- size 1) (++ (grid x (+ y 1)))))
  ))

Funzione che effettua la simulazione del modello:

(define (sandpile size accumulation iterations showstep)
  (local (grid x y)
    ; (seed 1 true) ; same random sequence
    (seed (time-of-day)) ; different random sequence
    (setq grid (array size size '(0)))
    (for (i 1 iterations)
      (distribute)
      (if showstep (begin (print-matrix grid) (read-line)))
    )
    (print-matrix grid)))

Facciamo alcune prove:

(sandpile 10 4 1000)
;->  3  2 11  2  7  1  8  5  0  5
;-> 12  4  2  9 16  7  1  6 18  2
;->  4  9 15  4  1  7 11  0  6  5
;->  6  0  4 25  4  4 24  6 16  4
;->  6 20 10  0 23  1 20  3 17  3
;->  4 13  6 17  9  4  8  7  2  3
;->  2  3  6  2  4  9  3 18  3  8
;->  2 11  9  6 12 26  2 24  9  2
;->  4 11 22 11  1  6  4  6  6  5
;->  4  1  1 13  5  8  0  9  0  4

(sandpile 5 4 100 true)
;-> 0 0 0 0 0
;-> 0 0 0 0 0
;-> 0 0 0 0 0
;-> 0 1 0 0 0
;-> 0 0 0 0 0
;-> ...
;-> ...
;-> 1 1 2 0 1
;-> 0 0 1 1 1
;-> 0 1 0 0 0
;-> 1 1 1 0 0
;-> 1 2 0 0 0
;->
;-> 1 1 2 0 1
;-> 0 0 1 2 1
;-> 0 1 0 0 0
;-> 1 1 1 0 0
;-> 1 2 0 0 0
;->
;-> 1 1 2 0 1
;-> 0 0 1 2 1
;-> 0 1 0 0 0
;-> 1 1 1 0 0
;-> 2 2 0 0 0
;->
;-> 1 1 2 1 1
;-> 0 0 1 2 1
;-> 0 1 0 0 0
;-> 1 1 1 0 0
;-> 2 2 0 0 0
;-> ...
;-> ...
;-> 1 2 3 6 5
;-> 4 3 2 3 0
;-> 1 6 1 2 4
;-> 1 5 7 3 3
;-> 4 3 0 3 2
;->
;-> 1 2 3 7 5
;-> 4 3 3 0 1
;-> 1 6 1 3 4
;-> 1 5 7 3 3
;-> 4 3 0 3 2
;->
;-> 2 2 3 7 5
;-> 1 4 3 0 1
;-> 2 6 1 3 4
;-> 1 5 7 3 3
;-> 4 3 0 3 2
;->
;-> 2 2 3 7 5
;-> 1 4 3 0 1
;-> 2 6 1 3 4
;-> 1 5 7 3 3
;-> 4 3 0 3 2


------------
Mouse e tane
------------

Abbiamo N topi e N tane posizionati lungo una linea retta.
Ogni tana può ospitare solo un mouse.
Un mouse fare le seguenti mosse:
a) restare nella sua posizione
b) fare un passo a destra da x a x + 1
c) fare un passo a sinistra da x a x - 1.
Ognuna di queste mosse consuma 1 unità di tempo.

Il problema è come associare le tane ai topi in modo da minimizzare il tempo necessario affinchè tutti i topi siano nelle loro tane.

Esempio:

Mouse: (-4 2 4)
Tane: (0 4 5)

       -4     2 4
  ------M-----M-M------
  ----------0----------
  ----------T---TT-----
            0   45

Supponiamo di fare le seguenti associazioni:

M(4)  --> T(4) (tempo 0)
M(-4) --> T(0) (tempo 4)
M(2)  --> T(5) (tempo 3)

In questo caso in 4 minuti tutti i topi sono nelle loro tane.
Si può notare che non esiste nessuna associazione che rende il tempo minore a 4 minuti.

Possiamo risolvere il problema utilizzando una strategia greedy (avida):
1) ordinare le posizioni delle tane
2) ordinare le posizioni dei topi
3) Trovare la massima differenza |topo(i) - tana(i)| con i=(1..N)

(define (tt topi tane)
  (sort tane)
  (sort topi)
  (apply max (map (fn(x y) (abs (- x y))) topi tane)))

Facciamo alcune prove:

(tt '(-4 2 4) '(0 4 5))
;-> 4

(setq t1 '(-3 7 5 9 16))
(setq t2 '(1 9 15 4 14))
(tt t1 t2)
;-> 5

(setq t1 '(23 86 20 -95 -87 46 -53 14 -92 -2))
(setq t2 '(91 27 27 -2 0 -37 -9 -5 58 -67))
(tt t1 t2)
;-> 78

Come al solito con le strategie greedy dobbiamo dimostrare che l'algoritmo utilizzato è corretto.
Dimostrazione:
Sia i1 < i2 la posizione di due topi e j1 < j2 la posizione di due tane.
È sufficiente dimostrarlo attraverso l'analisi del caso:

  max(|i1-j1|, |i2-j2|) <= max(|i1-j2|, |i2-j1|),

Per induzione qualunque assegnazione può essere trasformata da una serie di scambi delle assegnazioni fatte sulle liste ordinate e dove nessuno di questi scambi aumenta il tempo massimo.
Quindi l'algoritmo produce il risultato corretto.


--------------
Codice fiscale
--------------

Il codice fiscale italiano è un codice che serve ad identificare le persone fisiche (ed altri soggetti) in modo univoco.
Per le persone fisiche è composto da 16 caratteri alfanumerici mentre per gli altri soggetti da 11 cifre.

Per costruire il Codice Fiscale si utilizza il seguente algoritmo:

Posizioni 1-3: cognome (tre lettere)
------------------------------------
Vengono prese le consonanti del cognome o dei cognomi (se ve ne è più di uno) nel loro ordine (primo cognome, di seguito il secondo e così via). Se le consonanti sono insufficienti, si prelevano anche le vocali (se non sono sufficienti le consonanti, si prelevano la prima, la seconda e la terza vocale), sempre nel loro ordine.
Comunque, le vocali vengono riportate dopo le consonanti (per esempio: Rosi → RSO).
Nel caso in cui un cognome abbia meno di tre lettere, la parte di codice viene completata aggiungendo la lettera X (per esempio: Fo → FOX).
Per le donne, viene preso in considerazione il solo cognome da nubile.

(setq cf "")
(setq consonanti '("B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N"
                   "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" ))
(setq vocali '("A" "E" "I" "O" "U"))

Dati di prova:

(setq cognome "ROSSI")
(setq nome "MARIO")
(setq sesso "M")
(setq data '(1970 10 4))
(setq comune "CALTANISSETTA")

; Posizioni 1-3
; estrazione delle consonanti e delle vocali del cognome
(setq con '())
(setq voc '())
(dolist (ch (explode cognome))
  (cond ((find ch vocali) (push ch voc -1))
        ((find ch consonanti) (push ch con -1))
  )
)
; qualora le vocali non fossero sufficienti...
(extend voc '("X" "X" "X"))
;-> ("O" "I" "X" "X" "X")

; calcolo codice del cognome p13
(setq num-con (length con))
(cond ((>= num-con 3)
        (setq p13 (slice con 0 3)))
      ((= num-con 2)
        (setq p13 (list (con 0) (con 1) (voc 0))))
      ((= num-con 1)
       (setq p13 (list (con 0) (voc 0) (voc 1))))
      ((= num-con 0)
       (setq p13 (list (voc 0) (voc 1) (voc 2))))
)
(extend cf (join p13))
;-> "RSS"

Posizioni 4-6: nome (tre lettere)
---------------------------------
Vengono prese le consonanti del nome o dei nomi nel loro ordine (primo nome, di seguito il secondo e così via) in questo modo:
se il nome contiene quattro o più consonanti, si scelgono la prima, la terza e la quarta (per esempio: Gianfranco → GFR), altrimenti le prime tre in ordine (per esempio: Tiziana → TZN).
Se il nome non ha consonanti a sufficienza, si prendono anche le vocali.
In ogni caso le vocali vengono riportate dopo le consonanti (per esempio: Luca → LCU).
Nel caso in cui il nome abbia meno di tre lettere, la parte di codice viene completata aggiungendo la lettera X.

; Posizioni 4-6
; estrazione delle consonanti e delle vocali del nome
(setq con '())
(setq voc '())
(dolist (ch (explode nome))
  (cond ((find ch vocali) (push ch voc -1))
        ((find ch consonanti) (push ch con -1))
  )
)
; qualora le vocali non fossero sufficienti...
(extend voc '("X" "X" "X"))
; calcolo codice del nome p46
(setq num-con (length con))
(cond ((>= num-con 4)
        (setq p46 (list (con 0) (con 2) (con 3))))
      ((= num-con 3)
        (setq p46 (list (con 0) (con 1) (con 2))))
      ((= num-con 2)
        (setq p46 (list (con 0) (con 1) (voc 0))))
      ((= num-con 1)
        (setq p46 (list (con 0) (voc 0) (voc 1))))
      ((= num-con 0)
        (setq p46 (list (voc 0) (voc 1) (voc 2))))
)
(extend cf (join p46))
;-> "RSSMRA"

Posizioni 7-9: anno e mese di nascita (tre caratteri alfanumerici)
------------------------------------------------------------------
Anno di nascita (due cifre): si prendono le ultime due cifre dell'anno di nascita;
Mese di nascita (una lettera): a ogni mese dell'anno viene associata una lettera in base a questa tabella:

  gennaio    A
  febbraio   B
  marzo      C
  aprile     D
  maggio     E
  giugno     H
  luglio     L
  agosto     M
  settembre  P
  ottobre    R
  novembre   S
  dicembre   T

;(setq mesi '((gennaio   A) (febbraio B) (marzo    C) (aprile   D)
;             (maggio    E) (giugno   H) (luglio   L) (agosto   M)
;             (settembre P) (ottobre  R) (novembre S) (dicembre T)))

; Lista associativa dei mesi
(setq mesi '((1 "A") (2 "B") (3 "C") (4 "D") (5 "E") (6 "H")
             (7 "L") (8 "M") (9 "P") (10 "R") (11 "S") (12 "T")))

; Posizioni 7-9
; calcolo codice dell'anno e del mese p79
(map set '(aa mm gg) data)
(setq p79 (extend (slice (string aa) -2 2) (lookup mm mesi)))
(extend cf p79)
;-> "RSSMRA70R"

Posizioni 10-11: giorno di nascita e sesso (due cifre)
------------------------------------------------------
Si prendono le due cifre del giorno di nascita (se è compreso tra 1 e 9 si pone uno zero come prima cifra)
Per i soggetti di sesso femminile, a tale cifra va sommato il numero 40.
In questo modo il campo contiene la doppia informazione giorno di nascita e sesso.
Avremo pertanto la seguente casistica: gli uomini avranno il giorno con cifra da 01 a 31, mentre per le donne la cifra relativa al giorno sarà da 41 a 71.

; Posizioni 10-11
; calcolo codice del giorno per Maschio o Femmina
(cond ((= sesso "F") (setq p1011 (format "%02d" (int (+ gg 40) 0 10))))
      ((= sesso "M") (setq p1011 (format "%02d" (int gg 0 10))))
)
(extend cf p1011)
;-> "RSSMRA70R04"

Posizioni 12-15: comune (o Stato) di nascita (quattro caratteri alfanumerici)
-----------------------------------------------------------------------------
Per identificare il comune di nascita si utilizza il codice impropriamente detto Belfiore, composto da una lettera e tre cifre numeriche.
Per i nati al di fuori del territorio italiano, sia che si tratti di cittadini italiani nati all'estero, oppure stranieri, si considera lo stato estero di nascita: in tal caso la sigla inizia con la lettera Z seguita dal numero identificativo dello Stato.
Il codice Belfiore è lo stesso usato per il nuovo Codice catastale.

Il file con i codici catastali è stato creato nel modo seguente:

1) download del file comuni.xls dal seguente link:
https://www4.istat.it/storage/codici-unita-amministrative/Elenco-comuni-italiani.xls

2) conversione del file in formato csv (comma-separated-value)

3) eliminazione di tutti i caratteri non-ascii (è, à, ecc.)

4) importazione del file nella lista "comuni" con i seguenti comandi:

(setq comuni '())
(setq f1 (open "comuni.csv" "read"))
(while (setq str (read-line f1)) (push (parse str ",") comuni -1))
(close f1)

5) conversione dei nomi dei comuni in maiuscolo

(setq comuni (map (fn(x) (list (upper-case (x 0)) (x 1))) comuni))

6) salvataggio della lista "comuni" come file "comuni.lsp".

(save "comuni.lsp" 'comuni)

7) Adesso possiamo caricare la lista comuni con il seguente comando:

(load "comuni.lsp")

Nota: il file "comuni.lsp" si trova nella cartella "data".

; Posizioni 12-15
; calcolo codice comune di nascita p1215
(setq p1215 (lookup comune comuni))
(extend cf p1215)
;-> "RSSMRA70R04B429"

Posizione 16: carattere di controllo (una lettera)
--------------------------------------------------
A partire dai quindici caratteri alfanumerici ricavati in precedenza, si determina il carattere di controllo (indicato a volte come CIN, Control Internal Number) in base a un algoritmo che opera in questo modo:
si assegna un numero ad ogni carattere alfanumerico, partendo da 1:
si mettono da una parte i caratteri il cui numero è dispari e da un'altra quelli pari.
A questo punto, i caratteri vengono convertiti in valori numerici secondo le seguenti tabelle:

  DISPARI
  0  1   9 21   I 19   R 8
  1  0   A  1   J 21   S 12
  2  5   B  0   K  2   T 14
  3  7   C  5   L  4   U 16
  4  9   D  7   M 18   V 10
  5 13   E  9   N 20   W 22
  6 15   F 13   O 11   X 25
  7 17   G 15   P  3   Y 24
  8 19   H 17   Q  6   Z 23

  PARI
  0 0   9 9   I  8   R 17
  1 1   A 0   J  9   S 18
  2 2   B 1   K 10   T 19
  3 3   C 2   L 11   U 20
  4 4   D 3   M 12   V 21
  5 5   E 4   N 13   W 22
  6 6   F 5   O 14   X 23
  7 7   G 6   P 15   Y 24
  8 8   H 7   Q 16   Z 25

a questo punto, i valori che si ottengono dai caratteri pari e dispari vanno sommati tra di loro e il risultato va diviso per 26.
Il resto della divisione fornirà il codice identificativo, ottenuto dalla seguente tabella di conversione:

  RESTO
  0 A    7 H   14 O   21 V
  1 B    8 I   15 P   22 W
  2 C    9 J   16 Q   23 X
  3 D   10 K   17 R   24 Y
  4 E   11 L   18 S   25 Z
  5 F   12 M   19 T
  6 G   13 N   20 U

Per il codice di controllo sviluppiamo una funzione apposita.

(define (cin cf)
  (local (dispari pari resto)
    (setq dispari '(("0"  1) ("9" 21) ("I" 19) ("R" 8 )
                    ("1"  0) ("A"  1) ("J" 21) ("S" 12)
                    ("2"  5) ("B"  0) ("K"  2) ("T" 14)
                    ("3"  7) ("C"  5) ("L"  4) ("U" 16)
                    ("4"  9) ("D"  7) ("M" 18) ("V" 10)
                    ("5" 13) ("E"  9) ("N" 20) ("W" 22)
                    ("6" 15) ("F" 13) ("O" 11) ("X" 25)
                    ("7" 17) ("G" 15) ("P"  3) ("Y" 24)
                    ("8" 19) ("H" 17) ("Q"  6) ("Z" 23)))
    (setq pari '(("0" 0) ("9" 9) ("I"  8) ("R" 17)
                ("1" 1) ("A" 0) ("J"  9) ("S" 18)
                ("2" 2) ("B" 1) ("K" 10) ("T" 19)
                ("3" 3) ("C" 2) ("L" 11) ("U" 20)
                ("4" 4) ("D" 3) ("M" 12) ("V" 21)
                ("5" 5) ("E" 4) ("N" 13) ("W" 22)
                ("6" 6) ("F" 5) ("O" 14) ("X" 23)
                ("7" 7) ("G" 6) ("P" 15) ("Y" 24)
                ("8" 8) ("H" 7) ("Q" 16) ("Z" 25)))
    (setq resto '((0 "A") ( 7 "H") (14 "O") (21 "V")
                  (1 "B") ( 8 "I") (15 "P") (22 "W")
                  (2 "C") ( 9 "J") (16 "Q") (23 "X")
                  (3 "D") (10 "K") (17 "R") (24 "Y")
                  (4 "E") (11 "L") (18 "S") (25 "Z")
                  (5 "F") (12 "M") (19 "T")
                  (6 "G") (13 "N") (20 "U")))
    (setq somma '())
    ; creazione della lista da sommare
    (dolist (ch (explode cf))
      (cond ((even? $idx)
              ; numero associato ai caratteri dispari
              (push (lookup ch dispari) somma))
            ((odd? $idx)
              ; numero associato ai caratteri pari
              (push (lookup ch pari) somma))
      )
    )
    ; calcolo del carattere associato al resto della divisione
    (lookup (% (apply + somma) 26) resto)))

(cin "RSSMRA70R04B429")
;-> "V"

Omocodia
--------
Due diverse persone potrebbero avere uguali tutte e sedici le lettere/cifre generate usando questo schema (omocodia).
In questo caso, si sostituiscono i soli caratteri numerici (a partire dal carattere numerico più a destra) con una lettera, secondo la seguente tabella di corrispondenza:

  OMOCODIA
  0 L   4 Q   8 U
  1 M   5 R   9 V
  2 N   6 S
  3 P   7 T

(setq omocodia '((0 L) (4 Q) (8 U)
                 (1 M) (5 R) (9 V)
                 (2 N) (6 S)
                 (3 P) (7 T)))

Dopo la sostituzione, il carattere di controllo deve essere ricalcolato.

Implementazione finale
----------------------

Limiti:
a) solo cittadini italiani (occorrono i codici degli stati)
b) nessuna modifica in caso di omocodia (da fare a mano!)

(define (codice-fiscale nome cognome sesso data comune)
  (local (cf aa mm gg mesi consonanti vocali con voc num-con
          p13 p46 p79 p1011 p1215 p16)
    (setq cf "") ; codice fiscale
    ; anno, mese, giorno di nascita
    (map set '(aa mm gg) data)
    ; carica la lista dei comuni
    (load "comuni.lsp")
    ; lista associativa dei mesi
    (setq mesi '((1 "A") (2 "B") (3 "C") (4 "D") (5 "E") (6 "H")
                (7 "L") (8 "M") (9 "P") (10 "R") (11 "S") (12 "T")))
    (setq consonanti '("B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N"
                      "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" ))
    (setq vocali '("A" "E" "I" "O" "U"))
    ; Posizioni 1-3
    ; estrazione delle consonanti e delle vocali del cognome
    (setq con '())
    (setq voc '())
    (dolist (ch (explode cognome))
      (cond ((find ch vocali) (push ch voc -1))
            ((find ch consonanti) (push ch con -1))
      )
    )
    ; qualora le vocali non fossero sufficienti...
    (extend voc '("X" "X" "X"))
    ; calcolo codice del cognome p13
    (setq num-con (length con))
    (cond ((>= num-con 3)
            (setq p13 (slice con 0 3)))
          ((= num-con 2)
            (setq p13 (list (con 0) (con 1) (voc 0))))
          ((= num-con 1)
          (setq p13 (list (con 0) (voc 0) (voc 1))))
          ((= num-con 0)
          (setq p13 (list (voc 0) (voc 1) (voc 2))))
    )
    (println "p13 = " p13)
    (extend cf (join p13))
    ; Posizioni 4-6
    ; estrazione delle consonanti e delle vocali del nome
    (setq con '())
    (setq voc '())
    (dolist (ch (explode nome))
      (cond ((find ch vocali) (push ch voc -1))
            ((find ch consonanti) (push ch con -1))
      )
    )
    ; qualora le vocali non fossero sufficienti...
    (extend voc '("X" "X" "X"))
    ; calcolo codice del nome p46
    (setq num-con (length con))
    (cond ((>= num-con 4)
            (setq p46 (list (con 0) (con 2) (con 3))))
          ((= num-con 3)
            (setq p46 (list (con 0) (con 1) (con 2))))
          ((= num-con 2)
            (setq p46 (list (con 0) (con 1) (voc 0))))
          ((= num-con 1)
            (setq p46 (list (con 0) (voc 0) (voc 1))))
          ((= num-con 0)
            (setq p46 (list (voc 0) (voc 1) (voc 2))))
    )
    (println "p46 = " p46)
    (extend cf (join p46))
    ; Posizioni 7-9
    ; calcolo codice dell'anno e del mese p79
    (setq p79 (extend (slice (string aa) -2 2) (lookup mm mesi)))
    (println "p79 = " p79)
    (extend cf p79)
    ; Posizioni 10-11
    ; calcolo codice del giorno per Maschio o Femmina
    (cond ((= sesso "F") (setq p1011 (format "%02d" (int (+ gg 40) 0 10))))
          ((= sesso "M") (setq p1011 (format "%02d" (int gg 0 10))))
    )
    (println "p1011 = " p1011)
    (extend cf p1011)
    ; Posizioni 12-15
    ; calcolo codice comune di nascita p1215
    (setq p1215 (lookup comune comuni))
    (println "p1215 = " p1215)
    (extend cf p1215)
    ; Posizioni 16
    ; calcolo codice di controllo (CIN)
    (setq p16 (cin cf))
    (println "p16 = " p16)
    (extend cf p16)    
))

Facciamo alcune prove:

(codice-fiscale "MARIO" "ROSSI" "M" '(1970 10 4) "CALTANISSETTA")
;-> p13 = ("R" "S" "S")
;-> p46 = ("M" "R" "A")
;-> p79 = 70R
;-> p1011 = 04
;-> p1215 = B429
;-> p16 = V
;-> "RSSMRA70R04B429V"

(codice-fiscale "MR" "RO" "M" '(1970 10 4) "CALTANISSETTA")
;-> p13 = ("R" "O" "X")
;-> p46 = ("M" "R" "X")
;-> p79 = 70R
;-> p1011 = 04
;-> p1215 = B429
;-> p16 = B
;-> "ROXMRX70R04B429B"

(codice-fiscale "FRANCESCA" "ROSI" "F" '(1985 2 29) "ROMA")
;-> p13 = ("R" "S" "O")
;-> p46 = ("F" "N" "C")
;-> p79 = 85B
;-> p1011 = 69
;-> p1215 = H501
;-> p16 = F
;-> "RSOFNC85B69H501F"

Nota: anche se questo algoritmo permette di calcolare il codice fiscale di una persona fisica, l'unico soggetto che per legge rilascia un codice fiscale validato è l'anagrafe tributaria dell'Agenzia delle entrate.


---------------
Guardie e ladri
---------------

Consideriamo una lista che ha le seguenti specifiche:
Ogni elemento della lista contiene una guardia (G) o un ladro (L).
Ogni guardia può catturare un solo ladro.
Una guardia non può catturare un ladro che si trova più distante di K unità.
Il problema è trovare il massimo numero di ladri che possono essere catturati.

Esempio: 
lista = ("G" "L" "L" "G" "G")
K = 1
La guardia a 0 cattura il ladro a 1.
La guardia a 3 cattura il ladro a 2.
Totale: 2 catture

Algoritmo
1. Calcolare l'indice più basso tra guardia G e ladro L.
   Fare un'assegnazione
2. Se k >= |G-L| K fare una cattura e trovare i successivi G e L.
   Altrimenti incrementare min(G, L) al successivo G o L trovato.
3. Ripetere i due passi precedenti finché non vengono trovati G e L successivi.
4. Restituire il numero di catture effettuate.

(define (guardie-ladri lst k)
  (local (our len guardie ladri sx dx)
    (setq out 0)
    (setq len (length lst))
    (setq guardie '())
    (setq ladri '())
    ; memorizza gli indici di G e L in due liste
    (dolist (el lst)
      (cond ((= el "G") (push $idx guardie -1))
            ((= el "L") (push $idx ladri -1))
      )
    )
    (setq sx 0)
    (setq dx 0)
    ; indice minore tra L(sx) e G(dx)
    (while (and (< sx (length ladri)) (< dx (length guardie)))
      (cond ((>= k (abs (- (ladri sx) (guardie dx)))) ; cattura
            (++ out) (++ sx) (++ dx))
            ; incrementa indice minimo
            ((< (ladri sx) (guardie dx)) (++ sx))
            (true (++ dx))
      )
    )
    out))

Facciamo alcune prove:

(guardie-ladri '("G" "L" "L" "G" "G") 1)
;-> 2
(guardie-ladri '("G" "L" "L" "G" "L") 1)
;-> 2
(guardie-ladri '("G" "L" "L" "L" "G" "L" "G" "G") 1)
;-> 3
(guardie-ladri '("G" "L" "L" "L" "G" "L" "G" "G") 3)
;-> 4
(guardie-ladri '("L" "L" "G" "G" "L" "L" "L" "G" "G") 1)
;-> 3
(guardie-ladri '("G" "G" "L" "G" "L" "L" "G" "L") 2)
;-> 3


-------------------------------------
regex-all (trova tutte le occorrenze)
-------------------------------------

La funzione "regex" esegue una ricerca PCRE (Perl compatibile con l'espressione regolare) su "str-text" con il modello specificato in "str-pattern":

  (regex str-pattern str-text [regex-option [int-offset]])

Per esempio, ricerchiamo "AAA" nella stringa "AAAaBBcADccAAAA":

(setq a "AAAaBBcADccAAAA")
(regex "[A]{3}" a)
;-> ("AAA" 0 3)

Come si vede, la funzione "regex" ritorna solo la prima occorrenza del modello ("AAA").

Possiamo utilizzare la seguente funzione per ottenere tutte le occorrenze del modello che si trovano nella stringa:

(define (regex-all regexp str all)
  (local (out idx res)
    (setq out '())
    (setq idx 0)
    (setq res (regex regexp str 64 idx))
    (while res
      (push res out -1)
      (if all
          (setq idx (+ (res 1) 1)) ; contiguos pattern
          ;else
          (setq idx (+ (res 1) (res 2))) ; no contiguos pattern
      )
      (setq res (regex regexp str 64 idx))
    )
    out))

Quando il parametro booleano "all" vale true, allora "regex-all" cerca i modelli successivi al primo partendo dall'indice immediatamente successivo all'inizio del modello appena trovato.
Se "all" vale "nil", allora le ricerche succesive iniziano dall'indice successivo a quello della fine del modello.
In altre parole:
  all = true  --> Vengono trovate tutte le corrispondenze del modello
  all = nil   --> Vengono trovate solo le corrispondenze uniche del modello

Per esempio, se cerchiamo "AAA" nella stringa "AAAAAA" abbiamo due casi:

1) all = true  --> 4 occorrenze
    ___       ___       ___       ___
   "AAAAAA" "AAAAAA" "AAAAAA" "AAAAAA" 

2) all = nil   --> 2 orroccrenze
    ___         ___
   "AAAAAA" "AAAAAA"

(setq b "AAAAAA")
(regex-all "[A]{3}" b true)
;-> (("AAA" 0 3) ("AAA" 1 3) ("AAA" 2 3) ("AAA" 3 3))
(regex-all "[A]{3}" b)
;-> (("AAA" 0 3) ("AAA" 3 3))

(setq a "AAAaBBcADccAAAA")
(regex-all "[A]{3}" a true)
;-> (("AAA" 0 3) ("AAA" 11 3) ("AAA" 12 3))
(regex-all "[A]{3}" a)
;-> (("AAA" 0 3) ("AAA" 11 3))

Comunque se usiamo il modello più restrittivo "(?<!A)[A]{3}(?!A)", che trova 'esattamente' "AAA" e non "AAAA", allora il parametro "all" non ha influenza sul risultato:

(regex-all "(?<!A)[A]{3}(?!A)" a true)
;-> (("AAA" 0 3))
(regex-all "(?<!A)[A]{3}(?!A)" a)
;-> (("AAA" 0 3))


---------------------------
Riempire una linea/segmento
---------------------------

Dato una linea/segmento lunga n e due segmenti lunghi a e b con le seguenti proprietà:
  1) n > a e n > b e n > (a + b)
  2) a < b

Riempire la linea n con i segmenti a e b minimizzando lo spazio rimanente.

Esempio:
  n = 20
  a = 3
  b = 4
Soluzioni possibili (con le loro permutazioni):
  3 3 3 3 4 4 --> 20 (spazio rimanente 0)
  4 4 4 4 4   --> 20 (spazio rimanente 0)

Possiamo fare le seguenti considerazioni:

1) (zero? (% n a)) --> linea piena
2) (zero? (% n b)) --> linea piena
3) (zero? (% n (+ (* a i) (* b j)))) --> forse linea piena
   con 1 <= i <= (/ n a)
   con 1 <= j <= (/ n b)

Funzione che trova tutti i riempimenti possibili (a cui bisogna aggiungere le permutazioni) e i relativi spazi rimanenti:

(define (fill n a b)
  (local (out max-i max-j pieno vuoto)
    (setq out '())
    (setq max-i (/ n a))
    (setq max-j (/ n b))
    (for (i 0 max-i)
      (for (j 0 max-j)
        (cond ((not (and (zero? i) (zero? j)))
                (setq pieno (+ (* a i) (* b j)))
                (setq vuoto (- n pieno))
                ; inseriamo solo i valori positivi e nulli di vuoto
                (if (>= vuoto 0) (push (list vuoto a i b j) out -1)))
        )
      )
    )
    (sort out)))

(fill 20 3 4)
;-> ((0 3 0 4 5) (0 3 4 4 2) (1 3 1 4 4) (1 3 5 4 1) (2 3 2 4 3) (2 3 6 4 0) 
;->  (3 3 3 4 2) (4 3 0 4 4) (4 3 4 4 1) (5 3 1 4 3) (5 3 5 4 0) (6 3 2 4 2)
;->  (7 3 3 4 1) (8 3 0 4 3) (8 3 4 4 0) (9 3 1 4 2) (10 3 2 4 1) (11 3 3 4 0)
;->  (12 3 0 4 2) (13 3 1 4 1) (14 3 2 4 0) (16 3 0 4 1) (17 3 1 4 0))

La soluzione (0 3 0 4 5) significa:
0 --> spazio rimanente
3 --> lunghezza segmento a
0 --> numero di segmenti a
4 --> lunghezza segmento b
5 --> numero di segmenti b
Quindi la soluzione vale "aaabbbb" e qualunque sua permutazione.


------------------------------------------
Divisione intera e modulo intero in python
------------------------------------------

In python gli operatori di divisione intera "/" e di modulo intero "%" si comportano in modo diverso da newLISP.

Divisione intera
----------------

newLISP               python
(/ 5 2)               >>> (5 / 2)
;-> 2                 2
(/ -5 -2)             >>> (-5 / -2)
;-> 2                 2
(/ 5 -2)              >>> (5 / -2)
;-> -2                -3
(/ -5 2)              >>> (-5 / 2)
;-> -2                -3
(/ 6 -2)              >>> (6 / -2)
;-> -3                -3
(/ -6 2)              >>> (-6 / 2)
;-> -3                -3
(/ 6 2)               >>> (6 / 2)
;-> 3                 3
(/ -6 -2)             >>> (-6 / -2)
;-> 3                 3

Funzione che opera la divisione intera in modo python:

(define (python-div a b)
  (cond ((or (and (> a 0) (> b 0)) (and (< a 0) (< b 0))) (/ a b))
        ((zero? (% a b)) (/ a b))
        (true (- (/ a b) 1))))

(python-div 5 2)
;-> 2
(python-div -5 -2)
;-> 2
(python-div 5 -2)
;-> -3
(python-div -5 2)
;-> -3
(python-div 6 -2)
;-> -3
(python-div -6 2)
;-> -3
(python-div 6 2)
;-> 3
(python-div -6 -2)
;-> 3

Modulo intero
-------------

newLISP               python
(% 5 2)               >>> (5 % 2)
;-> 1                 1
(% -5 -2)             >>> (-5 % -2)
;-> -1                -1
(% 5 -2)              >>> (5 % -2)
;-> 1                 -1
(% -5 2)              >>> (-5 % 2)
;-> -1                1
(% 6 -2)              >>> (6 % -2)
;-> 0                 0
(% -6 2)              >>> (-6 % 2)
;-> 0                 0
(% 6 2)               >>> (6 % 2)
;-> 0                 0
(% -6 -2)             >>> (-6 % -2)
;-> 0                 0

Funzione che opera il modulo intero in modo python:

(define (python-mod a b) (% (+ (% a b) b) b))

(python-mod 5 2)
;-> 1
(python-mod -5 -2)
;-> -1
(python-mod 5 -2)
;-> -1
(python-mod -5 2)
;-> 1
(python-mod 6 -2)
;-> 0
(python-mod -6 2)
;-> 0
(python-mod 6 2)
;-> 0
(python-mod -6 -2)
;-> 0

Nota: fare attenzione quando si convertono programmi da python.


-------------
Numeri Grifon
-------------

Un numero Grifon è un numero nella forma a + a^2 + ... a^x, dove sia a che x sono numeri interi maggiori o uguali a due.
La sequenza Grifon è l'insieme di tutti i numeri Grifon in ordine crescente.
Se esistono più modi per formare un numero Grifon (per esempio 30, che è sia 2+2^2+2^3+2^4 che 5+5^2), allora il numero viene contato solo una volta nella sequenza.
I primi numeri Grifon sono: 6 12 14 20 30 39 42 56 62 72 84 90 110 ...

(define (calc a x)
  (setq somma a)
  (for (i 2 x) (setq somma (+ somma (pow a i)))))

(calc 3 2)
;-> 12

(define (grifon max-a max-x)
  (setq lst '())
  (for (a 2 max-a)
    (for (x 2 max-x)
      (push (calc a x) lst)
    )
  )
  (unique (sort lst)))

(grifon 10 10)
;-> (6 12 14 20 30 39 42 56 62 72 84 90 110 120 126 155 254 258 340 363 399 
;->  510 584 780 819 1022 1092 1110 1364 1554 2046 2800 3279 3905 4680 5460
;->  7380 9330 9840 11110 19530 19607 21844 29523 37448 55986 66429 87380 
;->  88572 97655 111110 137256 299592 335922 349524 488280 597870 960799 
;->  1111110 1398100 2015538 2396744 2441405 5380839 6725600 11111110 
;->  12093234 12207030 19173960 47079207 48427560 72559410 111111110 
;->  153391688 329554456 435848049 1111111110 1227133512 3922632450
;->  11111111110)

(length (grifon 10 10))
;-> 80
(length (grifon 20 20))
;-> 360


-----------------------------
Numeri con tutti 1 e 0 finale
-----------------------------

Trovare la sequenza dei numeri interi che se convertiti in una base minore o uguale a 10 generano un numero con tutti 1, tranne l'ultima cifra che deve valere 0: 1[1..1]0

Per esempio:
 30(base2) = 11110
 42(base6) = 110
 72(base8) = 110 

(define (b1-b2 num base1 base2)
"Convert an integer from base1 to base2 (2 <= base <= 10)"
  (if (zero? num) num
      (+ (% num base2) (* base1 (b1-b2 (/ num base2) base1 base2)))))

(b1-b2 30 10 2)
;-> 11110
(b1-b2 84 10 4)
;-> 1110
(b1-b2 84 10 10)
;-> 84

Funzione che verifica se un numero appartiene alla sequenza:

(define (seq? num)
  (setq str (string num))
  (cond ((< num 2) nil)
        ((= num 10) true)
        (true
          (setq found nil)
          (for (b 10 2 -1 found)
            (setq s (string (b1-b2 num 10 b)))
            ;(println b { } s)
            (if (and (= (last s) "0") 
                     (= (first s) "1")
                     (apply = (chop (explode s))))
                (setq found true)
            )
          )
          found)))

Facciamo alcune prove:

(seq? 24)
;-> nil
(seq? 5)
;-> nil
(seq? 10)
;-> true
(seq? 42)
;-> true
(seq? 155)
;-> true
(seq? 1110)
;-> true
(seq? 4692)
;-> nil

(filter seq? (sequence 1 1e3))
;-> (6 10 12 14 20 30 39 42 56 62 72 84 90 110 120 
;->  126 155 254 258 340 363 399 510 584 780 819)


----------------------------------------
Combinazioni di caratteri di una stringa
----------------------------------------

Data una stringa di caratteri diversi, generare in modo casuale le combinazioni univoche con ripetizione dei caratteri, dalla lunghezza 1 fino alla lunghezza della stringa.

Esempio: stringa = "abc" (o qualsiasi combinazione dei caratteri a,b,c):

 "a" "aa" "aaa" "aab" "aac" "ab" "aba" "abb" "abc" "ac" "aca" "acb" "acc"
 "b" "ba" "baa" "bab" "bac" "bb" "bba" "bbb" "bbc" "bc" "bca" "bcb" "bcc"
 "c" "ca" "caa" "cab" "cac" "cb" "cba" "cbb" "cbc" "cc" "cca" "ccb" "ccc"

Sequenza OEIS A031972: a(n) = Sum[k=1,n](n^k)
  0, 1, 6, 39, 340, 3905, 55986, 960799, 19173960, 435848049,
  11111111110, 313842837671, ... ,

Calcoliamo tutte le combinazioni con ripetizione dei caratteri.

(define (comb-rep k lst)
"Generates all combinations of k elements with repetition from a list of items"
  (cond ((zero? k 0) '(()))
        ((null? lst) '())
        (true
         (append (map (lambda (x) (cons (first lst) x))
                      (comb-rep (- k 1) lst))
                 (comb-rep k (rest lst))))))

(comb-rep 1 (explode "abc"))
;-> (("a") ("b") ("c"))
(comb-rep 2 (explode "abc"))
;-> (("a" "a") ("a" "b") ("a" "c") ("b" "b") ("b" "c") ("c" "c"))
(comb-rep 3 (explode "abc"))
;-> (("a" "a" "a") ("a" "a" "b") ("a" "a" "c") ("a" "b" "b") ("a" "b" "c")
;->  ("a" "c" "c") ("b" "b" "b") ("b" "b" "c") ("b" "c" "c") ("c" "c" "c"))

A queste tre liste occorre aggiungere le permutazioni dei caratteri.

(define (perm-rep k lst)
"Generates all permutations of k elements with repetition from a list of items"
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

(perm-rep 1 (explode "abc"))
;-> (("a") ("b") ("c"))
(perm-rep 2 (explode "abc"))
;-> (("a" "a") ("b" "a") ("c" "a") ("a" "b") ("b" "b") ("c" "b")
;->  ("a" "c") ("b" "c") ("c" "c"))
(perm-rep 3 (explode "abc"))
;-> (("a" "a" "a") ("b" "a" "a") ("c" "a" "a") ("a" "b" "a") ("b" "b" "a")
;->  ("c" "b" "a") ("a" "c" "a") ("b" "c" "a") ("c" "c" "a") ("a" "a" "b")
;->  ("b" "a" "b") ("c" "a" "b") ("a" "b" "b") ("b" "b" "b") ("c" "b" "b")
;->  ("a" "c" "b") ("b" "c" "b") ("c" "c" "b") ("a" "a" "c") ("b" "a" "c")
;->  ("c" "a" "c") ("a" "b" "c") ("b" "b" "c") ("c" "b" "c") ("a" "c" "c")
;->  ("b" "c" "c") ("c" "c" "c"))

Adesso basta unire le liste ed eliminare i duplicati.

(silent (setq lst (unique (sort (extend (comb-rep 1 (explode "abc"))
                                        (comb-rep 3 (explode "abc"))
                                        (comb-rep 3 (explode "abc"))
                                        (perm-rep 1 (explode "abc"))
                                        (perm-rep 2 (explode "abc"))
                                        (perm-rep 3 (explode "abc")))))))
(map join lst)
;-> ("a" "aa" "aaa" "aab" "aac" "ab" "aba" "abb" "abc" "ac" "aca" "acb" "acc"
;->  "b" "ba" "baa" "bab" "bac" "bb" "bba" "bbb" "bbc" "bc" "bca" "bcb" "bcc"
;->  "c" "ca" "caa" "cab" "cac" "cb" "cba" "cbb" "cbc" "cc" "cca" "ccb" "ccc")

Nella funzione finale calcoliamo anche la frequenza dei caratteri.

(define (strike str)
  (local (out len lst letter letter-count)
    (setq out '())
    (setq len (length str))
    (setq lst (explode str))
    ; combinazioni con ripetizione
    (for (c 1 len)
      (extend out (comb-rep c lst))
    )
    ; permutazioni con ripetizione
    (for (p 1 len)
      (extend out (perm-rep p lst))
    )
    ; calcolo della frequenza delle lettere di tutte le stringhe
    (setq letter (flat out))
    (setq letter-count (map list lst (count lst letter)))
    (println letter-count)
    ; ordina le stringhe ed elimina i duplicati
    (unique (sort (map join out)))))

(strike "abc")
;-> (("a" 49) ("b" 49) ("c" 49))
;-> ("a" "aa" "aaa" "aab" "aac" "ab" "aba" "abb" "abc" "ac" "aca" "acb" "acc"
;->  "b" "ba" "baa" "bab" "bac" "bb" "bba" "bbb" "bbc" "bc" "bca" "bcb" "bcc"
;->  "c" "ca" "caa" "cab" "cac" "cb" "cba" "cbb" "cbc" "cc" "cca" "ccb" "ccc")

(strike "abcd")
;-> (("a" 369) ("b" 369) ("c" 369) ("d" 369))
;-> ("a" "aa" "aaa" "aaaa" "aaab" "aaac" "aaad" "aab" "aaba" "aabb" "aabc"
;-> ...
;-> "ddc" "ddca" "ddcb" "ddcc" "ddcd" "ddd" "ddda" "dddb" "dddc" "dddd")

Nota: le lettere delle stringhe di output hanno tutte la stessa frequenza.

Calcoliamo la lunghezza dell'output al crescere del numero di caratteri:

(length (strike "a"))
;-> (("a" 1))
;-> 1

(length (strike "ab"))
;-> (("a" 9) ("b" 9))
;-> 6

(length (strike "abc"))
;-> (("a" 49) ("b" 49) ("c" 49))
;-> 39

(length (strike "abcd"))
;-> (("a" 369) ("b" 369) ("c" 369) ("d" 369))
;-> 340

(length (strike "abcde"))
;-> (("a" 3921) ("b" 3921) ("c" 3921) ("d" 3921) ("e" 3921))
;-> 3905

(length (strike "abcdef"))
;-> (("a" 54913) ("b" 54913) ("c" 54913) ("d" 54913) ("e" 54913) ("f" 54913))
;-> 55986

; la seguente espressione impiega alcuni minuti...
(length (strike "abcdefgh"))
;-> (("a" 18843009) ("b" 18843009) ("c" 18843009) ("d" 18843009)
;->  ("e" 18843009) ("f" 18843009) ("g" 18843009) ("h" 18843009))
;-> 19173960

La lunghezza della lista risultante è equivalente alla seguente sequenza:

Sequenza OEIS A031972: a(n) = Sum[k=1,n](n^k)
  0 1 6 39 340 3905 55986 960799 19173960 435848049
  11111111110 313842837671 9726655034460 ...

La frequenza di ogni carattere genera la seguente sequenza (che non è presente in OEIS):

  1 9 49 369 3921 54913 18843009 ...

=============================================================================

