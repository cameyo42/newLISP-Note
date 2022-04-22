===============

 NOTE LIBERE 8

===============

Un buon programmatore LISP cerca di utilizzare uno stile funzionale puro il più possibile usando funzioni con effetti-collaterali (side-effect) con parsimonia (il minimo indispensabile).

McCarthy (l'inventore originale di LISP) ha dimostrato che qualsiasi algoritmo/funzione può essere formulato completamente senza effetti collaterali solo con funzioni.

-----------------------------------------
Creazione di un contesto da una variabile
-----------------------------------------

Vediamo come creare un contesto dal contenuto di una variabile.

Primo metodo:
-------------
Definiamo la variabile che contiene il nome del contesto da creare come stringa ("TEST1"):

(setq name "TEST1")

E definiamo il contesto nel modo seguente:

(context (sym name))

(context? TEST1)
;-> true

Secondo metodo:
---------------

Definiamo la variabile che contiene il nome del contesto da creare come simbolo quotato ('TEST2):

(setq name 'TEST2)

E definiamo il contesto nel modo seguente:

(context name)

(context? TEST2)
;-> true

Terzo metodo:
---------------
Creiamo prima un contesto vuoto TEMP:

(context 'TEMP)
(context MAIN)

Definiamo la variabile che contiene il nome del contesto da creare come stringa ("TEST3"):

(setq var "TEST3")

Adesso possiamo creare il contesto DEMO copiando il contesto TEMP:

(new TEMP (sym var))
(context? TEST3)
;-> true

Quarto metodo:
---------------
Creiamo prima un contesto vuoto TEMP:

(context 'TEMP)
(context MAIN)

Definiamo la variabile che contiene il nome del contesto da creare come simbolo quotato ('TEST4):

(setq var 'TEST4)

Adesso possiamo creare il contesto TEST4 copiando il contesto TEMP:

(new TEMP (sym var))
(context? TEST4)
;-> true

Possiamo scrivere anche una funzione:

(define (create-context str)
  (local (temp ctx)
    (setq temp (sym str))
    (new MAIN temp)
    (setq ctx (eval temp))
    (setq ctx:name (string "I am " c))))

Adesso possiamo creare un contesto qualunque con una variabile che contiene il nome del contesto come stringa:

(setq c "DEMO")
(create-context c)
;-> "I am DEMO"
DEMO:name
;-> "I am DEMO"

Per finire vediamo come creare un contesto da un contesto esistente che contiene una funzione "create" (costruttore) che crea un contesto:

(context 'DEMO)

(define (create str)
    (context MAIN)
    (new DEMO (sym str))
    (context DEMO))

(define (echo)
    (println "Hello world"))

(context MAIN)

A questo punto possiamo creare un nuovo contesto (A) e assegnarlo ad una variabile (ctx):

(setq ctx (DEMO:create "A"))
(ctx:echo)
;-> Hello world


--------------------------------------
Creazione di contesti con una funzione
--------------------------------------

Per elencare la lista dei constesti attivi basta scrivere:

(filter context? (map eval (symbols 'MAIN)))

Vediamo come creare dei contesti con una funzione:

(context 'ITEM)
   (set 'title "")
   (set 'link "")
   (set 'content "")
   (set 'item_date "")
   (set 'author "")
(context 'MAIN)

(context 'MY_CONTEXT)
(set 'items '())
(define (create_item this_item)
   ;(println this_item)
   (new ITEM this_item)
   (set 'this_item (eval this_item))
   ;;Item Title
   (set 'this_item:title "some title")
   ;;Item Author
   (set 'this_item:author "some author")
   ;;Item Date
   (set 'this_item:item_date "some date")
   ;;Item Body
   (set 'this_item:content "foo body")
   ;;Item Link/URL
   (set 'this_item:link "some URL")
   (push this_item items)
)
(context 'MAIN)

Adesso possiamo scrivere:

(MY_CONTEXT:create_item 'TEST-1)
;-> (TEST-1)
(MY_CONTEXT:create_item 'TEST-2)
;-> (TEST-2)

MY_CONTEXT:items
;-> (TEST-2 TEST-1)

E dal contesto MY_CONTEXT possiamo scrivere:

(context 'MY_CONTEXT)
(create_item 'MAIN:TEST-3)
;-> (TEST-3 TEST-2 TEST-1)
(create_item 'MAIN:TEST-4)
;-> (TEST-4 TEST-3 TEST-2 TEST-1)
items
;-> (TEST-4 TEST-3 TEST-2 TEST-1)

Questo perché i simboli di contesto appartengono sempre a MAIN.

Questa è l'espressione critica:

(set 'this_item (eval this_item))

Poiché vogliamo accedere al contesto che è all'interno di this_item, ma "this_item" contiene il simbolo 'TEST-1 (che conterrà il contesto TEST-1). Quindi con "eval" rimuoviamo un livello di valutazione. Nell'ultima espressione viene usato "push", perché "cons" non è distruttivo e non cambierebbe la lista.


-----------
Mini-puzzle
-----------

Scrivere una funzione che prende due numeri interi a e b.
Se a > b, allora "a" diventa uguale a "b"
          altrimenti "a" viene scambiato con "b"

Il prototipo della funzione è il seguente:

(define (func a b)
  ; Vincoli:
  ; 1) la funzione deve contenere al massimo due riferimenti ad "a" e "b"
  ;    (oltre ai valori da restituire con (list a b))
  ; 2) la funzione non deve utilizzare altre variabili
  ; 3) la funzione deve essere la più breve possibile
  ;
  (list a b)) ; valori da restituire

Soluzione:

(define (func a b)
  ((if (> a b) setq swap) a b)
  (list a b))

(func 1 3)
;-> (3 1)

(func 4 2)
;-> (2 2)


------------------------
Minimo, massimo e indici
------------------------

Vediamo alcune funzioni per calcolare i valori minimo e massimo (e relativi indici) di una lista.

Primo metodo (primitve newLISP):

(define (min-max lst)
  (list (apply min lst) (apply max lst)))

(silent (setq num (randomize (sequence 1 1e6))))

(min-max num)
;-> (1 1000000)

Secondo metodo (algoritmo):

(define (min-max-2 lst)
  (let ((minimo (lst 0)) (massimo (lst 0)))
    (dolist (el lst)
      (cond ((< el minimo) (setq minimo el))
            ((> el massimo) (setq massimo el))
      )
    )
    (list minimo massimo)))

(min-max-2 num)
;-> (1 1000000)

Vediamo i tempi di esecuzione:

(time (min-max num) 100)
;-> 9662.792

(time (min-max-2 num) 100)
;-> 13607.61

Adesso restituiamo anche i relativi indici dei valori minimo e massimo:

Primo metodo (primitive newLISP):

(define (min-max-idx lst)
  (let ((minimo (apply min lst)) (massimo (apply max lst)))
    (list minimo (first (ref minimo lst)) massimo (first (ref massimo lst)))))

(min-max-idx num)
;-> (1 934142 1000000 997889)
(num 934142)
;-> 1
(num 997889)

Secondo metodo (algoritmo):

(define (min-max-idx-2 lst)
  (let ((minimo (lst 0)) (massimo (lst 0)) (idx-min 0) (idx-max 0))
    (dolist (el lst)
      (cond ((< el minimo)  (set 'minimo  el 'idx-min $idx))
            ((> el massimo) (set 'massimo el 'idx-max $idx))
      )
    )
    (list minimo idx-min massimo idx-max)))

(min-max-idx-2 num)
;-> (1 934142 1000000 997889)

Vediamo i tempi di esecuzione:

(time (min-max-idx num) 100)
;-> 11976.844

(time (min-max-idx-2 num) 100)
;-> 13875.329


------
Wordle
------

Wordle è un gioco sviluppato nel 2021 da Josh Wardle, in cui il giocatore deve indovinare una parola di cinque lettere in meno di sei tentativi.
Ogni tentativo deve essere una parola di cinque lettere.
Dopo ogni tentativo, viene mostrato il risultato del confronto:
Colore verde ("!")
  la lettera esiste nella soluzione e si trova nel posto corretto
Colore giallo (".")
  la lettera esiste nella soluzione, ma non si trova nel posto corretto
Colore grigio ("?")
  la lettera non esiste nella soluzione.
Le parole vengono selezionate casualmente da un file di 2315 parole (wordle.txt).

Vediamo una implementazione del gioco:

(define (wordle)
  (let ((guess "") (words nil) (word "") (test 0))
    ; load file of words
    (setq words (parse (read-file "wordle.txt")))
    ; initialize random generator
    (seed (time-of-day))
    ; select random word
    (setq word (random-word words))
    ;(println word)
    ; game loop
    (while (!= guess word)
      (++ test)
      (print "Word: ")
      (setq guess (read-line))
      (if (= 5 (length guess))
        (print-wordle guess word)
        (print "Word must be 5 chars\n")
      )
    )
    (println "Try: " test)
    'game-over))

; select random element from a list
(define (random-word lst) (lst (rand (length lst))))

; print wordle result
(define (print-wordle guess word)
  (print (dup " " 6))
  (dotimes (i 5)
    (print
      (cond
        ((= (guess i) (word i)) "!")  ; char in correct position
        ((find (guess i) word) ".") ; char in different position
        (true "?")))) ; char not in word
  (print "\n"))

Facciamo una partita:

(wordle)
Parola: adieu
;-> ?????
Parola: roate
;-> !!???
Parola: carlo
;-> ??.?.
Parola: robol
;-> !!?.?
Parola: roomy
;-> !!!!!
;-> Tentativi: 5
;-> game-over

Strategie nella scelta della prima parola
La prima parola è probabilmente la più importante. Per massimizzare il valore della tua mossa di apertura, scegli una parola con tre vocali e cinque lettere diverse.
Alcuni esempi: orate, media, radio.
A quanto pare dovremmo tutti iniziare con la parola "roate":

https://medium.com/@tglaiel/the-mathematically-optimal-first-guess-in-wordle-cbcb03c19b0a

Altri suggerimenti:

"adieu" come prima e "story" come seconda.
"audio", toglie immediatamente di mezzo 4 vocali su 5 si concentra sulle consonanti.
"teary", "pious" e "adieu" in sequenza.

Qualcuno sostiene che non stai giocando a Wordle correttamente se usi sempre la stessa parola per iniziare: prova parole diverse ogni volta: "yacht", "ulcer", "toast".
Non aver paura di deviare dalla normale parola iniziale, a volte una parola casuale che ci viene in mente finisce per essere più utile delle parole standard.

Evitare di riutilizzare le lettere che sono diventate grigie "?" (sembra ovvio, ma richiede più tempo e fatica pensare a parole di cinque lettere che non usano lettere che abbiamo già provato).

Attenzione, le lettere possono apparire più volte.

Nota: nella cartella "DATA" potete trovare i file "wordle.txt" (parole inglesi) e "wordle-ita.txt" (parole italiane).

Scriviamo una versione a colori per terminali ANSI. I colori sono verde, giallo e rosso:

Colore verde:
  la lettera esiste nella soluzione e si trova nel posto corretto

Colore giallo:
  la lettera esiste nella soluzione, ma non si trova nel posto corretto

Colore rosso:
  la lettera non esiste nella soluzione.

(define (wordle)
  (let ((guess "") (words nil) (word "") (test 0)
        (green "\027[0;32m")
        (yellow "\027[0;33m")
        (red "\027[0;31m")
        (reset-color "\027[39;49m"))
    ; load file of words
    (setq words (parse (read-file "wordle-ita.txt")))
    ; initialize random generator
    (seed (time-of-day))
    ; select random word
    (setq word (random-word words))
    ;(println word)
    ; game loop
    (while (!= guess word)
      (++ test)
      (print "Parola: ")
      (setq guess (read-line))
      (if (= 5 (length guess))
        (print-wordle guess word)
        (print "La parola deve avere 5 caratteri\n")
      )
    )
    (println "Tentativi: " test)
    'game-over))

; select random element from a list
(define (random-word lst) (lst (rand (length lst))))

; print wordle result
(define (print-wordle guess word)
  (print (dup " " 8))
  (dotimes (i 5)
      (cond
        ((= (guess i) (word i)) (print green "■")) ; char in correct position
        ((find (guess i) word) (print yellow "■")) ; char in different position
        (true (print red "■")) ; char not in word
      )
  )
  (print reset-color "\n"))

Facciamo una partita:

(wordle)


---------------------
Quadruple pitagoriche
---------------------

Una quadrupla pitagorica è una tupla di interi a, b, c e d, tale che a^2 + b^2 + c^2 = d^2. Sono soluzioni di un'equazione diofantiea e in genere vengono considerati solo valori interi positivi.
Una quadrupla pitagorica (a, b, c, d) definisce un cuboide con lati interi |a|, |b| e |c|, la cui diagonale ha lunghezza intera d (le quadruple pitagoriche sono quindi anche dette scatole pitagoriche (pythagorean boxes).

Scriviamo una funzione che determina tutte le quadruple pitagoriche fino ad un determinato numero.

Funzione che verifica se un numero è un quadrato perfetto:

(define (quadrato? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

Funzione che calcola le quadruple pitagoriche:

(define (quadruple n)
  (let ((out '()) (somma 0))
    (for (a 1 n)
      (for (b a n)
        (for (c b n)
          (setq somma (+ (* a a) (* b b) (* c c)))
          (if (quadrato? somma)
              (push (list a b c (sqrt somma)) out -1)
          ))))
    out))

(setq q (quadruple 10))
;-> ((1 2 2 3) (1 4 8 9) (2 3 6 7) (2 4 4 6) (2 6 9 11)
;->  (3 6 6 9) (4 4 7 9) (4 8 8 12) (5 10 10 15) (6 6 7 11))

(time (setq q (quadruple 100)))
;-> 42.113
(length q)
;-> 890

Attenzione: l'algoritmo ha un tempo polinomiale O(n^3).

(time (setq q (quadruple 1000)))
;-> 42424.61
(length q)
;-> 85490

Proviamo con un altro algoritmo: costruiamo una hash-map di tutti i modi possibili per creare a*a + b*b, poi creiamo tutti i possibili valori di d*d - c*c e verifichiamo un eventuale accoppiamento.

(define (quadruple2 n)
  (new Tree 'hash)
  (local (out key)
    (setq out '())
    (for (a 1 n)
      (for (b a n)
        (setq key (string (+ (* a a) (* b b))))
        ; aggiunge la coppia (a b) al valore associato alla chiave
        (hash key (if $it (extend (list (list a b)) $it)  (list (list a b))))
      )
    )
    ;(hash)
    ; (sqrt (mul 3 c c)) = (mul (sqrt 3) c) <= (mul 2 c)
    ; (mul 2 c) è leggermente più grande,
    ; quindi genera delle quadruple multiple
    ; che vengono eliminate alla fine con "sort" e "unique".
    (for (c 1 n)
      (for (d (+ c 1) (* 2 c))
        (setq key (string (- (* d d) (* c c))))
        (if (!= (hash key) nil)
          (dolist (el (hash key))
            (setq a (first el))
            (setq b (last el))
            (if (>= c b)
              ;(println a { } b { } c { } d)
              (push (list a b c d) out -1)
            )
          )
        )
      )
    )
    (delete 'hash)
    (unique (sort out))))

(setq q1 (quadruple2 10))
;-> ((1 2 2 3) (1 4 8 9) (2 3 6 7) (2 4 4 6) (2 6 9 11)
;->  (3 6 6 9) (4 4 7 9) (4 8 8 12) (5 10 10 15) (6 6 7 11))

Proviamo con n=100:

(time (setq q1 (quadruple2 100)))
;-> 9.975
(length q1)
;-> 890

Con la prima funzione:

(time (setq q (quadruple 100)))
;-> 42.098

Vediamo se le funzioni producono gli stessi risultati:

(= q q1)
;-> true

Proviamo con n=1000:

(time (setq q1 (quadruple2 1000)))
;-> 1421.486

Con la prima funzione:

(time (setq q (quadruple 1000)))
;-> 42577.862

Vediamo se le funzioni producono gli stessi risultati:

(= q q1)
;-> true

L'ultima funzione "quadruple2" è molto più veloce ed ha una complessità temporale pari a O(n^2.x) e comunque mostra presto i suoi limiti:

(time (setq qq (quadruple2 5000)))
;-> 64124.424


--------------------
Formula di Haversine
--------------------

Calcolare la distanza del cerchio massimo tra due punti in una sfera, date le longitudini e le latitudini di due punti (in gradi decimali)
La Terra è "una specie di sfera", quindi un percorso tra due punti non è esattamente una linea retta. Dobbiamo tenere conto della curvatura della Terra quando calcoliamo la distanza da un punto A ad un punto B.
Questo effetto è trascurabile per piccole distanze, ma aumenta all'aumentare della distanza.
La formula di Haversine tratta la Terra come una sfera e permette di "proiettare" i due punti A e B sulla sua superficie e di calcolare la distanza sferica tra di loro. Poiché la Terra non è una sfera perfetta, altri metodi che modellano la natura ellissoidale della Terra sono più accurati, ma la formula di Haversine produce un errore massimo dello 0.5%.

Per l'implementazione seguiamo la formula riportata da wikipedia:

https://en.wikipedia.org/wiki/Haversine_formula

(define (deg-rad deg) (div (mul deg 3.1415926535897931) 180))

(define (haversine lat1 lon1 lat2 lon2)
  (local (axis-a axis-b radius flatten phi-1 phi-2
         lambda-1 lambda-2 sin-phi sin-lambda h-val)
    ; CONTANTI WGS84
    ; https://en.wikipedia.org/wiki/World_Geodetic_System
    ; Distanze in metri (m)
    (setq axis-a 6378137.0)
    (setq axis-b 6356752.314245)
    (setq radius 6378137)
    ; Parametri equazione
    ; https://en.wikipedia.org/wiki/Haversine_formula#Formulation
    (setq flatten (div (sub axis-a axis-b) axis-a))
    (setq phi-1 (atan (mul (sub flatten 1) (tan (deg-rad lat1)))))
    (setq phi-2 (atan (mul (sub flatten 1) (tan (deg-rad lat2)))))
    (setq lambda-1 (deg-rad lon1))
    (setq lambda-2 (deg-rad lon2))
    ; Equazione
    (setq sin-phi (sin (div (sub phi-2 phi-1) 2)))
    (setq sin-lambda (sin (div (sub lambda-2 lambda-1) 2)))
    (setq sin-phi (mul sin-phi sin-phi))
    (setq sin-lambda (mul sin-lambda sin-lambda))
    (setq h-val (sqrt (add sin-phi (mul (cos phi-1) (cos phi-2) sin-lambda))))
    ; risultato in metri (m)
    (mul 2 radius (asin h-val))))

Facciamo alcune prove (i risultati sono in metri):

(haversine 42.123456 13.123456 54.654321 8.654321)
;-> 1433443.903533894

(haversine 42.123456 -10.123456 54.654321 -2.654321)
;-> 1499077.34482137

(haversine 37.774856 -122.424227 37.864742 -119.537521)
;-> 254352.3520794544458


-------------------
Formula di Lamberts
-------------------

La formula di Lamberts calcola la distanza più breve lungo la superficie di un ellissoide tra due punti sulla superficie terrestre date le loro longitudini e latitudini (in gradi decimali).
Rappresentare la terra come un ellissoide (cioè tenere conto dell'appiattimento ai poli nord e sud) ci permette di approssimare le distanze tra punti sulla superficie terrestre molto meglio di una sfera.
Le formule di Lambert forniscono una precisione nell'ordine di 10 metri su migliaia di chilometri. Altri metodi possono fornire una precisione millimetrica, ma questo è un metodo più semplice da calcolare.

NOTA: questo algoritmo utilizza la funzione "haversine" (vedi Formula di Haversine).

Per l'implementazione seguiamo la formula su wikipedia:

https://en.wikipedia.org/wiki/Geographical_distance#Lambert's_formula_for_long_lines

(define (deg-rad deg) (div (mul deg 3.1415926535897931) 180))

(define (lamberts lat1 lon1 lat2 lon2)
  (local (axis-a axis-b radius flatten b-lat1 b-lat2 sigma p-value q-value
          x-numer x-denom x-val y-numer y-denom y-val)
    ; CONTANTI WGS84
    ; https://en.wikipedia.org/wiki/World_Geodetic_System
    ; Distanze in metri (m)
    (setq axis-a 6378137.0)
    (setq axis-b 6356752.314245)
    ; raggio equatoriale
    (setq radius 6378137)
    ; Parametri equazione
    ; https://en.wikipedia.org/wiki/Geographical_distance#Lambert's_formula_for_long_lines
    (setq flatten (div (sub axis-a axis-b) axis-a))
    ; Latitudini parametriche
    ; https://en.wikipedia.org/wiki/Latitude#Parametric_(or_reduced)_latitude
    (setq b-lat1 (atan (mul (sub 1 flatten) (tan (deg-rad lat1)))))
    (setq b-lat2 (atan (mul (sub 1 flatten) (tan (deg-rad lat2)))))
    ; Calcola l'angolo centrale tra due punti usando la funzione haversine
    ; sigma = haversine / radius
    (setq sigma (div (haversine lat1 lon1 lat2 lon2) radius))
    ; Valori intermedi P e Q
    (setq p-value (div (add b-lat1 b-lat2) 2))
    (setq q-value (div (sub b-lat2 b-lat1) 2))
    ; Valore intermedio X
    ; X = (sigma - sin(sigma)) * sin^2P*cos^2Q / cos^2(sigma/2)
    (setq x-numer (mul (sin p-value) (sin p-value) (cos q-value) (cos q-value)))
    (setq x-denom (mul (cos (div sigma 2)) (cos (div sigma 2))))
    (setq x-val (mul (sub sigma (sin sigma)) (div x-numer x-denom)))
    ; Valore intermedio Y
    ; Y = (sigma + sin(sigma)) * cos^2P*sin^2Q / sin^2(sigma/2)
    (setq y-numer (mul (cos p-value) (cos p-value) (sin q-value) (sin q-value)))
    (setq y-denom (mul (sin (div sigma 2)) (sin (div sigma 2))))
    (setq y-val (mul (add sigma (sin sigma)) (div y-numer y-denom)))
    (mul radius (sub sigma (mul (div flatten 2) (add x-val y-val))))))

Facciamo alcune prove (i risultati sono in metri):

(lamberts 37.774856 -122.424227 37.864742 -119.537521)
;-> 254351.2128767878

(lamberts 37.774856 -122.424227 40.713019 -74.012647)
;-> 4138992.016770486

(lamberts 37.774856 -122.424227 45.443012 12.313071)
;-> 9737326.37699303

(lamberts 37.774856 -122.424227 37.864742 -119.537521)


-------------------
Metodo di bisezione
-------------------

Il metodo di Bisezione trova il valore dove una funzione diventa 0 in [a,b], cioè trova una radice della funzione.
Questo metodo è robusto, ma la convergenza è lineare (aggiunge solo un bit di accuratezza/precisione ad ogni iterazione).

(define (bisezione func a b)
(catch
  (local (start end mid)
    (setq start a)
    (setq end b)
    (cond ((zero? (func a)) a)
          ((zero? (func b)) b)
          ; se a e b sono entrambi positivi o entrambi negativi,
          ; allora questo metodo fallisce
          ((> (mul (func a) (func b)) 0) nil)
          (true
            (setq mid (add start (div (sub end start) 2)))
            # precisione del risultato 10e-9
            (while (> (abs (sub mid start)) 10e-9)
              (cond ((zero? (func mid))
                     (throw mid))
                    ((< (mul (func mid) (func start)) 0)
                     (setq end mid))
                    (true (setq start mid))
              )
              (setq mid (add start (div (sub end start) 2)))
            )
           )
    )
    mid)))

Vediamo un paio di esempi:

(define (f x) (sub (mul x x x) 1))
;-> (lambda (x) (sub (mul x x x) 1))

(bisezione f -5 5)
;-> 1.000000005587935

Valutiamo la funzione nel punto calcolato per vedere l'errore:
(f (bisezione f -5 5))
;-> 1.676380634307861e-008

(define (f x) (add (mul x x) (mul x -4) 3))
;-> (lambda (x) (add (mul x x) (mul x -4) 3))

(bisezione f 0 2)
;-> 1
(bisezione f 2 4)
;-> 3
(bisezione f 4 1000)
;-> nil


--------------------
Metodo delle secanti
--------------------

Il metodo delle secanti è un metodo semplice per il calcolo approssimato di una soluzione (radice) di un'equazione della forma f(x)=0. Esso si applica dopo avere determinato un intervallo [a,b] che contiene una sola radice.

Il metodo consiste nel costruire una successione di punti con il seguente criterio:
assegnati due punti iniziali x(0),x(1), per ogni n > 1 il punto x(n+1) sia lo zero della retta passante per i punti (x(n-1), f(x(n-1))), (x(n), f(x(n))). Si ottiene:

                x(n) - x(n-1)
  x(n+1) = ------------------------- * f(x(n))
              f(x(n)) - f(x(n-1))

La convergenza è locale, cioè dipende dalla scelta dei punti iniziali x(0) e x(1) e la velocità di convergenza è superlineare (convergenza con ordine phi = (1+sqrt(5))/2 ≈ 1.618).

(define (secante func a b iter)
  (let ((x0 a) (x1 b) (x2 0))
    (for (i 1 iter)
      ;(map set (x0 x1) (x1 (sub x1 (div (mul (func x1) (sub x1 x0)) (sub (func x1) (func x0))))))
      (setq temp x0)
      (setq x0 x1)
      (setq x1 (sub x1 (div (mul (func x1) (sub x1 temp)) (sub (func x1) (func temp)))))
      ;(setq x2 (sub x1 (div (mul (func x1) (sub x1 x0)) (sub (func x1) (func x0)))))
      ;(setq x0 x1)
      ;(setq x1 x2)
    )
    x1))

Vediamo un paio di esempi:

(define (f x) (sub (mul x x) 612))

(secante f 10 30 5)
;-> 24.73863374875072

(f (secante f 10 30 5))
;-> -2.451718046359019e-007

(define (f x) (add (mul x x) (mul -10 x) 10))

(secante f 0 5 7)
;-> 1.127016653809932

(f (secante f 0 5 7))
;-> -1.34381394900629e-010


----------------
Metodo di Newton
----------------

Il metodo di Newton (o metodo delle tangenti o metodo di Newton-Raphson), è uno dei metodi per il calcolo approssimato di una soluzione di un'equazione della forma f(x)=0. Esso si applica dopo avere determinato un intervallo [a,b] che contiene una sola radice.

Il metodo consiste nel sostituire alla curva y=f(x) la tangente alla curva stessa, partendo da un qualsiasi punto. Per semplicità si può iniziare da uno dei due punti che hanno come ascissa gli estremi dell'intervallo [a,b] e assumere, come valore approssimato della radice, l'ascissa x(t) del punto in cui la tangente interseca l'asse delle x internamente all'intervallo [a,b].

Procedendo in modo iterativo si dimostra che la relazione di ricorrenza del metodo è

                    f(x(n))
  x(n+1) = x(n) - ------------
                    f'(x(n))

che permette di determinare successive approssimazioni della radice dell'equazione y=f(x)=0. Con queste ipotesi, si può dimostrare che la successione delle x(n) converge alla radice piuttosto rapidamente.

Per l'implemetazione seguiamo l'algoritmo di wikipedia:

https://en.wikipedia.org/wiki/Newton%27s_method

I parametri della nostra procedura sono:

  func -> funzione
  dfunc -> derivata della funzione
  x0 -> ipotesi iniziale
  iter -> numero di iterazioni
  epsilon -> non dividere per un valore minore di questo
  tolerance -> precisione/accuratezza desiderata

(define (newton func dfunc x0 iter epsilon tolerance)
(catch
  (local (x1 y yder)
    (for (i 1 iter)
      (setq y (func x0))
      (setq yder (dfunc x0))
      ; fermarsi se il denominatore è troppo piccolo
      (cond ((< (abs yder) epsilon) (throw nil))
            (true
              ; newton
              (setq x1 (sub x0 (div y yder)))
              ; soluzione trovata se risultato è nella tolleranza
              (if (<= (abs (sub x1 x0)) tolerance)
                  (throw x1)
              )
              ; aggiorna x0
              (setq x0 x1))
      )
    )
    ; il metodo non converge
    nil)))

L'ipotesi iniziale sarà x0 = 1 e la funzione sarà f(x) = x^2 − 2 in modo che f'(x) = 2x.
Ogni nuova iterazione del metodo di Newton sarà indicata con x1. Durante il calcolo occorre verificare se il denominatore (yder) diventa troppo piccolo (minore di epsilon) (cosa che accade quando f′(x(n)) ≈ 0), altrimenti si potrebbe introdurre un errore troppo grande.

(define (f x) (sub (mul x x) 2))
(define (df x) (mul 2 x))

(newton f df 1 20 1e-7 1e-14)
;-> 1.414213562373095


-------------------------------
Conversioni tra unità di misura
-------------------------------

Funzione generale:

(define (convert val unit unit-name unit-value)
  (local (idx scala)
    (setq idx (find unit unit-name))
    (setq scala (mul val (unit-value idx)))
    (println val " " unit " is:")
    (dolist (el unit-name)
      (cond ((!= el unit)
            (println (format "%.6f %s" (div scala (unit-value $idx)) el)))
      ))))

Unità di Lunghezza
------------------

(setq length-unit '("km" "m" "cm" "mm" "mi" "yd" "ft" "in"))

(setq length-value '(1000.0 1.0 0.01 0.001 1609.34 0.9144 0.3048 0.0254))

(convert 10 "yd" length-unit length-value)
;-> 10 yd is:
;-> 0.009144 km
;-> 9.144000 m
;-> 914.400000 cm
;-> 9144.000000 mm
;-> 0.005682 mi
;-> 30.000000 ft
;-> 360.000000 in

Unità di Peso
-------------

(setq weight-unit '("kilogram" "gram" "milligram" "metric-ton" "long-ton"
                    "short-ton" "pound" "stone" "ounce" "carrat" "atomic-mass"))

(setq weight-value '(1 0.001 0.000001 1000 1016.04608 907.184 0.453592 6.35029
                     0.0283495 0.0002 1.660540199e-27))

(convert 50 "stone" weight-unit weight-value)
;-> 50 stone is:
;-> 317.514500 kilogram
;-> 317514.500000 gram
;-> 317514500.000000 milligram
;-> 0.317514 metric-ton
;-> 0.312500 long-ton
;-> 0.350000 short-ton
;-> 700.000220 pound
;-> 11200.003527 ounce
;-> 1587572.500000 carrat
;-> 191211570903981480000000000000.000000 atomic-mass

Unità di Volume
---------------

(setq volume-unit '("cubicmeter" "litre" "kilolitre" "gallon"
                    "cubicyard" "cubicfoot" "cup"))

(setq volume-value '(1 0.001 1 0.00454 0.76455 0.028 0.000236588))

(convert 500 "litre" volume-unit volume-value)
;-> 500 litre is:
;-> 0.500000 cubicmeter
;-> 0.500000 kilolitre
;-> 110.132159 gallon
;-> 0.653979 cubicyard
;-> 17.857143 cubicfoot
;-> 2113.378531 cup

Unità di Pressione
------------------

(setq pressure-unit '("atm" "pascal" "bar" "kilopascal" "megapascal"
                      "psi" "inHg" "torr"))

(setq pressure-value '(1 0.00000986923 0.986923 0.00986923 9.86923
                       0.068046 0.0334211 0.00131579))

(convert 1 "atm" pressure-unit pressure-value)
;-> 1 atm is:
;-> 101325.027383 pascal
;-> 1.013250 bar
;-> 101.325027 kilopascal
;-> 0.101325 megapascal
;-> 14.695941 psi
;-> 29.921217 inHg
;-> 759.999696 torr

Unità di Temperatura
--------------------

Celsius
-------

(define (celsius-fahrenheit celsius)
  (add (div (mul celsius 9) 5) 32))

(celsius-fahrenheit 273.354)
;-> 524.0372
(celsius-fahrenheit -40)
;-> -40
(celsius-fahrenheit 0)
;-> 32

(define (celsius-kelvin celsius)
  (add celsius 273.15))

(celsius-kelvin 0)
;-> 273.15
(celsius-kelvin 20)
;-> 293.15

(define (celsius-rankine celsius)
  (add (div (mul celsius 9) 5) 491.67))

(celsius-rankine 20)
;-> 527.6700000000001
(celsius-rankine 0)
;-> 491.67

(define (celsius-reaumur celsius)
  (div celsius 1.25))

(celsius-reaumur 20)
;-> 16
(celsius-reaumur 0)
;-> 0

Fahrenheit
----------

(define (fahrenheit-celsius fahrenheit)
  (div (mul 5 (sub fahrenheit 32)) 9))

(fahrenheit-celsius 0)
;-> -17.77777777777778
(fahrenheit-celsius 20)
;-> -6.666666666666667

(define (fahrenheit-kelvin fahrenheit)
  (add (div (mul 5 (sub fahrenheit 32)) 9) 273.15))

(fahrenheit-kelvin 20)
;-> 266.4833333333333
(fahrenheit-kelvin 0)
;-> 255.3722222222222

(define (fahrenheit-rankine fahrenheit)
  (add fahrenheit 459.67))

(fahrenheit-rankine 0)
;-> 459.67
(fahrenheit-rankine 20)
;-> 479.67

(define (fahrenheit-reaumur fahrenheit)
  (div (sub fahrenheit 32) 2.25))

(fahrenheit-reaumur 0)
;-> -14.22222222222222
(fahrenheit-reaumur 20)
;-> -5.333333333333333
(fahrenheit-reaumur 32)
;-> 0

Kelvin
------

(define (kelvin-celsius kelvin)
  (sub kelvin 273.15))

(kelvin-celsius 0)
;-> -273.15
(kelvin-celsius 40)
;-> -233.15

(define (kelvin-fahrenheit kelvin)
  (add (div (mul (sub kelvin 273.15) 9) 5) 32))

(kelvin-fahrenheit 0)
;-> -459.67
(kelvin-fahrenheit 300)
;-> 80.33000000000004
(kelvin-fahrenheit -273.15)
;-> -951.3399999999999

(define (kelvin-rankine kelvin)
  (div (mul kelvin 9) 5))

(kelvin-rankine 0)
;-> 0
(kelvin-rankine 20)
;-> 36

(define (kelvin-reaumur kelvin)
  (div (sub kelvin 273.15) 1.25))

(kelvin-reaumur 0)
;-> 218.52
(kelvin-reaumur 273.15)
;-> 0

Rankine
-------

(define (rankine-celsius rankine)
  (div (mul (sub rankine 491.67) 5) 9))

(rankine-celsius 300)
;-> -106.4833333333334
(rankine-celsius 0)
;-> -273.15
(rankine-celsius 273.15)
;-> -121.4

(define (rankine-fahrenheit rankine)
  (sub rankine 459.67))

(rankine-fahrenheit 300)
;-> -159.67
(rankine-fahrenheit 500)
;-> 40.32999999999998

(define (rankine-kelvin rankine)
  (div (mul rankine 5) 9))

(rankine-kelvin 0)
;-> 0
(rankine-kelvin 10)
;-> 5.555555555555555

(define (rankine-reaumur rankine)
  (div (sub rankine 32 459.67) 2.25))

(rankine-reaumur 491.67)
;-> 0
(rankine-reaumur 536.67)
;-> 19.99999999999998

Reaumur
-------

(define (reaumur-celsius reaumur)
  (mul reaumur 1.25))

(reaumur-celsius 16)
;-> 20
(reaumur-celsius 0)
;-> 0

(define (reaumur-fahrenheit reaumur)
  (add (mul reaumur 2.25) 32))

(reaumur-fahrenheit 0)
;-> 32
(reaumur-fahrenheit -10)
;-> 9.5

(define (reaumur-kelvin reaumur)
  (add (mul reaumur 1.25) 273.15))

(reaumur-kelvin 0)
;-> 273.15
(reaumur-kelvin 30)
;-> 310.65

(define (reaumur-rankine reaumur)
  (add (mul reaumur 2.25) 32 459.67))

(reaumur-rankine 0)
;-> 491.67
(reaumur-rankine 10)
;-> 514.1700000000001


-------------------------------
La funzione append e append-nil
-------------------------------

********************
>>> funzione APPEND
********************
sintassi: (append list-1 [list-2 ... ])
sintassi: (append array-1 [array-2 ... ])
sintassi: (append str-1 [str-2 ... ])

"append" funziona con liste, vettori, stringhe, aggiungendo list-1 (o array-1 o string-1) tramite list-n (o array-n o string-n) per formare una nuova lista (o vettore o stringa). Gli oggetti originali rimangono invariati.

(append '(1 2 3) '(4 5 6) '(a b))
;-> (1 2 3 4 5 6 a b)

(set 'aList '("hello" "world"))
;-> ("hello" "world")

(append aList '("here" "I am"))
;-> ("hello" "world" "here" "I am")

(set 'A (array 3 2 (sequence 1 6)))
;-> ((1 2) (3 4) (5 6))
(set 'B (array 2 2 (sequence 7 10)))
;-> ((7 8) (9 10))

(append A B)
;-> ((1 2) (3 4) (5 6) (7 8) (9 10))

(append B B B)
;-> ((7 8) (9 10) (7 8) (9 10) (7 8) (9 10))

(set 'more " how are you")
;-> " how are you"

(append "Hello " "world," more)
;-> "Hello world, how are you"

"append" è adatto anche per elaborare stringhe binarie contenenti zeri. La funzione "string" taglierebbe le stringhe a zero byte.

I caratteri o le stringhe di collegamento possono essere specificati utilizzando la funzione "join". Usa la funzione "string" per convertire gli argomenti in stringhe e aggiungerli in un solo passaggio.

Utilizzare le funzioni "extend" e "push" per aggiungere una lista o una stringa esistente modificando la l'oggetto di destinazione.

In Common LISP è possibile "appendere" una lista a nil:

  (append nil '(a b)) -> '(a b)

In newLISP questo genera un errore:

(append nil '(a b))
;-> ERR: array, list or string expected in function append : nil

Possiamo scrivere una funzione che si comporta come la "append" del Common LISP:

(define (append-nil obj)
  (if obj (append obj (apply append (args)))
            (apply append (args))))

(append-nil nil '(a b))
;-> (a b)

Verifichiamo che "append-nil" si comporta come "append":

(append-nil '(1 2 3) '(4 5 6) '(a b))
;-> (1 2 3 4 5 6 a b)

(append-nil aList '("here" "I am"))
;-> ("hello" "world" "here" "I am")

(append-nil A B)
;-> ((1 2) (3 4) (5 6) (7 8) (9 10))

(append-nil B B B)
;-> ((7 8) (9 10) (7 8) (9 10) (7 8) (9 10))

(append-nil "Hello " "world," more)
;-> "Hello world, how are you"


------------
Knapsack 0-1
------------

La seguente implementazione ricorsiva restituisce il valore massimo che può essere inserito in uno zaino di una data capacità, per cui ogni oggetto ha un peso e un valore specifico.

(define (knapsack capacita pesi valori)
  (local (num-oggetti)
    (setq num-oggetti (length valori))
    (knapsack-ex capacita pesi valori num-oggetti)
  ))

(define (knapsack-ex cap wei val cou)
  (local (left new-in new-out)
          ; caso base
    (cond ((or (zero? cou) (zero? cap))
           0)
  ; Se il peso dell'n-esimo oggetto è superiore alla capacità dello zaino,
  ; allora questo elemento non può essere incluso nella soluzione ottimale,
  ; altrimenti (true) restituisce il massimo di due casi:
  ; (1) n-esimo oggetto incluso
  ; (2) n-esimo oggetto non incluso
          ((> (wei (- cou 1)) cap)
           (knapsack-ex cap wei val (- cou 1)))
          (true
            (setq left (- cap (wei (- cou 1))))
            (setq new-in (+ (val (- cou 1))
                  (knapsack-ex left wei val (- cou 1))))
            (setq new-out (knapsack-ex cap wei val (- cou 1)))
            (max new-in new-out)))))

Vediamo un esempio:

capacita = 50
valori = (60 100 120)
pesi = (10 20 30)

(knapsack 50 '(10 20 30) '(60 100 120))
;-> 220
Il risultato è 220 perché i valori di 100 e 120 hanno il peso di 50 (20 + 30) che è il limite della capacità.

Vediamo un altro esempio:

(setq item '((maps 9 150) (compass 13 35) (water 153 200) (sandwich 50 160)
             (glucose 15 60) (tin 68 45) (banana 27 60) (apple 39 40)
             (cheese 23 30) (beer 52 10) (suntan-cream 11 70) (camera 32 30)
             (T-shirt 24 15) (trousers 48 10) (umbrella 73 40)
             (waterproof-trousers 42 70) (waterproof-overclothes 43 75)
             (note-case 22 80) (sunglasses 7 20) (towel 18 12) (socks 4 50)
             (book 30 10)
            ))

(setq p (map (fn(x) (x 1)) item))
;-> (9 13 153 50 15 68 27 39 23 52 11 32 24 48 73 42 43 22 7 18 4 30)
(setq v (map (fn(x) (x 2)) item))
;-> (150 35 200 160 60 45 60 40 30 10 70 30 15 10 40 70 75 80 20 12 50 10)

(knapsack 400 p v)
;-> 1030

Vedi anche "Il problema dello zaino (Knapsack)" su "Note libere 3" e "Problema dello zaino (Knapsack)" su "Rosetta Code".


--------------------
La funzione read-key
--------------------

**********************
>>> funzione READ-KEY
**********************
sintassi: (read-key [true])

Legge un tasto dalla tastiera e restituisce un valore intero. Per i tasti di navigazione, è necessario effettuare più chiamate a "read-key" a seconda del sistema operativo. Per i tasti che rappresentanono caratteri ASCII, il valore restituito è lo stesso su tutti i sistemi operativi, ad eccezione dei tasti di navigazione e di altre sequenze di controllo come i tasti funzione, nel qual caso i valori restituiti possono variare in base ai diversi sistemi operativi e configurazioni.

Quando si utilizza il flag true, "read-key" non è bloccante e viene restituito 0 (zero) quando non è stato premuto alcun tasto. Quando non si utilizza il flag extra, la chiamata a "read-key" blocca il programma finché non viene premuto un tasto.

(read-key)  → 97  ; dopo aver premuto il tasto A
(read-key)  → 65  ; dopo aver premuto il tasto Shift-A
(read-key)  → 10  ; dopo aver premuto il tasto [enter] on Linux
(read-key)  → 13  ; dopo aver premuto il tasto [enter] on Windows

(read-key true)  → 0 ; quando non viene premuto alcun tasto

(while (!= (set 'c (read-key)) 1) (println c))

L'ultimo esempio può essere utilizzato per controllare le sequenze di ritorno dei tasti di navigazione e dei tasti funzione. Per uscire dal ciclo, premere Ctrl-A.

Si noti che "read-key" funziona solo quando newLISP è in esecuzione in una shell Unix o in una shell dei comandi di Windows. Non funzionerà se eseguito dalla libreria condivisa newLISP Unix o dalla DLL (Dynamic Link Library) di MS Windows newLISP. Queste librerie non stanno ascoltando (listening) lo standard input.

Le seguenti note sono valide per il sistema operativo Windows.
Scriviamo una funzione che stampa il numero associato al tasto che viene premuto. Alcuni tasti (es. tasti funzione, tasti funzione e tasti speciali) restituiscono due valori, in questo caso il valore da considerare è l'ultimo che viene stampato.
La funzione viene interrotta premendo il tasto "Invio" (codice tasto: 13).

(define (keys)
  (local (k)
    (while (!= (setq k (read-key)) 13)
      (setq s (string k))
      (println s))))

Facciamo alcune prove:

(keys)
;-> 1   ; Ctrl-A
;-> 111 ; O
;-> 79  ; o
;-> 0
;-> 59  ; F1
;-> 0
;-> 60  ; F2
;-> 224
;-> 81  ; PageUp
;-> 224
;-> 72  ; Up
;-> 224
;-> 77  ; Right
;-> 224
;-> 80  ; Down
;-> 224
;-> 75  ; Left

Adesso vediamo come utilizzare questi codici per riconoscere quali tasti vengono premuti. Facciamo un esempio con i quattro tasti di navigazione: Up, Right, Down, Left.

(define (check-keys)
  (local (k)
    (while (!= (setq k (read-key)) 13)
      (cond ((= k 72) (println "Pressed UP key"))
            ((= k 77) (println "Pressed RIGHT key"))
            ((= k 80) (println "Pressed DOWN key"))
            ((= k 75) (println "Pressed LEFT key"))
      )
    )
    'end))

Lanciamo la funzione e poi premianmo i tasti di navigazione:

(check-keys)
;-> Pressed UP key
;-> Pressed UP key
;-> Pressed LEFT key
;-> Pressed DOWN key
;-> Pressed RIGHT key


--------------------------------
Problema del cambio delle monete
--------------------------------

Algoritmo di programmazione dinamica per la soluzione del problema del cambio delle monete riportato nel seguente articolo:

"Dynamic Programming Solution to the Coin Changing Problem"
College of Computer and Information Science, Northeastern University
CS7800 Advanced Algorithms
Prof. Aslam

https://www.ccs.neu.edu/home/jaa/CS7800.12F/Information/Handouts/dyn_prog.pdf

(define (change d n)
  (local (S C moneta minimo k out)
    (setq out '())
    (setq k (- (length d) 1))
    (setq C (array (+ n 1) '(0)))
    (setq S (array (+ n 1) '(0)))
    (for (p 1 n)
      (setq minimo 999999999)
      (setq moneta 0)
      (for (i 1 k)
        (if (>= p (d i))
            (if (< (+ (C (- p (d i))) 1) minimo)
                (set 'minimo (+ (C (- p (d i))) 1)
                     'moneta i)
            )
        )
        (setf (C p) minimo)
        (setf (S p) moneta)
      )
    )
    ; minimum moneys needed for the exchange
    (println (C n))
    ; build solution from S
    ; values of exhcange monetas
    (while (> n 0)
      ;(print (d (S n)) { })
      (if (!= (d (S n)) 0)
        (push (d (S n)) out -1)
      )
      (setq n  (- n (d (S n))))
    )
    out))

Parametri:

d -> lista delle monete (deve contenere anche 0 e 1)
n -> cifra da cambiare

Nota: la lista delle monete deve iniziare con 1 e l'elemento alla posizione 0 non è influente (per comodità poniamo l'elemento alla posizione 0 pari a 0).

(change '(0 1 5 10 20) 105)
;-> 6
;-> (5 20 20 20 20 20)

(change '(0 1 5 10 20) 106)
;-> 7
;-> (1 5 20 20 20 20 20)

(change '(0 1 3 5 10 20) 53)
;-> 4
;-> (3 10 20 20)

Il primo ciclo itera da 1 a n e quindi ha un tempo di esecuzione di O(n).
Poi troviamo un ciclo annidato. Il primo ciclo itera da 1 a n e il secondo itera da 1 a k che produce un tempo di esecuzione totale di O(n*k).
L'ultimo ciclo verrà eseguito n volte nel peggiore dei casi (a seconda del valore di n - d(S(n))), quindi ha un tempo di esecuzione di O(n).
Tutte le altre espressioni richiedono tempo costante.
Quindi l'algoritmo ha un tempo di esecuzione di O(n*k).


-----------------------------
Interesse semplice e composto
-----------------------------

L'interesse in economia finanziaria è la somma dovuta come compenso per ottenere la disponibilità di un capitale (solitamente una somma di denaro) per un certo periodo.

Il tasso di interesse è la percentuale del capitale che va pagata annualmente come interesse.

Interesse semplice
------------------
L'interesse lineare o interesse semplice è un interesse che si accumula linearmente. In altre parole, cresce di una certa frazione del capitale per unità di tempo.

Il capitale di riferimento del tasso di interesse semplice non varia mai, ma rimane sempre uguale. Vediamo come funziona con un esempio:

Acquistiamo un titolo di stato da 10000 euro che garantisce ogni anno un tasso di interesse del 5% netto.
Per calcolare quanti soldi riceverò tra 10 anni con un tasso di interesse semplice non devo fare altro che calcolare il 5% dei 10000 euro del primo anno e poi moltiplicare questa cifra per i successivi 10 anni. Quindi, poichè il 5% di 10000 euro è 500 euro, basta moltiplicare 500 euro per 10 anni e ottenere così l’incremento di 5000 euro. Alla fine del decimo anno avremo 10000 + 5000 = 15000 euro.

La formula generale è la seguente:

  C(n) = C0*(1 + n*t)

  C(n): Capitale dopo n anni
  C0:   Capitale iniziale
  t :   Tasso d'interesse
  n:    Numero di anni

(Nota: Il tasso di interesse "t" è un numero puro (es. 0.05), non una percentuale (es. 5%).

(define (interesse-semplice c0 t n)
  (mul c0 (add 1 (mul n t))))

(interesse-semplice 10000 10 0.05)
;-> 15000

Interesse composto
------------------
L'interesse composto o anatocismo è l'interesse che viene regolarmente aggiunto al debito. L'interesse viene allora calcolato non solo sul capitale, ma anche sugli interessi aggiunti al debito in precedenza – in altre parole, sul montante. Con l'interesse composto, la frequenza di capitalizzazione influenza l'interesse totale pagato nel corso della vita totale del prestito. La funzione dei montanti per l'interesse composto cresce in modo esponenziale rispetto al tempo.
Calcoliamo l'interesse composto con i dati dell'esempio precedente.
Dopo il primo anno, come visto sopra, abbiamo 500 euro in più e un capitale di 10500 euro. Poichè l'investimento genera un interesse del 5% annuo, occorre calcolare il 5% sul nuovo montante di 10500 euro. Andando avanti in questo modo, dopo il secondo anno abbiamo un valore di 525 euro e il terzo anno abbiamo un montante pari a 11025 euro... dopo 10 anni avremo un capitale di 16288.95 euro, quindi quasi 1290 euro in più rispetto al caso dell’interesse semplice.

  C(n) = C0*(1 + t/k)^(k*n)

  C(n): Capitale dopo n anni
  C0:   Capitale iniziale
  t :   Tasso d'interesse
  n:    Numero di anni
  k: Numero di periodi di capitalizzazione composta per anno
  (notare che il numero totale di periodi di capitalizzazione composta è k*n)

se k = 1  ==>  C(n) = C0*(1 + t)^n

(define (interesse-composto c0 t n k)
  (mul c0 (pow (add 1 (div t k)) (mul k n))))

(interesse-composto 10000 0.05 10 1)
;-> 16288.94626777442


------------------------------------------------------
Massima sottostringa comune (longest common substring)
------------------------------------------------------

Il problema della sottostringa comune più lunga è trovare la stringa più lunga che sia una sottostringa di due stringhe.

(define (longest-common-substring x y)
    (local (L m n max-len end-index)
      (setq m (length x))
      (setq n (length y))
      (setq max-len 0)
      (setq end-index 0)
      (setq L (array (+ m 1) (+ n 1) '(0)))
      ; fill the lookup table in a bottom-up manner
      (for (i 1 m)
        (for (j 1 n)
          ; if the current character of x and y matches
          (cond ((= (x (- i 1)) (y (- j 1)))
                 (setf (L i j) (+ (L (- i 1) (- j 1)) 1))
                 ; update the maximum length and ending index
                 (if (> (L i j) max-len)
                     (set 'max-len (L i j)
                          'end-index i)
                 ))
          )
        )
      )
      ; return longest common substring
      (slice x (- end-index max-len) max-len)))

Vediamo un paio di esempi:

(longest-common-substring "DABCE" "BABCABCEA")
;-> "ABCE"

(longest-common-substring "DZZZA" "BAJADHADCZZZBABCABCEA")
;-> "ZZZ"


---------------------------------------------------------
Massima sottosequenza comune (longest common subsequence)
---------------------------------------------------------

Il problema della sottosequenza comune più lunga (LCS) è il problema di trovare la sottosequenza più lunga comune a tutte le sequenze in un insieme di sequenze (spesso solo due sequenze). Si differenzia dal problema di sottostringa comune più lunga: a differenza delle sottostringhe, le sottosequenze non devono occupare posizioni consecutive all'interno delle sequenze originali.

Date due sequenze, trova la lunghezza della sottosequenza più lunga presente in entrambe. Una sottosequenza è una sequenza che appare nello stesso ordine relativo, ma non necessariamente continua.
Esempio: "abc", "abfh" sono sottosequenze di "abcdefgh".

(define (lcs x y)
  (local (m n L equal seq i j)
    (setq m (length x))
    (setq n (length y))
    (setq L (array (+ m 1) (+ n 1) '(0)))
      (for (i 1 m)
        (for (j 1 n)
          (if (= (x (- i 1)) (y (- j 1)))
              (setq equal 1)
              (setq equal 0)
          )
          (setf (L i j) (max (L (- i 1) j) (L i (- j 1)) (+ (L (- i 1) (- j 1)) equal)))
        )
      )
      (setq seq "")
      (setq i m)
      (setq j n)
      (while (and (> i 0) (> j 0))
        (if (= (x (- i 1)) (y (- j 1)))
                (setq equal 1)
                (setq equal 0)
        )
        (cond ((= (L i j) (+ (L (- i 1) (- j 1)) equal))
               (if (= equal 1) (setf seq (append (x (- i 1)) seq)))
               (-- i)
               (-- j))
              ((= (L i j) (L (- i 1) j))
               (-- i))
              (true (-- j))
        )
     )
     (list (L m n) seq)))

Vediamo un paio di esempi:

(lcs "abfh" "abcdefgh")
;-> (4 "abfh")

(lcs "AGXGTAB" "GXXTXAYB")
;-> (5 "GXTAB")


----------------------------------------------------------------
Massima sottosequenza crescente (longest increasing subsequence)
----------------------------------------------------------------

Il problema della massima sottosequenza crescente è quello di trovare in una data sequenza di numeri distinti, una sottosequenza in cui gli elementi siano in ordinati in ordine crescente, dal più basso al più alto, e in cui la stessa sottosequenza sia la più lunga possibile. Questa sottosequenza non è necessariamente unica o con numeri contigui della sequenza originale.
Secondo il teorema di Erdos–Szekeres, ogni sequenza di (n^2 + 1) interi distinti ha una sottosequenza crescente o decrescente di lunghezza n + 1.

(define (get-ceil-index arr T l r key i)
  (local (m)
    (while (> (- r l) 1)
      (setq m (+ l (/ (- r l) 2)))
      (if (>= (arr (T m)) key)
          (setq r m)
          (setq l m)
      )
    )
    r))

(define (lis arr)
  (local (n tail prev len pos out)
    (setq n (length arr))
    (setq tail (array (+ n 1) '(0)))
    (setq prev (array (+ n 1) '(-1)))
    (setq len 1)
    (for (i 1 (- n 1))
      (cond ((< (arr i) (arr (tail 0)))
             (setf (tail 0) i))
            ((> (arr i) (arr (tail (- len 1))))
             (setf (prev i) (tail (- len 1)))
             (setf (tail len) i)
             (++ len))
            (true
              (setq pos (get-ceil-index arr tail -1 (- len 1) (arr i)))
              (setf (prev i) (tail (- pos 1)))
              (setf (tail pos) i))
      )
    )
    (setq out '())
    (setq i (tail (- len 1)))
    (while (>= i 0)
      ;(print (arr i) { })
      (push (arr i) out)
      (setq i (prev i))
    )
    out))

(setq numeri '(2 5 3 7 11 8 10 13 6))
(lis numeri)
;-> (2 3 7 8 10 13)
(setq num '(0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15))
(lis num)
;-> (0 2 6 9 11 15)

(setq lst '(7 6 5 4 3 2))
(lis lst)
;-> (2)

(setq lst '(7 6 5 4 2 1))
(lis lst)
;-> (1)

(setq lst '(10 22 9 33 21 50 41 60 80))
(lis lst)
;-> (10 22 33 41 60 80)

(setq lst '(4 8 7 5 1 12 2 3 9))
(lis lst)
;-> (1 2 3 9)

(setq lst '(9 8 7 6 5 8))
(lis lst)
;-> (5 8)


---------------------
Numeri potenze di due
---------------------

Determinare se un dato numero N è una potenza di due, cioè se risulta:

  N = 2^x, con x = 1,2,3,...

Primo metodo
------------
Prendere log del numero in base 2 e se è un numero intero, allora il numero è dato da potenza di 2.

(define (power-of-two1? num)
  (= (ceil (log num 2)) (floor (log num 2))))

(power-of-two1? 1024)
;-> true
(power-of-two2? 1023)
;-> nil

(clean nil? (map (fn(x) (if (= (power-of-two1? x) true) (+ $idx 1) nil)) (sequence 1 1e5)))
;-> (1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536)

Secondo metodo
--------------
Sfruttiamo il fatto che la rappresentazione binaria di un numero potenza di due ha un solo 1.

(define (power-of-two2? num)
  (if (= (length (find-all "1" (bits num))) 1) true nil))

(power-of-two2? 1024)
;-> true
(power-of-two2? 1023)
;-> nil

(clean nil? (map (fn(x) (if (= (power-of-two2? x) true) (+ $idx 1) nil)) (sequence 1 1e5)))
;-> (1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536)

Terzo metodo:
-------------

Se sottraiamo il valore 1 ad un numero che è potenza di due, l'unico bit con valore 1 viene posto a 0 e i bit con valore 0 vengono posti a 1:

  decimale   binario
  1024       10000000000
  1023       01111111111

  10000000000 and
  01111111111 =
  ---------------
  00000000000

Quindi applicando l'operatore bitwise AND "&" ai numeri n e (n - 1) otteniamo 0 se e solo se n è una potenza di due: (n & (n -1)) == 0 se e solo se n è una potenza di due.

Nota: L'espressione n & (n-1) riporta 0 anche quando n vale 0 che non è una potenza di due.

(define (power-of-two3? n)
  (if (<= n 0) nil
      (if (zero? (& n (- n 1))) true nil)))

(power-of-two3? 1024)
;-> true
(power-of-two3? 1023)
;-> nil

(clean nil? (map (fn(x) (if (= (power-of-two3? x) true) (+ $idx 1) nil)) (sequence 1 1e5)))
;-> (1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536)

Vediamo quale funzione è la più veloce:

(time (map power-of-two1? (sequence 1 1e7)))
;-> 2431.529

(time (map power-of-two2? (sequence 1 1e7)))
;-> 21435.716

(time (map power-of-two3? (sequence 1 1e7)))
;-> 1516.974

La funzione "power-of-two3?" è la più veloce.


---------------
Numeri di Proth
---------------

Nella teoria dei numeri, un numero Proth è un numero della forma:

   N = k*2^n + 1

dove k è un intero positivo dispari e n è un intero positivo tale che 2^n > k. Prendono il nome dal matematico francese Francois Proth.

Per esempio: 

P0 = 2^1 + 1 = 3
P1 = 2^2 + 1 = 5
P2 = 2^3 + 1 = 9
P3 = 3 × 2^2 + 1 = 13
P4 = 2^4 + 1 = 17
P5 = 3 × 2^3 + 1 = 25
P6 = 2^5 + 1 = 33
...

I primi numeri di Proth sono (sequenza OEIS A080075):
  3, 5, 9, 13, 17, 25, 33, 41, 49, 57, 65, 81, 97, 113,
  129, 145, 161, 177, 193, 209, 225, 241, ...

Scriviamo una funzione che restituisce una lista con tutti i primi n numeri di Proth:

(define (proth num)
  (local (out out-idx idx incr)
    (cond ((< num 1) (setq out nil))
          ((= num 1) (setq out '(3)))
          ((= num 2) (setq out '(3 5)))
          (true
            (setq out '(3 5))
            (setq out-idx 2)
            ; +1 per le potenze di 2 a partire da 0, ovvero 2^0, 2^1, ecc.
            ; +1 per iniziare la sequenza dal terzo numero di Proth
            ; Quindi +2 nell'espressione seguente
            (setq idx (+ (int (log (/ num 3) 2)) 2))
            (setq incr 3)
            (for (bl 1 (- idx 1))
              (for (i 0 (- incr 1))
                (push (+ (pow 2 (+ bl 1)) (out (- out-idx 1))) out -1)
                (++ out-idx)
              )
              (setq incr (* incr 2))
            ))
    )
    (if (<= num 1)
      out
      (slice out 0 num))))

Proviamo la funzione:

(proth 0)
;-> nil

(proth 11)
;-> (3 5 9 13 17 25 33 41 49 57 65)

(proth 100)
;-> (3 5 9 13 17 25 33 41 49 57 65 81 97 113 129 145 161 177 193 
;->  209 225 241 257 289 321 353 385 417 449 481 513 545 577 609 
;->  641 673 705 737 769 801 833 865 897 929 961 993 1025)

I numeri di Proth che sono anche numeri primi iniziano con la sequente sequenza (OEIS A080076):

  3, 5, 13, 17, 41, 97, 113, 193, 241, 257, 353, 449, 577, 641, 673, 
  769, 929, 1153, 1217, 1409, 1601, 2113, 2689, 2753, 3137, 3329, 3457,
  4481, 4993, 6529, 7297, 7681, 7937, 9473, 9601, 9857, ...

e ancora non è stato dimostrato se siano in numero infinito oppure no.

Adesso vediamo una funzione che verifica se un determinato numero è un numero di Proth.

Funzione che verifica se un determinato numero è una potenza di 2:

(define (power-of-two? n)
  (if (<= n 0) 
      nil
      (if (zero? (& n (- n 1))) true nil)))

(define (proth? num)
(catch
  (let ((k 1) (num (- num 1)))
    (while (< k (/ num k))
      ; verifica se k divide n
      (if (zero? (% num k))
          ; verifica se n/k è potenza di 2
          (if (power-of-two? (/ num k)) (throw true))
      )
      ; prossimo k dispari
      (++ k 2)
    )
    ; adesso non esiste alcun valore di k
    ; tale che k è un numero dispari
    ; e n/k è una potenza di 2 maggiore di k
    nil)))

Proviamo la funzione:

(proth? 3)
;-> true
(proth? 1601)
;-> true

Calcoliamo i numeri di Proth con la funzone "proth?":

(clean nil? (map (fn(x) (if (= (proth? x) true) (+ $idx 1) nil)) (sequence 1 50)))
;-> (3 5 9 13 17 25 33 41 49)


----------------
Funzione sigmoid
----------------

Una funzione sigmoid è una funzione matematica avente una caratteristica curva a forma di "S" o curva sigmoidea.

Un esempio comune di funzione sigmoidea è la funzione logistica definita dalla formula:

            1            e^x
S(x) = ------------ = --------- = 1 - S(-x)
        1 + e^(-x)     e^x + 1

Nel contesto delle reti neurali artificiali, il termine "funzione sigmoid" è usato come alias per la funzione logistica.

(define (sigmoid x)
  (div (add 1 (exp (sub x)))))

Proviamo la funzione:

(sigmoid 0)
;-> 0.5

(sigmoid 0.7365642262031923)

(sigmoid -1)
;-> 0.2689414213699951
(sigmoid -5)
;-> 0.006692850924284855
(sigmoid -10)
;-> 4.53978687024344e-005
(sigmoid 1)
;-> 0.7310585786300049
(sigmoid 5)
;-> 0.9933071490757153
(sigmoid 10)
;-> 0.9999546021312976

Applichiamo la funzione "sigmoid" ad una lista di numeri:

(setq num (random 0 5 10))
;-> (4.294717246009705 3.552507095553453 2.567674794763024
;->  1.51997436445204 0.0749229407635731 0.457014679403058
;->  1.822260200811792 0.7365642262031923 0.8294930875576037
;->  4.942625202185125)

(setq num '(4.294717246009705 3.552507095553453 2.567674794763024
  1.51997436445204 0.0749229407635731 0.457014679403058
  1.822260200811792 0.7365642262031923 0.8294930875576037
  4.942625202185125))

(map sigmoid num)
;-> (0.9865431294370095 0.9721453955887022 0.9287519863607289 
;->  0.820534705596925 0.5187219781074153 0.6123057366241003 
;->  0.8608371122526624 0.6762440906843146 0.6962477351861746 
;->  0.9929147187018224)


---------------------
Algoritmo Round-Robin
---------------------

Round Robin è un algoritmo di scheduling di processi in cui ad ogni processo viene assegnato un tempo prefissato in modo ciclico.
Per schedulare i processi in modo equo, uno scheduler round-robin generalmente impiega la tecnica di time-sharing, assegnando a ciascun lavoro un determinato intervallo di tempo (in tempo di CPU) chiamato quantum e interrompendo il lavoro anche se non è stato completato al termine del tempo disponibile. Il lavoro viene ripreso la prossima volta che viene assegnato un altro quantum a quel processo. Se il processo termina  durante il quantum di tempo attribuito, lo scheduler seleziona il primo processo nella coda di pronto per l'esecuzione. In assenza di time-sharing o se i quanti fossero grandi rispetto alle dimensioni dei lavori, un processo che necessita più tempo sarebbe favorito rispetto ad altri processi. L'algoritmo round-robin è un algoritmo "preemptive" poiché lo scheduler forza il processo fuori dalla CPU una volta scaduta la quota di tempo.

(define (round-robin exec-time quantum)
(catch
  (local (tmp-exec-time wait-time t done)
    (setq tmp-exec-time exec-time)
    (setq wait-time (array (length exec-time) '(0)))
    (setq t 0)
    (while true
      (setq done true)
      (dolist (b-time exec-time)
        (if (> (tmp-exec-time $idx) 0)
          (begin
            (setq done nil)
            (if (> (tmp-exec-time $idx) quantum)
              (begin
                (setq t (+ t quantum))
                (setf (tmp-exec-time $idx) (- (tmp-exec-time $idx) quantum)))
              (begin
                (setq t (+ t (tmp-exec-time $idx)))
                (setf (wait-time $idx) (- t b-time))
                (setf (tmp-exec-time $idx) 0))
            )
          )
        )
      )
      (if done (throw wait-time))))))

Proviamo la funzione:

(round-robin '(10 5 8) 2) 
;-> (13 10 13)

(round-robin '(4 6 3 1) 2)
;-> (5 8 9 6)

(round-robin '(12 2 10) 2)
;-> (12 2 12)

Scriviamo una funzione che calcola i tempi totali per l'esecuzione di ogni processo:

  total-time = exec-time + wait-time

(define (total-time exec-times wait-times)
  (map + exec-times wait-times))

Facciamo una prova:

(setq exec-times '(3 5 7))
;-> (3 5 7)
(setq wait-times (round-robin exec-times 2))
;-> (4 7 8)
(setq total-times (total-time exec-times wait-times))
;-> (7 12 15)


--------------------------------------------
Estrazione di righe o colonne da una matrice
--------------------------------------------

Supponiamo di avere la seguente matrice 2x3:

(setq m '((1 2 3)
          (4 5 6)))

Se vogliamo estrarre una riga intera dalla matrice (es la riga 0) possiamo scrivere:

(m 0)
;-> (1 2 3)

Ma se vogliamo estrarre una colonna non possiamo usare lo stesso metodo perchè una colonna non è indicizzabile direttamente. Il trucco consiste nel trasporre la matrice e poi estrarre la colonna (che è diventata una riga nella matrice trasposta). Per esempio per estrarre la colonna 0 possiamo scrivere:

((transpose m) 0)
;-> (1 4)

Scriviamo due funzioni per estrarre una riga o una colonna da una matrice:

(define (get-row matrix row)
  (matrix row))

(define (get-column matrix column)
  ((transpose matrix) column))

(get-row m 1)
;-> (4 5 6)

(get-column m 2)
;-> (3 6)


------------------------------------------
La funzione count (per stringhe e vettori)
------------------------------------------

newLISP ha una funzione di conteggio molto utile per le liste: "count". Vediamo la definizione dal manuale:

*******************
>>> funzione COUNT
*******************
sintassi: (count list-1 list-2)

Conta gli elementi della lista-1 nella lista-2 e restituisce una lista di tali conteggi.

(count '(1 2 3) '(3 2 1 4 2 3 1 1 2 2))
;-> (3 4 2)
(count '(z a) '(z d z b a z y a))
;-> (3 2)

(set 'lst (explode (read-file "myFile.txt")))
(set 'letter-counts (count (unique lst) lst))

Il secondo esempio conta tutte le occorrenze di lettere diverse in myFile.txt.

Gli elementi della prima lista, che specifica gli elementi da conteggiare nella seconda lista, devono essere univoci. Per gli elementi che non sono univoci, solo la prima istanza conterrà un conteggio, tutte le altre istanze visualizzeranno 0 (zero).

Purtroppo questa funzione si applica solo alle liste e non alle stringhe o ai vettori, però possiamo scrivere una funzione che usa le stringhe o i vettori:

(define (count-obj lst-obj obj)
  (let (out '())
    (dolist (s lst-obj)
      (push (length (find-all s obj)) out -1)
    )
    out))

(count-obj '("a") "mamma mia")
;-> (3)
(count-obj '("a" "b" "c") "aabbcabsdbcgabcbfbghsgbc")
;-> (4 8 4)
(count-obj '("aa" "bb" "c") "aabbccaaccbb")
;-> (2 2 4)

(count-obj '(1 2) '(2 2 2 1 1 1 3 1 2 4 5))
;-> (4 4)
(count-obj '((1 2) (2 2)) '((2 2) (2 1) (1 1)))
;-> (0 1)


-----------------
Onesti e Bugiardi
-----------------

In un paese ci sono due tipi di persone, gli Onesti che dicono sempre la verità e i Bugiardi che mentono sempre.
Incontriamo tre persone (A, B e C) e chiediamo alla prima (A):
"Sei un Onesto o un Bugiardo?" La sua risposta è incomprensibile.
Allora la seconda persona (B) dice: "Ha detto che appartiene ai Bugiardi".
Ma la terza persona interviene: "Non credere a lui (B), è un Bugiardo"
Un giorno al mercato ci sono tre isolani (A, B e C) che stanno parlando. Arriva uno straniero che chiede ad A: "Sei un Onesto o un Bugiardo?". La risposta è incomprensibile.
Allora lo straniero chiede a B: "Cosa ha detto A?" B risponde "Ha detto di essere un Bugiardo."
Interviene C: "Non credere a B, lui è un Bugiardo!"

A quale tipo appartengono A, B e C ?

Soluzione
---------
"A" non può aver detto di essere un "Bugiardo", perché se fosse stato "Onesto" avrebbe detto di essere "Onesto" e se fosse stato "Bugiardo" avrebbe ugualmente detto, mentendo, di essere "Onesto".
Quindi "B" ha mentito nel riportare la risposta di "A" e perciò è un "Bugiardo".
"C" dice correttamente che "B" è un "Bugiardo", per cui è "Onesto".
Non si può sapere di che tipo sia "A" (anche perchè non si sa cosa ha detto).


-----------------
I tre prigionieri
-----------------

Siamo in una prigione con altri due prigionieri, il Bugiardo (che dice sempre bugie) e l'Onesto (che dice sempre la verità). Nella prigione ci sono due porte (P1 e P2), una porta conduce alla libertà e una alla condanna. I due prigionieri conoscono dove conducono le due porte. Ci viene concesso di fare una sola domanda ad uno dei due prigionieri. Quale domanda dobbiamo porre per individuare la porta che conduce alla libertà?

Soluzione
---------
Ad uno qualunque dei due prigionieri chiediamo:
Quale porta mi indicherebbe l'altro prigioniero se gli chiedessi quale porta conduce alla condanna?
Vediamo i due casi:
1) domanda rivolta al prigioniero "Onesto":
L'altro prigioniero indicherebbe la porta della libertà (perchè dice il falso), quindi l'Onesto risponderebbe: "l'altro prigioniero ti indicherebbe la porta" della libertà.
2) domanda rivolta al prigioniero "Bugiardo":
L'altro prigioniero indicherebbe la porta della condanna (perchè dice il vero), quindi il Bugirado risponderebbe: "l'altro prigioniero ti indicherebbe la porta" della libertà. 
Quindi con questa domanda entrambi i prigionieri indicherebbero la porta della libertà, quindi basta scegliere l'altra porta per essere liberi.


----------
Primi Home
----------

I primi Home (Home primes) sono definiti nel modo seguente:

per n >= 2, a(n) = il primo che viene finalmente raggiunto quando inizi con n, concateni i suoi fattori primi e ripeti fino a quando non viene raggiunto un primo (a(n) = -1 se nessun primo è viene mai raggiunto).

Sequenza OEIS A037274:

  2, 3, 211, 5, 23, 7, 3331113965338635107, 311, 773, 11, 223, 13, 
  13367, 1129, 31636373, 17, 233, 19, 3318308475676071413, 37, 211,
  23, 331319, 773, 3251, 13367, 227, 29, 547, 31, 241271, 311, 31397,
  1129, 71129, 37, 373, 313, 3314192745739, 41, 379, 43, 22815088913,
  3411949, 223, 47, ...

Scriviamo alcune funzioni che ci permettono di calcolare i primi home:

(define (make-int lst)
"Make an integer joining a list of integer"
  (int (join (map string lst))))

(make-int '(2 11));-> 211

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che genera tutti gli home-prime fino ad un determinato numero:

(define (home-prime num)
  (local (out)
    (setq out '())
    (for (i 2 num)
      (if (prime? i)
          ; se è primo lo inseriamo nella soluzione
          (push i out -1)
          ; altrimenti inseriamo il numero trasformato
          (push (hp i) out -1)))
    out))

Funzione che calcola le trasformazioni di un numero fino ad un numero primo:

(define (hp num)
  (local (res)
    (setq res num)
    (until (prime? (setq res (make-int (factor res))))
    res))

Proviamo la funzione:

(home-prime 10)
;-> (2 3 211 5 23 7 3331113965338635107 311 773)

(home-prime 20)
;-> (2 3 211 5 23 7 3331113965338635107 311 773 11 223
;->  13 13367 1129 31636373 17 233 19 3318308475676071413)

(time (println (home-prime 47)))
;-> (2 3 211 5 23 7 3331113965338635107 311 773 11 223 13 13367 1129 
;->  31636373 17 233 19 3318308475676071413 37 211 23 331319 773 3251
;->  13367 227 29 547 31 241271 311 31397 1129 71129 37 373 313 
;->  3314192745739 41 379 43 22815088913 3411949 223 47)
;-> 11757.11

Non abbiamo utilizzano i big-integer perchè fino al numero 47 non superiamo il valore massimo degli interi lunghi (9223372036854775807), ma per il numero 48 si ha il numero 6161791591356884791277 (che supera il valore massimo degli interi lunghi), e per il numero 49 si ha un numero ancora più lungo (che con conosco). 

Scriviamo una funzione che "traccia" le trasformazioni di un numero:

(define (hp-trace num)
  (let (out (list num))
    (until (prime? (setq num (make-int (factor num))))
      (push num out -1))
    (push num out -1)))

Vediamo le trasformazioni di alcuni numeri:

(hp-trace 3)
;-> (3 3)

(hp-trace 8)
;-> (8 222 2337 31941 33371313 311123771 7149317941 
;->  22931219729 112084656339 3347911118189 11613496501723 
;->  97130517917327 531832651281459 3331113965338635107)

(hp-trace 20)
;-> (20 225 3355 51161 114651 3312739 17194867 194122073 709273797 
;->  39713717791 113610337981 733914786213 3333723311815403 
;->  131723655857429041 772688237874641409 3318308475676071413)


--------------------------
Numeri figurati poligonali
--------------------------

Un numero figurato poligonale è un numero intero che può essere rappresentato mediante uno schema geometrico regolare che rappresenta un poligono.

Triangolari: F3(n) = ((n + 1)*n)/2
Sequenza OEIS A000217
(define (F3 n) (/ (* n (+ n 1)) 2))
(map F3 (sequence 1 10))
;-> (1 3 6 10 15 21 28 36 45 55)

Quadrati:    F4(n) = n^2
Sequenza OEIS A000290
(define (F4 n) (* n n))
(map F4 (sequence 1 10))
;-> (1 4 9 16 25 36 49 64 81 100)

Pentagonali: F5(n) = (3*n^2 - n)/2
Sequenza OEIS A000326
(define (F5 n) (/ (- (* 3 n n) n) 2))
(map F5 (sequence 1 10))
;-> (1 5 12 22 35 51 70 92 117 145)

Esagonali:   F6(n) = (2*n^2 - n)
Sequenza OEIS A000384
(define (F6 n) (- (* 2 n n) n))
(map F6 (sequence 1 10))
;-> (1 6 15 28 45 66 91 120 153 190)

Ettagonali:  F7(n) = (5*n^2 - 3*n)/2
Sequenza OEIS A000566
(define (F7 n) (/ (- (* 5 n n) (* 3 n)) 2))
(map F7 (sequence 1 10))
;-> (1 7 18 34 55 81 112 148 189 235)

Ottagonali:  F8(n) = 3*n^2 - 2*n
Sequenza OEIS A000567
(define (F8 n) (- (* 3 n n) (* 2 n)))
(map F8 (sequence 1 10))
;-> (1 8 21 40 65 96 133 176 225 280)

Nonagonali:  F9(n) = (7*n^2 - 5*n)/2
Sequenza OEIS A001106 
(define (F9 n) (/ (- (* 7 n n) (* 5 n)) 2))
(map F9 (sequence 1 10))
;-> (1 9 24 46 75 111 154 204 261 325)

Decagonali:  F10(n) = 4*n^2 - 3*n
Sequenza OEIS A001107
(define (F10 n) (- (* 4 n n) (* 3 n)))
(map F10 (sequence 1 10))
;-> (1 10 27 52 85 126 175 232 297 370)


---------------------------------
(* x x) è più veloce di (pow x 2)
---------------------------------

Caso con numeri interi:

(define (a x) (* x x))
(define (b x) (pow x 2))

(time (a 1234567890) 1e7)
;-> 567.51
(time (b 1234567890) 1e7)
;-> 708.287

Caso con numeri in virgola mobile:

(define (aa x) (mul x x))
(time (aa 1234567890.123456) 1e7)
;-> 557.538
(time (b 1234567890.123456) 1e7)
;-> 704.144

Proviamo con il cubo di un numero (* x x x):

Numeri interi:
(define (a x) (* x x x))
(define (b x) (pow x 3))
(time (a 1234567890) 1e7)
;-> 625.326
(time (b 1234567890) 1e7)
;-> 708.718

Numeri in virgola mobile:
(define (aa x) (mul x x x))
(time (aa 1234567890.123456) 1e7)
;-> 605.403
(time (b 1234567890.123456) 1e7)
;-> 704.6363

Proviamo con la quarta potenza di un numero (* x x x x):

Numeri interi:
(define (a x) (* x x x x))
(define (b x) (pow x 4))
(time (a 1234567890) 1e7)
;-> 668.702
(time (b 1234567890) 1e7)
;-> 709.389

Numeri in virgola mobile:
(define (aa x) (mul x x x x))
(time (aa 1234567890.123456) 1e7)
;-> 644.572
(time (b 1234567890.123456) 1e7)
;-> 705.045


-------------------
Sequenza di Padovan
-------------------

La sequenza di Padovan è una successione di numeri naturali definita nel modo seguente:

 P(0) = P(1) = P(2) = 1
 P(n) = P(n - 2) + P(n - 3) = P(n - 1) + P(n - 5)

Sequenza OEIS A000931:
  1, 1, 1, 2, 2, 3, 4, 5, 7, 9, 12, 16, 21, 28, 37, 49, 65, 86, 114, 151,
  200, 265, 351, 465, 616, 816, 1081, 1432, 1897, 2513, 3329, 4410, 5842,
  7739, 10252, 13581, 17991, 23833, 31572, 41824, 55405, ...

Scriviamo una funzione cha calcola l'n-esimo numero della sequenza di Padovan:

Versione ricorsiva:

(define (padovan n)
  (cond ((or (= n 0) (= n 1) (= n 2)) 1)
        (true
          (+ (padovan (- n 2)) (padovan (- n 3))))))

(padovan 8)
;-> 7

(map padovan (sequence 0 20))
;-> (1 1 1 2 2 3 4 5 7 9 12 16 21 28 37 49 65 86 114 151 200)

Versione iterativa:

(define (padovan-i n)
  (if (or (= n 0) (= n 1) (= n 2))
    1
    (let ((pPrev2 1) (pPrev 1) (pCurr 1) (pNext 1))
      (for (i 3 n)
        (setq pNext (+ pPrev2 pPrev))
        (setq pPrev2 pPrev)
        (setq pPrev pCurr)
        (setq pCurr pNext)
      )
      pNext)))

(padovan-i 8)
;-> 7

(map padovan-i (sequence 0 20))
;-> (1 1 1 2 2 3 4 5 7 9 12 16 21 28 37 49 65 86 114 151 200)

Modificando la versione iterativa possiamo ottenere tutta la sequenza di lunghezza n:

(define (padovan-seq n)
  (local (out)
    (cond ((= n 0) (setq out '(1)))
          ((= n 1) (setq out '(1 1)))
          ((= n 2) (setq out '(1 1 1)))
          (true
           (let ((pPrev2 1) (pPrev 1) (pCurr 1) (pNext 1))
            (setq out '(1 1 1))
            (for (i 3 n)
              (setq pNext (+ pPrev2 pPrev))
              (setq pPrev2 pPrev)
              (setq pPrev pCurr)
              (setq pCurr pNext)
              (push pNext out -1))))
    )
    out))

(padovan-seq 20)
;-> (1 1 1 2 2 3 4 5 7 9 12 16 21 28 37 49 65 86 114 151 200)


----------
Fattorione
----------

Un numero fattorione è un numero che è uguale alla somma dei fattoriali di ogni sua cifra, cioè un numero è un fattorione se risulta: 

  numero = d1! + d2! + d3! + ... + dn!
  dove d1..dn sono le cifre del numero

Funzione che calcola la somma dei fattoriali di ogni cifra di un determinato numero:

(define (sum-digit-fact num)
       ; precodifica dei fattoriali da 0 a 9
  (let ((fact '(1 1 2 6 24 120 720 5040 40320 362880))
        (temp num) (out 0))
    (while (> temp 0)
      (setq out (+ out (fact (% temp 10))))
      (setq temp (/ temp 10))
    )
    out))

Facciamo alcune prove:

(sum-digit-fact 122)
;-> 5

(sum-digit-fact 77)
;-> 10080

(sum-digit-fact 145)
;-> 145 ; è un numero fattorione

Proviamo ad applicare ripetutamente la funzione "sum-digit-fact" al suo output e verificare se si ottiene un ciclo.
Per esempio, partendo dal numero 169:

(sum-digit-fact 169)
;-> 363601

Adesso applico la funzione al risultato precedente:

(sum-digit-fact 363601)
;-> 1454

Continuo allo stesso modo:

(sum-digit-fact 1454)
;-> 169 ; uguale al numero di partenza -> abbiamo trovato un ciclo.

Il numero finale 169 è uguale al numero iniziale, quindi abbiamo trovato un ciclo reale: 

  (169 363601 1454 169)

Si può dimostrare che OGNI numero di partenza alla fine rimarrà bloccato in un ciclo reale o in un ciclo loop. Per esempio vediamo tre esempi di cicli loop:

  69 → 363600 → 1454 → 169 → 363601 → 1454
  78 → 45360 → 871 → 45361 → 871
  540 → 145 → 145

Scriviamo una funzione che calcola questi due tipi di cicli per un determinato numero:

(define (chain num)
  (let ((catena '()) (tmp num))
    (until (find num catena)
      (push num catena -1)
      (setq num (sum-digit-fact num))
    )
    (push num catena -1)
    (if (= num tmp)
        (push "R" catena) ; ciclo reale
        (push "L" catena) ; ciclo loop
    )))


(chain 169)
;-> ("R" 169 363601 1454 169)

(chain 44)
;-> ("L" 44 48 40344 79 367920 368649 404670 5810 40442 75 5160 842 40346 775 10200 6
;->  720 5043 151 122 5 120 4 24 26 722 5044 169 363601 1454 169)

Calcoliamo tutte le catene dei numeri da 1 a un milione:

(time (setq c (map chain (sequence 1 1e6))))
;-> 32993.293

Vediamo quanto è lunga la sequenza più lunga:

(apply max (map length c))
;-> 62

Contiamo quante sono le catene di ogni tipo (Reale e Loop):

(count '("L" "R") (map first c))
;-> (999989 11)

Vediamo quali sono le catene reali:

(filter (fn(x) (= "R" (first x))) c)
;-> (("R" 1 1) ("R" 2 2) ("R" 145 145) ("R" 169 363601 1454 169) 
;-> ("R" 871 45361 871) ("R" 872 45362 872) ("R" 1454 169 363601 1454)
;-> ("R" 40585 40585) ("R" 45361 871 45361) ("R" 45362 872 45362)
;-> ("R" 363601 1454 169 363601))


-----------
Numeri Star
-----------

Un numero star (stella) è un numero figurato (esagramma) centrato che forma una stella a sei punte (es.la Stella di David, la scacchiera della dama cinese).
Ad esempio i numeri 1, 13 e 37 sono numeri star:

  1        13               37
  *         *                *
         * * * *            * *
          * * *        * * * * * * * 
         * * * *        * * * * * *
            *            * * * * *
                        * * * * * *
                       * * * * * * * 
                            * *
                             *

L'n-esimo numero stella è dato dalla formula:

  S(n) = 6*n*(n − 1) + 1. 

Sequenza OEIS A003154:
  1, 13, 37, 73, 121, 181, 253, 337, 433, 541, 661, 793, 937, 1093, 1261, 1441, 
  1633, 1837, 2053, 2281, 2521, 2773, 3037, 3313, 3601, 3901, 4213, 4537, 4873, 
  5221, 5581, 5953, 6337, 6733, 7141, 7561, 7993, 8437, 8893, 9361, ...

(define (star n)
  (+ (* 6 n (- n 1)) 1))

(map star (sequence 1 40))
;-> (1 13 37 73 121 181 253 337 433 541 661 793 937 1093 1261 1441 
;->  1633 1837 2053 2281 2521 2773 3037 3313 3601 3901 4213 4537 4873
;->  5221 5581 5953 6337 6733 7141 7561 7993 8437 8893 9361)


------------
Numeri emirp
------------

Un emirp (prime scritto al contrario) è un numero primo che risulta in un primo diverso quando le sue cifre decimali sono invertite. Questa definizione esclude i numeri primi palindromici.

Sequenza OEIS: A006567
  13, 17, 31, 37, 71, 73, 79, 97, 107, 113, 149, 157, 167, 179, 199, 
  311, 337, 347, 359, 389, 701, 709, 733, 739, 743, 751, 761, 769, 
  907, 937, 941, 953, 967, 971, 983, 991, 1009, 1021, 1031, 1033, 
  1061, 1069, 1091, 1097, 1103, 1109, 1151, 1153, 1181, 1193, 1201

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

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

Calcoliamo i numeri primi fino a 1 milione ed eliminiamo (2 3 5 7 11):

(silent (setq a (primes-to 1e6))
  (setq a (slice a 5)))

(a 0)
;-> 13

Funzione per invertire un numero:

(define (inverte n)
  (int (reverse (string n))))

Invertiamo i numeri primi:

(setq b (map inverte a))

Intersezione tra i numeri primi e i loro inversi:

(silent (setq c (intersect a b)))
(length c)
;-> 11292

Adesso dobbiamo eliminare i numeri primi palindromi:

(define (palindrome? obj)
"Check if a number is palindrome"
      (let (str (string obj)) (= str (reverse (copy str)))))

(setq d (clean palindrome? c))
(length d)
;-> 11184

Vediamo i primi 40 numeri emirp:

(slice d 0 40)
;-> (13 17 31 37 71 73 79 97 107 113 149 157 167 179 199 
;->  311 337 347 359 389 701 709 733 739 743 751 761 769 
;->  907 937 941 953 967 971 983 991 1009 1021 1031 1033)


--------------------------------
Numeri con tutte le cifre uguali
--------------------------------

Determinare se un numero è composto da cifre tutte uguali.

Primo metodo
------------
Confronto delle cifre del numero tramite scomposizione algebrica

(define (check1 n)
  (local (digit cur-digit out)
    ; imposta ultima cifra
    (setq digit (% n 10))
    ; risultato true
    (setq out true)
    ; ciclo fino a n=0 e cifre uguali
    (while (and (!= n 0) out)
      ; imposta cifra corrente
      (setq cur-digit (% n 10))
      ; aggiorna n
      (setq n (/ n 10))
      ; se le cifre sono diverse...
      (if (!= cur-digit digit)
          ; esce dal ciclo con risultato nil
          (setq out nil)
      )
    )
    out))

(check1 1111)
;-> true
(check1 1121)
;-> nil
(time (map check1 (sequence 10 1e6)))
;-> 561.433

Secondo metodo
--------------
stringa del numero = prima cifra della stringa ripetuta per la lunghezza della stringa ?

(define (check2 n)
  (= (setq s (string n)) (dup (s 0) (length n))))

(check2 1111)
;-> true
(check2 1121)
;-> nil
(time (map check2 (sequence 10 1e6)))
;-> 688.428

Terzo metodo
------------
numero = (numero con tanti 1 quante sono le cifre) * (la prima cifra del numero) ?

(define (check3 n)
  (= n (* (int (dup "1" (length n))) (% n 10))))

(check3 1111)
;-> true
(check3 1121)
;-> nil
(time (map check3 (sequence 10 1e6)))
;-> 415.171

Quarto metodo
-------------
I caratteri di ogni cifra sono tutti uguali ?

(define (check4 n)
  (apply = (explode (string n))))

(check4 1111)
;-> true
(check4 1121)
;-> nil
(time (map check4 (sequence 10 1e6)))
;-> 1212.95

Quinto metodo
-------------
Come il primo metodo usando catch and throw.

(define (check5 n)
(catch
  (local (digit cur-digit)
    ; imposta ultima cifra
    (setq digit (% n 10))
    ; ciclo per estrarre le cifre...
    (while (!= n 0)
      ; imposta cifra corrente
      (setq cur-digit (% n 10))
      ; se le cifre sono diverse...
      (if (!= cur-digit digit)
          ; restituisce nil
          (throw nil)
      )
      ; aggiorna n
      (setq n (/ n 10))
    )
    true)))

(check5 1111)
;-> true
(check5 1121)
;-> nil
(time (map check5 (sequence 10 1e6)))
;-> 561.433

Sesto metodo (più veloce)
-------------------------
Formiamo un altro numero X in questo modo:

  X = N(0) * (K volte 1),

  dove N(0) è la prima cifra di N (ma può essere qualunque),
       K è la lunghezza di N

Vediamo un esempio:

N = 2222
N(0) = 2
K = 4 -> (K volte 1) = 1111
X = 2 * 1111 = 2222

A questo punto confrontiamo N con X:
  se sono uguali, allora il numero ha le stesse cifre
  altrimenti il numero non ha tutte le cifre uguali

Questo metodo è simile al terzo metodo, la differenza è che per creare il numero K composto da soli 1 utilizziamo la formula della somma di una progressione geometrica:

           a*r^C - 1
  Somma = -----------
             r - 1

dove "a" è il primo termine (in questo caso 1)
     "r" è il rapporto comune (in questo caso 10)
     "C" è il numero di cifre di N

Scriviamo una funzione per calcolare questa formula:

(define (K num-digits)
  (div (- (pow 10 num-digits) 1) 9))

(map K (sequence 1 8))
;-> (1 11 111 1111 11111 111111 1111111 11111111)

Adesso possiamo scrivere la funzione finale:

; (define (check6 n)
;   (= n (* (K (length n)) (% n 10))))

(define (check6 n)
  (= n (* (div (- (pow 10 (length n)) 1) 9) (% n 10))))

(check6 1111)
;-> true
(check6 1121)
;-> nil
(time (map check6 (sequence 10 1e6)))
;-> 345.272

Verifichiamo se le funzioni producono gli stessi risultati:

(= (map check1 (sequence 10 1e6)) (map check2 (sequence 10 1e6))
   (map check3 (sequence 10 1e6)) (map check4 (sequence 10 1e6))
   (map check5 (sequence 10 1e6)) (map check6 (sequence 10 1e6)))
;-> true


----------------------------
Numeri magici (magic number)
----------------------------

Nella programmazione il termine numero magico (magic number) ha molteplici significati. Potrebbe riferirsi a uno o più dei seguenti:

a) Valori numerici con significato inspiegabile o occorrenze multiple che potrebbero (preferibilmente) essere sostituiti con costanti denominate
b) Un valore numerico o di testo costante utilizzato per identificare un formato di file o un protocollo (es. firme dei file)
c) Valori univoci distintivi che è improbabile che vengano scambiati per altri significati (ad es. GUID, Globally Unique IDentifier)

Il tipo a) è un numero o una stringa di testo a cui non è associato un significato esplicito, ma il cui valore è essenziale ai fini del funzionamento del codice. Questo è sconsigliato dalle best practice della programmazione (anti-pattern). 
Questo anti-pattern è stato definito come la violazione di una delle più antiche regole di programmazione, che risale ai manuali COBOL, FORTRAN e PL/1 degli anni '60. L'uso di numeri magici senza nome nel codice oscura il significato del numero, aumenta le possibilità di errore e rende più difficile la manutenzione del programma. 
La sostituzione di tutti i numeri magici con costanti nominative semplifica la lettura, la comprensione e le modifiche dei programmi.

In matematica, esistono due definizioni di numero magico

1) un numero magico è un numero la cui somma ripetuta delle cifre vale 1.
Per esempio:

  numero = 50113 
  5 + 0 + 1 + 1 + 3 = 10  ->   1 + 0 = 1
Quindi 50113 è un numero magico (tipo 2).

  numero = 1234 
  1 + 2 + 3 + 4 = 10   ->  1 + 0 = 1
Quindi 50113 è un numero magico (tipo 2).

2) un numero magico è un numero la cui somma delle cifre moltiplicata per l'inverso della stessa somma restituisce il numero originale. 
Per esempio: 

  Numero = 1729
  1 + 7 + 2 + 9 = 19
  (inverso 19) = 91
  19 * 91 = 1729 
Quindi 1729 è un numero magico (tipo 1).


Scriviamo due funzioni per verificare se un numero n è un numero magico (di tipo 1 o di tipo 2):

Magico tipo 1
-------------

(define (digit-root num)
"Calculates the repeated sum of the digits of an integer"
    (+ 1 (% (- (abs num) 1) 9)))

(define (magic1? n)
  (= (digit-root n) 1))

(magic1? 50113)
;-> true
(magic1? 1234)
;-> true

(define (magic1?-to num)
  (let (out '())
    (for (i 1 num)
      (if (magic1? i)
          (push i out -1)
      )
    )
    out))

(magic1?-to 100)
;-> (1 10 19 28 37 46 55 64 73 82 91 100)

(filter (fn(x) (magic1? x)) (sequence 1 100))
;-> (1 10 19 28 37 46 55 64 73 82 91 100)

Magico tipo 2
-------------

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

Funzione per invertire un numero:

(define (inverte n)
  (int (reverse (string n))))

(define (magic2? n)
  (letn ((a (digit-sum n)) (b (inverte a)))
    ;(println a { } b)
    (= (* a b) n)))

(magic2? 1729)
;-> true

(define (magic2?-to num)
  (let (out '())
    (for (i 1 num)
      (if (magic2? i)
          (push i out -1)
      )
    )
    out))

(magic2?-to 1e6)
;-> (1 81 1458 1729)

(filter (fn(x) (magic2? x)) (sequence 1 1e6))
;-> (1 81 1458 1729)

(time (magic2?-to 1e6))
;-> 1484.28
(time (filter (fn(x) (magic2? x)) (sequence 1 1e6)))
;-> 1536.011


---------------------
Numeri polidivisibili
---------------------

Un numero polidivisibile (o numero magico) è un numero formato dalle cifre "abcde..." che ha le seguenti proprietà:

La sua prima cifra "a" non è 0.
Il numero formato dalle sue prime due cifre "ab" è un multiplo di 2.
Il numero formato dalle prime tre cifre "abc" è un multiplo di 3.
Il numero formato dalle prime quattro cifre "abcd" è un multiplo di 4.
ecc.

(define (polydivisible? n)
  (local (s stop)
    (setq s (string n))
    (setq stop nil)
    (for (i 2 (length s) 1 stop)
      ;(println (slice s 0 i))
      (if (!= (% (int (slice s 0 i)) i) 0)
          (setq stop true)
      )
    )
    (not stop)))

(polydivisible? 345654)
;-> true

(filter (fn(x) (polydivisible? x)) (sequence 90000 92000))
;-> (90000 90005 90040 90045 90080 90085 90320 90325 90360 90365 
;->  90600 90605 90640 90645 90680 90685 90920 90925 90960 90965)

Possiamo anche scrivere una funzione che verifica se un numero è polidivisibile in una base positiva qualunqe. Dato un intero positivo N e K = (int log-b(n) 1) il numero di cifre di N in base b. Il numero N è un numero polidivisibile solo se, per 1 <= i <= k, risulta:

  int(n/b^(k-i)) = 0 (mod i)

La seguente funzione verifica se un numero (base 10) è polidivisbile:

(define (poly-div? n)
  (local (len stop)
    (setq len (length n))
    (setq stop nil)
    (for (i 2 len 1 stop)
      ;(println (slice s 0 i))
      (if (!= (% (int (div n (pow 10 (- len i)))) i) 0)
          (setq stop true)
      )
    )
    (not stop)))

(poly-div? 345654)
;-> true

(filter (fn(x) (poly-div? x)) (sequence 90000 92000))
;-> (90000 90005 90040 90045 90080 90085 90320 90325 90360 90365
;->  90600 90605 90640 90645 90680 90685 90920 90925 90960 90965)


---------------------
Algoritmo jump search
---------------------

Questo algoritmo itera su una lista ordinata con un passo di n^(1/2), finché l'elemento confrontato non è più grande di quello cercato. Quindi esegue una ricerca lineare finché non trova il numero cercato.
Se non viene trovato, restituisce nil.

(define (jump-search x lst)
  (local (m passo precedente)
    (setq m (length lst))
    (setq passo (int (floor (sqrt m))))
    (setq precedente 0)
    (while (< (lst (- (min passo m) 1)) x)
      (setq precedente passo)
      (setq passo (+ passo (int (floor (sqrt m)))))
      (if (>= precedente m) (throw nil))
    )
    (while (< (lst precedente) x)
      (++ precedente)
      (if (= precedente (min passo m)) (throw nil))
    )
    (if (= (lst precedente) x) precedente nil)))

(jump-search 101 (sequence 1 1000))
;-> 100

(jump-search 21 '(0 1 2 3 5 8 13 21 34 55))
;-> 7


--------------------------------
Numeri intoccabili (untouchable)
--------------------------------

Un numero intoccabile è un numero intero positivo che non può essere espresso come la somma di tutti i divisori propri di qualsiasi numero intero positivo (incluso il numero intoccabile stesso).
Ad esempio, il numero 4 non è intoccabile in quanto è uguale alla somma dei divisori propri di 9: 1 + 3 = 4. Il numero 5 è intoccabile in quanto non è la somma dei divisori propri di un qualsiasi intero positivo: 5 = 1 + 4 è l'unico modo per scrivere 5 come somma di interi positivi distinti incluso 1, ma se 4 divide un numero, lo fa anche 2, quindi 1 + 4 non può essere la somma di tutti i divisori propri di qualsiasi numero (poiché il l'elenco dei fattori dovrebbe contenere sia 4 che 2).

Nota: la somma di tutti i divisori propri è anche nota come "aliquot sum".

Sequenza OEIS A005114:
	2, 5, 52, 88, 96, 120, 124, 146, 162, 188, 206, 210, 216, 238, 246, 
	248, 262, 268, 276, 288, 290, 292, 304, 306, 322, 324, 326, 336, 342,
	372, 406, 408, 426, 430, 448, 472, 474, 498, ... 

(define (factor-group num)
"Factorize an integer number"
	(if (< num 2) nil
			(letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
			; usa "factor-i" per usare i big-integer
			;(letn ((out '()) (lst (factor-i num)) (cur-val (first lst)) (cur-count 0))
				(dolist (el lst)
					(if (= el cur-val) (++ cur-count)
							(begin
								(push (list cur-val cur-count) out -1)
								(setq cur-count 1 cur-val el))))
				(push (list cur-val cur-count) out -1))))

(define (divisors-sum num)
"Sum all the divisors of integer number"
(if (zero? num) 0
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
						(setq out (* out sum))))))))

(divisors-sum 11)
(divisors-sum 6)
;-> 12

(define (proper-divisors-sum num)
"Sum all the proper divisors of integer number"
  (- (divisors-sum num) num))

Funzione che verifica se un numero è intoccabile:

(define (untouchable? num)
  (let (stop nil)
    (for (i 2 (- (* num num) 1) 1 stop)
      (if (= (- (divisors-sum i) i) num)
          (setq stop true)
      )
    )
    (not stop)))

(filter (fn(x) (untouchable? x)) (sequence 1 100))
;-> (2 5 52 88 96)

Questa funzione è lenta per trovare tutti i numeri intoccabili fino ad un dato numero:

(time (setq un (filter (fn(x) (untouchable? x)) (sequence 1 500))))
;-> 18538.425
un
;-> (2 5 52 88 96 120 124 146 162 188 206 210 216 238 246 
;->  248 262 268 276 288 290 292 304 306 322 324 326 336 342 
;->  372 406 408 426 430 448 472 474 498)

(time (setq un (filter (fn(x) (untouchable? x)) (sequence 1 1000))))
;-> 162800.669
un
;-> (2 5 52 88 96 120 124 146 162 188 206 210 216 238 246 
;->  248 262 268 276 288 290 292 304 306 322 324 326 336 342
;->  372 406 408 426 430 448 472 474 498 516 518 520 530 540 
;->  552 556 562 576 584 612 624 626 628 658 668 670 708 714 
;->  718 726 732 738 748 750 756 766 768 782 784 792 802 804 
;->  818 836 848 852 872 892 894 896 898 902 926 934 936 964 
;->  966 976 982 996)

=============================================================================

