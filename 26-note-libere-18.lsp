================

 NOTE LIBERE 18

================

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

Il problema se correre o camminare sotto la pioggia solleva una serie di preoccupazioni e considerazioni inaspettate, e in effetti, gran parte della discussione scientifica sulla questione tratta argomenti teorici molto specifici e aspetti del problema che non sono affatto pratici da considerare nel mondo reale.
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
Con il s.o. MSwindows possiamo utilizzare il servizio integrato Speech (Microsoft Speech Engine) oppure il programma "Balabolka" (balcon.exe).

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
  (local (out lst)
    (setq out "")
    (setq eng '(("0" "zero")("1" "one")("2" "two")("3" "three")("4" "four")
                ("5" "five")("6" "six")("7" "seven")("8" "eight")("9" "nine")))
    (setq ita '(("0" "zero")("1" "uno")("2" "due")("3" "tre")("4" "quattro")
            ("5" "cinque")("6" "sei")("7" "sette")("8" "otto")("9" "nove")))
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


------------------------------------------
Da stringa a numero di colonna e viceversa
------------------------------------------

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

=============================================================================

