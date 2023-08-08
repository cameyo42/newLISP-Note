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
=============================================================================

