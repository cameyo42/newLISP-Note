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

============================================================================

