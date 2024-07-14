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

Prima versione (explode e map):
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

Una lista ha elementi diversi se è uguale alla lista dei suoi unici elementi.

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

(sum-N-from-list? numbers 3)
;-> (true (3))

(sum-N-from-list? numbers 0)
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

(filter weird? (sequence 1 1000))
;-> (70 836)

La funzione è molto lenta:

(time (println (filter weird? (sequence 1 1e4))))
;-> (70 836 4030 5830 7192 7912 9272)
;-> 9540315.664999999   ; 2h 39m 316ms

============================================================================

