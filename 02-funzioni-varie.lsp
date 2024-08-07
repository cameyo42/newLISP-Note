================

 FUNZIONI VARIE

================

In questo capitolo definiremo alcune funzioni che operano sulle liste e altre funzioni di carattere generale. Alcune di queste ci serviranno successivamente per risolvere i problemi che andremo ad affrontare.
Poichè newLISP permette sia lo stile funzionale che quello imperativo, le funzioni sono implementate in modo personale e possono essere sicuramente migliorate.

Angle convention:

                             +y

                             |    /
                             |   /
                             |  /   + Theta
                             | / )
+-180 degrees    -x ------------------- +x    0 degrees
                             | \ )
                             |  \   - Theta
                             |   \
                             |    \

                            -y

-------------
Tabella ASCII
-------------

ASCII (acronimo di American Standard Code for Information Interchange, Codice Standard Americano per lo Scambio di Informazioni) è un codice per la codifica di caratteri. Lo standard ASCII è stato pubblicato dall'American National Standards Institute (ANSI) nel 1968. Il codice era composto originariamente da 7 bit (2^7 = 128 caratteri).
I caratteri del codice ASCII sono di due tipi: stampabili e non stampabili (caratteri di controllo).
I caratteri stampabili sono 95 (da 32 a 126), mentre quelli non stampabili sono 33 (da 0 a 31 e il 127). Quindi il totale dei caratteri vale 95 + 33 = 128.
Scriviamo una funzione che crea una lista dei caratteri ASCII stampabili.

(define (asciiTable)
  (let (out '())
    (for (i 32 126)
      (push (list i (char i)) out -1)
    )
    out
  )
)

(asciiTable)
;-> ((32 " ")  (33 "!")  (34 "\"") (35 "#")  (36 "$")  (37 "%")  (38 "&")
;->  (39 "'")  (40 "(")  (41 ")")  (42 "*")  (43 "+")  (44 ",")  (45 "-")
;->  (46 ".")  (47 "/")  (48 "0")  (49 "1")  (50 "2")  (51 "3")  (52 "4")
;->  (53 "5")  (54 "6")  (55 "7")  (56 "8")  (57 "9")  (58 ":")  (59 ";")
;->  (60 "<")  (61 "=")  (62 ">")  (63 "?")  (64 "@")  (65 "A")  (66 "B")
;->  (67 "C")  (68 "D")  (69 "E")  (70 "F")  (71 "G")  (72 "H")  (73 "I")
;->  (74 "J")  (75 "K")  (76 "L")  (77 "M")  (78 "N")  (79 "O")  (80 "P")
;->  (81 "Q")  (82 "R")  (83 "S")  (84 "T")  (85 "U")  (86 "V")  (87 "W")
;->  (88 "X")  (89 "Y")  (90 "Z")  (91 "[")  (92 "\\") (93 "]")  (94 "^")
;->  (95 "_")  (96 "`")  (97 "a")  (98 "b")  (99 "c")  (100 "d") (101 "e")
;->  (102 "f") (103 "g") (104 "h") (105 "i") (106 "j") (107 "k") (108 "l")
;->  (109 "m") (110 "n") (111 "o") (112 "p") (113 "q") (114 "r") (115 "s")
;->  (116 "t") (117 "u") (118 "v") (119 "w") (120 "x") (121 "y") (122 "z")
;->  (123 "{") (124 "|") (125 "}") (126 "~"))

In newLISP i caratteri numero 34 (doppi apici) e numero 92 (backslash) sono preceduti dal carattere di controllo '\' quando vengono stampati.

Altro metodo, applico (con "map") la funzione (list x (char(x))) ad ogni elemento della lista di numeri che va da 32 a 126 (sequence 32 126):

(define (ascii-list)
  (map (fn(x) (list x (char x))) (sequence 32 126)))

Altro metodo che mostra i valori Decimale, Ottale, Esadecimale e il carattere:

(define (ascii-info)
; ascii chart output from #32 - #126
  (println "Dec Oct Hex Chr")
  (map (fn(x) (println (format "%-3d %-3o %-3x %s" x x x (char x))))
      (sequence 32 126))
  '-------------)

(ascii-info)
;-> Dec Oct Hex Chr
;-> 32  40  20
;-> 33  41  21  !
;-> 34  42  22  "
;-> 35  43  23  #
;-> 36  44  24  $
;-> 37  45  25  %
;-> 38  46  26  &
;-> 39  47  27  '
;-> 40  50  28  (
;-> 41  51  29  )
;-> 42  52  2a  *
;-> 43  53  2b  +
;-> 44  54  2c  ,
;-> 45  55  2d  -
;-> 46  56  2e  .
;-> 47  57  2f  /
;-> 48  60  30  0
;-> 49  61  31  1
;-> 50  62  32  2
;-> 51  63  33  3
;-> 52  64  34  4
;-> 53  65  35  5
;-> 54  66  36  6
;-> 55  67  37  7
;-> 56  70  38  8
;-> 57  71  39  9
;-> 58  72  3a  :
;-> 59  73  3b  ;
;-> 60  74  3c  <
;-> 61  75  3d  =
;-> 62  76  3e  >
;-> 63  77  3f  ?
;-> 64  100 40  @
;-> 65  101 41  A
;-> 66  102 42  B
;-> 67  103 43  C
;-> 68  104 44  D
;-> 69  105 45  E
;-> 70  106 46  F
;-> 71  107 47  G
;-> 72  110 48  H
;-> 73  111 49  I
;-> 74  112 4a  J
;-> 75  113 4b  K
;-> 76  114 4c  L
;-> 77  115 4d  M
;-> 78  116 4e  N
;-> 79  117 4f  O
;-> 80  120 50  P
;-> 81  121 51  Q
;-> 82  122 52  R
;-> 83  123 53  S
;-> 84  124 54  T
;-> 85  125 55  U
;-> 86  126 56  V
;-> 87  127 57  W
;-> 88  130 58  X
;-> 89  131 59  Y
;-> 90  132 5a  Z
;-> 91  133 5b  [
;-> 92  134 5c  \
;-> 93  135 5d  ]
;-> 94  136 5e  ^
;-> 95  137 5f  _
;-> 96  140 60  `
;-> 97  141 61  a
;-> 98  142 62  b
;-> 99  143 63  c
;-> 100 144 64  d
;-> 101 145 65  e
;-> 102 146 66  f
;-> 103 147 67  g
;-> 104 150 68  h
;-> 105 151 69  i
;-> 106 152 6a  j
;-> 107 153 6b  k
;-> 108 154 6c  l
;-> 109 155 6d  m
;-> 110 156 6e  n
;-> 111 157 6f  o
;-> 112 160 70  p
;-> 113 161 71  q
;-> 114 162 72  r
;-> 115 163 73  s
;-> 116 164 74  t
;-> 117 165 75  u
;-> 118 166 76  v
;-> 119 167 77  w
;-> 120 170 78  x
;-> 121 171 79  y
;-> 122 172 7a  z
;-> 123 173 7b  {
;-> 124 174 7c  |
;-> 125 175 7d  }
;-> 126 176 7e  ~
;-> -------------


--------------
Pari o dispari
--------------

Definiamo le funzioni "pari" e "dispari":

(define (pari n) (if (= n 0) true (dispari (- n 1))))

(define (dispari n) (if (= n 0) nil (pari (- n 1))))

(pari 5)
;-> nil
(pari 0)
;-> true
(dispari 0)
;-> nil
(dispari 5)
;-> true

Altro metodo (più veloce) per definire le funzioni "pari " e "dispari":

(define (pari n) (if (= (% n 2) 0) true nil))

(define (dispari n) (if (= (% n 2) 0) nil true))


-----
Crono
-----

Definiamo una funzione che prende un numero n come argomento e costruisce una lista con tutti i numeri da n fino a 1 in ordine decrescente:

Stile Scheme/Lisp:

(define (crono n)
  (if (<= n 0)
      '()
      (cons n (crono (- n 1)))
  )
)

; Nota: '() rappresenta la lista vuota

(crono 10)
;-> (10 9 8 7 6 5 4 3 2 1)

Stile iterativo:

(define (crono2 n)
  (let (out '())
    (for (i n 1 -1)
      (push i out -1)
    )
    out))

(crono2 10)
;-> (10 9 8 7 6 5 4 3 2 1)

Stile newLISP:

(define (crono3 n) (sequence n 1))

(crono3 10)
;-> (10 9 8 7 6 5 4 3 2 1)

(time (crono 200) 10000)
;-> 1373.739
(time (crono2 200) 10000)
;-> 98.895
(time (crono3 200) 10000)
;-> 12.066

------------------------------
Cambiare di segno ad un numero
------------------------------

Primo metodo (sottrazione)
--------------------------
(setq n -1.24)
;-> -1.24
(setq n (sub 0 n))
;-> 1.24
(setq n (sub 0 n))
;-> -1.24

Secondo metodo (moltiplicazione)
--------------------------------
(setq n -1.24)
;-> -1.24
(setq n (mul -1 n))
;-> 12.4
(setq n (mul -1 n))
;-> -1.24

Vediamo quale metodo è più veloce:

(map (lambda (x) (sub 0 x))  (sequence 1 10))
;-> (-1 -2 -3 -4 -5 -6 -7 -8 -9 -10)

(map (lambda (x) (mul -1 x)) (sequence 1 10))
;-> (-1 -2 -3 -4 -5 -6 -7 -8 -9 -10)

Test primo metodo:
(time (map (lambda (x) (sub 0 x))  (sequence 1 1000000)) 10)
Questo è leggermente più veloce:
(time (map (lambda (x) (sub x))  (sequence 1 1000000)) 10)
;-> 906.196

Test secondo metodo:
(time (map (lambda (x) (mul -1 x)) (sequence 1 1000000)) 10)
;-> 906.343

I due metodi hanno la stessa velocità.

Terzo metodo (bitwise not "~") (valido solo per numeri interi)
--------------------------------------------------------------
(setq n -10)
;-> -10
(setq n (add (~ n) 1))
;-> 10
(setq n (add (~ n) 1))
;-> -10

Test terzo metodo:
(time (map (lambda (x) (add (~ x) 1)) (sequence 1 1000000)) 10)
;-> 1207.781

Questo metodo è più lento.

Quarto metodo (segno meno "-") (valido solo per numeri interi)
--------------------------------------------------------------
(setq n -10)
;-> -10
(setq n (- n))
;-> 10
(setq n (- n))
;-> -10

Test quarto metodo:
(time (map (lambda (x) (- x)) (sequence 1 1000000)) 10)
;-> 900.067

Quinto metodo (segno per "*") (valido solo per numeri interi)
-------------------------------------------------------------
(setq n -10)
;-> -10
(setq n (* -1 n))
;-> 10
(setq n (* -1 n))
;-> -10

Test quinto metodo:
(time (map (lambda (x) (* -1 x)) (sequence 1 1000000)) 10)
;-> 902.346

Con i numeri interi abbiamo velocità simile a quella dei primi due metodi (numeri floating point).


----------------------------------
Moltiplicazione solo con addizioni
----------------------------------

Moltiplicare due numeri naturali (interi positivi)

(define (moltiplica n m)
  (local (p)
    (setq p 0)
    (while (> n 0)
      (setq p (+ p m))
      (-- n)
    )
    p
  )
)

(moltiplica 1 12)
;-> 12

(moltiplica 20 30)
;-> 600


------------------------------
Divisione solo con sottrazioni
------------------------------

Dividere due numeri naturali (interi positivi)

(define (dividi n m)
  (local (q r)
    (setq r n)
    (setq q 0)
    (while (>= r m)
      (++ q)
      (setq r (- r m))
    )
    (list q r)
  )
)

(dividi 10 3)
;-> (3 1)

(dividi 121 11)
;-> (11 0)


----------------------
Distanza tra due punti
----------------------

P1 = (x1, y1)
P2 = (x2, y2)

Distanza al quadrato (piano cartesiano):

(define (dist2 x1 y1 x2 y2)
  (add (mul (sub x1 x2) (sub x1 x2))
       (mul (sub y1 y2) (sub y1 y2)))
)

Distanza (piano cartesiano):

(define (dist x1 y1 x2 y2)
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2))))
)

Distanza griglia manhattan (4 movimenti - esempio: torre):

(define (distM4 x1 y1 x2 y2)
  (add (abs (sub x1 x2)) (abs (sub y1 y2)))
)

Distanza griglia manhattan (8 movimenti - esempio: regina):

(define (distM8 x1 y1 x2 y2)
  (max (abs (sub x1 x2)) (abs (sub y1 y2)))
)

(dist 1 2 5 5)
;-> 5
(distM4 1 2 5 5)
;-> 7
(distM8 1 2 5 5)
;-> 4


---------------------------------
Conversione decimale <--> binario
---------------------------------

Questa funzione converte un numero decimale in un numero binario (lista):

(define (decimale2binario n)
  (reverse (d2b n)))

(define (d2b n)
  (if (zero? n) '(0)
      (cons (% n 2) (d2b (/ n 2)))
  )
)

(decimale2binario 1133)
;-> (1 0 0 0 1 1 0 1 1 0 1)

(decimale2binario 1233)
;-> (1 0 0 1 1 0 1 0 0 0 1)

(decimale2binario 2)
;-> (1 0)

(decimale2binario 0)
;-> (0)

Questa funzione converte un numero binario (lista) in un numero decimale:

(define (binario2decimale n)
  (b2d (reverse n)))

(define (b2d n)
    (if (null? n) 0
        (+ (first n) (* 2 (b2d (rest n))))
    )
)

(binario2decimale '(1 0 0 0 1 0 1 1 0 0 1))
;-> 1133

(binario2decimale '(1 0 0 1 1 0 1 0 0 0 1))
;-> 1233

(binario2decimale '(0))
;-> 0

Queste funzione converte un numero binario in un numero intero:

(define (bin2dec n)
  (if (zero? n) n
      (+ (% n 10) (* 2 (bin2dec (/ n 10))))))

(bin2dec 10001011001)
;-> 1113

(bin2dec 10011010001)
;-> 1233

(bin2dec 0)
;-> 0

Queste funzione converte un numero intero in un numero binario:

(define (dec2bin n)
   (if (zero? n) n
       (+ (% n 2) (* 10 (dec2bin(/ n 2))))
   )
)

(dec2bin 1133)
;-> 10001101101

(dec2bin 1233)
;-> 10011010001

(dec2bin 0)
;-> 0

(bin2dec (dec2bin 1133))
;-> 1133

(dec2bin (bin2dec 10011010001))
;-> 10011010001

Possiamo scrivere una funzione generale che converte un numero da una base (b1) ad un'altra base (b2):

(define (b1-b2 n b1 b2)
  (if (zero? n) n
      (+ (% n b2) (* b1 (b1-b2 (/ n b2) b1 b2)))))

(b1-b2 1133 10 2)
;-> 10001101101

(b1-b2 10001101101 2 10)
;-> 1133

Anche le funzioni predefinite "int" e "bits" di newLISP servono per convertire numeri da una base all'altra.

Vediamo alcuni esempi:

Converte una stringa esadecimale in decimale (il parametro 0 è il valore predefinito che viene restituito quando la conversione genera un errore):

(int "0xdecaff" 0 16)
;-> 14600959

Converte una stringa binaria nel numero decimale corrispondente:

(int "10101010" 0 2)
;-> 170

Converte un numero in una stringa o in una lista (1 -> true, 0 -> nil) che contiene il numero binario corrispondente:

(bits 170)
;-> "10101010"

(bits 170 true)
;-> (nil true nil true nil true nil true)

(int (bits 1234) 0 2)
;-> 1234

Funzione di conversione proposta da Lutz:

(define (binary x)
   (append
      (if (> x 1) (binary (/ x 2)) '())
      (list (% x 2))
   )
)

(binary 10239)
;-> (1 0 0 1 1 1 1 1 1 1 1 1 1 1)


-------------------------------------
Conversione decimale <--> esadecimale
-------------------------------------

Questa funzione converte un numero intero positivo in una stringa esadecimale:

(define (d2h n)
  (local (digit x y)
    (setq digit "0123456789ABCDEF")
    (setq x (% n 16))
    (setq y (/ n 16))
    (if (= y 0) (nth x digit)
        (cons (nth x digit) (d2h y))
    )
  )
)

(define (dec2hex n)
  (if (= n 0) "0"
      (join (reverse(d2h n)))
  )
)

(dec2hex 16)
;-> "10"
(dec2hex 0)
;-> "0"
(dec2hex 100001)
;-> "186A1"

Questa funzione converte una stringa esadecimale in un numero intero positivo:

(define (hex2dec s)
  (local (digit val)
    (setq digit "0123456789ABCDEF")
    (setq val 0L)
    (dostring (c s)
      (setq val (+ (* val 16) (find (char c) digit)))
      ; la seguente istruzione converte la variabile val in un numero intero,
      ; quindi genera un risultato sbagliato quando superiamo il limite.
      ; Ponendo val prima del numero 16 forza newLISP a considerare big integer
      ; il risultato dell'operazione di moltiplicazione.
      ;(setq val (+ (* 16 val) (find (char c) digit)))
      ; Comunque usando 16L al posto di 16 tutto funziona:
      ;(setq val (+ (* 16L val) (find (char c) digit)))
    )
  )
)

(hex2dec "0")
;-> 0L

(hex2dec "FF")
;-> 255L

(hex2dec "0123456789ABCDEF")
;-> 81985529216486895L


(hex2dec "FFFFFFFFFFFFFFFFFFFF")
;-> 1208925819614629174706175L

Nota:
Se il numero esadecimale non è intero per trasformarlo in numero decimale bisogna:
- convertire la parte intera scrivendo la somma dei prodotti delle cifre del numero, per le potenze decrescenti del 16.
- convertire la parte frazionaria scrivendo la somma dei prodotti delle cifre del numero, per le potenze crescenti negative del 16.


-------------------------------
Conversione decimale --> romano
-------------------------------

; roman.lsp
; Sam Cox December 8, 2003
;
; LM 2003/12/12: took out type checking of n
;
;
; This function constructs a roman numeral representation from its positive
; integer argument, N.  For example,
;
;     (roman 1988) --> MCMLXXXVIII
;
; The Roman method of writing numbers uses two kinds of symbols: the basic
; symbols are I=1, X=10, C=100 and M=1000; the auxiliary symbols are V=5,
; L=50 and D=500. A rule prescribes that the symbol for the larger number
; always stands to the left of that for the smaller number. An exception
; is motivated by the desire to use as few symbols as possible. For
; example, the number nine can be represented as VIIII (5+4) or IX (10-1);
; the latter is preferred.  Therefore, if the symbol of a smaller number
; stands at the left, the corresponding number has to be subtracted, not
; added.  It is not permitted to place several basic symbols or an
; auxiliary symbol in front.  For example, use CML for 950 instead of LM.
; ---
; The VNR Encyclopedia of Mathematics, W. Gellert, H. Kustner, M. Hellwich,
; and H. Kastner, eds., Van Nostrand Reinhold Company, New York, 1975.

(define (roman n)
        (roman-aux "" n (first *ROMAN*) (rest *ROMAN*)))

(define (roman-aux result n pair remaining)
    (roman-aux-2 result n (first pair) (second pair) remaining))

(define (roman-aux-2 result n val rep remaining)
    (if
        (= n 0)
            result
        (< n val)
            (roman-aux result n (first remaining) (rest remaining))
        ;else
            (roman-aux-2 (append result rep) (- n val) val rep remaining)))

(define (second x) (nth 1 x))

(setq *ROMAN*
         '(( 1000  "M" )
           (  999 "IM" )
           (  990 "XM" )
           (  900 "CM" )
           (  500  "D" )
           (  499 "ID" )
           (  490 "XD" )
           (  400 "CD" )
           (  100  "C" )
           (   99 "IC" )
           (   90 "XC" )
           (   50  "L" )
           (   49 "IL" )
           (   40 "XL" )
           (   10  "X" )
           (    9 "IX" )
           (    5  "V" )
           (    4 "IV" )
           (    1  "I" )))

In versione ricorsiva:

(define (->roman n)
    (let (roman-a '((1000 "M") (100  "C") (99 "IC") (90 "XC") (50  "L") (49 "IL")
                    (40 "XL")  (10  "X") (9 "IX") (5  "V") (4 "IV") (1  "I")))
      (define (roman-aux result n pair remaining)
          (roman-aux-2 result n (pair 0) (pair 1) remaining))
      (define (roman-aux-2 result n val rep remaining)
          (if (= n 0)  result
              (< n val) (roman-aux result n (remaining 0) (1 remaining))
              (roman-aux-2 (append result rep) (- n val) val rep remaining)))
      (roman-aux "" n (roman-a 0) (1 roman-a))))

(->roman 1234)
;-> "MCCXXXIV"


------------------------------------
Conversione numero intero <--> lista
------------------------------------

Vediamo due funzioni per convertire da numero intero a lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

(int2list 1234567890)
;-> (1 2 3 4 5 6 7 8 9 0)

(define (int2list2 n)
  (map int (explode (string n))))

(int2list2 1234567890)
;-> (1 2 3 4 5 6 7 8 9 0)

Vediamo quale delle due è più veloce:

(time (int2list 9223372036854775807) 100000)
;-> 332.671

(time (int2list2 9223372036854775807) 100000)
;-> 442.561

Vediamo tre funzioni per convertire da lista a numero intero:

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

(list2int '(1 2 3 4 5 6 7 8 9 0))
;-> 1234567890

(define (list2int2 lst)
  (int (join (map string lst))))

(list2int2 '(1 2 3 4 5 6 7 8 9 0))
;-> 1234567890

(define (list2int3 lst)
  (let (n 0)
    (dolist (el lst) (setq n (+ el (* n 10))))))

(list2int3 '(1 2 3 4 5 6 7 8 9 0))
;-> 1234567890

Vediamo quale delle tre è più veloce:

(time (list2int '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 622.365

(time (list2int2 '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 855.138

(time (list2int3 '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 234.349

Ricapitoliamo:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))) out))

(int2list 1282738374847)
;-> (1 2 8 2 7 3 8 3 7 4 8 4 7)

(define (int2list2 n) (map sym (explode (string n))))

(int2list2 1282738374847)
;-> (1 2 8 2 7 3 8 3 7 4 8 4 7)

(time (dotimes (x 1e6) (int2list x)))
;-> 1143.595
(time (dotimes (x 1e6) (int2list2 x)))
;-> 1866.541

(time (dotimes (x 1e7) (int2list x)))
;-> 12979.094
(time (dotimes (x 1e7) (int2list2 x)))
;-> 17760.076


-------------------------------
Numeri casuali in un intervallo
-------------------------------

Generare un numero casuale n tale che: a <= n <= b

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1)))
)

(rand-range 1 10)
;-> 1

Facciamo un test sulla distribuzione dei risultati:

(define (test n a b)
  (local (vec r)
    (setq vec (array 10 '(0)))
    (for (i 0 n)
      (setq r (rand-range a b))
      (++ (vec r))
    )
    vec
  )
)

(test 100000 1 5)
;-> (0 19828 20179 20076 20263 19655 0 0 0 0)

(test 100000 0 9)
;-> (9855 9809 9951 10199 9978 10006 9934 10110 10058 10101)


-------------------
Calcolo proporzione
-------------------

Calcolare il valore ignoto (che viene rappresentato con il numero zero) di una proporzione: A/B = C/D

(define (proporzione a b c d)
        ; nessuno zero: controllo proporzione
  (cond ((= '(0) (count '(0) (list a b c d)))
         (= (div a b) (div c d)))
        ; numero zeri maggiore di 1: nil
        ((!= '(1) (count '(0) (list a b c d))) nil)
        ; numero zeri uguale a 1: calcolo proporzione...
        ((= a 0) (div (mul b c) d))
        ((= b 0) (div (mul a d) c))
        ((= c 0) (div (mul a d) b))
        ((= d 0) (div (mul b c) a))
  )
)

(proporzione 4 2 10 0)
;-> 5
(proporzione 0 2 10 5)
;-> 4
(proporzione 4 2 0 5)
;-> 10
(proporzione 4 0 10 5)
;-> 2
(proporzione 4 3 0 0)
;-> nil
(proporzione 10 5 4 3)
;-> nil
(proporzione 10 5 4 2)
;-> true


----------------------------------------
Estrarre l'elemento n-esimo da una lista
----------------------------------------

; ======================================
; (n-esimo n lst)
; Estrae l'elemento n-esimo da una lista
; ======================================

(define (n-esimo n lst)
  (if (= lst '()) '()
    (if (= n 0)
        (first lst)
        (n-esimo (- n 1) (rest lst))
    )
  )
)

(n-esimo 1 '(1 (2 3) 4))
;-> (2 3)

(n-esimo 0 '(1 (2 3) 4))
;-> 1

(n-esimo 5 '(1 (2 3) 4))
;-> ()


------------------------------------
Verificare se una lista è palindroma
------------------------------------

; ======================================
; (palindroma? lst)
; Controlla se la lista lst è palindroma
; ======================================
(define (palindroma? lst)
  (= lst (reverse (copy lst))))

Nota: senza la funzione "copy", la condizione (= lst (reverse lst)) è sempre vera (perchè (reverse lst) è una funzione distruttiva.

(palindroma? '(n e w L I S P))
;-> nil

(palindroma? '(e p r e s a l a s e r p e))
;-> true


--------------------------------------
Verificare se una stringa è palindroma
--------------------------------------

(define (palindroma? str)
  (= str (reverse (copy str))))

(palindroma? "ababa")
;-> true

Vediamo una soluzione con gli indici:

(define (palindroma? str)
  (catch
    (local (start end)
      (setq start 0)
      (setq end (- (length str) 1))
        (while (< start end)
          (if (!= (str start) (str end)) (throw nil))
          (++ start)
          (-- end)
        )
      true
    );local
  );catch
)

(palindroma? "epresalaserpe")
;-> true

(palindroma? "abbai")
;-> nil


------------------------------------
Verificare se un numero è palindromo
------------------------------------

(define (palindromo? num)
  (let (str (string num))
    (= str (reverse (copy str)))))

(palindromo? 1234321)
;-> true

(define (palinum? num)
  (let ((val 0) (copia num))
    (until (null? num)
      (setq val (+ (* 10 val) (% num 10)))
      (setq num (/ num 10))
    )
    (= val copia)
  )
)

(palinum? 1234321)
;-> true

(time (map palindromo? (sequence 100000 110000)) 200)
;-> 1535.427

(time (map palinum? (sequence 100000 110000)) 200)
;-> 2778.158


---------------
Zippare N liste
---------------

La funzione "zip" prende due liste e raggruppa in coppie gli elementi delle due liste che hanno lo stesso indice.
Il risultato è una lista costituita da sottoliste con due elementi ciascuna.La lunghezza della lista è uguale a quella della lista più corta (cioè, la funzione deve fermarsi quando termina una delle due liste).

; zippa due liste
(define (zip l1 l2)
  (if (or (null? l1) (null? l2))
      '()
      (cons (list (first l1) (first l2))
            (zip (rest l1) (rest l2)))))

Se una delle due liste è vuota, allora ritorna la lista vuota. Altrimenti, formiamo una lista dei primi elementi di ciascuna lista e la associamo alla versione zippata delle parti rimanenti di ciascuna lista. Il risultato è la nostra lista formata da sottoliste di due elementi.

(zip '(1 2 3) '(a b c))
;-> ((1 a) (2 b) (3 c))

(zip '(1 2 3) '(a))
;-> ((1 a))

(zip '(1) '(a b c))
;-> ((1 a))

(zip '(1 3 5) '(2 4 6))
;-> ((1 2) (3 4) (5 6))

Possiamo scrivere la funzione "zip" utilizzando "map" e "apply":

; zip due liste
(define (zip l1 l2) (map list l1 l2))

(zip '(1 2 3) '(a b c))
;-> ((1 a) (2 b) (3 c))

(zip '(1 2 3) '(a))
;-> ((1 a) (2) (3))

(zip '(1) '(a b c))
;-> ((1 a))

Questa ultima funzione può essere facilmente estesa per trattare N liste:

; zippa N liste
(define (zip lst)
  (apply map (cons list lst)))

(zip '((1 a x) (2 b y)))
;-> ((1 2) (a b) (x y))

(zip '((1 2) (a b) (x y)))
;-> (1 a x) (2 b y))

Calcoliamo il tempo di esecuzione:

(time (zip '((1 a x) (2 b y))) 100000)
;-> 78.116 msec

La funzione "zip" è uguale alla funzione che traspone una matrice (scambia le righe con le colonne). Poichè newLISP fornisce la funzione "transpose" possiamo scrivere:

(transpose '((1 2 3) (a b c)))
;-> ((1 a) (2 b) (3 c))

Quindi la funzione che zippa N liste diventa:

; =============================================
; (zip lst)
; Zippa (traspone) una lista di liste (matrice)
; =============================================
; zippa N liste
(define (zip lst)
  (transpose lst))

(zip '((1 a x) (2 b y)))
;-> ((1 2) (a b) (x y))

Calcoliamo il tempo di esecuzione e notiamo che è più veloce della funzione iniziale:

(time (zip '((1 a x) (2 b y))) 100000)
;-> 31.87 msec

Vedia anche "La funzione Riffle (Mathematica)" su "Note libere 25".


--------------------------------------------------------------
Sostituire gli elementi di una lista con un determinato valore
--------------------------------------------------------------

Si tratta di sostituire tutti gli elementi di una lista con un determinato valore con un altro valore.

La funzione è la seguente:

(define (sostituisci x y lst)
    (if (null? lst) '()
      (if (= x (first lst))
        (cons y (sostituisci x y (rest lst)))
        (cons (first lst) (sostituisci x y (rest lst)))
      )
    )
)

(sostituisci 'd 'K '(a b c d 1 2 3 d))
;-> (a b c K 1 2 3 K)

Per rimpiazzare tutti gli elementi di una lista che hanno un determinato valore possiamo utilizzare la funzione built-in "replace":

(setq lst '(a b c d 1 2 3 d))
(replace 'd lst 'K)
;-> (a b c K 1 2 3 K)

(setq lst '((a b) (c d) (1 2 (3 d))))
(replace '(c d) lst 'K)
;-> ((a b) K (1 2 (3 d)))

Purtroppo "replace" non funziona quando vogliamo modificare un atomo che si trova all'interno di una lista nidificata:

(setq lst '((a b) (c d) (1 2 (3 d))))
(replace 'd lst 'K)
;-> ((a b) (c d) (1 2 (3 d)))

In questo caso dobbiamo utilizzare la funzione "set-ref-all":

(setq lst '((a b) (c d) (1 2 (3 d))))
(set-ref-all 'd lst 'K)
;-> ((a b) K (1 2 (3 K)))


-------------------------------------
Raggruppare gli elementi di una lista
-------------------------------------

La funzione "raggruppa" utilizza la ricorsione, prima raggruppiamo la prima parte della lista (presa con la funzione "take"), poi richiamiamo la stessa funzione "raggruppa" sulla lista rimanente (presa con la funzione "drop").

La funzione "take" restituisce i primi n elementi di una lista:

(define (take n lst) (slice lst 0 n))

La funzione "drop" restituisce tutti gli elementi di una lista tranne i primi n (cioè vengono esclusi dalla lista risultante i primi n elementi della lista passata:

(define (drop n lst) (slice lst n))

Adesso possiamo scrivere la funzione "raggruppa":

(define (raggruppa n lst)
   (if (null? lst) '()
      (cons (take n lst) (raggruppa n (drop n lst)))
   )
)

(setq lst '(0 1 2 3 4 5 6 7 8 9))
(raggruppa 2 lst)
;-> ((0 1) (2 3) (4 5) (6 7) (8 9))
(raggruppa 3 lst)
;-> ((0 1 2) (3 4 5) (6 7 8) (9))

(setq lst '(1 2 3 4 5 6 7 8 9 10 11 12))
(raggruppa 2 (raggruppa 2 lst))
;-> (((1 2) (3 4)) ((5 6) (7 8)) ((9 10) (11 12)))

Con newLISP possiamo utilizzare anche la funzione "explode".


-----------------------------------
Enumerare gli elementi di una lista
-----------------------------------

; =====================================================
; (emumera lst)
; Crea una nuova lista numerando gli elementi di lst
; =====================================================
(define (enumera lst)
  (local (out)
    (cond ((null? lst) '())
          (true (setq out '())
                (dolist (el lst)
                  ;(push (list $idx el) _out)
                  ;(push (list $idx el) _out -1)
                  (extend out (list(list $idx el)))
                )
                ;(reverse _out)
          )
    )
  )
)

(enumera '(a b c))
;-> ((0 a) (1 b) (2 c))

(enumera '((a b) (c d) e))
;-> ((0 (a b)) (1 (c d)) (2 e))

Oppure:

(define (enumera lst)
  (map list (sequence 0 (sub (length lst) 1)) lst))

(enumera '(a b c))
;-> ((0 a) (1 b) (2 c))

(enumera '((a b) (c d) e))
;-> ((0 (a b)) (1 (c d)) (2 e))

Oppure:

(map (fn (x) (list $idx x)) '((a b) (c d) e))
;-> ((0 (a b)) (1 (c d)) (2 e))


-----------------------------------------------------------
Creare una stringa come ripetizione di un carattere/stringa
-----------------------------------------------------------

newLISP possiede la funzione "dup" che funzione anche con i simboli:

(dup "A" 6)       → "AAAAAA"
(dup "A" 6 true)  → ("A" "A" "A" "A" "A" "A")
(dup "A" 0)       → ""
(dup "AB" 5)      → "ABABABABAB"
(dup 9 7)         → (9 9 9 9 9 9 9)
(dup 9 0)         → ()
(dup 'x 8)        → (x x x x x x x x)
(dup '(1 2) 3)    → ((1 2) (1 2) (1 2))
(dup "\000" 4)    → "\000\000\000\000"
(dup "*")         → "**"

Proviamo a scrivere la nostra funzione:

; =====================================================
; (duplica str num)
; Duplica la stringa str per num volte
; =====================================================

(define (duplica str num , newstr)
  (local (newstr)
    (setq newstr "")
    (dotimes (x num)
      (extend newstr str)
    )
   )
)

(duplica "prova" 4)
;-> "provaprovaprovaprova"


--------------------------------------------------
Massimo annidamento di una lista ("s-espressione")
--------------------------------------------------

La seguente funzione calcola il livello massimo di annidamento di una lista:

(define (annidamento lst)
  (cond ((null? lst) 0)
        ((atom? lst) 0)
        (true (max (+ 1 (annidamento (first lst)))
                   (annidamento (rest lst))))
  )
)

Il trucco sta nell'utilizzare la funzione "max" per scoprire quale ramo della ricorsione è il più profondo, notando che ogni volta che ricorriamo su first aggiungiamo un altro livello.

(annidamento '())
;-> 0
(annidamento '(a b))
;-> 1
(annidamento '((a)))
;-> 2
(annidamento '(a (b) ((c)) d e f))
;-> 3
(annidamento '(a (((b c d))) (e) ((f)) g))
;-> 4
(annidamento '(a (((b c (d)))) (e) ((f)) g))
;-> 5

rickyboy:

(define (nesting lst)
  (if (null? lst) 0
      (atom? lst) 0
      (+ 1 (apply max (map nesting lst)))))

fdb:

(define (nesting lst prev (t 0))
   (if (= lst prev)
      t
     (nesting (flat lst 1) lst (inc t))))

(nesting '(a (((b c (d)))) (e) ((f)) g))
;-> 5


-------------------------------
Run Length Encode di una lista
-------------------------------

Esempio: (rle '(a a a b b c c a d d))
;-> ((3 a) (2 b) (2 c) (1 a) (2 d))

Implementiamo il metodo di compressione Run Length Encoding ad una lista. Gli elementi consecutivi duplicati sono codificati come liste (N E) dove N è il numero di duplicati dell'elemento E.

; =====================================================
; (rle-encode lst)
; Codifica una lista con il metodo Run Length Encoding
; =====================================================
(define (rle-encode lst)
  (local (palo conta out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq palo (first lst))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              (if (= el palo) (++ conta)
                  ; altrimenti costruiamo la coppia (conta el) e la aggiungiamo al risultato
                  (begin (push (list conta palo) out -1)
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           (push (list conta palo) out -1)
          )
    )
    out
  )
)

(rle-encode '(a a a a b c c a a d e e e e f))
;-> ((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f))


------------------------------
Run Length Decode di una lista
------------------------------

Esempio: (rle-decode '((3 a) (2 b) (2 c) (1 a) (2 d)))
;-> (a a a b b c c a d d))

; =====================================================
; (rle-decode lst)
; Decodifica una lista compressa con il metodo Run Length Encoding
; =====================================================
(define (rle-decode lst)
  (local (out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (dolist (el lst)
              (extend out (dup (last el) (first el)))
           )
          )
    )
    out
  )
)

(rle-decode '((3 a) (2 b) (2 c) (1 a) (2 d)))
;-> (a a a b b c c a d d))

(rle-decode '((4 a) (1 b) (2 c) (2 a) (1 d) (4 e) (1 f)))
;-> (a a a a b c c a a d e e e e f)

(rle-decode (rle-encode '(a a a a b c c a a d e e e e f)))
;-> (a a a a b c c a a d e e e e f)


-----------------------------------------------
Massimo Comun Divisore e Minimo Comune Multiplo
-----------------------------------------------

In inglese:
GCD -> Greatest Common Divisor
LCM -> Least Common Multiple

; =============================================
; (my-gcd x1 x2 x3 ... xn)
; Calcola il massimo comun divisore di N numeri
; =============================================
(define (gcd_ a b) ; gcd funzione ausiliaria
  (let (r (% b a))
    (if (= r 0) a (gcd_ r a))))

(gcd_ 12 30)
;-> 6

(define-macro (my-gcd)
  ; ritorna il massimo comun divisore di tutti i numeri interi passati
  (apply gcd_ (args) 2))

(my-gcd 12 30 4)
;-> 2

; =============================================
; (my-lcm x1 x2 x3 ... xn)
; Calcola il minimo comune multiplo di N numeri
; =============================================
(define (lcm_ a b)
  ; lcm funzione ausiliaria
  (/ (* a b) (gcd_ a b)))

(lcm_ 12 30)
;-> 60

(define-macro (my-lcm)
  ; ritorna il minimo comune multiplo di tutti i numeri interi passati
  (apply lcm_ (args) 2))

(my-lcm 12 60 130)
;-> 780

Possiamo anche utilizzare una funzione lambda al posto della funzione ausiliaria:

(define-macro (lcm)
  (apply (fn (x y) (/ (* x y) (gcd_ x y))) (args) 2))

(lcm 12 60 130)
;-> 780


-----------------
Funzioni booleane
-----------------

; =====================================================
; Funzioni booleane e bitwise
; nand, nor, xor xnor
; =====================================================

;; boolean functions
(define (nand a b) (not (and a b)))
(define (nor a b) (not (or a b)))
(define (xor a b) (if (nand a b) (or a b) nil))
(define (xnor a b) (not (xor a b)))

;; bitwise versions:
(define (~& a b) (~ (& a b))) ; nand, bitwise
(define (~| a b) (~ (| a b))) ; nor, bitwise
;; xor is already in the language as ^
(define (~^ a b) (~ (^ a b))) ; xnor, bitwise


-------------------------------
Estrazione dei bit di un numero
-------------------------------

; Restituisce il bit n-esimo del numero intero positivo x
; indice zero
(define (bit n x)
    (if (< x 0) (setq x (sub 0 x))) ; solo numeri positivi
    (& (>> x (- n 1)) 1)
)

(bits 123)
;-> 1111011

(bit 1 123) ;-> 1
(bit 2 123) ;-> 1
(bit 3 123) ;-> 0
(bit 4 123) ;-> 1
(bit 5 123) ;-> 1
(bit 6 123) ;-> 1
(bit 7 123) ;-> 1

Per i big-integer possiamo usare la seguente funzione:

; Compute "bits" for bigint and int
(constant 'MAXINT (pow 2 62))
(define (prep s) (string (dup "0" (- 62 (length s))) s))
(define (bitsL n)
    (if (<= n MAXINT) (bits (int n))
      (string (bitsL (/ n MAXINT))
              (prep (bits (int (% n MAXINT)))))))

(bitsL 191934985723489057239845792384579823475981L)
;->"100011010000001011110101011010001101010110100111011110110000000110001010
;-> 110011011000001001000100010111101011011011010101000001110100001101"


---------------------------------------------------
Conversione gradi decimali <--> gradi sessagesimali
---------------------------------------------------

; =====================================================
; (dd-to-dms degrees)
; Converte gradi decimali in gradi, minuti, secondi
; =====================================================

(define (dd-to-dms degrees)
  (local (udegree d m s)
    (if (> 0.0 degrees)
        (setq udegree (abs degrees))
        (setq udegree degrees)
    )
    (setq d (int udegree))
    (setq m (int (mul 60.0 (sub udegree d))))
    (setq s (mul 3600.0 (sub udegree d (div m 60.0))))
    (if (> 0.0 degrees) (set 'd (sub d 0)))
    ;(println d { } m { } s { })
    (list d m s)
    ;result d m s
  )
)

(dd-to-dms 30.263888889)
;-> 30 15 50.00000040000145

; =====================================================
; (dms-to-decimal degrees minutes seconds)
; Converte gradi, minuti, secondi in gradi decimali
; =====================================================

(define (dms-to-dd degrees minutes seconds)
  (local (dd)
    (if (< 0.0 degrees)
        (setq dd (add degrees (div minutes 60.0) (div seconds 3600.0)))
        (setq dd (add degrees (- 0.0 (div minutes 60.0)) (- 0.0 (div seconds 3600.0))))
    )
    result dd
  )
)

(dms-to-dd 30.0 15.0 50.0)
;-> 30.26388888888889


------------------------
Conversione RGB <--> HSV
------------------------

Conversione di un colore dallo spazio RGB (Red, Green, Blu) allo spazio HSV (Hue Saturation Value) e viceversa. Per ulteriori informazioni consultare il sito:

http://www.easyrgb.com/en/math.php

R, G e B input range  = 0 ÷ 255
H, S e V output range = 0 ÷ 1.0

Conversione RGB -> HSV:

(define (rgb2hsv r g b)
  (local (h s v var-r var-g var-b var-min var-max del-max del-r del-g del-b)
    (setq var-r (div r 255))
    (setq var-g (div g 255))
    (setq var-b (div b 255))
    (setq var-min (min var-r var-g var-b)) ; valore minimo di RGB
    (setq var-max (max var-r var-g var-b)) ; valore massimo di RGB
    (setq del-max (sub var-max var-min))   ; delta RGB
    (setq v var-max)
    (cond ((= 0 del-max) (setq h 0) (setq s 0)) ; tono di grigio
           (true ; colore
              (setq s (div del-max var-max))
              (setq del-r (div (add (div (sub var-max var-r) 6) (div del-max 2)) del-max))
              (setq del-g (div (add (div (sub var-max var-g) 6) (div del-max 2)) del-max))
              (setq del-b (div (add (div (sub var-max var-b) 6) (div del-max 2)) del-max))
              (cond ((= var-r var-max) (setq h (sub del-b del-g)))
                    ((= var-g var-max) (setq h (add (div 1 3) (sub del-r del-b))))
                    ((= var-b var-max) (setq h (add (div 2 3) (sub del-g del-r))))
                    (true println "errore")
              )
              (if (< h 0) (setq h (add 1 h)))
              (if (> h 1) (setq h (sub 1 h)))
           );end true
    )
    (list h s v)
  );end local
)

(rgb2hsv 255 255 255)
;-> (0 0 1)

(rgb2hsv 0 0 0)
;-> (0 0 0)

(rgb2hsv 80 80 80)
;-> (0 0 0.3137254901960784)

(rgb2hsv 155 55 20)
;-> (0.04320987654320985 0.8709677419354838 0.6078431372549019)

Conversione HSV -> RGB:

(define (hsv2rgb h s v)
  (local (r g b var-h var-i var-1 var-2 var-3 var-4 var-r var-g var-b)
    (cond ((= 0 s) (setq r (mul v 255)) (setq g (mul v 255)) (setq b (mul v 255)))
          (true
             (setq var-h (mul h 6))
             (if (= var-h 6) (setq var-h 0)) ; h deve essere minore di 1
             (setq var-i (floor var-h))
             (setq var-1 (mul v (sub 1 s)))
             (setq var-2 (mul v (sub 1 (mul s (sub var-h var-i)))))
             (setq var-3 (mul v (sub 1 (mul s (sub 1 (sub var-h var-i))))))
             (cond ((= 0 var-i) (setq var-r v)     (setq var-g var-3) (setq var-b var-1))
                   ((= 1 var-i) (setq var-r var-2) (setq var-g v)     (setq var-b var-1))
                   ((= 2 var-i) (setq var-r var-1) (setq var-g v)     (setq var-b var-3))
                   ((= 3 var-i) (setq var-r var-1) (setq var-g var-2) (setq var-b v))
                   ((= 4 var-i) (setq var-r var-3) (setq var-g var-1) (setq var-b v))
                   (true        (setq var-r v    ) (setq var-g var-1) (setq var-b var-2))
             )
             (setq r (mul var-r 255))
             (setq g (mul var-g 255))
             (setq b (mul var-b 255))
          )
    );end cond
    (list r g b)
  );end local
)

(hsv2rgb 0 0 1)
;-> (255 255 255)

(hsv2rgb 0 0 0)
;-> (0 0 0)

(hsv2rgb 0 0 0.3137254901960784)
;-> (80 80 80)

(hsv2rgb 0.04320987654320985 0.8709677419354838 0.6078431372549019)
;-> (155 54.99999999999998 20.00000000000001)

(hsv2rgb 0.5 0.5 0.5)
;-> (63.75 127.5 127.5)

(rgb2hsv 63.75 127.5 127.5)
;-> (0.4999999999999999 0.5 0.5)


-------------------------------
Calcolo della media di n numeri
-------------------------------

; =====================================================
; (media lst) oppure (media x1 x2 ... xn)
; Calcola la media di n numeri
; =====================================================

(define (media)
  (if (or (= (args) '()) (= (args) '(()) )) nil
    (if (= (length (args)) 1) ;controlla se args è una lista o una serie di numeri
        (div (apply add (first (args))) (length (first (args))))
        (div (apply add (args)) (length (args)))
    )
  )
)

(media)
;-> nil

(media '())
;-> nil

(media 1 2 3)
;-> 2

(media '(1 2 3 4 5 6 7 8 9))
;-> 5

(media (sequence 1 9999))
;-> 5000

(setq lst '(1 2 3 4 5 6))
(media lst)
;-> 3.5


----------
Istogramma
----------

Data una lista disegnare l'istogramma dei valori.
Deve essere possibile passare un parametro che indica che la lista passata non è una lista di frequenze, ma una lista di valori: in tal taso occorre calcolare la lista delle frequenze prima di disegnare l'istogramma.

Le seguenti espressioni creano una lista di valori con 1000 elementi ("res"):

(setq res '())
(for (i 0 999)
  (push (rand 11) res -1)
)
(length res)

Le seguenti espressioni creano la lista delle frquenzze della lista "res":

(setq f (array 11 '(0)))
(dolist (el res)
  (println el)
  (++ (f (- el 1)))
)

f
;-> (80 98 86 83 86 99 90 106 80 84 108)

La seguente funzione disegna l'istogramma, se il parametro "calc" vale true, allora calcola la lista delle frequenze dalla lista passata:

(define (istogramma lst hmax (calc nil))
  (local (unici linee hm scala f-lst)
    (if calc
      ;calcolo la lista delle frequenze partendo da lst
      (begin
        ;trovo quanti numeri diversi ci sono nella lista
        (setq unici (length (unique lst)))
        ;creo la lista delle frequenze
        (setq f-lst (array unici '(0)))
        ; calcolo dei valori delle frequenze
        (dolist (el lst)
          (++ (f-lst (- el 1)))
        )
      )
      ;else
      ;lst è la lista delle frequenze
      (begin (setq f-lst lst))
    )
    (setq hm (apply max f-lst))
    (setq scala (div hm hmax))
    (setq linee (map (fn (x) (round (div x scala))) f-lst))
    (dolist (el linee)
      ;(println (format "%3d %s %0.2f" (add $idx 1) (dup "*" el) (f-lst $idx)))
      (println (format "%3d %s %4d" $idx (dup "*" el) (f-lst $idx)))
    )
  );local
)

(istogramma f 20)
;->   0 ***************   80
;->   1 ******************   98
;->   2 ****************   86
;->   3 ***************   83
;->   4 ****************   86
;->   5 ******************   99
;->   6 *****************   90
;->   7 ********************  106
;->   8 ***************   80
;->   9 ****************   84
;->  10 ********************  108

(istogramma res 20 true)
;->   0 ***************   80
;->   1 ******************   98
;->   2 ****************   86
;->   3 ***************   83
;->   4 ****************   86
;->   5 ******************   99
;->   6 *****************   90
;->   7 ********************  106
;->   8 ***************   80
;->   9 ****************   84
;->  10 ********************  108


--------------------
Stampare una matrice
--------------------

(define (print-matrix matrix)
  (local (row col nmax nmin digit fmtstr)
    ; converto matrice in lista ?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice (da rivedere)
    (setq col (length (first matrix)))
    ; valore massimo
    (setq nmax (string (apply max (flat matrix))))
    ; valore minimo
    (setq nmin (string (apply min (flat matrix))))
    ; calcolo spazio per i numeri
    (setq digit (add 1 (max (length nmax) (length nmin))))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "d"))
    ; stampa
    (for (i 0 (sub row 1))
      (for (j 0 (sub col 1))
        (print (format fmtstr (matrix i j)))
      )
      (println)
    )
  )
)

Con alcune modifiche la funzione può essere usata per stampare matrici di interi, floating-point e/o stringhe:

(define (print-matrix matrix)
  (local (row col lenmax digit fmtstr)
    ; converto matrice in lista?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; valore massimo della lunghezza di un elemento (come stringa)
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    ; calcolo spazio per gli elementi
    (setq digit (+ 1 lenmax))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "s"))
    ; stampa la matrice
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println)
    )
  nil))

(setq m '((1 2 3) (4 5 6) (7 8 9)))
(print-matrix m)
;-> 1 2 3
;-> 4 5 6
;-> 7 8 9

(setq m '((1111 -20000 3) (4 5 66) (7 8 999)))
(print-matrix m)
;-> 1111 -20000      3
;->    4      5     66
;->    7      8    999

(setq m '(("11.11" "2" "3") ("4" "55.555" "66") ("7" "8" "999")))
(print-matrix m)
;-> 11.11      2      3
;->     4 55.555     66
;->     7      8    999

(setq m '((1234.5 "bb" "ccc") (111 "lungo" "f") ("hh" "kkk" "zzzz")))
(print-matrix m)
;-> 1234.5     bb    ccc
;->    111  lungo      f
;->     hh    kkk   zzzz


----------------------------
Retta passante per due punti
----------------------------

(define (retta2p x1 y1 x2 y2)
  (local (m q)
    (cond ((zero? (sub x1 x2))
              (setq m (div 1 0))
              (setq q 0)
          )
          ((zero? (sub y1 y2))
              (setq m 0)
              (setq q y1)
          )
          (true
              (setq m (div (sub y1 y2) (sub x1 x2)))
              (setq q (sub y1 (mul m x1)))
          )
    )
    (list m q)
  )
)

(retta2p 2 -3 3 -1)
;-> (2 -7)

(retta2p 2 2 3 3)
;-> (1 0)

;retta verticale
(retta2p 2 4 2 3)
;-> (1.#INF 0)

;retta orizzontale
(retta2p 1 4 2 4)
;-> (0 4)


------------------------------------
Coordinate dei punti di una funzione
------------------------------------

Supponiamo di avere la seguente funzione e di voler ottenere una serie di coordinate (x,y):

y = f(x) = (3*x^2 - 4*x + 6)

Definiamo la funzione:

(define (fx x) (add (mul 3 (mul x x)) (- (mul 4 x)) 6))

Vogliamo calcolare 5 coppie di coordinate con x che va da 10 a 20.

Prima generiamo i valori delle x:

(setq l (sequence 10 20 2))
;-> (10 12 14 16 18 20)

Poi generiamo i valori delle y:

(setq k (map fx l))
;-> (266 390 538 710 906 1126)

Poi uniamo le due liste:

(transpose (list l k))
;-> ((10 266) (12 390) (14 538) (16 710) (18 906) (20 1126))

Possiamo scrivere una funzione che restituisce le coppie di coordinate:

(define (coordFX funzione xi xf passo)
  (local (lstX lstY)
    (setq lstX (sequence xi xf passo))
    (setq lstY (map funzione lstX))
    (transpose (list lstX lstY))
  )
)

(coordFX fx 10 20 2)
;-> ((10 266) (12 390) (14 538) (16 710) (18 906) (20 1126))

Definiamo la funzione quadrato:

(define (gx x) (mul x x))

(coordFX gx 1 10 1)
;-> ((1 1) (2 4) (3 9) (4 16) (5 25) (6 36) (7 49) (8 64) (9 81) (10 100))


-----------------------------------
Leggere e stampare un file di testo
-----------------------------------

;==================================
; (stampa file)
; Legge e stampa un file di testo
; Il parametro "file" è una stringa
;==================================

(define (stampa file)
  (local (afile linea)
    (setq afile (open file "read"))
    (while (read-line afile)
      (setq linea (current-line))
      (println linea)
    )
    (close afile)
  )
)

(stampa "stampa.txt")
;-> riga 1 del file da stampare
;-> riga 2 del file da stampare
;-> fine del file
;-> true


--------------------------------------
Criptazione e decriptazione di un file
--------------------------------------

La funzione "encrypt" di newLISP funziona in modo biunivoco:
(encrypt (encrypt "testo")) = "testo".
In altre parole una doppia criptazione restituisce il file originale, quindi possiamo scrivere una funzione unica:

;========================================
; Cripta/Decripta un file con buffer read
;========================================
(define (cripta inputfile outputfile key)
  (local (infile outfile crypt)
    (setq infile (open inputfile "read"))
    (setq outfile (open outputfile "write"))
    (while (!= (read infile buffer 256) nil)
        (setq crypt (encrypt buffer key))
        (write outfile crypt 256)
        ;(print (encrypt buffer key))
    )
    (close infile)
    (close outfile)
  )
)

Per criptare un file:
(cripta "testo.txt" "testo.enc" "chiave")

Per decriptare un file:
(cripta "testo.enc" "testo.out" "chiave")

Vedere anche "Cryptography fun with newLISP" su "Note libere 14".


-------------------------
Funzioni per input utente
-------------------------

*********************
>>>funzione READ-KEY
*********************
sintassi: (read-key)

Legge un tasto della tastiera e restituisce un valore intero. Per i tasti di navigazione, è necessario effettuare più di una chiamata read-key. Per i tasti che rappresentano i caratteri ASCII, il valore di ritorno è lo stesso su tutti i Sistemi Operativi, ad eccezione dei tasti di navigazione e di altre sequenze di controllo come i tasti funzione, nel qual caso i valori di ritorno possono variare in base ai diversi SO e alle configurazioni.

(read-key)  → 97  ; after hitting the A key
(read-key)  → 65  ; after hitting the shifted A key
(read-key)  → 10  ; after hitting [enter] on Linux
(read-key)  → 13  ; after hitting [enter] on Windows

(while (!= (set 'c (read-key)) 1) (println c))

L'ultimo esempio può essere utilizzato per verificare le sequenze di ritorno dalla navigazione e dai tasti funzione. Per interrompere il ciclo, premere Ctrl-A.

Notare che "read-key" funziona solo quando newLISP è in esecuzione in una shell Unix o nella shell dei comandi di Windows. Non funziona nelle gui Java newLISP-GS e Tcl/Tk newLISP-Tk. Non funziona neanche nelle shared library newwLISP di UNIX o nella DLL newLISP di Windows (Dynamic Link Library).

; =====================================================
; yes-no
; Ask user to input "Y" or "N" (all other keys)
; =====================================================

(define (yes-no message)
  (print message)
  (if (= "Y" (upper-case (read-line)))
    true
    nil
  )
)

(yes-no "Do you want to exit (y/n)? ")

; =====================================================
; input-symbol
; Ask user to input a symbol
; read-line function return a string
; =====================================================

(define (input-symbol message)
  (print message)
  ; a symbol can't begin with number
  (while (number? (int (read-line)))
    (print message)
  )
  (sym (current-line))
)

(input-symbol "Insert a symbol: ")


; =====================================================
; input-string
; Ask user to input a string
; read-line function return a string
; =====================================================

(define (input-string message)
  (print message)
  (while (not (string? (read-line)))
    (print message)
  )
  (current-line)
)

(input-string "Insert a string: ")

; =====================================================
; input-number
; Ask user to input a number (float)
; =====================================================

(define (input-number message)
  (print message)
  (while (not (number? (float (read-line))))
    (print message)
  )
  (float (current-line))
)

(input-number "Insert a number: ")

; =====================================================
; input-integer
; Ask user to input a number
; =====================================================

(define (input-integer message)
  (print message)
  (while (not (integer? (int (read-line))))
    (print message)
  )
  (int (current-line))
)

(input-integer "Insert an integer: ")


----------------
Emettere un beep
----------------

newLISP emette un suono/beep quando si stampa il carattere 'bell':

(println (char 7))
;-> "\007"

; =============================================
; (beep)
; Emette un beep
; =============================================
(define (beep)
  (silent (print (char 7))))

La funzione "silent" sopprime l'output sulla console, quindi non compare "\007".

(beep)

Può essere utile per segnalare il termine delle operazioni.


---------------------------------------
Disabilitare l'output delle espressioni
---------------------------------------

La funzione "silent" è simile a "begin": valuta una sequenza di espressioni sopprimendo l'output e il prompt. Per ritornare al prompt occorre premere "invio" due volte.

(silent (setq a 10) (println a))
;-> 10 ; premere "invio" due volte per ritornare al prompt

Un modo elegante per ritornare al prompt senza intervento dell'utente è il seguente:

; funzione che ritorna al prompt dopo una chiamata a "silence"
(define (resume) (print "\r\n> "))

; funzione generica
(define (myfunction) "valore di ritorno")

; Come utilizzare il metodo:
(silent (myfunction) (print "Fatto") (resume))

Ad esempio, per disabilitare l'output del valore di ritorno delle espressioni "print" e "println" possiamo usare le seguenti funzioni:

(define (sprint) (silent (apply print (args)) (resume)))
(define (sprintln) (silent (apply print (args)) (resume)))

Vediamo le differenze:

(println "normale")
;-> normale
;-> "normale"
(sprintln "normale")
;-> normale

(print "semplice")
;-> semplice"semplice"
(sprint "semplice")
;-> semplice

Possiamo terminare le espressioni che usano "silent" in questo modo:

(silent (println "ok?") (print ">  ")) ; due spazi dopo '>'
;-> ok?

silent sopprime solo il prompt ">" della REPL.
Anche se il prompt è soppresso, newLISP è pronto per accettare nuovi comandi.
Premendo "Invio" su una riga vuota viene stampato di nuovo il prompt.
(print ">") alla fine di un'espressione silent ripristina il normale prompt.
Possiamo anche inserirlo nel file init.lsp:

(set (global 'quiet) (fn ()
   (eval (cons silent (args)))
   (print "> ")))

E usarlo in questo modo:

(quiet (println "ok"))
;-> ok


-----------------------------------------------------
Trasformare una lista di stringhe in lista di simboli
-----------------------------------------------------

Partendo da una stringa:

(setq str "Questa è la stringa da convertire")
;-> "Questa è la stringa da convertire"

Creiamo una lista di stringhe:

(setq lst (parse str))
;-> ("Questa" "è" "la" "stringa" "da" "convertire")

Infine convertiamo la lista di stringhe in lista di simboli:

(map sym lst)
;-> (Questa è la stringa da convertire)


-----------------------------------------------------
Trasformare una lista di simboli in lista di stringhe
-----------------------------------------------------

Convertiamo una lista di simboli in una lista di stringhe:

(map string '(uno due tre))
;-> ("uno" "due" "tre")

Con una macro possiamo passare tutti i simboli senza usare una lista:

(define-macro (str-m) (map string (args)))
;-> (lambda-macro () (map string (args)))

(str-m uno due tre)
;-> ("uno" "due" "tre")

Una funzione non risolve il problema perchè prima di applicare "string" i parametri (args) vengono valutati (a nil):

(define (str-f) (map string (args)))

(str-f uno due tre)
;-> ("nil" "nil" "nil")


--------------------------
Simboli creati dall'utente
--------------------------

Per vedere quali simboli crea la nostra funzione possiamo utilizzare il seguente procedimento:
1) lanciare una nuova REPL
2) impostare i simboli attuali su una variabile:
   (setq prima (symbols))
3) Lanciare la funzione
4) impostare i nuovi simboli su una variabile:
   (setq dopo (symbols))
5) Effettuare la differenza tra le due variabili:
   (difference dopo prima)

Esempio:
1) lancio una nuova REPL
2) creo una lista con i simboli attuali:
  (setq prima (symbols))
3) Scrivo la funzione:
  (define (doppio x) (mul x x))
4) creo una lista con i nuovi simboli:
  (setq dopo (symbols))
5) calcolo la differenza tra le due liste di simboli:
  (difference dopo prima)
;-> (dopo doppio x)

La seguente funzione restituisce una lista con due sottoliste, la prima sottolista contiene i nomi delle funzioni definite dall'utente (lambda), mentra la seconda sottolista contiene tutti gli altri simboli definiti dall'utente.

Definite la seguente funzione in una nuova sessione di newLISP (una nuova REPL) e poi eseguitela:

(define (user-symbols)
  (local (func other)
    (setq func '())
    (setq other '())
    (dolist (el (symbols))
      (if (lambda? (eval el))  (push el func -1))
      (if (and (not (lambda? (eval el)))
               (not (primitive? (eval el)))
               (not (protected? el))
               (not (global? el)))
          (push el other -1))
    )
    (list func other)
  )
)

(user-symbols)
;-> ((module user-symbols) (el func other))

Versione modificata:

(define (user-symbols)
  (local (_func _other)
    (setq _func '())
    (setq _other '())
    (dolist (_el (symbols))
      (if (and (lambda? (eval _el))
               (not (= _el 'user-symbols)))
          (push _el _func -1))
      (if (and (not (lambda? (eval _el)))
               (not (primitive? (eval _el)))
               (not (protected? _el))
               (not (global? _el))
               (not (= _el '_func))
               (not (= _el '_other))
               (not (= _el '_el)))
          (push _el _other -1))
    )
    (list _func _other)
  )
)

(user-symbols)
;-> ((module) ()) ; from a fresh REPL of newLISP


-------------------------------------------------
Il programma è in esecuzione? (progress display)
-------------------------------------------------

Qualche volta abbiamo bisogno di sapere se un programma è in esecuzione (e a che punto si trova) oppure si è bloccato in qualche parte del nostro codice. Ci sono due metodi per questo:
il primo metodo stampa ciclicamente una serie di simboli sulla console per dimostrare che il programma sta girando (spinning rod animation):

(define (controllo)
    (setq i 1)
    (dotimes (x 100000)
      (case i
        (1 (print "wait... |\r"))
        (2 (print "wait... /\r"))
        (3 (print "wait... -\r"))
        (4 (print "wait... \\\r"))
        (true "errore")
      )
      (inc i)
      (if (> i 4) (setq i 1))
    )
    (println "Programma terminato")
)

Il programma stampa ciclicamente un carattere della serie "|", "/". "-", "\\".
Poichè ad ogni print stampiamo anche un "carriage return" (\r) stampiamo sempre sulla stessa linea a partire dalla colonna zero. Questo genera la semplice animazione che vedete quando eseguite la funzione.

(controllo)
;-> wait... (animazione dei caratteri)
;-> Programma terminato
;-> "Programma terminato"

(time (controllo) 5)
;-> 5515.739

Una funzione simile:

(define (controllo roll)
  (let ((i 0) (r '("|\r" "/\r" "-\r" "\\\r")))
    (dotimes (x 100000)
      (if roll
        (print "wait... " (r (% i 4)))
        (print "x = " x "\r")
      )
      (++ i)
    )
    (println "Programma terminato")))

(controllo)
;-> x = 1 (in sequenza)
;-> Programma terminato

(time (controllo) 5)
;-> 14320.088

(controllo true)
;-> wait... (animazione dei caratteri)
;-> Programma terminato

(time (controllo true) 5)
;-> 10249.843

Per migliorare l'output possiamo scrivere:

(define (resume) (print "\r\n> "))

(silent (controllo) (resume))
;-> Programma terminato

Possiamo diminuire il numero dei caratteri nell'animazione scegliendo due caratteri ":" e "-":

(define (controllo)
    (setq i 0)
    (dotimes (x 100000)
      (if (= 0 i) (print "wait... :\r")
                  (print "wait... -\r")
      )
      (inc i)
      (if (> i 1) (setq i 0))
    )
    (println "Programma terminato")
)

(silent (controllo) (resume))
;-> wait... (animazione dei caratteri)
;-> Programma terminato

Per finire il primo metodo utilizziamo un generatore per creare l'animazione:

(define (roll:roll)
  (inc roll:i)
  (print "wait... " (roll:r (% roll:i 4)))
)

(define (roll:init)
  (setq roll:r '("|\r" "/\r" "-\r" "\\\r"))
  (setq roll:i 0)
)

(roll:init)
;-> 0

(define (test n)
  (for (i 1 n) (roll))
  'end-of-program)

(test 100000)
;-> wait... (animazione dei caratteri)
;-> end-of-program

Il secondo metodo è più informativo, poichè visualizza il valore della iterazione corrente:

(define (controllo)
    (setq iter 10000000)
    (dotimes (x 100000000)
      ; ogni iter iterazioni stampiamo il valore
      (if (= 0 (mod x iter)) (print "Iter: " x "\r"))
    )
    (println "Programma terminato")
)

(silent (controllo) (resume))
;-> Iter: 0 ... ;-> Iter: 900000000
;-> Programma terminato

Da notare che tutti questi metodi rallentano l'esecuzione del programma.


-----------------------------
Ispezionare una cella newLISP
-----------------------------

Per conoscere il contenuto (tipo) di una cella lisp possiamo utilizzare la funzione "dump".

****************
>>>funzione DUMP
****************
sintassi: (dump [exp])

Mostra i contenuti binari di una nuova cella LISP. Senza argomenti, questa funzione restituisce un elenco di tutte le celle Lisp. Quando viene fornito exp, viene valutato e il contenuto della cella Lisp viene restituito in una lista.

(dump 'a)
;-> (9586996 5 9578692 9578692 9759280)

(dump 999)
;-> (9586996 130 9578692 9578692 999)

L'elenco contiene i seguenti indirizzi di memoria e informazioni:

offset  descrizione
0       indirizzo di memoria della cella Lisp
1       cella->tipo: maggiore/minore, vedi newLISP.h per i dettagli
2       cella->successivo: puntatore alla linked list
3       cella->aux:
          lunghezza della stringa + 1 o
          low (little endian) o high (big endian) word di numero intero a 64 bit o
          low word di double float IEEE 754
4       cella->contenuto:
          indirizzo della stringa/simbolo o
          high (little endian) o low (big endian) word di numero intero a 64 bit o
          high di double float IEEE 754

Questa funzione è utile per modificare i bit di tipo nelle celle o per hackerare altre parti dei nuovi interni di LISP.

La seguente funzione estrae il tipo di dato contenuto in una cella newLISP:

(define (type x) (& 15 (nth 1 (dump x))))

(type nil)
;-> 0            ;; nil
(type true)
;-> 1            ;; true
(type 123)
;-> 2            ;; integer
(type 1.23)
;-> 3            ;; float
(type "abcd")
;-> 4            ;; string
(type 'asymbol)
;-> 5            ;; symbol
(type MAIN)
;-> 6            ;; context
(type +)
;-> 7            ;; primitive
;; 8             ;; imports cdecl, dll
;; 9             ;; imports ffi
(type ''asym)
;-> 10           ;; quote
(type '(1 2 3))
;-> 11           ;; list expression
(type type)
;-> 12           ;; lambda
;; 13            ;; fexpr
;; 14            ;; array
;; 15            ;; dynamic symbol

Vedere il file "newLISP.h" nel programma sorgente per conoscere i bit superiori e il loro significato (e anche altre cose).

Un altro metodo simile:

(define types '("nil" "true" "int" "float" "string" "symbol" "context"
    "primitive" "import" "ffi" "quote" "expression" "lambda" "fexpr" "array"
    "dyn_symbol"))

(define (typeof v)
    (types (& 0xf ((dump v) 1))))


-----------------------------------
Informazioni sul sistema (sys-info)
-----------------------------------

Possiamo ottenere diverse informazioni sul sistema in uso utilizzando la funzione "sys-info".

********************
>>>funzione SYS-INFO
********************
sintassi: (sys-info [int-idx])

Chiamando sys-info senza int-idx viene restituito un elenco di informazioni sulle risorse. Dieci valori interi che hanno il seguente significato:

valore descrizione
  0     Numero di celle Lisp
  1     Numero massimo di celle Lisp (costante)
  2     Numero di simboli
  3     Livello di valutazione / ricorsione dell'ambiente
  4     Livello di stack dell'ambiente
  5     Numero massimo di chiamate allo stack (costante)
  6     Pid del processo genitore oppure 0
  7     Pid del processo newLISP
  8     Numero della versione come costante intera
  9     Costanti del sistema operativo:
        linux = 1, bsd = 2, osx = 3, solaris = 4, windows = 6, os/2 = 7, cygwin = 8, tru64 unix = 9, aix = 10, android = 11
        il bit 11 è impostato per le versioni ffilib (Extended Import/Callback API) (aggiungere 1024)
        il bit 10 è impostato per le versioni IPv6 (aggiungere 512)
        il bit  9 è impostato per le versioni a 64 bit (modificabili a runtime) (aggiungere 256)
        il bit  8 è impostato per le versioni UTF-8 (aggiungere 128)
        il bit  7 è aggiunto per le versioni di libreria (aggiungere 64)

I numeri da 0 a 9 indicano il valore dell'indice int-idx (opzionale) nella lista restituita.

Si consiglia di utilizzare gli indici da 0 a 5 (includendo) "Numero massimo di chiamate allo stack costante") e utilizzare gli offset negativi da -1 a -4 per accedere alle ultime quattro voci nella lista delle informazioni di sistema. Le future nuove voci verranno inserite dopo l'indice 5. In questo modo i programmi scritti precedentemente non dovranno essere modificati.

Quando si usa int-idx, verrà restituito un solo elemento della lista.

(sys-info) → (429 268435456 402 1 0 2048 0 19453 10406 1155)
(sys-info 3) → 1
(sys-info -2) → 10406 ;; versione 10.4.6

Il numero relativo al massimo di celle Lisp può essere modificato tramite l'opzione della riga di comando -m. Per ogni megabyte di memoria di celle Lisp, è possibile allocare 64k celle Lisp. La profondità massima dello stack di chiamata può essere modificata utilizzando l'opzione della riga di comando -s.

(bits (sys-info -1))
;-> "10110000110"
1 --> ffilib ON
0 --> IPv6 OFF
1 --> 64bit ON
1 --> UTF-8 ON
0 --> library OFF
0 --> (free)
0 --> (free)
0110 --> 6 = windows

Per rendere più leggibili le informazioni scriviamo la funzione "sysinfo":

(define (sysinfo)
  (local (info num num$ so)
    (setq info (sys-info))
    (println "Number of Lisp cells: " (info 0))
    (println "Maximum number of Lisp cells constant: " (info 1))
    (println "Number of symbols: " (info 2))
    (println "Evaluation/recursion level: " (info 3))
    (println "Environment stack level: " (info 4))
    (println "Maximum call stack constant: " (info 5))
    (println "Pid of the parent process or 0: " (info -4))
    (println "Pid of running newLISP process: " (info -3))
    (println "Version number as an integer constant: " (info -2))
    (setq num (sys-info -1))
    (setq num$ (bits num))
    (setq so (int (slice num$ (- (length num$) 4)) 0 2))
    (print "Operating System: ")
    (case so
        (1  (println "linux"))
        (2  (println "bsd"))
        (3  (println "osx"))
        (4  (println "solaris"))
        (5  (println "nil"))
        (6  (println "windows"))
        (7  (println "os/2"))
        (8  (println "cygwin"))
        (9  (println "tru64 unix"))
        (10 (println "aix"))
        (11 (println "android"))
        (true (println so))
    );case
    ; ffilib -> bit 11
    (print "ffilib: ")
    (if (zero? (& (>> num 10) 1)) (println "no") (println "yes"))
    ; IPV6 -> bit 10
    (print "IPV6: ")
    (if (zero? (& (>> num 9) 1)) (println "no") (println "yes"))
    ; 64 bit -> bit 9
    (print "64 bit: ")
    (if (zero? (& (>> num 8) 1)) (println "no") (println "yes"))
    ; utf8 -> bit 8
    (print "UTF-8: ")
    (if (zero? (& (>> num 7) 1)) (println "no") (println "yes"))
    ; library -> bit 7
    (print "library: ")
    (if (zero? (& (>> num 6) 1)) (println "no") (println "yes"))
    info
  )
)
(sys-info)
(sysinfo)
;-> Number of Lisp cells: 983
;-> Maximum number of Lisp cells constant: 576460752303423488
;-> Number of symbols: 425
;-> Evaluation/recursion level: 4
;-> Environment stack level: 1
;-> Maximum call stack constant: 2048
;-> Pid of the parent process or 0: 0
;-> Pid of running newLISP process: 6884
;-> Version number as an integer constant: 10705
;-> Operating System: windows
;-> ffilib: yes
;-> IPV6: no
;-> 64 bit: yes
;-> UTF-8: yes
;-> library: no
;-> (959 576460752303423488 425 2 0 2048 0 6884 10705 1414)


------------------------------------
Valutazione di elementi di una lista
------------------------------------

Supponiamo di aver creato la seguente lista:

(setq lst '( ((+ 6 2) (a) 2) ((- 2 5) (b) 5) ))
;-> (((+ 6 2) (a) 2) ((- 2 5) (b) 5))

La lista ha due elementi ((+ 6 2) (a) 2) e ((- 2 5) (b) 5).

Adesso vogliamo valutare il primo elemento di ogni sottolista: (+ 6 2) e (- 2 5).

Aggiorniamo questo elemento con la sua valutazione:

(dolist (el lst) (setf (first (lst $idx)) (eval (first el))))

Vediamo il risultato:

lst
;-> ((8 (a) 2) (-3 (b) 5))


---------------------------------------
Download tutti i file da una pagina web
---------------------------------------

La seguente funzione permette di scaricare tutti i file da una pagina web.

; get-all.lsp
; cameyo 2019
; scarica tutti i file da una pagina web
; get all downloadable files from a webpage

; get the page
(setq page (get-url "http://newlisp.digidep.net/"))
(setq page (get-url "http://landoflisp.com/source.html"))

; find files (*.lsp)
(setq filesA (find-all {href="(.*\.lsp)"} page $1))

; find files (*.jpg)
(setq filesB (find-all {href="(.*\.jpg)"} page $1))

(setq allfiles (union filesA filesB))

(dolist (file allfiles)
        (write-file file (get-url (string "http://newlisp.digidep.net/scripts/" file)))
        (println "->" file))

Esempio:

(change-dir "c:/temp")
(setq page (get-url "http://landoflisp.com/source.html"))
(setq allfiles (find-all {href="(.*\.lisp)"} page $1))
(dolist (file allfiles)
        (write-file file (get-url (string "http://landoflisp.com/source.html" file)))
        (println "-> " file))
;-> -> guess.lisp
;-> -> wizards_game.lisp
;-> -> graph-util.lisp
;-> -> wumpus.lisp
;-> -> orc-battle.lisp
;-> -> evolution.lisp
;-> -> robots.lisp
;-> -> webserver.lisp
;-> -> dice_of_doom_v1.lisp
;-> -> svg.lisp
;-> -> wizard_special_actions.
;-> -> lazy.lisp
;-> -> dice_of_doom_v2.lisp
;-> -> dice_of_doom_v3.lisp
;-> -> dice_of_doom_v4.lisp


-------------------------------------
Conversione numero da cifre a lettere
-------------------------------------

Vogliamo convertire un numero da cifre a lettere, ad esempio:

10421 -> diecimilaquattrocentoventuno

Questo problema è più difficile da risolvere per la lingua italiana che per quella inglese a causa delle cifre 1 ("uno") e 8 ("otto") che modifica la lettura del numero (es. ventuno e non ventiuno, trentotto e non trantaotto).

Come prima cosa definiamo alcune liste:

  ; la cifra 1
  (setq un "Un")
  ; le dieci cifre - codeA
  (setq cifre '("Zero" "Uno" "Due" "Tre" "Quattro" "Cinque" "Sei" "Sette"
    "Otto" "Nove"))
  ; i primi venti numeri - code
  (setq venti '("Zero" "Uno" "Due" "Tre" "Quattro" "Cinque" "Sei" "Sette"
    "Otto" "Nove" "Dieci" "Undici" "Dodici" "Tredici" "Quattordici"
    "Quindici" "Sedici" "Diciassette" "Diciotto" "Diciannove"))
  ; le decine - codeB
  (setq decine '("" "" "Venti" "Trenta" "Quaranta" "Cinquanta"
    "Sessanta" "Settanta" "Ottanta" "Novanta"))
  ; le decine senza vocali - codeB1
  (setq dcn    '("" "" "Vent" "Trent" "Quarant" "Cinquant"
    "Sessant" "Settant" "Ottant" "Novant"))
  ; il numero 100
  (setq cento "Cento")
  ; multipli con la cifra 1 - codeC
  (setq multiplo '("" "Mille" "Milione" "Miliardo" "Bilione" "Biliardo"
    "Trilione" "Triliardo" "Quadrilione" "Quadriliardo"))
  ; multipli con la cifra diversa da 1 - codeC1
  (setq multipli '("" "Mila" "Milioni" "Miliardi" "Bilioni" "Biliardi"
    "Trilioni" "Triliardi" "Quadrilioni" "Quadriliardi"))

Poichè la lettura di un numero procede per gruppi di tre (partendo da sinistra) scriviamo una funzione che converte in lettere un numero con 3 cifre. I numeri con una o due cifre devono essere riempiti con degli zeri: 000,001,002,...,999.
L'algoritmo controlla a quale cifra si riferisce (unita, decine o centinaia) e crea la stringa relativa. La creazione della stringa avviene scegliendo la lista corretta in base al valore della cifra e verificando se la cifra vale 1 o 8.

(define (triple num)
  (local (lst res)
    (setq res "")
    ; lista delle cifre
    (setq lst (map int (explode (string num))))
    (dolist (el lst)
      (cond ((= el 0) nil)
            (true (cond ((= $idx 2) ; cifra unita ?
                          (if (!= 1 (lst 1)) ; ultime 2 cifre > 19 ?
                              (setq res (append res (cifre el)))))
                        ((= $idx 1) ; cifra decine ?
                          (if (= el 1) ; ultime 2 cifre < 20 ?
                            ; prendo il numero da 11 a 19
                            (setq res (append res (venti (+ 9 el (lst 2)))))
                            ; oppure prendo le decine
                            (if (or (= 1 (lst 2)) (= 8 (lst 2))) ; numero finisce con 1 o con 8?
                              ; prendo le decine senza vocale finale
                              (setq res (append res (dcn el)))
                              ; oppure prendo le decine con vocale finale
                              (setq res (append res (decine el))))))
                        ((= $idx 0) ; cifra centinaia ?
                          (if (= el 1) ; cifra centinaia = 1 ?
                              ; prendo solo "cento"
                              (setq res (append res cento))
                              ; prendo il numero e "cento"
                              (setq res (append res (venti el) cento))))
                  )
            )
      )
    )
    res
  )
)

Proviamo la funzione:

(triple "010")
;-> Dieci
(triple "070")
;-> "Settanta"
(triple "999")
;-> "NoveCentoNovantaNove"
(triple "007")
;-> "Sette"
(triple "000")
;-> ""
(triple 100)
;-> "Cento"
(triple "001")
;-> "Uno"
(triple "016")
;-> "Sedici"
(triple "020")
;-> Venti
(triple "011")
;-> "Undici"
(triple "071")
;-> "SettantUno"
(triple "021")
;-> "Ventuno"
(triple "088")
;-> "OttantOtto"

Adesso definiamo una funzione che formatta un numero. La funzione prende un numero da formattare in stringa, un numero che rappresenta la lunghezza della stringa finale e un carattere con cui viene riempita la stringa se il numero ha una lunghezza inferiore alla lunghezza della stringa finale.

(define (pad num len ch)
  (local (out)
    (setq out (string num))
    (while (> len (length out))
      (setq out (string ch out)))
  out
  )
)

(pad 1256 8 "0")
;-> "00001256"

(pad 124623 3 "0")
;-> "124623"

(pad 1 3 "0")
;-> "001"

Ora possiamo stampare tutti i numeri da 1 (uno) a 100 (cento):

(for (i 1 100) (println i { - } (triple (pad i 3 "0"))))
;-> 1 - Uno
;-> 2 - Due
;-> 3 - Tre
;-> 4 - Quattro
;-> 5 - Cinque
;-> 6 - Sei
;-> 7 - Sette
;-> 8 - Otto
;-> 9 - Nove
;-> 10 - Dieci
;-> 11 - Undici
;-> ...
;-> 89 - OttantaNove
;-> 90 - Novanta
;-> 91 - NovantUno
;-> 92 - NovantaDue
;-> 93 - NovantaTre
;-> 94 - NovantaQuattro
;-> 95 - NovantaCinque
;-> 96 - NovantaSei
;-> 97 - NovantaSette
;-> 98 - NovantaOtto
;-> 99 - NovantaNove
;-> 100 - Cento

La funzione finale utilizza la funzione "triple" e tiene conto del numero (indice) della tripla a cui si riferisce per la creazione della stringa risultato.

(define (numero num)
  (local (lst tri val out)
    (setq out "")
    (if (= (string num) "0")
      (setq out "zero")
      (begin
        ; calcola il numero di triplette
        (if (zero? (% (length (string num)) 3))
            (setq tri (/ (length (string num)) 3))
            (setq tri (+ (/ (length (string num)) 3) 1))
        )
        ; formatta in stringa il numero (padding)
        ; e crea una lista con tutte le triplette
        (setq lst (explode (pad (string num) (* 3 tri) "0") 3))
        ; ciclo per la creazione della stringa finale
        (dolist (el lst)
          ; creazione del numero rappresentato dalla tripletta
          (setq val (triple el))
          ; controllo se tale numero vale "Uno"
          (if (= val "Uno")
            (cond ((= $idx (- (length lst) 1)) ; primo gruppo a destra ?
                  (setq out (append out val))) ; aggiungo solo "Uno"
                  ((= $idx (- (length lst) 2)) ; secondo gruppo a destra ?
                  (setq out (string out (multiplo (- tri 1))))) ;aggiungo solo "Mille"
                  ;altrimenti aggiungo "Un" e il codice corrispondente
                  (true (setq out (string out "Un" (multiplo (- tri 1)))))
            )
            (if (!= val "") ; se la tripletta vale "000" --> val = ""
              (setq out (string out val (multipli (- tri 1)))))
          )
          (-- tri)
          ;(println (triple el))
        )
        out
      )
    )
  )
)

(numero "2001001")
;-> "DueMilioniMilleUno"
(numero "1000000")
;-> "UnMilione"
(numero "12345670")
;-> "DodiciMilioniTreCentoQuarantaCinqueMilaSeiCentoSettanta"
(numero "2401001024")
;-> "DueMiliardiQuattroCentoUnoMilioniMilleVentiQuattro"
(numero "1111111111")
;-> "UnMiliardoCentoUndiciMilioniCentoUndiciMilaCentoUndici"
(numero "888881")
;-> "OttoCentoOttantOttoMilaOttoCentoOttantUno"

(for (i 0 100) (println i { - } (numero i)))
;-> 0 - zero
;-> 1 - Uno
;-> 2 - Due
;-> 3 - Tre
;-> 4 - Quattro
;-> 5 - Cinque
;-> 6 - Sei
;-> 7 - Sette
;-> 8 - Otto
;-> 9 - Nove
;-> 10 - Dieci
;-> 11 - Undici
;-> ...
;-> 88 - OttantOtto
;-> 89 - OttantaNove
;-> 90 - Novanta
;-> 91 - NovantUno
;-> 92 - NovantaDue
;-> 93 - NovantaTre
;-> 94 - NovantaQuattro
;-> 95 - NovantaCinque
;-> 96 - NovantaSei
;-> 97 - NovantaSette
;-> 98 - NovantOtto
;-> 99 - NovantaNove
;-> 100 - Cento


--------------------------------------
Punto a destra o sinistra di una linea
--------------------------------------

Data una linea e un punto, determinare se il punto si trova a destra o a sinistra della linea.
Utilizziamo il prodotto vettoriale (cross-product) tra due vettori.
Se il prodotto è maggiore di zero, allora il punto si trova a sinistra della linea.
Se il prodotto è minore di zero, allora il punto si trova a destra della linea.
Se il prodotto è uguale a zero, allora il punto si trova sulla linea.

(cross (point-a point-b point-c)
  (((b.X - a.X)*(c.Y - a.Y) - (b.Y - a.Y)*(c.X - a.X))))

dove:
a = primo punto della linea
b = secondo punto della linea
c = punto da verificare

Nel caso in cui la linea è orizzontale:
Se il prodotto è maggiore di zero, allora il punto si trova sopra la linea.
Se il prodotto è minore di zero, allora il punto si trova sotto la linea.
Se il prodotto è uguale a zero, allora il punto si trova sulla linea.

Esempio:

      |         .
      |         .PL2
      |         O
      |         .
      |         .
      |         .      P4
      |         .     X
      |   P3    .
      |     X   .
      |         .
      |         .
      |    P1   .PL1
      |   X     O
      |         .        P2
      |         .       X
      |         .
   -------------.--------------------
      |         .

(setq PL1 '(5 2))
(setq PL2 '(5 8))
(setq P1 '(2 3))
(setq P2 '(9 1))
(setq P3 '(3 6))
(setq P4 '(8 7))

(define (sinistra? PL1 PL2 P)
  (local (pl1.x pl1.y pl2.x pl2.y p.x p.y)
    (setq pl1.x (first PL1) pl1.y (last PL1))
    (setq pl2.x (first PL2) pl2.y (last PL2))
    (setq p.x (first P) p.y (last P))
    (> (sub (mul (sub pl2.x pl1.x) (sub p.y pl1.y))
            (mul (sub pl2.y pl1.y) (sub p.x pl1.x))) 0)
  )
)

(sinistra? PL1 PL2 P1)
;-> true
(sinistra? PL1 PL2 P2)
;-> nil
(sinistra? PL1 PL2 P3)
;-> true
(sinistra? PL1 PL2 P4)
;-> nil


----------------------------------------------
Creazione di un poligono da una lista di punti
----------------------------------------------

Data una lista di punti, costruire un poligono semplice (non autointersecante) con tutti i punti.

Ordiniamo i punti in base all'angolo creato con l'asse X quando si traccia una linea attraverso il punto e il punto più basso a destra (sinistra).
Se due o più punti formano lo stesso angolo con l'asse X (cioè sono allineati rispetto al punto di riferimento), questi punti devono essere ordinati in base alla distanza dal punto di riferimento.

Di seguito il codice che implementa questo algoritmo:

Funzione di confronto angoli usata dalla funzione "sort":

(define (angleCompare a b)
  (local (left)
    (setq left (isLeft p0 a b))
    (if (= left 0)
      (distCompare a b);
      (> left 0)
    )
  )
)

Funzione di confronto distanze usata dalla funzione "sort":

(define (distCompare a b)
  (local (distA distB)
    (setq distA (add (mul (sub (first p0) (first a)) (sub (first p0) (first a)))
                    (mul (sub (last p0)  (last a))  (sub (last p0)  (last a)))))
    (setq distB (add (mul (sub (first p0) (first b)) (sub (first p0) (first b)))
                    (mul (sub (last p0)  (last b))  (sub (last p0)  (last b)))))
    (> distA distB)
  )
)

Funzione che ritorna la posizione di un punto rispetto ad una retta:

(define (isLeft p0 a b)
  (sub (mul (sub (first a) (first p0)) (sub (last b) (last p0)))
       (mul (sub (first b) (first p0)) (sub (last a) (last p0))))
)

(define (crea-poligono lst)
  (local (p0 hull out)
    ; trova il punto più in basso (e più a sinistra)
    (setq hull (lst 0))
    (for (i 1 (- (length lst) 1))
      (if (<= (last (lst i)) (last hull))
          (if (= (last (lst i)) (last hull))
              (if (> (first (lst i)) (first hull))
                  (setq hull (lst i)))
              (setq hull (lst i))
          )
      )
    )
    (setq p0 hull)
    ;(println hull)
    (sort lst angleCompare)
  )
)

Vediamo alcuni esempi:

Esempio 1:

(setq P1 '(0 0))
(setq P2 '(90 10))
(setq P3 '(30 40))
(setq P4 '(80 50))
(setq P5 '(50 60))
(setq P6 '(10 100))
(setq P7 '(20 20))
(setq P8 '(30 10))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8))

(setq lista (crea-poligono points))
;-> ((90 10) (30 10) (80 50) (20 20) (50 60) (30 40) (10 100) (0 0))

Per verificare il risultato scriviamo una funzione che crea un file postscript (che viene poi convertito con ghostscript tramite un programma batch):

(define (disegna lista-punti file)
  (local (xc yc punti)
    (module "postscript.lsp")
    ; setup iniziale
    ; creazione sfondo nero
    (ps:goto 0 0)
    (ps:fill-color 0 0 0)
    (ps:line-color 0 0 0)
    (ps:rectangle 612 792 true)
    ; tipo giunzione (1 = round)
    (ps:line-join 1)
    ; spessore linea
    (ps:line-width 0.25)
    ;colore linea
    (ps:line-color 220 220 220)
    ;colore riempimento
    (ps:fill-color 255 20 20)
    ; coordinate centro della pagina
    (setq xc (/ 612 2))
    (setq yc (/ 792 2))
    ; punti da tracciare
    (setq punti lista-punti)
    ; Inizia a disegnare dal centro pagina partendo dal primo punto
    (ps:goto (+ xc (first (punti 0))) (+ yc (last (punti 0))))
    ; Sposto il primo punto alla fine (chiusura del poligono)
    (push (pop punti) punti -1)
    ; Disegna il poligono
    (dolist (el punti)
      ; disegna linea dalla posizione corrente al punto passato come parametro
      (ps:drawto (+ xc (first el)) (+ yc (last el)))
      ; disegna un punto alla posizione corrente
      (ps:circle 1 true)
    )
    ; salva il file postscript
    ;(ps:save "poly.ps")
    (ps:save (string file ".ps"))
    ; conversione del file .ps al file .pdf (ghostscript)
    ;(! (string "ps2pdf poly.ps poly.pdf")
    (! (string "ps2pdf " file ".ps " file ".pdf"))
  )
)

Creiamo i file "poly-1.ps" e "poly-1.pdf":

(disegna lista "poly-1")

Esempio 2:

(setq P1 '(20 20))
(setq P2 '(40 80))
(setq P3 '(30 50))
(setq P4 '(50 10))
(setq P5 '(70 40))
(setq P6 '(70 70))
(setq P7 '(80 20))
(setq P8 '(30 10))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8))

(setq lista (crea-poligono points))
;-> ((80 20) (70 40) (70 70) (40 80) (30 50) (20 20) (30 10) (50 10))

Creiamo i file "poly-2.ps" e "poly-2.pdf":

(disegna lista "poly-2")

Esempio 3:

(setq P1 '(80 90))
(setq P2 '(50 90))
(setq P3 '(70 70))
(setq P4 '(40 70))
(setq P5 '(60 50))
(setq P6 '(80 30))
(setq P7 '(40 40))
(setq P8 '(20 30))
(setq P9 '(60 20))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8 P9))

(setq lista (crea-poligono points))
;-> ((80 30) (80 90) (70 70) (60 50) (50 90) (40 70) (40 40) (20 30) (60 20))

Creiamo i file "poly-3.ps" e "poly-3.pdf":

(disegna lista "poly-3")

Esempio 4:

(setq P1 '(20 20))
(setq P2 '(40 50))
(setq P3 '(100 20))
(setq P4 '(60 30))
(setq P5 '(80 50))

(setq points (list P1 P2 P3 P4 P5))

(setq lista (crea-poligono points))
;-> ((80 50) (40 50) (60 30) (20 20) (100 20))

Creiamo i file "poly-4.ps" e "poly-4.pdf":

(disegna lista "poly-4")

Esempio 5:

(setq P1 '(20 20))
(setq P2 '(40 80))
(setq P3 '(30 50))
(setq P4 '(50 10))
(setq P5 '(70 40))
(setq P6 '(70 70))
(setq P7 '(80 20))
(setq P8 '(30 10))
(setq P9 '(120 50))
(setq P10 '(50 40))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8 P9 P10))

(setq lista (crea-poligono points))
;-> ((80 20) (120 50) (70 40) (70 70) (50 40) (40 80) (30 50) (20 20) (30 10) (50 10))

Creiamo i file "poly-5.ps" e "poly-5.pdf":

(disegna lista "poly-5")

Nota: questo algoritmo non trova il percorso minimo tra i punti.


-------------------------------------
Percorso minimo di una lista di punti
-------------------------------------

Data una lista di punti, costruire il poligono (percorso chiuso) che ha lunghezza minima.

Questo problema assomiglia a quello del commesso viaggiatore (Travelling Salesman Problem), ma in questo caso, potenzialmente, ogni punto è connesso con tutti gli altri (grafo completo non orientato).
L'algoritmo che adottiamo è abbastanza brutale: generiamo tutte le permutazioni dei punti e calcoliamo la somma totale della distanza tra i punti per ogni permutazione. La permutazione che ha la distanza minima è la soluzione.
Questo metodo limita fortemente il numero di punti che possiamo analizzare in tempi accettabili.

Funzione per calcolare le permutazioni:

(define (perm lst)
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
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
    out
  )
)

(length (perm '(0 1 2 3 4 5 6 7)))
;-> 40320

Supponiamo di avere i seguenti punti.

Esempio 1:

(setq P1 '(0 0))
(setq P2 '(90 10))
(setq P3 '(30 40))
(setq P4 '(80 50))
(setq P5 '(50 60))
(setq P6 '(10 100))
(setq P7 '(20 20))
(setq P8 '(30 10))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8))

Funzione per calcolare il quadrato della distanza tra due punti (questo è sufficiente per il confronto tra due distanze):

(define (quad-dist p q)
  (add
    (mul (sub (first q) (first p)) (sub (first q) (first p)))
    (mul (sub (last q) (last p)) (sub (last q) (last p)))))

(quad-dist P2 P1)
;-> 8200
(quad-dist P3 P2)
;-> 4500

Adesso definiamo la funzione finale:

(define (tsp lst)
  (local (permutazioni sol points dist dist-min)
    ; creazione permutazioni dei punti
    (setq permutazioni (perm lst))
    ; distanza minima iniziale
    (setq dist-min '99999999)
    (dolist (p permutazioni)
      (setq dist 0)
      ; calcola somma della distanza tra tutti i punti di una permutazione
      (for (i 1 (- (length p) 1))
        (setq dist (add dist (quad-dist (p i) (p (- i 1)))))
      )
      ; aggiunge distanza tra ultimo e primo punto (percorso chiuso)
      (setq dist (add dist (quad-dist (p 0) (p (- (length p) 1)))))
      ;controllo distanza minima
      (if (< dist dist-min)
          (begin
            (setq dist-min dist)
            (setq sol p))
            ;(println p { } dist-min)
      )
    )
    sol
  )
)

Proviamo la funzione:

(setq lista (tsp points))
;-> ((0 0) (20 20) (30 40) (10 100) (50 60) (80 50) (90 10) (30 10))

Per verificare il risultato scriviamo una funzione che crea un file postscript (che viene poi convertito con ghostscript in pdf tramite un programma batch):

(define (disegna lista-punti file)
  (local (xc yc punti)
    (module "postscript.lsp")
    ; setup iniziale
    ; creazione sfondo nero
    (ps:goto 0 0)
    (ps:fill-color 0 0 0)
    (ps:line-color 0 0 0)
    (ps:rectangle 612 792 true)
    ; tipo giunzione (1 = round)
    (ps:line-join 1)
    ; spessore linea
    (ps:line-width 0.25)
    ;colore linea
    (ps:line-color 220 220 220)
    ;colore riempimento
    (ps:fill-color 255 20 20)
    ; coordinate centro della pagina
    (setq xc (/ 612 2))
    (setq yc (/ 792 2))
    ; punti da tracciare
    (setq punti lista-punti)
    ; Inizia a disegnare dal centro pagina partendo dal primo punto
    (ps:goto (+ xc (first (punti 0))) (+ yc (last (punti 0))))
    ; Sposto il primo punto alla fine (chiusura del poligono)
    (push (pop punti) punti -1)
    ; Disegna il poligono
    (dolist (el punti)
      ; disegna linea dalla posizione corrente al punto passato come parametro
      (ps:drawto (+ xc (first el)) (+ yc (last el)))
      ; disegna un punto alla posizione corrente
      (ps:circle 1 true)
    )
    ; salva il file postscript
    ;(ps:save "poly.ps")
    (ps:save (string file ".ps"))
    ; conversione del file .ps al file .pdf (ghostscript)
    ; ps2pdf.bat
    ;(! (string "ps2pdf poly.ps poly.pdf")
    (! (string "ps2pdf " file ".ps " file ".pdf"))
  )
)

Creiamo i file "tsp-1.ps" e "tsp-1.pdf":

(disegna lista "tsp-1")

Esempio 2:

(setq P1 '(20 20))
(setq P2 '(40 80))
(setq P3 '(30 50))
(setq P4 '(50 10))
(setq P5 '(70 40))
(setq P6 '(70 70))
(setq P7 '(80 20))
(setq P8 '(30 10))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8))

(setq lista (tsp points))
;-> ((20 20) (30 50) (40 80) (70 70) (70 40) (80 20) (50 10) (30 10))

Creiamo i file "tsp-2.ps" e "tsp-2.pdf":

(disegna lista "tsp-2")

Esempio 3:

(setq P1 '(80 90))
(setq P2 '(50 90))
(setq P3 '(70 70))
(setq P4 '(40 70))
(setq P5 '(60 50))
(setq P6 '(80 30))
(setq P7 '(40 40))
(setq P8 '(20 30))
(setq P9 '(60 20))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8 P9))

(setq lista (tsp points))
;-> ((80 30) (60 50) (70 70) (80 90) (50 90) (40 70) (40 40) (20 30) (60 20))

Creiamo i file "tsp-3.ps" e "tsp-3.pdf":

(disegna lista "tsp-3")

Esempio 4:

(setq P1 '(20 20))
(setq P2 '(40 50))
(setq P3 '(100 20))
(setq P4 '(60 30))
(setq P5 '(80 50))

(setq points (list P1 P2 P3 P4 P5))

(setq lista (tsp points))
;-> ((40 50) (20 20) (60 30) (100 20) (80 50))

Creiamo i file "tsp-4.ps" e "tsp-4.pdf":

(disegna lista "tsp-4")

Esempio 5:

(setq P1 '(20 20))
(setq P2 '(40 80))
(setq P3 '(30 50))
(setq P4 '(50 10))
(setq P5 '(70 40))
(setq P6 '(70 70))
(setq P7 '(80 20))
(setq P8 '(30 10))
(setq P9 '(120 50))
(setq P10 '(50 40))

(setq points (list P1 P2 P3 P4 P5 P6 P7 P8 P9 P10))

(time (setq lista (tsp points)))
;-> 37307.071

lista
;-> ((50 10) (30 10) (20 20) (30 50) (40 80) (70 70) (120 50) (80 20) (70 40) (50 40))

Creiamo i file "tsp-5.ps" e "tsp-5.pdf":

(disegna lista "tsp-5")

Nota: Con questo algoritmo possiamo calcolare al massimo dieci punti (altrimenti il calcolo delle permutazioni richiederebbe troppo tempo).


---------------------------
Utilizzo del protocollo ftp
---------------------------

newLISP mette a disposizione un modulo per il download e l'upload di file tramite il protocollo ftp.

Esempio:

; ftp: ftp://ftpzone.data
; remote folder: temp
; Utente    Password    Diritti
; ------    --------    -------
; user1     pwd1        lettura
; user2     pwd2        lettura/scrittura

; load ftp module
(module "ftp.lsp")

; primitive functions
;; (FTP:get <str-user-id> <str-password> <str-host> <str-dir> <str-file-name>)
;; (FTP:put <str-user-id> <str-password> <str-host> <str-dir> <str-file-name>)

(set 'FTP:debug-mode true)

; Upload file:

(FTP:put "user2" "pwd2" "ftpzone.data" "temp" "filename.ext")
;-> true

; Download file:

(FTP:get "user2" "pwd2" "ftpzone.data" "temp" "filename.ext")
;-> true


--------------------------------------
Normalizzazione di una lista di numeri
--------------------------------------

Supponiamo di avere una lista di numeri che devono essere trasformati in un altro sistema di coordinate. Ad esempio una lista di coordinate geografiche che devono essere convertite per poter essere visualizzate sullo schermo o stampate con un plotter (cioè nel sistema di riferimento che usa lo schermo o il plotter).
In questo caso le coordinate geografiche rappresentano un punto di coordinate (x, y) ovvero (long, lat). Quindi useremo una trasformazione lineare in due dimensioni (2D).
Nota: la trasformazione lineare può essere applicata solo se l'estensione della zona geografica è limitata, cioè se possiamo approssimare la zona geografica con un piano cartesiano (in altre parole se possiamo trascurare la curvatura terrestre).

Questa è la lista delle coordinate geografiche:

(setq geo '((12.41142785 43.66627426)
            (12.65043641 43.55027395)
            (12.67496872 43.62171555)
            (12.78785627 43.95023854)
            (12.83323383 43.70941544)
            (12.90976429 43.90989685)
            (12.93863011 43.49932483)))

Poichè le coordinate hanno 8 cifre significative, possiamo moltiplicarle per 1e8 (in modo da avere numeri interi).

(setq geo (map (fn (x) (list (int (mul (first x) 1e8)) (int (mul (last x) 1e8)))) geo))
;-> ((1241142785 4366627426)
;->  (1265043641 4355027395)
;->  (1267496872 4362171555)
;->  (1278785627 4395023854)
;->  (1283323383 4370941544)
;->  (1290976429 4390989685)
;->  (1293863011 4349932483))

(integer? (first (first geo)))
;-> true

(setq long (first (first geo)))
;-> 1241142785
(setq lat (last (first geo)))
;-> 4366627426

Le coordinate hanno i seguenti limiti:

 1200000000 <= long <= 1300000000  --> (1300000000 - 1200000000) = 100000000
 4200000000 <= lat <= 4300000000   --> (4300000000 - 4200000000) = 100000000

Poichè i limiti definiscono un quadrato (100000000 e 100000000), per mantenere i rapporti di proporzione dobbiamo convertire queste coordinate in un piano cartesiano quadrato (10x10 o 200x200 o 150x150 ecc.)

Supponiamo che i limiti delle coordinate piane siano (0,0) e (100,100).
Possiamo scrivere:

(setq long-min 1200000000)
(setq long-max 1300000000)
(setq lat-min 4200000000)
(setq lat-max 4300000000)
(setq x-min 0)
(setq x-max 100)
(setq y-min 0)
(setq y-max 100)

Calcoliamo il fattore di scala nelle due dimensioni x e y:

(setq scala-x (div (sub x-max x-min) (sub long-max long-min)))
;-> 1e-006
(setq scala-y (div (sub y-max y-min) (sub lat-max lat-min)))
;-> 1e-006

Adesso possiamo scrivere le formule di trasformazione da una coordinata geografica (geo-long, geo-lat) ad una coordinata piana (x, y):

x = (geo-long - long-min) * scala-x
y = (geo-lat  -  lat-min) * scala-y

Esempio:

Coordinata geografica da convertire:

(setq geo-long 1241142785)
(setq geo-lat 4366627426)

Formula di trasformazione:

(setq x (mul (sub geo-long long-min) scala-x))
;-> 41.142785
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 166.627426

Controlliamo la correttezza della trasformazione:

Punto di mezzo
(setq geo-long 1250000000)
(setq geo-lat 4250000000)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 50
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 50

Punto iniziale
(setq geo-long 1200000000)
(setq geo-lat 4200000000)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 0
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 0

Punto finale
(setq geo-long 1300000000)
(setq geo-lat 4300000000)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 100
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 100

Vediamo ora il calcolo senza premoltiplicare le coordinate per 1e8:

(setq geo '((12.41142785 43.66627426)
            (12.65043641 43.55027395)
            (12.67496872 43.62171555)
            (12.78785627 43.95023854)
            (12.83323383 43.70941544)
            (12.90976429 43.90989685)
            (12.93863011 43.49932483)))
(setq long-min 12)
(setq long-max 13)
(setq lat-min 42)
(setq lat-max 43)
(setq x-min 0)
(setq x-max 100)
(setq y-min 0)
(setq y-max 100)
(setq scala-x (div (sub x-max x-min) (sub long-max long-min)))
(setq scala-y (div (sub y-max y-min) (sub lat-max lat-min)))
(setq x (mul (sub geo-long long-min) scala-x))
(setq y (mul (sub geo-lat lat-min) scala-y))

Punto iniziale
(setq geo-long 12)
(setq geo-lat 42)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 0
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 0

Punto di mezzo
(setq geo-long 12.5)
(setq geo-lat 42.5)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 50
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 50

Punto finale
(setq geo-long 13)
(setq geo-lat 43)
(setq x (mul (sub geo-long long-min) scala-x))
;-> 100
(setq y (mul (sub geo-lat lat-min) scala-y))
;-> 100

Abbiamo ottenuto gli stessi risultati.

La funzione che effettua la trasformazione ha i seguenti parametri:

1. lista delle coordinate (es. geo)
2. longitudine coordinata geografica minima  (es. 1200000000)
3. longitudine coordinata geografica massima (es. 1300000000)
4. latitudine  coordinata geografica minima  (es. 4200000000)
5. latitudine  coordinata geografica massima (es. 4300000000)
6. X minima coordinate piane
7. X massima coordinate piane
8. Y minima coordinate piane
9. Y massima coordinate piane

(define (trasf-coord punti long-min long-max lat-min lat-max x-min x-max y-min y-max)
  (local (x y scale-x scale-y out)
    (setq scala-x (div (sub x-max x-min) (sub long-max long-min)))
    (setq scala-y (div (sub y-max y-min) (sub lat-max lat-min)))
    (dolist (geo punti)
      (setq x (round (mul (sub (first geo) long-min) scala-x)))
      (setq y (round (mul (sub (last geo) lat-min) scala-y)))
      (push (list x y) out -1)
    )
  )
)

(setq geo '((12.41142785 43.66627426)
            (12.65043641 43.55027395)
            (12.67496872 43.62171555)
            (12.78785627 43.95023854)
            (12.83323383 43.70941544)
            (12.90976429 43.90989685)
            (12.93863011 43.49932483)))

(trasf-coord geo 12 13 42 43 0 100 0 100)
;-> ((41 167) (65 155) (67 162) (79 195) (83 171) (91 191) (94 150))


----------------------------
Trasformazione omografica 2D
----------------------------

Una omografia è una relazione tra punti di due spazi tali per cui ogni punto di uno spazio corrisponde ad uno ed un solo punto del secondo spazio. Si basa su concetti geometrici e matematici abbastanza complessi, noti come "coordinate omogenee" e "piani proiettivi", la cui spiegazione non rientra nell'ambito di questo documento.

Giusto per dare un'idea semplificata, il familiare "piano cartesiano" è composto da un insieme di punti che hanno una correlazione uno-a-uno con coppie di numeri reali, ovvero X-Y sui due assi. Il "piano proiettivo" invece è un superset di quel piano reale dove per ogni punto consideriamo anche tutte le possibili (infinite) rette verso lo spazio.

In questo scenario ogni punto 2D può essere proiettato su qualsiasi altro piano nello spazio.

Sulla base di questi concetti viene definita "omografia tra 2 piani" la trasformazione dei punti di un piano ad un altro piano.

La trasformazione omografica si basa sulle seguenti formule.

Formule di trasformazione omografica

     a*x + b*y + c              d*x + e*y + f
X = ---------------        Y = ---------------
     g*x + h*y + 1              g*x + h*y + 1

Dove X-Y sono le coordinate da calcolare nel secondo sistema di riferimento, date le coordinate x-y nel primo sistema di riferimento in funzione degli 8 parametri di trasformazione a, b, c, d, e, f, g, h.

a = fattore di scala fisso in direzione X con scala Y invariata.
b = fattore di scala in direzione X proporzionale alla distanza Y dall'origine.
c = traslazione dell'origine in direzione X.
d = fattore di scala in direzione Y proporzionale alla distanza X dall'origine.
e = fattore di scala fisso in direzione Y con scala X invariata.
f = traslazione dell'origine in direzione Y.
g = fattore di scala proporzionale X e Y in funzione di X.
h = fattore di scala proporzionale X e Y in funzione di Y.

Quindi, avendo queste 8 incognite, sono richiesti almeno 4 punti noti in entrambi i sistemi. In altre parole, dati 4 punti in un piano, esiste sempre una relazione che li trasforma nei corrispondenti 4 punti in un altro piano.

La trasformazione omografica viene utilizzata per la georeferenziazione di mappe oppure per correggere un'immagine prospettica (es. per generare una vista "in pianta" di un edificio da una foto "prospettica").

Le formule precedenti possono essere trasformate (tramite manipolazione algebrica) nella matrice di trasformazione omografica che ci consente di calcolare gli 8 parametri di trasformazione risolvendo il sistema lineare A*z = B.

Dati i quattro punti di partenza e i quattro punti di destinazione possiamo scrivere 8 equazioni:

        a*x(i) + b*y(i) + c                 d*x(i) + e*y(i) + f
X(i) = ---------------------        Y(i) = ---------------------
        g*x(i) + h*y(i) + 1                 g*x(i) + h*y(i) + 1

per 1 <= i <= 4

Queste 8 equazioni possono essere trasformate nel sistema lineare:

x1*a + y1*b + c - x1*X1*g - y1*X1*h = X1
x2*a + y2*b + c - x2*X2*g - y2*X2*h = X2
x3*a + y3*b + c - x3*X3*g - y3*X3*h = X3
x4*a + y4*b + c - x4*X4*g - y4*X4*h = X4
x1*d + y1*e + f - x1*Y1*g - y1*Y1*h = Y1
x2*d + y2*e + f - x2*Y2*g - y2*Y2*h = Y2
x3*d + y3*e + f - x3*Y3*g - y3*Y3*h = Y3
x4*d + y4*e + f - x4*Y4*g - y4*Y4*h = Y4

Che ha la seguente matrice di rappresentazione A*z = B:

| x1 y1  1  0  0  0 -x1*X1 -y1*X1 |   | a |   | X1 |
| x2 y2  1  0  0  0 -x2*X2 -y2*X2 |   | b |   | X2 |
| x3 y3  1  0  0  0 -x3*X3 -y3*X3 |   | c |   | X3 |
| x4 y4  1  0  0  0 -x4*X4 -y4*X4 | * | d | = | X4 |
|  0  0  0 x1 y1  1 -x1*Y1 -y1*Y1 |   | e |   | Y1 |
|  0  0  0 x2 y2  1 -x2*Y2 -y2*Y2 |   | f |   | Y2 |
|  0  0  0 x3 y3  1 -x3*Y3 -y3*Y3 |   | g |   | Y3 |
|  0  0  0 x4 y4  1 -x4*Y4 -y4*Y4 |   | h |   | Y4 |

matrice A:

  A[0][0] = x1  A[0][1] = y1  A[0][2] = 1  A[0][3] = 0   A[0][4] = 0   A[0][5] = 0  A[0][6] = -(X1*x1)  A[0][7] = -(X1*y1)
  A[1][0] = x2  A[1][1] = y2  A[1][2] = 1  A[1][3] = 0   A[1][4] = 0   A[1][5] = 0  A[1][6] = -(X2*x2)  A[1][7] = -(X2*y2)
  A[2][0] = x3  A[2][1] = y3  A[2][2] = 1  A[2][3] = 0   A[2][4] = 0   A[2][5] = 0  A[2][6] = -(X3*x3)  A[2][7] = -(X3*y3)
  A[3][0] = x4  A[3][1] = y4  A[3][2] = 1  A[3][3] = 0   A[3][4] = 0   A[3][5] = 0  A[3][6] = -(X4*x4)  A[3][7] = -(X4*y4)
  A[4][0] = 0   A[4][1] = 0   A[4][2] = 0  A[4][3] = x1  A[4][4] = y1  A[4][5] = 1  A[4][6] = -(Y1*x1)  A[4][7] = -(Y1*y1)
  A[5][0] = 0   A[5][1] = 0   A[5][2] = 0  A[5][3] = x2  A[5][4] = y2  A[5][5] = 1  A[5][6] = -(Y2*x2)  A[5][7] = -(Y2*y2)
  A[6][0] = 0   A[6][1] = 0   A[6][2] = 0  A[6][3] = x3  A[6][4] = y3  A[6][5] = 1  A[6][6] = -(Y3*x3)  A[6][7] = -(Y3*y3)
  A[7][0] = 0   A[7][1] = 0   A[7][2] = 0  A[7][3] = x4  A[7][4] = y4  A[7][5] = 1  A[7][6] = -(Y4*x4)  A[7][7] = -(Y4*y4)

matrice B (termini noti):

    B[0][0] = X1
    B[1][0] = X2
    B[2][0] = X3
    B[3][0] = X4
    B[4][0] = Y1
    B[5][0] = Y2
    B[6][0] = Y3
    B[7][0] = Y4

vettore incognite z:

    z[0] = a
    z[1] = b
    z[2] = c
    z[3] = d
    z[4] = e
    z[5] = f
    z[6] = g
    z[7] = h

Una volta calcolati questi 8 parametri (a, b, c, d, e, f, g, h) possiamo utilizzare le formule di trasformazione omografica per convertire qualsiasi punto dal primo sistema di riferimento al secondo.

Nota: I quattro punti iniziali devono essere non allineati a tre a tre (cioè non ci devono essere tre punti allineati).

Esempio:

       |
    13 |
    12 |                       #3
    11 |
    10 |
     9 |
     8 |                 #4
     7 |
     6 | o4      o3
     5 |
     4 |                         #2
     3 |
     2 |                   #1
     1 | o1     o2
   ---------------------------------------
       | 1 2 3 4 5 6 7 8 9 101112131415

I punti sono i seguenti:

Iniziale  --> Finale
o1 (1 1)  --> #1 (10 2)
o2 (5 1)  --> #2 (13 4)
o3 (5 5)  --> #3 (12 12)
o4 (1 5)  --> #4 (9 8)

(setq x1 1 y1 1)
(setq x2 5 y2 1)
(setq x3 5 y3 5)
(setq x4 1 y4 5)

(setq X1 10  Y1 2)
(setq X2 13 Y2 4)
(setq X3 12 Y3 12)
(setq X4 9  Y4 8)

Utilizziamo la seguente funzione per risolvere il sistema lineare:

(define (solve-linsys matrice noti)
  (local (dim detm det-i sol copia)
    (setq dim (length matrice))
    (setq sol '())
    (setq copia matrice)
    (setq detm (det copia))
    ; la soluzione è indeterminata se il determinante vale zero.
    (if (= detm 0) (setq sol nil)
    ;(println detm)
      (for (i 0 (- dim 1))
        (for (j 0 (- dim 1))
          (setf (copia j i) (noti j))
        )
        ; 0.0 -> "det" restituisce 0 (invece di nil),
        ; quando la matrice è singolare
        (setq det-i (det copia 0.0))
        (push (div det-i detm) sol -1)
        (setq copia matrice)
      );endfor
    );endif
    sol
  );local
)

(solve-linsys '((2 1 1) (4 -1 1) (-1 1 2)) '(1 -5 5))
 -> (-1 2 1)

Calcoliamo i parametri:

(setq r0 (list x1 y1  1  0  0  0 (- (mul x1 X1)) (- (mul y1 X1))))
(setq r1 (list x2 y2  1  0  0  0 (- (mul x2 X2)) (- (mul y2 X2))))
(setq r2 (list x3 y3  1  0  0  0 (- (mul x3 X3)) (- (mul y3 X3))))
(setq r3 (list x4 y4  1  0  0  0 (- (mul x4 X4)) (- (mul y4 X4))))
(setq r4 (list  0  0  0 x1 y1  1 (- (mul x1 Y1)) (- (mul y1 Y1))))
(setq r5 (list  0  0  0 x2 y2  1 (- (mul x2 Y2)) (- (mul y2 Y2))))
(setq r6 (list  0  0  0 x3 y3  1 (- (mul x3 Y3)) (- (mul y3 Y3))))
(setq r7 (list  0  0  0 x4 y4  1 (- (mul x4 Y4)) (- (mul y4 Y4))))
;-> (1 1 1 0 0 0 -10 -10)
;-> (5 1 1 0 0 0 -65 -13)
;-> (5 5 1 0 0 0 -60 -60)
;-> (1 5 1 0 0 0 -9 -45)
;-> (0 0 0 1 1 1 -2 -2)
;-> (0 0 0 5 1 1 -20 -4)
;-> (0 0 0 5 5 1 -60 -60)
;-> (0 0 0 1 5 1 -8 -40)

(setq matrix (list r0 r1 r2 r3 r4 r5 r6 r7))
;-> ((1 1 1 0 0 0 -10 -10)
;->  (5 1 1 0 0 0 -65 -13)
;->  (5 5 1 0 0 0 -60 -60)
;->  (1 5 1 0 0 0 -9 -45)
;->  (0 0 0 1 1 1 -2 -2)
;->  (0 0 0 5 1 1 -20 -4)
;->  (0 0 0 5 5 1 -60 -60)
;->  (0 0 0 1 5 1 -8 -40))

(setq noti (list X1 X2 X3 X4 Y1 Y2 Y3 Y4))
;-> (10 13 12 9 2 4 12 8)

(setq sol (solve-linsys matrix noti))
;-> (0.05000000000000014 -0.3833333333333334 9.666666666666666 0.2666666666666667 1.266666666666667
;->  0.3333333333333333 -0.04999999999999998 -0.01666666666666667)

(setq a (sol 0))
(setq b (sol 1))
(setq c (sol 2))
(setq d (sol 3))
(setq e (sol 4))
(setq f (sol 5))
(setq g (sol 6))
(setq h (sol 7))

Adesso possiamo trasformare qualunque punto dal sistema di riferimento iniziale al sistema di riferimento finale utilizzando le fornule di trasformazione omografica:

     a*x + b*y + c              d*x + e*y + f
X = ---------------        Y = ---------------
     g*x + h*y + 1              g*x + h*y + 1

(define (toX x y)
  (round (div (add (mul a x) (mul b y) c) (add (mul g x) (mul h y) 1)) -1))

(define (toY x y)
  (round (div (add (mul d x) (mul e y) f) (add (mul g x) (mul h y) 1)) -1))

Verifichiamo la trasformazione dei quattro punti iniziali:

(1 1)  -->  (10 2)
(5 1)  -->  (13 4)
(5 5)  -->  (12 12)
(1 5)  -->  (9 8)

(list (toX 1 1) (toY 1 1))
;-> (10 2)

(list (toX 5 1) (toY 5 1))
;-> (13 4)

(list (toX 5 5) (toY 5 5))
;-> (12 12)

(list (toX 1 5) (toY 1 5))
;-> (9 8)

Proviamo con altri punti:

(list (toX 3 3) (toY 3 3))
;-> (10.8 6.2)

(list (toX 5 3) (toY 5 3))
;-> (12.5 7.8)

Con questo metodo siamo in grado di prendere un file di coordinate geografiche (es. in formato geojson) e visualizzarlo sul monitor oppure creare un file postscript.


------------------------------------
Numeri primi successivi e precedenti
------------------------------------

Dato un numero intero n vogliamo determinare il primo numero primo successivo a n e il primo numero primo precedente a n.

Prima scriviamo la funzione che verifica se un numero è primo:

(define (primo? n)
  (if (< n 2) nil
      (= 1 (length (factor n)))))

Poi scriviamo due funzioni separate "primo+" e "primo-".

(define (primo+ num)
  (local (found val)
    (setq found nil)
    (setq val (+ num 1))
    (until found
      (if (primo? val)
          (setq found true)
          (++ val)
      )
    )
    val
  )
)

(primo+ 50)
;-> 53

(define (primo- num)
  (local (found val)
    (setq found nil)
    (setq val (- num 1))
    (until found
      (if (primo? val)
          (setq found true)
          (-- val)
      )
    )
    val
  )
)

(primo- 50)
;-> 47

(primo+ 2)
;-> 3


----------------------------
Giorno Giuliano (Julian day)
----------------------------

Il giorno giuliano (Julian Day, JD) è il numero di giorni passati dal mezzogiorno del lunedì 1 gennaio 4713 a.C. (-4712 1 1), che viene considerato il giorno 0 (zero) del calendario giuliano.
Il sistema dei giorni giuliani fornisce un singolo sistema di datazione che permette di lavorare con differenti calendari (in pratica è un metodo di normalizzazione delle date).

La formula per il calcolo del giorno giuliano è la seguente:

  JDN = (1461 × (Y + 4800 + (M − 14)/12))/4 + (367 × (M − 2 − 12 × ((M − 14)/12)))/12 − (3 × ((Y + 4900 + (M - 14)/12)/100))/4 + D − 32075

dove Y = Year  (anno)
     M = Month (mese)
     D = Day   (giorno)

Nota: le divisioni sono tutte intere, i resti vengono scartati.

Preferisco usare le formule (equivalenti) definite da Claus Tondering in "Calendar FAQ" e disponibili al seguente indirizzo web:

 https://stason.org/TULARC/society/calendars/index.html

In cui si trovano molte informazioni interessanti sulle date e sui vari calendari creati dall'uomo.

Vediamo l'algoritmo per il calcolo del giorno giuliano.

Calcolare le seguenti variabili ausiliarie:

  a = (14-month)/12
  y = year + 4800 - a
  m = month + 12*a - 3

Per una data nel calendario Gregoriano:

  JD = day + (153*m + 2)/5 + y*365 + y/4 - y/100 + y/400 - 32045

Per una data nel calendario Giuliano:

  JD = day + (153*m + 2)/5 + y*365 + y/4 - 32083

Il calendario Gregoriano viene utilizzato per le date che vanno dal 15 ottobre 1582 d.C. in avanti e il calendario Giuliano viene utilizzato per le date precedenti al 4 ottobre 1582.

Nota: Il calendario Giuliano non ha nulla in comune con il giorno giuliano.
Il calendario Giuliano fu introdotto da Giulio Cesare nel 45 AC ed era di uso comune fino al 1500, quando i paesi iniziarono ad utilizzare il calendario Gregoriano.

Scriviamo la funzione per il calcolo del numero del giorno giuliano partendo da una data del calendario Gregoriano:

(define (julian-g year month day)
  (local (a y m)
    (setq a (/ (- 14 month) 12))
    (setq y (+ year 4800 (- a)))
    (setq m (+ month (* 12 a) (- 3)))
    (+ day (/ (+ (* 153 m) 2) 5) (* y 365) (/ y 4) (- (/ y 100)) (/ y 400) (- 32045))
  )
)

(julian-g 2019 11 11)
;-> 2458799

(julian-g 2019 11 12)
;-> 2458800

Nota: per gli anni Avanti Cristo (Before Christ) occorre prima convertire l'anno A.C. in un anno negativo (es. 10 A.C. = -9).

Le "Idi di Marzo", il giorno dell'assassinio di Giulio Cesare avvenuto il 15 marzo del 44 A.C.

(julian-g -43 3 15)
;-> 1705428

Scriviamo la funzione per il calcolo del numero del giorno giuliano partendo da una data del calendario Giuliano:

(define (julian-j year month day)
  (local (a y m)
    (setq a (/ (- 14 month) 12))
    (setq y (+ year 4800 (- a)))
    (setq m (+ month (* 12 a) (- 3)))
    (+ day (/ (+ (* 153 m) 2) 5) (* y 365) (/ y 4) (- 32083))
  )
)

(julian-j 2019 11 11)
;-> 2458812

(julian-j 2019 11 12)
;-> 2458813

Verifichiamo il primo giorno del periodo giuliano:

(julian-j -4712 01 01)
;-> 0

Per convertire un giorno giuliano in una data del calendario Gregoriano o Giuliano utilizziamo il seguente algoritmo:

Per il calendario Gregoriano:

  a = JD + 32044
  b = (4*a + 3)/146097
  c = a - (b*146097)/4

Per il calendario Giuliano:

  a = 0
  b = 0
  c = JD + 32082

Poi, per entrambi i calendari:

  d = (4*c + 3)/1461
  e = c - (1461*d)/4
  m = (5*e + 2)/153

Infine calcoliamo la data:

  giorno = e - (153*m + 2)/5 + 1
  mese   = m + 3 - 12*(m/10)
  anno   = b*100 + d - 4800 + m/10

Scriviamo la funzione che converte da giorno giuliano a data Gregoriana (anno mese giorno):

(define (date-g JD)
  (local (a b c d e m)
    (setq a (+ JD 32044))
    (setq b (/ (+ (* 4 a) 3) 146097))
    (setq c (- a (/ (* b 146097) 4)))
    (setq d (/ (+ (* 4 c) 3) 1461))
    (setq e (- c (/ (* 1461 d) 4)))
    (setq m (/ (+ (* 5 e) 2) 153))
    (list
      (+ (* b 100) d (- 4800) (/ m 10))
      (+ m 3 (- (* 12 (/ m 10))))
      (+ e (- (/ (+ (* 153 m) 2) 5)) 1)
    )
  )
)

(julian-g 2019 11 11)
;-> 2458799
(date-g 2458799)
;-> (2019 11 11)

(julian-g 2019 11 12)
;-> 2458800
(date-g 2458800)
;-> (2019 11 12)

(julian-g -43 3 15)
;-> 1705428
(date-g 1705428)
;-> (-43 3 15)

Scriviamo la funzione che converte da giorno giuliano a data Giuliana (anno mese giorno):

(define (date-j JD)
  (local (a b c d e m)
    (setq a 0)
    (setq b 0)
    (setq c (+ JD 32082))
    (setq d (/ (+ (* 4 c) 3) 1461))
    (setq e (- c (/ (* 1461 d) 4)))
    (setq m (/ (+ (* 5 e) 2) 153))
    (list
      (+ (* b 100) d (- 4800) (/ m 10))
      (+ m 3 (- (* 12 (/ m 10))))
      (+ e (- (/ (+ (* 153 m) 2) 5)) 1)
    )
  )
)

(julian-j 2019 11 11)
;-> 2458812
(date-j 2458812)
;-> (2019 11 11)

(julian-j 2019 11 12)
;-> 2458813
(date-j 2458813)
;-> (2019 11 12)

(julian-j -4712 01 01)
;-> 0
(date-j 0)
;-> (-4712 1 1)

Adesso vediamo come trovare il giorno della settimana partendo da un giorno giuliano.

Sistema anglosassone
Se la settimana comincia (giorno 0) con la Domenica (Sunday), allora risulta:

  Sun Mon Tue Wed Thu Fri Sat
  Dom Lun Mar Mer Gio Ven Sab
   0   1   2   3   4   5   6

  giorno = mod(JD + 1, 7)

Sistema ISO internazionale
Se la settimana comincia (giorno 1) con il Lunedi (Monday), allora risulta:

  Mon Tue Wed Thu Fri Sat Sun
  Lun Mar Mer Gio Ven Sab Dom
   1   2   3   4   5   6   7

  giorno = mod(J, 7) + 1

(define (jd-day JD) (+ (% JD 7) 1))

(julian-g -43 3 15)
;-> 1705428
(date-g 1705428)
;-> (-43 3 15)
(jd-day 1705428)
;-> 5 ; Caio Giulio Cesare è morto di Venerdi

Le date formano uno spazio affine. Ciò significa che il risultato della sottrazione di due date non è un'altra data, ma piuttosto un intervallo di tempo. Ad esempio, il risultato della sottrazione del 1 gennaio 2013 dal 2 gennaio 2013 è l'intervallo di tempo di un giorno. Non è un'altra data.

In uno spazio affine, ci sono due tipi di oggetti, chiamati "punti" e "vettori". In questo caso i punti sono "date" e i vettori sono gli "intervalli" (numero di giorni). Con questi oggetti è possibile eseguire le seguenti operazioni:

Operazione                      Risultato
  data1 - data2                   intervallo
  data + intervallo               data
  data - intervallo               data
  intervallo1 + intervallo2       intervallo
  intervallo1 - intervallo2       intervallo

Si noti in particolare che non è possibile sommare due date.

Quindi con le funzioni che abbiamo definito (julian-g, date-g, jd-day ecc.) possiamo effettuare tutte le operazioni elencate sopra. Ad esempio, supponiamo di voler calcolare la differenza tra il 22 aprile 2010 e il 28 novembre 2012:

Calcoliamo il giorno giuliano per ognuna delle due date:

(setq jd1 (julian-g 2010 4 22))
;-> 2455309
(setq jd2 (julian-g 2012 11 28))
;-> 2456260

e poi calcoliamo la differenza:

(setq diff (- jd2 jd1))
;-> 951

Un altro esempio: che giorno della settimana sarà il natale del 2020 ?

(jd-day (julian-g 2020 12 25))
;-> 5 ;venerdi


-------------------------
Punto interno al poligono
-------------------------

Dato un poligono e un punto, determinare se il punto è interno o esterno al poligono.

Un metodo per verificare la presenza di un punto all'interno di una regione è il teorema della curva di Jordan. In sostanza, dice che un punto è all'interno di un poligono se, per qualsiasi raggio da questo punto, c'è un numero dispari di intersezioni del raggio con i segmenti (lati) del poligono. Questo vale per tutti i poligoni (concavi, convessi, con isole). Occorre considerare il caso particolare in cui il raggio interseziona uno o più vertici del poligono.

Esempio:

     |
  14 |           X---------X
     |          /           \
     |         /             \
  11 |        /         X-----X
     |       /          |
     |      /           |
   8 |     X     p1     X
     |      \           /
   6 |    p2 \         /
     |        \       /
     |         \     /
     |          \   /
     |           \ /
   1 |            X
     |
  ---------------------------------
     |     5     12     18 21 24

Rappresentazione degli oggetti punto e poligono:

pnt -> (x y)

poly ((x0 y0) (x1 y1) (x2 y2) (x3 y3) ... (xn yn))

Definiamo prima la funzione:

(define (point-in-polygon? pnt poly)
  (local (numpoint i j res)
    (setq numpoint (length poly))
    (setq res nil)
    (setq i 0)
    (setq j (- numpoint 1))
    (while (< i numpoint)
      (if (and (!= (> (last (poly i)) (last pnt)) (> (last (poly j)) (last pnt)))
               (< (first pnt)
                  (add (div (mul (sub (first (poly j)) (first (poly i)))
                                 (sub (last pnt) (last (poly i))))
                            (sub (last (poly j)) (last (poly i))))
                       (first (poly i)))))
          (setq res (not res))
      )
      (setq j i)
      (setq i (+ i 1))
    )
    ; check if point is equal to a vertex of polygon
    (dolist (el poly)
      (if (and (= (first el) (first pnt))
               (= (last el) (last pnt)))
          (setq res true)))
    res
  )
)

Altra versione con variabili ausiliarie:

(define (point-in-polygon? pnt poly)
  (local (numpoint i j res a b)
    (setq numpoint (length poly))
    (setq res nil)
    (setq i 0)
    (setq j (- numpoint 1))
    (while (< i numpoint)
      (setq a (mul (sub (first (poly j)) (first (poly i)))
                   (sub (last pnt) (last (poly i)))))
      (setq b (sub (last (poly j)) (last (poly i))))
      (if (and (!= (> (last (poly i)) (last pnt)) (> (last (poly j)) (last pnt)))
               (< (first pnt) (add (div a b) (first (poly i)))))
          (setq res (not res))
      )
      (setq j i)
      (setq i (+ i 1))
    )
    ; check if point is equal to a vertex of polygon
    (dolist (el poly)
      (if (and (= (first el) (first pnt))
               (= (last el) (last pnt)))
          (setq res true)))
    res
  )
)


Poligono:
(setq poligono '((12 1) (5 8) (12 14) (21 14) (24 11) (18 11) (18 8)))
(setq poligono '((12 1) (5 8) (12 14) (21 14) (24 11) (18 11) (18 8) (12 1)))

Punto interno p1:
(setq p1 '(12 8))

Punto esterno P2:
(setq p2 '(5 6))

(point-in-polygon? p1 poligono)
;-> true

(point-in-polygon? p2 poligono)
;-> nil

(point-in-polygon? '(21 12) poligono)
;-> true

(point-in-polygon? '(12 11) poligono)
;-> true

(point-in-polygon? '(21 10) poligono)
;-> nil

(point-in-polygon? '(5 11) poligono)
;-> nil

I punti del poligono appartengono al poligono:

(point-in-polygon? '(5 8) poligono)
;-> true

(point-in-polygon? '(21 14) poligono)
;-> true

(point-in-polygon? '(12 1) poligono)
;-> true

Spiegazione rapida:
Supponendo che il punto si trovi sulla coordinata y, la funzione calcola semplicemente le posizioni x in cui ciascuna dei lati (non orizzontali) del poligono interseziona con y. Conta il numero di posizioni x che sono inferiori alla posizione x del tuo punto. Se il numero di posizioni x è dispari, il punto è all'interno del poligono.
Un altro modo di visualizzare questo metodo: tracciamo una linea dall'infinito direttamente al tuo punto. Quando questa linea attraversa un lato del poligono siamo all'interno del poligono. Quando attraversiamo di nuovo un lato del poligono, allora siamo fuori. Nuova intersezione, dentro... e così via.

Spiegazione approfondita:

https://stackoverflow.com/questions/8721406/how-to-determine-if-a-point-is-inside-a-2d-convex-polygon

Il metodo esamina un "raggio" che inizia nel punto testato e si estende all'infinito sul lato destro dell'asse X. Per ogni segmento poligonale, controlla se il raggio lo attraversa. Se il numero totale di attraversamenti di segmenti è dispari, il punto testato viene considerato all'interno del poligono, altrimenti è esterno.

Per capire come viene calcolata la traversata, considerare la seguente figura:

              v2
              o
             /
            / c (intersezione)
  o -------- x ----------------------> all'infinito
  t       /
         /
        /
       o
       v1

Affinché si verifichi l'intersezione, test.y deve essere compreso tra i valori y dei vertici del segmento (v1 e v2). Questa è la prima condizione dell'istruzione if nel metodo. In questo caso, la linea orizzontale deve intersecare il segmento. Resta solo da stabilire se l'intersezione avviene alla destra del punto testato o alla sua sinistra. Ciò richiede di trovare la coordinata x del punto di intersezione, che è:

              t.y - v1.y
c.x = v1.x + ----------- * (v2.x - v1.x)
             v2.y - v1.y

Tutto ciò che resta da fare è esaminare i casi particolari:

Se v1.y == v2.y il raggio percorre il segmento e quindi il segmento non ha influenza sul risultato. In effetti, la prima parte dell'istruzione if restituisce false in quel caso.
Il codice moltiplica prima e solo successivamente divide. Questo viene fatto per supportare differenze molto piccole tra v1.x e v2.x, che potrebbero portare a uno zero dopo la divisione, a causa dell'arrotondamento.

Poi, viene il problema dell'incrocio esattamente su un vertice. Considera i seguenti due casi:

           o                    o
           |                     \     o
           | A1                C1 \   /
           |                       \ / C2
  o--------x-----------x------------x--------> all'infinito
          /           / \
      A2 /        B1 /   \ B2
        /           /     \
       o           /       o
                  o

Ora, per verificare se funziona, occorre controllare cosa viene restituito per ciascuno dei 4 segmenti dalla condizione if nel corpo del metodo. Scopriamo che i segmenti sopra il raggio (A1, C1, C2) ricevono un risultato positivo, mentre quelli sotto di esso (A2, B1, B2) ricevono un risultato negativo. Ciò significa che il vertice A contribuisce con un numero dispari (1) al conteggio dei passaggi, mentre B e C contribuiscono con un numero pari (0 e 2, rispettivamente), che è esattamente ciò che si desidera. A è davvero un vero incrocio del poligono, mentre B e C sono solo due casi di "sorvolo".

Infine viene verificato il caso in cui il punto è uguale ad uno dei vertici del poligono.

Vedi anche:

https://stackoverflow.com/questions/217578/how-can-i-determine-whether-a-2d-point-is-within-a-polygon


-------------------
Prodotto cartesiano
-------------------

In matematica il prodotto cartesiano di due insiemi A e B è l'insieme delle coppie ordinate (a,b) con a in A e b in B:

A x B = [(a,b): a in A e b in B]

Per esempiop, date due liste A = (1 2) e B = (3 4) il loro prodotto cartesiano vale:

(1 2) x (3 4) = ((1 3) (1 4) (2 3) (2 4))

cioè tutte le coppie formate dall'unione di ogni elemento della lista A con ogni elemento della lista B.

Nota: Il prodotto cartesiano non è commutativo: (A x B) != (B x A)

La funzione per calcolare il prodotto cartesiano di due liste è la seguente:

(define (cp lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        '()
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

(cp '(1 2) '(3 4))
;-> ((1 3) (1 4) (2 3) (2 4))

(cp '(3 4) '(1 2))
;-> ((3 1) (3 2) (4 1) (4 2))

(cp '(1 2) '())
;-> '()

(cp '() '(1 2))
;-> '()

(cp '(1 2 3) '(4 5))
;-> ((1 4) (1 5) (2 4) (2 5) (3 4) (3 5))

Il prodotto cartesiano può essere esteso alla composizione di n insiemi considerando l'insieme delle n-uple ordinate:

A1 x A2 x ... x An = [(a1,a2,...,an): a(i) in A(i) per i=1..n]

Il prodotto cartesiano è naturalmente associativo:

A1 x A2 x ... x An = A1 x (A2 x ... x An)

Per calcolare il prodotto cartesiano di più liste (comunque racchiuse in una lista) potremmo applicare la funzione "apply":

(apply cp '((1 2) (3 4) (5 6)) 2)
;-> (((1 3) 5) ((1 3) 6) ((1 4) 5) ((1 4) 6) ((2 3) 5) ((2 3) 6) ((2 4) 5) ((2 4) 6))

Il risultato è corretto, dobbiamo solo togliere le parentesi ad ogni elemento della lista:

((1 3) 5) --> (1 3 5)
((1 3) 6) --> (1 3 6)
((1 4) 5) --> (1 4 5)
...
((2 4) 6) --> (2 4 6)

Scriviamo la funzione che calcola il prodotto cartesiano di tutte le sotto-liste di una lista:

(define (prodotto-cartesiano lst-lst)
  (let (out '())
    (dolist (el (apply cp lst-lst 2))
      (push (flat el) out -1)
    )
    out))

(prodotto-cartesiano '((1 2) (3 4) (5 6)))
;-> ((1 3 5) (1 3 6) (1 4 5) (1 4 6) (2 3 5) (2 3 6) (2 4 5) (2 4 6))

(prodotto-cartesiano '((1 2 3) (4) (5 6)))
;-> ((1 4 5) (1 4 6) (2 4 5) (2 4 6) (3 4 5) (3 4 6))

(prodotto-cartesiano '((1 5) (2 6) (3 7) (4 8 9)))
;-> ((1 2 3 4) (1 2 3 8) (1 2 3 9) (1 2 7 4) (1 2 7 8) (1 2 7 9) (1 6 3 4)
;->  (1 6 3 8) (1 6 3 9) (1 6 7 4) (1 6 7 8) (1 6 7 9) (5 2 3 4) (5 2 3 8)
;->  (5 2 3 9) (5 2 7 4) (5 2 7 8) (5 2 7 9) (5 6 3 4) (5 6 3 8) (5 6 3 9)
;->  (5 6 7 4) (5 6 7 8) (5 6 7 9))

(prodotto-cartesiano '((1 2 3) (1) (500 100)))
;-> ((1 1 500) (1 1 100) (2 1 500) (2 1 100) (3 1 500) (3 1 100))

(prodotto-cartesiano '((1 2) (3 4)))
;-> ((1 3) (1 4) (2 3) (2 4))

Da notare che i risultati sono diversi nel caso di liste annidate:

(cp '(1 2 (3 4)) '((4 (3)) (5) (6)))
;-> ((1 (4 (3))) (1 (5)) (1 (6)) (2 (4 (3))) (2 (5))
;-> (2 (6)) ((3 4) (4 (3))) ((3 4) (5)) ((3 4) (6)))

(prodotto-cartesiano '((1 2 (3 4)) ((4 (3)) (5) (6))))
;-> ((1 4 3) (1 5) (1 6) (2 4 3) (2 5) (2 6) (3 4 4 3) (3 4 5) (3 4 6))
(prodotto-cartesiano '((1 2 3 4) (4 3 5 6)))
;-> ((1 4) (1 3) (1 5) (1 6) (2 4) (2 3) (2 5) (2 6)
;-> (3 4) (3 3) (3 5) (3 6) (4 4) (4 3) (4 5) (4 6))

Se abbiamo delle liste con elementi di tipo stringa, potremmo volere un altro risultato invece di:

(cp '("1" "2" "3") '("4" "5" "6"))
;-> (("1" "4") ("1" "5") ("1" "6")
;->  ("2" "4") ("2" "5") ("2" "6")
;->  ("3" "4") ("3" "5") ("3" "6"))

Cioè, vogliamo che il risultato sia: ("14" "15" "16" "24" ...).

In questo caso possiamo scrivere una nuova funzione simile a "cp", dove usiamo "string" al posto di "append":

(define (cps lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (string el1 el2) out -1))))))

(cps '("1" "2" "3") '("4" "5" "6"))
;-> ("14" "15" "16" "24" "25" "26" "34" "35" "36")

(define (cps-2 lst1 lst2)
  (if (or (empty? lst1) (empty? lst2))
      '()
      (apply append
             ; map su tutti gli elementi in lst1, quindi su ciascuno di essi
             ; map nuovamente su quelli in lst2 e concatenazione
             (map (fn (x) (map (fn (y) (string x y)) lst2)) lst1))))

(cps-2 '("1" "2" "3") '("4" "5" "6"))
;-> ("14" "15" "16" "24" "25" "26" "34" "35" "36")

Prodotto cartesiano di funzioni
-------------------------------
Se f è una funzione da A in B e g una funzione da C in D, si definisce come loro prodotto cartesiano e si denota con f x g la funzione da A x C in B x D data da:

[f x g](a,c) = [f(a), g(c)]

(Abbiamo distinto le parentesi che delimitano argomenti di funzione () dalle parentesi che delimitano coppie ordinate [])

Esempio:

(define (pcf f g lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list (f el1) (g el2)) out -1))))))

(define (f x) x)
(define (g x) (* x x))

(pcf f g (sequence 1 3) (sequence 1 3))
;-> ((1 1) (1 4) (1 9) (2 1) (2 4) (2 9) (3 1) (3 4) (3 9))


------------------------------
Insieme delle parti (powerset)
------------------------------

Dato un insieme L, l'insieme delle parti di L, scritto P(L), è l'insieme di tutti i sottoinsiemi di L. Questa collezione di insiemi viene anche detta insieme potenza di L.
Se l'insieme L ha n elementi, allora l'insieme delle parti ha 2^n elementi.

Esempio:
(setq L '(1 2 3))
(powerset-i L)
;-> ((3 2 1) (3 2) (3 1) (3) (2 1) (2) (1) ())
(length (powerset-i L))
;-> 8

Scriviamo una funzione ricorsiva cha calcola l'insieme potenza:

(define (powerset lst)
  (if (empty? lst)
      (list '())
      (let ( (element (first lst))
             (p (powerset (rest lst))))
           (append (map (fn (subset) (cons element subset)) p) p) )))

(powerset '(a b c))
;-> ((a b c) (a b) (a c) (a) (b c) (b) (c) ())

Adesso scriviamo una funzione iterativa cha calcola l'insieme potenza:

(define (powerset-i lst)
  (define (loop res s)
    (if (empty? s)
      res
      (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s))))
  (loop '(()) lst))

Vediamo la differenza di velocità tra le due funzioni:

(time (powerset '(1 2 3 4 5 6 7 8 9 10 15 16)) 1000)
;-> 2906.498

(time (powerset-i '(1 2 3 4 5 6 7 8 9 10 15 16)) 1000)
;-> 3672.166


-----------------
Terne pitagoriche
-----------------

Una terna pitagorica è costituita da tre numeri interi positivi a, b e c con a < b < c tale che a^2 + b^2 = c^2. Ad esempio, i tre numeri 3, 4 e 5 formano una tripla pitagorica perché 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

Scrivere una funzione per generare tutte le terne pitagoriche.

Esistono diversi metodi per generare le terne pitagoriche ad esempio l'algoritmo di Hall:

Se (a b c) è una terna pitagorica primitiva, allora lo sono anche:

  (a – 2b + 2c,  2a – b + 2c,  2a – 2b + 3c)

  (a + 2b + 2c,  2a + b + 2c,  2a + 2b + 3c)

  (-a + 2b + 2c, 2a + b + 2c, -2a + 2b + 3c)

Comunque per generare tutte le terne pitagoriche useremo il metodo di Dickson:

Per trovare soluzioni intere a x^2 + y^2 = z^2, trovare degli interi positivi r, s, t tali che r^2 = 2st sia un quadrato perfetto.
Quindi calcolare la terna pitagorica (x y z):

  x = r + s, y = r + t, z = r + s + t

Notiamo che r è un numero intero pari e che s e t sono fattori di (r ^ 2) / 2. Tutte le terne pitagoriche possono essere trovate con questo metodo. Quando s e t sono coprimi, la terna viene detta primitiva.

Nota: Una terna (x y z) viene detta primitiva quando x e y sono coprimi. Una terna primitiva (x y z) genera infinite terne non primitive moltiplicando i termini per un qualunque numero intero positivo n.

Esempio:

Terna primitiva: (3 4 5)       n
Terna non primitiva: (3 4 5) * 2 ==> (6 8 10)
Terna non primitiva: (3 4 5) * 3 ==> (9 12 15)
...

Il metodo di Dickson genera tutte le terne pitagoriche, anche quelle simmetriche (quelle in cui vengono scambiati i valori di x e y). Esempio: (3 4 5) e (4 3 5) sono due terne pitagoriche distinte.

La seguente funzione restituisce n terne pigatoriche:

(define (terne n)
  (local (a b c r f1 f2 idx somma continua out)
    (setq r 2)
    (setq f1 1)
    (setq idx 0)
    (while (< idx n)
      (setq continua true)
      (while continua
      ; calcola i fattori s (f1) e t (f2) del prossimo r^2/2
      ; e inserisci l'equazione per s e t
        (cond ((zero? (% (/ (* r r) 2) f1))
                (setq f2 (/ (/ (* r r) 2) f1))
                (setq a (+ r f1))
                (setq b (+ r f2))
                (setq c (+ r f1 f2))
                (++ f1)
                (setq continua nil)
                (push (list a b c) out -1))
                ; se f1 è maggiore di r^2/2, passa alla r successiva
                ; e imposta il fattore f1 a 1
              ((= f1 (+ (/ (* r r) 2) 1))
                (setq r (+ r 2))
                (setq f1 1))
              (true (++ f1))
        )
      )
      (++ idx)
    )
    out))

Calcoliamo le prime venti terne pitagoriche (primitive e non primitive):

(terne 20)
;-> ((3 4 5) (4 3 5) (5 12 13) (6 8 10) (8 6 10) (12 5 13) (7 24 25)
;->  (8 15 17) (9 12 15) (12 9 15) (15 8 17) (24 7 25) (9 40 41)
;->  (10 24 26) (12 16 20) (16 12 20) (24 10 26) (40 9 41) (11 60 61)
;->  (12 35 37))

Se vogliamo estrarre solo le terne primitive usiamo la funzione "filter" con il seguente predicato che verifica se i primi due numeri di una terna sono coprimi:

(define (coprimi? lst) (= (gcd (first lst) (first (rest lst))) 1))

(coprimi? '(3 4 5))
;-> true

Estraiamo solo le terne primitive:

(filter coprimi? (terne 20))
;-> ((3 4 5) (4 3 5) (5 12 13) (12 5 13) (7 24 25) (8 15 17) (15 8 17)
;->  (24 7 25) (9 40 41) (40 9 41) (11 60 61) (12 35 37))

Se vogliamo eliminare le terne simmetriche possiamo ordinare tutte le terne e poi rimuovere tutti i duplicati:

(unique (map (fn(x) (sort x)) (filter coprimi? (terne 20))))
;-> ((3 4 5) (5 12 13) (7 24 25) (8 15 17) (9 40 41) (11 60 61) (12 35 37))


---------------------------------
Calcolo di e con il metodo spigot
---------------------------------

Definiamo una funzione che calcola il numero di Eulero usando l'algoritmo di Rabinowitz e Wagon.

Il numero di Eulero "e" vale (con 500 cifre dopo la virgola):

2.71828182845904523536028747135266249775724709369995957496696762772407663
0353547594571382178525166427427466391932003059921817413596629043572900334
2952605956307381323286279434907632338298807531952510190115738341879307021
5408914993488416750924476146066808226480016847741185374234544243710753907
7744992069551702761838606261331384583000752044933826560297606737113200709
3287091274437470472306969772093101416928368190255151086574637721112523897
844250569536967707854499699679468644549059879316368892300987931

Di seguito lo pseudo-codice dell'algoritmo come riportato nell'articolo di Rabinowitz e Wagon:

Algorithm e-spigot:

1. Initialize:
   Let the first digit be 2 and
   initialize an array A of length n + 1 to (1, 1, 1, . . . , 1).
2. Repeat n − 1 times:
   Multiply by 10: Multiply each entry of A by 10.
   Take the fractional part: Starting from the right,
                             reduce the ith entry of A modulo i + 1,
                             carrying the quotient one place left.
   Output the next digit: The final quotient is the next digit of e.

Questa è l'implementazione in newLISP:

(define (spigot-e n)
  (local (vec cifra out)
    (setq out '())
    ; vettore con n elementi tutti di valore 1
    (setq vec (array n '(1)))
    (for (i 0 (- n 1))
      (setq cifra 0)
      (for (j (- n 1) 0 -1)
        (setf (vec j) (+ (* 10 (vec j)) cifra))
        (setq cifra (/ (vec j) (+ j 2)))
        (setf (vec j) (% (vec j) (+ j 2)))
      )
      (push cifra out -1))
    out))

(spigot-e 10)
;-> (7 1 8 2 8 1 8 2 6 1)

Un aspetto negativo di questo algoritmo è che le ultime cifre calcolate non sono corrette (soprattutto quando calcoliamo poche cifre). Questo problema può essere risolto in maniera pratica calcolando più cifre di quelle necessarie, in quanto l'algoritmo è molto veloce (calcolando 50 cifre in più siamo al sicuro fino a miliardi di cifre...).

Calcoliamo il numero "e" con 500 cifre dopo la virgola:

(join (map string (spigot-e 499)))
;-> "7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274274663919320030599218174135966290435729003342952605956307381323286279434907632338298807531952510190115738341879307021540891499348841675092447614606680822648001684774118537423454424371075390777449920695517027618386062613313845830007520449338265602976067371132007093287091274437470472306969772093101416928368190255151086574637721112523897844250569536967707854499699679468644549059879316368892300987931"

In questo caso tutte le cifre sono corrette.

Vedi anche "Calcolo di pi greco con il metodo spigot" su "Note libere 24".


-----------
Calcolo IVA
-----------

Due funzioni per calcolare l'IVA (Imposta Valore Aggiunto) e per scorporare l'IVA.

(define (iva+ value iva-perc)
  (mul value (add 1 (div iva-perc 100))))

(iva+ 100 20)
;-> 120

(iva+ 80 20)
;-> 96

(define (iva- value iva-perc)
  (div value (add 1 (div iva-perc 100))))

(iva- 96 20)
;-> 80


-----------------------
Numeri casuali distinti
-----------------------

Generare una lista ordinata con N numeri casuali distinti tra loro compresi tra "a" e "b".

Usiamo la funzione "rand-range" per generare un numero compreso tra "a" e "b":

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1))))

Crea una lista con tutti i valori di una hashmap:

(define (getValues hash)
  (local (out)
    (dolist (cp (hash))
      (push (cp 1) out -1)
    )
  out))

Poi scriviamo la funzione richiesta:

(define (sample n a b)
  (local (value out)
    ; creazione di un hashmap
    (new Tree 'hset)
    (until (= (length (hset)) n)
      ; genera valore casuale
      (setq value (rand-range a b))
      ; inserisce valore casuale nell'hash
      (hset (string value) value))
      ; assegnazione dei valori dell'hasmap ad una lista
      (setq out (getValues hset))
      ; eliminazione dell'hashmap
      (delete 'hset)
      (sort out)))

(sample 50 1 1000)
;-> (52 58 71 97 103 107 111 128 131 135 160 203 219 221
;->  225 240 284 291 294 301 307 324 397 416 428 474 530
;->  547 623 651 744 763 773 779 790 807 821 826 837 839
;->  851 859 875 921 930 936 965 970 980 988)

Nota: La chiamata (sample 50 1 25) non termina mai. Per correttezza dovremmo inserire un controllo che verifica se "n" è maggiore di "(b - a + 1)", nel qual caso non esiste una lista con 50 numeri diversi con un intervallo minore della dimensione della lista. Il caso limite è quando risulta n = (b - a + 1):

(sample 10 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

Invece la seguente chiamata non termina mai:

(sample 10 1 9)
Premere Ctrl+C per fermare l'elaborazione...
;-> ERR: received SIGINT - in function length
;-> called from user function (sample 10 1 9)>

Riscriviamo la funzione inserendo il controllo:

(define (sample n a b)
  (local (value out)
    (cond ((> n (+ b (- a) 1)) '()) ; controllo
          (true
            ; creazione di un hashmap
            (new Tree 'hset)
            (until (= (length (hset)) n)
              ; genera valore casuale
              (setq value (rand-range a b))
              ; inserisce valore casuale nell'hash
              (hset (string value) value))
              ; assegnazione dei valori dell'hasmap ad una lista
              (setq out (getValues hset))
              ; eliminazione dell'hashmap
              (delete 'hset)
              (sort out)))))

(sample 10 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

Adesso quando risulta n > (b - a + 1) la funzione restituisce la lista vuota:

(sample 10 1 9)
;-> ()

Un metodo generico per estrarre n elementi casuali diversi da una lista di elementi è quello di mischiare gli elementi della lista e poi prendere i primi n:

(define (samples num lst)
  (if (> num (length lst)) '()
      (sort (slice (randomize lst) 0 num ))))

(samples 5 (sequence 1 10))
;-> (1 2 5 8 10)

(samples 11 (sequence 1 10))
;-> (1 2 3 4 5 6 7 8 9 10)

(samples 5 (explode "abcdefghijklmnopqrstuvwxyz"))
;-> ("a" "f" "m" "n" "t")

Questo metodo è molto veloce, ma richiede una lista con tutti gli elementi.


-----------------------------------------------------
Numeri casuali con distribuzione discreta predefinita
-----------------------------------------------------

Supponiamo di voler generare uno dei seguenti eventi (a b c d) con le seguenti probabilità associate (0.05 0.15 0.35 0.45). In altre parole, se generiamo 1000 eventi la distribuzione deve essere uguale a quella predefinita: 50 a, 150 b, 350 c e 450 d (più o meno).

Nota: la somma delle probabilità deve valere 1.0.

Definiamo gli intervalli:

1) (0.00, 0.05) --> probabilità 5%
2) (0.05, 0.20) --> probabilità 15% (0.20 = 0.05 + 0.15)
3) (0.20, 0.55) --> probabilità 35% (0.55 = 0.20 + 0.35)
4) (0.55, 1.00) --> probabilità 45% (1.00 = 0.55 + 0.45)

(setq intervalli '(0.0 0.05 0.2 0.55 1.0))

Adesso generiamo un numero casuale R:

- se R cade nell'intervallo 1 [0.00, 0.05],
  allora si verifica l'evento "a" --> indice 0
- se R cade nell'intervallo 2 (0.05, 0.20],
  allora si verifica l'evento "b" --> indice 1
- se R cade nell'intervallo 3 (0.20, 0.55],
  allora si verifica l'evento "c" --> indice 2
- se R cade nell'intervallo 4 (0.55, 1.00],
  allora si verifica l'evento "d" --> indice 3

La funzione genera un numero da 0 a (n-1) che rappresenta l'indice del valore di probabilità nella lista delle probabilità:

(define (rand-prob probs)
  (local (out inter cur val found)
    (setq found nil)
    (setq inter '(0.0))
    (setq cur 0)
    ; creazione della lista degli intervalli
    (dolist (el probs)
      (setq cur (round (add cur el) -4))
      (push cur inter -1)
    )
    ; l'ultimo valore della lista degli intervalli deve valere 1
    (if (!= (last inter) 1) (println "Errore: somma probabilita diversa da 1"))
    ;(print inter)
    ; generazione numero random con probabilità predefinite
    (setq val (random))
    (setq out nil)
    ; ricerca in quale intervallo cade il numero random
    ; e restituisce l'indice corrispondente
    (for (i 0 (- (length inter) 2) 1 found)
      (if (and (>= val (inter i)) (<= val (inter (+ i 1))))
        (begin
        (setq out i)
        (setq found true))
      )
    )
    out))

Proviamo con l'esempio iniziale:

(setq p '(0.05 0.15 0.35 0.45))

(rand-prob p)
;-> 2

Verifichiamo la funzione generando 1000000 valori che popolano un vettore di frequenze:

(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-prob p))))
vet
;-> (50177 150075 348712 451036)
Il risultato segue bene la distribuzione perfetta che vale (50000 150000 350000 450000).

Calcoliamo la somma dei valori del vettore:
(apply + vet)
;-> 1000000

Facciamo un'altra prova:

(setq p '(0.02 0.08 0.7 0.2))
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-prob p))))
vet
;-> (19887 79869 699932 200312)

Sembra che tutto funzioni correttamente.

Vedi anche "Estrazione di elementi con probabilità predefinite" nel capitolo "15-note-libere-07".

------------------------------
Generatore di stringhe casuali
------------------------------

Scrivere una funzione che genera stringhe casuali di lunghezza prefissata.

Lettere minuscole:
(char 97)
;-> "a"
(char 122)
;-> "z"
(setq lower (map char (sequence 97 122)))
;-> ("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
;->  "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
(length lower)
;-> 26

Lettere maiuscole:
(char 65)
;-> "A"
(char 90)
;-> "Z"
(setq upper (map char (sequence 65 90)))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
;->  "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
(length upper)
;-> 26

Vocali:
(setq vowels '("a" "e" "i" "o" "u"))

Consonanti:
(setq consonants '("b" "c" "d" "f" "g" "h" "j" "k" "l" "m" "n" "p" "q" "r" "s" "t" "v" "w" "x" "y" "z"))

(setq upper-rnd (map char (randomize (sequence 65 90))))
;-> ("A" "P" "G" "V" "Q" "B" "N" "Y" "W" "D" "M" "X" "J"
;->  "T" "R" "F" "E" "U" "C" "O" "Z" "L" "I" "K" "H" "S")

Generatore di interi tra [a, b]:

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1))))

Estrae un carattere casuale da una lista:

(define (rand-char lst) (lst (rand (length lst))))

(rand-char lower)
;-> "c"

Il più semplice dei generatori casuali utilizza la funzione "rand-char" per creare una stringa di lunghezza n con caratteri presi dall'alfabeto alfa:

(define (rand-string n alfa)
  (let (out '())
    (dotimes (i n)
      (push (rand-char alfa) out -1))
      (join out)))

(rand-string 10 lower)
;-> "unhwsyyodm"

(rand-string 10 upper)
;-> "YTCPKTPOJD"

(rand-string 10 vowels)
;-> "eiuiuoeaoi"

Adesso ci proponiamo di scrivere una funzione che genera stringhe "leggibili". Per stringa "leggibile" intendiamo una stringa che segue le regole generali della lingua italiana e quindi può essere letta senza difficoltà (es. "unhwsyyodm" è illeggibile).
Vediamo alcune di queste regole (che hanno quasi sempre delle eccezioni):
1) non ci sono tre vocali di seguito (eccez. aiuola)
2) non ci sono tre consonanti di seguito (eccez. strada)
3) non ci sono quattro consonanti di seguito
4) alcune consonanti non possono essere doppie (es. hh, yy, xx, ww)
5) ecc.

La funzione che implementiamo segue le seguenti regole di costruzione:

a) Inizia con una consonante
b) segue una vocale
c) può seguire:
   c1) una consonante (percentuale di probabilità 60%)
   c2) due consonanti uguali (nn,rr,tt,...) (30%)
   c3) due consonanti diverse (fr,pr,tr,sf,...) (15%)
   c4) tre consonanti diverse (sfr, str, ttr,...) (5%)
d) segue una vocale
e) ritornare al punto a)

Cominciamo a definire quali sono le consonanti doppi possibili.

(define (doppia lst)
  (let (out '())
    (dolist (el lst)
      (push (string el el) out -1))))

(doppia consonants)
;-> ("bb" "cc" "dd" "ff" "gg" "hh" "jj" "kk" "ll" "mm" "nn" "pp"
;->  "qq" "rr" "ss" "tt" "vv" "ww" "xx" "yy" "zz")

Eliminiamo "hh", "jj", "kk", ,"qq", "ww", "xx" e "yy".

(setq doppie '("bb" "cc" "dd" "ff" "gg" "ll" "mm" "nn" "pp" "rr" "ss" "tt" "zz"))

Adesso analizziamo le consonanti diverse.

(setq lettere '("b" "c" "d" "f" "g" "l" "m" "n" "p" "q" "r" "s" "t" "v"))

Generiamo tutte le doppie:

(define (cp lst1 lst2 func)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (func el1 el2) out -1))))))

(difference (unique (cp lettere lettere string)) (doppia lettere))
;-> ("bc" "bd" "bf" "bg" "bl" "bm" "bn" "bp" "bq" "br" "bs" "bt" "bv"
;->  "cb" "cd" "cf" "cg" "cl" "cm" "cn" "cp" "cq" "cr" "cs" "ct" "cv"
;->  "db" "dc" "df" "dg" "dl" "dm" "dn" "dp" "dq" "dr" "ds" "dt" "dv"
;->  "fb" "fc" "fd" "fg" "fl" "fm" "fn" "fp" "fq" "fr" "fs" "ft" "fv"
;->  "gb" "gc" "gd" "gf" "gl" "gm" "gn" "gp" "gq" "gr" "gs" "gt" "gv"
;->  "lb" "lc" "ld" "lf" "lg" "lm" "ln" "lp" "lq" "lr" "ls" "lt" "lv"
;->  "mb" "mc" "md" "mf" "mg" "ml" "mn" "mp" "mq" "mr" "ms" "mt" "mv"
;->  "nb" "nc" "nd" "nf" "ng" "nl" "nm" "np" "nq" "nr" "ns" "nt" "nv"
;->  "pb" "pc" "pd" "pf" "pg" "pl" "pm" "pn" "pq" "pr" "ps" "pt" "pv"
;->  "qb" "qc" "qd" "qf" "qg" "ql" "qm" "qn" "qp" "qr" "qs" "qt" "qv"
;->  "rb" "rc" "rd" "rf" "rg" "rl" "rm" "rn" "rp" "rq" "rs" "rt" "rv"
;->  "sb" "sc" "sd" "sf" "sg" "sl" "sm" "sn" "sp" "sq" "sr" "st" "sv"
;->  "tb" "tc" "td" "tf" "tg" "tl" "tm" "tn" "tp" "tq" "tr" "ts" "tv"
;->  "vb" "vc" "vd" "vf" "vg" "vl" "vm" "vn" "vp" "vq" "vr" "vs" "vt")

Scegliamo "br", "cl", "cr", "dr", "fl", "fr", "gl", "gn", "gr", "lg", "pl", "pr", "rb", "rc" , "rs", "sb", "sc", "sf", "sl", "sm", "sp", "st", "tr".

(setq doppie-div '("br" "cl" "cr" "dr" "fl" "fr" "gl" "gn" "gr" "lg" "pl" "pr" "rb" "rc"  "rs" "sb" "sc" "sf" "sl" "sm" "sp" "st" "tr"))

Vediamo le triple consonanti:

(setq triple '("sfr" "str" "ttr"))

Funzione che estrae un elemento casuale dalla lista passata:

(define (rand-list lst) (lst (rand (length lst))))

(rand-list doppie)
;-> "cc"
(rand-list doppie-div)
;-> "dr"

Infine scriviamo la funzione che genera parole casuali "leggibili":

(define (rand-word iter)
  (local (out)
    (setq out '())
    (dotimes (i iter)
      (push (rand-list consonants) out -1)
      (push (rand-list vowels) out -1)
      (case (rand 4)
            (0 (push (rand-list consonants) out -1))
            (1 (push (rand-list doppie) out -1))
            (2 (push (rand-list doppie-div) out -1))
            (3 (push (rand-list triple) out -1))
            (true (println "error")))
      (push (rand-list vowels) out -1))
    (join out)))

(rand-word 2)
;-> "fuzzarazza"

Dieci parole casuali:

(dotimes (x 10) (println (rand-word (+ 1 (rand 2)))))
;-> nistra
;-> kattru
;-> riscumexu
;-> dusfri
;-> cadidosbo
;-> sestruvela
;-> guledavo
;-> bissinopa
;-> xunototto
;-> paslo

Il passo successivo sarebbe quello di definire una percentuale di probabilità predefinita ad ogni evento casuale, per esempio:
c1) una consonante (percentuale di probabilità 60%)
c2) due consonanti uguali  (30%)
c3) due consonanti diverse (15%)
c4) tre consonanti diverse (5%)

Inoltre sarebbe interessante modificare o definire altre regole di costruzione.


--------------------
Inverso di un numero
--------------------

Per calcolare l'inverso di un numero basta dividere 1 (uno) per il numero stesso. Comunque il newLISP è più veloce non includere il numero 1 nella divisione. Infatti risulta:

(= (div 1 2) (div 2))
;-> true

Calcoliamo la velocità dei due metodi:

(time (div 1 2) 10000000)
;-> 319.685

(time (div 2) 10000000)
;-> 264.999

Quindi la funzione inversa può essere scritta nel modo seguente:

(define (inv x) (if (zero? x) nil (div x)))

(inv 10)
;-> 0.1

(inv 0)
;-> nil


-----------------
Crivello di Atkin
-----------------

Il crivello di Atkin è un algoritmo per calcolare tutti i numeri primi fino ad dato numero intero.
Potete trovare maggiori informazioni sul sito web:

https://it.wikipedia.org/wiki/Crivello_di_Atkin

(define (atkin n)
  (local (primi up m j)
    (setq primi (array (+ n 1) '(nil)))
    (setf (primi 2) true)
    (setf (primi 3) true)
    (setq up (int (ceil (sqrt n))))
    (for (x 1 (- up 1))
      (for (y 1 (- up 1))
        (setq m (+ (* 4 x x) (* y y)))
        (if (and (<= m n) (or (= (% m 12) 1) (= (% m 12) 5)))
            (setf (primi m) (not (primi m)))
        )
        (setq m (+ (* 3 x x) (* y y)))
        (if (and (<= m n) (= (% m 12) 7))
            (setf (primi m) (not (primi m)))
        )
        (setq m (- (* 3 x x) (* y y)))
        (if (and (> x y) (<= m n) (= (% m 12) 11))
            (setf (primi m) (not (primi m)))
        )
      )
    )
    (for (i 5 up)
      (if (primi i)
        (begin
        (setq j (* i i))
        (while (< j n)
          (setf (primi j) nil)
          (setq j (+ j (* i i)))
        )
        )
      )
    )
    ; converte i valori true del vettore in numeri interi (primi)
    (filter integer? (map (fn(x) (if (= x true) $idx)) primi))
  )
)

(atkin 100)
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)

Vediamo il tempo di esecuzione:

(time (atkin 1e6))
;-> 1046.776
(time (atkin 1e7))
;-> 10329.198

Vediamo un'altra funzione per calcolare i numeri primi fino ad un dato numero:

(define (sieve-to n)
   (setq arr (array (+ n 1)) lst '(2))
   (for (x 3 n 2)
      (when (not (arr x))
         (push x lst -1)
         (for (y (* x x) n (* 2 x) (> y n))
            (setf (arr y) true))))
   lst
)

Controlliamo che le due funzioni producano risultati uguali:

(= (sieve-to 100000) (atkin 100000))
;-> true

Vediamo il tempo di esecuzione:

(time (sieve-to 1e7))
;-> 1932.644


-------------------------------
Esponenziazione modulare veloce
-------------------------------

In alcuni calcoli/algoritmi (per esempio il test di primalità di Miller-Rabin) è necessario calcolare l'espressione:

(b^e % m)

Esistono dei metodi per effettuare questo calcolo in modo più veloce. Invece di calcolare la potenza e poi il modulo, possiamo effettuare il calcolo in modo integrato.

Primo metodo:

(define (powmod b e m)
  (local (r)
    (cond ((= m 1) (setq r 0))
          (true
            (setq r 1L)
            (setq b (% b m))
            (while (> e 0)
              (if (= (% e 2) 1) (setq r (% (* r b) m)))
              (setq e (/ e 2))
              (setq b (% (* b b) m))
            )
          )
    )
    r))

Secondo metodo:

(define (modexpt b e M)
  (cond
    ((zero? e) 1L)
    ((even? e) (modexpt (% (* b b) M) (/ e 2L) M))
    ((odd? e) (% (* b (modexpt b (- e 1L) M)) M))))

(time (modexpt 1234L 55555456844L 7L) 10000)
;-> 421.888
(time (powmod 1234L 55555456844L 7L) 10000)
;-> 437.499
(time (modexpt 1234L 55555456844L 7L) 10000)
;-> 421.888
(time (powmod 1234L 55555456844L 7L) 10000)
;-> 421.874

Terzo metodo (standard):

(** x p) calcola la potenza di due numeri interi (x^p):

(define (** x p)
  (let (y 1L)
    (dotimes (i p)
      (set 'y (* y x)))))

(time (% (** 1234L 55555L) 7L))
;-> 1484.471

Praticamente, il terzo metodo è inutilizzabile.

Quarto metodo:

(define (pm a b q)
  (let (out 1L)
    (while (> b 0)
      (if (odd? b)
          (setq out (% (* out a) q)))
      (setq a (% (* a a) q))
      (setq b (/ b 2)))
    out))

(time (modexpt 1234L 955555456844L 7344L) 100000)
;-> 3107.794
(time (powmod 1234L 955555456844L 7344L) 100000)
;-> 3129.95
(time (pm 1234L 955555456844L 7344L) 100000)
;-> 2195.76


-------------
random sample
-------------

In statistica, un "random sample" è un sottoinsieme di elementi (un campione) scelti da un insieme più ampio. Ogni elemento viene scelto casualmente in modo tale che ogni elemento abbia la stessa probabilità di essere scelto in qualsiasi fase durante il processo di campionamento e ogni sottoinsieme di k elementi abbia la stessa probabilità di essere scelto come campione di qualsiasi altro sottoinsieme di k elementi. Questo processo e questa tecnica viene chiamata "campionamento casuale semplice" (simple random sample).

La seguente funzione "random-sample" non è corretta, in quanto può generare numeri uguali (non distinti).

(define (random-sample n k)
  (let (out '())
    (for (i 1 k)
      (push (+ 2 (rand n)) out)
    )
    out))

La seguente "random-sample" è corretta e seleziona k numeri distinti dai numeri 1..n.

(define (random-sample n k)
  ; newLISP start with the same sequence without "seed"
  (seed (time-of-day))
  (slice (randomize (sequence 1 n)) 0 k))

Invece questa "random-sample" seleziona k numeri distinti da una lista
Se n è un numero, allora la lista vale (1 2 ... n).
Altrimenti n deve essere una lista di elementi distinti.

(define (random-sample n k)
  ; newLISP start with the same sequence without "seed"
  (seed (time-of-day))
  (cond ((integer? n)
         (slice (randomize (sequence 1 n)) 0 k))
        ((list? n)
         (slice (randomize n) 0 k))
        (true nil)))

(random-sample 100 10)
;-> (73 30 87 32 20 74 91 2 82 36)

(random-sample '(a v f j k o l) 3)
;-> (j v l)

Nota: queste ultime due funzioni sono inutilizzabili per valori di n grandi, infatti la funzione "sequence" richiederebbe troppa memoria per generare la lista di numeri da 1 a n.

Possiamo scrivere una funzione che utilizza una hashmap. Continuiamo a generare un numero casuale e lo inseriamo nella hashmap fino a che non abbiamo k numeri casuali. La hashmap si preoccupa di gestire le eventuali collisioni (numeri casuali già estratti).

(define (random-sample1 n k)
  (let ((out '()) (r 0))
    (new Tree 'Hash)
    (while (< (length (Hash)) k)
      (setq r (+ 1 (rand n)))
      (Hash r r)
    )
    (dolist (el (Hash)) (push (el 1) out -1))
    (delete 'Hash)
    out
  )
)

Chiaramente questa funzione è efficiente quando il valore di n è almeno un ordine di grandezza superiore al valore di k.

(random-sample1 100 10)
;-> (11 26 38 4 57 60 70 73 77 87)

(length (unique (random-sample1 1000 1000)))
;-> 1000

Un altro problema viene dal fatto che la cancellazione della hashmap (delete 'Hash) è una funzione molto lenta. Allora proviamo ad eliminare tutti gli elementi della hashmap:

(define (random-sample n k)
  (let ((out '()) (r 0))
    (new Tree 'Hash)
    (while (< (length (Hash)) k)
      (setq r (+ 1 (rand n)))
      (Hash r r)
    )
    (dolist (el (Hash)) (push (el 1) out -1))
    ; delete Hash elements
    (dolist (el out) (Hash el nil))
    ;(delete 'Hash)
    out
  )
)

(random-sample 10 3)
;-> (4 5 6)

Vediamo la velocità:

(time (random-sample1 1000 100) 1000)
;-> 1125.599
(time (random-sample 1000 100) 1000)
;-> 940.62

(time (random-sample1 100000 1000) 100)
;-> 7111.842
(time (random-sample 100000 1000) 100)
;-> 7116.742

Nessun miglioramento sostanziale.


-------------------------------
Funzioni di Mobius e di Mertens
-------------------------------

La funzione di Mobius, indicata con mu(n), è una funzione che trova impiego in teoria dei numeri per classificare i numeri interi positivi in una di tre categorie possibili secondo la scomposizione in fattori.

La funzione viene definita assegnando a μ(n) i seguenti valori:

−1 se n è scomponibile in un numero dispari di fattori primi distinti.
   (se n ha un numero dispari di fattori primi non ripetuti)
Per esempio μ(435) = −1 perché 435 = 3 × 5 × 29, ha tre fattori primi. Per gli scopi di questa funzione, un numero primo è considerato avere un fattore primo, in sé, quindi μ(p) = −1.

0 se n ha uno o più fattori primi ripetuti.
Per esempio μ(436) = 0 perché 436 = 22 × 109 = 2 × 2 × 109, poiché gli esponenti significano che un fattore accade due volte o più nella scomposizione in fattori.

+1 se n è scomponibile in un numero pari di fattori primi distinti.
   (se n ha un numero pari di fattori non ripetuti)
Per esempio μ(437) = 1 perché 437 = 19 × 23. Si assume anche che μ(1) = 1, considerando che abbia una scomposizione in 0 fattori primi.

Per convenzione mu(1) = 1.

Questa è una funzione aritmetica moltiplicativa, cioè se h e k sono interi positivi coprimi, allora risulta: mu(h*k) = mu(h) * mu(k).

Sequenza OESIS: A008683

(setq A008683 '(
 1 -1 -1 0 -1 1 -1 0 0 1 -1 0 -1 1 1
 0 -1 0 -1 0 1 1 -1 0 0 1 0 0 -1 -1
 -1 0 1 1 1 0 -1 1 1 0 -1 -1 -1 0 0
 1 -1 0 0 0 1 0 -1 0 1 0 1 1 -1 0 -1
 1 0 0 1 -1 -1 0 1 -1 -1 0 -1 1 0 0 1 -1))

(length A008683)
;-> 78

(define (mobius n)
  (let (f (factor n))
    (cond ((= n 1) 1)
          ; se n ha fattori primi distinti...
          ((= f (unique f))
           ; se dispari -> -1, altrimenti -> 1
           (if (odd? (length f)) -1 1))
          ;se n ha fattori primi non distinti (ripetuti)
          (true 0))))

(mobius 6)
;-> 1

(= A008683 (map mobius (sequence 1 78)))
;-> true

La funzione di Mertens indicata con M(x) è la sommatoria della funzione di Mobius:

M(x) = Sum[n 1 x] (mu(n))

Sequenza OESIS: A002321

(setq A002321 '(
 1 0 -1 -1 -2 -1 -2 -2 -2 -1 -2 -2 -3 -2
 -1 -1 -2 -2 -3 -3 -2 -1 -2 -2 -2 -1 -1 -1
 -2 -3 -4 -4 -3 -2 -1 -1 -2 -1 0 0 -1 -2
 -3 -3 -3 -2 -3 -3 -3 -3 -2 -2 -3 -3 -2 -2
 -1 0 -1 -1 -2 -1 -1 -1 0 -1 -2 -2 -1 -2
 -3 -3 -4 -3 -3 -3 -2 -3 -4 -4 -4))

(length A002321)
;-> 81

(define (mertens x)
  (apply + (map mobius (sequence 1 x))))

(mertens 3)
;-> -1

(= A002321 (map mertens (sequence 1 81)))
;-> true


---------------------
Quadruple pitagoriche
---------------------

Una quadrupla pitagorica è costituita da quattro numeri interi positivi a, b, c e d tali che a ≤ b ≤ c ≤ d e a² + b² + c² = d². Ad esempio, (2 3 6 7) è una quadrupla pitagorica perché 2² + 3² + 6² = 4 + 9 + 36 = 49 = 7².

Scrivere un programma che conteggi le quadruple pitagoriche con a, b, c minore o uguale a 1000.

(define (isqrt n) (int (sqrt n)))

(define (pyquad n)
  (local (a b c d s out)
    (for (a 1 n)
      (for (b a n)
        (for (c b n)
          (setq s (+ (* a a) (* b b) (* c c)))
          (setq d (isqrt s))
          (if (= (* d d) s) (push (list a b c d) out -1)))))
    out))

(time (setq pq (pyquad 1000)))
;-> 59196.872

(length pq)
;-> 85490

(slice pq 0 20)
;-> ((1 2 2 3) (1 4 8 9) (1 6 18 19) (1 8 32 33) (1 10 50 51)
;->  (1 12 12 17) (1 12 72 73) (1 14 98 99) (1 16 128 129)
;->  (1 18 30 35) (1 18 162 163) (1 20 200 201) (1 22 46 51)
;->  (1 22 242 243) (1 24 288 289) (1 26 338 339) (1 28 76 81)
;->  (1 28 392 393) (1 30 450 451) (1 32 100 105))

Test del risultato:

(define (test a b c d)
  (= (* d d) (+ (* a a) (* b b) (* c c))))

(test 36 399 448 601)
;-> true

(dolist (el pq)
  (if (= (test (el 0) (el 1) (el 2) (el 3)) true)
    (println el)))


-------------------------
Lista dei contesti attivi
-------------------------

Per generare la lista di tutti i contesti (context) definiti nella sessione corrente possiamo utilizzare la seguente funzione:

(define (contexts-lst)
  (filter context? (map eval (symbols))))

(contexts-lst)
;-> (Class MAIN Tree)

Nota: i simboli che rappresentano i contesti si trovano sempre nel contesto MAIN.

------------------------------
Conversione lista <--> stringa
------------------------------

(setq lst '(1 a 2 b 3 c))

(define (lst2str lst)
  (join (map string lst) " "))

(lst2str lst)
;-> "1 a 2 b 3 c"

(define (str2lst str)
  (map sym (parse str)))

(str2lst "1 a 2 b 3 c")
;-> (1 a 2 b 3 c)


----------------
Funzione butlast
----------------

Questa funzione restituisce la lista o la stringa passata senza gli ultimi n elementi (default n=1):

(define (butlast list-or-string n)
  (chop list-or-string (or n 1)))

(butlast "pippo" 2)
;-> "pip"

(butlast '(1 2 3 4 5))
;-> (1 2 3 4)


-----------------------------------------
Lista di tutte le partizioni di un numero
-----------------------------------------

Dato un numero intero positivo n, generare tutti i modi unici possibili per rappresentare n come somma di numeri interi positivi.

La soluzione crea una lista con tutte le partizioni ordinate (anche i numeri di ogni partizione sono ordinati). Il metodo è quello di ottenere la partizione successiva usando i valori della partizione corrente. Memorizziamo ogni partizione in un vettore "part". Inizializziamo part[0] a n, dove n è il numero di input. Ad ogni iterazione inseriamo la partizione corrente (cioè il vettore "part") nella lista e quindi aggiorniamo il vettore "part" per memorizzare la partizione successiva. Quindi il problema principale è ottenere la partizione successiva da una determinata partizione.

I passaggi per ottenere la partizione successiva dalla partizione corrente sono i seguenti:
- Ci viene data la partizione corrente in "part" e le sue dimensioni.
- Dobbiamo aggiornare "part" per memorizzare la prossima partizione.
- I valori in "part" devono essere ordinati in ordine non crescente.

1) Trovare il valore (non-uno) (cioè diverso da 1) più a destra in "part" e memorizzare il conteggio di 1 incontrati prima di un valore non-uno in una variabile temp-value (Indica la somma dei valori sul lato destro che devono essere aggiornati). Assegna alla variabile k il valore dell'indice relativo al numero non-uno.

2) Diminuire il valore di part[k] di 1 e aumentare temp-value di 1.
Ora ci possono essere due casi:
a) Se part[k] è maggiore o uguale a temp-value. Questo è un caso semplice (abbiamo il corretto ordine in una nuova partizione). Assegnare temp-value a part[k + 1] e part[0..(k + 1)] è la nostra nuova partizione.
b) Altrimenti (questo è un caso interessante, considera part[] iniziale come [3, 1, 1, 1], part[k] è diminuito da 3 a 2, temp-value è aumentato da 3 a 4, la partizione successiva vale essere [2, 2, 2]).

3) Copiare part[k] nella posizione successiva, incrementare k e ridurre il conteggio di part[k] fino a che part[k] è inferiore a temp-value. Infine, assegnare temp-value a part[k + 1] e part[0..(k + 1)] è la nostra nuova partizione. Questo passaggio è come dividere temp-value in termini di part[k] (4 è diviso in 2 parti).

Vediamo l'implementazione dell'algoritmo:

(define (partnumber n)
  (catch
  (local (part k temp-value out)
    (setq out '())
    (setq part (array n '(0)))
    (setq k 0)
    (setf (part k) n)
    ; Questo ciclo prima aggiunge la partizione corrente alla lista
    ; poi genera la partizione successiva.
    ; Il ciclo termina quando la partizione corrente è costituita da tutti 1.
    (while true
      ; Aggiunge la partizione corrente alla lista delle soluzioni
      (push (slice part 0 (+ k 1)) out -1)
      ;
      ; Genera la partizione successiva
      ;
      ; Trova il valore non-uno più a destra di part[]
      ; Aggiorna anche il valore di temp-value
      ; (cioè quanti valori possono essere inseriti)
      (setq temp-value 0)
      (while (and (>= k 0) (= (part k) 1))
        (setq temp-value (+ temp-value (part k)))
        (-- k)
      )
      ; se k < 0, tutti i valori valgono 1
      ; quindi non ci sono altre partizioni da generare
      (if (< k 0) (throw out))
      ; Decrementa part[k] trovato sopra e calcola il valore di temp-value
      (setf (part k) (- (part k) 1))
      (++ temp-value)
      ; Se rem_val è maggiore, allora l'ordine è violato.
      ; Divide temp-value in diversi valori di dimensione part[k] e
      ; copia questi valori in posizioni diverse dopo part[k]
      (while (> temp-value (part k))
        (setf (part (+ k 1)) (part k))
        (setq temp-value (- temp-value (part k)))
        (++ k)
      )
      ; Copia rem_val nella posizione successiva e incrementa la posizione
      (setf (part (+ k 1)) temp-value)
      (++ k)
    )
  );local
  );catch
)

Proviamo la funzione:

(partnumber 1)
;-> ((1))

(partnumber 3)
;-> ((3) (2 1) (1 1 1))

(partnumber 5)
;-> ((5) (4 1) (3 2) (3 1 1) (2 2 1) (2 1 1 1) (1 1 1 1 1))

(length (partnumber 40))
;-> 37338

Possiamo usare anche la ricorsione per risolvere questo problema. Consideriamo ogni intero i da 1 a n e lo aggiungiamo all'output e poi usiamo la ricorsione per gli elementi rimanenti [i..n] con somma ridotta n-i. Per evitare di generare una permutazione, ogni combinazione viene costruita in ordine non decrescente. Se si raggiunge una combinazione con la somma data, allora la aggiungiamo all'elenco delle soluzioni.

(define (part-aux i num idx)
  (if (zero? num)
      ; se la somma diventa num, aggiungi questa soluzione
      (push (slice lst 0 idx) out -1)
  )
  ; necessario per evitare che il ciclo "for"
  ; sia operativo anche quando (i > num)
  ; (conteggio inverso)
  (if (<= i num) (begin
      ; inizia dall'elemento precedente nella combinazione fino a num
      (for (j i num)
        ;assegna l'elemento corrente all'indice corrente
        (setf (lst idx) j)
        ; ricorsione con somma ridotta
        (part-aux j (- num j) (+ idx 1))))))

(define (partition num)
  (local (lst out)
    (setq lst (array num '(0)))
    (setq out '())
    (part-aux 1 num 0)
    out))

(partition 5)
;-> ((5) (4 1) (3 2) (3 1 1) (2 2 1) (2 1 1 1) (1 1 1 1 1))

(length (partition 40))
;-> 37338

Vediamo la differenza di velocità delle due funzioni:

(time (println (length (partition 60))))
;-> 966467
;-> 2166.237
(time (println (length (partnumber 60))))
;-> 966467
;-> 3125.434

(time (println (length (partition 80))))
;-> 15796476
;-> 51805.942

(time (println (length (partnumber 80))))
;-> 15796476
;-> 94370.516

La versione ricorsiva è più veloce.

Se vogliamo trovare solo il numero di partizioni (senza generarle tutte) la situazione è abbastanza complicata. Non si conosce un metodo per calcolare esattamente il numero di partizioni di un dato numero n, cioè una funzione o un algoritmo per calcolare p(n) direttamente. Comunque esiste una definizione ricorsiva di p(n) che permette di calcolarla utilizzando i valori precedenti.

Su wikipedia si trova che la funzione generatrice per p(n) vale:

p(n) = p(n - 1) + p(k - 2) - p(k - 5) - p(k - 7) + p(k - 12) + p(k - 15) - p(k - 22) ...

dove p(0) = 1 e p(n) = 0 per n < 0.

La sequenza dei numeri k da utilizzare è data dalla formula dei numeri pentagonali generalizzati:

f(k) = k*(3k-1)/2 che vale sia per k negativo che per k positivo.

Questa formula può essere generata nel modo seguente:

    | (m/2 + 1)    se (k mod 2) = 0,
k = |
    | (-m/2 - 1)   altrimenti

I segni della funzione seguono lo schema +, +, -, -, +, +, -, -,...

Quindi partendo dal primo valore della sequenza possiamo calcolare quella successiva e cosi via.

(define (part-num num)
  (local (n p-vec segno penta i j val)
    (setq p-vec (array (+ num 1) '(0)))
    (setf (p-vec 0) 1)
    (setq n 1)
    (while (<= n num)
      (setq i 0)
      (setq penta 1)
      (while (<= penta n)
        (if (> (% i 4) 1)
            (setq segno -1)
            (setq segno 1))
        (setf (p-vec n) (+ (p-vec n) (* segno (p-vec (- n penta)))))
        (++ i)
        (if (zero? (% i 2))
            (setq j (+ (/ i 2) 1))
            (setq j (- (+ (/ i 2) 1))))
        (setq penta (/ (* j (- (* 3 j) 1)) 2))
      )
      (++ n)
    )
    p-vec))

(part-num 50)
;-> (1 1 2 3 5 7 11 15 22 30 42 56 77 101 135 176 231 297 385 490
;->  627 792 1002 1255 1575 1958 2436 3010 3718 4565 5604 6842
;->  8349 10143 12310 14883 17977 21637 26015 31185 37338 44583
;->  53174 63261 75175 89134 105558 124754 147273 173525 204226)

Sequenza OEIS: A000041
a(n) is the number of partitions of n (the partition numbers).
  1, 1, 2, 3, 5, 7, 11, 15, 22, 30, 42, 56, 77, 101, 135, 176, 231, 297, 385,
  490, 627, 792, 1002, 1255, 1575, 1958, 2436, 3010, 3718, 4565, 5604, 6842,
  8349, 10143, 12310, 14883, 17977, 21637, 26015, 31185, 37338, 44583, 53174,
  63261, 75175, 89134, 105558, 124754, 147273, 173525, ...

(time (println (part-num 100)))
;-> (1 1 2 3 5 7 11 15 22 30 42 56 77 101 135 176 231 297 385
;-> ...
;-> 104651419 118114304 133230930 150198136 169229875 190569292)
;-> 10.068

Nel 1918 il matematico indiano Ramanujan propose la seguente formula per calcolare il numero di partizioni di un numero n:

  p(n) ≈ (1/(4*n*sqrt(3)))*exp(pi*sqrt(2*n/3)) per n -> Infinto

(setq pi 3.1415926535897931)
(define (p n)
  (if (zero? n) 1
  (int (mul (div (mul 4 n (sqrt 3))) (exp (mul pi (sqrt (div (mul 2 n) 3))))))))

(map p (sequence 0 50))
;-> (1 1 2 4 6 8 12 18 25 35 48 64 86 115 151 198 257 332 427 545 692
;->  875 1101 1381 1724 2145 2659 3285 4045 4967 6080 7422 9036 10973
;->  13293 16064 19369 23303 27977 33519 40080 47833 56981 67756 80431
;->  95315 112770 133210 157114 185030 217590)

Vediamo come varia l'errore relativo:

  Errore relativo = Errore Assoluto / valore vero

Valori veri:

(setq valori (part-num 50))
(length valori)
;-> 51

Valori calcolati con la formula di Ramanujan:

(setq misure (map p (sequence 0 50)))
(length misure)
;-> 51

Errore relativo:

(setq err-rel (map (fn(x y)
  (format "%.4f" (div (abs (sub x y)) x) )) valori misure))
;-> ("0.0000" "0.0000" "0.0000" "0.3333" "0.2000" "0.1429" "0.0909" "0.2000"
;->  "0.1364" "0.1667" "0.1429" "0.1429" "0.1169" "0.1386" "0.1185" "0.1250"
;->  "0.1126" "0.1178" "0.1091" "0.1122" "0.1037" "0.1048" "0.0988" "0.1004"
;->  "0.0946" "0.0955" "0.0915" "0.0914" "0.0880" "0.0881" "0.0849" "0.0848"
;->  "0.0823" "0.0818" "0.0799" "0.0794" "0.0774" "0.0770" "0.0754" "0.0748"
;->  "0.0734" "0.0729" "0.0716" "0.0711" "0.0699" "0.0693" "0.0683" "0.0678"
;->  "0.0668" "0.0663" "0.0654")

L'errore diminuisce al crescere di n.


---------------------------
Algoritmo di Euclide esteso
---------------------------

MCD -> Massimo Comun Divisore
GCD -> Greatest Common divisor

Mentre l'algoritmo euclideo calcola solo il massimo comune divisore (MCD) di due interi a e b, la versione estesa trova anche un modo per rappresentare MCD in termini di a e b, cioè coefficienti x e y per i quali:

a*x + b*y = mcd(a, b)

Da notare che possiamo sempre trovare una tale rappresentazione, ad esempio mcd(55,80) = 5 quindi possiamo rappresentare 5 come una combinazione lineare con i termini 55 e 80:

55*3 + 80*(−2) = 5

Versione generale:

(define (gcdex a b)
  (local (x y lastx lasty temp)
    (setq x 0)
    (setq y 1)
    (setq lastx 1)
    (setq lasty 0)
    (while (not (zero? b))
      (setq q (/ a b))
      (setq r (% a b))
      (setq a b)
      (setq b r)
      (setq temp x)
      (setq x (- lastx (* q x)))
      (setq lastx temp)
      (setq temp y)
      (setq y (- lasty (* q y)))
      (setq lasty temp)
    )
    ; Adesso la variabile a contiene il valore di gcd
    ;(println a { } b { } x { } y { } lastx { } lasty)
    (list a lastx lasty)))

(gcdex 120 23)
;-> (1 -9 47)

(gcdex 8 -6)
;-> (2 1 1)

Versione alternativa:

(define (gcd-coeff x y)
  (local (q temp q11 q12 q22 t11 t22)
    (set 'q11 1 'q22 1 'q12 0 'q21 0)
    (until (zero? y)
      (setq temp y)
      (setq q (/ x y))
      (setq y (% x y))
      (setq x temp)
      (setq t21 q21)
      (setq t22 q22)
      (setq q21 (- q11 (* q q21)))
      (setq q22 (- q12 (* q q22)))
      (setq q11 t21)
      (setq q12 t22)
    )
    (list x q11 q12)))

(gcd-coeff 120 23)
;-> (1 -9 47)

(gcd-coeff 8 -6)
;-> (2 1 1)

Versione equivalente (più lenta):

(define (extended-euclid a b)
  (local (x0 y0 x y d)
  (cond ((zero? b) (list a 1 0))
        (true
          (map set '(d x0 y0) (extended-euclid b (% a b)))
          (map set '(x y) (list y0 (- x0 (* (/ a b) y0))))
          (list d x y)))))

(extended-euclid 120 23)
;-> (1 -9 47)

(extended-euclid 8 -6)
;-> (2 1 1)

Versione ricorsiva:

(define (gcd-ext a b)
    (cond ((zero? b)
           (setq x 1 y 0)
           a)
          (true
           (setq g (gcd-ext b (% a b)))
           (setq x1 x y1 y)
           (setq x y1)
           (setq y (- x1 (mul y1 (div a b))))
           (abs g)
    ))

(gcd-ext 18 24)
;-> 6

Versione iterativa:

(define (gcd-ext a b)
  (local (x y x1 y1 a1 b1 q)
    (setq x 1 y 0 x1 0 y1 1 a1 a b1 b)
    (while (!= b1 0)
      (setq q (/ a1 b1))
      (map set '(x x1) (list x1 (- x (* q x1))))
      (map set '(y y1) (list y1 (- y (* q y1))))
      (map set '(a1 b1) (list b1 (- a1 (* q b1))))
    )
    (abs a1)))

(gcd-ext 18 24)
;-> 6

(gcd-ext 18 -24)
;-> 6

(gcd-ext 15 -18)
;-> 3

(gcd-ext 4 -12)
;-> 4

(gcd-ext 0 12)
;-> 12

(gcd-ext -2 0)
;-> 2

Nota: Il gcd non cambia in caso di cambio di segno dei numeri:

gcd (a,b) = gcd (a,-b)= gcd (-a,b) = gcd (-a,-b)


----------------------------------
Punti casuali in una circonferenza
----------------------------------

La seguente funzione genera n punti casuali (x,y) interni ad un cerchio di raggio predefinito con centro in C(raggio, raggio).

(define (rand-xy-circle raggio n)
  (local (x y cx cy out i)
    (setq out '())
    (setq i 1)
    (while (<= i n)
      (setq x (mul (random) (mul raggio 2)))
      (setq y (mul (random) (mul raggio 2)))
      (if (< (add (mul (sub x raggio) (sub x raggio))
                  (mul (sub y raggio) (sub y raggio)))
              (mul raggio raggio))
          (begin
            (push (list x y) out -1)
            (++ i)))
    )
    out))

Possiamo verificare il risultato utilizzando un foglio elettronico:
1) generare e salvare n punti casuali
   (setq punti (rand-xy-circle 50 100))
   (save "punti.txt" 'punti)
2) importare il file punti.txt su un foglio elettronico
3) modificare il foglio in modo che ci siamo due colonne (una per la coordinata x e una per la coordinata y)
3) generare un grafico scatter-plot (x,y) con le coordinate dei punti.

Potremmo calcolare questi punti casuali utilizzando le coordinate polari (r,theta):

(define (rand-xy-circle raggio n)
  (local (x y cx cy r theta out)
    (setq out '())
    (for (i 1 n)
      (setq r (mul (random) raggio))
      (setq theta (mul (random) (mul 2 3.141592653589793)))
      (setq x (add raggio (mul r (cos theta))))
      (setq y (add raggio (mul r (sin theta))))
      (push (list x y) out -1)
    )
    out))

(setq punti (rand-xy-circle 5 10000))
(save "punti-polar.txt" 'punti)

Purtroppo questo metodo non è corretto, in quanto i punti tendono a concentrarsi intorno al centro della circonferenza.

Possiamo però "correggere" la densità dei punti moltiplicando le coordinate x e y per sqrt(r) e ripristinando una distribuzione uniforme:

(define (rand-xy-circle raggio n)
  (local (x y cx cy r theta out)
    (setq out '())
    (for (i 1 n)
      (setq r (mul (random) raggio))
      (setq theta (mul (random) (mul 2 3.141592653589793)))
      ;(setq x (add raggio (mul r (cos theta))))
      (setq x (add raggio (mul (sqrt r) (cos theta))))
      ;(setq y (add raggio (mul r (sin theta))))
      (setq y (add raggio (mul (sqrt r) (sin theta))))
      (push (list x y) out -1)
    )
    out))

(setq punti (rand-xy-circle 5 10000))
(save "puntos.csv" 'punti)

I risultati sono visibili nell'immagine "punti-cerchio.png" che si trova nella cartella "data".)


---------------------------------
Esponenziazione (potenza) binaria
---------------------------------

L'esponenziazione binaria (nota anche come esponenziazione per quadratura) è un trucco che consente di calcolare una potenza utilizzando solo O(log n) moltiplicazioni (invece delle O(n) richieste dall'approccio normale).
Questo metodo può essere utilizzato con qualsiasi operazione che abbia la proprietà dell'associatività:

(X op Y) op Z = X op (Y op Z)

Elevare a alla potenza di n è espresso ingenuamente come moltiplicazione per a fatto n − 1 volte: a*n = a*a* ... *a. Tuttavia, questo approccio non è pratico per grandi valori di a o n.

a^(b+c) = a^b * a^c  e  a^(2b) = a^b * a^b = (a^b)^2

L'idea dell'esponenziazione binaria è quella di suddividere le operazioni usando la rappresentazione binaria dell'esponente.

Scriviamo n in base 2, ad esempio:

3^13 = 3^(1101) = 3^8 * 3^4 * 3^1

Poiché il numero n ha esattamente |log2 n| + 1 cifre in base 2, dobbiamo solo eseguire O(log n) moltiplicazioni, se conosciamo le potenze a^1, a^2, a^4, a^8,…, a^|(log n)|.

Quindi abbiamo solo bisogno di conoscere un modo veloce per calcolarli. Fortunatamente questo è molto semplice, poiché un elemento nella sequenza è solo il quadrato dell'elemento precedente.

3^1 = 3
3^2 = (3^1)^2 = 3^2 = 9
3^4 = (3^2)^2 = 9^2 = 81
3^8 = (3^4)^2 = 81^2 = 6561

Quindi, per ottenere la risposta finale per 3^13, dobbiamo solo moltiplicarne tre di loro (saltando 3^2 perché il bit corrispondente in n non è impostato): 313 = 6561 * 81 * 3 = 1594323

La complessità finale di questo algoritmo è O(log n): dobbiamo calcolare (log n) potenze di a, quindi dobbiamo fare al massimo (log n) moltiplicazioni per ottenere la risposta finale.

Il seguente approccio ricorsivo esprime la stessa idea:

se n=0             ==>   a^n = 1

se n>0 e pari      ==>   a^n = (a^(n/2))^2

se n>0 e dispari   ==>   a^n = (a^((n-1)/2))^2

Versione ricorsiva:

(define (bin-pow-rec a b)
  (let (res 1L)
  (cond ((= b 0) 1)
        (true
          (setq res (bigint (bin-pow-rec a (/ b 2))))
          (if (= (% b 2) 1)
              (* res res a)
              (* res res))))))

(bin-pow-rec 2L 4L)
;-> 16L
(bin-pow-rec 7L 253L)
;-> 64536309039243386456273720567782680383746852777261605536920302
;-> 93074941615183644305679310302734520060591237478898870576089992
;-> 31319516198255060066433347506256253995870956010633721063187612
;-> 1518137796636277520794018407L

Versione iterativa:

(define (bin-pow a b)
  (let (res 1L)
    (while (> b 0)
      (if (= (% b 2) 1)
          (setq res (* res a)))
      (setq a (* a a))
      (setq b (/ b 2))
    )
  res))

(bin-pow 7L 253L)
;-> 64536309039243386456273720567782680383746852777261605536920302
;-> 93074941615183644305679310302734520060591237478898870576089992
;-> 31319516198255060066433347506256253995870956010633721063187612
;-> 1518137796636277520794018407L

Vediamo un'applicazione di questo metodo calcolando in modo efficiente una potenza modulo un numero. In altre parole, il problema è quello di calcolare (a^b mod m).

Poiché l'operatore modulo non interferisce con la moltiplicazione:

(a*b mod m) = ((a mod m) * (b mod m)) mod m)

(% (* 5 6) 4)
;-> 2
(* (% 5 4) (% 6 4))
;-> 2

(% (* 11 76) 14)
;-> 10
(% (* (% 11 14) (% 76 14)) 14)
;-> 10

possiamo utilizzare direttamente lo stesso codice della versione iterativa e sostituire semplicemente ogni moltiplicazione con una moltiplicazione modulare:

(define (bin-pow-mod a b m)
  (let (res 1L)
    (setq a (% a m))
    (while (> b 0)
      (if (= (% b 2) 1)
          (setq res (* res (% a m))))
      (setq a (* a (% a m)))
      (setq b (/ b 2))
    )
  res))

Per ottenere il risultato come big-integer occorre passare gli argomenti come big-integer.

(bin-pow-mod 7L 111L 6L)
;-> 1L


----------------------
Permutazioni circolari
----------------------

Le permutazioni circolari sono un tipo particolare di permutazioni semplici. Quando gli elementi di una permutazione sono disposti in maniera circolare, in modo che non sia possibile individuare il primo e l'ultimo elemento, si parla di permutazione ciclica o circolare o in linea chiusa.

Il numero delle permutazioni circolari di n oggetti vale: (n - 1)!

Vediamo la dimostrazione seguendo un esempio:

lista = A B C
permutazioni semplici = (A B C) (B A C) (B C A) (A C B) (C A B) (C B A)

Se rappresentiamo queste permutazioni intorno ad un cerchio, notiamo che alcune di loro sono equivalenti:

      A           B           B           A           C           C
    C   B       C   A       A   C       B   C       B   A       A   B
     (1)         (2)         (3)         (4)         (5)         (6)

La (1), la (3) e la (5) sono equivalenti (sono tutte rotazioni una dell'altra).
La (2), la (4) e la (6) sono equivalenti (sono tutte rotazioni una dell'altra).

Quindi abbiamo solo due permutazioni circolari uniche. Poichè il numero di permutazioni semplici vale n!, ed ogni permutazione semplice ha n permutazioni circolari equivalenti, possiamo calcolare il numero di permutazioni circolari in questo modo:

numero_permutazioni_circolari(n) = numero_permutazioni_semplici(n) / n = n!/n = (n - 1)!

Le permutazioni circolari possono essere generate tenendo fisso un elemento e calcolando le permutazioni semplici degli altri elementi. Questo metodo produce il seguente algoritmo:

1) estrarre il primo elemento della lista originale
2) calcolare tutte le permutazioni della lista senza il primo elemento
3) aggiungere il primo elemento della lista originale di fronte ad ogni permutazione semplice.

Funzione che calcola le permutazioni semplici:

(define (perm lst)
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

(perm '(A B C))
;-> ((A B C) (B A C) (C A B) (A C B) (B C A) (C B A))

Adesso scriviamo la funzione per il calcolo delle permutazioni circolari:

(define (perm-circ lst)
  (let (head (pop lst))
    (sort (map (fn(x) (push head x)) (sort (perm lst))))))

(perm-circ '(A B C))
;-> ((A B C) (A C B))

Verifichiamo i risultati della nostra funzione confrontandoli con quelli esatti contenuti nelle liste test4, test5 e test6.

(setq test4 '((A B C D) (A B D C) (A C B D) (A C D B) (A D B C) (A D C B)))

(= (perm-circ '(A B C D)) test4)
;-> true

(setq test5 '((A B C D E) (A B C E D) (A B D C E) (A B D E C) (A B E C D) (A B E D C) (A C B D E)
(A C B E D) (A C D B E) (A C D E B) (A C E B D) (A C E D B) (A D B C E) (A D B E C) (A D C B E)
(A D C E B) (A D E B C) (A D E C B) (A E B C D) (A E B D C) (A E C B D) (A E C D B) (A E D B C) (A E D C B)))

(= (perm-circ '(A B C D E)) test5)
;-> true

(setq test6
'((A B C D E F) (A B C D F E) (A B C E D F) (A B C E F D) (A B C F D E)
  (A B C F E D) (A B D C E F) (A B D C F E) (A B D E C F) (A B D E F C)
  (A B D F C E) (A B D F E C) (A B E C D F) (A B E C F D) (A B E D C F)
  (A B E D F C) (A B E F C D) (A B E F D C) (A B F C D E) (A B F C E D)
  (A B F D C E) (A B F D E C) (A B F E C D) (A B F E D C) (A C B D E F)
  (A C B D F E) (A C B E D F) (A C B E F D) (A C B F D E) (A C B F E D)
  (A C D B E F) (A C D B F E) (A C D E B F) (A C D E F B) (A C D F B E)
  (A C D F E B) (A C E B D F) (A C E B F D) (A C E D B F) (A C E D F B)
  (A C E F B D) (A C E F D B) (A C F B D E) (A C F B E D) (A C F D B E)
  (A C F D E B) (A C F E B D) (A C F E D B) (A D B C E F) (A D B C F E)
  (A D B E C F) (A D B E F C) (A D B F C E) (A D B F E C) (A D C B E F)
  (A D C B F E) (A D C E B F) (A D C E F B) (A D C F B E) (A D C F E B)
  (A D E B C F) (A D E B F C) (A D E C B F) (A D E C F B) (A D E F B C)
  (A D E F C B) (A D F B C E) (A D F B E C) (A D F C B E) (A D F C E B)
  (A D F E B C) (A D F E C B) (A E B C D F) (A E B C F D) (A E B D C F)
  (A E B D F C) (A E B F C D) (A E B F D C) (A E C B D F) (A E C B F D)
  (A E C D B F) (A E C D F B) (A E C F B D) (A E C F D B) (A E D B C F)
  (A E D B F C) (A E D C B F) (A E D C F B) (A E D F B C) (A E D F C B)
  (A E F B C D) (A E F B D C) (A E F C B D) (A E F C D B) (A E F D B C)
  (A E F D C B) (A F B C D E) (A F B C E D) (A F B D C E) (A F B D E C)
  (A F B E C D) (A F B E D C) (A F C B D E) (A F C B E D) (A F C D B E)
  (A F C D E B) (A F C E B D) (A F C E D B) (A F D B C E) (A F D B E C)
  (A F D C B E) (A F D C E B) (A F D E B C) (A F D E C B) (A F E B C D)
  (A F E B D C) (A F E C B D) (A F E C D B) (A F E D B C) (A F E D C B)))

(= (perm-circ '(A B C D E F)) test6)
;-> true


------------------------------
Crivello di Eratostene Lineare
------------------------------

Vediamo un algoritmo che utilizza il crivello Eratostene per calcolare tutti i numeri primi fino a n.
L'algoritmo è stato preso dal seguente articolo:
David Gries, Jayadev Misra. A Linear Sieve Algorithm for Finding Prime Numbers [1978]

(define (euclide-linear n)
  (local (lp pr j)
    (setq lp (array (+ n 1) '(0)))
    (setq pr '())
    (for (i 2 n)
      (if (zero? (lp i))
        (begin
          (setf (lp i) i)
          (push i pr -1)
        )
      )
      ;(println "lp= " lp)
      ;(println "pr= " pr)
      (setq j 0)
      (while (and (< j (length pr)) (<= (pr j) (lp i)) (<= (* i (pr j)) n))
        (setf (lp (* i (pr j))) (pr j))
        (++ j)
      )
    )
    (println lp)
    pr))

(euclide-linear 100)
;-> (0 0 2 3 2 5 2 7 2 3 2 11 2 13 2 3 2 17 2 19 2 3 2 23 2 5 2 3 2 29
;->  2 31 2 3 2 5 2 37 2 3 2 41 2 43 2 3 2 47 2 7 2 3 2 53 2 5 2 3 2 59
;->  2 61 2 3 2 5 2 67 2 3 2 71 2 73 2 3 2 7 2 79 2 3 2 83 2 5 2 3 2 89
;->  2 7 2 3 2 5 2 97 2 3 2)
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)

L'implementazione è lenta per (n > 1e5), perchè anche se l'algoritmo è lineare (cioè O(n)) noi utilizziamo una lista che ha un tempo di accesso non lineare.

Per verificare questa affermazione è sufficiente analizzare i tempi di esecuzione del seguente esempio:

1) Lista

; Assegnazione di un valore a tutti i 100000 elementi di una lista
(define (lista)
  (let  (lst (sequence 1 100000))
    (for (i 0 99999)
      (setf (lst i) i)
    )
  ))

(time (lista))
;-> 8006.047

Proviamo definendo la lista come variabile globale:

(silent (setq lst (dup 0 100000)))

(define (lista) (for (i 0 99999) (setf (lst i) i)))

(time (lista))
;-> 6824.776

2) Vettore

; Assegnazione di un valore a tutti i 100000 elementi di un vettore
(define (vettore)
  (let  (vet (array 100000 (sequence 1 100000)))
    (for (i 0 99999)
      (setf (vet i) i)
    )
  ))

(time (vettore))
;-> 5.984

Proviamo definendo il vettore come variabile globale:

(silent (setq vet (array 100000 '(0))))

(define (vettore) (for (i 0 99999) (setf (vet i) i)))

(time (vettore))
;-> 0

Come si può notare il vettore è estremamente più veloce di una lista.

Questo risultato porta a considerare un ulteriore aspetto nell'analisi della complessità temporale di un algoritmo: il tempo delle operazioni di lettura e scrittura delle strutture dati utilizzate per implementare l'algoritmo.


----------------------------
Area di un poligono semplice
----------------------------

Calcolare l'area di un poligono semplice (cioè senza autointersezioni) conoscendo tutte le coordinate dei vertici (ordinate in sequenza clockway (cw) o counterclockway (ccw)).

Possiamo attraversare tutti i lati e aggiungere le aree trapezoidali delimitate da ciascun lato e l'asse x. L'area deve essere calcolata con il segno in modo che l'area extra sarà sottratta. La formula è la seguente:

A = ∑(p,q)[(px−qx)*(py+qy)/2]

Questo formula viene chiamata teorema di Shoelace.

Rappresentiamo il poligono come una lista di punti. Ogni punto è una sottolista (x y).

(define (area polygon)
  (local (res)
    (setq res 0)
    (for (i 0 (- (length polygon) 2))
      (setq res (add res
                     (mul (sub (polygon i 0) (polygon (+ i 1) 0))
                          (add (polygon i 1) (polygon (+ i 1) 1)))))
    )
    (abs (div res 2))))

(setq poly '((0 0) (5 0) (5 5) (0 5) (0 0)))
(area poly)
;-> 25

(setq poly '((4 9) (8 9) (14 3) (7 3) (7 6) (4 6) (4 9)))
(area poly)
;-> 33

(setq poly '((2 6) (4 4) (6 6) (8 4) (10 4) (10 1) (9 1) (7 3) (4 3) (2 1) (2 6)))
(area poly)
;-> 20
(area (reverse poly))
;-> 20

Proviamo con due poligoni cartografici in proiezione Gauss-Boaga Fuso Est:

(setq poly
'((2520848.18 4800614.41)
(2520030.65 4800291.95)
(2520382.42 4799998.81)
(2520460.58 4800207.27)
(2520454.07 4799529.79)
(2520600.65 4799777.33)
(2520828.64 4799552.59)
(2521219.49 4799767.56)
(2521151.09 4800148.64)
(2520854.7 4800217.04 )
(2521112 4800389.67   )
(2520587.62 4800327.78)
(2521447.49 4800679.55)
(2520900.3 4800770.75 )
(2520848.18 4800614.41)))

(area poly)
;-> 731651.7139001787

(setq poly
'((2522369.25 4801321.2 )
(2521502.86 4801946.56)
(2521079.44 4801444.97)
(2522232.45 4800526.46)
(2521926.29 4801184.4 )
(2522714.5 4800291.95 )
(2522356.22 4800936.86)
(2522369.25 4801321.2 )))

(area poly)
;-> 882538.1518998221


--------------------
Rango di una matrice
--------------------

Il rango di una matrice è il maggior numero di righe/colonne linearmente indipendenti della matrice. Il rango non è definito solo per le matrici quadrate. Il rango di una matrice può anche essere definito come l'ordine più grande di qualsiasi minore diverso da zero nella matrice.
Lascia che la matrice sia rettangolare e abbia dimensione N × M. Nota che se la matrice è quadrata e il suo determinante è diverso da zero, il rango è N (= M), altrimenti sarà inferiore.
Algoritmo
Cerchiamo il rango usando l'eliminazione gaussiana. Eseguiremo le stesse operazioni di quando vogliamo risolvere il sistema o trovare il suo determinante. Ma se in qualsiasi passaggio nella colonna i-esima non ci sono righe con una elemento non vuota tra quelle che non abbiamo già selezionato, allora saltiamo questo passaggio. Altrimenti, se abbiamo trovato una riga con un elemento diverso da zero nella i-esima colonna durante l'i-esima fase, allora contrassegniamo questa riga come selezionata, aumentiamo il rango di uno (inizialmente il rango è impostato uguale a 0) ed eseguiamo le normali operazioni di rimozione di questa riga dal resto.
Questo algoritmo viene eseguito in O(n3).

(define (rango matrix)
  (local (n m j p rank row-sel eps break)
    (setq eps 1e-9)
    (setq n (length matrix)) ;righe
    (setq m (length (matrix 0))) ;colonne
    (println "n, m = " n {, } m)
    (setq row-sel (array n '(nil)))
    (setq rank 0)
    (for (i 0 (- m 1))
      (setq j 0)
      (setq break nil)
      (while (and (< j n) (not break))
        (if (and (not (row-sel j)) (> (abs(matrix j i)) eps))
            (setq break true)
            (++ j)
        )
      )
      (if (!= j n)
          (begin
            (++ rank)
            (setf (row-sel j) true)
            (if (< i (- m 1))
              (for (p (+ i 1) (- m 1))
                ;(println "j p i: " j { } p { } i)
                (setf (matrix j p) (div (matrix j p) (matrix j i)))
              )
            )
            (for (k 0 (- n 1))
              (if (and (!= k j) (> (abs(matrix k i)) eps))
                  (if (< i (- m 1))
                    (for (p (+ i 1) (- m 1))
                      (setf (matrix k p) (sub (matrix k p) (mul (matrix j p) (matrix k i))))
                    )
                  )
              )
            )
          )
      )
    )
    rank))

(rango '((1 1 1) (2 2 2) (3 3 3)))
;-> 1

(rango '((1 1 2) (4 2 2) (3 8 9)))
;-> 3

(rango '((10 2 -4 -2) (4 2 2 1) (6 0 -6 -3)))
;-> 2


----------------------------------------------
Operazioni tra coppie di elementi di una lista
----------------------------------------------

La seguente funzione applica l'operatore op ad ogni coppia di elementi di una lista:
el(1) op el(2), el(2) op el(3), el(3) op el(4), ..., el(n-1) op el(n)

(define (do-pair lst func rev)
  (if rev
      (map func (chop lst) (rest lst))
      (map func (rest lst) (chop lst))))

quando rev = true:
el(1) op el(2), el(2) op el(3), el(3) op el(4), ..., el(n-1) op el(n)

quando rev = nil:
el(2) op el(1), el(3) op el(2), el(4) op el(3), ..., el(n) op el(n-1)

(do-pair '(4 7 11 16 18) -)
;-> (3 4 5 2)
3 = 7 - 4
4 = 11 - 7
...

(do-pair '(4 7 11 16 18) - true)
;-> (-3 -4 -5 -2)
-3 = 4 - 7
-4 = 7 - 11
...

Possiamo anche passare una funzione utente come operatore:

(define (quad x y) (+ (* x x) (* y y)))

(do-pair '(1 2 3 4) quad)
;-> (5 13 25)


-----------------------------------
Polinomio interpolatore di Lagrange
-----------------------------------

Dato un insieme di n + 1 punti (xi, yi), il polinomio interpolatore di Lagrange è un polinomio di grado <= n, tale che passa attraverso tutti gli n + 1 punti.

Viene calcolato come:

Pn(x) = Sum[i 0 n] (Li(x) * yi)

dove (x0, y0), (x1, y1), ..., (xn, yn) sono gli n + 1 punti dati.

e Li(x) = Prod[j 0 n, j != i] ((x - xj) / (xi - xj))

Possiamo quindi calcolare la coordinata y di un generico valore x utilizzando il polinomio interpolatore di Lagrange:

Vediamo di implementare un programma che trova questo valore y partendo da una lista di punti e da un valore x.

; Funzione che calcola Li(x)
(define (li i n xcoord x)
  (let (prod 1)
    (for (j 0 n)
      (if (!= j i)
        (setq prod (mul prod (div (sub x (xcoord j)) (sub (xcoord i) (xcoord j)))))
      )
    )
    prod))

; Funzione per calcolare Pn(x)
; dove Pn è il polinomio interpolatore di Lagrange di grado n
(define (pn n xcoord ycoord x)
  (let (sum 0)
    (for (i 0 n)
      (setq sum (add sum (mul (li i n xcoord x) (ycoord i))))
    )
    sum))

(define (lagrange xcoord ycoord x)
  (pn (- (length xcoord) 1) xcoord ycoord x))

Proviamo la funzione:

(setq xval '(5 7 11 13 17))
(setq yval '(150 392 1452 2366 5202))
(lagrange xval yval 9.0)
;-> 810

(setq xval '(2 2.75 4))
(setq yval '(0.5 0.363636 0.25))
(lagrange xval yval 3.0)
;-> 0.3295450666666667

(setq pt '((1 1) (2 4) (3 9)))
(setq xval '(1 2 3))
(setq yval '(1 4 9))
(lagrange xval yval 2.5)
;-> 6.25

Adesso possiamo riunire il tutto in una funzione unica:

(define (lagrange lst-pt x)
  (local (sum u l)
    (setq sum 0.0)
    (for (i 0 (- (length lst-pt) 1))
      (setq u 1.0 l 1.0)
      (for (j 0 (- (length lst-pt) 1))
        (if (!= j i)
          (setq u (mul u (sub x (lst-pt j 0)))
                l (mul l (sub (lst-pt i 0) (lst-pt j 0))))
        )
      )
      (setq sum (add sum (mul (div u l) (lst-pt i 1))))
    )
    sum))

(setq pt '((5 150) (7 392) (11 1452) (13 2366) (17 5202)))
(lagrange pt 9.0)
;-> 810 ;809.9

(setq pt '((2 0.5) (2.75 0.363636) (4 0.25)))
(lagrange pt 3.0)
;-> 0.3295450666666667

(setq pt '((1 1) (2 4) (3 9)))
(lagrange pt 2.5)
;-> 6.25

Possiamo anche determinare i coefficienti del polinomio interpolatore di Lagrange:

(define (lagrange-coeff pts)
  (local (coeff newcoeff idx)
    (setq coeff (array (length pts) '(0)))
    (for (m 0 (- (length pts) 1))
      (setq newcoeff (array (length pts) '(0)))
      (if (> m 0)
        (begin
        (setf (newcoeff 0) (sub (div (pts 0 0) (sub (pts m 0) (pts 0 0)))))
        (setf (newcoeff 1) (div 1 (sub (pts m 0) (pts 0 0)))))
        (begin
        (setf (newcoeff 0) (sub (div (pts 1 0) (sub (pts m 0) (pts 1 0)))))
        (setf (newcoeff 1) (div 1 (sub (pts m 0) (pts 1 0)))))
      )
      (setq idx 1)
      (if (= m 0) (setq idx 2))
      (for (n idx (- (length pts) 1))
        (if (!= m n)
          (begin
          (for (nc (- (length pts) 1) 1)
            (setf (newcoeff nc) (add (mul (newcoeff nc) (sub (div (pts n 0) (sub (pts m 0) (pts n 0)))))
                                     (div (newcoeff (- nc 1)) (sub (pts m 0) (pts n 0)))))
          )
          (setf (newcoeff 0) (mul (newcoeff 0) (sub (div (pts n 0) (sub (pts m 0) (pts n 0)))))))
        )
      )
      (for (nc 0 (- (length pts) 1))
        (setf (coeff nc) (add (coeff nc) (mul (pts m 1) (newcoeff nc))))
      )
    )
    coeff))

(setq punti '((2 2) (4 5) (3 -2) (6 0) (7 2) (10 8)))

(lagrange-coeff punti)
;-> (300.5 -360.3511904761905 158.7202380952381 -32.26339285714285 3.05654761904762 -0.1086309523809524)

La soluzione esatta vale:

- 73/672*x^5 + 1027/336*x^4 - 7227/224*x^3 + 26665/168*x^2 - 60539/168*x - 601/2

(div -73 672)
;-> -0.1086309523809524
(div 1027 336)
;-> 3.056547619047619
(div -7227 224)
;-> -32.26339285714285
(div 26665 168)
;-> 158.7202380952381
(div -60539 168)
;-> -360.3511904761905
(div 601 2)
;-> 300.5

(setq punti '((3 2) (4 -1) (2 6) (6 0)))
(lagrange-coeff punti)
;-> (13 -2.166666666666671 -1 0.1666666666666666)

La soluzione esatta vale:  1/6*x^3 - x^2 - 13/6*x + 13

Proviamo con un polinomio conosciuto a priori: 3x^3 - 2x^2 + 5x + 4

(define (poly x) (add (mul 3 x x x) (mul -2 x x) (mul 5 x) 4))
(poly 0)
;-> 4
(poly 1)
;-> 10
(poly 2)
;-> 30
(poly 3)
;-> 82

(lagrange-coeff '((0 4) (1 10) (2 30) (3 82)))
;-> (4 5 -2 2.999999999999998)


-------------------------------
Moltiplicativo modulare inverso
-------------------------------

Un moltiplicativo modulare inverso di un intero a è un intero x tale che a*x è congruente a 1 rispetto al modulo m.  Nella notazione standard dell'aritmetica modulare questa congruenza è scritta come:

a*x ≡ 1 (mod m)

che è il modo abbreviato di scrivere l'affermazione che m divide (esattamente) la quantità a*x - 1, o, in altre parole, il resto dopo aver diviso a*x per l'intero m è 1. In altre parole:

a*x = 1 + k*m (dove k è un numero intero)

Se a ha un modulo inverso m, allora ci sono un numero infinito di soluzioni di questa congruenza che formano una classe di congruenza rispetto a questo modulo.
Si può dimostrare che un tale inverso esiste se e solo se a e m sono coprimi.

(define (modular-multiplicative-inverse a n)
  (local (t nt r nr q tmp out)
    (if (< n 0)
        (setq n (abs n)))
    (if (< a 0)
        (setq a (- n (% (- 0 a) n))))
    (setq t 0)
    (setq nt 1)
    (setq r n)
    (setq nr (mod a n))
    (while (not (zero? nr))
        (setq q (int (div r nr)))
        (setq tmp nt)
        (setq nt (sub t (mul q nt)))
        (setq t tmp)
        (setq tmp nr)
        (setq nr (sub r (mul q nr)))
        (setq r tmp))
    (if (> r 1)
        (setq out nil))
    (if (< t 0)
        (setq out (add t n))
        (setq out t))
    out))

(modular-multiplicative-inverse 42 2017)
;-> 1969


---------------------------
Radice n-esima di un numero
---------------------------

(define (nth-root n a)
  (let ((x1 a)
	(x2 (div a n)))
  (until (= x1 x2)
    (setq x1 x2
	        x2 (div (add (mul x1 (- n 1)) (div a (pow x1 (- n 1))))
		              n))
  )
  x2))

(nth-root 3 8)
;-> 2
(pow 8 (div 3))
;-> 2

(nth-root 25 100)
;-> 1.202264434617413
(pow 100 (div 25))
;-> 1.202264434617413

(nth-root 4 30.5)
;-> 2.350038405769921
(pow 30.5 (div 4))
;-> 2.350038405769921


------------------------------
Prodotto scalare (dot-product)
------------------------------

Funzione per calcolare il prodotto scalare, noto anche come dot-product, di due vettori di lunghezza arbitraria:

(define (dot-product x y)
  (apply add (map mul x y)))

(dot-product '(1 3) '(-2 -1))
;-> -5
(dot-product '(1 3 -5) '(4 -2 -1))
;-> 3

-----------------------------------
Prodotto vettoriale (cross-product)
-----------------------------------

Funzione per calcolare il prodotto vettoriale, noto anche come cross-product, di due vettori in 3 dimesioni:

(define (cross-product x y)
  (let ((xlen (length x)) (ylen (length y)))
    (cond ((or (zero? xlen) (zero? ylen)) '())
          ((or (!= 3 xlen) (!= 3 ylen)) '())
          ((!= xlen ylen) '())
          (true
            (list (sub (mul (x 1) (y 2)) (mul (x 2) (y 1)))
                  (sub (mul (x 2) (y 0)) (mul (x 0) (y 2)))
                  (sub (mul (x 0) (y 1)) (mul (x 1) (y 0))))))))

(cross-product '(3 -5 4) '(2 6 5))
;-> (-49 -7 28)
(cross-product '(2 3 4) '(5 6 7))
(-3 6 -3)


----------------------------------
Angolo tra due direzioni (bearing)
----------------------------------

Trovare l'angolo che è il risultato della sottrazione b2 - b1, dove b1 e b2 sono gli angoli delle direzioni.
Gli angoli di input sono espressi nell'intervallo da -180 a +180 gradi.
Il risultato è espresso nell'intervallo compreso tra -180 e +180 gradi.

(define (bearing b1 b2) (sub (mod (add (mod (sub b1 b2) 360.0) 540.0) 360.0) 180.0))

(bearing- 20 45)
;-> -25
(bearing- -45 45)
;-> -90
(bearing- 85 90)
;-> -5
(bearing- -95 90)
;-> 175

Per la navigazione, potremmo voler sapere se b1 è a sinistra o a destra di b2. (Si presume che esattamente 0 non sia un caso valido)

(define (bearings-left-right b1 b2)
  (if (> (sub (mod (sub (add b1 540) b2) 360) 180) 0)
      'left
      'right))

(bearings-left-right -20 -21)
(bearings-left-right 20 35)
;-> right
(bearings-left-right -95 90)
;-> left


-------------------
URL encoder/decoder
-------------------

URL encoder
-----------
Fornire una funzione per convertire una stringa fornita in una rappresentazione di codifica URL (encode).
Nella codifica URL, caratteri speciali, caratteri di controllo e caratteri estesi vengono convertiti in un simbolo di percentuale seguito da un codice esadecimale a due cifre. Quindi un carattere spazio codifica in %20 all'interno della stringa.

Per gli scopi di questa attività, tutti i caratteri tranne 0-9, A-Z e a-z richiedono la conversione, quindi i seguenti caratteri richiedono tutti la conversione per impostazione predefinita:

Codici di controllo ASCII (intervalli di caratteri 00-1F esadecimale (0-31 decimale) e 7F (127 decimale).
Simboli ASCII (intervalli di caratteri 32-47 decimali (20-2F hex))
Simboli ASCII (intervalli di caratteri 58-64 decimali (3A-40 hex))
Simboli ASCII (intervalli di caratteri 91-96 decimali (5B-60 hex))
Simboli ASCII (intervalli di caratteri 123-126 decimali (7B-7E hex))
Caratteri estesi con codici carattere da 128 decimali (80 esadecimale) e superiori.

Esempio
La stringa "http://foo bar/" verrebbe codificata come "http%3A%2F%2Ffoo%20bar%2F".

;; simple encoder
;; (source http://www.newlisp.org/index.cgi?page=Code_Snippets)
(define (url-encode str)
  (replace {([^a-zA-Z0-9])} str (format "%%%2X" (char $1)) 0))

(url-encode "http://foo bar/")
;-> "http%3A%2F%2Ffoo%20bar%2F"
(url-encode "google.com/search?q=`Abdu'l-Bahá")
;-> "google%2Ecom%2Fsearch%3Fq%3D%60Abdu%27l%2DBah%A0"
(url-decode "google%2Ecom%2Fsearch%3Fq%3D%60Abdu%27l%2DBah%A0")
"google.com/search?q=`Abdu'l-Bahá"


URL decoder
-----------
Il problema (l'opposto della codifica (encode) URL e distinto dal parser URL) è fornire una funzione per convertire una stringa codificata in URL nella sua forma originale non codificata (decode).

Esempi
   La stringa codificata "http% 3A% 2F% 2Ffoo% 20bar% 2F" dovrebbe essere ripristinata nel formato non codificato "http: // foo bar /".
   La stringa codificata "google.com/search?q=%60Abdu%27l-Bah%C3%A1" dovrebbe tornare alla forma non codificata "google.com/search?q=`Abdu'l-Bahá".

;; universal decoder, works for ASCII and UTF-8
;; (source http://www.newlisp.org/index.cgi?page=Code_Snippets)

(define (url-decode url (opt nil))
  (if opt (replace "+" url " "))
  (replace "%([0-9a-f][0-9a-f])" url (pack "b" (int $1 0 16)) 1))

(url-decode "http%3A%2F%2Ffoo%20bar%2F")
;-> "http://foo bar/"
(url-decode "google.com/search?q=%60Abdu%27l-Bah%C3%A1")
;-> "google.com/search?q=`Abdu'l-Bah├í"


-------------------
Funzione "gamma-ln"
-------------------

newLISP fornisce una funzione predefinita per la funzione Gamma.

********************
>>>funzione GAMMALN
********************
sintassi: (gammaln num-x)

Calcola il logaritmo della funzione Gamma in num-x.

(exp (gammaln 6))
;-> 119.9999999999998

L'esempio utilizza l'uguaglianza di n! = gamma (n + 1) per calcolare il valore fattoriale di 5.

La funzione Log Gamma è anche correlata alla funzione Beta, da cui si può derivare:

Beta(z,w) = Exp(Gammaln(z) + Gammaln(w) - Gammaln(z+w))

L'implementazione che segue è stata presa dal libro "Numerical Recipes in C" e convertita in newLISP:

(define (gamma-ln xx)
  (local (x tmp y ser cof)
    (setq cof '(57.1562356658629235 -59.5979603554754912
	14.1360979747417471 -0.491913816097620199 .339946499848118887e-4
	.465236289270485756e-4 -.983744753048795646e-4 .158088703224912494e-3
	-.210264441724104883e-3 .217439618115212643e-3 -.164318106536763890e-3
	.844182239838527433e-4 -.261908384015814087e-4 .368991826595316234e-5))
    (setq x xx y xx)
	  (setq tmp (add x 5.24218750000000000))
	  (setq tmp (sub (mul (add x 0.5) (log tmp)) tmp))
	  (setq ser 0.999999999999997092)
    (for (j 0 13) (setq ser (add ser (div (cof j) (setq y (add y 1))))))
    (add tmp (log (div (mul 2.5066282746310005 ser) x)))
  ))

(gamma-ln 10)
;-> 12.80182748008147
(gammaln 10)
;-> 12.80182748008196

(exp (gamma-ln 6))
;-> 119.9999999999998

Vediamo se le due funzioni danno risultati uguali:

(for (i 1 1000000)
  (if (> (abs (sub (gammaln i) (gamma-ln i))) 1e-8)
   (println i)))
;-> nil

Nota: con l'aumentare del valore dell'argomento, aumenta la differenza tra le due funzioni.

Come al solito la funzione predefinita è molto più veloce:

(time (map gammaln (sequence 1 1000000)))
;-> 80.842

(time (map gamma-ln (sequence 1 1000000)))
;-> 2410.738


----------------------------------
La funzione "select" per i vettori
----------------------------------

La funzione primitiva "select" funziona solo con le liste e le stringhe. Scriviamo una funzione analoga per i vettori:

(setq lst '(3 5 6 7 1 9))
(select lst '(2 4))
;-> (6 1)
(select lst '(-1 0))
;-> (9 3)

(setq vet (array (length lst) lst))
;-> (3 5 6 7 1 9)

Versione iterativa:

(define (select-array arr lst-idx)
  (let (lst-val '())
    (dolist (idx lst-idx)
      (push (arr idx) lst-val -1)
    )
    (array (length lst-val) lst-val)
  )
)

(select-array vet '(0 1))
;-> (3 5)

(select-array vet '(0 1 -1))
;-> (3 5 9)

(select-array vet '(-1 -2 -3 0 1 2))
;-> (9 1 7 3 5 6)

(select-array vet '(3 3 3))
;-> (7 7 7)

(select-array vet '(0 1 6))
;-> ERR: array index out of bounds in function push : 6
;-> called from user function (select-array vet '(0 1 6))

(array? (select-array vet '(4 1)))
;-> true

Versione funzionale:

(define (select-array2 arr lst-idx)
    (array (length lst-idx)
           (map (fn(x) (arr x)) lst-idx))
)

(select-array2 vet '(0 1))
;-> (3 5)

(select-array2 vet '(0 1 -1))
;-> (3 5 9)

(select-array2 vet '(-1 -2 -3 0 1 2))
;-> (9 1 7 3 5 6)

(select-array2 vet '(3 3 3))
;-> (7 7 7)

(select-array2 vet '(0 1 6))
;-> ERR: array index out of bounds in function map : 6
;-> called from user function (select-array2 vet '(0 1 6))

(array? (select-array2 vet '(4 1)))
;-> true

Versione che utilizza "select":

(define (select-array3 arr lst-idx)
  (array (length lst-idx) (select (array-list arr) lst-idx)))

(select-array3 vet '(0 1))
;-> (3 5)

(select-array3 vet '(0 1 -1))
;-> (3 5 9)

(select-array3 vet '(-1 -2 -3 0 1 2))
;-> (9 1 7 3 5 6)

(select-array3 vet '(3 3 3))
;-> (7 7 7)

(select-array3 vet '(0 1 6))
;-> ERR: invalid list index
;-> called from user function (select-array3 vet '(0 1 6))

(array? (select-array3 vet '(4 1)))
;-> true

Vediamo quale delle tre funzioni è la più veloce:

Vettore con centomila elementi (da 1 a 100000)
(silent (setq t (array 100000 (sequence 1 100000))))

Lista con diecimila indici (da 0 a 9999 mischiati)
(silent (setq ind (randomize (sequence 0 9999))))

(time (select-array t ind) 100)
;-> 187.451

(time (select-array2 t ind) 100)
;-> 187.449

(time (select-array3 t ind) 100)
;-> 6375.477

La funzione "select-array3" è molto lenta, allora proviamo la velocità della funzione primitiva "select":

Lista con centomila elementi (da 1 a 100000)
(silent (setq tlist (sequence 1 100000)))

(time (select tlist ind) 100)
;-> 4297.146

Scriviamo una versione di "select" che usa "select-array":

(define (select-list lst lst-idx)
  (array-list (select-array (array (length lst) lst) lst-idx)))

(setq lst '(3 5 6 7 1 9))

(select-list lst '(0 1))
;-> (3 5)

(select-list lst '(0 1 -1))
;-> (3 5 9)

(select-list lst '(-1 -2 -3 0 1 2))
;-> (9 1 7 3 5 6)

(select-list lst '(3 3 3))
;-> (7 7 7)

(select-list lst '(0 1 6))
;-> ERR: array index out of bounds in function push : 6
;-> called from user function (select-array (array (length lst) lst) lst-idx)
;-> called from user function (select-list lst '(0 1 6))

(list? (select-list lst '(4 1)))
;-> true

(time (select-list tlist ind) 100)
;-> 281.184

(div 4297.146 281.184)
;-> 15.282327

La funzione-utente "select-list" è 15 volte più veloce della funzione primitiva "select".

Il risultato è abbastanza strano, quindi facciamo un test con una lista con pochi valori (100):

Lista con cento elementi (da 1 a 100)
(setq alist (sequence 1 100))

Lista con cento indici (da 0 a 99 mischiati)
(setq aind (randomize (sequence 0 99)))

Proviamo la nostra funzione "select-list":
(time (select-list alist aind) 100000)
;-> 1116.293

Proviamo la funzione integrata "select":
(time (select alist aind) 100000)
;-> 294.371

Questa volta è più veloce la funzione integrata.
Quindi con pochi elementi conviene usare "select", mentre con tanti elementi conviene usare "select-list".


-----------------------------
Lunghezza di un numero intero
-----------------------------

Chiamiamo L(n) la lunghezza di un numero intero n.

       10^(d-1) <= n < 10^d
(d - 1)*log(10) <= log(n) < d*log(10)
        (d - 1) <= log(n)/log(10) < d
              d <= log10(n) + 1 < d + 1
              d = floor(1 + log10(n))
           L(n) = floor(1 + log10(n))

Scriviamo la funzione:

(define (len-num n)
  (floor (+ (log (abs n) 10) 1)))

(setq x 1234525454553452)
(len-num x)
;-> 16
La funzione integrata "length" calcola anche la lunghezza di un numero intero:
(length x)
;-> 16

(len-num (- x))
;-> 16
(length (- x))
;-> 16

Se passiamo un numero in virgola mobile, allora viene restituita solo la lunghezza della parte intera:
(length 1.345)
;-> 1
(len-num 1.345)
;-> 1
(length 0.345)
;-> 1
(len-num 0.345)
;-> 1
(length 10.345)
;-> 2
(len-num 10.345)
;-> 2

Vediamo la differenza di velocità:

(time (len-num x) 1000000)
;-> 140.583

(time (length x) 1000000)
;-> 78.098


---------------
Normalizzazione
---------------

Formula generale per normalizzare una lista di numeri nell'intervallo (a,b):

              (val - min-val)*(b - a)
new-val = a + -----------------------
                (max-val - min-val)

Con a=0 e b=1 la formula diventa:

              (val - min-val)
new-val = -----------------------
            (max-val - min-val)

(setq nums '(2 4 10 6 8 4))

(define (normalizza01 lst)
  (local (hi lo out)
    (setq out '())
    (setq hi (apply max lst))
    (setq lo (apply min lst))
    (dolist (val lst)
      (push (div (mul (sub val lo) ((sub hi lo)) out -1))
    out))

(normalizza01 nums)
;-> (0 0.25 1 0.5 0.75 0.25)

Adesso scriviamo la funzione generale:

(define (normalizza lst a b)
  (local (hi lo out)
    (setq out '())
    (setq hi (apply max lst))
    (setq lo (apply min lst))
    (dolist (val lst)
      (push (add a (div (mul (sub val lo) (sub b a)) (sub hi lo))) out -1))
    out))

(normalizza nums 0 1)
;-> (0 0.25 1 0.5 0.75 0.25)

(normalizza nums 100 200)
;-> (100 125 200 150 175 125)

(time (normalizza nums 100 200) 100000)
;-> 171.568

Questo è corretto, ma non efficiente. È una trasformazione lineare, quindi possiamo precalcolare la parte costante e riscrivere la formula:

                                       (b - a)
new-val = a + (val - min-val) * -----------------------
                                  (max-val - min-val)

(define (normalizza lst a b)
  (local (hi lo k out)
    (setq out '())
    (setq hi (apply max lst))
    (setq lo (apply min lst))
    (setq k (div (sub b a) (sub hi lo)))
    (dolist (val lst)
      (push (add a (mul (sub val lo) k)) out -1))
    out))

(normalizza nums 0 1)
;-> (0 0.25 1 0.5 0.75 0.25)

(normalizza nums 100 200)
;-> (100 125 200 150 175 125)

(time (normalizza nums 100 200) 100000)
;-> 128.655


---------
Papersize
---------

Una funzione per calcolare le dimensioni standard dei fogli di carta per la stampa. I risultati sono in milllimetri.

; side: misura del lato (float)
; k: numero del formato (int)
(define (side k)
    (if (< k 2)
        (if (= k 0) s0 s1)       ; misure conosciute
        (div (side (- k 2)) 2))) ; piegando due volte la lunghezza dei lati si dimezza

(define (papersize type k)
  (local (s0 s1)
    (cond ((= type 'A)
           (setq s0 (mul 1000 (pow 2 (div 1 4))))
           (setq s1 (div s0 (sqrt 2))))
          ((= type 'B)
           (setq s0 (mul 1000 (sqrt 2)))
           ;(setq s1 (div s0 (sqrt 2)))
           (setq s1 (mul 1000 1)))
          ((= type 'C)
           (setq s0 (mul 1000 (pow 8 (div 1 8))))
           (setq s1 (div s0 (sqrt 2))))
    )
    (list (side (+ k 1)) (side k))))

(papersize 'A 4)
;-> (210.2241038134286 297.3017787506803)

(for (i 0 10) (println (format "%d %d" ((papersize 'A i) 0) ((papersize 'A i) 1))))
;-> 840 1189
;-> 594 840
;-> 420 594
;-> 297 420
;-> 210 297
;-> 148 210
;-> 105 148
;-> 74 105
;-> 52 74
;-> 37 52
;-> 26 37

(for (i 0 10) (println (format "%d %d" ((papersize 'B i) 0) ((papersize 'B i) 1))))
;-> 1000 1414
;-> 707 1000
;-> 500 707
;-> 353 500
;-> 250 353
;-> 176 250
;-> 125 176
;-> 88 125
;-> 62 88
;-> 44 62
;-> 31 44

(for (i 0 10) (println (format "%d %d" ((papersize 'C i) 0) ((papersize 'C i) 1))))
;-> 917 1296
;-> 648 917
;-> 458 648
;-> 324 458
;-> 229 324
;-> 162 229
;-> 114 162
;-> 81 114
;-> 57 81
;-> 40 57
;-> 28 40


----------------------------------------------
Verificare se due numeri hanno lo stesso segno
----------------------------------------------

Due numeri hanno lo stesso segno se la loro moltiplicazione è maggiore di zero.
Oppure controllando se il test "maggiori di zero" è uguale per entrambi i numeri.

(define (same-sign x y) (= (> x 0) (> y 0)))

(same-sign 2 2)
;-> true
(same-sign -2 2)
;-> nil
(same-sign -2 -2)
;-> true
(same-sign 2 -2)
;-> nil


-------------------------
Suddivisione di una lista
-------------------------

Una funzione per dividere una lista in sotto-liste: data una lista di input da dividere e una lista di lunghezze delle sotto-liste, restituire una lista di sotto-liste che hanno le lunghezze richieste. Ad esempio: dividendo la lista (1 2 2 3 3 3) in sotto-liste di lunghezze (1 2 3) restituire la lista delle sotto-liste ((1) (2 2) (3 3 3)).
Gli eventuali elementi aggiuntivi finali della lista di input vengono ignorati.
Gli eventuali elementi mancanti alla fine della lista di input vengono ignorati.

Vediamo passo-passo come funziona (i = indice iniziale, q = quanti elementi prendere):

(setq lst '(a b c d e))
(setq d '(2 1 2))
(setq i 0 q (d 0))
(slice lst i q)
;-> (a b)

(setq i (+ i q) q (d 1))
(slice lst i q)
;-> (c)

(setq i (+ i q) q (d 2))
(slice lst i q)
;-> (d e)

Adesso possiamo scrivere la funzione finale:

(define (subdivide lst lst-len)
  (let ((i 0) (q 0) (out '()))
    (dolist (el lst-len)
      (setq i (+ i q))
      (setq q el)
      (push (slice lst i q) out -1)
    )
    out))

(setq lst '(a b c d e f))
(setq d '(2 1 2))
(subdivide lst d)
;-> ((a b) (c) (d e))

(setq lst '(a b c d))
(setq d '(2 1 2))
(subdivide lst d)
;-> ((a b) (c) (d))

(setq lst '(a b c d))
(setq d '(5))
(subdivide lst d)
;-> ((a b c d))

(setq lst '(a b c d))
(setq d '(2))
(subdivide lst d)
;-> ((a b))

(setq lst '(a b c d e f g h i j))
(setq d '(1 2 3 4))
(subdivide lst d)
;-> ((a) (b c) (d e f) (g h i j))


-------------------
Stampo di un numero
-------------------

Questa funzione conta le occorrenze di ogni cifra di un numero. Il risultato è un numero intero da una a dieci cifre che chiameremo "stampo". La n-esima cifra del risultato rappresenta quante volte la cifra "n" si ripete nel numero dato.

Esempio: (number-stamp 121232) = 1320
perché "3" appare una volta (1) , "2" tre volte (3), "1" due volte (2) e "0" zero volte (0).

Due numeri che sono permutazione uno dell'altro hanno lo stesso "stampo" (e viceversa).

Scriviamo diverse versioni di questa funzione e poi verifichiamo quale sia la più veloce.

Prima versione:

(define (number-stamp1 num)
  (let ((out 0) (digit 0) (pos 0) (i 0))
    (while (> num 0)
      (setq digit (% num 10))
      (setq num (/ num 10))
      (setq pos 1)
      (if (> digit 0)
          (for (i 1 digit)
            (setq pos (* 10 pos))
          )
      )
      (setq out (+ out pos))
    )
    out))

(number-stamp1 121232)
;-> 1320
(number-stamp1 1234567890)
;-> 1111111111
(number-stamp1 12345678901234567890)
;-> 2222222222

Seconda versione:

(define (number-stamp2 num)
  (let ((lst-num '()) (out 0))
    (while (!= num 0)
      (push (% num 10) lst-num)
      (setq num (/ num 10))
    )
    ; create output number from list of digit's count
    (dolist (el (count '(9 8 7 6 5 4 3 2 1 0) lst-num))
      (setq out (+ el (* out 10)))
    )
    out))

Vediamo se producono risultati uguali:

(= (map number-stamp1 (sequence 1 100000)) (map number-stamp2 (sequence 1 100000)))
;-> true

Terza versione:

(define (number-stamp3 num)
  (let ((ar (array 10 '(0))) (out 0))
    ; fill array with the count of digits
    (while (> num 0)
      (++ (ar (% num 10)))
      (setq num (/ num 10))
    )
    ; create output number from array
    (for (i 9 0)
      (setq out (+ (ar i) (* out 10)))
    )
    out))

Vediamo se producono risultati uguali:

(= (map number-stamp2 (sequence 1 100000)) (map number-stamp3 (sequence 1 100000)))
;-> true

Adesso vediamo i tempi di esecuzione:

(time (map number-stamp1 (sequence 1 1000000)))
;-> 2534.422

(time (map number-stamp2 (sequence 1 1000000)))
;-> 2437.09

(time (map number-stamp3 (sequence 1 1000000)))
;-> 1900.202

La terza versione è la più veloce.


------------------------------
Conversione vettore <--> lista
------------------------------

Per convertire un vettore in una lista abbiamo una funzione primitiva "array-list":

(setq vet (array 6 '(1 3 3 9 2 8)))
(setq lst (array-list vet))
;-> (1 3 3 9 2 8)

(list? lst)
;-> true
(array? lst)
;-> nil
(list? vet)
;-> nil
(array? vet)
;-> true

Per convertire una lista in un vettore scriviamo una funzione "list-array" utilizzando il metodo di assegnazione di valori ad un vettore durante la sua creazione:

(define (list-array lst)
  (array (length lst) lst))

(setq lst '(1 2 3 4 5))
(setq vet (list-array lst))
;-> (1 2 3 4 5)

(list? lst)
;-> true
(array? lst)
;-> nil
(list? vet)
;-> nil
(array? vet)
;-> true


----
one?
----

La seguente funzione non serve a niente, è solo per estetica, ma a me piace.

(define (one? num) (= num 1))

(one? 1)
;-> true
(one? 1.0)
;-> true
(one? 0)
;-> nil


----------------------------
Algoritmo Knuth-Morris-Pratt
----------------------------

L'algoritmo di Knuth-Morris-Pratt (algoritmo KMP) permette di trovare le occorrenze di una stringa (pattern di ricerca) S in un testo T. La caratteristica consiste nel pretrattamento della stringa da cercare in modo che, in caso di non-corrispondenza, non sia necessario riesaminare i caratteri precedenti. Questo permette all'algoritmo di minimizzare il numero di confronti necessari. La complessità temporale vale O(n+k), dove n è la lunghezza del testo e k è la lunghezza della stringa.

L'algoritmo è stato inventato da Knuth e Pratt, e indipendentemente da J. H. Morris nel 1975.

(define (max-border-len str)
  (local (lenstr mbl k)
    (setq lenstr (length str))
    (setq mbl (array lenstr '(0)))
    ; lunghezza del bordo corrente
    (setq k 0)
    (for (i 1 (- lenstr 1))
      (while (and (!= (str k) (str i)) (> k 0))
        ; diversi: prova il prossimo bordo
        (setq k (mbl (- k 1)))
      )
      ; ultimo carattere uguale?
      (if (= (str k) (str i))
        ; aumenta la lunghezza del bordo
        (++ k)
      )
      ; trovato bordo massimo di str (partendo da i + 1)
      (setf (mbl i) k)
    )
    mbl))

(max-border-len "AAAABABABAB")
;-> (0 1 2 3 0 1 0 1 0 1 0)

(max-border-len "massimo")
;-> (0 0 0 0 0 1 0)

(max-border-len "pippo")
;-> (0 0 1 1 0)

(max-border-len "abracadabra")
;-> (0 0 0 1 0 1 0 1 2 3 4)

(max-border-len "aaaaa")
;-> (0 1 2 3 4)

(define (knuth-morris-pratt str txt)
  (local (sep mbl lenstr out)
    (setq out '()) ; lista di output
    ; Il carattere sep non deve essere presente
    ; ne in txt ne in str
    (setq sep "~") ; carattere speciale non usato
    (setq mbl (max-border-len (string str sep txt)))
    (setq lenstr (length str))
    (dolist (el mbl)
      (if (= el lenstr) ; trovato un bordo della lunghezza di str
        ; inizio del bordo in txt
        ; stringa str trovata in txt
        (push (- $idx (* 2 lenstr)) out -1)
      )
    )
    out))

(knuth-morris-pratt "abra" "abracadabra")
;-> (0 7)

(knuth-morris-pratt "a" "ababababa")
;-> (0 2 4 6 8)

(knuth-morris-pratt "a" "aaaaa")
;-> (0 1 2 3 4)

(ref-all "a" (explode "aaaaa"))
;-> ((0) (1) (2) (3) (4))

(knuth-morris-pratt "ABAB" "ABABDABACDABABCABAB")
;-> (0 10 15)


--------------------------
Heap binario (Binary Heap)
--------------------------

Un heap binario è un albero binario con le seguenti proprietà:

1) È un albero completo (tutti i livelli sono completamente riempiti tranne forse l'ultimo livello e l'ultimo livello ha tutte le chiavi il più a sinistra possibile). Questa proprietà del Binary Heap lo rende adatto per essere archiviato in un vettore (array).

2) Un Binary Heap può essere Min-Heap o Max-Heap. In un Binary Heap minimo (Min-Heap), la chiave alla radice deve essere minima tra tutte le chiavi presenti in heap binario. La stessa proprietà deve essere ricorsivamente vera per tutti i nodi dell'albero binario. Un Binary Heap massimo (Max-Heap) è simile a Min-Heap.

L'Heap binario soddisfa la proprietà di ordinamento.

L'ordinamento può essere di due tipi:

1. Proprietà Min-Heap: il valore di ogni nodo è maggiore o uguale al valore del suo genitore, con il valore minimo alla radice.

2. Proprietà Max-Heap: il valore di ogni nodo è minore o uguale al valore del suo genitore, con il valore massimo alla radice.

Esempi di Min-Heap:

          10                  10
         /  \               /    \
       20    100          15      30
      /                  /  \    /  \
    30                  40  50  100 40

Come viene rappresentato l'Heap binario?

Poichè un Heap binario è un albero binario completo possiamo rappresentato con un array. L'elemento radice sarà in Array[0]. La tabella seguente mostra gli indici di altri nodi per l'i-esimo nodo, ovvero Array[i]:
Array[(i - 1) / 2]  Restituisce il nodo genitore
Array[(2 * i) + 1] Restituisce il nodo figlio sinistro
Array[(2 * i) + 2] Restituisce il nodo figlio destro

Il metodo di attraversamento utilizzato per ottenere la rappresentazione dell'array è l'ordine dei livelli:

            (0)
           1
          / \
         /   \
    (1) /     \ (2)
       3       6
      / \     /
     /   \   /
    5     9 8
 (3)   (4)   (5)

    (1 3 6 5 9 8)
     0 1 2 3 4 5

Operazioni di base su un Min-Heap:

1) get-min(): restituisce l'elemento radice di Min Heap. La complessità temporale di questa operazione è O(1).

2) extract-min(): rimuove l'elemento minimo da MinHeap. La complessità temporale di questa operazione è O(Logn) poiché questa operazione deve mantenere la proprietà heap (chiamando min-heapify()) dopo aver rimosso root.

3) decrease-key(): diminuisce il valore della chiave. La complessità temporale di questa operazione è O(Logn). Se il valore della chiave di diminuzione di un nodo è maggiore del genitore del nodo, non è necessario fare nulla. Altrimenti, dobbiamo attraversare l'albero per correggere la proprietà heap violata.

4) increase-key(): aumenta il valore della chiave. La complessità temporale di questa operazione è O(Logn). Se il valore della chiave encreases di un nodo è inferiore al genitore del nodo, non è necessario fare nulla. Altrimenti, dobbiamo attraversare l'albero per correggere la proprietà heap violata.

5) insert-key(): l'inserimento di una nuova chiave richiede tempo O(Logn). Aggiungiamo una nuova chiave alla fine dell'albero. Se la nuova chiave è maggiore del suo genitore, non è necessario fare nulla. Altrimenti, dobbiamo attraversare l'albero per correggere la proprietà heap violata.

6) delete-key(): Anche l'eliminazione di una chiave richiede tempo O(Logn). Sostituiamo la chiave da cancellare con meno infinito chiamando decrement-key(). Dopo decrement-key(), il valore meno infinito deve raggiungere root, quindi chiamiamo extract-min() per rimuovere la chiave.

7) change-value-key(): modifica il valore di una chiave. La complessità temporale di questa operazione è O (Logn). Se il nuovo valore della chiave è uguale al valore della chiave del suo genitore, non è necessario fare nulla. Altrimenti, dobbiamo spostarci verso l'alto per correggere la proprietà heap violata.

Di seguito è riportata l'implementazione delle operazioni di base per un Min-Heap:

; Dimensione massima dell'heap
(setq heap-max-size 100)

; Dimensione corrente del'heap
(setq heap-current-size 0)

; definizione del vettore di heap
(setq heap (array heap-max-size '(nil)))

; Ritorna l'indice genitore (parent) per l'indice specificato
(define (parent key) (/ (- key 1) 2))

; Ritorna l'indice sinistro (left) per l'indice specificato
(define (left key) (+ (* key 2) 1))

; Ritorna l'indice destro (left) per l'indice specificato
(define (right key) (+ (* key 2) 2))

; Restituisce la chiave minima (la chiave alla radice) di min-heap
(define (get-min) (heap 0))

; Restituisce e rimuove la chiave minima (la chiave alla radice) di min-heap
(define (extract-min)
  (local (root)
    (cond ((<= heap-current-size 0) 9223372036854775807)
          ((= heap-current-size 1)
          (-- heap-current-size)
          (heap 0))
          ; Store the minimum value and remove it from heap
          (true
            (setq root (heap 0))
            (setf (heap 0) (heap (- heap-current-size 1)))
            (-- heap-current-size)
            (min-heapify 0)
            root))))

; Diminuisce il valore della chiave a new-val.
; (Si suppone che new-val sia minore di heap[key])
(define (decrease-key key new-val)
  (if (> new-val (heap key)) (println "error: decrease-key"))
  ; Aggiorna il valore
  (setf (heap key) new-val)
  ; Aggiusta la proprietà min-heap se è stata violata
  (while (and (!= key 0) (< (heap key) (heap (parent key))))
    (swap (heap key) (heap (parent key)))
    (setq key (parent key))
  ))

; Aumenta il valore della chiave a new-val.
; (Si suppone che new-val sia maggiore di heap[key])
(define (increase-key key new-val)
  (if (< new-val (heap key)) (println "error: increase-key"))
  ; Aggiorna il valore
  (setf (heap key) new-val)
  (min-heapify key))

; Inserisce una nuova chiave
(define (insert-key key)
  (let (i heap-current-size)
    (cond ((= heap-current-size heap-max-size) nil)
          (true
            ; Prima inserisce la chiave alla fine
            (setf (heap i) key)
            (++ heap-current-size)
            ; Poi aggiusta la proprietà min-heap se è stata violata
            (while (and (!= i 0) (< (heap i) (heap (parent i))))
              (swap (heap i) (heap (parent i)))
              (setq i (parent i))
            ))
    )
    true))

; Elimina la chiave in corrispondenza dell'indice specificato.
; Prima ha riduce il valore a meno infinito, poi chiama extract-min()
(define (delete-key key)
  (decrease-key key -9223372036854775808)
  (extract-min))

; Metodo ricorsivo per "min-heapify" un sotto-albero
; con la radice in un dato indice
; Questo metodo presuppone che i sotto-alberi siano già "min-heapify"
(define (min-heapify key)
  (local (l r smallest)
    (setq l (left key))
    (setq r (right key))
    (setq smallest key)
    (if (and (< l heap-current-size) (< (heap l) (heap smallest)))
        (setq smallest l)
    )
    (if (and (< r heap-current-size) (< (heap r) (heap smallest)))
        (setq smallest r)
    )
    (if (!= smallest key) (begin
        (swap (heap key) (heap smallest))
        (min-heapify smallest))
    )))

; Cambia il valore di una chiave
(define (change-value-key key new-val)
  (cond ((= (heap key) new-val) new-val)
        ((< (heap key) new-val)
          (increase-key key new-val))
        ((> (heap key) new-val)
          (decrease-key key new-val))
  ))

Adesso possiamo definire un Min-Heap e provare alcune funzioni:

(setq heap-max-size 11)
(setq heap-current-size 0)
(setq heap (array heap-max-size '(nil)))
(insert-key 3)
(insert-key 2)
(delete-key 1)
(insert-key 15)
(insert-key 5)
(insert-key 4)
(insert-key 45)
(extract-min)
;-> 2
(get-min)
;-> 4
(decrease-key 2 1)
(get-min)
;-> 1
heap
;-> (1 15 4 45 45 nil nil nil nil nil nil)
heap-current-size
;-> 4

Nota: l'ultimo termine del min-heap (45) non viene considerato, infatti se inseriamo un nuovo valore:

(insert-key 46)
heap
;-> (1 15 4 45 46 nil nil nil nil nil nil)

il valore viene sovrascritto.


----------
Flood Fill
----------

Un'immagine è rappresentata da una matrice 2-D di numeri interi, ogni numero intero rappresenta il valore (da 0 a 65535) del colore dei pixel dell'immagine.

Data una coordinata (x, y) che rappresenta il pixel iniziale (riga e colonna) e un valore di colore (colore-nuovo) per il pixel, colorare tutti i pixel connessi a (x, y) con il nuovo colore.
Alla fine, restituire l'immagine modificata.

L'algoritmo "Flood fill" individua un punto all'interno dell'area/matrice e, a partire da quel punto, colora tutto quello che ha intorno fermandosi solo quando incontra un confine, ovvero un pixel di colore differente.

L'algoritmo richiede 2 parametri: il pixel iniziale e il colore di riempimento. La formulazione più semplice è ricorsiva. Si individua un pixel qualsiasi appartenente all'area da colorare, si controllano i vicini e se hanno un colore uguale lo si cambia con quello scelto, altrimenti si prosegue.

Flood-fill (pixel(x y), colore-nuovo):
 0. colore-prima = colore pixel(x y)
 1. Se il colore di pixel è diverso da colore-prima, termina.
 2. Imposta il colore di pixel a colore-nuovo.
 3. Esegui Flood-fill (pixel ad ovest di pixel colore-nuovo).
    Esegui Flood-fill (pixel a nord di pixel colore-nuovo).
    Esegui Flood-fill (pixel ad est di pixel colore-nuovo).
    Esegui Flood-fill (pixel a sud di pixel colore-nuovo).
 4. Termina.

(define (flood-fill img x y new-color)
  (local (old-color dir max-x max-y)
    (setq max-x (length img))
    (setq max-y (length (img 0)))
    (setq dir '((0 1) (0 -1) (1 0) (-1 0)))
    ;------------------
    ; recursive fill
    (define (fill x y)
    (catch
      (local (new-x new-y)
        (setq old-color (img x y))
        (if (= old-color new-color) (throw img))
        (setf (img x y) new-color)
        (for (i 0 (- (length dir) 1))
          (setq new-x (+ x (dir i 0)))
          (setq new-y (+ y (dir i 1)))
          (cond ((or (< new-x 0) (>= new-x max-x) (< new-y 0) (>= new-y max-y)) nil)
                ((!= (img new-x new-y) old-color) nil)
                (true (fill new-x new-y))
          )
        )
        img)))
     ;------------------
     (fill x y)))

Proviamo la funzione:

(setq image '((1 1 1)
              (1 1 0)
              (1 0 1)))

(flood-fill image 0 0 2)
;-> ((2 2 2)
;->  (2 2 0)
;->  (2 0 1))

(flood-fill image 2 2 2)
;-> ((1 1 1)
;->  (1 1 0)
;->  (1 0 2))

(setq image '(
      (0 0 1 0 1 1 1 1 0 0 0 1 1 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1)
      (1 0 1 1 1 0 1 1 1 1 1 0 1 1 1 1 0 1 0 1 0 1 0 0 1 1 1 1 1 1)
      (0 0 1 0 1 0 0 1 1 1 1 1 1 1 0 1 1 0 1 1 1 0 1 0 1 0 1 0 1 0)
      (1 0 1 1 0 1 0 1 0 1 0 1 0 1 1 1 1 1 1 1 1 0 1 0 0 0 1 1 1 1)
      (1 0 1 1 1 1 0 1 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
      (0 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 0 0 1 1 1 1 0 1 1 1 1 0 1 1)
      (1 1 0 1 1 1 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 0 1 0)
      (1 0 0 1 1 1 1 1 1 0 0 0 0 0 0 1 1 1 0 1 1 0 0 0 1 1 1 0 0 1)
      (1 0 0 0 0 0 1 1 1 0 0 0 1 1 1 0 0 1 1 0 0 0 0 1 1 0 0 1 1 1)
      (0 0 0 1 1 1 1 0 0 0 0 1 1 1 0 0 0 1 1 0 0 1 1 1 1 0 0 0 1 1)
      (1 0 0 1 1 1 0 0 0 1 1 1 0 0 0 0 1 1 0 1 0 0 0 1 1 1 0 0 0 1)
      (1 1 0 0 0 1 1 1 0 0 0 0 0 0 0 1 1 1 1 1 1 0 1 1 1 0 1 1 1 0)
      (1 1 1 0 1 1 0 1 1 1 0 0 1 1 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1 1)
      (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 0 1 0 1 0 1 0 1)
      (0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 0 0 1 0 1 0 1 1)
      (0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 0 0 1 0 1 0 1 1)))

(flood-fill image 0 0 8)
;-> ((8 8 1 0 1 1 1 1 0 0 0 1 1 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1)
;->  (1 8 1 1 1 8 1 1 1 1 1 0 1 1 1 1 0 1 0 1 0 1 8 8 1 1 1 1 1 1)
;->  (8 8 1 0 1 8 8 1 1 1 1 1 1 1 0 1 1 0 1 1 1 8 1 8 1 8 1 0 1 0)
;->  (1 8 1 1 0 1 8 1 8 1 8 1 8 1 1 1 1 1 1 1 1 8 1 8 8 8 1 1 1 1)
;->  (1 8 1 1 1 1 8 1 8 1 8 1 8 1 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8)
;->  (8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8)
;->  (8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8)
;->  (8 8 8 8 8 8 1 8 8 8 8 8 1 1 1 1 8 8 1 1 1 1 8 1 1 1 1 8 1 1)
;->  (1 1 8 1 1 1 0 1 1 8 1 8 1 8 1 0 1 8 1 0 1 8 1 1 1 0 1 8 1 0)
;->  (1 8 8 1 1 1 1 1 1 8 8 8 8 8 8 1 1 1 0 1 1 8 8 8 1 1 1 8 8 1)
;->  (1 8 8 8 8 8 1 1 1 8 8 8 1 1 1 8 8 1 1 8 8 8 8 1 1 0 0 1 1 1)
;->  (8 8 8 1 1 1 1 8 8 8 8 1 1 1 8 8 8 1 1 8 8 1 1 1 1 0 0 0 1 1)
;->  (1 8 8 1 1 1 8 8 8 1 1 1 8 8 8 8 1 1 0 1 8 8 8 1 1 1 0 0 0 1)
;->  (1 1 8 8 8 1 1 1 8 8 8 8 8 8 8 1 1 1 1 1 1 8 1 1 1 0 1 1 1 0)
;->  (1 1 1 8 1 1 8 1 1 1 8 8 1 1 8 8 8 8 8 8 8 8 8 1 1 0 0 0 1 1)
;->  (1 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 1 1 1 8 1 8 1 0 1 0 1 0 1)
;->  (8 8 1 1 1 8 8 8 8 8 8 8 8 8 8 8 8 8 1 1 8 1 8 8 1 0 1 0 1 1)
;->  (8 8 1 1 1 8 8 8 8 8 8 8 8 8 8 8 8 8 1 1 8 1 8 8 1 0 1 0 1 1))


-----------------
Poligoni convessi
-----------------

Determinare se un poligono è convesso. Il poligono è rappresentato da una lista di punti.

Un poligono è convesso se la componente z di tutti i prodotti incrociati (cross-product) ha lo stesso segno.
Questo metodo funziona con i poligoni semplici (senza lati auto-intersecanti) e assume che i vertici siano ordinati (in senso orario o in senso antiorario).

(define (convex? polygon)
(catch
  (local (len dx1 dy1 dx2 dy2 i1 i2 cur pre)
    (setq len (length polygon))
    (setq pre 0) (setq cur 0)
    (for (i 0 (- len 1))
      (setq i1 (+ i 1))
      (if (>= i1 len) (setq i1 (- i1 len)))
      (setq i2 (+ i 2))
      (if (>= i2 len) (setq i2 (- i2 len)))
      (setq dx1 (sub (polygon i1 0) (polygon i 0)))
      (setq dy1 (sub (polygon i1 1) (polygon i 1)))
      (setq dx2 (sub (polygon i2 0) (polygon i1 0)))
      (setq dy2 (sub (polygon i2 1) (polygon i1 1)))
      (setq cur (sub (mul dx1 dy2) (mul dx2 dy1)))
      (if (!= cur 0)
          (if (or (and (> cur 0) (< pre 0)) (and (< cur 0) (> pre 0)))
              (throw nil)
              (setq pre cur)
          )
      )
    )
    true)))

(convex? '((0 0) (1 0) (1 1) (0 1)))
;-> true
(convex? '((0 0) (2 0) (2 2) (0 2) (0 0)))
;-> true
(convex? '((0 0) (2 0) (2 2) (1 1) (0 2)))
;-> nil
(convex? '((0 0) (2 0) (2 2) (1 2) (0 2)))
;-> true
(convex? '((0 0) (2 0) (2 2) (1 1.9) (0 2)))
;-> nil
(convex? '((0 0) (2 0) (2 2) (1 1.999999999999999) (0 2)))
;-> nil
(convex? '((0 0) (2 0) (2 2) (1 1.9999999999999999) (0 2)))
;-> true


----------------------
Variazione percentuale
----------------------

Scrivere una funzione che calcola la variazione percentuale tra due numeri x e y.

(define (delta% x y)
  (div (mul (sub y x) 100) x))

(delta% 50 100)
;-> 100

(delta% 100 50)
;-> -50

(delta% 20 60)
;-> 200

(delta% 60 20)
;-> -66.66666666666667


-------------------------------
Grafico di coppie di coordinate
-------------------------------

Scrivere una funzione che disegna il grafico di una lista di coppie di coordinate, in altre parole disegna il grafico di una serie di punti.

Liste distinte di coordinate x e y per i punti:
(setq lst-x '(1 4 -5 2 10 -6 15))
(setq lst-y '(3 4 6 -2 12 -8 12))

Unione delle due liste di coordinate in una lista di punti:
(setq lst-xy (map list lst-x lst-y))
;-> ((1 3) (4 4) (-5 6) (2 -2) (10 12) (-6 -8) (15 12))

Divisione della lista di punti in due liste di coordinate x e y:
(setq lst-x (map first lst-xy))
(setq lst-y (map last  lst-xy))

Il metodo per stampare i punti al terminale utilizza una matrice di caratteri per simulare un sistema cartesiano di coordinate x e y. La mappatura delle celle della matrice con il sistema cartesiano è il seguente:

- la coordinata (0,0) della matrice si trova in alto a sinistra, mentre la coordinata (0,0) del sistema cartesiano si trova in basso a destra. Questo comporta che prima di stampare la matrice occorrerà invertire le sue righe.

- la coordinata x del punto è la colonna della matrice e la coordinata y è la riga, cioè:
  P(x,y) = Matrice(row,col) = Matrice(y,x)

Prima di tutto ci serve una funzione che normalizza una lista di valori in un intervallo (val-min, val-max):

(define (normal-zero lst-num val-min val-max)
  (local (hi lo k out)
    (setq out '())
    (setq hi (apply max lst-num))
    (setq lo (apply min lst-num))
    (setq k (div (sub val-max val-min) (sub hi lo)))
    (dolist (val lst-num)
      (push (add val-min (mul (sub val lo) k)) out -1)
    )
    ; Valore dello 0 nella lista normalizzata
    (push (add val-min (mul (sub 0 lo) k)) out)
    out))

(normal-zero lst-x -6 15)
;-> (0 1 4 -5 2 10 -6 15)
(normal-zero lst-x 0 30)
;-> (8.571428571428571 10 14.28571428571429 1.428571428571429
;->  11.42857142857143 22.85714285714286 0 30)

Adesso possiamo scrivere la funzione che disegna i punti sul terminale. QUesta funzione prende come parametri la lista di punti, la larghezza (in caratteri) del grafico e l'altezza (in caratteri) del grafico.

(define (plot lst-xy width height)
  (local (lst-x lst-y x-min x-max y-min y-max
          range-x range-y xx yy zero-x zero-y matrix)
    ; crea lista delle x
    (setq lst-x (map first lst-xy))
    ; crea lista delle y
    (setq lst-y (map last  lst-xy))
    ; calcola valori min,max x
    (setq x-min (apply min lst-x))
    (setq x-max (apply max lst-x))
    ; calcola valori min,max x
    (setq y-min (apply min lst-y))
    (setq y-max (apply max lst-y))
    ; calcolo intervallo valori x
    (setq range-x (sub x-max x-min))
    ; calcolo intervallo valori y
    (setq range-y (sub y-max y-min))
    ; calcolo valori normalizzati lista x
    ; (i valori vengono arrotondati e poi resi interi)
    (setq xx (normal-zero lst-x 0 width))
    (setq xx (map (fn(w) (int (round w))) xx))
    ; estrazione valore dello zero x normalizzato
    (setq zero-x (pop xx))
    ; calcolo valori normalizzati lista y
    (setq yy (normal-zero lst-y 0 height))
    (setq yy (map (fn(w) (int (round w))) yy))
    ; estrazione valore dello zero y normalizzato
    (setq zero-y (pop yy))
    ; Creazione matrice di caratteri di stampa
    ; Matrice = Sistema di coordinate (row col)
    ; x --> colonna della matrice
    ; y --> riga della matrice
    ; Valore cella vuota: " "
    (setq matrix (array (+ height 2) (+ width 2) '(" ")))
    ; Inserisce asse x sulla matrice
    ;(for (i 0 (- (length (matrix 0)) 1))
    ;  (setf (matrix zero-y i) "·")
    ;)
    ; asse x nella matrice
    (if (and (>= zero-y 0) (< zero-y (+ height 2)))
        (for (i 0 (- (length (matrix 0)) 1))
          (setf (matrix zero-y i) "·")
        )
    )
    ; Inserisce asse y sulla matrice
    ;(for (i 0 (- (length matrix) 1))
    ;  (setf (matrix i zero-x) "·")
    ;)
    ; asse y nella matrice
    (if (and (>= zero-x 0) (< zero-x (+ width 2)))
        (for (i 0 (- (length matrix) 1))
          (setf (matrix i zero-x) "·")
        )
    )
    ; Inserisce punti (x y) nella matrice
    ; (inserisce "■" nelle celle (y x) della matrice)
    (for (i 0 (- (length xx) 1))
      (setf (matrix (yy i) (xx i)) "■")
    )
    ; Inserisce origine degli assi (0 0) nella matrice.
    ; se l'origine è un punto della lista
    ;(if (= (matrix zero-y zero-x) "■")
    ;    ; allora inserisce "0"
    ;    (setf (matrix zero-y zero-x) "O")
    ;    ; altrimenti inserisce "●"
    ;    (setf (matrix zero-y zero-x) "∙")
    ;)
    ; (0,0) nella matrice
    (if (and (>= zero-x 0) (>= zero-y 0)
             (< zero-x (+ width 2)) (< zero-y (+ height 2)))
        (if (= (matrix zero-y zero-x) "■")
            (setf (matrix zero-y zero-x) "O")
            (setf (matrix zero-y zero-x) "∙")
        )
    )
    ; stampa valori reali min e max
    (println (format "x: %-12.3f %-12.3f" x-min x-max))
    (println (format "y: %-12.3f %-12.3f" y-min y-max))
    ; stampa matrice di caratteri
    ; (le righe della matrice vengono invertite)
    (dolist (el (reverse (array-list matrix)))
      (println " " (join el))
    )
    'end))

Facciamo alcune prove:

(plot lst-xy 60 30)
;-> x: -6.000       15.000
;-> y: -8.000       12.000
;->                   ·
;->                   ·                            ■             ■
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->     ■             ·
;->                   ·
;->                   ·
;->                   ·           ■
;->                   ·  ■
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->  ·················●············································
;->                   ·
;->                   ·
;->                   ·     ■
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->                   ·
;->  ■                ·

(setq coppie (map list (sequence 0 20) (sequence 0 10)))
(plot coppie 40 20)
;-> x: 0.000        20.000
;-> y: 0.000        20.000
;->  ·
;->  ·                                       ■
;->  ·                                     ■
;->  ·                                   ■
;->  ·                                 ■
;->  ·                               ■
;->  ·                             ■
;->  ·                           ■
;->  ·                         ■
;->  ·                       ■
;->  ·                     ■
;->  ·                   ■
;->  ·                 ■
;->  ·               ■
;->  ·             ■
;->  ·           ■
;->  ·         ■
;->  ·       ■
;->  ·     ■
;->  ·   ■
;->  · ■
;->  O·········································

Nota: nel terminale del DOS il rapporto proporzionale tra la larghezza e l'altezza dei caratteri varia con il tipo di font, ma varia tra 1/2 e 1/2.5.

Proviamo a disegnare una funzione matematica. Prima scriviamo una funzione che genera i punti della funzione:

(define (func-points func min-val max-val step)
  (let (pts '())
    (for (i min-val max-val step)
      (push (list i (func i)) pts -1))))

Adesso disegniamo il grafico della funzione seno (sin):

(plot (func-points sin -6.3 6.3 0.01) 60 20)
;-> x: -6.300       6.300
;-> y: -1.000       1.000
;->                                ·
;->        ■■■■                    ·     ■■■■
;->       ■■  ■■                   ·    ■■  ■■
;->      ■■    ■■                  ·   ■■    ■■
;->     ■■      ■■                 ·  ■■      ■■
;->     ■        ■                 ·  ■        ■
;->    ■■        ■■                · ■■        ■■
;->    ■          ■                · ■          ■
;->   ■■          ■■               ·■■          ■■
;->   ■            ■               ·■            ■
;->  ■■            ■■              ■■            ■■
;->  ■··············■··············O··············■··············■·
;->                 ■■            ■■              ■■            ■■
;->                  ■            ■·               ■            ■
;->                  ■■          ■■·               ■■          ■■
;->                   ■          ■ ·                ■          ■
;->                   ■■        ■■ ·                ■■        ■■
;->                    ■        ■  ·                 ■        ■
;->                    ■■      ■■  ·                 ■■      ■■
;->                     ■■    ■■   ·                  ■■    ■■
;->                      ■■  ■■    ·                   ■■  ■■
;->                       ■■■■     ·                    ■■■■

Disegniamo una superellisse.
Una superellisse è una figura geometrica definita come l'insieme di tutti i punti (x, y) tali che:

  |x/a|ⁿ + |y/b|ⁿ = 1

dove n, a e b sono numeri positivi.

La curva è data dalle equazioni parametriche (con parametro t che non ha una interpretazione geometrica elementare):

x(t) = |cos(t)|^2/n * a * sgn(cos(t))
y(t) = |sin(t)|^2/n * b * sgn(sin(t))

Funzione che genera i punti della superellisse:

(define (super-xy n a b)
  (local (x y out)
    (setq out '())
    (for (t 0 1000 0.1)
      (setq x (mul (pow (abs (cos t)) (div 2 n)) a (sgn (cos t))))
      (setq y (mul (pow (abs (sin t)) (div 2 n)) b (sgn (sin t))))
      (push (list x y) out -1)
    )
    out))

(plot (super-xy 2 200 200) 60 25)
;-> x: -200.000     200.000
;-> y: -200.000     200.000
;->                                ·
;->                        ■■■■■■■■■■■■■■■■■
;->                  ■■■■■■■       ·       ■■■■■■■
;->              ■■■■■             ·             ■■■■■
;->           ■■■■                 ·                 ■■■■
;->         ■■■                    ·                    ■■■
;->       ■■■                      ·                      ■■■
;->      ■■                        ·                        ■■
;->     ■■                         ·                         ■■
;->    ■■                          ·                           ■
;->   ■■                           ·                           ■■
;->  ■■                            ·                            ■■
;->  ■                             ·                             ■
;->  ■                             ·                             ■
;->  ■·····························●·····························■·
;->  ■                             ·                             ■
;->  ■■                            ·                            ■■
;->   ■■                           ·                           ■■
;->    ■■                          ·                          ■■
;->     ■■                         ·                         ■■
;->      ■■                        ·                        ■■
;->       ■■■                      ·                      ■■■
;->         ■■■                    ·                    ■■■
;->           ■■■■                 ·                 ■■■■
;->              ■■■■■             ·             ■■■■■
;->                  ■■■■■■■       ·       ■■■■■■■
;->                        ■■■■■■■■■■■■■■■■■

(plot (super-xy 0.5 1 1) 50 25)
;-> x: -1.000       1.000
;-> y: -1.000       1.000
;->                           ·
;->                           ■
;->                           ■
;->                           ■
;->                          ■■■
;->                          ■·■
;->                         ■■·■■
;->                         ■ · ■
;->                        ■■ · ■■
;->                      ■■■  ·  ■■■
;->                     ■■    ·    ■■
;->                  ■■■      ·      ■■■
;->              ■■■■■        ·        ■■■■■
;->  ■■■■■■■■■■■■■            ·            ■■■■■■■■■■■■■
;->  ■■■■■■■■■■■■■············●············■■■■■■■■■■■■■·
;->              ■■■■■        ·        ■■■■■
;->                  ■■■      ·      ■■■
;->                     ■■    ·    ■■
;->                      ■■■  ·  ■■■
;->                        ■■ · ■■
;->                         ■ · ■
;->                         ■■·■■
;->                          ■·■
;->                          ■■■
;->                           ■
;->                           ■
;->                           ■

Disegniamo un'altra funzione:

      (x*x)
y = --------- - 2
     (2 - x)

(define (gg x)
  (sub (div (mul x x) (sub 2 x)) 2))

(plot (func-points gg -2 1.5 0.01) 40 20)
;-> x: -2.000       1.500
;-> y: -2.000       2.500
;->                         ·
;->                         ·                ■
;->                         ·                ■
;->                         ·                ■
;->                         ·               ■
;->                         ·               ■
;->                         ·               ■
;->                         ·               ■
;->                         ·              ■■
;->                         ·              ■
;->                         ·              ■
;->                         ·             ■■
;->  ·······················●·············■····
;->                         ·            ■■
;->                         ·            ■
;->                         ·           ■■
;->                         ·          ■■
;->  ■■■■                   ·         ■■
;->     ■■■■■               ·        ■■
;->         ■■■■■           ·       ■■
;->             ■■■■■■■     ·    ■■■
;->                   ■■■■■■■■■■■■

(plot (func-points gg -4 -0.5 0.01) 40 20)
;-> x: -4.000       -0.500
;-> y: -1.900       0.667
;->
;->  ■■
;->   ■■
;->     ■■
;->      ■■■
;->        ■■
;->  ········■■································
;->           ■■■
;->             ■■■
;->               ■■
;->                 ■■
;->                  ■■■
;->                    ■■■
;->                      ■■■
;->                        ■■■
;->                          ■■■
;->                            ■■■
;->                              ■■■
;->                                ■■■
;->                                   ■■■
;->                                     ■■■■
;->                                        ■■■

(plot (func-points gg -8 1.6 0.01) 60 30)
;-> x: -8.000       1.600
;-> y: -2.000       4.400
;->                                                    ·
;->  ■■                                                ·         ■
;->   ■■                                               ·         ■
;->    ■■                                              ·         ■
;->      ■■                                            ·         ■
;->       ■■                                           ·         ■
;->        ■■■                                         ·         ■
;->          ■■                                        ·         ■
;->           ■■                                       ·         ■
;->             ■■                                     ·        ■
;->              ■■                                    ·        ■
;->               ■■■                                  ·        ■
;->                 ■■                                 ·        ■
;->                  ■■■                               ·        ■
;->                    ■■                              ·        ■
;->                     ■■■                            ·        ■
;->                       ■■                           ·        ■
;->                        ■■■                         ·        ■
;->                          ■■                        ·       ■
;->                           ■■■                      ·       ■
;->                             ■■                     ·       ■
;->                              ■■■                   ·       ■
;->  ······························■■··················∙·······■···
;->                                 ■■■                ·      ■■
;->                                   ■■               ·      ■
;->                                    ■■■             ·      ■
;->                                      ■■■           ·     ■■
;->                                        ■■■         ·     ■
;->                                          ■■■       ·    ■■
;->                                            ■■■     ·   ■■
;->                                              ■■■■  ·  ■■
;->                                                 ■■■■■■■

Dobbiamo ammettere che "gnuplot" è sicuramente meglio...

Nota: per migliorare il grafico si potrebbe usare l'algoritmo di bresenham per le linee (cioè, per quei punti che distano più di una unità (in x e in y) dal punto successivo).


---------------------------------
Sottosequenza crescente più lunga
---------------------------------

Dato una lista non ordinata di interi, trovare la lunghezza della sottosequenza crescente più lunga (anche non contigua).

Sia max[i] la lunghezza della sottosequenza crescente più lunga finora.
Se un elemento prima di i è minore di lst[i], allora max[i] = max(max[i], max[j]+1).

La sequente funzione calcola la lunghezza della sottosequenza crescente più lunga:

(define (lis lst)
  (local (len vet out)
    (setq out 1)
    (setq len (length lst))
    (setq vet (array len '(1)))
    (for (i 0 (- len 1))
      (setq j 0)
      (while (< j i)
        (if (> (lst i) (lst j))
            (setf (vet i) (max (vet i) (+ (vet j) 1)))
        )
        (++ j)
      )
      (setq out (max (vet i) out))
    )
    out))

(lis '(10 9 2 5 3 7 101 18))
;-> 4

Se vogliamo ottenere i valori della sottosequenza possiamo seguire l'algoritmo presentato su wikipedia:

(define (long-inc-sub X)
(local (N P M L lo hi mid newL Pk S)
  (setq N (length X))
  (setq P (array N '(0)))
  (setq M (array (+ N 1) '(0)))
  (setq L 0)
  (for (i 0 (- N 1))
    ; Binary search for the largest positive j ≤ L
    ; such that X[M[j]] < X[i]
    (setq lo 1)
    (setq hi L)
    (while (<= lo hi)
      (setq mid (int (ceil (div (+ lo hi) 2))))
      (if (< (X (M mid)) (X i))
          (setq lo (+ mid 1))
          (setq hi (- mid 1))
      )
    )
    ; After searching, lo is 1 greater than the
    ; length of the longest prefix of X[i]
    (setq newL lo)
    ; The predecessor of X[i] is the last index of
    ; the subsequence of length newL-1
    (setf (P i) (M (- newL 1)))
    (setf (M newL) i)
    (if (> newL L)
        ; If we found a subsequence longer than any we've
        ; found yet, update L
        (setq L newL)
    )
  )
  ; Reconstruct the longest increasing subsequence
  (setq S '())
  (setq k (M L))
  (for (i (- L 1) -2)
    (push (X k) S)
    (setq k (P k))
  )
  (slice S 2)))

(long-inc-sub '(0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15))
;-> (0 2 6 9 11 15)
(long-inc-sub '(3 2 6 4 5 1))
;-> (2 4 5)
(long-inc-sub '(10 9 2 5 3 7 101 18))
;-> (2 3 7 18)


------------------------------------
Conversione stringa <--> big-integer
------------------------------------

Vediamo come convertire una stringa in un big-integer e viceversa.

; Maximum value of int64
(setq MAX-INT)  9223372036854775807)
; Minimum value of int64
(setq MIN-INT) -9223372036854775808)

Definiamo una stringa numerica maggiore di MAX-INT:

(setq s "99223372036854775807")
;-> 99223372036854775807

Se convertiamo con la funzione "int" otteniamo un risultato errato a causa dell'overflow:
(int s)
;-> -1

Però possiamo utilizzare la funzione "eval-string":

(setq num (eval-string s))
;-> 99223372036854775807L
(length s)
;-> 20
(length num)
;-> 20

Attenzione alle lunghezze dei due tipi integer e string.

Definiamo una stringa numerica minore di MIN-INT:

(setq s "-99223372036854775808")
"-99223372036854775808"
(int s)
;-> -1
(setq num (eval-string s))
;-> -9223372036854775808L
(length s)
;-> 21 ; il segno "-" è un carattere
(length num)
;-> 20

Riconvertiamo il numero big-integer in stringa:

(setq q (string num))
;-> "-99223372036854775808L" ; nota la L finale
(length q)
;-> 22 ; il segno "-" e "L" sono due caratteri

Riconvertiamo la stringa in numero big-integer:
(setq num (eval-string q))
;-> -99223372036854775808L
(length num)
;-> 20

Quindi possiamo scrivere la seguente funzione:

(define (str-int str)
  (eval-string str))

(str-int "2315369")
;-> 2315369
(str-int "23153234812357131369")
;-> 23153234812357131369L
(str-int "-23153234812357131369L")
;-> -23153234812357131369L


---------------------------
Dismutazioni (Derangements)
---------------------------

Nel calcolo combinatorio vengono dette dismutazioni (o sconvolgimenti, o permutazioni complete) le permutazioni di un insieme tali che nessun elemento appare nella sua posizione originale. In altre parole, uno dismutazione è una permutazione che non ha punti fissi.
Non esiste alcuna dismutazione per un insieme di un solo elemento, ne esiste 1 per un insieme di 2 elementi, 2 per un insieme di 3 elementi, 9 per uno di 4 elementi, ad esempio, le 9 dismutazioni possibili della parola "ABCD" sono:

  BADC BCDA BDAC
  CADB CDAB CDBA
  DABC DCAB DCBA

Il simbolo matematico che rappresenta la dismutazione è: !n

Per calcolare il numero di dismutazioni !n di un insieme esistono due formule:

1)  !n = (n - 1)*(!(n-1) + !(n-2)),  dove !0 = 1 e !1 = 0

2)  !n = n*!(n-1) + (-1)^n,  dove !0 = 1 e !1 = 0

           n  (-1)^i
3)  !n = n!∑----------,  per n >= 0
           0    i!

Sequenza OEIS A000166:
  1, 0, 1, 2, 9, 44, 265, 1854, 14833, 133496, 1334961, 14684570,
  176214841, 2290792932, 32071101049, 481066515734, 7697064251745,
  130850092279664, 2355301661033953, 44750731559645106, 895014631192902121,
  18795307255050944540, 413496759611120779881, 9510425471055777937262, ...

Versione ricorsiva con la formula 1:

(define (dismut1 num)
  (cond ((= num 0) 1L)
        ((= num 1) 0L)
        (true
          (* (- num 1) (+ (dismut1 (- num 1)) (dismut1 (- num 2)))))))

(dismut1 5)
;-> 44
(dismut1 10L)
;-> 1334961L
(dismut2 30L)
;-> 97581073836835777732377428235481L

Versione più efficiente (programmazione dinamica) che memorizza i risultati di dismut(num-1) e dismut(num-2) in una lista per usi futuri:

(define (dismut2 num)
  (let (dis (array (+ num 1) '(0)))
    (setf (dis 0) 1L)
    (setf (dis 1) 0L)
    (setf (dis 2) 1L)
      ; Riempie dis[0..n] dal basso verso l'alto
      ; usando la formula ricorsiva sopra
      (for (i 3 num)
        ;(setf (dis i) (* (- i 1) (+ (dis (- i 1)) (dis (- i 2)))))
        (setf (dis i) (* (+ (dis (- i 1)) (dis (- i 2))) (- i 1)))
    )
    (dis num)))

(dismut2 5)
;-> 44L
(dismut2 10L)
;-> 1334961L
(dismut2 30L)
;-> 97581073836835777732377428235481L

Una versione ancora migliore utilizza solo due variabili per memorizzare i valori dis(n-1) e dis(n-2) (che sono gli unici che servono per calcolare dis(n)):

(define (dismut3 num)
  (cond ((= num 0) 1L)
        ((= num 1) 0L)
        ((= num 2) 1L)
        (true
          (let ((a 0L) (b 1L) (cur 0L))
            (for (i 3 num)
              (setq cur (* (+ a b) (- i 1)))
              (setq a b)
              (setq b cur)
            )
            b))))

(dismut3 5)
;-> 44L
(dismut3 10L)
;-> 1334961L
(dismut3 30L)
;-> 97581073836835777732377428235481L

Vediamo una funzione che utilizza la programmazione dinamica con la formula ricorsiva 2:

(define (dismut4 num)
  (cond ((= num 0) 1L)
        ((= num 1) 0L)
        ((= num 2) 1L)
        (true
          (let ((a 1L) (cur 0L))
            (for (i 3 num)
              (if (odd? i)
                (setq cur (- (* a i) 1))
                (setq cur (+ (* a i) 1))
                ;(setq cur (+ (* a i) (pow -1L i)))
              )
              (setq a cur)
            )
            cur))))

(dismut4 5)
;-> 44L
(dismut4 10L)
;-> 1334961L
(dismut4 30L)
;-> 97581073836835777732377428235481L

Vediamo i tempi di esecuzione di queste funzioni:

(time (dismut1 30L) 10)
;-> 13621.586

(time (dismut2 40L) 10000)
;-> 173.538

(time (dismut3 40L) 10000)
;-> 166.555

(time (dismut4 40L) 10000)
;-> 164.588

La seconda funzione "dismut2" memorizza tutti i valori di dis(i) per i = 0..num, quindi possiamo usarla per calcolare il numero di dismutazioni di tutti i numeri da 0 fino a num:

(define (dismut-to num)
  (let (dis (array (+ num 1) '(0)))
    (setf (dis 0) 1L)
    (setf (dis 1) 0L)
    (setf (dis 2) 1L)
      (for (i 3 num)
        (setf (dis i) (* (+ (dis (- i 1)) (dis (- i 2))) (- i 1)))
    )
    dis))

(dismut-to 20)
;-> (1L 0L 1L 2L 9L 44L 265L 1854L 14833L 133496L 1334961L 14684570L
;->  176214841L 2290792932L 32071101049L 481066515734L 7697064251745L
;->  130850092279664L 2355301661033953L 44750731559645106L
;->  895014631192902121L)

Per generare la lista delle dismutazioni di un insieme di elementi possiamo usare la funzione delle permutazioni con una modifica: inseriamo la permutazione corrente nella lista delle dismutazioni solo se soddisfa al vincolo che nessun elemento appare nella sua posizione originale.

Funzione che verifica se la lista corrente "lst" può essere una dismutazione (confronto con la lista originale "base"):

(define (dis?)
(catch
  (let (ok true)
    (dolist (el lst)
      (if (= el (base $idx))
        (throw nil)))
    ok)))

Nota: non passiamo le liste "lst" e "base" alla funzione "dis?" perchè perderemmo in velocità (ricorda che newLISP fa una copia di ogni parametro passato ad una funzione). Questo è possibile grazie all'ambito dinamico di newLISP.

(define (dism lst)
"Generates all dismutations without repeating from a list of items"
  (local (i indici out base)
    ; lista originale
    (setq base lst)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    ; non aggiungiamo la lista iniziale alla soluzione
    ; perchè non è una dismutazione
    ; (setq out (list lst))
    (setq out '())
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i))
            )
            ;(println lst)
            ; inseriamo la permutazione corrente solo se ogni elemento
            ; non appare nella sua posizione originale
            (if (dis?)
              (push lst out -1)
            )
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

(sort (dism '(A B C D)))
;-> ((B A D C) (B C D A) (B D A C)
;->  (C A D B) (C D A B) (C D B A)
;->  (D A B C) (D C A B) (D C B A))

Vediamo il tempo di esecuzione:

(time (println (length (dism '(a b c d e f g h i j)))))
;-> 1334961
;-> 7603.603


-------------------------
Stampa lista come tabella
-------------------------

La funzione seguente prende una lista e la stampa come una tabella con il seguente formato grafico:

lista = ((1 2 3 4 5) ("a" "b" "c" "d" "e") (-1 -2 -3 -4 -5) (aa bb cc dd ee) (-11 -12 -13 -14 -15))

Nota: la lista deve essere una matrice con tutti i valori e con più di una riga.

Nota: la stampa avviene con tutti i valori allineati a sinistra

  +-----+-----+-----+-----+-----+
  | 1   | 2   | 3   | 4   | 5   |
  +-----+-----+-----+-----+-----+
  | a   | b   | c   | d   | e   |
  +-----+-----+-----+-----+-----+
  | -1  | -2  | -3  | -4  | -5  |
  +-----+-----+-----+-----+-----+
  | aa  | bb  | cc  | dd  | ee  |
  +-----+-----+-----+-----+-----+
  | -11 | -12 | -13 | -14 | -15 |
  +-----+-----+-----+-----+-----+

Per facilitare la formattazione di stampa convertiamo tutti i valori in stringa con la seguente funzione che ci permette di applicare una funzione a tutti gli elementi di una lista annidata:

(define (map-all f lst)
  (let (result '())
    (dolist (el lst)
      (if (list? el)
        (push (map-all f el) result -1)
        (push (f el) result -1)))
    result))

Adesso possiamo scrivere la funzione di stampa della lista:

(define (print-table lst)
  (local (tab plus minus ver rows cols col-len-max len-max
          line-len line ind)
    ; conversione di tutti i valori della lista in stringa
    (setq tab (map-all string lst))
    ; caratteri grafici
    (setq plus "+")
    (setq minus "-")
    (setq ver "|")
    ; calcolo righe e colonne della lista
    (setq rows (length tab))
    (setq cols (length (tab 0)))
    ; vettore per le lunghezze massime dei valori di ogni colonna
    (setq col-len-max (array cols '(0)))
    ; calcola la lunghezza massima dei valori di ogni colonna
    (for (c 0 (- cols 1))
      (setq len-max 0)
      (for (r 0 (- rows 1))
        (setf len-max (max len-max (length (tab r c))))
      )
      (setf (col-len-max c) len-max)
    )
    ;(println col-len-max)
    ; lunghezza della linea =
    ; (somma delle lunghezze massime) +
    ; (2 spazi x ogni colonna) +
    ; (colonne + 1 per "|")
    (setq line-len (+ (apply + col-len-max) (* cols 2) (+ cols 1)))
    (setq line (dup minus line-len))
    (setf (line 0) plus)
    (setf (line -1) plus)
    ; calcola i limiti di stampa dei valori
    ; (inserisce "+" nella linea "line")
    (setq ind 1)
    (dolist (c col-len-max)
      (setq ind (+ ind 2 c))
      (setf (line ind) "+")
      (++ ind)
    )
    ; stampa della lista come tabella
    (dolist (r tab)
      (println line)
      (dolist (c r)
        (print ver { } c (dup " " (- (col-len-max $idx) (length c))) { })
      )
      (println ver)
    )
    (println line)
  'nil))

(setq lst '((1 2 3 4 5) ("a" "b" "c" "d" "e") (-1 -2 -3 -4 -5) (aa bb cc dd ee) (-11 -12 -13 -14 -15)))
(print-table lst)
;-> +-----+-----+-----+-----+-----+
;-> | 1   | 2   | 3   | 4   | 5   |
;-> +-----+-----+-----+-----+-----+
;-> | a   | b   | c   | d   | e   |
;-> +-----+-----+-----+-----+-----+
;-> | -1  | -2  | -3  | -4  | -5  |
;-> +-----+-----+-----+-----+-----+
;-> | aa  | bb  | cc  | dd  | ee  |
;-> +-----+-----+-----+-----+-----+
;-> | -11 | -12 | -13 | -14 | -15 |
;-> +-----+-----+-----+-----+-----+

(setq lst '((1 2 "pippo") ("paperino" "pluto" -98784749) (-1000 -100000 "tre")))
(print-table lst)
;-> +----------+---------+-----------+
;-> | 1        | 2       | pippo     |
;-> +----------+---------+-----------+
;-> | paperino | pluto   | -98784749 |
;-> +----------+---------+-----------+
;-> | -1000    | -100000 | tre       |
;-> +----------+---------+-----------+

(setq lst '((1) (-2) (pippo)))
(print-table lst)
;-> +-------+
;-> | 1     |
;-> +-------+
;-> | -2    |
;-> +-------+
;-> | pippo |
;-> +-------+

=============================================================================

