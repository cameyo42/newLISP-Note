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
    (println word)
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
    ; risultato in kilometri (km)
    (div (mul 2 radius (asin h-val)) 1000)))

Facciamo alcune prove (il risultato è in kilometri):

(haversine 42.123456 13.123456 54.654321 8.654321)
;-> 1433.443903533894

(haversine 42.123456 -10.123456 54.654321 -2.654321)
;-> 1499.07734482137

(haversine 37.774856 -122.424227 37.864742 -119.537521)
;-> 254.3520794544458

=============================================================================

