================

 NOTE LIBERE 25

================

  L'irrilevanza dell'uomo è superata solo dalla sua tendenza a sopravvalutarsi.

--------------------------------------------
Coppie di resistenze in serie e in parallelo
--------------------------------------------

Abbiamo una lista di resistenze e un valore R di una resistenza.
Utilizzando solo coppie di resistenze (messe in serie o in parallelo) determinare la coppia che più si avvicina ad R.
Se R compare nella lista delle resistenze, allora non serve nessuna coppia.

Coppia di Resistenze in serie:

  R = R1 + R2

Coppia di Resistenze in parallelo:

            1          R1 * R2
  R = ------------- = ---------
       1/R1 + 1/R2     R1 + R2

(define (serie r1 r2) (add r1 r2))
(define (parallelo r1 r2) (div (mul r1 r2) (add r1 r2)))

Funzione che genera tutte le coppie possibili tra gli elementi di una lista:
Se all = true, allora vengono generate anche le coppie con lo stesso elemento.

(define (couples lst all)
"Generates all the couples of a list"
  (let (out '())
    (if all
      (for (i 0 (- (length lst) 1))
        (for (j i (- (length lst) 1))
            (push (list (lst i) (lst j)) out -1)))
      ;else
      (for (i 0 (- (length lst) 2))
        (for (j (+ i 1) (- (length lst) 1))
            (push (list (lst i) (lst j)) out -1))))
    out))

Proviamo:

(couples '(1 2 3 4 5) true)
;-> ((1 1) (1 2) (1 3) (1 4) (1 5)
;->  (2 2) (2 3) (2 4) (2 5)
;->  (3 3) (3 4) (3 5)
;->  (4 4) (4 5)
;->  (5 5))

(couples '(1 2 3 4 5))
;-> ((1 2) (1 3) (1 4) (1 5)
;-> (2 3) (2 4) (2 5)
;-> (3 4) (3 5)
;-> (4 5))

(difference (couples '(1 2 3 4 5) true) (couples '(1 2 3 4 5)))
;-> ((1 1) (2 2) (3 3) (4 4) (5 5))

(couples '(1 2 1 2))
;-> ((1 2) (1 1) (1 2) (2 1) (2 2) (1 2))

(couples '(1 2 1 2) true)
;-> ((1 1) (1 2) (1 1) (1 2) (2 2) (2 1) (2 2) (1 1) (1 2) (2 2))

Funzione che trova il valore più vicino alla resistenza data:

(define (find-resistor R lst)
  (cond
    ((find R lst) (list R))
    (true
      (local (out par ser  min-dist coppie sval pval)
        (setq out '()) (setq par '()) (setq ser '())
        (setq min-dist 1e99)
        ; crea tutte le coppie di resistenze
        (setq coppie (couples lst))
        ; ciclo per ogni coppia...
        (dolist (c coppie)
          ; calcola valore serie coppia corrente e verifica distanza con R
          (setq sval (serie (c 0) (c 1)))
          (when (< (abs (sub R sval)) min-dist)
                (setq min-dist (abs (sub R sval)))
                (setq out (list sval (c 0) (c 1) "-")))
          ; calcolo valore parallelo coppia corrente e verifica distanza con R
          (setq pval (parallelo (c 0) (c 1)))
          (when (< (abs (sub R pval)) min-dist)
                (setq min-dist (abs (sub R pval)))
                (setq out (list pval (c 0) (c 1) "|")))
          ;(push (list (serie (c 0) (c 1)) (c 0) (c 1) "|") ser)
          ;(push (list (parallelo (c 0) (c 1)) (c 0) (c 1) "-") par)
        )
        ;(println (length ser) { } (length par))
        out))))

Proviamo:

(setq lst '(100 150 220 330 470 680 1000 1500 2200 3300 4700))

(find-resistor 510 lst)
;-> (519.4444444444445 680 2200 "|")
(find-resistor 150 lst)
;-> (150)
(find-resistor 250 lst)
;-> (250 100 150 "-")
(find-resistor 2000 lst)
;-> (1970 470 1500 "-")

Vediamo una versione più compatta:

(define (find-R R lst)
  (if (find R lst) (list R)
  ;else
  (let ( (min-dist 1e99) (r1 0) (r2 0) (sval 0) (pval 0) (out '()) )
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (set 'r1 (lst i) 'r2 (lst j))
        (setq sval (add r1 r2))
        (when (< (abs (sub R sval)) min-dist)
              (setq min-dist (abs (sub R sval)))
              (setq out (list sval r1 r2 "-")))
        (setq pval (div (mul r1 r2) (add r1 r2)))
        (when (< (abs (sub R pval)) min-dist)
              (setq min-dist (abs (sub R pval)))
              (setq out (list pval r1 r2 "|")))))
    out)))

Proviamo:

(find-R 510 lst)
;-> (519.4444444444445 680 2200 "|")
(find-R 150 lst)
;-> (150)
(find-R 250 lst)
;-> (250 100 150 "-")
(find-R 2000 lst)
;-> (1970 470 1500 "-")

Vediamo la differenza di velocità tra le due funzioni:

(time (find-resistor 2000 lst) 1e4)
;-> 375.182
(time (find-R 2000 lst) 1e4)
;-> 218.63

Vedi anche "Resistenze in parallelo" su "Note libere 18".


-----------------------------------------------------
La somma di tutti i numeri interi positivi vale -1/12
-----------------------------------------------------

La somma dei numeri interi positivi che vale -1/12 è un risultato famoso e controverso, attribuito a Srinivasa Ramanujan.
Il contesto matematico e la sua interpretazione sono molto particolari, infatti questo risultato proviene dalla teoria delle serie divergenti e dalla teoria delle funzioni zeta di Riemann.

La somma degli interi positivi Sum[n=1..inf](n) = 1 + 2 + 3 + 4 + ... diverge in senso classico, cioè cresce senza limiti.
Tuttavia, in contesti specifici della fisica teorica e della teoria analitica dei numeri, si può assegnare a questa somma un valore finito usando metodi di sommatoria regolare.

Dimostrazione con l'uso di serie
--------------------------------

Definiamo la seguente somma

  A = 1 - 1 + 1 - 1 + 1 - 1 + 1 - 1 + ...

Se sommiamo i primi due termini, otteniamo 0, poi aggiungiamo 1 e otteniamo 1, poi è di nuovo 0, poi 1, ... Quindi, questa somma infinita è il limite della sequenza:

  1, 0, 1, 0, 1, 0, 1, 0, 1, ...

Il modo più naturale per definire questo limite è quello di calcolare le medie:

  1, 1/2, 2/3, 2/4, 3/5, 3/6, ...

  Questa sequenza converge a 1/2, quindi possiamo concludere che A = 1/2.

Prendiamo la seguente somma:

  B = 1 - 2 + 3 - 4 + 5 - 6 + 7 - 8 + ...

  e raddoppiamola:

  2*B =
      = 1 - 2 + 3 - 4 + 5 - 6 + 7 - ... + 0 + 1 - 2 + 3 - 4 + 5 - 6 + 7 - ... =
      = 1 - 1 + 1 - 1 + 1 - 1 + 1 - 1 + ... = A

Quindi:

  B = A/2 = 1/4.

Adesso prendendo la somma di tutti i numeri naturali:

  S = 1 + 2 + 3 + 4 + 5 + 6 + ...

e sottraendo B otteniamo:

  S - B = 1 + 2 + 3 + 4 + 5 + 6 + ... - 1 + 2 - 3 + 4 - 5 + 6 - ... =
        = 0 + 4 + 0 + 8 + 0 + 12 + ... = 4*(1 + 2 + 3 + ...) = 4*S.

Quindi risulta:

  3S = -B = -1/4,  ---->  S = - 1/12.

Nota: questo tipo di manipolazioni con somme divergenti sono vietate nella matematica classica, poiché si possono ottenere rapidamente contraddizioni. Per esempio:

  M = 1 + 1 + 1 + 1 + ...

  0 = N - N =

  = 1 + 1 + 1 + 1 + 1 + 1 + 1 + ... - 0 - 1 - 1 - 1 - 1 - 1 - 1 - 1 - ... =

  = 1 + 0 + 0 + 0 + 0 + 0 + 0 + 0 = 1.

Dimostrazione con l'uso della funzione zeta di Riemann
------------------------------------------------------

La funzione zeta di Riemann Z(s), è definita per Re(s) > 1 dalla serie:

  Z(s) = Sum[n=1..inf] (1/n^s)

Questa funzione può essere estesa analiticamente a tutto il piano complesso, eccetto s = 1, dove ha un polo.
In particolare, Z(-1) ha un valore ben definito:

  Z(-1) = -1\12

Ora, consideriamo la serie divergente:

  S = 1 + 2 + 3 + 4 + ...

Per ottenere questo risultato, possiamo usare una rappresentazione formale collegata alla funzione zeta di Riemann.
Si parte dalla relazione:

  S = Sum[n=1..inf](n)

Ramanujan ha usato tecniche formali e proprietà delle serie per associare a questa somma divergente un valore finito.
La funzione zeta di Riemann fornisce una connessione analitica:

  Z(-1) = Sum[n=1..inf](n^(-(-1)) = Sum[n=1..inf](n) = -1/12

In altre parole, nel contesto della funzione zeta di Riemann e della sua continuazione analitica, si può interpretare la somma degli interi positivi come -1/12.

Nota:
questo risultato non deve essere interpretato nel senso usuale delle somme aritmetiche.
Si tratta di una somma regolarizzata che ha applicazioni in teoria delle stringhe e fisica quantistica, dove si utilizza in contesti matematici molto specifici.


--------------------------------------------
Scambiare a coppie gli elementi di una lista
--------------------------------------------

Data una lista scambiare a coppie il posto degli elementi.
Per esempio:

lista = (1 2 3 4 5 6)
out   = (2 1 4 3 6 5)

lista = (1 2 3 4 5)
out   = (2 1 4 3 5)

Prima versione (ciclo dolist):

(define (scambia-coppie lst)
  (let ((len (length lst))
        (out '()))
    (dotimes (i (/ len 2))
      (extend out (list (lst (+ 1 (* 2 i))) (lst (* 2 i)))))
    (if (zero? (% len 2))
        out
        (push (last lst) out -1))))

Proviamo:

(scambia-coppie '(1 2 3 4 5 6))
;-> (2 1 4 3 6 5)

(scambia-coppie '(1 2 3 4 5))
;-> (2 1 4 3 5)

Seconda versione (explode e map):
Usiamo "explode" per dividere la lista in coppie di elementi, poi usiamo "map" per scambiare gli elementi di ogni coppia.
Se la lista ha un numero dispari di elementi, l'ultimo elemento viene gestito separatamente e aggiunto alla fine della lista risultante.

(define (exchange-couples lst)
  (cond ((zero? (% (length lst) 2))
         (flat (map (fn(x) (list (x 1) (x 0))) (explode lst 2))))
        (true
         (let (single (pop lst -1))
          (push single (flat (map (fn(x) (list (x 1) (x 0))) (explode lst 2))) -1)))))

Proviamo:

(exchange-couples '(1 2 3 4 5 6))
;-> (2 1 4 3 6 5)

(exchange-couples '(1 2 3 4 5))
;-> (2 1 4 3 5)

Vediamo la velocità delle due funzioni:

(time (scambia-coppie (sequence 1 10001)))
;-> 327.829
(time (exchange-couples (sequence 1 10001)))
;-> 0.997

La seconda versione è estremamente più veloce.


--------------------------------------------------------------------------
Determinare se gli elementi di una lista sono tutti diversi o tutti uguali
--------------------------------------------------------------------------

Data una lista determinare se gli elementi sono tutti diversi o tutti uguali (o nessuna delle due).

Una lista ha elementi tutti diversi se è uguale alla lista dei suoi elementi unici.

(define (diversi? lst) (= lst (unique lst)))

Proviamo:

(diversi? '(9 8 1 2 3 4 5 6 7))
;-> true
(diversi? '(1 2 3 4 5 6 7 8 9 9))
;-> nil
(diversi? '(1))
;-> true
(diversi? '())
;-> true

Una lista ha elementi uguali se la sua lunghezza è minore di 2 oppure l'espressione "(apply = lst)" restituisce true.

(define (uguali? lst) (or (< (length lst) 2) (apply = lst)))

Proviamo:

(uguali? '(9 8 1 2 3 4 5 6 7))
;-> nil
(uguali? '(1 1 1 1 1 1 1 1 1))
;-> true
(uguali? '(1))
;-> true
(uguali? '())
;-> true


-----------
Random Sort
-----------

Uno dei metodi più imprevedibili (e lunghi) per ordinare una lista di elementi.

Funzione che verifica se una lista è ordinata in modo crescente:

(define (sorted? lst) (apply <= lst))

Proviamo:

(sorted? '(3 5 2 1))
;-> nil
(sorted? '(1 2 3 5))
;-> true
(sorted? '(1 1 1))
;-> true

Funzione che ordina una lista usando "randomize":

(define (rand-sort lst)
  (let (counter 0)
    (seed (time-of-day) true)
    (until (sorted? lst) (setq lst (randomize lst)) (++ counter))
    (println counter)
    lst))

Proviamo:

(rand-sort '(1 2 3 4))
;-> 0
;-> (1 2 3 4)
(rand-sort '(6 1 4 2 3 7 5))
;-> 5834
;-> (1 2 3 4 5 6 7)
(rand-sort '(8 9 6 1 4 7 2 3 5))
;-> 125803
;-> (1 2 3 4 5 6 7 8 9)
(rand-sort '(5 1 4 2 3 7 6))
;-> 3446
;-> (1 2 3 4 5 6 7)
(rand-sort '(8 9 6 1 4 7 2 5 3))
;-> 208761
;-> (1 2 3 4 5 6 7 8 9)

Vediamo i tempi di esecuzione:

(time (println (rand-sort (randomize (sequence 1 10)))))
;-> 2862463
;-> (1 2 3 4 5 6 7 8 9 10)
;-> 1532.68

(time (println (rand-sort (randomize (sequence 1 15)))))
...fermato dopo 5 minuti...

Nota: i generatori casuali di tipo PRNG hanno un ciclo, quindi non è garantito che vengano considerate tutte le permutazioni (quindi la funzione "rand-sort" potrebbe non terminare mai).

Proviamo con un metodo simile che scambia due elementi casuali per ogni ciclo:

(define (rand-sort2 lst)
  (let ( (counter 0) (len (length lst)) )
    (seed (time-of-day) true)
    (until (sorted? lst)
      (setq idx1 (rand len))
      (setq idx2 (rand len))
      (swap (lst idx1) (lst idx2))
      (++ counter)
    )
    (println counter)
    lst))

Proviamo:

(rand-sort2 '(1 2 3 4))
;-> 0
;-> (1 2 3 4)

(rand-sort2 '(6 1 4 2 3 7 5))
;-> 1344
;-> (1 2 3 4 5 6 7)

(rand-sort2 '(8 9 6 1 4 7 2 3 5))
;-> 692399
;-> (1 2 3 4 5 6 7 8 9)

(rand-sort2 '(5 1 4 2 3 7 6))
;-> 1493
;-> (1 2 3 4 5 6 7)

(rand-sort2 '(8 9 6 1 4 7 2 5 3))
;-> 1810753
;-> (1 2 3 4 5 6 7 8 9)

Vediamo i tempi di esecuzione:

(time (println (rand-sort2 (randomize (sequence 1 10)))))
;-> 2119907
;-> (1 2 3 4 5 6 7 8 9 10)
;-> 789.583

(time (println (rand-sort2 (randomize (sequence 1 15)))))
...fermato dopo 5 minuti...


---------------------------------------------
Quadrati e rettangoli in una griglia di punti
---------------------------------------------

Quanti quadrati e rettangoli ci sono in una griglia di punti N*M (lattice)?

1) Quadrati
Per contare il numero di quadrati in una griglia N*M:
a) Un quadrato può essere di dimensione k * k dove k varia da 1 al minimo tra N e M.
b) Per ciascuna dimensione k, il numero di posizioni in cui un quadrato di dimensione k * k può essere posizionato è (N - k + 1) * (M - k + 1).
Nota: se i quadrati 1x1 non contano, allora k varia da 2 al minimo tra N e M.

Quindi, il numero totale di quadrati è la somma dei quadrati possibili per ciascuna dimensione k:

  Numero di quadrati = Sum[k=1..min(N, M)] (N - k + 1) * (M - k + 1)

2) Rettangoli
Per contare il numero di rettangoli in una griglia N * M:
a) Un rettangolo può essere di dimensione a * b dove a varia da 1 a N e b varia da 1 a M.
b) Il numero di posizioni in cui un rettangolo di dimensione a * b può essere posizionato è (N - a + 1) * (M - b + 1).
Nota: se i rettangoli 1x1 non contano, allora a e b partono da 2.

Il numero totale di rettangoli è quindi dato dalla somma dei rettangoli possibili per tutte le combinazioni di a e b:

  Numero di rettangoli = Sum[a=1..N]Sum[b=1..M] (N - a + 1)*(M - b + 1)

(define (quadrati N M)
  (let ((totale 0))
    (dotimes (k (min N M))
      (++ totale (* (- N k) (- M k))))
    totale))

(define (quadrati N M all)
  (let ((totale 0))
    (dotimes (k (min N M))
      (++ totale (* (- N k) (- M k))))
    ; remove 1x1?
    (if all totale (- totale (* M N)))))


(define (quadrati2 N M all)
  (let ((totale 0))
    (for (k (if all 0 1) (min N M))
      (++ totale (* (- N k) (- M k))))
    totale))

(quadrati 8 8 true)
(quadrati2 8 8 true)
(+ 140 (* 8 8))
(quadrati2 8 8)
(quadrati 3 3)
(quadrati2 3 3)
(quadrati2 3 3 true)

(define (rettangoli N M all)
  (let ((totale 0))
    (dotimes (a N)
      (dotimes (b M)
        (++ totale (* (- N a) (- M b)))))
    ; remove 1x1?
    (if all totale (- totale (* N M)))))

(define (quadrati-rettangoli N M) (list (quadrati N M) (rettangoli N M)))

(quadrati-rettangoli 3 3)

(quadrati-rettangoli 8 8)
;-> (204 1296)

(quadrati-rettangoli 20 20)
;-> (2870 44100)


-------------------------------------------------------------
Base64 encoder-decoder (Funzioni "base64-enc" e "base64-dec")
-------------------------------------------------------------

newLISP primitive functions:

base64-enc        encodes a string into BASE64 format
base64-dec        decodes a string from BASE64 format

***********************
>>>funzione BASE64-ENC
***********************
syntax: (base64-enc str [bool-flag])
The string in str is encoded into BASE64 format.
This format encodes groups of 3 * 8 = 24 input bits into 4 * 8 = 32 output bits, where each 8-bit output group represents 6 bits from the input string.
The 6 bits are encoded into 64 possibilities from the letters A–Z and a–z, the numbers 0–9, and the characters + (plus sign) and / (slash).
The = (equals sign) is used as a filler in unused 3- to 4-byte translations.
This function is helpful for converting binary content into printable characters.

Without the optional bool-flag parameter the empty string "" is encoded into "====".
If bool-flag evaluates to true, the empty string "" is translated into "".
Both translations result in "" when using base64-dec.

The encoded string is returned.

BASE64 encoding is used with many Internet protocols to encode binary data for inclusion in text-based messages (e.g., XML-RPC).

(base64-enc "Hello World")
;-> "SGVsbG8gV29ybGQ="

(base64-enc "")
;-> "===="

(base64-enc "" true)
;-> ""

Note that base64-enc does not insert carriage-return/line-feed pairs in longer BASE64 sequences but instead returns a pure BASE64-encoded string.

For decoding, use the base64-dec function.
newLISP's BASE64 handling is derived from routines found in the Unix curl utility and conforms to the RFC 4648 standard.

***********************
>>>funzione BASE64-DEC
***********************
syntax: (base64-dec str)
The BASE64 string in str is decoded.
Note that str is not verified to be a valid BASE64 string.
The decoded string is returned.

(base64-dec "SGVsbG8gV29ybGQ=")
;-> "Hello World"

For encoding, use the base64-enc function.
newLISP's BASE64 handling is derived from routines found in the Unix curl utility and conforms to the RFC 4648 standard.

Functions written with newLISP:

Function based (100%) on routines written by Peter (March 1, 2004 - PvE)
(obsolete since newLisp 8.4.0)

Base64 encoder
--------------
(define (b64-enc dat)
  (local (BASE64 enc byte2 byte2 byte3 byte4 base1 base2 base3 base4)
    # Setup base64 encode string
    (set 'BASE64 "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/")
    # Initialize result variable to string
    (set 'enc "")
    # Mainloop
    (while (> (length dat) 0)
      # Find ASCII values
      (case (length dat)
        (1  (begin
          (set 'byte1 (char dat))
          (set 'byte2 0)
          (set 'byte3 0)))
        (2  (begin
          (set 'byte1 (char dat))
          (set 'byte2 (char dat 1))
          (set 'byte3 0)))
        (true (begin
          (set 'byte1 (char dat))
          (set 'byte2 (char dat 1))
          (set 'byte3 (char dat 2))
          )))
      # Now create BASE64 values
      (set 'base1 (/ byte1 4))
      (set 'base2 (+ (* (& byte1 3) 16) (/ (& byte2 240) 16)))
      (set 'base3 (+ (* (& byte2 15) 4) (/ (& byte3 192) 64)))
      (set 'base4 (& byte3 63))
      # Find BASE64 characters
      (case (length dat)
        (1  (begin
          (set 'enc (append enc (nth base1 BASE64)))
          (set 'enc (append enc (nth base2 BASE64)))
          (set 'enc (append enc "=="))
          (set 'dat "")))
        (2  (begin
          (set 'enc (append enc (nth base1 BASE64)))
          (set 'enc (append enc (nth base2 BASE64)))
          (set 'enc (append enc (nth base3 BASE64)))
          (set 'enc (append enc "="))
          (set 'dat "")))
        (true (begin
          (set 'enc (append enc (nth base1 BASE64)))
          (set 'enc (append enc (nth base2 BASE64)))
          (set 'enc (append enc (nth base3 BASE64)))
          (set 'enc (append enc (nth base4 BASE64)))
          # Decrease 'dat' with 3 characters
          (set 'dat (slice dat 3)))))
    )
    (string enc))

(b64-enc "Hello World")
;-> "SGVsbG8gV29ybGQ="

Base64 decoder
--------------
(define (b64-dec dat)
  (local (BASE64 res byte1 byte2 byte3 byte4)
    # Setup base64 encode string
    (set 'BASE64 "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/")
    # Initialize result variable to string
    (set 'res "")
    # Mainloop
    (while (> (length dat) 0)
      # Find the indexnumber in the BASE64 definition
      (set 'byte1 (find (nth 0 dat) BASE64))
      (if (= byte1 nil)(set 'byte1 0))
      (set 'byte2 (find (nth 1 dat) BASE64))
      (if (= byte2 nil)(set 'byte2 0))
      (set 'byte3 (find (nth 2 dat) BASE64))
      (if (= byte3 nil)(set 'byte3 0))
      (set 'byte4 (find (nth 3 dat) BASE64))
      (if (= byte4 nil)(set 'byte4 0))
      # Recalculate to ASCII value
      (set 'res (append res (char (+ (* (& byte1 63) 4) (/ (& byte2 48) 16)))))
      (set 'res (append res (char (+ (* (& byte2 15) 16) (/ (& byte3 60) 4)))))
      (set 'res (append res (char (+ (* (& byte3 3) 64) byte4))))
      # Decrease string with 4
      (set 'dat (slice dat 4)))
    # Resulting string
    (string res)))

(b64-dec "SGVsbG8gV29ybGQ=")
;-> "Hello World"


------------------------------
Puzzle esagonale di Aristotele
------------------------------

Il puzzle dei numeri di Aristotele consiste nel popolare ciascuna delle 19 celle di una griglia esagonale con un numero intero unico compreso tra 1 e 19 in modo tale che il totale lungo ciascun asse sia 38.

Puzzle esagonale di Aristotele

    a b c
   d e f g
  h i j k l
   m n o p
    q r s

Matematicamente il problema consiste nel trovare la soluzione al seguente sistema di 19 incognite:

          (a + b + c) == 38
      (d + e + f + g) == 38
  (h + i + j + k + l) == 38
      (m + n + o + p) == 38
          (q + r + s) == 38
          (a + d + h) == 38
      (b + e + i + m) == 38
  (c + f + j + n + q) == 38
      (g + k + o + r) == 38
          (l + p + s) == 38
          (c + g + l) == 38
      (b + f + k + p) == 38
  (a + e + j + o + s) == 38
      (d + i + n + r) == 38
          (h + m + q) == 38

Non possiamo generare tutte le permutazioni perchè sono troppe (19! = 121645100408832000).

Proviamo con un approccio casuale.
Generiamo casualmente una associazione di valori tra l'insieme (a..s) e l'insieme (1..19), poi verifichiamo se è una soluzione.

(define (aristotele-rnd iter)
  (local (numbers solution)
    (seed (time-of-day))
    (setq numbers (sequence 1 19))
    (setq solution '(a b c d e f g h i j k l m n o p q r s))
    (for (i 1 iter)
      ; genera i numeri casuali da 1 a 19
      (setq numbers (randomize numbers))
      ; assegna i valori casuali alle variabili a, b, c, ... s
      (map set solution numbers)
      ; verifica se i valori correnti sono una soluzione
      (when (and (= (+ a b c) 38)
                (= (+ d e f g) 38)
                (= (+ h i j k l) 38)
                (= (+ m n o p) 38)
                (= (+ q r s) 38)
                (= (+ a d h) 38)
                (= (+ b e i m) 38)
                (= (+ c f j n q) 38)
                (= (+ g k o r) 38)
                (= (+ l p s) 38)
                (= (+ c g l) 38)
                (= (+ b f k p) 38)
                (= (+ a e j o s) 38)
                (= (+ d i n r) 38)
                (= (+ h m q) 38))
        (println numbers)))))

Proviamo:

(time (aristotele-rnd 1e7))
;-> 15521.615

(time (aristotele-rnd 1e8))

Nessuna soluzione casuale...

Proviamo ad implementare un approccio di backtracking per cercare la soluzione passo dopo passo.
Questo approccio è più efficiente rispetto alla generazione di tutte le permutazioni, poiché costruisce la soluzione progressivamente e verifica i vincoli lungo il percorso.

Funzione che controlla se la configurazione corrente in 'solution' soddisfa i vincoli delle equazioni.
La verifica tiene conto di possibili valori 'nil' presenti durante la costruzione della soluzione.

(define (valid? solution)
  (let ((a (solution 0)) (b (solution 1)) (c (solution 2))
        (d (solution 3)) (e (solution 4)) (f (solution 5)) (g (solution 6))
        (h (solution 7)) (i (solution 8)) (j (solution 9)) (k (solution 10))
        (l (solution 11)) (m (solution 12)) (n (solution 13)) (o (solution 14))
        (p (solution 15)) (q (solution 16)) (r (solution 17)) (s (solution 18)))
    (and
      (or (nil? a) (nil? b) (nil? c) (= (+ a b c) 38))
      (or (nil? d) (nil? e) (nil? f) (nil? g) (= (+ d e f g) 38))
      (or (nil? h) (nil? i) (nil? j) (nil? k) (nil? l) (= (+ h i j k l) 38))
      (or (nil? m) (nil? n) (nil? o) (nil? p) (= (+ m n o p) 38))
      (or (nil? q) (nil? r) (nil? s) (= (+ q r s) 38))
      (or (nil? a) (nil? d) (nil? h) (= (+ a d h) 38))
      (or (nil? b) (nil? e) (nil? i) (nil? m) (= (+ b e i m) 38))
      (or (nil? c) (nil? f) (nil? j) (nil? n) (nil? q) (= (+ c f j n q) 38))
      (or (nil? g) (nil? k) (nil? o) (nil? r) (= (+ g k o r) 38))
      (or (nil? l) (nil? p) (nil? s) (= (+ l p s) 38))
      (or (nil? c) (nil? g) (nil? l) (= (+ c g l) 38))
      (or (nil? b) (nil? f) (nil? k) (nil? p) (= (+ b f k p) 38))
      (or (nil? a) (nil? e) (nil? j) (nil? o) (nil? s) (= (+ a e j o s) 38))
      (or (nil? d) (nil? i) (nil? n) (nil? r) (= (+ d i n r) 38))
      (or (nil? h) (nil? m) (nil? q) (= (+ h m q) 38)))))

Funzione che implementa il backtracking.
A ogni passo, prova a inserire un numero non ancora usato in 'solution' e verifica se la configurazione parziale è valida.
Se sì, continua con il prossimo indice.
Se no, rimuove il numero e prova il successivo.

(define (search-idx idx)
  (if (= idx 19)
      (when (valid? solution) (println solution))
      (dolist (num nums)
        (unless (member num solution)
          (setf (nth idx solution) num)
          (when (valid? solution)
            (search-idx (+ idx 1)))
          (setf (nth idx solution) nil)))))

Funzione che cerca le soluzioni del problema di Aristotele:

(define (aristotele-back rnd)
  (let ( (nums (sequence 1 19))   ; numbers from 1 to 19
         ;(nums (sequence 19 1)))  ; numbers from 19 to 1
         (solution (dup nil 19)) ) ; list of solution's elements
        ; start with a random sequence of numbers
        (when rnd
          (seed (time-of-day))
          (setq nums (randomize nums)))
    (search-idx 0)))

Proviamo:

(aristotele-back)
;-> (3 17 18 19 7 1 11 16 2 5 6 9 12 4 8 14 10 13 15)
;-> (3 19 16 17 7 2 12 18 1 5 4 10 11 6 8 13 9 14 15)
;-> (9 11 18 14 6 1 17 15 8 5 7 3 13 4 2 19 10 12 16)
;-> (9 14 15 11 6 8 13 18 1 5 4 10 17 7 2 12 3 19 16)
... fermato dopo 5 minuti.

Abbiamo trovato 4 soluzioni.

(aristotele-back true)
;-> (15 14 9 13 8 6 11 10 4 5 1 18 12 2 7 17 16 19 3)
;-> (15 13 10 14 8 4 12 9 6 5 2 16 11 1 7 19 18 17 3)
... fermato dopo 5 minuti.

Abbiamo trovato altre 2 soluzioni.

Altre 2 soluzioni partendo con: (nums (sequence 19 1))

;-> (18 17 3 11 1 7 19 9 6 5 2 16 14 8 4 12 15 13 10)
;-> (18 11 9 17 1 6 14 3 7 5 8 15 19 2 4 13 16 12 10)
... fermato dopo 5 minuti.

Lista di tutte le soluzioni:

  3 17 18 19 7 1 11 16 2 5 6 9 12 4 8 14 10 13 15
  3 19 16 17 7 2 12 18 1 5 4 10 11 6 8 13 9 14 15
  9 11 18 14 6 1 17 15 8 5 7 3 13 4 2 19 10 12 16
  9 14 15 11 6 8 13 18 1 5 4 10 17 7 2 12 3 19 16
  10 12 16 13 4 2 19 15 8 5 7 3 14 6 1 17 9 11 18
  10 13 15 12 4 8 14 16 2 5 6 9 19 7 1 11 3 17 18
  15 13 10 14 8 4 12 9 6 5 2 16 11 1 7 19 18 17 3
  15 14 9 13 8 6 11 10 4 5 1 18 12 2 7 17 16 19 3
  16 12 10 19 2 4 13 3 7 5 8 15 17 1 6 14 18 11 9
  16 19 3 12 2 7 17 10 4 5 1 18 13 8 6 11 15 14 9
  18 11 9 17 1 6 14 3 7 5 8 15 19 2 4 13 16 12 10
  18 17 3 11 1 7 19 9 6 5 2 16 14 8 4 12 15 13 10


--------------
Numeri pratici
--------------

Un numero n si dice pratico quando tutti i numeri interi positivi m < n si possono scrivere in almeno una maniera come somma di divisori distinti di n.

Sequenza OEIS: A005153
Practical numbers: positive integers m such that every k <= sigma(m) is a sum of distinct divisors of m. Also called panarithmic numbers.
  1, 2, 4, 6, 8, 12, 16, 18, 20, 24, 28, 30, 32, 36, 40, 42, 48, 54, 56,
  60, 64, 66, 72, 78, 80, 84, 88, 90, 96, 100, 104, 108, 112, 120, 126, 128,
  132, 140, 144, 150, 156, 160, 162, 168, 176, 180, 192, 196, 198, 200, 204,
  208, 210, 216, 220, 224, 228, 234, 240, 252, ...

Il problema centrale è scrivere una funzione che verifica se un dato numero N può essere espresso come somma di alcuni o tutti i numeri contenuti in una data lista:

Creiamo una lista dp di lunghezza N+1 e la inizializziamo con nil.
(Questa lista conterrà true in posizione 'i' se possiamo ottenere la somma 'i' usando i numeri della lista, altrimenti conterrà nil.)

Creiamo una lista used-numbers di lunghezza N+1 inizializzata con nil.
(Questa lista terrà traccia dei numeri utilizzati per ottenere ogni somma parziale.)

Impostiamo dp[0] a true perché la somma 0 può sempre essere ottenuta con la somma di zero numeri.

Aggiornamento della lista dp:
per ogni numero nella lista, aggiorniamo la lista dp per riflettere le nuove somme che possono essere ottenute includendo quel numero.

(Per determinare quali numeri della lista sommano a N, tracciamo le somme parziali durante l'aggiornamento della tabella dp e mantenere una lista 'used-numbers' che tiene traccia dei numeri utilizzati per ottenere ciascuna somma.)

Il ciclo for decrementa la variabile i da N fino a 0.
La condizione and (>= i num) (dp (- i num)) verifica che possiamo ottenere la somma i includendo num.
Se la condizione è vera, impostiamo dp[i] a true e aggiorniamo used-numbers[i] con num e la lista di numeri che hanno portato alla somma i - num.

Al termine restituiamo dp[N] e used-numbers:
  dp[N] può essere true oppure nil.
  used-numbers: può contenere la lista dei numeri che sommano a N oppure nil.

Funzione che verifica se un dato numero N può essere espresso come somma di alcuni o tutti i numeri contenuti in una data lista:

(define (sum-N-from-list? numbers N)
  (let ((dp (dup nil (+ N 1)))
        (used-numbers (dup nil (+ N 1))))
    (setf (dp 0) true)
    (dolist (num numbers)
      (for (i N 0 -1)
        (if (and (>= i num) (dp (- i num)))
          (begin
            (setf (dp i) true)
            (if (not (used-numbers i))
              (if (used-numbers (- i num))
                (setf (used-numbers i) (append (used-numbers (- i num)) (list num)))
                (setf (used-numbers i) (list num))))))))
    (list (dp N) (used-numbers N))))

Proviamo:

(setq lst '(3 34 4 12 5 2))

(sum-N-from-list? lst 9)
;-> (true (4 5))

(sum-N-from-list? lst 35)
;-> (nil nil)

(sum-N-from-list? lst 3)
;-> (true (3))

(sum-N-from-list? lst 0)
;-> (true nil)

(sum-N-from-list? '(1 1 1 1 1 1) 6)
;-> (true (1 1 1 1 1 1))

(sum-N-from-list? '(1 1 1 1 1 1) 5)
;-> (true (1 1 1 1 1))

(sum-N-from-list? '(1 2 3 4 6) 12)
;-> (true (1 2 3 6))

Comunque, in questo caso, a noi interessa solo se N può essere rappresentato come somma e non la lista dei numeri della somma, quindi restituiamo solo dp[N].

(define (sum-N-from-list? numbers N)
  (let ((dp (dup nil (+ N 1)))
        (used-numbers (dup nil (+ N 1))))
    (setf (dp 0) true)
    (dolist (num numbers)
      (for (i N 0 -1)
        (if (and (>= i num) (dp (- i num)))
          (begin
            (setf (dp i) true)
            (if (not (used-numbers i))
              (if (used-numbers (- i num))
                (setf (used-numbers i) (append (used-numbers (- i num)) (list num)))
                (setf (used-numbers i) (list num))))))))
    (dp N)))

Nota: vedi "Numeri weird (strani)" su "Note libere 25" per una funzione "sum-N-from-list?" molto più veloce che usa i vettori.

Poi ci serve la funzione che calcola i divisori di un numero:

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn ( (fattori (factor num))
            (unici (unique fattori)) )
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

(divisors 32)
;-> (1 2 4 8 16 32)

Funzione che verifica se un dato numero è pratico:
(setq N 5)

(define (pratico? N)
  (let (divisori (divisors N))
    (for-all (fn(x) (sum-N-from-list? divisori x)) (sequence 1 (- N 1)))))

Proviamo:

(pratico? 5)
;-> nil

(pratico? 12)
;-> true

Calcoliamo i numeri pratici fino a 252:

(filter pratico? (sequence 1 252))
;-> (1 2 4 6 8 12 16 18 20 24 28 30 32 36 40 42 48 54 56
;->  60 64 66 72 78 80 84 88 90 96 100 104 108 112 120 126 128
;->  132 140 144 150 156 160 162 168 176 180 192 196 198 200 204
;->  208 210 216 220 224 228 234 240 252)

La funzione è molto lenta:

(time (println (filter pratico? (sequence 1 1e3))))
;-> (1 2 4 6 8 12 16 18 20 24 28 30 32 36 40 42 48 54 56 60 64 66 72 78
;->  80 84 88 90 96 100 104 108 112 120 126 128 132 140 144 150 156 160
;->  162 168 176 180 192 196 198 200 204 208 210 216 220 224 228 234 240
;->  252 256 260 264 270 272 276 280 288 294 300 304 306 308 312 320 324
;->  330 336 340 342 348 352 360 364 368 378 380 384 390 392 396 400 408
;->  414 416 420 432 440 448 450 456 460 462 464 468 476 480 486 496 500
;->  504 510 512 520 522 528 532 540 544 546 552 558 560 570 576 580 588
;->  594 600 608 612 616 620 624 630 640 644 648 660 666 672 680 684 690
;->  696 700 702 704 714 720 726 728 736 740 744 750 756 760 768 780 784
;->  792 798 800 810 812 816 820 828 832 840 858 860 864 868 870 880 882
;->  888 896 900 912 918 920 924 928 930 936 952 960 966 968 972 980 984
;->  990 992 1000)
;-> 474867.061 ; quasi 8 minuti

Dal punto di vista matematico si può dimostrare che, data la scomposizione di N in fattori primi p(i) di molteplicità a(i), il numero N è pratico se risulta:

  a) p(1) = 2
                                   p(j)^(a(j)+1) - 1
  b) p(i) < 1 + Prod[j=1..(i-1)](---------------------), per i = 2,..,k
                                       p(j) - 1

dove p(i) e a(i) sono i fattori primi e le relative molteplicità della scomposizione di N:

  N = p(1)^a(1) * p(1)^a(1) * ... * p(k)^a(k)

(define (pratic? N)
  (if (= N 1) ; 1 è un numero pratico
    true
    ;else
    (local (fatt len stop p a prod)
    ; scomposizione di N in fattori primi con relativa moltplicità
    (setq fatt (factor-group N))
    ; inserisce '(1 1) per comodità
    (push '(1 1) fatt)
    ; calcolo del numero dei fattori
    (setq len (length fatt))
    (cond
      ((= len 2) ; se ci sono solo due fattori, allora verifica se p(1) = 2
        (if (= (fatt 1 0) 2) true nil))
      (true
        (if (!= (fatt 1 0) 2) ; se p(1) è diverso da 2, allora N non è pratico
            nil
            ;else ; se p(1) = 2, allora verifica gli altri fattori
            (begin
              (setq stop nil)
              (for (i 2 (- len 1) 1 stop)
                (setq p (fatt i 0))
                (setq a (fatt i 1))
                (setq prod 1)
                (for (j 1 (- i 1))
                  (setq prod (mul prod
                             (div (sub (pow (fatt j 0) (+ (fatt j 1) 1)) 1)
                                  (sub (fatt j 0) 1))))
                  ;(println i { } j { } prod)
                )
                ;(println p { } (+ 1 prod))
                ; condizione da verificare per essere un numero pratico
                (when (> p (+ 1 prod)) (setq stop true))
              )
              (not stop))))))))

Proviamo:

(pratic? 5)
;-> nil

(pratico? 12)
;-> true

Calcoliamo i numeri pratici fino a 252:

(filter pratic? (sequence 1 252))
;-> (1 2 4 6 8 12 16 18 20 24 28 30 32 36 40 42 48 54 56
;->  60 64 66 72 78 80 84 88 90 96 100 104 108 112 120 126 128
;->  132 140 144 150 156 160 162 168 176 180 192 196 198 200 204
;->  208 210 216 220 224 228 234 240 252)

Vediamo se le due funzioni producono risultati identici:

(= (filter pratic? (sequence 1 252)) (filter pratico? (sequence 1 252)))
;-> true

Vediamo la velocità della funzione "pratic?":

(time (println (filter pratic? (sequence 1 1e3))))
;-> (1 2 4 6 8 12 16 18 20 24 28 30 32 36 40 42 48 54 56 60 64 66 72 78
;->  80 84 88 90 96 100 104 108 112 120 126 128 132 140 144 150 156 160
;->  162 168 176 180 192 196 198 200 204 208 210 216 220 224 228 234 240
;->  252 256 260 264 270 272 276 280 288 294 300 304 306 308 312 320 324
;->  330 336 340 342 348 352 360 364 368 378 380 384 390 392 396 400 408
;->  414 416 420 432 440 448 450 456 460 462 464 468 476 480 486 496 500
;->  504 510 512 520 522 528 532 540 544 546 552 558 560 570 576 580 588
;->  594 600 608 612 616 620 624 630 640 644 648 660 666 672 680 684 690
;->  696 700 702 704 714 720 726 728 736 740 744 750 756 760 768 780 784
;->  792 798 800 810 812 816 820 828 832 840 858 860 864 868 870 880 882
;->  888 896 900 912 918 920 924 928 930 936 952 960 966 968 972 980 984
;->  990 992 1000)
;-> 0


============================================================
-------------
Il Gioco 2048
-------------

A 2048 si gioca su una semplice griglia di formato 4×4 in cui scorrono caselle di colori diversi, con numeri diversi (tutti i numeri sono potenze di 2), senza intralci quando un giocatore le muove.
All'inizio delgioco nella griglia ci sono solo due caselle con il numero 2, tutte le altre caselle valgono 0.
Il gioco usa alcuni tasti della tastiera per spostare tutte le caselle a sinistra o a destra oppure in alto o in basso.
Se due caselle contenenti lo stesso numero si scontrano mentre si muovono, si fondono in un'unica casella che avrà come numero la somma delle due tessere.
Ad ogni turno, una nuova tessera con il valore di 2 o 4 apparirà in modo casuale in una casella vuota dela griglia.
Il punteggio del giocatore inizia da zero e viene incrementato ogni volta che due tessere si combinano, con il valore della nuova casella.
La partita è vinta quando, continuando a combinare le tessere, si riesce a crearne una con il numero 2048.
Il gioco può anche continuare oltre, fino a un limite massimo teorico di 131072.
La partita è persa se il giocatore non può più modificare la griglia (perché non ci sono più spazi vuoti o non ci sono numeri adiacenti con lo stesso valore).

Funzione che stampa la griglia di gioco:

(define (print-grid matrix)
  (local (row col)
    (setq row (length matrix))
    (setq col (length (matrix 0)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format "%4d " (matrix i j)))
      )
      (println)) '>))

(setq grid '((2 2048 16 0) (0 512 4 0) (2 0 16 64) (64 4 0 8)))
(print-grid grid)
;->    2 2048   16    0
;->    0  512    4    0
;->    2    0   16   64
;->   64    4    0    8

Funzione che inizia un nuovo gioco:

(define (new-game)
  (setq N 4)
  ; griglia di gioco (matrice)
  (setq grid (array-list (array N N '(0))))
  ; lista delle coordinate della griglia
  (setq pts '())
  (for (i 0 (- N 1))
    (for (j 0 (- N 1))
      (push (list i j) pts -1)))
  ; inserisce il valore 2 in due caselle della griglia scelte a caso
  (setq pts (randomize pts))
  (setf (grid (pts 0)) 2)
  (setf (grid (pts 1)) 2)
  ;(setf (grid 0 0) 1024)
  ;(setf (grid 1 0) 1024)
  ; griglia precedente
  (setq old grid)
  ; numero mosse
  (setq mosse 0)
  ; punteggio
  (setq punti 0)
  (input))

Tasti freccia:      W
                  A S D

"W" or "w" Up    (87/119)
"A" or "a" Left  (65/97)
"S" or "s" Down  (85/115)
"D" or "d" Right (68/100)

Funzione che permette l'input dell'utente e controlla il l'andamento del gioco:
(Premere "0" per uscire dal gioco)

(define (input)
  (println "Mosse: " mosse)
  (println "Punti: " punti)
  (print-grid grid)
  (setq key (read-key))
  ;(println key { } (char key))
  (case key
    (87 (up))    (119 (up))
    (65 (left))  (97  (left))
    (85 (down))  (115 (down))
    (68 (right)) (100 (right))
    (48 (exit)) ; "0" --> esce dal gioco
    (true (begin (println "Tasto errato.") (setq error true)))
  )
        ; vinto?
  (cond ((ref 2048 grid) (println "Hai vinto."))
        ; premuto un tasto errato
        ((= error true) (setq error nil) (input))
        ; perso?
        ;((= grid old) (println "Hai perso."))
        (true ; il gioco continua con il prossimo turno
          ; Inserisce una nuova casella (2 o 4) nella griglia
          ; lista delle coordinate vuote
          (setq pts '())
          (for (i 0 (- N 1))
            (for (j 0 (- N 1))
              (if (zero? (grid i j)) (push (list i j) pts -1))))
          ; inserisce il valore 2 0 4 in una casella vuota (casuale)
          (when (> (length pts) 0)
            (setq pts (randomize pts))
            (if (zero? (rand 2))
                (setf (grid (pts 0)) 2)
                (setf (grid (pts 0)) 4)))
          ; input utente
          (input))))

Funzioni per spostare tutti i numeri di una riga diversi da zero a destra e a sinistra (al posto dei numeri spostati viene inserito 0):

(define (shift-right row)
  (let ((non-zero (filter (fn (x) (!= x 0)) row))
        (zeroes (filter (fn (x) (= x 0)) row)))
    (extend zeroes non-zero)))

(define (shift-left row)
  (let ((non-zero (filter (fn (x) (!= x 0)) row))
        (zeroes (filter (fn (x) (= x 0)) row)))
    (extend non-zero zeroes)))

Funzioni per spostare tutti i numeri di una griglia (matrice) diversi da zero a destra, a sinistra, in alto e in basso (al posto dei numeri spostati viene inserito 0):

(define (matrix-right matrix) (map shift-right matrix))

(define (matrix-left matrix) (map shift-left matrix))

(define (matrix-down matrix)
  (let (trans (transpose matrix))
    (transpose (map shift-right trans))))

(define (matrix-up matrix)
  (let (trans (transpose matrix))
    (transpose (map shift-left trans))))

Nota: per "matrix-up" e "matrix-down" utilizziamo la matrice trasposta per poter utilizzare le stesse funzioni di "matrix-right" e "matrix-left".

(setq grid '((4 16 2 2) (0 2 4 0) (0 0 4 4) (4 0 0 8)))
;-> ((4 16 2 2) (0 2 4 0) (0 0 4 4) (4 0 0 8))
(print-grid grid)
;->    4   16    2    2
;->    0    2    4    0
;->    0    0    4    4
;->    4    0    0    8
(print-grid (matrix-left grid))
;->    4   16    2    2
;->    2    4    0    0
;->    4    4    0    0
;->    4    8    0    0
(print-grid (matrix-right grid))
;->    4   16    2    2
;->    0    0    2    4
;->    0    0    4    4
;->    0    0    4    8
(print-grid (matrix-up grid))
;->    4   16    2    2
;->    4    2    4    4
;->    0    0    4    8
;->    0    0    0    0
(print-grid (matrix-down grid))
;->    0    0    0    0
;->    0    0    2    2
;->    4   16    4    4
;->    4    2    4    8

Funzioni per unire i numeri di una riga:

(define (merge-numbers row)
  (let ( (result '()) (idx 0) (len (length row)) )
    (while (< idx len)
      (if (and (< idx (- len 1)) (= (row idx) (row (+ idx 1))))
          (begin
            (push (* 2 (row idx)) result -1)
            (++ punti (* 2 (row idx)))
            (++ idx 2))  ; Salta un elemento aggiuntivo
          (begin
            (push (row idx) result -1)
            (++ idx 1))))
    ; aggiunge gli 0 necessari per completare la riga
    (extend result (dup 0 (- len (length result))))))

(merge-numbers '(2 2 4 4))
;-> (4 8 0 0)
(merge-numbers '(2 4 2 4))
;-> (2 4 2 4)
(merge-numbers '(2 2 2 2))
;-> (4 4 0 0)
(merge-numbers '(0 0 4 4))
;-> (0 8 0 0)
(merge-numbers '(0 4 4 0))
;-> (0 8 0 0)
(merge-numbers '(4 4 4 0))
;-> (8 4 0 0)
(merge-numbers '(0 4 4 4))
;-> (0 8 4 0)

Funzione per unire i numeri in una griglia (matrice):

(define (matrix-merge matrix) (map merge-numbers matrix))

Funzioni per le quattro mosse del gioco: right, left, up, down

(define (right)
  (println "right")
  (setq old grid)
  (++ mosse)
  ; sposta i numeri a destra
  (setq grid (matrix-right grid))
  ; unisce i numeri
  (setq grid (matrix-merge grid))
  ; sposta i numeri a destra
  (setq grid (matrix-right grid)))

(setq grid '((4 16 2 2) (0 4 4 0) (0 0 4 4) (8 0 0 8)))

(print-grid grid)
;->    4   16    2    2
;->    0    4    4    0
;->    0    0    4    4
;->    8    0    0    8
(right)
(print-grid grid)
;->    0    4   16    4
;->    0    0    0    8
;->    0    0    0    8
;->    0    0    0   16

(define (left)
  (println "left")
  (setq old grid)
  (++ mosse)
  (setq grid (matrix-left grid))
  (setq grid (matrix-merge grid))
  (setq grid (matrix-left grid)))

(left)
(print-grid grid)
;->    4   16    4    0
;->    8    0    0    0
;->    8    0    0    0
;->   16    0    0    0

(define (up)
  (println "up")
  (setq old grid)
  (++ mosse)
  (setq grid (matrix-up grid))
  (setq grid (transpose (matrix-merge (transpose grid))))
  (setq grid (matrix-up grid)))

(up)
(print-grid grid)
;->    4   16    4    0
;->   16    0    0    0
;->   16    0    0    0
;->    0    0    0    0

(define (down)
  (println "down")
  (setq old grid)
  (++ mosse)
  (setq grid (matrix-down grid))
  (setq grid (transpose (matrix-merge (transpose grid))))
  (setq grid (matrix-down grid)))

(down)
(print-grid grid)
;->    0    0    0    0
;->    0    0    0    0
;->    4    0    0    0
;->   32   16    4    0

Nota: per "up" e "down" utilizziamo la matrice trasposta per poter utilizzare le stesse funzioni di "right" e "left".

Facciamo una partita:

(new-game)
;-> Mosse: 0
;-> Punti: 0
;->    2    0    0    0
;->    0    0    0    0
;->    0    2    0    0
;->    0    0    0    0

;-> right
;-> Mosse: 1
;-> Punti: 0
;->    4    0    0    2
;->    0    0    0    0
;->    0    0    0    2
;->    0    0    0    0

;-> down
;-> Mosse: 2
;-> Punti: 4
;->    0    0    0    0
;->    0    0    0    0
;->    4    0    0    0
;->    4    0    0    4

;-> up
;-> Mosse: 3
;-> Punti: 12
;->    8    0    0    4
;->    0    0    0    0
;->    0    0    0    0
;->    0    0    2    0

;-> left
;-> Mosse: 4
;-> Punti: 12
;->    8    4    0    0
;->    0    4    0    0
;->    0    0    0    0
;->    2    0    0    0

;-> down
;-> Mosse: 5
;-> Punti: 20
;->    0    0    0    0
;->    0    0    0    0
;->    8    0    0    4
;->    2    8    0    0
;-> ...

Mettiamo tutto insieme:

(define (print-grid matrix)
  (local (row col)
    (setq row (length matrix))
    (setq col (length (matrix 0)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format "%4d " (matrix i j)))
      )
      (println)) '>))
;
(define (new-game)
  (setq N 4)
  ; griglia di gioco (matrice)
  (setq grid (array-list (array N N '(0))))
  ; lista delle coordinate della griglia
  (setq pts '())
  (for (i 0 (- N 1))
    (for (j 0 (- N 1))
      (push (list i j) pts -1)))
  ; inserisce il valore 2 in due caselle della griglia scelte a caso
  (setq pts (randomize pts))
  (setf (grid (pts 0)) 2)
  (setf (grid (pts 1)) 2)
  ;(setf (grid 0 0) 1024)
  ;(setf (grid 1 0) 1024)
  ; griglia precedente
  (setq old grid)
  ; numero mosse
  (setq mosse 0)
  ; punteggio
  (setq punti 0)
  (input))
;
(define (input)
  (println "Mosse: " mosse)
  (println "Punti: " punti)
  (print-grid grid)
  (setq key (read-key))
  ;(println key { } (char key))
  (case key
    (87 (up))    (119 (up))
    (65 (left))  (97  (left))
    (85 (down))  (115 (down))
    (68 (right)) (100 (right))
    (48 (exit)) ; "0" --> esce dal gioco
    (true (begin (println "Tasto errato.") (setq error true)))
  )
        ; vinto?
  (cond ((ref 2048 grid) (println "Hai vinto."))
        ; premuto un tasto errato
        ((= error true) (setq error nil) (input))
        ; perso?
        ;((= grid old) (println "Hai perso."))
        (true ; il gioco continua con il prossimo turno
          ; Inserisce una nuova casella (2 o 4) nella griglia
          ; lista delle coordinate vuote
          (setq pts '())
          (for (i 0 (- N 1))
            (for (j 0 (- N 1))
              (if (zero? (grid i j)) (push (list i j) pts -1))))
          ; inserisce il valore 2 0 4 in una casella vuota (casuale)
          (when (> (length pts) 0)
            (setq pts (randomize pts))
            (if (zero? (rand 2))
                (setf (grid (pts 0)) 2)
                (setf (grid (pts 0)) 4)))
          ; input utente
          (input))))
;
(define (shift-right row)
  (let ((non-zero (filter (fn (x) (!= x 0)) row))
        (zeroes (filter (fn (x) (= x 0)) row)))
    (extend zeroes non-zero)))
;
(define (shift-left row)
  (let ((non-zero (filter (fn (x) (!= x 0)) row))
        (zeroes (filter (fn (x) (= x 0)) row)))
    (extend non-zero zeroes)))
;
(define (matrix-right matrix) (map shift-right matrix))
;
(define (matrix-left matrix) (map shift-left matrix))
;
(define (matrix-down matrix)
  (let (trans (transpose matrix))
    (transpose (map shift-right trans))))
;
(define (matrix-up matrix)
  (let (trans (transpose matrix))
    (transpose (map shift-left trans))))
;
(define (merge-numbers row)
  (let ( (result '()) (idx 0) (len (length row)) )
    (while (< idx len)
      (if (and (< idx (- len 1)) (= (row idx) (row (+ idx 1))))
          (begin
            (push (* 2 (row idx)) result -1)
            (++ punti (* 2 (row idx)))
            (++ idx 2))  ; Salta un elemento aggiuntivo
          (begin
            (push (row idx) result -1)
            (++ idx 1))))
    ; aggiunge gli 0 necessari per completare la riga
    (extend result (dup 0 (- len (length result))))))
;
(define (matrix-merge matrix) (map merge-numbers matrix))
;
(define (right)
  (println "right")
  (setq old grid)
  (++ mosse)
  ; sposta i numeri a destra
  (setq grid (matrix-right grid))
  ; unisce i numeri
  (setq grid (matrix-merge grid))
  ; sposta i numeri a destra
  (setq grid (matrix-right grid)))
;
(define (left)
  (println "left")
  (setq old grid)
  (++ mosse)
  (setq grid (matrix-left grid))
  (setq grid (matrix-merge grid))
  (setq grid (matrix-left grid)))
;
(define (up)
  (println "up")
  (setq old grid)
  (++ mosse)
  (setq grid (matrix-up grid))
  (setq grid (transpose (matrix-merge (transpose grid))))
  (setq grid (matrix-up grid)))
;
(define (down)
  (println "down")
  (setq old grid)
  (++ mosse)
  (setq grid (matrix-down grid))
  (setq grid (transpose (matrix-merge (transpose grid))))
  (setq grid (matrix-down grid)))


;---------------------------------
; Minimalistic 2048 (4x4)
; Use "W" "A" "S" "D" key to move
; (load "g2048.lsp")
;---------------------------------
(define (print-grid)
  (for (i 0 3)
    (for (j 0 3)
      (print (format "%4d " (grid i j))))
    (println)) '>)
;
(define (find-zeros)
  (let (pts '())
    (for (i 0 3)
      (for (j 0 3)
        (if (zero? (grid i j)) (push (list i j) pts -1)))) pts))
;
(define (new-game)
  (setq grid (array-list (array 4 4 '(0))))
  (setq zeros (randomize (find-zeros)))
  (setf (grid (zeros 0)) 2)
  (setf (grid (zeros 1)) 2)
  (input))
;
(define (input)
  (print-grid)
  (case (setq key (read-key))
    (87 (up))    (119 (up))
    (65 (left))  (97  (left))
    (85 (down))  (115 (down))
    (68 (right)) (100 (right))
    (48 (exit)) ; "0" --> quit the game
    (true (begin (println "Wrong key.") (setq key-error true)))
  )
  (cond ((ref 2048 grid) (println "Bravo! You win.") (print-grid))
        ((= key-error true) (setq key-error nil) (input))
        (true
          (setq zeros (randomize (find-zeros)))
          (when zeros ; put 2 or 4 in a free cell
            (if (zero? (rand 2))
                (setf (grid (zeros 0)) 2)
                (setf (grid (zeros 0)) 4)))
          (input))))
;
(define (shift-right row)
  (let ((non-zero (filter (fn (x) (!= x 0)) row))
        (zeroes (filter (fn (x) (= x 0)) row)))
    (extend zeroes non-zero)))
;
(define (shift-left row)
  (let ((non-zero (filter (fn (x) (!= x 0)) row))
        (zeroes (filter (fn (x) (= x 0)) row)))
    (extend non-zero zeroes)))
;
(define (matrix-left matrix) (map shift-left matrix))
;
(define (matrix-right matrix) (map shift-right matrix))
;
(define (matrix-down matrix)
  (let (trans (transpose matrix))
    (transpose (map shift-right trans))))
;
(define (matrix-up matrix)
  (let (trans (transpose matrix))
    (transpose (map shift-left trans))))
;
(define (merge-numbers row)
  (let ( (result '()) (idx 0) (len (length row)) )
    (while (< idx len)
      (if (and (< idx (- len 1)) (= (row idx) (row (+ idx 1))))
          (begin
            (push (* 2 (row idx)) result -1)
            (++ idx 2))
          (begin
            (push (row idx) result -1)
            (++ idx 1))))
    (extend result (dup 0 (- len (length result))))))
;
(define (matrix-merge matrix) (map merge-numbers matrix))
;
(define (right)
  (println "right")
  (setq grid (matrix-right grid))  ; move the numbers to right
  (setq grid (matrix-merge grid))  ; merge the numbers
  (setq grid (matrix-right grid))) ; move the numbers to right
;
(define (left)
  (println "left")
  (setq grid (matrix-left grid))
  (setq grid (matrix-merge grid))
  (setq grid (matrix-left grid)))
;
(define (up)
  (println "up")
  (setq grid (matrix-up grid))
  (setq grid (transpose (matrix-merge (transpose grid))))
  (setq grid (matrix-up grid)))
;
(define (down)
  (println "down")
  (setq grid (matrix-down grid))
  (setq grid (transpose (matrix-merge (transpose grid))))
  (setq grid (matrix-down grid)))
;
(new-game)

--------------------------------------------------------
Funzione che restituisce risultati sempre diversi (UUID)
--------------------------------------------------------

Scrivere una funzione con le seguenti caratteristiche:

1) ogni volta che viene lanciata produce risultati differenti
2) su computer diversi produce risultati diversi
3) non è possibile utilizzare le funzioni random (rand, random, amb, ecc.)

La funzione è molto semplice perchè è una primitiva di newLISP: "uuid".

*****************
>>>funzione UUID
*****************
sintassi: (uuid [str-node])

Costruisce e restituisce un UUID (Universally Unique IDentifier).
Senza una specifica del nodo in str-node, viene restituito un numero di byte generato casualmente UUID di tipo 4.
Quando il parametro opzionale str-node costruisce e restituisce un UUID (IDentifier univoco universale).
Senza una specifica del nodo in str-node, viene restituito un numero di byte generato casualmente dall'UUID di tipo 4.
Quando viene utilizzato il parametro facoltativo str-node, viene restituito un UUID di tipo 1.
La stringa in str-node specifica un MAC (Media Access Code) valido da un adattatore di rete installato sul nodo o un ID nodo casuale.
Quando viene specificato un ID nodo casuale, il bit meno significativo del primo byte del nodo deve essere impostato su 1 per evitare conflitti con gli identificatori MAC reali.
Gli UUID di tipo 1 con ID nodo vengono generati da un timestamp e altri dati.
Vedere RFC 4122 per dettagli sulla generazione dell'UUID.

;; type 4 UUID for any system

(uuid)
;-> "493AAD61-266F-48A9-B99A-33941BEE3607"

;; type 1 UUID preferred for distributed systems

;; configure node ID for ether 00:14:51:0a:e0:bc
(set 'id (pack "cccccc" 0x00 0x14 0x51 0x0a 0xe0 0xbc))

(uuid  id)
;-> "0749161C-2EC2-11DB-BBB2-0014510AE0BC"

Ogni invocazione della funzione uuid produrrà un nuovo UUID univoco.
Gli UUID vengono generati senza un archivio stabile condiviso a livello di sistema (vedere RFC 4122).
Se il sistema che genera gli UUID è distribuito su più nodi, è necessario utilizzare la generazione di tipo 1 con un ID nodo diverso su ciascun nodo.
Per più processi sullo stesso nodo sono garantiti UUID validi anche se richiesti contemporaneamente.
Questo perché l'ID del processo di generazione newLISP fa parte del seed per il generatore di numeri casuali.
Quando gli ID di tipo 4 vengono utilizzati su un sistema distribuito, due UUID identici sono ancora altamente improbabili e impossibili per gli ID di tipo 1 se vengono utilizzati indirizzi MAC reali.

Quindi la nostra funzione è semplicemente:

(define (what?) (uuid))

Proviamo:

(what?)
;-> "60214143-18A3-42FB-9A76-90129C42CB41"
(what?)
;-> "251A2199-2C47-42E5-942F-C74E99377112"
(what?)
;-> "6B17694A-67A2-4B5A-8AAB-0D173D7DA762"
(what?)
;-> "321D0DD4-2926-458C-84EB-96366B6A4204"
(what?)
;-> "0E5718A8-22D4-4FF3-9DF3-4A24EA226C72"


-------------------------------------
Sequenze di numeri senza alcune cifre
-------------------------------------

Dati due numeri interi non negativi 'a' e 'b' con a < b e una lista di cifre diverse, scrivere una funzione che può generare tutti i numeri tra 'a' e 'b' che non contengono le cifre della lista oppure tutti i numeri tra 'a' e 'b' che contengono solo le cifre della lista (una o più).

Esempio:
a = 10
b = 30
cifre = (0 1 3)
Output (non contengono le cifre) = (22 24 25 26 27 28 29)
Output (contengono le cifre) = (10 11 13 30 31 33)

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

Funzione che genera tutti i numeri tra 'a' e 'b' che non contengono le cifre della lista data:

(define (counter-without a b digits)
  (local (seq lst lst-nums)
    (setq seq (sequence a b))
    (setq lst (map int-list seq))
    ; filtra elementi di lst
    ; per ogni elemento di lst (es. (2 0))
    ; controlla se tutte le cifre non compaiono nella lista digits
    (setq lst-nums (filter (fn(x)
                              (for-all (fn(y) (nil? (ref y digits))) x)) lst))
    ; converte le liste in numeri
    (map list-int lst-nums)))

(counter-without 10 40 '(0 1 3))
;-> (22 24 25 26 27 28 29)

Funzione che genera tutti i numeri tra 'a' e 'b' che contengono solo le cifre della lista data:

(define (counter-with a b digits)
  (local (seq lst lst-nums)
    (setq seq (sequence a b))
    (setq lst (map int-list seq))
    ; filtra elementi di lst
    ; per ogni elemento di lst (es. (2 0))
    ; controlla se tutte le cifre compaiono nella lista digits
    (setq lst-nums (filter (fn(x)
                              (for-all (fn(y) (true? (ref y digits))) x)) lst))
    ; converte le liste in numeri
    (map list-int lst-nums)))

(counter-with 10 40 '(0 1 3))
;-> (10 11 13 30 31 33)

Possiamo scrivere una funzione unica:

(define (counter a b digits with-digits)
  (local (seq lst lst-nums)
    (setq seq (sequence a b))
    (setq lst (map int-list seq))
    (if with-digits
      (setq lst-nums (filter (fn(x)
                              (for-all (fn(y) (true? (ref y digits))) x)) lst))
      ;else
      (setq lst-nums (filter (fn(x)
                              (for-all (fn(y) (nil? (ref y digits))) x)) lst))
    )
    ; converte le liste in numeri
    (map list-int lst-nums)))

Proviamo:

(counter 10 40 '(0 1 3) true)
;-> (10 11 13 30 31 33)

(counter 10 40 '(0 1 3))
;-> (22 24 25 26 27 28 29)

(counter 1 1000 '(1 2 3 4 5 6 8 0))
;-> (7 9 77 79 97 99 777 779 797 799 977 979 997 999)

(counter 1 1000 '(1 2 3 4 5 6 8 0) true)
;-> (1 2 3 4 5 6 8 10 11 12 13 14 15 16 18 20 21 22 23 24 25 26 28 30
;->  31 32 33 34 35 36 38 40 41 42 43 44 45 46 48 50 51 52 53 54 55 56
;->  ...
;->  834 835 836 838 840 841 842 843 844 845 846 848 850 851 852 853 854
;->  855 856 858 860 861 862 863 864 865 866 868 880 881 882 883 884 885
;->  886 888 1000)


-------------------------
Complessità di Kolmogorov
-------------------------

La complessità di Kolmogorov di un oggetto che può essere rappresentato come una sequenza di bit (es. un testo), è la lunghezza del più breve programma informatico (in un dato linguaggio di programmazione) che produce l'oggetto come output.
In altre parole, è la quantità di informazione contenuta in una data oggetto x espressa come la lunghezza del più breve programma che stampa x e si arresta.

Vediamo praticamente di cosa si tratta.
Supponiamo di avere la stringa "11111111111111111111" cioè "1" ripetuto 20 volte.
In newLISP penso che il più breve programma che stampi la stringa sia l'espressione:

(dup "1" 20)
;-> "11111111111111111111"

L'espressione (dup "1" 20) è lunga 12 caratteri, quindi la complessità di Kolmogorov della stringa "11111111111111111111" vale 12 (unità di informazione) utilizzando il linguaggio newLISP.

Nota: anche usando "print" il concetto rimane lo stesso, cambia solo la quantità di informazione dell'oggetto.

Adesso supponiamo di avere le prime 50 cifre decimali di Pi Greco:

  14159265358979323846264338327950288419716939937510

non c'è modo di stampare questa stringa dall'aspetto casuale se non specificandola cifra per cifra.

(print "14159265358979323846264338327950288419716939937510")
;-> 14159265358979323846264338327950288419716939937510

oppure:

"14159265358979323846264338327950288419716939937510"
;-> "14159265358979323846264338327950288419716939937510"

oppure:

14159265358979323846264338327950288419716939937510
;-> 14159265358979323846264338327950288419716939937510L

L'espressione (print "14159265358979323846264338327950288419716939937510") è lunga 61 caratteri (quantità di informazione), mentre l'oggetto è lungo 50 caratteri.

Quindi, per un dato linguaggio, gli oggetti informatici rappresentabili possono essere di tre tipi:

1) oggetti la cui quantità di informazione (complessità di Kolmogorov) è maggiore della loro rappresentazione.
2) oggetti la cui quantità di informazione (complessità di Kolmogorov) è uguale alla loro rappresentazione.
3) oggetti la cui quantità di informazione (complessità di Kolmogorov) è minore alla loro rappresentazione.


---------------------
Numeri weird (strani)
---------------------

Un numero weird (strano) è un numero la cui somma dei divisori propri è maggiore del numero stesso e nessun sottoinsieme di divisori propri somma a quel numero.
Esempi:
N = 70
divisori propri = (1 2 5 7 10 14 35)
Poichè la somma dei divisori (74) è maggiore di 70 e nessuna somma dei divisori porta a 70, allora il numero 70 è weird.

N = 18
divisori propri = (1 2 3 6 9)
In questo caso, la somma dei divisori (21) è maggiore di 18, ma 9 + 6 + 3 = 18, quindi il numero 18 non è weird.

Sequenza OEIS: A006037
Weird numbers: abundant (A005101) but not pseudoperfect (A005835).
  70, 836, 4030, 5830, 7192, 7912, 9272, 10430, 10570, 10792, 10990, 11410,
  11690, 12110, 12530, 12670, 13370, 13510, 13790, 13930, 14770, 15610,
  15890, 16030, 16310, 16730, 16870, 17272, 17570, 17990, 18410, 18830,
  18970, 19390, 19670, ...

Funzione che verifica se un dato numero N può essere espresso come somma di alcuni o tutti i numeri contenuti in una data lista:

(define (sum-N-from-list? numbers N)
  (let ((dp (dup nil (+ N 1)))
        (used-numbers (dup nil (+ N 1))))
    (setf (dp 0) true)
    (dolist (num numbers)
      (for (i N 0 -1)
        (if (and (>= i num) (dp (- i num)))
          (begin
            (setf (dp i) true)
            (if (not (used-numbers i))
              (if (used-numbers (- i num))
                (setf (used-numbers i) (append (used-numbers (- i num)) (list num)))
                (setf (used-numbers i) (list num))))))))
    (dp N)))

Poi ci serve la funzione che calcola i divisori di un numero:

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn ( (fattori (factor num))
            (unici (unique fattori)) )
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

(divisors 32)
;-> (1 2 4 8 16 32)
(divisors 13)
;-> (1 13)

Funzione che verifica se un dato numero è weird:

(define (weird? N)
  (let (divisori (divisors N))
    (cond ((< (length divisori) 3) nil) ; 1 e numeri primi
          (true
            (pop divisori -1) ; solo divisori propri
            (and (> (apply + divisori) N)
                    (not (sum-N-from-list? divisori N)))))))

Proviamo:

(weird? 70)
;-> true

(weird? 21)
;-> nil

(time (println (filter weird? (sequence 1 1000))))
;-> (70 836)
;-> 1828.362

La funzione è molto lenta:

(time (println (filter weird? (sequence 1 2000))))
;-> (70 836)
;-> 29471.311

(time (println (filter weird? (sequence 1 1e4))))
;-> (70 836 4030 5830 7192 7912 9272)
;-> 9540315.664999999   ; 2h 39m 316ms

Usiamo i vettori al posto delle liste nella funzione "sum-N-from-list?":

(define (sum-N-from-list? numbers N)
  (let ( (dp (array (+ N 1) (dup nil (+ N 1))))
         (used-numbers (array (+ N 1) (dup nil (+ N 1)))) )
    (setf (dp 0) true)
    (dolist (num numbers)
      (for (i N 0 -1)
        (if (and (>= i num) (dp (- i num)))
          (begin
            (setf (dp i) true)
            (if (not (used-numbers i))
              (if (used-numbers (- i num))
                (setf (used-numbers i) (append (used-numbers (- i num)) (list num)))
                (setf (used-numbers i) (list num))))))))
    (dp N)))

Proviamo:

(time (println (filter weird? (sequence 1 1000))))
;-> (70 836)
;-> 235.345

(time (println (filter weird? (sequence 1 2000))))
;-> (70 836)
;-> 1015.412

(time (println (filter weird? (sequence 1 1e4))))
;-> (70 836 4030 5830 7192 7912 9272)
;-> 33133.63

In quest'ultimo caso la funzione è 300 volte più veloce (circa).
Ma non andiamo tanto lontano...

(time (println (filter weird? (sequence 1 1e5))))
;-> (70 836 4030 5830 7192 7912 9272 10430 10570 10792 10990 11410 11690
;->  12110 12530 12670 13370 13510 13790 13930 14770 15610 15890 16030 
;->  16310 16730 16870 17272 17570 17990 18410 18830 18970 19390 19670 
;->  19810 20510 21490 21770 21910 22190 23170 23590 24290 24430 24710 
;->  25130 25690 26110 26530 26810 27230 27790 28070 28630 29330 29470
;->  30170 30310 30730 31010 31430 31990 32270 32410 32690 33530 34090
;->  34370 34930 35210 35630 36470 36610 37870 38290 38990 39410 39830
;->  39970 40390 41090 41510 41930 42070 42490 42910 43190 43330 44170
;->  44870 45010 45290 45356 45710 46130 46270 47110 47390 47810 48370
;->  49070 49630 50330 50890 51310 51730 52010 52570 52990 53270 53830
;->  54110 55090 55790 56630 56770 57470 57610 57890 58030 58730 59710
;->  59990 60130 60410 61390 61670 61810 62090 63490 63770 64330 65030
;->  65590 65870 66290 66710 67690 67970 68390 68810 69370 69790 70630
;->  70910 71330 71470 72170 72310 72730 73430 73570 73616 74270 74410
;->  74830 76090 76370 76510 76790 77210 77630 78190 78610 79030 80570
;->  80710 81410 81970 82670 83090 83312 83510 84070 84910 85190 85610
;->  86030 86170 86590 87430 88130 89390 89530 89810 90230 90370 90790
;->  91070 91210 91388 91490 92330 92470 92890 95270 95690 96110 96670
;->  97930 98630 99610 99890)
;-> 8827901.413000001   ; 2h 27m 7s 901ms


--------------------------------------------------
42: the answer to life the universe and everything
--------------------------------------------------

Nel libro "Guida galattica per gli autostoppisti" di Douglas Adams, il computer Deep Thought (Pensiero Profondo) ha calcolato la risposta alla Domanda Fondamentale sulla Vita, l'Universo e Tutto Quanto ("answer to life the universe and everything") impiegando un periodo di 7.5 milioni di anni...
La risposta è 42.

Nota: 6(13) * 9(13) = 42(13) (base 13)

Scrivere una funzione che richiede circa 7.5 secondi per generare il numero 42.
Regole:
1) non è possibile codificare il numero 42 direttamente nel codice, cioè deve essere calcolato nel modo più inventivo possibile
2) non è possibile usare la funzione "sleep", cioè non è possibile "sospendere" la funzione per un determinato periodo di tempo.

N.B. Il numero 42 deve essere calcolato in qualche modo (numeri casuali, qualunque cosa tu preferisca), non solo codificato nel tuo script.

(define (quarantadue)
  (letn ( (start (time-of-day))
          (end (+ start 7500)) )
        (until (< end (time-of-day))
          (if (!= val 42)
              (setq val (apply amb (sequence 0 100)))))
        (if (= val 42) val nil)))

(time (println (quarantadue)))
;-> 42
;-> 7500.211


---------------------
Funzione che ingrassa
---------------------

Scrivere una funzione che quando viene eseguita aumenta sempre di dimensione e stampa la funzione aumentata.

Sfruttiamo una particolarità della funzione "extend" che modifica il valore "in-place".
Se "extend" viene usata senza un simbolo iniziale, allora modifica la funzione con il valore dell'espressione.

(define (fat)
  (extend "" (string (rand 10)))
  (println fat) '>)

Proviamo:

(fat)
;-> (lambda () (extend "2" (string (rand 10))) (println fat) '>)

(fat)
;-> (lambda () (extend "21" (string (rand 10))) (println fat) '>)

(fat)
;-> (lambda () (extend "216" (string (rand 10))) (println fat) '>)

(fat)
;-> (lambda () (extend "2161" (string (rand 10))) (println fat) '>)

(fat)
;-> (lambda () (extend "21616" (string (rand 10))) (println fat) '>)

(fat)
;-> (lambda () (extend "216164" (string (rand 10))) (println fat) '>)

(fat)
;-> (lambda () (extend "2161647" (string (rand 10))) (println fat) '>)


----------------------------------------------------------------
Perimetro massimo e minimo di un rettangolo con area predefinita
----------------------------------------------------------------

Dato un numero intero che rappresenta l'area di un rettangolo, trovare i valori di base e altezza che minimizzano/massimizzano il perimetro del rettangolo.

(define (perim-min-max area)
  (local (pmin pmax xmin ymin xmax ymax y p)
    (setq pmin 1e99) (setq pmax 0)
    (setq xmin 1e99) (setq ymin 1e99)
    (setq xmax 0) (setq ymax 0)
    (for (x 1 area)
      (when (zero? (% area x)) ; trovato un y possibile?
        (setq y (/ area x))
        (setq p (* 2 (+ x y)))
        (if (< p pmin) (set 'pmin p 'xmin x 'ymin y))
        (if (> p pmax) (set 'pmax p 'xmax x 'ymax y))
        ;(println x { } y { } p { } pmin { } pmax)
      )
    )
    (list (list xmin ymin (* 2 (+ xmin ymin)))
          (list xmax ymax (* 2 (+ xmax ymax))))))

Proviamo:

(perim-min-max 49)
;-> ((7 7 28) (1 49 100))

(perim-min-max 83)
;-> ((1 83 168) (1 83 168))

(perim-min-max 84)
;-> ((7 12 38) (1 84 170))

(perim-min-max 25)
;-> ((5 5 20) (1 25 52))

(time (println (perim-min-max 987654321)))
;-> ((2601 379721 764644) (1 987654321 1975308644))
;-> 50041.141

Questo problema è in relazione con le seguenti due sequenze:

Sequenza OEIS: A033676
Largest divisor of n <= sqrt(n)
  1, 1, 1, 2, 1, 2, 1, 2, 3, 2, 1, 3, 1, 2, 3, 4, 1, 3, 1, 4, 3, 2, 1, 4,
  5, 2, 3, 4, 1, 5, 1, 4, 3, 2, 5, 6, 1, 2, 3, 5, 1, 6, 1, 4, 5, 2, 1, 6,
  7, 5, 3, 4, 1, 6, 5, 7, 3, 2, 1, 6, 1, 2, 7, 8, 5, 6, 1, 4, 3, 7, 1, 8,
  1, 2, 5, 4, 7, 6, 1, 8, 9, 2, 1, 7, 5, 2, 3, ...

Sequenza OEIS: A033677
Smallest divisor of n >= sqrt(n)
  1, 2, 3, 2, 5, 3, 7, 4, 3, 5, 11, 4, 13, 7, 5, 4, 17, 6, 19, 5, 7, 11, 23,
  6, 5, 13, 9, 7, 29, 6, 31, 8, 11, 17, 7, 6, 37, 19, 13, 8, 41, 7, 43, 11,
  9, 23, 47, 8, 7, 10, 17, 13, 53, 9, 11, 8, 19, 29, 59, 10, 61, 31, 9, 8,
  13, 11, 67, 17, 23, 10, 71, 9, 73, 37, 15, 19, 11, 13, 79, 10, ...

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn ( (fattori (factor num))
            (unici (unique fattori)) )
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

(define (A033676 num)
  (if (= num 1) 1
  ;else
    (local (divisori soglia stop)
      (setq divisori (divisors num))
      ;(pop divisori -1)
      (setq soglia (sqrt num))
      (setq stop nil)
      ; per trovare il più grande divisore di num <= a sqrt(num)
      ; partiamo con il divisore più grande
      (dolist (d (reverse divisori) stop)
        (when (<= d soglia)
          (setq out d) (setq stop true)))
    out)))

Proviamo:

(map A033676 (sequence 1 50))
;-> (1 1 1 2 1 2 1 2 3 2 1 3 1 2 3 4 1 3 1 4 3 2 1 4
;->  5 2 3 4 1 5 1 4 3 2 5 6 1 2 3 5 1 6 1 4 5 2 1 6
;->  7 5)

(define (A033677 num)
  (if (= num 1) 1
  ;else
    (local (divisori soglia stop)
      (setq divisori (divisors num))
      ;(pop divisori -1)
      (setq soglia (sqrt num))
      (setq stop nil)
      ; per trovare il più piccolo divisore di num >= a sqrt(num)
      ; partiamo con il divisore più piccolo
      (dolist (d divisori stop)
        (when (>= d soglia)
          (setq out d) (setq stop true)))
    out)))

Proviamo:

(map A033677 (sequence 1 50))
;-> (1 2 3 2 5 3 7 4 3 5 11 4 13 7 5 4 17 6 19 5 7 11 23
;->  6 5 13 9 7 29 6 31 8 11 17 7 6 37 19 13 8 41 7 43 11
;->  9 23 47 8 7 10)


----------------------------------------------------------------
Periodo e antiperiodo della divisione decimale di due interi M/N
----------------------------------------------------------------

Dati due numeri interi M e N, determinare il periodo e l'antiperiodo della divisione decimale M/N.

Esempi:

  M = 13, N = 12
  (div 13 12)
  ;-> 1.083333333333333
  periodo = 3
  antiperiodo = 08

  M = 1, N = 7
  (div 1 7)
  0.1428571428571429
  periodo = 142857
  periodo = nil

Algoritmo:
   1. Inizializzare liste vuote per 'resti`, 'cifre' e 'indici`.
   2. Calcolare il resto iniziale della divisione M/N).
   3. Usare un ciclo 'while' per continuare a calcolare i resti e i valori decimali finché non si trova un resto ripetuto.
   4. Aggiungere l'ultima cifra decimale (che segue il periodo).
   5. Aggiungere l'ultimo resto.
   6. Usare 'ref-all' per trovare gli indici delle cifre periodiche (dai 'resti').
   7. Convertire le cifre raccolte in una stringa 'decimali`.
   8. Calcolare il periodo estraendo la parte ripetuta dalla stringa 'decimali`.
   9. Calcolare l'antiperiodo estraendo la parte non ripetuta dalla stringa 'decimali`.
  10. Comporre la stringa finale che rappresenta la frazione decimale con il periodo tra parentesi.

Funzione che calcola il periodo e l'antiperiodo della frazione decimale M/N:

(define (periodo-decimale M N)
  (let ( (resti '())
         (cifre '())
         (indici '())
         (resto (mod M N))
         (decimali "")
         (periodo "")
         (antiperiodo "") )
    ; ciclo fino a che i resti sono diversi
    (while (not (member resto resti))
      (push resto resti -1)
      (push (floor (/ (* resto 10) N)) cifre -1)
      (setq resto (mod (* resto 10) N)))
    ; cifra seguente il periodo
    (push (floor (/ (* resto 10) N)) cifre -1)
    ; ultimo resto (uguale ad un resto precedente)
    (push resto resti -1)
    ; trova gli indici del periodo (dalla lista dei resti)
    (setq idx (ref-all (resti -1) resti))
    ; crea la stringa con tutti i decimali
    (setq decimali (join (map string cifre)))
    ; calcola il periodo
    (setq periodo (slice decimali (idx 0 0) (- (idx 1 0) (idx 0 0))))
    ; calcola l'antiperiodo
    (setq antiperiodo (slice decimali 0 (idx 0 0)))
    ; crea la stringa di output
    (string (/ M N) "." antiperiodo "(" periodo ")")))

Proviamo:

(periodo-decimale 13 12)
;-> "1.08(3)"

(periodo-decimale 1 7)
;-> "0.(142857)"

(periodo-decimale 4 4)
;-> "1.(0)"

(periodo-decimale 1 4)
;-> "0.25(0)"

(periodo-decimale 8 4)
;-> "2.(0)"

(periodo-decimale 1 983)
;-> "0.(00101729399796541200406917599186164801627670396744659206510681586978
;-> 636826042726347914547304170905391658189216683621566632756866734486266531
;-> 027466937945066124109867751780264496439471007121057985757884028484231943
;-> 031536113936927772126144455747711088504577822990844354018311291963377416
;-> 073245167853509664292980671414038657171922685656154628687690742624618514
;-> 750762970498474059003051881993896236012207527975584944048830111902339776
;-> 195320447609359104781281790437436419125127161749745676500508646998982706
;-> 002034587995930824008138351983723296032553407934893184130213631739572736
;-> 520854526958290946083418107833163784333672431332655137334689725330620549
;-> 338758901322482197355035605289928789420142421159715157680569684638860630
;-> 722278738555442522889114954221770091556459816887080366225839267548321464
;-> 903357070193285859613428280773143438453713123092573753814852492370295015
;-> 259409969481180061037639877924720244150559511698880976602238046795523906
;-> 40895218718209562563580874872838250254323499491353)"

Per convertire un numero decimale in una frazione vedi "Frazione generatrice" su "Problemi vari".


----------------------------
Stringhe con tutte le vocali
----------------------------

Data una stringa determinare se contiene tutte le vocali (a e i o u) almeno una volta.

(define (vowel? str)
  (not (ref 0 (count '("a" "e" "i" "o" "u") (explode str)))))

(vowel? "aiuole")
;-> true
(vowel? "ambarabaciccicocco")
;-> nil

Funzione che trova le parole con tutte le vocali in un file che contiene una parola per riga:

(define (find-vowel-words filename)
  (local (out file-str)
    (setq out '())
    (setq file-str (open filename "read"))
    (while (read-line file-str)
      (if (vowel? (current-line)) (push (current-line) out -1)))
    (close file-str)
    out))

Proviamo con un file di parole inglesi:

(find-vowel-words "unixdict.txt")
;-> ("adventitious" "aeronautic" "ambidextrous" "argillaceous" "argumentation"
;->  "auctioneer" "audiotape" "augmentation" "aureomycin" "authoritative" 
;->  "autocollimate" "automobile" "automotive" "autosuggestible" "beaujolais"
;->  "bimolecular" "boardinghouse" "cauliflower" "coeducation" "colatitude" 
;->  "communicable" "communicate" "consanguine" "consanguineous" 
;-> ...
;->  "questionnaire" "refutation" "reputation" "revolutionary" "sacrilegious"
;->  "sanguineous" "sequestration" "sequoia" "simultaneous" "stupefaction"
;->  "sulfonamide" "tambourine" "telecommunicate" "tenacious" "tetrafluoride"
;->  "tetrafluouride" "unidimensional" "unidirectional" "veracious"
;->  "vexatious")

(length (find-vowel-words "unixdict.txt"))
;-> 122

Proviamo con un file di parole italiane:

(find-vowel-words "60000_parole_italiane.txt")
;-> ("abitueremo" "abituero" "abiureremo" "abiurero" "abluzione" "accentuino"
;->  "accumulazione" "acquedotti" "acquietano" "acquietato" "acquietavo"
;->  "acquietero" "acquietino" "acquieto" "acquistero" "adeguiamo" "adeguino"
;->  "adulazione" "adulterino" "adulterio" "affettuosi" "aggiungendo"
;->  "aggiungero'" "aggiustero" "aiuole" "aiutassero" "aiuteranno" 
;->  ...
;->  "universitario" "univocamente" "urbanesimo" "ustionare" "ustionasse"
;->  "ustionaste" "ustionate" "ustionera" "ustionerai" "ustioniate"
;->  "valutazione" "visualizzazione" "vituperano" "vituperato" "vituperavo"
;->  "vuoterai" "vuotiate" "zuffolerai") 

(length (find-vowel-words "60000_parole_italiane.txt"))
;-> 319

I file "unixdict.txt" e "60000_parole_italiane.txt" si trovano nella cartella "data".


----------------------------------
Ordinamento alternato di una lista
----------------------------------

Data una lista di numeri interi tutti diversi creare una lista ordinata in modo alternato, cioè il primo numero è minore del secondo, il secondo è maggiore del terzo, il terzo è minore del quarto e cosi via.

Per esempio:
lista = (3 5 2 4 1 8)
output = (5 3 4 2 8 1) (uno dei diversi possibili output)

Algoritmo
Per ogni elemento della lista:
inserire l'elemento corrente alla fine o alla penultima posizione della lista ordinata in base a un confronto con l'ultimo elemento della lista ordinata corrente.

Esempio:
  lista =  1 4 9 2 7 5 3 8 6
  Posizionare 1 alla fine: lista corrente (1)
  (4 > 1)? vero  quindi posizionare 4 alla fine: lista corrente (1 4)
  (9 < 4)? falso quindi posizionare 9 alla penultima posizione: (1 9 4)
  (2 > 4)? falso quindi posizionare 2 al penultimo: (1 9 2 4)
  (7 < 4)? falso quindi posizionare 7 al penultimo: (1 9 2 7 4)
  (5 > 4)? vero  quindi posizionare 5 alla fine: (1 9 2 7 4 5)
  (3 < 5)? vero  quindi posizionare 3 alla fine: (1 9 2 7 4 5 3)
  (8 > 3)? vero  quindi posizionare 8 alla fine: (1 9 2 7 4 5 3 8)
  (6 < 8)? vero  quindi posizionare 6 alla fine: (1 9 2 7 4 5 3 8 6)

Da notare che i test di disuguaglianza si alternano e che si inserisce alla fine se l'uguaglianza è vera, o alla penultima posizione se è falsa.

(define (alterna lst)
  (setq out (list (lst 0)))
  (for (i 1 (- (length lst) 1))
    (when (odd? i)
      (if (> (lst i) (out -1))
          (push (lst i) out -1)
          (push (lst i) out -2)))
    (when (even? i)
      (if (< (lst i) (out -1))
          (push (lst i) out -1)
          (push (lst i) out -2)))
  )
  out)

Proviamo:

(alterna '(1 4 9 2 7 5 3 8 6))
;-> (1 9 2 7 4 5 3 8 6)

(alterna (sequence 1 25))
;-> (1 3 2 5 4 7 6 9 8 11 10 13 12 15 14 17 16 19 18 21 20 23 22 25 24)


---------------------------------------------
Verificare se due liste sono ruotate tra loro
---------------------------------------------

Date due liste scrivere una funzione che verifica se una lista è uguale ad una rotazione dell'altra.

Esempi:
  L1 = (1 2 3 4 5)
  L2 = (4 5 1 2 3)
  L1 è una rotazione di L2 (e L2 è una rotazione di L1)

  L1 = (1 2 3 4)
  L2 = (1 2 3)
  L1 non è una rotazione di L2 (e viceversa)

  L1 = (1 2 3 4)
  L2 = (5 1 2 3)
  L1 non è una rotazione di L2 (e viceversa)

Affinchè due liste possano essere la rotazione una dell'altra occorre che le seguenti condizioni siano vere:
1) la lunghezza delle due liste deve essere uguale
2) gli elementi delle due liste devono avere gli stessi valori
Poi bisogna controllare se una rotazione della prima lista di x posti (con x che va da 0 alla lunghezza della lista) è uguale alla seconda lista.

Funzione che verifica se due liste sono shiftate/ruotate tra loro:

(define (shifted? lst1 lst2)
  (let ((len1 (length lst1))
        (len2 (length lst2)))
    (cond ((!= len1 len2) nil) ; lunghezze diverse?
          ;((!= (difference lst1 lst2) '()) nil) ; elementi con valori diversi?
          (true ; controllo di tutte le rotazioni 
            (setq shiftate nil)
            (for (i 0 (- len1 1) 1 shiftate)
              (if (= (rotate (copy lst1) i) lst2) (setq shiftate true))
            )
            shiftate))))

Proviamo:

(setq lista1 '(1 2 3 4 5))
(setq lista2 '(4 5 1 2 3))
(shifted? lista1 lista2)
;-> true

(shifted? '(1 2 3 4) '(1 2 3))
;-> nil
(shifted? '(1 2 3 4) '(5 1 2 3))
;-> nil


----------------------------------
Parole collegate in modo circolare
----------------------------------

Data una lista di N parole (stringhe) con N<=10, ordinarle, se possibile, in modo che:

1) la prima lettera della prima parola è uguale all'ultima lettera dell'ultima parola
2) l'ultima lettera della prima parola è uguale alla prima lettera della seconda parola
3) l'ultima lettera della seconda parola è uguale alla prima lettera della terza parola
4) e cosi via.

Esempio:
  parole = abaco orsi indiana
  ordinamento = IndianA AbacO OrsI

Notare che le rotazioni di un ordinamento sono equivalenti:
1) indiana abaco orsi
2) abaco orsi indiana
3) orsi indiana abaco
e non devono essere considerate come soluzioni diverse.

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

Funzione che verifica se due liste sono shiftate/ruotate tra loro:

(define (shifted? lst1 lst2)
  (let ((len1 (length lst1))
        (len2 (length lst2)))
    (cond ((!= len1 len2) nil)
          ;((!= (difference lst1 lst2) '()) nil)
          (true
            (setq shiftate nil)
            (for (i 0 (- len1 1) 1 shiftate)
              (if (= (rotate (copy lst1) i) lst2) (setq shiftate true))
            )
            shiftate))))

(setq lista1 '(1 2 3 4 5))
(setq lista2 '(4 5 1 2 3))
(shifted? lista1 lista2)
;-> true

Funzione che genera l'ordinamento circolare di una lista di parole:

(define (circolare lst)
  (local (permute sol wrong)
    (setq permute (perm lst))
    (setq sol '())
    (dolist (p permute)
      (setq wrong nil)
      ; (prima lettera prima parola = ultima lettera ultima parola) ?
      (if (!= ((p 0) 0) ((p -1) -1)) (setq wrong true))
      ; ciclo sulla permutazione corrente
      (for (i 1 (- (length lst) 1) 1 wrong)
        ; (prima lettera parola corrente = ultima lettera parola precedente) ?
        (if (!= ((p i) 0) ((p (- i 1)) -1)) (setq wrong true)))
      ; permutazione corrente valida ?
      (when (not wrong)
        ; verifica se la permutazione corrente esiste già nella soluzione
        ; notare che: ("ao" "oi" "ia") è uguale a ("ia" "ao" "oi")
        (if (not (exists (fn(x) (shifted? p x)) sol)) (push p sol -1)))
    sol)))

Proviamo:

(setq parole '("abaco" "indiana" "orsi"))
(circolare parole)
;-> (("indiana" "abaco" "orsi") 

(setq parole '("abaco" "orso" "oca" "albero" "oboe" "elle" "edera" "astratta"))
(circolare parole)
;-> (("abaco" "orso" "oca" "albero" "oboe" "elle" "edera" "astratta")
;->  ("abaco" "oca" "albero" "orso" "oboe" "elle" "edera" "astratta")
;->  ("albero" "oca" "abaco" "orso" "oboe" "elle" "edera" "astratta")
;->  ("albero" "orso" "oca" "abaco" "oboe" "elle" "edera" "astratta")
;->  ("albero" "orso" "oboe" "elle" "edera" "abaco" "oca" "astratta")
;->  ("albero" "oboe" "elle" "edera" "abaco" "orso" "oca" "astratta")
;->  ("abaco" "oboe" "elle" "edera" "albero" "orso" "oca" "astratta")
;->  ("abaco" "orso" "oboe" "elle" "edera" "albero" "oca" "astratta"))

(setq parole '("abaco" "orso" "oca" "albero"))
(circolare parole)
;-> ()


--------------------------------------------------------
Ordinare una lista in base alla frequenza degli elementi
--------------------------------------------------------

Scrivere una funzione che prende una lista e restituisce una lista di elementi distinti, ordinati in ordine decrescente per frequenza.

(setq lst '("Luca" "Ivo" "Paola" "Lara" "Lara" "Ivo" "Ivo" "Lara" "Ivo" "Luca"))

(setq unici (unique lst))
;-> ("Luca" "Ivo" "Paola" "Lara")
(count unici lst)
;-> (2 4 1 3)
(setq conta (map list (count unici lst) unici))
;-> ((2 "John") (4 "Doe") (1 "Dick") (3 "Harry"))
(sort conta >)
;-> ((4 "Doe") (3 "Harry") (2 "John") (1 "Dick"))

(define (sort-freq lst)
  (let (unici (unique lst))
    (sort (map list (count unici lst) unici) >)))

(sort-freq lst)
;-> ((4 "Ivo") (3 "Lara") (2 "Luca") (1 "Paola"))


--------------
Mini blackjack
--------------

Il blackjack è uno dei giochi di casinò più famosi e diffusi al mondo.
Il gioco ha origine nella Francia del XVII secolo, con il nome di Vingt-et-un (ossia "ventuno").
Negli Stati Uniti (1931) il gioco del ventuno venne denominato "black jack" (fante nero) con l'introduzione di una variante: qualora il giocatore facesse 21 con un asso e un jack di picche, veniva pagato con un bonus di dieci volte la posta. Anche se attualmente il bonus è stato abolito, il nome comunque è rimasto.
Per il gioco del blackjack vengono usati da 2 a 6 mazzi di carte francesi, per un totale da 104 a 312 carte.
Nel gioco l'asso può valere 11, o 1, le figure valgono 10, mentre le altre carte da gioco valgono il loro valore nominale.
I semi non hanno alcuna influenza, o valore.
La somma dei punti avviene per semplice calcolo aritmetico.

Carte francesi (Come Quando Fuori Piove):
Cuori  - Hearts
Quadri - Diamonds
Fiori  - Clover
Picche - Pikes

Regole del mini blackjack:
1) due giocatori
2) 6 mazzi di carte (meno 18 carte casuali)
3) non ci sono puntate
4) non esiste lo split
5) ogni partita finisce in parità o con la vittoria di un giocatore
6) Il giocatore può usare il tasto 'Enter' per avere una nuova carta e il tasto 's' (stop) per terminare la mano corrente.

Nota: perchè togliamo 18 carte?
(length ' (1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5))
;-> 18
(+ 1 1 1 1 2 2 2 2 3 3 3)
;-> 21
(+ 3 3 4 4 4 5)
;-> 23

Funzione per la generazione di un mazzo di carte francesi mischiato:

(define (shuffle)
  (local (mazzo valori cuori quadri fiori picche)
    (setq mazzo '())
    (setq valori '("A" "2" "3" "4" "5" "6" "7" "8" "9" "10" "J" "Q" "K"))
    (setq cuori (map (fn(x y) (list x y)) valori (dup "c" 13 true)))
    (setq quadri (map (fn(x y) (list x y)) valori (dup "q" 13 true)))
    (setq fiori (map (fn(x y) (list x y)) valori (dup "f" 13 true)))
    (setq picche (map (fn(x y) (list x y)) valori (dup "p" 13 true)))
    (extend mazzo cuori quadri fiori picche)
    (randomize mazzo)))

(shuffle)
;-> (("A" "c") ("4" "f") ("Q" "c") ("4" "p") ("7" "f") ("2" "f") ("10" "q")
;->  ("9" "p") ("6" "p") ("3" "p") ("5" "q") ("8" "p") ("2" "p") ("8" "f")
;->  ("K" "q") ("3" "q") ("7" "q") ("2" "c") ("J" "q") ("Q" "q") ("K" "p")
;->  ("9" "f") ("2" "q") ("6" "q") ("4" "q") ("10" "f") ("A" "p") ("10" "c")
;->  ("4" "c") ("3" "f") ("A" "q") ("9" "c") ("6" "c") ("A" "f") ("7" "c")
;->  ("7" "p") ("10" "p") ("J" "p") ("9" "q") ("J" "c") ("Q" "p") ("J" "f")
;->  ("8" "q") ("5" "f") ("5" "c") ("K" "f") ("6" "f") ("3" "c") ("5" "p")
;->  ("Q" "f") ("8" "c") ("K" "c"))
 
Comunque a noi serve un mazzo semplificato (cioè 6 mazzi):

(define (mazzo)
 (randomize
  (flat (dup '(A 2 3 4 5 6 7 8 9 10 10 10 10) 24))))

(length (mazzo))
;-> 312

Funzione che trova il valore maggiore tra due interi che è anche minore/uguale a un numero dato:

(define (max-than a b N)
  (cond
    ((and (> a N) (> b N)) -1)
    ((and (<= a N) (<= b N)) (max a b))
    ((<= a N) a)
    ((<= b N) b)
    (true -1)))

(max-than 21 20 21)
;-> 21
(max-than 22 20 21)
;-> 20
(max-than 20 22 21)
;-> 20

Per calcolare il punteggio di una mano dobbiamo considerare i due casi quando A vale 11 oppure A vale 1 e prendere il punteggio più alto che non supera 21.

Funzione che calcola il punteggio di una mano:

(define (points lst)
  (local (p p1 p2)
    (cond ((ref 'A lst) ; there are A in lst
            (replace 'A lst 1) ; replace all the A's with 1
            (setq p1 (apply + lst))
            (setf (lst (ref 1 lst)) 11) ; replace the first 1 with 11
            (setq p2 (apply + lst))
            (setq p (max-than p1 p2 21)))
          (true ; no A in lst
            (setq p (apply + lst))
            (if (> p 21 (setq p -1)))))
    p))

(points '(A 2 3 4))
;-> 20
(points '(A 2))
;-> 13
(points '(A A 2))
;-> 14
(points '(A A A A))
;-> 14
(points '(A A A A 5 5))
;-> 14

Funzione che permette di giocare a mini-blackjack:

(define (blackjack)
(catch
  (local (carte mano-c mano-p stop key p c)
    ;(seed 1)
    (setq carte (mazzo))
    ; Si gioca fino a che rimangono 18 carte...
    (while (> (length carte) 18)
      ; prima carta al croupier
      (setq mano-c '())
      (push (pop carte) mano-c -1)
      ; PLAYER
      ; prima carta al giocatore
      (setq mano-p '())
      (push (pop carte) mano-p -1)
      (setq stop nil)
      (until stop
        (println "Your hand: " mano-p)
        (setq key (read-key))
              ; pressed "s" or "S"
        (cond ((or (= key 115) (= key 83)) (setq stop true))
              ; pressed 'ESC' to quit the game
              ((= key 27) (throw 'Game-Over))
              (true ; pressed Enter (or other key not "s" or "S" or 'ESC')
                (push (pop carte) mano-p -1)))
      )
      ; calculate points of current hand
      (setq p (points mano-p))
      (println "Your hand: " mano-p { } p)
      ; CROUPIER
      (setq c 0)
      ; check if player go over 21
      (cond ((= p -1) (println "You lose."))
            (true
              ; Croupier get new card until points
              ; are equal or greater than points of player
              (while (and (< c p) (!= c -1))
                (push (pop carte) mano-c -1)
                (setq c (points mano-c))
                ;(print mano-c { } c) (read-line)
              )
              (println "My hand: " mano-c { } c)
              ; check the result of the game
              (cond ((and (> c p) (<= c 21)) (println "You lose."))
                    ((= c p) (println "Game draw."))
                    ((< c p) (println "You win.")))))))))

Proviamo:

(blackjack)
;-> Your hand: (8)
;-> Your hand: (8 10)
;-> Your hand: (8 10) 18
;-> My hand: (A 6 3) 20
;-> You lose.
;-> Your hand: (10)
;-> Your hand: (10 8)
;-> Your hand: (10 8) 18
;-> My hand: (10 10) 20
;-> You lose.
;-> Your hand: (10)
;-> Your hand: (10 10)
;-> Your hand: (10 10) 20
;-> My hand: (2 5 10 A 7) -1
;-> You win.
;-> Your hand: (8)
;-> Your hand: (8 3)
;-> Your hand: (8 3 3)
;-> Your hand: (8 3 3 10)
;-> Your hand: (8 3 3 10) -1
;-> You lose.
;-> Your hand: (5)
;-> Your hand: (5 10)
;-> Your hand: (5 10) 15
;-> My hand: (8 A) 19
;-> You lose.
;-> Your hand: (10)
;-> Your hand: (10 8)
;-> Your hand: (10 8) 18
;-> My hand: (4 4 6 10) -1
;-> You win.
;-> Your hand: (3)
;-> Game-Over

(blackjack)
;-> Your hand: (10)
;-> Your hand: (10 10)
;-> Your hand: (10 10) 20
;-> My hand: (3 10 4 2 2) 21
;-> You lose.
;-> Your hand: (8)
;-> Your hand: (8 10)
;-> Your hand: (8 10) 18
;-> My hand: (7 2 10) 19
;-> You lose.
;-> Your hand: (2)
;-> Your hand: (2 4)
;-> Your hand: (2 4 6)
;-> Your hand: (2 4 6 6)
;-> Your hand: (2 4 6 6) 18
;-> My hand: (A 10) 21
;-> You lose.
;-> Your hand: (4)
;-> Your hand: (4 10)
;-> Your hand: (4 10 2)
;-> Your hand: (4 10 2) 16
;-> My hand: (8 3 A 10) -1
;-> You win.
;-> Your hand: (10)
;-> Game-Over

============================================================================
