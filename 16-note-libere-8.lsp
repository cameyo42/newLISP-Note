===============

 NOTE LIBERE 8

===============

Un buon programmatore LISP cerca di utilizzare uno stile funzionale puro il più possibile usando funzioni con effetti-collaterali (side-effect) con parsimonia (il minimo indispensabile).

McCarthy (l'inventore originale di LISP) ha dimostrato che qualsiasi algoritmo/funzione può essere formulato completamente senza effetti collaterali solo con funzioni.

Comunque newLISP ha uno stile di programmazione proprio.

"Cavemen in bearskins invaded the ivory towers of Artificial Intelligence.
 Nine months later, they left with a baby named newLISP.
 The women of the ivory towers wept and wailed. 'Abomination!' they cried."
- TedWalther

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
Le formule di Lambert forniscono una precisione nell'ordine di 10 metri su migliaia di chilometri. Altri metodi possono fornire una precisione millimetrica, ma questo è un metodo più semplice da implementare.

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
            ; precisione del risultato 10e-9
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


---------------------------------
La funzione "append" e append-nil
---------------------------------

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


----------------------
La funzione "read-key"
----------------------

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
Per calcolare quanti soldi riceverò tra 10 anni con un tasso di interesse semplice non devo fare altro che calcolare il 5% dei 10000 euro del primo anno e poi moltiplicare questa cifra per i successivi 10 anni. Quindi, poichè il 5% di 10000 euro è 500 euro, basta moltiplicare 500 euro per 10 anni e ottenere così l'incremento di 5000 euro. Alla fine del decimo anno avremo 10000 + 5000 = 15000 euro.

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
Dopo il primo anno, come visto sopra, abbiamo 500 euro in più e un capitale di 10500 euro. Poichè l'investimento genera un interesse del 5% annuo, occorre calcolare il 5% sul nuovo montante di 10500 euro. Andando avanti in questo modo, dopo il secondo anno abbiamo un valore di 525 euro e il terzo anno abbiamo un montante pari a 11025 euro... dopo 10 anni avremo un capitale di 16288.95 euro, quindi quasi 1290 euro in più rispetto al caso dell'interesse semplice.

  C(n) = C0*(1 + t/k)^(k*n)

  C(n): Capitale dopo n anni
    C0: Capitale iniziale
     t: Tasso d'interesse
     n: Numero di anni
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

(longest-common-substring "123456789" "123564789")
;-> "123"

(longest-common-substring "123456789" "1236789")
;-> "6789"


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


-----------------------------------------
Lettura di righe o colonne di una matrice
-----------------------------------------

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
Modifica di righe o colonne di una matrice
------------------------------------------

Vediamo come possiamo modificare una riga o una colonna di una matrice:

(setq m '((1 2 3 4) (5 6 7 8) (9 10 11 12)))

(define (set-row matrix row lst)
  (setf (matrix row) lst)
  matrix)

(setq m (set-row m 2 '(0 0 0 0)))
;-> ((1 2 3 4) (5 6 7 8) (0 0 0 0))

(define (set-column matrix column lst)
  (let (t (transpose matrix))
    (setf (t column) lst)
    (transpose t)))

(setq m (set-column m 1 '(0 0 0)))
;-> ((1 0 3 4) (5 0 7 8) (0 0 0 0))


--------------------------------------------
La funzione "count" (per stringhe e vettori)
--------------------------------------------

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

Un altra funzione che lavora solo con le stringhe (by Cormullion):

(define (num-chars str)
    (count (args) (explode str)))

(setq s (dup "abcdefg" 5))
;-> "abcdefgabcdefgabcdefgabcdefgabcdefg"

(num-chars s "b" "g" "a" "x")
;-> (5 5 5 0)

(num-chars "aabbcabsdbcgabcbfbghsgbc" "a" "b" "c")
;-> (4 8 4)


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


-------------------------------------
Sequenza di Padovan e numero plastico
-------------------------------------

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

Modificando la versione iterativa possiamo ottenere tutta la sequenza di lunghezza n (inoltre utilizziamo i big-integer):

(define (padovan-seq n)
  (local (out)
    (cond ((= n 0) (setq out '(1L)))
          ((= n 1) (setq out '(1L 1L)))
          ((= n 2) (setq out '(1L 1L 1L)))
          (true
           (let ((pPrev2 1L) (pPrev 1L) (pCurr 1L) (pNext 1L))
            (setq out '(1L 1L 1L))
            (for (i 3 n)
              (setq pNext (+ pPrev2 pPrev))
              (setq pPrev2 pPrev)
              (setq pPrev pCurr)
              (setq pCurr pNext)
              (push pNext out -1))))
    )
    out))

(padovan-seq 19)
;-> (1L 1L 1L 2L 2L 3L 4L 5L 7L 9L 12L 16L 21L 28L 37L 49L 65L 86L 114L 151L)

Il numero plastico ha lo stesso legame che il numero aureo ha con la sequenza di Fibonacci: i rapporti di due numeri Padovan adiacenti danno un'approssimazione del numero plastico.
Il valore del numero plastico è circa 1.324718.

Vediamo come calcolarli:

(silent
  (setq pado (padovan-seq 1000))
  (setq plastici (map div (rest pado) (chop pado))))
  
(plastici 10)
;-> 1.333333333333333
(plastici 100)
;-> 1.324717957244746
(plastici 999)
;-> 1.324717957244746)


------------------------------------
Fattorione (numero di krishnamurthy)
------------------------------------

Un numero fattorione (o numero di krishnamurthy) è un numero che è uguale alla somma dei fattoriali di ogni sua cifra, cioè un numero è un fattorione se risulta:

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


-----------------------------
Numeri magici (magic numbers)
-----------------------------

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


-------------------------------------
Numeri polidivisibili (numeri magici)
-------------------------------------

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
      (if (!= (% (int (slice s 0 i) 0 10) i) 0)
          (setq stop true)
      )
    )
    (not stop)))

(polydivisible? 345654)
;-> true

(filter (fn(x) (polydivisible? x)) (sequence 90000 92000))
;-> (90000 90005 90040 90045 90080 90085 90320 90325 90360 90365
;->  90600 90605 90640 90645 90680 90685 90920 90925 90960 90965)

Possiamo anche scrivere una funzione che verifica se un numero è polidivisibile in una base positiva qualunque. Dato un intero positivo N e K = (int log-b(n) 1) il numero di cifre di N in base b. Il numero N è un numero polidivisibile solo se, per 1 <= i <= k, risulta:

  int(n/b^(k-i)) = 0 (mod i)

La seguente funzione verifica se un numero (base 10) è polidivisibile:

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

Vediamo i tempi di esecuzione delle due funzioni:

(time (polydivisible? 345654) 100000)
;-> 197.537

(time (poly-div? 345654) 100000)
;-> 150.697

Sequenza OEIS: A144688
"Magic" numbers: all numbers from 0 to 9 are magic.
A number >= 10 is magic if it is divisible by the number of its digits and the number obtained by deleting the final digit is also magic.
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28,
  30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64,
  66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 102,
  105, 108, 120, 123, 126, 129, 141, 144, 147, 162, 165, 168, 180, ...

(filter (fn(x) (poly-div? x)) (sequence 0 200))
;-> (0 1 2 3 4 5 6 7 8 9 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
;->  40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82
;->  84 86 88 90 92 94 96 98 102 105 108 120 123 126 129 141 144 147 162
;->  165 168 180 183 186 189)

Per ogni base b, esiste solo un numero finito di numeri polidivisibili.
In base 10 il massimo numero polidivisibile è 3.608.528.850.368.400.786.036.725.

Verifichiamolo:

(define (string-int str)
"Convert a numeric string to big-integer"
  (let (num 0L)
    (cond ((= (str 0) "-")
            (pop str)
            (dolist (el (explode str)) (setq num (+ (* num 10) (int el))))
            (* num -1))
          (true
            (dolist (el (explode str)) (setq num (+ (* num 10) (int el))))))))

(define (polidivisibile? n)
  (local (s stop)
    (setq s (string n))
    (setq stop nil)
    (for (i 2 (- (length s) 1) 1 stop)
        ;(print (slice s 0 i))
        (if (!= (% (string-int (slice s 0 i)) i) 0)
            (setq stop true)
        )
    )
    (not stop)))

(polidivisibile? 3608528850368400786036725L)
;-> true


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

(proper-divisors-sum 6)
;-> 6

Funzione che verifica se un numero è intoccabile:

(define (untouchable? num)
  (let (stop nil)
    ; occorre sommare i divisori propri
    ; per ogni numero fino a (num^2 - 1)
    (for (i 2 (- (* num num) 1) 1 stop)
      (if (= (proper-divisors-sum i) num)
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

Scriviamo in modo diverso la funzione che calcola i numeri intoccabili fino ad un dato numero:

(define (untouchable-to num)
  (local (numbers limits sums)
    ; numeri di cui calcolare la somma dei divisori propri
    (setq limits (sequence 2 (* num num)))
    ; somma dei divisori propri di tutti i numeri
    (setq sums (unique (map proper-divisors-sum limits)))
    ; numeri da verificare
    (setq numbers (sequence 2 num))
    (difference numbers sums)))

(untouchable-to 100)
;-> (2 5 52 88 96)

(untouchable-to 1000)
;-> (2 5 52 88 96 120 124 146 162 188 206 210 216 238 246
;->  248 262 268 276 288 290 292 304 306 322 324 326 336 342
;->  372 406 408 426 430 448 472 474 498 516 518 520 530 540
;->  552 556 562 576 584 612 624 626 628 658 668 670 708 714
;->  718 726 732 738 748 750 756 766 768 782 784 792 802 804
;->  818 836 848 852 872 892 894 896 898 902 926 934 936 964
;->  966 976 982 996)

(time (untouchable-to 1000))
;-> 3956.685

La funzione è più veloce, ma è ancora troppo lenta per calcolare numeri intoccabili grandi:

(time (println (untouchable-to 10000)))
;-> 846273.96


---------------------
Powerset di una lista
---------------------

Il powerset di una lista è l'insieme di tutte le sottoliste della lista.
Per esempio:

  lista = (a b c)
  powerset = (() (a) (b) (a b) (c) (a c) (b c) (a b c))

Il numero di elementi del powerset vale:

  numero elementi powerset = 2^(numero elementi lista)

Nota: la lista vuota () appartiene sempre al powerset di qualunque lista.

Vediamo diversi funzioni per calcolare il powerset di una lista (o vettore).

Metodo 1 (iterativo)
--------------------

(define (powerset1 lst)
  (define (loop res s)
    (if (empty? s)
      res
      (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s))))
  (loop '(()) lst))

(powerset1 '(1 2 3))
;-> ((3 2 1) (3 2) (3 1) (3) (2 1) (2) (1) ())

Metodo 2 (ricorsivo)
--------------------

(define (powerset2 lst)
  (if (empty? lst)
      (list '())
      (let ((element (first lst))
            (p (powerset2 (rest lst))))
        (append (map (fn (subset) (cons element subset)) p) p) )))

(powerset2 '(1 2 3))
;-> ((1 2 3) (1 2) (1 3) (1) (2 3) (2) (3) ())

Metodo 3 (iterativo)
--------------------
Ci sono in totale 2^n sottoliste. Usiamo un ciclo da 0 a 2^n – 1 e, per ogni numero, scegliamo tutti gli elementi della lista che corrispondono a 1 nella rappresentazione binaria del numero corrente.

(define (powerset3 lst)
  (local (out len limit counter tmp)
    (setq out '())
    (setq len (length lst))
    ; numero elementi del powerset
    (setq limit (- (pow 2 len) 1))
    ; ciclo da 0 a (len - 1) (da 000..0 a 111..1)
    (for (i 0 limit)
      ; sottolista corrente vuota
      (setq tmp '())
      (for (j 0 (- len 1))
        ; se il j-esimo bit del contatore (i) è impostato,
        ; allora il j-esimo elemento della lista viene
        ; inserito nella sottolista corrente
        (if (> (& i (<< 1 j)) 0)
            (push (lst j) tmp -1)
        )
      )
      ; inserisce la sottolista corrente nella soluzione
      (push tmp out -1)
    )
    out))

(powerset3 '(1 2 3))
;-> (() (1) (2) (1 2) (3) (1 3) (2 3) (1 2 3))

Come funziona?
lista  = (1 2 3)
numero elementi del powerset = pow(2, 3) = 8
Ciclo da 0 a 7 (da 000 a 111 in binario):

Contatore (i)     Sottolista
   000        -->    ()
   001        -->    1
   010        -->    2
   011        -->    12
   100        -->    3
   101        -->    13
   110        -->    23
   111        -->    123

Metodo 4 (iterativo)
--------------------
Questa funzione prende come parametro il numero di elementi e genera il powerset della lista (0..n-1). Ad esempio se il numero vale 3, allora la funzione calcola il powerset della lista (0 1 2).

(define (powerset4 num)
  (local (out conta buf ind n_1 stop tmp)
    (cond ((zero? num) (setq out '(())))
          (true
            (setq out '(()))
            (setq conta 0) ; number of total permutations
            (setq buf (array num '(0)))
            (setq ind 0)
            (setq n_1 (- num 1))
            (setq stop nil)
            (until stop
              (setq tmp '())
              ;(for (i 0 ind) (print (buf i) { })) (println)
              (for (i 0 ind) (push (buf i) tmp -1))
              (push tmp out -1)
              (++ conta)
              (cond ((< (buf ind) n_1)
                      (++ ind)
                      (setf (buf ind) (+ (buf (- ind 1)) 1)))
                    ((> ind 0)
                      (-- ind)
                      (setf (buf ind) (+ (buf ind) 1)))
                    (true
                      (setq stop true))
              )
            )
          )
    )
    out))

(powerset4 3)
;-> (() (0) (0 1) (0 1 2) (0 2) (1) (1 2) (2))

Vediamo la velocità delle funzioni:

(setq lst (randomize (sequence 1 10)))
(time (powerset1 lst) 100)
;-> 46.849

(time (powerset2 lst) 100)
;-> 39.895

(time (powerset3 lst) 100)
;-> 149.604

(time (powerset4 10) 100)
;-> 58.039

(time (powerset1 (sequence 1 20)))
;-> 905.264
(time (powerset2 (sequence 1 20)))
;-> 631.173
(time (powerset3 (sequence 1 20)))
;-> 2775.072
(time (powerset4 20))
;-> 1087.91

Ottimizziamo un pò la funzione "powerset4":

(define (powerset5 num)
  (local (out conta buf ind n_1 stop tmp)
    (cond ((> num 0)
            (setq out '(()))
            (setq buf (array num '(0)))
            (setq ind 0)
            (setq n_1 (- num 1))
            (setq stop nil)
            (until stop
              (setq tmp '())
              (for (i 0 ind) (push (buf i) tmp))
              (push tmp out)
              (cond ((< (buf ind) n_1)
                      (++ ind)
                      (setf (buf ind) (+ (buf (- ind 1)) 1)))
                    ((> ind 0)
                      (-- ind)
                      (++ (buf ind)))
                    (true
                      (setq stop true))
              )
            )
          )
          (true (setq out '(())))
    )
    out))

(powerset5 3)
;-> ((2) (2 1) (1) (2 0) (2 1 0) (1 0) (0) ())

(time (powerset5 10) 100)
;-> 44.373

(time (powerset5 20))
;-> 966.032


-----------------------------------
Somme dei sottoinsiemi di una lista
-----------------------------------

Data una lista con numeri interi, creare una funzione che restituisce una lista con le somme di ogni sottoinsieme della lista data.

Metodo 1 (powerset)
-------------------

(define (powerset-i lst)
  (define (loop res s)
    (if (empty? s)
      res
      (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s))))
  (loop '(()) lst))

(define (subset-sums1 lst)
  ; generiamo il powerset e calcoliamo la somma di ogni sottoinsieme
  (map (fn(x) (apply + x)) (powerset-i lst)))

Il valore 0 nella soluzione è dovuto alla lista vuota (cioè quando scegliamo 0 elementi).

(subset-sums1 '(1 2 -3))
;-> (-3 -2 -1 0 1 2 3)

(define (subset-sums1a lst)
  (let (sums '())
    ; generiamo il powerset e calcoliamo la somma di ogni sottoinsieme
    (dolist (el (powerset-i lst))
      (push (apply + el) sums -1)
    )
    sums))

(subset-sums1a '(1 2 -3))
;-> (-3 -2 -1 0 1 2 3)

Metodo 2 (ricorsivo)
--------------------

(define (subset-sums-ex lst left right sum)
  (cond ((> left right)
         ; aggiunge il subset corrente
         (push sum out -1 { })
        )
        (true
         ; subset includendo lst[left]
         (subset-sums-ex lst (+ left 1) right (+ sum (lst left)))
         ; subset escludendo lst[left]
         (subset-sums-ex lst (+ left 1) right sum)
        )
  ))

(define (subset-sums2 lst)
  (local (out len)
    (setq out '())
    (setq len (length lst))
    (subset-sums-ex lst 0 (- len 1) 0)
    out))

(subset-sums2 '(1 2 -3))
;-> (-3 -2 -1 0 1 2 3)

Metodo 3 (iterativo)
--------------------

(define (subset-sums3 lst)
  (local (limit sum len out)
    (setq out '())
    (setq len (length lst))
    ; numero di subset
    (setq limit (<< 1 len))
    ;(setq limit (pow 2 len))
    (for (i 0 (- limit 1))
      (setq sum 0)
      (for (j 0 (- len 1))
        ; usa la rappresentazione binaria di "i"
        ; per decidere quali elementi prendere.
        (if (!= (& i (<< 1 j)))
            (setq sum (+ sum (lst j)))
        )
      )
      ; aggiunge la somma degli elementi selezionati
      (push sum out -1)
    )
    out))

(subset-sums3 '(1 2 -3))
;-> (-3 -2 -1 0 1 2 3)

Vediamo la velocità delle funzioni:

(setq a (randomize (sequence 1 15)))
(time (subset-sums1 a))
;-> 28.703
(time (subset-sums1a a))
;-> 27.701
(time (subset-sums2 a))
;-> 20717.199 ;(esponenziale)
(time (subset-sums3 a))
;-> 59.883

Con prove ripetute le funzioni 1 e 1a presentano il problema dell'aumento dei tempi di esecuzione delle chiamate successive:

(time (subset-sums1 a) 10)
;-> 497.343
(time (subset-sums1 a) 10)
;-> 902.555
(time (subset-sums1 a) 10)
;-> 1105.575

(time (subset-sums1a a) 10)
;-> 339.182
(time (subset-sums1a a) 10)
;-> 621.336
(time (subset-sums1a a) 10)
;-> 979.784

Verifichiamo se questo problema è dipende dalla funzione "powerset-i" (con una REPL nuova):

(define (powerset-i lst)
  (define (loop res s)
    (if (empty? s)
      res
      (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s))))
  (loop '(()) lst))

(setq a (randomize (sequence 1 15)))
(time (powerset-i a) 10)
;-> 168.325
(time (powerset-i a) 10)
;-> 216.182
(time (powerset-i a) 10)
;-> 309.941

Quindi la funzione "powerset-i" è la responsabile del problema.

Invece la funzione 3 non presenta il problema dell'aumento dei tempi:

(time (subset-sums3 a) 10)
;-> 669.222
(time (subset-sums3 a) 10)
;-> 684.093
(time (subset-sums3 a) 10)
;-> 667.093

Scriviamo la funzione che calcola il powerset in un altro modo:

(define (power-set lst)
  (local (out len limit counter tmp)
    (setq out '())
    (setq len (length lst))
    ; numero elementi del powerset
    (setq limit (- (pow 2 len) 1))
    ; ciclo da 0 a (len - 1) (da 000..0 a 111..1)
    (for (i 0 limit)
      ; sottolista corrente vuota
      (setq tmp '())
      (for (j 0 (- len 1))
        ; se il j-esimo bit del contatore (i) è impostato,
        ; allora il j-esimo elemento della lista viene
        ; inserito nella sottolista corrente
        (if (> (& i (<< 1 j)) 0)
            (push (lst j) tmp -1)
        )
      )
      ; inserisce la sottolista corrente nella soluzione
      (push tmp out -1)
    )
    out))

(power-set '(1 2 3))
;-> (() (1) (2) (1 2) (3) (1 3) (2 3) (1 2 3))

Come funziona?
lista  = (1 2 3)
numero elementi del powerset = pow(2, 3) = 8
Ciclo da 0 a 7 (da 000 a 111 in binario):

Contatore (i)     Sottolista
   000        -->    ()
   001        -->    1
   010        -->    2
   011        -->    12
   100        -->    3
   101        -->    13
   110        -->    23
   111        -->    123

Verifichiamo la funzione:

(setq a (randomize (sequence 1 15)))
(time (power-set a) 10)
;-> 669.192
(time (power-set a) 10)
;-> 684.761
(time (power-set a) 10)
;-> 684.764

Questa funzione non presenta il problema dei tempi, ma è più lenta.

Proviamo con un'altra funzione che calcola il powerset:

(define (power-set2 lst)
  (if (empty? lst)
      (list '())
      (let ((element (first lst))
            (p (power-set2 (rest lst))))
        (append (map (fn (subset) (cons element subset)) p) p) )))

Verifichiamo la funzione:

(time (power-set2 a) 10)
;-> 122.462
(time (power-set2 a) 10)
;-> 169.374
(time (power-set2 a) 10)
;-> 231.811

Anche questa funzione presenta il problema dei tempi.


-------------------------------------------
Somma dei sottoinsiemi (Subset Sum Problem)
-------------------------------------------

Il problema della somma dei sottoinsiemi (SSP, SubSet Problem) è un problema decisionale in cui viene dato insieme S di interi non negativi e una somma obiettivo T: la questione è decidere se un qualsiasi sottoinsieme degli interi di S somma esattamente a T. Il problema SSP è noto per essere NP-completo ed è un caso speciale del problema dello zaino (knapsack).

Scrivere una funzione che prende una lista "lst" e un valore di somma "sum" e restituisce true se esiste un qualunque sottoinsieme della lista i cui elementi hanno somma uguale a "sum" (altrimenti restituisce nil).

Soluzione naive
---------------

(define (subset-sum-ex lst len sum)
  (local (in out)
          ; restiture true se la somma diventa 0 (sottoinsieme trovato)
    (cond ((= sum 0) true)
          ; caso base: se nessun elemento rimasto o la somma diventa negativa,
          ; allora restituire nil
          ((or (< len 0) (< sum 0)) nil)
          (true
            ; Caso 1. Includere l'elemento corrente lst(n) nel sottoinsieme e
            ; ripetere per gli (len-1) elementi rimanenti
            ; con il totale rimanente (sum - lst[len])
            (setq in  (subset-sum-ex lst (- len 1) (- sum (lst len))))
            ; Caso 2. Escludere l'elemento corrente lst[len] dal sottoinsieme e
            ; ricorrere per i (len - 1) elementi rimanenti
            (setq out (subset-sum-ex lst (- len 1) sum))
            ; Restituire true se possiamo ottenere un sottoinsieme
            ; includendo o escludendo l'elemento corrente
            (or in out)))))

(define (subset-sum lst sum)
  (let (len (- (length lst) 1))
    (subset-sum-ex lst len sum)))

(subset-sum '(3 11 4 22 1 1) 9)
;-> true
(subset-sum '(1 0 2 12 11 3 2 6 9) 7)
;-> true
(subset-sum '(1 4 1 1) 4)
;-> true
(subset-sum '(4 5 10 6 9) 7)
;-> nil

Prima soluzione con programmazione dinamica
-------------------------------------------

(define (subset-sum1 lst sum)
  (local (len dp)
    (setq len (length lst))
    ; Il valore di dp[i][j] vale
    ; true se esiste un sottoinsieme di
    ; lst[0..j-1] con somma pari a i
    (setq dp (array (+ sum 1) (+ len 1) '(nil)))
    ; Se la somma è 0, allora restituisce true
    (for (i 0 len)
      (setf (dp 0 i) true))
    ; Se sum non è 0 e lst è vuota, allora restituisce nil
    (for (i 1 sum)
      (setf (dp i 0) nil))
    ; Riempie la matrice dp in modo bottom-up (dal basso verso l'alto)
    (for (i 1 sum)
      (for (j 1 len)
        (setf (dp i j) (dp i (- j 1)))
        (if (>= i (lst (- j 1)))
            (setf (dp i j) (or (dp i j) (dp (- i (lst (- j 1))) (- j 1))))
        )
      )
    )
    ;(println dp)
    (dp sum len)))

(subset-sum1 '(3 11 4 22 1 1) 9)
;-> true
(subset-sum1 '(1 0 2 12 11 3 2 6 9) 7)
;-> true
(subset-sum1 '(1 4 1 1) 4)
;-> true
(subset-sum1 '(4 5 10 6 9) 7)
;-> nil

Seconda soluzione con programmazione dinamica
---------------------------------------------

(define (subset-sum2 lst sum)
  (local (dp j)
    (setq dp (array (+ sum 1) '(nil)))
    ; l'inizializzazione con 1 perchè somma 0 è sempre possibile
    (setf (dp 0) true)
    ; ciclo per ogni elemento della lista
    (dolist (el lst)
      ; per modificare il valore di tutti i possibili valori di somma in True
      (setq j sum)
      (while (> j (- el 1))
        (if (dp (- j el)) (setf (dp j) true))
        (-- j)
      )
    )
    (dp sum)))

(subset-sum2 '(3 11 4 22 1 1) 9)
;-> true
(subset-sum2 '(1 0 2 12 11 3 2 6 9) 7)
;-> true
(subset-sum2 '(1 4 1 1) 4)
;-> true
(subset-sum2 '(4 5 10 6 9) 7)
;-> nil

Vediamo la velocità delle funzioni:

(setq nums (randomize (sequence 1 100)))
(time (subset-sum nums 25) 1000)
;-> 36060.684
(time (subset-sum1 nums 25) 1000)
;-> 553.523
(time (subset-sum2 nums 25) 1000)
;-> 56.875

Per calcolare i sottoinsiemi possiamo utilizzare la seguente funzione:

(define (subset-sum-all lst sum)
  (local (limit val len out)
    (setq out '())
    (setq len (length lst))
    ; numero di subset
    (setq limit (<< 1 len))
    ;(setq limit (pow 2 len))
    (for (i 0 (- limit 1))
      (setq val 0)
      (setq tmp '())
      (setq stop nil)
      (for (j 0 (- len 1) 1 stop)
        ; usa la rappresentazione binaria di "i"
        ; per decidere quali elementi prendere.
        (if (!= (& i (<< 1 j)))
          (begin
            (push (lst j) tmp -1)
            (setq val (+ val (lst j)))
            ; stop se somma del sottoinsieme corrente
            ; supera il valore sum
            (if (> val sum) (setq stop true))
          )
        )
      )
      (if (= val sum)
        ; aggiunge un sottosieme che somma a sum
        (push tmp out -1)
      )
    )
    out))

(subset-sum-all '(1 2 3 4 5) 10)
;-> ((1 2 3 4) (2 3 5) (1 4 5))

(subset-sum-all (sequence 1 10) 10)
;-> ((1 2 3 4) (2 3 5) (1 4 5) (1 3 6) (4 6) (1 2 7) (3 7) (2 8) (1 9) (10))


--------------
Numeri pratici
--------------

Un numero pratico (practical number) è un numero intero positivo n tale che tutti i numeri interi positivi più piccoli possono essere rappresentati come somme di divisori distinti di n. Ad esempio, 12 è un numero pratico perché tutti i numeri da 1 a 11 possono essere espressi come somme dei suoi divisori 1, 2, 3, 4 e 6: oltre a questi divisori stessi, abbiamo 5 = 3 + 2, 7 = 6 + 1, 8 = 6 + 2, 9 = 6 + 3, 10 = 6 + 3 + 1 e 11 = 6 + 3 + 2.

Sequenza OEIS A005153:
  1, 2, 4, 6, 8, 12, 16, 18, 20, 24, 28, 30, 32, 36, 40, 42, 48, 54,
  56, 60, 64, 66, 72, 78, 80, 84, 88, 90, 96, 100, 104, 108, 112, 120,
  126, 128, 132, 140, 144, 150 ...

Funzione che verifica se una sottolista di una lista (lst) somma a un valore predefinito (sum):

(define (subset-sum lst sum)
  (local (dp j)
    (setq dp (array (+ sum 1) '(nil)))
    (setf (dp 0) true)
    (dolist (el lst)
      (setq j sum)
      (while (> j (- el 1))
        (if (dp (- j el)) (setf (dp j) true))
        (-- j)
      )
    )
    (dp sum)))

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

(define (divisors num)
"Generate all the divisors of an integer number"
  (local (f out)
    (cond ((= num 1) '(1))
          (true
           (setq f (factor-group num))
           (setq out '())
           (divisors-aux 0 1)
           (sort out)))))
; funzione ausiliaria
(define (divisors-aux cur-index cur-divisor)
  (cond ((= cur-index (length f))
         (push cur-divisor out -1)
        )
        (true
         (for (i 0 (f cur-index 1))
           (divisors-aux (+ cur-index 1) cur-divisor)
           (setq cur-divisor (* cur-divisor (f cur-index 0)))
         ))))

Funzione che verifica se un numero è pratico:

(define (practical? num)
  (local (divs stop)
    (setq divs (divisors num))
    (setq stop nil)
    (for (i 1 (- num 1) 1 stop)
      (if (not (subset-sum divs i))
          (setq stop true)
      )
    )
    (not stop)))

(practical? 12)
;-> true

(practical? 666)
;-> true

Calcoliamo i numeri pratici fino a 150:

(filter (fn(x) (practical? x)) (sequence 1 150))
;-> (1 2 4 6 8 12 16 18 20 24 28 30 32 36 40 42 48 54
;->  56 60 64 66 72 78 80 84 88 90 96 100 104 108 112 120
;->  126 128 132 140 144 150)

Questo metodo è lento per calcolare molti numeri pratici:

(time (filter (fn(x) (practical? x)) (sequence 1 500)))
;-> 5615.946
(time (filter (fn(x) (practical? x)) (sequence 1 1000)))
;-> 48990.197


-----------------------------------
Creare file di testo Windows e Unix
-----------------------------------

I file di testo di Windows e Unix hanno il terminatore di linea diverso:

  in Windows -> CRLF \r\n
  in Unix    -> CR \r

  dove il carattere \n -> LF (Line Feed)
     e il carattere \r -> CR (Carriage Return)

Per creare file del tipo voluto possiamo utilizzare due funzioni (o due macro):

(define-macro (println-unix)
    (apply print (map eval (args)))
    (print "\n"))

(define (println-ux)
    (apply print (args))
    (print "\n"))

(define-macro (println-windows)
    (apply print (map eval (args)))
    (print "\r\n"))

(define (println-win)
    (apply print (args))
    (print "\r\n"))

(println-win "demo " "windows")
;-> demo windows
;-> "\n\r"

(println-windows "demo " "windows")
;-> demo windows
;-> "\n\r"

(println-unix "demo " "unix")
;-> demo unix
;-> "\n"

(println-ux "demo " "unix")
;-> demo unix
;-> "\n\r"

Creiamo un file di testo windows (\r\n):

(device (open "win.txt" "write"))
(println-windows "prova " "windows")
(println-win "prova " "windows")
(close (device))

Adesso il file "win.txt" ha il terminatore di linea di tipo windows (\r\n)

Creiamo un file di testo unix (\r):

(device (open "unix.txt" "write"))
(println-unix "prova " "unix")
(println-ux "prova " "unix")
(close (device))

Adesso il file "unix.txt" ha il terminatore di linea di tipo unix (\r).
Con notepad++ possiamo verificarlo tramite il menu View -> Show Symbol -> Show All Characters e convertire tra i due tipi con il menu Edit -> EOL Conversion.


---------------------
Radicale di un numero
---------------------

Il radicale di un numero intero positivo è il prodotto dei distinti fattori primi del numero.

(define (radical num)
  (if (= num 1) 1
      (apply * (unique (factor num)))))

(map radical (sequence 1 100))
;-> (1 2 3 2 5 6 7 2 3 10 11 6 13 14 15 2 17 6 19 10 21 22 23 6 5 26 3 14
;->  29 30 31 2 33 34 35 6 37 38 39 10 41 42 43 22 15 46 47 6 7 10 51 26
;->  53 6 55 14 57 58 59 30 61 62 21 2 65 66 67 34 69 70 71 6 73 74 15 38
;->  77 78 79 10 3 82 83 42 85 86 87 22 89 30 91 46 93 94 95 6 97 14 33 10)


-----------------------
Fattoriale e funzione Y
-----------------------

(let ((g (lambda (h)
         (expand (lambda (n)
           (let ((f (lambda (f n)
                   (if (< n 2) 1 (* n (f (- n 1)))))))
           (f (h h) n))) 'h))))
      ((g g) 10))
;-> 3628800


---------------------
La funzione "explode"
---------------------

********************
>>>funzione EXPLODE
********************
sintassi: (explode str [int-chunk [bool]])
sintassi: (explode list [int-chunk [bool]])

Nella prima sintassi, explode trasforma la stringa (str) in un elenco di stringhe a un carattere. Facoltativamente, è possibile specificare una dimensione del blocco in int-chunk per suddividere la stringa in blocchi di più caratteri. Quando si specifica un valore per bool diverso da nil, l'ultimo blocco verrà omesso se non ha la lunghezza completa specificata in int-chunk.

(explode "newLISP")  → ("n" "e" "w" "L" "I" "S" "P")

(join (explode "keep it together"))  → "keep it together"

(explode "newLISP" 2)    → ("ne" "wL" "IS" "P")

(explode "newLISP" 3)    → ("new" "LIS" "P")

; omit last chunk if too short
(explode "newLISP" 3 true)    → ("new" "LIS")

Solo su versioni non abilitate per UTF8, explode funziona anche su contenuto binario:

(explode "\000\001\002\003")   → ("\000" "\001" "\002" "\003")

Quando viene chiamato nelle versioni abilitate per UTF-8 di newLISP, explode funzionerà sui limiti dei caratteri anziché sui limiti dei byte. Nelle stringhe con codifica UTF-8, i caratteri possono contenere più di un byte. L'elaborazione si interromperà quando viene trovato un carattere di zero byte.

Per esplodere i contenuti binari nelle versioni abilitate per UTF-8 di newLISP, utilizzare unpack come mostrato nell'esempio seguente:

(set 'str "\001\002\003\004") → "\001\002\003\004"

(unpack (dup "c" (length str)) str) → (1 2 3 4)
(unpack (dup "s" (length str)) str) → ("\001" "\002" "\003" "\004")

Nella seconda sintassi, explode esplode una lista in sottoliste di dimensione del blocco int-chunk, che è 1 (uno) per impostazione predefinita.

Di seguito viene mostrato un esempio dell'ultimo blocco che viene omesso quando il valore per bool è diverso da nil e il blocco non ha la lunghezza completa specificata in int-chunk.

(explode '(a b c d e f g h))    → ((a) (b) (c) (d) (e) (f) (g) (h))
(explode '(a b c d e f g) 2)  → ((a b) (c d) (e f) (g))

; omit last chunk if too short
(explode '(a b c d e f g) 2 true)  → ((a b) (c d) (e f))

(transpose (explode '(a b c d e f g h) 2))
→ ((a c e g) (b d f h))

Le funzioni join e append sono operazioni inverse di explode.

Vediamo una funzione che estende le funzionalità di "explode":

;; group by nigel brown
;; This function performs a multiple slice on a given list
;; One supplies a list and an integer n. The list is broken into a list of sublists of
;; length n. If n is negative the list items are collected going from the end of the list
;; to the beginning. If the optional bool argument is supplied then remaining elements are
;; included in the result.
;; (group '(1 2 3 4 5 6 7) 3)       -> ((1 2 3)(4 5 6))
;; (group '(1 2 3 4 5 6 7) 3 true)  -> ((1 2 3)(4 5 6)(7))
;; (group '(1 2 3 4 5 6 7) -3 true) -> ((1)(2 3 4)(5 6 7))

(define (group lst n bool , len num rep rem start)
  (setq num (abs n))
  (if (< n 0)
      (reverse (map reverse (group (reverse lst) num bool)))
      (= n 0)
      nil
      (begin
        (setq len   (length lst)
              rep   (/ len num)
              rem   (% len num)
              start '()
        )
        (if (< num len)
            (begin
              (dotimes (x rep)
                (setq start (cons (slice lst (* x num) num) start)))
              (if (and bool (> rem 0))
                  (setq start (cons (slice lst (* num rep) rem) start)))
              (reverse start))
            (list lst)))))

(group '(1 2 3 4 5 6 7) 3)
;-> ((1 2 3) (4 5 6))
(group '(1 2 3 4 5 6 7) 3 true)
;-> ((1 2 3) (4 5 6) (7))
(group '(1 2 3 4 5 6 7) -3)
;-> ((2 3 4) (5 6 7))
(group '(1 2 3 4 5 6 7) -3 true)
;-> ((1) (2 3 4) (5 6 7))

Possiamo utilizzare explode per ottenere un risultato equivalente con una funzione più veloce:

(define (explodes lst num bool)
  (let (nn (abs num))
    (if (< num 0)
        (map reverse (reverse (explode (reverse lst) nn bool)))
        (explode lst nn bool))))

(setq lst '(1 2 3 4 5 6 7))
(explodes lst 3)
;-> ((1 2 3) (4 5 6) (7))
(explodes lst 3 true)
;-> ((1 2 3) (4 5 6))
(explodes lst -3 true)
;-> ((2 3 4) (5 6 7))
(explodes lst -3)
;-> ((1) (2 3 4) (5 6 7))

Vediamo i tempi di esecuzione:

(setq seq (sequence 1 10000))
(time (group seq -7 true) 10)
;-> 2109.563
(time (explodes seq -7) 10)
;-> 6.954

(= (group seq -7 true) (explodes seq -7))
;-> true

(time (group seq -7 ) 10)
;-> 2101.172
(time (explodes seq -7 true) 10)
;-> 7.951

Adesso vediamo una funzione che simula "explode":

(define (my-exp llst number)
  (if (empty? llst)
      '()
      (cons (0 number llst) (my-exp (number llst) number))))

(my-exp '(0 1 2 3 4 5 6 7 8 9) 3)
;-> ((0 1 2) (3 4 5) (6 7 8) (9))

Infine vediamo come "esplodere" le stringhe UTF-8:

(setq str "αεμπστφ")
;-> "αεµπστφ"
(explode str 2)
;-> ("αεµπστ" "φ\000àí") ???

(unpack (dup "c" (length str)) str)
;-> (-32 -18 -26 -29 -27 -25 -19)
(unpack (dup "s" (length str)) str)
;-> ("α" "ε" "µ" "π" "σ" "τ" "φ")


--------------------
Formula di Faulhaber
--------------------

La formula di Faulhaber rappresenta la somma delle p-esime potenze dei primi n numeri positivi.

   n
   ∑ (k^p) = 1^p + 2^p + 3^p + ... n^p
  k=1

(define (faulhaber p n)
  (let (out 0)
    (for (i 1 n)
      (setq out (+ out (pow i p)))
    )
    out))

Calcoliamo il numero per p=2 e n=1..20 (numeri piramidali quadrati):

(map (curry faulhaber 2) (sequence 1 20))
;-> (1 5 14 30 55 91 140 204 285 385 506 650
;->  819 1015 1240 1496 1785 2109 2470 2870)

Calcoliamo il numero per p=3 e n=1..20 (numeri piramidali quadrati):

(map (curry faulhaber 3) (sequence 1 20))
;-> (1 9 36 100 225 441 784 1296 2025 3025 4356 6084
;->  8281 11025 14400 18496 23409 29241 36100 44100)


--------------------------
Numeri piramidali quadrati
--------------------------

Un numero piramidale quadrato è un numero che rappresenta una piramide a base quadrata. L'n-esimo numero di questo tipo è quindi la somma dei quadrati dei primi n numeri naturali, che può essere espressa in formula come

   n          n*(n + 1)*(2*n + 1)     2*n^3 + 3*n^2 + n
   ∑ (k^2) = --------------------- = -------------------
  k=1                 2                      6

Questa formula è un caso particolare della formula di Faulhaber e restituisce sempre un numero intero, infatti:
  - n e n+1 sono due numeri consecutivi, quindi uno dei due è pari;
  - uno tra n, n+1 e 2n+1 è multiplo di 3 (rispettivamente se n=3k, n=3k+2, n=3k+1);
  - il numeratore è allora un multiplo di 6 e si semplifica quindi con il denominatore.

I primi numeri piramidali quadrati sono:

Sequenza OEIS

  0, 1, 5, 14, 30, 55, 91, 140, 204, 285, 385, 506, 650, 819, 1015,
  1240, 1496, 1785, 2109, 2470, 2870, 3311, 3795, 4324, 4900, 5525,
  6201, 6930, 7714, 8555, 9455, 10416, 11440, 12529, 13685, 14910,
  16206, 17575, 19019, 20540, 22140, 23821, 25585, 27434, 29370, ...

Questi numeri possono essere rappresentati nello spazio fisico attraverso una piramide di sfere la cui base ha lato n.

(define (pyramid-quad n)
  (/ (+ (* 2 n n n) (* 3 n n) n) 6))

(map pyramid-quad (sequence 0 30))
;-> (0 1 5 14 30 55 91 140 204 285 385 506 650 819 1015
;->  1240 1496 1785 2109 2470 2870 3311 3795 4324 4900 5525
;->  6201 6930 7714 8555 9455)


--------------
Numeri potenti
--------------

Un numero potente è un intero positivo n tale che, per ogni numero primo p che divide n, anche p^2 divide n. Equivalentemente, un numero potente è il prodotto di un quadrato per un cubo, ovvero può essere scomposto nella forma n = a^2*b^3, dove a e b sono interi positivi (eventualmente uguali a 1).

Sequenza OEIS A001694:
  1, 4, 8, 9, 16, 25, 27, 32, 36, 49, 64, 72, 81, 100, 108, 121, 125,
  128, 144, 169, 196, 200, 216, 225, 243, 256, 288, 289, 324, 343,
  361, 392, 400, 432, 441, 484, 500, 512, 529, 576, 625, 648, 675, 676,
  729, 784, 800, 841, 864, 900, 961, 968, 972, 1000, ...

Quindi se un numero n è potente, allora tutti i suoi fattori primi e i loro quadrati devono essere divisibili per n.

Funzione 1
----------

(define (factor-group num)
"Factorize an integer number"
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

(define (powerful1? num)
  (if (= num 1) true
  ;else
  (catch
    (let (factors (factor-group num))
      (dolist (f factors)
        (setq val (f 0))
        (if (not (and (zero? (% num val)) (zero? (% num (* val val)))))
            (throw nil)
        )
      )
      true))))

(powerful1? 1)
;-> true
(powerful1? 2)
;-> nil
(powerful1? 4)
;-> true

(filter powerful1? (sequence 2 1000))
;-> (4 8 9 16 25 27 32 36 49 64 72 81 100 108 121 125 128 144 169 196
;->  200 216 225 243 256 288 289 324 343 361 392 400 432 441 484 500
;->  512 529 576 625 648 675 676 729 784 800 841 864 900 961 968 972 1000)

Funzione 2
----------

(define (powerful2? num)
  (if (= num 1) true
  ;else
  (catch
    (let (factors (factor num))
    ;(let (factors (unique (factor num))
      (dolist (f factors)
        (if (not (and (zero? (% num f)) (zero? (% num (* f f)))))
            (throw nil)
        )
      )
      true))))

(filter powerful2? (sequence 2 1000))
;-> (4 8 9 16 25 27 32 36 49 64 72 81 100 108 121 125 128 144 169 196
;->  200 216 225 243 256 288 289 324 343 361 392 400 432 441 484 500
;->  512 529 576 625 648 675 676 729 784 800 841 864 900 961 968 972 1000)

Funzione 3
----------

(define (powerful3? num)
  (if (= num 1) true
  ;else
  (catch
    ;(let (factors (factor num))
    (let (factors (unique (factor num)))
      (dolist (f factors)
        (if (not (and (zero? (% num f)) (zero? (% num (* f f)))))
            (throw nil)
        )
      )
      true))))

(filter powerful3? (sequence 1 1000))
;-> (1 4 8 9 16 25 27 32 36 49 64 72 81 100 108 121 125 128 144 169 196
;->  200 216 225 243 256 288 289 324 343 361 392 400 432 441 484 500
;->  512 529 576 625 648 675 676 729 784 800 841 864 900 961 968 972 1000)

Funzione 4
----------

(define (powerful4? num)
  (cond ((= num 1) true)
        (true
          (let ((factors (factor num)) (stop nil))
            (dolist (f factors stop)
              (if (not (and (zero? (% num f)) (zero? (% num (* f f)))))
                (setq stop true)
              )
            )
            (not stop)))))

(filter powerful4? (sequence 1 1000))
;-> (4 8 9 16 25 27 32 36 49 64 72 81 100 108 121 125 128 144 169 196
;->  200 216 225 243 256 288 289 324 343 361 392 400 432 441 484 500
;->  512 529 576 625 648 675 676 729 784 800 841 864 900 961 968 972 1000)

Vediamo la velocità di esecuzione delle funzioni:

(time (map powerful1? (sequence 1 1e6)))
;-> 3025.494
(time (map powerful2? (sequence 1 1e6)))
;-> 2309.6
(time (map powerful3? (sequence 1 1e6)))
;-> 2647.393
(time (map powerful4? (sequence 1 1e6)))
;-> 1278.179

(time (map powerful1? (sequence 1 1e4)) 100)
;-> 2468.71
(time (map powerful2? (sequence 1 1e4)) 100)
;-> 1805.129
(time (map powerful3? (sequence 1 1e4)) 100)
;-> 2134.935
(time (map powerful4? (sequence 1 1e4)) 100)
;-> 780.683

La funzione 4 è la più veloce (sembra che "catch" e "unique" rallentino l'esecuzione).


----------------------------------------------------
Combinazioni di punteggi per comporre un dato numero
----------------------------------------------------

Nel gioco della pallacanestro (basket-ball) un canestro può valere, 1 punto, 2 punti o 3 punti. Dato un punteggio totale N, trovare tutte le combinazioni per comporre il numero N utilizzando 1, 2, e 3 punti.
Ad esempio:
  per N = 2  ->  ((1 1) (2))
  per N = 3  ->  ((1 1 1) (1 2) (2 1) (3))
  per N = 4  ->  ((1 1 1 1) (1 1 2) (1 2 1) (1 3) (2 1 1) (2 2) (3 1))

Algoritmo:
  - Nella prima posizione possiamo avere tre numeri 1 o 2 o 3.
  - Per prima cosa, mettere 1 in prima posizione e chiamare ricorsivamente n-1.
  - Quindi mettere 2 nella prima posizione e chiamare ricorsivamente n-2.
  - Quindi mettere 3 in prima posizione e chiamare ricorsivamente n-3.
  - Se n diventa 0, allora abbiamo formato una combinazione che compone n, quindi inserire la combinazione corrente nella lista soluzione.

Scriviamo la funzione che crea una lista con tutte le combinazioni di numeri 1, 2, ... , "max-point" che sommano ad un numero "num".

La variabile "idx" è usata nella ricorsione per tenere traccia dell'indice in arr[] dove il successivo elemento deve essere aggiunto. Il valore iniziale di "idx" vale 0.

Il vettore "arr" viene passato dinamicamente alla funzione "compose" perchè viene utilizzato in modo globale durante le chiamate ricorsive.

(define (sums-points num max-point)
  (local (arr out)
    (setq out '())
    (setq arr (array 100 '(0)))
    (compose num 0)
    out))

(define (compose num idx)
  (cond ((zero? num)
         ;(println (slice arr 0 idx))
         (push (slice arr 0 idx) out -1))
        ((> num 0)
          (for (k 1 max-point)
            (setf (arr idx) k)
            (compose (- num k) (+ idx 1))))))

(sums-points 4 3)
;-> ((1 1 1 1) (1 1 2) (1 2 1) (1 3) (2 1 1) (2 2) (3 1))

La funzione ha un complessità temporale esponenziale O(n^k).

La funzione genera liste molto grandi rapidamente:

(length (sums-points 10 3))
;-> 274
(length (sums-points 11 3))
;-> 504
(length (sums-points 12 3))
;-> 927
(length (sums-points 13 3))
;-> 1705

(time (sums-points 15 3))
;-> 3326.624
(time (sums-points 16 3))
;-> 12719.889


-------------------
Pangram (pangramma)
-------------------

Un pangramma (o anche pantogramma "tutte le lettere") è una frase di senso compiuto, la più breve possibile, in cui vengono utilizzate tutte le lettere dell'alfabeto. Si chiama pangramma eteroletterale una frase in cui tutte le lettere dell'alfabeto compaiono una sola volta.
In lingua italiana sono stati prodotti diversi pangrammi e i più famosi sono:

"Qualche vago ione tipo zolfo, bromo, sodio" (34 lettere)
"Ma che bel gufo spenzola da quei travi" (31 lettere)
"Che tempi brevi zio, quando solfeggi" (30 lettere)
"Qui gli ampi stronzi, bove, defechi?" (29 lettere)
"O templi, quarzi, vigne, fidi boschi!" (28 lettere)
"Pochi sforzan quel gambo di vite" (27 lettere)
"Pranzo d'acqua fa volti sghembi" (26 lettere)

I seguenti sono esempi di pangrammi in lingua inglese standard senza abbreviazioni o nomi propri:

"The quick brown fox jumps over a lazy dog" (33 lettere)
"Waltz, bad nymph, for quick jigs vex" (28 lettere)
"Glib jocks quiz nymph to vex dwarf" (28 lettere)
"Sphinx of black quartz, judge my vow" (29 lettere)
"How vexingly quick daft zebras jump!" (30 lettere)
"The five boxing wizards jump quickly" (31 lettere)
"Jackdaws love my big sphinx of quartz" (31 lettere)
"Pack my box with five dozen liquor jugs" (32 lettere)

Un pangramma in italiano che include anche le lettere dell'alfabeto inglese è:

"Quel vituperabile xenofobo zelante assaggia il whisky ed esclama: alleluja!"

Per verificare le telescriventi in genere veniva utilizzzato il pangramma:

"Fabrizio ha visto Max acquistandogli juta per New York".

Alfabeto inglese (26 lettere):
(setq alfabeth '(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z))

Alfabeto italiano (21 lettere):
(setq alfabeto '(A B C D E F G H I L M N O P Q R S T U V Z))

Funzione che verifica se una frase è un pangramma (inglese e italiano con it = true):

(define (pangram? str it)
  (local (alfabeto look)
    (if it
        (setq alfabeto '("A" "B" "C" "D" "E" "F" "G" "H" "I" "L" "M"
                         "N" "O" "P" "Q" "R" "S" "T" "U" "V" "Z"))
        (setq alfabeto '("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
                         "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"))
    )
    (replace " " str "")
    (setq look (count alfabeto (explode (upper-case str))))
    (if (not (find 0 look) nil true))))

(pangram? "The quick brown fox jumps over a lazy dog")
;-> true

(pangram? "Ma che bel gufo spenzola da quei travi")
;-> nil

(pangram? "Ma che bel gufo spenzola da quei travi" true)
;-> true

(pangram? "Fabrizio ha visto Max acquistandogli juta per New York")
;-> true

Un pangramma inglese è anche un pangramma per la lingua italiana (perchè l'alfabeto italiano è un sottoinsieme dell'alfabeto inglese):

(pangram? "How vexingly quick daft zebras jump!")
;-> true
(pangram? "How vexingly quick daft zebras jump!" true)
;-> true

La seguente espressione regolare restituisce true se la stringa passata ha 26 lettere tutte diverse:

  "(?!.*(.).*\1).{26}"

(regex "(?!.*(.).*\1).{26}" "abcdefgh")
;-> nil
(regex "(?!.*(.).*\1).{26}" "abcdefghijklmnopqrstuvwxyz")
;-> ("abcdefghijklmnopqrstuvwxyz" 0 26)
(regex "(?!.*(.).*\1).{26}" "thequickbrownfoxjumpsoverthelazydog")
;-> ("thequickbrownfoxjumpsovert" 0 26)


------------------
Problema K Centers
------------------

Date n città e distanze tra ogni coppia di città, selezionare k città in cui posizionare magazzini in modo tale da ridurre al minimo la distanza massima di una città da un magazzino.

Ad esempio, consideriamo le quattro città, 0, 1, 2 e 3, e le distanze tra di loro. Come posizionare 2 bancomat tra queste 4 città in modo da ridurre al minimo la distanza massima di una città da un bancomat?

Proviamo a scrivere una soluzione brute-force in cui il grafo dei punti è rappresentato da una lista di adiacenza. Ad esempio i grafi seguenti e le loro rappresentazioni:

Grafo g1                          Grafo g2

  +---+   4    +---+              +---+   10   +---+
  | 0 |--------| 1 |              | 1 |--------| 0 |
  +---+        +---+              +---+        +---+
   |   \      /  |                 |   \      /  |
   |    \8   /   |                 |    \5   /   |
   |     \  /    |                 |     \  /    |
   |      \/     |               8 |      \/     |6
 5 |      /\     |10               |      /\     |
   |     /  \    |                 |     /  \    |
   |    /7   \   |                 |    /7   \   |
   |   /      \  |                 |   /      \  |
  +---+   9    +---+              +---+   12   +---+
  | 3 |--------| 2 |              | 2 |--------| 3 |
  +---+        +---+              +---+        +---+

(setq g1 '( (0  4  8 5)
            (4  0 10 7)
            (8 10  0 9)
            (5  7  9 0)))

(setq g2 '( ( 0 10  7  6)
            (10  0  8  5)
            ( 7  8  0 12)
            ( 6  5 12  0)))

Le combinazioni di centri da verificare sono tutte le combinazioni di k elementi senza ripetizione da una lista di n elementi:

(define (comb k lst)
"Generates all combinations of k elements without repetition from a list of items"
  (cond ((zero? k)   '(()))
        ((null? lst) '())
        (true
          (append (map (lambda (k-1) (cons (first lst) k-1))
                       (comb (- k 1) (rest lst)))
                  (comb k (rest lst))))))

(comb 2 '(0 1 2 3))
;-> ((0 1) (0 2) (0 3) (1 2) (1 3) (2 3))

Notare che il numero di combinazioni cresce velocemente:

Comb(n,k) = binomial(n,k) = n!/(k!*(n-k)!)

(define (binom num k)
"Calculates the binomial coefficient (n k) = n!/(k!*(n - k)!) (combinations of k elements without repetition from n elements)"
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(for (k 1 10)
  (println "k: " k)
  (for (n 10 50 10)
    (print (binom n k) { })
  )
  (println))
;-> k: 1
;-> 10L 20L 30L 40L 50L
;-> k: 2
;-> 45L 190L 435L 780L 1225L
;-> k: 3
;-> 120L 1140L 4060L 9880L 19600L
;-> k: 4
;-> 210L 4845L 27405L 91390L 230300L
;-> k: 5
;-> 252L 15504L 142506L 658008L 2118760L
;-> k: 6
;-> 210L 38760L 593775L 3838380L 15890700L
;-> k: 7
;-> 120L 77520L 2035800L 18643560L 99884400L
;-> k: 8
;-> 45L 125970L 5852925L 76904685L 536878650L
;-> k: 9
;-> 10L 167960L 14307150L 273438880L 2505433700L
;-> k: 10
;-> 1L 184756L 30045015L 847660528L 10272278170L

Per ogni combinazione calcoliamo il valore massimo delle distanze minime di ogni altro punto dai centri di quella combinazione. Al termine selezioniamo il valore minimo delle distanze massime e la relativa posizione dei centri.

(define (kcenters k lst)
  (local (num-pts pts positions dist cur-min local-max out)
    ; numero di punti
    (setq num-pts (length lst))
    ; lista (0..num-pts)
    (setq pts (sequence 0 (- (length lst) 1)))
    ; lista di tutte le posizioni (combinazioni)
    ; in cui posizionare i centri
    (setq positions (comb k pts))
    ; lista (distanza massima, lista di centri)
    ; per ogni posizione
    (setq out '())
    ; ciclo per verificare ogni posizione
    (dolist (pos positions)
      ; calcolo punti di analizzare =
      ; tutti - posizione corrente
      (setq from-pts (difference pts pos))
      ; valore di distanza massima locale
      (setq local-max -1)
      ; calcola la distanza massima dei punti
      ; per la combinazione corrente.
      ; Per ogni punto...
      (dolist (f from-pts)
        ; calcola la distanza minima del punto corrente...
        (setq cur-min 999999)
        ; da tutti i centri della posizione corrente
        (dolist (p pos)
          (setq dist (lst f p))
          ; se distanza corrente è minore
          ; della distanza minima corrente...
          (if (< dist cur-min)
              ; allora aggiorna distanza minima e
              ; punti di posizionamento
              (setq cur-min dist)
          )
          ;(print pos { } f { } p { } (lst f p))
          ;(read-line)
        )
        ;(println cur-min)
        ; se la distanza minima è maggiore
        ; della distanza massima locale...
        ; allora aggiorna il valore
        ; della distanza massima locale
        (if (> cur-min local-max) (setq local-max cur-min))
        ;(print "local-max: " local-max)
        ;(read-line)
      )
      ;(print (list local-max pos))
      ;(read-line)
      ; inserisce distanza massima e centri
      ; nella lista soluzione
      (push (list local-max pos) out)
    )
    (println out)
    ; recupera l'elemento nella lista soluzione con distanza minima
    (first (sort out))))

(kcenters 2 g1)
;-> ((7 (2 3)) (9 (1 3)) (7 (1 2)) (8 (0 3)) (5 (0 2)) (8 (0 1)))
;-> (5 (0 2))

(kcenters 2 g2)
;-> ((6 (2 3)) (8 (1 3)) (7 (1 2)) (7 (0 3)) (8 (0 2)) (7 (0 1)))
;-> (6 (2 3))

Questo è un noto problema NP-Hard e non esiste una soluzione in tempo polinomiale. Esiste un algoritmo greedy approssimato con tempo polinomiale che fornisce una soluzione che non è mai peggiore del doppio della soluzione ottimale. La soluzione greedy funziona solo se le distanze tra le città seguono la disuguaglianza triangolare (la distanza tra due punti è sempre inferiore alla somma delle distanze attraverso un terzo punto).

Algoritmo greedy approssimativo:
1) Scegliere arbitrariamente il primo centro.
2) Scegliere i restanti centri k-1 utilizzando i seguenti criteri.
   Siano c1, c2, c3, … ci i centri già scelti.
   Scegliere l'(i+1)-esimo centro selezionando la città che è la più lontana
   dai centri selezionati, cioè il punto p che ha come valore massimo:
   Min[dist(p, c1), dist(p, c2), dist(p, c3), …. dist(p, ci)]

Prova che (soluzione-ottimale <= 2*soluzione-greedy):
Sia D la distanza massima di una città da un centro nella soluzione ottimale. Dobbiamo mostrare che la distanza massima ottenuta dall'algoritmo Greedy è 2*D.
La dimostrazione può essere fatta usando la contraddizione.
a) Si supponga che la distanza dal punto più lontano a tutti i centri sia > 2*D.
b) Ciò significa che anche le distanze tra tutti i centri sono > 2*D.
c) Abbiamo k + 1 punti con distanze > 2*OPT tra ogni coppia.
d) Ogni punto ha un centro della soluzione ottima con distanza <= OPT ad esso.
e) Esiste una coppia di punti con lo stesso centro X nella soluzione ottima (principio della piccionaia: k centri ottimali, k+1 punti)
f) La distanza tra loro è al massimo 2*D (per la disuguaglianza triangolare), che è una contraddizione.

(define (max-index lst)
  (let (max-idx 0)
    (dolist (el lst)
      (if (> el (lst max-idx))
          (setq max-idx $idx)
      )
    )
    max-idx))

(setq lst '(4 5 2 7 9 3))
(max-index lst)
;-> 4

(define (k-centers k lst)
  (local (num-pts dist centers maximum)
    (setq num-pts (length lst))
    (setq dist (array num-pts '(0)))
    (setq centers '())
    (for (i 0 (- num-pts 1))
      (setq (dist i) 999999)
    )
    ; indice della città che ha la distanza massima
    ; dal centro più vicino
    (setq maximum 0)
    (for (i 0 (- k 1))
      (push maximum centers -1)
      (for (j 0 (- num-pts 1))
        # aggiorna la distanza delle città dai loro centri più vicini
        (setq (dist j) (min (dist j) (lst maximum j)))
      )
      # aggiorna l'indice della città
      ; con la distanza massima dal centro più vicino
      (setq maximum (max-index dist))
    )
    (list (dist maximum) centers)))

(k-centers 2 g1)
;-> (5 (0 2)) ; soluzione ottimale

(k-centers 2 g2)
;-> (7 (0 1)) ; soluzione non ottimale


-----------------------------------------------
Verificare se due segmenti/rette sono paralleli
-----------------------------------------------

Dati due segmenti AB e CD aventi A = (x1 y1), B = (x2 y2), C = (x3 y3) e D = (x4 y4), verificare se sono paralleli (cioè le linee a cui appartengono questi segmenti sono parallele).
Due rette si dicono parallele hanno pendenze uguali (m1 = m2).

(define (parallel? p1 p2 p3 p4)
  (let ((x1 (first p1)) (y1 (last p1))
        (x2 (first p2)) (y2 (last p2))
        (x3 (first p3)) (y3 (last p3))
        (x4 (first p4)) (y4 (last p4))
        (m1 0) (m2 0))
              ; Entrambe le linee hanno pendenza infinita
        (cond ((and (zero? (sub x2 x1)) (zero? (sub x4 x3)))
                true)
              ; le pendenze sono finite
              (true
                (setq m1 (div (sub y2 y1) (sub x2 x1)))
                (setq m2 (div (sub y4 y3) (sub x4 x3)))
                ; test parallelismo: m1 = m2
                (if (= m1 m2)
                    true
                    nil)))))

(parallel? '(2 2) '(4 2) '(-5 3) '(1 3))
;-> true

(parallel? '(0 0) '(0 4) '(0 6) '(0 -5))
;-> true

(parallel? '(1 1) '(0 4) '(1 2) '(3 3))
;-> nil


------------------------------------------------
Verificare se due segmenti/rette sono ortogonali
------------------------------------------------

Dati due segmenti AB e CD aventi A = (x1 y1), B = (x2 y2), C = (x3 y3) e D = (x4 y4), verificare se sono ortogonali (cioè le linee a cui appartengono questi segmenti sono ortogonali).
Due rette si dicono ortogonali se sono perpendicolari nel punto di intersezione.

Calcoliamo le pendenze delle due rette: m1 e m2.
Poi verifichiamo i seguenti casi:

m1 = ∞ and m2 = ∞                            --> rette non parallele
(m1 = ∞ and m2 = 0) or (m1 = 0 and m2 = ∞)   --> rette parallele
m1 = x and m2 = y and x*y = -1               --> rette parallele

(define (ortho? p1 p2 p3 p4)
  (let ((x1 (first p1)) (y1 (last p1))
        (x2 (first p2)) (y2 (last p2))
        (x3 (first p3)) (y3 (last p3))
        (x4 (first p4)) (y4 (last p4))
        (m1 0) (m2 0))
              ; Entrambe le linee hanno pendenza infinita
        (cond ((and (zero? (sub x2 x1)) (zero? (sub x4 x3)))
                nil)
              ; solo la linea 1 ha pendenza infinita
              ((zero? (sub x2 x1))
                (setq m2 (div (sub y4 y3) (sub x4 x3)))
                (if (zero? m2)
                    true
                    nil))
              ; solo la linea 2 ha pendenza infinita
              ((zero? (sub x4 x3))
                (setq m1 (div (sub y2 y1) (sub x2 x1)))
                (if (zero? m1)
                    true
                    nil))
              ; le pendenze sono finite
              (true
                (setq m1 (div (sub y2 y1) (sub x2 x1)))
                (setq m2 (div (sub y4 y3) (sub x4 x3)))
                ; Test ortogonalità: m1*m2 = -1
                (if (= (mul m1 m2) -1)
                    true
                    nil))
        )))


(ortho? '(0 3) '(0 -5) '(2 0) '(-1 0))
;-> true
(ortho? '(0 3) '(0 -5) '(-1 0) '(2 0))
;-> true
(ortho? '(0 -5) '(-1 0) '(2 0) '(0 3))
;-> nil
(ortho?  '(0 4) '(0 -9) '(2 0) '(-1 0))
;-> true


-------------------------------------------
Quadrato, rettangolo, rombo o quadrilatero?
-------------------------------------------

Date le coordinate di quattro punti in un piano cartesiano 2D, determinare se formano un quadrato, un rombo, un rettangolo o un quadrilatero. Le coordinate dei punti sono ordinate in senso orario o antiorario.

Esistono diversi metodi per risolvere questo problema, in questo caso utilizziamo le distanze e il controllo di ortogonalità.

Per distinguere le figure calcoliamo tutte le distanze tra tutti i punti e verifichiamo le seguenti condizioni:

- Quadrato
  2 diagonali uguali e 4 lati uguali (2 4)
  e verifica se due lati sono ortogonali

- Rettangolo
  2 lati minori uguali, 2 lati maggiori uguali e 2 diagonali uguali (2 2 2)
  e verifica se due lati sono ortogonali

- Rombo
  1 diagonale minore, 1 diagonale maggiore e 4 lati uguali (1 1 4)
  e verifica se le diagonali sono ortogonali

- Quadrilatero
  tutti gli altri casi

(define (dist2d-2 p q)
"Calculates the square of 2D Cartesian distance of two points p = (x1 y1) and q = (x2 y2)"
  (let ((x1 (first p)) (y1 (last p))
        (x2 (first q)) (y2 (last q)))
    (add (mul (sub x1 x2) (sub x1 x2))
        (mul (sub y1 y2) (sub y1 y2)))))

(define (cosa? p1 p2 p3 p4)
  (local (dist d1 d2 d3 d4 d5 d6 uniq timbro out)
    (setq out "")
    (setq dist '())
    (setq d1 (dist2d-2 p1 p2))
    (setq d2 (dist2d-2 p1 p3))
    (setq d3 (dist2d-2 p1 p4))
    (setq d4 (dist2d-2 p2 p3))
    (setq d5 (dist2d-2 p2 p4))
    (setq d6 (dist2d-2 p3 p4))
    (push d1 dist -1)
    (push d2 dist -1)
    (push d3 dist -1)
    (push d4 dist -1)
    (push d5 dist -1)
    (push d6 dist -1)
    (setq uniq (unique dist))
    (setq timbro (sort (count uniq dist)))
    (println dist)
    (println timbro)
    (cond ((and (= timbro '(2 4)) (ortho? p1 p2 p2 p3))
            (setq out "quadrato"))
          ((and (= timbro '(1 1 4)) (ortho? p1 p3 p4 p2))
            (setq out "rombo"))
          ((and (= timbro '(2 2 2)) (ortho? p1 p2 p2 p3))
            (setq out "rettangolo"))
          (true (setq out "quadrilatero"))
    )
    out))

Quadrato:
(setq q1 '(10 10))
(setq q2 '(10 20))
(setq q3 '(20 20))
(setq q4 '(20 10))

(cosa? q1 q2 q3 q4)
;-> (100 200 100 100 200 100)
;-> (2 4)
;-> "quadrato"

(setq q1 '(-2 3))
(setq q2 '(3 6))
(setq q3 '(6 1))
(setq q4 '(1 -2))

(cosa? q1 q2 q3 q4)
;-> (34 68 34 34 68 34)
;-> (2 4)
;-> "quadrato"

Rettangolo:
(setq r1 '(10 20))
(setq r2 '(25 20))
(setq r3 '(25 10))
(setq r4 '(10 10))

(cosa? r1 r2 r3 r4)
;-> (225 325 100 100 325 225)
;-> (2 2 2)
;-> "rettangolo"

(setq r1 '(2 4))
(setq r2 '(4 2))
(setq r3 '(7 5))
(setq r4 '(5 7))

(cosa? r1 r2 r3 r4)
;-> (8 26 18 18 26 8)
;-> (2 2 2)
;-> "rettangolo"

Rombo:
(setq m1 '(-3 -4))
(setq m2 '(10 -4))
(setq m3 '(15 8))
(setq m4 '(2 8))

(cosa? m1 m2 m3 m4)
;-> (169 468 169 169 208 169)
;-> (1 1 4)
;-> "rombo"

Quadrilatero:
(setq q1 '(2 4))
(setq q2 '(10 4))
(setq q3 '(9 8))
(setq q4 '(1 8))

(cosa? q1 q2 q3 q4)
;-> (64 65 17 17 97 64)
;-> (1 1 2 2)
;-> "quadrilatero"

Se vogliamo verificare soltanto se le coordinate dei quattro punti formano un quadrato possiamo usare un metodo diverso.

Un quadrato ha le seguenti proprietà:
a) Tutti i quattro lati sono uguali.
b) L'angolo tra due lati qualsiasi è di 90 gradi. (condizione richiesta in quanto anche un quadrilatero ha gli stessi lati).
c) Entrambe le diagonali hanno la stessa lunghezza

(define (square? p1 p2 p3 p4)
  (local (d2 d3 d4)
    (setq d2 (dist2d-2 p1 p2))
    (setq d3 (dist2d-2 p1 p3))
    (setq d4 (dist2d-2 p1 p4))
    (cond ((or (zero? d2) (zero? d3) (zero? d4))
            nil)
     ; Se le lunghezze se (p1, p2) e (p1, p3) sono uguali, allora
     ; devono essere soddisfatte le seguenti condizioni per formare un quadrato.
     ; 1) Il quadrato di lunghezza di (p1, p4) è uguale a due volte
     ;    il quadrato di (p1, p2)
     ; 2) Il quadrato di lunghezza di (p2, p3) è lo stesso
     ;    al doppio del quadrato di (p2, p4)
          ((and (= d2 d3) (= (mul 2 d2) d4)
                (= (mul 2 (dist2d-2 p2 p4)) (dist2d-2 p2 p3)))
          true)
     ; condizione analoga
          ((and (= d3 d4) (= (mul 2 d3) d2)
                (= (mul 2 (dist2d-2 p3 p2)) (dist2d-2 p3 p4)))
          true)
     ; condizione analoga
          ((and (= d2 d4) (= (mul 2 d2) d3)
                (= (mul 2 (dist2d-2 p2 p3)) (dist2d-2 p2 p4)))
          true)
     ; altrimenti restituisce nil
          (true nil))))

(setq p1 '(20 10))
(setq p2 '(10 20))
(setq p3 '(20 20))
(setq p4 '(10 10))

(square? p1 p2 p3 p4)
;-> true

(setq p5 '(12 12))
(square? p1 p2 p3 p5)
;-> nil


--------------
Enigma machine
--------------

Scriviamo una programma che emula la famosa macchina Enigma della seconda guerra mondiale.
Il programma simula una macchina Enigma costituita da:
  - 9 rotori generati casualmente
  - riflettore (rotore statico)
  - alfabeto originale

Per maggiori informazioni:
https://en.wikipedia.org/wiki/Enigma_machine
https://youtu.be/QwQVMqfoB2E
Guarda anche i video di Numberphile e Computerphile su questo argomento.
Implementazione in python di riferimento:
https://github.com/TheAlgorithms/Python/blob/master/ciphers/enigma_machine2.py

;---------------
; SETUP function
;---------------
; Create alphabet, rotors and reflector
(define (setup)
  ; alphabet: ascii uppercase
  (setq abc "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
  ; rotors --------------------------
  (setq rotor1 "EGZWVONAHDCLFQMSIPJBYUKXTR")
  (setq rotor2 "FOBHMDKEXQNRAULPGSJVTYICZW")
  (setq rotor3 "ZJXESIUQLHAVRMDOYGTNFWPBKC")
  (setq rotor4 "RMDJXFUWGISLHVTCQNKYPBEZOA")
  (setq rotor5 "SGLCPQWZHKXAREONTFBVIYJUDM")
  (setq rotor6 "HVSICLTYKQUBXDWAJZOMFGPREN")
  (setq rotor7 "RZWQHFMVDBKICJLNTUXAGYPSOE")
  (setq rotor8 "LFKIJODBEGAMQPXVUHYSTCZRWN")
  (setq rotor9 "KOAEGVDHXPQZMLFTYWJNBRCIUS")
  ; reflector --------------------------
  (setq reflector '( ("A" "N") ("N" "A")
                     ("B" "O") ("O" "B")
                     ("C" "P") ("P" "C")
                     ("D" "Q") ("Q" "D")
                     ("E" "R") ("R" "E")
                     ("F" "S") ("S" "F")
                     ("G" "T") ("T" "G")
                     ("H" "U") ("U" "H")
                     ("I" "V") ("V" "I")
                     ("J" "W") ("W" "J")
                     ("K" "X") ("X" "K")
                     ("L" "Y") ("Y" "L")
                     ("M" "Z") ("Z" "M") ))
)
; execute "setup" function
(setup)
;---------------------
; PLUGBOARD-F function
----------------------
; pbstring: string
(define (plugboard-f pbstring)
  ; tests the input string if it
  ; a) is type string
  ; b) has even length (so pairs can be made)
  ; https://en.wikipedia.org/wiki/Enigma_machine#Plugboard
  (if (not (string? pbstring))
      (println "ERROR: pbstring in not a string: " pbstring))
  (if (odd? (length pbstring))
      (println "ERROR: pbstring has odd numbers of symbols: " (length pbstring)))
  (replace " " pbstring "")
  ; Checks if all characters are unique and
  ; are in alphabet abc
  (if (!= (unique (explode pbstring)) (explode pbstring))
      (println "ERROR: duplicate symbols: " pbstring))
  (if (!= (count (explode pbstring) (explode abc))
          (dup 1 (length pbstring)))
      (println "ERROR: symbols not in alphabet: " pbstring))
  ; Created the dictionary (associative list)
  (setq pb '())
  (for (j 0 (- (length pbstring) 2) 2)
    (push (list (pbstring j) (pbstring (+ j 1))) pb -1)
    (push (list (pbstring (+ j 1)) (pbstring j)) pb -1)
  )
  pb)
;-----------------
; PLUGBOARD-F test
;-----------------
;(plugboard-f "PICTURES")
;-> (("P" "I") ("I" "P") ("C" "T") ("T" "C") ("U" "R") ("R" "U") ("E" "S") ("S" "E"))
;(plugboard-f "POLAND")
;-> (("P" "O") ("O" "P") ("L" "A") ("A" "L") ("N" "D") ("D" "N"))
;(plugboard-f "A")
;(plugboard-f "AA")
;(plugboard-f "Aa")
;-------------------
; VALIDATOR function
;-------------------
; rotpos: (int int int)
; rotsel: (string string string)
; pb: string
; Checks if the values can be used for the 'enigma' function
(define (validator rotpos rotsel pb)
  (setq unique-rotsel (length (unique rotsel)))
  (if (< unique-rotsel 3)
      (println "ERROR: not 3 unique rotors: " unique-rotsel))
  (setq rotorpos1 (rotpos 0))
  (setq rotorpos2 (rotpos 1))
  (setq rotorpos3 (rotpos 2))
  ; (length abc) -> 26
  (if (or (< rotorpos1 1) (> rotorpos1 (length abc)))
      (println "ERROR: rotor 1 non in range 1..26: " rotorpos1))
  (if (or (< rotorpos2 1) (> rotorpos2 (length abc)))
      (println "ERROR: rotor 2 non in range 1..26: " rotorpos2))
  (if (or (< rotorpos3 1) (> rotorpos3 (length abc)))
      (println "ERROR: rotor 3 non in range 1..26: " rotorpos3))
  ; Validates string and returns dict (association list)
  (setq pbdict (plugboard-f pb))
  (list rotpos rotsel pbdict))
;---------------
; VALIDATOR test
;---------------
;(validator '(1 1 1) (list rotor1 rotor2 rotor3) "POLAND")
;-> ((1 1 1)
;->  ("EGZWVONAHDCLFQMSIPJBYUKXTR" "FOBHMDKEXQNRAULPGSJVTYICZW" "ZJXESIUQLHAVRMDOYGTNFWPBKC")
;->  (("P" "O") ("O" "P") ("L" "A") ("A" "L") ("N" "D") ("D" "N")))
;----------------
; ENIGMA function
;----------------
; test: string (message)
; rotor-position: (int int int)
; rotor-selection: (string string string)
; plugpb: string
; How it works:
;    (for every letter in the message)
;    - Input letter goes into the plugboard.
;    If it is connected to another one, switch it.
;    - Letter goes through 3 rotors.
;    Each rotor can be represented as 2 sets of symbol, where one is shuffled.
;    Each symbol from the first set has corresponding symbol in
;    the second set and vice versa.
;    example:
;    | ABCDEFGHIJKLMNOPQRSTUVWXYZ | e.g. F=D and D=F
;    | VKLEPDBGRNWTFCJOHQAMUZYIXS |
;    - Symbol then goes through reflector (static rotor).
;    There it is switched with paired symbol
;    The reflector can be represented as 2 sets, each with half of the alphanet.
;    There are usually 10 pairs of letters.
;    Example:
;    | ABCDEFGHIJKLM | e.g. E is paired to X
;    | ZYXWVUTSRQPON | so when E goes in X goes out and vice versa
;    - Letter then goes through the rotors again
;    - If the letter is connected to plugboard, it is switched.
;    - Return the letter
(define (enigma text rotor-position rotor-selection plugb)
  (setq text (upper-case text))
  (setq plugb (upper-case plugb))
  (setq result (validator rotor-position rotor-selection plugb))
  (setq rotor-position (result 0))
  (setq rotor-selection (result 1))
  (setq plugboard (result 2))
  (setq rotorpos1 (rotor-position 0))
  (setq rotorpos2 (rotor-position 1))
  (setq rotorpos3 (rotor-position 2))
  (setq rotorsel1 (rotor-selection 0))
  (setq rotorsel2 (rotor-selection 1))
  (setq rotorsel3 (rotor-selection 2))
  (-- rotorpos1)
  (-- rotorpos2)
  (-- rotorpos3)
  (setq result '())
  (dolist (s (explode text))
    (if (find s abc)
        (begin
          ; 1st plugboard
          (if (lookup s plugboard)
              (setq s (lookup s plugboard))
          )
          ; rotor ra
          (setq idx (+ (find s abc) rotorpos1))
          (setq s (rotorsel1 (% idx (length abc))))
          ; rotr rb
          (setq idx (+ (find s abc) rotorpos2))
          (setq s (rotorsel2 (% idx (length abc))))
          ; rotr rc
          (setq idx (+ (find s abc) rotorpos3))
          (setq s (rotorsel3 (% idx (length abc))))
          ; reflector --------------------------
          ; this is the reason you don't need another machine to decipher
          (setq s (lookup s reflector))
          ; 2nd rotors
          (setq s (abc (- (find s rotorsel3) rotorpos3)))
          (setq s (abc (- (find s rotorsel2) rotorpos2)))
          (setq s (abc (- (find s rotorsel1) rotorpos1)))
          ; 2nd plugboard
          (if (lookup s plugboard)
              (setq s (lookup s plugboard))
          )
          ; moves/resets rotor positions
          (++ rotorpos1)
          (if (>= rotorpos1 (length abc))
              (begin
                (setq rotorpos1 0)
                (++ rotorpos2)))
          (if (>= rotorpos2 (length abc))
              (begin
                (setq rotorpos2 0)
                (++ rotorpos3)))
          (if (>= rotorpos3 (length abc))
              (setq rotorpos3 0))
        )
    )
    (push s result -1)
  )
  (join result))
;------------
; ENIGMA test
;------------
;(enigma "Hello World!" '(1 2 1) (list rotor1 rotor2 rotor3) "pictures")
;-> "KORYH JUHHI!"
;(enigma "KORYH, juhhi!" '(1 2 1) (list rotor1 rotor2 rotor3) "pictures")
;-> "HELLO, WORLD!"
(enigma "This is my newLISP script that emulates the Enigma machine from WWII."
        '(1 1 1)
        (list rotor2 rotor4 rotor8)
        "pictures")
;-> "WQGI XH BJ HKOUHVO MWCAAP EEQG JDRPJMVH XQZ KSWSJJ STHSKGL XXLU TOXF."
(enigma "WQGI XH BJ HKOUHVO MWCAAP EEQG JDRPJMVH XQZ KSWSJJ STHSKGL XXLU TOXF."
        '(1 1 1)
        (list rotor2 rotor4 rotor8)
        "pictures")
;-> "THIS IS MY NEWLISP SCRIPT THAT EMULATES THE ENIGMA MACHINE FROM WWII."


-------------
Radice cubica
-------------

Radice cubica perfetta (intera)
-------------------------------
Per trovare la radice cubica di un cubo perfetto, possiamo semplicemente applicare la ricerca binaria sullo spazio di [1, num] e restituire x quando dove x^3 è uguale a num.
La seguente funzione calcola la radice cubica intera di un dato numero:

(define (cuberoot num)
  (local (a b m)
    (setq a 1)
    (setq b num)
    (setq m (/ (+ a b) 2))
    (while (and (!= m a) (!= (* m m m) num))
      (if (> (* m m m) num)
          (setq b m)
      ;else
          (setq a m)
      )
      (setq m (/ (+ a b) 2))
    )
    m))

(cuberoot 9)
;-> 2
(cuberoot 150)
;-> 5
(cuberoot 1235)
;-> 10

La condizione (m != a) nel ciclo while, permette di restituire un valore più piccolo nel caso in cui il ciclo non trovi una radice cubica perfetta. E senza questa condizione, il ciclo verrà eseguito all'infinito.

Radice cubica (decimale)
------------------------
Per trovare il valore reale di una radice cubica (cioè un numero floating point), possiamo prima cercare un risultato più piccolo usando la funzione "cuberoot" e, se restituisce una radice cubica perfetta, restituirla altrimenti procedere alla ricerca della soluzione con un numero di decimali predefinito.
Dopo aver trovato una radice cubica perfetta o un valore più piccolo più vicino, cercheremo tra .0 e .9 una corrispondenza perfetta o un valore più vicino, quindi avvieremo un'altra ricerca tra .00 e .09 e cosi via. Mentre avviene la ricerca negli intervalli dovremo continuare ad aggiungere i valori trovati al risultato (aumentando così la sua precisione).

(define (f a b) (mul a (pow 10 (- b))))
(define (cube) (pow (add res (f mid i)) 3))

(define (cube-root num prec)
(catch
  (local (res start end mid c)
    (setq res (cuberoot num))
    (if (= num (mul res res res))
        (throw res)
    )
    (for (i 1 prec)
      (setq start 0)
      (setq end 9)
      (setq mid (/ (+ start end) 2))
      (while (!= start mid)
        (setq c (cube))
        (cond ((> c num)
                (setq end mid))
              ((< c num)
                (setq start mid))
              ((= c num)
                (throw (add res (f mid i))))
        )
        (setq mid (/ (+ start end) 2))
      )
      (setq res (add res (f mid i)))
    )
    res)))

(cube-root 55 5)
;-> 3.80288
(cube-root 128 4)
;-> 5.0388
(cube-root 1234.31 3)
;-> 10.726
(cube-root 16.003008 5)
;-> 2.52

Nota: questo algoritmo ha il grave difetto che aumentando la precisione oltre un certo valore si generano errori di arrotondamento.

(pow 1234.31 (div 3))
;-> 10.72691277421636

(cube-root 1234.31 10)
;-> 10.7268888888

Il metodo standard per calcolare la radice cubica di un numero è quello di utilizzare la funzione "pow":

(pow 125 (div 3))
;-> 4.999999999999999

Però non calcola le radici cubiche di numeri negativi:

(pow -125 (div 3))
;-> -1.#IND

Allora possiamo scrivere una funzione:

(define (cbrt x)
"Calculates the cube root of a number"
  (if (< x 0)
      (sub (pow (sub x) (div 3)))
      ;else (positive number)
      (pow x (div 3))))

(cbrt 125)
;-> 4.999999999999999
(cbrt -125)
;-> -4.999999999999999

Se vogliamo calcolare la radice cubica intera di un numero possiamo scrivere:

(define (cbrt-i x)
"Calculates the integer cube root of a positive number"
  (int (add 0.5 (pow x (div 3)))))

(cbrt-i 126)
;-> 5

Oppure:

(define (cbrt-i2 x)
  (let ((res 0) (stop nil))
    (dotimes (i 9223372036854775807 stop)
      (if (> (* i i i) x) (set 'res (- i 1) 'stop true))
    )
    res))

(cbrt-i2 126)
;-> 5
(cbrt-i2 125)
;-> 5
(cbrt-i2 124)
;-> 4

Se vogliamo anche sapere se un numero è un cubo perfetto:

(define (cbrt? n exact)
"Calculates the integer cube root of a natural number"
  (let ((res 0) (stop nil) (val 0))
    (cond ((= exact true)
            (dotimes (i 9223372036854775807 stop)
              (setq val (* i i i))
              (if (= val n) (set 'res i   'stop true)
                  (> val n) (set 'res nil 'stop true)
              )
            )
          )
          (true
            (dotimes (i 9223372036854775807 stop)
              (if (> (* i i i) n) (set 'res (- i 1) 'stop true))
            )
          )
    )
    res))

(cbrt? 125)
;-> 5
(cbrt? 126)
;-> 5
(cbrt? 125 true)
;-> 5
(cbrt? 126 true)
;-> nil
(cbrt? 123456789123456789)
;-> 497933
(cbrt 123456789123456789)
;-> 497933.8593841521


--------------
Radice n-esima
--------------

Radice n-esima perfetta (intera)
--------------------------------
Per trovare la radice n-esima perfetta, possiamo semplicemente applicare la ricerca binaria sullo spazio di [1, num] e restituire x quando dove x^n è uguale a num.
La seguente funzione calcola la radice n-esima intera di un dato numero:

(define (nthroot num n)
  (local (a b m)
    (setq a 1)
    (setq b num)
    (setq m (/ (+ a b) 2))
    (while (and (!= m a) (!= (pow m n) num))
      (if (> (pow m n) num)
          (setq b m)
      ;else
          (setq a m)
      )
      (setq m (/ (+ a b) 2))
    )
    m))

(nthroot 8 3)
;-> 2
(nthroot 1235 3)
;-> 10
(nthroot 1024 5)
;-> 4

Radice n-esima (decimale)
-------------------------
La seguente funzione utilizza il metodo di newton per calcolare la radice-n-esima di un dato numero:

(define (nth-root n a)
  (let ((x1 a) (x2 (div a n)))
  (until (= x1 x2)
    (setq x1 x2
          x2 (div (add (mul x1 (- n 1)) (div a (pow x1 (- n 1))))
                  n))
  )
  x2))

(nth-root 3 1234.31)
;-> 10.72691277421636


------------------------------------------------------------
Analisi numerica e numeri in virgola mobile (floating point)
------------------------------------------------------------

https://people.eecs.berkeley.edu/~wkahan/

L'indirizzo web sopra riportato è il sito di William Kahan, Ph.D. (Math., University of Toronto, 1958) e Professor Emeritus of Mathematics, and of E.E. & Computer Science.
Contiene una miniera di informazioni sull'analisi numerica e sui problemi legati all'utilizzo dei numeri in virgola mobile nella soluzione dei problemi di calcolo.

Alcuni articoli interessanti:
  - Why is Floating-Point Computation so Hard to Debug when it Goes Wrong?
  - Why I can Debug some Numerical Programs You can't (PDF file)
  - Beastly Numbers, a paper about two different computers upset in the same way by the same two floating-point numbers
  - How to Test Whether SQRT is Rounded Correctly
  - Back to the Future of Undebuggable Floating-Point Software in Science and Engineering
  - A Numerical Analyst thinks about Artificial Intelligence & Deep Learning
  - ... the Critiques' gory details: (Unums' pdf) & (SORN's pdf)

Di seguito riportiamo i risultati della funzione descritta nell'articolo "Why is Floating-Point Computation so Hard to Debug when it Goes Wrong?"

(define (h x iter)
  (local (a b)
    (setq y (abs x))
    (for (i 1 iter) (setq y (sqrt y)))
    (setq w y)
    (for (i 1 iter) (setq w (mul w w)))
    (list y w)))

(h 0 128)
;-> (0 0)
(h 0.5 128)
;-> (0.9999999999999999 0)
(h 1 128)
;-> (1 1)
(h 1.5 128)
;-> (1 1)
(h 1.5 128)
;-> (1 1)
(h -1 128)
;-> (1 1)

(for (i 0 2 0.1) (println i { } (h i 128)))
;-> 0 (0 0)
;-> 0.1 (0.9999999999999999 0)
;-> 0.2 (0.9999999999999999 0)
;-> 0.3 (0.9999999999999999 0)
;-> 0.4 (0.9999999999999999 0)
;-> 0.5 (0.9999999999999999 0)
;-> 0.6000000000000001 (0.9999999999999999 0)
;-> 0.7000000000000001 (0.9999999999999999 0)
;-> 0.8 (0.9999999999999999 0)
;-> 0.9 (0.9999999999999999 0)
;-> 1 (1 1)
;-> 1.1 (1 1)
;-> 1.2 (1 1)
;-> 1.3 (1 1)
;-> 1.4 (1 1)
;-> 1.5 (1 1)
;-> 1.6 (1 1)
;-> 1.7 (1 1)
;-> 1.8 (1 1)
;-> 1.9 (1 1)
;-> 2 (1 1)

Usando una lista con i valori da 0.0 a 2.0 con passo 0.1 si elimina il problema dei valori 0.6 e 0.7 (perchè i valori non vengono calcolati come nel ciclo "for"):

(setq seq '(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0
              1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0))

(dolist (i seq) (println i { } (h i 128)))
;-> 0 (0 0)
;-> 0.1 (0.9999999999999999 0)
;-> 0.2 (0.9999999999999999 0)
;-> 0.3 (0.9999999999999999 0)
;-> 0.4 (0.9999999999999999 0)
;-> 0.5 (0.9999999999999999 0)
;-> 0.6 (0.9999999999999999 0)
;-> 0.7 (0.9999999999999999 0)
;-> 0.8 (0.9999999999999999 0)
;-> 0.9 (0.9999999999999999 0)
;-> 1 (1 1)
;-> 1.1 (1 1)
;-> 1.2 (1 1)
;-> 1.3 (1 1)
;-> 1.4 (1 1)
;-> 1.5 (1 1)
;-> 1.6 (1 1)
;-> 1.7 (1 1)
;-> 1.8 (1 1)
;-> 1.9 (1 1)
;-> 2 (1 1)
;-> (1 1)

Facciamo un altro test:

(dolist (i seq)
  (println i)
  (for (j 5 10)
    (print j {: } (last (h i j)) {. })
    ;(print j { } (h i j) {. })
  )
  (println))
;-> 0
;-> 5: 0. 6: 0. 7: 0. 8: 0. 9: 0. 10: 0.
;-> 0.1
;-> 5: 0.1000000000000001. 6: 0.1000000000000001. 7: 0.09999999999999937.
;-> 8: 0.09999999999999937. 9: 0.1000000000000024. 10: 0.1000000000000024.
;-> 0.2
;-> 5: 0.2000000000000001. 6: 0.2000000000000001. 7: 0.2000000000000016.
;-> 8: 0.2000000000000016. 9: 0.2000000000000016. 10: 0.1999999999999899.
;-> 0.3
;-> 5: 0.2999999999999999. 6: 0.3000000000000013. 7: 0.3000000000000013.
;-> 8: 0.2999999999999966. 9: 0.3000000000000047. 10: 0.3000000000000224.
;-> 0.4
;-> 5: 0.3999999999999993. 6: 0.3999999999999993. 7: 0.3999999999999993.
;-> 8: 0.3999999999999993. 9: 0.3999999999999993. 10: 0.399999999999976.
;-> 0.5
;-> 5: 0.4999999999999994. 6: 0.4999999999999994. 7: 0.4999999999999994.
;-> 8: 0.4999999999999994. 9: 0.4999999999999994. 10: 0.4999999999999994.
;-> 0.6
;-> 5: 0.6000000000000001. 6: 0.6000000000000001. 7: 0.6000000000000001.
;-> 8: 0.6000000000000001. 9: 0.6000000000000001. 10: 0.5999999999999658.
;-> 0.7
;-> 5: 0.7000000000000007. 6: 0.7000000000000034. 7: 0.7000000000000034.
;-> 8: 0.699999999999993. 9: 0.699999999999993. 10: 0.6999999999999529.
;-> 0.8
;-> 5: 0.8000000000000007. 6: 0.8000000000000037. 7: 0.8000000000000099.
;-> 8: 0.8000000000000099. 9: 0.8000000000000099. 10: 0.8000000000000099.
;-> 0.9
;-> 5: 0.900000000000002. 6: 0.8999999999999987. 7: 0.8999999999999987.
;-> 8: 0.8999999999999987. 9: 0.8999999999999987. 10: 0.8999999999999987.
;-> 1
;-> 5: 1. 6: 1. 7: 1. 8: 1. 9: 1. 10: 1.
;-> 1.1
;-> 5: 1.1. 6: 1.100000000000008. 7: 1.100000000000008.
;-> 8: 1.099999999999977. 9: 1.099999999999977. 10: 1.099999999999977.
;-> 1.2
;-> 5: 1.199999999999998. 6: 1.199999999999998. 7: 1.199999999999998.
;-> 8: 1.199999999999962. 9: 1.199999999999896. 10: 1.200000000000032.
;-> 1.3
;-> 5: 1.300000000000002. 6: 1.300000000000002. 7: 1.300000000000021.
;-> 8: 1.300000000000021. 9: 1.299999999999946. 10: 1.300000000000092.
;-> 1.4
;-> 5: 1.400000000000001. 6: 1.400000000000012. 7: 1.400000000000029.
;-> 8: 1.400000000000073. 9: 1.400000000000152. 10: 1.400000000000306.
;-> 1.5
;-> 5: 1.499999999999997. 6: 1.499999999999987. 7: 1.500000000000008.
;-> 8: 1.500000000000008. 9: 1.500000000000008. 10: 1.500000000000008.
;-> 1.6
;-> 5: 1.600000000000001. 6: 1.600000000000001. 7: 1.599999999999975.
;-> 8: 1.599999999999975. 9: 1.600000000000068. 10: 1.600000000000068.
;-> 1.7
;-> 5: 1.700000000000003. 6: 1.700000000000003. 7: 1.700000000000003.
;-> 8: 1.700000000000052. 9: 1.700000000000052. 10: 1.700000000000239.
;-> 1.8
;-> 5: 1.800000000000005. 6: 1.800000000000005. 7: 1.800000000000005.
;-> 8: 1.800000000000052. 9: 1.799999999999949. 10: 1.799999999999949.
;-> 1.9
;-> 5: 1.900000000000002. 6: 1.900000000000013. 7: 1.900000000000039.
;-> 8: 1.900000000000039. 9: 1.900000000000144. 10: 1.900000000000357.
;-> 2
;-> 5: 1.999999999999996. 6: 1.999999999999996. 7: 1.999999999999971.
;-> 8: 2.000000000000024. 9: 2.000000000000024. 10: 2.000000000000024.

newLISP utilizza lo standard IEEE 754 per i numeri in virgola mobile e i risultati sono tutti corretti.


----------------------------------------
Stabilità degli algoritmi di ordinamento
----------------------------------------

Un algoritmo di ordinamento si dice stabile se due elementi con chiavi uguali appaiono nello stesso ordine nell'output ordinato come appaiono nella lista di input da ordinare.

Formalmente la stabilità è definita nel modo seguente:

Sia A un array, e sia "<" un ordinamento stretto e debole sugli elementi di A.
Un algoritmo di ordinamento è stabile se:

   i < j e A(i) = A(j) implica P(i) < P(j)

dove P è la permutazione ordinata di A (l'ordinamento che muove A(i) nella posizione P(i)).

Informalmente, stabilità significa che gli elementi uguali mantengono le loro posizioni relative, dopo l'ordinamento:

   input: 1 2 2 3 1
             \ \
  output: 1 1 2 2 3

Quando elementi uguali sono indistinguibili, ad esempio con numeri interi o, più in generale, qualsiasi dato in cui l'intero elemento è la chiave, la stabilità non è un problema. La stabilità non è un problema anche quando tutte le chiavi sono diverse.

Algoritmi di ordinamento stabili: Bubble Sort, Insertion Sort, Merge Sort,...

Algoritmi di ordinamento non stabili: Quick Sort, Heap Sort,...

Vediamo un esempio in cui la stabilità è necessaria:

Data la seguente lista di coppie (nome età):

(("Dave" "A") ("Alice" "B") ("Ken" "A") ("Eric" "B") ("Carol" "A"))

Se ordiniamo questi dati solo in base al nome, è altamente improbabile che anche il risultato venga ordinato/raggruppato in base all'età.

(("Alice" "B") ("Carol" "A") ("Dave" "A") ("Eric" "B") ("Ken" "A"))

Quindi potremmo dover ordinare di nuovo per ottenere anche la lista in base all'età. Ma così facendo, se l'algoritmo di ordinamento non è stabile, potremmo ottenere un risultato come questo

(("Carol" "A") ("Dave" "A") ("Ken" "A") ("Eric" "B") ("Alice" "B"))

La lista è ora ordinata in base all'età, ma non in base ai nomi.

Nella lista ordinata per nome, la coppia ("Alice" "B") era precedente a ("Eric" "B"), ma poiché l'algoritmo di ordinamento non è stabile, l'ordine relativo viene perso.

Se usiamo un algoritmo di ordinamento stabile, il risultato sarebbe:

(("Carol" "A") ("Dave" "A") ("Ken" "A") ("Alice" "B")("Eric" "B"))

In questo caso viene mantenuto l'ordine relativo tra le diverse coppie.
È possibile che l'ordine relativo venga mantenuto in un ordinamento instabile, ma è altamente improbabile.

Vediamo come si comporta la funzione integrata di ordinamento "sort":

(setq aa '(("Dave" "A") ("Alice" "B") ("Ken" "A") ("Eric" "B") ("Carol" "A")))

Ordiniamo per nome:

(setq bb (sort aa))
;-> (("Alice" "B") ("Carol" "A") ("Dave" "A") ("Eric" "B") ("Ken" "A"))

Ordiniamo per classe:

(define (comp x y)
    (<= (last x) (last y)))

(sort bb comp)
;-> (("Carol" "A") ("Dave" "A") ("Ken" "A") ("Alice" "B") ("Eric" "B"))

L'ordinamento è stabile.

Nota: la funzione di ordinamento di newLISP "sort" è stabile se la funzione di comparazione utilizza gli operatori "<=" e/o ">=".

Facciamo un'altra prova:

(setq lst '((eva 24) (luisa 35) (roby 35) (leo 35) (vero 24) (vale 16) (luna 1)))

Ordiniamo per nome:

(sort lst)
;-> ((eva 24) (leo 35) (luisa 35) (luna 1) (roby 35) (vale 16) (vero 24))

Adesso ordiniamo per età:
; Funzione di comparazione
(define (comp x y)
    (<= (last x) (last y)))

(sort lst comp)
;-> ((luna 1) (vale 16) (eva 24) (vero 24) (leo 35) (luisa 35) (roby 35))

L'ordinamento è stabile.


--------------------------------------------
Colorazione di un grafo (m Coloring Problem)
--------------------------------------------

Implementazione in newLISP del problema presentato al sguente indirizoo web:

https://www.geeksforgeeks.org/m-coloring-problem-backtracking-5/

Dato un grafo non orientato e un numero m, determinare se il grafo può essere colorato con al massimo m colori in modo tale che non ci siano due vertici adiacenti del grafo colorati con lo stesso colore.
La colorazione di un grafo significa l'assegnazione di colori a tutti i vertici.

Input:
Un grafo/list 2D [V][V] dove V è il numero di vertici nel grafo e graph[V][V] è la matrice di adiacenza del grafo. Un valore graph[i][j] è 1 se esiste un arco diretto da i a j, altrimenti graph[i][j] è 0.
Un intero m è il numero massimo di colori che possono essere utilizzati.

Output:
Una lista color[V] che dovrebbe avere numeri da 1 a m. color[i] dovrebbe rappresentare il colore assegnato all'i-esimo vertice. Il codice dovrebbe anche restituire "nil" se il grafico non può essere colorato con m colori.

Algoritmo:
Approccio semplice: generare tutte le possibili configurazioni di colori. Poiché ogni nodo può essere colorato utilizzando uno qualsiasi degli m colori disponibili, il numero totale di configurazioni di colore possibili è m^V.
Dopo aver generato una configurazione di colore, controllare se i vertici adiacenti hanno lo stesso colore o meno. Se le condizioni sono soddisfatte, stampare la combinazione e interrompere il ciclo.

Creare una funzione ricorsiva che prende l'indice corrente, il numero di vertici e la lista di colori di output.
Se l'indice corrente è uguale al numero di vertici, allora controllare se la configurazione del colore di output è sicura, ovvero controlla se i vertici adiacenti non hanno lo stesso colore. Se le condizioni sono soddisfatte, allora stampare la configurazione e interrompere.
Assegnare un colore a un vertice (da 1 a m).
Per ogni colore assegnato richiamare ricorsivamente la funzione con l'indice successivo e il numero di vertici
Se una funzione ricorsiva restituisce true, interrompere il ciclo e restituire true.

Questa funzione verifica se la colorazione di un grafo è corretta oppure no:

(define (safe? graph color)
(catch (begin
  ; controlla ogni vertice
  (for (i 0 3)
    ; non deve superare, altrimenti newLISP fa il ciclo lo stesso...
    (if (< (+ i 1) 4)
      (for (j (+ i 1) 3)
        (if (and (= (graph i j) 1) (= (color j) (color i)))
            (throw nil)
        )
      )
    )
  )
  true)))

Questa funzione risolve il problema m-coloring utilizzando la ricorsione.
Restituisce nil se non è possibile assegnare gli m colori, in caso contrario, restituisce true e stampa le assegnazioni dei colori su tutti i vertici.
Si noti che potrebbero esserci più soluzioni, questa funzione stampa una delle soluzioni fattibili.

(define (graph-color graph m i color)
(catch (begin
  (if (= i 4)
    (begin
      ; se la colorazione è corretta...
      (if (safe? graph color)
          (begin
            ; stampa la soluzione e restituisce true
            (println color)
            (throw true)
          )
      )
      (throw nil)
    )
  )
  ; assegna ogni colore da 1 a m
  (for (j 1 m)
    (setf (color i) j)
    ; ricorsione sui vertici rimanenti
    (if (graph-color graph m (+ i 1) color)
        (throw true)
    )
    (setf (color i) 0)
  )
  nil)))

(define (m-color)
  (local (graph m color)
    (setq graph '(
          ( 0 1 1 1 )
          ( 1 0 1 0 )
          ( 1 1 0 1 )
          ( 1 0 1 0 )))
    (setq m 3)
    ;(setq 'color:color '(0 0 0 0))
    (setq color '(0 0 0 0))
    (if (not (graph-color graph m 0 color))
        (println "Solution does not exist")
    )))

(m-color)
;-> (1 2 3 2)

(define (m-color1)
  (local (graph m)
    (setq graph '(
          ( 1 1 1 1 )
          ( 1 1 1 1 )
          ( 1 1 1 1 )
          ( 1 1 1 1 )))
    (setq m 3)
    ;(setq 'color:color '(0 0 0 0))
    (setq color '(0 0 0 0))
    (if (not (graph-color graph m 0 color))
        (println "Solution does not exist")
    )))

(m-color1)
;-> Solution does not exist


-----------
Memoization
-----------

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(memoize fibonacci
    (lambda (n)
        (if(< n 2) 1
            (+  (fibonacci (- n 1))
                (fibonacci (- n 2))))))

(time (println (fibonacci 100)))
;-> 1298777728820984005
;-> 0


------------------------------
Auto-replicazione di una lista
------------------------------

Data una lista con un solo elemento, scrivere una funzione che permette di aggiungere alla lista un elemento dato dalla lista di tutti gli elementi precedenti della lista.

(define (insert-copy lst)
  (if (list? lst)
      (push lst lst -1)
      '()))

(setq lst '(1))
;-> (1)
(setq lst (insert-copy lst))
;-> (1 (1))
(setq lst (insert-copy lst))
;-> (1 (1) (1 (1)))
(setq lst (insert-copy lst))
;-> (1 (1) (1 (1)) (1 (1) (1 (1))))
...

(setq lst '())
;-> ()
(setq lst (insert-copy lst))
;-> (())
(setq lst (insert-copy lst))
;-> (() (()))
(setq lst (insert-copy lst))
;-> (() (()) (() (())))
(setq lst (insert-copy lst))
;-> (() (()) (() (())) (() (()) (() (()))))
(setq lst (insert-copy lst))
;-> (() (()) (() (())) (() (()) (() (()))) (() (()) (() (())) (() (()) (() (())))))
...


------------------
La funzione "sort"
------------------

Definizione dal manuale di riferimento:

*******************
>>> funzione: SORT
*******************
sintassi: (sort list [func-compare])
sintassi: (sort array [func-compare])

Tutti gli elementi della lista o del vettore sono ordinati in ordine crescente. Qualsiasi cosa può essere ordinata, indipendentemente dai tipi. Quando i membri sono essi stessi liste o vettori, ogni elemento viene confrontato in modo ricorsivo. Se vengono confrontate due espressioni di tipo diverso, il tipo inferiore viene ordinato prima del tipo superiore nell'ordine seguente:

Atomi: nil, true, intero o float, stringa, simbolo, primitiva
Liste: espressioni quotate, lista, lambda, lambda-macro

L'ordinamento è distruttivo, modifica l'ordine degli elementi nella lista o nel vettore originale e restituisce la lista o il vettore ordinato. È un merge-sort binario stabile con prestazioni approssimativamente O(n log2 n) che preserva l'ordine degli elementi adiacenti che sono uguali. Quando viene utilizzato func-compare, deve utilizzare gli operatori <= o >= per essere stabile.

È possibile fornire un operatore di confronto opzionale, una funzione definita dall'utente o una funzione anonima. Il funtore o l'operatore può essere fornito con o senza una virgoletta precedente.

(sort '(v f r t h n m j))     → (f h j m n r t v)
(sort '((3 4) (2 1) (1 10)))  → ((1 10) (2 1) (3 4))
(sort '((3 4) "hi" 2.8 8 b))  → (2.8 8 "hi" b (3 4))

(set 's '(k a l s))
(sort s)  → (a k l s)

(sort '(v f r t h n m j) >) → (v t r n m j h f)

(sort s '<)  → (a k l s)
(sort s >)  → (s l k a)
s           → (s l k a)

;; define a comparison function
(define (comp x y)
    (>= (last x) (last y)))

(set 'db '((a 3) (g 2) (c 5)))

(sort db comp)  →  ((c 5) (a 3) (g 2))

;; use an anonymous function
(sort db (fn (x y) (>= (last x) (last y))))

Nota: La funzione sort è distruttiva, nel senso che mosdifica direttamente l'argomento (lista o vettore).

Vediamo alcuni esempi.
Data la seguente lista di punti (x y):

  ((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4))

Ordinamento per la coordinata x crescente:

(setq lst '((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4)))
(sort lst)
;-> ((1 1) (1 3) (2 4) (2 5) (3 2) (4 4) (6 1) (6 3) (6 5) (8 5))

Nota: per x uguali viene ordinata anche la y.

Ordinamento per la coordinata y crescente:
(setq lst '((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4)))
(define (comp x y)
    (<= (last x) (last y)))
(sort lst comp)
;-> ((1 1) (6 1) (3 2) (1 3) (6 3) (4 4) (2 4) (2 5) (8 5) (6 5))

Nota: per y uguali non viene ordinata anche la x.

Ordinamento per la coordinata x crescente e y decrescente:

(setq lst '((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4)))
(define (comp x y)
  (if (= (first x) (first y))
      (>= (last x) (last y))
      (<= (first x) (first y))))
(sort lst comp)
;-> ((1 3) (1 1) (2 5) (2 4) (3 2) (4 4) (6 5) (6 3) (6 1) (8 5))

Ordinamento per x/y crescente (x = numeratore e y = denominatore):

(setq lst '((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4)))
(define (comp x y)
  (< (div (first x) (last x)) (div (first y) (last y))))
(map (fn(x) (div (first x) (last x))) (sort lst comp))
;-> (0.3333333333333333 0.4 0.5 1 1 1.2 1.5 1.6 2 6)
lst
;-> ((1 3) (2 5) (2 4) (4 4) (1 1) (6 5) (3 2) (8 5) (6 3) (6 1))

(setq cs '(("John Backus"  1924 2007)
           ("John Atanasoff" 1903 1995)
           ("Alan Turing" 1912 1954)
           ("John von Neumann" 1903 1957)
           ("Alonzo Church" 1903 1995)
           ("Norbert Wiener" 1894 1964)
           ("Edsger Dijkstra" 1930 2002)
           ("Kenneth Iverson" 1920 2004)
           ("Test 1" 1903 1996)
           ("Test 2" 1903 1904)))

Ordinamento per anno di nascita crescente:

(define (comp x y) (<= (x 1) (y 1)))
(sort cs comp)
;-> (("Norbert Wiener" 1894 1964) 
;->  ("John Atanasoff" 1903 1995) 
;->  ("John von Neumann" 1903 1957)
;->  ("Alonzo Church" 1903 1995)
;->  ("Test 1" 1903 1996)
;->  ("Test 2" 1903 1904)
;->  ("Alan Turing" 1912 1954)
;->  ("Kenneth Iverson" 1920 2004)
;->  ("John Backus" 1924 2007)
;->  ("Edsger Dijkstra" 1930 2002))


Ordinamento per anno di nascita crescente e anno di morte decrescente:

(define (comp x y)
  (if (= (x 1) (y 1))
      (<= (x 2) (y 2))
      (<= (x 1) (y 1))))

(sort cs comp)
;-> (("Norbert Wiener" 1894 1964) 
;->  ("Test 2" 1903 1904)
;->  ("John von Neumann" 1903 1957)
;->  ("John Atanasoff" 1903 1995)
;->  ("Alonzo Church" 1903 1995)
;->  ("Test 1" 1903 1996)
;->  ("Alan Turing" 1912 1954)
;->  ("Kenneth Iverson" 1920 2004)
;->  ("John Backus" 1924 2007)
;->  ("Edsger Dijkstra" 1930 2002))


-----------------
Algoritmo K-Means
-----------------

K-means (MacQueen, 1967) è uno dei più semplici algoritmi di apprendimento non supervisionato (unsupervised learning) che risolvono il noto problema del clustering.
La procedura segue un modo semplice e facile per classificare un dato set di dati attraverso un certo numero di cluster (assume k cluster) fissati a priori.
L'idea principale è definire k centroidi, uno per ogni cluster.
Questi centroidi dovrebbero essere posizionati in modo astuto perché posizioni diverse provocano risultati diversi. Quindi, la scelta migliore è posizionarli il più lontano possibile l'uno dall'altro.
Il passaggio successivo consiste nel prendere ogni punto appartenente a un dato set di dati e associarlo al baricentro più vicino. Quando nessun punto è in sospeso, il primo passaggio è completato e viene eseguito un primo raggruppamento.
A questo punto dobbiamo ricalcolare k nuovi centroidi come baricentri dei cluster risultanti dal passaggio precedente.
Dopo aver ottenuto questi k nuovi centroidi, è necessario eseguire un nuovo legame tra gli stessi set point di dati e il nuovo centroide più vicino. È stato generato un ciclo.
Come risultato di questo ciclo, potremmo notare che i k centroidi cambiano la loro posizione passo dopo passo fino a quando non vengono apportate più modifiche. In altre parole i centroidi non si muovono più.
Infine, questo algoritmo mira a minimizzare una funzione obiettivo, in questo caso una funzione di errore al quadrato. La funzione obiettivo è la seguente:

      k   n
  F = ∑   ∑ |x(i,j)-c(j)|²
     j=1 i=1

dove |x(i,j)-c(j)|², che è la misura della distanza al quadrato tra un punto dati x(i,j) e il centro del cluster c(j), rappresenta un indicatore della distanza degli n punti dati dai rispettivi centri del cluster.

L'algoritmo è composto dai seguenti passaggi:

  1. Posizionare i punti K nello spazio rappresentato dagli oggetti che vengono raggruppati. Questi punti rappresentano i centroidi del gruppo iniziale.

  2. Assegnare ogni oggetto al gruppo che ha il baricentro più vicino.

  3. Quando tutti gli oggetti sono stati assegnati, ricalcolare le posizioni dei centroidi K.

  4. Ripetere i passaggi 2 e 3 finché i centroidi non si muovono più. Ciò produce una separazione degli oggetti in gruppi da cui è possibile calcolare la metrica da minimizzare.

Sebbene si possa dimostrare che la procedura terminerà sempre, l'algoritmo k-means non trova necessariamente la configurazione ottimale, corrispondente al minimo della funzione obiettivo globale. L'algoritmo è anche significativamente sensibile al posizionamento casuale iniziale dei centroidi dei cluster. L'algoritmo k-means può essere eseguito più volte per ridurre questo effetto.

K-means è un semplice algoritmo che è stato adattato per risolvere diversi problemi:

Il clustering è una tecnica ampiamente utilizzata in quasi tutti i domini, dalle banche ai motori di ricerca, dal raggruppamento di documenti alla segmentazione delle immagini, cioè in tutti quei casi in cui abbiamo bisogno di raggruppare gli elementi di un insieme in base alle loro "caratteristiche/affinità"

newLISP mette a disposizioni due funzioni per utilizzare questo algoritmo: "kmeans-train" e "kmeans-query".

***************************
>>> funzione: KMEANS-TRAIN
***************************
sintassi: (kmeans-train matrix-data int-k context [matrix-centroids])

La funzione esegue l'analisi cluster K-means su matrix-data. Tutti gli n record di dati in matrix-data sono partizionati in un numero di int-k gruppi diversi.

Entrambi, i dati della matrice n * m e i centroidi della matrice k * m opzionali possono essere liste nidificate o array bidimensionali.

L'algoritmo Kmeans cerca di ridurre al minimo la somma del quadrato delle distanze interne del cluster (SSQ - sum of squared inner cluster distances) dal centroide del cluster. Ad ogni iterazione i centroidi si avvicinano alla loro posizione finale. In alcuni set di dati, il risultato finale può dipendere dai centroidi iniziali. La giusta scelta dei centroidi iniziali può accelerare il processo ed evitare minimi locali non desiderati.

Quando non vengono forniti i centroidi opzionali con matrix-centroids, "kmeans-train" assegnerà inizialmente un'appartenenza casuale al cluster a ciascuna riga di dati e calcolerà i centroidi iniziali.

"kmeans-train" restituisce un vettore di SSQ totali, la somma del quadrato delle distanze interne dal baricentro all'interno del cluster per tutti i cluster. L'algoritmo di iterazione si interrompe quando il cambio di SSQ da una all'iterazione successiva è inferiore a 1e-10.

Altri risultati dell'analisi vengono memorizzati come liste in variabili di contesto.

L'esempio seguente analizza 20 record di dati che misurano m = 3 caratteristiche e tenta di partizionare i dati in k = 3 cluster. Si potrebbero provare numeri diversi da k = 3. L'obiettivo è un risultato con pochi cluster ad alta densità misurati dalle distanze interne medie dei cluster.

(set 'data '(
(6.57 4.96 11.91)
(2.29 4.18 1.06)
(8.63 2.51 8.11)
(1.85 1.89 0.11)
(7.56 7.93 5.06)
(3.61 7.95 5.11)
(7.18 3.46 8.7)
(8.17 6.59 7.49)
(5.44 5.9 5.57)
(2.43 2.14 1.59)
(2.48 2.26 0.19)
(8.16 3.83 8.93)
(8.49 5.31 7.47)
(3.12 3.1 1.4)
(6.77 6.04 3.76)
(7.01 4.2 11.9)
(6.79 8.72 8.62)
(1.17 4.46 1.02)
(2.11 2.14 0.85)
(9.44 2.65 7.37)))

(kmeans-train data 3 'MAIN:K)
;-> (439.7949357 90.7474276 85.06633163 82.74597619)

; appartenenza ai cluster
; cluster membership
K:labels
;-> (2 3 2 3 1 1 2 1 1 3 3 2 2 3 1 2 1 3 3 2)

; centroidi di ogni cluster
; the centroid for each cluster
K:centroids
;-> ( (6.39 7.188333333 5.935)
;-> (7.925714286 3.845714286 9.198571429)
;-> (2.207142857 2.881428571 0.8885714286) )

La lista di SSQ restituita mostra come in ogni iterazione la somma delle distanze al quadrato interne diminuisce. La lista in K:labels mostra l'appartenenza a ciascun punto dati nello stesso ordine dei dati.

I centroidi in K:centroids possono essere utilizzati per la successiva classificazione di nuovi record di dati utilizzando "kmeans-query". Quando il numero di cluster specificato in int-k è troppo grande, "kmeans-train" produrrà centroidi inutilizzati con dati nan o NaN. Quando sono presenti i centroidi del cluster inutilizzati, il numero in int-k dovrebbe essere ridotto.

La media interna K:deviations dai membri del cluster al loro centroide mostra quanto è denso un cluster. Formalmente, le deviazioni sono calcolate in modo simile alle distanze euclidee e alle deviazioni standard nella statistica convenzionale. La quadratura delle deviazioni e la moltiplicazione di ciascuna per la dimensione del cluster (numero di membri nel cluster) mostra l'SSQ interno di ciascun cluster:

; deviazioni medie interne dei membri del cluster dal centroide
; average inner deviations of cluster members to the centroid
; deviation = sqrt(ssq-of-cluster / n-of-cluster)
K:deviations
;-> (2.457052209 2.260089397 1.240236975)

; calcola gli SSQ interni dalle deviazioni
; calculating inner SSQs from cluster deviations
(map mul '(6 7 7) (map mul K:deviations K:deviations))
;-> (36.22263333 35.75602857 10.76731429) ; inner SSQs

; SSQ dall'ultima iterazione come somma degli SSQ interni
; SSQ from last iteration as sum of inner SSQs
(apply add '(36.22263333 35.75602857 10.76731429))
;-> 82.74597619

K:clusters fornisce gli indici dei record di dati nei dati originali per ciascun cluster. Con questi, i singoli cluster possono essere estratti dai dati per ulteriori analisi:

; lista dei cluster risultanti con gli indici degli elementi nel set di dati
; list with the result clusters with indices into the data set
K:clusters
;-> ( (4 5 7 8 14 16)
;-> (0 2 6 11 12 15 19)
;-> (1 3 9 10 13 17 18) )

; cluster di record di dati etichettati 1 all'offset 0
; cluster of data records labeled 1 at offset 0
(select data (K:clusters 0))
;-> ( (7.56 7.93 5.06)
;-> (3.61 7.95 5.11)
;-> (8.17 6.59 7.49)
;-> (5.44 5.9 5.57)
;-> (6.77 6.04 3.76)
;-> (6.79 8.72 8.62) )

; cluster di record di dati etichettati 2 all'offset 1
; cluster of data records labeled 2 at offset 1
(select data (K:clusters 1))
;-> ( (6.57 4.96 11.91)
;-> (8.63 2.51 8.11)
;-> (7.18 3.46 8.7)
;-> (8.16 3.83 8.93)
;-> (8.49 5.31 7.47)
;-> (7.01 4.2 11.9)
;-> (9.44 2.65 7.37) )

; cluster di record di dati etichettati 3 all'offset 2
; cluster of data records labeled 3 at offset 2
(select data (K:clusters 2))
;-> ( (2.29 4.18 1.06)
;-> (1.85 1.89 0.11)
;-> (2.43 2.14 1.59)
;-> (2.48 2.26 0.19)
;-> (3.12 3.1 1.4)
;-> (1.17 4.46 1.02)
;-> (2.11 2.14 0.85) )

Nell'ultimo esempio ai dati vengono aggiunte le etichette del cluster (da 1 a 3):

; aggiungere un'etichetta del cluster a ciascun record di dati
; append a cluster label to each data record
(set 'labeled-data (transpose (push K:labels (transpose data) -1)))

labeled-data
;-> ( (6.57 4.96 11.91 2)
;-> (2.29 4.18 1.06 3)
;-> (8.63 2.51 8.11 2)
;-> (1.85 1.89 0.11 3)
;-> (7.56 7.93 5.06 1)
;-> (3.61 7.95 5.11 1)
;-> ... ...
;-> (2.11 2.14 0.85 3)
;-> (9.44 2.65 7.37 2) )

Il contesto risultante deve essere preceduto da MAIN quando il codice viene scritto in un contesto di spazio dei nomi. Se il contesto non esiste già, verrà creato.

I risultati in K:labels, K:clusters, K:centroids e K:deviations verranno sovrascritti, se già presenti da un precedente utilizzo di "kmeans-train".

È possibile supportare il training (allenamento) incrementale. Finché il contesto K viene salvato, può continuare ad allenarsi, poiché l'ultimo parametro della funzione "kmeans-train" è quello di ricevere i risultati esistenti.

***************************
>>> funzione: KMEANS-QUERY
***************************
sintassi: (kmeans-query list-data matrix-centroids)
sintassi: (kmeans-query list-data matrix-data)

Nel primo caso, "kmeans-query" calcola le distanze euclidee dal vettore di dati fornito in list-data ai centroidi dati in matrix-centroids. Il vettore di dati in list-data ha m elementi. La lista bidimensionale in matrix-centroids, risultato di un precedente clustering (raggruppamento) con "kmeans-train", ha k righe e m colonne per k centroidi che misurano m caratteristiche.

; centroidi derivanti dall'esecuzione di kmeans-train
; centroids from previous kmeans-train
K:centroids
;-> ( (6.39 7.188333333 5.935)
;-> (7.925714286 3.845714286 9.198571429)
;-> (2.207142857 2.881428571 0.8885714286) )

; distanza dal cluster 1, 2 e 3
(kmeans-query '(1 2 3) K:centroids)
;-> (8.036487279 9.475994267 2.58693657) ; distances to cluster 1, 2 and 3

Il record di dati (1 2 3) mostra la distanza più piccola dal terzo centroide del cluster e sarebbe classificato come appartenente a quel cluster.

Nel secondo caso "kmeans-query" calcola le distanze euclidee da una lista di altri punti che non sono centroidi. L'esempio seguente calcola le distanze del vettore di dati (1 2 3) rispetto a tutti i punti originali dall'analisi dei dati originale di "kmeans-train".

I dati in matrix-data possono essere una lista annidata o un array bidimensionale.

Questo vettore potrebbe essere ordinato per una successiva analisi kNN (k Nearest Neighbor):

(kmeans-query '(1 2 3) data)
;-> (10.91671196 3.190626898 9.19723328 3.014415366 9.079763213
;-> 6.83130295 8.533111976 9.624816881 6.444261013 2.013107051
;-> 3.186549858 9.475199206 9.32936761 2.874786949 7.084638311
;-> 10.96221237 10.50080473 3.162419959 2.423674896 9.526436899)

; mostra le distanze dai membri in ogni cluster
; show distances to members in each cluster

; per il cluster etichettato 1
; for cluster labeled 1
(select (kmeans-query '(1 2 3) data) (K:clusters 0))
;-> (9.079763213 6.83130295 9.624816881 6.444261013 7.084638311 10.50080473)

; per il cluster etichettato 3
; for cluster labeled 2
(select (kmeans-query '(1 2 3) data) (K:clusters 1))
;-> (10.91671196 9.19723328 8.533111976 9.475199206
;->  9.32936761 10.96221237 9.526436899)

; per il cluster etichettato 3
; for cluster labeled 3
(select (kmeans-query '(1 2 3) data) (K:clusters 2))
;-> (3.190626898 3.014415366 2.013107051 3.186549858
;->  2.874786949 3.162419959 2.423674896)

Vediamo che le distanze più piccole sono mostrate per i punti dati nel 3° cluster all'offset 2.

Se il numero di elementi - caratteristiche - nei record di list-data è diverso dal numero di colonne nei dati o nella matrice dei centroidi, allora il più piccolo viene preso per calcolare le distanze euclidee. Ciò è utile quando l'ultima colonna della matrice di dati non contiene dati sulle caratteristiche, ma etichette che identificano l'appartenenza al cluster di un punto.

Nota: potete trovare una spiegazione esaustiva dell'algoritmo K-means al seguente indirizzo web:

https://www.analyticsvidhya.com/blog/2019/08/comprehensive-guide-k-means-clustering/


------------------
Comportamento Lazy
------------------

Per utilizzare funzioni con comportamenti "lazy" (funzioni con stato e generatori) newLISP ha metodi diversi da Scheme e Common LISP:

1) utilizzare i contesti
2) scrivere codice auto-modificante

1) Contesti

(define (fibo:fibo)
    (if-not fibo:m
        (setq fibo:m '(0 1)))
    (pop (push (apply + fibo:m) fibo:m -1))
    (last fibo:m))

(fibo)
;-> 1
(fibo)
;-> 2
(fibo)
;-> 3
(fibo)
;-> 5
(fibo)
;-> 8

2) codice auto-modificante

(define (fib)
    (pop (push (eval (last fib)) (last fib) -1) 1)
    (+ 0 1))

(fib)
;-> 2
(fib)
;-> 3
(fib)
;-> 5
(fib)
;-> 8

fib
;-> (lambda () (pop (push (eval (last fib)) (last fib) -1) 1) (+ 3 5))

L'espressione: (last fib) si riferisce all'espressione: (+ 0 1), che viene modificata sul posto.
Quasi tutte le funzioni distruttive su newLISP possono modificare i dati sul posto. La funzione "setf" non può.

La funzione modificata può essere facilmente serializzata su disco usando: (save "fib.lsp" 'fib).
Si noti che lo stesso sarebbe possibile con la funzione di contesto: (save "fibo.lsp" 'fibo).
Questa funzione non è disponibile con le "closure" (chiusure), dove lo stato modificato di una chiusura di funzione è nascosto e non visibile.

Un altra tecnica è quella della "memoization"

La seguente macro genera uno spazio dei nomi (contesto) per la funzione di destinazione e genera simboli per ogni pattern di chiamata per memorizzare i risultati:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(memoize fibonacci
    (lambda (n)
        (if (< n 2) 1
            (+  (fibonacci (- n 1))
                (fibonacci (- n 2))))))

Senza l'utilizzo della "memoization" la seguente espressione non terminerebbe mai:

(fibonacci 80)
;-> 37889062373143906

(time (fibonacci 80))
;-> 0


---------------
SBCL Mandelbrot
---------------

Programma in linguaggio Steel Bank Common LISP che visualizza il frattale di Mandelbrot:

; sbcl lisp version by mandeep singh

(declaim (optimize (speed 3)))

(defconstant +BAILOUT+ 16)
(defconstant +MAX-ITERATIONS+ 1000)

(defun mandelbrot (x y)
  (declare (type single-float x y))
  (let ((cr (- y 0.5))
        (ci x)
        (zi 0.0)
        (zr 0.0))
    (declare (type single-float cr ci zi zr))
    (do ((i 0 (incf i)))
        (nil)
      (let* ((temp (the single-float (* zr zi)))
             (zr2 (the single-float (* zr zr)))
             (zi2 (the single-float (* zi zi))))
        (declare (type single-float temp zr2 zi2)
                 (type fixnum i))
        (setq zr (the single-float (+ (- zr2 zi2) cr)))
        (setq zi (the single-float (+ temp temp ci)))
        (if (> (the single-float (+ zi2 zr2)) +BAILOUT+)
            (return-from mandelbrot i))
        (if (> i +MAX-ITERATIONS+)
            (return-from mandelbrot 0))))))
(defun main ()
   (let ((tstart)
   (tfinish))
     (setq tstart (get-internal-real-time))
     (do ((y -39 (incf y)))
    ((= (the fixnum y) 39))
       (format t "~%")
       (do ((x -39 (incf x)))
      ((= (the fixnum x) 39))
    (let ((i (mandelbrot (the single-float (/ x 40.0))
               (the single-float (/ y 40.0)))))
      (declare (type fixnum i x y))
        (if (zerop i)
            (format t "*")
            (format t " ")))))
     (format t "~%")
     (setq tfinish (get-internal-real-time))
     (format t "SBCL Elapsed ~,2F~%"
      (coerce (/ (- tfinish tstart) internal-time-units-per-second) 'float))))

(progn
 (main)
 (quit))

Versione newLISP del programma precedente:

;newLISP v.10.0.0
;on Win32 IPv4 UTF-8
(import "kernel32.dll" "GetTickCount")
(set 'BAILOUT 16)
(set 'MAX_ITERATIONS 1000)

(define (iterate x y)
  (let ((cr (sub y 0.5))
       (ci x)
       (zi 0.0)
       (zr 0.0)
       (i 0))
   (while 1
     (inc i 1)
     (set 'temp (mul zr zi))
     (set 'zr2 (mul zr zr))
     (set 'zi2 (mul zi zi))
     (set 'zr  (add cr (sub zr2 zi2)))
     (set 'zi  (add temp temp ci))
     (if (> (add zi2 zr2) BAILOUT)
        (throw i))
     (if (> i MAX_ITERATIONS)
       (throw 0)))))

(define (mandelbrot)
    (let ((t (GetTickCount)))
     (for (y -39 38)
      (for (x -39 38)
         (set 'j (catch (iterate (div x 40.0) (div y 40.0))))
            (if (= j 0.0)
           (print "*")
           (print " ")))
      (print "\n"))
     (println "Time Elapsed: " (- (GetTickCount) t))))

(mandelbrot)
;->                                        *
;->                                        *
;->                                        *
;->                                        *
;->                                        *
;->                                       ***
;->                                      *****
;->                                      *****
;->                                       ***
;->                                        *
;->                                    *********
;->                                  *************
;->                                 ***************
;->                              *********************
;->                              *********************
;->                               *******************
;->                               *******************
;->                               *******************
;->                               *******************
;->                             ***********************
;->                               *******************
;->                               *******************
;->                              *********************
;->                               *******************
;->                               *******************
;->                                *****************
;->                                 ***************
;->                                  *************
;->                                    *********
;->                                        *
;->                                 ***************
;->                             ***********************
;->                          * ************************* *
;->                          *****************************
;->                       * ******************************* *
;->                        *********************************
;->                       ***********************************
;->                     ***************************************
;->                *** ***************************************** ***
;->                *************************************************
;->                 ***********************************************
;->                  *********************************************
;->                  *********************************************
;->                 ***********************************************
;->                 ***********************************************
;->               ***************************************************
;->                *************************************************
;->                *************************************************
;->               ***************************************************
;->               ***************************************************
;->          *    ***************************************************    *
;->        *****  ***************************************************  *****
;->        ****** *************************************************** ******
;->       ******* *************************************************** *******
;->     ***********************************************************************
;->     ********* *************************************************** *********
;->        ****** *************************************************** ******
;->        *****  ***************************************************  *****
;->               ***************************************************
;->               ***************************************************
;->               ***************************************************
;->               ***************************************************
;->                *************************************************
;->                *************************************************
;->               ***************************************************
;->                 ***********************************************
;->                 ***********************************************
;->                   *******************************************
;->                    *****************************************
;->                  *********************************************
;->                 **** ****************** ****************** ****
;->                  ***  ****************   ****************  ***
;->                   *    **************     **************    *
;->                          ***********       ***********
;->                          **  *****           *****  **
;->                           *   *                 *   *
;->
;->
;-> Time Elapsed: 1000

Altra versione di Mandelbrot:

(define (complex:complex
            (r 0)
            (i 0))
    (list complex r i))

(define (complex:rad)
    (set 're (self 1) 'im (self 2))
    (sqrt (add
            (mul re re)
            (mul im im))))

(define (complex:theta)
    (atan (div
            (self 1)
            (self 2))))

(define (complex:add b)
    (complex (add
                (self 1)
                (b 1))
             (add
                (self 2)
                (b 2))))

(define (complex:mul  b)
    (set 'a.re (self 1)
         'a.im (self 2)
         'b.re (b 1)
         'b.im (b 2))
    (complex
         (sub
            (mul a.re b.re)
            (mul a.im b.im))
         (add
            (mul a.re b.im)
            (mul a.im b.re))))

(define (mandelbrot)
    (for (y -2 2 0.02)
        (for (x -2 2 0.02)
            (inc counter)
            (set 'z (complex x y) 'c 126 'a z)
            (while (and
                    (< (abs (:rad (set 'z (:add (:mul z z) a)))) 2)
                    (> (dec c) 32)))
            (print (char c)))
        (println)))

(mandelbrot)


----------------------
La funzione "constant"
----------------------

*********************
>>>funzione CONSTANT
*********************
sintassi: (constant sym-1 exp-1 [sym-2 exp-2] ...)

Identiche funzionalità di "set", "constant" protegge ulteriormente i simboli da successive modifiche. Un simbolo identificato con "constant" può essere modificato solo utilizzando nuovamente la funzione "constant". Quando si tenta di modificare il contenuto di un simbolo protetto con "constant", newLISP genera un messaggio di errore. Solo i simboli del contesto corrente possono essere utilizzati con constant. Ciò impedisce la sovrascrittura di simboli che sono stati protetti nel loro contesto domestico. L'ultimo inizializzatore exp-n è sempre facoltativo.

I simboli inizializzati con "set", "define" o "define-macro" possono comunque essere protetti utilizzando la funzione "constant":

(constant 'aVar 123)  → 123
(set 'aVar 999)
ERR: symbol is protected in function set: aVar

(define (double x) (+ x x))

(constant 'double)

;; equivalente a

(constant 'double (fn (x) (+ x x)))

Il primo esempio definisce una costante, aVar, che può essere modificata solo utilizzando un'altra istruzione "constant". Il secondo esempio protegge double dalla modifica (tranne che per "constant"). Poiché una definizione di funzione in newLISP equivale a un'assegnazione di una funzione lambda, entrambi i passaggi possono essere compressi in uno, come mostrato nell'ultima istruzione. Questa potrebbe essere una tecnica importante per evitare errori di protezione quando un file viene caricato più volte.

L'ultimo valore da assegnare può essere omesso. "constant" restituisce il contenuto dell'ultimo simbolo impostato e protetto.

Le funzioni integrate possono essere assegnate a simboli o ai nomi di altre funzioni integrate, ridefinendole di fatto come funzioni diverse. Non vi è alcuna perdita di prestazioni durante la ridenominazione delle funzioni.

(constant 'squareroot sqrt)  → sqrt <406C2E>
(constant '+ add)            → add <4068A6>

squareroot si comporterà come sqrt. Il + (segno più) viene ridefinito per utilizzare la modalità di aggiunta in virgola mobile di tipo misto. Il numero esadecimale visualizzato nel risultato è l'indirizzo binario della funzione incorporata e varia in base alle piattaforme e ai sistemi operativi.

I simboli protetti con "constant" non possono esssere eliminati:

(constant 'prova 3)
;-> 3
(delete 'prova)
;-> nil
(set 'prova 3)
;-> ERR: symbol is protected in function set : prova
prova
;-> 3

Ecco perché "delete" restituisce "nil" e "prova" 'pippo' è ancora esistente.

Nota: un simbolo definito come "constant" non può essere usato come parametro variabile in una funzione nello stesso contesto.

(constant 'PI 3.1415)
;-> 3.1415

(define (somma a PI) (add a PI))

(somma 10 20)
;-> ERR: symbol is protected : PI
;-> called from user function (somma 10 20)
(somma PI PI)
;-> ERR: symbol is protected : PI
;-> called from user function (somma PI PI)

Il metodo seguente è valido perchè PI non è un parametro della funzione:

(define (somma a b) (add a b))

(somma PI PI)
;-> 6.283

Vediamo un trucco proposto da Lutz:

I questo caso "z" è costante solo nell'ambito dinamico della funzione "trick":
Anche il metodo seguente genera errore:

(define (trick z) (constant 'z 999))
(trick)
;-> ERR: not allowed on local symbol in function constant : z
;-> called from user function (trick)

(setq z 123)
;-> 123


--------------------
La funzione "global"
--------------------

*******************
>>>funzione GLOBAL
*******************
sintassi: (global sym-1 [sym-2 ... ])

Uno o più simboli in sym-1 [sym-2 ... ] possono essere resi globalmente accessibili da contesti diversi da MAIN. L'istruzione deve essere eseguita nel contesto MAIN e solo i simboli appartenenti a MAIN possono essere resi globali. "global" restituisce l'ultimo simbolo reso globale.

(global 'aVar 'x 'y 'z)  → z

(define (foo x)
(...))

(constant (global 'foo))

Il secondo esempio mostra come "constant" e "global" possono essere combinati in un'unica istruzione, proteggendo e rendendo globale una definizione di funzione precedente.


-----------
map e curry
-----------

Alcune volte abbiamo bisogno di passare un argomento alla funzione che viene utilizzata da "map". Ad esempio, supponiamo di voler aggiungere una stringa alla fine di ogni stringa della seguente lista:

(setq lst '("roma" "parigi" "londra"))

Possiamo scrivere una funzione:

(define (add-tail tail str) (append str tail))

(add-tail "-01" "pippo")
;-> "pippo-01"

Adesso per utilizzare la funzione "add-tail" con "map" occorre utilizzare "curry", perchè "add-tail" necessita di un parametro (sempre lo stesso in questo caso):

(map (curry add-tail "-00") lst)
;-> ("roma-00" "parigi-00" "londra-00")

Per numerare in ordine crescente possiamo scrivere:

(map (curry add-tail (string "-0" $idx)) lst)
;-> ("roma-00" "parigi-01" "londra-02")

Un altro esempio riguarda l'uso di "apply". Supponiamo di avere una lista costituita da sottoliste di interi e di voler sommare i numeri di ogni sottolista:

(setq lst '((1 3 5) (7 2 3 1)))

Possiamo scrivere:

(map (fn(x) (apply + x)) lst)
;-> (9 13)

Oppure possiamo usare "curry":

(map (curry apply +) lst)
;-> (9 13)

Nota: la seguente espressione non restituisce il risultato voluto

(map (apply +) lst)
;-> ((1 3 5) (7 2 3 1))

Infatti (apply +) restituisce 0 (come Scheme), e l'espressione mappa 0 in due liste.

(apply +)

Usando un numero come operatore applichiamo il "resting implicito", cioè 0 restituisce l'intera lista:

(0 '(1 2 5))
;-> (1 2 5)

In questo modo possiamo utilizzare "curry".

Il risultato della seguente espressione:

(map (apply *) '((0 1 2) (3 4 5)))
;-> ((1 2) (4 5))

si spiega col fatto che (apply *) restituisce 1 e quindi:

(1 '(0 1 2))
;-> (1 2)

Infine un quiz da Lutz Mueller, spiegare l'output delle seguenti espressioni:

(map 1 '((a b c d) (e f g h) (i j k l)))
;-> ((b c d) (f g h) (j k l))

(map 1 '((1 2) (4 3 2 1) (6 5 4)))
;-> ((2) (3 2 1) (5 4))

(map (curry 1 2) '((a b c d) (e f g h) (i j k l)))
;-> ((b c) (f g) (j k))

(map (curry 1 2) '((1 2) (4 3 2 1) (6 5 4)))
;-> ((2) (3 2) (5 4))

Spiegazione:

"Users Manual and Reference":
(map exp-functor list-args-1 [list-args-2 ... ])
Applica successivamente la funzione primitiva, la funzione definita o l'espressione lambda exp-functor agli argomenti specificati in list-args-1, list-args-2-, restituendo tutti i risultati in una lista.

Quindi le espressioni:

(map 1 '((a b c d) (e f g h) (i j k l)))
(map (curry 1 2) '((a b c d) (e f g h) (i j k l)))

Diventano:

(list (1 '(a b c d)) (1 '(e f g h)) (1 '(i j k l)))
(list ((curry 1 2) '(a b c d)) ((curry 1 2) '(e f g h)) ((curry 1 2) '(e f g h)))

Inoltre, sempre dal manuale,:

Implicit indexing for rest and slice
(Indicizzazione implicita per "rest" e "slice")
È possibile creare forme implicite di "rest" e "slice" anteponendo ad una lista o uno o due numeri per offset e lunghezza.

Quindi:

(1 '(a b c d))  ->  (b c d)
(1 '(e f g h))  ->  (f g h)
(1 '(i j k l))  ->  (j k l)

Inoltre, la funzione curry:

(curry func exp)
Trasforma func da una funzione f(x, y) che accetta due argomenti in una funzione fx(y) che accetta un singolo argomento. curry funziona come una macro in quanto non valuta i suoi argomenti. Vengono invece valutati durante l'applicazione della func.

Quindi:

((curry 1 2) '(a b c d))  ->  (1 2 '(a b c d))  ->  (b c)
((curry 1 2) '(e f g h))  ->  (1 2 '(e f g h))  ->  (f g)
((curry 1 2) '(i j k l))  ->  (1 2 '(i j k l))  ->  (j k)

Inoltre:

Implicit indexing for nth
(Indicizzazione implicita per nth)
Nel Lisp originale, il primo elemento in una lista di s-espressioni viene applicato come funzione agli elementi resto come argomenti. In newLISP, una lista nella posizione functor di una s-espressione presuppone la funzionalità di auto-indicizzazione utilizzando gli argomenti di indice che lo seguono.

Quindi:

(map ''(a b c d) '(3 2 1 0))
;-> (d c b a)

Vedi anche "curry e hayashi" in "Note libere 11"


-------------------------------------
Trasformare la struttura di una lista
-------------------------------------

Data una lista con la seguente struttura:

(setq lst '((1 Olio 2)
            (1 Olio 5)
            (1 Olio 7)
            (2 Gas 4)
            (2 Gas 12)))

Trasformarla nella lista seguente:

'((1 Olio (2 5 7))
  (2 Gas  (4 12)))

Definiamo i seguenti parametri per ogni elemento della lista trasformata (es. (1 Olio 2 5 7)):

id     --> codice univoco = 1
name   --> nome univoco = Olio
values --> lista dei valori (2 5 7)

(define (trasf lst)
  (local (out cur-id cur-name cur-values)
    (sort lst)
    (setq out '())
    (setq cur-id (lst 0 0))
    (setq cur-name (lst 0 1))
    (setq cur-values (list (lst 0 2)))
    (dolist (el lst)
      ; il primo elemento è stato già processato
      (if (> $idx 0)
          (cond ((= (el 0) cur-id) ; stesso elemento del precedente
                 (push (el 2) cur-values -1))
                (true ; elemento diverso dal precedente
                 ; aggiorna la lista soluzione
                 (push (list cur-id cur-name cur-values) out -1)
                 (setq cur-id (el 0)) ; aggiorna id corrente
                 (setq cur-name (el 1)) ; aggiorna name corrente
                 ; reinizializza la lista dei valori
                 (setq cur-values (list (el 2))))
          )
      )
    )
    ; inserisce l'ultimo elemento della lista soluzione
    (push (list cur-id cur-name cur-values) out -1)
    out))

Proviamo la funzione:

(trasf lst)
;-> ((1 Olio (2 5 7)) (2 Gas (4 12)))


----------------------------------------
Elementi duplicati/multipli di una lista
----------------------------------------

Data una lista di numeri interi, creare una nuova lista con solo gli elementi duplicati/multipli della lista originale.

(setq lst '(5 7 1 3 5 2 9 12 6 4 8 5 10 5 5 5 6 6))

(define (multiple lst all)
  (local (out uniq conta)
    (setq out '())
    ; calcola gli elementi unici
    (setq uniq (unique lst))
    ; conta gli elementi
    (setq conta (count uniq lst))
    ; ciclo per estrarre gli elementi con conteggio
    ; maggiore di 1
    (dolist (el conta)
      (if (> el 1)
          (if all
              ; inserisce tutti i valori dell'elemento
              ; multiplo corrente
              ;(push (dup (uniq $idx) el) out -1)
              (extend out (dup (uniq $idx) el))
              ; inserisce solo un valore dell'elemento
              ; multiplo corrente
              (push (uniq $idx) out -1)))
    )
    out))

(multiple lst)
;-> (5 6)

(multiple lst true)
;-> (5 5 5 5 5 5 6 6 6)

Altro metodo (Kazimir Majorinc e cameyo):

(define (multiple2 lst all)
  (if all
      (flat (map dup lst (replace 1 (count lst lst) 0)))
      (unique (flat (map dup lst (replace 1 (count lst lst) 0))))))

(setq lst '(5 7 1 3 5 2 9 12 6 4 8 5 10 5 5 5 6 6))

(multiple2 lst)
;-> (5 6)

(multiple2 lst true)
;-> (5 5 5 5 5 5 6 6 6)

Altro metodo che mantiene l'ordine degli elementi multipli (Kazimir Majorinc):

(define (multiple3 lst)
  (flat (map (lambda(x y)(if (!= y 1)(list x)(list))) lst (count lst lst))))

(multiple3 lst)
;-> (5 5 6 5 5 5 5 6 6)

Vediamo se le funzioni producono risultati uguali:

(setq lst (rand 100 1000))

(= (multiple lst) (multiple2 lst))
;-> true
(= (multiple lst all) (multiple2 lst all))
;-> true

Vediamo la velocità delle funzioni:

(time (multiple lst) 1000)
;-> 342.922
(time (multiple2 lst) 1000)
;-> 497.556

(time (multiple lst true) 1000)
;-> 391.729

(time (multiple2 lst true) 1000)
;-> 401.366

(time (multiple3 lst) 1000)
;-> 463.329


Se invece vogliamo eliminare tutti gli elementi multipli possiamo usare la seguente funzione:

(define (delete-multiple lst)
  (local (out uniq conta)
    (setq out '())
    ; calcola gli elementi unici
    (setq uniq (unique lst))
    ; conta gli elementi
    (setq conta (count uniq lst))
    ; ciclo per estrarre gli elementi con conteggio
    ; maggiore di 1
    (dolist (el conta)
      (if (= el 1)
        ; inserisce il valore dell'elemento singolo (non-multiplo) corrente
        (push (uniq $idx) out -1))
    )
    out))

(setq lst '(1 1 2 3 4 4 5 6))
(delete-multiple lst)
;-> (2 3 5 6)

(setq lst '(5 7 1 3 5 2 9 12 6 4 8 5 10 5 5 5 6 6))
(delete-multiple lst)
;-> (7 1 3 2 9 12 4 8 10)

Il risultato è diverso da quello della funzione "unique":

(unique lst)
;-> (5 7 1 3 2 9 12 6 4 8 10)

(difference (unique lst) (delete-multiple lst))
;-> (5 6)


-------------------
Nome della funzione
-------------------

newLISP non ha una funzione primitiva per conoscere il nome della funzione che si sta eseguendo. Comunque è possibile utilizzare la seguente macro scritta da Cormullion:

(define-macro (define! farg)
  (set (farg 0)
    (letex (func   (farg 0)
            arg    (rest farg)
            arg-p  (cons 'list (map (fn (x) (if (list? x) (first x) x))
                     (rest farg)))
            body   (cons 'begin (args)))
           (lambda
               arg (let (_self 'func) body)))))

La macro serve per definire la nostra funzione:

(define! (f a b c)
   (println "I'm " _self)
   (+ a b c))

(f 7 8 9)
;-> I'm f
;-> 24

(define! (g a b c)
   (println "and I'm " _self)
   (- a b c))

(g 3 2 1)
;-> and I'm g
;-> 0


------------------------
Complessità di una lista
------------------------

Come facciamo a definire la complessità di una lista?

Possiamo identificare alcune caratteristiche come:
- la lunghezza (numero di elementi)
- la struttura/lista degli indici (come è stratificata/annidata)
- massimo livello di annidamento
- tipologia degli elementi
- ...

Prendiamo come esempio la lista seguente:

(setq lst '((1 1 (2)) (3 3 3 (4 5 (4))) 1 ((((((6))))))))

Calcoliamo le caratteristiche elencate sopra:

lunghezza
---------
(length lst)
;-> 4

struttura/lista degli indici
----------------------------
(ref-all nil lst (fn (x) true))
;-> ((0) (0 0) (0 1) (0 2) (0 2 0) (1) (1 0) (1 1) (1 2) (1 3) (1 3 0)
;->  (1 3 1) (1 3 2) (1 3 2 0) (2) (3) (3 0) (3 0 0) (3 0 0 0)
;->  (3 0 0 0 0) (3 0 0 0 0 0)  (3 0 0 0 0 0 0))

Dalla lista degli indici possiamo recuperare tutti gli elementi della lista:

(setq idx (ref-all nil lst (fn (x) true)))
(dolist (el idx) (print (lst el) { }))
;-> (1 1 (2)) 1 1 (2) 2 (3 3 3 (4 5 (4))) 3 3 3 (4 5 (4)) 4 5 (4) 4 1
;-> ((((((6)))))) (((((6))))) ((((6)))) (((6))) ((6)) (6) 6

Possiamo recuperare gli elementi più facilmente con "ref-all":

(ref-all nil lst (fn (x) true) true)
;-> (1 1 (2)) 1 1 (2) 2 (3 3 3 (4 5 (4))) 3 3 3 (4 5 (4)) 4 5 (4) 4 1
;-> ((((((6)))))) (((((6))))) ((((6)))) (((6))) ((6)) (6) 6

Massimo livello di annidamento (by Sammo)
-----------------------------------------
(apply max (map length (ref-all nil lst (fn (x) true))))
;-> 7

Tipologia degli elementi
------------------------
(define (type-of x)
"Get the type of a symbol"
  (let (table '("nil" "true" "int" "float" "string" "symbol" "context"
               "primitive" "import" "ffi" "quote" "list" "lambda"
               "fexpr" "array" "dyn_symbol"))
    (table (& 0xf ((dump x) 1)))))

(dolist (el idx) (print (type-of (lst el)) { }))
;-> list int int list int list int int int list int int
;-> list int int list list list list list list int

Vediamo alcuni esempi:

(setq a '((1 2) ((2 (3)) (4 4)) (((7)))))
(setq b '((1 2) ((2 (3)) (4 4)) (((7)) () ())))
(setq c '((1 2) ((2 (3)) (4 4)) (((7)) () (nil))))

Lista degli indici:
(ref-all nil a (fn (x) true))
;-> ((0) (0 0) (0 1) (1) (1 0) (1 0 0) (1 0 1) (1 0 1 0)
;->  (1 1) (1 1 0) (1 1 1) (2) (2 0) (2 0 0) (2 0 0 0))

Lista dei valori:
(ref-all nil a (fn (x) true) true)
;-> ((1 2) 1 2 ((2 (3)) (4 4)) (2 (3)) 2 (3) 3 (4 4) 4 4 (((7))) ((7)) (7) 7)

Con elementi liste vuote "()":
(setq b '((1 2) ((2 (3)) (4 4)) (((7)) () ())))
(ref-all nil b (fn (x) true))
;-> ((0) (0 0) (0 1) (1) (1 0) (1 0 0) (1 0 1) (1 0 1 0) (1 1)
;->  (1 1 0) (1 1 1) (2) (2 0) (2 0 0) (2 0 0 0) (2 1) (2 2))

Con elementi "nil":
(setq c '((1 2) ((2 (3)) (4 4)) (((7)) () (nil))))
(ref-all nil c (fn (x) true))
;-> ((0) (0 0) (0 1) (1) (1 0) (1 0 0) (1 0 1) (1 0 1 0) (1 1)
;->  (1 1 0) (1 1 1) (2) (2 0) (2 0 0) (2 0 0 0) (2 1) (2 2) (2 2 0))

Se consideriamo le liste come alberi e la complessità è misurata in termini di nodi, rami e foglie (il ramo è il percorso dalla radice alla foglia), possiamo usare le seguenti funzioni:

; by Kazimir Majorinc
;
; Syntax:            (depth <L>) - length of the longest branch
;                    (size <L>)  - number of nodes
;                    (width <L>) - number of leafs
;
; Examples:

(set 'depth (lambda(x)
               ;(println x)
               (cond ((quote? x)(+ 1 (depth (eval x))))
                     ((and (list? x) (empty? x)) 1)
                     ((list? x)(+ 1 (apply max (map depth x))))
                     (true 1))))

(set 'size (lambda(x)
              (+ 1 (cond ((quote? x)(size (eval x)))
                         ((list? x)(apply + (map size x)))
                         (true 0)))))

(set 'width (lambda(x)
              (cond ((quote? x)(width (eval x)))
                    ((list? x)(apply + (map width x)))
                    (true 1))))

(setq lst '((1 1 (2)) (3 3 3 (4 5 (4))) 1 ((((((6))))))))

(depth lst)
;-> 8
(size lst)
;-> 23
(width lst)
;-> 11


------------------------------------------
Eliminare sottoliste da una lista annidata
------------------------------------------

Data la seguente lista:

(set 'planets '(("Mercury"
      (p-name "Mercury")
      (diameter 0.382)
      (mass 0.06)
      (radius 0.387)
      (period 0.241)
      (incline 7)
      (eccentricity 0.206)
      (rotation 58.6)
      (moons 0))
  ("Venus"
      (p-name "Venus")
      (diameter 0.949)
      (mass 0.82)
      (radius 0.72)
      (period 0.615)
      (incline 3.39)
      (eccentricity 0.0068)
      (rotation -243)
      (moons 0))
      ))

Come possiamo eliminare tutti gli elementi "p-name"?

La seguente espressione risolve il problema:

(dolist (item (reverse (ref-all '(p-name *) planets match)))
   (pop planets item))

planets
;-> (("Mercury" (diameter 0.382) (mass 0.06) (radius 0.387) (period 0.241)
;->  (incline 7) (eccentricity 0.206) (rotation 58.6) (moons 0))
;->  ("Venus" (diameter 0.949) (mass 0.82) (radius 0.72) (period 0.615)
;->  (incline 3.39) (eccentricity 0.0068) (rotation -243) (moons 0)))

Dobbiamo utilizzare "pop" su "reverse list" perchè altrimenti potremmo incorrere in "list out of bounds error".

Le funzioni della famiglia "ref" cercano sempre le corrispondenze scorrendo una lista da sinistra a destra,
prima in profondità. Ciò significa che è la rimozione di qualsiasi espressione corrispondente
interessa solo gli indici degli elementi che seguono, indipendentemente dall'annidamento,
anche se le corrispondenze contengono altre corrispondenze in modo ricorsivo.
Considera questo:

(set 'theList '(a (b) (b (b 2) (b (b 3) (b 4)))))
;-> (a (b) (b (b 2) (b (b 3) (b 4))))

(ref-all '(b *) theList match)
;-> ((1) (2) (2 1) (2 2) (2 2 1) (2 2 2))

(pop theList '(2 2 2))
;-> (b 4)

(pop theList '(2 2 1))
;-> (b 3)

(pop theList '(2 2))
;-> (b)

(pop theList '(2 1))
;-> (b 2)

(pop theList '(2))
;-> (b)

(pop theList '(1))
;-> (b)
theList
;-> (a)

viceversa possiamo costruire la lista originale da tutti gli elementi eliminati (popped) e dal vettore degli indici:

(set 'theList '(a (b) (b (b 2) (b (b 3) (b 4)))))

; the list of the index vectors
(set 'indexList (ref-all '(b *) theList match))
;-> ((1) (2) (2 1) (2 2) (2 2 1) (2 2 2))

; the list of all popped items
(set 'popped (map (curry pop theList) (reverse (copy indexList))))
((b 4) (b 3) (b) (b 2) (b) (b))

; after popping out all matches
theList
;-> (a)

; reconstruct the list from popped items starting with residual list
(map (fn (m i) (push m theList i)) (reverse (copy popped)) indexList)
;-> ((a (b)) (a (b) (b)) (a (b) (b (b 2))) (a (b) (b (b 2) (b)))
;->  (a (b) (b (b 2) (b (b 3)))) (a (b) (b (b 2) (b (b 3) (b 4)))))

theList
;-> (a (b) (b (b 2) (b (b 3) (b 4))))

Nota che "reverse" deve essere reso non distruttivo usando "copy".


-------------------------------------
Le funzioni "set-ref" e "set-ref-all"
-------------------------------------

*********************
>>> funzione SET-REF
*********************
sintassi: (set-ref exp-key list exp-replacement [func-compare])

Cerca "exp-key" nella lista e sostituisce l'elemento trovato con "exp-replacement". La lista può essere nidificata. La variabile di sistema $it contiene l'espressione trovata e può essere utilizzata in "exp-replacement". La funzione restituisce la nuova lista modificata.

(set 'data '(fruits (apples 123 44) (oranges 1 5 3)))

(set-ref 'apples data 'Apples)
;-> (fruits (Apples 123 44) (oranges 1 5 3))

data
;-> (fruits (Apples 123 44) (oranges 1 5 3)))

i dati potrebbero essere un identificatore di contesto della funzione di default (funtore) per passare liste per riferimento:

(set 'db:db '(fruits (apples 123 44) (oranges 1 5 3)))

(define (update ct key value)
  (set-ref key ct value))

(update db 'apples 'Apples)
;-> (fruits (Apples 123 44) (oranges 1 5 3))
(update db 'oranges 'Oranges)
;-> (fruits (Apples 123 44) (Oranges 1 5 3))

db:db
;-> (fruits (Apples 123 44) (Oranges 1 5 3))

Per esempi su come utilizzare "func-compare" vedere "set-ref-all".

Per modificare tutte le occorrenze di un elemento in una lista, utilizzare "set-ref-all".

*************************
>>> funzione SET-REF-ALL
*************************
sintassi: (set-ref-all exp-key list exp-replacement [func-compare])

Cerca "exp-key" nella lista e sostituisce ogni istanza dell'elemento trovato con "exp-replacement". La lista può essere nidificata. La variabile di sistema $it contiene l'espressione trovata e può essere utilizzata in "exp-replacement". La variabile di sistema "$count" contiene il numero di sostituzioni effettuate. La funzione restituisce la nuova lista modificata.

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(set-ref-all 'apples data "Apples")
;-> ((monday ("Apples" 20 30) (oranges 2 4 9)) (tuesday ("Apples" 5) (oranges 32 1)))

$count
;-> 2

L'uso del funtore predefinito come lista consente di passare la lista per riferimento a una funzione definita dall'utente contenente un'istruzione set-ref-all. Ciò comporterebbe un minore utilizzo della memoria e velocità più elevate durante le sostituzioni in liste di grandi dimensioni:

(set 'db:db '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(define (foo ctx)
  (set-ref-all 'apples ctx "Apples")
)

(foo db)
;-> ((monday ("Apples" 20 30) (oranges 2 4 9)) (tuesday ("Apples" 5) (oranges 32 1)))

Durante la valutazione di (foo db), l'elenco in db:db verrà passato per riferimento e "set-ref-all" apporterà le modifiche sull'originale, non su una copia di db:db.

Come con "find", "replace", "ref" e "ref-all", le ricerche complesse possono essere espresse usando "match" o "unify" in "func-compare":

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))

(set-ref-all '(oranges *) data (list (first $it) (apply + (rest $it))) match)
;-> ( ... (oranges 15) ... (oranges 33) ... )

L'esempio somma tutti i numeri trovati nei record che iniziano con il simbolo arancione. Gli elementi trovati appaiono in $it.

Vedi anche "set-ref" che sostituisce solo il primo elemento trovato.


------------------------------------
set-ref-all: differenze tra $0 e $it
------------------------------------

Nella funzione set-ref-all la variabile $0 viene impostata solo quando si utilizza un'espressione regolare. Invece $it viene sempre impostata. Il seguente esempio (tutte le stringhe che contengono "m" vengono rese maiuscole) funziona con entrambi $0 e $it:

(set-ref-all ".*m.*" '("abmcd" "defg" "xymzw") (upper-case $0) regex)
;-> ("ABMCD" "defg" "XYMZW")

(set-ref-all ".*m.*" '("abmcd" "defg" "xymzw") (upper-case $it) regex)
;-> ("ABMCD" "defg" "XYMZW")

Quando la regex corrisponde ad una sola parte dell'elemento ("m"), allora $0 e $it si comportano in modo diverso, perché $0 si riferisce solo alla parte dell'elemento che corrisponde e $it si riferisce all'intero elemento:

(set-ref-all "m" '("abmcd" "defg" "xymzw") (upper-case $0) regex)
;-> ("M" "defg" "M")
(set-ref-all "m" '("abmcd" "defg" "xymzw") (upper-case $it) regex)
;-> ("ABMCD" "defg" "XYMZW")

=============================================================================

