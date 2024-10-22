================

 NOTE LIBERE 26

================

  "In cuesta fraze ci sono cincue erori"

------------------
Punteggio Scrabble
------------------

Lo Scrabble è un gioco basato sulla formazione di parole di senso compiuto.
Per calcolare il valore di una parola ad ogni lettera viene assegnato un punteggio che è inversamente proporzionale alla frequenza di utilizzo nella lingua italiana.
La seguente tabella mostra i valori e la frequenza per ogni lettera dell'alfabeto italiano:

  Lettera   Valore   Frequenza
  A          1       14
  B          5        3
  C          2        6
  D          5        3
  E          1       11
  F          5        3
  G          8        2
  H          8        2
  I          1       12
  L          3        5
  M          3        5
  N          3        5
  O          1       15
  P          5        3
  Q         10        1
  R          2        6
  S          2        6
  T          2        6
  U          3        5
  V          5        3
  Z          8        2

Scriviamo una funzione che calcola il valore di una data parola.

(define (scrabble str)
  (let ( (val 0)
         (valori '(("A" 1) ("B" 5) ("C" 2) ("D" 5) ("E" 1) ("F" 5) ("G" 8)
                   ("H" 8) ("I" 1) ("L" 3) ("M" 3) ("N" 3) ("O" 1) ("P" 5)
                   ("Q" 10) ("R" 2) ("S" 2) ("T" 2) ("U" 3) ("V" 5) ("Z" 8))) )
    (setq str (upper-case str))
    (for (i 0 (- (length str) 1))
      (++ val (lookup (str i) valori)))))

Proviamo:

(scrabble "mamma")
;-> 11
(scrabble "soqquadro")
;-> 35

(scrabble "dieci")
;-> 10
(scrabble "quarantaquattro")
;-> 44

Vediamo quali numeri in forma letterale (da 0 a 100) hanno un valore scrabble pari al numero stesso:
(per la creazione dei numeri in lettere vedi "Conversione numero da cifre a lettere" su "Funzioni varie")

(setq numeri
  '("Zero" "Uno" "Due" "Tre" "Quattro" "Cinque" "Sei" "Sette" "Otto" "Nove"
    "Dieci" "Undici" "Dodici" "Tredici" "Quattordici" "Quindici" "Sedici"
    "Diciassette" "Diciotto" "Diciannove" "Venti" "VentUno" "VentiDue"
    "VentiTre" "VentiQuattro" "VentiCinque" "VentiSei" "VentiSette"
    "VentOtto" "VentiNove" "Trenta" "TrentUno" "TrentaDue" "TrentaTre"
    "TrentaQuattro" "TrentaCinque" "TrentaSei" "TrentaSette" "TrentOtto"
    "TrentaNove" "Quaranta" "QuarantUno" "QuarantaDue" "QuarantaTre"
    "QuarantaQuattro" "QuarantaCinque" "QuarantaSei" "QuarantaSette"
    "QuarantOtto" "QuarantaNove" "Cinquanta" "CinquantUno" "CinquantaDue"
    "CinquantaTre" "CinquantaQuattro" "CinquantaCinque" "CinquantaSei"
    "CinquantaSette" "CinquantOtto" "CinquantaNove" "Sessanta"
    "SessantUno" "SessantaDue" "SessantaTre" "SessantaQuattro"
    "SessantaCinque" "SessantaSei" "SessantaSette" "SessantOtto"
    "SessantaNove" "Settanta" "SettantUno" "SettantaDue" "SettantaTre"
    "SettantaQuattro" "SettantaCinque" "SettantaSei" "SettantaSette"
    "SettantOtto" "SettantaNove" "Ottanta" "OttantUno" "OttantaDue"
    "OttantaTre" "OttantaQuattro" "OttantaCinque" "OttantaSei" "OttantaSette"
    "OttantOtto" "OttantaNove" "Novanta" "NovantUno" "NovantaDue"
    "NovantaTre" "NovantaQuattro" "NovantaCinque" "NovantaSei"
    "NovantaSette" "NovantOtto" "NovantaNove" "Cento"))

(for (i 0 100)
  (if (= (scrabble (numeri i)) i)
      (println (numeri i) " --> " i)))
;-> Dieci --> 10
;-> QuarantaQuattro --> 44


-----------------------------------------------------------
Rappresentazione di una funzione matematica con N parametri
-----------------------------------------------------------

Quando codifichiamo una funzione matematica in genere usiamo gli stessi nomi per i parametri della funzione e le variabili del programma. Per esempio:

f(x,y) = x*y + x^2*y^2
(define (f x y) (add (mul x y) (mul x x y y)))

I parametri x e y della funzione hanno gli stessi nomi x e y delle variabili del programma.

Se la funzione matematica codificata deve essere passata come parametro ad altre funzioni del programma, allora dobbiamo considerare due casi:

1) la funzione passata ha sempre lo stesso numero di parametri
In questo caso la nostra codifica della funzione matematica non crea problemi in quanto le funzioni chiamanti sono predisposte ad utilizzare sempre lo stesso numero di parametri (x e y nell'esempio).

2) la funzione passata ha un numero variabile di parametri
In questo caso la nostra codifica della funzione matematica crea problemi in quanto le funzioni chiamanti non sono predisposte ad utilizzare un numero variabile di parametri.
Un metodo per risolvere questo problema consiste nel definire i parametri della funzione matematica come una lista. Per esempio, la funzione sopra diventa:

f(x,y) = x*y + x^2*y^2
(define (f x y) (add (mul x y) (mul x x y y)))
(define (f p) (add (mul (p 0) (p 1)) (mul (p 0) (p 0) (p 1) (p 1))))

Abbiamo operato le seguenti sostituzioni:

  Lista: p = (x y)
  x = (p 0)
  y = (p 1)

In questo modo le funzioni chiamanti possono utilizzare la lista 'p' dei parametri della funzione 'f' con facilità.

Come esempio vedi "Gradiente di una funzione" in "Note libere 26".


-------------------------
Gradiente di una funzione
-------------------------

Il "gradiente" rappresenta la derivata di una funzione che ha più di un parametro.
Il significato fisico è un vettore che rappresenta la direzione e la pendenza della funzione nel punto dato.

Ad esempio, supponiamo di avere la seguente funzione 2D:

  f(x, y) = x*x + y*y

E di voler calcolare il valore del gradiente nel punto (1, 2).
Calcoliamo il valore della funzione in questo punto e poi in due punti adiacenti con una variazione (offset) pari a dt = 0.1:

  f(x0, y0) = f(1, 2) = 1*1 + 2*2 = 5

  f(x0 + dt, y0) = f(1.1, 2) = 1.1*1.1 + 2*2 = 5.21

  f(x0, y0 + dt) = f(1, 2.1) = 1*1 + 2.1*2.1 = 5.41

Il gradiente è un vettore le cui componenti rappresentano la tangente della pendenza in ogni direzione (in questo caso x e y):

  g(x0, y0) = ((f(x0 + dt, y0) - f(x0, y0)) / dt,
               (f(x0, y0 + dt) - f(x0, y0) / dt) =
  = ((5.21 - 5,00) / 0.1, (5.41 - 5.00) / 0,1) =
  = (2.1, 4.1)

Naturalmente questo modo di calcolo fornirà un valore preciso per il gradiente solo quando dt è infinitesimale, ma per ragioni pratiche possiamo usare alcuni valori finitamente piccoli, come 1e-9 e calcolare il gradiente con la precisione data.

Direzione della pendenza
La direzione del vettore risultante, vale:

  atan2(4.1, 2.1) = 63 gradi dall'asse x, in senso antiorario.

Si tratta della direzione in cui la pendenza in questo punto aumenta più ripidamente.
Allo stesso tempo, la direzione inversa è quella che diminuiosce più rapidamente da questo punto.
Questo funziona anche per le funzioni con più di due argomenti, cioè per gli spazi con più dimensioni (anche se è difficile immaginarlo visivamente).

Vediamo una funzione in newLISP per calcolare il gradiente di una funzione con n parametri in un dato punto.

Parametri:
1) 'f': funzione di cui vogliamo calcolare il gradiente.
2) 'x': vettore di lunghezza n che rappresenta il punto in cui vogliamo calcolare il gradiente.
3) 'h': un piccolo valore utilizzato per approssimare la derivata (es. h = 1e-5).

(define (gradient f x h)
  (let (n (length x))
    (map
      (fn(i)
        (let (var x)
          (setf (var i) (add (x i) h))
          ;(println x) (println x1)
          (div (sub (f var) (f x)) h)))
      (sequence 0 (- n 1)))))

Proviamo:

Funzione: f(x,y) = x^2 + y^2
(define (func x) (add (pow (x 0) 2) (pow (x 1) 2)))
(setq punto '(1 2))
(setq h 0.1)
(gradient func punto h)
;-> (2.1 4.100000000000001)
(setq h 1e-5)
(gradient func punto h)
;-> (2.00001000001393 4.000010000027032)

Funzione: f(x,y) = xy + x^2
(define (func x) (add (mul (x 0) (x 1)) (mul (x 0) (x 0))))
(setq punto '(2 0))
(setq h 0.1)
(gradient func punto h)
;-> (4.100000000000001 2.000000000000002)
(setq h 1e-5)
(gradient func punto h)
;-> (4.000010000027032 2.000000000013102)

Funzione: f(x,y,x) = x*y*z + x*y + z
(define (func x) (add (mul (x 0) (x 1) (x 2)) (mul (x 0) (x 1)) (x 2)))
(setq punto '(2 2 2))
(setq h 0.1)
(gradient func punto h)
;-> (6.000000000000014 6.000000000000014 5)
(setq h 1e-5)
(gradient func punto h)
;-> (6.000000000128124 6.000000000128124 4.999999999988347)

Per migliorare il calcolo possiamo usare la differenza finita centrale per calcolare la derivata.

(define (gradient2 f x h)
  (let (n (length x))
    (map
      (lambda (i)
        (let ((var1 x)
              (var2 x))
          (setf (var1 i) (add (x i) h))
          (setf (var2 i) (sub (x i) h))
          (div (sub (f var1) (f var2)) (mul 2 h))))
      (sequence 0 (- n 1)))))

Proviamo:

Funzione: f(x,y) = x^2 + y^2
(define (func x) (add (pow (x 0) 2) (pow (x 1) 2)))
(setq punto '(1 2))
(setq h 0.1)
(gradient2 func punto h)
;-> (1.999999999999997 4.000000000000004)
(setq h 1e-5)
(gradient2 func punto h)
;-> (2.000000000013102 4.000000000026205)

Funzione: f(x,y) = xy + x^2
(define (func x) (add (mul (x 0) (x 1)) (mul (x 0) (x 0))))
(setq punto '(2 0))
(setq h 0.1)
(gradient2 func punto h)
;-> (4.000000000000001 2.000000000000002)
(setq h 1e-5)
(gradient2 func punto h)
;-> (4.000000000026205 2.000000000013102)

Funzione: f(x,y,x) = x*y*z + x*y + z
(define (func x) (add (mul (x 0) (x 1) (x 2)) (mul (x 0) (x 1)) (x 2)))
(setq punto '(2 2 2))
(setq h 0.1)
(gradient2 func punto h)
;-> (6.000000000000014 6.000000000000014 5)
(setq h 1e-5)
(gradient2 func punto h)
;-> (6.000000000128124 6.000000000128124 4.999999999988347)


---------------------------
Somma ponderata delle cifre
---------------------------

Il peso di una cifra (0..9) è dato dal numero dei suoi divisori:
(alla cifra 0 viene dato un peso 1)

  Cifra Divisori
   0     1
   1     1
   2     2
   3     2
   4     3
   5     2
   6     4
   7     2
   8     4
   9     3

Definiamo la Somma Ponderata delle Cifre per un intero N, SPC(N), come la somma di ciascuna cifra del numero moltiplicata per il suo peso.

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (spc num)
  (local (link digits sum)
    (setq link '((0 1) (1 1) (2 2) (3 2) (4 3) (5 2) (6 4) (7 2) (8 4) (9 3)))
    (setq digits (int-list num))
    (setq sum 0)
    (dolist (d digits) (++ sum (* d (lookup d link))))
    sum))

Proviamo:

(spc 9876543210)
;-> 130
(spc 123456)
;-> 57
(spc 111)
;-> 3
(spc 9123456789123456789)
;-> 287

(time (spc 9123456789123456789) 1e5)
;-> 452.03

Versione più veloce (link come vettore):

(define (spc-fast num)
  (let ( (sum 0) (d 0) (link (array 10 '(1 1 2 2 3 2 4 2 4 3))) )
    (while (!= num 0)
      (setq d (% num 10))
      (++ sum (* d (link d)))
      (setq num (/ num 10))
    )
    sum))

Proviamo:

(spc-fast 9876543210)
;-> 130
(spc-fast 123456)
;-> 57
(spc-fast 111)
;-> 3
(spc-fast 9123456789123456789)
;-> 287

(time (spc-fast 9123456789123456789) 1e5)
;-> 344.054


-------------------------------------
Automi cellulari elementari (Wolfram)
-------------------------------------

"A New Kind of Science" by Stephen Wolfram, Wolfram Media (2002).
Versione online: https://www.wolframscience.com/nks/

Gli automi cellulari elementari sono la classe più semplice di automi cellulari unidimensionali.
Questi automi hanno due possibili valori per ogni cella (0 o 1) e regole che dipendono solo dai valori delle celle adiacenti.
L'evoluzione di un automa cellulare elementare può essere descritta da una tabella che specifica lo stato che una data cella avrà nella generazione successiva in base a tre valori:
1) il valore della cella alla sua sinistra,
2) il valore della cella stessa
3) il valore della cella alla sua destra.
Poiché ci sono 2x2x2 = 2^3 = 8 possibili stati binari per le tre celle vicine, ci sono un totale di 2^8 = 256 automi cellulari elementari, ognuno dei quali viene individuato con un numero decimale (o un numero binario a 8 bit).

Per esempio, l'automa cellulare 30 ha la seguente codifica (Rule 30):

  111 -> 0
  110 -> 0
  101 -> 0
  100 -> 1
  011 -> 1
  010 -> 1
  001 -> 1
  000 -> 0

Casi della cella iniziale e finale:
Calcolare la nuova generazione per la cella iniziale e finale in un automa cellulare unidimensionale non ha un metodo unico perché le celle iniziali e finali non hanno entrambe le celle adiacenti.
Ci sono diverse soluzioni a questo problema, a seconda di come si vuole gestire i bordi dell'automa cellulare:

1) Bordi periodici (o condizioni di contorno cicliche)
In questo approccio, l'ultima cella è considerata come vicina alla prima, e viceversa.
In altre parole, il vicino della prima cella include l'ultima cella e il vicino dell'ultima cella include la prima cella.
Questo rende l'automa cellulare "circolare".

(define (next-generation cells rule)
  (let ((n (length cells))
        (new-cells '()))
    (dotimes (i n)
      (let ((left (nth (mod (- i 1) n) cells))  ; La cella a sinistra (con bordi ciclici)
            (center (nth i cells))             ; La cella centrale
            (right (nth (mod (+ i 1) n) cells))) ; La cella a destra (con bordi ciclici)
        (let ((pattern (list left center right))) ; Crea il vicinato
          (push (lookup-rule rule pattern) new-cells)))) ; Applica la regola
    (reverse new-cells))) ; Restituisci la nuova generazione

(define (lookup-rule rule pattern)
  (find (list pattern '?) rule match)
  ($0 1))

;; Esempio
(setq rule1 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
              ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 0) ((0 0 0) 1)))

(setq initial-generation '(0 1 0 1 1 0 1 0))
(next-generation initial-generation rule1)
;-> (0 0 0 0 0 0 0 0)

2) Bordi fissi
In questo caso, le celle iniziali e finali sono trattate come se fossero fisse.
Spesso vengono considerati come se i loro vicini fossero sempre 0.

(define (next-generation-fixed cells rule)
  (let ((n (length cells))
        (new-cells '()))
    (dotimes (i n)
      (let ((left (if (= i 0) 0 (nth (- i 1) cells))) ; Vicino sinistro (0 per la prima cella)
            (center (nth i cells))                    ; La cella centrale
            (right (if (= i (- n 1)) 0 (nth (+ i 1) cells)))) ; Vicino destro (0 per l'ultima cella)
        (let ((pattern (list left center right))) ; Crea il vicinato
          (push (lookup-rule rule pattern) new-cells)))) ; Applica la regola
    (reverse new-cells))) ; Restituisci la nuova generazione

;; Esempio
(next-generation-fixed initial-generation rule1)
;-> (1 1 0 0 0 0 0 0)

3) Bordi riflettenti
In questa configurazione, si considera che la prima cella e l'ultima abbiano un vicino riflettente (cioè, una copia di sé stesse).

(define (next-generation-reflective cells rule)
  (let ((n (length cells))
        (new-cells '()))
    (dotimes (i n)
      (let ((left (if (= i 0) (nth 0 cells) (nth (- i 1) cells))) ; Riflette se stessa a sinistra
            (center (nth i cells))                                ; La cella centrale
            (right (if (= i (- n 1)) (nth (- n 1) cells) (nth (+ i 1) cells)))) ; Riflette se stessa a destra
        (let ((pattern (list left center right))) ; Crea il vicinato
          (push (lookup-rule rule pattern) new-cells)))) ; Applica la regola
    (reverse new-cells))) ; Restituisci la nuova generazione
)

;; Esempio:
(next-generation-reflective initial-generation rule1)
;-> (0 0 0 0 0 0 0 0)

Nella funzione che scriveremo utilizzeremo il metodo dei bordi fissi, considerando i vicini come 0 (anzi (0 0)).

Funzione che stampa la configurazione (matrice) finale:

(define (print-matrix matrix ch0 ch1)
  (local (row col)
    (setq row (length matrix))
    (setq col (length (matrix 0)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (cond ((= (matrix i j) 0) (setq ch ch0))
              ((= (matrix i j) 1) (setq ch ch1)))
        (print ch)
      )
      (println)) '>))

Funzione che simula una automa cellulare elementare con la regola 30:

(define (rule30 num-lines)
  (local (line lines tmp pat val matrix row)
    ; prima linea
    (setq line '(0 0 1 0 0))
    ; lista delle linee
    (setq lines (list line))
    ; ciclo per il numero totale di linee da creare
    (for (k 2 num-lines)
      ; linea temporanea
      (setq tmp '())
      ; ciclo per creare la nuova linea dmatrixa linea corrente
      (for (i 1 (- (length line) 2))
        ; pattern della cella corrente
        (setq pat (list (line (- i 1)) (line i) (line (+ i 1))))
        ; regola 30
        (cond ((= pat '(1 1 1)) (setq val 0))
              ((= pat '(1 1 0)) (setq val 0))
              ((= pat '(1 0 1)) (setq val 0))
              ((= pat '(1 0 0)) (setq val 1))
              ((= pat '(0 1 1)) (setq val 1))
              ((= pat '(0 1 0)) (setq val 1))
              ((= pat '(0 0 1)) (setq val 1))
              ((= pat '(0 0 0)) (setq val 0)))
        ; inserimento nuova cella nella linea temporanea
        (push val tmp -1)
      )
      ; aggiungiamo i vicini '(0 0) matrixa linea temporanea
      (setq line (append '(0 0) tmp '(0 0)))
      ; inserimento della linea temporanea nella lista delle linee
      (push line lines)
    )
    ; creazione della matrice di stampa
    ; rende la lista delle linee una matrice quadrata aggiungendo
    ; gli 0 necessari ad ogni linea.
    (setq matrix (list (lines 0)))
    (for (i 1 (- num-lines 1))
      (setq row (append (dup 0 i) (lines i) (dup 0 i)))
      (push row matrix)
    )
    ; restituzione della matrice
    matrix))

Proviamo:

(rule30 19) "  " " ■")
(print-matrix (rule30 19) "  " " ■")
;->                                     ■
;->                                   ■ ■ ■
;->                                 ■ ■     ■
;->                               ■ ■   ■ ■ ■ ■
;->                             ■ ■     ■       ■
;->                           ■ ■   ■ ■ ■ ■   ■ ■ ■
;->                         ■ ■     ■         ■     ■
;->                       ■ ■   ■ ■ ■ ■     ■ ■ ■ ■ ■ ■
;->                     ■ ■     ■       ■ ■ ■           ■
;->                   ■ ■   ■ ■ ■ ■   ■ ■     ■       ■ ■ ■
;->                 ■ ■     ■         ■   ■ ■ ■ ■   ■ ■     ■
;->               ■ ■   ■ ■ ■ ■     ■ ■   ■         ■   ■ ■ ■ ■
;->             ■ ■     ■       ■ ■ ■     ■ ■     ■ ■   ■       ■
;->           ■ ■   ■ ■ ■ ■   ■ ■     ■ ■ ■   ■ ■ ■     ■ ■   ■ ■ ■
;->         ■ ■     ■         ■   ■ ■ ■       ■     ■ ■ ■     ■     ■
;->       ■ ■   ■ ■ ■ ■     ■ ■   ■     ■   ■ ■ ■ ■ ■     ■ ■ ■ ■ ■ ■ ■
;->     ■ ■     ■       ■ ■ ■     ■ ■ ■ ■   ■         ■ ■ ■             ■
;->   ■ ■   ■ ■ ■ ■   ■ ■     ■ ■ ■         ■ ■     ■ ■     ■         ■ ■ ■
;-> ■ ■     ■         ■   ■ ■ ■     ■     ■ ■   ■ ■ ■   ■ ■ ■ ■     ■ ■     ■

(print-matrix (rule30 19) "  " "██")
;->
;->                                     ██
;->                                   ██████
;->                                 ████    ██
;->                               ████  ████████
;->                             ████    ██      ██
;->                           ████  ████████  ██████
;->                         ████    ██        ██    ██
;->                       ████  ████████    ████████████
;->                     ████    ██      ██████          ██
;->                   ████  ████████  ████    ██      ██████
;->                 ████    ██        ██  ████████  ████    ██
;->               ████  ████████    ████  ██        ██  ████████
;->             ████    ██      ██████    ████    ████  ██      ██
;->           ████  ████████  ████    ██████  ██████    ████  ██████
;->         ████    ██        ██  ██████      ██    ██████    ██    ██
;->       ████  ████████    ████  ██    ██  ██████████    ██████████████
;->     ████    ██      ██████    ████████  ██        ██████            ██
;->   ████  ████████  ████    ██████        ████    ████    ██        ██████
;-> ████    ██        ██  ██████    ██    ████  ██████  ████████    ████    ██


(print-matrix (rule30 40) "  " "██")

Vedi immagine "rule30.png" nella cartella "data".

Lista delle regole:

(setq rules '(
  (r0  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 0) ((0 0 0) 0)))
  (r1  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 0) ((0 0 0) 1)))
  (r2  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 1) ((0 0 0) 0)))
  (r3  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 1) ((0 0 0) 1)))
  (r4  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 0) ((0 0 0) 0)))
  (r5  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 0) ((0 0 0) 1)))
  (r6  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0)))
  (r7  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 1)))
  (r8  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 1) ((0 1 0) 0) ((0 0 1) 0) ((0 0 0) 0)))
  (r9  '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 1) ((0 1 0) 0) ((0 0 1) 0) ((0 0 0) 1)))
  (r10 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 1) ((0 1 0) 0) ((0 0 1) 1) ((0 0 0) 0)))
  (r11 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 1) ((0 1 0) 0) ((0 0 1) 1) ((0 0 0) 1)))
  (r12 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 1) ((0 1 0) 1) ((0 0 1) 0) ((0 0 0) 0)))
  (r13 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 1) ((0 1 0) 1) ((0 0 1) 0) ((0 0 0) 1)))
  (r14 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 1) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0)))
  (r15 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 0)
        ((0 1 1) 1) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 1)))
  (r16 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
        ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 0) ((0 0 0) 0)))
  (r17 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
        ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 0) ((0 0 0) 1)))
  (r18 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
        ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 1) ((0 0 0) 0)))
  (r19 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
        ((0 1 1) 0) ((0 1 0) 0) ((0 0 1) 1) ((0 0 0) 1)))
  (r20 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
        ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 0) ((0 0 0) 0)))
  (r21 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
        ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 0) ((0 0 0) 1)))
  (r22 '(((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
        ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0)))
  ;; Continuare fino a r255
))

Funzione generica per un automa cellulare elementare (solo per regole che trasformano (0 0 0) -> 0):

(define (lookup-rule rule pattern)
  (find (list pattern '?) rule match)
  ($0 1))

(define (ace rule num-lines)
  (local (line lines tmp pat val matrix row)
    ; prima linea
    (setq line '(0 0 1 0 0))
    ; lista delle linee
    (setq lines (list line))
    ; ciclo per il numero totale di linee da creare
    (for (k 2 num-lines)
      ; linea temporanea
      (setq tmp '())
      ; ciclo per creare la nuova linea dmatrixa linea corrente
      (for (i 1 (- (length line) 2))
        ; pattern della cella corrente
        (setq pat (list (line (- i 1)) (line i) (line (+ i 1))))
        ; inserimento nuova cella nella linea temporanea
        (push (lookup-rule rule pat) tmp -1)
      )
      ; aggiungiamo i vicini '(0 0) matrixa linea temporanea
      (setq line (append '(0 0) tmp '(0 0)))
      ; inserimento della linea temporanea nella lista delle linee
      (push line lines)
    )
    ; creazione della matrice di stampa
    ; rende la lista delle linee una matrice quadrata aggiungendo
    ; gli 0 necessari ad ogni linea.
    (setq matrix (list (lines 0)))
    (for (i 1 (- num-lines 1))
      (setq row (append (dup 0 i) (lines i) (dup 0 i)))
      (push row matrix)
    )
    ; restituzione della matrice
    matrix))

Proviamo con la regola 30:

(setq r30 '( ((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
             ((0 1 1) 1) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0) ))

(print-matrix (ace r30 19) "  " " ■")
;->                                     ■
;->                                   ■ ■ ■
;->                                 ■ ■     ■
;->                               ■ ■   ■ ■ ■ ■
;->                             ■ ■     ■       ■
;->                           ■ ■   ■ ■ ■ ■   ■ ■ ■
;->                         ■ ■     ■         ■     ■
;->                       ■ ■   ■ ■ ■ ■     ■ ■ ■ ■ ■ ■
;->                     ■ ■     ■       ■ ■ ■           ■
;->                   ■ ■   ■ ■ ■ ■   ■ ■     ■       ■ ■ ■
;->                 ■ ■     ■         ■   ■ ■ ■ ■   ■ ■     ■
;->               ■ ■   ■ ■ ■ ■     ■ ■   ■         ■   ■ ■ ■ ■
;->             ■ ■     ■       ■ ■ ■     ■ ■     ■ ■   ■       ■
;->           ■ ■   ■ ■ ■ ■   ■ ■     ■ ■ ■   ■ ■ ■     ■ ■   ■ ■ ■
;->         ■ ■     ■         ■   ■ ■ ■       ■     ■ ■ ■     ■     ■
;->       ■ ■   ■ ■ ■ ■     ■ ■   ■     ■   ■ ■ ■ ■ ■     ■ ■ ■ ■ ■ ■ ■
;->     ■ ■     ■       ■ ■ ■     ■ ■ ■ ■   ■         ■ ■ ■             ■
;->   ■ ■   ■ ■ ■ ■   ■ ■     ■ ■ ■         ■ ■     ■ ■     ■         ■ ■ ■
;-> ■ ■     ■         ■   ■ ■ ■     ■     ■ ■   ■ ■ ■   ■ ■ ■ ■     ■ ■     ■

(print-matrix (ace r30 10) "  " "██")
;->                   ██
;->                 ██████
;->               ████    ██
;->             ████  ████████
;->           ████    ██      ██
;->         ████  ████████  ██████
;->       ████    ██        ██    ██
;->     ████  ████████    ████████████
;->   ████    ██      ██████          ██
;-> ████  ████████  ████    ██      ██████

Proviamo con altre regole.

Regola 54:

(setq r54 '( ((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 1) ((1 0 0) 1)
             ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0) ))

(print-matrix (ace r54 18) "  " "██")
;->                                   ██
;->                                 ██████
;->                               ██      ██
;->                             ██████  ██████
;->                           ██      ██      ██
;->                         ██████  ██████  ██████
;->                       ██      ██      ██      ██
;->                     ██████  ██████  ██████  ██████
;->                   ██      ██      ██      ██      ██
;->                 ██████  ██████  ██████  ██████  ██████
;->               ██      ██      ██      ██      ██      ██
;->             ██████  ██████  ██████  ██████  ██████  ██████
;->           ██      ██      ██      ██      ██      ██      ██
;->         ██████  ██████  ██████  ██████  ██████  ██████  ██████
;->       ██      ██      ██      ██      ██      ██      ██      ██
;->     ██████  ██████  ██████  ██████  ██████  ██████  ██████  ██████
;->   ██      ██      ██      ██      ██      ██      ██      ██      ██
;-> ██████  ██████  ██████  ██████  ██████  ██████  ██████  ██████  ██████

Regola 60:

(setq r60 '( ((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 1) ((1 0 0) 1)
             ((0 1 1) 1) ((0 1 0) 1) ((0 0 1) 0) ((0 0 0) 0) ))

(print-matrix (ace r60 16) "  " "██")
;->                               ██
;->                               ████
;->                               ██  ██
;->                               ████████
;->                               ██      ██
;->                               ████    ████
;->                               ██  ██  ██  ██
;->                               ████████████████
;->                               ██              ██
;->                               ████            ████
;->                               ██  ██          ██  ██
;->                               ████████        ████████
;->                               ██      ██      ██      ██
;->                               ████    ████    ████    ████
;->                               ██  ██  ██  ██  ██  ██  ██  ██
;->                               ████████████████████████████████

Regola 62:

(setq r62 '( ((1 1 1) 0) ((1 1 0) 0) ((1 0 1) 1) ((1 0 0) 1)
             ((0 1 1) 1) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0) ))

(print-matrix (ace r62 16) "  " "██")
;->                               ██
;->                             ██████
;->                           ████    ██
;->                         ████  ████████
;->                       ████  ████      ██
;->                     ████  ████  ██  ██████
;->                   ████  ████  ████████    ██
;->                 ████  ████  ████      ████████
;->               ████  ████  ████  ██  ████      ██
;->             ████  ████  ████  ████████  ██  ██████
;->           ████  ████  ████  ████      ████████    ██
;->         ████  ████  ████  ████  ██  ████      ████████
;->       ████  ████  ████  ████  ████████  ██  ████      ██
;->     ████  ████  ████  ████  ████      ████████  ██  ██████
;->   ████  ████  ████  ████  ████  ██  ████      ████████    ██
;-> ████  ████  ████  ████  ████  ████████  ██  ████      ████████

Regola 126:

(setq r126 '( ((1 1 1) 0) ((1 1 0) 1) ((1 0 1) 1) ((1 0 0) 1)
  ((0 1 1) 1) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0) ))

(print-matrix (ace r126 16) "  " "██")
;->                               ██
;->                             ██████
;->                           ████  ████
;->                         ██████████████
;->                       ████          ████
;->                     ████████      ████████
;->                   ████    ████  ████    ████
;->                 ██████████████████████████████
;->               ████                          ████
;->             ████████                      ████████
;->           ████    ████                  ████    ████
;->         ████████████████              ████████████████
;->       ████            ████          ████            ████
;->     ████████        ████████      ████████        ████████
;->   ████    ████    ████    ████  ████    ████    ████    ████
;-> ██████████████████████████████████████████████████████████████


Regola 150:

(setq r150 '( ((1 1 1) 1) ((1 1 0) 0) ((1 0 1) 0) ((1 0 0) 1)
              ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0) ))

(print-matrix (ace r150 16) "  " "██")
;->                               ██
;->                             ██████
;->                           ██  ██  ██
;->                         ████  ██  ████
;->                       ██      ██      ██
;->                     ██████  ██████  ██████
;->                   ██  ██      ██      ██  ██
;->                 ████  ████  ██████  ████  ████
;->               ██              ██              ██
;->             ██████          ██████          ██████
;->           ██  ██  ██      ██  ██  ██      ██  ██  ██
;->         ████  ██  ████  ████  ██  ████  ████  ██  ████
;->       ██      ██              ██              ██      ██
;->     ██████  ██████          ██████          ██████  ██████
;->   ██  ██      ██  ██      ██  ██  ██      ██  ██      ██  ██
;-> ████  ████  ████  ████  ████  ██  ████  ████  ████  ████  ████

Regola 182:

(setq r182 '( ((1 1 1) 1) ((1 1 0) 0) ((1 0 1) 1) ((1 0 0) 1)
              ((0 1 1) 0) ((0 1 0) 1) ((0 0 1) 1) ((0 0 0) 0) ))

(print-matrix (ace r182 16) "  " "██")
;->                               ██
;->                             ██████
;->                           ██  ██  ██
;->                         ██████████████
;->                       ██  ██████████  ██
;->                     ██████  ██████  ██████
;->                   ██  ██  ██  ██  ██  ██  ██
;->                 ██████████████████████████████
;->               ██  ██████████████████████████  ██
;->             ██████  ██████████████████████  ██████
;->           ██  ██  ██  ██████████████████  ██  ██  ██
;->         ██████████████  ██████████████  ██████████████
;->       ██  ██████████  ██  ██████████  ██  ██████████  ██
;->     ██████  ██████  ██████  ██████  ██████  ██████  ██████
;->   ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██
;-> ██████████████████████████████████████████████████████████████


---------------------------------
Palidromo precedente e successivo
---------------------------------

Dato un numero intero positivo, scrivere una funzione per determinare il numero palindromo successivo e il numero palindromo precedente al numero dato.

Funzione che verifica se un numero è palindromo:

(define (palindromo? num)
  (let (str (string num)) (= str (reverse (copy str)))))

Funzione che verifica se un numero è palindromo (più veloce):

(define (palindromo? num)
  (local (rev val)
    (setq rev 0)
    (setq val num)
    ; crea il numero invertito
    (until (zero? val)
      (setq rev (+ (* rev 10) (% val 10)))
      (setq val (/ val 10))
    )
    (= rev num)))

(define (prev-next-pali num)
  (local (up down found prev next)
    ; ricerca palindromo precedente
    (setq down num)
    (setq found nil)
    (until found
      (cond ((palindromo? down)
              (setq prev down) (setq found true))
            (true (-- down))))
    ; ricerca palindromo successivo
    (setq up num)
    (setq found nil)
    (until found
      (cond ((palindromo? up)
              (setq next up) (setq found true))
            (true (++ up))))
    (list prev next)))

Proviamo:

(prev-next-pali 1234)
;-> (1221 1331)

(prev-next-pali 1112)
;-> (1111 1221)

(prev-next-pali 12334)
;-> (12321 12421)

(prev-next-pali -12334)
;-> (-12421 -12321)

(prev-next-pali 10)
;-> (9 11)

(prev-next-pali 1234567890)
;-> (1234554321 1234664321)

Vedi anche "Palindromo più vicino" su "Note libere 9".


------------------------------------
Funzione per l'input di una password
------------------------------------

Scriviamo una funzione che permette all'utente di inserire una password (come stringa).
Il parametro 'pause' è il tempo di visualizzazione dell'ultimo carattere digitato.

(define (input-pwd pause)
  (local (pwd stop code ch)
    (setq pwd "")
    (setq stop nil)
    (until stop
      ; legge un carattere (codice ascii) da tastiera
      (setq code (read-key))
      (setq ch (char code))
      (cond ((= code 13) ; Invio/Enter (stop input)
             (print "\r" (dup "*" (length pwd)))
             (setq stop true))
            ((= code 8) ; Backspace (delete previous char)
              ; elimina l'ultimo carattere digitato
              (pop pwd -1)
              ; stampa gli asterischi
              (print "\r" (dup " " 80))
              (print "\r" (dup "*" (length pwd))))
            ((and (>= code 32) (<= code 126))
              ; stampa gli asterischi e l'ultimo carattere digitato
              (print "\r" (dup "*" (length pwd)) ch)
              ; tempo di visualizzazione dell'ultimo carattere digitato
              (sleep pause)
              ; aggiorna la password
              (extend pwd (char code))
              ; stampa gli asterischi
              (print "\r" (dup "*" (length pwd))))))
    (println)
    pwd))

Proviamo:

(input-pwd 200)
;-> ******
;-> "123445"


------------------------------
Trasformata di Burrows-Wheeler
------------------------------

La trasformata di Burrows-Wheeler (BWT) è un algoritmo di trasformazione di stringhe che viene utilizzato per la compressione dei dati, (es. algoritmo bzip2).
Non è un algoritmo di compressione vero e proprio, ma riorganizza i dati in modo che risultino più facili da comprimere.

Come funziona la trasformata di Burrows-Wheeler?

Codifica
--------

1) Input: Si parte con una stringa S di lunghezza n, alla quale viene aggiunto un terminatore speciale (di solito un carattere che non appare nella stringa, come "$").

   Esempio: S = "banana", con il terminatore diventa S = "banana$".

2. Rotazioni cicliche: Vengono generate tutte le possibili rotazioni cicliche della stringa S'. Ogni rotazione è semplicemente una permutazione dei caratteri della stringa spostata di una posizione.

   Esempio:
   - banana$
   - anana$b
   - nana$ba
   - ana$ban
   - na$bana
   - a$banan
   - $banana

3. Ordinamento: Le rotazioni cicliche vengono poi ordinate lessicograficamente.

   Esempio:
   - $banana
   - a$banan
   - ana$ban
   - anana$b
   - banana$
   - na$bana
   - nana$ba

4. Estrazione dell'ultima colonna: Viene quindi estratta l'ultima colonna della matrice delle rotazioni ordinate. Questa colonna rappresenta la trasformata di Burrows-Wheeler.

   BWT = "annb$aa"

Questa è la stringa trasformata. L'importanza della BWT sta nel fatto che tende a raggruppare insieme i caratteri ripetuti, rendendo più efficace l'applicazione di algoritmi di compressione come la codifica di Huffman o la codifica run-length.

Il carattere speciale "$" viene comunemente utilizzato come **terminatore** nella trasformata di Burrows-Wheeler e ha un significato specifico nell'ordinamento lessicografico.
Per assicurare che il terminatore sia sempre trattato come l'ultimo carattere rispetto a qualsiasi altra lettera o simbolo della stringa, si assume che "$" sia il più piccolo carattere possibile in questo contesto.
Quindi, rispetto ai caratteri "a", "b" o qualsiasi altro carattere alfabetico o numerico, il carattere "$" viene posizionato prima durante l'ordinamento lessicografico.

In altre parole, l'ordinamento lessicografico segue questa gerarchia:

  "$" < "a" < "b" ... < "z"

Pertanto, "$" viene sempre posizionato prima di qualsiasi altro carattere durante la fase di ordinamento delle rotazioni cicliche nella Burrows-Wheeler Transform, garantendo che occupi la prima posizione nelle rotazioni ordinate.

Nota: possiamo anche utilizzare "~" come terminatore: "a" < "b" ... < "z" < "~".

Decodifica
----------
La trasformata è reversibile. Utilizzando la stringa trasformata e l'informazione che essa contiene, è possibile ricostruire la stringa originale.

Partendo dalla seguente stringa (risultato della codifica di "banana"):

  BWT = "annb$aa"

Il carattere speciale "$" indica la fine della stringa originale.

1) Costruzione della Prima Colonna:
L'ordinamento lessicografico della stringa trasformata rappresenta la prima colonna delle rotazioni cicliche della stringa originale.
- Prendiamo la stringa BWT e la ordiniamo per ottenere la Prima Colonna (la colonna delle rotazioni ordinate):

  Prima Colonna = "$aaannb"

2. Ricostruzione delle righe: A partire dalla BWT e dalla Prima Colonna, possiamo ricostruire progressivamente le righe della matrice delle rotazioni. Ogni colonna aggiuntiva può essere ricostruita unendo progressivamente la BWT e la Prima Colonna, poiché entrambe contengono tutte le informazioni necessarie.

   - Prima iterazione: Prendiamo la BWT e la affianchiamo alla Prima Colonna.

     | BWT  | Prima Colonna |
     |------|---------------|
     | a    | $             |
     | n    | a             |
     | n    | a             |
     | b    | a             |
     | $    | n             |
     | a    | n             |
     | a    | b             |

     Questa è una parte della matrice che stiamo ricostruendo. La riga contenente il simbolo `"$"` è la rotazione corretta della stringa originale.

   - Seconda iterazione: Ordiniamo le righe secondo la loro **prima colonna** per generare la matrice ordinata:

     | Prima Colonna | Nuova Colonna (BWT) |
     |---------------|---------------------|
     | $             | a                   |
     | a             | n                   |
     | a             | n                   |
     | a             | b                   |
     | n             | $                   |
     | n             | a                   |
     | b             | a                   |

   - Ripetiamo il processo: Ogni volta che aggiungiamo una nuova colonna e riordiniamo le righe secondo la Prima Colonna, ci avviciniamo sempre di più alla matrice completa delle rotazioni cicliche.

3) Individuazione della stringa originale: Alla fine, avremo ricostruito completamente tutte le righe delle rotazioni cicliche. La riga che termina con il carattere speciale `"$"` corrisponde alla stringa originale.

   - Risultato finale: la stringa originale è "banana".

Vediamo due funzioni (molto inefficienti) per la codifica e la decodifica BWT.

Funzione BWT di codifica:

(define (encode str eos)
  (let (out '())
    (extend str eos)
    (for (i 0 (- (length str) 1))
      (setq str (rotate str))
      (push str out)
    )
    ;(println out)
    ;(println (sort out))
    (join (map last (sort out)))))

(encode "banana" "$")
;-> "annb$aa"
(encode "banana" "~")
;-> "bnn~aaa"

Funzione BWT di decodifica:

(define (decode str eos)
  (local (base lst)
    (setq base (explode str))
    (setq lst base)
    (for (i 1 (- (length str) 1))
      (sort lst)
      (setq lst (map string base lst))
    )
    ; estra la stringa che termina con delim
    (slice (first (filter (fn(x) (= eos (last x))) lst)) 0 -1)))

Proviamo:

(decode (encode "banana" "$") "$")
;-> "banana"
(decode (encode "banana" "~") "~")
;-> "banana"

(decode (encode "trasformata di Burrows-Wheeler" "~") "~")
;-> "trasformata di Burrows-Wheeler"
(decode (encode "trasformata di Burrows-Wheeler" "$") "$")
;-> "trasformata di Burrows-Wheeler"


-----------------------------------
Consigli sparsi sul Problem Solving
-----------------------------------

Consiglio 1: "Scomposizione del problema"
Proviamo a scomporre il problema in sottoproblemi.
Come risolviamo i sottoproblemi?
Come mettiamo insieme i sotto-risultati per formare la soluzione?

Consiglio 2: "Problemi analoghi"
Proviamo a ricordare alcuni problemi simili che abbiamo risolto.
Molti problemi non hanno un'idea completamente nuova.
Quindi potremmo usare la nostra esperienza di risoluzione di un problema simile per risolvere questo.

Consiglio 3: "Dallo specifico al generale"
Se non sappiamo risolvere un problema complesso, possiamo semplificarlo e cercare le soluzioni della versione semplificata.
Proviamo a risolvere altri casi specifici e poi proviamo a generalizzarli per trovare la soluzione del problema principale.
Cerchiamo una soluzione specifica/particolare al problema, cioè una soluzione con alcuni vincoli del problema 'rilassati'.

Consiglio 4: "Intuito personale"
Possiamo attingere al nostro intuito personale.
Se abbiamo elaborato una precisa ipotesi in testa, proviamo a dimostrarla.
Potrebbe funzionare bene o darci un'idea di come confutarla.
Controlliamo l'ipotesi su una ampia serie di test, prima di effettuare l'implementazione finale.

Consiglio 5: "Pensare insieme"
Discutiamo il problema con altre persone.
Ragionare su idee diverse aiuta nella comprensione del problema e nella ricerca di una soluzione.
Proviamo a cercere informazioni sul problema su Internet:
https://www.google.com/
https://stackexchange.com/sites
https://www.geeksforgeeks.org/
https://oeis.org
Oggi possiamo anche chiedere aiuto alle varie AI presenti sul web (ChatGPT, Claude, ecc.).

Consiglio 6: "Quale algoritmo?"
Proviamo a pensare agli algoritmi o metodi conosciuti che possono essere applicati al problema in qualsiasi modo.
Per ogni algoritmo/metodo scelto proviamo a pensare alla soluzione supponendo che il problema venga risolto usando questo metodo.

Consiglio 7: "Prototipi delle idee"
Proviamo a scrivere codice per fare un prototipo che ci permetta di verificare le nostre ipotesi di soluzione e/o analizzare gli schemi di input/output del problema.
Stampare e studiare tutti i risultati.


------------------------------
Fibonacci: formule e proprietà
------------------------------

Formula di Fibonacci:

  F(n) = F(n-1) + F(n-2)

Versione ricorsiva:

(define (fibonacci n)
        (if (= n 0) 0
            (< n 2) 1
            (+  (fibonacci (- n 1)) (fibonacci (- n 2)))))

(fibonacci 3)
;-> 2
(map fibonacci (sequence 0 20))
;-> (0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765)

Versione memoized:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(memoize fibo-mem
    (lambda (n)
        (if (= n 0) 0
            (< n 2) 1
            (+  (fibo-mem (- n 1)) (fibo-mem (- n 2))))))

(fibo-mem 3)
;-> 2
(map fibo-mem (sequence 0 20))
;-> (0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765)

Versione iterativa:

(define (fibo-i num)
"Calculates the Fibonacci number of an integer number"
  (if (zero? num) 0L
  ;else
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 (- num 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a)))

(fibo-i 3)
;-> 2L
(map fibo-i (sequence 0 20))
;-> (0L 1L 1L 2L 3L 5L 8L 13L 21L 34L 55L 89L 144L 233L 377L 610L
;->  987L 1597L 2584L 4181L 6765L)

Versione Dynamic Programming (bottom up)

(define (fiboDP n)
  (cond ((zero? n) 0)
        ((= n 1) 1)
        (true
          (setq dp (array (+ n 1) '(0)))
          (setq (dp 0) 0)
          (setq (dp 1) 1)
          (for (i 2 n)
            (setq val (+ (dp (- i 2)) (dp (- i 1))))
            (setf (dp i) val)
          )
          (dp n))))

(fiboDP 3)
;-> 2
(map fiboDP (sequence 0 20))
;-> (0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765)
(fiboDP 10)
;-> 55
dp
;-> (0 1 1 2 3 5 8 13 21 34 55)

Fibonacci (Lutz):

(define (fibo-lutz num)
  (let ( (out '(0L 1L)) (x 1L) )
    (extend out (series x (fn (y) (+ x (swap y x))) (- num 1)))))

(map fibo-lutz (sequence 0 20))
;-> (0L 1L 1L 2L 3L 5L 8L 13L 21L 34L 55L 89L 144L 233L 377L 610L
;->  987L 1597L 2584L 4181L 6765L))

Formula di Binet:

  F(n) = (phi^n - psi^n)/sqrt(5)
         dove: phi = (1 + sqrt(5))/2, (sezione aurea - golden ratio)
               psi = (1 - sqrt(5))/2

(define (fibo n)
  (setq sr (sqrt 5))
  (setq phi (div (add 1 sr) 2))
  (setq psi (div (sub 1 sr) 2))
  (floor (add 0.5 (div (sub (pow phi n) (pow psi n)) sr))))

(fibo 3)
;-> 2
(setq ff (map fibo (sequence 0 20)))
;-> (0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765)

Verifica se un dato numero intero è un numero di Fibonacci:

Un numero n è un numero di Fibonacci se e solo se (5*n^2 + 4) oppure (5*n^2 - 4) è un quadrato perfetto.

(define (square? num)
"Check if an integer is a perfect square"
  (local (a)
    (setq a (bigint num))
    (while (> (* a a) num)
      (setq a (/ (+ a (/ num a)) 2))
    )
    (= (* a a) num)))

(define (fibo? n)
  (let (tmp (* 5 n n))
    (or (square? (- tmp 4)) (square? (+ tmp 4)))))

(filter fibo? (sequence 1 10000))
;-> (1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765)

Indice di un numero di Fibonacci:

  n = floor(log(phi) / log(F*sqrt(5) + (1/2)))

(define (n-fibo fib) (floor (div (log (add (mul fib sr) 0.5)) (log phi))))

(n-fibo 6765)
;-> 20

Somma dei primi n numeri di Fibonacci:

  Sum[i..0 n]F(i) = F(n+2) - 1

(define (sum-fib-to n) (- (fibo (+ n 2)) 1))

(sum-fib-to 10)
;-> 143
(apply + (slice ff 1 10))
;-> 143
(apply + (slice ff 0 11))
;-> 143

Fibonacci coprimi:

I numeri di Fibonacci F(n) e F(n+1) sono coprimi tra loro:

  gcd(F(n), F(n+1)) = 1

Sezione aurea:

   lim F(n+1)/F(n) = phi = (1 + sqrt(5))/2
  n->inf

(div (add 1 (sqrt 5)) 2)
;-> 1.618033988749895

(div (fibo-i 22) (fibo-i 21))
;-> 1.618033985017358
(div (fibo-i 51) (fibo-i 50))
;-> 1.618033988749895

Rettangolo aureo:

  L : l = l : (L - l)
  dove L = lato maggiore,
       l = lato minore

Affiancando (alternativamente prima sotto e poi a destra) in successione tanti quadrati aventi per lato i numeri della serie di Fibonacci si ottiene un rettangolo aureo.
Per esempio:

  1 1 3 3 3 8 8 8 8 8 8 8 8
  2 2 3 3 3 8 8 8 8 8 8 8 8
  2 2 3 3 3 8 8 8 8 8 8 8 8
  5 5 5 5 5 8 8 8 8 8 8 8 8
  5 5 5 5 5 8 8 8 8 8 8 8 8
  5 5 5 5 5 8 8 8 8 8 8 8 8
  5 5 5 5 5 8 8 8 8 8 8 8 8
  5 5 5 5 5 8 8 8 8 8 8 8 8

Massimo Comun Divisore:

Per i numeri di Fibonacci vale la seguente identità (teorema di Vorob'ev).:

 GCD(F(n), F(m)) = GCD(n, m)
 (teorema di Vorob'ev).

Quindi F(n) è divisibile per F(m) se e solo se n è divisibile per m.


------------------
Incontro tra treni
------------------

Questo è un problema di fisica per la scuola media.
Due treni partono da stazioni diverse (A e B) e si dirigono uno verso l'altro.
Si incontrerano ad un certo punto (X) del percorso (che è rettilineo).
Data la distanza tra le due stazioni (S) e le velocità dei due treni (v1 e v2), determinare quanta strada percorrono i treni prima di incontrarsi (segmenti a e b).

  v1                             v2
  --->                       <-----
  |-----------|-------------------|
  A     a     X         b         B
  <------------------------------->
                 S

Dalle equazioni del moto rettilineo uniforme (spazio = velocità * tempo)::

  a = v1*t1   (1)
  b = v2*t2   (2)

Inoltre risulta:

  S = a + b   (3)

Sommiamo (1) e (2) e poi sostituiamo in (3):

  a + b = v1*t1 + v2*t2
  S = a + b = v1*t1 + v2*t2

Nel punto X si avrà t1 = t2:

  S = v1*t1 + v2*t2 = v1*t + v2*t = (v1 + v2)*t

Quindi i treni si incontreranno nel punto X dopo un tempo t pari a:

  t = S/(v1 + v2)

Con il tempo t il primo treno percorre:

  a = v1*t = v1*S/(v1 + v2)

Con il tempo t il secondo treno percorre:

  b = v2*t = v2*S/(v1 + v2)

(define (incontro distanza vel1 vel2)
  (let (t (div distanza (add vel1 vel2)))
    (list (mul vel1 t) (mul vel2 t))))

Proviamo:

(incontro 100 30 50)
;-> (37.5 62.5)

(incontro 100 10 10)
;-> (50 50)


---------------
Tassi di cambio
---------------

In parole semplici, il mercato dei cambi è un luogo dove ogni persona propone di vendere/scambiare una certa valuta per un altra. Ognuno è libero di proporre un "tasso di cambio" arbitrario (che comunque sono autoregolati dalla legge della domanda e dell'offerta).
In questo modo i tassi di cambio sono scarsamente prevedibili e sono sensibili alle condizioni politiche ed economiche che sono in continuo cambiamento.
Normalmente, se una valuta viene cambiata con un'altra una parte di denaro viene persa perché i tassi di cambio in due direzioni (ad esempio USD -> EUR e EUR -> USD) non si compensano a vicenda.
Per esempio:

(define (usd-eur usd) (mul usd 1.1))
(define (eur-usd eur) (mul eur 0.9))

Cambiare 100 dollari in 90 euro e poi tornare indietro ci dà solo 99 dollari.
100 $
(eur-usd (usd-eur 100))
;-> 99 $

Cambiare 100 euro in 110 dollari e poi tornare indietro ci dà solo 99 euro.
100 Euro
(usd-eur (eur-usd 100))
;-> 99 euro

Sembra una frode, ma può essere considerata come una specie di commissione.

Tuttavia, se i prezzi non sono coordinati, sono possibili situazioni di "arbitraggio".
Per esempio, se abbiamo i seguenti tassi di cambio:

  1 Dollaro Usa viene venduto per 130 Yen Japanese
  1 Yen Japanese viene venduto per 0.7 Euro
  1 Euro viene venduto per 1.1 Dollaro Usa

Possiamo operare le seguenti transazioni:

  Con 100 Dollari compriamo 13000 Yen.
  Con 13000 Yen compriamo 91 Euro.
  Com 91 Euro compriamo 100.1 Dollari.

Abbiamo guadagnato 0.1 Dollari (10 cent).

Nota: questo metodo è difficilmente praticabile in pratica. Infatti occorre individuare velocemente la condizione di "arbitraggio" e effettuare rapidamente tutte le operazioni di cambio (sperando che nel frattempo tutti i tassi dei cambi coinvolti rimangano costanti).

Problema:
Data una lista di tassi di cambio, determinare se esiste qualche tipo di "arbitraggio".

lista = (("valuta1" "valuta2" tasso1) ... ("valutaN-1" "valutaN" tassoN-1)

(setq lst '(("USD" "JPY" 130.000)
            ("USD" "EUR" 0.90000)
            ("JPY" "EUR" 0.00700)
            ("JPY" "USD" 0.00720)
            ("EUR" "USD" 1.10000)
            ("EUR" "JPY" 140.000)))

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

Algoritmo:

(setq currency (unique (flat (map (fn(x) (list (x 0) (x 1))) lst))))
;-> ("USD" "JPY" "EUR")

(setq permute (perm currency))
;-> (("USD" "JPY" "EUR") ("JPY" "USD" "EUR")
;->  ("EUR" "USD" "JPY") ("USD" "EUR" "JPY")
;->  ("JPY" "EUR" "USD") ("EUR" "JPY" "USD"))

(find '("EUR" "USD" ?) lst match)
;-> 4
$0
;-> ("EUR" "USD" 1.1)
($0 2)
;-> 1.1
(find (list "EUR" "USD" '?) lst match)
;-> 4

(setq all '())
(dolist (perm permute)
  ; aggiunge il primo elemento in fondo all permutazione corrente
  (setq cur (push (perm 0) perm -1))
  (setq len (length cur))
  ; investimento iniziale
  (setq change 100)
  ; ciclo per ogni valuta della permutazione corrente
  (for (k 0 (- len 2))
    ; valuta 1
    (setq c1 (cur k))
    ; valuta 2
    (setq c2 (cur (+ k 1)))
    ; ricerca tasso di scambio tra valuta1 e valuta2
    (find (list c1 c2 '?) lst match)
    (setq rate ($0 2))
    ; applicazione del tasso di scambio
    (setq change (mul change rate))
    (println c1 { } c2 { } rate { } change)
  )
  ; aggiunge la transazione corrente alla lista soluzione
  (push (push change cur) all)
)
; ordina la lista soluzione
(sort all)

Funzione finale:

(define (arbitro lst)
  (local (currency permute all cur len change c1 c2 rate)
    (setq currency (unique (flat (map (fn(x) (list (x 0) (x 1))) lst))))
    (setq permute (perm currency))
    (setq all '())
    (dolist (p permute)
      ; aggiunge il primo elemento in fondo all permutazione corrente
      (setq cur (push (p 0) p -1))
      (setq len (length cur))
      ; investimento iniziale
      (setq change 100)
      ; ciclo per ogni valuta della permutazione corrente
      (for (k 0 (- len 2))
        ; valuta 1
        (setq c1 (cur k))
        ; valuta 2
        (setq c2 (cur (+ k 1)))
        ; ricerca tasso di scambio tra valuta1 e valuta2
        (find (list c1 c2 '?) lst match)
        (setq rate ($0 2))
        ; applicazione del tasso di scambio
        (setq change (mul change rate))
        ;(println c1 { } c2 { } rate { } change)
      )
      ; aggiunge la transazione corrente alla lista soluzione
      (push (push change cur) all)
    )
    ; ordina la lista soluzione
    (sort all)))

Proviamo:

(arbitro lst)
;-> ((90.72 "EUR" "JPY" "USD" "EUR")
;->  (90.72 "JPY" "USD" "EUR" "JPY")
;->  (90.72 "USD" "EUR" "JPY" "USD")
;->  (100.1 "EUR" "USD" "JPY" "EUR")
;->  (100.1 "USD" "JPY" "EUR" "USD")
;->  (100.1 "JPY" "EUR" "USD" "JPY"))

(setq rates '(("USD" "JPY" 140.000)
              ("USD" "EUR" 0.90000)
              ("JPY" "EUR" 0.006549)
              ("JPY" "USD" 0.00714)
              ("EUR" "USD" 1.1)
              ("EUR" "JPY" 154.000)))

(arbitro rates)
;-> ((98.96039999999999 "EUR" "JPY" "USD" "EUR")
;->  (98.96039999999999 "JPY" "USD" "EUR" "JPY")
;->  (98.96039999999999 "USD" "EUR" "JPY" "USD")
;->  (100.8546 "JPY" "EUR" "USD" "JPY")
;->  (100.8546 "EUR" "USD" "JPY" "EUR")
;->  (100.8546 "USD" "JPY" "EUR" "USD"))

(setq rates '(("USD" "EUR" 0.90000)
              ("EUR" "USD" 1.10000)))

(arbitro rates)
;-> ((99.00000000000001 "EUR" "USD" "EUR")
;->  (99.00000000000001 "USD" "EUR" "USD"))

(setq rates '(("USD" "JPY" 1)
            ("USD" "EUR" 1)
            ("JPY" "EUR" 1)
            ("JPY" "USD" 1)
            ("EUR" "USD" 1)
            ("EUR" "JPY" 1)))

(arbitro rates)
;-> ((100 "EUR" "JPY" "USD" "EUR")
;->  (100 "EUR" "USD" "JPY" "EUR")
;->  (100 "JPY" "EUR" "USD" "JPY")
;->  (100 "JPY" "USD" "EUR" "JPY")
;->  (100 "USD" "EUR" "JPY" "USD")
;->  (100 "USD" "JPY" "EUR" "USD"))


--------------
Cifre speciali
--------------

Una cifra di un numero intero viene definita speciale quando risulta uno dei casi seguenti:
1) Cifra speciale minore
   La cifra è più piccola di ciascuna delle sue due cifre adiacenti (sx e dx)
2) Cifra speciale maggiore
   La cifra è più grande di ciascuna delle sue due cifre adiacenti (sx e dx)

La prima e l'ultima cifra del numero intero utilizzano le cifre adiacenti considerando il numero circolare.

Per calcolare il valore speciale di un numero intero poniamo:
  cifra speciale minore = 1
  cifra speciale maggiore = 2

Esempio:

  numero = 16498124
 sx c dx   valore
  4 1 6 --> 2
  1 6 4 --> 2
  6 4 9 --> 1
  4 9 8 --> 2
  9 8 1 --> 0
  8 1 2 --> 0
  2 4 1 --> 2
  valore speciale totale = 9

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (special num)
  (local (val digits len)
    (setq val 0)
    (setq digits (int-list num))
    (setq len (length digits))
    ; calcolo valore della prima cifra
    (cond ((and (> (digits 0) (digits 1)) (> (digits 0) (digits -1)))
          (++ val 2))
          ((and (< (digits 0) (digits 1)) (< (digits 0) (digits -1)))
          (++ val)))
    ; ciclo per le cifre dalla seconda (1) alla penultima (len - 2)
    (for (i 1 (- len 2))
      (cond ((and (> (digits i) (digits (- i 1))) (> (digits i) (digits (+ i 1))))
            (++ val 2))
            ((and (< (digits i) (digits (- i 1))) (< (digits i) (digits (+ i 1))))
            (++ val))))
    ; calcolo valore dell'ultima cifra
    (cond ((and (> (digits -1) (digits -2)) (> (digits -1) (digits 0)))
          (++ val 2))
          ((and (< (digits -1) (digits -2)) (< (digits -1) (digits 0)))
          (++ val)))
    val))

Proviamo:

(special 16498124)
;-> 9

(special 123456789)
;-> 3

(special 213546879)
;-> 9

Con un numero da N cifre (con N > 2) il valore speciale massimo vale 3 * (N/2).

(apply max (map special (sequence 100 999)))
;-> 3
(apply max (map special (sequence 1000 9999)))
;-> 6
(apply max (map special (sequence 10000 99999)))
;-> 6
(apply max (map special (sequence 100000 999999)))
;-> 9
(apply max (map special (sequence 1000000 9999999)))
;-> 9
(time (println (apply max (map special (sequence 10000000 99999999)))))


-------------------
Stampe in parallelo
-------------------

Abbiamo due stampanti, la prima produce una pagina ogni X secondi, mentre la seconda produce una pagina ogni Y secondi.
Utilizzando le stampanti in contemporanea, quanto tempo occorre per stampare N pagine?

Bisogna trasformare le capacità di lavoro rispetto all'unità di tempo (secondo):

1 pagina ogni X secondi --> ogni secondo 1/X pagine
1 pagina ogni Y secondi --> ogni secondo 1/Y pagine

In totale, per ogni secondo, stampiamo 1/X + 1/Y pagine.

Quindi per stampare N pagine occorrono:

            N             X*Y
  S = ------------- = N*------- secondi
       (1/X + 1/Y)       X + Y

Se il valore di S è un numero intero, allora il risultato è corretto.

Se il valore di S è un numero a virgola mobile, allora dobbiamo considerare che almeno una stampante (ma potrebbero essere entrambe) deve terminare la stampa dell'ultima pagina.

In questo caso ultimo dobbiamo considerare il rapporto tra il numero di pagine N e i valori di X e Y:
1) se X divide non divide esattamente N, allora aggiungiamo 1 al risultato
2) se Y divide non divide esattamente N, allora aggiungiamo 1 al risultato
3) se X e Y dividono esattamente N, allora aggiungiamo 1 al risultato
Infine bisogna prendere la parete intera del risultato.

(define (int? num) (= (int num) num))

(define (tempo pagine s1 s2)
  (setq s (div (mul pagine s1 s2) (add s1 s2)))
  (cond ((int? s) s)
        (true
          (if (not (int? (div pagine s1))) (setq s (add s 1)))
          (if (not (int? (div pagine s2))) (setq s (add s 1)))
          (if (and (int? (div pagine s1)) (int? (div pagine s2)))
              (setq s (add s 1)))
          (int s))))

Proviamo:

(tempo 7 1 1)
;-> 4

(tempo 5 4 6)
;-> 12

(tempo 4 5 3)
;-> 9

(tempo 800 3 4)
;-> 1372

Nota: il ragionamento può essere esteso al caso di M stampanti.


---------------------------------
Generatore casuale di Von Neumann
---------------------------------

Vediamo uno dei primi metodi per produrre sequenze di numeri apparentemente indipendenti (pseudocasuali) proposto da Von Neumann:

1) Scegliere un valore iniziale con 4 cifre (ad esempio nell'intervallo 0000 ... 9999).
2) Moltiplicarlo per se stesso per ottenere un valore composto da 8 cifre (aggiungere zeri iniziali se necessario).
3) Troncare le prime due e le ultime cifre di questo valore.
4) Il nuovo valore conterrà 4 cifre ed è il valore successivo di una sequenza.
5) Per ottenere più valori, ripeti dal passaggio 2.

(define (neumann base)
  (let (tmp (string (* base base)))
    (setq tmp (string (dup "0" (- 8 (length tmp))) tmp))
    (int (slice tmp 2 4) 0 10)))

Proviamo:

(neumann 5761)
;-> 1891
(neumann 1891)
;-> 5751

Una delle caratteristiche per valutare gli algoritmi casuali è quella di misurare quanti numeri casuali possiamo generare prima di entrare un ciclo (cioè creare un numero esistente).

Vediamo quali sono i cicli di tutti i numeri da 1000 a 999 del generatore di Neumann:

(define (cicli-neumann)
  (local (out cur k)
    (setq out '())
    (for (num 1000 9999)
      (setq cur '())
      (setq k num)
      (until (ref k cur)
        (push k cur -1)
        (setq k (neumann k))
      )
      (push k cur -1)
      (push (list (length cur) num cur) out -1)
    )
    (sort out)))

Proviamo:

(silent (setq res (cicli-neumann)))

Cicli più brevi:
(slice res 0 3)
;-> ((2 2500 (2500 2500)) (2 3792 (3792 3792)) (2 7600 (7600 7600)))

Cicli più lunghi:
(slice res -3)
;-> ((111 4655 (4655 6690 7561 1687 8459 5546 7581 4715 2312 3453 9232
;->    2298 2808 8848 2871 2426 8854 3933 4684 9398 3224 3941 5314 2385
;->    6882 3619 971 9428 8871 6946 2469 959 9196 5664 808 6528 6147 7856
;->    7167 3658 3809 5084 8470 7409 8932 7806 9336 1608 5856 2927 5673
;->    1829 3452 9163 9605 2560 5536 6472 8867 6236 8876 7833 3558 6593
;->    4676 8649 8052 8347 6724 2121 4986 8601 9772 4919 1965 8612 1665
;->    7722 6292 5892 7156 2083 3388 4785 8962 3174 742 5505 3050 3025
;->    1506 2680 1824 3269 6863 1007 140 196 384 1474 1726 9790 8441 2504
;->    2700 2900 4100 8100 6100 2100 4100))
;->  (111 9251 (9251 5810 7561 1687 8459 5546 7581 4715 2312 3453 9232
;->    2298 2808 8848 2871 2426 8854 3933 4684 9398 3224 3941 5314 2385
;->    6882 3619 971 9428 8871 6946 2469 959 9196 5664 808 6528 6147 7856
;->    7167 3658 3809 5084 8470 7409 8932 7806 9336 1608 5856 2927 5673
;->    1829 3452 9163 9605 2560 5536 6472 8867 6236 8876 7833 3558 6593
;->    4676 8649 8052 8347 6724 2121 4986 8601 9772 4919 1965 8612 1665
;->    7722 6292 5892 7156 2083 3388 4785 8962 3174 742 5505 3050 3025
;->    1506 2680 1824 3269 6863 1007 140 196 384 1474 1726 9790 8441 2504
;->    2700 2900 4100 8100 6100 2100 4100))
;->  (112 6239 (6239 9251 5810 7561 1687 8459 5546 7581 4715 2312 3453
;->    9232 2298 2808 8848 2871 2426 8854 3933 4684 9398 3224 3941 5314
;->    2385 6882 3619 971 9428 8871 6946 2469 959 9196 5664 808 6528 6147
;->    7856 7167 3658 3809 5084 8470 7409 8932 7806 9336 1608 5856 2927
;->    5673 1829 3452 9163 9605 2560 5536 6472 8867 6236 8876 7833 3558
;->    6593 4676 8649 8052 8347 6724 2121 4986 8601 9772 4919 1965 8612
;->    1665 7722 6292 5892 7156 2083 3388 4785 8962 3174 742 5505 3050
;->    3025 1506 2680 1824 3269 6863 1007 140 196 384 1474 1726 9790 8441
;->    2504 2700 2900 4100 8100 6100 2100 4100)))

Vedi anche "Generatore di numeri casuali" su "Note libere 1".
Vedi anche "Il metodo middle-square per generare numeri casuali" su "Note libere 22".
Vedi anche "Generatore casuale di Engel" su "Note libere 26".
Vedi anche "Generatore casuale LCG (Linear Congruential Generator)" su "Note libere 26".

---------------------------
Generatore casuale di Engel
---------------------------

Nel libro "Elementarmathematik vom algorithmischen Standpunkt" del 1977 ("Matematica elementare dal punto di vista algoritmico", 1984) di A. Engel, troviamo la descrizione di un semplice algoritmo per la generazione di numeri casuali:

  X = frac((X + 3.1415926535897931)^8)

Ovvero per il valore casuale corrente X troviamo il successivo aggiungendo pi greco, elevandolo all'ottava potenza e scartando la parte intera (quindi rimane solo la frazione nell'intervallo [0 .. 1)).
(Potremmo usare un altro valore al posto di pi greco)

Questa sequenza ha cicli più lunghi della sequenza di Neumann, ma queste sequenza hanno una distribuzione uniforme?

(define (engel num)
  (pow (add num 3.1415926535897931) 8)
)

(engel 0.123456789)

Vedi anche "Generatore di numeri casuali" su "Note libere 1".
Vedi anche "Il metodo middle-square per generare numeri casuali" su "Note libere 22".
Vedi anche "Generatore casuale di Neumann" su "Note libere 26".
Vedi anche "Generatore casuale LCG (Linear Congruential Generator)" su "Note libere 26".


---------------------------------------------------------------------------
Generatore casuale LCG (Linear Congruential Generator)
---------------------------------------------------------------------------

Il metodo LCG viene utilizzato da molti linguaggi di programmazione e librerie per produrre numeri casuali.
Si basa su una semplice formula che genera il valore casuale successivo partendo da un valore casuale corrente:

  Xsucc = (A * Xcorr + C) % M

Poiché il risultato viene calcolato con modulo M, tutti i membri sono nell'intervallo 0 ... M - 1.
Inoltre, poiché il numero successivo dipende solo da quello corrente, il periodo non può essere maggiore di M.
Tuttavia, non tutte le scelte di costanti producono la sequenza con periodo completo.
Le seguenti condizioni devono essere soddisfatte per una buona scelta:

  1) C e M non hanno divisori comuni diversi da 1.
  2) A - 1 è divisibile per tutti i fattori primi di M.
  3) Se M è un multiplo di 4, allora anche A - 1 deve esserlo.

Queste regole ci conducono all seguente scelta delle costanti:
  - sia M = 2 ^ K con un intero K >= 2
  - allora A = 4 * J + 1 con un intero J >= 1
  - e C = 2 * L - 1 con un intero L >= 1 che è un numero pari.

Qualsiasi altro insieme di regole può essere creato in modo simile:
  - sia M = 3 ^ K;
  - allora A = 3 * J + 1
  - e C = 3 * L - 1.

(define (lcg xcurr A C M) (% (+ (* A xcurr) C) M))

Proviamo:

  K = 16 --> M = 2^16 = 65536
  J = 5  --> A = (4 * 5) + 1 = 21
  L = 4  --> C = (3 * 2) - 1 = 5
  xcurr = 6

(lcg 6 5 21 65536)
;-> 51
(lcg 51 5 21 65536)
;-> 276

Vediamo quanto è lungo il ciclo di questo generatore:

(define (ciclo-lcg xcurr A C M)
  (local (out cur k)
    (setq out '())
    (setq k xcurr)
    (until (ref k out)
        (push k out -1)
        (setq k (lcg k A C M))
    )
    (push k out -1)))

(length (setq rnd (ciclo-lcg 6 5 21 65536)))
;-> 65537

L'ultimo numero è uguale al primo:

(rnd 0)
;-> 6
(rnd -1)
;-> 6

Partendo da un numero iniziale diverso da 6 (42):
(length (setq rnd (ciclo-lcg 42 5 21 65536)))
;-> 65537

L'ultimo numero è uguale al primo:

(rnd 0)
;-> 42
(rnd -1)
;-> 42

Vedi anche "Generatore di numeri casuali" su "Note libere 1".
Vedi anche "Il metodo middle-square per generare numeri casuali" su "Note libere 22".
Vedi anche "Generatore casuale di Neumann" su "Note libere 26".
Vedi anche "Generatore casuale di Engel" su "Note libere 26".


--------------------------------------------------------
Parte frazionaria (decimale) di un numero floating point
--------------------------------------------------------

Vediamo una funzione che restituisce la parte frazionaria (decimale) di un numero:

(define (fractional num)
  (letn ( (num (string num)) (idx (find "." num)) )
    (if idx
        (int (slice num (+ (find "." num) 1)) 0 10)
        ;else
        0)))

Proviamo:

(fractional 1.123456789)
;-> 123456789
(fractional 2)
;-> 0
(fractional 3.)
;-> 0
(fractional 4.1)
;-> 1

Attenzione ai numeri con troppe cifre decimali:

(fractional 1.123456789123456789)
;-> 123456789123457



---------------------
assoc e lookup estesi
---------------------

Vediamo le definizioni di "lookup" a "assoc" dal manuale di riferimento:

*******************
>>> funzione ASSOC
*******************
sintassi: (assoc exp-key list-alist)
sintassi: (assoc list-exp-key list-alist)

Nella prima sintassi il valore di exp-key (chiave) viene utilizzato per cercare nella lista list-alist una sottolista il cui primo elemento corrisponde al valore della chiave. Se trovato, viene restituita la sottolista. In caso contrario, il risultato sarà nil.

(assoc 1 '((3 4) (1 2)))
;-> (1 2)

(set 'data '((apples 123) (bananas 123 45) (pears 7)))

(assoc 'bananas data)
;-> (bananas 123 45)
(assoc 'oranges data)
;-> nil

Insieme a "setf" la funzione "assoc" può essere usata per modificare un'associazione.

(setf (assoc 'pears data) '(pears 8))
data
;-> ((apples 123) (bananas 123 45) (pears 8))

Nella seconda sintassi è possibile specificare più espressioni-chiave per la ricerca di liste associative annidate in più livelli:

(set 'persons '(
    (id001 (name "Anne") (address (country "USA") (city "New York")))
    (id002 (name "Jean") (address (country "France") (city "Paris")))
))

(assoc '(id001 address) persons)
;-> (address (country "USA") (city "New York"))
(assoc '(id001 address city) persons)
;-> (city "New York")

La lista in list-aList può essere un contesto (context) che verrà interpretato come il suo funtore di default. In questo modo è possibile passare per riferimento liste molto grandi per un accesso più rapido e un minore utilizzo della memoria:

(set 'persons:persons '(
    (id001 (name "Anne") (address (country "USA") (city "New York")))
    (id002 (name "Jean") (address (country "France") (city "Paris")))
))

(define (get-city db id)
    (last (assoc (list id 'address 'city) db ))
)

(get-city persons 'id001)
;-> "New York"

Per effettuare sostituzioni nelle liste di associazioni, utilizzare "setf" insieme alla funzione "assoc". La funzione "lookup" viene utilizzata per eseguire la ricerca di associazione e l'estrazione dell'elemento in un solo passaggio.

********************
>>> funzione LOOKUP
********************
sintassi: (lookup exp-key list-assoc [int-index [exp-default]])

Cerca, nella lista di associazione list-assoc, una sottolista, il cui elemento chiave ha lo stesso valore di exp-key e restituisce l'elemento int-index dell'associazione (o l'ultimo elemento se int-index è assente).

Facoltativamente, è possibile specificare exp-default, che viene restituita se non è possibile trovare un'associazione corrispondente a exp-key. Se exp-default è assente e non è stata trovata alcuna associazione, viene restituito nil.

Vedi anche l'indicizzazione delle liste e delle stringhe.

La ricerca è simile a quella della funzione "assoc", ma fa un ulteriore passo estraendo un elemento specifico trovato nella lista.

(set 'params '(
    (name "John Doe")
    (age 35)
    (gender "M")
    (balance 12.34)
))

(lookup 'age params)
;-> 35

; utilizzata insieme a setf per modificare una lista di associazione

(setf (lookup 'age params) 42)
;-> 42
(lookup 'age params)
;-> 42

(set 'persons '(
    ("John Doe" 35 "M" 12.34)
    ("Mickey Mouse" 65 "N" 12345678)
))

(lookup "Mickey Mouse" persons 2)
;-> "N"
(lookup "Mickey Mouse" persons -3)
;-> 65
(lookup "John Doe" persons 1)
;-> 35
(lookup "John Doe" persons -2)
;-> "M"
(lookup "Jane Doe" persons 1 "N/A")
;-> "N/A"
-------------------------------------------------

Una limitazione di "assoc" e "lookup" riguarda il fatto che la chiave "exp-key" può essere solo un atomo (non può essere una lista).
Per esempio:

Lista con exp-key solo atomi:

(setq alst '((0 (0 0 0 0))
             (1 "uno")
             (2 (3.14))))

(assoc 1 alst)
;-> (1 "uno")   ;OK
(lookup 1 alst)
;-> "uno"       ;OK
(assoc 2 alst)
;-> (2 (3.14))  ;OK
(lookup 2 alst)
;-> (3.14)      ;OK

Lista con exp-key atomi e liste:

(setq blst '(((0 0 0 0) 0)
              ("uno" 1)
             ((3.14) 2)))

(assoc "uno" blst)
;-> ("uno" 1)        ;OK
(lookup "uno" blst)
;-> 1                ;OK
(assoc '(3.14) blst)
;-> nil              ;??
(lookup '(3.14) blst)
;-> nil              ;??
(assoc '(0 0 0 0) blst)
;-> nil              ;??
(lookup '(0 0 0 0) blst)
;-> nil              ;??

Per ovviare a questo problema possiamo utilizzare le seguenti funzioni:

(define (assoc+ exp-key alst)
  (find (list exp-key '?) alst match) $0)

(define (lookup+ exp-key alst)
  (find (list exp-key '?) alst match) ($0 1))

Proviamo:

(assoc+ 1 alst)
;-> (1 "uno")   ;OK
(lookup+ 1 alst)
;-> "uno"       ;OK
(assoc+ 2 alst)
;-> (2 (3.14))  ;OK
(lookup+ 2 alst)
;-> (3.14)      ;OK

(assoc+ "uno" blst)
;-> ("uno" 1)            ;OK
(lookup+ "uno" blst)
;-> 1                    ;OK
(assoc+ '(3.14) blst)
;-> (3.14 2)             ;OK
(lookup+ '(3.14) blst)
;-> 2                    ;OK
(assoc+ '(0 0 0 0) blst)
;-> ((0 0 0 0) 0)        ;OK
(lookup+ '(0 0 0 0) blst)
;-> 0                    ;OK

(setq clst '(((0 0 0 0) (1 1))
              (("uno") (2 2))
             ((3.14 2.72) (3 3))))

(assoc+ '(0 0 0 0) clst)
;-> ((0 0 0 0) (1 1))
(lookup+ '(0 0 0 0) clst)
;-> (1 1)
(assoc+ '("uno") clst)
;-> (("uno") (2 2))
(lookup+ '("uno") clst)
;-> (2 2)
(assoc+ '(3.14 2.72) clst)
;-> ((3.14 2.72) (3 3))
(lookup+ '(3.14 2.72) clst)
;-> (3 3)


-----------------------------------
Codifica BCD (Binary-Coded Decimal)
-----------------------------------

Il Binary-Coded Decimal (BCD) è una classe di codifiche binarie di numeri decimali in cui ogni cifra è rappresentata da un numero fisso di bit, solitamente quattro (nibble) o otto byte.
Unpacked BCD: un byte completo per ogni cifra (spesso incluso il segno 1100 per il + e 1101 per il -)
Packed BCD: codifica due cifre all'interno di un singolo byte sfruttando il fatto che quattro bit sono sufficienti per rappresentare i numeri da da 0 a 9.

Simple Binary-Coded Decimal (SBCD) o BCD 8421:

  +----------+---------+
  | Cifra    | BCD     |
  | decimale | 8 4 2 1 |
  +----------+---------+
  |    0     | 0 0 0 0 |
  |    1     | 0 0 0 1 |
  |    2     | 0 0 1 0 |
  |    3     | 0 0 1 1 |
  |    4     | 0 1 0 0 |
  |    5     | 0 1 0 1 |
  |    6     | 0 1 1 0 |
  |    7     | 0 1 1 1 |
  |    8     | 1 0 0 0 |
  |    9     | 1 0 0 1 |
  +----------+---------+
  |  Segno   | BCD     |
  |    +     | 1 1 0 0 |
  |    -     | 1 1 0 1 |
  +----------+---------+

Il vantaggio principale della codifica BCD, rispetto ai sistemi posizionali binari, è la rappresentazione più accurati delle quantità decimali.

Oggi la codifica BCD non è di uso comune come in passato, tuttavia continua ad essere utilizzata nell'informatica finanziaria e industriale, dove gli errori di arrotondamento che sono insiti nei formati binari a virgola mobile non possono essere tollerati.

(setq digit-bcd '((0 (0 0 0 0)) (1 (0 0 0 1)) (2 (0 0 1 0))
                  (3 (0 0 1 1)) (4 (0 1 0 0)) (5 (0 1 0 1))
                  (6 (0 1 1 0)) (7 (0 1 1 1)) (8 (1 0 0 0))
                  (9 (1 0 0 1))))

(setq bcd-digit '(((0 0 0 0) 0) ((0 0 0 1) 1) ((0 0 1 0) 2)
                  ((0 0 1 1) 3) ((0 1 0 0) 4) ((0 1 0 1) 5)
                  ((0 1 1 0) 6) ((0 1 1 1) 7) ((1 0 0 0) 8)
                  ((1 0 0 1) 9)))

(define (assoc+ exp-key alst)
  (find (list exp-key '?) alst match) $0)

(define (lookup+ exp-key alst)
  (find (list exp-key '?) alst match) ($0 1))

(lookup+ '(0 1 0 1) bcd-digit)
;-> 5
(lookup '(0 1 0 1) bcd-digit)
;-> nil ;??
(lookup+ 5 digit-bcd)
;-> (0 1 0 1)
(lookup 5 digit-bcd)
;-> (0 1 0 1)

Oppure:

(setq digit-bcd '((0 "0000") (1 "0001") (2 "0010") (3 "0011")
                  (4 "0100") (5 "0101") (6 "0110") (7 "0111")
                  (8 "1000") (9 "1001")))

(setq bcd-digit '(("0000" 0) ("0001" 1) ("0010" 2) ("0011" 3)
                  ("0100" 4) ("0101" 5) ("0110" 6) ("0111" 7)
                  ("1000" 8) ("1001" 9)))

(lookup "0101" bcd-digit)
;-> 5
(lookup 5 digit-bcd)
;-> "0101"


-------------
Il gioco Zara
-------------

La zara è un antico gioco d'azzardo con i dadi nato in epoca romana e molto comune nel Medioevo.
Si gioca con tre dadi: a turno ogni giocatore dichiara un numero da 3 a 18, quindi getta i dadi.
Se la somma dei dadi è uguale al numero dichiarato il giocatore vince.

Calcoliamo le probabilità di uscita di ciascun numero da 3 a 18:
I numeri (3..18) hanno probabilità diverse di uscita (ad esempio il numero 3 ha una sola combinazione possibile (1+1+1=3), mentre per ottenere 10 ce ne sono diverse (1+4+5=10, 2+2+6=10, ecc.).
Quanti numeri possono uscire?
  numero-facce^numero-dadi = 6^3 = 216
(* 6 6 6)
;-> 216

Scriviamo una funzione che calcola le frequenze di tutti i numeri (da 0 a 18) e restituisce una lista con elementi del tipo (numero frequenza %) dove:
  numero = numero considerato (da 0 a 18)
  frequenza = numero di combinazioni di tre dadi che ottengono il numero
  % = percentuale di probabilità di uscita del numero in un lancio

(define (zara-freq)
  (let (freq (dup 0 19))
    (for (d1 1 6)
      (for (d2 1 6)
        (for (d3 1 6)
          (++ (freq (+ d1 d2 d3))))))
    (map (fn(x y z) (list x y (mul 100 (div z 216))))
    ;(map (fn(x y z) (list x y (round (mul 100 (div z 216)) -2)))
         (sequence 0 18) freq freq)))

(zara-freq)
;-> ((0 0 0) (1 0 0) (2 0 0)
;->  (3 1 0.4629629629629629)
;->  (4 3 1.388888888888889)
;->  (5 6 2.777777777777778)
;->  (6 10 4.62962962962963)
;->  (7 15 6.944444444444445)
;->  (8 21 9.722222222222223)
;->  (9 25 11.57407407407407)
;->  (10 27 12.5)
;->  (11 27 12.5)
;->  (12 25 11.57407407407407)
;->  (13 21 9.722222222222223)
;->  (14 15 6.944444444444445)
;->  (15 10 4.62962962962963)
;->  (16 6 2.777777777777778)
;->  (17 3 1.388888888888889)
;->  (18 1 0.4629629629629629))

(setq freq (map (fn(x) (x 1)) (zara-freq)))
;-> (0 0 0 1 3 6 10 15 21 25 27 27 25 21 15 10 6 3 1)

(setq perc (map last (zara-freq)))
;-> (0 0 0 0.4629629629629629 1.388888888888889 2.777777777777778
;->  4.62962962962963 6.944444444444445 9.722222222222223 11.57407407407407
;->  12.5 12.5 11.57407407407407 9.722222222222223 6.944444444444445
;->  4.62962962962963 2.777777777777778 1.388888888888889 0.4629629629629629)

Somma delle percentuali di probabilità:

(apply add (map (fn(x) (x 2)) (zara-freq)))
;-> 100

Supponendo che la perdita in una partita valga 1, quale vincita deve essere associata ad ogni numero affinchè il gioco sia equo?
In altre parole:
se il giocatore non indovina il numero, allora perde un fiorino (1).
se il giocatore indovina il numero deve guadagnare in relazione alla probabilità di uscita del numero.

Se la probabilità che il numero predetta si verifichi è P(N), il giocatore deve vincere una quantità tale che, nel lungo periodo, il profitto atteso sia nullo.
Allora, se perde 1 euro in tutte le altre occasioni, la vincita deve essere inversamente proporzionale alla probabilità di uscita del numero:

                 1
  vincita(N) = ------
                P(N)

  dove P(N) = 1/freq

Per esempio, il numero 5 ha una frequenza di 6, una probabilità di 6/216 e una vincita pari a:

vincita(6) = 1/(6/216) = 36

Quindi per ogni numero abbiamo le seguenti vincite:

(setq vincite (map (fn(x) (div (div x 216))) freq))
;-> (1.#INF 1.#INF 1.#INF 216 72 36 21.6 14.4 10.28571428571429
;->  8.640000000000001 8 8 8.640000000000001 10.28571428571429
;->  14.4 21.6 36 72 216)

Possiamo scrivere la seguente tabella:

  Numero Frequenza Probabilità(%) Vincita
    0        0        0            1.#INF
    1        0        0            1.#INF
    2        0        0            1.#INF
    3        1        0.46         216
    4        3        1.39         72
    5        6        2.78         36
    6       10        4.63         21.6
    7       15        6.94         14.4
    8       21        9.72         10.28571428571429
    9       25        11.57        8.64
   10       27        12.5         8
   11       27        12.5         8
   12       25        11.57        8.64
   13       21        9.72         10.28571428571429
   14       15        6.94         14.4
   15       10        4.63         21.6
   16        6        2.78         36
   17        3        1.39         72
   18        1        0.46         216

Vediamo una simulazione del gioco in cui giochiamo per un certo numero di volte lo stesso numero:

(setq vincite '(0 0 0 216 72 36 21.6 14.4 10.28571428571429 8.64 8
                8 8.64 10.28571428571429 14.4 21.6 36 72 216))

(define (simula partite num)
  (local (total vincite rnd)
    (setq total 0)
    (setq vincite '(0 0 0 215 71 35 20.6 13.4 9.285714285714285 7.64 7
                    7 7.64 9.285714285714285 13.4 20.6 35 71 215))
    ;(setq vincite '(0 0 0 216 72 36 21.6 14.4 10.28571428571429 8.64 8
    ;                8 8.64 10.28571428571429 14.4 21.6 36 72 216))
    (for (i 1 partite)
      (dec total)
      (setq rnd (+ (+ 1 (rand 6)) (+ 1 (rand 6)) (+ 1 (rand 6))))
      (if (= num rnd)
          (setq total (add total 1.0 (vincite num))))
      )
  total))

Proviamo:

(simula 1e6 1)
;-> -1000000
(simula 1e6 3)
;-> 302
(simula 1e6 10)
;-> 1384
(simula 1e6 16)
;-> -3340

(apply add (map (fn(x) (simula 1e6 x)) (sequence 3 18)))
;-> -460.0000000089058
(apply add (map (fn(x) (simula 1e6 x)) (sequence 3 18)))
;-> -1758.285714294122
(apply add (map (fn(x) (simula 1e6 x)) (sequence 3 18)))
;-> -31563.90857140935
(apply add (map (fn(x) (simula 1e6 x)) (sequence 3 18)))
;-> 24453.7142857219
(apply add (map (fn(x) (simula 1e6 x)) (sequence 3 18)))
;-> 27771

Il gioco della Zara è citato da Dante nella Divina Commedia:

"Quando si parte il gioco de la zara,
colui che perde si riman dolente,
repetendo le volte, e tristo impara;

con l'altro se ne va tutta la gente;
qual va dinanzi, e qual di dietro il prende,
e qual dallato li si reca a mente;

el non s'arresta, e questo e quello intende;
a cui porge la man, più non fa pressa;
e così da la calca si difende."

(Purgatorio VI, 1-9)


---------
Girl face
---------

Pixels of a girl face (x y x y x y ...)

(setq p1 '(
 65 0 68 0 70 0 72 0 74 0 56 1 59 1 61 1 63 1 65 1 67 1 68 1 70 1
 71 1 73 1 74 1 75 1 64 2 67 2 69 2 70 2 72 2 74 2 60 3 63 3 65 3
 67 3 69 3 71 3 72 3 73 3 75 3 76 3 57 4 62 4 66 4 68 4 70 4 72 4
 74 4 75 4 60 5 63 5 65 5 67 5 69 5 70 5 71 5 73 5 74 5 76 5 77 5
 62 6 64 6 66 6 68 6 70 6 72 6 73 6 75 6 76 6 59 7 61 7 64 7 67 7
 69 7 71 7 72 7 74 7 76 7 77 7 63 8 66 8 68 8 70 8 71 8 73 8 74 8
 75 8 77 8 60 9 62 9 64 9 66 9 68 9 70 9 72 9 74 9 76 9 77 9 78 9
 70 10 72 10 73 10 75 10 76 10 78 10 63 11 67 11 69 11 72 11 74 11
 75 11 77 11 78 11 65 12 74 12 76 12 78 12 79 12 64 13 67 13 69 13
 73 13 75 13 77 13 79 13 62 14 66 14 71 14 74 14 75 14 76 14 77 14
 78 14 65 15 69 15 73 15 75 15 77 15 79 15 81 15 59 16 62 16 64 16
 66 16 68 16 72 16 74 16 76 16 77 16 78 16 61 17 64 17 66 17 69 17
 71 17 73 17 75 17 76 17 78 17 57 18 60 18 62 18 64 18 66 18 68 18
 71 18 73 18 75 18 77 18 78 18 80 18 59 19 61 19 63 19 65 19 68 19
 70 19 71 19 73 19 75 19 77 19 58 20 60 20 62 20 64 20 66 20 68 20
 70 20 72 20 74 20 76 20 78 20 79 20 57 21 59 21 61 21 63 21 65 21
 68 21 70 21 72 21 73 21 75 21 77 21 78 21 55 22 59 22 61 22 63 22
 66 22 70 22 78 22 57 23 59 23 61 23 62 23 64 23 67 23 69 23 72 23
 74 23 77 23 78 23 79 23 55 24 58 24 63 24 79 24 57 25 60 25 63 25
 65 25 69 25 78 25 79 25 56 26 62 26 64 26 67 26 79 26 64 27 65 27
 79 27 80 27 54 28 65 28 66 28 80 28 65 29 66 29 80 29 81 29 66 30
 80 30 82 30 64 31 66 31 67 31 81 31 82 31 66 32 68 32 82 32 83 32
 65 33 67 33 83 33 84 33 63 34 66 34 67 34 68 34 84 34 66 35 84 35
 85 35 65 36 67 36 68 36 88 38 90 39 92 41 94 41 94 42 96 42 67 43
 95 43 63 44 68 44 96 44 98 44 65 45 67 45 98 45 100 45 69 46 63 47
 65 47 67 47 101 47 54 48 68 48 70 48 74 48 103 48 57 49 60 49 63
 49 65 49 67 49 105 49 61 50 66 50 69 50 71 50 106 50 107 50 56 51
 59 51 63 51 65 51 68 51 76 51 108 51 61 52 63 52 66 52 69 52 71 52
 73 52 109 52 110 52 57 53 60 53 65 53 67 53 70))

(setq p2 '(
 53 110 53 111 53 61 54 63 54 65 54 68 54 72 54 75 54 110 54 111 54
 58 55 64 55 67 55 69 55 71 55 73 55 111 55 112 55 63 56 65 56 67
 56 70 56 74 56 112 56 62 57 66 57 69 57 71 57 73 57 77 57 112 57
 113 57 65 58 68 58 72 58 75 58 108 58 112 58 64 59 67 59 69 59 71
 59 74 59 110 59 112 59 113 59 62 60 66 60 70 60 73 60 77 60 112 60
 69 61 72 61 75 61 106 61 111 61 64 62 66 62 68 62 70 62 72 62 74
 62 77 62 103 62 105 62 108 62 110 62 111 62 75 63 102 63 110 63 70
 64 72 64 74 64 78 64 101 64 76 65 100 65 108 65 109 65 70 66 72 66
 74 66 78 66 99 66 108 66 76 67 79 67 99 67 107 67 71 68 75 68 98
 68 106 68 107 68 73 69 78 69 98 69 105 69 76 70 82 70 97 70 102 70
 104 70 70 71 79 71 96 71 103 71 72 72 75 72 102 72 103 72 77 73 80
 73 96 73 102 73 84 74 102 74 103 74 74 75 81 75 103 75 104 75 76
 76 79 76 104 76 83 77 103 77 104 77 73 78 102 78 104 78 105 78 79
 79 105 79 88 80 92 80 95 80 101 80 104 80 106 80 84 81 98 81 105
 81 107 81 108 81 103 82 107 82 109 82 86 83 90 83 95 83 101 83 108
 83 109 83 110 83 92 84 105 84 108 84 110 84 111 84 97 85 107 85 109
 85 110 85 72 86 89 86 107 86 109 86 110 86 74 87 93 87 99 87 107
 87 108 87 110 87 106 88 107 88 109 88 80 89 105 89 106 89 108 89
 109 89 105 90 107 90 109 90 104 91 106 91 107 91 108 91 109 91 103
 92 104 92 106 92 107 92 102 93 103 93 105 93 102 94 104 94 102 95
 100 96 103 96 80 97 101 97 102 97 95 98 104 98 97 99 99 99 106 99
 108 99 109 99 94 100 101 100 105 100 106 100 108 100 110 100 97 101
 103 101 105 101 107 101 108 101 110 101 111 101 107 102 109 102 110
 102 111 102 94 103 102 103 109 103 111 103 112 103 107 104 110 104
 112 104 113 104 104 105 108 105 110 105 111 105 112 105 111 106 112
 106 113 106 107 107 110 107 112 107 109 108 111 108 112 108 108 109
 110 109 111 109 102 110 105 110 107 110 109 110 104 111 107 111 101
 112 106 112 107 112 84 113 95 113 103 113 105 113 106 113 97 114
 102 114 105))

(setq p3 '(
 114 107 114 99 115 104 115 105 115 106 115 102 116 105 116 107 116
 97 117 103 117 105 117 107 117 100 118 104 118 106 118 107 118 108
 118 103 119 106 119 108 119 102 120 104 120 105 120 107 120 108 120
 109 120 107 121 109 121 104 122 106 122 108 122 109 122 110 122 102
 123 107 123 109 123 110 123 111 123 106 124 109 124 111 124 104 125
 107 125 109 125 110 125 111 125 96 126 108 126 110 126 111 126 98
 127 106 127 109 127 111 127 112 127 102 128 108 128 110 128 111 128
 112 128 108 129 110 129 112 129 104 130 109 130 110 130 111 130 112
 130 106 131 108 131 111 131 109 132 110 132 111 132 112 132 105 133
 107 133 109 133 111 133 112 133 109 134 111 134 106 135 108 135 109
 135 110 135 111 135 105 136 108 136 48 137 60 137 100 137 103 137
 107 137 109 137 106 138 108 138 109 138 87 139 90 139 102 139 105
 139 107 139 70 140 74 140 77 140 104 140 106 140 93 141 103 141 80
 142 87 142 89 142 91 142 72 143 76 143 82 143 36 145 52 145 59 145
 64 145 54 146 61 147 58 148 56 149 54 150 39 152 44 152 48 152 53
 152 51 153 49 154 42 155 46 155 48 156 44 157 47 157 40 158 46 158
 44 159 42 160 45 160 38 161 44 161 41 162 43 162 39 164 41 164 43
 164 42 165 24 166 39 166 41 166 26 167 41 167 40 168 38 169 40 169
 35 170 40 170 37 171 39 171 30 172 38 172 34 173 36 173 38 173 32
 174 37 174 36 175 34 176 37 176 28 177 31 177 35 177 34 178 36 178
 32 179 35 179 30 180 34 180 33 181 30 182 32 182 33 183 29 184 8
 185 32 185 26 186 28 186 23 187 27 188 29 188 25 189 29 189 0 190
 28 190 2 191 23 191 26 191 28 191 27 192 4 193 23 193 25 193 27 193
 26 194 22 195 25 195 24 196 23 197 25 197 23 199))

Unione dei pixel:

(setq pixels (append p1 p2 p3))
(length pixels)
;-> 1634

(setq pixels (explode pixels 2))
(length pixels)
;-> 817

(pixels 0)
;-> (65 0)

Convertiamo i punti in un file immagine:

Vedi "Creazione di immagini con ImageMagick" su "Note libere 7".

(define (list-IM lst file-str)
  (local (outfile x-width y-height line)
    (setq lst (sort (unique lst)))
    (setq outfile (open file-str "write"))
    (print outfile { })
    ; calcolo dimensioni immagine
    (setq x-width (add 1 (apply max (map first lst))))
    (setq y-height (add 1 (apply max (map last lst))))
    ; scrittura del file in formato ImageMagick
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                (string x-width) "," (string y-height) ",256,rgba"))
    (dolist (el lst)
      (setq line (string (string (el 0)) ", " (string (el 1))
            ": (0,0,0,255)")) ; colore nero con alpha=100%
      (write-line outfile line)
    )
    (close outfile)))

(list-IM pixels "girl.txt")
(exec "convert girl.txt girl.png")

Vedi immagine "girl.png" nella cartella "data".


--------------------
Compito di punizione
--------------------

Il professore Bit era molto arrabbiato con i suoi alunni e per punizione assegnò loro un problema di programmazione estremamente tedioso:
Scrivere una funzione che determina se un numero dato è pari o dispari.
La funzione deve rispondere correttamente fino al numero 10.000.
La funzione deve essere scritta nel modo seguente:

(define (parita num)
  (if (= num 1) (println "odd"))
  (if (= num 2) (println "even"))
  ; ecc.
  (if (= num 10000) (println "even"))
)

Gli alunni erano veramente preoccupati: passare ore a scrivere 10000 righe non era una bella prospettiva.
Fortunatamente un alunno, soprannominato "skripter", ebbe un'idea molto furba: scrivere una funzione che genera la funzione richiesta dal professore.

(define (genera-funzione max-value)
  ; definizione iniziale della funzione
  (let (f '(lambda (num) (if (= num 1) (println "odd"))))
    ; ciclo per ogni if
    (for (i 2 max-value)
      (if (even? i)
        ; inserisce nella funzione if per i numeri pari
        (push (list 'if (list '= 'num i) (list 'println "even")) f -1)
        ; inserisce nella funzione if per i numeri dispari
        (push (list 'if (list '= 'num i) (list 'println "odd")) f -1)
      )
    )
    (push ''> f -1) ; invece di restituire nil
    f))

Proviamo:

(setq func (genera-funzione 5))
;-> (lambda (num)
;->  (if (= num 1)
;->   (println "odd"))
;->  (if (= num 2)
;->   (println "even"))
;->  (if (= num 3)
;->   (println "odd"))
;->  (if (= num 4)
;->   (println "even"))
;->  (if (= num 5)
;->   (println "odd")) '>)

(func 1)
;-> odd
(func 2)
;-> even
(func 3)
;-> odd
(func 4)
;-> even
(func 5)
;-> odd

(silent (setq func (genera-funzione 10000)))
(func 1)
;-> odd
(func 5674)
;-> even
(func 10000)
;-> even


------------------------
Generazione di labirinti
------------------------

Definizione
-----------
Un labirinto è una griglia rettangolare di celle in cui ogni cella è collegata alla cella iniziale da almeno un percorso.
In termini matematici, un labirinto è un grafo non orientato, planare e possibilmente ciclico, la cui chiusura transitiva è un grafo completamente connesso.

Proprietà dei labirinti
-----------------------
1) Vicoli ciechi
Un vicolo cieco è definito come una cella collegata ad un solo vicino.

2) Percorso più lungo
Rappresenta la percentuale di celle che si trovano sul percorso più lungo del labirinto.

3) Tortuosità
Tortuosità è una misura di quanto spesso un percorso cambi direzione.
Rappresenta la percentuale di celle di un percorso che svolta verso sinistra o verso destra.

4) Passaggi rettilinei:
I passaggi rettilinei rappresentano l'opposto della tortuosità.
Rappresenta quante celle in una griglia formano percorsi in linea retta, orizzontalmente o verticalmente.

5) Intersezioni
Le intersezioni indicano quanto spesso durante l'attraversamento del labirinto si dovrà prendere una decisione (destra e/o sinistra e/o alto e/o basso).

Per generare un labirinto esistono diversi metodi che producono risultati con caratteristiche differenti:

- Algoritmo Binary Tree,
- Algoritmo Aldous-Broder,
- Algoritmo Wilson,
- Algoritmo Recursive Backtracking,
- Algoritmo Kruskal,
- Algoritmo Eller,
- Algoritmo Growing Tree,
- Algoritmo Hunt-and-kill,
- Algoritmo Prim's,
- Algoritmo Recursive Division,
- Algoritmo Sidewinder,
- Algoritmi con automi cellulari.

In questo caso scriviamo una funzione che genera un labiritno utilizzando l'algoritmo Recursive Backtracking.
Questo algoritmo è uno dei più semplici da implementare, sia per la sua logica che per il codice richiesto.

Algoritmo Recursive Backtracking
--------------------------------
1) Inizializzazione: Si parte da una cella casuale nel labirinto.
2) Esplorazione: Si cerca una cella vicina non ancora visitata, la si marca come parte del percorso, e si procede verso quella cella.
3) Vicolo cieco: Se non ci sono celle vicine non visitate, si torna indietro (backtrack) al passo precedente e si cerca un'altra direzione.
4) Ripetizione: Si ripete il processo fino a quando tutte le celle sono state visitate.

Scelta delle celle di partenza e di arrivo
------------------------------------------
1. Cella di Partenza:
Possiamo scegliere una cella casuale oppure fissare una posizione specifica.
In questo caso scegliamo la cella in alto a sinistra (0,0).
2. Cella di Arrivo:
Possiamo scegliere una cella casuale, oppure la cella più lontana possibile dalla partenza o può essere fissata nell'angolo opposto alla cella di paretenza.
Nel nostro caso scegliamo la cella in basso a destra, (larghezza-1, altezza-1).

Partenza: (0, 0)
Arrivo: (larghezza-1, altezza-1)

Stampa del labirinto:
Stampiamo il labirinto come una matrice di caratteri.
Un muro può essere rappresentato con '*' e un passaggio con uno spazio vuoto " ".
La cella di partenza e quella di arrivo sono rappresentate con le lettere P (Partenza) e A (Arrivo).

Rappresentazione informatica del labirinto:
matrice in cui i termini valgono 0 per i muri e 1 per i passaggi.

Esempio di pseudocodice:
funzione generaLabirinto(cella):
    marca la cella come visitata
    mentre ci sono celle vicine non visitate:
        scegli una direzione casuale
        se la cella nella direzione scelta non è stata visitata:
            rimuovi il muro tra le celle
            chiama ricorsivamente generaLabirinto(cella vicina)

Implementazione
---------------

; Inizializza la matrice del labirinto con 0 (muri ovunque)
(define (crea-matrice)
  (setq matrice (array-list (array larghezza altezza '(0)))))

; Funzione per controllare se una cella è valida e non è stata visitata
(define (cella-valida? x y)
  (and (>= x 0) (< x larghezza) (>= y 0) (< y altezza)
       (= (matrice x y) 0)))  ; 0 significa che è un muro non visitato

; Funzione per generare il labirinto con il backtracking ricorsivo
(define (genera-labirinto x y)
  (setf (matrice x y) 1)  ; Marca la cella come visitata (1 = passaggio)
  (dolist (direzione (randomize '((1 0) (-1 0) (0 1) (0 -1))))  ; Mescola le direzioni
    (let ((nx (+ x (* 2 (direzione 0)))) (ny (+ y (* 2 (direzione 1)))))
      (when (cella-valida? nx ny)  ; Se la nuova cella è valida
        ; Rimuove il muro tra la cella corrente e quella nuova
        (setf (matrice (+ x (first direzione)) (+ y (direzione 1))) 1)
        ; Continua la generazione del labirinto dalla nuova cella
        (genera-labirinto nx ny)))))

; Funzione per stampare il labirinto con S (partenza) e E (arrivo)
(define (stampa-labirinto)
  (println (dup "_" (+ larghezza 2)))
  (for (y 0 (- altezza 1))
    (print "|")
    (for (x 0 (- larghezza 1))
      (cond
        ((and (= x 0) (= y 0)) (print "S"))  ; Stampa la cella di partenza
        ((and (= x (- larghezza 1)) (= y (- altezza 1))) (print "E"))  ; Stampa la cella di arrivo
        ((= (matrice x y) 1) (print " "))  ; Stampa i passaggi
        (true (print "█"))))  ; Stampa i muri
    (println "|"))  ; Vai a capo per ogni riga
  (println (dup "^" (+ larghezza 2))) '>)

Proviamo:

(setq larghezza 21)
(setq altezza 11)
(crea-matrice)
(genera-labirinto 0 0)
; Stampa il labirinto generato
(stampa-labirinto)
;-> -----------------------
;-> |S█         █   █     |
;-> | █ ███████ █ █ █ ███ |
;-> | █   █ █   █ █     █ |
;-> | ███ █ █ ███ ███████ |
;-> |     █   █     █     |
;-> |██████ █████████ ███ |
;-> |     █ █       █ █   |
;-> | █ █ █ █ █ ███ █ █ ██|
;-> | █ █ █ █ █   █   █ █ |
;-> | █ ███ █████ █████ █ |
;-> | █           █      E|
;-> ^^^^^^^^^^^^^^^^^^^^^^^

(crea-matrice)
(genera-labirinto 0 0)
; Stampa il labirinto generato
(stampa-labirinto)
;-> -----------------------
;-> |S  █ █       █       |
;-> |██ █ █ ███ █ ███████ |
;-> |   █     █ █       █ |
;-> | ███ █████ ███████ █ |
;-> | █     █   █ █     █ |
;-> | ███████ ███ █ █████ |
;-> |       █   █   █     |
;-> |██████ ███ █ ███ ███ |
;-> |     █     █   █ █   |
;-> | ███ █████████ ███ █ |
;-> |   █               █E|
;-> ^^^^^^^^^^^^^^^^^^^^^^^

(setq larghezza 41)
(setq altezza 21)
(crea-matrice)
(genera-labirinto 0 0)
; Stampa il labirinto generato
(stampa-labirinto)
;-> ___________________________________________
;-> |S█     █   █   █       █     █           |
;-> | ███ █ ███ █ █ █ █████ █ █ █ █████ █████ |
;-> |     █ █   █ █ █   █ █   █ █   █   █   █ |
;-> |██████ █ ███ █ ███ █ █████ ███ █ ███ █ █ |
;-> |     █ █ █   █       █     █   █   █ █   |
;-> | █ ███ █ █ ███████████ █████ █████ █ ████|
;-> | █   █ █     █     █   █ █   █     █ █   |
;-> | ███ █ █████ ███ █ █ ███ █ █████ ███ ███ |
;-> | █ █   █   █     █ █   █         █ █ █   |
;-> | █ █████ █ ███████ ███ ███████████ █ █ █ |
;-> | █       █   █   █ █ █   █         █   █ |
;-> | █████ █ ███ ███ █ █ ███ █ ███████ █████ |
;-> | █   █ █   █   █       █ █   █         █ |
;-> | █ █ █████ ███ ███████ █ ███ █ █████████ |
;-> | █ █ █   █   █       █ █ █ █ █   █       |
;-> | █ █ █ █ █ █ ███████ ███ █ █ ███ █ ██████|
;-> | █ █   █ █ █ █       █   █ █   █ █   █   |
;-> | █ █████ ███ █ ███████ ███ █ ███ ███ ███ |
;-> | █     █ █   █         █   █ █     █   █ |
;-> | █████ █ █ █████████████ ███ █ ███████ █ |
;-> |       █   █                 █          E|
;-> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Vedi anche "Labirinti (calcolo percorsi)" su "Problemi vari".
Vedi anche "Labirinti (Maze)" su "Note libere 3".
Vedi anche "Algoritmo Lee - Ricerca del percorso in un labirinto" su "Note libere 7".


--------------------------------------------
Quadrati concentrici di una matrice quadrata
--------------------------------------------

Data una matrice quadrata estrarre gli elementi partendo dal centro e proseguendo verso l'esterno in quadrati concentrici (partendo dalla cella in alto a sinistra e andando in senso orario).
Per esempio:

matrice = 1 2 3
          4 5 6
          7 8 9
Quadrati concentrici:
elemento centrale = (5)
primo quadrato = (1 2 3 6 9 8 7 4)

matrice=  1  2  3  4  5
          6  7  8  9 10
         11 12 13 14 15
         16 17 18 19 20
         21 22 23 24 25
Quadrati concentrici:
elemento centrale = (13)
primo quadrato = (7 8 9 14 19 18 17 12)
secondo quadrato = (1 2 3 4 5 10 15 20 25 24 23 22 21 16 11 6)

matrice =  1  2  3  4
           5  6  7  8
           9 10 11 12
          13 14 15 16
Quadrati concentrici:
elemento centrale = (6 7 11 10)
primo quadrato = (1 2 3 4 8 12 16 15 14 13 9 5))

(define (concentrici matrice)
  (local (N risultato centro
          riga-alto riga-basso-colonna-sinistra colonna-destra
          cur-quad)
    (setq N (length matrice))
    (setq risultato '())
    (setq centro (/ (length matrice) 2))
    ; matrice con N pari
    (when (even? N)
      ; Aggiunge i quattro elementi centrali al risultato
      (push (list (matrice (- centro 1) (- centro 1))
                  (matrice (- centro 1) centro)
                  (matrice centro centro)
                  (matrice centro (- centro 1))) risultato)
      ; Definisce gli indici degli angoli del quadrato di partenza
      (setq riga-alto (- centro 1))
      (setq riga-basso centro)
      (setq colonna-sinistra (- centro 1))
      (setq colonna-destra centro)
      ; Numero di quadrati
      (setq quadrati (- (/ N 2) 1))
    )
    ; matrice con N dispari
    (when (odd? N)
      ; Aggiunge l'elemento centrale al risultato
      (push (list (matrice centro centro)) risultato)
      ; Definisce gli indici degli angoli del quadrato di partenza
      (setq riga-alto centro)
      (setq riga-basso centro)
      (setq colonna-sinistra centro)
      (setq colonna-destra centro)
      ; Numero di quadrati
      (setq quadrati (/ N 2))
    )
    ; Procede con i quadrati concentrici
    (for (q 1 quadrati)
      (setq cur-quad '()) ; quadrato corrente
      ; Definisce gli indici degli angoli del quadrato corrente
      (setq riga-alto (- riga-alto 1))  ; riga alto
      (setq riga-basso (+ riga-basso 1))  ; riga basso
      (setq colonna-sinistra (- colonna-sinistra 1))  ; colonna sinistra
      (setq colonna-destra (+ colonna-destra 1))  ; colonna destra
      ; Lato superiore (da colonna-sinistra a colonna-destra)
      (for (i colonna-sinistra colonna-destra)
        (push (matrice riga-alto i) cur-quad -1))
      ; Lato destro (dall'alto verso il basso)
      (for (j (+ riga-alto 1) (- riga-basso 1))
        (push (matrice j colonna-destra) cur-quad -1))
      ; Lato inferiore (da colonna-destra a colonna-sinistra)
      (for (k colonna-destra colonna-sinistra)
        (push (matrice riga-basso k) cur-quad -1))
      ; Lato sinistro (dal basso verso l'alto)
      (for (l (- riga-basso 1) (+ riga-alto 1))
        (push (matrice l colonna-sinistra) cur-quad -1))
      (push cur-quad risultato -1)
    )
    risultato))

Proviamo:

(setq m1 '((1  2  3  4  5)
           (6  7  8  9  10)
           (11 12 13 14 15)
           (16 17 18 19 20)
           (21 22 23 24 25)))

(concentrici m1)
;-> ((13) (7 8 9 14 19 18 17 12) (1 2 3 4 5 10 15 20 25 24 23 22 21 16 11 6))

(setq m2 '((1 2 3)
           (4 5 6)
           (7 8 9)))

(concentrici m2)
;-> ((5) (1 2 3 6 9 8 7 4))

(setq m3 '(( 1  2  3  4)
           ( 5  6  7  8)
           ( 9 10 11 12)
           (13 14 15 16)))

(concentrici m3)
;-> ((6 7 11 10) (1 2 3 4 8 12 16 15 14 13 9 5))

(setq m4 (array-list (array 8 8 (sequence 1 64))))
(( 1  2  3  4  5  6  7  8)
 ( 9 10 11 12 13 14 15 16)
 (17 18 19 20 21 22 23 24)
 (25 26 27 28 29 30 31 32)
 (33 34 35 36 37 38 39 40)
 (41 42 43 44 45 46 47 48)
 (49 50 51 52 53 54 55 56)
 (57 58 59 60 61 62 63 64))

(concentrici m4)
;-> ((28 29 37 36)
;->  (19 20 21 22 30 38 46 45 44 43 35 27)
;->  (10 11 12 13 14 15 23 31 39 47 55 54 53 52 51 50 42 34 26 18)
;->  (1 2 3 4 5 6 7 8 16 24 32 40 48 56 64 63 62 61 60 59 58 57 49 41 33 25 17 9))

Il programma segue una logica strutturata per estrarre gli elementi di una matrice quadrata in quadrati concentrici, partendo dal centro verso l'esterno, tenendo conto di due scenari:
- quando la dimensione della matrice è **dispari** (con un singolo elemento centrale).
- quando la dimensione della matrice è **pari** (con quattro elementi centrali).

### Dettagli sul funzionamento:

#### 1. **Variabili iniziali**:
  - 'N': rappresenta la lunghezza della matrice (numero di righe o colonne).
  - 'centro': calcola il centro della matrice. Se 'N' è dispari, questo sarà l'indice esatto del centro, se 'N' è pari, si calcoleranno i quattro elementi centrali.
  - 'risultato': è la lista che conterrà gli elementi della matrice estratti in ordine a spirale.

#### 2. **Gestione del caso pari**:
Quando 'N' è pari:
  - Aggiunge i quattro elementi centrali alla lista 'risultato'.
    Questi quattro elementi formano un blocco al centro della matrice, quindi sono:
    - l'elemento in alto a sinistra del centro,
    - l'elemento in alto a destra,
    - l'elemento in basso a destra,
    - l'elemento in basso a sinistra.
  - Imposte gli indici iniziali delle righe ('riga-alto', 'riga-basso') e delle colonne ('colonna-sinistra', 'colonna-destra') corrispondenti agli angoli del blocco centrale.
  - Definisce 'quadrati', che indica il numero di quadrati concentrici rimanenti da processare.

#### 3. **Gestione del caso dispari**:
Quando 'N' è dispari:
  - Aggiunge l'elemento centrale singolo alla lista 'risultato'.
  - Imposta 'riga-alto', 'riga-basso', 'colonna-sinistra' e 'colonna-destra' in modo che corrispondano alla cella centrale.
  - Anche qui, 'quadrati' rappresenta il numero di quadrati concentrici rimanenti da processare.

#### 4. **Ciclo principale per creare i quadrati concentrici**:
Dopo aver gestito l'elemento o gli elementi centrali, il programma entra in un ciclo 'for' che crea quadrati concentrici intorno al centro.
Ad ogni iterazione, gli indici 'riga-alto', 'riga-basso', 'colonna-sinistra' e 'colonna-destra' vengono espansi per allargare il quadrato.

Per ciascun quadrato, il programma esegue quattro passaggi:
  - **Lato superiore**: Aggiunge gli elementi dall'estrema sinistra all'estrema destra della riga superiore.
  - **Lato destro**: Aggiunge gli elementi dall'alto verso il basso della colonna destra (tranne quelli che appartengono anche al lato superiore e inferiore).
  - **Lato inferiore**: Aggiunge gli elementi da destra a sinistra della riga inferiore.
  - **Lato sinistro**: Aggiunge gli elementi dal basso verso l'alto della colonna sinistra (tranne quelli che appartengono anche al lato superiore e inferiore).

Gli elementi raccolti per ciascun quadrato vengono temporaneamente salvati in 'cur-quad' e poi aggiunti a 'risultato'.

#### 5. **Output**:
Alla fine, 'risultato' contiene una lista di liste, dove ciascuna lista rappresenta un livello della spirale,partendo dal centro e procedendo verso l'esterno.

#### Esempio:
Per la matrice 5x5:
(set 'matrice '((1  2  3  4  5)
                (6  7  8  9  10)
                (11 12 13 14 15)
                (16 17 18 19 20)
                (21 22 23 24 25)))

L'espressione:
(concentrici matrice)

Restituirà:
((13)
 (7 8 9 14 19 18 17 12)
 (1 2 3 4 5 10 15 20 25 24 23 22 21 16 11 6))

#### Spiegazione dell'output:
I risultati vengono raggruppati per livelli di quadrati:
1. Il primo elemento '(13)' è il centro della matrice.
2. Il secondo gruppo di numeri rappresenta il primo quadrato intorno al centro, partendo dall'alto a sinistra e proseguendo in senso orario.
3. L'ultimo gruppo rappresenta il quadrato esterno della matrice, sempre disposto in senso orario.


-------------------------------
Odds, Evens, Oddish and Evenish
-------------------------------

Un numero è Odds se le cifre dispari sono in numero maggiore delle cifre pari
Un numero è Evens se le cifre pari sono in numero maggiore delle cifre dispari
Un numero è Neutral se il numero di cifre pari è uguale al numero delle cifre dispari.

Un numero è Oddish se la somma delle cifre è dispari
Un numero è Evenish se la somma delle cifre è pari

(define (oenoe num)
  (let ((somma 0) (pari 0) (dispari 0) (p1 "") (p2 "") (out '()))
    (while (!= num 0)
      (setq cifra (% num 10))
      (if (odd? cifra) (++ dispari) (++ pari))
      (setq somma (+ somma cifra))
      (setq num (/ num 10))
    )
    (cond ((> pari dispari) (setq p1 "Evens"))
          ((< pari dispari) (setq p1 "Odds"))
          ((= pari dispari) (setq p1 "Neutral")))
    (if (even? somma) 
        (setq p2 "Evenish")
        (setq p2 "Oddish"))
    (list p1 p2)))

Proviamo:

(oenoe 1234)
;-> ("Neutral" "Evenish")

(oenoe 11111)
;-> ("Odds" "Oddish")

(oenoe 224466)
;-> ("Evens" "Evenish")


-------------------------------------------------------------
Valore atteso dei passi per andare da 0 a N con passi casuali
-------------------------------------------------------------

Abbiamo una linea di numeri interi da 0 a N.
Poniamo una biglia nella posizione 0.
Poi avanziamo la biglia verso N di un valore casuale compreso tra 1 e (N - posizione).
Qual'è la formula per calcolare il valore medio dei valori casuali per raggiungere N (valore atteso)?

Scriviamo una funzione che simula questo processo.

(define (moves N iter)
  (local (num-passi pos)
    (setq num-passi 0)
    (for (i 1 iter)
      (setq pos 0)
      (while (< pos N)
        ; muove la biglia nella nuova posizione
        (++ pos (+ 1 (rand (- N pos))))
        (++ num-passi)))
    (div num-passi iter)))

Proviamo:

(moves 2 1e7)
;-> 1.5000352
(moves 4 1e7)
;-> 2.0827491
(moves 10 1e7)
;-> 2.9291817
(time (println (moves 100 1e7)))
;-> 5.1867909
;-> 8509.987999999999
(time (println (moves 1000 1e7)))
;-> 7.4858765
;-> 11879.613
(time (println (moves 10000 1e7)))
;-> 9.789269300000001
;-> 15193.538

Dal punto di vista matematico possiamo seguire un approccio basato su una somma armonica.
Quando ci troviamo in una posizione x (con 0 <= x < N), il passo successivo sarà un numero casuale tra 1 e (N - x).
Questo significa che il numero medio dei passi necessari da x a N vale:

  E(x) = 1 + 1/(N - x) * sum[k=1,(N-x)]E(x + k)

Tuttavia, possiamo semplificare questa ricorsione con un approccio alternativo:
dobbiamo calcolare la somma dei reciproci delle distanze rimanenti.
Per ogni posizione x, il numero medio di passi che mancano per raggiungere N è la somma dei reciproci delle distanze possibili, più 1 (per il primo passo):

  E(0) = sum[k=1,N](1/k)

Questa somma è chiamata somma armonica H(N) e può essere approssimata con la formula:

  H(N) ≈ ln(N) + gamma

dove gamma ≈ 0.5772156649015329 è la costante di Eulero-Mascheroni.

Il valore medio dei passi necessari per raggiungere N da 0 con scelte casuali ad ogni passo è dato da:

 E(0) = H(N) = sum[k=1,N](1/k)

In modo approssimato:

 E(0) = H(N) ≈ ln(N) + gamma

Funzione esatta:

(define (exact N)
  (setq passi 0)
  (for (k 1 N) (setq passi (add passi (div k))))
  passi)

Funzione approssimata:

(define (approx N) (add (log N) 0.577))

Proviamo:

(setq valori '(2 4 10 100 1000 10000))

(map exact valori)
;-> (1.5 2.083333333333333 2.928968253968254 5.187377517639621
;->  7.485470860550343 9.787606036044348)

(map approx valori)
;-> (1.270147180559945 1.963294361119891 2.879585092994046 5.182170185988092
;->  7.484755278982137 9.787340371976184)

Vediamo una tabella con i valori dei tre metodi:
            
      N   Simulazione    Esatto          Approssimato
      2    1.5000352      1.5             1.2701472
      4    2.0827491      2.0833333       1.9632944
     10    2.9291817      2.9289683       2.8795851
    100    5.1867909      5.1873775       5.1821702
   1000    7.4858765      7.4854709       7.4847553
  10000    9.7892693      9.7876060       9.7873404
 100000   12.0920852     12.0901461      12.0899255


---------------------------------------------------------
Raggruppamento degli elementi di una lista con una chiave
---------------------------------------------------------

In una miniera lavorano tre persone A, B e C.
Tutti i giorni, al rientro dal lavoro, ogni lavoratore compila una scheda in cui riporta il nome e le quantità di oro e argento che hanno estratto.
Dopo un pò di giorni abbiamo la seguente tabella:

Nome Oro(gr) Argento(gr)
 A    10      30
 B     0      50
 C    30      30
 B    10      50
 A    30       0
 ...

La tabella viene memorizzata come una lista in cui ogni riga rappresenta un elemento:

  (("A" 10 30) ("B" 0 50) ("C" 30 30) ("B" 10 50) ("A" 30 0)))

Vogliamo ottenere una lista del tipo:

  ("A" (10 30) (30 0)) ("B" (0 50) (10 50)) ("C" (30 30))

dove ci sono 3 elementi (le chiavi A, B e C) a cui sono associati tutti i valori corrispondenti.

(setq lst '(("A" 10 30) ("B" 0 50) ("C" 30 30) ("B" 10 50) ("A" 30 0)))

; Trova e ordina le chiavi
(setq keys (sort (unique (map first lst))))
;-> ("A" "B" "C")

; Lista soluzione
(setq out '())
; per ogni chiave...
(dolist (key keys)
  ; elemento corrente
  (setq element (list key))
  ; ricerca della chiave negli elementi della lista
  ; e aggiornamento dell'elemento corrente
  ;(dolist (el lst) (if (= key (el 0)) (extend element (list (slice el 1)))))
  (dolist (el lst) (if (= key (el 0)) (push (slice el 1) element -1)))
  ; inserimento elemento corrente nella lista soluzione
  (push element out -1)
)
;-> (("A" (10 30) (30 0)) ("B" (0 50) (10 50)) ("C" (30 30)))

; Trova e ordina le chiavi
(setq keys (sort (unique (map first lst))))
;-> ("A" "B" "C")
; Lista soluzione
(setq out '())
; per ogni chiave...
(dolist (key keys)
  ; elemento corrente
  (setq element (list key))
  ; ricerca della chiave negli elementi della lista
  ; e aggiornamento dell'elemento corrente
  (extend element (find-all (list key '*) lst (slice $it 1)))
  ;(dolist (el lst) (if (= key (el 0)) (extend element (list (slice el 1)))))
  ;(dolist (el lst) (if (= key (el 0)) (push (slice el 1) element -1)))
  ; inserimento elemento corrente nella lista soluzione
  (push element out -1)
)
;-> (("A" (10 30) (30 0)) ("B" (0 50) (10 50)) ("C" (30 30)))

Mettendo tutto insieme:

(define (merge-key lst flattened)
  (local (out keys element)
    ; Trova e ordina le chiavi
    (setq keys (sort (unique (map first lst))))
    ; Lista soluzione
    (setq out '())
    ; Per ogni chiave...
    (dolist (key keys)
      ; Elemento corrente
      (setq element (list key))
      ; Ricerca della chiave negli elementi della lista
      ; e aggiornamento dell'elemento corrente
      (extend element (find-all (list key '*) lst (slice $it 1)))
      ;(dolist (el lst) (if (= key (el 0)) (extend element (list (slice el 1)))))
      ;(dolist (el lst) (if (= key (el 0)) (push (slice el 1) element -1)))
      ; Inserimento elemento corrente nella lista soluzione
      (if flattened 
        (push (flat element) out -1)
        (push element out -1)))
    out))

Proviamo:

(merge-key lst)
;-> (("A" (10 30) (30 0)) ("B" (0 50) (10 50)) ("C" (30 30)))

(merge-key lst true)
;-> (("A" 10 30 30 0) ("B" 0 50 10 50) ("C" 30 30))

Test di velocità:
100 persone
10000 righe
valori da 0 a 1000
(silent (setq test (array-list (array 10000 100 (rand 1001 (* 10000 100))))))
(time (setq res (merge-key test)))
;-> 312.418

100 persone
100000 righe
valori da 0 a 1000
(silent (setq test (array-list (array 100000 100 (rand 1001 (* 100000 100))))))
(time (setq res (merge-key test)))
;-> 7438.243


------------------------
Cruciverba e crucinumero
------------------------ 

Dato un cruciverba con sole caselle bianche e nere, generare un cruciverba con i numeri delle definizioni orizzontali e verticali.
Per esempio, partendo dal seguente cruciverba:

  +------+------+------+------+------+------+------+
  |      |      |      |      |      |      |██████|
  |      |      |      |      |      |      |██████|
  +------+------+------+------+------+------+------+
  |      |██████|      |      |      |██████|      |
  |      |██████|      |      |      |██████|      |
  +------+------+------+------+------+------+------+
  |      |      |██████|      |██████|      |      |
  |      |      |██████|      |██████|      |      |
  +------+------+------+------+------+------+------+
  |      |      |      |██████|██████|      |      |
  |      |      |      |██████|██████|      |      |
  +------+------+------+------+------+------+------+
  |██████|      |      |██████|██████|      |      |
  |██████|      |      |██████|██████|      |      |
  +------+------+------+------+------+------+------+
  |      |      |██████|      |██████|      |      |
  |      |      |██████|      |██████|      |      |
  +------+------+------+------+------+------+------+
  |      |██████|      |      |      |██████|      |
  |      |██████|      |      |      |██████|      |
  +------+------+------+------+------+------+------+
  |      |      |      |      |      |      |██████|
  |      |      |      |      |      |      |██████|
  +------+------+------+------+------+------+------+

Bisogna generare il seguente cruciverba:

   +------+------+------+------+------+------+------+
   |1     |      |2     |3     |4     |      |██████|
   |      |      |      |      |      |      |██████|
   +------+------+------+------+------+------+------+
   |      |██████|5     |      |      |██████|6     |
   |      |██████|      |      |      |██████|      |
   +------+------+------+------+------+------+------+
   |7     |8     |██████|      |██████|9     |      |
   |      |      |██████|      |██████|      |      |
   +------+------+------+------+------+------+------+
   |10    |      |11    |██████|██████|12    |      |
   |      |      |      |██████|██████|      |      |
   +------+------+------+------+------+------+------+
   |██████|13    |      |██████|██████|14    |      |
   |██████|      |      |██████|██████|      |      |
   +------+------+------+------+------+------+------+
   |15    |      |██████|16    |██████|17    |      |
   |      |      |██████|      |██████|      |      |
   +------+------+------+------+------+------+------+
   |      |██████|18    |      |19    |██████|      |
   |      |██████|      |      |      |██████|      |
   +------+------+------+------+------+------+------+
   |20    |      |      |      |      |      |██████|
   |      |      |      |      |      |      |██████|
   +------+------+------+------+------+------+------+

Definizioni Orizzontali: 1 5 7 9 10 12 13 14 15 17 18 20
Definizioni Verticali: 1 2 3 4 6 8 9 11 15 16 18 19

Rappresentiamo il cruciverba come una matrice:

0 = casella vuota
* = casella piena

(setq cruci '((0 0 0 0 0 0 "*")
              (0 "*" 0 0 0 "*" 0)
              (0 0 "*" 0 "*" 0 0)
              (0 0 0 "*" "*" 0 0)
              ("*" 0 0 "*" "*" 0 0)
              (0 0 "*" 0 "*" 0 0)
              (0 "*" 0 0 0 "*" 0)
              (0 0 0 0 0 0 "*")))

Funzione che stampa un cruciverba:

(define (print-cruci cruci)
  (setq righe (length cruci))
  (setq colonne (length (cruci 0)))
  (for (r 0 (- righe 1))
    (for (c 0 (- colonne 1))
      (cond ((= (cruci r c) 0) (print " . "))
            ((= (cruci r c) "*") (print " ■ "))
            (true (print (format "%2d " (cruci r c)))))
    )
    (println)) '>)

(print-cruci cruci)
;-> .  .  .  .  .  .  ■
;-> .  ■  .  .  .  ■  .
;-> .  .  ■  .  ■  .  .
;-> .  .  .  ■  ■  .  .
;-> ■  .  .  ■  ■  .  .
;-> .  .  ■  .  ■  .  .
;-> .  ■  .  .  .  ■  .
;-> .  .  .  .  .  .  ■

Il primo passo è quello di trovare le caselle di inizio delle definizioni orizzontali e verticali.

Caselle con definizione orizzontale:
- hanno una casella libera a destra e una casella occupata a sinistra
Attenzione alle caselle particolari della prima e ultima colonna.

Caselle con definizione verticale:
- hanno una casella libera in basso e una casella occupata in alto
Attenzione alle caselle particolari della prima e ultima riga.

Funzione che verifica se una casella è una casella di inizio di una definizione orizzontale o verticale:

(define (check mx r c)
  (setq righe (length mx))
  (setq colonne (length (mx 0)))
  ; orizzontali
  (cond ((= (mx r c) "*") nil)
        ((= c 0)
          (if (!= (mx r (+ c 1)) "*") (push (list r c "O") marked -1)))
        ((= c (- colonne 1)) nil)
        (true ; (and (!= c 0) (!= c (- colonne 1)))
          (if (and (!= (mx r (+ c 1)) "*") (= (mx r (- c 1)) "*"))
              (push (list r c "O") marked -1)))
  )
  ; verticali
  (cond ((= (mx r c) "*") nil)
        ((= r 0)
          (if (!= (mx (+ r 1) c) "*") (push (list r c "V") marked -1)))
        ((= r (- righe 1)) nil)
        (true ; (and (!= r 0) (!= r (- righe 1)))
          (if (and (!= (mx (+ r 1) c) "*") (= (mx (- r 1) c) "*"))
              (push (list r c "V") marked -1)))
  )
)

Funzione che trova le caselle iniziali per le definizioni orizzontali e verticali:

(define (trova-caselle cruci)
  (setq righe (length cruci))
  (setq colonne (length (cruci 0)))
  (setq marked '())
  (for (r 0 (- righe 1))
    (for (c 0 (- colonne 1))
      (check cruci r c)
    )
  )
  marked)

(setq caselle (trova-caselle cruci))
;-> ((0 0 "O") (0 0 "V") (0 2 "V") (0 3 "V") (0 4 "V") (1 2 "O") 
;->  (1 6 "V") (2 0 "O") (2 1 "V") (2 5 "O") (2 5 "V") (3 0 "O")
;->  (3 2 "V") (3 5 "O") (4 1 "O") (4 5 "O") (5 0 "O") (5 0 "V")
;->  (5 3 "V") (5 5 "O") (6 2 "O") (6 2 "V") (6 4 "V") (7 0 "O"))

Adesso dobbiamo numerare le caselle delle definizioni.
Attenzione al fatto che una casella può essere l'inizio di una definizione orizzontale e anche l'inizio di una definizione verticale (per esempio la casella (0 0)) e quindi devono avere lo stesso numero.

Funzione che numera le caselle delle definizioni:

(define (numera-caselle lst)
  (setq numerate lst)
  (setq number 0)
  (dolist (el lst)
    (cond ((= (el 2) "O") ; numera orizzontali
            (++ number)
            (push number (numerate $idx) -1))
          ((= (el 2) "V") ; numera verticali
            (if (find (list (el 0) (el 1) "O" '?) numerate match)
                (begin (push ($0 3) (numerate $idx) -1))
                (begin (++ number) (push number (numerate $idx) -1)))))
  )
  numerate)

(setq caselle-numerate (numera-caselle caselle))
;-> ((0 0 "O" 1) (0 0 "V" 1) (0 2 "V" 2) (0 3 "V" 3) (0 4 "V" 4) 
;->  (1 2 "O" 5) (1 6 "V" 6) (2 0 "O" 7) (2 1 "V" 8) (2 5 "O" 9)
;->  (2 5 "V" 9) (3 0 "O" 10) (3 2 "V" 11) (3 5 "O" 12) (4 1 "O" 13)
;->  (4 5 "O" 14) (5 0 "O" 15) (5 0 "V" 15) (5 3 "V" 16) (5 5 "O" 17)
;->  (6 2 "O" 18) (6 2 "V" 18) (6 4 "V" 19) (7 0 "O" 20))

A questo punto dobbiamo aggiornare la matrice 'cruci' con i numeri delle definizioni:

(dolist (el caselle-numerate) (setf (cruci (el 0) (el 1)) (el 3)))
;-> 20

Stampiamo il cruciverba finale:

(print-cruci cruci)
;->  1  .  2  3  4  .  ■
;->  .  ■  5  .  .  ■  6
;->  7  8  ■  .  ■  9  .
;-> 10  . 11  ■  ■ 12  .
;->  ■ 13  .  ■  ■ 14  .
;-> 15  .  ■ 16  ■ 17  .
;->  .  ■ 18  . 19  ■  .
;-> 20  .  .  .  .  .  ■

Creiamo la lista dei numeri delle definizioni:

(setq oriz (find-all '(? ? "O" ?) caselle-numerate))
;-> ((0 0 "O" 1) (1 2 "O" 5) (2 0 "O" 7) (2 5 "O" 9) (3 0 "O" 10)
;->  (3 5 "O" 12) (4 1 "O" 13) (4 5 "O" 14) (5 0 "O" 15) (5 5 "O" 17)
;->  (6 2 "O" 18) (7 0 "O" 20))

(setq vert (find-all '(? ? "V" ?) caselle-numerate))
;-> ((0 0 "V" 1) (0 2 "V" 2) (0 3 "V" 3) (0 4 "V" 4) (1 6 "V" 6)
;->  (2 1 "V" 8) (2 5 "V" 9) (3 2 "V" 11) (5 0 "V" 15) (5 3 "V" 16)
;->  (6 2 "V" 18) (6 4 "V" 19))

(setq oriz-def (flat (map 3 oriz)))
;-> (1 5 7 9 10 12 13 14 15 17 18 20)

(setq vert-def (flat (map 3 vert)))
;-> (1 2 3 4 6 8 9 11 15 16 18 19)

Infine vediamo una funzione per creare un cruciverba (solo caselle bianche o nere) casuale:

(define (crea-cruci righe colonne caselle-nere)
  (let (k 0)
    (setq cruci (array-list (array righe colonne '(0))))
    (while (<= k caselle-nere)
      (setq r (rand righe))
      (setq c (rand colonne))
      (unless (= (cruci r c) "*")
        (setf (cruci r c) "*")
        (++ k)))
    cruci))

(print-cruci (crea-cruci 10 10 20))
;->  .  .  .  ■  .  ■  ■  .  .  .
;->  ■  ■  .  .  .  .  ■  .  ■  .
;->  .  .  .  .  .  .  .  .  .  .
;->  ■  .  .  .  .  .  .  .  ■  .
;->  .  .  ■  ■  .  .  .  .  .  .
;->  .  ■  .  ■  ■  ■  .  .  .  .
;->  .  .  .  .  .  .  ■  .  .  .
;->  .  .  .  .  .  ■  .  .  ■  .
;->  .  .  .  .  .  .  .  ■  .  .
;->  .  .  .  .  ■  .  .  .  .  ■

Nota: la creazione delle definizioni del cruciverba va fatta a mano.
Possiamo anche creare un crucinumero (che è più semplice) partendo dal cruciverba di esempio:

  +------+------+------+------+------+------+------+
  |1     |      |2     |3     |4     |      |██████|
  |      |      |      |      |      |      |██████|
  +------+------+------+------+------+------+------+
  |      |██████|5     |      |      |██████|6     |
  |      |██████|      |      |      |██████|      |
  +------+------+------+------+------+------+------+
  |7     |8     |██████|      |██████|9     |      |
  |      |      |██████|      |██████|      |      |
  +------+------+------+------+------+------+------+
  |10    |      |11    |██████|██████|12    |      |
  |      |      |      |██████|██████|      |      |
  +------+------+------+------+------+------+------+
  |██████|13    |      |██████|██████|14    |      |
  |██████|      |      |██████|██████|      |      |
  +------+------+------+------+------+------+------+
  |15    |      |██████|16    |██████|17    |      |
  |      |      |██████|      |██████|      |      |
  +------+------+------+------+------+------+------+
  |      |██████|18    |      |19    |██████|      |
  |      |██████|      |      |      |██████|      |
  +------+------+------+------+------+------+------+
  |20    |      |      |      |      |      |██████|
  |      |      |      |      |      |      |██████|
  +------+------+------+------+------+------+------+

Orizzontali:
 1. Prime 6 cifre di pi greco
 5. Titolo di una serie televisiva
 7. Mezza verità
 9. Se hai fatto 30, ...
10. Spedizione garibaldina meno 1
12. La maggiore età
13. Numero con 4 'buchi'
14. Metà I Ching
15. Apostoli
17. Numero somma di due quadrati uguali (x^2 + x^2)
18. Numero atomico Umbitrio
20. Prime 6 cifre di e

Verticali:
 1. Taxi di Ramanujan
 2. Squadra di calcio
 3. Levi's Jeans
 4. Paura
 6. Prime 6 cifre di e
 8. Italia mondiali di calcio
 9. "Chiamate Roma ..."
11. Numero somma di due quadrati uguali (x^2 + x^2)
15. Il 32-esimo primo
16. Prefisso della Mauritania
18. Ore della passione di Cristo
19. Numero atomico dello Stronzio

Soluzione:
  141592■
  7■100■7
  21■1■31
  999■■18
  ■88■■32
  12■2■18
  2■123■1
  718281■


----------------------------------
Interesse composto e il numero 'e'
----------------------------------

Il numero 'e' è la base dei logaritmi naturali e vale:

  2.718281828459045235360287471352662497757...

Il numero 'e' viene definito come:

  e = lim(1 + 1/x)^x
     x->inf

(define (e1 x) (pow (add 1 (div x)) x))

oppure come:

  e = Sum[k=0,inf](1/k!)

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (e2 x)
  (let (sum 0)
    (for (k 0 x) (inc sum (div (fact-i k))))))

Proviamo:

(e1 5)
;-> 2.48832
(e2 5)
;-> 2.716666666666666

(e1 10)
;-> 2.593742460100002
(e2 10)
;-> 2.718281801146385

(e1 100)
;-> 2.704813829421529
(e2 100)
;-> 2.718281828459046

(e1 1000)
;-> 2.71692393223552
(e2 1000)
;-> 2.718281828459046

Nota: la funzione "e2" converge ad 'e' più rapidamente della funzione "e1".

(e1 1e6)
;-> 2.718280469156428

L'interesse composto è l'interesse che si riceve su un importo principale, che è compreso dell'interesse accumulato dai periodi precedenti su un deposito o di un prestito.
In altre parole, è l'interesse guadagnato sul denaro che era già stato guadagnato come interesse o l'"interesse sugli interessi".

  V = C * (1 + I/F)^(F*T)

  dove:  V = Valore futuro
         C = Capitale iniziale
         I = Interesse (0..1)
         F = Frequenza di erogazione (numero di erogazioni all'anno)
         T = Tempo (anni)

Frequenza: numero di volte all'anno che i pagamenti di interessi sono erogati.
L'interesse è spesso composto su base annuale, semestrale, trimestrale o mensile, ma può anche essere composto su base quotidiana o anche in modo continuo.
In generale, più frequentemente l'interesse viene erogato, maggiore sarà il valore futuro del vostro denaro.
Ma fino a quanto possiamo arrivare?

Tasso di interesse: percentuale di interesse sul capitale.
L'interesse composto ha un impatto maggiore sugli investimenti con tempi più lunghi rispetto a quelli più brevi.

(define (composto capitale interesse frequenza anni)
  (mul capitale (pow (add 1 (div interesse frequenza)) (mul frequenza anni))))

Facciamo alcuni esempi:

capitale = 10
interesse = 10% = 0.1
frequenza = semestrale = 2 (volte all'anno)
anni = 5
(composto 10 0.1 2 5)
;-> 16.28894626777442

capitale = 10
interesse = 100% = 1
frequenza = trimestrale = 4 (volte all'anno)
anni = 5
(composto 10 1 4 5)
;-> 867.3617379884036

Nota: per sapere quanti anni occorrono per raddoppiare il capitale con un dato interesse (%) a frequenza annuale possiamo usare una formula approssimata: Anni = 72/Interesse

(define (anni interesse) (div 72 interesse))

Per esempio con un capitale di 10 e un interesse del 5%:
(anni 5)
;-> 14.4

(composto 10 0.05 1 14.4)
;-> 20.18951594467986

Possiamo notare che ponendo:
  capitale  --> C = 1
  interesse --> I = 1
  anni      --> T = 1
  frequenza --> F = x

le formule per 'e' e per l'interesse composto sono le stesse:

   e = lim(1 + 1/x)^x
     x->inf

   V = C * (1 + I/F)^(F*T) = 1 * (1 + 1/x)^x

Verifichiamolo:

(e 10)
;-> 2.593742460100002
(composto 1 1 10 1)
;-> 2.593742460100002
(e 100)
;-> 2.704813829421529
(composto 1 1 100 1)
;-> 2.704813829421529
(e 1e6)
;-> 2.718280469156428
(composto 1 1 1e6 1)
;-> 2.718280469156428

Questo significa che, in un anno, il nostro capitale può aumentare al massimo di 'e' volte (cioè 2.7182818284 volte) anche se la frequenza di erogazione è istantanea (cioè vale infinito).


--------------------------------
Corsa tra fattori pari e dispari
--------------------------------

Ogni numero può essere espresso come una moltiplicazione di numeri primi (scomposizione in fattori primi).
Per esempio:
Chiamiamo 'f-pari' i numeri la cui scomposizione in fattori primi ha un numero pari di fattori.
Chiamiamo 'f-dispari' i numeri la cui scomposizione in fattori primi ha un numero dispari di fattori.
Per convenzione il numero 1 vale pari.
Per i primi 10 numeri abbiamo:

      f-pari: 1     4   6     9 10
        freq: 1     2   3     4  5

   f-dispari:   2 3   5   7 8
        freq:   1 2   3   4 5

I numeri f-pari e f-dispari sembrano avere un numero di occorrenze simile.

Supponiamo di contare le occorrenze e confrontarle per ogni numero:

  +--------+--------------+-----------------+-------------------+
  | Numero | Conta f-pari | Conta f-dispari | Confronto         |
  +--------+--------------+-----------------+-------------------+
  |   1    |      1       |      0          | f-pari > fdispari |
  |   2    |      1       |      1          | f-pari = fdispari |
  |   3    |      1       |      2          | f-pari < fdispari |
  |   4    |      2       |      2          | f-pari = fdispari |
  |   5    |      2       |      3          | f-pari < fdispari |
  |   6    |      3       |      3          | f-pari = fdispari |
  |   7    |      3       |      4          | f-pari < fdispari |
  |   8    |      3       |      5          | f-pari < fdispari |
  |   9    |      4       |      5          | f-pari < fdispari |
  |  10    |      5       |      5          | f-pari = fdispari |
  |  11    |     ...      |     ...         |       ...         |
  +--------+--------------+-----------------+-------------------+

A parte per il numero 1, risulta che 'f-pari' è sempre minore o uguale a 'f-dispari'.

Nel 1919 George Polya congetturò che 'f-pari' non avrebbe mai sorpassato 'f-dispari' (a parte all'inizio con il numero 1).
Nel 1980 Minoru Tanaka dimostrò che 'f-pari' supera f-dispari al numero 906150257.

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (factor-pari? num) (even? (length (factor num))))
(define (factor-dispari? num) (odd? (length (factor num))))

(filter dispari? (sequence 1 10))
;-> (2 3 5 7 8)
(filter pari? (sequence 1 10))
;-> (1 4 6 9 10)

(define (check max-num)
  (let ( (pp 0) (dd 0) )
    (for (num 1 max-num)
      (if (even? (length (factor num)))
        (begin
          (++ pp)
          (if (> pp dd) (println "Pari in vantaggio a: " num " (" pp " " dd ")")))
        ;else
        (++ dd)))))

Proviamo:

(time (check 1e6))
;-> Pari in vantaggio a: 1
;-> 718.575
(time (check 1e7))
;-> Pari in vantaggio a: 1
;-> 15845.172
(time (check 1e8))
;-> Pari in vantaggio a: 1
;-> 407362.197
(time (check 906150257))
;-> Pari in vantaggio a: 1 (1 0)
;-> Pari in vantaggio a: 906150257 (453075129 453075128)
;-> 9400713.805 ; 2h 36m 40s 713ms
(+ 453075129 453075128)
;-> 906150257


-----------------------
Elemento di maggioranza
-----------------------

Data una lista di N elementi determinare se esiste un elemento di maggioranza.
Un elemento è detto di maggioranza se il numero delle sue occorrenze è maggiore di N/2.

1) Soluzione O(N^2)
-------------------
Doppio ciclo: per ogni elemento della lista (primo ciclo), calcolare quante volte questo elemento appare nella lista (secondo ciclo).

(define (major1 lst)
  (local (len stop conta soglia res)
    (setq len (length lst))
    (setq soglia (/ len 2))
    (setq stop nil)
    ; per ogni elemento...
    (dolist (el1 lst stop)
      (setq conta 0)
      ; contiamo quante volte compare
      (dolist (el2 lst stop)
        (if (= el1 el2) (++ conta))
        ; se supera len/2 allora questo è l'elemento di maggioranza
        ; e fermiamo i due cicli
        (if (> conta soglia) (set 'res el1 'stop true))
      )
    )
    res))

(setq a '(1 1 2 3 1 1 1 1 2 2 1 9 8))
(setq b '(1 1 2 2 2 2 2 1 3 4 2))
(major1 a)
;-> 1
(major1 b)
;-> 2

2) Soluzione O(NlogN)
---------------------
Ordiniamo la lista.
Scorriamo la lista, quando incontriamo un nuovo elemento, controlliamo se il conteggio dell'elemento precedente era maggiore della soglia di maggioranza. In tal caso abbiamo trovato l'elemento di maggioranza.
All'uscita del ciclo controlliamo il conteggio dell'ultimo elemento della lista.

(define (major2 lst)
  (local (len stop conta soglia res)
    (setq len (length lst))
    (setq soglia (/ len 2))
    (cond ((= len 1) (setq res (lst 0)))
          (true
            (sort lst)
            (setq conta 1)
            (setq stop nil)
            (for (i 1 (- len 1) 1 stop)
              (if (= (lst (- i 1)) (lst i))
                  (++ conta)
                  ;else
                  (begin
                    (if (> conta soglia) (set 'res (lst (- i 1)) 'stop true))
                    (setq conta 1))
              )
            )
            ; controllo dell'ultimo elemento
            (if (> conta soglia) (setq res (lst -1)))))
     res))

(major2 a)
;-> 1
(major2 b)
;-> 2

3) Soluzione O(N)
Attraversare la lista e, per ogni elemento, aggiornare il suo conteggio in una hash-map.
Dopo aver aggiornato il conteggio, controlla se supera la soglia di maggioranza. In tal caso abbiamo trovato l'elemento di maggioranza.

(define (major3 lst)
  (new Tree 'hash)
  (let ( (res nil) (stop nil) (soglia (/ (length lst) 2)) )
    (dolist (el lst stop)
      ; se il numero non esiste nella hash-map...
      (if (= (hash el) nil)
          ; allora inserisce il numero con conteggio 1
          (hash el 1)
          ; else
          ; altrimenti aumenta il conteggio esistente
          (hash el (+ $it 1)))
      ; controllo superamento soglia
      (if (> (hash el) soglia) (set 'res el 'stop true))
    )
    ;(println (hash))
    ; elimina la hash-map (operazione lenta)
    (delete 'hash)
    res))

(major3 a)
;-> 1
(major3 b)
;-> 2

4) Soluzione newLISP
--------------------
Usiamo "unique" per calcolare i valori univoci
Usiamo "count" per contare le occorrenze dei valori univoci
Usiamo "find" per trovare l'indice del numero di maggioranza (se esiste)

(define (major4 lst)
  (local (soglia unici conta idx)
    ; calcola la soglia di maggioranza
    (setq soglia (/ (length lst) 2))
    ; lista con elementi unici di lst
    (setq unici (unique lst))
    ; conta gli elementi unici in lst
    (setq conta (count unici lst))
    ; esiste un conteggio maggiore di soglia?
    (setq idx (find soglia conta <))
    ; se esiste, restituisce il numero di maggioranza
    ; altrimenti restituisce nil
    (if idx (unici idx) nil)))

(major4 a)
;-> 1
(major4 b)
;-> 2

Confronto di velocità
---------------------
"major1" funziona con liste e vettori
"major2" funziona con liste e vettori
"major3" funziona con liste e vettori
"major4" funziona con liste

Prova con una lista di 20001 elementi in cui esiste un elemento di maggioranza:

(define (crea-lista elements max-num M)
  (randomize (append (rand max-num elements) (dup M (+ elements 1)))))

(setq tl1 (crea-lista 10000 10000 42))
(setq tv1 (array 20001 tl1))

(= (major1 tl1) (major1 tv1) (major2 tl1) (major2 tv1)
   (major3 tl1) (major3 tv1) (major4 tl1))
;-> true

(time (major1 tl1))
;-> 4.936
(time (major1 tv1))
;-> 4.986

(time (major2 tl1))
;-> 761.972
(time (major2 tv1))
;-> 3.99

(time (major3 tl1))
;-> 18.93
(time (major3 tv1))
;-> 18.923

(time (major4 tl1))
;-> 12.966

Prova con una lista di 20000 elementi in cui non esiste un elemento di maggioranza:

(setq tl2 (rand 10000 20000))
(setq tv2 (array 20000 tl2))

(= (major1 tl2) (major1 tv2) (major2 tl2) (major2 tv2)
   (major3 tl2) (major3 tv2) (major4 tl2))
;-> true

(time (major1 tl2))
;-> 33621.155
(time (major1 tv2))
;-> 32987.844

(time (major2 tl2))
;-> 3321.227
(time (major2 tv2))
;-> 6.012

(time (major3 tl2))
;-> 22.943
(time (major3 tv2))
;-> 21.972

(time (major4 tl2))
;-> 19.962

La più veloce è "major2" con i vettori.


------------------------
Tastiere QWERTY e DVORAK
------------------------

Il layout delle tastiere QWERTY ANSI (US) è il seguente:
(vedi immagine "qwerty.png" nella cartella "data")

Riga1:
upper: ~ ! @ # $ % ^ & * ( ) _ +
lower: ` 1 2 3 4 5 6 7 8 9 0 - =

Riga2:
upper:   Q W E R T Y U I O P { } |
lower:   q w e r t y u i o p [ ] \

Riga3:
upper:   A S D F G H J K L : "
lower:   a s d f g h j k l ; '

Riga4:
upper:   Z X C V B N M < > ?
lower:   z x c v b n m , . /

Il layout delle tastiere DVORAK (US) è il seguente:
(vedi immagine "dvorak.png" nella cartella "data")

Riga1:
upper:   ~ ! @ # $ % ^ & * ( ) { }
lower:   ` 1 2 3 4 5 6 7 8 9 0 [ ]

Riga2:
upper:   " < > P Y F G C R L ? + |
lower:   ' , . p y f g c r l / = \

Riga3:
upper:   A O E U I D H T N S _
lower:   a o e u i d h t n s -

Riga4:
upper:   : Q J K X B M W V Z
lower:   ; q j k x b m w v z

Riga1:
(setq a '("~" "!" "@" "#" "$" "%" "^" "&" "*" "(" ")" "_" "+"))
(setq b '("~" "!" "@" "#" "$" "%" "^" "&" "*" "(" ")" "{" "}"))
(setq row1up (map list a b))
;-> (("~" "~") ("!" "!") ("@" "@") ("#" "#") ("$" "$") ("%" "%")
;->  ("^" "^") ("&" "&") ("*" "*") ("(" "(") (")" ")") ("_" "{")
;->  ("+" "}"))
(setq a '("`" "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" "-" "="))
(setq b '("`" "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" "[" "]"))
(setq row1down (map list a b))
;-> (("`" "`") ("1" "1") ("2" "2") ("3" "3") ("4" "4") ("5" "5")
;->  ("6" "6") ("7" "7") ("8" "8") ("9" "9") ("0" "0") ("-" "[")
;->  ("=" "]"))
(setq r1 (append row1down row1up))

Riga2:
(setq a '("Q" "W" "E" "R" "T" "Y" "U" "I" "O" "P" "{" "}" "|"))
(setq b '("\"" "<" ">" "P" "Y" "F" "G" "C" "R" "L" "?" "+" "|"))
(setq row2up (map list a b))
;-> (("Q" "\"") ("W" "<") ("E" ">") ("R" "P") ("T" "Y") ("Y" "F")
;->  ("U" "G") ("I" "C") ("O" "R") ("P" "L") ("{" "?") ("}" "+")
;->  ("|" "|"))
(setq a '("q" "w" "e" "r" "t" "y" "u" "i" "o" "p" "[" "]" "\\"))
(setq b '("'" "," "." "p" "y" "f" "g" "c" "r" "l" "/" "=" "\\"))
(setq row2down (map list a b))
;-> (("q" "'") ("w" ",") ("e" ".") ("r" "p") ("t" "y") ("y" "f")
;->  ("u" "g") ("i" "c") ("o" "r") ("p" "l") ("[" "/") ("]" "=")
;->  ("\\" "\\"))
(setq r2 (append row2down row2up))

Riga3:
(setq a '("A" "S" "D" "F" "G" "H" "J" "K" "L" ":" "\""))
(setq b '("A" "O" "E" "U" "I" "D" "H" "T" "N" "S" "_"))
(setq row3up (map list a b))
;-> (("A" "A") ("S" "O") ("D" "E") ("F" "U") ("G" "I") ("H" "D")
;->  ("J" "H") ("K" "T") ("L" "N") (":" "S") ("\"" "_"))
(setq a '("a" "s" "d" "f" "g" "h" "j" "k" "l" ";" "'"))
(setq b '("a" "o" "e" "u" "i" "d" "h" "t" "n" "s" "-"))
(setq row3down (map list a b))
;-> (("a" "a") ("s" "o") ("d" "e") ("f" "u") ("g" "i") ("h" "d")
;->  ("j" "h") ("k" "t") ("l" "n") (";" "s") ("'" "-"))
(setq r3 (append row3down row3up))

Riga4:
(setq a '("Z" "X" "C" "V" "B" "N" "M" "<" ">" "?"))
(setq b '(":" "Q" "J" "K" "X" "B" "M" "W" "V" "Z"))
(setq row4up (map list a b))
;-> (("Z" ":") ("X" "Q") ("C" "J") ("V" "K") ("B" "X") ("N" "B")
;->  ("M" "M") ("<" "W") (">" "V") ("?" "Z"))
(setq a '("z" "x" "c" "v" "b" "n" "m" "," "." "/"))
(setq b '(";" "q" "j" "k" "x" "b" "m" "w" "v" "z"))
(setq row4down (map list a b))
;-> (("z" ";") ("x" "q") ("c" "j") ("v" "k") ("b" "x") ("n" "b")
;->  ("m" "m") ("," "w") ("." "v") ("/" "z"))
(setq r4 (append row4down row4up))

Unione di tutte le righe (+ lo spazio " "):
; lista associativa da qwerty a dvorak
(setq q-v (append r1 r2 r3 r4 '((" " " "))))
; lista associativa da dvorak a qwerty
(setq v-q (map (fn(x) (list (x 1) (x 0))) q-v))

Proviamo:
(setq str "quanto divertimento... newLISP")
(setq out "")
(dolist (ch (explode str)) (extend out (lookup ch q-v)))
;-> "'gabyr eck.pycm.byrvvv b.,NCOL"

(setq str1 "'gabyr eck.pycm.byrvvv b.,NCOL")
(setq out "")
(dolist (ch (explode str1)) (extend out (lookup ch v-q)))
;-> "quanto divertimento... newLISP"

Funzione che converte da QWERTY a DVORAK:

(define (qwerty-dvorak str)
  (local (out partner)
    (setq out "")
    (dolist (ch (explode str))
      (setq partner (lookup ch q-v))
      (if partner
        (extend out partner)
        (extend out ch)))
    out))

(qwerty-dvorak str)
;-> "'gabyr eck.pycm.byrvvv b.,NCOL"

Funzione che converte da DVORAK a QWERTY:

(define (dvorak-qwerty str)
  (local (out partner)
    (setq out "")
    (dolist (ch (explode str))
      (setq partner (lookup ch v-q))
      (if partner
        (extend out partner)
        (extend out ch)))
    out))

(dvorak-qwerty str1)
;-> "quanto divertimento... newLISP"

(setq str "Prima Linea\n\tSeconda Linea")
(dvorak-qwerty (qwerty-dvorak str)))
;-> "Prima Linea\n\tSeconda Linea"

(println (dvorak-qwerty (qwerty-dvorak str)))
;-> Prima Linea
;->         Seconda Linea


---------------------------------
Raddoppiare l'area di un quadrato
---------------------------------

Dato un quadrato ABCD costruire un quadrato di area doppia.

Vediamo prima analiticamente.
L'area del quadrato dato vale A1 = l1*l1 dove l1 è il lato del quadrato.
Il quadrato da costruire ha area doppia pari a A2 = 2*A1 = 2*l1*l1.
Quindi il lato del quadrato A2 vale l2 = sqrt(2*l*l) = l1*sqrt(2).
Notiamo che l1*sqrt(2) è anche la lunghezza della diagonale d1 del quadrato A1:
d1 = sqrt(l1^2 + l1^2) = sqrt(2*l1^2) = l1*sqrt(2).
Quindi il quadrato di area doppia A2 può essere costruito sapendo che il suo lato è uguale alla diagonale del quadrato A1.
La soluzione geometrica di questo problema viene attribuita al filosofo greco Socrate.

Dato il quadrato ABCD:

  D +-----------+
    |           | C
    |           |
    |           |
    |           |
  A +-----------+
                B

Prolungare il lato AB in modo che AB = BE

  D +-----------+
    |           | C
    |           |
    |           |
    |           |
  A +-----------+-----------+ E
                B

Costruire il quadrato BEFC:

  D +-----------+-----------+ F
    |           | C         |
    |           |           |
    |           |           |
    |           |           |
  A +-----------+-----------+ E
                B

Costruire in modo analogo i quadrati CFGK e DCKL:

                K
  L +-----------+-----------+ G
    |           |           |
    |           |           |
    |           |           |
    |           |           |
  D +-----------+-----------+ F
    |           | C         |
    |           |           |
    |           |           |
    |           |           |
  A +-----------+-----------+ E
                B

Il quadrato DBFK ha area doppia del quadrato dato ABCD.
La diagonale DB è un lato del quadrato.


-------------------------------------------
Reti di lunghezza minima - Punti di Steiner
-------------------------------------------

Ci sono quattro città disposte sui vertici di un quadrato ABCD.
Il lato del quadrato vale 100 m.
Come possiamo connettere tutti i punti (A, B, C, e D) tra loro utilizzando una rete di lunghezza minima?

La rete minima non è semplicemente la somma dei segmenti che connettono i vertici del quadrato.
È necessario introdurre il concetto di punti di Steiner, che sono punti aggiuntivi all'interno del quadrato.
Per un quadrato, la soluzione ottimale include due punti di Steiner.
I punti di Steiner ottimali si trovano all'interno del quadrato in modo tale che gli angoli tra i segmenti collegati a ciascun punto siano di 120 gradi. (in altre parole un punto di Steiner in una rete ottimale forma angoli di 120 gradi con ciascuno dei tre segmenti che si collegano ai vertici a cui è associato.
I punti di Steiner si trovano lungo il segmento verticale (o orizzontale) che divide in quadrato in due rettangoli uguali.
Per il quadrato ABCD, i due punti di Steiner formano una forma simile a una stella con i quattro vertici.
Vedi immagine "steiner.png" nella cartella "data".

Per calcolare la posizione dei punti di Steiner occorre usare un pò di geometria e di trigonometria.
Abbiamo un triangolo isoscele ABC in cui l'angolo compreso tra i lati uguali (AB e AC) vale 120 gradi.
L'altro lato del triangolo è il lato del quadrato.
Consideriamo un triangolo isoscele ABC, dove i lati AB e AC sono uguali, e l'angolo in A è di 120 gradi.
Il lato BC ha lunghezza L (che è anche il lato del nostro quadrato).
Dobbiamo trovare l'altezza del triangolo:
Tracciamo l'altezza h che cade perpendicolare dal vertice A alla base BC.
Questo divide il triangolo in due triangoli rettangoli congruenti.
Ogni triangolo rettangolo ha un angolo alla base di 30 gradi (dato che l'angolo in A è diviso in due, 120 gradi / 2 = 60 gradi, e quindi l'altro angolo del triangolo rettangolo è 90 gradi - 60 gradi = 30 gradi).
Nel triangolo rettangolo, l'altezza h è il cateto opposto all'angolo di 30 gradi, e la metà della base BC/2 = L/2 è il cateto adiacente.
Possiamo quindi usare la funzione tangente:

  tan(30 gradi) = h/(L/2)

Sappiamo che tan(30^circ) = 1/sqrt(3), quindi possiamo scrivere:

  1/sqrt(3) = h/(L/2)

Quindi l'altezza h vale:

  h = (L/2)/(2*sqrt(3)) = L/(2*sqrt(3)) = L*sqrt(3)/6

Nel nostro caso h = 100*sqrt(3)/6 = 28.86751345948129

(div (mul 100 (sqrt 3)) 6)
;-> 28.86751345948129

Per trovare la lunghezza del lato AB (che è uguale a AC nel nostro triangolo isoscele), possiamo applicare il teorema del coseno, dato che conosciamo l'angolo in A = 120 gradi e il lato BC = L .

Il teorema del coseno afferma che, in un triangolo qualsiasi, la relazione tra i lati e gli angoli è data da:

  c^2 = a^2 + b^2 - 2ab*cos(theta)

dove:
  c è il lato opposto all'angolo theta,
  a e b sono gli altri due lati del triangolo.

Nel nostro caso:

  c = L (il lato opposto all'angolo A),
  a = AB,
  b = AC = AB (dato che AB = AC in un triangolo isoscele),
  theta = 120 gradi

Quindi possiamo applicare il teorema del coseno:

  L^2 = AB^2 + AB^2 - 2*AB*AB*cos(120 gradi)

Sapendo che cos(120gradi) = -1/2, l'equazione diventa:

  L^2 = 2*AB^2 - 2*AB^2*(-1/2)

  L^2 = 2*AB^2 + AB^2

  L^2 = 3*AB^2

Risolvendo per AB:

  AB = L/sqrt(3)

Nel nostro esempio:

  AB = AC = 100/sqrt(3)

(div 100 (sqrt 3))
;-> 57.73502691896258

Quindi adesso possiamo individuare le coordinate dei due punti di steiner (supponendo di dividere il quadrato in con un segmento verticale e di porre l'origine degli assi cartesiani nel punto in basso a sinistra del quadrato):

  s1 = (x1,y1)
  s2 = (x2,y2)

La coordinata X è la stessa per entrambi i punti e vale la metà del lato del quadrato:

  x1 = x2 = L/2 = 50m

Le coordinate y1 e y2 vengono calcolate utilizzando il valore dell'altezza del triangolo isoscele che ogni punto di Steiner forma con i vertici più vicini del quadrato e con un lato del quadrato):

  y1 = h = 28.86751345948129m
  y2 = L - h = 100 - h = 71.13248654051871m

(sub 100 28.86751345948129)
;-> 71.13248654051871

Adesso siamo pronti a calcolare la lunghezza della rete minima ottenuta con i due punti di Steiner.
La lunghezza della rete è data dalla somma:

 1) 4 volte la lunghezza del segmento che unisce una città con il più vicino punto di Steiner (es. il segmenti A-S1)
 2) dalla lunghezza del segmento (S1-S2) che unisce i due punti di Steiner.

Sostituendo i valori numerici:

Lunghezza Rete = (4 * 57.73502691896258) + (71.13248654051871 - 28.86751345948129) =
               = 273.2050807568878m

(add (mul 4 57.73502691896258) (sub 71.13248654051871 28.86751345948129))
;-> 273.205

Ma siamo proprio sicuri che questa sia la rete di lunghezza minima per un quadrato?

Scriviamo alcune funzioni che ci permetteranno di analizzare il problema dal punto di vista numerico.

(define (dist2d p1 p2)
"Calculates 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (let ( (x1 (p1 0)) (y1 (p1 1))
         (x2 (p2 0)) (y2 (p2 1)) )
    (sqrt (add (mul (sub x1 x2) (sub x1 x2))
               (mul (sub y1 y2) (sub y1 y2))))))

(define (rete s1 s2)
  (local (h d)
    ; s1 punto con coordinata Y minore o uguale a s2
    (if (> (s1 1) (s2 1)) (swap s1 s2))
    ; calcolo distanza s1-s2
    (setq h (abs (sub (s1 1) (s2 1))))
    ; calcolo distanza di un segmento
    (setq d (mul 4 (dist2d '(0 0) s1)))
    ; restituisce lunghezza della rete, distanza massima e minima tra le città
    (list (add h d) (add h (div d 2)) (div d 2))))

Proviamo con i dati dell'esempio:

Lunghezza del lato del quadrato:
(setq L 100)

Punti del quadrato:
(setq p1 '(0 0))      ;A
(setq p2 '(100 0))    ;B
(setq p3 '(100 100))  ;C
(setq p4 '(0 100))    ;D

Primo punto di Steiner:
(setq s1 '(50 28.86751345948129))

Secondo punto di Steiner:
(setq s2 '(50 71.13248654051871))

(rete s1 s2)
;-> (273.2050807568877 157.7350269189626 115.4700538379252)
(sub 71.13248654051871 28.86751345948129)
;-> 42.2649730810374 ; lunghezza del segmento S1-S2
(sub 157.7350269189626 115.4700538379252)
;-> 42.2649730810374 ; lunghezza del segmento S1-S2

Adesso vediamo i risultati se poniamo entrambi i punti di Steiner nel centro del quadrato (50,50).
In questo modo stiamo considerando la rete come composta dalle due diagonali del quadrato:

(setq s1 '(50 50))
(setq s2 '(50 50))
(rete s1 s2)
;-> (282.842712474619 141.4213562373095 141.4213562373095)

Utilizzando le diagonali del quadrato otteniamo una rete più lunga (282.84m), ma le distanze tra le quattro città sono identiche (141.42).
Utilizzando la rete con i punti ottimali di Steiner otteniamo una rete più corta (273.2m), ma le distanze tra le città sono diverse (157.74m e 115.47m).

Proviamo con altri valori per i punti di Steiner:

(setq s1 '(50 90))
(setq s2 '(50 10))
(rete s1 s2)
;-> (283.9607805437114 181.9803902718557 101.9803902718557)

(setq s1 '(50 100))
(setq s2 '(50 0))
(rete s1 s2)
;-> (300 200 100)

Per verificare che la soluzione sia corretta (cioè la rete trovata è effettivamente quella con la lunghezza minima) scriviamo una funzione che calcola i valori della rete variando la posizione dei due punti di Steiner lungo il segmento verticale che divide il quadrato in due parti uguali.

(define (steiner L y1 step)
  (setq x1 (div L 2))
  (setq x2 (div L 2))
  (setq y2 (sub L y1))
  (while (<= y1 (div L 2))
    (print y1 { - } (rete (list x1 y1) (list x2 y2)))
    (read-line)
    (setq y1 (add y1 step))
    (setq y2 (sub L y1))
  ))

(steiner 100 0 1)
;-> 0 - (300 200 100)
;-> 1 - (298.0399960007998 198.0199980003999 100.0199980003999)
;-> 2 - (296.1599360511489 196.0799680255744 100.0799680255744)
;-> 3 - (294.3596765818911 194.1798382909456 100.1798382909456)
;-> 4 - (292.6389792637513 192.3194896318756 100.3194896318756)
;-> 5 - (290.9975124224178 190.4987562112089 100.4987562112089)
;-> ...
;-> 27 - (273.297162322806 159.648581161403 113.648581161403)
;-> 28 - (273.2247805103104 158.6123902551552 114.6123902551552)
;-> 29 - (273.2055362658948 157.6027681329474 115.6027681329474) ;valore minimo
;-> 30 - (273.238075793812 156.619037896906 116.619037896906)
;-> 31 - (273.3210572813237 155.6605286406618 117.6605286406618)
;-> ...
;-> 45 - (279.0724809414742 144.5362404707371 134.5362404707371)
;-> 46 - (279.7646040234085 143.8823020117042 135.8823020117042)
;-> 47 - (280.4886154287642 143.2443077143821 137.2443077143821)
;-> 48 - (281.2435752186153 142.6217876093077 138.6217876093077)
;-> 49 - (282.0285699709942 142.0142849854971 140.0142849854971)
;-> 50 - (282.842712474619 141.4213562373095 141.4213562373095)

(steiner 100 28 0.01)
;-> ...
;-> 28.85 - (273.2050887269486 157.7525443634742 115.4525443634744)
;-> 28.86 - (273.2050822236511 157.7425411118254 115.4625411118257)
;-> 28.87 - (273.2050809175203 157.73254045876 115.4725404587603) ;valore minimo
;-> 28.88 - (273.2050848072063 157.722542403603 115.4825424036033)
;-> 28.89 - (273.2050938913591 157.7125469456794 115.4925469456797)
;-> ...

I calcoli numerici confermano che la rete di lunghezza minima è quella che utilizza i punti di Steiner ottimali che si trovano all'interno del quadrato in modo tale che gli angoli tra i segmenti collegati a ciascun punto siano di 120 gradi.

Nota: Se abbiamo tre città disposte ai vertici di un triangolo in cui tutti gli angoli sono minori di 120 gradi, allora esiste un solo punto di Steiner che si trova internamente al triangolo e forma angoli di 120 gradi con tutti i vertici del triangolo.

Nota: se ci sono N punti da connettere e dobbiamo trovare la rete di lunghezza minima, allora il concetto dei punti di Steiner è ancora valido, ma l'individuzione della loro posizione ottimale è un problema molto complesso.


---------------------------------------------
Numero massimo tramite concatenazione binaria
---------------------------------------------

Abbiamo una lista con tre numeri decimali interi.
Qual è il massimo numero che si può creare unendo le rappresentazioni binarie dei tre numeri dati?

Per esempio:
Numeri = 1, 2, 3
binario di 1 = 1 
binario di 2 = 10 
binario di 3 = 11 
Unioni possibili:
1 10 11 -> decimale di 11011 = 27
1 11 10 -> decimale di 11110 = 30
10 1 11 -> decimale di 10111 = 23
10 11 1 -> decimale di 10111 = 23
11 1 10 -> decimale di 11110 = 30
11 10 1 -> decimale di 11101 = 29
Quindi il numero massimo vale 30.

(define (bin-dec str)
"Convert a bynary string to decimal integer"
  (int str 0 2))

(define (dec-bin num)
"Convert a decimal integer to binary string"
  (bits num))

(define (max3-bin lst)
  (local (idx binary max-value)
    (setq idx '((0 1 2) (0 2 1) (1 0 2) (1 2 0) (2 0 1) (2 1 0)))
    (setq binary (map dec-bin lst))
    (setq max-value -1)
    ; ciclo che calcola il valore massimo tra tutte le unioni dei numeri binari
    (dolist (el idx)
      (setq max-value (max max-value (bin-dec (join (select binary el)))))
    )
    max-value))

Proviamo:

(max3-bin '(1 2 3))
;-> 30
(max3-bin '(22 21 42))
;-> 46442

Se gli elementi della lista sono più di 3 (ma meno di 11), allora possiamo usare le permutazioni.

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

(define (max-bin lst)
  (local (binary permute max-value)
    ; converte in binario i numeri decimali della lista
    (setq binary (map dec-bin lst))
    ; calcola le permutazioni della lista binaria
    (setq permute (perm binary))
    (setq max-value -1)
    ; ciclo che calcola il valore massimo tra tutte le unioni dei numeri binari
    (dolist (p permute)
      (setq max-value (max max-value (bin-dec (join p))))
    )
    max-value))

Proviamo:

(max-bin '(1 2 3))
;-> 30
(max-bin '(22 21 42))
;-> 46442


------------------------------------------------------
Intervallo più piccolo che include elementi da N liste
------------------------------------------------------

Abbiamo N liste di interi.
Determinare l'intervallo più piccolo che contiene almeno un numero di ognuna delle N liste.

Definiamo l'intervallo [a,b] minore dell'intervallo [c, d] se risulta:
1) (b - a) < (d - c)
oppure
2) se (b - a) = (d - c) e (a < c)

Esempio 1:
Liste = (4 10 15 24 26) (0 9 12 20) (5 18 22 30)
Intervallo minimo = (20 24)
Spiegazione:
Lista 1: (4 10 15 24 26) 24 si trova nell'intervallo (20 24).
Lista 2: (0 9 12 20) 20 si trova nell'intervallo (20 24).
Lista 3: (5 18 22 30) 22 si trova nell'intervallo (20 24).

Esempio 2:
Liste = (1 2 3 4 5) (6 7 8 9 10 11 12) (13 14 15)
Intervallo minimo =  (5 13)

Esempio 3:
Liste = (1 2 3) (1 2 3) (1 2 3)
Intervallo minimo =  (1 1)

Funzione che verifica se il primo intervallo è minore del secondo:

(define (range-min r1 r2)
  (let ( (a (r1 0)) (b (r1 1)) (c (r2 0)) (d (r2 1)) )
    (if (> a b) (swap a b))
    (if (> c d) (swap c d))
    (or (< (sub b a) (sub d c))
        (and (= (sub b a) (sub d c)) (< a c)))))

(range-min '(1 10) '(22 30))
;-> nil
(range-min '(1 10) '(21 30))
;-> true
(range-min '(10 1) '(30 21))
;-> true
(range-min '(1 10) '(-1 8))
;-> nil
(range-min '(10 1) '(8 -1))
;-> nil

Poichè il problema è abbastanza complicato proviamo a semplificarlo: invece di N liste supponiamo di avere solo 2 liste.

Possiamo risolvere questo problema con la 'forza bruta':
eseguiamo due cicli innestati per creare tutte le coppie di numeri e le loro distanze.
La coppia di numeri con distanza minima rappresenta anche l'intervallo minimo cercato.

(setq lst '((0 20 9 12) (22 18 5 30)))

(define (range lst)
  (let ( (a (lst 0)) (b (lst 1)) (minimo '(0 1e99)) )
    (dolist (el1 a)
      (dolist (el2 b)
        (when (range-min (list el1 el2) minimo)
          (setq minimo (list el1 el2)))))
    (sort minimo)))

(range lst)
;-> (18 20)

Questo metodo per risolvere il caso di due liste non è applicabile direttamente al caso di N liste, perchè dovremmo scrivere una funzione con N cicli annidati per trovare le distanze tra tutte le coppie di numeri.
Dobbiamo trovare un miglioramento al metodo 'brute force'.
Se ordiniamo le liste possiamo utilizzare un metodo con due puntatori per trovare la distanza minima tra le coppie di numeri.
(setq lst '((10 26 4 15 24) (0 20 9 12) (22 18 5 30)))
(setq lst (map sort lst))
;-> ((0 9 12 20) (5 18 22 30))

(setq L1 (lst 1))
;-> (0 9 12 20)
(setq L2 (lst 2))
;-> (5 18 22 30)

(setq len1 (length L1))
;-> 4
(setq len2 (length L2))
;-> 4

Rappresentiamo i numeri delle due liste lungo la linea degli interi:

L1:
0                 9     12              20
. . . . . . . . . . . . . . . . . . . . .

L2:
          5                         18      22             30
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

All'inizio i due puntatori p1 e p2 sono posizionati all'inizio delle liste:

(setq p1 0)
(setq p2 0)

Calcoliamo la distanza tra gli elementi indicati dai puntatori:

(println (L1 p1) { } (L2 p2))
; distanza tra 0 e 5
(setq dist (abs (- (L1 p1) (L2 p2))))
;-> 5

Adesso avanziamo il puntatore del numero più piccolo della coppia appena considerata e calcoliamo la distanza tra i numeri correnti.
Procediamo in questo modo fino alla fine di una delle due liste (i valori della lista più lunga generano sempre distanze maggiori).
In questo modo calcoliamo un numero molto inferiore di distanze (len1+len2) rispetto al metodo 'forza bruta' (len1*len2).
Questo è possibile perchè le liste sono ordinate e questo ci permette di non calcolare le distanze che sono sicuramente maggiori.

(if (<= (L1 p1) (L2 p2)) (++ p1) (++ p2))
(println (L1 p1) { } (L2 p2))
; distanza tra 9 e 5
(setq dist (abs (- (L1 p1) (L2 p2))))
;-> 4

(if (<= (L1 p1) (L2 p2)) (++ p1) (++ p2))
(println (L1 p1) { } (L2 p2))
; distanza tra 9 e 18
(setq dist (abs (- (L1 p1) (L2 p2))))
;-> 9

(if (<= (L1 p1) (L2 p2)) (++ p1) (++ p2))
(println (L1 p1) { } (L2 p2))
; distanza tra 12 e 18
(setq dist (abs (- (L1 p1) (L2 p2))))
;-> 6

(if (<= (L1 p1) (L2 p2)) (++ p1) (++ p2))
(println (L1 p1) { } (L2 p2))
; distanza tra 20 e 18
(setq dist (abs (- (L1 p1) (L2 p2))))
;-> 2

(if (<= (L1 p1) (L2 p2)) (++ p1) (++ p2))
(println (L1 p1) { } (L2 p2))
; distanza tra 20 e 22
(setq dist (abs (- (L1 p1) (L2 p2))))
;-> 2

Questo metodo con due puntatori può essere applicato anche nel caso di N liste.
Vediamo come si applica nel nostro esempio.

(setq lst '((10 26 4 15 24) (0 20 9 12) (22 18 5 30)))
(setq lst (map sort lst))

(setq L1 (lst 0))
;-> (4 10 15 24 26)
(setq L2 (lst 1))
;-> (0 9 12 20)
(setq L3 (lst 2))
;-> (5 18 22 30)

(setq len1 (length L1))
;-> 5
(setq len2 (length L2))
;-> 4
(setq len3 (length L3))
;-> 4

L1:
        4           10        15                24  26
. . . . . . . . . . . . . . . . . . . . . . . . . . .

L2:
0                 9     12              20
. . . . . . . . . . . . . . . . . . . . .

L3:
          5                         18      22              30
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Inizialmente i puntatori valgono 0 (inizio delle liste):

(setq p1 0) (setq p2 0) (setq p3 0)

Confrontiamo i valori indicati dai puntatori e determiniamo il valore minimo e massimo:

(setq numeri (sort (list (L1 p1) (L2 p2) (L3 p3))))
;-> (0 4 5)

Valore minimo:
(setq vmin (numeri 0))
;-> 0

Valore massimo:
(setq vmax (numeri -1))
;-> 5

Quindi il primo intervallo vale: [0, 5]

Adesso avanziamo il puntatore dell'elemento più piccolo dei numeri (0 4 5) che è p2:

(++ p2)

Adesso abbiamo i numeri (4 5 9):

(setq numeri (sort (list (L1 p1) (L2 p2) (L3 p3))))
;-> (4 5 9)

Il valore massimo vale 9.
Poichè 9 è maggiore di 5 (che è limite destro dell'intervallo corrente [0, 5]), allora sostituiamo il 5 con il 9 e otteniamo il nuovo intervallo [0, 9].
Il valore minimo vale 4. Quindi sostituiamo lo 0 con il 4 e otteniamo il nuovo intervallo [4 9].

Adesso avanziamo il puntatore dell'elemento più piccolo dei numeri (4 5 9) che è p1:

(++ p1)

Otteniamo i numeri (5 9 10):

(setq numeri (sort (list (L1 p1) (L2 p2) (L3 p3))))
;-> (5 9 10)

Il valore massimo vale 10, quindi l'intervallo diventa [4 10].
Il valore massimo vale 5, quindi l'intervallo diventa [5 10].

Continuiamo in questo modo fino alla fine di una delle liste.
Al termine l'intervallo finale è la soluzione al problema.

Scriviamo una funzione per verificare questo metodo (valida solo per tre liste):

(define (min-idx lst)
"Return min values and its index"
  (let (minimo (apply min lst))
    (list minimo (first (ref minimo lst)))))

(min-idx '(4 0 5))
;-> (0 1)

(define (min3-range lst)
  (setq lst (map sort lst))
  (setq L1 (lst 0)) (setq L2 (lst 1)) (setq L3 (lst 2))
  (setq len1 (length L1)) (setq len2 (length L2)) (setq len3 (length L3))
  (setq p1 0) (setq p2 0) (setq p3 0)
  (setq range '(-1 -1))
  ; ciclo fino alla fine di una delle tre liste
  (while (and (< p1 len1) (< p2 len2) (< p3 len3))
    ; prende i numeri in base ai puntatori e li ordina
    ; per trovare il minimo e il massimo
    (setq numeri (sort (list (L1 p1) (L2 p2) (L3 p3))))
    ; imposta il nuovo range
    (setf (range 1) (max (numeri -1) (range 1)))
    (setf (range 0) (numeri 0))
    ; cerca il puntatore del numero più piccolo
    (setq p ((min-idx (list (L1 p1) (L2 p2) (L3 p3))) 1))
    ; aumenta il puntatore del numero più piccolo
    (cond ((= p 0) (++ p1)) ((= p 1) (++ p2)) ((= p 2) (++ p3)))
    ;(println range)
    ;(println (list (L1 p1) (L2 p2) (L3 p3)))
    ;(println p)
    ;(println p1 { } p2 { } p3)
    ;(read-line)
  )
  range)

Proviamo:

(setq lst '((10 26 4 15 24) (0 20 9 12) (22 18 5 30)))
(min3-range lst)
;-> (20 24)

(setq test '((1 2 3 4 5) (6 7 8 9 10 11 12) (13 14 15)))
(min3-range test)
;-> (5 13)

Adesso dobbiamo scrivere una funzione che tratta N liste.

(define (min-idx lst)
"Return min values and its index"
  (let (minimo (apply min lst))
    (list minimo (first (ref minimo lst)))))

(define (finish?)
  (setq out nil)
  (for (i 0 (- num-list 1) 1 out)
    (if (>= (ptr i) (len-list i)) (setq out true))
  )
  out)

(define (range-min lst)
  (local (num-list ptr len-list range numeri ordinati p))
    ; ordina tutte le liste
    (setq lst (map sort lst))
    ; numero totale di liste
    (setq num-list (length lst))
    ; array di puntatori per le liste
    (setq ptr (array num-list '(0)))
    ; lista delle lunghezze delle liste
    (setq len-list (map length lst))
    ; range iniziale
    (setq range '(+1e99 -1e99))
    ;ciclo fino al termine di una delle liste
    (until (finish?) ; 
      ; prende i numeri in base ai puntatori e li ordina
      ; per trovare il minimo e il massimo
      (setq numeri '())
      (for (i 0 (- num-list 1))
        (push ((lst i) (ptr i)) numeri -1)
      )
      (setq ordinati numeri)
      (sort numeri)
      ; aggiorna l'intervallo
      (setf (range 1) (max (numeri -1) (range 1)))
      ;(setf (range 0) (numeri 0))
      ; cerca il puntatore del numero più piccolo
      (setq p ((min-idx ordinati) 1))
      ; aumenta il puntatore del numero più piccolo
      (++ (ptr p))
      ;(println range)
      ;(println ordinati)
      ;(println ptr)
      ;(read-line)
    )
    range)

Proviamo:

(setq lst '((10 26 4 15 24) (0 20 9 12) (22 18 5 30)))
(range-min lst)
;-> (20 24)

(setq test '((1 2 3 4 5) (6 7 8 9 10 11 12) (13 14 15)))
(range-min test)
;-> (5 13)

(setq lst '((0 20 9 12) (22 18 5 30)))
(range-min lst)
;-> (20 22)


----------------------------------------
Matematica cinese antica: i numeri primi
----------------------------------------

Duemila anni fa i matematici cinesi credevano che un numero N fosse primo se (2^N - 2) divideva esattamente N.

Formulazioni equivalenti:
Un numero N è primo se (2^N - 2) è un multiplo di N.
Un numero N è primo se risulta: (2^N - 2) mod N = 0
Un numero N è primo se (2^N - 2) è congruente a 0 modulo N: (2^N - 2) ≡ 0 (mod N)

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1L
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (pow-i num power)
"Calculates the integer power of an integer"
  (local (pot out)
    (if (zero? power)
        (setq out 1L)
        (begin
          (setq pot (pow-i num (/ power 2)))
          (if (odd? power)
              (setq out (* num pot pot))
              (setq out (* pot pot)))))
    out))

Vediamo quali numeri venivano erroneamente considerati primi:

(define (china-error max-num)
  (let (non-prime '())
    (for (num 2 max-num)
      (if (and (zero? (% (- (pow-i 2L num) 2) num)) (not (prime? num)))
          (push num non-prime -1)))
    non-prime))

(time (println (china-error 1e3)))
;-> (341 561 645)
;-> 9.988

(time (println (china-error 1e4)))
;-> (341 561 645 1105 1387 1729 1905 2047 2465 2701 2821 3277
;->  4033 4369 4371 4681 5461 6601 7957 8321 8481 8911)
;-> 358.166

(time (println (china-error 1e5)))
;-> (341 561 645 1105 1387 1729 1905 2047 2465 2701 2821 3277 4033 4369 4371 4681 5461
;->  6601 7957 8321 8481 8911 10261 10585 11305 12801 13741 13747 13981 14491 15709 15841
;->  16705 18705 18721 19951 23001 23377 25761 29341 30121 30889 31417 31609 31621 33153
;->  34945 35333 39865 41041 41665 42799 46657 49141 49981 52633 55245 57421 60701 60787
;->  62745 63973 65077 65281 68101 72885 74665 75361 80581 83333 83665 85489 87249 88357
;->  88561 90751 91001 93961)
;-> 226404.84

Adesso vediamo quanti numeri primi non venivano riconosciuti:

(define (china-miss max-num)
  (let (miss-prime '())
    (for (num 2 max-num)
      (if (and (prime? num) (not (zero? (% (- (pow-i 2L num) 2) num))))
          (push num miss-prime -1)))
    miss-prime))

(time (println (china-miss 1e5)))
;-> ()
;-> 20328.833

Vedi anche "Numeri di Carmichael" su "Rosetta Code".


-----------
Cyclic Sort
-----------

Il Cyclic sort è un algoritmo di ordinamento che si può applicare soltanto a liste che contengono tutti i numeri da 1 a N, dove N è la lunghezza della lista.
È un tipo di ordinamento in cui i numeri vengono ordinati in base ai loro indici (il numero 1 all'indice 0, il numero 2 all'indice 1, ecc.)

Per esempio:
lst = (1 5 3 2 4 0) --> applicabile
lst = (1 5 3 2 4 1) --> non applicabile
lst = (4 3 2 1)     --> non applicabile (manca il numero 0)

Algoritmo
Scorrere la lista verificando che ogni elemento sia nella posizione corretta, altrimenti scambiare l'elemento con l'elemento che ha indice corretto.

(define (cyclic-sort lst)
  (local (idx corretto)
    (setq idx 0)
    (while (< idx (length lst))
      (setq corretto (- (lst idx) 1))
      (if (!= (lst idx) (lst corretto))
          (swap (lst idx) (lst corretto))
          (++ idx)))
    lst))

(cyclic-sort '(3 5 2 1 4))
;-> (1 2 3 4 5)
(cyclic-sort (randomize (sequence 1 25)))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)


------------------------------
Primo numero positivo mancante
------------------------------

Data una lista di interi, restiture il più piccolo intero positivo che non è presente nella lista.

Esempio 1:
lst = (1 2 0 3)
Output: 4 (i numeri nell'intervallo (1 2 3) sono tutti nella lista)

Esempio 2:
lst = (5 3 4 -1 1)
Output: 2 (1 è nella lista, ma 2 è mancante)

Esempio 3:
lst = (0 7 8 9 10 11 12 14)
Output: 1 (1 è mancante)

Il numero cercato N sitrova nell'intervallo [1..lenght(lst) + 1].

Soluzione O(n*log(n)) 
---------------------
(Con ordinamento della lista)

(define (missing lst)
  (local (out stop)
    ; prende solo i numeri positivi e li ordina
    (setq lst (sort (filter (fn(x) (> x 0)) lst)))
    (setq stop nil)
    ; ciclo che verifica se risulta num = $idx + 1
    (dolist (el lst stop)
      ;(println el (+ $idx 1))
      ; se risulta num = indice_corrente (el = $idx + 1), continua il ciclo
      (unless (= el (+ $idx 1)) 
        ; altrimenti individua il numero mancante e ferma il ciclo
        (setq out (+ $idx 1))
        ; ferma il ciclo
        (setq stop true)
      )
    )
    ; se il ciclo è stato fermato, allora out è la soluzione 
    (if stop
        out
        ; altrimenti la soluzione è l'ultimo numero della lista + 1
        (+ (lst -1) 1))))

Proviamo:

(missing '(1 2 0 3))
;-> 4
(missing '(5 3 4 -1 1))
;-> 2
(missing '(0 7 8 9 10 11 12 14))
;-> 1

Soluzione O(n)
--------------
(Senza ordinamento della lista)

L'implementazione sfrutta il fatto che ci interessano solo gli interi positivi fino a n, la lunghezza della lista.
Algoritmo
1) Scorrere la lista e, per ogni elemento, eseguire le seguenti azioni:
  1a) Controllare se l'elemento corrente è un intero positivo e rientra nell'intervallo [1, n].
  1b) Assicurarsi che non sia già nella posizione corretta (il che significa che l'elemento all'indice nums[i] - 1 dovrebbe essere nums[i] stesso).
2) Se un elemento soddisfa i criteri di cui sopra, scambiarlo con l'elemento nella sua posizione "corretta" (la posizione che avrebbe se tutti gli elementi [1, n] fossero ordinati), che è l'indice nums[i] - 1.
3) Ripetere il processo finché l'elemento corrente non è fuori dall'intervallo o è già nella posizione corretta.
4) Dopo il ciclo di scambio, la lista viene nuovamente scansionata dall'inizio per trovare il primo indice i in cui nums[i] non è uguale a i + 1.
Questo indice i indica che i + 1 è il più piccolo intero positivo mancante perché tutti gli interi prima di i + 1 sono già nelle loro posizioni corrette e i + 1 è il primo che manca dalla sua posizione corretta.
5) Se non viene trovato alcun indice i, significa che tutti gli interi da 1 a n sono presenti e nelle loro posizioni corrette, quindi il più piccolo intero positivo mancante è n + 1.
Complessità temporale O(n)
Complessità spaziale O(1)

(define (missing2 lst)
  (setq len (length lst))
  ; Posizioni corrette dei numeri (simile al Cyclic sort):
  ; lst[i] = i + 1
  ; lst[i] - 1 = i
  ; lst[lst[i] - 1] = lst[i]  
  (for (i 0 (- len 1))
    (while (and (> (lst i) 0) (<= (lst i) len) (!= (lst i) (lst (- (lst i) 1))))
      (swap (lst i) (lst (- (lst i) 1)))
    )
  )
  ; verifica dell'eventuale numero mancante
  (setq stop nil)
  (for (i 0 (- len 1) 1 stop)
    (if (!= (lst i) (+ i 1)) (set 'out (+ i 1) 'stop true))
  )
  ; se il ciclo è stato fermato, allora out è la soluzione 
  (if stop
      out
      ; altrimenti la soluzione è la lunghezza della lista + 1
      (+ len 1)))

Proviamo:

(missing2 '(1 2 0 3))
;-> 4
(missing2 '(5 3 4 -1 1))
;-> 2
(missing2 '(0 7 8 9 10 11 12 14))
;-> 1


-----------------
Teorema di Wilson
-----------------

Il teorema di Wilson afferma che:

 (p - 1)! ≡ -1 (mod p), per ogni numero primo p.

In altre parole, il fattoriale di (p - 1), dove p è un numero primo, è congruente a -1 modulo p.
Questo significa che dividendo (p - 1)! per p otteniamo come resto (p - 1) (se e solo se p è un numero primo).

Nota: (p - 1)! ≡ -1 (mod p) è equivalente a (p - 1)! ≡ (p - 1) (mod p)

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (wilson? num)
  (= (- num 1) (% (fact-i (- num 1)) num)))

Proviamo:

(wilson? 3)
;-> true
(wilson? 11)
;-> true
(wilson? 12)
;-> nil

(filter wilson? (sequence 2 100))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)


-------------------------
Raggruppare gli anagrammi
-------------------------

Data una lista di stringhe, raggruppare le stringhe che sono anagrammi tra loro.

Algoritmo
Usiamo una lista associativa.
Sfruttiamo il fatto che due stringhe palindrome hanno lo stesso ordinamento di caratteri (perchè hanno gli stessi caratteri).
Per ogni stringa della lista:
1. ordinare la stringa corrente in base ai caratteri (key)
2. cercare la stringa ordinata (key nella lista associativa)
  2a) se esiste la key, allora aggiungere la stringa corrente al valore della chiave
  2b) altrimenti aggiungere alla lista associativa la coppia (key (str))

(define (ana-group lst)
  (local (link key val)
    ; lista associativa
    (setq link '())
    ; ciclo per ogni stringa
    (dolist (str lst)
      ; crea la stringa ordinata (key)
      (setq key (join (sort (explode str))))
      ; ricerca la chiave key nella lista associativa
      (setq val (lookup key link))
      ; aggiornameno della lista associativa
      (if val
          (setf (lookup key link) (push str val -1)) ; chiave esistente
          (push (list key (list str)) link -1); chiave non esistente
      )
    )
    link))

(setq data '("aperti" "incerte" "pietra" "rapati" "patria" "recenti"
             "rapite" "rapita" "aprite" "patrie" "pirata" "cretine"
             "pareti"))

(ana-group data)
;-> (("aeiprt" ("aperti" "pietra" "rapite" "aprite" "patrie" "pareti"))
;->  ("ceeinrt" ("incerte" "recenti" "cretine"))
;->  ("aaiprt" ("rapati" "patria" "rapita" "pirata")))


------------------------
Massimo numero di parole
------------------------

Date due stringhe, determinare quante volte è possibile scrivere la seconda stringa con i caratteri della prima.
Ogni carattere delle prima stringa può essere usato solo una volta.

Esempio:
stringa1 = "uno"
stringa2 = "abcuunnooxyz"
Output = 2

Esempio:
stringa1 = "rjmdafrgmkllsaoalkalwmjksakxmzbgmefmsadoajkmm"
stringa2 = "mamma"
Output = 2

Algoritmo
Contiamo le ripetizioni dei caratteri della prima stringa.
Contiamo le ripetizioni dei caratteri della seconda stringa.
Confrontando i valori delle ripetizioni dei caratteri possiamo determinare la soluzione.

(define (max-parole str1 str2)
  (local (s1 s2 unici1 unici2 lista1 lista2 stop parole ch2 rip1 rip2 ch2)
    (setq s1 (explode str1))
    (setq unici1 (unique s1))
    ; lista1 (carattere numero-ripetizioni) di str1
    (setq lista1 (map list unici1 (count unici1 s1)))
    (setq s2 (explode str2))
    (setq unici2 (unique s2))
    ; lista2 (carattere numero-ripetizioni) di str2
    (setq lista2 (map list unici2 (count unici2 s2)))
    (setq stop nil)
    (setq parole 1e99)
    ; ciclo sui caratteri della lista2
    (dolist (el lista2 stop)
      ; carattere corrente (lista2)
      (setq ch2 (el 0))
      ; ripetizioni carattere corrente (lista2)
      (setq rip2 (el 1))
      ; ripetizioni del carattere corrente in lista1
      (setq rip1 (lookup ch2 lista1))
      ; confronto ripetizioni tra i due caratteri
      (cond ((nil? rip1)
              ; non esiste il carattere nella lista 1
              (setq stop true))
            (true
              ; numero parole possibili = 
              ; = minimo tra (rip1/rip2) e numero parole possibili corrente
              (setq conta (/ rip1 rip2))
              (setq parole (min parole conta)))))
    parole))

Proviamo:

(max-parole "abcuunnooxyz" "uno")
;-> 2

(max-parole "rjmdafrgmkllsaoalkalwmjksakxmzbgmefmsadoajkmm" "mamma")
;-> 2

(setq test (join (randomize (explode (dup "lisp" 10)))))
(max-parole test "lisp")
;-> 10


------------------------------------
Distanza minima tra caratteri uguali
------------------------------------

Data una lista di elementi, scrivere una funzione che verifica se un dato elemento dista almeno k posizioni l'uno dall'altro.
Due elementi distano di (almeno) K posizioni se esistono (almeno) K elementi tra loro.

Esempio:
lista = (4 1 2 4 1 6 2 4 8 2)
elemento = 4
k = 2
Output = true (perchè tutti i 4 sono ad una distanza maggiore o uguale a 2)

 d = 2    
-------
4 1 2 4 1 6 2 4 8 2
      ---------
        d = 3

Esempio:
lista = ("a" "c" "a" "b" "a" "a" "g")
elemento = "a"
k = 1
Output = nil (perchè i caratteri "a" "a" si trovano a distanza 0 che è minore di 1)

   d = 1         d = 0
 ---------       -----
"a" "c" "a" "b" "a" "a" "g")
         ---------
           d = 1

Nota: per ogni elemento trovato, è sufficiente controllare se è distante almeno K posizioni dal successivo.

Stile iterativo:

(define (k-away? var k lst)
  (setq idx-prev (- 1e9))
  (setq stop nil)
  (dolist (el lst stop)
    (if (= el var) 
        (if (< k (- $idx idx-prev))
            (setq idx-prev $idx)
            ;else
            (setq stop true))))
  (not stop))

Proviamo: 

(k-away? 4 2 '(4 1 2 4 1 6 2 4 8 2))
;-> true

(k-away? "a" 1 '("a" "c" "a" "b" "a" "a" "g"))
;-> nil


Stile lisp:

(define (k-away1? var k lst)
  (let (idx (flat (ref-all var lst)))
      (if (find-all k (map - (rest idx) (chop idx)) $it >=) nil true)))

Proviamo:

(k-away1? 4 2 '(4 1 2 4 1 6 2 4 8 2))
;-> true

(k-away1? "a" 1 '("a" "c" "a" "b" "a" "a" "g"))
;-> nil

Test di velocità:

(setq t (append (dup 0 1e4) (randomize (append (dup 0 1e4) (dup "x" 10 true)))))
(k-away? "x" 1 t)
;-> true
(time (k-away? "x" 1 t) 1e3)
;-> 1224.723
(time (k-away? "x" 1 t) 1e4)
;-> 12322.064

(k-away1? "x" 1 t)
;-> true
(time (k-away1? "x" 1 t) 1e3)
;-> 363.056
(time (k-away1? "x" 1 t) 1e4)
;-> 3602.391


-------------------
Citazioni e H-Index
-------------------

Abbiamo una lista di numeri interi che rappresentano il numero di citazioni che un ricercatore ha ricevuto per il suo i-esimo articolo.
Per esempio la lista (5 1 1 3 6) significa che il ricercatore ha ricevuto:
5 citazioni per l'articolo 0
1 citazione per l'articolo 1
1 citazione per l'articolo 2
3 citazioni per l'articolo 3
6 citazioni per l'articolo 4

Definizione di H-index:
L'indice H-index è definito come il valore massimo di H tale che un ricercatore abbia pubblicato almeno H articoli che sono stati citati almeno H volte.
In altre parole, si tratta del numero massimo H tale che nella lista esistono almeno H numeri maggiori o uguali ad H.

Nel nostro esempio il ricercatore ha 3 articoli con almeno 3 citazioni ciascuno e i restanti 2 con non più di 3 citazioni ciascuno, quindi il suo H-index è 3.

Algoritmo
1) Ordiniamo la lista: (1 1 3 5 6)
2) Attraversiamo la lista
   Confrontiamo il numero corrente (1) con la differenza tra la lunghezza della lista (5) e l'indice corrente (0):
   numero corrente = 1
   idx = 0
   len - idx = 5 - 0 = 5
   Se il numero corrente (1) è maggiore o uguale alla differenza (5 - 0 = 5), allora la differenza è il valore di hindex. 
   Infatti questo significa che insieme al numero corrente esistono un numero corrente di numeri maggiori del numero corrente (che è la definizione di H-index).
   In questo caso (5 > 1), quindi andiamo avanti al numero 1 della lista:
   
   numero corrente = 1
   idx = 0
   len - idx = 5 - 1 = 4
   (1 < 4)
   
   numero corrente = 3
   idx = 2
   len - idx = 5 - 2 = 3 
   (3 = 3) --> Questo è l'H-index cercato.
   Adesso risulta che insieme al numero 3 esistono altri 2 numeri (5 e 6) che sono maggiori o uguali a 3.
   Quindi esistono 3 numeri che sono maggiori o uguali a 3.
 
(define (hindex lst)
  (let ( (len (length lst)) (stop nil) (out 0))
    (sort lst)
    (for (i 0 (- len 1) 1 stop)
      (if (>= (lst i) (- len i)) (set 'out (- len i) 'stop true)))
    out))

Proviamo:

(hindex '(5 1 1 3 6))
;-> 3

(hindex '(1 3 1 3 4 3 1))
;-> 3


--------------------
Separazione di 0 e 1
--------------------

Data una lista di 0 e 1, scrivere una funzione che sposta tuti gli 1 all'inizio della lista.
Esempio:
lista = (0 1 1 1 0 1 0 0)
output = (0 0 0 0 1 1 1 1)

Esistono molti modi di risolvere questo problema.


(define (separa1 lst) (sort lst))

(setq a '(0 1 1 1 0 1 0 0))
(separa1 a)
;-> (0 0 0 0 1 1 1 1)

(define (separa2 lst)
  (let (conta (count '(0 1) lst))
    (append (dup 0 (conta 0)) (dup 1 (conta 1)))))

(separa2 a)
;-> (0 0 0 0 1 1 1 1)

(define (separa3 lst)
  (append (filter zero? lst) (clean zero? lst)))

(separa3 a)
;-> (0 0 0 0 1 1 1 1)

Adesso supponiamo che per separare gli 1 dagli 0 possiamo soltanto scegliere due elementi adiacenti e scambiarli.
In questo modo, qual è il numero minimo di passaggi per raggruppare tutti gli 0 a sinistra e gli 1 a destra?

Algoritmo
Attraversiamo la lista e per ogni 0 il numero di scambi necessario per portarlo al posto corretto vale:
(indice-corrente - numeri-di-zeri-già-considerati)

(define (scambi lst)
  (local (num-scambi len zeri-processati)
    (setq len (length lst))
    (setq num-scambi 0)
    (setq zeri-processati 0)
    (for (idx 0 (- len 1))
      (when (zero? (lst idx))
        (++ num-scambi (- idx zeri-processati))
        (++ zeri-processati)))
    num-scambi))

Proviamo:

(scambi a)
;-> 11

(scambi '(1 0 1))
;-> 1

(scambi '(1 0 0))
;-> 2

(scambi '(0 0 1 1))
;-> 0

Verifichiamo i risultati scrivendo una funzione che ordina gli elementi scambiando le coppie adiacenti (simile al bubble-sort):

(define (separa-scambi lst)
  (local (len num-scambi scambiati)
    (setq len (length lst))
    (setq num-scambi 0)
    (setq scambiati true)
    ; ciclo fino a che ci sono scambi da fare
    (while scambiati 
      (setq scambiati nil)
      (for (idx 0 (- len 2))
        ; uno scambio avviene solo quando troviamo la sequenza 1 0
        (when (and (zero? (lst (+ idx 1))) (= (lst idx) 1))
          (swap (lst idx) (lst (+ idx 1)))
          (++ num-scambi)
          ; segnala che nel ciclo è stata scambiata almeno una coppia
          (setq scambiati true)
        )
      )
    )
    (list num-scambi lst)))

Proviamo:

(separa-scambi a)
;-> (11 (0 0 0 0 1 1 1 1)

(separa-scambi '(1 0 1))
;-> (1 (0 1 1))

(separa-scambi '(1 0 0))
;-> (2 (0 0 1))

(separa-scambi '(0 0 1 1))
;-> (0 (0 0 1 1))


--------------
Password check
--------------

Una password è considerata 'forte' se soddisfa tutte le seguenti condizioni:

1) Ha almeno 8 caratteri e al massimo 20 caratteri.
2) Contiene almeno una lettera minuscola
3) contiene almeno una lettera maiuscola
4) contiene almeno una cifra.
5) e contiene almeno un dei seguenti simboli:
   ! # $ % ^ & ( ) * + , - . : ; < = > @ [ ] ^ _ { | } ~ 
6) deve contenere solo i caratteri elencati sopra (per esempio, lo spazio " " non è consntito).

Scrivere una funzione che verifica se una password (stringa) è 'forte'.

(define (check-pwd str)
  (local (out lower upper digits simboli error len l u d s)
    (setq out nil)
    (setq lower "abcdefghijklmnopqrstuvwxyz")
    (setq upper "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    (setq digits "0123456789")
    (setq simboli '("!" "#" "$" "%" "^" "&" "(" ")" "*" "+" "," "-" "." ":"
                    ";" "<" "=" ">" "@" "[" "]" "^" "_" "{" "|" "}" "~"))
    (setq error nil)
    (setq len (length str))
    (cond ((or (< len 8) (> len 20)) 
          (println "Password must have at least 6 characters and at most 20 characters"))
          (true
            (setq l 0) (setq u 0) (setq d 0) (setq s 0)
            (dolist (ch (explode str))
              (cond ((find ch lower) (setq l 1))
                    ((find ch upper) (setq u 1))
                    ((find ch digits) (setq d 1))
                    ((find ch simboli) (setq s 1))
                    (true (setq error ch))))
            (if error (println "Character '" error "' not allowed"))
            (if (zero? l) (println "Missing lowercase character"))
            (if (zero? u) (println "Missing uppercase character"))
            (if (zero? d) (println "Missing digit character"))
            (if (zero? s) (println "Missing symbol character"))
            (if (= (+ l u d s) 4) (setq out true))))
    out))

Proviamo:

(check-pwd "A1a")
;-> Password must have at least 6 characters and at most 20 characters
;-> nil

(check-pwd "A1a234234_3242348qqqqq")
;-> Password must have at least 6 characters and at most 20 characters
;-> nil

(check-pwd "         ")
;-> Character ' ' not allowed
;-> Missing lowercase character
;-> Missing uppercase character
;-> Missing digit character
;-> Missing symbol character
;-> nil

(check-pwd "A1a2345_K")
;-> true


----------------------------------------------
Distanza massima tra coppie di primi adiacenti
----------------------------------------------

Tra due numeri primi adiacenti possiamo calcolare la distanza:
  
  distanza = p(i+1) - p(i)

Come varia la massima distanza fra numeri primi adiacenti?
Per esempio, consideriamo i seguenti numeri primi (2 3 5 7 11 13 17 19) e calcoliamo le distanze tra le i numeri adiacenti:

  3 - 2 = 1 (valore massimo di distanza)
  5 - 3 = 2 (valore massimo di distanza)
  7 - 5 = 2
 11 - 9 = 2
 13 - 9 = 2
 17 - 13 = 4 (valore massimo di distanza)
 19 - 17 = 2

Notiamo che le massime distanze tra i primi si verificano con il 3 (distanza 1), il 5 (distanza 2) e il 17 (distanza 4).
Vogliamo vedere come varia la massima distanza al crescere dei numeri primi.

Sequnza OEIS A005250:
Record gaps between primes.
  1, 2, 4, 6, 8, 14, 18, 20, 22, 34, 36, 44, 52, 72, 86, 96, 112, 114, 118,
  132, 148, 154, 180, 210, 220, 222, 234, 248, 250, 282, 288, 292, 320, 336,
  354, 382, 384, 394, 456, 464, 468, 474, 486, 490, 500, 514, 516, 532, 534,
  540, 582, 588, 602, 652, ...

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

(define (dist-max-primi limite)
  (local (primi out max-dist ordine prec)
    (setq primi (primes-to limite))
    (setq out '())
    (setq max-dist -1)
    (setq ordine 1)
    (setq prec 2)
    (dolist (p primi)
      (setq dist (- p prec))
      (when (> dist max-dist)
        (setq max-dist dist)
        (println ordine { } p { } dist)
        (push (list ordine p dist) out -1)
      )
      (setq prec p)
      (++ ordine))
    (println "Totale numeri primi: " (length primi))
    (println "Ultimo numero primo: " (primi -1))
    out))

Proviamo con numeri fino a 2e8 (200 milioni):

(time (setq result (dist-max-primi 2e8)))
;-> 1 2 0
;-> 2 3 1
;-> 3 5 2
;-> 5 11 4
;-> 10 29 6
;-> 25 97 8
;-> 31 127 14
;-> 100 541 18
;-> 155 907 20
;-> 190 1151 22
;-> 218 1361 34
;-> 1184 9587 36
;-> 1832 15727 44
;-> 2226 19661 52
;-> 3386 31469 72
;-> 14358 156007 86
;-> 30803 360749 96
;-> 31546 370373 112
;-> 40934 492227 114
;-> 103521 1349651 118
;-> 104072 1357333 132
;-> 149690 2010881 148
;-> 325853 4652507 154
;-> 1094422 17051887 180
;-> 1319946 20831533 210
;-> 2850175 47326913 220
;-> 6957877 122164969 222
;-> 10539433 189695893 234
;-> 10655463 191913031 248
;-> Totale numeri primi: 11078937
;-> Ultimo numero primo: 199999991
;-> 40253.924

Il 10655463-esimo numero primo, che vale 191913031, dista dal precedente (che vale 191912783) 248 unità.

Verifichiamo la sequenza OEIS:

(flat (map 2 result))
;-> (0 1 2 4 6 8 14 18 20 22 34 36 44 52 72 86 96 112
;->  114 118 132 148 154 180 210 220 222 234 248)

Poichè i numeri primi tendono ad essere meno frequenti col crescere delle cifre, è intuitivo che la massima distanza cresce sempre (ma molto lentamente e in maniera irregolare).
Un risultato noto, basato sull'ipotesi di Cramer, stima che la distanza massima tra primi adiacenti potrebbe crescere come: 

  Differenza (p(n+1) - p(n)) proporzionale a log^2(p(n))

cioè, la massima distanza tra primi consecutivi cresce proporzionalmente al quadrato del logaritmo del numero primo.
Questo significa ch il gap tra due numeri primi consecutivi non cresce semplicemente di log^2(p(n)) per ogni primo p(n) \), ma piuttosto la massima distanza tra due primi consecutivi fino a un certo punto tende a comportarsi come log^2(p(n)). 
Quindi la crescita della distanza massima è approssimativamente limitata da log^2(p(n)), ma non che ogni distanza massima segua quella relazione.
L'ipotesi di Cramer riguarda solo un limite superiore asintotico per la massima distanza possibile tra primi consecutivi. La maggior parte delle distanze è più piccola.

Esempio: 
per quanto potrebbe essere grande la distanza massima attorno a numeri primi di grandezza simile a 492227, potremmo  calcolare log^2(492227):

(mul (log 492227) (log 492227))
;-> 171.785460931684

Quindi, secondo l'ipotesi di Cramer, la massima distanza tra due primi consecutivi intorno a 492227 potrebbe essere approssimativamente 171. 
Tuttavia, la distanza effettiva tra due primi consecutivi specifici può essere molto inferiore alla massima possibile. 

Vedi anche "Distanza tra coppia di primi" su "Note libere 17".
Vedi anche "Distanze tra coppie di numeri primi adiacenti" su "Note libere 20".


--------------------------------------------
Conteggio dei numeri con cifre tutte diverse
--------------------------------------------

Dato un numero intero k, contare tutti i numeri con cifre univoche tra 0 e (10^k - 1) con 0 <= k <= 9.

Scriviamo una funzione che conta tutti i numeri da 'a' a 'b':

(define (conta-diversi a b)
  (let (conta 0)
    (for (numero a b)
      (setq cifre (explode (string numero)))
      (if (= cifre (unique cifre)) (++ conta))
    )
    conta))

Provaviamo:

(conta-diversi 0 9)
;-> 10
(conta-diversi 0 99)
;-> 91
(conta-diversi 0 999)
;-> 739
(conta-diversi 0 9999)
;-> 5275
(time (println (conta-diversi 0 9999999)))
;-> 712891
;-> 17937.959
(time (println (conta-diversi 0 1e8)))
;-> 2345851
;-> 196387.405

La funzione produce i risultati corretti, ma è lenta per valori di k > 6.

Calcoliamo i numeri con cifre diverse tra gli intervalli [10^(k-1)..(10^k - 1)]:

(conta-diversi 0 9)
;-> 10
(conta-diversi 10 99)
;-> 81
(conta-diversi 100 999)
;-> 648
(conta-diversi 1000 9999)
;-> 4536
(conta-diversi 10000 99999)
;-> 27216

A parte i primi 10 numeri diversi (da 0 a 9), gli altri valori seguono uno schema matematico:

(div 648 8)
;-> 81
(* 81 8)
;-> 648

(div 4536 7)
;-> 648
(* 648 7)
;-> 4536

(div 27216 6)
;-> 4536
(* 4536 6)
;-> 27216

Per k = 1, abbiamo 10 numeri diversi
    k = 2, abbiamo 10 + 81 numeri diversi 
    k = 3, abbiamo 10 + 81 + (81 * 8) numeri diversi
    k = 4, abbiamo 10 + 81 + 648 + (648 * 7) numeri diversi
    k = 5, abbiamo 10 + 81 + 648 + 4536 + (4536 * 5) numeri diversi
    k = 6, abbiamo 10 + 81 + 648 + 4536 + 27216 + (27216 * 4) numeri diversi
    ...

Quindi possiamo scrivere una funzione che effettua solo poche somme e moltiplicazioni per ottenere il risultato:

(define (conta-diversi2 k)
  (cond ((zero? k) 1)
    ((= k 1) 10)
    (true ; k > 1
    (let ( (out 10) (contatore 9) (unici 9) )
      (while (and (> k 1) (> contatore 0))
        (setq unici (* unici contatore))
        (setq out (+ out unici))
        (-- contatore)
        (-- k)
        ;(println unici { } out)
      )
      out))))

Proviamo:

(conta-diversi2 3)
;-> 739
(conta-diversi 0 999)
;-> 739

(conta-diversi2 4)
;-> 5275
(conta-diversi 0 9999)
;-> 5275

(conta-diversi2 6)
;-> 168571
(conta-diversi 0 999999)
;-> 168571

(time (println (conta-diversi2 8)))
;-> 2345851
;-> 0
(time (println (conta-diversi2 9)))
;-> 5611771
;-> 0


-------------------------------
Distanza tra primi in una lista
-------------------------------

Data una lista di interi positivi, determinare la massima distanza tra gli indici di due numeri primi (non necessariamente differenti).
Per esempio:

lista = (2 4 6 5 1 8 7)
primi indici 
 2     0 
 5     3
 7     6
Distanza massima = 6 - 0 = 6

lista = (1 2 4 8 4 21)
primi indici
2      1
Distanza massima = 1 - 1 = 0

lista = (1 10 4 8)
primi indici
Nessun primo      
Distanza massima = nil

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (dist-max-primi lst)
  (let (lst (sort (index prime? lst)))
    (if lst
      (- (lst -1) (lst 0))
      nil)))

Proviamo:

(setq a '(2 4 6 5 1 8 7))
(setq b '(1 2 4 8 4 21))
(setq c '(1 10 4 8))

(dist-max-primi a)
;-> 6
(dist-max-primi b)
;-> 0
(dist-max-primi c)
;-> nil

(silent (setq test (rand 1e6 1e6)))
(time (println (dist-max test)))
;-> 999983
;-> 937.452


-------------------------------------------------
Verificare se un numero intero è un cubo perfetto
-------------------------------------------------

Scriviamo una funzione per verificare se un numero intero è un cubo perfetto.

Prima versione
--------------

(define (cubo-perfetto? num)
  (let (icbr (int (pow num (div 3))))
    (= num (* icbr icbr icbr))))

Proviamo:

(cubo-perfetto? 8)
;-> true
(cubo-perfetto? 27)
;-> true
(cubo-perfetto? 64)
;-> nil ; risultato errato
(filter cubo-perfetto? (sequence 1 1000))
;-> (1 8 27) ; risultato errato

Questa funzione ha problemi che derivano dagli arrotondamenti dei numeri in virgola mobile generati dalla funzione "pow".

Seconda versione
----------------
Algoritmo
Calcolare il valore iniziale della radice cubica approssimata con pow e integer (cube-root).
Verificare se il cubo di questo valore è uguale al numero dato.
Se non è esatto, testare anche il valore successivo (cube-root + 1) e il valore precedente (cube-root - 1) per correggere eventuali errori dovuti alla divisione in virgola mobile.

(define (cube? num)
"Check if an integer is a perfect cube"
  (let ((cube-root (int (pow num (div 3)))))
    (if (= (* cube-root cube-root cube-root) num)
      true
      (if (= (* (+ cube-root 1) (+ cube-root 1) (+ cube-root 1)) num)
        true
        (if (= (* (- cube-root 1) (- cube-root 1) (- cube-root 1)) num)
        true
        nil)))))

Proviamo:

(cube? 8)
;-> true
(cube? 27)
;-> true
(cube? 64)
;-> true
(filter cube? (sequence 1 1000))
;-> (1 8 27 64 125 216 343 512 729 1000)

(= (filter cube? (sequence 1 1000000))
   (map (fn(x) (* x x x)) (sequence 1 100)))
;-> true


------------------------------------
Numeri con quadrati e cubi adiacenti
------------------------------------

Un numero intero positivo N è detto "SquareCube" se risulta:
1) (x - 1) è un quadrato perfetto
e
2) (x + 1) è un cubo perfetto

(define (square? num)
"Check if an integer is a perfect square"
  (let (isq (int (sqrt num)))
    (= num (* isq isq))))

(define (cube? num)
"Check if an integer is a perfect cube"
  (let ((cube-root (int (pow num (div 3)))))
    (if (= (* cube-root cube-root cube-root) num)
      true
      (if (= (* (+ cube-root 1) (+ cube-root 1) (+ cube-root 1)) num)
        true
        (if (= (* (- cube-root 1) (- cube-root 1) (- cube-root 1)) num)
        true
        nil)))))

(define (squarecube? num)
  (and (square? (- num 1)) (cube? (+ num 1))))

Proviamo con numeri fino ad 1 milione:
(filter squarecube? (sequence 1 1e6))
;-> (26)

Solo il numero 26 è "SquareCube":
  (26 - 1) = 25 = 5*5
  (26 + 1) = 27 = 3*3*3


--------------------------
Calcolo del tasso alcolico
--------------------------

Il Metodo "D"
-------------
Il cosiddetto "Metodo D" è stato messo a punto nel 2009 da Giancarlo Dosi, Franco Taggi e Teodora Macchia nell'ambito del progetto "Sistema Ulisse" sviluppato dall'Istituto Superiore di Sanità.

Questo semplice sistema di calcolo, rappresenta uno strumento, seppure approssimato, per la valutazione della propria alcolemia in seguito all'assunzione di bevande alcoliche.

Il metodo si basa sul calcolo della quantità di alcol ingerita espressa in grammi che viene rapportata al proprio peso con un coefficiente di correzione che tiene conto del genere (uomo/donna) e della condizione fisica (digiuno o a stomaco pieno).

Il "Metodo D" produce risultati del tutto simili a quelli delle tabelle ministeriali, con il vantaggio di poter indicare qualsiasi quantità di bevanda alcolica e qualsiasi gradazione.

Rappresentando il metodo con una formula matematica abbiamo:

  Alcolemia = Pa / (P * C)
  dove:
  Pa è il peso in grammi dell'alcol ingerito
  P è il peso della persona espresso in Kg
  C è un coefficiente che varia in base al genere ed alla condizione fisica
  Valori di C :
        Digiuno  Stomaco pieno
  Uomo  0.7      1.2
  Donna 0.5      0.9

Poiché le bevande alcoliche riportano sull'etichetta la gradazione espressa come percentuale del volume di alcol ("% vol") rispetto al volume complessivo della bevanda, per la nostra formula è necessario convertire tale valore in grammi.

Per questo scopo si utilizza un metodo molto semplice che consente di determinare il peso dell'alcol in grammi per un litro di bevanda alcolica moltiplicando per 8 i gradi espressi in "% vol".
Questo metodo si basa sul "peso specifico" dell'alcol che è di circa 0.8 e, anche se le densità delle bevande sono diverse da quella dell'acqua, il numero 8 è considerato un'ottima approssimazione per calcolare il peso dell'alcolo etilico, considerato che le differenze sarebbero trascurabili per il calcolo del tasso alcolemico.
Naturalmente, il valore ottenuto dovrà essere rapportato alla quantità di bevanda alcolica effettivamente ingerita.

Ad esempio, per un litro di birra a 6 gradi avremo 48 grammi di alcol.
Se si beve un boccale da mezzo litro i grammi saranno 24.

Tempo di smaltimento dell'Alcol
-------------------------------
Una volta ingerito, l'alcol è assorbito in parte dalle pareti dello stomaco (il 20% circa) e in parte dall'intestino ed è "metabolizzato" dal fegato ad un ritmo pressoché costante, pari a circa 0,15 mg/ora.

Erroneamente si ritiene che vi siano metodi per accelerare lo smaltimento dell'alcol, come ad esempio bere acqua o caffé, ma in realtà il tempo necessario affinché il fegato metabolizzi le molecole di alcol etilico non può essere alterato e dipende essenzialmente dalle condizioni fisiche del soggetto e dal buon funzionamento del fegato stesso.

Per questo motivo, una volta calcolato il tasso alcolico nel sangue, è possibile stimare, sempre in via teorica e a titolo indicativo, quanto tempo si impiega per tornare sobri, o quanto tempo dovrà trascorrere per tornare sotto il limite legale per la guida.

Ad esempio, se l'alcolemia raggiunta è pari a 1.8 mg/litro serviranno all'incirca 1.8 / 0.15 = 12 ore per tornare sobri.
In questo caso, per tornare sotto il limite legale per la guida, dovremo calcolare il tempo necessario per smaltire 1.8 - 0.5 = 1.3 mg di alcol che sarà pari a circa 8.7 ore.

Formula di Widmark
------------------
La formula di Widmark, già nota fin dalla prima metà del '900, calcola il livello di alcolemia considerando il rapporto tra peso corporeo e quantità di sangue nel corpo, senza tenere conto della condizione fisica del soggetto (stomaco vuoto o stomaco pieno):

  Alcolemia = (Pa * 1,055) / (P * Fw) 
  dove:
  Pa è il peso in grammi dell'alcol ingerito (si calcola come nel "metodo D")
  1,055 è una costante che indica il peso specifico del sangue
  P è il peso della persona espresso in Kg
  Fw è il cosiddetto "fattore di Widmark", talvolta detto anche "coefficiente di diffusione", che varia in base al genere: uomo = 0.73 e donna = 0.66

Successivamente, la formula di Widmark è stata migliorata introducendo ulteriori elementi legati alla costituzione corporea, tra cui il TBW (Total Body Water), ossia il quantitativo totale di acqua nel corpo.

Il fattore di Widmark corretto con il TBW diventa:

  Fw = TBW / (0.8 * P)

Per il calcolo del TBW, che cambia in base al genere, si tiene conto dell'età, dell'altezza e del peso del soggetto utilizzando le seguenti formule:

  Uomo: 
  TBW = 2.447 - 0.0952 * E + 0.1074 * A + 0.3362 * P
  Donna:  
  TBW = 0.203 - 0.07 * E + 0.1069 * A + 0.2466 * P
  dove:
  E è l'età espressa in anni
  A è l'altezza espressa in centimetri
  P è il peso corporeo espresso in Kg

--------------------------------
Tabelle alcolemiche ministeriali
--------------------------------
Le tabelle alcolemiche ministeriali sono state pubblicate dal Ministero della Salute in seguito all'approvazione del Decreto Legge 3 agosto 2007 n. 117 convertito in legge, con modificazioni, dall’art. 1 della legge 2 ottobre 2007 n. 160, che ha inasprito il limite legale del tasso alcolemico per la guida portandolo dai precedenti 0.8 g/litro agli attuali 0.5 g/litro, come stabilito dall'Art. 6.
Le tabelle riportano i valori per le principali bevande alcoliche secondo le cosiddette "unità alcoliche di riferimento", ossia le quantità servite nella maggior parte dei casi, come ad esempio la classica lattina di birra da 330 ml, o il bicchiere di vino da 125 ml.
Nota: nelle tabelle ministeriali le quantità sono indicate in "cc" (centimetri cubi) mentre nella quasi totalità delle bevande che si trovano in commercio, trattandosi di liquidi, la quantità è espressa in "ml" (millilitri) o "cl" (centilitri).
Vedi "tabella-alcolemica.png" nella cartella "data".

============================================================================

