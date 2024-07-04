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
        (2	(begin
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
        (1	(begin
          (set 'enc (append enc (nth base1 BASE64)))
          (set 'enc (append enc (nth base2 BASE64)))
          (set 'enc (append enc "=="))
          (set 'dat "")))
        (2	(begin
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

============================================================================

