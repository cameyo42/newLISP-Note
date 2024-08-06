================

 NOTE LIBERE 25

================

  L'irrilevanza dell'uomo è superata solo dalla sua tendenza a sopravvalutarsi.

---------------------
How to crash the REPL
---------------------

(define (crash)
  (print "Crash after 2 seconds...")
  (sleep 2000)
  (setq crash nil))

(crash)

(define (auto-delete)
  (println "The last run...")
  (setq s (eval-string "(define (kill) (setq auto-delete nil))"))
  (kill))

(auto-delete)


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


----------------------------------
Numeri pari e dispari in una lista
----------------------------------

Data una lista (anche annidata) di numeri interi, scrivere una funzione che restituisce:
  1) -1 se i numeri pari sono in numero maggiore dei numeri dispari
  2) 0 se i numeri pari sono in numero uguale ai numeri dispari
  3) +1 se i numeri pari sono in numero minore dei numeri dispari

(define (even-odd lst)
  (letn ( (fl (flat lst))
          (diff (- (length (filter even? fl)) (length (filter odd? fl)))) )
    (cond ((zero? diff) 0) ((> diff 0) -1) ((< diff 0) 1))))

Proviamo:

(even-odd '((1 2 (3)) (4 (5 (6))) ((7 8) 9)))
;-> 1
(even-odd '(5 2 5 2 5 2 2 2))
;-> -1
(even-odd '(3 3 3 2 2 2))
;-> 0

Riduzione della lunghezza della funzione:

cambiare: (cond ((zero? diff) 0) ((> diff 0) 1) ((< diff 0) -1))))
con:      (if (zero? diff) 0 (> diff 0) 1 (< diff 0) -1)))

Numero caratteri: 115

(define (f l)
(letn((l(flat l))(d(-(length(filter even? l))(length(filter odd? l)))))
(if(= d 0)0(> d 0)-1(< d 0)1)))

Proviamo:

(f '((1 2 (3)) (4 (5 (6))) ((7 8) 9)))
;-> 1
(f '(5 2 5 2 5 2 2 2))
;-> -1
(f '(3 3 3 2 2 2))
;-> 0

Per calcolare la lunghezza senza mettere la funzione in una sola riga togliere due caratteri per ogni riga (\r\n) alla lunghezza della funzione selezionata.


------------------
I gatti di Matilde
------------------

Matilde ha meno di 10 gatti e tutti hanno la coda bianca o nera.
Se chiedete a Matilde quanti gatti ha, lei risponde così:
"Prendendo a caso due dei miei gatti, la probabilità che entrambi hanno la coda bianca è del 50%"
Quanti gatti ha Matilde?

Poniamo:
  B = gatti con coda bianca
  N = gatti con coda nera
  T = tutti i gatti

Per avere il 50% di probabilità (cioè 1/2) nelle due scelte, deve risultare:

   B    (B-1)
  --- * ----- = 1/2
   T    (T-1)

Infatti alla prima scelta abbiamo probabilità B/T di avere una coda bianca e alla seconda scelta abbiamo probabilità (B-1)/(T-1) di avere una coda bianca (perchè dobbiamo togliere la coda bianca della prima scelta).
Poichè le due scelte devono verificarsi entrambe, allora la loro probabilità deve essere moltiplicata.
Quindi dobbiamo risolvere la seguente equazione:

 2*B*(B-1) = (T*(T-1))

Poichè T è minore di 10 (e quindi anche B), possiamo risolvere l'equazione provando tutti i numeri interi da 1 a 10.

(define (matilde gatti)
  (for (t 2 gatti)
    (for (b 1 gatti)
      (if (= (* 2 b (- b 1)) (* t (- t 1)))
          (println "Gatti = " t " - Bianca = " b " - Nera = " (- t b))))))

(matilde 9)
;-> Gatti = 4 - Bianca = 3 - Nera = 1

Vediamo quanti gatti con la coda bianca avrebbe potuto avere Matilde senza sapere il numero massimo dei gatti.
Proviamo con meno di 10000 gatti:

(time (matilde 9999))
;-> Gatti = 4 - Bianca = 3 - Nera = 1
;-> Gatti = 21 - Bianca = 15 - Nera = 6
;-> Gatti = 120 - Bianca = 85 - Nera = 35
;-> Gatti = 697 - Bianca = 493 - Nera = 204
;-> Gatti = 4060 - Bianca = 2871 - Nera = 1189
;-> 12407.286


----------------------------------------
Creazione di un algoritmo di ordinamento
----------------------------------------

Data una lista di numeri interi positivi, creare un metodo di ordinamento diverso da quelli conosciuti.
Nota: l'algoritmo non deve essere efficiente, basta che sia in gradoo di ordinare correttamente una lista.

Algoritmo
Copiare la lista data in una lista temporanea
Ciclo affinchè non abbiamo tutti zeri nella lista temporanea
  Diminuire di 1 tutti i valori della lista temporanea
  Ciclo sulla lista temporanea
    Se elemento corrente uguale a zero, allora
      Inserire nella soluzione il valore della lista data con indice corrente.
      Porre a -1 il valore della lista temporanea con indice corrente.
Restituire la soluzione.

(define (my-sort lst op)
  (local (out tmp)
    (setq out '())
    ; copia la lista data
    (setq tmp lst)
    ; ciclo affinchè non ci sono tutti 0 in 'tmp'
    (until (for-all (fn(x) (< x 0)) tmp)
      ; diminuisce di 1 gli elementi della lista 'tmp'
      (setq tmp (map (fn(x) (- x 1)) tmp))
      ; ciclo sulla lista 'tmp' per trovare gli elementi con valore 0
      (dolist (el tmp)
        ; se elemento correte = 0, allora
        ; aggiorna la soluzione e pone a -1 l'elemento corrente di 'tmp'
        (when (zero? el) (push (lst $idx) out -1) (setq (tmp $idx) -1)))
    )
    ; controllo ordinamento crescente o decrescente
    (if (= op '>) (reverse out) out)))

Proviamo:

(my-sort '(1 4 3 6 2 9 2))
;-> (1 2 2 3 4 6 9)
(my-sort '(1 4 3 6 2 9 2) '>)
;-> (9 6 4 3 2 2 1)

(my-sort (sequence 10 1))
;-> (1 2 3 4 5 6 7 8 9 10)

(my-sort (sequence 1 10) '>)
;-> (10 9 8 7 6 5 4 3 2 1)


------------------------------------
Circonferenza passante per tre punti
------------------------------------

Dati tre punti sul piano 2D determinare l'equazione della circonferenza che passa per i punti dati.

L'equazione di una circonferenza di raggio R e centro in (Xc, Yc) vale:

  (x - Xc)^2 + (y - Yc)^2 = R^2

Poichè i tre punti passano per la circonferenza, allora risulta:

  (x1 - Xc)^2 + (y1 - Yc)^2 = R^2
  (x2 - Xc)^2 + (y2 - Yc)^2 = R^2
  (x3 - Xc)^2 + (y3 - Yc)^2 = R^2

Questo è un sistema che possiamo risolvere per le incognite Xc, Yc e R.
Comunque per risolvere il problema usiamo una soluzione che non coinvolge le divisioni.
https://math.stackexchange.com/questions/213658/get-the-equation-of-a-circle-when-given-3-points

Calcoliamo i seguenti parametri:

  A = x1(y2 - y3) - y1(x2 - x3) + x2y3 - x3y2
  B = (x1^2 + y1^2)(y3 - y2) + (x2^2 + y2^2)(y1 - y3) + (x3^2 + y3^2)(y2 - y1)
  C = (x1^2 + y1^2)(x2 - x3) + (x2^2 + y2^2)(x3 - x1) + (x3^2 + y3^2)(x1 - x2)
  D = (x1^2 + y1^2)(x3y2 - x2y3) +
      (x2^2 + y2^2)(x1y3 - x3y1) +
      (x3^2 + y3^2)(x2y1 - x1y2)

Adesso il centro della circonferenza è dato da:

  Xc= -B/2A,  Yc= -C/2A

mentre il raggio della circonferenza è dato da:

             B^2 + C^2 - 4AD
  R = sqrt(-------------------)
                  4A^2

Quindi l'equazione della circonferenza vale:

  (x - Xc)^2 + (y - Yc)^2 = R^2

Vediamo un esempio:
Circonferenza con centro in (0,0) e raggio 2.
p1 = (0,2) p2 = (-2,0) p3 = (2,0)

(setq x1 0)  (setq y1 2)
(setq x2 -2) (setq y2 0)
(setq x3 2)  (setq y3 0)

(setq q1 (add (mul x1 x1) (mul y1 y1)))
;-> 4
(setq q2 (add (mul x2 x2) (mul y2 y2)))
;-> 4
(setq q3 (add (mul x3 x3) (mul y3 y3)))
;-> 4

(setq A (add (mul x1 (sub y2 y3)) (- (mul y1 (sub x2 x3))) (mul x2 y3) (- (mul x3 y2))))
;-> 8
(setq B (add (mul q1 (sub y3 y2)) (mul q2 (sub y1 y3)) (mul q3 (sub y2 y1))))
;-> 0
(setq C (add (mul q1 (sub x2 x3)) (mul q2 (sub x3 x1)) (mul q3 (sub x1 x2))))
;-> 0
(setq D (add (mul q1 (sub (mul x3 y2) (mul x2 y3)))
             (mul q2 (sub (mul x1 y3) (mul x3 y1)))
             (mul q3 (sub (mul x2 y1) (mul x1 y2)))))
;-> -32

(setq xc (sub (div B (mul 2 A))))
;-> 0
(setq yc (sub (div C (mul 2 A))))
;-> 0
(setq r (sqrt (div (add (mul B B) (mul C C) (sub (mul 4 A D))) (mul 4 A A))))
;-> 2

Casi particolari:
a) punti collineari
Se i tre punti sono collineari, allora non esiste alcuna circonferanza passante per i tre punti.
Nella soluzione proposta, quando i punti sono collineari il parametro A vale 0.
b) punti coincidenti
Se due o tre punti sono coincidenti, allora esistono infinite circonferenze che passano per i tre punti.
Per due punti passano infinite circonferenze perché dati due punti possiamo scegliere qualsiasi terzo punto non collineare con i primi due e determinare una circonferenza che passa per tutti e tre i punti.
Pertanto, non esiste un numero limitato di circonferenze che possono passare attraverso due punti specificati.
Per un punto possono passare infinite circonferenze perché un punto singolo non determina alcuna limitazione sulla posizione del centro o la lunghezza del raggio della circonferenza.
Si può scegliere un centro qualsiasi nel piano e un raggio qualsiasi, e si otterrà sempre una circonferenza che passa per quel punto specifico.
Anche in questo caso quando ci sono punti coincidenti il parametro A vale 0.

Scriviamo la funzione finale:

(define (circle3points x1 y1 x2 y2 x3 y3)
  (local (q1 q2 q3 A B C D xc yc r)
    ; calcolo dei parametri
    (setq q1 (add (mul x1 x1) (mul y1 y1)))
    (setq q2 (add (mul x2 x2) (mul y2 y2)))
    (setq q3 (add (mul x3 x3) (mul y3 y3)))
    (setq A (add (mul x1 (sub y2 y3))
                (- (mul y1 (sub x2 x3)))
                (mul x2 y3)
                (- (mul x3 y2))))
    ;(println A)
    (setq B (add (mul q1 (sub y3 y2))
                (mul q2 (sub y1 y3))
                (mul q3 (sub y2 y1))))
    (setq C (add (mul q1 (sub x2 x3))
                (mul q2 (sub x3 x1))
                (mul q3 (sub x1 x2))))
    (setq D (add (mul q1 (sub (mul x3 y2) (mul x2 y3)))
                (mul q2 (sub (mul x1 y3) (mul x3 y1)))
                (mul q3 (sub (mul x2 y1) (mul x1 y2)))))
    ;
    (cond
      ; punti coincidenti (infinite circonferenze)
      ; (da verificare PRIMA dei punti collineari)
      ((or (and (= x1 x2) (= y1 y2))
           (and (= x1 x3) (= y1 y3))
           (and (= x2 x3) (= y2 y3))) 'INF)
      ; punti collineari (nessuna circonferenza)
      ((zero? A) nil)
      ; caso standard
      (true
        (setq xc (sub (div B (mul 2 A))))
        (setq yc (sub (div C (mul 2 A))))
        (setq r (sqrt (div (add (mul B B) (mul C C) (sub (mul 4 A D)))
                          (mul 4 A A))))
        (list xc yc r)))))

Proviamo:

Cerchio normale:
(setq x1 0)  (setq y1 2)
(setq x2 -2) (setq y2 0)
(setq x3 2)  (setq y3 0)
(circle3points x1 y1 x2 y2 x3 y3)
;-> (0 0 -2)

Cerchio con punti collineari (p1, p2 e p3)
(setq x1 -2) (setq y1 0)
(setq x2 1)  (setq y2 0)
(setq x3 0)  (setq y3 0)
(circle3points x1 y1 x2 y2 x3 y3)
;-> nil

Cerchio con due punti coincidenti (p1 = p2)
(setq x1 1) (setq y1 1)
(setq x2 1) (setq y2 1)
(setq x3 6) (setq y3 1)
(circle3points x1 y1 x2 y2 x3 y3)
;-> INF

Cerchio con tre punti coincidenti (p1 = p2 = p3)
(setq x1 2) (setq y1 2)
(setq x2 2) (setq y2 2)
(setq x3 2) (setq y3 2)
(circle3points x1 y1 x2 y2 x3 y3)
;-> INF

Cerchio con punti collineari (p1, p2 e p3):
(setq x1 1) (setq y1 1)
(setq x2 1) (setq y2 2)
(setq x3 1) (setq y3 3)
(circle3points x1 y1 x2 y2 x3 y3)
;-> nil

Cerchio normale:
(setq x1 3) (setq y1 0)
(setq x2 3) (setq y2 -6)
(setq x3 0) (setq y3 -3)
(circle3points x1 y1 x2 y2 x3 y3)
;-> (3 -3 3)

Cerchio normale:
(setq x1 4) (setq y1 0)
(setq x2 4) (setq y2 4)
(setq x3 2) (setq y3 2)
(circle3points x1 y1 x2 y2 x3 y3)
;-> (4 2 2)


-----------------------------------------
Numero, doppio, triplo con tutte le cifre
-----------------------------------------

Trovare tutti i numeri fino ad un dato limite che hanno la seguente proprietà:
l'unione del numero, del suo doppio e del suo triplo contengono tutte le cifre da 0 a 9 (in qualunque ordine e anche ripetute).

(define (find-num limite)
  (for (i 1 limite)
    (setq n (explode (extend (string i (* 2 i) (* 3 i)))))
    ; cifre ripetute solo una volta
    ;(when (= (difference '("1" "2" "3" "4" "5" "6" "7" "8" "9" "0") n) '())
    ; cifre ripetute una o più volte
    (when (for-all (fn(x) (>= x 1)) (count '("1" "2" "3" "4" "5" "6" "7" "8" "9" "0") n))
        (println (string i {-} (* 2 i) {-} (* 3 i))))))

Proviamo:

(find-num 1e4)
;-> 1692-3384-5076
;-> 1809-3618-5427
;-> 1902-3804-5706
;-> 1908-3816-5724
;-> ...
;-> 9568-19136-28704
;-> 9678-19356-29034
;-> 9768-19536-29304
;-> 9780-19560-29340


----------------------------------------------------
Combattimento tra due creature fantastiche (ChatGPT)
----------------------------------------------------

Interazione tra l'autore e ChatGPT in merito alla progettazione di un combattimento tra due creature fantastiche (22 luglio 2024).

-----
User:
-----
Supponiamo di avere due creature, un elfo e un goblin che combattono tra loro in un gioco. Quali potrebbero essere i parametri di ogni giocatore? (es. forza, armatura, abilità, ecc.)

Per creare un sistema di combattimento tra un elfo e un goblin in un gioco, potresti considerare i seguenti parametri per ogni giocatore:

1. **Forza (STR)**: Determina il danno fisico che il personaggio può infliggere.
2. **Agilità (AGI)**: Influenza la velocità di attacco, la capacità di schivare e la precisione.
3. **Intelligenza (INT)**: Riguarda l'uso delle abilità magiche e la resistenza magica.
4. **Costituzione (CON)**: Indica la salute e la resistenza fisica, ossia quanti danni può subire prima di cadere.
5. **Armatura (ARM)**: Riduce il danno fisico subito.
6. **Resistenza Magica (MR)**: Riduce il danno magico subito.
7. **Abilità (SKL)**: Include abilità speciali uniche per ogni personaggio, come incantesimi per l'elfo o attacchi furtivi per il goblin.
8. **Punti Salute (HP)**: La quantità di salute totale del personaggio.
9. **Mana (MP)**: La quantità di energia magica disponibile per l'uso di abilità magiche.
10. **Velocità (SPD)**: Determina l'ordine di attacco e la possibilità di effettuare attacchi multipli in un turno.

Esempio di definizione dei parametri per un elfo e un goblin in newLISP:

(define elfo
  '((STR 15)
    (AGI 20)
    (INT 18)
    (CON 12)
    (ARM 10)
    (MR  15)
    (SKL '(arco-freccia incantesimo-cura))
    (HP  100)
    (MP  50)
    (SPD 25)))

(define goblin
  '((STR 18)
    (AGI 15)
    (INT 10)
    (CON 14)
    (ARM 12)
    (MR  8)
    (SKL '(attacco-furtivo veleno))
    (HP  120)
    (MP  20)
    (SPD 20)))

In questo esempio, abbiamo definito gli attributi principali per un elfo e un goblin, considerando i loro punti di forza e debolezza unici. L'elfo è più agile e magico, mentre il goblin è più forte e resistente. Puoi aggiungere ulteriori dettagli e logiche di combattimento in base alle necessità del tuo gioco.

-----
User:
-----
Senza scrivere codice quale potrebbe essere una equazione che tiene conto di tutti i parametri (e i loro valori minimo e massimo)?

--------
ChatGPT:
--------
Per creare un'equazione che tenga conto di tutti i parametri e dei loro valori minimo e massimo, possiamo immaginare una funzione che calcola il "potere di combattimento" (PC) di un personaggio.
Questa funzione potrebbe essere una combinazione ponderata dei vari parametri.
Un'idea potrebbe essere quella di normalizzare ciascun parametro in un intervallo compreso tra 0 e 1 e poi sommare i contributi ponderati di ciascun parametro.

Supponiamo che ciascun parametro possa assumere un valore minimo e massimo:

- Forza (STR): 0-100
- Agilità (AGI): 0-100
- Intelligenza (INT): 0-100
- Costituzione (CON): 0-100
- Armatura (ARM): 0-100
- Resistenza Magica (MR): 0-100
- Abilità (SKL): 0-100 (valutazione complessiva delle abilità speciali)
- Punti Salute (HP): 0-1000
- Mana (MP): 0-1000
- Velocità (SPD): 0-100

L'equazione del "potere di combattimento" (PC) potrebbe essere:

PC = w_{STR}*STR/100 + w_{AGI}*AGI/100 + w_{INT}*INT/100 + w_{CON}*CON/100 +
     w_{ARM}*ARM/100 + w_{MR}*MR/100 + w_{SKL}*SKL/100 + w_{HP}*HP/1000 +
     w_{MP}*MP/1000 + w_{SPD}*SPD/100

Dove w_{STR}, w_{AGI}, w_{INT}, w_{CON}, w_{ARM}, w_{MR}, w_{SKL}, w_{HP}, w_{MP}, w_{SPD} sono i pesi associati a ciascun parametro, che riflettono l'importanza relativa di ogni parametro nel calcolo del potere di combattimento.
I pesi possono essere scelti in base al design del gioco e all'equilibrio desiderato tra i vari parametri.

Esempio di pesi:

- Forza (STR): 0.15
- Agilità (AGI): 0.15
- Intelligenza (INT): 0.1
- Costituzione (CON): 0.1
- Armatura (ARM): 0.1
- Resistenza Magica (MR): 0.1
- Abilità (SKL): 0.1
- Punti Salute (HP): 0.1
- Mana (MP): 0.05
- Velocità (SPD): 0.15

Con questi pesi, l'equazione diventerebbe:

PC = 0.15*STR/100 + 0.15*AGI/100 + 0.1*INT/100 + 0.1*CON/100 +
     0.1*ARM/100 + 0.1*MR/100 + 0.1*SKL/100 + 0.1*HP/1000 +
     0.05*MP/1000 + 0.15*SPD/100

Questa equazione normalizza i valori di ciascun parametro e li combina usando pesi specifici per calcolare un singolo valore rappresentativo della forza complessiva del personaggio.

-----
User:
-----
In uno scontro non possiamo considerare solo la forza complessiva, sarebbe troppo scontato far vincere sempre il piu forte.

--------
ChatGPT:
--------
Hai ragione, uno scontro dovrebbe tenere conto di vari fattori dinamici e non solo della forza complessiva.
Si può pensare a un sistema che include variabili casuali e modificatori di situazioni specifiche per rendere il combattimento più realistico e interessante.
Di seguito, propongo un approccio per modellare un scontro tra due personaggi tenendo conto di più variabili:

1. **Probabilità di Colpire (Pc)**: Influenzata da agilità e velocità.
2. **Danno Inferto (Di)**: Dipende dalla forza e dalle abilità, ridotto dall'armatura e resistenza magica dell'avversario.
3. **Schivata (Sc)**: Dipende dall'agilità.
4. **Critico (Cr)**: Probabilità di colpo critico influenzata da agilità e intelligenza.
5. **Riduzione Danno (Rd)**: Influenzata dall'armatura e dalla resistenza magica.
6. **Abilità Speciali (As)**: Utilizzo delle abilità uniche di ciascun personaggio.

Ecco come potrebbero essere modellate queste variabili:

### 1. Probabilità di Colpire (Pc)
 Pc_{elfo} = AGI_{elfo} + SPD_{elfo} + fattore_casuale
 Pc_{goblin} = AGI_{goblin} + SPD_{goblin} + fattore_casuale

### 2. Danno Inferto (Di)
 Di_{elfo} = STR_{elfo} + danno_abilità - ARM_{goblin}
 Di_{goblin} = STR_{goblin} + danno_abilità - ARM_{elfo}

### 3. Schivata (Sc)
 Sc_{elfo} = AGI_{elfo} + fattore_casuale
 Sc_{goblin} = AGI_{goblin} + fattore_casuale

### 4. Critico (Cr)
 Cr_{elfo} = (AGI_{elfo} + INT_{elfo})*fattore_casuale
 Cr_{goblin} = (AGI_{goblin} + INT_{goblin})*fattore_casuale

### 5. Riduzione Danno (Rd)
 Rd_{elfo} = ARM_{elfo} + MR_{elfo}
 Rd_{goblin} = ARM_{goblin} + MR_{goblin}

### 6. Abilità Speciali (As)
L'uso delle abilità può essere modellato in base a un sistema di punti abilità o di mana:
 As_{elfo} = abilità_usata
 As_{goblin} = abilità_usata

### Equazione di Scontro

La risoluzione di uno scontro potrebbe essere una sequenza iterativa in cui ciascun personaggio attacca e difende. Ecco un esempio di come potrebbe essere strutturato:

1. **Elfo attacca:**
    - Calcolo della probabilità di colpire (Pc_{elfo})
    - Se (Pc_{elfo} > Sc_{goblin}), l'attacco colpisce.
    - Calcolo del danno inferto (Di_{elfo})
    - Se (Cr_{elfo} > threshold), danno critico.
    - Danno effettivo ({Danno Effettivo}_{elfo} = Di_{elfo} - Rd_{goblin})

2. **Goblin attacca:**
    - Calcolo della probabilità di colpire (Pc_{goblin})
    - Se (Pc_{goblin} > Sc_{elfo}), l'attacco colpisce.
    - Calcolo del danno inferto (Di_{goblin})
    - Se (Cr_{goblin} > threshold), danno critico.
    - Danno effettivo ({Danno Effettivo}_{goblin} = Di_{goblin} - Rd_{elfo})

3. **Aggiornamento dei Punti Salute:**
    - HP_{goblin} = HP_{goblin} - {Danno Effettivo}_{elfo}
    - HP_{elfo} = HP_{elfo} - {Danno Effettivo}_{goblin}

4. **Ripetizione fino alla fine del combattimento:**
    - Il combattimento continua finché uno dei due personaggi ha (HP <= 0).

Questo modello combina vari parametri, fattori casuali e abilità speciali per simulare un combattimento più realistico e meno prevedibile, dove non sempre il personaggio con i valori numerici più alti vince automaticamente.

-----
User:
-----

Potresti scrivere un programma che effettua uno scontro?

--------
ChatGPT:
--------

Certo! Possiamo scrivere un semplice programma in newLISP che simula uno scontro tra un elfo e un goblin utilizzando i parametri che abbiamo discusso. Questo programma includerà elementi casuali per rendere il combattimento meno prevedibile.

Ecco un esempio di come potrebbe essere strutturato:

Nota: il seguente programma è stato creato dopo diverse prove e correzioni che non sono riportate (chatGPT commette ancora diversi errori nell'utilizzo di newLISP). Comunque la logica del programma è tutta opera di chatGPT.

(define (random-factor)
  (add 0.9 (mul 0.2 (random))))
;
(define (calculate-hit-probability agi spd)
  (mul (add agi spd) (random-factor)))
;
(define (calculate-damage str skill-damage arm)
  (max 0 (sub (add str skill-damage) arm)))
;
(define (calculate-damage-reduction arm mr)
  (add arm mr))
;
(define (use-skill skills mp)
  (if (and (> (length skills) 0) (> mp 0))
    (first skills)
    0))
;
(define (update-health hp damage)
  (max 0 (sub hp damage)))
;
(define elfo
  (list (list 'STR 15)
        (list 'AGI 20)
        (list 'INT 18)
        (list 'CON 12)
        (list 'ARM 10)
        (list 'MR 15)
        (list 'SKL (list 10 5)) ; Danni abilità
        (list 'HP 100)
        (list 'MP 50)
        (list 'SPD 25)))
;
(define goblin
  (list (list 'STR 18)
        (list 'AGI 15)
        (list 'INT 10)
        (list 'CON 14)
        (list 'ARM 12)
        (list 'MR 8)
        (list 'SKL (list 12 8)) ; Danni abilità
        (list 'HP 120)
        (list 'MP 20)
        (list 'SPD 20)))
;
(define (get-value character key)
  (letn (val (assoc key character))
    (if val
      (last val)
      0)))

(define (fight elfo goblin)
  (letn ((rounds 1)
         (elfo-hp (get-value elfo 'HP))
         (goblin-hp (get-value goblin 'HP))
         (elfo-mp (get-value elfo 'MP))
         (goblin-mp (get-value goblin 'MP)))
    (while (and (> elfo-hp 0) (> goblin-hp 0))
      (letn ((elfo-hit-probability (calculate-hit-probability (get-value elfo 'AGI) (get-value elfo 'SPD)))
             (goblin-hit-probability (calculate-hit-probability (get-value goblin 'AGI) (get-value goblin 'SPD)))
             (elfo-damage (calculate-damage (get-value elfo 'STR) (use-skill (get-value elfo 'SKL) elfo-mp) (get-value goblin 'ARM)))
             (goblin-damage (calculate-damage (get-value goblin 'STR) (use-skill (get-value goblin 'SKL) goblin-mp) (get-value elfo 'ARM)))
             (elfo-damage-reduction (calculate-damage-reduction (get-value goblin 'ARM) (get-value goblin 'MR)))
             (goblin-damage-reduction (calculate-damage-reduction (get-value elfo 'ARM) (get-value elfo 'MR))))
        (if (< (random) elfo-hit-probability)
          (setq goblin-hp (update-health goblin-hp (add elfo-damage elfo-damage-reduction))))
        (if (< (random) goblin-hit-probability)
          (setq elfo-hp (update-health elfo-hp (add goblin-damage goblin-damage-reduction))))
        (println "Round " rounds ": Elfo HP " elfo-hp ", Goblin HP " goblin-hp)
        (setq rounds (add rounds 1))
        (read-line)))
    (if (<= elfo-hp 0)
      (println "Il goblin ha vinto!")
      (println "L'elfo ha vinto!"))))

(fight elfo goblin)
;-> Round 1: Elfo HP 55, Goblin HP 87
;-> Round 2: Elfo HP 10, Goblin HP 54
;-> Round 3: Elfo HP 0, Goblin HP 21
;-> Il goblin ha vinto!


----------------------------
Numero minimo con N divisori
----------------------------

Calcolare la seguente sequenza:

a(n) = Numero più piccolo con esattamente n divisori

Sequenza OEIS: A005179
Smallest number with exactly n divisors.
  1, 2, 4, 6, 16, 12, 64, 24, 36, 48, 1024, 60, 4096, 192, 144, 120, 65536,
  180, 262144, 240, 576, 3072, 4194304, 360, 1296, 12288, 900, 960, 268435456,
  720, 1073741824, 840, 9216, 196608, 5184, 1260, 68719476736, 786432, 36864,
  1680, 1099511627776, 2880, ...

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
    (letn ( (fattori (factor num))
            (unici (unique fattori)) )
      (transpose (list unici (count unici fattori))))))

(define (divisors-count num)
"Count the divisors of an integer number"
  (if (= num 1)
      1
      (let (lst (factor-group num))
        (apply * (map (fn(x) (+ 1 (last x))) lst)))))

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
           (setq cur-divisor (* cur-divisor (f cur-index 0)))))))

Il problema è che non sappiamo quale è il numero massimo di divisori di tutti i numeri da 1 a N.
Vediamo per alcuni casi quale è il numero massimo di divisori:

(apply max (map divisors-count (sequence 1 100)))
;-> 12
(apply max (map divisors-count (sequence 1 1e3)))
;-> 64
(apply max (map divisors-count (sequence 1 1e6)))
;-> 240
(time (println (apply max (map divisors-count (sequence 1 1e7)))))
;-> 448
;-> 35550.178

Poi dobbiamo controllare che esistano tutti i divisori da 1 fino al numero massimo.

Algoritmo
Calcoliamo il numero di tutti i divisori dei numeri da 1 fino ad un milione.
Creiamo una lista ordinata in modo crescente con elementi del tipo:
  (numero-divisori numero)
esempio: ((1 1) (2 2) (2 3) (2 5) (2 7) (3 4) (3 9) (4 6) (4 8) (4 10))
Ciclo k da 1 al limite dato
  Cerchiamo sulla lista l'elemento (k ?), (k=numero-divisori ?=numero)
  se esiste inseriamo il valore trovato in ? nella soluzione
  se non esiste inseriamo nil nella soluzione

(define (seq limite)
  (local (out all)
    (setq out '(0))
    (setq all (sort (map (fn(x) (list (divisors-count x) x)) (sequence 1 1e6))))
    ;(setq all (map (fn(x) (list x (divisors-count x))) (sequence 1 1e6)))
    (for (k 1 limite)
      (cond ((find (list k '?) all match)
              (push ($0 1) out -1))
            (true (push nil out -1))))
    out))

Proviamo:

(time (println (setq d (seq 100))))
;-> (0 1 2 4 6 16 12 64 24 36 48 1024 60 4096 192 144 120 65536 180 262144
;->  240 576 3072 nil 360 1296 12288 900 960 nil 720 nil 840 9216 196608
;->  5184 1260 nil 786432 36864 1680 nil 2880 nil 15360 3600 nil nil 2520
;->  46656 6480 589824 61440 nil 6300 82944 6720 nil nil nil 5040 nil nil
;->  14400 7560 331776 46080 nil 983040 nil 25920 nil 10080 nil nil 32400
;->  nil 746496 184320 nil 15120 44100 nil nil 20160 nil nil nil 107520 nil
;->  25200 nil nil nil nil nil 27720 nil 233280 230400 45360)
;-> 17970.287 ; 18 secondi

Quali sono i numeri di cui non abbiamo trovato il valore del numero di divisori nella lista dei divisori?

(ref-all nil d)
;-> ((23) (29) (31) (37) (41) (43) (46) (47) (53) (57) (58) (59) (61) (62)
;->  (67) (69) (71) (73) (74) (76) (79) (82) (83) (85) (86) (87) (89) (91)
;->  (92) (93) (94) (95) (97))

Questo vuol dire che non esiste alcun numero tra 1 e 1 milione che ha, per esempio, 23 divisori.
Il numero più piccolo che ha 23 divisori è 4194304.
Il numero più piccolo che ha 29 divisori è 268435456.
Il numero più piccolo che ha 31 divisori è 1073741824.

Il metodo di calcolare il numero di divisori per ogni numero è lento:

(define (t n) (for (i 1 n) (divisors-count n)))

(time (t 100))
;-> 0
(time (t 1e4))
;-> 31.24
(time (t 1e5))
;-> 234.311
(time (t 1e6))
;-> 2437.72
(time (t 1e7))
;-> 26467.224

Possiamo migliorare l'efficienza del calcolo di tutti i divisori utilizzando un approccio simile al crivello di Eratostene.
Invece di calcolare i divisori di ogni numero singolarmente, possiamo iterare sui numeri e aggiornare i contatori dei divisori per i loro multipli. Questo riduce il numero di operazioni necessarie.
Per fare questo utilizziamo due cicli for.
Il primo ciclo itera attraverso ogni numero i da 1 a N.
Il secondo ciclo itera attraverso ogni multiplo j di i e incrementa il contatore dei divisori corrispondente nel vettore soluzione (out).
Il vettore ha dimensione (N + 1) per iniziare l'indicizzazione da 1.
Usiamo un vettore perchè è più veloce di una lista, ma la funzione restituisce una lista.

(define (divisors-up-to-N N)
  ; Inizializza un vettore di contatori dei divisori a 0
  (let (out (array (+ N 1) '(0)))
    (for (i 1 N)
      (for (j i N i)
        (++ (out j))))
    ; Restituisce una lista senza il primo elemento
    (rest (array-list out))))

Proviamo:

(divisors-up-to-N 10)
;-> (1 2 2 3 2 4 2 4 3 4)

Vediamo se le due funzioni producono gli stessi risultati:

(= (map divisors-count (sequence 1 1e5)) (divisors-up-to-N 1e5))
;-> true

Vediamo la velocità delle due funzioni:

(time (map divisors-count (sequence 1 1e5)))
;-> 218.689
(time (divisors-up-to-N 1e5))
;-> 62.476
(time (map divisors-count (sequence 1 1e6)))
;-> 2640.756
(time (divisors-up-to-N 1e6))
;-> 1968.92
(time (divisors-up-to-N 1e7))
;-> 22049.074
(time (divisors-up-to-N 1e8))
;-> 273979.481

Proviamo ad usare questa nuova funzione "divisors-up-to-N":

(define (seq2 limite upto)
  (local (out all)
    (setq out '(0))
    (setq all (sort (map list (divisors-up-to-N upto) (sequence 1 upto))))
    (for (k 1 limite)
      (cond ((find (list k '?) all match)
              (push ($0 1) out -1))
            (true (push nil out -1))))
    out))

(time (println (setq d2 (seq2 100 1e6))))
;-> (0 1 2 4 6 16 12 64 24 36 48 1024 60 4096 192 144 120 65536 180 262144
;->  240 576 3072 nil 360 1296 12288 900 960 nil 720 nil 840 9216 196608
;->  5184 1260 nil 786432 36864 1680 nil 2880 nil 15360 3600 nil nil 2520
;->  46656 6480 589824 61440 nil 6300 82944 6720 nil nil nil 5040 nil nil
;->  14400 7560 331776 46080 nil 983040 nil 25920 nil 10080 nil nil 32400
;->  nil 746496 184320 nil 15120 44100 nil nil 20160 nil nil nil 107520 nil
;->  25200 nil nil nil nil nil 27720 nil 233280 230400 45360)
;-> 16048.442 ; 16 secondi

Non abbiamo migliorato molto la velocità perchè l'espressione che impiega più tempo è "find".

(ref-all nil d2)
;-> ((23) (29) (31) (37) (41) (43) (46) (47) (53) (57) (58) (59) (61) (62)
;->  (67) (69) (71) (73) (74) (76) (79) (82) (83) (85) (86) (87) (89) (91)
;->  (92) (93) (94) (95) (97))

Facciamo l'ultimo calcolo:

(time (println (setq d2 (seq2 100 1e8))))
;-> (0 1 2 4 6 16 12 64 24 36 48 1024 60 4096 192 144 120 65536 180 262144
;->  240 576 3072 4194304 360 1296 12288 900 960 nil 720 nil 840 9216 196608
;->  5184 1260 nil 786432 36864 1680 nil 2880 nil 15360 3600 12582912 nil 2520
;->  46656 6480 589824 61440 nil 6300 82944 6720 2359296 nil nil 5040 nil nil
;->  14400 7560 331776 46080 nil 983040 37748736 25920 nil 10080 nil nil 32400
;->  3932160 746496 184320 nil 15120 44100 nil nil 20160 5308416 nil nil 107520
;->  nil 25200 2985984 62914560 nil nil 21233664 27720 nil 233280 230400 45360)
;-> 1832762.63  ; 30m 32s 762ms


---------------------------------
Esercizi di aritmetica elementare
---------------------------------

Scriviamo un programma che genera espressioni aritmetiche da risolvere.
Il programma deve proporre un predeterminato numero di espressioni aritmetiche elementari del seguente tipo:

  valore1 operatore valore2 = (risultato)

dove 'valore1' e 'valore2' sono numeri da 0 a 10,
mentre 'operatore' può valere +, -, * oppure /.
I valori e l'operatore devono essere casuali per ogni espressione.
I valori devono essere inferiori ad un valore massimo predefinito.
Il risultato non deve essere mostrato all'utente.
Per ogni espressione l'utente deve inserire la risposta e il programma verificherà la sua correttezza e il tempo impiegato per rispondere.
Al termine di tutte le espressioni deve essere mostrato un riepilogo dei risultati e il tempo impiegato per rispondere a tutte le operazioni.

Esempio:
  Esercizi di aritmetica (3)

  1)  1 * 5 = 5
      1 * 5 = 5
  Corretto. (1975 msec)

  2)  7 + 10 = 23
      7 + 10 = 17
  Errato. (1603 msec)

  3)  3 * 1 = 3
      3 * 1 = 3
  Corretto. (1269 msec)

  Domande totali: 3
  Risposte corrette: 2
  Risposte errate: 1
  Tempo impiegato: 4.847 secondi.

Per adesso non utilizziamo l'operatore di divisione "/".

(define (select_operator) ('(+ - *) (rand 3)))

Per adesso il valore massimo vale 10.

(define (select_number) (rand 11))

Funzione che genera espressioni aritmetiche da risolvere:
(versione senza divisione e valore massimo = 10)

(define (esercizi num)
  (local (si no totale start val1 val2 op result res ans-time elapsed)
    (setq si 0)
    (setq no 0)
    (setq totale num)
    (println "Esercizi di aritmetica (" totale ")\n")
    (setq start (time-of-day))
    (for (i 1 totale)
      (setq val1 (select_number))
      (setq val2 (select_number))
      (setq op (select_operator))
      (setq result (eval-string (string "(" op " " val1 " " val2 ")")))
      (setq go (time-of-day))
      (print (string i ")  " val1 " " op " " val2 " = "))
      (read-line)
      (setq res (int (current-line) 0 10))
      (setq ans-time (int (- (time-of-day) go)))
      (println (string "    " val1 " " op " " val2 " = " result))
      (cond ((= res result)
             (++ si)
             (println "Corretto. (" ans-time " msec)"))
            ((!= res result)
             (++ no)
             (println "Errato. (" ans-time " msec)")))
      ;(println (string "(" op " " val1 " " val2 ") = " result)))))
      (println)
    )
    (setq elapsed (div (- (time-of-day) start) 1000))
    (println "Domande totali: " totale)
    (println "Risposte corrette: " si)
    (println "Risposte errate: " no)
    (println "Tempo impiegato: " elapsed " secondi.") '>))

Proviamo:

(esercizi 3)
;-> Esercizi di aritmetica (3)
;->
;-> 1)  3 + 1 = 4
;->     3 + 1 = 4
;-> Corretto. (1814 msec)
;->
;-> 2)  9 * 9 = 81
;->     9 * 9 = 81
;-> Corretto. (2016 msec)
;->
;-> 3)  1 + 3 = 5
;->     1 + 3 = 4
;-> Errato. (1754 msec)
;->
;-> Domande totali: 3
;-> Risposte corrette: 2
;-> Risposte errate: 1
;-> Tempo impiegato: 5.584 secondi.

Per aggiungere anche l'operatore di divisione "/" dobbiamo inserire alcuni controlli.
In particolare quando l'operatore vale "/", allora val2 deve essere sempre diverso da 0 (perchè non è possibile dividere per 0).

(define (select_operator) ('(+ - * /) (rand 4)))

Inoltre modifichiamo il programma in modo da predefinire anche il valore massimo dei numeri da utilizzare nelle espressioni.

(define (select_number max-number) (rand (+ max-number 1)))

Funzione che genera espressioni aritmetiche da risolvere:

(define (esercizi totale max-value)
  (local (si no start val1 val2 op result res ans-time elapsed)
    (setq si 0)
    (setq no 0)
    (println "Esercizi di aritmetica (" totale ")\n")
    (setq start (time-of-day))
    (for (i 1 totale)
      (setq val1 (select_number max-value))
      (setq val2 (select_number max-value))
      (setq op (select_operator))
      (setq result (eval-string (string "(" op " " val1 " " val2 ")")))
      (setq go (time-of-day))
      (print (string i ")  " val1 " " op " " val2 " = "))
      (read-line)
      (setq res (int (current-line) 0 10))
      (setq ans-time (int (- (time-of-day) go)))
      (println (string "    " val1 " " op " " val2 " = " result))
      (cond ((= res result)
             (++ si)
             (println "Corretto. (" ans-time " msec)"))
            ((!= res result)
             (++ no)
             (println "Errato. (" ans-time " msec)")))
      ;(println (string "(" op " " val1 " " val2 ") = " result)))))
    )
    (setq elapsed (div (- (time-of-day) start) 1000))
    (println)
    (println "Domande totali: " totale)
    (println "Risposte corrette: " si)
    (println "Risposte errate: " no)
    (println "Tempo impiegato: " elapsed " secondi.") '>))

Proviamo:

(esercizi 5 20)
;-> Esercizi di aritmetica (5)
;->
;-> 1)  12 * 13 = 156
;->     12 * 13 = 156
;-> Corretto. (7625 msec)
;-> 2)  16 * 3 = 48
;->     16 * 3 = 48
;-> Corretto. (3140 msec)
;-> 3)  18 - 19 = -1
;->     18 - 19 = -1
;-> Corretto. (13623 msec)
;-> 4)  15 + 0 = 15
;->     15 + 0 = 15
;-> Corretto. (2704 msec)
;-> 5)  20 / 6 = 3
;->     20 / 6 = 3
;-> Corretto. (3439 msec)
;->
;-> Domande totali: 5
;-> Risposte corrette: 5
;-> Risposte errate: 0
;-> Tempo impiegato: 30.563 secondi.

Per finire un programma solo per la tavola pitagorica (cioè genera espressioni per imparare le tabelline).

(define (tabelline totale)
  (local (si no start val1 val2 op result res ans-time elapsed)
    (setq si 0)
    (setq no 0)
    (println "Esercizi sulla tavola pitagorica (" totale ")")
    (setq start (time-of-day))
    (for (i 1 totale)
      (setq val1 (+ 1 (rand 12)))
      (setq val2 (+ 1 (rand 12)))
      (setq result (* val1 val2))
      (setq go (time-of-day))
      (print (string i ")  " val1 " * " val2 " = "))
      (read-line)
      (setq res (int (current-line) 0 10))
      (setq ans-time (int (- (time-of-day) go)))
      (println (string "    " val1 " * " val2 " = " result))
      (cond ((= res result)
             (++ si)
             (println "Corretto. (" ans-time " msec)"))
            ((!= res result)
             (++ no)
             (println "Errato. (" ans-time " msec)")))
    )
    (println)
    (setq elapsed (div (- (time-of-day) start) 1000))
    (println "Domande totali: " totale)
    (println "Risposte corrette: " si)
    (println "Risposte errate: " no)
    (println "Tempo impiegato: " elapsed " secondi.") '>))

Proviamo:

(tabelline 10)
;-> Esercizi sulla tavola pitagoricadi aritmetica (10)
;-> 1)  4 * 6 = 24
;->     4 * 6 = 24
;-> Corretto. (1876 msec)
;-> 2)  7 * 2 = 14
;->     7 * 2 = 14
;-> Corretto. (1397 msec)
;-> 3)  4 * 9 = 36
;->     4 * 9 = 36
;-> Corretto. (2265 msec)
;-> 4)  4 * 10 = 40
;->     4 * 10 = 40
;-> Corretto. (1617 msec)
;-> 5)  12 * 11 = 132
;->     12 * 11 = 132
;-> Corretto. (15724 msec)
;-> 6)  9 * 4 = 36
;->     9 * 4 = 36
;-> Corretto. (2413 msec)
;-> 7)  12 * 2 = 24
;->     12 * 2 = 24
;-> Corretto. (1457 msec)
;-> 8)  1 * 10 = 10
;->     1 * 10 = 10
;-> Corretto. (1875 msec)
;-> 9)  7 * 8 = 56
;->     7 * 8 = 56
;-> Corretto. (1501 msec)
;-> 10)  12 * 1 = 12
;->     12 * 1 = 12
;-> Corretto. (1281 msec)
;->
;-> Domande totali: 10
;-> Risposte corrette: 10
;-> Risposte errate: 0
;-> Tempo impiegato: 31.438 secondi.


------------------------------------
Mucche, galline e animali fantastici
------------------------------------

Il tradizionale problema delle mucche e delle galline è il seguente:

  Un contadino alleva mucche e galline nella sua fattoria.
  Gli animali hanno in totale 24 teste e 68 zampe.
  Quante mucche e quante galline ha il contadino?

Si tratta di un problema per introdurre i giovani studenti al concetto di sistema di equazioni.
Ponendo G = numero galline e M = numero mucche otteniamo il sistema:

1.   G + M = 24
2.   2*G + 4*M = 68

Vediamo la soluzione:

dalla 1.
  M = 24 - G
sostituiamo nella 2.
  2*G + 4*(24 - G) = 68
  2*G + 96 - 4*G = 68
  G = (96 - 68)/2 = 14
quindi:
  M = 24 - G = 10

Il contadino ha 10 mucche e 14 galline.

Un contadino extra-terrestre possiede animali diversi da mucche e galline.
Infatti egli alleva due tipi di animali A e B in cui:

 TesteA, è il numero di teste dell'animale A
 TesteA, è il numero di zampe dell'animale A
 ZampeB, è il numero di teste dell'animale B
 ZampeB, è il numero di zampe dell'animale B
 T, è il numero totale delle teste degli animali
 Z, è il numero totale delle zampe degli animali

Il sistema di equazioni diventa:

1)  A*TesteA + B*TesteB = T
2)  A*ZampeA + B*ZampeB = Z

Calcoliamo la soluzione:

  A = (T - B*TB)/TA

  ZA*T - Z*B*TB
  ------------- + B*ZB = Z
       TA

  ZA*T - ZA*B*TB + B*ZB*TA
  ------------------------ = Z
             TA

  ZA*T - ZA*B*TB + B*ZB*TA = Z*TA

  B*(ZB*TA - ZA*TB) = TA*Z - ZA*T

        TA*Z - ZA*T
  B = ---------------
       ZB*TA - ZA*TB

       (T - B*TB)
  A = ------------
           TA

Sistema di equazioni:

 A*ta + B*tb = t
 A*za + B*zb = z

Soluzione:

 A = (tb*z - t*zb)/(tb*za - ta*zb)
 B = (ta*z - t*za)/(ta*zb - tb*za)
     con (tb*za != ta*zb)

Nota: per essere valida la soluzione deve avere solo numeri interi (non esistono 2.25 animali vivi)

(define (animals ta tb za zb t z)
    ; tb*za = ta*zb --> nessuna soluzione
    (if ((zero? (* tb za) (* ta zb))
        nil
        ;else
        ; calcolo soluzione
        (local (A B)
          (setq A (div (sub (mul tb z) (mul t zb))
                      (sub (mul tb za) (mul ta zb))))
          (setq B (div (sub (mul ta z) (mul t za))
                      (sub (mul ta zb) (mul tb za))))
          ; stampa soluzione
          (println A { } B)
          ; verifica soluzioni con numeri interi
          (if (and (= A (int A)) (= B (int B))) (list A B) nil)))))

Proviamo:

(animals 1 1 2 4 24 68)
;-> (14 10)

(animals 4 2 8 16 210 672)
;-> (42 21)

(animals 4 3 4 5 100 200)
;-> -12.5 50
;-> nil


-------
GOTO 10
-------

"10 PRINT CHR$(205.5+RND(1)): GOTO 10" (Software Studies)
di Nick Montfort, Patsy Baudoin, John Bell, Ian Bogost, Jeremy Douglass

Questo libro prende una singola riga di codice (il programma BASIC per il Commodore 64 del titolo) e la usa come lente attraverso la quale considerare il fenomeno del "creative computing" e il modo in cui i programmi per computer appartengono alla cultura (vedi immagine di copertina "goto10-book.png" nella cartella "data".

L'espressione BASIC del Commodore 64:

  10 PRINT CHR$(205.5+RND(1)): GOTO 10

genera un motivo grafico casuale (vedi immagine "goto10-commodore64.png" nella cartella "data") utilizzando solo i caratteri '\' e '/'.

In newLISP il programma può essere simulato nel terminale:

(char "\\")
;-> 92
(char "/")
;-> 47

(define (goto10) (while (print ('("\\" "/") (rand 2)))))

(goto10)
;-> /\\\//\\\\\\\\//\/////\/\\/\/\/\\/\\\//\\/\\///\\/\///\/\\///\\\\/\
;-> \\//////\\\\\\/////\///\///\\\\/\\\/\\\\\/\\\/\//\/\/\\/\//\\//\\\/
;-> //\//\\\\/\\\\/\/\\///\/\/\\/\\\\/\\\//\\\\//\\//\//\\\//\\\\///\/\
;-> \\\\\/\//\//\//\/\/\\//\/////\\\///\\/////\\\/\////\\\\\//\\/////\/
;-> /\/\//\///\/\\////\\/\//\///\/\//\\\\////\\\/\\//\//\\//\/\//////\/
;-> /\\/\/\//\\///\\\/\\\\\/\\\/\\\\///\\\/\///\\//\\/\///\//\\/\\\\///
;-> /\///////\////\\\/\//\\/\\/\///\\/\//\////\/\\\\/\//\\\\//\\\\/\\/\
;-> /\\\///\\///\\\\/\\//\//\/\/\/\\//\//\//\\\\//\\\\/\/\\\\/\\\/\\/\/
;-> \\/\\/\\/\\/\/\///\/\\/\\////\\\//\/\\////\\/\\\\//\/\/\\///\///\/\
;-> /\//\//\///\//\\/\\///\////\\///\/\\/\///\\\\/\/\\\\\\///\/\/\\/\\\
;-> ///\////\/\\/\\\/\/\///\\/\\\/\\\////\////\\/\\///////\\\////\/\/\/
;-> \/\////////\/\\\\\\///\/\\\\//////\/\\\\\//\/\\\\\\/\/\//\/\\\/\\//
;-> \\/\/\//\/\\\\\//\\/////\\\\/////\/\/\\\\/\//\\\\\////\//\\\\/\\///
;-> \/\\/\//\///\/\//\\\\/////\//\\\//\/\//\////\//\\\/\/\//\\\/\/\/\\/
;-> /\//\//\////\/\/\\\\//\\\\/\\/\//\\\\\/\\\\\\\\\\\\/\///\//////\\\/
;-> //\/\/\//\/\\//\//\/\\////\\\/\\\/\\/\//\//\/\\\\\\/\\\\\\/\/\/\/\\
;-> /\///\///\\\\\\///\/\\/\\/\\\\\\///\/\/\\\/\/\\///\//\//\\\////\/\\
;-> \\//\/////\\//\//\/\//\\\\\//\\\\\\/\//////\\//\//\\/\/\/\\\//\\\//
;-> \//\/\/\//\\//\\///\/\\\//\/\\\///\/////\\\\\/\/\//\/\/\///\//\\\\/
;-> ...

La stessa funzione compressa:

(define(g)(while(print('("\\""/")(rand 2)))))

(g)

Versione interattiva:

(define (goto10 line)
  (while true
    (for (i 1 line) (print ('("\\" "/") (rand 2))))
    (read-line)))

(goto10 40)
;-> /\/\/\////\//\\\/\////\\\\\\\\//\/\\/\\/
;-> /\\/\\/\\//\//\///\///\/\\/\////\\/\\\/\
;-> /\//\\///\\\\\\/\\\\//\//////\\/\\\/////
;-> /\\///\\\//\\//\\\/\//\///\\\/\/\\\\\\\/
;-> /\//\/\/\//\////\\\/\\/\\\\\/\/\\\\/\///
;-> \\\//\//\\\\\//\\\/\\\//\\//\//\/\\///\/
;-> /////\//////\/\/\//\\\\/\\\\\///\\//\\/\
;-> \/////\/\\/\\\\///\//\\//\/\//\/\\//\///
;-> ///\//\////\/\///\/\/\\\////\////\\/\\\\

Utilizzando il linguaggio Processing otteniamo un risultato molto più gradevole dal punto di vista grafico:

// Programma che simula GOTO10 in Processing
// goto10.pde
// Change spacing and threshold to change motif
int x = 0;
int y = 0;
int spacing = 10;
float threshold = 0.5;
void setup()
{
  x = 0;
  y = 0;
  spacing = 10;
  size(400,400);
  background(0);
}

void draw()
{
  stroke(255);
  if (random(1) > threshold)
    { line(x, y, x + spacing, y + spacing); }
    else
    { line(x, y + spacing, x + spacing, y); }
  x = x + spacing;
  if (x > width )
    { x = 0; y = y + spacing; }
}

Potete vedere l'output del programma nell'immagine "goto10-pde.png" nella cartella "data".


-----------------------------------------
Incasellare un testo in un rettangolo MxN
-----------------------------------------

Dato un testo formato da caratteri ASCII (9, 10, 13, 32-126), inserire il testo in un rettangolo di dimensioni date MxN.

Specifiche:
a) I caratteri line-feed "\n" e return "\r" devono essere eliminati
b) il carattere Tab "\t" deve essere sostituito con uno spazio " "
c) se il testo è più lungo del rettangolo, allora viene troncato.
d) se il testo è più corto del rettangolo, allora viene allungato con spazi.

Nota:
 9 = Tab
10 = Line-feed "\n"
13 = Return "\r"
32-126 = caratteri ASCII stampabili

Esempio:
testo =
"Testo da inserire in un rettangolo"
M = 4
N = 10
output:
Testo da i
nserire in
 un rettan
golo

Esempio:
testo =
"Riga 1 del testo da inserire
Riga 2 del testo da inserire"
M = 4
N = 10
output:
Riga 1 del t
esto da inse
rireRiga 2 d
el testo da

Funzione che incasella un testo in un rettangolo MxN:

(define (text-rect txt M N)
  ; remove line-feed \n from text
  (replace "\r" txt "")
  ; remove return \r from text
  (replace "\n" txt "")
  ; replace Tab with 2 spaces -> "  "
  (replace "\t" txt "  ")
  ;(println txt)
  ; number of matrix elements
  (setq len-mat (* M N))
  ; lenght of text
  (setq len-text (length txt))
  ;
  (cond
    ; elementi matrice > lunghezza testo
    ((> len-mat len-text)
      ; allunga il testo con un numero di spazi pari alla differenza
      ; tra la lunghezza della matrice e la lughezza del testo
      (extend txt (dup " " (- len-mat len-text))))
    ; elementi matrice < lunghezza testo
    ((< len-mat len-text)
      ; taglia il testo di un numero di caratteri pari alla differenza
      ; tra la lunghezza della matrice e la lunghezza del testo
      (chop txt (- len-mat len-text))))
  ; crea la matrice di caratteri
  (setq m (array M N (explode txt)))
  ; stampa la matrice di caratteri
  (for (r 0 (- M 1)) (for (c 0 (- N 1)) (print (m r c))) (println))
  '>)

Proviamo:

(setq t1 "Questo testo è scritto in un rettangolo di 6 righe e 11 colonne")
(length t1)
;-> 63
(text-rect t1 6 11)
;-> Questo test
;-> o è scritto
;->  in un rett
;-> angolo di 6
;->  righe e 11
;->  colonne

(setq t2 "Riga 1 del testo da inserire
Riga 2 del testo da inserire")
(length t2)
;-> 58
(text-rect t2 7 8)
;-> Riga 1 d
;-> el testo
;->  da inse
;-> rireRiga
;->  2 del t
;-> esto da
;-> inserire

(setq t3
"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
 tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
 quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
 consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
 cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
 non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
(length t3)
;-> 455
; togliamo 2 caratteri per ogni riga con /r/n
(- 455 (* 5 2))
;-> 445
(* 23 20)
;-> 460
(text-rect t3 23 20)
;-> Lorem ipsum dolor si
;-> t amet, consectetur
;-> adipiscing elit, sed
;->  do eiusmod tempor i
;-> ncididunt ut labore
;-> et dolore magna aliq
;-> ua. Ut enim ad minim
;->  veniam, quis nostru
;-> d exercitation ullam
;-> co laboris nisi ut a
;-> liquip ex ea commodo
;->  consequat. Duis aut
;-> e irure dolor in rep
;-> rehenderit in volupt
;-> ate velit esse cillu
;-> m dolore eu fugiat n
;-> ulla pariatur. Excep
;-> teur sint occaecat c
;-> upidatat non proiden
;-> t, sunt in culpa qui
;->  officia deserunt mo
;-> llit anim id est lab
;-> orum.


--------------------
Il semaforo stradale
--------------------

Il semaforo è un segnale luminoso utilizzato prevalentemente nella circolazione stradale presso incroci, attraversamenti pedonali e in altre situazioni in cui sia necessario regolare flussi di traffico potenzialmente in conflitto fra loro.

Esistono tre tipi di semafori:

1) Semaforo a 3 tempi
L'ordine dei colori è: verde, giallo, rosso.

2) Semaforo a 4 tempi
L'ordine dei colori è: rosso, rosso con giallo, verde, giallo.
Il giallo si accende insieme al rosso poco prima che entrambi si spengano lasciando il posto al verde, per avvisare l'automobilista di prepararsi a partire.

3) Semaforo a 5 tempi
L'ordine dei colori è: verde, verde lampeggiante, giallo, rosso, rosso con giallo.
Il verde lampeggia per avvisare l'automobilista dell'imminenza del giallo.

Funzione di setup:

(define (setup)
  (define (cls) (print "\027[H\027[2J")) ; clear screen
  (setq no-color "\027[0;0m") ; reset colors to default
  (setq rosso "\027[0;91m")
  (setq verde "\027[0;92m")
  (setq giallo "\027[0;93m") '>)

(setup)

Funzione che mostra il semaforo con un dato colore (o due colori):

(define (show colore1 colore2)
  (cond ((= colore2 nil) ; un solo colore
          (println colore1 "████")
          (println "████"))
        (true ; due colori
          (println colore1 "████" colore2 "████")
          (println colore1 "████" colore2 "████"))
  )
  (print no-color) '>)

(show rosso)

S3 Colori: verde, giallo, rosso

(define (s3 tv tg tr)
  (while (zero? (read-key true))
    (cls) (show verde)   (sleep tv)
    (cls) (show giallo)  (sleep tg)
    (cls) (show rosso)   (sleep tr))
  (print no-color) '>)

(s3 3000 2000 3000)

L'ordine dei colori è: rosso, rosso con giallo, verde, giallo.

(define (s4 tr trg tv tg)
  (while (zero? (read-key true))
    (cls) (show rosso)        (sleep tr)
    (cls) (show rosso giallo) (sleep trg)
    (cls) (show verde)        (sleep tv)
    (cls) (show giallo)       (sleep tg))
  (print no-color) '>)

(s4 3000 2000 3000 2000)

S5 Colori: verde, verde lampeggiante, giallo, rosso, rosso con giallo.

(define (s5 tv tvl tg tr trg)
  (while (zero? (read-key true))
    (cls) (show verde) (sleep tv)
    (cls)
    ; verde lampeggiante (200 msec)
    (for (i 1 (/ tvl 200))
      (if (odd? i) (show verde)) (sleep 200) (cls))
    (cls) (show giallo)       (sleep tg)
    (cls) (show rosso)        (sleep tr)
    (cls) (show rosso giallo) (sleep trg))
  (print no-color) '>)

(s5 3000 2000 3000 3000 2000)


--------------------------
Gestione di timer multipli
--------------------------

Il linguaggio newLISP non ha un profiler, quindi per determinare la velocità di blocchi di codice possiamo utilizzare la funzione "time" oppure generare dei timer ad hoc.

Scriviamo alcune funzioni che permettono di:
1) Inizializzare un timer
2) Interrogare un timer
3) Fermare un timer
4) Interrogare tutti i timer
5) Resettare tutti i timer

Per memorizzare i timer usiamo una lista associativa con elementi del tipo:

  (nome_timer inizio_timer(msec))

La variabile 'inizio_timer' viene inizializzata dalla funzione "time-of-day" che restituisce il tempo (millisecondi) trascorso dall'inizio del giorno corrente.

Usiamo una variabile globale 'timers' per memorizzare i timer.

Funzione che resetta tutti i timer:

(define (reset-timers) (setq timers '()))

Funzione che inizializza un timer con un dato nome:

(define (start-timer name) (push (list name (time-of-day)) timers))

Funzione che interroga un timer con un dato nome:

(define (check-timer name)
  (if (find (list name '?) timers match)
      ; esiste timer 'name'
      (sub (time-of-day) ($0 1))
      ; non esiste timer 'name'
      -1))

Funzione che interroga tutti i timer:

(define (list-timers) timers)

Funzione che termina un timer con un dato nome:

(define (stop-timer name)
  (if (find (list name '?) timers match)
    ; esiste timer 'name'
    (begin
      (replace $0 timers)
      (sub (time-of-day) ($0 1)))
      ; non esiste timer 'name'
      -1))

Proviamo:

(reset-timers)
;-> ()
(start-timer "uno")
;-> (("uno" 54529246.369))
(check-timer "uno")
;-> 907.6199999973178
(list-timers)
;-> (("uno" 54529246.369))
(start-timer "due")
;-> (("due" 54531891.364) ("uno" 54529246.369))
(check-timer "due")
;-> 829.7360000014305
(list-timers)
;-> (("due" 54531891.364) ("uno" 54529246.369))
(stop-timer "uno")
;-> 5634.070999994874
(stop-timer "due")
;-> 4569.946000002325
(list-timers)
;-> ()

Vediamo un esempio con una funzione:

(vedi "Numero minimo con N divisori" su "Note libere 25")

(define (divisors-up-to-N N)
  ; Inizializza un vettore di contatori dei divisori a 0
  (let (out (array (+ N 1) '(0)))
    (for (i 1 N)
      (for (j i N i)
        (++ (out j))))
    ; Restituisce una lista senza il primo elemento
    (rest (array-list out))))

(define (seq2 limite upto)
  (local (out all)
    ; Reset timers
    (reset-timers)
    (setq out '(0))
    ; start timer "divisori"
    (start-timer "divisori")
    (setq all (sort (map list (divisors-up-to-N upto) (sequence 1 upto))))
    ; stop timer "divisori"
    (println "divisori time: " (stop-timer "divisori"))
    ; start timer "for"
    (start-timer "for")
    (for (k 1 limite)
      (cond ((find (list k '?) all match)
              (push ($0 1) out -1))
            (true (push nil out -1))))
    ; stop timer "for"
    (println "for time: " (stop-timer "for"))
    out))

(time (seq2 100 1e6))
;-> divisori time: 2017.898999996483
;-> for time: 13954.09000000358
;-> 16050.097

Nota: questo metodo non funziona se il programma viene eseguito a cavallo della mezzanotte (infatti "time-of-day" viene resettato a 0 a mezzanotte).

Nota: al posto di "time-of-day" si potrebbe usare la funzione "now" (ma bisogna modificare le funzioni).


-----------------------------------------
Lancio di tre dadi (rilanciando valori 1)
-----------------------------------------

Lanciare 3 dadi, sommare i due valori più alti e aggiungerli al totale.
Caso 1: Ogni 1 ottenuto deve essere tirato ancora una volta.
Caso 2: Ogni 1 ottenuto deve essere tirato fino a ottenere un valore diverso.
Calcolare il valore medio dei lanci e le probabilità di ogni risultato in entrambi i casi.

Caso 1: Ogni 1 ottenuto deve essere tirato ancora una volta.

(define (case1 iter)
  (local (totale valori d1 d2 d3 rolled result probs media)
    (setq totale 0)
    (setq valori (array 13 '(0)))
    (for (i 1 iter)
      ; lancio dei tre dadi e rilancio (una volta) degli 1 ottenuti
      (if (= (setq d1 (+ (rand 6) 1)) 1) (setq d1 (+ (rand 6) 1)))
      (if (= (setq d2 (+ (rand 6) 1)) 1) (setq d2 (+ (rand 6) 1)))
      (if (= (setq d3 (+ (rand 6) 1)) 1) (setq d3 (+ (rand 6) 1)))
      ; ordinamento dei valori ottenuti
      (sort (setq rolled (list d1 d2 d3)) >)
      ; numero ottenuto dal lancio
      (setq result (+ (rolled 0) (rolled 1)))
      ; aggiornamento occorrenze numero ottenuto dal lancio
      (++ (valori result))
      ; aggiornamento del totale
      (++ totale result)
    )
    ; calcolo delle probabilità di ogni risultato da 0 a 12
    (setq probs (map (fn(x) (div x iter)) valori))
    (setq media (div totale iter))
    (list media probs)))

(case1 1e6)
;-> (9.0967501
;-> (0 0 2.1e-005 0.000449 0.010973 0.028837 0.061076 0.101429 0.155467
;->  0.188828 0.193315 0.160772 0.098833))

Caso 2: Ogni 1 ottenuto deve essere tirato fino a ottenere un valore diverso.

(define (case2 iter)
  (local (totale valori d1 d2 d3 rolled result probs media)
    (setq totale 0)
    (setq valori (array 13 '(0)))
    (for (i 1 iter)
      ; lancio dei tre dadi fino a che sono tutti differenti da 1
      (until (!= (setq d1 (+ (rand 6) 1)) 1))
      (until (!= (setq d2 (+ (rand 6) 1)) 1))
      (until (!= (setq d3 (+ (rand 6) 1)) 1))
      ; ordinamento dei valori ottenuti
      (sort (setq rolled (list d1 d2 d3)) >)
      ; numero ottenuto dal lancio
      (setq result (+ (rolled 0) (rolled 1)))
      ; aggiornamento occorrenze numero ottenuto dal lancio
      (++ (valori result))
      ; aggiornamento del totale
      (++ totale result)
    )
    ; calcolo delle probabilità di ogni risultato da 0 a 12
    (setq probs (map (fn(x) (div x iter)) valori))
    (setq media (div totale iter))
    (list media probs)))

(case2 1e6)
;-> (9.200056999999999
;-> (0 0 0 0 0.008024 0.023972 0.056271 0.095657 0.151846
;->  0.192145 0.200153 0.167911 0.104021))


---------------
Sistema Braille
---------------

Il Braille è un sistema di lettura e scrittura tattile a rilievo per non vedenti, creato dal francese Louis Braille nella prima metà del XIX secolo.
Consiste in simboli formati da sei punti, disposti su una matrice 3x2 in cui ogni casella è della grandezza di circa 3x2 millimetri o più.
I sei punti della matrice 3x2 sono numerati nel modo seguente:

  Punto 1 - punto in alto a sinistra
  Punto 2 - punto centrale a sinistra
  Punto 3 - punto in basso a sinistra
  Punto 4 - punto in alto a destra
  Punto 5 - punto centrale a destra
  Punto 6 - punto in basso a destra

  Numerazione    Punti pieni    Punti vuoti
  +-----+        +-----+        +-----+
  | 1 4 |        | * * |        | . . |
  | 2 5 |        | * * |        | . . |
  | 3 6 |        | * * |        | . . |
  +-----+        +-----+        +-----+

I caratteri alfanumerici (A..Z) e (0..9) sono rappresentati con le seguenti configurazioni dei punti nella matrice:

    A/1      B/2      C/3      D/4      E/5      F/6      G/7      H/8
  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+
  | * . |  | * . |  | * * |  | * * |  | * . |  | * * |  | * * |  | * . |
  | . . |  | * . |  | . . |  | . * |  | . * |  | * . |  | * * |  | * * |
  | . . |  | . . |  | . . |  | . . |  | . . |  | . . |  | . . |  | . . |
  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+

    I/9    J/0       K        L        M        N        O        P
  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+
  | . * |  | . * |  | * . |  | * . |  | * * |  | * * |  | * . |  | * * |
  | * . |  | * * |  | . . |  | * . |  | . . |  | . * |  | . * |  | * . |
  | . . |  | . . |  | * . |  | * . |  | * . |  | * . |  | * . |  | * . |
  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+

     Q        R        S        T        U        V        W        X
  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+
  | * * |  | * . |  | . * |  | . * |  | * . |  | * . |  | . * |  | * * |
  | * * |  | * * |  | * . |  | * * |  | . . |  | * . |  | * * |  | . . |
  | * . |  | * . |  | * . |  | * . |  | * * |  | * * |  | . * |  | * * |
  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+  +-----+

     Y        Z        Segna numero    Spazio
  +-----+  +-----+       +-----+       +-----+
  | * * |  | * . |       | . * |       | . . |
  | . * |  | . * |       | . * |       | . . |
  | * * |  | * * |       | * * |       | . . |
  +-----+  +-----+       +-----+       +-----+

Nota: Le prime 10 lettere rappresentano anche le dieci cifre, quindi per stabilire se una di queste rappresentazioni sia una lettera o un numero viene utilizzata la casella "Segna numero", che segnala che la prossima casella è un numero.
Più precisamente, per scrivere un numero, a una o più cifre, la prima cifra deve essere preceduta dal carattere "segna numero" e l'ultima cifra sia seguita da uno spazio.

(setq linea '(". ." ". *" "* ." "* *"))

". ." = 0

". *" = 1

"* ." = 2

"* *" = 3

(setq caratteri
'((2 0 0) (2 2 0) (3 0 0) (3 1 0) (2 1 0) (3 2 0) (3 3 0) (2 3 0)
  (1 2 0) (1 3 0) (2 0 2) (2 2 2) (3 0 2) (3 1 2) (2 1 2) (3 2 2)
  (3 3 2) (2 3 2) (1 2 2) (1 3 2) (2 0 3) (2 2 3) (1 3 1) (3 0 3)
  (3 1 3) (2 1 3) (1 1 3) (0 0 0)))

(setq cifre '((2 0 0) (2 2 0) (3 0 0) (3 1 0) (2 1 0)
              (3 2 0) (3 3 0) (2 3 0) (1 2 0) (1 3 0)))

(length caratteri)
;-> 28
(length (unique caratteri))
;-> ;-> 28
(count (unique caratteri) caratteri)
;-> (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)

(char "A")
;-> 65

(define (char-braille ch)
  (local (indice terna)
    (if (= ch " ")
        (setq indice 27)
        ;else
        (setq indice (- (char (upper-case ch)) 65)))
    (setq terna (caratteri indice))
    ;(println indice { } terna)
    (println "+-----+ ")
    (dolist (el terna) (println "| " (linea el) " | "))
    (println "+-----+ ") '>))

Proviamo:

(char-braille "A")
;-> +-----+
;-> | * . |
;-> | . . |
;-> | . . |
;-> +-----+

(char-braille "Z")
;-> +-----+
;-> | * . |
;-> | . * |
;-> | * * |
;-> +-----+

(char-braille " ")
;-> +-----+
;-> | . . |
;-> | . . |
;-> | . . |
;-> +-----+

(setq chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
(setq alpha (explode chars))
(map char-braille alpha)

(char "0")
;-> 48
(char "1")
;-> 49

(define (digit-braille ch)
  (local (indice terna)
    (if (= ch "0")
        (setq indice 9)
        ;else
        (setq indice (- (char (upper-case ch)) 49)))
    (setq terna (cifre indice))
    ;(println indice { } terna)
    (println "+-----+ ")
    (dolist (el terna) (println "| " (linea el) " | "))
    (println "+-----+ ") '>))

Proviamo:

(digit-braille "0")
;-> +-----+
;-> | . * |
;-> | * * |
;-> | . . |
;-> +-----+

(digit-braille "9")
;-> +-----+
;-> | . * |
;-> | * . |
;-> | . . |
;-> +-----+

(setq digits "0123456789")
(setq nums (explode digits))
(map char-braille alpha)

Funzione che converte una parola in braille:

(define (word-braille str)
  (dostring (c (upper-case str)) (char-braille (char c))))

(word-braille "newLISP")
;-> +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+
;-> | * * | | * . | | . * | | * . | | . * | | . * | | * * |
;-> | . * | | . * | | * * | | * . | | * . | | * . | | * . |
;-> | * . | | . . | | . * | | * . | | . . | | * . | | * . |
;-> +-----+ +-----+ +-----+ +-----+ +-----+ +-----+ +-----+

Funzione che converte un numero in braille:

(define (number-braille str)
  (dostring (c str) (digit-braille (char c))))

(word-braille "1942")
;-> +-----+ +-----+ +-----+ +-----+
;-> | * * | | * . | | * * | | * * |
;-> | . . | | . . | | * . | | . * |
;-> | * . | | * * | | * . | | * . |
;-> +-----+ +-----+ +-----+ +-----+


---------------------------------
Partizioni di una lista in ordine
---------------------------------

Data una lista, dividerla in tutti i modi possibili (cioè creare tutte le partizioni della lista data rispettando l'ordine degli elementi).

Per esempio:

Lista = (1 2 3)
Output = ((1 2 3)) ((1 2) (3)) ((1) (2 3)) ((1) (2) (3))

Lista = (A B C D)
Output = ((A B C D)) ((A B C) (D)) ((A B) (C D)) ((A B) (C) (D)) ((A) (B C D))
          ((A) (B C) (D)) ((A) (B) (C D)) ((A) (B) (C) (D))

Notiamo che il numero totale delle liste divise vale 2^(n-1), dove n è la lunghezza della lista data.
Possiamo considerare l'operazione di divisione della lista come fosse fatta da un numero binario.
Il numero binario è lungo (n - 1) e varia da 0 a (2^n - 1).
La cifra 1 di un numero indica un taglio, la cifra 0 indica nessun taglio.

Per esempio:

lista (1 2 3)
binario  00 --> nessun taglio --> (1 2 3)

lista (1 2 3)
(divides '(1 2 3) "11")
binario  01 --> taglio tra i e i+1 (tra indice 1 e indice 2) --> (1 2) (3)

lista (1 2 3)
binario  10 --> taglio tra i e i+1 (tra indice 0 e indice 1) --> (1) (2 3)

lista (1 2 3)
binario  11 --> taglio tra i e i+1 (tra indice 0 e indice 1)
                taglio tra i e i+1 (tra indice 1 e indice 2) --> (1) (2) (3)

Algoritmo
Ciclo da 0 a (2^n - 1)
  Taglia lista con binario corrente
  Inserisce risultato nella soluzione

Per prima cosa dobbiamo scrivere una funzione che prende una lista e un numero binario e taglia la lista in corrispondenza degli 1 del numero binario:

(define (divides lst binary)
  (local (out tmp)
    (setq out '())
    (setq tmp '())
    (for (i 0 (- (length binary) 1))
      (cond ((= (binary i) "1") ; taglio
              (push (lst i) tmp -1)
              (push tmp out -1)
              (setq tmp '()))
            (true  ; nessun taglio
              (push (lst i) tmp -1))
      )
    )
    ; inserisce lista finale
    (push (lst -1) tmp -1)
    (push tmp out -1)
    out))

Proviamo:

(setq lst '(1 2 3 4 5))
(divides lst "0000")
;-> ((1 2 3 4 5))

(divides lst "0001")
;-> ((1 2 3 4) (5))

(divides lst "0101")
;-> ((1 2) (3 4) (5))

(divides lst "1111")
;-> ((1) (2) (3) (4) (5))

(divides lst "1010")
;-> ((1) (2 3) (4 5))

Adesso scriviamo la funzione finale:

(define (splits lst)
  (local (out len max-tagli taglio fmt)
    (setq out '())
    (setq len (length lst))
    ; numero massimo di tagli
    (setq max-tagli (- len 1))
    ; formattazione con 0 davanti
    (setq fmt (string "%0" max-tagli "s"))
    (for (i 0 (- (pow 2 max-tagli) 1))
      ; taglio corrente
      (setq taglio (format fmt (bits i)))
      ;(println taglio)
      ; taglia la lista con taglio corrente
      ; e la inserisce nella lista soluzione
      (push (divides lst taglio) out -1)
    )
    out))

Proviamo:

(splits '(1 2 3))
;-> (((1 2 3)) ((1 2) (3)) ((1) (2 3)) ((1) (2) (3)))

(splits '(A B C D E))
;-> (((A B C D E)) ((A B C D) (E)) ((A B C) (D E)) ((A B C) (D) (E))
;->  ((A B) (C D E)) ((A B) (C D) (E)) ((A B) (C) (D E)) ((A B) (C) (D) (E))
;->  ((A) (B C D E)) ((A) (B C D) (E)) ((A) (B C) (D E)) ((A) (B C) (D) (E))
;->  ((A) (B) (C D E)) ((A) (B) (C D) (E)) ((A) (B) (C) (D E))
;->  ((A) (B) (C) (D) (E)))

(setq lst '((1 2) 3 (4 (5 (6))) 7 8 ((9))))
(splits lst)
;-> ((((1 2) 3 (4 (5 (6))) 7 8 ((9))))
;->  (((1 2) 3 (4 (5 (6))) 7 8) (((9))))
;->  (((1 2) 3 (4 (5 (6))) 7) (8 ((9))))
;->  (((1 2) 3 (4 (5 (6))) 7) (8) (((9))))
;->  ...
;->  (((1 2)) (3) ((4 (5 (6))) 7) (8) (((9))))
;->  (((1 2)) (3) ((4 (5 (6)))) (7 8 ((9))))
;->  (((1 2)) (3) ((4 (5 (6)))) (7 8) (((9))))
;->  (((1 2)) (3) ((4 (5 (6)))) (7) (8 ((9))))
;->  (((1 2)) (3) ((4 (5 (6)))) (7) (8) (((9)))))

Vedi anche "Dividere una stringa in tutti i modi possibili" su "Note libere 17".


------------------------
Quanti anni ha Diofanto?
------------------------

Diofanto di Alessandria fu un grande matematico greco vissuto nel periodo tra il II e il III secolo d.C. ad Alessandria d'Egitto.
In un epigramma della "Antologia Palatina", attribuito a Metrodoro di Bisanzio, grammatico e aritmetico vissuto nel VI secolo d.C., si legge un testo dalla quale è possibile calcolare l'età di Diofanto.
L'indovinello che Diofanto stesso volle venisse scritto sulla propria tomba come epitaffio, è un problema aritmetico che recita (traduzione dal greco):

  "Questa tomba rinchiude Diofanto e, meraviglia!
  dice matematicamente quanto ha vissuto.
  Un sesto della sua vita fu l'infanzia, (1/6x)
  aggiunse un dodicesimo perché le sue guance si coprissero della peluria dell'adolescenza. (1/12x)
  Dopo un altro settimo della sua vita prese moglie, (1/7x)
  e dopo cinque anni di matrimonio ebbe un figlio. (5)
  L'infelice (figlio) morì improvvisamente quando raggiunse la metà dell'età che il padre ha vissuto. (1/2x)
  Il genitore sopravvissuto fu in lutto per quattro anni (4)
  e raggiunse infine il termine della propria vita." (x)

Da questo testo possiamo ricavare la seguente equazione:

  x/6 + x/12 + x/7 + 5 + x/2 + 4 = x

Risolviamo l'equazione:

  m.c.m = 84
  14x + 7x + 12x + 420 + 42x + 336 = 84x

  75x + 756 = 84x

  x = 756/(84-75) = 756/9 = 84

Diofanto morì a 84 anni.

Con newLISP possiamo cercare tutte le soluzioni intere all'equazione:

(define (eta)
  (for (x 1 1000)
    (if (= x (add (div x 6) (div x 12) (div x 7) 5 (div x 2) 4))
        (println x))) '>)

(eta)
;-> 84


---------------------------------------
Lista dei numeri primi sotto al milione
---------------------------------------

Scrivere una funzione/espressione che calcola tutti i primi sotto al milione.
La funzione/espressione deve essere la più corta possibile.

https://codegolf.stackexchange.com/questions/5977/list-of-primes-under-a-million

Algoritmo:
Selezionare tutti i numeri da 2 a 1000000 la cui scomposizione in fattori primi è formata da un solo numero.

Funzione base:

(filter (fn(x) (= (length (factor x)) 1)) (sequence 2 1e6))

Funzione compressa (53 caratteri):

(filter(fn(x)(=(length(factor x))1))(sequence 2 1e6))

Tempo di esecuzione:

(time (filter(fn(x)(=(length(factor x))1))(sequence 2 1e6)))
;-> 807.672


--------------------------------------
Il metodo Java Integer.highestOneBit()
--------------------------------------

Questo metodo calcola per un dato intero N la cui rappresentazione binaria è:

  0..01xxxx...xxxx

il valore:

  0..010000...0000

Il metodo restituisce un valore intero con al massimo un singolo bit che si trova nella posizione del bit di ordine più alto (cioè più a sinistra) per il valore intero specificato.

In altre parole genera un numero binario che inizia dal primo 1 incontrato a sinistra (highest bit) e poi ha
 tutti i bit a 0.
Se l'input binario ha tutti zeri (0000...), allora l'output è 0.

Esempi:
  input = 010
  output = 10

  input = 10110
  output = 10000

  input = 0000101
  output = 100

  input = 0000
  output = 0

  input = 01000
  output = 1000

(define (highestOneBit N)
  (local (bin len high-one)
    (setq bin (bits N))
    (setq len (length bin))
    (setq high-one (find "1" bin))
    (if high-one
      (setq out (string "1" (dup "0" (- len high-one 1))))
      (setq out 0))
    ;(println bin { } out)
    (int out 0 2)))

Proviamo:

(highestOneBit 18)
;-> 16
(highestOneBit 16)
;-> 16
(highestOneBit 15)
;-> 8
(highestOneBit 36)
;-> 32

Notiamo che la funzione restituisce un numero che è la prima potenza in base 2 inferiore o uguale al numero dato.
Per esempio:
  18 --> 2^4 = 16 (non 2^5 = 32 > 18)
  16 --> 2^4 = 16
  15 --> 2^3 = 8
  36 --> 2^5 = 32


----------------------
Espressione invariante
----------------------

Scrivere una espressione il cui output è invariante a qualunque rotazione (a sinistra o a destra) dell'espressione stessa.

Per esempio:

espressione = (println "test")
(println "test")
;-> test

rotazione a destra di 2 = ")(println "test
")(println "
;-> nil

Gli output sono diversi.

L'unica espressione che ho trovato è la seguente:

""""""""""""""""""""""""""""""""

Cioè una stringa costituita solo da doppi apici (in numero maggiore di 1).


-------------------------
Sottosequenze di stringhe
-------------------------

Date le stringhe S1 e S2, determinare se S1 è una sottosequenza di S2.
La stringa vuota è considerata una sottosequenza di ogni stringa.
Per esempio, "" and "anna" sono sottosequenze di "banana".

Differenza tra sottostringa e sottosequenza
Una sottostringa è compare esattamente com'è nella stringa.
Per esempio:
S1 = "anna", S2 = "giovanna"
"anna" è sottostringa (e sottosequenza) di "giovanna"

S1 = "anna", S2 = "banana"            __ __
"anna" è sottosequenza di "banana" ("banana")

S1 = "abc", S2 = "xaybzc"            _ _ _
"abc" è sottosequenza di "xaybzc" ("xaybzc")

S1 = "abc", S2 = "xayczb"                _   _
"abc" non è sottosequenza di "xayczb" ("xayczb")
Infatti anche se in S2 esistono le lettere "a", "b", "c", queste non appaiono in S2 con la stessa sequenza "_a _c_b".

(define (subseq s1 s2)
  (local (len1 len2 idx1 idx2 valid cur-char)
    (setq len1 (length s1))
    (setq len2 (length s2))
    (setq idx1 0)
    (setq idx2 0)
    (setq valid true)
    ; ciclo per tutta la stringa s1 (break when (idx2 > len2))
    (while (and (< idx1 len1) valid)
      ; carattere corrente stringa s1
      (setq cur-char (s1 idx1))
            ; raggiunta la fine della stringa s2 --> output = nil
      (cond ((>= idx2 len2) (setq valid nil))
            ; carattere corrente s1 = carattere corrente s2
            ((= cur-char (s2 idx2))
              ; avanziamo con entrambi gli indici
              (++ idx1) (++ idx2))
            ; carattere corrente s1 != carattere corrente s2
            ((!= cur-char (s2 idx2))
              ; avanziamo con entrambi l'indice di s2
              (++ idx2)))
    )
    valid))

Proviamo:

(subseq "anna" "banana")
;-> true
(subseq "anna" "banaa")
;-> nil
(subseq "abc" "xaybzc")
;-> true
(subseq "abc" "xayczb")
;-> nil
(subseq "12345" "15243246651")
;-> true
(subseq "12345" "1524325466")
;-> nil
(subseq "12345" "2521432534656")
;-> true

Per risolvere il problema possiamo anche usare un espressione regolare (regex):
Per esempio:

(find "a.*n.*n.*a" "banana" 0)
;-> 1

La regex "a.*n.*n.*a" cerca:
  1. Un carattere 'a'
  2. Qualsiasi numero di caratteri (incluso zero)
  3. Un carattere 'n'
  4. Qualsiasi numero di caratteri (incluso zero)
  5. Un altro carattere 'n'
  6. Qualsiasi numero di caratteri (incluso zero)
  7. Un carattere 'a'

(find "a.*n.*n.*a" "banana" 0)
;-> 0
(find "a.*n.*n.*a" "banaa" 0)
;-> nil
(find "a.*b.*c" "xaybzc" 0)
;-> 1
(find "a.*b.*c" "xayczb" 0)
;-> nil
(find "1.*2.*3.*4.*5" "15243246651" 0)
;-> 0
(find "1.*2.*3.*4.*5" "1524325466" 0)
;-> nil
(find "1.*2.*3.*4.*5" "2521432534656" 0)
;-> 3

Per creare la regex usiamo la seguente espressione:

(replace ".?" "anna" (string ".*" $it) 0)
;-> ".*a.*n.*n.*a.*"
(slice (replace ".?" "anna" (string ".*" $it) 0) 2 -2)
;-> "a.*n.*n.*a"

Scriviamo la funzione:

(define (subsequence s1 s2)
  (let (regx (slice (replace ".?" s1 (string ".*" $it) 0) 2 -2))
    (if (find regx s2 0) true nil)))

(subsequence "anna" "banana")
;-> true
(subsequence "anna" "banaa")
;-> nil
(subsequence "abc" "xaybzc")
;-> true
(subsequence "abc" "xayczb")
;-> nil
(subsequence "12345" "15243246651")
;-> true
(subsequence "12345" "1524325466")
;-> nil
(subsequence "12345" "2521432534656")
;-> true

Vediamo la velocità delle due funzioni:

Output true:

(time (subsequence "12345" "2521432534656") 1e5)
;-> 347.913
(time (subseq "12345" "2521432534656") 1e5)
;-> 520.634

(time (subsequence "1234567" "252143253465656345764576234573457") 1e5)
;-> 548.733
(time (subseq "1234567" "252143253465656345764576234573457") 1e5)
;-> 851.365

Output: nil

(time (subsequence "12345" "2521432534666") 1e5)
;-> 343.592
(time (subseq "12345" "2521432534666") 1e5)
;-> 592.757

(time (subsequence "1234567" "252143253465656345864586234583458") 1e5)
;-> 548.733
(time (subseq "1234567" "252143253465656345864586234583458") 1e5)
;-> 1523.709

Proviamo a compilare la regex e vedere cosa accade:

(setq s1 "1234567")
(setq p1 (regex-comp (slice (replace ".?" s1 (string ".*" $it) 0) 2 -2)))
(define (subs s2)  (if (find p1 s2 0x10000) true nil))
(subs "252143253465656345864586234583458")
;-> nil
(time (subs "252143253465656345864586234583458") 1e5)
;-> 17.09

In questo caso la funzione che usa la regex è velocissima.
Quindi se usiamo la stessa espressione regolare molte volte sarebbe opportuno compilarla.

Nota: in questo caso la regex cambia con il parametro s1 e quindi non è conveniente compilarla ogni volta, anche perchè all'interno della funzione viene usata solo una volta.


-----------------------------------------------------------
Terence Tao e una forma debole della congettura di Goldbach
-----------------------------------------------------------

Il matematico Terence Tao ha dimostrato nel 2012 una forma debole della congettura di Goldbach:

  Ogni numero dispari maggiore di 1 è la somma di (al massimo) 5 primi.

Vedi l'articolo:
"Every odd number greater than 1 is the sum of at most five primes" by Terence Tao.
https://arxiv.org/abs/1201.6656

Verifichiamola (per un numero finito di numeri).

Dato un intero dispari N > 1, scrivere N come somma di un massimo di 5 numeri primi.

(define (primes-range n1 n2)
"Generates all prime numbers in the interval [n1..n2]"
  (if (> n1 n2) (swap n1 n2))
  (cond ((= n2 1) '())
        ((= n2 2) '(2))
        (true
          (let ((lst '(2)) (arr (array (+ n2 1))))
            ; initialize lst
            (if (> n1 2) (setq lst '()))
            (for (x 3 n2 2)
              (when (not (arr x))
                ; push current primes (x) only if > n1
                (if (>= x n1) (push x lst -1))
                (for (y (* x x) n2 (* 2 x) (> y n2))
                  (setf (arr y) true)))) lst))))

(primes-range 11 103)
;-> (11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103)

(define (tao1 num)
(catch
  (dolist (a (primes-range 2 num))
    (if (= a num) (throw a))
    (dolist (b (primes-range (+ a 1) num))
      (dolist (c (primes-range (+ b 1) num))
        (if (= (+ a b c) num) (throw (list a b c)))
        (dolist (d (primes-range (+ c 1) num))
          (dolist (e (primes-range (+ d 1) num))
            (if (= (+ a b c d e) num) (throw (list a b c d e))))))))))

Proviamo:

(tao1 11)
;-> 11

(tao1 101)
;-> (3 5 7 13 73)

(tao1 201)
;-> (3 5 7 13 173)

Vediamo la velocità:

(time (map tao1 (sequence 3 101 2)))
;-> 324.622
(time (map tao1 (sequence 3 201 2)))
;-> 6235.301

(time (println (tao1 1001)))
;-> (3 5 7 19 967)
;-> 68657.521

Giusto per curiosità, proviamo con numeri pari:

(tao1 10)
;-> (2 3 5)

(tao1 100)
;-> (2 3 5 7 83)

(tao1 200)
;-> (2 3 5 11 179)

(time (println (tao1 1000)))
;-> (2 3 5 7 983)
;-> 0.97

Proviamo a velocizzare la funzione:

1) calcoliamo i numeri primi una sola volta
2) utilizziamo un vettore (array)
3) i cicli for utilizzano gli indici del vettore

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

(define (tao2 num)
(catch
  (local (primi len p)
    (setq primi (primes-to num))
    (setq len (length primi))
    (setq p (array len primi))
    (for (a 0 (- len 1))
      (if (= (p a) num) (throw (p a)))
      (if (<= (+ a 1) (- len 1))
      (for (b (+ a 1) (- len 1))
        (if (<= (+ b 1) (- len 1))
        (for (c (+ b 1) (- len 1))
          (if (= (+ (p a) (p b) (p c)) num)
              (throw (list (p a) (p b) (p c))))
          (if (<= (+ c 1) (- len 1))
          (for (d (+ c 1) (- len 1))
            (if (<= (+ d 1) (- len 1))
            (for (e (+ d 1) (- len 1))
              (if (= (+ (p a) (p b) (p c) (p d) (p e)) num)
                  (throw (list (p a) (p b) (p c) (p d) (p e))))))))))))))))

Proviamo:

(tao2 11)
;-> 11

(tao2 101)
;-> (3 5 7 13 73)

(tao2 201)
;-> (3 5 7 13 173)

Vediamo se le due funzioni producono gli stessi risultati:

(= (map tao2 (sequence 3 201 2)) (map tao2 (sequence 3 201 2)))
;-> true

Vediamo la velocità:

(time (map tao2 (sequence 3 101 2)))
;-> 30.201
(time (map tao2 (sequence 3 201 2)))
;-> 543.638
(time (println (tao2 1001)))
;-> (3 5 7 19 967)
;-> 4747.324


----------------------------------------------------------------
Utilizzare map con una funzione che ha alcuni parametri costanti
----------------------------------------------------------------

(define (test x y z) (* (+ x y) z))

(test 1 2 3)
;-> 9

Supponiamo di voler applicare ad ogni elemento w di una lista di numeri interi la seguente operazione:

  (w + 2) * 3

Non possiamo applicare "map" direttamente con la funzione "test", ma possiamo creare una funzione ausiliaria che richiama "test" con i parametri costanti (y=2 e z=3):

(define (test-aux x) (test x 2 3))

Adesso possiamo usare "map" con "test-aux":

(map test-aux (sequence 1 10))
;-> (9 12 15 18 21 24 27 30 33 36)

In questo caso "test" è una funzione molto semplice e avremmo potutto scriverla direttamente in "map" con fn(x), ma in caso di funzioni lunghe conviene utilizzare una funzione ausiliaria.


----------------------------------------
Conteggio delle chiamate ad una funzione
----------------------------------------

Alle volte vogliamo conoscere quante volte viene eseguita una funzione durante l'esecuzione di un programma.
Un metodo semplice è quello di utilizzare una variabile globale che viene incrementata dalla prima istruzione della funzione che vogliamo analizzare.

Esempio:

(define (fibo n)
  (++ fibo-count)
  (if (< n 2)
      1
      (+ (fibo (- n 1)) (fibo (- n 2)))))

(setq fibo-count 0)
(fibo 5)
;-> 8
fibo-count
;-> 15

(setq fibo-count 0)
(fibo 10)
;-> 89
fibo-count
;-> 177

(setq fibo-count 0)
(fibo 20)
;-> 10946
fibo-count
;-> 21891


-------------------------------------------
Differenza minima tra i numeri di una lista
-------------------------------------------

Data una lista di numeri interi positivi, scrivere una funzione che restituisce la differenza tra i due numeri più vicini e i due numeri stessi.

Esempio:
lista: (55 99 6 29 1 123 3)
output: 3 - 1 = 2

Algoritmo
1) Ordinare la lista (crescente)
2) Calcolare tutte le differenze delle coppie adiacenti: (e(i+1) - e(i))
3) Trovare il valore minimo delle differenze (diff-min)
4) Trovare l'indice del valore minimo delle differenze (idx)
5) Gli elementi sono lista(idx+1) e lista(idx)

(define (min-diff lst)
  (local (diff idx-min)
    ; Ordina la lista
    (sort lst)
    ; Calcola le differenze delle coppie adiacenti della lista ordinata
    (setq diff (map - (rest lst) (chop lst)))
    ; Ricerca indice del valore minimo delle differenze
    (setq idx-min (find (apply min diff) diff))
    ; Restituzione del risultato
    (list (- (lst (+ idx-min 1)) (lst idx-min))
          (lst (+ idx-min 1)) (lst idx-min))))

Proviamo:

(setq a '(55 99 6 29 1 123 3))
(min-diff a)
;-> (2 3 1)

(setq b '(-1 13 4 -3 7 -6 -12 22 -13 36))
(min-diff b)
;-> (1 -12 -13)

(setq c '(-10 20 12 -2 -22 42 83 2))
(min-diff c)
;-> (4 2 -2)


--------------------------------------
Numeri palindromi in base B (2<=B<=62)
--------------------------------------

Scrivere una funzione che genera i numeri palindromi in base B fino ad un dato numero N (decimale).

(define (base10-baseN number base)
"Convert a number from base 10 to base N (<=62)"
  (let ((charset "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        (result '())
        (quotient number))
    (while (>= quotient base)
      (push (charset (% quotient base)) result)
      (setq quotient (/ quotient base))
    )
    (push (charset quotient) result)
    (join result)))

(define (baseN-base10 number-string base)
"Convert a number from base N (<=62) to base 10"
  (let ((charset "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        (result 0)
        (len (length number-string)))
    (dolist (digit (explode number-string))
      (setq result (+ (* result base) (find digit charset)))
    )
    result))

Funzione che verifica se un numero (o una stringa) è palindromo:

(define (palindrome? obj)
  (let (str (string obj))
    (= (reverse (copy str)) str)))

Funzione che calcola i numeri palindromi in base B fino al numero N (decimale):

(define (pali B N)
  (let ( (out '()) (nb 0) )
    (for (num 1 N)
      (setq nb (base10-baseN num B))
      (if (palindrome? nb) (push (list nb num) out -1)))
    out))

(pali 2 50)
;-> (("1" 1) ("11" 3) ("101" 5) ("111" 7) ("1001" 9) ("1111" 15) ("10001" 17)
;->  ("10101" 21) ("11011" 27) ("11111" 31) ("100001" 33) ("101101" 45))

(pali 5 50)
;-> (("1" 1) ("2" 2) ("3" 3) ("4" 4) ("11" 6) ("22" 12) ("33" 18) ("44" 24)
;->  ("101" 26) ("111" 31) ("121" 36) ("131" 41) ("141" 46))

I numeri in base B che hanno indice da 0 a (B - 1) sono sempre palindromi perchè sono formati da una sola cifra/simbolo.

(slice (pali 60 500) 59)
;-> (("11" 61) ("22" 122) ("33" 183) ("44" 244)
;->  ("55" 305) ("66" 366) ("77" 427) ("88" 488))


---------------------
Sequenze Jolly Jumper
---------------------

Una sequenza di N numeri interi è detta Jolly Jumper se i valori assoluti della differenza tra elementi adiacenti assumono tutti i valori da 1 a N-1.
Le sequenze di lunghezza 0 o 1 sono considerate Jolly Jumper.

Per esempio:

  sequenza = (5 3 2 5 9)
  N = 5
  differenze = abs(3 - 5) abs(2 - 3) abs(5 - 2) abs(9 - 5) =
             = 2 1 3 4

Le differenze contengono tutti i numeri da 1 a N-1 (da 1 a 4): 1 2 3 4.
Quindi la sequenza è Jolly Jumper.

(define (jj? lst)
  ; calcolo delle differenze assolute degli elementi adiacenti
  (let (diff (map (fn(x y) (abs (- y x))) (rest lst) (chop lst)))
    ;(println (sort diff))
    ; verifica della presenza dei numeri da 1 a N-1
    (= (sort diff) (sequence 1 (- (length lst) 1)))))

Proviamo:

(setq a '(5 3 2 5 9))
(jj? a)
;-> (1 2 3 4)
;-> true

(jj? '(2 -1 0 2))
;-> (1 2 3)
;-> true

(jj? '(19 22 24 25))
;-> (1 2 3)
;-> true

(jj? '(19 22 24 21))
;-> (2 3 3)
;-> nil

Scriviamo una funzione che dato un numero N genera una lista Jolly Jumper con N elementi.

(define (make-jj N)
  (local (max-rnd out seq new-val)
  ; valore di partenza
  (setq max-rnd (* N 10))
  ; lista di output
  (setq out (list (rand max-rnd)))
  ; randomize (mischia) la sequenza 1..N
  (setq seq (randomize (sequence 1 N)))
  ; ciclo per ogni valore della sequenza
  (dolist (el seq)
    ; creazione valore corrente:
    ; valore_corrente = valore_precedente - elemento_corrente
    ; oppure
    ; valore_corrente = valore_precedente + elemento_corrente
    (if (zero? (rand 2))
        (setq new-val (- (out $idx) el))
        (setq new-val (+ (out $idx) el)))
    ; inserimento valore corrente
    (push new-val out -1)
  )
  out))

Proviamo:

(make-jj 5)
;-> (17 12 16 19 21 20)
(jj? '(17 12 16 19 21 20))
;-> true

(jj? (println (make-jj 8)))
;-> (52 59 58 52 50 58 53 49 52)
;-> true

(jj? (println (make-jj 10)))
;-> (32 31 38 42 33 23 15 18 13 11 5)
;-> true

Nota: la stampa (println) di un oggetto restituisce l'oggetto:

(list? (println '(1 2 3)))
;-> (1 2 3)
;-> true
(integer? (println 1))
;-> 1
;-> true
(float? (println 3.1415))
;-> 3.1415
;-> true
(string? (println "stringa"))
;-> stringa
;-> true
(primitive? (println println))
;-> println@40AC99
;-> true


---------------------
Problema Seven-Eleven
---------------------

Il problema del Seven-Eleven consiste nel trovare 4 numeri positivi (con due cifre decimali, A.BC) tali che la loro somma e il loro prodotto sia uguale a 7.11.
In termini matematici:

  a + b + c + d = a * b * c * d = 7.11
  con 0 < a <= b <= c <= d

Risolviamo il problema provando tutte le combinazioni possibili dei numeri a,b,c,d.
Per usare i numeri interi moltiplichiamo tutti i valori per 100.

(define (abcd)
  (local (out d)
    (for (a 1 (/ 711 4))
      (for (b a (/ 711 3))   ; (/ 711 4) non ottimizzato
        (for (c b (/ 711 2)) ; (/ 711 4) non ottimizzato
          (setq d (- 711 (+ a b c)))
          (if (and (>= d c) (= 711000000 (* a b c d)))
              (setq out (list a b c d))))))
    ; divisione per 100 dei valori della soluzione
    (map (fn(x) (div x 100)) out)))

Proviamo:

(abcd)
;-> (1.2 1.25 1.5 3.16)
(apply add (abcd))
;-> 7.11
(apply mul (abcd))
;-> 7.11
(time (abcd))
;-> 735.81


---------------------
Numeri k-almost-prime
---------------------

Un k-almost-prime (k-quasi-primo) è un numero intero positivo che ha esattamente k fattori primi, contati con molteplicità.

Sequenza OEIS A101695: 
a(n) = n-th n-almost prime.
  2, 6, 18, 40, 108, 224, 480, 1296, 2688, 5632, 11520, 25600, 53248, 124416,
  258048, 540672, 1105920, 2228224, 4587520, 9830400, 19922944, 40894464,
  95551488, 192937984, 396361728, 822083584, 1660944384, 3397386240,
  6845104128, ...

(define (k-almost limite)
  (local (out conta len)
    ; vettore soluzione
    (setq out (array 50 '(0)))
    ; vettore che conta le occorrenze delle lunghezze dei fattori dell'indice i
    (setq conta (array 50 '(0)))
    ; ciclo per tutti i numeri da 1 a limite
    (for (k 2 limite)
      ; numero di fattori del numero corrente
      (setq len (length (factor k)))
      ; aggiorna le occorrenze della lunghezza dei fattori pari a len
      (++ (conta len))
      ; se le occorrenze sono uguali 
      ; alla lunghezza dei fattori del numero corrente, allora
      ; abbiamo trovato un altro numero della sequenza
      (if (= (conta len) len) (setf (out len) k))
    )
    (clean zero? (array-list out))))

Proviamo:

(time (println (k-almost 1e5)))
;-> (2 6 18 40 108 224 480 1296 2688 5632 11520 25600 53248)
;-> 43.069

(time (println (k-almost 1e6)))
;-> (2 6 18 40 108 224 480 1296 2688 5632 11520 25600 53248 124416
;->  258048 540672)
;-> 750.023

(time (println (k-almost 1e7)))
;-> (2 6 18 40 108 224 480 1296 2688 5632 11520 25600 53248 124416
;->  258048 540672 1105920 2228224 4587520 9830400)
;-> 16626.773

(time (println (k-almost 1e8)))
;-> (2 6 18 40 108 224 480 1296 2688 5632 11520 25600 53248 124416
;->  258048 540672 1105920 2228224 4587520 9830400 19922944 40894464
;->  95551488)
;-> 414626.517


------------------------------
Le quarte potenze di Dov Juzuk
------------------------------

Nel 1939 il matematico Dov Juzuk descrisse e dimostrò un modo per generare le quarte potenze dei numeri naturali:

Prendere gli interi positivi e raggrupparli in insiemi in modo che l'm-esimo insieme contenga i successivi m
interi positivi:

  (1), (2,3), (4,5,6), (7,8,9,10), (11,12,13,14,15), ...

Rimuovere tutti gli insiemi con un numero pari di elementi (cioè rimuovere ogni secondo insieme).

    (1), (4,5,6), (11,12,13,14,15), ...

Quindi la somma di tutti gli interi nei primi n insiemi rimanenti è uguale a n^4.

Scriviamo una funzione che calcola la quarta potenza di un numero con il metodo di Juzuk.

(define (juzuk1 num)
  (local (out gruppi seq num-elem)
    (setq out '())
    (setq gruppi 1)
    ; numero in sequenza
    (setq seq 1)
    ; ciclo per creare i gruppi
    (while (<= gruppi (* num 2))
      ; contatore elementi del gruppo corrente
      (setq num-elem 1)
      (while (<= num-elem gruppi)
        ; inserisce solo i gruppi dispari
        (if (odd? gruppi) (push seq out -1))
        ; aumenta il numero in sequenza
        (++ seq)
        ; aumenta il numero di elementi del gruppo corrente
        (++ num-elem)
      )
      (++ gruppi)
    )
    (apply + out)))

Proviamo:

(map juzuk1 (sequence 1 10))
;-> (1 16 81 256 625 1296 2401 4096 6561 10000)

Matematicamente risulta che la somma del k-esimo gruppo vale:

  S(k) = 4*k^3 - 6*k^2 + 4*k - 1

(define (s k) (+ (* 4 k k k) (- (* 6 k k)) (* 4 k) (- 1)))

(pow 5 4)
;-> 625
(+ (s 1) (s 2) (s 3) (s 4) (s 5))
;-> 625

(define (juzuk2 num)
  (let (sum 0)
    (for (i 1 num) (++ sum (s i)))))

Proviamo:

(map juzuk2 (sequence 1 10))
;-> (1 16 81 256 625 1296 2401 4096 6561 10000)


--------------------------------------------------------
Print largest integer you can with the fewest characters
--------------------------------------------------------

https://codegolf.stackexchange.com/questions/185/print-largest-integer-you-can-with-the-fewest-characters

Find a way to output a large integer with few characters.
Solutions will be scored based on the magnitude of the number and shortness of code.

Prima soluzione:

(while (print 9))
;-> 999999999999999999999999999999999999999999999999999999999999999999999999
;-> 999999999999999999999999999999999999999999999999999999999999999999999999
;-> 999999999999999999999999999999999999999999...

Seconda soluzione (per gioco):

(print (div 1 0))
;-> 1.#INF  ; infinito è un numero molto grande...


----------------------------------------------
Separazione stabile numeri negativi e positivi
----------------------------------------------

Data una lista con numeri interi positivi e negativi, Scrivere una funzione per cambiare l'ordine degli elementi nella lista in modo che i numeri interi negativi siano all'inizio, i numeri interi positivi alla fine e i numeri interi con lo stesso segno non cambino ordine.

(define (positive? num) (>= num 0))
(define (negative? num) (< num 0))

(define (separa lst)
  (let (out (filter negative? lst))
    (extend out (filter positive? lst))))

Proviamo:

(setq a '(1 -3 -5 -2 9 0 8 -4 9 8 4))
(separa a)
;-> (-3 -5 -2 -4 1 9 0 8 9 8 4)

(setq b '(1 1 1 1))
(separa b)
;-> (1 1 1 1)


-------------------------------------------
Implementazione delle funzioni floor e ceil
-------------------------------------------

In newLISP le funzioni "floor" e "ceil" sono primitive.
  floor: calcola il più grande numero intero che sia minore o uguale a x.
  ceil: calcola il più piccolo numero intero che sia maggiore o uguale a x.

Implementiamo le due funzioni senza usare le primitive.

Funzione floor1:

(define (floor1 x)
  (if (>= x 0)
      (int x)
      (if (= x (int x))
          (int x)
          (- (int x) 1))))

Funzione ceil1:

(define (ceil1 x)
  (if (= x (int x))
      x
      (if (>= x 0)
          (+ (int x) 1)
          (int x))))

Proviamo:

(floor1 -2)
;-> -2
(ceil1 -2)
;-> -2
(floor1 3)
;-> 3
(ceil1 3)
;-> 3
(floor1 -1.03)
;-> -2
(ceil1 -1.03)
;-> -1
(floor1 1.03)
;-> 1
(ceil1 1.03)
;-> 2
(floor1 -1.52)
;-> -2
(ceil1 -1.52)
;-> -1
(floor1 1.52)
;-> 1
(ceil1 1.52)
;-> 2


--------------------------------------------
Angolo minore tra le lancette di un orologio
--------------------------------------------

Data un'ora in ore e minuti (es. 23 ore e 11 minuti) calcolare l'angolo minore (0..180 gradi) tra le lancette di un orologio.

Algoritmo:
1. Calcolare l'angolo della lancetta delle ore rispetto alle 12.
2. Calcolare l'angolo della lancetta dei minuti rispetto alle 12.
3. Trovare la differenza tra questi due angoli.
4. Assicurarsi che l'angolo trovato sia il minore (0..180 gradi).

(define (angolo-minore ore minuti)
  (local (angolo-ore angolo-min diff)
    ; calcolo dell'angolo della lancetta delle ore
    (setq angolo-ore (add (mul 30 (mod ore 12)) (div (mul 30 minuti) 60)))
    ; calcolo dell'angolo della lancetta dei minuti
    (setq angolo-min (mul 6 minuti))
    ; calcolo della diff assoluta tra i due angoli
    (setq diff (abs (sub angolo-ore angolo-min)))
    ; Assicurarsi che l'angolo sia minore di 180 gradi
    (if (> diff 180) (sub 360 diff) diff)))

Proviamo:

(angolo-minore 23 11)
;-> 90.5
(angolo-minore 15 16)
;-> 2
(angolo-minore 12 30)
;-> 165
(angolo-minore 18 30)
;-> 15
(angolo-minore 0 0)
;-> 0
(angolo-minore 12 0)
;-> 0
(angolo-minore 18 0)
;-> 180

Vedi anche "Angolo delle lancette di un'orologio" su "Note libere 5".

Creiamo il grafico ora-angolo:

(define (data)
  (let ( (out '()) (contatore 0) )
    (for (ore 0 23)
      (for (minuti 0 59)
        (++ contatore)
        (push (list (string ore ":" minuti) contatore
                    (angolo-minore ore minuti)) out -1)))
    out))

(length (data))
;-> 1440

(* 24 60)
;-> 1440

(define (list-csv lst file-str sepchar)
"Creates a file csv from a list"
  (local (outfile)
    (if (nil? sepchar)
        (setq sepchar ",")
    )
    (setq outfile (open file-str "write"))
    (dolist (el lst)
      (if (list? el)
          (setq line (join (map string el) sepchar))
          (setq line (string el))
      )
      (write-line outfile line)
    )
    (print outfile { })
    (close outfile)))

(list-csv (data) "ora-angolo.csv" ",")
;-> 3 true

Ora possiamo importare il file in Excel o GNUmeric e fare il grafico.

Vedi "ora-angolo.png" nella cartella "data".


-------
Cubotto
-------

Un numero è un cubotto se, dati tre numeri interi positivi a, b e c, risulta:

    a^3 + b^3 + c^3 = abc

dove abc è la concatenazione (come stringa) dei numeri a, b e c.

Esempio:
  a = 2, b = 2, c = 13
  abc = 2213
  2 * 2 * 2 = 8
  2 * 2 * 2 = 8
  13 * 13 * 13 = 2197
  8 + 8 + 2197 = 2213
  Quindi il numero 2213 è un cubotto.

Funzione che verifica se tre numeri interi positivi a,b,c formano un cubotto:

(define (cubotto? a b c)
  (= (+ (* a a a) (* b b b) (* c c c)) 
     (int (string a b c) 0 10)))

(cubotto? 2 2 13)
;-> true

(cubotto? 2 3 15)
;-> nil

Vediamo quanti cubotti ci sono con a,b e c che variano da 1 ad un dato limite:

(define (cubotti limite)
  (for (a 1 limite)
    (for (b a limite)
      (for (c b limite)
        (if (cubotto? a b c) (println a { } b { } c { } (string a b c)))))))

Proviamo:

(cubotti 100)
;-> 2 2 13 2213
;-> 4 18 33 41833
;-> 44 46 64 444664

2213 41833 444664

La funzione è molto lenta:

(time (cubotti 1000))
;-> 2 2 13 2213
;-> 4 18 33 41833
;-> 44 46 64 444664
;-> 186231.162


------------------------------
Trovare l'elemento più recente
------------------------------

Data una lista finita, ognuno dei suoi elementi ha una prima occorrenza.
Trovare l'elemento la cui prima occorrenza compare per ultima nella lista.

Esempio:
  lista = ("p" "r" "o" "g" "r" "a" "m" "m" "i" "n" "g")
  l'elemento "p" compare la prima volta all'indice 0
  l'elemento "r" compare la prima volta all'indice 1
  l'elemento "o" compare la prima volta all'indice 2
  l'elemento "g" compare la prima volta all'indice 3
  l'elemento "a" compare la prima volta all'indice 5
  l'elemento "m" compare la prima volta all'indice 6
  l'elemento "i" compare la prima volta all'indice 8
  l'elemento "n" compare la prima volta all'indice 9
  Quindi l'elemento che compare la prima volta per ultimo è "n".

Usiamo una lista 'item-idx' i cui elementi hanno la seguente struttura:
  (elemento indice-prima-occorrenza)

Funzione che trova l'elemento più recente:

(define (newest lst)
  (let (item-idx '())
    (dolist (el lst)
      ; inseriamo solo gli elementi che non esistono nella lista 'item-idx'
      ; (quindi inseriamo solo la prima occorrenza di ogni elemento)
      (if (not (find (list el '?) item-idx match))
          (push (list el $idx) item-idx)))
    ; ritorna l'ultimo coppia (elemento indice) inserita nella lista
    ; (che è il primo della lista)
    (item-idx 0)))

Proviamo:

(setq a '("p" "r" "o" "g" "r" "a" "m" "m" "i" "n" "g"))
(newest a)
;-> ("n" 9)

(setq b '(1 2 3 4 5 4 4 4 4 4 3 2 1))
(newest b)
;-> (5 4)


-----------------------------------------------------------
Lista di tutti i razionali positivi (Albero di Calkin-Wilf)
-----------------------------------------------------------

In matematica, l'albero di Calkin–Wilf è un albero in cui i vertici corrispondono uno a uno ai numeri razionali positivi . L'albero ha come radice numero 1/1 e ogni vertice è un numero razionale espresso come frazione irriducibile a/b che ha come figli due frazioni:
  figlio sinistro: a/(a+b)
  figlio destro: (a+b)/b

Questo albero ha le seguenti proprietà:
1) Il numeratore e il denominatore di ogni vertice sono primi tra loro
2) Ogni numero razionale positivo irriducibile appare in un vertice
3) Nessun numero razionale positivo irriducibile appare in più di un vertice

In altre parole, ogni numero razionale positivo appare esattamente una volta come un nodo dell'albero.

                             radice
                    .......... 1/1 ..........
                   /                         \
                  /                           \
                 /                             \
               1/2                             2/1  -->  livello 1
               /\                              /\
              /  \                            /  \
             /    \                          /    \
            /      \                        /      \
           /        \                      /        \
          /          \                    /          \
         /            \                  /            \
       1/3            3/2              2/3            3/1  -->  livello 2
       / \            / \              / \            / \
      /   \          /   \            /   \          /   \
     /     \        /     \          /     \        /     \
    /       \      /       \        /       \      /       \
  1/4       4/3  3/5       5/2    2/5       5/3  3/4       4/1  -->  livello 3
  / \       / \  / \       / \    / \       / \  / \       / \
 .....     ..........     .....  .....     ..........     .....  --> livello n 

Quindi per fare la lista di tutti i razionali positivi dobbiamo costruire un albero in cui:
  a) 1/1 è la radice
  b) ogni vertice i/j ha due figli
     1) figlio sinistro è i/i+j
     2) figlio destro è i+j/j

Ogni nodo dell'albero è una frazione che rappresenteremo come una lista (i j) dove i e j sono numeri interi.
Possiamo costruire l'albero in due modi:
1) Depth-First (profondità)
2) Breadth-First (larghezza, livello per livello)

1) Costruzione dell'albero in modo Depth-First (profondità):

Struttura di nodo:
(define (make-node i j) (list i j))

Funzione per calcolare il figlio sinistro:
(define (left-child node)
  (let ((i (node 0))
        (j (node 1)))
    (make-node i (+ i j))))

Funzione per calcolare il figlio destro:
(define (right-child node)
  (let ((i (node 0))
        (j (node 1)))
    (make-node (+ i j) j)))

Funzione per creare l'albero (Depth-First) fino a una certa profondità:

(define (print-tree-depth node depth)
  (if (>= depth 0)
    (begin
      (print (node 0) "/" (node 1) " ")
      (print-tree-depth (left-child node) (- depth 1))
      (print-tree-depth (right-child node) (- depth 1)))))

Proviamo:

(setq root (make-node 1 1))
(print-tree-depth root 3)
;-> 1/1 1/2 1/3 1/4 4/3 3/2 3/5 5/2 2/1 2/3 2/5 5/3 3/1 3/4 4/1

(print-tree-depth root 4)
;-> 1/1 1/2 1/3 1/4 1/5 5/4 4/3 4/7 7/3 3/2 3/5 3/8 8/5 5/2 5/7 7/2
;-> 2/1 2/3 2/5 2/7 7/5 5/3 5/8 8/3 3/1 3/4 3/7 7/4 4/1 4/5 5/1

2) Costruzione dell'albero in modo Breadth-First (larghezza):

Per gestire i nodi siamo una coda (queue), in modo da visitare prima tutti i nodi a un dato livello prima di passare al livello successivo.
Nella funzione vengono usate due code: una coda 'queue' per tenere traccia dei nodi da visitare e una seconda coda 'next-queue' per i nodi del livello successivo.

Funzione per creare l'albero (Breadth-First) fino a una certa profondità:

(define (print-tree-breadth root max-depth)
  (let ((queue (list root))
        (current-depth 0))
    (while (and queue (<= current-depth max-depth))
      (setq next-queue '())
      (println "Livello: " current-depth)
      (dolist (node queue)
        (print (node 0) "/" (node 1) " ")
        (if (< current-depth max-depth)
          (begin
            (push (left-child node) next-queue -1)
            (push (right-child node) next-queue -1))))
      (println)
      (setq queue next-queue)
      (++ current-depth)) '>))

Proviamo:

(print-tree-breadth (make-node 1 1) 4)
;-> Livello: 0
;-> 1/1
;-> Livello: 1
;-> 1/2 2/1
;-> Livello: 2
;-> 1/3 3/2 2/3 3/1
;-> Livello: 3
;-> 1/4 4/3 3/5 5/2 2/5 5/3 3/4 4/1
;-> Livello: 4
;-> 1/5 5/4 4/7 7/3 3/8 8/5 5/7 7/2 2/7 7/5 5/8 8/3 3/7 7/4 4/5 5/1

============================================================================

