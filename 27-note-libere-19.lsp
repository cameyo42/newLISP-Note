================

 NOTE LIBERE 19

================

  "Klaatu barada nikto"

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
    (setq hrow (join (map join (map (fn(x) (map string x)) grid)) "0"))
    ;(println hrow)
    (cond ((find "11111" hrow) (setq winner "1")
          (println "trovato 11111 in orizzontale"))
          ((find "22222" hrow) (setq winner "2")
          (println "trovato 11111 in orizzontale")))
    ; Ricerca verticale
    ; per unire le colonne trasponiamo la matrice e poi uniamo le righe
    (setq vrow (join (map join (map (fn(x) (map string x)) (transpose grid))) "0"))
    ;(println vrow)
    (cond ((find "11111" vrow) (setq winner "1")
          (println "trovato 11111 in verticale:"))
          ((find "22222" vrow) (setq winner "2")
          (println "trovato 22222 in verticale:")))
    ; Ricerca diagonale'/'
    (setq d1 (join (map join (map (fn(x) (map string x)) (diag1 grid))) "0"))
    ;(println d1)
    (cond ((find "11111" d1) (setq winner "1")
          (println "trovato 11111 in diagonale '/'"))
          ((find "22222" d1) (setq winner "2")
          (println "trovato 22222 in diagonale '/'")))
    ; Ricerca diagonale'\'
    ;(println d2)
    (setq d2 (join (map join (map (fn(x) (map string x)) (diag2 grid))) "0"))
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

(endgame? board)
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
    (setq str (join (map join (map (fn(x) (map string x)) grid)) "0"))
    (cond ((find "11111" str) (setq winner "nero"))
          ((find "22222" str) (setq winner "bianco")))
    ; Ricerca verticale
    ; per unire le colonne trasponiamo la matrice e poi uniamo le righe
    (setq str (join (map join (map (fn(x) (map string x)) (transpose grid))) "0"))
    (cond ((find "11111" str) (setq winner "nero"))
          ((find "22222" str) (setq winner "bianco")))
    ; Ricerca diagonale'/'
    (setq str (join (map join (map (fn(x) (map string x)) (diag1 grid))) "0"))
    (cond ((find "11111" str) (setq winner "nero"))
          ((find "22222" str) (setq winner "bianco")))
    ; Ricerca diagonale'\'
    (setq str (join (map join (map (fn(x) (map string x)) (diag2 grid))) "0"))
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
  (local (out len)
    (setq out '())
    (setq len (length lst))
    (for (i 0 (- len 1))
      (for (j 1 (- len i))
        ;(println i { } j)
        (push (slice lst i j) out -1)
      )
    )
    out))

Proviamo:

(contigue '(1 2 3 4))
;-> ((1) (1 2) (1 2 3) (1 2 3 4) (2) (2 3) (2 3 4) (3) (3 4) (4))

(contigue (sequence 1 5))
;-> ((1) (1 2) (1 2 3) (1 2 3 4) (1 2 3 4 5)
;->  (2) (2 3) (2 3 4) (2 3 4 5)
;->  (3) (3 4) (3 4 5)
;->  (4) (4 5)
;->  (5))

Nota: lo stesso metodo può essere applicato alle stringhe.


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

Proviamo:

(setq a '(("A" "B")
          ("C" "D")))
(paths a)
;-> (("A" "C" "D") ("A" "B" "D"))

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

Ora assegniamo i nomi ai ruoli sulla base di queste informazioni:

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


-----------
Topi e tane
-----------

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

Nota: anche se questo algoritmo permette di calcolare il codice fiscale di una persona fisica, l'unico soggetto che per legge rilascia un codice fiscale validato è l'anagrafe tributaria dell'Agenzia delle Entrate.


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


------------------------------
Lanci di monete e numeri primi
------------------------------

Lanciamo una moneta N volte, qual'è la probabilità che esca M volte Testa?
(dove M appartiene all'insieme di tutti i numeri primi)

Esempi:
  N = 2:
  SS = (TT TC CT CC)
  Prob(2) = 1/4 (per il caso TT)

  N = 3
  SS = (TTT TTC TCT CTT TCC CTC CCT CCC)
  Prob(3) = (1+3)/8 (rispettivamente per il caso di 3T e per il caso di 2T)

La probabilità cercata vale:

  Prob(n) = (Sum[k=2,3,5,7,11,...,primes-to(n)](binom (n k)) / (2^n))

Invece di cercare tutti i primi < N possiamo cercare i primi N primi, perché ogni numero primo > N restituisce zero (0) nel binomiale.

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

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (prob num)
  (local (primes sum)
    (setq primes (primes-to num))
    (setq sum 0L)
    (dolist (p primes)
      (setq sum (+ sum (binom num p)))
    )
    (setq power (** 2L num))
    (list sum power (format "%6.4f" (div sum power)))))

Facciamo alcune prove:

(prob 3L)
;-> (4L 8L "0.5000")

(prob 100L)
;-> (259998124633298346840532969570L 1267650600228229401496703205376L "0.2051")

(prob 246L)
;-> (15195371466230327564025395236853198786306754138691328084344452666115780909L
;-> 113078212145816597093331040047546785012958969400039613319782796882727665664L
;-> "0.1344")

Vediamo come fare un grafico della funzione Prob(n).

Creiamo una lista di punti:

(setq points (map (fn(x) (list x (float ((prob x) 2)))) (sequence 2 1000)))
;-> ((2 0.25) (3 0.5) (4 0.625) (5 0.6563) (6 0.6406)
;->  (7 0.6094) (8 0.5781) (9 0.5508) (10 0.5244)
;->  ...
;->  (995 0.1497) (996 0.1495) (997 0.1492)
;->  (998 0.1489) (999 0.1486) (1000 0.1483))

Esportiamo la lista in un file csv (comma-separated-value):

(define (list-csv lst file-str sepchar)
"Creates a file csv from a list"
  (local (outfile)
    (if (nil? sepchar)
        (setq sepchar ",")
    )
    (setq outfile (open file-str "write"))
    (dolist (el lst)
      (if (list? el)
          (setq line (join (map string el) sepchar))
          (setq line (string el))
      )
      (write-line outfile line)
    )
    (print outfile { })
    (close outfile)))

(list-csv points "points.csv")
;-> 3 true

Adesso possiamo importare il file dei punti con il programma preferito (gnuplot, octave, gnumeric, excel, ecc.) e plottare il grafico.

Vedi figura "primi-teste.png" nella cartella "data".


----------------------------
Numeri saltellanti (jumping)
----------------------------

Un numero saltellante è un numero intero positivo nel quale tutte le coppie di cifre decimali consecutive differiscono di 1.
Tutti i numeri a una cifra sono considerati numeri saltellanti.
La differenza tra 9 e 0 non è considerata come 1.

Sequenza OEIS A033075:
Positive numbers all of whose pairs of consecutive decimal digits differ by 1
  1 2 3 4 5 6 7 8 9 10 12 21 23 32 34 43 45 54 56 65 67 76 78 87 89 98
  101 121 123 210 212 232 234 321 323 343 345 432 434 454 456 543 545
  565 567 654 656 676 678 765 767 787 789 876 ...

Algoritmo:
Scomponiamo il numero cifra per cifra e verifichiamo per ogni coppia di cifre contigue se la differenza assoluta risulta 1.

(define (jumping? num)
  (cond
    ((<= num 10) true)
    (true
      (setq jump true)
      (setq temp num)
      (setq digit (% temp 10))
      (setq temp (/ temp 10))
      (while (and (> temp 0) jump)
        (if (!= (abs (- digit (% temp 10))) 1) (setq jump nil))
        (setq digit (% temp 10))
        (setq temp (/ temp 10))
      )
      jump)))

(jumping? 123454545456)
;-> true
(jumping? 123210)
;-> true
(jumping? 1235)
;-> nil

(filter jumping? (sequence 1 900))
;-> (1 2 3 4 5 6 7 8 9 10 12 21 23 32 34 43 45 54 56 65 67 76 78 87 89 98
;->  101 121 123 210 212 232 234 321 323 343 345 432 434 454 456 543 545
;->  565 567 654 656 676 678 765 767 787 789 876 878 898)


----------------------------------------------------
Stringa costituita solo da una sottostringa ripetuta
----------------------------------------------------

Scrivere una funzione che data una stringa restituisce "true" la stringa è composta solo da una sequenza di caratteri ripetuta.
La lunghezza della stringa è sempre maggiore di 1 e la sequenza di caratteri ha almeno una ripetizione.

L'uso di una espressione regolare risolve il problema:

(regex "^(.*)\\1+$" "aa")
;-> ("aa" 0 2 "a" 0 1)
(regex "^(.*)\\1+$" "aaa")
;-> ("aaa" 0 3 "a" 0 1)
(regex "^(.*)\\1+$" "abcabcabc")
;-> ("abcabcabc" 0 9 "abc" 0 3)
(regex "^(.*)\\1+$" "aba")
;-> nil
(regex "^(.*)\\1+$" "ababa")
;-> nil
(regex "^(.*)\\1+$" "weqweqweqweqweqw")
;-> nil

(define (subs? str) (if (regex "^(.*)\\1+$" str) true nil))

(subs? "aa")
;-> true
(subs? "aaa")
;-> true
(subs? "abcabcabc")
;-> true
(subs? "aba")
;-> nil
(subs? "ababa")
;-> nil
(subs? "weqweqweqweqweqw")
;-> nil


---------------
Numeri di Rocco
---------------

Un intero positivo N è un numero di Rocco se può essere rappresentato come:

   N = P*(P + 14) oppure
   N = P*(P - 14)
   dove P è un numero primo.

I primi 10 numeri di Rocco sono: 32,51,95,147,207,275,351,435,527,627

Notare che:

   P    P*(P - 14)
   2    -24
   3    -33
   5    -45
   7    -49
  11    -33
  13    -13
  17     51

Primo metodo:

  N = P*(P + 14) --> P^2 + 14P - N = 0
  Radice positiva: r1 = sqrt(N + 49) - 7

  N = P*(P - 14) --> P^2 + 14P - N = 0
  Radice positiva: r2 = sqrt(N + 49) + 7

Quindi basta verificare se r1 o r2 sono numeri primi.

(define (square? n)
"Check if an integer is a perfect square"
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (rocco1? num)
  (and (square? (+ num 49))
       (or (prime? (- (sqrt (+ num 49)) 7))
           (prime? (+ (sqrt (+ num 49)) 7)))))

(filter rocco1? (sequence 31 627))
;-> (32 51 95 147 207 275 351 435 527 627)

Secondo metodo:

Se consideriamo i fattori F della scomposizione in fattori primi del numero N possiamo dire che N è di Rocco se risulta:

  |F - N/F| = 14

per almeno uno dei fattori F di N.

(define (rocco2? num)
  (dolist (f (unique (factor num)))
    (if (= (abs (- f (/ num f))) 14) true nil)
  ))

(filter rocco2? (sequence 31 627))
;-> (32 51 95 147 207 275 351 435 527 627)

Per finire una funzione che genera i primi N numeri di Rocco:

(define (rocco limit)
  (setq out '())
  (setq conta 0)
  (setq i 32)
  (while (< conta limit)
    (cond ((rocco2? i)
            (++ conta)
            (push i out -1))
    )
    (++ i)
  )
  out)

(rocco 50)
;-> (32 51 95 147 207 275 351 435 527 627 851 1107 1247 1395 1551 1887 2067
;->  2255 2451 2655 2867 3551 4047 4307 4575 5135 5427 5727 6035 6351 6675
;->  7347 8051 8787 9167 9951 10355 10767 11187 11615 12051 12947 13407 14351
;->  15327 16851 17375 17907 18995 20115)


-------------------------
Catturare le regex errate
-------------------------

La seguente espressione genera un errore:

(regex "?" "abcde")
;-> ERR: regular expression in function regex : "offset 0 nothing to repeat"

Per catturare l'errore usare il seguente suggerimento di Lutz.

you have to use the second syntax of 'catch' with the extra parameter symbol to check for error exceptions:

 (catch (regex ".+?+" "a string") 'result)

If the there was an error the whole expression will return 'nil' and you have the error message in 'result'.

Else if the whole expression returns 'true', there was no error and you can inspect 'result' for the result of the the 'regex' expression, which still may be 'nil' if there was no match. Here is the whole picture:

(catch (regex ".+?+" "a string") 'result)
;-> nil
result
;-> ERR: regular expression in function regex: "offset 3 nothing to repeat:"

(catch (regex "r" "a string") 'result)
;-> true
result
;-> ("r" 4 1)

(catch (regex "x" "a string") 'result)
;-> true
result
;-> nil


------------------------
Forum: Contexts question
------------------------

Jeff:
-----
When applying a function defined in a context to a table defined outside of that context, how can you do assoc lookups?
For example:

(context 'foo)
(define (some-fn table)
  (lookup 'key-a table))

(context 'bar)
(some-fn '((key-a "value-a") (key-b "value-b")))

some-fn may be used from various contexts.
In order to lookup key-a, it must know which context we are coming from.
I can do a (name table true), but then to get the correct symbol to look up, I'm forced to do something like:

(eval-string (format "%s:key-a" (string (name table true)))

...which is incredibly verbose syntax just for a table lookup.

Anyone have a solution?

Jeff:
-----
Never mind. I've figured it out.

If I create the list in question inside of a context, and then I can pass the context to the function in another context.
With the example above:

(context 'foo)
(define (some-fn ctx)
  (lookup 'ctx:key-a ctx:table))

(context 'bar)
(set 'table ((key-a "value-a") (key-b "value-b")))

(context 'whatever)
(foo:some-fn bar)

Now, foo is reading the context of the input, and can lookup based on the context's symbols in the context's lists.

Lutz:
-----
... and as an added benefit you have passed your bar:table by reference, which is nice if your are dealing with a lot of data.


----------------------------------
Potenze di 2 che formano un numero
----------------------------------

Dato un intero positivo N, restituisce il risultato delle potenze di due la cui somma è uguale a N.
In altre parole, occorre trasformare il numero in binario e vedere quali posizioni delle potenze di 2 hanno valore 1.
Esempio:

N = 82
(bits 82)
;-> "1010010"

  +-----+-----+-----+-----+-----+-----+-----+
  | 2^6 | 2^5 | 2^4 | 2^3 | 2^2 | 2^1 | 2^0 | Potenze di 2
  +-----+-----+-----+-----+-----+-----+-----+
  | 64  | 32  | 16  |  8  |  4  |  2  |  1  | Valore delle potenze di 2
  +-----+-----+-----+-----+-----+-----+-----+
  |  1  |  0  |  1  |  0  |  0  |  1  |  0  | Valore binario di N
  +-----+-----+-----+-----+-----+-----+-----+
  | 64  |     | 16  |     |  2  |     |     |  64 + 16 + 2 = 80
  +-----+-----+-----+-----+-----+-----+-----+

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Funzione che trasforma un numero decimale in binario (big-integer):

(define (bitsL n)
  (setq max-int (pow 2 62))
  (define (prep s) (string (dup "0" (- 62 (length s))) s))
  (if (<= n max-int) (bits (int n))
      (string (bitsL (/ n max-int))
              (prep (bits (int (% n max-int)))))))

(define (sum2 num)
  (local (out bit len val)
    (setq out '())
    (setq binary (bitsL num))
    (setq bit (explode binary))
    (setq len (length binary))
    (dolist (b bit)
      (if (= b "1")
          (setq val (** 2 (- len $idx 1)))
          (setq val 0)
      )
      (push val out -1)
    )
    out))

Facciamo alcune prove:

(sum2 0)
;-> (0)

(sum2 1234)
;-> (1024L 0 0 128L 64L 0 16L 0 0 2L 0)

(sum2 128)
;-> (128L 0 0 0 0 0 0 0)

(** 2 78)
;-> 302231454903657293676544L
(sum2 (** 2 78))
;-> (302231454903657293676544L 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
(length (sum2 (** 2 78)))
;-> 79


--------------------------------------------------------
Forum: Matching the dollar sign in a regular expression?
--------------------------------------------------------

cormullion:
-----------
Is there some trick to searching for a plain unadorned dollar sign occurring in text with a regular expression?
I'm trying to replace the two characters \$ when followed by one or two digits with a single character $ followed by the digit(s) found.
I've lost sight of the answer in a downpour of baffling backslashes ... :-)

Lutz:
-----
Like this:

(replace {\\\$} {abc\$cde} "x" 0)
;-> "abcxcde"
(replace "\\\\\\$" "abc\\$cde" "x" 0)
;-> "abcxcde"

- both the backslash \ and the dollar sign are special characters in regular expression patterns (not the string, only the pattern) and have to be escaped by a \

- additionally when using quotes "" than a backslash is also a special character for newLISP.\ and must be esacped by a \.

- the {,} in newLISP takes all chracters literally, makeing things a bit easier.

... so in my examples I am actually replacing two character: the backslash and a dollar sign with an 'x'.

Nor sure if you meant, the dollar sign only:

(replace {\$} {abc$cde} "x" 0)
;-> "abcxcde"
(replace "\\\$" "abc$cde" "x" 0)
 ;-> "abcxcde"


-------------------------------------
Forum: Context switching in functions
-------------------------------------

Jeff:
-----
Does anyone know why this doesn't work?

(context 'bar)
;-> bar
;-> bar>
(context MAIN)
MAIN
(define (test) (context 'bar) (set 'x 100) (context MAIN))
;-> (lambda () (context 'bar) (set 'x 100) (context MAIN))
x
;-> nil
(set 'bar:x 10)
;-> 10
(test)
;-> MAIN
bar:x
;-> 10
x
;-> 100

Can you not switch contexts in a function's scope?

Lutz:
-----
The context statement only changes the context for translation of source into symbols when doing load, sym or eval-string.
Once a symbol is translated (after newLISP read your definition of 'test') it stays in the context it was translated in (which was MAIN), this happens before evaluation of (define (test) ...).

Context switches are only important when translating source into symbols.

This is described in Newlisp manual (contexts).

and in more detail here:

http://newlisp.org/ExpressionEvaluation.html

Jeff:
-----
But bar was defined first, before test.
I understood the (context 'sym) syntax to act as a procedural switch to another namespace.
I don't understand how switching contexts this way differs from doing it from the outermost lexical enclosure.
And if there is a difference, isn't that making the context function itself act within the lexical scope, rather than the dynamic scope from which it was called (as opposed to the contents of the context switched to)?

Lutz:
-----
The context statement on the top level is functioning during loading of subsequent source. The context statement inside the function is working during function execution:

(define (test) (context 'bar) (set (sym "x") 10))

(test)
;-> 10
bar:x
;-> 10

These are the steps:

(1) read top-level expression
(2) translate symbols
(3) evaluate top-level expression
(4) goto (1)

please read: http://newlisp.org/ExpressionEvaluation.html

ps: Context switches are only important when translating source into symbols. Once a symbol is translated it stays in its context forever.

Jeff:
-----
I read that while you were replying.
It explains better than the manual.
So the (context 'foo) syntax functions almost like a preprocessor command (or as close to that as you can get with an interpreted language).
Because it appears inside a lambda, it is not evaluated until the lambda is applied, yes?

If this is so, then I am still somewhat confused. Here is an example I am not sure I understand:

(define (foo x y)
  (context 'bar)
  (local (a) (println (name a true)))
  (context MAIN))

In that example, local a lexically appears after the context switch. Would that be inserted into bar?

Lutz:
-----
So the (context 'foo) syntax functions almost like a preprocessor command (or as close to that as you can get with an interpreted language). Because it appears inside a lambda, it is not evaluated until the lambda is applied, yes?

yes

Context switches are only important when translating source into symbols.
In your example is no 'sym or 'eval-string statement.

All symbols in function foo where translated when reading the toplevel (define (foo x y) ...) definition.
When evaluating the definition, the only thing which happened was assigning a lambda expression (which is already in memory translated into a binary structure) to the symbol foo.
When evaluating (foo ...) and then (local ...) inside, all symbol translation already has happened.

A context switch only has influence on subsequent 'sym and 'eval-string statements not on 'local and not on any other only 'sym and 'eval-string.

There is no interpretation happening during function evaluation in newLISP. All lexical analysis and translating is done before that.

ps: the best practice for 'sys and 'eval-string is to specify the context of translation in the 'sys or 'eval-string statement itself as one of the parameters.

Jeff:
-----
Ok, I think I have a better understanding of it now. The walkthrough on the low-level docs is helpful.


---------------------------------
ABC triple, ABC-hit, ABC-superhit
---------------------------------

ABC-triple
----------
Tre interi positivi A, B, C sono ABC-triple se risulta:

  1) A,B,C sono coprimi tra loro (cioè gcd(A, B, C) = 1)
  2) A < B
  3) A + B = C

Esempi:

1, 8, 9 è una ABC-triple poiché sono coprimi, 1 < 8 e 1 + 8 = 9
5, 7, 12 è una ABC-triple poiché sono coprimi, 5 < 7 e 5 + 7 = 12
4, 3, 7 non è una ABC-triple perché 4 > 3

(define (coprime? a b)
"Check if two integer are coprime"
  (= (gcd a b) 1))

Funzione che verifica se una terna di numeri interi positivi è ABC-triple:

(define (abc-triple? a b c)
  (and (= (+ a b) c) (< a b) (= (gcd a b c) 1)))

Facciamo alcune prove:

(abc-triple? 1 8 9)
;-> true

(abc-triple? 5 7 12)
;-> true

; 2, 4 e 6 non sono coprimi tra loro
(abc-triple? 2 4 6)
;-> nil

; 13 > 5
(abc-triple? 13 5 18)
;-> nil

ABC-hit
-------
Tre interi positivi A, B, C sono ABC-hit se risulta:

  radicale(A*B*C) < C

Il radicale di un numero intero positivo è il prodotto dei distinti fattori primi del numero.

(define (radical num)
  (if (= num 1) 1
      (apply * (unique (factor num)))))

Funzione che verifica se una terna di numeri interi positivi è ABC-hit:

(define (abc-hit? a b c)
  (< (radical (* a b c)) c))

(abc-hit? 1 8 9)
;-> true

(abc-hit? 5 7 12)
;-> true

; 2, 4 e 6 non sono coprimi tra loro
(abc-hit? 2 4 6)
;-> nil

; 13 > 5
(abc-hit? 13 5 18)
;-> nil

a) Tra tutte le 15*10^6 ABC-triple con C < 10000 abbiamo 120 ABC-hit.

b) Tra tutte le 380*10^6 ABC-triple con C < 50000 abbiamo 276 ABC-hit.

Teorema: Ci sono infinite terne ABC-hit.

Vedi "The ABC-conjecture" di Frits Beukers, ABC-day, Leiden 9 september 2005.
https://web.archive.org/web/20181227041615/http://www.staff.science.uu.nl/%7Ebeuke106/ABCpresentation.pdf

Proviamo a verificare a) e b) in modo brute-force (3 cicli for):

(define (test1 max-c)
  (let ( (triple 0) (hit 0) )
    (for (a 1 max-c)
      (for (b 1 max-c)
        (for (c 1 max-c)
          (cond ((abc-triple? a b c)
                  (++ triple)
                  ;(println triple " triple: " (list a b c))
                  (if (abc-hit? a b c) (++ hit)))
                  ;(println hit " hit: " (list a b c))))
          )
        )
      )
    )
    (list triple hit)))

Proviamo:

(test1 10)
;-> (15 1)
(test1 100)
;-> (1521 6)
(time (println (test 1000)))
;-> (152095 31)
;-> 119291.338

; Don't try...
;(time (println (test 9999)))

Ottimizziamo un pò le cose:

- Facciamo partire il ciclo "for" con B da A + 1

- Invece del ciclo "for" con C, poniamo C = A + B (scartando i valori di C che non soddisfano ABC-triple)

- Se A e B sono coprimi, allora anche la loro somma è coprima con A e B:
  (gcd a b c) = (gcd a b)

- Inseriamo il codice delle funzioni "abc-triple" e "abc-hit" nella funzione finale.

(define (test2 max-c)
  (let ( (triple 0) (hit 0) )
    (for (a 1 max-c)
      (for (b (+ a 1) max-c 1 (> (+ a b) max-c))
        (setq c (+ a b))
          (cond ((and (< a b) (= (gcd a b) 1))
                  (++ triple)
                  (if (< (apply * (unique (factor (* a b c)))) c) (++ hit)))
          )
      )
    )
    (list triple hit)))

Proviamo:

(test2 10)
;-> (15 1)
(test2 100)
;-> (1521 6)
(time (println (test2 1000)))
;-> (152095 31)
;-> 275.797
(time (println (test2 9999)))
;-> (15196742 120)
;-> 52222.693

Siamo arrivati a verificare C < 10000.

Eseguiamo la seguente espressione e andiamo a leggere un libro...

(time (println (test2 49999)))
;-> (379952131 276)
;-> 3311592.318 ; 55m 11s 592ms

In qualche modo siamo arrivati a verificare C < 50000.

ABC-superhit
------------
Tre interi positivi A, B, C sono ABC-superhit se risulta:

  (radicale(A*B*C))^k < C, con k > 1

(define (abc-superhit? a b c k)
  (< (pow (radical (* a b c)) k) c))

(define (test3 max-c k)
  (let ( (triple 0) (superhit 0) )
    (for (a 1 max-c)
      (for (b (+ a 1) max-c 1 (> (+ a b) max-c))
        (setq c (+ a b))
          (cond ((and (< a b) (= (gcd a b) 1))
                  (++ triple)
                  (if (abc-superhit? a b c k) (begin
                      (println a { } b { } c { } k) (++ superhit))))
          )
      )
    )
    (list triple superhit)))

Congettura ABC (Masser-Oesterle, 1985)
--------------------------------------
Sia k > 1. Allora, con un numero finito di eccezioni risulta:
  C < radicale(ABC)^k.

Proviamo a cercare qualche ABC-triple che è anche ABC-superhit:

(setq k 2)
(test3 100 k)
;-> (1521 0)
(test3 1000 k)
;-> (152095 0)
(time (println (test3 9999 2)))
;-> (15196742 0)
;-> 55852.736

(setq k 1.5)
(test3 100 k)
;-> (1521 0)
(test3 1000 k)
;-> (152095 0)
(time (println (test3 9999 1.5)))
;-> 1 4374 4375 1.5
;-> (15196742 1)
;-> 56713.125
(abc-superhit? 1 4374 4375 1.5)
;-> true

(setq k 1.1)
(test3 100 k)
;-> 1 8 9 1.1
;-> 1 63 64 1.1
;-> 1 80 81 1.1
;-> 32 49 81 1.1
;-> (1521 4)
;-> (1521 4)
(test3 1000 k)
;-> 1 8 9 1.1
;-> 1 63 64 1.1
;-> 1 80 81 1.1
;-> 1 242 243 1.1
;-> 1 288 289 1.1
;-> 1 512 513 1.1
;-> 3 125 128 1.1
;-> 13 243 256 1.1
;-> 25 704 729 1.1
;-> 32 49 81 1.1
;-> 32 343 375 1.1
;-> 49 576 625 1.1
;-> 104 625 729 1.1
;-> 169 343 512 1.1
;-> (152095 14)
(time (println (test3 9999 k)))
;-> 1 8 9 1.1
;-> 1 63 64 1.1
;-> 1 80 81 1.1
;-> 1 242 243 1.1
;-> 1 288 289 1.1
;-> 1 512 513 1.1
;-> 1 1024 1025 1.1
;-> ...
;-> 625 2048 2673 1.1
;-> 1024 1377 2401 1.1
;-> 1024 2187 3211 1.1
;-> 1125 8192 9317 1.1
;-> 1183 8192 9375 1.1
;-> 2401 4160 6561 1.1
;-> (15196742 50)
;-> 56561.055

Con k < 2 qualche ABC-superhit esiste.


-------------------------
Somma massima con N liste
-------------------------

Date N liste con lunghezze non necessariamente uguali contenenti numeri interi, risolvere i seguenti due problemi.

Problema 1
----------
Trovare la somma massima selezionando un elemento per ogni lista.
Poichè abbiamo N liste la somma è costituita da N numeri interi.

Il problema si risolve facilmente selezionando il numero massimo di ogni lista.

(define (max-sum1 lst)
  (let (sum 0)
    (dolist (el lst)
      (++ sum (apply max el))
    )
    sum))

(setq a '((21 15 3) (19 5 14 1) (20 2 18 4 4)))
(max-sum1 a)
;-> 60

Problema 2
----------
Trovare la somma massima selezionando un elemento per ogni lista in modo che non esistano indici uguali tra gli elementi che compongono la somma massima.

Esempio:
lst1 = (10 5 8)
lst2 = (20 6 12)

Nel caso del primo problema abbiamo:
somma massima = 10 + 20 = 30

Nel secondo problema abbiamo:
somma massima = 8 + 20 = 28
Infatti non possiamo scegliere i valori 10 e 20 perchè entrambi hanno indice 0.
Invece 8 ha indice 2 e 20 ha indice 0.

Questo secondo problema è più difficle...

Per trovare la somma massima dobbiamo verificare tutte le combinazioni tra gli elementi delle liste e assicurarsi che i loro indici non siano uguali.
Usiamo il prodotto cartesiano tra liste per generare tutte le combinazioni, poi scegliamo quelle valide e poi calcoliamo la somma massima.
Non possiamo utilizzare le liste per il prodotto cartesiano perchè dobbiamo verificare che gli indici siano validi.
Generiamo il prodotto cartesiano utilizzando le liste degli indici per ogni lista.

(define (cartesian-product lst-lst)
"Calculates the cartesian product of a list of lists"
  (let (out '())
    (dolist (el (apply cp lst-lst 2))
      (push (flat el) out -1)
    )
    out))
; auxiliary function: cartesian product of two list
(define (cp lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        '()
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

(define (max-sum2 lst)
  (let ( (seq '()) (all-index '()) (valid-index '())
         (values '())
         (somma 0) (somma-max -999999999) )
    ; genera la lista delle liste/sequenze) degli indici
    ; ((0 1 2) (0 1 2 3 4) ... (0 1))
    (dolist (el lst)
      (setq el-index (sequence 0 (- (length el) 1)))
      (push el-index seq -1)
    )
    ; calcola il prodotto cartesiano delle liste/sequenze degli indici
    (setq all-index (cartesian-product seq))
    ; filtra solo le combinazioni valide delle sequenze
    ; cioè quelle che hanno tutti gli indici diversi
    (setq valid-index (filter (fn(x) (= x (unique x))) all-index))
    ; Calcolo della somma massima
    ; per ogni combinazione,
    ; estrae i valori da sommare dalla lista relativa e verifica
    ; se il risultato supera la somma massima.
    ; In caso positivo aggiorna la soluzione che è del tipo:
    ; (somma-massima (val1 val2 ... valN) (idx1 idx2 ... idxN)
    (dolist (vi valid-index)
      (setq values '())
      ; recupera i valori dalle relative liste
      ; utilizzando la combinazione corrente di indici
      (dolist (el vi)
        ; valore all'indice corrente nella relativa lista
        (push (select (lst $idx) el) values)
      )
      ; valori da sommare
      (setq values (flat values))
      (setq somma (apply + values))
      ; per vedere come viene aggiornata la somma massima
      ; togliere il commento ";" alla linea seguente
      ;(print (list somma-max values vi)) (read-line)
      ; verifica se somma > somma massima
      (if (> somma somma-max)
          (begin
            (setq somma-max somma)
            (setq out (list somma-max values vi)))
      )
    )
    out))

Proviamo:

(setq a '((21 15 3) (19 5 14 1) (20 2 18 4 4)))
(max-sum2 a)
;-> (-999999999 (18 5 21) (0 1 2))
;-> (44 (4 5 21) (0 1 3))
;-> (44 (4 5 21) (0 1 4))
;-> (44 (2 14 21) (0 2 1))
;-> ...
;-> (52 (2 1 3) (2 3 1))
;-> (52 (4 1 3) (2 3 4))
;-> (52 (18 19 15) (1 0 2))
;-> (52 (18 19 15) (1 0 2))

La lista di output ha la seguente struttura:
  (somma-massima (val1 val2 ... valN) (idx1 idx2 ... idxN)

(max-sum2 '((1 3) (1 3)))
;-> (4 (3 1) (0 1))
(max-sum2 '((1 4 2) (5 6 1)))
;-> (9 (5 4) (1 0))
(max-sum2 '((-2 -21)(18 2)))
;-> (0 (2 -2) (0 1))
(max-sum2 '((1 2 3) (4 5 6) (7 8 9)))
;-> (15 (9 5 1) (0 1 2))
(max-sum2 '((1 2 3 4) (5 4 3 2) (6 2 7 1)))
;-> (16 (7 5 4) (3 0 2))

Nota: il prodotto cartesiano di N liste genera una lista con il seguente numero di elementi:

Numero di elementi = Lunghezza del primo elenco *
                     Lunghezza del secondo elenco *
                     ...
                     Lunghezza dell'N-esimo elenco

Vediamo la velocità della funzione:

(define (make-list num-lst min-len max-len max-val)
  (let (lst '())
    (for (i 1 num-lst) (push (rand max-val (+ min-len (rand (- max-len min-len)))) lst))
  lst))

5 liste da 5 a 10 elementi con valore massimo 100
(setq t1 (make-list 5 5 10 100))
;-> ((52 95 7 87 65 32 10 50) (31 95 87 72 30 94 12 6 78)
;->  (44 29 46 50 15 32 73) (85 15 32 7 7 64 82 54)
;->  (4 97 31 56 30 17 10 86))
(apply * (map length t1))
;-> 32256

8 liste da 5 a 10 elementi con valore massimo 100
(setq t2 (make-list 8 5 10 100))
(apply * (map length t2))
;-> 9483264 ;oops...
(time (println (max-sum2 t2)))
;-> (676 (69 96 93 89 85 90 74 80) (1 6 5 4 0 7 3 2))
;-> 20675.646

10 liste da 5 a 10 elementi con valore massimo 100
(setq t3 (make-list 10 5 10 100))
(apply * (map length t3))
;-> 180633600 ; 180 milioni 633 mila 600
Se proviamo con 10 liste newLISP va in crash (e forse anche windows)...
; (time (println (max-sum2 t2)))
;-> CRASH


-------------
Polilogaritmo
-------------

Il polilogaritmo è una funzione speciale che generalizza il logaritmo.
Dato un numero complesso, si definisce la funzione polilogaritmo di ordine s e argomento (complesso) z la serie di potenze:

  Li[s](z) = Sum[k=1..inf](z^k/k^s) = (z + z^2/s^2 + z^3/s^3 + ...)
             per ogni |z| < 1.

Per s = 1, otteniamo il classico logaritmo:

  Li[1](z) = Sum[k=1..inf](z^k)/k = -ln(1 - z)

(define (polylog s z)
  (let (sum 0)
    (for (k 1 1e3)
      ;(print sum) (read-line)
      (setq sum (add sum (div (pow z k) (pow k s))))
    )
    sum))

Proviamo:

(polylog 2 0.95)
;-> 1.440633796970039

(polylog 2 0.5)
;-> 0.5822405264650125

(polylog -3 0.95)
;-> 866779.9999999995

(polylog -3 0.5)
;-> 26
;-> 0.5822405264650125

Per |z| > 1, vedere l'articolo:
"Note on fast polylogarithm computation" by R. E. Crandall
https://www.reed.edu/physics/faculty/crandall/papers/Polylog.pdf


------------------------------------------------
Ordinare una lista con un'altra lista (variante)
------------------------------------------------

Vedi anche "Ordinare una lista con un'altra lista" su "Note libere 5".

Data una lista di nomi di colori univoci, ordinarli nell'ordine in cui appaiono per primi nella lista seguente:

colori = ("red" "yellow" "green" "brown" "scarlet" "black" "ochre"
          "peach" "ruby" "olive" "violet" "fawn" "lilac" "gold"
          "chocolate" "mauve" "cream" "crimson" "silver" "rose"
          "azure" "lemon" "russet" "grey" "purple" "white" "pink"
          "orange" "blue")

Per esempio:
lista = blue, green, red
ordinamento = red, green, blue

(setq colori '("red" "yellow" "green" "brown" "scarlet" "black" "ochre"
               "peach" "ruby" "olive" "violet" "fawn" "lilac" "gold"
               "chocolate" "mauve" "cream" "crimson" "silver" "rose"
               "azure" "lemon" "russet" "grey" "purple" "white" "pink"
               "orange" "blue"))

Creiamo una lista associativa con elementi del tipo: (colore posizione)

(setq col-pos (map (fn(x) (list x $idx)) colori))
;-> (("red" 0) ("yellow" 1) ("green" 2) ("brown" 3) ("scarlet" 4)
;->  ("black" 5) ("ochre"6) ("peach" 7) ("ruby" 8) ("olive" 9)
;->  ("violet" 10) ("fawn" 11) ("lilac" 12) ("gold" 13) ("chocolate" 14)
;->  ("mauve" 15) ("cream" 16) ("crimson" 17) ("silver" 18) ("rose" 19)
;->  ("azure" 20) ("lemon" 21) ("russet" 22) ("grey" 23) ("purple" 24)
;->  ("white" 25) ("pink" 26) ("orange" 27) ("blue" 28))

Per vedere la posizione di un colore usiamo "lookup":

(lookup "ruby" col-pos)
;-> 8

Funzione che ordina due colori in base alla posizione sulla lista col-pos:

(define (check x y)
  (<= (lookup x col-pos) (lookup y col-pos)))

Adesso basta usare "sort" sulla lista di input:

(sort '("blue" "green" "red") check)
;-> ("red" "green" "blue")

Scriviamo la funzione finale:

(define (ordina lst base)
  (define (check x y) (<= (lookup x base-pos) (lookup y base-pos)))
  (let (base-pos (map (fn(x) (list x $idx)) base))
    (sort lst check)))

Proviamo:
(ordina '("green" "blue" "red" "brown") colori)
;-> ("red" "green" "brown" "blue")

(ordina '("gold" "grey" "green") colori)
;-> ("green" "gold" "grey")

(ordina '("ruby" "yellow" "red" "grey") colori)
;-> ("red" "yellow" "ruby" "grey")

(ordina '("gold" "green" "fawn" "white" "azure" "rose" "black" "purple"
        "orange" "silver" "ruby" "blue" "lilac" "crimson" "pink" "cream"
        "lemon" "russet" "grey" "olive" "violet" "mauve" "chocolate"
        "yellow" "peach" "brown" "ochre" "scarlet" "red") colori)
;-> ("red" "yellow" "green" "brown" "scarlet" "black" "ochre" "peach"
;->  "ruby" "olive" "violet" "fawn" "lilac" "gold" "chocolate" "mauve"
;->  "cream" "crimson" "silver" "rose" "azure" "lemon" "russet" "grey"
;->  "purple" "white" "pink" "orange" "blue")

La funzione può essere applicata anche a liste con altri tipi di elementi oltre alle stringhe.
Per esempio:

(setq order '(1 9 2 8 3 7 4 5 6))

(ordina '(1 2 3 4 5 6 7 8 9) order)
;-> (1 9 2 8 3 7 4 5 6)


----------------
Digital sumorial
----------------

Il digital sumorial di un numero N è dato dalla somma delle somme digitali di N per tutte le basi da 1 a N.

La formula è la seguente:

  Sum[b=2..(n+1)](Sum[i=0..(n-1)](floor(n/b^i)) mod b)

Sequenza OEIS A131383:
Total digital sum of n: sum of the digital sums of n for all the bases 1 to n
  1, 3, 6, 8, 13, 16, 23, 25, 30, 35, 46, 46, 59, 66, 75, 74, 91, 91, 110,
  112, 125, 136, 159, 152, 169, 182, 195, 199, 228, 223, 254, 253, 274, 291,
  316, 297, 334, 353, 378, 373, 414, 409, 452, 460, 475, 498, 545, 520, 557,
  565, 598, 608, 661, 652, 693, 690, ...

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Funzione che calcola il digital sumorial di un numero:

(define (sumorial num)
  (let ( (sumor 0) (val 0) )
    (setq sumor 0)
    (for (b 2 (+ num 1))
      (setq val 0)
      (for (i 0 (- num 1)) (++ val (% (floor (div num (** b i))) b)))
      (++ sumor val)
    )
  sumor))

(map sumorial (sequence 1 50))
;-> (1 3 6 8 13 16 23 25 30 35 46 46 59 66 75 74 91 91 110 112 125 136
;->  159 152 169 182 195 199 228 223 254 253 274 291 316 297 334 353 378
;->  373 414 409 452 460 475 498 545 520 557 565)


--------------------------
Quanti giri fa una boccia?
--------------------------

"Non sa neanche quanti giri fa una boccia"
Questo è un detto delle mie parti per indicare una persona ignorante.

Ma quanti giri fa una boccia per percorrere una certa distanza?

Supponiamo che una boccia che rotola possa essere rappresentata da un cerchio che rotola lungo la sua circonferenza.
Per trovare il numero di rotazioni necessarie ad un cerchio (boccia) per percorrere una determinata distanza, possiamo utilizzare la formula:

                           Distanza
  Numero di Rotazioni = ---------------
                         Circonferenza

La circonferenza di un cerchio (boccia) è data dalla formula:

  Circonferenza = 2*π*Raggio

Quindi la formula per il numero di rotazioni diventa:

                          Distanza
  Numero di Rotazioni = ------------
                         2*π*Raggio

(define (rotations distance radius)
  (div distance (mul 2 3.1415926535897931 radius)))

Le ruote di una bicicletta da 28'' (pollici) hanno un diametro di 622 mm (millimetri).
Quanti giri deve fare la ruota per percorrere 1 km (kilometro)?

  Raggio(metri) = 0.622/2 = 0.311 m (metri)

(rotations 1000 0.311)
;-> 511.7522285913034


---------------
Excel Date code
---------------

Il foglio elettronico Excel tratta (internamente) le date con un numero intero positivo (date-code).

Il date-code viene calcolato da Excel nel modo seguente:
I giorni vengono contati partendo da 0 per lo 0 gennaio 1900 (che non esiste).
Quindi il date-code indica con 1 il 1 gennaio 1900.
Inoltre esiste il 29 febbraio 1900 con indice 60 (1900 viene considerato bisestile anche se non lo è).
Quindi il date-code indica con 61 il 1 marzo 1900.

Vediamo una tabella riassuntiva:

     0  -> (1900 01 00)    Nota: Non (1899 12 31)
     1  -> (1900 01 01)
     2  -> (1900 01 02)
    59  -> (1900 02 28)
    60  -> (1900 02 29)    Nota: Non (1900 03 01)
    61  -> (1900 03 01)
   100  -> (1900 04 09)
  1000  -> (1902 09 26)
 10000  -> (1927 05 18)
100000  -> (2173 10 14)

Usiamo due funzioni per le date.

(define (gdate-julian gdate)
"Convert gregorian date to julian day number (valid only from 15 ottobre 1582 A.D.)"
  (local (a y m)
    (setq a (/ (- 14 (gdate 1)) 12))
    (setq y (+ (gdate 0) 4800 (- a)))
    (setq m (+ (gdate 1) (* 12 a) (- 3)))
    (+ (gdate 2) (/ (+ (* 153 m) 2) 5) (* y 365) (/ y 4) (- (/ y 100)) (/ y 400) (- 32045))))

(define (julian-gdate jd)
"Convert julian day number to gregorian date (valid only from 15 ottobre 1582 A.D.)"
  (local (a b c d e m)
    (setq a (+ jd 32044))
    (setq b (/ (+ (* 4 a) 3) 146097))
    (setq c (- a (/ (* b 146097) 4)))
    (setq d (/ (+ (* 4 c) 3) 1461))
    (setq e (- c (/ (* 1461 d) 4)))
    (setq m (/ (+ (* 5 e) 2) 153))
    (list
      (+ (* b 100) d (- 4800) (/ m 10))
      (+ m 3 (- (* 12 (/ m 10))))
      (+ e (- (/ (+ (* 153 m) 2) 5)) 1))))

Facendo alcune prove troviamo i valori del numero giuliano per le date particolari.

(gdate-julian '(1900 1 0))
;-> 2415020
(julian-gdate 2415020)
;-> (1899 12 31)

(gdate-julian '(1900 1 1))
;-> 2415021
(julian-gdate 2415021)
;-> (1900 1 1)

(gdate-julian '(1900 2 29))
;-> 2415080
(julian-gdate 2415080)
;-> (1900 3 1)

Il numero giuliano di base è 2415021 a cui bisogna:
- aggiungere il date-code e togliere 2 (se date-code > 60)
- aggiungere il date-code e togliere 1 (se date-code < 60)
I casi (date-code = 0) e (date-code = 60) vengono trattati singolarmente

Funzione che converte un date-code di Excel nella data corrispondente:

(define (excel-date date-code)
  (cond ((= date-code 0)  '(1900 1 0))
        ((= date-code 60) '(1900 2 29))
        ((> date-code 60) (julian-gdate (+ 2415021 date-code (- 2))))
        ((< date-code 60) (julian-gdate (+ 2415021 date-code (- 1))))))

Proviamo:

(excel-date 0)
;-> (1900 1 0)
(excel-date 1)
;-> (1900 1 1)
(excel-date 2)
;-> (1900 1 2)
(excel-date 59)
;-> (1900 2 28)
(excel-date 60)
;-> (1900 2 29)
(excel-date 61)
;-> (1900 3 1)
(excel-date 1000)
;-> (1902 9 26)
(excel-date 10000)
;-> (1927 5 18)
(excel-date 100000)
;-> (2173 10 14)

Perchè Excel tratta il 1900 come anno bisestile?
------------------------------------------------
Uno dei primi fogli elettronici è stato "Lotus 1-2-3" sviluppato dal 1983.
All'epoca la RAM era di 640kb e i programmatori della Lotus decisero di considerare bisestile gli anni che erano divisibili per 4 (mentre un anno divisibile per 100 è bisestile solo se è anche divisibile per 400).
In questo modo coprivano un arco di tempo dal 1900 al 2100 (che sembrava più che sufficiente).
"Excel" è stato sviluppato dopo "Lotus-123" e per ragioni di compatibilità (possibilità di importare i file di Lotus 1-2-3) ha mantenuto questo comportamento (controlled-bug).
Anche il foglio elettronico "Calc" di OpenOffice si comporta in modo simile.
Il foglio elettronico "gnumeric" ha il seguente output:

     0	 1899-12-31
     1	 1900-01-01
    59	 1900-02-28
    60	 ##########
    61	 1900-03-01
   100	 1900-04-09
  1000	 1902-09-26
  10000	 1927-05-18


--------------
Il topo goloso
--------------

Ci sono N pile di formaggio accatastate in modo rettangolare per R righe e C colonne.
Ogni pila è formata da un certo numero di formaggi
La pila più piccola contiene 1 formaggio e quella più grande K formaggi.
Possiamo rappresentare le pile con una matrice:

  3 7 10  5
  6 8 12 13
 15 9 11  4
 14 1 16  2

In questo esempio ci sono 16 pile disposte in modo 4x4.
La pila (0 0) contiene 3 formaggi.
La pila (0 2) contiene 10 formaggi.

Il topo goloso parte da una pila casuale, la mangia, e poi passa alla pila vicina più grande, la mangia, e continua cosi finchè non ha più alcuna pila vicino.
Una pila può avere da 3 a 8 vicini (orizzontale, verticale e diagonale).

(setq m '((3 7 10 5)
          (6 8 12 13)
          (15 9 11 4)
          (14 1 16 2)))

(setq row-len (length m))
(setq col-len (length (m 0)))

Funzione che calcola la pila vicina con il valore massimo:
(restituisce una lista (valore-massimo riga colonna))

(define (max-vicino matrix r c)
  (let ( (val 0) (val-max 0) (r-idx -1) (c-idx -1) )
    ; muove in basso
    (cond ((> r 0)
            (setq val (matrix (- r 1) c))
            (if (> val val-max) (set 'val-max val 'r-idx (- r 1) 'c-idx c))))
    ; muove in alto
    (cond ((< r (- row-len 1))
            (setq val (matrix (+ r 1) c))
            (if (> val val-max) (set 'val-max val 'r-idx (+ r 1) 'c-idx c))))
    ; muove a sinistra
    (cond ((> c 0)
            (setq val (matrix r (- c 1)))
            (if (> val val-max) (set 'val-max val 'r-idx r 'c-idx (- c 1)))))
    ; muove a destra
    (cond ((< c (- col-len 1))
            (setq val (matrix r (+ c 1)))
            (if (> val val-max) (set 'val-max val 'r-idx r 'c-idx (+ c 1)))))
    ; muove in alto a sinistra
    (cond ((and (> r 0) (> c 0))
            (setq val (matrix (- r 1) (- c 1)))
            (if (> val val-max) (set 'val-max val 'r-idx (- r 1) 'c-idx (- c 1)))))
    ; muove in alto a destra
    (cond ((and (> r 0) (< c (- col-len 1)))
            (setq val (matrix (- r 1) (+ c 1)))
            (if (> val val-max) (set 'val-max val 'r-idx (- r 1) 'c-idx (+ c 1)))))
    ; muove in basso a sinistra
    (cond ((and (< r (- row-len 1)) (> c 0))
            (setq val (matrix (+ r 1) (- c 1)))
            (if (> val val-max) (set 'val-max val 'r-idx (+ r 1) 'c-idx (- c 1)))))
    ; muove in basso a destra
    (cond ((and (< r (- row-len 1)) (< c (- col-len 1)))
            (setq val (matrix (+ r 1) (+ c 1)))
            (if (> val val-max) (set 'val-max val 'r-idx (+ r 1) 'c-idx (+ c 1)))))
    (list val-max r-idx c-idx)))

Proviamo la funzione:

(for (r 0 3) (for (c 0 3) (println (list (m r c) (max-vicino m r c)))))
;-> (3 (7 0 1)) (7 (10 0 2)) (10 (7 0 1)) (5 (10 0 2)) (6 (8 1 1))
;-> (8 (12 1 2)) (12 (13 1 3)) (13 (12 1 2)) (15 (9 2 1)) (9 (15 2 0))
;-> (11 (13 1 3)) (4 (13 1 3)) (14 (15 2 0)) (1 (16 3 2)) (16 (11 2 2))
;-> (2 (16 3 2))

Scriviamo la funzione finale:

(define (mouse matrix start-row start-col)
  (local (row-len col-len somma cell rimasti)
    (setq row-len (length matrix))
    (setq col-len (length (matrix 0)))
    (setq somma (matrix start-row start-col))
    (print "Formaggi: " somma)
    (setq cell (max-vicino matrix start-row start-col))
    (setf (matrix start-row start-col) -1)
    ; se (cell 0) = 0, allora il topo non ha più pile vicine da mangiare
    (until (zero? (cell 0))
      (setf (matrix (cell 1) (cell 2)) -1)
      (setq somma (+ somma (cell 0)))
      (print { } (cell 0))
      (setq cell (max-vicino matrix (cell 1) (cell 2)))
    )
    (setq rimasti (clean (fn(x) (= x -1)) (flat matrix)))
    (println "\nTotale formaggi: " somma)
    (println "Rimasti: " rimasti " = " (apply + rimasti))
    matrix))

Facciamo alcune prove con il topo:

(mouse m 3 2)
;-> Formaggi: 16 11 13 12 10 8 15 14 9 6 7 3
;-> Totale formaggi: 124
;-> Rimasti: (5 4 1 2) = 12
;-> ((-1 -1 -1 5) (-1 -1 -1 -1) (-1 -1 -1 4) (-1 1 -1 2))

(setq m1 '((1 6 4)
           (2 3 5)
           (6 8 2)))

(mouse m1 0 0)
;-> Formaggi: 1 6 5 8 6 3 4
;-> Totale formaggi: 33
;-> Rimasti: (2 2) = 4
;-> ((-1 -1 -1) (2 -1 -1) (-1 -1 2))

(mouse m1 2 2)
;-> Formaggi: 2 8 6 3 6 5 4
;-> Totale formaggi: 34
;-> Rimasti: (1 2) = 3
;-> ((1 -1 -1) (2 -1 -1) (-1 -1 -1))

(mouse '(( 4  3  2  1) ( 5  6  7  8) (12 11 10  9) (13 14 15 16)) 3 3)
;-> Formaggi: 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
;-> Totale formaggi: 136
;-> Rimasti: () = 0
;-> ((-1 -1 -1 -1) (-1 -1 -1 -1) (-1 -1 -1 -1) (-1 -1 -1 -1))

(mouse '(( 8  1  9 14) (11  6  5 16) (13 15  2  7) (10  3 12  4)) 1 3)
;-> Formaggi: 16 14 9 6 15 13 11 8 1 5 7 12 4 2 3 10
;-> Totale formaggi: 136
;-> Rimasti: () = 0
;-> ((-1 -1 -1 -1) (-1 -1 -1 -1) (-1 -1 -1 -1) (-1 -1 -1 -1))

(mouse '(( 1  2  3  4) ( 5  6  7  8) ( 9 10 11 12) (13 14 15 16)) 3 3)
;-> Formaggi: 16 15 14 13 10 11 12 8 7 6 9 5 2 3 4
;-> Totale formaggi: 135
;-> Rimasti: (1) = 1
;-> ((1 -1 -1 -1) (-1 -1 -1 -1) (-1 -1 -1 -1) (-1 -1 -1 -1))

(mouse '((10 15 14 11) ( 9  3  1  7) (13  5 12  6) ( 2  8  4 16)) 3 3)
;-> Formaggi: 16 12 8 13 9 15 14 11 7 6 4 5 3 10
;-> Totale formaggi: 133
;-> Rimasti: (1 2) = 3
;-> ((-1 -1 -1 -1) (-1 -1 1 -1) (-1 -1 -1 -1) (2 -1 -1 -1))

(mouse '(( 3  7 10  5) ( 6  8 12 13) (15  9 11  4) (14  1 16  2)) 3 2)
;-> Formaggi: 16 11 13 12 10 8 15 14 9 6 7 3
;-> Totale formaggi: 124
;-> Rimasti: (5 4 1 2) = 12
;-> ((-1 -1 -1 5) (-1 -1 -1 -1) (-1 -1 -1 4) (-1 1 -1 2))

(mouse '(( 8  9  3  6) (13 11  7 15) (12 10 16  2) ( 4 14  1  5)) 2 2)
;-> Formaggi: 16 15 7 11 13 12 14 10 4
;-> Totale formaggi: 102
;-> Rimasti: (8 9 3 6 2 1 5) = 34
;-> ((8 9 3 6) (-1 -1 -1 -1) (-1 -1 -1 2) (-1 -1 1 5))

(mouse '(( 8 11 12  9) (14  5 10 16) ( 7  3  1  6) (13  4  2 15)) 1 3)
;-> Formaggi: 16 12 11 14 8 5 10 9
;-> Totale formaggi: 85
;-> Rimasti: (7 3 1 6 13 4 2 15) = 51
;-> ((-1 -1 -1 -1) (-1 -1 -1 -1) (7 3 1 6) (13 4 2 15))

(mouse '((13 14  1  2) (16 15  3  4) ( 5  6  7  8) ( 9 10 11 12)) 1 0)
;-> Formaggi: 16 15 14 13
;-> Totale formaggi: 58
;-> Rimasti: (1 2 3 4 5 6 7 8 9 10 11 12) = 78
;-> ((-1 -1 1 2) (-1 -1 3 4) (5 6 7 8) (9 10 11 12))

(mouse '(( 9 10 11 12) ( 1  2  4 13) ( 7  8  5 14) ( 3 16  6 15)) 3 1)
;-> Formaggi: 16 8 7 3
;-> Totale formaggi: 34
;-> Rimasti: (9 10 11 12 1 2 4 13 5 14 6 15) = 102
;-> ((9 10 11 12) (1 2 4 13) (-1 -1 5 14) (-1 -1 6 15))

(mouse '(( 9 10 11 12) ( 1  2  7 13) ( 6 16  4 14) ( 3  8  5 15)) 2 1)
;-> Formaggi: 16 8 6 3
;-> Totale formaggi: 33
;-> Rimasti: (9 10 11 12 1 2 7 13 4 14 5 15) = 103
;-> ((9 10 11 12) (1 2 7 13) (-1 -1 4 14) (-1 -1 5 15))


----------------------------------------------------------
Ordinare una lista di numeri in base alle cifre più grandi
----------------------------------------------------------

Data una lista di numeri interi, ordinarli in ordine discendente in base alle singole cifre più grandi.
L'ordine dei numeri con la stessa cifra più grande viene quindi ordinato in base alla seconda cifra più grande, ecc.
La prima cifra dei numeri negativi viene considerata positiva.
Per esempio:
  lista = (346 834 789 134 198 -910)
  lista ordinata in base alle cifre maggiori = (789 198 -910 834 346 134)

Possiamo ordinare le cifre di ogni numero, ordinare i numeri risultanti e poi sostituirli con i loro valori originali.

(setq nums '(346 834 789 134 198 -910))

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

Scomposizione dei numeri in cifre:
(setq a (map (fn(x) (int-list (abs x))) nums))
;-> ((3 4 6) (8 3 4) (7 8 9) (1 3 4) (1 9 8) (9 1 0))

Ordinamento delle cifre per ogni numero:
(setq b (map (fn(x) (sort x >)) a))
;-> ((6 4 3) (8 4 3) (9 8 7) (4 3 1) (9 8 1) (9 1 0))

Creazione dei numeri dei nuovi numeri:
(setq c (map list-int b))
;-> (643 843 987 431 981 910)

Ordinamento dei nuovi numeri:
(setq d (sort c >))

A questo punto non sappiamo quali siano i valori originali associati a questi numeri, cioè, per esempio, quale valore era associato al numero 987?

Dobbiamo fare tutte le precedenti operazioni portandoci dietro i valori originali.
Poichè dobbiamo operare sempre sul risultato della precedente operazione, possiamo scrivere le espressioni in modo concatenato:

Lista con elementi: (nuovo numero, numero originale)
(map (fn(x) (list (list-int (sort (int-list (abs x)) >)) x)) nums)
;-> ((643 346) (843 834) (987 789) (431 134) (981 198) (910 -910))

Ordinamento decrescente (nuovo numero) della lista:
(sort (map (fn(x) (list (list-int (sort (int-list (abs x)) >)) x)) nums) >)
;-> ((987 789) (981 198) (910 -910) (843 834) (643 346) (431 134))

Estrazione dei numeri originali dalla lista precedente:
(map last (sort (map (fn(x) (list (list-int (sort (int-list (abs x)) >)) x)) nums) >))
;-> (789 198 -910 834 346 134)

La funzione finale è composta da una singola espresione:

(define (sort-digits lst)
  (map last
       (sort
       (map (fn(x) (list (list-int (sort (int-list (abs x)) >)) x)) nums) >)))

(sort-digits nums)
;-> (789 198 -910 834 346 134)


------------------------------------
Numeri lessicograficamenti crescenti
------------------------------------

Un numero lessicograficamente crescente è un numero intero naturale (non negativo) le cui cifre sono in ordine strettamente crescente.

Scrivere una funzione che elenca questi numeri da un valore minimo "a" a un valore massimo "b".

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che verifica se un numero è lessicograficamente crescente:

(define (lexical? num)
  (or (< num 10) (apply < (int-list num))))

Nota: (apply < lst) restituisce true solo se gli elementi della lista "lst" sono ordinati in modo strettamente decrescente.

Funzione che trova tutti i numeri lessicograficamente crescente da "a" a "b":

(define (lexical a b)
  (filter lexical? (sequence a b)))

(lexical 0 1000)
;-> (0 1 2 3 4 5 6 7 8 9 12 13 14 15 16 17 18 19 23 24 25 26 27 28 29
;->  34 35 36 37 38 39 45 46 47 48 49 56 57 58 59 67 68 69 78 79 89 123
;->  124 125 126 127 128 129 134 135 136 137 138 139 145 146 147 148 149
;->  156 157 158 159 167 168 169 178 179 189 234 235 236 237 238 239 245
;->  246 247 248 249 256 257 258 259 267 268 269 278 279 289 345 346 347
;->  348 349 356 357 358 359 367 368 369 378 379 389 456 457 458 459 467
;->  468 469 478 479 489 567 568 569 578 579 589 678 679 689 789)


----------------------------------------------------
Perchè (sqrt x) restituisce solo la radice positiva?
----------------------------------------------------

Perchè i linguaggi di programmazione calcolano solo la soluzione positiva della radice quadrata di un numero intero positivo?
Per esempio: sqrt(4) = 2 e -2, infatti 2*2 = 4 e (-2)*(-2) = 4.

Quando i linguaggi di programmazione calcolano la radice quadrata di un intero positivo, in genere restituiscono solo la soluzione positiva, nota come radice quadrata principale.
Questa decisione viene presa per ragioni pratiche e di semplicità.

Coerenza e prevedibilità
------------------------
Restituire solo la radice quadrata positiva garantisce coerenza e prevedibilità nei risultati.
Per ogni dato numero positivo, gli utenti possono aspettarsi lo stesso risultato su diverse piattaforme e linguaggi di programmazione.

Semplicità
----------
La maggior parte dei linguaggi di programmazione punta alla semplicità per rendere più semplice l'utilizzo e la comprensione del linguaggio da parte degli sviluppatori.
Restituire solo la radice quadrata positiva semplifica l'implementazione e riduce la necessità di casi speciali o logica aggiuntiva.

Casi d'uso comuni
-----------------
In molte applicazioni del mondo reale, la radice quadrata positiva è la soluzione rilevante.
Ad esempio, quando si ha a che fare con misurazioni quali lunghezze, aree o volumi, i valori negativi potrebbero non avere senso.
Fornendo costantemente la radice quadrata positiva, i linguaggi di programmazione si allineano con questi casi d'uso comuni.

Convenzione matematica
----------------------
La radice quadrata principale è una convenzione matematica ben consolidata.
Quando i matematici si riferiscono alla radice quadrata, in genere intendono la radice quadrata principale.
Questa convenzione viene applicata ai linguaggi di programmazione per mantenere la compatibilità con le aspettative matematiche.

Se abbiamo bisogno di radici quadrate sia positive che negative, possiamo ottenere la soluzione negativa moltiplicando la soluzione positiva per -1.
Per esempio:

(define (sqrt2 num)
  (letn ( (a (sqrt num)) (b (mul a -1)) ) (list a b)))

(sqrt2 4)
;-> (2 -2)

Questo approccio consente flessibilità pur rispettando la convenzione di restituire la radice quadrata principale per impostazione predefinita.

Per finire troviamo tutte le soluzioni dell'equazione: x^4 = 16.
(ricordi di scuola superiore)

  x^4 = 16  -->  x^4 - 16 = 0  -->  (x^2 - 4)*(x^2 + 4) = 0
  (x^2 - 4) = 0  -->  x^2 =  4  -->  x1 = 2,  x2 = -2
  (x^2 + 4) = 0  -->  x^2 = -4  -->  x3 = 2i, x4 = -2i

Vedi anche "Radice quadrata di numeri complessi" in "Note libere 12".


--------------------------------
La congettura di Collatz inversa
--------------------------------

La sequenza di Collatz viene generata partendo da un numero intero positivo iniziale N >= 1 e seguendo le seguenti regole:

  N = 1 -> stop
  N -> N / 2 (se N è pari)
  N -> 3 * N + 1 (se N è dispari)

(define (collatz num)
  (let (out (list num))
    (while (!= num 1)
      (if (even? num)
          (setq num (/ num 2))
          (setq num (+ (* 3 num) 1))
      )
      (push num out -1)
    )
    out))

(collatz 13)
;-> (13 40 20 10 5 16 8 4 2 1)

La sequenza di Collatz inversa viene generata partendo da un numero intero positivo iniziale n >= 1 e seguendo le seguenti regole:

  N = 0 -> stop
  N = (3*N + 1) (se N pari)
  N = (N - 1)/2 (se N dispari)

(define (ztalloc num)
  (let (out (list num))
    (while (!= num 0)
      (if (even? num)
          (setq num (+ (* 3 num) 1))
          (setq num (/ (- num 1) 2))
      )
      (print num { }) (read-line)
      (push num out -1)
    )
    out))

Proviamo:

(ztalloc 2)
;-> 7
;-> 3
;-> 1
;-> 0
;-> (2 7 3 1 0)

(ztalloc 14)
;-> 43
;-> 21
;-> 10
;-> 31
;-> 15
;-> 7
;-> 3
;-> 1
;-> 0
;-> (14 43 21 10 31 15 7 3 1 0)

In questo caso il problema è che alcuni numeri generano delle sequenze ripetute (loop di una stessa sequenzaa di numeri):

(ztalloc 12)
;-> 37
;-> 18
;-> 55
;-> 27
;-> 13
;-> 6
;-> 19
;-> 9
;-> 4
;-> 13 ; numero già incontrato

Modifichiamo la funzione per arrestare il calcolo quando incontriamo un loop.

(define (ztalloc num)
  (let (out (list num))
    (while (!= num 0)
      (if (even? num)
          (setq num (+ (* 3 num) 1))
          (setq num (/ (- num 1) 2))
      )
      (if-not (ref num out)
          (push num out -1)
          (begin (push (list num) out -1) (setq num 0)))
    )
    out))

Proviamo:

(ztalloc 14)
;-> (14 43 21 10 31 15 7 3 1 0)
(ztalloc 12)
;-> (12 37 18 55 27 13 6 19 9 4 (13))

(map ztalloc (sequence 1 16))
;-> ((1 0)
;->  (2 7 3 1 0)
;->  (3 1 0)
;->  (4 13 6 19 9 (4))
;->  (5 2 7 3 1 0)
;->  (6 19 9 4 13 (6))
;->  (7 3 1 0)
;->  (8 25 12 37 18 55 27 13 6 19 9 4 (13))
;->  (9 4 13 6 19 (9))
;->  (10 31 15 7 3 1 0)
;->  (11 5 2 7 3 1 0)
;->  (12 37 18 55 27 13 6 19 9 4 (13))
;->  (13 6 19 9 4 (13))
;->  (14 43 21 10 31 15 7 3 1 0)
;->  (15 7 3 1 0)
;->  (16 49 24 73 36 109 54 163 81 40 121 60 181 90 271 135 67 33 (16)))

Vediamo le lunghezze delle sequenze:

(define (ztalloc-length num) (length (ztalloc num)))

(map ztalloc-length (sequence 1 100))
;-> (2 5 3 6 6 6 4 13 6 7 7 11 6 10 5 19 14 9 6 25 8 20 8 19 12 9 7 11
;->  11 23 6 30 19 15 15 19 10 14 7 19 26 9 9 24 21 18 9 28 19 13 13 17
;->  10 19 8 30 12 12 12 19 24 21 7 38 31 22 19 20 16 20 16 26 19 11 11
;->  15 15 15 8 24 19 27 27 28 10 41 10 37 25 19 22 19 19 23 10 36 29
;->  22 20 36)

(apply max (map ztalloc-length (sequence 0 1e2)))
;-> 41
(apply max (map ztalloc-length (sequence 0 1e3)))
;-> 133
(apply max (map ztalloc-length (sequence 0 1e4)))
;-> 245
(apply max (map ztalloc-length (sequence 0 1e5)))
;-> 339

(time (println (apply max (map ztalloc-length (sequence 0 1e6)))))
;-> 572
;-> 59943.3
(ref 572 (map ztalloc-length (sequence 0 1e6)))
;-> 858340
(ztalloc-length 858340)
;-> 572
(ztalloc 858340)
;-> (858340 2575021 1287510 3862531 1931265 965632 2896897 1448448 4345345
;->  2172672 6518017 3259008 9777025 4888512 14665537 7332768 21998305
;-> ...
;->  391 195 97 48 145 72 217 108 325 162 487 243 121 60 181 90 271 135
;->  67 33 16 49 24 73 36 109 54 163 81 40
;->  (121))

Una funzione in stile LISP che funziona solo per sequenze che terminano.
Le sequenze che hanno un loop generano un errore di stack overflow (ricorsione infinita).

(define (z n) (cons n (if (zero? n) nil (if (even? n) (z (+ (* n 3) 1)) (z (/ (- n 1) 2))))))

Proviamo:
(z 14)
;-> (14 43 21 10 31 15 7 3 1 0 nil)
(z 10)
;-> (10 31 15 7 3 1 0 nil)
(z 12)
;-> ERR: call or result stack overflow in function if : even?
;-> called from user function (z (/ (- n 1) 2))
;-> called from user function (z (+ (* n 3) 1))
;-> ...

Versione estesa:

(define (z n) (cons n (if (zero? n)
                          nil
                          (if (even? n)
                              (z (+ (* n 3) 1))
                              (z (/ (- n 1) 2))
                          )
                      )
              )
)


---------------------------
Un altro problema algebrico
---------------------------

Se a + b = 1 e a^2 + b^2 = 2, quanto vale a^3 + b^3 ?

  a + b = 1         (1)
  a^2 + b^2 = 2     (2)
  a^3 + b^3 = ?     (3)

Per prima cosa troviamo ab:

Dal quadrato di (1) otteniamo:

  (a + b)^2 = 1^2 = 1             (4)

Espansione del quadrato di (a + b):

  (a + b)^2 = a^2 + b^2 + 2ab     (5)

Dalla parte destra di (4) e (5) ricaviamo ab:

  a^2 + b^2 + 2ab = 1             (6)

       1 - (a^2 + b^2)
  ab = --------------- = -1/2 = -0.5       (7)
              2

Ricaviamo a e b dalla (1) e (7):

  (a + b) = 1
  ab = -1/2

  a = -1/2b
  (-1/2b + b) = 1 --> 2b^2 - 2b - 1 = 0     (8)

Risolviamo l'equazione di secondo grado:

(define (quadratic a b c)
"Find the solutions of the quadratic equation: A*x^2 + B*x + C = 0"
  (local (x1 i1 x2 i2 delta)
    (setq delta (sub (mul b b) (mul 4 a c)))
    (cond ((= a 0) ; equazione di primo grado
            (if (!= b 0) (setq x1 (sub 0 (div c b)))))
          ((> delta 0) ; due radici reali
            (setq x1 (div (add (sub 0 b) (sqrt delta)) (mul 2 a)))
            (setq x2 (div (sub (sub 0 b) (sqrt delta)) (mul 2 a)))
            (setq i1 0.0)
            (setq i2 0.0))
          ((< delta 0) ; due radici complesse
            (setq x1 (div (sub 0 b) (mul 2 a)))
            (setq x2 (div (sub 0 b) (mul 2 a)))
            (setq i1 (div (sqrt (sub 0 delta)) (mul 2 a)))
            (setq i2 (sub 0 (div (sqrt (sub 0 delta)) (mul 2 a)))))
          (true ;((= delta 0) ; due radici coincidenti
            (setq x1 (sub 0 (div b (mul 2 a))))
            (setq x2 (sub 0 (div b (mul 2 a))))
            (setq i1 0.0)
            (setq i2 0.0))
    )
    (list (list x1 i1) (list x2 i2))))

(quadratic 2 -2 -1)
;-> ((1.366025403784439 0) (-0.3660254037844386 0))

Le Soluzioni di (8) sono le seguenti:

  b1 = 1.366025403784439
  a1 = 1 - b = -0.3660254037844386
  b2 = -0.3660254037844386
  a2 = 1 - b2 =  1.366025403784439

A questo punto possiamo calcolare a^3 + b^3 analiticamente:

(setq a1 -0.3660254037844386)
(setq b1 1.366025403784439)
(setq a2 1.366025403784439)
(setq b2 -0.3660254037844386)

(add (pow a1 3) (pow b1 3))
;-> 2.500000000000002
(add (pow a2 3) (pow b2 3))
;-> 2.500000000000002

Oppure possiamo continuare in modo algebrico:

Dal cubo di (1) otteniamo:

  (a + b)^3 = 1^3 = 1              (9)

Espansione del cubo di (a + b):

  a^3 + b^3 + 3ab(a + b)           (10)

Dalla (9) e (10) otteniamo:

  a^3 + b^3 + 3ab(a + b) = 1       (11)

Adesso sostituiamo in (11) ab con -1/2 e (a + b) con 1:

  a^3 + b^3 + 3(-1/2)1 = 1         (12)

Da cui possiamo ricavare il valore di a^3 + b^3:

  a^3 + b^3 = 1 + 3/2 = 5/2 = 2.5


--------------------------------------
Divisione tra numeri interi (stringhe)
--------------------------------------

Funzione che restituisce true se str1 < str2:

(define (smaller? str1 str2)
  (local (n1 n2 out)
    (setq n1 (length str1))
    (setq n2 (length str2))
    (cond ((> n1 n2) (setq out nil))
          ((< n1 n2) (setq out true))
          (true
            (setq out nil)
            (setq stop nil)
            (for (i 0 (- n1 1) 1 stop)
              (cond ((< (str1 i) (str2 i))
                     (set 'out true 'stop true))
                    ((> (str1 i) (str2 i))
                     (set 'out nil 'stop true))
              )
            )
          )
    )
    out))

(< "1234" "98")
;-> true
(smaller? "1234" "98")
;-> nil

Funzione che sottrae due numeri interi passati come stringhe:

(define (sub- str1 str2)
  (local (n1 n2 str val carry z)
    (setq z (char "0"))
    ; str1 deve essere maggiore o uguale a str2
    (if (smaller? str1 str2) (swap str1 str2))
    (setq str "")
    (setq n1 (length str1))
    (setq n2 (length str2))
    ; inversione delle stringhe
    (reverse str1)
    (reverse str2)
    (setq carry 0)
    ; Ciclo per tutta la stringa più corta
    ; sottrae le cifre di str1 a str2
    (for (i 0 (- n2 1))
      (setq val (int (str1 i)))
      (setq val (- (- (char (str1 i)) z)
                   (- (char (str2 i)) z)
                   carry))
      ; Se la sottrazione è minore di zero
      ; allora aggiungiamo 10 a val e
      ; poniamo il riporto (carry) a 1
      (if (< val 0)
          (set 'val (+ val 10) 'carry 1)
          ; else
          (set 'carry 0)
      )
      (extend str (char (+ val z)))
    )
    ; sottrae le cifre rimanenti del numero maggiore
    (if (!= n1 n2) (begin
        ; sottrae le cifre che rimangono di str1
        (for (i n2 (- n1 1))
          (setq val (- (- (char (str1 i)) z) carry))
          ; se il valore val è negativo, allora lo rende positivo
          (if (< val 0)
            (set 'val (+ val 10) 'carry 1)
            ;else
            (set 'carry 0)
          )
          (extend str (char (+ val z)))
        ))
    )
    (reverse str)
    ; toglie gli (eventuali) zeri iniziali
    (while (= (str 0) "0") (pop str))
    (if (= str "") (setq str "0"))
    str))

Funzione che divide due numeri interi passati come stringhe:

(define (div-str str1 str2)
  (let (conta 0)
    (cond
      ((= str1 str2 0) (setq conta "0/0"))
      ((= str1 0) (setq conta "0"))
      ((= str2 0) (setq conta "1/0"))
      ((smaller? str1 str2) (setq conta "0"))
      ((= str1 str2) (setq conta "1"))
      (true
        (while (smaller? str2 str1)
          (setq str1 (sub- str1 str2))
          (++ conta)
        )
        (if (= str1 str2) (++ conta)))
    )
    (string conta)))

Proviamo:

(div-str "100" "200")
;-> "0"
(div-str "111" "111")
;-> 1"
(div-str "222" "110")
;-> "2"
(div-str "222" "112")
;-> "1"
(div-str "222" "111")
;-> "2"
(div-str "123456789" "1234")
;-> "100046"

(= (extend (sub- "3827461234561879235612789356172345617823456213564823456125634923451276345123764512763451276384"
                 "1563876348596238947562389745628937456237894657823945646375623945623456723465798263495639245384") "L")
   (string (- 3827461234561879235612789356172345617823456213564823456125634923451276345123764512763451276384
              1563876348596238947562389745628937456237894657823945646375623945623456723465798263495639245384)))
;-> true

(define (test iter)
  (local (a b as bs)
    (for (i 1 iter)
      (setq a (+ (rand 1e6) 1)) ; not zero
      (setq b (+ (rand 1e6) 1)) ; not zero
      (if (< a b) (swap a b))
      (setq as (string a))
      (setq bs (string b))
      (if (!= (string (/ a b)) (div-str as bs))
          (println a { } b { } as { } bs { } (+ a b) { } (sub- as bs))))))

(time (test 1e5))
;-> 27049.179

Nessun errore su 1e5 divisioni.


-------------------
Il teorema di Ryley
-------------------

Il matematico inglese Samuel Ryley dimostrò il seguente teorema nel 1825:

Ogni numero razionale può essere espresso come somma di tre cubi razionali.

   x^3 + y^3 + z^3 = r

La seguente formula si trova in:
Richmond, H. (1930) "On Rational Solutions of x^3+y^3+z^3=R"
Proceedings of the Edinburgh Mathematical Society, 2(2), 92-100.
https://doi.org/10.1017/S0013091500007604

         27r^3 + 1
  x = ----------------
       27r^2 - 9r + 3

      -27r^3 + 9r - 1
  y = ----------------
       27r^2 - 9r + 3

        -27r^2 + 9r
  z = ----------------
       27r^2 - 9r + 3

(define (solve r)
  (local (a b c den x y z xx yy zz x y z)
    (setq a (mul 27 r r r))
    (setq b (mul 27 r r))
    (setq c (mul 9 r))
    (setq den (add b (- c) 3))
    ;(println den)
    (setq xx (list (add a 1) den))
    (setq yy (list (add (- a) c (- 1)) den))
    (setq zz (list (add (- b) c) den))
    (println "Soluzione con frazioni: \n" xx { } yy { } zz)
    (setq x (div (xx 0) (xx 1)))
    (setq y (div (yy 0) (yy 1)))
    (setq z (div (zz 0) (zz 1)))
    (println "Soluzione con numeri reali: \n" x { } y { } z)
    (println "Valore di verifica: "
             (add (mul x x x) (mul y y y) (mul z z z)))))

Proviamo:

(solve 1)
;-> Soluzione con frazioni:
;-> (28 21) (-19 21) (-18 21)
;-> Soluzione con numeri reali:
;-> 1.333333333333333 -0.9047619047619048 -0.8571428571428571
;-> Valore di verifica: 1

(solve 42)
;-> Soluzione con frazioni:
;-> (2000377 47253) (-1999999 47253) (-47250 47253)
;-> Soluzione con numeri reali:
;-> 42.33333333333334 -42.32533384123759 -0.9999365119674941
;-> Valore di verifica: 42.00000000001698

(solve 30)
;-> Soluzione con frazioni:
;-> (729001 24033) (-728731 24033) (-24030 24033)
;-> Soluzione con numeri reali:
;-> 30.33333333333333 -30.32209878084301 -0.9998751716389964
;-> Valore di verifica: 30.00000000000289

(solve 33)
;-> Soluzione con frazioni:
;-> (970300 29109) (-970003 29109) (-29106 29109)
;-> Soluzione con numeri reali:
;-> 33.33333333333334 -33.32313030334261 -0.9998969390910028
;-> Valore di verifica: 33.00000000000826


------------------------------------
Numeri sparsi (numeri di Fibbinacci)
------------------------------------

Un numero sparso, o numero di Fibbinacci (Marc LeBrun), è un intero positivo la cui rappresentazione binaria non ha 1 consecutivi.
Ad esempio, 5 (101 in binario) e 21 (10101) sono numeri sparsi, ma 6 (110) e 13 (1101) non lo sono.

Sequenza OEIS A003714:
  0, 1, 2, 4, 5, 8, 9, 10, 16, 17, 18, 20, 21, 32, 33, 34, 36, 37, 40,
  41, 42, 64, 65, 66, 68, 69, 72, 73, 74, 80, 81, 82, 84, 85, 128, 129,
  130, 132, 133, ...

(define (sparse? num)
  (not (find "11" (bits num))))

(filter sparse? (sequence 0 100))
;-> (0 1 2 4 5 8 9 10 16 17 18 20 21 32 33 34 36 37 40
;->  41 42 64 65 66 68 69 72 73 74 80 81 82 84 85)

Nota: il numero di tali numeri con n bit è fibonacci(n), per n > 2.

Per semplicità precalcoliamo i primi 1e5 numeri sparsi:

(silent (setq sparsi (filter sparse? (sequence 0 1e5))))

(define (fibbinacci num)
  (++ num 2)
  (setq fib 0)
  (dolist (s sparsi)
    (setq binary (bits s))
    (cond ((= (length binary) num) (++ fib))))
  fib)

(map fibbinacci (sequence 0 15))
;-> (1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597)


--------------------------
Numeri stabili e instabili
--------------------------

Un numero stabile è quello in cui tutte le cifre hanno la stessa frequenza, mentre un numero instabile ha frequenze diverse per le sue cifre.
Ad esempio, il numero 112233 è stabile perché la cifra "1" appare due volte, "2" appare due volte e "3" appare due volte.
Invece il numero 44277 è instabile perché la cifra "4" appare due volte, "2" appare una volta e "7" appare due volte.

(define (stable? num)
  (cond ((< num 10) true)
        (true
          (setq str (explode (string num)))
          (setq freq (count (unique str) str))
          (or (= (length freq) 1) (apply = freq)))))

Proviamo:

(stable? 112233)
;-> true
(stable? 44277)
;-> nil

Numeri stabili fino a 20:

(filter stable? (sequence 1 20))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)

Numeri instabili fino a 1000:

(clean stable? (sequence 1 200))
;-> (100 101 110 112 113 114 115 116 117 118 119 121 122 131
;->  133 141 144 151 155 161 166 171 177 181 188 191 199 200)

Conteggio dei numeri stabili fino a N = 10, 100, 1e3, 1e4, 1e5, 1e6 ,1e7, 1e8:

(length (filter stable? (sequence 1 1e1)))
;-> 10
(length (filter stable? (sequence 1 1e2)))
;-> 99
(length (filter stable? (sequence 1 1e3)))
;-> 756
(length (filter stable? (sequence 1 1e4)))
;-> 5544
(length (filter stable? (sequence 1 1e5)))
;-> 32769
(length (filter stable? (sequence 1 1e6)))
;-> 179388

La frequenza dei numeri stabili diminuisce con l'aumentare di N:

(time (println (div (length (filter stable? (sequence 1 1e1))) 1e1)))
;-> 1
;-> 0
(time (println (div (length (filter stable? (sequence 1 1e2))) 1e2)))
;-> 0.99
;-> 0
(time (println (div (length (filter stable? (sequence 1 1e3))) 1e3)))
;-> 0.756
;-> 2.823
(time (println (div (length (filter stable? (sequence 1 1e4))) 1e4)))
;-> 0.5544
;-> 23.938
(time (println (div (length (filter stable? (sequence 1 1e5))) 1e5)))
;-> 0.32769
;-> 270.424
(time (println (div (length (filter stable? (sequence 1 1e6))) 1e6)))
;-> 0.179388
;-> 2936.176
(time (println (div (length (filter stable? (sequence 1 1e7))) 1e7)))
;-> 0.0723717
;-> 31749.101
(time (println (div (length (filter stable? (sequence 1 1e8))) 1e8)))
;-> 0.02835801
;-> 339428.42

Vedi il grafico "stabili.png" nella cartella "data".


----------------------------------------------
Numeri odiosi (odious) e numeri malvagi (evil)
----------------------------------------------

I numeri malvagi (Evil numbers) sono numeri interi non negativi che hanno un numero pari di 1 nello loro rappresntazione binaria.

Sequenza OEIS A001969:
  0, 3, 5, 6, 9, 10, 12, 15, 17, 18, 20, 23, 24, 27, 29, 30, 33, 34, 36,
  39, 40, 43, 45, 46, 48, 51, 53, 54, 57, 58, 60, 63, 65, 66, 68, 71, 72,
  75, 77, 78, 80, 83, 85, 86, 89, 90, 92, 95, 96, 99, 101, 102, 105, 106,
  108, 111, 113, 114, 116, 119, 120, 123, 125, 126, 129, ...

I numeri odiosi (Odious numbers) sono numeri interi positivi che hanno un numero dispari di 1 nello loro rappresntazione binaria.

Sequenza OEIS A000069:

  1, 2, 4, 7, 8, 11, 13, 14, 16, 19, 21, 22, 25, 26, 28, 31, 32, 35, 37,
  38, 41, 42, 44, 47, 49, 50, 52, 55, 56, 59, 61, 62, 64, 67, 69, 70, 73,
  74, 76, 79, 81, 82, 84, 87, 88, 91, 93, 94, 97, 98, 100, 103, 104, 107,
  109, 110, 112, 115, 117, 118, 121, 122, 124, 127, 128, ...

(define (conta-1 num)
  (first (count '("1") (explode (bits num)))))

(define (odious? num) (even? (conta-1 num)))
(define (evil? num)   (odd?  (conta-1 num)))

(filter odious? (sequence 0 100))
;-> (0 3 5 6 9 10 12 15 17 18 20 23 24 27 29 30 33 34 36 39 40 43 45 46 48 51
;->  53 54 57 58 60 63 65 66 68 71 72 75 77 78 80 83 85 86 89 90 92 95 96 99)

(filter evil? (sequence 0 100))
;-> (1 2 4 7 8 11 13 14 16 19 21 22 25 26 28 31 32 35 37 38 41 42 44 47 49 50 52
;->  55 56 59 61 62 64 67 69 70 73 74 76 79 81 82 84 87 88 91 93 94 97 98 100)

(define (evil-odious num)
  (let ((evil '()) (odious '()) (val 0))
    (for (i 0 num)
      (setq val (conta-1 i))
      (if (even? val)
          (push i evil -1)
          (push i odious -1)
      )
    )
    (list evil odious)))

(evil-odious 50)
;-> ((0 3 5 6 9 10 12 15 17 18 20 23 24 27 29 30 33 34 36 39 40 43 45 46 48)
;->  (1 2 4 7 8 11 13 14 16 19 21 22 25 26 28 31 32 35 37 38 41 42 44 47 49 50))


-----------
Numeri puri
-----------

Un numero puro è un numero che soddisfa le seguenti tre condizioni:
  1) Il numero ha un numero pari di cifre.
  2) Tutte le sue cifre sono 4 o 5.
  3) Il numero rimane lo stesso quando le sue cifre vengono invertite.

La funzione non è difficile da scrivere, ma il problema è quale ordine di condizioni rende la funzione più veloce?

(define (pure1? num)
  (let (str (string num))
    (and (even? (length str))         ; condizione 1
         (= str (reverse (copy str))) ; condizione 3
         (regex "^(4|5)+$" str))))    ; condizione 2

(time (println (filter pure1? (sequence 1 1e6))))
;-> (44 55 4444 4554 5445 5555 444444 445544
;->  454454 455554 544445 545545 554455 555555)
;-> 837.683

(define (pure2? num)
  (let (str (string num))
    (and (even? (length str))            ; condizione 1
         (regex "^(4|5)+$" str)          ; condizione 2
         (= str (reverse (copy str)))))) ; condizione 3

(time (println (filter pure2? (sequence 1 1e6))))
;-> (44 55 4444 4554 5445 5555 444444 445544
;->  454454 455554 544445 545545 554455 555555)
;-> 800.396

(define (pure3? num)
  (let (str (string num))
    (and (regex "^(4|5)+$" str)          ; condizione 2
         (even? (length str))            ; condizione 1
         (= str (reverse (copy str)))))) ; condizione 3

(time (println (filter pure3? (sequence 1 1e6))))
;-> (44 55 4444 4554 5445 5555 444444 445544
;->  454454 455554 544445 545545 554455 555555)
;-> 768.281

(define (pure4? num)
  (let (str (string num))
    (and (regex "^(4|5)+$" str)       ; condizione 2
         (= str (reverse (copy str))) ; condizione 3
         (even? (length str)))))      ; condizione 1

(time (println (filter pure4? (sequence 1 1e6))))
;-> (44 55 4444 4554 5445 5555 444444 445544
;->  454454 455554 544445 545545 554455 555555)
;-> 768.757

(define (pure5? num)
  (let (str (string num))
    (and (= str (reverse (copy str))) ; condizione 3
         (regex "^(4|5)+$" str)       ; condizione 2
         (even? (length str)))))      ; condizione 1

(time (println (filter pure5? (sequence 1 1e6))))
;-> (44 55 4444 4554 5445 5555 444444 445544
;->  454454 455554 544445 545545 554455 555555)
;-> 816.811

(define (pure6? num)
  (let (str (string num))
    (and (= str (reverse (copy str))) ; condizione 3
         (even? (length str))         ; condizione 1
         (regex "^(4|5)+$" str))))    ; condizione 2

(time (println (filter pure6? (sequence 1 1e6))))
;-> (44 55 4444 4554 5445 5555 444444 445544
;->  454454 455554 544445 545545 554455 555555)
;-> 806.77

Le funzioni più veloci sono la 3 e la 4 che hanno come prima condizione la "regex":

"^(4|5)+$"
  ^: asserisce l'inizio della stringa
  $: asserisce la fine della stringa.
  (4|5): corrisponde a 4 oppure 5
  +: garantisce che una o più occorrenze di 4 o 5 corrispondano.


---------------
Numeri di Kynea
---------------

I numeri di Kynea sono definiti dalla seguente espressione:

  K(n) = (2^n + 1)^2 - 2, con n intero non negativo.

Sequenza OEIS A093069:
  7, 23, 79, 287, 1087, 4223, 16639, 66047, 263167, 1050623, 4198399,
  16785407, 67125247, 268468223, 1073807359, 4295098367, 17180131327,
  68720001023, 274878955519, 1099513724927, 4398050705407, 17592194433023,
  70368760954879, 281475010265087, 1125899973951487, ...

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (kynea num) (- (** (+ (** 2 num) 1) 2) 2))

(map kynea (sequence 1 21))
;-> (7L 23L 79L 287L 1087L 4223L 16639L 66047L 263167L 1050623L 4198399L
;->  16785407L 67125247L 268468223L 1073807359L 4295098367L 17180131327L
;->  68720001023L 274878955519L 1099513724927L 4398050705407L)

(kynea 50)
;-> 1267650600228231653296516890623L


---------------------------------------------
Numeri di Mersenne e numeri primi di Mersenne
---------------------------------------------

In generale, un numero di Mersenne è della forma M(n) = 2^n - 1 anche quando n non è un numero primo.
Un numero primo di Mersenne è un numero primo nella forma M(p) = 2^p - 1, dove p è anche un numero primo.
Questi numeri prendono il nome da Marin Mersenne, un monaco francese del XVII secolo.

I numeri primi di Mersenne hanno sempre suscitato grande interesse tra i matematici a causa della loro rara presenza e della loro connessione con molte aree della matematica, tra cui la teoria dei numeri e la crittografia.
Nel 2023 si conoscono solo 51 numeri primi di Mersenne, il più grande dei quali ha oltre 24 milioni di cifre.
https://www.mersenne.org/

Uno dei motivi per cui i numeri primi di Mersenne sono così interessanti è che sono strettamente correlati ai numeri perfetti.
Un numero perfetto è un intero positivo uguale alla somma dei suoi divisori propri (cioè tutti i suoi divisori tranne se stesso).
Risulta che ogni numero perfetto pari può essere espresso come 2^(p-1)(2^p-1), dove 2^p-1 è un primo di Mersenne.
Tuttavia, è ancora una questione aperta se esistano numeri perfetti dispari.

Sequenza OEIS A001348:
  3, 7, 31, 127, 2047, 8191, 131071, 524287, 8388607, 536870911, 2147483647,
  137438953471, 2199023255551, 8796093022207, 140737488355327,
  9007199254740991, 576460752303423487, 2305843009213693951,
  147573952589676412927, 2361183241434822606847, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Funzione che calcola i numeri di Mersenne:

(define (mersenne num) (- (** 2 num) 1))

(map mersenne (sequence 1 20))
;-> (1L 3L 7L 15L 31L 63L 127L 255L 511L 1023L 2047L 4095L 8191L 16383L
;->  32767L 65535L 131071L 262143L 524287L 1048575L)

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

Funzione che calcola i numeri primi di Mersenne:

(define (mersenne-primi num) (map (fn(x) (- (** 2 x) 1)) (primes-to num)))

(mersenne-primi 100)
;-> (3L 7L 31L 127L 2047L 8191L 131071L 524287L 8388607L 536870911L 2147483647L
;->  137438953471L 2199023255551L 8796093022207L 140737488355327L
;->  9007199254740991L 576460752303423487L 2305843009213693951L
;->  147573952589676412927L 2361183241434822606847L 9444732965739290427391L
;->  604462909807314587353087L 9671406556917033397649407L
;->  618970019642690137449562111L 158456325028528675187087900671L)


----------------
Numeri di Fermat
----------------

I numeri di Fermat sono una sequenza di numeri della forma 2^(2^n) + 1, dove n è un numero intero non negativo.
Prendono il nome dal matematico francese Pierre de Fermat che li studiò nel XVII secolo.

I primi numeri di Fermat sono:

 F(0) = 2^(2^0) + 1 = 3
 F(1) = 2^(2^1) + 1 = 5
 F(2) = 2^(2^2) + 1 = 17
 F(3) = 2^(2^3) + 1 = 257
 F(4) = 2^(2^4) + 1 = 65537
 F(5) = 2^(2^5) + 1 = 4294967297

I numeri di Fermat hanno molte proprietà interessanti e collegamenti con altre aree della matematica.
Uno dei più famosi è il Piccolo Teorema di Fermat, il quale afferma che se p è un numero primo, allora per ogni intero a non divisibile per p, a^(p-1) - 1 è divisibile per p.
Questo teorema può essere usato per dimostrare che se n è un intero non negativo e 2^(2^n) + 1 è primo, allora n deve essere una potenza di 2.

Tuttavia non tutti i numeri di Fermat sono primi.
Infatti, F(5) è composto.
Si ipotizza che esistano infiniti numeri primi di Fermat, ma ciò non è stato dimostrato.

Sequenza OEIS A000215:
  3, 5, 17, 257, 65537, 4294967297, 18446744073709551617,
  340282366920938463463374607431768211457,
  115792089237316195423570985008687907853
  269984665640564039457584007913129639937, ...

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Funzione che calcola l'n-esimo numero di Fermat:

(define (fermat num) (+ (** 2 (** 2 num)) 1))

(map fermat (sequence 1 5))
;-> (5L 17L 257L 65537L 4294967297L)

(factor (fermat 5))
;-> (641 6700417)

(fermat 10)
;-> 1797693134862315907729305190789024733617976978942306572734300811577326
;-> 7580550096313270847732240753602112011387987139335765878976881441662249
;-> 2847430639474124377767893424865485276302219601246094119453082952085005
;-> 7688381506823424628814739131105408272371633505106845862982399472459384
;-> 79716304835356329624224137217L


---------------------------
Numeri misteriosi (mystery)
---------------------------

Un numero misterioso è un numero che può essere espresso come la somma di due numeri che devono essere l'uno l'inverso dell'altro.
In forma algebrica:

  M = a + b, con a = (d1..dn) = (dn..d1) = b
  dove d1..dn sono le cifre dei numeri a e b.

Per esempio:
33 è misterioso perchè 33 = 21 + 12 e i numeri sono uno l'inverso dell'altro.
110 è misterioso perchè 110 = 28 + 82 e i numeri sono uno l'inverso dell'altro.

Algoritmo
Ciclo per a da 1 n/2
  b = inverso di a
  se n = (+ a b), allora il numero n è misterioso

Funzione che verifica se un numero dato è misterioso:

(define (mystery? num)
  (let ( (b 0) (found nil) )
    (for (a 1 (/ num 2) 1 found)
      (setq b (int (reverse (string a)) 0 10))
      ;(print a { } b) (read-line)
      (if (= num (+ a b)) (setq found (list num a b)))
    )
    found))

Proviamo:

(mystery? 66)
;-> (66 15 51)
(mystery 21)
;-> ()

(filter true? (map mystery? (sequence 1 200)))
;-> ((2 1 1) (4 2 2) (6 3 3) (8 4 4) (10 5 5) (12 6 6) (14 7 7) (16 8 8)
;->  (18 9 9) (22 11 11) (33 12 21) (44 13 31) (55 14 41) (66 15 51)
;->  (77 16 61) (88 17 71) (99 18 81) (110 19 91) (121 29 92) (132 39 93)
;->  (143 49 94) (154 59 95) (165 69 96) (176 79 97) (187 89 98) (198 99 99))

(map first (filter true? (map mystery? (sequence 1 200))))
;-> (2 4 6 8 10 12 14 16 18 22 33 44 55 66 77
;-> 88 99 110 121 132 143 154 165 176 187 198)

Comunque alcuni numeri hanno soluzioni multiple, per esempio:

  110 = 55 + 55 = 46 + 64 = 37 + 73 = 28 + 82 = 19 + 91

(define (mystery-all? num)
  (let ( (b 0) (out '()) )
    (for (a 1 (/ num 2) 1 found)
      (setq b (int (reverse (string a)) 0 10))
      ;(print a { } b) (read-line)
      (if (= num (+ a b)) (push (list a b) out))
    )
    (if (not (null? out))
        (push num out)
        '())))

(mystery-all? 110)
;-> (110 (55 55) (46 64) (37 73) (28 82) (19 91))
(mystery-all? 21)
;-> ()

(filter true? (map mystery-all? (sequence 1 200)))
;-> ((2 (1 1)) (4 (2 2)) (6 (3 3)) (8 (4 4)) (10 (5 5))
;->  (12 (6 6)) (14 (7 7)) (16 (8 8)) (18 (9 9))
;->  (22 (11 11))
;->  (33 (12 21))
;->  (44 (22 22) (13 31))
;->  (55 (23 32) (14 41))
;->  (66 (33 33) (24 42) (15 51))
;->  (77 (34 43) (25 52) (16 61))
;->  (88 (44 44) (35 53) (26 62) (17 71))
;->  (99 (45 54) (36 63) (27 72) (18 81))
;->  (110 (55 55) (46 64) (37 73) (28 82) (19 91))
;->  (121 (56 65) (47 74) (38 83) (29 92))
;->  (132 (66 66) (57 75) (48 84) (39 93))
;->  (143 (67 76) (58 85) (49 94))
;->  (154 (77 77) (68 86) (59 95))
;->  (165 (78 87) (69 96))
;->  (176 (88 88) (79 97))
;->  (187 (89 98))
;->  (198 (99 99)))

Calcoliamo il numero di modi in cui un numero misterioso può esserlo:

(define (mystery-count? num)
  (local (conta b)
    (setq conta 0)
    (for (a 1 (/ num 2))
      (setq b (int (reverse (string a)) 0 10))
      ;(print a { } b) (read-line)
      (if (= num (+ a b)) (++ conta))
    )
    (if (not (zero? conta)) (list num conta) '())))

(mystery-count? 110)
;-> (110 5)
(mystery-count? 21)
;-> '()

(filter true? (map mystery-count? (sequence 1 200)))
;-> ((2 1) (4 1) (6 1) (8 1) (10 1) (12 1) (14 1) (16 1) (18 1) (22 1) (33 1)
;->  (44 2) (55 2) (66 3) (77 3) (88 4) (99 4) (110 5) (121 4) (132 4) (143 3)
;->  (154 3) (165 2) (176 2) (187 1) (198 1))

(define (mystery-count-max limit)
  (local (max-count max-value)
    (setq max-value 0)
    (setq max-count 0)
    (for (num 1 limit)
      (setq m (mystery-count? num))
      (if (not (null? m))
          (if (> (m 1) max-count) (set 'max-value (m 0) 'max-count (m 1))))
    )
    (list max-value max-count)))

(mystery-count-max 1e3)
;-> (110 5)

(time (println (mystery-count-max 1e4)))
;-> (9999 40)
;-> 12747.692

(mystery-all? 9999)
;-> (9999 (4905 5094) (4815 5184) (4725 5274) (4635 5364) (4545 5454)
;->  (4455 5544) (4365 5634) (4275 5724) (4185 5814) (4095 5904) (3906 6093)
;->  (3816 6183) (3726 6273) (3636 6363) (3546 6453) (3456 6543) (3366 6633)
;->  (3276 6723) (3186 6813) (3096 6903) (2907 7092) (2817 7182) (2727 7272)
;->  (2637 7362) (2547 7452) (2457 7542) (2367 7632) (2277 7722) (2187 7812)
;->  (2097 7902) (1908 8091) (1818 8181) (1728 8271) (1638 8361) (1548 8451)
;->  (1458 8541) (1368 8631) (1278 8721) (1188 8811) (1098 8901))

Comunque queste funzioni sono molto lente O(n^2):

(time (println (mystery-count-max 1e5)))
;-> (11000 45)
;-> 1335498.278 ; 22m 15s 498ms

Nota: abbiamo considerato i numeri "d0" diversi da "0d" (per esempio, 40 è diverso da 04)

Se vogliamo trovare tutti i numeri misteriosi che sono composti da numeri di una determinata lunghezza basta utilizzare un ciclo "for":
Per esempio, supponiamo di voler trovare tutti i numeri misteriosi composti da numeri di 3 cifre.

(define (mysteryN digit)
  (local (out a b)
    (setq out '())
    (for (a (pow 10 (- digit 1)) (- (pow 10 digit) 1))
      (setq b (int (reverse (string a)) 0 10))
      (if (= (length a) (length b)) (push (list (+ a b) a b) out -1))
    )
    out))

Per esempio, supponiamo di voler trovare tutti i numeri misteriosi composti da numeri di 2 cifre:

(mysteryN 2)
;-> ((22 11 11) (33 12 21) (44 13 31) (55 14 41) (66 15 51) (77 16 61)
;->  (88 17 71) (99 18 81) (110 19 91) (33 21 12) (44 22 22) (55 23 32)
;-> ...
;->  (165 87 78) (176 88 88) (187 89 98) (110 91 19) (121 92 29) (132 93 39)
;->  (143 94 49) (154 95 59) (165 96 69) (176 97 79) (187 98 89) (198 99 99))

(length (mysteryN 3))
;-> 810

Con questa funzione possiamo calcolare tutti i numeri misteriosi fino a un dato numero.
Per esempio, quanti sono i numeri misteriosi fino a 10000 (potenza di 10):

(setq m 0)
(for (i 1 4) (++ m (length (mysteryN i))))
;-> 9000


-------------------------------
Numeri primi contorti (twisted)
-------------------------------

Un numero primo contorto è un numero primo che rimane primo quando alcune delle sue cifre vengono scambiate.
Ad esempio, il numero 113 è un numero primo contorto perché se scambiamo la prima e l'ultima cifra, otteniamo 311, che è un numero primo diverso.
Ad esempio, il numero 11 è primo, ma se ne scambiamo le cifre, otteniamo comunque 11, che non è un numero primo diverso.

Esistono infiniti numeri primi contorti, ma diventano sempre più rari all'aumentare dei numeri primi.

Sequenza OEIS A225035:
Primes such that there is a nontrivial rearrangement of the digits which is a prime.
  13, 17, 31, 37, 71, 73, 79, 97, 101, 103, 107, 109, 113, 127, 131, 137,
  139, 149, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 239, 241,
  251, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349,
  359, 367, 373, 379, 389, 397, 401, 419, 421, ...

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

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (twisted? num show)
  (local (twisted permute primo)
    (cond ((prime? num)
        (setq twisted nil)
        (setq permute (map (fn(x) (int (join x) 0 10))
                           (perm (explode (string num)))))
         (dolist (p permute twisted)
          (if (and (!= num p) (prime? p)) (set 'twisted true 'primo p))
        )
        (if (and twisted show) (println (list num primo))))
    )
    twisted))

Proviamo:

(twisted? 113)
;-> true
(twisted? 113 true)
;-> (113 311)
;-> true

(filter twisted? (sequence 1 500))
;-> (13 17 31 37 71 73 79 97 101 103 107 109 113 127 131 137 139 149 157
;->  163 167 173 179 181 191 193 197 199 239 241 251 271 277 281 283 293
;->  307 311 313 317 331 337 347 349 359 367 373 379 389 397 401 419 421
;->  439 457 461 463 467 479 491)


------------------------------------------------------------
Numero successivo e precedente con cifre distinte dal numero
------------------------------------------------------------

Dato un numero intero N, trovare il numero successivo e precedente che ha cifre tutte distinte da quelle del numero dato.

(setq MAX-INT 9223372036854775807)
(define (next-distinct num)
  (local (base totale distinte continua out)
    (setq base (explode (string num)))
    (setq continua true)
    (while (and (< num MAX-INT) continua)
      (if (null? (intersect base (explode (string (+ num 1)))))
          (set 'out (+ num 1) 'continua nil)
          ;else
          (++ num)
      )
    )
    out))

Proviamo:

(next-distinct 1)
;-> 2
(next-distinct 10)
;-> 22
(next-distinct 1234)
;-> 5000
(next-distinct 2023)
;-> 4111
(next-distinct 1456789)

Funzione che trova il numero precedente con cifre tutte distinte:

(setq MIN-INT -9223372036854775808)
(define (previous-distinct num)
  (local (base totale distinte continua out)
    (setq base (explode (string num)))
    (setq continua true)
    (while (and (> num MIN-INT) continua)
      (if (null? (intersect base (explode (string (- num 1)))))
          (set 'out (- num 1) 'continua nil)
          ;else
          (-- num)
      )
    )
    out))

Proviamo:

(previous-distinct 1)
;-> 0
(previous-distinct 10)
;-> 9
(previous-distinct 1234)
;-> 999
(previous-distinct 2023)
;-> 1999
(previous-distinct 22)
;-> 19

Nota: se passiamo un numero con tutte le cifre (0..9), le funzioni arrivano a MAX-INT e MIN-INT.


-------------------------------
Putnam mathematical competition
-------------------------------

Da "The 69th William Lowell Putnam Mathematical Competition" Saturday, December 6, 2008
https://kskedlaya.org/putnam-archive/2008.pdf

Problema A3
-----------
"Iniziare con una sequenza finita a1,a2,...,an di interi positivi.
Se possibile, scegliere due indici j < k tali che a(j) non divida a(k), e sostituisci a(j) e a(k) rispettivamente con gcd(a(j),a(k)) e lcm(a(j),a(k)).
Dimostrare che se questo processo si ripete, prima o poi si fermerà e la sequenza finale non dipende dalle scelte effettuate.
(Nota: "gcd" greatest common divisor (massimo comun divisore) e "lcm" least common multiple (minimo comune multiplo.)"

Scrivere una funzione che effettua il processo descritto per verificare l'assunto del problema.

Dal punto di vista matematico risulta che il k-esimo elemento del risultato è il GCD degli LCM di tutti i sottoinsiemi con k elementi:

  el(k) = gcd( (lcm(ai1,...,aik) | 1 <= i1 <...< ik <= n) )

(define (comb k lst (r '()))
"Generates all combinations of k elements without repetition from a list of items"
  (if (= (length r) k)
    (list r)
    (let (rlst '())
      (dolist (x lst)
        (extend rlst (comb k ((+ 1 $idx) lst) (append r (list x)))))
      rlst)))

(define (lcm_ a b) (/ (* a b) (gcd a b)))
(define-macro (lcm)
"Calculates the lcm of two or more number"
  (apply lcm_ (args) 2))

Esempio:
(setq a '(3 6 21 77 42 36))

elemento 1:
(apply gcd a)
;-> 1

elemento 2:
(apply gcd (map (fn(x) (apply lcm x)) (comb 2 a)))
;-> 3

elemento 3:
(apply gcd (map (fn(x) (apply lcm x)) (comb 3 a)))
;-> 3

elemento 4:
(apply gcd (map (fn(x) (apply lcm x)) (comb 4 a)))
;-> 42

elemento 5:
(apply gcd (map (fn(x) (apply lcm x)) (comb 5 a)))
;-> 42

elemento 6:
(apply gcd (map (fn(x) (apply lcm x)) (comb 6 a)))
;-> 2773

Funzione che calcola la sequenza finale:

(define (math lst)
  (local (len out)
    (setq len (length lst))
    (setq out (list (apply gcd lst)))
    (for (i 2 len)
      (push (apply gcd (map (fn(x) (apply lcm x)) (comb i lst))) out -1)
    )
    out))

(math a)
;-> (1 3 3 42 42 2772)

Funzione che calcola la sequenza finale (senza "for"):

(define (math lst)
  (let (out (list (apply gcd lst)))
    (extend out
        (map (fn(z) (apply gcd (map (fn(x) (apply lcm x)) (comb z lst))))
             (sequence 2 (length lst))))))

Facciamo alcune prove:

(math a)
;-> (1 3 3 42 42 2772)

(math '(1 2 4 8 16 32))
;-> (1 2 4 8 16 32)

(math '(120 24 6 2 1 1))
;-> (1 1 2 6 24 120)

(math '(97 41 48 12 98 68))
;-> (1 1 2 4 12 159016368)

(math '(225 36 30 1125 36 18 180))
;-> (3 9 18 90 180 900 4500)

(math '(17 17 17 17))
;-> (17 17 17 17)

(math '(1 2 3 4 5 6 7 8 9 10))
;-> (1 1 1 1 1 2 2 6 60 2520)


---------------------------------
Contatore con simboli predefiniti
---------------------------------

Scrivere una funzione data una stringa di simboli genera una sequenza di simboli ordinati fino ad un dato numero di simboli.
Per esempio:

stringa di simboli = "ABC"

Simboli ordinati = 1
Output = A B C

Simboli ordinati = 2
Output = AA AB AC BA BB BC CA CB CC

Simboli ordinati = 3
Output = AAA AAB AAC ABA ABB ABC ACA ACB ACC BAA BAB BAC BBA BBB
         BBC BCA BCB BCC CAA CAB CAC CBA CBB CBC CCA CCB CCC

Simboli ordinati = 4
Output = AAAA AAAB AAAC AABA AABB AABC ... CCBB CCBC CCCA CCCB CCCC

Per generare in ordine i simboli/caratteri utilizziamo una lista di posizioni con un ciclo che incrementare progressivamente le posizioni.

(define (genera simboli num)
  (local (out len posizioni break numero pos)
    (setq out '())
    (setq len (length simboli))
    ; Creazione di un array con num zeri
    (setq posizioni (array num '(0)))
    (setq break nil)
    (until break
      ; Creazione del numero corrente
      (setq numero "")
      ; Con questo ciclo abbiamo a disposizione i simboli/caratteri
      ; per costruire il valore corrente
      (dolist (i posizioni) (extend numero (simboli i)))
      ;(println numero)
      (push numero out -1)
      ; Incrementa le posizioni dall'ultima
      (setq pos (- num 1))
      (while (and (>= pos 0) (= (posizioni pos) (- len 1)))
        (setf (posizioni pos) 0)
        (-- pos)
      )
      ; Se tutte le posizioni sono arrivate alla fine, esce
      (if (< pos 0)
          (setq break true)
          ;else
          ; Altrimenti, incrementa la posizione corrente
          (++ (posizioni pos))
      )
    )
    out))

Proviamo a generare qualche sequenza ordinata:

(genera "0123456789" 2)
;-> ("00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13"
;->  "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27"
;->  "28" "29" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "40" "41"
;->  "42" "43" "44" "45" "46" "47" "48" "49" "50" "51" "52" "53" "54" "55"
;->  "56" "57" "58" "59" "60" "61" "62" "63" "64" "65" "66" "67" "68" "69"
;->  "70" "71" "72" "73" "74" "75" "76" "77" "78" "79" "80" "81" "82" "83"
;->  "84" "85" "86" "87" "88" "89" "90" "91" "92" "93" "94" "95" "96" "97"
;->  "98" "99")

(genera "ABC" 3)
;-> ("AAA" "AAB" "AAC" "ABA" "ABB" "ABC" "ACA" "ACB" "ACC" "BAA" "BAB" "BAC"
;->  "BBA" "BBB" "BBC" "BCA" "BCB" "BCC" "CAA" "CAB" "CAC" "CBA" "CBB" "CBC"
;->  "CCA" "CCB" "CCC")

Numeri binari:

(genera "01" 4)
;-> ("0000" "0001" "0010" "0011" "0100" "0101" "0110" "0111" "1000" "1001"
;->  "1010" "1011" "1100" "1101" "1110" "1111")

Numeri esadecimali:

(genera "0123456789ABCDEF" 2)
;-> ("00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "0A" "0B" "0C" "0D"
;->  "0E" "0F" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "1A" "1B"
;->  "1C" "1D" "1E" "1F" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29"
;->  "2A" "2B" "2C" "2D" "2E" "2F" "30" "31" "32" "33" "34" "35" "36" "37"
;->  "38" "39" "3A" "3B" "3C" "3D" "3E" "3F" "40" "41" "42" "43" "44" "45"
;->  "46" "47" "48" "49" "4A" "4B" "4C" "4D" "4E" "4F" "50" "51" "52" "53"
;->  "54" "55" "56" "57" "58" "59" "5A" "5B" "5C" "5D" "5E" "5F" "60" "61"
;->  "62" "63" "64" "65" "66" "67" "68" "69" "6A" "6B" "6C" "6D" "6E" "6F"
;->  "70" "71" "72" "73" "74" "75" "76" "77" "78" "79" "7A" "7B" "7C" "7D"
;->  "7E" "7F" "80" "81" "82" "83" "84" "85" "86" "87" "88" "89" "8A" "8B"
;->  "8C" "8D" "8E" "8F" "90" "91" "92" "93" "94" "95" "96" "97" "98" "99"
;->  "9A" "9B" "9C" "9D" "9E" "9F" "A0" "A1" "A2" "A3" "A4" "A5" "A6" "A7"
;->  "A8" "A9" "AA" "AB" "AC" "AD" "AE" "AF" "B0" "B1" "B2" "B3" "B4" "B5"
;->  "B6" "B7" "B8" "B9" "BA" "BB" "BC" "BD" "BE" "BF" "C0" "C1" "C2" "C3"
;->  "C4" "C5" "C6" "C7" "C8" "C9" "CA" "CB" "CC" "CD" "CE" "CF" "D0" "D1"
;->  "D2" "D3" "D4" "D5" "D6" "D7" "D8" "D9" "DA" "DB" "DC" "DD" "DE" "DF"
;->  "E0" "E1" "E2" "E3" "E4" "E5" "E6" "E7" "E8" "E9" "EA" "EB" "EC" "ED"
;->  "EE" "EF" "F0" "F1" "F2" "F3" "F4" "F5" "F6" "F7" "F8" "F9" "FA" "FB"
;->  "FC" "FD" "FE" "FF")

Vedi anche "Contatore universale" in "Note libere 16".


---------------------
Numeri Tech (tecnici)
---------------------

Un numero Tech è un numero in cui la somma della prima metà e della seconda metà delle cifre, elevata al quadrato, produce come risultato il numero stesso.
Un numero Tech ha un numero di cifre pari.
Esempi:
  81 = ((8) + (1))^2 = 9^2 = 81   -->  Numero Tech
  24 = ((2) + (4))^2 = 6^2 = 36   -->  Numero non Tech
  134 --> numero di cifre dispari -->  Numero non Tech

Sequenza OEIS A238237:
  81, 2025, 3025, 9801, 494209, 998001, 24502500, 25502500, 52881984,
  60481729, 99980001, 6049417284, 6832014336, 9048004641, 9999800001,
  101558217124, 108878221089, 123448227904, 127194229449, 152344237969,
  213018248521, 217930248900, 249500250000, 250500250000, ...

(define (tech? num)
  (local (str len a b)
    (setq str (string num))
    (setq len (length num))
    (cond ((odd? len) nil)
          (true
            ; parte sinistra del numero
            (setq a (int (slice str 0 (/ len 2)) 0 10))
            ; parte destra del numero
            (setq b (int (slice str (/ len 2)) 0 10))
            (= num (* (+ a b) (+ a b)))))))

Proviamo:

(tech? 81)
;-> true
(tech? 24)
;-> nil
(tech? 134)
;-> nil

(filter tech? (sequence 1 1e5))
;-> (81 2025 3025 9801)

(time (println (filter tech? (sequence 1 1e6))))
;-> (81 2025 3025 9801 494209 998001)
;-> 1610.413

ALtro metodo (senza convertire il numero in stringa):

(define (tech?? num)
  (local (len a b)
    (setq len (length num))
    (cond ((odd? len) nil)
          (true
            ; parte sinistra del numero
            (setq a (/ num (pow 10 (/ len 2))))
            ; parte destra del numero
            (setq b (% num (pow 10 (/ len 2))))
            (= num (* (+ a b) (+ a b)))))))

Proviamo:

(tech?? 81)
;-> true
(tech?? 24)
;-> nil
(tech?? 134)
;-> nil

(filter tech?? (sequence 1 1e5))
;-> (81 2025 3025 9801)

(time (println (filter tech?? (sequence 1 1e6))))
;-> (81 2025 3025 9801 494209 998001)
;-> 962.25

(time (println (filter tech?? (sequence 1 1e8))))
;-> (81 2025 3025 9801 494209 998001 24502500
;->  25502500 52881984 60481729 99980001)
;-> 95893.062


-------------------------
Numeri insoliti (unusual)
-------------------------

Un numero insolito è definito come un numero per il quale il fattore primo più grande è maggiore della radice quadrata del numero.

Sequenza OEIS A064052:
  2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 20, 21, 22, 23, 26, 28, 29,
  31, 33, 34, 35, 37, 38, 39, 41, 42, 43, 44, 46, 47, 51, 52, 53, 55, 57,
  58, 59, 61, 62, 65, 66, 67, 68, 69, 71, 73, 74, 76, 77, 78, 79, 82, 83,
  85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 97, 99, 101, 102, ...

(define (unusual? num) (> (last (factor num)) (sqrt num)))

Proviamo:

(filter unusual? (sequence 2 102))
;-> (2 3 5 6 7 10 11 13 14 15 17 19 20 21 22 23 26 28 29
;->  31 33 34 35 37 38 39 41 42 43 44 46 47 51 52 53 55 57
;->  58 59 61 62 65 66 67 68 69 71 73 74 76 77 78 79 82 83
;->  85 86 87 88 89 91 92 93 94 95 97 99 101 102)


----------------------------------
Numeri Bleak (spogli) o Colombiani
----------------------------------

Un numero Bleak è un numero intero positivo N che non può essere rappresentato come la somma di qualsiasi numero intero positivo K e il conteggio dei bit attivi (1) di K.

Notiamo che il numero di bit a 1 in qualunque numero inferiore a N non può superare log2(N).
Quindi dobbiamo controllare solo i numeri dall'intervallo (N – ceil(log2(N))) a N.

In altre parole, se K + bit1(K) diventa N, allora N non può essere Bleak.

Sequenza OEIS A010061:
  1, 4, 6, 13, 15, 18, 21, 23, 30, 32, 37, 39, 46, 48, 51, 54, 56, 63, 71,
  78, 80, 83, 86, 88, 95, 97, 102, 104, 111, 113, 116, 119, 121, 128, 130,
  133, 135, 142, 144, 147, 150, 152, 159, 161, 166, 168, 175, 177, 180,
  183, 185, 192, 200, 207, 209, 212, 215, ...

(define (bleak? num)
  (let (stop nil)
    (for (k (- num (ceil (log num 2))) num 1 stop)
      (if (= (+ k (first (count '("1") (explode (bits k))))) num)
          (setq stop true)
      )
    )
    (not stop)))

Proviamo:

(filter bleak? (sequence 1 200))
;-> (1 4 6 13 15 18 21 23 30 32 37 39 46 48 51 54 56 63 71
;->  78 80 83 86 88 95 97 102 104 111 113 116 119 121 128 130
;->  133 135 142 144 147 150 152 159 161 166 168 175 177 180
;->  183 185 192 200)


-------------------------------
Numeri Triperfetti (Triperfect)
-------------------------------

Un intero positivo N si dice Triperfetto se la somma dei suoi divisori propri (escluso N stesso) è uguale a tre volte il numero N.
In altre parole, se la somma dei divisori di N (escluso N) è uguale a 3 volte N, allora N è un numero triperfetto.

Sequenza OEIS: A005820
  120, 672, 523776, 459818240, 1476304896, 51001180160, ...

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn (fattori (factor num)
          unici (unique fattori))
      (transpose (list unici (count unici fattori))))))

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

(define (triperfect? num) (= (/ (divisors-sum num) 3) num))

Proviamo:

(triperfect? 120)
;-> true

(triperfect? 567)
;-> nil

(time (println (filter triperfect? (sequence 2 1e6))))
;-> (120 672 523776)
;-> 3500.36

(map triperfect? '(459818240 1476304896 51001180160))
;-> (true true true)


-----------------------------
Numeri Progressivi (Stepping)
-----------------------------

Un numero Stepping (progressivo) è un numero in cui le cifre adiacenti hanno una differenza di 1.
Esempi:
234 è un numero Stepping poiché |2-3|=1 e |3-4|=1.
346 non è un numero Stepping poiché |3-4|=1, ma |4-6|=2.

Sequenza OEIS A033075:
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 21, 23, 32, 34, 43, 45, 54, 56, 65,
  67, 76, 78, 87, 89, 98, 101, 121, 123, 210, 212, 232, 234, 321, 323,
  343, 345, 432, 434, 454, 456, 543, 545, 565, 567, 654, 656, 676, 678,
  765, 767, 787, 789, 876, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (pair-func lst func rev)
"Produces a list applying a function to each pair of elements of a list"
      (if rev
          (map func (chop lst) (rest lst))
          (map func (rest lst) (chop lst))))

(pair-func '(1 2 3 4 5 6 8) -)
;-> (1 1 1 1 1 2)
(pair-func '(8 6 5 4 3 2 1) -)
;-> (-2 -1 -1 -1 -1 -1)

(define (stepping? num)
  (letn ( (lst (int-list num))
          (pair-diff (map (fn(x y) (abs (- x y))) (chop lst) (rest lst))) )
    (for-all (fn(x) (= x 1)) pair-diff)))

Proviamo:

(stepping? 234)
;-> true
(stepping? 346)
;-> nil

(filter stepping? (sequence 1 250))
;-> (1 2 3 4 5 6 7 8 9 10 12 21 23 32 34 43 45 54 56 65
;->  67 76 78 87 89 98 101 121 123 210 212 232 234)

Vedi anche "Numeri estetici" in "Note libere 10".


-----------
Numeri Duck
-----------

Un numero Duck è un numero positivo che contiene zeri.
Ad esempio 1203, 89800, 12340 sono tutti numeri Duck.
Nota che i numeri con solo 0 iniziali non sono considerati numeri Duck.
Ad esempio, numeri come 012 o 0021 non sono considerati numeri Duck.

Sequenza OEIS A011540:
  0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 101, 102, 103, 104, 105,
  106, 107, 108, 109, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200,
  201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 220, 230, 240, 250,
  260, 270, 280, 290, 300, 301, 302, ...

(define (duck? num)
  (let (str (string num))
    (cond ((= "0" (str 0)) nil)
          ((find "0" str) true)
          (true nil))))

Proviamo:

(duck? "0200")
;-> nil
(duck? "123405")
;-> true

(filter duck? (sequence 123 456))
;-> (130 140 150 160 170 180 190 200 201 202 203 204 205 206 207 208 209 210
;->  220 230 240 250 260 270 280 290 300 301 302 303 304 305 306 307 308 309
;->  310 320 330 340 350 360 370 380 390 400 401 402 403 404 405 406 407 408
;->  409 410 420 430 440 450)


----------------------------------------------------
Numeri Flavio Giuseppe (Setaccio di Flavio Giuseppe)
----------------------------------------------------

I numeri nel Setaccio di Flavio sono chiamati Numeri di Flavio.
Il setaccio di Flavio inizia con i numeri naturali e continua a ripetere il passaggio seguente:
Al k-esimo passo di setacciatura, rimuovi ogni (k+1)-esimo termine della sequenza rimanente di N numeri naturali dopo il (k-1)-esimo passo di setacciatura.

In altre parole, dato un numero N effettuare i seguenti passi:

Iniziare con:
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 .... N e cancellare ogni 2 termini, che risulta
1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 ... N e cancellare ogni 3 termini, che risulta
1 3 7 9 13 15 19 21 25 27 ................. N e cancellare ogni 4 termini, che risulta
1 3 7 13 15 19 25 27 ...................... N e cancellare ogni 5 termini, che risulta
...
Continuare fino a eliminare ogni N termini e ciò che rimane è la sequenza.

Sequenza OEIS A000960:
Flavius Josephus's sieve:
1) Start with the natural numbers;
2) at the k-th sieving step, remove every (k+1)-st term of the sequence remaining after the (k-1)-st sieving step
3) iterate.
  1, 3, 7, 13, 19, 27, 39, 49, 63, 79, 91, 109, 133, 147, 181, 207, 223,
  253, 289, 307, 349, 387, 399, 459, 481, 529, 567, 613, 649, 709, 763,
  807, 843, 927, 949, 1009, 1093, 1111, 1189, 1261, 1321, 1359, 1471,
  1483, 1579, 1693, 1719, 1807, 1899, 1933, 2023, ...

Il setaccio di Flavio Giuseppe Flavio:
1) iniziare con i numeri naturali,
2) alla k-esima fase di setacciatura, rimuovere ogni (k-1)-esimo termine della sequenza rimanente dopo la (k-1)-esima fase di setacciatura
3) ripetere.

Funzione che rimuove gli elementi di una lista in posizione k e multipli di k:

(define (remove-k lst k)
  (let (out '())
    (dolist (el lst) (if (!= (% (+ $idx 1) k) 0) (push el out -1)))
    out))

Funzione che verifica se un numero è di Flavio Giuseppe:

(define (flavio? num show)
  (if (= num 1)
      true
      (let (seq (sequence 1 num))
        (for (i 2 num)
          (setq seq (remove-k seq i))
        )
        (if show (println (unique (sort seq))))
        (if (ref num seq) true nil))))

Proviamo:

(flavio? 20 true)
;-> (1 3 7 13 19)
;-> nil

(filter flavio? (sequence 1 1000))
;-> (1 3 7 13 19 27 39 49 63 79 91 109 133 147 181 207 223
;->  253 289 307 349 387 399 459 481 529 567 613 649 709 763
;->  807 843 927 949)

Vedi anche "Il problema di Giuseppe (Josephus Problem)" in "Rosetta Code".


------------------------------
Coppie di fattori di un numero
------------------------------

Una coppia di fattori di un numero N è composta da due numeri interi positivi 'a' e 'b', tali che a * b = N.
In altre parole, sia 'a' che 'b' sono divisori di N e, se moltiplicati insieme, danno il numero originale.

Scrivere una funzione che trova tutte le coppie di fattori per un dato numero N.

(define (factor-pairs1 num)
  (if (= num 1) '(1 1)
      (let (out '())
        (for (i 1 (/ num 2))
          (if (zero? (% num i))
              (push (list i (/ num i)) out -1)
          )
        )
        (push (list num 1) out -1)
        out)))

Proviamo:

(factor-pairs1 1)
;-> (1 1)
(factor-pairs1 12)
;-> ((1 12) (2 6) (3 4) (4 3) (6 2) (12 1))
(factor-pairs1 36)
;-> ((1 36) (2 18) (3 12) (4 9) (6 6) (9 4) (12 3) (18 2) (36 1))
(factor-pairs1 760)
;-> ((1 760) (2 380) (4 190) (5 152) (8 95) (10 76) (19 40) (20 38)
;->  (38 20) (40 19) (76 10) (95 8) (152 5) (190 4) (380 2) (760 1))

Se vogliamo solo una coppia tra (a * b) e (b * a) possiamo inserire un controllo di uscita nel ciclo "for" (uscire dal ciclo quando (<= i (/ num i)):

(define (factor-pairs2 num)
  (if (= num 1) '(1 1)
      (let (out '())
        (for (i 1 (/ num 2) 1 (> i (/ num i)))
          (if (zero? (% num i))
              (push (list i (/ num i)) out -1)
          )
        )
        out)))

Proviamo:

(factor-pairs2 1)
;-> (1 1)
(factor-pairs2 12)
;-> ((1 12) (2 6) (3 4))
(factor-pairs2 36)
;-> ((1 36) (2 18) (3 12) (4 9) (6 6))
(factor-pairs2 760)
;-> ((1 760) (2 380) (4 190) (5 152) (8 95) (10 76) (19 40) (20 38))

Vediamo la velocità delle due funzioni:

(silent (setq t (sequence 1 10000)))
(time (map factor-pairs1 t))
;-> 1346.204
(time (map factor-pairs2 t)
;-> 84.026


-----------------------
Numeri polite (educati)
-----------------------

Un numero Educato è un numero intero positivo che può essere scritto come la somma di due o più numeri interi positivi consecutivi.
Un numero intero positivo che non è educato è detto Scortese.
I numeri Scortesi sono esattamente le potenze di due, mentre i numeri Educati sono i numeri naturali che non sono potenze di due.
Sulla base di questo fatto, esiste la seguente formula (teorema di Lambek-Moser) per l'N-esimo numero educato:

  E(N) = (N+1) + floor(log2((N+1) + log2(N+1)))

Sequenza OEIS A138591: Sums of two or more consecutive nonnegative integers
  1, 3, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 21, 22, 23, 24,
  25, 26, 27, 28, 29, 30, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43,
  44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
  62, 63, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, ...
In questa sequenza 1 = 0 + 1 viene considerato un numero educato.

Sequenza OEIS A057716: The nonpowers of 2
  0, 3, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 21, 22, 23, 24,
  25, 26, 27, 28, 29, 30, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43,
  44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
  62, 63, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, ...
In questa sequenza 1 = 0 + 1 non viene considerato un numero educato.

(define (polite N)
  (let (N (+ N 1))
    (+ N (floor (log (+ N (log N 2)) 2)))))

Proviamo:

(polite 0)
;-> 1
(polite 1)
;-> 3
(polite 7)
;-> 11

(map polite (sequence 0 50))
;-> (1 3 5 6 7 9 10 11 12 13 14 15 17 18 19 20 21 22 23 24 25 26 27 28 29 30
;->  31 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
;->  56)

Politeness (Cortesia)
La Cortesia di un numero positivo è definita come il numero di modi in cui può essere espresso come somma di numeri interi consecutivi.
Per ogni N, la Cortesia di N è uguale al numero di divisori dispari di N maggiori di uno.
Per esempio, la Cortesia di 15 è 3 perché ha tre divisori dispari, 3, 5 e 15, e tre rappresentazioni educate:

  15 = 4 + 5 + 6
  15 = 1 + 2 + 3 + 4 + 5
  15 = 7 + 8

Sequenza OEIS A069283:
  0, 0, 0, 1, 0, 1, 1, 1, 0, 2, 1, 1, 1, 1, 1, 3, 0, 1, 2, 1, 1, 3, 1, 1,
  1, 2, 1, 3, 1, 1, 3, 1, 0, 3, 1, 3, 2, 1, 1, 3, 1, 1, 3, 1, 1, 5, 1, 1,
  1, 2, 2, 3, 1, 1, 3, 3, 1, 3, 1, 1, 3, 1, 1, 5, 0, 3, 3, 1, 1, 3, 3, 1,
  2, 1, 1, 5, 1, 3, 3, 1, 1, 4, 1, 1, 3, 3, 1, 3, 1, 1, 5, 3, 1, 3, 1, 3,
  1, 1, 2, 5, 2, ...

Ecco un modo semplice per calcolare la Cortesia di un numero positivo:
1) scomporre il numero nei suoi fattori primi,
2) prendere le potenze di tutti i fattori primi maggiori di 2 (dispari)
3) sommare 1 ad ognuna potenza presa
4) moltiplicare tutti i numeri ottenuti e poi sommare 1

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn (fattori (factor num)
          unici (unique fattori))
      (transpose (list unici (count unici fattori))))))

(define (politeness num)
  (if (zero? num) 0
      (local (fg seq)
        ;scompone il numero in fattori primi
        (setq fg (factor-group num))
        (setq seq '())
        ; seleziona tutte le potenze maggiori di 2 e somma 1 ad ognuna
        ; mettendole in una lista
        (dolist (f fg)
          (if (> (f 0) 2) (push (+ (f 1) 1) seq))
        )
        ; moltiplica i numeri della lista e poi somma 1
        (- (apply * seq) 1))))

Proviamo:

(politeness 15)
;-> 3

(politeness 90)
;-> 5

(map politeness (sequence 0 100))
;-> (0 0 0 1 0 1 1 1 0 2 1 1 1 1 1 3 0 1 2 1 1 3 1 1
;->  1 2 1 3 1 1 3 1 0 3 1 3 2 1 1 3 1 1 3 1 1 5 1 1
;->  1 2 2 3 1 1 3 3 1 3 1 1 3 1 1 5 0 3 3 1 1 3 3 1
;->  2 1 1 5 1 3 3 1 1 4 1 1 3 3 1 3 1 1 5 3 1 3 1 3 1 1 2 5 2)

Per trovare la sequenza di interi positivi consecutivi che si somma a un dato numero gentile N, possiamo utilizzare il seguente algoritmo:

1. Inizializzazione
    - Sia N il numero per cui vogliamo trovare la sequenza (se esiste).
    - Inizializzare due puntatori, "inizio" e "fine", entrambi inizialmente puntano a 1.
    - Mantenere una variabile "SommaCorrente" per memorizzare la somma della sequenza tra "inizio" e "fine".

2. Iterare
    - Avviare un ciclo incrementando il puntatore "fine".
    - In ogni iterazione, aggiungere il valore "fine" corrente a "SommaCorrente".
    - Controllare se "SommaCorrente" è uguale a N:
      - Se uguale, abbiamo trovato la sequenza.
      - Se "SommaCorrente" è maggiore di N, incrementare "inizio" e aggiornare "SommaCorrente" di conseguenza.

3. Continuare l'iterazione
    - Continuare questo processo finché "inizio" non è maggiore di N/2.
    - A questo punto non ci sarà alcuna sequenza possibile.

(define (polite? num)
  (local (out inizio fine somma-corrente)
    (setq out '())
    (setq inizio 1)
    (setq fine 1)
    (setq somma-corrente 1)
    (while (<= inizio (/ num 2))
      (cond ((= somma-corrente num)
            (push (sequence inizio fine) out -1)
            ;(println (sequence inizio fine))
            (-- somma-corrente inizio)
            (++ inizio))
            ((< somma-corrente num)
              (++ fine)
              (++ somma-corrente fine))
            ((> somma-corrente num)
              (-- somma-corrente inizio)
              (++ inizio))
      )
    )
    out))

Proviamo:

(polite? 15)
;-> ((1 2 3 4 5) (4 5 6) (7 8))

(polite? 90)
;-> ((2 3 4 5 6 7 8 9 10 11 12 13)
;->  (6 7 8 9 10 11 12 13 14)
;->  (16 17 18 19 20)
;->  (21 22 23 24)
;->  (29 30 31))

(polite? 20)
;-> (3 4 5 6)

Supponiamo di voler generare tutte le possibili somme (con almeno due addendi) fino a un dato numero N.
Per esempio, con N = 3, vogliamo generare: 1+2, 1+2+3 e 2+3.
Per fare questo bastano due cicli "for" annidati:

(define (generate-all-sums N)
  (let (out '())
    (for (inizio 1 (- N 1))
      (for (fine (+ inizio 1) N)
        (push (sequence inizio fine) out -1)
        ;(println (sequence inizio fine))
      )
    )
    out))

Proviamo:

(generate-all-sums 5)
;-> ((1 2) (1 2 3) (1 2 3 4) (1 2 3 4 5)
;->  (2 3) (2 3 4) (2 3 4 5)
;->  (3 4) (3 4 5)
;->  (4 5))

(generate-all-sums 7)
;-> ((1 2) (1 2 3) (1 2 3 4) (1 2 3 4 5) (1 2 3 4 5 6) (1 2 3 4 5 6 7)
;->  (2 3) (2 3 4) (2 3 4 5) (2 3 4 5 6) (2 3 4 5 6 7)
;->  (3 4) (3 4 5) (3 4 5 6) (3 4 5 6 7)
;->  (4 5) (4 5 6) (4 5 6 7)
;->  (5 6) (5 6 7) (6 7))

(length (generate-all-sums 100))
;-> 4950

(length (generate-all-sums 1000))
;-> 499500


---------------
MS-DOS codepage
---------------

L'interprete dei comandi di Windows (CMD.exe) e quindi qualsiasi file batch DOS utilizzano una codepage diversa (437) rispetto ad altre applicazioni Windows (ad esempio Notepad/Blocco note).
Ciò potrebbe causare problemi con i caratteri speciali.

Per esempio supponiamo di avere una cartella con i file colò.html e galà.html.
Dal Command Prompt di una finestra DOS digitiamo:

dir /B /On > list.txt

Abbiamo creato il file list.txt con l'elenco dei file della cartella corrente.

Se apriamo il file list.txt con notepad di windows otteniamo il seguente risultato:

  col•.html
  gal….html
  list.txt

La soluzione è modificare la codepage all'inizio del file batch utilizzando il comando CHCP.

Dal Command Prompt di una finestra DOS digitiamo:

chcp
;-> Active code page: 437

Il codepage corrente è il 437.

Per modificare la codepage in 1252 (ANSI - Latin I), digitare:

chcp 1252

Adesso dal Command Prompt di una finestra DOS digitiamo:

dir /B /On > list2.txt

Adesso se apriamo il file list.txt con notepad di windows otteniamo il seguente risultato:

  colò.html
  galà.html
  list.txt
  list2.txt

Per ulteriori informazioni sul comando CHCP, digitare dal Command Prompt:

chcp /?

Dalla REPL di newLISP:

(exec "chcp /?")
("Displays or sets the active code page number."
 ""
 "CHCP [nnn]" "" "  nnn   Specifies a code page number."
 ""
 "Type CHCP without a parameter to display the active code page number.")

Vediamo una tabella con i valori numerici di alcuni codepage

  437 - United States ("PC-ASCII")
  850 - Multilingual (Latin I), euro version
  912 - ISO 8859-2 (Latin)
 1252 - ANSI - Latin I)
65001 - UTF-8

Nel forum di newLISP IVShilov ha mostrato come importare delle funzioni da "kernel.dll" per leggere e impostare il codepage.

; Imposta il codepage per le operazioni di input
(import "kernel32.dll" "SetConsoleCP")
; Restituisce il codepage corrente per le operazioni di input
(import "kernel32.dll" "GetConsoleCP")
; Imposta il codepage per le operazioni di output
(import "kernel32.dll" "SetConsoleOutputCP")
; Restituisce il codepage corrente per le operazioni di output
(import "kernel32.dll" "GetConsoleOutputCP")

(GetConsoleCP)
;-> 437

(GetConsoleOutputCP)
;-> 437

; utf8
(SetConsoleOutputCP 65001)
;-> 1

(GetConsoleOutputCP)
;-> 65001

Nota: non modificare il registro di windows per cambiare il codepage per tutto il sistema.
In Windows 10 Pro Version: 22H2 OS build: 19045.3693 possiamo utilizzare il codice dei caratteri utf-8 con i seguenti passi:

  Settings --> Language settings --> Administrative language settings
  Cliccare su Change system locale...
  Selezionare la casella:
      "Beta: Use Unicode UTF-8 for worldwide language support"
  Riavviare il computer.

In questo modo viene applicato a tutti i programmi, anche quelli che non si avviano dal prompt dei comandi.


----------------------------------
Stringhe con una linea di tastiera
----------------------------------

Data una stringa, determinare se può essere scritta solo con una linea della tastiera.

US international keyboard Layout
--------------------------------
Linea 1: `1234567890-=
Linea 2: qwertyuiop[]\
Linea 3: asdfghjkl;' con CapsLock: ASDFGHJKL
Linea 4: zxcvbnm,./ con Shift: ZXCVBNM<>?
Linea 5: spazio (Space Bar)

Algoritmo
1. Inserire i caratteri di ogni linea in una lista (ogni elemento rappresenta una linea di caratteri)
2. Trovare i caratteri unici della stringa data
3. Ciclo sulla lista delle linee
   Calcolare l'intersezione tra la linea corrente e i caratteri unici.
   Se l'intersezione è uguale a caratteri-unici, allora la linea corrente può stampare la stringa data.

(define (line? str)
  (local (out strings lines letter)
    (setq out "")
    (setq strings '("`1234567890-=" "qwertyuiop[]\\" "asdfghjkl;'ASDFGHJKL"
                    "zxcvbnm,./ZXCVBNM<>?" " "))
    (setq lines '())
    (dolist (s strings)
      (push (explode s) lines -1)
    )
    (setq letter (unique (explode str)))
    (dolist (l lines)
      ;(println l { } letter)
      ;(print (intersect letter l))
      ;(read-line)
      (if (= (intersect letter l) letter)
          (setq out (string "line" (+ $idx 1))))
    )
    out))

Proviamo:

(line? "pippo")
;-> "line2"

(line? "qa")
;-> ""

(line? "zxc/?")
;-> "line4"

(line? "234`-=")
;-> "line1"
;-> -----

(line? "aAf;'")
;-> "line3"

(line? "   ")
;-> "line5"


-------------------------------------------------
Probabilità di eventi ripetuti K volte su N prove
-------------------------------------------------

Uno dei problemi che capitano frequentemente nel calcolo di probabilità' è quello di calcolare la probabilità' che un dato evento accada K volte su N prove effettuate.

Per esempio, se lanciamo una moneta 5 volte qual'è la probabilità che escano tutte Croci? Qual'è la probabilità che escano 2 Teste e 3 Croci?
Nel primo caso:

  P(1) = 1/2 * 1/2 * 1/2 * 1/2 * 1/2 = (1/2)^5
          C     C     C     C     C

Nel secondo caso:

  P(2) = 1/2 * 1/2 * 1/2 * 1/2 * 1/2 = (1/2)^5
          T     T     C     C     C

Il calcolo di P(2) è corretto solo se intendiamo l'evento come l'esatta sequenza TTCCC.
Se invece consideriamo validi anche gli altri eventi in cui sono uscite 2 Teste e 3 Croci in qualunque ordine (cioè TCTCC, CCCTT, CTCTC, ecc.) allora dobbiamo utilizzare la formula di Bernoulli.

Per calcolare la probabilità che un evento si verifichi K volte su N prove, quando l'evento ha una probabilità di successo P in ciascuna prova, possiamo utilizzare la distribuzione binomiale.
La formula di Bernoulli che utilizza la distribuzione binomiale è:

  P(X=K) = binom(N, K) * P^K * (1 - P)^(N - K)

dove:
  - P(X=K) è la probabilità che l'evento si verifichi esattamente K volte su N prove.
  - binom(N, K) è il coefficiente binomiale, che rappresenta il numero di modi diversi in cui K successi possono verificarsi in N prove ed è calcolato come N!/K!(N-K)!
  - P è la probabilità di successo in una singola prova.
  - (1 - P) è la probabilità di fallimento in una singola prova.
  - N è il numero totale di prove.
  - K è il numero di successi che vogliamo.

Se invece vogliamo calcolare la probabilità che un evento si verifichi K o più volte su N prove, possiamo sommare le probabilità di K successi, K + 1 successi, K + 2 successi, e così via fino a N successi.
La formula per calcolare questa probabilità cumulativa è la seguente:

  P(X>=K) = Sum[i=K..N](binom(N, i) * P^i * (1 - P)^(N - i))

dove:
  - P(X>=K)è la probabilità che l'evento si verifichi K o più volte su mprove.
  - binom(N, K) è il coefficiente binomiale.
  - P è la probabilità di successo in una singola prova.
  - (1 - P) è la probabilità di fallimento in una singola prova.
  - N è il numero totale di prove.
  - K è il numero minimo di successi che stiamo cercando.

Questa formula tiene conto di tutte le possibilità in cui l'evento si verifica almeno K volte su N prove.

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

(define (evento p k n)
  (mul (binom n k) (pow p k) (pow (sub 1 p) (- n k))))

Proviamo:

(evento 0.5 1 10)
;-> 0.009765625
(evento 0.5 5 10)
;-> 0.24609375
(add (evento 0.5 5 10) (evento 0.5 6 10) (evento 0.5 7 10)
     (evento 0.5 8 10) (evento 0.5 9 10) (evento 0.5 10 10))
;-> 0.623046875

(evento 0.6 1 10)
;-> 0.001572864
(evento 0.6 5 10)
;-> 0.2006581248
(add (evento 0.6 5 10) (evento 0.6 6 10) (evento 0.6 7 10)
     (evento 0.6 8 10) (evento 0.6 9 10) (evento 0.6 10 10))
;-> 0.8337613824

Vediamo i risultati di una simulazione.

(define (simula p k n iter)
  (local (event conta)
    (setq event 0)
    (for (i 1 iter)
      (setq conta 0)
      (for (e 1 n)
        (if (< (random) p) (++ conta))
      )
      (if (= conta k) (++ event))
    )
    (div event iter)))

Proviamo:

(simula 0.6 1 10 1e6)
;-> 0.001578
(simula 0.6 5 10 1e6)
;-> 0.200347
(add (simula 0.6 5 10 1e6) (simula 0.6 6 10 1e6) (simula 0.6 7 10 1e6)
     (simula 0.6 8 10 1e6) (simula 0.6 9 10 1e6) (simula 0.6 10 10 1e6))
;-> 0.833485


----------------------------------------
Funzione che stampa la propria lunghezza
----------------------------------------

Scrivere una funzione che restituisce la propria lunghezza in byte (caratteri).

Per calcolare la lunghezza di una funzione consideriamo la sua rappresentazione all'interno di newLISP.
Per esempio la funzione (define (test a b) (+ a b))
ha rappresentazione interna (lambda (a b) (+ a b)).

Il simbolo 'test' è una lista lambda:

(list? test)
;-> true
(lambda? test)
;-> true

Parametri della funzione:
(nth 0 test)
;-> (a b)

Corpo della funzione:
(nth 1 test)
;-> (+ a b)

Quindi per sapere la lunghezza della funzione possiamo convertire la lista in stringa e poi calcolare quanti sono i caratteri che la compongono.

Funzione di base (50 caratteri):

(define (bytes) (println (length (string bytes))))

Rappresentazione della funzione internamente a newLISP (45 caratteri):

(lambda () (println (length (string bytes))))

(bytes)
;-> 45

Possiamo modificare la funzione di base ed ottenere sempre la lunghezza della nuova funzione.

Funzione di base modificata (85 caratteri):
(define (bytes1 a b) (local (c) (setq c (+ a b)) (println (length (string bytes1)))))

Rappresentazione della funzione internamente a newLISP (78 caratteri):
(lambda (a b) (local (c) (setq c (+ a b)) (println (length (string bytes1)))))

(bytes1 2 3)
;-> 78


-----------------
Colori True color
-----------------

I colori True color (24-bit) usano 8 bit per ognuna delle componenti R, G e B (Red, Green, Blue).
32-bit color significa che oltre ai 24 bit del colore vengono usati 8 bit per il canale Alpha (trasparenza).
2^24 fornisce 16.777.216 variazioni di colore (16milioni 777mila 216).
L'occhio umano può discriminare fino a dieci milioni di colori e poiché la gamma di un display è inferiore alla gamma della visione umana, ciò significa che dovrebbe coprire quella gamma con più dettagli di quanto possa essere percepito.

I colori possono essere rappresentati con terne RGB in cui i valori R,G,B variano da 0 a 255.
In questo modo si ottengono 256 x 256 x 256 = 16777216 combinazioni di colori.
Alle volte i valori RGB vengono rappresentati con valori Esadecimali.

Esempi:

  RGB decimale   RGB esadecinale
  (131,0,0)      #830000
  (139,77,0)     #8b4d00
  (102,103,0)    #666700
  (0,81,14)      #00510e
  (0,4,64)       #000440

Scrivere una funzione che genera tutti i codici RGB dei 16.677.216 colori.

(define (truecolor)
  (let (out '())
    (for (r 255 0)
      (for (g 255 0)
        (for (b 255 0)
          (push (list r g b 
                (string (format "%02X" r) (format "%02X" g) (format "%02X" b))) out)
        )
      )
    )
    out))

(time (setq colors (truecolor)))
;-> 34342.34

(length colors)
;-> 16777216

(colors 0)
;-> (0 0 0 "000000")
(colors -1)
;-> (255 255 255 "FFFFFF")


----------------------------
Stringhe gonfiate (inflated)
----------------------------

Data una stringa, una stringa gonfiata si ottiene calcolando le frequenze dei suoi caratteri e riscrivendo la stringa con la seguente regola:
ogni carattere della stringa originale deve essere ripetuto per la sua frequenza.

Esempi:
  massimo --> m=2, a=1, s=2, i=1, o=1 --> mmassssimmo
  pippo --> p=3, i=1, o=1 --> pppippppppo
  stop --> (nessun carattere con frequenza > 1) --> stop 

(define (inflate str)
  (local (out uniq alst)
    (setq out "")
    (setq str (explode str))
    ; calcola i caratteri unici della stringa
    (setq uniq (unique str))
    ; crea una lista di elementi (carattere frequenza)
    (setq alst (map (fn(x y) (list x y)) uniq (count uniq str)))
    ; gonfia la stinga
    (dolist (c str)
      (extend out (dup c (lookup c alst)))
    )
    out))

Proviamo:

(inflate "massimo")
;-> "mmassssimmo"

(inflate "pippo")
;-> "pppippppppo"

(inflate "stop")
;-> "stop"

(inflate "newlisp")
;-> "newlisp"

(inflate "mamma mia")
;-> "mmmmaaammmmmmmmaaa mmmmiaaa"

(inflate "mississippi")
;-> "miiiissssssssiiiissssssssiiiippppiiii"


------------------------------------
Interlacciamento di stringhe e liste
------------------------------------

Date due stringhe, generare tutte le sequenze interlacciate di caratteri di queste due stringhe preservando il loro ordine originale.
Ciò significa che ogni carattere nella sequenza di output deve provenire dalla prima o dalla seconda stringa e il loro ordine deve essere mantenuto così come appare nelle stringhe di input.

Esempio:
str1 = "abc"
str2 = "xy"
Sequenze interlacciate = ("abcxy" "abxcy" "axbcy" "xabcy" "abxyc" "axbyc" "xabyc" "axybc" "xaybc" "xyabc")

Usiamo un approccio ricorsivo. 
Attraversiamo ogni carattere nelle stringhe di input e consideraimo due possibilità: o scegliamo il carattere dalla prima stringa o dalla seconda stringa.
Esploriamo ricorsivamente tutte le possibilità aggiungendo il carattere scelto al risultato e spostandoci alla posizione successiva nel risultato e alla stringa corrispondente.

(define (interleave str1 str2)
  (local (out len1 len2 idx cur-str)
    (setq out '())
    (setq len1 (length str1))
    (setq len2 (length str2))
    (setq idx (+ len1 len2))
    (setq cur-str (dup " " idx))
    (interleave-aux str1 str2 cur-str (- len1 1) (- len2 1) (- idx 1))
    out))

(define (interleave-aux a b cur-str n m idx)
  (cond ((and (= n -1) (= m -1)) (push cur-str out))
        (true
          (if (>= n 0) (begin
              (setf (cur-str idx) (a n))
              (interleave-aux a b cur-str (- n 1) m (- idx 1))))
          (if (>= m 0) (begin 
              (setf (cur-str idx) (b m))
              (interleave-aux a b cur-str n (- m 1) (- idx 1)))))))

Proviamo:

(interleave "abc" "xy")
;-> ("abcxy" "abxcy" "axbcy" "xabcy" "abxyc" 
;->  "axbyc" "xabyc" "axybc" "xaybc" "xyabc")

(interleave "abcd" "xyz")
;-> ("abcdxyz" "abcxdyz" "abxcdyz" "axbcdyz" "xabcdyz" "abcxydz" "abxcydz"
;->  "axbcydz" "xabcydz" "abxycdz" "axbycdz" "xabycdz" "axybcdz" "xaybcdz"
;->  "xyabcdz" "abcxyzd" "abxcyzd" "axbcyzd" "xabcyzd" "abxyczd" "axbyczd"
;->  "xabyczd" "axybczd" "xaybczd" "xyabczd" "abxyzcd" "axbyzcd" "xabyzcd"
;->  "axybzcd" "xaybzcd" "xyabzcd" "axyzbcd" "xayzbcd" "xyazbcd" "xyzabcd")

Per le liste possiamo usare le stesse funzioni con una sola modifica:
l'espressione: (setq cur-str (dup " " idx))
diventa: (setq cur-lst (dup 0 idx))

(define (interleave lst1 lst2)
  (local (out len1 len2 idx cur-lst)
    (setq out '())
    (setq len1 (length lst1))
    (setq len2 (length lst2))
    (setq idx (+ len1 len2))
    (setq cur-lst (dup 0 idx))
    (interleave-aux lst1 lst2 cur-lst (- len1 1) (- len2 1) (- idx 1))
    out))

(define (interleave-aux a b cur-lst n m idx)
  (cond ((and (= n -1) (= m -1)) (push cur-lst out))
        (true
          (if (>= n 0) (begin
              (setf (cur-lst idx) (a n))
              (interleave-aux a b cur-lst (- n 1) m (- idx 1))))
          (if (>= m 0) (begin 
              (setf (cur-lst idx) (b m))
              (interleave-aux a b cur-lst n (- m 1) (- idx 1)))))))

Proviamo:

(interleave '(1 2 3) '(4 5 6))
;-> ((1 2 3 4 5 6) (1 2 4 3 5 6) (1 4 2 3 5 6) (4 1 2 3 5 6) (1 2 4 5 3 6) 
;->  (1 4 2 5 3 6) (4 1 2 5 3 6) (1 4 5 2 3 6) (4 1 5 2 3 6) (4 5 1 2 3 6)
;->  (1 2 4 5 6 3) (1 4 2 5 6 3) (4 1 2 5 6 3) (1 4 5 2 6 3) (4 1 5 2 6 3)
;->  (4 5 1 2 6 3) (1 4 5 6 2 3) (4 1 5 6 2 3) (4 5 1 6 2 3) (4 5 6 1 2 3))

Funzione unica per stringhe e liste:

(define (interleave obj1 obj2)
  (local (out len1 len2 idx cur-obj)
    (setq out '())
    (setq len1 (length obj1))
    (setq len2 (length obj2))
    (setq idx (+ len1 len2))
    (if (list? obj1)
        (setq cur-obj (dup 0 idx))
        (setq cur-obj (dup " " idx))
    )
    (interleave-aux obj1 obj2 cur-obj (- len1 1) (- len2 1) (- idx 1))
    out))

(define (interleave-aux a b cur-obj n m idx)
  (cond ((and (= n -1) (= m -1)) (push cur-obj out))
        (true
          (if (>= n 0) (begin
              (setf (cur-obj idx) (a n))
              (interleave-aux a b cur-obj (- n 1) m (- idx 1))))
          (if (>= m 0) (begin 
              (setf (cur-obj idx) (b m))
              (interleave-aux a b cur-obj n (- m 1) (- idx 1)))))))

Proviamo:

(interleave "abc" "xy")
;-> ("abcxy" "abxcy" "axbcy" "xabcy" "abxyc" 
;->  "axbyc" "xabyc" "axybc" "xaybc" "xyabc")

(interleave '(1 2) '(3 4 5))
;-> ((1 2 3 4 5) (1 3 2 4 5) (3 1 2 4 5) (1 3 4 2 5) (3 1 4 2 5) 
;->  (3 4 1 2 5) (1 3 4 5 2) (3 1 4 5 2) (3 4 1 5 2) (3 4 5 1 2))


------------------
Residui quadratici
------------------

Un intero r è detto residuo quadratico modulo n se esiste un intero x tale che:

   x^2 ≡ r (mod n)

L'insieme dei residui quadratici modulo n può essere generato calcolando (x^2 mod n) per 0 <= x <= floor(n/2).

(define (residui x n)
  (map (fn(x) (% (* x x) n)) (sequence 0 (floor (/ n 2)))))

Proviamo:

(residui 10 3)
;-> (0 1)

(residui 10 10)
;-> ( 0 1 4 9 6 5)

(residui 13 11)
;-> (0 1 4 9 5 3)


--------
Zip Bomb
--------

Una Zip Bomb (Bomba Zip) è solitamente un piccolo file facile da trasportare che non genera sospetti.
Tuttavia, quando il file viene decompresso, il suo contenuto è maggiore di quanto il sistema possa gestire.
Le Zip Bomb possono essere annoverate dagli attacchi di tipo DoS (Denial of Service) perché il loro obiettivo è quello di appesantire la macchina dell'utente così da renderla inutilizzabile.

Un esempio di Zip Bomb è il file 42.zip.
Il file contiene 16 file zippati, che a sua volta contiene 16 file zippati, che ancora contiene 16 file zippati, che ancora contiene 16 file zippati, che ancora contiene 16 file zippati, che contengono 1 file, con la dimensione di 4,3 GB.

Quindi, se estrai tutti i file, molto probabilmente rimarrai senza spazio :-)

  16 x 4294967295       = 68.719.476.720 (68GB)
  16 x 68719476720      = 1.099.511.627.520 (1TB)
  16 x 1099511627520    = 17.592.186.040.320 (17TB)
  16 x 17592186040320   = 281.474.976.645.120 (281TB)
  16 x 281474976645120  = 4.503.599.626.321.920 (4,5PB)

In realtà esistono due versioni di 42.zip, una versione precedente di 42.374 byte e una versione più recente di 42.838 byte. 
La differenza è che la versione più recente richiede una password prima di decomprimere.

42.zip (42.838 bytes)
Password: 42

42-old.zip (42.374 bytes)

Potete trovare il file 42.zip nella cartella "data".

Al seguente link web è possibile trovare entrambi i file:

https://theaviary.me/Zip-Bomb/42.html

Una forma sofisticata di Zip Bomb sfrutta le specifiche dei file zip e l'algoritmo di compressione Deflate per creare bombe senza l'uso di livelli nidificati come quelli utilizzati in 42.zip.

Esistono vari tipi di Zip Bomb:

Multilivello: è il caso del file 42.zip. Questa tipologia di attacco utilizzi file Zip ricorsivi "incastonati" l'uno dento l'altro.

Single-layered: in questo caso gli aggressori utilizzano un unico livello di compressione, senza usare l'approccio ricorsivo. 
Gli autori della Zip Bomb progettano attentamente il set di file di dati per ottenere il miglior rapporto di compressione. 
Esempi famosi sono le Zip Bomb chiamate zbsm, zblg e zbxl.

Autoreplicante: l'esemplare di Zip Bomb più complesso. 
Si tratta di un file Zip che si replica quando viene decompresso, creando un processo ricorsivo. 
Un esempio noto di tale categoria è il file r.zip.

Comunque la maggior parte dei moderni programmi antivirus e dei programmi di compressione (7-zip, Rar) è in grado di rilevare se un file è uno Zip Bomb, per evitare di decomprimerlo.


---------------------------------------------------------------
Sottosequenza ripetuta più lunga di una singola cifra/carattere
---------------------------------------------------------------

Dato un numero intero positivo, restituisce la sottosequenza a cifra singola più lunga che si verifica almeno due volte e ha i limiti di un'altra cifra (o l'inizio/fine del numero intero).

Esempio: 7888885466662716666
La sottosequenza più lunga di una singola cifra sarebbe 88888 (7[88888]5466662716666) con una lunghezza pari a 5. 
Tuttavia, questa sottosequenza si verifica solo una volta nell'intero.
Invece il risultato dovrebbe essere 6666 (78888854[6666]271[6666]), poiché ricorre (almeno) due volte.

La lunghezza delle sottosequenze ha la priorità rispetto al numero di volte in cui si verificano. 
(Cioè con 8888858888866656665666, restituiamo 88888 ([88888]5[88888]66656665666, lunghezza 5, si verifica due volte), e non 666 (88888588888[666]5[666]5[666], lunghezza 3, si verifica tre volte).

Se la lunghezza di più sottosequenze è uguale, viene generata quella con il valore più grande. 
Cioè, con 3331113331119111, restituiamo 333 ([333]111[333]1119111, lunghezza 3, valore 3) e non 111 (333[111]333[111]9[111], lunghezza 3, valore 1)

La sottosequenza deve avere limiti di altre cifre (o l'inizio/fine dell'intero). 
Cioè, con l'input 122222233433 il risultato è 33 (1222222[33]4[33], lunghezza 2, si verifica due volte) e non 222 (1[222][222]33433, lunghezza 3, si verifica due volte con entrambi non validi).

Questo vale per tutti i numeri che vengono conteggiati nel contatore delle occorrenze. 
Cioè, con l'input 811774177781382 il risultato è 8 ([8]117741777[8]13[8]2, lunghezza 1, si verifica tre volte) e non 77 (811[77]41[77]781382 / 811[77]417[77]81382, lunghezza 2, ricorre due volte con uno non valido) né 1 (8[1][1]774[1]7778[1]382, lunghezza 1, ricorre quattro volte con due non validi).

La stringa di input può essere alfanumeric (cifre e caratteri).

(define (rle-encode lst)
"Encode list with Run Length Encoding"
  (local (palo conta out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq palo (first lst))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              (if (= el palo) (++ conta)
                  ; altrimenti costruiamo la coppia (conta el) e la aggiungiamo al risultato
                  (begin (extend out (list(list conta palo)))
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           ; aggiungiamo l'ultima coppia di valori
           (extend out (list(list conta palo)))
          )
    )
    out))

(rle-encode (explode "911133111339339339339339"))
;-> ((1 "9") (3 "1") (2 "3") (3 "1") (2 "3") (1 "9") (2 "3")
;->  (1 "9") (2 "3") (1 "9") (2 "3") (1 "9") (2 "3") (1 "9"))

(sort (rle-encode (explode "911133111339339339339339")) >)
;-> ((3 "1") (3 "1") (2 "3") (2 "3") (2 "3") (2 "3") (2 "3") 
;->  (2 "3") (1 "9") (1 "9") (1 "9") (1 "9") (1 "9") (1 "9"))

A questo punto basta fare un ciclo per ogni elemento della lista per trovare il primo elemento che compare più di una volta.

(define (longest str)
  (setq lst (sort (rle-encode (explode str)) >))
  (setq stop nil)
  (dolist (el lst stop)
    ; se l'elemento corrente compare più di una volta,
    ; allora è la soluzione    
    (cond ((> (first (count (list el) lst)) 1)
           (println (dup (el 1) (el 0)))
           (setq stop true)))))

Proviamo:

(longest "911133111339339339339339")
;-> 111
(longest "900033000339339339339339")
;-> 000
(longest "BAAACCAAACCBCCBCCBCCBCCB")
;-> AAA

(longest "7888885466662716666")
;-> 6666

(longest "3331113331119111")
;-> 333

(longest "777333777333")
;-> 777

(longest "122222233433")
;-> 33

(longest "811774177781382")
;-> 8

(longest "555153333551")
;-> 1

(longest "12321")
;-> 2

(longest "944949949494999494")
;-> 9

(longest "8888858888866656665666")
;-> 88888

(longest "1112221112221111")
;-> 222

(longest "911133111339339339339339")
;-> 111

============================================================================

