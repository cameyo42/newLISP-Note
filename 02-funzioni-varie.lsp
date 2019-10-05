================

 FUNZIONI VARIE
 
================

In questo capitolo definiremo alcune funzioni che operano sulle liste e altre funzioni di carattere generale. Alcune di queste ci serviranno successivamente per risolvere i problemi che andremo ad affrontare.
Poichè newLISP permette sia lo stile funzionale che quello imperativo, le funzioni sono implementate in modo personale e possono essere sicuramente migliorate.

-------------
Tabella ASCII
-------------

ASCII (acronimo di American Standard Code for Information Interchange, Codice Standard Americano per lo Scambio di Informazioni) è un codice per la codifica di caratteri. Lo standard ASCII è stato pubblicato dall'American National Standards Institute (ANSI) nel 1968. Il codice era composto originariamente da 7 bit (2^7 = 128 caratteri).
I caratteri del codice ASCII sono di due tipi: stampabili e non stampabili (caratteri di controllo).
I caratteri stampabili sono 95 (da 32 a 126), mentre quelli non stampabili sono 33 (da 0 a 31 e il 127). Quindi il totale dei caratteri vale 95 + 33 = 128.
Scriviamo una funzione che crea una lista dei caratteri ASCII stmapabili.

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

(define (crono n)
  (if (<= n 0)
      '()
      (cons n (crono (- n 1)))
  )
)

; Nota: '() rappresenta la lista vuota

(crono 10)
;-> (10 9 8 7 6 5 4 3 2 1)


------------------------------
Cambiare di segno ad un numero
------------------------------

Primo metodo (sottrazione)
(setq n -1.24)
;-> -1.24
(setq n (sub 0 n))
;-> 1.24
(setq n (sub 0 n))
;-> -1.24

Secondo metodo (moltiplicazione)
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
;-> (map (lambda (x) (mul -1 x)) (sequence 1 10))

Test primo metodo:
(time (map (lambda (x) (sub 0 x))  (sequence 1 1000000)) 10)
;-> 906.196

Test secondo metodo:
(time (map (lambda (x) (mul -1 x)) (sequence 1 1000000)) 10)
;-> 906.343

I due metodi hanno la stessa velocità.

Terzo metodo (bitwise not "~") (valido solo per numeri interi)
(setq n -10)
;-> -10
(setq n (add (~ n) 1))
;-> 10
(setq n (add (~ n) 1))
;-> -10

Test terzo metodo:
(time (map (lambda (x) (add (~ n) 1)) (sequence 1 1000000)) 10)
;-> 1207.781

Questo metodo è più lento.

Quarto metodo (segno meno "-")
(setq n -10)
;-> 10
(setq n (- n))
;-> 10
(setq n (- n))
;-> -10

Test quarto metodo:
(time (map (lambda (x) (- n)) (sequence 1 1000000)) 10)
;-> 914.067

Stessa velocità dei primi due metodi, ma quest'ultimo è più leggibile.


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


------------------------------------
Conversione numero intero <--> lista
------------------------------------

Da numero intero a lista:

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

Da lista a numero intero:

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

Vediamo quale delle due è più veloce:

(time (list2int '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 622.365

(time (list2int2 '(9 2 2 3 3 7 2 0 3 6 8 5 4 7 7 5 8 0 7)) 100000)
;-> 855.138

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

(time (dotimes (x 1e7) (int2list x)))
;-> 1107.929
(time (dotimes (x 1e7) (int2list x)))
;-> 12721.02

(time (dotimes (x 1e6) (int2list2 x)))
;-> 1544.137
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
  (cond ((= a 0) (div (mul b c) d))
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

Con newLISP possiamo utilizzare la funzione "explode".

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
;-> ((0 a) (1 b) (2 c))


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

Il trucco sta nell'utilizzare la funzione "max" per scoprire quale ramo della ricorsione è il più profondo, notando che ogni volta che ricorraimo su first aggiungiamo un altro livello.

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

Definiamo la funzionde quadrato:

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


-------------------------
Funzioni per input utente
-------------------------

*********************
>>>funzione READ-KEY
*********************
sintassi: (read-key)

Legge un tasto dalla tastiera e restituisce un valore intero. Per i tasti di navigazione, è necessario effettuare più di una chiamata read-key. Per i tasti che rappresentano i caratteri ASCII, il valore di ritorno è lo stesso su tutti i Sistemi Operativi, ad eccezione dei tasti di navigazione e di altre sequenze di controllo come i tasti funzione, nel qual caso i valori di ritorno possono variare in base ai diversi SO e alle configurazioni.

(read-key)  → 97  ; after hitting the A key
(read-key)  → 65  ; after hitting the shifted A key
(read-key)  → 10  ; after hitting [enter] on Linux
(read-key)  → 13  ; after hitting [enter] on Windows

(while (!= (set 'c (read-key)) 1) (println c))

L'ultimo esempio può essere utilizzato per verificare le sequenze di ritorno dalla navigazione e dai tasti funzione. Per interrompere il ciclo, premere Ctrl-A.

Nota che read-key funziona solo quando newLISP è in esecuzione in una shell Unix o nella shell dei comandi di Windows. Non funziona nelle gui Java newLISP-GS e Tcl/Tk newLISP-Tk. Non funziona neanche nelle shared library newwLISP di UNIX o nella DLL newLISP di Windows (Dynamic Link Library).

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


-----------------------------------------------------
Trasformare una lista di stringhe in lista di simboli
-----------------------------------------------------

(setq str "Questa è la stringa da convertire")
;-> "Questa è la stringa da convertire"

(setq lst (parse str))
;-> ("Questa" "è" "la" "stringa" "da" "convertire")

(map sym lst)
;-> (Questa è la stringa da convertire)


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


-------------------------------------------------
Il programma è in esecuzione ? (progress display)
-------------------------------------------------

Qualche volta abbiamo bisogno di sapere se un programma è in esecuzione (e a che punto si trova) oppure si è bloccato in qualche parte del nostro codice. Ci sono due metodi per questo:
il primo metodo stampa ciclicamente una serie di simboli sulla console per dimostrare che il programma sta girando:

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

Da notare che entrambi i metodi rallentano leggermente l'esecuzione del programma.


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

Vedere il file newLISP.h nel programma sorgente per conoscere i bit superiori e il loro significato (e anche altre cose).

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
        il bit 11 è impostato per le versioni ffilib (Extended Import / Callback API) (aggiungere 1024)
        il bit 10 è impostato per le versioni IPv6 (aggiungere 512)
        il bit  9 è impostato per le versioni a 64 bit (modificabili a runtime) (aggiungere 256)
        il bit  8 è impostato per le versioni UTF-8 (aggiungere 128)
        il bit  7 è aggiunto per le versioni di libreria (aggiungere 64)

I numeri da 0 a 9 indicano il valore l'indice int-idx (opzionale) nella lista restituita.

Si consiglia di utilizzare gli indici da 0 a 5 (includendo) "Numero massimo di chiamate allo stack costante") e utilizzare gli offset negativi da -1 a -4 per accedere alle ultime quattro voci nella lista delle informazioni di sistema. Le future nuove voci verranno inserite dopo l'indice 5. In questo modo i programmi scritti precedentemente non dovranno essere modificati.

Quando si usa int-idx, verrà restituito un solo elemento della lista.

(sys-info) → (429 268435456 402 1 0 2048 0 19453 10406 ​​1155)
(sys-info 3) → 1
(sys-info -2) → 10406 ​​;; versione 10.4.6

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
    ; library -> bit 8
    (print "UTF-8: ")
    (if (zero? (& (>> num 7) 1)) (println "no") (println "yes"))
    ; library -> bit 6
    (print "library: ")
    (if (zero? (& (>> num 6) 1)) (println "no") (println "yes"))
    info
  )
)

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


