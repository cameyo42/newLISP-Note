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

============================================================================

