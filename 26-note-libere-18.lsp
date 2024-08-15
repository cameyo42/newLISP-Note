================

 NOTE LIBERE 18

================

  (pietra) --> (aperti aprite pareti patrie perita rapite ripeta)

------------------------------------------
Tavola Periodica degli Elementi (ricerche)
------------------------------------------

Nella cartella "data" si trova il file "periodic-table.csv" che contiene dati sulla Tavola Periodica degli Elementi (in formato Comma Separated Value).

Per caricare il file in una lista:

(setq table '())
(setq file (open "periodic-table.csv" "read"))
(while (read-line file) (push (parse (current-line) ",") table -1))
(close file)

Adesso i dati si trovano nella lista "table" e il nomi dei campi si trovano nel primo elemento della lista:

(table 0)
;-> ("Atomic_Number" "Element" "Nome" "Symbol" "Atomic_Weight" "Period"
;->  "Group" "Phase" "Type" "Ionic_Radius" "Atomic_Radius" "Electronegativity"
;->  "First_Ionization_Potential" "Density" "Melting_Point(K)"
;->  "Boiling_Point(K)" "Isotopes" "Year_Discovery" "Specific_Heat_Capacity"
;->  "Display_Row" "Display_Column")

Numero dei campi:

(length (table 0))
;-> 21

Vediamo come possiamo fare delle ricerche in questa lista.
Utilizziamo la seguente lista (parziale) per fare le ricerche:

(setq data '(
    ("Nome" "Symbol" "Atomic_Weight" "Period" "Group" "Phase" "Type")
    ("Idrogeno" "H" "1.00794" "1" "1" "gas" "Nonmetal")
    ("Elio" "He" "4.002602" "1" "18" "gas" "Noble Gas")
    ("Litio" "Li" "6.941" "2" "1" "solid" "Alkali Metal")
    ("Berillio" "Be" "9.012182" "2" "2" "solid" "Alkaline Earth Metal")
    ("Boro" "B" "10.811" "2" "13" "solid" "Metalloid")
    ("Carbonio" "C" "12.0107" "2" "14" "solid" "Nonmetal")
    ("Azoto" "N" "14.0067" "2" "15" "gas" "Nonmetal")
    ("Ossigeno" "O" "15.9994" "2" "16" "gas" "Nonmetal")
    ("Fluoro" "F" "18.9984032" "2" "17" "gas" "Halogen")
    ("Neon" "Ne" "20.1797" "2" "18" "gas" "Noble Gas")
    ("Sodio" "Na" "22.98976928" "3" "1" "solid" "Alkali Metal")
    ("Magnesio" "Mg" "24.305" "3" "2" "solid" "Alkaline Earth Metal")
    ("Alluminio" "Al" "26.9815386" "3" "13" "solid" "Metal")
    ("Silicio" "Si" "28.0855" "3" "14" "solid" "Metalloid")
    ("Fosforo" "P" "30.973762" "3" "15" "solid" "Nonmetal")
    ("Zolfo" "S" "32.065" "3" "16" "solid" "Nonmetal")
    ("Cloro" "Cl" "35.453" "3" "17" "gas" "Halogen")
    ("Argon" "Ar" "39.948" "3" "18" "gas" "Noble Gas")
    ("Potassio" "K" "39.0983" "4" "1" "solid" "Alkali Metal")
    ("Calcio" "Ca" "40.078" "4" "2" "solid" "Alkaline Earth Metal")
    ("Scandio" "Sc" "44.955912" "4" "3" "solid" "Transition Metal")))

Esempi:

(find '("Litio" *) data match)
;-> 3
$0
;-> ("Litio" "Li" "6.941" "2" "1" "solid" "Alkali Metal")

(find-all '(* "Calcio" *) data)
;-> (("Calcio" "Ca" "40.078" "4" "2" "solid" "Alkaline Earth Metal"))

(find-all '(* "F" *) data)
;-> (("Fluoro" "F" "18.9984032" "2" "17" "gas" "Halogen"))

(find-all '(* "Noble Gas" *) data)
;-> (("Elio" "He" "4.002602" "1" "18" "gas" "Noble Gas")
;->  ("Neon" "Ne" "20.1797" "2" "18"  "gas" "Noble Gas")
;->  ("Argon" "Ar" "39.948" "3" "18" "gas" "Noble Gas"))

(lookup "Litio" data)
;-> "Alkali Metal"

(assoc "Litio" data)
;-> ("Litio" "Li" "6.941" "2" "1" "solid" "Alkali Metal")

(setq column (find "Type" (data 0)))
(setq out '())
(for (i 1 (- (length data) 1))
  (if (= (data i column) "Nonmetal")
      (push (data i) out -1)))
out
;-> (("Idrogeno" "H" "1.00794" "1" "1" "gas" "Nonmetal")
;->  ("Carbonio" "C" "12.0107" "2" "14" "solid" "Nonmetal")
;->  ("Azoto" "N" "14.0067" "2" "15" "gas" "Nonmetal")
;->  ("Ossigeno" "O" "15.9994" "2" "16" "gas" "Nonmetal")
;->  ("Fosforo" "P" "30.973762" "3" "15" "solid" "Nonmetal")
;->  ("Zolfo" "S" "32.065" "3" "16" "solid" "Nonmetal"))

(ref-all "solid" data)
;-> ((3 5) (4 5) (5 5) (6 5) (11 5) (12 5) (13 5) (14 5) (15 5) (16 5) (19 5) (20 5)
;->  (21 5))

(ref-all "Noble Gas" data)
;-> ((2 6) (10 6) (18 6))

(select data '(2 10 18))
;-> (("Elio" "He" "4.002602" "1" "18" "gas" "Noble Gas")
;->  ("Neon" "Ne" "20.1797" "2" "18"  "gas" "Noble Gas")
;->  ("Argon" "Ar" "39.948" "3" "18" "gas" "Noble Gas"))

(select data (map first (ref-all "Noble Gas" data)))
;-> (("Elio" "He" "4.002602" "1" "18" "gas" "Noble Gas")
;->  ("Neon" "Ne" "20.1797" "2" "18"  "gas" "Noble Gas")
;->  ("Argon" "Ar" "39.948" "3" "18" "gas" "Noble Gas"))

Continua...


------------------------
Notazione per intervalli
------------------------

La notazione degli intervalli è un modo per rappresentare uno o più intervalli complicati in modo più conveniente e conciso rispetto alla scrittura di un intervallo completo.
Un intervallo viene definito nel modo seguente:

  < ( | [ > <integer> <comma> <integer> < ) | ]>

dove:
  ( significa "intervallo aperto all'inizio"
  [ significa "intervallo chiuso all'inizio"
  ) significa "intervallo aperto alla fine"
  ] significa "intervallo chiuso alla fine"
  integer è un numero intero
  comma è il carattere ","

Esempi:
  (1,5) --> 2 3 4
  [1,5] --> 1 2 3 4 5
  (1 5] --> 2 3 4 5
  [1,5) --> 1 2 3 4

Funzione che converte un intervallo breve in un intervallo esteso:

(define (short-long interval)
  (local (lst del1 del2 val1 val2 start end)
    (setq del1 (interval 0))
    (setq del2 (interval -1))
    (replace "[" interval "(")
    (replace "]" interval ")")
    ; "parse" don't likes "[" and "]"
    (setq lst (parse interval))
    (setq val1 (int(lst 1)))
    (setq val2 (int(lst 3)))
    ;(println del1 { } del2 { } val1 { } val2)
    (cond
      ((and (not (= del1 "(")) (not (= del1 "["))) nil)
      ((and (not (= del2 ")")) (not (= del2 "]"))) nil)
      ((not (integer? val1)) nil)
      ((not (integer? val2)) nil)
      (true
        (if (= del1 "(")
            (setq start (+ val1 1))
            ;else
            (setq start val1)
        )
        (if (= del2 ")")
            (setq end (- val2 1))
            ;else
            (setq end val2)
        )
        (sequence start end)))))

Facciamo alcuni esempi:

(short-long "(1,10)")
;-> (2 3 4 5 6 7 8 9)
(short-long "[1,10)")
;-> (1 2 3 4 5 6 7 8 9)
(short-long "[1,10]")
;-> (1 2 3 4 5 6 7 8 9 10)
(short-long "[1,10)")
;-> (1 2 3 4 5 6 7 8 9)

(define (long-short seq del1 del2)
    (string del1 (seq 0) "," (seq -1) del2)))

(long-short '(1 2 3 4 5) "(" ")")
;-> "(1,5)"


------------------
La funzione "Over"
------------------

"Over" è una funzione di ordine superiore. Prende 2 funzioni e 2 valori come argomenti, applica la prima funzione a entrambi i valori, quindi applica la seconda funzione al loro risultato.

La funzione prende i seguenti parametri:
  f: funzione che prende un parametro e restituisce un valore
  g: funzione che prende due parametri e restituisce un valore
  a: parametro
  b: parametro

La funzione restituisce: g(f(a), f(b)).

Funzione "over":

(define (over g f a b) (g (f a) (f b)))

Facciamo alcune prove:

(setq func1 (fn(x y) (+ x y)))
(setq func2 (fn(x) (* x x)))
(over func1 func2 2 3)
;-> 13

(over + (fn(x) (* x x)) 2 3)
;-> 13

(over + sqrt 16 64)
;-> 12

(over append title-case "super" "pippo")
;-> "SuperPippo"

ChatGPT (7 agosto 2023)
-----------------------
The use of the term "over" as a specific function name or operator in programming languages might not be as common as in APL, but the concept of reducing or folding over a sequence of values is present in various programming languages. Some languages might use different names or symbols for this concept. Here are a few examples:

Haskell: Haskell has a function called foldl and foldr which can be used to apply a binary function to the elements of a list in a left-to-right or right-to-left manner, respectively. While they aren't directly named "over," they serve a similar purpose.

Python: Python has the built-in reduce() function in the functools module, which can be used to apply a binary function to elements of a sequence in a cumulative way. It's similar to the concept of "over" but doesn't have the exact same naming.

Ruby: Ruby has the inject method, which is similar to the concept of "over." It allows you to apply a binary operation to elements of an enumerable in a cumulative manner.

LISP: LISP dialects like Common Lisp and Scheme have functions like foldl, foldr, and reduce that perform similar operations by applying a function to elements of a list in a cumulative way.

Clojure: Clojure has the reduce function, which takes a binary function and a collection, and applies the function to elements of the collection in a cumulative manner.

These examples demonstrate the concept of reducing or folding over a collection of values in various programming languages. The specific function names might vary, but the underlying idea remains consistent across these languages.


----------------
Numeri di Meeker
----------------

I numeri Meeker sono numeri interi di 7 cifre nella forma abcdefg, dove:

  a*b = 10*c + d
  d*e = 10*f + g.

Inoltre i numeri di di Meeker non hanno zeri iniziali, cioè a != 0.

Per esempio 6742612 è un numero di Meeker:
  6*7 = 10*4 + 2
  2*6 = 10*1 + 2

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che verifica se un numero è di Meeker:

(define (meeker? num)
  (letn (d (int-list num))
    (and (= (* (d 0) (d 1)) (+ (* 10 (d 2)) (d 3)))
        (= (* (d 3) (d 4)) (+ (* 10 (d 5)) (d 6))))))

(meeker? 6742612)
;-> true

Funzione che calcola tutti i numeri di Meeker:
(define (meeker-all)
  (let (out '())
    (for (i 1000000 9999999)
      (if (meeker? i) (push i out -1))
    )
    out))

(time (println (meeker-all)))
;-> (1000000 1000100 1000200 1000300 1000400 1000500 1000600 1000700 1000800
;->  1000900 1101000 1101101 1101202 1101303 1101404 1101505 1101606 1101707
;-> ...
;->  9872204 9872306 9872408 9872510 9872612 9872714 9872816 9872918 9981000
;->  9981101 9981202 9981303 9981404 9981505 9981606 9981707 9981808 9981909)
;-> 10671.14


---------------------------------------------
Numeri primi aggiungendo un suffisso/prefisso
---------------------------------------------

Dato un numero intero positivo, calcolare il numero intero positivo più piccolo in modo tale che l'aggiunta delle sue cifre alla fine (o all'inizio) del numero dato formi un numero primo.

Esempi:

N       prefisso (primo)    suffisso (primo)
3493    3 (33493)            9 (34939)
3492    nil (nil)           11 (349211)

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che cerca il primo numero primo aggiungendo un suffisso (k=0...):
(si può dimostrare che questo numero primo esiste sempre).

(define (prime-suf num)
  (local (stop k)
    (setq stop nil)
    (setq k 0)
    (until stop
      (if (prime? (int (string num k)))
          (setq stop true)
          ;else
          (++ k)
      )
    )
    (list num k (int (string num k)))))

Funzione che cerca il primo numero primo aggiungendo un prefisso (k=1...):
(in questo caso il numero primo non esiste sempre).

(define (prime-pre num)
  (local (stop k)
    (cond
      ; i numeri pari non hanno primi con prefisso
      ((even? num) (setq k nil))
      ; i numeri che terminano con 5 non hanno primi con prefisso
      ((= ((string num) -1) "5") (setq k nil))
      (true
        (setq stop nil)
        (setq k 1)
        (until stop
          (if (prime? (int (string k num)))
              (setq stop true)
              ;else
              (++ k))))
     )
     (list k num (int (string k num)))))

Facciamo alcune prove:

(prime-pre 3493)
;-> (3 3493 33493)
(prime-suf 3493)
;-> (3493 9 34939)
(prime-suf 3492)
;-> (3492 11 349211)
(prime-pre 3492)
;-> (nil 3492 nil)

(for (i 1 50) (println i { } (prime-suf i) { } (prime-pre i)))
;-> 1 (1 1 11) (1 1 11)
;-> 2 (2 3 23) (nil 2 nil)
;-> 3 (3 1 31) (1 3 13)
;-> 4 (4 1 41) (nil 4 nil)
;-> 5 (5 3 53) (nil 5 nil)
;-> 6 (6 1 61) (nil 6 nil)
;-> 7 (7 1 71) (1 7 17)
;-> 8 (8 3 83) (nil 8 nil)
;-> 9 (9 7 97) (1 9 19)
;-> 10 (10 1 101) (nil 10 nil)
;-> 11 (11 3 113) (2 11 211)
;-> 12 (12 7 127) (nil 12 nil)
;-> 13 (13 1 131) (1 13 113)
;-> 14 (14 9 149) (nil 14 nil)
;-> 15 (15 1 151) (nil 15 nil)
;-> 16 (16 3 163) (nil 16 nil)
;-> 17 (17 3 173) (3 17 317)
;-> 18 (18 1 181) (nil 18 nil)
;-> 19 (19 1 191) (4 19 419)
;-> 20 (20 11 2011) (nil 20 nil)
;-> 21 (21 1 211) (4 21 421)
;-> 22 (22 3 223) (nil 22 nil)
;-> 23 (23 3 233) (2 23 223)
;-> 24 (24 1 241) (nil 24 nil)
;-> 25 (25 1 251) (nil 25 nil)
;-> 26 (26 3 263) (nil 26 nil)
;-> 27 (27 1 271) (1 27 127)
;-> 28 (28 1 281) (nil 28 nil)
;-> 29 (29 3 293) (2 29 229)
;-> 30 (30 7 307) (nil 30 nil)
;-> 31 (31 1 311) (1 31 131)
;-> 32 (32 17 3217) (nil 32 nil)
;-> 33 (33 1 331) (2 33 233)
;-> 34 (34 7 347) (nil 34 nil)
;-> 35 (35 3 353) (nil 35 nil)
;-> 36 (36 7 367) (nil 36 nil)
;-> 37 (37 3 373) (1 37 137)
;-> 38 (38 3 383) (nil 38 nil)
;-> 39 (39 7 397) (1 39 139)
;-> 40 (40 1 401) (nil 40 nil)
;-> 41 (41 9 419) (2 41 241)
;-> 42 (42 1 421) (nil 42 nil)
;-> 43 (43 1 431) (4 43 443)
;-> 44 (44 3 443) (nil 44 nil)
;-> 45 (45 7 457) (nil 45 nil)
;-> 46 (46 1 461) (nil 46 nil)
;-> 47 (47 9 479) (3 47 347)
;-> 48 (48 7 487) (nil 48 nil)
;-> 49 (49 1 491) (1 49 149)
;-> 50 (50 3 503) (nil 50 nil)


-------------------------------------------------------------------
Sotto la pioggia è meglio correre o camminare per bagnarsi di meno?
-------------------------------------------------------------------

Una domanda semplice a cui è molto complesso rispondere.

La domanda se correre o camminare sotto la pioggia solleva una serie di problemi e considerazioni inaspettate, e in effetti, gran parte della discussione scientifica sulla questione tratta argomenti teorici molto specifici e aspetti del problema che non sono affatto pratici da considerare nel mondo reale.
Ci sono diversi articoli che trattano il problema matematicamente:

"Walk or run in the rain?" David E. Bell
The Mathematical Gazette, Volume 60, Number 413, October 1976
Conclude che correre permette di arrivare più asciutti dal 10% al 40%.
Comunque, se la pioggia cade di traverso contro la direzione che corriamo, allora dobbiamo correre il più velocemente possibile, mentre se la pioggia cade di traverso verso la direzione che corriamo, allora esiste una velocità ottimale per prendere meno acqua.

"It is really worth running in the rain?" Alessandro De Angelis
European Journal of Physics, Volume 8, Number 3, July 1987
Conclude che, sebbene correre fa prendere meno acqua, lo sforzo vale il risultato?

"Whether or not to run in the rain" Franco Bocci
European Journal of Physics, Volume 33, Number 5, July 2012
Conclude che la risposta dipende dalla forma e dall'orientamento del corpo in movimento e dalla direzione e intensità del vento.
Per diverse forme del corpo, la strategia migliore può essere diversa: in alcuni casi è meglio correre il più velocemente possibile, mentre in altri esiste una velocità ottimale.

ChatGPT (7 agosto 2023)
-----------------------
Se il tuo obiettivo è di bagnarti il meno possibile mentre ti sposti sotto la pioggia, in generale correre sarebbe una migliore opzione rispetto a camminare. Quando corri, riduci al minimo il tempo in cui sei esposto alla pioggia, il che può contribuire a ridurre la quantità complessiva di pioggia che entra in contatto con il tuo corpo.

Camminando, il tempo di esposizione alla pioggia è maggiore rispetto alla corsa, il che può causare un maggior numero di gocce di pioggia che ti colpiscono. Correre può aiutarti a raggiungere la tua destinazione più velocemente, riducendo quindi il tempo che passi sotto la pioggia e potenzialmente diminuendo la quantità di pioggia che si accumula sui tuoi vestiti e sul corpo.

Tuttavia, è importante notare che la velocità alla quale la pioggia cade e l'intensità della pioggia possono influire anche su quanto ti bagni. Correndo, potresti ricevere le gocce di pioggia con maggiore forza a causa della velocità maggiore, il che potrebbe causare un tipo diverso di bagnatura rispetto a quando cammini.

In ogni caso, indossare abbigliamento adeguato per la pioggia, come una giacca impermeabile, pantaloni e scarpe impermeabili, può aiutare significativamente a mantenere il corpo asciutto, indipendentemente dalla scelta di correre o camminare sotto la pioggia.
-----------------------

Quindi, per rispondere alla domanda iniziale, sembra abbastanza chiaro che correre sotto la pioggia ci permette di arrivare più asciutti (fino al 40%) alla meta.
A livello umano, tuttavia, se valga o meno la pena correre sotto la pioggia è oggetto di discussione.
Correre significa una maggiore possibilità di sguazzare nelle pozzanghere, inciampare,
o arrivare a destinazione non solo bagnati, ma anche accaldati e sudati.
Molte persone potrebbero preferire di camminare e bagnarsi di più (lo sforzo fisico non è sempre gradito).

----------------------------------------------------------
Ricostruzione dei numeri primi dalla lista degli esponenti
----------------------------------------------------------

Un numero primo può essere espresso nella forma:

  prime = Prod[primo p](p^e) = (2^e2)*(3^e3)*(7^e7)...

Possiamo quindi ricostruire un numero primo dalla lista degli esponenti:

  (e2 e3 e5 e7 e11 ...)

Per esempio:

  E = (2 0 2 1 0 1) = 2^2 * 3^0 * 5^2 * 7^1 * 11^0 * 13^1 = 9100

(* (pow 2 2) (pow 3 0) (pow 5 2) (pow 7 1) (pow 11 0) (pow 13 1))
;-> 9100

(factor 9100)
;-> (2 2 5 5 7 13)

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

Vediamo quanti primi possiamo calcolare:

(time (println (length (primes-to 1e2))))
;-> 25
;-> 0
(time (println (length (primes-to 500))))
;-> 95
;-> 0.007
(time (println (length (primes-to 1e3))))
;-> 168
;-> 0.997
(time (println (length (primes-to 1e4))))
;-> 1229
;-> 0.998
(time (println (length (primes-to 1e5))))
;-> 9592
;-> 10.999
(time (println (length (primes-to 1e6))))
;-> 78498
;-> 147.594

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (make-prime lst)
  (local (primi len)
    ; 25 primi
    (setq primi '(2 3 5 7 11 13 17 19 23 29 31 37 41
                  43 47 53 59 61 67 71 73 79 83 89 97))
    (setq len (length lst))
    (if (> len 25)
        (cond ((<= len 95)    (setq primi (primes-to 500)))
              ((<= len 168)   (setq primi (primes-to 1e3)))
              ((<= len 1229)  (setq primi (primes-to 1e4)))
              ((<= len 9592)  (setq primi (primes-to 1e5)))
              ((<= len 78498) (setq primi (primes-to 1e9)))
              (true (println "Error: length = " len " > 78498"))))
    (apply * (map ** (slice primi 0 len) lst))))

Facciamo alcune prove:

(setq lst '(2 0 2 1 0 1))

(make-prime lst)
;-> 9100

(make-prime '(0))
;-> 1L ;ma non è un numero primo

(make-prime '(1))
;-> 2L ;ecco il primo numero primo

(make-prime '(3 2) )
;-> 72L
(make-prime '(0 1 2))
;-> 75L
(make-prime '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
              0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
              0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))
;-> 347L
(make-prime '(6 2))
;-> 576L
(make-prime '(1 7))
;-> 4374L
(make-prime '(5 7))
;-> 69984L
(make-prime '(10 5))
;-> 248832L
(make-prime '(1 0 0 8 4))
;-> 168804902882L
(make-prime '(3 8 10))
;-> 512578125000L
(make-prime '(7 9 0 8))
;-> 14523977994624L
(make-prime '(4 4 7 0 0 5 5))
;-> 53377275216476250000L
(make-prime '(1 8 1 7 8 1))
;-> 150570936449966222190L
(make-prime '(10 0 2 8 9))
;-> 347983339699826969600L
(make-prime '(4 8 2 3 7 9))
;-> 186021488852335961308083600L
(make-prime '(7 6 6 8 6 8 4))
;-> 1014472920935186644572261278658000000L
(make-prime '(9 6 7 5 1 8 10))
;-> 8865565384329431006794755470280000000L


-------------------
Stringhe divisibili
-------------------

Data una stringa s, scrivere una funzione che restituisce vero se il codice ASCII di ogni lettera (32-126) è divisibile per la lunghezza di s, falso in caso contrario.

(define (divisible str)
  (let (len (length str))
    (for-all (fn(x) (zero? (% x len))) (map char (explode str)))))

Facciamo alcune prove:

(divisible "lol")
;-> true

(divisible "ciao")
;-> nil

(divisible "8  8")
;-> true


-----------------
Casio M functions
-----------------

La maggior parte delle calcolatrici Casio presenta una variabile M, a cui sono associati 3 operatori: M, M+ e M-.
In questo caso aggiungiamo altri due operatori: M* e M/.

Abbiamo le seguenti funzioni che agiscono sulla variabile M:

  (M)    --> ritorna il valore della variabile M
  (x M)  --> imposta il valore M = x
  (x M+) --> ritorna il valore di M + x
  (x M-) --> ritorna il valore di M - x
  (x M*) --> ritorna il valore di M * x
  (x M/) --> ritorna il valore di M / x

Scrivere un programma che esegue le funzionalità elencate.

(define (casio)
  (local (M expr x op)
    (setq M 0)
    (setq expr "")
    (until (= expr "exit")
      (setq expr (read-line))
      (cond ((!= expr "exit")
              (setq expr (read-expr expr))
              (cond ((and (= (length expr) 1) (= (expr 0) 'M))
                      (println M))
                    ((and (= (length expr) 1) (!= (expr 0) 'M))
                      (println "error: " expr))
                    ((> (length expr) 2)
                      (println "error: " expr))
                    (true
                      (setq x (eval (expr 0)))
                      (setq op (expr 1))
                      (cond ((= op 'M)  (setq M x))
                            ((= op 'M+) (setq M (add M x)))
                            ((= op 'M-) (setq M (sub M x)))
                            ((= op 'M*) (setq M (mul M x)))
                            ((= op 'M/) (setq M (div M x)))
                            (true (println "error: " expr))
                      ))
              ))
      ))))

(casio)
(M)
;-> 0
(12 M)
(M)
;-> 12
(2 M/)
(M)
;-> 6
(3 M*)
(M)
;-> 18
(m)
;-> error: (m)
(10 MM)
;-> error: (10 MM)
(M)
;-> 18
exit
;-> nil


----------------------------------------
Lista con tutti numeri uguali tranne uno
----------------------------------------

Data una lista/vettore con le seguenti caratteristiche:

- solo numeri interi positivi
- almeno tre numeri
- tutti i numeri sono uguali tranne uno.

Trovare l'elemento univoco e il suo indice.

Primo metodo:

(define (unico lst)
  (local (out a b c same stop)
    (setq out '())
    ; controlla i primi tre elementi
    (setq a (lst 0))
    (setq b (lst 1))
    (setq c (lst 2))
    (cond ((= a b c) (setq same a))
          ((!= a b)
            (if (= a c)
              (setq out (list b '(1)))
              (setq out (list a '(0)))))
          ((!= a c)
            (if (= a b)
              (setq out (list c '(2)))
              (setq out (list a '(0)))))
          ((!= b c)
            (if (= a b)
                (setq (list c '(2)))
                (setq (list b '(1)))))
    )
    (if (= out '()) ; primi 3 elementi tutti uguali?
      (begin
        ; allora cerchiamo l'elemento diverso
        (setq stop nil)
        (for (i 3 (- (length lst) 1) 1 stop)
          (if (!= (lst i) same) (setq out (list (lst i) (list i)) stop true))
        )
      )
    )
    out))

(setq m '(1 1 1 1 1 1 1 3 1 1 1))
(unico m)
;-> (3 (7))

(unico '(1 2 2))
;-> (1 (0))
(unico '(2 1 2))
;-> (1 (1))
(unico '(2 2 1))
;-> (1 (2))
(unico '(2 2 2 3))
;-> (3 (3))

Secondo metodo:

(define (unico2 lst)
  (setq t (sort (copy lst)))
  ; controlla il secondo e l'ultimo elemento della lista ordinata
  (if (= (t 1) (t -1))
      ; elementi uguali --> elemento diverso in prima posizione (0)
      (setq out (list (t 0) (ref (t 0) lst)))
      ; elementi diversi --> elemento diverso in ultima posizione
      (setq out (list (t -1) (ref (t -1) lst)))))

Facciamo alcune prove:

(unico2 m)
;-> (3 (7))

(unico '(1 2 2))
;-> (1 (0))
(unico '(2 1 2))
;-> (1 (1))
(unico '(2 2 1))
;-> (1 (2))
(unico '(2 2 2 3))
;-> (3 (3))

Proviamo con due liste di numeri:

(silent
  (setq len 10000)
  (setq x (dup 2 len))
  (setf (x (rand len)) 3)
  (setq y (dup 2 len))
  (setf (y (rand len)) 1)
)

(unico x)
;-> (3 (3502))
(unico2 x)
;-> (3 (3502))
(unico y)
;-> (1 (8959))
(unico2 y)
;-> (1 (8959))

Tempi di esecuzione:

(time (unico x) 100)
;-> 762.909
(time (unico2 x) 100)
;-> 75.529
(time (unico y) 100)
;-> 5153.963
(time (unico2 y) 100)
;-> 72.59

Con le liste è più veloce il secondo metodo.

Proviamo con due vettori di numeri (con la seconda funzione dobbiamo usare "array-list" perchè "ref" non si applica ai vettori):

(silent
  (setq len 10000)
  (setq x (array len (dup 2 len)))
  (setf (x (rand len)) 3)
  (setq y (array len (dup 2 len)))
  (setf (y (rand len)) 1)
)

(unico x)
;-> (3 (1741))
(unico2 (array-list x))
;-> (3 (1741))
(unico y)
;-> (1 (8589))
(unico2 (array-list y))
;-> (1 (8589))

(silent
(setq x (array 10000 (dup 2 10000)))
(setf (x 1741) 3)
(setq y (array 10000 (dup 2 10000)))
(setf (y 8589) 1))

Tempi di esecuzione:

(time (unico x) 100)
;-> 11.044
(time (unico2 (array-list x)) 100)
;-> 78.821
(time (unico y) 100)
;-> 44.332
(time (unico2 (array-list y)) 100)
;-> 73.834

Con i vettori il primo metodo è il più veloce (ma dobbiamo considerare il tempo necessario per trasformare il vettore in lista).

(setq x1 (array-list x))
(time (unico2 x1) 100)
;-> 78.8169999999
(setq y1 (array-list y))
(time (unico2 y1) 100)
;-> 73.83

Quindi il tempo per la conversione da vettore in lista è ininfluente.


---------------------
La funzione di Cantor
---------------------

La funzione di Cantor è un esempio di funzione continua e crescente nonostante abbia derivata zero in quasi tutti i punti essendo costante in tutti i sottointervalli di [0,1] che non contengono punti dell'insieme di Cantor.
Quindi si tratta di una scala con infiniti gradini, tutti di pendenza zero, ma ad altezze progressivamente crescenti, in modo che la pendenza media risulti comunque pari a 1.

Vedi le figure "cantor_function.png" e "cantor_function.gif" nella cartella "data".

La funzione può essere definita in modo ricorsivo:

  f(0, x) = x

              | (1/2)*(f n 3x)                con x in [0,1/3)
  f(n+1, x) = | 1/2                           con x in [1/3,2/3)
              | (1/2) + (1/2)*(f n (3x - 2))  con x in [2/3,1]

La funzione è il limite del processo:

  lim[f(n, x)]
  n->inf

(define (cantor n x)
  (println n { } x)
  (cond ((zero? n) x)
        ((and (>= x 0) (< x (div 3)))
          (mul 0.5 (cantor (- n 1) (mul 3 x))))
        ((and (>= x (div 3)) (< x (div 2 3)))
          (div 2))
        ((and (>= x (div 2 3)) (<= x 1))
          (add 0.5 (mul 0.5 (cantor (- n 1) (sub (mul 3 x) 2)))))))

Facciamo alcune prove:

(cantor 3 0.3)
;-> 0.3874999999999999
(cantor 0 0.1)
;-> 0.1
(cantor 4 0.29)
;-> 0.375
(cantor 5 0.11)
;-> 0.2415624999999999


----------------
Punti collineari
----------------

Dati 3 punti in un reticolo cartesiano 2D, determinare se sono tutti collineari.

Tre punti p1(x1,y1), p2(x2,y2) e p3(x3,y3) sono collineari se risulta:

  (x1-x2)*(y1-y3) = (y1-y2)*(x1-x3)

(define (collinear p1 p2 p3)
  (= (mul (sub (p1 0) (p2 0)) (sub (p1 1) (p3 1)))
     (mul (sub (p1 1) (p2 1)) (sub (p1 0) (p3 0)))))

Facciamo alcune prove:

(collinear '(1 1) '(2 2) '(3 3))
;-> true
(collinear '(1 1) '(2 2) '(10 10))
;-> true
(collinear '(10 1) '(10 2) '(10 3))
;-> true
(collinear '(1 10) '(2 10) '(3 10))
;-> true
(collinear '(1 1) '(2 2) '(3 4))
;-> nil
(collinear '(1 1) '(2 0) '(2 2))
;-> nil
(collinear '(-5 70) '(2 0) '(-1 30))
;-> true
(collinear '(460 2363) '(1127 2392) '(-1334 2285))
;-> true
(collinear '(-789 -215) '(-753 -110) '(518 -780))
;-> nil
(collinear '(227816082 4430300) '(121709952 3976855) '(127369710 4001042))
;-> true
(collinear '(641027 3459466) '(475989 3458761) '(-675960 3453838))
;-> nil


--------------------
Quale era e periodo?
--------------------

Dato un valore intero positivo compreso tra 0 e 542 che rappresenta milioni di anni fa, stabilire l'era e il periodo geologico.

I nomi e le suddivisioni delle ere e dei periodi geologici sono i seguenti:

Cenozoico  0 - 66
  Quaternario   0 - 3
  Neogene       4 - 23
  Paleogene    24 - 66
Mesozoico  67 - 252
  Cretaceo     67 - 145
  Giurassico  146 - 201
  Triassico   202 - 252
Paleozoico 253 - 542
  Permiano    253 - 299
  Carbonifero 300 - 359
  Devoniano   360 - 419
  Siluriano   420 - 444
  Ordoviciano 445 - 485
  Cambriano   486 - 542

Cenozoic  0 - 66
  Quaternary      0 - 3
  Neogene         4 - 23
  Paleogene      24 - 66
Mesozoic  67 - 252
  Cretaceous     67 - 145
  Jurassic      146 - 201
  Triassic      202 - 252
Paleozoic 253 - 542
  Permian       253 - 299
  Carboniferous 300 - 359
  Devonian      360 - 419
  Silurian      420 - 444
  Ordovician    445 - 485
  Cambrian      486 - 542

Esempi:
314 -> Paleozoic/Carboniferous
  0 -> Cenozoic/Quaternary
542 -> Paleozoic/Cambrian
100 -> Mesozoic/Cretaceous

Definiamo le strutture dati:

(setq ere '(("Cenozoico" 0 66) ("Mesozoico" 67 252) ("Paleozoico" 253 542)))

(setq periodi '(
  ("Cenozoico" (("Quaternario" 0 3)
                ("Neogene"     4 23)
                ("Paleogene"  24 66)))
  ("Mesozoico" (("Cretaceo"     67 145)
                ("Giurassico"  146 201)
                ("Triassico"   202 252)))
  ("Paleozoico" (("Permiano"    253 299)
                 ("Carbonifero" 300 359)
                 ("Devoniano"   360 419)
                 ("Siluriano"   420 444)
                 ("Ordoviciano" 445 485)
                 ("Cambriano"   486 542)))))

(assoc "Cenozoico" periodi)
;-> ("Cenozoico" (("Quaternario" 0 3) ("Neogene" 4 23) ("Paleogene" 24 66)))

(lookup "Cenozoico" periodi)
;-> (("Quaternario" 0 3) ("Neogene" 4 23) ("Paleogene" 24 66))

Funzione che verifica se un numero x è compreso nell intervallo chiuso [a,b]:

(define (within x a b) (and (>= x a) (<= x b)))

Funzione che determina l'era dato un numero che rappresenta milioni di anni fa:

(define (era? num)
  (let (era nil)
    ; valido solo per intervalli non sovrapposti
    (dolist (el ere)
      (if (within num (el 1) (el 2)) (setq era (el 0)))
    )
    era))

(era? 344)
;-> "Paleozoico"

Funzione che determina l'era e il periodo dato un numero che rappresenta milioni di anni fa:

(define (which? num)
  (local (era periodo)
    (setq era (era? num))
    (setq lst (lookup era periodi))
    ; valido solo per intervalli non sovrapposti
    (dolist (el lst)
      (if (within num (el 1) (el 2)) (setq periodo (el 0)))
    )
    (list era periodo)))

Facciamo alcune prove:

(which? 314)
;-> ("Paleozoico" "Carbonifero")
(which? 0)
;-> ("Cenozoico" "Quaternario")
(which? 542)
;-> ("Paleozoico" "Cambriano")
(which? 100)
;-> ("Mesozoico" "Cretaceo")


--------------------------------------
Semplificazione di una radice quadrata
--------------------------------------

Dato un intero positivo n, semplificare la radice quadrata sqrt(n) nella forma a*sqrt(b) estraendo tutti i fattori quadrati. I valori di a e b dovrebbero essere numeri interi positivi con n = a^2 * b e con b il più piccolo possibile.

(define (semplifica n)
  (let (k n)
    ; cerca il quadrato
    (while (!= (% n (* k k)) 0) (-- k))
    (println k "*sqrt(" (div n k k) ")")
    (list k (div n k k))))

(map semplifica (sequence 1 20))
;-> 1*sqrt(1)
;-> 1*sqrt(2)
;-> 1*sqrt(3)
;-> 2*sqrt(1)
;-> 1*sqrt(5)
;-> 1*sqrt(6)
;-> 1*sqrt(7)
;-> 2*sqrt(2)
;-> 3*sqrt(1)
;-> 1*sqrt(10)
;-> 1*sqrt(11)
;-> 2*sqrt(3)
;-> 1*sqrt(13)
;-> 1*sqrt(14)
;-> 1*sqrt(15)
;-> 4*sqrt(1)
;-> 1*sqrt(17)
;-> 3*sqrt(2)
;-> 1*sqrt(19)
;-> 2*sqrt(5)
;-> ((1 1) (1 2) (1 3) (2 1) (1 5) (1 6) (1 7) (2 2) (3 1) (1 10) (1 11)
;->  (2 3) (1 13) (1 14) (1 15) (4 1) (1 17) (3 2) (1 19) (2 5))


-----------------
Calendario Azteco
-----------------

Lo Xiuhnelpilli era usato dagli Aztechi (più propriamente, i Mexica) per denominare i loro anni.
Ogni anno ha un numero e un segno. Ecco una parte del ciclo:

  1089 -> 13 Calli                 1116 -> 1 Tecpatl
  1090 -> 1 Tochtli                1117 -> 2 Calli
  1091 -> 2 Acatl                  1118 -> 3 Tochtli
  1092 -> 3 Tecpatl                1119 -> 4 Acatl
  1093 -> 4 Calli                  1120 -> 5 Tecpatl
  1094 -> 5 Tochtli                1121 -> 6 Calli
  1095 -> 6 Acatl                  1122 -> 7 Tochtli
  1096 -> 7 Tecpatl                1123 -> 8 Acatl
  1097 -> 8 Calli                  1124 -> 9 Tecpatl
  1098 -> 9 Tochtli                1125 -> 10 Calli
  1099 -> 10 Acatl                 1126 -> 11 Tochtli
  1100 -> 11 Tecpatl               1127 -> 12 Acatl
  1101 -> 12 Calli                 1128 -> 13 Tecpatl
  1102 -> 13 Tochtli               1129 -> 1 Calli
  1103 -> 1 Acatl                  1130 -> 2 Tochtli
  1104 -> 2 Tecpatl                1131 -> 3 Acatl
  1105 -> 3 Calli                  1132 -> 4 Tecpatl
  1106 -> 4 Tochtli                1133 -> 5 Calli
  1107 -> 5 Acatl                  1134 -> 6 Tochtli
  1108 -> 6 Tecpatl                1135 -> 7 Acatl
  1109 -> 7 Calli                  1136 -> 8 Tecpatl
  1110 -> 8 Tochtli                1137 -> 9 Calli
  1111 -> 9 Acatl                  1138 -> 10 Tochtli
  1112 -> 10 Tecpatl               1139 -> 11 Acatl
  1113 -> 11 Calli                 1140 -> 12 Tecpatl
  1114 -> 12 Tochtli               1141 -> 13 Calli
  1115 -> 13 Acatl                 1142 -> 1 Tochtli

Lo schema è il seguente: il numero conta fino a 13 e il segno è dato dalla sequenza Tochtli, Acatl, Tecpatl, Calli.
Dopo 52 anni lo schema si ripete.

Scrivere una funzione che prende un numero intero compreso tra il 1064 (l'anno in cui i Mexica lasciarono la loro patria mitologica di Aztlan) e il 1521 (caduta di Tenochtitlan da parte degli spagnoli), inclusi, e produce il nome dell'anno corrispondente.

Funzione che produce il nome dell'anno azteco dato un numero intero:

(define (aztec anno)
  (local (number name)
    (setq number (+ 1 (% (+ anno 2) 13)))
    (setq name ('("Tecpatl" "Calli" "Tochtli" "Acatl") (% anno 4)))
    (list number name)))

Oppure in maniera più breve:

(define (aztec anno)
    (list (+ 1 (% (+ anno 2) 13))
          ('("Tecpatl" "Calli" "Tochtli" "Acatl") (% anno 4))))

Facciamo alcune prove:

(map aztec (sequence 1089 1142))
;-> ((13 "Calli") (1 "Tochtli") (2 "Acatl") (3 "Tecpatl") (4 "Calli")
;->  (5 "Tochtli") (6 "Acatl") (7 "Tecpatl") (8 "Calli") (9 "Tochtli")
;->  (10 "Acatl") (11 "Tecpatl") (12 "Calli") (13 "Tochtli") (1 "Acatl")
;->  (2 "Tecpatl") (3 "Calli") (4 "Tochtli") (5 "Acatl") (6 "Tecpatl")
;->  (7 "Calli") (8 "Tochtli") (9 "Acatl") (10 "Tecpatl") (11 "Calli")
;->  (12 "Tochtli") (13 "Acatl") (1 "Tecpatl") (2 "Calli") (3 "Tochtli")
;->  (4 "Acatl") (5 "Tecpatl") (6 "Calli") (7 "Tochtli") (8 "Acatl")
;->  (9 "Tecpatl") (10 "Calli") (11 "Tochtli") (12 "Acatl") (13 "Tecpatl")
;->  (1 "Calli") (2 "Tochtli") (3 "Acatl") (4 "Tecpatl") (5 "Calli")
;->  (6 "Tochtli") (7 "Acatl") (8 "Tecpatl") (9 "Calli") (10 "Tochtli")
;->  (11 "Acatl") (12 "Tecpatl") (13 "Calli") (1 "Tochtli"))

(aztec 2023)
;-> (11 "Acatl")


------------------------------------------------
Approssimazione dei numeri decimali con frazioni
------------------------------------------------

Dato un numero decimale e un numero intero, calcolare la migliore approssimazione frazionaria (completamente semplificata) del numero decimale per tutte le frazioni fino a un denominatore del numero intero dato.
La migliore approssimazione frazionaria sarà quella più vicina al numero decimale in valore assoluto.

Esempi:
  1.21, 8 --> 6/5

  3.14159265359, 1000000 --> 3126535/995207

  19.0, 10000000 --> 19/1

  3.14159265359, 12 --> 22/7

  2.7182818, 100 --> 193/71

  0.8193927511, 22 --> 9/11

  0.2557463559, 20 --> 1/4

  0.2557463559, 100 --> 11/43

  0.0748947977, 225 --> 14/187

Algoritmo brute-force
Provare tutti i denominatori da 1 a n, salvando tutti i risultati in una lista elenco in cui ogni elemento ha la forma (errore numeratore denominatore).
Prendere l'elemento della lista con il minimo errore, il numeratore e il denominatore rappresentano la  frazione cercata.

(define (riduce val den-max)
  (local (out num err)
    (setq out '())
    (for (den 1 den-max)
      (setq num (round (mul val den)))
      (setq err (abs (sub val (div num den))))
      (push (list err num den) out -1)
    )
    ; estrae il numeratore e il denominatore
    ; dal primo elemento della lista out
    ;(slice (pop (sort out)) 1)
    ; estrae (errore numeratore denominatore)
    (pop (sort out))))

Facciamo alcune prove:

(riduce 1.21 8)
;-> (0.01 6 5)

(time (println (riduce 3.14159265359 1e6)))
;-> (1.34958710873434e-012 3126535 995207)
;-> 1334.81

(time (println (riduce 19.0 1e7)))
;-> (0 19 1)
;-> 7654.529

(riduce 3.14159265359 12)
;-> (0.001264489267142732 22 7)

(riduce 2.7182818 100)
;-> (2.805915492931632e-005 193 71)

(riduce 0.8193927511 22)
;-> (0.001210932918181751 9 11)

(riduce 0.2557463559 20)
;-> (0.0057463559 1 4)

(riduce 0.2557463559 100)
;-> (6.759758837210361e-005 11 43)

(riduce 0.0748947977 225)
;-> (2.848753957220007e-005 14 187)

Vedi anche "Decimalizzare una frazione" su "Note libere 22".


------------------
Numero fattoriale?
------------------

Dato un numero intero positivo, determinare se è un numero fattoriale.

Primo metodo: divisione

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (factorial? num)
  (local (val x)
    (setq val num)
    (setq x 2L)
    (until (= val 0)
      (setq val (/ val x))
      (++ x)
    )
    (= num (fact-i (- x 2)))))

Facciamo alcune prove:

(factorial? 1)
;-> true
(factorial? 720)
;-> true
(factorial? 1234)
;-> nil

(ref-all true (map factorial? (sequence 0 1e6)))
;-> ((1) (2) (6) (24) (120) (720) (5040) (40320) (362880))

Secondo metodo: moltiplicazione

(define (fact? num)
  (let ( (val 1) (idx 1) (stop nil) )
    (until stop
      (cond ((= val num) (setq stop true) true)
            ((> val num) (setq stop true) nil)
            (true (++ idx) (setq val (* val idx)))))))

Facciamo alcune prove:

(fact? 1)
;-> true
(fact? 720)
;-> true
(fact? 1234)
;-> nil

(ref-all true (map fact? (sequence 0 1e6)))
;-> ((1) (2) (6) (24) (120) (720) (5040) (40320) (362880))


----------------------------
Funzioni iperboliche inverse
----------------------------

sinh-1: Seno iperbolico inverso

  sinh-1 = ln(x + sqrt(x^2 + 1))

cosh-1: Coseno iperbolico inverso (definita solo per x>=1)

  cosh-1 = ln(x + sqrt(x^2 - 1))

tanh-1: Tangente iperbolica inversa (definita solo per -1<x<1)

                     1 + x
  tanh-1 = (1/2)*ln(-------)
                     1 - x

Vedi immagine "iperboliche-inverse.png" nella cartella "data".

(define (sinh-1 x)
  (log (add x (sqrt (add (mul x x) 1)))))

(define (cosh-1 x)
  (log (add x (sqrt (sub (mul x x) 1)))))

(define (tanh-1 x)
  (mul 0.5 (log (div (add 1 x) (sub 1 x)))))

Facciamo alcune prove:

(sinh-1 0)
;-> 0
(cosh-1 1)
;-> 0
(sinh-1 5)
;-> 2.312438341272753
(cosh-1 5)
;-> 2.292431669561178
(tanh-1 0.5)
;-> 0.5493061443340549

(cosh-1 0)
;-> 1.#QNAN
(cosh-1 -1)
;-> 1.#QNAN
(tanh-1 1.5)
;-> 1.#QNAN


--------------
Carta igienica
--------------

I valori numerici di un rotolo di carta igienica sono tre numeri interi I, R e G.
  I è il raggio dell'anello interno,
  R è il numero di rotazioni,
  G è lo spessore.
Calcolare la lunghezza di tutta la carta igienica.

La carta igienica può essere vista come una spirale di Archimede, che inizia alle coordinate (I,x), e ruota un totale di R volte in senso antiorario, con una distanza di G per ogni giro.
In altre parole, la spirale di Archimede qui è definita come l'insieme di tutti i punti le cui posizioni nel tempo si allontanano dall'origine in senso antiorario a velocità costante e con velocità angolare costante.

Esempio (vedi immagine "carta-igienica.png" nella cartella "data"):
con I=5, R=3 e G=4 si ha una lunghezza L = 207.73

La formula per la lunghezza L del rotolo è la seguente:

                     2π(I+GR)/G
  L = (G/2π)*integral[sqrt(1 + x^2)]dx
                     2πI/G

  dove integral[sqrt(1 + x^2)]dx = (1/2)*(x*sqrt(1 + x^2) + sinh-1(x))

Funzione soluzione dell'integrale:

(define (f x)
  (mul 0.5 (add (mul x (sqrt (add 1 (mul x x)))) (sinh-1 x))))

Funzione seno iperbolico inverso:

(define (sinh-1 x)
  (log (add x (sqrt (add (mul x x) 1)))))

Valore di pi greco:

(setq pi 3.1415926535897931)

(define (carta I R G)
  (setq a (div (mul 2 pi I) G))
  (setq b (div (mul 2 pi (add I (mul G R))) G))
  (setq fa (f a))
  (setq fb (f b))
  (mul (div G (mul 2 pi)) (sub fb fa)))

Facciamo alcune prove:

(carta 0 1 1)
;-> 3.383041769062701
(carta 5 3 4)
;-> 207.7338934908665
(carta 12 9 2)
;-> 1187.666840566463


---------------------------------------
Riflessione e inversione di una stringa
---------------------------------------

Data una stringa ASCII rifletterla e invertirla.
Per fare questo:
a) Sostituire qualsiasi occorrenza dei caratteri (, ), /, \, <, >, [, ], { o } nella stringa con il corrispondente carattere "speculare": ), (, \, /, >, <, ], [, }, e {.}
b) Invertire la stringa ottenuta nel passo a).

(define (mir-rev str)
  (local (tmp ch)
    (setq tmp str)
    (for (i 0 (- (length str) 1))
      (setq ch (str i))
      (cond ((= ch "(") (setf (tmp i) ")"))
            ((= ch ")") (setf (tmp i) "("))
            ((= ch "/") (setf (tmp i) (char 92)))
            ((= ch "\\") (setf (tmp i) "/"))
            ((= ch ">") (setf (tmp i) "<"))
            ((= ch "<") (setf (tmp i) ">"))
            ((= ch "[") (setf (tmp i) "]"))
            ((= ch "]") (setf (tmp i) "["))
            ((= ch "{") (setf (tmp i) "}"))
            ((= ch "}") (setf (tmp i) "{"))
            (true (setf (tmp i) ch))
      )
    )
    ;(println tmp)
    (println (reverse tmp))))

Facciamo alcune prove:

(mir-rev "(s)t/r\i<n>g[i]e{s}")
;-> {s}e[i]g<n>ir\t(s)
;-> "{s}e[i]g<n>ir\\t(s)"

(mir-rev "(a + b)*[(a - b)*(c -d)]")
;-> [(d- c)*(b - a)]*(b + a)
;-> "[(d- c)*(b - a)]*(b + a)"
(mir-rev "])d[(d- c)*(b - a)]*(b + a)")
;-> (a + b)*[(a - b)*(c -d)]d([
;-> "(a + b)*[(a - b)*(c -d)]d(["

(mir-rev "(newlisp)")
;-> (psilwen)
;-> "(psilwen)"


------------------
Vicino al quadrato
------------------

Dato un intero positivo c, restituire due numeri interi a e b dove a * b = c e ciascun a e b è il più vicino a sqrt(c).

(define (factor-group num)
  (if (= num 1) '((1 1))
    (letn (fattori (factor num)
          unici (unique fattori))
      (transpose (list unici (count unici fattori))))))

(define (divisors num)
"Generate all the divisors of an integer number"
  (local (f out)
    (cond ((= num 1) '(1))
          (true
           (setq f (factor-group num))
           (setq out '())
           (divisors-aux 0 1)
           (sort out)))))
; auxiliary function
(define (divisors-aux cur-index cur-divisor)
  (cond ((= cur-index (length f))
         (push cur-divisor out -1)
        )
        (true
         (for (i 0 (f cur-index 1))
           (divisors-aux (+ cur-index 1) cur-divisor)
           (setq cur-divisor (* cur-divisor (f cur-index 0)))
         ))))

Il numero di divisori di un numero quadrato è dispari:
(for (i 2 20) (print (length (divisors (* i i))) { }))
;-> 3 3 5 3 9 3 7 5 9 3 15 3 9 9 9 3 15 3 15 " "

Il valore centrale della lista dei divisori diun numero quadrato è la radice quadrata del numero:
(divisors 144)
;-> (1 2 3 4 6 8 9 12 16 18 24 36 48 72 144)
Il valore centrale vale 12: 12*12 = 144

Se il numero non è un quadrato, allora i valori di a e b sono i due valori centrali:
(divisors 136)
;-> (1 2 4 8 17 34 68 136)
I valori centrali sono 8 e 17.

Funzione che calcola i valori di a e b:

(define (closest c)
  (local (lst len)
    (setq lst (divisors c))
    (setq len (length lst))
    (cond ((odd? len) (setq a (lst (/ len 2))) (setq b a))
          ((even? len) (setq a (lst (- (/ len 2) 1))) (setq b (lst (/ len 2))))
    )
    (list a b)))

Facciamo alcune prove:

(closest 144)
;-> (12 12)
(closest 136)
;-> (8 17)
(closest 41)
;-> (1 41)
(closest 189)
;-> (9 21)

Nota: il primo numero (a) rappresenta la sequenza OEIS A033676,
      il secondo numero (b) rappresenta la sequenza OEIS A033677.


------------------------
Zundoko Kiyoshi function
------------------------

Scrivere una funzione senza alcun input che produce il seguente comportamento:

- stampa ripetutamente "zun" o "doko", scegliendo ogni volta in modo uniforme e casuale.
- se la sequenza ("zun", "zun", "zun", "zun", "doko") appare nell'output, allora stampa "ki-yo-shi!" e si ferma.

Prima versione:

(define (zundoko)
  (local (five stop tipo)
    (setq five '())
    (setq stop nil)
    (until stop
      (setq tipo (rand 2))
      ; stampa "zun" o "doko"
      ; e inserisce 0 o 1 nella lista five
      (cond ((= tipo 0)
              (println "zun") (push 0 five -1))
            (true
              (println "doko") (push 1 five -1))
      )
      ; se la lista contiene 5 elementi
      (cond ((= (length five) 5)
              ; verifica ultimi 5 risultati
              (if (= five '(0 0 0 0 1))
                (begin
                  (println "ki-yo-shi!")
                  (setq stop true))
                )
                ;else
                ; togliere il primo elemento dalla lista
                ; (ne rimangono 4)
                (pop five))
      )
      ;(print five) (read-line)
    ))

(zundoko)
;-> doko
;-> doko
;-> zun
;-> zun
;-> doko
;-> ...
;-> zun
;-> doko
;-> doko
;-> doko
;-> doko
;-> doko
;-> zun
;-> zun
;-> zun
;-> zun
;-> doko
;-> ki-yo-shi!

Seconda versione:

(define (zundoko2)
(local (five tipo stop)
  (setq five '())
  ; inserisce i primi 4 elementi
  (for (i 1 4)
    (setq tipo (rand 2))
    ; stampa "zun" o "doko"
    ; e inserisce 0 o 1 nella lista five
    (cond ((= tipo 0)
            (println "zun") (push 0 five -1))
          (true
            (println "doko") (push 1 five -1))
    )
  )
  (setq stop nil)
  (until stop
    (setq tipo (rand 2))
    ; stampa "zun" o "doko"
    ; e inserisce 0 o 1 nella lista five
    (cond ((= tipo 0)
            (println "zun") (push 0 five -1))
          (true
            (println "doko") (push 1 five -1))
    )
    ; verifica lista five (che contiene 5 elementi)
    (if (= five '(0 0 0 0 1))
      (begin
        (println "ki-yo-shi!")
        (setq stop true)
      )
      ;else
      ; togliere il primo elemento dalla lista
      ; (ne rimangono 4)
      (pop five)
    )
    ;(print five) (read-line)
  ))

(zundoko2)
;-> zun
;-> zun
;-> doko
;-> zun
;-> doko
;-> doko
;-> doko
;-> doko
;-> zun
;-> doko
;-> zun
;-> zun
;-> doko
;-> doko
;-> doko
;-> doko
;-> zun
;-> doko
;-> doko
;-> zun
;-> zun
;-> doko
;-> zun
;-> zun
;-> doko
;-> doko
;-> doko
;-> zun
;-> zun
;-> zun
;-> zun
;-> doko
;-> ki-yo-shi!


----------------------------------
Metodo per memorizzare le password
----------------------------------

Una password è caratterizzata da:
Lunghezza: consigliabile usare da 8 a 15 caratteri
Caratteri usati:
  Numeri (0-9) = 10
  Lettere = 52 (26 minuscole + 26 maiuscole)
  Caratteri speciali (per es. " :&%?^|" ecc.) = 33
Totale caratteri: 95

"The only secure password is the one you can't remember" Troy Hunt.

Assegniamo un numero ad ogni sito web e usiamo una funzione matematica per generare la password:

Indirizzo Web    Numero   Stringa  Funzione(tan(x)^2)    Password
chess.com        1        uNo_     2.42551882081476      uNo_42551882
github.com       2        dUe_     4.774399204041917     dUe_77439920
netflix.com      3        tRe_     0.02031951694242694   tRe_02031951

(define (pwd num) (format "%.8f" (pow (tan num) 2)))

(pwd 1)
;-> "2.42551882"
(pwd 2)
;-> "4.77439920"
(pwd 3)
;-> "0.02031951"


--------------------------------------------------------------
Conversione numero decimale frazionario in binario frazionario
--------------------------------------------------------------

Dato un numero decimale frazionario n e un intero k, convertire il numero decimale n in un numero binario equivalente con precisione fino a k dopo la virgola decimale.

Esempi:

Input: n = 2,47, k = 5
Output: 10.01111

Input: n = 6,986 k = 8
Output: 110.11111100

A) Convertire la parte intera del numero nell'equivalente binario
1. Dividere il numero decimale per 2 e memorizzare il resto in una lista.
2. Dividire il quoziente per 2.
3. Ripetere il passaggio 2 finché nonsi ottiene il quoziente pari a zero.
4. Il numero binario equivalente è l'inverso di tutti i resti della lista.

B) Convertire la parte decimale (frazionaria) del numero nell'equivalente binario
1. Moltiplicare il numero decimale frazionario per 2.
2. La parte intera del numero risultante sarà la prima cifra del numero binario della frazione.
3. Ripetere il passaggio 1 utilizzando solo la parte decimale (frazionaria) del numero e quindi il passaggio 2.

C) Combinare la parte intera con quella decimale del numero binario.

Illustrazione :

Facciamo un esempio per n = 4.47 k = 3

Passaggio 1: conversione di 4 in binario
1. 4/2 : Resto = 0 : Quoziente = 2
2. 2/2 : Resto = 0 : Quoziente = 1
3. 1/2 : Resto = 1 : Quoziente = 0

Quindi il binario equivalente della parte intera del numero è 100.

Passaggio 2: conversione di .47 in binario
1. 0.47 * 2 = 0.94, Parte integrale: 0
2. 0.94 * 2 = 1.88, Parte integrale: 1
3. 0.88 * 2 = 1.76, Parte integrale: 1

Quindi il binario equivalente della parte decimale (frazionaria) del numero del decimale è .011

Passaggio 3: combinare il risultato dei passaggi 1 e 2.

La risposta finale vale: 100 + 0.011 = 100.011

(define (frac-bin num k)
  (local (binary intera decimale resto dec-bit)
    (setq binary "")
    ; parte intera del numero
    (setq intera (int num))
    ; parte decimale del numero
    (setq decimale (sub num intera))
    ; conversione parte intera in binario
    (while (> intera 0)
      (setq resto (% intera 2))
      (extend binary (string resto))
      (setq intera (/ intera 2))
    )
    (reverse binary)
    (if (zero? (length binary))
        (extend binary "0.")
        (extend binary ".")
    )
    ; conversione parte decimale (frazionaria) in binario
    (while (> k 0)
      (setq decimale (mul decimale 2))
      (setq dec-bit (int decimale))
      (cond ((= dec-bit 1)
            (setq decimale (sub decimale dec-bit))
            (extend binary "1"))
            (true (extend binary "0"))
      )
      (-- k)
    )
    binary))

Facciamo alcune prove:

(frac-bin 4.47 3)
;-> "100.011"

(frac-bin 4.47 8)
;-> "100.01111000"

(frac-bin 4.47 25)
;-> "100.0111100001010001111010111"

(frac-bin 6.986 5)
;-> "110.11111"

(frac-bin 6.986 15)
;-> "110.111111000110101"

(frac-bin (div 1 3) 10)
;-> "0.0101010101"


--------------------------------------------------------------
Conversione binario frazionario in numero decimale frazionario
--------------------------------------------------------------

Data una stringa di un numero binario frazionario, convertire il numero binario nel suo equivalente decimale.

Esempi:

Input: n = 110.101
Output: 6.625

Input: n = 101.1101
Output: 5.8125

A) Convertire la parte intera del binario nell'equivalente decimale
1) Moltiplica ciascuna cifra separatamente dal lato sinistro del punto della radice fino alla prima cifra rispettivamente per 2^0, 2^1, 2^2,....
2) Aggiungi tutto il risultato proveniente dal passaggio 1.
Il numero decimale intero equivalente è sarebbe il risultato ottenuto nel passaggio 2.

B) Convertire la parte frazionaria del binario nell'equivalente decimale
1) Dividere ciascuna cifra dal lato destro del punto fino alla fine rispettivamente per 2^1, 2^2, 2^3, ....
2) Aggiungere tutto il risultato proveniente dal passaggio 1.
Il numero decimale frazionario equivalente sarebbe il risultato ottenuto nel passaggio 2.

C) Combinare la parte intera con quella frazionaria del numero decimale.

(define (bin-frac binary)
  (setq len (length binary))
  (setq punto (or (find "." binary) len))
  (setq int-dec 0)
  (setq frac-dec 0)
  (setq due 1)
  ; conversione parte intera del binario in decimale
  (for (i (- punto 1) 0 -1)
    (setq int-dec (+ int-dec (* (int (binary i)) due)))
    (setq due (* due 2))
  )
  ; conversione parte frazionaria del binario in decimale
  (setq due 2)
  (for (i (+ punto 1) (- len 1))
    (setq frac-dec (add frac-dec (div (int (binary i)) due)))
    (setq due (* due 2))
  )
  (add int-dec frac-dec))

Facciamo alcune prove:

(bin-frac "110.101")
;-> 6.625

(bin-frac "101.1101")
;-> 5.8125

(bin-frac "100.011")
;-> 4.375

(bin-frac "100.01111000")
;-> 4.46875

(bin-frac  "100.0111100001010001111010111")
;-> 4.469999998807907

(bin-frac  "110.11111")
;-> 6.96875

(bin-frac "110.111111000110101")
;-> 6.985992431640625

(bin-frac "0.0101010101")
;-> 0.3330078125


-----------------------------
Ordinamento per tipo e valore
-----------------------------

Data una lista che può contenere interi, float e stringhe, ordinarla nel modo seguente:

1) Prima le stringhe ordinate in modo crescente
2) Poi gli interi ordinati in modo crescente
3) Infine i float ordinati in modo crescente

Il "sort" di newLISp ordina nel modo seguente:

(setq lst '(6 "abc" 3.1415 "zippo" 7 4 2 2.42 21.21 77))
(sort lst)
;-> (2 2.42 3.1415 4 6 7 21.21 77 "abc" "zippo")

Ordina anche eventuali simboli:

(setq lst '(6 "abc" 3.1415 "zippo" a z 7 4 2 2.42 21.21 77))
(sort lst)
;-> (2 2.42 3.1415 4 6 7 21.21 77 "abc" "zippo" a z)

Funzione che ordina una lista in base ai tipi e ai valori degli elementi:

(define (type-sort lst)
  (extend
    (sort (filter string? lst))
    (sort (filter integer? lst))
    (sort (filter float? lst))
    (sort (filter symbol? lst))))

(type-sort lst)
;-> ("abc" "zippo" 2 4 6 7 77 2.42 3.1415 21.21 a z)


----------------
Stringhe lineari
----------------

Data una stringa costituita solo da caratteri minuscoli, stabilire se è lineare.
Una stringa viene definita "lineare" se i suoi caratteri sono ordinati in modo crescente o in modo decrescente rispetto all'alfabeto ("abcdefghijklmnopqrstuvwxyz").

Esempi:
"amor" è una parola lineare perchè a <= m <= o <= r.
"zucca"  è una parola lineare perchè z>= u >= c >= c >= a.
"new" non è lineare perchè n >= e <= w.

(define (linear? str)
  (or (apply >= (explode str))
      (apply <= (explode str))))

Facciamo alcune prove:

(linear? "amor")
;-> true
(linear? "zucca")
;-> true
(linear? "new")
;-> nil
(linear? "newlisp")
;-> nil

Se una stringa non è lineare, quanto è "non lineare"?
Cioè quante volte i caratteri cambiano ordine rispetto l'alfabeto?

Esempio:
(setq s "newlisp")
(map char (explode s))
;-> (110 101 119 108 105 115 112)

110 e 101 --> decrescente (ordine iniziale)
101 e 119 --> crescente (change)
119 e 108 --> decrescente (change)
108 e 105 --> decrescente
105 e 115 --> crescente (change)
115 e 111 --> decrescente (change)

La seguente funzione restituisce il numero di volte che i caratteri cambiano ordine (decrescente o crescente). Il valore 0 indica che la stringa è lineare.

(define (linear str)
  (local (len change s1 s2 order)
    (setq len (length str))
    (setq change 0)
    (setq s1 (str 0))
    (setq s2 (str 1))
    (cond ((> s1 s2) (setq order "-"))
          ((< s1 s2) (setq order "+"))
          ((= s1 s2) (setq order "="))
    )
    ;(println s1 { } s2)
    ;(println "starting order: " order)
    (for (i 2 (- len 1))
      ;(println "current char: " (str i))
      (cond ((and (= order "+") (< (str i) (str (- i 1))))
              ;(println order { } (str i) { } (str (- i 1)))
              (++ change)
              ;(println "change: " change)
              (setq order "-"))
            ((and (= order "-") (> (str i) (str (- i 1))))
              ;(println order { } (str i) { } (str (- i 1)))
              (++ change)
              ;(println "change: " change)
              (setq order "+"))
            ((= order "=")
              (if (> (str i) (str (- i 1)))
                    (setq order "+")
                  (< (str i) (str (- i 1)))
                    (setq order "-")
              ))
      )
      ;(read-line)
    )
    change))

Facciamo alcune prove:

(linear "amor")
;-> 0
(linear "zucca")
;-> 0
(linear "newlisp")
;-> 4
(linear "zabc")
;-> 1
(linear "aaaaaaaa")
;-> 0
(linear "baaaaaaa")
;-> 0
(linear "aabbccbb")
;-> 1
(linear "zzccbbaabb")
;-> 1
(linear "zzzyyy")
;-> 0
(linear "zzzyyyaaddcc")
;-> 2


----------------------------------------------------
Determinare se un numero è minore/uguale di un altro
----------------------------------------------------

Scrivere una funzione che restituisce true solo se un numero a è inferiore ad un numero b.
Scrivere una funzione che restituisce true solo se un numero a è inferiore o uguale ad un numero b.
Non è consentito utilizzare i seguenti operatori:
- maggiore ">"
- minore "<"
- maggiore/uguale ">="
- minore/uguale "<="
- le primitive equivalenti di uguaglianza e comparazione del linguaggio (es. "eq", "equal", "greater" ecc.)

Esempi:

  a  b  | Output (minore) | Output (minore o uguale)
  ------|-----------------|-------------------------
  1, 3  | true            | true
  2, 2  | nil             | true
  3, 2  | nil             | nil

Ecco una soluzione:

(define (less-equal? a b) (zero? (max 0 (- a b))))

(define (less? a b) (not (zero? (max 0 (- b a)))))

(less? 1 3)
;-> true
(less-equal? 1 3)
;-> true
(less? 2 2)
;-> nil
(less-equal? 2 2)
;-> true
(less? 3 2)
;-> nil
(less-equal? 3 2)
;-> nil


-----------------
Semplice Profiler
-----------------

Per analizzare il tempo di esecuzione di parti di una funzione possiamo utilizzare la funzione "time".

Per esempio:

(define (test a b c iter)
  ; sezione 1 da profilare
  (setq t1 (time
    (for (i 1 iter) (setq d (mul a b c)))
  ))
  ; sezione 2 da profilare
  (setq t2 (time
    (for (i 1 iter) (setq d (add a b c)) (setq d (mul a b c)))
  ))
  (list t1 t2))

(test 123.123 456.456 789.789 10000000)
;-> (432.454 787.3)

In generale possiamo usare il seguente pattern (modello):

(define (func x y)
  (local (t1 t2 tn result)
    (setq t1 (time
      ; body of section 1
    ))
    (println "Section 1 time: " t1)
    (setq t2 (time
      ; body of section 2
    ))
    (println "Section 2 time: " t2)
    ; Other sections
    ; ...
    ; ...
    ; ...
    (setq tn (time
      ; body of section n
    ))
    (println "Section n time: " tn)
    ;(setq result )
    ; return values
    (list result t1 t2 tn)

Vedi anche:
 "Tempo di esecuzione" in "newLISP in generale",
 "Analisi dei tempi di esecuzione delle funzioni" in "newLISP in generale",
 "Profiler casalingo" in "Note libere 14".


-------------------------------------
Distanza tra due punti N-dimensionali
-------------------------------------

Funzione che calcola la distanza cartesiana di due punti N dimensionali: P1=(x1 y1 ... z1) e P2=(x2 y2 ... z2):

(define (dist-points p1 p2)
"Calculates Cartesian distance of two points N dimensional: P1=(x1 y1 ... z1) e P2=(x2 y2 ... z2)"
  (sqrt (apply add (map (fn(x) (mul x x)) (map sub p1 p2)))))

(dist-points '(-4 -5 -6 -7) '(1 2 3 4))
;-> 16.61324772583615


-----------------------------
Distanza euclidea tra matrici
-----------------------------

Date due matrici restituire la matrice delle distanze euclidee.
La distanza euclidea tra due punti nello stesso sistema di coordinate può essere descritta dalla seguente equazione:

  D = sqrt((x2-x1)^2 + (y2-y1)^2 + ... + (z2-z1)^2)

La matrice della distanza euclidea è la matrice che contiene la distanza euclidea tra ciascun punto di entrambe le matrici.

Esempio:

Matrice 3x3:

      |  1  2  3|
  a = | -4 -5 -6|
      |  7  8  9|

Matrice 1x3 (vettore):

  b = |1 2 3|

Matrice 3x1:

Distanza-Euclidea(a, b) = |0.0  12.4499 10.3923|

Ogni riga della matrice rappresenta un punto (la cui dimensione è data dal numero delle colonne della matrice).

Esempio:

Matrice 3x4:

      | 1  2  3  4|
  a = |-4 -5 -6 -7|
      | 6  7  8  9|

Matrice 2x4:

  b =  |1 2 3 4|
       |1 1 1 1|

Matrice 3x2:

                            | 0.0     3.74166|
  Distanza-Euclidea(a, b) = |16.6132 13.1909 |
                            |10.0    13.1909 |

Per ogni punto (riga) della prima matrice si calcola la distanza con ogni altro punto (riga) della seconda matrice.
La matrice risultante ha dimensione (righe prima matrice)x(righe seconda matrice).

  distanza (1 2 3 4) (1 2 3 4) = 0
  distanza (1 2 3 4) (1 1 1 1) = 3.741657386773941
  distanza (-4 -5 -6 -7) (1 2 3 4) = 16.61324772583615
  ...

Funzione che calcola la distanza cartesiana di due punti N dimensionali: P1=(x1 y1 ... z1) e P2=(x2 y2 ... z2):

(define (dist-points p1 p2)
"Calculates Cartesian distance of two points N dimensional: P1=(x1 y1 ... z1) e P2=(x2 y2 ... z2)"
  (sqrt (apply add (map (fn(x) (mul x x)) (map sub p1 p2)))))

(dist-points '(-4 -5 -6 -7) '(1 2 3 4))
;-> 16.61324772583615

Funzione che calcola la distanza euclidea tra matrici:

(define (mat-dist m1 m2)
  (local (out row1 row2)
    (setq out '())
    (setq row1 (length m1))
    (setq row2 (length m2))
    (for (r1 0 (- row1 1))
      (for (r2 0 (- row2 1))
        (push (dist-points (m1 r1) (m2 r2)) out -1)
      )
    )
    (explode out row2)))

Facciamo alcune prove:

Matrice 3x4:

(setq mat1 '((1 2 3 4)
             (-4 -5 -6 -7);
             (6 7 8 9)))

Matrice 2x4:

(setq mat2 '((1 2 3 4)
             (1 1 1 1)))

Matrice 3x2:

(mat-dist mat1 mat2)
;-> ((0 3.741657386773941)
;->  (16.61324772583615 13.19090595827292)
;->  (10 13.19090595827292))

Matrice 2x2:

(setq mat1 '((1  2)
           (3.3 4.4)))

Matrice 3x2:

(setq mat2 '((5.5 6.6)
             (7  8)
             (9.9 10.1)))

Matrice 2x3:

(mat-dist mat1 mat2)
;-> ((6.435060217278467 8.48528137423857 12.03411816461846)
;->  (3.111269837220809 5.162363799656123 8.720665112249181))


------------------------------------
Gesture based lock-screen on Android
------------------------------------

Uno dei metodi per sbloccare i cellulari con S.O. Android è quello di disegnare un segno (pattern) seguendo i punti di una matrice 3x3.

Matrice di punti 3x3:

    *    *    *

    *    *    *

    *    *    *

Esempio di segno (pattern):

     -->                   -->
    *----*----*           1----2----3
              |                     |
    *    *    *           4    5    6        1-2-3-6-9-8
              |                     |
    *    *----*           7    8----9

Quanti sono i segni (pattern) che possiamo tracciare?

Se il segno utilizza tutti i punti una sola volta, allora il risultato è il fattoriale di 9:

  9! = 362880

Comunque ci sono alcune regole da rispettare quando si compone un segno:

1) Un minimo di quattro punti devono essere connessi
2) Ogni punto può essere usato solo una volta (ma possono essere attraversati più volte)
3) Un punto intermedio sul percorso del segno deve essere incluso nel pattern finale, a meno che non sia già stato usato.

Esempio (il 4 non viene riutilizzato quando passiamo da 1 a 7):

  1----2----3
  |-->      |
  4----5----6        4-5-6-3-2-1-7-8
  |
  7----8    9

Le soluzioni sono le seguenti:

  +-------+---------+
  | Punti | Pattern |
  +-------+---------+
  |   4   |   1624  |
  |   5   |   7152  |
  |   6   |  26016  |
  |   7   |  72912  |
  |   8   | 140704  |
  |   9   | 140704  |
  +-------+---------+
            389112

Somma di tutti i pattern:
(+ 1624 7152 26016 72912 140704 140704)
;-> 389112

Somma dei pattern da 5 a 7:
(+ 7152 26016 72912)
;-> 106080

Per risolvere il problema usiamo la ricorsione per creare un algoritmo di ricerca DFS (Depth First Search) che viene eseguito per ogni punto di partenza.
Possiamo ottimizzare il metodo notando che alcuni punti di partenza sono simmetrici:
- i punti 1, 3, 7 e 9 sono simmetrici e forniscono lo stesso risultato
- i punti 2, 4, 6 e 8 sono simmetrici e forniscono lo stesso risultato
Per considerare i patterni invalidi (cioè per codificare le regole 2 e 3) usiamo una matrice jump che contiene le possibili celle intermedie di salto.
Per ignorare le mosse non valide, la funzione di ricerca ricorsiva non viene chiamata se lo spostamento da un punto ad un'altro coinvolge qualche punto intermedio che non è stato già visitato.

(define (patterns-from-cur cur to-visit)
  (cond
    ; ultimo punto? restituisce 1 modo
    ((zero? to-visit) 1)
    ; nessun punto ulteriore? restituisce 0 modi
    ((< to-visit 0) 0)
    (true
      (setq ways 0)
      ; imposta il punto corrente come visitato
      (setf (visited cur) 1)
      (for (i 1 9)
        ; se questo punto non è stato visitato (usato)
        ; AND
        ;    i e cur sono adiacenti
        ;    (cioè (jump i cur) vale 0)
        ;    OR
        ;    i punti intermedi devono essere già stati visitati
        ;    (cioè (visited (jump cur i)) vale 1)
        (if (and (zero? (visited i))
                (or (zero? (jump i cur)) (= (visited (jump i cur)) 1)))
            (setq ways (+ ways (patterns-from-cur i (- to-visit 1))))
        )
      )
      ; imposta il punto corrente come non visitato
      ; dopo il ritorno della funzione chiamata
      (setf (visited cur) 0)
      ways)))

(define (unlock-ways m n)
  (local (ways totways jump visited)
    ; matrice dei salti
    (setq jump (array 10 10 '(0)))
    ; lista dei punti visitati
    (setq visited (array 10 '(0)))
    ; 2 si trova tra 1 e 3
    (setf (jump 1 3) 2)
    (setf (jump 3 1) 2)
    ; 8 si trova tra 7 e 9
    (setf (jump 7 9) 8)
    (setf (jump 9 7) 8)
    ; 4 si trova tra 1 e 7
    (setf (jump 1 7) 4)
    (setf (jump 7 1) 4)
    ; 6 si trova tra 3 e 9
    (setf (jump 3 9) 6)
    (setf (jump 9 3) 6)
    ; 5 si trova tra 1 e 9
    (setf (jump 1 9) 5)
    (setf (jump 9 1) 5)
    ; 5 si trova tra 2 e 8
    (setf (jump 2 8) 5)
    (setf (jump 8 2) 5)
    ; 5 si trova tra 3 e 7
    (setf (jump 3 7) 5)
    (setf (jump 7 3) 5)
    ; 5 si trova tra 4 e 6
    (setf (jump 4 6) 5)
    (setf (jump 6 4) 5)
    (setq totways 0)
    (for (i m n)
      ; moltiplica per 4 perchè 1, 3, 7, 9 sono simmetrici
      (setq totways (+ totways (* 4 (patterns-from-cur 1 (- i 1)))))
      ; moltiplica per 4 perchè 2, 4, 6, 8 sono simmetrici
      (setq totways (+ totways (* 4 (patterns-from-cur 2 (- i 1)))))
      ; 5 non ha simmetrici
      (setq totways (+ totways (patterns-from-cur 5 (- i 1))))
    )
    totways))

Facciamo alcune prove:

(unlock-ways 1 1)
;-> 9
(unlock-ways 2 2)
;-> 56
(unlock-ways 1 2)
;-> 65
(unlock-ways 4 6)
;-> 34792
(unlock-ways 5 7)
;-> 106080
(unlock-ways 8 8)
;-> 140704
(unlock-ways 9 9)
;-> 140704
(unlock-ways 4 9)
;-> 389112

Nota: questo metodo per bloccare il cellulare non è molto sicuro...

"Cracking Android Pattern Lock in Five Attempts" by
Guixin Ye, Zhanyong Tang, Dingyi Fangy, Xiaojiang Chen, Kwang In Kim, Ben Taylor, and Zheng Wang

Abstract
Pattern lock is widely used as a mechanism for authentication and authorization on Android devices.
In this paper, we demonstrate a novel video-based attack to reconstruct Android lock patterns from video footage filmed using a mobile phone camera.
Unlike prior attacks on pattern lock, our approach does not require the video to capture any content displayed on the screen.
Instead, we employ a computer vision algorithm to track the fingertip movements to infer the pattern.
Using the geometry information extracted from the tracked fingertip motions, our approach is able to accurately identify a small number of (often one) candidate patterns to be tested by an adversary.
We thoroughly evaluated our approach using 120 unique patterns collected from 215 independent users, by applying it to reconstruct patterns from video footage filmed using smartphone cameras.
Experimental results show that our approach can break over 95% of the patterns in five attempts before the device is automatically locked by the Android system.
We discovered that, in contrast to many people's belief, complex patterns do not offer stronger protection under our attacking scenarios.
This is demonstrated by the fact that we are able to break all but one complex patterns (with a 97.5% success rate) as opposed to 60% of the simple patterns in the first attempt.
Since our threat model is common in day-to-day lives, our works calls for the community to revisit the risks of using Android pattern lock to protect sensitive information.


-------------------------------------------------
Paradosso Maschio o Femmina (Boy or Girl Paradox)
-------------------------------------------------

Problema 1
----------
Maria e Pietro hanno due figli.
Almeno uno dei due figli è un maschio.
Supponiamo che la probabilità di ciascun genere sia 1/2.

Qual è la probabilità che anche l'altro figlio sia maschio?

Soluzione
---------
Elenchiamo le varie combinazioni di due figli:

  1.  Maschio - Femmina
  2.  Maschio - Maschio
  3.  Femmina - Femmina (non possibile)
  4.  Femmina - Maschio

Poichè un figlio è maschio, allora la combinazione 3 non è possibile.

La probabilità cercata vale:

                casi favorevoli
  P(maschio) = -----------------
                casi possibili

  Casi possibili = 3, (1 2 4)

  Casi favorevoli = 1, (2)

                1
  P(maschio) = --- = 1/3 = 0.333333333....
                3

Problema 2
----------
Maria e Pietro hanno due figli.
Il figlio più vecchio è una femmina.
Supponiamo che la probabilità di ciascun genere sia 1/2.

Qual è la probabilità che anche l'altro figlio sia femmina?

Elenchiamo le varie combinazioni di due figli:

      Vecchio   Giovane
      -------   -------
  1.  Maschio - Femmina (non possibile)
  2.  Maschio - Maschio (non possibile)
  3.  Femmina - Femmina
  4.  Femmina - Maschio

Poichè femmina è più vecchia le combinazione 1 e 2 non sono possibili.

La probabilità cercata vale:

                casi favorevoli
  P(femmina) = -----------------
                casi possibili

  Casi possibili = 2, (3 4)

  Casi favorevoli = 1, (3)

                1
  P(femmina) = --- = 1/2 = 0.5
                2

Funzioni di simulazione
-----------------------

Problema 1:
Maria e Pietro hanno due figli.
Almeno uno dei due figli è un maschio.
Qual è la probabilità che anche l'altro figlio sia maschio?

(define (p1 iter)
  ; M = "0", F = "1"
  (setq genere '("M" "F"))
  (setq ok 0)
  (for (i 1 iter)
    ; generazione coppia di figli scartando la configurazione ("F" "F")
    (until (not (= (setq coppia (list (genere (rand 2)) (genere (rand 2)))) '("F" "F"))))
    ; controllo casi favorevoli
    (if (= coppia '("M" "M")) (++ ok))
  )
  ; calcolo percentuale
  (div ok iter))

Verifichiamo il risultato:

(p1 1e6)
;-> 0.333567
(p1 1e7)
;-> 0.3332742

Problema2:
Maria e Pietro hanno due figli.
Il figlio più vecchio è una femmina.
Supponiamo che la probabilità di ciascun genere sia 1/2.

Qual è la probabilità che anche l'altro figlio sia femmina?

(define (p2 iter)
  ; M = "0", F = "1"
  (setq genere '("M" "F"))
  (setq ok 0)
  (for (i 1 iter)
    ; generazione coppia di figli in cui la prima è una femmina
    ; ("F" "F") oppure ("F" "M")
    (setq coppia (list (genere (rand 2)) (genere (rand 2))))
    (until (or (= coppia '("F" "F")) (= coppia '("F" "M")))
      (setq coppia (list (genere (rand 2)) (genere (rand 2))))
    )
    ; controllo casi favorevoli
    (if (= coppia '("F" "F")) (++ ok))
  )
  ; calcolo percentuale
  (div ok iter))

Verifichiamo il risultato:

(p2 1e6)
;-> 0.500609
(p2 1e7)
;-> 0.4999576

Altre formulazioni:

Maria e Pietro hanno due bambini ed almeno uno è un maschio.
Qual è la probabilità che l'altro bambino sia un maschio?

Maria e Pietro hanno due bambini e non sono entrambi femmine.
Qual è la probabilità che entrambi i bambini siano maschi?


ChatGPT 3.5 (20 settembre 2023)
-------------------------------

Domanda:
--------
Una coppia ha due figli. Uno è un maschio. Quali sono le probabilità che anche l'altro figlio sia maschio?
ChatGPT

Risposta:
---------
Quando una coppia ha due figli, ci sono quattro possibili combinazioni di genere per i figli: maschio-maschio (MM), maschio-femmina (MF), femmina-maschio (FM) e femmina-femmina (FF).

Poiché sappiamo che almeno uno dei figli è un maschio, possiamo escludere la combinazione femmina-femmina (FF). Rimangono tre combinazioni possibili: MM, MF e FM.

Ognuna di queste tre combinazioni è equiprobabile. Quindi, la probabilità che l'altro bambino sia maschio (nell'opzione MM) è di 1/3, mentre la probabilità che l'altro bambino sia una femmina (nelle opzioni MF o FM) è anch'essa di 1/3. Quindi, la probabilità che l'altro bambino sia maschio è del 1/3.

Domanda:
--------
Una coppia ha due figli. Il figlio maggiore è un maschio. Quali sono le probabilità che anche l'altro figlio sia maschio?

Risposta:
---------
Se una coppia ha due figli e sappiamo che il figlio maggiore è un maschio, allora ci sono solo due possibili combinazioni di genere per i due figli: maschio-maschio (MM) e maschio-femmina (MF).

Poiché queste due combinazioni sono equiprobabili, la probabilità che anche l'altro figlio sia maschio (nell'opzione MM) è del 50%, mentre la probabilità che l'altro figlio sia una femmina (nell'opzione MF) è anch'essa del 50%. Quindi, nella situazione in cui sappiamo che il figlio maggiore è un maschio, la probabilità che anche l'altro figlio sia maschio è del 50%.


-------------
Veleno e topi
-------------

Ci sono 1000 bottiglie d'acqua.
Una delle bottiglie contiene acqua avvelenata.
Se un topo beve acqua avvelenata, allora muore dopo 24 ore.

Qual'è il numero minimo di topi necessari per capire quale bottiglia contiene acqua avvelenata?

Soluzione
---------
Occorrono 10 topi per capire quale sia la bottiglia avvelenata.

Assegniamo il relativo numero binario da 1 a 1000 ad ogni bottiglia.
La rappresentazione binaria di 1000 vale "1111101000" ed è lunga 10 bit.
Infatti la lunghezza di un numero binario è data da: ceil(log2 numero).
(bits 1000)
;-> "1111101000"
(length (bits 1000))
;-> 10
(ceil (log 1000 2))
;-> 10

Adesso assegniamo un topo ad ogni bit di ogni rappresentazione binaria.
Per esempio, la bottiglia 25 ha rappresentazione binaria pari a "0000011001".

Assegniamo ad ogni topo la posizione di un bit della rappresentazione binaria.
Nel caso di "0000011001", partendo da sinistra,:
  il primo bit "0" rappresenta il topo 1,
  il secondo bit "0" rappresenta il topo 2,
  ...,
  il sesto bit "1" rappresenta il topo 6,
  ...,
  il nono bit "0" rappresenta il topo 9,
  il decimo bit "1" rappresenta il topo 10.

Adesso prendiamo ogni bottiglia e la facciamo bere ai topi che nella sua rappresentazione binaria valgono "1".
Nell'esempio, la bottiglia 25 viene fatta bere ai topi 6, 7 e 10.

Notare che questa operazione (far bere ai topi l'acqua di tutte le bottiglie) deve essere svolta entro 24 ore, altrimenti alcuni topi potrebbero morire, impedendo così la conclusione dell'operazione.

Al termine dell'operazione avremo alcuni topi morti.
Supponiamo di avere come morti i topi 3, 5 e 8.
La bottiglia avvelenata è quella in cui la rappresentazione binaria vale "1" solo in corrispondenza dei bit 3, 5 e 8, cioè "0010100100" = 164.
(int "0010100100" 0 2)
;-> 164

Vediamo la seguente funzione per capire meglio il metodo:

(define (poison num-bottiglie)
  (local (morti veleno fmt binario out)
    ; numero di cavie necessarie
    (setq cavie (ceil (log num-bottiglie 2)))
    ; all'inizio nessun topo morto
    (setq morti '())
    ; bottiglia avvelenata
    (setq veleno (+ (rand num-bottiglie) 1))
    (println "Numero di bottiglie: " num-bottiglie)
    (println "Bottiglia avvelenata: " veleno)
    (println "Cavie necessarie: " cavie)
    ; Ciclo per far bere un pò d'acqua di ogni bottiglia ai topi
    ; che valgono "1" nella rappresentazione binaria del numero della bottiglia
    (for (bottiglia 1 num-bottiglie)
      ; rappresentazione binaria del numero bottiglia
      (setq fmt (string "%0" (int cavie) "d"))
      (setq binario (format fmt (int (bits bottiglia))))
      ; I topi con "1" in binario bevono la bottiglia corrente
      (for (k 0 (- (length binario) 1))
        ; il k-esimo topo muore se la bottiglia corrente è quella avvelenata
        ; e la sua posizione viene memorizzata nella lista morti
        (if (and (= veleno bottiglia) (= (binario k) "1")) (push k morti -1))
      )
    )
    (println "Lista topi morti: " morti)
    ; Ricostruzione del numero binario dalla posizione dei topi morti
    (setq out (dup "0" cavie))
    (dolist (m morti)
      (setf (out m) "1")
    )
    ; rappresentazione binaria e decimale della bottiglia avvelenata
    (list out (int out 0 2))))

Facciamo alcune prove:

(poison 1000)
;-> Numero di bottiglie: 1000
;-> Bottiglia avvelenata: 365
;-> Cavie necessarie: 10
;-> Lista topi morti: (1 3 4 6 7 9)
;-> ("0101101101" 365)

(poison 100)
;-> Numero di bottiglie: 100
;-> Bottiglia avvelenata: 15
;-> Cavie necessarie: 7
;-> Lista topi morti: (3 4 5 6)
;-> ("0001111" 15)

(poison 20)
;-> Numero di bottiglie: 20
;-> Bottiglia avvelenata: 4
;-> Cavie necessarie: 5
;-> Lista topi morti: (2)
;-> ("00100" 4)

Qual'è il numero massimo di topi di morti con N bottiglie?

Il massimo numero di topi morti si ottiene quando la rappresentazione binaria della bottiglia avvelenata contiene il maggior numero di bit a "1".

(define (max-1 limite)
  (setq out '())
  (setq val-max 0)
  (setq num-bin "0")
  (for (num 1 limite)
    (setq conta-1 (length (ref-all "1" (explode (bits num)))))
    (if (>= conta-1 val-max)
        (set 'val-max conta-1 'num-bin (bits num))
    )
  )
  (list val-max num-bin (int num-bin 0 2)))

Facciamo alcune prove:

(max-1 1000)
;-> (9 "1111011111" 991)
(max-1 1023)
;-> (10 "1111111111" 1023)
(max-1 1500)
;-> (10 "1111111111" 1023)

Quindi con N bottiglie il numero massimo di topi morti vale:

          | ceil(log2 N)    , se N contiene tutti "1"
  morti = |
          | ceil(log2 N) - 1, se N non contiene tutti "1"


-------------------------------------------------------
Calendario Maya (Maya Mesoamerican Long Count Calendar)
-------------------------------------------------------

Questo calendario conta i giorni dall'11 agosto 3114 A.C.
Divide il numero di giorni trascorsi in periodi di diversa durata:
- il giorno singolo,
- il Winal (20 giorni),
- il Tun (18 Winal, o 360 giorni),
- il K'atun (20 Tun, 7200 giorni) e
- il B'ak'tun (20 K'atun, 144 000 giorni).

Dato un numero di giorni dal 11 agosto 3114 A.C. determinare la data del calendario Maya.

Per esempio:
Giorni: 1526484
(setq baktun (/ 1526484 144000))
;-> 10
(setq resto (- 1526484 (* baktun 144000)))
;-> 86484
(setq katun (/ resto 7200))
;-> 12
(setq resto (- resto (* katun 7200)))
;-> 84
(setq tun (/ resto 360))
;-> 0
(setq resto (- resto (* tun 360)))
;-> 84
(setq winal (/ resto 20))
;-> 4
(setq giorni (- resto (* winal 20)))
;-> 4
Data Maya: 10.12.0.4.4

(define (maya days)
  (local (baktun katun tun winal giorni resto)
    (setq baktun (/ days 144000))
    (setq resto (- days (* baktun 144000)))
    (setq katun (/ resto 7200))
    (setq resto (- resto (* katun 7200)))
    (setq tun (/ resto 360))
    (setq resto (- resto (* tun 360)))
    (setq winal (/ resto 20))
    (setq giorni (- resto (* winal 20)))
    (string baktun "." katun "." tun "." winal "." giorni)))

Facciamo alcune prove:

(maya 1526484)
;-> "10.12.0.4.4"

(maya 1)
;-> "0.0.0.0.1"

Nota: per calcolare la data Maya di una data qualsiasi occorre usare le funzioni sulle date della libreria "yo.lsp", facendo attenzione alle date con il calendario giuliano e con il calendario gregoriano.


---------------------
Media tra due lettere
---------------------

Ogni lettera dell'alfabeto può essere rappresentata con un codice ASCII.
Ad esempio, "a" è 97 e "S" è 83.
La formula per calcolare la media di due numeri xey è (x+y)/2.
Calcolare il carattere ASCII medio di due lettere (valore intero).
Entrambe le lettere ASCII saranno comprese nell'intervallo 97-122 o 65-90.
Il valore ASCII medio deve essere troncato a 0 cifre decimali (parte intera della media dei valori).

Esempi:
  Input:  A, C
  Output: B
  Input:  a, z
  Output: m
  Input:  d, j
  Output: g
  Input:  B, e
  Output: S
  Input:  Z, a
  Output: ]

La funzione deve essere la più breve possibile.

Prima versione:

(define (m l) (char (apply add (map div (map char l) '(2 2)))))

(m '("A" "C"))
;-> "B"
(m '("a" "z"))
;-> "m"
(m '("d" "j"))
;-> "g"
(m '("B" "e"))
;-> "S"
(m '("Z" "a"))
;-> "]"

Seconda versione:

(define (m a b) (char (/ (+ (char a) (char b)) 2)))

(m "A" "C")
;-> "B"
(m "a" "z")
;-> "m"
(m "d" "j")
;-> "g"
(m "B" "e")
;-> "S"
(m "Z" "a")
;-> "]"


--------------------
Terne magiche uniche
--------------------

Abbiamo una lista di numeri interi (a1,...,an).
Una terna magica è un insieme di tre valori (a(i), a(j), a(k)) della lista, tale che gli indici (i,j,k) sono tutti distinti, i valori sono in ordine crescente (a(i) <= a(j) <= a(k)) e la somma dei primi due valori è uguale al terzo.
Generare tutte le triplette magiche uniche.

Esempi:
  (1 2 3 2 4) -> ((1 2 3)  (1 3 4)  (2 2 4))
  (0 0 0 0) -> ((0 0 0))
  (1 0 -1) -> ((-1 0 1))
  (1 2) -> ()
  (1 2 4 8 99) -> ()
  (33 90 7 24 60 32 80 43 15 40 36 90 65 12 91 33 88 1 96 33 40) ->
    ((7 33 40) (32 33 65) (1 32 33) (1 90 91) (7 36 43)
     (24 36 60) (12 24 36) (36 60 96) (15 65 80) (40 40 80)

Algoritmo forza bruta:

(define (terne lst)
  (setq len (length lst))
  (setq out '())
  (if (>= len 3)
    (for (i 0 (- len 1))
      (for (j 0 (- len 1))
        (for (k 0 (- len 1))
          (setq v1 (lst i))
          (setq v2 (lst j))
          (setq v3 (lst k))
          (if (and (= v3 (+ v1 v2))
                  (>= v3 v2)
                  (>= v2 v1)
                  (!= i j)
                  (!= i k)
                  (!= j k))
              (push (list v1 v2 v3) out -1)
          ))))
  )
  (unique out))

Facciamo alcune prove:

(terne '(1 2 3 2 4))
;-> ((1 2 3) (1 3 4) (2 2 4))
(terne '(0 0 0 0))
;-> ((0 0 0))
(terne '(1 0 -1))
;-> ()
(terne '(1 2))
;-> ()
(terne '(1 2 4 8 99))
;-> ()
(terne '(33 90 7 24 60 32 80 43 15 40 36 90 65 12 91 33 88 1 96 33 40))
;-> ((7 33 40) (7 36 43) (24 36 60) (32 33 65) (15 65 80)
;->  (40 40 80) (36 60 96) (12 24 36) (1 90 91) (1 32 33))

10 elementi:
(silent (setq t (rand 1e6 1e1)))
(time (terne t))
;-> 0

100 elementi:
(silent (setq t (rand 1e6 1e2)))
(time (terne t))
;-> 288.834

1000 elementi:
(silent (setq t (rand 1e6 1e3)))
(time (terne t))
;-> 1600601.791 ;oops, 1600 secondi (quasi 27 minuti)

Utilizziamo un vettore:

10 elementi:
(silent (setq t (array 1e1 (rand 1e6 1e1))))
(time (terne t))
;-> 0

100 elementi:
(silent (setq t (array 1e2 (rand 1e6 1e2))))
(time (terne t))
;-> 180.974

1000 elementi:
(silent (setq t (array 1e3 (rand 1e6 1e3))))
(time (terne t))
;-> 171398.926 ;171 secondi (3 minuti e 11 secondi)

Proviamo con "dolist" invece del "for":

(define (terne2 lst)
  (setq len (length lst))
  (setq out '())
  (if (>= len 3)
    (dolist (v1 lst)
      (setq i $idx)
      (dolist (v2 lst)
        (setq j $idx)
        (if (!= j i)
          (begin
            (dolist (v3 lst)
              (setq k $idx)
              (if (and (!= k i) (!= k j)
                       (= v3 (+ v1 v2))
                       (>= v3 v2)
                       (>= v2 v1))
                  (push (list v1 v2 v3) out -1)
              )
            )
          )
        )
      )
    )
  )
  (unique out))

Facciamo alcune prove:

(terne2 '(1 2 3 2 4))
;-> ((1 2 3) (1 3 4) (2 2 4))
(terne2 '(0 0 0 0))
;-> ((0 0 0))
(terne2 '(1 0 -1))
;-> ()
(terne2 '(1 2))
;-> ()
(terne2 '(1 2 4 8 99))
;-> ()
(terne2 '(33 90 7 24 60 32 80 43 15 40 36 90 65 12 91 33 88 1 96 33 40))
;-> ((7 33 40) (7 36 43) (24 36 60) (32 33 65) (15 65 80)
;->  (40 40 80) (36 60 96) (12 24 36) (1 90 91) (1 32 33))

10 elementi:
(silent (setq t (rand 1e6 1e1)))
(time (terne2 t))
;-> 0

100 elementi:
(silent (setq t (rand 1e6 1e2)))
(time (terne2 t))
;-> 155.533

1000 elementi:
(silent (setq t (rand 1e6 1e3)))
(time (terne2 t))
;-> 147819.544 ;148 secondi (3 minuti e 28 secondi)

Utilizziamo un vettore:

10 elementi:
(silent (setq t (array 1e1 (rand 1e6 1e1))))
(time (terne2 t))
;-> 0

100 elementi:
(silent (setq t (array 1e2 (rand 1e6 1e2))))
(time (terne2 t))
;-> 140.614

1000 elementi:
(silent (setq t (array 1e3 (rand 1e6 1e3))))
(time (terne2 t))
;->  148781.185; 148 secondi (2 minuti e 28 secondi)

Proviamo a spostare le condizioni "if" degli indici:

(define (terne3 lst)
  (setq len (length lst))
  (setq out '())
  (if (>= len 3)
    (dolist (v1 lst)
      (setq i $idx)
      (dolist (v2 lst)
        (setq j $idx)
        (dolist (v3 lst)
          (setq k $idx)
          (if (and (= v3 (+ v1 v2))
                  (>= v3 v2)
                  (>= v2 v1)
                  (!= i j)
                  (!= i k)
                  (!= j k))
              (push (list v1 v2 v3) out -1)
          ))))
  )
  (unique out))

Facciamo alcune prove:

(terne3 '(1 2 3 2 4))
;-> ((1 2 3) (1 3 4) (2 2 4))
(terne3 '(0 0 0 0))
;-> ((0 0 0))
(terne3 '(1 0 -1))
;-> ()
(terne3 '(1 2))
;-> ()
(terne3 '(1 2 4 8 99))
;-> ()
(terne3 '(33 90 7 24 60 32 80 43 15 40 36 90 65 12 91 33 88 1 96 33 40))
;-> ((7 33 40) (7 36 43) (24 36 60) (32 33 65) (15 65 80)
;->  (40 40 80) (36 60 96) (12 24 36) (1 90 91) (1 32 33))

10 elementi:
(silent (setq t (rand 1e6 1e1)))
(time (terne3 t))
;-> 0

100 elementi:
(silent (setq t (rand 1e6 1e2)))
(time (terne3 t))
;-> 100.2

1000 elementi:
(silent (setq t (rand 1e6 1e3)))
(time (terne3 t))
;-> 98853.769 ;quasi 99 secondi

Utilizziamo un vettore:

10 elementi:
(silent (setq t (array 1e1 (rand 1e6 1e1))))
(time (terne3 t))

100 elementi:
(silent (setq t (array 1e2 (rand 1e6 1e2))))
(time (terne3 t))
;-> 100.233

1000 elementi:
(silent (setq t (array 1e3 (rand 1e6 1e3))))
(time (terne3 t))
;-> 99564.918 ;99 secondi


--------------
Cerchi e corde
--------------

Qual è il numero massimo di pezzi che si possono creare utilizzando N corde per tagliare il cerchio?

Per esempio:
  con 1 corda dividiamo il cerchio in  2 parti.
  con 2 corda dividiamo il cerchio in  4 parti (al massimo).
  con 3 corde dividiamo il cerchio in  7 parti (al massimo).
  con 4 corde dividiamo il cerchio in 11 parti (al massimo).
  con 5 corde dividiamo il cerchio in 16 parti (al massimo).
  con 6 corde dividiamo il cerchio in 22 parti (al massimo).

Vedi la figura "cerchio-corde.jpg" nella cartella "data".

Cerchiamo di ricavare una formula generale con il "Metodo delle differenze".

Vedi "Polinomi generatori di sequenze - Metodo delle differenze" su "Note libere 15".

Scriviamo i valori e le differenze successive tra due elementi:

  S(n) = 2 4 7 11 16 22
          2 3 4  5  6
           1 1  1  1

Il polinomio generatore è di secondo grado, perchè abbiamo 2 righe di differenze per ottenere un valore costante (1):

  P(n) = A*n^2 + B*n + C

Ci servono 3 valori per determinare le variabili A, B e C:

  P(1) = 2
  P(2) = 4
  P(3) = 7

Sostituiamo i valori e otteniamo il seguente sistema:

  A + B + C = 2
  4A + 2B + C = 4
  9A + 3B + C = 7

Risolviamo il sistema con la funzione "sislin-c" (metodo di Cramer):

(define (sislin-c matrix terms)
"Solve a linear system with Cramer's method (determinant)"
  (local (dim detm det-i sol copia)
    (setq dim (length matrix))
    (setq sol '())
    (setq copia matrix)
    (setq detm (det copia 0.0))
    ; la soluzione è indeterminata se il determinante vale zero.
    (if (= detm 0) (setq sol nil)
    ;(println detm)
      (for (i 0 (- dim 1))
        (for (j 0 (- dim 1))
          (setf (copia j i) (terms j))
        )
        ; 0.0 -> restituisce 0 (invece di nil),
        ; quando la matrix è singolare
        (setq det-i (det copia 0.0))
        (push (div det-i detm) sol -1)
        (setq copia matrix)
      )
    )
    sol))

(sislin-c '((1 1 1) (4 2 1) (9 3 1)) '(2 4 7))
;-> (0.5000000000000003 0.5000000000000009 0.9999999999999993)

Quindi abbiamo i seguenti valori:

  A = 0.5 = 1/2
  B = 0.5 = 1/2
  C = 1

Verifichiamo la soluzione:

(define (check-sislin matrix terms sol)
"Check the solution of a linear system (backwards substitution)"
  (let (err '())
    (dolist (row matrix)
      (push (sub (terms $idx) (apply add (map mul row sol))) err -1))))

(check-sislin '((1 1 1) (4 2 1) (9 3 1)) '(2 4 7)
              '(0.5 0.5 1))
;-> (0 0 0)

Il nostro polinomio generatore vale:

  P(n) = (1/2)*n^2 + (1/2)*n + 1 =
       = (n^2 + n)/2 + 1 =
       = (n*(n+1))/2 + 1

Scriviamo la funzione per il polinomio:

(define (p n) (+ 1 (/ (* n (+ n 1)) 2)))

Verifichiamo i risultati:

(map s (sequence 1 6))
;-> (2 4 7 11 16 22)

Per esempio, con 100 tagli otteniamo 5051 pezzi:

(s 100)
;-> 5051

Per le potenze di 10 fino a 5:

(map s '(1e1 1e2 1e3 1e4 1e5))
;-> (56 5051 500501 50005001 5000050001)


-----------------
Il geco e il muro
-----------------

Un geco si trova alla base di un muro alto 10 metri.
Il geco sale per 2 metri di giorno e scende di 1 metro la notte mentre dorme.
Quante giornate sono necessarie al geco per raggiungere la sommità del muro?
Una giornata è composta da un giorno e una nottte.
Quando il geco raggiunge la sommità non scende più.

Si tratta di un vecchio indovinello la cui risposta è 9 giorni e 8 notti, cioè 8.5 giornate.
Infatti il nono giorno il geco raggiunge la cima (quindi la nona notte non scende).

Proviamo a scrivere una funzione considerando che:

  giorno + notte = 0.5 + 0.5 = 1 giornata

(define (geco muro sale scende)
  (local (pos giornate giorni notti)
    (setq pos 0)
    (setq giornate 0)
    (setq giorni 0)
    (setq notti 0)
    (while (< pos muro)
      ; salita
      (setq pos (+ pos sale))
      (++ giorni)
      (setq giornate (add giornate 0.5))
      ; discesa (solo se non abbiamo raggiunto la cima del muro)
      (if (< pos muro)
        (begin
          (setq pos (- pos scende))
          (++ notti)
          (setq giornate (add giornate 0.5))
        )
      )
    )
  (list giorni notti giornate)))

Facciamo alcune prove:

(geco 10 2 1)
;-> (9 8 8.5)

(geco 2 2 1)
;-> (1 0 0.5)

(geco 50 4 3)
;-> (47 46 46.5)

(geco 10 12 10)
;-> (1 0 0.5)


--------------------
Cambio di pneumatici
--------------------

Un'auto ha 4 ruote e 1 ruota di scorta.
Ogni pneumatico può percorrere una distanza massima di 20000 km prima di consumarsi.
Qual è la distanza massima che l'auto può percorrere prima di essere costretto ad acquistare un nuovo pneumatico?
È possibile cambiare gli pneumatici (utilizzando la ruota di scorta) un numero illimitato di volte.

Soluzione:
Dividiamo la durata della ruota di scorta in 4 parti uguali, ovvero 5000 km, e la sostituiamo dopo aver percorso 5000 km.
Chiamiamo le 4 ruote A,B,C,D e la ruota di scorta S.

Situazione iniziale:
   A        B        C        D        S
   0        0        0        0        0       km percorsi
 20000    20000    20000    20000    200000    km rimasti

Passo 1: Percorro 5000 km e poi cambio A con S
   S        B        C        D        A
   0       5000     5000     5000     5000     km percorsi
 20000    15000    15000    15000    15000     km rimasti

Passo 2: Percorro 5000 km, rimetto A al suo posto e cambio B con S:
   A        S        C        D        B
  5000     5000    10000    10000    10000     km percorsi
 15000    15000    10000    10000    10000     km rimasti

Passo 3: Percorro 5000 km, rimetto B al suo posto e cambio C con S:
   A        B        S        D        C
 10000    10000    10000    15000    15000     km percorsi
 10000    10000    10000     5000     5000     km rimasti

Passo 4: Percorro 5000 km, rimetto C al suo posto e cambio D con S:
   A        B        C        S        D
 15000    15000    15000    15000    20000     km percorsi
  5000     5000     5000     5000      0       km rimasti

Passo 5: Percorro 5000 km e tutte le gomme sono consumate:
   A        B        C        S        D
 20000    20000    20000    20000    20000     km percorsi
   0        0        0        0        0       km rimasti

Abbiamo percorso 5 volte 5000 km, quindi la soluzione vale 5*5000 = 25000 km.

Considerando 5 pneumatici di pari kilometraggio possiamo scrivere:

(define (km? ruota)
  ;(setq step (div ruota 4))
  ;(setq distanza (mul step 5))
  (mul (div ruota 4) 5))

(km? 20000)
;-> 25000
(km? 150000)
;-> 187500

Se invece le 5 ruote hanno un kilometraggio diverso, allora utilizzare come ruota di scorta quella con kilometraggio minore.
Per esempio:

A = 10000 km
B = 10000 km
C = 10000 km
D = 10000 km
S =  8000 km

In questo caso dobbiamo dividere 8000 in 4 parti uguali, quindi dobbiamo cambiare la ruota ogni 2000 km.

Scriviamo una funzione che risolve il problema:

(define (test r1 r2 r3 r4 s0)
  (local (tot_km Ar Br Cr Dr Sr Ap Bp Cp Dp Sp km totale)
    (setq tot_km 0)
    ; kilometri rimasti per ogni pneumatico
    (setq Ar r1 Br r2 Cr r3 Dr r4 Sr s0)
    ; kilometri percorsi per ogni pneumatico
    (setq Ap 0 Bp 0 Cp 0 Dp 0 Sp 0)
    ; kilometri percorsi ad ogni passo
    (setq km (div Sr 4))
    (println "Situazione iniziale:")
    (println "km rimasti pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ar "B=" Br "C=" Cr "D=" Dr "S=" Sr))
    (println "km percorsi pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ap "B=" Bp "C=" Cp "D=" Dp "S=" Sp))
    (println "\nPasso 1: percorro " km " km e cambio A con S")
    (map set '(Ap Bp Cp Dp) (map (fn(x) (add x km)) (list Ap Bp Cp Dp)))
    (map set '(Ar Br Cr Dr) (map (fn(x) (sub x km)) (list Ar Br Cr Dr)))
    (setq tot_km (add tot_km km))
    ; swap A S (S B C D)
    (println "km rimasti")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "S=" Sr "B=" Br "C=" Cr "D=" Dr "A=" Ar))
    (println "km percorsi")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "S=" Sp "B=" Bp "C=" Cp "D=" Dp "A=" Ap))
    (println "\nPasso 2: percorro " km " km, rimonto A e cambio B con S")
    (map set '(Sp Bp Cp Dp) (map (fn(x) (add x km)) (list Sp Bp Cp Dp)))
    (map set '(Sr Br Cr Dr) (map (fn(x) (sub x km)) (list Sr Br Cr Dr)))
    (setq tot_km (add tot_km km))
    ; mount A and swap B S (A S C D)
    (println "km rimasti pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ar "S=" Sr "C=" Cr "D=" Dr "B=" Br))
    (println "km percorsi pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ap "S=" Sp "C=" Cp "D=" Dp "B=" Bp))
    (println "\nPasso 3: percorro " km " km, rimonto B e cambio C con S")
    (map set '(Ap Sp Cp Dp) (map (fn(x) (add x km)) (list Ap Sp Cp Dp)))
    (map set '(Ar Sr Cr Dr) (map (fn(x) (sub x km)) (list Ar Sr Cr Dr)))
    (setq tot_km (add tot_km km))
    ; mount B and swap C S (A B S D)
    (println "km rimasti pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ar "B=" Br "S=" Sr "D=" Dr "C=" Cr))
    (println "km percorsi pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ap "B=" Bp "S=" Sp "D=" Dp "C=" Cp))
    (println "\nPasso 4: percorro " km " km, rimonto C e cambio D con S")
    (map set '(Ap Bp Sp Dp) (map (fn(x) (add x km)) (list Ap Bp Sp Dp)))
    (map set '(Ar Br Sr Dr) (map (fn(x) (sub x km)) (list Ar Br Sr Dr)))
    (setq tot_km (add tot_km km))
    ; mount C and swap D S (A B C S)
    (println "km rimasti pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ar "B=" Br "C=" Cr "S=" Sr "D=" Dr))
    (println "km percorsi pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ap "B=" Bp "C=" Cp "S=" Sp "D=" Dp))
    (println "\nPasso 5: percorro " km " km e rimonto D")
    (map set '(Ap Bp Cp Sp) (map (fn(x) (add x km)) (list Ap Bp Cp Sp)))
    (map set '(Ar Br Cr Sr) (map (fn(x) (sub x km)) (list Ar Br Cr Sr)))
    (setq tot_km (add tot_km km))
    ; mount D (swap D S) (A B C D)
    (println "km rimasti pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ar "B=" Br "C=" Cr "D=" Dr "S=" Sr))
    (println "km percorsi pneumatici:")
    (println (format "%s%-8d%s%-8d%s%-8d%s%-8d%s%-8d" "A=" Ap "B=" Bp "C=" Cp "D=" Dp "S=" Sp))
    (println "Totale km percorsi (fino ad esaurimento ruota di scorta): " tot_km)
    ; kilometri da aggiungere al termine della ruota di scorta
    (println "Totale km: " (add tot_km (min Ar Br Cr Dr)))
  ))

Facciamo alcune prove:

(test 20000 20000 20000 20000 20000)
;-> Situazione iniziale:
;-> km rimasti pneumatici:
;-> A=20000   B=20000   C=20000   D=20000   S=20000
;-> km percorsi pneumatici:
;-> A=0       B=0       C=0       D=0       S=0
;->
;-> Passo 1: percorro 5000 km e cambio A con S
;-> km rimasti
;-> S=20000   B=15000   C=15000   D=15000   A=15000
;-> km percorsi
;-> S=0       B=5000    C=5000    D=5000    A=5000
;->
;-> Passo 2: percorro 5000 km, rimonto A e cambio B con S
;-> km rimasti pneumatici:
;-> A=15000   S=15000   C=10000   D=10000   B=10000
;-> km percorsi pneumatici:
;-> A=5000    S=5000    C=10000   D=10000   B=10000
;->
;-> Passo 3: percorro 5000 km, rimonto B e cambio C con S
;-> km rimasti pneumatici:
;-> A=10000   B=10000   S=10000   D=5000    C=5000
;-> km percorsi pneumatici:
;-> A=10000   B=10000   S=10000   D=15000   C=15000
;->
;-> Passo 4: percorro 5000 km, rimonto C e cambio D con S
;-> km rimasti pneumatici:
;-> A=5000    B=5000    C=5000    S=5000    D=0
;-> km percorsi pneumatici:
;-> A=15000   B=15000   C=15000   S=15000   D=20000
;->
;-> Passo 5: percorro 5000 km e rimonto D
;-> km rimasti pneumatici:
;-> A=0       B=0       C=0       D=0       S=0
;-> km percorsi pneumatici:
;-> A=20000   B=20000   C=20000   D=20000   S=20000
;-> Totale km percorsi (fino ad esaurimento ruota di scorta): 25000
;-> Totale km: 25000

(test 20000 20000 20000 20000 10000)
;-> Situazione iniziale:
;-> km rimasti pneumatici:
;-> A=20000   B=20000   C=20000   D=20000   S=10000
;-> km percorsi pneumatici:
;-> A=0       B=0       C=0       D=0       S=0
;->
;-> Passo 1: percorro 2500 km e cambio A con S
;-> km rimasti
;-> S=10000   B=17500   C=17500   D=17500   A=17500
;-> km percorsi
;-> S=0       B=2500    C=2500    D=2500    A=2500
;->
;-> Passo 2: percorro 2500 km, rimonto A e cambio B con S
;-> km rimasti pneumatici:
;-> A=17500   S=7500    C=15000   D=15000   B=15000
;-> km percorsi pneumatici:
;-> A=2500    S=2500    C=5000    D=5000    B=5000
;->
;-> Passo 3: percorro 2500 km, rimonto B e cambio C con S
;-> km rimasti pneumatici:
;-> A=15000   B=15000   S=5000    D=12500   C=12500
;-> km percorsi pneumatici:
;-> A=5000    B=5000    S=5000    D=7500    C=7500
;->
;-> Passo 4: percorro 2500 km, rimonto C e cambio D con S
;-> km rimasti pneumatici:
;-> A=12500   B=12500   C=12500   S=2500    D=10000
;-> km percorsi pneumatici:
;-> A=7500    B=7500    C=7500    S=7500    D=10000
;->
;-> Passo 5: percorro 2500 km e rimonto D
;-> km rimasti pneumatici:
;-> A=10000   B=10000   C=10000   D=10000   S=0
;-> km percorsi pneumatici:
;-> A=10000   B=10000   C=10000   D=10000   S=10000
;-> Totale km percorsi (fino ad esaurimento ruota di scorta): 12500
;-> Totale km: 22500

(test 10000 9000 10000 10000 8000)
;-> Situazione iniziale:
;-> km rimasti pneumatici:
;-> A=10000   B=9000    C=10000   D=10000   S=8000
;-> km percorsi pneumatici:
;-> A=0       B=0       C=0       D=0       S=0
;->
;-> Passo 1: percorro 2000 km e cambio A con S
;-> km rimasti
;-> S=8000    B=7000    C=8000    D=8000    A=8000
;-> km percorsi
;-> S=0       B=2000    C=2000    D=2000    A=2000
;->
;-> Passo 2: percorro 2000 km, rimonto A e cambio B con S
;-> km rimasti pneumatici:
;-> A=8000    S=6000    C=6000    D=6000    B=5000
;-> km percorsi pneumatici:
;-> A=2000    S=2000    C=4000    D=4000    B=4000
;->
;-> Passo 3: percorro 2000 km, rimonto B e cambio C con S
;-> km rimasti pneumatici:
;-> A=6000    B=5000    S=4000    D=4000    C=4000
;-> km percorsi pneumatici:
;-> A=4000    B=4000    S=4000    D=6000    C=6000
;->
;-> Passo 4: percorro 2000 km, rimonto C e cambio D con S
;-> km rimasti pneumatici:
;-> A=4000    B=3000    C=4000    S=2000    D=2000
;-> km percorsi pneumatici:
;-> A=6000    B=6000    C=6000    S=6000    D=8000
;->
;-> Passo 5: percorro 2000 km e rimonto D
;-> km rimasti pneumatici:
;-> A=2000    B=1000    C=2000    D=2000    S=0
;-> km percorsi pneumatici:
;-> A=8000    B=8000    C=8000    D=8000    S=8000
;-> Totale km percorsi (fino ad esaurimento ruota di scorta): 10000
;-> Totale km: 11000


-----------------------
Il gioco di carte "SET"
-----------------------

SET (oppure Set o SET!) è un gioco di carte progettato da Marsha Falco nel 1974 e pubblicato da Set Enterprises nel 1991.
Il mazzo è composto da 81 carte uniche che variano in quattro caratteristiche attraverso tre possibilità per ogni tipo di caratteristica:

- numero di forme (una, due o tre),
- forma (diamante, onda, ovale),
- campitura (solida, a strisce o aperta)
- colore (rosso, verde o viola).

Ogni possibile combinazione di caratteristiche (ad esempio una carta con tre diamanti verdi a strisce) appare come una carta esattamente una volta nel mazzo.

Vedi immagine "set-game.png" nella cartella "data".

Con queste carte si possono fare diversi giochi, tutti basati sul concetto di "set".

Un "set" è composto da tre carte che soddisfano tutte queste condizioni:

- Hanno tutte lo stesso numero o tre numeri diversi.
- Hanno tutte la stessa forma o hanno tre forme diverse.
- Hanno tutte la stessa campitura oppure tre campiture diverse.
- Hanno tutte lo stesso colore o hanno tre colori diversi.

Cioè, le carte sono tutte uguali o tutte diverse in ciascuna delle quattro caratteristiche.

Le regole sono riassunte come segue:
Se abbiamo un gruppo di tre carte in "due di ____ e una di ____", allora non è un "set".

Ad esempio, queste tre carte formano un "set":
  1) Un diamante a strisce rosso
  2) Due diamanti solidi rossi
  3) Tre diamanti aperti rossi

Date due carte qualsiasi del mazzo, c'è una e soltanto un'altra carta che forma un "set" con esse.
Quindi la probabilità di avere un "set" da 3 carte estratte a caso da un mazzo completo è 1/79.

Date diverse carte (solitamente 12), l'obiettivo del gioco è trovare un insieme di tre carte tale che formino un "set".

Rappresentiamo una carta come una tupla di 4 numeri da 0 a 2.
Per esempio:

  0000 = un diamante solido rosso
  0011 = uno onde a strisce rosse
  0112 = un ovale striato verde
  1201 = due onde viola solidi

Un "cap set" è un insieme di carte che non contiene alcun "set".
Nel 1971 è stato dimostrato che il numero massimo di carte senza un "set" è 20.
Trovare il "set" con il maggior numero di carte per il gioco generalizzato del SET è ancora un problema aperto in matematica.
Ci sono 682344 "cap set" da 20 carte in tutto, ma sotto trasformazioni affini sullo spazio finito quadridimensionale, si riducono tutti essenzialmente a un solo "cap set" (Donald Knuth 2001).

Vediamo come trovare un qualunque "cap set" tra i 682344.

Definiamo un "cap set" tutte le quadruple (a b c d) da {0,1,2}^4 dove:

  a*a + b*b + c*d = 0 (mod 3)

In altre parole, stiamo cercando un insieme di valori per a, b, c, d in cui la somma dei prodotti di questi valori, quando calcolata modulo 3, produce come risultato 0.

L'espressione "{0, 1, 2}^4" rappresenta un insieme di quadruple di numeri dove ciascun numero può essere 0, 1 o 2.
Questa notazione viene utilizzata per rappresentare un insieme di tuple ordinate di elementi presi da un insieme di valori possibili.
In questo caso, stiamo considerando quadruple, quindi ci sono 4 posizioni in ciascuna quadrupla e ognuna di queste posizioni può contenere uno dei tre valori: 0, 1 o 2.
L'insieme "{0, 1, 2}^4" sarebbe quindi composto da tutte le possibili combinazioni di quadruple di 0, 1 e 2. Ci sarebbero un totale di 3^4 = 81 diverse quadruple in questo insieme, poiché ogni posizione può avere una delle tre opzioni e ci sono 4 posizioni in totale. Ecco alcune delle possibili quadruple in questo insieme:

  (0, 0, 0, 0)
  (0, 0, 0, 1)
  (0, 0, 0, 2)
  (0, 0, 1, 0)
  ...
  (2, 2, 2, 0)
  (2, 2, 2, 1)
  (2, 2, 2, 2)

Quindi, "{0, 1, 2}^4" rappresenta un insieme di 81 diverse quadruple di numeri composte da 0, 1 e 2.

(define (perm-rep k lst)
"Generates all permutations of k elements with repetition from a list of items"
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

Generiamo tutto il mazzo di carte del gioco:

(perm-rep 4 '(0 1 2))
;-> ((0 0 0 0)
;->  (1 0 0 0)
;->  (2 0 0 0)
;->  (0 1 0 0)
;->  (1 1 0 0)
;->  (2 1 0 0)
;->  ...
;->  (2 1 2 2)
;->  (0 2 2 2)
;->  (1 2 2 2)
;->  (2 2 2 2))

(length (perm-rep 4 '(0 1 2)))
;-> 81

Scriviamo la funzione che trova un "cap set" di 20 carte:

(define (find-capset)
  (local (capset fours)
    (setq capset '())
    (setq fours (perm-rep 4 '(0 1 2)))
    (dolist (f fours)
      (if (and (zero? (% (+ (* (f 0) (f 0)) (* (f 1) (f 1)) (* (f 2) (f 3))) 3))
              (!= (apply + f) 0))
          (push f capset -1)
      )
    )
    capset))

(find-capset)
;-> ((0 0 1 0) (0 0 2 0) (0 0 0 1) (1 1 1 1) (2 1 1 1)
;->  (1 2 1 1) (2 2 1 1) (1 0 2 1) (2 0 2 1) (0 1 2 1)
;->  (0 2 2 1) (0 0 0 2) (1 0 1 2) (2 0 1 2) (0 1 1 2)
;->  (0 2 1 2) (1 1 2 2) (2 1 2 2) (1 2 2 2) (2 2 2 2))

Adesso scriviamo una funzione per vedere se tre carte formano un "set".

Abbiamo visto che un "set" è composto da tre carte che soddisfano tutte queste condizioni:

- Hanno tutte lo stesso numero o tre numeri diversi.
- Hanno tutte la stessa forma o hanno tre forme diverse.
- Hanno tutte la stessa campitura oppure tre campiture diverse.
- Hanno tutte lo stesso colore o hanno tre colori diversi.

Cioè, le carte sono tutte uguali o tutte diverse in ciascuna delle quattro caratteristiche.

(define (is-set? lst)
  (let ((res true) (tipo '()))
    (for (t 0 3) ; per ogni tipo
      ; carte di quel tipo
      (setq tipo (list (lst 0 t) (lst 1 t) (lst 2 t)))
      ;(println tipo)
              ; se tutti tipi uguali oppure...
      (if (or (apply = tipo)
              ;... tutti i tipi diversi
              (= (unique tipo) tipo)) nil (setq res nil))
    )
    res))

Facciamo alcuni esempi:

(setq k '((0 0 1 0) (1 2 1 1) (2 2 1 1)))
(is-set? k)
;-> nil

Esempi di set:

  0000, 0001, 0002
  0000, 1111, 2222
  1201, 2210, 0222

(setq a '((0 0 0 0) (0 0 0 1) (0 0 0 2)))
(setq b '((0 0 0 0) (1 1 1 1) (2 2 2 2)))
(setq c '((1 2 0 1) (2 2 1 0) (0 2 2 2)))

Esempi di non-set:

 0000, 0011, 0012
 1020, 2110, 0102

(setq x '((0 0 0 0) (0 0 1 1) (0 0 1 2)))
(setq y '((1 0 2 0) (2 1 1 0) (0 1 0 2)))

(is-set? a)
;-> true
(is-set? b)
;-> true
(is-set? c)
;-> true
(is-set? x)
;-> nil
(is-set? y)
;-> nil

Verifichiamo che il "cap set" trovato precedentemente non contiene alcun "set".

(setq capset (find-capset))
;-> ((0 0 1 0) (0 0 2 0) (0 0 0 1) (1 1 1 1) (2 1 1 1)
;->  (1 2 1 1) (2 2 1 1) (1 0 2 1) (2 0 2 1) (0 1 2 1)
;->  (0 2 2 1) (0 0 0 2) (1 0 1 2) (2 0 1 2) (0 1 1 2)
;->  (0 2 1 2) (1 1 2 2) (2 1 2 2) (1 2 2 2) (2 2 2 2)))

Ci sono 1140 combinazioni diverse di tre carte che possono essere scelte dal capset:

(define (comb k lst (r '()))
"Generates all combinations of k elements without repetition from a list of items"
  (if (= (length r) k)
    (list r)
    (let (rlst '())
      (dolist (x lst)
        (extend rlst (comb k ((+ 1 $idx) lst) (append r (list x)))))
      rlst)))

(length (comb 3 capset))
;-> 1140

Generiamo tutte le combinazioni di tre carte:

(setq all (comb 3 capset))
;-> (((0 0 1 0) (0 0 2 0) (0 0 0 1))
;->  ((0 0 1 0) (0 0 2 0) (1 1 1 1))
;->  ((0 0 1 0) (0 0 2 0) (2 1 1 1))
;->  ...
;->  ((1 1 2 2) (2 1 2 2) (2 2 2 2))
;->  ((1 1 2 2) (1 2 2 2) (2 2 2 2))
;->  ((2 1 2 2) (1 2 2 2) (2 2 2 2)))

Verifichiamo che non abbiamo alcun "set" in queste combinazioni:

(dolist (mano all) (if (is-set? mano) (println mano)))
;-> nil

Adesso scriviamo una funzione che calcola tutti i "set" di un insieme di carte:

(define (find-set lst)
  (let ((all (comb 3 lst)) (out '()))
    (dolist (mano all)
      (if (is-set? mano)
          (push mano out -1)))
    out))

(find-set capset)
;-> ()

Funzione che genera un numero determinato di carte:

(define (create-cards num)
  (let (out (unique (collect (rand 3 4) num)))
       (until (= (length out) num)
         (setq out (unique (collect (rand 3 4) num)))
       )
       out))

(create-cards 5)
;-> ((1 1 2 1) (0 2 2 1) (0 2 2 2) (0 0 1 1) (0 2 0 2))

(create-cards 12)
;-> ((1 2 0 0) (0 2 2 2) (0 0 1 0) (0 0 0 0) (2 2 0 2) (2 0 2 1)
;->  (0 2 1 2) (0 0 1 2) (1 2 2 0) (0 2 1 1) (0 1 2 2) (0 2 2 1))

Nota: non provate (create-cards 81)...

Generiamo insiemi di carte e vediamo se ci sono "set":

(find-set (create-cards 12))
;-> (((0 1 1 1) (0 1 2 2) (0 1 0 0))
;->  ((2 1 1 1) (1 2 0 0) (0 0 2 2))
;->  ((1 2 1 0) (1 2 0 0) (1 2 2 0))
;->  ((1 2 0 0) (0 1 2 2) (2 0 1 1)))

(find-set (create-cards 12))
;-> (((0 1 0 2) (1 2 1 0) (2 0 2 1))
;->  ((0 1 2 0) (1 2 2 0) (2 0 2 0)))

Verifichiamo che scegliendo 3 carte dal mazzo completo (81 carte) abbiamo 1/79 di probabilità di formare un "set":

(setq iter 1e6)
(setq found 0)
(for (i 1 iter) (if (find-set (create-cards 3)) (++ found)))
found
;-> 12671
(div found iter)
;-> 0.012671
(div 1 79)
;-> 0.01265822784810127


----------------------------------
Stampa di numeri senza usare cifre
----------------------------------

Stampare un dato numero intero senza utilizzare nel codice i caratteri numerici 0..9.

L'idea è quella di utilizzare i valori degli indici di due liste di simboli.
Per esempio, per stampare il numero 2023 possiamo scrivere:

(int (apply string (map (fn(x) (find x '(a b c d))) '(c a c d))))
;-> 2023

Come funziona?
La funzione map cerca x in (a b c d) con x in (c a c d), quindi:
1) x = c --> (find c (a b c d)) = 2
1) x = a --> (find a (a b c d)) = 0
1) x = c --> (find c (a b c d)) = 2
1) x = d --> (find d (a b c d)) = 3
Poi convertiamo la lista (2 0 2 3) in stringa e infine convertiamo la stringa nel numero intero.
(int (apply string '(2 0 2 3)))
;-> 2023

Poichè abbiamo 10 cifre (0..9) utilizziamo la lista (a b c d e f g h i j) per la funzione "find".
Per creare la seconda lista (quella che codifica il numero) usiamo la lista costruita con le cifre del numero dato per selezionare i simboli dalla prima lista.

(define (number num)
  (local (ns alphabet code)
    ; lista delle cifre del numero dato
    (setq ns (map int (explode (string num))))
    (setq alphabet '(a b c d e f g h i j))
    ; creazione della seconda lista
    ; utilizzando la lista delle cifre del numero dato
    ; per selezionare i simboli corrispondenti dalla prima lista
    (setq code (select alphabet ns))
    (int (apply string (map (fn(x) (find x alphabet)) code)))))

(number 2023)
;-> 2023
(number 102030405060708090)
;-> 102030405060708090

Versione minima:

(define (p n)
  (int (apply string
       (map (fn(x) (find x '(a b c d e f g h i j)))
            (select '(a b c d e f g h i j) (map int (explode (string n))))))))

(p 2023)
;-> 2023
(p 102030405060708090)
;-> 102030405060708090


-------------------
Il pifferaio magico
-------------------

Questo è un vecchio test di programmazione.

Lungo una strada (indicata con "_"), c'è un Pifferaio Magico (indicato con "P") e diversi topi (indicati con "o" e "~", che rappresentano rispettivamente la testa e la coda di un topo).

Data una stringa che rappresenta una disposizione di topi e pifferaio, scrivere una funzione che restituisce quanti topi si dirigono verso il pifferaio e quanti topi si allontanano da lui.

Esempi:

input: __o~P_o~~o
output: 1 2

input: __P~oo~o~_o~~o__
output: 3 2

input: ~oPo~
output: 2 0

input: o~P~o
output: 0 2

Nota: non è possibile utilizzare le espressioni regolari e le funzioni di ricerca ("find" "find-all", "ref", "ref-all", ecc.)

(define (piff str)
  (local (len p sx dx i vicino lontano)
    (setq sx '() dx '())
    (setq vicino 0 lontano 0)
    (setq len (length str))
    ; per ogni carattere della stringa
    (setq i 0)
    (while (< i (- len 1))
      (cond ((= (str i) "~")   ; cerca "~o"
              (cond ((= (str (+ i 1)) "o")
                      (push i dx -1)
                      (++ i 2))
                    (true (++ i))
              ))
            ((= (str i) "o")  ; cerca "o~"
              (cond ((= (str (+ i 1)) "~")
                      (push i sx -1)
                      (++ i 2))
                    (true (++ i))
              ))
            ((= (str i) "P") ; trovato "P"
              (setq p i)
              (++ i))
            ; per tutti gli altri caratteri
            (true (++ i))
      )
    )
    ; ricerca vicini-lontani per i topi
    ; che vanno verso sinistra
    (dolist (pos sx) ; o~
      (if (< pos p)
          (++ lontano)
          (++ vicino)
      )
    )
    ; ricerca vicini-lontani per i topi
    ; che vanno verso destra
    (dolist (pos dx) ; ~o
      (if (< pos p)
          (++ vicino)
          (++ lontano)
      )
    )
    (list vicino lontano)))

Facciamo alcune prove:

(piff "__o~P_o~~o")
;-> (1 2)

(piff "__P~oo~o~_o~~o__")
;-> (3 2)

(piff "~oPo~")
;-> (2 0)

(piff "o~P~o")
;-> (0 2)


---------------------
La funzione "collect"
---------------------

********************
>>>funzione COLLECT
********************
sintassi: (collect exp [int-max-count])

Valuta l'espressione in exp e raccoglie i risultati in una lista finché la valutazione di exp non restituisce nil.

Facoltativamente è possibile specificare un conteggio massimo di elementi in int-max-count.

; collect results until nil is returned
(set 'x 0)
(collect (if (<= (inc x) 10) x)) → (1 2 3 4 5 6 7 8 9 10)

; collect results until nil is returned or 6 results are collected
(set 'x 0)
(collect (if (<= (inc x) 10) x) 6) → (1 2 3 4 5 6)

Vediamo un esempio in cui vogliamo cercare tutti gli indici della sottostringa "abc" nella stringa:

(setq str "abc123abcdef")

(setq idx -1)
(collect (setq idx (find "abc" str nil (+ idx 1))))
;-> (0 6)

Come funziona?
All'inizio "find" cerca "abc" sulla stringa str partendo dall indice 0 (cioè idx + 1).
Se troviamo "abc", allora l'indice di partenza viene aggiornato partendo dall'indice successivo a quello in cui abbiamo trovato "abc" (intanto "collect" salva il valore dell'indice corrente idx).
Se non lo troviamo restituisce nil e "collect" si ferma.

La funzione "collect" acquista importanza quando notiamo che l'espressione "exp" può essere un insieme di espressioni.
Vediamo un altro esempio in cui dobbiamo estrarre i primi quadrati da una lista:

(setq lst '(1 4 9 16 25 36 47 64 81))

(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(collect (begin ; se abbiamo più di una espressione
          (setq kk (pop lst))       ; prima espressione
          (if (square? kk) kk nil)  ; seconda espressione
         )
)
;-> (1 4 9 16 25 36)


---------------------------------------
Ricerca di sottostringhe nelle stringhe
---------------------------------------

Per ricercare le sottostringhe in una stringa possiamo usare le funzioni "find" o "find-all":

(setq s "abc-123-abc-123-xyz")

La funzione "find" trova il primo indice della sottostringa:

(find "abc" s)
;-> 0

La funzione "find-all" trova tutte le occorrenze della sottostringa:
(find-all "abc" s)
;-> ("abc" "abc")

Ma se vogliamo tutti gli indici delle occorrenze di "abc"?

L'idea è quella di utilizzare la funzione "find" con incremento (offset) dell'indice di partenza.
Partiamo dall'indice 0 e cerchiamo la sottostringa.
Se la troviamo aumentiamo l'indice di partenza.
Altrimenti abbiamo terminato la ricerca.

L'incremento dell'indice di partenza dipende dal tipo di ricerca che vogliamo effettuare:
a) se vogliamo ricercare tutte le sottostringhe (anche quelle con caratteri in comune), allora l'incremento vale 1.
Esempio:
sottostringa "ss"
stringa "ssss"
"ssss"
 ss
  ss
   ss
La sottostringa "ss" si trova a partire dagli indici 0, 1 e 2.
b) se vogliamo ricercare solo le sottostringhe con caratteri non in comune, allora l'incremento vale: length(substring) - 1
Esempio:
sottostringa "ss"
stringa "ssss"
"ssss"
 ss
   ss
La sottostringa "ss" si trova a partire dagli indici 0 e 2.

Funzione che ricerca una sottostringa in una stringa:

(define (ref-all1 s str all)
  (local (w idx out)
    (setq w (length s))
    (setq out '())
    (setq idx -1)
    (while (!= idx nil)
      (setq idx (find s str nil (+ idx 1)))
      (if (!= idx nil)
        (begin
          (push idx out -1)
          ; incremento dell indice
          (if (not all) (++ idx (- w 1)))
        )
      )
    )
    out))

(ref-all1 "abc" s)
;-> (0 8)
(ref-all1 "ss" "ssss")
;-> (0 2)
(ref-all1 "ss" "ssss" true)
;-> (0 1 2)

Altra funzione simile che utilizza la funzione "collect":

(define (ref-all2 s str all)
  (local (idx incr)
    (setq idx -1)
    (if all (setq incr 0) (setq incr (- (length s) 1)))
    (collect (begin (setq idx (find s str nil (+ idx 1)))
                    (cond (idx (setq idx (+ idx incr)) ;calcola il nuovo indice
                          (- idx incr)))) ; ma ritorna l'indice trovato
    )))

(ref-all2 "abc" s)
;-> (0 8)
(ref-all2 "ss" "ssss")
;-> (0 2)
(ref-all2 "ss" "ssss" true)
;-> (0 1 2)

La funzione può essere implementata anche senza utilizzare "find" (ma è molto lenta):

(define (ref-all3 s str all)
  (local (out w len i eq)
    (setq out '())
    (setq w (length s))
    (setq len (length str))
    ; per ogni carattere della stringa
    (setq i 0)
    (while (< i len)
      ; se la somma della posizione corrente (i) sulla stringa e
      ; della lunghezza della stringa di ricerca è minore o uguale
      ; della lunghezza della stringa...
      (if (<= (+ i w) len)
        (begin
          ; allora cerchiamo se esiste una corrispondenza
          (setq eq true)
          (for (k 0 (- w 1))
            ;(println k { } i (+ k i))
            ;(println (s k) { } (str (+ i k)))
            ; controllo caratteri da i a (i + k)
            (if (!= (s k) (str (+ i k))) (setq eq nil))
            ;(read-line)
          )
        )
        ;else
        (setq eq nil)
      )
      ; se dalla posizione i-esima tutti i caratteri sono uguali
      ; abbiamo trovato una corrispondenza
      (cond ((= eq true)
              (push i out -1)
              ; incremento indice della stringa
              (if all (++ i)     ; tutte le corrispondenze
                      (++ i w))) ; solo corrispondenze univoche
            (true (++ i))
      )
    )
    out))

(ref-all3 "abc" s)
;-> (0 8)
(ref-all3 "ss" "ssss")
;-> (0 2)
(ref-all3 "ss" "ssss" true)
;-> (0 1 2)

Vediamo la velocità delle tre funzioni:

(setq test "dghnxcjvbhtyc72jnsdfgtycsdajkfhjkasstycsdklhj23178tycsaefjkhastyc")

(= (ref-all1 "tyc" test) (ref-all2 "tyc" test) (ref-all3 "tyc" test))
;-> true

(time (ref-all1 "tyc" test) 1e5)
;-> 174.532
(time (ref-all2 "tyc" test) 1e5)
;-> 123.671
(time (ref-all3 "tyc" test) 1e5)
;-> 6406.902


-----------------------------------
Da testo a parlato (Text to speech)
-----------------------------------

Per trasformare il testo in parlato (cioè una voce che legge il testo) il s.o. macOSX ha la funzione "say" che legge un testo.
Con il s.o. MSwindows possiamo utilizzare il servizio integrato Speech (Microsoft Speech Engine) oppure il programma "Balabolka" (balcon.exe):

https://www.cross-plus-a.com/balabolka.htm

Balabolka Command Line Utility
------------------------------
The utility differs from the desktop application in that it contains no graphical user interface and works only from the command line.
This is useful to integrate the Text-To-Speech process to other applications, for example.

- No installation required.
- Compact.
- Flexible and easy to use.
- Low system requirements.
- Microsoft Speech API 4 and 5 support.

Size: 663 KB
Version: 1.81
Licence: Freeware
Operating System: Microsoft Windows XP/Vista/7/8/10/11
API: SAPI 4, SAPI 5, Microsoft Speech Platform

Vediamo l'help dell'applicazione:

e:\tmp>balcon
Balabolka (Command Line Utility), version 1.81
Copyright (c) 2013-2022 Ilya Morozov

Usage: balcon [options ...]

  -l              : print list of voices
  -g              : print list of audio output devices
  -f <file_name>  : set input text file
  -fl <file_name> : set file with list of input file names
  -w <file_name>  : set output file in WAV format
  -n <voice_name> : set voice for speech
  -id <integer>   : set voice by language code (Locale ID)
  -m              : print voice parameters
  -b <integer>    : set audio output device by index
  -r <text>       : set audio output device by name
  -c              : use text from clipboard
  -t <text>       : use text from command line
  -i              : use text from stdin
  -o              : write sound data to stdout
  -s <integer>    : set rate of speech (from -10 to 10)
  -p <integer>    : set pitch of speech (from -10 to 10)
  -v <integer>    : set volume of speech (from 0 to 100)
  -e <integer>    : pause between sentences (in milliseconds)
  -a <integer>    : pause between paragraphs (in milliseconds)
  -d <file_name>  : apply dictionary for pronunciation correction
  -k              : kill other copies of application
  -ka             : kill active copy of application
  -pr             : pause or resume reading by active copy of application
  -q              : add application to queue
  -lrc            : create LRC file to display synchronized text in audio players
  -srt            : create SRT file to display synchronized text in video players
  -vs <file_name> : create text file with synchronized visemes
  -sub            : process input text as subtitles
  -tray           : show icon in system tray
  -ln <integer>   : select line by number (or range, e.g. 12-79)
  -fr <integer>   : set output audio sampling frequency in kHz (from 8 to 48)
  -bt <integer>   : set output audio bit depth (8 or 16)
  -ch <integer>   : set output audio channel mode (1 or 2)
  -enc <encoding> : set input text encoding (ansi, utf8 or unicode)
  -sb <integer>   : silence at the beginning (in milliseconds)
  -se <integer>   : silence at the end (in milliseconds)
  -df             : delete text file when job is done
  -dp             : display progress information
  -isb            : ignore text in square brackets
  -icb            : ignore text in curly brackets
  -iab            : ignore text in angle brackets
  -irb            : ignore text in round brackets
  -iu             : ignore URLs
  -ic             : ignore /*comments*/ in text
  -h              : print usage information

  --lrc-length <integer>  : set max length of text lines for output LRC file
  --lrc-fname <file_name> : set filename for output LRC file
  --lrc-enc <encoding>    : set encoding for output LRC file
  --lrc-offset <integer>  : set time offset for output LRC file (in milliseconds)
  --lrc-artist <text>     : artist (ID tag)
  --lrc-album <text>      : album (ID tag)
  --lrc-title <text>      : title (ID tag)
  --lrc-author <text>     : author (ID tag)
  --lrc-creator <text>    : creator of LRC file (ID tag)
  --lrc-sent              : insert blank lines after sentences in LRC file
  --lrc-para              : insert blank lines after paragraphs in LRC file
  --srt-length <integer>  : set max length of text lines for output SRT file
  --srt-fname <file_name> : set filename for output SRT file
  --srt-enc <encoding>    : set encoding for output SRT file
  --raw                   : output is raw PCM data (headerless)
  --ignore-length         : omit length of audio data in WAV header
  --sub-format <text>     : set format of subtitles (for input text)
  --sub-fit               : increase speech rate to fit time intervals in subtitles
  --sub-max <integer>     : set max rate of speech for subtitles

  --voice1-name <voice_name>    : set voice to read foreign words in text
  --voice1-langid <language_id> : set language ID for foreign text (e.g. en)
  --voice1-rate <integer>       : set rate of speech for foreign text (from -10 to 10)
  --voice1-pitch <integer>      : set pitch of speech for foreign text (from -10 to 10)
  --voice1-volume <integer>     : set volume of speech for foreign text (from 0 to 100)
  --voice1-roman                : use default voice to read Roman numerals
  --voice1-digit                : use default voice to read numbers in foreign text
  --voice1-length <integer>     : set min length of foreign text to change voice

Il modo più semplice per usare il programma è il seguente:

  balcon.exe -t <text>

Facciamo un esempio:

(define (spell num)
  (local (out eng)
    (setq out "")
    (setq eng '(("0" "zero")("1" "one")("2" "two")("3" "three")("4" "four")
                ("5" "five")("6" "six")("7" "seven")("8" "eight")("9" "nine")))
    ;(setq ita '(("0" "zero")("1" "uno")("2" "due")("3" "tre")("4" "quattro")
    ;        ("5" "cinque")("6" "sei")("7" "sette")("8" "otto")("9" "nove")))
    (dolist (digit (explode (string num)))
      (extend out (lookup digit eng) ", "))
    (chop out 2)))

(spell "345180018")
;-> "three, four, five, one, eight, zero, zero, one, eight""

Per lanciare "balcon.exe" utilizziamo la primitiva "exec".

Poichè il testo da leggere deve essere racchiuso da doppi apici "", possiamo scrivere:

(println (string "e:\\tmp\\balcon -t " "\"" (spell "345180018") "\""))
;-> e:\tmp\balcon -t "three, four, five, one, eight, zero, zero, one, eight"

Sostituiamo "exec" a "println" ed ascoltiamo i numeri:

(exec (string "e:\\tmp\\balcon -t " "\"" (spell "345180018") "\""))
;-> ()

Oppure direttamente con una stringa:

(exec (string "e:\\tmp\\balcon -t " "\"" "newlisp is fun" "\""))
;-> ()

Possiamo anche utilizzare la clipboard con l'opzione -c.

Copiare il testo della linea seguente:
This is the text on clipboard

ed eseguire il seguente comando dalla REPL:

(exec "e:\\tmp\\balcon -c")

Nota: è anche possibile modificare il tipo di voce e il linguaggio utilizzato.


-----------------------------------------------
Angoli interni ed esterni dei poligoni regolari
-----------------------------------------------

Calcolare gli angoli interni e gli angoli esterni di un poligono regolare di N lati.

Un poligono regolare è un poligono convesso che è sia equilatero (cioè ha tutti i lati uguali fra loro), che equiangolo (cioè ha tutti gli angoli uguali fra loro).

Ogni angolo interno di un poligono vale (1 - 2/n)*180 = 180 - 360/n gradi.
Pertanto la somma degli angoli interni è (n - 2)*180.

Esempi:
In un triangolo equilatero l'angolo interno vale 60 gradi.
In un quadrato l'angolo interno vale 90 gradi.
In un pentagono l'angolo interno vale 108 gradi.
...

Gli angoli esterni invece misurano 360/n gradi.
Pertanto la somma degli angoli interni è 360 gradi.

Adesso possiamo facilmente scrivere le due funzioni:

(define (interno lati) (sub 180 (div 360 lati)))

(define (esterno lati) (div 360 lati))

(map (fn(x) (list x (interno x) (esterno x))) '(3 4 5 6 7 8 9 10))
;-> ((3 60 120)
;->  (4 90 90)
;->  (5 108 72)
;->  (6 120 60)
;->  (7 128.5714285714286 51.42857142857143)
;->  (8 135 45)
;->  (9 140 40)
;->  (10 144 36))

Nota: Non tutti i poligoni regolari sono costruibili con riga e compasso.
Condizione necessaria e sufficiente perché ciò accada è che i fattori primi dispari del numero di lati siano primi di Fermat distinti.
Per esempio, il triangolo equilatero, il quadrato, il pentagono e l'esagono regolari sono costruibili con riga e compasso, mentre l'ettagono regolare non lo è.


---------------
Segni zodiacali
---------------

Scriviamo una funzione che dato il mese e il giorno di nascita determina il relativo segno zodiacale.

Periodi dei segni zodiacali
---------------------------
  Ariete,     21 marzo - 19 aprile,      21/3 - 19/4
  Toro,       20 aprile - 20 maggio,     20/4 - 20/5
  Gemelli,    21 maggio - 20 giugno,     21/5 - 20/6
  Cancro,     21 giugno - 22 luglio,     21/6 - 22/7
  Leone,      23 luglio - 23 agosto,     23/7 - 23/8
  Vergine,    24 agosto - 22 settembre,  24/8 - 22/9
  Bilancia,   23 settembre - 22 ottobre, 23/9 - 22/10
  Scorpione,  23 ottobre - 21 novembre,  23/10 - 21/11
  Sagittario, 22 novembre - 21 dicembre, 22/11 - 21/12
  Capricorno, 22 dicembre - 19 gennaio,  22/12 - 19/1
  Acquario,   20 gennaio - 19 febbraio,  20/1 - 19/2
  Pesci,      20 febbraio - 20 marzo,    20/2 - 20/3

Codifichiamo i valori nel modo seguente: (mese * 100) + giorno

Acquario,   120 - 219
Pesci,      220 - 320
Ariete,     321 - 419
Toro,       420 - 520
Gemelli,    521 - 620
Cancro,     621 - 722
Leone,      723 - 823
Vergine,    824 - 922
Bilancia,   923 - 1022
Scorpione,  1023 - 1121
Sagittario, 1122 - 1221
Capricorno, 1222 - 119

(define (zodiaco giorno mese)
  (let (val (+ (* mese 100) giorno))
    (cond ((and (>= val 120) (<= val 219)) "Acquario")
          ((and (>= val 220) (<= val 320)) "Pesci")
          ((and (>= val 321) (<= val 419)) "Ariete")
          ((and (>= val 420) (<= val 520)) "Toro")
          ((and (>= val 521) (<= val 620)) "Gemelli")
          ((and (>= val 621) (<= val 722)) "Cancro")
          ((and (>= val 723) (<= val 823)) "Leone")
          ((and (>= val 824) (<= val 922)) "Vergine")
          ((and (>= val 923) (<= val 1022)) "Bilancia")
          ((and (>= val 1023) (<= val 1121)) "Scorpione")
          ((and (>= val 1122) (<= val 1221)) "Sagittario")
          ((or (>= val 1022) (<= val 119)) "Capricorno"))))

Facciamo alcune prove:

(zodiaco 25 12)
;-> "Capricorno"
(zodiaco 26 12)
;-> "Capricorno"
(zodiaco 27 12)
;-> "Capricorno"
(zodiaco 19 1)
;-> "Capricorno"
(zodiaco 20 1)
;-> "Acquario"
(zodiaco 21 12)
;-> "Sagittario"
(zodiaco 21 01)
;-> "Acquario"
(zodiaco 21 02)
;-> "Pesci"
(zodiaco 20 02)
;-> "Pesci"
(zodiaco 19 02)
;-> "Acquario"
(zodiaco 19 02)
;-> "Acquario"
(zodiaco 6 10)
;-> "Bilancia"


-----------------
Astrologia cinese
-----------------

Uno dei cicli su cui si basa l'astrologia cinese è di dodici anni, ognuno dei quali corrisponde a un segno dello zodiaco:

Topo: I nati sotto questo segno sono dotati di fascino ed hanno capacità di attrarre. Sono anche grandi lavoratori.
Bufalo o Bue: I nati sotto questo segno sono pazienti e poco loquaci, ma ispirano grande fiducia.
Tigre: I nati sotto questo segno sono sensibili ed hanno una notevole profondità di pensiero, sono coraggiosi.
Coniglio o Lepre (兔 Tù). I nati sotto questo segno hanno molto talento e sono ambiziosi. Dimostrano notevole capacità negli affari.
Drago: I nati sotto questo segno godono di buona salute e dispongono di grandi energie, ma sono alquanto testardi.
Serpente: I nati sotto questo segno parlano poco, sono molto saggi e generosi.
Cavallo: I nati sotto questo segno sono simpatici e molto gioiosi, ma rischiano di parlare un po' troppo.
Capra o Pecora: I nati sotto questo segno sono eleganti ed hanno notevoli capacità artistiche.
Scimmia: I nati sotto questo segno sono imprevedibili, inventivi, abili, e flessibili.
Gallo: I nati sotto questo segno sono sempre affaccendati e ritengono di avere sempre ragione, anche se qualche volta sbagliano.
Cane: I nati sotto questo segno sono fedeli e leali, talvolta anche egoisti ed eccentrici.
Maiale o Cinghiale: I nati sotto questo segno sono coraggiosi e cavallereschi, non arretrano mai e si dimostrano gentili con il prossimo.

La sequenza del ciclo è la seguente:

  0) Scimmia,
  1) Gallo,
  2) Cane,
  3) Maiale,
  4) Topo,
  5) Bufalo,
  6) Tigre,
  7) Coniglio,
  8) Drago,
  9) Serpente,
 10) Cavallo,
 11) Capra,

Quindi basta prendere l'anno e calcolare il modulo 12: (mod anno 12)

(define (cinese anno)
 ('("Scimmia" "Gallo" "Cane" "Maiale" "Topo" "Bufalo" "Tigre"
           "Coniglio" "Drago" "Serpente" "Cavallo" "Capra") (% anno 12)))

Facciamo alcune prove:

(cinese 1963)
;-> "Coniglio"

(cinese 1965)
;-> "Serpente"

(cinese 1998)
;-> "Tigre"

(map (fn(x) (println x { } (cinese x))) (sequence 2000 2023))
;-> 2000 Drago
;-> 2001 Serpente
;-> 2002 Cavallo
;-> 2003 Capra
;-> 2004 Scimmia
;-> 2005 Gallo
;-> 2006 Cane
;-> 2007 Maiale
;-> 2008 Topo
;-> 2009 Bufalo
;-> 2010 Tigre
;-> 2011 Coniglio
;-> 2012 Drago
;-> 2013 Serpente
;-> 2014 Cavallo
;-> 2015 Capra
;-> 2016 Scimmia
;-> 2017 Gallo
;-> 2018 Cane
;-> 2019 Maiale
;-> 2020 Topo
;-> 2021 Bufalo
;-> 2022 Tigre
;-> 2023 Coniglio
;-> ("Drago" "Serpente" "Cavallo" "Capra" "Scimmia" "Gallo" "Cane" "Maiale" "Topo" "Bufalo"
;->  "Tigre" "Coniglio" "Drago" "Serpente" "Cavallo" "Capra" "Scimmia" "Gallo" "Cane"
;->  "Maiale" "Topo" "Bufalo" "Tigre" "Coniglio")


-------------
Ultraradicale
-------------

L'Ultraradicale (o radicale Bring) di un numero reale "a" è l'unica radice reale della seguente equazione di quinto grado:

  x^5 + x + a = 0

Metodo di Newton-Raphson con un numero fisso di iterazioni e utilizzo di (5x^4 + 5) come approssimazione di f'(x) = 5x^4 + 1.

(define (solve a)
  (setq x (div a 5))
  (dotimes (i 100)
    (setq x (sub x (div (add (div a (add (mul x x x x) 1)) x) 5)))
  )
  x)

Facciamo alcune prove:

(solve -100010)
;-> 10
(solve 0)
;-> 0
(solve 1)
;-> -0.7548776662466926
(solve -1)
;-> 0.7548776662466926
(solve 1.414213562)
;-> -0.8816165664970691
(solve 3.141592653)
;-> -1.147965385466847
(solve -9.515716566)
;-> 1.515716566491764
(solve 10)
;-> -1.533012798646983
(solve -100)
;-> 2.499203570440939
(solve 1000)
;-> -3.977899393311168


-------------------------------------------------------------
Da stringa a numero di colonna e viceversa (colonne di Excel)
-------------------------------------------------------------

Nei fogli elettronici (per esempio MS Excel), le colonne vanno da A-Z, AA, AB, AZ, BA, ... ,BZ e così via.
In realtà ciascuna di esse rappresentano un numero, ma sono codificate come stringhe alfabetiche.

Data una stringa che rappresenta una colonna, scrivere una funzione che restituisce il numero corrispondente.

Per esempio:

  "A" restituisce 1 (il che significa che è la prima colonna)
  "B" restituisce 2
  "Z" restituisce 26
  "AA" restituisce 27
  "AB" restituisce 28
  "AZ" restituisce 52
  "ZZ" restituisce 702
  "AAA" restituisce 703

(define (column-value col)
  (let (x 0)
    ; simile ad una conversione da base-26 a base-10
    (dostring (c col)
      (setq x (+ (* x 26) c -64))
    )
    x))

Facciamo alcune prove:

(column-value "BZ")
;-> 78
(column-value "CA")
;-> 79
(column-value "ZZ")
;-> 702
(column-value "ZZZZZZZZZZ")
;-> 146813779479510

(setq lst '("A" "B" "Z" "AA" "AB" "AZ" "ZZ" "AAA" "ABC"))
(map (fn(x) (list x (column-value x))) lst)
;-> (("A" 1) ("B" 2) ("Z" 26) ("AA" 27) ("AB" 28)
;->  ("AZ" 52) ("ZZ" 702) ("AAA" 703) ("ABC" 731))

Possiamo anche scrivere la funzione inversa, cioè una funzione che, dato un numero, restituisce il valore stringa della colonna.

Esempio:
Numero = 28
Calcoliamo il resto del numero:
(% 28 26)
;-> 2
Se il resto di 26 risulta essere 0 (ovvero 26, 52 e così via), inseriamo "Z" nella stringa di output e il nuovo numero diventa numero/26 - 1 perché qui stiamo considerando 26 come 'Z' mentre in realtà è il 25esimo rispetto ad "A".
Se il resto risulta essere diverso da zero (come 1, 2, 3 ecc.), occorre inserire nella stringa il carattere relativo e poi calcolare:
numero = numero/26.
Al termine occorre invertire la stringa.

Esempio:
Numero = 700
Il resto (numero % 26) è 24. Quindi inseriamo "X" nella stringa di output e numero diventa numero/26 che è 26.
Il resto (26 % 26) è 0. Quindi inseriamo "Z" nella stringa di output e numero diventa numero/26 - 1 che è 0.
Invertiamo la stringa e otteniamo: "ZX"

(define (column-string num)
  (local (str rem)
    (setq str "")
    (while (> num 0)
      ; calcola il resto
      (setq rem (% num 26))
      (cond ((zero? rem) ; rem = 0 --> "Z"
              (extend str "Z")
              (setq num (- (/ num 26) 1)))
            (true ; rem != 0 --> indexed char
              (extend str (char (+ (- rem 1) (char "A"))))
              (setq num (/ num 26)))
      )
    )
    (reverse str)))

Facciamo alcune prove:

(column-string 1)
;-> "A"
(column-string 78)
;-> "BZ"
(column-string 79)
;-> "CA"
(column-string 705)
;-> "AAC"
(column-string 702)
;-> "ZZ"
(column-string 146813779479510)
;-> "ZZZZZZZZZZ"
(column-string 1234567890)
;-> "CYWOQVJ"

(setq numbers '(1 2 26 27 28 52 702 703 731))
(map (fn(x) (list x (column-string x))) numbers)
;-> ((1 "A") (2 "B") (26 "Z") (27 "AA") (28 "AB")
;->  (52 "AZ") (702 "ZZ") (703 "AAA") (731 "ABC"))


-----------------------------------
Cifre in lettere e lettere in cifre
-----------------------------------

Dato un numero intero convertire le sue cifre in lettere:
1 --> one, 2 --> two ecc.

  1234567890  -->  "one two three four five six seven eight nine zero"

Data una stringa di cifre in lettere convertire le sue cifre in numeri:
"one" --> 1, "two" --> 2, ecc.
Le cifre della stringa di input sono separate da una spazio " ".

  "one two three four five six seven eight nine zero"  -->  1234567890

Funzione che converte da cifre a lettere:

(define (cifre-lettere num)
  (local (out eng)
    (setq out "")
    (setq eng '(("0" "zero") ("1" "one") ("2" "two") ("3" "three")
                ("4" "four") ("5" "five") ("6" "six") ("7" "seven")
                ("8" "eight") ("9" "nine")))
    ;(setq ita '(("0" "zero") ("1" "uno") ("2" "due") ("3" "tre")
    ;            ("4" "quattro") ("5" "cinque") ("6" "sei")
    ;            ("7" "sette") ("8" "otto") ("9" "nove")))
    (dolist (digit (explode (string num)))
      (extend out (lookup digit eng) " ")
    )
    (chop out 1)))

(cifre-lettere 1234567890)
;-> "one two three four five six seven eight nine zero"

Funzione che converte da lettere a cifre:

(define (lettere-cifre str)
  (local (out eng lst)
    (setq out 0)
    (setq eng '(("zero" 0) ("one" 1) ("two" 2) ("three" 3)
                ("four" 4) ("five" 5) ("six" 6) ("seven" 7)
                ("eight" 8) ("nine" 9)))
    (setq lst (parse str " "))
    ;(setq ita '(("zero" 0) ("uno" 1) ("due" 2) ("tre" 3)
    ;            ("quattro" 4) ("cinque" 5) ("sei" 6) ("sette" 7)
    ;            ("otto" 8) ("nove" 9))
    (dolist (cifra (reverse lst))
      (setq out (+ out (*  (lookup cifra eng) (pow 10 $idx))))
    )
    out))

(lettere-cifre "one two three four five six seven eight nine zero")
;-> 1234567890

(lettere-cifre (cifre-lettere 2023))
;-> 2023

(cifre-lettere (lettere-cifre "three zero seven seven"))
;-> "three zero seven seven"


-----------------------
Resistenze in parallelo
-----------------------

Due resistenze R1 e R2 in parallelo (R1||R2) hanno una resistenza totale pari a:

            1          R1 * R2
  R = ------------- = ---------
       1/R1 + 1/R2     R1 + R2

Nota che R < (min (R1 R2)), cioè la resistenza totale è minore della resistenza più piccola tra R1 e R2.

Tre resistenze R1, R2 e R3 in parallelo hanno una resistenza totale pari a:

                                R1 * R2
                               --------- * R3
               1                R1 + R2
  R = -------------------- = ------------------
       1/R1 + 1/R2 + 1/R3       R1 * R2
                               --------- + R3
                                R1 + R2

In generale N resistenze in parallelo hanno una resistenza totale pari a:

                  1
  R = --------------------------
       1/R1 + 1/R2 + ... + 1/RN

Per esempio:

  Resistenze                            Parallelo
  (1,1) ----------------------------->  0.5

  (1,1,1) --------------------------->  0.3333333

  (4,6,3) --------------------------->  1.3333333

  (20,14,18,8,2,12) ----------------->  1.1295

  (10,10,20,30,40,50,60,70,80,90) --->  2.6117

Scrivere una funzione che data una lista di resistenze, calcola la resistenza totale quando sono messe tutte in parallelo.

(define (res-par lst) (div (apply add (map div lst))))

Facciamo alcune prove:

(res-par '(1 1))
;-> 0.5
(res-par '(1 1 1))
;-> 0.3333333333333333
(res-par '(4 6 3))
;-> 1.333333333333333
(res-par '(20 14 18 8 2 12))
;-> 1.129538323621694
(res-par '(10 10 20 30 40 50 60 70 80 90))
;-> 2.611669603067675

Data un'insieme di resistenze quanti valori possiamo ottenere da tutte le loro combinazioni?

(define (comb k lst (r '()))
"Generates all combinations of k elements without repetition from a list of items"
  (if (= (length r) k)
    (list r)
    (let (rlst '())
      (dolist (x lst)
        (extend rlst (comb k ((+ 1 $idx) lst) (append r (list x)))))
      rlst)))

(define (parallel lst)
  (local (prove out)
    (setq out '())
    (for (k 2 (length lst))
      (setq prove (comb k lst))
      (dolist (p prove) (push (list (round (res-par p) -4) p) out))
    )
    (sort out)))

Facciamo alcune prove:

(parallel '(10 20 30))
;-> ((5.4545 (10 20 30)) (6.6667 (10 20)) (7.5 (10 30)) (12 (20 30)))

(parallel '(10 20 30 40 50))
;-> ((4.3796 (10 20 30 40 50)) (4.8 (10 20 30 40)) (4.918 (10 20 30 50))
;->  (5.1282 (10 20 40 50)) (5.4545 (10 20 30)) (5.6075 (10 30 40 50))
;->  (5.7143 (10 20 40)) (5.8824 (10 20 50)) (6.3158 (10 30 40))
;->  (6.5217 (10 30 50)) (6.6667 (10 20)) (6.8966 (10 40 50)) (7.5 (10 30))
;->  (7.7922 (20 30 40 50)) (8 (10 40)) (8.3333 (10 50)) (9.2308 (20 30 40))
;->  (9.6774 (20 30 50)) (10.5263 (20 40 50)) (12 (20 30)) (12.766 (30 40 50))
;->  (13.3333 (20 40)) (14.2857 (20 50)) (17.1429 (30 40)) (18.75 (30 50))
;->  (22.2222 (40 50)))

(length (parallel (sequence 1 10)))
;-> 1013

Vedi anche "Coppie di resistenze in serie e in parallelo" su "Note libere 25".


-------------------------------------------
Punti casuali sulla superficie di una sfera
-------------------------------------------

Dobbiamo generare punti (x,y,z) e assicurarci che giacciano sulla superficie della sfera il cui centro è (0,0,0) e il cui diametro è R.

L'uso della distribuzione gaussiana per tutte e tre le coordinate del punto garantirà una distribuzione uniforme sulla superficie della sfera.
Si può procedere come segue:

1) Generare tre numeri casuali x,y,z utilizzando la distribuzione gaussiana.
2) Moltiplicare ciascun numero per sqrt(1/x^2+y2^+z^2) (ovvero Normalizzare).
   (gestire cosa succede se x=y=z=0).
3) Moltiplicare ogni numero per il raggio della tua sfera.
4) Opzionale: verificare che la distanza tra (0,0,0) e (x,y,z) sia R.

(define (dist3d x1 y1 z1 x2 y2 z2)
"Calculates 3D Cartesian distance of two points P1=(x1 y1 z1) e P2=(x2 y2 z2)"
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2))
             (mul (sub z1 z2) (sub z1 z2)))))

(define (cbrt x)
"Calculates the cube root of a number"
  (if (< x 0)
      (sub (pow (sub x) (div 3)))
      ;else (positive number)
      (pow x (div 3))))

Funzione che genera un punto che giace sulla superficie di una sfera con centro in (0,0,0) e raggio "radius":

(define (rnd-pts radius)
  (local (x y z norm))
    ; generazione di tre numeri random con distribuzione Gaussiana (Normale)
    (setq x (normal))
    (setq y (normal))
    (setq z (normal))
    ; Normalizzazione dei numeri
    (setq norm (sqrt (div (add (mul x x) (mul y y) (mul z z)))))
    (setq x (mul x norm))
    (setq y (mul y norm))
    (setq z (mul z norm))
    ; Moltiplicazione delle coordinate per il raggio della sfera
    (setq x (mul x radius))
    (setq y (mul y radius))
    (setq z (mul z radius))
    ; output: coordinate del punto + distanza del punto dal (0,0,0)
    ; (la distanza deve essere uguale al raggio della sfera)
    (list x y z (dist3d x y z 0 0 0)))

Facciamo alcune prove:

(chop '(1 2 3 4))

(rnd-pts 2)
;-> (1.210846481698793 -1.246459613513464 -0.9900450644478368 2)
(rnd-pts 10)
;-> (-0.5026408937663467 7.08095359093341 -7.043255523900934 10)

Creiamo 500 punti sulla superficie di una sfera di raggio 10:

(silent
  (setq lst (map rnd-pts (dup 10 500)))
  (setq lst (map chop lst))
)

Esportiamo i punti:

(save "sfera500.txt" 'lst)
;-> true

Modifichiamo il file "sfera500.txt" in modo che ogni riga sia solo: x y z

Da cosi:

(set 'lst '(
  (5.487372834479757 -2.828667854941998 7.86685309013912)
  (-3.797452898396809 -3.433214776138425 8.590249576430388)
  (9.851332250951074 0.2207698136576774 -1.703676486528114)
...
  (-4.707549026292338 2.932130536376371 8.321153326474839)
  (4.671114410263778 8.70936815849182 1.525646238836153)))

A cosi:

5.487372834479757 -2.828667854941998 7.86685309013912
-3.797452898396809 -3.433214776138425 8.590249576430388
9.851332250951074 0.2207698136576774 -1.703676486528114
...
-4.707549026292338 2.932130536376371 8.321153326474839
4.671114410263778 8.70936815849182 1.525646238836153

Il file "sfera500.txt" si trova nella cartella "data".

Visualizziamo il file con Octeve con il seguente script "sfera500.m":

  data = load('sfera500.txt');
  figure;
  scatter3(data(:,1), data(:,2), data(:,3), 'filled');
  title('3D Plot');
  xlabel('X-axis');
  ylabel('Y-axis');
  zlabel('Z-axis');
  axis equal;

Esportiamo l'immagine dalla figura di Octave: File -> Save As...

Vedi lo script "sfera500.m" e l'immagine "sfera500.png" nella cartella "data".


----------------------------------------
newLISP per VisualNEO Win. Parte 0: Info
----------------------------------------
Copyright: SinLios Soluciones Digitales. All rights reserved. sinlios.com

visualNEO
---------
https://visualneo.com/
VisualNEO Win, è un software per generare app eseguibili di Windows.
Sviluppa tu stesso le app Windows con VisualNEO Win.
Utilizza il linguaggio NeoScript, il linguaggio di programmazione più semplice, per codificare la logica delle tue App.
Rimarrai sorpreso da quanto sia facile sviluppare le tue applicazioni Windows con VisualNEO Win.
E le tue app possono essere vendute o condivise!
I progetti VisualNEO Win completati possono essere compilati in un'applicazione Windows compatta e autonoma (exe) per una facile distribuzione.
Per eseguire le applicazioni compilate non sono necessari lettori, driver speciali, licenze o software aggiuntivo.
Le applicazioni create da VisualNEO Win appaiono e si comportano proprio come qualsiasi altro programma Windows, quindi nessuno ha bisogno di sapere che non hai faticato per anni imparando Java o C++.

newLISP
-------
http://www.newlisp.org/
Reinier Maliepaard ha scritto alcuni tutorial su questo interessante linguaggio di programmazione per VisualNEO Win.

Questa è una serie di 5 tutorial su newLISP scritti da Reinier Maliepaard e tradotti da me.
I tutorial si trovano (in inglese) al seguente indirizzo web:
https://visualneo.com/newlisp


--------------------------------------------
newLISP per VisualNEO Win. Parte 1: Iniziare
--------------------------------------------

newLISP è stato compilato in una DLL di Windows (libreria a collegamento dinamico): newLISP.dll.
Hans Peter Wickern ha creato un plugin gratuito per VisualNeo Win che rende possibile l'uso di newLISP all'interno del generatore di applicazioni GUI VisualNeo Win (scaricare hpwNewLISP da https://visualneo.com/product/hpwnewlisp).

Perché utilizzare newLISP?
a. codice più breve ed efficiente, ad es. combinando le funzioni in un unico comando
b. in molti casi, prestazioni più veloci, ad es. in caso di cicli annidati
c. più di 350 funzioni integrate
d. le funzioni possono essere combinate in un unico comando
e. ottimo uso delle espressioni regolari
f. Le applicazioni VisualNeo con newLISP funzionano bene e velocemente sotto Wine/Linux (al contrario di VBScript, che spesso si blocca).
g. newLISP è testato molto bene, quindi i bug saranno rari.

E citando lo sviluppatore Lutz Mueller:

newLISP si carica rapidamente e ha un ingombro di memoria ridotto.
newLISP è veloce quanto altri linguaggi di scripting popolari e utilizza pochissime risorse.

Distribuzione
-------------
Sebbene newLISP sia concesso in licenza come GPL 3.0, l'autore di newLISP Lutz Mueller ti consente di distribuire newLISP.dll insieme al tuo binario VisualNeo Win, senza dover rilasciare il codice newLISP sotto GPL 3.0 (restrizione: "purché i tuoi script non utilizzino altro software di terze parti protetto da GPL sotto forma di librerie importate o moduli caricati, i tuoi script newLISP non necessitano di licenza GPL.")
http://www.newLISP.org/index.cgi?FAQ

Quando si utilizza newLISP nel proprio software, menzionare sempre il sito Web www.newlisp.org nella documentazione come luogo in cui è disponibile il codice sorgente per newLISP.

Per far funzionare la tua applicazione per gli utenti, devi solo distribuire il tuo binario VisualNeo, insieme a newLISP.dll e hpwNewLISP.nbr gratuito (che si trova nel pacchetto plugin di Hans-Peter Wickern. Scarica: https://visualneo.com/ prodotto/hpwnewlisp).

Utilizzare codice newLISP in VisualNeo Win
------------------------------------------
Per testare gli esempi di VisualNeo Win è necessario scaricare hpwNewLISP da https://visualneo.com/product/hpwnewlisp e installare il plugin.
Crea una cartella, ad es. D:\mcNewLISP e inserirvi il mio esempio 'mcTestNewLISP.exe', risorse necessarie incluse (www.mcdigit.nl/mcTestnewLISP.zip).

Prova le istruzioni e gli esempi seguenti e acquisirai familiarità con l'uso di newLISP in "mcTestNewLISP.exe".

Nota che a volte devi sostituire "" (doppio apostrofo) con { e } (o con [#34]) e talvolta [ con [#91] e ] con [#93].
Faccio un'osservazione su quando questo è necessario per gli esempi newLISP presentati qui.

1. Primi passi con newLISP
--------------------------
In questo blog non troverai alcuna discussione estesa sugli argomenti di sintassi di newLISP.
Fornisco solo informazioni su newLISP utili per te come utente VisualNeo.
Iniziamo con le chiamate di funzione, che ti offrono molte possibilità.

Si noti che newLISP fa distinzione tra maiuscole e minuscole e utilizza (per esempio) i nomi delle funzioni in minuscolo!

1.1. Sintassi delle chiamate di funzioni
----------------------------------------
Le chiamate di funzione in newLISP hanno una sintassi semplice e coerente.
Studia il prossimo tipo di espressione Lisp, composto da parentesi bilanciate e uno o più elementi:

  (nome-funzione argomento-1 argomento-2 ... argomento-n)

Un esempio utilizzando questo modello è:

(add 2 3.5)
;-> 5.5

Questa espressione Lisp contiene una chiamata alla funzione 'add' con due argomenti, ovvero 2 e 3.5.
Il valore restituito è 5.5.

Tieni presente che
– gli argomenti sono facoltativi
– alcune funzioni non necessitano di argomenti e altre funzioni >= 1

1.2. Tutte le funzioni in newLISP restituiscono un valore
--------------------------------------------
Eseguire l'applicazione di esempio VisualNeo 'mcTestNewLISP.exe' e inserire l'espressione

(add 2 3.5)
;-> 5.5

nel primo campo di testo, premi il pulsante 'Call Lisp' e il secondo campo di testo mostrerà il risultato, il valore 5.5.

Infatti, verrà eseguito il seguente codice VisualNeo Win:

  hpwnewLISPCall "(aggiungi 2 3.5)" "[DllRetvar]"

Il risultato verrà valutato tramite:

  If "[nlcError]" "=" ""
   SetVar "[LispReturn]" "[DllRetvar]"
  Else
   SetVar "[LispReturn]" "Error: [nlcError]"
  Endif

Inserisci ora l'espressione errata

(add 2 3.5

nel primo campo di testo (quindi senza parentesi bilanciate) e premere il pulsante 'Call Lisp'.
Il secondo campo di testo mostra il risultato, il messaggio Errore:

6 ERR: missing parenthesis : "...(add 2 3.5"

1.2.1 Evaluation of all arguments first
---------------------------------------
newLISP valuta innanzitutto gli argomenti, prima che la funzione venga applicata agli argomenti.

(+ 2 (- 6 3) (+ 3 4))
;-> 17

Si noti che ";->" significa 'restituisce il valore:'.

I passaggi in questo esempio:

(+ 2 (- 6 3) (* 3 4))

(- 6 3)
;-> 3

(* 3 4)
;->  12

(+ 2 3 12)
;->  17

Pertanto, le espressioni (- 6 3) e (* 3 4) vengono valutate prima di essere inviate alla funzione.

Questi esempi di matematica non sono molto utili per te (VisualNeo ha semplici alternative) ma erano intesi solo come dimostrazione della sintassi elementare newLISP.
Naturalmente presenterò nella sezione '4. Esercizi ed esempi' alcuni interessanti esempi di matematica.

2. Le funzioni possono essere combinate
---------------------------------------
(div 8 3 2 2)
;->  0.6666666666666666

(round (div 8 3 2 2) -2)
;->  0.67

(add (round (div 8 3 2 2) -2) 5)
;->  5.67

3. TRUE o NIL
-------------
Alcune funzioni restituiscono TRUE o NIL.
Per verificare che tutti i numeri siano ordinati in modo crescente, potremmo scrivere:

(<2 3 5 7 8)

che restituisce TRUE.

(<2 3 5 4 8)

restituisce NIL, che è l'equivalente newLISP di FALSE.

4. Esercizi ed esempi
---------------------
Per completezza, le funzioni add, sub, mul e div restituiscono un numero mobile se uno degli operandi è un numero in virgola mobile.
Il numero in virgola mobile viene visualizzato senza decimali se i decimali sono tutti 0.

(add 2 3.25 9.75)
;->  15

> (float? (add 2 3.25 9.75))
;->  true

Per l'aritmetica degli interi è anche possibile utilizzare +, -, *, /.
Solo per chiarezza, ti presento queste chiamate di funzioni, che puoi modificare a tuo piacimento.

> (* 4.5 7.5)
;->  28

> (mul 4.5 7.5)
;->  33.75

(format "%2.1f" (* 4.5 7.5))
;->  28.0

Le seguenti funzioni sono più utili per te.
Si prega di controllare http://www.newlisp.org/downloads/manual_frame.html per la sintassi precisa delle funzioni.

4.1 Aritmetica di base
----------------------
(max 2 1.5 3 2.7)
;->  3

(min 2 1.5 3 2.7)
;->  1.5

(log (exp 3))
;->  3
(log 100 10)
;->  2

(pow 100 2)
;->  10000

(pow 100 0.5)
;->  10

(pow 100 0.5 3)
;->  1000

(% 10 3)
;->  1

(% -10 3)
;->  -1

(mod 10.5 3.3)
;->  0.6

(mod -10.5 3.3)
;->  -0.6

(mod -10.5 1)
;->  -0.5

è equivalente a (mod -10.5)

(inc 0.25)
;->  1.25

(dec 9 0.25)
;->  8.75

(NaN? (sqrt -1))
;->  true

(NaN? (div 0 0))
;->  true

(inf? (div 1 0))
;->  true

4.2 Funzioni trigonometriche
----------------------------
Funzioni disponibili:

  acos, acosh, asin, asinh, atan, atanh, atan2, cos, cosh, sin, sinh, tan, tanh

(acos 1)
;->  0

(acosh 2)
;->  1.316957897

(cosh (acosh 2))
;->  2

(NaN? (acosh 0.5))
;->  true

4.3 Arrotondamento
------------------
(round 123.49 2)
;->  100

(round 123.49 1)
;->  120

(round 123.49 0)
;->  123

(round 123.49)
;->  123

(round 123.49 -1)
;->  123.5

(round 123.49 -2)
;->  123.49

(ceil -1.5)
;->  -1

(ceil 3.4)
;->  4

(floor -1.5)
;->  -2

(floor 3.4)
;->  3

4.4 Selezioni casuali (random)
------------------------------
(rand 3)
could generate 0 or 1 or 2

(rand 3 10)
could generate (2 2 0 2 2 1 0 0 2 1)

(random 0 1 4) could generate
could generate (0.1555528427991577 0.5039216284676656 0.7320169682912686 0.4055909909360027)

(random 10 5)
could generate 11.0971 (a number between 10 and 15)

(random 10 7)
could generate 11.0971 (a number between 10 and 17)

(amb 1 2 3 4 5)
could generate 1 or 2 or 3 or 4 or 5

4.5 Sequenze
------------
(sequence 10 5)
;->  (10 9 8 7 6 5)

(sequence 0 1 0.2)
;->  (0 0.2 0.4 0.6 0.8 1)

(sequence 2 0 0.3)
;->  (2 1.7 1.4 1.1 0.8 0.5 0.2)

(series 2 2 5)
;->  (2 4 8 16 32)

(series 2 3 3)
;->  (2 6 18)

La funzione 'ssq' calcola la somma dei quadrati di una lista di numeri:

(ssq (sequence 1 5))
;->  55

4.6 Liste
---------
Tutte le espressioni Lisp sopra riportate sono in realtà una lista, un tipico tipo di dati newLISP.
Normalmente il primo elemento di una lista viene interpretato da newLISP come un riferimento ad una funzione, che verrà poi invocata (ricordiamo quanto detto sopra in 1.1. Sintassi delle chiamate di funzione).
A volte non lo vuoi e ti piace passare una lista semplicemente come dati (e non come una chiamata di funzione implicita).
In questo caso la lista deve essere "quotata", cioè preceduta da un apostrofo "'".
Esempio:

(ssq (sequence 1 5))

è una chiamata alla funzione 'ssq' e al suo argomento.
Questo argomento è una lista che verrà valutata nella lista (1 2 3 4 5).
Possiamo saltare la chiamata alla funzione 'sequence' e passare la lista (1 2 3 4 5) direttamente alla funzione 'ssq'.

(ssq '(1 2 3 4 5))
;->  55

La lista quotata '(1 2 3 4 5) significa: "prendi questa lista alla lettera", cioè come lista di numeri, come dati. (1 2 3 4 5) senza utilizzare la quotatura "'" verrebbe interpretato da newLISP come la funzione 1 e i suoi parametri 2 3 4 5.
Questo comando genererà ovviamente un errore.

4.7 Da lista a stringa
----------------------
A volte il risultato di una funzione newLISP è una lista (vedere gli esempi precedenti in 4.5 Sequenze).
Per utilizzare una lista di questo tipo in VisualNEO, potremmo convertirlo in una stringa CSV.
Esempio:

(join (map string (series 2 3 3)) ";")
;->  "2;6;18"

Cosa fa questo comando?

(series 2 3 3)
;->  (2 6 18)

La lista contiene i tre numeri 2, 6 e 18.

(map string (series 2 3 3))
;->  ("2" "6" "18")

La lista ora ha tre elementi di tipo stringa.
Le funzioni 'map' e 'string' convertono la lista di numeri in una lista di stringhe.

(join (map string (series 2 3 3)) ";")
;->  "2;6;18"

La funzione 'join' concatena la lista degli elementi stringa ("2" "6" "18") in una stringa "2;6;18" inserendo il carattere ";" tra ogni elemento.

Si noti che l'equivalente più breve (join '("2" "6" "18") ";") ha lo stesso risultato, ma in questo caso è necessario quotare la lista con le tre stringhe.
Una lista quotata significa per newLISP "prendere la lista alla lettera", cioè non interpretare il primo elemento come una funzione!

5. Vuoi saperne di più su newLISP?
----------------------------------
Le informazioni precedenti sulla sintassi newLISP sono tutto ciò che devi sapere per iniziare con successo ad utilizzare newLISP nella tua applicazione VisualNeo.
Se non vedi l'ora che vengano pubblicati i prossimi tutorial e desideri saperne di più su newLISP, ti consiglio quanto segue:

– https://en.wikibooks.org/wiki/Introduction_to_newLISP è una bella introduzione a newLISP.
– http://www.newLISP.org/downloads/manual_frame.html fornisce eccellenti informazioni su newLISP.

Grazie per la lettura. Alla prossima volta!
Reinier Maliepaard
ultimo aggiornamento: 31-05-2019


-------------------------------------------------
newLISP per VisualNEO Win. Parte 2: test sui dati
-------------------------------------------------

Questo tutorial riguarda le funzioni che verificano condizioni semplici. È possibile eseguire test più complicati combinando funzioni e operatori logici (not, and, or).

newLISP ha i cosiddetti predicati, ovvero funzioni che restituiscono TRUE o NIL dopo aver eseguito un test sul suo argomento.
Come già sai, NIL è l'equivalente newLISP di FALSE.
Esistono alcuni predicati incorporati che ti sono utili.
In questo tutorial ci limiteremo principalmente a numeri e stringhe.
Le liste di elaborazione verranno trattate in seguito.

Per testare il seguente codice, eseguire l'applicazione di esempio VisualNeo 'mcTestNewLISP.exe' (www.mcdigit.nl/mcTestnewLISP.zip), immettere l'espressione e analizzare il valore restituito.

Si noti che newLISP fa distinzione tra maiuscole e minuscole e utilizza ad es. nomi delle funzioni in minuscolo!

1. Predicati, tipo 1
--------------------
I predicati di tipo 1 hanno un argomento.
Esempi:

(even? 8)
;->  true

(even? 7)
;->  nil

un numero in virgola mobile verrà convertito in un numero intero tagliando la sua parte frazionaria:

(even? 8.7)
;->  true

(odd? 7)
;->  true

(odd? 8)
;->  nil

(integer? 123)
;->  true

(number? 123)
;->  true

(number? 1.23)
;->  true

(float? 1.23)
;->  true

(string? "hello")
;->  true

(zero? 0)
;->  true

(null? nil)
;->  true

Studia il seguente codice VisualNeo Win:

  SetVar "[x]" "1.23"
  hpwNewLispCall "(number? [x])" "[DllRetvar]"
  ;->  true

2. Predicati, tipo 2
--------------------
I predicati di tipo 2 testano la relazione tra argomenti.

(= (+ 3 3) 6)
;->  true

(not (= (+ 3 3) 6))
;->  nil

(null? (!= (+ 3 3) (+ 2 4)))
;->  true

(< 3 (+ 2 2) 5 (+ 3 3) 7 (+ 4 4))
;->  true

(> 6.5 7)
;->  nil

(starts-with "Reinier Maliepaard is my name." "babs|jennifer|reinier")
;->  nil

Aggiungere il numero 1 come terzo argomento per un controllo senza distinzione tra maiuscole e minuscole.

(starts-with "Reinier Maliepaard is my name." "babs|jennifer|reinier" 1)
;->  true

Il secondo argomento 'babs|jennifer|reinier' è un esempio di espressione regolare (vedi sezione 4).

(ends-with "My name is Reinier Maliepaard" "reinier maliepaard|babs berg|dean doe" 1)
;->  true

(member "LISP" "my-newLISP")
;->  "LISP"

(member "new" "my-newLISP")
;->  "newLISP"

(member "my" "my-newLISP")
;->  "my-newLISP"

Se la stringa di ricerca viene trovata, la funzione 'member' restituisce una stringa che inizia con la stringa di ricerca.
Le funzioni "find" e "find-all", utili anche per i test, sono trattate in un paragrafo successivo.

3. Combinazione di funzioni
---------------------------
Gli operatori logici "and" e "or" possono essere utilizzati per combinare due o più predicati in un test più complicato.

(and (number? 123) (number? 456) (> 456 123))
;->  true

Che succede qui? Tutti e tre gli argomenti vengono valutati in ordine.

Il primo argomento (numero? 123) restituisce true.
Il secondo argomento (numero? 456) restituisce true.
Il terzo argomento (> 456 123) restituisce true.
Ora la funzione "and" verrà applicata agli argomenti.
Poiché tutti gli argomenti sono true, verrà restituito il valore dell'ultima valutazione.

(and (number? 123) (number? 456) (> 456 123) "456 is greater than 123")
;->  "456 is greater than 123"

Qui il quarto argomento è la stringa "456 è maggiore di 123".
Le stringhe verranno sempre valutate su se stesse, restituendo semplicemente il loro valore letterale.

(and (number? 123) (number? 456) (< 456 123) "456 is greater than 123")
;->  nil

L'argomento (< 456 123) restituisce nil, che è anche il valore restituito.
Un esempio di codice VisualNeo di funzioni combinate:

  SetVar "[x]" "123"SetVar "[y]" "456"
  hpwNewLispCall "(and (number? [x]) (number? [y]) (< (- [x] [y]) 0 ))" "[DllRetvar]"
  ;->  true

4.Funzioni definite dall'utente per i test
------------------------------------------
Puoi anche ottenere risultati simili applicando le espressioni regolari.
La corrispondenza dei modelli di espressione regolare viene eseguita con la funzione newLISP Regex.
Sebbene questo blog non riguardi le espressioni regolari, è necessario introdurre alcune sintassi di base per comprendere la potenza delle espressioni regolari in newLISP (tornerò di nuovo sulle espressioni regolari più avanti quando descriverò le funzioni newLISP come 'find' e 'replace').

I seguenti metacaratteri svolgono un ruolo importante nelle espressioni regolari:

  - Ancore (Anchors): ^ e $
  - Quantificatori (Quantifiers): * + ? e {}
  - operatore OR: | oppure []
  - Classi di caratteri (Character classes): es. \d \w \s

Gli esempi seguenti ne dimostrano l'utilizzo.

Espressione e corrispondenze (matches):

  [a-c]+
  Qualsiasi stringa (non vuota) di a, b e c (come a, abba, acbabcacaa).
  Il quantificatore + significa "uno o più".

  ^[a-c]+$
  Qualsiasi stringa (non vuota), contenente solo a, b e c.
  L'ancora ^ si riferisce all'inizio e l'ancora $ alla fine.

  [a-c\s]+
  Qualsiasi stringa (non vuota) di a, b, c e spazi, tab o newline.

  ^\w+$
  Una 'parola' (word), ovvero una sequenza non vuota di caratteri alfanumerici e trattini bassi (underscore).

  d+ or [0-9]+
  Una o più cifre qualsiasi

  ^\d+$
  Solo una o più cifre. Uguale a ^[0-9]+$.

  ^\d{2}$
  Una sequenza non vuota di sole due cifre. Uguale a ^[0-9]{2}$.

  ^\d{2}C?$
  Una sequenza non vuota di sole due cifre, seguita da zero o un carattere C
  Uguale a ^[0-9]{2}C?$.
  Il quantificatore ? significa "zero o uno".

  ^[a-zA-Z]{2,3}.*$
  Qualsiasi stringa (non vuota), che inizia con due o tre caratteri alfabetici seguiti da zero o più caratteri.
  Il quantificatore * significa "zero o più".
  Il punto in .* corrisponde a qualsiasi carattere.
  The dot in .* matches any character.

  ^[a-zA-Z]{2}[\.]{1}.{3}$
  Qualsiasi stringa (non vuota), che inizia con due caratteri alfabetici seguiti da un punto e tre caratteri.

  \. Corrisponde a un punto (Matches a dot).

4.1 Prova
---------
Eseguire l'applicazione di esempio VisualNeo Win 'mcTestNewLISP.exe' (www.mcdigit.nl/mcTestnewLISP.zip), immettere un'espressione regex e analizzare il valore restituito.
Se non viene trovata alcuna corrispondenza, verrà restituito NIL.
Per ricercare una stringa non vuota contenente solo una o più a, b, c, si potrebbe scrivere:

(regex "^[a-c]+$" "abcd")
;->  nil

Estendi il set di caratteri in [a-d] e ci sarà una corrispondenza:

(regex "^[a-d]+$" "abcd")
;->  ("abcd" 0 4)

Se il valore restituito non è uguale a NIL (come in questo caso) allora esiste una corrispondenza.
Maggiori informazioni al riguardo nella sezione 4.2.
Per una corrispondenza senza distinzione tra maiuscole e minuscole, aggiungi l'opzione 1.

(regex "^[A-D]+$" "abcd")
;->  nil

(regex "^[a-d]+$" "ABCD" 1) or (regex "^[A-D]+$" "abcd" 1)
;->  ("abcd" 0 4)

4.2 Valore restituito in caso di corrispondenza
-----------------------------------------------
Se esiste una corrispondenza, il valore restituito è il tipo di dati più comunemente utilizzato in newLISP: la lista.
Nell'ultimo esempio di 4.1, il valore restituito è la lista

("abcd" 0 4)

Contiene tre elementi. Il primo elemento è la corrispondenza "abcd".
Il secondo elemento è l'offset della corrispondenza, l'indice 0.
Il terzo elemento è la lunghezza della corrispondenza 4.

(regex "[a-e]+" "zzzabcdzzz")

restituisce

;-> ("abcd" 3 4)

La corrispondenza è "abcd", il suo offset è 3 e la sua lunghezza è 4.

Ovviamente puoi elaborare questa lista, ma per ora salteremo questo argomento.

4.3 Invocazione di Regex in hpwNewLispCall
------------------------------------------
Per eseguire le espressioni precedenti in hpwNewLispCall, è necessario modificare leggermente le espressioni.
L'ultimo esempio:

(regex "[a-e]+" "zzzabcdzzz")

dovrebbe essere implementato come:

  hpwNewLispCall "(regex {[#91]a-e[#93]+} {zzzabcdzzz})" "[DllRetvar]"

So

Così

- il doppio apice di apertura "" è sostituito da { e quello di chiusura da }
- la parentesi quadra [ è sostituita da [#91] e ] da [#93].

Le parentesi graffe sono utili anche quando nell'espressione sono presenti barre rovesciate, come \d

  hpwNewLispCall "(regex {^\d+$} {123})" "[DllRetvar]"

invece di

  hpwNewLispCall "(regex [#34]^\\d+$[#34] [#34]123[#34])" "[DllRetvar]"

5. Esercizi ed esempi
---------------------
Test per caratteri alfabetici e numerici
(regex "[a-zA-Z0-9]+" "123abc")
;->  ("123abc" 0 6)

Test per caratteri alfabetici e numerici, spazi, tab e newline sono permessi
(regex "[a-zA-Z0-9\\s]+" "12 3a bc@#&")
;->  ("12 3a bc" 0 8)

Test per caratteri numerici
(regex "[0-9]+" "1234")
;->  ("1234" 0 4)

Test per esattamente 5 caratteri numerici
(regex {\d{5}} "1234")
;->  nil

Test per 4 o 5 caratteri numerici
(regex {\d{4,5}} "1234")
;->  ("1234" 0 4)

Test per caratteri alfabetici
(regex "[a-zA-Z]+" "abc")
;->  ("abc" 0 3)

Test solo per caratteri alfabetici minuscoli
(regex "[a-z]+" "abc")
;->  ("abc" 0 3)

Test solo per caratteri alfabetici maiuscoli
(regex "[A-Z]+" "abc")
;->  nil

Test per e-mail valide (sì, è possibile creare validatori migliori...)
(regex "^[a-zA-Z_\.]+@[a-zA-Z_]+?\.[a-zA-Z]{2,4}$" "dean.doe@some_host.info")
;->  ("dean.doe@some_host.info" 0 23)

Test per data valida con barre 26/04/2019
(regex {^\d{1,2}\/\d{1,2}\/\d{4}$} {26/04/2019})
;->  ("26/04/2019" 0 10)

Test per data valida con punti 1.5.2019
(regex {^\d{1,2}\.\d{1,2}\.\d{4}$} {1.5.2019})
;->  ("1.5.2019" 0 8)

Test per indirizzi IPv4:
(regex {^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$} {172.16.254.1})
;->  ("172.16.254.1" 0 12)

6. Maggiori informazioni sull'esecuzione di test in newLISP
-----------------------------------------------------------
Le informazioni precedenti sui predicati e sulle espressioni regolari in newLISP riguardavano il test dei dati.
Altri predicati e la corrispondenza dei modelli di espressioni regolari (supportati anche in altre funzioni newLISP) verranno trattati in seguito.

Grazie per la lettura. Alla prossima volta!
Reinier Maliepaard
(ultimo aggiornamento: 31-05-2019)


------------------
newLISP Challenge!
------------------

Prima di continuare con il Tutorial 3 su newLISP, facciamo ora alcuni esercizi di programmazione newLISP.
Devi risolvere alcuni piccoli problemi.
Per farlo con successo, ricorda il contenuto dei miei primi due tutorial su newLISP.
Inoltre, puoi utilizzare http://www.newlisp.org/downloads/manual_frame.html per informazioni sulle funzioni newLISP.

[Si noti che per alcuni problemi è possibile trovare soluzioni migliori richiamando altre funzioni rispetto a quelle discusse nei primi due tutorial.]

1. Determinare il valore restituito dalle seguenti espressioni:
---------------------------------------------------------------
a. (< 0 1 1 2 3 5 8 13 21 34 55 89 144)
;->  nil

b. '(+ 1 2 (- 1 2))
;->  (+ 1 2 (- 1 2))

Nota: un'espressione quotata, cioè un'espressione preceduta da un apostrofo, significa per newLISP: "non valutare questa espressione come una funzione, ma letteralmente, cioè come dati e restituire semplicemente l'espressione senza apostrofo."

c. (add 3E4 (* 2 (pow 10 1)) 7E-2)
;->  30020.07

d. (and (> (/ 1 5) (* 5 (/ 1 30))) "Math can be very challenging!")
;->  nil

Nota: vedi perchè (and (> (div 1 5) (mul 5 (div 1 30))) "Math can be very challenging!") restituisce "Math can be very challenging!"?

e. (string? '("newLISP puts the fun back in LISP"))
;->  nil

Nota: (string? "newLISP puts the fun back in LISP") restiruirebbe il valore true.

f. (or (number? '(100)) (float? 3.1415))
;->  true

2. Scrivi una singola espressione che verifica se il valore assoluto della sottrazione 2 – 5 è maggiore di 0, ma restituisce il valore nil
-------------------------------------------------------------
(not (> (abs (- 2 5)) 0))
;->  nil

Nota: utilizzando il condizionale 'if' (di cui non abbiamo parlato nei tutorial precedenti), potresti scrivere:

(if (> (abs (- 2 5)) 0) nil true)
;->  nil

Leggere: if (test-is-successful) then (expression-test-is-successful) else (expression-test-is-not-successful)

Senza la parte facoltativa else: (if (> (abs (- 2 5)) 0) nil) valuta pure a nil.

3. Scrivi una singola espressione che restituisca un valore float, ovvero la differenza tra il valore più alto e quello più basso della seguente serie di quattro numeri: 2 1.5 3 2.7
-------------------------------------------------------------

(sub (max 2 1.5 4 2.7) (min 2 1.5 4 2.7))
;->  2.5

Nota: cambia sub in – (meno) e il risultato sarà 3: (- 4 1.5) sarà interpretato come (- 4 1)

4. Scrivi una singola espressione che restituisca un numero casuale compreso tra 1 e 10 (intero) e moltiplica il risultato per 2,5
-------------------------------------------------------------

(mul (+ 1 (rand 10)) 2.5)
;->  il risultato potrebbe essere 22.5

Nota: l'espressione (rand 10) genera un numero compreso tra 0 e 9.
Quindi dobbiamo aggiungere 1 al risultato per ottenere un numero casuale compreso tra 1 e 10: (+ 1 (rand 10))

5. Utilizzare entrambe le funzioni 'zero?' e 'mod' per il problema successivo.
Non puoi utilizzare la funzione 'even?'
-------------------------------------------------------------
Problema: prova in una singola espressione se il numero 10 è pari

(zero? (mod 10 2))
;->  true

6. Scrivi una singola espressione che concatena la lista degli elementi della stringa ("2" "3" "4") nella stringa "2-3-4"
-------------------------------------------------------------
(join '("2" "3" "4") "-")
;->  "2-3-4"

Nota: il primo parametro della funzione join è una lista di stringhe, in questo caso '("2" "3" "4")

7. Scrivi una singola espressione che calcoli la somma dei quadrati della lista (3 9 27). Questa lista dovrebbe essere il risultato della funzione integrata 'series'
-------------------------------------------------------------
(ssq (series 3 3 3))
;->  819

8. Utilizzare entrambe le funzioni 'zero?' e 'pow' per il problema successivo.
Non è possibile utilizzare la funzione 'sqrt'.
-------------------------------------------------------------
Problema: prova se il numero 9 è diverso da 0 e prova che la differenza tra la radice quadrata di 100 e la radice quadrata di 81 è uguale a 1. Naturalmente in un'unica espressione.
Problema: prova se il numero 9 è diverso da 0 e prova che la differenza tra la radice quadrata di 100 e la radice quadrata di 81 è uguale a 1. Naturalmente in un'unica espressione.

(and (not (zero? 9)) (= (- (pow 100 0.5) (pow 81 0.5)) 1))
;->  true

Nota: la sooluzione con il condizionale 'if':

(if (zero? 9) nil (= (sub (pow 100 0.5) (pow 81 0.5)) 1))
;->  true

or

(if (not (zero? 9)) (= (sub (pow 100 0.5) (pow 81 0.5)) 1))
;->  true

9. Scrivi una singola espressione che valida la stringa "AbcD XyZ" e mostra che la lunghezza di "AbcD XyZ" è uguale a 8
-------------------------------------------------------------
(regex "[a-z ]+" "AbcD XyZ" 1)
;->  ("AbcD XyZ" 0 8)

Nota: questa espressione con l'opzione di ricerca senza distinzione tra maiuscole e minuscole 1, verifica solo se la stringa AbcD XyZ è composta da caratteri alfabetici e spazi. (regex "[a-d]{4}[ ]{1}[x-z]{3}" "AbcD XyZ" 1)

10. Scrivi una singola espressione che trasformi la lista (2 3 4) nella stringa "3-4-5"
-------------------------------------------------------------
(join (map string (map inc '(2 3 4))) "-")
;->  "3-4-5"

Nota: studiare i seguenti passaggi

(map inc '(2 3 4))
;->   (3 4 5)

cioè "mappa la funzione inc su ciascun elemento della lista (2 3 4)"

(map string (map inc '(2 3 4)))
;->   ("3" "4" "5")

cioè "mappa la stringa della funzione su ciascun elemento della lista (3 4 5)"

(join '("3" "4" "5") "-")
;->   "3-4-5"

Quindi, non ci sono abbastanza domande?
Ok, un'ultima complicazione:

11. Scrivi una singola espressione che
-------------------------------------------------------------
– restituisce una sottostringa contenente le ultime tre parole di "To be or not to be"
– e verifica se la sottostringa ha effettivamente tre parole, separate da uno spazio;
– la sottostringa non ha spazi all'inizio e alla fine
(regex "^\\w+[ ]{1}\\w+[ ]{1}\\w+$" (member "not" "to be or not to be"))
;->  ("not to be" 0 9)

Per evitare le doppie barre rovesciate, utilizzare le parentesi graffe:

(regex {^\w+[ ]{1}\w+[ ]{1}\w+$} (member "not" "to be or not to be"))
;->  ("not to be" 0 9)

Grazie per la lettura. Alla prossima volta!
Reinier Maliepaard
(ultimo aggiornamento: 24-06-2019)


--------------------------------------------
newLISP per VisualNEO Win. Parte 3: Stringhe
--------------------------------------------

In newLISP, i tipi di dati stringhe, array unidimensionali e liste hanno molto in comune: sono tutte sequenze di alcuni elementi – in un ordine specifico.
Non sorprende che molte delle funzioni integrate del newLISP possano essere applicate a stringhe, array e liste.

In qualità di sviluppatore di newLISP, Lutz Mueller ha scritto:

"Molte delle funzioni integrate di newLISP sono polimorfiche e accettano una varietà di tipi di dati e parametri opzionali.
Ciò riduce notevolmente il numero di funzioni e forme sintattiche necessarie da apprendere e implementare."

Ad esempio, la funzione 'length' può essere applicata a:

1. una stringa:

(length "Hello World")
;->  11

2. un vettore (array) unidimensionale:

(length '(1 2 3 4 5))
;->  5

3. una lista:

(length '(a b (c d) e))
;->  4

Questo tutorial riguarda le stringhe. Perché?
Le funzioni di stringa di newLISP sono ottime per gli utenti VisualNEO.
Nel frattempo impariamo, inconsciamente, la possibile applicazione di funzioni su vettori e liste (di cui parleremo nei tutorial successivi).
Si noti che ho selezionato solo le funzioni newLISP che non hanno equivalenti diretti in VisualNEO.
A volte le funzioni VisualNeo e newLISP fanno più o meno la stessa cosa.
Ma ricorda che una delle potenti funzionalità di newLISP è la combinazione di diverse funzioni in un'unica espressione.

Supponendo che tu abbia installato il plugin newLISP di Hans-Peter Wickern (https://visualneo.com/product/hpwnewlisp), probabilmente saprai come implementare il codice newLISP nel tuo script VisualNEO:

  hpwNewLispCall "(length {Hello World})" "[DllRetvar]"
  Alertbox "Result" "[DllRetvar]"

Se necessario, rileggi il mio primo e secondo tutorial.

Ok, diamo un'occhiata ad alcune funzioni che operano sulle stringhe.

Sezione 1. Operazioni base sulle stringhe
-----------------------------------------
Le nuove funzioni LISP 'minuscolo' e 'maiuscolo' fanno ciò che ci aspettiamo e hanno i loro equivalenti VisualNeo. Altre due funzioni estendono i comandi VisualNeo.

1.1 'reverse'
-------------
La funzione 'reverse' inverte una stringa:

(reverse "the name reinier is a palindrom")
;->  "mordnilap a si reinier eman eht"

1.2 'title-case'
----------------
Per rendere maiuscolo il primo carattere di una stringa, dopo aver rimosso gli spazi all'inizio e alla fine di una stringa:

(title-case (trim " reinier h. maliepaard    "))
;->  "Reinier h. maliepaard"

(cosa fa la funzione 'trim', vedere 1.5.2)

1.3 'title-case' su sottostringhe
---------------------------------
Se la stringa di risultato nell'esempio precedente avrebbe dovuto essere "Reinier H. Maliepaard", abbiamo

– per fare il parsing di una stringa in una lista di stringhe
– per mappare 'title-case' a ciascun elemento di questa lista e
– per unire questa lista modificata in una stringa

(join (map title-case (parse "reinier h. maliepaard")) " ")
;->  "Reinier H. Maliepaard"

1.4 Sooostringhe
----------------
L'estrazione di sottostringhe dalle stringhe è semplice: contare in avanti dal taglio (interi positivi, 0 compreso) o all'indietro dalla fine (interi negativi).
Gli indici negativi sono una caratteristica interessante per gli utenti di VisualNeo.

("0123456" 0)
;->  "0"

Soluzione alternativa:
(first "0123456")
;->  "0"

("0123456" -1)
;->  "6"

Soluzione alternativa:
(last "0123456")
;->  "6"

La funzione 'slice' ti dà una nuova sezione di una stringa esistente.

(slice "0123456" -1 1)
;->  "6"

(slice "0123456" -2 2)
;->  "56"

(slice "0123456" 3)
;->  "3456"

(slice "0123456" 3 -1)
;->  "345"

(slice "0123456" 3 -2)
;->  "34"

Puoi anche usare una variante più breve:
– rimuovi 'slice' e
– metti l'intervallo di numeri all'inizio.

L'ultimo esempio potrebbe anche essere scritto come

(3 -2 "0123456")
;->  "34"

Notare l'uso di 'rest' come alternativa a (slice "0123456" 1 6):

(rest "0123456")
;->  "123456"

che è lo stesso di

(1 "0123456")
;->  "123456"

(3 "0123456")
;->  "3456"

ecc.

1.5 Modificare l'inizio e/o la fine delle stringhe
--------------------------------------------------

1.5.1 'chop'
------------
La funzione 'chop' rimuove i caratteri dalla fine di una stringa.
L'impostazione predefinita rimuove l'ultimo carattere.

(chop "Hello")
;->  "Hell"

Per rimuovere 3 caratteri alla fine, aggiungere il parametro 3:

(chop "Hello" 3)
;->  "He"

1.5.2 'trim'
------------
La funzione 'trim' rimuove i caratteri dall'inizio e dalla fine di una stringa.
Predefinito: rimozione degli spazi.

(trim "        123       ")
;->  "123"

(trim  "——123——" "-")
;->  "123"

(trim "——123******" "-" "*")
;->  "123"

(trim "——123******" "-")
;->  "123******"

(trim "——123******" "*")
;->  "——123"

1.6 Modifying strings with 'setf' and 'replace'
-----------------------------------------------

1.6.1 'setf'
------------
Con la funzione 'setf' è possibile modificare i caratteri di una stringa (lista e array) tramite i loro numeri di indice.
Per vedere come funziona esattamente 'setf', utilizziamo una variabile, definita con 'setq'.

;definisci una variabile con 'setq'
(setq my-string "reinier h. maliepaard")

;sostituisci il primo carattere 'r' (numero di indice 0) con 'R'
(setf (my-string 0) "R")
;->  "R"

;la stringa originale è stata modificata
my-string
;->  "Reinier"

Se non vuoi modificare definitivamente la stringa originale (quindi 'setf' è chiamata funzione distruttiva), usa la funzione 'copy':

(setf ((setq result-string (copy my-string)) 0) "R")
;->  "R"

my-string
;->  "reinier"

result-string
;->  "Reinier"

1.6.2 'replace'
---------------
Nessuna sorpresa, la funzione 'replace' (anche distruttiva) è molto potente usando le espressioni regolari (studia il tutorial2 per informazioni sulla sintassi di base delle espressioni regolari).
Inoltre, 'replace' con le espressioni regolari imposta anche le variabili interne di sistema $0, $1, $2, fino a $15 con il contenuto delle espressioni e sottoespressioni trovate.
Ultimo ma non meno importante, la funzione 'replace' ha un'opzione "sostituisci solo la prima corrispondenza".

;il parametro 0 indica una ricerca con distinzione tra maiuscole e minuscole
(replace "a" "aAa" "X" 0)
;->  "XAX"

;il parametro 1 indica una ricerca senza distinzione tra maiuscole e minuscole
(replace "a" "aAa" "X" 1)
;->  "XXX"

Gli esempi precedenti possono essere facilmente eseguiti con StrReplace di VisualNeo.
Ma i prossimi esempi sono piuttosto complicati da realizzare in VisualNeo.

;il parametro 0x8000 indica l'opzione 'sostituisci solo la prima corrispondenza'
(replace "a" "aAa" "X" 0x8000)
;->  "XAa"

;ora in combinazione con l'espressione regolare a|A, ovvero corrisponde al carattere 'a' o 'A'
(replace "a|A" "AaA" "X" 0x8000)
;->  "XaA"

(replace "a|A" "aaA" "X" 0x8000)
;->  "XaA"

;le sottoespressioni trovate vengono restituite nelle variabili di sistema $1, $2 ecc.
;$3 contiene la terza sottoespressione, $2 la seconda e $1 la prima
;quindi '123' verrà restituito come '321' e '193' come '391'

(setq my-string "—123—193—")
(replace "(1)(.)(3)" my-string (append $3 $2 $1) 0)
;->  "—321—391—"

La funzione 'append' incolla insieme le stringhe: vedere 2.2

;Le espressioni trovate vengono restituite nelle variabili di sistema $0
(replace "t|b|n" "to be or not to be" (upper-case $0) 0)
;->  "To Be or NoT To Be"

1.6.3 'rotate'
--------------
(setq str "0123456")

;a destra
(rotate str 1)
;->  "6012345"

;a sinistra
(rotate str -1)
;->  "1234560"

(rotate str 2)
;->  "5601234"

(rotate str -2)
;->  "2345601"

Sezione 2: creare stringhe
--------------------------
Sebbene VisualNeo disponga di diversi strumenti per creare una stringa, diamo una breve occhiata a come è possibile creare stringhe in newLISP.

2.1 Costruisci una stringa con le funzioni 'sequence', 'char' a 'join'
----------------------------------------------------------------------
(char "a")
;->  97

(char 97)
;->  "a"

(sequence (char "a") (char "z"))
;->  (97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117  118 119 120 121 122)

(map char (sequence (char "a") (char "z")))
;->  ("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

To transform this list of separated strings into one string, use the function 'join':

(join (map char (sequence (char "a") (char "z"))))
;->  "abcdefghijklmnopqrstuvwxyz"

To make a CSV string, add an extra parameter to 'join':

(join (map char (sequence (char "a") (char "z"))) ";")
;->  "a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u;v;w;x;y;z"

2.2 La funzione 'append' incolla insieme le stringhe
----------------------------------------------------
La funzione 'append' funziona sulle stringhe:

(append "Hello" " world " "of newLISP!")
;->  "Hello world of newLISP!"

(append "Today " "it " "is " (date))
;->  "Today it is Tue Jun 25 13:23:44 2019"

Tieni presente che (date) restituisce una stringa.

2.3 'string' come potente alternativa a 'append'
------------------------------------------------
Più potente di "append" è la funzione stringa: converte gli argomenti in stringhe e li aggiunge in un unico passaggio:

(string "The expression " '(sequence 1 10) " produces – if unquoted! – the list " (sequence 1 10))
;->  "The expression (sequence 1 10) produces – if unquoted! – the list (1 2 3 4 5 6 7 8 9 10)"

2.4 'dup' per ripetizioni di caratteri all'interno di una stringa
-----------------------------------------------------------------
(dup "AB" 5)
;->  "ABABABABAB"

Sezione 3: 'find' e 'find-all'
------------------------------
Le funzioni 'find' e 'find-all' fanno ciò che suggerisce il nome.
Queste funzioni sono strumenti potenti se combinate con le espressioni regolari.
Alcuni esempi, tralasciando le applicazioni che assomigliano alla funzione VisualNeo SearchStr.

;l'opzione 0 in 'find' come in altre funzioni di stringa newLISP si riferisce alla distinzione tra maiuscole e minuscole e 1 a senza distinzione tra maiuscole e minuscole:

(find "cat|dog" "I have a cat" 0)
;->  9

(find "cat|dog" "I have a CAT" 0)
;->  nil

;senza distinzione tra maiuscole e minuscole
(find "cat|dog" "I have a CAT" 1)
;->  9

;usa un offset opzionale per cercare da una posizione specifica, qui dall'indice numero 12
(find "cat|dog" "I have a cat and a dog" 0 12)
;->  19

Sezione 4: 10 problemi da cui imparare...
-----------------------------------------

Problema 1: qual è l'ultimo carattere di una stringa?
-------------------------------------------------------------
Soluzione:
(last "A secret message")
;->  e

Problema 2: scegliere uno o più caratteri dalla stringa
-------------------------------------------------------------
Soluzione:
(select "abcdef" -2 -1 0)
;->  "efa"

Problema 3: convertire il primo carattere di una stringa in maiuscolo e gli altri caratteri di quella stringa in minuscolo
-------------------------------------------------------------
Soluzione:
(title-case "bABS" true)
;->  "Babs"

Problema 4: ritagliare i caratteri da entrambi i lati oppure solo un lato
-------------------------------------------------------------
Soluzione:
;tagliare il carattere dalla fine
(trim "aaa12345z" "" "z")
;->  "aaa12345"

;tagliare il carattere dall'inizio
(trim "a12345zz" "a" "")
;->  "12345zz"

;tagliare il carattere dalla fine e dall'inizio
(trim "aa12345zzz" "a" "z")
;->  "12345"

;codice predefinito breve: taglia gli spazi da entrambi i lati
(trim " 12345  ")
;->  "12345"

Problema 5: sostituire tutti i caratteri di una stringa con un carattere specificato
-------------------------------------------------------------
Cosa sapere:
un'espressione regolare che fa riferimento a tutti i caratteri: \.

Soluzione:
(replace "\." "abcdef" "X" 1)
;->  "XXXXXX"

Problema 6: sostituire tutte le cifre di una stringa con un carattere specificato
-------------------------------------------------------------
Cosa sapere:
un'espressione regolare che fa riferimento ai numeri: \d

Soluzione:
(replace "\\d" "a1c2e3" "X" 0)
;->  "aXcXeX"

Problema 7: fornire la posizione del primo carattere di una stringa inclusa in un dato sottoinsieme
-------------------------------------------------------------
Cosa sapere:
classe di caratteri dell'espressione regolare: [x|y|z]

Soluzione:
(find "[x|y|z]" "abczef" 0)
;->  3

Problema 8: dare la posizione del primo carattere di una stringa che non è inclusa in un dato sottoinsieme
-------------------------------------------------------------
Cosa sapere:
classe di espressione regolare dei caratteri inclusi: [x|y|z]
classe di espressioni regolari di caratteri esclusi: [^x|y|z]

Soluzione:
(find "[^x|y|z]" "zabcxef" 0)
;->  1

Problema 9: crittografare e decrittografare una stringa
-------------------------------------------------------------
(setq secret (encrypt "A secret message" "my secret key"))
;->  ",YS\022\006\017\023\017TM\014\022\n\012\030E"

(encrypt secret "my secret key")
;->  "A secret message"

Problema 10: dividere una stringa in 5 gruppi di caratteri dopo aver eliminato i caratteri di interpunzione ! . e spazio
-------------------------------------------------------------
(setq secret "A secret message. A secret key, a secret agent!")
(explode (replace "[,!\. ]" secret "" 0) 5)
;->  ("Asecr" "etmes" "sageA" "secre" "tkeya" "secre" "tagen" "t")

Grazie per la lettura. Alla prossima volta!
Reinier Maliepaard
(ultimo aggiornamento: 22-07-2019)


-----------------------------------------
newLISP per VisualNEO Win. Parte 4: Liste
-----------------------------------------

Nei tutorial precedenti abbiamo già incontrato il tipo di dati newLISP più importante, la lista.
Tecnicamente una lista è una sequenza di uno o più elementi, separati da uno spazio e circondati da parentesi bilanciate (notare che esiste una lista vuota anche in newLISP).

Ricordare:
Le parentesi attorno a una lista identificano un'unità che può memorizzare dati, ma può anche chiamare e definire le funzioni.

Quest'ultima opzione "chiamare e definire le funzioni" verrà discussa in un altro tutorial.

Qualche esempio:

;una lista di atomi numerici, o numeri, aventi cinque elementi
(1 2 3 4 5)

;una lista di tre elementi stringa
("Reinier" "newLISP" "VisualNEO")

;una lista contenente una stringa
("this-is-the-only-string-in-this-list")

;una lista di atomi simbolici, o simboli, aventi quattro elementi
(FOO A1$2 I-AM-A-SYMBOL BWV545)

I simboli possono servire come, per esempio, una variabile o il nome di una funzione (vedi sotto).

Una lista può combinare diversi tipi di elementi.

;una lista con numeri, stringhe e simboli, composto da sette elementi
(5 "my-number" A B "c" 3.14 PI)

Una lista può anche essere un elemento di una lista.

;una lista con una lista "annidata" (nidificata).
(1 (A1 B2,4 Hello! z-score) "2")

Si noti che questa lista ha tre elementi. Per essere sicuro:

(length (1 (A1 B2,4 Hello! z-score) "2"))
;->  3

Il secondo elemento, la sottolista

(A1 B2,4 Hello! z-score)

ha quattro elementi.

Nota che lo spazio è il separatore predefinito all'interno di una lista, quindi
– B2,4 è un elemento, nonostante la sua virgola
– Ciao! è un elemento, nonostante il punto esclamativo.
– e z-score è un elemento, nonostante il segno meno.

Le liste annidate rendono possibili le cosiddette 'liste di associazione', che sono molto utili: vedere la Sezione 5.

Gli elementi di una lista nei miei tutorial newLISP fino ad ora sono numeri, stringhe, simboli e liste.
Sorge la domanda: in che modo newLISP valuta questi tipi di dati?
Studia i prossimi esempi:

;Reinier is the son of Balten
(son Balten Reinier)
;Reinier is the father of Daniel
(father Daniel Reinier)

Qui il nostro piccolo database contiene solo simboli.
Fornisce informazioni sui rapporti familiari: Balten è il nonno di Daniel.
Ma questi elementi non hanno alcun significato per newLISP: si valutano da soli - sono presi alla lettera - proprio come numeri e stringhe.

(add 1.5 2.6)
;->  4.1

In questo caso, newLISP riconosce il simbolo 'add' come funzione e interpreta i due numeri 1.5 e 2.6 come argomenti.
Verrà valutata l'espressione, cioè: elaborazione della funzione 'add' con due argomenti e restituzione di un valore (qui la somma tra i due numeri 1.5 e 2.6).

(setq x 12)
;->  12

(+ x 13)
;->  25

Qui il simbolo 'x' è una variabile: il valore 12 è assegnato a 'x'.
Quindi, 13 viene aggiunto a "x", il che dà come risultato 25.

Quindi più precisamente, una lista può contenere atomi (ad esempio numeri, stringhe e simboli) e/o liste.
I simboli possono avere il ruolo di identificatori, denominare variabili o funzioni.
Per ora ti basta sapere questo.

Una piccola nota sulle stringhe: le stringhe e le liste appartengono al tipo di dati sequenza (= insieme ordinato di elementi). Hanno molte funzioni in comune.

Diamo ora un'occhiata a come elaborare le liste.
Ho fatto di nuovo esempi di semplici espressioni newLISP.
Ma credetemi, le liste si prestano a costrutti molto complessi.

Sezione 1. Elaborazione delle liste
-----------------------------------

1.1 Restituisce il primo elemento della lista
---------------------------------------------
(first '(1 2 3 4 5))
;->  1

Si noti che se una lista è un argomento di una funzione (qui la funzione 'first'), deve essere racchiusa tra virgolette (= presa alla lettera): vedere la sezione 2.

(first '((1 2 3) 4 5))
;->  (1 2 3)

1.2 Restituisce l'ultimo elemento della lista
---------------------------------------------
(last '(1 2 3 4 5))
;->  5

1.3 Restituisce tutti gli elementi di una lista, tranne il primo
----------------------------------------------------------------
(rest '(1 2 3 4 5))
;->  (2 3 4 5)

Si noti che il valore restituito è una lista.

(first (rest '(1 2 3 4 5)))
;->  2

1.4 Restituire valori tramite indicizzazione implicita
------------------------------------------------------
(setq mc-list '(1 2 3 4 5))
;->  (1 2 3 4 5)

(1 mc-list)
;->  (2 3 4 5)

che equivale alla funzione 'rest'.

(2 mc-list)
;->  (3 4 5)

che equivale a (rest (rest '(1 2 3 4 5)))

(0 1 mc-list)
;->  (1)

(2 -1 mc-list)
;->  (3 4)

1.5 Liste annidate
------------------
(setq mc-list '(1 (2 3) 4 5))
;->  (1 (2 3) 4 5)

Questa lista ha 4 elementi. Il secondo elemento è:

(1 1 mc-list)
;->  ((2 3))

Il quarto elemento è:

(3 1 mc-list)
;->  (5)

Il quinto elemento è la fine della lista:

(4 1 mc-list)
;->  ()

Sì, una lista vuota.

1.6 Modificare una lista
------------------------

1.6.1 'setf'
------------
Con la funzione 'setf' è possibile modificare i caratteri di una lista (stringa o vettore) tramite i loro numeri di indice.

;definisci una variabile con 'setq'
(setq my-list '("a" "b" "c" "a"))

;sostituire la prima "a" (numero indice 0) con "D"
(setf (my-list 0) "D")
;->  "D"

;la lista originale è stata modificata
my-list
;->  ("D" "b" "c" "a")

Vedi tutorial 3, 1.6.1 se non vuoi modificare la lista originale.

1.6.2 set-ref, set-ref-all e replace
------------------------------------
(setf (my-list 0) "D")

ha un'alternativa:

(set-ref "a" my-list "D")

che sostituisce la prima occorrenza.

Per sostituire tutte le corrispondenze potresti usare 'set-ref-all'.

(setq my-list '("a" "b" "c" "a"))
;->  ("a" "b" "c" "a")

(set-ref-all "a" my-list "D")
;->  "D"

my-list
;->  ("D" "b" "c" "D")

Naturalmente la funzione 'replace' svolge molto bene il suo lavoro sulle liste.
Vedi www.newlisp.org/downloads/manual_frame.html
Of course, the function 'replace' does its job on lists very well. See www.newlisp.org/downloads/manual_frame.html

1.6.3 'push' e ' pop'
---------------------
La funzione 'push' aggiunge un nuovo elemento all'inizio di una lista se non è specificato alcun numero di indice.
Nel prossimo esempio viene aggiunta una "X" alla fine della lista perché è dato il numero di indice -1.

(setq my-list '("a" "b" "c" "a"))
;->  ("a" "b" "c" "a")

(push "X" my-list -1)
;->  ("a" "b" "c" "a" "X")

Nell'esempio successivo il numero di indice 1 si riferisce alla seconda posizione della lista, dove è inserita "Y":

(push "Y" my-list 1)
;->  ("a" "Y" "b" "c" "a" "X")

La funzione 'pop' rimuove un elemento della lista:

(pop my-list 0) ;lo stesso dell'impostazione predefinita (pop mylist)
;->  "a"

my-list
;->  ("Y" "b" "c" "a" "X")

1.7. Convertire una lista in stringa
------------------------------------
Per convertire una lista in una stringa, puoi usare la funzione 'format':

(format "%d %d %d" '(1 2 3))
"1 2 3"

(format "%f %d %f" '(1.1 2 3.2))
"1.100000 2 3.200000"

oppure meglio:

(format "%0.2f %d %0.1f" '(1.1 2 3.2))
"1.10 2 3.2"

(format "%0.2e %d %0.1f" '(1.1 2 3.2))
"1.10e+00 2 3.2"

(format "%s %s %s" '("a" "b" "c"))
"a b c"

(format "%c %c %c" '(65 66 67))
"A B C"

dove le cifre si riferiscono a valori ASCII in decimale.

Il % (segno di percentuale) negli esempi precedenti avvia una specifica del formato: vedere la tabella seguente.

formato  descrizione
  s      text string
  c      character (value 1 – 255)
  d      decimal (32-bit)
  u      unsigned decimal (32-bit)
  x      hexadecimal lowercase
  X      hexadecimal uppercase
  o      octal (32-bits) (not supported on all of newLISP flavors)
  f      floating point
  e      scientific floating point
  E      scientific floating point
  g      general floating point

Maggiori informazioni nella sezione 3.

1.8. Lista o stringa?
--------------------
Probabilmente nella maggior parte dei casi le stringhe sono più convenienti per gli utenti di VisualNeo rispetto alle liste.
Inoltre, è possibile applicare a una stringa molte funzioni di lista.
Tuttavia, per comprendere completamente alcune utili funzioni newLISP, è necessario saperne di più sulle liste: vedere la Sezione 3.
Ancora più importante, nella Sezione 5 incontrerete liste speciali che vi saranno utili.

Sezione 2. Quotazione di una lista
----------------------------------
Come già detto, una lista come argomento in una funzione deve essere quotata (= presa alla lettera). Abbiamo già visto un esempio:

Come già detto, una lista come argomento in una funzione deve essere racchiusa quotata (= presa alla lettera). Abbiamo già visto un esempio:

(first '(1 2 3 4 5))
;->  1

Perchè è necessario quotare?
Perché newLISP interpreta il primo elemento di una lista come una funzione e gli altri elementi come argomenti di quella funzione. Non citare la lista comporta un errore:

(first (1 2 3 4 5))
;->  ERR: illegal parameter type in function first : 2

Ricordati che dimenticare di quotare una lista è una delle cause più comuni di bug nei programmi newLISP.

Sezione 3. Una squadra d'oro di funzioni newLISP: 'join', 'map' e 'apply'
-------------------------------------------------------------------------
Gli utenti di VisualNeo possono gestire facilmente le liste, grazie alle tre funzioni 'join', 'map' e 'apply'.

3.1 'join' (e 'explode')
------------------------
La funzione 'join' concatena la lista di stringhe fornita in una lista contenente una stringa.

(join '("a" "b" "c"))
;->  ("abc")

(join '("a" "b" "c") "*")
;->  ("a*b*c")

(join '("a" "b" "c") "*" true)
;->  ("a*b*c*")

La funzione 'explode' ha un'operazione inversa di 'join':

(explode "newLISP")
;->  ("n" "e" "w" "L" "I" "S" "P")

(join (explode "newLISP"))
;->  "newLISP"

3.2 'map'
---------
La funzione 'map' applica successivamente una funzione ai suoi argomenti, restituendo tutti i risultati in una lista.

(map upper-case '("a" "b" "c"))
;->  ("A" "B" "C")

(map + '(1 1 1) '(1 2 3))
;->  (2 3 4)

3.3 'apply'
-----------
La funzione 'apply' applica una funzione ai suoi argomenti nel loro insieme (e non come la funzione 'map' elemento per elemento).

(apply + '(1 2 3))
;->  6

che è lo stesso di

(+ 1 2 3)
;->  6

Si noti che 'map' restituisce una lista, mentre 'apply' restituisce una stringa.

(map upper-case '("abc"))
;->  ("ABC")

(apply upper-case '("abc"))
;->  "ABC"

Sezione 4. Imparare con l'esempio
---------------------------------
In questa sezione ti presenterò alcuni problemi e le relative soluzioni.
Incontrerai nuove funzioni, che lavorano insieme a 'join', 'map' e 'apply'.
Una lista o una stringa è l'input e una stringa l'output.

4.1. Rimuovere i duplicati in una lista
---------------------------------------
(join (map string (unique '(1 1 2 2 2 2 2 2 2 3 2 4 4 3 2 4))))
;->  "1234"

Per rimuovere i duplicati in una stringa, potresti scrivere:

(join (unique (explode "1122222223244324")))
;->  "1234"

Tieni presente che "unique" funziona più velocemente con una lista ordinata.

(join (map string (unique (sort '(1 1 2 2 2 2 2 2 2 3 2 4 4 3 2 4)))))
;->  "1234"

(join (unique (sort (explode "1122222223244324"))))
;->  "1234"

4.2. Quali elementi della lista 1 non si trovano nella lista 2?
---------------------------------------------------------------
(join (map string (difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1))) "-")
;->  "5-6-0"

La stessa domanda può essere applicata alle stringhe: quali caratteri nella stringa 1 non sono nella stringa 2?

(join (difference (explode "25603502") (explode "123321")) "-")
;->  "5-6-0"

4.3. Quali caratteri hanno in comune la lista 1 e la lista 2?
-------------------------------------------------------------
(join (map string (intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5)) ) "-")
;->  "2-4-1"

4.4. Arrotonda (ceil) i numeri di una lista e restituisce una stringa csv
-------------------------------------------------------------------------
(join (map string (map ceil '(1.01 2.53 3.64))) "-")
;->  "2-3-4"

Se hai una stringa CSV con numeri float, puoi eseguire un'operazione simile:

(join (map string (map ceil (map float (parse "1.01;2.53;3.64" ";"))) ) "-")
;->  "2-3-4"

4.5. Combina gli elementi di due liste in una stringa csv a due elementi
------------------------------------------------------------------------
(join (map append '("cats" "dogs" "birds") (dup " " 3 true) '("miaow" "bark" "tweet")) ";")
;->  "cats miaow;dogs bark;birds tweet"

Capisci cosa fa?

(dup " " 3 true)

Bene, restituisce una lista con tre stringhe:

(" " " " " ")

Notare che

(dup " " 3)

restituisce una stringa contenente tre spazi: "   "

Se hai una stringa csv come input, potresti scrivere:

(join (map append (parse "cats;dogs;birds" ";") (dup " " 3 true) (parse "miaow;bark;tweet" ";")) ";")
;->  "cats miaow;dogs bark;birds tweet"

Si noti che il numero 3 nella funzione 'dup' potrebbe essere sostituito da:

(length '("cats" "dogs" "birds")) or (length (parse "cats;dogs;birds" ";"))

4.6. Invertire ogni parola di una lista e restituire una stringa csv
--------------------------------------------------------------------
Lista: (to be or not to be!)

Ricorda che:

(reverse '(To be or not to be!))
;->  (be! to not or be To)

stampa la lista originale al contrario (il che è vero anche se l'argomento è una stringa).

Ora dobbiamo usare la funzione 'map' per applicare la funzione 'reverse' a ciascuna parola.

(join (map reverse (map string '(To be or not to be!))) " ")
;->  "oT eb ro ton ot !eb"

Quindi la lista viene trasformata in una lista di stringhe.
Otteniamo lo stesso risultato con la funzione 'parse' applicata ad una stringa.

(join (map reverse (parse "To be or not to be!")) " ")
;->  "oT eb ro ton ot !eb"

Sezione 5. Elaborazione avanzata delle liste
--------------------------------------------
Le cosiddette liste di associazione, in realtà una serie di liste nidificate -composte da due elementi-, sono un'estensione davvero carina della lista.

((1 "a") (2 "b") (3 "c"))

Essenziale per una lista di associazioni è che il primo elemento della coppia di elementi sia un indice del secondo.
Due funzioni sono rilevanti qui: 'assoc' e 'lookup' estraggono i dati della lista di associazione

5.1. 'assoc'
------------
(setq mc-data '((1 "a") (2 "b") (3 "c")))
(assoc 3 mc-data)
;->  (3 "c")

5.2. 'lookup'
-------------
(setq mc-data '((1 "a") (2 "b") (3 "c")))
(lookup 3 mc-data)
;->  "c"

A proposito, questo esempio può anche essere realizzato con vettore multidimensionale (di cui parleremo in un prossimo tutorial), che sembrano essere più veloci.

5.3. 'assoc' con 'rest'
-----------------------
Naturalmente queste funzioni possono essere combinate con altre funzioni di elaborazione delle liste.
Esempio:

(setq mc-data '((1 (a b)) (2 (b c)) (3 (c d))))
(rest (assoc 3 mc-data))
;->  ((c d))

che è quasi equivalente a:

(lookup 3 mc-data)
;-> (c d)

Per ottenere lo stesso risultato invece di ((c d)) -una lista all'interno di una lista-, applica 'flat':

(flat (rest (assoc 3 mc-data)))
;->  (c d)

5.4. 'find-all'
---------------
Utilizzare 'find-all' per cercare un sottoelenco in un elenco di associazioni che corrisponde a un modello.
'trova tutto' accetta i caratteri jolly (wildcard).

(setq math-score-semester-1-2019 '((John 7) (Tim 6) (Grace 8) (Jessica 7) ))

(find-all '(* 7) math-score-semester-1-2019)
;->  ((John 7) (Jessica 7))

Oppure solo i nomi utilizzando la variabile di sistema $it:

(find-all '(* 7) math-score-semester-1-2019 (first $it))
;->  (John Jessica)

Si noti che 'find-all' ha interessanti applicazioni su liste semplici: vedere www.newlisp.org/downloads/manual_frame.html

6. Bonus
--------
Concludo questo tutorial -solo per divertimento- con due problemi, in cui le funzioni della squadra d'oro e le espressioni regolari vengono applicate ad una stringa.

6.1. Dividere una stringa con un numero diverso del carattere delimitatore '-' e restituire una stringa csv, delimitata da un solo '$'
-------------------------------------------------------------
(join (map title-case (parse "one-two–three—four" "-+" 0)) "$")
;->  "One$Two$Three$Four"

Si noti che un'espressione regolare che corrisponde a una o più occorrenze del trattino-segno meno (-) è '-+'.

6.2. Dividere una stringa che contiene diversi caratteri delimitatori e restituire una stringa CSV, delimitata da un solo "$"
-------------------------------------------------------------
(join (map upper-case (parse "hello, regular expression; why so tricky?" {(; *|, *| +)} 0)) "$")
;->  "HELLO$REGULAR$EXPRESSION$WHY$SO$TRICKY?"

Grazie per la lettura. Alla prossima volta!
Reinier Maliepaard
(ultimo aggiornamento: 18-08-2019)


--------------------
newLisp Challenge 2!
--------------------

Prima di continuare con il Tutorial 5 su newLISP, facciamo ora alcuni esercizi di programmazione newLISP.
Devi risolvere alcuni problemi.
Per farlo con successo, ricorda il contenuto dei miei primi quattro tutorial su newLISP.
Inoltre, puoi utilizzare questo collegamento per informazioni sulle funzioni newLISP: http://www.newlisp.org/downloads/manual_frame.html

Si noti che per alcuni problemi è possibile trovare soluzioni migliori richiamando altre funzioni rispetto a quelle discusse nei primi quattro tutorial.

Di seguito le soluzioni prima per i compiti di livello principiante e poi per quello intermedio.

A. Livello principiante
-----------------------

1. Funzione Between
-------------------
Restituisce la sottostringa tra ad es. { e }, se trovata, oppure restituisce nil.

Esempio:
Restituisce 12 se la sottostringa {12} esiste nell'input

Soluzione:
(if (find "{(.*)}" "There were {12} objects!" 1) $1)

Valore restituito:
"12"

Sorgente:
https://github.com/danielstjules/Stringy#betweenstring-start-string-end–int-offset

2. Funzione camelize
--------------------
Restituisce una versione camelCase della stringa.

Requisiti:
Rifinisce gli spazi circostanti,
Rende maiuscole le lettere che seguono i trattini e i trattini bassi e
Rimuove trattini e caratteri di sottolineatura.

Esempi:
Camel-Case -> camelCase
Camel_Case -> camelCase
Camel-case -> camelCase
CAMEL-cASE -> camelCase

Soluzione:
(append (first (parse (lower-case {CAMEL-cASE}) {_|-} 0 )) (title-case (apply string (rest (parse (lower-case {CAMEL-cASE}) {_|-} 0)))))

Da notare che questa funzione è meno complessa di quanto sembra: alla fine di questo testo la spezzerò nelle parti consistenti. Inoltre, fornirò una soluzione regex.

Valore restituito:
"camelCase"

Sorgente:
https://github.com/danielstjules/Stringy#camelize

3. Funzione Collapsewhitespace
------------------------------
Taglia la stringa e sostituisce i caratteri di spazio consecutivi con un singolo spazio.

Soluzione:
(replace {[ ]+} (trim { A     B           C }) { } 0)

Valore restituito:
"A B C"

Sorgente:
https://github.com/danielstjules/Stringy#collapsewhitespace

4. Funzione Return-CSV
----------------------
Restituisce una stringa CSV composta dai caratteri nell'input, separati ad es. dal delimitatore ";".

Soluzione:
(join (explode {ABC}) {;})

Valore restituito:
"A;B;C"

Sorgente: (modified):
https://github.com/danielstjules/Stringy#chars

5. Funzione Countsubstring
--------------------------
Restituisce il numero di occorrenze di una sottostringa nell'input specificato.

Requisito:
Casesensitive.

Solution, casesensitive:
(if (find-all {a} {A little man shook his bald head.}) $count)

Valore restituito:
3

Solution, caseinsensitive:
(if (find-all {A|a} {A little man shook his bald head.}) $count)

Valore restituito:
4

Sorgente:
https://github.com/danielstjules/Stringy#countsubstrstring-substring–boolean-casesensitive–true-

6. Funzione Dasherize
---------------------
Restituisce una stringa minuscola e tagliata separata da trattini.

Requisiti:
Dashes are inserted before uppercase characters (with the exception of the first character of the string).
Spaces as well as underscores are replaced by dashes.

Example:
fooBar -> foo-bar

Soluzione:
(trim (replace {([A-Z _]{1})} {FooBar} (append {-} (trim (trim (lower-case $1) "_"))) 0) "-")

Valore restituito:
"foo-bar"

Sorgente:
https://github.com/danielstjules/Stringy#dasherize

7. Funzione EnsureLeft
----------------------
Garantisce che l'input inizi con un prefisso specifico.
In caso contrario, il prefisso viene anteposto.

Esempio: (with prefix "https://"):
foobar.com -> https://foobar.com
https://foobar.com -> https://foobar.com

Soluzione:
(if (starts-with {foobar.com} {https://} 1) {foobar.com} (append {https://} {foobar.com} ))

Valore restituito:
"https://foobar.com"

Sorgente:
https://github.com/danielstjules/Stringy#ensureleftstring-substring

8. Funzione EnsureRight
-----------------------
Garantisce che l'input termini con un suffisso specifico.
In caso contrario, il suffisso viene aggiunto.

Example (here with suffix ".com"):
– foobar -> foobar.com
– foobar.com -> foobar.com

(if (ends-with {foobar} {.com} 1) {foobar} (append {foobar} {.com}))

Valore restituito:
"foobar.com"

Sorgente:
https://github.com/danielstjules/Stringy#ensurerightstring-substring

9. Funzione PadLeft
-------------------
Restituisce una stringa di una determinata lunghezza (qui 9) in modo tale che l'inizio della stringa sia riempito.

Soluzione:
(append (dup {$} (- 9 (length {abc}))) {abc})

Valore restituito:
"$$$$$$abc"

Sorgente:
https://github.com/danielstjules/Stringy#padbothint-length–string-padstr—-

10. Funzione PadRight
---------------------
Restituisce una stringa di una determinata lunghezza in modo tale che la fine della stringa sia riempita.

Soluzione:
(append {abc} (dup {$} (- 20 (length {abc}))))

Valore restituito:
"abc$$$$$$$$$$$$$$$$$"

Sorgente:
https://github.com/danielstjules/Stringy#padbothint-length–string-padstr—-

11. Funzione PadBoth
--------------------
Restituisce una stringa di una determinata lunghezza in modo tale che entrambi i lati della stringa siano riempiti.

Requisito:
Inoltre: il riempimento della lunghezza a sinistra e il riempimento della lunghezza a destra possono essere diversi, ma dovresti renderli uguali!

Esempio:
[new-string-length] = 10 e lunghezza [input] = 7 -> X1234567X and not XX1234567X

Soluzione:
(append (dup {X} (/ (- 10 (length {1234567})) 2) ) {1234567} (dup {X} (/ (- 10 (length {1234567})) 2) ))

Valore restituito:
"X1234567X"

Sorgente:
https://github.com/danielstjules/Stringy#padbothint-length–string-padstr—-

12. Funzione RemoveLeft
-----------------------
Restituisce una nuova stringa con il [prefisso] rimosso, se presente.
Qui [prefisso] è "foo".

Soluzione:
(if (starts-with {foobar} {foo}) (slice {foobar} (length {foo})))

Valore restituito:
"bar"

Sorgente:
https://github.com/danielstjules/Stringy#padbothint-length–string-padstr—-

13. Funzione RemoveRight
------------------------
Restituisce una nuova stringa con il [suffisso] rimosso, se presente.
Qui [suffisso] è "bar".

Soluzione:
(if (ends-with {foobar} {bar}) (chop {foobar} (length {bar})))

Valore restituito:
"foo"

Sorgente:
https://github.com/danielstjules/Stringy#padbothint-length–string-padstr—-

14. Funzione Shuffle
--------------------
Restituisce una stringa con i suoi caratteri in ordine casuale.

Soluzione:
(join (randomize (explode {abcdefg})))

Return value could be:
"cgbfead"

Sorgente:
https://github.com/danielstjules/Stringy#shuffle

15. Funzione TrimLeft
---------------------
Restituisce una stringa con un carattere specifico (qui: -) rimosso dall'inizio dell'input.

Soluzione:
(trim {—-abc———} {-} {})

Valore restituito:
"abc———"

Sorgente:
https://github.com/danielstjules/Stringy#trimleft-string-chars

16. Funzione TrimRight
----------------------
Restituisce una stringa con un carattere specifico (qui: -) rimosso dalla fine dell'input.

Soluzione:
(trim {—-abc———} {} {-})

Valore restituito:
"—-abc"

Sorgente:
https://github.com/danielstjules/Stringy#trimright-string-chars

17. Funzione TrimBoth
---------------------
Restituisce una stringa con un carattere specifico rimosso dall'inizio e dalla fine della stringa.
Qui: – dall'inizio e = dalla fine.

Soluzione:
(trim {—abc=====} {-} {=})

Valore restituito:
"abc"

Sorgente:
https://github.com/danielstjules/Stringy#trim-string-chars

18. Funzione Upper-case-first
-----------------------------
Converte il primo carattere della stringa fornita in maiuscolo.

Soluzione:
(title-case {abc})

Valore restituito:
"Abc"

Sorgente:
https://github.com/danielstjules/Stringy#swapcase

19. Funzione Upper-case-all
---------------------------
Converte in maiuscolo il primo carattere di ogni parola nella stringa fornita.

Soluzione:
(join (map title-case (parse {This is the end!})) { })

Valore restituito:
"This Is The End!"

Spiegazione della funzione numero 2: Camelize
(first (parse (lower-case {CAMEL_cASE}) {_|-} 0 ))
;-> "camel"

; the result is "camel", which is a string
; the number 0 is necessary due to the regular expression {_|-}

; find now the second part:

(rest (parse (lower-case {CAMEL_cASE}) {_|-} 0))
;-> ("case")

; the result is ("case"), which is a list
; to convert it to a string, use apply:

(apply string (rest (parse (lower-case {CAMEL_cASE}) {_|-} 0)))
;-> "case"

; the result is "case", which is a string
; uppercase now the first character

(title-case (apply string (rest (parse (lower-case {CAMEL_cASE}) {_|-} 0))))
;-> "Case"

;to glue both results, use the function append which accept strings as parameters:

(append
(first (parse (lower-case {CAMEL-cASE}) {_|-} 0 ))
(title-case (apply string (rest (parse (lower-case {CAMEL-cASE}) {_|-} 0)))))
;-> "camelCase"

Molto più semplice di quanto sembri, vero!

Una soluzione regex (più breve) è:

(replace {([_-]{1})([a-zA-Z]{1})} (lower-case {CAMEL-cASE}) (upper-case $2) 0)
;-> "camelCase"

$0 corrisponde a '-c', $1 '-' e $2 'c' (in questo esempio).
Potresti sostituire [a-zA-Z] con il metacarattere \w

B. Livello intermedio
---------------------

;definire una struttura dati: nome – genere – punteggio (name – gender – score)
(setq mc-data-students '((John Male 6) (Tim Male 8) (Grace Female 4) (Suzanna Female 7)))
;-> ((John Male 6) (Tim Male 8) (Grace Female 4) (Suzanna Female 7))

; estrarre tutti i punteggi
(setq mc-scores (flat (find-all '(* ?) mc-data-students (rest (rest $it)))))
;->  (6 8 4 7)

; quanti punteggi sopra 5?
(length (find-all 5 mc-scores $it <))
;->  3

; media di tutti gli studenti
(div (apply '+ (flat (find-all '(* * *) mc-data-students (rest (rest $it))))) $count)
;->  6.25

; media di tutte le studentesse
(div (apply '+ (flat (find-all '(* Female *) mc-data-students (rest (rest $it))))) $count)
;->  5.5

; media di tutti gli studenti con punteggio > 5
(div (apply '+ (find-all 5 mc-scores $it <)) $count)
;->  7

Spero che sarai ispirato dalle meravigliose possibilità di newLISP.
Implementare il codice in VisualNEO è molto semplice, grazie all'eccellente plugin di Hans-Peter Wickern: https://visualneo.com/product/hpwnewlisp.

Grazie per la lettura. Alla prossima volta!
Reinier Maliepaard
(ultimo aggiornamento: 09-11-2019)


-----------------------------------------------------------
newLISP per VisualNEO Win. Parte 5: altri quattro argomenti
-----------------------------------------------------------

Questo quinto tutorial copre quattro argomenti di newLISP che potrebbero migliorare la tua applicazione VisualNEO.

A. Testare di nuovo i dati
--------------------------
Nel Tutorial 2 abbiamo prestato attenzione ai predicati.
I predicati vengono utilizzati per testare i dati.
Due funzioni non sono classificate sotto Predicati (www.newlisp.org/downloads/manual_frame.html), ma sono molto utili:
exists and for-all.

1. exists
---------
(setq mc-list '(2 "reinier" 1 "hello" 3 8 -1750))
;->  (2 "reinier" 1 "hello" 3 8 -1750)

(list? mc-list)
;->  true

(exists string? mc-list)
;->  "reinier"

(exists number? mc-list)
;->  2

Per verificare se il numero 0 o 0.0 fa parte della lista:

(exists zero? mc-list)
;->  nil

Per verificare se un numero della lista è negativo:

(exists < mc-list)
;->  -1750

Molto interessante è la possibilità di aggiungere una funzione personalizzata a "exists".
La funzione

(fn (x) (> x 3))

nell'esempio successivo controlla se un numero della lista è maggiore di 3.
Il numero 8 è il primo.

(setq mc-list '(2 1 3 8 -1750))
(exists (fn (x) (> x 3)) mc-list)
;->  8

Per verificare se un numero fa parte della lista:

(exists (fn (x) (= x 10)) mc-list)
;->  nil

oppure un po' più facile

(member 10 mc-list)
;->  nil

2. for-all
----------
La funzione 'for-all' controlla se tutti gli elementi in una lista soddisfano la condizione di una funzione. Il risultato è true o nil.

(for-all number? '(2 1 3 8 -1750))
;->  true

(for-all number? '("Bach" 2 1 3 8 1750))
;->  nil

(for-all (fn (x) (= x 1750)) '(1750 1750 1750 1750))
;->  true

(for-all (fn (x) (= x 1750)) '(1685 1750))
;->  nil

Il comando (fn (x) (= x 1750)) è una cosiddetta funzione anonima (vedere la prossima sezione B).

B. Funzioni personalizzate
--------------------------
È possibile definire una funzione. Ad esempio, la funzione somma:

(define (sum x y) (add x y))

È possibile richiamare la funzione come segue:

(sum 2 3)
;->  5

Più interessante è la funzione anonima che puoi utilizzare in situazioni di iterazione (vedi la prossima sezione C)

(fn (x y) (add x y))

Questa funzione può essere chiamata ad es. nella funzione 'for-all', come hai visto nella sezione precedente.
Altri esempi:

(define double (fn (x) (+ x x)))
(double 2)
;->  4

(apply (fn (x) (+ x x)) '(123))
;->  246

(set 'db '((a 3) (g 2) (c 5)))
(sort db (fn (x y) (>= (last x) (last y))))
;->  ((c 5) (a 3) (g 2))

(setq mc-list '("Maeve" "Olivia" "Aurora" "Ada" "Charlotte" "Amara"))
(find "Isla" mc-list (fn (x y) (> (length x) (length y))))
;->  3   ; "Isla" is longer than element 3, "Ada"

(map (fn (x) (pow 2 x)) (sequence 1 10))
;->  (2 4 8 16 32 64 128 256 512 1024)

Per rendere il tuo codice più leggibile, potresti assegnare la funzione a una variabile:

(setq mc-pow2 '(fn (x) (pow 2 x)))
(map mc-pow2 (sequence 1 10))
;->  (2 4 8 16 32 64 128 256 512 1024)

Questo dimostra cosa puoi leggere nei testi su newLISP e Lisp: il codice sorgente e i dati sono intercambiabili.
Davvero, una caratteristica meravigliosa!

C. Iterazione
------------
NewLISP ha diverse funzioni di iterazione.
Le funzioni 'do-until', 'do- while', 'doargs', 'dolist', 'dostring' e 'dotimes' possono esserti utili.
Ma diamo un breve sguardo alla funzione "for".

Il suo uso normale è:

(for (x 1 10 1) (print x))
;->  12345678910

oppure con passo 2

(for (x 1 10 2) (print x))
;->  13579

oppure con passo 0.5

(for (x 3 2 0.5) (print " – " x))
;->  3 – 2.5 – 2

Ma molto interessante è l'opzione per aggiungere alcune condizioni di interruzione al comando 'for':

(for (x 1 100 2 (> (* x x) 30)) (print " – " x))
;->  1 – 3 – 5

D. Potenza di elaborazione
--------------------------
A volte è necessario velocizzare l'applicazione VisualNEO, ad es. in caso di cicli annidati.
Bene, newLISP è tuo amico.
Quello che non ti ho detto è che VisualNEO può comunicare facilmente con estesi script newLISP.
L'idea è: passare le variabili allo script newLISP.

Supponiamo di avere un'applicazione con un oggetto di immissione testo "Utente".
Il contenuto di questo oggetto di immissione testo viene memorizzato nella variabile VisualNeo [mcText]. Gli utenti inseriscono il loro testo lungo.
Vuoi elaborare quel testo con newLISP.
Ora non è più possibile utilizzare una singola espressione newLISP.
Come gestirlo?
Soluzione: devi solo passare [mcText] al codice newLISP.
In pochi passaggi te lo spiegherò.

Passo 1
Crea un secondo oggetto di immissione testo "Code" con il tuo codice sorgente newLISP (posizionalo all'esterno della finestra dell'applicazione).
Il contenuto di questo oggetto di immissione testo viene memorizzato nella variabile [mcNewLISP-code].

Passo 2
Determina la lunghezza del testo dell'utente con StrLen:

  StrLen "[mcText]" "[mcTextLen]"

Passo 3
Aggiungi al secondo oggetto di immissione testo "Coce" i seguenti comandi:

  (setq mcStringLen (nbget "[mcTextLen]" 255))
  (setq size (int mcStringLen))
  (setq mcString (nbget "[mcText]" size))

o in una unica espressione:

  (setq mcString (nbget "[mcText]" (int (nbget "[mcTextLen]" 255))))

Passo 4
Richiamare hpwNewLISPCall nell'applicazione VisualNEO:

  hpwNewLISPCall "[mcNewLISP-code]" "[DllRetvar]"

[DllRetvar] restituirà il risultato.

Potresti anche memorizzare il risultato in un file separato.
Aggiungere al codice newLISP quanto segue alla fine:

  (setq mcOutputFile (replace "\\" (nbget "[Outputfile]" 255) "/"))
  (write-file mcOutputFile mcString)

La variabile VisualNeo [Outputfile] potrebbe essere definita come:

  SetVar "[Outputfile]" "[PubDir]temp.txt"

Il codice newLISP verrà eseguito molto velocemente, migliorando la tua applicazione VisualNEO.

Debugging
---------
Può essere utile in caso di debug impostare una variabile VisualNEO con alcuni valori newLISP, ovvero un risultato intermedio:

(nbset "[CheckVar]" (string mcString ))

E. Conclusioni
--------------
Questo è stato il mio ultimo tutorial su newLISP e VisualNEO.
Spero che ti sia stato utile.
Penso che avrai informazioni sufficienti per continuare da solo il viaggio newLISP-VisualNEO.
Grazie per aver letto i miei tutorial.

Reinier Maliepaard
(ultimo aggiornamento: 08-12-2019)


-------------------------------------------------------------
Numeri che diminuiscono e lettere che aumentano e (viceversa)
-------------------------------------------------------------

Dato un elenco di lettere minuscole [a-z] e numeri interi (ad esempio, ("a", 2, 3, "b")) aumentare le lettere di una posizione nell'alfabeto (ritornando da z ad a) e diminuire i numeri di 1.
Nell'esempio precedente, l'output dovrebbe essere ("b", 1, 2, "c").
Nota: "z" va ad "a", ma 1 va a 0 e 0 va a -1, ecc.
Esempi:

Input                   Output
("a" 2 3 "b")   -->  ("b" 1 2 "c")
("a" "b" "z")   -->  ("b" "c" "a")
(-1 0 257 "x")  -->  (-2 -1 256 "y")
(0 3 1 202876)  -->  (-1 2 0 202875)

(char "a")
;-> 97
(char "z")
;-> 122

Funzione che verifica se una stringa è un solo carattere minuscolo:

(define (lower? ch)
  (and (string? ch) (= (length ch) 1) (>= ch "a") (<= ch "z")))

Numeri diminuiscono e lettere aumentano:

(define (augmentin lst)
  (let (out '())
    (dolist (el lst)
      (cond ((integer? el) (push (- el 1) out -1))
            ((lower? el)
              (if (= el "z")
                  (push "a" out -1)
                  (push (char (+ (char el) 1)) out -1)
              ))
              ; equivalente a
              ;(push (char (+ (% (- (+ (char el) 1) 97) 26) 97)) out -1))
            (true (println "Error: " el))
      )
    )
    out))

(augmentin '("a" 2 3 "b"))
;-> ("b" 1 2 "c")
(augmentin '("a" "b" "z"))
;-> ("b" "c" "a")
(augmentin '(-1 0 257 "x"))
;-> (-2 -1 256 "y")
(augmentin '(0 3 1 202876))
;-> (-1 2 0 202875)

Numeri aumentano e lettere diminuiscono:

(define (digmentin lst)
  (let (out '())
    (dolist (el lst)
      (cond ((integer? el) (push (+ el 1) out -1))
            ((lower? el)
              (if (= el "a")
                  (push "z" out -1)
                  (push (char (- (char el) 1)) out -1)
              ))
            (true (println "Error: " el))
      )
    )
    out))

(digmentin '("a" 2 3 "b"))
;-> ("z" 3 4 "a")
(digmentin '("a" "b" "z"))
;-> ("z" "a" "y")
(digmentin '(-1 0 257 "x"))
;-> (0 1 258 "w")
(digmentin '(0 3 1 202876))
;-> (1 4 2 202877)

(digmentin '("b" 1 2 "c"))
;-> ("a" 2 3 "b")
(digmentin '("b" "c" "a"))
;-> ("a" "b" "z")
(digmentin '(-2 -1 256 "y"))
;-> (-1 0 257 "x")
(digmentin '(-1 2 0 202875))
;-> (0 3 1 202876)


-----------------
Quale presidente?
-----------------

Chi era il Presidente della Repubblica Italiana il giorno/mese/anno?

Abbiamo i dati in una lista con il seguente formato:

          Inizio mandato      Fine mandato
  (Nome (anno mese giorno) (anno mese giorno))

(setq pres
          '(("Enrico De Nicola" (1948 1 1) (1948 5 12))
            ("Luigi Einaudi" (1948 5 12) (1955 5 11))
            ("Giovanni Gronchi" (1955 5 11) (1962 5 11))
            ("Antonio Segni" (1962 5 11) (1964 12 6))
            ("Giuseppe Saragat" (1964 12 29) (1971 12 29))
            ("Giovanni Leone" (1971 12 29) (1978 6 15))
            ("Sandro Pertini" (1978 7 9) (1985 6 29))
            ("Francesco Cossiga" (1985 7 3) (1992 4 28))
            ("Oscar Luigi Scalfaro" (1992 5 28) (1999 5 15))
            ("Carlo Azeglio Ciampi" (1999 5 18) (2006 5 15))
            ("Giorgio Napolitano" (2006 5 15) (2015 1 14))
            ("Sergio Mattarella" (2015 2 3) (2029 2 3))))

Convertiamo le date in numero:

  numero = anno*10000 + mese*100 + giorno

Una data viene rappresentata da una lista: data --> (anno mese giorno)

(define (date-number lst) (+ (* (lst 0) 1e4) (* (lst 1) 1e2) (lst 2)))

(date-number '(1948 1 1))
;-> 19480101
(date-number '(1948 12 31))
;-> 19481231
(date-number '(2023 12 31))
;-> 20231231

Trasformiamo le date della lista "pres":

(define (trasforma lst)
  (local (out nome start end)
    (setq out '())
    (dolist (el lst)
      (setq nome (el 0))
      (setq start (date-number (el 1)))
      (setq end (date-number (el 2)))
      (push (list nome start end) out -1)
    )
    out))

(setq pres (trasforma pres))
;-> (("Enrico De Nicola" 19480101 19480512)
;->  ("Luigi Einaudi" 19480512 19550511)
;->  ("Giovanni Gronchi" 19550511 19620511)
;->  ("Antonio Segni" 19620511 19641206)
;->  ("Giuseppe Saragat" 19641229 19711229)
;->  ("Giovanni Leone" 19711229 19780615)
;->  ("Sandro Pertini" 19780709 19850629)
;->  ("Francesco Cossiga" 19850703 19920428)
;->  ("Oscar Luigi Scalfaro" 19920528 19990515)
;->  ("Carlo Azeglio Ciampi" 19990518 20060515)
;->  ("Giorgio Napolitano" 20060515 20150114)
;->  ("Sergio Mattarella" 20150203 20290203))

Funzione che trova il presidente ad una certa data:

(define (presidente? data)
  (let (out '())
    (setq num (date-number data))
    (dolist (el pres)
      (if (and (>= num (el 1)) (<= num (el 2))) (push (el 0) out -1))
    )
    out))

(presidente? '(1963 8 21))
;-> (Antonio Segni")

(presidente? '(1948 5 12))
;-> ("Enrico De Nicola" "Luigi Einaudi")

(presidente? '(1978 6 21))
;-> ()

-----------------------
Super Mario Lucky House
-----------------------

Nel gioco Super Mario 3D World esiste una slot machine con 4 blocchi chiamata Lucky House.

Ogni blocco può essere uno dei seguenti 5 caratteri:
  fiore, foglia, campana, ciliegia o boomerang

Il punteggio dipende dal numero di caratteri uguali ottenuti con un tiro:
  Tutti caratteri diversi: 10
  Una coppia: 100
  Due coppie: 200
  Tris: 300
  Poker: 777

Scrivere una funzione che simula la Lucky House.

(define (lh)
  (local (out values score ch)
    (setq out '())
    (setq values '())
    (setq score 0)
    (setq ch '("fiore" "foglia" "campana" "ciliegia" "boomerang"))
    (for (i 1 4)
      (setq blocco (rand 5))
      (push blocco values)
      (push (ch blocco) out -1)
    )
    (setq conteggio (count '(0 1 2 3 4) values))
    (setq val-max (apply max conteggio))
    (cond ((= val-max 1) (setq score 10))  ; tutti diversi
          ((= val-max 3) (setq score 300)) ; tris
          ((= val-max 4) (setq score 777)) ; poker
          ((= val-max 2)
            (if (= (length (find-all 2 conteggio)) 2)
                (setq score 200) ; doppia coppia
                (setq score 100) ; coppia singola
            ))
    )
    (list out score)))

(for (i 1 20) (println (lh)))
;-> (("boomerang" "foglia" "boomerang" "foglia") 200)
;-> (("foglia" "campana" "boomerang" "fiore") 10)
;-> (("fiore" "campana" "campana" "fiore") 200)
;-> (("foglia" "boomerang" "foglia" "fiore") 100)
;-> (("fiore" "boomerang" "fiore" "fiore") 300)
;-> (("fiore" "foglia" "boomerang" "foglia") 100)
;-> (("campana" "boomerang" "boomerang" "campana") 200)
;-> (("boomerang" "ciliegia" "foglia" "foglia") 100)
;-> (("fiore" "campana" "boomerang" "foglia") 10)
;-> (("foglia" "campana" "foglia" "ciliegia") 100)
;-> (("boomerang" "campana" "boomerang" "fiore") 100)
;-> (("boomerang" "ciliegia" "ciliegia" "campana") 100)
;-> (("fiore" "foglia" "foglia" "fiore") 200)
;-> (("campana" "fiore" "ciliegia" "boomerang") 10)
;-> (("fiore" "boomerang" "ciliegia" "ciliegia") 100)
;-> (("boomerang" "campana" "ciliegia" "fiore") 10)
;-> (("ciliegia" "ciliegia" "ciliegia" "fiore") 300)
;-> (("boomerang" "ciliegia" "ciliegia" "fiore") 100)
;-> (("campana" "boomerang" "fiore" "foglia") 10)
;-> (("fiore" "boomerang" "ciliegia" "foglia") 10)
;-> (("fiore" "boomerang" "ciliegia" "foglia") 10)

Vediamo le probabilità di ogni combinazione:

(define (prob iter)
  (local (diversi coppia doppia tris poker)
    (set 'diversi 0 'coppia 0 'doppia 0 'tris 0 'poker 0)
    (for (i 1 iter)
      (setq val (last (lh)))
      (cond ((= val 10) (++ diversi))
            ((= val 100) (++ coppia))
            ((= val 200) (++ doppia))
            ((= val 300) (++ tris))
            ((= val 777) (++ poker))
            (true (println "Error: " val))
      )
    )
    (list (div diversi iter) (div coppia iter) (div doppia iter)
          (div tris iter) (div poker iter))))

(prob 1e7)
;-> (0.1919409 0.57597 0.095969 0.1281644 0.0079557)

(add 0.1919409 0.57597 0.095969 0.1281644 0.0079557)
;-> 0.9999999999999999

Notare che è più probabile ottenere un tris che una doppia coppia.

Vediamo i valori della speranza matematica di ogni combinazione:

  speranza = probabilità * punteggio

(map mul '(0.1919409 0.57597 0.095969 0.1281644 0.0079557)
         '(10 100 200 300 777))
;-> (1.919409 57.597 19.1938 38.44932 6.1815789)


------------------------------------
Booleani di Church (Church booleans)
------------------------------------

Un booleano di Church è una funzione che restituisce x per vero e y per falso dove x è il primo argomento della funzione e y è il secondo argomento della funzione.
In notazione di calcolo lambda:

  true = λa.λb.a
  nil  = λa.λb.b

Da queste si possono comporre altre funzioni logiche (and, not, xor, ecc.).
Per esempio:

true(x y) -> x
nil(x y) -> y

and (true true)(x y) -> x
oppure
and (true(x y) true(x y)) -> x

and (true nil)(x y) -> y
oppure
and (true(x y) nil(x y)) -> y
...

Con Mathematica:

  t[x_, y_] := x
  f[x_, y_] := y
  and[x_, y_] := x[y, f]
  or[x_, y_] := x[t, y]
  not[x_] := x[f, t]
  xor[x_, y_] := y[not[x], x]

Vediamo un modo per implementare questi booleani di Church:

#TRUE
TRUE: con parametri x e y, restituisce sempre x
(define (t x y j) x)

#FALSE
FALSE: con parametri x e y, restituisce sempre y
(define (f x y j) y)

#NOT
NOT: con parametri x, y e j ('t' oppure 'f'), restituisce:
  j(y, x)

(define (not-ch x y j) (j y x))
(not-ch 10 20 t)
;-> 20
(not-ch 10 20 f)
;-> 10
Spiegazione:
n è un'espressione lambda che accetta tre parametri: x, y e j.
Ci si aspetta che il parametro j sia una funzione (t o f).
Quindi chiama la funzione j con y e x come parametri e restituisce il risultato.
Ciò significa che restituisce x (se j è t) o y (se j è f).

#AND
AND con parametri x, y, j1 e j2 (j1 e j2 't' oppure 'f') restituisce:
  j1(j2(x, y), y)

(define (a-ch x y j1 j2) (j1 (j2 x y) y))
(a-ch 10 20 t t)
;-> 10
(a-ch 10 20 f f)
;-> 20
(a-ch 10 20 t f)
;-> 20
(a-ch 10 20 f t)
;-> 20

#OR
OR con parametri x, y, j1 e j2 (j1 e j2 't' oppure 'f') restituisce:
  j1(x, j2(x,y))

(define (or-ch x y j1 j2) (j1 x (j2 x y)))
(or-ch 10 20 t t)
;-> 10
(or-ch 10 20 f f)
;-> 20
(or-ch 10 20 t f)
;-> 10
(or-ch 10 20 f t)
;-> 10

#XOR
XOR con parametri x, y, j1 e j2 (j1 e j2 't' oppure 'f') restituisce:
  j1(j2(y,x), j2(x,y))

(define (xor-ch x y j1 j2) (j1 (j2 y x) (j2 x y)))
(xor-ch 10 20 t t)
;-> 20
(xor-ch 10 20 f f)
;-> 20
(xor-ch 10 20 t f)
;-> 10
(xor-ch 10 20 f t)
;-> 10


--------------------------
Sequenza somma delle cifre
--------------------------

La sequenza è definita nel modo seguente:

  a(0) = 1,
  a(1) = 1
  a(n) = somma delle cifre di tutti i termini precedenti
  a(n) = a(n-1) + digit-sum(a(n-1))

Sequenza OEIS A004207:
  1, 1, 2, 4, 8, 16, 23, 28, 38, 49, 62, 70, 77, 91, 101, 103, 107, 115,
  122, 127, 137, 148, 161, 169, 185, 199, 218, 229, 242, 250, 257, 271,
  281, 292, 305, 313, 320, 325, 335, 346, 359, 376, 392, 406, 416, 427,
  440, 448, 464, 478, 497, 517, 530, 538, ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (A004207 num)
  (cond ((= num 1) '(1))
        ((= num 2) '(1 1))
        (true
          (let (out '(1 1))
            (for (i 2 (- num 1))
              (push (+ (out -1) (digit-sum (out -1))) out -1)
            )
          out))))

(A004207 50)
;-> (1 1 2 4 8 16 23 28 38 49 62 70 77 91 101 103 107 115 122 127 137
;->  148 161 169 185 199 218 229 242 250 257 271 281 292 305 313 320
;->  325 335 346 359 376 392 406 416 427 440 448 464 478)


--------------------------------------------------------------
Attraversando il ponte di notte (Crossing the Bridge at Night)
--------------------------------------------------------------

Quattro persone partono dallo stesso lato di un ponte.
Devi aiutarli ad attraversare il ponte e raggiungere l'altro lato.
È notte. C'è una pila elettrica.
Nel ponte possono transitare al massimo due persone alla volta.
Qualsiasi gruppo che attraversa, una o due persone, deve avere la pila.
La pila deve essere spostata avanti e indietro (non può essere lanciata, ecc.)
Ogni persona cammina a una velocità diversa.
Una coppia cammina insieme al ritmo del passo della persona più lenta.
I tempi di percorrenza del ponte di ogni persona sono i seguenti:
  - la persona 1 impiega t1 = 1 minuti per attraversare.
  - la persona 2 impiega t2 = 2 minuti per attraversare.
  - la persona 3 impiega t3 = 5 minuti per attraversare.
  - la persona 4 impiega t4 = 10 minuti per attraversare.

Scriviamo alcune funzioni che ci permettono di simulare questo processo.

Utilizziamo le seguenti variabili globali:

  elapsed = tempo totale di percorrenza del ponte
  sinistra = lista delle persone a sinistra del ponte
  destra = lista delle persone a destra del ponte
  speed = tempi di percorrenza di ogni persona

Adesso definiamo due funzioni per muovere le persone attraverso il ponte.

  avanti(lst)   --> sposta le persone in lst da sinistra a destra
  indietro(lst) --> sposta le persone in lst da destra a sinistra

(define (setup tp)
; variabili globali
  (setq elapsed 0)
  (setq sinistra '(1 2 3 4))
  (setq destra '())
  ; indice 0 = persona 0
  (push 0 speed)
  (setq speed (push 0 tp))
)

(define (avanti lst)
  (local (tempi tempo-max)
    ;(setq tempi (select speed lst))
    ;(setq tempo-max (apply max (select speed lst)))
    ;(println tempi { } tempo-max)
    (++ elapsed (apply max (select speed lst)))      ; update elapsed
    (sort (extend destra lst))                       ; update destra
    (setq sinistra (sort (difference sinistra lst))) ; update sinistra
    (println sinistra { } destra { } elapsed)))      ; print current status

(define (indietro lst)
  (local (tempi tempo-max)
    ;(setq tempi (select speed lst))
    ;(setq tempo-max (apply max tempi))
    ;(println tempi { } tempo-max)
    (++ elapsed (apply max (select speed lst)))  ; update elapsed
    (sort (extend sinistra lst))                 ; update sinistra
    (setq destra (sort (difference destra lst))) ; update destra
    (println sinistra { } destra { } elapsed)))  ; print current status

Con queste funzioni possiamo simulare il processo e cercare la soluzione ottimale (quella che impiega meno tempo per far attraversare il ponte a tutte le persone).

Nota: nessun controllo di correttezza sui dati di input delle funzioni.

La soluzione più ovvia è lasciare che la persona più veloce (persona 1) si accoppi a turno con ogni persona per attraversare il ponte e ritorni poi da solo con la torcia.
Vediamo cosa comporta questo metodo:

Inizializziamo la situazione:
(setup '(1 2 5 10))
;-> (0 1 2 5 10)

1 e 2 attraversano il ponte:
(avanti '(1 2))
;-> (3 4) (1 2) 2

L'output ha il seguente significato:
A sinistra ci sono le persone 3 e 4. A destra ci sono le persone 1 e 2.
Il tempo di percorrenza totale vale 2.

1 torna indietro:
(indietro '(1))
;-> (1 3 4) (2) 3

1 e 3 attraversano il ponte:
(avanti '(1 3))
;-> (4) (1 2 3) 8

1 torna indietro:
(indietro '(1))
;-> (1 4) (2 3) 9

1 e 4 attraversano il ponte:
(avanti '(1 4))
;-> () (1 2 3 4) 19

Con questo metodo impieghiamo 19 minuti per attraversare il ponte.

Per cercare una soluzione migliore bisogna notare che far attraversare individualmente le due persone più lente fa perdere tempo, che potrebbe essere guadagnato se entrambe attraversano insieme.

Inizializziamo la situazione:
(setup '(1 2 5 10))
;-> (0 1 2 5 10)

1 e 2 attraversano il ponte:
(avanti '(1 2))
;-> (3 4) (1 2) 2

1 torna indietro:
(indietro '(1))
;-> (1 3 4) (2) 3

3 e 4 attraversano il ponte:
(avanti '(3 4))
;-> (1) (2 3 4) 13

2 torna indietro:
(indietro '(2))
;-> (1 2) (3 4) 15

1 e 2 attraversano il ponte:
(avanti '(1 2))
;-> () (1 2 3 4) 17

Con questo metodo impieghiamo 17 minuti per attraversare il ponte.

Dal punto di vista matematico il tempo minimo per quattro persone è dato dalla seguente equazione (con t1 < t2 < t3 < t4):

  min(t1 + t2 + t3 + t1 + t4, t1 + t2 + t4 + t2 + t2) =
  = min(2t1 + t2 + t3 + t4, t1 + 3t2 + t4) =
  = min(t1 + t3, 2t2 + t4)

Per una trattazione completa del problema esteso a N persone vedi:
"Crossing the Bridge at Night" di Rote Gunter (2002) - Istituto Informatica dell'Università di Berlino.


------------------------------
Espansione di un numero intero
------------------------------

Da bambini, in prima o seconda elementare, utilizzavamo la forma estesa per conoscere il valore posizionale dei numeri.
È più facile spiegarlo con un esempio.
Consideriamo il numero 123:
in forma estesa è rappresentato come 100 + 20 + 3.
In parole: cento (più) venti (più) tre.

Scrivere una funzione che espande un numero intero.

(define (espandi num)
  (local (str pos cifra valore)
    (setq str "")
    (setq pos 0)
    ; ciclo per ogni cifra
    (while (!= num 0)
      ; cifra corrente
      (setq cifra (% num 10))
      ; valore in base alla posizione della cifra
      (setq valore (* cifra (pow 10 pos)))
      ; aggiorna la stringa di output
      (if (!= valore 0) (setq str (append (string valore " + ") str)))
      ; prossima cifra
      (setq num (/ num 10))
      ; prossima posizione
      (++ pos)
    )
    ; output (caso del numero 0):
    (if (= str "") "0" (chop str 3))))

Facciamo alcune prove:

(espandi 1234)
"1000 + 200 + 30 + 4"
> (espandi 1000)
"1000"
> (espandi 24601)
"20000 + 4000 + 600 + 1"
> (espandi 8)
"8"
> (espandi 0)
"0"


-----------------
Algoritmo di Luhn
-----------------

Questo algoritmo, conosciuto anche come Modulo 10, che consente di generare e verificare la validità di vari numeri identificativi (es. carte di credito).
Venne ideata nel 1954 dall'informatico dell'IBM Hans Peter Luhn, brevettata nel 1960 è ora di pubblico dominio.
Ogni carta di credito ha un suo numero di carta (es. 0000-1234-5678-9123) dove la prima parte identifica il circuito internazionale (Visa, American Express, Mastercard...) mentre il resto la banca ed il cliente.

L'algoritmo è il seguente:
Passo 1:
partendo dalla cifra più a destra, raddoppiare il valore di ogni seconda cifra.

Passo 2:
Se il raddoppio di un numero dà come risultato un numero a due cifre, ovvero maggiore di 9 (ad esempio, 5 * 2 = 10), allora aggiungere le cifre del prodotto (ad esempio, 10: 1 + 0 = 1) per ottenere un numero a una cifra.

Passo 3:
Sommare tutte le cifre.

Passo 4:
Se la somma modulo 10 è uguale a 0 (se il totale termina con zero) allora il numero è valido secondo la formula di Luhn, altrimenti non è valido.

Per capire meglio l'algoritmo vediamo un esempio.
Consideriamo il numero 79937291783:

 0 7 9 9 3 7 2 9 1 7 8 3  numero
 0   18  6   4   2   16   raddoppio dei numeri posto pari (da destra)
     9   6   4   2   7    cifra unica
 0 7   9   7   9   7   3  numeri posto dispari (da destra)

 0 7 9 9 6 7 4 9 2 7 7 3  numeri da sommare

(+  0 7 9 9 6 7 4 9 2 7 7 3)
;-> 70

  (70 mod 10) = 0 ==> numero valido (secondo la formula di Luhn)

(define (digit-root num)
"Calculates the repeated sum of the digits of an integer"
    (+ 1 (% (- (abs num) 1) 9)))

(define (luhn num)
  (local (somma secondo val)
    (setq num (reverse (explode (string num))))
    (setq somma 0)
    (setq secondo nil)
    (dolist (el num)
      (setq val (int el))
      (if secondo
          (++ somma (digit-root (* val 2)))
          (++ somma val)
      )
      (setq secondo (not secondo))
    )
    ;(println somma)
    (zero? (% somma 10))))

Facciamo alcune prove:

(luhn "079937291783")
;-> true

(luhn "0736892374903")
;-> nil

(luhn "0624356783073")
;-> true

Possiamo anche creare un numero di Luhn.

Funzione che calcola la somma di luhn di un numero:

(define (luhn-somma num)
  (local (somma secondo val)
    (setq num (reverse (explode (string num))))
    (setq somma 0)
    (setq secondo nil)
    (dolist (el num)
      (setq val (int el))
      (if secondo
          (++ somma (digit-root (* val 2)))
          (++ somma val)
      )
      (setq secondo (not secondo))
    )
    somma))

(luhn-somma "135625538987")
;-> 55

Funzione che crea un numero di Luhn (12 cifre):

(define (create-luhn)
  (local (numero somma secondo val diff)
    ; genera una lista casuale di 10 cifre
    (setq lst (rand 10 10))
    ; converte la lista in stringa
    (setq numero (join (map string lst)))
    ; calcola la somma di luhn
    (setq somma (luhn-somma numero))
    ; calcola il valore (cifra) da aggiungere per fare in modo che:
    ; (somma + cifra) mod 10 = 0
    (setq diff (% (- 10 (% somma 10)) 10))
    ; cambiamo le ultime due cifre (a e b) con i valori più semplici (base)
    ; diff = d1 + d2 = a*2 + b
    ; per esempio il valore 0 potrebbe essere dato da:
    ; a = 0, b = 0 --> 0*2 = 0 0 + 0 = 0 (caso base) oppure
    ; a = 6, b = 7 --> 6*2=12 -> 3 + 7 = 10
    (cond ((= diff 0) (setq a 0) (setq b 0)) ; caso base
          ((= diff 1) (setq a 0) (setq b 1)) ; caso base
          ((= diff 2) (setq a 1) (setq b 0)) ; caso base
          ((= diff 3) (setq a 1) (setq b 1)) ; caso base
          ((= diff 4) (setq a 2) (setq b 0)) ; caso base
          ((= diff 5) (setq a 2) (setq b 1)) ; caso base
          ((= diff 6) (setq a 2) (setq b 2)) ; caso base
          ((= diff 7) (setq a 3) (setq b 1)) ; caso base
          ((= diff 8) (setq a 4) (setq b 0)) ; caso base
          ((= diff 9) (setq a 4) (setq b 1)) ; caso base
    )
    (push (string a) numero -1) ; penultima cifra
    (push (string b) numero -1) ; ultima cifra
    numero))

Facciamo alcune prove:

(create-luhn)
;-> "336928396231"
(create-luhn)
;-> "235220178620"
(create-luhn)
;-> "804692678910"
(luhn (create-luhn))
;-> true

(for (i 1 1e5) (if (not (luhn (create-luhn))) (println "error")))
;-> nil


-------------------------------------------------------------------
Sfida a Donald Knuth: k parole più frequenti (literate programming)
-------------------------------------------------------------------

Questa è una nota sfida sulla programmazione.
Nel 1986 Jon Bentley chiese a Donald Knuth di scrivere un programma in grado di trovare le k parole più frequenti in un file.
Knuth ha implementato una soluzione utilizzando gli "hash tries" in un programma di 8 pagine per illustrare la sua tecnica di "literate programming" (vedi nota alla fine).

"Programming Pearls"
"A literate programming" Jon Bentley, Don Knuth e Doug McIlroy
"https://www.cs.tufts.edu/~nr/cs257/archive/don-knuth/pearls-2.pdf"

Descrizione originale del problema:
Dato un file di testo e un numero intero k, stampare le k parole più frequenti nel file (e il numero delle loro occorrenze) con frequenza decrescente.

Ulteriori chiarimenti sul problema:
- Knuth definisce una parola come una stringa di lettere latine: [A-Za-z]+
- Tutti gli altri caratteri vengono ignorati
- le lettere maiuscole e minuscole sono considerate equivalenti

Soluzione con newLISP
---------------------
Possiamo utilizzare la funzione "bayes-train" per scansionare una lista di parole e memorizzare le frequenze delle parole in un nuovo contesto ctx):

(bayes-train '("we" "are" "you" "we" "is" "it" "are") 'ctx)
;-> (7) ; numero degli elementi della lista

Adesso il contesto contiene un elenco di parole che compaiono nella lista e le frequenze di ciascuna. Ad esempio:

(ctx)
;-> (("are" (2)) ("is" (1)) ("it" (1)) ("we" (2)) ("you" (1)))

ctx:_we
;-> (2)

I nomi delle simboli sono preceduti da "_" nel contesto.
Comunque possiamo trasformare i simboli del contesto (e i loro valori) con una semplice assegnazione:

(setq lista (ctx))
;-> (("are" (2)) ("is" (1)) ("it" (1)) ("we" (2)) ("you" (1)))
(list? lista)
;-> true

Per creare la lista di parole utilizziamo la funzione "parse".
Il file di test è "dorian-grey.txt" che si trova nella cartella "data".

(silent
(setq dorian
  (parse (lower-case
         (read-file "dorian-grey.txt")) {\W} 0)))

Il parametro {\W} indica a regex di prendere solo le parole (Words).

(length dorian)
;-> 110762
(slice dorian 100 20)
;-> ("are" "corrupt" "without" "" "being" "charming"
;->  "" "" "this" "is" "a" "fault" "" "" "" ""
;->  "those" "who" "find" "beautiful")

Scriviamo la funzione finale:

(define (freq file k)
  (local (lst out)
    ; elimina i dati dal contesto (se esiste)
    (if (context? U) (delete 'U))
    ; divide (parse) il file in parole
    (setq lst (parse (lower-case (read-file file)) {\W} 0))
    ; crea le parole (simboli) e le relative frequenze (valori) nel contesto U
    (bayes-train lst 'U)
    ; inserisce i simboli del contesto in una lista: (simbolo valore)
    (setq out (U))
    ; inserisce i simboli del contesto in una lista: (valore simbolo)
    ;(dotree (s U true) (push (list (first (eval s)) (eval (term s))) out -1))
    ; ordina la lista in base ai valori di frequenza
    ; ed estrae i primi k termini
    (slice (sort lista (fn (x y) (>= (last x) (last y)))) 0 k))

Proviamo la funzione:

(freq "dorian-grey.txt" 10)
;-> ((30346 "_") (3762 "_the") (2211 "_and") (2175 "_of")
;->  (2101 "_to") (1694 "_i") (1672 "_a") (1541 "_he")
;->  (1445 "_you") (1361 "_that"))

Nota: Literate Programming
--------------------------
La "literate programming" è una tecnica di programmazione proposta da Donald Knuth negli anni '80.
L'obiettivo della literate programming è quello di scrivere il codice in un modo che sia più comprensibile e leggibile per gli esseri umani.

Nel contesto della literate programming, il programma non è scritto come una serie lineare di istruzioni, ma piuttosto come un racconto o un documento.
Questo documento combina il codice sorgente con spiegazioni dettagliate e documentazione testuale.
Knuth ha creato un sistema chiamato "WEB" per la scrittura di programmi con questa tecnica.

Vantaggi della literate programming:

Maggiore comprensibilità: La documentazione testuale inclusa nel programma aiuta gli sviluppatori a comprendere meglio il codice e le sue funzioni.

Facilità di manutenzione: La documentazione dettagliata aiuta ad individuare i bug o a migliorare il codice in modo più efficace.

Maggiore collaborazione: La chiarezza della documentazioni facilita la comunicazione tra gli sviluppatori.

Generazione automatica della documentazione: La documentazione dei programmi può essere effettuata automaticamente a partire dal codice sorgente.

Svantaggi della literate programming:

Tempo di sviluppo maggiore: la literate programming richiede un impegno maggiore nella scrittura e nella documentazione (il che potrebbe renderla meno adatta a molti i tipi di progetti software).

Bassa adozione: non è stata adottata in modo diffuso nel settore dell'industria del software.


-------------
Elenco di Noè
-------------

Genesi 7
--------
Il Signore disse a Noè:
"Entra nell'arca tu con tutta la tua famiglia, perché ti ho visto giusto dinanzi a me in questa generazione.
Di ogni animale puro prendine con te sette paia, il maschio e la sua femmina;
degli animali che non sono puri un paio, il maschio e la sua femmina.
Anche degli uccelli del cielo, sette paia, maschio e femmina, per conservarne in vita la razza su tutta la terra.
Perché tra sette giorni farò piovere sulla terra per quaranta giorni e quaranta notti; cancellerò dalla terra ogni essere che ho fatto".
Noè fece quanto il Signore gli aveva comandato.

Nota: gli animali puri sono quelli adatti al sacrificio

Tralasciando la differenza tra animali puri e impuri, chiamiamo "elenco di Noè" una lista in cui ogni intero ha una sua copia (maschio e femmina).
In altre parole, una lista in cui tutti i numeri sono ripetuti solo due volte.

Primo metodo:

(define (noe1? lst)
  (for-all (fn(x) (= x 2)) (count (unique lst) lst)))

(noe1? '(7 13 9 2 10 2 4 10 7 13 4 9))
(noe1? '(1 2 3 1 2 3))
(noe1? '(10 100 1000 1 100 10 1000 1))
(noe1? '(123 123))
(noe1? '(8 22 57189 492 22 57188 8 492 57188 57189 1 1))
(noe1? '(1 1))

(noe1? '(6 4 4 6 4 7 4 7))
(noe1? '(2 2 2 2 2 2))
(noe1? '(5 1 4 5 1 1 4))
(noe1? '(77 31 5 31 80 77 5 8 8))
(noe1? '(1 2 3 2 1))
(noe1? '(44 4 4))
(noe1? '(500 30 1))
(noe1? '(1 2 1 1))
(noe1? '(2 4 6 4 4 4))
(noe1? '(2 23 34 4))
(noe1? '(2 23 3 3 34 4))

Secondo metodo:

(define (noe2? lst)
  (let ((conta (count (unique lst) lst))
        (len (length conta)))
    (or (and (= (conta 0) 2) (= (length conta) 1))
        (and (= (conta 0) 2) (apply = conta)))))

(noe2? '(7 13 9 2 10 2 4 10 7 13 4 9))
(noe2? '(1 2 3 1 2 3))
(noe2? '(10 100 1000 1 100 10 1000 1))
(noe2? '(123 123))
(noe2? '(8 22 57189 492 22 57188 8 492 57188 57189 1 1))
(noe2? '(1 1))

(noe2? '(6 4 4 6 4 7 4 7))
(noe2? '(2 2 2 2 2 2))
(noe2? '(5 1 4 5 1 1 4))
(noe2? '(77 31 5 31 80 77 5 8 8))
(noe2? '(1 2 3 2 1))
(noe2? '(44 4 4))
(noe2? '(500 30 1))
(noe2? '(1 2 1 1))
(noe2? '(2 4 6 4 4 4))
(noe2? '(2 23 34 4))
(noe2? '(2 23 3 3 34 4))

Vediamo la velocità delle due funzioni:

(setq test (flat (dup '(1 2 3) 100)))
(time (noe1? test) 1e5)
;-> 4674.145
(time (noe2? test) 1e5)
;-> 4683.183

(setq test (flat (dup '(1 2 3) 10000)))
(time (noe1? test) 1e3)
;-> 7435.053
(time (noe2? test) 1e3)
;-> 7412.839


-----------------------------------------------
Eliminazione dei caratteri non ASCII in un file
-----------------------------------------------

Dato un file di testo, scrivere una funzione che crea un nuovo file in cui sono stati eliminati tutti i caratteri non ASCII (< 127) presenti nel file di input.
La funzione deve restituire la lista dei caratteri non ASCII.

(define (ascii-file file1 file2)
  (local (in-file out-file chr non-ascii)
    (setq in-file (open file1 "read"))
    (if file2
        (setq out-file (open file2 "write"))
        (setq out-file (open (extend file1 ".txt") "write"))
    )
    (setq non-ascii '())
    (while (setq chr (read-utf8 in-file))
        ;solo caratteri ascii
        (if (< chr 127)
            (write-char out-file chr) ; write ASCII char
            (push chr non-ascii -1)   ; put non-ASCII char on list
        )
    )
    (close in-file)
    (close out-file)
    non-ascii))

Usiamo il file seguente per prova:

"utf8-file.txt"
----------------
← ↑ → ↓
αβγδεζηθκλμνξπρστυφχψω
π ∞ ∏ ∑
133 à 0224 Alt+F8
138 è 0232 Alt+F9
141 ì 0236 Alt+F10
149 ò 0242 Alt+F11
151 ù 0249 Alt+F12
254 ■
223 ▀
219 █
lambda λ
(print "╔") (print "╗") (print "╚") (print "╝")
(char "·")
;-> 33554432
(char "∙")
;-> 16777216
(char "●")
;-> 63
----------------

Eseguiamo la funzione:

(real-path)
(ascii-file "utf8-file.txt" "ascii-file.txt")
;-> (8592 8593 8594 8595 945 946 947 948 949 950 951 952 954 955 956 957 958 960 961
;->  963 964 965 966 967 968 969 960 8734 8719 8721 224 232 236 242 249 9632 9600 9608
;->  955 9556 9559 9562 9565 183 8729 9679)

Il file creato è il seguente:

"ascii-file.txt"
----------------



133  0224 Alt+F8
138  0232 Alt+F9
141  0236 Alt+F10
149  0242 Alt+F11
151  0249 Alt+F12
254
223
219
lambda
(print "") (print "") (print "") (print "")
(char "")
;-> 33554432
(char "")
;-> 16777216
(char "")
;-> 63
----------------

La lista di output contiene i valori decimali dei caratteri utf8 presenti nel file di input.


---------------------
Text file utilities 2
---------------------

filedemo.txt
-------------------
Line 1
Line 2

  Line 3
Line 4
Line 4
  Line 4
lambda λ
pigreco π
133 à 0224 Alt+F8
138 è 0232 Alt+F9
141 ì 0236 Alt+F10
149 ò 0242 Alt+F11
151 ù 0249 Alt+F12
-------------------

(define (lwc-count in-file unix)
"Counts lines, words and chars of a text file"
  (local (line lc wc cc)
    (setq lc 0 wc 0 cc 0)
    (setq in-file (open in-file "read"))
    (while (setq line (read-line in-file))
      ; lines count
      (++ lc)
      ; words count
      (setq wc (+ wc (length (parse (trim line) "\\s+" 0))))
      ; chars count
      ; (+1 add back the line feed - Unix)
      ; (+2 add back the line feed/carriage return - Windows)
      (if unix
        (setq cc (+ cc (length line) 1))
        (setq cc (+ cc (length line) 2))
      )
    )
    (close in-file)
    (list lc wc cc)))

(lwc-count "filedemo.txt")
;-> (16 38 222)

(define (print-file in-file pause)
"Print a text file (stdout)"
    (setq in-file (open in-file "read"))
    (while (read-line in-file)
      (cond ((nil? pause) (println (current-line)))
            (true  (print (current-line) (read-line))))
    )
    (close in-file))

(print-file "filedemo.txt")

(define (list-file in-file)
"Create a list with all the lines of a text in-file"
  (let (lst '())
    (setq in-file (open in-file "read"))
    (while (read-line in-file)
      (push (current-line) lst -1))
    (close in-file)
    lst))

(list-file "filedemo.txt")

(define (unique-lines in-file out-file)
  (local (lst ext)
    (setq lst '())
    (setq in-file (open in-file "read"))
    (setq out-file (open out-file "write"))
    (while (read-line in-file)
      (push (current-line) lst -1))
    (close in-file)
    (setq lst (unique lst))
    (map (fn(line) (write-line out-file line)) lst)
    (close out-file)))

(unique-lines "filedemo.txt" "unique.txt")

(define (sort-file in-file out-file order)
"Sort the lines of a text file"
  (let (lst '())
    (setq in-file (open in-file "read"))
    (setq out-file (open out-file "write"))
    (while (read-line in-file)
      (push (current-line) lst -1)
    )
    (close in-file)
    (sort lst order)
    (println lst)
    (map (fn(line) (write-line out-file line)) lst)
    (close out-file)))

(sort-file "filedemo.txt" "sort.txt" >)
(sort-file "filedemo.txt" "sort2.txt" <)

(define (extract-lines start end in-file out-file)
"Extract lines from a text file"
  (let (lst '())
    (setq in-file (open in-file "read"))
    (setq out-file (open out-file "write"))
    ; put lines on list
    (while (read-line in-file)
      (push (current-line) lst -1))
    (close in-file)
    ; extract lines from list
    (setq lst (slice lst (- start 1) (+ (- end start) 1)))
    (map (fn(line) (write-line out-file line)) lst)
    (close out-file)))

(extract-lines 1 5 "filedemo.txt" "linee1-5.txt")
(print-file "linee1-5.txt")

(define (cat file1 file2 out-file)
  (local (lst ext)
    (setq lst '())
    (setq out-file (open out-file "write"))
    (setq file1 (open file1 "read"))
    (while (read-line file1)
      (push (current-line) lst -1))
    (close file1)
    (setq file2 (open file2 "read"))
    (while (read-line file2)
      (push (current-line) lst -1))
    (close file2)
    (map (fn(line) (write-line out-file line)) lst)
    (close out-file)))

(cat "filedemo.txt" "filedemo.txt" "due.txt")
(print-file "due.txt")

(define (crypt-file in-file out-file pwd)
"Crypt a text file"
  (write-file out-file (encrypt (read-file in-file) pwd)))

(crypt-file "filedemo.txt" "temp.txt" "newlisp")

(define (decrypt-file in-file out-file pwd)
"Decrypt a text file"
  (write-file out-file (encrypt (read-file in-file) pwd)))

(decrypt-file "filedemo.txt" "filedemo1.txt" "newlisp")

(define-macro (println-unix)
"Print unix style \n"
  (apply print (map eval (args)))
  (print "\n"))

(define-macro (println-windows)
"Print windows style \r\n"
  (apply print (map eval (args)))
  (print "\r\n"))

(define (hex-dump file)
"hex-dump of ASCII file"
  (local (in-file line sofar buff)
    (setq in-file (open file "read"))
    (setq line 0)
    ; read file with buffer of 16 char
    (while (> (setq sofar (read-buffer in-file buff 16)) 0)
      ; print number of char (es. 00000016)
      (print (format "%08d - " (++ line 16)))
      ; fill buffer to 16 char (if necessary)
      (if (< sofar 16)
          (dotimes (x (- 16 sofar))
            (extend buff (char 0)))
      )
      ; print hex value of chars of buffer
      (dolist (x (explode buff)) (print (format "%02X " (char x))))
      ; format last line with space
      (if (< sofar 16) (print (dup " " (* 3 (- 16 sofar)))))
      ; print chars of buffer
      (dolist (x (explode buff))
        (if (and (>= (char x) 32) (<= (char x) 126))
            (print x)   ; ASCII char: x
            (print ".") ; non-ASCII char: "."
        )
      )
      (print "\n")
    )
    (close in-file)))

(save "dump.lsp" 'hex-dump)
(hex-dump "dump.lsp")

(define (ascii-file in-file out-file)
"Create a file with only ASCII chars from a text file"
  (local (chr non-ascii)
    (setq in-file (open in-file "read"))
    (setq out-file (open out-file "write"))
    (setq non-ascii '())
    (while (setq chr (read-utf8 in-file))
        ;solo caratteri ascii
        (if (< chr 127)
            (write-char out-file chr) ; write ASCII char on file
            (push chr non-ascii -1)   ; put non-ASCII char on list
        )
    )
    (close in-file)
    (close out-file)
    non-ascii))

(ascii-file "filedemo.txt" "ascii.txt")


-------------------
Roulette simulation
-------------------

La roulette francese ha 37 numeri (da 0 a 36), di cui 18 sono rossi e 18 sono neri. Lo zero è verde.
Il croupier (colui che manovra la roulette) lancia una pallina che cadrà in una delle sezioni numerate.

Vedi l'immagine "roulette-francese.png" nella cartella "data".

Disposizione dei numeri sulla ruota della roulette:
0-32-15-19-4-21-2-25-17-34-6-27-13-36-11-30-8-23-10-5-24-16-33-1-20-14-31-9-22-18-29-7-28-12-35-3-26

Inoltre abbiamo un tavolo da gioco verde suddiviso in diverse aree, ognuna corrispondente alle diverse possibilità di puntata.

                       +--------------+
                       |      0       |
    +---+--------------+--------------+--------------+---+
    |   |              |  1 |  2 |  3 |              |   |
    |   |              +----+----+----+              |   |
    |   |              |  4 |  5 |  6 |              |   |
    | P |    PASSE     +----+----+----+    MANQUE    | P |
    |   |    19-36     |  7 |  8 |  9 |     1-18     |   |
    |   |              +----+----+----+              |   |
    |   |              | 10 | 11 | 12 |              |   |
    +---+--------------+----+----+----+--------------+---+
    |   |              | 13 | 14 | 15 |              |   |
    |   |              +----+----+----+              |   |
    |   |              | 16 | 17 | 18 |              |   |
    | M |     PAIR     +----+----+----+    IMPAIR    | M |
    |   |     PARI     | 19 | 20 | 21 |    DISPARI   |   |
    |   |              +----+----+----+              |   |
    |   |              | 22 | 23 | 24 |              |   |
    +---+--------------+----+----+----+--------------+---+
    |   |              | 25 | 26 | 27 |              |   |
    |   |              +----+----+----+              |   |
    |   |              | 28 | 29 | 30 |              |   |
    | D |     NOIR     +----+----+----+    ROUGE     | D |
    |   |     NERO     | 31 | 32 | 33 |    ROSSO     |   |
    |   |              +----+----+----+              |   |
    |   |              | 34 | 35 | 36 |              |   |
    +---+----+----+----+----+----+----+----+----+----+---+
        |12P |12M |12D | C1 | C2 | C3 |12D |12M |12P |
        +----+----+----+----+----+----+----+----+----+

0 -> "en prison"

Ogni area del panno è abbinata ad un numero, un colore o qualche altra opzione su cui ognuno può scommettere delle fiches (cercando di indovinare dove si posizionerà la pallina nella roulette).
Conoscere quali sono le puntate possibili e quanto pagano in caso di vittoria è fondamentale per definire le proprie strategie di gioco.
Le combinazioni su cui è possibile puntare sono svariate, ognuna delle quali è quotata (36/N)-1, dove N è la quantità di numeri compresi nella combinazione scelta.

Tipi di puntate/scommesse
-------------------------
1) Plein (singolo numero)
un numero
35 volte la somma puntata

2) Cheval (cavallo o coppia di numeri)
due numeri trasversali adiacenti (es. 8-9, 31-32)
17 volte la somma puntata

3) Transversale Pleine (terzina)
tre numeri trasversali adiacenti (es. 4-5-6, 28-29-30)
11 volte la somma puntata

4) Carré (quartina)
quattro numeri in quadrato (es. 29-30-32-33)
8 volte la somma puntata

5) Transversale Simple (sestina)
sei numeri che formano un blocco 2x3 (es. 25-26-27-28-29-30)
5 volte la somma puntata

6) Douzaine - Premier, Milieu, Dernier (dozzina - prima, seconda o terza)
1-12 Premier, 13-24 Milieu, 25-36 Dernier
2 volte la somma puntata

7) Colonne (colonna, prima, seconda o terza)
1->34, 2->35, 3->36
2 volte la somma puntata

8) Pair ou Impair (pari o dispari)
numeri pari o dispari
1 volta la somma puntata

9) Manque (bassi)
numeri da 1 a 18
1 volta la somma puntata

10) Passe (alti)
numeri da 19 a 36
1 volta la somma puntata

11) Rouge ou Noir (rosso o nero)
numeri rossi o neri
1 volta la somma puntata

Calcoliamo quanto paga ogni combinazione in caso di successo:

(define (quota n) (- (div 36 n) 1))

(setq number '(("plein" 1) ("cheval" 2) ("trans3" 3) ("carre" 4)
               ("trans6" 6) ("douzaine" 12) ("colonne" 12)
               ("pair" 18) ("impair" 18) ("manque" 18) ("passe" 18)
               ("rouge" 18) ("noir" 18)))

(map (fn(x) (list (x 0) (quota (x 1)))) number)
;-> (("plein" 35) ("cheval" 17) ("trans3" 11) ("carre" 8) ("trans6" 5)
;->  ("douzaine" 2) ("colonne" 2) ("pair" 1) ("impair" 1) ("manque" 1)
;->  ("passe" 1) ("rouge" 1) ("noir" 1))

Sistemi di gioco
----------------
Esistono poi diversi sistemi di gioco codificati a livello internazionale.
I più comuni sono: i vicini dello zero, la serie 5/8, gli orfanelli, gli zero spiel, i tiers press e la nassa.

I "vicini dello zero" ("Les voisins du zéro") sono una serie di 17 numeri ubicati sul cilindro alla destra e alla sinistra dello zero tra il 22 e il 25 compresi, e si possono giocare con un totale di 9 fiche.
I numeri in questione sono 0-2-3, 4-7, 12-15, 18-21, 19-22, 25-26-28-29, 32-35 con due fiche sullo 0-2-3 e sul carrè 25-29.

La "serie 5/8" ("tiers du cylindre" o più semplicemente "tiers") è composta da 12 numeri giocabili con 6 fiche su 6 cavalli, i numeri sono 5-8, 10-11, 13-16, 23-24, 27-30, 33-36, e sono ubicati, sul cilindro, in maniera diametralmente opposta ai "vicini dello zero".

Gli "orfanelli" (o "orphelins"), così chiamati proprio perché non facenti parte di nessuna delle due serie sopra esposte, sono gli 8 numeri rimanenti, ossia 1, 6-9, 14-17, 17-20, 31-34 (l'1 pieno, gli altri a cavallo), si possono giocare con 5 fiche e sono ubicati, in parte sul lato sinistro e in parte sul lato destro del cilindro, che per consuetudine viene rappresentato con lo "0" in alto.

"Zero Spiel" è un piccolo settore di 7 numeri a destra e sinistra dello zero che vengono coperti con 4 fiche.
In pratica una versione ridotta dei "vicini dello zero". I numeri che ne fanno parte sono 0-3, 12-15, 26 (in pieno), 32-35.

"Tiers press", come la "tiers" normale (5-8-10-11-13-16-23-24-27-30-33-36) con l'aggiunta dei pieni dei primi quattro numeri (ossia 5-8-10-11) per un totale di 10 fiche.

"Nassa" si effettua puntando 5 fiche, che vanno a coprire 8 numeri vicini dello zero: il 26 e il 19 pieni e i cavalli 0-3, 12-15, 32-35 (21.6% di probabilità di vincita)

Nella simulazione useremo solo i tipi di scommesse e non i sistemi di gioco.

; Funzione di setup per iniziare una nuova simulazione
; (tutte le variabili sono globali)
(define (roulette budget)
  ; Lista delle scommesse
  (setq bets '())
  ; Fiches totali del giocatore
  (setq fiches budget)
  ; Lista delle combinazioni e delle relative quotazioni
  (setq reward '(("plein" 35) ("cheval" 17) ("trans3" 11) ("carre" 8)
                 ("trans6" 5) ("douzaine" 2) ("colonne" 2)
                 ("pair" 1) ("impair" 1) ("manque" 1) ("passe" 1)
                 ("rouge" 1) ("noir" 1)))
  ; Liste dei numeri associati ad ogni combinazione
  (setq red '(1 3 5 7 9 12 15 18 19 21 23 25 27 30 32 34 36))
  (setq black '(2 4 6 810 11 13 15 17 20 22 24 26 28 29 31 33 35))
  (setq even (sequence 2 36 2))
  (setq odd (sequence 1 35 2))
  (setq low (sequence 1 18))
  (setq high (sequence 19 36))
  (setq column (list (sequence 1 34 3) (sequence 2 35 3) (sequence 3 36 3)))
  (setq dozen (list (sequence 1 12) (sequence 13 24) (sequence 25 36)))
  (println "Fiches: " fiches))

; Funzioni per inserire le scommesse/puntate
; (fiches "nome") oppure (fiches "nome" numero)
; le funzioni aggiornano la lista bets con elementi del tipo:
; (fiches-puntate nome-puntata (lista numeri))
;
; Numero secco
(define (plein num bet) (push (list bet "plein" (list num)) bets -1))
; Coppia
(define (cheval lst bet) (push (list bet "cheval" lst) bets -1))
; Terzina
(define (trans3 lst bet) (push (list bet "trans3" lst) bets -1))
; Quadrato
(define (carre lst bet) (push (list bet "carre" lst) bets -1))
; Due terzine
(define (trans6 lst bet) (push (list bet "trans6" lst) bets -1))
; Dozzina
(define (douzaine num bet) (push (list bet "douzaine" (dozen (- num 1))) bets -1))
; Colonna
(define (colonne num bet) (push (list bet "colonne" (column (- num 1))) bets -1))
; Pari
(define (pair bet) (push (list bet "pair" even) bets -1))
; Dispari
(define (impair bet) (push (list bet "impair" odd) bets -1))
; Da 1 a 18
(define (manque bet) (push (list bet "manque" low) bets -1))
; Da 19 a 36
(define (passe bet) (push (list bet "passe" high) bets -1))
; Rosso
(define (rouge bet) (push (list bet "rouge" red) bets -1))
; Nero
(define (noir bet) (push (list bet "noir" black) bets -1))

; Funzione per la gestione di un lancio del croupier
(define (croupier dbg)
  (local (num segno)
    (setq num (rand 37))
    ; for test
    (if (= dbg true) (setq num 28))
    (println "Numero uscito: " num)
    (println "Puntate:")
    ; analisi delle puntate
    (dolist (el bets)
    ;(el 0) -> fiches puntate
    ;(el 1) -> nome della puntata
    ;(el 2) -> lista dei numeri della puntata
      (if (find num (el 2))
            (set 'get (* (lookup (el 1) reward) (el 0)) 'segno "+")
            ;else
            (set 'get (- (el 0)) 'segno "")
      )
      (++ fiches get)
      (println {  } (el 1) { } segno get)
    )
    (println "Fiches: " fiches)
    ; Annulla tutte le puntate
    (setq bets '())
  '----------------))

Vediamo un paio di esempi.

Inizializzazione:

(roulette 100)

Puntate:

(plein 28 10)
(plein 42 10)
(cheval '(28 29) 5)
(cheval '(1 2) 5)
(trans3 '(28 29 30) 10)
(trans3 '(13 14 15) 10)
(carre '(28 29 31 32) 5)
(carre '(4 5 7 8) 5)
(douzaine 3 10)
(douzaine 1 10)
(rouge 5)
(noir 5)
(manque 10)
(passe 10)
(pair 5)
(impair 5)
(colonne 1 10)
(colonne 2 10)
(colonne 3 10)
(trans6 '(28 29 30 31 32 33) 4)
(trans6 '(7 8 9 10 11 12) 4)
;-> ((10 "plein" (28))
;->  (10 "plein" (42))
;->  (5 "cheval" (28 29))
;->  (5 "cheval" (1 2))
;->  (10 "trans3" (28 29 30))
;->  (10 "trans3" (13 14 15))
;->  (5 "carre" (28 29 31 32))
;->  (5 "carre" (4 5 7 8))
;->  (10 "douzaine" (25 26 27 28 29 30 31 32 33 34 35 36))
;->  (10 "douzaine" (1 2 3 4 5 6 7 8 9 10 11 12))
;->  (5 "rouge" (1 3 5 7 9 12 15 18 19 21 23 25 27 30 32 34 36))
;->  (5 "noir" (2 4 6 810 11 13 15 17 20 22 24 26 28 29 31 33 35))
;->  (10 "manque" (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18))
;->  (10 "passe" (19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36))
;->  (5 "pair" (2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36))
;->  (5 "impair" (1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35))
;->  (10 "colonne" (1 4 7 10 13 16 19 22 25 28 31 34))
;->  (10 "colonne" (2 5 8 11 14 17 20 23 26 29 32 35))
;->  (10 "colonne" (3 6 9 12 15 18 21 24 27 30 33 36))
;->  (4 "trans6" (28 29 30 31 32 33))
;->  (4 "trans6" (7 8 9 10 11 12)))

Il Croupier gira la ruota della roulette:

(croupier true)
;-> Numero uscito: 28
;-> Puntate:
;->   plein +350
;->   plein -10
;->   cheval +85
;->   cheval -5
;->   trans3 +110
;->   trans3 -10
;->   carre +40
;->   carre -5
;->   douzaine +20
;->   douzaine -10
;->   rouge -5
;->   noir +5
;->   manque -10
;->   passe +10
;->   pair +5
;->   impair -5
;->   colonne +20
;->   colonne -10
;->   colonne -10
;->   trans6 +20
;->   trans6 -4
;-> Fiches: 593
;-> ----------------

Inizializzazione:

(roulette 100)

Puntate:

(plein 28 10)
(plein 42 10)
(cheval '(28 29) 5)
(cheval '(1 2) 5)
(trans3 '(28 29 30) 10)
(trans3 '(13 14 15) 10)
(carre '(28 29 31 32) 5)
(carre '(4 5 7 8) 5)
(douzaine 3 10)
(douzaine 1 10)
(rouge 5)
(noir 5)
(manque 10)
(passe 10)
(pair 5)
(impair 5)
(colonne 1 10)
(colonne 2 10)
(colonne 3 10)
(trans6 '(28 29 30 31 32 33) 4)
(trans6 '(7 8 9 10 11 12) 4)
;-> ((10 "plein" (28))
;->  (10 "plein" (42))
;->  (5 "cheval" (28 29))
;->  (5 "cheval" (1 2))
;->  (10 "trans3" (28 29 30))
;->  (10 "trans3" (13 14 15))
;->  (5 "carre" (28 29 31 32))
;->  (5 "carre" (4 5 7 8))
;->  (10 "douzaine" (25 26 27 28 29 30 31 32 33 34 35 36))
;->  (10 "douzaine" (1 2 3 4 5 6 7 8 9 10 11 12))
;->  (5 "rouge" (1 3 5 7 9 12 15 18 19 21 23 25 27 30 32 34 36))
;->  (5 "noir" (2 4 6 810 11 13 15 17 20 22 24 26 28 29 31 33 35))
;->  (10 "manque" (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18))
;->  (10 "passe" (19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36))
;->  (5 "pair" (2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36))
;->  (5 "impair" (1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35))
;->  (10 "colonne" (1 4 7 10 13 16 19 22 25 28 31 34))
;->  (10 "colonne" (2 5 8 11 14 17 20 23 26 29 32 35))
;->  (10 "colonne" (3 6 9 12 15 18 21 24 27 30 33 36))
;->  (4 "trans6" (28 29 30 31 32 33))
;->  (4 "trans6" (7 8 9 10 11 12)))

Il Croupier gira la ruota della roulette:

(croupier)
;-> Numero uscito: 29
;-> Puntate:
;->   plein -10
;->   plein -10
;->   cheval +85
;->   cheval -5
;->   trans3 +110
;->   trans3 -10
;->   carre +40
;->   carre -5
;->   douzaine +20
;->   douzaine -10
;->   rouge -5
;->   noir +5
;->   manque -10
;->   passe +10
;->   pair -5
;->   impair +5
;->   colonne -10
;->   colonne +20
;->   colonne -10
;->   trans6 +20
;->   trans6 -4
;-> Fiches: 321
;-> ----------------

Per finire vediamo quali sono le probabilità del giocatore e quelle del croupier per ogni combinazione:

(define (probs num)
  (local (giocatore croupier)
    (setq giocatore (div num 37))
    (setq croupier (sub 1 giocatore))
    (list (format "%5.3f" giocatore) (format "%5.3f" croupier))))

(map (fn(x) (list (x 0) (probs (x 1)))) number)
;-> (("plein" ("0.027" "0.973"))
;->  ("cheval" ("0.054" "0.946"))
;->  ("trans3" ("0.081" "0.919"))
;->  ("carre" ("0.108" "0.892"))
;->  ("trans6" ("0.162" "0.838"))
;->  ("douzaine" ("0.324" "0.676"))
;->  ("colonne" ("0.324" "0.676"))
;->  ("pair" ("0.486" "0.514"))
;->  ("impair" ("0.486" "0.514"))
;->  ("manque" ("0.486" "0.514"))
;->  ("passe" ("0.486" "0.514"))
;->  ("rouge" ("0.486" "0.514"))
;->  ("noir" ("0.486" "0.514")))

Il numero "0" sposta sempre le probabilità a favore del croupier.


-----------------
Messaggio cifrato
-----------------

Un messaggio (stringa ASCII [32-126]) viene cifrato con il seguente algoritmo:

a) Convertire ogni carattere nel relativo codice ASCII a 7 bit
   (se il codice ASCII è inferiore a 7 bit, inserisci i bit zero iniziali)
b) Concatenare tutti i bit
   (bitstream lungo 7*n bit dove n è il numero di caratteri della stringa)
c) Per ogni bit del bitstream:
   aggiungere "1" al risultato se è diverso dal bit precedente
   altrimenti aggiungere "0".
   (Il primo bit del risultato è sempre 1).

Esempio:

  input = "newLISP"
  "n" --> "1101110"
  "e" --> "1100101"
  "w" --> "1110111"
  "L" --> "1001100"
  "I" --> "1001001"
  "S" --> "1010011"
  "P" --> "1010000"
  concatenazione = "1101110110010111101111001100100100110100111010000"
  output = "1011001101011100011000101010110110101110100111000"

Scrivere le funzioni di cifratura e decifratura di questo algoritmo.

Funzione che cifra una stringa:

(define (crypt str)
  (let ((bit7 "") (out "1"))
    (dostring (ch str)
      (extend bit7 (format "%07s" (bits ch)))
      ;(println (char ch) { } (format "%07s" (bits ch)))
    )
    ;(println bit7)
    (for (i 1 (- (length bit7) 1))
      (if (= (bit7 i) (bit7 (- i 1)))
          (extend out "0")
          (extend out "1")
      )
    )
    out))

(crypt "newLISP")
;-> "1011001101011100011000101010110110101110100111000"

Per decifrare il messaggio cifrato occorre conoscere se la concatenazione iniziava con "1" oppure con "0". Purtroppo questo non è possibile perchè l'algoritmo di cifratura fa iniziare l'output sempre con "1".
Per aggirare il problema scriviamo una funzione di decifratura che prende un parametro (start) per definire il bit iniziale. 
In questo modo possiamo provare entrambe le possibilità per capire il giusto risultato.

Funzione che inverte un bit:

Funzione che decifra una stringa:

(define (decrypt str start)
  (let (out "")
    (setq out start)
    (for (i 1 (- (length str) 1))
      (cond ((= (str i) "1") ; carattere di output diverso dal precedente
              (extend out (flip (out (- i 1)))))
            ((= (str i) "0") ; carattere di output uguale al precedente
              (extend out (out (- i 1))))
      )
    )
    (join (map char (map (fn(x) (int x 0 2)) (explode out 7))))))

Facciamo alcune prove:

(decrypt (crypt "newLISP") "0")
;-> "\017\026\b36,/"
(decrypt (crypt "newLISP") "1")
;-> "newLISP"

(decrypt (crypt "  newLISP") "0")
;-> "  newLISP"
(decrypt (crypt "  newLISP") "1")
;-> "__\017\026\b36,/"

(decrypt (crypt "warning: this is addictive.") "0")
;-> "\b\030\r\017\022\017\024E_\011\023\022\f_\022\f_\030\027\027\022\028\011\022\t\026Q"
(decrypt (crypt "warning: this is addictive.") "1")
;-> "warning: this is addictive."


---------
Comb sort
---------

Comb Sort è un algoritmo di ordinamento che migliora il Bubble Sort.
Il bubble sort (ordinamento a bolle) confronta sempre i valori adiacenti, quindi tutte le inversioni vengono effettuate una per una.
Il Comb Sort utilizza una differenza tra i valori superiore a 1.
La differenza inizia con il valore dato dalla lunghezza della lista da ordinare e si riduce di un fattore 1.3 in ogni iterazione fino a raggiungere il valore 1.
Pertanto Comb Sort effettua le inversioni con una differenza maggiore e questo lo rende migliore del Bubble Sort.
Il fattore di riduzione è stato fissato empiricamente pari a 1,3 (testando Combsort su oltre 200.000 liste casuali)
Anche se in media funziona meglio del Bubble Sort, il caso peggiore rimane O(n^2).

(define (getgap gap)
  (setq gap (div (mul gap 10) 13))
  (if (< gap 1) 1 gap))

(define (combsort lst)
  (local (len swapped gap)
    (setq len (length lst))
    ; gap iniziale = lunghezza della lista
    (setq gap len)
    ; nessuno scambio effettuato
    (setq swapped true)
    (println "gap: " gap " - lst: " lst)
    (while (or (!= gap 1) (= swapped true))
      ; aggiorna valore di gap (dimunuisce)
      (setq gap (getgap gap))
      (setq swapped nil)
      ; ciclo per scambiare coppie di elementi
      (for (i 0 (- len gap 1))
        (if (> (lst i) (lst (+ i gap)))
          (begin
            (swap (lst i) (lst (+ i gap)))
            ; scambio effettuato
            (setq swapped true)
          )
        )
      )
      (print "gap: " gap " - lst: " lst)
      (read-line)
    )
    lst))

(combsort '(10 34 23 12 67 4 7 8 23 6 9))
;-> gap: 11 - lst: (10 34 23 12 67 4 7 8 23 6 9)
;-> gap: 8.461538461538462 - lst: (10 6 9 12 67 4 7 8 23 34 23)
;-> gap: 6.50887573964497 - lst: (7 6 9 12 23 4 10 8 23 34 67)
;-> gap: 5.006827492034592 - lst: (4 6 8 12 23 7 10 9 23 34 67)
;-> gap: 3.851405763103533 - lst: (4 6 7 10 9 8 12 23 23 34 67)
;-> gap: 2.962619817771949 - lst: (4 6 7 8 9 10 12 23 23 34 67)
;-> gap: 2.278938321363037 - lst: (4 6 7 8 9 10 12 23 23 34 67)
;-> gap: 1.753029477971567 - lst: (4 6 7 8 9 10 12 23 23 34 67)
;-> gap: 1.348484213824282 - lst: (4 6 7 8 9 10 12 23 23 34 67)
;-> gap: 1.037295549095602 - lst: (4 6 7 8 9 10 12 23 23 34 67)
;-> gap: 1 - lst: (4 6 7 8 9 10 12 23 23 34 67)
;-> (4 6 7 8 9 10 12 23 23 34 67)


--------------------------------------------
Inversione di righe e colonne di una matrice
--------------------------------------------

Funzione che inverte le colonne di una matrice:

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

Funzione che inverte le righe di una matrice:

(define (swap-rows matrix)
  (local (rows cols)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (for (c 0 (- cols 1))
      (for (r 0 (- (/ rows 2) 1))
        (swap (matrix r c) (matrix (- rows r 1) c))
      )
    )
  matrix))

(setq m '((1 2 3 4)
          (5 6 7 8)
          (0 8 9 3)
          (3 2 1 4)
          (8 7 9 3)))

(swap-cols m)
;-> ((4 3 2 1)
;->  (8 7 6 5)
;->  (3 9 8 0)
;->  (4 1 2 3)
;->  (3 9 7 8))

(swap-rows m)
;-> ((8 7 9 3) 
;->  (3 2 1 4) 
;->  (0 8 9 3) 
;->  (5 6 7 8) 
;->  (1 2 3 4))


---------------------------------------------------------------
Rotazione di 90 gradi (in senso orario) di una matrice quadrata
---------------------------------------------------------------

Vediamo un esempio di rotazione di 90 gradi (in senso orario) di una matrice quadrata:

   1  2  3  4  5  6
   7  8  9 10 11 12
  13 14 15 16 17 18
  19 20 21 22 23 24
  25 26 27 28 29 30
  31 32 33 34 35 36

Dopo aver ruotato la matrice di 90 gradi in senso orario, otteniamo:

  6 12 18 24 30 36
  5 11 17 23 29 35
  4 10 16 22 28 34
  3  9 15 21 27 33
  2  8 14 20 26 32
  1  7 13 19 25 31

Algoritmo
1) trasporre la matrice
2) invertire le righe della matrice trasposta
   (riga 0) con (riga (n-1)), riga 1 con (riga (n-2)), ecc.

La matrice risultante dopo la trasposizione e l'inversione di ciascuna riga sarà la matrice ruotata di 90 gradi in senso orario.

trasposta di m =  1  7 13 19 25 31
                  2  8 14 20 26 32
                  3  9 15 21 27 33
                  4 10 16 22 28 34
                  5 11 17 23 29 35
                  6 12 18 24 30 36

inversione delle righe = 6 12 18 24 30 36
                         5 11 17 23 29 35
                         4 10 16 22 28 34
                         3  9 15 21 27 33
                         2  8 14 20 26 32
                         1  7 13 19 25 31

Funzione che inverte le righe di una matrice:

(define (swap-rows matrix)
  (local (rows cols)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (for (c 0 (- cols 1))
      (for (r 0 (- (/ rows 2) 1))
        (swap (matrix r c) (matrix (- rows r 1) c))
      )
    )
  matrix))

(setq m '(( 1  2  3  4  5  6)
          ( 7  8  9 10 11 12)
          (13 14 15 16 17 18)
          (19 20 21 22 23 24)
          (25 26 27 28 29 30)
          (31 32 33 34 35 36)))

(setq t (transpose m))
;-> ((1  7 13 19 25 31)
;->  (2  8 14 20 26 32)
;->  (3  9 15 21 27 33)
;->  (4 10 16 22 28 34)
;->  (5 11 17 23 29 35)
;->  (6 12 18 24 30 36))

(swap-rows t)
;-> ((6 12 18 24 30 36)
;->  (5 11 17 23 29 35)
;->  (4 10 16 22 28 34)
;->  (3  9 15 21 27 33)
;->  (2  8 14 20 26 32)
;->  (1  7 13 19 25 31))

Funzione che ruota una matrice di 90 gradi in senso orario:

(define (rot90 matrix)
  (swap-rows (transpose matrix)))

(rot90 m)
;-> ((6 12 18 24 30 36)
;->  (5 11 17 23 29 35)
;->  (4 10 16 22 28 34)
;->  (3  9 15 21 27 33)
;->  (2  8 14 20 26 32)
;->  (1  7 13 19 25 31))

Per ruotare una matrice di 180 gradi applicare due volte "rot90":

(setq g '(( 1  2  3  4  5)
          ( 6  7  8  9 10 )
          (11 12 13 14 15)
          (16 17 18 19 20)
          (21 22 23 24 25)))

(rot90 (rot90 g))
;-> ((25 24 23 22 21)
;->  (20 19 18 17 16)
;->  (15 14 13 12 11)
;->  (10  9  8  7  6)
;->  ( 5  4  3  2  1))


---------------------------------------------
Attraversamento di matrici lungo le diagonali
---------------------------------------------

Data una matrice vogliamo attraversarla seguendo le diagonali (2 modi).
Per esempio:

          | 1  2  3  4  5 |
matrice = | 6  7  8  9  5 |
          | 1  2  3  4  3 |

Primo modo '/' (partendo dall'elemento in alto a sinistra (1)):

  1 - 2 6 - 3 7 1 - 4 8 2 - 5 9 3 - 5 4 - 3

Secondo modo '\' (partendo dall'elemento in alto a destra (5)):

  5 - 4 5 - 3 9 3 - 2 8 4 - 1 7 3 - 6 2 - 1

Partiamo dal primo modo '/' e osserviamo lo schema in cui ci muoviamo attraverso la matrice. 
Possiamo notare che ciascuna diagonale può essere identificata univocamente dalla somma dei suoi indici di riga e di colonna. 
Grazie a questa proprietà, possiamo dividere l'attraversamento in due parti: la prima parte in cui iteriamo sulla metà superiore della matrice (righe da 0 a M-1) e la seconda parte in cui iteriamo sulla metà inferiore della matrice (colonne da 1 a N-1).

Funzione che attraversa una matrice in diagonale '/':

(define (diag1 matrix)
  (local (out row cols)
    (setq out '())
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    ; prima metà
    (for (i 0 (- cols 1))
      (for (j i 0)
        (if (< (- i j) rows) (push (matrix (- i j) j) out -1))
      )
    )
    ;(println out)
    ; seconda metà
    (for (i 1 (- rows 1))
      (setq k i)
      (for (j (- cols 1) 0)
        (if (< k rows) (begin (push (matrix k j) out -1) (++ k)))
      )
    )
    out))

(setq m '((1 2 3 4 5)
          (6 7 8 9 5)
          (1 2 3 4 3)))

(diag1 m)
;-> (1 2 6 3 7 1 4 8 2 5 9 3 5 4 3)

Per ottenere il secondo modo '\', possiamo notare che dopo aver scambiato le colonne della matrice (0 con cols-1, 1 con cols -2, ecc.) possiamo applicare la funzione "diag1" alla matrice risultante.

Funzione che scambia le colonne di una matrice:

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

(setq mm (swap-cols m))
;-> ((5 4 3 2 1) (5 9 8 7 6) (3 4 3 2 1))

(diag1 mm)
;-> (5 4 5 3 9 3 2 8 4 1 7 3 6 2 1)

Funzione che attraversa una matrice in diagonale '\':

(define (diag2 matrix) (diag1 (swap-cols matrix)))

(diag2 m)
;-> (5 4 5 3 9 3 2 8 4 1 7 3 6 2 1)

=============================================================================

