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

=============================================================================

