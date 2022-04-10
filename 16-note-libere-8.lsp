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

=============================================================================

