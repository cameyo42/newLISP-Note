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
  (int (add 0.5 (div (sub (pow phi n) (pow psi n)) sr))))

(fibo 3)
;-> 2
(setq ff (map fibo (sequence 0 20)))
;-> (0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765)

Indice di un numero di Fibonacci:

  n = floor(log(phi) / log(F*sqrt(5) + (1/2)))

(define (n-fibo fib) (floor (div (log (add (mul fib sr) 0.5)) (log phi))))

(n-fibo 6765)
;-> 20

Somma dei primi n numeri di fibonacci:

  Sum[i..0 n]F(i) = F(n+2) - 1

(define (sum-fib-to n) (- (fibo (+ n 2)) 1))

(sum-fib-to 10)
;-> 143
(apply + (slice ff 1 10))
;-> 143
(apply + (slice ff 0 11))
;-> 143

Sezione aurea:

   lim (F(n+1)/F(n) = phi = (1 + sqrt(5))/2
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

============================================================================

